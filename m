Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E33CFF49;
	Mon, 28 Sep 2026 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639937; cv=fail; b=alE0gU0KAA1Fr/eNKhHxbkzfbPmLZLeWErtnSRx+v5SeBfRZCpi0+gM3caNbqixQVo0obtPGWro5ndbXjNpDxjFDXKSxSGrQdwoSaQqkNhwILSWmeiT/he8VpPQZPuvCcxsbwIcgn2nGCTJymOzipga/iTTlOrOe7+qsHUyLn4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639937; c=relaxed/simple;
	bh=juwwEi7zBYeliVtHEMkp4UJ9uD7rkIPnYKvvQdptUPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YpxpSx8JBi3yJUI+7NQkZgILfJnqSOe09tgWJD9760GXAAfAR54tnZDw+uGBdceINWwYBXAaUvRciH3sSPX4OKS447uhXGmFFQT45dV+ejv1eftMA6Y33QfGkItK2EsVtrLFKl01OmJ2mzvUd/haIHJqlgFnPocmZc5d9j4hac8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1qYIzrF; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1qYIzrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790639935; x=1822175935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=juwwEi7zBYeliVtHEMkp4UJ9uD7rkIPnYKvvQdptUPU=;
  b=R1qYIzrFXPDXepkBN0eTjfL2b3Lu306dxQrKnbVacMfZZBYXwyRR/OBo
   WoXbzLmAkdmSg8AYq8Q8tOh+B+2cI6QuBqzhuawraS8Mpn8FUcOfot32Q
   flLLSytHCFS9NBo9KHohmsJI8riP2V2kzjLG6kN5uA3PO4qECjZl0ayZA
   aQQ03Ne41uQyIOqoAYK0h1Zpz5P6CKerZF4WtEjZ5/QraaHOoZfdistNB
   2JfBsQJY6RoKe858x7HQkEPhuRADEkaIaMx/8NkWMkOm/PJG1yKpsVdpI
   g/qwOO3h/V/XwfuPncnwEUFtNe3Eq20hPSpN5X3diBQcERNDhrvtnPj6I
   w==;
X-CSE-ConnectionGUID: sDDomrhwRiKtfqfpcSfqMA==
X-CSE-MsgGUID: owSsRKrfSVCBTAxNE/ymww==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="102011385"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="102011385"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:58:54 -0700
X-CSE-ConnectionGUID: 9t3xHA1GQkiD/QAaSSs1gw==
X-CSE-MsgGUID: 8moX8WFNTqeJ8jN8Ph6qQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="279007221"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:58:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:58:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 16:58:54 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCWgBIyiMUErXKpKsNH8IT3QcPXqcz1doiePgMO7jBkdu42+0vXRX2Ey5Uu2mRvb/whc6lpxHbu5KsOB+xshxx27YSzZfzb+4uF3nRnBRB/JQ8CTWn76USCg39YlDfnVRuMapepW/kKyD3XGsZ7p0bjKypaWhRDNfRQZ77xVO7JySLPJe61RSq596KW4tbKu+RJiZhF0mdtJYywYjp/JKWGNp6MBIVP8tyYgA7So1jhyf8AxJr7mK2g20Krf9qcv1xKiFrVVm5o1EFeYcRRHgHzqCkGxYw90ubIr66M1FuHYO7OCoPP1M8UMzcgdn5m2tG0cUiDyxwNHiIKcRWO7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juwwEi7zBYeliVtHEMkp4UJ9uD7rkIPnYKvvQdptUPU=;
 b=NnY9IrCtIqHJHgYBF2jX45D0KQepddyaCqyCUEGlk14tJxT62cqBFR6hNBKvxvIOjNN5m43MzqMN9KrMurWJUn8nc4lHuWtS2hxdbwwW7FqrDsY5YRiVpV2u4YkUjW1G8J2eKY8Lo4x7euTeor8O9Ey4GVgpC+ZL0h9pwmOYQnyQ6j1U/bv/CqdflpYabQAI1PynaqDEt42Wvt+jKc97JRpNTttZpie+dxbBBf3o088AL+IeM8at3xQOibXgryUZo0nrBXOwfcwHLE3VJECAjIgmpn9Xna3ib142Uqz1x9U5+71S9puguLhQamGbyA91tGwBGo1tmMw9YyrpdUVl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CYXPR11MB8753.namprd11.prod.outlook.com (2603:10b6:930:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 23:58:51 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 23:58:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "dedekind1@gmail.com"
	<dedekind1@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdRnUxZ7ir+OFvoU2rBazg3q+3u7bdURSAgAAUiYCAABwpAIAAJKgAgAAwDYCABd2cgIABCZwA
Date: Mon, 28 Sep 2026 23:58:51 +0000
Message-ID: <c2b669f099174c5d67593d5446a02abc43eff40c.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
	 <39047bbc-757d-4131-a25c-5a7743fd591a@intel.com>
	 <062f5365-7eb5-4e04-9c84-f5ecd566f019@linux.intel.com>
	 <eca53031-fd47-4471-9d05-d73295a0f57e@intel.com>
	 <8bcba51e-2a3b-44b8-89cd-aebfd1e50cfd@linux.intel.com>
	 <de109514-91b8-49a6-bbbe-c1f7f1ee407f@intel.com>
	 <c612e6cd-ca84-4c37-af72-9c13eeb1f3ce@linux.intel.com>
In-Reply-To: <c612e6cd-ca84-4c37-af72-9c13eeb1f3ce@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CYXPR11MB8753:EE_
x-ms-office365-filtering-correlation-id: fd03cf4d-9c05-48f5-a853-08df1dbc71dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: KatmgRlQ79H2+Wy5a28YzGP0lKHG1d4UEp+vuOtWt/1GkWE62HWuYPWF42koqQwZ6dro/HNcUcgve7/wh4WajZDLLmReGgGEEvwL7PYM4viVka74k54j7d2KJPI8TbcUOJgT4JfZXvIumVert2kT1njZKRqn0p+xEew+bOyH/EoL0wI07ap5n3iebzkeV0KJNbc7YUr+Hp35BnHyus1QpvgCT6bNxKxa2VxeJvcy9DQWm9SOYPES4T4A7MTpcKl7j+rmhhQtqzBex88VD6xDN2rrV2b0vHMXmaHRf7HzF8VilqL64d/Qx2PYcjZMDnBz4B3lv7RGkjFHhaO60eAfGxBbr5Mc952sPIZvO/kZ0f0t/0SiU2/yxLDVxefXyY9JhlZUt8rHk7dQbnKpUpPVfCQR/MSQpHMVYecmFUPL2JggGb3w7D64O2c287/9oWgdrE2H5G0Te49rhORgD1hYZa69rpY+6paPrsFj0Ww54+g3mPukS9GdDTxTbeDHBTwJnQ7dHDIvH5pikcNk8gS3zlxlKbnvinaQ+9qJivLbIHMLExFFdloe68DCDMRcuQ7Hk7F3sWFV0kKlW8dA9yPRyuXLmDDWm4jAh/w0oAEZWy2PqsiG2WrRJVyRpF7/FanfHJ/xwd7nGKLU0DFd9lfpSc428aUh8k0CsE+z62BY5zx+1xXWXMC1BG+IGatBthg9wJBwgueJxobk/rpk8diYykrg9eiXqsXN7HKnJt/HVdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNUcjd6ZFpxcU53OUdERmVOVVBNeHFscmM0QXg4Y1l5b2h4ckJBNTAzdlVS?=
 =?utf-8?B?SFRSdWhLNUY1dnpLRUNKT1FZSnFkUkVHTlJKZzZtdjdSTlF6bE1pejBBTXdi?=
 =?utf-8?B?alJZRnNlY1pOazN1dldrNUs4Zkg5TEJpaWVHd21vWXB4NnlUSzYvRGY3UXlk?=
 =?utf-8?B?MUNNWHRZRjFhZ2t2VkNPTC8zNVFvZjVvOW9TVHFBUHBpbTZmTjdSRG51MUZl?=
 =?utf-8?B?SXA5RmFWaXZ3Z1VkdExXeU5EcGEyRmszNnNaU3dhMm93U1lDdkIyZXd0eHVF?=
 =?utf-8?B?Y2dxcjB5eng1RitoVHM2bDRTUG1ZcFBLbCtDb2RRRnBhQk1WNnJuWVJNS1Ew?=
 =?utf-8?B?MC9lUUdGRzQ4Qnl5S0F4emVZVFdYNHZhK0xqbnUyREtOUnpkRlVTQ2hlenZX?=
 =?utf-8?B?Y1Q3SjU3TFRucjc3TUJLYUc5T2ZTTmREazlVQWJLZkYyZlFvNEllTkRBdVNT?=
 =?utf-8?B?Qmd3T1Z6ZWlabmdEd0xnZmRFK2duTE5xYjI2RDdhcGhocjBpa01FbEJ6STFM?=
 =?utf-8?B?RlYzdGNjOVd5SlA5ajFKUFFvQ1V3a2t1czNlWkxIQVZ1V1RIRmFHRW1qcDlq?=
 =?utf-8?B?aVNYME96bGFXcVY2NzlwTFpPa2JWTDJpbllwd1BNTjR6c0FBUTEwditaMUZX?=
 =?utf-8?B?YU1DM1FXRXRuMVVheDJZcTV6YTZ2eStIQmNRbExnd3pMbmk4WVlxYW1LbC8w?=
 =?utf-8?B?VlpoQUJ1S2U3K1BNb1pMRUJLazJnUy9CWGIrTjJhYzViei9DMFBVZ01remFj?=
 =?utf-8?B?VndCbWxCSEhhd3FPeXlmbDJha1NjNHpvOTZwVVM4N05IYVZ2ZWFSK1Y3bkQv?=
 =?utf-8?B?czFlRmFtZlFQMWVRbzJ6NklZZUZ3K2VwUSswVit4bGNsWlJwWmNoWE1icFVq?=
 =?utf-8?B?ZWxlNEdmU3lkdXNXTEZqZDVnK0RDQXA3OHVEZE5UMDh2R1ZpcmFMTXdnWXY5?=
 =?utf-8?B?V2U2SkRObVo4dmhzRDBFeC84OTVVTGs5bkVpUXJubkYydG1wd0p5ZlQ2UlFx?=
 =?utf-8?B?Um1CcmtiS1lid2o5UHF3L2xGdTlIb2tDWDBxY0tweXBIRkhrQTNUbGhabnFI?=
 =?utf-8?B?aVlweU10MU8xTWFZVXBuUTN6WDN0YWJXKzBJb0lvNlBYYnAreElVRE5FVTQv?=
 =?utf-8?B?ZGk4MktNNklvek1rczBQTFVYYkorM293QXNnZWpSSjRySUlpVnoxY2tNblF6?=
 =?utf-8?B?aWgwUVJLUm9hZHY0dGNaNGV5STk0TXI2dlo1bWg0UDNoeU1SSTJLVk4xYlk3?=
 =?utf-8?B?VE9SSXdWRHIrUjdScThlR3VVejJ1NEdmckR4Z2x1akJjWXJkT1RSWFJBNisr?=
 =?utf-8?B?NHgxTytSNnFtVFVCT0p2elB3T3YrNldWcUR6bXAzdzVwVlppM0wxZGVGbDFY?=
 =?utf-8?B?dnFvbG5LdFNHdi9YYmVzUGZPbENNM015U2wzMWZmd0doblNmSVljSEk1NXZT?=
 =?utf-8?B?MlJhaTVWNGhxWnFoZXlWdWhvYVJkZzhuSGNGVTF0U1JSeEZXNGo0WXIyZGxX?=
 =?utf-8?B?R3R4bFFXOGhPQW4xL0dUNERtUkRKdFA0L1I2S3VoMVdnUUhCYTFTNjlRYjF4?=
 =?utf-8?B?T29sNUI0MEJxbXI1dThpWmNrRkNDcnFtTFZnbEU3L3ZoRi9qNGN6Ukc5OEhG?=
 =?utf-8?B?QUt3NHhaUDB6MGFEOUU1c2MwMVRlWWVOOEVJc1cwUjB4UGRVUWJzd3QvZDZz?=
 =?utf-8?B?emNFZ0ZZQXlLRnVzRTNyQUk1MTNhVDJDazVGd1NHenZETXVYLzNYYnNmNGZi?=
 =?utf-8?B?SXBpN2RXVDZBRGhBZ0Z1S2t3MmlVbUVhajM5TDdiMnQ4SCtWTC9QaElqYUR6?=
 =?utf-8?B?Q293UU1TQ25XL1J0U0hiWmRjTDdxN3FUaGRhN3VQRjNYR3FHMGFYOFlmSUd6?=
 =?utf-8?B?QzlCb0k1SE9yS240bWNZdzRvSnNNSEJoZjJqY2hjSlJaRzM0K2wyR1pRaEVN?=
 =?utf-8?B?WUZoWEFlYUV1VC9HMG10aVd4ZjlYbzhxeWlYOG1WRGw0dW9JdHQ2eDhxWlJo?=
 =?utf-8?B?Ry96QzBTRksza0NrSUwySitRT2NQMXNIRUNwdElPRDBUSDFOL2k1WGdnODV1?=
 =?utf-8?B?d2dZYzV0L3YvcG4xbk1ydGh4cUJFbG9Rb1BlN2t1blBtSzZPLzlVY0FRTXlN?=
 =?utf-8?B?SHNCc2s0ZFd5TStPM3Zjb3hhTnRkYm8vSFV1U3EvZzV6RmpHSzBsVmxab01O?=
 =?utf-8?B?OElScy9MaFFmYXhqRGlDUTc0Rk84bVBuYVo2cm1FT1RmNSs3S2FkQTlnMHdQ?=
 =?utf-8?B?VzFhSmJnREFGWmFRK1Q3c3h5WDdWUE1yMCtpR3BjcGptQ0tETXFwV1NWeGFK?=
 =?utf-8?B?UW1QckFFVFVmUmVQVUlLVUFNN0UvaWcwRCtWNG1jUUVSTXM4aVFBWjJpaG9R?=
 =?utf-8?Q?m3ZSDJD/FpXbj53M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A71854ED067A147A63E87B6DDE8747C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ktZHaeogyLKn2rXtv0SVz/3JAULB/HUx0hgKAPpYUxwCrTl0ENpaeYMDHEuM5KvydSd4ejHwqyn21KdsJOs29avuxovzGBJb3EhuGwvvmmygyoEVAIgGO12gYNAWvTBjoC+8pdw6jFi2Wb1KBCvPZtKdIvMsGLpZ5SlX/D1sHxqJD2ln+V2uEj5uBl3tg6V7WNwaV/zZ7Fyu2d9GpWcXi7NLbAnzSL3Mvlp5awJGF2YEHAQ8S8ID3xoIOpv3QQwGzpTYXIzNtVzNbV/QRvunkndKNGckBx0ZGmnoc9+RHbx+iekuySoVvoof/B50f5qiuaE3xpnn7PSh34/Yd5EtTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd03cf4d-9c05-48f5-a853-08df1dbc71dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 23:58:51.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCHsTENKRHzX0w4XavGpno2T1mbgA3mOLheuVDuY2IekDC9De4lhmE5aVFbUa+llUcaepoQI1GsAAPRTvt920bxAkp7BVp4wAluimD7Hel8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8753
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE2OjA4ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
PiBJIGRvbid0IGtub3cgd2h5IHRoZSBDUFVJRCBpcyBkaXNjb25uZWN0ZWQgd2l0aCB0aGUgTVNS
Lg0KPiA+ID4gQnV0IHRoaXMgYml0IGlzIHByZXNlbnQgb24gdGhlIGhvc3QsIEkgdGhpbmsgd2Ug
Y2FuIGFkZCBpdCB0byB0aGUNCj4gPiA+IGFsbG93bGlzdC4NCj4gPiANCj4gPiBJIGhhdmUgb3Bw
b3NpdGUgb3Bpbmlvbi4gU2luY2UgMSkgdGhpcyBmZWF0dXJlIGlzIHJlbGF0ZWQgdG8gaGFyZHdh
cmUNCj4gPiBwcm9jZXNzb3IgUElOLCAyKSBLVk0gbmV2ZXIgYWR2ZXJ0aXNlIGl0IHRvIG5vcm1h
bCBWTXMsIGFuZCAzKSBubyB1c2FnZSBpbg0KPiA+IGtlcm5lbCBmb3IgdGhpcyBmZWF0dXJlLiBJ
IHRoaW5rIG5vIFREIHJlbGllcyBvbiBpdCBhbmQgZG9uJ3QgYWxsb3cgaXQNCj4gPiBzaG91bGQg
YmUgT0suDQoNClllYSwgSSBsZWFuIHRvd2FyZHMgZWR1Y2F0ZWQgZ3Vlc3NlcyB0aGF0IHVzZXJz
cGFjZS9ndWVzdHMgYXJlIG5vdCByZWx5aW5nIG9uDQp0aGVzZSBraW5kIG9mIGZlYXR1cmVzLiBJ
ZiB3ZSBndWVzcyB3cm9uZywgd2UgY2FuIHJldmVydCB0aGUgY2hhbmdlLiBJZiB3ZSBhbGxvdw0K
aXQgZm9yIHllYXJzLCB0aGVuIHdlIGhhdmUgYW5vdGhlciBsaW5lIGluIHRoZSBhbGxvdyBsaXN0
IGZvcmV2ZXIgdGhhdCBtYXliZQ0Kbm9ib2R5IGlzIHVzaW5nLg0KDQo+IA0KPiBNeSBjb25zaWRl
cmF0aW9uIHdhcyBtYXliZSBzb21lIHVzZXJzcGFjZSBjb3VsZCBzZXQgdGhpcyBiaXQuDQo+IA0K
PiBCdXQgdXNlcnNwYWNlIGlzIGV4cGVjdGVkIHRvIGNvbnN1bHQgS1ZNX1REWF9DQVBBQklMSVRJ
RVMgZm9yIHRoZSBjb25maWd1cmFibGUNCj4gYml0cyBiZWZvcmUgaW52b2tpbmcgS1ZNX1REWF9J
TklUX1ZNDQoNCklmIGEgZ3Vlc3QgaXMgYWxyZWFkeSB1c2luZyBpdCwgdGhlbiBldmVuIGlmIHRo
ZSBiaXQgZGlzYXBwZWFycyBmcm9tDQpLVk1fVERYX0NBUEFCSUxJVElFUyBpdCBjb3VsZCBjYXVz
ZSBhIHJlZ3Jlc3Npb24gd2hlbiBpdCBkb2Vzbid0IGdldCBjb25maWd1cmVkDQppbiB0aGUgZ3Vl
c3QuDQoNCj4gLCByZWdhcmRsZXNzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLCB0aGVyZSBpcyBubyBy
aXNrIHRvIGJyZWFrIHVzZXJzcGFjZSwgZXhjZXB0DQo+IGZvciBDT1JFX0NBUEFCSUxJVElFUywg
d2hpY2ggaXMgdGhlIG9ubHkNCj4gc3BlY2lhbCBjYXNlIGFzIGl0IHdhcyBkZWZpbmVkIGFzIGZp
eGVkLTEuDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8gYWRkIFhUUFIgdG8gdGhl
IGFsbG93IGxpc3QgZWl0aGVyLg0KDQoNCg==
