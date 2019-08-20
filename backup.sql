--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

-- Started on 2019-08-20 01:30:19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 215 (class 1255 OID 21517)
-- Name: get_precio_medio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_precio_medio() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
  suma float = 0;
  suma_total float = 0;
  precio_u float;
  i int = 1;
  cursor_precio_productos CURSOR FOR
    SELECT price FROM products;

BEGIN
  SELECT COUNT(*) INTO suma_total FROM products;
  
  OPEN cursor_precio_productos;
    WHILE i <= suma_total LOOP
  FETCH cursor_precio_productos into precio_u;
  suma = suma + precio_u;
  i = i + 1;
    END LOOP;
  CLOSE cursor_precio_productos;
  
  RETURN suma / suma_total;
END;
$$;


ALTER FUNCTION public.get_precio_medio() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 21518)
-- Name: get_precio_medio_con_descuento(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_precio_medio_con_descuento() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
  suma float = 0;
  suma_total float = 0;
  precio_u float;
  descuento float;
  i int = 1;
  cursor_precio_productos CURSOR FOR
    SELECT price, discount FROM products;

BEGIN
  SELECT COUNT(*) INTO suma_total FROM products;
  
  OPEN cursor_precio_productos;
    WHILE i <= suma_total LOOP
  FETCH cursor_precio_productos into precio_u, descuento;
          IF descuento IS NOT NULL THEN
    suma = suma + (precio_u - precio_u * (descuento / 100));
          ELSE
            suma = suma + precio_u;
          END IF;
  i = i + 1;
    END LOOP;
  CLOSE cursor_precio_productos;
  
  RETURN suma / suma_total;
END;
$$;


ALTER FUNCTION public.get_precio_medio_con_descuento() OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 21520)
-- Name: sae_product_backup(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sae_product_backup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into products_backup(id, name, description, price, brand_id)
values(OLD.id, OLD.name, OLD.description, OLD.price, OLD.brand_id);
RETURN OLD;
END;
$$;


ALTER FUNCTION public.sae_product_backup() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 21515)
-- Name: save_brand(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.save_brand() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO brand_backup(id, name) VALUES(OLD.id, OLD.name);
END; $$;


ALTER FUNCTION public.save_brand() OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 21508)
-- Name: save_product_backup(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.save_product_backup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into products_backup(id, name, description, price, brand_id)
values(OLD.id, OLD.name, OLD.description, OLD.price, OLD.brand_id);
RETURN OLD;
END;
$$;


ALTER FUNCTION public.save_product_backup() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 203 (class 1259 OID 20854)
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO andre;

--
-- TOC entry 202 (class 1259 OID 20852)
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO andre;

--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 202
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- TOC entry 201 (class 1259 OID 20842)
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO andre;

--
-- TOC entry 200 (class 1259 OID 20840)
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO andre;

--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 200
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- TOC entry 197 (class 1259 OID 20821)
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO andre;

--
-- TOC entry 211 (class 1259 OID 21510)
-- Name: brand_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand_backup (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE public.brand_backup OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 20888)
-- Name: brands; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.brands (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.brands OWNER TO andre;

--
-- TOC entry 206 (class 1259 OID 20886)
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_id_seq OWNER TO andre;

--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 206
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- TOC entry 199 (class 1259 OID 20831)
-- Name: products; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL,
    price double precision NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    brand_id bigint NOT NULL,
    discount integer
);


ALTER TABLE public.products OWNER TO andre;

--
-- TOC entry 210 (class 1259 OID 21500)
-- Name: products_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_backup (
    id integer NOT NULL,
    name character varying(45),
    description character varying(1000),
    price double precision,
    brand_id integer
);


ALTER TABLE public.products_backup OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 20829)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO andre;

--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 198
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 213 (class 1259 OID 21569)
-- Name: purchases; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.purchases (
    id bigint NOT NULL,
    product_id bigint,
    user_id bigint,
    product_price double precision,
    product_discount double precision,
    address character varying,
    telephone character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.purchases OWNER TO andre;

--
-- TOC entry 212 (class 1259 OID 21567)
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchases_id_seq OWNER TO andre;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 212
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- TOC entry 196 (class 1259 OID 20813)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO andre;

--
-- TOC entry 205 (class 1259 OID 20872)
-- Name: users; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO andre;

--
-- TOC entry 204 (class 1259 OID 20870)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO andre;

--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 209 (class 1259 OID 20906)
-- Name: versions; Type: TABLE; Schema: public; Owner: andre
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp without time zone
);


ALTER TABLE public.versions OWNER TO andre;

--
-- TOC entry 208 (class 1259 OID 20904)
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: andre
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO andre;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 208
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andre
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- TOC entry 2108 (class 2604 OID 20857)
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- TOC entry 2107 (class 2604 OID 20845)
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- TOC entry 2113 (class 2604 OID 20891)
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- TOC entry 2106 (class 2604 OID 20834)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 2115 (class 2604 OID 21572)
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- TOC entry 2109 (class 2604 OID 20875)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 2114 (class 2604 OID 20909)
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- TOC entry 2282 (class 0 OID 20854)
-- Dependencies: 203
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	images	Product	1	1	2019-05-30 11:54:13.338359
2	images	Product	1	2	2019-05-30 11:54:14.043022
3	images	Product	1	3	2019-05-30 11:54:14.189875
4	images	Product	2	4	2019-05-30 11:54:14.352899
5	images	Product	2	5	2019-05-30 11:54:14.498367
6	images	Product	3	6	2019-05-30 11:54:14.634621
7	images	Product	3	7	2019-05-30 11:54:14.758929
8	images	Product	4	8	2019-05-30 11:54:14.901076
9	images	Product	4	9	2019-05-30 11:54:15.038419
10	images	Product	5	10	2019-05-30 14:05:38.795425
\.


--
-- TOC entry 2280 (class 0 OID 20842)
-- Dependencies: 201
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, byte_size, checksum, created_at) FROM stdin;
1	yuhgz8fjshdj9sl3fusgobs1icq8	1.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	157238	37C1ra2vOmS74rU3E0SgxQ==	2019-05-30 11:54:13.335249
2	gpvyv645d89tjxvve3oup0ld663e	2.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	159376	na6xGDzr/z7iVYuqEHYBwA==	2019-05-30 11:54:14.040943
3	sbsbuen3rdr8zapnss4xpqae2nw9	3.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	190201	iJd8dDAQDeT0LehrUn9akA==	2019-05-30 11:54:14.187757
4	bdiyvy3yqh2p14jp3xv68aaxqxwd	1.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	105699	/u5A4TDKB7v2f8306FT4nA==	2019-05-30 11:54:14.348151
5	190dhlq5ip29pfhfcilff6n8oyl9	2.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	68702	/RBVska1vovI9jHZMXSyWQ==	2019-05-30 11:54:14.496359
6	on70e5v1b76m768i8uzatnc35hi0	1.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	106729	qTNevPrzueWRYjUp6ktCnw==	2019-05-30 11:54:14.632541
7	2hcr3hnbj1cap5x3tt0c5jh8avk2	2.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	96013	CAru5igZ9bDKzkiBNb/cnQ==	2019-05-30 11:54:14.75681
8	9zn6srdhtt93zq5578wuos5t74i8	1.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	142338	Bv40PI4s0bQc4+ZWESbY7g==	2019-05-30 11:54:14.898872
9	e25d6jlmp11n98e62u08coky0yxg	2.jpg	image/jpeg	{"identified":true,"width":472,"height":472,"analyzed":true}	185541	s+hOyo8Mh9B6TiK+Pmwl0A==	2019-05-30 11:54:15.036262
10	0b39wl1haggpq8ca6j8b1plta18n	DER.png	image/png	{"identified":true,"width":1535,"height":1364,"analyzed":true}	172463	VoA5eaowcb6On34sqS/xAQ==	2019-05-30 14:05:38.786942
\.


--
-- TOC entry 2276 (class 0 OID 20821)
-- Dependencies: 197
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2019-05-30 11:53:55.279134	2019-05-30 11:53:55.279134
\.


--
-- TOC entry 2290 (class 0 OID 21510)
-- Dependencies: 211
-- Data for Name: brand_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brand_backup (id, name) FROM stdin;
\.


--
-- TOC entry 2286 (class 0 OID 20888)
-- Dependencies: 207
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.brands (id, name, created_at, updated_at) FROM stdin;
1	Rollex	2019-05-30 11:54:13.011436	2019-05-30 11:54:13.011436
2	Armani	2019-05-30 11:54:13.02095	2019-05-30 11:54:13.02095
3	Fossil	2019-05-30 11:54:13.024808	2019-05-30 11:54:13.024808
4	Tissot	2019-05-30 11:54:13.028321	2019-05-30 11:54:13.028321
5	Wenger	2019-05-30 11:54:13.031685	2019-05-30 11:54:13.031685
6	Casio	2019-05-30 11:54:13.045132	2019-05-30 11:54:13.045132
7	Invicta	2019-05-30 11:54:13.050032	2019-05-30 11:54:13.050032
8	BMW	2019-05-30 11:54:13.05498	2019-05-30 11:54:13.05498
9	Tommy Hilfiger	2019-05-30 11:54:13.058874	2019-05-30 11:54:13.058874
10	Q&Q	2019-05-30 11:54:13.062254	2019-05-30 11:54:13.062254
11	Calvin Klein	2019-05-30 11:54:13.065735	2019-05-30 11:54:13.065735
12	Diesel	2019-05-30 11:54:13.069199	2019-05-30 11:54:13.069199
13	Certina	2019-05-30 11:54:13.072383	2019-05-30 11:54:13.072383
14	G-Shock	2019-05-30 11:54:13.07618	2019-05-30 11:54:13.07618
15	Michael Kors	2019-05-30 11:54:13.079703	2019-05-30 11:54:13.079703
\.


--
-- TOC entry 2278 (class 0 OID 20831)
-- Dependencies: 199
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.products (id, name, description, price, created_at, updated_at, brand_id, discount) FROM stdin;
2	Everyday Muse ES4062	Reloj analogo para hombre con movimiento de cuarzo y hecho en acero inoxidable. Tiene una resistencia al agua de hasta 50 metros y una garantía de 1 año por defectos de fábrica	602990	2019-05-30 11:54:14.29908	2019-05-30 11:54:14.500115	3	\N
3	FS4735IE	Reloj cronógrafo marca Fossil hecho en acero inoxidable y fabricado en China.	519990	2019-05-30 11:54:14.614621	2019-05-30 11:54:14.760573	3	\N
5	Polar M600	Un buen reloj	234300	2019-05-30 14:05:38.622954	2019-05-30 14:06:04.522203	7	15
4	T-Race T115	El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por el deporte del motor se está acelerando en el carril rápido de la moda.	2238000	2019-05-30 11:54:14.878411	2019-08-20 04:43:39.456406	4	5
\.


--
-- TOC entry 2289 (class 0 OID 21500)
-- Dependencies: 210
-- Data for Name: products_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_backup (id, name, description, price, brand_id) FROM stdin;
1	T-Race T048	El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por el deporte del motor se está acelerando en el carril rápido de la moda.	2706000	4
\.


--
-- TOC entry 2292 (class 0 OID 21569)
-- Dependencies: 213
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.purchases (id, product_id, user_id, product_price, product_discount, address, telephone, created_at, updated_at) FROM stdin;
1	\N	\N	\N	\N	Hola	3105998581	2019-08-20 05:38:40.069047	2019-08-20 05:38:40.069047
2	2	1	12	0	hola	aca	2019-08-20 05:58:31.185199	2019-08-20 05:58:31.185199
3	2	1	602990	\N	Carrera 14 #18-95	3105998581	2019-08-20 06:04:38.407704	2019-08-20 06:04:38.407704
\.


--
-- TOC entry 2275 (class 0 OID 20813)
-- Dependencies: 196
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.schema_migrations (version) FROM stdin;
20190528131543
20190528132640
20190528200602
20190528210549
20190528223317
20190528224422
20190528230021
20190529212301
20190529215814
20190820050018
\.


--
-- TOC entry 2284 (class 0 OID 20872)
-- Dependencies: 205
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, admin) FROM stdin;
1	andres.linares.971122@gmail.com	$2a$11$Ji7xxP1sDVXNFylGbi.z5OpYfJax3nb088r4hWsdEQVAXh651u5u6	\N	\N	\N	2019-05-30 11:57:49.293188	2019-08-20 04:46:57.010058	t
2	carlos.linares@unillanos.edu.co	$2a$11$zA3eET0zK2FhfOncIIsffObY30qaU5Im0hJrj2kro9jkYKTjqh3p2	\N	\N	\N	2019-08-20 04:47:21.275674	2019-08-20 04:47:21.275674	f
\.


--
-- TOC entry 2288 (class 0 OID 20906)
-- Dependencies: 209
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: andre
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
1	Product	1	create	\N	\N	2019-05-30 11:54:13.130766
2	Product	1	update	\N	---\nid: 1\nname: T-Race T048\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2706000.0\ncreated_at: 2019-05-30 11:54:13.130766000 Z\nupdated_at: 2019-05-30 11:54:13.340908000 Z\nbrand_id: 4\ndiscount: \n	2019-05-30 11:54:13.340908
3	Product	1	update	\N	---\nid: 1\nname: T-Race T048\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2706000.0\ncreated_at: 2019-05-30 11:54:13.130766000 Z\nupdated_at: 2019-05-30 11:54:14.044802000 Z\nbrand_id: 4\ndiscount: \n	2019-05-30 11:54:14.044802
4	Product	1	update	\N	---\nid: 1\nname: T-Race T048\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2706000.0\ncreated_at: 2019-05-30 11:54:13.130766000 Z\nupdated_at: 2019-05-30 11:54:14.191670000 Z\nbrand_id: 4\ndiscount: \n	2019-05-30 11:54:14.19167
5	Product	2	create	\N	\N	2019-05-30 11:54:14.29908
6	Product	2	update	\N	---\nid: 2\nname: Everyday Muse ES4062\ndescription: Reloj analogo para hombre con movimiento de cuarzo y hecho en acero inoxidable.\n  Tiene una resistencia al agua de hasta 50 metros y una garantía de 1 año por defectos\n  de fábrica\nprice: 602990.0\ncreated_at: 2019-05-30 11:54:14.299080000 Z\nupdated_at: 2019-05-30 11:54:14.354872000 Z\nbrand_id: 3\ndiscount: \n	2019-05-30 11:54:14.354872
7	Product	2	update	\N	---\nid: 2\nname: Everyday Muse ES4062\ndescription: Reloj analogo para hombre con movimiento de cuarzo y hecho en acero inoxidable.\n  Tiene una resistencia al agua de hasta 50 metros y una garantía de 1 año por defectos\n  de fábrica\nprice: 602990.0\ncreated_at: 2019-05-30 11:54:14.299080000 Z\nupdated_at: 2019-05-30 11:54:14.500115000 Z\nbrand_id: 3\ndiscount: \n	2019-05-30 11:54:14.500115
8	Product	3	create	\N	\N	2019-05-30 11:54:14.614621
9	Product	3	update	\N	---\nid: 3\nname: FS4735IE\ndescription: Reloj cronógrafo marca Fossil hecho en acero inoxidable y fabricado en\n  China.\nprice: 519990.0\ncreated_at: 2019-05-30 11:54:14.614621000 Z\nupdated_at: 2019-05-30 11:54:14.636467000 Z\nbrand_id: 3\ndiscount: \n	2019-05-30 11:54:14.636467
10	Product	3	update	\N	---\nid: 3\nname: FS4735IE\ndescription: Reloj cronógrafo marca Fossil hecho en acero inoxidable y fabricado en\n  China.\nprice: 519990.0\ncreated_at: 2019-05-30 11:54:14.614621000 Z\nupdated_at: 2019-05-30 11:54:14.760573000 Z\nbrand_id: 3\ndiscount: \n	2019-05-30 11:54:14.760573
11	Product	4	create	\N	\N	2019-05-30 11:54:14.878411
12	Product	4	update	\N	---\nid: 4\nname: T-Race T115\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2238000.0\ncreated_at: 2019-05-30 11:54:14.878411000 Z\nupdated_at: 2019-05-30 11:54:14.903038000 Z\nbrand_id: 4\ndiscount: \n	2019-05-30 11:54:14.903038
13	Product	4	update	\N	---\nid: 4\nname: T-Race T115\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2238000.0\ncreated_at: 2019-05-30 11:54:14.878411000 Z\nupdated_at: 2019-05-30 11:54:15.040444000 Z\nbrand_id: 4\ndiscount: \n	2019-05-30 11:54:15.040444
14	Product	1	update	1	---\nid: 1\nname: T-Race T048\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2706000.0\nbrand_id: 4\ndiscount: \ncreated_at: 2019-05-30 11:54:13.130766000 Z\nupdated_at: 2019-05-30 11:54:14.191670000 Z\n	2019-05-30 12:01:39.524607
15	Product	5	create	1	\N	2019-05-30 14:05:38.622954
16	Product	5	update	1	---\nid: 5\nname: Polar M600\ndescription: Un buen reloj\nprice: 234300.0\ncreated_at: 2019-05-30 14:05:38.622954000 Z\nupdated_at: 2019-05-30 14:05:38.803518000 Z\nbrand_id: 7\ndiscount: 10\n	2019-05-30 14:05:38.803518
17	Product	5	update	1	---\nid: 5\nname: Polar M600\ndescription: Un buen reloj\nprice: 234300.0\nbrand_id: 7\ndiscount: 10\ncreated_at: 2019-05-30 14:05:38.622954000 Z\nupdated_at: 2019-05-30 14:05:38.803518000 Z\n	2019-05-30 14:06:04.522203
18	Product	4	update	1	---\nid: 4\nname: T-Race T115\ndescription: El Tissot T-Race es un ganador dentro y fuera del circuito. Los detalles\n  de diseño inspirados en las carreras de bicicletas y el estilo dinámico, con una\n  pequeña dosis de colores extravagantes, ponen a estos modelos en marcha y les da\n  una posición inicial igualmente fuerte. Con Tissot T-Race, la pasión de Tissot por\n  el deporte del motor se está acelerando en el carril rápido de la moda.\nprice: 2238000.0\nbrand_id: 4\ndiscount: \ncreated_at: 2019-05-30 11:54:14.878411000 Z\nupdated_at: 2019-05-30 11:54:15.040444000 Z\n	2019-08-20 04:43:39.456406
\.


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 202
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 10, true);


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 200
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 10, true);


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 206
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.brands_id_seq', 15, true);


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 198
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.products_id_seq', 5, true);


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 212
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.purchases_id_seq', 3, true);


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 208
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andre
--

SELECT pg_catalog.setval('public.versions_id_seq', 18, true);


--
-- TOC entry 2127 (class 2606 OID 20862)
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- TOC entry 2124 (class 2606 OID 20850)
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- TOC entry 2119 (class 2606 OID 20828)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 2143 (class 2606 OID 21514)
-- Name: brand_backup brand_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand_backup
    ADD CONSTRAINT brand_backup_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 20896)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- TOC entry 2141 (class 2606 OID 21507)
-- Name: products_backup products_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_backup
    ADD CONSTRAINT products_backup_pkey PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 20839)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 21577)
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- TOC entry 2117 (class 2606 OID 20820)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 2133 (class 2606 OID 20882)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 20914)
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- TOC entry 2128 (class 1259 OID 20868)
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: andre
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- TOC entry 2129 (class 1259 OID 20869)
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: andre
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- TOC entry 2125 (class 1259 OID 20851)
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: andre
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- TOC entry 2136 (class 1259 OID 20903)
-- Name: index_brands_on_name; Type: INDEX; Schema: public; Owner: andre
--

CREATE UNIQUE INDEX index_brands_on_name ON public.brands USING btree (name);


--
-- TOC entry 2120 (class 1259 OID 20897)
-- Name: index_products_on_brand_id; Type: INDEX; Schema: public; Owner: andre
--

CREATE INDEX index_products_on_brand_id ON public.products USING btree (brand_id);


--
-- TOC entry 2144 (class 1259 OID 21588)
-- Name: index_purchases_on_product_id; Type: INDEX; Schema: public; Owner: andre
--

CREATE INDEX index_purchases_on_product_id ON public.purchases USING btree (product_id);


--
-- TOC entry 2145 (class 1259 OID 21589)
-- Name: index_purchases_on_user_id; Type: INDEX; Schema: public; Owner: andre
--

CREATE INDEX index_purchases_on_user_id ON public.purchases USING btree (user_id);


--
-- TOC entry 2130 (class 1259 OID 20883)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: andre
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- TOC entry 2131 (class 1259 OID 20884)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: andre
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- TOC entry 2137 (class 1259 OID 20915)
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: andre
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- TOC entry 2153 (class 2620 OID 21516)
-- Name: brands bd_brand_backup; Type: TRIGGER; Schema: public; Owner: andre
--

CREATE TRIGGER bd_brand_backup BEFORE DELETE ON public.brands FOR EACH ROW EXECUTE PROCEDURE public.save_brand();


--
-- TOC entry 2152 (class 2620 OID 21509)
-- Name: products bd_product_backup; Type: TRIGGER; Schema: public; Owner: andre
--

CREATE TRIGGER bd_product_backup BEFORE DELETE ON public.products FOR EACH ROW EXECUTE PROCEDURE public.save_product_backup();


--
-- TOC entry 2150 (class 2606 OID 21578)
-- Name: purchases fk_rails_0d630f0bc7; Type: FK CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_rails_0d630f0bc7 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 2151 (class 2606 OID 21583)
-- Name: purchases fk_rails_2888c5cba9; Type: FK CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT fk_rails_2888c5cba9 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2149 (class 2606 OID 20863)
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- TOC entry 2148 (class 2606 OID 20898)
-- Name: products fk_rails_f3b4d49caa; Type: FK CONSTRAINT; Schema: public; Owner: andre
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_f3b4d49caa FOREIGN KEY (brand_id) REFERENCES public.brands(id);


-- Completed on 2019-08-20 01:30:19

--
-- PostgreSQL database dump complete
--

