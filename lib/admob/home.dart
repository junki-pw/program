import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:program/admob/att_helper.dart';
import 'package:program/admob/benner.dart';

class AdmobHomeView extends StatefulWidget {
  const AdmobHomeView({super.key});

  @override
  State<AdmobHomeView> createState() => _AdmobHomeViewState();
}

class _AdmobHomeViewState extends State<AdmobHomeView> {
  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  Future<void> _loadInterstitialAd() async {
    print('広告を準備します');
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('onAdDismissedFullScreenContent 発火');
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  // TODO: Add _rewardedAd
  RewardedAd? _rewardedAd;

  // TODO: Implement _loadRewardedAd()
  Future<void> _loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Demo'),
        actions: [
          IconButton(
            onPressed: () {
              initPlugin(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Center(
            child: AdBanner(size: AdSize.banner),
          ),
          ElevatedButton(
            child: Text(
              _interstitialAd == null ? '広告を準備する' : 'Show Interstitial Ad',
            ),
            onPressed: () async {
              if (_interstitialAd == null) {
                await _loadInterstitialAd();
              } else {
                _interstitialAd?.show();
              }
            },
          ),
          ElevatedButton(
            child: Text(
              _rewardedAd == null ? 'リワード広告を準備する' : 'Show Interstitial Ad',
            ),
            onPressed: () async {
              if (_rewardedAd == null) {
                await _loadRewardedAd();
              } else {
                _rewardedAd?.show(
                  onUserEarnedReward: (ad, reward) {},
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> initPlugin(BuildContext context) async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    print('status: $status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      print('status: $status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
}
