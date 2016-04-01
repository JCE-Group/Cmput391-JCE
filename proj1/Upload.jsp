<html>
	<head>
		Upload your image! ${username}
	</head>

	<body>
		<form enctype=multipart/form-data name="upload-image" method="post" action="UploadImage">
			File path: <input type = "file" name = "file-path" > <br>
			<input type = "submit" name = "upload" value = "Upload">
		</form>
	</body>
</html>
