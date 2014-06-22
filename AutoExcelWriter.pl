use 5.010;
use strict;  
# use warnings;  
use Spreadsheet::XLSX;  
use Excel::Writer::XLSX;
use MyExcelFormatter;
use Encode;
use HTML::TokeParser;
use Data::Dumper;
use Mojo::UserAgent;
use Mojo::UserAgent::CookieJar;
use Mojo::UserAgent::Proxy;
use YAML 'Dump';
use Win32::API;

#��ȡ��������ڣ���Ϊ���� Excel ������
sub getTime
{
    my $time = shift || time();
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($time);

    $year += 1900;
    $mon ++;

    $min  = '0'.$min  if length($min)  < 2;
    $sec  = '0'.$sec  if length($sec)  < 2;
    $mon  = '0'.$mon  if length($mon)  < 2;
    $mday = '0'.$mday if length($mday) < 2;
    $hour = '0'.$hour if length($hour) < 2;
    
    my $weekday = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat')[$wday];

    return { 'second' => $sec,
             'minute' => $min,
             'hour'   => $hour,
             'day'    => $mday,
             'month'  => $mon,
             'year'   => $year,
             'weekNo' => $wday,
             'wday'   => $weekday,
             'yday'   => $yday,
             'date'   => "$year-$mon-$mday"
          };
}

my $date = getTime();  
my $today = $date->{date};                          # ��ȡxxxx-xx-xx����������
#my $month = $date->{month};                        # ��ȡ��
#my $day = $date->{day};                            # ��ȡ��
#my $year = $date->{year};                          # ��ȡ��
#my $weekday = $date->{wday};                       # ��ȡ����
my $yesterday = getTime(time() - 86400)->{date};   # ��ȡ��������ڣ�Ҳ������ 86400*N����ȡN��ǰ������

sub H{
my $text = shift;
return  decode('utf8',$text);  # ����ת��
}
##################################################
#                 ɾ�����ļ�                     #
##################################################

foreach my $file (grep {/�ͻ���������־/ or /��ά����ƽ̨/} glob "*.xls") { 
say "ɾ���ļ���$file";
unlink  "$file";
}

my $client_log_file = "�ͻ���������־".$today.".htm.xls";
my $yesterday_file  = 'Finished�ϴ��������'.$yesterday.'.xlsx';
my $yunwei_file     = "��ά����ƽ̨".$today.".htm.xls";

##################################################
#                 ������־�ļ�                    #
##################################################

my $proxy = Mojo::UserAgent::Proxy->new;
$proxy->detect;
say $proxy->http;


# ��Ҫ���� AdvOcr

# ����汾�ǿ��Եģ���Ϊ��ʱ��Ҫ������֤�룬������ʱ����
my $ua   = Mojo::UserAgent->new;
my $http = $proxy->http;
my $ua_proxy      = $proxy->http('http://192.168.1.158:8080');
my $response = $ua->get('https://gskrx.windms.com/commons/image.jsp');

 if ($response->success) {
     # ץȡ��֤��ͼƬ #
$response->res->content->asset->move_to('verifycode.BMP'); # ���ܺ����ģ�


 # # ������֤�벢��¼ #
# print "--> enter verifycode:";

# chomp( my $verifycode = <> );
# $verifycode=~ s/\s//g; #ɾ���հ�

my $dll={};
my $D='AdvOcr.dll';
$dll->{OcrInit} = Win32::API->new($D, 'OcrInit',[],'N') || die " Can't open the dll file $D $!";

$dll->{OCR_C} = Win32::API->new($D, 'OCR_C',['P','P'],'P');
if($dll->{OcrInit}->Call()){
my $ocr_txt=$dll->{OCR_C}->Call('163_esales','verifycode.BMP');
    print "���:$ocr_txt\n";
# }

# 163_esales ����ʹ���ĸ���ģ��
# �������˺ܶ��ֳɵ���ģ��ֻҪ��������������Ϳ���ʶ���������͵���֤��
# �����������OCRtypedef.ini�ļ���������28����ģ

my $login_url  = "https://gskrx.windms.com/login.do";
my $post_form = {
       'rand' => "$ocr_txt",
       'anchor'       =>"",
       'userAccount'  =>'winc_sxw',
       'userPassword' =>'000000',

    };

  
    my $tx = $ua->post( $login_url => form => $post_form );
if ( $tx->success ) {
    if ($tx->res->body !~ /��֤���������/) {
	
my $query_form= {
'colIds' => '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,48,43,44,45,46,47',
'reportName' => '../listview/platform/server/dmsRunLogListView',
'tableId'=> 'dmsRunLogListView',
'uploadResult'=>'2',
'loadResult'=>'2',
'uploadDate1'=>"$today",
'uploadDate2'=>"$today",
'dmsRunLogListView_rd'=>'200',
'_RES_ID_'=>'156',
'ec_i'=>'dmsRunLogListView',
'ec_eti'=>'dmsRunLogListView',
'dmsRunLogListView_ev'=>'htm',
'dmsRunLogListView_efn'=>'�ͻ���������־.htm.xls',
'dmsRunLogListView_crd'=>'200',
'dmsRunLogListView_p'=>'1',
};

my $yunwei_query_form = {
'_RES_ID_'=>'236',
'colIds'=>'0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,36,37',
'delayDay'=>'2',
'ec_eti'=>'helpDesk',
'ec_i'=>'helpDesk',
'FILE_EXPORT_TOKEN_PARAM_NAME'=>'1393911174875',
'helpDesk_crd'=>'200',
'helpDesk_efn'=>'��ά����ƽ̨.htm.xls',
'helpDesk_ev'=>'htm',
'helpDesk_p'=>'1',
'helpDesk_rd'=>'200',
'reportName'=>'helpDesk',
'saleDelayDay'=>'0',
};

# 'FILE_EXPORT_TOKEN_PARAM_NAME'=>'1392799287157'
# URL Ҫ�����������POST
my $client_file='�ͻ���������־'.$today.'.htm.xls';

my  $tx=$ua->post('https://gskrx.windms.com/report/listReport.do' => form => $query_form );
$tx->res->content->asset->move_to($client_file); # ���ܺ����ģ�

my $yunwei_tx =$ua->post('https://gskrx.windms.com/report/listReport.do' => form => $yunwei_query_form);
$yunwei_tx->res->content->asset->move_to($yunwei_file); #

}
}
}
}
##################################################
#                ����Ƿ����ص�                  #
##################################################


my @files_needed =($client_log_file,$yesterday_file,$yunwei_file);
foreach my $file (@files_needed){
   print "[������] -> $file \n" if not -e $file;
}

exit   if not -e "��ά����ƽ̨".$today.".htm.xls";
exit   if not -e "�ͻ���������־".$today.".htm.xls";
exit   if not -e 'Finished�ϴ��������'.$yesterday.'.xlsx';

my $parser = HTML::TokeParser->new($yunwei_file)
    or die "Can't open $yunwei_file: $!\n";
	
	
my (@table, @row, $inrow);
while (my $token = $parser->get_token( )) {
    my $type = $token->[0];
    if ( $type eq 'T' ) {
        push @row, $token->[1] if $inrow;
    }
    elsif ( $type eq 'S' ) {
        if ( $token->[1] eq 'tr' ) {
            $inrow = 1;
        }
    }
    elsif ( $type eq 'E' ) {
        if ( $token->[1] eq 'tr' ) {
            push @table, [@row]; # ע����һ�в����� @row
            @row = ();
            $inrow = 0;
        }
    }
}
my @temp;
my %client_code;
foreach my $ele (@table) {
   my $string=join "", $ele->[10],$ele->[12],$ele->[14],"\n";
   $string=~s/\s+$//g;
   # print $ele->[3];
   push @temp, $string if $string;
   $client_code{$ele->[3]} =  $string;
}
delete $client_code{'�ͻ��˱���'};
# print Dumper(%client_code);



################################################################################################
# ��������ȡ�ͻ���������־��ľ����̱��룬��Ϊ Excel�� Vlookup������ table_array
################################################################################################

################################################################################################
# ������Ҫ׼�����ļ���3����������ϴ��������������Ŀͻ���������־
################################################################################################


open my $fh,"<",$client_log_file or die $!;  #�ͻ���������־2014-01-05.htm.xls
my @array;
my %has_seen;
while(<$fh>) {
     $has_seen{$1}=1 if /<td class="tsc" >(\d{7,})<\/td>/;
}

foreach my $key (keys %has_seen) {
        push @array,$key;
}
close $fh;

my $workbook   =  Excel::Writer::XLSX->new( "�ϴ��������".$today.".xlsx" );
my $format     = $workbook->add_format( 
           align      => 'center',
		   font       => H('΢���ź�'),
		   size       => 9 ,
		   num_format => '@' 
		   );
		   
my $time_format     = $workbook->add_format( align => 'center', num_format => 'h:mm',        font => H('΢���ź�'), size => 9);
my $date_format     = $workbook->add_format( align => 'center', num_format => 'yyyy/mm/dd',  font => H('΢���ź�'), size => 9);
my $filter_format_Y = $workbook->add_format( align => 'center', bg_color   => '#16a951');
my $filter_format_N = $workbook->add_format( align => 'center', bg_color   => 'red', );

# set_column( $first_col, $last_col, $width, $format, $hidden, $level, $collapsed )
   
# ��ȡһ��Excel �����ݵ�����һ���½��Ĺ������У���ʵ���Ǹ���ԭ���� Excel �ļ�	   
my $excel          =  Spreadsheet::XLSX -> new ('Finished�ϴ��������'.$yesterday.'.xlsx');

foreach my $old_sheet( @{$excel -> {Worksheet}}[0] ) {  # ֻ��ȡǰ���Ź�����ֱ����װ
        my @columns; 
        my $new_worksheet  =  $workbook->add_worksheet(H($old_sheet->{Name}));  # ��ԭ���Ĺ���������ӵ��µ� Excel
	    $old_sheet -> {MaxCol} ||= $old_sheet -> {MinCol};  #|| �߼��򣬷��ؼ�������Ϊ���ֵ�������Ҽ���
        my $temp=$old_sheet -> {MaxCol}+65;  # �������������10���������������һ�У��������11,����1,������ת��Ϊ��Ӧ����ĸ
        my $cell_today=chr($temp+1);

	   # д���� Excel �ļ�ǰ���������� Excel �ĵ�Ԫ���ʽ 
       $new_worksheet->set_column( 'A:A', 8.38,$format );
       $new_worksheet->set_column( 'B:B', 10.38,$format);
       $new_worksheet->set_column( 'C:D', 25 ,$format);
       $new_worksheet->set_column( 'F:F', 15, $time_format );
	   $new_worksheet->set_column( 'G:G', 25 ,$date_format);
       $new_worksheet->set_column( 'E:E', 15, $format ); 
       $new_worksheet->set_column( "J:$cell_today", 15, $date_format ); 
       
# ��ȡԭ Excel��Ȼ��д�� �� Excel        
foreach my $col ($old_sheet -> {MinCol} .. $old_sheet -> {MaxCol}) {
			    $old_sheet -> {MaxRow} ||= $old_sheet -> {MinRow}; 
                foreach my $row ($old_sheet -> {MinRow} ..  $old_sheet -> {MaxRow}) {  
					    push @{$columns[$col]},H($old_sheet -> {Cells} [$row] [$col]->{Val});
                        }
				 $new_worksheet->write_row( 'A1', \@columns);
				}


$new_worksheet->write( $cell_today."1",$today,$date_format); # header��Ϊÿ�������

shift  @{$columns[1]}; 
chomp @{$columns[1]};
my @custom=map {s/\s+//g;$_} @{$columns[1]};
shift @{$columns[4]};
my @source_client =map {s/\s+//g;$_} @{$columns[4]};
{no warnings;
foreach my $i ($old_sheet -> {MinRow}+2..$old_sheet -> {MaxRow}+1) {
        $new_worksheet->write( 'F'.$i, $source_client[$i-2] ~~ %client_code ? decode("gb2312",$client_code{$source_client[$i-2]}):"N");
	}

foreach my $i ($old_sheet -> {MinRow}+2..$old_sheet -> {MaxRow}+1) {
        $new_worksheet->write( $cell_today.$i, $custom[$i-2] ~~ @array ? "Y":"N");
	}

my $alpha=$cell_today;
my $b=$alpha.($old_sheet -> {MaxRow}+1);	
$new_worksheet->autofilter( "A1:$b" ); # ��ѡ�����ݽ���ɸѡ
$new_worksheet->filter_column( 8, 'x == NonBlanks');
# $new_worksheet->filter_column( 5, 'x =~ *Сʱ');
    		
my $row = 1;
shift @{$columns[8]};
    
for my $region ( @{$columns[8]} ) {
        if ( not defined $region) {
    
            # Hide row.
            $new_worksheet->set_row( $row, undef, undef, 1 ); # ���ز�ƥ����˱�׼����
        } 
    
        $new_worksheet->write( $row++, 8, $region );
		$new_worksheet->write( $cell_today.$row,$region ~~ @array ? "Y":"N") if defined $region;# ����if defined һ��Ҫ���ϣ����ǹؼ�
 }
}  
		 		
    #������ʽ 
    		  $new_worksheet->conditional_formatting( "J:$cell_today",
                {
                    type     => 'text',
                    criteria => 'begins with',
                    value    => 'Y',
                    format   => $filter_format_Y,
                }
            );
    		
    		  $new_worksheet->conditional_formatting( "J:$cell_today",
                {
                    type     => 'text',
                    criteria => 'begins with',
                    value    => 'N',
                    format   => $filter_format_N,
                }
            );
}
print  "---------> [ OK ]";
__END__