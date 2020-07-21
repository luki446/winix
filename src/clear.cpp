#include <windows.h>

int main() {
    const COORD screenCoordinates{0, 0};
    DWORD charsWritten;
    CONSOLE_SCREEN_BUFFER_INFO csinfo;
    auto handle = GetStdHandle(STD_OUTPUT_HANDLE);

    GetConsoleScreenBufferInfo(handle, &csinfo);
    DWORD consoleSize = csinfo.dwSize.X * csinfo.dwSize.Y;

    FillConsoleOutputCharacter(handle, (WCHAR) ' ', consoleSize, screenCoordinates, &charsWritten);

    SetConsoleCursorPosition(handle, screenCoordinates);
}