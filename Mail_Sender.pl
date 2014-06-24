#!/usr/bin/perl
use strict;
use warnings;

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

# or using the eval{ $obj->Method()->Method()->...->Close()} trick ...
        use Mail::Sender;
        eval {
        (new Mail::Sender)
                ->OpenMultipart({
                            smtp => 'smtp.winchannel.net',
                            from => 'sunxiaowei@winchannel.net',
                             auth=> 'LOGIN',
                          authid => 'sunxiaowei@winchannel.net',
                         authpwd => 'win123456',
                              to => 'sxw2k@sina.com',
                         subject => "$today�����ս�",
                        boundary => 'boundary-test-1',
                            type => 'multipart/related'
                })
                ->Attach({
                        description => 'fujian',
                              ctype => 'application/x-zip-encoded',
                           encoding => 'Base64',
                        disposition => 'NONE',
                               file => "E:/GSK-RXԶ�̵ǼǱ�.xlsx,E:/�ϴ��������$today.xlsx,E:/������־.xlsx"
                })
           
                ->Close()
        }
        or die "Cannot send mail: $Mail::Sender::Error\n";