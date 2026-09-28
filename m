Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEE479885;
	Mon, 28 Sep 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629589; cv=fail; b=AnYNirfaSm370JyqZL/ivVTb4+V6G2xRVhRs+TF0fWb3eVk47eWIfYb+DF01tjkJOXmMT+jpbL3V73ZU6waqGWhLq9N3m/lapVr3wgV2O25b3IMH8lQG1gXdaYYNqK95vUBZQXm6MCP2u+rhmOF9fNtBuoDMR5YNRk7l4+4pnXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629589; c=relaxed/simple;
	bh=G+/r1F8yvzxg78DX4r/wKGd6/NGi+MhNa9ObEB1M9I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fTRngPSu0x9L18clcFcvPEiDn0awNLhWXlavX/9nkWgnES3kOIndmgGWR4HbEM6oDHJuwGhOSyAUaI4npuFtXWTxHh0f9O+Eh8XHrt0N9CiGEeArQDiv+KSd30ms5FFvPpj5hXKrDbOHGe8X6J+vVTXTjmrlWBsjcqXzH/ABGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRhglZ6Y; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRhglZ6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790629588; x=1822165588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G+/r1F8yvzxg78DX4r/wKGd6/NGi+MhNa9ObEB1M9I0=;
  b=HRhglZ6YIfrz2xML2UJyqI1sxUwOdJ4sZzbg4X4OA5+tZvviYhTsx/NG
   1qO/vAZdGIUYhqBImO58L90D/9f56oVUGZqyNWz6orpZ10G1jYMJiQTLG
   7LPtlSANQ6xZOl2ivK4OpJRIk/6CDACJpP8S9lR1v3NdpSsXErXxYIl/0
   7WiSmIF2rYAh3TDCIsmFImDG2ovTrYzOtLz5Rb3rynpbU+i3pgBZvj+wb
   1ZKRM3Dq6mRk8NMPycu5rapHJUyU8AiDDXpOrbh+lEClqQhQlXkXweP2Q
   oVTrmJeCbAggeCPDnzYH3zgxmo9ho0fuFVcpeimuPqD2jKUxOUEg5Q8ai
   Q==;
X-CSE-ConnectionGUID: XTkDOvTCQeiPz6QyX2skVw==
X-CSE-MsgGUID: bBFvP8KcSpm0dQtFfUtfRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90206415"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90206415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:06:27 -0700
X-CSE-ConnectionGUID: NS3z5PmySEaz42uQsX1GRQ==
X-CSE-MsgGUID: kSaZbHoPRU+Ae1hAuXpKtw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:06:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:06:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 14:06:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irepBRf7SwZSbUihDEMWHWoc6pzAIina99B/bhnpeBmzY38VaZCEBREoxomQqaENI5k5ds48tfJ2yCXLUJulze5af/t5RU3sm1gxrZuQrOQnbgaLJfkUJfztn1sGiiPT8xJD+vQsoOKA6zi0eP8k53IQVlASI5x2MG4wbM9s5gPw/yMgQijQs+1aJIwNJvwQIWkSngii7Mf3n/DrIUTFunLCfeo//UZm7dy9T+5bdOyXNXx7PCASIeNbusDwz9EIJm57CUmKIXewqUqYw+3b++pL9hJFKdj6AejtaXIUDG+4eNnmVNC/VLXWWmRJl/7B9PjRaHjQF2M9X3Al0QL9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+/r1F8yvzxg78DX4r/wKGd6/NGi+MhNa9ObEB1M9I0=;
 b=nUvfa1IM/FHVGe7vcAJKzpnD8Y2KAUFkUCFg9KMk8PDMb6HYVjpgWTCfG+/cU2EiUD4Ui5mWW7F8hHbMsQ46SAgcnHXdA7yzM7BkH1DZ48Q9/alCbwQYPUA3GJLrCnahR/Ls74/KeZdajGiqqcODwX5Yjxjn7lPOEveMXjyo8dKV6iG77X7EawvaNq5B3ZUrHkmvlPyYkWGrr6X+wCNRv9ekcIIlDLqbGu/Ue8SvCmyidgAcIv7eI00ZOy0+lrn3LnwRuWIDpQZj3Fnm6wKjIPUfn3IhYiWMsVXYGGBNLUKOgBucntv2epjPqEcj0q3QinC8+YXWAs1W78YamsJMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 21:06:16 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 21:06:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHdRPzRHohuXeHMhkaF5CbyB+xzBLbQJFoAgBRsEYA=
Date: Mon, 28 Sep 2026 21:06:15 +0000
Message-ID: <13ff769fb55f37a9e7a68bdd40815775ddc4ddb1.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-4-yilun.xu@linux.intel.com>
	 <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
In-Reply-To: <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB5874:EE_
x-ms-office365-filtering-correlation-id: a1d1e489-89ea-4b00-1305-08df1da455be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: +pcdUL8V5qUqlyyxoCJYVXZzOTlgMWvyLyrsD72avMVNmt3coAVQmjp+bUeyOe1+FRleo5UPx7RdEb1G/KyyBh/wdyLut6PlnUz566itLK/ph85geDY//ppiWOqzNp96Djf8trCy9hLhOvij5CdbFXap02FgaoBj71D7IOje7Zgo5r2zdz9pliCBrNv00WOpUxoVgfBGbaynycS43e1sYTAdM2c9BiD4vdVWzgp8ch+k+n4bNDNSlP8udWOrrhKwxx3tuPs+rRfcY5YPXyE5K5HSfNkA2LFvWEAFeaxD37E0aImyOl094QrXvh0PmTv4cA8qiicXlqps99s1eMkHGiiIyQdU8w/JpZSQDKbQs21OuGEi/FfhxxHrxvywV6dC6GkyDar5A+OxjwVqlFukvGXEojQ/eMNKFvAZgNDjYIDsYKLSRWTJi62KrKWpWTbLkuwZWzd3VGqJBDXnP2O0PXYREZRb/wDH37EI/pPUtyZxM5T2cl32Ugu9NZ3/MoTf8PPT0D8Q0MwmGx1P0NEBndS/sDIgHqWNa/XfN/LVLVKnoShSwE4IWimiPlCl8N39wktX7/6o/jaD13PExVzevcsk1ezB/uME1VCp1YV9UojC+aeo8IwCM8uqQtK0rAyhYt4p7anmOJBB8vnNythxwvOXGwOJTE7DwDzs67wd/2USYOzaY5dtiro/+bk+uYCchBLFIihzdSbqYh7ygbg7/betcGZIST9AScMefp4i1JA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhUUU51dHB6citDVC9wT1I3elZXck50bVY1TDQ4OTNEbUExVzhnOVJIMXQ1?=
 =?utf-8?B?amlabGM5dVJtQ1Bab1hrUGRJZUJ4bXd4dU5rSWhURkFRM3ZLTlQ3OWs1TDlt?=
 =?utf-8?B?bTgrYnhZNzQ5ZHpHQjdiQ01wZjIrWVdFMldhUTEzbWRjck1RS3E2N2hsRk1o?=
 =?utf-8?B?b1lNZWg0bVFVbGVmc0F0TVp6MkhPazB4SDFLZkxQU3VrMk52anBGWjlMNURs?=
 =?utf-8?B?WGcyaC84cHc3RHVTV1I3bUdQRUxOVHIvVUxZWVBZRU1mWkZDandpUjZDZ3RG?=
 =?utf-8?B?dHk5bUgvT2M2RlhoVFVrbUl6R3ZqYmVoMmNHamdSdVhsUTMybCtRd0paUDhN?=
 =?utf-8?B?QnBKUnYwTFlwUGlWTWdSVzVwdDF4OTUzTGpjN2o2dGpXUjMxVEdBbVJWUEhU?=
 =?utf-8?B?c29YZzhZNVFQRStINGhibVlMblJvNGFnVVcwcjBibGRKT0M1dDJlamIwNlor?=
 =?utf-8?B?KzE3K1pRSzhqSVhtMmtqaG8wVGtLZVFvWHFFYkJnSGhaUW51V004TjNVQjRZ?=
 =?utf-8?B?VFlORXhja3hIamx2NVRsNmplbUluWTNsQlQ1SldLbjNNcmlmMWV2T3hTMGZ4?=
 =?utf-8?B?S21LeG8wdnB1UGJCUHZYeWNEU01ybmFrQUFPajFSbmxMOUljN3lTSmFZQjhq?=
 =?utf-8?B?QVpMd2ViWHZVMXZFMnE1cEFIbXFVK0x3Z1FoY05kdWV6aXFmWDVGWTVMMTFr?=
 =?utf-8?B?c3JycHMzYUtOeGRGUmJrQnl3YTYyeTNJT0x2OXhCQ3FxbEZBS2N1WktocCtv?=
 =?utf-8?B?elEySFhoWUhMV1BvOXp5Tmg1VklENEdCVDJsVS9BQnhXUkpaVy8yYUU3cVJp?=
 =?utf-8?B?U3RjWlMzMXN0Y1M2Q2FKbWFidHBrQ3g1Ym0xUUVFRjF2TmViYmdIMzh0eGM3?=
 =?utf-8?B?WHY1bldlRWhxMnU0cy8rYi9pTG1mUVU5QVpCQmVoTkNtVHYwdEQ2MkwxY1dm?=
 =?utf-8?B?WDRhTFkyVFZpQ2kyOUdnaS92VTRVOHhKZ3Q4T0ExaXJNTUVFRzVOTFpTVUdl?=
 =?utf-8?B?YlRoOHA5TDJEQW4wdVUwbUhWZ1lac1dBNlkxSlJxM1djMlRhMWttZ0JvREpR?=
 =?utf-8?B?QTg0dVNTWXpOSFIwTHBMK0xzVUhKWGNGN1VmRVp0SnVNQW5BYnlUWndWVkpI?=
 =?utf-8?B?S1Z5OVNVNC9paTgwMVgrbmFBUTh3c2x2eENRcVpQTi9KaG5JRi8yYi9SS3g0?=
 =?utf-8?B?YTBmR2daRUNlTExDTkpIdTNsOHdSbjQ4M3JRcDVsSlp0NTdpYjRnZm9RNjAx?=
 =?utf-8?B?NTBWUXhFcWRVTjh1NXZtbGtBSVgwZjdZM0ZyMHZlaHU1bGF4UkZSVGdoUXVL?=
 =?utf-8?B?QnhOUDZTWTRrS3lobVVXck5UeWVSbWM3ZGcwUzhYVXhKeWcvazhEYUwxNG5n?=
 =?utf-8?B?QS8ySERNTlFvOEZaWW5Ua2hFc2w2QlAzaVNIVXRWUnd0bVEva1hVV3ZBVmNS?=
 =?utf-8?B?U2tsb1pnVU5rYjFzWVFHTUkwVHRBeXpRckd0RmZlOWFiM2d1eWxOZlRFNzAv?=
 =?utf-8?B?ajBBSDlieXZmaDQxbTQ5WXhHWGtiSU5YSnpsNHFWR3IwZWJ3N2dyQXh5WjBR?=
 =?utf-8?B?Mlo4VnBrNUt1RFZsblpzOGJpWUxVMjkwUEZPampCWmFJcHl1SjhlRFRjUXlv?=
 =?utf-8?B?MVBYcTRLb25HbFpUSFY1WllRc0VWVFBlTEJnR0ZhK0JYcmw0dE9pdG9iTG1H?=
 =?utf-8?B?SFNsZmsreGpCNlZOQmNOd3lyZWF4d0E5TGtrZm91UldtL0I4c05pMkZDRFdL?=
 =?utf-8?B?QzdRejJpbG03dFBsQzNBWmtNMEg2SHhyb1U3THJielcwTHNqZHZidE5IU0NU?=
 =?utf-8?B?NWh6WThqTjZWOU1ZYjM3SUlQSE1sNzB5VDVFU2daOGRycm9wekdRdzcvV29Q?=
 =?utf-8?B?VVVoc3RqUnI0Mm94c3ZBRW1qajRaWVgrcmdXZnVkRmY0VVpqMnc0QzBMa3dy?=
 =?utf-8?B?SFJuKzE4OU44elFEZmlLNVZtdEh3c0drcW0yZEc4QTZlN0tpbE1KNXYxaENQ?=
 =?utf-8?B?TWV4Y0NxUEw0NGpPRXBzQnRBRlI3ZkM2Z3NhUTZVeTlRU2piQkQ0YytPVnZL?=
 =?utf-8?B?cWQ2MXU3ckdEemRRVWFUZ0hGU2w2RFZNb0Z2UUg5MFdoZlNsamZsVDZ1bjc5?=
 =?utf-8?B?M0lKc2JuUVkvbkVPSGFCTXBpMWZYSUtCYVdKUHhuNVNXOFBFR1ZIclMwelZl?=
 =?utf-8?B?Z3hZUnZ2MEJtcWNtS3FPV1hXQmtaSnh5WVZOVGVvZXZyaFg2S3h1WHYzR0w5?=
 =?utf-8?B?SnJTYXd4YkVxd3dIa2VjVVNCak5BSlA3VnpFYldBb01CY1VwVjUycHhnTzlL?=
 =?utf-8?B?Vk9Xekh4dGZ4QTlpWXV4cjJySVVhNEJ5eVQrN2ZSd0M0NlJkMlUyMzdNbEMr?=
 =?utf-8?Q?mfzY09V9IfxgYaqY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6DD17FEB386DF4A9D281AFB9536E7B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SAH54ezp448CVf7lLyiPVAxPFBsoAtdKKFk6deuaw92nqchE9U21UtuH2oQpExNCm6Ly2URWb3y+vMpSH0YSnDCuHaw0tzV3rbtLKvyar3vplatYSqou/+P8bcY74D+POFtkTm5OQW5PBnsoef5zv8ZWUIiVdWxMiyYiDnq8Hghkbavh0PskDfErzHRo4kwuCAJHxn5xigjvfZgTdkJlQQjRo9fsW2xfhAgfsGugLHqoJt2cErDdTEiUkqWqYHSqgSXcPM/+BPu72b19sYeCsRWl5jcXAH9Yen6B23DgomFBtgYXc6OiX5cDPaseEtcsrX9bNccA/6vrh+w1RLltVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d1e489-89ea-4b00-1305-08df1da455be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 21:06:15.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBRx9nuHpUujl9zU+8XcRwEl8bwo/vVscQVs+I4bPlz7AzgBUEQ4KKNnMZ2Oi4DFWfUAk5FM16b/lYrHIQ7+yT3Sl2/GCqbdXwpYtUWmw4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE0OjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gbm93IHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBkbyB0aGlzIG9uIHVwZGF0ZQ0KDQpQZXIgYW4g
b2ZmLWxpc3QgZGlzY3Vzc2lvbiwgd2UgYWdyZWVkIHRvIG5vdCBoYXZlIFRESC5TWVMuVVBEQVRF
IGRvIHRoZQ0KVERILkVYVC5JTklUIHdvcmsgaW50ZXJuYWxseSBzbyAgdGhhdCBhbm90aGVyIFZN
TSBjYW4gaGF2ZSBtb3JlIGZsZXhpYmlsaXR5LiBTbw0Kd2Ugbm93IG5lZWQgdG8gZ28gYmFjayB0
byBzb21ldGhpbmcgbGlrZSB3ZSBoYWQgaW4gdjEgd2hlcmUgaXQgaXMgY2FsbGVkIGFmdGVyDQp1
cGRhdGUuIEJ1dCBnaXZlbiB0aGUgY2hhbmdlIGluIGVycm9yIGNvZGVzIGZvciBUREguRVhULklO
SVQsIEkgdGhpbmsgd2Ugc3RpbGwNCmRvbid0IG5lZWQgdG8gc2F2ZSB0aGUgZXh0X3JlcXVpcmVk
IG1ldGFkYXRhIGZpZWxkPyBXZSBjYW4ganVzdCBjYWxsIGl0DQp1bmNvbmRpdGlvbmFsbHksIHJp
Z2h0PyBTbyBpdCBzaG91bGQgc3RpbGwgYmUgYSBiaXQgc2ltcGxlciB0aGFuIHYxLg0K
