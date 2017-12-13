author = load '/home/hduser/Downloads/medical'  using  PigStorage('	') AS (name:chararray, dept, salary:int);
--dump author;
joo = foreach author generate $0, $2 as salary;
--dump joo;
grp =group joo by name;
--dump grp;
b = foreach grp generate $0, ROUND_TO(AVG(joo.salary),2);
dump b;
