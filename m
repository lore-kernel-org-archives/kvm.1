Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315437DE85;
	Tue, 15 Sep 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505648; cv=fail; b=Mw4hmUbfiH4UMQdLIQaqkGo+LeUi5RIcS6Mk2YIBEH3PKc7okvv+p2/NUQKF4pwbPmWkYCWEnsX/b5fGCks/2kPTUIaN+ntsja6ygUcflDGNb7SEXokUKpiMzMbGFW/tTV6TE380rBid2uOTvTvvdC+SVFmRZ2uSY44s/oO1fEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505648; c=relaxed/simple;
	bh=UD4QLuDTDYlUGPxhxZBj8ZRd70zhdu+42cGvvqXZk5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pd8PqeT3G4ptv55H4p0HPWGpLr8rX2QAdshK+bGZIwWO5msZy9qrpQ1gLfg2iCGU3HL+pf/TN6dZwif6g1JMCbRplLbbh2FFgOBfjwryVo/CpRfaAGDPnPmkkjmFI8eLKt+f5TFn9vb3xySILiIaqUXAYthILs7v2VFYUsAE3W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1/WzXdz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1/WzXdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789505647; x=1821041647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UD4QLuDTDYlUGPxhxZBj8ZRd70zhdu+42cGvvqXZk5o=;
  b=b1/WzXdz9/ms/tMWrPix6w9Nc2fjEBF9NQBj+gvzMVVvQ4TqbL789Wwf
   qw77notqGhcEviMg0UQ6yspXvAi4gKr6fP9kpLc4pMXIm40/MHEEkjyGr
   taUrmjltRIp6NzAN10fiv0N84/jigjN6+H0b4kuoz3qWmOBFJst70T1hX
   yjaA4Xwxt9pDl6JXcmdCIlB06TqVqWCNJ8xMksgcfp2EoqzPeVevdVop1
   /TilGR6HkU8cx1nN2P2uISWetu9B3Jsh2mpuS4KRK3s3cb9RWDFbT6OwL
   QLDwofiMdpdbRhDygZ1sirWFtRS+Usk6x2/iJHYl0wbUgQAGElu0mvy7U
   Q==;
X-CSE-ConnectionGUID: rUznrgnLRK20ZzQ3wFlB+A==
X-CSE-MsgGUID: Bkqg2rQ2TZ2N18unkBw0ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89898960"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89898960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:54:06 -0700
X-CSE-ConnectionGUID: BMSq47zISmePrlZGwAhk/g==
X-CSE-MsgGUID: ec4lBGZbSm+jl2Qgb6/fMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276874801"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:54:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:54:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 13:54:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbvG39c/mjCHQWwDj6ftp93bRT7bCiFPjgt8cC6aoXB6bjBiMgKl1cOETVhrjQYQSgWfGQvez3+ZcHWdkZb+i3WKv/j1Illl/O3BX9oeU5w0QyPl59nFYjmyrP5pBFWpzeQPq8G5gj2dKWnEFfW5f9hs/RhmJx3cnAm2aQTsupl3VEaPRN/mlNo43xsHWOoczOHV69D2WGrOn4OSY/wJLhOt8bgsBMR/zoHKloKPCRwuDtrpFpGM51lwmUENOIBwELg+/ivlmEMi7JZy66Qz5Rjv0+KYIl2BIxVoaZasrgoilQp5NAsWW8nxvKtcmQyyD7HsnB+WW3XJyKDLTmaFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD4QLuDTDYlUGPxhxZBj8ZRd70zhdu+42cGvvqXZk5o=;
 b=aLmhmSjzVWOjDsHDnFNkqyZasqeMZV3h6h6YwF7X74iZ7IDIYyJAu56U82PG4aH7xjYVfWjNe/Mjpx1UF4iN81GyeOSxGCgeUGp3pw5tLGuO/BG8Qftrmpo1+eihG9rVJC+sXsrmTaSKF9odo9PdOTPGBdkDM6N7tw2M23pkrMCn+fvqcETd1ocLh39kj+27Cw/6YEAqSivXEWNCWQJc/fIhBSRuh9SpAfGy1BR1phpczuWawx9f8ANgSXS392Cf4FiQJahwGUvxUfzeW0jecvOGDZkftR/Codnj6/tGDvWY8zOkFP7DH+fQiF2VZ/C/q29yYGF8pJDV3gRg0fPeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:54:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:54:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Topic: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Index: AQHdRPzQX5taAxNGkkCppHYESMqxcrbQHrAA
Date: Tue, 15 Sep 2026 20:54:01 +0000
Message-ID: <2f6ac9afef52386fc491145222ea46e54c24a73f.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-3-yilun.xu@linux.intel.com>
In-Reply-To: <20260915102658.713079-3-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: 4296a2d1-9a56-4c56-110f-08df136b788c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CAfQuGdxfYxa6rwU2joBBa2bw4oJdd1GSp8Io8+TeKlF/schCgUEc+4jGxMY4kEsv3IV/vsqImKiZJSHcb2VNNUi/wyDZ+x04nEcFDuLTfVbwqZueGk5+U2aOIf7PQQshylyoSF0JY8Ao2I3EAFwvaM1otJXgFAzCQX20T8zyY0xMlq1dsORXwvvp36Bqgha4/JJ2n3WoNTnnjpJlZ+rLjDj7tgou0mg6y1Q8b3CA6LL5ZubRu+twDr0slo+ygsEpIsucWVt4DCM8Z2PcJMfwd/CMJVjAy+2poWfAqkAwXIZxJi/DFT1iqqMe+B27811bPgvMyjDDXIDjMSOnpzPX/9jPfNy9cuBR583XmKC7hHg9T1rYXxSJmL+hImxzUuMxDBPA4IW9tBdPu2cG7gdheQRAPyOzjfahWwyclQYIJ2ewoG4dYbYQVFOpDwbsQWXDDx7dcWpvuLVEJC9myLwqvT2IZyWr8R/lmsNbJrRdIBVniWSnWBcWmXI/JKNgnIm0esMY0l5VDmRaq/MYwsYW9yoq0m9Tcrf7wyvOhr79JpRNCv3ZOx+pWc1tltkCEytvawvnhDqZjRoKLFy5ufhmmHjOKDTLb6PmXgvcFR/gBAibzy2sJFi2jcIM38KzE8ipuh//3MOBtf6TKNC03tM9VqH45srbEicH9LKZUfTs1Sk8jO7g0aVKj5EOzr1dynWWEejc3/e6wHnSHczNE8WLd+Fmuayd9zprsprYYE7PBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0RpcW1vQjJpdmtQRlhiVnR0Vmx5ckRGWTRiZnJYT0h3ZmRGaHJWcTBBN1Vn?=
 =?utf-8?B?Tng1czlCL0ZIRWV1UFBnZ0VPOHYxQlU4c3UvWVZnNVk0L0x1d2dtM0d3aHRp?=
 =?utf-8?B?OUxNc08vUE1TcFhiQXIwdys3TlR4YmEwMm9ZbkxnM1VHaTMrVm9RdVdIMWg4?=
 =?utf-8?B?eXNJay9ZMlpIUEFPemVFeGM4UjFWL2RBZ1dTSnRtT05YQXdRVWVNMmRKQW5I?=
 =?utf-8?B?R0VkTnJSVURhU0g2K280Uy9UWWhTanZiYU56R2ZqMU5mOE5hT0FXU0V6b3pI?=
 =?utf-8?B?SVBKNkt2RzlXWEpGM2tIRUo4Z1M2Q3dpNEwrb2J0eXBIYXlpU0ovVDV3b1Zt?=
 =?utf-8?B?N3FpK09WOHdjQVZQYU80YWZoMFljb0NERDFNcld0aVpLU0NNcWpKRzNxeFFP?=
 =?utf-8?B?Sm1lc3Fta29rS2Z3QVJKbEV5amJMckdCK1IrckJXdGlnOVJmR1lHR0Q4bmNP?=
 =?utf-8?B?ZFcvaTk3RDROYXFHS3FadGtaekVnb1ptT08zdXZESVRGWVgraFRxZXh4emx4?=
 =?utf-8?B?RzFCcEhSUTdISE1HYXVtTlJVWmJBL25QNEVjNjk4Qk9tcUZPQ3dmZnIvSnp3?=
 =?utf-8?B?TisxTVhXajBISkZjUkVPZ1Y2S0N2Um9Ebjd5Ni9jUjdqNlplWVh0SHlYbWpX?=
 =?utf-8?B?N3EvVUJzQ0VuM2ZrWitDa3hlTjhOWVFmMXBZWEozM3QvYUdMQ1FFM1NsV3h2?=
 =?utf-8?B?bG5SaGYzUVJHZng2M1pzbktucEZEM0RPMzg3ZHlHNnNrZStsWWQ1YzJpVldr?=
 =?utf-8?B?Y0I1WStDb1l4Rmw2eE82NStsWmw3ZEtWUWM0ZFZueUk4N212WTNWQjNPQmpN?=
 =?utf-8?B?blVoZzdNMnJLWlYzak9TTnBTQ21SWjV5d3YyVnNqTk5XTTNaY1BBeUpZTkJQ?=
 =?utf-8?B?OElXNEVRcXJJTDZ6NVFVRHNGOHNVRFRpR3A5eThLYWhRdFN5ZWVDdWN5MHZO?=
 =?utf-8?B?RjNLdy8zWHBMcHZ0TkNGS1lKVExWOE81Y21PQUZxTm5hVDFoMWVkNi9RcjFX?=
 =?utf-8?B?TDlpSG1aS3ZjZGJmdlFVVlpOMmlwZHRIV0NVc1FYVG9kUWFxN3o1RFl6NXUv?=
 =?utf-8?B?aGFTcGptaFNMSUZ0dFZvS2Y1R09jN1J5UC81UnpyUFo0VWhib0FTc3E0TWth?=
 =?utf-8?B?TlExYk9FMFlmVHZURkZKUGZ4SFljeXBVQlJCcGtTT0lRV1VLeFdPQVhZYy9l?=
 =?utf-8?B?ellORmxPM2R4aG1qMUM5Ym1HM2hvbngyWTRsMUxBVnNHM0tmbXJUZFAram9C?=
 =?utf-8?B?KzJtZ1hjQUFVdytKMUNnWTJSMmphUFVQMFQ5cCthamZaS0k5WnhqZEdSZlNu?=
 =?utf-8?B?NXRmSXlZcjZtdGlwZkpnMU15UDIvYVlSd0ZqWnBTU0Z1bEU0d2lqb1VFYkov?=
 =?utf-8?B?K2w5cEZHd3Rld1NVVExyLy91U2RvRTRmdm52MkxzKzBUTWtNTk1CcENJTWZq?=
 =?utf-8?B?Rm02NjJpL0tZQ1lkSFhNUUtEL3BNRE5pbmJ5WWtnbVQwNk5wbFJKS3FUQmVM?=
 =?utf-8?B?c1pRWTFkcTdjLzZ5c0swM3BkQkJ5TkhBOTZ2MGZjOEwwTkpQQVFpVHZSaHpC?=
 =?utf-8?B?VERKKzlXU1VPSHdQNFoxcWRSb3YxYldhd2JiU0dETEl0SjFjbUxQK0tZdnI1?=
 =?utf-8?B?VU9yUnZnd1YyL3dPd3UzSFJ0RllERktNM05OcFNKRHhGN1JYSEwwZitTN1ow?=
 =?utf-8?B?dFFGRzBYVGsxdEZEbWlUQW51Z1ZqTGxxeXdxbUpMZE9TK25ZaDBrQkowcUFF?=
 =?utf-8?B?R3ZuT0hnQ1BvMnJ1cjRKMDZFa2pkRFVrT29oT1puZ1ZGV2ZwVlh0eDdkM1Vk?=
 =?utf-8?B?c0MvalVSMEgxRzN5VThkN3AySnVmQkJkTHZWeEkxQzZRbVJuZnEzMUFiSmE0?=
 =?utf-8?B?VklScG9aN2pEb1luWlBFVnRYNVE5K052TEIvV0VYYlVIUlFaSGozZU9ITGRV?=
 =?utf-8?B?T2VwQW41QXhlTEFFWGNZbnBLTHluQitVbzVESkppRDhIMGhDelZod3dqU3ZX?=
 =?utf-8?B?Mnp2TVpVK2J1MjhHQ0ZUeFNPOGdDSERsRHRrVEFCUDJWNENyVS9ZQUY1MEFi?=
 =?utf-8?B?UHlWbnZUVHllMmtUQTE0ZjFHd1FQbHh1ZGNxQWFnNnhIWDBSQTJtME5zSzRM?=
 =?utf-8?B?MGJMTUVDazNxa1VIN29Ubm9BSjJGUWZKek1BQ016UmxGNEs0UXByUGl6OTc4?=
 =?utf-8?B?RFZzQW8zWlhBRnRDMnRmZHZMRUU4TzIwSCtkRkNrWnBaMkhBY2Zxa21VMmxL?=
 =?utf-8?B?OWVicm13RDM0TjRRWE5FU0JvRDNDS3FXWHh5M1NBVThtbzFudTN6TnpQRFBs?=
 =?utf-8?B?UEljSEhHb0FDYnpiTE5qOGp2UmpLQTJUMXZKMTBvNWxSZ1lnSlFEWW5RQ1dO?=
 =?utf-8?Q?Z3Xcst0OSoywYSdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A782F42EA45BC4DBDB182E7F197E1E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rDVqTKXPOK43xNBKNZCSg3jUbMPvd+szvm6vCUEePZ+s7lpIQspsRx257JT6oHLjgO9tt6EXO7njlyhnE42JodEK5m0wqYw7qUVECjdFCSEAYhRUU5dG0GUwHJWivbVhgWVCAI/avRUrZ8uxd7XN9DG+V+U2OGwfJACuadHnSbFc8AOPhe6dsbhLSGtClIz75mmpPky7ExsCSd+E/7jPvs851wmXm9ATPCF1ucW2vNApwg9+pAFks/pokuffjmpKKOrWIXvNr0wVTkDkRPgB9MEy2N+aPuWV9NsYMoOATJ8U2lXTEsCqayCp4sIlYpsJcfQL682uv/xChaPZi1JeOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4296a2d1-9a56-4c56-110f-08df136b788c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 20:54:01.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mzNCJKElbuS+P903fuvdGHGqenGJ4Qycs26Gi1jBV6Kv7/ANKNKY5KXklcxy8WCHUjPx9USEcjyvasTwfsZcgF64xChD4NOkXRfsWwoKrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE4OjI2ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQEAg
LTEwMTIsMTIgKzEwMjEsMjIgQEAgc3RydWN0IHRkbXJfaW5mb19wYV9hcnJheSB7DQo+IMKgc3Rh
dGljIF9faW5pdCBpbnQgdGR4X3N5c19jb25maWcoc3RydWN0IHRkbXJfaW5mb19wYV9hcnJheSAq
dGRtcl9wYV9hcnJheSwNCj4gwqAJCQkJIHVuc2lnbmVkIGludCBucl90ZG1yX3BhLCB1NjQgZ2xv
YmFsX2tleWlkKQ0KPiDCoHsNCj4gKwl1NjQgYWRkb25fZmVhdHVyZXMwID0gZ2V0X3RkeF9hZGRv
bl9mZWF0dXJlczAoKTsNCj4gwqAJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0gew0KPiDC
oAkJLnJjeCA9IF9fcGEodGRtcl9wYV9hcnJheSksDQo+IMKgCQkucmR4ID0gbnJfdGRtcl9wYSwN
Cj4gwqAJCS5yOCA9IGdsb2JhbF9rZXlpZCwNCj4gwqAJfTsNCg0KSXQgc2VlbXMgaW5jb25zaXN0
ZW50IHRoYXQgZ2xvYmFsX2tleWlkIGlzIHBhc3NlZCBpbiBldmVuIHRob3VnaCBpdCBpcyBiYXNp
Y2FsbHkNCmdsb2JhbCBzdGF0ZSwgd2hpbGUgYWRkb25fZmVhdHVyZXMwIGlzIHJldHJpZXZlZCBm
cm9tIHRoZSBnbG9iYWwgc3RhdGUuIFBhc3NpbmcNCnRoZSByZXN1bHQgb2YgZ2V0X3RkeF9hZGRv
bl9mZWF0dXJlczAoKSBpbiBmcm9tIHRoZSBjYWxsZXIgZG9lc24ndCBtYWtlIGEgdG9uIG9mDQpz
ZW5zZS4gQW5kIHdlIGFscmVhZHkgcmVmZXJlbmNlIHRkeF9nbG9iYWxfa2V5aWQgZ2xvYmFsbHkg
ZnJvbSBhbm90aGVyIHNlYW1jYWxsDQp3cmFwcGVyLiBTbyBJJ2QgdGhpbmsgZHJvcHBpbmcgdGhl
IGFyZyB3aGVuIHlvdSBjcmVhdGUgdGhlIHdyYXBwZXIgd291bGQgYmUgYmVzdA0KaW4gdGhlIGVu
ZC4NCg0KVGhlIHNtYWxsZXN0IGNoYW5nZSB0byBzdGF5IGNvbnNpc3RlbnQgd291bGQgYmUgZ28g
YWRkIGFuIGFkZG9uX2ZlYXR1cmVzMCBhcmcgdG8NCnRkeF9zeXNfY29uZmlnKCksIGJ1dCBpdCdz
IGhhcmQgdG8ganVzdGlmeSBhcyBnb29kIGNvZGUuIEknZCBtYXliZSBnbyB3aXRoIHRoZQ0KZ2xv
YmFsX2tleWlkIGNoYW5nZSBhbmQgaXQgcHJvYmFibHkgaXMgYSBzZXBhcmF0ZSBwYXRjaCwgYnV0
IHdlIGFyZSBicnVzaGluZyB1cA0KYWdhaW5zdCBtaXhpbmcgY2xlYW51cCBhbmQgZmVhdHVyZSBl
bmFibGluZy4uLiB0aG91Z2h0cz8NCg0KDQo+IMKgDQo+ICsJLyoNCj4gKwkgKiBVc2UgU0VBTUNB
TEwgdmVyc2lvbiAxIHRoYXQgc3VwcG9ydHMgYWRkLW9uIGZlYXR1cmVzIGlmIGFueSBhcmUNCj4g
KwkgKiByZXF1ZXN0ZWQuIE90aGVyd2lzZSB1c2UgdmVyc2lvbiAwIGZvciBiYWNrd2FyZCBjb21w
YXRpYmlsaXR5Lg0KPiArCSAqLw0KPiArCWlmIChhZGRvbl9mZWF0dXJlczApIHsNCj4gKwkJYXJn
cy5yOSA9IGFkZG9uX2ZlYXR1cmVzMDsNCj4gKwkJYXJncy52ZXJzaW9uID0gMTsNCj4gKwl9DQo+
ICsNCj4gwqAJcmV0dXJuIHNlYW1jYWxsX3ByZXJyKFRESF9TWVNfQ09ORklHLCAmYXJncyk7DQo+
IMKgfQ0KDQo=
