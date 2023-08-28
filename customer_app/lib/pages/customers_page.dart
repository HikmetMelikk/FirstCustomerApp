import 'package:customer_app/models/post.dart';
import 'package:customer_app/services/remote_service.dart';
import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetching data
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers Page'),
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 75,
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts![index].customerName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            posts![index].customerPhone,
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
