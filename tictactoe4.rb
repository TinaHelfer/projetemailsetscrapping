require 'scanf' #sert à convertir chaque type(entier,chaînes de caractères)

class BoardCase #définit la classe des cases et leur valeur (X, O, ou vide) et leur numéro de case
  def valeur
     @valeur
   end
  
   def valeur=(val)
      @valeur=val
    end

  def initialize #règle sa valeur
    @valeur = ' '
  end
  
  def to_s #renvoie la valeur au format string
    s = " "+@valeur+" "
    print s
  end
end


class Board 
  def damier
     @damier
   end

  def initialize #Quand la classe s'initialise, elle crée 9 instances BoardCases
    @damier = [[BoardCase.new,BoardCase.new,BoardCase.new],
               [BoardCase.new,BoardCase.new,BoardCase.new],
               [BoardCase.new,BoardCase.new,BoardCase.new]]
  end

   def setDamier(l,c,val)
     @damier[l][c].valeur = val
   end


  def to_s #affiche le plateau et les numéros de case
    i = 0
    print "\n"
    while i<@damier.length do
      print "#{i+1}: "
      print @damier[i][0].to_s
      print "|"
      print @damier[i][1].to_s
      print "|"
      print @damier[i][2].to_s
      print "\n"
      if i<2 then
        print "   ","-"*11,"\n"
        
      else
        print "    1   2   3\n"
      end
      i = i+1
    end
  end
  
  def configGagnante(val) #donne les possibilités de configuration gagnante(ligne,colonne,diagonale)
    r = false
    i=0 # ligne
    while i<3 do
      r = r || (@damier[i][0]==val && @damier[i][1]==val && @damier[i][2]==val)
      i = i+1
    end
     i=0 # col
    while i<3 do
      r = r || (@damier[0][i]==val && @damier[1][i]==val && @damier[2][i]==val)
      i = i+1
    end
    r = r || (@damier[0][0]==val && @damier[1][1]==val && @damier[2][2]==val) # diagonale 1
    r = r || (@damier[2][0]==val && @damier[1][1]==val && @damier[0][2]==val) # diagonale 2   
    return r
  end
end


class Player 
   attr_reader :nom, :valeur, :gagne
   def gagne=(newGagne)
     @gagne = newGagne
   end

  def initialize(nom, valeur) #attribuée au joueur, gagne-t-il et avec quelle valeur?
    @nom = nom
    if @valeur == ' ' then
      print "erreur joueur.valeur == \' \'\n"
      abort
    end     
    @valeur = valeur
    @gagne = false
  end
  
  def to_s
    print "#{@nom}: #{@valeur}\n"
  end
end


class Game #crée 2 joueurs et un board
  def initialize(joueur_1,joueur_2)
    @joueur_1 = joueur_1
    @joueur_2 = joueur_2
    if @joueur_1.valeur == @joueur_2.valeur then
      print "erreur game: joueur_1 et joueur_2 meme valeur\n"
      abort
    end     
    @b = Board.new
  end

  def turn(joueur) #affiche le plateau, demande au joueur quelle case veut-il jouer, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    @b.to_s
    print joueur.to_s,": quelle case jouez-vous?\n"
    p = scanf("%d%d")
    if !(1<=p[0] && p[0]<=3) then
      print "erreur game: mauvaise ligne\n"
      abort
    end 
    if !(1<=p[1] && p[1]<=3) then
      print "erreur game: mauvaise colonne\n"
      abort
    end 
    l = p[0]-1
    c = p[1]-1
    if @b.damier[l][c].valeur == ' ' then
      @b.setDamier(l,c,joueur.valeur)
    else
      print "erreur game: mauvaise case\n"
      abort
    end 
    joueur.gagne = @b.configGagnante(joueur.valeur) 
  end

  def go #félicite le joueur gagnant et annonce en cas de match nul
    joueurs = [@joueur_1, @joueur_2]
    i = 0
    while i<9 && !(@joueur_1.gagne || @joueur_2.gagne) do
        turn(joueurs[i%2])
        i = i+1
    end
    if @joueur_1.gagne then
      print "bravo ", @joueur_1.nom,"\n"
    elsif @joueur_2.gagne then
      print "bravo", @joueur_2.nom,"\n"
    else
      print "match nul\n"
    end
  end
 end

joueur_1 = Player.new("Tina",'X')
joueur_2 = Player.new("Tino",'O')
Game.new(joueur_1,joueur_2).go
