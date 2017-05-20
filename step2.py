#coding: utf-8
import MySQLdb
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
if __name__ == '__main__':
 conn=MySQLdb.connect(
    host='localhost',
    port=3306,
    user='root',
    passwd='6286',
    charset="utf8",
    db='university',
)
cur = conn.cursor()
cur.execute("select * from department")
def prc_line(line):
    _result = line.decode("utf-8").strip().split(" ")
    _result[2] = int(_result[2])
    return _result

with open('/home/yangfan/桌面/MySQL上课文件/作业/university/department.txt','r') as f:
    datas = [prc_line(line) for line in f.readlines()]
print datas
for d in datas:
    cur.execute("insert into department values('%s','%s',%d)"%(d[0],d[1],d[2]))
conn.commit()
cur.close()


cur.execute("select * from student")
def prc_line(line):
     _result = line.decode("utf-8").strip().split(" ")
     _result[0] = int(_result[0])
     _result[3] = int(_result[3])
     return _result

with open('/home/yangfan/桌面/MySQL上课文件/作业/university/student.txt','r') as f:
    datas = [prc_line(line) for line in f.readlines()]
print datas
for d in datas:
  cur.execute("insert into student values(%d,'%s','%s',%d,'%s','%s')"%(d[0],d[1],d[2],d[3],d[4],d[5]))
conn.commit()


cur.execute("select * from exam")
def prc_line(line):
    _result = line.decode("utf-8").strip().split(" ")
    _result[0] = int(_result[0])
    _result[2] = int(_result[2])
    return _result

with open('/home/yangfan//桌面/MySQL上课文件/作业/university/exam.txt','r') as f:
    datas = [prc_line(line) for line in f.readlines()]
print datas

for d in datas:
    cur.execute("insert into exam values(%d,'%s',%d)"%(d[0],d[1],d[2]))
conn.commit()
cur.close()
conn.close()