Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340F257828;
	Sat, 11 Apr 2026 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872619; cv=fail; b=VyzFtx5IH42EfPj5+HmGiBSR8pGiED8LtNjJoyYuWdX8AwV4bc7VS+VAQ6McwkRmlTJFiMroypyF/42VUZSOgCSgK+LN+xVzPcxeCb2hOBg3Kulki/ONz5NFna/FSov2tEAJ5hbiB6ud1/j8G0F0zqjoJaTS9gbObeZclpqeRuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872619; c=relaxed/simple;
	bh=q+NL2st6C9nfEdbWhTyqrdlmHi1BcU/QiSF9utaBZCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1jBSKY70koqVJuIPEqm29SxfK+EHOiqh7Reonp0kFGR89cBY2VMWpiTUEaJDfmeph34pJQmRHUwX6/l5f9lPelU/59jUP3IVCHxHIvqi+kRO6OHK/p5NXJqV2Yb5f/WyQIAy1RkaaT+I0zKfn/EwNvx1aWm7PXJosWSZ04ojmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiTWDhWX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiTWDhWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775872618; x=1807408618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q+NL2st6C9nfEdbWhTyqrdlmHi1BcU/QiSF9utaBZCY=;
  b=JiTWDhWXsNv1D/aKao4q4NUPQGSLOMzd3bic0gdr80NIR9GGJatv1jYa
   wXUaDbb8y/MP/LnWscTRfNCmPYreaxbMNjtpjZmP8SGTYLtRrDCQajUIv
   TDIOgjRWVLJYnRSd2HgPLTwfQe0jeNhYoDZCMvZzsjcEy5kNNIf5VSBSO
   dgnTBBUBRQOan48b2Fd+1DBJWuXIOQ0wN7S4gBbI2kPfiBG949ePUD7KI
   MFBQCWgKNHdY7PmUGOPrpukSM/DJBdJIMAHWVzdZ/f63CcMej822joB3N
   kENX5LLZyxd6Fyn4Nq3+HWLDmtCqI5VRA+nmJVFipdRXJgVN+OEa/iFll
   A==;
X-CSE-ConnectionGUID: G7lTzp9LQv26hQpEycDz4g==
X-CSE-MsgGUID: C8BnJnVQQmSGAeXQBusfKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94471027"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="94471027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:56:57 -0700
X-CSE-ConnectionGUID: UOZ1NP0dRgSx9HmXIPLMiQ==
X-CSE-MsgGUID: jG4O4FruRAuc6DuL/JvI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="224524406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 18:56:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:56:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 18:56:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 18:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3przUZibPcBgOYp/piwO2ejx0KATHFQin6tD0JuaEh6ZL5FPyVjRIwWkZqB1zSojHyBWvaPSKFSLwC7krvPmDyiRVvU74MwbgACw6DUgAibLjUy6eliFavec/J3xYkTkn0ZbB/WxTvSaOJS33HHKdPke+s5IJXTj3EuDcH66f+u+pYb7iJ35xrJL/jA1jAhVnkqEYx29I0iTwE45S/EX6tUqDb0M6XKukLq2T3wZNMtGPno2p6T5a7ttT9kxaz6Ay/dU1ayboiEJAxmdWo8k/jXsuy79eje95MHkecBhJoIxJdnZRxwbtWritRQmbrSEKLbOdI6WmFUdhpIdbUdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+NL2st6C9nfEdbWhTyqrdlmHi1BcU/QiSF9utaBZCY=;
 b=AOXmlYjGmQfsRJo9deDz2bZbEWlqfqDJ5l/HZ6rlz/DeMmtna3VZB/ZmtRnN1dv/xjuN2x4kaY8DUnMvTeDjQG+Np/s0feFeqCgpfAGuEWMu6tPqLc53DI3QxTVpgl3agOuSnNB8MyhHJ8Gh2a6Mm93WuMB4/ne/FXcQtvSGEairrR7IJOnYtTVMf2p5SYRje1ezTWCx+kAg+D21opc01UjomR60dO2Y2yfAASQY56r4DaV6qcGkmSrKLs+F84oAEv8Ah0/9eh/ms0k5hrIFiurmI4uyFu7I6jeYkBN0/2JyRs6oZZvFr/1FTei2lHPFMH+nIGfe0ICajfoUI+jSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 11 Apr
 2026 01:56:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 01:56:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Topic: [PATCH v7 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Index: AQHcwQwCk8kg2MYL70m65kvCmvSerbXZKtQA
Date: Sat, 11 Apr 2026 01:56:51 +0000
Message-ID: <726dccd6d46d0bd471ec0b2f6861f8e45bade26c.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-13-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-13-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8717:EE_
x-ms-office365-filtering-correlation-id: d47c27bc-fcf2-440f-e034-08de976d9997
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dbbAgUdl1NV4ksVtlA68dWUmTmE4sZA8WD4XXfYF04pREyzrpy1kJrDCqGQfPsAYpw57NdbKwQ/OkGTNDbZ4ipUPPIc9YDeJyybC322yrJmumdeUcNr302aMeeAOHYlagCyGIdS2fDeb/PaZqBDc6VYb3zbADzhMIZffK6sob/0UnX/n7305q6JEaNEfBgkBGJb2y7gYl4vltd2Em9zc0babiKXxim7EGtsXstKWi5xkMlz2Oz0sjnr56YRhqfnQua/fg2kRAWsMHUerh3QqBDKjDstwmsONH+3GPingqlzcqT2Eus5M+kLiF4fWNdQk9fYqRQjasqR1E9Iqo+90P5v8thD52EZk0HhaWjDUs9w17Q9OJ1pALiJVntNfAheqkR1X+jx7dVWmkrGazwUiuzLJqOqTsL/g6FWZj5ye8O2KZ5OZUbzpBbwdO5/5h7IK5aDIkciNOgDTExMLeAxrYkUNSHHRTuYtShiyl973Fuji8Z4IVNdzej8kKqcQ0KclXHmW7r/mcjABe8AwGyI9JcqmfwwJOfO/8oXMTEjHrAxbXy1jwHJki68TJMcuRnQNflhqaazX+OlPuJU91k6IgJaLOjzk3WpKUB/KjnTN30yRUGVM7a006X2M7zpra2A22dkdYPhT+PD6qJcS3sbvIThzVnd9Ev1Y9boFlY2vquOc8S5uhMupzkRfHkbpEan94CHhd11F0Jn7iZJv5TDtBIPQ9nkTIWxLmW2gHRuEgJJj8uGQy6nsvdp0iBFk6bBaC04CKh/d0hJ/QcfTRLhfrIRQSlUym0zyhP3ARDKMjZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdlbHB0SVBVQVhWZmJhUFZja0taUDljM2lDOEdIenVxZGJrRHF6aWl4N3dZ?=
 =?utf-8?B?amR1Q1c4N1BCK1c0RmlYQ2I4end3b002a0w0aC8rV25Iam9LR002cmo5T3E1?=
 =?utf-8?B?eHhZWUFaczMzTnFvOXYxVzNaZGZCN0toeXpiMVR4UVR5QllURmxpaGY3Wmd5?=
 =?utf-8?B?ckpXL1ZCSTNCNjBUYk53MkVuNitjeGl4SkxHbkpoNlR6TThtM2NFcGhXaHV1?=
 =?utf-8?B?WkNPTm9qTjNMM01kTzRFRlFhTnQ0bTF6Q2xPZ1lUeG1JN21JczZhbTNMK2VL?=
 =?utf-8?B?ZUsxUENaem5HUDJtbDRpM2JLNUR5eWZwcldRTmpNWEthRW9RU294UVVOZ2Ix?=
 =?utf-8?B?VjAxUDMwdlRvd3Z6NmQ0UUY3S25rMC9rcStEdFlLL3pEVUtOdm81cDVIREIv?=
 =?utf-8?B?NS8rOGhGVHIxcmt6ZnZuTHZWaXkxclRVem0wdGdjOXJ3eTE3N2Q3cGQxWm9O?=
 =?utf-8?B?cVliSHlBTEc3WVllSmp2MDVrZDlPS2FGRWlnYy9KK0tDaktkbHNoZVJwS0k5?=
 =?utf-8?B?dEdLRWhMcy9MZCtVSk9OL04wbnYwSklRRE5UNVMrSjEwTG8xaEVCWFBTZHYx?=
 =?utf-8?B?RDFWNVZKNS90V3NjTTV6aU1TRUNrRmZtY3U4U2JMbHVDUW52ODBzZndxc1BF?=
 =?utf-8?B?Rnc0KzhwSVIwUkY4RTJUajlBc0hQNjFjYWdTVCs0OWZNbXFyVnVJa3M3NHcw?=
 =?utf-8?B?Y3g1UWU2S0s5cGF6N1JxaENJNHFzR3l0ekhNcnhqQmJLcldZZVJodE5VTkU5?=
 =?utf-8?B?TWdlQ3B4NmxlV3lxRGh5L1h1VE9OT1FKMDU4TWJJWlVRMTRVYUpNeVZveERr?=
 =?utf-8?B?MlJTZ3ZkdGhuUWIwTmJQQUdONXB1VFM4OUIxZ0tiSVlQZ2oyOG5CeHBMaUtE?=
 =?utf-8?B?S3JkZy9SeHJ1OU8vY1JrRTZZYlllY3ppdWdiU0dMc2taYlRkcWpGUnNmRnZp?=
 =?utf-8?B?SERaZHRsNi92UjJ3TkMwODV2M2w3MThWWnhWZ2RLczRmZzRRQ3d0OGhNelhK?=
 =?utf-8?B?MFpXbzFYZzFzUHZNb2g4VjJoYjNCSHA5alMzUWZyTkk0ZWpsNmhuMDVTemp4?=
 =?utf-8?B?TlBwTDlGWmRtNmVNMUlTZXJrS0lsT0tmYi9IMmd4UDVEWEw3SXhvdGRDNUdT?=
 =?utf-8?B?NnBRODRlbVg5aDdVL3cyWER2bjl3R3F0dndBeFE3K25wRXpDNEZWekcxTk90?=
 =?utf-8?B?ajgyb2YvN3RvQjZTOVVTdWgrYkVST3lmUVNLd0FsRDVOY0xXeGhVWC9YejZS?=
 =?utf-8?B?VHVZUWRsTzNNSCs1MVpEd2kxOVpuMnMvbUhCS0NKdkhaSXEvUkx2eWtOZlVr?=
 =?utf-8?B?YTh6Tk5JTVhFTy9HR1hkU0xDaFNobkpIU2VERjJ1UWIyaGdQdjlWOHlzbTN2?=
 =?utf-8?B?RzBWWjBCS2xWS0pBREMvMTNQVmU5RHhEeGEvOEJQM0xQblV4aEFsZjFBTU4z?=
 =?utf-8?B?OGRLckpPWnI0TlNNV3lxSmNEb2M5U2Fwc2ovSmlUblhpWFo1YTAxNUo0aUI5?=
 =?utf-8?B?M0ZUVms4cnQ5dFhRSTRxWFJGTHMzRWljcHh6NDdZNDRWM1BhR05GTS9tcGJN?=
 =?utf-8?B?ZEUyQXptWUYxcWcxUVdhaHlrc0xtQ1huck9kOCt6UkJ0akhVUzVrMW1QQmh0?=
 =?utf-8?B?eGZDYWVoWGtvZEdlT09TK1pGYVZVeUxGT2JjT2lKdGF3MHNLcWFPS2xUeUUx?=
 =?utf-8?B?dUFOeXFscTNsWkxvcFVOL1dSOWZac25nc3hFL2xJWitoWHhQMGowMGd2Ymh4?=
 =?utf-8?B?eS9ZR0FQTTFPbDh4WFVyUUMyNVIxQjY1REsyend3MGh3TmxsY21KWHM2QUR3?=
 =?utf-8?B?WkxLS2tEVDFlVG9Da1RScWJ2QUIyL29TQS9iNmx6K09nOWJTMzMxbUltWm5X?=
 =?utf-8?B?NG81d2VYbVVZUDFNbW1PZ1BwV0M5TUl1UW5EZnNScldQU3RyanJnaWlSWktw?=
 =?utf-8?B?WXovT3Y0MWJveTB3cnk1N1UxUUxCSE15UDFtaW5HYytvZU00UkN2Q1plK0Ra?=
 =?utf-8?B?TENMZUUwWSs5ZTRxWmVLMFJDWU5wb1RrdUJaSlo0UUpJMGF3RUllR0hoTHcx?=
 =?utf-8?B?amVSbkNWYU1tR0FEeDVPVTIzT2ZnNVpDcjFaaTdjdGdBWDVxemFYcENrZGFt?=
 =?utf-8?B?YnQzRy85ZXVTL3RGNkE1eVMwaTdKWE92TnEwN2lHWHNSQmhBQTR4MGdabHpI?=
 =?utf-8?B?SzQwNjBoNjhRNis3R21RVGR5MGlkaXhvZCtCay95eXpxT0Z1cEsyelE5MEc3?=
 =?utf-8?B?VUFsOFhhTzFQeTRUaUphYloyeTlQUDZjOW5sNUs0NDlyNVhxeTdldXI4WllR?=
 =?utf-8?B?YWpHdEJ5WVRmSkpKU1FjcTRKR1d5TGVXR1dBVDh6eDZEMUtQbk9jUy9EUVhm?=
 =?utf-8?Q?dBx3WcNDW1kdM+Ic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <739401FEB3BB02478C1921B44B6B8A98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iNNxFHEg2q+hSw3PpLLDGc3LQFN4OJn77hZoTNsDixtGM0l6/fUrrZ9GxgvedsweMGTJA8b7M03w6vdJEp9R9yj9gmhNlye4Mw26R552+M2W4qK75GtMbkwFBWJHs9bUBqFLRMu3CrosUkKrGTV23VL/YLe63h3E59CCoNHlNnijsVmi0hk7/MiESkTChLpU8nXtam+zE1IdhrUGmpZkJq4k9JFG4xr9m9g7EvWsLSeE2ro+iAt9mUICr5drwUjvFrqX/LP/yg78IIJZqMGS56gxTxBecCyJGuzA54JMg7Z6FfQFb1xxeLzu3lCfZ9befBrpii55IRycM4FuvE7WLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c27bc-fcf2-440f-e034-08de976d9997
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 01:56:51.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVKusMTbTHCNEQSwAb1hcNcLInY20vgZBGb42O3HPBoNaeqfgyekspIcNxYUPAkoMImu/SMSdVHTd6Nxa+45Q3OF0udq9fEUIWoRlBrHhBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgcmVxdWlyZXMgYSBvbmUtdGltZSBnbG9iYWwgaW5pdGlhbGl6YXRpb24gKFRE
SC5TWVMuSU5JVCkgYW5kDQo+IHBlci1DUFUgaW5pdGlhbGl6YXRpb24gKFRESC5TWVMuTFAuSU5J
VCkgYmVmb3JlIHVzZS4gVGhlc2UgaW5pdGlhbGl6YXRpb25zDQo+IGFyZSBndWFyZGVkIGJ5IHNv
ZnR3YXJlIGZsYWdzIHRvIHByZXZlbnQgcmVwZXRpdGlvbi4NCj4gDQo+IEFmdGVyIFREWCBtb2R1
bGUgdXBkYXRlcywgdGhlIG5ldyBURFggbW9kdWxlIHJlcXVpcmVzIHRoZSBzYW1lIGdsb2JhbCBh
bmQNCj4gcGVyLUNQVSBpbml0aWFsaXphdGlvbnMsIGJ1dCB0aGUgZXhpc3Rpbmcgc29mdHdhcmUg
ZmxhZ3MgcHJldmVudA0KPiByZS1pbml0aWFsaXphdGlvbi4NCj4gDQo+IFJlc2V0IGFsbCBzb2Z0
d2FyZSBmbGFncyBndWFyZGluZyB0aGUgaW5pdGlhbGl6YXRpb24gZmxvd3MgdG8gYWxsb3cgdGhl
DQo+IGdsb2JhbCBhbmQgcGVyLUNQVSBpbml0aWFsaXphdGlvbnMgdG8gYmUgdHJpZ2dlcmVkIGFn
YWluIGFmdGVyIHVwZGF0ZXMuDQo+IA0KPiBTZXQgdGR4X21vZHVsZV9zdGF0dXMgdG8gRVJST1Ig
dG8gaW5kaWNhdGUgdGhlIG1vZHVsZSBpcyB1bmF2YWlsYWJsZS4gVGhpcw0KPiBpcyB0byBwcmV2
ZW50IHJlLWluaXRpYWxpemF0aW9uL3RkeF9zeXNpbmZvIHJlcG9ydGluZyBvbiBhIGZhaWxlZCB1
cGRhdGUuDQo+IFVzaW5nIEVSUk9SIGluc3RlYWQgb2YgVU5JTklUSUFMSVpFRCBhcyB0aGUgbGF0
dGVyIGltcGxpY2l0bHkgZGVwZW5kcyBvbg0KPiBnZXRfdGR4X3N5c19pbmZvKCkgZmFpbGluZyBl
YXJseSB0byBwcmV2ZW50IHJlLWluaXQgYWZ0ZXIgc3VjY2Vzc2Z1bA0KPiBzaHV0ZG93biBmb2xs
b3dlZCBieSBmYWlsZWQgdXBkYXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNo
YW8uZ2FvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnkubGlu
ZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVh
bmdAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KDQpUaGUgZXhpc3RpbmcgY29kZSBhcm91bmQgc3lzaW5pdF9kb25l
L3JldCBpcyB2ZXJ5IHN0cmFuZ2UgdG8gbWUuIEl0IG1ha2VzIHRoaXMNCnBhdGNoIHNlZW0gYSBi
aXQgc3RyYWluZWQsIGJ1dCB0aGF0IGlzIG5vdCBpdCdzIGZhdWx0Lg0K
