--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
-- Dumped by pg_dump version 14.1

-- Started on 2023-09-19 23:05:05

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
-- TOC entry 209 (class 1259 OID 16385)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16388)
-- Name: baskets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.baskets (
    id integer NOT NULL,
    count integer NOT NULL,
    user_id integer,
    product_item_id integer
);


ALTER TABLE public.baskets OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16391)
-- Name: baskets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.baskets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.baskets_id_seq OWNER TO postgres;

--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 211
-- Name: baskets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.baskets_id_seq OWNED BY public.baskets.id;


--
-- TOC entry 212 (class 1259 OID 16392)
-- Name: characteristics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characteristics (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.characteristics OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16395)
-- Name: characteristics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.characteristics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characteristics_id_seq OWNER TO postgres;

--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 213
-- Name: characteristics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characteristics_id_seq OWNED BY public.characteristics.id;


--
-- TOC entry 214 (class 1259 OID 16396)
-- Name: customer_tag_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_tag_links (
    customer_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.customer_tag_links OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    description character varying,
    "time" timestamp with time zone NOT NULL,
    details json NOT NULL,
    user_id integer
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16404)
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO postgres;

--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 216
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- TOC entry 217 (class 1259 OID 16405)
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id integer NOT NULL,
    user_id integer,
    product_item_id integer
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16408)
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favourites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favourites_id_seq OWNER TO postgres;

--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 218
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favourites_id_seq OWNED BY public.favourites.id;


--
-- TOC entry 219 (class 1259 OID 16409)
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    token character varying(255) NOT NULL,
    owner_id integer,
    details json
);


ALTER TABLE public.files OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16414)
-- Name: friend_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friend_types (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.friend_types OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: friend_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friend_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friend_types_id_seq OWNER TO postgres;

--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 221
-- Name: friend_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friend_types_id_seq OWNED BY public.friend_types.id;


--
-- TOC entry 222 (class 1259 OID 16420)
-- Name: friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friends (
    type character varying(255),
    initator_id integer NOT NULL,
    friend_id integer NOT NULL
);


ALTER TABLE public.friends OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    user_id integer NOT NULL,
    product_feedback_id integer NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16426)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    text text,
    user_id integer,
    created_at timestamp without time zone,
    details json
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16431)
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 225
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- TOC entry 226 (class 1259 OID 16432)
-- Name: product_favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_favourites (
    id integer NOT NULL,
    user_id integer,
    product_id integer
);


ALTER TABLE public.product_favourites OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16435)
-- Name: product_favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_favourites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_favourites_id_seq OWNER TO postgres;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 227
-- Name: product_favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_favourites_id_seq OWNED BY public.product_favourites.id;


--
-- TOC entry 228 (class 1259 OID 16436)
-- Name: product_feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_feedbacks (
    id integer NOT NULL,
    mark integer,
    review text,
    user_id integer,
    product_id integer
);


ALTER TABLE public.product_feedbacks OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16441)
-- Name: product_feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_feedbacks_id_seq OWNER TO postgres;

--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 229
-- Name: product_feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_feedbacks_id_seq OWNED BY public.product_feedbacks.id;


--
-- TOC entry 230 (class 1259 OID 16442)
-- Name: product_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_items (
    id integer NOT NULL,
    price integer,
    name character varying(255),
    details json,
    product_id integer,
    count integer
);


ALTER TABLE public.product_items OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16447)
-- Name: product_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_items_id_seq OWNER TO postgres;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_items_id_seq OWNED BY public.product_items.id;


--
-- TOC entry 232 (class 1259 OID 16448)
-- Name: product_tag_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tag_links (
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.product_tag_links OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16451)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    preview_img character varying(255),
    details json,
    store_id integer,
    is_service boolean
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16456)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 234
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 235 (class 1259 OID 16457)
-- Name: purshase_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purshase_histories (
    id integer NOT NULL,
    count integer NOT NULL,
    price integer NOT NULL,
    user_id integer,
    product_item_id integer,
    date timestamp without time zone
);


ALTER TABLE public.purshase_histories OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16460)
-- Name: purshase_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purshase_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purshase_histories_id_seq OWNER TO postgres;

--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 236
-- Name: purshase_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purshase_histories_id_seq OWNED BY public.purshase_histories.id;


--
-- TOC entry 237 (class 1259 OID 16461)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    details json,
    is_public boolean
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16466)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 238
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 239 (class 1259 OID 16467)
-- Name: store_tag_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_tag_links (
    store_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.store_tag_links OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16470)
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    img character varying(255),
    is_active boolean,
    address text,
    coordinates json,
    site text,
    details json,
    owner_id integer
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16475)
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stores_id_seq OWNER TO postgres;

--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 241
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- TOC entry 242 (class 1259 OID 16476)
-- Name: tag_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag_groups (
    id integer NOT NULL,
    name character varying(255),
    details json
);


ALTER TABLE public.tag_groups OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16481)
-- Name: tag_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 243
-- Name: tag_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_groups_id_seq OWNED BY public.tag_groups.id;


--
-- TOC entry 244 (class 1259 OID 16482)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(255),
    group_id integer,
    details json
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16487)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 245
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 246 (class 1259 OID 16488)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    path character varying(255),
    is_active boolean,
    details json,
    user_id integer,
    last_date_execute timestamp with time zone,
    duration interval,
    name character varying(255),
    date_execute timestamp with time zone
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16493)
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 247
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 248 (class 1259 OID 16494)
-- Name: unit_intervals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_intervals (
    id integer NOT NULL,
    name character varying(255),
    unit character varying(255),
    value integer,
    details json
);


ALTER TABLE public.unit_intervals OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16499)
-- Name: unit_intervals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_intervals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_intervals_id_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 249
-- Name: unit_intervals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_intervals_id_seq OWNED BY public.unit_intervals.id;


--
-- TOC entry 250 (class 1259 OID 16500)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(320) NOT NULL,
    hashed_password character varying(1024) NOT NULL,
    firstname character varying(100),
    lastname character varying(100),
    patronymic character varying(100),
    created_at timestamp without time zone,
    role_id integer,
    birthdate date,
    img text,
    gender boolean,
    cash integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16505)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3303 (class 2604 OID 16506)
-- Name: baskets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baskets ALTER COLUMN id SET DEFAULT nextval('public.baskets_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16507)
-- Name: characteristics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characteristics ALTER COLUMN id SET DEFAULT nextval('public.characteristics_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16508)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16509)
-- Name: favourites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites ALTER COLUMN id SET DEFAULT nextval('public.favourites_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16510)
-- Name: friend_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_types ALTER COLUMN id SET DEFAULT nextval('public.friend_types_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16511)
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16512)
-- Name: product_favourites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_favourites ALTER COLUMN id SET DEFAULT nextval('public.product_favourites_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16513)
-- Name: product_feedbacks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_feedbacks ALTER COLUMN id SET DEFAULT nextval('public.product_feedbacks_id_seq'::regclass);


--
-- TOC entry 3311 (class 2604 OID 16514)
-- Name: product_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items ALTER COLUMN id SET DEFAULT nextval('public.product_items_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 16515)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16516)
-- Name: purshase_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purshase_histories ALTER COLUMN id SET DEFAULT nextval('public.purshase_histories_id_seq'::regclass);


--
-- TOC entry 3314 (class 2604 OID 16517)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16518)
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 16519)
-- Name: tag_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_groups ALTER COLUMN id SET DEFAULT nextval('public.tag_groups_id_seq'::regclass);


--
-- TOC entry 3317 (class 2604 OID 16520)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 3318 (class 2604 OID 16521)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 16522)
-- Name: unit_intervals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_intervals ALTER COLUMN id SET DEFAULT nextval('public.unit_intervals_id_seq'::regclass);


--
-- TOC entry 3320 (class 2604 OID 16523)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3551 (class 0 OID 16385)
-- Dependencies: 209
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
9e0e60eb28f1
\.


--
-- TOC entry 3552 (class 0 OID 16388)
-- Dependencies: 210
-- Data for Name: baskets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.baskets (id, count, user_id, product_item_id) FROM stdin;
9	2	12	37
11	2	12	56
\.


--
-- TOC entry 3554 (class 0 OID 16392)
-- Dependencies: 212
-- Data for Name: characteristics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characteristics (id, name) FROM stdin;
2	Серия в одежде и обуви
3	Сезон
4	Цвет
5	Модельный год
6	Материал обода
7	Диаметр колес, дюймы
8	Размер
9	Длина
10	Материал
11	Вес
12	Количество в наборе
13	Диаметр грифа
14	Вес грифа
15	Внутренняя память
16	Модель процессора
17	Оперативная память
18	Общий объём    
19	Производитель
20	Объём
21	Сторона
22	Единиц в одном наборе
23	Время
24	Срочность
25	Издательство
26	Тип книги
27	Издание
28	Основной материал украшения:
29	Средний вес
30	Тип одежды
31	Оборудование
32	Готовность результата
33	Полнота разбора
34	Глубина консультации
35	Дальнейшее направление
36	Ширина
37	Высота
38	Состояние
39	Глубина
40	Количество в комлекте
41	Количество комлектов
42	Эффекты
43	Количество фото
44	Тип соуса
45	Толщина теста
46	Количество штук
47	Состав
48	Соус
49	Длительность
50	Авиабилеты
51	Отель
52	Еда
53	Каюта
54	Тип расходников
55	Тип шин
56	Балансировка
57	Тип плиты
58	Вывоз
59	Настройка работы
60	Тип холодильника
61	Форма выпуска
62	Дозировка
63	Сроки
64	Бригада
65	Материалы
66	Тип
67	Пол
68	Вид стрижки
69	Тип продукта
70	Марка
71	Разновидность
72	Вид
73	Возраст
74	Жирность
75	Объем
76	Сорт
77	Вид мяса
78	Процессор
79	Жесткий диск
80	Экран
81	Чипсет
82	Память
83	Интерфейс
84	Тип памяти
85	Объем памяти
86	Частота
87	Количество ядер
88	Количество потоков
89	Диагональ экрана
90	Разрешение экрана
91	Цветовой охват
92	Стандарт Wi-Fi
93	Скорость Wi-Fi
94	Порты Ethernet
95	Тип накопителя
96	Объем накопителя
97	Тип наушников
98	Технология шумоподавления
99	Частотный диапазон
100	Тип клавиатуры
101	Технология клавиш
102	Подсветка клавиш
103	Количество модулей
104	Графика
105	Хранилище
\.


--
-- TOC entry 3556 (class 0 OID 16396)
-- Dependencies: 214
-- Data for Name: customer_tag_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_tag_links (customer_id, tag_id) FROM stdin;
7	1
7	2
7	7
6	7
12	7
12	21
6	37
6	1
12	5
12	54
12	149
6	54
\.


--
-- TOC entry 3557 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, description, "time", details, user_id) FROM stdin;
12	string	2023-09-19 16:06:24.542+00	{}	12
13	string	2023-09-19 16:44:43.79+00	{}	12
14		0111-11-11 11:11:00+00	{}	12
15		0111-11-11 11:11:00+00	{}	12
16		0111-11-11 11:11:00+00	{}	12
17		0111-11-11 11:11:00+00	{}	12
18		1111-11-11 11:01:00+00	{}	12
19		0111-11-11 11:11:00+00	{}	12
20		0111-11-11 11:11:00+00	{}	12
\.


--
-- TOC entry 3559 (class 0 OID 16405)
-- Dependencies: 217
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favourites (id, user_id, product_item_id) FROM stdin;
4	12	39
5	6	12
6	6	9
\.


--
-- TOC entry 3561 (class 0 OID 16409)
-- Dependencies: 219
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files (token, owner_id, details) FROM stdin;
5db70f22f44d1146b243413d7c082464c634ef696ac22cc6271eda8d7a3f0e4b9027b7cdd1e5d999e3b3	1	{"token": "5db70f22f44d1146b243413d7c082464c634ef696ac22cc6271eda8d7a3f0e4b9027b7cdd1e5d999e3b3", "name": "8a1fbd8e2a2de62f0e97b5900.jpg", "size": 163975, "originalFilename": "composition-of-different-car-accessories.jpg", "createdAt": "2023-09-16T19:53:40.644Z", "mimeType": "image/jpeg", "deleteToken": "bdb136f5d52e114bff31"}
0f5bc5e318e07a42aee91b450f6d2f4b3278773cdc989b70535176edbb0221e61e690c29c35a69af751e	7	{"token": "0f5bc5e318e07a42aee91b450f6d2f4b3278773cdc989b70535176edbb0221e61e690c29c35a69af751e", "name": "fc38452031e1497caf242a300.jpg", "size": 75665, "originalFilename": "36938.jpg", "createdAt": "2023-09-16T19:58:38.195Z", "mimeType": "image/jpeg", "deleteToken": "fb0da7b71e4e207df804"}
86b35224f5c803d0f2199192b1a81dd393b4dbcb5f54efbef37db908d2b0c583ffee125981f15ef65935	2	{"token": "86b35224f5c803d0f2199192b1a81dd393b4dbcb5f54efbef37db908d2b0c583ffee125981f15ef65935", "name": "fc38452031e1497caf242a301.jpg", "size": 54954, "originalFilename": "7822490.jpg", "createdAt": "2023-09-16T20:00:51.888Z", "mimeType": "image/jpeg", "deleteToken": "959ea0a732ebcb3b7c70"}
2bcd8da748d955a666dbddac19865fc4f6082da97f2baff39dddeb24ab7c515339a3a5d3aa95facbf11b	2	{"token": "2bcd8da748d955a666dbddac19865fc4f6082da97f2baff39dddeb24ab7c515339a3a5d3aa95facbf11b", "name": "fc38452031e1497caf242a302.jpg", "size": 34493, "originalFilename": "7dbe7d19-00da-4b67-8bc8-d93624404f7b.jpg", "createdAt": "2023-09-16T20:03:05.889Z", "mimeType": "image/jpeg", "deleteToken": "d937de680de4c258e4ef"}
e0b72c97314342fcf12e427f7c73bbf321d8abed7a9ff05b7395f6c9c929615383c43e00fff303a961f3	3	{"token": "e0b72c97314342fcf12e427f7c73bbf321d8abed7a9ff05b7395f6c9c929615383c43e00fff303a961f3", "name": "fa61fc35523a23e05328cd800.jpg", "size": 222896, "originalFilename": "hand-drawn-fashion-atelier-twitch-background_23-2149405047.jpg", "createdAt": "2023-09-16T22:17:58.842Z", "mimeType": "image/jpeg", "deleteToken": "06218285fe21a49eff56"}
1540d62644e10639a5fd242a2a476f729186813253d1d6d3ba83a9d86aeddcfc2efc740f99598f9b7825	4	{"token": "1540d62644e10639a5fd242a2a476f729186813253d1d6d3ba83a9d86aeddcfc2efc740f99598f9b7825", "name": "fa61fc35523a23e05328cd801.jpg", "size": 270259, "originalFilename": "7588171.jpg", "createdAt": "2023-09-16T22:21:50.299Z", "mimeType": "image/jpeg", "deleteToken": "20fc63f75866e1bc5f11"}
7490e06a7886cfd7774dd7483e07eaff5790780e018be149f5cad44210b7953f3b64d4f6f7051ee615b8	5	{"token": "7490e06a7886cfd7774dd7483e07eaff5790780e018be149f5cad44210b7953f3b64d4f6f7051ee615b8", "name": "fa61fc35523a23e05328cd802.jpg", "size": 34803, "originalFilename": "v987-18a.jpg", "createdAt": "2023-09-16T22:25:11.297Z", "mimeType": "image/jpeg", "deleteToken": "7b88eeea618ca1ce1f55"}
2e1a44b0c5af8634bb139c23c22bdf8e01edf4b2d4438b43e436ff168fda1c46575bbe185f55a87af6b9	8	{"token": "2e1a44b0c5af8634bb139c23c22bdf8e01edf4b2d4438b43e436ff168fda1c46575bbe185f55a87af6b9", "name": "fa61fc35523a23e05328cd803.jpg", "size": 76614, "originalFilename": "4127633.jpg", "createdAt": "2023-09-16T22:28:20.054Z", "mimeType": "image/jpeg", "deleteToken": "d57d12d2941258a59fea"}
c1d99a58393289f4acc96c6e17236345dba41c228fa0d8f6b6b9bc167b3f50e25fceb28204b61a2076e5	9	{"token": "c1d99a58393289f4acc96c6e17236345dba41c228fa0d8f6b6b9bc167b3f50e25fceb28204b61a2076e5", "name": "fa61fc35523a23e05328cd804.jpg", "size": 131266, "originalFilename": "high-angle-clothes-on-bed-fast-fashion-concept.jpg", "createdAt": "2023-09-16T22:30:45.626Z", "mimeType": "image/jpeg", "deleteToken": "3e54a74a4cd75a64d389"}
f8ec85509f6de0ee2b2b51d35d3c845e96f2bd0ade4dfe90b8a5bc7830e6946d39b65ffba63e56bbfc64	10	{"token": "f8ec85509f6de0ee2b2b51d35d3c845e96f2bd0ade4dfe90b8a5bc7830e6946d39b65ffba63e56bbfc64", "name": "fa61fc35523a23e05328cd805.jpg", "size": 157689, "originalFilename": "a-modern-logo-for-a-modern-travel-agency-and-companies_753333-580.jpg", "createdAt": "2023-09-16T22:37:57.949Z", "mimeType": "image/jpeg", "deleteToken": "e739ab86484a0f42af27"}
2cad70fe43e30a307b2a23122f724be53c8d6d8a5a6f42da40c508ea387d1f95d9510964ac48472235be	11	{"token": "2cad70fe43e30a307b2a23122f724be53c8d6d8a5a6f42da40c508ea387d1f95d9510964ac48472235be", "name": "fa61fc35523a23e05328cd806.jpg", "size": 38694, "originalFilename": "original_57d7030540c08828298bb867_62e902c481f2a0.31404742.jpg", "createdAt": "2023-09-16T22:39:15.293Z", "mimeType": "image/jpeg", "deleteToken": "0209c19cea1d06a4b220"}
be734b399ee0012a049872e3add6a05b3c8476efdc7e7b571f936aa035817ae5242ce4e5a73fa7af3c3b	12	{"token": "be734b399ee0012a049872e3add6a05b3c8476efdc7e7b571f936aa035817ae5242ce4e5a73fa7af3c3b", "name": "fa61fc35523a23e05328cd807.jpg", "size": 160982, "originalFilename": "a-grocery-basket-with-a-handle-that-says-apple-on-it.jpg", "createdAt": "2023-09-16T22:40:29.662Z", "mimeType": "image/jpeg", "deleteToken": "be7d53afdc4e7bb7a45a"}
1cce96f0ac729849b45f6431b2307267c90e41d8b860f108b4e8d2d2804b3a24530526fb4f0a82283ac1	13	{"token": "1cce96f0ac729849b45f6431b2307267c90e41d8b860f108b4e8d2d2804b3a24530526fb4f0a82283ac1", "name": "fa61fc35523a23e05328cd808.jpg", "size": 60051, "originalFilename": "7916579.jpg", "createdAt": "2023-09-16T22:41:39.183Z", "mimeType": "image/jpeg", "deleteToken": "7e46140e2289d111d6e0"}
5bfa275d2235e658cdd387046fde63d0455e30d63a9192118c27ffa83acc887f51485d2a549de68846ae	13	{"token": "5bfa275d2235e658cdd387046fde63d0455e30d63a9192118c27ffa83acc887f51485d2a549de68846ae", "name": "fa61fc35523a23e05328cd809.jpg", "size": 124275, "originalFilename": "8329637.jpg", "createdAt": "2023-09-16T22:44:32.218Z", "mimeType": "image/jpeg", "deleteToken": "1040d1cf10c142cd376d"}
c2416d3100e2a1fe28ee5a8cac6567c43de07ecf0450b13ed48d998c4865b5b0f1d75400270a17003529	14	{"token": "c2416d3100e2a1fe28ee5a8cac6567c43de07ecf0450b13ed48d998c4865b5b0f1d75400270a17003529", "name": "fa61fc35523a23e05328cd80a.png", "size": 41816, "originalFilename": "800x400_4fd22130325e6c9f12b39f5c84818e80___jpg____4_f271c9e5.png", "createdAt": "2023-09-16T22:46:04.656Z", "mimeType": "image/png", "deleteToken": "67a5bbcef6402bebdd34"}
62eead118d0c92e900cd1d46ed1218aee3f1bd494661b209668a95f7ecf6a0be3ba547d7c53f5ba1409a	15	{"token": "62eead118d0c92e900cd1d46ed1218aee3f1bd494661b209668a95f7ecf6a0be3ba547d7c53f5ba1409a", "name": "fa61fc35523a23e05328cd80b.jpg", "size": 68247, "originalFilename": "1626352720896.jpg", "createdAt": "2023-09-16T22:48:47.745Z", "mimeType": "image/jpeg", "deleteToken": "80b237f91930a56978d1"}
199584414a152a32cb3de5724359c8157ebf6afd52b018b7ecb94eeee6308f00220e5060cdcb4061629a	15	{"token": "199584414a152a32cb3de5724359c8157ebf6afd52b018b7ecb94eeee6308f00220e5060cdcb4061629a", "name": "fa61fc35523a23e05328cd80c.jpg", "size": 89764, "originalFilename": "4964127.jpg", "createdAt": "2023-09-16T22:57:42.347Z", "mimeType": "image/jpeg", "deleteToken": "e7e0c1839768ccbd81a9"}
dc590b001d7a5a44175cfca9721b9bd64cd12a8f5645a0f6a597c78e4a421575cf96e6114ca226fe84c8	16	{"token": "dc590b001d7a5a44175cfca9721b9bd64cd12a8f5645a0f6a597c78e4a421575cf96e6114ca226fe84c8", "name": "fa61fc35523a23e05328cd80d.jpg", "size": 56874, "originalFilename": "7630077.jpg", "createdAt": "2023-09-16T22:59:36.288Z", "mimeType": "image/jpeg", "deleteToken": "f0996b495ed9fddd582d"}
c92d40be2dd31dfdf1b321e3f752a08777215a48ce41c14a4a2b79a927b5b6d371488fe1e67bddfed388	16	{"token": "c92d40be2dd31dfdf1b321e3f752a08777215a48ce41c14a4a2b79a927b5b6d371488fe1e67bddfed388", "name": "fa61fc35523a23e05328cd80e.png", "size": 6313, "originalFilename": "\\u0411\\u0435\\u0437 \\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f.png", "createdAt": "2023-09-16T23:01:12.649Z", "mimeType": "image/png", "deleteToken": "636fc7a737b9df858ce0"}
46807a8be7aaec82d91ca9501d371c023fc9c7179aaa3bd54216c8a77b14bbcb0d4d411308757edba477	17	{"token": "46807a8be7aaec82d91ca9501d371c023fc9c7179aaa3bd54216c8a77b14bbcb0d4d411308757edba477", "name": "fa61fc35523a23e05328cd80f.jpg", "size": 129490, "originalFilename": "top-view-bouquet-red-roses-craft-paper-with-attached-postcard-lying-laptop-with-paper-cup-coffee-dark-wooden-background.jpg", "createdAt": "2023-09-16T23:02:32.062Z", "mimeType": "image/jpeg", "deleteToken": "63b958e9164a497afa7a"}
255b181a41a6b7d45ea573f7a427b730b68fce3d97750768724830efa4336ed36f02a5091ed9670fb764	27	{"token": "255b181a41a6b7d45ea573f7a427b730b68fce3d97750768724830efa4336ed36f02a5091ed9670fb764", "name": "4d548de07bb364952b9fc1b1c.png", "size": 23503, "originalFilename": "Screenshot 2023-09-16 180122.png", "createdAt": "2023-09-19T13:58:22.237Z", "mimeType": "image/png", "deleteToken": "8d700cb695013810e809"}
6dde07c7eb3aa6da57206cd2ad5db4193132dc527a9e66d91a9feb162d5bc560b70e58c4cc331d4a0b87	27	{"token": "6dde07c7eb3aa6da57206cd2ad5db4193132dc527a9e66d91a9feb162d5bc560b70e58c4cc331d4a0b87", "name": "4d548de07bb364952b9fc1b1d.jpg", "size": 5516, "originalFilename": "Screenshot 2023-09-16 180122.jpg", "createdAt": "2023-09-19T14:00:33.581Z", "mimeType": "image/jpeg", "deleteToken": "d4b8526040885a867c69"}
ad96e2c68ca2338d5875a5f54139529cbb175ed4dcfa1fb59e7ad4c8da9d7cbe0988f2fd9b61e12810ec	12	{"token": "ad96e2c68ca2338d5875a5f54139529cbb175ed4dcfa1fb59e7ad4c8da9d7cbe0988f2fd9b61e12810ec", "name": "4d548de07bb364952b9fc1b1e.jpg", "size": 93964, "originalFilename": "photo_2021-07-27_11-58-03.jpg", "createdAt": "2023-09-19T14:01:57.086Z", "mimeType": "image/jpeg", "deleteToken": "07a40a903e14957acba4"}
159284c3d88bdb5fa6939939581f4b87ae41f4c144123f958bb8fd2aef1add3c2f29bc32eabe5994c288	6	{"token": "159284c3d88bdb5fa6939939581f4b87ae41f4c144123f958bb8fd2aef1add3c2f29bc32eabe5994c288", "name": "4d548de07bb364952b9fc1b1f.png", "size": 23503, "originalFilename": "Screenshot 2023-09-16 180122.png", "createdAt": "2023-09-19T14:03:34.330Z", "mimeType": "image/png", "deleteToken": "f4f63fda6ffaaeeb8e8b"}
bb679d7a64b9203a63f2e46c0cafd597847666cd15cda55cb0ee2dd42f2190ee81da05c86a84cc9f763a	12	{"token": "bb679d7a64b9203a63f2e46c0cafd597847666cd15cda55cb0ee2dd42f2190ee81da05c86a84cc9f763a", "name": "4d548de07bb364952b9fc1b20.jpg", "size": 93964, "originalFilename": "photo_2021-07-27_11-58-03.jpg", "createdAt": "2023-09-19T14:13:57.686Z", "mimeType": "image/jpeg", "deleteToken": "c2a9b02392b08cda9d52"}
1a34c1dc1d84567acfd98fbc98d8857ce3ec9cf042ef57e33de59d7dc6b90d061c0ebc9977f2cd535855	12	{"token": "1a34c1dc1d84567acfd98fbc98d8857ce3ec9cf042ef57e33de59d7dc6b90d061c0ebc9977f2cd535855", "name": "4d548de07bb364952b9fc1b21.jpg", "size": 93964, "originalFilename": "photo_2021-07-27_11-58-03.jpg", "createdAt": "2023-09-19T14:14:04.487Z", "mimeType": "image/jpeg", "deleteToken": "6cf583e7be6a4980004d"}
f90810b6300d0d499603217a7218cd01ce0ab2583e8a3da52bcba2582e22495524a31fcd58e7f6baf557	6	{"token": "f90810b6300d0d499603217a7218cd01ce0ab2583e8a3da52bcba2582e22495524a31fcd58e7f6baf557", "name": "4d548de07bb364952b9fc1b23.jpg", "size": 874491, "originalFilename": "Xb1Y58qsN-Y.jpg", "createdAt": "2023-09-19T16:28:55.060Z", "mimeType": "image/jpeg", "deleteToken": "959f36abcbb31b70718b"}
cfa743f47392a0e71b181e88431ea88269056ab7d02fdd2350ecfd4388ccd81a4d47333ddd5c531921ba	6	{"token": "cfa743f47392a0e71b181e88431ea88269056ab7d02fdd2350ecfd4388ccd81a4d47333ddd5c531921ba", "name": "4d548de07bb364952b9fc1b24.png", "size": 15921, "originalFilename": "89f4567a-9546-40a4-bced-c86bebb0e5be.png", "createdAt": "2023-09-19T16:38:28.341Z", "mimeType": "image/png", "deleteToken": "b87422a406c454365359"}
\.


--
-- TOC entry 3562 (class 0 OID 16414)
-- Dependencies: 220
-- Data for Name: friend_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friend_types (id, name) FROM stdin;
1	Муж
2	Жена
3	Дочь
4	Друг
5	Сын
6	Подруга
7	Дядя
8	Тетя
\.


--
-- TOC entry 3564 (class 0 OID 16420)
-- Dependencies: 222
-- Data for Name: friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friends (type, initator_id, friend_id) FROM stdin;
string	12	6
string	12	7
Друг	12	1
\.


--
-- TOC entry 3565 (class 0 OID 16423)
-- Dependencies: 223
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (user_id, product_feedback_id) FROM stdin;
\.


--
-- TOC entry 3566 (class 0 OID 16426)
-- Dependencies: 224
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, text, user_id, created_at, details) FROM stdin;
\.


--
-- TOC entry 3568 (class 0 OID 16432)
-- Dependencies: 226
-- Data for Name: product_favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_favourites (id, user_id, product_id) FROM stdin;
\.


--
-- TOC entry 3570 (class 0 OID 16436)
-- Dependencies: 228
-- Data for Name: product_feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_feedbacks (id, mark, review, user_id, product_id) FROM stdin;
1	5	Метод не работает - срок действия токена истек	6	5
\.


--
-- TOC entry 3572 (class 0 OID 16442)
-- Dependencies: 230
-- Data for Name: product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_items (id, price, name, details, product_id, count) FROM stdin;
3	10000	Nike Air Max 270 Black	{"characteristics": [{"Размер": 42}]}	5	550
19	19000	Xiaomi Redmi Note 12S 6	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}, {"\\u0412\\u043d\\u0443\\u0442\\u0440\\u0435\\u043d\\u043d\\u044f\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "256 \\u0433\\u0431"}]}	14	85
81	3490	Шиномонтаж (стандарт)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0448\\u0438\\u043d": "\\u041b\\u0435\\u0442\\u043d\\u0438\\u0435"}, {"\\u0411\\u0430\\u043b\\u0430\\u043d\\u0441\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u041e\\u0442\\u0435\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0439"}]}	41	51
98	200	Красный трактор на колесах	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0426\\u0432\\u0435\\u0442\\u044b"}, {"\\u0412\\u0438\\u0434": "\\u0420\\u043e\\u0437\\u044b"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0411\\u0435\\u043b\\u044b\\u0435"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u041a\\u0440\\u0430\\u0441\\u043d\\u044b\\u0439"}]}	49	62
93	90	Шоколад Alpen Gold с фундуком	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0428\\u043e\\u043a\\u043e\\u043b\\u0430\\u0434"}, {"\\u041c\\u0430\\u0440\\u043a\\u0430": "Alpen Gold"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0424\\u0443\\u043d\\u0434\\u0443\\u043a"}]}	47	53
22	43000	Ноутбук F+ FLAPTOP R-series AMD Ryzen 5	{"characteristics": [{"\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c \\u043f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440\\u0430": "AMD Ryzen 5"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0433\\u0431"}, {"\\u041e\\u0431\\u0449\\u0438\\u0439 \\u043e\\u0431\\u044a\\u0451\\u043c    ": "512 \\u0433\\u0431"}]}	15	55
23	55000	Ноутбук F+ FLAPTOP R-series AMD Ryzen 7	{"characteristics": [{"\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c \\u043f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440\\u0430": "AMD Ryzen 7"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "16 \\u0433\\u0431"}, {"\\u041e\\u0431\\u0449\\u0438\\u0439 \\u043e\\u0431\\u044a\\u0451\\u043c    ": "512 \\u0433\\u0431"}]}	15	52
24	1500	TechnoGrand Smart Watch x7 pro pink	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0420\\u043e\\u0437\\u043e\\u0432\\u044b\\u0439"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u041a\\u0438\\u0442\\u0430\\u0439"}]}	16	60
25	1700	TechnoGrand Smart Watch x7 pro black	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0435\\u0440\\u043d\\u044b\\u0439"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u0412\\u044c\\u0435\\u0442\\u043d\\u0430\\u043c"}]}	16	55
26	1750	TechnoGrand Smart Watch x7 pro green	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0417\\u0435\\u043b\\u0451\\u043d\\u044b\\u0439"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u041a\\u0438\\u0442\\u0430\\u0439"}]}	16	52
27	1500	Ремонтный полупорог левый на Toyota Corolla E120 E130 2000-2007	{"characteristics": [{"\\u041e\\u0431\\u044a\\u0451\\u043c": "0.8 \\u043b"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u041e\\u0446\\u0438\\u043d\\u043a\\u043e\\u0432\\u0430\\u043d\\u043d\\u0430\\u044f \\u0441\\u0442\\u0430\\u043b\\u044c"}, {"\\u0421\\u0442\\u043e\\u0440\\u043e\\u043d\\u0430": "\\u041b\\u0435\\u0432\\u044b\\u0439"}]}	17	60
28	1750	Ремонтный полупорог правый на Toyota Corolla E120 E130 2000-2007	{"characteristics": [{"\\u041e\\u0431\\u044a\\u0451\\u043c": "1 \\u043b"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0425\\u043e\\u043b\\u043e\\u0434\\u043d\\u043e\\u043a\\u0430\\u0442\\u0430\\u043d\\u0430\\u044f \\u0441\\u0442\\u0430\\u043b\\u044c"}, {"\\u0421\\u0442\\u043e\\u0440\\u043e\\u043d\\u0430": "\\u041f\\u0440\\u0430\\u0432\\u044b\\u0439"}]}	17	55
4	9500	Nike Air Max 270 White	{"characteristics": [{"Размер": 38}]}	5	550
5	60000	Scott Scale 970 Blue	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "\\u041c"}]}	8	90
6	11000	Nike Air Max 270 Blue	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": 44}]}	5	60
7	65000	Scott Scale 970 Green	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "L"}]}	8	60
8	70000	Scott Scale 970 Red	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "XL"}]}	8	60
9	50000	Fischer RCS Carbonlite Skate Plus 180	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "180 \\u0441\\u043c"}]}	9	53
10	55000	Fischer RCS Carbonlite Skate Plus 185	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "185 \\u0441\\u043c"}]}	9	52
11	60000	Fischer RCS Carbonlite Skate Plus 190	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "190 \\u0441\\u043c"}]}	9	51
12	1500	Reebok Rubber Hex Dumbbell 2 kg	{"characteristics": [{"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 2}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0420\\u0435\\u0437\\u0438\\u043d\\u0430"}]}	10	60
13	3000	Reebok Rubber Hex Dumbbell 5 kg	{"characteristics": [{"\\u0412\\u0435\\u0441": "5 \\u043a\\u0433"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 4}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041c\\u0435\\u0442\\u0430\\u043b\\u043b"}]}	10	58
14	5000	Reebok Rubber Hex Dumbbell 10 kg	{"characteristics": [{"\\u0412\\u0435\\u0441": "10 \\u043a\\u0433"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 2}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041c\\u0435\\u0442\\u0430\\u043b\\u043b"}]}	10	55
15	25000	Champion Power Bar Standard	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "2 \\u043c"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0410\\u043b\\u044e\\u043c\\u0438\\u043d\\u0438\\u0439"}, {"\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u0433\\u0440\\u0438\\u0444\\u0430": "25 \\u043c\\u043c"}, {"\\u0412\\u0435\\u0441 \\u0433\\u0440\\u0438\\u0444\\u0430": "5 \\u043a\\u0433"}]}	11	55
16	30000	Champion Power Bar Olympic	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "2.2 \\u043c"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0410\\u043b\\u044e\\u043c\\u0438\\u043d\\u0438\\u0439"}, {"\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u0433\\u0440\\u0438\\u0444\\u0430": "30 \\u043c\\u043c"}, {"\\u0412\\u0435\\u0441 \\u0433\\u0440\\u0438\\u0444\\u0430": "7 \\u043a\\u0433"}]}	11	53
17	35000	Champion Power Bar Elite	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "2.4 \\u043c"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0410\\u043b\\u044e\\u043c\\u0438\\u043d\\u0438\\u0439"}, {"\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u0433\\u0440\\u0438\\u0444\\u0430": "35 \\u043c\\u043c"}, {"\\u0412\\u0435\\u0441 \\u0433\\u0440\\u0438\\u0444\\u0430": "10 \\u043a\\u0433"}]}	11	52
18	20000	Xiaomi Redmi Note 12S 8	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0417\\u0435\\u043b\\u0435\\u043d\\u044b\\u0439"}, {"\\u0412\\u043d\\u0443\\u0442\\u0440\\u0435\\u043d\\u043d\\u044f\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "256 \\u0433\\u0431"}]}	14	100
20	20000	Champion Power Bar Elite	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u041a\\u0440\\u0430\\u0441\\u043d\\u044b\\u0439"}, {"\\u0412\\u043d\\u0443\\u0442\\u0440\\u0435\\u043d\\u043d\\u044f\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "256 \\u0433\\u0431"}]}	14	70
21	40000	Ноутбук F+ FLAPTOP R-series AMD Ryzen 3	{"characteristics": [{"\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c \\u043f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440\\u0430": "AMD Ryzen 3"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0433\\u0431"}, {"\\u041e\\u0431\\u0449\\u0438\\u0439 \\u043e\\u0431\\u044a\\u0451\\u043c    ": "256 \\u0433\\u0431"}]}	15	60
29	1750	Ремонтный полупорог левый на Toyota Corolla E120 E130 2000-2007	{"characteristics": [{"\\u041e\\u0431\\u044a\\u0451\\u043c": "1.5 \\u043b"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0425\\u043e\\u043b\\u043e\\u0434\\u043d\\u043e\\u043a\\u0430\\u0442\\u0430\\u043d\\u0430\\u044f \\u0441\\u0442\\u0430\\u043b\\u044c"}, {"\\u0421\\u0442\\u043e\\u0440\\u043e\\u043d\\u0430": "\\u041b\\u0435\\u0432\\u044b\\u0439"}]}	17	52
30	540	Тряпка из микрофибры и замши для автомобиля	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "30*40"}, {"\\u0415\\u0434\\u0438\\u043d\\u0438\\u0446 \\u0432 \\u043e\\u0434\\u043d\\u043e\\u043c \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 1}]}	18	60
31	1000	Тряпка из микрофибры и замши для автомобиля	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "30*40+30*60"}, {"\\u0415\\u0434\\u0438\\u043d\\u0438\\u0446 \\u0432 \\u043e\\u0434\\u043d\\u043e\\u043c \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 2}]}	18	55
32	1000	Детейлинг срочный салона автомобиля	{"characteristics": [{"\\u0412\\u0440\\u0435\\u043c\\u044f": "3 \\u0434\\u043d\\u044f"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}]}	19	51
33	1500	Детейлинг срочный салона автомобиля	{"characteristics": [{"\\u0412\\u0440\\u0435\\u043c\\u044f": "1 \\u0434\\u0435\\u043d\\u044c"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}]}	19	51
34	417	Английский язык. Контрольные задания. 7 класс. ФГОС / Английский в фокусе. Spotlight / Просвещение	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u0442\\u0435\\u043b\\u044c\\u0441\\u0442\\u0432\\u043e": "\\u041f\\u0440\\u043e\\u0441\\u0432\\u0435\\u0449\\u0435\\u043d\\u0438\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	20	61
35	717	Английский язык. Контрольные задания. 7 класс. ФГОС / Английский в фокусе. Spotlight / Pearson	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u0442\\u0435\\u043b\\u044c\\u0441\\u0442\\u0432\\u043e": "Pearson"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	20	52
36	576	На одной волне со Вселенной. Живая психология и немножечко чудес. О тебе, об отношениях и о том, как прекратить играть в прятки со счастьем.Краткое	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041a\\u0440\\u0430\\u0442\\u043a\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	21	57
37	590	На одной волне со Вселенной. Живая психология и немножечко чудес. О тебе, об отношениях и о том, как прекратить играть в прятки со счастьем.С объяснениями	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u0421 \\u043e\\u0431\\u044a\\u0441\\u043d\\u0435\\u043d\\u0438\\u044f\\u043c\\u0438"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	21	61
38	666	На одной волне со Вселенной. Живая психология и немножечко чудес. О тебе, об отношениях и о том, как прекратить играть в прятки со счастьем.Полное	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041f\\u043e\\u043b\\u043d\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u042d\\u043b\\u0435\\u043a\\u0442\\u0440\\u043e\\u043d\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	21	55
40	211	Обучающие лабиринты. Сложение и вычитание. 8-9 лет.С объяснениями	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u0421 \\u043e\\u0431\\u044a\\u0441\\u043d\\u0435\\u043d\\u0438\\u044f\\u043c\\u0438"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	22	61
41	348	Обучающие лабиринты. Сложение и вычитание. 8-9 лет.Полное	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041f\\u043e\\u043b\\u043d\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u042d\\u043b\\u0435\\u043a\\u0442\\u0440\\u043e\\u043d\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	22	55
42	1816	Крестик Серебро 925 Золочение Распятие Молитва Да воскреснет Бог	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043f\\u043e\\u0437\\u043e\\u043b\\u043e\\u0447\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "23 \\u0445 46 \\u043c\\u043c"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "5 \\u0433\\u0440."}]}	23	64
59	2300	Комплект стульев HW9001 SOKOLTEC, 2 шт.	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u041d\\u043e\\u0432\\u043e\\u0435"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u043a\\u043e\\u043c\\u043b\\u0435\\u043a\\u0442\\u043e\\u0432": 2}]}	31	56
60	7500	Платье 'Вечерний шик'.S	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0428\\u0438\\u0444\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "S"}]}	32	54
61	7800	Платье 'Вечерний шик'.M	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0428\\u0438\\u0444\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "M"}]}	32	56
43	909	Крестик Серебро 925 Распятие Молитва Да воскреснет Бог Частичная Позолота Оксидирование к280 Магазин Жюте 925	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043e\\u043a\\u0441\\u0438\\u0434\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "12 \\u0445 23 \\u043c\\u043c"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "2.5 \\u0433\\u0440."}]}	23	62
44	821	Подвеска Амулет Оберег Зеркало МАЛЕНЬКАЯ Серебро 925 с Золочением Магазин ЖюТе 925	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043f\\u043e\\u0437\\u043e\\u043b\\u043e\\u0447\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u041f\\u043e\\u0434\\u0432\\u0435\\u0441\\u043a\\u0438 14 \\u043c\\u043c + \\u0423\\u0448\\u043a\\u043e"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "1 \\u0433\\u0440."}]}	24	54
45	839	Подвеска Амулет Оберег Зеркало МАЛЕНЬКАЯ Серебро 925 Платинированное Магазин ЖюТе 925	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043f\\u043b\\u0430\\u0442\\u0438\\u043d\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u041f\\u043e\\u0434\\u0432\\u0435\\u0441\\u043a\\u0438 14 \\u043c\\u043c + \\u0423\\u0448\\u043a\\u043e"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "1 \\u0433\\u0440."}]}	24	52
46	900	Ремонт одежды. Штаны	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041a\\u043e\\u0436\\u0430"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u0428\\u0442\\u0430\\u043d\\u044b"}]}	25	51
47	1000	Ремонт одежды. Рубашка	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0425\\u043b\\u043e\\u043f\\u043e\\u043a"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u0420\\u0443\\u0431\\u0430\\u0448\\u043a\\u0430"}]}	25	51
48	9000	Ремонт одежды. Куртка	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041a\\u043e\\u0436\\u0430"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u041a\\u0443\\u0440\\u0442\\u043a\\u0430"}]}	26	51
49	10000	Ремонт одежды. Платье	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0428\\u0435\\u043b\\u043a"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u041f\\u043b\\u0430\\u0442\\u044c\\u0435"}]}	26	51
50	1500	Сдача анализов. Кровь	{"characteristics": [{"\\u041e\\u0431\\u043e\\u0440\\u0443\\u0434\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435": "\\u0418\\u043c\\u043f\\u043e\\u0440\\u0442\\u043d\\u043e\\u0435"}, {"\\u0413\\u043e\\u0442\\u043e\\u0432\\u043d\\u043e\\u0441\\u0442\\u044c \\u0440\\u0435\\u0437\\u0443\\u043b\\u044c\\u0442\\u0430\\u0442\\u0430": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0435"}, {"\\u041f\\u043e\\u043b\\u043d\\u043e\\u0442\\u0430 \\u0440\\u0430\\u0437\\u0431\\u043e\\u0440\\u0430": "\\u041f\\u043e\\u043b\\u043d\\u044b\\u0439"}]}	27	51
51	1000	Сдача анализов. Гормоны	{"characteristics": [{"\\u041e\\u0431\\u043e\\u0440\\u0443\\u0434\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435": "\\u041e\\u0442\\u0435\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0413\\u043e\\u0442\\u043e\\u0432\\u043d\\u043e\\u0441\\u0442\\u044c \\u0440\\u0435\\u0437\\u0443\\u043b\\u044c\\u0442\\u0430\\u0442\\u0430": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e\\u0435"}, {"\\u041f\\u043e\\u043b\\u043d\\u043e\\u0442\\u0430 \\u0440\\u0430\\u0437\\u0431\\u043e\\u0440\\u0430": "\\u041f\\u043e\\u043b\\u043d\\u044b\\u0439"}]}	27	51
52	1500	Приём у терапевта	{"characteristics": [{"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430 \\u043a\\u043e\\u043d\\u0441\\u0443\\u043b\\u044c\\u0442\\u0430\\u0446\\u0438\\u0438": "\\u041f\\u043e\\u043b\\u043d\\u0430\\u044f"}, {"\\u0414\\u0430\\u043b\\u044c\\u043d\\u0435\\u0439\\u0448\\u0435\\u0435 \\u043d\\u0430\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435": "\\u0412\\u044b\\u043f\\u0438\\u0441\\u044b\\u0432\\u0430\\u0435\\u0442\\u0441\\u044f"}]}	28	51
53	1500	Приём у терапевта	{"characteristics": [{"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430 \\u043a\\u043e\\u043d\\u0441\\u0443\\u043b\\u044c\\u0442\\u0430\\u0446\\u0438\\u0438": "\\u0427\\u0430\\u0441\\u0442\\u0438\\u0447\\u043d\\u0430\\u044f"}, {"\\u0414\\u0430\\u043b\\u044c\\u043d\\u0435\\u0439\\u0448\\u0435\\u0435 \\u043d\\u0430\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435": "\\u041d\\u0435 \\u0432\\u044b\\u043f\\u0438\\u0441\\u044b\\u0432\\u0430\\u0435\\u0442\\u0441\\u044f"}]}	28	51
54	8500	Матрас ASKONA Forma Акция серия Balance, Независимые пружины, 120х200 см	{"characteristics": [{"\\u0428\\u0438\\u0440\\u0438\\u043d\\u0430": 120}, {"\\u0414\\u043b\\u0438\\u043d\\u0430": 200}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 19}]}	29	58
55	10200	Матрас ASKONA Forma Акция серия Balance, Независимые пружины, 160х200 см	{"characteristics": [{"\\u0428\\u0438\\u0440\\u0438\\u043d\\u0430": 160}, {"\\u0414\\u043b\\u0438\\u043d\\u0430": 200}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 19}]}	29	56
56	1000	Обувница для прихожей, этажерка для обуви 3 яруса	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u041d\\u043e\\u0432\\u043e\\u0435"}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 70}, {"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430": 35}]}	30	62
57	1300	Обувница для прихожей, этажерка для обуви 3 яруса. Уцененный товар	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u0423\\u0446\\u0435\\u043d\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 70}, {"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430": 35}]}	30	53
58	4500	Комплект стульев _SOKOLTEC_HW900_, 4 шт. 	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u041d\\u043e\\u0432\\u043e\\u0435"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0411\\u0435\\u043b\\u044b\\u0439"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043a\\u043e\\u043c\\u043b\\u0435\\u043a\\u0442\\u0435": 4}]}	31	54
103	300	Сыр Российский 'Веселый молочник' 500 г	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "45%"}, {"\\u0412\\u0435\\u0441": "500 \\u0433"}]}	51	50
62	2500	Куртка 'Спортивный стиль'. Синий S	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041d\\u0435\\u0439\\u043b\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "S"}]}	33	59
63	2300	Куртка 'Спортивный стиль'. Чёрный M	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041d\\u0435\\u0439\\u043b\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "M"}]}	33	66
64	1500	Сумка 'Городская жизнь'. Искусственная кожа коричневый	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0418\\u0441\\u043a\\u0443\\u0441\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u0430\\u044f \\u043a\\u043e\\u0436\\u0430"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u041a\\u043e\\u0440\\u0438\\u0447\\u043d\\u0435\\u0432\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "One Size"}]}	34	53
65	2300	Куртка 'Спортивный стиль'. Чёрный Кожзам	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041a\\u043e\\u0436\\u0437\\u0430\\u043c"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "One Size"}]}	34	51
66	4300	Куртка 'Спортивный стиль'. Чёрный Натуральная кожа	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041d\\u0430\\u0442\\u0443\\u0440\\u0430\\u043b\\u044c\\u043d\\u0430\\u044f \\u043a\\u043e\\u0436\\u0430"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "One Size"}]}	34	63
67	500	Сфотографировать для фото.	{"characteristics": [{"\\u042d\\u0444\\u0444\\u0435\\u043a\\u0442\\u044b": "\\u0423\\u043b\\u0443\\u0447\\u0448\\u0435\\u043d\\u0438\\u0435 \\u043b\\u0438\\u0446\\u0430"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0444\\u043e\\u0442\\u043e": 4}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "3x4"}]}	35	51
68	490	Пицца 'Маргарита'(30 см)	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "30 \\u0441\\u043c"}, {"\\u0422\\u0438\\u043f \\u0441\\u043e\\u0443\\u0441\\u0430": "\\u0422\\u043e\\u043c\\u0430\\u0442\\u043d\\u044b\\u0439"}, {"\\u0422\\u043e\\u043b\\u0449\\u0438\\u043d\\u0430 \\u0442\\u0435\\u0441\\u0442\\u0430": "\\u0421\\u0440\\u0435\\u0434\\u043d\\u044f\\u044f"}]}	36	51
69	590	Пицца 'Маргарита'(35 см)	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "35 \\u0441\\u043c"}, {"\\u0422\\u0438\\u043f \\u0441\\u043e\\u0443\\u0441\\u0430": "\\u0422\\u043e\\u043c\\u0430\\u0442\\u043d\\u044b\\u0439"}, {"\\u0422\\u043e\\u043b\\u0449\\u0438\\u043d\\u0430 \\u0442\\u0435\\u0441\\u0442\\u0430": "\\u0421\\u0440\\u0435\\u0434\\u043d\\u044f\\u044f"}]}	36	51
70	690	Пицца 'Маргарита'(40 см)	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "40 \\u0441\\u043c"}, {"\\u0422\\u0438\\u043f \\u0441\\u043e\\u0443\\u0441\\u0430": "\\u0422\\u043e\\u043c\\u0430\\u0442\\u043d\\u044b\\u0439"}, {"\\u0422\\u043e\\u043b\\u0449\\u0438\\u043d\\u0430 \\u0442\\u0435\\u0441\\u0442\\u0430": "\\u0421\\u0440\\u0435\\u0434\\u043d\\u044f\\u044f"}]}	36	51
71	490	Роллы 'Филадельфия' (16 штук)	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0448\\u0442\\u0443\\u043a": 16}, {"\\u0421\\u043e\\u0441\\u0442\\u0430\\u0432": "\\u0420\\u0438\\u0441, \\u043b\\u043e\\u0441\\u043e\\u0441\\u044c, \\u0441\\u044b\\u0440 \\u0444\\u0438\\u043b\\u0430\\u0434\\u0435\\u043b\\u044c\\u0444\\u0438\\u044f, \\u043e\\u0433\\u0443\\u0440\\u0435\\u0446"}, {"\\u0421\\u043e\\u0443\\u0441": "\\u0412\\u0430\\u0441\\u0430\\u0431\\u0438"}]}	37	51
72	590	Роллы 'Филадельфия' (4 штуки)	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0448\\u0442\\u0443\\u043a": 4}, {"\\u0421\\u043e\\u0441\\u0442\\u0430\\u0432": "\\u0420\\u0438\\u0441, \\u043b\\u043e\\u0441\\u043e\\u0441\\u044c, \\u0441\\u044b\\u0440 \\u0444\\u0438\\u043b\\u0430\\u0434\\u0435\\u043b\\u044c\\u0444\\u0438\\u044f, \\u043e\\u0433\\u0443\\u0440\\u0435\\u0446"}, {"\\u0421\\u043e\\u0443\\u0441": "\\u0418\\u043c\\u0431\\u0438\\u0440\\u044c"}]}	37	51
73	690	Роллы 'Филадельфия' (8 штук)	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0448\\u0442\\u0443\\u043a": 8}, {"\\u0421\\u043e\\u0441\\u0442\\u0430\\u0432": "\\u0420\\u0438\\u0441, \\u043b\\u043e\\u0441\\u043e\\u0441\\u044c, \\u0441\\u044b\\u0440 \\u0444\\u0438\\u043b\\u0430\\u0434\\u0435\\u043b\\u044c\\u0444\\u0438\\u044f, \\u043e\\u0433\\u0443\\u0440\\u0435\\u0446"}, {"\\u0421\\u043e\\u0443\\u0441": "\\u0412\\u0430\\u0441\\u0430\\u0431\\u0438"}]}	37	51
74	44490	Тур 'Париж и его красоты' (стандарт)	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "7 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041e\\u0442\\u0435\\u043b\\u044c": "4 \\u0437\\u0432\\u0435\\u0437\\u0434\\u044b"}, {"\\u0415\\u0434\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u0430"}]}	38	51
75	150900	Тур 'Париж и его красоты' (VIP)	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "14 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041e\\u0442\\u0435\\u043b\\u044c": "5 \\u0437\\u0432\\u0435\\u0437\\u0434"}, {"\\u0415\\u0434\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	38	51
76	44490	Круиз 'Карибское море' (эконом)	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "7 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041a\\u0430\\u044e\\u0442\\u0430": "2 \\u0437\\u0432\\u0435\\u0437\\u0434\\u044b"}, {"\\u0415\\u0434\\u0430": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	39	51
77	100900	Круиз 'Карибское море' (стандарт)	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "7 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041a\\u0430\\u044e\\u0442\\u0430": "4 \\u0437\\u0432\\u0435\\u0437\\u0434\\u044b"}, {"\\u0415\\u0434\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	39	51
78	300900	Круиз 'Карибское море' (VIP)	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "14 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041a\\u0430\\u044e\\u0442\\u0430": "5 \\u0437\\u0432\\u0435\\u0437\\u0434"}, {"\\u0415\\u0434\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	39	51
79	4490	Техническое обслуживание (стандарт)	{"characteristics": [{"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u0440\\u0430\\u0441\\u0445\\u043e\\u0434\\u043d\\u0438\\u043a\\u043e\\u0432": "\\u041e\\u0442\\u0435\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435"}]}	40	51
80	10900	Техническое обслуживание (премиум)	{"characteristics": [{"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u0440\\u0430\\u0441\\u0445\\u043e\\u0434\\u043d\\u0438\\u043a\\u043e\\u0432": "\\u041e\\u0440\\u0438\\u0433\\u0438\\u043d\\u0430\\u043b\\u044c\\u043d\\u044b\\u0435"}]}	40	51
82	7900	Шиномонтаж (премиум)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0448\\u0438\\u043d": "\\u041b\\u0435\\u0442\\u043d\\u0438\\u0435"}, {"\\u0411\\u0430\\u043b\\u0430\\u043d\\u0441\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "Michelin"}]}	41	51
83	3490	Ремонт плит (стандарт)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u043b\\u0438\\u0442\\u044b": "\\u0413\\u0430\\u0437\\u043e\\u0432\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	42	51
84	7900	Ремонт плит (премиум)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u043b\\u0438\\u0442\\u044b": "\\u042d\\u043b\\u0435\\u043a\\u0442\\u0440\\u0438\\u0447\\u0435\\u0441\\u043a\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	42	51
85	3490	Ремонт холодильников (стандарт)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0445\\u043e\\u043b\\u043e\\u0434\\u0438\\u043b\\u044c\\u043d\\u0438\\u043a\\u0430": "\\u0413\\u0430\\u0437\\u043e\\u0432\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	43	51
86	7900	Ремонт холодильников (премиум)	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0445\\u043e\\u043b\\u043e\\u0434\\u0438\\u043b\\u044c\\u043d\\u0438\\u043a\\u0430": "\\u042d\\u043b\\u0435\\u043a\\u0442\\u0440\\u0438\\u0447\\u0435\\u0441\\u043a\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	43	51
87	290	Препарат 'Цитрамон'(стандарт)	{"characteristics": [{"\\u0424\\u043e\\u0440\\u043c\\u0430 \\u0432\\u044b\\u043f\\u0443\\u0441\\u043a\\u0430": "\\u0422\\u0430\\u0431\\u043b\\u0435\\u0442\\u043a\\u0438"}, {"\\u0414\\u043e\\u0437\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": " 500 \\u043c\\u0433 \\u0430\\u0446\\u0435\\u0442\\u0438\\u043b\\u0441\\u0430\\u043b\\u0438\\u0446\\u0438\\u043b\\u043e\\u0432\\u043e\\u0439 \\u043a\\u0438\\u0441\\u043b\\u043e\\u0442\\u044b, 250 \\u043c\\u0433 \\u043f\\u0430\\u0440\\u0430\\u0446\\u0435\\u0442\\u0430\\u043c\\u043e\\u043b\\u0430, 30 \\u043c\\u0433 \\u043a\\u043e\\u0444\\u0435\\u0438\\u043d\\u0430"}]}	44	62
88	490	Препарат 'Цитрамон' Extra	{"characteristics": [{"\\u0424\\u043e\\u0440\\u043c\\u0430 \\u0432\\u044b\\u043f\\u0443\\u0441\\u043a\\u0430": "\\u0422\\u0430\\u0431\\u043b\\u0435\\u0442\\u043a\\u0438"}, {"\\u0414\\u043e\\u0437\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": " 750 \\u043c\\u0433 \\u0430\\u0446\\u0435\\u0442\\u0438\\u043b\\u0441\\u0430\\u043b\\u0438\\u0446\\u0438\\u043b\\u043e\\u0432\\u043e\\u0439 \\u043a\\u0438\\u0441\\u043b\\u043e\\u0442\\u044b, 300 \\u043c\\u0433 \\u043f\\u0430\\u0440\\u0430\\u0446\\u0435\\u0442\\u0430\\u043c\\u043e\\u043b\\u0430, 50 \\u043c\\u0433 \\u043a\\u043e\\u0444\\u0435\\u0438\\u043d\\u0430"}]}	44	61
89	149490	Строительная компания 'Молоток'(баня)	{"characteristics": [{"\\u0421\\u0440\\u043e\\u043a\\u0438": "30 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0411\\u0440\\u0438\\u0433\\u0430\\u0434\\u0430": "5 \\u0447\\u0435\\u043b\\u043e\\u0432\\u0435\\u043a"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b": "\\u0421\\u043e\\u0431\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435"}, {"\\u0422\\u0438\\u043f": "\\u0411\\u0430\\u043d\\u044f"}]}	45	51
90	111190	Строительная компания 'Молоток'(веранда)	{"characteristics": [{"\\u0421\\u0440\\u043e\\u043a\\u0438": "14 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0411\\u0440\\u0438\\u0433\\u0430\\u0434\\u0430": "3 \\u0447\\u0435\\u043b\\u043e\\u0432\\u0435\\u043a\\u0430"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b": "\\u0421\\u043e\\u0431\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435"}, {"\\u0422\\u0438\\u043f": "\\u0412\\u0435\\u0440\\u0430\\u043d\\u0434\\u0430"}]}	45	51
92	1190	Прическа женская	{"characteristics": [{"\\u041f\\u043e\\u043b": "\\u0416\\u0435\\u043d\\u0441\\u043a\\u0438\\u0439"}, {"\\u0412\\u0438\\u0434 \\u0441\\u0442\\u0440\\u0438\\u0436\\u043a\\u0438": "\\u041e\\u043a\\u0440\\u0430\\u0448\\u0438\\u0432\\u0430\\u043d\\u0438\\u0435"}]}	46	51
94	90	Шоколад Milka молочный шоколад	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0428\\u043e\\u043a\\u043e\\u043b\\u0430\\u0434"}, {"\\u041c\\u0430\\u0440\\u043a\\u0430": "Milka"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041c\\u043e\\u043b\\u043e\\u0447\\u043d\\u044b\\u0439 \\u0448\\u043e\\u043a\\u043e\\u043b\\u0430\\u0434"}]}	47	62
95	80	Букет из красных роз	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0426\\u0432\\u0435\\u0442\\u044b"}, {"\\u0412\\u0438\\u0434": "\\u0420\\u043e\\u0437\\u044b"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041a\\u0440\\u0430\\u0441\\u043d\\u044b\\u0435"}]}	48	61
96	110	Букет из белых роз	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0426\\u0432\\u0435\\u0442\\u044b"}, {"\\u0412\\u0438\\u0434": "\\u0420\\u043e\\u0437\\u044b"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0411\\u0435\\u043b\\u044b\\u0435"}]}	48	62
97	200	Синий трактор на колесах	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0418\\u0433\\u0440\\u0443\\u0448\\u043a\\u0430"}, {"\\u041f\\u043e\\u043b": "\\u041c\\u0430\\u043b\\u044c\\u0447\\u0438\\u043a"}, {"\\u0412\\u043e\\u0437\\u0440\\u0430\\u0441\\u0442": "0+"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}]}	49	61
99	50	Молоко Домик в деревне 3,2% 1 л	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "3,2%"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c": "1 \\u043b"}]}	50	50
100	90	Молоко Домик в деревне 3,2% 2 л	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "3,2%"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c": "2 \\u043b"}]}	50	30
101	120	Молоко Домик в деревне 3,2% 3 л	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "3,2%"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c": "3 \\u043b"}]}	50	20
102	150	Сыр Российский 'Веселый молочник' 200 г	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "45%"}, {"\\u0412\\u0435\\u0441": "200 \\u0433"}]}	51	100
104	500	Сыр Российский 'Веселый молочник' 1 кг	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "45%"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	51	30
105	30	Картофель 'Ред Скарлет' 1 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0420\\u0435\\u0434 \\u0421\\u043a\\u0430\\u0440\\u043b\\u0435\\u0442'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	52	200
106	50	Картофель 'Ред Скарлет' 2 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0420\\u0435\\u0434 \\u0421\\u043a\\u0430\\u0440\\u043b\\u0435\\u0442'"}, {"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}]}	52	150
107	100	Картофель 'Ред Скарлет' 5 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0420\\u0435\\u0434 \\u0421\\u043a\\u0430\\u0440\\u043b\\u0435\\u0442'"}, {"\\u0412\\u0435\\u0441": "5 \\u043a\\u0433"}]}	52	100
108	700	Мясо говядины 'Ангус' 1 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u0413\\u043e\\u0432\\u044f\\u0434\\u0438\\u043d\\u0430"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	53	50
109	1300	Мясо говядины 'Ангус' 2 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u0413\\u043e\\u0432\\u044f\\u0434\\u0438\\u043d\\u0430"}, {"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}]}	53	30
110	2500	Мясо говядины 'Ангус' 5 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u0413\\u043e\\u0432\\u044f\\u0434\\u0438\\u043d\\u0430"}, {"\\u0412\\u0435\\u0441": "5 \\u043a\\u0433"}]}	53	20
111	100	Рис 'Басмати' 1 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u0430\\u0441\\u043c\\u0430\\u0442\\u0438'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	54	100
112	180	Рис 'Басмати' 2 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u0430\\u0441\\u043c\\u0430\\u0442\\u0438'"}, {"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}]}	54	70
113	350	Рис 'Басмати' 5 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u0430\\u0441\\u043c\\u0430\\u0442\\u0438'"}, {"\\u0412\\u0435\\u0441": "5 \\u043a\\u0433"}]}	54	50
114	50	Хлеб 'Бородинский' 1 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u043e\\u0440\\u043e\\u0434\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	55	200
115	90	Хлеб 'Бородинский' 2 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u043e\\u0440\\u043e\\u0434\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439'"}, {"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}]}	55	150
116	150	Хлеб 'Бородинский' 3 кг	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u043e\\u0440\\u043e\\u0434\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439'"}, {"\\u0412\\u0435\\u0441": "3 \\u043a\\u0433"}]}	55	100
117	150	Курица 'Домашняя' 1 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u041a\\u0443\\u0440\\u0438\\u0446\\u0430"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	56	100
118	280	Курица 'Домашняя' 2 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u041a\\u0443\\u0440\\u0438\\u0446\\u0430"}, {"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}]}	56	70
119	550	Курица 'Домашняя' 5 кг	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u041a\\u0443\\u0440\\u0438\\u0446\\u0430"}, {"\\u0412\\u0435\\u0441": "5 \\u043a\\u0433"}]}	56	50
120	500	Мед 'Алтайский' 1 кг	{"characteristics": [{"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	57	100
39	104	Обучающие лабиринты. Сложение и вычитание. 8-9 лет. Краткое	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041a\\u0440\\u0430\\u0442\\u043a\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	22	61
91	490	Прическа мужская	{"characteristics": [{"\\u041f\\u043e\\u043b": "\\u041c\\u0443\\u0436\\u0441\\u043a\\u043e\\u0439"}, {"\\u0412\\u0438\\u0434 \\u0441\\u0442\\u0440\\u0438\\u0436\\u043a\\u0438": "\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c\\u043d\\u0430\\u044f"}]}	46	47
121	59990	HP Pavilion x360 14-dh1007ur	{"characteristics": [{"\\u041f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440": "Intel Core i5-8265U"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0413\\u0411 DDR4"}, {"\\u0416\\u0435\\u0441\\u0442\\u043a\\u0438\\u0439 \\u0434\\u0438\\u0441\\u043a": "256 \\u0413\\u0411 SSD"}, {"\\u042d\\u043a\\u0440\\u0430\\u043d": "14 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432, \\u0441\\u0435\\u043d\\u0441\\u043e\\u0440\\u043d\\u044b\\u0439"}]}	58	5
122	64990	HP Pavilion x360 14-dh1008ur	{"characteristics": [{"\\u041f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440": "Intel Core i5-8265U"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0413\\u0411 DDR4"}, {"\\u0416\\u0435\\u0441\\u0442\\u043a\\u0438\\u0439 \\u0434\\u0438\\u0441\\u043a": "512 \\u0413\\u0411 SSD"}, {"\\u042d\\u043a\\u0440\\u0430\\u043d": "14 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432, \\u0441\\u0435\\u043d\\u0441\\u043e\\u0440\\u043d\\u044b\\u0439"}]}	58	3
123	69990	HP Pavilion x360 14-dh1009ur	{"characteristics": [{"\\u041f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440": "Intel Core i7-8565U"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "16 \\u0413\\u0411 DDR4"}, {"\\u0416\\u0435\\u0441\\u0442\\u043a\\u0438\\u0439 \\u0434\\u0438\\u0441\\u043a": "512 \\u0413\\u0411 SSD"}, {"\\u042d\\u043a\\u0440\\u0430\\u043d": "14 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432, \\u0441\\u0435\\u043d\\u0441\\u043e\\u0440\\u043d\\u044b\\u0439"}]}	58	2
124	99990	NVIDIA GeForce RTX 3080	{"characteristics": [{"\\u0427\\u0438\\u043f\\u0441\\u0435\\u0442": "NVIDIA GeForce RTX 3080"}, {"\\u041f\\u0430\\u043c\\u044f\\u0442\\u044c": "10 \\u0413\\u0411 GDDR6X"}, {"\\u0418\\u043d\\u0442\\u0435\\u0440\\u0444\\u0435\\u0439\\u0441": "PCI Express 4.0"}]}	59	10
127	69990	Intel Core i9-11900K	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u044f\\u0434\\u0435\\u0440": "8"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u043f\\u043e\\u0442\\u043e\\u043a\\u043e\\u0432": "16"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3.5 \\u0413\\u0413\\u0446 (4.9 \\u0413\\u0413\\u0446 \\u0432 \\u0440\\u0435\\u0436\\u0438\\u043c\\u0435 Turbo Boost)"}]}	61	8
130	19990	Samsung 970 EVO Plus 1 ТБ	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "SSD"}, {"\\u0418\\u043d\\u0442\\u0435\\u0440\\u0444\\u0435\\u0439\\u0441": "PCIe NVMe 3.0 x4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "1 \\u0422\\u0411"}]}	64	9
133	19990	Logitech G915 TKL	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043a\\u043b\\u0430\\u0432\\u0438\\u0430\\u0442\\u0443\\u0440\\u044b": "\\u041c\\u0435\\u0445\\u0430\\u043d\\u0438\\u0447\\u0435\\u0441\\u043a\\u0430\\u044f"}, {"\\u0422\\u0435\\u0445\\u043d\\u043e\\u043b\\u043e\\u0433\\u0438\\u044f \\u043a\\u043b\\u0430\\u0432\\u0438\\u0448": "GL Tactile"}, {"\\u041f\\u043e\\u0434\\u0441\\u0432\\u0435\\u0442\\u043a\\u0430 \\u043a\\u043b\\u0430\\u0432\\u0438\\u0448": "RGB"}]}	66	5
134	5000	Kingston HyperX Fury DDR4 16GB	{"characteristics": [{"\\u0422\\u0438\\u043f": "DDR4"}]}	67	15
137	80000	ASUS ROG Zephyrus M16 (Intel Core i7-11800H, 16ГБ RAM, 512ГБ SSD)	{"characteristics": [{"\\u042d\\u043a\\u0440\\u0430\\u043d": "16 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}]}	68	12
125	19990	Corsair Vengeance LPX 32 ГБ (2 x 16 ГБ) DDR4 3200 МГц	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "DDR4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "32 \\u0413\\u0411 (2 x 16 \\u0413\\u0411)"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3200 \\u041c\\u0413\\u0446"}]}	60	7
128	49990	Dell UltraSharp U2720Q	{"characteristics": [{"\\u0414\\u0438\\u0430\\u0433\\u043e\\u043d\\u0430\\u043b\\u044c \\u044d\\u043a\\u0440\\u0430\\u043d\\u0430": "27 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}, {"\\u0420\\u0430\\u0437\\u0440\\u0435\\u0448\\u0435\\u043d\\u0438\\u0435 \\u044d\\u043a\\u0440\\u0430\\u043d\\u0430": "3840 x 2160 \\u043f\\u0438\\u043a\\u0441\\u0435\\u043b\\u0435\\u0439"}, {"\\u0426\\u0432\\u0435\\u0442\\u043e\\u0432\\u043e\\u0439 \\u043e\\u0445\\u0432\\u0430\\u0442": "99% sRGB, 99% Rec. 709, 95% DCI-P3"}]}	62	6
131	9990	Samsung 970 EVO Plus 500 ГБ	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "SSD"}, {"\\u0418\\u043d\\u0442\\u0435\\u0440\\u0444\\u0435\\u0439\\u0441": "PCIe NVMe 3.0 x4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "500 \\u0413\\u0411"}]}	64	11
136	6000	Kingston HyperX Fury DDR4 16GB (RGB)	{"characteristics": [{"\\u0422\\u0438\\u043f": "DDR4"}]}	67	5
139	90000	ASUS ROG Zephyrus M16 (Intel Core i9-11980H, 32ГБ RAM, 2ТБ SSD)	{"characteristics": [{"\\u042d\\u043a\\u0440\\u0430\\u043d": "16 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}]}	68	10
126	34990	Corsair Vengeance LPX 64 ГБ (4 x 16 ГБ) DDR4 3200 МГц	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "DDR4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "64 \\u0413\\u0411 (4 x 16 \\u0413\\u0411)"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3200 \\u041c\\u0413\\u0446"}]}	60	3
129	29990	ASUS RT-AX88U	{"characteristics": [{"\\u0421\\u0442\\u0430\\u043d\\u0434\\u0430\\u0440\\u0442 Wi-Fi": "Wi-Fi 6 (802.11ax)"}, {"\\u0421\\u043a\\u043e\\u0440\\u043e\\u0441\\u0442\\u044c Wi-Fi": "6000 \\u041c\\u0431\\u0438\\u0442/\\u0441"}, {"\\u041f\\u043e\\u0440\\u0442\\u044b Ethernet": "8 x 1 \\u0413\\u0431\\u0438\\u0442/\\u0441"}]}	63	4
132	29990	Sony WH-1000XM4	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043d\\u0430\\u0443\\u0448\\u043d\\u0438\\u043a\\u043e\\u0432": "Bluetooth"}, {"\\u0422\\u0435\\u0445\\u043d\\u043e\\u043b\\u043e\\u0433\\u0438\\u044f \\u0448\\u0443\\u043c\\u043e\\u043f\\u043e\\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f": "Sony HD Noise Cancelling Processor QN1"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u043d\\u044b\\u0439 \\u0434\\u0438\\u0430\\u043f\\u0430\\u0437\\u043e\\u043d": "4 \\u0413\\u0446 - 40 \\u043a\\u0413\\u0446"}]}	65	8
135	5500	Kingston HyperX Fury DDR4 16GB (2x8GB)	{"characteristics": [{"\\u0422\\u0438\\u043f": "DDR4"}]}	67	10
138	85000	ASUS ROG Zephyrus M16 (Intel Core i7-11800H, 32ГБ RAM, 1ТБ SSD)	{"characteristics": [{"\\u042d\\u043a\\u0440\\u0430\\u043d": "16 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}]}	68	8
\.


--
-- TOC entry 3574 (class 0 OID 16448)
-- Dependencies: 232
-- Data for Name: product_tag_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tag_links (product_id, tag_id) FROM stdin;
5	30
5	31
5	32
8	33
8	34
8	35
9	36
9	37
9	38
10	39
10	37
10	40
11	37
11	41
14	43
14	44
14	45
15	46
15	47
15	48
16	46
16	49
16	50
17	51
17	52
17	53
18	51
18	54
18	55
19	51
19	56
19	57
20	58
20	59
21	58
21	60
22	58
22	61
22	62
23	63
23	64
23	65
24	63
24	66
24	65
25	67
25	52
26	67
26	68
27	69
27	70
27	71
28	69
28	72
28	73
29	74
29	75
29	76
30	74
30	77
31	74
31	78
32	79
32	80
32	81
33	82
33	83
33	84
34	85
34	86
34	87
35	88
35	89
36	90
36	91
36	92
37	93
37	94
37	95
38	18
38	96
38	97
39	18
39	98
39	99
40	100
40	101
40	102
41	100
41	103
41	102
42	107
42	108
42	101
43	107
43	109
43	101
44	110
44	111
44	112
45	15
45	52
46	113
46	114
47	115
47	116
48	117
48	118
49	119
49	120
50	173
50	174
50	175
51	176
51	174
51	177
52	178
52	174
52	179
53	180
53	174
53	181
54	182
54	174
54	183
55	184
55	174
55	185
56	180
56	174
56	186
57	187
57	174
57	188
58	47
58	189
58	190
59	191
59	192
59	193
59	194
60	195
60	196
61	197
61	198
61	193
62	199
62	200
62	201
63	202
63	203
63	204
64	205
64	206
65	207
65	208
65	209
66	210
66	211
66	193
67	195
67	124
67	212
68	213
68	124
68	203
68	214
\.


--
-- TOC entry 3575 (class 0 OID 16451)
-- Dependencies: 233
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, created_at, preview_img, details, store_id, is_service) FROM stdin;
5	Кроссовки Nike Air Max 270	Кроссовки с уникальной воздушной подушкой для максимального комфорта при беге и занятиях спортом. Изготовлены из дышащего материала, что обеспечивает надежную вентиляцию стопы	2023-09-17 04:01:27.229892	https://ir.ozone.ru/s3/multimedia-r/wc750/6640766235.jpg	{"characteristics": [{"\\u0421\\u0435\\u0440\\u0438\\u044f \\u0432 \\u043e\\u0434\\u0435\\u0436\\u0434\\u0435 \\u0438 \\u043e\\u0431\\u0443\\u0432\\u0438": "Air Monarch IV"}, {"\\u0421\\u0435\\u0437\\u043e\\u043d": "\\u0414\\u0435\\u043c\\u0438\\u0441\\u0435\\u0437\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0411\\u0435\\u043b\\u044b\\u0439, \\u0441\\u0435\\u0440\\u044b\\u0439"}]}	6	f
8	Горный Велосипед Scott Scale 970 29'' 2023 dark grey (L), 29, 2023	Прочный и легкий велосипед для активного катания по бездорожью. Имеет жесткую раму из алюминия, вилку с ходом 100 мм и надежные дисковые тормоза	2023-09-17 08:58:07.975097	https://ir.ozone.ru/s3/multimedia-l/wc700/6749144193.jpg	{"characteristics": [{"\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c\\u043d\\u044b\\u0439 \\u0433\\u043e\\u0434": "2023"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u043e\\u0431\\u043e\\u0434\\u0430": "\\u0410\\u043b\\u044e\\u043c\\u0438\\u043d\\u0438\\u0435\\u0432\\u044b\\u0439 \\u0441\\u043f\\u043b\\u0430\\u0432"}, {"\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u043a\\u043e\\u043b\\u0435\\u0441, \\u0434\\u044e\\u0439\\u043c\\u044b": "29"}]}	6	f
9	Лыжи Fischer RCS Carbonlite Skate Plus	Профессиональные лыжи для катания на коньках с ультралегкой конструкцией и уникальными технологиями для максимальной скорости и маневренности.	2023-09-18 10:34:17.193196	https://www.fischersports.com/ru_ru/rcs-carbonlite-skate-plus-1564	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "180 \\u0441\\u043c"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041f\\u043b\\u0430\\u0441\\u0442\\u043c\\u0430\\u0441\\u0441\\u0430"}]}	6	f
10	Гантели Reebok Rubber Hex Dumbbells	Набор гантелей с покрытием из резины для защиты пола и удобства захвата. Включает гантели разного веса от 2 до 20 кг.	2023-09-18 10:34:19.313947	https://assets.reebok.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy/0a3b8d6e2f7a4d2c8d1aa8a600f5a96c_9366/Ganteli_Reebok_Rubber_Hex_Dumbbells_Silver_DV9459_01_standard.jpg	{"characteristics": [{"\\u0412\\u0435\\u0441": "2 \\u043a\\u0433"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0420\\u0435\\u0437\\u0438\\u043d\\u0430"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 2}]}	6	f
11	Штанга Champion Power Bar	Профессиональная штанга для тренировок с грифом диаметром 28 мм и нагрузкой до 1000 фунтов. Изготовлена из высокопрочной стали и имеет удобные ручки для захвата.	2023-09-18 10:34:21.429558	https://www.championbarbell.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/1/1/1156_1.jpg	{"characteristics": [{"\\u0414\\u043b\\u0438\\u043d\\u0430": "2 \\u043c"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0410\\u043b\\u044e\\u043c\\u0438\\u043d\\u0438\\u0439"}, {"\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u0433\\u0440\\u0438\\u0444\\u0430": "25 \\u043c\\u043c"}, {"\\u0412\\u0435\\u0441 \\u0433\\u0440\\u0438\\u0444\\u0430": "5 \\u043a\\u0433"}]}	6	f
14	Xiaomi Redmi Note 12S 8	Redmi Note 12S.Ключевые преимущества:108 Мп, камера профессионального уровня: Ультраширокоугольный и макро объективы.90 Гц AMOLED дисплей: Два динамика.33 Вт быстрая зарядка: 5000 мАч (тип.) аккумулятор.Производительный процессор MediaTek Helio G96: Большой объём постоянной памяти.	2023-09-18 11:10:26.710021	https://ir.ozone.ru/s3/multimedia-f/wc1000/6642131703.jpg	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0417\\u0435\\u043b\\u0435\\u043d\\u044b\\u0439"}, {"\\u0412\\u043d\\u0443\\u0442\\u0440\\u0435\\u043d\\u043d\\u044f\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "256 \\u0433\\u0431"}]}	1	f
15	Ноутбук F+ FLAPTOP R-series AMD Ryzen 3	Ноутбук FLTP-5R7-16512-W — создан для активной жизни. Тонкий алюминиевый с внушительным содержимым.С F+ FLAPTOP R вам не придется выбирать, потому что модель сочетает в себе впечатляющую эффективность работы и стильный компактный корпус.	2023-09-18 11:10:28.854467	https://ir.ozone.ru/s3/multimedia-t/wc1000/6696740153.jpg	{"characteristics": [{"\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c \\u043f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440\\u0430": "AMD Ryzen 3"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0433\\u0431"}, {"\\u041e\\u0431\\u0449\\u0438\\u0439 \\u043e\\u0431\\u044a\\u0451\\u043c    ": "256 \\u0433\\u0431"}]}	1	f
16	TechnoGrand Smart Watch x7 pro	Смарт часы X7 PRO Series 7 являются новинкой с улучшенным динамиком и более быстрым процессором. Отзывчивый сенсор и качественная синхронизация со смартфонами на платформах Android или iOS с помощью Bluetooth 5.2 порадуют своей точностью и стабильным соединением.	2023-09-18 11:10:30.965359	https://ir.ozone.ru/s3/multimedia-6/wc1000/6671499342.jpg	{"characteristics": [{"\\u0426\\u0432\\u0435\\u0442": "\\u0420\\u043e\\u0437\\u043e\\u0432\\u044b\\u0439"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u041a\\u0438\\u0442\\u0430\\u0439"}]}	1	f
18	Тряпка из микрофибры и замши для автомобиля	Универсальная тряпка для влажной и сухой уборки станет для Вас прекрасным помощником. Микрофибра и замша не оставляет за собой следы от ворсинок, не оставляет разводов и микроцарапин	2023-09-18 11:34:45.119425	https://ir.ozone.ru/s3/multimedia-j/wc1000/6731906815.jpg	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "30*40"}, {"\\u0415\\u0434\\u0438\\u043d\\u0438\\u0446 \\u0432 \\u043e\\u0434\\u043d\\u043e\\u043c \\u043d\\u0430\\u0431\\u043e\\u0440\\u0435": 1}]}	2	f
19	Подбор запчастей	Добросовестный подбор автозапчастей по важным критериям	2023-09-18 11:34:47.244958	https://avatars.mds.yandex.net/i?id=6035ab181ab02aa4867d4aedd02e592fd890a416-9198173-images-thumbs&n=13	{"characteristics": [{"\\u0412\\u0440\\u0435\\u043c\\u044f": "3 \\u0434\\u043d\\u044f"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}]}	2	t
17	Ремонтный полупорог левый на Toyota Corolla E120 E130 2000-2007	Хорошие пороги	2023-09-18 11:34:43.023251	https://ir.ozone.ru/s3/multimedia-2/wc1000/6653545346.jpg	{"characteristics": [{"\\u041e\\u0431\\u044a\\u0451\\u043c": "0.8 \\u043b"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u041e\\u0446\\u0438\\u043d\\u043a\\u043e\\u0432\\u0430\\u043d\\u043d\\u0430\\u044f \\u0441\\u0442\\u0430\\u043b\\u044c"}, {"\\u0421\\u0442\\u043e\\u0440\\u043e\\u043d\\u0430": "\\u041b\\u0435\\u0432\\u044b\\u0439"}]}	2	f
20	Английский язык. Контрольные задания. 7 класс. ФГОС / Английский в фокусе. Spotlight / Просвещение	Сборник контрольных заданий является компонентом учебно-методического комплекта по английскому языку серии «Английский в фокусе» для учащихся 7 класса общеобразовательных организаций. Он включает 10 контрольных заданий в двух экземплярах, которые выполняются по завершении работы над каждым модулем. Сборник обеспечивает процесс контроля на регулярной и объективной основе.	2023-09-18 11:38:47.622797	https://ir.ozone.ru/s3/multimedia-8/wc1000/6632239544.jpg	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u0442\\u0435\\u043b\\u044c\\u0441\\u0442\\u0432\\u043e": "\\u041f\\u0440\\u043e\\u0441\\u0432\\u0435\\u0449\\u0435\\u043d\\u0438\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	3	f
21	На одной волне со Вселенной. Живая психология и немножечко чудес. О тебе, об отношениях и о том, как прекратить играть в прятки со счастьем.Краткое	«На одной волне со Вселенной» – книга, из которой вы узнаете:\n- какие действия нужно исключить из своей жизни, чтобы Вселенная начала оказывать тебе поддержку;\n- как перестать болеть душой и научиться прощать себя за ошибки;\n- как притянуть в жизнь любовь, успех и вдохновение;\n- как ослабить хватку и впустить волшебные перемены.	2023-09-18 11:38:49.737748	https://ir.ozone.ru/s3/multimedia-b/wc1000/6531699275.jpg	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041a\\u0440\\u0430\\u0442\\u043a\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	3	f
22	Обучающие лабиринты. Сложение и вычитание. 8-9 лет. Краткое	Прохождение лабиринтов - это увлекательное занятие, которое требует внимания, сосредоточенности и твёрдой руки. Но наши лабиринты ещё и обучающие. Найди верный путь, а затем выполни задание: разгадай загадку, собери буквы или сделай по порядку вычисления - и ты обязательно узнаешь что-то новое и интересное. Желаем увлекательного обучения!	2023-09-18 11:38:51.811752	https://ir.ozone.ru/s3/multimedia-p/wc1000/6757731745.jpg	{"characteristics": [{"\\u0418\\u0437\\u0434\\u0430\\u043d\\u0438\\u0435": "\\u041a\\u0440\\u0430\\u0442\\u043a\\u043e\\u0435"}, {"\\u0422\\u0438\\u043f \\u043a\\u043d\\u0438\\u0433\\u0438": "\\u041f\\u0435\\u0447\\u0430\\u0442\\u043d\\u0430\\u044f \\u043a\\u043d\\u0438\\u0433\\u0430"}]}	3	f
23	Крестик Серебро 925 Золочение Распятие Молитва Да воскреснет Бог 	Крестик Православный Распятие Христово Молитва на обороте  'Да воскреснет Бог, и расточатся врази Его, и да бежат от лица Его ненавидящии Его ' Металл: Серебро 925 пробы, с Частичной Позолотой, Родирование ( Позолота - 2 слоя Золота 750 и 990 пробы, по 3 мкр. каждый,  т.е. общая толщина Позолоты 6 мкр. ) 	2023-09-18 11:40:15.25509	https://ir.ozone.ru/s3/multimedia-7/wc1000/6530884555.jpg	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043f\\u043e\\u0437\\u043e\\u043b\\u043e\\u0447\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "23 \\u0445 46 \\u043c\\u043c"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "5 \\u0433\\u0440."}]}	4	f
24	Подвеска Амулет Оберег Зеркало МАЛЕНЬКАЯ Серебро 925 с Золочением Магазин ЖюТе 925	Данный Амулет в виде зеркала помогает владельцу впитывать положительную энергию из окружающего мира и в то же время это двустороннее зеркальце будет отражать зло, ворожбу и наговоры от своего хозяина.	2023-09-18 11:40:17.33994	https://ir.ozone.ru/s3/multimedia-7/wc1000/6683855911.jpg	{"characteristics": [{"\\u041e\\u0441\\u043d\\u043e\\u0432\\u043d\\u043e\\u0439 \\u043c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b \\u0443\\u043a\\u0440\\u0430\\u0448\\u0435\\u043d\\u0438\\u044f:": "\\u0421\\u0435\\u0440\\u0435\\u0431\\u0440\\u043e \\u043f\\u043e\\u0437\\u043e\\u043b\\u043e\\u0447\\u0435\\u043d\\u043d\\u043e\\u0435"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "\\u0414\\u0438\\u0430\\u043c\\u0435\\u0442\\u0440 \\u041f\\u043e\\u0434\\u0432\\u0435\\u0441\\u043a\\u0438 14 \\u043c\\u043c + \\u0423\\u0448\\u043a\\u043e"}, {"\\u0421\\u0440\\u0435\\u0434\\u043d\\u0438\\u0439 \\u0432\\u0435\\u0441": "1 \\u0433\\u0440."}]}	4	f
25	Ремонт одежды. Штаны	Производится ремонт одежды	2023-09-18 11:42:15.823663	https://avatars.mds.yandex.net/i?id=070b5a803d280d3dc7385574cf45932b756173cc-10355098-images-thumbs&n=13	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041a\\u043e\\u0436\\u0430"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u0428\\u0442\\u0430\\u043d\\u044b"}]}	5	t
26	Пошив одежды. Куркта 	Производится пошив одежды	2023-09-18 11:42:17.90582	https://avatars.mds.yandex.net/i?id=e6a8ec2d0ddb53dd8e06881d76a4a519f786fd55-8474988-images-thumbs&n=13	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041a\\u043e\\u0436\\u0430"}, {"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u043e\\u0434\\u0435\\u0436\\u0434\\u044b": "\\u041a\\u0443\\u0440\\u0442\\u043a\\u0430"}]}	5	t
27	Сдача анализов. Кровь 	Сбор крови для проведения анализа	2023-09-18 11:45:04.520989	https://avatars.mds.yandex.net/i?id=c198b301f31545ffeef6a123dd51978dd202a642-9151021-images-thumbs&n=13	{"characteristics": [{"\\u041e\\u0431\\u043e\\u0440\\u0443\\u0434\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435": "\\u0418\\u043c\\u043f\\u043e\\u0440\\u0442\\u043d\\u043e\\u0435"}, {"\\u0413\\u043e\\u0442\\u043e\\u0432\\u043d\\u043e\\u0441\\u0442\\u044c \\u0440\\u0435\\u0437\\u0443\\u043b\\u044c\\u0442\\u0430\\u0442\\u0430": "\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0435"}, {"\\u041f\\u043e\\u043b\\u043d\\u043e\\u0442\\u0430 \\u0440\\u0430\\u0437\\u0431\\u043e\\u0440\\u0430": "\\u041f\\u043e\\u043b\\u043d\\u044b\\u0439"}]}	7	t
28	Приём у терапевта 	Консультация у врача-терапевта	2023-09-18 11:45:06.63911	https://avatars.mds.yandex.net/i?id=ddcc4d71b992e8d4df607b49a0b25fdef4ddc4bf-9844469-images-thumbs&n=13	{"characteristics": [{"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430 \\u043a\\u043e\\u043d\\u0441\\u0443\\u043b\\u044c\\u0442\\u0430\\u0446\\u0438\\u0438": "\\u041f\\u043e\\u043b\\u043d\\u0430\\u044f"}, {"\\u0414\\u0430\\u043b\\u044c\\u043d\\u0435\\u0439\\u0448\\u0435\\u0435 \\u043d\\u0430\\u043f\\u0440\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u0435": "\\u0412\\u044b\\u043f\\u0438\\u0441\\u044b\\u0432\\u0430\\u0435\\u0442\\u0441\\u044f"}]}	7	t
29	Матрас ASKONA Forma Акция серия Balance, Независимые пружины, 120х200 см 	Надежный и комфортный ортопедический матрас Askona Balance FORMA Акция - это супер-бестселлер среди всех моделей серии Balance. Тысячи покупателей покупают именно его за потрясающее соотношение цена-качество-комфорт.	2023-09-18 11:46:56.107879	https://ir.ozone.ru/s3/multimedia-t/wc1000/6549182801.jpg	{"characteristics": [{"\\u0428\\u0438\\u0440\\u0438\\u043d\\u0430": 120}, {"\\u0414\\u043b\\u0438\\u043d\\u0430": 200}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 19}]}	8	f
30	Обувница для прихожей, этажерка для обуви 3 яруса	Обувница является важной составляющей интерьера прихожей. Такая прихожая мебель не только создает уют, но и значительно повышает комфорт. Конструкция этажерки для обуви позволяет обуви быстрее сохнуть и проветриваться. Также обувница в прихожую оборудована пластиковыми колпачками на ножках, препятствующими скольжению и повреждению пола. Компактная этажерка  79×36×33 см легко поместится в прихожую, гардеробную, коридор или балкон. Неприхотлива в уходе!	2023-09-18 11:46:58.209866	https://ir.ozone.ru/s3/multimedia-0/wc1000/6656229252.jpg	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u041d\\u043e\\u0432\\u043e\\u0435"}, {"\\u0412\\u044b\\u0441\\u043e\\u0442\\u0430": 70}, {"\\u0413\\u043b\\u0443\\u0431\\u0438\\u043d\\u0430": 35}]}	8	f
31	Комплект стульев _SOKOLTEC_HW900_, 4 шт. Белый.	Кухонные стулья SOKOLTEC выполнены в лаконичном стиле, крайне популярном сегодня. Стул кресло с высокой спинкой и широким сиденьем обеспечивает удобную посадку на протяжении долгого времени. Мягкий стул флекс открытый, без ограничений, что позволяет комфортно устроиться человеку с любым телосложением. Изготовлен из высококачественного, практичного и легкого в уходе пластика; ножки из дерева + металлический каркас. Данная модель стульев универсальна -  подойдет под разные интерьеры: лофт, скандинавский стиль, модерн, хай-тек, классический или современный.	2023-09-18 11:47:00.322649	https://ir.ozone.ru/s3/multimedia-2/wc1000/6273982718.jpg	{"characteristics": [{"\\u0421\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u0435": "\\u041d\\u043e\\u0432\\u043e\\u0435"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0411\\u0435\\u043b\\u044b\\u0439"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0432 \\u043a\\u043e\\u043c\\u043b\\u0435\\u043a\\u0442\\u0435": 4}]}	8	f
32	Платье 'Вечерний шик'.S	Элегантное вечернее платье с открытой спиной и пышной юбкой.	2023-09-18 11:59:29.900533	https://avatars.mds.yandex.net/i?id=73eb683b262d186c30b14f93794d348b6ff07556-9042386-images-thumbs&n=13	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0428\\u0438\\u0444\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0427\\u0451\\u0440\\u043d\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "S"}]}	9	f
33	Куртка 'Спортивный стиль'. Синий S	Стильная куртка с капюшоном и удобными карманами.	2023-09-18 11:59:32.021525	https://photo.7ya.ru/ph/2017/11/13/1510533077408.jpg	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u041d\\u0435\\u0439\\u043b\\u043e\\u043d"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "S"}]}	9	f
34	Сумка 'Городская жизнь'. Искусственная кожа коричневый	Стильная куртка с капюшоном и удобными карманами.	2023-09-18 11:59:34.100043	https://photo.7ya.ru/ph/2017/11/13/1510533077408.jpg	{"characteristics": [{"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b": "\\u0418\\u0441\\u043a\\u0443\\u0441\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u0430\\u044f \\u043a\\u043e\\u0436\\u0430"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u041a\\u043e\\u0440\\u0438\\u0447\\u043d\\u0435\\u0432\\u044b\\u0439"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "One Size"}]}	9	f
35	Сфотографировать для фото.	Профессиональная фотография.	2023-09-18 12:00:54.445782	https://avatars.mds.yandex.net/i?id=206daa8f1965599d996e521732bb4d5469d49f6d-9066790-images-thumbs&n=13	{"characteristics": [{"\\u042d\\u0444\\u0444\\u0435\\u043a\\u0442\\u044b": "\\u0423\\u043b\\u0443\\u0447\\u0448\\u0435\\u043d\\u0438\\u0435 \\u043b\\u0438\\u0446\\u0430"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0444\\u043e\\u0442\\u043e": "4"}, {"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "3x4"}]}	11	t
36	Пицца 'Маргарита'(30 см)	Классическая и всеми любимая пицца с сочными томатами, ароматным базиликом и сыром моцарелла.	2023-09-18 12:01:58.245879	https://avatars.mds.yandex.net/i?id=521e9903ca7bff5d71606d9606a966447ccd637a-10310233-images-thumbs&n=13	{"characteristics": [{"\\u0420\\u0430\\u0437\\u043c\\u0435\\u0440": "30 \\u0441\\u043c"}, {"\\u0422\\u0438\\u043f \\u0441\\u043e\\u0443\\u0441\\u0430": "\\u0422\\u043e\\u043c\\u0430\\u0442\\u043d\\u044b\\u0439"}, {"\\u0422\\u043e\\u043b\\u0449\\u0438\\u043d\\u0430 \\u0442\\u0435\\u0441\\u0442\\u0430": "\\u0421\\u0440\\u0435\\u0434\\u043d\\u044f\\u044f"}]}	12	t
37	Роллы 'Филадельфия' (8 штук)	Изысканные роллы с лососем, сыром филадельфия и огурцом, приготовленные по классическому рецепту.	2023-09-18 12:02:00.386002	https://avatars.mds.yandex.net/i?id=0046824db742b9b359e000a0ea61a912ad8d62e5-10299502-images-thumbs&n=13	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u0448\\u0442\\u0443\\u043a": 8}, {"\\u0421\\u043e\\u0441\\u0442\\u0430\\u0432": "\\u0420\\u0438\\u0441, \\u043b\\u043e\\u0441\\u043e\\u0441\\u044c, \\u0441\\u044b\\u0440 \\u0444\\u0438\\u043b\\u0430\\u0434\\u0435\\u043b\\u044c\\u0444\\u0438\\u044f, \\u043e\\u0433\\u0443\\u0440\\u0435\\u0446"}, {"\\u0421\\u043e\\u0443\\u0441": "\\u0412\\u0430\\u0441\\u0430\\u0431\\u0438"}]}	12	t
38	Тур 'Париж и его красоты' (стандарт)	Незабываемое путешествие в романтический город Париж, где вы сможете насладиться видами Эйфелевой башни, прогуляться по улицам Монмартра, посетить Лувр и другие известные достопримечательности.	2023-09-18 12:03:17.875376	https://avatars.mds.yandex.net/i?id=5b7b3c0d84e22dcfaf1c8b5cf507acd85533ee46-7675486-images-thumbs&n=13	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "7 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u044b"}, {"\\u041e\\u0442\\u0435\\u043b\\u044c": "4 \\u0437\\u0432\\u0435\\u0437\\u0434\\u044b"}, {"\\u0415\\u0434\\u0430": "\\u0412\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u0430"}]}	10	t
39	Круиз 'Карибское море' (эконом)	Уникальная возможность отправиться в путешествие по прекрасным островам Карибского моря, насладиться белоснежными пляжами, кристально чистой водой и живописными закатами.	2023-09-18 12:03:20.007047	https://avatars.mds.yandex.net/i?id=3efe05bbf94c74477293b8863bc1b032606e3ac6-9221695-images-thumbs&n=13	{"characteristics": [{"\\u0414\\u043b\\u0438\\u0442\\u0435\\u043b\\u044c\\u043d\\u043e\\u0441\\u0442\\u044c": "7 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0410\\u0432\\u0438\\u0430\\u0431\\u0438\\u043b\\u0435\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041a\\u0430\\u044e\\u0442\\u0430": "2 \\u0437\\u0432\\u0435\\u0437\\u0434\\u044b"}, {"\\u0415\\u0434\\u0430": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	10	t
40	Техническое обслуживание (стандарт)	Полное техническое обслуживание вашего автомобиля, включающее замену фильтров, проверку системы охлаждения, диагностику и другие необходимые работы.	2023-09-18 12:04:52.832017	https://avatars.mds.yandex.net/i?id=57427ad2318c1194f199bb4f0946e4728592a738-9461391-images-thumbs&n=13	{"characteristics": [{"\\u0421\\u0440\\u043e\\u0447\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041d\\u0435 \\u0441\\u0440\\u043e\\u0447\\u043d\\u043e"}, {"\\u0422\\u0438\\u043f \\u0440\\u0430\\u0441\\u0445\\u043e\\u0434\\u043d\\u0438\\u043a\\u043e\\u0432": "\\u041e\\u0442\\u0435\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435"}]}	13	t
41	Шиномонтаж (стандарт)	Качественный шиномонтаж для вашего автомобиля, включающий снятие и установку колес, балансировку и проверку давления.	2023-09-18 12:04:54.977595	https://avatars.mds.yandex.net/i?id=2a0000018a9cb9972f3b2bcdf598b5b1de22-987198-fast-images&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0448\\u0438\\u043d": "\\u041b\\u0435\\u0442\\u043d\\u0438\\u0435"}, {"\\u0411\\u0430\\u043b\\u0430\\u043d\\u0441\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041f\\u0440\\u043e\\u0438\\u0437\\u0432\\u043e\\u0434\\u0438\\u0442\\u0435\\u043b\\u044c": "\\u041e\\u0442\\u0435\\u0447\\u0435\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0439"}]}	13	t
42	Ремонт плит (стандарт)	 Качественный ремонт плит различных марок и моделей, включающий диагностику, замену деталей и настройку работы.	2023-09-18 12:10:09.354964	https://avatars.mds.yandex.net/i?id=5e852b470da77cdb948d0aa91b307230f9d556d5-8819334-images-thumbs&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u043b\\u0438\\u0442\\u044b": "\\u0413\\u0430\\u0437\\u043e\\u0432\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	14	t
43	Ремонт холодильников (стандарт)	 Качественный ремонт плит различных марок и моделей, включающий диагностику, замену деталей и настройку работы.	2023-09-18 12:10:11.507844	https://avatars.mds.yandex.net/i?id=d3d14e97254e12c51bdc78ded8ec8423874a6e85-9145401-images-thumbs&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u0445\\u043e\\u043b\\u043e\\u0434\\u0438\\u043b\\u044c\\u043d\\u0438\\u043a\\u0430": "\\u0413\\u0430\\u0437\\u043e\\u0432\\u0430\\u044f"}, {"\\u0412\\u044b\\u0432\\u043e\\u0437": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}, {"\\u041d\\u0430\\u0441\\u0442\\u0440\\u043e\\u0439\\u043a\\u0430 \\u0440\\u0430\\u0431\\u043e\\u0442\\u044b": "\\u041d\\u0435 \\u0432\\u043a\\u043b\\u044e\\u0447\\u0435\\u043d\\u043e"}]}	14	t
44	Препарат 'Цитрамон'(стандарт)	Комбинированный препарат для снятия головной боли, содержащий активные вещества ацетилсалициловую кислоту, парацетамол и кофеин.	2023-09-18 12:11:49.924771	https://avatars.mds.yandex.net/i?id=6187b80773a45903f36720f288aedb3df4def5a2-9845623-images-thumbs&n=13	{"characteristics": [{"\\u0424\\u043e\\u0440\\u043c\\u0430 \\u0432\\u044b\\u043f\\u0443\\u0441\\u043a\\u0430": "\\u0422\\u0430\\u0431\\u043b\\u0435\\u0442\\u043a\\u0438"}, {"\\u0414\\u043e\\u0437\\u0438\\u0440\\u043e\\u0432\\u043a\\u0430": " 500 \\u043c\\u0433 \\u0430\\u0446\\u0435\\u0442\\u0438\\u043b\\u0441\\u0430\\u043b\\u0438\\u0446\\u0438\\u043b\\u043e\\u0432\\u043e\\u0439 \\u043a\\u0438\\u0441\\u043b\\u043e\\u0442\\u044b, 250 \\u043c\\u0433 \\u043f\\u0430\\u0440\\u0430\\u0446\\u0435\\u0442\\u0430\\u043c\\u043e\\u043b\\u0430, 30 \\u043c\\u0433 \\u043a\\u043e\\u0444\\u0435\\u0438\\u043d\\u0430"}]}	15	f
45	Строительная компания 'Молоток'(баня)	Качественная постройка строений	2023-09-18 12:12:54.348683	https://avatars.mds.yandex.net/i?id=c46f8d809034e0cc69f81d336a27f404a9ae4d6b-9043236-images-thumbs&n=13	{"characteristics": [{"\\u0421\\u0440\\u043e\\u043a\\u0438": "30 \\u0434\\u043d\\u0435\\u0439"}, {"\\u0411\\u0440\\u0438\\u0433\\u0430\\u0434\\u0430": "5 \\u0447\\u0435\\u043b\\u043e\\u0432\\u0435\\u043a"}, {"\\u041c\\u0430\\u0442\\u0435\\u0440\\u0438\\u0430\\u043b\\u044b": "\\u0421\\u043e\\u0431\\u0441\\u0442\\u0432\\u0435\\u043d\\u043d\\u044b\\u0435"}, {"\\u0422\\u0438\\u043f": "\\u0411\\u0430\\u043d\\u044f"}]}	16	t
46	Прическа мужская	Стрижка мужчин любой сложности	2023-09-18 12:13:26.564157	https://avatars.mds.yandex.net/i?id=b4689b31c4073e5804d1bc79bd9f3677c595ee47-9265516-images-thumbs&n=13	{"characteristics": [{"\\u041f\\u043e\\u043b": "\\u041c\\u0443\\u0436\\u0441\\u043a\\u043e\\u0439"}, {"\\u0412\\u0438\\u0434 \\u0441\\u0442\\u0440\\u0438\\u0436\\u043a\\u0438": "\\u041c\\u043e\\u0434\\u0435\\u043b\\u044c\\u043d\\u0430\\u044f"}]}	17	t
47	Шоколад Alpen Gold с фундуком	Плитка шоколада со вкусом фундука	2023-09-18 12:14:27.291025	https://avatars.mds.yandex.net/i?id=e7fcd7ce164f974d78665f88e4bedaa994cc1a16-9857422-images-thumbs&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0428\\u043e\\u043a\\u043e\\u043b\\u0430\\u0434"}, {"\\u041c\\u0430\\u0440\\u043a\\u0430": "Alpen Gold"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u0424\\u0443\\u043d\\u0434\\u0443\\u043a"}]}	18	f
48	Букет из красных роз	Шикарный букет из красных роз	2023-09-18 12:14:53.150738	https://avatars.mds.yandex.net/i?id=2e01b63feb77711e39b5cb1f02954c1967409eca-8439108-images-thumbs&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0426\\u0432\\u0435\\u0442\\u044b"}, {"\\u0412\\u0438\\u0434": "\\u0420\\u043e\\u0437\\u044b"}, {"\\u0420\\u0430\\u0437\\u043d\\u043e\\u0432\\u0438\\u0434\\u043d\\u043e\\u0441\\u0442\\u044c": "\\u041a\\u0440\\u0430\\u0441\\u043d\\u044b\\u0435"}]}	19	f
49	Синий трактор на колесах	Детская игрушка синий трактор	2023-09-18 12:15:45.44512	https://avatars.mds.yandex.net/i?id=dba987616c59869e6fb5c80ad2cebafa267eeade-5707839-images-thumbs&n=13	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0440\\u043e\\u0434\\u0443\\u043a\\u0442\\u0430": "\\u0418\\u0433\\u0440\\u0443\\u0448\\u043a\\u0430"}, {"\\u041f\\u043e\\u043b": "\\u041c\\u0430\\u043b\\u044c\\u0447\\u0438\\u043a"}, {"\\u0412\\u043e\\u0437\\u0440\\u0430\\u0441\\u0442": "0+"}, {"\\u0426\\u0432\\u0435\\u0442": "\\u0421\\u0438\\u043d\\u0438\\u0439"}]}	20	f
50	Молоко Домик в деревне 3,2%	Свежее молоко высшего качества от производителя 'Домик в деревне'. Идеально подходит для приготовления различных блюд и напитков.	2023-09-19 14:36:08.566496	https://lenta.servicecdn.ru/globalassets/1/-/14/69/73/221863_1.png?preset=fulllossywhite	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "3,2%"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c": "1 \\u043b"}]}	18	f
51	Сыр Российский 'Веселый молочник'	Натуральный сыр высшего качества от производителя 'Веселый молочник'. Идеально подходит для приготовления бутербродов и различных закусок.	2023-09-19 14:36:08.632076	https://cdn-img.perekrestok.ru/i/800x800-fit/xdelivery/files/3f/a5/5be1b6b81e66b0ac079d66cc97e5.jpg	{"characteristics": [{"\\u0416\\u0438\\u0440\\u043d\\u043e\\u0441\\u0442\\u044c": "45%"}, {"\\u0412\\u0435\\u0441": "200 \\u0433"}]}	18	f
52	Картофель 'Ред Скарлет'	Свежий картофель высшего качества от производителя 'Ред Скарлет'. Идеально подходит для приготовления различных блюд и гарниров.	2023-09-19 14:36:08.684771	https://vsesorta.ru/upload/iblock/1ce/714539i-kartofel-semennoy-red-skarlett.jpg	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0420\\u0435\\u0434 \\u0421\\u043a\\u0430\\u0440\\u043b\\u0435\\u0442'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
53	Мясо говядины 'Ангус'	Свежее мясо говядины высшего качества от производителя 'Ангус'. Идеально подходит для приготовления различных блюд и мясных блюд.	2023-09-19 14:36:08.737205	https://www.man-meat.ru/upload/medialibrary/6bf/Black_Angus_Steaks.jpg	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u0413\\u043e\\u0432\\u044f\\u0434\\u0438\\u043d\\u0430"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
54	Рис 'Басмати'	Свежий рис высшего качества от производителя 'Басмати'. Идеально подходит для приготовления различных блюд и гарниров.	2023-09-19 14:36:08.782624	https://shop.miratorg.ru/upload/resize_cache/iblock/3ba/800_800_1/3bab4b88097ac160e9d1c678ac561aef.jpg	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u0430\\u0441\\u043c\\u0430\\u0442\\u0438'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
55	Хлеб 'Бородинский'	Свежий хлеб высшего качества от производителя 'Бородинский'. Идеально подходит для приготовления различных блюд и бутербродов.	2023-09-19 14:36:08.827884	https://www.philips.ru/c-dam/b2c/ru_RU/marketing-catalog/ho/recipes/desserts-baked-goods/borodino-bread/borodinskij-hleb.jpg	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0411\\u043e\\u0440\\u043e\\u0434\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
56	Курица 'Домашняя'	Свежая курица высшего качества от производителя 'Домашняя'. Идеально подходит для приготовления различных блюд и мясных блюд.	2023-09-19 14:36:08.878339	https://luxvill74.ru/pictures/product/big/5944_big.jpg	{"characteristics": [{"\\u0412\\u0438\\u0434 \\u043c\\u044f\\u0441\\u0430": "\\u041a\\u0443\\u0440\\u0438\\u0446\\u0430"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
57	Мед 'Алтайский'	Натуральный мед высшего качества от производителя 'Алтайский'. Идеально подходит для приготовления различных блюд и напитков.	2023-09-19 14:36:08.92707	https://altai-premium.ru/uploads/news/1534938838.jpg	{"characteristics": [{"\\u0421\\u043e\\u0440\\u0442": "'\\u0410\\u043b\\u0442\\u0430\\u0439\\u0441\\u043a\\u0438\\u0439'"}, {"\\u0412\\u0435\\u0441": "1 \\u043a\\u0433"}]}	18	f
58	Ноутбук HP Pavilion x360	Конвертируемый ноутбук с сенсорным экраном и процессором Intel Core i5 для повседневного использования.	2023-09-19 15:37:49.348117	https://clck.ru/35nAxH	{"characteristics": [{"\\u041f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440": "Intel Core i5-8265U"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "8 \\u0413\\u0411 DDR4"}, {"\\u0416\\u0435\\u0441\\u0442\\u043a\\u0438\\u0439 \\u0434\\u0438\\u0441\\u043a": "256 \\u0413\\u0411 SSD"}, {"\\u042d\\u043a\\u0440\\u0430\\u043d": "14 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432, \\u0441\\u0435\\u043d\\u0441\\u043e\\u0440\\u043d\\u044b\\u0439"}]}	1	f
60	Оперативная память Corsair Vengeance LPX	Высокопроизводительная оперативная память с радиаторами для охлаждения.	2023-09-19 15:37:49.472634	https://cdn1.ozone.ru/s3/multimedia-b/6463687175.jpg	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "DDR4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043f\\u0430\\u043c\\u044f\\u0442\\u0438": "32 \\u0413\\u0411 (2 x 16 \\u0413\\u0411)"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3200 \\u041c\\u0413\\u0446"}]}	1	f
59	Видеокарта NVIDIA GeForce RTX 3080	Мощная видеокарта для игр и профессионального использования с поддержкой технологии трассировки лучей.	2023-09-19 15:37:49.4082	https://cryptoage.com/images/Mining3/GTX2080/NVIDIA-GeForce-RTX-3080-FE.jpg	{"characteristics": [{"\\u0427\\u0438\\u043f\\u0441\\u0435\\u0442": "NVIDIA GeForce RTX 3080"}, {"\\u041f\\u0430\\u043c\\u044f\\u0442\\u044c": "10 \\u0413\\u0411 GDDR6X"}, {"\\u0418\\u043d\\u0442\\u0435\\u0440\\u0444\\u0435\\u0439\\u0441": "PCI Express 4.0"}]}	1	f
61	Процессор Intel Core i9-11900K	Мощный процессор для игр и профессионального использования с высокой производительностью.	2023-09-19 15:37:49.527859	https://cdn.idealo.com/folder/Product/201170/7/201170735/s3_produktbild_max_1/intel-core-i9-11900k-box.jpg	{"characteristics": [{"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u044f\\u0434\\u0435\\u0440": "8"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u043f\\u043e\\u0442\\u043e\\u043a\\u043e\\u0432": "16"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3.5 \\u0413\\u0413\\u0446 (4.9 \\u0413\\u0413\\u0446 \\u0432 \\u0440\\u0435\\u0436\\u0438\\u043c\\u0435 Turbo Boost)"}]}	1	f
66	Клавиатура Logitech G915 TKL	Беспроводная игровая клавиатура с подсветкой и технологией GL Tactile для более быстрого нажатия клавиш.	2023-09-19 15:37:49.83901	https://avatars.mds.yandex.net/get-marketpic/1584467/pic0c323db9044c9fd9a5315e27afa3f0b4/orig	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043a\\u043b\\u0430\\u0432\\u0438\\u0430\\u0442\\u0443\\u0440\\u044b": "\\u041c\\u0435\\u0445\\u0430\\u043d\\u0438\\u0447\\u0435\\u0441\\u043a\\u0430\\u044f"}, {"\\u0422\\u0435\\u0445\\u043d\\u043e\\u043b\\u043e\\u0433\\u0438\\u044f \\u043a\\u043b\\u0430\\u0432\\u0438\\u0448": "GL Tactile"}, {"\\u041f\\u043e\\u0434\\u0441\\u0432\\u0435\\u0442\\u043a\\u0430 \\u043a\\u043b\\u0430\\u0432\\u0438\\u0448": "RGB"}]}	1	f
62	Монитор Dell UltraSharp U2720Q	4K-монитор с широким цветовым охватом для профессионального использования.	2023-09-19 15:37:49.591776	https://images-na.ssl-images-amazon.com/images/I/51aFeV9SIdL._SS768_.jpg	{"characteristics": [{"\\u0414\\u0438\\u0430\\u0433\\u043e\\u043d\\u0430\\u043b\\u044c \\u044d\\u043a\\u0440\\u0430\\u043d\\u0430": "27 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}, {"\\u0420\\u0430\\u0437\\u0440\\u0435\\u0448\\u0435\\u043d\\u0438\\u0435 \\u044d\\u043a\\u0440\\u0430\\u043d\\u0430": "3840 x 2160 \\u043f\\u0438\\u043a\\u0441\\u0435\\u043b\\u0435\\u0439"}, {"\\u0426\\u0432\\u0435\\u0442\\u043e\\u0432\\u043e\\u0439 \\u043e\\u0445\\u0432\\u0430\\u0442": "99% sRGB, 99% Rec. 709, 95% DCI-P3"}]}	1	f
64	SSD-накопитель Samsung 970 EVO Plus	Быстрый SSD-накопитель с интерфейсом NVMe для повышения производительности компьютера.	2023-09-19 15:37:49.711694	https://madgeek.io/wp-content/uploads/2020/11/970evo-1.jpg	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "SSD"}, {"\\u0418\\u043d\\u0442\\u0435\\u0440\\u0444\\u0435\\u0439\\u0441": "PCIe NVMe 3.0 x4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c \\u043d\\u0430\\u043a\\u043e\\u043f\\u0438\\u0442\\u0435\\u043b\\u044f": "1 \\u0422\\u0411"}]}	1	f
63	Маршрутизатор ASUS RT-AX88U	Мощный маршрутизатор со стандартом Wi-Fi 6 и поддержкой технологии MU-MIMO.	2023-09-19 15:37:49.652641	https://nevateka.ru/upload/iblock/9ac/1150108_v01_b.jpg	{"characteristics": [{"\\u0421\\u0442\\u0430\\u043d\\u0434\\u0430\\u0440\\u0442 Wi-Fi": "Wi-Fi 6 (802.11ax)"}, {"\\u0421\\u043a\\u043e\\u0440\\u043e\\u0441\\u0442\\u044c Wi-Fi": "6000 \\u041c\\u0431\\u0438\\u0442/\\u0441"}, {"\\u041f\\u043e\\u0440\\u0442\\u044b Ethernet": "8 x 1 \\u0413\\u0431\\u0438\\u0442/\\u0441"}]}	1	f
65	Наушники Sony WH-1000XM4	Беспроводные наушники с поддержкой технологии шумоподавления и высоким качеством звука.	2023-09-19 15:37:49.779142	https://i.expansys.net/img/b/367041/sony-wh-1000xm4-true-wireless-noise-cancelling-headphones.jpg	{"characteristics": [{"\\u0422\\u0438\\u043f \\u043d\\u0430\\u0443\\u0448\\u043d\\u0438\\u043a\\u043e\\u0432": "Bluetooth"}, {"\\u0422\\u0435\\u0445\\u043d\\u043e\\u043b\\u043e\\u0433\\u0438\\u044f \\u0448\\u0443\\u043c\\u043e\\u043f\\u043e\\u0434\\u0430\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f": "Sony HD Noise Cancelling Processor QN1"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u043d\\u044b\\u0439 \\u0434\\u0438\\u0430\\u043f\\u0430\\u0437\\u043e\\u043d": "4 \\u0413\\u0446 - 40 \\u043a\\u0413\\u0446"}]}	1	f
67	Оперативная память Kingston HyperX Fury DDR4 16GB	Быстрая оперативная память Kingston HyperX Fury DDR4 объемом 16 ГБ с высокой производительностью и низкой задержкой.	2023-09-19 16:03:07.392096	https://cdn1.ozone.ru/s3/multimedia-y/6680529394.jpg	{"characteristics": [{"\\u0422\\u0438\\u043f": "DDR4"}, {"\\u041e\\u0431\\u044a\\u0435\\u043c": "16 \\u0413\\u0411"}, {"\\u0427\\u0430\\u0441\\u0442\\u043e\\u0442\\u0430": "3600 \\u041c\\u0413\\u0446"}, {"\\u041a\\u043e\\u043b\\u0438\\u0447\\u0435\\u0441\\u0442\\u0432\\u043e \\u043c\\u043e\\u0434\\u0443\\u043b\\u0435\\u0439": "1"}]}	1	f
68	Ноутбук ASUS ROG Zephyrus M16	Мощный игровой ноутбук ASUS ROG Zephyrus M16 с высокой производительностью и 16-дюймовым экраном.	2023-09-19 16:03:07.452633	https://www.pcplanet.ru/public_files/products/08/ba/08ba69b45b6166b593f9683195a99783/original.jpg	{"characteristics": [{"\\u042d\\u043a\\u0440\\u0430\\u043d": "16 \\u0434\\u044e\\u0439\\u043c\\u043e\\u0432"}, {"\\u041f\\u0440\\u043e\\u0446\\u0435\\u0441\\u0441\\u043e\\u0440": "Intel Core i7-11800H"}, {"\\u0413\\u0440\\u0430\\u0444\\u0438\\u043a\\u0430": "NVIDIA GeForce RTX 3060"}, {"\\u041e\\u043f\\u0435\\u0440\\u0430\\u0442\\u0438\\u0432\\u043d\\u0430\\u044f \\u043f\\u0430\\u043c\\u044f\\u0442\\u044c": "16 \\u0413\\u0411"}, {"\\u0425\\u0440\\u0430\\u043d\\u0438\\u043b\\u0438\\u0449\\u0435": "512 \\u0413\\u0411 SSD"}]}	1	f
\.


--
-- TOC entry 3577 (class 0 OID 16457)
-- Dependencies: 235
-- Data for Name: purshase_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purshase_histories (id, count, price, user_id, product_item_id, date) FROM stdin;
5	1	104	12	39	2023-09-19 14:49:05.137595
6	1	490	12	91	2023-09-19 15:01:12.98053
7	3	1470	12	91	2023-09-19 15:01:36.419869
\.


--
-- TOC entry 3579 (class 0 OID 16461)
-- Dependencies: 237
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, details, is_public) FROM stdin;
1	Покупатель	\N	t
2	Продавец	\N	t
3	Админ	\N	f
4	Worker	\N	f
\.


--
-- TOC entry 3581 (class 0 OID 16467)
-- Dependencies: 239
-- Data for Name: store_tag_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_tag_links (store_id, tag_id) FROM stdin;
1	3
1	4
1	46
1	121
1	122
1	123
1	124
2	51
2	122
2	125
2	52
2	126
3	58
3	122
3	127
3	12
3	128
4	129
4	130
4	131
4	132
4	133
5	134
5	135
5	136
5	68
5	133
6	34
6	137
6	131
6	138
6	139
7	140
7	138
7	136
7	141
7	142
8	143
8	144
8	131
8	145
8	146
9	133
9	147
9	148
9	149
9	122
10	18
10	150
10	151
10	152
10	153
11	154
11	155
11	151
11	89
11	156
12	157
12	151
12	158
12	159
12	160
13	100
13	52
13	161
13	125
13	136
14	52
14	162
14	151
14	121
14	145
15	112
15	163
15	131
15	138
15	140
16	15
16	52
16	136
16	164
16	165
17	166
17	167
17	168
17	169
17	136
18	115
18	170
18	159
18	160
18	131
19	117
19	132
19	122
19	171
19	172
20	115
20	170
20	159
20	160
20	131
\.


--
-- TOC entry 3582 (class 0 OID 16470)
-- Dependencies: 240
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (id, name, description, created_at, img, is_active, address, coordinates, site, details, owner_id) FROM stdin;
1	Онлайн-магазин 'Электроника'	Ведущий онлайн-магазин электроники. Мы предлагаем широкий ассортимент техники и аксессуаров по доступным ценам.	2023-09-16 14:26:54.276687	0f5bc5e318e07a42aee91b450f6d2f4b3278773cdc989b70535176edbb0221e61e690c29c35a69af751e	t	\N	{}	https://www.elektronika.ru/	{}	7
2	Онлайн-сервис 'Автозапчасти'	Надежный онлайн-магазин автозапчастей. У нас вы найдете все необходимые запчасти для вашего автомобиля по доступным ценам	2023-09-16 22:56:23.507623	5db70f22f44d1146b243413d7c082464c634ef696ac22cc6271eda8d7a3f0e4b9027b7cdd1e5d999e3b3	t	\N	{}	https://www.avtozapchasti.ru/	{}	1
3	Онлайн-магазин 'Книги'	Ведущий онлайн-магазин книг. Мы предлагаем широкий ассортимент книг по различным тематикам по доступным ценам	2023-09-16 23:02:30.154103	86b35224f5c803d0f2199192b1a81dd393b4dbcb5f54efbef37db908d2b0c583ffee125981f15ef65935	t	\N	{}	https://www.knigi.ru/	{}	2
4	Оффлайн-магазин 'Ювелирный магазин'	Крупнейший ювелирный магазин в городе. У нас вы найдете широкий ассортимент ювелирных изделий и украшений для любого случая	2023-09-16 23:05:37.256733	2bcd8da748d955a666dbddac19865fc4f6082da97f2baff39dddeb24ab7c515339a3a5d3aa95facbf11b	t	ул. Гагарина, 15	{"longitude": 55.756909, "latitude": 37.617634}	https://www.yuvelir-magazin.ru/	{}	2
5	Оффлайн-сервис 'Швейная мастерская'	Профессиональная швейная мастерская с опытными мастерами и современным оборудованием. Мы предлагаем широкий спектр услуг по пошиву и ремонту одежды	2023-09-17 01:21:05.340718	e0b72c97314342fcf12e427f7c73bbf321d8abed7a9ff05b7395f6c9c929615383c43e00fff303a961f3	f	ул. Кутузова, 10	{"longitude": 55.755826, "latitude": 37.6172999}	https://www.shvejnaya-masterskaya.ru/	{}	3
6	Оффлайн-магазин 'Спортивный магазин'	Крупнейший спортивный магазин в городе. У нас вы найдете все необходимое для занятий спортом и активного отдыха	2023-09-17 01:23:46.207944	1540d62644e10639a5fd242a2a476f729186813253d1d6d3ba83a9d86aeddcfc2efc740f99598f9b7825	t	ул. Ломоносова, 10	{"longitude": 55.755826, "latitude": 37.6172999}	https://www.sport-magazin.ru/	{}	4
7	Оффлайн-сервис 'Медицинский центр'	Профессиональный медицинский центр с опытными врачами и современным оборудованием. Мы предлагаем широкий спектр услуг по диагностике и лечению различных заболеваний	2023-09-17 01:26:28.847077	7490e06a7886cfd7774dd7483e07eaff5790780e018be149f5cad44210b7953f3b64d4f6f7051ee615b8	t	ул. Московская, 5	{"longitude": 55.758765, "latitude": 37.625978}	https://www.medcentr.ru/	{}	5
8	Оффлайн-магазин 'Мебельный магазин'	Крупнейший мебельный магазин в городе. У нас вы найдете все необходимое для обустройства вашего дома и офиса	2023-09-17 01:29:58.447253	2e1a44b0c5af8634bb139c23c22bdf8e01edf4b2d4438b43e436ff168fda1c46575bbe185f55a87af6b9	f	ул. Пушкина, 15	{"longitude": 55.764422, "latitude": 37.604785}	https://www.mebel-magazin.ru/	{}	8
9	Онлайн-магазин 'Модные тенденции'	Ведущий онлайн-магазин модной одежды. Мы предлагаем широкий ассортимент одежды, обуви и аксессуаров по доступным ценам	2023-09-17 01:31:38.886844	c1d99a58393289f4acc96c6e17236345dba41c228fa0d8f6b6b9bc167b3f50e25fceb28204b61a2076e5	t	\N	null	https://www.modnyetendencii.ru/	{}	9
10	Онлайн-сервис 'Туристическое агентство'	Надежный онлайн-сервис по организации путешествий и туров по всему миру. У нас вы можете заказать тур в любую страну мира и получить квалифицированную помощь от наших менеджеров	2023-09-17 01:38:48.11601	f8ec85509f6de0ee2b2b51d35d3c845e96f2bd0ade4dfe90b8a5bc7830e6946d39b65ffba63e56bbfc64	t	\N	null	https://www.tur-agency.ru/	{}	10
11	Онлайн-сервис 'Фотосервис'	Надежный онлайн-сервис по печати фотографий и созданию фотокниг. У нас вы можете заказать печать фотографий и создать уникальную фотокнигу в удобное для вас время	2023-09-17 01:39:55.254521	2cad70fe43e30a307b2a23122f724be53c8d6d8a5a6f42da40c508ea387d1f95d9510964ac48472235be	t	\N	null	https://foto-service.ru/	{}	11
12	Онлайн-сервис 'Доставка еды'	Надежный онлайн-сервис по доставке еды на дом и в офис. У нас вы можете заказать еду из лучших ресторанов города и получить ее в удобное для вас время	2023-09-17 01:41:13.37452	be734b399ee0012a049872e3add6a05b3c8476efdc7e7b571f936aa035817ae5242ce4e5a73fa7af3c3b	t	\N	null	https://www.dostavka-edy.ru/	{}	12
13	Оффлайн-сервис 'Автосервис'	Профессиональный автосервис с опытными механиками и современным оборудованием. Мы предлагаем широкий спектр услуг по ремонту и обслуживанию автомобилей	2023-09-17 01:44:11.656772	1cce96f0ac729849b45f6431b2307267c90e41d8b860f108b4e8d2d2804b3a24530526fb4f0a82283ac1	t	 ул. Садовая, 10	{"longitude": 55.7539303, "latitude": 37.620795}	https://www.avtoservis.ru/	{}	13
15	Оффлайн-магазин 'Аптека'	Крупнейшая сеть аптек в городе. У нас вы найдете все необходимые лекарства и медицинские препараты по доступным ценам	2023-09-17 01:47:53.244962	c2416d3100e2a1fe28ee5a8cac6567c43de07ecf0450b13ed48d998c4865b5b0f1d75400270a17003529	t	ул. Ленина, 25	{"longitude": 55.755826, "latitude": 37.6172999}	https://apteka.ru/	{}	14
16	Оффлайн-сервис 'Строительная компания'	Профессиональная строительная компания с опытными специалистами и современным оборудованием. Мы предлагаем широкий спектр услуг по строительству и ремонту жилых и коммерческих объектов	2023-09-17 01:50:42.717361	62eead118d0c92e900cd1d46ed1218aee3f1bd494661b209668a95f7ecf6a0be3ba547d7c53f5ba1409a	t	ул. Московская, 5	{"longitude": 55.758765, "latitude": 37.625978}	https://www.stroitel-kompaniya.ru/	{}	15
14	Онлайн-сервис "Ремонт бытовой техники"	Надежный онлайн-сервис по ремонту бытовой техники. У нас вы можете заказать ремонт вашей техники в удобное для вас время	2023-09-17 01:45:15.071538	5bfa275d2235e658cdd387046fde63d0455e30d63a9192118c27ffa83acc887f51485d2a549de68846ae	t	\N	null	https://www.remont-byt-tehniki.ru/	{}	13
17	Оффлайн-сервис 'Стрижка и уход за волосами'	Профессиональный салон красоты с опытными парикмахерами и косметологами. Мы предлагаем широкий спектр услуг по уходу за волосами и кожей головы	2023-09-17 01:58:56.556757	199584414a152a32cb3de5724359c8157ebf6afd52b018b7ecb94eeee6308f00220e5060cdcb4061629a	t	ул. Кирова, 5	{"longitude": 55.756909, "latitude": 37.617634}	https://www.strijka-uhod.ru/	{}	15
18	Оффлайн-магазин 'Супермаркет продуктов'	Крупнейшая сеть супермаркетов в городе. У нас вы найдете все необходимое для приготовления вкусных блюд и удобных покупок	2023-09-17 02:00:41.083142	dc590b001d7a5a44175cfca9721b9bd64cd12a8f5645a0f6a597c78e4a421575cf96e6114ca226fe84c8	t	ул. Ленина, 25	{"longitude": 55.755826, "latitude": 37.6172999}	https://www.supermarket-prod.ru/	{}	16
19	Онлайн-магазин 'Цветы и подарки'	Ведущий онлайн-магазин цветов и подарков. Мы предлагаем широкий ассортимент цветов, букетов, подарков и сувениров по доступным ценам	2023-09-17 02:02:00.159412	c92d40be2dd31dfdf1b321e3f752a08777215a48ce41c14a4a2b79a927b5b6d371488fe1e67bddfed388	t	\N	null	https://www.cvety-podarki.ru/	{}	16
20	Онлайн-магазин 'Игрушки'	Ведущий онлайн-магазин игрушек. Мы предлагаем широкий ассортимент игрушек для детей всех возрастов по доступным ценам	2023-09-17 02:03:13.919076	46807a8be7aaec82d91ca9501d371c023fc9c7179aaa3bd54216c8a77b14bbcb0d4d411308757edba477	t	\N	null	https://www.igrushki.ru/	{}	17
\.


--
-- TOC entry 3584 (class 0 OID 16476)
-- Dependencies: 242
-- Data for Name: tag_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag_groups (id, name, details) FROM stdin;
1	Возраст	{"is_product_tag": false}
2	Занятость	{"is_product_tag": false}
3	Сфера деятельности	{"is_product_tag": false}
4	Маркет	{"is_product_tag":true}
\.


--
-- TOC entry 3586 (class 0 OID 16482)
-- Dependencies: 244
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, name, group_id, details) FROM stdin;
2	Безработный	2	\N
3	Студент	2	\N
4	Школьник	2	\N
10	Производство	3	\N
11	Торговля	3	\N
12	Образование	3	\N
13	Здравоохранение	3	\N
14	Финансы	3	\N
15	Строительство	3	\N
16	Транспорт	3	\N
17	Логистика	3	\N
18	Туризм	3	\N
19	Реклама	3	\N
20	Маркетинг	3	\N
21	Информационные технологии	3	\N
22	Консалтинг	3	\N
23	Юриспруденция	3	\N
24	Недвижимость	3	\N
25	Сельское хозяйство	3	\N
26	Энергетика	3	\N
27	Искусство и культура	3	\N
28	Спорт и фитнес	3	\N
29	Государственное управление	3	\N
5	Дети	1	{"age_min": 0, "age_max": 10}
6	Подростки	1	{"age_min": 11,"age_max": 18}
7	Молодежь	1	{"age_min":19,"age_max": 35}
8	Взрослые	1	{"age_min":36,"age_max": 60}
9	Старшее поколение	1	{"age_min":61,"age_max": 10000}
1	Работающий	2	\N
30	Кроссовки	4	\N
31	Спортивная обувь	4	\N
32	Nike	4	\N
33	Велосипед	4	\N
34	Спорт	4	\N
35	Scott	4	\N
36	Лыжи	4	\N
37	Спортивный инвентарь	4	\N
38	Fischer	4	\N
39	Гантели	4	\N
40	Reebok	4	\N
41	Штанга	4	\N
42	Champion	4	\N
43	Xiaomi	4	\N
44	Смартфоны	4	\N
45	Китай	4	\N
46	Электроника	4	\N
47	Ноутбуки	4	\N
48	Flaptop	4	\N
49	Смарт-часы	4	\N
50	Не дорогие	4	\N
51	Автозапчасти	4	\N
52	Ремонт	4	\N
53	Порог	4	\N
54	Внешний вид	4	\N
55	Красиво	4	\N
56	Подбор	4	\N
57	Быстро	4	\N
58	Книги	4	\N
59	Учебная литература	4	\N
60	Психология	4	\N
61	Детское развитие	4	\N
62	Детям и родителям	4	\N
63	Ювелирное украшение	4	\N
64	Крест	4	\N
65	Серебро	4	\N
66	Подвеска	4	\N
67	Швея	4	\N
68	Пошив	4	\N
69	Медицинский центр	4	\N
70	Анализы	4	\N
71	Сдача	4	\N
72	Приём	4	\N
73	Терапевт	4	\N
74	Мебельный магазин	4	\N
75	Матрас	4	\N
76	Askona	4	\N
77	Обувница	4	\N
78	Стулья	4	\N
79	Вечернее платье	4	\N
80	Элегантность	4	\N
81	Открытая спина	4	\N
82	Спортивная куртка	4	\N
83	Стиль	4	\N
84	Капюшон	4	\N
85	Городская сумка	4	\N
86	Просторная	4	\N
87	Отделения	4	\N
88	Фотография	4	\N
89	Печать	4	\N
90	Пицца	4	\N
91	Маргарита	4	\N
92	Итальянская кухня	4	\N
93	Роллы	4	\N
94	Филадельфия	4	\N
95	Заказ	4	\N
96	Франция	4	\N
97	Париж	4	\N
98	Карибское море	4	\N
99	Круиз	4	\N
100	Автосервис	4	\N
101	Техническое обслуживание	4	\N
102	Обслуживание автомобиля	4	\N
103	Шиномонтаж	4	\N
107	Ремонт бытовой техники	4	\N
108	Плита	4	\N
109	Холодильник	4	\N
110	Лекарство	4	\N
111	Препарат	4	\N
112	Аптека	4	\N
113	Волосы	4	\N
114	Парикмахер	4	\N
115	Продукты	4	\N
116	Шоколад	4	\N
117	Цветы	4	\N
118	Розы	4	\N
119	Игрушка	4	\N
120	Трактор	4	\N
121	Техника	4	\N
122	Интернет-магазин	4	\N
123	Гаджеты	4	\N
124	Компьютеры	4	\N
125	Автомобиль	4	\N
126	Запчасти	4	\N
127	Литература	4	\N
128	Чтение	4	\N
129	Ювелирные изделия	4	\N
130	Украшения	4	\N
131	Оффлайн-магазин	4	\N
132	Подарки	4	\N
133	Мода	4	\N
134	Швейная мастерская	4	\N
135	Ремонт одежды	4	\N
136	Оффлайн-сервис	4	\N
137	Магазин	4	\N
138	Здоровье	4	\N
139	Активный отдых	4	\N
140	Медицина	4	\N
141	Врачи	4	\N
142	Диагностика	4	\N
143	Мебель	4	\N
144	Интерьер	4	\N
145	Дом	4	\N
146	Офис	4	\N
147	Одежда	4	\N
148	Обувь	4	\N
149	Аксессуары	4	\N
150	Путешествия	4	\N
151	Интернет-сервис	4	\N
152	Туры	4	\N
153	Отдых	4	\N
154	Фото	4	\N
155	Фотосервис	4	\N
156	Фотокниги	4	\N
157	Доставка еды	4	\N
158	Рестораны	4	\N
159	Еда	4	\N
160	Питание	4	\N
161	Обслуживание	4	\N
162	Бытовая техника	4	\N
163	Лекарства	4	\N
164	Жилье	4	\N
165	Коммерческие объекты	4	\N
166	Стрижка	4	\N
167	Уход за волосами	4	\N
168	Красота	4	\N
169	Парикмахерская	4	\N
170	Супермаркет	4	\N
171	Букеты	4	\N
172	Сувениры	4	\N
173	Молоко	4	\N
174	Продукты питания	4	\N
175	Домик в деревне	4	\N
176	Сыр	4	\N
177	Веселый молочник	4	\N
178	Картофель	4	\N
179	Ред скарлет	4	\N
180	Мясо	4	\N
181	Ангус	4	\N
182	Рис	4	\N
183	Басмати	4	\N
184	Хлеб	4	\N
185	Бородинский	4	\N
186	Домашняя	4	\N
187	Мед	4	\N
188	Алтайский	4	\N
189	Hp	4	\N
190	Конвертируемый	4	\N
191	Видеокарты	4	\N
192	Nvidia	4	\N
193	Игры	4	\N
194	Трассировка лучей	4	\N
195	Оперативная память	4	\N
196	Corsair	4	\N
197	Процессоры	4	\N
198	Intel	4	\N
199	Мониторы	4	\N
200	Dell	4	\N
201	4k	4	\N
202	Маршрутизаторы	4	\N
203	Asus	4	\N
204	Wi-fi 6	4	\N
205	Ssd	4	\N
206	Samsung	4	\N
207	Наушники	4	\N
208	Sony	4	\N
209	Беспроводные	4	\N
210	Клавиатуры	4	\N
211	Logitech	4	\N
212	Kingston	4	\N
213	Ноутбук	4	\N
214	Игровой ноутбук	4	\N
\.


--
-- TOC entry 3588 (class 0 OID 16488)
-- Dependencies: 246
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, path, is_active, details, user_id, last_date_execute, duration, name, date_execute) FROM stdin;
\.


--
-- TOC entry 3590 (class 0 OID 16494)
-- Dependencies: 248
-- Data for Name: unit_intervals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unit_intervals (id, name, unit, value, details) FROM stdin;
1	Каждый час	hours	1	{"custom": "час"}
3	Каждую неделю	weeks	1	{"custom": "неделя"}
4	Каждый месяц	months	1	{"custom": "месяц"}
2	Каждый день	days	1	{"custom": "день"}
\.


--
-- TOC entry 3592 (class 0 OID 16500)
-- Dependencies: 250
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, firstname, lastname, patronymic, created_at, role_id, birthdate, img, gender, cash) FROM stdin;
1	andrey.savateeff2015@yandex.ru	$2b$12$HxCmrrCnkl7lnkUaIHbci.CtKnKX/BJzLQWv69C2dcQvndPw7N1OK	Андрей	Саватеев	Игоревич	2023-09-16 10:11:29.832893	2	\N	\N	t	0
3	katsumiproo@gmail.com	$2b$12$rzws3B9P3ux4aAm2GGyJIe1dIWqz8uPaPwALxUZUwTAW9hZCQx8kC	Петр	Петров	Петрович	2023-09-16 10:11:29.832893	2	\N	\N	t	0
4	maksim228775@gmail.com	$2b$12$rzws3B9P3ux4aAm2GGyJIe1dIWqz8uPaPwALxUZUwTAW9hZCQx8kC	Алексей	Алексеев	Алексеевич	2023-09-10 10:11:29.832893	2	\N	\N	t	0
5	romanova@mail.ru	$2b$12$rzws3B9P3ux4aAm2GGyJIe1dIWqz8uPaPwALxUZUwTAW9hZCQx8kC	Алина	Романова	Алексеевна	2023-09-17 10:11:29.832893	2	\N	\N	f	0
7	user@example.com	$2b$12$HxCmrrCnkl7lnkUaIHbci.CtKnKX/BJzLQWv69C2dcQvndPw7N1OK	Максим	Исаев	Александрович	2023-09-14 10:11:29.832893	2	2002-02-20	\N	t	0
8	vaynbaum50@gmail.com	$2b$12$TuMOaB55HSJMvz3IBQk0EuZ17rqGvmrVsaZaaSs2spgOjs7M0al5e	Иван	Смирнов	Романович	2023-09-16 22:38:26.152421	2	\N	\N	t	0
9	volkov@mail.ru	$2b$12$4r0.jeHC46XbExOm/XUHGOsKSJtAlGLxYzWLSQ2KkcQkTPbucxYue	Михаил	Волков	Борисович	2023-09-16 22:38:42.970237	2	\N	\N	t	0
10	burova@mail.ru	$2b$12$2cizZRTyv6UIXzoQ9jQtG.7csq.bTVh4xrn4G9HM.kwKgCQ25hWsq	Наталья	Бурова	Витальевна	2023-09-16 22:38:49.529068	2	\N	\N	f	0
11	kurskaya@mail.ru	$2b$12$psk5bVgyTZrV9/aqWgoVQOAt3l31WmxXwdtGpGnWSJErOR.tm7Ele	Евгения	Курская	Ивановна	2023-09-16 22:38:58.210738	2	\N	\N	f	0
13	kozlovroman@yandex.ru	$2b$12$8YdSrKhoqTrlUq.JUt1VoeYCrfk7k63pJB2qIO0eTe.SSKv/d2K9m	Роман	Козлов	Романович	2023-09-16 22:42:24.000038	2	\N	\N	t	0
14	hmelnikovroman@yandex.ru	$2b$12$o0gFGLPZl7c6ZBjebd60ieiyJHAFL8H0fGyWiuPbE.I8IUhIDhTy.	Роман	Хмельников	Алексеевич	2023-09-16 22:42:41.774587	2	\N	\N	t	0
16	s.rindow@yandex.ru	$2b$12$agDdgq4T./9guh6zXvGYa.JXG7fkZeyQq9.nsEfXbrVb1zgFzODH6	Сергей	Рындов	Николаевич	2023-09-16 22:45:06.801737	2	\N	\N	t	0
17	taisiya1983@hotmail.com	$2b$12$8tyQBWAiMqCMT1jPFHZsPOxEdluEKLNx/vCEGwCMDgzeBTUpubF2W	Таисия	Якущенко	Климентьевна	2023-09-16 22:46:04.080303	2	\N	\N	f	0
18	filipp1969@hotmail.com	$2b$12$7gZPtn.XPKl0SO5PQMN1ReM1NJ3YuY9Tn1RJIJO8GdGXBAtKFeeD2	Филипп	Аршавин	Макарович	2023-09-16 22:48:17.525147	1	\N	\N	t	0
21	efim8351@ya.ru	$2b$12$AtXL7fN6XwnMdOtIHlpGXOiCuWV.V5KW1.7HDxfucc0hTyBnMOOO6	\N	\N	\N	2023-09-16 22:51:00.468017	1	\N	\N	\N	0
19	denis91@yandex.ru	$2b$12$bbwrT96umGYuBJAa4SzTzuEmdW/RdmsoQfgUVqZrdlwG4HeIV.8Gu	Денис	Денисов	Тимофеевич	2023-09-16 22:50:03.25544	1	\N	\N	\N	0
20	nika.kucaka@rambler.ru	$2b$12$uDYjFIgG3aXl3tZuffCLneZTdx197SFNHAtIoLBciJWCw1odLTHw6	Ника	Куцака	Федотовна	2023-09-16 22:50:32.355068	1	\N	\N	\N	0
22	konstantin10@hotmail.com	$2b$12$XZFaFgsT5ZN/7h3.WUWTvO/U9lV8q/GnLnEXvvxm6jpK0h66IxAoK	\N	\N	\N	2023-09-16 22:51:12.83689	1	\N	\N	\N	0
23	yaroslava1961@mail.ru	$2b$12$O0KATs2zC44UgDi0t3Y7ve9HliWsbjSggKAk.WZgi50NtiLEccFWS	\N	\N	\N	2023-09-16 22:51:32.595322	1	\N	\N	\N	0
24	aleksey1996@outlook.com	$2b$12$E4O/H.SiDE0Dju0B0bzV2eJ/TZQSNZ2xgIJkVvDSjzHTbSh6oEheW	\N	\N	\N	2023-09-16 22:51:43.947636	1	\N	\N	\N	0
25	misty_worker@mail.ru	$2b$12$BxogY3z724qLS2rVE3OF7.hwMLlGAm2/lPWUT37cyGpzz6s363X3q	\N	\N	\N	2023-09-17 17:19:35.828963	4	\N	\N	\N	0
26	andreysavateev@yandex.ru	$2b$12$QxLtqFiACfMfJe.z2Cdje.5//yB0KqXqYMeMbfAxAVOQwn09xvCMq	\N	\N	\N	2023-09-19 09:13:23.016718	1	\N	\N	\N	0
27	v.romankozlov@gmail.com	$2b$12$bpp050BhSZ.59Q9lYe7WDOdortzTJUkYxA8awXFb057BFQFJ2sf/2	Роман	Козлов	Васильевич	2023-09-19 13:28:44.628397	1	\N	http://46.243.226.43:6100/files/6dde07c7eb3aa6da57206cd2ad5db4193132dc527a9e66d91a9feb162d5bc560b70e58c4cc331d4a0b87	\N	0
15	capricorns_roman@mail.ru	$2b$12$2CoXa4HPzNiSej6Zl4gS.u5BwlGnT3D7Ef0zK5KrHHS3Utc23.CQ.	Роман	Козерогов	Сергеевич	2023-09-16 22:43:17.044647	2	\N	\N	t	1861
12	vromanmelnikov@yandex.ru	$2b$12$ezvN7CKzWvw13Be5/QU.5uQ8M8dTGXmn/g6Y7DtV6CW6lImfE8aye	Роман	Мельников	Васильевич	2023-09-16 22:41:57.280058	2	2023-09-19	http://46.243.226.43:6100/files/1a34c1dc1d84567acfd98fbc98d8857ce3ec9cf042ef57e33de59d7dc6b90d061c0ebc9977f2cd535855	t	226638
2	ngtumaksimisaev@gmail.com	$2b$12$HxCmrrCnkl7lnkUaIHbci.CtKnKX/BJzLQWv69C2dcQvndPw7N1OK	Иван	Иванов	Иванович	2023-09-15 21:17:29.638677	2	\N	\N	t	98
6	mr.vaynbaum@mail.ru	$2b$12$rzws3B9P3ux4aAm2GGyJIe1dIWqz8uPaPwALxUZUwTAW9hZCQx8kC	Денис	Вайнбаум	Алексеевич	2023-09-15 21:17:29.638677	1	2003-01-16	http://46.243.226.43:6100/files/f90810b6300d0d499603217a7218cd01ce0ab2583e8a3da52bcba2582e22495524a31fcd58e7f6baf557	t	999280
\.


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 211
-- Name: baskets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.baskets_id_seq', 11, true);


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 213
-- Name: characteristics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characteristics_id_seq', 105, true);


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 216
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 20, true);


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 218
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 6, true);


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 221
-- Name: friend_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friend_types_id_seq', 8, true);


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 225
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 5, true);


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 227
-- Name: product_favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_favourites_id_seq', 1, false);


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 229
-- Name: product_feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_feedbacks_id_seq', 1, true);


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 231
-- Name: product_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_items_id_seq', 139, true);


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 234
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 68, true);


--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 236
-- Name: purshase_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purshase_histories_id_seq', 7, true);


--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 238
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 241
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stores_id_seq', 20, true);


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 243
-- Name: tag_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_groups_id_seq', 1, false);


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 245
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 214, true);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 247
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 22, true);


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 249
-- Name: unit_intervals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_intervals_id_seq', 1, false);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 28, true);


--
-- TOC entry 3322 (class 2606 OID 16525)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 3324 (class 2606 OID 16527)
-- Name: baskets baskets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baskets
    ADD CONSTRAINT baskets_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 16529)
-- Name: characteristics characteristics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characteristics
    ADD CONSTRAINT characteristics_pkey PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16531)
-- Name: customer_tag_links customer_tag_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_tag_links
    ADD CONSTRAINT customer_tag_links_pkey PRIMARY KEY (customer_id, tag_id);


--
-- TOC entry 3330 (class 2606 OID 16533)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16535)
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16537)
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (token);


--
-- TOC entry 3336 (class 2606 OID 16539)
-- Name: friend_types friend_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_types
    ADD CONSTRAINT friend_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16541)
-- Name: friends friends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (initator_id, friend_id);


--
-- TOC entry 3340 (class 2606 OID 16543)
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (user_id, product_feedback_id);


--
-- TOC entry 3342 (class 2606 OID 16545)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 16547)
-- Name: product_favourites product_favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_favourites
    ADD CONSTRAINT product_favourites_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16549)
-- Name: product_feedbacks product_feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_feedbacks
    ADD CONSTRAINT product_feedbacks_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 16551)
-- Name: product_items product_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 16553)
-- Name: product_tag_links product_tag_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tag_links
    ADD CONSTRAINT product_tag_links_pkey PRIMARY KEY (product_id, tag_id);


--
-- TOC entry 3352 (class 2606 OID 16555)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 16557)
-- Name: purshase_histories purshase_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purshase_histories
    ADD CONSTRAINT purshase_histories_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 16559)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 3358 (class 2606 OID 16561)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 16563)
-- Name: store_tag_links store_tag_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag_links
    ADD CONSTRAINT store_tag_links_pkey PRIMARY KEY (store_id, tag_id);


--
-- TOC entry 3362 (class 2606 OID 16565)
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 16567)
-- Name: tag_groups tag_groups_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_groups
    ADD CONSTRAINT tag_groups_name_key UNIQUE (name);


--
-- TOC entry 3366 (class 2606 OID 16569)
-- Name: tag_groups tag_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_groups
    ADD CONSTRAINT tag_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 16571)
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- TOC entry 3370 (class 2606 OID 16573)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 16575)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 16577)
-- Name: unit_intervals unit_intervals_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_intervals
    ADD CONSTRAINT unit_intervals_name_key UNIQUE (name);


--
-- TOC entry 3376 (class 2606 OID 16579)
-- Name: unit_intervals unit_intervals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_intervals
    ADD CONSTRAINT unit_intervals_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 16581)
-- Name: unit_intervals unit_intervals_unit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_intervals
    ADD CONSTRAINT unit_intervals_unit_key UNIQUE (unit);


--
-- TOC entry 3380 (class 2606 OID 16583)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3382 (class 2606 OID 16585)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3383 (class 2606 OID 16586)
-- Name: baskets baskets_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baskets
    ADD CONSTRAINT baskets_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(id);


--
-- TOC entry 3384 (class 2606 OID 16591)
-- Name: baskets baskets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baskets
    ADD CONSTRAINT baskets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3385 (class 2606 OID 16596)
-- Name: customer_tag_links customer_tag_links_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_tag_links
    ADD CONSTRAINT customer_tag_links_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id);


--
-- TOC entry 3386 (class 2606 OID 16601)
-- Name: customer_tag_links customer_tag_links_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_tag_links
    ADD CONSTRAINT customer_tag_links_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- TOC entry 3387 (class 2606 OID 16606)
-- Name: events events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3388 (class 2606 OID 16611)
-- Name: favourites favourites_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(id);


--
-- TOC entry 3389 (class 2606 OID 16616)
-- Name: favourites favourites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3390 (class 2606 OID 16621)
-- Name: files files_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- TOC entry 3391 (class 2606 OID 16626)
-- Name: friends friends_friend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES public.users(id);


--
-- TOC entry 3392 (class 2606 OID 16631)
-- Name: friends friends_initator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_initator_id_fkey FOREIGN KEY (initator_id) REFERENCES public.users(id);


--
-- TOC entry 3393 (class 2606 OID 16636)
-- Name: likes likes_product_feedback_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_product_feedback_id_fkey FOREIGN KEY (product_feedback_id) REFERENCES public.product_feedbacks(id);


--
-- TOC entry 3394 (class 2606 OID 16641)
-- Name: likes likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3395 (class 2606 OID 16646)
-- Name: notes notes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3396 (class 2606 OID 16651)
-- Name: product_favourites product_favourites_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_favourites
    ADD CONSTRAINT product_favourites_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3397 (class 2606 OID 16656)
-- Name: product_favourites product_favourites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_favourites
    ADD CONSTRAINT product_favourites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3398 (class 2606 OID 16661)
-- Name: product_feedbacks product_feedbacks_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_feedbacks
    ADD CONSTRAINT product_feedbacks_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3399 (class 2606 OID 16666)
-- Name: product_feedbacks product_feedbacks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_feedbacks
    ADD CONSTRAINT product_feedbacks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3400 (class 2606 OID 16671)
-- Name: product_items product_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_items
    ADD CONSTRAINT product_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3401 (class 2606 OID 16676)
-- Name: product_tag_links product_tag_links_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tag_links
    ADD CONSTRAINT product_tag_links_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3402 (class 2606 OID 16681)
-- Name: product_tag_links product_tag_links_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tag_links
    ADD CONSTRAINT product_tag_links_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- TOC entry 3403 (class 2606 OID 16686)
-- Name: products products_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- TOC entry 3404 (class 2606 OID 16691)
-- Name: purshase_histories purshase_histories_product_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purshase_histories
    ADD CONSTRAINT purshase_histories_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES public.product_items(id);


--
-- TOC entry 3405 (class 2606 OID 16696)
-- Name: purshase_histories purshase_histories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purshase_histories
    ADD CONSTRAINT purshase_histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3406 (class 2606 OID 16701)
-- Name: store_tag_links store_tag_links_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag_links
    ADD CONSTRAINT store_tag_links_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- TOC entry 3407 (class 2606 OID 16706)
-- Name: store_tag_links store_tag_links_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag_links
    ADD CONSTRAINT store_tag_links_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- TOC entry 3408 (class 2606 OID 16711)
-- Name: stores stores_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- TOC entry 3409 (class 2606 OID 16716)
-- Name: tags tags_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.tag_groups(id);


--
-- TOC entry 3410 (class 2606 OID 16721)
-- Name: tasks tasks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3411 (class 2606 OID 16726)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2023-09-19 23:05:21

--
-- PostgreSQL database dump complete
--

