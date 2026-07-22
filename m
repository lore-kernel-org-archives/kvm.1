Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD93AEF49
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757323; cv=fail; b=IX/fgnngQX0YFudPzfvz8WabBk/6A6zw9a9IUj2WMi8FtVuEvmJVbjM8gJh6fWay9KdyqkfmbNYA6CymabWDPzDMFpg0Nq3dXao0gXhoLD5OZnbYysnrB1jcXWOxPbLhLKk7WMs841EMw3H7T/GG668vxdeOSdkBgrufwvbuwB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757323; c=relaxed/simple;
	bh=t4D8lrTYkyGkxvBTSFVPMVC1p0ZQaE7wY12u7Jajh0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1HSY8SRg3/igS1eTQiPFf5ct5MFBfm/R5vUbnExyvQlj7uSdEGuWiifb/6q9PWAI9DFnEYSwiDCjf5j/5b32EzbnnQakIdqXRLwiz7uzwtsNbA7dAUAIzlCLCn+WEK8FykdWg7Wt31/Y9owXEY2a6s4GGW+JVrUOewiSSDayz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8fOZMh2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8fOZMh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757323; x=1816293323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t4D8lrTYkyGkxvBTSFVPMVC1p0ZQaE7wY12u7Jajh0A=;
  b=Y8fOZMh2ikAoUDMey3OF6tGFfGIyQIAndP76sWsFuU2NAsZ8LHVByvMu
   Odcv+qbxxXrRkJ7PvzhhRTsvPrN/TYFgwSRSbB5K3Ce6JyGGmx1YFdZ47
   ZnoT5CETvPAfoc1z8nONnpTHKQPCpMmdv4QnRwI2BleT7bG2X/KSjDTt2
   mEG4KdW/DEip2Wpk7aJwIeijv3twiaUpwtj2egfNWvnkKG2WZ743TkpgJ
   L0H4ItfED3m9NRGSp5yb0WrsCL4d/442ciNpC3A+wOOosHMMQZRXtCdLt
   RUONYrrkK5tfT1L5WChO969an+I4bpfvSHYFYT13Y9e0ZHCbJsihMPC5D
   Q==;
X-CSE-ConnectionGUID: hutGlj+ESB+4waOhuX42gg==
X-CSE-MsgGUID: 4xv3JwbkROqJRQL53CJa9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102950803"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102950803"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:22 -0700
X-CSE-ConnectionGUID: G19NQ4fLSXuFsFV9BMtk3g==
X-CSE-MsgGUID: uBb9X2szRWmhx0aFIBQGfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256420974"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byn/K+IOIVV5EUMqGjBQxe1ziSpx6OlUG398AL5lJRGbIevS1tWBtYV/XAcCtOIUo4xTuvAcn7ewcu1F2jKhAO2D9X7mj+U4gojOexAOMK76r6oS+wrMLbCYFIBp12GD+W0AoEog0kOkYc7oXc4OBBh+ZfLj42iQ2AdQjbcd5GLkwuHe2EM5hlkHyq2EV6ktFgkkfJumvoCjWk/BIMJJxD2obcfGrWQtapyMoHwxTR/Cwkmdz02rTGABD6iMidhhLI2xzwyZlDh6AqZoMoMPD8fqIkLskPjcrwCkx36CPEcD4Bwi3+GGcMfF9FzF0hxJpIVf/pDhiXvgET9xZj3FPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTjxDcKLr09FoqVOg+trDEhdklEVnOcOgAnGVmKrwiE=;
 b=EchG/lB7TLdm2U2ZXQmxGAgzGQ5e1n2QKhPvJhO5RZ8m9wpsZmv+4RZ55n4tlpk7on50BlmP2BCF35m8XDyKBHd2iWmXATjtEUePoTKOwpSfpwyr5ZcyJaSbC1mzVHkvDuMvt/vYewAPxYoj0L4/xF+gjUUT+NlALlPTIcO1XxDMI6cnQpui24E/rVTpCjDda6buJ+eg+yjT4W2PrSi31fsbuJ7SUiOBbwu4uxn6D6Uhs6ugbkbWK2Brq9+aEJeifFzbTUvzdBLHZNsdpY+Ai338yPw0SbolcedpOPfuImAbwz9NjYTy2enF3uZ1cZg/yhVhfBuFqTrHlYGNPS36Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:18 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:18 +0000
Message-ID: <b2594968-6d41-4574-97bb-f9146bcce33c@intel.com>
Date: Wed, 22 Jul 2026 14:55:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/20] KVM: x86: Add APX in supported XCR0
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-17-chang.seok.bae@intel.com>
 <20260720182507.7D03B1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720182507.7D03B1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 787587c6-1610-4e92-6970-08dee83beb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D5/lCWC1dPoFc/WaYIkkTnnClFNhWtCGxVCL2o3w1R+yiLij3CmRuo5YMmz1K3CCYmjI4eZxNMQ1Lb0NgzMOO1MkpJm4E71lT4QvGGe6sgwGLR+ASmM43a2FzvujEfqfdle5qjKTR2ctTb+wb/v5k+grOVrCepYVF3QUfwkmYsdKWewAONk6N2WjyzCkTxEgbNC58QXHW1X1yI0jhlh6Y0EX5i0WNAIgVqaBnT5aNCfnWr6fBk3Af5TenOcAGCxgtO2xCGBoMM1bQLUjJ3HvJeu3bYqGFB63IEx2iOCFCCSIvyGcELV6zZSy8uBFeEAzaSyHF630RCsyWPUalFGJeX457/O6O53cWaWrW7my0QiT+doO2gfSp/mI0v+cbsoe/BQfvmZmTdZvVnnTN549CLr1DNTv15YAAl7AI/MCGktMNc6+YBgMJCs2BrZsZrbX6N+RMKyfgijutgD7fWtYgngaXFrJIGaiWi/tb+5EuKTWsLMgZeY0l3GOmAVHZa58DZgfnrQHN6CAkoAmSHwEM/qU10eJ9I+ZUXvmMLQw+0g9sXIUGxzYbLRhd1KfZXN1LixvxnjDfl27i2yT3aU+tEAafKMa9zHBi0LEh3hQ1BQIRtcr7tG2Q6/qoXKNexGLqxlio9Uk9aYOmbovEscSV+A44BU5hbNsFhrhn/XAkQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9hTllPQlR4aTY3YTBMa0N3OE9Mb0FPRGI2c0xlajdUK0VEV1JPSE94L0ZC?=
 =?utf-8?B?ckNPOXJKbjMrVGRzNEx6dEtWeGQyU3YzNGFNS2RQbVRDd3JpMWhNb2xXcDBq?=
 =?utf-8?B?OGxFUlM0S0l1VVY3Q2NvWTJHY05YblhuVC9raldMT1VtTnEvWEU4QU1EenVJ?=
 =?utf-8?B?R1paYjBxczU4SUhDazA3WEQ0RVBWVlExc25NdVovdEZmWXlvVXF1c2N4YjFR?=
 =?utf-8?B?RnBGbkRoQkdtaVlXb1FvTmtoRHFJSVF1bEkrVFJ4dmpFeXhWSXdlUXloRjdY?=
 =?utf-8?B?V0NQem4vWHU2eW9BdllWKzAyYjg2UmVyQTg3dmVVcnpQaWVzaUZGVnR3N0RM?=
 =?utf-8?B?ZTFmcFZpSlFkbHVhOExYSUNoejBFSVBkb1AwS2g5ZGFrVXdKMU1kMUVYKzBz?=
 =?utf-8?B?T0RIeVBhSlAzUjU3VGlvMXVDUkVqeEFtUEYwdGdiWTJuYjdhRXV1RThmNDhy?=
 =?utf-8?B?aXV1Vldhai9XdXo1ZEprWVdEMTdJaUpSRUxPNEFkcjlBaVhyM1p4MFlQSFBt?=
 =?utf-8?B?d3RkQ25yMXRkWUNrdCsvSWhHYVo4VHhpZHBFVmNja1VTZ2dYQ1Z0bThKN0pi?=
 =?utf-8?B?RmhOVkJBVG9FQ0haZVlyd2wyOWpoUmdSMUFkdFhCMFFCdmc1RjB4UE02YWhH?=
 =?utf-8?B?QWI0bklBV0gyZXhqMjF3Ym1ublI1VW9WOG5TZmNaaWkxeEg5TTdNN2psMGxW?=
 =?utf-8?B?amRMcElIdEdRQzJmaEhiK0dQcW4vMkhsWEg3M3pTUGZ1Q2VXMm5Yd1Z5dFQ5?=
 =?utf-8?B?S1BPdXJaaGJ4NVp3VTYxY3BNL0dIWVh2cHRCWVFZUVlpNUdZV1RtSGxITE8w?=
 =?utf-8?B?YW14Yk5NV2lPdUllVXpadjE2Z1lLMVlRR1lUNUhqSG0xOVZ3SjlOZk50NHBs?=
 =?utf-8?B?SC85ZnkvZFBZZEVXMFBjRk44dVBlY0lQeFlCQWZSMTFic29XaTBFcDNhVTZY?=
 =?utf-8?B?cXk5WXZUN3hOU1FPZVk0dm5ORVBsZysxcmErMnhTeVRMemhjeTNrMmVpUC9P?=
 =?utf-8?B?dVRyb3F3T1k4VW55SXlGdEs4Z2kzUzJDdzd4c2UrOE4rWFVCWEtxd052a1hV?=
 =?utf-8?B?VG5uajZibklGOGJja2hwZzJ3d1p5azdiVlhrNzFGa2FGa3NPbGRHRjhxZ1RI?=
 =?utf-8?B?YXhTcE9GUWtKMlRvcnlxdU0rVjd5NHZYeGtma29zL0F5YUUxQTMvQXp4aFFR?=
 =?utf-8?B?L0h0VVVpdnlvWXNYTVVnTFRVNGhZT0FkTnEvbnV2Vmk4cXV3VzFZaStLa3Yw?=
 =?utf-8?B?LzRXUTI4QktLdzFLNlNEemtjZGpXakZqZGoyVVRYcUIrQStEbm1JZEY3Q0lB?=
 =?utf-8?B?K1o3eWdJK3M1aS9PVGxPV3ZCbTZwKzlHeHVVcTNjeXRZSXowNWQ2QlFxZ1Rx?=
 =?utf-8?B?MXRwK3dzdUVwTzIxcVVBMVVHWjE1NSs2dFlNUHNYVGdpUjgrTVJIR0ZCc0J5?=
 =?utf-8?B?ZDZsZ3lQU20zbkMyUWJQOXBNQ25PbkJyd0FzcUU5aVF1UlpqcGhzUUxDRXRW?=
 =?utf-8?B?Q09QTkdiazAwZ25rOWMrMG9BdkxtYlJrTHlUUFRVaGdnSjNTTmgzVG52MFFK?=
 =?utf-8?B?VGxhN2Nxa0NnQ0pWWVNYNXNhaDRBVnZyREdRZFA5ckgvVWpaTjNmQ1kyVmdI?=
 =?utf-8?B?THNjall4ZEVEVDQrSlp3MWZlV1h0R09jWVo0UW5ZZUdVV0tIWlVjVGFYalFK?=
 =?utf-8?B?dFV5TmlJTUFDUVI5Y0dSL2ZUYnJYTkVXcmJXanBIanM2RDlHRlpIcVBuZll0?=
 =?utf-8?B?eHRVMkFyMXFmVWRFSXV3UTF3MThlYW90M0tzWHhQNnVIbnVYMks4THRYY3Ri?=
 =?utf-8?B?Zng0OTl4c1RXOG9mUEp3a1l1MTN3SENocVREeVRvalJjMEZEaFdBeUU1V0hi?=
 =?utf-8?B?K2RvRVN2c1NqQmtGYlVwQ0NVTlFRT1BDSHFrTC85ZU8wN0FXMGdzVUNkdzY2?=
 =?utf-8?B?NkxLVHBmd01vUTg5eldsQzJEZDVpY1ZzUXI4dEpGaU4xb1VJMzlKRnU4bDNp?=
 =?utf-8?B?a2Mwelh0ZWpFZS9uNm5NVVNSdGdJZEhMT0dyc0VPVlBiWC9Zd3pZUEtPb0kr?=
 =?utf-8?B?ZkZVZDNuR0NuRFVGcVZWOGdGaWRHY1A1RTJWUkkvb3MxOW1DOUdJZEsxcS90?=
 =?utf-8?B?UUxQZzdkWFFQTTAzMlpuako1cWtlZmloY1VqVkdRdWE0eUtZMmk0MXJwR0JO?=
 =?utf-8?B?Ylo5TnJkR0JLMEp2cEtGanNFeURyUU5tdUdhNFJDWG9UVkJxMktQMzExMGI2?=
 =?utf-8?B?dStOMjNpUzViemNsMVp4Nlh0NTIxVzEyUlhlMnJvdkNVOGdjSVdjMmFUODVI?=
 =?utf-8?B?eENUSGFRZ1VVbExRVnp0d0tyc2V3V1NvQ0lnekxVb25qOG1WTllQdz09?=
X-Exchange-RoutingPolicyChecked: YhZ7haF0F9NcXgpt2rEVdMTooLBkSJjMgGHvQz9+Ui/kmEaKTw15jGba6Jkv6TdFr6Dix3UEcah1ffVtcUHQXjtt2VU9DdELBxr8xXhBoZVexcko1TmbMt/3S/ZoYme9yVJR0ig1TvjVpjIrYcqpM1Iwpar3tODvPU3QQwMVPhzNsJL1D3v2AyQwxBB/xAZcezMa6rGIodU2Rqwq6FOXzACVAjJa06CNHUV//3slMqLseKOC7t1vM7cb5GnchHJhwCqJFV7/wzFbmJ6+WaUlHq0f1+K2xeq0cgZ+imIdzTjeSNvn+l+52ly46FFIMd5ICDftppcisSVdgR8pQV2lDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 787587c6-1610-4e92-6970-08dee83beb39
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:18.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HudHiaF43MQs/AnhL0iDkouuCCtA3q8lTMPT+P/NxLQCdRzJxYIwxjMEKPBaUcSLAyFddMjJNBCYKdYNo4C92u2zCJSHfVoqeAS74xFu/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:25 AM, sashiko-bot@kernel.org wrote:
>> @@ -7082,6 +7082,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>>   	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
>>   		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>>   		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
>> +		if (IS_ENABLED(CONFIG_KVM_APX))
>> +			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
> 
> [Severity: High]
> This is a pre-existing issue, but does enabling APX here push the default
> uncompacted FPU uABI size over 4096 bytes?

No. APX repurposes the offset taken by MPX previously, so APX does not
increase the XSTATE area.

Thanks,
Chang
