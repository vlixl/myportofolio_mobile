# myportofolio_mobile

### Tugas 7

#### AI Declaration
Dalam pengerjaan tugas 7, AI digunakan dalam memahami beberapa konsep-konsep flutter seperti widget tree, state, serta mengidentifikasi fungsi dan kegunaan masing-masing widget. Secara umum, AI berguna dalam memahami dan berdiskusi tentang hal-hal yang tidak tertera dalam dokumentasi. Contohnya, AI dapat membantu menjelaskan bagaimana masing-masing widget saling berinteraksi dalam suatu aplikasi, serta bagaimana arsitektur pemrograman yang cocok digunakan dalam persoalan tertentu. 

1. Widget tree dalam flutter adalah kerangka hierarkis yang menunjukkan hubungan antar-widget dalam sebuah antarmuka. Dalam ini, hubungan parent-child secara umum berarti parent widget akan membungkus child widget di dalamnya. Sebagai contoh, widget Center yang membungkus widget Text akan mengetengahkan widget Text tersebut.

2. Widget-widget yang digunakan meliputi:
    - MyApp	        Widget utama aplikasi yang mengembalikan MaterialApp.
    - MaterialApp	Mengatur konfigurasi aplikasi, seperti tema, judul, dan halaman utama.
    - MyHomePage	Widget yang menampilkan halaman utama aplikasi.
    - Scaffold	    Menyediakan struktur dasar halaman, termasuk appBar dan body.
    - AppBar	    Menampilkan bilah atas dengan judul MyPortfolio.
    - Text	        Menampilkan teks, seperti nama, NPM, kelas, dan label tombol.
    - Padding	    Memberikan jarak di sekitar widget anak.
    - Column	    Menyusun widget secara vertikal.
    - Row	        Menyusun widget secara horizontal, khususnya ketiga InfoCard.
    - InfoCard	    Widget buatan sendiri untuk menampilkan informasi NPM, nama, dan kelas.
    - Card	        Menampilkan informasi dalam bentuk kartu dengan efek elevasi.
    - Container	    Mengatur ukuran, padding, dan tampilan widget anak.
    - SizedBox	    Memberikan jarak kosong antar-widget.
    - Center	    Memosisikan widget anak di tengah.
    - GridView	    Menyusun tombol menu dalam grid dengan tiga kolom.
    - ItemCard	    Widget buatan sendiri yang menampilkan tombol menu berdasarkan data ItemHomepage.
    - Material	    Memberikan permukaan Material dengan warna dan sudut membulat pada tombol.
    - InkWell	    Mendeteksi interaksi pengguna dan memberikan efek visual ketika tombol ditekan.
    - Icon	        Menampilkan ikon pada setiap tombol menu.
    - SnackBar	    Menampilkan pesan sementara ketika pengguna menekan tombol menu.

3. Dikutip dari dokumentasi, MaterialApp adalah "An application that uses Material Design." 
    MaterialApp merupakan widget yang menyediakan konfigurasi aplikasi Flutter berdasarkan Material Design. Fungsinya meliputi:
    - Mengatur tema aplikasi melalui theme.
    - Mengatur navigasi antarlayar melalui sistem routing.
    - Menentukan halaman awal melalui home.
    MaterialApp umumnya digunakan sebagai root widget karena semua widget di bawahnya memerlukan konfigurasi yang disediakan oleh MaterialApp.

4. `StatelessWidget` adalah widget yang tidak memiliki state internal. Widget ini cocok untuk menampilkan elemen yang tidak memerlukan perubahan state akibat interaksi pengguna. Hal ini meliputi teks, icon, dll. Sedangkan, `StatefulWidget` adalah widget yang memiliki objek `State` untuk menyimpan data yang dapat berubah selama aplikasi berjalan. Ketika state berubah, metode `setState()` akan membangun ulang widget berdasarkan data yang baru. 
    Oleh karena itu, `StatelessWidget` sebaiknya digunakan untuk hal-hal yang tidak perlu mengelola state internal yang berubah, sedangkan `Stateful Widget` sebaiknya digunakan untuk hal-hal yang dinamis dan interaktif, sehingga membutuhkan perubahan state.

5. `BuildContext` adalah objek yang merepresentasikan lokasi suatu widget dalam widget tree. Hal ini penting karena konteks memungkinkan widget untuk mengakses informasi dari widget ancestor, seperti Theme, ukuran layar, dll. 
    Dalam flutter, `BuildContext` diterima sebagai parameter pada metode `build(BuildContext context)` dan digunakan ketika membangun widget. Sebagai contoh, `Theme.of(context).colorScheme.primary` digunakan untuk mengambil warna utama dari tema aplikasi.

6. _Hot reload_ adalah fitur Flutter yang memungkinkan developer menerapkan perubahan kode pada aplikasi yang sedang berjalan tanpa perlu dijalankan ulang. Fitur ini mempertahankan state aplikasi sehingga berguna saat mengubah tampilan atau memperbaiki kode. 
    Sementara itu, _Hot restart_ menjalankan ulang aplikasi Flutter dari awal dan menghapus state yang sebelumnya tersimpan. Hot restart digunakan ketika terdapat perubahan yang tidak dapat diterapkan melalui hot reload, seperti perubahan dalam `initState()`, karena fungsi tersebut tidak dijalankan pada hot reload. 
    Terakhir, _full restart_ diperlukan ketika terdapat perubahan yang memerlukan aplikasi dijalankan ulang sepenuhnya, seperti perubahan pada kode native Android atau iOS.


### Tugas 8

#### AI Declaration
Dalam pengerjaan tugas 8, saya menggunakan ChatGPT sebagai alat bantu untuk memahami konsep navigasi, struktur widget, layout, dan validasi form pada Flutter. AI juga digunakan untuk memeriksa kesesuaian penjelasan dengan implementasi kode pada repository.

1. Perbedaan ketiga aksi navigator:
    - `Navigator.push()` membuka sebuah page baru dan menambahkannya pada _navigation stack_, dengan page sebelumnya tetap berada di bawahnya
    - `Navigator.pushReplacement()` membuka sebuah page baru, menggantikan page sebelumnya dalam stack
    - `Navigator.pop()` menghapus route teratas dari navigation stack, sehingga route sebelumnya kembali ditampilkan.

    Kartu aksi menggunakan `Navigator.push()` untuk membuka `ProjectFormPage`. Opsi Home pada drawer menavigasi kembali pada home screen, diimplementasi dengan menggunakan `pushReplacement()` untuk menggantikan page yang sedang aktif dalam navigation stack.

2. `Scaffold` memberikan struktur dasar dari page, `AppBar` memberikan header dari page, dan `Drawer` memberikan menu navigasi yang konsisten. Menggunakan kembali widget-widget ini dalam aplikasi membuat page-page berbeda memiliki layout dan navigasi yang konsisten. 
    Sebagai contoh, portfolio ini menggunakan indigo sebagai tema warna utama. Sebagai contoh, indigo digunakan untuk `AppBar` dan tombol save dalam project form, serta untuk drawer header. 

3. Form dalam aplikasi menggunakan `Column` untuk menyusun input field secara vertikal, membuatnya mudah untuk dibaca dan diisi. Masing-masing field dibungkus dalam `Padding` untuk memberikan spacing, sedangkan `Align` mengetengahkan tombol save dalam sumbu horizontal.
    `SingleChildScrollView` menyediakan scroll vertikal kepada user ketika panjang form melebihi panjang layar, seperti pada tampilan kecil atau ketika ada keyboard yang muncul. Hal ini mencegah _vertical overflow_ dan membuat form lebih mudah untuk digunakan.

4. `GlobalKey<FormState>` memberikan akses pada `State` dari form tersebut. Masing-masing _validator_ mendefinisikan aturan-aturan validasi untuk field-nya, yang mana `validate()` mengeksekusi validator-validator tersebut ketika tombol `Save` ditekan. Dialog berhasil akan muncul hanya bila semua validasi tuntas.

    Sebagai contoh, field nama project menolak input yang kosong atau hanya memiliki whitespace karena nama projek wajib diisi. Validator tersebut menggunakan `trim().isEmpty` dalam implementasinya.

    Memilih jenis input atau papan ketik saja belum cukup karena hal tersebut hanya memengaruhi bagaimana pengguna memasukkan informasi, tanpa menjamin sebuah input yang valid. Validator tetap dibutuhkan untuk memastikan bahwa input memenuhi syarat yang ditetapkan.
