# 1.0.2
- **Web Caching Support**: Added support for caching in web applications to enhance performance and reduce loading times.

# 1.0.1
- **Fixed Links in README**: Corrected some links in the README for better navigation and clarity.

# 1.0.0

- **Initial Release**: Released initial version of the image_craft package, supporting image loading from various sources (network, assets, SVG, and files) with caching, error handling, and loading indicators.
- **Image Types**: Implemented support for four image types: NETWORK, ASSET, SVG, and FILE.
- **Caching Mechanism**: Added a caching manager to handle temporary file storage and cleanup.
- **Error Handling**: Included error and loading placeholders for improved user experience during image loading.
- **Pre-Caching**: Introduced pre-caching for assets to enhance performance.
- **ImageLoader Interface**: Defined an abstract `ImageLoader` class to standardize image loading across different implementations.
- **Factory Pattern**: Implemented an `ImageLoaderFactory` to provide instances of specific image loaders based on the image type.
- **Documentation**: Comprehensive documentation added for all classes and methods.