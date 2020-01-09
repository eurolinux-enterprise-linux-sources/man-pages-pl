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
scp \- bezpieczne kopiowanie (program zdalnego kopiowania plik�w)

.SH SK�ADNIA
.LP
.B scp
[\c
.B \-aAqQprvBCL1\c
]
[\c
.BI \-S "\ �cie�ka-do-ssh\c
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
.BI \-i "\ to�samo��\c
]
.if n .ti +5
[[\c
.B u�ytkownik@\c
]\c
.B host1:\c
]\c
.B nazwapliku1\c
\&.\|.\|.
[[\c
.B u�ytkownik@\c
]\c
.B host2:\c
]\c
.B nazwapliku2

.SH OPIS
.LP
.B Scp
kopiuje pliki mi�dzy hostami sieci. Do transferu danych u�ywa
.B ssh
i wykorzystuje t� sam� autoryzacj� oraz daje takie samo bezpiecze�stwo jak
same security as
.B ssh.
W przeciwie�stwie do
.BR rcp ",
.B scp
pyta w razie potrzeby o has�a uwierzytelniaj�ce.
.LP
Wszelkie nazwy pliku mog� zawiera� specyfikacje hosta i u�ytkownika,
okre�laj�ce �e plik jest kopiowany do/z tego hosta. Dozwolone jest
kopiowanie mi�dzy dwoma zdalnymi hostami.

.SH OPCJE

.TP 0.6i
.B \-a
W��cza wy�wietlanie statystyk dla ka�dego pliku.
.TP
.B \-A
Wy��cza wy�wietlanie statystyk dla ka�dego pliku.
.TP
.BI \-c "\ szyfr
Wybiera szyfr u�ywany do kodowania danych. Opcja ta jest przekazywana
bezpo�rednio do
.B ssh.
.TP
.BI \-i "\ plik_to�samo�ci
Wybiera plik, z kt�rego odczytywana jest to�samo�� (klucz prywatny) dla
uwierzytelnienia RSA. Opcja ta jest przekazywana bezpo�rednio do
.B ssh.
.TP
.B \-L
U�yj nieuprzywilejowanego portu. Prz u�yciu tej opcji nie mo�na u�ywa�
autoryzacji rhosts lub rsarhosts, ale umo�liwia ona omin�� niekt�re zapory
ogniowe, kt�re nie zezwalaj� na przej�cie uprzywilejowanych port�w
�r�d�owych. Jest to to samo co wykonanie "-o UsePrivilegdePort=no" lub -P w
ssh; -L zosta�o u�yte z powodu braku odpowiednich liter.
.TP
.B \-1
Wymu� by scp na zdalnym ko�cu u�y� zamiast "scp" polecenia "scp1". Mo�e to
by� konieczne w pewnych sytuacjach je�li zdalny system ma dowi�zane "scp" do
"scp2".
.TP
.BI \-o "\ opcje-ssh
Opcje ssh przekazywane programowi ssh.
.TP
.B \-p
Zachowuje czasy modyfikacji, dost�pu i prawa oryginalnego pliku.
.TP
.B \-q
Wy��cz wy�wietlanie statystyk.
.TP
.B \-Q
W��cz wy�wietlanie statystyk.
.TP
.B \-r
Kopiuj rekursywnie ca�e katalogi.
.TP
.B \-v
Tryb gadatliwy. Powoduje, �e
.B scp
i
.B ssh
drukuj� komunikaty debugowe o swoim dzia�aniu. Jest to przydatne w
debugowaniu problem�w ��czenia, autoryzacji i konfiguracji.
.TP
.B \-B
Wybiera tryb wsadowy (nie pyta o has�a i frazy koduj�ce).
.TP
.B \-C
W��czenie kompresji. Przekazuje
.B ssh
flag� -C, w��czaj�c� kompresj�.
.TP
.BI \-P "\ port
Podaje port, do kt�rego pod��czy� si� na zdalnym ho�cie. Zauwa�, �e opcja ta
jest napisana jako du�e P, gdy� \-p ju� jest zarezerwowane dla innej
operacji.
.TP
.BI \-S "\ �cie�ka-do-ssh
Okre�la �cie�k� do programu ssh.

.SH ZMIENNE �RODOWISKOWE
.LP
Statystyki scp mo�na prze��cza�, ustawiaj�c zmienne �rodowiskowe
.B SSH_SCP_STATS
lub
.BR SSH_NO_SCP_STATS .
Aby prze��cza� statystyki dla ka�dego pliku, u�yj
.B SSH_ALL_SCP_STATS
lub
.BR SSH_NO_ALL_SCP_STATS .
Domy�lne warto�ci statystyk mo�na ustawi� podczas konfiguracji ssh. Potem
scp sprawdza wymienione zmienne �rodowiskowe, a na ko�cu opcje linii polece�.

.SH AUTORZY
.LP
Timo Rinne <tri@iki.fi> i Tatu Ylonen <ylo@ssh.fi>

.SH �R�D�A
.LP
.B Scp
jest oparty na programie
.BR rcp ,
o kodzie �r�d�owym z Regent�w Uniwersytetu Kalifornijskiego.

.SH ZOBACZ TAK�E
.LP
.BR ssh (1),
.BR sshd (8),
.BR ssh-keygen (1),
.BR ssh-agent (1),
.BR ssh-add (1),
.BR rcp (1)
