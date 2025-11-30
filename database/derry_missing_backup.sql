--
-- PostgreSQL database dump
--

\restrict 3LqkK3XRZXZ6rfYaTfFjnqavmJFg0qtchilIwCLggRdjhhXFfEhKV3Y9zDLh7dK

-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: personal_effects; Type: TABLE; Schema: public; Owner: derry_admin
--

CREATE TABLE public.personal_effects (
    id integer NOT NULL,
    victim_id integer,
    item_description character varying(255) NOT NULL,
    found_location character varying(255),
    found_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.personal_effects OWNER TO derry_admin;

--
-- Name: personal_effects_id_seq; Type: SEQUENCE; Schema: public; Owner: derry_admin
--

CREATE SEQUENCE public.personal_effects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_effects_id_seq OWNER TO derry_admin;

--
-- Name: personal_effects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: derry_admin
--

ALTER SEQUENCE public.personal_effects_id_seq OWNED BY public.personal_effects.id;


--
-- Name: sightings; Type: TABLE; Schema: public; Owner: derry_admin
--

CREATE TABLE public.sightings (
    id integer NOT NULL,
    victim_id integer,
    location character varying(255) NOT NULL,
    witness_name character varying(200),
    sighting_date date NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sightings OWNER TO derry_admin;

--
-- Name: sightings_id_seq; Type: SEQUENCE; Schema: public; Owner: derry_admin
--

CREATE SEQUENCE public.sightings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sightings_id_seq OWNER TO derry_admin;

--
-- Name: sightings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: derry_admin
--

ALTER SEQUENCE public.sightings_id_seq OWNED BY public.sightings.id;


--
-- Name: victims; Type: TABLE; Schema: public; Owner: derry_admin
--

CREATE TABLE public.victims (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    nickname character varying(50),
    age_at_disappearance integer NOT NULL,
    date_of_birth date NOT NULL,
    disappearance_date date NOT NULL,
    last_seen_location character varying(255) NOT NULL,
    physical_description text,
    photo_url character varying(500),
    status character varying(50) DEFAULT 'Missing'::character varying,
    case_number character varying(50) NOT NULL,
    decade character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.victims OWNER TO derry_admin;

--
-- Name: victims_id_seq; Type: SEQUENCE; Schema: public; Owner: derry_admin
--

CREATE SEQUENCE public.victims_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.victims_id_seq OWNER TO derry_admin;

--
-- Name: victims_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: derry_admin
--

ALTER SEQUENCE public.victims_id_seq OWNED BY public.victims.id;


--
-- Name: personal_effects id; Type: DEFAULT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.personal_effects ALTER COLUMN id SET DEFAULT nextval('public.personal_effects_id_seq'::regclass);


--
-- Name: sightings id; Type: DEFAULT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.sightings ALTER COLUMN id SET DEFAULT nextval('public.sightings_id_seq'::regclass);


--
-- Name: victims id; Type: DEFAULT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.victims ALTER COLUMN id SET DEFAULT nextval('public.victims_id_seq'::regclass);


--
-- Data for Name: personal_effects; Type: TABLE DATA; Schema: public; Owner: derry_admin
--

COPY public.personal_effects (id, victim_id, item_description, found_location, found_date, created_at) FROM stdin;
1	7	Library book	The Barrens	1930-08-31	2025-11-30 02:25:41.169424
2	13	Glasses	Canal Street Storm Drain	1929-05-08	2025-11-30 02:25:41.169424
3	14	Wristwatch	The Barrens	1930-01-29	2025-11-30 02:25:41.169424
4	17	Glasses	Neibolt Street (The Old House)	1958-07-11	2025-11-30 02:25:41.169424
5	19	Library book	The Aladdin Theater	1958-07-22	2025-11-30 02:25:41.169424
6	22	Jacket	The Derry Town House	1957-03-10	2025-11-30 02:25:41.169424
7	22	Lunchbox	Bassey Park	1957-04-04	2025-11-30 02:25:41.169424
8	23	Baseball cap	Silver Ball Arcade	1958-10-18	2025-11-30 02:25:41.169424
9	24	Jacket	Silver Ball Arcade	1957-05-20	2025-11-30 02:25:41.169424
10	25	Comic book	Main Street	1957-12-26	2025-11-30 02:25:41.169424
11	26	Baseball glove	The Standpipe	1957-10-10	2025-11-30 02:25:41.169424
12	27	Lunchbox	The Aladdin Theater	1957-09-30	2025-11-30 02:25:41.169424
13	29	Bicycle	The Barrens	1958-08-05	2025-11-30 02:25:41.169424
14	30	Bicycle	Witcham Street	1957-06-29	2025-11-30 02:25:41.169424
15	30	Skateboard	The Barrens	1957-06-30	2025-11-30 02:25:41.169424
16	32	Skateboard	Silver Ball Arcade	1984-12-18	2025-11-30 02:25:41.169424
17	32	Baseball cap	Silver Ball Arcade	1984-12-16	2025-11-30 02:25:41.169424
18	35	Camera	Tracker Brothers Depot	1985-02-26	2025-11-30 02:25:41.169424
19	40	Toy car	The Barrens	1985-07-18	2025-11-30 02:25:41.169424
20	43	Skateboard	Bassey Park	1984-03-19	2025-11-30 02:25:41.169424
21	43	Silver dollar	The Barrens	1984-03-19	2025-11-30 02:25:41.169424
22	44	Camera	The Barrens	1984-08-26	2025-11-30 02:25:41.169424
23	45	Skateboard	Tracker Brothers Depot	1984-10-22	2025-11-30 02:25:41.169424
24	45	Paper boat	Bassey Park	1984-11-03	2025-11-30 02:25:41.169424
25	46	Glasses	The Aladdin Theater	2018-01-26	2025-11-30 02:25:41.169424
26	46	Comic book	Neibolt Street (The Old House)	2018-01-24	2025-11-30 02:25:41.169424
27	47	Library book	The Barrens	2016-02-16	2025-11-30 02:25:41.169424
28	48	Red balloon	The Barrens	2016-09-29	2025-11-30 02:25:41.169424
29	49	Camera	Derry High School	2016-10-24	2025-11-30 02:25:41.169424
30	49	Library book	Derry High School	2016-11-16	2025-11-30 02:25:41.169424
31	51	Sneakers	The Aladdin Theater	2017-07-10	2025-11-30 02:25:41.169424
32	53	School backpack	The Barrens	2017-05-29	2025-11-30 02:25:41.169424
33	53	Red balloon	Derry High School	2017-06-07	2025-11-30 02:25:41.169424
34	54	Silver dollar	Main Street	2016-04-25	2025-11-30 02:25:41.169424
35	54	Library book	Canal Street Storm Drain	2016-05-06	2025-11-30 02:25:41.169424
36	56	Sneakers	Costello Avenue	2018-01-21	2025-11-30 02:25:41.169424
37	56	Notebook	Center Street	2018-01-02	2025-11-30 02:25:41.169424
\.


--
-- Data for Name: sightings; Type: TABLE DATA; Schema: public; Owner: derry_admin
--

COPY public.sightings (id, victim_id, location, witness_name, sighting_date, description, created_at) FROM stdin;
1	1	The Public Library	Katie Wheeler	1930-03-10	Seen walking alone near The Public Library	2025-11-30 02:25:41.16398
2	1	The Barrens	Kimberly Buchanan	1930-03-10	Seen with unknown adult near The Barrens	2025-11-30 02:25:41.16398
3	2	Neibolt Street (The Old House)	Melissa Soto	1930-02-15	Observed looking into storm drain	2025-11-30 02:25:41.16398
4	9	Up-Mile Hill	Richard Perkins	1929-01-12	Observed playing with friends at Up-Mile Hill	2025-11-30 02:25:41.16398
5	13	Silver Ball Arcade	Kaitlin Patterson	1929-04-11	Seen walking alone near Silver Ball Arcade	2025-11-30 02:25:41.16398
6	13	Canal Street Storm Drain	William Rangel	1929-04-15	Seen with unknown adult near Canal Street Storm Drain	2025-11-30 02:25:41.16398
7	15	Derry High School	Jessica Hogan	1930-01-08	Seen with unknown adult near Derry High School	2025-11-30 02:25:41.16398
8	15	Memorial Park	Troy Hernandez	1930-01-06	Seen walking alone near Memorial Park	2025-11-30 02:25:41.16398
9	15	Derry High School	Dale Brown	1930-01-07	Spotted riding bicycle near Derry High School	2025-11-30 02:25:41.16398
10	16	The Derry Town House	Jared Anderson	1958-08-19	Seen with unknown adult near The Derry Town House	2025-11-30 02:25:41.16398
11	16	Center Street	Erika Adkins	1958-08-23	Witnessed at Center Street around dusk	2025-11-30 02:25:41.16398
12	19	Kansas Street	Heather Mathis	1958-07-15	Spotted riding bicycle near Kansas Street	2025-11-30 02:25:41.16398
13	19	Main Street	Benjamin Burke	1958-07-19	Spotted riding bicycle near Main Street	2025-11-30 02:25:41.16398
14	23	Center Street	Daniel Gray	1958-10-10	Observed playing with friends at Center Street	2025-11-30 02:25:41.16398
15	23	Tracker Brothers Depot	Richard Washington	1958-10-07	Spotted riding bicycle near Tracker Brothers Depot	2025-11-30 02:25:41.16398
16	25	The Aladdin Theater	Kristi Davis	1957-12-03	Spotted riding bicycle near The Aladdin Theater	2025-11-30 02:25:41.16398
17	27	Center Street	Ashley Melton	1957-08-30	Witnessed at Center Street around dusk	2025-11-30 02:25:41.16398
18	27	Silver Ball Arcade	Mary Payne	1957-08-30	Observed playing with friends at Silver Ball Arcade	2025-11-30 02:25:41.16398
19	29	Derry High School	Michael Stevens	1958-07-17	Seen walking alone near Derry High School	2025-11-30 02:25:41.16398
20	34	The Aladdin Theater	Derrick Smith	1985-10-03	Seen walking alone near The Aladdin Theater	2025-11-30 02:25:41.16398
21	35	Bassey Park	Rebecca Rhodes	1985-02-14	Observed playing with friends at Bassey Park	2025-11-30 02:25:41.16398
22	38	The Barrens	Alan Murray	1985-07-02	Witnessed at The Barrens around dusk	2025-11-30 02:25:41.16398
23	38	The Standpipe	Bruce Cruz	1985-07-05	Observed looking into storm drain	2025-11-30 02:25:41.16398
24	40	Neibolt Street (The Old House)	Jeremy Ramirez	1985-07-01	Spotted riding bicycle near Neibolt Street (The Old House)	2025-11-30 02:25:41.16398
25	42	Neibolt Street (The Old House)	Dylan Martinez	1984-08-21	Seen with unknown adult near Neibolt Street (The Old House)	2025-11-30 02:25:41.16398
26	42	The Aladdin Theater	Joseph Thomas	1984-08-23	Last seen walking home from school	2025-11-30 02:25:41.16398
27	42	The Kissing Bridge	Martha Morris	1984-08-22	Observed looking into storm drain	2025-11-30 02:25:41.16398
28	46	The Derry Town House	Douglas Pearson	2017-12-25	Witnessed at The Derry Town House around dusk	2025-11-30 02:25:41.16398
29	46	Center Street	Nicholas Villa	2017-12-23	Seen walking alone near Center Street	2025-11-30 02:25:41.16398
30	46	Memorial Park	Linda Johnston	2017-12-21	Seen walking alone near Memorial Park	2025-11-30 02:25:41.16398
31	50	Center Street	Rachel Kane	2017-01-21	Seen walking alone near Center Street	2025-11-30 02:25:41.16398
32	52	The Derry Town House	Steve Jones	2017-07-01	Observed looking into storm drain	2025-11-30 02:25:41.16398
33	58	Tracker Brothers Depot	Alison Franklin	2017-12-23	Observed playing with friends at Tracker Brothers Depot	2025-11-30 02:25:41.16398
34	58	Neibolt Street (The Old House)	Sydney Brown	2017-12-24	Spotted riding bicycle near Neibolt Street (The Old House)	2025-11-30 02:25:41.16398
35	58	The Derry Town House	Pamela Wilson	2017-12-21	Seen with unknown adult near The Derry Town House	2025-11-30 02:25:41.16398
36	59	Main Street	David Davis	2017-03-09	Seen with unknown adult near Main Street	2025-11-30 02:25:41.16398
37	59	Derry Elementary School	Amanda Clark	2017-03-14	Last seen walking home from school	2025-11-30 02:25:41.16398
\.


--
-- Data for Name: victims; Type: TABLE DATA; Schema: public; Owner: derry_admin
--

COPY public.victims (id, first_name, last_name, nickname, age_at_disappearance, date_of_birth, disappearance_date, last_seen_location, physical_description, photo_url, status, case_number, decade, created_at) FROM stdin;
4	Wesley	Brady	Wesley	14	1915-12-11	1929-12-11	Derry High School	Approximately 5'9", blonde hair, gray eyes	/images/victims/DPD_1929_0004.jpg	Missing	DPD-1929-0004	1920s	2025-11-30 02:25:41.153218
8	Katie	Williams	Katiie	16	1913-02-28	1929-02-28	The Public Library	Approximately 4'6", auburn hair, hazel eyes	/images/victims/DPD_1929_0008.jpg	Missing	DPD-1929-0008	1920s	2025-11-30 02:25:41.153218
9	Jodi	Higgins	\N	9	1920-01-13	1929-01-13	Up-Mile Hill	Approximately 3'6", light brown hair, hazel eyes	/images/victims/DPD_1929_0009.jpg	Missing	DPD-1929-0009	1920s	2025-11-30 02:25:41.153218
12	Michele	Dyer	\N	20	1909-03-14	1929-03-14	Derry Elementary School	Brown hair, hazel eyes, 5 feet 1 inches tall	/images/victims/DPD_1929_0012.jpg	Missing	DPD-1929-0012	1920s	2025-11-30 02:25:41.153218
13	Mary	Zhang	\N	6	1923-04-17	1929-04-17	Kansas Street	Dark brown hair, gray eyes, 3 feet 9 inches tall	/images/victims/DPD_1929_0013.jpg	Missing	DPD-1929-0013	1920s	2025-11-30 02:25:41.153218
1	Lauren	Doyle	Lauren	7	1923-03-14	1930-03-14	The Kissing Bridge	Approximately 3'4", light brown hair, brown eyes	/images/victims/DPD_1930_0001.jpg	Missing	DPD-1930-0001	1920s	2025-11-30 02:25:41.153218
2	John	Giles	\N	15	1915-02-16	1930-02-16	Center Street	Light brown hair, gray eyes, 4 feet 5 inches tall	/images/victims/DPD_1930_0002.jpg	Missing	DPD-1930-0002	1920s	2025-11-30 02:25:41.153218
3	Sean	Newton	\N	12	1918-09-03	1930-09-03	Canal Street Storm Drain	4'5" tall, brown hair, blue eyes	/images/victims/DPD_1930_0003.jpg	Missing	DPD-1930-0003	1920s	2025-11-30 02:25:41.153218
5	David	Santiago	\N	13	1917-11-13	1930-11-14	Canal Street Storm Drain	4'5" tall, blonde hair, brown eyes. Dimples when smiling	/images/victims/DPD_1930_0005.jpg	Missing	DPD-1930-0005	1920s	2025-11-30 02:25:41.153218
6	Melissa	Wise	\N	8	1922-10-21	1930-10-21	Main Street	Approximately 4'4", blonde hair, brown eyes	/images/victims/DPD_1930_0006.jpg	Missing	DPD-1930-0006	1920s	2025-11-30 02:25:41.153218
7	Donna	Bailey	Donnie	12	1918-08-28	1930-08-28	Kansas Street	Approximately 5'0", blonde hair, gray eyes	/images/victims/DPD_1930_0007.jpg	Missing	DPD-1930-0007	1920s	2025-11-30 02:25:41.153218
10	Troy	Ayala	\N	10	1920-10-31	1930-11-01	The Kissing Bridge	4'7" tall, light brown hair, hazel eyes	/images/victims/DPD_1930_0010.jpg	Missing	DPD-1930-0010	1920s	2025-11-30 02:25:41.153218
11	Amy	Johnson	\N	9	1921-11-10	1930-11-11	The Barrens	Red hair, gray eyes, 4 feet 3 inches tall	/images/victims/DPD_1930_0011.jpg	Missing	DPD-1930-0011	1920s	2025-11-30 02:25:41.153218
14	Jennifer	Randall	Jennifer	14	1916-01-25	1930-01-25	Witcham Street	4'0" tall, light brown hair, green eyes	/images/victims/DPD_1930_0014.jpg	Missing	DPD-1930-0014	1920s	2025-11-30 02:25:41.153218
15	Sandra	Morris	\N	11	1919-01-10	1930-01-10	The Public Library	Approximately 4'2", black hair, brown eyes	/images/victims/DPD_1930_0015.jpg	Missing	DPD-1930-0015	1920s	2025-11-30 02:25:41.153218
20	Joseph	Kent	\N	13	1944-05-18	1957-05-19	Memorial Park	Approximately 4'2", light brown hair, gray eyes	/images/victims/DPD_1957_0005.jpg	Missing	DPD-1957-0005	1950s	2025-11-30 02:25:41.153218
21	Carrie	Crane	\N	14	1943-05-01	1957-05-01	Canal Street Storm Drain	Approximately 5'0", blonde hair, hazel eyes	/images/victims/DPD_1957_0006.jpg	Missing	DPD-1957-0006	1950s	2025-11-30 02:25:41.153218
22	James	Rios	\N	10	1947-03-09	1957-03-09	Derry Elementary School	Brown hair, gray eyes, 4 feet 1 inches tall	/images/victims/DPD_1957_0007.jpg	Missing	DPD-1957-0007	1950s	2025-11-30 02:25:41.153218
24	Christopher	Diaz	\N	13	1944-05-01	1957-05-02	The Standpipe	4'3" tall, black hair, green eyes	/images/victims/DPD_1957_0009.jpg	Missing	DPD-1957-0009	1950s	2025-11-30 02:25:41.153218
25	Terry	Odom	\N	7	1950-12-09	1957-12-09	Main Street	Approximately 3'2", brown hair, gray eyes	/images/victims/DPD_1957_0010.jpg	Missing	DPD-1957-0010	1950s	2025-11-30 02:25:41.153218
26	Amanda	Taylor	\N	12	1945-09-19	1957-09-19	The Standpipe	Dark brown hair, green eyes, 4 feet 3 inches tall	/images/victims/DPD_1957_0011.jpg	Presumed Dead	DPD-1957-0011	1950s	2025-11-30 02:25:41.153218
27	April	Ortiz	\N	11	1946-09-02	1957-09-02	The Aladdin Theater	Approximately 3'10", auburn hair, blue eyes	/images/victims/DPD_1957_0012.jpg	Missing	DPD-1957-0012	1950s	2025-11-30 02:25:41.153218
28	Chad	Velazquez	\N	8	1949-02-20	1957-02-20	Witcham Street	Auburn hair, hazel eyes, 4 feet 9 inches tall	/images/victims/DPD_1957_0013.jpg	Missing	DPD-1957-0013	1950s	2025-11-30 02:25:41.153218
30	Howard	Pena	\N	12	1945-06-24	1957-06-24	The Standpipe	4'11" tall, brown hair, brown eyes. Freckles across nose	/images/victims/DPD_1957_0015.jpg	Missing	DPD-1957-0015	1950s	2025-11-30 02:25:41.153218
16	Christopher	Martinez	\N	13	1945-08-24	1958-08-25	Up-Mile Hill	4'7" tall, blonde hair, green eyes	/images/victims/DPD_1958_0001.jpg	Missing	DPD-1958-0001	1950s	2025-11-30 02:25:41.153218
17	Eric	Barber	Eriy	7	1951-07-03	1958-07-03	Neibolt Street (The Old House)	Approximately 4'2", brown hair, green eyes	/images/victims/DPD_1958_0002.jpg	Missing	DPD-1958-0002	1950s	2025-11-30 02:25:41.153218
18	Debra	Johnson	\N	8	1950-11-08	1958-11-08	Memorial Park	Dark brown hair, hazel eyes, 5 feet 0 inches tall	/images/victims/DPD_1958_0003.jpg	Missing	DPD-1958-0003	1950s	2025-11-30 02:25:41.153218
19	Ryan	Short	\N	15	1943-07-20	1958-07-20	The Aladdin Theater	Approximately 5'11", blonde hair, hazel eyes	/images/victims/DPD_1958_0004.jpg	Missing	DPD-1958-0004	1950s	2025-11-30 02:25:41.153218
23	Kelly	Johnson	\N	9	1949-10-12	1958-10-13	Main Street	4'6" tall, blonde hair, green eyes	/images/victims/DPD_1958_0008.jpg	Missing	DPD-1958-0008	1950s	2025-11-30 02:25:41.153218
29	Juan	Burke	\N	10	1948-07-21	1958-07-22	The Kissing Bridge	Dark brown hair, green eyes, 3 feet 5 inches tall	/images/victims/DPD_1958_0014.jpg	Missing	DPD-1958-0014	1950s	2025-11-30 02:25:41.153218
32	Jeffrey	Turner	\N	12	1972-11-25	1984-11-25	Silver Ball Arcade	Approximately 5'0", black hair, blue eyes	/images/victims/DPD_1984_0002.jpg	Missing	DPD-1984-0002	1980s	2025-11-30 02:25:41.153218
37	Eugene	Brown	Eugeie	8	1976-05-26	1984-05-26	Bassey Park	3'1" tall, light brown hair, blue eyes	/images/victims/DPD_1984_0007.jpg	Missing	DPD-1984-0007	1980s	2025-11-30 02:25:41.153218
42	Joseph	Aguilar	Joseph	9	1975-08-27	1984-08-27	Tracker Brothers Depot	4'4" tall, red hair, green eyes. Dimples when smiling	/images/victims/DPD_1984_0012.jpg	Presumed Dead	DPD-1984-0012	1980s	2025-11-30 02:25:41.153218
43	Gerald	Stephens	Gerald	15	1969-03-01	1984-03-01	Bassey Park	5'5" tall, dark brown hair, hazel eyes	/images/victims/DPD_1984_0013.jpg	Missing	DPD-1984-0013	1980s	2025-11-30 02:25:41.153218
44	Jose	Mays	\N	16	1968-08-23	1984-08-23	The Standpipe	Approximately 5'5", dark brown hair, blue eyes	/images/victims/DPD_1984_0014.jpg	Body Found	DPD-1984-0014	1980s	2025-11-30 02:25:41.153218
45	Joe	Singh	\N	6	1978-10-11	1984-10-11	Bassey Park	Brown hair, hazel eyes, 3 feet 4 inches tall	/images/victims/DPD_1984_0015.jpg	Missing	DPD-1984-0015	1980s	2025-11-30 02:25:41.153218
31	Joshua	Harvey	\N	21	1964-09-13	1985-09-14	Main Street	Red hair, hazel eyes, 4 feet 2 inches tall	/images/victims/DPD_1985_0001.jpg	Missing	DPD-1985-0001	1980s	2025-11-30 02:25:41.153218
33	Gilbert	Flores	\N	15	1970-06-15	1985-06-15	The Kissing Bridge	5'10" tall, auburn hair, green eyes	/images/victims/DPD_1985_0003.jpg	Missing	DPD-1985-0003	1980s	2025-11-30 02:25:41.153218
34	Cory	Brooks	\N	11	1974-10-07	1985-10-07	Memorial Park	4'3" tall, dark brown hair, gray eyes. Dimples when smiling	/images/victims/DPD_1985_0004.jpg	Missing	DPD-1985-0004	1980s	2025-11-30 02:25:41.153218
35	Valerie	Lopez	\N	13	1972-02-15	1985-02-15	Tracker Brothers Depot	4'6" tall, red hair, blue eyes. Freckles across nose	/images/victims/DPD_1985_0005.jpg	Missing	DPD-1985-0005	1980s	2025-11-30 02:25:41.153218
36	Justin	Lyons	\N	25	1960-09-18	1985-09-19	The Standpipe	Blonde hair, gray eyes, 5 feet 4 inches tall	/images/victims/DPD_1985_0006.jpg	Missing	DPD-1985-0006	1980s	2025-11-30 02:25:41.153218
38	Scott	Rodriguez	\N	14	1971-07-08	1985-07-08	Center Street	6'0" tall, red hair, green eyes. Small scar on left cheek	/images/victims/DPD_1985_0008.jpg	Missing	DPD-1985-0008	1980s	2025-11-30 02:25:41.153218
39	Brian	Murphy	\N	16	1969-07-13	1985-07-13	Canal Street Storm Drain	Approximately 4'4", black hair, brown eyes	/images/victims/DPD_1985_0009.jpg	Missing	DPD-1985-0009	1980s	2025-11-30 02:25:41.153218
40	Michael	Stephens	\N	14	1971-07-07	1985-07-07	The Public Library	5'1" tall, auburn hair, green eyes	/images/victims/DPD_1985_0010.jpg	Body Found	DPD-1985-0010	1980s	2025-11-30 02:25:41.153218
41	Mark	Dunn	\N	9	1976-12-14	1985-12-15	Bassey Park	4'1" tall, dark brown hair, gray eyes	/images/victims/DPD_1985_0011.jpg	Missing	DPD-1985-0011	1980s	2025-11-30 02:25:41.153218
47	Jasmine	Hunter	\N	15	2001-02-06	2016-02-07	The Public Library	5'5" tall, black hair, gray eyes	/images/victims/DPD_2016_0002.jpg	Missing	DPD-2016-0002	2010s	2025-11-30 02:25:41.153218
48	Juan	Turner	Juan	7	2009-09-11	2016-09-11	The Kissing Bridge	Approximately 4'9", light brown hair, green eyes	/images/victims/DPD_2016_0003.jpg	Missing	DPD-2016-0003	2010s	2025-11-30 02:25:41.153218
49	Gavin	Nelson	\N	11	2005-10-19	2016-10-19	Derry High School	3'2" tall, auburn hair, hazel eyes	/images/victims/DPD_2016_0004.jpg	Missing	DPD-2016-0004	2010s	2025-11-30 02:25:41.153218
54	Michael	Valenzuela	Michael	15	2001-04-09	2016-04-09	Canal Street Storm Drain	Approximately 4'10", black hair, gray eyes	/images/victims/DPD_2016_0009.jpg	Missing	DPD-2016-0009	2010s	2025-11-30 02:25:41.153218
55	Regina	Phillips	\N	10	2006-05-06	2016-05-06	Main Street	Approximately 4'11", dark brown hair, green eyes	/images/victims/DPD_2016_0010.jpg	Missing	DPD-2016-0010	2010s	2025-11-30 02:25:41.153218
57	Robin	Brock	\N	11	2005-11-19	2016-11-19	Canal Street Storm Drain	Approximately 4'0", black hair, gray eyes	/images/victims/DPD_2016_0012.jpg	Missing	DPD-2016-0012	2010s	2025-11-30 02:25:41.153218
46	Richard	Larsen	Richie	9	2008-12-27	2017-12-28	The Aladdin Theater	4'6" tall, red hair, green eyes. Wears braces	/images/victims/DPD_2017_0001.jpg	Body Found	DPD-2017-0001	2010s	2025-11-30 02:25:41.153218
50	Carolyn	Stevenson	\N	14	2003-01-25	2017-01-25	Kansas Street	Approximately 4'11", black hair, gray eyes	/images/victims/DPD_2017_0005.jpg	Body Found	DPD-2017-0005	2010s	2025-11-30 02:25:41.153218
51	Michael	Pruitt	\N	13	2004-06-23	2017-06-24	The Derry Town House	Dark brown hair, green eyes, 5 feet 3 inches tall	/images/victims/DPD_2017_0006.jpg	Presumed Dead	DPD-2017-0006	2010s	2025-11-30 02:25:41.153218
52	Kathleen	White	Kathleen	6	2011-07-07	2017-07-07	Silver Ball Arcade	Approximately 4'2", auburn hair, gray eyes	/images/victims/DPD_2017_0007.jpg	Missing	DPD-2017-0007	2010s	2025-11-30 02:25:41.153218
53	Jessica	Collins	Jesy	9	2008-05-09	2017-05-10	Derry High School	3'11" tall, red hair, gray eyes. Dimples when smiling	/images/victims/DPD_2017_0008.jpg	Missing	DPD-2017-0008	2010s	2025-11-30 02:25:41.153218
56	Lindsey	Beard	\N	8	2009-12-28	2017-12-28	Derry High School	3'4" tall, black hair, blue eyes	/images/victims/DPD_2017_0011.jpg	Presumed Dead	DPD-2017-0011	2010s	2025-11-30 02:25:41.153218
58	Raymond	Kirk	\N	13	2004-12-27	2017-12-28	Derry High School	Approximately 5'8", red hair, green eyes	/images/victims/DPD_2017_0013.jpg	Missing	DPD-2017-0013	2010s	2025-11-30 02:25:41.153218
59	Steven	Mitchell	\N	10	2007-03-15	2017-03-15	Costello Avenue	4'3" tall, dark brown hair, hazel eyes	/images/victims/DPD_2017_0014.jpg	Missing	DPD-2017-0014	2010s	2025-11-30 02:25:41.153218
60	Tina	Gonzalez	\N	14	2003-11-24	2017-11-24	The Public Library	Approximately 5'0", blonde hair, gray eyes	/images/victims/DPD_2017_0015.jpg	Missing	DPD-2017-0015	2010s	2025-11-30 02:25:41.153218
\.


--
-- Name: personal_effects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: derry_admin
--

SELECT pg_catalog.setval('public.personal_effects_id_seq', 37, true);


--
-- Name: sightings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: derry_admin
--

SELECT pg_catalog.setval('public.sightings_id_seq', 37, true);


--
-- Name: victims_id_seq; Type: SEQUENCE SET; Schema: public; Owner: derry_admin
--

SELECT pg_catalog.setval('public.victims_id_seq', 60, true);


--
-- Name: personal_effects personal_effects_pkey; Type: CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.personal_effects
    ADD CONSTRAINT personal_effects_pkey PRIMARY KEY (id);


--
-- Name: sightings sightings_pkey; Type: CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_pkey PRIMARY KEY (id);


--
-- Name: victims victims_case_number_key; Type: CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.victims
    ADD CONSTRAINT victims_case_number_key UNIQUE (case_number);


--
-- Name: victims victims_pkey; Type: CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.victims
    ADD CONSTRAINT victims_pkey PRIMARY KEY (id);


--
-- Name: idx_personal_effects_victim_id; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_personal_effects_victim_id ON public.personal_effects USING btree (victim_id);


--
-- Name: idx_sightings_victim_id; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_sightings_victim_id ON public.sightings USING btree (victim_id);


--
-- Name: idx_victims_decade; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_victims_decade ON public.victims USING btree (decade);


--
-- Name: idx_victims_disappearance_date; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_victims_disappearance_date ON public.victims USING btree (disappearance_date);


--
-- Name: idx_victims_last_name; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_victims_last_name ON public.victims USING btree (last_name);


--
-- Name: idx_victims_status; Type: INDEX; Schema: public; Owner: derry_admin
--

CREATE INDEX idx_victims_status ON public.victims USING btree (status);


--
-- Name: personal_effects personal_effects_victim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.personal_effects
    ADD CONSTRAINT personal_effects_victim_id_fkey FOREIGN KEY (victim_id) REFERENCES public.victims(id) ON DELETE CASCADE;


--
-- Name: sightings sightings_victim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: derry_admin
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_victim_id_fkey FOREIGN KEY (victim_id) REFERENCES public.victims(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 3LqkK3XRZXZ6rfYaTfFjnqavmJFg0qtchilIwCLggRdjhhXFfEhKV3Y9zDLh7dK

