Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C972288D5;
	Thu, 16 Apr 2026 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303819; cv=fail; b=ADEDOE46w3D1QMZWqxXxOCmeEZwkrfkPA4MGXfm66ucGaPpGhfiDysnaVcRHGmO3MrRhPyHEW4XnKo9irO/RuyB5NU6Mph3c57VOxn7UXyNy8tOgq8sv/qx7UMuX8bMOap80XLPbIFNU0ldxC1AN8bBkLFCZw+iediUvrLOeVJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303819; c=relaxed/simple;
	bh=HARsyIa23/AxRCy+bXuedAVY73qGUj/+ZyBpGBV+SGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtbdDmZEZ/RHeJdK8Z5f0LGWHRqYsN6pWtRUnHusQeoZp0BUAxuF9OJ+04kO8nyrG/gRPIp+ANs/tu5+8dxGkSTeblyrhZ5Xjchm9VYjvK8H8HLa/G0z0y+ceX4tqbpyaXK5ax3ipsNFKlpgS5YDvi5tULLvLLf463oNcSTS3FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLUqIEpF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLUqIEpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776303818; x=1807839818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HARsyIa23/AxRCy+bXuedAVY73qGUj/+ZyBpGBV+SGo=;
  b=hLUqIEpF/wn63fTfjG3J1QJD4IciNA7HSmzYf4PCEQ+wmaf6NOpo+JOz
   Wng/8JNlGeg9w7Yqt+WS0kTeI+OZ31vPqf4rAkwFyl36tk+NxcmxnEmjW
   xD89Bsp/sPU2uF+8JjGEPjVhReM9YRIRPJKW0bXKjp/Y26Q+FOi6+2XXO
   inxO8UbfKBrMcxLngi0tR6QDM//OWE3Vl/N7q/QH3cmRR8+tnPrpggHHa
   LN+oRRsli9UHksUVKPuwqrFEiDWErAk+kwHFLlCmp6RFdqx9v7SXYrh8W
   xpx3KZwrMhiaDJczpb9ZmIx08sewRwtI1FtnyVRR0zOsb8T4lk+74vIiS
   A==;
X-CSE-ConnectionGUID: ZY6gPOrUSNWcOP1PYFMuuw==
X-CSE-MsgGUID: pddGcSD2T823GipQ/D8BAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77268856"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77268856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:43:37 -0700
X-CSE-ConnectionGUID: 7kq1vmBKTBGvu7Nuzd3ZfQ==
X-CSE-MsgGUID: L7tD0mH6SzqumIdIwVJ0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="229558302"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:43:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:43:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 18:43:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek78zXU083urLtnTRNGj8T4BILk+S06SEyQZkrjiZZ9wxzFGa8hMk9LClx0vd8D6oTt81GuV5rOnHvtdlvtFX3ce2Ngy5gvhKyZxzCSMp/H3fXcBkROqs0OtuMo4TT1AjD++qgzab+yS6ABL9j8TCeq1COvPT/5QOB8/iE5eeoMKiKbY1QVZaCmTGg4gEgws9EfeSum5lE281hDXyDzH8s6T6Gw8IjkKi14T3HcmFf27bbw4aAEzV1QjRazJLW4DbjyElzoT4FjNJc5F7uU2S+/Qg1Bitdi/mUQFmpCg22s8H6cQI1/KFpind/W0hBaw4e9GFjwQ0aB/jgrUAsHXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HARsyIa23/AxRCy+bXuedAVY73qGUj/+ZyBpGBV+SGo=;
 b=jdkOFhcYyb7BshVKgdzbDbV+SXqs8p/TpBu+WqHxqzUe8/ZOIn0l+iAqmqX/DFjpWpYzkfLJBBjVoneuf+gbxQx17H2Dn6Up7q/Kl+3EXUWUU7C81eR8hZcIDQmDwEw89kk9IcfN1INduO8zSiLrnHT1yTmgK7Hifvc6oUTetDPoUPypn8LNKY/gFR9OdepQxXEKnbhvEbmu1i9ME63pl8CRM1qZ45pyKpXODVgrou8R6DIvbRW3HBzzSr2c8IjIdwBRPBhCSnfGnNKZJuY9EMFbUMnqPOsnG9lD5KSvOXuD6OnFqonn0uqnQsObN5DQFiDG5mmfyU3MoIQXrTVr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 01:43:33 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:43:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH 11/11] KVM: x86: Harden is_64_bit_hypercall() against bugs
 on 32-bit kernels
Thread-Topic: [PATCH 11/11] KVM: x86: Harden is_64_bit_hypercall() against
 bugs on 32-bit kernels
Thread-Index: AQHcyHzAcoL0yvjunkeW1xNqVWqS1LXg8+EA
Date: Thu, 16 Apr 2026 01:43:32 +0000
Message-ID: <1a48b8d66339d89a71ca0c978201ffd72d24ec99.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-12-seanjc@google.com>
In-Reply-To: <20260409235622.2052730-12-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: ffeda07e-db4d-4ee3-de39-08de9b599197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: VvOvTZDsmv9pOeEVaQ5xBSfguv1M37iwsEfrZZjuOHPfV4vOcytAnP6iAB05MLgXy+cgZbq6lpLsiWRtmTFamEo9ULWZuUa2R/VFkLQheamp449dIK/h3R71zqWCexYqUNKkpdN5mwte0i1JB3QwhOTpJMmwwqm9RfdxclwHkS+7MQ2pgDuNCLur5AD1/uOIFls0GonfuA5KNQ4OI/bWjjnTZayCUmY9vDp5VYarMIR3Miwo6borotOIB8zYEoecWji7PFwtv7RbhQ0FpX8mteDauQAvxguEUHIEYGJlv1CUkO3BP49q/1cKD8iqKjwCk3PAlDe/qtE9bFK7BQp40GDWUp7g6Xt828Nr13hwVO2jt5Aydm8DGw4TOdvIh1/7P1DlA9mV0rRDvArBX7C/OWgmJfbCYH2CovHA3R4m6GJJLL63Wp0QsvUTHu6fsLdUJVvNLQVQGeOZ0y3mVqgTtug2NGrzKo6dEmuTw8BAhwtlHzJscIKSLTr1b0dVrXLXDjmPc4SdGD1iFOfXpRg00YS7FSXaxCR0n0z5ItU4qgMCFCmx5SFGx6i+y+s6x7myno2T7z36U5wbEUNVl59gX2IsHStRaS0t73qz8ZIfJDbNsM4sXcCSfxKOMCjDo4Avco5rxQN1Kzvkj5Ws1Y1JkZBglR0w8HOV1WC5B6mbMxV6zVzMZZFMXmtTUNPotRkzkEZtr+ZoWozIy6qwlaNPvJKKf7D+frxgy2Lw9E8Yd/3kD92iT4uhz7cifNhXmXnq1y/4gjYfRU9tuIfGiGlbEJ051zshgNCwUqJXv/8GkLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzRkZDRlaUtvdHVoK0xsYW9qNzM5emg3SUNtK1VYSTVCeXBHNjVGdUthMEhB?=
 =?utf-8?B?R25VaWJha2hZOCtiTFVjajRPNDB2NHRDaUk2NUZITWZmUmFkSEJzLzVJNEVu?=
 =?utf-8?B?bG9UeVFkZnVaRFQ1WUVqNEV4RVVRZUcvczk0Y05McDByWTQwUUt1T0w1NklB?=
 =?utf-8?B?ZjdablNvWDdYbEdpalN2bTFBeVdHbUNKQ2hJZFRhRkJCQ0o1NEpIc1Nna04r?=
 =?utf-8?B?UlRFSzBvTFhJeXhIUmJxWkltaXdGQ2NXMHRxRFI2NEQyUHQzcFNpT1pjVklq?=
 =?utf-8?B?SjQ2QkFOd0FLSk8wSmpUdkpkVDJManlCVTI0KzBQc3NrVjNwdUtJcndvQkVW?=
 =?utf-8?B?b0ExNmNGZjhFQkk3d2d0REpHYlJkTUdlK291S09BVVcvcXJwRmJEMGNRRWFW?=
 =?utf-8?B?cmZnN3hkYkY0NUhNdDQxckJPeFpmYkNEY21OU2cxenF5OFAzOWhiOWVzMFpj?=
 =?utf-8?B?L0ZXcXcweTFhemJuZ2tTQUpPcXViSXREdDF2RGx2c09ObnA3aG1qbXB6QS9m?=
 =?utf-8?B?SXNQNyt2SlpVaWh2aTRydUoxeGx1MWFNcUtwWWNKK2JGZXB2UnRQRmYwc3Rt?=
 =?utf-8?B?WGs1aGFOZHlyc3FPR3NveUlyWm5tcHJBMzEwZnh6WWJOanlvQkRnYjNXS0lP?=
 =?utf-8?B?ZXd4bXNOeXJreTFTcEFiTk1UMTh3aUhidHUvczVzMm5aelZrNklXRk1GL2la?=
 =?utf-8?B?Tm91SU5rU0pmM0EyeWp3R05UaWJEcjNRS1ZBV1BjeC9EZnc3YlBEblJBc1JW?=
 =?utf-8?B?enpJbHV1dlhBQmZoK0VvM2VMY3BrbzF0UFBNYUYxU2xvWDdZZkdwNnU2UTVk?=
 =?utf-8?B?Q0I5anAvZERLNVlhaGpMUk92NVdHZ2JQeVN1cDUvZXJCQXlZSkRwd1l2UDE3?=
 =?utf-8?B?clUxUTNsUmdQcFFnMVFBeEpweEJlT0RuSXFWQ2ZlQlR2VjZ3WVhVVFFvWnM4?=
 =?utf-8?B?NUV3UENyM1JlNkpjRWowWGovU2tyaGNLVVlDdmdrWWtTV2d3R1FXSEptbjFo?=
 =?utf-8?B?RDVnd0o4S0dKamJsazVleGg3N0N3K0huY0dTZ0sycDVoSWJIVHNhUjY5bm14?=
 =?utf-8?B?SWFrWjk3VDBGQk9sUGxpT3JJNjdjSlBQMlh4bGErTFFNb2pWSUNlejdhUGdQ?=
 =?utf-8?B?dnFuSlFXaWJ2MG9zbyt0aVoxS1BxUHREeDlSOHhaODFiWTBISEJFay9VaFBo?=
 =?utf-8?B?ZE1ZMkY4S3BvbGtxcGFvUDdqYzBEMTdnaElZRzVOMHNuUGNLM0hGM05xN1p6?=
 =?utf-8?B?L3REUTI0Q1pQSjVScUdGaGk0eGQ3UFJSMjgxNkRrN1BaTSs0cUExWTJKN084?=
 =?utf-8?B?aFc0WTdBZDQvbWZZL3M0Z00xUmtrZ3Q4U05MNGRuYm5WbFFlWlE3NjRpUnJZ?=
 =?utf-8?B?S0ZRTWxsWUprSWFDZEZLS0J1WGdzbElsdHZ3ZzZENWVTWktSR3FidGF3K2Rh?=
 =?utf-8?B?OW9CRUo4dzlGOXhWc1VKb1A5NE1qejRBQi9ISEY1eFY1clQ5bUxCTjVRdU05?=
 =?utf-8?B?TlJ5Tm9vaklpRHh2bDk5bGl5enliemdmem4yL1dQZjIxNU9QWkhpekNwZmdY?=
 =?utf-8?B?ZTh0TXZISnUwdmNjcWw2N25KREJLRU9DL2NZSk9wbDNEcHFDRnlsdE5PNEpC?=
 =?utf-8?B?cFhCUnpHbS9Qd0tlRUkwUlFnaWxkclR2WmxDT29WN05WYWFxRWFhMUU2czBT?=
 =?utf-8?B?K2JSRzFOd1RzVEtyOXFIbEx4WW5qbmFJcUdaWWVNY2oxWDI3Qkdnajc1bjNJ?=
 =?utf-8?B?bUUzK3JmaklnTk9KcUZHSnM0OHFSempybWEyQ3Nkcm9KTmxGR3dlUjVIdnUx?=
 =?utf-8?B?czVGbS83ZFBRaEt0cnJrQ2NpTGlYbUJocFFDai9PeDlTejdBYnpRM3g3K215?=
 =?utf-8?B?dDRidW5TQkZ6djV1Q0xZbkhwZGhlNDFqMTlvWXdtR3R5YUZWV3JlM2FWTHVr?=
 =?utf-8?B?Tnk1c21qM0tRRXFwT3IwWS9qajltZ3ZpcXhoSG9FSkl2bjNXRU05ZmVmcDcv?=
 =?utf-8?B?YisveGFVMENrRnhuQWpJMTNVS09WZHYrVnBtZ1JtbGYxN3JtK0JYOHpZYitK?=
 =?utf-8?B?aEJJVUtRUEN2NWN0dDRkNkFCeTNJMzloTDhnODZFOGtkQkk2bmMrMDVKZmtV?=
 =?utf-8?B?UHQrTFNQRlgrZUsyd0lDWU1TcTBrWEZSaDR2NHgvL2VYQzQ3UVFrZlVWdlR2?=
 =?utf-8?B?d2VhVEhBNmJ3UFpXZ2Y5NlhIYXNaK3ZVQWIwM0Nrd2laeGFqdC9uaWxOd0ZO?=
 =?utf-8?B?bmJLaEdMbGYvSm9GOUczdzZURmRrTzFwWWUvS29SRVZNcExoMVJHVHR0aE9j?=
 =?utf-8?B?dkRBM3BJaGsxd1VvREVqVk94OUthb0hEdjF4TjlHRUF1dUZPNi84Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F7C185CD6CB0E4CAC3D77E8E2A1A167@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sojw0n5J7MvTHQ6k584yLndVr6x78DMU86/vQ2usqYFY7A3icMP3oQDUm/QQRH0OYJDXfsRBo4ZWx+cBVMflgZLrp7PJyBg06JKR6tZqyaELaxurcxPLFbP5J48BAJqyc7eNmVSP46JnIM52mFikYLA0q6eQzw9NHssM/lB1/lHsObp30jaV7BZUyAjLwWl/U2o9B8bsNAcQrseU3Xa03cq815gY6k1KHVswWfnBfFrshOhROeMRtyW2pc+fmw/XW37rbyLdFfBgtkIJGcHYRrWWEaDW+0GLwmlcGM8XYh69MMyqejb3mVp2TnInocpyJnhhWJdPYcVSA2Fxpwoedw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffeda07e-db4d-4ee3-de39-08de9b599197
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:43:32.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cd75S7hn3rQW22wVJWPNeUUTkKv3C9z9xDeO1h1eRF5kAm76+r7cbO2168xGQCLPn3MKwhaIeCj3dJUQQVHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE2OjU2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBVbmNvbmRpdGlvbmFsbHkgcmV0dXJuICVmYWxzZSBmb3IgaXNfNjRfYml0X2h5cGVy
Y2FsbCgpIG9uIDMyLWJpdCBrZXJuZWxzDQo+IHRvIGd1YXJkIGFnYWluc3QgaW5jb3JyZWN0bHkg
c2V0dGluZyBndWVzdF9zdGF0ZV9wcm90ZWN0ZWQsIGFuZCBiZWNhdXNlDQo+IGluIGEgKHZlcnkp
IGh5cG90aGV0aWNhbCB3b3JsZCB3aGVyZSAzMi1iaXQgS1ZNIHN1cHBvcnRzIHByb3RlY3RlZCBn
dWVzdHMsDQo+IGFzc3VtaW5nIGEgaHlwZXJjYWxsIHdhcyBtYWRlIGluIDY0LWJpdCBtb2RlIGlz
IGZsYXQgb3V0IHdyb25nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNv
biA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0K
