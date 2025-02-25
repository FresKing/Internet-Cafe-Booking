class Hotel {
  String imgurl;
  String title;
  String description;
  String location;
  int price;
  double rating;

  Hotel(this.imgurl, this.title, this.description, this.location, this.price, this.rating);

 static List<Hotel> hotellist() {
    return [
      Hotel('assets/images/VIP 1.jpg', 'Setup Gaming Futuristik','Boasting a fitness centre, shared lounge and views of city, Empyrean Hotel is set in Dhaka, 1.7 km from Bangladesh University of Textiles. Among the facilities of this property are a restaurant, a 24-hour front desk and room service, along with free WiFi throughout the property. The accommodation offers an ATM, a concierge service and currency exchange for guests.',"",  15000, 4.3),


      Hotel('assets/images/VIP 2.jpg', 'Neon Setup','Located in the prestigious downtown business district, InterContinental Dhaka is the foremost name of luxury. The hotel is beautifully designed boasted with Millennium modern outlook with a touch of local culture. Featuring 226 luxury rooms and suites, a selection of restaurants offering exquisite cuisines. Host your events at the meeting spaces equipped with modern facilities. ', "", 11990 , 4.4),


      Hotel('assets/images/VIP 3.jpg', 'Pan Pacific Sonargaon','Be inspired by the vibrancy surrounding our premier hotel in Dhaka. Located in the heart of the City Centre, our luxurious accommodation offers a calming respite from the hustle and bustle of downtown Dhaka, where contemporary comfort will refresh your senses. We welcome you with our plush rooms, modern amenities and a promise of peace at Pan Pacific Sonargaon Dhaka.', "",  12500, 4.3),


      Hotel('assets/images/VIP 4.jpg', 'Sea Pearl Beach Resort',"Sea Pearl Beach Resort & Spa is located on Inani beach, Cox's Bazar with lush green hills rise from the east and endless sea stretching on the west, the resort offers panoramic visuals of Bay of Bengal. Nestled in the heart of nature along the world’s longest natural sandy beach, the resort is spread over 15 acres", "",  15000, 4.3),

      Hotel('assets/images/VIP 5.jpg', 'The Westin','Conveniently placed just 8 km away from Hazrat Shahjalal International Airport, The Westin Dhaka boasts a spacious swimming pool and offers free Wi-Fi at all areas. It also houses 5 restaurants.Located just 1 km away from Shopper’s World Mall, the property is also a 8 km away from the historical Bahadur Shah Park Memorial.' , "",  10400, 4.2),
    ];
  }

  static List<Hotel> PeoplechoiceList(){
   return[
     Hotel('assets/images/regular 1.jpg', 'Raddison Blu',"As the city’s premier international hotel, the Radisson Blu Chattogram Bay View offers you an unforgettable stay with spectacular views of Chattogram, the Bay of Bengal, and the Hill Tracts. Enjoy posh rooms and suites within walking distance of M. A. Aziz Stadium and landmarks like the Circuit House in this commercial capital. The hotel is just a 10-minute drive from the city’s main business hub and less than 45 minutes from Shah Amanat International Airport" ,  "", 10000, 4.5),

     Hotel('assets/images/regular 2.jpg', 'Renaissance',"Conveniently located in the most dynamic and inspiring neighborhood of Gulshan, Renaissance Dhaka Gulshan Hotel is ideal for business and leisure travelers alike. Enjoy easy access to the Hazrat Shahjalal International Airport, just 20 minutes away, and experience the distinctive local character that dictates the atmosphere and experiences for guests. Discover sophisticated elements and uber design throughout the 211 stylish rooms and suites. The infinity rooftop temperature-controlled pool with a stunning city vista view will take your breath away" , "",  10000, 4.2),

     Hotel('assets/images/regular 3.jpg', 'Sonargaon Royal',"Welcome to Sonargaon Royal ResortWe welcome you to our resort as you enlighten our abode with your warmth and smiley nature. We are truly grateful to you for your visit here and hope to have memorable moments throughout your visit." , "",  10000, 4.1),

     Hotel('assets/images/regular 4.jpg', 'Hotel Grand Park',"Hotel Grand Park Barisal aims to exceed all expectations as we welcome guests from around the globe. With this in mind, you will find our business and recreation facilities prepare you to take on the world - or the bustle of busy city." , "",  10000, 4.1),

     Hotel('assets/images/regular 5.jpg', 'Seagull',"Welcome to SEAGULL HOTEL where business and leisure blend together. Enjoying an unrivalled location, overlooking the Bay of Bengal (only 25 yards from the Bay water) and sitting in the laps of hills, we offer deluxe accommodation in 181 well appointed guest rooms and suites. The panoramic view of the ocean, the majestic hills and the natural beauty of the tamarisk trees are all wonderfully complemented by luxury facilities and Bangladeshi hospitality." , "",  10000, 4.2),

     Hotel('assets/images/regular 6.jpg', 'Grand Sultan', "The one & only five star resort in the Sylhet region of Bangladesh. Equipped with all modern state of the art amenities and facilities, located in Srimongal (the tea capital of Bangladesh), around four hours drive from Dhaka. This resort is the true combination of ultimate luxury, gracious hospitality and admirable greenery. Classified in 08 categories with 135 hotel rooms and suites Grand Sultan welcomes you in Sylhet to enjoy your holiday or vacation with comfort and luxury.",  "", 10000, 4.7),

     Hotel('assets/images/regular 7.jpg', 'Grand Mostofa \n Hotel  Ababil',"A place where traditional meets contemporary. A place to escape, relax, and enjoy. A place to dine with confidence. A place for special occasions. A place to remember. That is Hotel Grand Mostafa. Grand Mostafa located in Sylhet welcomes respite and tranquil relaxation guests can delight in spacious rooms well equipped to offer truly elevated experienced with modern amenities." , "",  10000, 4.1),

     Hotel('assets/images/regular 8.jpg', 'Zabeer \n International ',"Zabeer Hotel International in Jessore features a bar and a terrace. Among the facilities of this property are a restaurant, a 24-hour front desk and room service, along with free WiFi throughout the property. Guests can use the indoor pool and the fitness centre, or enjoy city views.All units at the hotel come with air conditioning, a seating area, a flat-screen TV with cable channels, a safety deposit box and a private bathroom with a shower, bathrobes and slippers. All rooms will provide guests with a desk and a kettle." , "",  10000, 4.2),

     Hotel('assets/images/regular 9.jpg', 'The Palace \n Luxury Resort'," Come lose yourself in the largest resort in Bangladesh in the heart of breathtaking pristine nature. Indulge in a regal experience like no other at The Palace Luxury Resort in Bahubal, Habiganj. Book an escape to this Kingdom of tranquility and experience life the Palace way.", "", 10000, 4.5),

     Hotel('assets/images/regular 10.jpg', 'Zabeer \n International ',"Zabeer Hotel International in Jessore features a bar and a terrace. Among the facilities of this property are a restaurant, a 24-hour front desk and room service, along with free WiFi throughout the property. Guests can use the indoor pool and the fitness centre, or enjoy city views.All units at the hotel come with air conditioning, a seating area, a flat-screen TV with cable channels, a safety deposit box and a private bathroom with a shower, bathrobes and slippers. All rooms will provide guests with a desk and a kettle." , "",  10000, 4.2),
   ];
  }

}


