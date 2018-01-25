require 'scanf'

class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
  def valeur
     @valeur
   end

  def initialize
    #TO DO doit régler sa valeur, ainsi que son numéro de case
    @valeur = ' '
  end
  
  def to_s
    #TO DO : doit renvoyer la valeur au format string
    s = " "+@valeur+" "
    print s
  end
end


class Board
  #include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  def damier
     @damier
   end

  def initialize
    #TO DO :
    #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    @damier = [[BoardCase.new,BoardCase.new,BoardCase.new],
               [BoardCase.new,BoardCase.new,BoardCase.new],
               [BoardCase.new,BoardCase.new,BoardCase.new]]
  end

   def setDamier(l,c,val)
     @damier[l][c] = val
   end


  def to_s
    #TO DO : afficher le plateau
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
  
  def configGagnante(val)
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
    r = r || (@damier[0][0]==val && @damier[1][1]==val && @damier[2][2]==val)
    r = r || (@damier[2][0]==val && @damier[1][1]==val && @damier[0][2]==val)     
    return r
  end
end


class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
   attr_reader :nom, :valeur, :gagne
   def gagne=(newGagne)
     @gagne = newGagne
   end

  def initialize(nom, valeur)
    #TO DO : doit régler son nom, sa valeur, son état de victoire
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


class Game
  def initialize(joueur_1,joueur_2)
    #TO DO : créé 2 joueurs, créé un board
    @joueur_1 = joueur_1
    @joueur_2 = joueur_2
    if @joueur_1.valeur == @joueur_2.valeur then
      print "erreur game: joueur_1 et joueur_2 meme valeur\n"
      abort
    end     
    @b = Board.new
  end

  def turn(joueur)
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie
    #si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
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

  def go
    # TO DO : lance la partie
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
joueur_2 = Player.new("Barney",'O')
Game.new(joueur_1,joueur_2).go
