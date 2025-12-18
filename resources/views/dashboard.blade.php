<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background: #f0f0f0; }
        .welcome-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        h1 { color: #333; margin-bottom: 20px; }
        p { color: #666; margin-bottom: 20px; }
        a { display: inline-block; padding: 12px 24px; background: #e3342f; color: white; text-decoration: none; border-radius: 4px; }
        a:hover { background: #cc1f1a; }
    </style>
</head>
<body>
    <div class="welcome-box">
        <h1>¡Bienvenido!</h1>
        <p>Hola, {{ Auth::user()->name }}. Has iniciado sesión correctamente.</p>
        <form method="POST" action="{{ route('logout') }}" style="display:inline;">
            @csrf
            <button type="submit" style="padding: 12px 24px; background: #e3342f; color: white; border: none; border-radius: 4px; cursor: pointer;">Cerrar Sesión</button>
        </form>
    </div>
</body>
</html>
