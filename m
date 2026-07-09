Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C92DAFBB;
	Thu,  9 Jul 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638550; cv=fail; b=NmC8MJwA6/vyVkf0NZfy38Grn8w6mwkY+PddoTB537Qm933ipMXw1RgSEtFXqCaIjEzSiiyaE2cbtLPZDCG3efF5wxRSZRkanW/YyOuibW+DBsZI9Ap3anyNatSDanmmCrtW+c3pFw2ZfZm6LGX4mmz1vscJiVHsktt3BPBh3Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638550; c=relaxed/simple;
	bh=OrhJlzh6tD4UU9TsuyEN8Sfyi6ByVA528VWaWOhf/oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DF449X82K9f016NGm/UkvZIlO/3Lh7LJLOwdt9E+HokwjPDOfFeLxnFmXqgLlHrZpihq/wgfoDiLQi6SMaIashgrkjz+WUm3nlfwrDGID9W7t1ZSw221ahf1wT4BRUI8UWI2uHxlh2uF0lx3brDMg9mQHOSqTzx/na/2vC4uZug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df7RwH/a; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df7RwH/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783638550; x=1815174550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OrhJlzh6tD4UU9TsuyEN8Sfyi6ByVA528VWaWOhf/oo=;
  b=Df7RwH/aXW+jQXneJ2rnMJ+3ZRSBEF1A/FtZ6MM1ewrCarezj6ltu+9E
   kMCNaPRz/sYPCWtu/JW2OP97zQI9BwWLMbS+gO34NUH8SMSSR0V5gomj0
   Y8kiyB28Wddk3rJA9VnYeDIt08uVOJjHJ9Hk+AgJi2A+nNyZ3NvfzmYfj
   jXrqge+5nGAEAGmV0HVB1z3fLZ8SX9J5O3jf82cq94BI2GXujbRIrzV7+
   XwAA6emUXPCSvYDcDmxpskSacFav80nwFUqBmWgyQK/yGj5ih0nn34M1L
   pluOpxJB8tvAe4dDZMg0hxnbyCm7+uFUUDw5SUaOKliBQfpYLNX9iIj20
   Q==;
X-CSE-ConnectionGUID: BV8QAlQ8QtOcTS9vKQFIaA==
X-CSE-MsgGUID: 6LrFYPhMTb6kr15eDP/IXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84308389"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84308389"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 16:09:09 -0700
X-CSE-ConnectionGUID: YMQD3KufQzmzdP0H6EueGQ==
X-CSE-MsgGUID: KaKKvPIzRCaGoKGIEygGYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252987249"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 16:09:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 16:09:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 16:09:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 16:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1JbJ9CHZfke/x0T0GU5g8CjZ0kke0LmAEFgq87TveWN2TgyLRnqZ5C+0/2N4c56i4TaKdgUGuO9i+kYwVzJ5sMoTvk+E2wCPISqOtRq2aoaepZJDeWe92FPEGWC8ssa7dPfI9PZVgNLjVozmeGvKMyXCjg59RzSjt6zPos3Rw+BWXzVCdvFHqzEaiA7Yd4EIUQkjAE6vp/wJB8qxSzFz3Pi++IrceD1jTTU/F0LmZbPym5UcRhDoeRswXAaMbNMdoV2pVoLd+pT+PhsiLVtMF4dJz25xwYYrAeUr9kgfYTsf2fA7wZI8iAH22gdFK2MDzZZ2P4xeQdSO3Wswwh0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrhJlzh6tD4UU9TsuyEN8Sfyi6ByVA528VWaWOhf/oo=;
 b=lNSMiXAz15Gw0S0Bx+riwVymWzneim5UIakZZgUBftfE2pc33LDiYtEutZR1D/ufjFN+VjjjnC7RFfHxAbWX8qklu1fiyFENqB4Uccxv2ttvaI77ejtAK82KbrYUOmzHVoGFbOnD0nm7gRkuq3yjm5LMcyLbMw6TwTX/f7VaqYdOFD+WuwmO5h5iyu33MnVytODRvOWMo0zsj3LkxnqeJulyqvVHx8g8i5fmrz0z6f02IT61eotKAFoK7Q47vZdLRo2filYpFj1PU+B7LW0Mw7wVHLc3ozm9FiF0Sqkk5mpz0aXUc0lzvaMnCUwFNEwRL1CJ2w6TMeqf4ZasCrg6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7819.namprd11.prod.outlook.com (2603:10b6:610:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 23:09:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 23:09:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Topic: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Index: AQHc7LhXfoCfkuUFmkqKqK55gbUxZLZjcZUAgAEqJQCAACZLAIABVGiA
Date: Thu, 9 Jul 2026 23:09:04 +0000
Message-ID: <ad840587305878d544f3c1dd44ba6947498c167b.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
	 <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
	 <9aa0694b9f0e2057808ed7c69ba6796a1d629bf7.camel@intel.com>
	 <ak8MghJ4OKmsXAWE@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak8MghJ4OKmsXAWE@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7819:EE_
x-ms-office365-filtering-correlation-id: 5e93e9bf-92c1-47b3-027d-08dede0f1203
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RXDNA08PikkmsLzPwZpjI+ijaJ80N4sdxRQ0jo9i2G+G+rHQqJG9t2c1W/2zcJsPkNjS/Va6TosiKW6Tyjq0+NrQ3DjEmHsbASwJxS0oR9pVZVNDu5+TpS+nsoQGbar0G3qiTZ1dIrF0J2+qporDtDoVTwHwg+UB/iTPz3gdJcgEVidrI2Zoh4i4E8k37G651hvpS8qM5R0quyJ4gPjUAe9HUyNLKsl63Dzf4YmBFvaoCtcjjmOkNhqBvjS2ZlOR2UpO2uo6SOJnRauKNlWxfqDnVY75Oc7xha4lFrKGeQZDRSJOFlvcKQdDLfWx3vGvrWJpZSqL8qwpjncOwWrE95urjNLN+KHxUYKIPF5QNIUojn2ynhIa9/NvF9k6NhADKl7MEj+X2uHBiH5hMzFT45MrNnvP0nDOEZoCrUrIn5NGIpcNL9cbE28b2GozIoZkU2BpteeiqoU9xbS/LbTuPUFzTGWOeP+b2YHsZUCaVtVQ4garKf5nBvWsJIepewAf1jLwDnVwF2zWG+IRxP6sxZv/34i5LhiVG9XCVQgsQHoFWY+5GJiUXJDBq0VHIOKmG5yNLp76fC/cfxHPqmXUk66o8GyvW0dqhQHjalrMtCVl+GKN+uwS5kj8yTyHsMDgq9uhFUjYu1R8TQqWqqrZxgGA06aNfK7CxWv3AEhNDvAtu6Rh5vFO8NyicATAWovAz98Xj82wStaD+/k6fjjPH1VoMPoGafFWYk+RQWIQZi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2pobzlUcWJ3bnJlZzg0VUZoOTZoRVRUYlY5T0wyTXdnTDJTdVJyc1UvRHJr?=
 =?utf-8?B?cWVSUk0xSTJwYWE2ajdSaVV1RFp5bVNmS2tES3cxVkpBRG9adktESENxTG13?=
 =?utf-8?B?b2JsckVMU05ldGhqaTZFWHpseFJiTFpOZEc1bExLZ2UwUnphSUpNbVR6YVNp?=
 =?utf-8?B?QnBwbXZQQk5XSzkxdUlSVUwyalN5dDZpRDI0b0FjS2lsZlZ0dkZXNnFYNTR2?=
 =?utf-8?B?dWRjU3ErMk1PcGFzQmVPYjViTUNuWEpTTU9uWE1jT2FDNGhkVU5yT2VyNFM4?=
 =?utf-8?B?RnhBVHMxUmh4MUxYdHQ0ekxJaEVUaU9vZnZzT3NMSGhzeEVCTk9uM1M4RGs3?=
 =?utf-8?B?VTdMMm1DQy9EVXBvZWRMQmlVaytnb0RRQmIzMzRvTDl5bnl4V1lwYURJRmtI?=
 =?utf-8?B?RjZhQmpIcEZRcld0Q1pNNXVVS20vR2wzVStWN0x0cytQNXF4b2NKeXdyVWxv?=
 =?utf-8?B?SEdONi9HUVhrUTZFRllCa2FWYnpnbWJxTmREWHQ0MlRwQ2hmUVcwTkQydWla?=
 =?utf-8?B?TUxIK2UzbE45VkRVbHk0RkpnK2I0UjlIdlZaZHF0cUV3UnJwZlJKaDFMM0Y1?=
 =?utf-8?B?eU9GUjl3VXhsMFJKOFhDb1BFOXVWYmY3YW5qWDhiZkxSVTFPVG82VFlKNk05?=
 =?utf-8?B?ajYzR3ZWNEprczF0aTNMck5haDBtaGhKa1NOelNsWHV1MEIrWVZ3TGFkcnpl?=
 =?utf-8?B?SDdDN2kvMFFoSzhmT3ZLUGt1aTc5WXdFbzQ0RVRoRHowYktrb1NoY1o1VW5W?=
 =?utf-8?B?S3U4cXNQNktaRzQ3dFVZNmhKVXBxWlVyMUJGaDkraWw4TXhtQ0hCQXZhT3pF?=
 =?utf-8?B?UmxDeEF5U2g3L0xVVlhZSnVZSy9XMDQ2dkNHd0tvdXlselFva0F1cVJJdDUw?=
 =?utf-8?B?TUs0RzR5c3FHNSs5ZlIvZi9HMTJWbmR3WkJMZElteUx3VThlY0U2NmIzNEJo?=
 =?utf-8?B?REYwdGNwUnVuM0J6YVRQSG43eTJhWnhpOTBLbDFwc2g4WUVVTmRzQUNmUG5h?=
 =?utf-8?B?TUJ0VklTNzAyMERvOG5ybktEaEVhTjczc29QTUVTbGpORkV6blN2SDc0MDRP?=
 =?utf-8?B?R1ZvcVlUOHA3ekVkaEpoWnA5VWN0ZDgxT2F0UzFHZ3ZuMW9aSE5xbXZqTENK?=
 =?utf-8?B?MXNMYU1QbnQ1Wkh6N3pXQ0FycWdZQk5NOGMyWTU5VEtvUkQyaFNrZm1URFdY?=
 =?utf-8?B?VVFIMnFpZVprZ0lNdXZhVXNESWQzdTRoK2dCMTJqNVlqS3hCdDkrRXpYQUVh?=
 =?utf-8?B?NmNjR1YyWG1lVVd0WjB4UTZKb1NCRU5iTC9uN2Z2aVRoemNia2VhWWR4L3JD?=
 =?utf-8?B?SytibGVieXRBSTVTUXZyRVFSajVBbUxQTytBbVlPd2MzbDJaYitETUkwSlZT?=
 =?utf-8?B?UFhLbHV3c0FiYlUzZjhjMUVNaERHNkswelcyQ08wTWRXQWVOZGpIdVY3NXNE?=
 =?utf-8?B?WkV5NVJvMXZ6SlFQMEYyQ0w0aTYySllYTEVSVUtCQUlDR0pia1kxbHo4OU1H?=
 =?utf-8?B?cDN6N3EvcC9vSWZIWDhleHVXQ0hxZHdFWWI5dmYyUEhhMm5iRFBEazlQK2JL?=
 =?utf-8?B?VEY5VW1VT1JUaFhJS3ZZRklkWDIxWTByakVtNnVsbEYwbnVnMTRMbE41dXZt?=
 =?utf-8?B?Y0dLOXJ2SS9ySlU3d214MU93UTBlOTltN2l3dklHVmo3TzZqTjRrVUI0bXc4?=
 =?utf-8?B?T3Jnc0xYYnV0QllzU3ZRZXBCMDBHRU9GRkVZTmVydURkOTZ1OVNPcS9BRDA4?=
 =?utf-8?B?UWkxelRMZ1hQSzZVdXRLM3hubXFPNGN4UUQra1FnYmlCdU92T2dYQzVVVUV2?=
 =?utf-8?B?aG9vZjEwbGs0SVZJVlBPTlBGeHhGSldoYlh3dm43NERESFF0V3ZjbkUrM084?=
 =?utf-8?B?YkNMRTkxakRKRWlJTCs4U2taSml4NXVWS2NlendpY2tldmZKZWpqRjdUZFF6?=
 =?utf-8?B?VGZZYWlBODJwdGZ2UjJwYzdJR2VWNGVmaWU0YVlMdUFhckJCTHVDczZaZnVL?=
 =?utf-8?B?U0tyUm8vdi9JVzljR0N0VTF5VlpwaTF5Qm9oK3ZnMEV1SHZBRVBiVGg3Ukp2?=
 =?utf-8?B?U0RaSkY4OTdaaUo2MXJ4SFVtNk50ZXg1aEJ5SHJTYXVDZGpsOEYyT1hucnAy?=
 =?utf-8?B?bi9BL0l6NDJOSGNuTzJ5WkZyOTNtbUNlb0Z1MkxCM3lkT2pBaDFDZmord0pH?=
 =?utf-8?B?emc3QXQ4dkVqMURaZVpjdmIyRElIQXZiaEY3ZDB2T1NaVHB5QW9NWDE0aDZw?=
 =?utf-8?B?YmtRZUFOSVhuYlpWZGhqNmFROVhMc3NtSkhxdEdIcE9IK1NBOG45VnNQaXZZ?=
 =?utf-8?B?NW1Pc0tXOWxnbGxrQm1VY01PVnovM1ZFSU1ZOUw3UUpXdXhBSkE3cWx2WEpr?=
 =?utf-8?Q?8pTk1WkVPztlldeE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB67B927DB5DA543994847E0EEE7A43C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: emT5hOgglfqo6IP1J7nk/Gn1aBfJh87kpEEAKZQ0EMLXSSQNG1TdTVms+hszO+GtjjJtt0cK//LVlQ1+bg6kpzIwhD6VpS0wXWyM/R4LwKsCWYkz5CJ0cmApG73Bb2j8VxDMA+5+fF6lVQBl1txlJOQol/YVO4TdLcbQEHWTfXxeo7v3dvQjoSEV7/KDjUyyr8Xb70wvZABbsqkGwqbYv1uCUFsZOK/QFpOyt9DXvBXIvlE9e150vRhtiypqgZjPsZlWZRtRZHSpOpkUGKb1SxKYnSyTREqvU/IRXjUZ8MpRINRoEFN+/fA0HTid4NBNYK3ZKeJ2RVFVBOGVn1LDpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e93e9bf-92c1-47b3-027d-08dede0f1203
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 23:09:04.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFVUSObcWxCU0tejC6z6LtJoqQYIOcvn3KxIbztZ2gm+2cstJILPrRh0Gb87bw15HJFYSqcEEeu5jo6+xMn6FZ4GyFEACerXeALyFxn5KA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7819
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEwOjUwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiA+
ID4gdGR4X3BhbXRfZ2V0KCkvdGR4X3BhbXRfcHV0KCkgdW5jb25kaXRpb25hbGx5IGFkZCBvciBy
ZW1vdmUgRHluYW1pYyBQQU1UDQo+ID4gPiA+IGJhY2tpbmcgZm9yIHRoZSAyTUIgcmVnaW9uIGNv
dmVyaW5nIHRoZSBwYXNzZWQgcGZuLiBIb3dldmVyLCBtdWx0aXBsZQ0KPiA+ID4gPiBjYWxsZXJz
IGNhbiBjb25jdXJyZW50bHkgb3BlcmF0ZSBvbiA0S0IgcGFnZXMgdGhhdCBmYWxsIHdpdGhpbiB0
aGUgc2FtZQ0KPiA+ID4gPiAyTUIgcmVnaW9uLiBXaGVuIHRoaXMgaGFwcGVucyBvbmx5IG9uZSBE
eW5hbWljIFBBTVQgcGFnZSBwYWlyIG5lZWRzIHRvDQo+ID4gPiA+IGJlDQo+ID4gPiBXaGF0ICJ0
aGlzIiBzdGFuZHMgZm9yIGlzIG5vdCBjbGVhciBhbmQgYSBjb21tYSBpcyBtaXNzaW5nIGFmdGVy
DQo+ID4gPiAiaGFwcGVucyIuDQo+ID4gDQo+ID4gUmVhbGx5IHRoaXMgaXMgbm90IGNsZWFyPyBU
aGUgcHJldmlvdXMgc2VudGVuY2UgaXMgYWxsIGFib3V0IGEgc2VuYXJpbyBiZWluZw0KPiA+IHBv
c3NpYmxlICJtdWx0aXBsZSBjYWxsZXJzIGNhbiBjb25jdXJyZW50bHkgb3BlcmF0ZSBvbiA0S0Ig
cGFnZXMgdGhhdCBmYWxsDQo+ID4gd2l0aGluIHRoZSBzYW1lIDJNQiByZWdpb24iLiBTbyBJIHRo
b3VnaHQgdGhpcyB3b3VsZCBiZSBjbGVhci4NCj4gSG1tLCBzb3JyeSBmb3Igbml0cGlja2luZy4N
Cj4gQnV0IHRoZSBwcmV2aW91cyBzZW50ZW5jZSBzYXlzICJtdWx0aXBsZSBjYWxsZXJzIGNhbiBj
b25jdXJyZW50bHkgb3BlcmF0ZSBvbg0KPiA0S0IgcGFnZXMiLCB3aGVyZSAib3BlcmF0ZSIgZG9l
c24ndCBuZWNlc3NhcmlseSBpbXBseSBhbGxvY2F0aW5nIHBhZ2VzLg0KPiBIb3dldmVyLCB0aGUg
bGF0dGVyIHNlbnRlbmNlIGFzc3VtZXMgUEFNVCBwYWdlcyBuZWVkIHRvIGJlIGluc3RhbGxlZC4g
VGhhdCdzDQo+IHdoeSBJIHRoaW5rICJpdCIgaXMgbm90IGNsZWFyLg0KDQpOb3Qgc3VyZSB3aGF0
IHlvdSBtZWFuIGJ5ICJpdCIsIGJ1dCBJIGd1ZXNzIHlvdSBhcmUgc2F5aW5nIHRoYXQgInRoaXMi
IGNvdWxkDQpyZWZlciB0byB0aGUgZmlyc3Qgc2VudGVuY2UgYW5kIG5vdCB0aGUgb25lIHRoYXQg
aW1tZWRpYXRlbHkgcHJlY2VkZWQgdGhlICJ0aGlzIg0KcmVmZXJlbmNlPyBUaGF0IHBhcnQgc3Rp
bGwgcmVhZHMgb2sgdG8gbWUsIGJ1dCBpZiB5b3Ugc3RpbGwgZmVlbCBpdCdzIHVuY2xlYXINCkkn
bGwgY2hhbmdlIGl0IHRvLg0KDQpBY3R1YWxseSwgYW5vdGhlciBwcm9ibGVtIHdpdGggdGhpcyBw
YXJhZ3JhcGggaXMgZm9jdXNlcyB0b28gbXVjaCBvbiBjb25jdXJyZW50DQpjYWxsZXJzLCB3aGVu
IHRoZSBtYWluIHRoaW5nIHRoaXMgcGF0Y2ggZG9lcyBpcyBhZGRyZXNzIGdldC1pbmcgbXVsdGlw
bGUgcGFnZXMuDQpUaGUgY29uY3VycmVuY3kgaXMgYWRkZWQgdG8gbWFrZSB0aGUgcmVmY291bnRz
IHdvcmsuIEknZCBsaWtlIHRvIGFkZHJlc3MgdGhhdA0KdG9vLiBIb3cgaXMgdGhpcyB0byB5b3U/
DQoNCng4Ni92aXJ0L3RkeDogSGFuZGxlIG11bHRpcGxlIGNhbGxlcnMgaW4gdGR4X3BhbXRfZ2V0
L3B1dCgpDQoNCnRkeF9wYW10X2dldCgpL3RkeF9wYW10X3B1dCgpIHVuY29uZGl0aW9uYWxseSBh
ZGQgb3IgcmVtb3ZlIER5bmFtaWMgUEFNVCANCmJhY2tpbmcgZm9yIHRoZSAyTUIgcmVnaW9uIGNv
dmVyaW5nIHRoZSBwYXNzZWQgcGFnZS4gSG93ZXZlciwgbXVsdGlwbGUgDQpjYWxsZXJzIGNhbiBh
ZGQgb3IgcmVtb3ZlIDRLQiBwYWdlcyB0aGF0IGZhbGwgd2l0aGluIHRoZSBzYW1lIDJNQiByZWdp
b24NCmFuZCBpbiB0aGF0IHNjZW5hcmlvIG9ubHkgYSBzaW5nbGUgUEFNVCBlbnRyeSBpcyByZXF1
aXJlZC4NCg0KTWFrZSB0aGUgaGVscGVycyBoYW5kbGUgb25seSBhZGRpbmcvcmVtb3ZpbmcgRHlu
YW1pYyBQQU1UIGJhY2tpbmcgd2hlbiANCnJlcXVpcmVkLCBieSByZWZjb3VudGluZyBlYWNoIDJN
QiByYW5nZS4gR2F0ZSB0aGUgYWN0dWFsIER5bmFtaWMgUEFNVCBhZGQNCmFuZCByZW1vdmUgb24g
cmVmY291bnQgdHJhbnNpdGlvbnMgKDAtPjEgYW5kIDEtPjApLiBTZXJpYWxpemUgdGhlIHJlZmNv
dW50DQpjaGVjayBhbmQgU0VBTUNBTEwgd2l0aCBhIGdsb2JhbCBzcGlubG9jayBzbyB0aGUgcmVh
ZC1kZWNpZGUtYWN0IHNlcXVlbmNlDQppcyBhdG9taWMuIFRoaXMgYWxzbyBhdm9pZHMgVERYIG1v
ZHVsZSBCVVNZIGVycm9ycywgYXMgdGhlIER5bmFtaWMgUEFNVCBhZGQNCmFuZCByZW1vdmUgU0VB
TUNBTExzIHRha2UgaW50ZXJuYWwgVERYIG1vZHVsZSBsb2NrcyBmb3IgdGhlIDJNQiByYW5nZXMg
b2YNCnRoZSBzcGVjaWZpZWQgUEZOIGFuZCB0aGUgUEFNVCBwYWdlIHBhaXIgUEZOcy4gU28gc2lt
dWx0YW5lb3VzIGF0dGVtcHRzIG9uDQp0aGUgc2FtZSAyTUIgcmFuZ2VzIG9mIHRoZSBQRk5zIHdv
dWxkIG90aGVyd2lzZSBlbmNvdW50ZXIgYW5kIGVycm9yLCB3aGljaA0Kd291bGQgbm90IGJlIGhh
bmRsZWFibGUgaW4gdGhlIHB1dCBjYXNlLg0KDQpUaGUgbG9jayBpcyBnbG9iYWwgYW5kIGhlYXZ5
d2VpZ2h0LiBVc2Ugc2ltcGxlIGNvbmRpdGlvbmFsIGxvZ2ljIHRvIGtlZXANCmNvcnJlY3RuZXNz
IG9idmlvdXMuIFRoaXMgd2lsbCBiZSBvcHRpbWl6ZWQgaW4gYSBsYXRlciBjaGFuZ2UuDQoNClRo
ZSBwYW10X3JlZmNvdW50W11zIGFyZSBhdG9taWNfdCdzLiBUaGV5IGRvIG5vdCBzdHJpY3RseSBu
ZWVkIHRvIGJlDQpiZWNhdXNlIGFsbCBhY2Nlc3MgaXMgcHJvdGVjdGVkIGJ5IHBhbXRfbG9jay4g
VGhlIG92ZXJoZWFkIG9mIGFuIGF0b21pY190DQppbiB0aGlzIHNpdHVhdGlvbiBpcyBtaW51c2N1
bGUgY29tcGFyZWQgdG8gdGhlIGdsb2JhbCBsb2NrLiBMZWF2ZSB0aGUNCmF0b21pY190IGluIHBs
YWNlIHRvIGVuYWJsZSBmdXR1cmUgb3B0aW1pemF0aW9uIHdpdGggbWluaW1hbCBjaHVybi4NCg0K
DQo=
