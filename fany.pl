#! /usr/bin/perl
# ѧϰperl LWPʱ��post���ķ���С�ű�
# ���õ����е��ʵ�
# ���ߣ���2012λ����
# ԭ������ http://www.cnblogs.com/caibird/archive/2013/03/22/2974999.html
# 2014-01-10 ���ӱ����ж�+��CP936�淶������ʺ���windows��������ʾ - paktc

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Encode;
use Term::ANSIColor;
use Win32::Console::ANSI;
use 5.010;
my $mode=recogn();
binmode(STDOUT,':encoding(CP936)');

my $browser = LWP::UserAgent->new();
while(1){
print "> Please input the word:";
chomp (my $input = <STDIN>);
my $response = $browser->post(
#    'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=https://www.google.com.hk/',
    'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=null',
    [
        'type'    => 'AUTO',
        'i'       => "$input",
        'doctype' => 'json',
    ],
    );

if($response->is_success){
    my $result =eval{ $response->content };
    my $json = new JSON;
	my $obj;
    eval{
	$obj = $json->decode($result);
	};
    #print Dumper $obj;
    my $trans =eval{ @{$obj->{'translateResult'}[0]}[0]->{"tgt"} };
    my $string;
    eval{
        $string  = join " ", @{$obj->{'smartResult'}->{"entries"}};
    };

    my $say1=decode($mode," -> ��������");
    my $say2=decode($mode," -> �������: ");
    $trans=decode('UTF-8',$trans) if $trans;
    $string=decode('UTF-8',$string) if $string;
    print color 'bold green';
    print $say1 if defined $trans;
    print color 'bold yellow';
	say $trans if defined $trans;
	print color 'bold red';
	print $say2 if defined $string;
	print color 'bold cyan';
	say $string if defined $string;
	print color 'bold white';
}
}
# �жϵ�ǰ�ű������ʽ  ����WIN32����ϵͳ���Թ�
sub recogn {
    my $cn="��";
    my $code;
    my @arr=split("",$cn);
    if ($#arr == 0) {            # 'Unicode' 4e2d
        $code='Unicode';
    } elsif ($#arr == 1) {       # 'GBK'   d6 d0 
        $code='GBK';
    } elsif ($#arr == 2) {       # 'UTF-8' e4 b8 ad
        $code='UTF-8';
    } else {
        $code='WHAT?';
    }
}