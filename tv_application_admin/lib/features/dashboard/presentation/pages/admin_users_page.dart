import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_application_admin/features/dashboard/presentation/providers/admin_users_provider.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the page loads
    Future.microtask(() => 
      context.read<AdminUsersProvider>().fetchUsers()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminUsersProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Text('Error: ${provider.error}'),
          );
        }

        if (provider.users.isEmpty) {
          return const Center(
            child: Text('No users found'),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
              ],
              rows: provider.users.map((user) {
                return DataRow(
                  cells: [
                    DataCell(Text(user.id?.toString() ?? 'N/A')),
                    DataCell(Text(user.userName ?? 'N/A')),
                    DataCell(Text(user.email ?? 'N/A')),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
} 