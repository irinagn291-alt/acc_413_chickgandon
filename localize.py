from pathlib import Path
import json,re
r=Path(__file__).resolve().parent
pairs=r'''Add bird|Vogel hinzufügen|Ajouter une poule|Adicionar ave
Add care reminder|Pflege planen|Planifier un soin|Agendar cuidado
Add feed|Futter hinzufügen|Ajouter un aliment|Adicionar ração
Added|Hinzugefügt|Ajouté le|Adicionado
Adjust count|Anzahl ändern|Ajuster le nombre|Ajustar quantidade
Alerts are off|Hinweise sind aus|Alertes désactivées|Alertas desativados
Alerts enabled|Hinweise aktiviert|Alertes activées|Alertas ativados
Chickgandon|Chickgandon|Chickgandon|Chickgandon
Bird card|Vogelkarte|Fiche de l’oiseau|Ficha da ave
Bird details|Vogeldaten|Détails de l’oiseau|Dados da ave
Birds|Vögel|Oiseaux|Aves
Breed|Rasse|Race|Raça
Breed not recorded|Rasse nicht erfasst|Race non renseignée|Raça não informada
Cancel|Abbrechen|Annuler|Cancelar
Care|Pflege|Soins|Cuidados
Care calendar|Pflegekalender|Calendrier des soins|Calendário de cuidados
Care due|Pflege fällig|Soins à faire|Cuidados pendentes
Care notifications|Pflegehinweise|Alertes de soins|Alertas de cuidados
Care reminder|Pflegeerinnerung|Rappel de soin|Lembrete de cuidado
Care today|Pflege heute|Soins du jour|Cuidados de hoje
Category|Kategorie|Catégorie|Categoria
Choose bird photo|Vogelfoto auswählen|Choisir une photo|Escolher foto da ave
Collect eggs|Eier einsammeln|Ramasser les œufs|Coletar ovos
Collection date|Sammeldatum|Date de collecte|Data da coleta
Complete care|Pflege abschließen|Terminer le soin|Concluir cuidado
Days|Tage|Jours|Dias
Delete record|Eintrag löschen|Supprimer la fiche|Excluir registro
Delete this record?|Diesen Eintrag löschen?|Supprimer cette fiche ?|Excluir este registro?
Done|Fertig|Terminé|Concluído
Due|Fällig|Échéance|Prazo
Egg collection|Eiersammlung|Collecte d’œufs|Coleta de ovos
Egg count|Eieranzahl|Nombre d’œufs|Quantidade de ovos
Egg journal|Eiertagebuch|Journal de ponte|Diário de postura
Eggs|Eier|Œufs|Ovos
Eggs collected|Gesammelte Eier|Œufs récoltés|Ovos coletados
Enable care alerts|Pflegehinweise aktivieren|Activer les alertes|Ativar alertas
Every egg, accounted for.|Jedes Ei im Blick.|Chaque œuf compte.|Cada ovo registrado.
Export report|Bericht exportieren|Exporter le rapport|Exportar relatório
Feed|Futter|Aliments|Ração
Feed & health library|Futter- und Gesundheitswissen|Alimentation et santé|Alimentação e saúde
Feed & supplies|Futter & Vorrat|Aliments et réserves|Ração e estoque
Feed entry|Futtereintrag|Fiche d’aliment|Registro de ração
Feed name|Futtername|Nom de l’aliment|Nome da ração
Feed needed|Futterbedarf|Aliment nécessaire|Ração necessária
Feed store|Futtervorrat|Réserve d’aliments|Estoque de ração
Feed used (kg)|Futterverbrauch (kg)|Aliment utilisé (kg)|Ração usada (kg)
Field guide|Praxisratgeber|Guide pratique|Guia prático
Flock|Bestand|Basse-cour|Plantel
Good feed. Healthy hens.|Gutes Futter. Gesunde Hennen.|Bien nourries, en bonne santé.|Boa ração. Galinhas saudáveis.
Grams per bird / day|Gramm pro Vogel / Tag|Grammes par oiseau / jour|Gramas por ave / dia
Guide|Ratgeber|Guide|Guia
Hatch date|Schlupfdatum|Date d’éclosion|Data de nascimento
Include completed|Erledigte anzeigen|Inclure les soins terminés|Incluir concluídos
Journal|Tagebuch|Journal|Diário
Last 7 days|Letzte 7 Tage|7 derniers jours|Últimos 7 dias
Log eggs|Eier erfassen|Noter les œufs|Registrar ovos
Name|Name|Nom|Nome
No care due|Keine Pflege fällig|Aucun soin à faire|Nenhum cuidado pendente
Notes|Notizen|Notes|Anotações
OK|OK|OK|OK
Open device Settings|Geräteeinstellungen öffnen|Ouvrir les réglages|Abrir ajustes do aparelho
Privacy|Datenschutz|Confidentialité|Privacidade
Privacy & app information|Datenschutz & App-Info|Confidentialité et application|Privacidade e informações
Private by nature. Works offline.|Privat. Auch offline nutzbar.|Privé par nature. Disponible hors ligne.|Privado por natureza. Funciona offline.
Quantity (kg)|Menge (kg)|Quantité (kg)|Quantidade (kg)
Ration planner|Futterplaner|Calcul de ration|Calculadora de ração
Read the source|Quelle lesen|Lire la source|Ler a fonte
Record feed used|Futterverbrauch erfassen|Noter la consommation|Registrar uso de ração
Reference|Quelle|Référence|Referência
Remove photo|Foto entfernen|Retirer la photo|Remover foto
Repeat every (days)|Wiederholung (Tage)|Répéter tous les (jours)|Repetir a cada (dias)
Save|Speichern|Enregistrer|Salvar
Search the guide|Ratgeber durchsuchen|Rechercher dans le guide|Buscar no guia
Season|Jahreszeit|Saison|Estação
Seasonal checklist|Saisonale Checkliste|Liste de saison|Lista sazonal
Send to Apple Reminders|An Apple Erinnerungen senden|Envoyer vers Rappels Apple|Enviar ao Lembretes da Apple
Settings|Einstellungen|Réglages|Ajustes
Show all dates|Alle Termine anzeigen|Afficher toutes les dates|Mostrar todas as datas
Stored on this device|Auf diesem Gerät gespeichert|Enregistré sur cet appareil|Salvo neste aparelho
Sync now|Jetzt synchronisieren|Synchroniser|Sincronizar agora
Sync with iCloud|Mit iCloud synchronisieren|Synchroniser avec iCloud|Sincronizar com iCloud
Syncing with iCloud…|iCloud wird synchronisiert…|Synchronisation iCloud…|Sincronizando com iCloud…
Take bird photo|Vogel fotografieren|Photographier l’oiseau|Fotografar ave
Task name|Aufgabe|Nom de la tâche|Nome da tarefa
Up to date in iCloud|In iCloud aktuell|À jour dans iCloud|Atualizado no iCloud
Weekly eggs|Eier diese Woche|Œufs de la semaine|Ovos da semana
YOUR LITTLE FARM|DEIN KLEINER HOF|VOTRE PETITE FERME|SUA PEQUENA CRIAÇÃO
Your birds|Deine Vögel|Vos oiseaux|Suas aves
Your data|Deine Daten|Vos données|Seus dados
Your flock care is due.|Zeit für die Pflege deiner Vögel.|Il est temps de soigner vos oiseaux.|Está na hora de cuidar das suas aves.
iCloud journal|iCloud-Tagebuch|Journal iCloud|Diário no iCloud
kg in store|kg im Vorrat|kg en réserve|kg no estoque
reminders|Erinnerungen|rappels|lembretes
Spring|Frühling|Printemps|Primavera
Summer|Sommer|Été|Verão
Autumn|Herbst|Automne|Outono
Winter|Winter|Hiver|Inverno
Feeding|Fütterung|Alimentation|Alimentação
Health check|Gesundheitskontrolle|Contrôle de santé|Exame de saúde
Other|Sonstiges|Autre|Outro
Check shade and water|Schatten und Wasser prüfen|Vérifier l’ombre et l’eau|Verificar sombra e água
Inspect for mites|Auf Milben prüfen|Rechercher des acariens|Verificar ácaros
Keep feed cool and dry|Futter kühl und trocken lagern|Garder l’aliment au frais et au sec|Manter ração fresca e seca
Check shelter for drafts|Stall auf Zugluft prüfen|Vérifier les courants d’air|Verificar correntes de ar
Inspect roof and fencing|Dach und Zaun prüfen|Inspecter toit et clôtures|Inspecionar telhado e cercas
Review feed supplies|Futtervorräte prüfen|Vérifier les réserves d’aliments|Revisar estoque de ração
Keep drinking water unfrozen|Trinkwasser eisfrei halten|Éviter le gel de l’eau|Evitar congelamento da água
Keep bedding dry|Einstreu trocken halten|Garder la litière sèche|Manter a cama seca
Check ventilation daily|Belüftung täglich prüfen|Vérifier l’aération chaque jour|Verificar ventilação diariamente
Deep clean the coop|Stall gründlich reinigen|Nettoyer le poulailler à fond|Limpar bem o galinheiro
Inspect birds and bedding|Vögel und Einstreu prüfen|Inspecter oiseaux et litière|Inspecionar aves e cama
Check predator barriers|Raubtierschutz prüfen|Vérifier la protection contre les prédateurs|Verificar proteção contra predadores
Make room for your flock|Platz für deinen Bestand|Accueillez votre basse-cour|Crie espaço para seu plantel
Add your first bird with a name, breed and hatch date. Your records stay on this device.|Erfasse deinen ersten Vogel mit Name, Rasse und Schlupfdatum. Die Daten bleiben auf diesem Gerät.|Ajoutez votre premier oiseau avec son nom, sa race et sa date d’éclosion. Les données restent sur cet appareil.|Adicione a primeira ave com nome, raça e data de nascimento. Os dados ficam neste aparelho.
Your egg diary starts here|Hier beginnt dein Eiertagebuch|Votre journal commence ici|Seu diário começa aqui
Record each collection. The chart totals all collections for each day.|Erfasse jede Sammlung. Das Diagramm summiert alle Sammlungen pro Tag.|Notez chaque collecte. Le graphique totalise les collectes de chaque jour.|Registre cada coleta. O gráfico soma todas as coletas de cada dia.
Keep an eye on supplies|Vorräte im Blick behalten|Gardez un œil sur les réserves|Acompanhe seus suprimentos
Add the feed you have in storage, then record what you use.|Erfasse deinen Futtervorrat und trage den Verbrauch ein.|Ajoutez votre réserve d’aliments, puis notez la consommation.|Adicione a ração em estoque e registre o consumo.
A little care goes a long way|Kleine Pflege, große Wirkung|Des soins réguliers font la différence|Pequenos cuidados fazem diferença
Plan feeding, egg collection or a health check. Alerts are optional; the calendar always works offline.|Plane Fütterung, Eiersammlung oder Gesundheitskontrollen. Hinweise sind optional; der Kalender funktioniert offline.|Planifiez repas, collecte d’œufs et contrôles de santé. Les alertes sont facultatives ; le calendrier fonctionne hors ligne.|Planeje alimentação, coleta de ovos e exames de saúde. Os alertas são opcionais; o calendário funciona offline.
Choose the season where you live. Checks are kept for the current year.|Wähle deine örtliche Jahreszeit. Die Häkchen gelten für das aktuelle Jahr.|Choisissez votre saison locale. Les validations sont conservées pour l’année en cours.|Escolha a estação da sua região. As marcações ficam salvas para o ano atual.
For adult laying hens on complete layer feed. Adjust to the feed label, bird condition and local advice.|Für erwachsene Legehennen mit Alleinfutter. An Futteretikett, Tierzustand und örtliche Beratung anpassen.|Pour les pondeuses adultes nourries avec un aliment complet. Adaptez selon l’étiquette, l’état des oiseaux et les conseils locaux.|Para poedeiras adultas com ração completa. Ajuste conforme o rótulo, a condição das aves e a orientação local.
Baseline: 115 g per hen daily. This is a planning estimate, not a feed formulation.|Richtwert: 115 g je Henne täglich. Eine Planungshilfe, keine Futterrezeptur.|Base : 115 g par poule et par jour. Estimation de planification, pas une formule d’aliment.|Base: 115 g por galinha ao dia. Estimativa para planejamento, não uma fórmula de ração.
The amount is deducted from your oldest feed entries first.|Die Menge wird zuerst von den ältesten Vorräten abgezogen.|La quantité est d’abord déduite des plus anciennes réserves.|A quantidade é descontada primeiro dos registros mais antigos.
0 means once. The next reminder is created when you complete this one.|0 bedeutet einmalig. Der nächste Termin entsteht beim Abschließen dieses Eintrags.|0 signifie une seule fois. Le prochain rappel est créé quand vous terminez celui-ci.|0 significa uma vez. O próximo lembrete é criado ao concluir este.
Sending creates or updates a copy in Apple Reminders. Your local schedule also works without access.|Erstellt oder aktualisiert eine Kopie in Apple Erinnerungen. Der lokale Plan funktioniert auch ohne Zugriff.|Crée ou met à jour une copie dans Rappels Apple. Le planning local fonctionne aussi sans accès.|Cria ou atualiza uma cópia no Lembretes da Apple. A agenda local funciona sem acesso.
Saved to Apple Reminders. Future edits there do not change this journal.|In Apple Erinnerungen gespeichert. Dortige Änderungen ändern dieses Tagebuch nicht.|Enregistré dans Rappels Apple. Les modifications faites là-bas ne changent pas ce journal.|Salvo no Lembretes da Apple. Alterações feitas lá não mudam este diário.
Repeating care creates the next due date when completed. Up to 60 upcoming alerts are scheduled; opening the app refreshes them.|Wiederholte Pflege erzeugt beim Abschließen den nächsten Termin. Bis zu 60 Hinweise werden geplant und beim Öffnen aktualisiert.|Un soin récurrent crée la prochaine échéance une fois terminé. Jusqu’à 60 alertes sont programmées, puis actualisées à l’ouverture.|Cuidados recorrentes criam a próxima data ao concluir. Até 60 alertas são agendados e atualizados ao abrir o app.
Get a local alert at each care time. Permission is optional and can be changed in device Settings.|Erhalte lokale Hinweise zur Pflegezeit. Die Erlaubnis ist optional und in den Geräteeinstellungen änderbar.|Recevez une alerte locale à l’heure des soins. L’autorisation est facultative et modifiable dans les réglages.|Receba um alerta local no horário de cada cuidado. A permissão é opcional e pode ser alterada nos ajustes.
Sync uses your private iCloud storage. The newest edit wins for each record. Records and photos are always kept locally; sync errors never remove them.|Die Synchronisierung nutzt deinen privaten iCloud-Speicher. Pro Eintrag gilt die neueste Änderung. Daten und Fotos bleiben lokal; Fehler löschen sie nicht.|La synchronisation utilise votre espace iCloud privé. La dernière modification de chaque fiche prévaut. Fiches et photos restent aussi en local, même en cas d’erreur.|A sincronização usa seu espaço privado no iCloud. A edição mais recente prevalece em cada registro. Registros e fotos ficam locais, mesmo com erros.
Sign in to iCloud to sync. Local records are safe.|Für die Synchronisierung bei iCloud anmelden. Lokale Daten bleiben erhalten.|Connectez-vous à iCloud pour synchroniser. Les données locales sont conservées.|Entre no iCloud para sincronizar. Os registros locais estão seguros.
iCloud account changed. Sync is paused to protect this journal.|iCloud-Konto geändert. Die Synchronisierung pausiert zum Schutz des Tagebuchs.|Le compte iCloud a changé. La synchronisation est suspendue pour protéger le journal.|A conta iCloud mudou. A sincronização foi pausada para proteger o diário.
iCloud is unavailable. Everything stays on this device.|iCloud nicht verfügbar. Alles bleibt auf diesem Gerät.|iCloud est indisponible. Tout reste sur cet appareil.|iCloud indisponível. Tudo fica neste aparelho.
A camera is not available on this device.|Dieses Gerät hat keine verfügbare Kamera.|La caméra est indisponible sur cet appareil.|A câmera não está disponível neste aparelho.
Camera access is off. Choose a photo or enable the camera in device Settings.|Kamerazugriff aus. Foto auswählen oder Kamera in den Geräteeinstellungen aktivieren.|Accès caméra désactivé. Choisissez une photo ou activez la caméra dans les réglages.|Acesso à câmera desativado. Escolha uma foto ou ative a câmera nos ajustes.
This photo could not be opened.|Dieses Foto konnte nicht geöffnet werden.|Impossible d’ouvrir cette photo.|Não foi possível abrir esta foto.
Could not create the report.|Bericht konnte nicht erstellt werden.|Impossible de créer le rapport.|Não foi possível criar o relatório.
Could not read the local journal. Your file was kept.|Lokales Tagebuch nicht lesbar. Die Datei wurde bewahrt.|Lecture du journal local impossible. Votre fichier a été conservé.|Não foi possível ler o diário local. Seu arquivo foi mantido.
Could not save. Please check available device storage.|Speichern fehlgeschlagen. Bitte freien Gerätespeicher prüfen.|Enregistrement impossible. Vérifiez l’espace libre de l’appareil.|Não foi possível salvar. Verifique o espaço livre no aparelho.
Could not write to Apple Reminders. Your local care record is safe.|Schreiben in Apple Erinnerungen fehlgeschlagen. Die lokale Pflege bleibt erhalten.|Écriture dans Rappels Apple impossible. Votre soin local est conservé.|Não foi possível gravar no Lembretes da Apple. Seu registro local está seguro.
Create a list in Apple Reminders first.|Zuerst eine Liste in Apple Erinnerungen erstellen.|Créez d’abord une liste dans Rappels Apple.|Crie primeiro uma lista no Lembretes da Apple.
Reminders access was declined. Your care schedule remains available here.|Zugriff auf Erinnerungen abgelehnt. Der Pflegeplan bleibt hier verfügbar.|Accès aux rappels refusé. Votre planning reste disponible ici.|Acesso ao Lembretes recusado. Sua agenda continua disponível aqui.
Notifications are off. Care stays in the app; you can enable alerts in Settings.|Hinweise aus. Pflege bleibt in der App; Hinweise in Einstellungen aktivierbar.|Alertes désactivées. Les soins restent dans l’app ; activez les alertes dans les réglages.|Alertas desativados. Os cuidados ficam no app; ative os alertas nos ajustes.
Notifications are unavailable. Care stays saved locally.|Hinweise nicht verfügbar. Pflege bleibt lokal gespeichert.|Alertes indisponibles. Les soins restent enregistrés en local.|Alertas indisponíveis. Os cuidados ficam salvos localmente.
Egg totals, feed supplies and the care your flock needs today.|Eierzahlen, Futtervorräte und die Pflege für deinen Bestand heute.|Totaux d’œufs, réserves d’aliments et soins de votre basse-cour aujourd’hui.|Total de ovos, estoque de ração e cuidados do plantel para hoje.
'''
D={}
for line in pairs.strip().splitlines():
 parts=line.split('|'); assert len(parts)==4,line
 D[parts[0]]=parts
D['Enter 1–500 grams']=['Enter 1–500 grams','1–500 Gramm eingeben','Saisir 1 à 500 grammes','Informe 1–500 gramas']
D['A good day\nfor your flock.']=['A good day\nfor your flock.','Ein guter Tag\nfür deinen Bestand.','Une belle journée\npour vos oiseaux.','Um bom dia\npara suas aves.']
D['A field guide\nfor everyday care.']=['A field guide\nfor everyday care.','Praxiswissen\nfür jeden Tag.','Un guide pratique\npour chaque jour.','Um guia prático\npara todo dia.']
D['Little routines,\nlasting wellbeing.']=['Little routines,\nlasting wellbeing.','Kleine Routinen,\ndauerhaftes Wohlbefinden.','Petits gestes,\nbien-être durable.','Pequenas rotinas,\nbem-estar duradouro.']
privacy='No ads, purchases, analytics or tracking. Flock photos, notes and care records stay on your device. If enabled, iCloud stores them in your private Apple account. Apple Reminders receives only care items you choose to send. Shared reports are controlled by you. Delete any record from its edit screen. No account is required. The field guide is educational and does not diagnose illness; contact a poultry veterinarian for sick birds.'
D[privacy]=[privacy,'Keine Werbung, Käufe, Analyse oder Tracking. Fotos, Notizen und Pflege bleiben auf deinem Gerät. Optional speichert iCloud sie in deinem privaten Apple-Konto. Apple Erinnerungen erhält nur die von dir gesendeten Pflegeaufgaben. Du entscheidest, mit wem du Berichte teilst. Einträge lassen sich im Bearbeitungsfenster löschen. Kein Konto nötig. Der Ratgeber dient der Information und stellt keine Diagnose. Bei kranken Vögeln einen Geflügeltierarzt kontaktieren.','Aucune publicité, achat, analyse ni suivi. Photos, notes et soins restent sur votre appareil. Si activé, iCloud les stocke dans votre compte Apple privé. Rappels Apple reçoit uniquement les soins que vous envoyez. Vous contrôlez le partage des rapports. Supprimez une fiche depuis son écran d’édition. Aucun compte requis. Le guide est éducatif et ne pose pas de diagnostic ; consultez un vétérinaire aviaire pour tout oiseau malade.','Sem anúncios, compras, análise ou rastreamento. Fotos, anotações e cuidados ficam no aparelho. Se ativado, o iCloud os armazena na sua conta Apple privada. O Lembretes da Apple recebe só os cuidados que você envia. Você controla o compartilhamento dos relatórios. Exclua registros na tela de edição. Não é preciso criar conta. O guia é educativo e não diagnostica doenças; procure um veterinário de aves em caso de doença.']
articles=[
('complete','leaf.fill','Complete layer feed',[
'Use a complete feed labelled for adult laying hens. A useful planning baseline is about 115 g per hen daily; real intake varies with breed, temperature and production. Follow the feed label and monitor body condition. Do not give high-calcium layer feed to growing chicks. Keep fresh water available.',
'Für erwachsene Legehennen ein entsprechendes Alleinfutter verwenden. Etwa 115 g pro Henne täglich sind ein Planungsrichtwert; Aufnahme hängt von Rasse, Temperatur und Legeleistung ab. Futteretikett beachten und Körperzustand prüfen. Küken kein kalziumreiches Legefutter geben. Stets frisches Wasser anbieten.',
'Utilisez un aliment complet pour pondeuses adultes. Environ 115 g par poule et par jour servent de base ; la consommation varie selon la race, la température et la ponte. Suivez l’étiquette et surveillez l’état corporel. Ne donnez pas d’aliment riche en calcium aux poussins. Laissez de l’eau fraîche disponible.',
'Use ração completa para poedeiras adultas. Cerca de 115 g por galinha ao dia é uma base de planejamento; o consumo varia com raça, temperatura e postura. Siga o rótulo e observe a condição corporal. Não dê ração rica em cálcio a pintinhos. Mantenha água fresca disponível.'],['Legehennen richtig füttern','Aliment complet pour pondeuses','Ração completa para poedeiras'],'https://www.aces.edu/blog/topics/farming/backyard-small-poultry-flock-management-series-feeding-the-laying-hen/'),
('bio','shield.lefthalf.filled','Everyday biosecurity',[
'Keep wild birds and rodents away from feed and water. Use dedicated coop footwear and wash hands after handling birds or equipment. Keep new arrivals separate and ask a veterinarian about a suitable quarantine plan. Clean drinkers and keep bedding dry. Avoid sharing equipment between flocks.',
'Wildvögel und Nager von Futter und Wasser fernhalten. Eigene Stallschuhe tragen und nach Kontakt Hände waschen. Neuzugänge getrennt halten und tierärztlich zur Quarantäne beraten lassen. Tränken reinigen und Einstreu trocken halten. Geräte nicht zwischen Beständen teilen.',
'Éloignez oiseaux sauvages et rongeurs des aliments et de l’eau. Portez des chaussures réservées au poulailler et lavez-vous les mains après contact. Isolez les nouveaux arrivants et demandez un plan de quarantaine au vétérinaire. Nettoyez les abreuvoirs et gardez la litière sèche. Ne partagez pas le matériel entre élevages.',
'Afaste aves silvestres e roedores da ração e da água. Use calçados exclusivos no galinheiro e lave as mãos após contato. Separe aves recém-chegadas e consulte o veterinário sobre quarentena. Limpe bebedouros e mantenha a cama seca. Evite compartilhar equipamentos entre criações.'],['Biosicherheit im Alltag','Biosécurité au quotidien','Biossegurança no dia a dia'],'https://extension.umn.edu/agriculture/animals-and-livestock/poultry/raising-chickens-for-eggs'),
('resp','cross.case','Respiratory warning signs',[
'Wheezing, repeated sneezing, discharge, reduced appetite or unusual quietness need attention. Separate an unwell bird, provide water and contact a poultry veterinarian. Breathing difficulty or sudden deaths require urgent advice. A journal cannot identify the cause; do not choose medicines from symptoms alone.',
'Röcheln, häufiges Niesen, Ausfluss, Appetitverlust oder ungewöhnliche Ruhe beachten. Kranke Vögel absondern, Wasser anbieten und einen Geflügeltierarzt kontaktieren. Atemnot oder plötzliche Todesfälle sind dringend. Ein Tagebuch erkennt keine Ursache; Medikamente nicht allein nach Symptomen wählen.',
'Respiration bruyante, éternuements répétés, écoulements, perte d’appétit ou calme inhabituel demandent de l’attention. Isolez l’oiseau, fournissez de l’eau et contactez un vétérinaire aviaire. Difficultés respiratoires ou morts soudaines sont urgentes. Un journal ne détermine pas la cause ; ne choisissez pas de médicament sur les seuls symptômes.',
'Chiado, espirros repetidos, secreção, falta de apetite ou quietude incomum merecem atenção. Separe a ave doente, ofereça água e contate um veterinário de aves. Dificuldade para respirar ou mortes súbitas exigem orientação urgente. O diário não identifica a causa; não escolha remédios só pelos sintomas.'],['Warnzeichen der Atmung','Signes respiratoires à surveiller','Sinais respiratórios de alerta'],'https://extension.umn.edu/agriculture/animals-and-livestock/poultry/raising-chickens-for-eggs'),
('parasite','magnifyingglass','Mites and parasites',[
'Check feather bases, skin and coop crevices for irritation or tiny moving specks. Pale combs, feather damage and reduced laying can have many causes. Record what you see and ask a poultry veterinarian to identify the problem before treatment. Keep bedding clean and inspect the rest of the flock.',
'Federansätze, Haut und Stallritzen auf Reizung oder kleine bewegliche Punkte prüfen. Blasse Kämme, Federschäden und weniger Eier können viele Ursachen haben. Beobachtungen notieren und vor Behandlung tierärztlich abklären lassen. Einstreu sauber halten und übrige Vögel prüfen.',
'Inspectez la base des plumes, la peau et les fissures du poulailler. Une crête pâle, des plumes abîmées et une baisse de ponte ont plusieurs causes possibles. Notez vos observations et faites identifier le problème par un vétérinaire avant traitement. Gardez la litière propre et examinez les autres oiseaux.',
'Examine a base das penas, a pele e frestas do galinheiro. Cristas pálidas, penas danificadas e queda na postura podem ter várias causas. Anote o que observa e peça diagnóstico veterinário antes de tratar. Mantenha a cama limpa e examine as outras aves.'],['Milben und Parasiten','Acariens et parasites','Ácaros e parasitas'],'https://extension.umn.edu/agriculture/animals-and-livestock/poultry/raising-chickens-for-eggs'),
('lay','oval.portrait','Changes in laying',[
'Age, moulting, daylight, stress and nutrition can change egg numbers. Compare daily records over several weeks rather than assuming disease from one low day. Straining, weakness or a swollen abdomen need prompt veterinary assessment. Do not attempt to remove an egg yourself.',
'Alter, Mauser, Tageslicht, Stress und Ernährung verändern die Legeleistung. Mehrere Wochen vergleichen, statt einen schwachen Tag als Krankheit zu deuten. Pressen, Schwäche oder ein geschwollener Bauch erfordern rasche tierärztliche Abklärung. Nicht selbst ein Ei entfernen.',
'L’âge, la mue, la lumière, le stress et l’alimentation influencent la ponte. Comparez plusieurs semaines au lieu de conclure à une maladie après une seule baisse. Efforts de ponte, faiblesse ou abdomen gonflé nécessitent rapidement un vétérinaire. Ne tentez pas de retirer un œuf vous-même.',
'Idade, muda, luz, estresse e alimentação mudam a postura. Compare registros de várias semanas, sem presumir doença por um único dia baixo. Esforço para pôr, fraqueza ou abdômen inchado exigem avaliação veterinária rápida. Não tente retirar um ovo por conta própria.'],['Veränderte Legeleistung','Variations de ponte','Mudanças na postura'],'https://www.merckvetmanual.com/exotic-and-laboratory-animals/backyard-poultry/management-of-backyard-poultry'),
('flu','exclamationmark.shield','Sudden illness in the flock',[
'Sudden deaths, severe breathing trouble or several sick birds at once need urgent veterinary advice. Keep people and equipment from moving between flocks. Contact your local animal-health authority about current avian influenza guidance and reporting rules. The offline guide does not provide current outbreak status.',
'Plötzliche Todesfälle, schwere Atemnot oder mehrere kranke Vögel zugleich brauchen sofort tierärztliche Hilfe. Personen und Geräte nicht zwischen Beständen bewegen. Bei der örtlichen Tiergesundheitsbehörde aktuelle Hinweise zur Vogelgrippe und Meldepflicht erfragen. Dieser Offline-Ratgeber zeigt keine aktuelle Seuchenlage.',
'Morts soudaines, forte gêne respiratoire ou plusieurs oiseaux malades à la fois exigent un avis vétérinaire urgent. Évitez les déplacements de personnes et de matériel entre élevages. Contactez l’autorité sanitaire animale pour les consignes et déclarations liées à la grippe aviaire. Ce guide hors ligne ne donne pas l’état actuel des foyers.',
'Mortes súbitas, dificuldade respiratória grave ou várias aves doentes ao mesmo tempo exigem orientação veterinária urgente. Evite circulação de pessoas e equipamentos entre plantéis. Consulte o serviço local de saúde animal sobre influenza aviária e regras de notificação. Este guia offline não informa surtos atuais.'],['Plötzliche Erkrankung im Bestand','Maladie soudaine du groupe','Doença súbita no plantel'],'https://www.bah.state.mn.us/sites/default/files/documents/Biosecurity-Guide-Checklist.pdf')]
out=[]
for id,icon,title,texts,titles,url in articles:
 D[title]=[title]+titles;D[texts[0]]=texts;out.append(dict(id=id,icon=icon,title=title,body=texts[0],source=url))
(r/'Resources/FieldNotes.json').write_text(json.dumps(out,ensure_ascii=False,indent=2))
s='\n'.join(x.read_text() for x in r.glob('**/*.swift'))
keys={json.loads('"'+x+'"') for x in re.findall(r'h7\("((?:[^"\\]|\\.)*)"\)',s)}
missing=keys-D.keys();assert not missing,missing
langs=['en','de','fr','pt-BR']
strings={k:{'extractionState':'manual','localizations':{lang:{'stringUnit':{'state':'translated','value':v[i]}} for i,lang in enumerate(langs)}} for k,v in sorted(D.items())}
(r/'Resources/Localizable.xcstrings').write_text(json.dumps({'sourceLanguage':'en','strings':strings,'version':'1.0'},ensure_ascii=False,indent=2))
info={
'NSCameraUsageDescription':['Take a portrait to recognize a bird in your flock journal.','Fotografiere einen Vogel, um ihn im Bestandstagebuch zu erkennen.','Prenez un portrait pour reconnaître un oiseau dans votre journal.','Fotografe uma ave para reconhecê-la no diário do plantel.'],
'NSPhotoLibraryUsageDescription':['Choose an existing bird picture for its flock card.','Wähle ein vorhandenes Vogelfoto für die Bestandskarte.','Choisissez une photo existante pour la fiche de l’oiseau.','Escolha uma foto existente para a ficha da ave.'],
'NSRemindersUsageDescription':['Copy selected poultry care tasks into your Apple Reminders lists.','Übertrage ausgewählte Pflegeaufgaben in deine Apple-Erinnerungslisten.','Copiez les soins choisis dans vos listes Rappels Apple.','Copie os cuidados selecionados para suas listas do Lembretes da Apple.'],
'NSRemindersFullAccessUsageDescription':['Save and update the poultry care tasks you choose in Apple Reminders.','Speichere und aktualisiere selbst gewählte Geflügelpflege in Apple Erinnerungen.','Enregistrez et actualisez les soins choisis dans Rappels Apple.','Salve e atualize os cuidados de aves escolhidos no Lembretes da Apple.']}
(r/'Resources/InfoPlist.xcstrings').write_text(json.dumps({'sourceLanguage':'en','strings':{k:{'extractionState':'manual','localizations':{lang:{'stringUnit':{'state':'translated','value':v[i]}} for i,lang in enumerate(langs)}} for k,v in info.items()},'version':'1.0'},ensure_ascii=False,indent=2))
print(len(strings),'fully translated keys in',len(langs),'languages')
