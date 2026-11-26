from pathlib import Path
import subprocess,os
r=Path(__file__).resolve().parents[1]
s=(r/'Source/H7Leaf.swift').read_text()
s='import Foundation\n'+s[s.index('struct H7Row:'):s.index('struct H7Bars:')]
s+=r'''
func check(_ label:String,_ yes:Bool){guard yes else{fatalError(label)};print("PASS "+label)}
let now=Date();let previous=Calendar.current.date(byAdding:.day,value:-1,to:now)!
let rows=[H7Row(k:"egg",d:now,v:3),H7Row(k:"egg",d:now,v:4),H7Row(k:"egg",d:previous,v:2),H7Row(k:"egg",d:now,v:90,gone:true)]
check("daily aggregation",H7Math.week(rows,now).last!.1 == 7)
check("seven day boundary",H7Math.week(rows,now).count == 7 && H7Math.week(rows,now).reduce(0){$0+$1.1} == 9)
check("ration calculation",abs(H7Math.ration(10,115,7)-8.05)<0.0001)
check("negative ration clamped",H7Math.ration(-3,115,7) == 0)
let old=H7Row(id:"one",k:"bird",n:"Hazel",u:now);var dead=old;dead.u=now.addingTimeInterval(1);dead.gone=true
check("deletion wins merge",H7Math.merged([old],[dead]) == [dead] && H7Math.merged([dead],[old]) == [dead])
let due=[H7Row(k:"care",d:now.addingTimeInterval(-100)),H7Row(k:"care",d:now.addingTimeInterval(172800)),H7Row(k:"care",d:now,done:true)]
check("overdue care and completed filtering",H7Math.due(due,now).count == 1)
let csv=H7Math.csv([H7Row(k:"bird",n:"=1+1",q:"a,\"b\"\nline")])
check("CSV formula and quote escaping",csv.contains("\"'=1+1\"") && csv.contains("\"a,\"\"b\"\"\nline\""))
let photo=H7Row(k:"bird",n:"Hazel",p:Data([0,1,2,3]));let encoded=try JSONEncoder().encode(H7Box(rows:[photo]))
check("photo and journal round trip",try JSONDecoder().decode(H7Box.self,from:encoded).rows == [photo])
'''
# Shared App Group access is a platform operation and is not exercised by these portable Foundation checks.
s=s.replace('forSecurityApplicationGroupIdentifier:h7G','forSecurityApplicationGroupIdentifier:"group.com.backyardcoop.app"')
p=subprocess.run(['xcrun','swift','-module-cache-path',str(r/'Artifacts/CoreCache'),'-'],input=s,text=True,capture_output=True,env={**os.environ,'DEVELOPER_DIR':'/Applications/Xcode.app/Contents/Developer'})
(r/'QA/core-check.log').write_text(p.stdout+p.stderr);print(p.stdout+p.stderr);raise SystemExit(p.returncode)
