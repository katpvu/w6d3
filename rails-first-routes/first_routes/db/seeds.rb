# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#Populating Users table!
    
    ArtworkShare.destroy_all
    Artwork.destroy_all
    User.destroy_all

    puts 'Resetting id sequences...'
    %w(users artworks artwork_shares).each do |table_name|
        ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end

    kat = User.create!( username: "kat123" )

    alex =  User.create!( username: "alex456" ) 

    da_vinki = User.create!( username: "davinki" ) 

    aquaphor = User.create!( username: "aquaphor" )

    mona_lisa = Artwork.create!( {title: "Mona Lisa", image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/1200px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg", artist_id: 3 })

    sharing = ArtworkShare.create!( 
        artwork_id: mona_lisa.id,
        viewer_id: kat.id
        )

    puts "Seeds Complete!"