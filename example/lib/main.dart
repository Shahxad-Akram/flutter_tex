import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex_example/math2svg_example.dart';
import 'package:flutter_tex_example/tex_view_document_example.dart';
import 'package:flutter_tex_example/tex_view_fonts_example.dart';
import 'package:flutter_tex_example/tex_view_image_video_example.dart';
import 'package:flutter_tex_example/tex_view_ink_well_example.dart';
import 'package:flutter_tex_example/tex_view_markdown_example.dart';
import 'package:flutter_tex_example/tex_view_quiz_example.dart';
import 'package:flutter_tex_example/tex_widget_example.dart';
import 'package:flutter_tex_example/tex_editor/tex_view_editor_example.dart';

/// The main entry point for the Flutter TeX example application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the TeX rendering server to ensure assets are ready.
  await TeXRenderingServer.start();
  runApp(const FlutterTeXExample());
}

/// The root widget of the Flutter TeX example application.
///
/// This widget sets up the [MaterialApp], theme, and routing for the various examples.
class FlutterTeXExample extends StatelessWidget {
  const FlutterTeXExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter TeX Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Indigo 900
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A237E),
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xFF1A237E)),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            side: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TeXViewFullExample(),
        '/editor': (context) => const TeXViewEditorExample(),
        '/widget': (context) => const TeXWidgetExamples(),
        '/document': (context) => const TeXViewDocumentExamples(),
        '/quiz': (context) => const TeXViewQuizExample(),
        '/math2svg': (context) => const Math2SVGExample(),
        '/markdown': (context) => const TeXViewMarkdownExamples(),
        '/fonts': (context) => const TeXViewFontsExamples(),
        '/image_video': (context) => const TeXViewImageVideoExample(),
        '/inkwell': (context) => const TeXViewInkWellExample(),
      },
    );
  }
}

class TeXViewFullExample extends StatelessWidget {
  const TeXViewFullExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ExampleItem> examples = [
      ExampleItem(
        title: 'TeX Editor',
        subtitle: 'Live Formula and Document Editor',
        icon: Icons.edit_note_outlined,
        routeName: '/editor',
        color: Colors.deepOrange,
      ),
      ExampleItem(
        title: 'Math to SVG',
        subtitle: 'Convert equations to vector graphics',
        icon: Icons.transform_outlined,
        routeName: '/math2svg',
        color: Colors.purple,
      ),
      ExampleItem(
        title: 'TeXWidget Example',
        subtitle: 'Core widget implementation',
        icon: Icons.widgets_outlined,
        routeName: '/widget',
        color: Colors.blue,
      ),
      ExampleItem(
        title: 'TeX Documents',
        subtitle: 'Full document rendering',
        icon: Icons.article_outlined,
        routeName: '/document',
        color: Colors.orange,
      ),
      ExampleItem(
        title: 'Markdown Support',
        subtitle: 'Render Markdown with LaTeX',
        icon: Icons.text_snippet_outlined,
        routeName: '/markdown',
        color: Colors.pink,
      ),
      ExampleItem(
        title: 'Custom Fonts',
        subtitle: 'Styling with custom typefaces',
        icon: Icons.font_download_outlined,
        routeName: '/fonts',
        color: Colors.teal,
      ),
      ExampleItem(
        title: 'Media Integration',
        subtitle: 'Images and video support',
        icon: Icons.perm_media_outlined,
        routeName: '/image_video',
        color: Colors.red,
      ),
      ExampleItem(
        title: 'Interactivity',
        subtitle: 'InkWell and touch events',
        icon: Icons.touch_app_outlined,
        routeName: '/inkwell',
        color: Colors.indigo,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Flutter TeX",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Flutter TeX',
                      applicationVersion: '3.6.17',
                      applicationIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/flutter_tex_banner.png',
                            height: 50, width: 50),
                      ),
                      children: const [
                        Text('A Flutter Package to render LaTeX.')
                      ]);
                },
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Container(
                  // Limit maximum width to 750 for centered layout.
                  constraints: const BoxConstraints(maxWidth: 750),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/flutter_tex_banner.png",
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "The most powerful LaTeX rendering for Flutter based on MathJax",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.grey[800],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = examples[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildExampleCard(context, item),
                  );
                },
                childCount: examples.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, ExampleItem item) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, item.routeName),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            )),
      ),
    );
  }
}

class ExampleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String routeName;
  final Color color;

  ExampleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routeName,
    required this.color,
  });
}
