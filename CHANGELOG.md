# Changelog

## 0.1.0 — Initial Release

### Added

- **Tracker** — connection, instance, thread, and custom object lifecycle management with automatic cleanup
- **Logger** — scoped logging with configurable levels (`Internal`, `Info`, `Warn`, `Error`, `Fatal`) and plugin name prefix
- **Ribbon** — toolbar and button management with `CreateButton` and `SetCallback`
- **Widget** — `NewDockWidget` and `NewOverlay` with a shared `Show`, `Hide`, `Toggle`, `SetEnabled` interface
- **History** — `Record`, `SetWaypoint`, `ResetWaypoints`, `Undo`, `Redo` with `Commit`, `Cancel`, and `Append` on recording handles
- **Internals** — internal tracker and signal for framework lifecycle management
- `Framework.Unloading` signal fired before plugin unloads
