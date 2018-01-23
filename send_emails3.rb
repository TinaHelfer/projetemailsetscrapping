require "google_drive"
require 'gmail'

# retourne le corps du message sous forme d'une chaîne de caractères au format html
def get_the_email_html(ville)
    content_type 'text/html; charset=UTF-8'
    return "<p>Bonjour<br/>
    Je m'appelle Théophile, je suis élève à la formation de code gratuite,
    ouverte à tous, sans restriction géographique, ni restriction de niveau.<br/>

    La formation s'appelle The Hacking Project (http://thehackingproject.org/).<br/>
    Nous vous contactons pour vous parlez du projet, et vous dire que vous pouvez
    ouvrir une cellule à #{ville}.
    Nous serions ravis de travailler avec #{ville} !<br/>

    Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos
    questions : 06.95.46.60.80.<br/>

    Cordialement Théophile</p>"
end

# gmail envoie un mail à l'adresse donnée par la ligne row du tableau ws
def send_email_to_line(gmail, ws, row)
   email = gmail.compose do
   to ws[row,2]
   subject "thp"
   body get_the_email_html(ws[row,1])
end
   email.deliver # or: gmail.deliver(email)
end


session = GoogleDrive::Session.from_config("")

ws = session.spreadsheet_by_key("").worksheets[0] # annuaire email

gmail =  Gmail.connect("theophile.countaind@gmail.com","")

(1..ws.num_rows).each do |row|
  send_email_to_line(gmail, ws, row)
end
gmail.logout
