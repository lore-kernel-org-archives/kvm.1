Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792721729;
	b=VJUdX1zmK/C4OyMizHgVLB4YDnit+ptkiyTuhF0kL86lFCgg5gIHs0XP1BiYcv+P7ubT
	 MnYMADcd3GXv96xyDxELTagETRbCwvDF6ZOJgw2ovSJWZvDvGMD21vVjTb02gaUmiTwN9
	 QI8qplJ4jUJQPKSFyn8ZyEnc/KAoJZAxbU/RDHKcDo01CaPV5n6qVKBmezSDSmpKBFBb+
	 eJuZLZgheHmPgaPqrvuSuwEsOM18g/WyFkFiaqFgwu2p0uvL//q6NiyDr7far53w++s85
	 qi3As9DTi3g8fexDeVSpOx33opMrAPcFtuO6YQMWxUF8m/hRySAfNRrdDjO1UilQwOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721729;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=HvYuOCF3NcVq0FAlMCPuL082ZVKX32CRNKxK6tDLfn8=;
	b=rVGH1fur65kGYUcg3F5N2ms0s6pjl8cD2TMeDZYqlAl0rFisX7+ZIxeIXEGwbcgL31ZF
	 nuZlkf4H1pfTAMeeY0acW9tnmFcbx1xRmsMFrm1FgrR2nPSUfuEwKluOvoqwdif7N/41G
	 3AvMwguSo4XkCy1qYyE0pDKDu8eQ/yzBuWasCeLIJnNbFdEEYgSgqSOoOPNgpNhfNmLp/
	 KLO1VEwra+ydTpv/6DJr8Fwl42HEj9SIobATpw1arFgVz+/u4rbaRVxNPmYtewex+YyW4
	 U8ICsEam0wSGlIwa6xD7AS9Y4t16Bp+s/QYGjw26B8YhthCQl1EMyIFFVKkEtVt4dmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g4o66dRd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7E606A31E;
	Fri, 23 Oct 2026 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01E7E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g4o66dRd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792721729; x=1824257729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HvYuOCF3NcVq0FAlMCPuL082ZVKX32CRNKxK6tDLfn8=;
  b=g4o66dRd6hVPhGBH6Jdu3Bn3/S+/XaAnolfZ85wx1XaS/Km9KfEKXozk
   9dkw+dN/cvHug/EOIPdsdZG6sXjialC/Xf/nc5gJ2H4GHHyZqIb7Ksv7J
   Iak7DCX6mK56vYDmKF6U1DFWI2NVWLBOMxCAAdU8SQIdGbt+rAuqapV5t
   cQl0Zyu5NHaxE2TSeVAuYWszHzX63HxGRtGqXK+oeehTsR3M8Q6uP2KwQ
   M1SI8MnSwIJ/esprO2O5ba8+AN0tJrI0BDe45jDVJfLLr14GyJhuHoOgd
   kBzYZPjepgFAp1W9KdYqfSxV3Hjvkh1kcTi4Wwyp/1phK9c3is5qspti6
   A==;
X-CSE-ConnectionGUID: YTQxb04UTV6bONQO5AIdLQ==
X-CSE-MsgGUID: imNIEbLyRSCtmEq2vROSCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1488578"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1488578"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:15:28 -0700
X-CSE-ConnectionGUID: qRzop23BTdaY45jGYeVklw==
X-CSE-MsgGUID: D7e8pNfuR+Wm7G8I2phSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3558089"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:15:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:15:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:15:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:15:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYI8t6hOBQsy7cZEo66dHH8PKknHlt0htQ1e9klow5FrhvF9W+qloVOpf5LIkfFLOETB5RCK4jyLxokbrRDLrzjUJ6nhRq7gLRYh3xqTC4DKXXkPg+rH7o15uM5HVc5c11H4x8CZKEqDMeU9PECzqory8LgmBx8W6Cn6IPdeLxr+tRBr7ggvPKw45c2BTgDkkBfu5gUsWduLuedxc/VhDqk0N4oOtK8aXdnuaW08tvDcSs31ug1znLcBfLQlezx260Ic6yHn2guK9+FYEgZQl5Amm85VlsP9D16KtGPPX/M0ZY1ruEE1RrqCFMaueWizrm6/N2mz/+O630CZP4bJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvYuOCF3NcVq0FAlMCPuL082ZVKX32CRNKxK6tDLfn8=;
 b=BnXsZ+vRX0o2oc6e0sMLecV4YCWq/JcygLso1WxYgG+IyS3Uw/6GZxsa6gZLtZJXhStJoM4BEManfLjSKmoWkEuAJhg73akJOJtuXkioylSoErMyRkS/X/S4xqniiTZT5OtljgJ0OC6kPPx+YZ8x/gwUGUVsD4LJN5RtAUA6SBLN6ETyoVgCPma6RTiMoJKKd3MpiXyc1sdbz+ZQyjLCA5/jQA3YALh/N4UKXy5+pM3hMRxQikWp2I3yaLhJPj7i3yrTsGRpdsEHgGwBMDvMdo2bK4AmJxxCJOwWDhKvfZXsgbLx2jW0+PdYH8jlRflCXTUXGvAIbrYVkKPWufFslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS7PR11MB6223.namprd11.prod.outlook.com
 (2603:10b6:8:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 23 Oct
 2026 02:15:22 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:15:22 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kas@kernel.org" <kas@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reAgAVHxQCABHwBAIAAldoAgACPGoCAAIb6gIAAIHiAgAACBACAAADBAIAAAeOAgAAAuoA=
Date: Fri, 23 Oct 2026 02:15:22 +0000
Message-ID: <097e9bcf67b1bcdfd6d2b8d34bd0793a773d6e32.camel@intel.com>
References: <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
	 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
	 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
	 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
	 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
	 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
	 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
	 <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
	 <atrAZhEINeaieBxN@yzhao56-desk.sh.intel.com>
	 <97ad9dac09d945ab5b76ec8596a76f8fdf2bb6b6.camel@intel.com>
	 <atrCnSpy8UTTVw6Y@yzhao56-desk.sh.intel.com>
In-Reply-To: <atrCnSpy8UTTVw6Y@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 885dd505-9f96-4e46-7d8e-08df30ab7e06
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|38070700021|11063799006|261022105027099003|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WWzxxCvzArvQrH4+8SjzNnVzTHko0if4/y2WURiWgQ6NdFYjef0swaDe30mgv9cRHW34CBVlsQ6dHOeOIBgwvxL8xUskeU48KxtbKyPViqL/6ubRk4bEZze6p7HAKfePt6t8lboDt4rtcul5nCSf/WpCcJHJPN+1BDIW2bZSPgGsvEOZ/MrC0gbl7jH69dCv3lH8Ly/YUAjWBfVES42mG8XZowMIvRJvnt+L1E183+3bYEoesUgm7DTpYATC9UkreX8TRkS1moxfNlnXjj88DZDg2lq/cDQoMhHvSsm94wDSVB2HSXkcp69P0xlq5O/sJxHnLmonCvX6KUVl9Dl3X1+o3AYwQtODWJw3Sg2cAwdOOWTSMhB3P64dlRdr5N4tIBsBCy+TkxpQwWp4GRT/AP2LimClrHOl0ncdKR7ehNArSKK2pstN+Nhx6A+fOilNI1wrMiIVXadGSBs1VoGjtBsshoaXXNEsdfvqcdoHYkn8fqCO+ysz1BoLQsfA2bND4BvEd7YChBiLDJmGGSgxwssTtWZi4Cc2Kxpfzg8tiwagr0zAMEnvA4Du0aVlNlLN17JH3bFHv/qYXFkJc0V31FtRHpxEG+9zobY3QPmdva9B64Ka8fXjWN5Z4tFHmtXdBXiDqRJVhbpSLInvbmUCQT5YFzvyl4GdLFIGAs+aBQXY6fHm1GTd9jYWFlMWrLiNiZFCuGFva42U6+63H/r4Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(38070700021)(11063799006)(261022105027099003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti9VQ2dmNDRTSU9nNTZpLzFHUytVWGNFem8vR0xnOCt2ejVHQS9TWERQbGQ0?=
 =?utf-8?B?OGg0M2R2RktteXIzTEtHb0ExUkd6bjJtTlhwTHY2V0VkR2ZlYmZ3R0s3VTNj?=
 =?utf-8?B?Ry8wSDkvcU11bDlJMXhmSmJVT0FyQUxOVmNxK1NtRk9hWDdSd2NTWllkam9n?=
 =?utf-8?B?OUh4cW40ZHh1eWc5Rnc2ZFFxam4xZUg0eWU5SmhhaHZ5eW5LTnlHMVkzZnBy?=
 =?utf-8?B?Q0FzQkhCMUxOZjFRRmpMb0FEQTZJQXoyc1YzTE5VdzNndTNzQ0NuMFl4NUph?=
 =?utf-8?B?SDJIbHZxOE5Cb3c5U0FPaW9hZDBONEpjRWhMakhpSkJuS2RmemtyWTQwcmgv?=
 =?utf-8?B?QzFzYVN1SWxLa1YwZ0x3MDl4SG04ZXlaL0lzeGxLbHY3ZVVPVURJU3Jtb0px?=
 =?utf-8?B?a0RZZjhTNFYwQlJmdEl6S2NVTTdtSzQvdzN4aG82RmR6SUFCa0VVTHdyQnZ2?=
 =?utf-8?B?ZnVDeUJqUEpBdjE5bGtMai83dlB6eWZSSlVUb3IrMVNmZnEvQ1BTVGM2Y2JP?=
 =?utf-8?B?N1FLWFRFb0lVMEpWU2pXN0t1QVBXMzkxN0xaOHU2TU85cjE1S0VacGd1Qkpp?=
 =?utf-8?B?NmxSVVpuVlVtWVNsZXl3NVBPRTNRNjU1YnhYUTBRTFh5ckNmVmcvY0sxcnp2?=
 =?utf-8?B?Q2k3QitramNxK1dxK1VYQXkzMGFxc2txSUZzQWpGeFRNdWRCb2xJQ3B1YUJj?=
 =?utf-8?B?alYxc0xWcjdieDdrckM4QkFialdmUGo5YWUyY3F4RU5za2Z6ZUVkdEgvR1BS?=
 =?utf-8?B?YVBUNW02clRWQTdXTnY5YWlCYzdNUWlPSUdvdVU1anhCV2NZVTc1WDBzN3M5?=
 =?utf-8?B?S1oyd1h1eVVjaEwrVjhHbm9VbFZ5ZzdPL3lJZkl1RHd6QW1aOTUxNkIvMUJP?=
 =?utf-8?B?eTdIU29uRlpJRHJuYkdrR3ZGM0FKZHJuVzhRTlF5cWFFMEF6WFhLUXZxWmdG?=
 =?utf-8?B?WldUOHJiTEJwRkxtVzZlSE1QVGNsWTU4YUV2Y2FsMGMxMmxUeFBaSmJJK3Qw?=
 =?utf-8?B?K05oNkExWVdqT1dIT2lRbW5sN0E1c0FqaEMvVWFZRGxEbmJiWGdVYkEvNk9H?=
 =?utf-8?B?YUxWS3VNL2lUN0t0SGdXQk1ONnczdnV0bUxMMmdHakg4ekNZaDhHOTFyR1U4?=
 =?utf-8?B?ZmxGT2hrV093NTRYbGU5bTV3ODJ5MkRaN1RwOHA0Wm00Z3N4ZEExOFNjUGYx?=
 =?utf-8?B?a2VHa1p5ZFlWQVpRN2hUU05SZmhXdnJJNVdxU1NkQUhydXdTQWZQZ05kUkJG?=
 =?utf-8?B?K3NUeHZzV0pHUHBuWTkzVFppL0xWamZ1NmxBNUFjRWVxSW5ZamZIOVNNaVZZ?=
 =?utf-8?B?ZUh3U1h6cDh1RjZiV3NUa3dyYjFoUzlaeE1TbGtWc3owdlNZajEwUkhXS2FX?=
 =?utf-8?B?eHR2aUh5Uk80ZFIzZ3hsVnNwclJXVjFJVVJaWmFlVURSNDFVNmo5MEpTTGQ1?=
 =?utf-8?B?NEx1TGtSaU9USVJLQUo0cDVXeUZPT3AxbjJpQ0hmeWpTVVBVK0Evem9seWNW?=
 =?utf-8?B?aHMzZmhWYW5wOWxVUnJMZUxaYXNKWlZKVkVZTm1IUlZCc2JoZWlaWGJ0MnhI?=
 =?utf-8?B?V0Qyc3JncmpHeG5xVEp6czdLU29sa2NJSi8wSXdxdzBkeG8rV0JtaUVtTGNC?=
 =?utf-8?B?ZjVBRmJoZXlLOUhyREVkb2VRa04vMzhoamhFUlBjS29CZTVJOEg0Zkg3Si9D?=
 =?utf-8?B?NWV2VFNoeExtWkdOeXNXQWVCYTFjMmxFTTUwSmYwNmlLWkhMVWVzNjJJTm9i?=
 =?utf-8?B?bkNKbFVGQnZZYlR3dnVTbndtcFVnODl2TUoxM0ErZVFOYVJ0K2pYaEVrWVoz?=
 =?utf-8?B?STJrRWEvWFF0eGw3RUxTNW52Y3BSVEhKQlhGTXY5OS92NVRUMmMwRnAvN2pZ?=
 =?utf-8?B?YlVPaTRDOVdOQXI3OXNjWnBKUS85WGhreEdvSzg5bU9PR2RVR083T0NsUmls?=
 =?utf-8?B?by9pZ3V0N1ZnVEx6VVVReXR3ajlSRWZWeXlPbjdHMllwcm1WSnd1b2RCWERl?=
 =?utf-8?B?c0lVbFF5UEhTaHNRbzJRV2NYYW8vdWxvaURldzJzRnp1ZUpTU2lacUNDelpo?=
 =?utf-8?B?R2FCRXVuK24xM3plL3hQeVR3Smd6NXRoYzl3SEZkRG1lR21IVG5BVVpubVpF?=
 =?utf-8?B?OVRzNG0xZmN6T0dOL1dQY054c0tFV1J5dStibW52SE41aHAzbmxlK2l0cDNL?=
 =?utf-8?B?azJDVkdEQWtCbG1OOHRrOCtnMDBucUFWNXg0QXdrNjJ4cFcxNDVyTXNtQlds?=
 =?utf-8?B?VjQyVHQyTXNndlptM3BRcW1kMzBKZmcxM0RXMDZQdVJpck1QTFRxb2RIUTZt?=
 =?utf-8?B?bTVqRTc0VXhKSGxUVVcvQlg1VzJ2N2JvbXV4SmdjVDNFeU5sRFRlR0xTcjA0?=
 =?utf-8?Q?TtHB/4nRKJBkL7f8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6616422770BDD64AA60607DB0A358FFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F5cJQscyDfzi1tbIa9Rs0VFnBkAo7yMWHm4TWJrKbohU4EN5yXgHxD59YKltCk6kXmVMMm3wG8SWxptxWlVbmAykiyVQRSAI1NAJjdZ0cgbwUAf3FksVXjbYbWVPWaIqDEvwvEtwnIHnsMf1QWCDVkQKMq59D4zTEqqTrYMAOy2OIf71ctTk4luO3tRwcSMsLBm9Fu7uYj6VlM2FC7573GM24gKw2Gom3e0tmK9Dtz8H5hnyCLYWCVbK7MUj3UabHZQXa0WkrAxBEJFeIk3CfahIg26PV66b/nx87csDVBAFuHMoILwmpeyZQW3jhO33v/ATfMwwcbOalchLbDrn9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885dd505-9f96-4e46-7d8e-08df30ab7e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:15:22.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lIZPzFXNaPVdPv2XnjQllnIlWIdsueArI1sJDZcAVcSr21/Jj54ykBP6aOBENjMD6u2QqcJhJE7bCwp+8vfcCiVbqTCgmZvdFwxGbvVS5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEwOjEyICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gwqAg
LyoNCj4gwqDCoCAqIE9ubHkgb25lIERQQU1UIHBhZ2UgcGFpciBpcyBuZWVkZWQgcGVyIDJNQiBh
bGlnbmVkIHJlZ2lvbi4NCj4gwqDCoCAqICsxIHBhaXIgdG8gYWNjb3VudCBmb3IgbWFwcGluZyBh
IG5ldyA0S0IgZ3Vlc3QgcGFnZSBvciBzcGxpdHRpbmcgYQ0KPiDCoMKgICogMk1CIGd1ZXN0IHBh
Z2UgaW50byA1MTIgNEtCIHBhZ2VzLg0KPiDCoMKgICovDQoNCkxHVE0NCg==
