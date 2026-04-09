Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877F30F547;
	Thu,  9 Apr 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698542; cv=fail; b=MVDUig6L2BdNRrVMUk2n9+PtavoXw4xNcezRxcsmvYwMO4tAqwZw2JzUTIcEZZZ24Tzoe8/dVR7UgeQEScX99pcxpOwJcNEMujSUVuzyfX0Eq+9mJc+vslnH+Ck9z62nrJds+QZAO3eowHJ8yf14PK0qCq1MQsg45kOoAYKJMZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698542; c=relaxed/simple;
	bh=THl2l2NVqIFOGOArPf6U2/hFlHBkcPm6AqqoB2l/Wmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2HAFuuMrVkcSOC1clYiuxnRl2XVa2AyIUsqwli7oJN/J8oZzgefzmbokKgnCEUIdSCkZT3nJeah61g6+PGErDB8DriO1rBjok5MaWJU17MzDNzt85kQ9hgTS6hauIzhfKj/7B47A3W6+Mvqq5sauuOJVwlWZ5sItEwpjpGnwac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APnGvT3D; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APnGvT3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775698540; x=1807234540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THl2l2NVqIFOGOArPf6U2/hFlHBkcPm6AqqoB2l/Wmc=;
  b=APnGvT3D+lpzlAAMnNqqy3oJ6YlSmS13qSK1nYSaf9mqdyFYN05HybB7
   3RXmJduAXVyES3/RXXfs2C1I2sQRP1k7vfqGbA/RxcBCeEF393148QP2k
   8V9lUqU8ywlOADT/dgquzKErPCotrTh91w5QKj+YyjmxSsxf/YLauXpgr
   LyJM5oLTtAPSURLwX6TzFwpXDY4ztneWheQK9JWWlFpMwUw8R6LoPcZ8A
   Xz8fBjZbhQzd1XvYF4PpNXBN3HgRWO3VhqsSf76c/OSsl3DHqR8GUWNz/
   HOD1UGAr7NJGXMnl8rviJhemtdm+ou7NBrCwb6Z5KnHTIQHp2nmtCdTTU
   Q==;
X-CSE-ConnectionGUID: wa9xHjNMS0ez8c6A7UI1Kw==
X-CSE-MsgGUID: Lz7xs7S9RMqz5FJVU3uv/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76713190"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76713190"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:35:40 -0700
X-CSE-ConnectionGUID: gd0TCfF8Rf6Ae4fbXE1gkw==
X-CSE-MsgGUID: ykFBgEKMTaG08rI5aTtBRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230297355"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:35:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:35:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 18:35:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 18:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqqX1eyX8xoSNepUGzqeYETtQHBYViFPWPTmDjDnLYdsRSDKcAP3Hi8viqPMuNz+jlnSiDCEcBzSAw8I5reDCohQRi+MANjNVk79cJuEvcw2cop239YsENAK6aZepiuPUmBMGaKyRbFl+5rYzoRUBaVns7vFQ0rtJa3UfGKyMxMbJfZSrcwsR9X9fD4w+W0yWqZhwniYwo0ZFJ7h2t4GE+8mcHiuPhfeUa5gyOn+pRkVqiB0Y/PeXmZKT2O/bDqgu7u4GRntmnp1gJjPHOWk03C8SZCU70pQiNk6ze+8nM/gIZPoagfjp/NGw5z/YFufjhaaa5uO2Qfo0AKCLfJ8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THl2l2NVqIFOGOArPf6U2/hFlHBkcPm6AqqoB2l/Wmc=;
 b=S5CqPPCV4zFeC9BJHEhF6ecZ/Zs04JvwggiG40ZTHkGM6a/V5kLcpgcdXNa2NK/Tbyr1TiHmXvAQroBCDrxoBVoe8puHSCqAWPu/Q/+G3qazSCU3mwzuI5zgeYatleAicrjmpHXyuXWajlOhEJ2Q/qi+cZQVrh708IZge8cldPGKkEqWASPZJcUGWLihdJIjsuS/Hs1/omUzpun4f7KtowY3Y6GbVzyRCeq2d4Wm8xrT5QYymTxrWObP31iWLuZuTMZKg0DmV27BO5XsfmWQ7exq2+/mtdrbgOsu1fmLYEDYLv7mGytOJmGkM8zSYgFtPNvvi7EYA/PGeXZsEm1ebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 01:35:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Thu, 9 Apr 2026
 01:35:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"prsampat@amd.com" <prsampat@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUAgAEXRwCAAJP5gIABJR6AgACYAoCACDwA4A==
Date: Thu, 9 Apr 2026 01:35:33 +0000
Message-ID: <IA3PR11MB91365041D42CB7F53DA5A98092582@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
	 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
	 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
	 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
	 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
In-Reply-To: <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB6692:EE_
x-ms-office365-filtering-correlation-id: 4ffa4d65-0b5a-4e64-0eba-08de95d84b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: o6k0NXDMX2C0ri1f2B1vuMAY+8I45crUdDs0zo9FbEKlMl9azYeGKpWvf6+Mhb7h0FTxzbPzbVVKpxY0TGfqmCm+JEXfqNEuzsuTgSe8zl2PQqByMHKatqnz4uwoOxqJi7pPfpZFejJuozBTjQTEAIHutrmgtbA9kTW2UYMmVaNmIWOx2BC/izjygqi8/zRGqOG6djwHyWgQx2Cv7joDUvOgQCu2tZ1MbvWBHn3GBB/cSJhDy40CzbT9sN+R4Z8kUnnvLrrYOCDjJ4pAHc9mAiViYw67BILOjmj/bxVgErWxb6czW+mjWI8XTDL92uiJ0ZiAlMvLjAW40lnF3C/5BB1eMB7XBUyhMslQVtcqAXgTVDkXEtoT39IxpqJEM22DBhZmCAmrAfhr/8h/P+0aIbiXkW9TG+e96cQ9EOfe/34qSUD/NNCXPvlAx8HbSWvt/UORIf1zOT2G9lbv36EkhhLpE+XhLkglJQ0IYNDHkZw95ZsaMk0ANXh8qnndZLoFZxgu3HocUbfo2wJVl8JsXWMiCDYujxNPlbIaVRrxOtIE2FZHeEk/7YhEahN71veXgo0cG+FG9WjKeyZRjjGh7Gm1k5BhbwDnxvgpGlVneNwmwE1vFY6qOQudxIhZVrBTqOIRF2CNEIUlbVE8LnCV5yHBcXUCysiS1YLH9F3Rg9vJu0Sbu89NDl5nAfxvMy3H2KYseN1NM2LM2hpak1OCptAXP1AX1tZ/U2vXcEDcAHaemE/NlkhD2oRU/ISZKleB59u1bSJ71IDCkXKlU3K6wsqODS4RoeI9D5XPGnTSNUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NOdXZHUEhvTjVTTFNTQndtaUZxL0lxT256eU56SVdRQXVEVDYvcWx3Zkkv?=
 =?utf-8?B?RkRhVGh4ckxOZ2hnLzNHQUxxdXhGSE1VV08wSy9kR29lUTFDWWs3cUo2bHJH?=
 =?utf-8?B?Y0YwR1pVWXlDS3BhQWE5LzZKVGZNVFRBbHlmdkJ1TE9ES1VUSlZvd1R4ejJy?=
 =?utf-8?B?cldSSGV6UnJJdWhnM1dVMi8wZTdyandFdWpjL3lCOFhkNkI5ZGNkeFhsUWxa?=
 =?utf-8?B?U1BzMndzdGlrT2IzSG5IYU9zN2ZzL3ZaUVY0bnM2bGQ3QWdCT243MDNEdldT?=
 =?utf-8?B?aGxQaWFubHJ0cjF6TE9FVnc5WTJDcFhvRDY3ZVZtbGtPK25ldlk3cEx2Ri91?=
 =?utf-8?B?OWJzUDQ0TDFodmV3UUZLTlZXN1VGV0dUTDgvVjB1Z2Y4VjFoUTNLM0Y4ZHY4?=
 =?utf-8?B?eU54aWhTRXZJbVRmUGM4emVpTGtXR1NmMVJWVEQxMjJocFFTMjdwcEtwcVhE?=
 =?utf-8?B?VXFkSldWK2U1MmNzK1BqakZvYUFkYXAyWTFxM0J3ck5aWmdIZ0IwM3lqc04r?=
 =?utf-8?B?T2k4THdwWjdKQ3diNTR6anU1Y1hrNEE0TFR6MU5ET1lwZ3JPZFIxNStaQUJX?=
 =?utf-8?B?YWtxTVpIbnZ4ZlRKNzNrb3pYZmZIYUdyZ2dQZEdLWFA5Q1FDV1lMVUR2YjdO?=
 =?utf-8?B?blZ2bVVzaW5tSm85NnRKYVVFcTJVbUcxL0xEcnZXN2hhcjFaY2ZMN3c4aGgx?=
 =?utf-8?B?V1doWDN0WXdUODZjWDVDc2NjRjhNdXV2SmdRbmNweXg3RjJwaWtVdXZOZG5i?=
 =?utf-8?B?bnp1RFUvdWdXVzRHTWhmUWo2cjhSVkFTeUFGMUk2NHZFK1hXZ3dhc3VrS3Mr?=
 =?utf-8?B?aFAvVGV3Y1V6UGhlMWV4U1J0bU5KU1hGamxjTm1uelJKVmI2SFpLejdjTUFM?=
 =?utf-8?B?QzViQUl3QUlKMXhyUnlEUWJGSCszcW51RXd2NktnTUQ3NEJyYyt4Mk1MSWhT?=
 =?utf-8?B?MUFyKzBoRjZDeEFUNys0WGhhUXU4ZDZBUEo0ZFYwZEd6MVgwQzJkcFhXWFVR?=
 =?utf-8?B?RVJjQnA5bEtyTzVpZ05qRVNYczh5ck5OS216K09DSFBXWDhEYm5aWXgwTXYz?=
 =?utf-8?B?aS9zZFV6Q1B3UDlOYVFQMGE2dTljUnNrN1Y5VTExcEpTU0phTUpXRmYvNnlQ?=
 =?utf-8?B?dnRLejhBaDAwa0dOTG1WZklBUHcvdSsyc3A1RHQ0dnBxdElyajVCR3B0czZL?=
 =?utf-8?B?SWdPbjI3VnpQQ0RzMXhIbmh1RnJHa0dYcTBFYlEyQ1FmYWZtSnl4dW5LWDVE?=
 =?utf-8?B?UjBaN1N1MzFJTnRRVEhualgrRU4vRldxWlJaTkZacld3b0ZaRlYwaVVCWHRT?=
 =?utf-8?B?ODU1NnJwNDBHMXhkNFZqT2hYOGtjRFhQS21uR2FZMk10UTUyc3lPNlVMN1Vp?=
 =?utf-8?B?R0ZVdjhTM1N3RFdMU3hQb3BWV3M0cUZuU0E3M2JnWjB4c3VnL0dadEpWVUow?=
 =?utf-8?B?dHBGVU54UGNBdmgrSms4d1RLTnhlaUEvdGQ3RXU1L0QyMmF4amxUWVNWTHI2?=
 =?utf-8?B?bkJ0RHl0SXlHMVAyM1R5MGxnalhBa0N6THlZeFBVUWN3c29PZkpSMGsrNXUz?=
 =?utf-8?B?cTYxWkhZbk0ycEYwTDViblhiSS83ODBnZmtsYzB4QXVJYWRnUDRQRUNXanp4?=
 =?utf-8?B?MTVHTlpORkZwd25YY0I4U0FpaEpiUmdIZG5EM3hubkYwQUpXUHBBRHVrT0lp?=
 =?utf-8?B?R3dHSTNnMURQRUhkbDBWY2JUQjM5NWM4NHYxLzViYTYvYUlFcWNKc2paSGxn?=
 =?utf-8?B?TWlWdnZDemgxUHFic0NLRXJpQTAyb0FSdTQwME5JU0JjN1Q1MHpLcWlPd21G?=
 =?utf-8?B?Z0dqRDAwRllCUTZDUWF0Tk02c2VzbWhPMUV5cW9pajJod1hYTGprUkJlSlpC?=
 =?utf-8?B?NDVqOGdobVZxSzFHOUsreGhpMDJmSHRGTkUzbHZ2TnZqNkJ3MW11Rkc2SHA2?=
 =?utf-8?B?T3lVeXFyd3FhaGNmalgzcmk1aVcvWTV3c281K1V4dnF6eHBvbjdjQ3lrV0Js?=
 =?utf-8?B?RHluQ3lHRVpwaWlWYm1Ic2svVGlMZElFb2xGeUhMc3pzM09yRTJHTHZSSlVR?=
 =?utf-8?B?Z01GTElUK3I4Zzd4aW5ENVJXNHBLVGpBRG4wZW5Xd3JEWHpHeGNXNTl2Y2Nk?=
 =?utf-8?B?Z3BIbENDeG5iVVFmTFRTN01yRXNRczJCWTR3WCtrekQ2SWRyV0dwMlNKK0xU?=
 =?utf-8?B?dHFkUGsxRHpIcGRVRTlybmM2eEN0RFo1WW5Db1Q5Lzl0d0NaNFR6MUF3cFA3?=
 =?utf-8?B?WTgwRHZTQ3hUQjdKdnVxTTYyWjBDaVNSNWRMYWEzWWY5Nlk0ZmxKVllIVC84?=
 =?utf-8?B?OXFWaDhZdHZETXY2WUhyVjRNMkxGdFRWcVFnL0lKN2xHNFByVytjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xdzk8WRjZcl+oWyKMjvnKPPCwQ2nAb6eBx9Ayn4GUvfxcLYjJTEgTMoo2Gb0Sz593W9mcaZEjLr97VEnqOy1+sgmgDW7/Lt7GC9GOxDpUJG/K45PaBvjlH8+aYl52TRzaJLI8KBFbfVJXO6EVVZooVV6odh89abu1aN/0xFCpWDdDZ4hRJQiZjQAzjc9sVBdMpdQLS+texrgKGRTPdolZtw3H4JTeQCCEhQxVDR7Xx1ebWNFVfAX5w/KscbUd9zO34WZPZtANd+qV25ljnUFOfFj0PL4AeF0kE0IZkdlBU+AGGo5INB8bgU7JqZIExn2bXXN8AblsEN9geOqnhNhDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffa4d65-0b5a-4e64-0eba-08de95d84b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:35:33.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSH+E4tLBgsfOB+1dMM4aT9VfROaaomBNV/gn6LjLgN0XklG8t5+1pXlbn7xQxVBBlgS8bW0goF/NqNZivbEksZnopkCqXdMB02wNmCDiFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVkZ2Vjb21iZSwgUmljayBQ
IDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvMl0g
eDg2L3RkeDogQWNjZXB0IGhvdHBsdWdnZWQgbWVtb3J5IGJlZm9yZSBvbmxpbmUNCj4NCj5PbiBG
cmksIDIwMjYtMDQtMDMgYXQgMTA6MzcgKzAwMDAsIFJlc2hldG92YSwgRWxlbmEgd3JvdGU6DQo+
PiA+ID4gPiBTbyB0aGUgcGFydCBhYm91dCB3aGV0aGVyIGEgdHJpZ2dlcmVkIGFjY2VwdCBzdWNj
ZWVkcyBvciByZXR1cm5zIGFuDQo+PiA+ID4gPiBhbHJlYWR5IGFjY2VwdGVkIGVycm9yIGlzIGFs
cmVhZHkgdW5kZXIgdGhlIGNvbnRyb2wgb2YgdGhlIGhvc3QuID4gPg0KPj4gPiA+ID4gSS5lLiwg
aWYgd2UgZG9uJ3QgaGF2ZSB0aGUgemVyb2luZyBiZWhhdmlvciwgdGhlIGhvc3QgY2FuIGFscmVh
ZHkgPiA+DQo+PiA+ID4gPiBjYXVzZSB0aGUgcGFnZSB0byBnZXQgemVyb2VkLiBTbyBJIGRvbid0
IHRoaW5rIGFueXRoaW5nIGlzID4gPg0KPj4gPiA+ID4gcmVncmVzc2VkLiBCb3RoIGNvbWUgZG93
biB0byBob3cgY2FyZWZ1bCB0aGUgZ3Vlc3QgaXMgYWJvdXQgd2hhdCBpdCA+ID4NCj4+ID4gPiA+
IGFjY2VwdHMuDQo+PiA+DQo+PiA+IFllcywgYW5kIG15IHBvaW50IGlzIHRoYXQgd2Ugc2hvdWxk
IG5vdCBhbGxvdyBndWVzdCB0byBmcmVlbHkgZG91YmxlDQo+PiA+IGFjY2VwdGluZyBldmVyLg0K
Pj4gPiBGb3IgYW55IHVzZSBjYXNlIHRoYXQgcmVxdWlyZXMgcmVsZWFzaW5nIG1lbW9yeSBhbmQg
YWNjZXB0aW5nIGl0ID4gYmFjaywgaXQNCj4+ID4gc2hvdWxkIGJlIGV4cGxpY2l0IGFjdGlvbiBi
eSB0aGUgZ3Vlc3QgdG8gdHJhY2sgdGhhdCBtZW1vcnkgPiBoYXMgYmVlbg0KPj4gPiAicmVsZWFz
ZWQiICh1bmRlciBjb3JyZWN0IGFuZCBzYWZlIGNvbmRpdGlvbnMpIGFuZCB0aGVuIGl0ID4gaXMg
b2sgdG8gYWNjZXB0DQo+PiA+IGl0IGJhY2sgKGV2ZW4gaWYgaXQgZG9lc250IG1lYW4gcGh5c2lj
YWxseSBhY2NlcHRpbmcgPiBpdCkgYW5kIGluIHRoaXMgY2FzZQ0KPj4gPiBpdCBpcyBvayAoYW5k
IGV2ZW4gc3Ryb25nbHkgZGVzaXJlZCkgdG8gemVybyB0aGUgPiBwYWdlIHRvIHNpbXVsYXRlIHRo
ZQ0KPj4gPiBub3JtYWwgYWNjZXB0IGJlaGF2aW91ci4NCj4NCj5IbW0sIGl0IGRvZXNuJ3Qgc2Vl
bSBsaWtlIHlvdSBlbmdhZ2VkIHdpdGggbXkgcG9pbnQuIE9yIGF0IGxlYXN0IEknbSBub3QNCj5m
b2xsb3dpbmcgd2hhdCBpcyBleHBvc2VkPw0KPg0KPlNvIEknbSBnb2luZyB0byBhc3N1bWUgeW91
IGFncmVlIHRoYXQgdGhpcyBwcm9jZWR1cmUgd291bGQgbm90IG9wZW4gdXAgYW55DQo+c3BlY2lm
aWMgbmV3IGNhcGFiaWxpdGllcyBmb3IgdGhlIGhvc3QgdGhhdCBkb24ndCBleGlzdCB0b2RheS4g
QW5kIGluc3RlYWQgeW91DQo+YXJlIGp1c3Qgc2F5aW5nIHRoYXQgdGhlIGd1ZXN0IHNob3VsZCBo
YXZlIGluZnJhc3RydWN0dXJlIHRvIG5vdCBkb3VibGUgYWNjZXB0DQo+bWVtb3J5IGluIHRoZSBm
aXJzdCBwbGFjZS4NCj4NCj5CdXQgdGhlIHByb2JsZW0gaGVyZSBpcyBub3QgdGhhdCB0aGUgZ3Vl
c3QgbG9zaW5nIHRyYWNrIG9mIHRoZSBhY2NlcHQgc3RhdGUNCj5hY3R1YWxseS4gSXQgaXMgdGhh
dCB0aGUgZ3Vlc3QgcmVsaWVzIG9uIHRoZSBob3N0IHRvIGFjdHVhbGx5IHphcCB0aGUgUy1FUFQN
Cj5iZWZvcmUgcmUtcGx1Z2dpbmcgbWVtb3J5IGF0IHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3Mg
c3BhY2UuIFNvIHRoZSBndWVzdCBpcw0KPnRyYWNraW5nIHRoYXQgdGhlIG1lbW9yeSBpcyByZWxl
YXNlZCBjb3JyZWN0bHkuIEJldHRlciB0cmFja2luZyB3aWxsIG5vdCBoZWxwLg0KPkl0IHJlbGll
cyBvbiBob3N0IGJlaGF2aW9yIHRvIG5vdCBoaXQgYSBkb3VibGUgYWNjZXB0Lg0KPg0KPlREWCBj
b25uZWN0IHdpbGwgdXNlIHRoaXMgInVuYWNjZXB0IiBzZWFtY2FsbCwgc28gSSBhc2tlZCBaaGVu
emhvbmcgKENjZWQpIGhvdw0KPm11Y2ggb2Ygd2hhdCB3ZSBuZWVkIGZvciB0aGF0IHNvbHV0aW9u
IHdpbGwganVzdCBnZXQgYWRkZWQgZm9yIFREWCBjb25uZWN0DQo+YW55d2F5LiBJdCBzZWVtcyBs
aWtlIHdlIHNob3VsZCBtYWtlIHN1cmUgdGhlIHNhbWUgc29sdXRpb24gd2lsbCB3b3JrIGZvciBi
b3RoDQo+U05QIGFuZCBURFggYW5kIGtlZXAgdGhlIG9wdGlvbnMgb3BlbiBhdCB0aGlzIHN0YWdl
Lg0KDQpGb3IgdGhhdCBzb2x1dGlvbiwgYW5hbG9nIHRvIGhvdHBsdWcsIFREWCBDb25uZWN0IG5l
ZWRzIGEgaG90LXVucGx1ZyBoYW5kbGVyIHRvDQp1c2UgInJlbGVhc2UiIHNlYW1jYWxsIHRvIHVu
YWNjZXB0IHByaXZhdGUgbWVtb3J5IGJlZm9yZSB1bnBsdWcsIHRoYXQncyBpdC4gQnV0DQppZiB0
aGUgemFwcGluZyBTLUVQVCB3aWxsIG5vdCBoYXBwZW4gaW4gaG9zdCwgSSB0aGluayB0aGlzICJy
ZWxlYXNlIiBzZWFtY2FsbCBpcyBhbHNvDQp1bm5lY2Vzc2FyeSBmb3IgVERYIENvbm5lY3QuDQoN
CkkgYWxzbyBoYXZlIGEgc2lsbHkgcXVlc3Rpb24gd2hpY2ggSSBsb29rZWQgb3ZlciB0aGlzIHRo
cmVhZCBhbmQgZGlkbid0IGZpbmQgYW5zd2VyLg0KRG8gd2UgaGF2ZSB0byBzdXBwb3J0IHByaXZh
dGUgbWVtb3J5IGhvdHBsdWcsIHdoYXQgYmVuZWZpdCB3ZSBnZXQgdG8gc3VwcG9ydCBpdD8NCklm
IHdlIG9ubHkgYWxsb3cgc2hhcmVkIG1lbW9yeSBwbHVnL3VucGx1ZyB0byBURCwgdGhlbiB3ZSBk
b24ndCBuZWVkIHRoaXMgc2VyaWVzLg0KR3Vlc3QgZGVjaWRlcyB0byBjb252ZXJ0IHNoYXJlZCBt
ZW1vcnkgdG8gcHJpdmF0ZSBhZnRlciBwbHVnIGFuZCBkbyB0aGUgb3Bwb3NpdGUgYmVmb3JlIHVu
cGx1Zy4NClRoaXMgd29ya3MgZm9yIGJvdGggVERYIGNvbm5lY3QgYW5kIG1lbW9yeSB1bnBsdWcg
YXMgbWVtb3J5IHJlbGVhc2UgaXMgaW1wbGljaXRseSB0cmlnZ2VyZWQNCmluIG1lbW9yeSBjb252
ZXJ0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K
