use Win32::Console;
use Encode;
use 5.010;
use AnyEvent;

 
use Win32::Console::ANSI;
use Term::ANSIColor;
my @color    = qw( red  green  yellow  blue  magenta  cyan  white 
                   bright_black  bright_red  bright_green  bright_yellow 
				   bright_blue   bright_magenta  bright_cyan   bright_white ansi0);


#my @color= map {'ansi'.$_} (0..15);
$|=1; #���뿪�����
system("mode con cols=135 lines=25");
my $Out = new Win32::Console(STD_OUTPUT_HANDLE) || die;
my $cv = AnyEvent->condvar;
my $count=0;
my $w; $w = AnyEvent->timer(
        after       => 2, 
        interval => 2,
        cb => sub {
            $count++;
			
my ( $x, $y ) = $Out->Cursor();
$Out->Cursor( $x+125, $y + 5,0,0);

           while (<DATA>) {
  s/ /��/g;
  chomp;
  $a=decode('gb2312',$_);
  @words=$a=~m/(.)/g;
  

  foreach $word (@words) {  
         $c = $color[int rand @color];
		 print color 'bold '.$c;
         $Out->Write(encode('gb2312',$word));
         my ( $x, $y ) = $Out->Cursor();
         $Out->Cursor( $x, $y + 1,0,1);

         my ( $x, $y ) = $Out->Cursor();
         $Out->Cursor( $x-2, $y,0,1);
         select(undef,undef,undef,0.045);
         }

my ( $x, $y ) = $Out->Cursor();
$Out->Cursor( $x-2, $y-@words,0,0);
}
			system("cls");
			# say $count;
			seek(DATA,1565,0); # �����������˾�û���ı��ˣ�������Ҫ���أ���ʵDATA���������ļ��������script�������ı���
	
            if ($count >= 10) {
                undef $w; 
            }   
        }   
        );  
$cv->recv;
__END__




��������������
�ҵ�һ�������õĳ���
��
����������
��
���˺�ãã�о�����������
��
İ������Ϥ
��
���ܺ�����ͬһ��յ���Ϣ

ȴ�޷�ӵ������
��
���ת����ʱ����ݺ�����
������
��Ը�ϵ����۾�
��
ǧ��֮������������
��
����������羰
��
���ǵĹ��²���������
��
ȴ�����������
�� 
���ܺ�����ͬһ��յ���Ϣ
��
ȴ�޷�ӵ������
�� 
���ת����ʱ����ݺ�����
��
��Ը�ϵ����۾�
��
ǧ��֮������������
��
����������羰
��
���ǵĹ��²���������
��
ȴ�����������
��
��������¸ҵ���һ��
�� 
�᲻�᲻ͬ���
��
��᲻��Ҳ��ǧ������
��
���ڳ�Ĭ�����