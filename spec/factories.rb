FactoryBot.define do

	factory :user do
		sequence(:username, 200) { |n| "person#{n}mm" }
		sequence(:email, 200) { |n| "dd#{n}@example.com" }
		password { "123" }
		factory :user_with_ratings do
			transient do
				ratings_count { 5 }
			end
			after(:create) do |user, evaluator|
				create_list(:rating, evaluator.ratings_count, user: user)
			end
		end

		
	   
	end

	factory :app do
		name { "Dota 2" }
		description { "Dota 2 es un videojuego perteneciente al género de Arena de batalla" }
		git_url { "https://github.com/JorgeVasquezF/APIOpenGlove/" }
		video_url { "https://www.youtube.com/embed/6wlvYh0h63k" }
		documentation { "doc" }
		image_url { "https://images-eds-ssl.xboxlive.com/image?url=8Oaj9Ryq1G1_p3lLnXlsaZgGzAie6Mnu24_PawYuDYIoH77pJ.X5Z.MqQPibUVTcRdpxbH0rWzcOGrAKpSD.0JgpT1S5NK.jeCFmJmS4NxjoJSejAhRtHojJG9IH1iiRS8fHD3cyJaDufZJbW5vOMc8Nc4PaQlPVOSndGUg_xEScGFXfGKSebd97WM4.p102OHgYGNSHANrC48PvfPnyNgcE.PHOuMSp7OrHnXdHasU-&h=1080&w=1920&format=jpg" }
		os { "Windows"}
		user_ids {  }
	end

	factory :rating do
		rating { 3 }
		comment { "Todo bien" }
		user_id { 13 }
		app
	end

	factory :tag do
		name { "Juego" }
	end

	factory :check do
		user_id { }
		app_id { }
		role { 1 }
	end
		
end
