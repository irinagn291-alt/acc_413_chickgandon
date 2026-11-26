from pathlib import Path
import json,uuid,plistlib
r=Path(__file__).resolve().parent
objects={}
def obj(isa,**kw):
 i=uuid.uuid4().hex[:24].upper();objects[i]={'isa':isa,**kw};return i
def dump(x):
 if isinstance(x,dict):return '{\n'+''.join(json.dumps(str(k))+ ' = '+dump(v)+';\n' for k,v in x.items())+'}'
 if isinstance(x,list):return '(\n'+''.join(dump(v)+',\n' for v in x)+')'
 return json.dumps(str(x))
def plist(name,data):
 (r/'Resources'/name).write_bytes(plistlib.dumps(data,sort_keys=False))
base={'CFBundleDevelopmentRegion':'en','CFBundleExecutable':'$(EXECUTABLE_NAME)','CFBundleIdentifier':'$(PRODUCT_BUNDLE_IDENTIFIER)','CFBundleInfoDictionaryVersion':'6.0','CFBundleName':'$(PRODUCT_NAME)','CFBundlePackageType':'APPL','CFBundleShortVersionString':'$(MARKETING_VERSION)','CFBundleVersion':'$(CURRENT_PROJECT_VERSION)','CFBundleDisplayName':'Chickgandon','LSRequiresIPhoneOS':True}
app=base|{'UILaunchScreen':{},'UIApplicationSceneManifest':{'UIApplicationSupportsMultipleScenes':False},'UISupportedInterfaceOrientations':['UIInterfaceOrientationPortrait','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight'],'UISupportedInterfaceOrientations~ipad':['UIInterfaceOrientationPortrait','UIInterfaceOrientationPortraitUpsideDown','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight'],'UIBackgroundModes':['remote-notification'],'NSCameraUsageDescription':'Take a portrait to recognize a bird in your flock journal.','NSPhotoLibraryUsageDescription':'Choose an existing bird picture for its flock card.','NSRemindersUsageDescription':'Copy selected poultry care tasks into your Apple Reminders lists.','NSRemindersFullAccessUsageDescription':'Save and update the poultry care tasks you choose in Apple Reminders.','CFBundleURLTypes':[{'CFBundleURLSchemes':['coop482']}]}
plist('NestInfo.plist',app)
plist('GlanceInfo.plist',base|{'CFBundlePackageType':'XPC!','NSExtension':{'NSExtensionPointIdentifier':'com.apple.widgetkit-extension'}})
plist('Nest.entitlements',{'com.apple.security.application-groups':['group.com.backyardcoop.app'],'com.apple.developer.icloud-services':['CloudKit'],'com.apple.developer.icloud-container-identifiers':['iCloud.com.backyardcoop.app'],'aps-environment':'development'})
plist('Glance.entitlements',{'com.apple.security.application-groups':['group.com.backyardcoop.app']})
plist('PrivacyInfo.xcprivacy',{'NSPrivacyTracking':False,'NSPrivacyTrackingDomains':[],'NSPrivacyCollectedDataTypes':[],'NSPrivacyAccessedAPITypes':[{'NSPrivacyAccessedAPIType':'NSPrivacyAccessedAPICategoryUserDefaults','NSPrivacyAccessedAPITypeReasons':['CA92.1']}]})
(r/'Resources/PastureArt.xcassets/Contents.json').write_text(json.dumps({'info':{'author':'xcode','version':1}}))
(r/'Resources/PastureArt.xcassets/NestMark.appiconset/Contents.json').write_text(json.dumps({'images':[{'filename':'NestMark.png','idiom':'universal','platform':'ios','size':'1024x1024'}],'info':{'author':'xcode','version':1}}))
seal=r/'Resources/PastureArt.xcassets/YardSeal.imageset';seal.mkdir(exist_ok=True)
import shutil
shutil.copyfile(r/'Resources/PastureArt.xcassets/NestMark.appiconset/NestMark.png',seal/'seal.png')
(seal/'Contents.json').write_text(json.dumps({'images':[{'filename':'seal.png','idiom':'universal'}],'info':{'author':'xcode','version':1}}))
refs={}
files={'Source/H7Leaf.swift':'sourcecode.swift','Source/V2Nest.swift':'sourcecode.swift','Source/B8Yard.swift':'sourcecode.swift','Source/U5Feather.swift':'sourcecode.swift','Glance/K3Patch.swift':'sourcecode.swift','Checks/N6Proof.swift':'sourcecode.swift','Resources/PastureArt.xcassets':'folder.assetcatalog','Resources/Localizable.xcstrings':'text.json.xcstrings','Resources/InfoPlist.xcstrings':'text.json.xcstrings','Resources/FieldNotes.json':'text.json','Resources/PrivacyInfo.xcprivacy':'text.xml'}
for p,t in files.items():refs[p]=obj('PBXFileReference',lastKnownFileType=t,path=p,sourceTree='<group>')
products=obj('PBXGroup',children=[],name='Products',sourceTree='<group>')
main=obj('PBXGroup',children=list(refs.values())+[products],sourceTree='<group>')
projectID=obj('PBXProject',attributes={'BuildIndependentTargetsInParallel':'YES','LastUpgradeCheck':'2720','ORGANIZATIONNAME':'Sunlit Orchard Ledger'},buildConfigurationList='',compatibilityVersion='Xcode 14.0',developmentRegion='en',knownRegions=['en','de','fr','pt-BR','Base'],mainGroup=main,productRefGroup=products,projectDirPath='',projectRoot='',targets=[])
common={'SDKROOT':'iphoneos','SWIFT_VERSION':'5.0','IPHONEOS_DEPLOYMENT_TARGET':'17.4','TARGETED_DEVICE_FAMILY':'1,2','CLANG_ENABLE_MODULES':'YES','CLANG_ENABLE_OBJC_ARC':'YES','SWIFT_STRICT_CONCURRENCY':'minimal','ENABLE_USER_SCRIPT_SANDBOXING':'YES','CODE_SIGN_STYLE':'Automatic','MARKETING_VERSION':'1.4.2','CURRENT_PROJECT_VERSION':'482','SUPPORTED_PLATFORMS':'iphoneos iphonesimulator','SUPPORTS_MACCATALYST':'NO','SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD':'NO','DEBUG_INFORMATION_FORMAT':'dwarf-with-dsym'}
def configs(settings):
 cs=[]
 for name in ['FieldDebug','OrchardRelease']:
  s=common|settings|({'SWIFT_OPTIMIZATION_LEVEL':'-Onone','SWIFT_ACTIVE_COMPILATION_CONDITIONS':'DEBUG $(inherited)','ENABLE_TESTABILITY':'YES'} if name=='FieldDebug' else {'SWIFT_OPTIMIZATION_LEVEL':'-O','VALIDATE_PRODUCT':'YES'})
  if settings.get('SWIFT_ACTIVE_COMPILATION_CONDITIONS'):s['SWIFT_ACTIVE_COMPILATION_CONDITIONS']=settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS']+(' DEBUG' if name=='FieldDebug' else '')
  cs.append(obj('XCBuildConfiguration',name=name,buildSettings=s))
 return obj('XCConfigurationList',buildConfigurations=cs,defaultConfigurationIsVisible='0',defaultConfigurationName='OrchardRelease')
objects[projectID]['buildConfigurationList']=configs({})
def target(name,bundle,sources,resources,kind,settings):
 prod=obj('PBXFileReference',explicitFileType={'app':'wrapper.application','appex':'wrapper.app-extension','xctest':'wrapper.cfbundle'}[kind],includeInIndex='0',path=name+'.'+kind,sourceTree='BUILT_PRODUCTS_DIR');objects[products]['children'].append(prod)
 def phase(isa,paths):return obj(isa,buildActionMask='2147483647',files=[obj('PBXBuildFile',fileRef=refs[p]) for p in paths],runOnlyForDeploymentPostprocessing='0')
 types={'app':'com.apple.product-type.application','appex':'com.apple.product-type.app-extension','xctest':'com.apple.product-type.bundle.unit-test'}
 b=configs({'PRODUCT_NAME':'$(TARGET_NAME)','PRODUCT_BUNDLE_IDENTIFIER':bundle,**settings})
 t=obj('PBXNativeTarget',buildConfigurationList=b,buildPhases=[phase('PBXSourcesBuildPhase',sources),phase('PBXFrameworksBuildPhase',[]),phase('PBXResourcesBuildPhase',resources)],buildRules=[],dependencies=[],name=name,productName=name,productReference=prod,productType=types[kind]);objects[projectID]['targets'].append(t);return t,prod
res=['Resources/PastureArt.xcassets','Resources/Localizable.xcstrings','Resources/InfoPlist.xcstrings','Resources/PrivacyInfo.xcprivacy']
a,ap=target('Paddock','com.backyardcoop.app',[p for p in files if p.startswith('Source/')],res+['Resources/FieldNotes.json'],'app',{'INFOPLIST_FILE':'Resources/NestInfo.plist','CODE_SIGN_ENTITLEMENTS':'Resources/Nest.entitlements','ASSETCATALOG_COMPILER_APPICON_NAME':'NestMark','LD_RUNPATH_SEARCH_PATHS':'$(inherited) @executable_path/Frameworks','SWIFT_EMIT_LOC_STRINGS':'NO'})
w,wp=target('VerdantGlance','com.backyardcoop.app.glance',['Source/H7Leaf.swift','Glance/K3Patch.swift'],res,'appex',{'INFOPLIST_FILE':'Resources/GlanceInfo.plist','CODE_SIGN_ENTITLEMENTS':'Resources/Glance.entitlements','APPLICATION_EXTENSION_API_ONLY':'YES','SKIP_INSTALL':'YES','LD_RUNPATH_SEARCH_PATHS':'$(inherited) @executable_path/Frameworks @executable_path/../../Frameworks'})
u,up=target('GrainChecks','com.backyardcoop.app.checks',['Checks/N6Proof.swift'],[],'xctest',{'GENERATE_INFOPLIST_FILE':'YES','TEST_HOST':'$(BUILT_PRODUCTS_DIR)/Paddock.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/Paddock','BUNDLE_LOADER':'$(TEST_HOST)'})
t,tp=target('WingChecks','com.backyardcoop.app.ui',['Checks/N6Proof.swift'],[],'xctest',{'GENERATE_INFOPLIST_FILE':'YES','TEST_TARGET_NAME':'Paddock','SWIFT_ACTIVE_COMPILATION_CONDITIONS':'COOP_UI'})
objects[t]['productType']='com.apple.product-type.bundle.ui-testing'
def dep(parent,child):
 proxy=obj('PBXContainerItemProxy',containerPortal=projectID,proxyType='1',remoteGlobalIDString=child,remoteInfo=objects[child]['name'])
 objects[parent]['dependencies'].append(obj('PBXTargetDependency',target=child,targetProxy=proxy))
dep(a,w);dep(u,a);dep(t,a)
objects[a]['buildPhases'].append(obj('PBXCopyFilesBuildPhase',buildActionMask='2147483647',dstPath='',dstSubfolderSpec='13',files=[obj('PBXBuildFile',fileRef=wp,settings={'ATTRIBUTES':['RemoveHeadersOnCopy']})],name='Embed Garden Glance',runOnlyForDeploymentPostprocessing='0'))
p=r/'BackyardCoop.xcodeproj';p.mkdir(exist_ok=True)
(p/'project.pbxproj').write_text('// !$*UTF8*$!\n'+dump({'archiveVersion':'1','classes':{},'objectVersion':'56','objects':objects,'rootObject':projectID}))
sch=p/'xcshareddata/xcschemes';sch.mkdir(parents=True,exist_ok=True)
def ref(t,ext):return f'<BuildableReference BuildableIdentifier="primary" BlueprintIdentifier="{t}" BuildableName="{objects[t]["name"]}.{ext}" BlueprintName="{objects[t]["name"]}" ReferencedContainer="container:BackyardCoop.xcodeproj"/>'
(sch/'Paddock.xcscheme').write_text(f'''<?xml version="1.0" encoding="UTF-8"?><Scheme LastUpgradeVersion="2720" version="1.7"><BuildAction parallelizeBuildables="YES" buildImplicitDependencies="YES"><BuildActionEntries><BuildActionEntry buildForTesting="YES" buildForRunning="YES" buildForProfiling="YES" buildForArchiving="YES" buildForAnalyzing="YES">{ref(a,'app')}</BuildActionEntry></BuildActionEntries></BuildAction><TestAction buildConfiguration="FieldDebug" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" shouldUseLaunchSchemeArgsEnv="YES"><Testables><TestableReference skipped="NO">{ref(u,'xctest')}</TestableReference><TestableReference skipped="NO">{ref(t,'xctest')}</TestableReference></Testables></TestAction><LaunchAction buildConfiguration="FieldDebug" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" launchStyle="0" useCustomWorkingDirectory="NO" ignoresPersistentStateOnLaunch="NO" debugDocumentVersioning="YES" debugServiceExtension="internal" allowLocationSimulation="YES"><BuildableProductRunnable runnableDebuggingMode="0">{ref(a,'app')}</BuildableProductRunnable></LaunchAction><ProfileAction buildConfiguration="OrchardRelease" shouldUseLaunchSchemeArgsEnv="YES" savedToolIdentifier="" useCustomWorkingDirectory="NO" debugDocumentVersioning="YES"><BuildableProductRunnable runnableDebuggingMode="0">{ref(a,'app')}</BuildableProductRunnable></ProfileAction><AnalyzeAction buildConfiguration="FieldDebug"/><ArchiveAction buildConfiguration="OrchardRelease" revealArchiveInOrganizer="YES"/></Scheme>''')
print('Generated',len(objects),'unique project objects')
