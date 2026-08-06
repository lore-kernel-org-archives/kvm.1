Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669E3B8405;
	Thu,  6 Aug 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053808; cv=fail; b=ufpfyJmwfpQSNbXcLMCFA3hnyBdxF2u+S+sGBPwMZG/q1JzAfi59H8RTaBHg2TLqKVduKkQ4Opu1RwFG1tvH4YwN8LuZyXOAv1XT7d6xt7sInooPvRLPg9wKSFIvxHByNU5XeqKMbWGlLT4JElb9W9u9FKKxJhp4iknIIQ1g1eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053808; c=relaxed/simple;
	bh=rB3qxHV0ATa3xn18wCjXbmGNfpzYEKureP151d+6Udw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K4k2V+x33Ua/6I8UE5SwEaLfB4NivSZka/sxVgiz2emlXwPdxGxLsRjOWGNL2bX1Cw/XDQmWDM5WCvkttFyVP9pfxq1YViosFt6aB/tLM4n2Ye+ct3OZEagLJq8aUYroZYEJ9tGv1kh13Y5FtnxR4Ujm0U0s4dXjHoUT2V0FtJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkUO/Rfp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkUO/Rfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786053808; x=1817589808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rB3qxHV0ATa3xn18wCjXbmGNfpzYEKureP151d+6Udw=;
  b=LkUO/RfpzEqahVXAWpFrELDHS0N+VGAdcMqXj5PBE+/z1Oz+nU2vr4f3
   /YJJG9zVcRxiiIH2hiv/bdFiNnXH4Fe+ynLUAcoh1RFOAyB9gIfcuo0Wn
   l7mH9Ql21Yx4zZ5wyaRcx+Lv5arKf9XQXYcPx02awD9wTtRB4IOiR8OW4
   JAwNZc7P2NnAsfQyUw+g2MJP0xYvLQA7txNbYqnFnQJj5t04A47FRYYIi
   2A5+JvLWDfQI6x1SLQRthEZ7P7Vs+COvU1y6VgFxeD45R0ToaATE9igNx
   +zAX/36JzFEmGaTZolnSc8fhdlWcFdd+7HDEEf+ro6Kx4Kj0kdNAbwQox
   A==;
X-CSE-ConnectionGUID: RxsfX4F7SSSYQItguZyc8A==
X-CSE-MsgGUID: XikUPQJrSW+ld/ayBWrt1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97014183"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97014183"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:03:26 -0700
X-CSE-ConnectionGUID: zk+6CEFWQCiW9+MiclGTSQ==
X-CSE-MsgGUID: jeA55cWtQ7WG15m/LBz9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="292116515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 15:03:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:03:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 15:03:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaxoeHJ6OklDeDP76aza3AU6P5LwKLqL9/EfRScZQ7npj64BAnzAQ+g9V2OALxL3MtgMtqpMjS5Kt7V/1IUqeB+RLxqdLasScjp6dwubUoMQM3w8k3imE6+txst4r+wvs5iYmI0r+8UPLAt/wEeVoASK4LwkkBppyQmbu/b5QrWDyStU2tlpG+QoSrXlgtgNd9SDGtJL+LOVWIRtKK/hqmX67cPrC5BvzrVM3FB/jWUeFXU1CpNQCGkyBF68iCZsZJQAQKSDHFbzdBORTz0Q6BT37GRwqBF/Xy92EPmmPti6/JbTEdK34A6sPwiKzGbYHEL/mJh0wGOqo09pGQdJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB3qxHV0ATa3xn18wCjXbmGNfpzYEKureP151d+6Udw=;
 b=XLxGyzg9xqW8lkUkQz2+6xCrlZorqnsRnNxFBguzpDqfCO/E+72IXu6HdChHbJEhCU3FjMNIoMICOCALCCwo9QfgqBRmKRg5ruVPh+SpL6soHS/oY5Vx6qayv5pinyNwTaSSCvl0F97/ESQ/tCmUKPU+uQlyYJVnJfp8+KMxh03q5NuL7f5YLIzy5jCEnsgqlqRjWzUJXzaWQ1MSaPCfc8i+yx5G5M+dtTB++05Stnr3eJvIly06lJ7L2Jv5BFIVgA1ZMFP+/WNvHTFMxEyPFv3sE5VZ2NMgumj3vqICTbqYcFo3F8lMfNHoeOAIex+FjPNPKW6PyartCDI8vB9OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7369.namprd11.prod.outlook.com (2603:10b6:610:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 22:02:58 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 22:02:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hongyu.ning@linux.intel.com"
	<hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic
 PAMT memory
Thread-Index: AQHdJUiSpW9IcQOPSkW3F2w8Am0TyLaQSiSAgAFJ94A=
Date: Thu, 6 Aug 2026 22:02:58 +0000
Message-ID: <fd3014be925bc16fb3e1522c8cce00d9149e7808.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
	 <20260806022158.586A11F000E9@smtp.kernel.org>
In-Reply-To: <20260806022158.586A11F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7369:EE_
x-ms-office365-filtering-correlation-id: b6c06eee-5ce7-4a5e-23ef-08def4067a01
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|6133799003|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: oiRfjQddvgmBnoEOdr6t5jIBt9dzrXD4+jye+balsZLLX3xvw1ps+w+e3SHyI+1tm3WmDsWYIIuN03sPcw0xH8fz8XtwcJ2yVulBUf71VlUIRfUKcO7lPNNA4B2d2Cp74CByfAAc2tEueaaYRRnd4Ddq/Os5TG4oZUwZPRnm8SdrjDszRk5a4RH1k02QjTlwl2RsY29AUJCWgCpt974+2YCdzrS2anhrc2B/yYVwpQV5uA762x7jrxF/zfzoxz7IdhU9FTWiiP7VrHUjUCUb/64fix7Mezx85Q8aaeN1M+6pdj6CKVzOOPjPyxVXszDqJWIxM9RnudedFJJRjOvr6GVKaKFx3QwWQI6Lrow8J9ZUC2wH1YTawUmJwNlvROVxF4mjGNCF6/HMG1oCL9q4zB1rggoJ6vYbDtQzG60M3I3OtXLS7vGVXySWkY91GOQKsSpuIyPnPOt2SL7KeofF7ccuvljriUrVtQKp/4rcML9clZigqW2Jo/l0dUZbnnxhyYVS6DtHtEK0dj71Xn8r38tpvRlGN21muETJ35GB1Bf6pvyWHUMh/AP1a/b7mdbS28W/cP20/fdpHgXtN7S5ta+sOvn2MOovH/YId1EoWSxjchx1d3A/hlktukbBnwcc0hrQqfTP5wI4OHUprtRrKRrd+95gWAqJ8ySx5x8VG/acyCQBRYDEZZdQJQi2vYviwrIaYNTqfV/ZLMiG7wJk1B5/l4PzMNnT9LpGincnTYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzhxNk9wRzR0ZzZDbG5aRFRDWFArVkdZZVNJVHpRcnMxNUNRV0NPWjVSclB1?=
 =?utf-8?B?eXFaUnpPRENZelM3WFp0RkZaMWc3UjJONzJPQ3pyZk0ybXR5MGFHTlFpRitn?=
 =?utf-8?B?aWJyUFZ5NE93QmQ5OW1IWlpSVGZtZmxlTWdqMlIvMm91Vmc2NFZtcGhuVEM0?=
 =?utf-8?B?eHl0a2d3elc5enIwcDJXUURQSlNsa3FYdXV6YU1mN2xsdEVJWjJaamJVZGRz?=
 =?utf-8?B?WG1hbC9UM1grYjJTS0RGemZKNGY4aGdpRWJudEF4LzVRSXdCYTdTeHdjaWVm?=
 =?utf-8?B?dUhNUXkvbEk5eGkwZkJrdEZGaTMySHg3dXFFNTd0QUtreThmaEN3ZTdISDdi?=
 =?utf-8?B?UzIrUEVLekZRZ1dpTnl2S011UktEQnNQVmplT1ZHVUpaUGhkaEdnS3BPeDBo?=
 =?utf-8?B?YmlCRTFLM0FrOEM5bzY5bGlqdFV6RWlTNDlMZzg2WUpVcS9Od0ZuMnJRQS84?=
 =?utf-8?B?RWRqZkdTajVRU0xscjZWRXZrU0F3N3ppdkdmelhOWUpoaitScFdqMHl1Q2Rj?=
 =?utf-8?B?YW5BQndWUWo5RGMxUHpCM3hPcHlMUFZNN1lnbHlWNWNMN3JhK21GMUZoSHRL?=
 =?utf-8?B?c2Nua005M1EyaGxBZTFPWEZPMk5PMTlvUGFaamprUWoyREkzblBlbHZFd3NW?=
 =?utf-8?B?bHp4c0tzZ1czN2Vabzc3Q084OHZqV1h1U21tSVNtTGdFRVFYNERJVmM2ekU4?=
 =?utf-8?B?SDZjK0ZIOEZ2WG9WekYrc1JzdjFkd2NwRjhTUmFVRkJDVnVjYmVCMjNPN1RH?=
 =?utf-8?B?VEIwRjlwRFVEaGg4bjRWNXV1alc0Rm9HSVhTY001SlVxZklyWmRzS1NpYWxI?=
 =?utf-8?B?YWlLUm5sNm8ydjgvd0twTzJzTGxmWjJibHo1aTNRNFpPSlp6UkVESFFHckxQ?=
 =?utf-8?B?dzZtUytSSHI1L2NNRVdoRmtwZkRsSlczUkdlWEp4WkNsU1ZKb2FEUzRsa1kv?=
 =?utf-8?B?V0FicmZNT3N1UkplNEJVRVR1VXcrVllwb255cUQ0NXFVdmV3eE1pZXZCOG9I?=
 =?utf-8?B?NGRDdTRpdXFiaXZ5YUhjWkdvei9lZXduMDhuRjFzQkswbjBiUnB4emNjQmJ3?=
 =?utf-8?B?eU04SFZHUTd0bXl4anhCdXZ3akFJekJ6dW0rR2x5QURJK2RiVm5PVnlmVDNN?=
 =?utf-8?B?anZmSzJRa2ZlV3BYSzRTWjdCUG5NaHA3cGpZUG50c21PUEtSM3grQjZNQWY5?=
 =?utf-8?B?eVpSTDRDd01FeWZ5OXNDdzdUVktOWFlhWjB0a3VkYkE5T3dnMnlHekFjTmRQ?=
 =?utf-8?B?anJETzVxbExXQ1lUTkRqQ1VoNDB1VElYU1lLdTBDbmU5Uk1wQU9rWURueFBZ?=
 =?utf-8?B?YzlkeTRVbCtHWm5paExndkNoSmNLaktmUi9TVTU4Tk00ZWFNbTdwQlJVQzhq?=
 =?utf-8?B?UkdlR0pZUjZVMmg4a2ZPZWtWb0M1c2ZVdFhOUzZOTjZPTU8vOVlHUHM1RmlI?=
 =?utf-8?B?Q3ZYVTRsRTNiVWhCQ1cvRkZOOEoxWVU1V0JkRHFuT3kwb0Y4SHh5eHJHbTho?=
 =?utf-8?B?ZWZIUy93TWVDVU84SjVjVHh0RGNzRk1PVWdLSTc2Tkl3c1FjWGtGM1NneFQx?=
 =?utf-8?B?cy94dnU2VVhZZWh2K2VHK3d5UlhZR1dXSVZYeitLWnJLNWcyMGtVQzlRTU5W?=
 =?utf-8?B?UjZtaEF2WFhJeG5oWlg3REN6ZWwyVHN1QzJKMmxtajlMMEF6UTV1aUkxWnlH?=
 =?utf-8?B?QXZ2Y0JDMHd0QklqY25zYU41RS9aVXRyOWhwSFBUaS9oaXVlRnpDeU41NzdV?=
 =?utf-8?B?cVpLbkNpbTdMamw5VU1PQkt4cythVHV6YkVvU1gyeS80R0g0TWFMSXBrQ2Zw?=
 =?utf-8?B?VVVPblg2YnoyZk9iQlZHVTRmNmxJR1Z3cjd6MW5PQjVOZHhhSldKd3diazh6?=
 =?utf-8?B?eTdtMXByYURGeXFqdmdDVFRJZmE1SEFYdUhEdTFGdmxBb0dFZ0IzRm0zRGhl?=
 =?utf-8?B?azl5OU9WZDZjRGxDYzF0TnR0T1Y1ZDQ4ZC9BUkpIbzhJclZ0UklQcDlPdjlt?=
 =?utf-8?B?UElicFN3dmlpRUFTYXBTTFlxRFBlQTdCc2lsWlpHb21PRC90bTZseFJBVzRE?=
 =?utf-8?B?SXgwbUIxZXNSOVZMVHhoYkZySlp3Qnk2cUVUK0Fpbm9lQUNqQjVpZUJ1cC83?=
 =?utf-8?B?ZlF2RHk1aEtoeTNQVGdNWWpvMnZSa2VPUHY0dUdmb3RFUjJxak9tVzNMbFFv?=
 =?utf-8?B?YjNXOWJPcjF6aUxubENMRXRvUWhVQTBCbThvM1lOcWREc3VXOWgzblRZMDh0?=
 =?utf-8?B?ZTlUUUFnSWtJc3FDK3BTb3lCckVHV0xKemx6c0VKREVWTEczZktERGwwcDJG?=
 =?utf-8?B?eGNJKzhwU1JvY2I0bGJNZlo3NmtSWTVVc0lCd1oxZ2JQbzlWM1dROTQ1Rjkz?=
 =?utf-8?Q?0SLJgMD3nZP6GCU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C92A8E2398F344873D63D68B3D767D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ou80EHx8uQJwmDsI3AFfoESkbjb3v+mBqz6zgXapQCnTljx7tFZrEN54Wr/Jkal4yGerckc1oxzJKkfqd61F4sIPH4tA5Q8wh+rEcaYCCARbnye6U74yE0Nw47g+I8gUaKrxlqUWeromk8FMWzd1j7MJzPZ8E+oi22eufam6tt+ebQII9t1SgzSsFmpDCUyPBwSQxNvA6IKkJJb7R7wDM1lY4rc2AaDkGodBiJw8U+vHAZzjT8mo5djpsjVAeeaDGpcHQxEu/qaZCfo6rZJW42QuTJNZhpM/pU/0VM2g020n+8/uihb0yjOzSH6I0fpcwE3D9BN7xi+t3KjrZGHvCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c06eee-5ce7-4a5e-23ef-08def4067a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 22:02:58.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ri5v+Fp3WO1zPfc7UYp1KVvCMEpWhYbgYQudrz6GIvWAiRiWb87rQqfvMV462+bHE6lDPUwZmL7l1RxrM3ssZSBNcyZgkdz8vM0OO16K5+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7369
X-OriginatorOrg: intel.com

Q0MgZXZlcnlvbmUgb24gdGhpcyBTYXNoaWtvIGNvbW1lbnQsIGJlY2F1c2UgSSB0aGluayBpdHMg
bm90IDEwMCUgY2xlYXIgY3V0IGhvdw0KdG8gaGFuZGxlIGl0Lg0KDQpPbiBUaHUsIDIwMjYtMDgt
MDYgYXQgMDI6MjEgKzAwMDAsIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFtTZXZl
cml0eTogSGlnaF0NCj4gQ291bGQgdGhpcyB2emFsbG9jKCkgY2FsbCB0cmlnZ2VyIGEga2VybmVs
IHBhbmljIG9uIHN5c3RlbXMgd2l0aCBzcGFyc2UNCj4gbWVtb3J5IGxheW91dHMgaW5zdGVhZCBv
ZiBncmFjZWZ1bGx5IGRpc2FibGluZyBURFg/DQo+IA0KPiBUaGUgYWxsb2NhdGlvbiBzaXplIGJh
c2VkIG9uIG1heF9wZm4gY2FuIGJlIGV4dHJlbWVseSBsYXJnZSAodXAgdG8gOEdCKS4NCj4gQmVj
YXVzZSB2emFsbG9jKCkgZG9lcyBub3QgaW5jbHVkZSBfX0dGUF9SRVRSWV9NQVlGQUlMLCBhbiBh
bGxvY2F0aW9uDQo+IGZhaWx1cmUgd2lsbCBpbnZva2UgdGhlIHBhZ2UgYWxsb2NhdG9yIHNsb3cg
cGF0aCBhbmQgdGhlIE9PTSBraWxsZXIuIFNpbmNlDQo+IHRoaXMgcnVucyBkdXJpbmcgZWFybHkg
Ym9vdCBiZWZvcmUgYW55IGtpbGxhYmxlIHVzZXIgcHJvY2Vzc2VzIGV4aXN0LCB0aGUNCj4gT09N
IGtpbGxlciB3aWxsIHVuY29uZGl0aW9uYWxseSBjYWxsIHBhbmljKCkgaW5zdGVhZCBvZiByZXR1
cm5pbmcgTlVMTC4NCj4gDQo+IFdvdWxkIGl0IGJlIHNhZmVyIHRvIHVzZSBfX3ZtYWxsb2MoKSB3
aXRoIEdGUF9LRVJORUwgfCBfX0dGUF9aRVJPIHwNCj4gX19HRlBfUkVUUllfTUFZRkFJTCB8IF9f
R0ZQX05PV0FSTiB0byBlbnN1cmUgdGhlIGFsbG9jYXRvciByZXR1cm5zIE5VTEwNCj4gd2hlbiBt
ZW1vcnkgaXMgZXhoYXVzdGVkPw0KDQpJIHRoaW5rIHRoaXMgaXMgYSBiaXQgb3ZlcmJsb3duLiBJ
ZiB0aGVyZSBpcyBhIGxvdCBvZiBtZW1vcnkgc3VjaCB0aGF0IHRoaXMNCmFsbG9jYXRpb24gaXMg
bGFyZ2UsIHdlIGNhbiBleHBlY3QgaXQgYmUgbGVzcyBsaWtlbHkgdG8gZmFpbC4NCg0KU28gSSdt
IG5vdCBzdXJlIGl0IG5lZWRzIHNwZWNpYWwgaGFuZGxpbmcuIFRoZSB0cmFkZW9mZiBpcyBtb3Jl
IG5vbi1zdGFuZGFyZA0KY29kZSB0byByZWFkIGFuZCBjb25zaWRlciwgd2VpZ2hlZCBhZ2FpbnN0
IHdoYXQgSSB0aGluayBpcyBwcm9iYWJseSBhIGxvdyBjb3N0DQpvZiBoaXR0aW5nIHRoZSBwcm9i
bGVtLiBTbyBJIHRoaW5rIEknbGwgbGVhdmUgaXQuIEVzcGVjaWFsbHkgc2luY2UgRFBBTVQgaXMg
YW4NCm9wdC1pbiwgdGhlcmUgaXMgYW4gZXNjYXBlIGhhdGNoIGZvciBub3cuIFNvIGlmIHRoZSBy
ZWFzb25pbmcgaXMgdmVyeSB3cm9uZywNCmltcGFjdCBpcyBub3QgaG9ycmlibGUuDQo=
