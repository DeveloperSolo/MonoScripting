-- Core Scripting Project
project "Scripting"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"
    debugformat "c7"
    warnings "Extra" -- Set warnings level to 4 for all projects.

    -- Engine output directory
    targetdir("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    -- Engine's files
    files
    {
        "src/**.h",
        "src/**.cpp",
    }

    -- Engine's defines 
    defines
    {
        "_CRT_SECURE_NO_WARNINGS",
    }

    -- Engine's include directories
    includedirs
    {
        "src",
        "%{IncludeDir.mono}",
    }

    -- library diretories
    libdirs 
    {
        "%{LibraryDir.mono}",
    }

    -- linking External libraries 
    -- NOTE: do not put their extensions.
    -- IMPORTANT DISCOVERY
    --  For visual studio, If the name of the project is selected it will be linekd via 
    --  VS references directly against other projects.
    --  doesn't show up as links in project properties but instead
    --  can be found on Build Dependencies/Add Reference options
    links
    {
        "mono-2.0-sgen",
    }

    -- Graphic's Dependent defines
    -- filter "platforms:OpenGL"
    --  defines "GRAPHICS_CONTEXT_OPENGL"
        
    filter "system:windows"
        cppdialect "C++17"
        staticruntime "off"
        systemversion "latest"

        defines
        {
            "OO_PLATFORM_WINDOWS",
            "GRAPHICS_CONTEXT_OPENGL"
        }

        -- shortcuts
        binOut = "../bin/" .. outputdir
        binEngine = binOut .. "/" .. Engine
        
        --enable this post build command for 64 bit system
        architecture "x86_64"
        postbuildcommands
        {
        }

    filter{ "configurations:Debug or Release", "platforms:Editor"}
        defines { "TRACY_ENABLE", "TRACY_ON_DEMAND" }
    filter{}

    filter "configurations:Debug"
        defines "OO_DEBUG"
        symbols "On"
        
        architecture "x86_64"
        postbuildcommands
        {
        }

    filter "configurations:Release"
        defines "OO_RELEASE"
        optimize "On"

        architecture "x86_64"
        postbuildcommands
        {
        }

    filter "configurations:Production"
        defines "OO_PRODUCTION"
        optimize "On"

        architecture "x86_64"
        postbuildcommands
        {
        }

