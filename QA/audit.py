from pathlib import Path
import hashlib,json,re
r=Path(__file__).resolve().parents[1];factory=r.parents[3]
result={}
for rel,want in [('concepts15nov/04_chicken_road/04_backyard_coop.md','e13f69f0b34e13c1f0d65a393eac15b9b71961d5b8bc5ae2dac516997f17db40'),('concepts15nov/README.md','f0134d4bc1eab47d1b8d3e37be06fc510be0744a7dc17b95e258885e08ef7e93')]:
 actual=hashlib.sha256((factory/rel).read_bytes()).hexdigest();result[rel]={'sha256':actual,'matches':actual==want}
pbx=(r/'BackyardCoop.xcodeproj/project.pbxproj').read_text();ids=set(re.findall(r'\b[A-F0-9]{24}\b',pbx));collisions=[];compared=0
for other in (factory/'output/concepts15nov').glob('*/*/*.xcodeproj/project.pbxproj'):
 if other == r/'BackyardCoop.xcodeproj/project.pbxproj':continue
 compared+=1;shared=ids & set(re.findall(r'\b[A-F0-9]{24}\b',other.read_text(errors='replace')))
 if shared:collisions.append({'project':str(other.relative_to(factory)),'UUIDs':sorted(shared)})
result['pbxUUIDs']={'own':len(ids),'projectsCompared':compared,'collisions':collisions}
result['swiftFiles']=[str(p.relative_to(r)) for p in [*r.glob('Source/*.swift'),*r.glob('Glance/*.swift'),*r.glob('Checks/*.swift')]]
local=json.loads((r/'Resources/Localizable.xcstrings').read_text());result['localizedKeys']=len(local['strings']);result['locales']=list(next(iter(local['strings'].values()))['localizations']);result['allTranslationsComplete']=all(set(v['localizations'])=={'en','de','fr','pt-BR'} for v in local['strings'].values())
texts=[*r.glob('Source/*'),*r.glob('Glance/*'),*r.glob('Resources/*.plist'),*r.glob('Resources/*.xcstrings'),r/'BackyardCoop.xcodeproj/project.pbxproj']
result['personalSourceTraces']=[str(p.relative_to(r)) for p in texts if p.is_file() and re.search(r'/Users/|@gmail|ORGANIZATIONNAME.*[Ee]mail',p.read_text(errors='ignore'))]
result['bannedUIWords']=[]
for k,v in local['strings'].items():
 for lang,entry in v['localizations'].items():
  if re.search(r'\b(bet|casino|slot|jackpot|odds)\b',entry['stringUnit']['value'],re.I):result['bannedUIWords'].append([k,lang])
(r/'QA/audit.json').write_text(json.dumps(result,ensure_ascii=False,indent=2));print(json.dumps(result,ensure_ascii=False,indent=2))
