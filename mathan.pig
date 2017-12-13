d2000 = load  '/home/hduser/Downloads/2000.txt'  using  PigStorage(',')  AS ( catid, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
--dump d2000;
d2001 = load  '/home/hduser/Downloads/2001.txt'  using  PigStorage(',')  AS ( catid, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
--dump d2001;
d2002 = load  '/home/hduser/Downloads/2002.txt'  using  PigStorage(',')  AS ( catid, name, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double ,nov:double, dec:double);
--dump d2002;
dg2000 = foreach d2000 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2000;
--dump dg2000;
dg2001 = foreach d2001 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2000;
--dump dg2000;
dg2002 = foreach d2002 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13) as tot2000;
--dump dg2000;
data012 = join dg2000 by $0, dg2001 by $0, dg2002 by $0;
--dump data012;
data012new = foreach data012 generate $0, $1, $2, $5, $8;
--dump data012new;
data = foreach data012new generate $0, $1, $2, $3, $4, (($3-$2)/$2*100), (($4-$3)/$3*100);
--dump data;
avg = foreach data generate $0, $1, $2, $3, $4, $5, $6, ROUND_TO((($5+$6)/2),2) as avge;
--dump avg;
growth = filter avg by avge>10;
--dump growth;
growth1 = filter avg by avge<-5;
--dump growth1;
add = foreach data012new generate $0, $1, ($2+$3+$4) as total;
--dump add;
top = order add by total desc;
--dump top;
top5 = limit top 5;
--dump top5;
bot = limit (order add by total) 5;
dump bot;