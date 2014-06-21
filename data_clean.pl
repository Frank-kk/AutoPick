use Mojo::DOM;
use 5.010;
use Data::Dumper;
use Encode;
use Excel::Writer::XLSX;


my $workbook  = Excel::Writer::XLSX->new("data_clean.xlsx");
my $worksheet = $workbook->add_worksheet('data_clean');
my $content = do {local $/;<DATA>};
$content =~ s/&nbsp;//g;
my $dom = Mojo::DOM->new($content);
my $headers = $dom->find('table[id="tabGoodsInfo"]');
my @columns;
my @headers; 

# �ռ���Ʒ��Ϣ��������
for my $e ($headers->find('table[id="tabGoodsInfo"]> tr > td > font > input[class="inputnormal"]')->each) {
  # say $e; 
  # 21000101 ͨ������ 10Ƭ ͸���ͣ���׼�� ��е 14.4900 19.5000
  # �� �к� �� ��� �������ʷ����ҩ���޹�˾  2014-05-11��2014-06-19 ����ʷ��
	my $collect= Mojo::DOM->new($e);
	$collect->find('input[value]')->each(sub { push @headers,shift->{value}});
}

# ��Ʒ��ÿ����¼
my $collection = $dom->find('table[id="dgGoods"]>tr');
 foreach my $ele (@$collection) { 
     my $tds = $ele->find('td')->text;
	 next if $tds =~ /�ŵ����/;
	 next if $tds =~ /�ϼ�/;
	 push @columns,[@$tds,@headers];
}

foreach my $line (@columns){
          
    foreach (@$line) {
	    chomp;
        $_=decode("gb2312",$_) if defined $_;
    }
}

my @first_line = (
                     ['�ŵ����',	'�ŵ�����',	'��������',	'����',	'����',	'��Ӧ��',
					 '����',       'Ʒ��',        '���',        '����',    '������',  '���ۼ�',
					 '���װ',     '�а�װ',      '�ڰ�װ',      '����',    '����',    '��ѯʱ��', 'ҵ��λ']
					 );
					 
foreach my $line (@first_line){
          
    foreach (@$line) {
	    chomp;
        $_=decode("gb2312",$_) if defined $_;
    }
}

$worksheet->write_col('A1',\@first_line);	# д�����	 
$worksheet->write_col('A2',\@columns);


__DATA__
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>

	<HEAD>

		<title>SaleRecords</title>

		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">

		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">

		<meta name="vs_defaultClientScript" content="JavaScript">

		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">

		<LINK href="../BC.css" type="text/css" rel="stylesheet">

		<link rel="stylesheet" href="../menu.css">

	</HEAD>

	<body bottomMargin="0" leftMargin="0" topMargin="0">

		<form name="Form1" method="post" action="SaleRecords.aspx" id="Form1">

<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"  />



<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"  />

			<TABLE class="table" id="Table0" style="LEFT: 4px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%"

				cellSpacing="0" cellPadding="0" align="center" border="0">

				<TR>

					<TD>

<link href="BC.css" type="text/css" rel="stylesheet">

<link rel="stylesheet" href="menu.css">



<script language="JavaScript">

<!-- Hide

var timerID = null

var timerRunning = false

function MakeArray(size) {

    this.length = size;

    for(var i = 1; i <= size; i++)

      {

        this[i] = "";

      }

  return this;

}

function stopclock (){

    if(timerRunning)

    clearTimeout(timerID);

    timerRunning = false

}

function showtime (){

  var now = new Date();

  var year = now.getYear();

  var month = now.getMonth() + 1;

  var date = now.getDate();

  var hours = now.getHours();

  var minutes = now.getMinutes();

  var seconds = now.getSeconds();

  var day = now.getDay();

  Day = new MakeArray(7);

  Day[0]="������";

  Day[1]="����һ";

  Day[2]="���ڶ�";

  Day[3]="������";

  Day[4]="������";

  Day[5]="������";

  Day[6]="������";

  var timeValue = "";

  timeValue += year + "��";

  timeValue += ((month < 10) ? "0" : "") + month + "��";

  timeValue += date + "��  ";

  timeValue += (Day[day]) + "  ";

  timeValue += ((hours <= 12) ? hours : hours - 12);

  timeValue += ((minutes < 10) ? ":0" : ":") + minutes;

  timeValue += ((seconds < 10) ? ":0" : ":") + seconds;

  timeValue += (hours < 12) ? "����" : "  ����";

  document.all.clock.innerText = timeValue;

  timerID = setTimeout("showtime()",1000);

  timerRunning = true

}

function startclock () {

  stopclock();

  showtime()

}

//-->

</script>

<table border="0" cellpadding="0" cellspacing="0" style="Z-INDEX: 101; LEFT: 0px; TOP: 0px; BORDER-COLLAPSE: collapse"

	bordercolor="#111111" width="100%" bgcolor="#336699">

	<tr>

		<td>

			<table border="0" cellpadding="0" cellspacing="0" style="Z-INDEX: 101; LEFT: 16px; BORDER-COLLAPSE: collapse"

				bordercolor="#111111" width="100%" bgcolor="#336699">

				<tr>

					<td width="500" colSpan="1" rowSpan="1" height="58">

						<TABLE id="Table1" cellSpacing="0" cellPadding="0" border="0" width="100%" style="HEIGHT: 58px">

							<TR>

								<TD background="/BC/image/yht.jpg" style="WIDTH: 70px; HEIGHT: 15px"><FONT face="����"></FONT></TD>

								<td style="FONT-WEIGHT: bolder; FONT-SIZE: x-large; WIDTH: 500px; COLOR: white; FONT-FAMILY: ����; HEIGHT: 15px"><FONT face="����">ҵ��λ��Ϣ��ѯϵͳ</FONT></td>

							</TR>

						</TABLE>

					</td>

					<td>

						<!--

						<table cellSpacing="0" cellPadding="0" border="0" width="100%" style="HEIGHT: 58px">

							<tr>

								<td valign="bottom" width="33%" height="58">

									<p align="center"><a class="toolbar" href="/BC/Page/BrowseCompany.aspx">��λ��Ϣ</a></p>

								</td>

								<td valign="bottom" width="2" height="58">

									<p align="center">

										<img height="14" width="2" border="0" src="/BC/Image/separator.gif"></p>

								</td>

								<td valign="bottom" width="33%" height="58">

									<p align="center"><a class="toolbar" href="/BC/Page/SaleRecords.aspx">���۲�ѯ</a></p>

								</td>

								<td valign="bottom" width="2" height="58">

									<p align="center">

										<img height="14" width="2" border="0" src="/BC/Image/separator.gif"></p>

								</td>

								<td valign="bottom" width="34%" height="58">

									<p align="center"><a class="toolbar" href="/BC/Help/Instruction_BC.mht"  target=_blank>ʹ��ָ��</a></p>

								</td>

							</tr>

						</table>

						-->

					</td>

				</tr>

			</table>

		</td>

	</tr>

	<tr>

		<td>

			<table border="0" cellpadding="0" cellspacing="0" style="WIDTH: 100%; COLOR: white; BORDER-COLLAPSE: collapse; HEIGHT: 32px"

				bordercolor="#111111" height="32" bgcolor="#6699cc">

				<tr>

					<td align="left" valign="bottom" width="34%">��ӭ����<a id="Title1_UserInfo" class="toolbar">����ʷ��</a>

					</td>

					<td align="center" valign="bottom" width="11%"><a class="toolbar" href="/BCC/page/Login.aspx">���µ�¼</a></td>

					<td align="center" valign="bottom" width="11%"><a class="toolbar" href="/BCC/page/ChangePWD.aspx">�޸�����</a>

					</td>

					<td width="14%">&nbsp;</td>

					<td id="clock" align="right" valign="bottom" width="30%"></td>

				</tr>

			</table>

		</td>

	</tr>

</table>

<script language="javascript">

	startclock();

</script>

<!-- menu script itself. you should not modify this file -->

<script type="text/javascript" language="javascript" src="/BCC/JS/menucode.js"></script>

<script type="text/javascript" language="JavaScript" src="/BCC/JS/menu.js"></script>

<!-- items structure. menu hierarchy and links are stored there -->

<script language="JavaScript" src="/BCC/JS/menu_items.js"></script>

<!-- files with geometry and styles structures -->

<script language="JavaScript" src="/BCC/JS/menu_tpl.js"></script>

<script language="JavaScript">

	<!--//

	// Note where menu initialization block is located in HTML document.

	// Don't try to position menu locating menu initialization block in

	// some table cell or other HTML element. Always put it before </body>



	// each menu gets two parameters (see demo files)

	// 1. items structure

	// 2. geometry structure



	new menu (MENU_ITEMS, MENU_POS);

	// make sure files containing definitions for these variables are linked to the document

	// if you got some javascript error like "MENU_POS is not defined", then you've made syntax

	// error in menu_tpl.js file or that file isn't linked properly.

	

	// also take a look at stylesheets loaded in header in order to set styles

	//-->

</script></TD>

				</TR>

				<TR>

					<TD vAlign="top" align="center" height="100%">

						<TABLE class="table" id="Table1" cellSpacing="0" cellPadding="0" width="100%" align="center"

							border="0">

							<TR>

								<TD colSpan="2" height="5"></TD>

							</TR>

							<TR>

								<TD class="titlecell" style="HEIGHT: 25px" align="left"><B>��ѯ����</B></TD>

								<TD class="titlecell" style="HEIGHT: 25px" align="right"><input type="submit" name="btFind" value="��ѯ" onclick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;btFind&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, false))" id="btFind" class="button" /></TD>

							</TR>

							<TR>

								<td class="errorcellfore" colSpan="12"><span id="lblError"></span>

									

									

									</td>

							</TR>

							<TR>

								<td colSpan="2" style="HEIGHT: 1px">

									<TABLE class="table" id="Table3" cellSpacing="0" cellPadding="0" width="100%" align="center"

										border="1">

										<tr>

											<TD style="HEIGHT: 23px" align="center" width="70">��ʼʱ��</TD>

											<TD style="HEIGHT: 23px" width="80"><input name="txtBeginDate" type="text" value="2014-05-11" id="txtBeginDate" title="��ʽ����2005��1��1�գ������룺05-1-1��05.1.1" class="inputnormal" /></TD>

											<TD style="HEIGHT: 23px" align="center" width="70">����ʱ��</TD>

											<TD style="HEIGHT: 23px" width="80"><input name="txtEndDate" type="text" value="2014-06-19" id="txtEndDate" class="inputnormal" /></TD>

											<TD style="HEIGHT: 23px" align="center" width="70">ҵ��λ</TD>

											<TD style="HEIGHT: 23px" width="320"><FONT face="����"><select name="ddlCompany" id="ddlCompany" class="inputnormal">

	<option selected="selected" value="002-02-001">[002-02-001]����ʷ��</option>



</select></FONT></TD>

											<TD style="WIDTH: 50px; HEIGHT: 23px" align="center">Ʒ��</TD>

											<TD style="WIDTH: 320px; HEIGHT: 23px"><FONT face="����"><select name="ddlGoods" id="ddlGoods" class="inputnormal">

	<option value="">--ѡ��--</option>

	<option value="12300003">[12300003](F)������濨�ɱ������(������)50ug/��&#215;120��/ƿ,����ɫ����ƿ</option>

	<option value="14440140">[14440140]������������Ƭ(����ͨ)500mg&#215;10Ƭ</option>

	<option value="14440282">[14440282]����һ��ͽ���(�ұص�)300mg&#215;20��/��,��������</option>

	<option value="14440286">[14440286]����һ��ͽ���(�ұص�)0.3g*10s</option>

	<option value="14440289">[14440289]����һ��ͽ���0.4g*8��/��*3��/��</option>

	<option value="14440441">[14440441]�ӿ�Ƭ(�ұص�)10Ƭ/��,PTP����/������ϩ/��ƫ������ϩӲƬ����</option>

	<option value="14440442">[14440442]�ӿ�Ƭ(�ұص�)565mg&#215;20Ƭ/��,��������</option>

	<option value="14440493">[14440493](FM)����α�黺�ͽ���(��̩����)10s</option>

	<option value="14440580">[14440580](FM)��������α��Ƽ�ͽ���(�¿�̩��)10��&#215;1��/��,��������</option>

	<option value="14440582">[14440582](FM)��������α��Ƽ�ͽ���8��/��</option>

	<option value="14440589">[14440589](FM)����α��Ƭ(�¿�̩��)10Ƭ&#215;2��/��,����</option>

	<option value="14440590">[14440590](FM)����α��Ƭ10Ƭ/��,��������</option>

	<option value="14450025">[14450025]�����涡Ƭ(̩θ��)800mg&#215;10Ƭ/��,��������,(��Ĥ��Ƭ)</option>

	<option value="14450026">[14450026]�����涡Ƭ(̩θ��)400mg&#215;20Ƭ/��,��������,(��Ĥ��Ƭ)</option>

	<option value="14468020">[14468020]��������Ƭ(ʷ�˳�����)200mg&#215;10Ƭ/��,��������</option>

	<option value="14468025">[14468025]��������Ƭ2s*200mg</option>

	<option value="14510291">[14510291]���ᰱ�������ͽ���75����*6��/��</option>

	<option value="15529011">[15529011](F)���ᱶ�����ɱ������(������)50ug/��&#215;200��/֧,���ް�װ</option>

	<option value="16541240">[16541240]Īƥ�������(�ٶ��)2��/5g/֧,��������</option>

	<option value="16541241">[16541241]Īƥ�������(�ٶ��)2��/10g/֧,��������</option>

	<option value="16541280">[16541280]��������(�ұص�)20g��5����&#215;1֧/֧,����</option>

	<option value="16541330">[16541330]�����ر��������(������)5g&#215;1֧/֧,����</option>

	<option value="21000084">[21000084]ͨ������10Ƭ ��ɫ�ͣ���׼��</option>

	<option value="21000101">[21000101]ͨ������10Ƭ ͸���ͣ���׼��</option>

	<option value="21000136">[21000136]ͨ������(��ͯ��)8s</option>

	<option value="21000204">[21000204]ͨ������10Ƭ�������ͣ���׼��</option>

	<option value="42990002">[42990002]�¿�̩�˺�ˬ������ǣ�����ζ��40��(20��װ)</option>

	<option value="42990003">[42990003]�¿�̩�˺�ˬ�ݱ�������ǣ�����ζ��20�ˣ�10��װ��</option>

	<option value="42990004">[42990004]�¿�̩�˺�ˬ�ݱ�������ǣ�����ζ��40��(20��װ)</option>

	<option value="42990005">[42990005]�¿�̩�˺�ˬ�ݱ�������ǣ�����ζ��20�ˣ�10��װ��</option>

	<option value="42990119">[42990119]�¿�̩�˺�ˬ�ݱ�������ǣ��ͷ�ݮ��ζ��40�ˣ�Լ20������װ��</option>

	<option value="43990000">[43990000]�¿�̩�˲ݱ�������Ǻ�ˬ�����ɿ�ζ��40�ˣ�20��װ��</option>

	<option value="85001032">[85001032]�ٶ������������70ml</option>

	<option value="88000476">[88000476]���ʴ￹�������ࣨȫ�滤��120g</option>

	<option selected="selected" value="88000477">[88000477]���ʴ￹�������ࣨ���±��ɣ�120g</option>

	<option value="88000478">[88000478]���ʴ���Ч��������120g</option>

	<option value="88000479">[88000479]���ʴ�רҵ�޸�����100��</option>

	<option value="88009047">[88009047]�������������Ƭ24Ƭ</option>

	<option value="88009049">[88009049]�������������Ƭ���ֲ�����ר�ã�24Ƭ</option>

	<option value="88010004">[88010004]�������������Ƭ��ȫ/��ڼ���ר�ã�30Ƭ</option>

	<option value="88010005">[88010005]�������������Ƭ���ֲ�����ר�ã�30Ƭ</option>



</select></FONT></TD>

										</tr>

									</TABLE>

								</td>

							</TR>

							<TR>

								<TD align="center" colSpan="2" height="5"></TD>

							</TR>

							<TR>

								<TD colspan="2" vAlign="top" align="center" height="100%">

									<table id="tabResult" class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">

	<tr>

		<TD class="titlecell" style="HEIGHT: 25px" align="left"><B>���ҽ��</B><B> </B>

												<span id="lblInfo" style="display:inline-block;">���ҵ� 7 ����¼</span></TD>

		<TD class="titlecell" style="HEIGHT: 25px" align="right"><input type="submit" name="btPtint" value="��ӡ" onclick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;btPtint&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, false))" id="btPtint" class="button" />

												<input type="submit" name="btDown" value="����" onclick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;btDown&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, false))" id="btDown" class="button" />

											</TD>

	</tr>

	<tr>

		<td colspan="2">

												<table id="tabGoodsInfo" class="table" style="TABLE-LAYOUT: fixed" height="100%" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">

			<tr>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">����</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtCode" type="text" value="88000477" id="txtCode" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">Ʒ��</FONT></td>

				<td style="HEIGHT: 23px" colspan="3"><FONT face="����"><input name="txtName" type="text" value="���ʴ￹�������ࣨ���±��ɣ�" id="txtName" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">���</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtSpec" type="text" value="120g" id="txtSpec" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">����</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtDoseType" type="text" value="��������" id="txtDoseType" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">������</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtWholePrice" type="text" value="20.8100" id="txtWholePrice" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">���ۼ�</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtRetailPrice" type="text" value="28.0000" id="txtRetailPrice" class="inputnormal" /></FONT></td>

			</tr>

			<tr>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">���װ</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtOutPack" type="text" value="��" id="txtOutPack" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">�а�װ</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtMidPack" type="text" value="��" id="txtMidPack" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">�ڰ�װ</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtInPack" type="text" value="֧" id="txtInPack" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">����</FONT></td>

				<td style="HEIGHT: 23px"><FONT face="����"><input name="txtProducePlace" type="text" value="����" id="txtProducePlace" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">����</FONT></td>

				<td style="HEIGHT: 23px" colspan="5"><FONT face="����"><input name="txtManufacturer" type="text" value="���ݿ�������ױƷ���޹�˾" id="txtManufacturer" class="inputnormal" /></FONT></td>

			</tr>

			<tr>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">��ѯʱ��</FONT></td>

				<td style="HEIGHT: 23px" colspan="7"><FONT face="����"><input name="txtDate" type="text" value="2014-05-11��2014-06-19" id="txtDate" class="inputnormal" /></FONT></td>

				<td style="HEIGHT: 23px" valign="middle" align="center" width="60"><FONT face="����">ҵ��λ</FONT></td>

				<td style="HEIGHT: 23px" colspan="5"><FONT face="����"><input name="txtCompany" type="text" value="����ʷ��" id="txtCompany" class="inputnormal" /></FONT></td>

			</tr>

		</table>

		

											</td>

	</tr>

	<tr>

		<TD valign="top" colspan="2">

												<table id="tabSale" class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">

			<tr>

				<TD colspan="2"><table cellspacing="0" rules="all" border="1" id="dgGoods" width="100%">

					<tr>

						<td align="center" valign="middle" width="10%">�ŵ����</td><td align="center" valign="middle" width="45%">�ŵ�����</td><td align="center" valign="middle" width="10%">��������</td><td align="center" valign="middle" width="15%">����</td><td align="center" valign="middle" width="10%">����</td><td align="center" valign="middle" width="10%">��Ӧ��</td>

					</tr><tr>

						<td align="center">103</td><td align="left">�Ž���</td><td align="center">2014��6��5��</td><td align="center">13092401</td><td align="right">6.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">108</td><td align="left">���ŵ�</td><td align="center">2014��6��16��</td><td align="center">13092401</td><td align="right">2.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">218</td><td align="left">��ɽ��</td><td align="center">2014��6��5��</td><td align="center">13092401</td><td align="right">11.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">219</td><td align="left">��ɽ��</td><td align="center">2014��5��14��</td><td align="center">13092401</td><td align="right">2.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">311</td><td align="left">�����</td><td align="center">2014��6��17��</td><td align="center">13092401</td><td align="right">5.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">408</td><td align="left">���ŵ�</td><td align="center">2014��6��4��</td><td align="center">13092401</td><td align="right">2.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">428</td><td align="left">����·��</td><td align="center">2014��6��18��</td><td align="center">13092401</td><td align="right">2.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">�ϼ�</td><td align="left">&nbsp;</td><td align="center">&nbsp;</td><td align="center">&nbsp;</td><td align="right">30.0000</td><td align="right">0.000000000000</td>

					</tr><tr>

						<td align="center">�ֿ��</td><td align="left">&nbsp;</td><td align="center">&nbsp;</td><td align="center">&nbsp;</td><td align="right">15.0000</td><td align="right">0.000000000000</td>

					</tr>

				</table>

															

														</TD>

			</tr>

		</table>

		

											</TD>

	</tr>

</table>



								</TD>

							</TR>

						</TABLE>

					</TD>

				</TR>

				<TR>

					<td vAlign="bottom" align="center">

��Ȩ���� 2005�Ϻ�������ҩҵ������Ӫ���޹�˾

</td>

				</TR>

			</TABLE>

		</form>

	</body>

</HTML>
