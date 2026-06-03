Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48246AEFB;
	Wed,  3 Jun 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486916; cv=fail; b=RR4htbwIg9ng6/WEB2LDncfkHLplxsW9H2fdBud21YebOEWL4HsSFRsqkH0aprdVn2ZWxltDl0IgFKg/aCGadst1esJ1PBqWmQCC3/deGQby0+OE9la3qPSEKifc853hY8ofSTgnV/8YUBVFx2gtfDmn9cliipkjNcHZu0sa2VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486916; c=relaxed/simple;
	bh=YWaGzPlYbHLrqCD3sn4EQqUWCmxUDk+QJcleMSUgQ4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQRp80LDKy9kvjKfzs51Ymf68DVRy/wnrOHhkZbU/wuDh0Drai2RrgFUDo33fsVgSJo9Dpwq4sswDWhvJ2Aw4DcKuJeiOkD21x3BfIYjiD26kKGLvjeGYk1yjvUzgVUjxoAHz/AKpt5fxAbC1kYQIN7rn4wlSsWUdGHWh/5Cmsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sq0v0A+x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sq0v0A+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780486914; x=1812022914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YWaGzPlYbHLrqCD3sn4EQqUWCmxUDk+QJcleMSUgQ4Q=;
  b=Sq0v0A+xZ2jY/AIsjuGA03RUgiVzTS0ZLnlRPQMYPmY0M/Pruv1tRhnH
   Sl+1yTBFYi+GM4IH8HLQBk6wQ6fY9wFbNjlGj5pBjGla5AjuuCRhslOAB
   +2Fheoqg7PeLk3CIAGHUqxgDItJFhmCSMlleaoeR1B/f+GFggfJGzH5bv
   fiBNMqsSQcVWzWzvyyxtNR5kbp96JyeyP0RzwbYeA5XtFqGKdo2PuCU3M
   QSBYVqR5lteLiB6ipx9h+epRUyTOMx3z7xPwGgnOUBspdGYI+2w1WtbOy
   3TNDY2Hso67h3NDy3+pkSdCbT1yvYIeSWTS4WrhZ71VSFnskJoNDyUA1j
   g==;
X-CSE-ConnectionGUID: AO/opAz9TwibPh1SBI5RmA==
X-CSE-MsgGUID: KXpjP5KaSoCrp5zESAyR3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81418923"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81418923"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:41:54 -0700
X-CSE-ConnectionGUID: H1lLr7/AQQexTwfqj2D1Ag==
X-CSE-MsgGUID: Nb2ff7SARJakdAxnENgSBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244292702"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:41:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:41:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:41:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpcNkbPbJMdnxSjqL7n6hFrWxEaFU5uiPd4hVTRIhG2SYCitCXTOB2cHrcyWUjDKdWX+oEVR+QZeIHY8DUdKQc8f1DkPmhgb6Pb2BFl795jHW0hfDWWuJTZFpLxX6s6pXVvUTJKjFt/UBLVx81170jVYjad1YoLuw3zUhMPL0S1fzWWKO5GTCLv2q46Z/ZLrv+Tv/+y4vJLWDlU4jiELPq7rDOSDhPeI7C6j2djucG7CqDhsEDsy7Muz3CrI9v0OfT0hlwSBCwXepeNGi9aaKjnQ7EJROhptUmaD/PNEDjNrBiwV/D8qI9yNrmDtD7J+ASHEevjUTqI/xILMd/mtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWaGzPlYbHLrqCD3sn4EQqUWCmxUDk+QJcleMSUgQ4Q=;
 b=FRMz7Hyj4tqBWGAw84kIpLMOHfhC2FXftH2y9G0h9qgc3LCF+mSMASiTqrkJCb3rcYIg3syE0XkT2OHFIhh8ei8hCYRnR7Djr03cUM4VU/Df7NZJmiDv+62zdxRrUFORNpPvHlVtoVm4o1unELpJgxo4tDkGc2lONH8As/kRLNDa0hsnrlaqryB3IV7y4mclFLeb3PM4qOLcFN/zgjp2tsvg6LQam5peAqlPtmdLyK24fPUSXk19HgkiOxtK/GLwW1BgoNRQV6ucqzrGc6uPLhPYQcm1BLDy8vDlEkPBg+rR2OhCJvzlzOR99pJ4fJRHU9m2Uz80oQwx7FRWsiKJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 11:41:50 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:41:50 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 17/40] KVM: x86: Drop defunct vcpu_tsc_khz()
 declaration
Thread-Topic: [PATCH v3 17/40] KVM: x86: Drop defunct vcpu_tsc_khz()
 declaration
Thread-Index: AQHc77nBzuFVrA2Vnkezx60dGGRzPLYsvHgA
Date: Wed, 3 Jun 2026 11:41:49 +0000
Message-ID: <4a3de0c87fcad249db21be206fcaee3dd6c5d2d2.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-18-seanjc@google.com>
In-Reply-To: <20260529222223.870923-18-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7829:EE_
x-ms-office365-filtering-correlation-id: d16e1078-989c-45b3-9117-08dec16519ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: f8v0Fe3KT5MYd2OqcmYsaWKvRwl2+o++XMhzkrCXmx7k5+/CLQrndJqYLg7XFblNiQAfri/JrR1k2awXUIWqEcPo6ih0rviw3DPkUB8lsHwXtf52mxNqG7HErLUx7TYGhPFv/dZS4fBJ7mjfm01gS+8UMsBUhWKhRTTWpAO/BP4vFbOPkx4hjgmdd0Ercxrv82HTYKuqvA7C83QQS6a5t8Sn8WmO9D61YcZNxUY6FlrSGNnheYqlD/VTrdfcfL9j8pnRq0BuEDhSHWB2qWsSZbtRBqoCZiY0zrjDWqlS0rIQ0NO/k+9alGLvqoz9dqtQa1jAWCbHn047fq9C1kJr17f+irgrNT8sxDDrikYiNliAC/cFnMjqDX88cDlwz4tFg23PkOws6Cc1bAVEjxt5aALHZBd280XLo+BsyNzUZSonRLrEp9A+Z+gYEwom55OcJds1MI6JKbH/0iX0QS2Gxy3uXdK+7akrChIZwd4rCeV5KXybsrJN6v2o19FtXxQ45z5uDIu+7N90F806Li1JA1Otb/SQKcYsJuF48L0PliF9OVBB72vyLDILr2YKMvxDVepRM5GUQWpCNSZy3sI6j+lKU1t0akfyNJFo8n7yBqLv930BG1eWr7NnwKOD+AbsUSURPBrsq41AflM8tAj71c8it47ZNOuyuWponnJqMK4jTieVIUZrrFDKROJJXFLRGLmnOzadwXQpbI/gaf6okdzGZfN+aEvEGK89V87eNZgs4HIw1SEORS3+jL/2IHxy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0pVS3FwK2xFYVdKcXhhWEdlN3VYeHhpNXdpQWl1U3M3eU5rb1VXZzhJMlUz?=
 =?utf-8?B?ck1pdHpKVEZtTE5nTUp4SGRldXVQTGY2UkhCTlRDVEZBODROVFlyZHdzTGk0?=
 =?utf-8?B?UlZQRUhNOWRBTmRoWEU1ZHhhL2xtRUltcjM5VERuTUxKTG9uZXJ1SG9BbWFV?=
 =?utf-8?B?RWNNUnR6Sll1cWZZVEhmRXcvSjVKb0gwZXQzcE9jWkhqb0JXSFZDVURnalB3?=
 =?utf-8?B?MG9mUUtsSU4xSlg2RkpPY3RDNlZidlc1QnJ3aTAxZHJOTHVwVkNhS1gyNjFC?=
 =?utf-8?B?Smo0R20ya25QWmJyeFcrWXNJdWdReWJDRjJWZUx2N0o4MW0wdEhOdmJSb1d4?=
 =?utf-8?B?K3hKWE55Zjg4ZDh0bDJoc3A2ZFlFUnQ5VEdIWk1uT09jdHJ3NHo2ZTVud3VK?=
 =?utf-8?B?RlRLMHN0SlpnOUEyZFhXY1R4NDJRdGd1NTNQeDVEWlBpcnJnVjVGQVNBYm5O?=
 =?utf-8?B?RWZ5NmFQL0YyMmNHYndsNU5uN0FqSTRFTkR6YlY5cS9SVEN3VUxxZVNrZXNV?=
 =?utf-8?B?MTJHZFhZRHl4WXJtbE95aTM0MHhUSGRSUCs2TXd5T0xKSFFRODFyTGRCSUVp?=
 =?utf-8?B?YXFxVUJCNWhwenBhMGJ5ZDRvOXhjYU9oUFlQYXZQT21Fa2ZXTlAzM1p3UU4z?=
 =?utf-8?B?Z2JtV3Jub3RjazZXVTJuR1NDQnpTQzBENnN6TnViYi83eExHMVJuM1BkSUxj?=
 =?utf-8?B?ZmRLSVJTeHEveWdLVTFZL1dSMmswV2orcExmSHB6aWV0SGVJRmRSNVRneWJ0?=
 =?utf-8?B?WmF2b2ZNRjF5SG1XUWlHOFhubkkvd0l6VFdmQjdnSUNMV1ozeVJ4OHE4ZkY1?=
 =?utf-8?B?aW1VUDUzdEVqRWg4NXdGWS9ldGUzNXErSEN0NGxueXZrb1BtYUlyUDMrSW90?=
 =?utf-8?B?YXFia3l5N1Y0d1IyZWdtbWl5MnFCSldQTHNaNG5PS1VzNnUrRXdXSFZhcEhG?=
 =?utf-8?B?aVBBVFNhQjVxeUNvdDVWdUswalNTYnpsRTNyUFo0OUUwY3Y2YUpIYlQxZnR3?=
 =?utf-8?B?aU05ZHBaVUNkdDhIb3h5MTZKaGtYSmRXZmVVTjR6a0lpOE9FYUVWTjJ2ZnYz?=
 =?utf-8?B?Y2d3a1ZJQTNLR2tpWmhUOGQ2ekN2MkgzallxdDcxMmgvVDNucnhFU2hQd1pO?=
 =?utf-8?B?MnY3cjZxcy9LNHM3TUQwalN2V05WTnllVDZuZ3ZTR3piVysvejc4dWZmNmJj?=
 =?utf-8?B?KzhjcXhmc3ByR05TRjZ3dHhuNFpmTmVJUUZESWJIRVpwc0ROaUtOcHBEa0hx?=
 =?utf-8?B?cG1uWG1aZGdxbnZ1K05qQjlNY0c3S1R6Q2xSR0tNTTJ4blgvWGJadGlGdzhE?=
 =?utf-8?B?WVBHOGwxbHFrRjkvZFpZeVJYUzJaZGtQV2Uvb3d5TUNpVmVIM1N4L1dTOXpu?=
 =?utf-8?B?UVA4MExJR2poR0dndmduc01HVjRsWTkxRXM0dHg3ZEpycDZaUEZrcmtHKzlI?=
 =?utf-8?B?WjRUTWk4a0g0NmZZSytpbjRjS1ZFWm44OWpOTGVDdDJoU1pGVWVXVWtGajNj?=
 =?utf-8?B?dDF2ZHhXV1QrZW15eHo5SEpScnFMTEsvUG5relM1ZVhEbUh4Q3M5a2VJN3dh?=
 =?utf-8?B?UHd5VmluMGVWS3B2eElsMWZjdWhuQnJiWXNuK2hhN2gzQ3huS1J4VStsanVC?=
 =?utf-8?B?RmpmS2tiRnloaU0yZzJFZEQ1eGRVWXNyRjUwWXJ2MnB1VVRwTUVya1M2RTBO?=
 =?utf-8?B?bWFwU2Q1SUFnQjZaRytuZ2d3RVRpWnMxdG5FN1lONGFDaVJXa2F6TzNyUngy?=
 =?utf-8?B?ODRBNUg4aXF5Y1crL2djQ0g2TXlNN20vcUNGMk5zMkFvS3puODVjb2o1aHVC?=
 =?utf-8?B?bVV6ZXhiZWlrUDhVT0xpUTVaaEZENytJZXU5VkhXVFRzRTg5WUhyZ2lsdDRW?=
 =?utf-8?B?U3Z6MzR6cVk4SmVGY090c2FlRy9vSTNXemE4S2J5L3E1eUlOR0F4QmdtSjEx?=
 =?utf-8?B?UTBPVU84SFRIQ3BDb2thVXVwWHhnUUFQMDk4NGZNTXdNT0xVZERuUGc3RzZ0?=
 =?utf-8?B?TzBMODRRTmdjRjhNY1VIa1lSUHJKVDJUcmlZY08vRCtJcFFEUkFwWWdjcW1s?=
 =?utf-8?B?elB4aHpmQ3BNSGZjMjlmT082dUs1Rm5MSzNFWDZ1OG81VmQrSTl3WXl0eU1s?=
 =?utf-8?B?Rkd3WEwyTDA5NnBCZmZFKzhkb3UwRVJmSUdJdVF6SlZmQnpjSFBIbnk3eWtV?=
 =?utf-8?B?QTE5WFBlSmlndzFrSUlhRjNvcGlWZHN2QllaWGlQMUtoWlhXWVV2U0JOWlFx?=
 =?utf-8?B?eGozZk03RHoxUXVBYW1MRnd4QWFDOU1BS3BYUzhvaS9MT0ZMbU5Mam4wczRs?=
 =?utf-8?B?aFIrV1FudW9UaEx1SGNFMU1KdFV4VC91N3BFYnNvOUpDV2hwZWdYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46564AB377739D45ADB8B1056F46464A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KwkzYSuUQR60J274cTZ8+MIwiV9phZhQhngSJ237Cm/VbaZZql9rDTdyVEuxU/bku/C+0O4VK3fRESn/CflQjyFr1cuPbA7I1vSuDPg03KVJ2yYrUIvC3eBKzV5Ls54QO6s4iNHLPaRLQoPbhO+1zbCur07pe14OSLWPQtwsGcJidW1OloNLKJYDxqhSWAXKl4tSp0UK/0ii1qzqjoTeNo4vUaUcKMmEPJaB91R4LZEwykeoFArK1to0aTR8qabG//LW23MQy3vG8ZejvTD/DH0Y9LmAWR5faKeH/2/o1yJwwbspOHF1q0RJhdHoYR+TsZ8F77b0RdUTuSf4NlDwHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e1078-989c-45b3-9117-08dec16519ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:41:49.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVcRKKaH4WAQkNJnTyzMBAp4Qy9xE1KQl1XHCVavSttoWzJzFNHxrI1+ay16mhGEVXoVXTSxSOE+UE++gEe0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZW1vdmUgYSBkZWFkIHZjcHVfdHNjX2toeigpIGRlY2xhcmF0aW9uLiAgTm8gZnVu
Y3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlz
dG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8
a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
