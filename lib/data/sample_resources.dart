import '../models/resource.dart';

/// Local test data set (no server, no database). At least 20 resources
/// spread across the six suggested categories, as required by RF-Datos de prueba.
const List<Resource> kSampleResources = [
  // ---------------------------------------------------------------- Flutter
  Resource(
    id: 'r1',
    title: 'Introduccion a Widgets',
    category: 'Flutter',
    author: 'Roilan R.',
    durationMinutes: 12,
    level: ResourceLevel.basico,
    type: ResourceType.video,
    description:
        'Un recorrido por los widgets basicos de Flutter y como se combinan para construir una interfaz.',
    content: 'https://exre.app/videos/introduccion-a-widgets',
  ),
  Resource(
    id: 'r2',
    title: 'StatefulWidget vs StatelessWidget',
    category: 'Flutter',
    author: 'Ana Perez',
    durationMinutes: 16,
    level: ResourceLevel.basico,
    type: ResourceType.lectura,
    description:
        'Diferencias clave entre widgets con y sin estado, y cuando conviene usar cada uno.',
    content:
        'Lectura: un StatelessWidget se reconstruye solo cuando cambian sus parametros de entrada, '
        'mientras que un StatefulWidget mantiene un objeto State que puede llamar a setState().',
  ),
  Resource(
    id: 'r3',
    title: 'Gestion de estado con ChangeNotifier',
    category: 'Flutter',
    author: 'Carlos Diaz',
    durationMinutes: 20,
    level: ResourceLevel.intermedio,
    type: ResourceType.practica,
    description:
        'Practica guiada para modelar el estado de una app usando solo herramientas del SDK.',
    content:
        'Ejercicio: crea una clase que extienda ChangeNotifier, expon metodos para mutar el estado '
        'y notifica a los oyentes con notifyListeners().',
  ),
  Resource(
    id: 'r4',
    title: 'Ciclo de build y rebuilds eficientes',
    category: 'Flutter',
    author: 'Maria Lopez',
    durationMinutes: 25,
    level: ResourceLevel.avanzado,
    type: ResourceType.documento,
    description:
        'Como Flutter decide que reconstruir y tecnicas para evitar rebuilds innecesarios.',
    content: 'https://exre.app/docs/ciclo-de-build',
  ),

  // ---------------------------------------------------------------- Android
  Resource(
    id: 'r5',
    title: 'Ciclo de vida en Android',
    category: 'Android',
    author: 'Jorge Ruiz',
    durationMinutes: 10,
    level: ResourceLevel.basico,
    type: ResourceType.video,
    description:
        'Resumen visual de los estados resumed, inactive, paused y detached observados desde Flutter.',
    content: 'https://exre.app/videos/ciclo-de-vida-android',
  ),
  Resource(
    id: 'r6',
    title: 'Actividades y fragmentos',
    category: 'Android',
    author: 'Elena Gomez',
    durationMinutes: 14,
    level: ResourceLevel.basico,
    type: ResourceType.lectura,
    description:
        'Como se relacionan las actividades nativas de Android con el motor de Flutter.',
    content:
        'Lectura: cada app de Flutter corre dentro de una unica Activity (FlutterActivity) que aloja '
        'la vista del motor de renderizado.',
  ),
  Resource(
    id: 'r7',
    title: 'Permisos y almacenamiento local',
    category: 'Android',
    author: 'Sofia Torres',
    durationMinutes: 18,
    level: ResourceLevel.intermedio,
    type: ResourceType.practica,
    description: 'Practica sobre el manejo de permisos y datos locales en dispositivos Android.',
    content: 'Ejercicio: identifica que permisos declarar en el manifest para leer archivos locales.',
  ),
  Resource(
    id: 'r8',
    title: 'Optimizacion de recursos en Android',
    category: 'Android',
    author: 'Pedro Vidal',
    durationMinutes: 22,
    level: ResourceLevel.avanzado,
    type: ResourceType.documento,
    description: 'Buenas practicas para reducir el consumo de memoria y bateria en Android.',
    content: 'https://exre.app/docs/optimizacion-android',
  ),

  // --------------------------------------------------------------- Layouts
  Resource(
    id: 'r9',
    title: 'Layouts Adaptables con Flex',
    category: 'Layouts',
    author: 'Ana Perez',
    durationMinutes: 18,
    level: ResourceLevel.intermedio,
    type: ResourceType.lectura,
    description: 'Row, Column y Flexible/Expanded para construir interfaces que se adaptan al espacio.',
    content:
        'Lectura: Expanded reparte el espacio sobrante segun un factor flex, mientras que Flexible '
        'permite que un hijo sea mas pequeno que el espacio disponible.',
  ),
  Resource(
    id: 'r10',
    title: 'Row, Column y Expanded',
    category: 'Layouts',
    author: 'Roilan R.',
    durationMinutes: 11,
    level: ResourceLevel.basico,
    type: ResourceType.video,
    description: 'Los tres widgets mas usados para organizar contenido horizontal y vertical.',
    content: 'https://exre.app/videos/row-column-expanded',
  ),
  Resource(
    id: 'r11',
    title: 'Diseño responsivo con MediaQuery',
    category: 'Layouts',
    author: 'Laura Nunez',
    durationMinutes: 20,
    level: ResourceLevel.intermedio,
    type: ResourceType.practica,
    description: 'Practica para adaptar un layout a distintos tamanos de pantalla sin overflow.',
    content: 'Ejercicio: usa MediaQuery.of(context).size para ajustar paddings en pantallas pequenas.',
  ),
  Resource(
    id: 'r12',
    title: 'Constraints y overflow: como evitarlos',
    category: 'Layouts',
    author: 'Carlos Diaz',
    durationMinutes: 16,
    level: ResourceLevel.avanzado,
    type: ResourceType.documento,
    description: 'Entendiendo el modelo de constraints de Flutter para prevenir errores de overflow.',
    content: 'https://exre.app/docs/constraints-y-overflow',
  ),

  // ----------------------------------------------------------- Scrollables
  Resource(
    id: 'r13',
    title: 'ListView.builder a fondo',
    category: 'Scrollables',
    author: 'Carlos Diaz',
    durationMinutes: 15,
    level: ResourceLevel.basico,
    type: ResourceType.video,
    description: 'Como construir listas largas de forma eficiente usando ListView.builder.',
    content: 'https://exre.app/videos/listview-builder',
  ),
  Resource(
    id: 'r14',
    title: 'ListView.separated y divisores',
    category: 'Scrollables',
    author: 'Maria Lopez',
    durationMinutes: 13,
    level: ResourceLevel.basico,
    type: ResourceType.lectura,
    description: 'Cuando usar ListView.separated para anadir divisores visuales entre elementos.',
    content:
        'Lectura: ListView.separated recibe un separatorBuilder que se ejecuta entre cada par de '
        'elementos consecutivos de la lista.',
  ),
  Resource(
    id: 'r15',
    title: 'CustomScrollView y slivers combinados',
    category: 'Scrollables',
    author: 'Jorge Ruiz',
    durationMinutes: 24,
    level: ResourceLevel.avanzado,
    type: ResourceType.practica,
    description: 'Practica combinando varios slivers dentro de un mismo CustomScrollView.',
    content: 'Ejercicio: combina un SliverAppBar con un SliverList dentro de un CustomScrollView.',
  ),
  Resource(
    id: 'r16',
    title: 'Scroll infinito y paginacion local',
    category: 'Scrollables',
    author: 'Sofia Torres',
    durationMinutes: 19,
    level: ResourceLevel.intermedio,
    type: ResourceType.documento,
    description: 'Tecnicas para simular carga incremental de datos en una lista local.',
    content: 'https://exre.app/docs/scroll-infinito',
  ),

  // --------------------------------------------------------------- Slivers
  Resource(
    id: 'r17',
    title: 'SliverAppBar paso a paso',
    category: 'Slivers',
    author: 'Maria Lopez',
    durationMinutes: 22,
    level: ResourceLevel.avanzado,
    type: ResourceType.video,
    description: 'Construccion de una barra superior colapsable usando SliverAppBar.',
    content: 'https://exre.app/videos/sliverappbar-paso-a-paso',
  ),
  Resource(
    id: 'r18',
    title: 'SliverList vs SliverGrid',
    category: 'Slivers',
    author: 'Elena Gomez',
    durationMinutes: 17,
    level: ResourceLevel.intermedio,
    type: ResourceType.lectura,
    description: 'Comparacion entre los dos slivers de coleccion mas comunes.',
    content:
        'Lectura: SliverList dispone sus hijos en una sola columna scrolleable, mientras que '
        'SliverGrid los organiza en una cuadricula segun un delegate.',
  ),
  Resource(
    id: 'r19',
    title: 'SliverGridDelegateWithFixedCrossAxisCount',
    category: 'Slivers',
    author: 'Pedro Vidal',
    durationMinutes: 21,
    level: ResourceLevel.avanzado,
    type: ResourceType.practica,
    description: 'Practica configurando columnas, espaciado y proporcion de celdas en una grilla.',
    content:
        'Ejercicio: ajusta crossAxisCount, crossAxisSpacing, mainAxisSpacing y childAspectRatio '
        'hasta obtener celdas sin deformar.',
  ),
  Resource(
    id: 'r20',
    title: 'Efectos de colapso con Slivers',
    category: 'Slivers',
    author: 'Laura Nunez',
    durationMinutes: 23,
    level: ResourceLevel.avanzado,
    type: ResourceType.documento,
    description: 'Como lograr efectos de encogimiento y parallax combinando slivers.',
    content: 'https://exre.app/docs/efectos-de-colapso',
  ),

  // ------------------------------------------------------------ Navegacion
  Resource(
    id: 'r21',
    title: 'Navigator y rutas nombradas',
    category: 'Navegacion',
    author: 'Elena Gomez',
    durationMinutes: 14,
    level: ResourceLevel.intermedio,
    type: ResourceType.video,
    description: 'Fundamentos de navegacion entre pantallas usando el Navigator del SDK.',
    content: 'https://exre.app/videos/navigator-rutas-nombradas',
  ),
  Resource(
    id: 'r22',
    title: 'Navigator.push vs pushNamed',
    category: 'Navegacion',
    author: 'Roilan R.',
    durationMinutes: 9,
    level: ResourceLevel.basico,
    type: ResourceType.lectura,
    description: 'Diferencias practicas entre empujar una ruta directa y una ruta con nombre.',
    content:
        'Lectura: Navigator.push recibe una Route ya construida; Navigator.pushNamed busca la ruta '
        'en la tabla de rutas registrada en el MaterialApp.',
  ),
  Resource(
    id: 'r23',
    title: 'Paso de argumentos entre pantallas',
    category: 'Navegacion',
    author: 'Ana Perez',
    durationMinutes: 15,
    level: ResourceLevel.intermedio,
    type: ResourceType.practica,
    description: 'Practica enviando y recibiendo datos al navegar hacia la pantalla de Detalle.',
    content: 'Ejercicio: pasa el identificador de un recurso como argumento al construir la ruta.',
  ),
  Resource(
    id: 'r24',
    title: 'BottomNavigationBar y navegacion persistente',
    category: 'Navegacion',
    author: 'Jorge Ruiz',
    durationMinutes: 17,
    level: ResourceLevel.intermedio,
    type: ResourceType.documento,
    description: 'Como mantener una barra inferior persistente mientras se navega por secciones.',
    content: 'https://exre.app/docs/bottomnavigationbar',
  ),
];
