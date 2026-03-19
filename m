Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836B3EFD3E;
	Thu, 19 Mar 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941280; cv=fail; b=Rmw1IEObsAlTJSrMdU2o65KqHfH9hEFEsqxkGwFIhkswkKRyR7pfPmGuye6WUu783KlyaAx1xb0P+I//BYnK1LgvIuLmgCTIVVNVneox787CdPoQjxdTLxeORSqnmOe5+s3NHqY3qgdAPSUEVDX9zAsISf17w6JtGG+3UnI5bIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941280; c=relaxed/simple;
	bh=86hB9qiMhQtAs9Pyz35pTXqUNikzHeLt1D8IItoCDn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDOmrq5ppxqWHvUQyVIfo/ibyvMwZv35xaKjpEvuedjYjyZjSosjP2cE0XV0teb5+mxDh1fQc4UF8uSnaU42pd78UnNifX03RwUF/dWgG7NrotMf5tXap4GGNvx+uhs4Hyu4cpNbYi7BzB6Lktfe4gi8wOCNsx1jAKVIQ7xsrhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVOKSCjn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVOKSCjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773941279; x=1805477279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=86hB9qiMhQtAs9Pyz35pTXqUNikzHeLt1D8IItoCDn4=;
  b=BVOKSCjnCe05uYmO/XrQAhRrijhT2R2Vd0sKSJ7hzUvux5YPxROCpO+i
   g3Gf1E/8pVH6u/8ortDmbrdzzgXPpQeWz/SXuQj740tga5HJm3GjMSkke
   Ff0l139GBBerBLjE2gM3t6fBLKpqeE5VHVsLKIdhlr1PVz44xmPHDbPhl
   qHn+K7O6Tm4uQrnjAqpesn1URRCnSicEJEJ2gryQ4uv13Xhjs3LlRyyYu
   JlJ5CuXMIxm6pdEgpIcom4nnDdTYYyqeJ7Nj9Cx8ANc+dO0rjPDY2WT34
   pM6qur9XJ4YdFZwbC3sZ9Sd7CXYjjnWbQ7o1P0mJFVzUsFjxTCynacr+V
   A==;
X-CSE-ConnectionGUID: yvxf7zXuQqytrHRqg/gsKQ==
X-CSE-MsgGUID: 8Br/RaDxR4G3dISXkeXn0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77626775"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="77626775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:27:56 -0700
X-CSE-ConnectionGUID: A67orBvqQr+0LR+qRs647Q==
X-CSE-MsgGUID: Jq3sZt3ATPeejj4ZLHWezQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:27:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 10:27:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 10:27:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 10:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYQQ3qo+CQDhYdjrewxzbzTH/ycmqBsIKTFtEiI6wi2VOTzMIEWDe8QPNLfZMTbxB606A3hPULRnSzfqFY5t48hpN1h3LfiEfDPry1Zz3Crgdw0hi8kDaCzZYkcq0Y+Z3+UmABJ/yss4RlGcmbgve8GAE2bQkKGE4zR5yIQb+jW2VdSmv/mNuSiGuyBBQcB+mVKuvytk8Ril71xKqVUOV3LiO5xGMnDwARx10nyAV7R6isI4CNXIvRV9/Lb9eksHjg4n9xPD0oT7/CHaxmuCX3sfQaca9lfs4FAAMxY6s2s7Q1oW2MYXstA0p7Au6Bn5VDlTIQh1p0o/ddyXGb1Iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86hB9qiMhQtAs9Pyz35pTXqUNikzHeLt1D8IItoCDn4=;
 b=gyKccmGrbWLpcpVV08xAO8tBw+stFlMT6Kki5CKiJbmXcvB+WvKdrM1aBaITS+zmccKxA61RTv7vNOGzs0rsVjI2FDDWRptR9d+hausyiLS/dhzQ4mO0CbgV7UmU8kWhqAQQup1u8nkn25/9uJEFVI3L2BM94SYxOjYgoJyWCHNfu50X61drwAUUBbfg1/cxduT8dh6xGyygWWScWt3Q0VhmtvtexqZ8/EUIbsP5fnH2hIIsjKpKVXTPVXgeeFap97btXh7tFXAzMZO1/M/6rhO+b1qj2VuQIxDwGPdI7SP0wwMaT/enRuq56cYKhbrnUmZw7DgvaGxk0mTAm0fv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 17:27:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 17:27:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LW1qsAAgAAWiYCAABAogIAAS3WA
Date: Thu, 19 Mar 2026 17:27:48 +0000
Message-ID: <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <abvR2A19S4ZtpAli@thinkstation>
	 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
	 <abvxiuJfK2eM_1UX@thinkstation>
In-Reply-To: <abvxiuJfK2eM_1UX@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: abe7fc3e-125c-4184-6908-08de85dcd76e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: MWBGNoMdaZBGW/bYfrp+ph+uLbh0+fSHuLo72IY8bGzW1zKZed5hwFVf5/yBSbQUGiQoGJmqi5vCDwcgv9DgPEUOLSXNwJR7rc98/ajLb6LHDZqSYgXnWUISBWj/4a7EwVC0zKAouWmaMlV4/eao9kBjOZRm4jbkZ7anEWIGUmUPOwYbVaZJ15HjI7g1jFjFSQB3rQ9xudnKdqvdxufHGm45xK9/CPDDAe/APAQLffNXNmjGblVofIUxrEcq5JuCT6eqjC662PEe0YWYXPOmtNFAbxM0d3kzT8d6jPDavSqZdvsCjWYXHKlLJ6Nvxs7dXN6s4RumxlI3deT2FhhSWri43r+HcnFCm26rll9uPLEEb4whsfu+ra1rgae+H+NZuRPCcVxcQjJoHJVH5UXt9Pp4ic6+Blf+t3vYAAREq2bNTbX0ZGuDKxIhMl/HCg4rX2F9QLgtd1pYTykvece93iDcHAbU/IC1RYut+P0SX40Af/zFh9qKae3zBO63sQ+/8oXPz982gGx3BRua+r3XVXAmqchOsyvWW2mEthwImMnN4Z9aPOHVWIRcoFtmnQ3/ot+DIyS7qlNBJSUX5+i28x2yQ6e4LXrIFum2QF21//bfk7oRndqjZdn4+d8goiomd4nouNtnENnB1s8UxQQ3GX19N6YV9StgZZcYKzDkPQ14AMnMiOttPFTwTm8cnAkC5jS5q9YF2Wul2JlrZazScop53Xuyn6ZZq6nYzc9eTNkMwyqOihVfnRn3MwVOm2dGebi1MbLf8//xOCi+47LgoUDBEDDQnp8Nc0cxNZ7hjdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3pQQW1uVDZMTjJkUGx1VHVzalpTRGE4S2RKV2xoUmlKSXpheFlhamk0ejkx?=
 =?utf-8?B?RVIrOVRnNCtFcTZOdU92THFXQ012ay9vWlFPYkxQeDcwandQNFlzMENLSlBv?=
 =?utf-8?B?SVdHQ2JMc2V4RmUrQ2Q3T05uVUhaSmIxS3RpLzB2eEQyc2JJbXFIVUhGNXlq?=
 =?utf-8?B?WDVoYkFvUVhJVHRxVldmV0drMm5NRlAxek1GVGNURGYrUWhoejRJeWM4ZG1q?=
 =?utf-8?B?ckw4T1hyMVJUYStYajhLY3luNGQ3Zk9kQkV0VjZPV1JDTzRaK2VEdVIwaDMy?=
 =?utf-8?B?VXhWYU1QdWd6YmtoMUNsdGFLOCtmZHgxV0pPNHkyY2N1YUZXVGhySENNd0ph?=
 =?utf-8?B?L3ZOdGNZek1NUTRvQmVVb1pxNjdwek5aaUpEd3N5Q2lMRWdMSW1VcCtEOUYx?=
 =?utf-8?B?bGtHbmRsdWIvOVFWUkVFKzV5NWNNck9LYThNRld1b1Z1S2tMbXc2am0ySHJO?=
 =?utf-8?B?SHpzZ3RTWHh5cVpYbnVCRkcrbVFZUFQzSHBiWVIyQWRVSzhXbHVGdWIrQXVV?=
 =?utf-8?B?dVBzSHJFczhCMFZHZk5EWFl3TXJ6aTRwQVJ3U2Zyb1YzdGI0bnlvMVBzSTlC?=
 =?utf-8?B?Rk1hdUVPZG1vcjdwSUVabVd2emVFb1IzSWZSQm9zQ242WHBDRWNOSnExQ3c3?=
 =?utf-8?B?bzhrbDRWMlIxUHoyckNHaC9SWUdsbTBIRzh3V0hzZm5ONVc0MWE5RURML3VE?=
 =?utf-8?B?TVEvQzNPR1JLN093aEJlZ0RGNStzRzlSN3RDZXlwa20wSVZvUjdUOE84cWpp?=
 =?utf-8?B?U0JleHdTT0NWRFFJR1preGxkWmsvcVpLQ2cvUkgreXNZeDZ4Mm1ZcklFbi9t?=
 =?utf-8?B?R0MxKzBtN0E1SjhSN0g1TFp3OXk1d2N2bVhKaEVSeEo5dTdyTWJNcmN6dnlP?=
 =?utf-8?B?cWdqMlRpZVpnc0w2Q2g4WlhMZldCK0RqTGZZVFgwZkFPa3lWWHF5ZEtVcEIw?=
 =?utf-8?B?dzkxa0F0WG5KSXNhOHRTdy9CamhHUnVTTGlDY0Zjc25hOU5vUjUrMk1HWmd3?=
 =?utf-8?B?NXJTZ3hnNThQYXFjVS9yb05tN2IxU0dYU0xkWStrQ2t0NGo4RkF2V3ArOURn?=
 =?utf-8?B?Z24zak1xZ1JPZjBIU2JwaHBlekZDeEovNGRpUTJCT05wTlVKc2lpR3NPUkE1?=
 =?utf-8?B?TmpOc0RXdXRyd0JPbUF6R3JqakFDdStzejNoTkY2Z0FzWXZydjZxMDZRY20w?=
 =?utf-8?B?Y0lQMDdCRyt0ZUhWck5UZDFKanBxNjFTZ1JMclhsVjJJejhDRzFXTjhsaTdI?=
 =?utf-8?B?WHlWQVYwd0NCT2gzRGlrKzR0c3pUREJNUzZiWHV0SnNIQVZ0emlPcFNVeEdz?=
 =?utf-8?B?YXZxR2NkMnlsaU1tYTBNNk54ZzdLc0ExOUhhN25yWlhER2VBcEFnMDNSMXZj?=
 =?utf-8?B?UXF4MXFkeHY4TmV0ZC9mOXk2WXdIa2owbGFDMVdHRVFnc1dVYlJFUnJTSmI2?=
 =?utf-8?B?TURSOEpEWUlDRlhhQUhBWlZ4OStlaGdBNjNsTUJpU2dhYmRNRFF3QndaZ1BR?=
 =?utf-8?B?bU9NS1VKQklRS1gwaXR6RUhVYVh2QjlKN0xrYWdnS3RQNlpWalNWTGowMThD?=
 =?utf-8?B?OW9MMDhJMVR6QzBVSS9tRFNQRjZOZWh5WE5IYUcvY2lxZkcrUVJIK0YyaHJ3?=
 =?utf-8?B?TmZ4VHNOQnpIOEkyN2NJb0JLUmRTYkI1WDQ5czRVVjBQUzcwektxcFI2Yldm?=
 =?utf-8?B?UzltQ2hzSHh4WUs3RElIVWZXQk9KZjdzZXRBWFdkL0xkZUkyc1pWOFJrTjN1?=
 =?utf-8?B?dHA0MnhieTFLczRFWkMyNzdlbk1jaEJ0NjkwY1M4MlZtSDJjVVZLMGo2MmFi?=
 =?utf-8?B?UGRwNFI2ZHdBdGpSQzZwMy84M3NZYVFQVkFhdVB1M2VOUjE5TFpEdXJBVW1C?=
 =?utf-8?B?am1iK0J3bzBYaGd5R2p4L3g1N2MrQy81Sm9jZ1dVWEhLRThlN2hDa2JvakNa?=
 =?utf-8?B?Q2tFakVVblR2YlNrY2tXY1JGTEErK1JhUU80MHpQR0pkeWx1Q05mdldiY0JB?=
 =?utf-8?B?dkVLV0pSbmwvWVg3K2V1Z0xaQThNODIyRFVOamNwUzRDcWhvWk9QVGdWNVRE?=
 =?utf-8?B?UTRLMG5DdXJ6NHkwb3N5elFVQStUeEhWb0VaUmhsYllIby9hRDZ1Mk1QM05P?=
 =?utf-8?B?ZnZoNFlDMmhaM0Y5cTZiZEZYbk1jMFhXMzhFOFRYS3NWVXdaTy9NRzJZQjBX?=
 =?utf-8?B?dnE1STRQWlErbFhyTTFYVEtoNklSNkVwdEhHS1BaOU1PSmJTM3Z6QzZuUkV6?=
 =?utf-8?B?WHExbjN3VTgwMzFWK2RISkdCcXdDQ0RzWnQ1K2tXUTdoKzQ2OTNMd1NVY21C?=
 =?utf-8?B?RXVCV0xLQUxyZHk0bVFvRVBMN1RQYjVkcDEzR2w4UGp5T0RiQm9PRFBjSVhu?=
 =?utf-8?Q?qLwD806VLUWR1mc8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1260375546954DA94D0C418A72F375@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AiWj57qQ7FK+lpYk9254zLUK69DGd6eG/DMSHRHyJ39WeNz0phmnoTaTd4iOhNnh/cmcmFLEjinBhJFpGnvmhJb5OauON27IXCuVeHUNP8O+UyVsdFayJpUhrZCBEvduwwLTMgS0xISjjFm4Q7sIz44ArSmhvdQSsUvLjpqqDCr2QiI7nh8rO+pa+zpY31LGi9vh78IDTddUerQ6yga6FEwoa2nCoFAA0Z/unwRitGBSzFKmQ8cxMyaU+bAJadL5X+jxtDg4J/pIZicSSfqtnNQNo1l6qzD2+Qm33kPNSgL1VHnofjq8IjP1Q1A0/YIgo1qF4oksf6hAhAqxnptc5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe7fc3e-125c-4184-6908-08de85dcd76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:27:48.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lBHlkQn1QofzHPPLxK+eJfdk3jgXpmKBI622nv9qYuJwFTE+qlhuK0RW5IoQ3ze9WlwXom5MKWQaGkuhFXxqQzwSx+11FEfqA0jCWqOJlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDEyOjU3ICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ID4gVGhvdWdoIHRkaF9tZW1fcGFnZV9hdWcoKSBpcyBhbiBBUEksIGl0IGlzIGN1cnJlbnRs
eSBvbmx5IGV4cG9ydGVkIHRvIEtWTQ0KPiA+IGFuZA0KPiA+IHVzZXMgdHlwZSBrdm1fcGZuX3Qu
IFNvLCBpcyBpdCBzdGlsbCBhY2NlcHRhYmxlIHRvIGFzc3VtZSBmbHVzaCBzaXplIHRvIGJlDQo+
ID4gUEFHRV9TSVpFPyBIb25vcmluZyBsZXZlbCB3aWxsIHNvb24gYmUgaW50cm9kdWNlZCBieSBo
dWdlIHBhZ2UgcGF0Y2hlcy4NCj4gDQo+IEl0IGNhdWdodCBteSBleWUgYmVjYXVzZSBwcmV2aW91
c2x5IHNpemUgdG8gZmx1c2ggd2FzIHBhc3NlZCBkb3duIHRvDQo+IHRkeF9jbGZsdXNoX3BhZ2Uo
KSBpbiB0aGUgc3RydWN0IHBhZ2UgKGFsdGhvdWdoIG5ldmVyIHVzZWQgdGhlcmUpLg0KPiBXaXRo
IHN3aXRjaGluZyB0byBwZm4sIHdlIGdpdmUgdXAgdGhpcyBpbmZvcm1hdGlvbiBhbmQgaXQgaGFz
IHRvIGJlDQo+IHBhc3NlZCBzZXBhcmF0ZWx5LiBJdCB3b3VsZCBiZSBlYXN5IHRvIG1pc3MgdGhh
dCBpbiBodWdlIHBhZ2UgcGF0Y2hlcywNCj4gaWYgd2UgZG9uJ3QgcGFzcyBkb3duIGxldmVsIGhl
cmUuDQo+IA0KPiA+IA0KPiA+IElmIHlvdSB0aGluayBpdCBuZWVkcyB0byBiZSBmaXhlZCBiZWZv
cmUgaHVnZSBwYWdlIHNlcmllcywgd2hhdCBhYm91dCBmaXhpbmcNCj4gPiBpdA0KPiA+IGluIGEg
c2VwYXJhdGUgY2xlYW51cCBwYXRjaD8gSU1PLCBpdCB3b3VsZCBiZSBiZXR0ZXIgcGxhY2VkIGFm
dGVyIFNlYW4ncw0KPiA+IGNsZWFudXANCj4gPiBwYXRjaCBbMV0sIHNvIHdlIGNhbiB1c2UgcGFn
ZV9sZXZlbF9zaXplKCkgaW5zdGVhZCBvZiBpbnZlbnRpbmcgdGhlIHdoZWVsLg0KPiANCj4gSSBh
bSBva2F5IHdpdGggYSBzZXBhcmF0ZSBwYXRjaC4NCg0KSSBmZWVsIGxpa2Ugd2UgYXJndWVkIGFi
b3V0IHRoaXMgYmVmb3JlLiBCdXQgaXQgd291bGQgYmUgbW9yZSBjb3JyZWN0IHRvIGp1c3QNCmRy
b3AgbGV2ZWwgYW5kIG1ha2UgaXQgNGsgb25seSB1bnRpbCBodWdlIHBhZ2VzPyBPdGhlcndpc2Ug
d2UgYXJlIHR3ZWFraW5nIGRlYWQNCmJlaGF2aW9yLg0K
