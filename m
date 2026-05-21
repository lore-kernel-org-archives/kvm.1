Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79223D291
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328682; cv=fail; b=B/cuzi+Z4J4dBmtvFQueZd5Qd7vj7DPVBSNhX3TdGP2eYWSfPKoRtaZ9E8x4a4KE7oyx6LZHPb7wF+fM6dXslgPdPDs1UJRKnqMZ7MhCAa4he/UyLldDk+uzrtTizgeMjO78FVSb/N7bVyFRKjrxDDKl9p4k7ssKBXaM+NqLCzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328682; c=relaxed/simple;
	bh=G1fr7yil8M+WFSSH4ozNlrJ2LbnIWgDoOl2ac7MGuu8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knP8RaKEZRBCnSlXe1b7zdri/M9+oNuxgGdypHdUoa68CpM1tmWVQnfDW9c4kZzux6Rab9Qj73ZF0G1ZjmJRnpRU2r9Ky9T47bPblekH4W6Ezpd3mNvZ7pl45Syd71vs1+mCR61IDIzCXIt51CUAFt+xxE/IJaLUG023t9/q7KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDvVlhvp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDvVlhvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779328681; x=1810864681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G1fr7yil8M+WFSSH4ozNlrJ2LbnIWgDoOl2ac7MGuu8=;
  b=GDvVlhvp8gZg70G8SO4Eik/7YD2fDmn5EOx8Pi5rL52CpbGWlKcuTSJH
   FpRbY860gRfMDpEDmV6Tw36UZSTx/urEq5JllKdPtEnpO1F6FPTYZgmrL
   b3u8FhkjM06GKqNrW4xp3hWDt37Omo/GFHz9et9bJTKx4jFB0x4fOrgIx
   HyNpM+NbrYGio/P6ovDk+YzSL16jeYAgthONf4R+B+WewPqiVnXYRmW90
   EATlW3n+k4jGf28gcy10pCScYLBZ1iFsjizDdXvZrp+9KBOEY5IjyulBR
   pxUppbIv1TVSGxMk/VEJqSiDlHSBRzcfovd0JuD7W7+/p/HuhHNpgzxgd
   g==;
X-CSE-ConnectionGUID: zDHLmm04R5KlxObTIskYvQ==
X-CSE-MsgGUID: UW6bcee4QwuqSH9iOsEORA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79266807"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="79266807"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 18:58:00 -0700
X-CSE-ConnectionGUID: fw+RWa7xSPmOlgJAcYF7ig==
X-CSE-MsgGUID: MuDlPXXwS5207sl8scK2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="239373693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 18:58:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 18:57:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 18:57:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 18:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNLW05LEJDbT19zXRx1mnFPt1FAtCmYM1vp+7xjKSi3fVouANGAHH1MXr5RSBz3W0Nv0hSR0xy0FaLrI8TzLU46kypjzZyAiEMH4Hb5okzeRIv4HaQauBAR2Roh5sEwR9lx0jFknaSqvVzjpqzUtZKmt4vodgagQmsMUI36HmBwMU829yoSrsel0Bz0ANxd8MoChAPLwWKhcTl4lfqtn8LYM+XZl/XsiM/YrsrheHGZrCH7kX4Xwo7z3SC8Q6n/2zs4P0oiGiTcy0Jv+RKCDlanhevtWHMftPMsnllY45wnUgnBrgRFnI0W0AhHIZIkaz/mzVDoUCunLqY3V+oSK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILXfQHuwmpuoLbjVW4ozCf7vK9D4GahC9Lmg+1nXckU=;
 b=KZcgoYC/kgMlgMhCOPFo0RB4SQNCTtb+6K9YSVVl+NHXhIRD05Io8GCMUWqqZj9XqU36UIkkk/1JHH8QJJm+ePANizH0YFX8P8iS0aPh31fv8Ha41vJxoGhr+skjRFfW5y9FSbS6mlJsgojXc6FX8++vpIdSa4U8gYCwOAr8MZyfdj4FSJyQDH0zx98SdskXs+io2ebLicj2dnaNmfJiUmE31mfBl+s1TZS7k/g7Ft3r1u4kRufekbfHw53kYWCCu6O47A1TLkizfUteFSXOYLErADnlSGQ39uL4+eGg2rkOA5sDP/z5ZbXDOUY4QcIhP1XKrXFB/PONyp+D9bc01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Thu, 21 May 2026 01:57:56 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 01:57:56 +0000
Message-ID: <0b9be606-dfc1-432f-8291-e1b4dcbf413e@intel.com>
Date: Thu, 21 May 2026 09:57:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 2/2] nVMX: Test IA32_DEBUGCTLMSR behavior
 on set and cleared save/load debug controls
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>
References: <20250811063035.12626-1-chenyi.qiang@intel.com>
 <20250811063035.12626-3-chenyi.qiang@intel.com>
 <9f1ba406-7638-44e5-bf0d-8aa27be24a59@intel.com>
 <ag3U77kKME3LM6at@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <ag3U77kKME3LM6at@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 513a2832-62a0-4851-6bba-08deb6dc6042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: GFreB/BTDcMZx2iaR8p1eXbx+0uYlHDqlAprj9dNPVsBzh4hGjMTb/je2PhtM22/vWPNu5DNy+/AjLVZK8q1A0AmPeV2sT8Fi9hL6wPu/eGLcfaSTj4emj9d8eHv+NeZppUIzrnpF1gZgG9tVQ0hwDb23Mwt+6NIBdmgyqH6wNlmuVbjv2UUgmef1pIwUUPT9u33ciChw/MKQFG5srXrpmJIHQ4cP3JDeQTnQz62Iip5hY5VB14snHau+hqBUdSG7ubR1AQwbchy810wEMjrqzmZhgNwHYP5ct7Gk3I8QwsgQ3D1mo10b72h1adsFQIh9NwHx9NrS7X6LVpEWxG7PcMbeWJFOBPRedXxFEWmeV1PoOgcAuod97o2QAwH6K8W6ceUBW9770MxO7PUgO6bztEX/bLnxJandETq1QwaLmPXzxPC61rJwsSVVQfb9QNUfE7RWQL0ASzPrejLnVT4tjYD6bzbvVFDo4TXFmub0URm5hizvNLntLfWoH6knYqkFMOMRQUamjvTTOqPGJ5QpbZ1hktKfGmJ1iewCaxkg/1Tj2IwqHbMJHf/P7wjQLiVQzqGG/OmjWs/WjlGLm5YdfGD1R/EwIB58BOzp60ebMM0WQQlsG3u8lNex2zfx+ETulXKQLR4o8EI/yj+JOtuqYqj4HrSSBhdoAm4OC0aGQosXoo0/HhvchAYN5GdFQhU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitHeWJVaE9TK0JZUmIwTGxGaWg3MWpQSWd4R1hiUjRzTDRIdyttTzF6OXZ6?=
 =?utf-8?B?dGx3TTAyRzBINU5DM0pzOFBpeGJzbnZqQXJocFVRS0IxTTV5TXMxeGc2RWtS?=
 =?utf-8?B?dmhUR1JmdktabUc3b3ZKY1FNL0ZmNER5ck5CdUN1MGpYV0xpL0hkVE82VjYy?=
 =?utf-8?B?dE51dVpnYWFZaVIyT1VlZzJyamw2VmN0bnJkUVV2TkF4WUlGcHpxK0QzYkx2?=
 =?utf-8?B?QzJGem8yckJIeE9wZjJqUTZaMkg3d1RCS09aYVpuNnRxdU4zRkdBanhRYjdo?=
 =?utf-8?B?djBiejFnZjlHQVpHRk12TlBNNTFhbndZcyt5UG91V2pNUWxvOVlYSFltdldt?=
 =?utf-8?B?YnpUSTk0bnJMNG5zbDFFUy9DbXU1WmpDTC90dTNncFZrWGJlU0IzWDFSeXdP?=
 =?utf-8?B?Q1BwdnB5ZUZCUnZsMmZuaHdkcmZqQk9IREgzYk1jVEJrMUROSnhaWXVnK3JH?=
 =?utf-8?B?bk1PUjF0aE1FeUo3ajRiczhHRWZpeENWWXh3T2xsalBteThHWjVGbUhnWWVY?=
 =?utf-8?B?TGppYmUwS0ZGZE96UVVnSE9KQkM0aEpoUkcxRk9MbTNRMTk0WDM0TWZLNHJr?=
 =?utf-8?B?ZG1EWVNha1Eyb213bmoxdG4zUzl6OXZGS0Vob1lVUFZhQWlDWklXeU9LNkxm?=
 =?utf-8?B?SzZrVkVrZ0EzS29telJNUUZ5SmRMSzYzTzlxOUpFb05VVU9oYmFlSFQ4SGN5?=
 =?utf-8?B?NlVrbURCZTU0ekppeGhGSlhrenBTaHBKN3Q0K1JqenZ4d2htYTRkRm15ZDgw?=
 =?utf-8?B?MDFydzlUSHJUaTJDQnp1RkRQQzZ5N3F3dVlEaStjaDNvM1ZsZFBzQ0dOemkw?=
 =?utf-8?B?ZGtML1BHRTZYd2NIemlkRTF0bWswRHdhNHZia3ZNOXl1L2Rlc1BqMFI3ZjRS?=
 =?utf-8?B?aXJkUUZxaDByZy85RGl6ckQ1dGRWTDg3MCtIeDRGQU1jUzVYS2pxeG0wSmg2?=
 =?utf-8?B?WmFTNTlMeThsUlAxdkFXSmNmZDhPZHpPYTZ6U3k2eG9BelExVTd4a1FoaVJm?=
 =?utf-8?B?Y2FqSzUxYTVSdUpPS3ZPNmVCMCtIaXRjcnJkRW9pT0NLSnNqWGRxdWFQLzdY?=
 =?utf-8?B?Unh5a1JlL1NqaTFlMHhHYm0rdjZXVkt1N3A2RHlRTmhwaWdpaUxwTGJJd3kw?=
 =?utf-8?B?d1hheWxrN3JDbDZuNGFmYmp6L21jR0hXSWFqS0pxbzVaVnhYaWtnMnRCTWlF?=
 =?utf-8?B?UlYzcnFJaHVLb0xEQXpWaEdEUjV6MDBnN0VQeXl5bW0rd0g3VVRSRzhEblIx?=
 =?utf-8?B?cjZrZUE4RTB4K1Nzci9TM1hpbkVTLzQwaHNZU0dhMnhRUkdOakM1eEZlajJu?=
 =?utf-8?B?STExYkJHNk9iV1ZyTm1jQXAwNzVmT3RuUktsaHlOZy9SOFE5Z0hOTHFIbS9H?=
 =?utf-8?B?bXBBVGFJUUhURWpKaFlvNTVxTGM1c2x0NkxJamVBQlBiemU2VGRWVnVEYksr?=
 =?utf-8?B?UlVnSnVTcjlJYmNTTmxpaU9aN0FuTnNsUW9JWkJPaFFCc2I0dTBNd2o3ZDJI?=
 =?utf-8?B?ZU9CdW5oN0hUZUk3OVpCdjgrU3N5bW1PQktWc1V0UVNYck53VE1tSTl6S2pJ?=
 =?utf-8?B?akdBekYxU3RtOWVzNmJROFRJSmdwK1htYTJqRStMYmdQa21BMGNRNWIxNDBy?=
 =?utf-8?B?c1pVRmk0K3dURTVFOVZqdU1lK3dCOFdSQzl5bFdReU5HQWE4aGwxaElQY21X?=
 =?utf-8?B?WVMwWXo1OUxQaU5JVko0b2J5eDlVa2p3Q2xDWmFMdXMxbzFKSEh4elRsa3FK?=
 =?utf-8?B?VkZyMlk3WFJRNWFkNUV3YlcySEYvNzA0UTFqdStGOWpnT1hlNnFxT05WVkR4?=
 =?utf-8?B?UjVsS2l5bENYYzdaQlh1QnY4Y2ljMnZFMEp1Y1p4T3lPWWRsS3JmNFpKNFRv?=
 =?utf-8?B?SzVqRWNab2diS2tzeUhSRmxidFZtUkc3d2crdndEWjBMT2UvZys0NnVvSWgx?=
 =?utf-8?B?eWtkMTQzb2U4L1pOVjUvS3UxVC80czVpMG4yRUhmS3hTc1NMUmgyS1FWWSs3?=
 =?utf-8?B?bWhLTFdKNGNxZEZxNHIyWE16M2dTQUZSbHFQdVFibmt6WHlIS2VnSzZJYklE?=
 =?utf-8?B?WVJoRlo4OXZDYWFJVW5XVVRScU80THRHZjI3RWkwbnl4SENVTDBZNGdLRWM4?=
 =?utf-8?B?dmdkN1pzQ1ZwU3pzM1FTTlBEUUpSYVBtUjZSdDFuMUNRSWVaa2lZUElTcGh5?=
 =?utf-8?B?NFhjdlZBeVNWMlR6RUR1UVg5VytpM2c3ZnJWTG4wYjRESnllZnNLK3lITmc0?=
 =?utf-8?B?ZURvY3IwMFpiMGJCeDJMZHM0ajI5cmtqYXU0cWtkSmtJSjk3ZTI4YW5rckt0?=
 =?utf-8?B?VmZxaldPZFJlcGNTYVExeUJNTlM0Wk9nelVqMDdEYTA3Z05qWC9xdz09?=
X-Exchange-RoutingPolicyChecked: RDR50efrBQfqkmd1hEZ5TB8PJOHKelaSOcPFXvT203+TCSqQ/68G0/cVBu4OancYfm5xAMxuPuuQrl2wV8ftU4U77jgF8JkcTbwhrOIcY+4WiNd/GDMp9SD0vzxmQIroexHiRauEsCd681u3Ufddse8wa+DteqzSX/wDH8z7O9ccwjqIBFVqbd9GB/876geHEQ59r+RUyKQ0kvjDIF79zo/Utl9JKzgqgCWWUSww6XLBmG3VDdrufnoUevVhh6NtDkw+fwO3d5geuAmgk9Fcvt2o1MKxTzsvv1h9sdGdB9YSsgil0/3BlEr4FZY2/2PUIbByH5WA1lnlZKaBH38zxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 513a2832-62a0-4851-6bba-08deb6dc6042
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 01:57:56.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwGQOooIBBBMIlWtkIyc9ffY0yrDUdzMUYLOIzDJKHy3lJV2usU3L69qEIA9nw9F+SNzVgV+kK8xGMrEuiy/Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com



On 5/20/2026 11:36 PM, Sean Christopherson wrote:
> On Mon, Aug 11, 2025, Xiaoyao Li wrote:
>> On 8/11/2025 2:30 PM, Chenyi Qiang wrote:
>>> Besides the existing DR7 test on debug controls, introduce a similar
>>> separate test for IA32_DEBUGCTLMSR.
>>>
>>> Previously, the IA32_DEBUGCTLMSR was combined with the DR7 test. However,
>>> it attempted to access the LBR and BTF bits in the MSR which can be
>>> invalid. Although KVM will exempt these two bits from validity check,
>>> they will be cleared and resulted in the unexpected MSR value.
>>
>> Initially, LBR (bit 0) and BTF(bit 1) have been allowed to write by the
>> guest but the value are dropped, as the workaround to not break some OS that
>> writes to the MSR unconditionally.
>>
>> BTF never gets supported by KVM. While LBR gained support but it depends on
>> PMU and LBR being exposed to the guest, which requires additional parameters
>> to the test configuration.
>>
>> On the other hand, DEBUGCTLMSR_BUS_LOCK_DETECT chosen by this patch doesn't
>> require additional parameter, but it requires the hardware support of the
>> feature. IIRC, it needs to be SPR and later. So it has less coverage of
>> hardwares than LBR.
>>
>> I'm not sure the preference of Sean/Paolo. Let's see what they would say.
> 
> I would say add dedicated tests (for BUS_LOCK_DETECT and LBR), and get any coverage
> for KVM's handling of DEBUGCTL reads and writes as a side effect.

Thanks Sean for your comments. I will pick up this series and post a new version.
