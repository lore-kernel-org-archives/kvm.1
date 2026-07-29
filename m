Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21671402B9E
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363062; cv=fail; b=uqW5Zk2fPFqbjuit/5X0zan2s6FIT4dWRikxOn2+OoR+ADjd8ZIUnTeZCyZL8A7biJwgkxgFtnvPpFHzCrse4srvUZKuKdyC3QtcVLB6ApnZZO4xB+oc+htQYY5TIfEjO9NkNsCfbBrqoR7kgJwL/htpUDVKpMMYJQI1lx1LIWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363062; c=relaxed/simple;
	bh=vXmotZ3fhWJTx3VgzrHErryXDZQx3mMSSpmK5OHdd60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n66+j9UM5plRMfRFHih0rinQCvKzMNUIcAqQRWzleJfyqlrgoCz5JleHZpn1JaWtXdZvdSFBdREpwe4xpFb6nwVSuvaKw/1/tfhD3jl4Na9EU1AdjvZC0LC2LShM8H8yU/aeTGia00lCLQlHvie+ts/P/NlAwdUlCJNEJnoQZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwyQp1oi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwyQp1oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785363059; x=1816899059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vXmotZ3fhWJTx3VgzrHErryXDZQx3mMSSpmK5OHdd60=;
  b=TwyQp1oiupHcErSqENWGUMzlVAmD433nSIqcOY/gNXiWeKcmrYerlxYm
   COYoMgN8PMEZx3OllDaMCoLM9hfJY9Wgb1Pk+rHa2+zufMMZiQGXovQ7j
   9H+5UiLtTDmNcgsM56g+f6XlY/HWG0FDiJltia8y3dwaCe+Tuh1WS1a+J
   cvMn0QKc4oTE3TVVCOUaWzKusfYx3dE/IZ8T6aUJspGumu42fA5AjiPQn
   F0/HcGzKVxJFx1ma+7XpOs5IhYIuJ70aSvkBiotXRGK3WBkQtJMmFF8Pf
   Nsv7dV21FRF+AvgK7ycDyfr35FJssZ4QA5UU9A9RrvyuLTVEAmocPkthO
   Q==;
X-CSE-ConnectionGUID: RDepDMWNSxK3cbIaoi16ZA==
X-CSE-MsgGUID: 0ih2XqOXT4mmnyvxOIKZOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103518071"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103518071"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:10:58 -0700
X-CSE-ConnectionGUID: EEoTtprBR0uxJgs/8LE75Q==
X-CSE-MsgGUID: +v0itNEpQz+C9tTXkHVjNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256792185"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:10:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:10:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:10:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ48pJiWx8T4CAlUKVIvOqZ8L4J67wbEg8pSmgp9074pij+CnnnIoBGoCLS69w706rdyPM6Kf+lSp32yvkIwYq7sxpZGfLCi4zxIfEErWMPLZebFuBGDIgpiXhD61ByIeTp64uPpPwNFmYzDSpyjZItNv4KbZy/OXPyVCLwtsEy70TWpUK13TxDZxX0WAklzlSIRyMH43yIy7SfrCfLI1JiHiry79Js03XKg8+0wN/+snX9GXbNEkfp25KhxcF4g4VYqCCmX8N94cbbdJZH934wrxc4CpyA4ynLufZpNvs1ET2/cio7Y/Rof0WU4xu+WJzkOw3zlX7mmNQPCGUJQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXmotZ3fhWJTx3VgzrHErryXDZQx3mMSSpmK5OHdd60=;
 b=CSnSr+gC2TF5kIqr6q1N7UyuoZr+1jeYctKsQMPJArnQyuI3ds44V+noYFaCf53xEhE78TJb4wbh/nOn5qdrrcS+FvX5C2uRehdHAWgfgtyqtko7mufUsq2Mdk2rxiLTmn/RmrfPh+FUZx2mryuFpgwNn4DW54vIYAd1vjXWvHbbRLCLrofhkuoykgNVSsdkOQCbPVprFYdkBWlIwABuoMVssh1o5w+AzKctBYlY/6d7k2xLAyowsczu/+yhb3aUeM/OR9cUzA6jq+Je3vHPWkwKia2G5ToiRcVwrKShQIzrS0C9p5Ojx5weTzu9MU+K9bBByr8QUDQTIKxNauhnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 22:10:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:10:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v8 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHdG8vMQyaw50i6+U2yU1W7BhCyPbZ9Y14AgAezPQA=
Date: Wed, 29 Jul 2026 22:10:45 +0000
Message-ID: <1b3bc3539f1f909f413bda68e037123617e9857f.camel@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
	 <20260725002302.3337017-4-rick.p.edgecombe@intel.com>
	 <20260725003524.91EFF1F000E9@smtp.kernel.org>
In-Reply-To: <20260725003524.91EFF1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV8PR11MB8722:EE_
x-ms-office365-filtering-correlation-id: 2073558e-3aa9-472b-b5f8-08deedbe3cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 4Osp2Q+Oph+V4RDEUn52kGuDv0k2sNk9ZUVBY7uGcSrn9E+ltLDer/54WksCWepDHNrBOFfpm3cZ8JM0zu8mp2RoZzWYfo/TH2r4osZpC0cEcGF6c+a3Z4x5amEEjLDocR1PKb2bMkodZdt9Akb/xEXk/pj/TfulClIGn19Gu2H5WRcEUZvdBy6JDvrKcKQem4+6uKPV/0eA+zaywnNg6Jhzv4l/+ol1ivdQ5IFwncYuGUoEgI5UkiSjdYfvvVXtXOVzhbxmrKUz4C1e4fG2Voqckf6jMePBPQjzSlwBQ4GGWI8m3qXWQpIxFgDqqpHvOtGbCinJ2qAsbdNIdltlHLr9kV8jOzBUUQmVKYebLFzXNsDZn04Hv/6099SBXhmETAAe33Z5ep/Z4XRd5D86+w87ZWYTTgrOfGCTDNQR0aKTMtGvN4A/edB4H7dWwBM1WORYavgaQFOc6G94a61Lq/cbazgLLAjb1w+jEJM77BNJzPrVrzks/Ns9UizpuQTLUdDZFaGXfxyuvrCdWb/G5GLKt0Y28mR0c+fFUJiktFh03jwVdjUOs2OS1dzox+wi0kbRDnIMPNx4u149PZ8LnkKXxnUYEhUEVQlYo0iu6pIHDKOZaVrRpmq0OFaMiT35pLFuUJwWXaodmnzhRVgfygatZnayUqZr14UvWjx0/0OCXLkszdww9o93ST9XLqzEW2lVHCtCP6DJzf1OPTFHVGdQupbIkHPgZCFuWDdOi6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkkrektmeUhDbjlTbzFJc3JxaFQxVXBTY0loc2ZPcTg2OUJqOXVieWJRaTd0?=
 =?utf-8?B?SnhpalBEOTAvSXYrRCtXQW9zRDl1VXAwcXVqdU9RTFV6UWwyMUQ4UURCQUJR?=
 =?utf-8?B?U1ZRdmZHdXZURUNPeUIxVUk4bG51Um1qWmgwY21IV2FERVVCUExMWjF5ZVY0?=
 =?utf-8?B?QVJjYUQwYWp6Y1ZNNm5yNDExMDNGbnZNTUZpWmRXbHhFMGpYUEFTcjN1dXpw?=
 =?utf-8?B?dGRyNVhvUGtyRE1MUlBrQ1pFVnkrVmJvR3pWZlEzNTI2OTFvTk5HMGJXL1ow?=
 =?utf-8?B?UlQ3ZS9PZEZiN2NXaFM4eFAvb2hiYXNRRldzZ3BVaGFhMGVETnVBc0lTV3l0?=
 =?utf-8?B?byt5d0VEdVdYOFJsT0hXVWw5M3ZpV0ZhMENPMGRxNU5WVWVpT0VwSnRGaEhp?=
 =?utf-8?B?Tmc1dnZGUS9NN2xhdHpYa2tMbExMdmJpcWRZQThhdDZxSFpRUjdER2IrelRE?=
 =?utf-8?B?czdJdUhUY3dhcWZKK3B0Tk1zMTF2aWVFM1dzcStYaWtYbHplVVYwbHplaUhv?=
 =?utf-8?B?OFhjN1ZCTUFtRkNwWFlRRm53VjRjUitUNTBnN2xMaFpBdXlua1J1NzNNUEZq?=
 =?utf-8?B?SnFSZlVna1lNcDlXNXRLZ2VLVXp6NnA5aXNZZXVJU256RFYrdmdqWUhhRGtI?=
 =?utf-8?B?K1ArRGpDQlhPUnppVDJsb3ZubXdidzRMZ2ltOXFlWkZQbzNzc0N5dVR1azZE?=
 =?utf-8?B?dlREb3dKUTN2NHRtTGxEb3dqTUcxN0VMdFVuRW9Cbm9NbFQ3dVVCcVBkNlB6?=
 =?utf-8?B?eWhEUmZYeGV2YUtNZUU1V3ViMFcvWklhMThJNGRZbzQ0bUZsT2lwa3h6b0Js?=
 =?utf-8?B?YUxydFEzUW9YWnA0cUtMZ25LOVZPc0xQenVva1JjTXlKMlJXei9KSXFEOUV5?=
 =?utf-8?B?SS9BYmpRSnJTRHJMOTRxOFV5Qlg1ZzZjNlpnQUZuSVhTaVZSY0dYa3E3d0t2?=
 =?utf-8?B?RFFLSndnVzdvdmRMeGpQRjhnOHZHd3FhMlRFTGhHd0lrR09CajFLb0pUTk95?=
 =?utf-8?B?eFZ1VkZIeDJHMGdaK2FScVBqSldUOTlxR2V4UG1mVUVPcVNiUHlmamRVVkVR?=
 =?utf-8?B?VWJyMWlCMEMzcC8rRDJuWHdkOGRIWEJHbUF0LzJFS3dhM1J1RTFaNjNWWllh?=
 =?utf-8?B?d1MvcStJZmtDZ3dXdE9Ib1ArNnRzTkRDaEttSjVMa3NFd3p4bURqS0pLZFph?=
 =?utf-8?B?ekd6MVZsVFQ0aFpTdElvWlJRZ2xFS1puMFhjanZ1Nk94S2N5cDBpM29zZWdQ?=
 =?utf-8?B?TFBXR0ZSNmxsQzBualc0NjRNN2VkVUhoZHdFZld4VHo4eTFtUHJsdTBPV2dG?=
 =?utf-8?B?czJYVStyK0VJVTZBNVQrNUhTN3NsL3RpL3J2YXZJQUJMN2xLUkJRZ1dROStB?=
 =?utf-8?B?d082ckxZR01qWUVlRVJTcUlJdjVocmRnM2RYWUdwRW8wZXI4WWJLMSs0VHdy?=
 =?utf-8?B?VXAvOU52NXliNDlUeHJvYW9BT0EvSWJVOFEyOVVzNHFNK3Q5RENLa1VDWmRk?=
 =?utf-8?B?MWFhU0J4N3AyZDRWaFhyeWNUeUREaEZIMnd4UVorTnhlMUNOUFNHbHB5S1BQ?=
 =?utf-8?B?RkM0RGpYYnhVT0tkNmxKRjhacjJaMGh5aUlaUXRRMXRWUmxQM0I1bGc1WUpY?=
 =?utf-8?B?TkhKYk9VZml1MERYSVJtWmxDZWs3UkVQY3F2NkVuMFF6MVMvUFZFWU9KYkl3?=
 =?utf-8?B?REhHOVNpWFpPRXEydEh1NGNpV0M3cEoxZFN4NjVtNmZRelBidlBqRnQ1T3VS?=
 =?utf-8?B?NWwzdmVNZ1JhRHlGbmgyY1FWTjhhQTJjTW9lbCt3bUdJbzJtQTNBQWc0NC9I?=
 =?utf-8?B?dmRHQlczdGV1dVZxMnFxelRVblpQcWVjcC9ZSjRrcEdOYS9KVmRaaUVZTHZ4?=
 =?utf-8?B?b1YrUHR0b2FDMnhCbDhDd0xzWGhDaEM3ZUJacGc5VWRtWXJIWDI5YjZyei9Y?=
 =?utf-8?B?TUt3b3VNRGhuYXI2SDA0c3crWmJNcDJ2NS85MjJWUTBHK2Z3aFMwZC8wa2JI?=
 =?utf-8?B?dGR1K3pkcDlYTENTa1YybEFoUGlJL2VtL1BpVXlqZHgxZHJhRUd2d04zaDB4?=
 =?utf-8?B?QzBBL2VzU1BTOEFpbVhqZXRGdVhXTXRlL0Q5bEJRVjJKWklUcWp0ZG53bXZx?=
 =?utf-8?B?R0ZKSDh2dDZKRi9yOXo2QVRBaDhyUnM2aE1tRVJBWmxLNU9NV1FRQzRqbkdy?=
 =?utf-8?B?WTVIbVRsaWpaZU5GTDA5d3FQK3o4cE1ybHNrZ3g5Y2U1WTNJUmE0VDJJc3pl?=
 =?utf-8?B?bjBqdE1mdHpBTEFqOG9Vdk5tOHJiRHUrK3dRekN1alBxSGxHNlJpa01NTHEr?=
 =?utf-8?B?aEl4Snk3U2hEczl5ajJVb3dybzNZMHNrMksvamg3Umk0OXJVc0tFVjNsaHhO?=
 =?utf-8?Q?rF1E/dqPsOoB8yPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D418D7F5F504F24980C5D6E84385AA0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P2tAxnAP2JGZyO7xYyb8pElJMLTtztLsTZb7anSJdUfdF1k2p03AXEXbdreWpw2Yd+SAXGwW2XmKphUy8BtgTq00TT873lXc9/DJKMqIzu/TmMnvUdArX6ZIOZvAXzHJrsLQS01Cceq71Q7oHqP8p+8IlhDRI2tFflQTwai5jdwkG/frdkr8uJ4pJsVgon/Lqu2zIs+3zZ2TofiktjeI2/lYjmy//KMSG3N+D4Xyp1tw8e1dTozXoHU2udNJibs+mOweX7KpilQyZi34eHsxfrLD6T1iArdmim/eSruzeaj4QBCCr2bB7H81hEoB/ga/qiLpsR/YMj4gMD8aYN6oYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2073558e-3aa9-472b-b5f8-08deedbe3cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:10:45.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DvkqPCwN4rJQ/0AgnY45BeppO9nHciExJS5eOf0Z1IUmpy7vYwSu4vCKwt82lkWUJ+3x4/Q2VLliMKXkoIb07rQ+sk0WlczAbcpPkPZGG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTI1IGF0IDAwOjM1ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFdpbGwgc2VxdWVudGlhbCBhbGxvY2F0aW9u
cyBpbiB0aGUgc2FtZSAyTUIgcmVnaW9uIGZhaWwgaGVyZT8NCj4gDQo+IFdoZW4gYWxsb2NhdGlu
ZyBtdWx0aXBsZSBjb250cm9sIHBhZ2VzIHNlcXVlbnRpYWxseSwgdGhlIGJ1ZGR5IGFsbG9jYXRv
cg0KPiBvZnRlbiByZXR1cm5zIHBhZ2VzIGluIHRoZSBzYW1lIDJNQiBwaHlzaWNhbCByZWdpb24u
IFNpbmNlIHRoZSBURFggbW9kdWxlDQo+IHRyYWNrcyBEeW5hbWljIFBBTVQgYXQgYSAyTUIgZ3Jh
bnVsYXJpdHksIHRoZSBmaXJzdCBhbGxvY2F0aW9uIHdpbGwNCj4gc3VjY2Vzc2Z1bGx5IGFkZCB0
aGUgUEFNVCwgYnV0IHRoZSBzZWNvbmQgYWxsb2NhdGlvbiB3aWxsIGF0dGVtcHQgdG8gYWRkDQo+
IGl0IGFnYWluIGluIHRkeF9wYW10X2dldCgpIGluIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHgu
Yy4NCj4gDQo+IEJlY2F1c2UgdGhlcmUgaXMgbm8gcmVmY291bnRpbmcgdG8gY2hlY2sgaWYgdGhl
IDJNQiByZWdpb24gYWxyZWFkeSBoYXMNCj4gUEFNVCBhZGRlZCwgdGRoX3BoeW1lbV9wYW10X2Fk
ZCgpIHdpbGwgcmV0dXJuIGFuIGVycm9yIG9uIHRoZSBzZWNvbmQgcGFnZSwNCj4gY2F1c2luZyB0
aGUgY29udHJvbCBwYWdlIGFsbG9jYXRpb24gdG8gZmFpbCBhbmQgYnJlYWtpbmcgVERYIFZNIGNy
ZWF0aW9uLg0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIG1lbnRpb25zIGxlYXZpbmcgY29uY3Vy
cmVuY3kgaXNzdWVzIGZvciBmdXR1cmUNCj4gY2hhbmdlcywgYnV0IGNvdWxkIHRoaXMgYnJlYWsg
ZXZlbiBzaW5nbGUtdGhyZWFkZWQgc2VxdWVudGlhbCBhbGxvY2F0aW9ucz8NCg0KVGhlc2UgZnVu
Y3Rpb25zIGFyZSBidWlsdCBvdmVyIHNldmVyYWwgcGF0Y2hlcywgc28gaXQgaXMgbm90IGludGVu
ZGVkIHRvIGJlDQpjb21wbGV0ZSBpbiB0aGUgZmlyc3Qgb25lLiBUaGVyZSBhcmUgbm8gY2FsbGVy
cyB5ZXQsIHNvIHRoZXJlIGFyZSBubyByZWFsDQpwcm9ibGVtcy4NCg0KTWF5YmUgaW5zdGVhZCBv
ZiAiY29uY3VycmVuY3kgaXNzdWVzIiBmb3IgY292ZXJpbmcgc2ltdWx0YW5lb3VzIGNhbGxlcnMg
YW5kDQptdWx0aXBsZSBjYWxscyBmb3IgdGhlIHNhbWUgMk1CIHBoeXNpY2FsIHBhZ2UsIGl0IGNv
dWxkIGJlIG1vcmUgY2FyZWZ1bGx5IGNhbGxlZA0KIm11bHRpcGxlIGNhbGxlcnMiIGluIHRoZSBs
b2cuIFNvIEkgdGhpbmsgdGhpcyBpcyBiYXNpY2FsbHkgYSBsb2cgbml0LCBidXQNCnJlYXNvbmFi
bGUuDQo=
