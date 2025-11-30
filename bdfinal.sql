--
-- PostgreSQL database dump
--

\restrict 6JaqBBelvWrwHxjFOOM0zbm08hjyjnd4b8tT6ReJnZhBFla7ufFKYmC4VdRqNpR

-- Dumped from database version 18.1 (Postgres.app)
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-29 22:35:21 -05

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16543)
-- Name: aerolinea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aerolinea (
    id_aerolinea bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    pais_origen character varying(50) NOT NULL
);


ALTER TABLE public.aerolinea OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16542)
-- Name: aerolinea_id_aerolinea_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aerolinea_id_aerolinea_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aerolinea_id_aerolinea_seq OWNER TO postgres;

--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 219
-- Name: aerolinea_id_aerolinea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aerolinea_id_aerolinea_seq OWNED BY public.aerolinea.id_aerolinea;


--
-- TOC entry 224 (class 1259 OID 16570)
-- Name: aeropuerto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeropuerto (
    id_aeropuerto bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    ciudad character varying(50) NOT NULL,
    pais character varying(50) NOT NULL,
    codigo_iata character varying(3)
);


ALTER TABLE public.aeropuerto OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16569)
-- Name: aeropuerto_id_aeropuerto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeropuerto_id_aeropuerto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeropuerto_id_aeropuerto_seq OWNER TO postgres;

--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 223
-- Name: aeropuerto_id_aeropuerto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeropuerto_id_aeropuerto_seq OWNED BY public.aeropuerto.id_aeropuerto;


--
-- TOC entry 228 (class 1259 OID 16618)
-- Name: asiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asiento (
    id_asiento bigint NOT NULL,
    id_vuelo bigint NOT NULL,
    numero_asiento character varying(5) NOT NULL,
    disponible boolean DEFAULT true
);


ALTER TABLE public.asiento OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16617)
-- Name: asiento_id_asiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asiento_id_asiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asiento_id_asiento_seq OWNER TO postgres;

--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 227
-- Name: asiento_id_asiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asiento_id_asiento_seq OWNED BY public.asiento.id_asiento;


--
-- TOC entry 222 (class 1259 OID 16553)
-- Name: avion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avion (
    id_avion bigint NOT NULL,
    modelo character varying(50) NOT NULL,
    capacidad integer NOT NULL,
    id_aerolinea bigint NOT NULL,
    CONSTRAINT avion_capacidad_check CHECK ((capacidad > 0))
);


ALTER TABLE public.avion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16552)
-- Name: avion_id_avion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avion_id_avion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avion_id_avion_seq OWNER TO postgres;

--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 221
-- Name: avion_id_avion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avion_id_avion_seq OWNED BY public.avion.id_avion;


--
-- TOC entry 230 (class 1259 OID 16636)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id_cliente bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    documento character varying(20) NOT NULL,
    correo character varying(100) NOT NULL,
    telefono character varying(20)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16635)
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 229
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_cliente_seq OWNED BY public.cliente.id_cliente;


--
-- TOC entry 234 (class 1259 OID 16681)
-- Name: pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago (
    id_pago bigint NOT NULL,
    id_reserva bigint NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(50) NOT NULL,
    fecha_pago timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pago_monto_check CHECK ((monto >= (0)::numeric))
);


ALTER TABLE public.pago OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16680)
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_id_pago_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_id_pago_seq OWNER TO postgres;

--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 233
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_id_pago_seq OWNED BY public.pago.id_pago;


--
-- TOC entry 232 (class 1259 OID 16649)
-- Name: reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reserva (
    id_reserva bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_vuelo bigint NOT NULL,
    id_asiento bigint NOT NULL,
    fecha_reserva timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    CONSTRAINT chk_reserva_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'CONFIRMADA'::character varying, 'CANCELADA'::character varying, 'PAGADA'::character varying])::text[])))
);


ALTER TABLE public.reserva OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16648)
-- Name: reserva_id_reserva_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reserva_id_reserva_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reserva_id_reserva_seq OWNER TO postgres;

--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 231
-- Name: reserva_id_reserva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reserva_id_reserva_seq OWNED BY public.reserva.id_reserva;


--
-- TOC entry 226 (class 1259 OID 16583)
-- Name: vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vuelo (
    id_vuelo bigint NOT NULL,
    codigo_vuelo character varying(10) NOT NULL,
    id_avion bigint NOT NULL,
    id_aeropuerto_origen bigint NOT NULL,
    id_aeropuerto_destino bigint NOT NULL,
    fecha_salida timestamp with time zone NOT NULL,
    fecha_llegada timestamp with time zone NOT NULL,
    estado character varying(20) DEFAULT 'PROGRAMADO'::character varying NOT NULL,
    CONSTRAINT chk_vuelo_estado CHECK (((estado)::text = ANY ((ARRAY['PROGRAMADO'::character varying, 'EN_AIRE'::character varying, 'REALIZADO'::character varying, 'CANCELADO'::character varying, 'DEMORADO'::character varying])::text[]))),
    CONSTRAINT chk_vuelo_fechas CHECK ((fecha_llegada > fecha_salida))
);


ALTER TABLE public.vuelo OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16582)
-- Name: vuelo_id_vuelo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vuelo_id_vuelo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vuelo_id_vuelo_seq OWNER TO postgres;

--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 225
-- Name: vuelo_id_vuelo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vuelo_id_vuelo_seq OWNED BY public.vuelo.id_vuelo;


--
-- TOC entry 3705 (class 2604 OID 16546)
-- Name: aerolinea id_aerolinea; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolinea ALTER COLUMN id_aerolinea SET DEFAULT nextval('public.aerolinea_id_aerolinea_seq'::regclass);


--
-- TOC entry 3707 (class 2604 OID 16573)
-- Name: aeropuerto id_aeropuerto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeropuerto ALTER COLUMN id_aeropuerto SET DEFAULT nextval('public.aeropuerto_id_aeropuerto_seq'::regclass);


--
-- TOC entry 3710 (class 2604 OID 16621)
-- Name: asiento id_asiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asiento ALTER COLUMN id_asiento SET DEFAULT nextval('public.asiento_id_asiento_seq'::regclass);


--
-- TOC entry 3706 (class 2604 OID 16556)
-- Name: avion id_avion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion ALTER COLUMN id_avion SET DEFAULT nextval('public.avion_id_avion_seq'::regclass);


--
-- TOC entry 3712 (class 2604 OID 16639)
-- Name: cliente id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('public.cliente_id_cliente_seq'::regclass);


--
-- TOC entry 3716 (class 2604 OID 16684)
-- Name: pago id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_id_pago_seq'::regclass);


--
-- TOC entry 3713 (class 2604 OID 16652)
-- Name: reserva id_reserva; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva ALTER COLUMN id_reserva SET DEFAULT nextval('public.reserva_id_reserva_seq'::regclass);


--
-- TOC entry 3708 (class 2604 OID 16586)
-- Name: vuelo id_vuelo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo ALTER COLUMN id_vuelo SET DEFAULT nextval('public.vuelo_id_vuelo_seq'::regclass);


--
-- TOC entry 3911 (class 0 OID 16543)
-- Dependencies: 220
-- Data for Name: aerolinea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aerolinea (id_aerolinea, nombre, pais_origen) FROM stdin;
1	LATAM Airlines	Chile
2	Avianca	Colombia
3	American Airlines	USA
4	Iberia	España
5	Copa Airlines	Panamá
6	Sky Airline	Chile
7	Aeroméxico	México
8	Air France	Francia
9	Lufthansa	Alemania
10	Qatar Airways	Qatar
\.


--
-- TOC entry 3915 (class 0 OID 16570)
-- Dependencies: 224
-- Data for Name: aeropuerto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeropuerto (id_aeropuerto, nombre, ciudad, pais, codigo_iata) FROM stdin;
1	Jorge Chávez	Lima	Perú	LIM
2	El Dorado	Bogotá	Colombia	BOG
3	Arturo Merino Benítez	Santiago	Chile	SCL
4	Miami International	Miami	USA	MIA
5	Adolfo Suárez Barajas	Madrid	España	MAD
6	Benito Juárez	Ciudad de México	México	MEX
7	Ezeiza	Buenos Aires	Argentina	EZE
8	John F. Kennedy	New York	USA	JFK
9	Charles de Gaulle	París	Francia	CDG
10	Guarulhos	São Paulo	Brasil	GRU
\.


--
-- TOC entry 3919 (class 0 OID 16618)
-- Dependencies: 228
-- Data for Name: asiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asiento (id_asiento, id_vuelo, numero_asiento, disponible) FROM stdin;
2	1	1B	f
3	1	1C	f
4	1	2A	f
5	1	2B	f
6	1	2C	f
7	1	3A	f
8	1	3B	f
9	1	3C	t
10	1	4A	t
1	1	1A	f
\.


--
-- TOC entry 3913 (class 0 OID 16553)
-- Dependencies: 222
-- Data for Name: avion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.avion (id_avion, modelo, capacidad, id_aerolinea) FROM stdin;
1	Airbus A320	180	1
2	Boeing 787 Dreamliner	250	2
3	Boeing 737 MAX	160	3
4	Airbus A350	300	4
5	Boeing 737-800	160	5
6	Airbus A320neo	186	6
7	Boeing 787-9	270	7
8	Airbus A380	500	8
9	Boeing 747-8	400	9
10	Airbus A350-1000	350	10
\.


--
-- TOC entry 3921 (class 0 OID 16636)
-- Dependencies: 230
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id_cliente, nombre, documento, correo, telefono) FROM stdin;
1	Juan Pérez	DOC001	juan.perez@email.com	999888777
2	Maria Lopez	DOC002	maria.lopez@email.com	999111222
3	Carlos Ruiz	DOC003	carlos.ruiz@email.com	987654321
4	Ana Torres	DOC004	ana.torres@email.com	955444333
5	Luis Gomez	DOC005	luis.gomez@email.com	944333222
6	Elena Diaz	DOC006	elena.diaz@email.com	933222111
7	Pedro Silva	DOC007	pedro.silva@email.com	922111000
8	Lucia Jara	DOC008	lucia.jara@email.com	911000999
9	Jorge Rios	DOC009	jorge.rios@email.com	900999888
10	Sofia Paz	DOC010	sofia.paz@email.com	999777666
\.


--
-- TOC entry 3925 (class 0 OID 16681)
-- Dependencies: 234
-- Data for Name: pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pago (id_pago, id_reserva, monto, metodo_pago, fecha_pago) FROM stdin;
1	1	250.00	TARJETA_CREDITO	2025-11-29 17:22:55.208275-05
2	2	250.00	PAYPAL	2025-11-29 17:22:55.208275-05
3	3	250.00	TARJETA_DEBITO	2025-11-29 17:22:55.208275-05
4	4	250.00	TRANSFERENCIA	2025-11-29 17:22:55.208275-05
5	8	250.00	TARJETA_CREDITO	2025-11-29 17:22:55.208275-05
\.


--
-- TOC entry 3923 (class 0 OID 16649)
-- Dependencies: 232
-- Data for Name: reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reserva (id_reserva, id_cliente, id_vuelo, id_asiento, fecha_reserva, estado) FROM stdin;
1	1	1	1	2025-11-29 17:22:55.208275-05	CONFIRMADA
2	2	1	2	2025-11-29 17:22:55.208275-05	CONFIRMADA
3	3	1	3	2025-11-29 17:22:55.208275-05	CONFIRMADA
4	4	1	4	2025-11-29 17:22:55.208275-05	CONFIRMADA
5	5	1	5	2025-11-29 17:22:55.208275-05	PENDIENTE
6	6	1	6	2025-11-29 17:22:55.208275-05	PENDIENTE
7	7	1	7	2025-11-29 17:22:55.208275-05	CANCELADA
8	8	1	8	2025-11-29 17:22:55.208275-05	CONFIRMADA
9	9	1	9	2025-11-29 17:22:55.208275-05	PENDIENTE
10	10	1	10	2025-11-29 17:22:55.208275-05	PENDIENTE
\.


--
-- TOC entry 3917 (class 0 OID 16583)
-- Dependencies: 226
-- Data for Name: vuelo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vuelo (id_vuelo, codigo_vuelo, id_avion, id_aeropuerto_origen, id_aeropuerto_destino, fecha_salida, fecha_llegada, estado) FROM stdin;
1	LA2400	1	1	4	2023-11-01 08:00:00-05	2023-11-01 15:00:00-05	PROGRAMADO
2	AV0120	2	2	5	2023-11-02 10:00:00-05	2023-11-03 04:00:00-05	PROGRAMADO
3	AA0980	3	4	1	2023-11-03 14:00:00-05	2023-11-03 21:00:00-05	PROGRAMADO
4	IB6400	4	1	5	2023-11-04 19:00:00-05	2023-11-05 13:00:00-05	PROGRAMADO
5	CM0300	5	1	2	2023-11-05 06:00:00-05	2023-11-05 09:00:00-05	PROGRAMADO
6	SK0500	6	3	1	2023-11-06 07:00:00-05	2023-11-06 10:00:00-05	PROGRAMADO
7	AM0020	7	6	4	2023-11-07 12:00:00-05	2023-11-07 16:00:00-05	PROGRAMADO
8	AF0450	8	9	8	2023-11-08 08:00:00-05	2023-11-08 11:00:00-05	PROGRAMADO
9	LH0100	9	9	10	2023-11-09 22:00:00-05	2023-11-10 09:00:00-05	PROGRAMADO
10	QR0700	10	10	5	2023-11-10 15:00:00-05	2023-11-11 06:00:00-05	PROGRAMADO
\.


--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 219
-- Name: aerolinea_id_aerolinea_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aerolinea_id_aerolinea_seq', 10, true);


--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 223
-- Name: aeropuerto_id_aeropuerto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeropuerto_id_aeropuerto_seq', 10, true);


--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 227
-- Name: asiento_id_asiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asiento_id_asiento_seq', 10, true);


--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 221
-- Name: avion_id_avion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avion_id_avion_seq', 10, true);


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 229
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_cliente_seq', 10, true);


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 233
-- Name: pago_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_id_pago_seq', 5, true);


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 231
-- Name: reserva_id_reserva_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reserva_id_reserva_seq', 12, true);


--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 225
-- Name: vuelo_id_vuelo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vuelo_id_vuelo_seq', 10, true);


--
-- TOC entry 3724 (class 2606 OID 16551)
-- Name: aerolinea aerolinea_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolinea
    ADD CONSTRAINT aerolinea_pkey PRIMARY KEY (id_aerolinea);


--
-- TOC entry 3728 (class 2606 OID 16581)
-- Name: aeropuerto aeropuerto_codigo_iata_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeropuerto
    ADD CONSTRAINT aeropuerto_codigo_iata_key UNIQUE (codigo_iata);


--
-- TOC entry 3730 (class 2606 OID 16579)
-- Name: aeropuerto aeropuerto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeropuerto
    ADD CONSTRAINT aeropuerto_pkey PRIMARY KEY (id_aeropuerto);


--
-- TOC entry 3737 (class 2606 OID 16629)
-- Name: asiento asiento_id_vuelo_numero_asiento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asiento
    ADD CONSTRAINT asiento_id_vuelo_numero_asiento_key UNIQUE (id_vuelo, numero_asiento);


--
-- TOC entry 3739 (class 2606 OID 16627)
-- Name: asiento asiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asiento
    ADD CONSTRAINT asiento_pkey PRIMARY KEY (id_asiento);


--
-- TOC entry 3726 (class 2606 OID 16563)
-- Name: avion avion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT avion_pkey PRIMARY KEY (id_avion);


--
-- TOC entry 3742 (class 2606 OID 16647)
-- Name: cliente cliente_documento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_documento_key UNIQUE (documento);


--
-- TOC entry 3744 (class 2606 OID 16645)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 3751 (class 2606 OID 16694)
-- Name: pago pago_id_reserva_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_reserva_key UNIQUE (id_reserva);


--
-- TOC entry 3753 (class 2606 OID 16692)
-- Name: pago pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 3747 (class 2606 OID 16662)
-- Name: reserva reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_pkey PRIMARY KEY (id_reserva);


--
-- TOC entry 3749 (class 2606 OID 16664)
-- Name: reserva uq_reserva_asiento_activa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT uq_reserva_asiento_activa UNIQUE (id_asiento, id_vuelo);


--
-- TOC entry 3733 (class 2606 OID 16601)
-- Name: vuelo vuelo_codigo_vuelo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_codigo_vuelo_key UNIQUE (codigo_vuelo);


--
-- TOC entry 3735 (class 2606 OID 16599)
-- Name: vuelo vuelo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_pkey PRIMARY KEY (id_vuelo);


--
-- TOC entry 3740 (class 1259 OID 16701)
-- Name: idx_asiento_disponibilidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asiento_disponibilidad ON public.asiento USING btree (id_vuelo) WHERE (disponible = true);


--
-- TOC entry 3745 (class 1259 OID 16702)
-- Name: idx_reserva_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reserva_cliente ON public.reserva USING btree (id_cliente);


--
-- TOC entry 3731 (class 1259 OID 16700)
-- Name: idx_vuelo_busqueda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vuelo_busqueda ON public.vuelo USING btree (fecha_salida, id_aeropuerto_origen, id_aeropuerto_destino);


--
-- TOC entry 3758 (class 2606 OID 16630)
-- Name: asiento asiento_id_vuelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asiento
    ADD CONSTRAINT asiento_id_vuelo_fkey FOREIGN KEY (id_vuelo) REFERENCES public.vuelo(id_vuelo) ON DELETE CASCADE;


--
-- TOC entry 3754 (class 2606 OID 16564)
-- Name: avion avion_id_aerolinea_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT avion_id_aerolinea_fkey FOREIGN KEY (id_aerolinea) REFERENCES public.aerolinea(id_aerolinea);


--
-- TOC entry 3762 (class 2606 OID 16695)
-- Name: pago pago_id_reserva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);


--
-- TOC entry 3759 (class 2606 OID 16675)
-- Name: reserva reserva_id_asiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_asiento_fkey FOREIGN KEY (id_asiento) REFERENCES public.asiento(id_asiento);


--
-- TOC entry 3760 (class 2606 OID 16665)
-- Name: reserva reserva_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id_cliente);


--
-- TOC entry 3761 (class 2606 OID 16670)
-- Name: reserva reserva_id_vuelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_vuelo_fkey FOREIGN KEY (id_vuelo) REFERENCES public.vuelo(id_vuelo);


--
-- TOC entry 3755 (class 2606 OID 16612)
-- Name: vuelo vuelo_id_aeropuerto_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_id_aeropuerto_destino_fkey FOREIGN KEY (id_aeropuerto_destino) REFERENCES public.aeropuerto(id_aeropuerto);


--
-- TOC entry 3756 (class 2606 OID 16607)
-- Name: vuelo vuelo_id_aeropuerto_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_id_aeropuerto_origen_fkey FOREIGN KEY (id_aeropuerto_origen) REFERENCES public.aeropuerto(id_aeropuerto);


--
-- TOC entry 3757 (class 2606 OID 16602)
-- Name: vuelo vuelo_id_avion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT vuelo_id_avion_fkey FOREIGN KEY (id_avion) REFERENCES public.avion(id_avion);


-- Completed on 2025-11-29 22:35:21 -05

--
-- PostgreSQL database dump complete
--

\unrestrict 6JaqBBelvWrwHxjFOOM0zbm08hjyjnd4b8tT6ReJnZhBFla7ufFKYmC4VdRqNpR

