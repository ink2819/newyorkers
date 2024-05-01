drop database if exists my_ny_db;
create database my_ny_db;

\c my_ny_db

CREATE TABLE "locations" (
  "id" serial,
  "name" varchar,
  "latitude" DECIMAL(9,6),
  "longitude" DECIMAL(9,6),
  PRIMARY KEY ("id")
);

CREATE TABLE "chapters" (
  "id" serial,
  "name" varchar,
  "source" varchar,
  "source_link" varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE "posts" (
  "id" serial,
  "title" varchar,
  "post_link" varchar,
  "image_link" varchar,
  "location_id" integer,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_posts_location_id"
    FOREIGN KEY ("location_id")
      REFERENCES "locations"("id")
);

CREATE TABLE "quotes" (
  "id" serial,
  "en_text" varchar,
  "ch_text" varchar,
  "chapter_id" integer,
  "location_id" integer,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_quotes_chapter_id"
    FOREIGN KEY ("chapter_id")
      REFERENCES "chapters"("id"),
  CONSTRAINT "FK_quotes_location_id"
    FOREIGN KEY ("location_id")
      REFERENCES "locations"("id")
);

INSERT INTO "locations" ("id", "name", "latitude", "longitude") VALUES 
(1, 'Central Park', 40.7830096, -73.96557804),
(2, 'Taven on the Green', 40.77261717, -73.97753403),
(3, 'Columbia East Asian Library', 40.80728019, -73.96136711),
(4, 'St Marks Pl', 40.80767345, -73.96255126),
(5, 'One Chase Manhattan Plaza', 40.70792116, -74.00886639),
(6, 'Saks Fifth Ave', 40.75811951, -73.97697192),
(7, 'Latin Quarter', 40.7551039, -73.97307535),
(8, 'Le Pavillon', 40.75298347, -73.97844625),
(9, 'St Patrick''s Cathedral', 40.7587417, -73.97621676),
(10, 'Our Lady of Sorrows Church', 40.71963711, -73.9823964),
(11, 'Central Park West', 40.78166512, -73.97264863),
(12, 'Pratt Institute', 40.69208325, -73.96364528),
(13, 'Columbia University', 40.80769781, -73.962621),
(14, 'New York University', 40.72969455, -73.99638745),
(15, 'Greenwich Village', 40.7336, -74.0027),
(16, 'St Vincent''s Hospital', 40.73763884, -74.0010167),
(17, 'Chelsea', 40.7465, -74.0014),
(18, 'East Hampton', 41.0832, -71.9994),
(19, 'Time Square', 40.75825098, -73.98547823),
(20, 'Yonkers', 40.92457678, -73.86456553),
(21, 'Riverdale', 40.8996, -73.9088),
(22, '3rd Ave & 21st Street', 40.73764462, -73.98404159),
(23, 'Westchester', 41.122, -73.7949),
(24, 'Lower East Side', 40.715, -73.9843),
(25, 'Russian Tea Room', 40.76508105, -73.97941637),
(26, 'Metropolitan Opera House', 40.77290257, -73.98400476),
(27, 'The Mount Sinai Hospital', 40.79053325, -73.95242394),
(28, 'Fictional bar: Tea for Two', 40.7423631, -74.00070366),
(29, 'Macy''s', 40.75100971, -73.98909612),
(30, 'Carnegie Hall', 40.76534517, -73.97991287),
(31, 'Yeshiva College', 40.849317, -73.93010759),
(32, 'Washington Bridge', 40.84688574, -73.92778732),
(33, '5th Ave & 48th Street', 40.75757659, -73.97813769);

INSERT INTO chapters (id, name, source) VALUES
(1, 'Li T’ung: A Chinese Girl in New York', '“Li T’ung: A Chinese Girl in New York.” Tr. by the author and C.T. Hsia. In C.T. Hsia, ed., Twentieth Century Chinese Stories. NY: Columbia UP, 1971, 218-39.'),
(2, 'A Fallen Angel''s Complaint', '“A Fallen Angel’s Complaint.” Tr. Yingtsih Hwang. Taiwan Literature: English Translation Series 40 (2017): 107-16.'),
(3, 'Nocturne', '“Nocturne.” Tr. Patia Isake and the author. The Chinese Pen (Summer 1980): 1-34.'),
(4, 'Remains of the Dead', '“Remains of the Dead.” Tr. Steven Riep. Taiwan Literature: English Translation Series 40 (2017): 83-106.'),
(5, 'Danny Boy', '“Danny Boy.” Tr. Sylvia Li-chun Lin. Taiwan Literature: English Translation Series 40 (2017): 41-60.'),
(6, 'Tea for Two', '“Tea for Two.” Tr. Howard Goldblatt. Taiwan Literature: English Translation Series 40 (2017): 3-40.');

INSERT INTO quotes (ch_text, en_text, location_id, chapter_id) VALUES
('我们去把李彤接到了Central Park，她穿了一袭云红纱的晚礼服，相当潇洒，可是她那枚大蜘蛛不知怎地却爬到了她的肩膀的发尾上来，甩荡甩荡的，好像吊在蛛丝上一般，十分刺目。', 'We picked up Li T’ung and headed for Central Park. She wore a pink organdy gown, very chic. But this time her diamond spider had slid down almost to the end of the flowing mane around her left shoulder, swaying there as if it were suspended from some invisible filament. It was altogether striking.', 1, 1),
('周大庆早在Tavern on the Green里等我们。他新理了头发，耳际上两条发线修得十分整齐。他看见我们时立刻站了起来，脸上笑得有点僵硬，还像在大学里站在女生宿舍门口等候舞伴那么紧张。', 'Chou Ta-ch''ing had been waiting for us for some time at the Tavern-on-the-Green. He had just had his hair cut, and looked overly trim. He got up as soon as he saw us, with a stiff smile on his face, seemingly still as nervous as when, back in his college days, he had waited outside the girls'' dormitory to take his date to a dance.', 2, 1),
('张嘉行结婚，李彤替她做伴娘。李彤消瘦了不少，可是在人堆子里，还是那么突出，那么扎眼。招待会是在王医生Central Park West上的大公寓里举行的，王医生的社交很广，与会的人很多，两个大厅都挤得满满的，李彤从人堆里闪到我跟前要我陪她出去走走', 'The reception was held in Dr. Wang''s luxurious apartment on Central Park West; with his wide connections, little wonder that he had so many well-wishers gathered in the living room and dining room. Pushing through the crowd, Li T''ung came near me and asked me to take her out for a walk.', 11, 1),
('我问她是不是还住在Village里，她说已经搬了三次家了。谈笑间，李彤已经喝下去三杯Manhattan。', 'I asked her if she still lived on Lexington Avenue. She laughed and said she had moved three times since I had last seen her. She had already gulped down three drinks during our talk and her face was beginning to turn red.', 15, 1),
('当车子开进Times Square的当儿，我发觉慧芬坐在我旁边哭泣起来了。我侧过头去看她，她僵挺挺地坐着，脸朝着前方一动也不动，睁着一双眼睛，空茫失神地直视着，泪水一条条从她眼里淌了出来，她没有去揩拭，任其一滴滴掉落到她的胸前', 'When our car got near Times Square, I suddenly found that Hui-fen was weeping. She was sitting stiffly beside me, looking blankly in front of her. Tears kept rolling down her cheeks; she didn’t even try to wipe them away and let them fall on her chest.', 19, 1),
('有一个星期六，李彤提议去赌马，于是我们一行八人便到了Yonkers跑马场。李彤的男伴是个叫邓茂昌的中年男人，邓是从香港来的，在第五街上开了一个相当体面的中国古玩店。李彤说邓是个跑马专家，十押九中。', 'One Saturday she suggested horse racing. So off we went that afternoon, the eight of us, to the Yonkers racecourse. Li T’ung’s escort was Teng Mao-ch’ang, a businessman from Hong Kong in his late thirties who ran a Chinese curio shop on Fifth Avenue. Li T’ung said that Teng was an expert on horse racing, winning nine out of ten times.', 20, 1),
('Riverdale附近，全是一式酱色陈旧的公寓房子。这是个星期天，住户们都在睡早觉，街上一个人也看不见，两旁的房子，上上下下，一排排的窗户全遮上了黄色的帘子，好像许多双挖去了瞳仁的大眼睛，互相空白地瞪视着。每家房子的前方都悬了一架锯齿形的救火梯，把房面切成了迷宫似的图样。梯子都积了雪，好像那一根根黑铁上，突然生出了许多白毛来。太阳升过了屋顶，照得一条街通亮，但是空气寒冽，鲜明的阳光，没有丝毫暖意。', 'Near Riverdale, all the apartment buildings were uniform in their mustard color, showing signs of age. It was a Sunday morning, and the residents were likely still asleep, with no one visible on the street. The apartment buildings, tall and lined up, had their windows covered with yellow curtains, giving the impression of many blank, staring eyes without pupils. Each building had an angular fire escape in front, making the façade resemble a labyrinthine design. The fire escapes were covered in snow, looking as though white hair had suddenly sprouted on the black iron. The sun rose over the rooftops, brightening the street, but the air was crisp, and the bright sunlight carried no warmth.', 21, 1),
('“是吗？”李彤笑道，“我想起来了，前两个月我在Macy’s门口还碰见他，他陪他太太去买东西。他给了我他的新地址，说要请我到他家去玩。”', '"No kidding,” Li Tung laughed. “Now I remember seeing him at Macy''s four or five months ago. He was shopping with his wife. He gave me his address and asked me to visit him."', 29, 1),
('夜渐深的时分，纽约的风雪愈来愈大。在St.Mark’s Plaza的上空，那些密密麻麻的霓虹灯光，让纷纷落下的雪花，织成了一张七彩晶艳的珠网。黄凤仪从计程车里跳了出来，两手护住头，便钻进了第六街Rendezvous的地下室里去。里面早挤满了人，玫瑰色的灯光中，散满了乳白的烟色。', 'Later that night, the snowstorm in New York worsens. Above St. Mark’s Plaza, the densely packed and glowing neon lights turn the falling snowflakes into a sparkling rainbow web. Huang Fengyi hops out of a cab, both hands covering her head, and makes her way into The Rendezvous, located in a basement on Sixth Avenue. The place is already packed and milk-white cigarette smoke rises in the rose-colored light.', 4, 2),
('戴着太阳眼镜在Times Square的人潮中，让人家推着走的时候，抬起头看见那些摩天大楼，一排排在往后退，我觉得自己只有一点丁儿那么大了。淹没在这个成千万人的大城中，我觉得得到了真正的自由：一种独来独往，无人理会的自由', 'Wearing sunglasses amid the crowds in Times Square, being pushed along by others, and looking up at those skyscrapers, receding, row upon row, into the distance, makes me feel so insignificant. Buried in a city of millions, I feel I have attained true freedom—a kind of independence, a freedom from being noticed by anyone.', 19, 2),
('有一天，几个朋友载我到纽约近郊Westchester一个阔人住宅区去玩。我走过一幢花园别墅时，突然站住了脚。那是一幢很华丽的楼房，花园非常大，园里有一个白铁花棚，棚架上爬满了葡萄。园门敞开着，我竟忘情地走了进去，踱到了那个花棚下面。棚架上垂着一串串碧绿的葡萄子，非常可爱。', 'One day, some friends of mine took me to Westchester, a rich neighborhood near New York. As I was passing a well-landscaped mansion, I suddenly stopped in my tracks. It was a magnificent place with a huge garden in which there was a white, wrought-iron arbor covered with grape vines. The garden gate was open, so without thinking, I walked in and strolled over under the arbor. Clusters of bluish grapes hung from the arbor and looked quite delightful. I sat down alone on a stone bench there, and lost myself in thought for a long time.', 23, 2),
('又：以后不必再寄中国罐头来给我，我已经不做中国饭了，太麻烦。LOWER EAST SIDE，NEW YORK', 'p.s. There’s no need to send Chinese canned goods any more. I no longer cook Chinese food because it’s too much trouble.', 24, 2),
('大概是受了珮琪的鼓舞吧，吴振铎也跃跃欲试起来，到第五大道萨克斯去添置了几套时髦的新衣，胡髭头发也开始修剪得整整齐齐', 'Probably inspired by Peggy, Wuzhenduo also became eager to try, and went to Saks on Fifth Avenue to add a few sets of fashionable new clothes. He also started to trim his beard and hair neatly', 6, 3),
('周末他有时请她出去，到Latin Quarter去跳舞，握着她的手，也只是轻轻的，生怕亵渎了她。他对吕芳的情感、爱慕中，总有那么一份尊敬。', 'On weekends, he sometimes invited her out to dance at the Latin Quarter, holding her hand ever so lightly, as if afraid to defile her. In his affection and admiration for Lü Fang, there was always a certain respect', 7, 3),
('吴振铎这层公寓，占了枫丹白露大厦的四楼，正对着中央公园，从上临下，中央公园西边大道的景色，一览无遗。这是一个暮秋的午后，感恩节刚过，天气乍寒，公园里的树木，夏日蓊郁的绿叶，骤然凋落了大半，嶙嶙峋峋，露出许多苍黑虬劲的枝干来。公园外边行人道那排老榆树，树叶都焦黄了，落在地上，在秋风中瑟瑟地滚动着。道上的行人都穿上了秋装，今年时兴曳地的长裙，咖啡、古铜、金黄、奶白，仕女们，袅袅娜娜，拂地而过，西边大道上，登时秋意嫣然起来。在这个秋尽冬来的时分，纽约的曼哈顿，的确有她一份繁华过后的雍容与自如，令人心旷神怡','WuZhenDuo''s apartment occupies the fourth floor of the Fontainebleau building, directly facing Central Park. From his vantage point, he has an unobstructed view of the scenery along the park''s western avenue. It''s an afternoon in late autumn, just after Thanksgiving, and the weather has turned chilly. The trees in the park, once lush with summer greenery, have suddenly lost most of their leaves, revealing many dark and gnarled branches. Outside the park, the row of old elm trees along the pedestrian path has leaves that have turned a scorched yellow, falling to the ground and rolling in the autumn breeze. Pedestrians on the path are dressed in autumn wear, with long skirts that are fashionable this year dragging on the ground in shades of coffee, bronze, gold, and cream. The ladies, elegant and graceful, sweep by, and with them, a sense of autumn splendor emerges on the western avenue. In this time when autumn wanes and winter approaches, Manhattan in New York indeed possesses a relaxed and comfortable elegance that follows its hustle and bustle, offering a spacious and delightful experience for the soul', 1, 3),
('刘伟却安静得多了，他人小，五短身材，戴着一副酒瓶底那么厚的近视眼镜，等他们争罢了，他才慢条斯理地耸耸眼镜，说道：“肥料，中国现在最需要的，就是化学肥料！”','Liu Wei, however, was much quieter. He was short and stocky, wearing a pair of nearsighted glasses as thick as the bottom of a wine bottle. After the others had finished arguing, he slowly adjusted his glasses and said methodically, "Fertilizer, what China needs most now is chemical fertilizer!"', 2, 2),
('此外，在长岛的East Hampton上，他还购买了一幢海滨别墅，周末可以出城去度假。他常带了珮琪和大卫，到别墅的海滨去游泳打球，或者干脆躺在沙滩上晒一个下午的太阳，全家人都晒得红头赤脸回来，把大城里的苍白都晒掉。','Moreover, he purchased a seaside villa in East Hampton on Long Island, where he could go for weekend getaways out of the city. He often took Peiqi and David to the villa''s beach for swimming and playing ball, or simply to lie on the sand and bask in the sun for an afternoon. The whole family would return home sunburned, shedding the pallor of the big city life.', 18, 3),
('上次珮琪来找他，商量大卫明年上哈佛大学的事宜，他请她到五十七街那家白俄餐馆Russian Tearoom去吃俄国大菜，基辅鸡，两个人三杯“凡亚舅舅”下肚，竟谈得兴高采烈起来——从前两夫妻在一块儿，到了末期，三天竟找不出两句话——珮琪滔滔不绝，谈到她那位炒房地产的男朋友，容光焕发','Last time Peggy came to see him to discuss David''s admission to Harvard University next year, he invited her to the Russian Tea Room on 57th Street for a Russian feast, including Chicken Kiev. After three rounds of ''Uncle Vanya'' cocktails, they found themselves talking excitedly — a contrast to the later days of their marriage when they could hardly find two words to say to each other over three days. Peiqi spoke non-stop, glowing as she talked about her real estate investor boyfriend', 25, 3),
('那天他约了西奈山医院那个既风趣又风骚的麻醉师','That day he had arranged to meet with the charming and seductive anesthetist from Mount Sinai Hospital', 26, 3),
('安娜·波兰斯基女士—— 一个波兰没落贵族的后裔—— 一块儿到大都会去听Leontyne Price的《阿依达》','Ms. Anna Polanski — a descendant of a declined Polish nobility — to go to the Metropolitan Opera together to listen to Leontyne Price perform ''Aida''', 27, 3),
('那次在卡耐基礼堂中，肖邦逝世百周年比赛会上，吕芳穿着一袭宝蓝的长裙，一头乌浓的长发，那首《英雄波兰舞曲》一奏完，双手潇洒地一扬，台下喝彩的声音，直持续了几分钟。台上那只最大的花篮便是他送的，有成百朵的白菊花','At the Chopin Bicentennial Competition at Carnegie Hall, Lü Fang wore a sapphire blue gown with her long, dark hair flowing down her back. After she finished playing the ''Heroic Polonaise'', she lifted her hands gracefully, and the applause from the audience continued for several minutes. The largest bouquet on the stage, with hundreds of white chrysanthemums, was sent by him', 30, 3);
