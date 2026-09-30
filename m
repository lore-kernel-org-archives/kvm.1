Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AF3B14D4;
	Wed, 30 Sep 2026 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806651; cv=fail; b=ZbjJ0m5nqxt/EZzUB3NqK+YSNlbvfxdYvQ/KI319P14DneEbiNyjpoZTZbdhJwlB7g7uOnImxdyQag+K0MB9dbVwsGq0AYj2fajzOFxWm2P/3X2lPUakxapb09UGmkuQS90yoo2LJpNIBM9BKvishg4aVPS9nu8AX7S5k72AwQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806651; c=relaxed/simple;
	bh=c/+Gaz5T+rNT1AF1SFNZZw0cEbBDPIojjP6lwoAH0wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTQND6/wcobvGQG9HZdsR4BRew2tXrqJrRfEeKt3Kd79uhZM9p2uq/INWL3ZJulHAHiCBq/aXd11QfVL5i1fXhh7jPAfG83qEj8AM2O0Scwi2JhyuuEqc2dO0CFnR4086kB2435ckVsu687QcXoOffydH2v8xxC2sy/SLoV45DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2LBVvnS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2LBVvnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790806650; x=1822342650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c/+Gaz5T+rNT1AF1SFNZZw0cEbBDPIojjP6lwoAH0wo=;
  b=P2LBVvnSFcC3g0y6JxOP0O1N9exoE9G66h0Zt5/EiIPYEih1HEoGpElZ
   ODF2EDw98DVZ0D8RGI/PEjepfItV+1LGjM1vzk52SyV6tluq9hfQZHSqy
   6P/G2JWOQXoGhTya1JZch4aIRZpPI0/6OxMgFy6VRtQGshj81uJ+kJNyd
   lQeqiwT85FtBYcE1N+o6wCRPlhT93GVNQG/zb5v0AhMyUm6V34MPgCB1T
   mBnL8gXjQyLxzBZkezLVJFvHPe83AzuHSDJEwh/xHtRzJfAIu4s9feZak
   M9pzSc/OE43DGLxlyve+D8srqDQpuR59V2ix+cQEXcguz9wcrMADo18qW
   A==;
X-CSE-ConnectionGUID: KkgZA2TSTLaxjPbSdwI1jA==
X-CSE-MsgGUID: Il2eKugTQYWzEu0hiSy7Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102129909"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="102129909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:17:29 -0700
X-CSE-ConnectionGUID: 3hvsyjl1TgmYhbHvrMM9PA==
X-CSE-MsgGUID: BgNMaO4/T/2scs4faL5UHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279116676"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:17:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:17:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:17:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaRRvSMPVlhjGZRYcK6HGwDfi6OzxT4hb04rMJSod8gZe5P2hPOBxoPetI4InyNoFAAqwiMCNvBJvQtRrJ7hNjuNllcSfJ55xIFGnGosYktkY20xiTv9jvRH21vWOGSR4WJUtEUmenZ4yYaO8wTT/WgX1TttkXeSOVP5HlR23u60cN4aWKzJ00i49GGymyd9Nz5Uo7w6+nMTJar9kZ9LU599oe1MVGPCWBaXwPW+dRawpRlsI0O89GzD6JO1bwatIusvT/8E+JBwCMm+07GZhQbHsivjYf7olsyvUZYZKct5gSI1jjsI8YDncWD9D60A7lXbCJ+q55PTUR1FVqpS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/+Gaz5T+rNT1AF1SFNZZw0cEbBDPIojjP6lwoAH0wo=;
 b=KWlyBj36SE/9ROmSLBJxAVnMiz4xs/zV1SLH7ozUCaqz/jT1KxChhCtWBWFN/BnzqE0ir/F2bAaTzBSLW+eMrUV8XENmWsz73fVyH1NNvAw++XcD4AyuliVoBlZkUdbnk1kVnSuEW9GMfRCn+T9OdJAn4ZOEPaDCK/6z+sznyho8Mq1iUeFSfHieqVj1Mi/jz5m/YyRMf/Um/lb6T2mBIFND9Jja3bnhc+nZxG7F8YkRgF4Mj6X/DlFpieGqu46KJVPyGxHUZknOWLCxlmzqF18M9TWVtqqEV6TpijcjFbwLQ6rsJUcLn8sTJGQOIfSPqgscDcFEHxsiMH296/N6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:17:26 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 22:17:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v6 0/6] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v6 0/6] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdUMfKNvM0ih5t6kmqVGf+KKEKBrbnsVqA
Date: Wed, 30 Sep 2026 22:17:20 +0000
Message-ID: <b0608ba835890246be2f70b3307e76370a949729.camel@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
In-Reply-To: <20260930103739.2851980-1-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4639:EE_
x-ms-office365-filtering-correlation-id: 466bd2c2-9a5c-49b8-10e1-08df1f409848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kWnpmsG1LCyXVtqNqshwqI7/AE1PubAUFUxY/XakwjOQZXHqlqgM/Opp6F02ix5uii27FepnFAs+hOR54HJxHY+Y9de+oaLPUAGwuEtIgJIaxyYHVdBt1P6ZxBWVildH2Fm6USpUuo4WjONppzjnY8bl4M4nx+A8+6m06OImHDuccMAWzJPznT4oJANIabKHxvrVc//VWrFHMPyaPTQ+/Y0ad9CFJkhnlYhOkEIJiHBeVUPRso5yF8e+B7wqxgP0tCg4lE7rbpUZVr1LweuJSEihMrk3BG3OE95P6rccxQm/nYCTMxjVwGwMZyCnfARtwIEebORXw9s+LY5Z6kyc+BMUxzh102KKjsElZ0FKxb3y4p1HljYmFT9hOmWWhSm8v/16wUbmn9pTBQy7ikx9vAhGwH4eCqgRS2JEFuC3YQLdg/HE/R3hIszp1BA4OboKf9EQ+PLnGi2tFnWukTmqenI6LMm+yAHp1OjhW+RsdojMe0YjpuT/coIWC9BPC26hHXAifT+tC6G3Bsf1pMQrzD9ZdNx56ocXpgdYwmvPNwncllAvkDMIaDhE4nErOQIZe3lTzRyWYUV+KsZrd5mX+6rZ330c6xW+MW5GVCzGkR/JfOpFtKk4FwJLZvfOgt8Vfso28ZfL9/5JWCXBC7NmPnKF4BB9NbRD/FLdxY8N0nBhraoWLVTlYRGkZ9kNnn7SvckAVQlo0YVMyUI9bQXgNINln6jf1cL4eKgReuzm1ns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnVUSE9Yb3Nja01PTXBROG1pUVM5YS8rT3F2NjEvOTBoUVlsR2gveUJkM2Zj?=
 =?utf-8?B?WXpQbE4xY0VtdmtYeTlaZmV0TjJKUHlqRjMyZ3lzRDlGTllSNVByMHJMMWNY?=
 =?utf-8?B?UnRnWXhHV0Z0OGplY0FVQ29UNCtRWlBRU3plQVNkSUNXbGtvSEdRSlRvRWor?=
 =?utf-8?B?S1ppdzJXQ0lUemg5OXhIeGowNUMwMDdQM3p0ZVVCNnFDanlLdExQN09ZVlJS?=
 =?utf-8?B?NUpvTm41aUZodWRWNitFdjdGczVFcGM3aHY2TldrbGFTOWpUNHNrd1poRmdK?=
 =?utf-8?B?Vk9UY0dVRzhDZHo2YU9lYWVWYm5kQnROWTJWaUZ1NHE3RUZqTis4QjIvNEoz?=
 =?utf-8?B?WXJQVGhsYUpQdDV2YnF4TURqd2s1OEJNSjlaN2M3SXZmcFhlb1VMZjgxbStO?=
 =?utf-8?B?VklHaEsxQXpUbDFHZEpNZG1SQXB6d3hYZTc3bVE5NGx3dnd5d1lIeTMzK1FT?=
 =?utf-8?B?T3ZrclZvdkdSa3o5UjNsem5jdmtYNHlvMldEOCs3WEhtL0JnMmFpd2pxSllE?=
 =?utf-8?B?L2dJa3hqNFlxUTBrV3RsdVVHeFEyWVJ5dFd4d0FiYnRTcXVFTFVHeU5yN1VZ?=
 =?utf-8?B?T0FYVDJXUmFnNWpQZzNydEZFT2l4R0ZsVUw0QmdxN1dnMjFFbG00enFVa1RO?=
 =?utf-8?B?d2hCRzRkaDNXUXM4bTZ4QmF6S2djYVBhQW0rTk5wTVZ1clpoQWZxYnE5Y25X?=
 =?utf-8?B?SFc3akJOL3Zma0ovSXlzdy9YVWM0Q3k2eXhZK1JhSWFRSjFIWVFZSkYvWk03?=
 =?utf-8?B?Y09HZzhWY0krRlRzTmJ3ZUVIMEljNkdBa01IbGlpcDVRa0p6anhNZEtrSXd5?=
 =?utf-8?B?RFE5cnRLRjZlL2YvTkRqQ3ozM0dnNmdYOWFMRDdFVW5DWUpmMDFaaHZSbm1p?=
 =?utf-8?B?VWlUa3hBRXN0d0tVU2RlSVphYS93Qk52YkRHblZ5aExJL2lVNFZINGdPNUJy?=
 =?utf-8?B?VzZnYTkvcy9RWGZVMmxvQWxRZDArKysxYkY0R3JZWm1KTVYrQlppbWtwNUoy?=
 =?utf-8?B?RnFHaE05VDFMUHdvMGgxSE55cUNtZ2c5a21BU1NPS3hZMUNTanphVFRBamNU?=
 =?utf-8?B?VmpXQ1dUZ1VBZEU4R0QvYnprelhtajBTdXU5MUx0azZJaGtYaXpDQjBLUzc5?=
 =?utf-8?B?MDVqOWFOZVFDQkJwdnRnb0ltaFMzYnY5WTNBdzJVQWZncDV4YzVpNzhQK2N1?=
 =?utf-8?B?YmJMN2pxeVFTcXVwU3JaYTJqUzJaTEpzUG9HZXRlY01hZ1hLRmt5eHBMWWl5?=
 =?utf-8?B?OVliOG0za3NDRmNpVUZLbG1ZZnRlRXlkSkd0dmswUW1JenN3TnExL0NZSzEw?=
 =?utf-8?B?bDVLR2t5RWdYNGxjdlluV2FFVytXM3dKSEdXdnNaS0NpdWRNaVh5aWMvRnFN?=
 =?utf-8?B?MUZoM29OZDhVVDRVM091U0puU3JOeUYvMGY5WisyanBrdWdnOWRBQkpEWThW?=
 =?utf-8?B?ZU9BNUcvZ2ZUcFhrZDllTm1lWTZ2bEVsOTVkYUU3eXFmekF5NjQyUFVxd3J1?=
 =?utf-8?B?OXFwQnd4Vk5PK0UyNUNYdFloaElncWZsZ1pDMm5DUHR0RGNjSjZQVDhjc2lY?=
 =?utf-8?B?Zkxsdm4yeHByNEhMZ3V4UFhxZVRSQ2dQaEtZK204dHJyN2dIdFltR1FkeThz?=
 =?utf-8?B?c1l6SVgweU5jbVV2QmNIQzhvN1RpZG01L0dwUUVObzY4WlFMdUxsK0FrazVw?=
 =?utf-8?B?bGpBeHBnOW5kbW9GbndjblR1ZWRPZGtyYy9lNmRsSTdrdWtEMnB4UHZCS2k4?=
 =?utf-8?B?OHgvREwvRktvR0FGdS9nNnRSMWEwMklxQVJXVXg3cGVURWhlbjVId2E1bU4w?=
 =?utf-8?B?R1V5Mm1oQzEwcVQwdWxDOHRsRTJneGdQUnJoL3U4UlArcUVwZmlZQXBvVCtp?=
 =?utf-8?B?VjVVaytKUmhJbGthRGxSaWYyc2FoVW9LUnlMM2Rrbm80NWJOcXlSMEpsNndG?=
 =?utf-8?B?S1RwY0lCN1JsekErOExCay9LU0x2U3J4YmliRWtFN1hXUFUyTUdpRzZYenZI?=
 =?utf-8?B?cFBKU0hvTFlqeXlKZ2RZM0c1R2J6bXFOUElJMEs0UVhGMS9PK2FhVDRUM3d2?=
 =?utf-8?B?S0taTUoxbllCT1RPblA4NVRjRlg5WGR1MzE4R1FxR3E4YkE5MncwT0hLOTNs?=
 =?utf-8?B?NFV6cm5RYUNhN0ZHZ3JzdkZWYmQyT3RjOWxuR0t1cjd6V3dka1pMU292endB?=
 =?utf-8?B?dlhVUVRjM2VlSlNvWWNsOVhLTDMvcTFpcnQwWUcrT3QyQ2F6SVZsTUlDNVQz?=
 =?utf-8?B?NmdSNThMYlBoZVRxeUkzckEyaVRVYWtKN0lWMG56NDZBamlFYjhtTHRBb21V?=
 =?utf-8?B?MUNCUlF0Ry9PcTFta2ZwYVBOTC85MFoxZDB6aWRpdVpsVWpRa3JJcE1jMXVH?=
 =?utf-8?Q?THnTgYpgrfc+mw58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ECE61EE7835984081A72DEA78660218@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ov70/DF9wZiyLx3Ju/vmdCtGVpIFgq3JJAdele/HZviJU5Kiym2s8pvVhlscg9MBeAfQr5f/ZUzCCD+mQRC9Tmj9rE9F8s6HTnqW4flk1uqSmBqJLlQ0SsDW4omoXtoOKwCJEeIaJefOA5+18MXHIWKIQ8Q9GHVmINNIMthKu6yGfgy29ahHfdG0lvgLLUGILq9uGNe3e0N1F2qKhv22yGbs5OiVZFpXnTtYSRMFEIrkkemWmQQCwwVI+3UqsO35RfDBVCWzMj8LHjBA6Tq3R2cylu5OsRoc9dNa+s31lASt4dg8vVJtySIYXm6WsHqZMtej0i7D9jLS7zSQ0oA2MA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466bd2c2-9a5c-49b8-10e1-08df1f409848
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 22:17:20.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUXxSZnFu1naSgD13wYMsvuWv/4x1GjrmqJH3Bw0k/06M8wbjHnigw2Hq+qUrm+vEEhbwrpccKIXkcRTHCJXoXsCZud2bzYrNknXj9RH5D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDAzOjMwIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBQ
YXRjaCAxLzY6IFRha2UgdGhlIFF1b3RlIGJ1ZmZlciBhcyBhIGdlbmVyaWMgcG9pbnRlci4NCj4g
UGF0Y2ggMi82OiBHaXZlIHRoZSBRdW90ZSBidWZmZXIgYW4gZXhwbGljaXQgdHlwZS4NCj4gUGF0
Y2ggMy82OiBDYWxjdWxhdGUgdGhlIFF1b3RlIGJ1ZmZlciBzaXplIHdpdGggc3RydWN0X3NpemUo
KS4NCj4gUGF0Y2ggNC82OiBSZWFkIHRoZSBRdW90ZSBidWZmZXIgc2l6ZSBmcm9tIGEgaGVscGVy
Lg0KPiBQYXRjaCA1LzY6IEFkZCBhIGhlbHBlciB0byByZWFkIHRoZSBRVU9URV9NQVhfU0laRSBt
ZXRhZGF0YSBmaWVsZC4NCj4gUGF0Y2ggNi82OiBUaGUgZmluYWwgcy9GSVhFRF9CVUZfU0laRS9x
dWVyaWVkX2J1Zl9zaXplLywgd2hlbiBhdmFpbGFibGUuDQoNClJldmlld2VkLWJ5OiBSaWNrIEVk
Z2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+LCBleGNlcHQgZm9yIHBhdGNoIDQu
DQoNCkhvdyBhYm91dCB3ZSBhc2sgRGF2ZSB0byBsb29rIGF0IGl0IGF0IHRoaXMgcG9pbnQ/IEhl
IG1pZ2h0IGJlIHdpbGxpbmcgdG8ganVzdA0KZml4IGl0IHVwIGlmIGhlIGFncmVlcyB3aXRoIGFu
eSBvZiBteSBjb21tZW50cyB0aGVyZS4NCg==
