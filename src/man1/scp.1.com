.\" 2000 PTM Przemek Borys <pborys@dione.ids.pl>
.\"  -*- nroff -*-
.\"
.\" scp.1
.\"
.\" Author: Tatu Ylonen <ylo@cs.hut.fi>
.\"
.\" Copyright (c) 1995 Tatu Ylonen <ylo@cs.hut.fi>, Espoo, Finland
.\"                    All rights reserved
.\"
.\" Created: Sun May  7 00:14:37 1995 ylo
.\"
.\" $Id: scp.1.com,v 1.4 2004/06/21 09:37:03 robert Exp $
.\" $Log: scp.1.com,v $
.\" Revision 1.4  2004/06/21 09:37:03  robert
.\" poprawka
.\"
.\" Revision 1.3  2004/06/16 04:44:04  ankry
.\" - reversed: this manpage belongs to a commercial SSH
.\"
.\" Revision 1.1  2000/07/26 13:06:01  pborys
.\" nowe.
.\"
.\" Revision 1.1.1.1  1999/09/02 23:27:08  wiget
.\" - pierwsza porcja oryginalnych manuali
.\"
.\" Revision 1.7  1998/08/07 12:26:35  tri
.\" 	Added flag -1 to force command "scp1" on the remote
.\" 	system instead of "scp".  This is necessary sometimes,
.\" 	if remote side has scp symlinked to scp2.
.\"
.\" Revision 1.6  1998/07/08 00:42:13  kivinen
.\" 	Changed to do similar commercial #ifdef processing than other
.\" 	files. Added -a, -A, -Q, and -L. Added comment about
.\" 	environment variables.
.\"
.\" Revision 1.5  1998/06/11 00:10:08  kivinen
.\" 	Added -q option.
.\"
.\" Revision 1.4  1997/04/27  21:48:37  kivinen
.\" 	Added F-SECURE stuff.
.\"
.\" Revision 1.3  1997/04/23 00:03:28  kivinen
.\" 	Documented -S flag and -o flags.
.\"
.\" Revision 1.2  1997/03/25 05:41:20  kivinen
.\" 	Fixed typo. Changed ylo's email to @ssh.fi.
.\"
.\" Revision 1.1.1.1  1996/02/18 21:38:13  ylo
.\" 	Imported ssh-1.2.13.
.\"
.\" Revision 1.5  1995/08/29  22:30:46  ylo
.\" 	Improved manual pages from Andrew Macpherson.
.\"
.\" Revision 1.4  1995/08/18  22:55:14  ylo
.\" 	Added "-P port" option.
.\"
.\" Revision 1.3  1995/07/13  01:37:06  ylo
.\" 	Removed "Last modified" header.
.\" 	Added cvs log.
.\"
.\" $Endlog$
.\"
.\"
.\"
.\"
.\" #ifndef F_SECURE_COMMERCIAL
.TH SCP 1 "8 listopad 1995" "SSH" "SSH"
.\" #endif F_SECURE_COMMERCIAL

.SH NAZWA
scp \- bezpieczne kopiowanie (program zdalnego kopiowania plików)

.SH SK£ADNIA
.LP
.B scp
[\c
.B \-aAqQprvBCL1\c
]
[\c
.BI \-S "\ ¶cie¿ka-do-ssh\c
]
[\c
.BI \-o "\ opcje-ssh\c
]
[\c
.BI \-P "\ port\c
]
[\c
.BI \-c "\ szyfr\c
]
[\c
.BI \-i "\ to¿samo¶æ\c
]
.if n .ti +5
[[\c
.B u¿ytkownik@\c
]\c
.B host1:\c
]\c
.B nazwapliku1\c
\&.\|.\|.
[[\c
.B u¿ytkownik@\c
]\c
.B host2:\c
]\c
.B nazwapliku2

.SH OPIS
.LP
.B Scp
kopiuje pliki miêdzy hostami sieci. Do transferu danych u¿ywa
.B ssh
i wykorzystuje t± sam± autoryzacjê oraz daje takie samo bezpieczeñstwo jak
same security as
.B ssh.
W przeciwieñstwie do
.BR rcp ",
.B scp
pyta w razie potrzeby o has³a uwierzytelniaj±ce.
.LP
Wszelkie nazwy pliku mog± zawieraæ specyfikacje hosta i u¿ytkownika,
okre¶laj±ce ¿e plik jest kopiowany do/z tego hosta. Dozwolone jest
kopiowanie miêdzy dwoma zdalnymi hostami.

.SH OPCJE

.TP 0.6i
.B \-a
W³±cza wy¶wietlanie statystyk dla ka¿dego pliku.
.TP
.B \-A
Wy³±cza wy¶wietlanie statystyk dla ka¿dego pliku.
.TP
.BI \-c "\ szyfr
Wybiera szyfr u¿ywany do kodowania danych. Opcja ta jest przekazywana
bezpo¶rednio do
.B ssh.
.TP
.BI \-i "\ plik_to¿samo¶ci
Wybiera plik, z którego odczytywana jest to¿samo¶æ (klucz prywatny) dla
uwierzytelnienia RSA. Opcja ta jest przekazywana bezpo¶rednio do
.B ssh.
.TP
.B \-L
U¿yj nieuprzywilejowanego portu. Prz u¿yciu tej opcji nie mo¿na u¿ywaæ
autoryzacji rhosts lub rsarhosts, ale umo¿liwia ona omin±æ niektóre zapory
ogniowe, które nie zezwalaj± na przej¶cie uprzywilejowanych portów
¼ród³owych. Jest to to samo co wykonanie "-o UsePrivilegdePort=no" lub -P w
ssh; -L zosta³o u¿yte z powodu braku odpowiednich liter.
.TP
.B \-1
Wymu¶ by scp na zdalnym koñcu u¿y³ zamiast "scp" polecenia "scp1". Mo¿e to
byæ konieczne w pewnych sytuacjach je¶li zdalny system ma dowi±zane "scp" do
"scp2".
.TP
.BI \-o "\ opcje-ssh
Opcje ssh przekazywane programowi ssh.
.TP
.B \-p
Zachowuje czasy modyfikacji, dostêpu i prawa oryginalnego pliku.
.TP
.B \-q
Wy³±cz wy¶wietlanie statystyk.
.TP
.B \-Q
W³±cz wy¶wietlanie statystyk.
.TP
.B \-r
Kopiuj rekursywnie ca³e katalogi.
.TP
.B \-v
Tryb gadatliwy. Powoduje, ¿e
.B scp
i
.B ssh
drukuj± komunikaty debugowe o swoim dzia³aniu. Jest to przydatne w
debugowaniu problemów ³±czenia, autoryzacji i konfiguracji.
.TP
.B \-B
Wybiera tryb wsadowy (nie pyta o has³a i frazy koduj±ce).
.TP
.B \-C
W³±czenie kompresji. Przekazuje
.B ssh
flagê -C, w³±czaj±c± kompresjê.
.TP
.BI \-P "\ port
Podaje port, do którego pod³±czyæ siê na zdalnym ho¶cie. Zauwa¿, ¿e opcja ta
jest napisana jako du¿e P, gdy¿ \-p ju¿ jest zarezerwowane dla innej
operacji.
.TP
.BI \-S "\ ¶cie¿ka-do-ssh
Okre¶la ¶cie¿kê do programu ssh.

.SH ZMIENNE ¦RODOWISKOWE
.LP
Statystyki scp mo¿na prze³±czaæ, ustawiaj±c zmienne ¶rodowiskowe
.B SSH_SCP_STATS
lub
.BR SSH_NO_SCP_STATS .
Aby prze³±czaæ statystyki dla ka¿dego pliku, u¿yj
.B SSH_ALL_SCP_STATS
lub
.BR SSH_NO_ALL_SCP_STATS .
Domy¶lne warto¶ci statystyk mo¿na ustawiæ podczas konfiguracji ssh. Potem
scp sprawdza wymienione zmienne ¶rodowiskowe, a na koñcu opcje linii poleceñ.

.SH AUTORZY
.LP
Timo Rinne <tri@iki.fi> i Tatu Ylonen <ylo@ssh.fi>

.SH ¬RÓD£A
.LP
.B Scp
jest oparty na programie
.BR rcp ,
o kodzie ¼ród³owym z Regentów Uniwersytetu Kalifornijskiego.

.SH ZOBACZ TAK¯E
.LP
.BR ssh (1),
.BR sshd (8),
.BR ssh-keygen (1),
.BR ssh-agent (1),
.BR ssh-add (1),
.BR rcp (1)
