Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABF2C3266;
	Fri, 11 Sep 2026 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089446; cv=fail; b=Jhjg1RqR5y+nGM0TD+qZsr3uW8HShxiX+npo9nQU1QYtU4qNqYCfTeq90ZbwdUmo3j7dtzkpxyy/75JBV3vFenjGKm45+WK5hztzECXAkAPDy15DVSooqtHwSzFmMNfDhY3N+8jCBx1wYXHY7guGd07q9n+9SpyeyDiiN71lwDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089446; c=relaxed/simple;
	bh=qU8a3zz1zvQEEQOvdd9YP5Xa7BxYI6OQWFy0ZHBf14w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jscMuLZHSTVYdMRPz+jJOlQH6GD5lH8oXmrhLuuEoATl5KEfzJI8D4CYBAiwlA4MZCiwhgv4eF2g/0KC6DOASCvLxBnDjdJ4DNK7Xr2r9xhpwY27gaqupjsmFpG+bJ3Clwn9T6Nzum+ETvcd/fH6P1uItRMZFUjIeD3PzeYEXMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D94quTPF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D94quTPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789089444; x=1820625444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qU8a3zz1zvQEEQOvdd9YP5Xa7BxYI6OQWFy0ZHBf14w=;
  b=D94quTPFgZyaJBNcKFfJznivYKoCDpgb2+f1WUt3bCZTlSKAab0tTYQt
   3O7H5zSy4P0ORh9dzGNsogHUvrKk+zK8zPLxzbc1/LdALGGkTmHzco3nV
   GVrsPomKYWCFGLb97WDhnyxAVntC/8O3WO+XvJvTXHj2ukhCw2SOjQC3o
   8lCShk5/MVa02NA4JDHJWSrWAVmp23IczWf5s0bED/f33fm8Dl6gP/xb0
   bsg8Z7jw05PNWGUXrn1kc7kyuibToS/7Udr83h7VuRTC1lRvUWHRDTwb9
   P1Lk5vYAEbcufgg8kydrtw6vX26bo7aoMoPYC+jPET3dCyLrfrSzdlYlr
   g==;
X-CSE-ConnectionGUID: Y4wwp8G2Q+uIC1lJkCMDPg==
X-CSE-MsgGUID: +fiwQn2GQHiHyIzvUs437w==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="77112593"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="77112593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:17:18 -0700
X-CSE-ConnectionGUID: aYp0fjkAQBOgSNxnW/ZUgQ==
X-CSE-MsgGUID: nthO/iRPTKqPkHFC4Shu2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="269188018"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:17:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:17:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 18:17:15 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9IjwKF67VykghFR/BvKV/JfdMAIOI2C5Qn/S+g4m4KYlpRCociyNvKYK4xhwlIOxKwDFOgq9ag4lGdeDvPnShmSbgD7bIoF/Hw4svKb0JPygwcsCp4xyz7jzkDfNrOkRPsXQKNU8YB2eksbVUPqM+UakZtvr/JTG8R0JaqwLSw/O51Uf/vQHOw3vmWoJ6qnU0fmFaP66wwvamtUMn2/GmTj89Ahsv561c6t238zLS02uPdzIirL0zjvwP6GjPCPRVsZoorex6nbEZIFeLJTuOgkv1RQqTn4aGTLYzKWAMxO6oMfYL8esf2cPiCK0Gu8DSVsb1Npt7YY+LOBQY2jNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU8a3zz1zvQEEQOvdd9YP5Xa7BxYI6OQWFy0ZHBf14w=;
 b=ho4WCJFxsTZt0JYTqOZNMrq+2xsLjZLnT2FcARdJ5IQP5V8PS1bdpjyns5/j3L/iiWmi+TiTeeV/ei6xcxXNPRbv3G17FuUNtLFrJr93iBvsmPh03qK6FhWfqsPr05Vcj97g5TZE9SnUb98yYhCCQ2fm+Wxn3RBawW6wWurIpnvQKVhEVmQOm5ii2UfbG6WZuJozNC7sw5Kr9coxp8HBDMlkUnw63QK5lRNpVsox3JieHJEb//nV4SNesw7ASG7YvQkQSWvktf3hgS6a6avJiGkmeivnQKXZphqK6R09/XKt05Yw9+6I4aJV76Wd9fYP2jxt2TIzep5Son6cpUyNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM3PPF1939049CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 01:17:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 01:17:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Thread-Topic: [PATCH 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Thread-Index: AQHdQXSN9mvhgfwDXU666+cnFtN1WbbIk6AA
Date: Fri, 11 Sep 2026 01:17:11 +0000
Message-ID: <9d56edf399ca409068a5adc17f573823641b5ea9.camel@intel.com>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM3PPF1939049CF:EE_
x-ms-office365-filtering-correlation-id: 6a28c1ed-d2f3-4e99-d861-08df0fa26828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: prYnaB+ek1H1OcfruziWrf+tPJOcdJzR7PTwZnR50O4OqIU1/4at3qigSkfHduMe38IpN0r9uWmH9SCg2RkOOe0iuExHEQ9DxMZccr1K/hjj6vMGOuyrs/eLXPX1xHR69QztVwepOl4G2vq3gmjSsSjkKcixahX5rUjzRp4hKqEP33h0d5KHICQBPeBOSP+un9FQodLno3j0DRTDSbm6ljp/A1UtqdhJ2J2oVNkoG+YNxJknauYHnvV/8ivwyOkwTb+uQVZWhsTLOkd/5CuEFNZyyh1aE5dloXBZOUvcRpOQ86fSJ6VWpPgaKtNKZmj+ZP+VVR69nkhNH/xhljZd1S7UXQOyEe4gvrUTCn0dlvieNe3Z8mAFrkZXX/VFj1jWa0/xPp6DcFSUZItK2n7V9g+hcGiV9IusmqQ4xVs3uT8gRcIcTnSME2lswiiiX6OMjLnEO1VtrWGQ6HacUmljjPmYU2KexlhYiJ3B45XtcFjL+dfaZZH6Tn9/bsI6B6nqmLfl9MPvgSzwL+tZZlGB0jxqw6Sq6CeOghKQAAkKKE+5iYg8Kp9oWE5SefE5Ih+6dzp8hyjMXWwaZDc0OI81a8eSxn8OFfyvmClCmApMuyXjA3T8qT2D+Bav6VZQQrPcnXYqZlvx8rfDr6dZrfiG68gUK8of9AR2UTkkhqWmwJipaWvlpFxQuX+KZkOIG35HwMssS88ZxJr927gweq3x9miLkbvz6DdqbCG+SkVOqes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNlUEZ6RWFRbi81Q0Nia1JEZWFaZ2U5ZURZbk96N0NoWmxzZGZzcXhOdDJt?=
 =?utf-8?B?eU5XTzcwQ1VDeDduQXR6ckowaDFrMzMweE1wa3dya2lNbjBwWFhKSEJZNVpx?=
 =?utf-8?B?eStrV3pWWEV2WTRIQUZraWdXMFdmRnhTN0NIdFFKaHQ0dnNXaXYxWVBhMzE1?=
 =?utf-8?B?SmhwY0dOcnhDaVhiVVRVQlR5UGc4Q1RGK01yWk1yMzBORG8vQlVZUGZJUVFX?=
 =?utf-8?B?UlNWUUJZcEY0NDVHNDRuUDQ2Sm50NFRNWFJ6bzlEeXdmQUVSMlV2MXA5RmhS?=
 =?utf-8?B?Q0JPZmhreXVjbEpXemJUUnBxK296N0ZUbGYzVVNrTXcxU3pjcEhCMGVpM0Ry?=
 =?utf-8?B?WC84d1laV3FCR2FTMEsrbGVQdFU5SEhIS211aWN2bGdTbGJWcHRDVHZmMk1j?=
 =?utf-8?B?REZUUCtEWW1kOVl0eDJrOG03NWVYRUNHTFozVmZOTEJOQmhHUVE3TXo0MVBX?=
 =?utf-8?B?V0NsZ211T3YrYlNCeDEwMXRvVXNMQkpVd1dIMGdKUmpmNUNtcW5ZV3VlZFU3?=
 =?utf-8?B?d29zQ25KTmR6S2FzZjgrd2ZYZHNOejVOSHRvVExaU3Z2SUgxdkd3SGhBeEc2?=
 =?utf-8?B?NzRCdmtXWDdudXZCc2hxWFZoNmE3VnFlTk90YkpZb2VEWEhrRjNHUFBFRUJZ?=
 =?utf-8?B?SUx1NWY1NjhUR0ZvUnI5ZExoOTM5Wkw4aXArR3I2NU9JOTZhTEp4MU1NNDJX?=
 =?utf-8?B?WklCVEw3RmY1MWIyWWVOZ3FtdS95aDFTYWd2NG5MQjd4bUJzZVdEd3JoRnAy?=
 =?utf-8?B?NGRGbWU0WFc5blhWVTVmM1YvaHFzVWRWd0wxSnRnYVdrZkp5dFFmUGdJSUpS?=
 =?utf-8?B?ajdnZStqOTQzYkhUYnNDc3JrZ0JLZkpvQ1hVcm1iZ05kb0svdmdwc2hqa2tB?=
 =?utf-8?B?dmk5aDRzMjdQcjB0SGthcnVTanBSKzZUSmsvNSt2cUdLeVJPK2hxVnYxWUpI?=
 =?utf-8?B?TEUzdG1sbXVUUkxDckYxUTVRaXRIVXBwYmorMFFuenVCWmdFSnBRalFKU09z?=
 =?utf-8?B?NUk5bW8zdGFoYTVORGczNUtTMXFQL3lSb1MxdGRTZGtaNkFoUnBSRGlyT1Bo?=
 =?utf-8?B?M1VpL2Y3S0tHNGsxT3dKSUJQMWpJRnNPUDBXTElxaVRjdDlRNzdxYTV4UlBv?=
 =?utf-8?B?eWQ2cUM5aWFaWklWYmRiek5JL0NReHRJQmp4ZGlZVHRWZ2lzSEVMR1AwOTJ1?=
 =?utf-8?B?cXhmaGg1MTZrZ2Y0ZHM2UWx4Sk9SeS81S3BrYVBLU0V5KzBlMThmN3R6QTNk?=
 =?utf-8?B?dHVaTldaYndiblIxMTRYN0FFWWhlaGtSNGt5MHNrU1lkblREUDlMSDQ5bUVu?=
 =?utf-8?B?bGd1Q1d1V0FIOCtNbHI2NTBmNkNxMUMwSFB2YXVvaGhZbFNiZlpXQk0xZzdq?=
 =?utf-8?B?L2VDNmZPKzBKakx3N0NlenFGOGJTemtGVkdjSUxPOThrdHlqb25kOStDY3E3?=
 =?utf-8?B?U0Y1ZUF1VEUzRHN4dTlybERyVE5vckNHdzlKYzlWdVdOTnpLTUthekJSQ1Qr?=
 =?utf-8?B?M1FSYmVHTDRXS2IvY3VIbFlXKytyaVVRK0VaaS9nWFJjRnhvUTluL3VQMlBJ?=
 =?utf-8?B?Ukx4NUYxdGNBamZWR01LaFo0UFpENlFIUU5RdHRhc2VicUxYL2kzUnJtUTRY?=
 =?utf-8?B?QitxcEJjRUVKZmJtaDdsM0VzVGs4VGRzMVUrR2pWczJWUlAybEVvR0VIVlFq?=
 =?utf-8?B?QmRBSmdNbDNuT3IyY0NHWkhFUUhhQXlFbXVnSkFjYjNjZ2NkNWpwZWtqKzZG?=
 =?utf-8?B?S0k5NjZCbUQzWUFjblZiWmxyMjRDTFFRQVh1NFZkelFKZk0zMkNDSVBKUFp6?=
 =?utf-8?B?UDFpZmN3c21RRkFSUW5VWHB5dFdaVDdEZXFUM2xXcnZ3TFVZUlAvUjRFdHJk?=
 =?utf-8?B?a3NLOFZJWVJEbnVRck5LbUlrUlpHQVpsMEhaVGRBcjNXRWloSk5xdDFEb3N6?=
 =?utf-8?B?anArenFtYXNjZXFYYnZ3WEwxZzRjR2daQ2E1SDBuejVzZ0Vocmx1ZkhaZzR1?=
 =?utf-8?B?N3ZkVlZFd2VGWW5HYzVhUzlERXBoUnpqU3A2Um9SRysyWDBmMThDTG51VE9r?=
 =?utf-8?B?cmdwdzl1aXdjMzFKTjdmQndHN3pKQmNSVjZHamhnZ2g1M05aa3NyM2xsbU9J?=
 =?utf-8?B?TWtCcTBEYUtYV0Z4V2tmZHlCTnZDMnkzK1krWnltY2NvL1RaUDF2OUdvYng0?=
 =?utf-8?B?S1lkMmRaM1cvamphWUVzSlBqU0liTFJ0ZDVrTVB2S1RvQVEzSVBFSUZYWlJx?=
 =?utf-8?B?b3cvd2tLL2VzRys2YzlhVmt4NXVUc2VNUW1YUlk0Mlh3OXNMazhIdjJwZTR2?=
 =?utf-8?B?RnErdzBQR3NxVjN1QTBYdWhSVVFvOUZCSGlJVk5vREtDYTE5d29XcjVieXNF?=
 =?utf-8?Q?HTj1ekHj5jd3Hvhc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A7A76C86DAA2C4EA56BF9AA73E5B7E0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jBh5GlL+6tiRpQHNfHBdD1XsJPndnLlQ0X9INb3HeJssUTtp8VwPZVa6j57/2Bp9hTwnAS+QTwjrvPRrku2S70GzSjimNM/cDox+MGrbD8QuGj1lVC8Iqhd/FGwRTWU1msyj93oPdbw/WNonBid5grYiZzVsMPWNUmO7GRIa39Hd23kjCc9A3cLLyvv/Nq3btEivh/JzSH41uZfexxxZtJv7qW9axa9InpSsid8M3to037A2IVxeEdIKSEbBOwyqkPyv3BqBK+XwlimUqLs3es2vCsfJybyV3bhXMU8iFhfQ/t1VEL0X/kwO8eLsZHzxcdLNpTBh99yVXwKlY687eg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a28c1ed-d2f3-4e99-d861-08df0fa26828
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 01:17:11.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWP0F71CbSxjU3Kr0WkXxes8v8DHPXtrClAqHfQBpy1MxBzy0JwGAgFkywHg0dfyAhMM3Qe5tMZbgrpScGZGHfsYQzFZcb8SEIaw6otBiEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1939049CF
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDE2OjM0IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IEJhY2tncm91bmQNCj4gPT09PT09PT09PQ0KPiANCj4gVERYIGd1ZXN0cyBoYXZlIGVhcmx5X3By
aW50ayBzdXBwb3J0LCBidXQgaXQgaXMgdGhyb3VnaCBhIHJvdW5kYWJvdXQgd2F5DQo+IHVzaW5n
IGEgI1ZFIGV4Y2VwdGlvbiBhcyBhIGZ1bmN0aW9uYWwgbWVjaGFuaXNtLCB3aGljaCBpcyBmcmFn
aWxlLiBUaGUNCj4gZXhjZXB0aW9uIGhhbmRsZXIgaGFzIHRvIHVzZSBUREcuVlAuVkVJTkZPLkdF
VCB0byBmaW5kIG91dCB3aGF0IGZhdWx0ZWQsDQo+IGFuZCB0aGVuIGlzc3VlIHRoZSBURFZNQ0FM
TC4gVGhpcyBjYW4gYmUgc2ltcGxpZmllZCBpbnRvIGEgVERWTUNBTEwgZnJvbQ0KPiB0aGUgZ3Vl
c3QgdGhhdCBkb2VzIHRoZSBJL08gZGlyZWN0bHkuDQoNCkhvdyBtYW55IG90aGVyIHBvcnQgaW8g
I1ZFIHVzZXJzIGFyZSB0aGVyZT8gSG93IGZhciBpcyB0aGlzIG9uIHRoZSB3YXkgdG8NCnJlbW92
aW5nIHRoZW0gYWxsPyBJcyBlYXJseSBwcmludGsgYW4gZXNwZWNpYWxseSBmcmFnaWxlICNWRSBw
b3J0IGlvIHVzZXI/DQo=
