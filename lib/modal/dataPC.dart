class DataPC {
  String imgurl;
  String title;
  String description;
  String status;
  int price;

  DataPC(this.imgurl, this.title, this.description, this.status, this.price);

  static List<DataPC> VIPlist() {
    return [
      DataPC('assets/images/VIP 1.jpg', 'VIP 1',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDA GEFORCE RTX 4060\n'
        'PROCESSOR : INTEL CORE I5-12400F\n'
        'CHIPSET : INTEL H610M D4\n'
        'MEMORY : PC25600 3200 MHZ 2X8GB\n'
        'STORAGE : SSD NVME 512GB\n'
        'POWER SUPPLY : 550W 80+ BRONZE CERTIFIED\n'
        'COOLING SYSTEM : 4 BUAH 12CM RGB FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 245 AVG FPS\n'
        'VALORANT : 376 AVG FPS\n'
        'ROBLOX : 201 AVG FPS', 'Tersedia',
        15000),


      DataPC('assets/images/VIP 2.jpg', 'VIP 2',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDA GEFORCE RTX 4060\n'
        'PROCESSOR : INTEL CORE I5-12400F\n'
        'CHIPSET : INTEL H610M D4\n'
        'MEMORY : PC25600 3200 MHZ 2X8GB\n'
        'STORAGE : SSD NVME 512GB\n'
        'POWER SUPPLY : 550W 80+ BRONZE CERTIFIED\n'
        'COOLING SYSTEM : 4 BUAH 12CM RGB FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 245 AVG FPS\n'
        'VALORANT : 376 AVG FPS\n'
        'ROBLOX : 201 AVG FPS','Maintenance', 15000),


      DataPC('assets/images/VIP 3.jpg', 'VIP 3',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDA GEFORCE RTX 4060\n'
        'PROCESSOR : INTEL CORE I5-12400F\n'
        'CHIPSET : INTEL H610M D4\n'
        'MEMORY : PC25600 3200 MHZ 2X8GB\n'
        'STORAGE : SSD NVME 512GB\n'
        'POWER SUPPLY : 550W 80+ BRONZE CERTIFIED\n'
        'COOLING SYSTEM : 4 BUAH 12CM RGB FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 245 AVG FPS\n'
        'VALORANT : 376 AVG FPS\n'
        'ROBLOX : 201 AVG FPS','Tersedia', 15000),

      DataPC('assets/images/VIP 4.jpg', 'VIP 4',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDA GEFORCE RTX 4060\n'
        'PROCESSOR : INTEL CORE I5-12400F\n'
        'CHIPSET : INTEL H610M D4\n'
        'MEMORY : PC25600 3200 MHZ 2X8GB\n'
        'STORAGE : SSD NVME 512GB\n'
        'POWER SUPPLY : 550W 80+ BRONZE CERTIFIED\n'
        'COOLING SYSTEM : 4 BUAH 12CM RGB FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 245 AVG FPS\n'
        'VALORANT : 376 AVG FPS\n'
        'ROBLOX : 201 AVG FPS','Sedang Dipakai', 15000),


      DataPC('assets/images/VIP 5.jpg',  'VIP 5',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDA GEFORCE RTX 4060\n'
        'PROCESSOR : INTEL CORE I5-12400F\n'
        'CHIPSET : INTEL H610M D4\n'
        'MEMORY : PC25600 3200 MHZ 2X8GB\n'
        'STORAGE : SSD NVME 512GB\n'
        'POWER SUPPLY : 550W 80+ BRONZE CERTIFIED\n'
        'COOLING SYSTEM : 4 BUAH 12CM RGB FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 245 AVG FPS\n'
        'VALORANT : 376 AVG FPS\n'
        'ROBLOX : 201 AVG FPS', 'Tersedia', 15000),
    ];
  }

  static List<DataPC> regularList(){
   return[
     DataPC('assets/images/regular 1.jpg', 'regular 1',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia',  10000),

     DataPC('assets/images/regular 2.jpg',  'regular 2',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Maintenance',  10000),

     DataPC('assets/images/regular 3.jpg', 'regular 3',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Sedang Dipakai',  10000),

     DataPC('assets/images/regular 4.jpg', 'regular 4',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia',  10000),

     DataPC('assets/images/regular 5.jpg', 'regular 5',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia', 10000),

     DataPC('assets/images/regular 6.jpg', 'regular6',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia', 10000),

     DataPC('assets/images/regular 7.jpg', 'regular 7',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS','Tersedia', 10000),


     DataPC('assets/images/regular 8.jpg', 'regular 8',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia', 10000),

     DataPC('assets/images/regular 9.jpg', 
      'regular 9',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS', 'Tersedia', 10000),

     DataPC('assets/images/regular 10.jpg', 'regular 10',
        'SPESIFIKASI :\n'
        'GRAPHIC : NVIDIA GEFORCE RTX 4060 Ti\n'
        'PROCESSOR : INTEL CORE I7-13700F\n'
        'CHIPSET : INTEL B760M\n'
        'MEMORY : DDR5 5600 MHZ 2X16GB\n'
        'STORAGE : SSD NVME PCIe Gen4 x4 500GB + HDD 2TB 7200 RPM\n'
        'POWER SUPPLY : 850W 80+ GOLD CERTIFIED\n'
        'COOLING SYSTEM : DEEPCOOL AG400 ARGB + 2 BUAH 12CM ARGB FAN + 1 BUAH 12CM SYSTEM FAN\n\n'
        'BENCHMARK GAMING PERFORMANCE MEDIUM SETTING:\n'
        'GENSHIN IMPACT : 283 AVG FPS\n'
        'VALORANT : 488 AVG FPS\n'
        'ROBLOX : 398 AVG FPS','Tersedia', 10000),
    ];
  }
}

class DataBooking {
  String title;
  String tanggal;
  String jamMulai;
  String jamSelesai;
  int totalHarga;

  DataBooking(this.title, this.tanggal, this.jamMulai, this.jamSelesai, this.totalHarga);
  static List<DataBooking> dipesanList(){
    return[
      DataBooking('Regular 1', '13 Februari 2023', '08.00', '10.00', 10000),
      DataBooking('Regular 2', '14 Februari 2023', '08.00', '10.00', 10000),
      DataBooking('Regular 3', '15 Februari 2023', '08.00', '10.00', 10000),
    ];
  }
}
