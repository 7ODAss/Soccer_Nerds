import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for Clipboard
import 'package:google_fonts/google_fonts.dart';

class AiPreview extends StatelessWidget {
  final String? result;
  const AiPreview({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a gradient for a modern, tech-inspired background
      backgroundColor: Color(0xFF0A1931),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Custom app bar row for a cleaner look
              _buildAppBar(context),
              const SizedBox(height: 20),
              // The main analysis card
              _buildAiAnalysisView(context, result ?? "No analysis available."),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a custom app bar using a Row.
  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
        const Icon(
          Icons.insights_rounded,
          color: Colors.orangeAccent,
          size: 26,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "AI Match Analysis",
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the main card that displays the AI-generated text.
  Widget _buildAiAnalysisView(BuildContext context, String analysisText) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Color(0xFF185ADB),//theme
              // Color(0xFF0A1931),//theme
              Color(0xFF1E2A4A),
              Color(0xFF121B34),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox.shrink()), // Spacer
                  // Copy to clipboard button for user convenience
                  IconButton(
                    icon: Icon(
                      Icons.copy_all_outlined,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    iconSize: 22,
                    tooltip: "Copy Analysis",
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: analysisText));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('AI analysis copied to clipboard!'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          )
                      );
                    },
                  ),
                ],
              ),
              Divider(
                height: 10.0,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              // Display the analysis text
              Text(
                analysisText.trim(),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    height: 1.6, // Increased line spacing for readability
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
