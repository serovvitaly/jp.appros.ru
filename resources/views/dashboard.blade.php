<!DOCTYPE HTML>
<html manifest="">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="UTF-8">

    <title>App</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap.css">

    <style>
        .fa{
            color: #889DAD;
        }
        .fa-lg{
            padding: 5px;
        }
    </style>

    <script>
        var __TOKEN__ = '{{ csrf_token() }}';
    </script>

    <!-- The line below must be kept intact for Sencha Cmd to build your application -->
    <script type="text/javascript" src="/ext/build/ext-all-debug.js"></script>
    <script type="text/javascript" src="/app/app.js"></script>

</head>
<body></body>
</html>
