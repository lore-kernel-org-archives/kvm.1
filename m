Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A23612E8;
	Tue, 15 Sep 2026 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449011; cv=fail; b=ljv3omNBrqjHBZODemWDhvgc8rtod8NkjgXKfjI7w89sLhvpVweOzwNJfEGpf5MsD2IhtUgutwSLp60YNYoPyUJKAYHADJhZW9rfd+Jc0VJrTd5GqRGVJxMEjAOaA+Hp1Yv8YhC24IxvoSNvzfIjJMVwP+/kpXTDfzCe/QGCgzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449011; c=relaxed/simple;
	bh=zz/tGvj6f3UlAcDNHDZiNZzxUZwfrey5/F4WM4MPS04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMK6o0TSuH/kWH3sNrGKC8g7Nl2Uup5k+X0CbIDAInDTJuainmm01N6whHZ2F0XdkgG490/nzeC1LqvDS/u6Xmo5YDp99arPjoOY6XErU1P3hHr8ksUkVO8IdB6KPB2/mmhxPwB53AI8VnWJasVhj2wrPav6zuysMyToyyrLZpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5pTXQEC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5pTXQEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789449009; x=1820985009;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zz/tGvj6f3UlAcDNHDZiNZzxUZwfrey5/F4WM4MPS04=;
  b=d5pTXQECzd5K3S8vNPr85AaCN7o1W1gIBMl6vI1RqdsI4Iy2adTS8QwE
   WLjyy/ByUj7yZbMKQTHELB06TdO39RRZ7WDuQ3f+CW4u6UCyVbOiO4303
   DnZ7/9eivdtvCTj5FBj7a6uGrVOvzfXlpiNU+Gf2fGvypaja/7vOWfudC
   Kd4bhWNsyzKFhzYeMIox7LRPt7Hq/ak13ejpcs8vQPE7vxFYucIiA6KLp
   fyZiuxhbgtYVf0PhWm2zWcBj1tkR87E8i7861eGh+evGtmF4SGwtszsN1
   wJiu8NMNwEZlh98Ws2LQSUcJ+FvKLgC5V5DbEZv0wY84DRUTGyrbYSEEH
   Q==;
X-CSE-ConnectionGUID: Pl3HdXMCQN6hzdhB0HxD5A==
X-CSE-MsgGUID: TdDOHaMbQmazaMkqpTWrcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88940838"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88940838"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 22:10:08 -0700
X-CSE-ConnectionGUID: XRY+hU0YRq2p61WqkueqEQ==
X-CSE-MsgGUID: Fhp2xYZbTQWIhgj7RtGePw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296337893"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 22:10:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:10:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 22:10:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGUfIoxpnAlT1fBsUKivx81eCeM7H6twMmpnza5GkkT+B0dyq9+FQRceuZeus90pA+zO5ZV0yPP7EidjsnQTx3xgg7X+sUHSy0wMlOrle3KDGSYEJEZQMemeoaUJM3/UdCB3+0JLivlpyOOm57KWGsmrejRnwG4IUd0qLA9eZ7fcn7lXxlgYPCZlRIbUqIsPQ99RBZoksSSnNd+9iT6QrECDyRCmN4pO8/5z6+OVwgEATLgp3Wjau34dS12zLfj2Lnv7efu62XkdChy+lijFNNR/HlftL34HoH+MRN4F0hafElZ1hULbo46UNpq/g5Tqt1WXX4KIxvHHsfsGIDjtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8JWAfWJNunw59geBzlLbFPIxrktfvQGc8R/CaPAZ1I=;
 b=LDlttGjXgHerwHzyRpAOjlPzQWszD0NOaAsJXhGBuAHE5b8ztw9bJkMRvscr1F7N3zpbA53k4br9ksBBRfbTQr8hz4Mkay9LFcxbDSlAtx+uZtAiflXgZV4DHzNSLL9I3RCDZllQLNOlTeIx36fvOvuM6VOvjEMpkV+eiyEgIif06WBPg4jfaPKuz9noVTMq13HuXn3nj078/NwTIQOMKCVA5ZQhAfRUkLUQ8apUPtFAA789W52hIG4xVGhEcOPP/zvMXjV1pdt0g76uxKdj7SyrCTheuMrLvN+4gw7BSmfajhIcFU7051NtBFj1yWK4TpefzuhmIPHzTKHL8hW+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 05:10:02 +0000
Received: from PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e]) by PH7PR11MB6932.namprd11.prod.outlook.com
 ([fe80::cca2:8c49:b4b1:761e%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 05:10:02 +0000
Message-ID: <c5076e4a-0335-4ed1-8049-a3ddf486ea03@intel.com>
Date: Mon, 14 Sep 2026 22:10:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
Content-Language: en-US
To: "Chang S. Bae" <chang.seok.bae@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Kai Huang <kai.huang@intel.com>, Fuad Tabba
	<fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David Matlack
	<dmatlack@google.com>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
 <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To PH7PR11MB6932.namprd11.prod.outlook.com
 (2603:10b6:510:207::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6932:EE_|PH7PR11MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d82176-48c6-4cc8-2b37-08df12e798ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Qe3hMZl+9WXqxxgphUh0bbr0CVDZ1qg1KwcRdjPyEEgIomqzRoel9Ik+krqcj1O98qhrd2hMSry8UHm9eYdn4rCmo7rrhLax8ijgBkPEpalir2nytt0ECHyrR8+HPtGnPX1+g9EtZiSPyLyzZSUO3cjldLRgp6ebchyesvkmIWBkwloVjWRPeVf56SEqLeMRclTlJhyDr+XxXjGb+loA0GcrAuxbgxtSCeUq/CHuZ+m26a0DOArVBjBXZvq1z4rl0H7ueUg2fVIsKJyQH20QSaxLDkmDjS9dejFQ7rPgWRs2cem8orXuzlZ4A/KiX2nlfVm3UYzThzsOiRrrk1l6h+dsQ/+T8fP3VL9uvdGzcXq1McaOJREE5m7Qke05WPaZXMH6BGOmOMnAGLEY7eYA1wtM5Pz/VhHnVjuMETqM03E6BWpqlVu/g1A/FWTvviWL7ZM8HGjya8oY+D0hpjLay349XpN7JRDMGR0u2BTWXIS3pH4EQNCiaJVYF8lFZ+u545dKN7LMkqfCbQEMyM5QPXZv0N/Zc2KtS2F+hizwnkwCnAIkOEkfwLRsNanhyZfA4ixdKe7wM7KhmWfIBhcu4dJHwKemYRAprisafITa1hdwjXMpbqMXzQ7HjK5lV9b/5dvJOMhmUuryQ6zjlSrnFSbAT5g8nAmRFUbGDijC+00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy90amFKc0ZLYXAxZE1zZE5ONkFWZStmb1paQW41emt6Rit5MGVwRkg3TEhZ?=
 =?utf-8?B?VjVVSnRBZlRGZ3NkZndmaFZTNTB1ZjBMUjEvK2IyZlN3N0NsbzVHQmFhZ2xG?=
 =?utf-8?B?elpoMk4wTm5XRnFmcTdDeHBGaW1FNkhwVW94alNCVURkaGVNeHRLeWNVeTBV?=
 =?utf-8?B?dXlON3dyay9FUFV6Z0wyY0taMUhjcVZoS1B0R0M2UUdpdmdlQmNLSDJ0dUEx?=
 =?utf-8?B?UlJTZys0Z2lZNEp4ZG1veXFWNGpBcVZjTjVVeWNZZldlZnBFTDlzQi9TVlgv?=
 =?utf-8?B?TXdzVHIzSGZOWUhRUHFNR2dtUUR1Zld5VjlOVWxvN1QxR2hMZk1Qa05aTStK?=
 =?utf-8?B?MFFyQUsxdjY4aDQ1VW9HUm9pUHVxTFZYOGkwOGNtOW1FeGlrTEtqWFRqZzk1?=
 =?utf-8?B?cjBUY1dlbEk4SWJGQ1MrMm1ZRlNuS2d1QTZ1NCtSQTJtWi9FeTJ2T1E5V0Vs?=
 =?utf-8?B?Zk4rN2o2WVVkRlVwMFhtcVVVQjVxTkduelk0N1ZQa0tzTDdXZWluRzRHMHU2?=
 =?utf-8?B?b2lwbVQwbm8zdkZQMnJGditSQU5DZVBRdzNzMk1VdHRUK1l4ZDFRdjBCeDkr?=
 =?utf-8?B?S1BrYU83M1pPQmFHbTMvazhvMWh1ZHRLeDFwbXdEQUR1a1k5anAxVVAydG9h?=
 =?utf-8?B?WXdybThGNTZqblpHMndkM3BEVEVFUUxuUTRNNVBGd2hjMmZwOXdyUkR4L0px?=
 =?utf-8?B?T25OUytEKzV0bUZ0NTl5YkhWdWM5V2hTYkJha1o0MXU2cnQ2YTJRSUw0d1hu?=
 =?utf-8?B?Q0lNdCtLbXA1eWVnSjI4NXgvenkrUGtzcHI3SHM0TlZoUmVWTnA4WHRrZWlU?=
 =?utf-8?B?Z3RDRnhQMmREaU9rQ0VWdE43N1ZuUGpBMkw3c09yWk53bTZhMktOZHNzSWlE?=
 =?utf-8?B?MXRPaHh2UGNFcmxKTUROSnlsc1hEN1p6OXBiWXlvaTNTcXM2NVlpSThDS3Jo?=
 =?utf-8?B?Uml6cWtzQ1BaZ3NMeExyc1dUeHArc1psOHEvSlVOQk1uMXlTK2l6VWdiZnNI?=
 =?utf-8?B?a3h2emhrOVB2ZE55a1NoQXcyOC93S0FxcVVVdVBFSWRZMVlEck9NcGtndW5N?=
 =?utf-8?B?Qy9hSGZMUHM4L3JEQ0k5WCt1Vk1Lblo3YTdEbWxEdEZZWG5Ga0czMjRVTWVa?=
 =?utf-8?B?dFU0dDlSK2FNZzJxeHZwWjBuVWRwbWdLUUExZXJxOEdSM0NhVDUzOEpEd1cy?=
 =?utf-8?B?cUJSWmwwcUh5QTdMLzlIbnY2VEVYVkx0WVhWN2JDN284V1BYVW15VWk0NUxL?=
 =?utf-8?B?TGVuOVF3ZjBHYXN1cjVqdENvbUs0TlBENXdKZHlNYmpwZzA0UlY5WVhFUW11?=
 =?utf-8?B?L3RvVmF4amNrM1Y1MitvV2JDNnVoNFcvVjgvYlgrRElLQ0Z6R1diR01DcDZU?=
 =?utf-8?B?WFdZMUFCNEozUVlaZkM0R25rUkRzc0xzMUN0dWMzSjRRWW5UdWJGRC8ycmhs?=
 =?utf-8?B?RlNNMHgvb1dLOXlMbVEyQlVQOXFJbFRKcDU2ZjNYVWNyeGMwYnA2bURZN2pk?=
 =?utf-8?B?SllhR0oyZmU2R0Y4UUczbE5ONzNNei9yeHlWWStiOElVZmhHbmRGSUhuWUpC?=
 =?utf-8?B?emdZKzNadjdhSCs4TFMxMkRKSVBwNkZVREJac0M1Wm5HMllKVUV5Y2hQeVZi?=
 =?utf-8?B?eTY1K1lUZ3hiR1dibHY0Z09ieWdiMmtzQ2tnOGJhZ041SWNqblVkY0I4NlY1?=
 =?utf-8?B?QVpscUJseHd5bFB2cVUzNmcwUXFnK3F4VXhTT0NqZ2VZTHRFM20vdHRhOHB5?=
 =?utf-8?B?NEZOTHZJUmZieHhweFo3R2wrYWF2T2hiNzUySGdtcEhZSFAxTm9UMEZSWS81?=
 =?utf-8?B?OG5xeVBsSlpYM1F3U1liNWU4eU9CcHIrYStremdhQ21FblA1NTdsTzhrbzJY?=
 =?utf-8?B?aUlrOU1nSnRRNTJZZE9Ha1Z0UWNjdHltMCs4V3Q4S3hzNUVYQ1U4SXB4ZFl0?=
 =?utf-8?B?QnM1d1dXVGRvRVplMHBTTVEyaWNGVlpDYXRLbTd4R2JUaFV4TlBkSzArMkw3?=
 =?utf-8?B?OW1QeE1wWkVmT2hQOC9hQWlWeVYvbDZNbEpwOHFoek5ISFQwV0FlYVdUd2JF?=
 =?utf-8?B?cnJsWndkbjJyL21MVlc3WkhMVXZYSFI5VXZML1c4ZUVzK09LZU1HT3FCdjkw?=
 =?utf-8?B?STlGaUltMWQxZVhvZGJKUlNvaXIzTGFuaWRwY245ZzNiMFpDNTZrRUV0Mit6?=
 =?utf-8?B?dEN5VExVNmhUQVpTTXFWbUFKTmFORGJhdzBOU0srV0wrSkdPL2FIbTdjT0NN?=
 =?utf-8?B?WEtJNks4dnQ1OHVBLytLS3grRWlNWnlYZ2ZpNnN4MmpGcEtHY2tQekM4dUFH?=
 =?utf-8?B?Si9QQ3dXbUppSUZ2Y0ExMzYxWVVhRmFlRzBKMEZrK1BiV1c2LzZNdz09?=
X-Exchange-RoutingPolicyChecked: nGrQ+cZ3V0mhXkdZyz9mynOZc4y5p41oXXZVz0miEIf/gnVeO5qE+DMgvRzxXxfm0GTQkS1DDk6ZDulFA+qIQl3Y81mHw5Ps4igLWIadgH/2Y93FjnvifK7Bb+iDYM9KvK03xYwebaUPuxw77K96utAhBljoC+rjcSTZsVXPDFuVIKU5ViEg1TjiyoxsI7lSnm81FqszLtKOCwBb/QlWfH/AP50LnDsb/9OuruxP/4AkzHsRMJBJv8ft22Jd/Buf/3GkYa5TuCUENrRPEis0LJChb9Oyh7fRFCEna+oLyhEjV2L/RbMzVtf7Yy/RixWp9zUBEfe49rKWCyGh8ObhVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d82176-48c6-4cc8-2b37-08df12e798ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:10:02.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO2uhf0JI4vAaVQMhhI+bA5TEQmZAuwmvLn6vXX2hD8+gHP9qLSBxnQsHKFkQlbXklMf2/4fCZebQInpqnGHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-OriginatorOrg: intel.com


> 
> This looks like an essential piece for the check introduced in the 
> series. I could follow the logic, and it looks sane to me. If allowed,
> 
>    Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> 

Thanks!

> The code also looks to be written according to Sean's comment in:
> 
>    https://lore.kernel.org/kvm/ZNwOYdy3AC12MI52@google.com
> 

Yes, that's exactly the reason I didn't modify it much. But 3 years is a
long time. So Sean's preference may have changed.

> Yes, this could be a matter of taste as taking and going to maintain the 
> code. But as a reader looking at this, the logic was not that easy to 
> capture at a high level.
>

At first look, I found it a bit hard to follow as well. But instead of
splitting out the logic into 4 static functions (which have limited
value to the rest of the file), how about we add a high level comment on
top of the function?

I'll let Sean comment whether he prefers to change anything here or
leave it as-is.

Note, some function names in the proposed diff could be misleading. For
example, is_user_mode() checks the IMPLICIT flag in addition to the CPL
which feels odd. And, is_lass_enforced() seems like a generic LASS check
but in reality it only covers the supervisor data rule.
