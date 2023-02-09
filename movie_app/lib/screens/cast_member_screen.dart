import 'package:flutter/material.dart';
import 'package:movie_app/models/cast_member_response.dart';
import 'package:movie_app/models/credits_response.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class CastMemberScreen extends StatelessWidget {
  const CastMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cast castMember = ModalRoute.of(context)!.settings.arguments as Cast;
    final size = MediaQuery.of(context).size;
    final MoviesProvider moviesProvider =
        Provider.of<MoviesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(castMember.name)),
      body: FutureBuilder(
        future: moviesProvider.getCastMemberInfo(castMember.id),
        builder: (context, AsyncSnapshot<CastMemberResponse> snapshot) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: snapshot.data?.id ?? '',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          image: NetworkImage(castMember.fullProfilePath),
                          placeholder: const AssetImage('assets/no-image.jpg'),
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width - 160),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            castMember.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            snapshot.data?.getBirthDate() ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          if (snapshot.data?.deathday != null)
                            Text(
                              snapshot.data?.getDeathDate() ?? '',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          Text(
                            '${snapshot.data?.placeOfBirth}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Popularidad: ${snapshot.data?.popularity}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Biografía',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(snapshot.data?.biography != ''
                        ? '${snapshot.data?.biography}'
                        : 'Biografía no disponible'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
