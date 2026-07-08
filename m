Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7183AD50F;
	Wed,  8 Jul 2026 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476439; cv=fail; b=BRC/VJpMue1Xtt0Qq2lE6V2xm1MjjNnyQoi2wWIpafXVvEXDJw0F2aUqJAJbDq1Ce0kk6/vfFCGSDf3clzeZzrL6a0ZnKjTjQn5GKbGIIf6sF01fvvn9/gsj3weoiVMTne679OyxT4WdgpD4mqCGT4AqO1Vd2bJpmzaGyRh7gTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476439; c=relaxed/simple;
	bh=pzHwMnVzQDB7CYdtRIvFwweRr6fS/WxGyiQvi+81vNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TBsOrQZn9jynJHrDiwJ8oYbBtzT/wc1SSVrtF5I2/hwkGziEfl9D7GrwpRFPbx/RIzyNTSzY9aVRwlX12Oh4kvg3MF3Mg5ftWnoCn1q7NnSdT/4ybku+Fg+qXL8HQ3RpPME3j/6PIDAqig/FnVt+/1oWQirzJm0FmXe+YyissWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxLFgNh2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxLFgNh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476437; x=1815012437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pzHwMnVzQDB7CYdtRIvFwweRr6fS/WxGyiQvi+81vNw=;
  b=mxLFgNh2ySrrd8Q1S7J2auaQgNxHK3c3C7cGn5J0HL3PRFOKlODBpWi9
   0G2j4tjhCV3mBrzVikdNDZINjzOTsZVxtxAnhnIAsABLtELk5OQXrDoHR
   3XiFpRWWbhnhBFV3FMMkLipMHTaC+9vwBh+zQiJ97gg5sy2pfLIPV+pqq
   qpKV8YoIaGekoSCPHQIkDfwIJD773BsH/1wxwzPiZPVKgBRRficByAA06
   8QiaYagd6djLj/C0GDlFeOEssbSSLOA0x+sATQGChnDRLLGkkYewrY3t9
   YZGcs/BmsgmY9Kqg2cs71wkylyRffzNCJLzFUxTCCIFM7rzJRBjzDtt5G
   Q==;
X-CSE-ConnectionGUID: 2l0hUmAEQcmjlq3BdSEc4A==
X-CSE-MsgGUID: eAoE8xFtSuGVVbhWNeel1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95510655"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95510655"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:07:16 -0700
X-CSE-ConnectionGUID: SktIic7SRqaxYfAuRZrPCA==
X-CSE-MsgGUID: aQR5VIwRSpeR3u/JugBCVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254803971"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:07:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:07:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:07:15 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8cIknGwTIIxK20H1dIdlCSMOkZe7OeshzdhQ6ar1j3q29vXUzRt68I9pKkjp1UAw+RVNVtChHL+bi1qrR1PP5YQQkHcOK2iMF/ZZMMCQNxDOkcXZ6Q/GJV1xABs6Ymg92hM2fJf4Th3qD/559XuQIxJb7F4Tjd1OkmfnioxpTP/AXa0B4fzcnNHhvkykrlgzoV298YjsQCAj/nZzECOwxLtrALVUaih69HwkpggixWD5poonT9DchE88vGc1YP41k5i6fFxpqBmDx3Ql0TDhU+6Oh5CVlbeqN9bmOhlZ6TKATt/rc8M4piWBKbaAs7RPdU0pZblz/YWY0hGnSjkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzHwMnVzQDB7CYdtRIvFwweRr6fS/WxGyiQvi+81vNw=;
 b=rvv+tzU3nwFEk+D6dXW2r6kYWO/bR3f8CC1nh0CU5Lq5NSe3zhSq6/9FLkJHVRNVQKJ3rTGtIUbFjjCiwXdUidrEKdjTnZJJl64o/rC3MMZGfHIABOYQIVX18MHAQ9XuygGgMYFce6Gtck1hxYVBbtf7zOJ05t2leVuwSMm6/aJzn/ZCZYAlFF4VbgOGH2EcLDYd51JiX5wSYht3u2nP/tHycTXyMSt2MTvIohFOCftrjevOQ/VpJ+Giv2DMtGWo1COSKoaPoTxsB2y9xfDZLoxgnAolUDDaClJ9NJVnlFaisISjAv24h87tyhaLokZiNW+JrPbHNKKjABX+bQpC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 02:07:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 02:07:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHc7LhSIZlCRlcQpE6fbqoCJ0ANmLZjDbSAgAAVzgA=
Date: Wed, 8 Jul 2026 02:07:08 +0000
Message-ID: <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
	 <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
In-Reply-To: <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7011:EE_
x-ms-office365-filtering-correlation-id: c70520a1-b8ca-4236-ee21-08dedc959d6e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|56012099006|4143699003|11063799006|22082099003|6133799003|18002099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: ags6FI3jHHOQBZUq5smj0qlneJrjebtrPLfU0VXhJVR3vpJS0mwha1ySN2SZcNwZTpOEzbqWHcqMUCVCpU8ugH65+nqadqGgCnttVHr6RfhCWBokGN8415sGSwFFqpQ/NMkDQ4dQ9H0EKHUR02jIwxK0imZ/jC2qGnMRQCk3QqwMhcScg0Oh+iiH8Wb9QN3Zp/mhlDL/jstX/6EjxaVTQLl6x6pI1qHZc8uKetZMiD9ICwqCSkB8YaYwXUs9YK7hHthLImxlEiwCx/DT/+hNWa2A0/BnqlTsDQNr9XHT0QhKv0WFC5XXpParHDY8DimzWncNvi6CQvOi50G1TQNEJ/dEwLZX+i35YmJhL4BG+5dTfpm+dCq3XZ3TFQobRJ0K7ItW4/RRXrLvAefSz4zU92ExgVPMMPj/UFeo0CJFHLTgJOQ49r/aSI2yyI7E9vJ8Jc3/m99GWyMLLVbOFrcMF84+LzVaxSOumqxMr8NbtOpgSRcSouXoc2BXu2tynK8iY5fXitGRfl6fR07rydLiWAOKipo2f4iu2xpQgrbF4LFeYvOvN0vAmyoPJk5x7fMvFTCuYUGZXoYw9pWa/MUOMZuNdD63/6vjAA//htkskhX0+bVMz3MOAr6m4pZsFmGMy9WZ3rNLwh2lHwmFEjjjlKHm9Gqe4BnQCmCpOUTOp2WICq0uPFMuKHz6fn9+GX7e0umdklYc8p5FWSAh3QGaY7vqcEjC+IaQiP6bb+FquLB2AyU0akJPyb4rzec7KvH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003)(18002099003)(3023799007)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzRSMVRSc3o3dlozaFdDYUVSRW5tcWJVYmJKRmJlTE5IU3NrZXRsTVZYVGZy?=
 =?utf-8?B?UHVxb3JnSW95aVJGODR4UmQ4Q3lrWEJ4ZEpGN01jaE5BSnVyWTB6dmNhbWNx?=
 =?utf-8?B?WU1BMWRaN052NGU2THU0S3ByRkxucXRQNjRjeXg5dlE5TFVucFFtWGJ4VFlN?=
 =?utf-8?B?UXFtblpIeTZrdHhEWVFqWGwwU0xuWVYyK3ZGMmtRY2U5MmxoSVcxVk8zRDF6?=
 =?utf-8?B?R3hwMVc0N2piUStUbTRRTm5YaWNFRXpXMEd4anNudjJtNHMrZGdzUm9RS1NT?=
 =?utf-8?B?cWh6WU9tYzBKNGRpaHcweW82RmFTdmVHUzVkNjNpRHZxRkx4KzJzRWFrYmdq?=
 =?utf-8?B?cTRlWm1PUXhzUnlmeHQ0NTV2U2hqbzE2TEI2WUd4Q3p0L09JTzU4dTROdmtV?=
 =?utf-8?B?b0txOWtwSHExdks5OFQrRmJYTXZ6dEZnN1lodXdvaUVFRStjdnlFTkhKaHl1?=
 =?utf-8?B?N3lKR1l6aThhWDM0MGNsVDZ2MVJGN0M5MmFZNTBRMnFxdTNsQTlSd0pRWlFl?=
 =?utf-8?B?ODdrcEV2RWpHZ2tsc2Uwa1d4VHpZUTQwbFNIY3h1NU15NzJYRFl1KzNyY0Fn?=
 =?utf-8?B?YXhIMTk5N3dlQUNrSTVZYS9KdUszRmtTbnErbmt4V1VmNDJIV0ZkaWM4ek5t?=
 =?utf-8?B?dnhDTzNoNmJDVGc1MVBhSnA4VjgrZVlSSlFiNC9DbkVoN1ZEeEp5emkxLzlh?=
 =?utf-8?B?aDZYZlUyWk1LZnJ1L1YxSVIyakhvNDFzMllqZk41bklaaVVyWllHZGRpcEly?=
 =?utf-8?B?MUx2VGJWZFVteTZ0QlJkN3VyVXdDMWgzR0FFM0h1RUU3NW9YK1FMOTltWVcz?=
 =?utf-8?B?c0VHMlVnTDVTWkFCNjg0SXNreUYybk1ORHFXMUY2Rm9rdEdVdExoS2lLeXJz?=
 =?utf-8?B?eWM4dEw5K2JPNXRsc1ZMUm5kUzFlL245cGpZQ0kyOE1EY2tIaWpML1U4ZlZS?=
 =?utf-8?B?cU0xRTVlbjB3Y1QxRU5QWm5LV2FpODdvQ1FyT21DWmVrQ2tEYWxHdUpzNzli?=
 =?utf-8?B?dU5vVlVRVW5RdWpueUlRbGVSY3RqclVxRGV3Q3RvdGtma2JDbXloQlpQd0Fw?=
 =?utf-8?B?ODQxUDJSdXRTQm5uMnpKUWI1Y1N0bm9VL2EyT3d4RmtSaGFqZXA3eHMrN2x0?=
 =?utf-8?B?YjY3aGV6STUrU2l3bUJ4M0x2aUt1MFVjYkJpTlJyTzN6em85clNtTm9CeHdm?=
 =?utf-8?B?M2ZTaW16QVBzRW1Hdi94OS9JMVZabGFVVEpETWd6WU1KWnlIN2pBbkppN25h?=
 =?utf-8?B?NVR4UEVYUVB0c2NWZnJ4VFBQL1dsUVZITy9ISUlqQzdPaEdhTm1kQ3g3VVNz?=
 =?utf-8?B?NWdFS0RGTmtlNXJUNWd5UEhGMjBTTlFMcjI3aXlCYWhiRTNCSzlHSTBHU3Ju?=
 =?utf-8?B?L0NFMStNRXpSYkRQK2syOS95NG16WHpQRkZBbnl3TUsxZmk2NWdVVFBaVFZG?=
 =?utf-8?B?d3o1MW1nZWR4KzYrdEtWb1ZHaElTNmtKQVVaTGJSMnFxNC9JY0VoajhJSjRB?=
 =?utf-8?B?MUhZS09MUDNHM1Fya1k0eW93anI5S3BSWWN2TVI3SVBUZU5VRFFkaGxPS1hR?=
 =?utf-8?B?TUFPWVNjd3hra1VTSHpLYWpKVlpGUSsyb05QN0RZWUp3L3RqUDlwN1F3N1lE?=
 =?utf-8?B?bllEL08ydC9lVFlyVndXQWJieXRiOHBWbnNGN3UxWEJtelVHR3lGT0loOGY2?=
 =?utf-8?B?eUJXMzJRekp2YnRUNno4R1BadGNJV2NtRHBsZEZ5QStjU3BiTzJtc3V0b1kw?=
 =?utf-8?B?V0ZldzNiV0VzMUw0M05sTEhLdHcwUHUyRE1yZFRlcDA2WWJuaW15MGFoU3lp?=
 =?utf-8?B?WnNLME9xbXJwWWhva1RNZVVhWkE3MWNXNnZvMGwrUjBRSVE2eEJ5VDQyOHls?=
 =?utf-8?B?eGZocTlETkpqNHRnSVo0TG9OWTN0UDZWL08zTGs5bUw3Y1h6clhkWTZNSHhC?=
 =?utf-8?B?T0dqaG9XYUFSQ1pVZVVZbEsrTHdsUERYZDZiZ2hoVldDWG1lRGljR3dRTS9S?=
 =?utf-8?B?UWRHN1h2R0d2VEMrQkRqeXJ5eFVvU0Q1U29vbXEwZ2NmZWQzMFlscHhpQ1Fp?=
 =?utf-8?B?VGRTRjJQWWtZL04xeE5FRUVFTkZxZUlra216ZCt1MU5nTjhwc0RYdnAvVVNp?=
 =?utf-8?B?M0t1S0U3NzlLNzhFdXZxcHgrMUxQWm5nR0ZZaThKdXdxampZQUVoOHRncE12?=
 =?utf-8?B?S2JwTnBreXJQTURoUHR6SEU2bWJRNUdQQnptTGNIRWswVGRJYTV5Q2Zid3Jr?=
 =?utf-8?B?ZWt5Kzh3ay9VMFo5TTU3OTRjTDRGanV6VWcwb3NoR3hLRjR3V01ZWE5aS2dD?=
 =?utf-8?B?OE9PMnlWODhqT1I2VzAzdzNRMGJ2ZXVsTkd3WTB0VXgvUUw4Ty96TXdLUzJ5?=
 =?utf-8?Q?IrAufApDPwwA5Myg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56EAD90BD39E994A9B730BD92E0E6E90@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nQ2VtUDHCS16h3OpLG7wCckH8iiHA1mn+3e8MsaL2Ovm2/RQNpW78YcwCXlUwlg7h+zYTpF+KJMr7GKS5Wc97J4sVpDtudNK3Mz84GKXenL3GgGjwgyifG8+6WUQHPEa7H+eT+oI24jr4cEcJHTtNHm/a9hYtXUl7U8rZ4Z8O2JbC3BskGgABoHwNMS3GQ7dFjReugtYT5aIiJSbMU7hB44FiOJ104GVUajHB5klIbI5FI2/i+Xr+HTTkrclnppR+yBLxK3MpXEwfFqWynyPswO2SMK9gLYsLFGylxK/s9HKXCMr1emeubvoNwoYvbkE5SEkk8sJqSKscVbqp7sqVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70520a1-b8ca-4236-ee21-08dedc959d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 02:07:08.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BezF5As9yxQgJVbQL4ua5/OljjLT90eoLhDaKL+0sYgnlHswjR/brfW7ck9Syyf34VEN6TbdrmWKkq3lpAoijxPIPeR2KW4CimRnVsJBJkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDE3OjQ5IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gNS8yNS8yMDI2IDc6MzUgUE0sIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206ICJL
aXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+
IA0KPiA+IFRoZSBURFggUGh5c2ljYWwgQWRkcmVzcyBNZXRhZGF0YSBUYWJsZSAoUEFNVCkgaG9s
ZHMgZGF0YSBhYm91dCB0aGUNCj4gPiBwaHlzaWNhbCBtZW1vcnkgdXNlZCBieSBURFgsIGFuZCBt
dXN0IGJlIGFsbG9jYXRlZCBieSB0aGUga2VybmVsIGR1cmluZw0KPiA+IFREWCBtb2R1bGUgaW5p
dGlhbGl6YXRpb24uDQo+ID4gDQo+ID4gVGhlIGV4YWN0IHNpemUgb2YgdGhlIHJlcXVpcmVkIFBB
TVQgbWVtb3J5IGlzIGRldGVybWluZWQgYnkgdGhlIFREWCBtb2R1bGUNCj4gPiBhbmQgbWF5IHZh
cnkgYmV0d2VlbiBURFggbW9kdWxlIHZlcnNpb25zLiBDdXJyZW50bHkgaXQgaXMgYXBwcm94aW1h
dGVseQ0KPiA+IDAuNCUgb2YgdGhlIHN5c3RlbSBtZW1vcnkuIFRoaXMgaXMgYSBzaWduaWZpY2Fu
dCBjb21taXRtZW50LCBlc3BlY2lhbGx5IGlmDQo+ID4gaXQgaXMgbm90IGtub3duIHVwZnJvbnQg
d2hldGhlciB0aGUgbWFjaGluZSB3aWxsIHJ1biBhbnkgVERYIGd1ZXN0cy4NCj4gPiANCj4gPiBF
YWNoIG1lbW9yeSByZWdpb24gdGhhdCB0aGUgVERYIG1vZHVsZSBtaWdodCB1c2UgbmVlZHMgdGhy
ZWUgc2VwYXJhdGUgUEFNVA0KPiA+IGFsbG9jYXRpb25zLiBPbmUgZm9yIGVhY2ggc3VwcG9ydGVk
IHBhZ2Ugc2l6ZSAoMUdCLCAyTUIsIDRLQikuIFRoZQ0KPiA+IFREWCBtb2R1bGUgc3VwcG9ydHMg
YSBuZXcgZmVhdHVyZSBkZXNpZ25lZCB0byByZWR1Y2UgUEFNVCBvdmVyaGVhZCBjYWxsZWQNCj4g
PiBEeW5hbWljIFBBTVQuIEF0IGEgaGlnaCBsZXZlbCwgRHluYW1pYyBQQU1UIHN0aWxsIGhhcyB0
aGUgMUdCIGFuZCAyTUINCj4gPiBsZXZlbHMgYWxsb2NhdGVkIG9uIFREWCBtb2R1bGUgaW5pdGlh
bGl6YXRpb24sIGJ1dCB0aGUgNEtCIGxldmVsIGlzDQo+ID4gYWxsb2NhdGVkIGR5bmFtaWNhbGx5
IGR1cmluZyBydW50aW1lLg0KPiANCj4gVGhlIGxhc3Qgc3RhdGVtZW50IGlzIHNsaWdodGx5IGNv
bmZ1c2luZyB0byBtZS4gSXMgaXQgdHJ5aW5nIHRvIHNheSB0aGF0DQo+IHRoZSAiZHluYW1pYyIg
cGFydCBpcyBvbmx5IGFwcGxpY2FibGUgdG8gNEtCIGFsbG9jYXRpb25zPw0KDQpZZWEuIENhbiB5
b3UgZXhwbGFpbiBtb3JlIGFib3V0IHdoYXQgaXMgY29uZnVzaW5nPyBJIGd1ZXNzIHRoaXMgaXMg
bW9yZSBjb21wYWN0Og0KDQpVbmRlciBEeW5hbWljIFBBTVQgdGhlIDRLQiBsZXZlbCBpcyBhbGxv
Y2F0ZWQgZHluYW1pY2FsbHkgZHVyaW5nIHJ1bnRpbWUsIHdoaWxlDQp0aGUgMUdCIGFuZCAyTUIg
bGV2ZWxzIHJlbWFpbiBhbGxvY2F0ZWQgb24gVERYIG1vZHVsZSBpbml0aWFsaXphdGlvbi4NCg0K
PiANCj4gDQo+ID4gDQo+ID4gSG93ZXZlciwgaW4gdGhlIGRldGFpbHMsIER5bmFtaWMgUEFNVCBz
dGlsbCBuZWVkcyBzb21lIHNtYWxsZXIgcGVyIDRLQg0KPiA+IHBhZ2Ugc2NvcGVkIGRhdGEgKGN1
cnJlbnRseSBpdCBpcyAxIGJpdCBwZXIgcGFnZSkuIFRoZSBURFggbW9kdWxlIGV4cG9zZXMNCj4g
PiB0aGUgbnVtYmVyIG9mIGJpdHMgYXMgYSBzZXBhcmF0ZSBwaWVjZSBvZiBtZXRhZGF0YSB0aGFu
IHRoZSA0S0Igc3RhdGljDQo+ID4gYWxsb2NhdGlvbiBmb3IgcmVndWxhciBQQU1ULiBBbHRob3Vn
aCB0aGUgc2l6ZSBpcyBlbnVtZXJhdGVkIGRpZmZlcmVudGx5LA0KPiA+IGl0IGlzIGhhbmRlZCB0
byB0aGUgVERYIG1vZHVsZSBpbiB0aGUgc2FtZSB3YXkgdGhlIDRLQiBwYWdlIHNpemUgUEFNVA0K
PiA+IGFsbG9jYXRpb24gaXMgZm9yIHJlZ3VsYXIsIG5vbi1keW5hbWljIFBBTVQuDQo+ID4gDQo+
ID4gQmVnaW4gdG8gaW1wbGVtZW50IER5bmFtaWMgUEFNVCBpbiB0aGUga2VybmVsIGJ5IHJlYWRp
bmcgdGhlIGJpdHMtcGVyLXBhZ2UNCj4gPiBuZWVkZWQgZm9yIER5bmFtaWMgUEFNVC4gQ2FsY3Vs
YXRlIHRoZSBzaXplIG5lZWRlZCBmb3IgdGhlIGJpdG1hcCwNCj4gPiBhbmQgdXNlIGl0IGluc3Rl
YWQgb2YgdGhlIDRLQiBzaXplIGRldGVybWluZWQgZm9yIG5vcm1hbCBQQU1ULCBpbiB0aGUgY2Fz
ZQ0KPiA+IG9mIER5bmFtaWMgUEFNVC4NCj4gPiANCj4gPiBVbmxpa2UgdGhlIGV4aXN0aW5nIG1l
dGFkYXRhIHJlYWRpbmcgY29kZSwgdGhpcyBjb2RlIGlzIG5vdCBnZW5lcmF0ZWQgYnkgYQ0KPiA+
IHNjcmlwdC4gDQo+IA0KPiANCj4gSXQgbWlnaHQgYmUgdXNlZnVsIHRvIHNheSB0aGF0IHRoaXMg
ZmlsZSB3YXMgYXV0by1nZW5lcmF0ZWQgaW4gdGhlIHBhc3QNCj4gYnV0IGdvaW5nIGZvcndhcmQg
aXQgaXMgZ29pbmcgdG8gYmUgbWFudWFsbHkgdXBkYXRlZC4NCj4gDQo+ID4gU28gYWRqdXN0IHRo
ZSBjb21tZW50IHRvIGJlIG1vcmUgZ2VuZXJpYy4gQWxzbywgc3RhcnQgdG8gYWRvcHQgYQ0KPiA+
IG1vcmUgbm9ybWFsIGtlcm5lbCBjb2RlIHN0eWxlIHdpdGhvdXQgdGhlIHRlbmFyeSBzdGF0ZW1l
bnRzIGFuZCBpZg0KPiANCj4gcy9hIG1vcmUvDQo+IHMvdGVuYXJ5L3Rlcm5hcnkNCg0KSG93IGFi
b3V0IHRoaXM/DQoNClRoZSBleGlzdGluZyBtZXRhZGF0YSByZWFkaW5nIGNvZGUgd2FzIGdlbmVy
YXRlZCBieSBhIHNjcmlwdCwgYnV0IHRoZSBjdXJyZW50DQpwbGFuIGlzIHRvIHN0b3AgZ2VuZXJh
dGluZyB0aGlzIGNvZGUsIGFzIHRoZSBzY3JpcHQgaGFzIGNvbnRpbnVlZCB0byBuZWVkDQphZGp1
c3RtZW50cy4gU28gYWRkIG1hbnVhbGx5IHdyaXR0ZW4gY29kZSBhbmQgYWRqdXN0IHRoZSBjb21t
ZW50IGFib3V0IGl0IGJlaW5nDQphdXRvZ2VuZXJhdGVkIHRvIGJlIG1vcmUgZ2VuZXJpYy4gU3Rh
cnQgdG8gYWRvcHQgYSBtb3JlIG5vcm1hbCBrZXJuZWwgY29kZSBzdHlsZQ0Kd2l0aG91dCB0aGUg
dGVybmFyeSBzdGF0ZW1lbnRzIGFuZCBpZiBjb25kaXRpb25hbHMgYXNzaWdubWVudHMgdGhhdCB0
aGUgYXV0bw0KZ2VuZXJhdGVkIGNvZGUgaGFzLg0KDQo+IA0KPiANCj4gPiBjb25kaXRpb25hbHMg
YXNzaWdubWVudHMgdGhhdCB0aGUgYXV0byBnZW5lcmF0ZWQgY29kZSBoYXMuDQo+ID4gDQo+ID4g
QXNzaXN0ZWQtYnk6IFNhc2hpa286Y2xhdWRlLW9wdXMtNC02DQo+ID4gUmV2aWV3ZWQtYnk6IEJp
bmJpbiBXdSA8YmluYmluLnd1QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRoZSByZXZpZXcgdGFn
cyBnb2VzIGFmdGVyIHRoZSBTT0JzLg0KWWVwLCBJIGhhdmUgYmVlbiBmaXhpbmcgdGhvc2UgYWNy
b3NzIHRoZSBzZXJpZXMuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRl
bW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+IENvLWRldmVsb3BlZC1i
eTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gPiBpbmRleCA1MDNmOWEzZjQ2ZDYxLi44MmRj
MjdhZWNmMjk3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oDQo+
ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gPiBAQCAtMTQ5LDYgKzE0OSwx
MSBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCBzY19yZXRyeShzY19mdW5jX3QgZnVuYywg
dTY0IGZuLA0KPiA+ICBjb25zdCBjaGFyICp0ZHhfZHVtcF9tY2VfaW5mbyhzdHJ1Y3QgbWNlICpt
KTsNCj4gPiAgY29uc3Qgc3RydWN0IHRkeF9zeXNfaW5mbyAqdGR4X2dldF9zeXNpbmZvKHZvaWQp
Ow0KPiA+ICANCj4gPiArc3RhdGljIGlubGluZSBib29sIHRkeF9zdXBwb3J0c19keW5hbWljX3Bh
bXQoY29uc3Qgc3RydWN0IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykNCj4gPiArew0KPiA+ICsJcmV0
dXJuIGZhbHNlOyAvKiBUbyBiZSBlbmFibGVkIHdoZW4ga2VybmVsIGlzIHJlYWR5ICovDQo+IA0K
PiBJIHdvdWxkIGF2b2lkIHRoZSB0YWlsIGNvbW1lbnQgZXZlbiBpZiBpdCBpcyB0ZW1wb3Jhcnku
DQoNClllcCwgWWFuIGNvbW1lbnRlZCB0aGUgc2FtZSB0aGluZy4NCg0KPiANCj4gPiArfQ0KPiA+
ICsNCj4gPiAgaW50IHRkeF9ndWVzdF9rZXlpZF9hbGxvYyh2b2lkKTsNCj4gPiAgdTMyIHRkeF9n
ZXRfbnJfZ3Vlc3Rfa2V5aWRzKHZvaWQpOw0KPiA+ICB2b2lkIHRkeF9ndWVzdF9rZXlpZF9mcmVl
KHVuc2lnbmVkIGludCBrZXlpZCk7DQo+IA0KPiANCj4gDQo+ID4gQEAgLTMzLDYgKzMzLDE4IEBA
IHN0YXRpYyBfX2luaXQgaW50IGdldF90ZHhfc3lzX2luZm9fZmVhdHVyZXMoc3RydWN0IHRkeF9z
eXNfaW5mb19mZWF0dXJlcyAqc3lzaW5mDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4g
IA0KPiA+ICtzdGF0aWMgX19pbml0IGludCBnZXRfdGR4X3N5c19pbmZvX3RkbXJfZHBhbXQoc3Ry
dWN0IHRkeF9zeXNfaW5mb190ZG1yICpzeXNpbmZvX3RkbXIpDQo+ID4gK3sNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKwl1NjQgdmFsOw0KPiA+ICsNCj4gPiArCXJldCA9IHJlYWRfc3lzX21ldGFkYXRh
X2ZpZWxkKDB4OTEwMDAwMDEwMDAwMDAxMywgJnZhbCk7DQo+IA0KPiBTaG91bGQgdGhpcyBiZSBh
ICNkZWZpbmUgbm93IHRoYXQgdGhlIGZpbGUgaXMgYmVpbmcgbWFudWFsbHkgdXBkYXRlZD8gT3IN
Cj4gaXMgdGhlIHBsYW4gdG8gZG8gaXQgYWxsIHRvZ2V0aGVyPyBBICNkZWZpbmUgd291bGQgbWFr
ZSBpdCBlYXNpZXIgdG8NCj4gcmVhZCB0aGlzIHBhdGNoLg0KDQpJIHRoaW5rIHN3aXRjaGluZyB0
byBkZWZpbmVzIHdvdWxkIG92ZXJsYXAgdG9vIG11Y2ggaW50byB0aGUgdWx0aW1hdGUgbWV0YWRh
dGENCnJlYWRpbmcgc29sdXRpb24gdGhhdCBnZXRzIGRpc2N1c3NlZC4gQ2hhbyBpcyBjdXJyZW50
bHkgd29ya2luZyBvbiBhIHNlcmllcyBmb3INCnRoaXMsIHNvIEknZCB0aGluayB0byBsZWF2ZSB0
aGF0IHBhcnQgZm9yIGxhdGVyLg0KDQo+IA0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJc3lzaW5m
b190ZG1yLT5wYW10X3BhZ2VfYml0bWFwX2VudHJ5X2JpdHMgPSB2YWw7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIF9faW5pdCBpbnQgZ2V0X3Rk
eF9zeXNfaW5mb190ZG1yKHN0cnVjdCB0ZHhfc3lzX2luZm9fdGRtciAqc3lzaW5mb190ZG1yKQ0K
PiA+ICB7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPiBAQCAtMTE2LDUgKzEyOCwxMiBAQCBzdGF0
aWMgX19pbml0IGludCBnZXRfdGR4X3N5c19pbmZvKHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5c2lu
Zm8pDQo+ID4gIAlyZXQgPSByZXQgPzogZ2V0X3RkeF9zeXNfaW5mb190ZF9jdHJsKCZzeXNpbmZv
LT50ZF9jdHJsKTsNCj4gPiAgCXJldCA9IHJldCA/OiBnZXRfdGR4X3N5c19pbmZvX3RkX2NvbmYo
JnN5c2luZm8tPnRkX2NvbmYpOw0KPiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiBEb24ndCB0cmVh
dCBhIG1vZHVsZSB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBEeW5hbWljIFBBTVQNCj4gPiArCSAqIGFz
IGEgZmFpbHVyZS4gT25seSByZWFkIHRoZSBtZXRhZGF0YSBvcHRpb25hbGx5Lg0KPiA+ICsJICov
DQo+ID4gKwlpZiAoIXJldCAmJiB0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KHN5c2luZm8pKQ0K
PiA+ICsJCXJldCA9IGdldF90ZHhfc3lzX2luZm9fdGRtcl9kcGFtdCgmc3lzaW5mby0+dGRtcik7
DQo+IA0KPiBUaGVyZSBpcyBhIG5lZWQgZm9yIHRoZSBjb21tZW50IGJlY2F1c2UgaXQgY29tYmlu
ZXMgdHdvIGNoZWNrczoNCj4gDQo+IDEpIERpZCBhbnkgb2YgdGhlIHByZXZpb3VzIHN0YWdlcyBm
YWlsPw0KPiAyKSBEb2VzIHRoZSBURFggbW9kdWxlIHN1cHBvcnQgRHluYW1pYyBQQU1UPw0KPiAN
Cj4gU2hvdWxkIHRoZXNlIGJlIHNlcGFyYXRlZCBmb3IgcmVhZGFiaWxpdHkgYW5kIHRvIGZvbGxv
dyB0aGUgdHlwaWNhbA0KPiBrZXJuZWwgc3R5bGU/DQo+IA0KPiAJaWYgKHJldCkNCj4gCQlyZXR1
cm4gcmV0Ow0KPiANCj4gCWlmICh0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KHN5c2luZm8pKQ0K
PiAJCXJldCA9IGdldF90ZHhfc3lzX2luZm9fdGRtcl9kcGFtdCgmc3lzaW5mby0+dGRtcik7DQo+
IA0KPiAJcmV0dXJuIHJldDsNCj4gDQo+IEkgdGhpbmsgeW91IGNhbiBhdm9pZCB0aGUgY29tbWVu
dCBhbHRvZ2V0aGVyIGluIHRoYXQgY2FzZS4NCg0KSSBkb24ndCB0aGluayBpdCByZW1vdmVzIHRo
ZSBuZWVkIGZvciBhIGNvbW1lbnQuIFRoZSBwb2ludCBpcyBpZg0KdGR4X3N1cHBvcnRzX2R5bmFt
aWNfcGFtdCgpIGlzIG5vdCBzdXBwb3J0ZWQuIFRoZSBjb21tZW50IHNob3VsZCBiZSBtb3JlIGFi
b3V0DQoid2h5IiwgdGhhbiB3aGF0IHRoZSBjb2RlIGRvZXMsIHJpZ2h0Pw0KDQpIb3cgYWJvdXQ6
DQoNCglpZiAocmV0KQ0KCQlyZXR1cm4gcmV0Ow0KDQoJLyoNCgkgKiBUaGUga2VybmVsIHN1cHBv
cnRzIHVzaW5nIFREWCB3aXRob3V0IER5bmFtaWMgUEFNVCwgc28NCgkgKiBhdm9pZCByZXBvcnRp
bmcgZmFpbHVyZSBpZiBpdCdzIG5vdCBzdXBwb3J0ZWQuDQoJICovDQoJaWYgKHRkeF9zdXBwb3J0
c19keW5hbWljX3BhbXQoc3lzaW5mbykpDQoJCXJldCA9IGdldF90ZHhfc3lzX2luZm9fdGRtcl9k
cGFtdCgmc3lzaW5mby0+dGRtcik7DQoNCglyZXR1cm4gcmV0Ow0KDQo+IA0KPiA+ICsNCj4gPiAg
CXJldHVybiByZXQ7DQo+ID4gIH0NCj4gDQoNCg==
