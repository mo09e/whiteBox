FactoryBot.define do
  factory :reservation_test, class: Reservation do
    title { 'testtest' }
    start_time { '2020-10-31' }
    end_time { '2020-10-31' }
    artist_id { Artist.find_by(name: "Hamlet").id }
    gallery_id { Gallery.find_by(name: "Macbeth").id }
  end
end
