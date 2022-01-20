# Fern2AutoScalingGroups
Virtp - Fernlehre 2 // Auto Scaling Groups & Terraform Modules / AWS

Infrastructure-as-Code Übung (inkl. ASGs und Terraform Modulen) - in den 2er Gruppen  
Angelehnt an die Übung https://moodle.fh-burgenland.at/mod/url/view.php?id=349125, soll eine Applikation mittels Infrastructure-as-Code/Terraform installiert werden. Es darf die selbe Applikation wie in der ersten Fernlehre verwendet werden, wobei es sich um zwei voneinander unabhängigen Abgaben handelt und die erste Aufgabe mit "simplen" virtuellen Maschinen und die zweite Aufgabe mit Auto-Scaling Groups/Load Balancern und Terraform Modulen zu lösen ist.

Constraints

Die Applikation soll aus mindestens 3 Microservices bzw. VMs bestehen, welche miteinander kommunizieren. Sofern euch bereits elegantere Möglichkeiten bekannt sind, dieses zu bewerkstelligen, könnt ihr eurer Kreativität gerne freien Lauf lassen.
Die Installation erfolgt ausschließlich code-basiert mittels Terraform (sofern sich jemand mit Crossplane/Pulumi befassen möchte, ist dies natürlich auch kein Problem)
Es werden Terraform Module, Auto Scaling Groups und Load Balancer verwendet
Jede Gruppe verwendet eine andere Applikation
Getroffene Annahmen über die Infrastruktur sind dokumentiert
Es ist ohne weiteres möglich, dieses Setup zu reproduzieren
Notwendige Troubleshooting-Maßnahmen meinerseits führen zu erheblichen Punkteabzug 

Deliverable

Der Infrastructure-Code ist in einem GitHub Repository bereitzustellen und mir Zugang dazu zu ermöglichen (mein GitHub Username ist @thschue). Bitte gebt in diesen Zusammenhang auf die Trennung Code/Konfiguration sowie auf Secrets acht, im Klartext eingecheckte Secrets im führen ebenfalls zu Punkteabzug. 
