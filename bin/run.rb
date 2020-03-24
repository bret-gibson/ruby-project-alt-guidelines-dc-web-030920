
require_relative '../config/environment'



  
  def logo
    system "clear"
    puts'        888b    888        888       .d8888b.                 888   d8b .d888         
        8888b   888        888      d88P  Y88b                888   Y8Pd88P"          
        88888b  888        888      Y88b.                     888      888            
        888Y88b 888 .d88b. 888888    "Y888b.  88888b.  .d88b. 888888888888888888  888 
        888 Y88b888d88""88b888          "Y88b.888 "88bd88""88b888   888888   888  888 
        888  Y88888888  888888            "888888  888888  888888   888888   888  888 
        888   Y8888Y88..88PY88b.    Y88b  d88P888 d88PY88..88PY88b. 888888   Y88b 888 
        888    Y888 "Y88P"  "Y888    "Y8888P" 88888P"  "Y88P"  "Y888888888    "Y88888 
                                              888                                 888 
                                              888                            Y8b d88P 
                                              888                             "Y88P"' 
    2.times {puts ""}
end    
#web_request
add_song_from_search
# Menu.welcome
