package com.ehealthsystem.user


import android.Manifest
import android.app.Activity
import android.app.Dialog
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.telephony.TelephonyManager
import android.view.View
import android.view.Window
import android.widget.Button
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.eHealthSystem/goAnotherApp"

    lateinit var result: MethodChannel.Result

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            this.result = result
            if (call.method == "getBatteryLevel") {

            }
            else if (call.method == "intentTest") {
                var isAppInstalled = appInstalledOrNot("com.safey.lungmonitoring")
                if (isAinaPackageAvailableSpiro(this@MainActivity)) {
                    if (isAppInstalled)
                    {
                        val string: String = call.arguments as String
                        val data: List<String> = string.split(",")

                        val LaunchIntent = packageManager
                            .getLaunchIntentForPackage("com.safey.lungmonitoring")
                        LaunchIntent!!.action = Intent.ACTION_SEND
//                LaunchIntent.setAction(Intent.ACTION_VIEW)
//                LaunchIntent.putExtra(Intent.EXTRA_TEXT, "Sanjaya Your App is Good")
                        LaunchIntent.putExtra("FirstName", data[0])
                        LaunchIntent.putExtra("LastName", data[1])
                        LaunchIntent.putExtra("Gender", data[2])
                        LaunchIntent.putExtra("Height", data[3])
                        LaunchIntent.putExtra("ethnicity", data[4])
                        LaunchIntent.putExtra("avatar", "")
                        LaunchIntent.putExtra("HeightUnit", "1")
                        LaunchIntent.putExtra("BirthDate", data[7])
                        LaunchIntent.putExtra("UHID", data[5])
                        LaunchIntent.putExtra("Age", data[6])
                        LaunchIntent.putExtra("createdDate", data[8])
                        LaunchIntent.putExtra("createdTime", data[9])
                        LaunchIntent.putExtra("vendorId", data[10])
//                LaunchIntent.putExtra("weight", data.get(5))
//                LaunchIntent.putExtra("age", data.get(6))
                        LaunchIntent.type = "text/plain"
                        /* val t = Toast.makeText(
                             this@MainActivity,
                             "Height: " + data.get(4) + " Weight: " + data.get(5),
                             Toast.LENGTH_SHORT
                         )
                         t.show()*/
                        startActivity(LaunchIntent)

                    }
                    else{
                        redirectToPlayStore2("https://drive.google.com/file/d/1lSscdZYVNGC-THEJciZNH4ZsVDPINTb4/view?usp=sharing");

                    }
                }
                else{
                    var dialog = Dialog(this@MainActivity)
                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE) //before
                    dialog.setContentView(R.layout.noapkdialog)
                    val downloadbtn: Button = dialog.findViewById(R.id.downloadbtn) as Button
                    downloadbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            // Do some work here
                            redirectToPlayStore2("https://drive.google.com/file/d/1lSscdZYVNGC-THEJciZNH4ZsVDPINTb4/view?usp=sharing");
                        }

                    })
                    val cancelbtn: Button = dialog.findViewById(R.id.cancelbtn) as Button
                    cancelbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            dialog.dismiss()
                        }
                    })
                    dialog.show()
                }

            }
            else if (call.method == "writzo") {
                val string: String = call.arguments as String
                val data: List<String> = string.split(",")
                val intent = Intent()
                intent.setComponent(
                    ComponentName(
                        "com.wrizto.samvita",
                        "com.wrizto.samvita.Kit.RecordVitalsActivity"
                    )
                )
                intent.setAction(Intent.ACTION_VIEW)

                intent.putExtra("UHID", data[0])

                intent.putExtra("username", "connect@ehs.com")

                intent.putExtra("password", "User@123")

                intent.putExtra("Age", data[1])

                intent.putExtra("Gender", data[2])

                intent.putExtra("Name", data[3])

                intent.putExtra("filepath", data[4])

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)

                intent.setType("text/plain")

                intent.toUri(Intent.URI_INTENT_SCHEME)

                try {

                    startActivityForResult(intent, 1002)

                } catch (e: Exception) {

                    //Log.v("DATA_TRANSFER", e.message!!)

                }

            }
            else if (call.method == "call_nadi") {

                var isAppInstalled = appInstalledOrNot("com.example.ehs_app")
                if (isAinaPackageAvailableNadi(this@MainActivity)) {
                    if (isAppInstalled){
                        val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
//                val LaunchIntent = packageManager
//                    .getLaunchIntentForPackage("com.example.ehs_app")
                        /* val LaunchIntent = packageManager
                             .getLaunchIntentForPackage("com.example.untitled")
                         LaunchIntent!!.action = Intent.ACTION_SEND*/
                        val intent = Intent()

                        intent.setComponent(
                            ComponentName(
                                "com.example.ehs_app",
                                "com.example.ehs_app.MainActivity",
                            )
                        )

                        intent.setAction("com.example.ehs_app")
                        intent.action = Intent.ACTION_SEND
                        intent.putExtra("UHID", data[0])
//                intent.putExtra(Intent.EXTRA_TEXT, "Jatin")
                        intent.putExtra("Age", data[1])

                        intent.putExtra("Gender",data[2])

                        intent.putExtra("Name",data[3])


                        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)

                        intent.setType("text/plain")

                        intent.toUri(Intent.URI_INTENT_SCHEME)

                        try {

                            startActivityForResult(intent, 1003)

                        } catch (e: Exception) {

                            //Log.v("DATA_TRANSFER", e.message!!)

                        }

                    }
                    else{
                        redirectToPlayStore2("https://drive.google.com/file/d/1a2nbNlYqLgDklNIdf0Svn6Jw5hOtgeyC/view?usp=sharing");

                    }
                }else{
                    var dialog = Dialog(this@MainActivity)
                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE) //before
                    dialog.setContentView(R.layout.noapkdialog)
                    val downloadbtn: Button = dialog.findViewById(R.id.downloadbtn) as Button
                    downloadbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            // Do some work here
                            redirectToPlayStore2("https://drive.google.com/file/d/1a2nbNlYqLgDklNIdf0Svn6Jw5hOtgeyC/view?usp=sharing");
                        }

                    })
                    val cancelbtn: Button = dialog.findViewById(R.id.cancelbtn) as Button
                    cancelbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            dialog.dismiss()
                        }
                    })
                    dialog.show()
                }


            }
            else if (call.method == "ayurythm") {

                val string: String = call.arguments as String
                val data: List<String> = string.split(",")

                System.out.println("The value Tag>>>>>>" + string)

                //Toast.makeText(this@MainActivity, string, Toast.LENGTH_SHORT).show()
                val intent = Intent()

                intent.setComponent(
                    ComponentName(
                        "com.app.ayurythm",
                        "com.app.ayurythm.MainActivity"
                    )
                )

                intent.setAction("com.app.ayurythm.AyurWellness")

                val bundle = Bundle()

                bundle.putString("userId", data[0]) // 2950	(any random unique id)

                bundle.putString("userAge", data[1]) // 30	(in year)

                bundle.putString("userHeight", data[2]) // 170	(in cm)

                bundle.putString("userWeight", data[3]) // 66	(in kg)

                bundle.putString("userGender", data[4])

                intent.putExtra("data", bundle);

                intent.type = "text/plain"

                startActivityForResult(intent, 123)


            }
            else if (call.method == "callUrl") {
                //val intent = Intent(this, WebViewActivity::class.java)
                //intent.putExtra("key", value)
                //startActivity(intent)
            }
            else if (call.method == "deviceId") {
                var value = getIMEIDeviceId(this@MainActivity)
                if (value != null)
                    result.success(value)
                else
                    result.success("Nothing getting")

            }
            else if (call.method == "iLab") {

                var isAppInstalled = appInstalledOrNot("ilabmini.in.ilab")
                if (isAinaPackageAvailable(this@MainActivity)) {
                    if (isAppInstalled) {
                        val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
                        val LaunchIntent = packageManager
                            .getLaunchIntentForPackage("ilabmini.in.ilab")
                        LaunchIntent!!.action = Intent.ACTION_SEND
                        LaunchIntent.putExtra(Intent.EXTRA_TEXT, "1")
                        LaunchIntent.putExtra("apid", "8036d1868bd71fb6b500cb18eeec3936")
                        LaunchIntent.putExtra("puniqueid", data.get(0))
                        LaunchIntent.putExtra("name", data.get(1))
                        LaunchIntent.putExtra("mobile", data.get(2))
                        LaunchIntent.putExtra("gender", data.get(3))
                        LaunchIntent.putExtra("height", data.get(4))
                        LaunchIntent.putExtra("weight", data.get(5))
                        LaunchIntent.putExtra("age", data.get(6))
                        LaunchIntent.type = "text/plain"
                        /* val t = Toast.makeText(
                             this@MainActivity,
                             "Height: " + data.get(4) + " Weight: " + data.get(5),
                             Toast.LENGTH_SHORT
                         )
                         t.show()*/
                        startActivity(LaunchIntent)

                    } else {
                        /*val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
                        Toast.makeText(this@MainActiivty, "Height: "+data.get(4)+" Weight: "+data.get(5), Toast.LENGTH_SHORT).show()*/
                        redirectToPlayStore()

                        // Do whatever we want to do if application not installed
                        // For example, Redirect to play store

                        // Log.i("Application is not currently installed.");
                    }
                } else {
                    var dialog = Dialog(this@MainActivity)
                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE) //before
                    dialog.setContentView(R.layout.noapkdialog)
                    val downloadbtn: Button = dialog.findViewById(R.id.downloadbtn) as Button
                    /*downloadbtn.setOnClickListener(object : View.OnClickListener() {
                        fun onClick(view: View?) {
                            redirectToPlayStore()
                            //   Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.janacare.aina.production"));
                            // startActivity(intent);
                        }
                    })*/
                    downloadbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            // Do some work here
                            redirectToPlayStore()
                        }

                    })
                    val cancelbtn: Button = dialog.findViewById(R.id.cancelbtn) as Button
                    cancelbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            dialog.dismiss()
                        }
                    })
                    dialog.show()
                }

            } else if (call.method == "lab2") {

                var isAppInstalled = appInstalledOrNot("info.safey.peakflowapp")
                if (isAinaPackageAvailable1(this@MainActivity)) {
                    if (isAppInstalled) {
                        val string: String = call.arguments as String
//                        val data: List<String> = string.split(",")
                        val LaunchIntent = packageManager
                            .getLaunchIntentForPackage("info.safey.peakflowapp")
                        LaunchIntent!!.action = Intent.ACTION_SEND
                        LaunchIntent.putExtra(Intent.EXTRA_TEXT, "1")
//                        LaunchIntent.putExtra("apid", "8036d1868bd71fb6b500cb18eeec3936")
//                        LaunchIntent.putExtra("puniqueid", data.get(0))
//                        LaunchIntent.putExtra("name", data.get(1))
//                        LaunchIntent.putExtra("mobile", data.get(2))
//                        LaunchIntent.putExtra("gender", data.get(3))
//                        LaunchIntent.putExtra("height", data.get(4))
//                        LaunchIntent.putExtra("weight", data.get(5))
//                        LaunchIntent.putExtra("age", data.get(6))
                        LaunchIntent.type = "text/plain"
                        /* val t = Toast.makeText(
                             this@MainActivity,
                             "Height: " + data.get(4) + " Weight: " + data.get(5),
                             Toast.LENGTH_SHORT
                         )
                         t.show()*/
                        startActivity(LaunchIntent)

                    } else {
                        /*val string: String = call.arguments as String
                        val data: List<String> = string.split(",")
                        Toast.makeText(this@MainActiivty, "Height: "+data.get(4)+" Weight: "+data.get(5), Toast.LENGTH_SHORT).show()*/
                        redirectToPlayStore1()

                        // Do whatever we want to do if application not installed
                        // For example, Redirect to play store

                        // Log.i("Application is not currently installed.");
                    }
                } else {
                    var dialog = Dialog(this@MainActivity)
                    dialog.requestWindowFeature(Window.FEATURE_NO_TITLE) //before
                    dialog.setContentView(R.layout.noapkdialog1)
                    val downloadbtn: Button = dialog.findViewById(R.id.downloadbtn) as Button
                    /*downloadbtn.setOnClickListener(object : View.OnClickListener() {
                        fun onClick(view: View?) {
                            redirectToPlayStore()
                            //   Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.janacare.aina.production"));
                            // startActivity(intent);
                        }
                    })*/
                    downloadbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            // Do some work here
                            redirectToPlayStore1()
                        }

                    })
                    val cancelbtn: Button = dialog.findViewById(R.id.cancelbtn) as Button
                    cancelbtn.setOnClickListener(object : View.OnClickListener {
                        override fun onClick(view: View?) {
                            dialog.dismiss()
                        }
                    })
                    dialog.show()
                }

            } else {
                result.notImplemented()
            }
        }
    }


    fun redirectToPlayStore() {
        val url =
            "https://drive.google.com/file/d/1iB4IUeT4vOV9lCRiEwilbHLYA-DBlgJ2/view?usp=sharing"
        // String url="https://drive.google.com/file/d/1cDKAENDCdOOzyk9jwOtHjRs8gE3PVxW8/view?usp=sharing";
        val i = Intent(Intent.ACTION_VIEW)
        i.data = Uri.parse(url)
        startActivity(i)
    }

    fun redirectToPlayStore2(url:String) {
        val i = Intent(Intent.ACTION_VIEW)
        i.data = Uri.parse(url)
        startActivity(i)
    }


    fun redirectToPlayStore1() {
        val url =
            "https://play.google.com/store/apps/details?id=info.safey.peakflowapp"
        // String url="https://drive.google.com/file/d/1cDKAENDCdOOzyk9jwOtHjRs8gE3PVxW8/view?usp=sharing";
        val i = Intent(Intent.ACTION_VIEW)
        i.data = Uri.parse(url)
        startActivity(i)
    }

    private fun appInstalledOrNot(uri: String): Boolean {
        val pm: PackageManager = packageManager
        try {
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
            return true
        } catch (e: PackageManager.NameNotFoundException) {
        }
        return false
    }

    fun isAinaPackageAvailable(context: Context): Boolean {
        val packages: List<ApplicationInfo>
        val pm: PackageManager
        pm = context.getPackageManager()
        packages = pm.getInstalledApplications(0)
        for (packageInfo in packages) {
            if (packageInfo.packageName.contains("ilabmini.in.ilab")) {
                return true
            }
        }
        return false
    }

    fun isAinaPackageAvailableSpiro(context: Context): Boolean {
        val packages: List<ApplicationInfo>
        val pm: PackageManager
        pm = context.getPackageManager()
        packages = pm.getInstalledApplications(0)
        for (packageInfo in packages) {
            if (packageInfo.packageName.contains("com.safey.lungmonitoring")) {
                return true
            }
        }
        return false
    }

    fun isAinaPackageAvailableNadi(context: Context): Boolean {
        val packages: List<ApplicationInfo>
        val pm: PackageManager
        pm = context.getPackageManager()
        packages = pm.getInstalledApplications(0)
        for (packageInfo in packages) {
            if (packageInfo.packageName.contains("com.example.ehs_app")) {
                return true
            }
        }
        return false
    }

    fun isAinaPackageAvailable1(context: Context): Boolean {
        val packages: List<ApplicationInfo>
        val pm: PackageManager
        pm = context.getPackageManager()
        packages = pm.getInstalledApplications(0)
        for (packageInfo in packages) {
            if (packageInfo.packageName.contains("info.safey.peakflowapp")) {
                return true
            }
        }
        return false
    }

    fun getIMEIDeviceId(context: Context): String? {
        var deviceId: String
        deviceId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
        } else {
            val mTelephony = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (context.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) !=
                    PackageManager.PERMISSION_GRANTED
                ) {
                    return ""
                }
            }
            //assert mTelephony != null;
            if (mTelephony.deviceId != null) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    mTelephony.imei
                } else {
                    mTelephony.deviceId
                }
            } else {
                Settings.Secure.getString(
                    context.contentResolver,
                    Settings.Secure.ANDROID_ID
                )
            }
        }
        if (deviceId == "" || deviceId == null) {
            val android_id = Settings.Secure.getString(
                applicationContext.contentResolver,
                Settings.Secure.ANDROID_ID
            )
            deviceId = android_id
        }
        return deviceId
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 1002) {
            val bundle: Bundle? = data!!.getBundleExtra("data")
            val vitalData: String? = bundle?.getString("vitalsJsonData")
            /*  Toast.makeText(this, "In Android Code:" + vitalData, Toast.LENGTH_SHORT).show()*/
            this.result.success(vitalData)
        } else if (requestCode == 123 && resultCode == Activity.RESULT_OK) {

            val bundle: Bundle? = data!!.getBundleExtra("data")
            val resultData: String? = bundle?.getString("result")
            val sparshna: String? = bundle?.getString("sparshna")
            val vikriti: String? = bundle?.getString("vikriti")
            val prakriti: String? = bundle?.getString("prakriti")


            var mainJson1: JSONObject = JSONObject();
            var mainJson2: JSONObject = JSONObject();
            var mainJson3: JSONObject = JSONObject();
            var mainJson4: JSONObject = JSONObject();

            mainJson1.put("data", resultData)
            mainJson2.put("sparshna",sparshna)
            mainJson3.put("vikriti",vikriti)
            mainJson4.put("prakriti",prakriti)
        /*    var finalVal:String? = "$mainJson1,$mainJson2,$mainJson3,$mainJson4";*/
            var finalVal:String? = "$resultData#$sparshna#$vikriti#$prakriti";
            var finalVal1:String? = resultData+"@"+sparshna+"@"+vikriti+"@"+prakriti;

//            var finalVal1:String? = resultData;
//            Toast.makeText(
//                this,
//                "In Android Code: ${resultData.toString()}  ${sparshna.toString()}  ${vikriti.toString()}  ${prakriti.toString()}  ",
//                Toast.LENGTH_LONG
//            ).show()


            this.result.success(finalVal1.toString())
        }else if (requestCode == 1003) {
            val resultData: String? = data?.getStringExtra("data")
            /*  Toast.makeText(this, "In Android Code:" + vitalData, Toast.LENGTH_SHORT).show()*/
            this.result.success(resultData)
        }
        else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}
