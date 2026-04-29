Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C6536E467;
	Wed, 29 Apr 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483351; cv=fail; b=aPGVmivv1970G73bXtewNOX9HDHSI2Dpph9N0FonQ7U9hg//t9uGT0yjTMc6/fbueuRkyAG2LYmtGkmuF/yr6gbHPPrCf9uVgsWNo7oAgXMebgDeAFb2UWXcThegKoHG0o1uEMa1ODrz2XpejCHkLN5JI+6Dd522YUG+BgqLa40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483351; c=relaxed/simple;
	bh=vOsY2vsTIRVMUoyFwFnZxtOI7uYtFCILOOpkWKlTP8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2n1vVDlC8Bq0uhBqVitnUYrWZzL0i3Cq9uMY59OVWjtqYdomkMygctZSDRdtiOxmCVj3IJuuQiKtoOGs4+ge29Z1PafFPuZrLOnL/c1lXpAuGHnc7bb9O23RUOS2squa+v9cz5Wi98xcXYEb6DVx72LqIt4AJH99br0DN+IfCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxY3DTXa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxY3DTXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777483349; x=1809019349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vOsY2vsTIRVMUoyFwFnZxtOI7uYtFCILOOpkWKlTP8o=;
  b=nxY3DTXaJmqxu275x7r0KWnabu0FDtoY1DDszYeTllTFXWCLJe+tgiV6
   WGhXFJ5l0XS3he32wGSGM8bJWyCARrq4w3hOTIqqGYs4Z6lOCcLBloQiW
   S9OHwNmgiFyhCwRZHqbsmqsYh3LJu/IEd2mudLCqTLe2IYgKAtAFwHz7w
   iLqFYT4rTpv06q/uGbv4vTnjptndgCSmyTrm4aqSqtAJxVr8kdFy5084F
   WjiPzdGclwphTto/Up+oES6QLfBsvUyqk9laWjFUZMZP++LZZ1TwStYqS
   iCatAzbMETcNcKAClXKIsfiAPodsVoUWlz2Hwb5WE4WYSMES9Inh/+2mZ
   g==;
X-CSE-ConnectionGUID: pCWXR4HTREm1VoJOwe6c7g==
X-CSE-MsgGUID: 217ksaFlSE+ZMRzigYjVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101082079"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101082079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:22:27 -0700
X-CSE-ConnectionGUID: rtAreYvRQ9iudHXQPq0RUA==
X-CSE-MsgGUID: /EsonwHCQDakUe8pE2gx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239351879"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 10:22:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 10:22:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 10:22:27 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 10:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Il3zORHnNVGuZHF28kZyG+IDpLuKCQw2yxwJIftoQBo6NbB+pHYJicMF1Ofm/G/Yhx/fRYQNZN3QBDdGdXCC1XmOMxBqlmK0OXRCyfKkRGJxzTm2c+z48mXYmp1EJwgvrtQp68LLqx22TGagvlaqrKOLjItX3i/OxhOhlPGEv2zjcX0ad0DyrfK70WUruPy8Li8wx9eFHDRS/gKnrTqOl3j5Ndd6TrjSfJA14JSn+bEEHMwPpW8MdydPhhwmFVpY1Cp0GdnGyFshoyldq9J8JCdkLryBhvyzA7uJIsrfraWoQcoALoW/GcqoEWeiuOpb19QqhAsbtBxgdg53aVB0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj+2u/onaQRZyAISVmjdtXk9SHaRa0qgH/dJtZxUI6k=;
 b=OXVqy87wbQwoJsXrebRmXfwxiYWbF60EDQJ1BSfj+Nb6Auqc1NziILUN1uKpkblZnJSar6e/8RtrSU376kdfhqLP2pk+z7+AKyLOTzK01oqgQTB3nRZSKQc+bx7Phxox4hHsbB+h0rGO/8dffArrJycLCvg9DtLvMAPnaWD7zu9RR5VxyzSrUidsHxJFuIwIW3/9UrcAY199m++Kv35cm4VUUQdxipkFqoCD9v2emmsJuge+mZxxwGXKKQA1WjAuzqPIn7P2LuDTT/FVeK6rgNSjFmFptGPusA79W9ylAF9coRbo8/TTMrfzgUBw6LUeqDHTO0nCqQlSKeraNEZPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 17:22:24 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:22:24 +0000
Message-ID: <3bba4988-31d3-4b36-b3a1-2307ad3ed4b9@intel.com>
Date: Wed, 29 Apr 2026 10:22:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] KVM: VMX: Macrofy 64-bit GPR swapping in
 __vmx_vcpu_run()
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chao.gao@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
 <20260428050111.39323-2-chang.seok.bae@intel.com>
 <6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com>
 <c87d863b-e053-416f-bae2-6960b4b9d0fb@intel.com>
 <CABgObfbgt35yN+o4w_D5U8A7QKRWxiwEtUuzzK39eScXNa4EfQ@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CABgObfbgt35yN+o4w_D5U8A7QKRWxiwEtUuzzK39eScXNa4EfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To IA1PR11MB7917.namprd11.prod.outlook.com
 (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a3d472-3ae5-4db4-4df2-08dea613e111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: P13oyb9LoBZWJR1A0zl8FKIvse9LOnJ2t4cwt88CRBMUSrn+yKWAomMAP9hsEq/PHb8h5NBtkIb3Mi62GpmOXwqpQpDnaDukjfY1oP83JWF1//09vl7FR7dCGUbhWaA7saNoF2HExrWVC88bvoPM/GukZAs1YvXzt6pazcjeVDJTeMFbA0zQiVqSlZIiI8jMLlEQGHPEn/xOwu19ssji4CTtXUdmUKN0hzWhslGxOI8/bWhoXZ8MGY3M7P3Uxfzk8EvXsvkd1R5cnT0x8VpiI3z0MfhBXj8tK+Jh9a1xzx8eGPrs8JNuVXx2wNVXsPydmy/XdbRUfmx25c0HIQzBdhsRAsbpaX5kqektB8JOu4LQ1msK+MpRWVEDFvH5g/PojudvnfwU18QFwHzuVs5yU82c3IpeV3EA9cvmhevPiaWt8tdEVKkuQc8Ncw0+cc0LwUhjOgXY780fW0PNl44INjw1GxVzoNrwqjraPeM5zZeVBxizEi8gQEvq1NLI7ZjK5ucJ+cjDh9vDEP59AzvL+nPzj/4aRSh0veVEhlX+sJWZ3gOgaaoaSfvfp5ecHHk+TtrS8IJszW5gt59iJSh4BTOxgD4qrupa/kCNlqaOZdkVEWGS0JD7wugwKkKRtN8o6HiKaMnS6H1OryQ+dV1zlKWZOeiYfHVEIU89c78/kvraqYLQfjNmLo7WWIS6XyA4Z7v0o06aGE0No6i5r41y86b2k2cv1Ql9UWMqgIWYrqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0I5K1dYRk5zcWdnVkliT2tISWVxN3I5MlcwelY5ZjJveGVtZGtjUXhyVkhu?=
 =?utf-8?B?Zi9BN3FhWG9Tb3hGVlBLZFpDQVBOenBiRU8xbEF0VmlHTjFOc2ptbmZMTXFa?=
 =?utf-8?B?VVNLak1YL21zUVR5TUZLZ1E4ajNPQzRRRTVvSXNrUmxkNU1JTzBkNGdBSTBp?=
 =?utf-8?B?ZEpWNWxFcVNkYldtOENoMmJGcE1SM1JTa25PcnpyOXFMTVdYdU5IUG1Dbldk?=
 =?utf-8?B?RzIyZjBzcklWai92RWRvU2hHSTIwVUxSWTRtRXpKVnVpTEZQWE90N1cxN2lS?=
 =?utf-8?B?dmcwM2F2VjQ1bFJ1VUswMndJWTI1dlVWeHNiaythYWtNRXJheCsxckdhZU51?=
 =?utf-8?B?L1VLRUIrdGxhbzVGS0JDWEROUHpXS2l3STdWeVlZd01yOWh0WjBoLzhKOWZU?=
 =?utf-8?B?S1JRS3pMazRhMTQwM0dEWUFBYkMyK0Ezd09oOTZnY2pBVG9zb3lXbFBsR0xZ?=
 =?utf-8?B?Y2QyVFBnM0MxVW5BYXBkYUVCSjdmZGpUR2dvOGQrRHJGQzB1NENZN3RiY1Rm?=
 =?utf-8?B?RGhoWmRpeDBHSU1tK0Y0cFhZZzU1c1pISmJPK2FSaG5JcDducVV1T0RPdHE4?=
 =?utf-8?B?Q3k0TVRiTG1xSDNHMkM0VXhRd1cxRFV0QXBJNTliT2hRZjhicisxR2RGM2N2?=
 =?utf-8?B?ZmZiTjhBYkNaMTJEYm1DMUxoTkJqbWdPT09yM1RvSlpwczV3M25kWDRwV1lU?=
 =?utf-8?B?cndhV3k5SXc1b2hwN0duQ1BjUGt4bnZjNjZleWZqanNBaXRPS1VaZmVkNHNE?=
 =?utf-8?B?S3pqZ0Z4dWNPUzdXMmpETWdyMTRUTmhvVFlpV1hSS29Ka2FlSG4xRVZqR2VW?=
 =?utf-8?B?aDRIcWlZL24vaU94UnJWaGREeFhsN3FhODFYS3RvUjRTT3V0MHlZNVhnQTFX?=
 =?utf-8?B?aERUZVhtMGpxWmtieXk3U2Ntak1YSDNXcEozL29PdXV3N2h4WnBYZXZXRGF2?=
 =?utf-8?B?Tm9mQzIyR0k5QnpmYlp4WTFaeEpmaFBiWDlPdkZndGtrelQ0WjFrWExLVmFv?=
 =?utf-8?B?dnJ4YXdlN08wdGthVDBSNDZOVnZhaXNvYnV6dVE0d0NyN1pBL2gvMGFUTnJz?=
 =?utf-8?B?NzBtMHFuTlh5VEkwR29Jb2o1amJPOGJFTEJEU3pobmJSbklEQ1pkYks0dHhT?=
 =?utf-8?B?VFN6cjkwMGZad1lwdStRZ3M4enRpdmhwWmk1S3ZDdmgzWllkRDdYeDh3YUpH?=
 =?utf-8?B?N1JaejBGdnl0QmtpOEJWRDNqaWlMUXdRbDJpVnl2SC9JU2cxMGZXbVY3ZzI5?=
 =?utf-8?B?SVJVQURqK05jelUrdVlBR3MycUlLNUs5QkFBNzZ6bnh6eWlhUkVQUWxualFy?=
 =?utf-8?B?KzQ4dDlMazdqUnIzbGsyM1UwYUd6UHV1Z0Flc1B1bmVTRmV0NFdPdGdlVkN6?=
 =?utf-8?B?KytHVmRwVVhVQkJYcXNLV3ZpTnNRY3piczRhK0VocHd4RHFUS0pjQnFPTEhW?=
 =?utf-8?B?aW9IM1Z3VjVXWU90VHpqaHdzRWdGeGY3d1VGNXk4ekNjWlROM0Q0OEw1UWt0?=
 =?utf-8?B?VEFBc3o1Y0V1L2xSTHlsVDFFZkx4YUxQVnNCY0FSTzVRd25BWEJ5TDBvbitM?=
 =?utf-8?B?ci9NT01EaWdkMlo4MXVNQlFSaVFOUDdYVjZFTi80WGpNZjJ6RHEyKzhHN0Yv?=
 =?utf-8?B?U3k3MWJJRUhkWTR3V2xBT1l2V2hORzlKSVFTeGtzWTNUdWZhbHBrUXpodTcv?=
 =?utf-8?B?YXhXYVBWWUtqcFdaOE51QUpXK2J2Nk1TK0hjQnhHWnBTRm1sbk9KOFlOQ0oz?=
 =?utf-8?B?RG80ejBkWTFyelM2Qko4SkkxQW8rckgzdnFGeGFDUCt5VTQzZEx5M1lkelZ5?=
 =?utf-8?B?Q3FJbDdQRkd3M3FvT2pSY0l4WU5nOUM4QnliYWs4eDk3Z1FxOWNXOFlhcUpR?=
 =?utf-8?B?eWZsSzVETlRkYlFxaDJYQ0pHQUpkUlRQQXg5WnpFc0hBNk1BaERYUVhiR2tC?=
 =?utf-8?B?SkdGS2M5U3hrMnJuZndjN01BeHhzMjJPRldtR1p6U1g5TWtBb3dsejhLVmU1?=
 =?utf-8?B?VkgrdEd6cHVWT1N0TzRPZGNhQTVNK01WbDFteFZncjdodEkvWUt2Z1djT2VT?=
 =?utf-8?B?VkxMSUQ1eFg3SnNEU3pxWVZVR09BRHpDVTlMUUFqUVFZSkNiZGNZZk1aR2g1?=
 =?utf-8?B?NFJiL2tQdUNRWmMvaFhiK1dFKzAwQjgvOWozcWlRSlZwdnFIQURRUTdDLzA2?=
 =?utf-8?B?eWV0dXNwY1hheFp6bHk0OEh3ZVBKM1cxcUhubExjeCtNbGZlL05hM0V0eUpr?=
 =?utf-8?B?YWphTGVjL2dzV05DeEJ2b0o5MXVxVUE2djVUdUNRWEVIbUE3dDlXaTZReUIz?=
 =?utf-8?B?eWU5R0psMlRuUndxbVFNTGg0OXlYU2YrdWsrUnBsM0t6dE82NVJSWnVSMFRu?=
 =?utf-8?Q?FZrkArNnz98tQe5o=3D?=
X-Exchange-RoutingPolicyChecked: PoDXT6vJypd44O9RbyH8GMcY61Plqz3/ygGBwqGp2uUyi4hG0gpN/o1VQdQe415mZ5JHmewdhmVlGpoSEa75qT5yg7tymG71QIXTgOGqxAzlSzvfeLRsXoBvS6OiiP1Mw4JpZhG3a2K4Qp8JhW1skiof/TQtO3s+IqdD50A3WWElOzd+2XNBCzkv+e7L7GlageQctlBv1m0zTC00NxamZbmHM0s/SnQQWq9SROftzgwzVozJeIbL9ER/oS+O6KoRPWr0FreAejM1Vwe+fE/KAds93OMeBn0kSh1+w9wLbUbWM48xW9d8KuvtbmKg1fEQZPwP3oKePkZMmLYs5pfwsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a3d472-3ae5-4db4-4df2-08dea613e111
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:22:24.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g14ahvIb6wrrozITPOx1KRK8A5GIMKSAjuuhnk4N6L3/rsMlcHBIY/HyEmcIcxOEvFbaH2R5vDHoBPQ3+2aAxIbJ5uOQ7AMoNDOApuxfp00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com

On 4/29/2026 12:50 AM, Paolo Bonzini wrote:
> On Tue, Apr 28, 2026 at 10:12 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>> On 4/28/2026 2:03 AM, Paolo Bonzini wrote:
>>> I would also consider using inst.h's name-to-index conversion:
>>>
>>> .macro LOAD_GPRS src:req, regs_ofs:req, regs:vararg
>>> .irp reg, \regs
>>> #ifdef CONFIG_X86_64
>>>       R64_NUM reg_num \reg
>>> #else
>>>       R32_NUM reg_num \reg
>>> #endif
>>>       .if \reg_num <> REG_NUM_INVALID
>>>       mov (\regs_ofs + \reg_num * WORD_SIZE)(%_ASM_DI), \reg
>>>       .else
>>>       .err invalid register \reg
>>>       .endif
>>> .endr
>>> .endm
>> Yup! Also, looks like still needs the REG_TYPE macro:
> 
> I don't think so, you can (and should) assume that \reg has WORD_SIZE
> size (i.e. disallow %eax if CONFIG_X86_64 is set).  Only CLEAR_REGS
> uses smaller registers but it does not need the reg_num.
Okay, I think I didn't close look at the error. Simply "\reg_num" to 
"reg_num" builds fine. Yes, REG_TYPE can go away.

Thanks,
Chang
