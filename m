Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51264FDA52;
	Mon, 28 Sep 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630766; cv=fail; b=Ri7ETWmwiJC0iR54QKyhhds+mQTsxCNARLJNfYOi27Pk8E9GIyg56uzlfqPb72IvF4cRgV3XE6LrS73m1kGzh7KOK48KPuS/9lwxvPxkUfE6zlAoxw2OT76EgCLf3dHCIGq0BgA+sLcccKOeeS3fXWS0ydnncGKpOE3GjFxFPl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630766; c=relaxed/simple;
	bh=OzUz/Fdb0JDnEyaZsnhXr/YO0/flU6mhw0lZ+3pNxP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SPoD2wul66JLrDe5uF6OE25qbFNNBcBoky866+VhBbWX4Jq+O3dYTzE5OYA3uEi6S/na9ZIF9b46BPd2crl3ziu4PAJe93F9UhjCmiYE8TGw4TEi6+ki2VKLknp+nP+RLd9A5yWgghklDvSR/6qJN5PyT69c/inaEI6Op1uQSJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yuq8AzgU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yuq8AzgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790630759; x=1822166759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OzUz/Fdb0JDnEyaZsnhXr/YO0/flU6mhw0lZ+3pNxP0=;
  b=Yuq8AzgUU9QqGYqM00fKahnmLkg/3ccGP7Z2UINqXk1rwK1SGnCNdhoD
   k2ZLH9024oMQDgbPmvWGF/nA+h4q3ztvJo0iA8VNZQdFBhfTbqBvDLiYS
   79500JRK/k8rGgzn4P4WmCLU39xzAGWF+15Uy16QLWqDBeE3QC0nX/k6M
   NiyCUaAekwysHoZl5o4340efscBwyxXHY9ibmuFago/3fjRRXFzaAwjZm
   Fkfsfiu037d5pMuUmiM6DhCCsKnzORUzyFCf2mYa94m/DGCOLDhrCIEQ7
   FJtICdOlNKucrDrSvRPUNsi+O6sJw7UERFPyxjk6FHwstFfXoNQHhUfvW
   Q==;
X-CSE-ConnectionGUID: yppnMJQ7SI2USidpgvT50g==
X-CSE-MsgGUID: 0qWIOidIQG2MMUeg1/tZFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100672683"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="100672683"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:25:54 -0700
X-CSE-ConnectionGUID: DO+/oTitRau9UACgpHl6kw==
X-CSE-MsgGUID: SBNdldKcR/iyih/XdTb8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273294575"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:25:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:25:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 14:25:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0jiYghRqq6i70wGvaLEw6lkwztofrHcN/Ggr7gPEO/265oK1hYAUsRxKJizLtwqN0W6dOoAPlsLWBRZPSTDqpMTrsjRhvqOJRhU37LkR3pUTh4BsB4OFlETscrZpv5iJIuHdj5rRyEHJo47crgJZ4iVOrdez79SDT6WQm08Cx3InaK9Lkx3QU5MzbvdekGE1FwWib1MI7VStGXh3RDPEfrfOGyuOsMf7265tAwpY+LRPPkkCGiz8/pXIUvnIq4C5Y5ctOpj87DJziNoh0yEEUAYcxcIRpYNw/vHhHtFwXZZqFxEhqF7PuZvNTEXnF22pwpgTvVLoETnW92owU3Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzUz/Fdb0JDnEyaZsnhXr/YO0/flU6mhw0lZ+3pNxP0=;
 b=JqP/NHMT7ByjHy9s/HtafjM1Zfe1k0jFhZb8KhzWHXNbac062S6Ew4WQlumZ9qP5+poSpFfis8ZGKeLRB8bImizEy8OV1tFbSyto3DHRG5kX8QGM0jycFTBYkIjRjjP3X8VOuFCxs9JYhIHP/tPKnbuGQeCQ5HhgNeceVSHKrH5A7svPtggQ95OUupT3rjsdMpJRMAvYUsgBef19XfiWD1d1OSrcTH8ITO/uqcS7P0O74zr3Z1VukJ4qDGc1gNwTXr9PFqtmX/ihMtYMQZ3J39jXnXOWnKJMQ7mquxWRHvyvLzbn/IVUKYs7uYgLjLR0vozyjiE7Iguk0gU211dCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 21:25:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 21:25:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Topic: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Index: AQHdTzGsoGIHh9qePk+bCG/ii8ItOrbkVhWAgAAoFACAAAMngIAAACgA
Date: Mon, 28 Sep 2026 21:25:48 +0000
Message-ID: <a2fb22dceec6d7b75445ecf0a9ef6ac238eb5c78.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-6-peter.fang@intel.com>
	 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
	 <arrYlnkCq4GDIG9M@intel.com>
	 <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
In-Reply-To: <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: 7ada2ab9-b2e8-442d-88e8-08df1da710da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: hxKPotBfhKrJFSoYbUIEFCMv6KNycy03WAgW6pBGnS+5GeuM5PU5iNEAVOLCR7mHOrZd1WHEDYr0gXqW5TrW2WosDND48Ty4QqKPrELOEL2K10ny0WGkiy60ETOdoSl5fmvUf8nOkDTh+MNyAx5migkfl2a8cX/joBzTb7TO6aw1uYEh6OYyU9Gn0GW37dzAn7Oc2hi2QcqeqS4Tw1YTGvkwZ/Gc9G50iDBknPDL9Dj/UXmaSWUSjvi7C0kdGih4F4qlPnIbwDCwUX16WNhOBUrKS3t3nPnXg4YC8rZ4nJ9+mey/cborZ+FNbvlTozzLDxTiaVPLXJXD2rARYdtkhY/6m44jNuD5j9NkVDChOTwGKJBcXwX7Dr/68WChTJEbmI1+O2a2/334e+A2VQtJa5GdrtJrjtEFXnZ6Wrrmn7jTg62yB1fNzse4BZpH67/dw6pnHDv4CpwfFzJAFgblAc+3xBVuELyRvAEMOJHQYvaJcIuEsacRji8MGzgUTvcm7aIw9OZuwPjK315KRbhhJPG4/F6HhTLCEpgp4FBMJOacqdW96N7quAD37124BhjxS56RXPbT5DpIdnRQKZ/ealM7WITMkPANVt3h4X1D79pC+JOEcrb2zlxgiyizXryjuncQZnzSayF63xgceYwnZngGQs8TQiRejtRd9kAad0u1+jfPOAcvj3oBIpXiLGxKeC7WgWbd5JyUz9CuyezCCB95p0bvLAuq55T5KZPnvf4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ZNL2h6VHlWY1ZxbFk3YzNiK3gvT3J3Q0gvclNqNkRSa1Vta3hjanVKQUZh?=
 =?utf-8?B?dGoxUEI2V1hwak1HLzBHdHdnYkEwejVzOWhZejJzNTBGUjhYYk9KWVI5STR1?=
 =?utf-8?B?OGNVeTduME5PbjRrY2VtWHpFSlJWOVAvaExPdndYdWpYOEhqam1EUitGcHRM?=
 =?utf-8?B?S0o5WlB0VHoyaFRXRk1MRUZzRHVJbUEzZjBaMnV2N3RqVk1GN3FKczV4UW5a?=
 =?utf-8?B?a0RMOVE4Q0YwV1BZNjkzRzZEcHc3aGo2VlkrZlRhVkExOVR5ZENtUkNmWE05?=
 =?utf-8?B?K0MwS1RYeU9tZWRVNHRRNFJFZkRIelY5WENvTUxkNmlVL2NJQ1VMRGFHSFNt?=
 =?utf-8?B?ZDR5LzFEemhuaE9keHkzQWV2TUdZanNpVjBwQUtXdGcrbUhnWlk2dlpwbUVq?=
 =?utf-8?B?YU5MQXg2U052QmF0b1o3RU5TUlQveFpVMWVpVlRyOVd0cWVWc05ObUJBTFdU?=
 =?utf-8?B?ZEhxYjlCaGRzK0NNZi9NN0drU3F2bkxCdk8wRXhXVGh3eFMwUHhhWGVvVzdi?=
 =?utf-8?B?cXBQbU1kSk9TcGVad01lSU12UGJEQkIxUVpoV09KQ0ZPMUpPTEdBaW44ejNH?=
 =?utf-8?B?OUMwbG92WURXQWtTeUk3VHRsbXVXUlFnYTZhQThucW8zMUJOZnVNQlFXcHhD?=
 =?utf-8?B?Z25UZXFJR2ZBZ25UN1BnK0JHZEN0dnJPdkpOdXpDaVJTbm5qL1VKWmxZdmpv?=
 =?utf-8?B?OWIrc0xBeWovNUs0eHpISkVHdjBobGprQlowYWtmNHRPOTlZYWVpTXIrUUlz?=
 =?utf-8?B?NGFlOGUxanYyR09SUEdPRjdnbW5ESzdRM3hEdGIrV1VmOWtxdVBERUdNN0ZP?=
 =?utf-8?B?aUVQcVNjUkJ6WEhvZnFUYXkrZ0tXbEpTb1RSVDMvZmptczBKS0x4aVJoNFk0?=
 =?utf-8?B?Z1BxL2NPdzhYUjhNVHFSd2dtc0dqWXRSRmVSMFVLcEJWbEZxcFVUYzRIbFJs?=
 =?utf-8?B?emREbzdzc1VZWmZsU200NWpvc1ZmSE9ucU0yM1htS1dndjZQeUdTYkYzdEY4?=
 =?utf-8?B?aU5YaVFkTys4MVNDOGtnR0tVOStMbGVJY3BzTDdNZmd0U2dVdC9hK2kyd1Zv?=
 =?utf-8?B?bSsrK1dRUm5rMUFIZTZsWEhyL0RxUHVhSXRQMTk1UE9GRTU3SEs4TGE5ZDEv?=
 =?utf-8?B?WTdmcndXZllLWWQwMEhkUDhERmxRaldDQm5kNmRmTmFUa0xmSytnMmY5WURQ?=
 =?utf-8?B?d21rZEtBTXF6N1FNcXdHRHgramVhZy9lQmQwMnpycmhKblBDL3Y2MzZINjUy?=
 =?utf-8?B?KzhYVGg1WFNUZ0h2TmR2WEtyRGlpWDBMb1hGRDBkU0RWZzVwK0xCLzJYY2F3?=
 =?utf-8?B?RnltSFV1TXFoZDlHbEIyTG1BcTh2UVl5MkhiWExzcDJYV2VnanovWWc1ak4w?=
 =?utf-8?B?blZva1U0bDVDci96YjcwdkNVY1NZL1I3Y2I5RExMYkQySFdvVXM4NDU2bm5O?=
 =?utf-8?B?UEpWNkFMUXlDeUhRdlByd0x1Wktqbmx1SUEyRW94cExpcTRDWStEZXh3K212?=
 =?utf-8?B?aFRCSklEbCtBclFnTHJYcjJCMXNLdk9sbm53VG9vSjdET3BNaGlNT3BqcWpM?=
 =?utf-8?B?bFdXTDhSY0RSb0JBdFcxRjdRYmtsRGM3RW5FY3RjaUtKZG1YZDlVSUZPNjB0?=
 =?utf-8?B?ZjlobTU5M1lkaENtZTA0aGh0aXdhQU9ETUp3NHhMRitaQjY4Vmx3bUlNRk5F?=
 =?utf-8?B?cWpXL2tLakFkK2IyMmFpTUYwcGF2dUhpdkN6OWxXUnRuenRTWkhaejk5S0lF?=
 =?utf-8?B?S2VOUXNDZTZCczE2QWFQZjN4aVR2NEljQjRHSU5PWkRpN0kzU3llKytWM3li?=
 =?utf-8?B?aDYrWFdhMGpiUHU0Y0VVSUFkLytldVlMQjN3NnhhRENWZllDK2VLLzZORkNH?=
 =?utf-8?B?SWZSenhmdlFWaFlRL2ZqanJqdFprcC96QmY2Tlpqak14U0tsUWlFSFViS1c1?=
 =?utf-8?B?dTJuQnd2U0I2dDByN0pBZTFQMlMrbjVQQ2c5SXliZ1lkZ3AvYTU3YzVUQzNF?=
 =?utf-8?B?TU8xU2xxa0I3Tk44cE0wVkpnRGp6L3Z6aXEvTUZRUEc5L3FRRWVLaHpJQ0Ev?=
 =?utf-8?B?eWFOZzFvck1VWHZRSEZjc0s5Ui83bFJLaXJ4WWh1N1J2cEFyVktzT3JiT3Q1?=
 =?utf-8?B?ZHhmWG5kMU9Hd2hobHY5YVhGUWxUdlhKSnZMSk9OTzFpYWlSbU9aVU9zcWJz?=
 =?utf-8?B?VHpNK25Qc0tBZ1hoMGhNcGZrOHcvTVFQY3IxbC9RUjVmQzYzdEhsdnk1b3Iv?=
 =?utf-8?B?Mk53NjVPeG16Rm9MTnByM1doaWdRZDBVcE5wN1ZMZFllNFV6WFhLL2tqV1Vn?=
 =?utf-8?B?RXQ4L1U1QlNJWVdDQmpJM3dBcU9lcHBPZjNweWZWL3cvTHk1QXQrbGRLY0VP?=
 =?utf-8?Q?FcM61/aYZPLXIvvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B1F768A7501E64591B2671FAE7A1BC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jpWtQOOAHVvpZDwjTdTdWP/vnV5Pq6rwf605WPr9t8SddcN3V0gSFM/J0xbMQ4j+GZx66rwAzt1qMILcVRmvux/kwBIOwlBPlhgsqJXU6uFjrjXna5zJXMV2RcJK4ePsayzqUdU0+rBi1it1NnM7z+AIwZ6C/ZA0rvJz54USecj29uNCRO8Jw5ED/F7BKBQ2apqso1QWlWs0Rlh2PmUtjOvK9nPjZ2IWD+4ApEIAxgypNrtR1+Iz4K5YlXf3D68dH/8WnnLheRz5aQW2EvpnH5IGwhfyb3F/JSNIgG3DA6ITdlrRAMHoIZDCo6IzOQnICoC7siAiHIAgpNUTCAa/zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ada2ab9-b2e8-442d-88e8-08df1da710da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 21:25:48.9113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: et+UBDToYFAZsIw1L88lNIUOAlTk44r81NapKJlZ8yHEEJz0ekWNTQpzcR9YvxY8vRcNS/gXdAmkS7ayqnAnncBygsICegUietbDHyjBroI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE0OjI1IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiBCdXQgZXZlbiBpZiB0aGUgcmVwb3J0ZWQgc2l6ZSBpcyBhbHdheXMgcGFnZSBhbGlnbmVk
LCB0aGUgZHJpdmVyIHdvdWxkDQo+ID4gc3RpbGwgbmVlZCB0byBzbGFwIHRoZSBHSENJIGhlYWRl
ciBpbiBmcm9udCBvZiBpdCwgYW5kIHRoYXQgd291bGQgbWFrZQ0KPiA+IHRoZSB0b3RhbCBidWZm
ZXIgc2l6ZSBhZ2FpbiBub3QgcGFnZSBhbGlnbmVkLiBTbyB3b3VsZCBpdCBiZSB1c2VmdWwgaW4N
Cj4gPiB0aGUgZW5kPw0KPiANCj4gQWggcmlnaHQuDQoNCkJ1dCB0aGF0IG1lYW5zIHRoZSBtZW1z
ZXQgbGVuZ3RoIGlzIGEgcmVhbCBmdW5jdGlvbmFsIGNoYW5nZT8NCg==
