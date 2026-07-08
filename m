Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC17384258;
	Wed,  8 Jul 2026 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551280; cv=fail; b=d0H2+B7FjJbnQULMJX3ddcrTMp3Cte/pALMCZ+57Y9LL66DhG1G1p5dZ93PoaIPQFNizaZt5BRXOK5xAebn+OZxbhb5AcQs+o79xEh41CopHtk11qE258aF35IiKY/PTIAyJYDSkeRKA8iWpEhZOhezhScA/2z+t7x6mo0AE5j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551280; c=relaxed/simple;
	bh=u0D6lIhIGtpfDJLqiYhiMn9yC0OIcx2FRVVrCEr3r60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nI2sp24Z2vjbdls/U4yvY8u86ZLETf8idQMZmTok7Gp1ii+SIu0drOB+HVFSiof5XBYHO4UpY9ZsQIrgT+V0xb75Fji9CKlWmaFJqrXifA8vLB8U2SRk8w3FW025FRGoO2dQkMFe/uYZ5rnJ50jRZaRTKdZJ2kFtynkE3r+RM/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcWcWSBT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcWcWSBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783551280; x=1815087280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u0D6lIhIGtpfDJLqiYhiMn9yC0OIcx2FRVVrCEr3r60=;
  b=RcWcWSBT688YiTCXdaKeD8SWxZnFIlYHr8Ui1xtlQz4xt0D5uDueebmV
   8iQln5gCtwU7ZrYixfuJPI6JM56h4lWHwq/VjjOHPp/XkrjpeJyRSFxsd
   8wO0Rwjhujw8eihbWMdx5bHHHqhjhlKoQNbfLS4Sh2Ml1+tgRozW7lWxu
   aemMZTCk/kR07HsdLHNtjTUz7Ay8irIEfDkxIQwG9iAjuKF+Rxwu7kkUe
   r/c+XJHUscrFvlDqIs4P8fHI28g4dfczc7Atdws12fRD2bVVpJZ6+KhsL
   CdCVRCYDO072GgBDeITfWVLZ+DHJlJL116nV/ukoLT+bOngLvgIHQ0rBm
   A==;
X-CSE-ConnectionGUID: aaCbX2ycS5KqQJB8wQi+vA==
X-CSE-MsgGUID: VeUO5ojaQXqOWchWgMiTGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84008720"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84008720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 15:54:26 -0700
X-CSE-ConnectionGUID: q5s4Y1RpRx2cSK4mDWXaaA==
X-CSE-MsgGUID: zzhwvWvgTaihp4ewR6zcnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255065238"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 15:54:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:54:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 15:54:23 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDYPZFPzPyfW0oMilOtW82Kc1PnNT+KOvJBl3mQE7dczErLbJa4SWenYStQp6XXpI1FhrUmNmsav71ezqRN7Mfm2T8jaasMnfzeMKUpAuI5UrtgdY0tDBSnhNS6CH7wG0/JlEp4sOsEfzTmA/gNO50kJYrP6a7VCFRScCnpo5CttKcIflazUQcbwVca6RBt0h6BTCosLiB/WeXY6Vhi9HZpd56txFAzyr4fcwa1HiMnxSvlnB09E7gjEnVSup+FBoWP6VW2v6Ok/PrMmMZO24SuYTdPf1lVN65lzAh9nUZGHfkZrxD6KHDbc7oPAcJKRzFMl2uUzVD9WTs6kVZ++ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0D6lIhIGtpfDJLqiYhiMn9yC0OIcx2FRVVrCEr3r60=;
 b=zTEFCSYvo207txN/Fw2kO4MUVSeQmpSyqqBK13TZn4Y+Ic5eVe+oo+BTDig20qEx6zXQfvq9msCkJowWCKB9FkaqTngzBKjYvbkk5/kUcPXwQh9DscdSpcElcBqkXCFBu8wHCmGbYu/0zIdDK01xiHC/roBR59TQK3iH4sGA73vp6uiIoQ3zFL2P0Snhp3++BkRdIlBe8qVuitRElQTAaEdb6U8xI3nf8fpUXBup1fAPIz5PS09GPCvx3bhD5pGpy4whxwJdd9tDkBaxSbWxacj2CcH6b7JsL8jCXUFlzy/5icGXnsLC8mo+WsuZT5DmXHnkISEQk5XQUOOCAqfecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 22:54:18 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 22:54:17 +0000
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
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHc7LhWCooE6IHqmkuIiSt8p5dGSLZjQGWAgAE/jwA=
Date: Wed, 8 Jul 2026 22:54:16 +0000
Message-ID: <e268cced7f18e0d25997a9dfa1e0150f34d5bd60.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
	 <7d39a92a-0555-41cb-91dd-96dace318dcf@intel.com>
In-Reply-To: <7d39a92a-0555-41cb-91dd-96dace318dcf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DM4PR11MB8180:EE_
x-ms-office365-filtering-correlation-id: 712e424a-8cb6-4367-cb19-08dedd43d6d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|921020|18002099003|38070700021|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 5Pw8XPnhlbG6lVcRj2HDrKpKYNVmk5oALrdloxzkJDqTKy1IM523/zDNBMkwgHZyZz2E2+6LJZAha9pWJ3vzBbblUXqVq6NrmG4xBjZ0wxoqYgDljP8SUUNgQ5TmCPXVjOGw3j0zzaESzaQFSC3LtxJlzaD+yyR+Fug4itmognCOHYSOvcEXwKUAkeMcLeZZLL7wngLc0ljjG3bqlu4BgXpKck0zJxzpjKyUfpAbB0NpghmxQ7fZwlqQIw9BNEXNmzOXQttn+Js6eJvuqXCTa5hMuYOf1yasnrVJSqKL5QhbGLM4NDry0WvnRHPGqI6ajcXS97T5JU3NPEl5Wud4LgU757BDZ3S8vMXW+BkbxXSe292eJFspfxE+CfgzWKUQfYEq6VxQysR91mH2b5l+MUR888WuCJ3NW5+IG0Blc2U8jFe8M73Um85OAvQrBiFCkzbw1beV++Z1AZJstTP3jO6Z8o5jqOxrH2WqIEE0HjW19tht1uRURzK+UXw2VLgSUwQwH+sUL3djvwmzikzIITiKViccASFQdPDATXbXLERbJPS7jtAqkKWVmhHtFZXUnjNIYYVHkrzyOUJfHVaT7bFXq2epOWUkv3Qm//Tu7WtzBEta39tePvK+kKl1vixGsjZ9EujH1AjjiBjytaezStRYYFlto+oJai1SnB82DYLuTdEuSo6WQUrjqP9YFGzGSGSrG2lCAVEIY6chTGiqKs6Hlt2rUb9i/L9oxMX/Af0EygFLqPxwPqH7v4PVI72g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(921020)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXFoSFZHenVGMWljdnp3S1FYL0I3UnNyTVY5TDFqclB4WXNtZ1djWFFhZEJ5?=
 =?utf-8?B?Rldvdk1rdDZobDJ3Y0taVVpiRkt3ZUZ4MGVFcDlnSHY0Vm5XeGdncW13bUNJ?=
 =?utf-8?B?SWowS0F3bnZDWTlhU3hweFBWYkRoT0E2NFYyNlIwZmtzZU1kY2J1enlTNGdQ?=
 =?utf-8?B?Sk1HWW1wTk1rdlJqcnpkV2VGMjhPemFkeU1DZmFhSzZFeGV3VE9naURBbWtI?=
 =?utf-8?B?UXYycnRnVklpTjFDN3I0TUphK0RPbG5xUElyMVFMb3FObUJlQzRHQWEvb2xD?=
 =?utf-8?B?VFU2OTFMdmJnU3Q3M1d0bGVsemtJbEhSaFlZSkZFSHZtQ3BZeDlzU0Jwb3Bw?=
 =?utf-8?B?VWlGZG04M1BzcUFocFJaQmVtTFh2UjJsUnc0NTVhN2VLQkdsS3RJSkdjVVJt?=
 =?utf-8?B?Y3V2SlpTeWpScUxVUnRoVFlJNTFVb2EwUDhHbUZGYkJRdWJLNlZMYzV0VGRi?=
 =?utf-8?B?dEt6SW5FcUo4S2ZyRTQ3WmZEUFloOFpZZ2RaanJiMWFsUlJoNVhkL0FYUVdX?=
 =?utf-8?B?M2NIQzNjSTBoYkczSllscS9SSDUvUzA0QlVRSHRhbG9oMWZQaU93Z2pSU1Jt?=
 =?utf-8?B?dFZpcWpPenV2bUlkS1JUbFV0TVRBeVNSaFFTdVV5ZUd3aEljdHo2eGNJVDgx?=
 =?utf-8?B?bFU2RnRWZlRuSEJKL1FKa1Nuemg4SzdvUHhERk5CN3VLemplclZYZURiS0dL?=
 =?utf-8?B?NENta3JFbFlhZGZXb3JsUlBZKzlkNWxOc2VybEg4MTJSYkRuWDJ6bGxONFZB?=
 =?utf-8?B?TnpwVXFHL05uRXVDVWthVy9MV0xpRDFkSU1ldnF5MFJJQjYzeXRManhCWTZ5?=
 =?utf-8?B?S1kwMWg3T2YrMytqWUs5bklma1lha0lueDZrTU1jWmdpQThwNU9nS0Y3Q1Mv?=
 =?utf-8?B?QVBKcmpGaFh1QmZzSDhjeGhpVlJYYk95N3JpYkoxZkNKZjF2NC9LTWlZMXhm?=
 =?utf-8?B?UzRGNTd2TlBkSFA3dVIrbk1FOVA3RU5LSDhiaW9qVy90ZmIrcTZVanlBT3Jr?=
 =?utf-8?B?VnhOTG9DbXloZWx0aHFGcS9PbDFmV0JRRVRCdkdpWDFyUkJyZkRIMlA2eXpo?=
 =?utf-8?B?a1dvY3JrcHRLeTJPbFJKdk82aFBLdkFFeVA1bUJYZW1TMmJDdjJDSDlNRk5o?=
 =?utf-8?B?RUJuYVVWbXp2Q0tBL3JnN0RZcFIxa1hDWHNGTEFJV1JTejJlQ0NZYmdwdzI4?=
 =?utf-8?B?cW4rYk9sWGd5d3luc2Z0c3ovdnVPbVZHaWJBRE9uK1piZmFSdkh1S2hLTXFJ?=
 =?utf-8?B?M0FRWnBVZys4NG1pWm9Eb2gwMXRCTnAwT2h1dExXdVNaVElqZk9EU0haeXBR?=
 =?utf-8?B?Y0dkcm5lSy9CMDIwaFUwdlpsWURHWEpvMTBwWTZISFVRdUs3L0dNN3NhQUdY?=
 =?utf-8?B?OGVtcEVLcThtK3IvaGR5YStxU1pWZVdqdWRrQzcxQ0EzWTZpSTkzYnNFc09Y?=
 =?utf-8?B?OG9FT1NCL0V1b2F0bHc3UllmVy9uZ3lqdlNjTnVYMkhac2ZDSGxpL09GZG82?=
 =?utf-8?B?aDBJaWJ2OXBJZGwzYTlTaThMejhsQ3VVLzFqVlgwZ05xeWhkMDMxNjEyTDBw?=
 =?utf-8?B?Z2lRT29LTWZCbUZyemh0Qzc1YzQrOVN1U2ptU3BJa3BaZ0lCUUtHeWRLOFRa?=
 =?utf-8?B?Ymd5anlEdnJUeDBBUDh6VnJ0cHpCMFloY2pMdTdEdlZoem5zQzB1eDJnY2R5?=
 =?utf-8?B?Y0UwdGpGUmVqSEFVSVRPSncrZ215M0dxNFM3M0lnSXFaN2RVODJqMzZpN2ZN?=
 =?utf-8?B?emNCSVc5WHZ0SzJqR0lrNGE2TFVxdlZFMkpyYVVYb3dvTktSallpT29TUm11?=
 =?utf-8?B?c1o5bFNueFBScDlsUFhhNDhoWk85QXFhUkp2dldYVFlXMXAremhDZmxCd21h?=
 =?utf-8?B?RXpOYUMwdlNiNDBYbFNEOWJhZWRoODdTeFI3OE1oSGdxTkNLRnZiTnJ3Q0Rq?=
 =?utf-8?B?UTF0cVlyeUpQUmg1Z2dMUlJyTlJiVGVNOFN1RTJYbmh5V3JrVVE3UkkrNGdz?=
 =?utf-8?B?NE1qNWUwNEFSUzhtWUZpbENKVzJuQjdMeVhNd1BKWFlxTlVFY3NldlZESFl6?=
 =?utf-8?B?ZjRiMnhmQVhHbmxqNXhiTGtJTnlaeExlRlpPWGdiN2tqWURLMUdIQ2RXQjNC?=
 =?utf-8?B?dDhWdXVZc09HUm5VdmxVNHNKWGx2T094L2RrN3J0OVU1N1VLbU9JVnlQS2s2?=
 =?utf-8?B?c3NGTDhsVHhlaFJJL2lVenZkc1g5ZTJ2WWF4eXM4US9TRUFlWGZ4VWJ2Vnhu?=
 =?utf-8?B?YTFKdUV1R1p2WUw0ZkxHZUo2MmhnUWtUb2tzVzBjRTZGZGRVTitXTjU0NTY5?=
 =?utf-8?B?Nnl6aFRWNG5IWmo3cnIxN3FtUE1yTWI0OGxOeGRDUzlleDJNb2tSWWVtakdY?=
 =?utf-8?Q?YgRzHEzlK0PKsxu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2633ADCA38A4334795CACAEF88B9D119@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Th76EGb3Sb0no78s6ansmt8MONRFErVEm/4CscxNNN6/M5jAYH/ntKKpN2CrbPWyUEPrENcPUikWyfXKIW0BerpJvNRTJRRXjXQZN6kAHD4CY0i70WX2Bt9to1O6osEDzi0FUDeImcS5neMDTnfWMPUlAGI6//o8Kr8BGyJtJvc9CHrWGi+ELEEKI/Bhc8Enk/UUHqrySQsipkTpvthyB4R/EGcI1Rs7pnYSXc02b0HuCzIN2PnVNvxDg1acjntIx8CJRGtuvX0Hw4OSJPJzl6pUhLW2zPgcfVUZdqlxntWj+5lc3u8IZ7JbKP6LCU1KohSX4gSj7q+xJpROaAK6Ew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e424a-8cb6-4367-cb19-08dedd43d6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 22:54:16.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QK8PoNvOLEzVks2oTbf9MCJ9kgLy4rQhZebcT2Q2gxyGQB8xGTQAXsd7ZaXSxJrCygUQiweeLuFpD5+15iE5ZcIbMC7TzXj3JwzE2kGuC3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDIwOjUwIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
SG93IGFib3V0Pw0KPiANCj4geDg2L3ZpcnQvdGR4OiBBZGQgdGR4X3thbGxvYyxmcmVlfV9jb250
cm9sX3BhZ2UoKSBoZWxwZXJzDQoNClN1cmUuDQoNCj4gDQo+IE9uIDUvMjUvMjAyNiA3OjM1IFBN
LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBGcm9tOiAiS2lyaWxsIEEuIFNodXRlbW92IiA8
a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiANCj4gPiBBZGQgaGVscGVycyB0
byB1c2Ugd2hlbiBhbGxvY2F0aW5nIG9yIHByZXBhcmluZyBwYWdlcyB0aGF0IGFyZSBoYW5kZWQg
dG8NCj4gPiB0aGUgVERYLU1vZHVsZSBmb3IgdXNlIGFzIGNvbnRyb2wvUy1FUFQgcGFnZXMsIGFu
ZCB0aHVzIG5lZWQgRHluYW1pYyBQQU1UDQo+ID4gYWRqdXN0bWVudHMuDQo+ID4gDQo+ID4gVGhl
IFREWCBtb2R1bGUgdHJhY2tzIHNvbWUgc3RhdGUgZm9yIGVhY2ggcGFnZSBvZiBwaHlzaWNhbCBt
ZW1vcnkgdGhhdCBpdA0KPiA+IG1pZ2h0IHVzZS4gSXQgY2FsbHMgdGhpcyBzdGF0ZSB0aGUgUEFN
VC4gSXQgaW5jbHVkZXMgc2VwYXJhdGUgc3RhdGUgZm9yDQo+ID4gZWFjaCBwYWdlIHNpemUgYSBw
aHlzaWNhbCBwYWdlIGNvdWxkIGJlIHV0aWxpemVkIGF0IHdpdGhpbiB0aGUgVERYIG1vZHVsZQ0K
PiA+ICgxR0IsIDJNQiwgNEtCKS4gSW4gRHluYW1pYyBQQU1ULCBvbmx5IHRoZSA0S0IgcGFnZSBz
aXplIHN0YXRlIGlzDQo+ID4gYWxsb2NhdGVkIGR5bmFtaWNhbGx5LiBTbyBmb3IgcGFnZXMgdGhh
dCBURFggd2lsbCB1c2UgYXMgMk1CIHBoeXNpY2FsbHkNCj4gPiBjb250aWd1b3VzIHBhZ2VzLCBE
eW5hbWljIFBBTVQgYmFja2luZyBpcyBub3QgbmVlZGVkLg0KPiANCj4gSSBsb3N0IHRoZSBjb250
aW51YXRpb24gaW4gdGhlIGxhc3Qgc2VudGVuY2UuIFdoeSBkb2VzIGl0IG9ubHkgdGFsaw0KPiBh
Ym91dCAyTUIgaWYgb25seSA0S0IgaXMgZHluYW1pY2FsbHkgYWxsb2NhdGVkLiBXaGF0IGFib3V0
IDFHQj8NCj4gDQo+IChQcm9iYWJseSBkdWUgdG8gbXkgbGFjayBvZiBURFgga25vd2xlZGdlKQ0K
PiBTaW1pbGFybHksIHdoeSBkbyB0aGVzZSBmdW5jdGlvbnMgb25seSByZWZlciB0byAyTUIgb25s
eSBhbmQgbm90IDFHQj8NCj4gDQo+IHBhbXRfMm1iX2FyZygpLCB0ZGhfcGh5bWVtX3BhbXRfYWRk
KCksIHRkaF9waHltZW1fcGFtdF9yZW1vdmUoKS4NCg0KV2Ugb25seSBuZWVkIHRvIGR5bmFtaWNh
bGx5IGFsbG9jYXRlIHRoZSA0ayBsZXZlbCBvZiB0aGUgUEFNVC4gVGhpcyBpcyB0aGUNCmRldGFp
bCB3ZSBkaXNjdXNzZWQgaW4gcGF0Y2ggMi4gVGhlcmUgaXQgd2FzIG5lY2Vzc2FyeSB0byBleHBs
YWluIHdoeSB3ZSBhcmUNCmNoYW5naW5nIHRoZSA0SyBsZXZlbCBvZiB0aGUgUEFNVCB0byBiZSBh
IGJpdG1hcCB0aGluZywgYW5kIG5vdCB0aGUgb3RoZXJzLiBIZXJlDQpJIHRoaW5rIGl0IGlzIHVz
ZWZ1bCB0byB1bmRlcnN0YW5kIHdoeSB0aGUgaGVscGVycyBhcmUgYWxsIGZvciA0S0IgcGFnZSBz
aXplIG9mDQpob3N0IG1lbW9yeS4gSSB0aGluayBpdCdzIGNsZWFyZXIgYWN0dWFsbHkgd2l0aCBq
dXN0IHRoZSBsYXN0IGxpbmUgcmVtb3ZlZDoNCg0KICAgVGhlIFREWCBtb2R1bGUgdHJhY2tzIHNv
bWUgc3RhdGUgZm9yIGVhY2ggcGFnZSBvZiBwaHlzaWNhbCBtZW1vcnkgdGhhdCBpdA0KICAgbWln
aHQgdXNlLiBJdCBjYWxscyB0aGlzIHN0YXRlIHRoZSBQQU1ULiBJdCBpbmNsdWRlcyBzZXBhcmF0
ZSBzdGF0ZSBmb3INCiAgIGVhY2ggcGFnZSBzaXplIGEgcGh5c2ljYWwgcGFnZSBjb3VsZCBiZSB1
dGlsaXplZCBhdCB3aXRoaW4gdGhlIFREWCBtb2R1bGUNCiAgICgxR0IsIDJNQiwgNEtCKS4gSW4g
RHluYW1pYyBQQU1ULCBvbmx5IHRoZSA0S0IgcGFnZSBzaXplIHN0YXRlIGlzDQogICBhbGxvY2F0
ZWQgZHluYW1pY2FsbHkuDQogICANCiAgIEtWTSB3aWxsIG5lZWQgdG8gaGFuZCBwYWdlcyB0byB0
aGUgVERYIG1vZHVsZSB0aGF0IGl0IHdpbGwgdXNlIGF0IDRLQg0KICAgZ3JhbnVsYXJpdHkuIFNv
IHRoZXNlIHBhZ2VzIHdpbGwgbmVlZCBEeW5hbWljIFBBTVQgYmFja2luZyBhZGRlZCBiZWZvcmUN
CiAgIHRoZXkgYXJlIHVzZWQgYnkgdGhlIFREWCBtb2R1bGUsIGFuZCByZW1vdmVkIGFmdGVyd2Fy
ZHMuDQoNCkFuZCwgSSdsbCBhZGRyZXNzIHRoZSB0cmltbWVkIHN0eWxlIGNvbW1lbnRzLg0KDQoN
Cg0K
