--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

ALTER ROLE "user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:geWsiBMJbgkneBcbzsrYrw==$0t01b0ejCSYl60VKYBvk85gYdU/U9Q72aPyz9PQNbjQ=:Dbi1LZ26HFDDFU9T/rrk47NQpQhPRNfo9POKiYobCmE=';

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
17	Amateur radio
18	American football
19	Amusement Park
20	Amusement park
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
62	Scuba diving
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
89	Skating
90	Skiing
91	Skill games
92	playing soccer
93	free diving
94	diving
95	Skincare Regime
96	Sky diving
97	Skydiving
98	Skydiving
99	Skype
100	Sky running
101	Sledding
102	Slot car racing
103	Snake
104	Snooker
105	Snorkeling
106	Snow Biking
107	Snow Skiing
108	Snow skiing
109	Snowboarding
110	Snowmobile Riding
111	Snowmobiles
112	Snowmobiling
113	Snowshoeing
114	Soap making
115	Soccer
116	Social
117	Social Networking
118	Soft Rock
119	Softball
120	Space Exploration
121	Speed Skating
122	Spider
123	Spinning
124	Sport fishing
125	Sporting dog field trials
126	Sporting interests
127	Sports
128	Sports Cards
129	Sports memorabilia
130	Sports on TV
131	Squash
132	Stained Glass
133	Stamp Collecting
134	Stamps
135	Stargazing
136	Stereo
137	Stocks
138	Stone collecting
139	Street Racing
140	Street games
141	Sudoku Puzzles
142	Sunbathing
143	Surfing
144	Survey date
145	Sweepstakes
146	Sweepstake
147	Swimming
148	Swimming pool
149	Table Tennis
150	Table football
151	Table tennis
152	Tabletop games
153	Tai Chi
154	Tango Dance
155	Target shooting
156	Target shooting
157	Tarot
158	Tarot card reading
159	Taxidermy
160	Team Games
161	Telescopes
162	Ten Pin Bowling
163	Tennis
164	Texting
165	Theater Sports
166	Theater/Performing Arts
167	Theatre
168	Third person shooter games
169	Thriller
170	Tie dying
171	Tile-based games
172	Timeshare
173	Touch football
174	Tour skating
175	Toys
176	Track &amp
177	 Field
178	Train Spotting
179	Trainspotting
180	Trap
181	Travel
182	Travel games
183	Traveling
184	Traveling and exploration
185	Treasure Hunting
186	Treasure hunting
187	Tree climbing
188	Trekkie
189	Trekking
190	Turtle
191	Tutoring
192	Types of Recreation
193	US Travel
194	Urban exploration
195	Vacation cruises
196	Traveling
197	Vacations
198	Vehicle restoration
199	Veterans
200	Video Games
201	Video games
202	Video gaming
203	DVD
204	Video
205	Videophilia
206	Vintage Books
207	Vintage car
208	Vintage clothing
209	Vitamin supplements
210	Volleyball
211	Volunteering
212	Walking
213	Walking and Hiking
214	Walking/health
215	Wall Art
216	Want further mailings
217	Wargames
218	Warships
219	Watching Movies
220	Watching Sports
221	Watching TV
222	Watching movies
223	Water Polo
224	Water Skiing
225	Water sports
226	Watercolor Paintings
227	Weather Forecasting
228	Weaving
229	Websites
230	Weight training
231	Weightlifting
232	White Water Rafting
233	Whitewater rafting
234	Wildlife safari   Snorkeling A
235	Wildlife
236	Wind Surfing
237	Windsurfing
238	Windsurfing Kayaking
239	Wine Appreciation
240	Wine Making
241	Wine tasting
242	Wines
243	Wingsuit flying
244	Wood Carving
245	Wood Working
246	Woodworking
247	Word games
248	World news or politics
249	Worldbuilding
250	Worship Team
251	Wrestling
252	Writing
253	Yachting
254	Yo-yoing
255	YoYo
256	Yoga
257	Youth Band
258	Youth Group
259	Yoyo
260	Zumba
261	cooperative games
262	courses
263	deck building games
264	insects
265	knotting
266	leaves
267	magician
268	angling/Fly fishing
269	real time games
270	rocks
271	strategy games
272	thematic games
273	Acting
274	Aeromodeling
275	Air sports
276	Airbrushing
277	Aircraft Spotting
278	Airsoft
279	Airsofting
280	Amateur astronomy
281	Amateur geology
282	Amateur Radio
283	American football
284	Animal fancy
285	dogs
286	pets
287	Animals
288	Antiquing
289	Antiquities
290	Aqua-lung
291	Aquarium
292	Archery
293	Art collecting
294	Arts
295	Association football
296	Astrology
297	Astronomy
298	Audiophilia
299	Auto audiophilia
300	Auto racing
301	Backgammon
302	Backpacking
303	Badminton
304	Base Jumping
305	Baseball
306	Basketball
307	Baton Twirling
308	Beach Volleyball
309	Sun tanning
310	Beach
311	Beachcombing
312	Beadwork
313	Beatboxing
314	Beekeeping
315	Bell Ringing
316	Belly Dancing
317	Bicycle Polo
318	Bicycling
319	Billiards
320	Bird watching
321	Birding
322	Birdwatching
323	Blacksmithing
324	Blogging
325	BMX
326	Board games
327	Board sports
328	BoardGames
329	Boating
330	Body Building
331	Bodybuilding
332	Bonsai Tree
333	Book collecting
334	Bookbinding
335	Boomerangs
336	Bowling
337	Boxing
338	Brazilian jiu-jitsu
339	Breakdancing
340	Brewing Beer
341	Bridge
342	Bridge Building
343	Bringing Food To The Disabled
344	Building Dollhouses
345	Bus spotting
346	Butterfly Watching
347	Button Collecting
348	Cake Decorating
349	Calligraphy
350	Camping
351	Candle making
352	Canoeing
353	Car Racing
354	Card collecting
355	Cartooning
356	Casino Gambling
357	Cave Diving
358	Ceramics
359	Cheerleading
360	Chess
361	Church/church activities
362	Cigar Smoking
363	Climbing
364	Cloud Watching
365	Coin Collecting
366	Collecting
367	Collecting Antiques
368	Collecting Artwork
369	Collecting Hats
370	Collecting Music Albums
371	Collecting RPM Records
372	Collecting Sports Cards
373	Collecting Swords
374	Color guard
375	Coloring
376	Comic book collecting
377	Compose Music
378	Computer activities
379	Computer programming
380	Conworlding
381	Cooking
382	Cosplay
383	Cosplaying
384	Couponing
385	Crafts
386	Creative writing
387	Cricket
388	Crochet
389	Crocheting
390	Cross-Stitch
391	Crossword Puzzles
392	Cryptography
393	Curling
394	Cycling
395	Dance
396	Dancing
397	Darts
398	Debate
399	Deltiology
400	Diecast Collectibles
401	Digital arts
402	Digital Photography
403	Disc golf
404	Do it yourself
405	Dodgeball
406	Dog sport
407	Dolls
408	Dominoes
409	Dowsing
410	Drama
411	Drawing
412	Driving
413	Dumpster Diving
414	Eating out
415	Educational Courses
416	Electronics
417	Element collecting
418	Embroidery
419	Entertaining
420	Equestrianism
421	aerobics
422	Exercise
423	Exhibition drill
424	Falconry
425	Fast cars
426	Felting
427	Fencing
428	Field hockey
429	Figure skating
430	Fire Poi
431	Fishing
432	Fishkeeping
433	Flag Football
434	Floorball
435	Floral Arrangements
436	Flower arranging
437	Flower collecting and pressing
438	Fly Tying
439	Flying
440	Footbag
441	Football
442	Foraging
443	Foreign language learning
444	Fossil hunting
445	Four Wheeling
446	Freshwater Aquariums
447	Frisbee Golf
448	Gambling
449	Games
450	Gaming
451	Garage Saleing
452	Gardening
453	Genealogy
454	Geocaching
455	Ghost hunting
456	Glassblowing
457	Glowsticking
458	Gnoming
459	Going to movies
460	Golf
461	Golfing
462	Gongoozling
463	Graffiti
464	Grip Strength
465	Guitar
466	Gun Collecting
467	Gunsmithing
468	Gymnastics
469	Gyotaku
470	Handball
471	Handwriting Analysis
472	Hang gliding
473	Herping
474	Hiking
475	Home Brewing
476	Home Repair
477	Home Theater
478	Homebrewing
479	Hooping
480	Horse riding
481	Hot air ballooning
482	Hula Hooping
483	Hunting
484	Ice hockey
485	Ice skating
486	Iceskating
487	Illusion
488	Impersonations
489	Inline skating
490	Insect collecting
491	Internet
492	Inventing
493	Jet Engines
494	Jewelry Making
495	Jigsaw Puzzles
496	Jogging
497	Judo
498	Juggling
499	Jukskei
500	Jump Roping
501	Kabaddi
502	Kart racing
503	Kayaking
504	Keep A Journal
505	Kitchen Chemistry
506	Kite Boarding
507	Kite flying
508	Kites
509	Kitesurfing
510	Knapping
511	Knife making
512	Knife throwing
513	Knitting
514	Knotting
515	Lacemaking
516	Lacrosse
517	Lapidary
518	LARPing
519	Laser tag
520	Lasers
521	Lawn Darts
522	Learn to Play Poker
523	Learning A Foreign Language
524	Learning An Instrument
525	Learning To Pilot A Plane
526	Leather crafting
527	Leathercrafting
528	Lego building
529	Legos
530	Letterboxing
531	Listening to music
532	Locksport
533	Machining
534	Macramé
535	Macrame
536	Magic
537	Mahjong
538	Making Model Cars
539	Marbles
540	Marksmanship
541	Martial arts
542	Matchstick Modeling
543	Meditation
544	Metal detecting
545	Meteorology
546	Microscopy
547	Mineral collecting
548	Model aircraft
549	Model building
550	Model Railroading
551	Model Rockets
552	Modeling Ships
553	Models
554	Motor sports
555	Motorcycles
556	Mountain Biking
557	Mountain Climbing
558	Mountaineering
559	Movie and movie memorabilia collecting
560	Mushroom hunting/Mycology
561	Musical Instruments
562	Nail Art
563	Needlepoint
564	Netball
565	Nordic skating
566	Orienteering
567	Origami
568	Owning An Antique Car
569	Paintball
570	Painting
571	Papermache
572	Papermaking
573	Parachuting
574	Paragliding or Power Paragliding
575	Parkour
576	People Watching
577	Photography
578	Piano
579	Pigeon racing
580	Pinochle
581	Pipe Smoking
582	Planking
583	Playing music
584	Playing musical instruments
585	Playing team sports
586	Poker
587	Pole Dancing
588	Polo
589	Pottery
590	Powerboking
591	Protesting
592	Puppetry
593	Puzzles
594	Pyrotechnics
595	Quilting
596	R/C Boats
597	R/C Cars
598	R/C Helicopters
599	R/C Planes
600	Racing Pigeons
601	Racquetball
602	Radio-controlled car racing
603	Rafting
604	Railfans
605	Rappelling
606	Rapping
607	Reading
608	Reading To The Elderly
609	Record collecting
610	Relaxing
611	Renaissance Faire
612	Renting movies
613	Rescuing Abused
614	 Abandoned Animals
615	Robotics
616	Rock balancing
617	Rock climbing
618	Rock Collecting
619	Rockets
620	Rocking AIDS Babies
621	Roleplaying
622	Roller derby
623	Roller skating
624	Rugby
625	Rugby league football
626	Running
627	Sailing
628	Saltwater Aquariums
629	Sand art
630	Sand Castles
631	Scrapbooking
632	Scuba diving
633	Sculling or Rowing
634	Sculpting
635	Sea glass collecting
636	Seashell collecting
637	Self Defense
638	Sewing
639	Shark Fishing
640	Shooting
641	Shooting sport
642	Shopping
643	Shortwave listening
644	Singing
645	Singing In Choir
646	Skateboarding
647	Skeet Shooting
648	Sketching
649	Skiing
650	Skimboarding
651	Sky Diving
652	Skydiving
653	Slack Lining
654	Slacklining
655	Sleeping
656	Slingshots
657	Slot car racing
658	Snorkeling
659	Snowboarding
660	Soap Making
661	Soapmaking
662	Socializing with friends/neighbors
663	Speed Cubing
664	Speed skating
665	Spelunkering
666	Spending time with family/kids
667	Sports
668	Squash
669	Stamp Collecting
670	Stand-up comedy
671	Stone collecting
672	Stone skipping
673	Storm Chasing
674	Storytelling
675	String Figures
676	Sudoku
677	Surf Fishing
678	Surfing
679	Survival
680	Swimming
681	Table football
682	Table tennis
683	Taekwondo
684	Tai chi
685	Tatting
686	Taxidermy
687	Tea Tasting
688	Tennis
689	Tesla Coils
690	Tetris
691	Textiles
692	Texting
693	Tombstone Rubbing
694	Tool Collecting
695	Tour skating
696	Toy Collecting
697	Train Collecting
698	Train Spotting
699	Trainspotting
700	Traveling
701	Treasure Hunting
702	Trekkie
703	Triathlon
704	Tutoring Children
705	TV watching
706	Ultimate Frisbee
707	Urban exploration
708	Vehicle restoration
709	Video game collecting
710	Video Games
711	Video gaming
712	Videophilia
713	Vintage cars
714	Violin
715	Volleyball
716	Volunteer
717	Walking
718	Warhammer
719	Watching movies
720	Watching sporting events
721	Water sports
722	Weather Watcher
723	Web surfing
724	Weightlifting
725	Windsurfing
726	Wine Making
727	Wood carving
728	Woodworking
729	Working In A Food Pantry
730	Working on cars
731	World Record Breaking
732	Worldbuilding
733	Wrestling
734	Writing
735	Writing Music
736	Writing Songs
737	Yo-yoing
738	Yoga
739	YoYo
740	Ziplining
741	Zumba
742	Acting
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

SELECT pg_catalog.setval('public.categories_id_seq', 2223, true);


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

