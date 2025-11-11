--
-- PostgreSQL database dump
--

\restrict 5Pagf0CroeS8frE09Ne5kOfmMcZZECoPRHO0nMqYK4QA7JHanC9odBvMg6n9FIW

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chapters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chapters (
    id text NOT NULL,
    novel_id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.chapters OWNER TO postgres;

--
-- Name: check_chapter_access(public.chapters); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_chapter_access(chapter_row public.chapters) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$

DECLARE

  novel_owner_id UUID;

  is_collaborator BOOLEAN;

BEGIN

  -- 1. R├®cup├¿re l'ID du propri├®taire (contourne RLS gr├óce ├á SECURITY DEFINER)

  SELECT user_id INTO novel_owner_id

  FROM public.novels

  WHERE id = chapter_row.novel_id;



  -- 2. V├®rifie si l'utilisateur actuel est le propri├®taire

  IF auth.uid() = novel_owner_id THEN

    RETURN TRUE;

  END IF;

  

  -- 3. V├®rifie si l'utilisateur actuel est un collaborateur

  SELECT EXISTS (

    SELECT 1

    FROM public.novel_collaborators

    WHERE novel_id = chapter_row.novel_id

    AND collaborator_id = auth.uid()

  ) INTO is_collaborator;

  

  IF is_collaborator THEN

    RETURN TRUE;

  END IF;

  

  -- 4. V├®rifie si l'utilisateur est un admin

  IF public.is_admin() THEN

    RETURN TRUE;

  END IF;



  RETURN FALSE;

END;

$$;


ALTER FUNCTION public.check_chapter_access(chapter_row public.chapters) OWNER TO postgres;

--
-- Name: novel_collaborators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.novel_collaborators (
    novel_id text NOT NULL,
    collaborator_id uuid NOT NULL,
    role text DEFAULT 'reader'::text NOT NULL,
    invited_at timestamp with time zone DEFAULT now(),
    CONSTRAINT novel_collaborators_role_check CHECK ((role = ANY (ARRAY['reader'::text, 'co-author'::text])))
);


ALTER TABLE public.novel_collaborators OWNER TO postgres;

--
-- Name: check_collaborator_policy_access(public.novel_collaborators); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_collaborator_policy_access(collaborator_row public.novel_collaborators) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$

DECLARE

  novel_owner_id UUID;

  is_current_user_a_collaborator BOOLEAN;

BEGIN

  -- 1. Les admins voient tout

  IF public.is_admin() THEN

    RETURN TRUE;

  END IF;



  -- 2. R├®cup├¿re l'ID du propri├®taire (s├®curis├® car SECURITY DEFINER)

  SELECT n.user_id INTO novel_owner_id

  FROM public.novels n

  WHERE n.id = collaborator_row.novel_id;



  -- 3. Le propri├®taire voit les collaborateurs de SON roman

  IF auth.uid() = novel_owner_id THEN

    RETURN TRUE;

  END IF;



  -- 4. V├®rifie si l'utilisateur ACTUEL (celui qui fait la requ├¬te)

  --    est LUI-MEME un collaborateur de CE roman sp├®cifique

  SELECT EXISTS (

    SELECT 1

    FROM public.novel_collaborators nc -- Requ├¬te directe, s├®curis├®e dans SECURITY DEFINER

    WHERE nc.novel_id = collaborator_row.novel_id -- Pour ce roman pr├®cis

    AND nc.collaborator_id = auth.uid()        -- Si l'utilisateur actuel est list├®

  ) INTO is_current_user_a_collaborator;



  IF is_current_user_a_collaborator THEN

      -- Les collaborateurs peuvent voir la liste du roman auquel ils participent

      RETURN TRUE;

  END IF;



  -- Sinon (ni admin, ni proprio, ni collaborateur de CE roman), acc├¿s refus├®

  RETURN FALSE;

END;

$$;


ALTER FUNCTION public.check_collaborator_policy_access(collaborator_row public.novel_collaborators) OWNER TO postgres;

--
-- Name: get_collaborators_for_novel(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_collaborators_for_novel(p_novel_id uuid) RETURNS TABLE(id uuid, first_name text, last_name text, email text)
    LANGUAGE sql SECURITY DEFINER
    AS $$

  select

    p.id,

    p.first_name,

    p.last_name,

    p.email

  from profiles p

  join novel_collaborators nc on nc.collaborator_id = p.id

  -- CORRECTION ICI :

  where nc.novel_id = p_novel_id::text;

$$;


ALTER FUNCTION public.get_collaborators_for_novel(p_novel_id uuid) OWNER TO postgres;

--
-- Name: get_friends(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_friends() RETURNS TABLE(id uuid, first_name text, last_name text, email text)
    LANGUAGE sql SECURITY DEFINER
    AS $$

  select

    p.id,

    p.first_name,

    p.last_name,

    p.email

  from public.profiles p

  join public.friendships f on

    -- Soit je suis user_id_1 et p est user_id_2

    (f.user_id_1 = auth.uid() and f.user_id_2 = p.id) or

    -- Soit je suis user_id_2 et p est user_id_1

    (f.user_id_2 = auth.uid() and f.user_id_1 = p.id)

  where

    f.status = 'accepted';

$$;


ALTER FUNCTION public.get_friends() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

BEGIN

  INSERT INTO public.profiles (id, email, first_name, last_name, is_vip, status, created_at, updated_at)

  VALUES (

    NEW.id,

    NEW.email,

    COALESCE(NEW.raw_user_meta_data->>'first_name', ''),

    COALESCE(NEW.raw_user_meta_data->>'last_name', ''),

    FALSE, -- is_vip par d├®faut ├á false

    'pending', -- status par d├®faut ├á pending

    NOW(),

    NOW()

  );

  RETURN NEW;

END;

$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: handle_user_email_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_user_email_update() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

BEGIN

  UPDATE public.profiles SET email = new.email WHERE id = new.id;

  RETURN new;

END;

$$;


ALTER FUNCTION public.handle_user_email_update() OWNER TO postgres;

--
-- Name: is_admin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$

BEGIN

  RETURN EXISTS (SELECT 1 FROM public.profiles WHERE public.profiles.id = auth.uid() AND public.profiles.is_admin = TRUE);

END;

$$;


ALTER FUNCTION public.is_admin() OWNER TO postgres;

--
-- Name: send_friend_request(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.send_friend_request(invitee_email text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

declare

  invitee_id uuid;

  requester_id uuid := auth.uid();

begin

  -- 1. Trouver l'ID de l'invit├® ├á partir de son email

  select id into invitee_id from public.profiles where email = invitee_email;



  -- 2. G├®rer les erreurs

  if invitee_id is null then

    raise exception 'User with that email does not exist.';

  end if;



  if invitee_id = requester_id then

    raise exception 'You cannot send a friend request to yourself.';

  end if;



  -- 3. V├®rifier si une relation existe d├®j├á (dans n'importe quelle direction)

  if exists (

    select 1 from public.friendships

    where (user_id_1 = requester_id and user_id_2 = invitee_id)

       or (user_id_1 = invitee_id and user_id_2 = requester_id)

  ) then

    raise exception 'A friend request or friendship already exists.';

  end if;



  -- 4. Cr├®er la demande en attente

  -- Convention : user_id_1 est le demandeur

  insert into public.friendships(user_id_1, user_id_2, status, requester_id)

  values (requester_id, invitee_id, 'pending', requester_id);

end;

$$;


ALTER FUNCTION public.send_friend_request(invitee_email text) OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN NEW.updated_at = NOW(); RETURN NEW; END;

$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEWÔêÆOLD (added paths) and OLDÔêÆNEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEWÔêÆOLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLDÔêÆNEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    user_email text NOT NULL,
    feedback_type text NOT NULL,
    message text NOT NULL,
    additional_info text,
    status text DEFAULT 'unread'::text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    CONSTRAINT feedbacks_status_check CHECK ((status = ANY (ARRAY['unread'::text, 'read'::text])))
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- Name: friendships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendships (
    user_id_1 uuid NOT NULL,
    user_id_2 uuid NOT NULL,
    status text NOT NULL,
    requester_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT enforce_user_order CHECK (((user_id_1)::text < (user_id_2)::text)),
    CONSTRAINT friendships_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'accepted'::text, 'blocked'::text])))
);


ALTER TABLE public.friendships OWNER TO postgres;

--
-- Name: novels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.novels (
    id text NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    level text NOT NULL,
    genre text NOT NULL,
    specifications text,
    language text DEFAULT 'Japonais'::text NOT NULL,
    cover_image_path text,
    roadmap text,
    model_id text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    summaries jsonb,
    future_outline text,
    is_dynamic_outline boolean DEFAULT true
);


ALTER TABLE public.novels OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    is_admin boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    email text,
    is_vip boolean DEFAULT false,
    CONSTRAINT profiles_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text])))
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: COLUMN profiles.is_vip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.is_vip IS 'Indique si l''utilisateur a un statut VIP';


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	91e755b6-b240-4237-8b5c-95df0f2d4bc9	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"nathangrondin683@gmail.com","user_id":"a4f97776-a1e7-4478-b546-32995006d8aa","user_phone":""}}	2025-10-17 17:16:37.107057+00	
00000000-0000-0000-0000-000000000000	655a494b-d8aa-483b-a4b0-34ba5728e116	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:16:47.564194+00	
00000000-0000-0000-0000-000000000000	8d333992-d1fb-4bd6-ad34-819b9caec9c7	{"action":"logout","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-17 17:18:02.909828+00	
00000000-0000-0000-0000-000000000000	9a3c1a01-30df-4847-a3c0-fcea8fcc3c0f	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:18:15.208643+00	
00000000-0000-0000-0000-000000000000	1ce09f7b-d309-466c-84a9-fc2a39d243ce	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:33:30.018851+00	
00000000-0000-0000-0000-000000000000	3eddc2d7-257d-464f-b96d-9d9a95008a51	{"action":"logout","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-17 17:36:23.422536+00	
00000000-0000-0000-0000-000000000000	ed689e7e-0b06-4bd4-a21b-82f50d666ac6	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:39:17.986331+00	
00000000-0000-0000-0000-000000000000	f851611c-6f01-49bd-a5a6-caf4207eb99e	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:42:26.127506+00	
00000000-0000-0000-0000-000000000000	7a21d91c-bdaa-4a24-94e5-b822bc13ee55	{"action":"logout","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-17 17:42:30.304105+00	
00000000-0000-0000-0000-000000000000	af6c96ec-4380-4fa1-900d-4f500a448719	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 17:43:31.707927+00	
00000000-0000-0000-0000-000000000000	9837f78a-bc51-46bc-9070-12fbd60a8eda	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 18:08:51.842897+00	
00000000-0000-0000-0000-000000000000	eea66282-9c15-40dc-8add-90f14399c825	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 18:12:35.761266+00	
00000000-0000-0000-0000-000000000000	b741c2a7-a5ba-4705-9fdb-e256a08ace55	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 18:17:49.368839+00	
00000000-0000-0000-0000-000000000000	d66ff49a-6987-415f-8425-d4e2d91ed8fe	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 18:30:27.755304+00	
00000000-0000-0000-0000-000000000000	641dd394-1839-42c7-bca5-81f445ca698e	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 18:33:00.245046+00	
00000000-0000-0000-0000-000000000000	4ca20476-aaf8-445a-a0d6-618e58ba6bdc	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 20:25:53.341019+00	
00000000-0000-0000-0000-000000000000	a4cb889b-6985-4af6-ba3c-911e97698db8	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 20:52:02.498503+00	
00000000-0000-0000-0000-000000000000	96a41b25-be65-433c-90d4-9d6ea0d6f8f6	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 20:55:02.651527+00	
00000000-0000-0000-0000-000000000000	881698f5-e411-42a2-8c32-2da0b8711a75	{"action":"token_refreshed","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 21:25:23.034421+00	
00000000-0000-0000-0000-000000000000	16b5b923-3359-4e01-a9ca-cf16d48f6443	{"action":"token_revoked","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 21:25:23.047177+00	
00000000-0000-0000-0000-000000000000	2e598fd4-07c6-4886-8da1-5b2f67844be7	{"action":"token_refreshed","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 22:25:04.02326+00	
00000000-0000-0000-0000-000000000000	fe66e0e3-5483-4a8a-8268-549a0b619e4a	{"action":"token_revoked","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 22:25:04.031932+00	
00000000-0000-0000-0000-000000000000	f517919b-b0da-4ad0-93a7-1a9a9578a15f	{"action":"user_invited","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"eac19304-d67e-482f-a0e2-b02ea693612b"}}	2025-10-17 22:28:58.019652+00	
00000000-0000-0000-0000-000000000000	952469ac-d371-4b56-b5fd-85f1b9d56a3d	{"action":"user_signedup","actor_id":"eac19304-d67e-482f-a0e2-b02ea693612b","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-17 22:29:12.438613+00	
00000000-0000-0000-0000-000000000000	8b4a3a39-ebcd-4547-b93e-f54b9b7457c6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"eac19304-d67e-482f-a0e2-b02ea693612b","user_phone":""}}	2025-10-17 22:30:12.349177+00	
00000000-0000-0000-0000-000000000000	d1ce86d2-f410-4a05-b11a-1eaadcb26d46	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 22:49:54.915056+00	
00000000-0000-0000-0000-000000000000	0802f530-8225-4a79-b8fd-9ee18a1e4079	{"action":"logout","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-17 22:52:37.775828+00	
00000000-0000-0000-0000-000000000000	5f4eb70a-50b1-412c-b1e8-1e026676720e	{"action":"login","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-17 22:55:01.096572+00	
00000000-0000-0000-0000-000000000000	57ba3c68-4762-4405-834a-fcf7b58fa3b7	{"action":"user_confirmation_requested","actor_id":"16df2e2f-3bb5-4eb9-9202-7dee8e747049","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:17:33.393962+00	
00000000-0000-0000-0000-000000000000	14eec630-b70f-4ea6-962f-c1ecfd738790	{"action":"user_confirmation_requested","actor_id":"16df2e2f-3bb5-4eb9-9202-7dee8e747049","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:18:33.51499+00	
00000000-0000-0000-0000-000000000000	1d4746ec-1aff-47c8-8e72-d43beb5831c4	{"action":"user_confirmation_requested","actor_id":"16df2e2f-3bb5-4eb9-9202-7dee8e747049","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:19:34.658558+00	
00000000-0000-0000-0000-000000000000	962ea5f3-9c62-4844-bc2b-8f8768b43479	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"16df2e2f-3bb5-4eb9-9202-7dee8e747049","user_phone":""}}	2025-10-17 23:24:05.970438+00	
00000000-0000-0000-0000-000000000000	66031423-2d2c-485a-b19b-0ee94445be55	{"action":"user_confirmation_requested","actor_id":"ff39ae1d-7437-4ec2-b6c6-15c8a9fd1328","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:24:11.731377+00	
00000000-0000-0000-0000-000000000000	38d5c9fc-3c4b-4e02-a65b-f45e5a9333f8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"ff39ae1d-7437-4ec2-b6c6-15c8a9fd1328","user_phone":""}}	2025-10-17 23:24:38.387873+00	
00000000-0000-0000-0000-000000000000	f2d4df1b-9565-4074-94e4-11b31e304014	{"action":"user_confirmation_requested","actor_id":"80c3cc7a-6edf-472c-8e01-0102c2d239c9","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:25:26.914934+00	
00000000-0000-0000-0000-000000000000	00060d96-413c-477a-9ed6-b29beed8c6fa	{"action":"user_confirmation_requested","actor_id":"80c3cc7a-6edf-472c-8e01-0102c2d239c9","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:27:50.626269+00	
00000000-0000-0000-0000-000000000000	e877353f-7a09-4ef4-9ca9-873204b2228f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"80c3cc7a-6edf-472c-8e01-0102c2d239c9","user_phone":""}}	2025-10-17 23:35:08.303901+00	
00000000-0000-0000-0000-000000000000	6bdad09e-e918-4c3e-8907-c8db62137f7b	{"action":"user_confirmation_requested","actor_id":"c7db5746-113c-4d7a-94a2-6157cea871bb","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:35:59.085474+00	
00000000-0000-0000-0000-000000000000	db14da9a-5433-4ee0-bab2-67bffae87f34	{"action":"user_signedup","actor_id":"c7db5746-113c-4d7a-94a2-6157cea871bb","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-17 23:36:06.197676+00	
00000000-0000-0000-0000-000000000000	562e929b-dd8f-44f9-a679-b0160619a6f7	{"action":"user_repeated_signup","actor_id":"c7db5746-113c-4d7a-94a2-6157cea871bb","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:38:42.80097+00	
00000000-0000-0000-0000-000000000000	e37eda69-fe85-4f51-b3be-865220c3070b	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"c7db5746-113c-4d7a-94a2-6157cea871bb","user_phone":""}}	2025-10-17 23:39:20.214143+00	
00000000-0000-0000-0000-000000000000	d8563502-0f54-4883-9961-2f7904ecaf2e	{"action":"user_confirmation_requested","actor_id":"59df146e-e6f4-4bb9-8c65-4165b6993b95","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:39:22.186192+00	
00000000-0000-0000-0000-000000000000	bec62f2b-0834-43fc-9c6b-65603ebe8a97	{"action":"user_signedup","actor_id":"59df146e-e6f4-4bb9-8c65-4165b6993b95","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-17 23:39:32.596112+00	
00000000-0000-0000-0000-000000000000	900cf91e-0d21-4e94-b140-02155049a0c8	{"action":"token_refreshed","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 23:39:35.765089+00	
00000000-0000-0000-0000-000000000000	24a04df7-f038-479b-ae6b-6913646a38a1	{"action":"token_revoked","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-17 23:39:35.766066+00	
00000000-0000-0000-0000-000000000000	2af8192a-ac37-4c04-8f71-8ac796b86711	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"59df146e-e6f4-4bb9-8c65-4165b6993b95","user_phone":""}}	2025-10-17 23:49:23.514506+00	
00000000-0000-0000-0000-000000000000	02df0485-c2bb-483a-a03d-61786de13323	{"action":"user_confirmation_requested","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:49:35.580055+00	
00000000-0000-0000-0000-000000000000	73b6c872-768e-4950-bba9-c17683724a5b	{"action":"user_signedup","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-17 23:50:19.941762+00	
00000000-0000-0000-0000-000000000000	daf2ddce-ca8e-4129-aa5e-3d8c275cdb40	{"action":"user_repeated_signup","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:52:47.88331+00	
00000000-0000-0000-0000-000000000000	807ddbfa-239d-4d08-9862-507c36a94a5a	{"action":"user_repeated_signup","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:53:01.247132+00	
00000000-0000-0000-0000-000000000000	56c4ab13-b38c-4ad7-a83e-a34d7ea2d24f	{"action":"user_repeated_signup","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:53:55.767815+00	
00000000-0000-0000-0000-000000000000	5ddea4a9-77ce-4d74-8013-e145413afa63	{"action":"user_repeated_signup","actor_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-17 23:57:08.887779+00	
00000000-0000-0000-0000-000000000000	9622eaa9-48c0-4f19-8d7a-269277d19227	{"action":"user_confirmation_requested","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 00:07:20.482019+00	
00000000-0000-0000-0000-000000000000	30192aaa-b902-4f43-ac9e-1a74add2c994	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"45d15cac-7142-4e80-b6fb-244c261c69a2","user_phone":""}}	2025-10-18 00:07:56.678423+00	
00000000-0000-0000-0000-000000000000	51f3d4b2-3522-43a3-aaa1-ed82057ddc0f	{"action":"user_signedup","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 00:11:27.4403+00	
00000000-0000-0000-0000-000000000000	dc519744-d99e-4e04-a1d7-394100ea7e29	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"email"}}	2025-10-18 00:11:28.188261+00	
00000000-0000-0000-0000-000000000000	2588eaeb-5582-40c9-ae4e-f6ab9a5433f9	{"action":"logout","actor_id":"a4f97776-a1e7-4478-b546-32995006d8aa","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:12:51.076013+00	
00000000-0000-0000-0000-000000000000	491d16e8-0718-4873-bfdb-22f83cbeafbf	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:13:20.039245+00	
00000000-0000-0000-0000-000000000000	42532464-7f56-443d-b9a9-77ed16bba7ae	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:13:52.506508+00	
00000000-0000-0000-0000-000000000000	c4d9088f-e2f1-468a-9199-16e573369d33	{"action":"user_confirmation_requested","actor_id":"67679597-a41c-4bb9-95ca-d535a0e643c9","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 00:14:09.674658+00	
00000000-0000-0000-0000-000000000000	53b0bba4-9a81-4d86-909d-7e72a562544c	{"action":"user_signedup","actor_id":"67679597-a41c-4bb9-95ca-d535a0e643c9","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 00:15:29.272393+00	
00000000-0000-0000-0000-000000000000	b1577211-e10f-4752-a0bb-3492671fd04b	{"action":"login","actor_id":"67679597-a41c-4bb9-95ca-d535a0e643c9","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"email"}}	2025-10-18 00:15:29.842716+00	
00000000-0000-0000-0000-000000000000	f26dbea8-6052-4b93-998e-40f49db8b731	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"67679597-a41c-4bb9-95ca-d535a0e643c9","user_phone":""}}	2025-10-18 00:17:00.337396+00	
00000000-0000-0000-0000-000000000000	fc305dae-f9cf-43f7-9e72-c52186fef85c	{"action":"user_signedup","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 00:23:23.985108+00	
00000000-0000-0000-0000-000000000000	2d4b7722-5cae-4c86-9cde-9b5a38c07044	{"action":"login","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:23:23.989085+00	
00000000-0000-0000-0000-000000000000	e17408b3-89e4-449a-b6e8-35066ddce277	{"action":"logout","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:34:41.973908+00	
00000000-0000-0000-0000-000000000000	d3fb880b-5416-4b78-8cd9-6dd8a0538a85	{"action":"login","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:35:03.612406+00	
00000000-0000-0000-0000-000000000000	5cd00317-55d5-4aab-b579-a17ee438a6cb	{"action":"logout","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:35:03.805376+00	
00000000-0000-0000-0000-000000000000	529b91da-da76-439a-a509-722326904f34	{"action":"login","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:35:14.730998+00	
00000000-0000-0000-0000-000000000000	c42f8803-3046-4cd3-86b6-56b6d24b3a3b	{"action":"logout","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:36:17.337695+00	
00000000-0000-0000-0000-000000000000	9fa6728e-cd55-4d03-9a15-3888711d91c0	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:36:29.004566+00	
00000000-0000-0000-0000-000000000000	8494a91d-a40f-44c7-be3a-ad6f948ae9fe	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:36:40.294771+00	
00000000-0000-0000-0000-000000000000	f67ebcc0-5f60-4b56-8ca1-cf67e6b1a626	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:36:51.339582+00	
00000000-0000-0000-0000-000000000000	4f68dd62-72c6-4d79-8080-a356be3c2f1f	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 00:36:54.100509+00	
00000000-0000-0000-0000-000000000000	8b925bd7-829a-4518-ae4a-48f4a5bd19b2	{"action":"login","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:37:06.005482+00	
00000000-0000-0000-0000-000000000000	bd74c787-c1d0-41f5-9679-119b5ea87574	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:10:18.854409+00	
00000000-0000-0000-0000-000000000000	a908cbea-8654-4e3b-aee2-ed6d4c5422a4	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"a4f97776-a1e7-4478-b546-32995006d8aa","user_phone":""}}	2025-10-18 00:45:01.511348+00	
00000000-0000-0000-0000-000000000000	f754117e-8711-4ff9-bedb-f51a1019ef19	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:51:10.279892+00	
00000000-0000-0000-0000-000000000000	6b4bc1a1-58be-4e00-9059-d5fbd0ea8683	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 00:52:42.2948+00	
00000000-0000-0000-0000-000000000000	e462a6f1-7283-4956-b598-7f1489e60827	{"action":"token_refreshed","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 08:28:32.25368+00	
00000000-0000-0000-0000-000000000000	648e636c-3104-45c7-908a-13c692953c52	{"action":"token_revoked","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 08:28:32.281022+00	
00000000-0000-0000-0000-000000000000	11325ce5-0f3a-46fd-bd7b-ea6f4dc87f3d	{"action":"logout","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 08:28:33.117317+00	
00000000-0000-0000-0000-000000000000	6158171c-2d6c-44c8-835e-19f2767c5790	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 08:52:10.204363+00	
00000000-0000-0000-0000-000000000000	651c47e5-5b1f-444f-b47d-9142017ee5b8	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 08:52:17.144125+00	
00000000-0000-0000-0000-000000000000	b00ca02d-3c53-4ad2-9caa-889e6ceab6f4	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:00:47.336909+00	
00000000-0000-0000-0000-000000000000	c924b847-9b64-43e1-b516-83cf3e24d59b	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:00:51.263935+00	
00000000-0000-0000-0000-000000000000	5b35e334-3165-456b-8857-4a1d222add55	{"action":"user_repeated_signup","actor_id":"b30401cb-95ca-447e-b668-7e58625a5552","actor_username":"nathangrondin681@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-18 09:01:09.900062+00	
00000000-0000-0000-0000-000000000000	58da97cc-75d1-4afd-a542-ca4e206cbefc	{"action":"user_signedup","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-18 09:01:51.707412+00	
00000000-0000-0000-0000-000000000000	78a87390-bf24-468b-baba-61af5502ac71	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:01:51.712307+00	
00000000-0000-0000-0000-000000000000	b4110d7c-452e-4f73-8a48-09b3370557a9	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:01:52.071846+00	
00000000-0000-0000-0000-000000000000	04482a46-2ab8-4e47-9f4b-980b9da65247	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:02:28.150551+00	
00000000-0000-0000-0000-000000000000	99e02f3d-6740-4bfd-842d-17a7d3237ab1	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:02:28.311056+00	
00000000-0000-0000-0000-000000000000	f664716b-da40-4a0b-b93b-47525f783f76	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:02:47.517822+00	
00000000-0000-0000-0000-000000000000	8a722037-25ea-4ed7-a300-c3b0dab44700	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:02:47.7132+00	
00000000-0000-0000-0000-000000000000	74367c61-e50c-43b2-800a-219c8ffc9b16	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:02:55.858259+00	
00000000-0000-0000-0000-000000000000	1bd53e72-8818-4e5a-af31-7d69c96ff3ec	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:05:12.079461+00	
00000000-0000-0000-0000-000000000000	2fb10b03-94b4-4d85-848f-ca6eeaeeb678	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:05:23.772154+00	
00000000-0000-0000-0000-000000000000	5a783f45-60af-450b-b066-c4f24619b29a	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:06:20.899514+00	
00000000-0000-0000-0000-000000000000	c8b4e880-efde-4173-a0eb-7534ef2f8986	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:06:32.881745+00	
00000000-0000-0000-0000-000000000000	d86ac783-0403-45a7-8374-5627c1d75102	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:10:29.641749+00	
00000000-0000-0000-0000-000000000000	64bb906d-27ed-4d17-a085-3bd7098b9f59	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:10:44.920371+00	
00000000-0000-0000-0000-000000000000	04527baa-d158-4a53-a327-17077691f8a3	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:10:54.558021+00	
00000000-0000-0000-0000-000000000000	0ad58fb7-4f1d-435a-ab5b-c2bfdc6da0bc	{"action":"logout","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:11:20.198458+00	
00000000-0000-0000-0000-000000000000	7e803cab-dfef-4b46-8f69-732d6d19e404	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:11:34.119837+00	
00000000-0000-0000-0000-000000000000	a7dd7b59-f9bb-44ea-803b-b8e12ac173a5	{"action":"login","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:12:31.560867+00	
00000000-0000-0000-0000-000000000000	d878bc01-8f5c-4e8a-8078-75a9a5e37265	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 09:34:22.593758+00	
00000000-0000-0000-0000-000000000000	18f033ec-ea3e-4d1f-ab6d-93a9b1d0db30	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 09:54:53.248193+00	
00000000-0000-0000-0000-000000000000	216c2dd9-7d11-4b2d-b655-66adbd2653ea	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 10:55:04.484874+00	
00000000-0000-0000-0000-000000000000	334e4411-3155-4271-9be3-2f8f0465fce8	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 10:55:04.498706+00	
00000000-0000-0000-0000-000000000000	9aba392b-d389-4b0d-9679-c23364c57832	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 11:26:17.448867+00	
00000000-0000-0000-0000-000000000000	4eba4c20-4406-4de8-8225-85998ed24722	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 12:04:07.153744+00	
00000000-0000-0000-0000-000000000000	51dbf649-4ba1-43ab-b470-cdc15649a38e	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 13:05:38.3769+00	
00000000-0000-0000-0000-000000000000	b84703b5-e8ab-461f-992f-f38adc5398ca	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 13:23:02.890916+00	
00000000-0000-0000-0000-000000000000	38eec261-ba37-4011-aa69-e168f09ac899	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 13:36:48.809524+00	
00000000-0000-0000-0000-000000000000	02695841-3baf-4ffd-bc6c-37e31b93e952	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 13:36:48.814687+00	
00000000-0000-0000-0000-000000000000	c8b15940-d129-40ac-9793-bc53a946212f	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 14:37:03.022445+00	
00000000-0000-0000-0000-000000000000	64d4ab9d-206b-4d4a-8593-ad1c8c9f01d8	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 14:37:03.03992+00	
00000000-0000-0000-0000-000000000000	8d898d27-bd52-4660-9538-3ee2f271f0f3	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 15:02:19.87685+00	
00000000-0000-0000-0000-000000000000	33bc1c15-7f76-4212-9d91-6b2dbffd79c2	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 15:02:19.889842+00	
00000000-0000-0000-0000-000000000000	f6720eac-5c65-407e-b0b8-69dad35fc14a	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 15:14:00.042825+00	
00000000-0000-0000-0000-000000000000	3943f440-0d1f-48ef-af2e-2958ffa54a1c	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 15:14:52.798296+00	
00000000-0000-0000-0000-000000000000	ebd4bbb5-10af-404f-bb7b-6337cff84090	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 15:16:33.682089+00	
00000000-0000-0000-0000-000000000000	58f54a6c-eaa6-45d3-bbc0-37f83a643ee0	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 15:16:46.570484+00	
00000000-0000-0000-0000-000000000000	fe12a009-868f-4ba7-8905-ff96811d2faa	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 15:34:24.833016+00	
00000000-0000-0000-0000-000000000000	9e695cd3-9e44-4b38-8491-ae89daa8e37e	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:34:11.942271+00	
00000000-0000-0000-0000-000000000000	4b6329af-7ffc-4c1f-99e3-cda9032eb1a1	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:34:11.956702+00	
00000000-0000-0000-0000-000000000000	c1547685-60d0-490d-9047-f6472368fe53	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 16:37:32.119851+00	
00000000-0000-0000-0000-000000000000	a0aff086-0829-4194-ac6b-4240beeeadaf	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 16:40:53.428187+00	
00000000-0000-0000-0000-000000000000	e3565f9a-1fd2-4010-86b8-bbbf0424d4aa	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:59:01.383492+00	
00000000-0000-0000-0000-000000000000	384c1336-220f-4ce1-b2ef-2e1e244c646b	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 16:59:01.392881+00	
00000000-0000-0000-0000-000000000000	8b097c2e-7c71-4ed6-9043-56868e39cc01	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 17:14:02.479103+00	
00000000-0000-0000-0000-000000000000	8489c556-1b04-49c6-ab0e-6c39cc71bf73	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 17:14:02.487106+00	
00000000-0000-0000-0000-000000000000	fbb83e86-fa55-406a-833b-158125752263	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-18 17:20:42.394218+00	
00000000-0000-0000-0000-000000000000	d24946fe-fea3-4222-bcdd-b49c23f1c53c	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-18 17:20:57.477487+00	
00000000-0000-0000-0000-000000000000	64992d64-c774-41f5-b244-5e36755b59d5	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 21:06:01.406498+00	
00000000-0000-0000-0000-000000000000	9ac05bd9-c7f8-47bd-b60a-009ffb5ba794	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 21:06:01.426514+00	
00000000-0000-0000-0000-000000000000	e225e441-36fe-4862-a9c9-e06d294aeb67	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 21:56:33.566962+00	
00000000-0000-0000-0000-000000000000	4e57be51-269a-4b83-9b51-f2240595e763	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 21:56:33.578876+00	
00000000-0000-0000-0000-000000000000	47f144c2-0f47-40c9-af1d-e60fc450db28	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 22:20:03.354562+00	
00000000-0000-0000-0000-000000000000	854c99b2-f82e-48b0-b7fd-58c54838c482	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-18 22:20:03.362336+00	
00000000-0000-0000-0000-000000000000	f55e078f-ce18-4f29-ae93-cda15e6d8f44	{"action":"user_signedup","actor_id":"eaeb1dc1-14fd-4a7d-b621-a1761fc3490b","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 02:30:25.432844+00	
00000000-0000-0000-0000-000000000000	201679d9-6a06-4f91-8121-5c23354c1f7f	{"action":"login","actor_id":"eaeb1dc1-14fd-4a7d-b621-a1761fc3490b","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 02:30:25.463104+00	
00000000-0000-0000-0000-000000000000	2c4f1fdf-4e80-4672-b8f4-cf83e822201f	{"action":"logout","actor_id":"eaeb1dc1-14fd-4a7d-b621-a1761fc3490b","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 02:30:26.560542+00	
00000000-0000-0000-0000-000000000000	3e5a4ce1-3307-4f63-b8e7-9e611b0a7e6d	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 10:59:48.238262+00	
00000000-0000-0000-0000-000000000000	4f0d4514-e3c4-4e75-8645-2996a23adea5	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 10:59:48.254194+00	
00000000-0000-0000-0000-000000000000	4cc50d20-643f-4597-8793-65746bd263d1	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 11:00:09.776046+00	
00000000-0000-0000-0000-000000000000	5c0e43ad-3068-41e1-92c5-71c2ac5fc3a0	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 11:00:09.777873+00	
00000000-0000-0000-0000-000000000000	7a0008e1-1599-4733-bbcd-5715c64f0aaa	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 11:35:33.022382+00	
00000000-0000-0000-0000-000000000000	b82eed1a-37be-482c-bfcb-cda627934d57	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 11:35:33.039629+00	
00000000-0000-0000-0000-000000000000	04480dd3-aa52-43a0-9f57-8ba01d9e7d76	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 11:44:08.944267+00	
00000000-0000-0000-0000-000000000000	b029135c-b8d1-4db3-8411-048b4fa07d57	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 12:35:03.84349+00	
00000000-0000-0000-0000-000000000000	2e94d577-58f3-47a6-81e4-c6c54435f9b7	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 12:35:03.854643+00	
00000000-0000-0000-0000-000000000000	0d729b3d-9bab-422a-8a41-e5c65b9cdf19	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 13:10:05.653308+00	
00000000-0000-0000-0000-000000000000	6d7164bb-9a3a-4c66-bb9e-64903932eaa1	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 13:10:17.263638+00	
00000000-0000-0000-0000-000000000000	95563dad-30f1-48d3-8e0a-6436f87fb303	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 14:09:39.370893+00	
00000000-0000-0000-0000-000000000000	b8335ba7-de77-46a5-aff3-a5e0f021e384	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 14:09:39.386509+00	
00000000-0000-0000-0000-000000000000	f6bd7f70-4a5c-44bb-bf4e-fed89d2fbf8b	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 14:15:55.723635+00	
00000000-0000-0000-0000-000000000000	a31b7ace-718d-4ea2-9336-aa247603b800	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 14:15:55.727701+00	
00000000-0000-0000-0000-000000000000	e3fb569c-bf49-42d7-b019-996c2c51d81f	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 15:09:03.926666+00	
00000000-0000-0000-0000-000000000000	44f9ceb5-4a66-4263-a775-74fc93a1efd6	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 15:09:03.938316+00	
00000000-0000-0000-0000-000000000000	54cb9f51-7ec0-436d-85f8-29a60283c926	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 15:15:19.673024+00	
00000000-0000-0000-0000-000000000000	65f47b7c-a5f3-41ee-a9ef-ceebf0e0f44c	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 15:21:08.866013+00	
00000000-0000-0000-0000-000000000000	98e43c92-0f0e-40e9-a5a5-683137c90782	{"action":"login","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 15:23:41.344701+00	
00000000-0000-0000-0000-000000000000	1e3437be-5e5e-479e-99bb-42b6d78292af	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 16:09:03.787812+00	
00000000-0000-0000-0000-000000000000	0184456b-7cc9-4e35-8fe4-29539794342f	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 16:09:03.801347+00	
00000000-0000-0000-0000-000000000000	9f627442-5528-434a-b96d-eeaa6861a04e	{"action":"token_refreshed","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 17:08:25.74866+00	
00000000-0000-0000-0000-000000000000	0d01725e-60e8-43c8-b1be-b435260cc3ba	{"action":"token_revoked","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 17:08:25.753715+00	
00000000-0000-0000-0000-000000000000	01c8c1d3-e482-4cb4-a795-b0460a2946c3	{"action":"logout","actor_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:08:58.00705+00	
00000000-0000-0000-0000-000000000000	31d42a71-b353-4ac7-89ea-d1ab5dfb7e99	{"action":"user_repeated_signup","actor_id":"0886f3b5-a953-4702-884d-79727dbcc400","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-19 17:09:15.100014+00	
00000000-0000-0000-0000-000000000000	8aa92fc1-9c05-447c-8046-c5358aa9dc1e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"0886f3b5-a953-4702-884d-79727dbcc400","user_phone":""}}	2025-10-19 17:09:25.627835+00	
00000000-0000-0000-0000-000000000000	81098e2d-ce7c-4d38-987e-024044ac73ad	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"adixi.night@gmail.com","user_id":"eaeb1dc1-14fd-4a7d-b621-a1761fc3490b","user_phone":""}}	2025-10-19 17:09:25.649123+00	
00000000-0000-0000-0000-000000000000	af5ed20a-e4ee-456e-84d1-6b95b4936420	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin681@gmail.com","user_id":"b30401cb-95ca-447e-b668-7e58625a5552","user_phone":""}}	2025-10-19 17:09:25.676257+00	
00000000-0000-0000-0000-000000000000	228322f9-aba8-4911-86dc-1846abf8a43e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"c09aca21-664f-4bb8-bccf-1b864a2503b3","user_phone":""}}	2025-10-19 17:09:25.737706+00	
00000000-0000-0000-0000-000000000000	248d16be-4684-4bb8-9893-8dea56f3c154	{"action":"user_signedup","actor_id":"cd0ab331-fc66-44bc-9f21-a55270293489","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 17:09:29.048947+00	
00000000-0000-0000-0000-000000000000	4221b39b-cd4e-49f1-a4f3-790f4f8a80ec	{"action":"login","actor_id":"cd0ab331-fc66-44bc-9f21-a55270293489","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:09:29.052892+00	
00000000-0000-0000-0000-000000000000	19ee95bc-6b21-4cba-9f14-d5f1603fbccb	{"action":"logout","actor_id":"cd0ab331-fc66-44bc-9f21-a55270293489","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:09:29.333959+00	
00000000-0000-0000-0000-000000000000	191f62d9-673d-4464-9ebb-f8046627cea0	{"action":"login","actor_id":"cd0ab331-fc66-44bc-9f21-a55270293489","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:10:20.566967+00	
00000000-0000-0000-0000-000000000000	77814fbb-3ee3-4dd3-bc50-68aebc9d8851	{"action":"logout","actor_id":"cd0ab331-fc66-44bc-9f21-a55270293489","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:10:20.812321+00	
00000000-0000-0000-0000-000000000000	83ff3332-ee83-4d2a-b4b4-64036ee1dad1	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"cd0ab331-fc66-44bc-9f21-a55270293489","user_phone":""}}	2025-10-19 17:12:26.057588+00	
00000000-0000-0000-0000-000000000000	00d4a486-11f7-464a-9bdb-48d589526c34	{"action":"user_signedup","actor_id":"bddbc095-2541-48e9-bb53-f83fd43f182b","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 17:12:49.923842+00	
00000000-0000-0000-0000-000000000000	11483f1e-10ad-4136-9555-e73ae13e5c03	{"action":"login","actor_id":"bddbc095-2541-48e9-bb53-f83fd43f182b","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:12:49.929575+00	
00000000-0000-0000-0000-000000000000	4b5e5a93-af86-47b3-ad5a-f43a9d69db0d	{"action":"logout","actor_id":"bddbc095-2541-48e9-bb53-f83fd43f182b","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:12:50.150179+00	
00000000-0000-0000-0000-000000000000	e63b9626-fce9-415f-b4a0-392d82329d21	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"bddbc095-2541-48e9-bb53-f83fd43f182b","user_phone":""}}	2025-10-19 17:13:29.062417+00	
00000000-0000-0000-0000-000000000000	2e6abcab-42d3-4dff-acb8-3badf9f7f71e	{"action":"user_signedup","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 17:13:47.027041+00	
00000000-0000-0000-0000-000000000000	0acce7cf-e87e-4c12-92ba-4b9a822bdf34	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:13:47.030397+00	
00000000-0000-0000-0000-000000000000	72bc79ae-93e3-4d09-aace-01dffecd395a	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:13:47.219219+00	
00000000-0000-0000-0000-000000000000	047fa725-8b89-4914-a465-dc65d5ff3da7	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:20:56.661571+00	
00000000-0000-0000-0000-000000000000	fdc3199d-28a0-456c-a588-1290fa2185ae	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:20:56.892793+00	
00000000-0000-0000-0000-000000000000	b17100d6-24be-418e-9ed8-d4947d95fc94	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:20:58.150672+00	
00000000-0000-0000-0000-000000000000	3217c6ad-d3b1-4faa-865a-a58ddca8cee3	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:20:58.38752+00	
00000000-0000-0000-0000-000000000000	d06674fd-698f-4686-a8e1-ba3fe962576f	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:27.569008+00	
00000000-0000-0000-0000-000000000000	b69545bf-48bc-4cdf-a13b-e90c55b5d2f9	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:28.10998+00	
00000000-0000-0000-0000-000000000000	c549b0db-bd40-4984-9643-e9c0558d494d	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:28.617095+00	
00000000-0000-0000-0000-000000000000	4ca17375-d167-448d-9371-74c9698e96a4	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:28.817011+00	
00000000-0000-0000-0000-000000000000	f44ec945-3d85-4b0e-8dad-c4c02f4bf785	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:42.135271+00	
00000000-0000-0000-0000-000000000000	812ddc57-6a6d-4df8-8199-7b34521af2ba	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:42.342298+00	
00000000-0000-0000-0000-000000000000	7b14ba79-246e-4175-bfb4-8f471f4aaeaf	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:42.8769+00	
00000000-0000-0000-0000-000000000000	952bb92e-f106-426f-8cd3-fe5ceecbdb28	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:43.052622+00	
00000000-0000-0000-0000-000000000000	c949342b-8f06-412f-bd3e-e76073d2bcf8	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:56.976761+00	
00000000-0000-0000-0000-000000000000	1f797ec3-f86e-43b3-b939-2e8b549fc530	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:57.184729+00	
00000000-0000-0000-0000-000000000000	bcd18848-98dc-4212-9f7c-99cbcfe03c7f	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:21:57.770903+00	
00000000-0000-0000-0000-000000000000	79409513-cd34-4902-810c-5c69ee0c38c0	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:21:57.983031+00	
00000000-0000-0000-0000-000000000000	0d95f38e-9772-41d5-a6e1-316fbe4ecd5c	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:22:11.345817+00	
00000000-0000-0000-0000-000000000000	0b7e604f-4a1b-4c4a-b0a6-28f06b18fba1	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:22:11.621758+00	
00000000-0000-0000-0000-000000000000	49403d42-a196-457a-9e89-b3a622444b6e	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:22:12.110749+00	
00000000-0000-0000-0000-000000000000	a8b1c084-75cc-49c2-b500-e3a58d5cef86	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:22:12.392202+00	
00000000-0000-0000-0000-000000000000	135fe7d8-c212-43a7-bfa7-edd5770f30fc	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:22:12.778347+00	
00000000-0000-0000-0000-000000000000	d268ef0b-3293-4b75-8088-6eaf3ecc64c0	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:22:13.07627+00	
00000000-0000-0000-0000-000000000000	f5ae6a6a-1a0f-404d-90da-1d9c07be3bbb	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:22:14.047702+00	
00000000-0000-0000-0000-000000000000	ad832dfb-362f-44fe-a4e7-be182bce36a6	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:22:14.289911+00	
00000000-0000-0000-0000-000000000000	2017abe2-c930-4bbc-91e2-1eed75d381ac	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:23:23.252812+00	
00000000-0000-0000-0000-000000000000	b3cfadc3-922f-400f-a0b3-004b88a7e4cf	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:23:23.517397+00	
00000000-0000-0000-0000-000000000000	981586ce-cd13-49b9-a1f0-b9d23a85d97a	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:23:23.988819+00	
00000000-0000-0000-0000-000000000000	be766a39-9980-405c-b490-30565b7bbd98	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:23:24.171558+00	
00000000-0000-0000-0000-000000000000	f0eb5481-8b6a-4617-9e1a-e7ee71c0f54a	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:23:34.1362+00	
00000000-0000-0000-0000-000000000000	f64cb7fa-380d-4176-aabd-3c1be142a8fd	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:23:34.288655+00	
00000000-0000-0000-0000-000000000000	9de38736-206c-4ad7-9ff7-15a3c308e83b	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:23:34.791482+00	
00000000-0000-0000-0000-000000000000	bde5b9fe-40f5-4b95-97f8-a903a4a9528c	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:23:34.925785+00	
00000000-0000-0000-0000-000000000000	83128d7f-c258-426f-9a19-d2ada6a2592b	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:27.848122+00	
00000000-0000-0000-0000-000000000000	dd2144fc-5d38-47fe-8695-a557ed29b075	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:27.996032+00	
00000000-0000-0000-0000-000000000000	77a005b8-0a66-443a-ba24-176c69239af6	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:28.570668+00	
00000000-0000-0000-0000-000000000000	adb305b8-b575-4b23-a4e6-a769ad8796f7	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:28.731581+00	
00000000-0000-0000-0000-000000000000	7f5e0e4b-c897-48c6-8aa0-96a83017cfd0	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:29.196303+00	
00000000-0000-0000-0000-000000000000	2e35ad58-ff7e-4a6b-b7e3-928cb7888de3	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:29.373288+00	
00000000-0000-0000-0000-000000000000	faa8e76d-a772-42a4-bb75-a8bccae2c1ee	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:43.946065+00	
00000000-0000-0000-0000-000000000000	3f5efefd-0ea0-403a-80e6-b55c8edfce5c	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:44.095236+00	
00000000-0000-0000-0000-000000000000	0fdb53db-d018-460d-a14d-506614832f24	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:44.804512+00	
00000000-0000-0000-0000-000000000000	74f2335f-3b5d-4b0b-8069-3f127dd28c9a	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:45.03419+00	
00000000-0000-0000-0000-000000000000	805528f6-1966-4746-95e1-1fb36cb76054	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:24:45.545176+00	
00000000-0000-0000-0000-000000000000	f8883bde-5bc0-45ae-8117-3d9f03e96236	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:24:45.699759+00	
00000000-0000-0000-0000-000000000000	235e958b-3b67-4eb7-a632-74acba61592e	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:44:29.823984+00	
00000000-0000-0000-0000-000000000000	196cbecc-e3f4-406c-a223-8b65d2b63491	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:44:30.320304+00	
00000000-0000-0000-0000-000000000000	1775501e-00da-4070-a809-9cad288e8f89	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:44:30.866398+00	
00000000-0000-0000-0000-000000000000	aafef375-2f43-4361-88f9-d61becbb7f84	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:44:31.079749+00	
00000000-0000-0000-0000-000000000000	21307af0-148f-4dfd-b8e4-aa582f30fab4	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:44:31.661277+00	
00000000-0000-0000-0000-000000000000	26bed730-bdb7-4b8c-879f-be9e769bb695	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:44:31.832945+00	
00000000-0000-0000-0000-000000000000	c99993ce-f673-40ea-9c5c-07d69353fbf5	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:45:28.887559+00	
00000000-0000-0000-0000-000000000000	1588897a-9b0c-492a-8261-592551982ea9	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:45:29.289212+00	
00000000-0000-0000-0000-000000000000	e1775c93-bf13-4966-9a64-d7308a8c348b	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:47:17.831122+00	
00000000-0000-0000-0000-000000000000	462d596f-837f-4a43-a3b2-904d2b0d7a6d	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:47:18.047771+00	
00000000-0000-0000-0000-000000000000	ff81d519-92bb-4e95-af07-abe6cb3f4c62	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:49:48.399183+00	
00000000-0000-0000-0000-000000000000	d56efd71-ce3b-4083-9ef3-e5eadc34e8dc	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:49:48.560591+00	
00000000-0000-0000-0000-000000000000	df5d4021-84da-4d93-bc2e-dd2466c71a55	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:49:49.218794+00	
00000000-0000-0000-0000-000000000000	dba6f957-fc90-4008-a787-9e8e6a1c5557	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:49:49.357445+00	
00000000-0000-0000-0000-000000000000	97d4ac30-ddf8-4fde-8bd0-1b944e0f061a	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:49:49.897162+00	
00000000-0000-0000-0000-000000000000	022bcbac-4492-45da-966c-c1a5cfeea114	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:49:50.030886+00	
00000000-0000-0000-0000-000000000000	ef85fb8b-e002-40e8-97a8-400bb545ea0e	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:50:02.046736+00	
00000000-0000-0000-0000-000000000000	600b34b7-cd82-4387-89d9-300374ab5e5e	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:50:02.189515+00	
00000000-0000-0000-0000-000000000000	7ac733ea-afa1-4edb-b50f-6e5d1d93c0bc	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:50:02.745361+00	
00000000-0000-0000-0000-000000000000	fb94225e-e2ce-4f22-b4a0-8f89c47035a7	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:50:02.872109+00	
00000000-0000-0000-0000-000000000000	8bc9e6fd-03e0-4074-b677-2ca995e9ec0b	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:50:21.879693+00	
00000000-0000-0000-0000-000000000000	2d27e14c-2498-4fd9-886b-cb9bcfd12507	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:50:22.047186+00	
00000000-0000-0000-0000-000000000000	4b7344a9-0c33-4974-92e4-68b435eb992c	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:50:42.748313+00	
00000000-0000-0000-0000-000000000000	7551d518-e54b-4823-a28a-a1068f068805	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:50:42.904621+00	
00000000-0000-0000-0000-000000000000	3dc2688c-0184-4518-aa6b-3b0dbb8ad94a	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:55:03.364993+00	
00000000-0000-0000-0000-000000000000	1ffb48c1-70c3-4990-b650-250a6bf8b22f	{"action":"user_signedup","actor_id":"ddf3e29e-777d-4653-b5c9-09111949a5ff","actor_username":"nathangrondin@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 17:55:28.717676+00	
00000000-0000-0000-0000-000000000000	8901d915-26bb-41ed-989e-3f29b36f0635	{"action":"login","actor_id":"ddf3e29e-777d-4653-b5c9-09111949a5ff","actor_username":"nathangrondin@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 17:55:28.723062+00	
00000000-0000-0000-0000-000000000000	fe5fcb71-9c42-44e1-b6a5-2af15b9984cc	{"action":"logout","actor_id":"ddf3e29e-777d-4653-b5c9-09111949a5ff","actor_username":"nathangrondin@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:55:28.938391+00	
00000000-0000-0000-0000-000000000000	ab636772-b644-49db-a164-40afa6c8b7f7	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 17:59:54.925982+00	
00000000-0000-0000-0000-000000000000	ca08b5e9-b595-441a-a5d2-3e2a8c48fde2	{"action":"user_repeated_signup","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-19 18:00:11.35702+00	
00000000-0000-0000-0000-000000000000	c3b9f6bc-d08b-4b00-b6d3-ee315058f975	{"action":"login","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:00:27.479556+00	
00000000-0000-0000-0000-000000000000	4cdab31a-da3c-4507-a6ec-9167447bd382	{"action":"logout","actor_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 18:00:27.636603+00	
00000000-0000-0000-0000-000000000000	e982f054-68aa-4a10-9ded-9d446ac33149	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"0089afe1-dffd-4fa7-9fca-f5a20c17b315","user_phone":""}}	2025-10-19 18:00:40.598866+00	
00000000-0000-0000-0000-000000000000	8db54e49-cb3c-4e82-8eb1-922675136a66	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin@gmail.com","user_id":"ddf3e29e-777d-4653-b5c9-09111949a5ff","user_phone":""}}	2025-10-19 18:00:44.252019+00	
00000000-0000-0000-0000-000000000000	bbb668e0-6de4-4cb3-879f-e68077a347f8	{"action":"user_signedup","actor_id":"908d3369-1c54-47f1-8ca6-40ab41a6ee5d","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 18:01:03.047634+00	
00000000-0000-0000-0000-000000000000	a7ba2adb-42f6-4c54-9278-e0ca299a80c5	{"action":"login","actor_id":"908d3369-1c54-47f1-8ca6-40ab41a6ee5d","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:01:03.054776+00	
00000000-0000-0000-0000-000000000000	0ec0610a-f5dd-4c7f-ade8-795860ce5bf4	{"action":"logout","actor_id":"908d3369-1c54-47f1-8ca6-40ab41a6ee5d","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 18:01:03.263949+00	
00000000-0000-0000-0000-000000000000	ceae517b-3630-421f-879b-2c2614d8f836	{"action":"login","actor_id":"908d3369-1c54-47f1-8ca6-40ab41a6ee5d","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:01:21.846603+00	
00000000-0000-0000-0000-000000000000	fef79d66-3c0a-48a5-8037-7a7c9dfcab0d	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin683@gmail.com","user_id":"908d3369-1c54-47f1-8ca6-40ab41a6ee5d","user_phone":""}}	2025-10-19 18:08:20.499896+00	
00000000-0000-0000-0000-000000000000	7789ec67-b38c-42e7-a0d4-427a0267b3a0	{"action":"user_signedup","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 18:14:05.191707+00	
00000000-0000-0000-0000-000000000000	e462eb93-0535-4c0d-bd27-87b40f9dbce3	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:14:05.196928+00	
00000000-0000-0000-0000-000000000000	cdb942a2-ce81-4b4f-8202-64a77ba3e002	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 18:14:05.415355+00	
00000000-0000-0000-0000-000000000000	3122a6fc-7f0f-45f1-826a-76862e2e815e	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:14:35.678727+00	
00000000-0000-0000-0000-000000000000	2126c84e-6d5f-4d50-832d-55095fd483d4	{"action":"user_signedup","actor_id":"45e8afa7-3f11-445f-9a92-4a7fe31e4b72","actor_username":"qdg@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 18:15:07.650303+00	
00000000-0000-0000-0000-000000000000	7595a8d4-eccc-4178-955c-13a369090f17	{"action":"login","actor_id":"45e8afa7-3f11-445f-9a92-4a7fe31e4b72","actor_username":"qdg@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:15:07.673639+00	
00000000-0000-0000-0000-000000000000	8363ab8f-9003-4c49-af14-26a633ae5cfe	{"action":"logout","actor_id":"45e8afa7-3f11-445f-9a92-4a7fe31e4b72","actor_username":"qdg@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 18:15:08.224162+00	
00000000-0000-0000-0000-000000000000	8f6d9178-11d0-4978-b947-7ec3e3a7a8c8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"qdg@gmail.com","user_id":"45e8afa7-3f11-445f-9a92-4a7fe31e4b72","user_phone":""}}	2025-10-19 18:15:40.013191+00	
00000000-0000-0000-0000-000000000000	e3d3fa58-10df-4f9d-bfda-7e151c7842a5	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 18:33:14.931069+00	
00000000-0000-0000-0000-000000000000	0bdd9ad2-8128-4905-8ff1-a426c85eaa02	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:08:50.292103+00	
00000000-0000-0000-0000-000000000000	3d558235-cd38-4964-b274-8c75c6316b94	{"action":"user_signedup","actor_id":"f476a870-202e-4684-9cce-d39470691099","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:09:11.146577+00	
00000000-0000-0000-0000-000000000000	d1916552-f594-4982-9a0b-2dead7c64914	{"action":"login","actor_id":"f476a870-202e-4684-9cce-d39470691099","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:09:11.164111+00	
00000000-0000-0000-0000-000000000000	6a69111d-9889-4c5a-8788-77022d8e111b	{"action":"logout","actor_id":"f476a870-202e-4684-9cce-d39470691099","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:09:11.380617+00	
00000000-0000-0000-0000-000000000000	333f34a6-ed1d-4fc7-9573-0f395b3481bf	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 19:32:37.518424+00	
00000000-0000-0000-0000-000000000000	8b683fdf-69fd-4e69-b600-26baa1188295	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"f476a870-202e-4684-9cce-d39470691099","user_phone":""}}	2025-10-19 19:11:15.488695+00	
00000000-0000-0000-0000-000000000000	7213da5c-e26c-4a02-97b6-04e9f8cd9829	{"action":"user_signedup","actor_id":"4a1a3515-f3ce-4d4d-858d-b664b88683c2","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:16:16.720522+00	
00000000-0000-0000-0000-000000000000	ac77186b-6a0d-42b9-b000-7c7e39d38534	{"action":"login","actor_id":"4a1a3515-f3ce-4d4d-858d-b664b88683c2","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:16:16.735641+00	
00000000-0000-0000-0000-000000000000	ee615336-0cd5-4a91-a262-d4b519d5b3b9	{"action":"logout","actor_id":"4a1a3515-f3ce-4d4d-858d-b664b88683c2","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:16:16.972494+00	
00000000-0000-0000-0000-000000000000	3865a589-6e7c-480c-aaca-b7210a5af9bb	{"action":"user_repeated_signup","actor_id":"4a1a3515-f3ce-4d4d-858d-b664b88683c2","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-19 19:16:26.693475+00	
00000000-0000-0000-0000-000000000000	90f46895-4b3f-47c5-ae2f-1acbbdf73f54	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"4a1a3515-f3ce-4d4d-858d-b664b88683c2","user_phone":""}}	2025-10-19 19:16:53.63966+00	
00000000-0000-0000-0000-000000000000	473ad470-5bb5-4145-84d2-e8eb8d74c84b	{"action":"user_signedup","actor_id":"c39e7df7-011b-46c5-80e6-7f0cd22dd892","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:16:57.051109+00	
00000000-0000-0000-0000-000000000000	db1ee45d-713e-4697-9784-33ad374c0911	{"action":"login","actor_id":"c39e7df7-011b-46c5-80e6-7f0cd22dd892","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:16:57.055651+00	
00000000-0000-0000-0000-000000000000	fa387f3f-3d2c-4149-8355-0f90d3aac39c	{"action":"logout","actor_id":"c39e7df7-011b-46c5-80e6-7f0cd22dd892","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:16:57.260898+00	
00000000-0000-0000-0000-000000000000	53aa478e-3e45-44d8-b34b-08c243589db3	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"c39e7df7-011b-46c5-80e6-7f0cd22dd892","user_phone":""}}	2025-10-19 19:17:24.713594+00	
00000000-0000-0000-0000-000000000000	99622166-854f-4622-96e8-6e3ea768c7e5	{"action":"user_signedup","actor_id":"0247fc98-34d3-4cd4-a7cf-05c88ca5ef31","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:17:26.878901+00	
00000000-0000-0000-0000-000000000000	6d544936-e2d7-4d9b-b5e4-96f59320eb3a	{"action":"login","actor_id":"0247fc98-34d3-4cd4-a7cf-05c88ca5ef31","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:17:26.883106+00	
00000000-0000-0000-0000-000000000000	98801107-3c39-48b1-83d8-eacc9ca7136f	{"action":"logout","actor_id":"0247fc98-34d3-4cd4-a7cf-05c88ca5ef31","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:17:27.100796+00	
00000000-0000-0000-0000-000000000000	bd1e0e30-b0b8-4ac0-9674-71bfce9c5e06	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"0247fc98-34d3-4cd4-a7cf-05c88ca5ef31","user_phone":""}}	2025-10-19 19:18:06.871031+00	
00000000-0000-0000-0000-000000000000	e5f8d65c-4747-40d8-b513-b5216b6287cd	{"action":"user_signedup","actor_id":"7c979a2d-8e5b-4130-9fcc-a02845a58df6","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:18:08.917252+00	
00000000-0000-0000-0000-000000000000	e7f02baa-5d6b-4d01-ac2c-cb2606a169e9	{"action":"login","actor_id":"7c979a2d-8e5b-4130-9fcc-a02845a58df6","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:18:08.920835+00	
00000000-0000-0000-0000-000000000000	9677e5ae-9cd6-4745-a125-735d6a6bbf04	{"action":"logout","actor_id":"7c979a2d-8e5b-4130-9fcc-a02845a58df6","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:18:09.09767+00	
00000000-0000-0000-0000-000000000000	0eaef034-45bc-4580-a333-1465db228e34	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"7c979a2d-8e5b-4130-9fcc-a02845a58df6","user_phone":""}}	2025-10-19 19:18:38.681112+00	
00000000-0000-0000-0000-000000000000	0b88e3fe-5407-4a6b-b7c6-cb0b85743d3f	{"action":"user_signedup","actor_id":"ea7c49fb-b1b2-4768-aff8-35b4c81ca9c5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:18:45.276438+00	
00000000-0000-0000-0000-000000000000	a95fdad0-0471-4798-bea5-a6ef7be41dae	{"action":"login","actor_id":"ea7c49fb-b1b2-4768-aff8-35b4c81ca9c5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:18:45.2796+00	
00000000-0000-0000-0000-000000000000	79b1ccb8-62f9-4245-859c-6296504261ad	{"action":"logout","actor_id":"ea7c49fb-b1b2-4768-aff8-35b4c81ca9c5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:18:45.469142+00	
00000000-0000-0000-0000-000000000000	e7deaf26-a9b9-4781-8a80-af64f7529af8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"ea7c49fb-b1b2-4768-aff8-35b4c81ca9c5","user_phone":""}}	2025-10-19 19:27:17.845442+00	
00000000-0000-0000-0000-000000000000	1a36520f-5619-48cf-a86d-950d7c354852	{"action":"user_signedup","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-19 19:27:43.476962+00	
00000000-0000-0000-0000-000000000000	383d70a3-2bc9-4cc3-8c0d-705c54cb222d	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:27:43.484568+00	
00000000-0000-0000-0000-000000000000	94710288-5511-4ccb-aa6d-858b26b6b7eb	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:27:43.821492+00	
00000000-0000-0000-0000-000000000000	c968a4c8-9b41-471f-a62a-dee2be2c97f2	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:28:05.241356+00	
00000000-0000-0000-0000-000000000000	19af7a5c-0350-46f5-bfd5-7c898a0c40e8	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-19 19:28:05.437859+00	
00000000-0000-0000-0000-000000000000	1e37843a-5599-4803-9279-8eeeaeeef111	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 19:28:09.525892+00	
00000000-0000-0000-0000-000000000000	3983acee-4622-4548-9279-2bc81e8c1c16	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 19:32:37.517467+00	
00000000-0000-0000-0000-000000000000	ac50506b-682e-48d2-b3ce-5caf93a45f03	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-19 20:05:10.644336+00	
00000000-0000-0000-0000-000000000000	12ae4b69-aca3-4555-bc06-0e8957636089	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 20:34:13.567285+00	
00000000-0000-0000-0000-000000000000	550b9617-840e-47f5-afcd-e5d0af6ba7d1	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-19 20:34:13.58066+00	
00000000-0000-0000-0000-000000000000	b7431445-3efa-4286-b75c-bb5456daaec5	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 07:07:16.172558+00	
00000000-0000-0000-0000-000000000000	6de0d9ba-4ac0-4b30-bfb3-813bf836d607	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 07:07:16.196176+00	
00000000-0000-0000-0000-000000000000	400e9a07-f77e-4c93-b56e-a8af50078ece	{"action":"user_signedup","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-20 07:41:18.570675+00	
00000000-0000-0000-0000-000000000000	c0144073-e094-4be7-950e-15d76c28b229	{"action":"login","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 07:41:18.588905+00	
00000000-0000-0000-0000-000000000000	a9f76e16-7a24-48cf-88a5-b715e90fcc92	{"action":"logout","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 07:41:19.353542+00	
00000000-0000-0000-0000-000000000000	90e22fe1-68b4-4da6-87a5-93f819229c81	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 07:43:22.080691+00	
00000000-0000-0000-0000-000000000000	e8aeea3f-b380-49ec-80dd-a3bf45c4d76a	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 07:43:22.08901+00	
00000000-0000-0000-0000-000000000000	8b48ce38-1234-41c7-8ed4-d39667a438ab	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 08:43:06.270652+00	
00000000-0000-0000-0000-000000000000	5e5492b5-ed04-4017-aae8-b358c26f8400	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 08:43:06.287128+00	
00000000-0000-0000-0000-000000000000	f822740e-c4e0-4e34-94c0-075b7e9ed0f4	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 09:52:53.713452+00	
00000000-0000-0000-0000-000000000000	d1b5421f-40f9-4e03-aa66-7113ee665806	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 09:52:53.735719+00	
00000000-0000-0000-0000-000000000000	0312c1ec-8cd7-48ad-9952-d8df3834ec0d	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 09:54:24.517442+00	
00000000-0000-0000-0000-000000000000	6900cbe0-25a0-4bfd-8886-f521213250b0	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 11:20:47.559403+00	
00000000-0000-0000-0000-000000000000	e6079418-6b60-4689-85f9-07bf2665a9f3	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 11:20:47.577924+00	
00000000-0000-0000-0000-000000000000	2fe791ed-ec2f-48d2-9140-8a9c034bd21e	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 11:47:12.893205+00	
00000000-0000-0000-0000-000000000000	c7cdf3ce-bb42-4384-854d-8c948feaec19	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 11:47:12.906103+00	
00000000-0000-0000-0000-000000000000	a2f52fe9-9c94-4440-a96b-c77e05490a96	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 16:42:18.928194+00	
00000000-0000-0000-0000-000000000000	b1669c40-09e6-48a2-ad13-8bdb78f7ea9c	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 16:42:18.938765+00	
00000000-0000-0000-0000-000000000000	c3c77ee5-c58c-4014-85b2-44d1add7c2ec	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 17:19:24.576264+00	
00000000-0000-0000-0000-000000000000	d15c2e04-ab73-4156-8c18-bfb870048ec1	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 17:19:33.926253+00	
00000000-0000-0000-0000-000000000000	1f464db5-8a02-4596-b7cf-4b4cdd47a86c	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 17:24:36.795945+00	
00000000-0000-0000-0000-000000000000	d0d063ab-2ea2-4dd2-b011-f0721aac4ab7	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 17:24:36.807888+00	
00000000-0000-0000-0000-000000000000	0a90b32e-46fe-4bf6-9ff0-1b83a81b163d	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 17:26:33.577268+00	
00000000-0000-0000-0000-000000000000	2581d252-07c4-4646-a66a-8663ed2d74a6	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 18:18:57.805141+00	
00000000-0000-0000-0000-000000000000	8444841f-445f-4564-a39a-01b3d32d628b	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 18:18:57.816199+00	
00000000-0000-0000-0000-000000000000	e4c65c0d-3e31-45f3-9e48-162afc4e95c2	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:16:49.909929+00	
00000000-0000-0000-0000-000000000000	d82347f4-1ed7-4eaf-b2ef-5f1bf551242f	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:16:49.917259+00	
00000000-0000-0000-0000-000000000000	7ff052bb-5154-4537-a011-2c23c38c152e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:18:19.544772+00	
00000000-0000-0000-0000-000000000000	5bdd60f1-7151-491b-bebc-8bf2eccf6636	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:18:19.546136+00	
00000000-0000-0000-0000-000000000000	de0293c1-eb4f-404a-bd65-fdbf902caaa2	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:19:32.018749+00	
00000000-0000-0000-0000-000000000000	d1e6b22c-4c51-4a25-b5f8-67d60317daba	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 19:19:32.023618+00	
00000000-0000-0000-0000-000000000000	91100fc7-8eaa-409a-a2f8-490de5f4e163	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:20:13.706552+00	
00000000-0000-0000-0000-000000000000	d550c772-f35f-4182-8a2f-ff9d5b0c1991	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:20:23.948602+00	
00000000-0000-0000-0000-000000000000	a1782adc-6c19-46a3-a29c-2a323a06543e	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:20:35.600319+00	
00000000-0000-0000-0000-000000000000	aae6e8ed-4aa3-4788-8053-c11e680236d6	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:20:49.036798+00	
00000000-0000-0000-0000-000000000000	63fafd13-48a6-4315-991a-0ac2b9ac8c23	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:22:45.994927+00	
00000000-0000-0000-0000-000000000000	3f00d8c5-845f-49d3-b46a-469910c5eac1	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:22:57.318572+00	
00000000-0000-0000-0000-000000000000	45fe7778-ec92-4949-a452-bf5c4dc62a8c	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:23:06.251755+00	
00000000-0000-0000-0000-000000000000	b05fca34-117c-4824-82d0-ed0f807db3a5	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:23:15.76172+00	
00000000-0000-0000-0000-000000000000	80346a63-3677-486f-83fe-136e4ee67b28	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:25:55.502457+00	
00000000-0000-0000-0000-000000000000	21de2e17-851d-4ed0-9824-6304c1042e64	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:27:53.704846+00	
00000000-0000-0000-0000-000000000000	d12c627c-36b2-4514-906c-74095a42fdb6	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:28:00.935104+00	
00000000-0000-0000-0000-000000000000	91ff6968-ec2d-4d55-b5d5-2eb587484b0a	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:28:10.232576+00	
00000000-0000-0000-0000-000000000000	60cd932f-5cea-4f52-ab21-14b0058b5e39	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:29:37.469915+00	
00000000-0000-0000-0000-000000000000	d750507b-c1ca-4b52-8724-7bd03cf98526	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:29:54.213204+00	
00000000-0000-0000-0000-000000000000	716a5213-b877-4aea-b95c-c68c143d4a01	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:40:37.585636+00	
00000000-0000-0000-0000-000000000000	ffdd5924-036e-4c56-bd21-e65e80faabdd	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:40:47.459998+00	
00000000-0000-0000-0000-000000000000	4f99bfbf-51f4-4220-9808-b0215509248e	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-20 19:41:53.364067+00	
00000000-0000-0000-0000-000000000000	d0f84b83-bcb3-4ac1-bc45-52c021b1b1a1	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 19:42:03.274351+00	
00000000-0000-0000-0000-000000000000	c5176a1d-e517-4ee7-be2b-ada2c7d9a921	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 20:19:48.521079+00	
00000000-0000-0000-0000-000000000000	e5c5f927-f2d7-4be7-b00c-7bb47ffb85df	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 21:13:54.286307+00	
00000000-0000-0000-0000-000000000000	acd71663-0d9e-4c38-ad1b-d3c2ab9ad6f7	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 21:18:44.211214+00	
00000000-0000-0000-0000-000000000000	b4f074c7-60c9-4fc0-a87c-a5a69ed83ad0	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 21:42:35.312708+00	
00000000-0000-0000-0000-000000000000	9b3eaedb-8a2f-4467-a739-2db1c04b7854	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-20 21:53:05.732403+00	
00000000-0000-0000-0000-000000000000	d3088e5b-294b-46a5-8f90-d94270cca3c2	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 22:42:02.398256+00	
00000000-0000-0000-0000-000000000000	4cdb4483-0fcd-4d57-b979-5e1a9d061d83	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-20 22:42:02.416265+00	
00000000-0000-0000-0000-000000000000	5a663755-9e4e-4dc0-ba53-141d105706bf	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 07:30:54.541738+00	
00000000-0000-0000-0000-000000000000	05f716e1-87a9-4f3b-94d9-85725075ef93	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 07:30:54.564901+00	
00000000-0000-0000-0000-000000000000	c7dd10c5-c503-4279-8430-c0df252bacab	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 10:14:33.605843+00	
00000000-0000-0000-0000-000000000000	acc143cd-f545-4a74-9b83-c6efefe92ac1	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 10:33:19.311964+00	
00000000-0000-0000-0000-000000000000	ac79f130-55b6-4742-8bf6-96905b650870	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 10:43:59.905619+00	
00000000-0000-0000-0000-000000000000	89a55c4b-2d06-497d-baa3-5dd89b2e0446	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 11:05:26.843139+00	
00000000-0000-0000-0000-000000000000	d4458a1a-792b-4701-9504-536c4b584efc	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 11:05:36.544588+00	
00000000-0000-0000-0000-000000000000	91ce918c-8dbd-4fc8-b6e5-b65171330197	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 11:05:50.193316+00	
00000000-0000-0000-0000-000000000000	3542d86c-9936-4bb7-bc9c-6eb1724d3bf4	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 11:08:38.531631+00	
00000000-0000-0000-0000-000000000000	3d8bac24-45af-43b5-bdeb-148fbb614371	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 11:27:57.731755+00	
00000000-0000-0000-0000-000000000000	5845127e-4e3a-44db-a58c-30e2b21acf96	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 11:27:57.738854+00	
00000000-0000-0000-0000-000000000000	5c72b893-2050-4542-b121-2523f3887498	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 11:29:26.082689+00	
00000000-0000-0000-0000-000000000000	a009e1c9-adc0-4afe-8dec-c7540c90013b	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 11:29:26.084202+00	
00000000-0000-0000-0000-000000000000	3781a520-33bf-4733-82b9-8e290f553eac	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 11:31:25.532009+00	
00000000-0000-0000-0000-000000000000	3ee89104-f106-448a-b791-dcd4f12eb413	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 11:34:55.51365+00	
00000000-0000-0000-0000-000000000000	5b121527-5fcc-4ebc-940f-7577b8daebb2	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 13:09:40.911907+00	
00000000-0000-0000-0000-000000000000	446d49a5-e63c-4d8e-bd12-a4ffd39fe19c	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 13:09:40.93387+00	
00000000-0000-0000-0000-000000000000	a408d674-9891-4b58-9a49-77faf5181fcd	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:04:02.520682+00	
00000000-0000-0000-0000-000000000000	b3e426ef-94d5-47b9-87a2-5e741e171920	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:04:02.537461+00	
00000000-0000-0000-0000-000000000000	74aba9d9-53f8-431c-8450-005a4a948d95	{"action":"login","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 16:07:55.162523+00	
00000000-0000-0000-0000-000000000000	546ef92a-535a-4ef5-a741-f37f0f57a88d	{"action":"token_refreshed","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:11:30.358328+00	
00000000-0000-0000-0000-000000000000	201838b8-660f-4616-bedf-91adf6c4e63b	{"action":"token_revoked","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:11:30.360075+00	
00000000-0000-0000-0000-000000000000	a8b74327-2820-4d4b-9362-161aee6f6d04	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:27:32.017292+00	
00000000-0000-0000-0000-000000000000	b5aa1ada-c463-4b4f-ae80-4b9947003950	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 16:27:32.02388+00	
00000000-0000-0000-0000-000000000000	0efaa305-046a-407d-bab0-1fd3367b4213	{"action":"login","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 16:37:56.662592+00	
00000000-0000-0000-0000-000000000000	7c1d077a-dd15-44c0-bcca-31d81615d507	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 17:02:16.054285+00	
00000000-0000-0000-0000-000000000000	d47b3c6c-c051-4acf-b22c-93a23ff0c597	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 17:24:35.461967+00	
00000000-0000-0000-0000-000000000000	c71e9996-cf73-4482-bd50-8b5c91c0e24b	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 17:26:59.621124+00	
00000000-0000-0000-0000-000000000000	3a3a6792-e3d7-43da-8369-0909495d6a57	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 17:26:59.625034+00	
00000000-0000-0000-0000-000000000000	29609edb-ca90-4199-8091-7674e6679597	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 17:38:03.05161+00	
00000000-0000-0000-0000-000000000000	1cfbf377-809d-4c8d-9a86-501243628ff2	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 17:38:03.056045+00	
00000000-0000-0000-0000-000000000000	b3d7bc59-3de5-43b3-881c-94ca5cb41fb6	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 18:27:00.023707+00	
00000000-0000-0000-0000-000000000000	7a937136-2ddd-48da-aa5b-f3bafa409fda	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 18:27:00.035495+00	
00000000-0000-0000-0000-000000000000	fa1c4b78-2134-4d27-bdce-006eb8b25f95	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 18:57:25.142326+00	
00000000-0000-0000-0000-000000000000	be28ef40-87cb-436b-ae8c-eec74552493e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 19:11:20.865098+00	
00000000-0000-0000-0000-000000000000	b2aac742-2506-44de-9061-1527c223c70b	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 19:11:20.868795+00	
00000000-0000-0000-0000-000000000000	9bc96e8c-a49d-45d3-8731-25a3838a8968	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 19:11:27.503352+00	
00000000-0000-0000-0000-000000000000	61e4f5b0-19dc-49fb-b4bd-ae72ad0419e8	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 19:11:36.590316+00	
00000000-0000-0000-0000-000000000000	cc19cad2-d403-4289-a4ab-f38fec50fed8	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 19:22:24.191058+00	
00000000-0000-0000-0000-000000000000	0fab4643-a945-445a-8d0c-63cf376cfa7a	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 19:26:25.685588+00	
00000000-0000-0000-0000-000000000000	f19dfa81-4dc2-4fd5-8b40-2b96baf6c457	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 19:26:25.690969+00	
00000000-0000-0000-0000-000000000000	7671af86-b43e-4ec3-9afd-a6fb2993db3b	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 20:09:32.718544+00	
00000000-0000-0000-0000-000000000000	747abb04-d9fa-4a30-bf97-d8613343c8d1	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:09:45.441384+00	
00000000-0000-0000-0000-000000000000	38489a20-9abd-4816-b501-42f8db7cf678	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 20:10:56.420117+00	
00000000-0000-0000-0000-000000000000	b890aa9b-d34e-431e-be5d-5f783c8ccbaa	{"action":"login","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:11:11.085674+00	
00000000-0000-0000-0000-000000000000	2386e16a-0307-4fd6-8bf2-a619b030fd6f	{"action":"logout","actor_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 20:11:57.471755+00	
00000000-0000-0000-0000-000000000000	fbc875a4-d953-4b74-9453-a2441059ef6a	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:12:09.167459+00	
00000000-0000-0000-0000-000000000000	91e6a33e-2866-4345-8586-b0705a052997	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"5262d643-4519-47cd-bcfb-20704fb66bfe","user_phone":""}}	2025-10-21 20:15:28.414952+00	
00000000-0000-0000-0000-000000000000	0a992417-8bbd-4d65-848c-f5b32bde61f0	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 20:20:52.749281+00	
00000000-0000-0000-0000-000000000000	461f6ddd-8284-49bf-95ae-d80608e86fe4	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 20:20:52.750614+00	
00000000-0000-0000-0000-000000000000	9cc93add-4623-4fca-b3c9-a8045f0a765d	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 20:23:12.062546+00	
00000000-0000-0000-0000-000000000000	05484369-9827-420c-8f3d-ae051574df64	{"action":"user_signedup","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-21 20:27:17.137423+00	
00000000-0000-0000-0000-000000000000	ffc05868-80b8-4174-8cab-dcdfa86cfe02	{"action":"login","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:27:17.172908+00	
00000000-0000-0000-0000-000000000000	f5348960-5eee-4641-9041-a33b4daf6edd	{"action":"logout","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-21 20:27:17.869276+00	
00000000-0000-0000-0000-000000000000	adaa2ca6-51bd-4219-a87d-062c83acdfec	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:27:51.599469+00	
00000000-0000-0000-0000-000000000000	aef3d244-35b8-4c9a-91f1-749ca786c03d	{"action":"login","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 20:28:09.016654+00	
00000000-0000-0000-0000-000000000000	eccf8275-ef70-401e-bd3f-92826b3a18d6	{"action":"user_repeated_signup","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-21 20:29:11.265158+00	
00000000-0000-0000-0000-000000000000	20400498-f730-45cc-b379-12ec448a467a	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 21:27:22.887376+00	
00000000-0000-0000-0000-000000000000	eb57e6c6-329e-4d80-a2df-2038c9e60af7	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 21:27:22.921992+00	
00000000-0000-0000-0000-000000000000	3830106d-827a-47d8-8b48-31f9eb570dae	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 22:02:00.116737+00	
00000000-0000-0000-0000-000000000000	814c7bec-bc13-4665-9652-d659b61d7f70	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 22:32:59.811982+00	
00000000-0000-0000-0000-000000000000	bd5ce519-82ba-46f8-8c59-da34457d2a2e	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 22:32:59.82632+00	
00000000-0000-0000-0000-000000000000	f67f65c4-83fb-44b0-bcb1-1a2336f44614	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-21 22:34:17.161813+00	
00000000-0000-0000-0000-000000000000	9323bf2a-df99-4a7d-a450-7e74cccf8f38	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 23:01:28.02775+00	
00000000-0000-0000-0000-000000000000	28c90c65-d555-4327-a4f1-806fd875dceb	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-21 23:01:28.038637+00	
00000000-0000-0000-0000-000000000000	8e2a1bbf-44dc-4ac2-bafb-268818616ee5	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 01:36:31.339152+00	
00000000-0000-0000-0000-000000000000	550ad852-68cf-43c1-a336-bd33677c6790	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 01:36:31.36671+00	
00000000-0000-0000-0000-000000000000	f842e7de-6188-4c8f-ba02-444918b35a9b	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 02:35:57.973295+00	
00000000-0000-0000-0000-000000000000	c54e62f2-69d1-4e6a-9e96-2fe9a68f4669	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 02:35:57.986896+00	
00000000-0000-0000-0000-000000000000	defe1398-4a34-4772-ae40-105e47ebbfa9	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 03:35:22.524489+00	
00000000-0000-0000-0000-000000000000	336668a5-c744-4e52-acc4-a2bba5b2314c	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 03:35:22.537379+00	
00000000-0000-0000-0000-000000000000	4741f21c-d4f1-4012-b6e0-72509c835aa2	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 04:35:13.083655+00	
00000000-0000-0000-0000-000000000000	b408f0a6-3eb6-4151-af9a-b5eafd8cbca4	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 04:35:13.103711+00	
00000000-0000-0000-0000-000000000000	c389228f-fcdb-45b2-b338-cb59000fda24	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 04:45:41.509965+00	
00000000-0000-0000-0000-000000000000	4b3e91e7-f658-4d0a-a505-e389fb3c0686	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 04:45:41.517924+00	
00000000-0000-0000-0000-000000000000	580f3dab-759e-48b5-933e-ea19459350bb	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 05:34:40.500027+00	
00000000-0000-0000-0000-000000000000	2a22ddf6-0d99-420b-8130-6e75f97248c9	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 05:34:40.512102+00	
00000000-0000-0000-0000-000000000000	10402b17-9b1d-4e59-bb4d-bdd10c8bd3c4	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 06:34:12.728605+00	
00000000-0000-0000-0000-000000000000	920d54d0-1105-4cf2-a4e3-7dda36ba3320	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 06:34:12.747922+00	
00000000-0000-0000-0000-000000000000	8d76c526-1599-40ba-8f4d-d78c6025b56f	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 07:03:08.593112+00	
00000000-0000-0000-0000-000000000000	2ee5a152-0630-4fe8-824d-0bc6f999ccb8	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 07:03:08.598698+00	
00000000-0000-0000-0000-000000000000	89fb4cb6-683e-4ebf-a082-020b126d3554	{"action":"user_signedup","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-22 07:12:35.143568+00	
00000000-0000-0000-0000-000000000000	eb496a61-e48a-4a20-9db9-e0185e98835c	{"action":"login","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-22 07:12:35.162587+00	
00000000-0000-0000-0000-000000000000	3bcb1cc7-21ca-4ae5-bafa-de0fe3fb4e64	{"action":"logout","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-22 07:12:36.295693+00	
00000000-0000-0000-0000-000000000000	1fd584c3-481e-484b-8e94-06b031a34e5a	{"action":"login","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-22 07:13:54.969056+00	
00000000-0000-0000-0000-000000000000	5046f3fd-fefb-404f-92db-a54ba9e22e9c	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-22 07:49:49.604629+00	
00000000-0000-0000-0000-000000000000	8a908e80-09b7-4478-af71-2845b3f8c967	{"action":"login","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-22 07:50:26.056592+00	
00000000-0000-0000-0000-000000000000	8648e20e-d2f4-49c6-902d-64977b846101	{"action":"logout","actor_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","actor_username":"nathangrondin682@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-22 07:50:40.981339+00	
00000000-0000-0000-0000-000000000000	b68b512b-5dfb-497d-be2e-d1525676cea2	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-22 07:50:54.878145+00	
00000000-0000-0000-0000-000000000000	44470de0-d9c8-41b7-bc2f-fa48aad40423	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 08:13:47.29252+00	
00000000-0000-0000-0000-000000000000	a521d789-3cdd-4cd1-8c3b-d04914b62af7	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 08:13:47.303235+00	
00000000-0000-0000-0000-000000000000	a2321ea1-a111-46d9-aa2a-8a6ef22bec2e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 08:50:22.697896+00	
00000000-0000-0000-0000-000000000000	a76ce674-05aa-40c9-835f-79e5716bf347	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 08:50:22.702481+00	
00000000-0000-0000-0000-000000000000	877069d4-816b-4e7c-abe8-0e8cdc368711	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 09:13:11.935903+00	
00000000-0000-0000-0000-000000000000	11c62e18-9162-4e1f-8469-8db4d25fcfd0	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 09:13:11.9454+00	
00000000-0000-0000-0000-000000000000	79d04fb8-9be0-49d3-9779-7d7d1c29714c	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 10:11:06.263523+00	
00000000-0000-0000-0000-000000000000	03d6577e-bdba-4ddb-96c2-9c7f6608e016	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 10:11:06.277521+00	
00000000-0000-0000-0000-000000000000	5b94e6b4-cab6-40c1-a5bb-43a74dc5aea8	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 10:12:33.847004+00	
00000000-0000-0000-0000-000000000000	a645da40-119a-4332-8f22-c454a3d9b216	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 10:12:33.857836+00	
00000000-0000-0000-0000-000000000000	ef13dce4-8623-4db4-b234-516c13b74416	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 11:12:33.974567+00	
00000000-0000-0000-0000-000000000000	57f2270b-e538-45a7-93ca-5081fffc67c7	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 11:12:33.995981+00	
00000000-0000-0000-0000-000000000000	b1c6a81c-c062-4ca8-88ff-352e2c0ccde7	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 12:12:33.962861+00	
00000000-0000-0000-0000-000000000000	c762e801-ad52-4967-85aa-e54e59c5e5b1	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 12:12:33.981373+00	
00000000-0000-0000-0000-000000000000	4b5b1ff5-4252-4cea-b2dc-096d6bf4a434	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:09:51.170845+00	
00000000-0000-0000-0000-000000000000	ad2c403a-6d3f-47a5-bc4d-dfcc2ccf7322	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:09:51.191268+00	
00000000-0000-0000-0000-000000000000	7025efad-55a7-4c6c-afa1-94fa1681e672	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:29:00.967635+00	
00000000-0000-0000-0000-000000000000	cbcf81b8-7be6-418f-9c91-3cb09a248957	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 14:29:00.974825+00	
00000000-0000-0000-0000-000000000000	19be2501-c117-4250-b52a-39a11cdae9c2	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 16:23:33.995438+00	
00000000-0000-0000-0000-000000000000	13b3356e-a387-46ea-80e4-cdf4faa73818	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 16:23:34.017644+00	
00000000-0000-0000-0000-000000000000	0aeb7758-e88c-4418-a17e-ff89ccb20079	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 16:35:55.134633+00	
00000000-0000-0000-0000-000000000000	27dbc614-bf29-4a66-85ca-907c7eb49822	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 16:35:55.144855+00	
00000000-0000-0000-0000-000000000000	5245b64a-9bc7-4002-a4e0-f8466e6e90e8	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 17:16:57.911869+00	
00000000-0000-0000-0000-000000000000	475359c1-6883-4070-a34a-33d06e9770d3	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 17:16:57.929039+00	
00000000-0000-0000-0000-000000000000	e8db27ff-c506-4f09-9f88-8d587601114e	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 17:23:44.246337+00	
00000000-0000-0000-0000-000000000000	2aa44bfa-018d-4a39-8a37-7b3ceed6254d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 17:23:44.253064+00	
00000000-0000-0000-0000-000000000000	099b8d2e-c44d-4ea7-a4ae-a4e12eb2e781	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 18:15:20.06062+00	
00000000-0000-0000-0000-000000000000	75e71c2e-643e-4389-b247-181866677735	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 18:15:20.075577+00	
00000000-0000-0000-0000-000000000000	9c6f7ec2-6bec-4f2f-b5e1-ba3219e7711e	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 19:31:58.707898+00	
00000000-0000-0000-0000-000000000000	fd39639e-10b0-4465-b91a-dea740745379	{"action":"token_revoked","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 19:31:58.718804+00	
00000000-0000-0000-0000-000000000000	f19ba2a0-2052-4c97-b511-d549e46f3381	{"action":"token_refreshed","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-22 19:43:59.705728+00	
00000000-0000-0000-0000-000000000000	276ee4e9-d364-491b-866f-42cd11bbbd55	{"action":"logout","actor_id":"1981ba9f-2416-40b0-b484-8f33e2242d66","actor_username":"esoum18@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-22 19:46:53.629582+00	
00000000-0000-0000-0000-000000000000	094c87b0-5d9c-4162-89d7-7fa35ee0c4bb	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 00:42:24.919869+00	
00000000-0000-0000-0000-000000000000	a919de77-f665-4b28-989a-565111d114fb	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 00:42:24.94851+00	
00000000-0000-0000-0000-000000000000	edb9ccf9-49c3-4e47-a98f-7830f50c4440	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 01:42:10.249878+00	
00000000-0000-0000-0000-000000000000	ece2146d-252a-4e94-b2a8-3abc5e1f134a	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 01:42:10.27202+00	
00000000-0000-0000-0000-000000000000	a3cc8448-b4b9-4070-85fc-dffa8f1bd029	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 16:56:51.786532+00	
00000000-0000-0000-0000-000000000000	7431ac1e-f486-4ffb-abc9-ec370831e68e	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-23 16:56:51.81257+00	
00000000-0000-0000-0000-000000000000	64131316-a222-490b-97cd-203476536aaf	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 03:22:33.161327+00	
00000000-0000-0000-0000-000000000000	08167c33-5bed-4c06-9988-468f98f44375	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 03:22:33.1817+00	
00000000-0000-0000-0000-000000000000	c2a529b2-d6d7-48ab-966e-2acc45274a5f	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 04:22:43.849766+00	
00000000-0000-0000-0000-000000000000	dd586524-5442-4ae9-bfba-f5f40576dc51	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 04:22:43.869423+00	
00000000-0000-0000-0000-000000000000	cf2a6b5a-8b06-4cc6-a862-9b8a60c12c71	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 05:22:43.905638+00	
00000000-0000-0000-0000-000000000000	16fcfbaa-8058-442f-8697-e73ae92c3cbb	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 05:22:43.92988+00	
00000000-0000-0000-0000-000000000000	14f4f800-3158-43f1-9f94-81a82bad3daf	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 06:22:43.823639+00	
00000000-0000-0000-0000-000000000000	8781d65b-762f-47f6-b1a3-d8fa5c4ce376	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 06:22:43.83855+00	
00000000-0000-0000-0000-000000000000	1990026e-1adc-4981-86e0-16d21f5c500c	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 10:26:43.457841+00	
00000000-0000-0000-0000-000000000000	d788107d-9613-478b-8699-6fe9ca0e07fa	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 10:26:43.479555+00	
00000000-0000-0000-0000-000000000000	548f38bf-26cd-4df4-b944-bdf94ef33d2b	{"action":"user_signedup","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-24 10:47:43.337026+00	
00000000-0000-0000-0000-000000000000	83493f24-97be-4248-8f7b-15bdbcb61743	{"action":"login","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-24 10:47:43.350876+00	
00000000-0000-0000-0000-000000000000	dfa5380f-555c-4bc1-aa92-a6e831611f08	{"action":"logout","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-24 10:47:43.713783+00	
00000000-0000-0000-0000-000000000000	992aca19-0580-4aec-9760-8f3f3e261d32	{"action":"login","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-24 10:48:32.23398+00	
00000000-0000-0000-0000-000000000000	e7264235-2b68-4f1c-bd8a-03e9d7c4b7b3	{"action":"login","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-24 10:53:01.190373+00	
00000000-0000-0000-0000-000000000000	43f454b7-a1ac-4b68-86cb-5c616195909e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 11:51:00.532907+00	
00000000-0000-0000-0000-000000000000	b0903e81-69d2-4fae-be74-bf27a9814b2e	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 11:51:00.553307+00	
00000000-0000-0000-0000-000000000000	524bf682-f152-4eb4-86d3-8f7e20dd1879	{"action":"token_refreshed","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 11:55:25.376425+00	
00000000-0000-0000-0000-000000000000	ac22ec2f-6a5a-4722-93f7-4a72c206ecb6	{"action":"token_revoked","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 11:55:25.380886+00	
00000000-0000-0000-0000-000000000000	4519b2a8-02bb-49dd-af13-f4546f984ded	{"action":"token_refreshed","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 12:04:53.851201+00	
00000000-0000-0000-0000-000000000000	4c13d09f-062b-4b5f-963a-0fc1b7cc5aca	{"action":"token_revoked","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 12:04:53.854277+00	
00000000-0000-0000-0000-000000000000	9d355f6d-5d3f-4e9d-987b-4678e5f1bd53	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 13:30:50.232906+00	
00000000-0000-0000-0000-000000000000	d7c48a2d-9dfc-4d7f-8e0a-249d72202122	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 13:30:50.253306+00	
00000000-0000-0000-0000-000000000000	c9871f05-0d56-4d45-93e8-c4f847065895	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 15:06:03.201268+00	
00000000-0000-0000-0000-000000000000	916d7c97-c770-4dfa-a5f9-9d2bc023906e	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 15:06:03.223252+00	
00000000-0000-0000-0000-000000000000	54b2de41-a89e-4e0c-92fd-0bb7cf04a788	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 16:09:58.508237+00	
00000000-0000-0000-0000-000000000000	a36b959b-482b-4527-aa4e-1fa2594d720a	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 16:09:58.522877+00	
00000000-0000-0000-0000-000000000000	b29e0632-ae76-4fc4-990f-156323a14757	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 17:09:42.619722+00	
00000000-0000-0000-0000-000000000000	1ece1e3d-8600-40a2-a27e-2792a29d006c	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 17:09:42.633404+00	
00000000-0000-0000-0000-000000000000	e475961e-697e-4919-a808-5e5f3c2165f9	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 18:09:42.688859+00	
00000000-0000-0000-0000-000000000000	10fd260d-1641-4308-b65a-508bfe8080e2	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 18:09:42.704449+00	
00000000-0000-0000-0000-000000000000	901a098d-d14a-42c4-b268-6d72e33f65bb	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 19:09:42.556509+00	
00000000-0000-0000-0000-000000000000	f60bbfab-f1fe-4602-90a0-1386dec41b27	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 19:09:42.575622+00	
00000000-0000-0000-0000-000000000000	a4cdd727-ac58-4633-82c9-aa9e8ca4e8ec	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 19:20:28.333538+00	
00000000-0000-0000-0000-000000000000	bf8c74e0-1b3c-41cb-859f-35f8f099fd8a	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 19:20:28.343683+00	
00000000-0000-0000-0000-000000000000	916d7768-4cfe-4ffc-8e88-b4a237297884	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 20:09:42.607641+00	
00000000-0000-0000-0000-000000000000	5a095d86-a71a-4272-8210-1c84db397c45	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 20:09:42.62321+00	
00000000-0000-0000-0000-000000000000	a910140b-cea8-4820-9202-ed3a64ecbb75	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 21:09:42.563816+00	
00000000-0000-0000-0000-000000000000	3f788273-10d5-461e-99de-bce6b527fc6e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 21:09:42.577028+00	
00000000-0000-0000-0000-000000000000	aabf33c4-5db5-48b8-9f17-2417e6d3c54d	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 22:09:42.621317+00	
00000000-0000-0000-0000-000000000000	40584a4d-b498-4032-98e3-04b017d7313c	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 22:09:42.631222+00	
00000000-0000-0000-0000-000000000000	bb37c260-f082-423d-a9fd-68f7c05634d6	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 23:09:42.589208+00	
00000000-0000-0000-0000-000000000000	20fe25cc-b820-4b65-9e6b-e262b960806e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-24 23:09:42.611506+00	
00000000-0000-0000-0000-000000000000	e8f6ae99-ac0c-462b-9b9a-2f5eed010a1b	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 00:09:42.46773+00	
00000000-0000-0000-0000-000000000000	606b6917-503b-4b19-868b-f36782ba510b	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 00:09:42.478598+00	
00000000-0000-0000-0000-000000000000	0a4da7eb-77e4-47b5-acd1-cac7093d10cd	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 01:09:42.568504+00	
00000000-0000-0000-0000-000000000000	0fe49243-ed1f-4d49-9e79-d13686083d42	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 01:09:42.582011+00	
00000000-0000-0000-0000-000000000000	3c663b48-7523-4e54-afea-3fcd9f41c661	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 02:09:42.456253+00	
00000000-0000-0000-0000-000000000000	91252f90-92d4-4551-8876-15b35e7335fc	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 02:09:42.468869+00	
00000000-0000-0000-0000-000000000000	c5b4e466-78bc-4ed9-8da9-2f0912168aa2	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 03:09:42.357346+00	
00000000-0000-0000-0000-000000000000	be6515af-7a64-4538-84b3-c396d78d00cb	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 03:09:42.367801+00	
00000000-0000-0000-0000-000000000000	d8b62a39-ebd8-4990-8b7e-d49cf166b170	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 04:09:42.446775+00	
00000000-0000-0000-0000-000000000000	2826417f-6a13-4ed0-969d-af366941c2b4	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 04:09:42.458105+00	
00000000-0000-0000-0000-000000000000	e9d28e7b-98f2-4cdf-97b4-c5a312eb5803	{"action":"token_refreshed","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 10:23:01.767411+00	
00000000-0000-0000-0000-000000000000	61bc2190-6642-4d2b-86bb-2142784f1810	{"action":"token_revoked","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-25 10:23:01.796766+00	
00000000-0000-0000-0000-000000000000	18d39276-d1e1-47fc-9f44-20d18b9b237a	{"action":"logout","actor_id":"53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd","actor_username":"alexandregrondin123@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-25 10:23:03.891084+00	
00000000-0000-0000-0000-000000000000	19f6e2ce-070b-400e-ad9e-9d21583137db	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 02:43:07.773557+00	
00000000-0000-0000-0000-000000000000	b71ad962-febc-46d0-b366-e35e0c657b53	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 02:43:07.797199+00	
00000000-0000-0000-0000-000000000000	e0377635-fc74-4087-bf84-d05895cb0263	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 22:03:43.290601+00	
00000000-0000-0000-0000-000000000000	a2ac5ade-be15-4cb6-9dc1-597ef14f6fb3	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-26 22:03:43.312443+00	
00000000-0000-0000-0000-000000000000	d2f515ab-6354-4847-8c94-e308cbb84454	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 17:03:58.646037+00	
00000000-0000-0000-0000-000000000000	e670bd7e-b31e-4727-9a68-bbd0a5d2274b	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 17:03:58.666174+00	
00000000-0000-0000-0000-000000000000	f0965c00-383a-4536-8244-a9052d75ec51	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 18:03:57.778561+00	
00000000-0000-0000-0000-000000000000	2708dd02-78c9-4359-aa6c-47fb8f4255a7	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 18:03:57.790051+00	
00000000-0000-0000-0000-000000000000	5568823e-d556-4bea-8814-73ec1d035b35	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 00:50:16.432687+00	
00000000-0000-0000-0000-000000000000	a0b3b8d4-7580-42ed-9157-396bcdf4acf6	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 00:50:16.448629+00	
00000000-0000-0000-0000-000000000000	a0045f3d-1596-42f7-bbe7-d8e22db67e5b	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 01:50:19.181518+00	
00000000-0000-0000-0000-000000000000	e6e5dd8a-f8a4-4b64-998d-414c5a833a3e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 01:50:19.193477+00	
00000000-0000-0000-0000-000000000000	8f55c70f-0304-46fa-92b9-259393ff0e7d	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 02:50:19.108245+00	
00000000-0000-0000-0000-000000000000	3ab0b678-d1a3-4bc0-b9a7-1835fa144e44	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 02:50:19.123877+00	
00000000-0000-0000-0000-000000000000	aad96c9d-f06b-4cec-a7f5-f35d8dbc1150	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 03:50:19.141974+00	
00000000-0000-0000-0000-000000000000	5ea859db-217b-403f-8a96-90083c811ba0	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 03:50:19.152722+00	
00000000-0000-0000-0000-000000000000	7ba445fd-e313-4781-a2c3-a0994e481aac	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 04:50:19.108324+00	
00000000-0000-0000-0000-000000000000	f1cfb8c8-7f41-45e9-9e97-1934c6125ca2	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 04:50:19.117292+00	
00000000-0000-0000-0000-000000000000	85a85c7d-7e00-44f9-83b5-083a786e96f0	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 15:44:30.44315+00	
00000000-0000-0000-0000-000000000000	4be29feb-4d98-4431-b3d4-02af4c00dd08	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 15:44:30.469926+00	
00000000-0000-0000-0000-000000000000	0c7a51cd-85ec-436d-b060-9d28069fa44a	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 16:44:26.692727+00	
00000000-0000-0000-0000-000000000000	0e887ae8-35dc-48c5-99e5-5f6b077e55d8	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 16:44:26.708417+00	
00000000-0000-0000-0000-000000000000	38248921-bb59-4d33-896a-df0575125774	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 05:11:39.716166+00	
00000000-0000-0000-0000-000000000000	c41d9f37-39f1-4c6d-91c6-31a781f6969c	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 05:11:39.739192+00	
00000000-0000-0000-0000-000000000000	0686f9c0-c495-4173-93ae-ff90f928c234	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:11:31.879058+00	
00000000-0000-0000-0000-000000000000	b7fb6b40-f312-4586-a5a5-05c5d5c48a74	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 06:11:31.889664+00	
00000000-0000-0000-0000-000000000000	b8d32b47-8bb8-422e-ac32-ccb6938d5bdf	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 07:11:31.686888+00	
00000000-0000-0000-0000-000000000000	c5578ed1-4402-43b8-92a8-32f365f46c9a	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 07:11:31.70789+00	
00000000-0000-0000-0000-000000000000	ec02d00f-870e-4628-b7b3-29bdb008af10	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 08:11:31.581574+00	
00000000-0000-0000-0000-000000000000	c174f33c-820e-413f-a167-c58dcfbb171d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 08:11:31.593877+00	
00000000-0000-0000-0000-000000000000	68332647-e153-473c-8489-3cc1bd6136da	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 15:36:16.702919+00	
00000000-0000-0000-0000-000000000000	60ad172d-df8f-438e-8024-7eb076b7a51d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 15:36:16.729081+00	
00000000-0000-0000-0000-000000000000	b6439671-8d71-4fbf-96e2-cc555d94f1e7	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 16:36:30.317648+00	
00000000-0000-0000-0000-000000000000	16c62985-b408-4574-9559-0e827802d45d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 16:36:30.328145+00	
00000000-0000-0000-0000-000000000000	1124bf55-b2cf-47c7-9adb-5c529e6681ea	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 02:01:46.472355+00	
00000000-0000-0000-0000-000000000000	091a13dc-4081-44a8-a870-d83fd892707d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 02:01:46.494001+00	
00000000-0000-0000-0000-000000000000	4e2e3b27-c91d-4189-b950-994cfac50491	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 03:01:29.171997+00	
00000000-0000-0000-0000-000000000000	5dee8ad7-2748-496c-b8f1-cd39d3be98b6	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 03:01:29.195129+00	
00000000-0000-0000-0000-000000000000	1a4bac6d-e82b-44a6-8b56-74501c32577f	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 04:01:29.097351+00	
00000000-0000-0000-0000-000000000000	b6b48848-2811-488b-9a4d-9bc26fa62bbb	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 04:01:29.119568+00	
00000000-0000-0000-0000-000000000000	61c99a75-bc84-4dd3-82d0-3013d624f486	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 05:20:02.683475+00	
00000000-0000-0000-0000-000000000000	be7b0f93-90cd-4a02-9cbf-8a854505bc8e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 05:20:02.7063+00	
00000000-0000-0000-0000-000000000000	bd93eff4-7f0d-4d68-8524-4104d87c1129	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 19:53:42.931148+00	
00000000-0000-0000-0000-000000000000	c47e80e7-0183-4d46-b0eb-c490cb1a01af	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 19:53:42.954265+00	
00000000-0000-0000-0000-000000000000	a10e29a7-71fb-4771-adbf-1323f322e33b	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 23:46:13.302249+00	
00000000-0000-0000-0000-000000000000	8b8e8372-da65-4617-b3c8-67be4ef94a42	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 23:46:13.328196+00	
00000000-0000-0000-0000-000000000000	1e6246ee-82e2-456b-8f35-c47197a2ec78	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 00:46:22.647556+00	
00000000-0000-0000-0000-000000000000	51e56faa-8d7d-4962-9967-96a7a04d9543	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 00:46:22.654664+00	
00000000-0000-0000-0000-000000000000	8febec72-4a63-44e4-85a3-ec7dc9c04208	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 01:46:22.711979+00	
00000000-0000-0000-0000-000000000000	12d58d68-9615-4dd7-9ce9-6e4f71ef72b2	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 01:46:22.733655+00	
00000000-0000-0000-0000-000000000000	481d2302-751b-46c9-9f9c-916888ab3fe7	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 02:46:22.722907+00	
00000000-0000-0000-0000-000000000000	64757715-e5a9-468e-bf63-f75e636b5f68	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 02:46:22.733098+00	
00000000-0000-0000-0000-000000000000	1a5e57af-d5ed-4c2e-a73d-922a7bedae20	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 03:46:22.616882+00	
00000000-0000-0000-0000-000000000000	6a5ced2b-5564-4a04-83a4-831e71a0d97e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 03:46:22.628695+00	
00000000-0000-0000-0000-000000000000	87a57e0a-6747-4378-8360-94f81be8b77a	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 04:46:22.792507+00	
00000000-0000-0000-0000-000000000000	fe767f30-7864-4fd2-a852-1fe8e175c773	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 04:46:22.820109+00	
00000000-0000-0000-0000-000000000000	f947ff7a-bc86-4395-af70-dc69340e9126	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 05:46:22.538899+00	
00000000-0000-0000-0000-000000000000	6684cd14-bbf3-462b-bc9c-6ea2f5767214	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 05:46:22.551634+00	
00000000-0000-0000-0000-000000000000	de3ac626-4189-41bf-9fba-469346a081b5	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 06:46:22.610143+00	
00000000-0000-0000-0000-000000000000	7732f863-3efe-47de-9e3d-19e29054b88e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 06:46:22.620277+00	
00000000-0000-0000-0000-000000000000	9a6a1d9b-ed93-471c-81b2-7ddcf649df43	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 07:46:22.543361+00	
00000000-0000-0000-0000-000000000000	105b378f-89c8-4010-b3c6-35b25650d26f	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 07:46:22.557844+00	
00000000-0000-0000-0000-000000000000	fb06000b-339f-4f0e-a01d-bfd4ca3219ef	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 11:48:06.93837+00	
00000000-0000-0000-0000-000000000000	4a1cde5b-97b8-4408-afed-493091add61d	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-01 11:48:06.967595+00	
00000000-0000-0000-0000-000000000000	4604fc14-02b9-4410-a15e-17fe1aaf6fae	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-03 20:21:02.323035+00	
00000000-0000-0000-0000-000000000000	14417f3c-6912-4b89-a287-d6448f699cb7	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 21:21:56.86917+00	
00000000-0000-0000-0000-000000000000	ae5abb94-06e5-4929-ba98-87d8017c2212	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-03 21:21:56.889899+00	
00000000-0000-0000-0000-000000000000	85bd2c27-0247-442f-90a8-9f12edfefd99	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-03 21:29:27.021847+00	
00000000-0000-0000-0000-000000000000	e0d8c2c0-9bff-4d43-88c8-682853d18d53	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-03 21:29:42.373357+00	
00000000-0000-0000-0000-000000000000	10fd966b-5aaa-468a-b42c-422d07eb314e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 16:47:56.503313+00	
00000000-0000-0000-0000-000000000000	0d704789-01f7-46d2-8edd-2c520dd01f5a	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-04 16:47:56.523196+00	
00000000-0000-0000-0000-000000000000	fae79c7f-ce9b-418a-860a-deaf71e38a89	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 18:00:46.008801+00	
00000000-0000-0000-0000-000000000000	9d6c9367-c6a6-4646-95f4-4247852c7472	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-04 18:04:55.322367+00	
00000000-0000-0000-0000-000000000000	a6decd83-cadd-4250-b6e5-75ba9e719f33	{"action":"user_signedup","actor_id":"eeaf1592-2675-4b0e-8029-561d0b38ccaa","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-04 18:05:11.127947+00	
00000000-0000-0000-0000-000000000000	b8a9db35-40cf-4009-af4c-ad008e8f74f3	{"action":"login","actor_id":"eeaf1592-2675-4b0e-8029-561d0b38ccaa","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 18:05:11.136472+00	
00000000-0000-0000-0000-000000000000	973db618-8526-4487-94e6-3d0fc843b104	{"action":"logout","actor_id":"eeaf1592-2675-4b0e-8029-561d0b38ccaa","actor_username":"test@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-04 18:05:22.706853+00	
00000000-0000-0000-0000-000000000000	3b5e1191-984f-4d84-9e05-8e6388948635	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 18:05:31.034923+00	
00000000-0000-0000-0000-000000000000	0197b59f-58ae-4155-a795-38d38cdb96ca	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-04 18:12:15.535539+00	
00000000-0000-0000-0000-000000000000	5822bc4c-b926-4b7b-84ea-00248338a736	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 18:12:25.556371+00	
00000000-0000-0000-0000-000000000000	50ae2978-bf59-4237-be83-eeba31058d72	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nathangrondin682@gmail.com","user_id":"deeca980-e06f-488c-9ef5-3d02a4dd5ac5","user_phone":""}}	2025-11-04 18:40:55.099587+00	
00000000-0000-0000-0000-000000000000	7b8adb85-4e81-4827-abfc-b56dbe1c6bc1	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"test@gmail.com","user_id":"eeaf1592-2675-4b0e-8029-561d0b38ccaa","user_phone":""}}	2025-11-04 18:40:55.498133+00	
00000000-0000-0000-0000-000000000000	88e3b1ab-59d4-4178-948e-07aefc128f99	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-04 18:59:44.147095+00	
00000000-0000-0000-0000-000000000000	a7c4e1a4-74bf-40a0-ba51-c3ac3ba34134	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 18:59:59.131934+00	
00000000-0000-0000-0000-000000000000	1112f9e4-7b5f-4515-b6b6-f00260189a28	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-04 19:09:10.205419+00	
00000000-0000-0000-0000-000000000000	5943f70d-cc8a-499e-a7bd-cf9ad196fb41	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-05 14:40:45.889445+00	
00000000-0000-0000-0000-000000000000	c5c8eb9f-aab0-4d82-91c0-729963068707	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 15:40:31.957987+00	
00000000-0000-0000-0000-000000000000	97f4be45-3e73-420b-ac19-c9f074046542	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-05 15:40:31.975328+00	
00000000-0000-0000-0000-000000000000	57e3b354-6623-41b4-8bf9-9da3998fc920	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:30:48.477542+00	
00000000-0000-0000-0000-000000000000	005eae91-0113-4d74-b7ad-cacd580addde	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 03:30:48.500214+00	
00000000-0000-0000-0000-000000000000	9cd317ef-279a-405f-9d5b-385e57a51baf	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 04:30:19.31906+00	
00000000-0000-0000-0000-000000000000	e4861ade-19a3-4add-92ea-787300684e18	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 04:30:19.330086+00	
00000000-0000-0000-0000-000000000000	957e8cef-e261-4a43-b985-19ccf29748ad	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:30:19.223092+00	
00000000-0000-0000-0000-000000000000	00f65024-88c3-4dc1-9bd2-17f6bf82e202	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 05:30:19.236381+00	
00000000-0000-0000-0000-000000000000	6be2b105-7a12-41cd-99f3-e1e6eb046f79	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 06:30:19.298309+00	
00000000-0000-0000-0000-000000000000	c908a35b-afb7-4463-a9a8-506b4103a90e	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 06:30:19.318958+00	
00000000-0000-0000-0000-000000000000	b89f94e8-9f94-46b2-9005-0ac204473f09	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 07:30:19.259041+00	
00000000-0000-0000-0000-000000000000	4dd89dae-8729-452f-9d22-45105816ac40	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 07:30:19.275334+00	
00000000-0000-0000-0000-000000000000	be37a2a5-2462-4608-b59a-edba88e876f3	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 08:30:19.195326+00	
00000000-0000-0000-0000-000000000000	290bf2eb-bb82-4596-aacb-77073d2e782d	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 08:30:19.209881+00	
00000000-0000-0000-0000-000000000000	12f8ecf2-b077-471e-92e1-7aaaafbf33d9	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 09:30:19.142987+00	
00000000-0000-0000-0000-000000000000	eab0bbc8-2b81-4434-8208-45f47e5d77ed	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 09:30:19.153357+00	
00000000-0000-0000-0000-000000000000	23fb0ef3-7926-4d24-970c-84fe8a210fa4	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 10:30:19.204996+00	
00000000-0000-0000-0000-000000000000	033a3c0c-aa9e-4fb9-84fa-f45038eb7891	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 10:30:19.222446+00	
00000000-0000-0000-0000-000000000000	fc44e184-8792-450b-9317-c760ee9d6050	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 11:30:19.078784+00	
00000000-0000-0000-0000-000000000000	cbfda7a1-8a82-41ae-9193-412588024656	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 11:30:19.09697+00	
00000000-0000-0000-0000-000000000000	04cea7b1-6429-496b-97d1-55780a46e1f8	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 12:30:19.095116+00	
00000000-0000-0000-0000-000000000000	429f8769-30ca-4630-a30b-f7fc1939256b	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 12:30:19.1098+00	
00000000-0000-0000-0000-000000000000	97e8490b-fae2-4ae5-a6d9-57f708c282d0	{"action":"token_refreshed","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 13:30:19.117891+00	
00000000-0000-0000-0000-000000000000	368590ef-57d8-4009-87a5-dbe97e530d1b	{"action":"token_revoked","actor_id":"4796942f-f64e-4f89-9c05-c62bbaf33ff4","actor_username":"adixi.night@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 13:30:19.129385+00	
00000000-0000-0000-0000-000000000000	c258dd38-139b-4127-b161-437088fc21f3	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 14:01:47.631428+00	
00000000-0000-0000-0000-000000000000	f5cb6a42-f22f-45f0-95dd-d7bb089ba6ba	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 14:01:47.645018+00	
00000000-0000-0000-0000-000000000000	dfb57853-07c6-4156-853d-12477e734baf	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 15:01:26.289603+00	
00000000-0000-0000-0000-000000000000	17dc6e5b-c2b8-4d3f-b131-4c4bc3f3fb72	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 15:01:26.306685+00	
00000000-0000-0000-0000-000000000000	22c58b0e-ad56-4095-ac5f-9bcde24d46ae	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 16:01:26.487242+00	
00000000-0000-0000-0000-000000000000	7146b9d3-4d17-4bca-8064-0bd86286ad9d	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-06 16:01:26.503338+00	
00000000-0000-0000-0000-000000000000	5850e10e-25c6-4924-92e9-45c4c94c9f47	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 07:47:21.667744+00	
00000000-0000-0000-0000-000000000000	248b20b4-84e7-4b56-abe7-36da0a73753c	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-07 07:47:21.687321+00	
00000000-0000-0000-0000-000000000000	8b0345f5-2781-4b6c-aca1-05b8387f26cd	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-08 19:15:50.41662+00	
00000000-0000-0000-0000-000000000000	f8002a4f-98e4-47b0-92cb-f844ea8e0a9e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:19:14.118195+00	
00000000-0000-0000-0000-000000000000	93258e79-b4af-4654-92a6-7a76d8e47f7b	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:19:14.144064+00	
00000000-0000-0000-0000-000000000000	d41eb5a9-875f-4de4-8918-ec194c1ca5cf	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:30:22.813542+00	
00000000-0000-0000-0000-000000000000	c155f5c5-59d9-4be9-ad92-07236f6e3717	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 12:30:22.82311+00	
00000000-0000-0000-0000-000000000000	45f4dd8a-ee5e-4d57-a2e7-cf4b2db6b9c9	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 12:33:54.809254+00	
00000000-0000-0000-0000-000000000000	c7ced036-056f-4820-a049-8f7fec87a18f	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 12:58:36.90448+00	
00000000-0000-0000-0000-000000000000	1acba48f-971a-47ee-8aaf-deddce5a1385	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 13:04:11.125586+00	
00000000-0000-0000-0000-000000000000	2b16cc36-1f59-41ea-beb6-7560248a173f	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 13:11:05.123109+00	
00000000-0000-0000-0000-000000000000	3ff8d9a1-cf0a-4d9a-9565-8342a18a9148	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 13:18:42.26238+00	
00000000-0000-0000-0000-000000000000	332f2034-efbc-4952-9af9-696908712136	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 13:18:42.268026+00	
00000000-0000-0000-0000-000000000000	4601debf-d483-49c1-8b11-6050d8beb70c	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 13:24:15.821363+00	
00000000-0000-0000-0000-000000000000	d92206ec-4a81-4f86-9e47-56e13b82bf39	{"action":"user_modified","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-11-09 13:58:27.230369+00	
00000000-0000-0000-0000-000000000000	eb3b45a5-5b3f-4522-ba43-408c3aa3ac35	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 14:02:26.798267+00	
00000000-0000-0000-0000-000000000000	f3d32ca7-926a-4b94-8e43-52e3f53c1855	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 14:03:16.733862+00	
00000000-0000-0000-0000-000000000000	092c86fb-403b-4be4-9215-2369b3a0fdf8	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 14:05:59.14375+00	
00000000-0000-0000-0000-000000000000	8b146c9e-2be0-4eeb-9505-893aba51e9ed	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 14:29:56.738559+00	
00000000-0000-0000-0000-000000000000	aaf8873c-c08f-43c6-ab02-8cc92a40b2af	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 14:39:19.510925+00	
00000000-0000-0000-0000-000000000000	889629d2-6990-4a25-89e0-bff3fc0b9d4e	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 14:59:59.206273+00	
00000000-0000-0000-0000-000000000000	f3bf93e2-fa5f-44cd-8eb3-a0cea957bf70	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 15:00:15.73826+00	
00000000-0000-0000-0000-000000000000	843b7cc6-925e-452f-9db1-0829d56dbae4	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 15:05:22.634515+00	
00000000-0000-0000-0000-000000000000	83972b86-689e-4a98-94a3-4b9952af0edd	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 15:05:22.647498+00	
00000000-0000-0000-0000-000000000000	0a500890-e008-4fd6-a711-f63f4059852f	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 15:19:40.749306+00	
00000000-0000-0000-0000-000000000000	d152481d-fb33-414c-994e-d449432b051b	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 15:19:53.767116+00	
00000000-0000-0000-0000-000000000000	e65c27e3-7eaa-40b2-8bf8-dcdcdf861ea9	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 15:19:57.265983+00	
00000000-0000-0000-0000-000000000000	cef6b67a-fb82-4137-841f-87c588362e9d	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 15:19:58.525938+00	
00000000-0000-0000-0000-000000000000	cb5634df-e544-4474-a70d-a2f790a3f122	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 15:20:02.936992+00	
00000000-0000-0000-0000-000000000000	2bc9580e-43fe-4aa3-917d-bb40ff4da332	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 16:19:23.156263+00	
00000000-0000-0000-0000-000000000000	88c7413a-a9db-4aa3-bdfa-e31e7f4618f4	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 16:19:23.169776+00	
00000000-0000-0000-0000-000000000000	3ec45b04-6edf-44ab-bd3a-5eed4959c413	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 17:00:30.971954+00	
00000000-0000-0000-0000-000000000000	c8949b8f-4f83-4e21-b949-8c06642f95ad	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 17:00:30.978487+00	
00000000-0000-0000-0000-000000000000	d83fc142-3035-40cf-bffa-f77ed595c196	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 17:03:14.726837+00	
00000000-0000-0000-0000-000000000000	7427774c-1556-4c52-9e37-cabd67169c6c	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 17:03:32.609657+00	
00000000-0000-0000-0000-000000000000	64c80cb5-fef5-42fb-9a95-3ffc70a5b41a	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 17:03:34.494844+00	
00000000-0000-0000-0000-000000000000	00f22e7c-398a-4140-afe4-d84d9891ad7b	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 17:20:48.824694+00	
00000000-0000-0000-0000-000000000000	eb27ad32-4cf9-4304-84b1-d35011e76ea3	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 17:21:10.517139+00	
00000000-0000-0000-0000-000000000000	e9fe53cf-5e51-44ac-924d-7f7c3b462c3b	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 20:00:56.821127+00	
00000000-0000-0000-0000-000000000000	91a03de9-3767-420c-b8df-9134ecfd9f93	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 20:00:56.830595+00	
00000000-0000-0000-0000-000000000000	dd1f984a-dc06-4bce-aea6-fc5d86fa343b	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-09 20:01:03.843801+00	
00000000-0000-0000-0000-000000000000	edad9b6f-9342-43c5-b01f-70a4d23f81d2	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 20:01:25.072776+00	
00000000-0000-0000-0000-000000000000	9f4e3bbb-e3f9-40e7-a66d-d259c830b510	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 21:01:22.271+00	
00000000-0000-0000-0000-000000000000	888d8328-0216-4bf6-93f2-6cc995f9e0a4	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 21:01:22.289883+00	
00000000-0000-0000-0000-000000000000	f795c51f-bf0b-414c-959d-aa9e1927298e	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 21:29:34.319032+00	
00000000-0000-0000-0000-000000000000	ee85af18-d4aa-4a87-a57d-0f6c5a04455e	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:01:22.273824+00	
00000000-0000-0000-0000-000000000000	8a9e7070-e105-4597-b0eb-28bee35bd9f7	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:01:22.299863+00	
00000000-0000-0000-0000-000000000000	7b8d7908-ce70-48ba-a09d-5f00a4524896	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:10:47.060695+00	
00000000-0000-0000-0000-000000000000	7fe9f944-71fc-4212-9ae5-2bf799cb3ecf	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-09 22:10:47.064796+00	
00000000-0000-0000-0000-000000000000	c02432c7-9096-4bab-bc2f-f91550b0d971	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-09 22:11:38.860406+00	
00000000-0000-0000-0000-000000000000	7dee0837-f72f-4e38-b544-48d718e692a0	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 05:08:29.878131+00	
00000000-0000-0000-0000-000000000000	644a3cc6-252e-4f4c-b66e-06f8b9fac59b	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 05:08:29.903091+00	
00000000-0000-0000-0000-000000000000	8fe8a798-5144-40aa-bce0-f03aeace909b	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 11:53:31.091614+00	
00000000-0000-0000-0000-000000000000	f6a56377-e9c9-47bf-9ec1-654094d3fd60	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 11:53:31.113333+00	
00000000-0000-0000-0000-000000000000	b9c5197a-34cd-4e66-9b55-d6246ad872e7	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 14:34:13.584874+00	
00000000-0000-0000-0000-000000000000	fb71e4bf-b7f3-42cd-98a7-523b705f23ca	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 14:34:13.600037+00	
00000000-0000-0000-0000-000000000000	a566a8b1-7bb3-4d0b-b70b-55359f335fcc	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 15:28:18.227784+00	
00000000-0000-0000-0000-000000000000	f6394089-fa96-4138-bf9b-90f312563592	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 15:28:18.238132+00	
00000000-0000-0000-0000-000000000000	bf3b2730-18da-49ef-aaee-cdf3f494dd23	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-10 15:44:43.99505+00	
00000000-0000-0000-0000-000000000000	3510eaee-e234-48d0-9403-fe3ef8df8cfd	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 15:45:16.904909+00	
00000000-0000-0000-0000-000000000000	7a5a3e55-d1e6-481d-8750-faf19a65efcc	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 15:45:20.667301+00	
00000000-0000-0000-0000-000000000000	196088a2-73fc-4783-8ec6-b35052a3aa07	{"action":"user_signedup","actor_id":"a773f6e9-aad0-43f1-a8e0-ef5320dae958","actor_username":"ndevillers21@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-11-10 15:46:51.638512+00	
00000000-0000-0000-0000-000000000000	65ed1d8b-0065-4f17-8260-661eb1f3f7d6	{"action":"login","actor_id":"a773f6e9-aad0-43f1-a8e0-ef5320dae958","actor_username":"ndevillers21@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 15:46:51.647449+00	
00000000-0000-0000-0000-000000000000	0542db69-8cbd-49d0-95ed-fd976cf3a0d1	{"action":"logout","actor_id":"a773f6e9-aad0-43f1-a8e0-ef5320dae958","actor_username":"ndevillers21@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-10 15:46:52.053292+00	
00000000-0000-0000-0000-000000000000	445adcff-4294-4ac6-a297-9a843f6e4838	{"action":"login","actor_id":"a773f6e9-aad0-43f1-a8e0-ef5320dae958","actor_username":"ndevillers21@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 15:47:24.793777+00	
00000000-0000-0000-0000-000000000000	f5550a3b-8144-4afa-9133-48c51571ca13	{"action":"logout","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-11-10 16:15:16.193449+00	
00000000-0000-0000-0000-000000000000	562bf6d1-2e22-4ce9-a81e-b529af20a5f6	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 16:15:28.366639+00	
00000000-0000-0000-0000-000000000000	300f2bf0-6c53-44ba-84d1-bf504917c4d1	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 16:17:43.035049+00	
00000000-0000-0000-0000-000000000000	6fdb0136-07f1-4b2f-bb92-38cc1eef7fa2	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 16:17:43.037345+00	
00000000-0000-0000-0000-000000000000	9df2f99a-f0f5-493c-8840-749c3ae8c0f7	{"action":"token_refreshed","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 22:39:29.650258+00	
00000000-0000-0000-0000-000000000000	8bda3943-6dbb-459d-bbc9-662a3196c722	{"action":"token_revoked","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-11-10 22:39:29.673648+00	
00000000-0000-0000-0000-000000000000	a729516b-ebe6-4d6e-a527-288552956c81	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-10 23:18:42.932624+00	
00000000-0000-0000-0000-000000000000	dc22c882-0229-40fb-a7c7-cb4ea53e01c0	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-11 00:27:45.906806+00	
00000000-0000-0000-0000-000000000000	0e09450b-c722-4ca2-869c-5977f16989f5	{"action":"login","actor_id":"212cdfee-bdfd-4a38-affd-7546df01cc02","actor_username":"nathangrondin683@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-11-11 00:28:39.649171+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
ce772ccc-041b-44af-b435-ecd1e2631993	16df2e2f-3bb5-4eb9-9202-7dee8e747049	7df9c5ca-e45e-4631-95e5-f70971a31ced	s256	aOEcetft4xqu-JwDrYKy7rZ0DYLZqQb5OUuVqrJjZtA	email			2025-10-17 23:17:33.401567+00	2025-10-17 23:17:33.401567+00	email/signup	\N
0dc709d5-e2f7-46ce-a7c0-6c136508269c	16df2e2f-3bb5-4eb9-9202-7dee8e747049	8a805707-c24a-4204-9e97-4d69157629a7	s256	i9FHun-JjQ-4fa-5KFt72LSK0BzSZhUqXsJwnDiRLwQ	email			2025-10-17 23:18:33.515759+00	2025-10-17 23:18:33.515759+00	email/signup	\N
0f57124f-0beb-4ccb-adaa-92846df900f1	16df2e2f-3bb5-4eb9-9202-7dee8e747049	93cfae0d-4b24-4080-9cc5-085d467bc796	s256	_fxKWRXZq-UbGV-Dyvq57GjI8FMpkB6ImGB1Jsa1a8I	email			2025-10-17 23:19:34.65935+00	2025-10-17 23:19:34.65935+00	email/signup	\N
8d6e4845-8322-4d94-bd09-bb50d738be1c	ff39ae1d-7437-4ec2-b6c6-15c8a9fd1328	6f45eeab-6ba3-4666-953c-ca30ab072b64	s256	YYbY6wT471BXa77E5O6z17jGhSlu2Gs8SYJMYBbe_RI	email			2025-10-17 23:24:11.736442+00	2025-10-17 23:24:11.736442+00	email/signup	\N
eaba2eb9-f3ff-4381-9897-f4104e09727e	80c3cc7a-6edf-472c-8e01-0102c2d239c9	9a7f4e23-a728-4a55-a050-0c137825deb9	s256	LaZ3sb6vAKqFOoZLl2DJpAPWYdKFUYOAUb4C4oAENpY	email			2025-10-17 23:25:26.916047+00	2025-10-17 23:25:26.916047+00	email/signup	\N
6383b229-3d64-4a0b-b341-3609f09407e7	80c3cc7a-6edf-472c-8e01-0102c2d239c9	1998ec3c-69d1-4bb1-a8de-718d84363936	s256	oGD7c25BLQj0nXpfuw4UswJ_7mU81LYrEPgTu4357h8	email			2025-10-17 23:27:50.627327+00	2025-10-17 23:27:50.627327+00	email/signup	\N
f0405e6c-6d00-4864-8288-f44707ec908f	c7db5746-113c-4d7a-94a2-6157cea871bb	5a15aa61-1dd6-4fea-8231-49dc0383ad1d	s256	UF_gfy3stuVkDKTRsgZUt72KFURPjYIU1SbWnLT5aGc	email			2025-10-17 23:35:59.087261+00	2025-10-17 23:36:06.204428+00	email/signup	2025-10-17 23:36:06.204392+00
132de594-f59d-4ad8-b779-b569a7e467b6	59df146e-e6f4-4bb9-8c65-4165b6993b95	3b7a1a4e-a34d-4af3-8c7b-4f2e3998a2fa	s256	rtkMPxuYwBqrFzaoNbv99gW_HKuf5IWH5XOTuw-l1p0	email			2025-10-17 23:39:22.199255+00	2025-10-17 23:39:32.602078+00	email/signup	2025-10-17 23:39:32.602037+00
a416ed45-5858-4d9a-8250-388ba3b0c1fa	45d15cac-7142-4e80-b6fb-244c261c69a2	bdf1a050-7d50-4711-8c40-016c7c99cef3	s256	-kaYI317y7aVMp9RPc-5Oo8xw8nF71XiqnGQHoG83GQ	email			2025-10-17 23:49:35.581877+00	2025-10-17 23:50:19.950573+00	email/signup	2025-10-17 23:50:19.950522+00
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
212cdfee-bdfd-4a38-affd-7546df01cc02	212cdfee-bdfd-4a38-affd-7546df01cc02	{"sub": "212cdfee-bdfd-4a38-affd-7546df01cc02", "email": "nathangrondin683@gmail.com", "last_name": "Grondin", "first_name": "Nathan", "email_verified": false, "phone_verified": false}	email	2025-10-19 18:14:05.186818+00	2025-10-19 18:14:05.186874+00	2025-10-19 18:14:05.186874+00	3de70520-bdd7-40dd-8125-6f6ba234200e
4796942f-f64e-4f89-9c05-c62bbaf33ff4	4796942f-f64e-4f89-9c05-c62bbaf33ff4	{"sub": "4796942f-f64e-4f89-9c05-c62bbaf33ff4", "email": "adixi.night@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-10-20 07:41:18.5479+00	2025-10-20 07:41:18.547956+00	2025-10-20 07:41:18.547956+00	9c277290-c1d5-4418-a295-9fb1aeabf4fb
1981ba9f-2416-40b0-b484-8f33e2242d66	1981ba9f-2416-40b0-b484-8f33e2242d66	{"sub": "1981ba9f-2416-40b0-b484-8f33e2242d66", "email": "esoum18@gmail.com", "last_name": "Soum", "first_name": "Enzo", "email_verified": false, "phone_verified": false}	email	2025-10-22 07:12:35.132387+00	2025-10-22 07:12:35.132441+00	2025-10-22 07:12:35.132441+00	6a80b03f-061e-4a3e-b8ac-72bf9a284171
53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	{"sub": "53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd", "email": "alexandregrondin123@gmail.com", "last_name": "Grondin", "first_name": "Alexandre", "email_verified": false, "phone_verified": false}	email	2025-10-24 10:47:43.321873+00	2025-10-24 10:47:43.321926+00	2025-10-24 10:47:43.321926+00	32cee646-43aa-4211-b5cf-fe1d8ceb5c40
a773f6e9-aad0-43f1-a8e0-ef5320dae958	a773f6e9-aad0-43f1-a8e0-ef5320dae958	{"sub": "a773f6e9-aad0-43f1-a8e0-ef5320dae958", "email": "ndevillers21@gmail.com", "last_name": "Devillers", "first_name": "Nathalie", "email_verified": false, "phone_verified": false}	email	2025-11-10 15:46:51.629214+00	2025-11-10 15:46:51.62928+00	2025-11-10 15:46:51.62928+00	091d5f16-2025-4115-b8e4-6a499787b6ea
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
8e578290-fc5f-4b5f-87bb-3e44ad01e68d	2025-11-04 18:59:59.172548+00	2025-11-04 18:59:59.172548+00	password	e9fc6dff-618b-4fea-89df-ed80b9504d62
72e799b2-be19-417e-aabb-232a3e4df775	2025-11-08 19:15:50.47972+00	2025-11-08 19:15:50.47972+00	password	193f5c86-b639-4966-afff-2632910fa30b
f8607297-eac6-4107-9e3b-7418da91d5f8	2025-11-09 12:33:54.826945+00	2025-11-09 12:33:54.826945+00	password	55850fde-1504-4d5d-b777-724c06ad74ef
a7514806-af16-44a2-b3ba-a10afa645488	2025-11-09 12:58:37.005608+00	2025-11-09 12:58:37.005608+00	password	cf5478ea-9642-4060-8e28-22d277df37fa
41b39ad1-7ddc-4f6e-b7c4-b6d63562cc5f	2025-11-09 13:04:11.155347+00	2025-11-09 13:04:11.155347+00	password	4f34affa-442c-43ca-b1b2-f08d99bf2eca
4b19a91b-c2c9-4bfe-aec6-e6edff42cafa	2025-11-09 13:11:05.176216+00	2025-11-09 13:11:05.176216+00	password	4a536179-bd6a-4bd2-ac2b-a929bd150379
324a446d-a8c2-42eb-922b-bb54f7808221	2025-11-09 13:24:15.876694+00	2025-11-09 13:24:15.876694+00	password	8a8b1534-8aa3-41f7-be39-37bad8f8412b
4a4d3c6e-1a2a-4fab-ac41-aec7f9a3c1b9	2025-11-09 14:02:26.885775+00	2025-11-09 14:02:26.885775+00	password	74de7fe8-f1b2-4243-9485-839f2265440e
c3fa4381-323f-4c77-ba21-7e3cc42c48f4	2025-11-09 14:39:19.552339+00	2025-11-09 14:39:19.552339+00	password	658f4f87-a740-49c7-a11f-d1f820b2062a
4d4c915d-e73e-42cb-87d9-956d0a9022d2	2025-11-09 15:19:53.796462+00	2025-11-09 15:19:53.796462+00	password	7d53f5b2-99f2-452b-9bc7-dce1f6ca885e
1433d76f-324f-415c-9afe-b76ffc91a0ec	2025-11-09 15:19:57.271028+00	2025-11-09 15:19:57.271028+00	password	6822b40c-3eab-4563-b57b-9f8406877866
fa5e816b-29fb-4a69-a8e2-cf1d8ca3d3e2	2025-11-09 15:19:58.531159+00	2025-11-09 15:19:58.531159+00	password	3904b828-0afe-4d38-9352-2537d9ab6369
68aba8f2-d484-46dc-a7e3-fc7caaca8267	2025-11-09 17:03:32.657333+00	2025-11-09 17:03:32.657333+00	password	062d2ac1-1847-4bbe-8945-219797dac95c
eb91be93-cfa6-4fb6-adbc-8e4b6a41ac1d	2025-11-09 17:21:10.539104+00	2025-11-09 17:21:10.539104+00	password	8b2ad7ef-873b-423b-b1e2-f8f8f70c6c11
e83478af-7479-4522-9e57-c3bb36a3fa51	2025-11-09 20:01:25.084077+00	2025-11-09 20:01:25.084077+00	password	762a9e84-d68b-4111-866a-f9ca19ee845e
4c23a07b-80b1-485b-af3e-6cce18e5b236	2025-11-09 21:29:34.380781+00	2025-11-09 21:29:34.380781+00	password	3a3c8d1d-9dec-43de-8f28-ed730c10e8ae
e3d96228-f5a9-4fa5-a64f-e2328c340fe3	2025-11-09 22:11:38.879254+00	2025-11-09 22:11:38.879254+00	password	e1f5865e-75bf-43c2-a3bd-02ac954f524a
0680616c-b5bb-4370-83ad-45602dcf7a8c	2025-11-10 15:45:16.946633+00	2025-11-10 15:45:16.946633+00	password	ec415684-e400-4273-b698-6941b16a2d9e
f439bff6-6966-4996-98df-598db06b2225	2025-10-21 16:07:55.184741+00	2025-10-21 16:07:55.184741+00	password	b4ae4dce-7e19-4cc4-9ea3-ab78ff93a272
b56961cf-f02f-4d83-bbd5-c645ba6da50c	2025-10-21 16:37:56.70911+00	2025-10-21 16:37:56.70911+00	password	e6f87b57-97eb-4b58-b2e1-81d20a7f8d8b
5b50fc75-6fc6-4ede-bd68-5d1713f86d17	2025-11-10 15:47:24.796981+00	2025-11-10 15:47:24.796981+00	password	bb00a5b6-288f-41ee-aa3e-776a27262230
65cbc9f9-522c-4004-bc15-4e6ef4679cd2	2025-11-10 16:15:28.390524+00	2025-11-10 16:15:28.390524+00	password	e98ab3ae-4076-4828-abac-c8f324ec5551
709c6bd8-ea70-4b24-ba32-6975051d6b84	2025-11-10 23:18:43.012287+00	2025-11-10 23:18:43.012287+00	password	62f22684-7442-4cd5-9256-3c0e7e306343
41756d12-c577-409f-821e-382a92bb2806	2025-11-11 00:27:45.961686+00	2025-11-11 00:27:45.961686+00	password	11e8f1e6-4527-4b39-943d-ddc08188048b
73d48dbe-5e29-4e74-8757-921b12411fe9	2025-11-11 00:28:39.660559+00	2025-11-11 00:28:39.660559+00	password	d2460fad-7d08-4da1-bf10-501babba1c4b
aa0d20a0-5de5-4b40-bde5-07de565d6bcb	2025-10-24 10:53:01.195545+00	2025-10-24 10:53:01.195545+00	password	30c76986-98f1-4f09-88b1-0dad0f805b4e
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	231	mj2d463lnv35	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 17:16:57.945566+00	2025-10-23 00:42:24.950584+00	6y3vwtalxr2f	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	235	ydq55zbkkaia	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-23 00:42:24.974646+00	2025-10-23 01:42:10.272722+00	mj2d463lnv35	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	236	hk7e6bk3z52v	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-23 01:42:10.286895+00	2025-10-24 03:22:33.182393+00	ydq55zbkkaia	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	183	bnrsmgtwrraf	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-21 16:07:55.180687+00	2025-10-21 20:20:52.751375+00	\N	f439bff6-6966-4996-98df-598db06b2225
00000000-0000-0000-0000-000000000000	238	o3oyetzd7b2v	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 03:22:33.199884+00	2025-10-24 04:22:43.871636+00	hk7e6bk3z52v	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	239	4vqvkp6ivfiq	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 04:22:43.888984+00	2025-10-24 05:22:43.932012+00	o3oyetzd7b2v	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	311	kuemzg2ofcup	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 04:30:19.342393+00	2025-11-06 05:30:19.237696+00	syoh23ftk6rq	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	240	5vatloetstan	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 05:22:43.95134+00	2025-10-24 06:22:43.839377+00	4vqvkp6ivfiq	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	313	5x3dn2vxde3b	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 06:30:19.333086+00	2025-11-06 07:30:19.277273+00	rbjwcxf2quqp	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	315	kd3hseb5m57x	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 08:30:19.224523+00	2025-11-06 09:30:19.158362+00	ipphj6fuzh45	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	190	x6m35mewm5c4	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-21 17:38:03.059591+00	2025-10-22 01:36:31.368751+00	eqqwdofopoxr	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	317	ikyrcckag35j	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 10:30:19.24811+00	2025-11-06 11:30:19.099395+00	epydidx6j6tp	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	208	ij6pcbgfd5zb	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 01:36:31.390483+00	2025-10-22 02:35:57.990417+00	x6m35mewm5c4	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	319	3siluhyrjynj	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 12:30:19.134214+00	2025-11-06 13:30:19.133068+00	ya7h6f5ztbky	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	209	4goxmv64uju2	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 02:35:58.004447+00	2025-10-22 03:35:22.540826+00	ij6pcbgfd5zb	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	210	cdbymsnokrjx	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 03:35:22.555155+00	2025-10-22 04:35:13.105083+00	4goxmv64uju2	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	245	lkyyeawse46t	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	t	2025-10-24 10:53:01.193061+00	2025-10-24 11:55:25.38153+00	\N	aa0d20a0-5de5-4b40-bde5-07de565d6bcb
00000000-0000-0000-0000-000000000000	211	jqjjwejxozuv	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 04:35:13.11959+00	2025-10-22 05:34:40.514026+00	cdbymsnokrjx	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	247	xvvyyp4gjwot	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	f	2025-10-24 11:55:25.386336+00	2025-10-24 11:55:25.386336+00	lkyyeawse46t	aa0d20a0-5de5-4b40-bde5-07de565d6bcb
00000000-0000-0000-0000-000000000000	213	weqpe6ohmbg6	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 05:34:40.517964+00	2025-10-22 06:34:12.751637+00	jqjjwejxozuv	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	241	jy2rdqru33o2	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 06:22:43.847838+00	2025-10-24 16:09:58.524837+00	5vatloetstan	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	325	g2kdhrpfdvdm	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-08 19:15:50.452529+00	2025-11-09 12:30:22.823866+00	\N	72e799b2-be19-417e-aabb-232a3e4df775
00000000-0000-0000-0000-000000000000	251	je4cjjforfxe	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 16:09:58.536585+00	2025-10-24 17:09:42.636333+00	jy2rdqru33o2	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	327	6ae536opm7ex	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 12:30:22.830005+00	2025-11-09 12:30:22.830005+00	g2kdhrpfdvdm	72e799b2-be19-417e-aabb-232a3e4df775
00000000-0000-0000-0000-000000000000	328	7vk6faucss3b	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 12:33:54.82471+00	2025-11-09 12:33:54.82471+00	\N	f8607297-eac6-4107-9e3b-7418da91d5f8
00000000-0000-0000-0000-000000000000	329	dswew3pishcb	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 12:58:36.96253+00	2025-11-09 12:58:36.96253+00	\N	a7514806-af16-44a2-b3ba-a10afa645488
00000000-0000-0000-0000-000000000000	330	v667nowsoy5h	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 13:04:11.145944+00	2025-11-09 13:04:11.145944+00	\N	41b39ad1-7ddc-4f6e-b7c4-b6d63562cc5f
00000000-0000-0000-0000-000000000000	331	i7uvin6ibfij	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 13:11:05.161595+00	2025-11-09 13:11:05.161595+00	\N	4b19a91b-c2c9-4bfe-aec6-e6edff42cafa
00000000-0000-0000-0000-000000000000	333	hyd6teoo6oto	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 13:24:15.855722+00	2025-11-09 13:24:15.855722+00	\N	324a446d-a8c2-42eb-922b-bb54f7808221
00000000-0000-0000-0000-000000000000	334	tbnrunzcwu6d	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 14:02:26.853845+00	2025-11-09 14:02:26.853845+00	\N	4a4d3c6e-1a2a-4fab-ac41-aec7f9a3c1b9
00000000-0000-0000-0000-000000000000	337	o2bnfctoueos	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 14:39:19.535119+00	2025-11-09 14:39:19.535119+00	\N	c3fa4381-323f-4c77-ba21-7e3cc42c48f4
00000000-0000-0000-0000-000000000000	340	ksftdo46iwyc	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 15:19:53.787661+00	2025-11-09 15:19:53.787661+00	\N	4d4c915d-e73e-42cb-87d9-956d0a9022d2
00000000-0000-0000-0000-000000000000	341	aohzgvu5mkdh	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 15:19:57.268566+00	2025-11-09 15:19:57.268566+00	\N	1433d76f-324f-415c-9afe-b76ffc91a0ec
00000000-0000-0000-0000-000000000000	342	tcrumnqwp6db	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 15:19:58.528723+00	2025-11-09 15:19:58.528723+00	\N	fa5e816b-29fb-4a69-a8e2-cf1d8ca3d3e2
00000000-0000-0000-0000-000000000000	346	ujppm7zielpo	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 17:03:32.636466+00	2025-11-09 17:03:32.636466+00	\N	68aba8f2-d484-46dc-a7e3-fc7caaca8267
00000000-0000-0000-0000-000000000000	350	bdpa7mkw7wum	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-09 20:01:25.080208+00	2025-11-09 21:01:22.292627+00	\N	e83478af-7479-4522-9e57-c3bb36a3fa51
00000000-0000-0000-0000-000000000000	352	no7plqilxn7v	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 21:29:34.350569+00	2025-11-09 21:29:34.350569+00	\N	4c23a07b-80b1-485b-af3e-6cce18e5b236
00000000-0000-0000-0000-000000000000	351	b556shvjykcq	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-09 21:01:22.312534+00	2025-11-09 22:01:22.303332+00	bdpa7mkw7wum	e83478af-7479-4522-9e57-c3bb36a3fa51
00000000-0000-0000-0000-000000000000	186	eqqwdofopoxr	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-21 16:37:56.693259+00	2025-10-21 17:38:03.05742+00	\N	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	353	3qpzcxyztxsj	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 22:01:22.325567+00	2025-11-09 22:01:22.325567+00	b556shvjykcq	e83478af-7479-4522-9e57-c3bb36a3fa51
00000000-0000-0000-0000-000000000000	348	nuifdhkutlqj	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-09 17:21:10.532257+00	2025-11-09 22:10:47.072486+00	\N	eb91be93-cfa6-4fb6-adbc-8e4b6a41ac1d
00000000-0000-0000-0000-000000000000	354	zvepc3qfdkek	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-09 22:10:47.07463+00	2025-11-09 22:10:47.07463+00	nuifdhkutlqj	eb91be93-cfa6-4fb6-adbc-8e4b6a41ac1d
00000000-0000-0000-0000-000000000000	200	6yrsdo6g4gco	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-21 20:20:52.752233+00	2025-10-22 16:23:34.021189+00	bnrsmgtwrraf	f439bff6-6966-4996-98df-598db06b2225
00000000-0000-0000-0000-000000000000	214	6y3vwtalxr2f	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 06:34:12.766945+00	2025-10-22 17:16:57.92973+00	weqpe6ohmbg6	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	229	rup4tgpfdueh	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-22 16:23:34.032926+00	2025-10-22 17:23:44.259405+00	6yrsdo6g4gco	f439bff6-6966-4996-98df-598db06b2225
00000000-0000-0000-0000-000000000000	232	dypp2dit66e6	4796942f-f64e-4f89-9c05-c62bbaf33ff4	f	2025-10-22 17:23:44.264612+00	2025-10-22 17:23:44.264612+00	rup4tgpfdueh	f439bff6-6966-4996-98df-598db06b2225
00000000-0000-0000-0000-000000000000	252	rt7nha2yx6ti	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 17:09:42.649101+00	2025-10-24 18:09:42.705897+00	je4cjjforfxe	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	253	3juiij4gvag5	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 18:09:42.715022+00	2025-10-24 19:09:42.57696+00	rt7nha2yx6ti	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	306	jtn7xszz32il	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-04 18:59:59.154816+00	2025-11-04 18:59:59.154816+00	\N	8e578290-fc5f-4b5f-87bb-3e44ad01e68d
00000000-0000-0000-0000-000000000000	254	623uovt6g6qn	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 19:09:42.589498+00	2025-10-24 20:09:42.625014+00	3juiij4gvag5	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	256	czj23jt6xvp3	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 20:09:42.641825+00	2025-10-24 21:09:42.584214+00	623uovt6g6qn	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	257	t2efoxg3k6ho	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 21:09:42.593652+00	2025-10-24 22:09:42.633049+00	czj23jt6xvp3	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	296	zp7zukj2h3dj	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 07:46:22.574323+00	2025-11-06 03:30:48.502102+00	dc6debrlvwpn	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	258	uhp5ka5mtzpb	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 22:09:42.646457+00	2025-10-24 23:09:42.612824+00	t2efoxg3k6ho	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	259	zolbiydre47t	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-24 23:09:42.627192+00	2025-10-25 00:09:42.480474+00	uhp5ka5mtzpb	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	310	syoh23ftk6rq	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 03:30:48.520621+00	2025-11-06 04:30:19.332918+00	zp7zukj2h3dj	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	260	u6x2rsy7ondb	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-25 00:09:42.495351+00	2025-10-25 01:09:42.584508+00	zolbiydre47t	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	261	onxiu5eym7mv	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-25 01:09:42.597797+00	2025-10-25 02:09:42.472333+00	u6x2rsy7ondb	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	312	rbjwcxf2quqp	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 05:30:19.254266+00	2025-11-06 06:30:19.321168+00	kuemzg2ofcup	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	262	wq2sqt6iziyy	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-25 02:09:42.491296+00	2025-10-25 03:09:42.369623+00	onxiu5eym7mv	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	263	sy2bdd7cfxug	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-25 03:09:42.379224+00	2025-10-25 04:09:42.459984+00	wq2sqt6iziyy	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	314	ipphj6fuzh45	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 07:30:19.290315+00	2025-11-06 08:30:19.212722+00	5x3dn2vxde3b	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	264	7htmaxm7nkli	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-25 04:09:42.472994+00	2025-10-26 02:43:07.800859+00	sy2bdd7cfxug	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	316	epydidx6j6tp	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 09:30:19.168379+00	2025-11-06 10:30:19.223989+00	kd3hseb5m57x	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	318	ya7h6f5ztbky	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-06 11:30:19.114562+00	2025-11-06 12:30:19.114443+00	ikyrcckag35j	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	266	ctnolkcpf23j	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-26 02:43:07.821108+00	2025-10-27 17:03:58.667497+00	7htmaxm7nkli	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	320	4a7t5qdpdd3j	4796942f-f64e-4f89-9c05-c62bbaf33ff4	f	2025-11-06 13:30:19.144022+00	2025-11-06 13:30:19.144022+00	3siluhyrjynj	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	268	nkugg7qm5h57	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-27 17:03:58.686519+00	2025-10-27 18:03:57.793209+00	ctnolkcpf23j	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	269	ls5wrcja4vqh	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-27 18:03:57.805736+00	2025-10-28 00:50:16.450671+00	nkugg7qm5h57	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	270	kliaespxxobl	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 00:50:16.468511+00	2025-10-28 01:50:19.194158+00	ls5wrcja4vqh	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	271	ofzyxnzqik4g	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 01:50:19.199893+00	2025-10-28 02:50:19.125915+00	kliaespxxobl	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	272	svloi3touqjy	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 02:50:19.138426+00	2025-10-28 03:50:19.159308+00	ofzyxnzqik4g	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	273	vjnrffbewbbc	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 03:50:19.16982+00	2025-10-28 04:50:19.118591+00	svloi3touqjy	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	274	yjmki6gixpnq	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 04:50:19.128443+00	2025-10-28 15:44:30.471783+00	vjnrffbewbbc	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	275	tl7jgi4kefsj	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 15:44:30.494856+00	2025-10-28 16:44:26.71192+00	yjmki6gixpnq	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	276	azebg4vyvmwu	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-28 16:44:26.72308+00	2025-10-29 05:11:39.741737+00	tl7jgi4kefsj	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	277	nkwbswssendc	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 05:11:39.766272+00	2025-10-29 06:11:31.891664+00	azebg4vyvmwu	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	278	bg4mbi2ls5by	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 06:11:31.903298+00	2025-10-29 07:11:31.709104+00	nkwbswssendc	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	279	rjqkkpysdgwx	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 07:11:31.722153+00	2025-10-29 08:11:31.595696+00	bg4mbi2ls5by	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	280	fumtqzz2ajrw	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 08:11:31.604398+00	2025-10-29 15:36:16.730406+00	rjqkkpysdgwx	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	281	p6mw22dgwg7j	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 15:36:16.748656+00	2025-10-29 16:36:30.330023+00	fumtqzz2ajrw	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	282	ymwdaboyznj2	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-29 16:36:30.338958+00	2025-10-30 02:01:46.494675+00	p6mw22dgwg7j	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	283	mad3jf4gq4kq	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-30 02:01:46.517453+00	2025-10-30 03:01:29.195935+00	ymwdaboyznj2	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	284	ldvier3dh3gt	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-30 03:01:29.211813+00	2025-10-30 04:01:29.122634+00	mad3jf4gq4kq	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	285	3o52oq2xmm72	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-30 04:01:29.146221+00	2025-10-30 05:20:02.708281+00	ldvier3dh3gt	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	286	g4xgulsj5kjg	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-30 05:20:02.727885+00	2025-10-30 19:53:42.954882+00	3o52oq2xmm72	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	287	kb3s4k5ck2al	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-30 19:53:42.977286+00	2025-10-31 23:46:13.328896+00	g4xgulsj5kjg	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	288	cpdtpqwfh36c	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-10-31 23:46:13.352028+00	2025-11-01 00:46:22.657475+00	kb3s4k5ck2al	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	289	57d3hg6b6a3l	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 00:46:22.666503+00	2025-11-01 01:46:22.740248+00	cpdtpqwfh36c	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	290	wsguvqtzvnar	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 01:46:22.749265+00	2025-11-01 02:46:22.734827+00	57d3hg6b6a3l	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	291	hhufriwcfvxp	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 02:46:22.742281+00	2025-11-01 03:46:22.629293+00	wsguvqtzvnar	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	292	lrx5rtrjnqso	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 03:46:22.643332+00	2025-11-01 04:46:22.823643+00	hhufriwcfvxp	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	293	kuudcedujoms	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 04:46:22.845076+00	2025-11-01 05:46:22.556272+00	lrx5rtrjnqso	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	294	vxgt25qdetl4	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 05:46:22.565681+00	2025-11-01 06:46:22.621989+00	kuudcedujoms	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	295	dc6debrlvwpn	4796942f-f64e-4f89-9c05-c62bbaf33ff4	t	2025-11-01 06:46:22.630781+00	2025-11-01 07:46:22.562831+00	vxgt25qdetl4	b56961cf-f02f-4d83-bbd5-c645ba6da50c
00000000-0000-0000-0000-000000000000	355	s7q5lsbw6x7h	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-09 22:11:38.874747+00	2025-11-10 05:08:29.911659+00	\N	e3d96228-f5a9-4fa5-a64f-e2328c340fe3
00000000-0000-0000-0000-000000000000	356	smcnosvgv5ri	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-10 05:08:29.934096+00	2025-11-10 11:53:31.115259+00	s7q5lsbw6x7h	e3d96228-f5a9-4fa5-a64f-e2328c340fe3
00000000-0000-0000-0000-000000000000	357	3yp4t2vtjypm	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-10 11:53:31.131027+00	2025-11-10 14:34:13.600772+00	smcnosvgv5ri	e3d96228-f5a9-4fa5-a64f-e2328c340fe3
00000000-0000-0000-0000-000000000000	360	hhb6mwc56sdo	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-10 15:45:16.929167+00	2025-11-10 15:45:16.929167+00	\N	0680616c-b5bb-4370-83ad-45602dcf7a8c
00000000-0000-0000-0000-000000000000	363	eh3dopns7wfb	a773f6e9-aad0-43f1-a8e0-ef5320dae958	f	2025-11-10 15:47:24.795769+00	2025-11-10 15:47:24.795769+00	\N	5b50fc75-6fc6-4ede-bd68-5d1713f86d17
00000000-0000-0000-0000-000000000000	358	2svk2o5z77fg	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-10 14:34:13.611793+00	2025-11-10 16:17:43.039794+00	3yp4t2vtjypm	e3d96228-f5a9-4fa5-a64f-e2328c340fe3
00000000-0000-0000-0000-000000000000	365	szrucs4fn4c5	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-10 16:17:43.043262+00	2025-11-10 16:17:43.043262+00	2svk2o5z77fg	e3d96228-f5a9-4fa5-a64f-e2328c340fe3
00000000-0000-0000-0000-000000000000	364	tqsrh5vzyllb	212cdfee-bdfd-4a38-affd-7546df01cc02	t	2025-11-10 16:15:28.380519+00	2025-11-10 22:39:29.678399+00	\N	65cbc9f9-522c-4004-bc15-4e6ef4679cd2
00000000-0000-0000-0000-000000000000	366	kdd2mefsgutr	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-10 22:39:29.692488+00	2025-11-10 22:39:29.692488+00	tqsrh5vzyllb	65cbc9f9-522c-4004-bc15-4e6ef4679cd2
00000000-0000-0000-0000-000000000000	367	yezie3r3hlfn	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-10 23:18:42.979688+00	2025-11-10 23:18:42.979688+00	\N	709c6bd8-ea70-4b24-ba32-6975051d6b84
00000000-0000-0000-0000-000000000000	368	abjyhwspc3gh	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-11 00:27:45.941076+00	2025-11-11 00:27:45.941076+00	\N	41756d12-c577-409f-821e-382a92bb2806
00000000-0000-0000-0000-000000000000	369	ntvdn3whyje5	212cdfee-bdfd-4a38-affd-7546df01cc02	f	2025-11-11 00:28:39.657423+00	2025-11-11 00:28:39.657423+00	\N	73d48dbe-5e29-4e74-8757-921b12411fe9
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter) FROM stdin;
8e578290-fc5f-4b5f-87bb-3e44ad01e68d	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-04 18:59:59.142882+00	2025-11-04 18:59:59.142882+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
a7514806-af16-44a2-b3ba-a10afa645488	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 12:58:36.934262+00	2025-11-09 12:58:36.934262+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
41b39ad1-7ddc-4f6e-b7c4-b6d63562cc5f	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 13:04:11.135257+00	2025-11-09 13:04:11.135257+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
4b19a91b-c2c9-4bfe-aec6-e6edff42cafa	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 13:11:05.143189+00	2025-11-09 13:11:05.143189+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
eb91be93-cfa6-4fb6-adbc-8e4b6a41ac1d	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 17:21:10.527614+00	2025-11-09 22:10:47.086298+00	\N	aal1	\N	2025-11-09 22:10:47.08618	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	92.184.146.87	\N	\N	\N	\N
324a446d-a8c2-42eb-922b-bb54f7808221	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 13:24:15.84345+00	2025-11-09 13:24:15.84345+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
4a4d3c6e-1a2a-4fab-ac41-aec7f9a3c1b9	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 14:02:26.827913+00	2025-11-09 14:02:26.827913+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
c3fa4381-323f-4c77-ba21-7e3cc42c48f4	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 14:39:19.523992+00	2025-11-09 14:39:19.523992+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
b56961cf-f02f-4d83-bbd5-c645ba6da50c	4796942f-f64e-4f89-9c05-c62bbaf33ff4	2025-10-21 16:37:56.674784+00	2025-11-06 13:30:19.155774+00	\N	aal1	\N	2025-11-06 13:30:19.155664	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-1)	137.175.222.222	\N	\N	\N	\N
4d4c915d-e73e-42cb-87d9-956d0a9022d2	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 15:19:53.777771+00	2025-11-09 15:19:53.777771+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
1433d76f-324f-415c-9afe-b76ffc91a0ec	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 15:19:57.267134+00	2025-11-09 15:19:57.267134+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
fa5e816b-29fb-4a69-a8e2-cf1d8ca3d3e2	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 15:19:58.527395+00	2025-11-09 15:19:58.527395+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
41756d12-c577-409f-821e-382a92bb2806	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-11 00:27:45.923685+00	2025-11-11 00:27:45.923685+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
73d48dbe-5e29-4e74-8757-921b12411fe9	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-11 00:28:39.651589+00	2025-11-11 00:28:39.651589+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
72e799b2-be19-417e-aabb-232a3e4df775	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-08 19:15:50.435509+00	2025-11-09 12:30:22.837067+00	\N	aal1	\N	2025-11-09 12:30:22.836969	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
f8607297-eac6-4107-9e3b-7418da91d5f8	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 12:33:54.814788+00	2025-11-09 12:33:54.814788+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
68aba8f2-d484-46dc-a7e3-fc7caaca8267	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 17:03:32.621908+00	2025-11-09 17:03:32.621908+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	92.184.146.141	\N	\N	\N	\N
f439bff6-6966-4996-98df-598db06b2225	4796942f-f64e-4f89-9c05-c62bbaf33ff4	2025-10-21 16:07:55.169314+00	2025-10-22 17:23:44.26997+00	\N	aal1	\N	2025-10-22 17:23:44.269308	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	204.48.95.182	\N	\N	\N	\N
0680616c-b5bb-4370-83ad-45602dcf7a8c	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-10 15:45:16.915456+00	2025-11-10 15:45:16.915456+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	147.210.179.68	\N	\N	\N	\N
4c23a07b-80b1-485b-af3e-6cce18e5b236	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 21:29:34.335655+00	2025-11-09 21:29:34.335655+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
e83478af-7479-4522-9e57-c3bb36a3fa51	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 20:01:25.075452+00	2025-11-09 22:01:22.349835+00	\N	aal1	\N	2025-11-09 22:01:22.349734	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
aa0d20a0-5de5-4b40-bde5-07de565d6bcb	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	2025-10-24 10:53:01.191579+00	2025-10-24 11:55:25.394218+00	\N	aal1	\N	2025-10-24 11:55:25.39413	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1	178.139.237.174	\N	\N	\N	\N
5b50fc75-6fc6-4ede-bd68-5d1713f86d17	a773f6e9-aad0-43f1-a8e0-ef5320dae958	2025-11-10 15:47:24.794974+00	2025-11-10 15:47:24.794974+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	147.210.179.68	\N	\N	\N	\N
e3d96228-f5a9-4fa5-a64f-e2328c340fe3	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-09 22:11:38.865286+00	2025-11-10 16:17:43.048887+00	\N	aal1	\N	2025-11-10 16:17:43.048797	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1	92.184.141.45	\N	\N	\N	\N
65cbc9f9-522c-4004-bc15-4e6ef4679cd2	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-10 16:15:28.372679+00	2025-11-10 22:39:29.713068+00	\N	aal1	\N	2025-11-10 22:39:29.712463	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
709c6bd8-ea70-4b24-ba32-6975051d6b84	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-10 23:18:42.957191+00	2025-11-10 23:18:42.957191+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	81.65.155.89	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	4796942f-f64e-4f89-9c05-c62bbaf33ff4	authenticated	authenticated	adixi.night@gmail.com	$2a$10$qKO6KV/CM/FT5m6HNOqmfOkKUdsI9vIO.ptmD5uKUnQLimtif59I.	2025-10-20 07:41:18.577441+00	\N		\N		\N			\N	2025-10-21 16:37:56.674685+00	{"provider": "email", "providers": ["email"]}	{"sub": "4796942f-f64e-4f89-9c05-c62bbaf33ff4", "email": "adixi.night@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-20 07:41:18.491965+00	2025-11-06 13:30:19.148802+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1981ba9f-2416-40b0-b484-8f33e2242d66	authenticated	authenticated	esoum18@gmail.com	$2a$10$LnhC/OmX1n/3dYxQxf8lsevWqrvh1SRpE9O6GnaAiT5bXtYPKUnH2	2025-10-22 07:12:35.150667+00	\N		\N		\N			\N	2025-10-22 07:13:54.972072+00	{"provider": "email", "providers": ["email"]}	{"sub": "1981ba9f-2416-40b0-b484-8f33e2242d66", "email": "esoum18@gmail.com", "last_name": "Soum", "first_name": "Enzo", "email_verified": true, "phone_verified": false}	\N	2025-10-22 07:12:35.072556+00	2025-10-22 19:31:58.737208+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	212cdfee-bdfd-4a38-affd-7546df01cc02	authenticated	authenticated	nathangrondin683@gmail.com	$2a$10$kAvmq.rwuRzBQUb.75AnmeANndoAnm1h.MJTgXmhdr4bsCIA/Emlq	2025-10-19 18:14:05.192532+00	\N		\N		\N			\N	2025-11-11 00:28:39.651496+00	{"provider": "email", "providers": ["email"]}	{"sub": "212cdfee-bdfd-4a38-affd-7546df01cc02", "email": "nathangrondin683@gmail.com", "last_name": "Grondin", "first_name": "Nathan", "email_verified": true, "phone_verified": false}	\N	2025-10-19 18:14:05.171033+00	2025-11-11 00:28:39.6602+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	authenticated	authenticated	alexandregrondin123@gmail.com	$2a$10$9cK4QIq7NBuoJZIVenqyc.pq6ZN5uZ.JGRKlALRWw1lTVh/zWoxF6	2025-10-24 10:47:43.339954+00	\N		\N		\N			\N	2025-10-24 10:53:01.191482+00	{"provider": "email", "providers": ["email"]}	{"sub": "53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd", "email": "alexandregrondin123@gmail.com", "last_name": "Grondin", "first_name": "Alexandre", "email_verified": true, "phone_verified": false}	\N	2025-10-24 10:47:43.274447+00	2025-10-25 10:23:01.848204+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a773f6e9-aad0-43f1-a8e0-ef5320dae958	authenticated	authenticated	ndevillers21@gmail.com	$2a$10$qryRz3InpnWYula.mwpSi.h09aBN/hUTDgwtFF.4EGr8mDYs1/dhS	2025-11-10 15:46:51.639339+00	\N		\N		\N			\N	2025-11-10 15:47:24.794875+00	{"provider": "email", "providers": ["email"]}	{"sub": "a773f6e9-aad0-43f1-a8e0-ef5320dae958", "email": "ndevillers21@gmail.com", "last_name": "Devillers", "first_name": "Nathalie", "email_verified": true, "phone_verified": false}	\N	2025-11-10 15:46:51.596433+00	2025-11-10 15:47:24.796682+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chapters (id, novel_id, title, content, created_at) FROM stdin;
4b936d3c-e2ad-4285-a284-8e0f646885c3	0a119146-72e5-4a1c-97c9-d8aca926f187	La ligne des souvenirs cach├®s	Le wagon oscillait doucement, ├®clair├® par des n├®ons jaunis qui projetaient des ombres tremblantes sur les si├¿ges en velours us├®. Nathan d├®colla sa joue de la vitre, laissant une trace de bu├®e l├á o├╣ son souffle sÔÇÖ├®tait condens├®. Dehors, les r├®verb├¿res de Bordeaux fondaient en traits lumineux, aval├®s par la nuit naissante. Il sentit la chaleur de la main dÔÇÖEnzo se poser sur la sienne, les doigts recouverts de fusain laissant des marques gris├ótres sur sa peau.\n\n┬½ Regarde ┬╗, murmura Enzo, pointant du menton la fen├¬tre oppos├®e. Nathan suivit son regard. Dans le reflet, leurs visages se superposaient ├á la campagne qui d├®filait : deux silhouettes floues, encadr├®es par le paysage mouvant de champs sombres et de clochers isol├®s. ┬½ CÔÇÖest comme ├ºa que je te vois toujoursÔÇª dans les entre-deux. ┬╗  \n\nNathan sourit, mais son rire sÔÇÖ├®touffa quand le train traversa un tunnel. Un silence pesant sÔÇÖabattit, troubl├® seulement par le hal├¿tement r├®gulier des roues sur les rails. Enzo sortit son carnet, tourna une page marqu├®e dÔÇÖun ticket perfor├®, et commen├ºa ├á esquisser les courbes du visage de Nathan ├®clair├® par intermittence dÔÇÖun lampadaire.  \n\n┬½ Tu te souviens de cette ligne entre Tours et Angers ? ┬╗ demanda-t-il soudain, sans lever les yeux. ┬½ En 1939, un convoi de r├®fugi├®s a d├╗ rebrousser chemin ici quand les trains allemands ont coup├® la liaison. Les voyageurs ont attendu trois jours sur ce quai, avec juste des paniers de pain sec et des bouteilles dÔÇÖeau. ┬╗ Sa voix se mua en chuchotement, comme sÔÇÖil craignait de r├®veiller les fant├┤mes du pass├®. ┬½ Le m├®canicien a fini par ouvrir les sas des wagons-lits pour quÔÇÖils puissent sÔÇÖabriter de la pluie. ┬╗  \n\nNathan fron├ºa les sourcils. ┬½ Comment tu connais ├ºa ? Tu as fouill├® les archives SNCF ? ┬╗  \n\nEnzo secoua la t├¬te, un index sur les l├¿vres. ┬½ Un vieux contr├┤leur me lÔÇÖa racont├® ├á Quimper. Il portait la m├¬me montre en cuivre que mon grand-p├¿re. ┬╗ Il ouvrit sa veste, r├®v├®lant une cha├«ne dor├®e. Nathan reconnut lÔÇÖobjet : un chronom├¿tre ├á remontage manuel, offert par Enzo ├á ses 18 ans. ┬½ Il disait que les trains gardent les m├®moires quÔÇÖon oublie. ┬╗  \n\nUn soubresaut du wagon fit glisser le carnet. Nathan le rattrapa au vol, les yeux attir├®s par une page corn├®e. Une photo en noir et blanc y ├®tait coll├®e : deux hommes en uniforme ferroviaire, sourires crisp├®s devant une locomotive ├á vapeur. Au dos, une inscription au stylo-bille : *┬½ Albert & Marcel, juin 1943. Pas de billet retour. ┬╗*  \n\n┬½ QuiÔÇª ? ┬╗  \n\n┬½ Des amis de mon grand-p├¿re ┬╗, coupa Enzo, refermant le carnet dÔÇÖun geste brusque. Ses jointures blanchirent sur le cuir us├®. ┬½ Ils ont aid├® des familles juives ├á fuir par le train de Saint-Nazaire. JusquÔÇÖ├á ce que la Gestapo ferme la ligne. ┬╗ Il d├®tourna le regard vers le couloir, o├╣ un contr├┤leur ├óg├® passait entre les si├¿ges, son badge ├®br├®ch├® claquant contre sa veste. ┬½ Ce genre dÔÇÖhistoires, elles ne sont pas dans les guides touristiques. ┬╗  \n\nNathan posa une main sur son poignet. ┬½ Et ton grand-p├¿reÔÇª ? ┬╗  \n\nLe train ├®mergea du tunnel, inondant le compartiment dÔÇÖune lumi├¿re orang├®e. Enzo inspira longuement, les yeux fix├®s sur les champs illumin├®s par la lune. ┬½ Il a disparu en mai 1944. Personne nÔÇÖa jamais retrouv├® son corps. Juste ce chronom├¿tre, coinc├® dans la bo├«te ├á gants dÔÇÖune locomotive sabot├®e. ┬╗ Sa voix se brisa sur le dernier mot. ┬½ CÔÇÖest pour ├ºa que je voyage. Pour effacer le blanc entre les dates. ┬╗  \n\nNathan chercha ses mots, mais Enzo se redressa soudain, pointant une gare minuscule engloutie par lÔÇÖobscurit├®. ┬½ Regarde ! Saint-Pierre-des-Corps ! ┬╗ Son enthousiasme ├®tait feint, trop aigu. ┬½ CÔÇÖest ici que les TGV ont battu leur premier record de vitesse. 1981. ┬╗ Il sortit son appareil photo, mitraillant les panneaux dÔÇÖaffichage sans m├¬me cadrer. ┬½ LÔÇÖhomme qui a con├ºu ces ramesÔÇª il a travaill├® dans le noir complet. Sans jamais voir la fin de sa ligne. ┬╗  \n\nLe cliquetis de lÔÇÖappareil se m├¬la au grondement des roues. Nathan observa les traits tendus dÔÇÖEnzo, le pli soucieux entre ses sourcils qui trahissait lÔÇÖangoisse sous le flot de paroles. Il se pencha, effleurant de ses l├¿vres la tempe de son amant. ┬½ Tu nÔÇÖes pas lui, Enzo. ┬╗  \n\nLe jeune homme tressaillit, lÔÇÖobjectif braqu├® sur Nathan. Dans le viseur, ses yeux brillaient dÔÇÖun m├®lange de col├¿re et de larmes retenues. ┬½ Et si cÔÇÖ├®tait le cas ? Si je passais ma vie ├á chercher des bouts de rail sans jamaisÔÇª ┬╗ Il sÔÇÖinterrompit, une goutte sal├®e ├®claboussant lÔÇÖ├®cran num├®rique.  \n\n┬½ Sans jamais quoi ? ┬╗  \n\nLa sonnerie du train annon├ºa lÔÇÖapproche de Nantes. Enzo rangea pr├®cipitamment son appareil, les joues rouges. ┬½ Rien. Oublie. ┬╗  \n\nMais Nathan avait vu la feuille gliss├®e entre les pages du carnet : un courrier professionnel en-t├¬te de *France T├®l├®visions*, dat├® de la veille. *┬½ Objet : Proposition de collaboration pour documentaire sur les r├®seaux secondairesÔÇª ┬╗*  \n\nAlors que les premi├¿res lueurs de Nantes apparaissaient ├á lÔÇÖhorizon, Nathan serra la main dÔÇÖEnzo plus fort. Dehors, un panneau indiquait *┬½ Gare de Nantes ÔÇô 2 km ┬╗*, mais dans lÔÇÖobscurit├® du wagon, il ne voyait plus que les secrets qui dansaient entre leurs doigts entrelac├®s.	2025-10-22 10:50:18.471+00
cbb25cd7-08cf-4e27-9041-4d75e503b0fc	b373d5ce-36de-481e-8a60-b16b06600ff9	Les Investigations Masqu├®esLe d├®cor des rues enneig├®es reprenaient possession du coeur des jeunes filles ├á chaque pas qu'elles faisaient. Le bruit dans leur dos s'estompait peu ├á peu, les laissant se d├®lier des murmures du village. Cependant, aucun commentaire ne sortit non plus de leur bouche, leur pas  ├®tait rapide et leurs regards d├®fiant toute ser├®nit├®. Djia allait tenter de reprendre contenance, serrant les paniers entre ses bras, Pomme la pressant de marcher plus loin, les doigts tremblants de neige et de tension nerveuse.	"Tu crois qu'ils ont senti quelque chose ?" finit par murmurer Pomme en risquant un coup d'oeil suspicieux vers l'entr├®e du village.\n\nDjia ne r├®pondit pas tout de suite, ses yeux riv├®s au sol qui semblait encore peu ├á peu vibrer sous elle. Ses paumes ├®taient moites, comme si elle pouvait sentir dans le fond, ce l├®ger vortex de peur ├®veill├®e lÔÇÖacculant cette fameuse nuit avec la lumi├¿re inondant la for├¬t. Ce souvenir ne la quittait plus, encha├«nant les nuits, les pens├®es, les questions. Sa faiblesse face aux ├®v├®nements la hanterait encore pour des ann├®es.  \n\n"Je... ne sais pas. Mais si c'est le cas, on a peu de chances qu'on croit" sussura t-elle enfin.\n\nPomme avait l'air aussi ├®branl├®e que son amie dans la pr├®cip silencieuse qui suivit. Leurs t├óches matinales leur permettaient garder l'esprit occup├®, elles alignaient m├®ticuleusement les premiers bourgeons r├®colt├®s dans une succession de paniers en osier. La nuit ne les rassura que temporairement. Djia sentait les courants cycliques de M├®diolias lui offrir une sorte de paix, peut-├¬tre les p├®tales violets comme promesse de bonheur dans ce faible calme.\n\nPendant les jours suivants, lestrangers aux tuniques violettes captiv├¿rent progressivement le village, enchanquant avec l├®g├¿ret├® la vieille Mara dÔÇÖun simple sortillio de pr├®servation qui lui ├®vitaient de voir pourrir les r├®tes pr├®matur├®ment. Six bras├®s de violet firent leur apparition parmi les villageois, les ├®clairant dans leurs t├óches quotidiennes avec des sorts non violents visant ├á cultiver la force collective. Des bandes de runes p├óles et lumineuses flottaient ├á peine lorsque l des voyageurs utilisait le pouvoir pour redonner souffle ├á la terre meurtrie ou ├®claircir lÔÇÖeau trouble du puits central.  \n\n"Quelle magie", racontait fi├¿rement le vois d'├á c├┤t├® aux voyageurs, "nos terres ne tiennent aujourdÔÇÖhui que gr├óce ├á notre foi en la M├®diola".\n\n"Ou alors, gr├óce ├á la lumi├¿re dans votre sol", r├®torquait doucement un des ramifications inconnus.\n\nur spectre de magie alexandrine ├®tait ├®trangement apaisant et bienveillant, d├®routant pour des personnes prosp├®rant sur le terrain des cultes douteux ou des secrets bien gard├®s. Selon leur discours ├®pur├® et mesur├®, ils ├®taient l├á dans le simple but dÔÇÖ├®tudier ces fleurs sacr├®es, r├®put├®es pour leur singuli├¿re symbiose avec la terre volcanique. Djia, bien que rassur├®e par leur discours en fa├ºade, sentait contre son fil int├®rieur une ├®nergie ├®lectronique d├®rangeante ├®manant des symboles grav├®s dans leurs mains.\n\nCette suspicion prenait forme quand, au d├®tour d'un champ, elle remarqua un geste ├®trange. LÔÇÖun des voyageurs pointait discr├¿tement ses doigts vers une silhouette en contrebas, touchant le sol avec pr├®cision. Une vibration sourde se propagea dans ses jambes comme un tambour fun├¿bre, petits tourbillons de s├¿ve suivant soudainement les raies violettes quÔÇÖil animait sans m├¬me que les autres s'en rendent compte.ROP\n\nCette manipulation cach├®e la fit d├®tourner le regard, son c┼ôur battant derechef ├á une cadence effrayante. Elle savait pertinemment que malgr├® leur sourire lisse et doux, il s'agissait d'observateurs avis├®s et m├®thodiques, peut-├¬tre m├¬me dangereux. Malgr├® les sentiments que certains villageois fa├ºonnaient ├á leur ├®gard, une crainte organique restait intacte en elle, et Pomme, plus lucide que jamais, la sentait monter derri├¿re ce sourire feint dans la journ├®e artisanale.  \n\n"Je nuis pas tranquille avec eux", chuchota Djia alors que les deux demoiselles fermaient lauded pour cette nuit-l├á la parcelle florale enneig├®e."  \n\n"C'est ce qu'ils veulent. Les loups sont plus sages quand les moutons les laissent sÔÇÖapprocher."  \n\nPomme, bien quÔÇÖinsouciante en apparence, d├®veloppait aussi un instinct aiguis├®, peut-├¬tre soutenu par les bribes de cette col├¿re violette naissait entre elles. Cependant, pour fleurir sans cesse, la terre ne cessait de se nourrir de calme apparent.\n\nLe lendemain matin se leva avec un ├®clairage diffract├®. Hier encore lÔÇÖhiver ├®tait roi, aujourdÔÇÖhui, Chantevue donnait naissance ├á une lumi├¿re douce et r├®g├®n├®rescente. La joyeuset├® sÔÇÖempara de cette aube. La coutume voulait que le bas du village sÔÇÖaffol├ót de pr├®parer les ├®choppes color├®es, les guirlandes ocre et violets ├®mergeant comme des lampions entre le ciel et la terre. Des inventions de f├¬tes sauvagines embellirent les rues ├®troites et malgr├® la p├®nurie de ressource, chaque ruelle abrite une odeur florale, toujours plus parfum├®e que les ann├®es pass├®es.\n\nDjia et Pomme participaient machinalement, leurs doigts agiles emm├¬l├®s ├á tresser des couronnes destin├®es au rituel sacr├®.  \n\n"Ben tiens, voil├á les fins enchantres !" Bisailla une vieille femme aux ├®paules vo├╗t├®es en les regardant.\n\nPomme sourit, ses cheveux encore aveuglants de blond factice dansent comme des rayons de lumi├¿re bris├®e. Djia, sa grande taille s'allongeant dans les mouvements, retenait ses gestes et son apparence, restant sto├»que face ├á cette soudaine curiosit├® ambiantes. Malgr├® cela,elle sentit le regard brulant des ├®trangers.  \n\nAlors que les villageois dansaient de pr├®paratif en chants joyeux, l'homme au regard bleu translucide marchait silencieusement entour├® des siens. Leurs pieds foulant la terre de Sausir avec aisance faisaient voler des parcelles de p├®tales cach├®s sous la neige. Lentement, il examinait les ┼ôuvres de ses prochaines cibles, personne ne distinguait ces lieux de ses pr├®ceptes pour longtemps.\n\nLe festival commen├ºa ├á battre son plein ├á l'aube. Des ├®choppes priestent d'anciennes victoires contre le vent, des cercueils de lumi├¿res sans fin ├®merg├¿rent qui ├®clair├¿rent les recoins les plus sombres du village, cr├®ant un arc-en-ciel terrestre de toutes les palettes imaginables. Pomme partageait les ├®tapes chor├®graphiques avec d'autres jeunes via le ballet des M├®diolias. Djia elle regardait la sc├¿ne ├á l'├®cart, d├®sireuse de composer seule ├á l'ombre du guignol o├╣ les villageois sÔÇÖentassaient.  \n\n"Tu tÔÇÖoccupes d'Estromia au journalier donc ? " demanda une voix fluide derri├¿re elle.\n\nSon sang se gla├ºa instantan├®ment, elle sentait le pair d'yeux bleus clouer chacun de ses muscles. Djia tourna peu ├á peu la t├¬te, faisant face ├á l'inqui├®tant inconnu. Il portait autour du cou un pendentif de pierre lunaire grav├® des motifs similaires aux anciennes dalles bris├®es.  \n\n"Non, je m'occupe du tissage des guirlandes" r├®pondit-elle, montant un sourire neutre et contr├┤l├®.\n\n"Vous faites l├á, une excellente sagesse. La danse est charmante nÔÇÖest-ce pas ?" Il fit signe vers Pomme sur le devant, dans ses ├®clats de voiles. "Mais les vertus sacr├®es se transmettent partout o├╣ des noyaux florales se manifestent. En ces terres si banales, jÔÇÖaurais cru ne rien y trouver dÔÇÖint├®ressant."\n\n"D'ici, on tient juste ├á nourrir le monde avec notre culture" r├®visqua Djia, feignant un accent de col├¿re contre lui.\n\nLÔÇÖinconnu fut accueilli dÔÇÖun regard p├®n├®trant. Plusieurs sensations ├®tranges hantaient Djia comme une simple pression dans la poitrine. Toute ├®motion quÔÇÖelle aurait laiss├® ├®clore aurait ├®t├® un signal de d├®tresse pour qui ma├«trisait la v├®rit├® du monde de la magie.\n\nCe soir-l├á, comme toutes les ├®toiles gardaient leur voile dÔÇÖor, les deux artisanles se prirent ├á rebondir dans leurs pas de promenade. Le culture fig├®es, le travail r├®compensait la petite parcelle de calme ressentie dans la neige derri├¿re eux. Mais ├á chaque instant, Djia surveillait lÔÇÖattitude des cultivateurs, restant en retrait pour mieux contourner leur pr├®sence persistante.  \n\n"Pour p-pas dormir dans l'├®couteur..." Pomme chercha une phrase. "Peut-├¬tre quÔÇÖils sont ici pour une toute autre raison."\n\n"En tout cas, les M├®diolias sont sacr├®es pour bien d'autres que leur beaut├®. Tout ce qui nous reste de ce monde bris├®, juste de quoi se lever, respirer". Elle avait faim de phrases rassurantes, mais la curiosit├® du monde constamment en alerte dominait.ROP\n\nLa nuit sÔÇÖembrumant sous le calme fragile du village, alors que les deux jeunes filles rin├ºaient leurs souliers couverts de bourbe, une chape de neige ├®trange se mit ├á tomber, comme si le p├┤le m├¬me du climat s'inversait sous leurs yeux. Djia saisit alors le poignet de Pomme, retenant un cri dans un centime de contr├┤le.\n\n"Tu as vu ├ºa ?" chuchota Djia.\n\n"Le vent... mais comment sÔÇÖinverse un vent ?" interrogea Pomme en regardant la tourmente avec tal.\n\nAu loin, entre le tourbillonnement fragile de ce climat in├®dit, et juste avant que cette ├®trange lueur ne rev├«nt courir dans la neige, elles cru percevoir un ├®l├®ment qui ne leur ├®tait pas inconnuÔÇª Une femme dans les ombres mouvantes, une femme qui portait des ├®chos de leur m├®moire, rose pouvant trouver racine que chez elle.ROP\n\nQuelque chose ici brisait encore une fois l'apparente simplicit├® du village.\n\nPendant qu'elle d├®tournaient encore leurs regards, un reflet ├®trangement familier ondoyait dans l'eau du puits, un miroir avec cette m├¬me magie dor├®e qui fonctionnait ici.ROP\n\nUn reflet d'elle avant la neige, avant m├¬me la chute.ROP\n\nUn visage quÔÇÖelle ne sÔÇÖ├®tait jamais vu.	2025-10-22 21:09:01.823+00
198048a5-1c1f-45be-8230-d70af8535e1c	4a440939-d2e6-43a7-84fc-2782177bc172	Le premier caf├® de Grenade	Les pierres grises de la cath├®drale projetaient des ombres allong├®es sur la Plaza del Carmen quand Alexandre consulta son t├®l├®phone pour la dixi├¿me fois en cinq minutes. LÔÇÖ├®cran, ├®bloui par le soleil de Grenade, affichait un plan tressautant o├╣ son point bleu clignotant semblait jouer ├á cache-cache avec la r├®alit├®. Ses mocassins claquaient sur les pav├®s in├®gaux, r├®sonnant ├á contretemps contre les murs de chaux o├╣ des glycines d├®goulinaient comme des larmes violettes. Il passa devant un barbondissant dÔÇÖun chaos de chaises en fer forg├®, de voix rauques et de verres tintant ├á lÔÇÖunisson, et sÔÇÖarr├¬ta net. ┬½ Gare ├á ne pas mourir de soif ┬╗, murmura-t-il en fran├ºais, puis il se reprit : ┬½ Serait bien de boire. ┬╗.  \n\nLa boulangerie sÔÇÖ├®tait transform├®e en cordonnerie. Le cordonnerie en pharmacie. La pharmacie en vitrine poussi├®reuse de cruches en ├®caille. Alexandre plissa les yeux, les doigts crisp├®s sur la bande dessin├®e quÔÇÖil avait gard├®e pour se rep├®rer. *Deux ruelles plus loin, un caf├® rouge sur la gauche*. Il compta mentalement les tournants, mais les ruelles de Grenade nÔÇÖavaient pas de logique, pas de num├®ro, pas de raison dÔÇÖ├¬tre. Juste des virages capricieux, des enclos de chats noirs dress├®s de balconnets rouges, et des regards en coin du type sur son scooter, arr├¬t├® ├á sa hauteur.  \n\nQuand il poussa enfin la porte du *Caf├® del Sol*, un carillon de clochettes ├®br├®ch├®es annon├ºa son entr├®e. LÔÇÖint├®rieur ├®tait satur├® dÔÇÖune odeur chaude de churros et de caf├® moulu. Derri├¿re le comptoir, un homme aux sourcils ├®pais comme des brosses ├á dents essuya sa tasse dÔÇÖun geste circulaire ├®tudi├®. Alexandre sortit sa petite phrase pr├®par├®e : ┬½ Bonjour, pourriez-vous me donner un caf├®, noir, sans sucre, sÔÇÖil vous pla├«t ? ┬╗. Le barman haussa un sourcil. ┬½ SÔÇÖil vous pla├«t ? ┬╗, r├®p├®ta-t-il en espagnol, avec un sourire qui nÔÇÖ├®tait pas tout ├á fait un sourire. Alexandre sentit son front rosir. Il avait r├®p├®t├® ce mot-l├á, dix fois sous la douche. Mais la phrase avait jailli avant quÔÇÖil ne pense ├á conjuguer en espagnol, comme une langue maternelle prise en faute.  \n\nDebout devant la machine ├á expresso d├®cor├®e de photos de flamencos et de rois maures, Alexandre tenta une clarification. ┬½ EuhÔÇª Caf├®, por favorÔÇª Que est├íÔÇª hum, c├│mo se dice ? ÔÇØsans sucreÔÇØ ? ┬╗.  \n\nLe barman posa un coude sur le comptoir, le menton cal├® au creux de son poing. ┬½ Et vous ├¬tes sur quel chantier pour poser autant de questions avant de commander ? ┬╗. Alexandre bafouilla, puis l├ócha un ┬½ Je pr├®f├¿re le noir ┬╗ ├á contretemps. ┬½ *Sin az├║car, s├¡*, ┬╗ r├®pondit le barman, cette fois en fran├ºais, ├á la stupeur du jeune ing├®nieur. ┬½ Mais caf├® ici, cÔÇÖest d├®gustation. Pas format gluton. Vous restez ? ┬╗. Alexandre jeta un ┼ôil ├á ses notes de r├®union ├®tal├®es dans son sac. 18h, d├®lai strict pour envoyer son rapport ├á Paris. Il e├╗t pu dire oui, partir, fermer les yeux sur lÔÇÖincident.  \n\nMais lÔÇÖespace dÔÇÖune seconde, il entendit ce que les murs ne lui disaient pas. La femme au balai, dans la rue, qui fredonnait un air doux, chant derri├¿re le tintinabulement des gamelles. Le temps, dans le caf├®, semblait suspendu, ├®pais. Alexandre prit place au comptoir, articulant un ┬½ Oui bien s├╗r ┬╗ sans conviction. Le barman hocha la t├¬te, pressant sur un levier qui lib├®ra un nuage de vapeur odorante. ┬½ Et le vous ? ┬╗ demanda-t-il soudain, montrant le macaroon dans son sac. Alexandre fixa la p├ótisserie bleue, un cadeau de son bureau avant d├®partÔÇôune tentative pitoyable de diplomatie interculturelle. ┬½ PourÔÇª partager ? ┬╗ risqua-t-il, en remettant le g├óteau. LÔÇÖhomme ├®mit un ricanement guttural. ┬½ *Aqu├¡ no se comparte cuando es paz de ocho de la ma├▒ana*. ┬╗. Alexandre nota mentalement la chaleurinfo du regard de lÔÇÖhomme, son accent qui lissait les consonnes.  \n\nLorsque son caf├® arriva enfin, ├á la hauteur des gravures ocre du plafond, Alexandre prit conscience dÔÇÖun d├®tail ├®tonnant : les autres clients observaient son sac fa├ºon Marie-Curie-de-Paris, une queue de canard en tapisserie fich├®e dedans. Puis une jeune femme entra en valsant, chemisier vert fluo et bas de collant trou├®. Elle pointa Alexandre du menton, puis lan├ºa vers le barman un ┬½ Le nouvelle recrue, hein ? ┬╗.  \n\nAlexandre perdit le fil. Sa tasse fumait sans doute trop chaud. Le plafond semblait se remuer en motifs insolites, tel ces mosa├»ques de lÔÇÖAlhambra quÔÇÖil nÔÇÖavait pas encore trouv├® le temps de visiter. Mais ce fut lÔÇÖhomme qui referma la br├¿che, tendant un torchon ├á la pr├®cision de couturier. ┬½ ├ëcoutez, ing├®nieur. Ici, un caf├® nÔÇÖest pas un *task*. CÔÇÖest une histoire. Et les histoiresÔÇª elles prennent le temps quÔÇÖelles veulent. ┬╗.  \n\nAlexandre porta la tasse ├á ses l├¿vres en pin├ºant les dents, pr├®voyant rentrer dans les temps, les r├¿gles, lÔÇÖordre. Mais ce premier go├╗t du caf├® grenadin le d├®sar├ºonna, pas inflammable, ├┤ combien plus sucr├® et dÔÇÖun arri├¿re-go├╗t de cannelle qui ├®branla ses notions. Son horloge interne, r├®gl├®e ├á la minute pr├¿s, tremblota.  \n\nAlors quÔÇÖil sortait du comptoir, Alexandre remarqua un morceau de chewing-gum coll├® sous sa chaise : quelquÔÇÖun y avait d├®pos├® un petit papier, lui-m├¬me aur├®ol├® de mots encres ├®tranges. Un num├®ro de t├®l├®phone. Sous les yeux navr├®s des autres clients, la jeune femme en vert fluo lui glissa un clin dÔÇÖ┼ôil lorsque leur chemins se crois├¿rent au seuil de la porte. ┬½ Bienvenue dans le d├®dale, ┬╗ lan├ºa-t-elle. Puis disparut dans un virage trop serr├®.  \n\nDehors, la ruelle sÔÇÖ├®largissait en une **all├®e inqui├®tante bord├®e de portes rouges**, ÔÇô desquelles sortaient de vague m├®lodies, ├á la guitare, distordant un air de flamenco. Son t├®l├®phone vibra alors ├á lÔÇÖint├®rieur de son sac. Un mail. Urgent. Grenade, il nÔÇÖavait pas encore enregistr├® le rythme de ses pas. Et ce caf├®, savour├® ou non, ne serait certainement pas le dernier quÔÇÖil commanderait mal.	2025-10-24 12:45:10.748+00
b3b88559-1ce8-4836-b290-fbc360408851	b373d5ce-36de-481e-8a60-b16b06600ff9	L'├®veil d'une lueur oubli├®e	La brume du soir enveloppait encore les collines lorsque Djia et Pomme s'aventur├¿rent hors des limites du village. Le vent hurlait comme une b├¬te bless├®e, arrachant les feuilles rouges des arbres centenaires qui bordaient le chemin forestier. Les deux adolescentes avaient l'habitude de ces escapades tardives, fuyant pour quelques heures les regards d├®sapprobateurs des anciens et les corv├®es quotidiennes. Pomme, avec ses boucles rousses soigneusement dissimul├®es sous un voile bleu, marchait en avant, scrutant le sentier avec une excitation mal contenue.\n\n"Je te l'avais dit qu'on aurait d├╗ partir plus t├┤t, regarde, le soleil se couche d├®j├á" murmura Djia en jetant un regard noir ├á son amie.\n\nPomme sautilla l├®g├¿rement, heureuse de pouvoir se balader apr├¿s une longue journ├®e. Elle fit comme si elle n'avait rien entendu.\n\n"Tu es s├╗re que c'est par l├á ?" ronchonna Djia, ses traits fins illumin├®s par les derniers rayons du soleil filtrant ├á travers les feuilles.\n\n"Bien s├╗r ! La vieux marchand m'a dit que les ruines de la source ├®taient encore accessibles si on suivait le lit de la rivi├¿re ass├®ch├®e."\n\nDjia grima├ºa. Les ruines des anciennes sources de magie ├®taient cens├®es ├¬tre maudites depuis la chute de l'empire. Un d├®sastre abominable o├╣ la grande majorit├® d'entre elles avaient ├®t├® d├®truite, plongeant les r├®gions coup├®s de magie dans une p├®riode sombre que nul n'a pu ├®viter. La curiosit├® l'emporta, comme toujours. Elles march├¿rent en silence, le sol craquel├® sous leurs pieds, jusqu'├á ce qu'une structure circulaire ├®merge des broussailles. Des motifs de racines grav├®s dans la pierre ├®taient encore visibles, bien que partiellement recouverts par la v├®g├®tation environnante. Quel ├®merveillement de pouvoir se rapprocher autant de ces monuments antiques.\n\nPomme tendit la main vers la dalle centrale, ses doigts effleurant les sculptures. "Il n'y a aucune ├®rosion, la pierre est fendue mais on voit bien que c'est arriv├® il y a quelques ann├®es seulement."\n\nEn r├®alit├®, ces sites datait de plusieurs milliers d'ann├®es mais les brisures que l'on apercevait remonter d'il y a 12 ans ├á peine.\n\n"Tu crois qu'il reste un peu de..."\n\nUn craquement sec retentit derri├¿re elles. Les filles se fig├¿rent. Six hommes arm├®s ├®merg├¿rent des fourr├®s, leurs ├®p├®es ├®mettant de faibles lueurs bleut├®es. Le chef, un g├®ant balafr├®, sourit en d├®couvrant ses dents noircies.\n\n"Eh bien, qu'avons-nous l├á ? Deux petites souris loin de leur trou."\n\nDjia sentit son c┼ôur battre ├á tout rompre. Elle recula d'un pas, faisant face ├á ces personnages lugubres. Derri├¿re elle Pomme se pr├®cipita pour la rejoindre mais dans la panique tr├®bucha. Son voile glissa, r├®v├®lant ses cheveux roux flamboyants. Les hommes rican├¿rent.\n\n"Une rousse ! ├ça porte malheur, ces cr├®atures."\n\nDjia sentit son estomac se nouer. Elle connaissait ces hommes. Les Loups Noirs, une bande de pillards qui ├®cumaient la r├®gion depuis des mois. On pouvait facilement les reconna├«tre ├á leurs accoutrements, v├¬tu de cuir, le plastron orn├®e d'un loup noir. Leurs exploits sanglants faisaient fr├®mir tous les villages alentour.\n\nPomme pris la main que Djia venait de tendre vers elle et se releva maladroitement. "Djia..." Son souffle ├®tait court, ses pupilles dilat├®es par la peur.\n\n"Laissez-nous partir," tenta Djia, bien que sa voix tremblante trahisse sa bravade. "Nous n'avons rien de valeur."\n\nLe deuxi├¿me bandit, un g├®ant au nez cass├®, ├®clata de rire. "Rien de valeur ? Toi, peut-├¬tre. Mais la rousse... Les esclavagistes paient cher pour son genre."\n\nDjia vit Pomme p├ólir ├á l'annonce de ces mots.\n\n"Rien ne sert de perdre plus de temps... Attraper la maudite." s'exclama leur chef avec d├®dain.\n\n"Et celle-l├á ?" Ajouta le dernier bandit, un petit trapu mais f├®roce, d'un air excit├® comme s'il attendait l'approbation de son sup├®rieur. Le chef tourna la t├¬te en sa direction et esquissa un sourire malicieux.\n\n"Amuse-toi..."\n\nDeux des affreux se pr├®cipit├¿rent en direction de Pomme, pr├¬ts ├á la neutraliser, ├®p├®e dans une main, corde dans l'autre. Elles se mirent ├á courir aussi vite qu'elle pu s'enfon├ºant dans les bois. Mais que pouvez faire deux petites files face ├á ces colosses en rage ? Elles cherch├¿rent d├®sesp├®r├®ment autour d'elle une issue, une arme, n'importe quoi. Les arbres semblaient se refermer sur elles jusqu'├á finalement arriver au pieds de la colline qui n'├®tait autre qu'un cul-de-sac, pi├¿ge naturel complice de leurs agresseurs.\n\nLes deux premiers affreux se pr├®cipit├¿rent en direction de la rouquine, pr├¬ts ├á la neutraliser, ils la plaqu├¿rent au sol sans aucun probl├¿me. Djia de toute ses forces frappa de ses petites mains fr├¬les les hommes en esp├®rant qu'ils rel├ócherait sa camarade.\n\n"Lib├®rez-l├á bandes de brutes !!!"\n\nRien n'y faisait et d'un coup violent elle se fit d├®gag├® tandis que Pomme observait la sc├¿ne en criant, visage ├®cras├® contre le sol, se d├®b├ótant de toute ses forces. Elle avait malheureusement agac├® encore plus ces b├¬tes sauvages. Un troisi├¿me bandit s'├®tait rejoint, c'├®tait encore lui, le presque nain qui rester pourtant le plus massif d'entre eux.\n\n"N'ab├«mer pas son jolie minois bande d'abrutis, le chef veut en tirer le meilleur prix. Emmenez-l├á."\n\nIl s'approcha doucement au d├®but, faisant s'├®loigner Djia en rampant, encore sonn├®e de son vol plan├®.\n\n"Hahaha et pour toi l'histoire s'arr├¬te l├á. Regarde ce qui arrive quand on se prom├¿ne toute seule dans les bois, le grand m├®chant loup mange la petite fille".\n\nVoyant le reste de la bande arriver il brandit son arme, se jetant soudainement sur la jeune fille comme un charognard assoiff├®e de sang. Il ne d├®sirait pas seulement la voir morte, il voulait voir sa t├¬te tomb├®, faire gicler le rouge pourpre, se d├®lecter de la satisfaction qu'apporte l'action d'asseoir son pouvoir sans aucun effort. Il se croyait tellement fort, s'amuser tout en impressionnant son chef, c'├®tait parfait.\n\nDjia vit le mouvement au ralenti : la lame s'├®levant, pr├¬te ├á s'abattre sur elle. Un cri lui ├®chappa, et soudain, une chaleur intense envahit sa poitrine. Des particules dor├®es jaillirent de ses paumes, formant un bouclier ├®blouissant entre son visage et l'attaque.\n\nLes arbres ploy├¿rent sous une force invisible, les criminels furent projet├®s en arri├¿re comme des pantins d├®sarticul├®s. Dans l'instant suivant, un silence surnaturel s'abattit sur la for├¬t. Les brigands se relev├¿rent, horrifi├®s, leurs yeux riv├®s sur les ├®clats de lumi├¿re qui dansaient autour de Djia. La jeune fille elle-m├¬me semblait p├®trifi├®e, contemplant ses mains avec une incr├®dulit├® muette, sa vision devenant tout ├á coup de plus en plus flou.\n\n"Blanche..." souffla l'un des hommes, peinant ├á se relever. "La magie des dieux !"\n\nLe chef, plus t├®m├®raire, rugit : "Saisissez-la ! Le prix sur sa t├¬te va nous..."\n\nIl ne put terminer sa phrase. Une vibration sourde parcourut le sol, comme s'il lui avait fallu quelques secondes pour se propager jusqu'├á eux, secouant encore les arbres environnants, tandis qu'une ├®trange pulsation lumineuse s'├®levait dans le ciel, un faisceau lumineux visible ├á des lieux ├á la ronde.\n\nPomme se releva assez rapidement, n'├®tant pas r├®ellement bless├®e elle se pr├®cipita vers Djia et attrapa son bras. "Il faut partir. MAINTENANT."\n\nElles s'enfuirent, l'une tra├«nant l'autre, sans m├¬me un regard en arri├¿re. Les cheveux roux de Pomme se noyaient dans le d├®cor orang├® de la saison d'automne qui d├®butait et, dans cette brise silencieuse, ne pas s'arr├¬ter relever de la survie. La lumi├¿re dans le ciel s'├®teignit aussi subitement qu'elle ├®tait apparue, laissant derri├¿re elle l'annonce d'un grand changement avenir.\n\nDans les bas-fonds de la nouvelle capitale, un jeune homme aux cheveux noirs de jais leva la t├¬te du registre qu'il compulsait. Les doigts de Tianxin se crisp├¿rent sur le parchemin lorsqu'une douleur aigu├½ lui traversa la tempe droite. L├á, sous la peau, sa cicatrice rougeoya bri├¿vement avant de retrouver sa p├óleur habituelle.\n\nL'homme se leva si brusquement que sa chaise chuta sur le sol de pierre. "Impossible..." Pourtant, il l'avait bien senti.\n\nEt sans vraiment savoir pourquoi, c'├®tait comme si cette ├®nergie appelait son sang.\n\nPlus loin, dans l'ombre d'un temple abandonn├®, des silhouettes encapuchonn├®es avaient observ├® l'horizon dor├® avec stupeur et excitation. L'un d'eux avait sorti un manuscrit de sa manche et commen├ºa tracer des symboles violets dans la p├®nombre.\n\n"Pr├®parez-vous" intima la voix rauque de l'homme qui semblait diriger le groupe.\n\nLes deux rescap├®es atteignirent enfin le village, s'engouffrant dans la maison de Djia. De retour dans sa chambre, Djia observait ses mains avec effroi. Elles tremblaient encore.\n\n"Personne ne doit savoir" l├ócha Djia entre deux respirations.\n\nPomme jura de garder le secret, mais comment cacher une telle chose ? Elle se jet├¿rent toutes les deux sur le lit, cherchant le r├®confort d'un lit douiller pour d├®compresser de cette aventure folle.\n\n"Tu as vu leur visage", chuchota Pomme en se frottant la gorge meurtrie. "Ils t'ont prise pour une d├®esse."\n\nDjia ferma les yeux, la m├¬me c├®cit├® partielle ne voulant toujours pas la quitter. Dans son esprit, des images flottaient : une femme aux cheveux de jais qui pleurait en la serrant contre elle, une chute interminable ├á travers les nuages, une voix murmurant des mots qu'elle ne comprenait pas.\n\n"Arr├¬te de dire n'importe quoi... Ils ont eu peur c'est tout.. exactement comme toi et moi."\n\n"C'├®tait effrayant oui... et en m├¬me temps... cette lueur ├®tait si jolie."\n\nDjia resta silencieuse un moment. Cette discussion lui donnait la boule au ventre, elle ├®tait incapable d'expliquer les ├®v├¿nements r├®cents et toutes les ├®motions qu'elle ressentait restaient bloqu├®es ├á l'int├®rieur. Elle le sentait au fond d'elle, sa vie ne serait plus jamais la m├¬me ├á partir d'aujourd'hui.\n\n"Mara m'a toujours dit que ta m├¿re m'avait trouv├® pr├¿s de la rivi├¿re", murmura Djia. "Mais je commence ├á croire que ce n'est pas toute l'histoire."\n\n"Tu crois que ├ºa a un rapport avec tes origines ?" Les grands yeux de Pomme fixait Djia avec inqui├®tude et compassion.\n\n"Il y a de grandes chances, mais il semblerait que nous n'ayons aucune autre information ├á ce sujet." Djia arborait cette expression d├®pit├®e. Plus t├┤t elles auraient pu mourir, mais cette lumi├¿re, cette magie, les avaient sauv├®s. Toutefois, instinctivement, elle savait que cela n'allait apporter que des ennuies.\n\nUne main toqua a la porte. Un peu surprise, Djia et Pomme se regard├¿rent presque avec effroi. Prise de panique, pensant qu'on venait pour les gronder. Elles s'├®taient encore enfuis. La silhouette de Lily apparu quand elle ouvrit doucement la porte.\n\n"C'est pr├¬t les filles, d├®barbouillez vous et venez manger." Elle tourna la t├¬te en direction de sa fille. "Nous en rentrons pas tard ce soir, ton p├¿re est fatigu├®e, et tu remercieras bien Mara de nous avoir invit├® ce soir."\n\n"Oui mamaaaan, comme toujours."\n\nAu final, ce n'├®tait que la m├¿re de Pomme qui venait gentiment appeler les jeunes filles pour le repas du soir. Elle esquissa un petit sourire et repris la direction des escaliers.\n\n"On vous attends" lan├ºa t-elle une derni├¿re fois en descendant tranquillement.\n\nDeux gros soupires se fit entendre.\n\n"J'ai cru qu'elle savait ce qu'il s'├®tait pass├® et que nous allions nous faire tuer une deuxi├¿me fois." chuchota Pomme qui avait commencer ├á gigoter de stresse.\n\nElles laiss├¿rent ├®chapper quelques petits rires nerveux tout en se mettant en route vers la salle de bain.\n\nComme ├á chaque repas tous ensemble, la pi├¿ce ├®tait inond├®e de douceur. Les rires chaleureux, la bonne nourriture soigneusement pr├®par├®es, le cr├®pitement de la chemin├®e. De l'ext├®rieur, on pourrait presque croire que tout ce qui ├®tait arriv├® n'avait en r├®alit├® jamais exist├®. Cette ambiance qui pouvait apaiser n'importe quelle c┼ôur, donnant ce sentiment si pr├®cieux d'amour. Avoir des personnes qui prennent sinc├¿rement soin de nous, c'est ce que nous avons de plus cher apr├¿s tout. Pourtant ces moments de bonheur ├®taient, sans qu'elles ne le sachent, sur le point de dispara├«tre En effet, elles ignoraient encore l'├®tendue des pouvoirs qui se mettaient d├®j├á en mouvement pour les retrouver.\n\nQuelque part, tr├¿s loin, au-del├á des nuages, une pr├®sence ancienne faisait les cents pas, se rem├®morant l'├®tincelle qui ├®tait parvenu jusqu'├á son horizon habituellement imperturbable. Un vieil homme aux yeux ├®teints et aux traits du visage creus├®s s'├®tait mis ├á trembler, plong├® dans les milliers de pens├®es qui affluaient en continu. Il s'affala ├á nouveau sur son tr├┤ne, serrant les accoudoirs avec force.\n\n"Majest├® ?" Un serviteur s'approcha, inquiet.\n\nLe roi Sukan se leva, son regard redevenu aussi vif qu'autrefois, brillant comme la robe rouge et dor├®e qu'il portait. Son c┼ôur, endormi depuis des ann├®es, lui, battait maintenant comme un tambour de guerre. Il n'y avait qu'une explication : "Ma lumi├¿re... Elle est revenue."\n\nLa vibration magique qu'il avait ressenti plus t├┤t lui parcourait encore les os, famili├¿re et pourtant oubli├®e. Seule une chose au monde pouvait ├®mettre une telle puissance : la magie blanche des c├®lestes. Apr├¿s tant d'ann├®es de silence, elle venait enfin de se r├®veiller.\n\nUn deuxi├¿me serviteur fit son apparition et entra en courant, haletant. "Majest├®, le prince Fred.. demande audience. Il dit avoir ressenti ..."\n\n"Qu'on l'am├¿ne" gronda Sukan. Son c┼ôur repartait pour un tour. Les questions se bousculaient dans sa t├¬te comme les vagues d'une mer d├®cha├«n├®e.\n\nAda ├®tait-elle vivante ?\n\nOu alors ├®tait-ce... l'enfant ?	2025-10-21 22:09:46.84+00
f951e741-2a4a-48b3-af59-54efe2b4dd3d	b373d5ce-36de-481e-8a60-b16b06600ff9	Ins├®parables	C'est en plein milieu de la nuit que Djia se r├®veilla avec un affreux mal de t├¬te, le corps couvert d'une sueur froide. Ses doigts se crisp├¿rent sur les draps tandis que les images de son songe s'estompaient lentement. Encore cette chute. Encore cette femme aux cheveux noirs qui l'appelait d'une voix bris├®e. Un frisson lui parcourra tout le corps.\n\n"J'en peux plus..." murmura-t-elle en se frottant les yeux.\n\nDepuis l'incident il y a quelques mois, ce m├¬me r├¬ve continuait d'appara├«tre sans cesse. Des flash lui revenait comme de mauvais souvenirs bloqu├®es au plus profond d'elle, des souvenirs qui lui semblaient irr├®els mais qui r├®sonnaient dans tout son ├¬tre. Elle referma les yeux doucement en soupirant quand un grattement contre sa fen├¬tre la fit sursauter. Elle se leva d'un bond, le c┼ôur battant ├á tout rompre, pour d├®couvrir la silhouette famili├¿re de Pomme agripp├®e ├á l'encadrement, couverte de neige.\n\n"Ouvre, c'est moi !" chuchota son amie.\n\nDjia poussa le volet avec pr├®caution. "Tu es folle ! Tu m'as fait tellement peur, en plus si Mara t'entend..."\n\n"Justement, elle ronfle comme un ours en hibernation", r├®torqua Pomme en glissant dans la chambre avec agilit├®. Ses cheveux mouill├®s, habituellement teints en blond, laissaient appara├«tre des m├¿ches rousses ├á la racine.\n\n"J'ai vu la lumi├¿re de ta chambre s'allumer. Encore le r├¬ve ?"\n\nDjia hocha la t├¬te sans r├®pondre. Elle referma la fen├¬tre qui avait laisser un courant d'air froid entrer et rafra├«chir toute la pi├¿ce, par peur qu'elle n'attrape un mauvais rhume, envelopp├®es par la p├óle lumi├¿re lunaire filtrant ├á travers les volets.\n\n"├ça fait trois nuits de suite", reprit Pomme en baissant la voix. "Et depuis l'incident dans la for├¬t..."\n\n"Tais-toi !" Djia lui saisit le bras. "On avait jur├® de ne plus en parler."\n\nPomme lui lan├ºa un regard entendu. "Tu crois vraiment qu'on peut faire comme si rien ne s'├®tait pass├® ? Tout le village a vu la lumi├¿re dans le ciel ce jour-l├á."\n\nUn silence lourd s'installa entre elles. Depuis leur fuite face aux Loups Noirs, une tension lourde r├®gnait dans le village. Tout le monde savait que quelque chose se tramait, certains avait commencer ├á en parler de fa├ºon r├®currente, certains se taisait dans la peur de revivre le pass├®, d'autres qui gardaient espoirs en leur dieux esp├®raient qu'ils ├®taient venus les lib├®rer. Lorsque des pierres enflamm├®s ├®taient tomb├®es du ciel, que des ├®clairs de magie blanche s'├®taient abattu aux quatre coins du globe, faisant imploser presque la totalit├® des sources, une grande partie du monde fut plonger dans une ├¿re de d├®solation.\n\nCes sources, portails entre le monde spirituel et notre r├®alit├®, ├®taient un syst├¿me ing├®nieux tr├¿s ancien permettant la circulation de la magie, fluidifiant son flux afin de nourrir la plan├¿te dans les meilleurs conditions. La magie, comme r├®elle ├®nergie vitale, faisait partie de toute chose, en absence compl├¿te de celle-ci la v├®g├®tation elle m├¬me se verrait d├®p├®rir. Avec tous les d├®g├óts caus├®s, plusieurs sources ont ├®t├® bris├®es, obligeant des peuples entier ├á se d├®porter l├á o├╣ la vie existait encore. L'ancienne capitale elle m├¬me avait du ├¬tre abandonn├® pour ├®viter la famine, la nourriture se faisant de plus en plus rare. De nombreux conflits ├®clat├¿rent ├®galement, les villes priv├®s d'une source fonctionnelle se voyait s'appauvrir, devant d├®sormais d├®pendre des autres. A l'inverse, certains petits villages insignifiant ├á l'├®poque s'├®taient vu devenir de grande cit├®s aujourd'hui gr├óce ├á leur nouvel avantage. Tr├¿s vite, certains groupes en qu├¬te de pouvoirs profit├¿rent du contexte et saut├¿rent sur l'occasion de cr├®er un nouvel empire qu'ils dirigeraient gr├óce ├á la force et ├á la terreur. Sans le soutiens des dieux, le manque de ressources rendu les gens de plus en plus m├®fiants, de plus en plus agressifs. C'├®tait le monde dans lequel les deux jeunes filles avait malheureusement grandit.\n\n"On doit tout de m├¬me rester prudentes" s'indigna Djia.\n\nElle regarda Pomme qui ├®tait devenue presque tremp├®e ├á cause de la neige fondue. Elle se leva pour chercher de quoi la s├®cher. Elle saisit une serviette dans son armoire et la jeta sur Pomme sans un mot. Dehors le vent s'├®tait lev├® et fouettaient la vitre de la chambre faisant cliqueter les volets. La neige se remit ├á tomber doucement. L'hiver ├®tait bient├┤t termin├®, les temp├¬tes violentes avaient d├®j├á presque cesser. Cela voulait dire que l'activit├® du village allait reprendre sous peu, devenant de nouveau de plus en plus achaland├®.\n\n"Tu ne dormais pas ?" Finit par demander Djia pendant qu'elles s'asseyaient ensemble au bord du lit.\n\n"Non, je m'entra├«ner ├á danser pour la f├¬te du printemps."\n\n"C'est vrai, le festival des M├®diolias..."\n\nChaque ann├®e pour le retour du printemps le village de Sausir a pour tradition d'organiser un festival. Connu pour leur culture de fleurs diverses et vari├®, le commerce de ces fleurs ├®tait la source principale de revenu des habitants.  Autrefois, avant la chute, c'├®tait une f├¬te qui c├®l├®brer la prosp├®rit├®, des pri├¿res ├®taient chant├®es en c┼ôur pour favoriser l'abondance des r├®coltes et des danses ancestrales ├®taient interpr├®t├®es sous les jeter de p├®tales de M├®diolias. Cette fleur coriace r├®siste tr├¿s bien au froid et dans la r├®gion celle-ci se met m├¬me ├á pousser avant la fin des derni├¿res neiges. Vendue ├á la fois pour ses propri├®t├®s m├®dicinales et la beaut├® de sa couleur violette, elle est l'une des premi├¿res fleurs ├á pouvoir ├¬tre r├®colter. Bien que les derniers ├®v├¿nements furent tragiques, la population au fil des ann├®es avait d├®cid├® de garder cette coutume comme signe d'espoir pour un avenir meilleur. Si les fleurs continuaient de fleurir dans ces temps si durs, alors tout n'├®tait pas perdu.\n\n"Je te montre ?" Demanda Pomme avec un grand sourire.\n\nSous ses m├¿ches ├®bouriff├®es Djia acquies├ºa. C'├®tait en r├®alit├® le moyen parfait pour lui changer les id├®es, inexplicablement, le r├®confort que lui apportait Pomme ├®tait tel que m├¬me le plus court des instants en sa pr├®sence pouvait apaiser toutes ses craintes. Depuis ce jour l├á, il ├®tait devenu difficile pour elle de se d├®tendre et elle restait constamment en ├®tat d'alerte.\n\nSur la pointe des pieds la jeune fille commen├ºa alors ├á se mouvoir avec souplesse, faisant virevolter ses longs cheveux faussement blonds. Son chemisier blanc refl├®tait la lumi├¿re de la lune laissant le souffle coup├® ├á sa seule spectatrice. Cela ne faisait que quelques ann├®es que Pomme avait commenc├® ├á danser, mais sa dext├®rit├® laissait croire qu'elle en avait fait toute sa vie. \n\nDjia, elle, ne s'├®tait jamais vraiment lanc├® dans ce genre d'activit├®, malgr├® son corps de fillette et sa peau lisse comme de la porcelaine, son visage quelque peu androgyne ainsi que sa grande taille lui avaient valu des r├®flexions d├®plac├®es ├á maintes reprises. Loin de s'en soucier, cela lui avait quand m├¬me couper toute envie de ressembler aux jeunes filles de son ├óge. Loin des pouponnages, sans parler de sa nature aventuri├¿re, un doute planait toujours dans l'esprit des gens face ├á sa neutralit├®. Il devenait en effet d├®licat de ne pas se tromper, seuls ceux qui la connaissait ├®taient ├®pargn├®s de ce doute.\n\nCependant, s'il y avait bien une chose que Djia savait faire c'├®tait chanter, une voix douce qui, elle, rappelait imm├®diatement la nature de son genre. Tout bas, des notes sortirent de sa bouche. Avec une si belle prestations de danse, comment ne pas l'accompagner d'une douce chanson ? Presqu'en chuchotant, pour ne pas r├®veiller la maisonn├®e. Les filles se regard├¿rent et se mirent ├á sourire l'une ├á l'autre, oubliant pour un instant tous leurs tracas. Ce moment pr├®cis restera grav├® dans leur m├®moire comme suspendu dans le temps. \n\nLe lendemain matin tr├¿s t├┤t, Lily venait toquer ├á la porte de Mara. Avant m├¬me qu'un son soit ├®mit, celle-ci secoua un non de la t├¬te, signe qu'elle n'avait pas vu Pomme entrer aujourd'hui. Ensemble elles mont├¿rent ├á l'├®tage discutant de futur r├®colte de fleurs. Une fois en haut elles d├®couvrirent leurs filles endormies, se partageant rien qu'un petit lit encore une fois. En refermant doucement la porte derri├¿re elles, les deux m├¿res elles aussi amies depuis toujours se mettaient ├á rire, ce dessein leur rappelant leur propre enfance.\n\nLes pas feutr├®s de Mara et Lily s'estomp├¿rent dans l'escalier, leurs rires ├®touff├®s par l'├®paisseur des murs de bois. Dans la cuisine aux poutres noircies, la vieille Mara s'affaira devant la chemin├®e, ranimant les braises sous une marmite fumante. \n\n"Elles ne changeront jamais, hein ? " murmura-t-elle en ajoutant quelques herbes ├á son eau ├á peine fr├®missante.\n\nLily, assise pr├¿s de la fen├¬tre o├╣ dansaient les premi├¿res lueurs du jour, sourit.\n\n"On dirait qu'hier encore, nous ├®tions ├á leur place." \n\nMara versa dans de vielles tasses le th├® qu'elle venait de pr├®parer. \n\n"Aujourd'hui, c'est la moisson des M├®diolias qui commence. Si le gel n'a pas br├╗l├® les bourgeons... " \n\nElle jeta un coup d'┼ôil anxieux vers le champ voisin, o├╣ des p├®tales violets ├®mergeaient timidement sous la neige fondante. Elle tendit une des tasses ├á son amie avant de se diriger pr├¿s de la chemin├®e ├®teinte.\n\nLes m├¿res s'assirent ├á table, entamant machinalement les pr├®paratifs du festival : compter les p├®tales de M├®diolias s├®ch├®s, v├®rifier les toiles brod├®es de motifs printaniers. \n\n"Les premi├¿res fleurs ont perc├® hier", dit Lily en brisant le calme. \n\nMara fron├ºa les sourcils. \n\n"Et si cette ann├®e... les r├®coltes ne suffisaient pas ? La neige a ├®t├® trop longue, les r├®serves trop maigres."\n\n"Le froid recule enfin, il faut garder espoir. Le festival est bient├┤t, rien de mieux pour remotiver le village. Puis, n'oublie pas la promesse des visiteurs de la capitale de racheter nos plantes m├®dicinales ├á prix d'or..."\n\nPendant ce temps, dans la chambre baignait une lueur laiteuse, les volets mal ferm├®s laissant filtrer les premi├¿res lueurs de l'aube. Le parfum de la serviette humide abandonn├®e la veille impr├®gnait l'air d'une odeur saline. Djia se r├®veilla doucement, repos├®e, comme si la pr├®sence de Pomme avait fait dispara├«tre ses mauvais r├¬ves. Elle se leva pour ouvrir la fen├¬tre et laisser a├®rer la pi├¿ce de cette humidit├®. Son regard se posa au loin, les champs gel├®s scintillaient sous le givre, mais au pied des collines, des taches violettes apparaissaient d├®j├á : les M├®diolias r├®sistaient, fid├¿les ├á leur r├®putation. \n\n La fra├«cheur du matin qui se glissait ├á l'int├®rieur sorti Pomme de son sommeil. \n\n"D├®j├á r├®veill├®e ?" Dit-elle en se frottant les yeux exag├®r├®ment. \n\n"Oui. Nous avons beaucoup de travail aujourd'hui." Elle s'├®tira en baillant.  \n\n"Et puis Lily te cherche peut-├¬tre encore" rigola t-elle.\n\nEn bas, les m├¿res achevaient de garnir les paniers de pansements et de racines m├®dicinales. Les pas des jeunes se firent entendre au loin dans l'escalier et soudainement elles apparurent, t├¬te baiss├®s, les yeux riv├®s vers le sol.\n\n"Nous ne recommenceront plus." S'exclam├¿rent les deux adolescentes ├á l'unisson. \n\nMara et Lilly se mirent ├á rigoler, sachant pertinemment que c'├®tait un bon vieux mensonge, ce n'├®tait ni la premi├¿re fois, ni la derni├¿re fois que l'une de leur fille disparaissait sans un mot.\n\n"Puisque vous ├¬tes d├®j├á pr├¬tes, allez donc porter ces paniers ├á la boutique". Lilly indiqua du doigts 3 paniers remplis de pr├®paratifs diverses et vari├®s. \n\nLes filles sortirent alors de la maison, sautillant, paniers en mains. Elles s'arr├¬t├¿rent un instant ├á l'ext├®rieur pour admirer l'arriv├®e du printemps. D├®barrass├® de son linceul neigeux, le paysage exhalaient une odeur ├ócre de terre mouill├®e et de s├¿ve printani├¿re. Le petit village de Sausir reprenait peu ├á peu vie, les ruelles ├®troites s'animaient de cris joyeux. En marchant, elles observait autour d'elles les ├®tals de tissus color├®s qui se dressaient d├®j├á, les enfants couraient entre les jambes des adultes en brandissant des guirlandes de feuilles s├®ch├®es et des premi├¿res fleurs de M├®diolias.\n\nSoudain, le grincement d'une carriole brisa le calme du village. Cinq voyageurs en tuniques mauves descendirent d'un v├®hicule orn├® de motifs ├®tranges , des spirales rappelant les anciens symboles des sources bris├®es. Leur peau comme poudr├®e de cendre argent├®e, et leurs mains tatou├®es de runes violettes qui semblaient anormalement bien entretenues.\n\n ┬½ Les visiteurs arrivent t├┤t pour le festival ┬╗ s'exclama Pomme avec insouciance.\n\nL'un d'eux, un homme au visage anguleux, retira sa capuche, r├®v├®lant des cheveux gris tress├®s de fils d'argent. Ses yeux, d'un bleu translucide, balay├¿rent les rues du village avec une pr├®cision calcul├®e.\n\n ┬½ Des cultivateurs de l'Ouest ┬╗, murmura Djia, serrant son panier contre sa poitrine. "S├╗rement des ├®veill├®s". \n\n"Peu d'entre eux viennent par ici habituellement... C'est probablement pour le festival ?" Se questionna Pomme en continuant son chemin, h├®sitante.\n\n"Bienvenue ├á Sausir !"  s'exclama le maire plus loin, ├®talant une r├®v├®rence exag├®r├®e. L'homme au manteau brod├® inclina la t├¬te, un sourire trop pr├®cis ├®tirant ses l├¿vres. \n\n"Nous ├®tudions les vertus des fleurs sacr├®es. Votre festival nous int├®resse particuli├¿rement."\n\n"La r├®colte de M├®diolias commence demain ┬╗, intervint la femme du maire qui l'accompagnait. ┬½ Si vous souhaitez observer nos m├®thodes... ┬╗\n\n"Y'aurait-il une auberge o├╣ loger ?" demanda l'homme.\n\nSes yeux, d'un air vif, balay├¿rent la foule ├á nouveau pendant que le maire leur donnait quelques explications, s'arr├¬tant quelques instants sur les deux jeunes filles.  \n\n Djia se rappela soudain le regard glacial du chef des Loups Noirs, quelques mois plus t├┤t, quand elle avait invoqu├® cette lueur dor├®e. Un frisson remonta le long de son ├®chine, comme un mauvais pr├®sentiment, et cette sensation de regard per├ºant, un regard qui reconna├«t un secret enfoui.\n\n"Allons-y maintenant..." Djia s'empressa de marcher dans la direction oppos├®e en faisant signe ├á Pomme.\n\nPendant qu'elles quittaient la sc├¿ne, quelques murmures pouvait se faire entendre derri├¿re elles :\n\n"Quel dr├┤le de tenus, ils ne sont pas du coin".\n\n "Tout ce qui brille cache une dague de nos jours."\n\n"Des cultivateurs ? J'esp├¿re qu'ils d├®penseront dans mon ├®choppe."\n\nPlus au nord, ├á des centaines de lieues de l├á, Tianxin essuyait la sueur de son front sous un ciel ├®tranger. La lettre du roi Sukan se froissant dans sa poche : ┬½ N'oublie pas, retrouver l'origine de cette lueur sera ta seule chance de prouver en qui va ta loyaut├®. ┬╗	2025-10-21 22:13:40.612+00
66867d04-a559-4514-93e3-01c9f83baacb	c698b03c-c76e-4cce-8dab-a39784ab5ab6	þÁ╣Òü«õ©èÒü«Õó¿	Õ░åÞ╗ìÒü«Õ««µ«┐Òü½Òü»ÒÇüÚ½ÿþ¼æÒüäÒü«Õú░Òü»µ▒║ÒüùÒüªÚƒ┐ÒüïÒü¬ÒüïÒüúÒüƒÒÇéÒüƒÒüáÒÇüÕêÇÒéêÒéèÒééÚï¡ÒüäÚØÖÕ»éÒüáÒüæÒüîþ®║µ░ùÒéÆÕêçÒéèÒüñÒüæÒüªÒüäÒüƒÒÇéÕçøÒü«ÞÂ│Úƒ│Òü»Úø¿ÒüáÒéîÒü«ÒéêÒüåÒü½Õ┐ìÒü│ÒÇüþ┐íþ┐áÒéÆµòÀÒüìÞ®░ÒéüÒüƒÕ║èÒü«ÕåÀÒüƒÒüòÒüîÞÂ│ÞúÅÒü½µ▓üÒü┐ÒéïÒÇéÕ¢╝ÕÑ│Òü»ÕÅ│µëïÒéÆµëçÒü«µƒäÒü½µÀ╗ÒüêÒü¬ÒüîÒéëÒÇüÕ╗èõ©ïÒü«ÕÉæÒüôÒüåÒü½Õ×éÒéîÒéëÒéîÒüƒþÁ╣Òü«Õ©│ÒéÆþø«ÒüºÞ┐¢ÒüúÒüƒÒÇéÕ©│Òü«ÕÉæÒüôÒüåÒüºÒü»ÒÇüþÖ¥Òü«ÚáÿÕ£░ÒéÆþÁ▒Òü╣ÒéïþöÀÒüîÕ¥àÒüúÒüªÒüäÒéïÒÇéõ©Çµü»Òüºõ║║ÒéÆþä╝ÒüìÕ░¢ÒüÅÒüÖÒüïÒÇüÒüéÒéïÒüäÒü»Õñ®Òü¥ÒüºÚ½ÿÒüÅÕÉèÒéïÒüÖÒüïÔöÇÔöÇÒüØÒü«ÞªÜµéƒÒéÆµ▒║ÒéüÒüªÒÇüÕ¢╝ÕÑ│Òü»ÕöçÒü½ÒéÅÒüÜÒüïÒü¬þ¼æÒü┐ÒéÆµÁ«ÒüïÒü╣ÒüƒÒÇé\n\nÕ©│ÒüîÚØÖÒüïÒü½ÚûïÒüïÒéîÒÇüÚ╗ÆÒüäõ╗«ÚØóÒéÆÞó½ÒüúÒüƒÕ░åÞ╗ìÒüîþÅ¥ÒéîÒüƒÒÇéµ╝åÕû░Òü«ÕúüÒü½µÿáÒéïþü»þü½ÒüîÒÇüõ╗«ÚØóÒü«þ½»ÒéÆÞÁñÒüÅµƒôÒéüÒüªÒüäÒéïÒÇéÕ¢╝Òü«Þé®Òü½Òü»Ú╗Æþ¥¢þ╣öÒüîÒü¥Òü¿ÒéÅÒéèÒüñÒüìÒÇüÞà░Òü½Òü»õ©Çµ£¼Òü«ÕêÇÒééÒü¬ÒüäÒÇéÕÖéÚÇÜÒéèÒÇüµ¡ªÕÖ¿ÒüØÒü«ÒééÒü«ÒüîÕ¢╝Òü«Õ¡ÿÕ£¿ÒüáÒÇéÕçøÒü»ÞÀ¬ÒüìÒÇüÚíìÒéÆÕ║èÒü½ÒüñÒüæÒüƒÒü¥Òü¥ÒÇüÕú░ÒéÆÕ╝ÁÒéèõ©èÒüÆÒüƒÒÇéÒÇîÚó¿ÕÀØÒü«ÚçîÒéêÒéèÕÅéÒéèÒüùÒÇüÞè▒Òü«Õ«ÂµëÇÕ▒×Òâ╗ÕçøÒü¿þö│ÒüùÒü¥ÒüÖÒÇì  \n\nÒÇîÕú░ÒüîÚ£çÒüêÒüªÒüäÒéïÒÇìÕ░åÞ╗ìÒü«Õú░Òü»ÒÇüÕêâþë®ÒüºÕëèÒüÄÞÉ¢Òü¿ÒüòÒéîÒüƒÒéêÒüåÒü¬ÕåÀÒüƒÒüòÒüáÒüúÒüƒÒÇéÒÇîÒüèÕëìÒü«Þ║½õ¢ôÒü»ÒÇüõ╗èÒÇüõ¢òÞë▓Òü½ÕàëÒüúÒüªÒüäÒéï´╝ƒÒÇì  \n\nÕçøÒü»ÚíöÒéÆõ©èÒüÆÒÇüÞâ©ÕàâÒü½ÞºªÒéîÒüƒÒÇéÒüØÒüôÒü½Õê╗Òü¥ÒéîÒüƒÞè▒µûçÕ¡ùÒüîÒÇüµ£êµÿÄÒüïÒéèÒéÆµÁ┤Òü│ÒüªµÀíÒüÅÚØÆÒüÅÞ╝ØÒüäÒüªÒüäÒéïÒÇéÞè▒Òü«Õ«ÂÒü«Ú¡öÞíôÒü»ÒÇüÞéîÒü½Õ«┐ÒéïµäƒµâàÒéÆµûçÕ¡ùÒü½ÕñëÒüêÒéïÒÇéþÀèÕ╝ÁÒüºÞäêµëôÒüñÞâ©Òü«ÞÁñÒüäµ¿íµºÿÒéÆÒÇüÕ¢╝ÕÑ│Òü»þäíþÉåÒéäÒéèÕ¥«þ¼æÒü┐ÒüºÚÜáÒüØÒüåÒü¿ÒüùÒüƒÒÇé  \n\nÒÇîÒüòÒüüÔÇªÔÇªÕ░åÞ╗ìµºÿÒü«Òüèµ░ùÒü½ÕÅ¼ÒüÖÞë▓Òü½ÒÇüÕñëÒéÅÒéèÒü¥ÒüÖÒÇì  \n\nÕ░åÞ╗ìÒü»õ©Çµ¡®Þ©ÅÒü┐Õç║ÒüùÒÇüµîçÕàêÒüºÕçøÒü«Þé®Òü½ÞºªÒéîÒüƒÒÇéÕê╣ÚéúÒÇüÕ¢╝ÕÑ│Òü«ÞéîÒüîþ▓ƒþ½ïÒüñÒÇéõ╗«ÚØóÒü«õ©ïÒüïÒéëÕÉÉÒüìÕç║ÒüòÒéîÒüƒÕÉÉµü»ÒüîÒÇüÞéîÒéÆõ╝ØÒüåÞè▒µûçÕ¡ùÒéÆÚ£çÒéÅÒüøÒéïÒÇéÒÇîþäíÒÇìÒü¿ÒüäÒüåõ©ÇµûçÕ¡ùÒüîÒÇüþ®║õ©¡Òü½µÁ«ÒüïÒü│õ©èÒüîÒüúÒüƒÒÇéÒüØÒéîÒü»Òü¥ÒéïÒüºÕó¿ÒéÆÕ×éÒéëÒüùÒüƒÒéêÒüåÒü½Õ║âÒüîÒéèÒÇüÕæ¿ÒéèÒü«þ®║µ░ùÒéÆÕÉ©ÒüäÞ¥╝ÒéôÒüºÒüäÒüÅÒÇéÕçøÒü«Þâ©Òü½ÕàëÒüúÒüƒµûçÕ¡ùÒü»ÒÇüÒü┐ÒéïÒü┐ÒéïµÜùÒüÅÒü¬ÒüúÒüªµÂêÒüêÒüƒÒÇé  \n\nÒÇîµäƒµâàÒéÆµÂêÒüÖÚ¡öÞíôÒüïÒÇìÕçøÒü»µ¡»ÒéÆÚúƒÒüäÒüùÒü░ÒéèÒÇüõ╗èÕ║ªÒü»µëçÒéÆÕ║âÒüÆÒüƒÒÇéÚó¿ÒéÆÕêçÒéèÞúéÒüÅÚƒ│Òü¿Òü¿ÒééÒü½ÒÇüÞê×ÒüîÕºïÒü¥ÒéïÒÇéþÁ╣Õ£░Òü«µëçÒü½Õó¿ÒéÆµƒôÒü┐Þ¥╝Òü¥ÒüøÒÇüµ£êÕàëÒéÆÕÅùÒüæÒüªþ®║õ©¡Òü½ÒÇîµüïÒÇìÒü¿ÒüäÒüåÕ¡ùÒéÆµÁ«ÒüïÒü╣ÒéïÒÇéÒüÖÒéïÒü¿ÒÇüÒüØÒü«µûçÕ¡ùÒüîÞè▒Òü│ÒéëÒü«ÒéêÒüåÒü½ÕêåÞºúÒüòÒéîÒÇüÕ░åÞ╗ìÒü«Õæ¿Õø▓ÒéÆÕîàÒéÇÒÇéÕîéÒüäÒü»õ©ÇÞ╗óÒÇüµíâÒü«ÚªÖÒéèÒüîþ½ïÒüíÞ¥╝ÒéüÒüƒÒÇé  \n\nÕ░åÞ╗ìÒü»ÕïòÒüÿÒüÜÒü½µëïÒéÆõ╝©Òü░ÒüùÒÇüÞê×ÒüåÞè▒Òü│ÒéëÒéÆµÅíÒéèÒüñÒüÂÒüùÒüƒÒÇéÒÇîþäíÒÇìÒü«µûçÕ¡ùÒüîÕåìÒü│þÅ¥ÒéîÒÇüµíâÒü«ÚªÖÒéèÒéÆþ▓ëÒÇàÒü½þáòÒüÅÒÇéÕ¢╝Òü«Õú░Òü»õ¢ÄÒüÅÚƒ┐ÒüäÒüƒÒÇéÒÇîÞè©ÞÇàÒü½ÒÇüµüïÒéÆµø©ÒüÅÞ│çµá╝Òü»Òü¬ÒüäÒÇéÒüèÕëìÒü«ÚüÄÕÄ╗Òü»ÔöÇÔöÇÒÇì  \n\nÒÇîÚüÄÕÄ╗Òü»ÒÇüÕó¿Òü¿ÕÉîÒüÿÒüºÒüÖÒÇìÕçøÒü»µëçÒéÆÚûëÒüÿÒÇüÕ░åÞ╗ìÒü«Þâ©ÕàâÒü½µè╝ÒüùÒüñÒüæÒüƒÒÇéÒÇîµÂêÒüêÒü»ÒüùÒü¥ÒüøÒéôÒüîÒÇüµû░ÒüƒÒü¬Þë▓ÒüºÕíùÒéèÒüñÒüÂÒüøÒü¥ÒüÖÒÇì  \n\nõ©ÇÞºªÕì│þÖ║Òü«þÀèÕ╝ÁÒüîÕ╝ÁÒéèÞ®░ÒéüÒéïÒÇéÕ░åÞ╗ìÒü«µîçÒüîÕçøÒü«ÕûëÒü½þÁíÒü¥ÒéìÒüåÒü¿ÒüùÒüƒþ×¼ÚûôÒÇüÕ¢╝ÕÑ│Òü»µÇÑÒü½Õ║èÒéÆÞ╣┤ÒüúÒüƒÒÇéµëçÒéÆµ¡ªÕÖ¿Òü½Þªïþ½ïÒüªÒÇüþø©µëïÒü«õ╗«ÚØóÒéÆþïÖÒüåÒÇéÒüùÒüïÒüùÒÇüÕ░åÞ╗ìÒü»õ©Çþ×¼ÒüºÒüØÒü«Þ║½ÒéÆþ┐╗ÒüùÒÇüÕçøÒü«ÞâîÕ¥îÒü½þ½ïÒüñÒÇéÒÇîÕêÇÒü¬Òüìµ▒║ÚùÿÒÇüÒüèÕëìÒü»Þ▓áÒüæÒüáÒÇì  \n\nÕ¢╝Òü«ÞàòÒüîÕçøÒü«Þâ┤ÒéÆþÀáÒéüÒüñÒüæÒÇüÞÇ│ÕàâÒüºÕøüÒüÅÒÇéÒÇîÒü¬Òü£ÒÇüõ┐║ÒéÆµîæþÖ║ÒüÖÒéï´╝ƒÒÇì  \n\nÒÇîÕ░åÞ╗ìµºÿÒüîÒÇüþäíÒü«µûçÕ¡ùÒüºÕ┐âÒéÆÚÜáÒüÖÒüïÒéëÒüºÒüÖÒÇìÕçøÒü»ÕûÿÒüÄÒü¬ÒüîÒéëþ¡öÒüêÒüƒÒÇéÒÇîÒüØÒüôÒü½ÔÇªÔÇªÕ¡ñþï¼Òüîµ╗▓ÒéôÒüºÒüäÒéïÒÇì  \n\nÕ░åÞ╗ìÒü«ÞàòÒü«ÕèøÒüîõ©Çþ×¼ÒüáÒüæþÀ®ÒéôÒüáÒÇéÒüØÒü«ÚÜÖÒü½ÒÇüÕçøÒü»Õ║èÒü½µëïÒéÆÒüñÒüìÒÇüþ┤áµù®ÒüÅÞÀØÚøóÒéÆÕÅûÒüúÒüƒÒÇéÚ╝ôÕïòÒüîÚÇƒÒüäÒÇéÕ¢╝ÕÑ│Òü»þƒÑÒüúÒüªÒüäÒüƒÒÇéõ╗èÒüôÒü«Õá┤Òü»ÒÇüÚ¡öÞíôÒü«Þ®ªþÀ┤ÒüºÒééÒÇüÕ£░õ¢ìÒü«õ║ëÒüäÒüºÒééÒü¬ÒüäÒÇéÒüôÒéîÒü»ÒÇüõ║îõ║║ÒüáÒüæÒü«µÜùÚùçÒü«õ©¡ÒüºÒüùÒüïþöƒÒü¥ÒéîÒü¬ÒüäÒÇüÕì▒ÚÖ║Òü¬Õà▒Ú│┤ÒüáÒÇé  \n\nÒÇîµÿÄµùÑÒééµØÑÒüäÒÇìÕ░åÞ╗ìÒü»õ╗«ÚØóÒéÆþø┤ÒüùÒÇüÚâ¿Õ▒ïÒéÆÕç║ÒüªÞíîÒüúÒüƒÒÇéÒÇîÒüèÕëìÒü«Õó¿ÒüîÒÇüõ┐║Òü«Õ┐âÒéÆµƒôÒéüÒéëÒéîÒéïÒüïÒü®ÒüåÒüïÔöÇÔöÇÞªïÒüøÒüªÒééÒéëÒüèÒüåÒÇì  \n\nÕñ£Òüîµø┤ÒüæÒÇüÕçøÒü»õ©ÄÒüêÒéëÒéîÒüƒÕ«┐ÞêÄÒüºþØÇþë®ÒéÆÞä▒ÒüäÒüáÒÇéÞéîÒü½µÁ«ÒüïÒüÂÞè▒µûçÕ¡ùÒü»ÒééÒüåµÂêÒüêÒüªÒüäÒüƒÒüîÒÇüÕ░åÞ╗ìÒü«µîçÒü«µäƒÞºªÒüáÒüæÒüîµ«ïÒüúÒüªÒüäÒéïÒÇéÕ¢╝ÕÑ│Òü»µëïÚªûÒü½þ©øÒéëÒéîÒüƒÚ╗ÆÒüäþ┤ÉÒéÆÞºúÒüìÒÇüÕ╣╝ÒüäÚáâÒü½Õê╗Òü¥ÒéîÒüƒÕéÀÞÀíÒü½ÞºªÒéîÒüƒÒÇéÒüØÒéîÒü»ÚÅíÒâÄÕñ¬ÕêÇÒü«þ┤ïþ½áÔöÇÔöÇÕ¢▒Òü«Õ«ÂÒü«þºÿÕ«ØÒéÆþƒÑÒéïÞÇàÒü½ÒüáÒüæõ©ÄÒüêÒéëÒéîÒéïÕì░ÒÇé  \n\nÒÇîÒü¬Òü£ÒÇüÕ░åÞ╗ìÒü»þºüÒü«ÚüÄÕÄ╗ÒéÆÔÇªÔÇª´╝ƒÒÇì  \n\nþûæÕòÅÒéÆÞâ©Òü½ÒÇüÕ¢╝ÕÑ│Òü»Õ©âÕøúÒü½ÒééÒüÉÒéèÞ¥╝ÒéôÒüáÒÇéþ£áÒéèÒü½ÞÉ¢ÒüíÒéïþø┤ÕëìÒÇüÕ╣╗ÞªÜÒüîÚûâÒüäÒüƒÒÇéÕ░åÞ╗ìÒü«õ╗«ÚØóÒüîÕ┤®ÒéîÒÇüÕåÀÒüƒÒüäµîçÒüîÞâ©ÕàâÒü«ÕéÀÞÀíÒéÆÒü¬Òü×ÒéïÒÇéÞéîÒüîþå▒ÒéÆµîüÒüíÒÇüÞªïÒüêÒü¬ÒüäÒÇîþäíÒÇìÒü«µûçÕ¡ùÒüîÕ¢╝ÕÑ│ÒéÆÚú▓Òü┐Þ¥╝ÒéôÒüºÒüäÒüÅÒÇéÕÅ½Òü│ÒüØÒüåÒü½Òü¬ÒéèÒÇüÕçøÒü»Òü»ÒüúÒü¿þø«ÒéÆÚûïÒüæÒüƒÒÇéµ▒ùÒü░ÒéôÒüáÞéîÒü½ÒÇüµû░ÒüƒÒü¬Þè▒µûçÕ¡ùÒüîÒüåÒüúÒüÖÒéëÒü¿ÕàëÒüúÒüªÒüäÒüƒÒÇé  \n\nµ£ØÚ£▓Òüîþ¬ôÒéÆõ╝ØÒüåÚáâÒÇüÕ¢╝ÕÑ│Òü»µ▒║µäÅÒüùÒüƒÒÇéÒüôÒü«Õ««µ«┐ÒüºÒÇüÕ░åÞ╗ìÒü«õ╗«ÚØóÒéÆÕëÑÒüîÒüÖÔöÇÔöÇÒüØÒüùÒüªÒÇüÚüÄÕÄ╗Òü½þ©øÒéëÒéîÒüƒÞç¬ÕêåÞç¬Þ║½ÒéÆÒééÒÇüÕó¿ÒüºÕíùÒéèµø┐ÒüêÒéïÒü«ÒüáÒü¿ÒÇé	2025-10-22 09:28:51.468+00
6728ba5b-6523-4eee-9301-b4652e285525	0ecbf452-250b-4ce2-aa00-f40c41977bd9	L'├ëlan et la R├®verb├®ration	La lumi├¿re crue des n├®ons du centre de conf├®rences transper├ºait les paupi├¿res de Simon, mais dans son cr├óne, les ├®crans tactiles de la salle de commande clignotaient dÔÇÖun bleu ├®th├®r├®. Le Directeur, silhouette anguleuse coiff├®e dÔÇÖun casque m├®tallique qui capte les battements de son propre c┼ôur, pianotait sur son clavier avec une f├®brilit├® maladive. Les neurones-servants ajustaient leur danse synaptique en rythme, anticipant les lignes du discours stock├® dans les archives de la M├®moire, pr├®cises comme des rails de train. ┬½ Il va falloir acc├®l├®rer les s├®quences motrices de la m├óchoire. Les virgules sont trop longues ┬╗, aboya-t-il, sa voix r├®sonnant dans les canaux auditifs comme un coup de crosse contre la tempe. ├Ç ses c├┤t├®s, la Conseill├¿re se tenait debout, ses dreadlocks argent├®es flottant dans le vide ├®cho des souvenirs, un sourire mat dansant entre ses l├¿vres ├®th├®r├®es. ┬½ Et si les virgules respiraient ? Aucun auditoire ne tue un homme pour une pause trop longue. ┬╗ Le Directeur la fusilla dÔÇÖun coup dÔÇÖ┼ôil virtuel, ses pupilles num├®riques se r├®tractant en points minuscules. ┬½ Proposer la mort lente par perfection inefficace. Tu prends un caf├® avec lÔÇÖ├ëmotionnel en ce moment ? ┬╗ La r├®ponse claqua comme un ressort avort├® : un g├®missement ├®mergea de la fosse limbique, similaire ├á du verre pil├®. LÔÇÖ├ëmotionnel, entit├® pulpeuse et changeante aux allures de gel├®e pourpre, venait dÔÇÖinonder les synapses de cortisol. ┬½ Paris 2014. Microphone d├®fectueux. Rires du premier rang. TU SAIS CE QUI ARRIVE QUAND ON INNOVE ┬╗, ricana-t-il, projetant des images fragment├®es qui vrill├¿rent lÔÇÖestomac de Simon.  \n\nSous la glotte, le n┼ôud se resserra. Les doigts cliquetaient sur les pr├®sentations PowerPoint. ┬½ Recalibrate les micro-expressions faciales ! ┬╗ hurla le Directeur, figeant instantan├®ment les coins des l├¿vres de Simon en un rictus de pl├ótre. La Conseill├¿re glissa une main translucide dans les flux de donn├®es, tamisant la temp├®rature corporelle de trente-huit degr├®s hyst├®riques ├á un calme l├®ger. ┬½ Souviens-toi quand tu as b├®gay├® aux v┼ôux ├á table. Puis ri avec eux. ┬╗ Mais la M├®moire, assise dans son coin sous un arc dÔÇÖhippocampes bioluminescents, secoua la t├¬te sans quitter son scrolleur de souvenirs. ┬½ Trop fragile. Un cercle vicieux de d├®faite post-trauma. Alerte. ┬╗ LÔÇÖurgence ├®lectrifia la pi├¿ce. Le Directeur devint une tornade de doigts courrouc├®s, invoquant les protocoles des sosies proches-zoom pour saboter la r├®union. ┬½ On repart du slide deux. Correction int├®grale. ┬╗ La Conseill├¿re intercepta une commande de halte cardiaque accidentelle. ┬½ Et si on abandonnait ? ┬╗ proposa-t-elle, doux murmure absorbant le grondement. LÔÇÖ├ëmotionnel se dilata, saignant des fragments de panic 3.0 dans la trach├®e. ┬½ ABANDON ? TU VEUX QUÔÇÖIL CORRADE SA DOCTEUR EN CHIRURGIE !! ┬╗ Toute la salle de commande bascula en alarme rouge. Simon crut vomir. Son cerveau in vivo se r├®voltait.  \n\nSur la sc├¿ne, le corps h├®sita. Bouche entrouverte, pupilles papillonnant les applis ├á r├®citer le paragraphe exact des finances 2022. Soudain, une ├®tincelle. ├Ç c├┤t├® du montant du budget yoga pour la mairie, une note manuscrite tremblait, oubli├®e dans la terreur nomm├®e "intuitif". Le Directeur sÔÇÖ├®trangla dans une temp├¬te de pixels. ┬½ PR├ë-POSI-TION POST-PUBLICAIRE REVISE DE TON GANT DE BORDEAUX. CRISE DE D├ëMISSION POST-SCONDUCTION ! ┬╗ La Conseill├¿re, mollement appuy├®e contre le r├®verb├¿re des hanches, sourit ├á la canne qui tremblait dans la poche. ┬½ ou juste une photo de Marie dans une marre dÔÇÖindigo. ┬╗ LÔÇÖ├ëmotionnel sÔÇÖ├®tira vers la temporaire vision, dilatant les art├¿res d├®faitistes. ┬½ Focus sur la sueur du pouce gauche. Sens leur d├®ception. ┬╗  \n\nSimon recula dÔÇÖun pas, les hanches qui sÔÇÖ entrechoquaient. ┬½ H-Hem ┬╗, parvint ├á articuler son gosier avant de planter face ├á un tableau grisonnant. Dans la salle, un silence mortel. Dans le cerveau, une guerre civile. Le Directeur rageait en retouchant les plombs moteurs pour forcer le corps de monter un genou, le bulb pingait des antid├®presseurs-mots oubli├®s, la M├®moire d├®chirait des archives sur le sujet "microbes sociaux" par peur de perdre le chromosome calme. Enfin, sous les hurlements intoxiqu├®s, un dernier choix. La Conseill├¿re laissa filer ses doigts dans le r├®seau c├®r├®belleux, inversant unÚüôµòÖ du cortex, et murmura : ┬½ laisse-le tomber ┬╗.  \n\nSimon d├®rapa sur un mot. Menton contre sol. Les rires ├®clat├¿rent. Mais ├á lÔÇÖint├®rieur, le chaos virait ├á lÔÇÖexode. LÔÇÖ├ëmotionnel sÔÇÖ├®touffait de gloire, noyant le liquide c├®phalo-rachidien sous lÔÇÖacide de lÔÇÖ├®chec-pis-possible. La M├®moire se r├®fugiait loin dans lÔÇÖamygdale, effray├®e du pouvoir de lÔÇÖincertitude. Seule la Conseill├¿re tenait bon, patiente dans la tornade, un cafard de fixit├® dans le flou. ┬½ NÔÇÖest-ce pas courageux, cette chute ? ┬╗ l├ócha-t-elle au Directeur, fig├® dans lÔÇÖattente de nouveaux codes. ├ëclips├®.  \n\nLorsque Simon se releva, lÔÇÖinterphone inter-cr├ónien venait de sÔÇÖembrumer. Le c┼ôur tapait moins comme un sourd revencheur, et loin, tr├¿s loin, un souvenir lointain dÔÇÖavion en papier planait dans les limbes... Mais personne ne sÔÇÖy attarda. Le pr├®sent, plus que jamais, chantait la d├®sillusion.	2025-10-22 09:29:41.191+00
b5cfc599-d57b-4bcd-875b-c66012832170	0a119146-72e5-4a1c-97c9-d8aca926f187	L'Heure des Lignes	Nathan effleura le ticket du bout de l'index, comme s'il craignait de d├®chirer ce fragile vestige du temps. ┬½ Le 18 marsÔÇª CÔÇÖ├®tait le jour o├╣ jÔÇÖai rat├® mon train pour Nantes, murmura-t-il, soudain tendu. Celui o├╣ je tÔÇÖai envoy├® ce message en pleine panique parce que mon oral de master a d├®rap├®. ┬╗ Enzo se figea, les jointures de ses doigts blanchirent sur le carnet. Dehors, le tramway num├®ro C cuba contre les rails dans un grincement m├®tallique, tandis quÔÇÖune goutte dÔÇÖeau glissait lentement le long de la vitre, tra├ºant une ligne entre eux et le monde.  \n\n┬½ Tu as gard├® ce ticketÔÇª depuis ce jour-l├á ? ┬╗ La voix de Nathan se brisa, ├á peine audible sous le brouhaha du caf├®. Enzo d├®tourna le regard, fixant la tasse de caf├® refroidi dont la surface rid├®e refl├®tait les n├®ons tremblotants. ┬½ Je lÔÇÖai r├®cup├®r├® dans la poubelle de la gare. Tu avais oubli├® ton sac plastique pr├¿s du distributeur. ┬╗ Il marqua une pause, les paupi├¿res baiss├®es. ┬½ Dedans, il y avait ton programme de colloque, une photo de nous devant la gare Saint-LazareÔÇª et ce ticket. ┬╗  \n\nNathan sentit sa poitrine se serrer. Ce jour-l├á, il avait couru dans les couloirs d├®serts, les mains moites serrant son dossier, sans remarquer lÔÇÖhomme assis sur le banc du quai, le crayon courant sur un carnet. Enzo, qui nÔÇÖavait m├¬me pas cherch├® ├á lÔÇÖarr├¬ter. Qui avait pr├®f├®r├® fixer dans le fusain lÔÇÖinstant pr├®cis o├╣ Nathan disparaissait derri├¿re les portes automatiques.  \n\n┬½ La noteÔÇª *├Ç ton rythme, le temps dispara├«t*, reprit Nathan en tournant le ticket entre ses doigts. CÔÇÖest toi qui as ├®crit ├ºa ? ┬╗  \n\nEnzo secoua la t├¬te, un sourire triste aux l├¿vres. ┬½ Un vieux contr├┤leur. Il mÔÇÖa dit ├ºa quand je lui ai demand├® pourquoi les horaires SNCF changeaient sans cesse. *Les trains suivent des secondes, pas des vies*, quÔÇÖil mÔÇÖa r├®pondu. *Toi, si tu marches ├á ton rythme, le temps nÔÇÖexiste plus.* ┬╗ Sa main effleura machinalement lÔÇÖappareil photo accroch├® ├á sa ceinture, comme pour se rassurer. ┬½ Depuis, je collectionne ces instants hors du temps. Comme ce ticket. ┬╗  \n\nLe silence sÔÇÖinstalla, ├®pais, charg├® de non-dits. Nathan observa les cernes sous les yeux dÔÇÖEnzo, ces ombres que le caf├® ne suffisait plus ├á dissimuler. Il se rappela les nuits o├╣ son amant rentrait ├á lÔÇÖaube, les v├¬tements impr├®gn├®s dÔÇÖodeurs de ferraille et de pluie, murmurant des noms de gares comme des pri├¿res.  \n\n┬½ Alors partons, maintenant ┬╗, lan├ºa Nathan soudain, poussant la chaise en arri├¿re. La serveuse tourna la t├¬te, surprise, tandis quÔÇÖil attrapait la main dÔÇÖEnzo.  \n\n┬½ Maintenant ? MaisÔÇª ┬╗  \n\n┬½ Le prochain TER pour Nantes part dans vingt-sept minutes. ┬╗ Enzo d├®glutit, ses yeux noisette sÔÇÖagrandissant. ┬½ Tu as regard├® lÔÇÖhoraire ? ┬╗  \n\nNathan haussa les ├®paules, un rire nerveux secouant ses ├®paules. ┬½ JÔÇÖai m├®moris├® le planning quand tu mÔÇÖas montr├® cette photo de la gare de Nantes. Celle avec les horloges en mosa├»que. ┬╗ Il glissa le ticket dans la poche poitrine du manteau dÔÇÖEnzo, sentant sous ses doigts le battement rapide de son c┼ôur. ┬½ Montre-moi ce temps qui dispara├«t. ┬╗  \n\nDehors, la pluie sÔÇÖ├®tait transform├®e en bruine argent├®e. Ils coururent sous les r├®verb├¿res qui sÔÇÖallumaient un ├á un, leurs pas r├®sonnant contre les fa├ºades haussmanniennes. Enzo serrait son carnet contre sa poitrine, comme un bouclier, tandis que Nathan riait, essouffl├®, en ├®vitant les flaques dÔÇÖeau. ├Ç lÔÇÖangle de la rue des Faussets, son pied glissa sur une plaque de verglas invisible. Enzo le rattrapa par la taille, leurs visages ├á quelques centim├¿tres, le souffle court m├¬l├® dans lÔÇÖair froid.  \n\n┬½ Tu crois quÔÇÖon va le rater ? ┬╗ haleta Nathan, le front coll├® contre lÔÇÖ├®charpe dÔÇÖEnzo.  \n\nCelui-ci consulta sa montre, puis leva les yeux vers les panneaux dÔÇÖaffichage de la rue. ┬½ Non. Le train partira ├á 18h07 pr├®cises. Pas une seconde avant. Pas une seconde apr├¿s. ┬╗ Il sourit, pour la premi├¿re fois depuis des heures. ┬½ Parce que pour les voyageurs comme nousÔÇª le temps sÔÇÖarr├¬te toujours. ┬╗  \n\nIls atteignirent la gare en courant, les cheveux tremp├®s, les joues rouges. Sur le quai, Enzo ouvrit son carnet ├á une page vierge, son crayon volant d├®j├á sur le papier pour capturer la lueur dor├®e des r├®verb├¿res se refl├®tant dans les flaques. Nathan sÔÇÖassit pr├¿s de lui, observant les ombres des voyageurs press├®s d├®filer devant les fen├¬tres du wagon.  \n\n┬½ Pourquoi Nantes ? ┬╗ demanda-t-il tout bas.  \n\nEnzo ne leva pas les yeux. ┬½ Parce que cÔÇÖest la seule ville o├╣ tu nÔÇÖas jamais pos├® tes valises. Et je veux y dessiner ton sourire. ┬╗  \n\nLe sifflet du conducteur retentit. Nathan glissa sa main dans celle dÔÇÖEnzo, sentant sous ses doigts les traces de fusain qui ne partaient jamais vraiment. Dans le wagon qui sÔÇÖ├®branlait, le ticket jauni br├╗lait dans sa poche, promesse dÔÇÖun temps qui, enfin, leur appartenait.	2025-10-22 10:44:36.811+00
ab693312-a3e3-44c0-b1f7-28e7fc05b60d	c9b1255a-0a71-493b-8048-8e69a9d9b6a0	µÜùÚùçÒü«Þ¿¬Òéî	Þìëµ£¿Òééþ£áÒéïþ£ƒÕñ£õ©¡ÒÇüþö░µñìÒüêÒü«þÁéÒéÅÒüúÒüƒÕ¥îÒü«þö░þòæÒü½µ╝éÒüúÒüªÒüäÒüƒÒü¼ÒéïÒüäµ╣┐µ░ùÒüîÒÇüÚï¡ÒüÅÕåÀÒüƒÒüäÚó¿Òü½ÕñëÒéÅÒüúÒüƒÒÇéµ╗ØÕÄƒµØæÒü«µØ▒Òü«Òü½ÞíÇÒü«ÒéêÒüåÒü½ÞÁñÒüäµ£êÒüîµÿçÒéèÒÇüÞûäµÜùÒüäÕàëÒüîõ╗üþÄïþ½ïÒüíÒüÖÒéïÕ«ÂÒÇàÒéÆµƒôÒéüÒüªÒüäÒüƒÒÇéµØæÒü«Õç║ÕàÑÒéèÕÅúÒü½Õ¢ôÒüƒÒéïÕÀ¿µ£¿Òü«õ©ïÒüºÒÇüÕñºÕ▓®Òü½õ©Çõ║║Òü«þöÀÒüîþ½ïÒüúÒüªÒüäÒüƒÒÇéÚ╗ÆÒüäÞó┤ÒüîÚó¿Òü½þ┐╗ÒéèÒÇüþ½╣µ×ùÒü«ÒéêÒüåÒü½þ¬üÒüìþ½ïÒüñõ©ëµ£¼µîçÒü«þ¿¢ÕÅñÒâæÒâ│ÒâüÒüºµ×»ÒéîÒüƒÞæëÒéÆÒü¬ÒüÄµëòÒüúÒüƒÒÇé\n\nÒÇîÒüôÒüôÒüºÒééÒüåõ©ÇÒüñþó║Þ¬ìÒüùÒüªÒüèÒüôÒüåÒÇéÒü¥ÒüƒÞåØÒéÆÕ┤®ÒüùÒüªþÀ┤þ┐ÆÒéÆÒéÁÒâ£ÒüúÒüªÒüäÒéïÒü¬ÒÇì\n\nÕñºÕ▓®ÒüïÒéëÕ░æÒüùÚøóÒéîÒüƒÕá┤µëÇÒüºÒü»ÒÇüõ©ëõ║║Òü«Õ░æÕ╣┤ÒüîÞèïÒü╗ÒéèÒéÆÒüùÒü¬ÒüîÒéëµò¼þñ╝ÒüùÒüªÒüäÒüƒÒÇéÕ░æÕ╣┤ÒüƒÒüíÒü«ÞªûþÀÜÕàêÒü½Õ║âÒüîÒéïÚçÄÕÄƒÒü½Òü»ÒÇüÕñ£Ú£▓Òü½Òü¼ÒéîÒüƒÞìëÒüîµÅ║ÒéîÒüªþ£ƒµû░ÒüùÒüäÞíÇÒü«þüæÞÉ¢ÒüîÕùàÒüÆÒéïÒÇéÒüØÒü«õ©íµëïÒü½Òü»Õ░Åµ×ØÒüºÒü»Òü¬ÒüÅÒÇüÚ╗ÆÒüäõ║öÕ»©ÚçÿÒüîµÅíÒéëÒéîÒüªÒüäÒüƒÒÇéþäíÚÇáõ¢£Òü½µö¥ÒüƒÒéîÒüƒõ©Çµû╣Òü½Õ░æÕ╣┤ÒüƒÒüíÒü»þ£ëõ©ÇÒüñÕïòÒüïÒüòÒüÜÚü┐ÒüæÒéïÒÇé\n\nÒÇîµ£¼µ░ùÒü½Òü¬ÒüúÒüƒÒü¿ÒüìÒüîÒÇüÒüèÕëìÒü«Þ▓áÒüæÒü½Òü¬ÒéïÒüáÒéìÒüåÒÇéõ╗èÕ«ÁÒééÒéêÒüÅÒéäÒüúÒüƒÒÇì\n\nÒüØÒüåÞ¿ÇÒüúÒüªõ╗▓ÚûôÒü«Þé®ÒéÆÒü¢ÒéôÒü¿ÒüƒÒüƒÒüÅÒÇéÕïòÒüìÒü«õ©¡ÒüºÕâàÒüïÒü½Õ¢▒Òü«ÞúéÒüæÒüƒþ┤ïÒüîÒüéÒéïÚØ®Õà£Òü½þ£╝ÕàëÒüîÕ«┐ÒéïÒÇéÒüØÒü«þ×¼ÚûôÒÇüÞâîÕ¥îÒüïÒéëÚï¡Òüäþ®║µ░ùÒü«µî»ÕïòÒÇéµï│ÒéÆÕÅùÒüæµ¡óÒéüÒéïÒéêÒüåÒü½ÕñºÕ▓®ÒéÆÞ╣┤ÒüúÒüªõ¢ôÒéÆÕø×Þ╗óÒüòÒüøÒüƒþöÀÒü»ÒÇüÕ»©ÕëìÒüºÕêÇµÆâÒü«ÕêâÒéÆþëçµëïÒüºÚÿ▓ÒüÉÒÇéµ¼íÒü«þ×¼ÚûôÒÇüÕñ¬Þà┐Òü½µÀ▒ÒüäÕêçÒéèÕéÀÒüîÕê╗Òü¥ÒéîÒéïÒÇéµ¡ôÕú░Òü½Òééõ╝╝Òüƒµ▓Öµ▒░ÒüøÒü¼þ¼æÒü┐ÒÇéµÜùµ«║ÞÇàÒü«þî┐ÚØóÒÇüÚ╝╗ÒüîÒüÅÒüúÒüñÒüìÒÇüÞíÇÞç¡ÒüäÕæ╝ÕÉ©ÒÇé\n\nÒÇîÒüØÒü«ÕêÇÒü½Òü»ÔÇªÔÇªÒÇì\n\nþø©µëïÒüîÞ¿ÇÒüúÒüªÒüƒÕê╣ÚéúÒÇüÕêÇÞ║½ÒéÆÒü½ÒüÄÒéïÒüØÒü«µÄîÒéÆÞ╣┤ÒéèÚúøÒü░ÒüÖÒÇéµ£¿Òü«ÞæëÒü«ÒéêÒüåÒü½Õ«ÖÒéÆÞê×ÒüåÚûôÒü½ÒÇüÞ║½ÒéÆÕ▒êÒéüÒÇüÞÂ│ÕàâÒü½Þ╗óÒüîÒéïµ×»þ½╣ÒéÆÕç║ÒüùÒüªÒüïÒéÅÒüùÒüƒÒÇéÞíÇÒüîþƒ│þò│Òü½µ╗┤ÒéïÚƒ│ÒüîÕöÉþ¬üÒü½Òü¿Òü¥ÒéèÒÇüÒüƒÒüáÒüíÒü½õ©ëÒÇüÕøøÒü«Õ¢▒ÒüîÕîàÕø▓ÒüùÕºïÒéüÒüƒÒÇéþöÀÒü«þ½ïÒüíõ¢ìþ¢«ÒüïÒéëÒü»þü½þƒóÒü¿ÒééÕàÑÒéîõ║ñÒü£ÒÇüµØæÒü©Òü«ÞÑ▓µÆâÒéÆÕ»ƒÒüùÒüƒÒÇé\n\nÒÇîÒé¼ÒéñÒâëÒü«Þ®ªÕÉêÒüîÒüôÒéôÒü¬µû╣µ│òÒüºÔÇªÔÇª´╝üÒÇì\n\nÕñóÒü«õ©¡ÒüºÞü×ÒüäÒüƒÕú░ÒüîÒüÖÒéïÒÇéÒüáÒüîµ¡ñÕçªÒü»þÅ¥Õ«ƒÒü«ÕîûÒüæþë®Òü«Õ«┤ÒüáÒüúÒüƒÒÇéÕ┤®ÒéîÒüïÒüæÒüƒÕí¥ÕáéÒü«ÕëìÒü½Õ░ÄÒüïÒéîÒÇüÒü¥ÒüáÕ¡Éõ¥øÒüîõ║îõ║║ÒÇüõ╗üþÄïþ½ïÒüíÒüÖÒéïõ©ëõ║║þÁäÒü«õ©¡ÚûôÞÀØÚøóÒüºµúÆþ½ïÒüíÒü½Òü¬ÒüúÒüªÒüäÒéïÒÇéþöÀÒü»µØ¥þ¼áÕñ£ÕÅëÒü¿ÒüäÒüåÕ╣╝Úª┤Òü«Õ¿ÿÒéÆÞä│ÚçîÒü½ÕûÜÒü│Òü¬ÒüîÒéëÒééÒÇüÒüØÒüôÒü½Òü»µòÁÒü«ÕêÇÒüîÞ┐½ÒüúÒüªÒüäÒüƒÒÇé\n\nõ©Çµ£¼Ú╝╗ÕàêÒéÆÒüïÒüÖÒéüÒüƒÕêÇÒüîÕí¥ÕáéÒéÆÞ▓½ÒüäÒüƒµû¡ÒüúÒüƒþ×¼ÚûôÒÇüÞ¿ôÞ¬¡Òü«Õæ¬µûçÒü«ÒéêÒüåÒü¬Õ╝ÅÒüîµÁ«ÒüïÒéôÒüáÒÇéÕà¿ÒüªÞü×ÒüôÒüêÒü¬ÒüÅÒü¬ÒéïÒü╗Òü®Òü«ÞíØµÆâÒü«Õ¥îÒü½Òü»ÒÇüÕ░æÕÑ│Òü«Þ¬¡µø©Õú░ÒüÖÒéëµÂêÒüêÒüƒÒÇéÚ╗ÆÕêÇÒéÆµè£ÒüÅÒÇé\n\nµÜùµ«║ÞÇàÒüîÕ┤®ÒéîÒéïµ¡®Õ╣àÒéÆÞªïÞÂèÒüùÒüªÒü«ÕêçÒéèµö¥ÒüíÒÇéÒüáÒüîÒüØÒü«þä╝ÒüæÒüñÒüäÒüƒÕêÇÞ║½Òü½Òü»ÒÇüÕ©©Òü¬ÒéëÒü¼µ░ùÚàìÒüîÒüéÒéïÒÇé\n\nÕà¿ÒüªÒü»ÒüØÒü«µêªÕá┤ÒüºÕºïÒü¥ÒüúÒüƒÒÇéÒü«ÒüíÒü½ÕâºÒéäþè¼þÑ×Òü«ÚøåÞÉ¢Òü¿Ú¿ÆÒüîÒéîÒéïÚçÄõ╝ÅÒü«Þ░ÀÒü½ÒÇüþöÀÒü»Õ»íÚ╗ÖÒü¬Õêçµû¡ÒüïÒéëµû░ÒüƒÒü¬Õæ¬ÞäêÒéÆÕÅùÒüæÕàÑÒéîÒéïÞªÜµéƒÒéÆµè▒ÒüäÒüƒÒÇéÚçÿÒü«ÞÀíÒüîµÂêÒüêÒÇüµêªÒü«µé▓Ú│┤ÒüîÞÇ│Òü½µ«ïÒéïõ╗èÒééÒÇüþöƒÒü¥ÒéîÒüƒÞ¼ÄÒüîÞâ©ÒéÆþÀáÒéüõ╗ÿÒüæÒéïÒÇé\n\nÒüèÒü«ÕñûÕúüÒü½Õ×éÒüùÒüªÒüäÒüƒÚûÇÕëìÒü«õ¥øÒüêþë®ÒüîÒÇüÒüƒÒüáÒüíÒü½Õ╝ÀÚó¿Òüºþ┐╗ÒüúÒüƒÒÇéÒüØÒü«õ©ïÒü½õ¢òÒüïÒü«Õ¢▒ÒÇéÕ╣îÒüïÒéëþ┤║Òü«ÞíúÒüîÞªùÒüìÒÇüÒüØÒü«Õ¢▒Òü»ÒéåÒéïÒéäÒüïÒü½þƒ│Òü«õ©èÒüºµ║ÂÒüæÒüªÒüäÒüúÒüƒÒÇé\n\nÕêÇÒü½ÚûóÒüùÒüªõ©ûþòîÒü«þÉåÒüîÒüåÒüöÒéüÒüÅµ░ùÚàìÒüîÒüùÒÇüþöÀÒü»ÞíÇÒü«ÚüôÒü½ÞÂ│ÒéÆÞ©ÅÒü┐ÕàÑÒéîÒéïõ©ÇÕê╗ÒéÆµéƒÒéïÒÇéÒüïÒüñÒüªÒü«Õ©½ÒüîÞ¬×ÒüúÒüƒÕÅñÒéüÒüïÒüùÒüäõ©ÇÞ¬¼ÒÇüÒÇîÚ¼╝µû¼ÒéèÒÇìÒü«µèÇµ│òÒÇüµ¡ªÕú½ÚüôÒü«ÚÖÉþòîõ║æÒÇàÒüîÕ¿ÿÒéÆµ«ïÒüùÒüƒÕá┤Òü½µÁ«ÒüïÒü│õ©èÒüîÒéèµÂêÒüêÒüªÒüäÒüÅÒÇé\n\nÒÇîÒüòÒüªÔÇªÔÇªÒüäÒüûÒÇéÒÇì\n\nÞíÇÒü«ÚüôÒéÆÒüƒÒü®ÒéïÒü¿µ▒║µäÅÒüùÒüªÒÇüÕ░æÕ╣┤ÒüƒÒüíÒü«ÒüäÒéïÞ░ÀÒü©Òü«Õ»äÒéèÚüôÒéÆµ¡óÒéüÒüƒÒÇéµ│ÑÒü¥Òü┐ÒéîÒü«µìòÒéëÒüêµû╣Òü½µâ»ÒéîÒüƒÕ¥îÒü«þ¢░Òü¿ÒüùÒüªÕÀ▒Òü½µêÆÒéüÒéÆõ©ÄÒüêþÂÜÒüæÒüƒÕñ£ÒÇéÒüØÒéîõ╗Ñõ©èÒü«ÞªÜµéƒÒüîÒÇüÚø¿Òü¿µÀÀÒüÿÒüúÒüƒþöƒÒü¿µ¡╗Òü«þäÖÒüÿÒüƒÒü½ÒüèÒüäÒü«õ©¡Òü½µ¢£ÒéôÒüºÒüäÒéïÒéëÒüùÒüäÒÇé\n\nÕêÇÒéÆÚ×ÿÒü½ÒüùÒü¥ÒüúÒüªÒÇüÕáñÒü½þ½ïÒüñÕº┐Òü»ÒÇüµùÑÒü½Õ¢ôÒüªÒüƒµØ¥ÞäéÒü«ÒéêÒüåÒü½Òü¥ÒüÂÒüùÒüäÒÇéõ©ëÕÅìÒü«Ù®êÒüêÒü»Òü¬ÒüÅÒÇüÒüƒÒüáÕëìÒü«ÒéüÒéèÒü½ÕïòÒüÅÒÇéµÇÆµÂøÒü«ÒéêÒüåÒü¬µêªÒüäÒüîÒüØÒü«Õ¥îÒü½ÒüéÒéïÒüáÒéìÒüåÒüôÒü¿Òü»ÒÇüÒüØÒéîÒü¥ÒüºÒü½õ¢ôÚ¿ôÒüùÒüªÒüìÒüƒõ║ïÒüïÒéëÒÇüõ║êµ©¼ÒüºÒüìÒüƒÒÇé	2025-10-24 14:05:58.905+00
62b4236a-2191-4454-af03-5e3b3ba43785	c9b1255a-0a71-493b-8048-8e69a9d9b6a0	þü░Òü¿Ú£èþ¼ªÒü«þï¡Úûô	õ©íÒü«µÄîÒü½ÞíÇÒéÆµ╗▓Òü¥ÒüøÒü¬ÒüîÒéëÒÇüþöÀÒü»µ│ÑÒü«ÚªÖÒéèÒüïÒéëÕñºÒüìÒüÅµü»ÒéÆÕÉ©ÒüúÒüƒÒÇéÕëèÒéèÕÅûÒéëÒéîÒüƒÕñ¬Þà┐Òü«ÕéÀÕÅúÒüîõ©Çþ×¼ÒÇüÞç¬ÕêåÒü«ÞíÇÒü½þäªÒüÆÒüñÒüïÒüøÒéïÒéêÒüåÒü½þùøÒéôÒüáÒÇéÒüØÒéôÒü¬þùøÒü┐ÒéÆõ╣ùÒüøÒéïÒüòÒéîÒüªÒÇüÞÂ│ÕàâÒü«Õ¢▒ÒüîÞûäÒüÅÞúéµò░ÒéÆµ£øÒéÇþàÖÒü«ÒéêÒüåÒü½þÀ┤ÒéèÒüñÒüäÒüƒÒÇé\n\nÒÇîÒüôÒüôÒüÿÒéâÕïØÞ▓áÒéÆþÁéÒüêÒéëÒéîÒüØÒüåÒü½ÒééÒüéÒéèÒü¥ÒüøÒéôÒéêÒÇì\n\nÒéäÒéèÕá┤Òü«Òü¬Òüäþ£®ÒüùÒüòÒü½Õë┐ÒüúÒüªÒüùÒü¥ÒüåÕú░ÒÇéþöÀÒü»ÒéäÒüÉÒéëÒéÆÞ©ÅÒéÇÒü¿ÒÇüÕí¥ÕáéÒü«ÞÀíÒéÆþØ¿ÒéÇÒéêÒüåÒü½ÒüùÒüªþàÖÒü½þ╣ïÒüîÒéïÞÂ│ÕàâÒü«þ│©ÒéÆÞ┐¢µ║»ÒüùÒüƒÒÇéÕñ£Ú£▓ÒéÆµÁ┤Òü│Òüƒþƒ│ÒééÕ┤®ÒéîÒéïÒéêÒüåÒü½µ¡¬ÒéôÒüºÒüäÒüƒÒÇéµØ¥µÿÄÒüÖÒéëµìîÒüæÒü¬ÒüäµÜùÚùçÒü½ÚüáÒüûÒüïÒéïÕ¥îÒÇüþôªþñ½Òü«ÚÜÖÚûôÒüïÒéëÕÅñÒü│ÒüƒÚÉÿµÑ╝ÒüîÒéÇÒüòÒüÅÒéïÒüùÒüäÕ¢▒ÒéÆÞÉ¢Òü¿ÒüùÒüªÒüäÒüƒÒÇé\n\nþöÀÒüîÞ©ÅÒü┐ÕàÑÒéîÒéïÒü¿ÒÇüÚó¿Òü«µÁüÒéîÒüîµ¡óÒü¥ÒüúÒüƒÒÇéþè¼þÑ×Òü«Õ¢▒ÞÁ░ÒéèÒü½õ╝╝ÒüªÒÇüµ£¢ÒüíÒüƒµƒ▒Òü½þ¼ªÕÆÆÒüîþ®║ÒéÆÞúéÒüÅÒéêÒüåÒü½Þ▓╝ÒéëÒéîÒüªÒüäÒüƒÒÇéþø«ÒéÆµôªÒéïÚûôÒÇüÒüØÒéîÒü»µû░ÒüƒÒü¬µ┐âÒüòÒéÆÞªïÒüøÒüƒÒÇéÕ¿ÿÒü«Þ¬¡µø©Òü«Õú░ÒüîÚá¡Òü«õ©¡Òü½Òü¥ÒüáÒüôÒééÒüúÒüªÒüäÒüƒÒÇéÒüØÒü«µø©þë®ÒüïÒéëÞ¬×ÒéëÒéîÒüƒÞìÆµ│òÕ©½Òü«Þ®▒ÔÇöÔÇöÔÇöÕæ¬ÒéÅÒéîÒüƒÕêÇÒü»ÒÇüõ¢┐ÒüäµëïÒü«Õæ¢ÞäêÒéÆÚéäÒüÖõ╗úÒéÅÒéèÒü½ÒÇüÞíÇÒü«µƒôÒü¥ÒéïÚüôÒéÆÕêÂÚÖÉÒüÖÒéïÒü¿ÒüäÒüåÒÇéÕú░ÒüîÚü║ÒüòÒéîÒüƒÕ»║ÒéêÒéèÒééÒü¥ÒüáÞïÑÒüäÒÇé\n\nÒÇîþêÂÒüòÒéôÒü¬ÒéëÒÇüÒüôÒüôÒüºþ£áÒüúÒüªÒüƒÒüôÒü¿Òü»þäíÒüòÒüØÒüåÒüºÒüÖÒü¡ÒÇì\n\nþôªþñ½Òü«õ©èÒüºµ¡®Òü┐ÒéÆµëòÒüäÒÇüÕ╗âÕ»║Òü«ÕÑÑÒü½ÒüéÒéïÚüôÕá┤ÞÀíÒü©Òü¿µè╝ÒüùÚÇ▓ÒéÇÒÇéÚƒ┐ÒüÅÕú░Òü½ÒÇüþöÀÒü»ÕÀ▒Òü«ÞÂ│Úƒ│ÒéÆµÑ¢ÒüùÒéÇÒéêÒüåÒü½µ¡óÒéüÒüƒÒÇéÕ£░ÚØóÒü½ÚúøÒü│µòúÒüúÒüƒÚñèÕ¡Éþ©üþÁäÒü«µø©ÕàÀÒü«µ«ïÒéèÒÇéÒüØÒüùÒüªõ©¡Õñ«ÒÇüÞÖÜþ®║ÒéÆÕÉæÒüäÒüƒµ£¿Òü«ÚªÖþéëÒÇéþçâÒüêÒüƒþùòÒüîþ¬üÒüìµîçÒüùÒüªþó║ÒüïÒü¬þÁÉµ×£Òü¬ÒéëÒüûÒéïÒééÒü«ÒéÆþñ║ÒüùÒüªÒüäÒüƒÒÇé\n\nÕ╝òÒüìÞ¥╝Òü¥ÒéîÒéïÒéêÒüåÒü½ÚüôÕá┤Òü«ÕåàÚâ¿Òü½Òü»Þ©ÅÒü┐Þ¥╝ÒéÇÒü¿ÒÇüþ×¼µÖéÒü½õ¢òÒüïÒüîÞ┐öÒüúÒüƒÒÇéÒü¼ÒéïÒüäþ¡êÒü«þ®║µ░ùÒüîÒÇüþ¬üþäÂÕåÀÒüƒÒüÅÕÆ¢Òü│µ│úÒüÅÒéêÒüåÒü½Òü¬ÒüúÒüƒÒÇéÕ▓®Òü«Õ║èÒü½Þ╗óÒüîÒéïµè£ÒüæÒüƒÚ╗ÆÕêÇÒÇéõ║öÕ»©ÚçÿÒü«µø┐ÒéÅÒéèÒü½µÅíÒéëÒéîÒéïÒüØÒü«ÕêâÒü½Òü»ÒÇüÚüÄÕÄ╗ÒüîÕê╗Þ¥╝Òü¥ÒéîÒüªÒüäÒüƒÒÇé\n\nþø«ÒéÆÕçØÒéëÒüÖÒü¿ÒÇüþçâÒüêÒéïÒéêÒüåÒü¬ÞÁñÒüÆÒüƒÕ¡ùÒÇéÒÇÄÚ¼╝µû¼Òéèõ║îõ╗úþø«þø┤õ╝ØÒÇÅÒÇéÕú░Òüºµê©µâæÒéÅÒüÜÒÇüþöÀÒü»Ú×ÿÒéÆÞåØÒü½þ½ïÒüªÒüƒÒü¥Òü¥õ©ïÒüÆÒüƒÒÇéÕêçÕàêÒüïÒéëÕç║Òéïµü»ÒüîÒÇüÚà©ÕîûÒüùÒüƒÕêâÒü«ÞúÅÒü½µîƒÒü¥ÒüúÒüƒÕ╣¢Ú£èÒü«ÒéêÒüåÒü½Õÿ»ÒüäÒüƒÒÇé\n\nÒÇîÒüôÒéôÒü¬Òü¿ÒüôÒéìÒü½ÚÜáÒüùÒüªÒüäÒüƒÒéÅÒüæÒü»ÔÇªÔÇªÒÇì\n\nÒüØÒü«ÕéÀÒüïÒéëÕ¢╝Þç¬Þ║½Òü½ÞäêÒü«ÕèøÒüîµê╗ÒüúÒüƒÒéêÒüåÒü½ÞÂ│ÕàâÒüîÕ╝ÀÕ╝ÁÒüúÒüƒÒÇéÚüÄÕÄ╗Òü½µ»ìÕ▒ïÒüºÞªïÒüïÒüæÒüƒÒÇüÞ▓áÕéÀÒüùÒüƒþêÂÒü«Þâîõ©¡ÒÇéþêÂÒü»ÒüôÒü«ÕêÇÒéÆµÅíÒéèÒüùÒéüÒü¬ÒüîÒéëÒÇüÒü¬ÒüÖÒüÖÒü╣ÒééÒü¬ÒüÅÕ┤®ÒéîÒüªÒüäÒüƒÒÇéÒüØÒü«Þ¿ÿµåÂÒéÆþ┐│ÒüÖµ▓Öµ▒░ÒüîÒÇüÒü®ÒüôÒüïþå▒ÒüÅÒü¬ÒüúÒüƒÕÑçÕªÖÒü¬µäƒÞªÜÒÇé\n\nµÜùÕê╣Òü«ÕÉèÒéèµê©Òü«ÚÖ░Òü½ÒÇüÚçæÕ║òÒü«þëçµúÆÒüîÕìèÚûïÒüìÒü½Òü¥ÒüºÚûïÒüïÒéîÒüƒÒÇéÕÑÑÒü½õ©ëµ×ÜÒü«ÞÂ│Õ¢▒Ó©éÓ©▓Ó©óÕç║ÒüùÒüºÒü«Òü░ÒüòÒéîÒüƒþÁîÕÀ╗ÒüîÞ®░ÒéüÒéëÒéîÒüªÒüäÒüƒÒÇéÕê╣ÚéúÒÇüõ¢òÒüïÒüîÚï¡ÒüäÕàëÒüºÚûâÒüäÒüƒÒÇé\n\nÒÇîµ¡óÒéüÒü¥ÒüùÒéçÒüåÒÇüÒüéÒü¬ÒüƒÒü»ÒüôÒü«ÚüôÒü½ÕàÑÒéïÒü╣ÒüìÒüºÒü»Òü¬ÒüïÒüúÒüƒÒÇì\n\nÕÉÉÒüìµì¿ÒüªÒüƒÕú░ÒüîÒÇüþöÀÒü«ÞâîÕ¥îÒüïÒéëÒü«õ©ÇµÆâÒéÆÕ╣©Òü½ÒüùÒüƒÒÇéþ¼ªÒéÆÕ«ÖÒü½µÅÅÒüÅÒüöÒü¿ÒüÅÞàòÒéÆµö¥ÒüñµòÁÒéÆÒÇüþöÀÒü»Õ▓®Õá┤ÒéÆÞ╣┤ÒüúÒüªÕÆäÕùƒÞ┐ÄµÆâÒüÖÒéïÒÇéÒüáÒüîÒÇüÒéÅÒüÜÒüïÒü½ÚüàÒéîÒüƒÒüƒÒéüÒÇüÞé®ÕÅúÒü½µÀ▒ÒüòÒéÆµîüÒüƒÒü¼µëôÒüíÞ¥╝Òü┐ÒéÆÕÅùÒüæÒéïÒÇé\n\nµï│Òü½Õ«┐Òéïµû¼ÒéïÕèøÒéÆþäíÞªûÒüÖÒéïÒüïÒü«ÒéêÒüåÒü½ÒÇüþöÀÒü»Õ▒àõ©ªÒüÂþ¼ªÒéÆµîüÒüñþöÀÒü«ÚíöÒéÆÞªùÒüìÞ¥╝ÒéÇÒÇéÒüØÒü«ÞÇ│Òü½ÒÇüµëôÒüíÕ»äÒüøÒéïµ×ùÒü«ÕïòÒüìÒüîÞºúÒéïÒéêÒüåÒü½Òü¬ÒüúÒüƒÒÇéÕ¢╝Òü«Þé®Òü«ÕéÀÒéÆµï¡ÒüåÚó¿ÒüîÒÇüÒüôÒüôÒüºµ£¬µø¢µ£ëÒü«ÞíØµÆâÒéÆµïàÒüúÒüªÒüäÒüƒÒÇé\n\nÒÇîþºüÒééþë╣þò░Òü¬µû╣Òü»ÒÇüÒüôÒü«ÒüåÒüêÒü¬ÒüÅÕ½îÒüúÒüªÒüèÒéèÒü¥ÒüÖÒÇì  \n\nÞîÂþ¡àÒü¿ÚíöÒéÆÕÀíÒéëÒüùÒüªÒÇüþöÀÒü»Õæ¬Òü«ÕêâÒüïÒéëõ©Çµû╣ÒéÆÕÅìÒéïµòÁÒü«ÞóêÞúƒÒéÆþïÖÒüúÒüƒÒÇéµ£¬µø¢µ£ëÒü«Úï¡ÒüòÒüºþ¬üÒüäÒüªÒüïÒéëÒÇüÚàìµ░┤µ©áÒéÆÞ╣┤ÒüúÒüªÞÀØÚøóÒéÆÕÅûÒéïÒÇéÕ¢╝ÒüîµëïÒü½ÒüùÒüƒÕ¢óÞªïÒü«ÕêÇÒü»ÒÇüµôìµÇºÒéÆµîüÒüíÞ┐öÒüÖÒéêÒüåÒü¬ÕèøÒéÆÕÇƒÒéèÒéïõ║║ÚûôÒüîÒüäÒü¬ÒüäÒü¿ÒÇüõ©ìþÖ║Òü½ÒüÖÒéïÒééÒü«ÒüáÒüúÒüƒÒÇé\n\nµòÁÒü«ÞóêÞúƒÕ©âÒéÆÕêçÒéèÞúéÒüäÒüƒþöÀÒü«ÕÅìÕ┐£Òü½ÒÇüõ║îõ║║þø«Òü«þ¡ûÕú½Òüîþ¼ªÕæ¬ÒüºÞÂ│ÒéÆµëòÒüúÒüªÒüÅÒéïÒÇéÒüáÒüîÒÇüÒüØÒü«Ú£èõ©¡Òü½þ¿¢ÕÅñÒüºÚìøÒüêÒüƒÕç║Òüùµè£ÒüæÒüîÞªïÞÂèÒüùÒüƒÒÇéÞÀ│ÒéôÒüºÒüØÒü«Þ©ÅÒü┐ÞÀíÒéÆÞªåÒüúÒüƒÒéêÒüåÒü½ÒüùÒüªþ¬üÒüìÒüéÒüÆÒüƒÒüØÒü«ÕëúÕ░ûÒü½Òü»ÒÇüµÿöµùÑÒü«ÚìøþÀ┤ÒüîÕ«ƒÒüúÒüƒÒÇé\n\nÒÇîµ£¡ÒüºÕëúÒéÆÕçîÒüöÒüåÒüºÒüÖÒüï´╝ƒÒÇì\n\nþ┤ïÒÇàÒü¿ÒüùÒüƒÕêÇÒü»ÒÇüÕ╣¢Ú¼╝ÚÇÇµ▓╗Òü½Òééõ╝╝ÒüƒÕÅùÚøúÒéÆþé║ÒüÖõ©Çµî»ÒéèÒüáÒüúÒüƒÒÇéÒüØÒéîÒéÆµÅíÒüúÒüƒµòÁÒü»ÕåìÒü│Õ¥îÚÇÇÒéïÒÇéþ®║µ░ùÒüîµ¡¬ÒéôÒüáÒüïÒü«ÕªéÒüÅÒÇüµëïÒü½þòÖÒéüÒüìÒéîÒü¬Òüäþ¼ªÒüîõ©Çµ×ÜÒüƒÒüáÒüíÒü½þá┤ÒéïÒÇé\n\nÒüØÒü«þ×¼ÚûôÒÇüþöÀÒü»ÞâîÕ¥îÒéÆþó║ÒéüÒüƒÒÇéÕ░æÕ╣┤ÒüƒÒüíÒüîÚü┐ÒüæÒüîÒüƒÒüìþàÖÒüºÚú▓Òü┐Þ¥╝Òü¥ÒéîÒüƒÞ░ÀÒü½ÕÅ▒ÒéëÒéîÒüªÒüäÒüƒÒÇéÞç¬ÕêåÒü½Þ¬ôÒüúÒüƒÕÀ▒Òü«ÒéÆõ╗úÒüêÒéïÒüôÒü¿ÒéÆÕÀ«ÒüùÞ®░ÒéüÒüªÒÇüÚüôÕá┤ÞÀíÒü«Þ╣┤ÒéïÞúÅµ£¡ÒéÆÕÅûÒéïÒÇé\n\nþ®║Òü©Ú®│ÕçÂÒüùÒüƒÕú░ÒüîÒÇüÒüôÒü«µÖéÒüØÒü«µ£¡Òü½µ║óÒéîÒüƒÒÇéµö¥ÒüƒÒéîÒüƒþå▒µ│óÒüîµÜùÕê╣ÞÀíÒü«Õ▒ïµá╣Òü«þƒ│þôªÒéÆÕ┤®ÒüÖÒÇéþöÀÒü»Õæ╗ÒüìÒüñÒüñÒééÒÇüþäíÕéÀÒü¿Òü»ÒüäÒüìÒü¬ÒüîÒéëõ©ëÕ║ªþ½ïÒüªþÂÜÒüæÒü½µòÁÒü©Þ║ìÒüúÒüƒÒÇé\n\nÒüØÒü«µêªÕá┤ÒüºÕ¥ùÒüƒþûæÕòÅÒü¿µÇÆÒéèÒü¿ÒüîÒÇüÚüôÕá┤Òü½Õ░üÒüÿÞ¥╝ÒéüÒüƒõ©Çµî»ÒéèÒéÆÞºúÒüäÒüƒÒÇéÕêÇÒéÆµÅíÒéèÒüùÒéüÒéïÕ║ªÒÇüµû¡þÁÂÒüòÒéîÒüƒÞ¿ÿµåÂÒüîÕåìÚûïÒüòÒéîÒüƒÒÇéþêÂÒü»ÒüôÒüôÒüºÒü«µêªÒüäÒü«Õ¥îÒÇüµØæÒü½µê╗ÒéëÒüÜÚ£èþ¼ªÒüºÞ║½ÒéÆÕ«êÒüúÒüƒÒü¥Òü¥µùàþ½ïÒüúÒüƒÒÇéÒüØÒüùÒüªõ╗èÒü»ÒÇüÒüØÒü«Õ«┐Õæ¢ÒüÿÒü┐ÒüƒÚçìÕ£ºÒüîþöÀÞç¬Þ║½Òü«ÕÅúÒéÆÚûïÒüïÒüøÒüƒÒÇé\n\nÒÇîÕïØÒüñÒü«Òü»þºüÒüºÒü»Òü¬ÒüÅÒÇüÕæ¬ÞíôÒü«õ╗úÒÇì\n\nÕ┐âÕ¥ùÚüòÒüäÒü«ÕëúÒü½ÒéêÒüúÒüªÒü¬ÒüîÒéëÒÇüþ¼ªÕæ¬Òü«þÁÉõ╗░ÒüîÕ┤®ÒéîÒéïÒÇéþöÀÒü»ÕÇÆÒéîÒüƒµòÁÒü«Þâîõ©¡ÒéÆÚíºÒü┐ÒüÜÒÇüÚüôÕá┤ÒéÆþº╗ÕïòÒüùÒüªµû░ÒüƒÒü¬Õñ®õ║òÒü«þùòÒéÆþó║Þ¬ìÒüÖÒéïÒÇéÚó¿ÒüìÒüªÒüäÒüƒþ¼ªÒü«õ©ÇÒüñÒüîÒÇüÔÇ£ÚçÄõ╝ÅÒü«Þ░ÀÔÇØÒéÆµîçÒüÖÒéêÒüåÒü¬µø©ÕàÀÒéÆµ«ïÒüùÒüªÒüäÒüƒÒÇé\n\nÞíÇÒü½µëôÒüƒÒéîÒüƒÕêÇÒéÆÚ×ÿÒü½µê╗ÒüÖÒü¿ÒÇüµ£¡Òü¿Õà▒Òü½Õñ®õ║òõ©ïÒü½ÞÀ¬ÒüÅÒÇéÞÀíÕ¢óÒü«Òü¬ÒüäþêÂÒü«Õ¢óÒüîÒÇüþü½Òü½þä╝ÒüæÒüƒÞë▓Òüºµ╝éÒüúÒüªÒüäÒüƒÒÇéÒüØÒü«µëïÒüºÞºªÒéîÒüƒþôªþñ½ÒüïÒéëÚªÖÒéïþü░Òü¿þé¡Òü«Õæ│ÒÇéÒüØÒüùÒüªÒÇüµ¼íÒü«Þ░ÀÒüåÒü¡ÒéèÒéÆÕ©»Òü│ÒüƒÕÉÉµü»ÒÇé	2025-10-24 14:05:59.905+00
9f8b6274-26bf-428f-bd95-06f363e03f3d	0a119146-72e5-4a1c-97c9-d8aca926f187	Les Lignes Invisibles	Le Caf├® M├®rignac ├®tait satur├® de ce doux chaos typique des apr├¿s-midi bordeaux : cliquetis de cuill├¿res contre les tasses en porcelaine, murmures de conversations entrecoup├®s de rires ├®touff├®s, lÔÇÖodeur persistante de caf├® br├╗l├® et de pain chaud. Enzo Soum, recroquevill├® dans un coin pr├¿s de la fen├¬tre, ne remarqua pas imm├®diatement lÔÇÖarriv├®e de Nathan. Son attention tout enti├¿re ├®tait absorb├®e par les courbes de la Gare Saint-Jean esquiss├®es sur son carnet Moleskine. Le trait t├®nu de son crayon H refaisait vivre la majest├® d├®fra├«chie de lÔÇÖ├®difice, chaque ligne un hommage silencieux aux ann├®es de voyages solitaires dans les wagons de la SNCF.\n\nSes doigts, macul├®s de fusain, effleuraient les reliefs imaginaires des colonnes en fonte lorsque deux mains se pos├¿rent soudain sur ses ├®paules. Une bouff├®e de parfum bois├®, familier, accompagna le souffle chaud de Nathan contre sa nuque.\n\n┬½ Tu dessines encore des gares ? ┬╗ chuchota ce dernier, le nez enfoui dans les cheveux indisciplin├®s dÔÇÖEnzo.\n\nLe jeune homme sursauta, refermant instinctivement son carnet. Trop tard. Nathan, d├®j├á pench├® par-dessus son ├®paule, fron├ºa les sourcils devant lÔÇÖesquisse d├®taill├®e.\n\n┬½ CÔÇÖest magnifiqueÔÇª Mais pourquoi tu ne mÔÇÖas jamais dit que tu dessinais ? ┬╗\n\nEnzo haussa les ├®paules, mal ├á lÔÇÖaise. ┬½ CÔÇÖest juste un truc pour tuer le temps entre deux trains. ┬╗\n\nNathan insista, sourire en coin. ┬½ Laisse-moi voir la suite. ┬╗\n\nDÔÇÖun geste brusque, Enzo tenta de r├®cup├®rer son carnet, mais Nathan, plus rapide, lÔÇÖouvrit ├á une autre page. Son sourire sÔÇÖeffa├ºa. L├á, sous ses yeux ├®carquill├®s, tr├┤nait un portrait au fusain : lui-m├¬me, assis sur un banc de la gare, le regard perdu vers les panneaux dÔÇÖaffichage. Les d├®tails ├®taient frappants ÔÇö la ride dÔÇÖexpression pr├¿s de son ┼ôil gauche quand il souriait, le pli us├® de son manteau bleu marine.\n\n┬½ TuÔÇª Tu mÔÇÖas dessin├® ? ┬╗ balbutia Nathan, le c┼ôur battant. ┬½ Quand ? Je ne tÔÇÖai jamais vu faire. ┬╗\n\nEnzo rougit, triturant le coin de son carnet. ┬½ CÔÇÖ├®tait il y a deux semaines. Tu attendais ton TER pendant que je r├®glais la focale de mon appareil. Tu avais cet airÔÇª paisible. ┬╗\n\nLe silence sÔÇÖinstalla, ponctu├® par le cliquetis dÔÇÖune tasse derri├¿re le comptoir. Nathan tourna d├®licatement les pages, d├®couvrant dÔÇÖautres esquisses : des compartiments vides, des mains agrippant des poign├®es de wagons, des ombres projet├®es par les quais ├á lÔÇÖaube. Chaque trait semblait respirer une intimit├® quÔÇÖEnzo nÔÇÖavait jamais os├® verbaliser.\n\n┬½ Pourquoi tu caches tout ├ºa ? ┬╗ murmura Nathan, effleurant du bout du doigt le sourire esquiss├® sur son propre portrait.\n\nEnzo d├®tourna le regard vers la rue, o├╣ un tramway grin├ºa en passant. ┬½ Parce que cÔÇÖestÔÇª fragile. Comme ces vieilles gares quÔÇÖon r├®nove sans comprendre leur ├óme. ┬╗\n\nNathan referma le carnet avec douceur, posant sa main sur celle dÔÇÖEnzo. ┬½ Montre-moi. Tout. ┬╗\n\nDehors, le ciel de Bordeaux virait au gris plomb, annon├ºant lÔÇÖaverse. Mais ├á cette table, entre deux tasses de caf├® fumant, une nouvelle ligne venait dÔÇÖ├¬tre trac├®e. Un ticket jauni, coinc├® entre les pages oubli├®es du carnet, attendait dÔÇÖ├¬tre d├®couvert ÔÇö dat├® du 18 mars, trajet Bordeaux-Nantes en 7h32, avec en marge une note ├á peine lisible : *┬½ ├Ç ton rythme, le temps dispara├«t.	2025-10-22 10:29:05.981+00
70244c84-956e-4d45-a788-5278cc998ab1	655b112d-df6f-4398-9044-f7cba93a87e5	Nuit d'├ëgar├®e	Le cr├®puscule sÔÇÖ├®tendait comme un voile de lumi├¿res orang├®es sur la ville de Chicago, enveloppant les buildings et les rues d'une atmosph├¿re feutr├®e et un brin myst├®rieuse. A├»ko conduisait depuis plusieurs heures, les yeux fatigu├®s, les ├®paules tendues par la tension de la route. Elle avait quitt├® lÔÇÖOntario le matin m├¬me, esp├®rant rentrer chez elle, ├á Toronto, avant minuit. Mais ├á mesure que la journ├®e avan├ºait, les circonstances sÔÇÖ├®taient complexifi├®es. Elle avait pris un d├®tour inattendu, se perdant dans les rues serpentines de Chicago, une ville qui semblait ne jamais dormir.\n\nA├»ko bailla, s'├®tirant un peu sur son si├¿ge de voiture. La fatigue commen├ºait ├á peser lourdement sur ses ├®paules. Elle jeta un coup d'┼ôil ├á la boussole de son GPS, qui clignotait de mani├¿re inqui├®tante. ┬½ Tu es perdue, A├»ko, ┬╗ se reprocha-t-elle ├á mi-voix. Elle avait tent├® de suivre les indications de son application de navigation, mais les rues tortueuses et les feux de circulation incessants avaient rendu la t├óche ardue. Le GPS la guidait maintenant vers une direction inconnue, loin de lÔÇÖautoroute quÔÇÖelle avait lÔÇÖintention de reprendre.\n\nElle tourna ├á un coin de rue, esp├®rant trouver un panneau indicateur ou un rep├¿re familier. Mais chaque intersection ressemblait ├á la pr├®c├®dente : avenues bord├®es de b├ótiments imposants, trottoirs anim├®s de passants press├®s, et lumi├¿res multicolores des enseignes commerciales. A├»ko se sentit d├®sempar├®e. Elle nÔÇÖavait jamais ressenti une telle solitude dans une foule aussi dense.\n\nSoudain, un crissement de pneus et un klaxon strident la firent sursauter. Elle avait failli entrer en collision avec un taxi jaune qui klaxonnait furieusement. A├»ko s'arr├¬ta brusquement, le c┼ôur battant. Elle se rangea sur le bas-c├┤t├®, posant sa t├¬te sur le volant. ┬½ Respirer, ┬╗ se commanda-t-elle. Elle prit une profonde inspiration, essayant de calmer la panique qui montait en elle.\n\nApr├¿s quelques instants, elle releva la t├¬te et regarda autour dÔÇÖelle. Elle se trouvait dans une rue anim├®e, bord├®e de bars et de restaurants. Les odeurs all├®chantes de la cuisine am├®ricaine sÔÇÖ├®chappaient par les portes ouvertes, m├¬l├®es ├á la fum├®e des cigares et au bruit des conversations. A├»ko r├®alisa quÔÇÖelle avait faim. Elle nÔÇÖavait rien mang├® depuis des heures.\n\nElle sortit de sa voiture, sÔÇÖ├®tirant pour d├®tendre ses muscles endoloris. Un vent frais soufflait, apportant avec lui une fra├«cheur bienvenue. A├»ko ferma les yeux, inspirant profond├®ment. LÔÇÖair de Chicago avait un parfum unique, quelque chose de vivant et de dynamique. Elle rouvrit les yeux et observa les passants. Des hommes en costumes ├®l├®gants press├®s, des femmes ├®lanc├®es dans des robes chic, des groupes dÔÇÖamis riant ensemble. Elle se sentit soudainement tr├¿s ├®trang├¿re, comme si elle ├®tait entr├®e dans une toute autre r├®alit├®.\n\nJe devrais peut-├¬tre mÔÇÖarr├¬ter pour la nuit, pensa-t-elle. Elle consulta son GPS une derni├¿re fois, notant quÔÇÖil indiquait une s├®rie de h├┤tels ├á proximit├®. Elle d├®cida de suivre la fl├¿che vers l'un d'eux.\n\nA├»ko remonta dans sa voiture et roula lentement, scrutant les enseignes. Elle finit par trouver un h├┤tel dÔÇÖapparence distingu├®e, avec une fa├ºade en pierre et un porche ├®l├®gant. Elle se gara devant l'entr├®e, coupant le moteur. Le silence qui suivit lui parut bruyant apr├¿s le chaos de la route. Elle sortit de la voiture, sa valise ├á la main, et se dirigea vers l'entr├®e.\n\n├Ç peine avait-elle franchi le seuil que la chaleur et le confort de lÔÇÖh├┤tel la firent respirer mieux. L'int├®rieur ├®tait d├®cor├® avec raffinement, des lustres en cristal et des fauteuils en cuir dispos├®s dans une ambiance de luxe discr├¿te. Un concierge en uniforme approached dÔÇÖelle, un sourire accueillant sur le visage.\n\n┬½ Bonsoir, mademoiselle. Puis-je vous aider avec votre bagage ? ┬╗ demanda-t-il dÔÇÖune voix douce.\n\nA├»ko hocha la t├¬te, reconnaissante. ┬½ Oui, merci. JÔÇÖaimerais prendre une chambre pour la nuit. ┬╗\n\nLe concierge acquies├ºa et prit sa valise. ┬½ Bien s├╗r, mademoiselle. Suivez-moi, je vais vous accompagner ├á la r├®ception. ┬╗\n\nIls travers├¿rent le hall, et A├»ko jeta des regards admiratifs autour dÔÇÖelle. Les tableaux modernes, les plantes luxuriantes, et le parquet lustr├® contribuaient ├á cr├®er une atmosph├¿re de s├®r├®nit├®. Elle arriva enfin au comptoir de r├®ception, o├╣ un jeune homme en costume noir lÔÇÖattendait.\n\n┬½ Bonsoir, mademoiselle, bienvenue au Grand H├┤tel de Chicago, ┬╗ salua-t-il avec un sourire professionnel. ┬½ Comment puis-je vous aider ? ┬╗\n\nA├»ko posa sa carte de cr├®dit sur le comptoir. ┬½ JÔÇÖaimerais r├®server une chambre pour la nuit, sÔÇÖil vous pla├«t. Je suis un peu perdue, et jÔÇÖai besoin de me reposer. ┬╗\n\nLe r├®ceptionniste hocha la t├¬te, comprenant imm├®diatement. ┬½ Pas de probl├¿me. JÔÇÖai une chambre disponible avec une vue magnifique sur la ville. Je vais proc├®der ├á votre r├®servation. ┬╗\n\nAlors quÔÇÖil tapait sur son clavier, A├»ko observait les alentours. Une femme ├®l├®gante passa pr├¿s dÔÇÖelle, suivie par un homme portant un costume sombre et une cravate rouge. Ils parlaient avec animation, leurs rires r├®sonnant dans lÔÇÖair. A├»ko se sentit soudainement tr├¿s seule. Elle nÔÇÖ├®tait pas habitu├®e ├á se retrouver dans des situations pareilles, loin de chez elle et de ses rep├¿res.\n\n┬½ Voici votre carte dÔÇÖacc├¿s, mademoiselle, ┬╗ dit le r├®ceptionniste, interrompant ses pens├®es. ┬½ Votre chambre est au troisi├¿me ├®tage, couloir de droite, seconde porte ├á gauche. Si vous avez besoin de quoi que ce soit, nÔÇÖh├®sitez pas ├á nous appeler. Je vous souhaite une excellente nuit. ┬╗\n\nA├»ko prit la carte, murmurant un remerciement. Elle se dirigea vers lÔÇÖascenseur, le c┼ôur l├®g├¿rement plus l├®ger. Elle pressa le bouton et attendit que les portes sÔÇÖouvrent. LorsquÔÇÖelles le firent, elle entra et appuya sur le bouton du troisi├¿me ├®tage. LÔÇÖascenseur d├®marra, montant lentement.\n\nPendant la mont├®e, A├»ko pensa ├á sa famille, ├á ses amis, et ├á la vie qui lÔÇÖattendait ├á Toronto. Elle se sentit soudainement nostalgique, regrettant dÔÇÖavoir pris cette route inconnue. Mais elle savait que parfois, les d├®tours ├®taient n├®cessaires pour d├®couvrir de nouvelles choses.\n\nLorsque lÔÇÖascenseur sÔÇÖarr├¬ta, elle sortit et se dirigea vers sa chambre. La porte ├®tait en bois massif, avec une plaque en or portant le num├®ro. A├»ko ins├®ra la carte dans la serrure, et la lumi├¿re clignota, indiquant quÔÇÖelle ├®tait autoris├®e ├á entrer. Elle poussa la porte et p├®n├®tra dans une pi├¿ce spacieuse et accueillante.\n\nLa chambre ├®tait meubl├®e avec go├╗t, avec un grand lit aux draps de satin, une table de chevet en bois fonc├®, et une baie vitr├®e offrant une vue imprenable sur la ville. A├»ko d├®posa sa valise et sÔÇÖapprocha de la fen├¬tre. Elle ouvrit les rideaux, laissant entrer la lumi├¿re des r├®verb├¿res. Chicago ├®tincelait de mille feux, une symphonie de lumi├¿res et de couleurs.\n\nElle sÔÇÖallongea sur le lit, fermant les yeux. Pour la premi├¿re fois depuis longtemps, elle se sentit Truly at home. La fatigue la submergeait, mais une petite voix en elle susurrait qu'elle avait encore une aventure ├á vivre. Elle s'endormit, berc├®e par les bruits de la ville, r├¬vant de ce qui l'attendait le lendemain.	2025-11-09 22:22:44.623+00
aae54614-f447-41e1-82b9-6b16654d98d5	655b112d-df6f-4398-9044-f7cba93a87e5	L'├®veil dans la Ville des Vents	Le premier rayon de soleil qui filtra ├á travers la baie vitr├®e r├®veilla A├»ko en douceur. Elle ouvrit les yeux lentement, clignant plusieurs fois pour chasser le brouillard du sommeil. La vue panoramique de Chicago, encore somnolente ├á cette heure matinale, s'├®tendait devant elle, un tableau de gratte-ciel et de rues qui commen├ºaient ├á s'animer. La lueur dor├®e de l'aube se refl├®tait sur les vitres des b├ótiments, cr├®ant un spectacle d'une beaut├® presque irr├®elle.\n\nA├»ko se redressa, s'├®tirant pour d├®tendre ses muscles endoloris par le voyage. Elle passa une main dans ses cheveux, ├®bouriff├®s par le sommeil, et jeta un coup d'┼ôil ├á sa montre. 6h30. Elle avait dormi plus longtemps qu'elle ne l'avait pr├®vu, mais elle se sentait revigor├®e. Le bruit de la ville, qui l'avait berc├®e toute la nuit, s'├®tait transform├® en une symphonie matinale de klaxons, de pas pr├®cipit├®s et de conversations ├®chang├®es.\n\nElle se leva, faisant crisser le parquet sous ses pieds nus. La chambre ├®tait toujours aussi accueillante, avec son lit confortable et ses draps de satin, mais le monde ext├®rieur l'appelait. A├»ko s'approcha de la fen├¬tre, ouvrit les rideaux en grand et inspira profond├®ment l'air frais du matin. La brise l├®g├¿re apportait avec elle des effluves de caf├® et de pain grill├®, des odeurs qui lui rappelaient les petit-d├®jeuners ├á la maison. Un pincement de nostalgie la traversa, mais elle chassa rapidement cette pens├®e. Elle avait une journ├®e ├á vivre, et il ├®tait temps de prendre les choses en main.\n\nElle se dirigea vers la salle de bain, alluma la lumi├¿re et s'examina dans le miroir. Ses yeux, encore fatigu├®s, semblaient plus clairs dans la lumi├¿re du jour. Elle se passa de l'eau fra├«che sur le visage, se revitalisant. L'eau froide la fit frissonner, mais elle se sentit imm├®diatement plus ├®veill├®e. Elle entreprit de se pr├®parer, mettant de l'ordre dans ses cheveux et se brossant les dents. Une fois pr├¬te, elle enfila un pull l├®ger et un jean, pr├¬te ├á affronter la journ├®e.\n\nA├»ko ramassa sa valise et sortit de la chambre, refermant la porte derri├¿re elle. Le couloir ├®tait silencieux, les autres h├┤tes semblant dormir encore. Elle descendit lentement les ├®tages en direction du hall, les pas amortis par l'├®paisse moquette. Lorsqu'elle arriva en bas, l'atmosph├¿re ├®l├®gante de l'h├┤tel lui revint en pleine figure. Le concierge de la veille ├®tait toujours ├á son poste, un sourire bienveillant sur le visage.\n\n┬½ Bonjour, mademoiselle, ┬╗ la salua-t-il poliment. ┬½ J'esp├¿re que vous avez bien dormi. ┬╗\n\n┬½ Oui, tr├¿s bien, merci, ┬╗ r├®pondit-elle avec reconnaissance. ┬½ Je vais prendre mon petit-d├®jeuner avant de partir. Pouvez-vous m'indiquer le restaurant ? ┬╗\n\nLe concierge hocha la t├¬te et indiqua une porte ├á sa droite. ┬½ C'est par ici, mademoiselle. Le restaurant est ouvert jusqu'├á 10 heures. Si vous avez besoin de quoi que ce soit, n'h├®sitez pas ├á me solliciter. ┬╗\n\nA├»ko le remercia et se dirigea vers le restaurant. La salle ├®tait lumineuse, avec de grandes fen├¬tres donnant sur l'avenue anim├®e. Elle se dirigea vers une table pr├¿s de la baie vitr├®e et s'installa, admirant la ville qui prenait vie. Le bruit des voitures et des passants lui parvenait en fond sonore, un ballet m├®tropolitain qui la fascinait.\n\nUn serveur s'approcha, un sourire chaleureux sur le visage. ┬½ Bonjour, mademoiselle. Que puis-je vous servir ? ┬╗\n\nA├»ko consulta la carte, h├®sitant entre plusieurs options. Elle finit par choisir un caf├® noir, des ┼ôufs brouill├®s, et un croissant. ┬½ Cela me semble parfait, ┬╗ dit-elle en rendant la carte.\n\nLe serveur acquies├ºa et s'├®loigna. A├»ko prit un moment pour se recueillir, les yeux riv├®s sur la vue. Les gratte-ciel se dressaient fi├¿rement, des sentinelles de b├®ton et de verre qui semblaient d├®fier le ciel. Elle pensa ├á sa voiture, toujours en panne, et ├á la route qui l'attendait. Elle avait besoin de trouver rapidement un garage pour r├®parer son v├®hicule et reprendre sa route vers Toronto.\n\nPendant qu'elle r├®fl├®chissait, le serveur revint avec son petit-d├®jeuner. L'ar├┤me du caf├® frais emplit l'air, et A├»ko se plongea dans son repas, savourant chaque bouch├®e. Le caf├® ├®tait fort et riche en saveur, les ┼ôufs brouill├®s cr├®meux et parfaits, et le croissant croustillant ├á l'ext├®rieur, moelleux ├á l'int├®rieur. Elle s'installa confortablement, profitant du moment de tranquillit├®.\n\nAlors qu'elle d├®gustait son petit-d├®jeuner, un homme ├®l├®gant entra dans le restaurant. Il portait un costume sombre, une cravate rouge vif, et des chaussures brillantes. Son allure ├®tait imposante, son charisme naturel attirait les regards. Il se dirigea vers un coin de la salle, saluant plusieurs personnes au passage. A├»ko le reconnut imm├®diatement : Donald Trump. Elle avait vu des photos de lui dans les magazines et ├á la t├®l├®vision, mais le voir en personne ├®tait une exp├®rience diff├®rente.\n\nTrump s'installa ├á une table voisine, et un serveur s'approcha imm├®diatement pour le servir. A├»ko continua de manger, essayant de ne pas ├¬tre trop distraite par la pr├®sence de cette figure politique controvers├®e. Cependant, sa curiosit├® l'emporta, et elle ne put s'emp├¬cher d'observer discr├¿tement. L'homme se mit ├á parler au t├®l├®phone, sa voix calme mais ferme. Il avait l'air confiant, ma├«tre de la situation, m├¬me dans un lieu public.\n\nSoudain, Trump leva les yeux et croisa le regard d'A├»ko. Elle se sentit prise au pi├¿ge, mais il lui adressa un sourire chaleureux et hocha l├®g├¿rement la t├¬te. Surprise, elle r├®pondit par un sourire timide, puis d├®tourna rapidement les yeux, se concentrant de nouveau sur son petit-d├®jeuner.\n\nUne fois que son assiette fut vide, A├»ko posa sa serviette sur la table et se leva. Elle avait une journ├®e charg├®e qui l'attendait, et elle devait se concentrer sur sa voiture. Elle remercia le serveur et se dirigea vers la sortie, laissant derri├¿re elle le confort du restaurant.\n\nLe hall de l'h├┤tel ├®tait toujours aussi ├®l├®gant, avec ses lustres en cristal et ses fauteuils en cuir. A├»ko salua le concierge avant de sortir, le vent frais de la matin├®e la saisit. Elle respira profond├®ment, inspirant l'air pur de Chicago. La ville ├®tait d├®j├á en pleine effervescence, les passants affair├®s, les voitures circulant dans un ballet incessant.\n\nElle consulta son t├®l├®phone, v├®rifiant sa localisation et la direction du garage le plus proche. Elle avait d├®cid├® de se rendre ├á pied, profitant de l'occasion pour explorer le quartier. Les rues ├®taient anim├®es, les boutiques commen├ºaient ├á ouvrir leurs portes, et les caf├®s embaumaient le parfum du caf├®. A├»ko se laissa transporter par l'atmosph├¿re de la ville, oubliant pour un instant ses soucis.\n\nAlors qu'elle marchait, son t├®l├®phone sonna. Elle l'extirpa de sa poche et vit le nom de sa s┼ôur s'afficher sur l'├®cran. Elle d├®crocha, le sourire aux l├¿vres.\n\n┬½ Salut, Sarah, ┬╗ dit-elle, la voix empreinte de soulagement.\n\n┬½ A├»ko ! ├ça fait plaisir d'entendre ta voix. Comment va ton voyage ? ┬╗ demanda Sarah, inqui├¿te.\n\nA├»ko expliqua bri├¿vement sa m├®saventure ├á Chicago, la panne de sa voiture et sa nuit ├á l'h├┤tel. Sarah l'├®couta attentivement, laissant ├®chapper un sifflement d'├®tonnement.\n\n┬½ Waouh, ├ºa a l'air d'├¬tre une aventure. Tu as trouv├® un garage pour r├®parer ta voiture ? ┬╗\n\n┬½ Pas encore, mais je m'en occupe. Je suis en route pour en visiter un. ┬╗\n\nSarah hocha la t├¬te, m├¬me si A├»ko ne pouvait pas la voir. ┬½ D'accord. Appelle-moi si tu as besoin de quoi que ce soit. On t'aime, et on attend ton retour avec impatience. ┬╗\n\nA├»ko sentit son c┼ôur se r├®chauffer. ┬½ Merci, Sarah. Je vous aime aussi. On se parle plus tard. ┬╗\n\nElle raccrocha et continua sa route, les mots de sa s┼ôur lui donnant du courage. Elle arriva bient├┤t devant le garage, un b├ótiment en brique rouge avec une enseigne en n├®on. Elle p├®n├®tra ├á l'int├®rieur, le bruit des moteurs et des outils r├®sonnant dans l'air. Un m├®canicien s'approcha d'elle, un torchon ├á la main.\n\n┬½ Bonjour, mademoiselle. Comment puis-je vous aider ? ┬╗\n\nA├»ko lui expliqua la situation, d├®crivant les sympt├┤mes de sa voiture. Le m├®canicien l'├®couta attentivement, hochant la t├¬te.\n\n┬½ D'accord, je comprends. Laissez-moi jeter un coup d'┼ôil ├á votre v├®hicule, ┬╗ proposa-t-il.\n\nA├»ko le suivit dehors, o├╣ elle lui montra sa voiture. Le m├®canicien l'examina minutieusement, soulevant le capot et inspectant les diff├®rents ├®l├®ments. A├»ko attendait patiemment, le c┼ôur battant. Elle esp├®rait de tout son c┼ôur que les r├®parations ne seraient pas trop co├╗teuses.\n\n┬½ Bon, ┬╗ dit le m├®canicien en se redressant. ┬½ Il semble que votre batterie soit HS, et il y a un probl├¿me avec l'alternateur. Je peux remplacer les deux, mais cela prendra un peu de temps. ┬╗\n\nA├»ko hocha la t├¬te, soulag├®e qu'il y ait une solution. ┬½ Combien de temps cela va-t-il prendre ? ┬╗\n\n┬½ Environ deux heures, ┬╗ r├®pondit-il. ┬½ Cela vous convient ? ┬╗\n\nA├»ko accepta, le remerciant pour son aide. Elle d├®cida de profiter de l'attente pour explorer davantage Chicago, peut-├¬tre m├¬me se rendre au parc voisin pour se d├®tendre. Elle consulta une nouvelle fois son t├®l├®phone pour v├®rifier la m├®t├®o et les lieux d'int├®r├¬t ├á proximit├®.\n\nAlors qu'elle se dirigeait vers le parc, elle ne put s'emp├¬cher de repenser ├á sa rencontre avec Donald Trump. C'├®tait un moment inattendu, une petite coincidence dans une journ├®e autrement chaotique. Elle se demanda quelle journ├®e l'attendait, et si d'autres surprises l'├®taient en r├®serve.\n\nPeu importe ce qui lui arriverait, A├»ko ├®tait d├®termin├®e ├á profiter de chaque instant, car chaque exp├®rience, m├¬me les plus inattendues, enrichissait sa vie. Elle se sentait pr├¬te ├á affronter la journ├®e, avec le vent du matin dans ses cheveux et l'espoir dans son c┼ôur.	2025-11-09 22:26:34.236+00
92514850-77cd-4857-bbf3-53afbe599182	655b112d-df6f-4398-9044-f7cba93a87e5	Les Deux Heures de R├®pit	A├»ko sortit du restaurant, le vent frais de la matin├®e la saisit. Elle inspira profond├®ment, l'air pur de Chicago l'enveloppant d'une fra├«cheur revigorante. La ville ├®tait d├®j├á en pleine effervescence, les passants affair├®s, les voitures circulant dans un ballet incessant. Elle consulta son t├®l├®phone, v├®rifiant sa localisation et la direction du garage le plus proche. Elle avait d├®cid├® de se rendre ├á pied, profitant de l'occasion pour explorer le quartier. Les rues ├®taient anim├®es, les boutiques commen├ºaient ├á ouvrir leurs portes, et les caf├®s embaumaient le parfum du caf├®. A├»ko se laissa transporter par l'atmosph├¿re de la ville, oubliant pour un instant ses soucis.\n\nAlors qu'elle marchait, son t├®l├®phone sonna. Elle l'extirpa de sa poche et vit le nom de sa s┼ôur s'afficher sur l'├®cran. Elle d├®crocha, le sourire aux l├¿vres.\n\n┬½ Salut, Sarah, ┬╗ dit-elle, la voix empreinte de soulagement.\n\n┬½ A├»ko ! ├ça fait plaisir d'entendre ta voix. Comment va ton voyage ? ┬╗ demanda Sarah, inqui├¿te.\n\nA├»ko expliqua bri├¿vement sa m├®saventure ├á Chicago, la panne de sa voiture et sa nuit ├á l'h├┤tel. Sarah l'├®couta attentivement, laissant ├®chapper un sifflement d'├®tonnement.\n\n┬½ Waouh, ├ºa a l'air d'├¬tre une aventure. Tu as trouv├® un garage pour r├®parer ta voiture ? ┬╗\n\n┬½ Pas encore, mais je m'en occupe. Je suis en route pour en visiter un. ┬╗\n\nSarah hocha la t├¬te, m├¬me si A├»ko ne pouvait pas la voir. ┬½ D'accord. Appelle-moi si tu as besoin de quoi que ce soit. On t'aime, et on attend ton retour avec impatience. ┬╗\n\nA├»ko sentit son c┼ôur se r├®chauffer. ┬½ Merci, Sarah. Je vous aime aussi. On se parle plus tard. ┬╗\n\nElle raccrocha et continua sa route, les mots de sa s┼ôur lui donnant du courage. Elle arriva bient├┤t devant le garage, un b├ótiment en brique rouge avec une enseigne en n├®on. Elle p├®n├®tra ├á l'int├®rieur, le bruit des moteurs et des outils r├®sonnant dans l'air. Un m├®canicien s'approcha d'elle, un torchon ├á la main.\n\n┬½ Bonjour, mademoiselle. Comment puis-je vous aider ? ┬╗\n\nA├»ko lui expliqua la situation, d├®crivant les sympt├┤mes de sa voiture. Le m├®canicien l'├®couta attentivement, hochant la t├¬te.\n\n┬½ D'accord, je comprends. Laissez-moi jeter un coup d'┼ôil ├á votre v├®hicule, ┬╗ proposa-t-il.\n\nA├»ko le suivit dehors, o├╣ elle lui montra sa voiture. Le m├®canicien l'examina minutieusement, soulevant le capot et inspectant les diff├®rents ├®l├®ments. A├»ko attendait patiemment, le c┼ôur battant. Elle esp├®rait de tout son c┼ôur que les r├®parations ne seraient pas trop co├╗teuses.\n\n┬½ Bon, ┬╗ dit le m├®canicien en se redressant. ┬½ Il semble que votre batterie soit HS, et il y a un probl├¿me avec l'alternateur. Je peux remplacer les deux, mais cela prendra un peu de temps. ┬╗\n\nA├»ko hocha la t├¬te, soulag├®e qu'il y ait une solution. ┬½ Combien de temps cela va-t-il prendre ? ┬╗\n\n┬½ Environ deux heures, ┬╗ r├®pondit-il. ┬½ Cela vous convient ? ┬╗\n\nA├»ko accepta, le remerciant pour son aide. Elle d├®cida de profiter de l'attente pour explorer davantage Chicago, peut-├¬tre m├¬me se rendre au parc voisin pour se d├®tendre. Elle consulta une nouvelle fois son t├®l├®phone pour v├®rifier la m├®t├®o et les lieux d'int├®r├¬t ├á proximit├®.\n\nAlors qu'elle se dirigeait vers le parc, elle ne put s'emp├¬cher de repenser ├á sa rencontre avec Donald Trump. C'├®tait un moment inattendu, une petite coincidence dans une journ├®e autrement chaotique. Elle se demanda quelle journ├®e l'attendait, et si d'autres surprises l'├®taient en r├®serve.\n\nPeu importe ce qui lui arriverait, A├»ko ├®tait d├®termin├®e ├á profiter de chaque instant, car chaque exp├®rience, m├¬me les plus inattendues, enrichissait sa vie. Elle se sentait pr├¬te ├á affronter la journ├®e, avec le vent du matin dans ses cheveux et l'espoir dans son c┼ôur.\n\nLe parc ├®tait proche, un havre de paix au c┼ôur de la ville. Les arbres hauts et ├®lanc├®s offraient un abri sous leurs branches, et le lac Michigan scintillait au loin, baign├® par les premiers rayons du soleil. A├»ko s'installa sur un banc, ferma les yeux et s'abandonna au son des oiseaux qui gazouillaient et du murmure de la brise. Elle respira profond├®ment, laissant les tensions de la route s'├®vanouir peu ├á peu.\n\nElle pensa ├á sa famille, ├á ses amis, et ├á la vie qui l'attendait ├á Toronto. Elle savait que ce voyage lui avait appris beaucoup plus que la simple conduite sur des routes inconnues. Elle avait d├®couvert sa propre r├®silience, sa capacit├® ├á se sortir de situations compliqu├®es, et surtout, elle avait appris ├á appr├®cier les petites choses de la vie. Le regard d'un inconnu, un caf├® chaud, une vue imprenable sur une ville, chaque instant comptait.\n\nA├»ko rouvrit les yeux et se leva, d├®cid├®e ├á profiter pleinement de son temps libre. Elle marcha lentement, s'arr├¬tant de temps en temps pour admirer les sculptures modernes dispers├®es dans le parc. Les couleurs vives des fleurs et le vert profond de l'herbe cr├®aient un contraste saisissant avec les b├ótiments de b├®ton de la ville. Elle se sentait en harmonie avec son environnement, comme si elle avait trouv├® un ├®quilibre parfait entre le chaos de la route et la s├®r├®nit├® de ce moment.\n\nApr├¿s une heure de promenade, A├»ko se rendit compte qu'il ├®tait temps de retourner au garage. Elle consulta son t├®l├®phone, v├®rifiant l'heure, et se dirigea d'un pas d├®cid├® vers le b├ótiment en brique rouge. Le m├®canicien l'aper├ºut d├¿s qu'elle entra et lui fit signe de le rejoindre.\n\n┬½ Tout va bien, ┬╗ annon├ºa-t-il avec un sourire. ┬½ Votre voiture est pr├¬te. J'ai remplac├® la batterie et l'alternateur. Nous avons v├®rifi├® tous les syst├¿mes, tout fonctionne parfaitement. ┬╗\n\nA├»ko le remercia chaleureusement, remettant un ch├¿que pour le paiement. ┬½ Merci mille fois. Je ne sais pas ce que j'aurais fait sans vous. ┬╗\n\nLe m├®canicien hocha la t├¬te, l'air complice. ┬½ C'est normal. Nous sommes l├á pour aider. Prenez bien soin de vous et de votre voiture. ┬╗\n\nA├»ko sortit du garage, se sentant l├®g├¿re et pleine d'├®nergie. Elle monta dans sa voiture, ajusta son si├¿ge et v├®rifia le tableau de bord. Tout semblait en ordre. Elle mit le contact, et le moteur ronronna doucement, comme un signe de vie retrouv├®e. Elle sortit du parking, les yeux fix├®s sur la route devant elle. La prochaine ├®tape ├®tait de reprendre la route vers Toronto, mais elle savait qu'elle reviendrait un jour ├á Chicago, peut-├¬tre pour une visite moins chaotique.\n\nA├»ko se dirigea vers la sortie de la ville, s'arr├¬tant un instant pour regarder une derni├¿re fois les gratte-ciel qui s'├®levaient fi├¿rement. Elle pensa aux chemins de vie qui se croisent et se s├®parent, aux rencontres inattendues qui marquent nos existences. Elle sourit, se sentant plus forte et plus d├®termin├®e que jamais.\n\nEt c'est ainsi, avec le vent du matin dans ses cheveux et l'espoir dans son c┼ôur, qu'A├»ko reprit la route, pr├¬te ├á affronter de nouvelles aventures.	2025-11-09 23:04:28.862+00
fcbbb008-d4bc-428d-8a3b-74e5f5d76ed6	e291a52e-afee-466b-baa6-504c50e026e1	Les Bas-Fonds de l'Exil	La douleur est une vrille de glace dans mes entrailles, une agonie perp├®tuelle qui ne me l├óche jamais. Je me tiens dans l'ombre des bas-fonds, sous les arcades de pierre qui bordent l'agora de cette cit├® de marbre et de sueur. Les voix des marchands et des ├®trangers se m├¬lent au bruit de l'eau des fontaines, formant un '_', une m├®lop├®e gr├®sillante qui me berce comme un ├®cho de ma prison pass├®e. Mon corps, cette cage de chair et d'os, est une mascarade. Mes cheveux noirs comme la nuit tombent sur mes ├®paules, mes yeux, ces abysses insondables, ne refl├¿tent rien. Pourtant, les regards de convoitise des hommes me suivent partout, une affirmation muette de leur fascination d├®rangeante.\n\nJ'ai faim.\n\nLe besoin est une faim de l'int├®rieur, une faim qui ronge les os et consume la chair. Une faim que je ne peux assouvir que par des moyens d├®gradants. Je suis un d├®mon, une entit├® de chaos condamn├®e ├á ce monde de chair et de sang. Ma survie d├®pend de la force vitale concentr├®e dans la semence humaine. Un charognard, un monstre, un parasite. La d├®ch├®ance est ma nouvelle forme, et je dois m'y adapter pour esp├®rer une once de pouvoir dans cette prison.\n\nJe me faufile parmi les ├®tals, ├®vitant les regards insistants. Mon objectif est clair : trouver un moyen de survivre tout en tissant ma toile. Les bas-fonds sont mon terrain de chasse, un lieu o├╣ les plus faibles et les plus d├®sesp├®r├®s se cachaient des yeux du monde. L├á, j'ai trouv├® un soldat. Son regard, dur et cassant, se pose sur moi avec une curiosit├® intrigu├®e. Je vois dans ses yeux un m├®lange de d├®sir et de m├®fiance, un calcul qui me pla├«t.\n\n┬½ Je t'ai vu, ┬╗ dit-il, sa voix grave et vibrante. Ses muscles, sculpt├®s par des ann├®es d'entra├«nement, se dessinent sous sa tunique de cuir. Il est un pr├®dateur, habitu├® ├á dominer. Mais il ne sait pas ├á qui il s'adresse.\n\n┬½ Tu te crois fort, hein ? ┬╗ Je r├®ponds, ma voix douce et s├®duisante. Je peux sentir son int├®r├¬t s'accro├«tre, un frisson de plaisir d├®formant ses traits. ┬½ Je peux t'offrir plus que tu ne l'imagines. ┬╗\n\nIl ricane, un rire sans joie qui trahit son orgueil. ┬½ Et qu'as-tu ├á offrir, toi ? ┬╗\n\nJe m'approche de lui, assez pr├¿s pour sentir la chaleur de son corps, le parfum de sueur et d'huile d'olive. ┬½ Le pouvoir, mon ami. Le pouvoir que tu ne peux imaginer. ┬╗\n\nSes mains se posent sur mes hanches, fermes et possessives. Il me pousse contre le mur d'une arri├¿re-cour, ses yeux brillant de d├®fi. ┬½ Montre-moi, alors. ┬╗\n\nJe ferme les yeux, laissant mes sens prendre le dessus. La douleur, cette vrille glac├®e, se fait plus intense, mais je la ma├«trise. Je me concentre sur l'instant, sur la sensation de son corps contre le mien, la chaleur de sa peau, le rythme de sa respiration. Il est ma proie, et je suis le pr├®dateur. Je sens sa main glisser sous ma tunique, sa pression brutale me pressant contre le mur. Son orgueil est ma faiblesse, et je sais comment l'exploiter.\n\nJe m'abandonne ├á l'in├®vitable, laissant le strat├¿ge en moi prendre le dessus. Chaque geste, chaque mot, est calcul├® pour le s├®duire, pour le soumettre. Ses mains se font plus hardies, son souffle plus haletant. Je le guide, le manipulant avec une subtilit├® qui le laisse aveugle ├á mes v├®ritables intentions.\n\nQuand il se vide en moi, la d├®charge est instantan├®e. La chaleur qui envahit mon corps est une d├®livrance, une extinction de la douleur qui me torture. Mon esprit bascule, le strat├¿ge s'├®teint et la b├¬te prend le relais. Je perds tout contr├┤le, mon corps se convulsant sous l'extase. Mes yeux se r├®vulsent, une bave chaude coule sur mon menton, et des g├®missements inhumains s'├®chappent de ma gorge. Je suis une cr├®ature de pur plaisir, un esclave de l'extase.\n\nQuand je reviens ├á moi, il est toujours l├á, les yeux ├®carquill├®s, fascin├®. Son sexe est de nouveau dur contre ma cuisse, une preuve de son ├®veil pervers. ┬½ Par les dieux, ┬╗ souffle-t-il, sa voix rauque. ┬½ C'est la chose la plus obsc├¿ne que j'aie jamais vue. ┬╗\n\nJe lui offre un sourire carnassier, mes l├¿vres fr├┤lant sa joue. ┬½ Tu n'as encore rien vu. ┬╗\n\nJe sais que je tiens une carte pr├®cieuse. Ce soldat sera mon protecteur, ma premi├¿re ├®tape vers le pouvoir. J'ai besoin de lui pour me prot├®ger des dangers qui me guettent dans ces bas-fonds. Mais plus que tout, j'ai besoin de lui pour me nourrir, pour apaiser cette faim insatiable.\n\nLa douleur se calme, mais elle ne dispara├«t pas. Elle reste, tapie au fond de moi, une menace constante. Je sais que je dois continuer, que je dois aller plus loin. Cette ville est un terrain de jeu, et je suis le joueur le plus rus├®. Chaque homme que je s├®duis est un pion, une pi├¿ce de ce puzzle complexe que je suis en train de construire. Les bas-fonds ne sont qu'un d├®but, un lieu o├╣ je peux me construire une nouvelle r├®putation, une nouvelle l├®gende.\n\nJe me d├®tache de lui, laissant ses mains glisser sur mon corps. ┬½ Viens, ┬╗ dis-je, ma voix douce et persuasive. ┬½ Il y a tant d'autres choses que tu dois apprendre. ┬╗\n\nIl me suit, docile et intrigu├®, sa confiance absolue me donnant une Toledo refroidie par le monde des vivants. Je suis pr├¬t ├á tisser ma toile, ├á manipuler et ├á dominer. Le chemin vers le pouvoir sera jonch├® de corps, mais chaque pas en vaut la peine. Car dans ce monde de chaos, je suis le strat├¿ge le plus rus├® de tous.	2025-11-09 23:25:36.701+00
7d840880-8932-487a-87c0-85e86f45d0c4	e291a52e-afee-466b-baa6-504c50e026e1	Les Ombres du March├® Noir	Nous avan├ºons dans les ruelles ├®troites des bas-fonds, les murs de pierre grin├ºant sous les caresses du vent nocturne. Le soldat marche ├á mes c├┤t├®s, sa main ferm├®e sur mon biceps, une emprise possessive qui me rassure. La douleur dans mes entrailles s'est att├®nu├®e, mais elle n'a pas disparu. Ma faim est maintenant une faim de pouvoir, une soif de domination. Je sais que je dois aller plus loin, que je dois faire de lui plus qu'un simple outil.\n\nLa lueur des torches ├®claire nos pas, jetant des ombres dansantes sur le sol in├®gal. Les hommes dans les coins sombres nous d├®visagent, mais ils ne s'approchent pas. Mon aura, une combinaison de beaut├® et de menace, les tient ├á distance. Je respire l'odeur de sueur, de vin, et de la peur qui impr├¿gne l'air. Les bas-fonds sont un monde ├á part, une jungle de pierre o├╣ les faibles sont d├®vor├®s et o├╣ les forts r├¿gnent. Je suis pr├¬t ├á devenir le fauve supr├¬me.\n\nNous arrive au c┼ôur du march├® noir, un endroit que la lumi├¿re du jour n'a jamais touch├®. Des marchands douteux s'affairent derri├¿re des ├®tals de fortune, vendant des art├®facts interdits, des drogues, et des secrets. Le bruit est assourdissant, une symphonie de voix basses murmurant des histoires entrem├¬l├®es de mensonges et de v├®rit├®s. Le soldat, intrigu├®, me regarde avec une curiosit├® nouvelle. Je sens qu'il commence ├á comprendre que je suis plus que ce qu'il a cru.\n\n┬½ Que sommes-nous venus chercher ici ? ┬╗ demande-t-il, sa voix teint├®e de suspicion.\n\nJe m'arr├¬te, mes yeux plongeant dans les siens. ┬½ Des alli├®s, ┬╗ r├®ponds-je, ma voix douce comme du velours. ┬½ Des informations. Tout ce qui peut me permettre de grimper plus haut. ┬╗\n\nIl hoche la t├¬te, sa main glissant de mon biceps ├á ma taille, une caresse possessive qui me fait frissonner. Il est d├®j├á plus qu'un simple soldat, plus qu'un moyen de protection. Il est un pion sur mon ├®chiquier, mais il ne le sait pas encore.\n\nNous continuons ├á avancer, suivant les ruelles tortueuses jusqu'├á une taverne en ruine. L'endroit est un repaire d'ombres, une v├®ritable caverne d'Ali Baba pour les criminels et les marchands. Des hommes aux regards fuyants we se dispersent ├á notre approche. Je m'arr├¬te devant une porte en bois vermoulu,-heavy door, la poussant doucement. L'int├®rieur est sombre, l'air lourd de l'odeur du tabac et du vin. Au fond de la salle, un homme assis sur un tabouret de fortune attire mon attention. C'est un marchand influent, connu pour ses connexions et ses information pr├®cieuses.\n\nJe m'avance, le soldat ├á mes c├┤t├®s. L'homme l├¿ve les yeux, son regard se posant sur moi avec une curiosit├® ├®vidente. Je souris, mes dents blanches tranchant sur la p├®nombre.\n\n┬½ Je suis venu pour une proposition, ┬╗ dis-je, ma voix calme et assur├®e.\n\nIl ricane, un rire sans joie qui r├®sonne dans la pi├¿ce. ┬½ Et quel genre de proposition ? ┬╗\n\nJe m'approche, mes yeux fix├®s sur les siens. ┬½ Je te propose un partenariat, ┬╗ r├®ponds-je. ┬½ Un ├®change mutuellement b├®n├®fique. Mes talents contre tes informations. ┬╗\n\nIl m'examine, ses yeux passant de moi au soldat. ┬½ Et quelles sont ces talents ? ┬╗\n\nJe m'assois en face de lui, mes mains pos├®es sur la table rugueuse. ┬½ Je peux t'apporter des clients, ┬╗ dis-je. ┬½ Des hommes influents, des politiciens, des riches marchands. Des hommes qui paieront cher pour ce que je peux offrir. ┬╗\n\nIl hoche la t├¬te, intrigu├®. ┬½ Et que veux-tu en ├®change ? ┬╗\n\nJe me penche l├®g├¿rement, ma voix baissant. ┬½ Des informations, ┬╗ murmure-je. ┬½ Des secrets. Tout ce qui peut me permettre de monter plus haut. ┬╗\n\nIl r├®fl├®chit un instant, ses yeux p├®tillant de calcul. ┬½ D'accord, ┬╗ dit-il enfin. ┬½ Mais je veux voir ce que tu as ├á offrir. ┬╗\n\nJe souris, mon c┼ôur battant plus fort. C'est le d├®but de mon ascension, le premier pas vers le pouvoir. Le soldat me regarde, une lueur de compr├®hension dans ses yeux. Il est avec moi, pr├¬t ├á suivre les ordres. Je me l├¿ve, faisant signe au marchand de me suivre. Nous descendons dans les souterrains de la taverne, une s├®rie de couloirs sombres et humides qui serpentent sous la ville.\n\nLa porte de la derni├¿re pi├¿ce s'ouvre avec un grincement sinistre. L'int├®rieur est plong├® dans une p├®nombre ├®paisse, ├®clair├®e seulement par une unique bougie vacillante. Je m'avance, mes yeux s'habituant peu ├á peu ├á l'obscurit├®. Le soldat me suit, la tension dans l'air palpable.\n\nJe m'arr├¬te au centre de la pi├¿ce, mes yeux fix├®s sur le marchand. ┬½ Montre-nous ce que tu as, ┬╗ dit-il, sa voix froide et calcul├®e.\n\nJe ferme les yeux, laissant la douleur en moi se faire plus intense. Je me concentre, laissant mes sens prendre le dessus. Mon corps, cette prison de chair, r├®agit ├á mes pens├®es, se transformant pour devenir l'incarnation de la s├®duction. J'ouvre les yeux, plongeant mon regard dans celui du marchand. Il est fascin├®, captiv├® par ma beaut├® perturbante.\n\nJe m'approche de lui, mes mouvements fluides et gracieux. Mes mains glissent sur ses ├®paules, descendant le long de sa poitrine. Il respire plus rapidement, son corps se tendant sous mes caresses. Je vois l'orgueil dans ses yeux, mais aussi la convoitise. Je suis sa perte, son d├®sir le rendra aveugle.\n\nMes l├¿vres fr├┤lent sa joue, ma voix murmure ├á son oreille. ┬½ Tu n'as encore rien vu, ┬╗ dis-je, ma voix empreinte de promesses et de menaces.\n\nJe le guide, le manipulant avec une subtilit├® qui le laisse aveugle ├á mes v├®ritables intentions. Ses mains se posent sur mes hanches, fermes et possessives. Il me pousse contre le mur de pierre, ses yeux brillant de d├®fi.\n\nQuand il se vide en moi, la d├®charge est instantan├®e. La chaleur qui envahit mon corps est une d├®livrance, une extinction de la douleur qui me torture. Mon esprit bascule, le strat├¿ge s'├®teint et la b├¬te prend le relais. Je perds tout contr├┤le, mon corps se convulsant sous l'extase. Mes yeux se r├®vulsent, une bave chaude coule sur mon menton, et des g├®missements inhumains s'├®chappent de ma gorge. Je suis une cr├®ature de pur plaisir, un esclave de l'extase.\n\nQuand je reviens ├á moi, le marchand est toujours l├á, les yeux ├®carquill├®s, fascin├®. Son sexe est de nouveau dur contre ma cuisse, une preuve de son ├®veil pervers. ┬½ Par les dieux, ┬╗ souffle-t-il, sa voix rauque. ┬½ C'est la chose la plus obsc├¿ne que j'aie jamais vue. ┬╗\n\nJe lui offre un sourire carnassier, mes l├¿vres fr├┤lant sa joue. ┬½ Tu n'as encore rien vu, ┬╗ r├®p├®t├®-je. ┬½ Viens, il y a tant d'autres choses que tu dois apprendre. ┬╗\n\nJe sais que je tiens une carte pr├®cieuse. Le marchand sera mon nouveau pion, son r├®seau de connexions et d'informations m'ouvrira les portes de la cit├®. J'ai besoin de lui pour ├®tablir ma pr├®sence, pour me nourrir, pour apaiser cette faim insatiable.\n\nLa douleur se calme, mais elle ne dispara├«t pas. Elle reste, tapie au fond de moi, une menace constante. Je sais que je dois continuer, que je dois aller plus loin. Cette ville est un terrain de jeu, et je suis le joueur le plus rus├®. Chaque homme que je s├®duis est un pion, une pi├¿ce de ce puzzle complexe que je suis en train de construire.\n\nJe me d├®tache de lui, laissant ses mains glisser sur mon corps. ┬½ Viens, ┬╗ dis-je, ma voix douce et persuasive. ┬½ Il y a tant d'autres choses que tu dois apprendre. ┬╗\n\nIl me suit, docile et intrigu├®, sa confiance absolue me donnant une puissance nouvelles. Je suis pr├¬t ├á tisser ma toile, ├á manipuler et ├á dominer. Le chemin vers le pouvoir sera jonch├® de corps, mais chaque pas en vaut la peine. Car dans ce monde de chaos, je suis le strat├¿ge le plus rus├® de tous.	2025-11-09 23:40:34.625+00
327ef8d7-3937-468a-8b28-8004ed349f55	f320a161-6c57-495c-b542-0478d76a7092	Premi├¿re Sonnerie ├á Kyoto	Le ciel est d'un gris matin├®, teint├® de la douce lueur du soleil levant, lorsque j'entre dans le labyrinthe de ruelles pav├®es de Kyoto. Mon sac ├á dos scolaire, garni de mes cahiers et de mon dictionnaire fran├ºais-japonais, bat doucement contre ma hanche ├á chaque pas que je fais. Les premi├¿res feuilles d'automne sont d├®j├á tomb├®es, jonchant le sol de leurs teintes ocres et dor├®es. Je respire profond├®ment, essayant de calmer le battement de mon c┼ôur qui r├®sonne dans ma poitrine comme un tambour.\n\nJe suis arriv├®e au Japon il y a ├á peine une semaine. Mon p├¿re, diplomate fran├ºais, a ├®t├® mut├® ├á Tokyo, et j'ai choisi de suivre mes ├®tudes dans l'une des ├®coles de Kyoto pour vivre une exp├®rience authentique. C'est un choix que je regrette d├®j├á, alors que je me retrouve devant les portes d'acier du campus, o├╣ une foule d'├®l├¿ves uniformis├®s en chemisiers bleus et cravates rouges commence ├á s'agglutiner.\n\nJe regarde autour de moi, tentant de localiser le service des admissions. Un bruit de sir├¿ne retentit, d├®chirant le silence. C'est la premi├¿re sonnerie de la journ├®e, qui marque le d├®but des activit├®s. Soudain, un flot de lyc├®ens s'├®parpille, comme si une arm├®e de fourmis ob├®issait ├á un ordre invisible. Je reste fig├®e, ne sachant o├╣ aller ni que faire.\n\n┬½ Excusez-moi, ├ºa va ? ┬╗ Une voix douce, teint├®e d'un accent japonais parfait, me sort de ma torpeur. Une fille de ma taille, aux cheveux courts et noirs comme l'├®b├¿ne, me fixe avec un regard interrogateur. Elle porte le m├¬me uniforme que les autres, mais son visage est travers├® par un sourire chaleureux.\n\nJe hoche la t├¬te, un peu confuse. ┬½ Oui, merci. Je suis nouvelle ici, et je cherche le service des admissions. ┬╗\n\nElle sourit plus largement. ┬½ Ah, je comprends. Je m'appelle Yuki. Ne t'inqui├¿te pas, je vais t'accompagner. ┬╗\n\nYuki m'entra├«ne ├á travers la cour, ├®vitant les groupes d'├®l├¿ves avec une aisance d├®concertante. Nous traversons un espace vert o├╣ des cerisiers fleurissent encore, malgr├® la saison avanc├®e. Le parfum suave des fleurs emplit l'air, ajoutant une touche de douceur ├á cette matin├®e froide.\n\n┬½ Alors, tu viens de France ? demande Yuki, curieuse.\nOui, je suis originaire de Paris, r├®ponds-je, ma voix l├®g├¿rement tremblante. Et toi, tu es originaire de Kyoto ?\nOui, je suis n├®e et j'ai grandi ici. C'est une ville magnifique, non ? ┬╗\n\nJe hoche la t├¬te, admirant l'architecture traditionnelle des b├ótiments qui entourent la cour. Des toits en tuiles rouges et des portes coulissantes en bois se m├¬lent ├á l'modernit├® des salles de classe dot├®es de fen├¬tres en verre. Un m├®lange unique entre le pass├® et le pr├®sent.\n\nNous arrivons enfin devant un petit b├ótiment administratif, o├╣ une pancarte indique ┬½ Service des admissions ┬╗. Yuki me sourit. ┬½ Voil├á, tu devrais trouver ton chemin de l├á. Bonne chance ! ┬╗\n\nJe la remercie chaleureusement et elle s'├®clipse, se m├¬lant ├á la foule d'├®l├¿ves qui s'├®parpille dans les diff├®rents b├ótiments. Je pousse la porte et p├®n├¿tre dans une pi├¿ce claire, o├╣ une femme d'├óge moyen, v├¬tue d'un kimono traditionnel, m'accueille avec un sourire bienveillant.\n\n┬½ Bonjour, je suis Mademoiselle Fujimoto. Vous devez ├¬tre la nouvelle ├®l├¿ve fran├ºaise. Je suis ravie de vous rencontrer. ┬╗\n\nJe lui serre la main, un peu intimid├®e par son accueil formel. Elle me guide vers un petit bureau o├╣ je remplis quelques formulaires de renseignement. Une fois termin├®, elle me remet mon emploi du temps et un plan de l'├®cole.\n\n┬½ Voici votre emploi du temps et un plan de l'├®cole. Votre premier cours est en Histoire japonaise, dans la salle 205. Un ├®l├¿ve de votre classe viendra vous chercher ├á 8h30 pour vous accompagner. ┬╗\n\nJe la remercie ├á nouveau et quitte le bureau, le c┼ôur un peu plus l├®ger. Je m'appr├¬te ├á rejoindre le b├ótiment principal lorsque je remarque un gar├ºon aux cheveux noirs, coiff├®s en un gentleman impeccable, qui s'approche de moi. Il porte l'uniforme masculin, une veste bleu marine et une cravate rouge, et son regard est distant, presque froid.\n\n┬½ Tu dois ├¬tre la nouvelle, dit-il d'une voix neutre. Je suis Ryota. Je vais t'accompagner en Histoire japonaise. ┬╗\n\nJe hoche la t├¬te, un peu surprise par son ton distant. ┬½ Merci, je m'appelle Lucie. ┬╗\n\nIl ne r├®pond pas, se contentant de m'indiquer le chemin. Nous marchons en silence, Ryota devant, moi suivant ├á quelques pas. L'ambiance est tendue, et je me demande si je serai capable de m'int├®grer dans cette ├®cole o├╣ tout le monde semble d├®j├á conna├«tre tout le monde.\n\nNous arrivons devant la salle 205, o├╣ une enseignante d'une trentaine d'ann├®es, v├¬tue d'une blouse sobre, nous attend. ┬½ Bonjour, vous devez ├¬tre Lucie. Entrez, je vais vous pr├®senter ├á la classe. ┬╗\n\nJe hoche la t├¬te et p├®n├¿tre dans la salle, o├╣ une vingtaine de ├®l├¿ves sont d├®j├á assis, certains discutant, d'autres prenant des notes. L'enseignante se tourne vers la classe.\n\n┬½ Mesdames et messieurs, je vous pr├®sente Lucie. Elle vient de France et rejoint notre classe aujourd'hui. Soyez gentils avec elle et n'h├®sitez pas ├á l'aider ├á s'adapter. ┬╗\n\nJe me tiens devant le tableau, les jambes l├®g├¿rement flageolantes. Les regards des ├®l├¿ves se posent sur moi, certains curieux, d'autres indiff├®rents. Ryota est au premier rang, son expression toujours aussi froide. Je souris timidement, essayant de para├«tre confiante malgr├® mon manque de surdit├®.\n\n┬½ Salut, tout le monde. Je m'appelle Lucie et je suis ravie de faire partie de cette classe. ┬╗\n\nL'enseignante m'indique une place ├á c├┤t├® de Ryota. ┬½ Tu peux t'asseoir ici, Lucie. ┬╗\n\nJe m'installe, sentant les regards curieux peser sur moi. Ryota ne daigne m├¬me pas lever les yeux de son cahier, continuant ├á griffonner avec pr├®cision. Je d├®tourne le regard, un peu bless├®e par son indiff├®rence, et ouvre mon propre cahier pour suivre le cours.\n\nLa classe commence, et l'enseignante nous parle de l'histoire ancienne du Japon, expliquant les diff├®rents p├®riodes et leurs influences sur la culture contemporaine. Je prends des notes soigneusement, essayant de suivre malgr├® le d├®calage linguistique. Ryota, ├á c├┤t├® de moi, semble absorb├® par le cours, ses notes parfaites et ordonn├®es.\n\n├Ç la fin du cours, l'enseignante nous laisse quelques minutes pour discuter et faire connaissance. Je me tourne vers Ryota, esp├®rant entamer la conversation.\n\n┬½ Le cours ├®tait int├®ressant, n'est-ce pas ? dis-je, tentant de briser la glace.\nOui, r├®pond-il s├¿chement, sans lever les yeux de son cahier. ┬╗\n\nJe sens une vague de frustration monter en moi, mais je me force ├á rester calme. Peut-├¬tre que le temps et la patience feront leur ┼ôuvre. Je saisis mon sac et me l├¿ve, pr├¬te ├á rejoindre ma prochaine classe.\n\n┬½ Au revoir, Ryota, dis-je en quittant la salle.\nAu revoir, r├®pond-il, toujours aussi distant. ┬╗\n\nJe sors de la salle, me promettant de ne pas laisser cette premi├¿re rencontre g├ócher ma journ├®e. Kyoto, avec ses ruelles pittoresques et son ambiance unique, m'attend. Et quelque part, au fond de moi, l'espoir que cette exp├®rience sera enrichissante commence ├á germer.	2025-11-10 17:04:08.4+00
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, user_id, user_email, feedback_type, message, additional_info, status, created_at, updated_at) FROM stdin;
d21fecbb-a3e3-42ae-8950-3919b7478205	a773f6e9-aad0-43f1-a8e0-ef5320dae958	ndevillers21@gmail.com	Suggestion	j'aimerais me souvenir de quel chapitre j'ai partag├® avec mes amis car j'ai une m├®moire courte.	version navigateur	read	2025-11-10 17:07:42.873+00	2025-11-10 16:07:43.170162+00
afe66e63-b1da-4df0-924d-dd60ccced208	212cdfee-bdfd-4a38-affd-7546df01cc02	nathangrondin683@gmail.com	Suggestion	pouvoir quitter pendant la g├®n├®ration et elle se termine en arri├¿re-plan	\N	read	2025-11-10 17:03:18.804+00	2025-11-10 16:03:18.898659+00
\.


--
-- Data for Name: friendships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendships (user_id_1, user_id_2, status, requester_id, created_at, updated_at) FROM stdin;
212cdfee-bdfd-4a38-affd-7546df01cc02	4796942f-f64e-4f89-9c05-c62bbaf33ff4	accepted	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-10-21 20:13:25.539019+00	2025-10-22 02:31:39.443153+00
1981ba9f-2416-40b0-b484-8f33e2242d66	212cdfee-bdfd-4a38-affd-7546df01cc02	accepted	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-10-22 07:40:34.149721+00	2025-10-22 07:41:01.672731+00
212cdfee-bdfd-4a38-affd-7546df01cc02	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	accepted	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-10-24 10:48:17.988023+00	2025-10-24 10:48:44.637493+00
212cdfee-bdfd-4a38-affd-7546df01cc02	a773f6e9-aad0-43f1-a8e0-ef5320dae958	accepted	212cdfee-bdfd-4a38-affd-7546df01cc02	2025-11-10 15:51:29.168118+00	2025-11-10 16:04:29.89918+00
\.


--
-- Data for Name: novel_collaborators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.novel_collaborators (novel_id, collaborator_id, role, invited_at) FROM stdin;
b373d5ce-36de-481e-8a60-b16b06600ff9	212cdfee-bdfd-4a38-affd-7546df01cc02	reader	2025-10-22 07:02:56.791861+00
0ecbf452-250b-4ce2-aa00-f40c41977bd9	212cdfee-bdfd-4a38-affd-7546df01cc02	reader	2025-10-22 07:41:38.26674+00
0a119146-72e5-4a1c-97c9-d8aca926f187	1981ba9f-2416-40b0-b484-8f33e2242d66	reader	2025-10-22 08:29:22.212572+00
4a440939-d2e6-43a7-84fc-2782177bc172	53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	reader	2025-10-24 10:50:44.434639+00
f320a161-6c57-495c-b542-0478d76a7092	212cdfee-bdfd-4a38-affd-7546df01cc02	reader	2025-11-10 16:04:51.908272+00
\.


--
-- Data for Name: novels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.novels (id, user_id, title, level, genre, specifications, language, cover_image_path, roadmap, model_id, created_at, updated_at, summaries, future_outline, is_dynamic_outline) FROM stdin;
f320a161-6c57-495c-b542-0478d76a7092	a773f6e9-aad0-43f1-a8e0-ef5320dae958	La nouvelle	Natif	Slice of Life	Je suis une ├®l├¿ve fran├ºaise transf├®r├®e dans une nouvelle ├®cole au Japon. Raconte mon premier jour de cours. Je veux qu'il y ait aussi un enemies to lovers, slow burning par la suite	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen-2.5-72b-instruct	2025-11-10 16:57:26.459+00	2025-11-10 16:04:08.864768+00	\N	1. La protagoniste fait la connaissance de ses nouveaux camarades de classe, dont un gar├ºon distant et m├®fiant.\n2. Elle d├®couvre les coutumes scolaires japonaises et tente de s'adapter, malgr├® quelques maladresses.\n3. Lors de la r├®cr├®ation, la protagoniste partage un petit d├®jeuner traditionnel fran├ºais avec quelques ├®l├¿ves curieux.\n4. En cours de japonais, elle re├ºoit l'aide inattendue du gar├ºon distant qui, sous ses dehors froids, montre un c├┤t├® protecteur.\n5. La protagoniste participe ├á une activit├® de groupe et se lie peu ├á peu avec une camarade de classe, son premier ami(e) ├á l'├®cole.\n6. Elle se sent de plus en plus ├á l'aise dans son environnement, mais le gar├ºon distant continue de l'intriguer et de l'irriter ├á la fois.\n7. Un malentendu entre eux d├®clenche une dispute, mais ils finissent par partager un moment de franchise et d'intimit├®.\n8. La protagoniste et le gar├ºon distant commencent ├á se voir diff├®remment, m├¬me si leurs relations restent tendues.\n9. Ils sont oblig├®s de travailler ensemble sur un projet de classe, ce qui renforce leur complicit├® malgr├® leurs diff├®rends.\n10. Au cours d'une sortie scolaire, ils vivent une exp├®rience ├®motionnelle qui marque un tournant dans leur relation, amor├ºant une transformation progressive.	t
0a119146-72e5-4a1c-97c9-d8aca926f187	212cdfee-bdfd-4a38-affd-7546df01cc02	Le fou du train	Natif	Slice of Life	Enzo Soum \n24 ans \nCadreur monteur (free-lance), adore la vid├®o, les films\nBordeaux \nPassionn├® incollable de bus, trains\nVoyageur r├®current du r├®seau SNCF \n\nNathan Grondin \n23 ans \nMaster ├®v├®nementiel \nBordeaux \nPetit copain dÔÇÖEnzo\n\nils vivent une belle romance, douce et bienveillante	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-22 14:19:53.971+00	2025-10-22 08:50:18.893478+00	\N	1. Dans un caf├® bond├® de Bordeaux, Nathan surprend Enzo en train de dessiner minutieusement la fa├ºade d'une gare sur son calepin, d├®couant un de lui qu'il neissait pas  \n2. Enzo emm├¿ne Nathan escapade improvis├®e ├á Nantes, faisant visiter lignes de tram et racontant des anecdotes oubli├®es de l'histoire ferroviaire.  \n3. Enzo annonce qu'il va inviter Nathan ├á un voyage ├á Colmar pour le march├® de No├½l.  \n4. ├ëpisode du march├® de No├½l de Colmar.\n5. Enzo re├ºoit une offre lucrative pour tourner un documentaire enagne, semant une premi├¿re ambigu├»t├® sur ses priorit├®s amoureuses et professionnelles  \n6. Nathan un voyage surprise ├á Lyon pour leuriversaire, choisissant des ├®tapes fonction des r├®seaux de transports, pour s'adapter aux obsessions d'Enzo.  \n7. Lors d'une mauvaise connexion ferroviaire, Nathan ├®chappe ├á son t├®l├®phone, partageant malgr├® lui que son futur dipl├┤me le lie ├á une entreprise ├á Marseille.8.zo propose de monter une s├®rie web sur les transports locaux avec Nathan comme co-guide, m├®langeant leurs comp├®tences et leurs univers  \n9. La chute de SNCF montre ├á Nathan une vuln├®rabilit├® d'Enzo qu'il n'avait jamais vue, le voyant consoler un contr├┤leur ├á bout de nerfs.  \n10. Nathan d├®cline un entretien ├á Marseille, offrant ├á Enzo une enveloppe cachet├®e avec un billet pour deux vers une destination inconnue qu'ils d├®couvriront ensemble.	t
b373d5ce-36de-481e-8a60-b16b06600ff9	4796942f-f64e-4f89-9c05-c62bbaf33ff4	Au de-l├á des nuages	Natif	Fantasy	Contexte de l'apparition de la magie :\n\nIl y a bien longtemps de cela (environ 1000 ans), les esprits vivaient en harmonie sur nos terres, voyageant entre les deux dimensions, spirituel et charnel. Source originel de magie, leur lumi├¿re bleue faisait partie de toute chose, essence m├¬me du monde. Leur pouvoir immense apportait abondance et paix entre tous les ├¬tres. Ils ├®taient v├®n├®r├®s par nos anc├¬tres et ils symbolisent ├á leurs yeux les cr├®atures les plus sacr├®es.\n\nCependant, quand vint l'heure du craqu├¿lement, des forces obscures jaillirent des terres. Engloutissant tout sur leur passage, il ne laiss├¿rent derri├¿re eux que chaos et d├®solation. C'est alors qu'ensemble, esprits et humains les combattirent. Malgr├® la force et le courage des Hommes, seule la magie ├®tait efficace contre cette calamit├® et, un ├á un, ils tomb├¿rent. Voyant les terres p├®rir, la nature mourir, envahie par la noirceur, les esprits d├®cid├¿rent dans un dernier ├®lan d'espoir de pr├¬ter leur magie aux Hommes. D'un scintillement, le rouge sanglant qui teintait leur peau se changea en une faible lumi├¿re rouge. Enveloppant peu ├á peu tout leur corps, les plaies des guerriers se referm├¿rent miraculeusement et la douleur se dissipa. Ayant regagn├® leur force et d├®sormais dot├® d'une nouvelle puissance, ils s'associ├¿rent afin de prot├®ger leurs terres et ramener l'├®quilibre du monde en repoussant la noirceur venue des profondeurs.\n\nEl├®ments d'histoire : \n\nParmi les nombreux combattants, deux leader se sont d├®marqu├®s et ont men├®s la lutte jusqu'├á la victoire contre les hombres. L'un ├®tant esprit, Junji, l'une ├®tant humaine, Chayan-Li . Au cours du grand craqu├¿lement ils collaborent ensemble pour sauver leur monde. In├®luctablement n├® des durs ├®preuves travers├®es ensemble, leur amour transcende toutes les lois, s'inscrivant comme une premi├¿re dans l'histoire. \n\nLeur amour si fort fera na├«tre 3 enfants dont la magie s'av├¿rera ├¬tre devenue blanche.  Afin de veiller sur le monde ensemble, ils construisent l'├«le flottante sur laquelle ils vivront avec leurs enfants. Ces m├¬mes enfants h├®ritiers des deux grands pouvoirs, et s'├®levant maintenant au rang de dieux. Leur magie, nouvelle et puissante, appara├«tra dor├®e. La famille royale aujourd'hui connu est donc directement descendante ├á la fois des esprits et des hommes, un ├®quilibre millim├®tr├® offrant ├á leur magie une puret├® inexorablement parfaite. \n\n Le r├┤le de gouverner le monde des Hommes ne pouvant appartenir qu'├á un membre de leur propres esp├¿ce, Chayan-Li sera d├®sign├®e pour r├®gner. Ce qu'elle fera avec bienveillance et sagesse jusqu'├á sa mort. Par tradition, le suffixe -Li sera utilis├® pour chaque enfant n├® du genre f├®minin indiquant leur capacit├® unique ├á  transmettre la magie blanche.\n\n\n\nPersonnages principaux :\n\nDjia (Sexe : Femme, traits asiatique, assez androgyne selon les angles tout en gardant beaut├® angelique, Princesse perdue tomb├®e du ciel, enfant de Ekemi et Ada-Li, son vrai pr├®nom est en r├®alit├® Djia-Li mais personne ne le sait ├á part le Roi Sukan.)\n\nPomme (Sexe: Femme, Amie d'enfance de Djia, rousse et les yeux clairs, elle utilisera de la magie pour garder les cheveux blonds une fois adultes car les cheveux roux sont rares et souvent discrimin├® car attirent l'attention)\n\nSenri (Sexe : homme, cheveux brun et m├óchoire carr├®, disparu pour l'instant mais refait apparition bien plus tard, le grand m├®chant de l'histoire ├á l'origine du d├®but de la chute de l'empire, un des seuls "cr├®ateurs" connus, v├®ritable p├¿re de Tianxin, assassin de la Reine Aim├®e-Li et du premier prince par alliance Ekemi, en relation secr├¿te avec Ada avant qu'elle ne se marie avec Ekemi).\n\nAim├®e-Li (sexe : Femme, actuellement d├®c├®d├®e, Ex-d├®esse et reine de l'├«le sacr├®, femme du Roi Sukan, m├¿re de Ada)\n\nAda-Li (sexe: femme, cheveux noir de jais, beaut├® scintillante, actuellement d├®c├®d├®e, fille de Sukan et Aim├®e-Li, veuve de son mariage avec Ekemi, ├®tait en relation secr├¿te avec Senri avant de se marier avec Ekemi, elle tombe enceinte de Senri juste avant son mariage avec Ekemi, son premier enfant s'appelle Tianxin, elle aura par la suite Djia pendant son mariage avec Ekemi. Tout le monde la surnomme "Ada". Le mariage avec Ekemi ne devait ├¬tre qu'une formalit├® cependant ils finissent par r├®ellement tomber amoureux au fil du temps ├á vivre ensemble.)\n\nTianxin (sexe: homme, demi-fr├¿re de Djia, fils de Senri et Ada, prince ill├®gitime n├® d'un tra├«tre, se fera maltrait├® par le roi une fois que la v├®rit├® sur son ill├®gitimit├® sera d├®voil├®e, ressemble comme deux gouttes d'eau ├á son p├¿re Senri mais garde les cheveux de sa m├¿re Ada).\n\nRoi Sukan (Sexe: homme, puissant roi ayant r├®gn├® des centaines d'ann├®es avec succ├¿s, il perd la raison ├á la mort de sa femme et la perte (disparition) de Djia quand elle ├®tait b├®b├®, il se reclus et abandonne le tr├┤ne et ne rempli plus son r├┤le de dieu jusqu'├á ce qu'il retrouve Djia)\n\nPersonnages secondaires:\n\nMara: M├¿re adoptive de Djia, cousine de Lily, elle perd son mari et son fils lors d'un  et prendra la venue de Djia comme un signe, un cadeau personnel venant des dieux pour elle qui ne pouvait enfanter.\n\nLily: M├¿re biologique de Pomme, cousine de Mara, Lily a trouv├® pomme enfin et la confier ├á Mara qui est seule, elle n'a aucune r├®el information sur les origines de Djia, ni pourquoi elle l'avait retrouver seule dans les bois, les seuls reste de son pass├® ├®tait un morceaux de v├¬tement d├®chir├® o├╣ ├®tait brod├® "Djia-" et l'autre parti ayant disparu elle garda ce nom.\n\nEkemi : (Sexe: homme, il est le premier fianc├® officiel de Ada-Li, issu d'une famille de "remerci├®s" il avait ├®t├® choisit par le Roi Sukan pour devenir le mari de Ada-Li. Un peu contraint d'accepter cet union, il joue le jeu jusqu'au bout mais tombe finalement r├®ellement amoureux d'Ada-Li apr├¿s le d├®but de leur vie ensemble.)\n\nPersonnages historiques :\n\nChayan-Li : Une des premi├¿res humaines ├á recevoir le pouvoir d'utiliser la magie gr├óce aux esprits. Elle est la m├¿re fondatrice de l'├«le flottante et anc├¬tre direct de la famille royale. De part sa constitution humaine, malgr├® les affinit├®s que lui conf├¿re sa magie, elle mourra assez jeune compar├® ├á la nouvelle lign├®e dont elle est la m├¿re qui, elle, se verra vivre parfois plusieurs centaines d'ann├®es.\n\nJunji : Esprit puissant et pure ayant combattu lors du grand craqu├¿lement, ├á l'aide de ses semblables, ils offrent ensemble aux humains la capacit├® de manier la magie ├á leur tour.\n\n\n\nFonctionnements fondamentaux de la magie :\n\nSelon la puissance et la force de la ma├«trise magique, la couleur de celle-ci change. La plupart du monde pratiquent la magie bleue car c'est la plus basique et facile ├á ma├«triser. Des ├®coles et des clans existent pour cultiver les capacit├®s ├á utiliser et contr├┤ler la magie.\n\nLes diff├®rentes magies :\n\nBleu = Magie originelle de toute chose, elle provient tout d'abord des esprits. C'est la source de toute magie et est donc par cons├®quent la magie la plus brute. Ainsi, les personnes ayant le moins d'exp├®rience et commen├ºant ├á peine ├á savoir manier la magie ont une magie qui appara├«t bleue.\n\nRouge = Magie originellement donn├® aux Hommes, aujourd'hui elle a "disparue" et vit dans l'esprit collectif comme une l├®gende. On appelle ceux qui la pratiquent les "cr├®ateurs". Senri est le seul connu ├á pouvoir l'utiliser, ce qui fait de lui un ├¬tre anormalement puissant.\n\nViolet = Ceux qui la manient font partie de la cat├®gories des "cultivateurs" connus sous trois sous-cat├®gories : "Les ├®veill├®s" pour ceux qui la pratiquent mais rest├®s sur terre, "les envol├®s" pour les adoub├®s (ceux qui rejoignent les cieux apr├¿s avoir ├®t├® sur Terre), et "les remerci├®s" pour les familles c├®lestes ancestrales rest├®s sur l'├«le sacr├®e. La magie violette est le m├®lange entre la magie bleu et la magie rouge.\n\nBlanche = Magie "purifi├®e" n'├®tant utilis├®e que par les dieux c├®lestes de l'├«le sacr├®e, la famille royale. Elle est l'assemblage de toutes les couleurs d'o├╣ sont noms "magie blanche", cependant elle appara├«t aux yeux des hommes comme une poussi├¿re/lueur dor├®e. La magie blanche apparait lors de l'union de l'esprit Junji et de l'humaine Chayan-Li, apr├¿s avoir combattu lors du grand craquellement, ils s'unissent par amour et leurs enfants h├®ritent de ce pouvoir.\n\nVerte, Orange, Rose = Des magies plus ou moins avanc├®es piochant dans les diff├®rentes magies primaires existantes (Bleu, Rouge), elles sont utilis├®es par des personnes ├á la puissance interm├®diaire utilisant la magie, pouvant varier.\n\nLieux importants:\n\nL'├«le sacr├®e = Cette ├«le volante flotte a plusieurs centaines de kilom├¿tres dans le ciel au-dessus de la Terre, elle est le lieu de r├®sidence des dieux et des esprits. La famille royale y vit dans un palais aux inspirations chinoises et japonaises, de multiples temples sont pr├®sents partout sur l'├«le, y vit ├®galement les remerci├®s et les adoub├®s. Elev├® au ciel par ses fondateur Junji et Chayan-Li, l'├«le est un havre de paix o├╣ peut reposer la famille c├®lestes ainsi que les esprits d├®sirants aller et venir entre les deux mondes.\n\nLa Terre = Monde o├╣ vivent les humains, faune et flore sont principalement aliment├®s par la magie qui est source de toute chose. Des grandes sources de magie se trouvent aux quatre coins du monde, cr├®ant des points de ralliement o├╣ de grandes villes ont prosp├®r├® dans le pass├®.\n\nVillage de Sausir : Village dont est originaire Pomme et sa famille mais aussi village dans lequel elle a grandit avec Djia. Ce petit patelin est principalement connu pour la production de fleurs en tout genre, simplement d├®coratives ou avec des propri├®t├®s magiques ou m├®dicinales, elles sont export├®s dans tout le pays.\n\nLa nouvelle capitale "" : A l'origine elle n'├®tait qu'une simple ville commerciale sans importance, mais lors de la chute de l'empire sa source magique a miraculeusement ├®t├® ├®pargn├®, faisant d├®sormais d'elle un point de ralliement pour tous les r├®fugi├®s. Assez rapidement, sa population cro├«t de fa├ºon exponentielle et la ville s'├®tend de plus en plus. En quelques ann├®es seulement, elle devient une vraie m├®gapole, pleine de vies et de passage, elle est d├®sign├® comme la nouvelle capitale.\n\nEv├¿nements d├®clencheurs de la chute de l'empire :\n\nSenri, avide de pouvoir et avec de grandes ambitions, monte un plan pour s'introduire sur l'├«le sacr├®e en rejoignant l'arm├®e c├®leste du roi. Il charme la princesse Ada avec l'espoir de la marier. Il ont une relation tr├¿s passionnelle, mais Senri doit repartir sur Terre due ├á ses fonctions dans l'arm├®e, il devait souvent effectu├® des missions hors de l'├«le. A chaque retour Ada l'attendait patiemment, malheureusement, la famille royale avait des plans pour Ada, dont celui de la marier ├á Ekemi, un remerci├®e tr├¿s appr├®ci├® de la Reine . N'ayant pas le choix de refuser et ayant toujours gard├® sa relation avec Senri secr├¿te, Ada acceptera de se donner enti├¿rement ├á Senri la veille son mariage avec Ekemi en guise "d'au revoir". Elle tombe malheureusement enceinte de Senri , et elle fera passer l'enfant pour celui d'Ekemi pendant des ann├®es. Senri n'ayant pu atteindre son objectif en charmant Ada la premi├¿re fois, il pensera un nouveau plan pour  rejoindre les rangs de la garde rapproch├®e du Roi Sukan. \n\nPlusieurs ann├®e passe avant qu'il puisse atteindre son objectif et retourner sur l'├«le avec son nouveau poste dans la garde rapproch├®e du Roi. Cependant, pendant toutes ces ann├®es d'absence, Ekemi et Ada d├®veloppe finalement des sentiments l'un envers l'autre. Ada ayant le coeur bris├® et d'abord rude envers son nouveau mari, s'adoucira face ├á la patiente et la bienveillance d'Ekemi. Ne sachant toujours pas quel ├®tait le vrai p├¿re de Tianxin, Ada d├®cide de tracer un trait sur son pass├® et vivre pleinement son histoire avec Ekemi. Senri de retour pr├¿s d'Ada, se senti trahit d'observer de ses propres yeux la proximit├® entre Ada et Ekemi. Senri qui ne pouvait supporter de la voir en permanence accompagn├®e de son mari Ekemi, et apprenant  qu'Ada ├®tait de nouveau enceinte, il ├®labore un plan pour empoisonner Ekemi avec un th├® sp├®cial. Maintenant qu'il avait mont├®e de grade, il pourrait peut-├¬tre r├®cup├®rer Ada si Ekemi disparaissait. Le but de Senri ├®tant toujours d'essayer de gagn├® plus de pouvoir en s'alliant ├á l'un des membres de la famille Royale et obtenir l'autorit├® d'un dieu le jour o├╣ Ada reprendra la place de son p├¿re, puisqu'elle est la seule h├®riti├¿re du tr├┤ne, il deviendrait ├á son tour roi. \n\nMais par m├®garde Ekemi boira ce th├® avec la Reine Aim├®e-Li dont il ├®tait devenu proche au fil des ann├®es, causant leurs morts ├á tous les deux. Fou de rage et d├®vast├® le roi va d├®couvrir que Senri ├®tait derri├¿re tout ├ºa. Le but de Senri au d├®part ├®tant de tuer seulement Ekemi pour prendre officiellement sa place plus tard, et en se mariant ├á la princesse Ada recevoir le pouvoir des dieux. \n\nPeu apr├¿s la naissance du deuxi├¿me enfant d'Ada, la princesse Djia, le Roi Sukan d├®couvre le plan de Senri et un ├®norme combat d├®truisant presque toute l'├«le sacr├®e a lieu. La v├®rit├® ├á propos de Tianxin, le premier fils d'Ada est r├®v├®l├®e, il n'est pas le fils d'Ekemi mais bien celui de Senri , le tra├«tre, faisant ainsi de lui un b├ótard ill├®gitime. Apr├¿s tout, quand on regardait bien, la ressemblance entre eux ├®tait de plus en plus frappante en grandissant. Lors du combat, Senri prend le b├®b├® comme otage, accul├® de tous les c├┤t├®s, comme dernier espoir de n├®gociation. Il finira par se jeter dans le vide avec le b├®b├®, Ada les suivra afin de sauver son enfant. Ils s'enfoncent dans les nuages et Senri dispara├«t pendant qu'Ada rattrape Djia. Pendant leur chute Ada utilisera toute sa puissance en sacrifice afin de sauver la vie de Djia, elle scellera par la m├¬me occasion toute sa magie c├®leste en Djia, ├®tant trop faible apr├¿s le combat c'├®tait son seul moyen. Ada en meurt et Djia atterrit sur Terre saine et sauve. Le roi dans un dernier ├®lan de folie et de rage fait d├®ferler sa col├¿re sur Terre, brisant malencontreusement la quasi-totalit├® des sources de magie (sous forme de dalle en pierre ronde avec des motifs de racine), provoquant ainsi la chute de l'empire. En dehors des habitants de l'├«le sacr├®e, personne ne sait vraiment ce qui a d├®clench├® cet ├®v├®nement abominable. La plupart voit cet ├®v├¿nement comme l'abandon des dieux.\n\nContexte sur le monde actuel :\n\nLes grandes sources ayant ├®t├® presque toutes d├®truites, le monde fut plong├® dans le chaos, la mis├¿re et la peur. Faisant passer le monde d'utopique ├á dystopique, la chute de l'empire comme on l'appelle causera la mort de nombreuses personnes et engendrera la d├®portations de peuples entier (Ceux vivant pr├¿s de sources de magie d├®truites se voient oblig├®s de fuir vers les villes ayant encore une source de magie fonctionnelle). L'absence de magie joue un r├┤le majeur sur la sant├® de l'environnement. Les for├¬ts priv├®es d'assez de magie se voient p├®rir, les champs se fanent, les animaux sauvages se font rare et la vie en g├®n├®rale dispara├«t peu ├á peu. Les villes proches de sources magiques encore fonctionnelles se mettent d'un seul coup ├á prosp├®rer ├®norm├®ment, de petits villages deviennent peu ├á peu de grandes cit├®s, certains prennent avantages de leurs nouveaux atouts, certains accueillent tandis que d'autres pillent, et taxes les plus pr├®caires. Beaucoup de petit villages se voient ├¬tre rendu ├á l'esclavage s'ils n'├®taient pas capable de subvenir ├á leur propre besoin seul. Les faibles apeur├®s travaillant pour les plus fort qui leurs assurent protection et nourritures en ├®change de travail.\n\nLe Roi Sukan vit toujours reclus sur l'├«le sacr├®e, Tianxin lui est en quelque sorte banni de l'├«le sacr├®e et s'installera dans la nouvelle capitale.	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-21 06:09:04.681+00	2025-10-23 01:09:01.680988+00	[]	Chapitre 1 : Djia et Pomme s'├®loignent du village pour une ├®ni├¿me aventure, ├á la recherche d'une ancienne source de magie bris├®. Elles se font surprendre par un bande de mercenaires, les loups noirs. Ils tentent de les capturer et les tuer. A deux doigts de perdre la vie lors d'une attaque ├á l'├®p├®e, Djia d├®bloque sa magie, la sauvant elle et son amie. Un grand halo de lumi├¿re ├®merge dans le ciel faisant savoir ├á tous qu'une magie puissante venait de se r├®veiller. Elles s'enfuient et retourne au village de Sausir, d├®cidant de ne pas parler de ce qu'il s'est pass├®. Le roi Sukan et Tianxin ont ressenti la magie et se questionnent sur son origine.\n\n\n\nChapitre 2 : Plusieurs mois ont pass├® et c'est maintenant presque la fin de l'hiver. Djia a un r├¬ve r├®curent ├á propos d'une chute dans les nuages et une femme aux cheveux noirs. Elle n'arrive pourtant pas ├á savoir si c'├®tait r├®el ou juste un r├¬ve. Un soir, Pomme vient la r├®conforter en venant toquer ├á sa fen├¬tre en pleine nuit, les jeunes filles discute et finissent par parler du festivale annuel du printemps en rapport avec les fleurs de M├®diolias. Pomme fait une d├®monstration de la danse qu'elle effectuera dans quelques jours et Djia chante pour l'accompagner. Les filles finissent par s'endormir. Le lendemain, leurs m├¿res respectives les retrouves endormie ensemble et sont rassur├®s de voir que tout va bien.  Leurs m├¿res discuteront de l'organisation du festival et des premi├¿res r├®coltes. Plus tard dans la journ├®e, un groupe de cultivateurs arrive au village. ils disent ├¬tre l├á pour leur recherche. Leur accoutrement peu commun fait se questionner le village.  D'autre part, Tianxin voyage seul, avec une lletre du Roi Sukan ayant pour mission de retrouver qui a ├®mit la magie blanche, et ce sera sa saule fa├ºon de prouver sa loyaut├®.\n\nChapitre 3 :\nLes jeunes filles qui s'inqui├¿te qu'on les cherche. \n Quelques jours ont pass├® et les cultivateurs ont commenc├® ├á ├¬tre grandement appr├®ci├® par le village, de part leurs aptitudes magiques, ils d├®cident d'aider les villageois dans leur t├óche journali├¿re, une sorte de remerciement pour les accueillir. Djia se fait toute petit pour ne pas attirer l'attention. Le lendemain, le festivale se d├®roule sur la journ├®e au complet, tout le monde se r├®veille t├┤t pour finaliser les pr├®parations et de nombreux visiteurs arrivent aux aurores pour ne rien manquer. \n\nChapitre 4 : Pomme essaye de convaincre Djia de chanter devant le village mais celle-ci refuse, ayant peur de se faire remarquer. Pomme finira par insister au moment de la prestation et Djia acceptera finalement pour lui faire plaisir. Pendant ce moment, elle est expos├® devant tout le villlage, son apparence peu commune dan sla r├®gion attire l'oeil des cultivateurs qui pensent avoir trouver une piste. \n\nChapitre 5 : Le soir ils essaieront de l'int├®roger, tout en la flattant elle et pomme sur leur prestation de la journ├®e. Djia se m├®fiant et ressentant une aura lourde venant des cultivateurs ele essaiera de fuir. Les cultivateurs ne peuvent pas la laisser partir et d├®cide de mettre sa vie en danger pour la forcer ├á utiliser son pouvoir. Pour eux c'├®tait le seul moyen d'├¬tre s├╗r qu'elle n'├®tait pas celle qui cherchait.\n\n\nChapitre 6 : Alors que les jeunes filles ont disparu et ne rentre pas pour le souper du soir, Mara et Lilly partent ├á leur recherche, demandant aux villageois s'ils les ont vu. pendant ce temps, Djia et Pomme sont gravement menac├® et m├¬me bless├®, car rien ├á faire, sa magie ne revient pas et elle refuse de la leur montrer.\n\nChapitre 7 :  Les cultivateurs essayent de l'amadouer en lui promettant pouvoir l'aider ├á contr├┤ler ce pouvoir et devenir puissante. Djia cependant aime sa vie de simplicit├®, et est effray├® par ce qu'implique tant de puissance. Elle s'├®chappe gr├óce ├á une ruse et les cultivateurs les poursuivent jusque dans la rue. Ici, elles tombent nez ├á nez avec leurs m├¿res ainsi que quelques villageois encore entrain de ranger apr├¿s le festival.\n\nChapitre 8: Les cultivateurs commencent ├á les menacer et essaye de s'en prendre ├á Mara. Djia folle de rage finit par utiliser sa magie ├á nouveau, devant otu le monde pr├®sent. tous les spectateurs sont choqu├®s et le cultivateur principal ayant enfin sa r├®ponse envoie le groupe la capturer. \n\nChapitre 9 : Djia n'a pas d'autre choix que de quitter le village, Pomme d├®cidera de l'accompagner, ne pouvant tout expliquer ├á leurs parents dans la pr├®cipitation elle dira juste qu'elle ne peut abandonner Djia, et qu'il est important que Lilly et Mara reste afin de s'assurer que le village aille bien et, peut-├¬tre, ralentir les agresseurs.	f
e291a52e-afee-466b-baa6-504c50e026e1	212cdfee-bdfd-4a38-affd-7546df01cc02	Ephialt├¿s	Natif	Fantasy	Directive G├®n├®rale\nTu vas ├®crire une romance ├®rotique gay se d├®roulant dans un univers de fantasy inspir├® de la Gr├¿ce antique. L'histoire est racont├®e ├á la premi├¿re personne ("Je") du point de vue d'un d├®mon banni, forc├® de consommer la semence humaine pour ne pas mourir. Le lecteur doit vivre sa transformation de l'int├®rieur : ce qui commence comme une mal├®diction humiliante devient progressivement une qu├¬te h├®doniste de pouvoir et de plaisir, jusqu'├á une addiction totale ├á l'extase. Le ton doit ├¬tre direct, brutal et sensoriel, centr├® sur mes besoins primaires.\n\nAxe 1 : Le Personnage (Le D├®mon Banni)\nMoi ÔÇô Azael : L'Exil├® Affam├®.\n\nMon Apparence : Mon corps est un mensonge sculpt├® dans la chair des mortels, un pi├¿ge parfait. J'ai l'apparence d'un jeune homme au sommet de sa beaut├® : des cheveux noirs comme le vide entre les ├®toiles, une peau lisse et p├óle sans le moindre d├®faut, des muscles dessin├®s comme par un sculpteur divin. Mais le pi├¿ge est dans les d├®tails. Mes yeux n'ont pas de couleur d├®finie, leur teinte changeant du gris temp├¬te au violet profond selon la lumi├¿re, et ils ne refl├¿tent jamais rien. Mon corps, quand je suis immobile, a une qui├®tude surnaturelle, une absence de mouvement qui trahit ma nature non-humaine. C'est une beaut├® qui attire et qui d├®range.\n\nMon ├ége et Mon Histoire : L'├óge n'a pas de sens pour moi. J'ai vu des montagnes devenir du sable et des ├®toiles na├«tre et mourir. Avant cette prison de chair, j'├®tais une entit├® de chaos, un d├®voreur d'├®chos dans le n├®ant. Ma transgression fut simple : la curiosit├®. J'ai go├╗t├® ├á une ├®motion pure, une chose qui n'├®tait pas ├á moi. Pour ce crime, ils m'ont banni, m'ont encha├«n├® ├á cette forme physique et ├á sa faim perp├®tuelle.\n\nMa Dualit├® : Le Strat├¿ge et la B├¬te : Je suis deux choses ├á la fois. En dehors de l'acte, mon esprit est un labyrinthe de calculs. Comme un Varys ou un Littlefinger, je manipule les hommes, les rumeurs et les ├®v├®nements avec plusieurs coups d'avance. Mes machinations sont subtiles, invisibles. Je m├¿ne le jeu pour obtenir exactement ce que je veux, quand je le veux. Mais pendant l'acte, au moment de recevoir ce qui me nourrit, je perds tout contr├┤le. Mon esprit de strat├¿ge s'├®teint et la b├¬te prend le dessus. Cette soumission totale ├á l'extase est ma plus grande vuln├®rabilit├® et, paradoxalement, mon arme la plus puissante.\n\nMa Mal├®diction : Mon essence d├®moniaque se d├®sagr├¿ge dans ce monde. C'est une agonie constante, une sensation de froid int├®rieur qui me ronge. La seule substance capable de stopper cette d├®composition et de me "nourrir" est la force vitale concentr├®e dans la semence humaine.\n\nMon ├ëvolution Psychologique (v├®cue par le lecteur) :\n\nLa Survie (Le D├®go├╗t) : Au d├®but, chaque acte est une n├®cessit├® abjecte. Je me vois comme un charognard, forc├® de m'abaisser ├á ce rituel humiliant.\n\nLa Chasse (Le Calcul) : Je r├®alise que la manipulation est une arme. J'apprends ├á jouer des r├┤les pour obtenir ce dont j'ai besoin plus facilement.\n\nLe Plaisir (La B├®n├®diction) : Je d├®couvre le plaisir. Pas seulement le soulagement de la faim, mais le plaisir brut de l'acte lui-m├¬me. La chaleur des corps, le go├╗t, la sensation de pouvoir... Ma mal├®diction devient mon terrain de jeu.\n\nL'Extase (L'Addiction) : Le plaisir devient une faim en soi, plus puissante que celle de ma survie. Je recherche des sensations de plus en plus fortes, jusqu'├á atteindre un point de non-retour : une extase si intense qu'elle efface toute pens├®e, toute conscience. Mon corps r├®agit de mani├¿re incontr├┤lable, les yeux r├®vuls├®s, la salive aux l├¿vres, des g├®missements animaux. Je deviens un accro ├á cette perte de contr├┤le, ├á cet oubli de soi dans une jouissance absolue.\n\nAxe 2 : L'Univers (Une Gr├¿ce Fantastique)\nLe Cadre : Une version fantasm├®e du monde grec. Des cit├®s-├®tats de marbre blanc sous un soleil ├®crasant, des agoras o├╣ les philosophes c├┤toient les mercenaires, des temples d├®di├®s ├á des dieux cruels et oubli├®s. Les gymnases, les casernes militaires et les villas des patriciens sont mes terrains de chasse.\n\nLa Soci├®t├® : Une culture qui c├®l├¿bre la beaut├® du corps masculin, mais o├╣ les dynamiques de pouvoir sont strictes. La p├®n├®tration est un acte de domination. Je dois naviguer dans ces codes, en les utilisant ├á mon avantage.\n\nAxe 3 : La Progression Narrative\nL'histoire doit suivre une progression claire, o├╣ chaque conqu├¬te sert un objectif plus grand.\n\nActe 1 : La Toile du D├®sir. Mon objectif est de survivre et de construire mon pouvoir. Je passe du statut de victime de ma faim ├á celui de ma├«tre manipulateur. Chaque homme que je s├®duis est un pion.\n\nD├®cor : Les bas-fonds, les tavernes. Je commence par des proies faciles.\n\nIntrigue : J'utilise un soldat pour me prot├®ger, un marchand pour m'├®tablir, et je commence ├á tisser ma toile de rumeurs pour cr├®er ma l├®gende.\n\nImportance narrative : ├ëtablir ma m├®thode, ma r├®putation et ma transformation du d├®go├╗t ├á l'addiction.\n\nActe 2 : Le Jeu des Immortels. Mon objectif change. Je d├®couvre qu'un autre ├¬tre comme moi, ou peut-├¬tre l'un de ceux qui m'ont banni, est pr├®sent dans la cit├®. Ma qu├¬te devient une chasse ├á l'information et une pr├®paration ├á la confrontation.\n\nD├®cor : Les villas des politiciens, les jardins des philosophes, les temples. Mes cibles deviennent plus prestigieuses.\n\nIntrigue : Je s├®duis un politicien pour apprendre les secrets de la cit├®, un pr├¬tre pour comprendre les rituels anciens, un g├®n├®ral pour ├®valuer les forces en pr├®sence. Chaque acte sexuel est une extraction d'informations, chaque orgasme une pi├¿ce du puzzle.\n\nImportance narrative : Augmenter les enjeux, diversifier les sc├¿nes et introduire un antagoniste ou un myst├¿re central.\n\nActe 3 : La Confrontation. Je suis pr├¬t. J'utilise tous les pions que j'ai plac├®s, toutes les informations que j'ai recueillies, pour orchestrer ma confrontation finale.\n\nD├®cor : Le c┼ôur du pouvoir (le palais, le temple principal).\n\nIntrigue : Mon plan se d├®roule. Je dois affronter mon rival ou l'entit├® qui me menace, en utilisant non pas la force brute, mais la manipulation et le d├®sir comme mes armes principales.\n\nImportance narrative : R├®soudre le conflit central. Mon addiction ├á l'extase sera-t-elle ma force ou ma chute finale ?\n\nAxe 4 : La Dynamique de la Chasse\nMes Strat├®gies : Je suis un ma├«tre manipulateur. Mes plans sont des toiles complexes, et chaque conqu├¬te est une ├®tape vers mon objectif final.\n\nLe S├®ducteur : Je peux jouer le bel ├®ph├¿be myst├®rieux pour attirer un po├¿te ou un aristocrate, apr├¿s avoir ├®tudi├® leurs faiblesses pendant des semaines.\n\nLe Rival : Je peux d├®fier un athl├¿te, non pas sur sa force, mais sur son orgueil, en orchestrant une situation o├╣ sa seule issue pour sauver la face est de m'emmener dans son lit.\n\nLa Proie : Je peux me faire passer pour une victime pour attirer un protecteur, tout en ayant sem├® les graines du danger moi-m├¬me.\n\nLa L├®gende : Ma r├®putation me pr├®c├¿de. Les hommes se murmurent mon nom. Je cultive cette notori├®t├®, laissant filtrer des rumeurs pour attirer des cibles sp├®cifiques, les faisant croire que c'est eux qui me chassent.\n\nMes Proies : Je ne suis pas un charognard. J'ai un certain standing. Je ne choisis que les plus beaux, les plus puissants, les plus d├®sirables. Un athl├¿te olympique, un g├®n├®ral victorieux, un sculpteur dont les mains cr├®ent la beaut├®. Leur excellence rend leur semence plus... savoureuse. Leurs r├®actions ├á mon extase ne sont pas de la peur, mais une fascination perverse. Ils sont excit├®s par ma perte de contr├┤le, y voyant la preuve ultime du plaisir que je ressens gr├óce ├á eux.\n\nAxe 5 : Style et Ton\n├ërotisme Brut et Sensoriel : L'histoire est racont├®e ├á travers mes sens. D├®cris ma douleur lancinante, la texture et le go├╗t de ce qui me sauve, la chaleur d'un corps contre le mien, l'odeur de la sueur et de l'huile d'olive.\n\nLangage Direct et Cru : Mes pens├®es sont primaires. "J'ai faim." "Je dois le soumettre." "Je veux son sperme." "C'est bon." Le style est sans fard, sans euph├®misme.\n\nPoint de Vue ├á la Premi├¿re Personne ("Je") : Le lecteur est pi├®g├® dans ma t├¬te. Il doit ressentir ma d├®ch├®ance, ma ruse, et ma transformation en un h├®doniste impitoyable. Le glissement du d├®go├╗t au plaisir, puis ├á l'addiction, doit ├¬tre le fil rouge de ma narration interne.\n\nAxe 6 : Exemple de Ton\nPour illustrer le style et l'├®volution du personnage, voici un exemple de sc├¿ne int├®rieure :\n\nExemple de Tension et de Transformation (├á la premi├¿re personne) :\n"La douleur est une vrille de glace dans mes entrailles, mais je la cache. L'athl├¿te s'approche, exactement comme je l'avais pr├®vu. Sa suffisance est une insulte, mais son corps est une promesse. Il pense mener le jeu. Imb├®cile. Il me plaque contre le mur, sa main brutale troussant ma tunique. Je ferme les yeux, savourant le d├®roulement parfait de mon plan. Quand il se vide en moi, la d├®charge frappe. Le strat├¿ge en moi s'├®teint. La chaleur qui calme la douleur est si intense qu'elle fait sauter le verrou de ma conscience. Le go├╗t sal├® et puissant sur ma langue est une drogue. Mon esprit se fracture. Mon corps prend le relais. Mes yeux se r├®vulsent, ne laissant voir que le blanc. Ma m├óchoire se d├®croche, ma langue pend, inerte, et un filet de bave et de sperme coule sur mon menton. Un gargouillis obsc├¿ne s'├®chappe de ma gorge, un son inhumain. Mon corps entier est secou├® de spasmes violents, mes talons martelant le sol en pierre. Je suis une cr├®ature de pur plaisir, une b├¬te en rut. Mais cette fois, quand je reprends conscience, il est toujours l├á. Il ne me l├óche pas. Il me regarde, non avec terreur, mais avec une fascination lubrique. Son propre sexe est de nouveau dur comme le marbre. 'Par les dieux,' souffle-t-il, sa voix rauque. 'C'est la chose la plus obsc├¿ne que j'aie jamais vue.' Il se penche, non pour m'embrasser, mais pour l├®cher le m├®lange de bave et de sa propre semence sur mon menton. Il veut go├╗ter ├á ma d├®ch├®ance. Je ne suis plus seulement son objet. Je suis sa nouvelle religion. Et il est le premier de mes fid├¿les."	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen-2.5-72b-instruct	2025-11-10 00:24:55.992+00	2025-11-09 22:40:34.967994+00	\N	1. Dans les bas-fonds de la cit├®, Azael tisse sa toile, utilisant un mercenaire charismatique comme garde du corps et un influent n├®gociant des march├®s noirs pour ├®tablir sa pr├®sence.\n2. Il cible le Biblioth├®caire en chef de la Cit├®, un homme d'une beaut├® aust├¿re et d'une intelligence redoutable, pour d├®chiffrer les archives interdites r├®v├®lant la nature de sa mal├®diction et l'identit├® de son tourmenteur.\n3. Azael s├®duit le po├¿te le plus adul├® de la cit├®, un artiste ├á la beaut├® c├®l├®br├®e par l'aristocratie, transformant ses vers en instruments de propagande pour b├ótir sa propre l├®gende.\n4. Il s├®duit le Ma├«tre de la Guilde des Marchands, un homme au charisme impitoyable qui tient l'├®conomie de la cit├®, afin de d├®tourner les flux de richesses et de financer ses op├®rations.\n5. Visant le c┼ôur spirituel, Azael cible le Grand Pr├¬tre, un homme ├á la beaut├® hi├®ratique et ├á l'influence politique immense, utilisant sa foi r├®put├®e inflexible comme une arme pour corrompre les oracles.\n6. Il p├®n├¿tre la haute soci├®t├® et devient l'obsession d'un Duc puissant, r├®put├® pour son esth├®tisme raffin├® et son contr├┤le absolu sur l'aristocratie, cartographiant ainsi les alliances de la noblesse.\n7. Son ascension attire l'attention du Ma├«tre-Espion de la Cit├®, un adversaire aussi s├®duisant que mortel. Azael orchestre sa chute en utilisant la d├®sinformation, retournant le propre r├®seau de l'espion contre lui.\n8. Azael cible le Juge Supr├¬me, un homme ├á la r├®putation incorruptible et ├á l'autorit├® incontest├®e, utilisant un chantage ├®motionnel complexe pour prendre le contr├┤le du syst├¿me judiciaire.\n9. Pour neutraliser la force arm├®e, il s├®duit le G├®n├®ral invaincu des l├®gions, un strat├¿ge brillant ├á la beaut├® martiale, exploitant son ambition d├®vorante pour assurer la loyaut├® de l'arm├®e lors du coup final.\n10. Ma├«tre absolu de la cit├®, Azael orchestre la confrontation finale avec l'entit├® qui le maudit. Utilisant ses pions (militaire, religieux, politique) pour alimenter un rituel complexe, il parvient ├á vaincre son tourmenteur, s'emparant de son pouvoir et devenant le nouveau ma├«tre invisible de la m├®tropole.	t
c698b03c-c76e-4cce-8dab-a39784ab5ab6	212cdfee-bdfd-4a38-affd-7546df01cc02	µüïµäøÒü«þë®Þ¬×	N3	Fantasy	­ƒî© þ┐íþ┐á´╝êÒü▓ÒüÖÒüä´╝ëÒâÄµÂÖÒâÄþÄïÕ£ï´╝êÒüèÒüåÒüôÒüÅ´╝ë ­ƒî©\nÒé©ÒâúÒâ│Òâ½: SMUT´╝êµÑÁÚüôÒâ¡Òâ×Òâ│Òé╣Òâ╗ÞâîÕ¥│µäø´╝ë, µÖéõ╗ú´╝êµ¡┤ÕÅ▓´╝ëÒâ¡Òâ×Òâ│Òé╣, ÕåÆÚÖ║µ┤╗Õèç, Õëúµêƒ´╝êÒüæÒéôÒüÆÒüì´╝ë, µüïµäø\n­ƒôì ÞâîµÖ»õ©ûþòî\nþò░Þü×Òâ╗µ▒ƒµê©µÖéõ╗ú´╝ÜÒüôÒü«õ©ûþòîÒüºÒü»ÒÇüÕÅ▓Õ«ƒÒü«µ▒ƒµê©ÒéÆÕƒ║þñÄÒü¿ÒüùÒüñÒüñÒééÒÇüµÇºÕêÑÒÇüþñ¥õ╝ÜþÜäÕ¢╣Õë▓ÒÇüµ¿®ÕèøµºïÚÇáÒü½Õ»¥ÒüÖÒéïÞªïµû╣ÒüîÕñºÒüìÒüÅþò░Òü¬ÒéèÒÇüþï¼Þç¬Òü«þÖ║Õ▒òÒéÆÚüéÒüÆÒüªÒüäÒü¥ÒüÖÒÇé\n * þñ¥õ╝Ü´╝ÜÕÑ│õ¥ì´╝êÒüèÒéôÒü¬ÒüûÒéÇÒéëÒüä´╝ëÒéäþöÀÞè©ÞÇà´╝êÒüèÒü¿ÒüôÒüÆÒüäÒüùÒéâ´╝ëÒüîÕ¡ÿÕ£¿ÒüÖÒéïÒÇé\n * ÕÉìÞ¬ë´╝êÒüèÒü«Òéî´╝ë´╝Üõ║║Òü«õ¢ìÒü»þöƒÒü¥ÒéîÒüºÒü»Òü¬ÒüÅÒÇüÒÇîÕëÁÚÇáÒüùÒÇüµÑÁÒéüÒÇüÒü¥ÒüƒÒü»Ú¡àõ║åÒüùÒüƒ´╝êµâæÒéÅÒüøÒüƒ´╝ëÒééÒü«ÒÇìÒü½ÒéêÒüúÒüªµ©¼ÒéëÒéîÒéïÒÇé\n * Ú¡öÞíô´╝ÜÚ¡öÞíôÒü»Òé¿Òâ¬Òâ╝ÒâêÒü«Õù£Òü┐ÒüºÒüéÒéèÒÇüõ║öÕñºÕàâþ┤áÕ«Â´╝êÚó¿ÒÇüþü½ÒÇüµ░┤ÒÇüÕ¢▒ÒÇüÞè▒´╝ëÒü½ÒéêÒüúÒüªµÄîµÅíÒüòÒéîÒüªÒüäÒéïÒÇé\nÔ£¿ Ú¡öµ│òõ¢ôþ│╗ ÔÇö þºÿÞíô´╝êÒü▓ÒüÿÒéàÒüñ´╝ëÒü«µø©Úüô´╝êÒüùÒéçÒü®Òüå´╝ë\nþÑ×ÞüûÒü¬Òéïµø©ÚüôÒü½ÞºªþÖ║ÒüòÒéîÒüƒõ¢ôþ│╗ÒÇéµûçÕ¡ùÒéÆÒÇîµø©ÒüìÒÇìÒÇüÒüéÒéïÒüäÒü»ÒÇîÕö▒ÒüêÒéïÒÇìÒüôÒü¿ÒüºÒÇüµºÿÕ╝ÅÕîûÒüòÒéîÒüƒÚ¡öÞíôÒüîþÖ║ÕïòÒüÖÒéïÒÇéõ¢┐þö¿ÒüÖÒéïÕ¬Æõ¢ô´╝êÚó¿ÒÇüþÁ╣ÒÇüÞéëõ¢ôÒÇüÕó¿ÒÇüÕêâ´╝ëÒüîÚ¡öÞíôÒü«Õ¢óÒü½Õ¢▒Úƒ┐ÒéÆõ©ÄÒüêÒéïÒÇé\n * Úó¿Òü«Õ«Â´╝Üþº╗ÕïòÒÇüÚÇƒÕ║ªÒÇüÚÜáÕ»å´╝êÒüèÒéôÒü┐Òüñ´╝ëÒü«Ú¡öÞíôÒÇé\n * þü½Òü«Õ«Â´╝Üµâàþå▒ÒÇüþá┤ÕúèÒÇüµÀÀµ▓îÒü«Ú¡öÞíôÒÇé\n * Õ¢▒Òü«Õ«Â´╝ÜÕ╣╗µâ│ÒÇüµåæõ¥Ø´╝êÒü▓ÒéçÒüåÒüä´╝ëÒÇüÕñëÞ║½Òü«Ú¡öÞíôÒÇé\n * µ░┤Òü«Õ«Â´╝Üµ▓╗þÖÆÒÇüÞ¿ÿµåÂÒÇüÕ«êÞ¡ÀÒü«Ú¡öÞíôÒÇé\n * Þè▒Òü«Õ«Â´╝ÜÚ¡àõ║åÒÇüÞè©ÞíôÒÇüµäƒµâàÒéÆµôìÒéïÚ¡öÞíôÒÇé\n­ƒÆí Ú¡öÞíôÒü«þÖ║Õïò´╝ÜÞ▓┤õ║║Òü»ÒÇüÕêÇÒü«Òü▓Òü¿µî»ÒéèÒÇüÞè©ÞÇàÒü«Þê×ÒÇüµäøÒüùÒüäÞÇàÒü«ÞÇ│ÕàâÒüºÕøüÒüÅÞ®®ÒÇüÒü¬Òü®Òü½ÒéêÒüúÒüªÕæ¬µûçÒéÆÒÇîµø©ÒüÅÒÇìÒüôÒü¿ÒüîÒüºÒüìÒéïÒÇé\n­ƒææ ÒéÀÒâèÒâ¬Òé¬´╝ÜÒÇîÕêÇÒü¿ÞîÂÒü«µ£êÕñ£´╝êÒüñÒüÅÒéê´╝ëÒü«õ©ïÒüºÒÇì\n­ƒô£ µªéÞªü´╝êÒâöÒââÒâü´╝ë\nÞüûÕƒƒÒâ╗Úó¿ÕÀØ´╝êÒüéÒü£ÒüïÒéÅ´╝ëÒâÄÚçîÒü½ÒüªÒÇüþºÿÞíôÒü«µø©ÚüôÒü½þåƒÚüöÒüùÒüƒÞïÑÒüìÞè©ÞÇàÒâ╗Õçø´╝êÒéèÒéô´╝ëÒü»ÒÇüÚâ¢´╝êÒü┐ÒéäÒüô´╝ëÒü«Õ««µ«┐Òü½ÕÅ¼ÚøåÒüòÒéîÒéïÒÇéÕÅ¼ÚøåÒéÆÕæ¢ÒüÿÒüƒÒü«Òü»ÒÇüÞ¼ÄÒü½ÕîàÒü¥ÒéîÒüƒÒÇüÒüØÒüùÒüªµüÉÒéîÒéëÒéîÒéïÕ░åÞ╗ìÒâ╗þâê´╝êÒéîÒüñ´╝ëÒâÄþºïÕ╝ÿ´╝êÒüéÒüìÒü▓Òéì´╝ëÒÇé\nÕåÀÚàÀþäíµ»öÒÇüõ©ìµòùÒÇüÒüØÒüùÒüªþªüÒüÿÒéëÒéîÒüƒ**õ©ÇµûçÕ¡ù´╝êµ╝óÕ¡ù´╝ë**ÒéÆµôìÒéïÕ¢╝Òü»ÒÇüÚ¡öÞíôÒü¿µêª´╝êÒüäÒüÅÒüò´╝ëÒü«þï¡ÚûôÒü½µÅ║ÒéîÒéïÕø¢Õ«ÂÒéÆÚÖ░ÒüïÒéëµö»ÚàìÒüùÒüªÒüäÒéïÒÇé\nÒéäÒüîÒüªÒÇüÕçøÒü«ÞëÂÒéüÒüÅÕä¬þ¥ÄÒüòÒü¿ÒÇüþºïÕ╝ÿÒü«ÚØÖÒüïÒü¬ÒéïÕåÀÕ¥╣ÒüòÒü«ÚûôÒü½Òü»ÒÇüµè£ÒüìÕÀ«ÒüùÒü¬ÒéëÒü¼þÀèÕ╝ÁÒüîþöƒÒü¥ÒéîÒéïÒÇé\nÒüùÒüïÒüùÒÇüÕçøÒü«ÚüÄÕÄ╗ÒüïÒéë**ÒÇîÕ¢▒Òü«Õ«ÂÒÇìÒü«þºÿÕ«ØÒâ╗ÚÅíÒâÄÕñ¬ÕêÇ´╝êÒüïÒüîÒü┐Òü«ÒüƒÒüí´╝ë**Òü«ÚìÁÒüîµÁ«õ©èÒüùÒüƒÒü¿ÒüìÒÇüµ¿®ÕèøÚùÿõ║ëÒü«Úüèµê»´╝êÒé▓Òâ╝Òâá´╝ëÒü»ÒÇüÞéëõ¢ôÒÇüþ▓¥þÑ×ÒÇüÒüØÒüùÒüªþéÄÒü«Úüèµê»Òü©Òü¿ÕñëÞ▓îÒüÖÒéïÒÇé\nÒü¬Òü£Òü¬ÒéëÒÇüÕçøÒüîµ▒éÒéüÒéïþöÀÒü»ÒÇüÕ¢╝Òü«þá┤µ╗àÒü«ÚüôÕàÀÒü¿Òü¬ÒéèÒÇüÒüéÒéïÒüäÒü»ÒÇüÕ¥®Þ«ÉÒü«ÚìÁÒü¿Òü¬ÒéïÒüïÒééÒüùÒéîÒü¬ÒüäÒüïÒéëÒüáÔÇª\n­ƒºæÔÇì­ƒñØÔÇì­ƒºæ õ©╗ÞªüþÖ╗Õá┤õ║║þë®\n­ƒî© Õçø´╝êÒéèÒéô´╝ë ´╝ê20µ¡│´╝ë\n * Þè▒Òü«Õ«ÂÒü«Þè©ÞÇàÒÇéÚ¡àõ║åÒü«ÞíôÒÇüÚ¡öÞê×ÒÇüµëçÒéÆõ¢┐ÒüúÒüƒµêªÚùÿÒü½ÚòÀÒüæÒéïÒÇé\n * Þ║½õ¢ôµø©Úüô´╝êÒüïÒéëÒüáÒüùÒéçÒü®Òüå´╝ëÒü«Úüöõ║║´╝ÜÕÀ▒Òü«ÞéîÒü«õ©èÒü½Õæ¬µûçÒéÆÞ©èÒéëÒüøÒÇüµ£êÕàëÒü«õ©ïÒüºþø«ÞªÜÒéüÒéïÞªïÒüêÒüûÒéïµ╝óÕ¡ùÒéÆÕê╗ÒéÇÒÇé\n * µÿÄµÖ░ÒÇüµé¬µê»ÕÑ¢ÒüìÒüºõ║║ÒéÆµâ╣ÒüìÒüñÒüæÒéïÒüîÒÇüþªüÒüÿÒéëÒéîÒüƒÕ«ÂÒü«Õ¡ñÕàÉÒü¿ÒüäÒüåµÜùÒüäÚüÄÕÄ╗ÒéÆÚÜáÒüùÒüªÒüäÒéïÒÇéÚÅíÒâÄÕñ¬ÕêÇÒü«þºÿÕ»åÒéÆþƒÑÒéïÒÇé\n * ÕÄ│µá╝Òü¬ÕÉîµÇºµäøÞÇàÒüºÒüéÒéèÒÇüÒâªÒéªÒâèÒü©Òü«µüïµäøµäƒµâàÒü»Òü¬Òüä´╝êÕàäÕª╣Òü«ÒéêÒüåÒü¬þÁåÒéÆÞé▓ÒéÇ´╝ëÒÇé\n­ƒÉë Õ░åÞ╗ìÒâ╗þºïÕ╝ÿ þâê´╝êÒüéÒüìÒü▓ÒéìÒâ╗ÒéîÒüñ´╝ë ´╝ê30µ¡│´╝ë\n * Õ©ØÕø¢ÒéÆþÁ▒Òü╣Òéïµ£ÇÚ½ÿÞ╗ìõ║ïµîçÕ░ÄÞÇàÒÇéõ║öÕñºÕàâþ┤áÕ«ÂÒü½ÒéêÒüúÒüªÕØçÞííÒéÆõ┐ØÒüñÒüƒÒéüÒü½Úü©Òü░ÒéîÒüƒÒÇé\n * ÕåÀÕ¥╣ÒÇüÕ¿üÕÄ│ÒüîÒüéÒéèÒÇüÞ┐æÕ»äÒéèÒüîÒüƒÒüäÒÇéþÁÂÕ»¥þÜäÒü¬ÕèøÒü«Þ▒íÕ¥┤ÒüºÒüéÒéïÚ╗ÆÒüäõ╗«ÚØóÒéÆµ╗àÕñÜÒü½ÕñûÒüòÒü¬ÒüäÒÇé\n * þªüµû¡Òü«õ©ÇµûçÕ¡ùÒéÆµôìÒéïÒÇéÒüØÒü«µûçÕ¡ùÒü»**ÒÇîþäíÒÇì**´╝ÜÕæ¬µûçÒéÆÕ╝òÒüìÞúéÒüìÒÇüµäƒµâàÒéÆþäíÕè╣ÕîûÒüùÒÇüÞéëõ¢ôÒéÆþáòÒüÅÕèøÒéÆµîüÒüñÒÇé\n * Õ¡ñþï¼ÒÇüµêªÒÇüÒüØÒüùÒüªÕÀ▒ÒéÆÒüƒÒüáÒü«**ÒÇîµ¡ªÕÖ¿ÒÇì**Òü¿ÒüùÒüïÞªïÒü¬Òüäõ©ûþòîÒü©Òü«Þïøþ½ïÒüíÒéÆþƒÑÒéïÒÇé\n * ÕçøÒü©Òü«ÚûóÕ┐âÒü»ÕƒÀþØÇÒü©Òü¿ÕñëÒéÅÒüúÒüªÒüäÒüÅÒÇé\nÔÜö´©Å Õ¥üµ£¿´╝êÒüøÒüäÒüì´╝ëÒâÄÒâªÒéªÒâè ´╝ê27µ¡│´╝ë\n * þü½Òü«Õ«ÂÒü«õ╝ØÞ¬¼þÜäÒü¬Õ░åÞ╗ìÒÇéµáäÕàëÒü½ÕîàÒü¥ÒéîÒüªÕ©░ÚéäÒüÖÒéïÒééÒÇüµêªÕ¢╣Òü«Õ¢▒Òü½ÞïøÒü¥ÒéîÒéïÒÇé\n * Õøáþ┐ÆÒéÆµïÆÒéÇÒÇéþöÀþë®Òü«ÚÄºÒéÆþ║ÅÒüåÒüîÒÇüÒüØÒü«Þê×Òü»ÕÑ│Õ©ØÒü«Õä¬ÚøàÒüòÒéÆõ¢ÁÒüøµîüÒüñÒÇé\n * µäøÕêÇÒü»Õæ¬µûçÒéÆÕ«┐ÒüÖ´╝Üµî»ÒéïÒüåÒüƒÒü│Òü½þÑ×ÞüûÒü¬Õñ¬Ú╝ôÒü«Úƒ│ÒüîÚƒ┐ÒüÅÒÇé\n * µ¡ªõ║║Òü«ÕÄ│ÒüùÒüòÒü«õ©ïÒü½ÒÇüµ£¼Þâ¢þÜäÒü¬þ╣ïÒüîÒéèÒÇüÞª¬Õ»åÒüòÒÇüÕä¬ÒüùÒüòÒéÆµ▒éÒéüÒéïÒÇé\n­ƒæ╣ Ú╗ÆÞÀ»´╝êÒüÅÒéìÒüÿ´╝ëÕ©½\n * õ©ÇÞªïµ©®ÕÄÜÒü¬Õâºõ¥ÂÒüáÒüîÒÇüÒüØÒü«Õ«ƒµàïÒü»Õ¢▒Òü«Õ«ÂÒü«ÕÅ¼õ¢┐ÒÇé\n * ÕäÇÕ╝ÅÒéÆµôìÒéèÒÇüÕçøÒü«Þéëõ¢ôÒü½ÚÜáÒüòÒéîÒüƒÕÅñõ╗úÒü«þºÿÕ«ØÒéÆþø«ÞªÜÒéüÒüòÒüøÒéêÒüåÒü¿ÒüÖÒéïÔÇª\n­ƒôÜ þë®Þ¬×µºïµêÉ´╝êµö╣Þ¿éþëê´╝ë\nþ¼¼õ©ÇÕ╣ò ÔÇö ÒÇîþÁ╣´╝êÒüìÒü¼´╝ëÒü«õ©è´╝êÒüåÒüê´╝ëÒü«Õó¿´╝êÒüÖÒü┐´╝ëÒÇì\n * Õ««µ«┐ÒüïÒéëÒü«ÕÅ¼Úøå´╝ÜÕçøÒÇüÕ░åÞ╗ìÒü½Õæ╝Òü░ÒéîÒéïÒÇé\n * ÒÇîþäíÒÇìÒü«õ╗«ÚØó´╝ÜþºïÕ╝ÿÒÇüÕåÀÚàÀþäíµ»öÒü½þÅ¥ÒéîÒéïÒÇé\n * Õó¿Òü¿Þéëõ¢ô´╝ÜÕçøÒü«Õ«ÿÞâ¢þÜäÒü¬ÒéïÚ¡öÞíôÒü«ÕêØÕÅ¼ÕûÜÒÇé\n * ÕêÇÒü¬Òüìµ▒║Úùÿ´╝ÜÕçøÒü¿þºïÕ╝ÿÒü«ÚûôÒü«Õ╝ÁÒéèÞ®░ÒéüÒüƒõ║ñµÁüÒÇé\n * µ£ÇÕêØÒü«Þéëõ¢ôµÄÑÞºª´╝êÕñó´╝ë´╝ÜÕçøÒÇüÒüéÒéïÕªäµâ│Òü½ÕøÜÒéÅÒéîÒéïÒÇé\nþ¼¼õ║îÕ╣ò ÔÇö ÒÇîÞÖÜþ®║´╝êÒüôÒüÅÒüå´╝ëÒü«µ╝óÕ¡ù´╝êÒüïÒéôÒüÿ´╝ëÒÇì\n * Õ░åÞ╗ìÕ«ÂÒü«ÕäÇÕ╝Å´╝ÜÚÖ░Þ¼ÇÒÇüÕçªÕêæÒÇüÒüØÒüùÒüªÕäÇþñ╝ÕîûÒüòÒéîÒüƒþÑ¡õ║ïÒÇé\n * ÕìâÒü«Þô«´╝êÒü»ÒüÖ´╝ëÒü«µ╣»µ«┐´╝ÜÕçøÒÇüÕ░åÞ╗ìÒü¿Òü«µ▓ÉµÁ┤Òü½µïøÒüïÒéîÒéïÒÇé\n * ÕêâÒü«õ©ïÒü«ÕæèþÖ¢´╝ÜþºïÕ╝ÿÒÇüÚüÄÕÄ╗Òü«µû¡þëçÒéÆµÿÄÒüïÒüÖÒÇé\n * Õ¡ù´╝êÒüéÒüûÒü¬´╝ëÒü«Þ×ìÕÉê´╝ÜÕçøÒÇüÕêØÒéüÒüªþºïÕ╝ÿÒü½Ú¡öÞíôÒü«Õê║ÚØÆÒéÆÕê╗ÒéÇÒÇé\n * ÚÅíÒâÄÕñ¬ÕêÇÒü«Õñ£´╝Üµ┐âÕÄÜÒüºÚ¡öÞíôþÜäÒü¬µâàõ║ñÒü«Õá┤ÒÇé\nþ¼¼õ©ëÕ╣ò ÔÇö ÒÇîµ¼▓µ£øÒü«Õê╗Õì░´╝êÒüùÒéïÒüù´╝ëÒÇì\n * Õâºõ¥ÂÒü«ÞúÅÕêçÒéè´╝ÜÚ╗ÆÞÀ»ÒÇüÕçøÒéÆÕ¬Æõ¢ôÒü½Õñ¬ÕêÇÒéÆÕÅ¼ÕûÜÒüùÒéêÒüåÒü¿õ╝üÒéÇÒÇé\n * õ╗«ÚØó´╝êÒâ×Òé╣Òé»´╝ëÒü«Õ┤®Õúè´╝ÜþºïÕ╝ÿÒÇüµùºõ¢ôÕêÂÒéêÒéèÒééÕçøÒéÆÚü©ÒüÂÒÇé\n * ÒÇîþäíÒÇìÒü¿ÒÇîÞè▒ÒÇì´╝Üõ║îõ║║Òü«Ú¡öÞíôþÜäÒü¬þÁÉÕÉêÒüî**µû░ÒüƒÒü¬õ©ÇµûçÕ¡ùÒÇîµäø´╝êÒüéÒüä´╝ëÒÇì**ÒéÆÕëÁÚÇáÒüÖÒéïÒÇé\n * µ¡╗Òü¿Õà▒Ú│┤´╝êÒüìÒéçÒüåÒéüÒüä´╝ë´╝ÜÕçøÒÇüþºïÕ╝ÿÒéÆµòæÒüåÒüƒÒéüÒü½Þç¬ÒéëÒü«ÕèøÒü«õ©ÇÚâ¿ÒéÆþèáþë▓Òü½ÒüÖÒéïÒÇé\n * þÁéþ½á ÔÇö µ£ÇÕ¥îÒü«ÞîÂ´╝êÒüíÒéâ´╝ëÒü«Õ©¡´╝Üõ║îõ║║Òü»ÕåìÕ«Üþ¥®ÒüòÒéîÒüƒÕ©ØÕø¢ÒéÆÕà▒Òü½þÁ▒µ▓╗ÒüÖÒéïÒÇé\nÔ£ì´©Å µû░ÞªÅµûçõ¢ôÒéÁÒâ│ÒâùÒâ½\n­ƒûï´©Å õ╝ØþÁ▒þÜäÒü¬Õ£░Òü«µûç\nÕ░åÞ╗ìÒü«Õ««µ«┐Òü½Òü»ÒÇüµ▒║ÒüùÒüªÚ½ÿþ¼æÒüäÒüîÚƒ┐ÒüÅÒüôÒü¿Òü»Òü¬ÒüäÒÇéÒüƒÒüáÒÇüÕêÇÒéêÒéèÒééÚï¡ÒüäÚØÖÕ»éÒü«Òü┐ÒüîÕ¡ÿÕ£¿ÒüùÒüƒÒÇé\nþ½╣ÒéÆµëôÒüñÚø¿Òü«ÒéêÒüåÒü½Þ╗¢ÒüäÕçøÒü«ÞÂ│Úƒ│Òü»ÒÇüþ┐íþ┐áÒü«Õ║èÒü«ÚØÖÒüæÒüòÒéÆõ╣▒ÒüòÒü¬ÒüäÒÇé\nÕ¢╝Òü»þƒÑÒüúÒüªÒüäÒüƒÒÇéþÁ╣Òü«Õ©│´╝êÒü¿Òü░Òéè´╝ëÒü«ÕÉæÒüôÒüåÒüºÒÇüþÖ¥Òü«ÚáÿÕ£░ÒéÆþÁ▒Òü╣ÒéïþöÀÒüîÞç¬ÕêåÒéÆÞªïÒüñÒéüÒüªÒüäÒéïÒüôÒü¿ÒéÆÒÇé\nÒüØÒüùÒüªÒÇüÒüƒÒüúÒüƒõ©ÇÞ¿ÇÒÇüÒü▓Òü¿ÕÉÉµü»ÒüºÒÇüÕ¢╝Òü»þä╝ÒüïÒéîÒÇüÒüéÒéïÒüäÒü»Ú½ÿÒéüÒéëÒéîÒéïÒü«ÒüáÒü¿ÒÇé\n­ƒöÑ µû░ÞªÅ µâàõ║ñÒü«µè£þ▓ï ÔÇö Õçø ├ù Õ░åÞ╗ì þºïÕ╝ÿ\nÒÇîÕèøÒÇüµ¼▓ÒüùÒüäÒüï´╝ƒÒÇìþºïÕ╝ÿÒü»ÒÇüÕçøÒü«Úªûþ¡ïÒü½µëïÒéÆµÀ╗ÒüêÒÇüÕøüÒüäÒüƒÒÇé\nÒÇîÒüäÒüäÒüêÒÇìÕçøÒü»ÒÇüµü»ÒéÆõ╣▒ÒüùÒüªþ¡öÒüêÒéïÒÇéÒÇîÞ▓┤µû╣´╝êÒüéÒü¬Òüƒ´╝ëÒü½ÒÇüÒüØÒéîÒéÆÕÑ¬ÒüäÕÅûÒüúÒüªÒü╗ÒüùÒüäÒÇì\nÕ░åÞ╗ìÒü»ÒÇüÕçøÒéÆþò│Òü«õ©èÒü½µè╝ÒüùÕÇÆÒüùÒÇüÕÀ▒Òü«Þà░ÒéÆÕ¢╝Òü«Þà░Òü½µÀ▒ÒüÅµì«ÒüêÒüƒÒÇéÕ¢╝Òü»ÒÇüÕçøÒü«þØÇþë®ÒéÆÕ╝ÀÕ╝òÒü½ÚûïÒüæÒÇüþ¢¬´╝êÒüñÒü┐´╝ëÒü«µ╝óÕ¡ùÒüîÚ««ÒéäÒüïÒü½ÕàëÒéïÞâ©ÕàâÒéÆÚ£▓ÕæêÒüòÒüøÒüƒÒÇé\nÕ¢╝Òü»ÒÇüÒü╗Òü¿ÒéôÒü®þÑ×ÞüûÒü¬Òü╗Òü®Òü«µ¡úþó║ÒüòÒüºÒÇüÒéåÒüúÒüÅÒéèÒü¿Õ¢╝ÒéÆÞ▓½ÒüäÒüƒÒÇéÕçøÒü»ÒÇüþùøÒü┐ÒüºÒü»Òü¬ÒüÅþïéÕû£Òü½ÕÅ½Òü│ÒÇüÚ¡öµ│òÒüîÕ¢╝ÒéëÒü«µÀÀÒüûÒéèÕÉêÒüúÒüƒÞéîÒü«õ©èÒü½Ú╗äÚçæÒü«Õì░ÒéÆÕê╗Òü┐Òü¬ÒüîÒéëµ║óÒéîÕç║ÒüùÒüƒÒÇé\nÒÇîÒééÒüúÒü¿Õ╝ÀÒüÅÔÇªþºüÒéÆþäíÕÅúÒü½ÒüùÒüªÔÇªÒÇì\nÕ░åÞ╗ìÒü»Õ¢╝Òü½ÕÅúÒüÑÒüæÒÇüÒüØÒü«ÕÅúÒüÑÒüæÒü«õ©¡ÒüºÒÇüµ▓êÚ╗ÖÒü»þÑêÒéèÒü©Òü¿ÕñëÒéÅÒüúÒüƒÒÇé	Japonais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-22 09:25:03.354+00	2025-10-22 07:28:51.905459+00	\N	1. ÕêØþ½áÒü«ÞäåÒüò´╝ÜÕçøÒü»Õ««µ«┐Òü«ÕäÇÕ╝ÅÒü½µ▒éÒéüÒéëÒéîÒéïÕ«îþÆºÒüòÒü½ÕÇªÕÄ¡ÒüùÒü¬ÒüîÒéëÒééÒÇüþºïÕ╝ÿÒü«ÒÇîþäíÒÇìÒü«þºÿÞíôÒü«ÞúÅÒü½Õ«┐ÒéïÕ¡ñþï¼Òü«õ©ÇÞ¥À´╝êÒüäÒüíÒüÖÒüä´╝ëÒéÆÞ¬¡Òü┐ÕÅûÒéïÒÇé  \n2. þâêÞÅ»´╝êÒéîÒüúÒüï´╝ëÒü«þ½Âµ╝ö´╝Üþü½ÒâÄÕ«ÂÒü«ÒâªÒéªÒâèÒüîÕÅéÕåàÒüùÒÇüÞªûþÀÜÒü«µêªÒüîÕ▒ò´╝êÒü«´╝ëÒü│ÒéïÞîÂÕ©¡ÒüºÒÇüÕçøÒü«þ£╝ÕÀ«ÒüùÒüîþºïÕ╝ÿÒéÆµÅ║ÒüòÒüÂÒéïÒÇé  \n3. ÞúéÕ©ø´╝êÒéîÒüúÒü▒ÒüÅ´╝ëÒü«Õê╗´╝ÜÚ╗ÆÞÀ»Õ©½Òü«ÚøøÕªô´╝êÒüíÒüö´╝ëÚüôÒüîÞ┐½Òéïõ©¡ÒÇüÕçøÒü«ÞéîÒü½Õ«┐ÒéïÕÅñõ╗úµûçÕ¡ùÒüîµ£êÕàëÒéÆÚü┐ÒüæÒüªÞÀ│´╝êÒü»´╝ëÒü¡ÒéïÒÇé  \n4. µ«ïþü½´╝êÒüûÒéôÒüï´╝ëÒü«Õñ£µâ│´╝ÜþºïÕ╝ÿÒü«õ╗«ÚØóÒü«ÞúÅÒü½þºÿÒéüÒéëÒéîÒüƒþü╝þå▒Òü«ÚüÄÕÄ╗ÒéÆÕ×úÚûôÞªïÒüƒÕçøÒüîÒÇüÕ┐âÒü«Úÿ▓ÕúüÒü½õ║ÇÞúéÒéÆµäƒÒüÿÒéïÒÇé  \n5. ÚÅíþáò´╝êÒüìÒéçÒüåÒüïÒüä´╝ëÒü«Õ║Åµø▓´╝ÜÕ¢▒ÒâÄÚ¡öÞíôÕ©½ÒüƒÒüíÒüîµ¢£ÕàÑÒüùÒüƒÕ╗À´╝êÒüªÒüä´╝ëÒü«Õ«┤ÒüºÒÇüÕçøÒü«Þê×ÒüîÕ»¥µèùÕæ¬µûçÒéÆµÜ┤ÞÁ░ÒüòÒüøÒéïÒÇé  \n6. þäöwithin´╝êÒü╗ÒéÇÒüò´╝ëÒü«ÕÑæµ®ƒ´╝ÜþºïÕ╝ÿÒüîÞç¬Þ║½Òü«Þéëõ¢ôÒü½ÒÇîþäíÒÇìÒü«Õ░üÕì░ÒéÆÞºúÒüìÒÇüÕçøÒü¿Òü«RoomÒü½Õ┤®ÒéîÒüƒþº®Õ║ÅÒü«ÞâÄÕïòÒüîÕºïÒü¥ÒéïÒÇé  \n7. µ│úÕ¢®´╝êÒéîÒüäÒüòÒüä´╝ëÒü«Þú©Õ¢ó´╝ÜÞè▒ÒâÄÚçîÒü«þºÿÕ«ØÒéÆµ▒éÒéüÒéïÕê║Õ«óÒüƒÒüíÒü¿Õ»¥Õ│ÖÒüùÒÇüÕçøÒüîÕ«ƒÕ«ÂÒâÄµû¡þëçÒéÆÞíÇµûçÕ¡ùÒüºµø©ÒüìÞ¿ÿÒüÖÒÇé  \n8. Ú╗ÖÞíî´╝êÒééÒüúÒüôÒüå´╝ëÒü«ÚÖ░µ│ò´╝ÜÒâªÒéªÒâèÒüîþºïÕ╝ÿÒü«ÕÄ│µ¿®´╝êÒüÆÒéôÒüæÒéô´╝ëÒéÆÕòÅÒüåµ¬ä´╝êÒüÆÒüì´╝ëµûçÒéÆµû¡ÒüíÒÇüõ©âÕ║ªÒü«µêªÒü«Õ«┐Õ┐ÁÒüîÕåìþçâÒÇé  \n9. Þ╝¬Õ╗╗´╝êÒéèÒéôÒü¡´╝ëÒü«ÞúéÕéÀ´╝ÜÚ╗ÆÞÀ»Õ©½Òü«Õ░ÄÒüÅÕ£░õ©ïÕ««´╝êÒüíÒüïÒü┐Òéä´╝ëÒüºÒÇüÕçøÒü«ÞªÜÚåÆÒüòÒéîÒüƒÕæ¬µûçÒüîõ║îõ║║ÒéÆµÖéÚûôÒü«Þúéþ╝ØÒü½µèòÒüÆÕàÑÒéîÒéïÒÇé  \n10. Þ╝¬Òé┐ÒâüÒü«Ú╗ÄµÿÄ´╝ÜþºïÕ╝ÿÒü«õ╗«ÚØóÒü»ÞÉ¢Òü¿ÒüòÒéîÒÇüÒÇîþäíÒÇìÒü¿ÒÇîÞè▒ÒÇìÒüïÒéëþ╣öÒéèÒü¬ÒüòÒéîÒéïÒÇîµäøÒÇìÒü«µûçÕ¡ùÒüîþëÖÕƒÄ´╝êÒüîÒüÿÒéçÒüå´╝ëÒéÆþä╝ÒüìÕ░¢ÒüÅÒüÖÒÇé	t
4a440939-d2e6-43a7-84fc-2782177bc172	212cdfee-bdfd-4a38-affd-7546df01cc02	Alexandre ├á Paris	Natif	Slice of Life	adaptation entre Paris et l'Espagne (Grenade), d'Alexandre un ing├®nieur fran├ºais de 27 ans\n\n(utilise think r├®flexion)	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-24 14:44:40.211+00	2025-10-24 10:56:48.780262+00	\N	1. Alexandre se perd dans les ruelles de Grenade, incapable de commander un caf├® sans m├®langer fran├ºais et espagnol maladroits.  \n2. Un coll├¿gue local lui explique que "├á demain" ici signifie "peut-├¬tre dans trois jours", bouleversant son planning dÔÇÖing├®nieur rigoureux.  \n3. Une voisine octog├®naire lÔÇÖinitie au rythme des siestas, lui faisant manquer un appel crucial de son bureau parisien.  \n4. Il tente de r├®parer une prise ├®lectrique standard fran├ºaise dans un logement aux normes andalouses, provoquant une coupure g├®n├®rale.  \n5. Une danseuse de flamenco sarcastique corrige son accent en ├®change de le├ºons de paso doble sous les arcades du Sacromonte.  \n6. Son projet dÔÇÖoptimisation ├®nerg├®tique est rejet├® car "trop froid" pour lÔÇÖ├óme chaude des maisons grenadines.  \n7. Une invitation improvis├®e ├á un mariage familial le force ├á danser le sevillanas jusquÔÇÖ├á lÔÇÖaube, ├®puisant son rythme parisien.  \n8. Une pluie torrentielle inonde son appartement, r├®v├®lant que les anciens murs mauresques ne suivent pas ses calculs dÔÇÖ├®tanch├®it├®.  \n9. Il ach├¿te par erreur dix kilos dÔÇÖalmond pour une recette de turr├│n, d├®clenchant une s├®ance de cuisine collective avec ses voisins.  \n10. Assis sur lÔÇÖAlba├»c├¡n au coucher du soleil, il r├®alise que ses racines parisiennes et ses nouvelles cicatrices andalouses forment une carte in├®dite.	t
c9b1255a-0a71-493b-8048-8e69a9d9b6a0	212cdfee-bdfd-4a38-affd-7546df01cc02	Samoura├»	N4	Fantasy	samoura├» qui fait du kyokushin	Japonais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-24 13:59:36.794+00	2025-10-24 13:40:52.127524+00	\N	1. Õ¢╝Òü»ÒÇüµØæÒéÆÞÑ▓ÒüúÒüƒÞ¼ÄÒü«µÜùµ«║ÞÇàÒü¿Òü«µêªÒüäÒüºÕÅñÕéÀÒéÆÞ▓áÒüäÒÇüÞç¬ÕêåÒüîõ¢òÞÇàÒü½þïÖÒéÅÒéîÒüªÒüäÒéïÒü«ÒüïÒéÆµÄóÒéïµ▒║µäÅÒéÆÒüÖÒéïÒÇé  \n2. Õ╗âÕ»║Òü½ÚÜáÒüòÒéîÒüƒþêÂÒü«Úü║ÕôüÒü«õ©¡ÒüïÒéëÒÇüÞ¼ÄÒü«Ú╗ÆÒüäÕêÇÒü¿þçâÒüêÒéïÒéêÒüåÒü¬µûçÕ¡ùÒüîÕê╗Òü¥ÒéîÒüƒµ£¡ÒéÆþÖ║ÞªïÒüÖÒéïÒÇé  \n3. ÕêÇÒü«µîüÒüíõ©╗ÒüîÒüïÒüñÒüªÒÇîÚ¼╝µû¼ÒéèÒÇìÒü¿Õæ╝Òü░ÒéîÒüƒµ¡ªÕú½ÒüºÒüéÒéèÒÇüÒüØÒü«Õæ¬ÒéÅÒéîÒüƒÚüÄÕÄ╗Òü½Þç¬ÕêåÞç¬Þ║½ÒüîþÁÉÒü│ÒüñÒüæÒéëÒéîÒüªÒüäÒüƒÒüôÒü¿ÒéÆþƒÑÒéïÒÇé  \n4. Õæ¿Þ¥║Òü«µØæÒÇàÒüºÞÁÀÒüôÒéïþò░ÕñëÒéÆÒüƒÒü®ÒéèÒÇüÞìÆÕ╗âÒüùÒüƒÕ▒▒õ©¡Òü½ÒüéÒéïÚé¬µòÖÒü«þùòÞÀíÒü½Úü¡ÚüçÒüÖÒéïÒÇé  \n5. Úé¬µòÖÒü«ÕÅ©þÑ¡ÒüîµÜ┤ÞÁ░ÒüÖÒéïÚ¡öþë®ÒéÆµôìÒéèÒÇüÕêÇÒéÆþïÖÒüúÒüªÕà▒ÕÉîõ¢ôÒéÆþá┤ÕúèÒüùÒüªÒüäÒéïÒüôÒü¿Òü½µ░ùÒüÑÒüìÒÇüõ╗▓ÚûôÒéÆÚøåÒéüÕºïÒéüÒéïÒÇé  \n6. Ú¡öþë®Òü«ÞÑ▓µÆâÒéÆÕÅùÒüæÒüƒÚçîÒüºÒÇüþªüµû¡Òü«ÒÇîÞíÇÒü«ÚìøÚî¼ÒÇìÒü½ÒéêÒüúÒüªÕâàÒüïÒü¬Õ©îµ£øÒéÆµÄ┤Òü┐µî½ÒüæÒüØÒüåÒü½Òü¬ÒéïÒÇé  \n7. õ©╗õ║║Õà¼Òü«ÕëúÒü½Õ«┐ÒéïÕæ¬ÒüäÒüîÕ¢╝Þç¬Þ║½ÞØòÒü┐ÕºïÒéüÒÇüÕ╣╗ÞªÜÒü«õ©¡ÒüºþêÂÒü«õ©ìÕÉìÞ¬ëÒü¬µ¡╗Òü«þ£ƒþø©Òü¿ÕÉæÒüìÕÉêÒüåÒÇé  \n8. ÒüïÒüñÒüªÒü«Õ©½ÒüºÒüéÒéèµòÁÒüºÒééÒüéÒéïµ¡ªõ║║Òâ╗þäíµ«ïµûÄÒü¿Òü«µ¡╗ÚùÿÒü½µòùÒéîÒÇüÒüÖÒü╣ÒüªÒéÆÕñ▒ÒüúÒüƒÕá┤µëÇÒüºÕÀ▒Òü«µ¡ªÕú½ÚüôÒéÆÕåìµºïþ»ëÒüÖÒéïÒÇé  \n9. Úé¬µòÖÒü½ÕøÜÒéÅÒéîÒüƒÚçîÕ¿ÿÒü«µòæÕç║ÒéÆÞ®ªÒü┐ÒÇüµòÁÒü«µ£¼µïáÕ£░Õ£░õ©ïþÑ×µ«┐ÒüºÒü«þ¡ûþòÑÒü½µ░ùõ╗ÿÒüìµ¢£ÕàÑÒüÖÒéïÒÇé  \n10. ÒééÒüåõ©ÇÒüñÒü«ÒÇîÚ¼╝µû¼ÒéèµÁüÒÇìÒü«Õ╣©Õ¡ÿÞÇàÒü¿Õ»¥Õ│ÖÒüùÒÇüõ║îÒüñÒü«ÕêÇÒéÆÕÀíÒéïµ£ÇþÁéÚü©ÕêÑÒüîÞç¬ÒéëÒü«Õ«┐Õæ¢Òü«µá©ÒéÆÚ£▓ÒéÅÒü½ÒüÖÒéïÒÇé	t
655b112d-df6f-4398-9044-f7cba93a87e5	212cdfee-bdfd-4a38-affd-7546df01cc02	Perdue ├á Chicago	Natif	Slice of Life	A├»ko est perdue ├á chicago en voiture en rentrant au Canada mais sa voiture tombe en panne et elle rencontre Trump dans un h├┤tel	Fran├ºais	\N	A├»ko a quitt├® Toronto en direction de lÔÇÖOntario, mais sa voiture a panne en route, la for├ºant ├á trouver refuge dans un h├┤tel de Chicago. Le lendemain matin, apr├¿s une nuit dÔÇÖincertitude et de r├®flexion, elle se rend ├á pied ├á un garage pour faire r├®parer sa voiture. Elle en profite pour explorer le quartier, se perdre dans l'effervescence de la ville, et re├ºoit un coup de t├®l├®phone r├®confortant de sa s┼ôur Sarah. Au garage, le m├®canicien diagnostique un probl├¿me de batterie et dÔÇÖalternateur, et propose de les remplacer, ce qui prendra environ deux heures. A├»ko d├®cide de profiter de lÔÇÖattente en se promenant dans un parc proche, se laissant bercer par le calme et la beaut├® du lieu. Elle y r├®fl├®chit ├á sa vie, ├á sa famille, et aux le├ºons tir├®es de ces derniers ├®v├®nements. Apr├¿s avoir r├®cup├®r├® sa voiture r├®par├®e, elle se pr├®pare ├á reprendre la route vers Toronto, d├®termin├®e ├á continuer son voyage malgr├® les emb├╗ches. Cependant, en soir├®e, elle se perd ├á nouveau dans les rues tortueuses de Chicago, se sentant de plus en plus ├®puis├®e. Elle d├®cide finalement de s'arr├¬ter pour la nuit dans un h├┤tel ├®l├®gant, o├╣ elle trouve un moment de repos et de r├®pit. Le lendemain matin, r├®veill├®e par les premiers rayons du soleil, A├»ko profite d'un petit-d├®jeuner paisible dans le restaurant de l'h├┤tel, o├╣ elle croise Donald Trump par hasard. Apr├¿s cette rencontre inattendue, elle sort de l'h├┤tel, retrouve son courage et se dirige ├á nouveau vers le garage pour finir les r├®parations, pr├¬te ├á affronter les d├®fis qui l'attendent.	qwen/qwen-2.5-72b-instruct	2025-11-09 23:20:45.79+00	2025-11-09 22:04:42.646904+00	\N	1. A├»ko, ├®puis├®e par son voyage, cherche un h├┤tel pour se reposer, mais se perd dans les rues de Chicago.\n2. Apr├¿s plusieurs tentatives infructueuses, elle s'arr├¬te dans un garage pour r├®parer sa voiture en panne.\n3. Le m├®canicien, un homme sympathique, lui offre de l'aide et sugg├¿re un h├┤tel proche o├╣ elle pourrait passer la nuit.\n4. A├»ko arrive ├á l'h├┤tel, int├®grant ses environs avec un m├®lange d'appr├®hension et d'excitation.\n5. Au comptoir de r├®ception, elle rencontre un homme d'affaires ├®l├®gant et charismatique qui se pr├®sente comme Donald Trump.\n6. Intrigu├®e et surprise, A├»ko accepte l'invitation de Trump pour boire un verre dans le bar de l'h├┤tel.\n7. Au fil de la conversation, elle d├®couvre que Trump est en ville pour un rassemblement politique et partage son parcours et ses ambitions.\n8. A├»ko, touch├®e par sa bienveillance, accepte son offre de l'aider ├á localiser un garage de confiance pour r├®parer sa voiture.\n9. Le lendemain, Trump l'accompagne personnellement au garage et lui pr├®sente le m├®canicien recommand├®.\n10. Avec sa voiture r├®par├®e et un sentiment de gratitude, A├»ko reprend la route vers le Canada, enrichie par cette ├®trange rencontre.	t
0ecbf452-250b-4ce2-aa00-f40c41977bd9	1981ba9f-2416-40b0-b484-8f33e2242d66	Les petites voix de notre t├¬te	Natif	Philosophie	l'histoire se passe dans le cerveau de quelqu'un. les personnages sont des d├®cideurs, l'un ├á les commandes sur le corps (agissements et parole) et l'autre nous conseille, un peu comme notre petite voix. D'autres personnages font partie du processus dans le cerveau, chacun ├á son role (├®motions, m├®moire, souvenirs etc.).\nLa personne vit des moments qui l'am├¿ne ├á beaucoup penser, se faire peur, s'auto convaincre que tout va bien ou que tout va mal. On se plonge dans les dessous de ses d├®cisions, influenc├®s par ce qu'il ressent et les agissement des personnages dans son cerveaux.	Fran├ºais	\N	Le roman vient de commencer.	qwen/qwen3-235b-a22b:free	2025-10-22 09:29:05.231+00	2025-10-22 07:29:42.025104+00	\N	1. L'├®chec d'une pr├®sentation professionnelle oppose Le Directeur, exigeant une r├®p├®tition obsessionnelle, ├á La Conseill├¿re qui d├®fend l'acceptation de l'erreur.  \n2. Une nuit d'insomnie ravive par L'├ëmotionnel amplifie des souvenirs d'humiliations pass├®es jusqu'├á paralyser les prises de parole.  \n3. La M├®moire ressuscite un traumatisme scolaire pour justifier chaque h├®sitation face aux regards ext├®rieurs.  \n4. Le Directeur, submerg├®, annule un rendez-vous crucial, d├®clenchane querelle sur la fuite comme se de se.  \n5. Une confrontation avec un coll├¿gue tourne ├á la paralysie corporelle devant l'affrontement entre agressivit├® et autocritique.  \n6. Une crise d'angoisse en pleine rue pousse La Conseill├¿re ├á questionner le mythe du contr├┤le total sur les ├®v├®nements.  \n7. La M├®moire, malgr├® L'├ëmotionnel, exhume un souvenibli├® de r├®silience apr├¿s un ├®chec adolescent.  \n8. Une m├®diation p├®nible entre instances c├®r├®brales ├®labore une strat├®gie hybride : agir sans nier l'incertitude.  \n9. Une seconde pr├®sentation r├®ussit partiellement, mais les voix s'acharnent ├á red├®finir ce qu'est un "succ├¿s".  \n10. Le protagoniste accepte que l'├®quilibre soit une n├®gociation permanente, non une victoire d├®finitive des d├®cideurs.	t
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, first_name, last_name, status, is_admin, created_at, updated_at, email, is_vip) FROM stdin;
53b4cf7c-3770-4c4b-80e9-7c9ebc2066bd	Alexandre	Grondin	approved	f	2025-10-24 10:47:43.272165+00	2025-10-24 10:47:57.084161+00	alexandregrondin123@gmail.com	f
4796942f-f64e-4f89-9c05-c62bbaf33ff4	A├»ko	Outmonmon	approved	f	2025-10-20 07:41:18.915224+00	2025-11-10 15:21:15.978904+00	adixi.night@gmail.com	t
1981ba9f-2416-40b0-b484-8f33e2242d66	Enzo	Soum	approved	f	2025-10-22 07:12:35.06834+00	2025-11-10 16:00:51.903939+00	esoum18@gmail.com	f
a773f6e9-aad0-43f1-a8e0-ef5320dae958	Nathalie	Devillers	approved	f	2025-11-10 15:46:51.595498+00	2025-11-10 16:23:48.925412+00	ndevillers21@gmail.com	t
212cdfee-bdfd-4a38-affd-7546df01cc02	Nathan	Grondin	approved	t	2025-10-19 18:14:05.359167+00	2025-11-10 23:19:23.023537+00	nathangrondin683@gmail.com	t
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-10-17 13:30:55
20211116045059	2025-10-17 13:30:57
20211116050929	2025-10-17 13:30:59
20211116051442	2025-10-17 13:31:00
20211116212300	2025-10-17 13:31:02
20211116213355	2025-10-17 13:31:04
20211116213934	2025-10-17 13:31:06
20211116214523	2025-10-17 13:31:08
20211122062447	2025-10-17 13:31:10
20211124070109	2025-10-17 13:31:11
20211202204204	2025-10-17 13:31:13
20211202204605	2025-10-17 13:31:14
20211210212804	2025-10-17 13:31:19
20211228014915	2025-10-17 13:31:21
20220107221237	2025-10-17 13:31:23
20220228202821	2025-10-17 13:31:24
20220312004840	2025-10-17 13:31:26
20220603231003	2025-10-17 13:31:28
20220603232444	2025-10-17 13:31:30
20220615214548	2025-10-17 13:31:32
20220712093339	2025-10-17 13:31:34
20220908172859	2025-10-17 13:31:35
20220916233421	2025-10-17 13:31:37
20230119133233	2025-10-17 13:31:38
20230128025114	2025-10-17 13:31:40
20230128025212	2025-10-17 13:31:42
20230227211149	2025-10-17 13:31:44
20230228184745	2025-10-17 13:31:46
20230308225145	2025-10-17 13:31:47
20230328144023	2025-10-17 13:31:49
20231018144023	2025-10-17 13:31:51
20231204144023	2025-10-17 13:31:53
20231204144024	2025-10-17 13:31:55
20231204144025	2025-10-17 13:31:56
20240108234812	2025-10-17 13:31:58
20240109165339	2025-10-17 13:31:59
20240227174441	2025-10-17 13:32:02
20240311171622	2025-10-17 13:32:05
20240321100241	2025-10-17 13:32:08
20240401105812	2025-10-17 13:32:13
20240418121054	2025-10-17 13:32:15
20240523004032	2025-10-17 13:32:21
20240618124746	2025-10-17 13:32:22
20240801235015	2025-10-17 13:32:24
20240805133720	2025-10-17 13:32:25
20240827160934	2025-10-17 13:32:27
20240919163303	2025-10-17 13:32:29
20240919163305	2025-10-17 13:32:31
20241019105805	2025-10-17 13:32:32
20241030150047	2025-10-17 13:32:38
20241108114728	2025-10-17 13:32:41
20241121104152	2025-10-17 13:32:42
20241130184212	2025-10-17 13:32:44
20241220035512	2025-10-17 13:32:46
20241220123912	2025-10-17 13:32:47
20241224161212	2025-10-17 13:32:49
20250107150512	2025-10-17 13:32:51
20250110162412	2025-10-17 13:32:52
20250123174212	2025-10-17 13:32:54
20250128220012	2025-10-17 13:32:55
20250506224012	2025-10-17 13:32:57
20250523164012	2025-10-17 13:32:58
20250714121412	2025-10-17 13:33:00
20250905041441	2025-10-17 13:33:01
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-10-17 13:30:53.213891
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-10-17 13:30:53.220702
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-10-17 13:30:53.228999
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-10-17 13:30:53.253835
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-10-17 13:30:53.326385
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-10-17 13:30:53.331586
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-10-17 13:30:53.338547
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-10-17 13:30:53.344888
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-10-17 13:30:53.349344
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-10-17 13:30:53.354747
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-10-17 13:30:53.360693
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-10-17 13:30:53.372228
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-10-17 13:30:53.380245
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-10-17 13:30:53.385461
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-10-17 13:30:53.38989
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-10-17 13:30:53.415228
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-10-17 13:30:53.420743
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-10-17 13:30:53.42533
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-10-17 13:30:53.430332
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-10-17 13:30:53.439671
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-10-17 13:30:53.44501
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-10-17 13:30:53.454183
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-10-17 13:30:53.469957
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-10-17 13:30:53.482372
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-10-17 13:30:53.487738
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-10-17 13:30:53.491979
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-10-17 13:30:53.497144
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-10-17 13:30:53.510276
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-10-17 13:30:55.578973
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-10-17 13:30:55.587336
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-10-17 13:30:55.59563
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-10-17 13:30:55.610216
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-10-17 13:30:55.618932
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-10-17 13:30:55.626382
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-10-17 13:30:55.628422
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-10-17 13:30:55.634645
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-10-17 13:30:55.640818
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-10-17 13:30:55.647918
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-10-17 13:30:55.653458
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-10-17 13:30:55.663011
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-10-17 13:30:55.668102
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-10-17 13:30:55.67843
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-10-17 13:30:55.683936
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-10-17 13:30:55.69121
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 369, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: chapters chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: friendships friendships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendships
    ADD CONSTRAINT friendships_pkey PRIMARY KEY (user_id_1, user_id_2);


--
-- Name: novel_collaborators novel_collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novel_collaborators
    ADD CONSTRAINT novel_collaborators_pkey PRIMARY KEY (novel_id, collaborator_id);


--
-- Name: novels novels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novels
    ADD CONSTRAINT novels_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_email_key UNIQUE (email);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_chapters_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chapters_created_at ON public.chapters USING btree (created_at);


--
-- Name: idx_chapters_novel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chapters_novel_id ON public.chapters USING btree (novel_id);


--
-- Name: idx_collaborators_novel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collaborators_novel_id ON public.novel_collaborators USING btree (novel_id);


--
-- Name: idx_collaborators_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collaborators_user_id ON public.novel_collaborators USING btree (collaborator_id);


--
-- Name: idx_feedbacks_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feedbacks_created_at ON public.feedbacks USING btree (created_at DESC);


--
-- Name: idx_feedbacks_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feedbacks_status ON public.feedbacks USING btree (status);


--
-- Name: idx_feedbacks_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feedbacks_user_id ON public.feedbacks USING btree (user_id);


--
-- Name: idx_friendships_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_friendships_status ON public.friendships USING btree (status);


--
-- Name: idx_friendships_user1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_friendships_user1 ON public.friendships USING btree (user_id_1);


--
-- Name: idx_friendships_user2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_friendships_user2 ON public.friendships USING btree (user_id_2);


--
-- Name: idx_novels_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_novels_updated_at ON public.novels USING btree (updated_at DESC);


--
-- Name: idx_novels_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_novels_user_id ON public.novels USING btree (user_id);


--
-- Name: idx_profiles_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_email ON public.profiles USING btree (email);


--
-- Name: idx_profiles_is_vip; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_is_vip ON public.profiles USING btree (is_vip);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: users on_auth_user_updated; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_updated AFTER UPDATE OF email ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_user_email_update();


--
-- Name: friendships update_friendships_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_friendships_updated_at BEFORE UPDATE ON public.friendships FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: novels update_novels_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_novels_updated_at BEFORE UPDATE ON public.novels FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: profiles update_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: chapters chapters_novel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_novel_id_fkey FOREIGN KEY (novel_id) REFERENCES public.novels(id) ON DELETE CASCADE;


--
-- Name: feedbacks feedbacks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: friendships friendships_requester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendships
    ADD CONSTRAINT friendships_requester_id_fkey FOREIGN KEY (requester_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: friendships friendships_user_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendships
    ADD CONSTRAINT friendships_user_id_1_fkey FOREIGN KEY (user_id_1) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: friendships friendships_user_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendships
    ADD CONSTRAINT friendships_user_id_2_fkey FOREIGN KEY (user_id_2) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: novel_collaborators novel_collaborators_collaborator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novel_collaborators
    ADD CONSTRAINT novel_collaborators_collaborator_id_fkey FOREIGN KEY (collaborator_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: novel_collaborators novel_collaborators_novel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novel_collaborators
    ADD CONSTRAINT novel_collaborators_novel_id_fkey FOREIGN KEY (novel_id) REFERENCES public.novels(id) ON DELETE CASCADE;


--
-- Name: novels novels_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novels
    ADD CONSTRAINT novels_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: feedbacks Admins can delete feedbacks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete feedbacks" ON public.feedbacks FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.is_admin = true)))));


--
-- Name: profiles Admins can delete profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete profiles" ON public.profiles FOR DELETE TO authenticated USING (public.is_admin());


--
-- Name: feedbacks Admins can update feedback status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update feedback status" ON public.feedbacks FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.is_admin = true)))));


--
-- Name: feedbacks Admins can view all feedbacks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all feedbacks" ON public.feedbacks FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.is_admin = true)))));


--
-- Name: profiles Allow profile view for self, admins, friends (pending/accepted); Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow profile view for self, admins, friends (pending/accepted)" ON public.profiles FOR SELECT TO authenticated USING (((auth.uid() = id) OR public.is_admin() OR (EXISTS ( SELECT 1
   FROM public.friendships f
  WHERE ((f.status = ANY (ARRAY['accepted'::text, 'pending'::text])) AND (((f.user_id_1 = auth.uid()) AND (f.user_id_2 = profiles.id)) OR ((f.user_id_2 = auth.uid()) AND (f.user_id_1 = profiles.id)))))) OR (EXISTS ( SELECT 1
   FROM (public.novels n
     JOIN public.novel_collaborators nc ON ((n.id = nc.novel_id)))
  WHERE ((n.user_id = auth.uid()) AND (nc.collaborator_id = profiles.id)))) OR (EXISTS ( SELECT 1
   FROM (public.novels n
     JOIN public.novel_collaborators nc ON ((n.id = nc.novel_id)))
  WHERE ((nc.collaborator_id = auth.uid()) AND (n.user_id = profiles.id)))) OR (EXISTS ( SELECT 1
   FROM (public.novel_collaborators nc_viewer
     JOIN public.novel_collaborators nc_profile ON ((nc_viewer.novel_id = nc_profile.novel_id)))
  WHERE ((nc_viewer.collaborator_id = auth.uid()) AND (nc_profile.collaborator_id = profiles.id) AND (nc_viewer.collaborator_id <> nc_profile.collaborator_id))))));


--
-- Name: novel_collaborators Owners and Admins can manage collaborators; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Owners and Admins can manage collaborators" ON public.novel_collaborators TO authenticated USING (public.check_collaborator_policy_access(novel_collaborators.*)) WITH CHECK (public.check_collaborator_policy_access(novel_collaborators.*));


--
-- Name: novel_collaborators Owners and Admins can view collaborators; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Owners and Admins can view collaborators" ON public.novel_collaborators FOR SELECT TO authenticated USING (public.check_collaborator_policy_access(novel_collaborators.*));


--
-- Name: chapters Users and Admins can delete chapters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can delete chapters" ON public.chapters FOR DELETE TO authenticated USING ((public.is_admin() OR (EXISTS ( SELECT 1
   FROM public.novels n
  WHERE ((n.id = chapters.novel_id) AND (n.user_id = auth.uid()))))));


--
-- Name: novels Users and Admins can delete novels; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can delete novels" ON public.novels FOR DELETE TO authenticated USING (((auth.uid() = user_id) OR public.is_admin()));


--
-- Name: chapters Users and Admins can insert chapters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can insert chapters" ON public.chapters FOR INSERT TO authenticated WITH CHECK ((public.is_admin() OR (EXISTS ( SELECT 1
   FROM public.novels n
  WHERE ((n.id = chapters.novel_id) AND (n.user_id = auth.uid()))))));


--
-- Name: chapters Users and Admins can update chapters; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can update chapters" ON public.chapters FOR UPDATE TO authenticated USING ((public.is_admin() OR (EXISTS ( SELECT 1
   FROM public.novels n
  WHERE ((n.id = chapters.novel_id) AND (n.user_id = auth.uid()))))));


--
-- Name: novels Users and Admins can update novels; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can update novels" ON public.novels FOR UPDATE TO authenticated USING (((auth.uid() = user_id) OR public.is_admin())) WITH CHECK (((auth.uid() = user_id) OR public.is_admin()));


--
-- Name: profiles Users and Admins can update profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users and Admins can update profiles" ON public.profiles FOR UPDATE TO authenticated USING (((auth.uid() = id) OR public.is_admin())) WITH CHECK (((auth.uid() = id) OR public.is_admin()));


--
-- Name: friendships Users can delete their friendships; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their friendships" ON public.friendships FOR DELETE TO authenticated USING (((auth.uid() = user_id_1) OR (auth.uid() = user_id_2)));


--
-- Name: feedbacks Users can insert their own feedbacks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own feedbacks" ON public.feedbacks FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: novels Users can insert their own novels; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own novels" ON public.novels FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Users can insert their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT TO authenticated WITH CHECK ((auth.uid() = id));


--
-- Name: friendships Users can send friend requests; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can send friend requests" ON public.friendships FOR INSERT TO authenticated WITH CHECK (((auth.uid() = requester_id) AND (status = 'pending'::text) AND (user_id_1 < user_id_2)));


--
-- Name: friendships Users can update incoming friend requests; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update incoming friend requests" ON public.friendships FOR UPDATE TO authenticated USING (((status = 'pending'::text) AND (((auth.uid() = user_id_1) AND (requester_id = user_id_2)) OR ((auth.uid() = user_id_2) AND (requester_id = user_id_1))))) WITH CHECK (((status = ANY (ARRAY['accepted'::text, 'blocked'::text])) AND (((auth.uid() = user_id_1) AND (requester_id = user_id_2)) OR ((auth.uid() = user_id_2) AND (requester_id = user_id_1)))));


--
-- Name: chapters Users can view chapters of their novels or shared ones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view chapters of their novels or shared ones" ON public.chapters FOR SELECT TO authenticated USING (public.check_chapter_access(chapters.*));


--
-- Name: novels Users can view their novels and shared ones; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their novels and shared ones" ON public.novels FOR SELECT TO authenticated USING (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM public.novel_collaborators nc
  WHERE ((nc.novel_id = novels.id) AND (nc.collaborator_id = auth.uid()))))));


--
-- Name: feedbacks Users can view their own feedbacks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own feedbacks" ON public.feedbacks FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: friendships Users can view their own friendships; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own friendships" ON public.friendships FOR SELECT TO authenticated USING (((auth.uid() = user_id_1) OR (auth.uid() = user_id_2)));


--
-- Name: chapters; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.chapters ENABLE ROW LEVEL SECURITY;

--
-- Name: feedbacks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.feedbacks ENABLE ROW LEVEL SECURITY;

--
-- Name: friendships; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.friendships ENABLE ROW LEVEL SECURITY;

--
-- Name: novel_collaborators; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.novel_collaborators ENABLE ROW LEVEL SECURITY;

--
-- Name: novels; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.novels ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: TABLE chapters; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.chapters TO anon;
GRANT ALL ON TABLE public.chapters TO authenticated;
GRANT ALL ON TABLE public.chapters TO service_role;


--
-- Name: FUNCTION check_chapter_access(chapter_row public.chapters); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_chapter_access(chapter_row public.chapters) TO anon;
GRANT ALL ON FUNCTION public.check_chapter_access(chapter_row public.chapters) TO authenticated;
GRANT ALL ON FUNCTION public.check_chapter_access(chapter_row public.chapters) TO service_role;


--
-- Name: TABLE novel_collaborators; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.novel_collaborators TO anon;
GRANT ALL ON TABLE public.novel_collaborators TO authenticated;
GRANT ALL ON TABLE public.novel_collaborators TO service_role;


--
-- Name: FUNCTION check_collaborator_policy_access(collaborator_row public.novel_collaborators); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_collaborator_policy_access(collaborator_row public.novel_collaborators) TO anon;
GRANT ALL ON FUNCTION public.check_collaborator_policy_access(collaborator_row public.novel_collaborators) TO authenticated;
GRANT ALL ON FUNCTION public.check_collaborator_policy_access(collaborator_row public.novel_collaborators) TO service_role;


--
-- Name: FUNCTION get_collaborators_for_novel(p_novel_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_collaborators_for_novel(p_novel_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_collaborators_for_novel(p_novel_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_collaborators_for_novel(p_novel_id uuid) TO service_role;


--
-- Name: FUNCTION get_friends(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_friends() TO anon;
GRANT ALL ON FUNCTION public.get_friends() TO authenticated;
GRANT ALL ON FUNCTION public.get_friends() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION handle_user_email_update(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_user_email_update() TO anon;
GRANT ALL ON FUNCTION public.handle_user_email_update() TO authenticated;
GRANT ALL ON FUNCTION public.handle_user_email_update() TO service_role;


--
-- Name: FUNCTION is_admin(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_admin() TO anon;
GRANT ALL ON FUNCTION public.is_admin() TO authenticated;
GRANT ALL ON FUNCTION public.is_admin() TO service_role;


--
-- Name: FUNCTION send_friend_request(invitee_email text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.send_friend_request(invitee_email text) TO anon;
GRANT ALL ON FUNCTION public.send_friend_request(invitee_email text) TO authenticated;
GRANT ALL ON FUNCTION public.send_friend_request(invitee_email text) TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE feedbacks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.feedbacks TO anon;
GRANT ALL ON TABLE public.feedbacks TO authenticated;
GRANT ALL ON TABLE public.feedbacks TO service_role;


--
-- Name: TABLE friendships; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.friendships TO anon;
GRANT ALL ON TABLE public.friendships TO authenticated;
GRANT ALL ON TABLE public.friendships TO service_role;


--
-- Name: TABLE novels; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.novels TO anon;
GRANT ALL ON TABLE public.novels TO authenticated;
GRANT ALL ON TABLE public.novels TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict 5Pagf0CroeS8frE09Ne5kOfmMcZZECoPRHO0nMqYK4QA7JHanC9odBvMg6n9FIW

