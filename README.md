# ✈️ Airport Operations — Data Analysis Project

Proyecto de análisis de datos aeroportuarios que simula el funcionamiento operativo de un aeropuerto real.  
Incluye diseño de base de datos, consultas SQL, exportación de datos a CSV y visualizaciones basadas en puntualidad, retrasos y movimientos de pista.

---

## 🎯 Objetivos del proyecto

- Diseñar una base de datos relacional que represente operaciones reales de un aeropuerto.
- Analizar información clave como puntualidad, retrasos y movimientos de pista.
- Exportar datasets en formato CSV para su posterior análisis.
- Generar visualizaciones claras y profesionales basadas en los datos.
- Documentar el proceso completo como parte de un portfolio profesional.
- Demostrar habilidades en SQL, análisis de datos y organización de proyectos.

---

## 🛠️ Herramientas utilizadas

- **MySQL Workbench** → Creación de tablas, inserciones y consultas SQL.
- **CSV** → Exportación de datasets para análisis.
- **Excel / Google Sheets** → Creación de gráficos y visualizaciones.
- **GitHub** → Control de versiones y documentación del proyecto.
- **Markdown** → Redacción del README y estructura del repositorio.

---

## 📁 Estructura del proyecto

airport_operations/
├── CSV/                # Datasets exportados desde MySQL
├── SQL/                # Estructura, inserciones y consultas SQL
├── IMAGENES/           # Gráficos generados a partir de los datos
└── README.md            # Documentación del proyecto

---

## 🧱 Modelo de datos

El proyecto incluye las siguientes tablas:

- **aerolineas** → Información de aerolíneas  
- **puertas_embarque** → Puertas y terminales  
- **vuelos** → Información operativa de vuelos  
- **operaciones_pista** → Aterrizajes y despegues  
- **retrasos** → Causas y minutos de retraso  

Las relaciones están definidas mediante claves foráneas para mantener integridad referencial.

---

## 🗄️ Archivos SQL incluidos

En la carpeta **SQL/** se encuentran:

- `estructura_airport_operations.sql` → Creación de tablas  
- `inserciones_airport_operations.sql` → Datos iniciales  
- `consultas_basicas.sql` → SELECT simples y JOIN  
- `consultas_avanzadas.sql` → Agregaciones, GROUP BY, análisis  
- `joins.sql` → Consultas relacionales  

---

## 📊 Datasets (CSV)

En la carpeta **CSV/** se incluyen:

- `puntualidad_aerolineas.csv`  
- `retrasos_por_causa.csv`  
- `movimientos_por_pista.csv`  

Estos archivos fueron generados a partir de consultas SQL ejecutadas en MySQL Workbench.

---

## 📈 Visualizaciones

En la carpeta **IMAGENES/** se encuentran gráficos que representan:

- Puntualidad por aerolínea  
- Retrasos por causa  
- Movimientos por pista  

Las visualizaciones fueron creadas a partir de los CSV exportados.

---

## 🔍 Consultas destacadas

### ✔ Puntualidad por aerolínea
```sql
SELECT 
    a.nombre AS aerolinea,
    COUNT(v.id_vuelo) AS total_vuelos,
    SUM(CASE WHEN v.estado = 'En horario' THEN 1 ELSE 0 END) AS vuelos_en_horario,
    SUM(CASE WHEN v.estado = 'Retrasado' THEN 1 ELSE 0 END) AS vuelos_retrasados
FROM vuelos v
JOIN aerolineas a ON v.id_aerolinea = a.id_aerolinea
GROUP BY a.nombre;
👨‍💻 Autor
Proyecto desarrollado por Lautaro Callupil como parte de su portfolio profesional.
