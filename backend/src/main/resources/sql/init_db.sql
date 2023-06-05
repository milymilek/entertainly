--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

ALTER ROLE "user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:MbpYxVmlm/imjTJ8wH4TBg==$KWWsMQiONZLuUYr/0P1BzdvyUDtOQDiu3hO917Mg874=:MR6vmGX/ZTDIh+kYvFu+qQ1eZ3QSogmRXKMA3NO7NTU=';

--
-- User Configurations
--

--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO "user";

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: user
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: user
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO "user";

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authorities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authorities (
    id bigint NOT NULL,
    authority character varying(255),
    username character varying(255)
);


ALTER TABLE public.authorities OWNER TO "user";

--
-- Name: authorities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.authorities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorities_id_seq OWNER TO "user";

--
-- Name: authorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.authorities_id_seq OWNED BY public.authorities.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.categories OWNER TO "user";

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO "user";

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    address character varying(255),
    description character varying(255),
    end_time timestamp without time zone,
    event_creator_id bigint,
    start_time timestamp without time zone,
    category_id bigint
);


ALTER TABLE public.events OWNER TO "user";

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO "user";

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: events_participants; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.events_participants (
    events_id bigint NOT NULL,
    participants_username character varying(255) NOT NULL
);


ALTER TABLE public.events_participants OWNER TO "user";

--
-- Name: items; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.items (
    id bigint NOT NULL,
    name character varying(255),
    price numeric(19,2),
    uuid character varying(255),
    vendor character varying(255)
);


ALTER TABLE public.items OWNER TO "user";

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO "user";

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.message (
    message_id bigint NOT NULL,
    content character varying(255),
    created_at timestamp without time zone,
    category_id bigint,
    username character varying(255)
);


ALTER TABLE public.message OWNER TO "user";

--
-- Name: message_message_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_message_id_seq OWNER TO "user";

--
-- Name: message_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.message_message_id_seq OWNED BY public.message.message_id;


--
-- Name: token; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.token (
    id bigint NOT NULL,
    created timestamp without time zone,
    token character varying(255)
);


ALTER TABLE public.token OWNER TO "user";

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_id_seq OWNER TO "user";

--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.token_id_seq OWNED BY public.token.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    username character varying(255) NOT NULL,
    email character varying(255),
    enabled integer NOT NULL,
    id bigint,
    password character varying(255)
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: users_categories; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users_categories (
    user_username character varying(255) NOT NULL,
    categories_id bigint NOT NULL
);


ALTER TABLE public.users_categories OWNER TO "user";

--
-- Name: authorities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authorities ALTER COLUMN id SET DEFAULT nextval('public.authorities_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: message message_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.message ALTER COLUMN message_id SET DEFAULT nextval('public.message_message_id_seq'::regclass);


--
-- Name: token id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.token ALTER COLUMN id SET DEFAULT nextval('public.token_id_seq'::regclass);


--
-- Data for Name: authorities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authorities (id, authority, username) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.categories (id, name) FROM stdin;
0	Acting
1	Action Figures
2	Adventure park
3	Aerobics
4	Air hockey
5	Air sports
6	Airbrushing
7	Aircraft
8	Aircraft spotting
9	Airsoft
10	All-Terrain vehicles
11	Alternate reality games
12	Alternative
13	Amateur Radio
14	Amateur astronomy
15	Amateur geology
16	Amateur meteorology
18	American football
19	Amusement Park
21	Animal
22	Animal care
23	Antiques
24	Antiquing
25	Antiquities
26	Aquariums
27	Arcade Games
28	Archaeology
29	Archery
30	Archery/Crossbow
31	Architecture
32	Aromatherapy
33	Art Activities
34	Art Collecting / Collectibles
35	Art and Crafts
36	Art collecting
37	Art/antique collecting
38	Arts and Crafts
39	Arts/cultural
40	Artwork
41	Association football
42	Astrology
43	Astronomy
44	Audiophilia
45	Australian Football League
46	Auto audiophilia
47	Auto racing
48	Autographs
49	Automotive work/repair
50	BMX tricks
51	Back packing
52	Backgamon
53	Backpacking
54	Badge Collecting
55	Badminton
56	Baking
57	Ballet
58	Ballet Dancing
59	Ballooning
60	Scuba
61	Scuba Diving
63	Sculling or Rowing
64	Sculpting
65	Sculpture
66	Seaglass collecting
67	Seashell collecting
68	Seashells
69	Self-Improvement
70	Self-Improvement Courses
71	Service
72	Sewing
73	Shoes
74	Shooting guns
75	Shooting sport
76	Shopping
77	Shopping for latest trends
78	Shortwave listening
79	Show Choir
80	Sightseeing
81	Singing
82	Singing Lessons
83	Singing games
84	Singing/composing music
85	Skate Boarding
86	Skateboarding
87	Skateboarding/rollerblading
88	Skating
89	Skiing
90	Skill games
91	playing soccer
92	free diving
93	diving
94	Skincare Regime
95	Sky diving
96	Skydiving
97	Skype
98	Sky running
99	Sledding
100	Slot car racing
101	Snake
102	Snooker
103	Snorkeling
104	Snow Biking
105	Snow Skiing
107	Snowboarding
108	Snowmobile Riding
109	Snowmobiles
110	Snowmobiling
111	Snowshoeing
112	Soap making
113	Soccer
114	Social
115	Social Networking
116	Soft Rock
117	Softball
118	Space Exploration
119	Speed Skating
120	Spider
121	Spinning
122	Sport fishing
123	Sporting dog field trials
124	Sporting interests
125	Sports
126	Sports Cards
127	Sports memorabilia
128	Sports on TV
129	Squash
130	Stained Glass
131	Stamp Collecting
132	Stamps
133	Stargazing
134	Stereo
135	Stocks
136	Stone collecting
137	Street Racing
138	Street games
139	Sudoku Puzzles
140	Sunbathing
141	Surfing
142	Survey date
143	Sweepstakes
144	Sweepstake
145	Swimming
146	Swimming pool
147	Table Tennis
148	Table football
150	Tabletop games
151	Tai Chi
152	Tango Dance
153	Target shooting
154	Tarot
155	Tarot card reading
156	Taxidermy
157	Team Games
158	Telescopes
159	Ten Pin Bowling
160	Tennis
161	Texting
162	Theater Sports
163	Theater/Performing Arts
164	Theatre
165	Third person shooter games
166	Thriller
167	Tie dying
168	Tile-based games
169	Timeshare
170	Touch football
171	Tour skating
172	Toys
173	Track &amp
174	 Field
175	Train Spotting
176	Trainspotting
177	Trap
178	Travel
179	Travel games
180	Traveling
181	Traveling and exploration
182	Treasure Hunting
184	Tree climbing
185	Trekkie
186	Trekking
187	Turtle
188	Tutoring
189	Types of Recreation
190	US Travel
191	Urban exploration
192	Vacation cruises
193	Vacations
194	Vehicle restoration
195	Veterans
196	Video Games
198	Video gaming
199	DVD
200	Video
201	Videophilia
202	Vintage Books
203	Vintage car
204	Vintage clothing
205	Vitamin supplements
206	Volleyball
207	Volunteering
208	Walking
209	Walking and Hiking
210	Walking/health
211	Wall Art
212	Want further mailings
213	Wargames
214	Warships
215	Watching Movies
216	Watching Sports
217	Watching TV
219	Water Polo
220	Water Skiing
221	Water sports
222	Watercolor Paintings
223	Weather Forecasting
224	Weaving
225	Websites
226	Weight training
227	Weightlifting
228	White Water Rafting
229	Whitewater rafting
230	Wildlife safari   Snorkeling A
231	Wildlife
232	Wind Surfing
233	Windsurfing
234	Windsurfing Kayaking
235	Wine Appreciation
236	Wine Making
237	Wine tasting
238	Wines
239	Wingsuit flying
240	Wood Carving
241	Wood Working
242	Woodworking
243	Word games
244	World news or politics
245	Worldbuilding
246	Worship Team
247	Wrestling
248	Writing
249	Yachting
250	Yo-yoing
251	YoYo
252	Yoga
253	Youth Band
254	Youth Group
256	Zumba
257	cooperative games
258	courses
259	deck building games
260	insects
261	knotting
262	leaves
263	magician
264	angling/Fly fishing
265	real time games
266	rocks
267	strategy games
268	thematic games
269	Aeromodeling
271	Airsofting
272	Animal fancy
273	dogs
274	pets
275	Animals
276	Aqua-lung
277	Aquarium
278	Arts
279	Backgammon
280	Base Jumping
281	Baseball
282	Basketball
283	Baton Twirling
284	Beach Volleyball
285	Sun tanning
286	Beach
287	Beachcombing
288	Beadwork
289	Beatboxing
290	Beekeeping
291	Bell Ringing
292	Belly Dancing
293	Bicycle Polo
294	Bicycling
295	Billiards
296	Bird watching
297	Birding
298	Birdwatching
299	Blacksmithing
300	Blogging
301	BMX
302	Board games
303	Board sports
304	BoardGames
305	Boating
306	Body Building
307	Bodybuilding
308	Bonsai Tree
309	Book collecting
310	Bookbinding
311	Boomerangs
312	Bowling
313	Boxing
314	Brazilian jiu-jitsu
315	Breakdancing
316	Brewing Beer
317	Bridge
318	Bridge Building
319	Bringing Food To The Disabled
320	Building Dollhouses
321	Bus spotting
322	Butterfly Watching
323	Button Collecting
324	Cake Decorating
325	Calligraphy
326	Camping
327	Candle making
328	Canoeing
329	Car Racing
330	Card collecting
331	Cartooning
332	Casino Gambling
333	Cave Diving
334	Ceramics
335	Cheerleading
336	Chess
337	Church/church activities
338	Cigar Smoking
339	Climbing
340	Cloud Watching
341	Coin Collecting
342	Collecting
343	Collecting Antiques
344	Collecting Artwork
345	Collecting Hats
346	Collecting Music Albums
347	Collecting RPM Records
348	Collecting Sports Cards
349	Collecting Swords
350	Color guard
351	Coloring
352	Comic book collecting
353	Compose Music
354	Computer activities
355	Computer programming
356	Conworlding
357	Cooking
358	Cosplay
359	Cosplaying
360	Couponing
361	Crafts
362	Creative writing
363	Cricket
364	Crochet
365	Crocheting
366	Cross-Stitch
367	Crossword Puzzles
368	Cryptography
369	Curling
370	Cycling
371	Dance
372	Dancing
373	Darts
374	Debate
375	Deltiology
376	Diecast Collectibles
377	Digital arts
378	Digital Photography
379	Disc golf
380	Do it yourself
381	Dodgeball
382	Dog sport
383	Dolls
384	Dominoes
385	Dowsing
386	Drama
387	Drawing
388	Driving
389	Dumpster Diving
390	Eating out
391	Educational Courses
392	Electronics
393	Element collecting
394	Embroidery
395	Entertaining
396	Equestrianism
398	Exercise
399	Exhibition drill
400	Falconry
401	Fast cars
402	Felting
403	Fencing
404	Field hockey
405	Figure skating
406	Fire Poi
407	Fishing
408	Fishkeeping
409	Flag Football
410	Floorball
411	Floral Arrangements
412	Flower arranging
413	Flower collecting and pressing
414	Fly Tying
415	Flying
416	Footbag
417	Football
418	Foraging
419	Foreign language learning
420	Fossil hunting
421	Four Wheeling
422	Freshwater Aquariums
423	Frisbee Golf
424	Gambling
425	Games
426	Gaming
427	Garage Saleing
428	Gardening
429	Genealogy
430	Geocaching
431	Ghost hunting
432	Glassblowing
433	Glowsticking
434	Gnoming
435	Going to movies
436	Golf
437	Golfing
438	Gongoozling
439	Graffiti
440	Grip Strength
441	Guitar
442	Gun Collecting
443	Gunsmithing
444	Gymnastics
445	Gyotaku
446	Handball
447	Handwriting Analysis
448	Hang gliding
449	Herping
450	Hiking
451	Home Brewing
452	Home Repair
453	Home Theater
454	Homebrewing
455	Hooping
456	Horse riding
457	Hot air ballooning
458	Hula Hooping
459	Hunting
460	Ice hockey
461	Ice skating
462	Iceskating
463	Illusion
464	Impersonations
465	Inline skating
466	Insect collecting
467	Internet
468	Inventing
469	Jet Engines
470	Jewelry Making
471	Jigsaw Puzzles
472	Jogging
473	Judo
474	Juggling
475	Jukskei
476	Jump Roping
477	Kabaddi
478	Kart racing
479	Kayaking
480	Keep A Journal
481	Kitchen Chemistry
482	Kite Boarding
483	Kite flying
484	Kites
485	Kitesurfing
486	Knapping
487	Knife making
488	Knife throwing
489	Knitting
491	Lacemaking
492	Lacrosse
493	Lapidary
494	LARPing
495	Laser tag
496	Lasers
497	Lawn Darts
498	Learn to Play Poker
499	Learning A Foreign Language
500	Learning An Instrument
501	Learning To Pilot A Plane
502	Leather crafting
503	Leathercrafting
504	Lego building
505	Legos
506	Letterboxing
507	Listening to music
508	Locksport
509	Machining
510	Macramé
511	Macrame
512	Magic
513	Mahjong
514	Making Model Cars
515	Marbles
516	Marksmanship
517	Martial arts
518	Matchstick Modeling
519	Meditation
520	Metal detecting
521	Meteorology
522	Microscopy
523	Mineral collecting
524	Model aircraft
525	Model building
526	Model Railroading
527	Model Rockets
528	Modeling Ships
529	Models
530	Motor sports
531	Motorcycles
532	Mountain Biking
533	Mountain Climbing
534	Mountaineering
535	Movie and movie memorabilia collecting
536	Mushroom hunting/Mycology
537	Musical Instruments
538	Nail Art
539	Needlepoint
540	Netball
541	Nordic skating
542	Orienteering
543	Origami
544	Owning An Antique Car
545	Paintball
546	Painting
547	Papermache
548	Papermaking
549	Parachuting
550	Paragliding or Power Paragliding
551	Parkour
552	People Watching
553	Photography
554	Piano
555	Pigeon racing
556	Pinochle
557	Pipe Smoking
558	Planking
559	Playing music
560	Playing musical instruments
561	Playing team sports
562	Poker
563	Pole Dancing
564	Polo
565	Pottery
566	Powerboking
567	Protesting
568	Puppetry
569	Puzzles
570	Pyrotechnics
571	Quilting
572	R/C Boats
573	R/C Cars
574	R/C Helicopters
575	R/C Planes
576	Racing Pigeons
577	Racquetball
578	Radio-controlled car racing
579	Rafting
580	Railfans
581	Rappelling
582	Rapping
583	Reading
584	Reading To The Elderly
585	Record collecting
586	Relaxing
587	Renaissance Faire
588	Renting movies
589	Rescuing Abused
590	 Abandoned Animals
591	Robotics
592	Rock balancing
593	Rock climbing
594	Rock Collecting
595	Rockets
596	Rocking AIDS Babies
597	Roleplaying
598	Roller derby
599	Roller skating
600	Rugby
601	Rugby league football
602	Running
603	Sailing
604	Saltwater Aquariums
605	Sand art
606	Sand Castles
607	Scrapbooking
608	Sea glass collecting
609	Self Defense
610	Shark Fishing
611	Shooting
612	Singing In Choir
613	Skeet Shooting
614	Sketching
615	Skimboarding
617	Slack Lining
618	Slacklining
619	Sleeping
620	Slingshots
622	Soapmaking
623	Socializing with friends/neighbors
624	Speed Cubing
626	Spelunkering
627	Spending time with family/kids
628	Stand-up comedy
629	Stone skipping
630	Storm Chasing
631	Storytelling
632	String Figures
633	Sudoku
634	Surf Fishing
635	Survival
636	Taekwondo
638	Tatting
639	Tea Tasting
640	Tesla Coils
641	Tetris
642	Textiles
643	Tombstone Rubbing
644	Tool Collecting
645	Toy Collecting
646	Train Collecting
647	Triathlon
648	Tutoring Children
649	TV watching
650	Ultimate Frisbee
651	Video game collecting
652	Vintage cars
653	Violin
654	Volunteer
655	Warhammer
656	Watching sporting events
657	Weather Watcher
658	Web surfing
660	Working In A Food Pantry
661	Working on cars
662	World Record Breaking
663	Writing Music
664	Writing Songs
665	Ziplining
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.events (id, address, description, end_time, event_creator_id, start_time, category_id) FROM stdin;
\.


--
-- Data for Name: events_participants; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.events_participants (events_id, participants_username) FROM stdin;
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.items (id, name, price, uuid, vendor) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.message (message_id, content, created_at, category_id, username) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.token (id, created, token) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (username, email, enabled, id, password) FROM stdin;
\.


--
-- Data for Name: users_categories; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users_categories (user_username, categories_id) FROM stdin;
\.


--
-- Name: authorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.authorities_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.events_id_seq', 1, false);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.items_id_seq', 1, false);


--
-- Name: message_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.message_message_id_seq', 1, false);


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.token_id_seq', 1, false);


--
-- Name: authorities authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT authorities_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: events_participants events_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events_participants
    ADD CONSTRAINT events_participants_pkey PRIMARY KEY (events_id, participants_username);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (message_id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: message fk2d6u4bvaabbi945fij1ld3uj9; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk2d6u4bvaabbi945fij1ld3uj9 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: message fk2j3i99a4wysg3yufghmkv54mg; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk2j3i99a4wysg3yufghmkv54mg FOREIGN KEY (username) REFERENCES public.users(username);


--
-- Name: users_categories fk2q0l9ao0evb67ubu3evvaw03r; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users_categories
    ADD CONSTRAINT fk2q0l9ao0evb67ubu3evvaw03r FOREIGN KEY (user_username) REFERENCES public.users(username);


--
-- Name: events_participants fk332julvlns5a989h0com6eht7; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events_participants
    ADD CONSTRAINT fk332julvlns5a989h0com6eht7 FOREIGN KEY (participants_username) REFERENCES public.users(username);


--
-- Name: items fk5a8o8tj4xcigeovtinv7d0ib2; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk5a8o8tj4xcigeovtinv7d0ib2 FOREIGN KEY (vendor) REFERENCES public.users(username);


--
-- Name: authorities fkhjuy9y4fd8v5m3klig05ktofg; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT fkhjuy9y4fd8v5m3klig05ktofg FOREIGN KEY (username) REFERENCES public.users(username);


--
-- Name: events fko6mla8j1p5bokt4dxrlmgwc28; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fko6mla8j1p5bokt4dxrlmgwc28 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: users_categories fkql128cyq5j4yx8ilmqutnrlu9; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users_categories
    ADD CONSTRAINT fkql128cyq5j4yx8ilmqutnrlu9 FOREIGN KEY (categories_id) REFERENCES public.categories(id);


--
-- Name: events_participants fkrwil1qdlw36dv5y5m51pdgn0x; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.events_participants
    ADD CONSTRAINT fkrwil1qdlw36dv5y5m51pdgn0x FOREIGN KEY (events_id) REFERENCES public.events(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

