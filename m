Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79643AEF2D
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483578; cv=fail; b=Y6IfcTmPwbTFWwr5m0J/DsFzBcmirP2Z2i5TvlhiUKtJ9fH8XjhXrsNHP6J9Uq8inECALVKCAI4ysbwqsYGRMpoao2nWMmj2QI4qpKSTJF9TpdEhlPqV0LQcqxi5iXu32qi6xZtH5u7JaxOoyILnkHvWPcs8VEY8+DV/pBNmB1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483578; c=relaxed/simple;
	bh=5lyAGkPTDQrnPKYBikKHw/x40VeB8o2Yugg1zhWECYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpOE/9LR2I+uI+i+ETvBuL/f2vbaexQceQnov12KryVvvhqhcNfeWovF4a+sC6N7iF4dAlj1z1Hvz+j7dTNFAGCR0Yi6iRhVYS/HFkNofa//uhkj4tvC5vH0yxU5hHef2o7DBW7VJO+AZDD48PQO9Gm6fB7RYEmF+4TbGP3YZyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7VSJkHz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7VSJkHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791483577; x=1823019577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5lyAGkPTDQrnPKYBikKHw/x40VeB8o2Yugg1zhWECYk=;
  b=S7VSJkHzFCLOyAImwMWs2Ye+TloS/DHzIxUsv3FAeYKV9iB4XAwi7dPq
   gwqmgiMXLDx5NfJB94lfB5XE1HrJH6NeQoR0XzKRQm8Kku233BXVP8Of+
   g0h/0J0rh2jRaStRrQBUfFfC1hSZv5Ej4m1at8Tb3Wd54prN3Ak4vExSV
   SEbH5r+xwCRee1ltwKEMs7TtnaM1zqovvf2F4EVBwyPcgB/5N0WlUe750
   go1Ut2dOr3ZxJZQz1oA3i3NC8+uG45VMRNUv4zza6hGtew6Dzgba6FK2E
   S4LIhlzgEf5FBF0Z/IclegQ0DjdgUpdSD31l+XU5TD8IeM23PB+crTZ6u
   g==;
X-CSE-ConnectionGUID: u9RorJIVSAeN1DkV6sspeQ==
X-CSE-MsgGUID: u9nUYxkGQ4+hl7zlAf32Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="303085"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="303085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 11:19:37 -0700
X-CSE-ConnectionGUID: fgKc/dcGTMeSFSrAH+Mj/w==
X-CSE-MsgGUID: HKNQRQenTZO5QIFfJQMguQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="427570"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 11:19:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:19:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 11:19:36 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1TbvVafn4CM5rKMfJjWYUXd0BBqV4+P3JaUlxi+qWDrpG2htY//2DsiME9rm0x2uRFVZ8EkxOdtTUloekodV6gsXt9/UzdfWxHl1W3EApmJgN4hcAoO5NpDpXBFGnkhFdyH8WRLRz1/YLyPaKHCQl7xT1rHpN4wOnrpb/rksFQRIZ2wg07xWgyYwWBGR0Hx+t7oPSyuxNdk4aN2q7k4nfFm+I/L8H3F9/mpBYwk4i1ItwDULp0Vsi0ceIR7rnCeoPMDXSvOClYiMQgjpm8hIDx6201/haPza1lqB5j4/iPMCLtcl7bNfQUi0YqApwwN5DyJROJVNVviC4fgEP6oyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lyAGkPTDQrnPKYBikKHw/x40VeB8o2Yugg1zhWECYk=;
 b=wgi6oklFFxsqRk3gLSTsVNkof49GTXB2hZVyt7pqq3XnDa6KaponuvQ9Tu7wUgQINQgexqqwXREm6QSHAQn2GRQjA8OW47rv2oQRNiS1ZypmZC8hBftqG15lOkDA59N2JqLs8uHTyLRpvTVyurdAWQCXVBTzTL/MMd3cBcL0PYjZHCGoiZwCWAGOFd0FCoQqTWYLsZYJeXUDhmlVrz68cN/WiBbLm5AEtpqqLywuY+g74SRzA43rsbZ0g7TRBh0aNrkIqQYagQW7Yh0QP8WXOMgZS94Z16jIaCx/cZiijJ1EnnetFHg76+QlOJLkGFswJV4gTP+XUG0xvB7NYwHdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 18:19:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 18:19:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory for
 the extensions
Thread-Topic: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Thread-Index: AQHdVPF3BQcMH2y8f0ylbGGnNqMG6bbz+TsA
Date: Thu, 8 Oct 2026 18:19:31 +0000
Message-ID: <8f3e9d41b473d597ff538c5a70c49f02fbaaf317.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
	 <20261005175713.8B8701F00893@smtp.kernel.org>
	 <ascck27BOXu2QZPR@yilunxu-OptiPlex-7050>
In-Reply-To: <ascck27BOXu2QZPR@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA0PR11MB7694:EE_
x-ms-office365-filtering-correlation-id: 381bc1b5-064c-4793-3cf2-08df2568b2b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info: rd6byf3cVArW3tcpyqjoVF/XDnze8stauR2D9HgVQ1aeFeEj8jWp04ZItbwIXbQ1ZuE7U3112961sJzwXkpM/fBtWZWNgGOAywaRN+Vus/7lO3/AXMg+CQ77rR7KPUWOchE3XBgbWudtuagc2eKwoFZakRma3JOtESWq4yYzNXZYK+Rud5+pMQuw4SOSRNq4r3iI0hQO4i8cM7LCGHroq8qIqfVGWOV81nb7cd2dYYcBAwNsC01d4K8BwC88ePIkLLWq/t76fgkZlJt/j1wi14M9EO9NNKU5gtDaM2sbzCo2pyKxpr9GnF/6yEelNdcKwQboD0WbvoGOveyyxDRRsTIFK6aGKbm81fZREvmU1uCYCsHJni7KQtVreMmN/kS837FwnuY6AN7qE6hy9rrAkfAg7d8X6IyrUc4ouDqkMKSc7BGN9kavfhyxOMzd6eg4XK/gLH/d8yC0gS1zrPkEjl5P91Un/n/Q3Bv4QgIgIoODXB0jd3sjUddhJa2/3nWvlGiM8EL2M4aa12ho7kGkA2kmoq0d87FGwTmVcNfxlYxYBkjklLzLjuT2aWfofnA9K85dYU7WgZLh64e+a3L5n8b5pEkwJNilOiRkSUh6GupNFKJuXh4gYr8EzzjX9CVZZ9PESteT/PP1VC4ByJ6Nk5o4QszTvt3AjMzb09Ikl+eB/ToBMuzT8CcpPWsMpsjWBexG/ZtpHwenO6ooBL5kOMWqkY3UtDh6jQbxy2WQ+Kg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0xuSytneUZLUVRNYnY3cURsQ2NoUnBTcXhZeHE5TTBoME16Z1FaY0dUQk9t?=
 =?utf-8?B?TUxTZzFoOVRmMzhoRE1pT2c5Z0VMY2tZMURJL1lkNytHbE44UVNINGRoMiti?=
 =?utf-8?B?N3MzVDRJMEhESE51Nm83Nkd6NVdsZVRQYWJYOTVrNGR2OVR3bVovRmZRKytw?=
 =?utf-8?B?bGFZRnU0QXlOUm1iQW9Ga2dNdEp1YjQzL0xHSXhGYVAwS1Z0SDVyamtSR3hD?=
 =?utf-8?B?MlZKSkNDdHdwYjRSbFVIOFhDbGc3eitjOVN6KzlwK0draUhNcFBJb1VRWW92?=
 =?utf-8?B?UjZSOVRXT3p0M3FPZDVxdTVJWXErUjhiMzAySmllREZOVUE1KzNsOGtWdmdJ?=
 =?utf-8?B?c0pJT2N3WUpBaHdXR1FlaTRDSjlwd0ltWmU4SmhZUko5bHhtSXllSTN5WGhM?=
 =?utf-8?B?QnZEVExTcWhkbG5VOFNSeENpV0VQL3lLOEFMdTVGcFZMRXVWS3cwMG9VYVRB?=
 =?utf-8?B?cWxtd2ZTM1dNK3l4VHZkODZIRldMblF5T0NpZDNtcXpZU2JWVUdKd2o5UW01?=
 =?utf-8?B?V2RXNE4rdEEyVk12dlNLVzJkeXVHdEtDRGwvREI1NTJuNjg2UkxXT3lSNXZt?=
 =?utf-8?B?UHRnelcrdXpvR01MOFJrQStIMFVzcnVYdCtvOTRXeU1oY2tmc25nQ29INko5?=
 =?utf-8?B?ajZOZmc5UjhZZ0hieFJyaDRKR0dPU2ZzdGJ0YmhKK09JbWJYVEtGeG9FTmFO?=
 =?utf-8?B?dXZCTzdKT2Z3dmlXNGdLTTVja0h0SDM5ZVVTQ01iSENXSzhmd3RRVEhKNXUw?=
 =?utf-8?B?M0xVS1N1VUVhd3JWcFBvbFZBUG85OVJxT1lIS1p3Q0dpSHA3RUhXT1U3RGhu?=
 =?utf-8?B?WUlEVzdXWVZlTWdMZDcwMzVZMGxybWZPbWM4dWlQT3RxRGUrcTJ0L21uQXVl?=
 =?utf-8?B?dWYrdktzRDlTdUFkdng1TVBiMjdtL01uMzJLWlRuNnE0YkNaVjkrUVZzWXZB?=
 =?utf-8?B?Q1lySjg0TWk1cmFhbHVWVHVNeGoycG4rK0Q3bG9QYzAvZ0xCbU5HOHdxRkVy?=
 =?utf-8?B?djVqNWNEQzVhKy9mTVFhWlV6NUNucWZKQmdjZi9GNmpHKzNZcU9TQlB3TGRo?=
 =?utf-8?B?OCtNMTVEVW9peW4xck9RVVIxeXA2QWk3cDNoVGE5R3Q0b3BDZ09RWU5XaFM2?=
 =?utf-8?B?blpGTzd2cWc5Z3BhYi9LYmk5M2dzdGxvLzU5Q2dyVmZ5bk51QjhrNDhMb3pm?=
 =?utf-8?B?emVHRnBJa002T3hET0pQTzR4N1lmbVBQVTN6UjRrTU96QU1iR1E5UVAxelMv?=
 =?utf-8?B?dzBTNnBwb3B1am92YW9GYUFpRHpvVnZhYW8yaUgwUlREQjlEaHg5ZnBhZzhu?=
 =?utf-8?B?VlV1SHNVcndhNzJ5UmU1V1ViTitIcTZoVWdTVXo2NmhXTVY0VmU0dHlXQzhH?=
 =?utf-8?B?VksyTXJMdWw4ejlmVUZUOXROdnVObURTK0NEcVozeXJIQVZWYUdyRVQyOTQw?=
 =?utf-8?B?dkZkbmVob1BXenJycDhvZGlJUEdRdU4wd2o0MWt6bXUxcHdFSjR4ZUVlcndv?=
 =?utf-8?B?RWhoV2tDSGdCdzNtWUNvYzVIOGxvcEY0UXJpeHNoMW1YNmZ1MXhxaGpBaldQ?=
 =?utf-8?B?TFhpR1Z2c1ZTUjFVWnpPMVJLQUFRWFh6R2wrRjU0bEthTlNSTzRKMFd2cFNN?=
 =?utf-8?B?bUVQT3J4ZHNqWVRYakUvYjZ0WFRHK3dIa3dpMW5EWWhpSmhpYnZiUWZTV1o0?=
 =?utf-8?B?QWloS0s5dHhoWTdoVXpNcjdJb092UDJFNWNScnVqek04NlZSd0h0UXA1em44?=
 =?utf-8?B?N2Y3SVF2UVVpcndYYmFCY2dMM1ljWForeExEQzJ2eUhCSnJhUU5HQkNXSE5C?=
 =?utf-8?B?eE1oc1Y2RVlwMmQwcEFVd1UyYU1zdVRZZitLdVltQ3FBQkQvZXB3M1NranVt?=
 =?utf-8?B?bG1RUDQzemtsUXBESVQvYld0Nk8xblpZZEV5bExHSytGWjdoeUFxOFN4dExx?=
 =?utf-8?B?bFNhdFpkK0tTMFJiZEVYZGR3Q21Qd2pqVXBLam80TzROT00wM0s1YjIxb2Z3?=
 =?utf-8?B?enZoS3VZOFY3cFZmcmxsZDhxc1NRTGhhcG16RVdkUFF3dmdjSldHc0FBeHN6?=
 =?utf-8?B?bWIyemdwRjNzZGJaWGFzbGhGVlVqSExIdXhsbVlLRGkxc2x5OVRtYTMrc2R5?=
 =?utf-8?B?WmI4d0l1VDdpcWpaYlF0R1I2STJhMXFkTjBwb2VlMnYvQ3lHYjJGOEdPQ0F4?=
 =?utf-8?B?RHdvRjRZS09ha2Y2VVFwWVNvYXVRNkZqLzRZWmZsM294UXFrekczak1ELzRE?=
 =?utf-8?B?K3lLaldWL2FnYzYvUVJOQ1VFRHRBaUJ4d2hoS29CdSs3WmxuZlVnVzI1Ritz?=
 =?utf-8?B?MjRnRlM4U0xoak9BcGw0d1M4bVpqbC9WT0dCWU00UkYzVnRUcGtqWXdkWmNl?=
 =?utf-8?Q?UBV4erNZPzI998jo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724EAA4B6899D145BB213DB58E8630EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dFBCOCEyQlzBJ4vkUTyDzBrDhFR88ukL3nrM83filsWroWL0BF9/goXzefIwYnMrmNVA+d6SqbVSyEojogOVbc4SlaWYK20MX0agIETfa2Mu5eA3Nj/YqEpaPZ1pr0Mp/uyVSI1c07XaU61qs4wxn7t2rJ4ipeSF+ukH/I8pPMkPMlNqDcStn8zBg3/V/9+5of0Yu7Br+i8E8UNfG0a4/neio8/QlCJJ5Vl8a/m3x2hCl94Bx1KuVFQJ3D5IndGJ5+XZk6JdPHY4vmij262o3k3r92NIAVUXqgPhhyTglIvsXQYbYrPT66xSWLfyk7aB6qa3NYiUz72WUyv5s3R8pQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381bc1b5-064c-4793-3cf2-08df2568b2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 18:19:31.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4psKGZE4SyuLpZBkfjgqDEYmbjWC9nWKoeHuY/h3na1LkSQ10lA/OGyx9+7B3DkPqooOKoYxQ2m9EtbbznhtxpHwl/7WVJ2G9n7R0yg7NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTA4IGF0IDEyOjMxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gPiBT
aW5jZSA1MTEgb3V0IG9mIDUxMiBwYWdlcyBpbiBlYWNoIDJNQiBibG9jayB3aWxsIGZpbmQgdGhl
IGVudHJ5IGFscmVhZHkNCj4gPiBwcmVzZW50LCB0aGUgbmV3bHkgYWxsb2NhdGVkIHBhZ2VzIGFy
ZSBpbW1lZGlhdGVseSBmcmVlZC4gRm9yIHRlbnMgb2YNCj4gPiBtZWdhYnl0ZXMgb2YgZXh0ZW5z
aW9ucywgdGhpcyByZXN1bHRzIGluIHRob3VzYW5kcyBvZiB1bm5lY2Vzc2FyeQ0KPiA+IGFsbG9j
YXRpb25zDQo+ID4gYW5kIGZyZWVzLiBGdXJ0aGVybW9yZSwgZnJlZV9wYW10X2FycmF5KCkgcGVy
Zm9ybXMgZXhwZW5zaXZlIG1lbW9yeSByZXNldHMsDQo+ID4gbGVhZGluZyB0byB1bm5lY2Vzc2Fy
eSBib290IGRlbGF5cy4NCj4gPiANCj4gPiBDb3VsZCBhIHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSBi
ZSBhbGxvY2F0ZWQgbG9jYWxseSBpbiB0ZHhfZXh0X21lbV9zZXR1cCgpDQo+ID4gYW5kDQo+ID4g
cGFzc2VkIGludG8gdGR4X3BhbXRfZ2V0KCkgdG8gYXZvaWQgdGhpcyB0aHJhc2hpbmc/DQo+IA0K
PiB0ZHhfcGFtdF9jYWNoZSBpcyBmb3IgY2FzZXMgd2hlcmUgbWVtb3J5IGFsbG9jYXRpb24gaXMg
bm90IHBvc3NpYmxlIHdoZW4NCj4gYWRkaW5nIERQQU1ULiBJIGRvbid0IHRoaW5rIGl0J3MgZ29v
ZCB0byB1c2UgdGR4X3BhbXRfY2FjaGUgaW4gbm9ybWFsDQo+IGNhc2VzLg0KDQpTaW5jZSB3ZSBh
cmUgd29ycnlpbmcgYWJvdXQgZnJhZ21lbnRlZCBsb25nIHRlcm0gYWxsb2NhdGlvbiBvZiB0aGUg
YWN0dWFsIHBhZ2VzDQpvZiB0aGlzIG1lbW9yeSwgaXQgZG9lcyBzZWVtIHZhbGlkIHRvIHdvcnJ5
IGFib3V0IHRoZSBQQU1UIG1lbW9yeSBmb3IgdGhlIHNhbWUNCnJlYXNvbi4gQnV0IGdpdmVuIHRo
ZSBwcm9ibGVtIGlzIDEvNTEyIG9mIHRoZSBvdGhlciBvbmUuIExldCdzIGlnbm9yZSBpdCBmb3IN
Cm5vdy4NCg0KRm9yIHRoZSBleGNlc3MgYWxsb2MvZnJlZSwgeWVhLCBsZXRzIGxlYXZlIGl0IGZv
ciBmdXR1cmUgb3B0aW1pemF0aW9uLiBXZSBhcmUNCmFscmVhZHkgZG9pbmcgc29tZSBvcHRpbWl6
YXRpb24gYWhlYWQgb2YgdGltZSB3aXRoIHRoZSBmdWxsIHBhZ2UgYXJyYXkNCmltcGxlbWVudGF0
aW9uLg0K
