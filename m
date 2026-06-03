Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C93C73DD;
	Wed,  3 Jun 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485347; cv=fail; b=Y6cWpfnOvF1d5DRJHXSYoe0TWmYaNhEhGCjTSne6uqbrwfaVHgW40tvFAgupCHv3mce3EbC5Eg1RpAfizPnJyyhO4ur98qMiF7V/0hndd1EasnWXdPd8i7SVgeLHQ8n93Nz6Q2Uk2hNuVFvugVufMXzV0C5M1aso0kPG60E/pxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485347; c=relaxed/simple;
	bh=dQam5SPqxuNlUvWqIp48flHQPdZWwWEfyEnlyvpKmhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAJ/Vw5nfcbPa48rpwR5l6xmBBjVDhsn6zor/zLg6ST//NdntA0yYwdlxOjTHH/bOrlV/L98VA1JI3VjurUbu921XIaA+llYpEEh9AeYLVqFdBUiQU8lo08BgGhqjw5/o7jPNnMpQoLL8XGZ64OrP4WEI97PTTmU/UKy/0uo4OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSgMUauV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSgMUauV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780485345; x=1812021345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dQam5SPqxuNlUvWqIp48flHQPdZWwWEfyEnlyvpKmhk=;
  b=VSgMUauV32Lj6e6ao+MtkOTbLvuYCjzyERQwnD6Qx6N+Yv5NrM4fihnd
   yieXyzeu/hyZt0eOSNUgOMqnSpNnaDlob2JrNZLJGz6znAVEkhE0lN4O6
   KXhohFR3dlJlq0V0/CBCy9vZVgd5GSuqhWPxUYxtkBnDXQiiRoFIgew5J
   afagdDqBXO4Il2i3Uzqk4FtIdQOnVrs+Y/NIhTHz2Q8nY67ICIqFJ+GEt
   f4ka6xqM1NdXapfTukMuupyuQk3zVvCk4I9ItrjeY1R30hgScephGcT81
   0T+DtPWzxhN8EpuK/8TBw3h8HmUXwf3VoI8VfObQKcPF7VLQc3lmGlZ3+
   Q==;
X-CSE-ConnectionGUID: 3ryOnbFiS2+Mex+KHFLx0Q==
X-CSE-MsgGUID: GqdVu3fUSE2gd1KTrl7LIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91602436"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91602436"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:15:44 -0700
X-CSE-ConnectionGUID: vj7pUhfwT3y3GHhK15I7/Q==
X-CSE-MsgGUID: +gWK+UtSTRC6YYpdIbWgBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249114422"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:15:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:15:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:15:44 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFALYnxDg66dAeSpMmA80n2sF9EcJzBQwTl9ieZj36wbJWNqDrXg+/AUOS4pFhH9vjmUyUMFM3Q26zFn21PLYTKOANjfu3UkgED/accA1S2+CbgVvAchcxvg3zsHk86au3av3WL/frqDuH3GpPQD+QrzoTHcKuUJEUEft42IteaLA7YgDPk4mmFBi8gwL8D0/nGYEO6loHcizh2LawvwuBOCSL7nNH+j7TWf5qbP3OTcI7WR5sbBwDMjqu3FsCL8+DfqV+YvCpXbEAPK2nts8Vh6tHlIiB6Q+pWzddGs8LPth3ImK+t3dbKF1kqrG8XAymmLHGCrtPTx1OJKYY9LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQam5SPqxuNlUvWqIp48flHQPdZWwWEfyEnlyvpKmhk=;
 b=kIwYyqPjxkiR8L6LYehm74kZ3vvZIXAr/jEN/iLLyT56AhDyXTZSKA0jFdG1Fvs4mUhJT1K5uE6E7Msk+WrL4ibvAvjID/TKECprKMq//9jQMRTOXBOi0s9jto5e3mFKLIIU9GBE3wUtsia/vzEpOt8XpeiErfjRKQCyPDB9vWgStXxuAdFEcl/+qeUGak2ZCFapqwoAOALwsaDxLD/FIK7q8G9dPuI8XOGhGIFTKWfV5MPV7GIbTluljE40DVXedt4Xt6gBbH6pqRVj5IUffsEUCEJJnfKVow/veG+S5MYZCy5HgdHwRcYoOT51BAQkKus4VeEMTWrE0givJflHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:15:41 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:15:40 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 08/40] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH v3 08/40] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHc77m9hFQqwC2Hl0GGLlCbRWxCgbYstSqA
Date: Wed, 3 Jun 2026 11:15:40 +0000
Message-ID: <53c1799bdffda3b51e1b0883358ad6dc7fcbaeb9.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-9-seanjc@google.com>
In-Reply-To: <20260529222223.870923-9-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 706c2914-194c-4f20-9be2-08dec1617273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|3023799007|11063799006|4143699003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: eOPDcEOxbdeuaTLZ/b4TgwNgiIGyF9qRQDmoU3VNCmvbufYO7UUgIlbPV7+RRMVOPT8DtbFIOqItgCYAsTuJ9wkWx6YyoXGeMWFN81ncINSNu0K5EmQzOrOlVNdSVPVVA/fVZ2bq5W4RkataHPzNCA+Y2D/TdDMDxYAy5DTdnpO3/fTWqFWRyHDpiSZ2+eZ1PDbT3EKjZ1Aftk/tSuiYiZnmQ7QQPXZTvJMmPc1HJA14h95iCdgP/eFJL0hfwXVURPu8C1qujts7hPKkrQ97nGFnFsj5CvIlD3UAL75k12ogZ4OPze8Hh5J58Z17gQLtE5lilTonh32Moh93b57kyvFSpvHbM9nCIiFWniW9LQd/pzZUs3u+WiISAU9tBYAqg3Fxm06bfPYYlOmTroQiSNvDrEjoHgQ+HeGGR1YQ28/DTC4D2lfCLwu0/MglN94/FWvMYqwEq/VjXXjlyvWs02uPOtmz4UrK8vJaDgBNKrEALIlbUH8Svxu3kUYrnmFEjpYBuAMgfamaHz+8k6h4Cn67kD9D1HCyhYOLTc2yxHxovPvGzX4kLwAovdGfxYpBnM4BhdAd2YMxuC/QZWchmJB6GvPfKuyoMFqRLgnBwR73u0U5JIJ2PMrkl3EhGXG3vUdH+Q+Jc1ea+cNhH5WYEE8W2QSvifijRHceh9vEadlC/GoZmL9lrnT2ann2jxiRkn3ZiQDQNzzCEYAOuTuVRW7tDTYyrTBZL+45M74C2FSAUCR99nWZlFoW5+Xer3RS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(3023799007)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ltYTdrMUt2bTltSDJSRGlrMVhiZDlzRmZVdFdPdFF5TEsvdTE4cUx6RkU2?=
 =?utf-8?B?SjRqdGNnTmdGZVpJbjVKRmxDYUZrVklubkhxNkRIRnNWdHlUMVhaakszL2F4?=
 =?utf-8?B?N2k0bXRqYjZ1UTRuelFmQnFieG9zY21oTGo1d09vY0xlZ3dJVFIzOWMzcnE4?=
 =?utf-8?B?WlJ5RXZvc1lXSUtvOWI1M0dTZTh3VXJjaUo1TEV2ZXJmNDBIYzJWZS9aRHhk?=
 =?utf-8?B?clhhb1ZKZVJ2R2RIUEVxOEVicGF0cWNsVFUrZCthRjRYZFV5STZJbFc1R1FL?=
 =?utf-8?B?M2x5OWFybTRxRDN1dnJ2SEpjUHB2LzZHREtkR1J2MFJtOWFyR3p5SGFGeXRp?=
 =?utf-8?B?eUJiWS9aK3RhdGliTzUvSkYySlYrbm9ZTThPUzNDbGVseWJhNGtscFVTWHZn?=
 =?utf-8?B?Q2tvZ2s3ckpPaU9LL20rMmhWRm5VSGRGMzhQMmtWd3lOSFg4dHdXQzJ2QmRp?=
 =?utf-8?B?UWF6Z1lsMHJQT1dkZEhvb1NiaHZPV3VqRUZ3WUlmV2Rtd0cvdW1sZndLaHk5?=
 =?utf-8?B?VVFpQmlGUVMxbjlJem4rSnltMDdEc2hzZDN0WWNUbEQ5UHJOblN4bXB5cXg4?=
 =?utf-8?B?ejA0R2VJQk1yTjd3QWRVRUNoa1FkWU9vMytpQm5IcS9EZEgvMGpFZ0ZEMUZm?=
 =?utf-8?B?aUNsZlZqMFIwNWxrbmRzWTM2VFNqTVVtcjdKa1FOeHEwVFZjQ3JodlMxOWlR?=
 =?utf-8?B?WEtHM3QrMmpERnpQVXFGV2VQL0MxaVZ6K0Foc1NDKzhZeE02dnpnTlRsUEFa?=
 =?utf-8?B?WWkzQmtHM1h4OFpXYW82TE43djhPNDVCYlUvZ0MvTkJUQUpBcU50VEtJcGpO?=
 =?utf-8?B?VzBMTkM5eTFhbXpZZ1QvZXJLbUN1MWpIWkVrcVNxK3NrUG16ZWJLbWNkdGpR?=
 =?utf-8?B?S1BsK3grd0ZUblYzSnNoajNwbEFGTGlEekVxZGJPNUJHemJzckRoZ0FHY3R2?=
 =?utf-8?B?M2hGc3AwK0c0Q1NBdXpkRURpUUoyUkEza2xCNmtHNkkxdzlsb003UlV2SUcv?=
 =?utf-8?B?cVJKOVJMaTVFUFB4R2pOdkRKc1duM2pXdXNKbk9ESTREWVVJQXRnSVR4YStQ?=
 =?utf-8?B?VUtiNUNmSXl4WXlCTHNra25yelAzV3E5ZllOUGN6MU1KN2dDNkN4Um44bTI2?=
 =?utf-8?B?TTlSK2l6Zzh0L0JxdThlcnR6czFveU8yN2x0aC9vQitYS1VDVHZGbzBhZHFa?=
 =?utf-8?B?d2F5RlFhRWh0TFpwUkc2SlE2NEtTT0pDVnI4Y1doMEpPSTY1RXpkMk95WkpC?=
 =?utf-8?B?T1dUeW4rSU1UNGRlUGlRSVZNNCsrSTFwT3Y1KzlzSkVqMStHYWlRZHZVZUM5?=
 =?utf-8?B?QkpuME9IbDY2MWpqeDdZbGptZUlFVFpsWHRFT2N4VnJnUlJ5L3h2VVEvOWZK?=
 =?utf-8?B?MmVjQTAvTER6a21qQ1RzV2F6VjE0YUV1TDFKQ1hYbUI0Nnc4bFNvbG04azNk?=
 =?utf-8?B?TjA4Q0Niem4vUk4vVjFQNkRKanF4OXkwUWlxbExHUFJFVFBjdHo3L1VoR2pa?=
 =?utf-8?B?Q2pnRmhpVUpmWTNKRUdmU0pnSjlYQ3BuVlNGTUpuMXNpOWc2dGxWdGR4c3l5?=
 =?utf-8?B?ZWZBTDlkUUpEVlNVS0dkREU5ZFVCRUdSRkdrR3FSakJiRzU1ZHJqSjRwMG1S?=
 =?utf-8?B?bmEzQ0tvd2tsb3hkWTdvejNVaUVPb3NkY0JBY3NCNS9jZnhHcCt4RHdFbmtC?=
 =?utf-8?B?a2lpOUZyTW1ITmZTNjVtVTNOcTNhMlc3UXQ0U1RoNDl1bnBzRXphaHl3Vnph?=
 =?utf-8?B?VCt5ZVFXaEFJQ3kxYndrVUVqN1JKT2RRK0U5NWJNMGtkSnQweWsraEMwM2Ja?=
 =?utf-8?B?ejJub2ppZTN4ZjhGQVd4bEdFeVczMXdKVWVRVnlFQzJsc2NwUU1odkEvMXE0?=
 =?utf-8?B?azNKZXg3anZQUnhrUVBSMDJoRVRjMTNqOFN6ZG8weTZIcEhXSVFEd3ZFYm1U?=
 =?utf-8?B?RjJsR3JKaW5BNzQ1aStaNGFQMEdiUjc4L2M3NWIydXhOMEFsNGFIQnY2UEww?=
 =?utf-8?B?U1MxNHRUV0w2LzNNOTB6NncxVjNXUnVUbzdaRzlxYjQ0MkYzQ0l3Sm9KWlRh?=
 =?utf-8?B?OHRKQlJndmhFUjZOcjkwWGxtRU5TR09HWEd6eG5lNTJtQWU2cUdYTmtsUThT?=
 =?utf-8?B?ZkRQWUtWUnNoQ2hpZy9lQjd3TCtOS3R4MUpWN0E3OHkxMTVISUlGT2hhYnhK?=
 =?utf-8?B?OTY0cFJkc3I0d3FhVlBnSUd5Tm44b3F1VElFS3Y5WVBkeFdyVXpCQzlRb2dl?=
 =?utf-8?B?SGZzR3lmOFRJUER0eTh1ZkVES3htVWNVMUpJOCtidnNOQWRFc2YxMzB5NjBO?=
 =?utf-8?B?Szc0bGpDYVBRTFBiTC9Zek42d1hkUnhobjc0VjNiazJOd2E4cExQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0252B7422CFA647BA6AED4B0C16FE9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fowQtT1ghO9VIPbTqYVmEv/Ec6vVWZ5l8xpQbBid6LGtyuPBBVvT749KBbuPjgfDP8BUzSpf1WKn70+B+Nj10yzOqhWmYbYdWBN8sAcT15Fq6T9x+NmI1DSQVlsQTMcUwgd8bKhOHaMo1yvxYK69BMqDMsJlfVM/VwXWRXZIiv34NF0SVCcLIMLwtlmpvHWZA6avTDHtF+B+IVgh1aqFut+4sdMXgi76oogzPLkHT6tfvsEGrZRMs4J/UZ5c8FeMWsLkEAiP6u7O0tkse2GT24HUG6SSykPR+Jc34olEYIsHJkEsiD0+54Oecdf+Nah2zUOWn6zN/ZURF4GK9GWOug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c2914-194c-4f20-9be2-08dec1617273
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:15:40.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcviimGM8A341YByPbissQkVBHdRS+BnMQxPxQzbxxGxSR/1s+w/BC2mADej6V/OzLWxvxxrbG9/N8ZrVb5m7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNYWtlIGt2bV88cmVnPl97cmVhZCx3cml0ZX0oKSBtb2RlLWF3YXJlICh3aGVyZSB0
aGUgdmFsdWUgaXMgdHJ1bmNhdGVkIHRvDQo+IDMyIGJpdHMgaWYgdGhlIHZDUFUgaXNuJ3QgaW4g
NjQtYml0IG1vZGUpLCBhbmQgY29udmVydCBhbGwgdGhlIGludGVudGlvbmFsDQo+ICJyYXciIGFj
Y2Vzc2VzIHRvIGt2bV88cmVnPl97cmVhZCx3cml0ZX1fcmF3KCkgdmVyc2lvbnMuICBUbyBhdm9p
ZA0KPiBjb25mdXNpb24gYW5kIGJpa2VzaGVkZGluZyBvdmVyIHdoZXRoZXIgb3Igbm90IGV4cGxp
Y2l0IDMyLWJpdCBhY2Nlc3Nlcw0KPiBzaG91bGQgdXNlIHRoZSAicmF3IiBvciBtb2RlLWF3YXJl
IHZhcmlhbnRzLCBhZGQgYW5kIHVzZSAiZSIgdmVyc2lvbnMsIGUuZy4NCj4gZm9yIHRoaW5ncyBs
aWtlIFJETVNSLCBXUk1TUiwgYW5kIENQVUlELCB3aGVyZSB0aGUgaW5zdHJ1Y3Rpb24gdXNlcyBv
bmx5DQo+IGJpdHMgMzE6MCwgcmVnYXJkbGVzcyBvZiBtb2RlLg0KPiANCj4gTm8gZnVuY3Rpb25h
bCBjaGFuZ2UgaW50ZW5kZWQgKGFsbCB1c2Ugb2YgImUiIHZlcnNpb25zIGlzIGZvciBjYXNlcyB3
aGVyZQ0KPiB0aGUgdmFsdWUgaXMgYWxyZWFkeSB0cnVuY2F0ZWQgZHVlIHRvIGJvdW5jaW5nIHRo
cm91Z2ggYSB1MzIpLg0KPiANCj4gQ2M6IEJpbmJpbiBXdSA8YmluYmluLnd1QGxpbnV4LmludGVs
LmNvbT4NCj4gQ2M6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEJpbmJpbiBXdSA8YmluYmluLnd1QGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpSZXZpZXdl
ZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
