/* Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
                    Icon(
                      Icons.insights_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "AI Match Analysis",
                        style: GoogleFonts.oswald(
                          // Using a different font for title
                          textStyle: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            // Slightly less than bold
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    _buildActionIcons(
                      context,
                      analysisText,
                      liveMatchDetailsState,
                    ),
                  ],
                ),*/