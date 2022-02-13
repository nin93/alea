module Alea::Tables::Ziggurat
  # Tables for normal variates
  module Normal
    K32 = UInt32.static_array(
      0x007799EC, 0x00000000, 0x006045F5, 0x006D1AA8, 0x00728FB4,
      0x007592AF, 0x00777A5C, 0x0078CA38, 0x0079BF6B, 0x007A7A35,
      0x007B0D2F, 0x007B83D4, 0x007BE597, 0x007C3788, 0x007C7D33,
      0x007CB926, 0x007CED48, 0x007D1B08, 0x007D437F, 0x007D678B,
      0x007D87DB, 0x007DA4FC, 0x007DBF61, 0x007DD767, 0x007DED5D,
      0x007E0183, 0x007E1411, 0x007E2534, 0x007E3515, 0x007E43D5,
      0x007E5193, 0x007E5E67, 0x007E6A69, 0x007E75AA, 0x007E803E,
      0x007E8A32, 0x007E9395, 0x007E9C72, 0x007EA4D5, 0x007EACC6,
      0x007EB44E, 0x007EBB75, 0x007EC243, 0x007EC8BC, 0x007ECEE8,
      0x007ED4CC, 0x007EDA6B, 0x007EDFCB, 0x007EE4EF, 0x007EE9DC,
      0x007EEE94, 0x007EF31B, 0x007EF774, 0x007EFBA0, 0x007EFFA3,
      0x007F037F, 0x007F0736, 0x007F0ACA, 0x007F0E3C, 0x007F118F,
      0x007F14C4, 0x007F17DC, 0x007F1ADA, 0x007F1DBD, 0x007F2087,
      0x007F233A, 0x007F25D7, 0x007F285D, 0x007F2AD0, 0x007F2D2E,
      0x007F2F7A, 0x007F31B3, 0x007F33DC, 0x007F35F3, 0x007F37FB,
      0x007F39F3, 0x007F3BDC, 0x007F3DB7, 0x007F3F84, 0x007F4145,
      0x007F42F8, 0x007F449F, 0x007F463A, 0x007F47CA, 0x007F494E,
      0x007F4AC8, 0x007F4C38, 0x007F4D9D, 0x007F4EF9, 0x007F504C,
      0x007F5195, 0x007F52D5, 0x007F540D, 0x007F553D, 0x007F5664,
      0x007F5784, 0x007F589C, 0x007F59AC, 0x007F5AB5, 0x007F5BB8,
      0x007F5CB3, 0x007F5DA8, 0x007F5E96, 0x007F5F7E, 0x007F605F,
      0x007F613B, 0x007F6210, 0x007F62E0, 0x007F63AA, 0x007F646F,
      0x007F652E, 0x007F65E8, 0x007F669C, 0x007F674C, 0x007F67F6,
      0x007F689C, 0x007F693C, 0x007F69D9, 0x007F6A70, 0x007F6B03,
      0x007F6B91, 0x007F6C1B, 0x007F6CA0, 0x007F6D21, 0x007F6D9E,
      0x007F6E17, 0x007F6E8C, 0x007F6EFC, 0x007F6F68, 0x007F6FD1,
      0x007F7035, 0x007F7096, 0x007F70F3, 0x007F714C, 0x007F71A1,
      0x007F71F2, 0x007F723F, 0x007F7289, 0x007F72CF, 0x007F7312,
      0x007F7350, 0x007F738B, 0x007F73C3, 0x007F73F6, 0x007F7427,
      0x007F7453, 0x007F747C, 0x007F74A1, 0x007F74C3, 0x007F74E0,
      0x007F74FB, 0x007F7511, 0x007F7524, 0x007F7533, 0x007F753F,
      0x007F7546, 0x007F754A, 0x007F754B, 0x007F7547, 0x007F753F,
      0x007F7534, 0x007F7524, 0x007F7511, 0x007F74F9, 0x007F74DE,
      0x007F74BE, 0x007F749A, 0x007F7472, 0x007F7445, 0x007F7414,
      0x007F73DF, 0x007F73A5, 0x007F7366, 0x007F7323, 0x007F72DA,
      0x007F728D, 0x007F723A, 0x007F71E3, 0x007F7186, 0x007F7123,
      0x007F70BB, 0x007F704D, 0x007F6FD9, 0x007F6F5F, 0x007F6EDF,
      0x007F6E58, 0x007F6DCB, 0x007F6D37, 0x007F6C9C, 0x007F6BF9,
      0x007F6B4F, 0x007F6A9C, 0x007F69E2, 0x007F691F, 0x007F6854,
      0x007F677F, 0x007F66A1, 0x007F65B8, 0x007F64C6, 0x007F63C8,
      0x007F62C0, 0x007F61AB, 0x007F608A, 0x007F5F5D, 0x007F5E21,
      0x007F5CD8, 0x007F5B7F, 0x007F5A17, 0x007F589E, 0x007F5713,
      0x007F5575, 0x007F53C4, 0x007F51FE, 0x007F5022, 0x007F4E2F,
      0x007F4C22, 0x007F49FA, 0x007F47B6, 0x007F4553, 0x007F42CF,
      0x007F4028, 0x007F3D5A, 0x007F3A64, 0x007F3741, 0x007F33ED,
      0x007F3065, 0x007F2CA4, 0x007F28A4, 0x007F245F, 0x007F1FCE,
      0x007F1AEA, 0x007F15A9, 0x007F1000, 0x007F09E4, 0x007F0346,
      0x007EFC16, 0x007EF43E, 0x007EEBA8, 0x007EE237, 0x007ED7C8,
      0x007ECC2F, 0x007EBF37, 0x007EB09D, 0x007EA00A, 0x007E8D0D,
      0x007E7710, 0x007E5D47, 0x007E3E93, 0x007E1959, 0x007DEB2C,
      0x007DB036, 0x007D6203, 0x007CF4B9, 0x007C4FD2, 0x007B3630,
      0x0078D2D2
    )

    K64 = UInt64.static_array(
      0x0007799ec012f7b2, 0x0000000000000000, 0x0006045f4c7de363, 0x0006d1aa7d5ec0a5,
      0x000728fb3f60f777, 0x0007592af4e9fbc0, 0x000777a5c0bf655d, 0x00078ca3857d2256,
      0x00079bf6b0ffe58b, 0x0007a7a34ab092ad, 0x0007b0d2f20dd1cb, 0x0007b83d3aa9cb52,
      0x0007be597614224d, 0x0007c3788631abe9, 0x0007c7d32bc192ee, 0x0007cb9263a6e86d,
      0x0007ced483edfa84, 0x0007d1b07ac0fd39, 0x0007d437ef2da5fc, 0x0007d678b069aa6e,
      0x0007d87db38c5c87, 0x0007da4fc6a9ba62, 0x0007dbf611b37f3b, 0x0007dd7674d0f286,
      0x0007ded5ce8205f6, 0x0007e018307fb62b, 0x0007e141081bd124, 0x0007e2533d712de8,
      0x0007e3514bbd7718, 0x0007e43d54944b52, 0x0007e5192f25ef42, 0x0007e5e67481118d,
      0x0007e6a6897c1ce2, 0x0007e75aa6c7f64c, 0x0007e803df8ee498, 0x0007e8a326eb6272,
      0x0007e93954717a28, 0x0007e9c727f8648f, 0x0007ea4d4cc85a3c, 0x0007eacc5c4907a9,
      0x0007eb44e0474cf6, 0x0007ebb754e47419, 0x0007ec242a3d8474, 0x0007ec8bc5d69645,
      0x0007ecee83d3d6e9, 0x0007ed4cb8082f45, 0x0007eda6aee0170f, 0x0007edfcae2dfe68,
      0x0007ee4ef5dccd3e, 0x0007ee9dc08c394e, 0x0007eee9441a17c7, 0x0007ef31b21b4fb1,
      0x0007ef773846a8a7, 0x0007efba00d35a17, 0x0007effa32ccf69f, 0x0007f037f25e1278,
      0x0007f0736112d12c, 0x0007f0ac9e145c25, 0x0007f0e3c65e1fcc, 0x0007f118f4ed8e54,
      0x0007f14c42ed0dc8, 0x0007f17dc7daa0c3, 0x0007f1ad99aac6a5, 0x0007f1dbcce80015,
      0x0007f20874cf56bf, 0x0007f233a36a3b9a, 0x0007f25d69a604ad, 0x0007f285d7694a92,
      0x0007f2acfba75e3b, 0x0007f2d2e4720909, 0x0007f2f79f09c344, 0x0007f31b37ec883b,
      0x0007f33dbae36abc, 0x0007f35f330f08d5, 0x0007f37faaf2fa79, 0x0007f39f2c805380,
      0x0007f3bdc11f4f1c, 0x0007f3db71b83850, 0x0007f3f846bba121, 0x0007f4144829f846,
      0x0007f42f7d9a8b9d, 0x0007f449ee420432, 0x0007f463a0f8675e, 0x0007f47c9c3ea77b,
      0x0007f494e643cd8e, 0x0007f4ac84e9c475, 0x0007f4c37dc9cd50, 0x0007f4d9d638a432,
      0x0007f4ef934a5b6a, 0x0007f504b9d5f33d, 0x0007f5194e78b352, 0x0007f52d55994a96,
      0x0007f540d36aba0c, 0x0007f553cbef0e77, 0x0007f56642f9ec8f, 0x0007f5783c32f31e,
      0x0007f589bb17f609, 0x0007f59ac2ff1525, 0x0007f5ab5718b15a, 0x0007f5bb7a71427c,
      0x0007f5cb2ff31009, 0x0007f5da7a67cebe, 0x0007f5e95c7a24e7, 0x0007f5f7d8b7171e,
      0x0007f605f18f5ef4, 0x0007f613a958ad0a, 0x0007f621024ed7e9, 0x0007f62dfe94f8cb,
      0x0007f63aa036777a, 0x0007f646e928065a, 0x0007f652db488f88, 0x0007f65e786213ff,
      0x0007f669c22a7d8a, 0x0007f674ba446459, 0x0007f67f623fc8db, 0x0007f689bb9ac294,
      0x0007f693c7c22481, 0x0007f69d881217a6, 0x0007f6a6fdd6ac36, 0x0007f6b02a4c61ee,
      0x0007f6b90ea0a7f4, 0x0007f6c1abf254c0, 0x0007f6ca03521664, 0x0007f6d215c2db82,
      0x0007f6d9e43a3559, 0x0007f6e16fa0b329, 0x0007f6e8b8d23729, 0x0007f6efc09e4569,
      0x0007f6f687c84cbf, 0x0007f6fd0f07ea09, 0x0007f703570925e2, 0x0007f709606cad03,
      0x0007f70f2bc8036f, 0x0007f714b9a5b292, 0x0007f71a0a85725d, 0x0007f71f1edc4d9e,
      0x0007f723f714c179, 0x0007f728938ed843, 0x0007f72cf4a03fa0, 0x0007f7311a945a16,
      0x0007f73505ac4bf8, 0x0007f738b61f03bd, 0x0007f73c2c193dc0, 0x0007f73f67bd835c,
      0x0007f74269242559, 0x0007f745305b31a1, 0x0007f747bd666428, 0x0007f74a103f12ed,
      0x0007f74c28d414f5, 0x0007f74e0709a42d, 0x0007f74faab939f9, 0x0007f75113b16657,
      0x0007f75241b5a155, 0x0007f753347e16b8, 0x0007f753ebb76b7c, 0x0007f75467027d05,
      0x0007f754a5f4199d, 0x0007f754a814b207, 0x0007f7546ce003ae, 0x0007f753f3c4bb29,
      0x0007f7533c240e92, 0x0007f75245514f41, 0x0007f7510e91726c, 0x0007f74f971a9012,
      0x0007f74dde135797, 0x0007f74be2927971, 0x0007f749a39e051c, 0x0007f747202aba8a,
      0x0007f744571b4e3c, 0x0007f741473f9efe, 0x0007f73def53dc43, 0x0007f73a4dff9bff,
      0x0007f73661d4deaf, 0x0007f732294f003f, 0x0007f72da2d19444, 0x0007f728cca72bda,
      0x0007f723a5000367, 0x0007f71e29f09627, 0x0007f7185970156b, 0x0007f7123156c102,
      0x0007f70baf5c1e2c, 0x0007f704d1150a23, 0x0007f6fd93f1a4e5, 0x0007f6f5f53b10b6,
      0x0007f6edf211023e, 0x0007f6e587671ce9, 0x0007f6dcb2021679, 0x0007f6d36e749c64,
      0x0007f6c9b91bf4c6, 0x0007f6bf8e1c541b, 0x0007f6b4e95ce015, 0x0007f6a9c68356ff,
      0x0007f69e20ef5211, 0x0007f691f3b517eb, 0x0007f6853997f321, 0x0007f677ed03ff19,
      0x0007f66a08075bdc, 0x0007f65b844ab75a, 0x0007f64c5b091860, 0x0007f63c8506d4bc,
      0x0007f62bfa8798fe, 0x0007f61ab34364b0, 0x0007f608a65a599a, 0x0007f5f5ca4737e8,
      0x0007f5e214d05b48, 0x0007f5cd7af7066e, 0x0007f5b7f0e4c2a1, 0x0007f5a169d68fcf,
      0x0007f589d80596a5, 0x0007f5712c8d0174, 0x0007f557574c912b, 0x0007f53c46c77193,
      0x0007f51fe7feb9f2, 0x0007f5022646ecfb, 0x0007f4e2eb17ab1d, 0x0007f4c21dd4a3d1,
      0x0007f49fa38ea394, 0x0007f47b5ebb62eb, 0x0007f4552ee27473, 0x0007f42cf03d58f5,
      0x0007f4027b48549f, 0x0007f3d5a44119df, 0x0007f3a63a8fb552, 0x0007f37408155100,
      0x0007f33ed05b55ec, 0x0007f3064f9c183e, 0x0007f2ca399c7ba1, 0x0007f28a384bb940,
      0x0007f245ea1b7a2b, 0x0007f1fcdffe8f1b, 0x0007f1ae9af758cd, 0x0007f15a8917f27e,
      0x0007f10001ccaaab, 0x0007f09e413c418a, 0x0007f034627733d7, 0x0007efc15815b8d5,
      0x0007ef43e2bf7f55, 0x0007eeba84e31dfe, 0x0007ee237294df89, 0x0007ed7c7c170141,
      0x0007ecc2f0d95d3a, 0x0007ebf377a46782, 0x0007eb09d6deb285, 0x0007ea00a4f17808,
      0x0007e8d0d3da63d6, 0x0007e771023b0fcf, 0x0007e5d46c2f08d8, 0x0007e3e937669691,
      0x0007e195978f1176, 0x0007deb2c0e05c1c, 0x0007db0362002a19, 0x0007d6202c151439,
      0x0007cf4b8f00a2cb, 0x0007c4fd24520efd, 0x0007b362fbf81816, 0x00078d2d25998e24
    )

    W32 = Float32.static_array(
      4.66198677960027669255e-07, 2.56588335019207033255e-08, 3.41146697750176784592e-08,
      4.00230311410932959821e-08, 4.47179475877737745459e-08, 4.86837785973537366722e-08,
      5.21562578925932412861e-08, 5.52695199001886257153e-08, 5.81078488992733116465e-08,
      6.07279932024587421409e-08, 6.31701613261172047795e-08, 6.54639842900233842742e-08,
      6.76319905583641815324e-08, 6.96917493470166688656e-08, 7.16572544283857476692e-08,
      7.35398519048393832969e-08, 7.53488822443557479279e-08, 7.70921367281667127885e-08,
      7.87761895947956022626e-08, 8.04066446825615346857e-08, 8.19883218760237408659e-08,
      8.35254002936857088917e-08, 8.50215298165053411740e-08, 8.64799190652369040985e-08,
      8.79034055989140110861e-08, 8.92945125124233511541e-08, 9.06554945027956262312e-08,
      9.19883756905278607229e-08, 9.32949809202232869780e-08, 9.45769618559625849039e-08,
      9.58358188855612866442e-08, 9.70729196232813152662e-08, 9.82895146313061088986e-08,
      9.94867508514382224721e-08, 1.00665683139461669691e-07, 1.01827284217853923044e-07,
      1.02972453302539369464e-07, 1.04102023612124921572e-07, 1.05216768930574060431e-07,
      1.06317409364335657741e-07, 1.07404616410877866490e-07, 1.08479017436113134283e-07,
      1.09541199642370962438e-07, 1.10591713595628691212e-07, 1.11631076370069356306e-07,
      1.12659774359245895023e-07, 1.13678265795837113569e-07, 1.14686983015899673063e-07,
      1.15686334498432158725e-07, 1.16676706706789039179e-07, 1.17658465754873988919e-07,
      1.18631958917986203582e-07, 1.19597516005596215528e-07, 1.20555450611113917226e-07,
      1.21506061251817163689e-07, 1.22449632410483948386e-07, 1.23386435488872536840e-07,
      1.24316729681986364321e-07, 1.25240762781015530062e-07, 1.26158771911939892267e-07,
      1.27070984215989333455e-07, 1.27977617477468922011e-07, 1.28878880703854958297e-07,
      1.29774974662539874521e-07, 1.30666092378141980504e-07, 1.31552419593887221722e-07,
      1.32434135200211397569e-07, 1.33311411633413359243e-07, 1.34184415246907777059e-07,
      1.35053306657377859830e-07, 1.35918241067904315860e-07, 1.36779368569952053923e-07,
      1.37636834425917531047e-07, 1.38490779333783508675e-07, 1.39341339675287344817e-07,
      1.40188647748881762555e-07, 1.41032831988654882776e-07, 1.41874017170273235693e-07,
      1.42712324604921442006e-07, 1.43547872322127921816e-07, 1.44380775242292721080e-07,
      1.45211145339665544509e-07, 1.46039091796461362146e-07, 1.46864721148745476208e-07,
      1.47688137424670065700e-07, 1.48509442275598857119e-07, 1.49328735100614641423e-07,
      1.50146113164867617390e-07, 1.50961671712187416111e-07, 1.51775504072350982845e-07,
      1.52587701763369746341e-07, 1.53398354589133671168e-07, 1.54207550732725568797e-07,
      1.55015376845697999657e-07, 1.55821918133584372604e-07, 1.56627258437898192833e-07,
      1.57431480314857468671e-07, 1.58234665111056041043e-07, 1.59036893036289199880e-07,
      1.59838243233728855017e-07, 1.60638793847630850137e-07, 1.61438622088746393909e-07,
      1.62237804297600106296e-07, 1.63036416005787357730e-07, 1.63834531995435479082e-07,
      1.64632226356965902954e-07, 1.65429572545287097020e-07, 1.66226643434541294491e-07,
      1.67023511371523209274e-07, 1.67820248227882200051e-07, 1.68616925451215588827e-07,
      1.69413614115155757272e-07, 1.70210384968549673733e-07, 1.71007308483826142122e-07,
      1.71804454904642543391e-07, 1.72601894292900061024e-07, 1.73399696575213681990e-07,
      1.74197931588920988271e-07, 1.74996669127712165834e-07, 1.75795978986961275677e-07,
      1.76595931008838063924e-07, 1.77396595127278238022e-07, 1.78198041412889183130e-07,
      1.79000340117867431104e-07, 1.79803561721004406185e-07, 1.80607776972855859813e-07,
      1.81413056941151359868e-07, 1.82219473056520464354e-07, 1.83027097158612474240e-07,
      1.83836001542687613069e-07, 1.84646259006759307383e-07, 1.85457942899367347876e-07,
      1.86271127168064649331e-07, 1.87085886408701333260e-07, 1.87902295915592424729e-07,
      1.88720431732658022414e-07, 1.89540370705627262627e-07, 1.90362190535400839128e-07,
      1.91185969832669990437e-07, 1.92011788173893651535e-07, 1.92839726158739913768e-07,
      1.93669865469102145482e-07, 1.94502288929804890433e-07, 1.95337080571120616772e-07,
      1.96174325693223683314e-07, 1.97014110932714374919e-07, 1.97856524331352952716e-07,
      1.98701655407150388211e-07, 1.99549595227971635348e-07, 2.00400436487814600236e-07,
      2.01254273585938820883e-07, 2.02111202709026498408e-07, 2.02971321916571014951e-07,
      2.03834731229698846698e-07, 2.04701532723644121196e-07, 2.05571830624108885378e-07,
      2.06445731407757185541e-07, 2.07323343907107312957e-07, 2.08204779420104330037e-07,
      2.09090151824673600213e-07, 2.09979577698577670508e-07, 2.10873176444920111011e-07,
      2.11771070423665379388e-07, 2.12673385089569268965e-07, 2.13580249136944118603e-07,
      2.14491794651713402832e-07, 2.15408157271244625533e-07, 2.16329476352486921685e-07,
      2.17255895148978920488e-07, 2.18187560997337924713e-07, 2.19124625513888206785e-07,
      2.20067244802139479285e-07, 2.21015579671883851683e-07, 2.21969795870742159701e-07,
      2.22930064329060010376e-07, 2.23896561419128954210e-07, 2.24869469229791575583e-07,
      2.25848975857580322189e-07, 2.26835275715640744118e-07, 2.27828569861799901001e-07,
      2.28829066347263833069e-07, 2.29836980587561823183e-07, 2.30852535757505260518e-07,
      2.31875963212094114516e-07, 2.32907502935486642699e-07, 2.33947404020352726160e-07,
      2.34995925180156140289e-07, 2.36053335297164516378e-07, 2.37119914009265667728e-07,
      2.38195952338983970691e-07, 2.39281753368440712742e-07, 2.40377632964396957621e-07,
      2.41483920557958384709e-07, 2.42600959984018662258e-07, 2.43729110386077326413e-07,
      2.44868747192698939290e-07, 2.46020263172594533433e-07, 2.47184069576113545901e-07,
      2.48360597371852893654e-07, 2.49550298588131851232e-07, 2.50753647770270890721e-07,
      2.51971143565970967140e-07, 2.53203310452642767375e-07, 2.54450700622322097890e-07,
      2.55713896041856770961e-07, 2.56993510708419870887e-07, 2.58290193123138874550e-07,
      2.59604629008804833146e-07, 2.60937544301314385690e-07, 2.62289708448800566945e-07,
      2.63661938057441759882e-07, 2.65055100928844238758e-07, 2.66470120540847889467e-07,
      2.67907981031821866252e-07, 2.69369732758258246335e-07, 2.70856498507068313229e-07,
      2.72369480457841388042e-07, 2.73909968006952220135e-07, 2.75479346585437289399e-07,
      2.77079107626811561009e-07, 2.78710859870496796972e-07, 2.80376342222588603820e-07,
      2.82077438439999912690e-07, 2.83816193958769527230e-07, 2.85594835255375795814e-07,
      2.87415792215003905739e-07, 2.89281724087851835900e-07, 2.91195549750371467233e-07,
      2.93160483161771875581e-07, 2.95180075129332912389e-07, 2.97258262785797916083e-07,
      2.99399428561531794298e-07, 3.01608470935804138388e-07, 3.03890889921758510417e-07,
      3.06252891144972267537e-07, 3.08701513613258141075e-07, 3.11244787989714509378e-07,
      3.13891934589336184321e-07, 3.16653613755314681314e-07, 3.19542246256559459667e-07,
      3.22572428717978242099e-07, 3.25761480217458181578e-07, 3.29130173358915628534e-07,
      3.32703730345002116955e-07, 3.36513208964639108346e-07, 3.40597478255417943913e-07,
      3.45006114675213401550e-07, 3.49803789521323211592e-07, 3.55077180848341416206e-07,
      3.60946392031859609868e-07, 3.67584959507244041831e-07, 3.75257645787954431030e-07,
      3.84399301057791926300e-07, 3.95804015855768440983e-07, 4.11186015434435801956e-07,
      4.35608969373823260746e-07
    )

    W64 = Float64.static_array(
      1.7367254121602630e-15, 9.5586603514556339e-17, 1.2708704834810623e-16,
      1.4909740962495474e-16, 1.6658733631586268e-16, 1.8136120810119029e-16,
      1.9429720153135588e-16, 2.0589500628482093e-16, 2.1646860576895422e-16,
      2.2622940392218116e-16, 2.3532718914045892e-16, 2.4387234557428771e-16,
      2.5194879829274225e-16, 2.5962199772528103e-16, 2.6694407473648285e-16,
      2.7395729685142446e-16, 2.8069646002484804e-16, 2.8719058904113930e-16,
      2.9346417484728883e-16, 2.9953809336782113e-16, 3.0543030007192440e-16,
      3.1115636338921572e-16, 3.1672988018581815e-16, 3.2216280350549905e-16,
      3.2746570407939751e-16, 3.3264798116841710e-16, 3.3771803417353232e-16,
      3.4268340353119356e-16, 3.4755088731729758e-16, 3.5232663846002031e-16,
      3.5701624633953494e-16, 3.6162480571598339e-16, 3.6615697529653540e-16,
      3.7061702777236077e-16, 3.7500889278747798e-16, 3.7933619401549554e-16,
      3.8360228129677279e-16, 3.8781025861250247e-16, 3.9196300853257678e-16,
      3.9606321366256378e-16, 4.0011337552546690e-16, 4.0411583124143332e-16,
      4.0807276830960448e-16, 4.1198623774807442e-16, 4.1585816580828064e-16,
      4.1969036444740733e-16, 4.2348454071520708e-16, 4.2724230518899761e-16,
      4.3096517957162941e-16, 4.3465460355128760e-16, 4.3831194100854571e-16,
      4.4193848564470665e-16, 4.4553546609579137e-16, 4.4910405058828750e-16,
      4.5264535118571397e-16, 4.5616042766900381e-16, 4.5965029108849407e-16,
      4.6311590702081647e-16, 4.6655819856008752e-16, 4.6997804906941950e-16,
      4.7337630471583237e-16, 4.7675377680908526e-16, 4.8011124396270155e-16,
      4.8344945409350080e-16, 4.8676912627422087e-16, 4.9007095245229938e-16,
      4.9335559904654139e-16, 4.9662370843221783e-16, 4.9987590032409088e-16,
      5.0311277306593187e-16, 5.0633490483427195e-16, 5.0954285476338923e-16,
      5.1273716399787966e-16, 5.1591835667857364e-16, 5.1908694086703434e-16,
      5.2224340941340417e-16, 5.2538824077194543e-16, 5.2852189976823820e-16,
      5.3164483832166176e-16, 5.3475749612647295e-16, 5.3786030129452348e-16,
      5.4095367096239933e-16, 5.4403801186554671e-16, 5.4711372088173611e-16,
      5.5018118554603362e-16, 5.5324078453927836e-16, 5.5629288815190902e-16,
      5.5933785872484621e-16, 5.6237605106900435e-16, 5.6540781286489604e-16,
      5.6843348504368141e-16, 5.7145340215092040e-16, 5.7446789269419609e-16,
      5.7747727947569648e-16, 5.8048187991076857e-16, 5.8348200633338921e-16,
      5.8647796628943653e-16, 5.8947006281858718e-16, 5.9245859472561339e-16,
      5.9544385684180598e-16, 5.9842614027720281e-16, 6.0140573266426640e-16,
      6.0438291839361250e-16, 6.0735797884236057e-16, 6.1033119259564394e-16,
      6.1330283566179110e-16, 6.1627318168165963e-16, 6.1924250213258470e-16,
      6.2221106652737879e-16, 6.2517914260879998e-16, 6.2814699653988953e-16,
      6.3111489309056042e-16, 6.3408309582080600e-16, 6.3705186726088149e-16,
      6.4002146908880247e-16, 6.4299216230548961e-16, 6.4596420740788321e-16,
      6.4893786456033965e-16, 6.5191339376461587e-16, 6.5489105502874154e-16,
      6.5787110853507413e-16, 6.6085381480782587e-16, 6.6383943488035057e-16,
      6.6682823046247459e-16, 6.6982046410815579e-16, 6.7281639938375311e-16,
      6.7581630103719006e-16, 6.7882043516829803e-16, 6.8182906940062540e-16,
      6.8484247305500383e-16, 6.8786091732516637e-16, 6.9088467545571690e-16,
      6.9391402292275690e-16, 6.9694923761748294e-16, 6.9999060003307640e-16,
      7.0303839345521508e-16, 7.0609290415654822e-16, 7.0915442159548734e-16,
      7.1222323861967788e-16, 7.1529965167453030e-16, 7.1838396101720629e-16,
      7.2147647093647067e-16, 7.2457748997883870e-16, 7.2768733118146927e-16,
      7.3080631231227429e-16, 7.3393475611774048e-16, 7.3707299057898310e-16,
      7.4022134917657997e-16, 7.4338017116476479e-16, 7.4654980185558890e-16,
      7.4973059291369793e-16, 7.5292290266240584e-16, 7.5612709640179217e-16,
      7.5934354673958895e-16, 7.6257263393567558e-16, 7.6581474626104873e-16,
      7.6907028037219191e-16, 7.7233964170182985e-16, 7.7562324486711744e-16,
      7.7892151409638524e-16, 7.8223488367564108e-16, 7.8556379841610841e-16,
      7.8890871414417552e-16, 7.9227009821522709e-16, 7.9564843005293662e-16,
      7.9904420171571300e-16, 8.0245791849212591e-16, 8.0589009952726568e-16,
      8.0934127848215009e-16, 8.1281200422845008e-16, 8.1630284158098775e-16,
      8.1981437207065329e-16, 8.2334719476060504e-16, 8.2690192710884700e-16,
      8.3047920588053737e-16, 8.3407968811366288e-16, 8.3770405214202216e-16,
      8.4135299867980282e-16, 8.4502725197240968e-16, 8.4872756101861549e-16,
      8.5245470086955962e-16, 8.5620947401062333e-16, 8.5999271183276646e-16,
      8.6380527620052589e-16, 8.6764806112455816e-16, 8.7152199454736980e-16,
      8.7542804025171749e-16, 8.7936719990210427e-16, 8.8334051523084080e-16,
      8.8734907038131345e-16, 8.9139399442240861e-16, 8.9547646404950677e-16,
      8.9959770648910994e-16, 9.0375900262601175e-16, 9.0796169037400680e-16,
      9.1220716831348461e-16, 9.1649689962191353e-16, 9.2083241632623076e-16,
      9.2521532390956933e-16, 9.2964730630864167e-16, 9.3413013134252651e-16,
      9.3866565661866598e-16, 9.4325583596767065e-16, 9.4790272646517382e-16,
      9.5260849610662787e-16, 9.5737543220974496e-16, 9.6220595062948384e-16,
      9.6710260588230542e-16, 9.7206810229016259e-16, 9.7710530627072088e-16,
      9.8221725991905411e-16, 9.8740719604806711e-16, 9.9267855488079765e-16,
      9.9803500261836449e-16, 1.0034804521436181e-15, 1.0090190861637457e-15,
      1.0146553831467086e-15, 1.0203941464683124e-15, 1.0262405372613567e-15,
      1.0322001115486456e-15, 1.0382788623515399e-15, 1.0444832676000471e-15,
      1.0508203448355195e-15, 1.0572977139009890e-15, 1.0639236690676801e-15,
      1.0707072623632994e-15, 1.0776584002668106e-15, 1.0847879564403425e-15,
      1.0921079038149563e-15, 1.0996314701785628e-15, 1.1073733224935752e-15,
      1.1153497865853155e-15, 1.1235791107110833e-15, 1.1320817840164846e-15,
      1.1408809242582780e-15, 1.1500027537839792e-15, 1.1594771891449189e-15,
      1.1693385786910960e-15, 1.1796266352955801e-15, 1.1903876299282890e-15,
      1.2016759392543819e-15, 1.2135560818666897e-15, 1.2261054417450561e-15,
      1.2394179789163251e-15, 1.2536093926602567e-15, 1.2688244814255010e-15,
      1.2852479319096109e-15, 1.3031206634689985e-15, 1.3227655770195326e-15,
      1.3446300925011171e-15, 1.3693606835128518e-15, 1.3979436672775240e-15,
      1.4319989869661328e-15, 1.4744848603597596e-15, 1.5317872741611144e-15,
      1.6227698675312968e-15
    )

    F32 = Float32.static_array(
      1.00000000000000000000e+00, 9.77101701267671596263e-01, 9.59879091800106665211e-01,
      9.45198953442299649730e-01, 9.32060075959230460718e-01, 9.19991505039347012840e-01,
      9.08726440052130879366e-01, 8.98095921898343418910e-01, 8.87984660755833377088e-01,
      8.78309655808917399966e-01, 8.69008688036857046555e-01, 8.60033621196331532488e-01,
      8.51346258458677951353e-01, 8.42915653112204177333e-01, 8.34716292986883434679e-01,
      8.26726833946221373317e-01, 8.18929191603702366642e-01, 8.11307874312656274185e-01,
      8.03849483170964274059e-01, 7.96542330422958966274e-01, 7.89376143566024590648e-01,
      7.82341832654802504798e-01, 7.75431304981187174974e-01, 7.68637315798486264740e-01,
      7.61953346836795386565e-01, 7.55373506507096115214e-01, 7.48892447219156820459e-01,
      7.42505296340151055290e-01, 7.36207598126862650112e-01, 7.29995264561476231435e-01,
      7.23864533468630222401e-01, 7.17811932630721960535e-01, 7.11834248878248421200e-01,
      7.05928501332754310127e-01, 7.00091918136511615067e-01, 6.94321916126116711609e-01,
      6.88616083004671808432e-01, 6.82972161644994857355e-01, 6.77388036218773526009e-01,
      6.71861719897082099173e-01, 6.66391343908750100056e-01, 6.60975147776663107813e-01,
      6.55611470579697264149e-01, 6.50298743110816701574e-01, 6.45035480820822293424e-01,
      6.39820277453056585060e-01, 6.34651799287623608059e-01, 6.29528779924836690007e-01,
      6.24450015547026504592e-01, 6.19414360605834324325e-01, 6.14420723888913888899e-01,
      6.09468064925773433949e-01, 6.04555390697467776029e-01, 5.99681752619125263415e-01,
      5.94846243767987448159e-01, 5.90047996332826008015e-01, 5.85286179263371453274e-01,
      5.80559996100790898232e-01, 5.75868682972353718164e-01, 5.71211506735253227163e-01,
      5.66587763256164445025e-01, 5.61996775814524340831e-01, 5.57437893618765945014e-01,
      5.52910490425832290562e-01, 5.48413963255265812791e-01, 5.43947731190026262382e-01,
      5.39511234256952132426e-01, 5.35103932380457614215e-01, 5.30725304403662057062e-01,
      5.26374847171684479008e-01, 5.22052074672321841931e-01, 5.17756517229756352272e-01,
      5.13487720747326958914e-01, 5.09245245995747941592e-01, 5.05028667943468123624e-01,
      5.00837575126148681903e-01, 4.96671569052489714213e-01, 4.92530263643868537748e-01,
      4.88413284705458028423e-01, 4.84320269426683325253e-01, 4.80250865909046753544e-01,
      4.76204732719505863248e-01, 4.72181538467730199660e-01, 4.68180961405693596422e-01,
      4.64202689048174355069e-01, 4.60246417812842867345e-01, 4.56311852678716434184e-01,
      4.52398706861848520777e-01, 4.48506701507203064949e-01, 4.44635565395739396077e-01,
      4.40785034665803987508e-01, 4.36954852547985550526e-01, 4.33144769112652261445e-01,
      4.29354541029441427735e-01, 4.25583931338021970170e-01, 4.21832709229495894654e-01,
      4.18100649837848226120e-01, 4.14387534040891125642e-01, 4.10693148270188157500e-01,
      4.07017284329473372217e-01, 4.03359739221114510510e-01, 3.99720314980197222177e-01,
      3.96098818515832451492e-01, 3.92495061459315619512e-01, 3.88908860018788715696e-01,
      3.85340034840077283462e-01, 3.81788410873393657674e-01, 3.78253817245619183840e-01,
      3.74736087137891138443e-01, 3.71235057668239498696e-01, 3.67750569779032587814e-01,
      3.64282468129004055601e-01, 3.60830600989648031529e-01, 3.57394820145780500731e-01,
      3.53974980800076777232e-01, 3.50570941481406106455e-01, 3.47182563956793643900e-01,
      3.43809713146850715049e-01, 3.40452257044521866547e-01, 3.37110066637006045021e-01,
      3.33783015830718454708e-01, 3.30470981379163586400e-01, 3.27173842813601400970e-01,
      3.23891482376391093290e-01, 3.20623784956905355514e-01, 3.17370638029913609834e-01,
      3.14131931596337177215e-01, 3.10907558126286509559e-01, 3.07697412504292056035e-01,
      3.04501391976649993243e-01, 3.01319396100803049698e-01, 2.98151326696685481377e-01,
      2.94997087799961810184e-01, 2.91856585617095209972e-01, 2.88729728482182923521e-01,
      2.85616426815501756042e-01, 2.82516593083707578948e-01, 2.79430141761637940157e-01,
      2.76356989295668320494e-01, 2.73297054068577072172e-01, 2.70250256365875463072e-01,
      2.67216518343561471038e-01, 2.64195763997261190426e-01, 2.61187919132721213522e-01,
      2.58192911337619235290e-01, 2.55210669954661961700e-01, 2.52241126055942177508e-01,
      2.49284212418528522415e-01, 2.46339863501263828249e-01, 2.43408015422750312329e-01,
      2.40488605940500588254e-01, 2.37581574431238090606e-01, 2.34686861872330010392e-01,
      2.31804410824338724684e-01, 2.28934165414680340644e-01, 2.26076071322380278694e-01,
      2.23230075763917484855e-01, 2.20396127480151998723e-01, 2.17574176724331130872e-01,
      2.14764175251173583536e-01, 2.11966076307030182324e-01, 2.09179834621125076977e-01,
      2.06405406397880797353e-01, 2.03642749310334908452e-01, 2.00891822494656591136e-01,
      1.98152586545775138971e-01, 1.95425003514134304483e-01, 1.92709036903589175926e-01,
      1.90004651670464985713e-01, 1.87311814223800304768e-01, 1.84630492426799269756e-01,
      1.81960655599522513892e-01, 1.79302274522847582272e-01, 1.76655321443734858455e-01,
      1.74019770081838553999e-01, 1.71395595637505754327e-01, 1.68782774801211288285e-01,
      1.66181285764481906364e-01, 1.63591108232365584074e-01, 1.61012223437511009516e-01,
      1.58444614155924284882e-01, 1.55888264724479197465e-01, 1.53343161060262855866e-01,
      1.50809290681845675763e-01, 1.48286642732574552861e-01, 1.45775208005994028060e-01,
      1.43274978973513461566e-01, 1.40785949814444699690e-01, 1.38308116448550733057e-01,
      1.35841476571253755301e-01, 1.33386029691669155683e-01, 1.30941777173644358090e-01,
      1.28508722279999570981e-01, 1.26086870220185887081e-01, 1.23676228201596571932e-01,
      1.21276805484790306533e-01, 1.18888613442910059947e-01, 1.16511665625610869035e-01,
      1.14145977827838487895e-01, 1.11791568163838089811e-01, 1.09448457146811797824e-01,
      1.07116667774683801961e-01, 1.04796225622487068629e-01, 1.02487158941935246892e-01,
      1.00189498768810017482e-01, 9.79032790388624646338e-02, 9.56285367130089991594e-02,
      9.33653119126910124859e-02, 9.11136480663737591268e-02, 8.88735920682758862021e-02,
      8.66451944505580717859e-02, 8.44285095703534715916e-02, 8.22235958132029043366e-02,
      8.00305158146630696292e-02, 7.78493367020961224423e-02, 7.56801303589271778804e-02,
      7.35229737139813238622e-02, 7.13779490588904025339e-02, 6.92451443970067553879e-02,
      6.71246538277884968737e-02, 6.50165779712428976156e-02, 6.29210244377581412456e-02,
      6.08381083495398780614e-02, 5.87679529209337372930e-02, 5.67106901062029017391e-02,
      5.46664613248889208474e-02, 5.26354182767921896513e-02, 5.06177238609477817000e-02,
      4.86135532158685421122e-02, 4.66230949019303814174e-02, 4.46465522512944634759e-02,
      4.26841449164744590750e-02, 4.07361106559409394401e-02, 3.88027074045261474722e-02,
      3.68842156885673053135e-02, 3.49809414617161251737e-02, 3.30932194585785779961e-02,
      3.12214171919203004046e-02, 2.93659397581333588001e-02, 2.75272356696031131329e-02,
      2.57058040085489103443e-02, 2.39022033057958785407e-02, 2.21170627073088502113e-02,
      2.03510962300445102935e-02, 1.86051212757246224594e-02, 1.68800831525431419000e-02,
      1.51770883079353092332e-02, 1.34974506017398673818e-02, 1.18427578579078790488e-02,
      1.02149714397014590439e-02, 8.61658276939872638800e-03, 7.05087547137322242369e-03,
      5.52240329925099155545e-03, 4.03797259336302356153e-03, 2.60907274610215926189e-03,
      1.26028593049859797236e-03
    )

    F64 = Float64.static_array(
      1.0000000000000000e+00, 9.7710170126767082e-01, 9.5987909180010600e-01,
      9.4519895344229909e-01, 9.3206007595922991e-01, 9.1999150503934646e-01,
      9.0872644005213032e-01, 8.9809592189834297e-01, 8.8798466075583282e-01,
      8.7830965580891684e-01, 8.6900868803685649e-01, 8.6003362119633109e-01,
      8.5134625845867751e-01, 8.4291565311220373e-01, 8.3471629298688299e-01,
      8.2672683394622093e-01, 8.1892919160370192e-01, 8.1130787431265572e-01,
      8.0384948317096383e-01, 7.9654233042295841e-01, 7.8937614356602404e-01,
      7.8234183265480195e-01, 7.7543130498118662e-01, 7.6863731579848571e-01,
      7.6195334683679483e-01, 7.5537350650709567e-01, 7.4889244721915638e-01,
      7.4250529634015061e-01, 7.3620759812686210e-01, 7.2999526456147568e-01,
      7.2386453346862967e-01, 7.1781193263072152e-01, 7.1183424887824798e-01,
      7.0592850133275376e-01, 7.0009191813651117e-01, 6.9432191612611627e-01,
      6.8861608300467136e-01, 6.8297216164499430e-01, 6.7738803621877308e-01,
      6.7186171989708166e-01, 6.6639134390874977e-01, 6.6097514777666277e-01,
      6.5561147057969693e-01, 6.5029874311081637e-01, 6.4503548082082196e-01,
      6.3982027745305614e-01, 6.3465179928762327e-01, 6.2952877992483625e-01,
      6.2445001554702606e-01, 6.1941436060583399e-01, 6.1442072388891344e-01,
      6.0946806492577310e-01, 6.0455539069746733e-01, 5.9968175261912482e-01,
      5.9484624376798689e-01, 5.9004799633282545e-01, 5.8528617926337090e-01,
      5.8055999610079034e-01, 5.7586868297235316e-01, 5.7121150673525267e-01,
      5.6658776325616389e-01, 5.6199677581452390e-01, 5.5743789361876550e-01,
      5.5291049042583185e-01, 5.4841396325526537e-01, 5.4394773119002582e-01,
      5.3951123425695158e-01, 5.3510393238045717e-01, 5.3072530440366150e-01,
      5.2637484717168403e-01, 5.2205207467232140e-01, 5.1775651722975591e-01,
      5.1348772074732651e-01, 5.0924524599574761e-01, 5.0502866794346790e-01,
      5.0083757512614835e-01, 4.9667156905248933e-01, 4.9253026364386815e-01,
      4.8841328470545758e-01, 4.8432026942668288e-01, 4.8025086590904642e-01,
      4.7620473271950547e-01, 4.7218153846772976e-01, 4.6818096140569321e-01,
      4.6420268904817391e-01, 4.6024641781284248e-01, 4.5631185267871610e-01,
      4.5239870686184824e-01, 4.4850670150720273e-01, 4.4463556539573912e-01,
      4.4078503466580377e-01, 4.3695485254798533e-01, 4.3314476911265209e-01,
      4.2935454102944126e-01, 4.2558393133802180e-01, 4.2183270922949573e-01,
      4.1810064983784795e-01, 4.1438753404089090e-01, 4.1069314827018799e-01,
      4.0701728432947315e-01, 4.0335973922111429e-01, 3.9972031498019700e-01,
      3.9609881851583223e-01, 3.9249506145931540e-01, 3.8890886001878855e-01,
      3.8534003484007706e-01, 3.8178841087339344e-01, 3.7825381724561896e-01,
      3.7473608713789086e-01, 3.7123505766823922e-01, 3.6775056977903225e-01,
      3.6428246812900372e-01, 3.6083060098964775e-01, 3.5739482014578022e-01,
      3.5397498080007656e-01, 3.5057094148140588e-01, 3.4718256395679348e-01,
      3.4380971314685055e-01, 3.4045225704452164e-01, 3.3711006663700588e-01,
      3.3378301583071823e-01, 3.3047098137916342e-01, 3.2717384281360129e-01,
      3.2389148237639104e-01, 3.2062378495690530e-01, 3.1737063802991350e-01,
      3.1413193159633707e-01, 3.1090755812628634e-01, 3.0769741250429189e-01,
      3.0450139197664983e-01, 3.0131939610080288e-01, 2.9815132669668531e-01,
      2.9499708779996164e-01, 2.9185658561709499e-01, 2.8872972848218270e-01,
      2.8561642681550159e-01, 2.8251659308370741e-01, 2.7943014176163772e-01,
      2.7635698929566810e-01, 2.7329705406857691e-01, 2.7025025636587519e-01,
      2.6721651834356114e-01, 2.6419576399726080e-01, 2.6118791913272082e-01,
      2.5819291133761890e-01, 2.5521066995466168e-01, 2.5224112605594190e-01,
      2.4928421241852824e-01, 2.4633986350126363e-01, 2.4340801542275012e-01,
      2.4048860594050039e-01, 2.3758157443123795e-01, 2.3468686187232990e-01,
      2.3180441082433859e-01, 2.2893416541468023e-01, 2.2607607132238020e-01,
      2.2323007576391746e-01, 2.2039612748015194e-01, 2.1757417672433113e-01,
      2.1476417525117358e-01, 2.1196607630703015e-01, 2.0917983462112499e-01,
      2.0640540639788071e-01, 2.0364274931033485e-01, 2.0089182249465656e-01,
      1.9815258654577511e-01, 1.9542500351413428e-01, 1.9270903690358912e-01,
      1.9000465167046496e-01, 1.8731181422380025e-01, 1.8463049242679927e-01,
      1.8196065559952254e-01, 1.7930227452284767e-01, 1.7665532144373500e-01,
      1.7401977008183875e-01, 1.7139559563750595e-01, 1.6878277480121151e-01,
      1.6618128576448205e-01, 1.6359110823236570e-01, 1.6101222343751107e-01,
      1.5844461415592431e-01, 1.5588826472447920e-01, 1.5334316106026283e-01,
      1.5080929068184568e-01, 1.4828664273257453e-01, 1.4577520800599403e-01,
      1.4327497897351341e-01, 1.4078594981444470e-01, 1.3830811644855071e-01,
      1.3584147657125373e-01, 1.3338602969166913e-01, 1.3094177717364430e-01,
      1.2850872227999952e-01, 1.2608687022018586e-01, 1.2367622820159654e-01,
      1.2127680548479021e-01, 1.1888861344290998e-01, 1.1651166562561080e-01,
      1.1414597782783835e-01, 1.1179156816383801e-01, 1.0944845714681163e-01,
      1.0711666777468364e-01, 1.0479622562248690e-01, 1.0248715894193508e-01,
      1.0018949876880981e-01, 9.7903279038862284e-02, 9.5628536713008819e-02,
      9.3365311912690860e-02, 9.1113648066373634e-02, 8.8873592068275789e-02,
      8.6645194450557961e-02, 8.4428509570353374e-02, 8.2223595813202863e-02,
      8.0030515814663056e-02, 7.7849336702096039e-02, 7.5680130358927067e-02,
      7.3522973713981268e-02, 7.1377949058890375e-02, 6.9245144397006769e-02,
      6.7124653827788497e-02, 6.5016577971242842e-02, 6.2921024437758113e-02,
      6.0838108349539864e-02, 5.8767952920933758e-02, 5.6710690106202902e-02,
      5.4666461324888914e-02, 5.2635418276792176e-02, 5.0617723860947761e-02,
      4.8613553215868521e-02, 4.6623094901930368e-02, 4.4646552251294443e-02,
      4.2684144916474431e-02, 4.0736110655940933e-02, 3.8802707404526113e-02,
      3.6884215688567284e-02, 3.4980941461716084e-02, 3.3093219458578522e-02,
      3.1221417191920245e-02, 2.9365939758133314e-02, 2.7527235669603082e-02,
      2.5705804008548896e-02, 2.3902203305795882e-02, 2.2117062707308864e-02,
      2.0351096230044517e-02, 1.8605121275724643e-02, 1.6880083152543166e-02,
      1.5177088307935325e-02, 1.3497450601739880e-02, 1.1842757857907888e-02,
      1.0214971439701471e-02, 8.6165827693987316e-03, 7.0508754713732268e-03,
      5.5224032992509968e-03, 4.0379725933630305e-03, 2.6090727461021627e-03,
      1.2602859304985975e-03
    )

    R32 = 3.6541528853610087963519472518f32

    R64 = 3.6541528853610087963519472518f64

    # 1.0 / R32
    RINV32 = 0.27366123732975827203338247596f32

    # 1.0 / R64
    RINV64 = 0.27366123732975827203338247596f64
  end
end
