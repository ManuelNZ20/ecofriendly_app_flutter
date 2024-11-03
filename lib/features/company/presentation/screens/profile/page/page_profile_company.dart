import 'package:ecofriendly_app/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecofriendly_app/core/shared/shared.dart';
import '../../../providers/company_app_provider.riverpod.dart';

class PageProfileCompany extends ConsumerWidget {
  static const String name = 'page_profile_company';
  const PageProfileCompany({
    super.key,
    required this.idCompany,
  });

  final String idCompany;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final companyRes = ref.watch(companyProvider(idCompany));
    final textMessage = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey.shade600,
        );
    final textInfo = Theme.of(context).textTheme.bodyLarge!.copyWith(
        // color: Colors.grey.shade600,
        );
    const double radius = 40;
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Perfil general'),
      ),
      body: companyRes.isLoading
          ? const FullScreenLoader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perfil ecofriendly',
                    style: textMessage,
                  ),
                  Text(
                    companyRes.company!.nameCompany,
                    style: textInfo,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    height: 140,
                    child: companyRes.company!.bannerCompany!.isEmpty
                        ? Container(
                            color: Colors.grey.shade300,
                            child: const Text('Not banner'),
                          )
                        : Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  companyRes.company!.bannerCompany!,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 8,
                                  bottom: 8,
                                  child: companyRes
                                          .company!.imgPresentation!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: radius,
                                          backgroundImage: NetworkImage(
                                            companyRes
                                                .company!.imgPresentation!,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          radius: radius,
                                          backgroundImage: AssetImage(
                                              'assets/images/image-not-found.png'),
                                        ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width,
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: listShadowCard,
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width,
                              child: Text(
                                companyRes.company!.email,
                                softWrap: true,
                                style: textInfo,
                              ),
                            ),
                            Text(
                              companyRes.company!.ruc!,
                              style: textInfo,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 15,
                    top: 120,
                    child: SizedBox(
                      width: size.width * .9,
                      height: 100,
                      child: ListView(
                        children: [
                          Text(
                            companyRes.company!.description!,
                            softWrap: true,
                            style: textInfo,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Text(companyRes.company!.nameCompany),
                ],
              ),
            ),
    );
  }
}
