CREATE OR REPLACE FUNCTION sp_get_rpt_asistencia_general(IN fechainicio date, IN fechafin date, OUT id_tiposervicio integer, OUT tiposervicio character varying, OUT id_servicio integer, OUT servicio character varying, OUT cantidad numeric)
  RETURNS SETOF record AS
$BODY$
BEGIN
  return query (SELECT s.int_servicio_tipo as id_tiposervicio,
           c.var_constante_descripcion AS tiposervicio,
           a.servicio_id AS id_servicio,
           s.var_servicio_nombre AS servicio,
           round(avg((a.int_asistencia_cantidad))) AS cantidad
          FROM asistencia a
        JOIN servicios s ON s.int_servicio_id = a.servicio_id
        JOIN constantes c ON c.int_constante_valor = s.int_servicio_tipo AND c.int_constante_clase = 1
        WHERE DATE(a.dat_asistencia_fecasistencia) between fechaInicio and fechaFin
        GROUP BY s.int_servicio_tipo,c.var_constante_descripcion, a.servicio_id, s.var_servicio_nombre
        ORDER BY c.var_constante_descripcion, s.var_servicio_nombre);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

CREATE OR REPLACE FUNCTION sp_get_rpt_asistencia_serviciocategoriames(IN fechainicio date, IN fechafin date, OUT id_tiposervicio integer, OUT tiposervicio character varying, OUT id_servicio integer, OUT servicio character varying, OUT mes text, OUT categoria character varying, OUT cantidad numeric)
  RETURNS SETOF record AS
$BODY$
BEGIN
  return query (SELECT 
      s.int_servicio_tipo as id_tiposervicio,
      c.var_constante_descripcion AS tiposervicio,
      a.servicio_id AS id_servicio,
      s.var_servicio_nombre AS servicio,
    (CASE
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 1::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia), ' - ' , 'Enero' )::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 2::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' , 'Febrero')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 3::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Marzo')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 4::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Abril')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 5::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Mayo')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 6::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Junio')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 7::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Julio')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 8::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Agosto')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 9::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Septiembre')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 10::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Octubre')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 11::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Noviembre')::text
        WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 12::double precision THEN CONCAT(date_part('year'::text, a.dat_asistencia_fecasistencia) , ' - ' ,'Diciembre')::text
        ELSE NULL::text
    END) AS mes,
      c1.var_constante_descripcion AS categoria,
      round(avg(a.int_asistencia_cantidad)) AS cantidad
     FROM asistencia a
     JOIN servicios s ON s.int_servicio_id = a.servicio_id
     JOIN constantes c ON c.int_constante_valor = s.int_servicio_tipo AND c.int_constante_clase = 1
     JOIN constantes c1 ON c1.int_constante_valor = a.int_asistencia_categoria AND c1.int_constante_clase=2
    WHERE DATE(a.dat_asistencia_fecasistencia) between fechaInicio and fechaFin
    GROUP BY s.int_servicio_tipo,c.var_constante_descripcion, a.servicio_id, s.var_servicio_nombre, date_part('year'::text, a.dat_asistencia_fecasistencia), date_part('month'::text, a.dat_asistencia_fecasistencia),a.int_asistencia_categoria,c1.var_constante_descripcion
    ORDER BY date_part('year'::text, a.dat_asistencia_fecasistencia) desc, date_part('month'::text, a.dat_asistencia_fecasistencia) desc, s.int_servicio_tipo, a.servicio_id, a.int_asistencia_categoria);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

CREATE OR REPLACE FUNCTION sp_inst_registrar_constante(descripcion character varying, clase integer)
  RETURNS SETOF record AS
$BODY$
BEGIN

  INSERT INTO constantes (int_constante_id,var_constante_descripcion,int_constante_valor,int_constante_clase,created_at,updated_at) 
  VALUES ((SELECT max(int_constante_id)+ 1 FROM constantes),descripcion,
  (SELECT max(int_constante_valor)+ 1 FROM constantes where int_constante_clase = clase),clase,current_timestamp,current_timestamp);
  
  return;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

CREATE OR REPLACE VIEW view_get_persona_completo AS 
 SELECT p.int_persona_id,
    p.var_persona_nombres,
    p.var_persona_apellidos,
    p.int_persona_edad,
    p.var_persona_ocupacion,
    p.var_persona_profesion,
    p.var_persona_dni,
    p.var_persona_email,
    p.var_persona_sexo,
    to_char(p.dat_persona_fecregistro::timestamp with time zone, 'dd/mm/yyyy'::text) AS fecconvertido,
    to_char(p."dat_persona_fecNacimiento"::timestamp with time zone, 'dd/mm/yyyy'::text) AS fecnacimiento,
    to_char(p."dat_persona_bautismo"::timestamp with time zone, 'dd/mm/yyyy'::text) AS bautismo,
    nc.int_nivelcrecimiento_escala AS nivel,
    p.var_persona_invitado,
    p.lugar_id,
    peticions.var_peticion_motivooracion AS peticion,
    d.var_direccion_descripcion AS direccion,
    d.var_direccion_referencia AS referencia,
    udis.int_ubigeo_id AS distrito,
    uprov.int_ubigeo_id AS provincia,
    udep.int_ubigeo_id AS departamento
   FROM personas p
   JOIN nivel_crecimientos nc ON nc.persona_id = p.int_persona_id and nc.int_nivelcrecimiento_estadoactual = 1
   JOIN peticions ON peticions.persona_id = p.int_persona_id
   JOIN direccions d ON p.int_persona_id = d.persona_id
   JOIN ubigeos udis ON d.ubigeo_id = udis.int_ubigeo_id
   JOIN ubigeos uprov ON udis.int_ubigeo_dependencia = uprov.int_ubigeo_id
   JOIN ubigeos udep ON uprov.int_ubigeo_dependencia = udep.int_ubigeo_id;

CREATE OR REPLACE VIEW view_get_personas AS 
 SELECT p.int_persona_id,
    concat(p.var_persona_nombres, ' ', p.var_persona_apellidos) AS nombrecompleto,
    to_char(p.dat_persona_fecregistro::timestamp with time zone, 'dd/mm/yyyy'::text) AS fecconvertido,
    to_char(p."dat_persona_fecNacimiento"::timestamp with time zone, 'dd/mm/yyyy'::text) AS fecnacimiento,
    array_to_string(ARRAY( SELECT
                CASE nc.int_nivelcrecimiento_escala
                    WHEN (-1) THEN 'Pastor Principal'::text
                    WHEN 0 THEN 'Visitante'::text
                    WHEN 1 THEN 'Miembro'::text
                    ELSE 'Indefinido'::text
                END AS "case"
           FROM nivel_crecimientos nc
          WHERE nc.persona_id = p.int_persona_id AND nc.int_nivelcrecimiento_estadoactual = 1), '<br>'::text) AS nivel
   FROM personas p
  WHERE p.var_persona_estado::text = '1'::text;



CREATE OR REPLACE VIEW view_get_rpt_asistencia_bycategoriaservicio AS 
 SELECT s.var_servicio_nombre AS servicio,
    date(a.dat_asistencia_fecasistencia) AS fecha,
    a.int_asistencia_cantidad AS cantidad,
        CASE
            WHEN a.int_asistencia_categoria = 0 THEN 'Mujeres Jovenes'::text
            WHEN a.int_asistencia_categoria = 1 THEN 'Hombres Jovenes'::text
            WHEN a.int_asistencia_categoria = 2 THEN 'Mujeres'::text
            WHEN a.int_asistencia_categoria = 3 THEN 'Hombres'::text
            ELSE NULL::text
        END AS categoria,
    ( SELECT sum(a_1.int_asistencia_cantidad) AS total
           FROM asistencia a_1) AS total
   FROM asistencia a
   JOIN servicios s ON a.servicio_id = s.int_servicio_id
  GROUP BY s.var_servicio_nombre, a.int_asistencia_categoria, a.dat_asistencia_fecasistencia, a.int_asistencia_cantidad;

CREATE OR REPLACE VIEW view_get_rpt_asistencia_general AS 
 SELECT s.int_servicio_tipo AS id_tiposervicio,
    c.var_constante_descripcion AS tiposervicio,
    a.servicio_id AS id_servicio,
    s.var_servicio_nombre AS servicio,
    date_part('month'::text, a.dat_asistencia_fecasistencia) AS fecha,
    sum(a.int_asistencia_cantidad) AS cantidad
   FROM asistencia a
   JOIN servicios s ON s.int_servicio_id = a.servicio_id
   JOIN constantes c ON c.int_constante_valor = s.int_servicio_tipo AND c.int_constante_clase = 1
  GROUP BY s.int_servicio_tipo, c.var_constante_descripcion, a.servicio_id, s.var_servicio_nombre, a.dat_asistencia_fecasistencia
  ORDER BY c.var_constante_descripcion, s.var_servicio_nombre;

CREATE OR REPLACE VIEW view_get_rpt_asistencia_servicio AS 
 SELECT se.int_servicio_id,
    se.var_servicio_nombre AS servicio,
    ( SELECT sum(a.int_asistencia_cantidad) AS sum
           FROM asistencia a
          WHERE a.servicio_id = se.int_servicio_id) AS asistencias,
    date(asi.dat_asistencia_fecasistencia) AS fecha
   FROM servicios se
   JOIN asistencia asi ON asi.servicio_id = se.int_servicio_id
  GROUP BY se.int_servicio_id, se.var_servicio_nombre, asi.dat_asistencia_fecasistencia
  ORDER BY se.int_servicio_id;

CREATE OR REPLACE VIEW view_get_rpt_asistencia_serviciocategoriafecha AS 
 SELECT a.int_asistencia_id AS id,
    c.var_constante_descripcion AS tiposervicio,
    a.servicio_id AS id_servicio,
    s.var_servicio_nombre AS servicio,
    date(a.dat_asistencia_fecasistencia) AS fecha,
    a.int_asistencia_categoria AS categoria,
    sum(a.int_asistencia_cantidad) AS cantidad
   FROM asistencia a
   JOIN servicios s ON s.int_servicio_id = a.servicio_id
   JOIN constantes c ON c.int_constante_valor = s.int_servicio_tipo AND c.int_constante_clase = 1
  GROUP BY a.int_asistencia_id, c.var_constante_descripcion, a.servicio_id, s.var_servicio_nombre, a.dat_asistencia_fecasistencia, a.int_asistencia_categoria
  ORDER BY c.var_constante_descripcion, s.var_servicio_nombre, a.dat_asistencia_fecasistencia, a.int_asistencia_categoria;

CREATE OR REPLACE VIEW view_get_rpt_asistencia_serviciocategoriames AS 
 SELECT c.var_constante_descripcion AS tiposervicio,
    a.servicio_id AS id_servicio,
    s.var_servicio_nombre AS servicio,
        CASE
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 1::double precision THEN 'Enero'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 2::double precision THEN 'Febrero'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 3::double precision THEN 'Marzo'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 4::double precision THEN 'Abril'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 5::double precision THEN 'Mayo'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 6::double precision THEN 'Junio'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 7::double precision THEN 'Julio'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 8::double precision THEN 'Agosto'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 9::double precision THEN 'Septiembre'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 10::double precision THEN 'Octubre'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 11::double precision THEN 'Noviembre'::text
            WHEN date_part('month'::text, a.dat_asistencia_fecasistencia) = 12::double precision THEN 'Diciembre'::text
            ELSE NULL::text
        END AS mes,
    date(a.dat_asistencia_fecasistencia) AS fecha,
    a.int_asistencia_categoria AS categoria,
    sum(a.int_asistencia_cantidad) AS cantidad
   FROM asistencia a
   JOIN servicios s ON s.int_servicio_id = a.servicio_id
   JOIN constantes c ON c.int_constante_valor = s.int_servicio_tipo AND c.int_constante_clase = 1
  GROUP BY c.var_constante_descripcion, a.servicio_id, s.var_servicio_nombre, date_part('month'::text, a.dat_asistencia_fecasistencia), a.dat_asistencia_fecasistencia, a.int_asistencia_categoria
  ORDER BY s.var_servicio_nombre, date_part('month'::text, a.dat_asistencia_fecasistencia), a.int_asistencia_categoria;

CREATE OR REPLACE VIEW view_get_rpt_diezmo AS 
 SELECT concat(p.var_persona_nombres, ' ', p.var_persona_apellidos) AS "Miembro",
    d.dec_diezmo_monto AS monto,
    d.var_diezmo_peticion AS peticion,
    p.int_persona_id AS id_persona,
    date(d.dat_diezmo_fecharegistro) AS fecharegistro
   FROM diezmos d
   JOIN personas p ON p.int_persona_id = d.persona_id;

CREATE OR REPLACE VIEW view_get_rpt_miembros AS 
 SELECT concat(p.var_persona_nombres, ' ', p.var_persona_apellidos) AS nombrecompleto,
    COALESCE(p.int_persona_edad, 0) AS edad,
    p.dat_persona_fecregistro AS fecconvertido,
    p."dat_persona_fecNacimiento" AS fecnacimiento,
    COALESCE(p.var_persona_ocupacion, ''::character varying) AS var_persona_ocupacion,
    COALESCE(( SELECT d.var_direccion_descripcion
           FROM direccions d
          WHERE d.persona_id = p.int_persona_id
         LIMIT 1), ''::character varying) AS direccion,
    COALESCE(( SELECT d.var_direccion_referencia
           FROM direccions d
          WHERE d.persona_id = p.int_persona_id
         LIMIT 1), ''::character varying) AS referencias,
    COALESCE(( SELECT concat('(', t.var_telefono_codigo, ')', ' - ', COALESCE(t.var_telefono_numero, ''::character varying)) AS concat
           FROM telefonos t
          WHERE t.persona_id = p.int_persona_id
         LIMIT 1), ''::text) AS telefono,
    date(p.created_at) AS fecregistro
   FROM nivel_crecimientos nc
   JOIN personas p ON p.int_persona_id = nc.persona_id
  WHERE nc.int_nivelcrecimiento_estadoactual = 1 AND nc.int_nivelcrecimiento_escala = 1 AND p.var_persona_estado::text = '1'::text;

CREATE OR REPLACE VIEW view_get_rpt_ofrendas AS 
 SELECT se.int_servicio_id AS id,
    ct.var_constante_descripcion AS tiposervicio,
    se.var_servicio_nombre AS servicio,
    date(of.dec_ofrenda_fecharegistro) AS fecha,
    concat(t.var_turno_horainicio, ' - ', t.var_turno_horafin) AS turno,
    of.dec_ofrenda_monto AS monto
   FROM ofrendas of
   JOIN turnos t ON t.int_turno_id = of.turno_id
   JOIN servicios se ON se.int_servicio_id = t.servicio_id
   JOIN constantes ct ON ct.int_constante_valor = se.int_servicio_tipo AND ct.int_constante_clase = 1 AND ct.int_constante_valor <> 0
  ORDER BY ct.var_constante_descripcion, se.var_servicio_nombre, date(of.dec_ofrenda_fecharegistro);

CREATE OR REPLACE VIEW view_get_rpt_visitantes AS 
 SELECT concat(p.var_persona_nombres, ' ', p.var_persona_apellidos) AS nombrecompleto,
    COALESCE(p.int_persona_edad, 0) AS edad,
    p."dat_persona_fecNacimiento" AS fecnacimiento,
    COALESCE(( SELECT concat('(', t.var_telefono_codigo, ')', ' - ', COALESCE(t.var_telefono_numero, ''::character varying)) AS concat
           FROM telefonos t
          WHERE t.persona_id = p.int_persona_id
         LIMIT 1), ''::text) AS telefono,
    date(p.created_at) AS fecregistro
   FROM nivel_crecimientos nc
   JOIN personas p ON p.int_persona_id = nc.persona_id
  WHERE nc.int_nivelcrecimiento_estadoactual = 1 AND nc.int_nivelcrecimiento_escala = 0 AND p.var_persona_estado::text = '1'::text;

CREATE OR REPLACE VIEW view_get_servicios AS 
 SELECT s.int_servicio_id,
    s.var_servicio_nombre,
    s.int_servicio_tipo,
    t.int_turno_dia
   FROM servicios s
   JOIN turnos t ON t.servicio_id = s.int_servicio_id;

CREATE OR REPLACE VIEW view_get_tbl_asistencia AS 
 SELECT se.int_servicio_id,
    se.var_servicio_nombre AS servicio,
    sum(asi.int_asistencia_cantidad) AS asistencia,
    concat(t.var_turno_horainicio, ' - ', t.var_turno_horafin) AS turno,
    date(asi.dat_asistencia_fecasistencia) AS fecha
   FROM servicios se
   JOIN asistencia asi ON asi.servicio_id = se.int_servicio_id
   JOIN turnos t ON t.servicio_id = se.int_servicio_id
  GROUP BY se.int_servicio_id, se.var_servicio_nombre, asi.dat_asistencia_fecasistencia, t.var_turno_horainicio, t.var_turno_horafin
  ORDER BY se.int_servicio_id;

CREATE OR REPLACE VIEW view_get_tbl_diezmo AS 
 SELECT concat(p.var_persona_nombres, ' ', p.var_persona_apellidos) AS persona,
    date(d.dat_diezmo_fecharegistro) AS fecha,
    d.dec_diezmo_monto AS monto,
    d.var_diezmo_peticion AS peticion
   FROM diezmos d
   JOIN personas p ON p.int_persona_id = d.persona_id
  WHERE p.var_persona_estado::text = '1'::text;

CREATE OR REPLACE VIEW view_menu_usuario AS 
 SELECT m.var_menu_nombre
   FROM menus m
   JOIN usuario_menus um ON m.int_menu_id = um.menu_id;


CREATE OR REPLACE VIEW view_list_grupo_pequenios AS 
 SELECT g.int_grupopequenio_id AS id,
    g.var_grupopequenio_nombre AS nombre,
    g.int_grupopequenio_tipo AS tipo,
    g.lugar_id AS lugar,
    g.var_grupopequenio_direccion AS direccion,
    g."int_grupopequenio_diaReunion" AS dia,
    g.int_grupopequenio_frecuenciareunion AS frecuencia,
    g.var_grupopequenio_hora AS hora,
    g.grupo_principal_id,
    ( SELECT concat(p.var_persona_nombres, p.var_persona_apellidos) AS concat
           FROM grupo_principals gp
      JOIN personas p ON p.int_persona_id = gp.int_grupoprincipal_responsable) AS grupo_principal,
    g.int_grupopequenio_responsable,
    ( SELECT concat(personas.var_persona_nombres, personas.var_persona_apellidos) AS concat
           FROM personas
          WHERE personas.int_persona_id = g.int_grupopequenio_responsable) AS grupo_pequenio,
    g."dat_grupopequenio_fechaInicio"
   FROM grupo_pequenios g;
   
CREATE OR REPLACE VIEW public.view_lista_herramientas AS
SELECT int_herramconsolidacion_id as id, var_herramconsolidacion_descripcion as descripcion, 
       int_herramconsolidacion_nrodias as duracion, int_herramconsolidacion_repeticion as repeticion, 
  case when (select count(*) from lista_temas l where l.herramienta_consolidacion_id = int_herramconsolidacion_id) > 0 then 'Si'::text
  else 'No'::text end as asignado,
       case when var_herramconsolidacion_estado = '1' then 'Activo'::text
       else 'Inactivo'::text
       end as estado
       
  FROM herramienta_consolidacions;
ALTER TABLE public.view_lista_herramientas
  OWNER TO postgres;