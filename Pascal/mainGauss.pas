program mainGauss;

uses unitGauss;

var 
X : Integer;
a : matrice;
b : vecteur;

begin
	
	{Exemple Wilson}
	//Définition nombre d'inconnu et d'équation
	writeln('Voici ci-dessous l exemple de Wilson:');
	SetLength(a, 4, 5);
	SetLength(b, 4);
	//Initialisation des deux exemples à traiter
	exempleWilson(a);
	//Iterations pour obtenir les solutions de notre système
	matriceEchelonne(a);
	reponse(a,b);
	mineursPrincipaux(a,b);

	{Exemple Hilbert}
	{writeln('Voici ci-dessous l exemple de Hilbert:');
	//Définition nombre d'inconnu et d'équation
	writeln('Veuillez saisir le nombre d inconnu et d equation connue :');
	read(X);
	SetLength(a, X, X+1);
	SetLength(b, X);
	//Initialisation des deux exemples à traiter
	exempleHilbert(a);
	//Iterations pour obtenir les solutions de notre système
	matriceEchelonne(a);
	reponse(a,b);
	mineursPrincipaux(a,b);}
	
	
	{procedure interessante lorsque les coefficients sont entiers et que l'on veut les
	rentrer au clavier. Les réponses du système seront trouvées rapidement et facilement}
	
	{Explication fonctionnement du remplissage de la matrice}
	{writeln('Vous allez maintenant saisir les coefficients des equations connus.');
	writeln('Afin de comprendre le remplissage de la matrice voici un exemple avec 3 equations/inconnus :');
	writeln(' ');
	writeln(' ax1 + bx2 + cx3 = d');
	writeln(' ex1 + fx2 + gx3 = h');
	writeln(' ix1 + jx2 + kx3 = l');
	writeln(' ');
	writeln('Il va falloir entrer au clavier par ordre alphabetique les coefficients definis ci-dessus.');
	writeln('C est a vous :');}
	//initialisationMatrice(a);
end.
