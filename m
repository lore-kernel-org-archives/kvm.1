Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E843B3E1
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757297; cv=fail; b=ZXxTxsgJxNSw7tkKIX0jbpm83Andv/m9t2E5Za7H79HKwfTuKJtdcoaw88Wzp3u092pC289uTVBCv2iRwTPIMB3NPnrp87vwcWoKONON4i9oBJee3Yo/n541Q0qTTGz+UTbHqYmolauFvr1uINiz2HqsJi3nOik946enrwmWZ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757297; c=relaxed/simple;
	bh=BHMs2xiOuPngCnHwoxbYk6NRxp1BGKFxaeGRD34VanI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcu55v3yC2+2HYaY0dcm03wWNlac6c7OLI9ALJfamrydDsdAdWbJ+rXBcX0sbn+SUt+bTr2iIWg5z9VemPB6PI5033IfjknqNpEHdb+R1lC4qnRmAaGaErTvVAGFE4Qhlmb0j+QLC6QNPitOMU7fXPMMWFM0wvOuUy5tx3lCaPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajeGySsS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajeGySsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757296; x=1816293296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BHMs2xiOuPngCnHwoxbYk6NRxp1BGKFxaeGRD34VanI=;
  b=ajeGySsSXWoo9jMo2Jvo7oO33GCpNkajVPssBQ4BYom8k1KTrY3LQWq2
   I2QIe+mH1b0h8erVnRufMhmv4HDFApKlWc6ciLLN4wa2rytbaKotolyYN
   JnS8I+yai7KPc4UINjOtbJOD2KXA0p4YCVAg/flEJEpt2m2ikp3ca3DyA
   965aCMoetvN1/HIYG0EPB9/FIrpzMD1lEZhJy+PcUhkAscUNJ0kfE+hsy
   96Zn04AgMF0rcIJCjYLybhdve7sPdbFxgoJ4V90g2yXAnxWx/9jigX4/w
   xaUSpa7cRoIq7E3TNfD2eseGvh/Q9qOHPDZZrmTkIXCc0Lz0FtRcfPhQk
   A==;
X-CSE-ConnectionGUID: FuqL2iTsRNaSzaeTna8IzQ==
X-CSE-MsgGUID: IePuu6ulRLCE8WtPlHNWpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110949084"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="110949084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:54:55 -0700
X-CSE-ConnectionGUID: aHAw0y/cQEOxgQRW02Tqmg==
X-CSE-MsgGUID: uqk4VFiCSA6EtRY2e6Fz/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="288212994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:54:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:54:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:54:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2v6c3WUqJRkPtvKvWWp7U6K8LKjt/mM4Tt/psz7odXxLWleg0wZLuY/nfc4Oe4OV7Fn5BJSwYSliyhzqjCWZBWxozOhSQZ6aHA/eKRKQP8UN2OVEcEAoz0RruxUZ8Kg4jLeNvMqR99aMPCGhWvKA0mMKzQkZouCzeLb1g00TOijKgiQAjgQq8T8xUrl9lnRdx1IWbPka1K9Ijcx1xtw83KCDC6Fwzvmiy3Ioshjo4J+2PUbTqCCWWIWXDiYMvgcxnIOm6pyWHXWteTzb88XhfEBUgJN/6UVj/NnbzSiALt/3o+kg0fJ1sd9m1TeOJH0qgoGL1XNiiwm69JzcIdR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84q3nPolJsIc/jX0nC6IHnxXY9SVXvy7lohz8Pgbn2g=;
 b=ayA1uelOQazS4JYlIF5Y1+s65+h+141agjIGpePkbkjRi+gF+JWYe3FAX83OT3WGqNQfkVfrUE7F/Li8yETHDmqJrJHKjf1Ky2JA4MFi5ck8659AMLKQTztn2zcsUE5/f2IBohLahi7eOj4bZz6ws0eRxhaMvpqttsolf7uRc/1lGUuCtY10/m3MaXUnmh/VOnJZiI0W6i247BAskKTZenfPuQ+GTYGTTaaoxu3Zq5v98r3fDZlBWHt1uteLEp+NQ3ogcAtYJjAi+wCKSVGseumA2on6Mb8h/e/H63vF1k7VWYIo429rZtmgo7TDNVJr5T2uJ9h4ZD3i6l12rYS9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:54:52 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:54:52 +0000
Message-ID: <761b969a-2d2c-4233-b3ed-2f0f35f04864@intel.com>
Date: Wed, 22 Jul 2026 14:54:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/20] KVM: x86: Support APX state for XSAVE ABI
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-4-chang.seok.bae@intel.com>
 <20260720182224.0388A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720182224.0388A1F000E9@smtp.kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: 2dea371e-735a-4efb-c89f-08dee83bdc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|5023799004|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uAHQWpn8yB8LkVLu5sRIBfc0LuFBmBkH9TbFoJp4BIqnsiKo89JAESRgr+yDw0c2kJM3iQ5ugb95YWQ4cYnV/fCvQ5fHUW9MN4jFUfdMu82jCefxKgBQBuVmt0LL1ILhjVHUfZpMshzWwl7bab5EyQ0nWrdubMNU0fj64dzkMwlOOgJtuU2vVwpT0Oqi078pAqP+OPKzVayXS51qAmR7vkQemos8KXEq42eum6JD0LBgdf4JxbuOjPxXTUthA+7v5oilUV7pI4KYcv/tWxmn6NreoAEl8giZGGihT3MbidIfEW57Fm0XqpjrinVhWpGH07fQ9URLJ9KCFnJi7NxSnhk9caegIkksWUcH+0i4HSU/eUqJDpELnqdKUjVsk8jUOsgKNm1khfwNJiDCAs7V7S/lvD3g6JoYNVtYD7LJRCeu4bZYmoQ5e40y9vmGJCYbpqZ8QmBhE97YaAyn/4x4SKN+N2BjLoJ2p6nhJetSfX5MmO0LGMCZyLoj1x6mPr0iIvjocIro/VFsqkkBuaKGCDfPsddPUvprUa/Kz5dKtqWGpkyfwM437r8e+1f6s+E0EqBlBmiSbApgTPYlc4k79K7iCC7zHy6lm6b1efzdI1Hj7cHZHT4OoefAntHRaYw4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2orYis5ditQeWF5cndEbU5ta01aclVSMFVXZ2RRVy9KVHBIUTl6ZWNYRVRa?=
 =?utf-8?B?aG1GUE0yT2Z0VlBadEh0bFpoYnpSUy9YWURWN1ZzMHIxQkgrMjVTTG85bDdJ?=
 =?utf-8?B?YVMvSG1WMnR2K0R1eG9QK0hPRWY1dis5YTFSREd0OENnVExBZEprNzdUaEY3?=
 =?utf-8?B?L2I2Qk5EL1NDaitadWFjazV3aUs4RHpTK0ErcW14TnNLaUpyeTZkR1Rlb09Y?=
 =?utf-8?B?b1JOc3Z5Mjg5RWxyUFRoK3dWMmRkM0JTUHNaUmhNRERZamxsK0JDZzBYdGlv?=
 =?utf-8?B?eGl6ZEhQQkp0QlA4QytnNDlYUUZ1UmRab21jai9zZFkvU1VHTHpUSVR1VWRF?=
 =?utf-8?B?YXh0OHpwcVprMUh4Vmx0ZHNNaVBYcVJmTHV3RFRUZ1hDZmFVR0Q2VmJjQ25I?=
 =?utf-8?B?MGF3VHNpb2Eyd1dvaHVLU3MwK0EwNnNtUmJlK01EYUwzV3hpMFkwVlphdDV5?=
 =?utf-8?B?RTBzVWNGTnJGdHdYY0p3TGVJMW8wb0lQeGxiS0h5MHZzbGFjNE5hNEFCQmta?=
 =?utf-8?B?N3ZjZS9DNWlWNEpTcy9yN2dJa0hBZ2g2MjFGMTF4d1pIM3Q0dVo1Ymc4UjRX?=
 =?utf-8?B?dUxPYkFMRWY0K0tWN3oya2NNNUo3bnk2WEdVcG05ZzAyK2xabzlXVkJmZXEx?=
 =?utf-8?B?ZUU0d3JNY2N2aWdpVldXWnB3Tk4xL0lvVEhpRlkvVGtzQnZRRzlPY1Arb3Bn?=
 =?utf-8?B?aGViNkwyTmdXMW1mOGxGaXRMVjFWVkFnaTAxZllrWVA2ZGlEMHFBdUdCNFJB?=
 =?utf-8?B?VFpNN0llTW1MbzZwcVRlRWtlbUE5d09hajRYYVVreWVOd3BoYlpiSXhrcEZC?=
 =?utf-8?B?bTYvdXhWazBlZjREZGZwcCswOElYOCtYSnZmOG1ybTd0YWhGTStGM1FScDA4?=
 =?utf-8?B?RTZJejdFMjF1azZnUGVMTDFRUk5xbnpHVVZDbWphZ2dqNmw2WGpUMUFtTVUv?=
 =?utf-8?B?UDRDMENUZnBBL1ArendZakJLTlMzWWJZZHNRQUlXNnRBRnpOZm1SMGVjYW9K?=
 =?utf-8?B?SFNybEJwVWxBaUcwVk9PZHpCQ3RSREtqbDRCV01JN2djclU1T1dxenorYzZP?=
 =?utf-8?B?YnUzZDFaeW5adERzUjZZdDgreVFJVDZMUDNqVnRjSXpPeTJQeSt6NHR4UURG?=
 =?utf-8?B?TzN1aHRHaElQQlRXQzc3OHVBNDExU0pjYndlOHludTJ0a3dEVVF0aVBqMVFL?=
 =?utf-8?B?Q25laWwvVFNCNTZZYXJ2U3plT3RZdE1PSEVxcFlVSGhmWEUvRG84RVNGc1c0?=
 =?utf-8?B?WHlBNHFSOFNJUHJ2a0MrRWNxTHk1Q3FMODFPWEhvdGxsVWhMVnJFcU1rcVhy?=
 =?utf-8?B?RjYxeFlDT3VxTjNkQnJJaEhEbXU4YlhhbXNienVJaEpraXUwZ2p2eWVHTHZK?=
 =?utf-8?B?TTNKNWRoeW9DbUcwcHJDWTNhRjI2N1ZEQzlJYms1d0h4bk42R2Ywbm9FTlgz?=
 =?utf-8?B?ZnRCNi9wTHRTcnFjcFdSZllPdWF6c2tUYWxpN2V4R1dsdXBYZDFFU0JGNmVN?=
 =?utf-8?B?M0xtK3l5aWthUnNlamU3WldvTUtOKzZORkJhMldiYlJQVTlCVVZMYUIvLzJU?=
 =?utf-8?B?NmIzYjB5SS9PMEUzcnF0S2dFN0tuaTZQOGIrMDRNN211OVltcGRvZmg3dWFM?=
 =?utf-8?B?dU1VdUlQT1pMVW1YeUZPemcxQ0tTYzZVeUt4MWd1K2VJSm1heWFHN1V4alQ1?=
 =?utf-8?B?NWphSFpaTm5MSTRCT3FrZXVmQVE5bTEvcGh4cWVpOHJOSlNRcXpmWXBIeFFQ?=
 =?utf-8?B?VGo0aHJ2SzNWN1dBTzJDQ0dQSnhLaUpZZ3pPY05Ea1U3S0dvTGo4V0QvMHpo?=
 =?utf-8?B?UmhwL3RQSmEwWXl3bjJIRFVINUdIemQvcThjNmVtbHhzV1N1Qk1wSXVSTFJT?=
 =?utf-8?B?RFVCbTl1SzdrWENaVXkxNWE0WGdWOHc5cDBCV0dON0tuOWVkWFNwbTAyRW9p?=
 =?utf-8?B?MnNQVURrWThmajlUd2Y5T0Y5N0R0ZXFzbEFGekZhcSs3NTRDaFp5UHhXZElO?=
 =?utf-8?B?N1JyakpHQWFLVE11Z0hpeEc2eDFkeEUvczlxWk1EZDVodnc3emQyQmdKU2Nn?=
 =?utf-8?B?SFBISUZUNVpzaU85TGhwSG5QZ1ROcDVLa1hSd2pjTlZiTDlpZnRKa1pRbXo4?=
 =?utf-8?B?cnFTSTNXUm9ocGtGVk11WTFtWkEwZTJkd2V3S2lnNUJIeWN6Z2Z6c2MrditF?=
 =?utf-8?B?YmxodEd5VVRwaEpSWTNPWnFTbWFLc0lnVzA4Nnk2RTk5d0l1YUVRcm5ZRVBV?=
 =?utf-8?B?THMwYXc4Vkl0T0lYaDdYL0RxL3NDNzNWNERxdjJBdDZkc3FueXQyN0ovV0dQ?=
 =?utf-8?B?ckU1SlBwdkFGUEJQdWl0ZjJFWmVMek85cVRHK2ZXVGVndnZKQnFZUT09?=
X-Exchange-RoutingPolicyChecked: LJQpsKvfnfkGdfX7std3BMradmvylBC5sV9FbkEr7UMipbT1flCn0NmuEo0OG6A2aQ5sqj3g30dRSN9EPjK50KvEPsLqj56rWDsIToK6wGZpeCUmw7WmuYFFzxVGT7KO5cIRTouhKMmjyUvTlnYKhte8+tPfwW91yth5BhGZ6/NgShWBFXVxCoSVEuJvKbNVRb5RMJLk7zhcA4+WEoglt1SLl/plWz80dC32OZExTJ9/LpZvkssS2knwsrasVknAIx3pVwL39Y/ajO566LKUk0hVIhFEr4TTl+jBohk4fkipqnDyK3PreG+V99JRWTh7D8t9Tf2IehwJMo79xEfA2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea371e-735a-4efb-c89f-08dee83bdc0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:54:52.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWk9Z/9vi1WX+eU8zZYPWCV01BaSU4MbwKHGAufRQqJI+GVLksMCFwzvNY6BYkrxAWSctmX7Ge3hj+Mw8IeqAoBzHcYYt9xy3YRZETI7n+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:22 AM, sashiko-bot@kernel.org wrote:
> 
>> +}
>> +
>> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
>> +{
>> +	union fpregs_state *xstate = (union fpregs_state *)buf;
>> +
>> +	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
>> +		return 0;
> 
> [Severity: High]
> Does this early return fail to reset the APX registers to their architectural
> INIT state?
> 
> If a VMM restores a vCPU's state using KVM_SET_XSAVE and the
> XFEATURE_MASK_APX bit is clear, the APX component should be initialized to
> zero. Because this returns early without modifying vcpu->arch.regs, could
> this leave stale data in the VCPU's APX registers and leak state across
> resets or migrations?

This matches the existing XSAVE uABI semantics. XSTATE_BV specifies 
which state components are being updated. If userspace wants to zero the 
APX state, it must include the APX bit in XSTATE_BV; omitting the bit 
means "leave this component unchanged", just like the generic XSAVE copy 
path.

>> @@ -3161,6 +3211,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
>>   					struct kvm_xsave *guest_xsave)
>>   {
>>   	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
> 
> [Severity: High]
> Will adding APX as a static FPU feature inflate KVM's base uABI size beyond
> 4096 bytes on AMX-capable hosts, unconditionally breaking legacy KVM_GET_XSAVE?

APX reuses the XSAVE area formerly allocated to MPX, so the layout does 
not grow beyond the existing ABI size.

>> @@ -3172,6 +3223,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
>>   	 */
>>   	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
>>   
>> +	/*
>> +	 * This and the following copy functions copy APX state into each
>> +	 * storage. The VCPU cache is the single source of truth but avoiding
>> +	 * this redundant copy tends to introduce special-case handling. Since
>> +	 * this lies in a slow path, keep the implementation simple.
>> +	 */
>> +	err = kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
>> +	if (err)
>> +		return err;
> 
> [Severity: High]
> Does modifying the APX state before validating the rest of the FPU state
> lead to a corrupted vCPU state if the ioctl fails?

This follows the existing behavior. copy_uabi_to_xstate() also updates
state incrementally before later validation:
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1363

This patch still preserves those semantics.

Thanks,
Chang
