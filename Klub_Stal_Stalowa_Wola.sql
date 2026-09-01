-- Eksport bazy projektu Klub_Stal_Stalowa_Wola
-- Plik przygotowany do importu w pgAdmin Query Tool.
-- Zawiera strukture bazy i publiczne dane projektu.
-- Nie zawiera .env, sesji, cache, biletow ani prywatnych danych uzytkownikow.

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
DROP INDEX IF EXISTS public.sessions_user_id_index;
DROP INDEX IF EXISTS public.sessions_last_activity_index;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.failed_jobs_connection_queue_failed_at_index;
DROP INDEX IF EXISTS public.cache_locks_expiration_index;
DROP INDEX IF EXISTS public.cache_expiration_index;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_pkey;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_pesel_unique;
ALTER TABLE IF EXISTS ONLY public.uzytkownicy DROP CONSTRAINT IF EXISTS uzytkownicy_email_unique;
ALTER TABLE IF EXISTS ONLY public.statystyki_pilkarzy DROP CONSTRAINT IF EXISTS statystyki_pilkarzy_pkey;
ALTER TABLE IF EXISTS ONLY public.statystyki_pilkarzy DROP CONSTRAINT IF EXISTS statystyki_pilkarzy_pilkarz_id_unique;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
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
DROP TABLE IF EXISTS public.sessions;
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
-- Name: bilety; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: bilety_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bilety_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bilety_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bilety_id_seq OWNED BY public.bilety.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


--
-- Name: druzyny; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: druzyny_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.druzyny_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: druzyny_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.druzyny_id_seq OWNED BY public.druzyny.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: mecze; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: mecze_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mecze_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mecze_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mecze_id_seq OWNED BY public.mecze.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: pilkarze; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: pilkarze_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pilkarze_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pilkarze_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pilkarze_id_seq OWNED BY public.pilkarze.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: statystyki_pilkarzy; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statystyki_pilkarzy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statystyki_pilkarzy_id_seq OWNED BY public.statystyki_pilkarzy.id;


--
-- Name: uzytkownicy; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uzytkownicy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uzytkownicy_id_seq OWNED BY public.uzytkownicy.id;


--
-- Name: bilety id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety ALTER COLUMN id SET DEFAULT nextval('public.bilety_id_seq'::regclass);


--
-- Name: druzyny id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.druzyny ALTER COLUMN id SET DEFAULT nextval('public.druzyny_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: mecze id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mecze ALTER COLUMN id SET DEFAULT nextval('public.mecze_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: pilkarze id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilkarze ALTER COLUMN id SET DEFAULT nextval('public.pilkarze_id_seq'::regclass);


--
-- Name: statystyki_pilkarzy id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statystyki_pilkarzy ALTER COLUMN id SET DEFAULT nextval('public.statystyki_pilkarzy_id_seq'::regclass);


--
-- Name: uzytkownicy id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uzytkownicy ALTER COLUMN id SET DEFAULT nextval('public.uzytkownicy_id_seq'::regclass);


--
-- Data for Name: druzyny; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.druzyny VALUES (3, 'Hutnik Kraków', 11, 5, 11, 3, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (35, 'GKS Tychy', 11, 5, 9, 4, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (36, 'Znicz Pruszków', 10, 5, 8, 4, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (37, 'Zawisza Bydgoszcz', 10, 5, 8, 6, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (38, 'Avia Świdnik', 9, 5, 9, 9, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (14, 'Sandecja Nowy Sącz', 8, 5, 5, 4, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (40, 'Olimpia Grudziądz', 8, 5, 7, 8, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (41, 'Górnik Łęczna', 7, 5, 9, 8, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (13, 'Rekord Bielsko-Biała', 7, 5, 8, 7, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (43, 'Legia II Warszawa', 6, 5, 12, 7, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (44, 'Lechia Zielona Góra', 6, 5, 11, 7, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (19, 'Stal Stalowa Wola', 6, 5, 8, 7, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (46, 'Śląsk II Wrocław', 6, 5, 9, 9, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (1, 'Chojniczanka Chojnice', 6, 5, 5, 9, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (9, 'Podhale Nowy Targ', 5, 5, 8, 12, '2026-06-08 23:23:44', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (49, 'Sokół Kleczew', 5, 5, 6, 13, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (50, 'Resovia', 2, 5, 4, 10, '2026-08-28 12:53:40', '2026-08-28 12:53:40');
INSERT INTO public.druzyny VALUES (51, 'Świt Szczecin', 1, 5, 3, 13, '2026-08-28 12:53:40', '2026-08-28 12:53:40');


--
-- Data for Name: mecze; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.mecze VALUES (11, '2026-09-04 18:00:00', 'PCPN Stalowa Wola', 'Planowany', '2026-08-28 10:59:41', '2026-08-28 10:59:41', true, 37, NULL, NULL);
INSERT INTO public.mecze VALUES (13, '2026-09-20 12:00:00', 'PCPN Stalowa Wola', 'Planowany', '2026-08-28 11:06:09', '2026-08-28 11:06:09', true, 50, NULL, NULL);
INSERT INTO public.mecze VALUES (14, '2026-09-12 14:00:00', 'Stadion wyjazdowy', 'Planowany', '2026-08-28 11:07:07', '2026-08-28 11:07:07', false, 9, NULL, NULL);
INSERT INTO public.mecze VALUES (15, '2026-10-04 13:00:00', 'Stadion wyjazdowy', 'Planowany', '2026-08-28 11:08:21', '2026-08-28 11:08:21', false, 36, NULL, NULL);
INSERT INTO public.mecze VALUES (16, '2026-10-10 19:30:00', 'PCPN Stalowa Wola', 'Planowany', '2026-08-28 11:09:23', '2026-08-28 11:09:23', true, 46, NULL, NULL);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migrations VALUES (1, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO public.migrations VALUES (2, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO public.migrations VALUES (3, '2026_05_25_225051_create_mecze_table', 1);
INSERT INTO public.migrations VALUES (4, '2026_05_25_225535_create_bilety_table', 1);
INSERT INTO public.migrations VALUES (5, '2026_05_25_230203_create_pilkarze_table', 1);
INSERT INTO public.migrations VALUES (6, '2026_05_26_070458_create_uzytkownicy_table', 1);
INSERT INTO public.migrations VALUES (7, '2026_06_01_171718_create_druzyny_table', 1);
INSERT INTO public.migrations VALUES (8, '2026_06_08_181315_create_statystyki_pilkarzy_table', 1);
INSERT INTO public.migrations VALUES (9, '2026_06_08_211241_ustalanie_meczy_do_tabeli_druzyn', 1);
INSERT INTO public.migrations VALUES (10, '2026_06_09_000001_add_user_and_code_to_bilety_table', 2);
INSERT INTO public.migrations VALUES (11, '2026_06_09_000002_add_unique_user_match_to_bilety_table', 3);
INSERT INTO public.migrations VALUES (12, '2026_08_28_000000_create_sessions_table', 4);


--
-- Data for Name: pilkarze; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pilkarze VALUES (34, 'Krystian', 'Harciński', 1, 'Bramkarz', 'Krystian_Harcinski.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (35, 'Mikołaj', 'Smyłek', 12, 'Bramkarz', 'Mikołaj_Smylek.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (36, 'Jakub', 'Stępak', 33, 'Bramkarz', 'Jakub_Stepak.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (37, 'Bartłomiej', 'Kukułowicz', 2, 'Obrońca', 'Bartlomiej_Kukulowicz.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (38, 'Łukasz', 'Furtak', 3, 'Obrońca', 'Lukasz_Furtak.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (39, 'Piotr', 'Żemło', 4, 'Obrońca', 'Piotr_Zemlo.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (40, 'Maciej', 'Jaroszewski', 5, 'Obrońca', 'Maciej_Jaroszewski.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (41, 'Krystian', 'Getinger', 6, 'Obrońca', 'Krystian_Getinger.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (42, 'Igor', 'Fedejko', 13, 'Obrońca', 'Igor_Fedejko.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (43, 'Damian', 'Oko', 22, 'Obrońca', 'Damian_Oko.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (44, 'Mateusz', 'Radecki', 7, 'Pomocnik', 'Mateusz_Radecki.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (45, 'Lukas', 'Hrnciar', 8, 'Pomocnik', 'Lukas_Hrnciar.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (46, 'Maksymilian', 'Hebel', 10, 'Pomocnik', 'Maksymilian_Hebel.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (47, 'Patryk', 'Zaucha', 11, 'Pomocnik', 'Patryk_Zaucha.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (48, 'Krystian', 'Lelek', 14, 'Pomocnik', 'Krystian_Lelek.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (49, 'Hubert', 'Tomalski', 17, 'Pomocnik', 'Hubert_Tomalski.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (50, 'Michał', 'Surzyn', 18, 'Pomocnik', 'Michał_Surzyn.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (51, 'Jakub', 'Niedbała', 19, 'Pomocnik', 'Jakub_Niedbala.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (52, 'Jakub', 'Sobeczko', 20, 'Pomocnik', 'Jakub_Sobeczko.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (53, 'Piotr', 'Wójs', 21, 'Pomocnik', 'Piotr_Wojs.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (54, 'Jakub', 'Kendzia', 23, 'Pomocnik', 'Jakub_Kendzia.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (55, 'Dawid', 'Wolny', 9, 'Napastnik', 'Dawid_Wolny.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (56, 'Kacper', 'Śpiewak', 90, 'Napastnik', 'Kacper_Spiewak.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (57, 'Olaf', 'Nowak', 99, 'Napastnik', 'Olaf_Nowak.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (58, 'Dariusz', 'Kantor', 0, 'Sztab', 'Dariusz_Kantor.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (59, 'Stanisław', 'Szpyrka', 0, 'Sztab', 'Stanislaw_Szpyrka.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (60, 'Paweł', 'Żmuda', 0, 'Sztab', 'Paweł_Zmuda.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (61, 'Przemysław', 'Stelmach', 0, 'Sztab', 'Przemysław_Stelmach.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (62, 'Anna', 'Galant', 0, 'Sztab', 'Anna_Galant.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (63, 'Adrian', 'Golik', 0, 'Sztab', 'Adrian_Golik.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.pilkarze VALUES (64, 'Tomasz', 'Wietecha', 0, 'Sztab', 'Tomasz_Wietecha.png', '2026-08-28 10:21:33', '2026-08-28 10:21:33');


--
-- Data for Name: statystyki_pilkarzy; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.statystyki_pilkarzy VALUES (21, 35, 16, 1470, 0, 0, 1, 1, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (22, 36, 17, 1530, 0, 0, 1, 1, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (23, 34, 0, 0, 0, 0, 0, 0, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (24, 37, 28, 1479, 4, 3, 0, 7, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (25, 38, 26, 2364, 1, 0, 0, 10, 2, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (26, 39, 26, 2179, 2, 1, 0, 11, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (27, 47, 33, 2514, 5, 2, 0, 2, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (28, 41, 26, 2113, 0, 3, 0, 5, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (29, 43, 21, 1749, 4, 0, 0, 6, 1, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (30, 44, 32, 2311, 2, 1, 0, 9, 1, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (31, 45, 32, 1927, 1, 6, 0, 4, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (32, 46, 33, 2423, 5, 10, 0, 7, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (33, 50, 28, 1327, 0, 1, 0, 0, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (34, 57, 12, 632, 1, 1, 0, 2, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (35, 48, 19, 835, 3, 0, 0, 1, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (36, 49, 26, 1281, 1, 2, 0, 3, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (37, 55, 34, 1719, 11, 1, 0, 4, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (38, 56, 14, 803, 1, 0, 0, 2, 0, '2026-08-28 10:21:33', '2026-08-28 10:21:33');
INSERT INTO public.statystyki_pilkarzy VALUES (39, 54, 29, 1912, 5, 4, 0, 0, 1, '2026-08-28 10:21:33', '2026-08-28 10:21:33');


--
-- Name: bilety_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bilety_id_seq', 6, true);


--
-- Name: druzyny_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.druzyny_id_seq', 51, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: mecze_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.mecze_id_seq', 17, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 12, true);


--
-- Name: pilkarze_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pilkarze_id_seq', 64, true);


--
-- Name: statystyki_pilkarzy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.statystyki_pilkarzy_id_seq', 39, true);


--
-- Name: uzytkownicy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.uzytkownicy_id_seq', 3, true);


--
-- Name: bilety bilety_kod_biletu_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_kod_biletu_unique UNIQUE (kod_biletu);


--
-- Name: bilety bilety_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_pkey PRIMARY KEY (id);


--
-- Name: bilety bilety_uzytkownik_mecz_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_uzytkownik_mecz_unique UNIQUE (uzytkownik_id, mecz_id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: druzyny druzyny_nazwa_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.druzyny
    ADD CONSTRAINT druzyny_nazwa_unique UNIQUE (nazwa);


--
-- Name: druzyny druzyny_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.druzyny
    ADD CONSTRAINT druzyny_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: mecze mecze_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mecze
    ADD CONSTRAINT mecze_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: pilkarze pilkarze_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilkarze
    ADD CONSTRAINT pilkarze_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pilkarz_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pilkarz_id_unique UNIQUE (pilkarz_id);


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pkey PRIMARY KEY (id);


--
-- Name: uzytkownicy uzytkownicy_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_email_unique UNIQUE (email);


--
-- Name: uzytkownicy uzytkownicy_pesel_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pesel_unique UNIQUE (pesel);


--
-- Name: uzytkownicy uzytkownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: failed_jobs_connection_queue_failed_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX failed_jobs_connection_queue_failed_at_index ON public.failed_jobs USING btree (connection, queue, failed_at);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: bilety bilety_mecz_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_mecz_id_foreign FOREIGN KEY (mecz_id) REFERENCES public.mecze(id) ON DELETE CASCADE;


--
-- Name: bilety bilety_uzytkownik_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilety
    ADD CONSTRAINT bilety_uzytkownik_id_foreign FOREIGN KEY (uzytkownik_id) REFERENCES public.uzytkownicy(id) ON DELETE SET NULL;


--
-- Name: mecze mecze_druzyna_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mecze
    ADD CONSTRAINT mecze_druzyna_id_foreign FOREIGN KEY (druzyna_id) REFERENCES public.druzyny(id) ON DELETE CASCADE;


--
-- Name: statystyki_pilkarzy statystyki_pilkarzy_pilkarz_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statystyki_pilkarzy
    ADD CONSTRAINT statystyki_pilkarzy_pilkarz_id_foreign FOREIGN KEY (pilkarz_id) REFERENCES public.pilkarze(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--



-- Uwaga: dane uzytkownikow, bilety, sesje i cache nie sa eksportowane do pliku publicznego.
-- Konta testowe do logowania tworzy seeder w projekcie Laravel: php artisan db:seed --class=UzytkownikSeeder

