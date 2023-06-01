

include(ExternalProject)
ExternalProject_Add(
        UnityTestFramework
        PREFIX ${CMAKE_SOURCE_DIR}/external
        GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
        GIT_TAG v2.5.1
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/external
        TMP_DIR ${CMAKE_SOURCE_DIR}/external/UnityFramework/tmp
        SOURCE_DIR ${CMAKE_SOURCE_DIR}/external/UnityFramework/Unity
        STAMP_DIR ${CMAKE_SOURCE_DIR}/external/UnityFramework/tmp
        BINARY_DIR ${CMAKE_SOURCE_DIR}/external/UnityFramework/tmp
        PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_LIST_DIR}/patches/0001-unity-test-applied-color-changes.patch
        TEST_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""

)


#add_custom_target(WaitForUnity
#        # Add a command that waits for the external project to be downloaded
#        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target Unity
#        # Add any other dependencies if needed
#)

set(UNITY_UPDATE_REQUIRED TRUE)

ExternalProject_Get_Property(UnityTestFramework SOURCE_DIR)
message("[install_unity.cmake] Source dir for unity: ${SOURCE_DIR}")

set(Unity_SOURCES
        ${SOURCE_DIR}/src/unity.c
        )
set(Unity_INCLUDE
        ${SOURCE_DIR}/src
        )

if (EXISTS ${Unity_SOURCES})
    message ("Unity sources already exist")
    set(UNITY_UPDATE_REQUIRED FALSE)
else ()
    message ("unity sources download required")
    set_source_files_properties(
            ${SOURCE_DIR}/src/unity.c
            PROPERTIES GENERATED TRUE
    )
    set(UNITY_UPDATE_REQUIRED TRUE)
endif ()

add_custom_command(
        TARGET UnityTestFramework
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_SOURCE_DIR}/external/UnityFramework/tmp
)
