import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodninga/core/colors.dart';
import 'package:foodninga/core/textstyle.dart';
import 'package:foodninga/core/utils/app_loading_widget.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_cubit.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_state.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodninga/features/auth/presentation/widgets/custom_elvetedbutton.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _categories = [
    'Burger',
    'Pizza',
    'Drinks',
    'Desserts',
    'Salads',
    'Meals',
  ];
  String? _selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  final cubit = context.read<AdminCubit>();

                  return GestureDetector(
                    onTap: () async {
                      await cubit.pickImage();
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.6),
                          width: 1.5.w,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: cubit.selectedProductImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                cubit.selectedProductImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: AppColors.primary,
                                  size: 30.sp,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Upload',
                                  style: AppTextStyles.font14NormalGrey
                                      .copyWith(
                                        color: AppColors.primary,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),

            CustomTextfield(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
              controller: _nameController,
              hinttext: "Product Name",
              prefix: Icon(Icons.fastfood_outlined, color: AppColors.primary),
              width: double.infinity,
            ),
            SizedBox(height: 10.h),

            CustomTextfield(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product price';
                }
                return null;
              },
              controller: _priceController,
              hinttext: "Price (\$)",
              prefix: Icon(
                Icons.attach_money_outlined,
                color: AppColors.primary,
              ),
              width: double.infinity,
            ),
            SizedBox(height: 10.h),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              dropdownColor: const Color(0xFF1E1E1E),
              icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Select Category',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                prefixIcon: Icon(
                  Icons.category_outlined,
                  color: AppColors.primary,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),

            CustomTextfield(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product description';
                }
                return null;
              },
              controller: _descriptionController,
              hinttext: "Description",
              prefix: Icon(
                Icons.description_outlined,
                color: AppColors.primary,
              ),
              height: 90,
              width: double.infinity,
            ),
            SizedBox(height: 20.h),

            Center(
              child: BlocConsumer<AdminCubit, AdminState>(
                listener: (context, state) {
                  if (state is AdminSuccess) {
                    _nameController.clear();
                    _priceController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _selectedCategory = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product Added Successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AdminError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AdminLoading) {
                    return const AppLoadingWidget();
                  }
                  return CustomElevetedboutton(
                    title: "Add Product",
                    width: 200,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AdminCubit>().addproduct(
                          name: _nameController.text,
                          price: double.parse(_priceController.text),
                          descreption: _descriptionController.text,
                          category: _selectedCategory!,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
