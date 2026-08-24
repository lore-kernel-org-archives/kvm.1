Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9A33A9FE;
	Mon, 24 Aug 2026 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605863; cv=fail; b=GyJn7jAJYcswRmttHGdPbnJcpGzDHfx5Czczlw0Xndt1LkzYGcI1xVwW6Tld8LnkxEkZr93aeVkFElBm6ppBi3b88SuZB7tAcb+lo39ZL/q6lG6+N08YXKcBJNGJ/qLCZC0HWU9PsQVy/mCNtlYWCk79WsPdafHV3e2Prylu050=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605863; c=relaxed/simple;
	bh=VZ8ap15h8T3KhSRNjcz5wziOwh9aPhsfrVG3UAfcmeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9fOj5JKEAvb0xKcUmTJP+aDqkoPscRZXHwQDcX99vIHU4lNbhvU3rq+pUITorO0TO1+Lgup7NXbzedEOonACH5se6iHs+55sRcpwaEDyaInuk6u+SkCbBrAwFpk6mB3Y9PV/QpLPMOeSiDm0yd8adz4oDkIrJEnhKuq/PPh3x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKvNYVk0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKvNYVk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787605861; x=1819141861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VZ8ap15h8T3KhSRNjcz5wziOwh9aPhsfrVG3UAfcmeE=;
  b=VKvNYVk0TeYN1NDU7CY26I/mcH/qDXofinS1dZ+dDiF8oXN7dqgk42/d
   vr90YdG4cdO2a17kyJgaa7BNR4Afc6FLJM4d7tD34KtigxgbUNYEfTIC4
   NrHzdsacqZzmuTNm+8xyHpciDhYKRj4TOgjKTP5N+Q/WFeKkz6EKrMWdW
   6lqN4s2F8xMIksgm0WIGc3GmynHnjP/AkbVauqLEQyXRktpp1t8aXwgBD
   ADPn9PJ4XYYqqSRzsHtIQ621HeK9DSUu+3Gt7mkOfPkeS2Nuwl52Cfav7
   izYBSy1Oeceesgj++i5eLUUupEYMgXx/IwefHjCUJw9mxg6TRYL2hhV6P
   g==;
X-CSE-ConnectionGUID: EtuiPiy7TrO++i5kHTMA/g==
X-CSE-MsgGUID: u/22v8i3T1OxdrNvTalqRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125128"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:11:00 -0700
X-CSE-ConnectionGUID: U2WxHw3ISBWIgwNe5xFT6Q==
X-CSE-MsgGUID: D+T0ET9BTC+ImNy1TM/yTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290633818"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:11:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:10:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 14:10:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbKAJYTgsVjHGG2Mx7pWkn60tZ2SXl53z4F2RzfD3Wl65si8s9W1OwcMfEK6J0JOvrKo/nKk4V9+Ia7pt5WJvBAfyvV5DgeUfiPoI6cTV3wfyPHsG+NCik2SiBz0hi6pAaFJ+blp2o3BYem+k/F3RcJZFJy3G7UA6cMfxIDYasc2ADMN1tDDh7O1O0PjkqHebAkR8zh4/JdUZ7/tGx4eyJK93TuNtwF0lC/nTF1X1tDTlnYUAoTwrI9tYd5m/6LDK7bu7UjK+ZhOKf06FmjUdx6nKElNxugdPi4Paor6TNVud01iAJiWUIT1Ufejw3RCxXI6mSVZiSEAVD+uAkc8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ8ap15h8T3KhSRNjcz5wziOwh9aPhsfrVG3UAfcmeE=;
 b=tFYNxcMGk1XNGCG+HCE8MQl+ms69oerhp0arRC6cV/ER3CPc0UHljkHozxTIOmnPH+C4vgdoKdpUMu/siddfFaQ8QsiydQpE14vBeqYX4uEG1+koGDUXrT9qRmTsvscwxr4ONo7YVvLWaRIuuNwy+ncNOxy1WwWy9tUdJcPzT4Xsq3Xi6jGOyaJuwFDhM4wbFVwxVaiQopyI5H9rZ6rDmDRCWlVi7il2XacEdYhcVQyqlz1aksGH+5UThJpj1dR/hTLETHc/+l013QY0MEoDrBXtuDCkJK5FR9hAWjmCZ+JaQrato374JCukQBg90WaIPxl3C2RRUDImMfdPUIGvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 21:10:51 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 21:10:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Hansen, Dave"
	<dave.hansen@intel.com>
Subject: Re: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
Thread-Topic: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
Thread-Index: AQHdMVBkXbc2RAJmgkucp8fyxhefybatt2+A
Date: Mon, 24 Aug 2026 21:10:48 +0000
Message-ID: <35248f8b1859582cd78a31177043c3d61489c19f.camel@intel.com>
References: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
In-Reply-To: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 680b9d9e-6c46-44d9-b38a-08df02242bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: O+oBCbfTLv1eP3dz6UnK/HSkPguNYn9j+8hsmGmCrL6f+Y8EUeNuWiZjIU/8tEd/TYgk4jpTzuBtNT49e3KkugO7R1Q48X0imEV9+rWime88rvU8m3fSjkZEHqZK8Q4mtdAIuox/Oxiyc5Sn3pLdIWNAgGJHbN4ohMkHFI944d3qJ4yqsy9mAO+zcKGLPA/im/xmzZk18LFNyeFjNzGgeS2z1wP4P66MhjRoKJAk8RBBjum4ei2mlSC1M4C9XTokf5qk0RpQn3u2a3pzH5ou/NxLqdPgmbuGIzBUnVqZ5MVuQZrHg5tNxBCYZnj13z1ZdPSf4DN0eQltLClXxVaVpLfGJ1BVzDCinLmU5AYbpkLd6YKwhyZFg0/06NuOjKkkcXVkI37KoGYt5H4s/EALtNCUW2Ns+k1NzRzgiwylamNTiDwQEDak2tnF1CdaaN/Wy6cbsPSvs9Xuc0KqV/CgYHSK0nJzRp5XTY3HovK+hPzSlUAqQ2UkOYrqySnLRzZyyp9LZyMIfIbpGeXIHYzlVxiUElvnE3vAoaOlrWPp8jIZHIYEYGuQph4irONBT9IeKDyBZ5p3nCrnmYtBZXstEvP6ddMrbhTWRA05/vkmmt+WlY+z5fF7axPAaiQeIJhoB0+i4vxNIhM3g6NHHw3bl90PVwYvHa9q9DPWKsHpvor+xFImNHdwkWnodGiWNs28sSQvkamFW7Tg4m+KEVbYChncg26JV4ruTI+uMoc+dvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2hHeFdFNm1VVS9aVXBaSy96WFJxVVBsSmR0Tzc4ZWUxOXBnUytBNzVsZXN3?=
 =?utf-8?B?TE9acGF4alMwQ01BWmd4cWo0bjd6TDBOT1N4clFiaEw0SEFHQUVLZjJEd3VR?=
 =?utf-8?B?bHBVNXhGTFV0ZWxSYW10YUxTSTBkRWtTQWJrYU1FZkczemFyelQzYk9EZlQ2?=
 =?utf-8?B?SkRrV1FDd0p5ODAyMHFYUjhiWGZyZnhqVWVSWC9EOElMcVRMV3cvdk94bGlw?=
 =?utf-8?B?MTlFZ3ZzTjR0dS93bVdoZUZEV2x6UlUzdDZEaGJ4Q2FqMzlpVjVnZmJxZ1hK?=
 =?utf-8?B?ZndoR005ZHQ4TndmSkhWdE5rWDVqV1hmSGFRQjBmTHN6cnhwY1JtcEh6VkhR?=
 =?utf-8?B?MENsTERhVkJ4Vi9ORDdiendEb2EvWjRwZktmTTIwVFpyRDdqRUlLeFlBbVVH?=
 =?utf-8?B?ZGFrRGlVcmozcW92dUlHbzVSNytJQ1ZreVhkVmtOdzF5QVNsdS9ZcENIcm41?=
 =?utf-8?B?WklvUzRhRmswK3lnRHRJNi9XbVhzNWVVVWhkaFNZMkFQbnkwcmN3OW81Mkwx?=
 =?utf-8?B?Z2lEajV3Rjg0WWdza0xYYWFETkk3RVVLcEVKaU9tUzRGTEUrdkNjQzlQSVhW?=
 =?utf-8?B?OGtIcXE4N2V2MlpuRFZFSEt0WWc0V2U3RkM3Vk9xQjVoY3JaaXk0NjVSMXdY?=
 =?utf-8?B?b2ZXN1lGK3pEVjJzdDBvV3Z0MW1rVGRaNUQ2dHVXSGIrTGpwL1VRaTZsVHE2?=
 =?utf-8?B?aC9hTG92Z1liS0R0djNGbHcySG40cklkZVBmOWtNdG5ncGNHTnJ1aTd6UzF5?=
 =?utf-8?B?Vy9uaCtTd3hFZnZKQWNwRzFhbzQ3bUVrWjFBR1hNNlB5WUt1b2RLeGFXd1gz?=
 =?utf-8?B?WU5qTlB4WnBwM3A0TXpJZ2xpZDZSSitOUmpGT054UC9uem1OR09PTUQ3am43?=
 =?utf-8?B?VllCdDVYVmNvL1dXUWNZa3hvNVJ1aGF6ZEFXUGpjRmN2Y0RlYTZJdW5zczBZ?=
 =?utf-8?B?dThhV3lUUmtRelMyeXNSRnVZYjE3Nk1jOUcyYk5Yb2FkdERPTnFYdjJsNyts?=
 =?utf-8?B?ZUl3WkEvNnAvZHRrc1Vlek54eDltMzZVZkRuMnQ4elZNVWFsTGxDSmZpMzhj?=
 =?utf-8?B?Q2d0RkNNSVBMRGRnOHQwWGRRbzUzaEtuTTFpQlZLcTJ3OG44aEo3SkpCWkVF?=
 =?utf-8?B?c3NxTWJFS25pU3AxVHNMUGlmQ0F6SXVBVmxON1A0NGordXIwaXRCTWdaQVYr?=
 =?utf-8?B?NWVIVUlUZ0xveEpMTk56MlN1UHIzaXloNVpSdWtvWEpWN042K0hGQ1c4UUV0?=
 =?utf-8?B?aGUxaE4rUjNuajJMb2dlMFNnNGZNZk1NcEI3Z3ZoWksyRkVQK1BIMVNnWm41?=
 =?utf-8?B?SW1iaGpqaFBBMVorRGo1emtyazVmNkdCMnhYZzA1QmEvYllzSCtFOGxudTJm?=
 =?utf-8?B?Ym1JMFZIMk8vRWljSE9NTG1MQjd4Yk1TYmRFQkNNbFhONWpkc3pPZjZUTUxW?=
 =?utf-8?B?VGJtS3U3aCtiZkNtZVJpbjhHUzVHUzZhT2VVQm50eEwvaDBEdHZBaEl0ZXQ0?=
 =?utf-8?B?U3QxWDl1ck9yRGlJbVZ5MzFIK3I1ZWdwcWFUTFZBYVBCbk9uU21LbjdlVXNE?=
 =?utf-8?B?OWdJV1dLdlE5UDg2WmdmMHBUKytHbGNSSmpaWUVDRzhpZ1hiMWZYa1ZhRm9F?=
 =?utf-8?B?dVNZbThDQ3B4SWg2blo1S1NjelpqYkNmMVQrQ0p2akFXR1lPRFRCM1hoUEVj?=
 =?utf-8?B?aGkwZFJsenpSYXl1TUM4Ylk5dDYvK2d2TWFaazQ0VG9ZZ2EzcjRCWmVBQ3JT?=
 =?utf-8?B?UkN1eDRsTUI4YUljV2lGdlZpVkNvemRJcFl4WUVkY3pnSVFhWitxV3ozdmo5?=
 =?utf-8?B?cmdqajc3bjF1Sk5ZSnRoaXppLzRtOWZWeW51ckI2Z2ptOFFWQTFZTVpHVFhO?=
 =?utf-8?B?Rm9wYUg0ZlcrQ3ZRTXB5M3dPZ0pOblN4Q2JZVzhhSFlubEFPNVhxZXBUZVdk?=
 =?utf-8?B?YUo2b1hWSXVSMWVmSFZkL3RleFlmcXBoaWdMWWlKT2lsWHZSU213bTYrMTNP?=
 =?utf-8?B?SEs0K096aE5zN3hPb2kvR2l1ajB6WlB2M2V3bVhQeVhmVHRsWkJobXIwZzVL?=
 =?utf-8?B?d2lKTE5GQ0VvRURFbzM1VFJkb3hnd2RSSi96ZG1iOUZWREk1UmE4VnErYSsv?=
 =?utf-8?B?Sk56T1dYMlhyL2dpMUs0QXV1KzNEYkg2aFBDQ0tJR3FoTi9YVXJ0T2ZOdkFj?=
 =?utf-8?B?ZXlzV2hudkV5a3h2VGpWR25pQm5Tc1hYZU1FaUlSdlViR01qRXN0ZkVaSlc0?=
 =?utf-8?B?RkpQTVZ4NFlTd1o2UlBHM0QwR3hJWlhmVmZFWWd6SDdUd1QvZk94b3Qxd1c2?=
 =?utf-8?B?L0VnbEVwSW1xZEMxTkZGSTNwSDJYcmlrT0t6K0RXQXNWNytEYTZWaklhQVg1?=
 =?utf-8?Q?9zVf8kCKR7gTVYOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC943EC0489CE4EB7F88B52590534E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C8j+VQSCSBpAjFNGULVaPy5KUzStc2ojQUKGCOPbqIbkEZCqgedL4SLM0XrID2TyJCj6IstRjZRbmD0mWep5aysIS+ENV9KEfbPgR+RQnKYN3RgNB5R4KLuqpFa32TxuyvWZE0+ZscLJDZ5FIDYPUfGL2MIAeoyX2VwImZOJDxNhvBBjP1eJLPfSkVqYCG/ZS58Ln9BBubzS4DdXmhyL37PAamaAAn+OL47AfM7KffB4jqirfVYZZAKA0B7EDMH7BkKhuYUp5C62YQtwnN/rjVzFBDuhjsDK+b2rnd+A5R5wYd156dk4Zt8lnKb4musH1ing9T2vdHGr6EXFBOKqmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680b9d9e-6c46-44d9-b38a-08df02242bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 21:10:48.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qz6f5vGmGhjVldREfBFknHld7cmxQbx1YkyceHt3WVQXgfkRqw5RttePN/bVMetxD4/5APE2aWbAqfHOEaAoqes0OZdvex76cPIFRkSqv/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDE3OjM5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IEFk
ZCBhIHRkeF9oa2lkX2FsbG9jKCkgaGVscGVyIHRoYXQgY2hhcmdlcyB0aGUgbWlzYyBjZ3JvdXAg
YmVmb3JlDQo+IGFsbG9jYXRpbmcgYW4gSEtJRCwgYW5kIHVud2luZCB0aGUgY2hhcmdlIGlmIEhL
SUQgYWxsb2NhdGlvbiBmYWlscy4NCj4gDQo+IF9fdGR4X3RkX2luaXQoKSBjdXJyZW50bHkgYWxs
b2NhdGVzIGFuIEhLSUQgYmVmb3JlIGNoYXJnaW5nIHRoZSBtaXNjDQo+IGNncm91cC4gSWYgdGhl
IGNoYXJnZSBmYWlscywgdGhlIGVycm9yIHBhdGggY2FsbHMgdGR4X2hraWRfZnJlZSgpLCB3aGlj
aA0KPiB1bmNoYXJnZXMgYSByZXNvdXJjZSB0aGF0IHdhcyBuZXZlciBzdWNjZXNzZnVsbHkgY2hh
cmdlZC4gVGhpcyBjYW4gbWFrZQ0KPiB0aGUgbWlzYy1jZ3JvdXAgdXNhZ2UgbmVnYXRpdmUuDQo+
IA0KPiBDaGFyZ2UgdGhlIGNncm91cCBiZWZvcmUgYWxsb2NhdGluZyB0aGUgSEtJRC4gIFdyYXBw
aW5nIGJvdGggc3RlcHMgaW4NCj4gdGR4X2hraWRfYWxsb2MoKSBtYWtlcyBpdCB0aGUgZXhhY3Qg
Y291bnRlcnBhcnQgb2YgdGR4X2hraWRfZnJlZSgpLCBpLmUuDQo+IGtlZXBzIHJlc291cmNlIGFs
bG9jYXRpb24gYW5kIHJlbGVhc2Ugc3ltbWV0cmljLCBhbmQgbGV0cyBfX3RkeF90ZF9pbml0KCkN
Cj4gc2ltcGx5IGJhaWwgb24gZmFpbHVyZSBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIHRoZSB1bndp
bmQuDQo+IA0KPiBSZXBvcnRlZC1ieTogc2FzaGlrby1ib3RAa2VybmVsLm9yZw0KPiBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcxMDA0MDE1My5EOEVBNzFGMDAwRTlA
c210cC5rZXJuZWwub3JnDQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjYwNzE4MDIwMzQ4LjNCNDIyMUYwMDBFOUBzbXRwLmtlcm5lbC5vcmcNCj4gRml4ZXM6IDdjMDM1
YmVhOTQwNyAoIktWTTogVERYOiBSZWdpc3RlciBURFggaG9zdCBrZXkgSURzIHRvIGNncm91cCBt
aXNjIGNvbnRyb2xsZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCaW5iaW4gV3UgPGJpbmJpbi53dUBs
aW51eC5pbnRlbC5jb20+DQoNCkFzIGEgc3RyYWlnaHRmb3J3YXJkIGJ1ZyBmaXg6DQpSZXZpZXdl
ZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQpCdXQg
aXQgc2VlbXMgYSBiaXQgYXdrd2FyZCBob3cgdGhlIGtleWlkIGFsbG9jYXRvciBpcyBjYXJlZnVs
bHkgaGlkZGVuIGF3YXkgaW4NCmFyY2gveDg2IGJ1dCB0aGUgS1ZNIGNhbGxlciBkb2VzIHRoZSBj
Z3JvdXAgbWFpbnRlbmFuY2UuIEhtbSwgSSdkIHdvbmRlciBpZiB3ZQ0KY291bGQgbW92ZSB0aGUg
c3RydWN0IG1pc2NfY2cgcG9pbnRlciB0byBzdHJ1Y3QgdGR4X3RkIG9yIG90aGVyd2lzZSBwYXNz
IGl0IGluLA0KYW5kIG1ha2UgdGhpcyBzdHVmZiBtYW5hZ2VkIGJ5IGFyY2gveDg2Lg0KDQpJIHRo
aW5rIHRoZSBvbmx5IHJlYXNvbiBpdCBpcyBLVk0gbWFuYWdlZCBpcyB0aGF0IGFuIG9sZCBjZ3Jv
dXAgcGF0Y2ggZ290DQphcHBsaWVkIG9uIHRvcCBvZiB0aGUgYmFzZSBzZXJpZXMuIFRoZSBvbGQg
ZGVzaWduIGZyb20gdGhlIGVyYSBvZiB0aGF0IHBhdGNoIGhhZA0KdGhlIGtleWlkIHJhbmdlIGV4
cG9ydGVkLCBhbmQgS1ZNIHVzZWQgaXQgdG8gbWFuYWdlIHRoZSBrZXlpZCBhbGxvY2F0aW9uLiBU
aGVuDQp3aGVuIHRoZSBrZXlpZCByYW5nZSBnb3QgaGlkZGVuLCBpdCByZXN1bHRlZCBpbiB0aGUg
YWxsb2MvZnJlZSBmdW5jdGlvbnMgZ2V0dGluZw0KZXhwb3J0ZWQuIFNvIEkgd29uZGVyIGlmIHRo
ZSBuZXcgdGR4X2hraWRfYWxsb2MoKSBzaG91bGQgbGl2ZSBpbiBhcmNoL3g4Ni4NCk90aGVyd2lz
ZSB3ZSBhcmUgZG9pbmcgdGhlIHRoaW5nIHdoZXJlIEtWTSBqdXN0IHdyYXBzIGFyY2gveDg2IGV4
cG9ydHMgdG8gZG8NCndoYXQgaXQgbmVlZGVkIHRvIGRvIGluIHRoZSBmaXJzdCBwbGFjZS4NCg0K
QnV0IG5vdCBuZWVkZWQgZm9yIHRoaXMgcGF0Y2ggaW4gYW55IGNhc2UuDQoNCj4gLS0tDQo+ICBh
cmNoL3g4Ni9rdm0vdm14L3RkeC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC90ZHguYyBiL2FyY2gveDg2L2t2
bS92bXgvdGR4LmMNCj4gaW5kZXggYjI3MmMyMDU4NmE3Li5kMWZlMjc5YjViYzMgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC90
ZHguYw0KPiBAQCAtMjYwLDYgKzI2MCwzMSBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQg
dGR2bWNhbGxfc2V0X3JldHVybl92YWwoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiAgCXRvX3Rk
eCh2Y3B1KS0+dnBfZW50ZXJfYXJncy5yMTEgPSB2YWw7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBp
bnQgdGR4X2hraWRfYWxsb2Moc3RydWN0IGt2bV90ZHggKmt2bV90ZHgpDQo+ICt7DQo+ICsJaW50
IHJldDsNCj4gKw0KPiArCWt2bV90ZHgtPm1pc2NfY2cgPSBnZXRfY3VycmVudF9taXNjX2NnKCk7
DQo+ICsJcmV0ID0gbWlzY19jZ190cnlfY2hhcmdlKE1JU0NfQ0dfUkVTX1REWCwga3ZtX3RkeC0+
bWlzY19jZywgMSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJZ290byBwdXRfbWlzY19jZzsNCj4gKw0K
PiArCXJldCA9IHRkeF9ndWVzdF9rZXlpZF9hbGxvYygpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiAr
CQlnb3RvIHVuY2hhcmdlX21pc2NfY2c7DQo+ICsNCj4gKwlrdm1fdGR4LT5oa2lkID0gcmV0Ow0K
PiArCXJldHVybiAwOw0KPiArDQo+ICt1bmNoYXJnZV9taXNjX2NnOg0KPiArCW1pc2NfY2dfdW5j
aGFyZ2UoTUlTQ19DR19SRVNfVERYLCBrdm1fdGR4LT5taXNjX2NnLCAxKTsNCj4gK3B1dF9taXNj
X2NnOg0KPiArCXB1dF9taXNjX2NnKGt2bV90ZHgtPm1pc2NfY2cpOw0KPiArCWt2bV90ZHgtPm1p
c2NfY2cgPSBOVUxMOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGlj
IGlubGluZSB2b2lkIHRkeF9oa2lkX2ZyZWUoc3RydWN0IGt2bV90ZHggKmt2bV90ZHgpDQo+ICB7
DQo+ICAJdGR4X2d1ZXN0X2tleWlkX2ZyZWUoa3ZtX3RkeC0+aGtpZCk7DQo+IEBAIC0yNDQ1LDE0
ICsyNDcwLDkgQEAgc3RhdGljIGludCBfX3RkeF90ZF9pbml0KHN0cnVjdCBrdm0gKmt2bSwgc3Ry
dWN0IHRkX3BhcmFtcyAqdGRfcGFyYW1zLA0KPiAgCXU2NCBlcnIsIHJjeDsNCj4gIA0KPiAgCSpz
ZWFtY2FsbF9lcnIgPSAwOw0KPiAtCXJldCA9IHRkeF9ndWVzdF9rZXlpZF9hbGxvYygpOw0KPiAt
CWlmIChyZXQgPCAwKQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtCWt2bV90ZHgtPmhraWQgPSByZXQ7
DQo+IC0Ja3ZtX3RkeC0+bWlzY19jZyA9IGdldF9jdXJyZW50X21pc2NfY2coKTsNCj4gLQlyZXQg
PSBtaXNjX2NnX3RyeV9jaGFyZ2UoTUlTQ19DR19SRVNfVERYLCBrdm1fdGR4LT5taXNjX2NnLCAx
KTsNCj4gKwlyZXQgPSB0ZHhfaGtpZF9hbGxvYyhrdm1fdGR4KTsNCj4gIAlpZiAocmV0KQ0KPiAt
CQlnb3RvIGZyZWVfaGtpZDsNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXJldCA9IC1FTk9N
RU07DQo+ICANCj4gDQo+IGJhc2UtY29tbWl0OiAxYjczMWU1ZGVkNDgwYmQxZTU1NDZhZWQzNTU4
NDIzODY2MWNlNzJlDQoNCg==
