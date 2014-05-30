# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140530210045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambientes", primary_key: "int_ambiente_id", force: true do |t|
    t.string   "var_ambiente_nombre",         limit: 150
    t.integer  "int_ambiente_tipo"
    t.integer  "int_ambiente_nromaxpersonas"
    t.string   "var_ambiente_estado",         limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asistencia", primary_key: "int_asistencia_id", force: true do |t|
    t.datetime "dat_asistencia_fecregistro"
    t.datetime "dat_asistencia_fecasistencia"
    t.integer  "int_asistencia_categoria"
    t.integer  "int_asistencia_cantidad"
    t.integer  "servicio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asistencia", ["servicio_id"], name: "index_asistencia_on_servicio_id", using: :btree

  create_table "charts", primary_key: "int_chart_id", force: true do |t|
    t.integer  "int_chart_anio",        default: 0
    t.integer  "int_chart_mes",         default: 0
    t.integer  "int_chart_miembro",     default: 0
    t.integer  "int_chart_visita",      default: 0
    t.integer  "int_chart_joven",       default: 0
    t.integer  "int_chart_adulto",      default: 0
    t.integer  "int_chart_adolescente", default: 0
    t.integer  "int_chart_ninio",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consolidadors", primary_key: "int_consolidador_id", force: true do |t|
    t.integer  "persona_id"
    t.date     "dat_consolidador_fechaAsignacion"
    t.string   "var_consolidador_estado",          limit: 1
    t.integer  "grupo_principal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consolidadors", ["grupo_principal_id"], name: "index_consolidadors_on_grupo_principal_id", using: :btree
  add_index "consolidadors", ["persona_id"], name: "index_consolidadors_on_persona_id", using: :btree

  create_table "constantes", primary_key: "int_constante_id", force: true do |t|
    t.string   "var_constante_descripcion", limit: 50
    t.integer  "int_constante_valor"
    t.integer  "int_constante_clase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "control_asistencia", primary_key: "int_controlasistencia_id", force: true do |t|
    t.integer  "inscripcion_alumno_id"
    t.date     "dat_controlasistencia_fecha"
    t.string   "var_controlasistencia_estado", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cursos", primary_key: "int_curso_id", force: true do |t|
    t.string   "var_curso_nombre"
    t.integer  "int_curso_tipo"
    t.integer  "int_curso_nroclases"
    t.string   "var_curso_estado",      limit: 1
    t.integer  "int_curso_dependiente"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diezmos", primary_key: "int_diezmo_id", force: true do |t|
    t.decimal  "dec_diezmo_monto",                     precision: 18, scale: 2
    t.datetime "dat_diezmo_fecharegistro"
    t.string   "var_diezmo_peticion",      limit: 200
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diezmos", ["persona_id"], name: "index_diezmos_on_persona_id", using: :btree

  create_table "direccions", primary_key: "int_direccion_id", force: true do |t|
    t.string   "var_direccion_descripcion", limit: 100
    t.string   "var_direccion_referencia",  limit: 100
    t.float    "dou_direccion_longitud"
    t.float    "dou_direccion_latitud"
    t.string   "var_direccion_estado",      limit: 1
    t.integer  "ubigeo_id"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "direccions", ["persona_id"], name: "index_direccions_on_persona_id", using: :btree
  add_index "direccions", ["ubigeo_id"], name: "index_direccions_on_ubigeo_id", using: :btree

  create_table "grupo_pequenios", id: false, force: true do |t|
    t.string   "var_grupopequenio_id",                limit: 5,   null: false
    t.string   "var_grupopequenio_nombre",            limit: 150
    t.integer  "int_grupopequenio_tipo"
    t.integer  "lugar_id"
    t.date     "dat_grupopequenio_fechaInicio"
    t.integer  "int_grupopequenio_diaReunion"
    t.string   "var_grupopequenio_hora",              limit: 10
    t.string   "var_grupopequenio_direccion",         limit: 200
    t.integer  "int_grupopequenio_frecuenciareunion"
    t.integer  "int_grupopequenio_responsable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grupo_pequenios", ["lugar_id"], name: "index_grupo_pequenios_on_lugar_id", using: :btree

  create_table "grupo_principals", primary_key: "int_grupoprincipal_id", force: true do |t|
    t.string   "var_grupoprincipal_codigo",        limit: 5
    t.integer  "int_grupoprincipal_tipo"
    t.integer  "int_grupoprincipal_responsable"
    t.date     "dat_grupoprincipal_fechaCreacion"
    t.integer  "int_grupoprincipal_nromiembros"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herram_conso_consolidadors", primary_key: "int_herramconsoConsolidador_id", force: true do |t|
    t.string   "var_herramconsoConsolidador_estado"
    t.date     "dat_herramconsoConsolidador_fechaRealizado"
    t.integer  "consolidador_id"
    t.integer  "miembro_id"
    t.integer  "herramienta_consolidacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "herram_conso_consolidadors", ["consolidador_id"], name: "index_herram_conso_consolidadors_on_consolidador_id", using: :btree
  add_index "herram_conso_consolidadors", ["miembro_id"], name: "index_herram_conso_consolidadors_on_miembro_id", using: :btree

  create_table "herramienta_consolidacions", primary_key: "int_herramconsolidacion_id", force: true do |t|
    t.string   "var_herramconsolidacion_descripcion", limit: 200
    t.integer  "int_herramconsolidacion_nrodias"
    t.integer  "int_herramconsolidacion_repeticion"
    t.string   "var_herramconsolidacion_estado",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iglesia", primary_key: "int_iglesia_id", force: true do |t|
    t.datetime "dat_iglesia_fecregistro"
    t.date     "dat_iglesia_feccreacion"
    t.string   "var_iglesia_telefono",    limit: 18
    t.string   "var_iglesia_siglas",      limit: 20
    t.string   "var_iglesia_nombre",      limit: 150
    t.string   "var_iglesia_direccion",   limit: 150
    t.string   "var_iglesia_referencia",  limit: 150
    t.float    "dou_iglesia_longitud"
    t.float    "dou_iglesia_latitud"
    t.integer  "ubigeo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "iglesia", ["ubigeo_id"], name: "index_iglesia_on_ubigeo_id", using: :btree

  create_table "inscripcion_alumnos", primary_key: "int_inscripcionAlumno_id", force: true do |t|
    t.integer  "programar_curso_id"
    t.string   "var_inscripcionAlumno_estado", limit: 1
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inscripcion_alumnos", ["persona_id"], name: "index_inscripcion_alumnos_on_persona_id", using: :btree
  add_index "inscripcion_alumnos", ["programar_curso_id"], name: "index_inscripcion_alumnos_on_programar_curso_id", using: :btree

  create_table "lista_clases", primary_key: "int_listaclase_id", force: true do |t|
    t.string   "var_listaclase_nombre", limit: 150
    t.string   "var_listaclase_estado", limit: 1
    t.integer  "curso_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lista_clases", ["curso_id"], name: "index_lista_clases_on_curso_id", using: :btree

  create_table "lista_miembro_gps", primary_key: "int_listamiembrogp_id", force: true do |t|
    t.string   "grupo_pequenio_id",                limit: 5
    t.integer  "persona_id"
    t.date     "dat_listamimebrogp_fechaRegistro"
    t.string   "var_listamiembrogp_estado",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lista_miembro_gps", ["grupo_pequenio_id"], name: "fki_foreign_grupo_pequenio", using: :btree
  add_index "lista_miembro_gps", ["persona_id"], name: "index_lista_miembro_gps_on_persona_id", using: :btree

  create_table "lista_nota", primary_key: "int_listanota_id", force: true do |t|
    t.integer  "inscripcion_alumno_id"
    t.float    "dec_listanota_nota"
    t.date     "dat_listanota_fechaRegistro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lista_nota", ["inscripcion_alumno_id"], name: "index_lista_nota_on_inscripcion_alumno_id", using: :btree

  create_table "lista_temas", primary_key: "int_listatema_id", force: true do |t|
    t.integer  "herramienta_consolidacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lista_temas", ["herramienta_consolidacion_id"], name: "index_lista_temas_on_herramienta_consolidacion_id", using: :btree

  create_table "lugars", primary_key: "int_lugar_id", force: true do |t|
    t.string   "var_lugar_descripcion", limit: 100
    t.string   "var_lugar_estado",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maestros", primary_key: "int_maestro_id", force: true do |t|
    t.string   "var_maestro_id",            limit: 5
    t.integer  "miembro_id"
    t.date     "dat_maestro_fechaRegistro"
    t.string   "var_maestro_especialidad",  limit: 100
    t.string   "var_maestro_estado",        limit: 1
    t.string   "maestrocol",                limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maestros", ["miembro_id"], name: "index_maestros_on_miembro_id", using: :btree

  create_table "menus", primary_key: "int_menu_id", force: true do |t|
    t.string   "var_menu_nombre", limit: 50
    t.string   "var_menu_path",   limit: 150
    t.integer  "int_menu_nivel"
    t.integer  "int_new_dep"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "miembros", primary_key: "int_miembro_id", force: true do |t|
    t.integer  "persona_id"
    t.date     "dat_miembro_fechaAsignacion"
    t.string   "var_miembro_estado",          limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "miembros", ["persona_id"], name: "index_miembros_on_persona_id", using: :btree

  create_table "nivel_crecimientos", primary_key: "int_nivelcrecimiento_id", force: true do |t|
    t.integer  "int_nivelcrecimiento_escala"
    t.integer  "int_nivelcrecimiento_estadoactual"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nivel_crecimientos", ["persona_id"], name: "index_nivel_crecimientos_on_persona_id", using: :btree

  create_table "nivel_liderazgos", primary_key: "int_niveliderazgo_id", force: true do |t|
    t.integer  "int_niveliderazgo_tiponivel"
    t.integer  "int_niveliderazgo_responsable"
    t.integer  "miembro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nivel_liderazgos", ["miembro_id"], name: "index_nivel_liderazgos_on_miembro_id", using: :btree

  create_table "ofrendas", primary_key: "int_ofrenda_id", force: true do |t|
    t.decimal  "dec_ofrenda_monto",         precision: 18, scale: 2
    t.datetime "dec_ofrenda_fecharegistro"
    t.integer  "turno_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ofrendas", ["turno_id"], name: "index_ofrendas_on_turno_id", using: :btree

  create_table "persona_consolidadors", primary_key: "int_personaconsolidador_id", force: true do |t|
    t.integer  "consolidador_id"
    t.integer  "miembro_id"
    t.date     "dat_perconsolidador_fechaAsignacion"
    t.string   "var_perconsolidador_estado",          limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "persona_consolidadors", ["consolidador_id"], name: "index_persona_consolidadors_on_consolidador_id", using: :btree
  add_index "persona_consolidadors", ["miembro_id"], name: "index_persona_consolidadors_on_miembro_id", using: :btree

  create_table "persona_grupo_principals", primary_key: "int_pergrupoprincipal_id", force: true do |t|
    t.integer  "grupo_principal_id"
    t.string   "var_pergrupoprincipal_estado",          limit: 1
    t.date     "dat_pergrupoprincipal_fechaAsignacion"
    t.integer  "miembro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "persona_grupo_principals", ["grupo_principal_id"], name: "index_persona_grupo_principals_on_grupo_principal_id", using: :btree
  add_index "persona_grupo_principals", ["miembro_id"], name: "index_persona_grupo_principals_on_miembro_id", using: :btree

  create_table "personas", primary_key: "int_persona_id", force: true do |t|
    t.datetime "dat_persona_fecregistro"
    t.string   "var_persona_nombres",       limit: 45
    t.string   "var_persona_apellidos",     limit: 45
    t.integer  "int_persona_edad"
    t.date     "dat_persona_fecNacimiento"
    t.string   "var_persona_profesion",     limit: 45
    t.string   "var_persona_ocupacion",     limit: 45
    t.string   "var_persona_sexo",          limit: 1
    t.string   "var_persona_dni",           limit: 10
    t.string   "var_persona_estado",        limit: 1
    t.string   "var_persona_email"
    t.string   "var_persona_invitado",      limit: 100
    t.integer  "iglesia_id"
    t.integer  "lugar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "dat_persona_bautismo"
  end

  add_index "personas", ["iglesia_id"], name: "index_personas_on_iglesia_id", using: :btree
  add_index "personas", ["lugar_id"], name: "index_personas_on_lugar_id", using: :btree

  create_table "peticions", primary_key: "int_peticion_id", force: true do |t|
    t.string   "var_peticion_motivooracion", limit: 300
    t.integer  "persona_id"
    t.date     "dat_peticion_fecha"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "peticions", ["persona_id"], name: "index_peticions_on_persona_id", using: :btree

  create_table "programar_cursos", primary_key: "int_programarcurso_id", force: true do |t|
    t.integer  "curso_id"
    t.integer  "maestro_id"
    t.date     "dat_programarcurso_fechaRegistro"
    t.date     "dat_programarcurso_fechaApertura"
    t.date     "dat_programarcurso_fechaInicio"
    t.date     "dat_programarcurso_fechaFin"
    t.integer  "int_programarcurso_turno"
    t.string   "var_programarcurso_horaInicio",    limit: 10
    t.string   "var_programarcurso_horaFin",       limit: 10
    t.integer  "int_programarcurso_suplente"
    t.integer  "int_programarcurso_frecuencia"
    t.string   "var_programarcurso_estado",        limit: 1
    t.integer  "ambiente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programar_cursos", ["curso_id"], name: "index_programar_cursos_on_curso_id", using: :btree
  add_index "programar_cursos", ["maestro_id"], name: "index_programar_cursos_on_maestro_id", using: :btree

  create_table "servicios", primary_key: "int_servicio_id", force: true do |t|
    t.string   "var_servicio_nombre", limit: 150
    t.integer  "int_servicio_tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms", primary_key: "int_sms_id", force: true do |t|
    t.string   "var_sms_mensaje",          limit: 250
    t.datetime "dat_detallesms_fechahora"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telefonos", primary_key: "int_telefono_id", force: true do |t|
    t.integer  "int_telefono_tipo"
    t.string   "var_telefono_codigo", limit: 5
    t.string   "var_telefono_numero", limit: 18
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "telefonos", ["persona_id"], name: "index_telefonos_on_persona_id", using: :btree

  create_table "turnos", primary_key: "int_turno_id", force: true do |t|
    t.string   "var_turno_horainicio", limit: 10
    t.string   "var_turno_horafin",    limit: 10
    t.integer  "int_turno_dia"
    t.integer  "servicio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "turnos", ["servicio_id"], name: "index_turnos_on_servicio_id", using: :btree

  create_table "ubigeos", primary_key: "int_ubigeo_id", force: true do |t|
    t.string   "string_ubigeo_descripcion", limit: 50
    t.integer  "int_ubigeo_departamento"
    t.integer  "int_ubigeo_provincia"
    t.integer  "int_ubigeo_distrito"
    t.integer  "int_ubigeo_dependencia"
    t.float    "float_ubigeo_latitud"
    t.float    "float_ubigeo_longitud"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "var_usuario_nombre",     limit: 50
    t.string   "var_usuario_apellido",   limit: 50
    t.string   "var_usuario_documento",  limit: 18
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "usuario_menus", primary_key: "int_usuariomenu_id", force: true do |t|
    t.integer  "user_id"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuario_menus", ["menu_id"], name: "index_usuario_menus_on_menu_id", using: :btree
  add_index "usuario_menus", ["user_id"], name: "index_usuario_menus_on_user_id", using: :btree

end
