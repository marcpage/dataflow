cmake_minimum_required(VERSION 3.21)

project(DataFlow VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets)
qt_standard_project_setup()

# set(MACOSX_BUNDLE_ICON_FILE MyApp.icns)
# set(APP_ICON "${CMAKE_CURRENT_SOURCE_DIR}/resources/MyApp.icns")
# set_source_files_properties(${APP_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

qt_add_executable(DataFlow
    src/main.cpp
    src/MainWindow.cpp
    src/MainWindow.h
    src/rsc/resources.qrc
    ${APP_ICON}
)

target_link_libraries(DataFlow PRIVATE Qt6::Widgets)
set_target_properties(DataFlow PROPERTIES
    MACOSX_BUNDLE ON
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.resolvetoexcel.DataFlow"
    MACOSX_BUNDLE_BUNDLE_NAME "DataFlow"
    MACOSX_BUNDLE_BUNDLE_VERSION "${PROJECT_VERSION}"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
    MACOSX_BUNDLE_COPYRIGHT "(C) 2026 Resolve To Excel"
)

install(TARGETS DataFlow BUNDLE DESTINATION .)
qt_generate_deploy_app_script(
    TARGET DataFlow
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
)

install(SCRIPT ${deploy_script})

# cmake -S . -B build -G Ninja -DCMAKE_PREFIX_PATH="dependencies/qt/6.11.1"
# ninja -C build -j 8
