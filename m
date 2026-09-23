Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04245408626;
	Wed, 23 Sep 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203945; cv=fail; b=ptOIJX5K7YsrovsUSR0/YAAZzxSCv00C3WPa0l2lucz7rzkFFd7Rg4Pvz1MX63chg1lUD8RAMEk5Uc3DNdpGPI6M/Qtll++oRy0EWPJYqGQaiwRqZ1EExF29/Qwk/3wHqZhP0dzyLBxXGNzuDWiguwgY6VjK+OFmIl0Cu/2PLSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203945; c=relaxed/simple;
	bh=yJi7A57fe6qqfYgpx/ghbCfctJjMvt7mf2D6Oh9REBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7sVCHic/I8YEt9ewUQCccC/+wNpPcsfwFrTYc7XWZji+IO3C7ou+ILUioWOpOscOp6ZmrAEFtKtDIh0fcitrmPyjSz8XLwkede2iUCEyvkOXuZhNbpf4dud0PHhiQdM/4TLFfx4GvSX5Ty3dIMWB9NdvREIX7XSCmuYb9od77Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUz1pc9E; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUz1pc9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790203944; x=1821739944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yJi7A57fe6qqfYgpx/ghbCfctJjMvt7mf2D6Oh9REBM=;
  b=RUz1pc9EJx47eysjozreaHJyUoqaiII6bFipE7jgbaTKSxyP2Vauf92w
   qVEKGZeIiCASU8qZtlRUDRFDxJ5A5WlcPRaTAvrUYEDoQ+JQoJVt2aaRh
   Ud7nb9Uv5iqrmvx5yGaU91wtloUm2hKSJenN0O32oCT0HTua+Y9/7P73h
   vtNa63AfN1mNY45DohGthM9wozA4O/pgMV/Hjy1+FgaYnDsJfWyLj4hfz
   cpKXQ3k9FDD1tN0y3GKrllVfixkSj4EsD0CASf91fyXB4khp4q0LYTXtp
   6oPah9w9+nTyQHxqmblbrY7zGdKU3qYIjq4gqe8dGP3JCVX4tCN+XcOPk
   A==;
X-CSE-ConnectionGUID: QYM0u9ZVS+G42ddtM/Njxg==
X-CSE-MsgGUID: m6nWRmqrRselrFoWQVqSAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78506538"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="78506538"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:52:23 -0700
X-CSE-ConnectionGUID: ezJnHDr8TxS/FuMte7O0ig==
X-CSE-MsgGUID: gsGfie/NSJC0cqGuQjwsAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="278549500"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:52:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:52:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:52:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnL5MRSifYOFzQIThHFsX9b8LbL88f/hP9cth/5dl3rD8FGgxSq88GmgSGE0aekXwkRqsKpC3gvBeSSI5PNyM5JnQpPVJrAyB9/0kYSi/9+Qhj6r90QAMoXJuYm4hWad4p/M103MOrfeddiIGhfP40c1RFEBHWyMH/lvK2zMIy80c4sbr+qyo/0fbs1Kn3rlwvYkWfRXaWzIkQOdr+mjNBZLRA1Hfjj5J04o/qAIbf9WSTE5uPr1j9i9aakL4y0y/j/PU76R4ZpPeM6tnKiLCwdj8awCVaW8WBi4Cmbq2wYtwenWv6PfQEvzuBbNEcY4muenAXmiOw61CN22AV7Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJi7A57fe6qqfYgpx/ghbCfctJjMvt7mf2D6Oh9REBM=;
 b=IU4B2EnN3z7me8hUIXO8K5tx1PcCWCUU4FCypK/IAnrjyV79hOLXcEKS7/Jjhf9DV2xh4aq6s8TVKC0X3JL9jT6wJ8k/UZdrpuh0s6LZtLI9xMsXo33gfTd6MMAo/yrctwgJjnBl8U/anuQSCH5iO/bxm1im/u61WY+wnHcF5vdoyOZp3taLZKLBDHTNAiJyvoa3jyd/UoANd9PhJ5J/0HoV3u4L4hVF+bamYrw3rpYhSrSvGoXwbKrqR/YNFedQfJaawh4V/5iYQ43k2hZkScrV/fzClsuL4fl5i3H/W+TsLB9XXtvRtQaAD5d1XNsokSgrOLpkzHm8zNgrrINlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 23 Sep
 2026 22:52:19 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:52:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Thread-Topic: [RFC PATCH v2 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Thread-Index: AQHdR3IV6RyI1ljue0CIwvf0DSDmTrbczXmA
Date: Wed, 23 Sep 2026 22:52:17 +0000
Message-ID: <f3332010d452fa3466ec4fa4f6f69e0ad3ca06d4.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-10-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-10-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: a7260731-9f25-42aa-d575-08df19c551a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021|6133799003;
x-microsoft-antispam-message-info: iVtnRkYZyyJBYkwRWsDG8+B4CQgA+FKiwMuoasbfNbJ69/FqtoQ28Is56YZvFu5JYc3c6lQWB++O9ki4aaRiHlCTLZ0Im5LmT/5oa4a0DVx/9ydPaUm1qMKGKVFzJhN58ceQ/RI4cbDuiCyAbymp5M4yn2xFsWHVd54aBhKgY40wsM3v4ICgFNwsGmqm2/tQH1rFRnMpMvn3F2rKoXFnbokISwwzeUAOKlKhEU89yCkVlp7nmBc0KgN9/st2JUeFyQKDOIijbM17l0t6Es/csr5xvTEfhmrjN+/y+sCm/MhxSfgqLz8mVbOrXFDmzU5K2I48XsPP7ERHbuuefRqNlI0Nprik/MA8uNk0XCdNK5opFGl8XVb0m8Q97msG/RTOs4xoPqDg+Sr8fIScUhFZX2vqRBAYJ92bE7ESfdvKBQmka81XyrcgZYfyXU1iZ6ur61+jRTj8lIczjiIMfM9J1SL49RQV1vZAOBzloDiAcigbkMnBSn00ud5yjoeG9DrIAXMxmMRDQkEc6eQO25xzUoCSmf8JqQq53OyBd+dN8dVkduaVDT8NDpPuNZSUXAA25L58Dz4nmQgt82g5z5LuLxiH6kdaZzEQObsVLkCiPHnyE/bvzH3SmBY4z58q/KKgKIFRO223TLWJujESxnM0OtSOnkgs6afzKOnZj5OpfHFxrtM62/60tioAXINt4KdNlAA7roowHnjAdhQAndmAWNoHoLYxMG/8BpP6WKK6uu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0Z0L1ppWVIrbzVQTE1Yc21UVDZMcy8wZGVhYjlIZVBsUi8xa3l0em1zeTB4?=
 =?utf-8?B?anBzL1BVMzRDTDhWaDNudFJqZmxWWmZpWk81MXgwUTVUQkhtV2lwZ2J4THRx?=
 =?utf-8?B?NkU5MmJnR3IvM0dyUXZaY0RrRHhFUmhlRDBYRlFkMjN3Tno3VGxMd0NaZSts?=
 =?utf-8?B?U1ZhU0FwbDVnZ1Z2b0xsaVE0TlRyZWRTbnJlUHZjZTlHeTlOUnV0YWw0VkRH?=
 =?utf-8?B?eFNnSGxBam1uWHZwbVA5M0ZoSTgwL3B2VnlQTzNGSzhQRXlKdDhHemxFNWJU?=
 =?utf-8?B?YU9pMm1EdktEeGh6VlZIMkJGQW55QWRQQ3A2NkZBWFBWTGVoYy9ycVBDemZ1?=
 =?utf-8?B?Rkdsb0xNekpzWmVBa01RRUVWcEIvOGdSN2hmTVhDMHpTNktkU2g5MmtmYmNW?=
 =?utf-8?B?OXNnY011ZU1iZmxlTWpVYUxCdXVmbU5yZ3hFSHpubWlwTUt2UGt4L1ovMkxM?=
 =?utf-8?B?cGpoQzU4Nk4yMDlJK1RCa1NYRGNKd002aDN3T3ZDRlNaNDNSVlNHYVVxTE12?=
 =?utf-8?B?S2ROTmx3elhEZ1BZZXd4ajFJWmlwTjdiTEhOcnN1YmJQTmRSZFA3YVh2b2tu?=
 =?utf-8?B?TGlzaS9EZzlWWnloVTJEMjZkYkdjRkhhcWh6UDJTUTNTeklnTGJ2aEovYjNO?=
 =?utf-8?B?KzRDako0a1NmbGN1UUplTm5wNWhiNEYwKzVmY3Q0cE9EYW5XZ1E5MWlUT3gz?=
 =?utf-8?B?OFg2ZHZKREVsOFU5ZFh3a1lRMFJ5bnBmd0xJVERxWkJkTnh6U0FXNDNISjJn?=
 =?utf-8?B?emV3RENYY2l0eEFmL0pnSlp5UHQxblZjeEp6WEpjVytjMkZBemVYMUdPelk3?=
 =?utf-8?B?bFB3cGZSR0pHWXdaWG1uMzZkMlA1b3FLTGdYdERLMTJ4cGhic0Vnb2xFUStZ?=
 =?utf-8?B?U25wSGJVcTlsTTl0Uk1nK0phT1VFN0pIYnovOVJIYXJRamtjU00zQjJZS0NJ?=
 =?utf-8?B?UGkrbk1ZNkZHLzlGREpSbGdYdGJYVjdTVmp0ZW5STEZaTEV4bTM0M1NtYlB0?=
 =?utf-8?B?bjFhb28xeklrdEhzeEdXdGFldnZ6ejhrNjk5UzRpQ2Q4c3dCZ3FXaW02aUti?=
 =?utf-8?B?cENjR0prQTFqZUhlQlAzdCt2a2h5UEo2ekVvdmF1WkpUbC9TVTdmVGtja0kv?=
 =?utf-8?B?b0VVbzgrU2JXa29EczFzb25yMlJtUVJnK0FhMlppNDJJaVVLcDc4OUEzcU56?=
 =?utf-8?B?am03UUJJQmFEOUNKNzBLVWFMUS8vWlBzK3ZNVG4wTm5TWFVnS1pZbFI0OUx2?=
 =?utf-8?B?WWlyOERFYjVwWGxyQlNUTG9VaWx3T1dlcVJRR3VWUnF0cWpabSswclN1SWpD?=
 =?utf-8?B?eWVIaUNPL1VpSEgvaVFIYjFUTlVUUnFzVENDSXJ2ZUdPNkFCcHBWMkpLQXZi?=
 =?utf-8?B?K3RtNXFoWW5kdXpmNTErcUxSZllxZll5VjU1Wi9ZSm5GRS9kR2wrak5yeG94?=
 =?utf-8?B?ZVV3bUlkUll1MGVNbVAzZ0NLMGJUSDZCYm5OWlIzcENLTmIxcU9ibUF3Z2VB?=
 =?utf-8?B?a3FEVjdISDJseFNpSzk2TWtwSjRuU1dGaWFWSlBXblA2ZW5sTThlcGJMaGo3?=
 =?utf-8?B?QnRwZllwVEZ3Vnh4Ry8xYlV5SUhxWE9IR2pTWTJYRk9rRm82ckFranpBcWRu?=
 =?utf-8?B?RnVSWkJ0aTFsRkhnQkRuZTBIWkZoOUlWVDBJOWtpMmthb2RkMzhQdE40OUVM?=
 =?utf-8?B?UWY4TWhUdUNBNUNRQ043QUtFNFhKZGRBRTg2Zlk4dTMwaEdDSWJOYTFUZUlz?=
 =?utf-8?B?eHVXbXBqSk43SCtHRHIrUk5KMFcwQjNoYzNrcHQ1NlprY2h2QUJEUk5mRU9L?=
 =?utf-8?B?QXl3dlg5QVBYN1R6MjgxYndmd2xreUJUN1NMU09saXdnMGNPbTliN0FvUUZB?=
 =?utf-8?B?VkpaZUtFU1I4cmNkOWEzS1ZpYUlZQUV1ZThPWVl2TU5OMzM5SndUcUttcTFU?=
 =?utf-8?B?eFM0L2VCVlB4WXNjVmFQckZXOGJpZzh4bEpBR1Ywem5KSEQxN0orSnJEd29U?=
 =?utf-8?B?ck13aDFPQVVoSDMrMnIrZ2M0Wk0zL3JIWHJEbXRScDBiRkRGL09Gak9wZnQy?=
 =?utf-8?B?eGZzOHVhKzdJSHgxOTJlSWVXd1A1eDhPTDVTbFg4RDQyaURQaTVJbmR4em9Q?=
 =?utf-8?B?NDdCUWUwQyt4VHo1dG53YUgvZUhOWDByZnlUVUNOaHQ0L2s3Vm1GVUtiTXNq?=
 =?utf-8?B?V041cTZDRllQUjVCYXVUNzhVQ0pWdThYYjBEdUt2bmdWOWExUFNRYmVMTDZi?=
 =?utf-8?B?aS9ZRkQ3NnkybEhCYzJIbmpWMURWYU5zUmRvRlJubGR2bjFTa2R3V2kwMWls?=
 =?utf-8?B?ZXc4dUFVMUN5d2VXWHBjUmE1azJTZHVFdVE4SFNsU3gvQjZaWGgzSE5DZktW?=
 =?utf-8?Q?7f6jdFyNB6dBM6nk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3D9521B104D6D4F821489AE5722DDDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cE8thMzd5mSQRJ7Vd675BGvcJR4XFbRPn1obwsD/9/fpYbw7Zj8ZJBDlYM8H3OGNzFc/2tC5z9zmeCduJolsWU35TmmyMBxKMRYT4R8ZLoUop/YbE6MkzTcqCD6YDdlpGuFgz2b6kMAFgcSgG5GdiHOZ3oPxPoiFreGGlzsJpRD2Ty/GVPHAnjW/mOAYPenko4uedV0WUg80QZduYv36nll11Yu2RjpvjU0b4Wd9+nZ/9b6Hl2xyzeth8EtuisWlLMPojC8XSiAXGczKuHDw7evCqFTDr7Tml/nW5OMmemhhvSUGV/a2X3zpC0MX5Ciz2648V7nI2ZmQSxFD8Yw1/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7260731-9f25-42aa-d575-08df19c551a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:52:17.8489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOpdbJf8m7HjHhjhStpJVoF3gjpeItrw2n4dYy9/mrAKUxSoal/WDxbD0ixxwn6YnT+vv8DexfbcJNJdY1PPYz//UDnB0H8owBGlSd9dEQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gZ2V0
X3RkeF9zeXNfaW5mbygpIHdhcyBnZW5lcmF0ZWQgYnkgYSBzY3JpcHQuIEl0IGNoYWlucyBpdHMg
bWV0YWRhdGEgcmVhZHMNCj4gd2l0aDoNCj4gDQo+ICAgICAgIHJldCA9IHJldCA/OiBnZXRfdGR4
X3N5c19pbmZvX2ZvbyguLi4pOw0KPiANCj4gVGhlIGZ1bmN0aW9uIGlzIG1haW50YWluZWQgYnkg
aGFuZCBub3cuIFVzZSBjb252ZW50aW9uYWwgZWFybHkgcmV0dXJucw0KPiBpbnN0ZWFkLg0KPiAN
Cj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNpb24gdG8gcmV2aWV3IGNvZGUgYW5kIHdvcmtz
aG9wIGxvZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwu
Y29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDMzICsrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92
bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IDlmOWYy
ZWY4MGY1NS4uOWQ1YTMyOTZkM2MwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC01NjQs
MTkgKzU2NCwzMyBAQCBzdGF0aWMgX19pbml0IGludCBnZXRfdGR4X3N5c19pbmZvX3RkX2NvbmYo
c3RydWN0IHRkeF9zeXNfaW5mb190ZF9jb25mICp0ZF9jb25mKQ0KPiAgDQo+ICBzdGF0aWMgX19p
bml0IGludCBnZXRfdGR4X3N5c19pbmZvKHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5c2luZm8pDQo+
ICB7DQo+IC0JaW50IHJldCA9IDA7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAtCXJldCA9IHJldCA/
OiBnZXRfdGR4X3N5c19pbmZvX3ZlcnNpb24oJnN5c2luZm8tPnZlcnNpb24pOw0KPiArCXJldCA9
IGdldF90ZHhfc3lzX2luZm9fdmVyc2lvbigmc3lzaW5mby0+dmVyc2lvbik7DQo+ICANCj4gIAlw
cl9pbmZvKCJNb2R1bGUgdmVyc2lvbjogIiBURFhfVkVSU0lPTl9GTVQgIlxuIiwNCj4gIAkJc3lz
aW5mby0+dmVyc2lvbi5tYWpvcl92ZXJzaW9uLA0KPiAgCQlzeXNpbmZvLT52ZXJzaW9uLm1pbm9y
X3ZlcnNpb24sDQo+ICAJCXN5c2luZm8tPnZlcnNpb24udXBkYXRlX3ZlcnNpb24pOw0KPiAgDQo+
IC0JcmV0ID0gcmV0ID86IGdldF90ZHhfc3lzX2luZm9fZmVhdHVyZXMoJnN5c2luZm8tPmZlYXR1
cmVzKTsNCj4gLQlyZXQgPSByZXQgPzogZ2V0X3RkeF9zeXNfaW5mb190ZG1yKCZzeXNpbmZvLT50
ZG1yKTsNCj4gLQlyZXQgPSByZXQgPzogZ2V0X3RkeF9zeXNfaW5mb190ZF9jdHJsKCZzeXNpbmZv
LT50ZF9jdHJsKTsNCj4gLQlyZXQgPSByZXQgPzogZ2V0X3RkeF9zeXNfaW5mb190ZF9jb25mKCZz
eXNpbmZvLT50ZF9jb25mKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KDQpJdCBz
aG91bGQgbm90IHByaW50IHRoZSBtb2R1bGUgdmVyc2lvbnMgaWYgaXQgZmFpbGVkIHRvIHJlYWQg
dGhlbSwgcmlnaHQ/IEkNCnRoaW5rIHRoZSByZWFzb24gd2h5IGl0IHdhcyBkb25lIHRoaXMgd2F5
IHdhcyB0byBmaXQgaW50byB0aGUgZXhpc3RpbmcgcGF0dGVybg0KYW5kIGJlY2F1c2UgcHJpbnRp
bmcgemVyb3MgaXMgbm90IGEgaG9ycmlibGUgb3V0Y29tZS4gQnV0IHRoYXQgY29kZSBwYXR0ZXJu
DQpjYXVzZWQgcHJvYmxlbSBubyBsb25nZXIgZXhpc3RzLiBTbyBJJ2QgdGhpbmsgaXQncyBvayB0
byBmaXggaXQgaW4gdGhpcyBwYXRjaC4NCkJlZm9yZSBpdCBraW5kIG9mIGJsZW5kZWQgaW4uIEJ1
dCBub3cgaXQgZWFzaWx5IHN0YW5kcyBvdXQgYXMgYnVnZ3kuIA0KDQo+ICsNCj4gKwlyZXQgPSBn
ZXRfdGR4X3N5c19pbmZvX2ZlYXR1cmVzKCZzeXNpbmZvLT5mZWF0dXJlcyk7DQo+ICsJaWYgKHJl
dCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGdldF90ZHhfc3lzX2luZm9fdGRt
cigmc3lzaW5mby0+dGRtcik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0K
PiArCXJldCA9IGdldF90ZHhfc3lzX2luZm9fdGRfY3RybCgmc3lzaW5mby0+dGRfY3RybCk7DQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGdldF90ZHhfc3lz
X2luZm9fdGRfY29uZigmc3lzaW5mby0+dGRfY29uZik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gIA0KPiAgCS8qDQo+ICAJICogVGhlIGtlcm5lbCBzdXBwb3J0cyB1c2luZyBU
RFggd2l0aG91dCBEUEFNVCwgc28NCj4gQEAgLTU4NCwxMCArNTk4LDEzIEBAIHN0YXRpYyBfX2lu
aXQgaW50IGdldF90ZHhfc3lzX2luZm8oc3RydWN0IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykNCj4g
IAkgKiB0cnkgdG8gc3VwcG9ydCBidWdneSBURFggbW9kdWxlcyB0aGF0IGFkdmVydGlzZQ0KPiAg
CSAqIERQQU1UIGJ1dCBkb24ndCBleHBvc2UgdGhlIG1ldGFkYXRhLg0KPiAgCSAqLw0KPiAtCWlm
ICghcmV0ICYmIHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoc3lzaW5mbykpDQo+ICsJaWYgKHRk
eF9zdXBwb3J0c19keW5hbWljX3BhbXQoc3lzaW5mbykpIHsNCj4gIAkJcmV0ID0gZ2V0X3RkeF9z
eXNfaW5mb190ZG1yX2RwYW10KCZzeXNpbmZvLT50ZG1yKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJ
CXJldHVybiByZXQ7DQo+ICsJfQ0KPiAgDQo+IC0JcmV0dXJuIHJldDsNCj4gKwlyZXR1cm4gMDsN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIF9faW5pdCBpbnQgY2hlY2tfZmVhdHVyZXMoc3RydWN0IHRk
eF9zeXNfaW5mbyAqc3lzaW5mbykNCg0K
