Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792720578;
	b=OPPJr0pYBfEBxzJ4bIYTr1j9ArSzPNTw/R3zWNIFT0Q/Gg1ZNXFDTKrw3Q5Z67eA4p9E
	 emXQ7446y9zKPdKruQh3MwzzmgOKxGM+PWqfH6Woi4kFXBNHqs0VRyg9OI6/MDgC5Tuyv
	 ZEIcaXcCcUUrjVzBBr4D0QnN7uPr2sTQPPQhEb0jYmU5wUZReSwGOtp1Fv1zWVPBpvQbr
	 ONCK8PWMVBRBpVSUlNWAYgyoHETahUE4bn3mLwSj2BRUoeU5w1+Q0vVjwETYm4oRVYAQF
	 +Mvgh8X9jSbCRn8Py9jqRz4ShB7FTeYN9G+opJ31+/lm8aNsFXDcqAG+vLwtkCwnQkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720578;
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
	bh=Mxvv/e36GhCMLrR0E8W6xLycOUsluSTYCK1Q7F4MvjE=;
	b=dBKsTdfANzP6AwPiEoslTIr+IPgIsnzWIbsIrVPHja5cIbDopmHyka/JKt6/VfiTzxwK
	 bybjtMxxcmWohdn6z4KUn8jrS8VbfILpJOU8PAtGyb/635YSpKfQbo/Hr6YmHKorkUy65
	 xbaQGWvmYFppnKQjN7bqK8OTiFfmsTEUYgU669j0MpP1fbnBVGoGZK22tPHn4uXk95bVL
	 XCwhqpaBoQYma52sQ9w3/fRgENE/aNNl1x1NGNA5n7AoQ58bYXSLZgwy4anxGTZ8pdNiw
	 66R4+825sbbO8qNzTl1N3RYBN9iYoUkj8CaRMJWjyQV0ArXpFX6Wc9fP33BI3rcElPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HHU0OqDb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE49606A31B;
	Fri, 23 Oct 2026 01:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE49606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HHU0OqDb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792720576; x=1824256576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mxvv/e36GhCMLrR0E8W6xLycOUsluSTYCK1Q7F4MvjE=;
  b=HHU0OqDbvw8a9bWlLdDUK4F8BcQOpLAKFhDfmNzrrs836BSnrbB3WJy/
   bDcIXlmqkH+zBtB6TR6SatxAxbeMIlzZ7lpmR7l0N5+crrpYLl6iz8txm
   pzct6uZF8G4Ep+/87yQ4X9CzzOK8Cph8cvLfR/Sit2tvfLO6zWViT0bro
   xRTAKaXY/UlxVfxIqqnDjPRkstesQfdYRwfoDTf259jUPZDlUXWtsn3J7
   rAwo2VdQnqrmfa7PBlyT3uyCISvs726NftzzxHBsp0Jrz0lIq7uFhExS6
   fd9qYZJhLe22dM057aZPXgohDAH4d4QMOwqa2e2tNnegJgcXHyWlrpAnh
   w==;
X-CSE-ConnectionGUID: A9K5puAcRzWazFl5nhYFHQ==
X-CSE-MsgGUID: iTyvzalLSYGa9bLBmJ6JVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1573453"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1573453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:56:15 -0700
X-CSE-ConnectionGUID: MXLhMD8mS1WtLqXe9f0nkw==
X-CSE-MsgGUID: OosphVCgTqepycDXTGAjCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3420426"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:56:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:56:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 18:56:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 18:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgQjRRKnSy8/Yf6Tn6VwyiSQrgxbPBz4xNX3/lCn5NFVNllqEBNNmCwVU+E9Luz8wiBOccDWNPpz9smw2L7GpFWH7muGg9RUTNYz/NPPFhkhMN9rI2rg0jJOHPkDfyOGYOJNMp0Eqlom/4riYM9QKb2mpg99g4vEAL8UPs2t2QL3e2QC8/fuZtV+33zdVGfTiR5ZW2IZQs8MnvF7u6a+EjFnmbqNSMAMz22C1DVpGuZoskfazx+UHvLQdmHZFURL8fqhU8YWkZe4k/Szc+O3lue0xSN6Dh1PlkS75sqJj8S88aoBYevHoOH0eWTRX5MRUgm+DhApTRGuuitEVSsuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxvv/e36GhCMLrR0E8W6xLycOUsluSTYCK1Q7F4MvjE=;
 b=bsHa7LyU7zpF8Nouq3W7ozrvDE3kasCJAcwmhi7kZr/IYP44A3zDDttjTPDHBgo7AofBepO1AvE4OPvCvXQn9ZWbwoAmbh05xZVpFS0GsDmgrCxYZa1FT2ccMVwIyaM9SLajgcsJhQgbSijjJCfNb81Zolf3kPMV3hXsmXJlwbf/88CZetq6FCw1SDHoPda38PQ1aI+uT5ToXJ0udgtwCB6rRnTKMXU+2UMnEUYvmHLHoPSoQg96hTsTGZuxzhGxhYJ0VgayywaL18JVVNnPU/eNFr/iZ71z1GBCP5MoECMe/wOJWiU2F3vYMhP6tDGwmyCy9ZY9jV1uRpA3tpBxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS4PPF69AE895C5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 01:56:06 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:56:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkAgAApaACAAhZUAIAA2vcAgAB1o4CAA+N3gIACbDEAgADZdgCAAKsxgIAA0reAgAVHxQCABHwBAIAAldoAgACPGoCAAIb6gIAAIHiA
Date: Fri, 23 Oct 2026 01:56:06 +0000
Message-ID: <29790651d7a5d8727f956985823c17e3dfbdcc24.camel@intel.com>
References: <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
	 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
	 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
	 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
	 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
	 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
	 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
	 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
	 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
	 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
	 <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
In-Reply-To: <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS4PPF69AE895C5:EE_
x-ms-office365-filtering-correlation-id: f8781966-0645-446d-f08d-08df30a8cd29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|261022105027099003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: toW3tK1JUDT56sXFU6iKUzzd/t4uJLJH+z0//AyP2f9ibsGaWFVgzTorlUBKPtMj6K2b6UPr8bsJYkunoOAZ85t6O7/dSsZ1WvWpLglz7j6SPzUBAVniSpfLEMomhocuYSf+JLo2EAt3UAgR1XmEcPGxQ6RtKqVaHZUBnVOfwfGyESoxOfaezVZTehImNp8h3IZDZOAw5hBqyk+AQ/W8vgcYmVQ87h6mQiSHVDObHd/O+GqK0gqhE89+jUBIzuyRUw+8e2tg5fJx1WC3nl03c7u5qmkJodSGas6fZRafjKsBEVCsafWHvvKlWr/v6VmPc22Lq3gISEx6GrZz07oS66SdC7rfeS6Iz9zUO7ArplxqbQOCaHg1ak2D4W9R4UOCuMp+9Ftg8+fk4KqT+xwgN6TbF7lRiAnPIGhuczqF0WvQDUrohNEnztTkBmNbg7jS3pKMuq7DmbKtFYijzFykXS6joZt7gj3YE50UOS8EYL3DNpjIuw98vojkJ7KH8nZaLXvUxHTSWW17DNBgyMjgsyOSV4acONc4JQQXFIrW6zXg+jNTN8rM52cesQr735yBfht+K1JU/OJgu8juxPiT0PEe44l10TKAE8NuOr8Fejijw32iy6a5NgaCcMdVhCSqa9OYa60/CuI3XxirUbpS1lrm0bxdm1phPSWoFnAgdvPZCVd0jFzjN2sNOaKqeGaFao/H3SmL3pNSslz5kkT5mnXu4/6QoIe6P+I6C0/Uwb4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(261022105027099003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGl1QzVBeEZXL1F3SDJNd09KZW52NGhOcDNkakZrTC9qZjgzZjVYY1UvTmF6?=
 =?utf-8?B?Y05SUnF3MTB3SG1pRFdRV1UxSlZ2NFdCa25yZjhxT3dud0NnZ1dVb1JZVnE0?=
 =?utf-8?B?U3ZxMDVuMDI0TUZTdklNb0lEV1kydGg1WnZ6dDkzbkdSWXh1eFNMR01xY0xn?=
 =?utf-8?B?MEZlc3hINGJPbENJdW9SQlBTU3MyTS9LQ0ZVMHQ2c0hnV29BSjRyZG9YYzZr?=
 =?utf-8?B?WXZxOTBEbVUrN1Y3SmtpQ1VHZ1Z4bHJWdm5DQ1ZFMGRZTHh0SlZxb1JUUFhX?=
 =?utf-8?B?UjlEYU5jOU5TbjhrNWJYUWNpU0dRRHlJbDNCd0kxYmFtWHpoY1VRSE1DOVNT?=
 =?utf-8?B?U2RsMitmNVVOSmRqdzZHUjJMc216dUV5SDEybVBrYURMdm5TNUhuMEV3SEZq?=
 =?utf-8?B?MHVrUUphT050NDV2VW00NlFsS1R5Q25KR0FibU5hdUw5VXdEeEhEUGlJdzds?=
 =?utf-8?B?MDZ2VElicCtieTJ0QkorbHdNWW91UHo1Vnlxdm40aEdWRURnTjhGNXJNT2Rv?=
 =?utf-8?B?SmxwUElZWUZxQUl2VHk0dTM3ZlFnQm5KeC9kRGtHanhXZlBLRHpxa1VLU25O?=
 =?utf-8?B?QVhGL3BYbHJ5SUFOQlkyTnZaK2JrcXlEL0ZmcUU4MlF3d24xaWFGNmh6ZGl1?=
 =?utf-8?B?c0ZhbUM1RHdkSkxXVStKd3I2SHBVdE5EdytlZHVMZ0xlNldxeUxrRmdtUDQ5?=
 =?utf-8?B?UFBHL0VFUS9HVFM5Y1R1cTJjNjZac2MzRVhzNUd5dm04MFFCT2ZwaUtPSUtP?=
 =?utf-8?B?Q2tvdEdFUHBFb1lVTU4wQXYrS3B2TjY3UTBNcjRPZ1AvemdDZm1yc2FtTk1q?=
 =?utf-8?B?SzU2ZjV0Z2JWYzhOV2IwYVc2bklTbFAwWTlvOVlHdTdHdFlFZGh6ZmdZK2wv?=
 =?utf-8?B?ZHI5cGx3NWxYeHZsMExyV1FhUXpKMEZ3ZlZHYTMySkxrMmkwMVRRR1Zqb0xy?=
 =?utf-8?B?TDlJb3BkQ3pHS1dtd3A3WG13akEvcllYZXBUbGRaMGVPRmdhSjBMS2NXU2Nw?=
 =?utf-8?B?ODU0aHFBRi9yZEpRRllPM05LdUdmOG1jbUdyNXEzOU9IcUk0VzhVbEZoTkZP?=
 =?utf-8?B?NVkwSFVoeXVDWjhXM3BRZ09NYTVwdHRIS0VIeDVRZ25Md2dpemRwb2VTcWpp?=
 =?utf-8?B?WWNWUXBESHZqZGhHR0c1NG1Cc1hGemJ6blhhWGJITDNwS0h2WllId3JaTVFo?=
 =?utf-8?B?OHRYOUhlSEFDeHNHUU1SSlB0TFVuaFhPODlLVlBXcjlEOGY1STkyOUEyYlhr?=
 =?utf-8?B?WTNseGd1UXVuR0hXc1Z1bDZrVnNvSC8wdUovQUl3ODEzajRoaGFreFRsM1VI?=
 =?utf-8?B?eWlzbWJKcFVHK0JnSDlNOWJqSkRLRzJma1JsT3MrV2o3amNVazd2VVlYblNu?=
 =?utf-8?B?eUF1WlZuMGVGYXc2dEZmWGFtRHBMOWF0MWFiZDdHS3BIWnNpakdvbkFYRDdx?=
 =?utf-8?B?dVR1R3JxMEF3SUVsZEl1ZmQvWDIzYUFRb0VNMGJjdUFQeWEzMGpuWEd6NXJh?=
 =?utf-8?B?N3Q0MVU3Y2JFNFEwczFMcjJXQnVaRlh5c2tSMFN0TzZ1VFhKcU1qV0NBdjVr?=
 =?utf-8?B?em11b3BiT3h4WFlBc1BmV1MvVE9tUGduS28xcmsxZ3I3SGNXMCtqQkxJUUR4?=
 =?utf-8?B?WGMzRFN2UDZXcXZZV1FGK0NZcWRxZWh6QXBINDhycnA4QnluR0xuNmQ3bHRC?=
 =?utf-8?B?TU0zKzUrNzlVRHlvU3U5NjlZY3pMbmNSd1ZzQnlIRlRFUTc4ektucWhmM0Zu?=
 =?utf-8?B?eDY3UkJEOC9uM245aGNUNXh5VG1qY0pFZVU5Zk12YXRyelBjSXV3WklhQk9G?=
 =?utf-8?B?Q25sMkMvN2U1Si9HcnM1dFBnZWhZdGNqZ1NyU2RTb1JNK2JTekZRbEVWVHF4?=
 =?utf-8?B?QVJLNSs0MWZvWUVjaDFoU3NoM3Rzb1lVbENZSVBUbUJkcnliZUh3SS9icjkx?=
 =?utf-8?B?TDFOTC96b2xrc0tYUVYvb0prN204dDZEam5VUTFDT3BXNmw5b09SdGhhQ2dp?=
 =?utf-8?B?eURhdDdXSzNESTdqRWlMSlkwc2w3bERjenRXaFNnVzNsZjdSVStHemVNVDNB?=
 =?utf-8?B?cnNKdy8yWER0RkU0TGhKWld3MW5aZXhDWSszbEdtSU1QRUoweWMzRlhvNGFP?=
 =?utf-8?B?UE1iK3ZLelE3SGJRTDZxV1lkMWVXRS9wNVFMeDVVV2gwSUlJOTY2aDJpM01M?=
 =?utf-8?B?WXhyNmRvUXYzWmtheGVlRzRBVkVjaVFJaWFIOHR2US9MVGxqMzlTMWJ0eDli?=
 =?utf-8?B?Y3JmcEl1aWdQTHZqa2xJbkxvVUV3dUVYNTZnTjZQNmJTaDhrVTRNR2RzWDRJ?=
 =?utf-8?B?dHdPT284dlE4ZE40MCtzclF5Q0R1ZXpPZysyNTNXQjRxd3lGdW83VHJKY0Vz?=
 =?utf-8?Q?tB7b1+PxP4p5tthA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CFD5A69E30274AA9C097BE3118C561@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: PuE9KngkC5n/lGYO5PqJX9DhCyggEFAfTHHD+crYwtNfUzL9+XrRXKdn1v50BMYTkIRgfk7T3eKqaV59IWyvbvdmR0l10yVRRGslkkIPSlH1BUpC+R26lYh5hfNnOyyfMdaogo5sKVendaUb0OWOe0NwLyc5C8G0JSeIinX7zVNWAJ9vRoYgVzcGJZ+rOdQWY+pbZ1ZF8Ff+7KpwzVlmqJKkv0T15ALYoNXsYn2BcQK674c830scIyWnvYzNNDGgwlMRxZvTt561/ZWCkcvOmNh5yHyO7vxRwBpUIxI5TlBsBvovCG7TEJiExJnI7x3xjPKlK8m1QrzRAx8KO6hVug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8781966-0645-446d-f08d-08df30a8cd29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 01:56:06.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nws5tLvkYV8prP12QxSR5gYAixg4lw0ZBv+emyIw3vd9+rlf/nFVJTpZQZRZIr1uAQ0dXP9MZcXo6On+nGywtB+TDU1m6gM3VWhS9XEccAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF69AE895C5
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDA3OjU5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBZ
ZXMgdGhpcyBsb29rcyBtdWNoIGNsZWFyZXIgdGhhbiBldmVuIHRoZSB1cHN0cmVhbSBjb2RlLiBE
byB5b3UgaGF2ZSBhbnkNCj4gPiBiZXR0ZXINCj4gPiBpZGVhcyB0aGFuICI0S0IgZ3Vlc3QgcHJp
dmF0ZSBwYWdlIiB0aG91Z2g/IEJlY2F1c2UgaW4gdGhlIHNwbGl0IGNhc2UgaXQgaXMNCj4gPiBh
Y3R1YWxseSBmb3IgNTEyIGd1ZXN0IHByaXZhdGUgcGFnZXMuIFdlIHNob3VsZCBwdXQgYW4gYXJ0
ZnVsIGNvbW1lbnQgdG8NCj4gPiBleHBsYWluDQo+ID4gYm90aCBjYXNlcyB3aGlsZSBub3QgbWFr
aW5nIGl0IGxvb2sgbGlrZSBzb21ldGhpbmcgdGhhdCBoYXMgYSBiZXR0ZXINCj4gPiBzb2x1dGlv
bi4NCj4gPiBCZWNhdXNlIEknbSB0aGlua2luZyB0aGVyZSBpc24ndCBvbmUuDQo+IA0KPiBXaGF0
IGFib3V0IGEgY29tbWVudCBsaWtlDQo+IAkvKg0KPiDCoMKgwqDCoMKgwqDCoMKgICogKzEgcGFp
ciB0byBhY2NvdW50IGZvciBtYXBwaW5nIGEgbmV3IDRLQiBndWVzdCBwYWdlIG9yIHNwbGl0dGlu
ZyBhDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiAyTUIgZ3Vlc3QgcGFnZSBpbnRvIDUxMiA0S0IgcGFn
ZXMuDQo+IMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gPw0KDQpDYW4gd2UgbWVudGlvbiB3aHkgd2Ug
b25seSBuZWVkIG9uZSBmb3IgNTEyIHBhZ2VzLCB3aGF0IGFib3V0Pw0KDQovKg0KICogKzEgcGFp
ciB0byBhY2NvdW50IGZvciBtYXBwaW5nIGEgbmV3IDRLQiBndWVzdCBwYWdlIG9yIHNwbGl0dGlu
ZyBhDQogKiAyTUIgZ3Vlc3QgcGFnZS4gU2luY2UgdGhlIHJlc3VsdGluZyBzcGxpdCAyTUIgcGFn
ZSB3aWxsIGJlIDJNQg0KICogYWxpZ25lZCBpdCB3aWxsIG9ubHkgZW5kIHVwIG5lZWRpbmcgb25l
IERQQU1UIHBhZ2UgcGFpciB0byBjb3ZlciBhbGwNCiAqIDUxMiA0S0IgcGFnZXMuDQogKi8NCg0K
DQo=
