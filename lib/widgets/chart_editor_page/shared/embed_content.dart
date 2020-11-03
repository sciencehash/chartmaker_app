import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';
import '../../../models/app_chart.dart';

class EmbedContent extends StatefulWidget {
  @override
  _EmbedContentState createState() => _EmbedContentState();
}

class _EmbedContentState extends State<EmbedContent> {
  String _lib;

  TextEditingController _textController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  EditorCubit _editorCubit;

  @override
  void initState() {
    //
    context.bloc<EditorCubit>().updateChart(hideViewer: true);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //
    _editorCubit = context.bloc<EditorCubit>();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //
    _editorCubit.updateChart(hideViewer: false);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    AppChart appChart =
        (context.bloc<EditorCubit>().state as EditorLoaded).appChart;
    //
    _lib = appChart.config['lib'];

    //
    _textController.text = appChart.getEmbedContent();

    //
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: Text('Embed'),
          backgroundColor: Colors.transparent,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Copy the next text in your website:'),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white.withOpacity(.1),
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
            enableInteractiveSelection: true,
            maxLines: 5,
            readOnly: true,
          ),
          // child: SelectableText(
          //   '''<iframe id="iframe123456" width="100%" style="border:none" scrolling="no" srcdoc="&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js&quot; integrity=&quot;sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==&quot; crossorigin=&quot;anonymous&quot;&gt;&lt;/script&gt;&lt;script defer src=&quot;../dist/chartmaker.min.js&quot;&gt;&lt;/script&gt;&lt;canvas id=&quot;chart&quot;&gt;&lt;/canvas&gt;"></iframe>
          //       <script></script>''',
          // ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FlatButton(
            child: Text('Select All'),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _textController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _textController.text.length,
              );
              _focusNode.requestFocus();
            },
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
