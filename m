Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F21EB5E3;
	Tue, 14 Apr 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186164; cv=fail; b=jS961u3RGnqORwab8aPqAwWdGWQTgSTITC7G/mpA/IovFahy/zxB7IPyVgnLmeJmLAC9llcRXlTlOHrVcRldHJWA7hwWhQYeQCA/7H+qGXjbzP75KcXOW6Ld6a+9HoIoK+FwiGD3rZnXi6UD8DD//IqBSMghdJlelYdijjUvu7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186164; c=relaxed/simple;
	bh=a2krKqOh0q0PQ9Twc4Ze14mGFh+jSjbm1+FS+ocxbSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEiTycL5Wzj1W0V6YuCMGCwR1XDCK43l3B2mVhzo7qX+MLlSyyUhrQ1nkcS9wPzLuqTWHMJkn0eCLWhfkmMargVZchb2ergS9GIwTygCArGL5bD7qun/PiAnNini6BbQ0tftsN9p7Gp62wqXt4arBgm4Ibghk9lmDvpgvAN5WMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDg8KSHK; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDg8KSHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186164; x=1807722164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a2krKqOh0q0PQ9Twc4Ze14mGFh+jSjbm1+FS+ocxbSA=;
  b=CDg8KSHKhtqI/iluHRTlXmq5pRnNoD/3yT6BUxFSSCSvapQ8MYhKAVeC
   v6TONYJdgj8GGwCwNfI0uBbxVNJU31JiuFSVEzzVwcVSNUgamGA4iraJh
   DRObdqBRen6CBUICr5Y+iRZKZEM/pb/CkBpfb42A8XsG5xGw6THPp3XYI
   OHQV9DJPVxkILKpOgaZzBOPV9lhVESnx86wune5KSoPiinOP6B7vMtbPD
   /6H+ryea5UOg9yIUakzZxKAy6SkLlGF80jwC9xhN39i6SYIfTvPClbCxK
   I01vm1vA3oY+OlLHOC6VeZU/iMKp8qiYwIjZb+LgrlbyxZdZEr1uZBv6c
   g==;
X-CSE-ConnectionGUID: Wj71wT4tRSmLOj/6QD9ppQ==
X-CSE-MsgGUID: 07+SB0FbSZmo54h5KjB5Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77332631"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77332631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:02:43 -0700
X-CSE-ConnectionGUID: 2LIjnz7BRG6KQ0G7IZ7lCg==
X-CSE-MsgGUID: +WjRsy1AQziRzPKK/Y9jVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225852033"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:02:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:02:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:02:41 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:02:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSWlAA1VQbRpujymhS2TZDlkBYnLPK+5kTMTMYvR1PWtCsC9onyn9GUnJtaivJPvatF0OwhJ8urGKSnd+zg+Cf4ofVHykCBpj9R0Pe9ZsGI0xruQB9M2UY+njX8whwwKuZqZnWFimOJ3XVjX0IKKWMk+izO+/zfyVQImx+y4pwmTXsvSfXGLCgwIiSiIVLjYJ8couoFZnBRbDxfXcM1UUwG/3EQ5A3oI3RrDivSCLxsnmIK3uL/47PUMS4H450tfMmwRJJVydGAnhDUi3H3ENUp7CFi61say705VntK4+wScyYvhGQgMtUyybtCYHlc7Zj3OdUHs6C1+pPgZQKIEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2krKqOh0q0PQ9Twc4Ze14mGFh+jSjbm1+FS+ocxbSA=;
 b=LvQecMqgPc77R1m/WNfZXawkEbwWDnKs6N8qNjrkmI1cKUoZwme8PxipvMY1A9VCJmL9Vxswl3xf9E6IX1EG2004F5cvzAQ82/Kwfw5Z0xACJvGNkcLtr68Vjby/8qml6G8R9NlAcSZ4OBuYVpWDdVU3r1yYV88yzW6+oENE/fiyAOq3CZcga8xM9y3v7fLahr1JPw42phtMOjOyAYXm/Po0ZINzGBghqrGFTvhS1hU2kSegJCWPCVQXkKMRD+yG0Zf/dh1bVxUeiHuw2ag6wFbzxRbBgedhR92/7Xs47ctr67W07TQSi4aFqYCgbTDDBjlh1hXPh7fioUfrXJk1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Tue, 14 Apr
 2026 17:02:29 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:02:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Thread-Topic: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Thread-Index: AQHcwQv8Y8HdIlbNRUuaJqZi32fcQ7Xdb72AgAEPrgCAAF9ugA==
Date: Tue, 14 Apr 2026 17:02:28 +0000
Message-ID: <7eb2cf06cf74e5d4cdf1695a5c3c4df6ac814de3.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-7-chao.gao@intel.com>
	 <fbcce1bd98ff8a7ff106f7583e3b576b170358cf.camel@intel.com>
	 <ad4jFpCYbW5laTbr@intel.com>
In-Reply-To: <ad4jFpCYbW5laTbr@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: 09d4c998-8786-4028-becc-08de9a479c30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: L2BJa9T/GOSkcruU4xaPmfwWNMGG7NvpBfSgD2JxHJkdEb8Zs+siOXNGCvAVhqSnPipE163ygVQ83riL7ptxOV6bs3rrjU3dIGSISjQIWZWTushYthW2nHLUJmR/T9Vn8HKR9nSHoUdTFh2FSsAgq1ppWTgdYeWd3ho5cEHCnnxjsAyUETBN9gmEP9aRZGGO2HhvudaoQXGaZ3JZSRZNcekbBUReCWnmEaaUzRqDWykfQsFHhKF958GoukR+zPjFW3k7sbzXKdW9aNM4UiM9iOU3jC7PTWYwG41JJriZZG7ZBV5XRvNu5+U9lnXX3QBDd7F27MOfm3WIo/O4eN6Ia2spkz4Xaobbni7lz96OqjjEAoH620w+/QWyQ6suDHqpKYcuHdav0EYLQG1o7sWnnsb+4yh85MBE9iwljCcnOrP+Zbn7WIMLTs+lP8ycm2D95Rmp8xbaolOWYgPtE/STVXwTKBusrknA+LK/otj0aF1ZnTbzfsvvYSNsez9hcB3FrsECbwVbqDo1JtqG4r3tFKpF4jJnSLDoH4g9w+A0ONylY5JtceNo8rbRHnJePSqo41EHorDibkcx5rKnbid9rosTVCbvUM/w1BAtaNQLdZiC5VOD7O5fSOTChC4pr9XH+zf1JSEprS7jvPBfhA9yJMg6Y0ky7IqlXy0a3epaBzpuTlhB6UvsyppoQlRrMLUm+V3tPOPlPdKa5O3QFWnXEG8x6pg6mb9JtqGGFFOqr2m05tGEGqZRCjBuhpGWMZJ5X/z9OtOIPttzkWMKpc13VRWPQg5s9XEnI5flBw584Lo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NQc2hMSUEzWHJ0d2dHbnVlbENwOVZVWktLR1lYTm51MDBFampoTWNmUmxL?=
 =?utf-8?B?T1lCZURiYW9RWjRHcncyZVp2WlR6U29ZcFptZzE3NnZHNkUyVU91RXlldUw2?=
 =?utf-8?B?ZlJVWXBwYTJ2Z3dnbXE1VW9tc0dXdUVJaUZKdExaM1NKQktOb0k4K1pKWUZ0?=
 =?utf-8?B?Zml0Szd1bXZZQUpNSGpJRE5mZkVJaG5KazZOU21xOUE5S1dlN2p1eTRDWXNs?=
 =?utf-8?B?elh0d1lkVFpuaVB0THZ4cGRKaklMRzAwS0ZQOFp1bVRLM2JKRzlsRGtzU0hU?=
 =?utf-8?B?MHpEdWZZWmM4WFYyT29GK0hIdzhwVHk0WG1CblRucnlCQlQzeUtPNzBGWE1w?=
 =?utf-8?B?c25TUzZPMHJVWXExUW9CbU9LTEh2WU05ajBwc1laWEVpSXVwNUZlL2N3anN2?=
 =?utf-8?B?OGlxbGE0VU56Q2QrMnB3Sk5qcHRtdlJIZmtSVVJQYkx6MzJqbkI0NlkyVzM3?=
 =?utf-8?B?ZU1GTkhXZGIvTjlpRmpWclo5Z2hRVGthQkR1MkxZYi9CM1RaVUZaZHFJVGxH?=
 =?utf-8?B?UEo1RUQxT3BTbDJtWXd2Q3lzOHo5T0ROWGZTaXVCN1FNU05lV2I1TVZwWi9x?=
 =?utf-8?B?ckdaRjFSemI3cy9jVGRiZlJqN2ltbTA0eG5EVjI4UjBMS3NYK3o4R2dWcytH?=
 =?utf-8?B?RDVYSzJJZzJDOGxnSkV4R0RubVcrb2dTL0JvaHM4TDdBOWFONE9jTENOdTVE?=
 =?utf-8?B?a1RsejQzV1dUTTZhZHBFaldESVpIY1pqa3pnQ21LRzNHNGhMVytwR2NtQWpp?=
 =?utf-8?B?SHhIdy9SZGpXaXppUy9lK2RHL3BFK2h2STlYRVUxTXk3MFBMNFAraWVvUm1i?=
 =?utf-8?B?YU5abk9MTUdtU0NvZVJCcFBHalRsU0QrYUZydHJueXQ1NmMxbGVFTTYxZlJj?=
 =?utf-8?B?SnJaQmE1d3M0R2xWSnJMRnVsWWp2dFc0NWZBYUV4V1h0N200UUtCQ2VwQ0gx?=
 =?utf-8?B?VjllVEJwOFgydkVKcXYrMnhwbjZOQ1I4OUg3SXkvR25MWitvRDBSK1dhNnhM?=
 =?utf-8?B?WGZnKzk2ODlSVHhmWHNpZ0FPOVNIemRSWTBwR1J3a3V3YTNkRGVpR2pIK1l2?=
 =?utf-8?B?ckx3MVZOQy9MNUN4Qm5IVXhXaXJobmt0Rk52K2UrU2JGTERaTjRiYnlnTndS?=
 =?utf-8?B?RXNwUlNGZGQ5K01wMkhHbit4akhOM3J5SVdoN09iSDdSVjhJbVZQbEJzbHY1?=
 =?utf-8?B?bjlGK2YxZFpCenRpUVdqTUlmZS9IRkswTXZtL2d4U0IxN1VEaENkUG45T3Q2?=
 =?utf-8?B?eURlcndvUFBRYTNFU05ORGNjeHRxZkNkdjQrZTMva1ZOWTR3cXIwZW9wWDBO?=
 =?utf-8?B?T054L0xTalhVcjdjWm9yeXhuek1pU3dhMVFkSEtnb3lMR0w2Mi9NSkhCR09h?=
 =?utf-8?B?ZWtmUTV1eWo4d0oyTmozcHpZb0Q2QUQ1UldCU0FsQ0NPdUUvaGJsNjZNdkFt?=
 =?utf-8?B?b1hlZE9BNTV4YmxrbFFLTzFjNGFWL3NuLzRkTjc5b25qSFE1QjY1Q0RnVkxD?=
 =?utf-8?B?bkxpTVdwOEJoV1l0TDhUYTNST2NtM2RvM0ZBNnBPcEZEMGdRQUg4MkxzYmRL?=
 =?utf-8?B?dTgzNXR5ZXpiOW1LYXZQRThpdkZTbDU2SWtzZjAzWWM4WkZYQ092OVhET1Vp?=
 =?utf-8?B?Z3IyZTM0RnkxMFhnVU51dTZETXY0WFk1UWpmdkpnaHBTdXRvd0k3c3lGaldW?=
 =?utf-8?B?U2pPMmJQVHRBNzlLM2RGelRjK1dhRG5nRHFuL0pab3Y1ZUZ2Z1JBaGkrVXd3?=
 =?utf-8?B?c09SMHRqblpFeGxQQzByby83QmkzcUtoM1NralppeGVyYnlETVhOMU1aanQx?=
 =?utf-8?B?SjFOQzU0b2ZzaDdTbTdINlpaY3Z6NkN1dkgvRU41ZmFtUlN6UnN1ekREcm1s?=
 =?utf-8?B?Y2poMU1DdjRFUWdUelVTSTBPbWs3Yk5SUVd1d1dxdElIaldMR1JsYStYejNj?=
 =?utf-8?B?ci9lR25rbE1aTUp1Z2ZITDdESkxDemF3SXZvOXJsR2cwNTZ2Z0I5NDhIS3Qr?=
 =?utf-8?B?TEQ5OW5heEs4a3V4NUJRMUN6TU1penF2N1VwRFJxRlE5OHhMckNiQTZFMVB0?=
 =?utf-8?B?VXdIUmZzK2FxUmJ0R3Uxck4xU2FyR21aQ2lpUzhuUXg1czYyMVo3cGhrbW9m?=
 =?utf-8?B?ZVZWUzBkZzA5TXNRVzM5L0lPZ0ZzMHhWcDlmZnlaSmFIamM4ZUZmWFF0enlF?=
 =?utf-8?B?eHRYRzdFcUhyQUVNOXFXL21pblZyc25vTlRxekFoQWZvT2trakk0QlZURWRL?=
 =?utf-8?B?TW1SZmpWdHY5dGN2M0ZVTkZqOXlrTTI4czRYY2x1SGNJQW1iS0sraTh3RUto?=
 =?utf-8?B?cjFpek82cnFrWEdUMHp0RC9vOWVFV2RRNlVWQklrRGc4RVVJVkdxVE9LOFp5?=
 =?utf-8?Q?3Jtr76zl2EhNuYS0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30F34C46CEEF8F4F9AC5DB55E37420F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WkDRHwN+fe1wbHdSFlgDeS5desiQL4CrlkvO/9PtiAtiLGtn2abMqfkAr6zCE65Hpvet12JCGRcMmdJeLQWyxdnqM4BMho1qvd/ozBR41YryiOSUGcO26qo0dotzgmiqngxhUQZxBbhcOg0+mSH01LH2wkECYka0hn80A5ngyLE8P+N1q5kSTdQXQxso5rpIaBF+1ulZPM0xvGCK//MV7tFfxwWfJBR+J571yZ15s5Drph5mT4P1z4zDc9C6eMlZ01BlXqzIsRGQPkbxs6+4uiGEB21RdHWP0DW5YGBdVa1QVYN74nJciUdQpYY7iYFkkepKJLre5f8a52udDiILuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d4c998-8786-4028-becc-08de9a479c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:02:28.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaMafGl5M/3NgGigfSM+WHQzROu9dGxjWZWxjGGI/h5SLHZLuyA3LqaQg9C22papmxPf9It8dtCGb/mx2kXW0ZmAL/4ap7epGJXa05yvl5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE5OjIwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBD
YW4geW91IGV4cGxhaW4gaG93IGFsbCBvZiB0aGVzZSBvdmVybGFwPw0KPiA+IC0gVERYIG1vZHVs
ZSBzdXBwb3J0cyBtb2R1bGUgdXBkYXRlDQo+ID4gLSBTRUFNTERSIHN1cHBvcnRzIE5VTV9SRU1B
SU5JTkdfVVBEQVRFUyBpbmZvDQo+ID4gLSBTRUFNTERSIHN1cHBvcnRzIFZFUlNJT04gaW5mbw0K
PiA+IA0KPiA+IElmIHRoZSBURFggbW9kdWxlIHN1cHBvcnRzIG1vZHVsZSB1cGRhdGUsIGRvIHdl
IGtub3cgdGhlIFNFQU1MRFIgc3VwcG9ydHMNCj4gPiB0aGlzIG90aGVyIHN0dWZmIHNvbWVob3c/
IEl0IG1pZ2h0IGJlIHdvcnRoIGEgY29tbWVudCB0aGUgcmVhc29uaW5nLg0KPiANCj4gVkVSU0lP
TiBhbmQgTlVNX1JFTUFJTklOR19VUERBVEVTIGFyZSBhbHdheXMgYXZhaWxhYmxlIGZvciBhbnkg
UC1TRUFNTERSLiBUaGV5DQo+IGRvbid0IGRlcGVuZCBvbiBURFggbW9kdWxlJ3MgdXBkYXRlIHN1
cHBvcnQuDQoNClRoZSBvbGQgc2VhbWxkcidzIGRvbid0IHN1cHBvcnQgdGhlbSB0aG91Z2gsIHJp
Z2h0PyBBdCBsZWFzdCB0aGUgZG9jcyBJJ20NCmxvb2tpbmcgYXQgc2hvdyBOVU1fUkVNQUlOSU5H
X1VQREFURVMgYXMgYSBjaGFuZ2UgaW4gdGhlIHNwZWMuIE9oIHRoaXMgdXBkYXRlIGlzDQpmcm9t
IDIwMjIuIFNvIHF1aXRlIG9sZCBub3cuDQo=
