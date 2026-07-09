Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2B397338;
	Thu,  9 Jul 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617530; cv=fail; b=QFArAIavFQpdBPQ0IKYdiPBpR4HKVlo2CelFbrAfMJA5b0DONUMAao3f+sPLR/wI81OFrgOOaqkZDl/U6HD+hy7rqOLbt4VMevUXUfwQ4BRYfchNrIMQ4zbK+e2ELyWS5FKDYKjbS54gHfcO1xKK+biulH78Tv8A+dZNLJ28v38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617530; c=relaxed/simple;
	bh=53X5kOgIhoDSehIbpRA6I63k84VPnO+cntFDxGlftag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dd8NN0m+dYEE0F705hde5a+hea9Afgutr7MRei3s/wVqRQLBZNtmCdVqag/ydNdMneTptYL0DrvXEI9jkkNeEXg34CgyK5qN+3f7SayIrneMPsrc9jcrWbdUyuevK2tugdSxc9zdF1wXlZdm2R08P9AAS0Y8sSFKDnO7339ApQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFfkXkIc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFfkXkIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783617528; x=1815153528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=53X5kOgIhoDSehIbpRA6I63k84VPnO+cntFDxGlftag=;
  b=JFfkXkIcs7f8+OIxBGTywWrgzNaVwy6bM1D0ULbl9tMcDfBw5AFzg7/X
   2vVM4IwNZnb19q04N2t6xOoks+I9x3fv+Vej7ckOq/AazvlnDBYuSowyN
   mnFfrYTcGHNKQwTXZ6+fyTu1caWP812LVchbgV+lWp0BQqY9bbOgAICLN
   dktvwmRStIbQhyLReEg6+zSbQYYlXCfTgdQjPPxylFQ4PQpxL6aaKWnDu
   fI8dDkMI0YVJxyUAI2xKxIIrpYeu08dFDfb7hH0crvHPKtIwfS7mKVzWf
   e3Y8O8tU//UfndLSfPCX8MvxrcB/ahdhWKLrVeLRHF8CrynLjwyLtL17f
   Q==;
X-CSE-ConnectionGUID: IaaJEyw1StaOWk2QVqztAA==
X-CSE-MsgGUID: yWCQCBcPRlO4/Zf4XI/Euw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71831040"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71831040"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:18:47 -0700
X-CSE-ConnectionGUID: gtr4FC6hSAGzKWvVN+WmhA==
X-CSE-MsgGUID: 2u/tv7xIQUWT1kujEydR8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248278123"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:18:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:18:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 10:18:46 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixkR4YLwGZbaaFh1m/TeYRLTktf4/kleDCJcj0TiDkI1YYyd3utIdE9+czBF+xlEdrD2hGlpOJUy6v9xb90cdmn8c+JZsh0m5dZGnd2H1kLhBrY/TAFJIpsrTD6f5Y4TfEytyboSq78OnkhKw0VcWNzi7xY4xylyFF1GFiB6kZsrOFNGoVF0QQ/AhP3Uq+gCJJ8M8VmQRMvQXWawcMQXEL0xTixFi7VhfrOTau+GbWDHW8nALJuV8HGxvNN7+VYJNjz76k6SDa7gKbuL4ZELeLsKe+rWlmVCArrDWSNzhF15Ad0fUaHpRlfhlXcrNxg6MyGB9ZFTlZFpFPQpZjPtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOaErjVZFQfwdnRrNI2JJTUfXukX9uoOzW2s4rb3IzU=;
 b=rW9C6DIUiw84tJaTmhEftupTSTK23vvfyWCCMhMG9F/ZOAqmDc92gV/QOwMK4eYpFYDWJ3MCoF0h0Mowzq+FQ5ECkaLRhxpVSTiq3NVkue8xgrxxh05zEoJsKce/XMRLXUTDt+gfWkGmYfcu64fVAG6lscPRONHsQTH0W4HKGdHpuZJgM1FmZxiusvBQZlnADB10znI3Zo2S00vOayVDu39z2xjzrBdlnzDsxBHux/EpF52VCqucngMfuwlTeyAYcNzS7/a3UOBg/MrnzSQZYtxhYryYN3CsVODb4aqbUFUCBwS475t/RcbwLK619HTLGpPCv3EAgaESSQwr8kxyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 17:18:43 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 17:18:43 +0000
Message-ID: <958ecf5c-4bc5-405a-9de3-a6dde235f0b9@intel.com>
Date: Thu, 9 Jul 2026 10:18:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
To: Xiaoyao Li <xiaoyao.li@intel.com>, <linux-kernel@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>, "Zhao
 Liu" <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
 <b9410638-57bd-46c8-b455-d4b288f0a9b1@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <b9410638-57bd-46c8-b455-d4b288f0a9b1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc1cb0e-0611-4564-8a7a-08deddde2087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AnqEMi9iQVuUkUAUK8Gtb3EbEhNBrPjkY0+ku9Q7bEQWHDWSnVBzEdCmoryDHuKvJU3Umzo4iEqw/6bDVtxB18DdaG59eMWb2Ij/Lj3QEN7Mh/ckm1QP5EO+OGSupyGSVyR23O6bZbALAO5NwnvMuyoKgIPsoJIa2NjP/TBwEcvX8cFF8aBMB7GpjioHJyLqyX02BCNcPYCi3ZJvpFHYYaXBqLLdGrF+DDwJHgL/lsFwbOmpCxTBFA914YpxzoIn8SYM6D2SZHbzOtrccT+71BO8KkLF9B1SYlRMQd+z2YJmOiN0b1+alrauEk1kH3/dj51dLZKrBr+cvMwvbtdFwM852c1tgg/Tb1YFF0/pU1bROrbJyue/U8yoFTHTttch48y8NA1hHa8XWh52gyse4IdIbEWFoqeQ+jguBPt47IUrmAyqWZ0tLyAybt9/2iinngAz+27dVPD9Sa87Lp7UHgEDIac77Y99OMzZqAliTnkrfoyKnfNnJLBxlunOSjwccVLepoeEATx6g2m3lUheEtLcLMczmxC0R9ehzZJK+TuLqp+kdI/crsvmGtnfkE4EoLjvqbahdBgmeAEbpz0twnS+jcEHGP+8g7I/Fsxa7IeT6YaGTpO4Yni7NVRDT9TVX+lcqs+t7G3MQ7R294Hb+6JgCANM+Th2Zmzy+0QCoF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFJMkRwRWZxanJnSkZWNXVwM3Fsa3JaTk8yeE4zenYxYkpuLzlNcGYycVp0?=
 =?utf-8?B?eHJZVytIQkF5eW1VMmVZOFdURXpJNkIxV1pmTmk0S013SlpEdHdEaHNkUEJ4?=
 =?utf-8?B?U2lyVlNRcWRPQk9ka25QcFQ3WHNhT3IxK2ZrQjlRZFFmT1Y5VFNZeXFtT2Iv?=
 =?utf-8?B?TnFlWFd3UEpnc2thWEFPbVFEdjBUcGN4Lys2QjgxMVFmNmtUK0V2YXBNU2hP?=
 =?utf-8?B?QWpzKy9xSHUrY0szTmVmSE9ZYlVqZUhIbWY2WkpZTzdBYW4zemtVd010OEFk?=
 =?utf-8?B?SEJtY01DaUV3aGJuTSsvcjZVbHI1OVRlMGJBZW1qMGk0dzY1emxvL2NubTgv?=
 =?utf-8?B?cVY3djVCSTZFQ3RQY2drbExLN3VlaXM5WTl1elRmUmhIZXZaVVlnOVVoNXZk?=
 =?utf-8?B?TG5KcktCQnZWaHRYMGJsTk5JWjg1Z3o4YTYyandnQldNTE1OcHhEQ0FxOStk?=
 =?utf-8?B?RHZXQmMvQVlFWkZuMDl2dW5TVmxXOE82OXdvNVNyN2dqUGZkdExINkMrNTJU?=
 =?utf-8?B?WEZBM29uWFhZVmJJbkZGOFM5SERsSXRKMzdPVlVVMDFZdElBTEVDZDRYVVZy?=
 =?utf-8?B?RDNQVzNvc1RPdFNjdWhnL2lXellLaTZpYW94SUJhY21VR1JGR2JWcnJXb1BU?=
 =?utf-8?B?RUQ4blNtNzdCdDBseDhUVmIzODF4SmFXQXhOZDcvdWc1ZnNLK2d0OUZrRzFO?=
 =?utf-8?B?bkIvd2dENUY5Ym9GckF3RXFuTVlQRng0YU5pWDBVM25VNVVEbTFnNjVITGRX?=
 =?utf-8?B?YmxZb2gxSzc1dFUzSE9NZXVIS3BHOXJObEw3ZzRNWUFtVlorMVZMSFlQRE1Y?=
 =?utf-8?B?T1liYTFOSUZkODh2N3o3bWlvZm9tWkJBL2l3WGVDbGNxVHlZZkJjNkJXdUVh?=
 =?utf-8?B?ZHhxOWRFLzB4dEFkMDA5ajNLZXdrZW9YSzZWZWY1YnlmZHpoVzRJN2dvdlhD?=
 =?utf-8?B?ZDRkU0NSVTIvTGR5a0dqWElKYmFIMTI3Z2Z3bndvMTdOakJZSWNIRWxROExj?=
 =?utf-8?B?TWxzS3pNNUZaRTFYMjZpd251WUhWQ1dGY0ZwOHpKcTdtTkhlQzZ3L0ZmMFkr?=
 =?utf-8?B?OGY1NXN1MDBDeGVUZGhiUGZPbWx5T056Q1NTcXZGTzIyLzRBOTNKS3dxMmE0?=
 =?utf-8?B?c253d28zcTdTd1lUMWw0TDNVeVY3ZE50RS9WS3JselhQVW9veVJpTVNiZWFa?=
 =?utf-8?B?ZllBT0x0b2I5YWxlREZjdm1aTlQ1anVhUXc1RXFhWWRVT3FSNzRiTWV6S1dv?=
 =?utf-8?B?WkFHRmNJb0NyeU1ISkY4VVpobWpRMWZMMFJhYXIxSFBLci9DV3FGQ0F3QkYx?=
 =?utf-8?B?aHFHdWwzd21QYThBbGV3SWNSUmpLZ09xNEx0ak5VQ2txRnNscm5HMjlwUnRM?=
 =?utf-8?B?RDZ3Q1hHWXlnOStoUHBoOW1mRmhkbEcxTjZUNjRPL2FZLzFzWXlQVXQ4MDk1?=
 =?utf-8?B?RkdXcXk4cUl4T2ttZkFRYzVacUVRbnNqNVlJbEVQbWNCbms5KytqT05ONjRk?=
 =?utf-8?B?ZXFXQ2twWVpIWHBMclIrcldrNEpnT3kwTU1IZzk5U1BYNGdIMGJBekFtdktl?=
 =?utf-8?B?NDJ6WE9Tb1FyVHVma2s2NUJTdUMzczNJd1hPWStEcFhpcitscjFLMUZxSm92?=
 =?utf-8?B?QXYxbTdVd2Q5R2dMclcvVFNPV0JGOUNTT20wUGZaQmd6dmc3MTl4Tk5TOW0r?=
 =?utf-8?B?RkgrMm91c0NMRGREa090SW0rZDhGRGlVcUM1RkticFcwU2Fhb1FheExIbFVE?=
 =?utf-8?B?YlQ5R2pjNDUweU1ZdStZTm5OUUVpU3o5aWczOGpGdi9ERi9oVEtXWU5ENHp5?=
 =?utf-8?B?K2FCNTlPWGpUM0lHT0F5YURUdU81NzRwdWcwdnR5Q2t0QjlFUG92cjN5eE01?=
 =?utf-8?B?YXQ4MEEwcGwyNXNvQ09CbVRVbXBiR0JaVkJ0SHB6TGVjZnJ0OHc5a2VrRjJR?=
 =?utf-8?B?eTNhMmNWTEZiTjFWK1RMRWFIcVN4NVBnKzBZL2szSWxLa25YL0FPcll4VFpr?=
 =?utf-8?B?b1JhVnY4T0c5ZGhlci9oUHJFRzVEYnhoY1Z1S2YvdktzMXd3bG5oOWQ3QmRw?=
 =?utf-8?B?TlpzeDF1R0gxS1dlUW95OTc4WGMrTkJSTy9ZZzdlekc5R2dUVmp2WnFtSGtP?=
 =?utf-8?B?ZlNUWlFCYmprZ05JamZkL3pPOEkydXlDUGNUaE5icDYyWk1Ld1lMRUt1NzMz?=
 =?utf-8?B?WXJEbGZ0UVlEUDY0TUZDa1p4WkJ6ZWloc1pzOEdxWUJHWHRSdjFhOVhtNS9E?=
 =?utf-8?B?Y1MrdjJ1c0NpYjRLYWVrb3dPU3lOclRkamppZVI1ZVpscHNiR2IxUzZ0ckxt?=
 =?utf-8?B?NjRRRGJrTTFqVHFwbXh4bHZwVWVHY280bEc0ZjIzSmFOQ09VRGJWdz09?=
X-Exchange-RoutingPolicyChecked: qTx6rfGiiB+TjcYQEdJK7nPg1sQ5BpQiwG/+eZuGTwb4BgP9Hlk7aKxLTkEwwJyZc/xfFM+I1n9f1AaZsxv7SV7+0F89IMXldHWiOPgoWcmAPdzCr1kbcuIHN/3f1fT5UpilzYfDj0T/Xh1zxoJbXFyhOC1hkvpBKH39hQDJn7vUa+q/H0w4F3sb0OSFZh469u+/7JAvCxffUTnEpQXpYQYf0/d5JHbLanWx7tMpeuGBDvgH5GWESgUZqUbVEPo8Uf4Gyven9yoRX73q+OsoSBxbqgE1k7ov0lTNsUstC7F1TG15KGRofqpoCyTO6uvP8qsYqz0hoPOHpBcB6GedYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc1cb0e-0611-4564-8a7a-08deddde2087
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:18:43.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUgdsg+mcjXX4SNz0qXb7L/XJiFlux+5xJK+WqWb9hYFuBmOTwKjxieBayTO2k9R4NSzLEvUvhB7FnKxBvvGjIdNU8L73ZF7P2AiXZWz++U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

On 7/8/2026 7:12 PM, Xiaoyao Li wrote:
> 
> BTW, I think the bit cannot be assigned for new other usage in the 
> future and becomes reserved forever, right?

Reserving the bit forever looks contrary to the purpose of this patch. 
Right now the bit is already taken. And shipping processors will report 
that CPUID bit as zero. So this removal intentionally makes the software 
into the "it was never defined before" state. Whether the bit will 
eventually be repurposed is what I don't know. But that being said, I 
think it should be also backported to @stable.

Thanks,
Chang
