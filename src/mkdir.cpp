#include <filesystem>

int main(int argc, char* argv[]) {
    for(int i = 1 ; i < argc ; ++i) {
        std::filesystem::create_directory(argv[i]);
    }

    return 0;
} 