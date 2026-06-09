--
-- PostgreSQL database dump
--
-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.statystyki_pilkarzy DROP CONSTRAINT IF EXISTS statystyki_pilkarzy_pilkarz_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mecze DROP CONSTRAINT IF EXISTS mecze_druzyna_id_foreign;
ALTER TABLE IF EXISTS ONLY public.bilety DROP CONSTRAINT IF EXISTS bilety_uzytkownik_id_foreign;
ALTER TABLE IF EXISTS ONLY public.bilety DROP CONSTRAINT IF EXISTS bilety_mecz_id_foreign;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.failed_jobs_connection_queue_failed_at_index;
DROP INDEX IF EXISTS public.cache_locks_expiration_index;
DROP INDEX IF EXISTS public.cache_expiration_index;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_pkey;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_pesel_unique;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_email_unique;
ALTER TABLE IF EXISTS ONLY public.statystyki_pilkarzy DROP CONSTRAINT IF EXISTS statystyki_pilkarzy_pkey;
ALTER TABLE IF EXISTS ONLY public.statystyki_pilkarzy DROP CONSTRAINT IF EXISTS statystyki_pilkarzy_pilkarz_id_unique;
ALTER TABLE IF EXISTS ONLY public.pilkarze DROP CONSTRAINT IF EXISTS pilkarze_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.mecze DROP CONSTRAINT IF EXISTS mecze_pkey;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.job_batches DROP CONSTRAINT IF EXISTS job_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_uuid_unique;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.druzyny DROP CONSTRAINT IF EXISTS druzyny_pkey;
ALTER TABLE IF EXISTS ONLY public.druzyny DROP CONSTRAINT IF EXISTS druzyny_nazwa_unique;
ALTER TABLE IF EXISTS ONLY public.cache DROP CONSTRAINT IF EXISTS cache_pkey;
ALTER TABLE IF EXISTS ONLY public.cache_locks DROP CONSTRAINT IF EXISTS cache_locks_pkey;
ALTER TABLE IF EXISTS ONLY public.bilety DROP CONSTRAINT IF EXISTS bilety_uzytkownik_mecz_unique;
ALTER TABLE IF EXISTS ONLY public.bilety DROP CONSTRAINT IF EXISTS bilety_pkey;
ALTER TABLE IF EXISTS ONLY public.bilety DROP CONSTRAINT IF EXISTS bilety_kod_biletu_unique;
ALTER TABLE IF EXISTS public.uzytkownicy ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.statystyki_pilkarzy ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pilkarze ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mecze ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.druzyny ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bilety ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.uzytkownicy_id_seq;
DROP TABLE IF EXISTS public.uzytkownicy;
DROP SEQUENCE IF EXISTS public.statystyki_pilkarzy_id_seq;
DROP TABLE IF EXISTS public.statystyki_pilkarzy;
DROP SEQUENCE IF EXISTS public.pilkarze_id_seq;
DROP TABLE IF EXISTS public.pilkarze;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.mecze_id_seq;
DROP TABLE IF EXISTS public.mecze;
DROP SEQUENCE IF EXISTS public.jobs_id_seq;
DROP TABLE IF EXISTS public.jobs;
DROP TABLE IF EXISTS public.job_batches;
DROP SEQUENCE IF EXISTS public.failed_jobs_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP SEQUENCE IF EXISTS public.druzyny_id_seq;
DROP TABLE IF EXISTS public.druzyny;
DROP TABLE IF EXISTS public.cache_locks;
DROP TABLE IF EXISTS public.cache;
DROP SEQUENCE IF EXISTS public.bilety_id_seq;
DROP TABLE IF EXISTS public.bilety;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bilety; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bilety (
    id bigint NOT NULL,
    mecz_id bigint NOT NULL,
    sektor character varying(255) NOT NULL,
    rzad integer NOT NULL,
    miejsce integer NOT NULL,
    typ_biletu character varying(255) NOT NULL,
    znizka integer DEFAULT 0 NOT NULL,
    imie_nazwisko_kibica character varying(255) NOT NULL,
    pesel_kibica character varying(11) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    uzytkownik_id bigint,
    kod_biletu character varying(32)
);


ALTER TABLE public.bilety OWNER TO postgres;

--
-- Name: bilety_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bilety_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bilety_id_seq OWNER TO postgres;

--
-- Name: bilety_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bilety_id_seq OWNED BY public.bilety.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: druzyny; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.druzyny (
    id bigint NOT NULL,
    nazwa character varying(255) NOT NULL,
    punkty integer DEFAULT 0 NOT NULL,
    mecze_rozegrane integer DEFAULT 0 NOT NULL,
    bramki_zdobyte integer DEFAULT 0 NOT NULL,
    bramki_stracone integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.druzyny OWNER TO postgres;

--
-- Name: druzyny_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.druzyny_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.druzyny_id_seq OWNER TO postgres;

--
-- Name: druzyny_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.druzyny_id_seq OWNED BY public.druzyny.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection character varying(255) NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: mecze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mecze (
    id bigint NOT NULL,
    data_meczu timestamp(0) without time zone NOT NULL,
    miejsce character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'Planowany'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    czy_domowy boolean DEFAULT false NOT NULL,
    druzyna_id bigint NOT NULL,
    wynik_stal integer,
    wynik_rywal integer
);


ALTER TABLE public.mecze OWNER TO postgres;

--
-- Name: mecze_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mecze_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mecze_id_seq OWNER TO postgres;

--
-- Name: mecze_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecze_id_seq OWNED BY public.mecze.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: pilkarze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pilkarze (
    id bigint NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    numer integer NOT NULL,
    pozycja character varying(255) NOT NULL,
    zdjecie character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pilkarze OWNER TO postgres;

--
-- Name: pilkarze_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pilkarze_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pilkarze_id_seq OWNER TO postgres;

--
-- Name: pilkarze_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pilkarze_id_seq OWNED BY public.pilkarze.id;


--
-- Name: statystyki_pilkarzy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statystyki_pilkarzy (
    id bigint NOT NULL,
    pilkarz_id bigint NOT NULL,
    wystepy integer DEFAULT 0 NOT NULL,
    minuty integer DEFAULT 0 NOT NULL,
    gole integer DEFAULT 0 NOT NULL,
    asysty integer DEFAULT 0 NOT NULL,
    czyste_konta integer DEFAULT 0 NOT NULL,
    zolte_kartki integer DEFAULT 0 NOT NULL,
    czerwone_kartki integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.statystyki_pilkarzy OWNER TO postgres;

--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statystyki_pilkarzy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.statystyki_pilkarzy_id_seq OWNER TO postgres;

--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statystyki_pilkarzy_id_seq OWNED BY public.statystyki_pilkarzy.id;


--
-- Name: uzytkownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uzytkownicy (
    id bigint NOT NULL,
    imie character varying(50) NOT NULL,
    nazwisko character varying(50) NOT NULL,
    pesel character varying(11) NOT NULL,
    data_urodzenia date NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    rola character varying(255) DEFAULT 'kibic'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.uzytkownicy OWNER TO postgres;

--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uzytkownicy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.uzytkownicy_id_seq OWNER TO postgres;

--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uzytkownicy_id_seq OWNED BY public.uzytkownicy.id;


--
-- Name: bilety id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety ALTER COLUMN id SET DEFAULT nextval('public.bilety_id_seq'::regclass);


--
-- Name: druzyny id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druzyny ALTER COLUMN id SET DEFAULT nextval('public.druzyny_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: mecze id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecze ALTER COLUMN id SET DEFAULT nextval('public.mecze_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: pilkarze id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilkarze ALTER COLUMN id SET DEFAULT nextval('public.pilkarze_id_seq'::regclass);


--
-- Name: statystyki_pilkarzy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statystyki_pilkarzy ALTER COLUMN id SET DEFAULT nextval('public.statystyki_pilkarzy_id_seq'::regclass);


--
-- Name: uzytkownicy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy ALTER COLUMN id SET DEFAULT nextval('public.uzytkownicy_id_seq'::regclass);


--
-- Data for Name: bilety; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bilety (id, mecz_id, sektor, rzad, miejsce, typ_biletu, znizka, imie_nazwisko_kibica, pesel_kibica, created_at, updated_at, uzytkownik_id, kod_biletu) FROM stdin;
2	5	Sektor A - Mlyn	10	39	ulgowy	20	Jakub Pelic	22222222222	2026-06-09 00:14:20	2026-06-09 00:14:20	1	STAL-6094-EDM
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: druzyny; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.druzyny (id, nazwa, punkty, mecze_rozegrane, bramki_zdobyte, bramki_stracone, created_at, updated_at) FROM stdin;
11	Polonia Bytom	38	18	34	17	2026-06-08 23:23:44	2026-06-08 23:23:44
4	KKS 1925 Kalisz	35	18	29	18	2026-06-08 23:23:44	2026-06-08 23:23:44
1	Chojniczanka Chojnice	31	18	27	19	2026-06-08 23:23:44	2026-06-08 23:23:44
5	Kotwica Kołobrzeg	30	18	25	20	2026-06-08 23:23:44	2026-06-08 23:23:44
3	Hutnik Kraków	29	18	24	21	2026-06-08 23:23:44	2026-06-08 23:23:44
13	Rekord Bielsko-Biała	27	18	23	22	2026-06-08 23:23:44	2026-06-08 23:23:44
14	Sandecja Nowy Sącz	26	18	21	19	2026-06-08 23:23:44	2026-06-08 23:23:44
2	GKS Jastrzębie	25	18	22	23	2026-06-08 23:23:44	2026-06-08 23:23:44
8	Olimpia Grudziądz	24	18	20	21	2026-06-08 23:23:44	2026-06-08 23:23:44
17	Wisła Puławy	23	18	19	21	2026-06-08 23:23:44	2026-06-08 23:23:44
16	Stomil Olsztyn	22	18	18	22	2026-06-08 23:23:44	2026-06-08 23:23:44
7	Olimpia Elbląg	21	18	18	24	2026-06-08 23:23:44	2026-06-08 23:23:44
15	Skra Częstochowa	20	18	17	23	2026-06-08 23:23:44	2026-06-08 23:23:44
9	Podhale Nowy Targ	19	18	16	24	2026-06-08 23:23:44	2026-06-08 23:23:44
10	Pogoń Siedlce	18	18	15	25	2026-06-08 23:23:44	2026-06-08 23:23:44
18	Zagłębie II Lubin	15	18	14	30	2026-06-08 23:23:44	2026-06-08 23:23:44
19	Stal Stalowa Wola	34	18	28	18	2026-06-08 23:23:44	2026-06-09 00:47:50
33	ŁKS II Łódź	18	18	16	28	2026-06-09 00:50:48	2026-06-09 00:50:56
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: mecze; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mecze (id, data_meczu, miejsce, status, created_at, updated_at, czy_domowy, druzyna_id, wynik_stal, wynik_rywal) FROM stdin;
1	2026-06-25 15:00:00	Stadion wyjazdowy	Planowany	2026-06-08 23:23:58	2026-06-08 23:23:58	f	4	\N	\N
5	2026-07-05 18:00:00	PCPN Stalowa Wola	Planowany	2026-06-08 23:23:58	2026-06-08 23:23:58	t	1	\N	\N
2	2026-06-18 18:00:00	PCPN Stalowa Wola	Planowany	2026-06-08 23:23:58	2026-06-09 00:46:11	t	5	\N	\N
3	2026-06-14 17:00:00	Stadion wyjazdowy	Planowany	2026-06-08 23:23:58	2026-06-09 00:46:28	f	11	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000001_create_cache_table	1
2	0001_01_01_000002_create_jobs_table	1
3	2026_05_25_225051_create_mecze_table	1
4	2026_05_25_225535_create_bilety_table	1
5	2026_05_25_230203_create_pilkarze_table	1
6	2026_05_26_070458_create_uzytkownicy_table	1
7	2026_06_01_171718_create_druzyny_table	1
8	2026_06_08_181315_create_statystyki_pilkarzy_table	1
9	2026_06_08_211241_ustalanie_meczy_do_tabeli_druzyn	1
10	2026_06_09_000001_add_user_and_code_to_bilety_table	2
11	2026_06_09_000002_add_unique_user_match_to_bilety_table	3
\.


--
-- Data for Name: pilkarze; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pilkarze (id, imie, nazwisko, numer, pozycja, zdjecie, created_at, updated_at) FROM stdin;
1	Krystian	Harciński	1	Bramkarz	Krystian_Harcinski.png	2026-06-08 22:53:04	2026-06-08 22:53:04
2	Mikołaj	Smyłek	12	Bramkarz	Mikołaj_Smylek.png	2026-06-08 22:53:04	2026-06-08 22:53:04
3	Jakub	Stępak	33	Bramkarz	Jakub_Stepak.png	2026-06-08 22:53:04	2026-06-08 22:53:04
4	Bartłomiej	Kukułowicz	2	Obrońca	Bartlomiej_Kukulowicz.png	2026-06-08 22:53:04	2026-06-08 22:53:04
5	Łukasz	Furtak	3	Obrońca	Lukasz_Furtak.png	2026-06-08 22:53:04	2026-06-08 22:53:04
6	Piotr	Żemło	4	Obrońca	Piotr_Zemlo.png	2026-06-08 22:53:04	2026-06-08 22:53:04
7	Maciej	Jaroszewski	5	Obrońca	Maciej_Jaroszewski.png	2026-06-08 22:53:04	2026-06-08 22:53:04
8	Krystian	Getinger	6	Obrońca	Krystian_Getinger.png	2026-06-08 22:53:04	2026-06-08 22:53:04
9	Igor	Fedejko	13	Obrońca	Igor_Fedejko.png	2026-06-08 22:53:04	2026-06-08 22:53:04
10	Damian	Oko	22	Obrońca	Damian_Oko.png	2026-06-08 22:53:04	2026-06-08 22:53:04
11	Mateusz	Radecki	7	Pomocnik	Mateusz_Radecki.png	2026-06-08 22:53:04	2026-06-08 22:53:04
12	Lukas	Hrnciar	8	Pomocnik	Lukas_Hrnciar.png	2026-06-08 22:53:04	2026-06-08 22:53:04
13	Maksymilian	Hebel	10	Pomocnik	Maksymilian_Hebel.png	2026-06-08 22:53:04	2026-06-08 22:53:04
14	Patryk	Zaucha	11	Pomocnik	Patryk_Zaucha.png	2026-06-08 22:53:04	2026-06-08 22:53:04
15	Krystian	Lelek	14	Pomocnik	Krystian_Lelek.png	2026-06-08 22:53:04	2026-06-08 22:53:04
16	Hubert	Tomalski	17	Pomocnik	Hubert_Tomalski.png	2026-06-08 22:53:04	2026-06-08 22:53:04
17	Michał	Surzyn	18	Pomocnik	Michał_Surzyn.png	2026-06-08 22:53:04	2026-06-08 22:53:04
18	Jakub	Niedbała	19	Pomocnik	Jakub_Niedbala.png	2026-06-08 22:53:04	2026-06-08 22:53:04
19	Jakub	Sobeczko	20	Pomocnik	Jakub_Sobeczko.png	2026-06-08 22:53:04	2026-06-08 22:53:04
20	Piotr	Wójs	21	Pomocnik	Piotr_Wojs.png	2026-06-08 22:53:04	2026-06-08 22:53:04
21	Jakub	Kendzia	23	Pomocnik	Jakub_Kendzia.png	2026-06-08 22:53:04	2026-06-08 22:53:04
22	Dawid	Wolny	9	Napastnik	Dawid_Wolny.png	2026-06-08 22:53:04	2026-06-08 22:53:04
23	Kacper	Śpiewak	90	Napastnik	Kacper_Spiewak.png	2026-06-08 22:53:04	2026-06-08 22:53:04
24	Olaf	Nowak	99	Napastnik	Olaf_Nowak.png	2026-06-08 22:53:04	2026-06-08 22:53:04
25	Dariusz	Kantor	0	Sztab	Dariusz_Kantor.png	2026-06-08 22:53:04	2026-06-08 22:53:04
26	Stanisław	Szpyrka	0	Sztab	Stanislaw_Szpyrka.png	2026-06-08 22:53:04	2026-06-08 22:53:04
27	Paweł	Żmuda	0	Sztab	Paweł_Zmuda.png	2026-06-08 22:53:04	2026-06-08 22:53:04
28	Przemysław	Stelmach	0	Sztab	Przemysław_Stelmach.png	2026-06-08 22:53:04	2026-06-08 22:53:04
29	Anna	Galant	0	Sztab	Anna_Galant.png	2026-06-08 22:53:04	2026-06-08 22:53:04
30	Adrian	Golik	0	Sztab	Adrian_Golik.png	2026-06-08 22:53:04	2026-06-08 22:53:04
31	Tomasz	Wietecha	0	Sztab	Tomasz_Wietecha.png	2026-06-08 22:53:04	2026-06-08 22:53:04
32	Testowe	Test	0	Sztab (Test)	\N	2026-06-09 00:41:16	2026-06-09 00:41:16
\.


--
-- Data for Name: statystyki_pilkarzy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statystyki_pilkarzy (id, pilkarz_id, wystepy, minuty, gole, asysty, czyste_konta, zolte_kartki, czerwone_kartki, created_at, updated_at) FROM stdin;
1	2	16	1470	0	0	1	1	0	2026-06-08 22:53:04	2026-06-08 22:53:04
2	3	17	1530	0	0	1	1	0	2026-06-08 22:53:04	2026-06-08 22:53:04
3	1	0	0	0	0	0	0	0	2026-06-08 22:53:04	2026-06-08 22:53:04
4	4	28	1479	4	3	0	7	0	2026-06-08 22:53:04	2026-06-08 22:53:04
5	5	26	2364	1	0	0	10	2	2026-06-08 22:53:04	2026-06-08 22:53:04
6	6	26	2179	2	1	0	11	0	2026-06-08 22:53:04	2026-06-08 22:53:04
7	14	33	2514	5	2	0	2	0	2026-06-08 22:53:04	2026-06-08 22:53:04
8	8	26	2113	0	3	0	5	0	2026-06-08 22:53:04	2026-06-08 22:53:04
9	10	21	1749	4	0	0	6	1	2026-06-08 22:53:04	2026-06-08 22:53:04
10	11	32	2311	2	1	0	9	1	2026-06-08 22:53:04	2026-06-08 22:53:04
11	12	32	1927	1	6	0	4	0	2026-06-08 22:53:04	2026-06-08 22:53:04
12	13	33	2423	5	10	0	7	0	2026-06-08 22:53:04	2026-06-08 22:53:04
13	17	28	1327	0	1	0	0	0	2026-06-08 22:53:04	2026-06-08 22:53:04
14	24	12	632	1	1	0	2	0	2026-06-08 22:53:04	2026-06-08 22:53:04
15	15	19	835	3	0	0	1	0	2026-06-08 22:53:04	2026-06-08 22:53:04
16	16	26	1281	1	2	0	3	0	2026-06-08 22:53:04	2026-06-08 22:53:04
17	22	34	1719	11	1	0	4	0	2026-06-08 22:53:04	2026-06-08 22:53:04
18	23	14	803	1	0	0	2	0	2026-06-08 22:53:04	2026-06-08 22:53:04
19	21	29	1912	5	4	0	0	1	2026-06-08 22:53:04	2026-06-08 22:53:04
\.


--
-- Data for Name: uzytkownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uzytkownicy (id, imie, nazwisko, pesel, data_urodzenia, email, password, rola, created_at, updated_at) FROM stdin;
1	Jakub	Pelic	22222222222	1998-04-23	kubapelic@gmiail.com	$2y$12$wco9C4XjebbK7rBYAMvWP.J1xvmVEZeT6ktAuejcZ7eAEoYUSMUHy	kibic	2026-06-08 23:25:14	2026-06-08 23:25:14
2	Marek	Karabuła	12345678900	1980-01-01	prezes@stal.pl	$2y$12$fZedS2np6.YiiYCIfDgSNeTdFdu0ju/oljRQQUJwLbP4Ul8oQXPba	prezes	2026-06-08 23:58:13	2026-06-08 23:58:13
\.


--
-- Name: bilety_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilety_id_seq', 2, true);


--
-- Name: druzyny_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.druzyny_id_seq', 33, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: mecze_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecze_id_seq', 5, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 11, true);


--
-- Name: pilkarze_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pilkarze_id_seq', 32, true);


--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statystyki_pilkarzy_id_seq', 19, true);


--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uzytkownicy_id_seq', 2, true);


--
-- Name: bilety bilety_kod_biletu_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_kod_biletu_unique UNIQUE (kod_biletu);


--
-- Name: bilety bilety_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_pkey PRIMARY KEY (id);


--
-- Name: bilety bilety_uzytkownik_mecz_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_uzytkownik_mecz_unique UNIQUE (uzytkownik_id, mecz_id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: druzyny druzyny_nazwa_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druzyny
    ADD CONSTRAINT druzyny_nazwa_unique UNIQUE (nazwa);


--
-- Name: druzyny druzyny_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.druzyny
    ADD CONSTRAINT druzyny_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: mecze mecze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecze
    ADD CONSTRAINT mecze_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: pilkarze pilkarze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilkarze
    ADD CONSTRAINT pilkarze_pkey PRIMARY KEY (id);


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pilkarz_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pilkarz_id_unique UNIQUE (pilkarz_id);


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pkey PRIMARY KEY (id);


--
-- Name: uzytkownicy uzytkownicy_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_email_unique UNIQUE (email);


--
-- Name: uzytkownicy uzytkownicy_pesel_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pesel_unique UNIQUE (pesel);


--
-- Name: uzytkownicy uzytkownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: failed_jobs_connection_queue_failed_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX failed_jobs_connection_queue_failed_at_index ON public.failed_jobs USING btree (connection, queue, failed_at);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: bilety bilety_mecz_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_mecz_id_foreign FOREIGN KEY (mecz_id) REFERENCES public.mecze(id) ON DELETE CASCADE;


--
-- Name: bilety bilety_uzytkownik_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_uzytkownik_id_foreign FOREIGN KEY (uzytkownik_id) REFERENCES public.uzytkownicy(id) ON DELETE SET NULL;


--
-- Name: mecze mecze_druzyna_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecze
    ADD CONSTRAINT mecze_druzyna_id_foreign FOREIGN KEY (druzyna_id) REFERENCES public.druzyny(id) ON DELETE CASCADE;


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pilkarz_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pilkarz_id_foreign FOREIGN KEY (pilkarz_id) REFERENCES public.pilkarze(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
