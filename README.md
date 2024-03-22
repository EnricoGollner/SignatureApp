
# Signature App

Project built to help in signing documents virtually, by simply drawing your signature in the signature pad and picking or shooting an image to sign.

## Packages

 - [signature](https://pub.dev/packages/signature) - Provide the ignature Pad.
 - [lindi_sticker_widget](https://pub.dev/packages/lindi_sticker_widget) - To place the signature in the document.
 - [image_picker](https://bulldogjob.com/news/449-how-to-write-a-good-readme-forour-github-project-y) - Allows to pick an image from the gallery to place the drawn signature in.


## Required Permission (iOS - Image Picker)

**NSPhotoLibraryUsageDescription** - Describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
This permission will not be requested if you always pass false for requestFullMetadata, but App Store policy requires including the plist entry.

**NSCameraUsageDescription** - Describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
## AndroidManifest

#### android/app/src/main

To enable image_crop view, in the path bellow, insert the following activity:

~~~XML
```
<!-- Image Cropper Package requirement -->
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```