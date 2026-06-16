Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7E397AE5;
	Tue, 16 Jun 2026 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594949; cv=fail; b=RQDFv32ZSRnzOiD4H8lMo9XGOGezm0KSXNfFprTsipPYdkpsGJmyReXky/eH7IqzB8KxbtvbqkjG8O+2+N0J4MwKXbcoGD1lyzN1A08jhXcEpJeBV8D/bchmHZItPeK5ZpTwLzK3j+cZNYemdyNIlqUJIydQ3uyvpdhxOSdGsu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594949; c=relaxed/simple;
	bh=ercDCN/zW8mH8GRav6kq3jbIGLTJ9RYYJIlsvDlnshA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1Ow+759ze3YEOd6BgA50TsiezrhR9WUQSS1qpWdSk0OpKmdekBvGGWHWwrNBXURNp8bbfIuBXgYV2ofSZEQFoFSIlcpbbVdRgb0ThQw1iNFyicbnynZbggT97gPRwdKK8rFM3ea9OKyWLYJaCosquliSg7nWlL9xrnuLQO2ZR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhtjgYnQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhtjgYnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781594947; x=1813130947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ercDCN/zW8mH8GRav6kq3jbIGLTJ9RYYJIlsvDlnshA=;
  b=NhtjgYnQJCXNPhHl4/PpUPaZgQtLI2k5gi+RdZZkBeXcV0aKH3TL/coO
   M3leTOk+6WmZfpJfEb833yMDjcYC6ws3LR4KNgK2iJFmmGMIuSdy2WmCC
   D9Y5/9jzS4nvoZG0aG9YgmBj2xtse8nbsUiKd8hDlMzbi8cvmZcXO2gXC
   ucPpUK38UnOuoHdvRzcwJuRVFyB76JlRme9NA9V2cLlP7r4onJgY7T1cw
   SwuwVa7oMcydf1ZucNmWaDAMIE3c3nD8fjaGsHUG5sm4EAqRx+/9marLI
   dGYELOIA7eA64xtqx/n/3rlctSXeGInPS5eEaPT+9tXda+xyqte9AFUlk
   g==;
X-CSE-ConnectionGUID: Jlktl3gpTB28GCTg8xzAlA==
X-CSE-MsgGUID: WJXWpKDjTLq2w+WfDNUC2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82547686"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82547686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:29:07 -0700
X-CSE-ConnectionGUID: PfeufetCRieqhp0RYLVzcQ==
X-CSE-MsgGUID: l5hxW3GkTkCn1Gvhf4BiPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="249584060"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:29:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 00:29:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 00:29:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 00:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB0cWBpKKi6brc2l8dltBBYSL7ts84JiEB2Fran2l+K/ttqa2BuSclWjjaMmKvK1zP3bfJxsPLOaHE7Buga+gEnvlb+X3w+bewn1u0zhrPg5xj/48xOpEwwXdKbwj92jtmatxn6K9yLwc6ms9II1O1g+0eTGW/5QQwm5FFvZJz428ZMRvGBB6oufXdZ81BcM3wrqBSO0VskOcw3ZFWQsjwi3zaDeIEHrxfTCKdksiS4AD0METyV/fktid8llhXy2RlbQs22VX9AwPNbcWpB1GLGLSl/L0nbxI9odYTmnHVDk5Iyx227c4zM1Eb8hBTGMDWvKbIZtVOAEfjc//EfsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ercDCN/zW8mH8GRav6kq3jbIGLTJ9RYYJIlsvDlnshA=;
 b=x4qag7eKkSxHhnRdEJfc0scni1uOcADoeokPof7ToHNlU8iDLYMqSzJt1nCZGYT2iWRttUTHkHWI2UpJbV3K5ItJF0i7O8J6NnEmH8ngNZfMjqQAGzMkzSTjgz7W8qr4FJ/FjDo1flVkZSAJY5BdJF+KWqeHD8T+q/FpSvZe0tkAFG4i6Jf5Uv6k7lYngK6JrsiFZ6LaJO9DPlLkhWrJXfmobGNpIWH6BERh/Hn6mHLWO60KLnTEaMiQB54DkVgphqqWT13kNhNEegnRrFiZsC3+j+zdvM9jAtGY1twDxaWvSic9angDSSZaLG9Z67DMsb5Mwxv2Q94z5aLyaNYlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 07:29:01 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:29:00 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Topic: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Index: AQHc+sgqXLeuA1RU9kGzdjSHRH7/w7ZAvW0AgAAQmQA=
Date: Tue, 16 Jun 2026 07:29:00 +0000
Message-ID: <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-19-seanjc@google.com>
	 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
In-Reply-To: <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH0PR11MB5173:EE_
x-ms-office365-filtering-correlation-id: 60727f3a-21a3-4134-3056-08decb78ef7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: r/VaFaMcmGtkKFJ+CkU5WdNc32qrRJ0UtChF0WHBFU4pmqz1hOD22tJ0VxGONRNT/rd/EGqNx+VAQ9jTuMT5FMBcGWTl1MP3LJMBhD9bFhnjZ68h4ErJ3aED6eZRou8/4ALv6h7D7syTaAOi/ES6EBncCwZbAPEXcx9S+v/HT5nNaNMMPHIEZzvnHaDFrPMojOddTaZxffkNvEFCrRRx1uX7a2Bql2HYkNbF8tg5NH3DQyaTsLFmYudtkXqpQ+ZUUY26/ESTxllxr3mXJVprDQfs63xTsYHzRgLhHj+FctuBwstKx+NXr39LhxaZZXhK65EnxQ/+VbOdfRzbq8MVOEnk3pMvR6FKvjk7nxI9pxfrgh1hCalMyWpaC5ptR+mu5gwq4MQajYGvMsXeAOeLGNoQcvZY3TGeBmGn4rG/OKL6JPE6rJ8sdiAg8SNkJ/4JkebFmWXLp+OH1/GB/GjDD2dPaDDNz/f+TtP8LyQqbotUWbfy5Rvd/BYfoEd6NohGrnPPSrpG75HbALclyzRVZbw8peALcy2/PAGDUVKZUB3ekCGl/4s+87hJPFxffpA2kJo+9/ZmE1ZFFnR24pG7kkTM9foydFUOxVdmRQMCMiY3HthTQafdpq9egS5uCXG6gFvFnzZh4b30tTS8D4W14Mwj/SaC5p/bX2r1I0pFv3EOQs/jiki6FWQv6QYZW8F3e2D5FxWigX3eTJzjZE34cG4KfplC7O6QanrJ/eX1+q8EuAl8FTGoEa0OQWtpPGRF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlI5U3kweEpTa09DTzVLVG1FREFKaTNDc1d5UnR4aGxsUm5OKzZ0aGQ3eVFV?=
 =?utf-8?B?bEdySkErVHhYd0NVK2srSnVOeDhwbzJtQXoxV1VmOC9oajZTdTc4bUdjdSsw?=
 =?utf-8?B?L0xvT054ZWx4dlFTZ1lrRmd3eXh0Mms3Q29SZkFON2U1WnpNVE45MXZ0UkJE?=
 =?utf-8?B?blVnUWc4MDg5Ynp1R0daSWNYdnNGckJNY3RqUkQyQk5UZElONzd5QnF4MDNw?=
 =?utf-8?B?YlpsMzJwQnU3a0w0RExudjdJMkZIcDhRNHRETkhRMEpCRnNXU25ueTkzdTNK?=
 =?utf-8?B?THg4c1ZydVovN21FT0hQdVZTSG1MMzNMZ2dTZGl0NWExREFzK1EzKzNUUnBy?=
 =?utf-8?B?MWM2TXM3b2FJVFBHRFh1QWR0T1ZZSjUzZkFWZzloYW9Eam43bG5Tb2U2N09n?=
 =?utf-8?B?SnJkbTZDcWVKUkl5dC9wdXVBVEg3VnhiMWo3NGVwZDdCOWJGZXRwS01ObGla?=
 =?utf-8?B?ZHlRQW1GdzduNnFlSnRRU0pZdERFaU9FQWlSbll2OERRUjZYcWkvYnhsQ3BV?=
 =?utf-8?B?ZnVxKzVzcE1KVE95Rmo1V0hTOUVuOU5DR2JhajFsV3JTMmVhSWtkMFVxSUZ0?=
 =?utf-8?B?ZFhBVktvS2FTTHFOWklaYW9zYi96dTJkYmprYldJbE53YkU2MWQ5TmZPZXU1?=
 =?utf-8?B?ZE4yUk42SXpTUGFqaDU0aWtzUXJQMXJKUTcwZ3FvR21KY3Q2b0QyeVRGQnhF?=
 =?utf-8?B?Sk8wcWFWSi9hSzFVU25GTSsxbFVIZ2hUQ2lLMkRvRWoxTy96dGxvaTF1NXlH?=
 =?utf-8?B?QVBibERJQmg3U2JlMnZrMmQ0OUpPbml3VFR1SmRsNi9RS1RubXFNWnRMK3Bx?=
 =?utf-8?B?YlNLQ3FrMjl2MTVYMGxwbWFLckVDSjFORWhNakJ6QnZoREg0a3h0QTZwSmpn?=
 =?utf-8?B?eGxDVjdRS3VSRjFHbmo0ZjhnSmJjcTFVUWZNeEdoR1ozZWl2aVVqVXkvQmV6?=
 =?utf-8?B?UGhSZnJ4WjBnYlBmNFhRN2RqcDJWbnl2WEhMTTRwZnc4ZXVWNkpnMFBHb1RT?=
 =?utf-8?B?NStUZDJrc0VsQ2w4MHA2aU5aakp1RXVNMnBVNitCOFNxb2REbGd1NTVyMHU2?=
 =?utf-8?B?SFVPUFFsTnVsMU5OR21SR0RBNk5taDRsWnVUVU1JTGI3S0pucXZjN3RCSGVl?=
 =?utf-8?B?dzJDbkdQcXdxS3JoeXg4NUFrYUVuZnFRSGxYRmVlald3L3JFRWdrQndmNXhp?=
 =?utf-8?B?M3R5ZXVsUGlKQnlFNFdYL0N3ZmdzWWJkOFV2cUdMYnBLeVJzQ3dFOGx0cTBH?=
 =?utf-8?B?dGpqYW1TTmNOYzcrcEFyS0ptN0VJWGxielkrQUhiUU5hK1VTdW40RmJrTkd5?=
 =?utf-8?B?RWVyTUNlWkdwZHh2Y2w0MGpHWXVBaWF2QkhiUFJrU3FqR1lCKzJQT3JiZ1JR?=
 =?utf-8?B?MWh4dk00SUNkSEdUb1FENFJaVDZnOVVQSTlPNkZRUUJqVXNyanpSM3RwWWZs?=
 =?utf-8?B?V3NoU0RrUkxqY2Z2UUJPbUpSZ1prbDNyQlVhdVcwbFpBSmNpQXhwWmEvb3ZJ?=
 =?utf-8?B?NEwvMWoyMVVtY29ZVk5PZFVDeWpyckp0VmJmZDFaVWJsRzBXYUYzZ2JXLzJJ?=
 =?utf-8?B?UWpQMjJtTENsQjMrd0dkb01YbWZKOVdDWXMvV0hNZHNsVkZuYk1yT21vcG1o?=
 =?utf-8?B?LzBQOTFQS2w1VnFNMjB5TFBDaHAvY2Y3d1ViZXA0NmpBZ1BucjN6a0ZRVWxI?=
 =?utf-8?B?WFZxbStKcGIvbVBRcktFaDZQTzNKeS9kRERLRGRMa2xIdGhWc3Q2R0ZNSnM1?=
 =?utf-8?B?REtLYkttYVRncGk3TnVDOTAwL1h1TUlXa242QkJaMDkwbnVPbHBCTDM5QmRI?=
 =?utf-8?B?RUsrSXJ3MDdtQ2p3aWxVckNqUk5ENE9kcFUxMzNkcW1JRTRYNWhRT1YvQzdp?=
 =?utf-8?B?L2Y4Wlh0L0pjUWFiNEN4NE9LbUQrODg0WHNBaW1EVjh6M2VJRGQyZFVKTzdk?=
 =?utf-8?B?OGNUbG5yK3MxVWJ2MnV2SHhCeFpKcmNEQjFzaDJBMUE5RUhpK2Mwc1M4YUdI?=
 =?utf-8?B?eUpYRkU5Wk1NTkg4aDI2aWZKcVc3d29Hemc1VUJxUGRVNXJ6SVExdm9jU0lV?=
 =?utf-8?B?N1JvajlSNWZORDcybHVsd1V0VG5WMyttY2Z6WkRNYlRpMndiM1JQZVVJTnFS?=
 =?utf-8?B?SnA2aStxcG5HdjV6b1RsNzZEcXBZcytqanlIWmRsdkJHN1UxL3dDbGhCdDJE?=
 =?utf-8?B?b2R0QUJyeXBONE1Yd010b1dmZ2tjbUNTYnlPZEh2YUJ0TEhNMDU5VmhyWDFC?=
 =?utf-8?B?NzlYOVZRRHM0SVhHOXpOWHBsaktnaUt5VXR6MFFhbUxubk41bVViU2ppcGpC?=
 =?utf-8?B?S0pUUmJHZDNmeGFHUGZBTHZnbXNKTldvdEVjUEVUOUNGMTJESExSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC6C8B95CB9034D9FAB29543CA780F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D54T1F0LmpYGpwawZK6SLBstlRXunFWxEZS/FFgLZzGzZANvyhelmN+ar/fhWXTD6RfvEFdQTk1hWTAenZvSrkf9XM14oaAP0nSfnHVUty0Q062MkhGfJ2WPjm4WQX1qef6DyHJwBJhMWo/ZDtzVRRzGuk5xc7gQYZ8py/wWTwfdbbgMCd/n0VrdDQ/deHSnA2hllkqh0DIG6itoRyG4LetfGtSxxG4p9ClWmSDKZYo++HJw9kPU28Kae6M5ww6TDThblZtdalv9/H0Wgw8bi0cQwIpVXyoR14eK+utGFPCeouHKkO/wDG7vwClHj7om3s8iHfKRJsI2QItAmBzdpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60727f3a-21a3-4134-3056-08decb78ef7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 07:29:00.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8FysygVFBLsUnQJTXwdWUXzKOEiz4AvuZ2vxh7v62jKMYpFvW/6qcc05jMBmjm/LOF4OB2znYZkQCIZSZC81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDE0OjI5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IE9u
IDYvMTMvMjAyNiA4OjAzIEFNLCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPiA+IE1vdmUg
dGhlIGRlZmluaXRpb24gb2YgInN0cnVjdCBrdm1feDg2X21zcl9maWx0ZXIiIGFuZCBpdHMgYXNz
b2NpYXRlLA0KPiA+ICJzdHJ1Y3QgbXNyX2JpdG1hcF9yYW5nZSIsIHRvIG1zcnMuYywgYXMgdGhl
IGRldGFpbHMgb2YgdGhlIGZpbHRlcnMgYXJlDQo+ID4gdmVyeSBtdWNoIGltcGxlbWVudGF0aW9u
IGRldGFpbHMgdGhhdCBjYW4gYW5kIHNob3VsZCBiZSBidXJpZWQgaW4gbXNycy5jLg0KPiA+IFdo
aWxlIHRoZSBfZXhpc3RlbmNlXyBvZiBmaWx0ZXJzIGlzIHB1YmxpYyBrbm93bGVkZ2UsIGFsbW9z
dCBieSBkZWZpbml0aW9uLA0KPiA+IHRoZSBjb250ZW50cyBkb24ndCBuZWVkIHRvIGJlIGV4cG9z
ZWQgb3V0c2lkZSBvZiB0aGUgTVNSIGNvZGUgYXMgdGhlIGZpbHRlcg0KPiA+IGRhdGEgaXMgcHJv
dmlkZWQgYnkgdXNlcnNwYWNlLCBpLmUuIGl0IHByZXR0eSBtdWNoIGhhcyB0byBiZSBkeW5hbWlj
YWxseQ0KPiA+IGFsbG9jYXRlZCwgYW5kIHRodXMgbmV2ZXIgc2hvdWxkIGJlIGZ1bGx5IGVtYmVk
ZGVkIGluIGEgZ2xvYmFsbHkgdmlzaWJsZQ0KPiA+IHN0cnVjdHVyZS4NCj4gPiANCj4gPiBOb3Rl
LCB0aGlzIGNyZWF0ZXMgYSBkaXNjcmVwYW5jeSB3aXRoIHRoZSBQTVUgZXZlbnQgZmlsdGVyIHN0
cnVjdHVyZTsgdGhhdA0KPiA+IHdpbGwgYmUgcmVtZWRpZWQgc2hvcnRseS4NCj4gPiANCj4gPiBO
byBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gPiANCj4gPiBTdWdnZXN0ZWQtYnk6IEth
aSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDE1ICsrLS0tLS0tLS0tLS0tLQ0KPiA+ICBhcmNoL3g4
Ni9rdm0vbXNycy5jICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20va3ZtX2hvc3QuaA0KPiA+IGluZGV4IDA5ZTQzN2M5NDdhOS4uNGZmNjMwNGMwMmQw
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCj4gPiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+ID4gQEAgLTMxNSw2ICszMTUs
OCBAQCBlbnVtIHg4Nl9pbnRlcmNlcHRfc3RhZ2U7DQo+ID4gIHN0cnVjdCBrdm1fa2VybmVsX2ly
cWZkOw0KPiA+ICBzdHJ1Y3Qga3ZtX2tlcm5lbF9pcnFfcm91dGluZ19lbnRyeTsNCj4gPiAgDQo+
ID4gK3N0cnVjdCBrdm1feDg2X21zcl9maWx0ZXI7DQo+IA0KPiANCj4gSnVzdCBGWUksIHRoZSBj
b2RlIGZhaWxlZCB0byBidWlsZCBvbiBteSBkZXNrdG9wIHdpdGggYW4gb2xkIGdjYyB2ZXJzaW9u
IHY5LjQuDQo+IER1ZSB0byBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8gaW5jb21wbGV0ZSB0eXBl
IOKAmHN0cnVjdCBrdm1feDg2X21zcl9maWx0ZXInIHZpYQ0KPiB0eXBlb2YoKS4NCj4gDQo+IEl0
J3Mgbm90IHRoZSBmYXVsdCBvZiB0aGUgcGF0Y2gsIHRoZSBpc3N1ZSB3YXMgZml4ZWQgZm9yIEdD
QyAxMCsgYWNjb3JkaW5nIHRvDQo+IHRoZSBsaW5rOiBodHRwczovL2djYy5nbnUub3JnL2J1Z3pp
bGxhL3Nob3dfYnVnLmNnaT9pZD00NDI1Nw0KDQpUaGlzIGlzc3VlIHdhcyByZXBvcnRlZCBhdDoN
Cg0KCXJ1c3R5IDIwMTAtMDUtMjQgMDA6Mjk6NDYgVVRDDQoNCkJ1dCBvbmx5IGdvdCBmaXhlZCBh
dDoNCg0KCURyZWEgUGluc2tpIDIwMjEtMDktMjAgMDI6MTQ6MzggVVRDDQoNCkFtYXppbmcgOi0p
DQoNCj4gDQo+IEJ1dCB0aGUgbWluaW1hbCB0b29sIHZlcnNpb24gZ290IGZvciBnY2MgaXMgc3Rp
bGwgdjguMS4wLCBub3Qgc3VyZSBpZiBpdCBuZWVkcw0KPiB0byBidW1wIHRoZSB2ZXJzaW9uIGlu
IHNjcmlwdHMvbWluLXRvb2wtdmVyc2lvbi5zaD8NCj4gDQoNCkJ1bXBpbmcgdGhlIHZlcnNpb24g
d291bGQgaGF2ZSBnbG9iYWwgaW1wYWN0LCBzbyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBkby4N
Cg0KSG93ZXZlciwgZG9lcyBtb3ZpbmcgdGhlIHN0cnVjdHVyZSBkZWZpbml0aW9uIHRvICJtc3Jz
LmgiIGZpeCB0aGUgcHJvYmxlbT8NCg==
