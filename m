Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002914;
	b=UipdTD+a0KxMq/GbAEQmqsiPc+BIUsj91mggCk4beN6fzY5kqU38FQ/mJjRmW+ATw/P6
	 rNC8QSYvMvafIKN4GuSMUWJZF9UPBXAw6AnMdXVuWGEQLVI1+OcgEf6D7RS+n8HT/YCZm
	 zmlY2wDn67O8Gs68sq1KU8VH+8Z60BrPB17qUzYkV51sJxXUobnCRy0If79W/G/EmBqkT
	 WcOeftsADY8Q35pUr9YBYnIeE5HAZQzLfVL06lOAzk0Ve4vIqH5tXawSYJCKUL3+is0qA
	 V9k4BV5PHua2DwLjp6XF3ng4Kp47kx94CggrVVSzMIpTnbJhD6Ax+7f8yTV+qndzvkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002914;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BghQRm0LUziY9VWfO4FQpv9HrKe1htAOr6S9Ml4SiPI=;
	b=vTXRN8bXhVxKWWzVqMnahOnh2V6DDjAV1juJIzVKwCpax6qSfzUdQE+fdWJ+vAkvilVO
	 e/SEG54LHkbTCaFJBxVK9ac3FlzE8DBtzeb7o4VU8T43ghKCqbtKAf9VVxy0LBFbfYlry
	 We+lu8cVXGKQRlyctVbLHAawm5+X1FwV6lkMUDgf/rDUPxo3Ji5Z+ffJ8KnWfsZTKeV7W
	 xaCqz/a8GKAdRHZOxTRgeQV9Kv3CbWovZPFuN14N2ve8qGpiwe7dI5XQq5RA1OKdHDmUW
	 7qND25ogAY01YtQHEeLbO8VlcmcIhOq7sfmFfkMsHNLY/6AhRMbN5TSX8QdC1P0Mm+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2BwZcLeG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF4606A320;
	Wed, 18 Nov 2026 11:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CFF4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2BwZcLeG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcyHO1v+oemabt77L0v9XlsAFE37KdW0HXjfqqYg8cjRnCp/Tb2MliUErDiZZDciSAwq+w1slyFLLriD9Grvx0GfTcYGM0EMjL67DQhN4c5Xdr48/TZ/o538XQKoje0iZo7rKwXK4VvtPiI4tvwUJybTvxNwFpHntpPlBmVJ9G5rUQwbiB1/BkGmUDV1KkasnIBoEUNWbOSnYz6llkKy7YdXaejIbcZ7BXh62A1ROmDtjv2sPIR6P3Ukp9nHp+4ebNOTV+td8S7fETb2d5fUk3jSDmmZwj+dSPUMoE1NH7dZy63+Dz2DADPRUR8pdG2lu5AhYbdu7gihiU2iUfIq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BghQRm0LUziY9VWfO4FQpv9HrKe1htAOr6S9Ml4SiPI=;
 b=mDh+QFA8D6hmjkAKdTHPHhBHP4gU1PezmOxVhCMWDlH/awhPKq4J1FqGwXTjK8XApt/UUqC50WeCYzi8D/7dE2bqOvzVPNhqF/OdhF+o7yxHzgxhwGdsVIy5oLOMyOo5qsN3Mm+hwPuD9+a//Ias46SfXJ7aYOoVlSD7bk6gsL7wggSBY2VGVdTnWtwGJeWqorOaQCqNG5aTA7J6Cp6atITKwNQJB8zdSD7RB+ohKm7sU3k4zanzxZNydwJDZEFo6CJAhkiICm39U9DdP1BXLbsB7Nr58UFDQtCssqmUXVqUvOZGtHj2naoNgjydBzsfs0Bq2AtKY5IMeqtd66OZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BghQRm0LUziY9VWfO4FQpv9HrKe1htAOr6S9Ml4SiPI=;
 b=2BwZcLeGyi/i4b4t5OWyWS/aohmD8yEH6GvlQqcS50+4dKr5Qnt/6EGlCUvtLuatP+Tg3XjXyuAaj8dWbXFpekyMASBdCVZCVcKv/jlTo8DUjnGHzC8uRcBpKhE5nHzCmLbEXfPImMeb92zlbbK/ygAMKLMsOoA13KW4CnrhAow=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 11:55:10 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:55:10 +0000
Message-ID: <789e0295-487a-4a47-aa9f-cae0499d3a95@amd.com>
Date: Wed, 18 Nov 2026 12:55:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
References: <20261117011513.39419-1-seanjc@google.com>
 <20261117011513.39419-3-seanjc@google.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20261117011513.39419-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0b99ee-2d67-4270-865e-08df456acc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	o8Xj6t3NtdNo72jZBzr+cFNghFN7pylJ30J4D6ex1rIipmuRLmodk1555ucswcJEmj0EzrbqlTRMZJUPoKaetxDGgXBWJjQduBQAH3edn2lB0E39h0Y6hRGxuVQ90D8dndj++c0ViJQAHgttxVGdH4SGqB9rs9QPwotjEkb7thHs2DAaJlUuOdtS0ZTDmpNLKFD9yY60hIGzkc9zpOOyeyqClHceawyHvUesZLZ9hAXMoJVvkRXOxHeTMNFJx/YoLLPFdHY9DbFICkdC3i/A81Jj1T1bszcUql+jcFIvU/+AxjmICyNY1A9yOUrRMzzK+NThG59Ao70XeTlLtp0Bcz3d9HmHV3gLsMEWEF/Ub3PklgxdEvJDyZ+QGuX1rWePP3gICweljcVDIYe2ZgSkp7UiLcDfbq0TjldC2wQ43cbvLUZvo26bLvQL0vTsWxtGBsulh1TuoxN74YM07INnfVw4e96K6bNwZ6tFfMcUFBRq49jjvUM/cu6xXEMrI3Z6pgLIXP5ETc8yDWgJ0q2KYSr8CbjNsFCOkkA7h2wfjqGBsxBNReuNWubjCWJWujLT7q2OvNvcxp+vm+ItpzpnnZjBj0EDXY1C7QWMRyHuX3PTeLD+xau6wjLvYPWy7kfB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0wvaGtCK1hXWVptVmdmYXMyVHQ3NTBieGtTSSt0WUhUSHlUY045S2ttQkh0?=
 =?utf-8?B?aTZUdWQyN3czakdXRFlVUU93WlQzUFV4amNTMlcwZml1ZGcrTTk1Q3Zaak1J?=
 =?utf-8?B?L1B5WEk2MjUvNXE1Y3NVQ2pyS1grRmZVMG9mdnBWbGhCa29zeitValFHNFUy?=
 =?utf-8?B?cCtoMlNYU0t0RHdpM01UTzRMSDhnSDFEbXlsdm02L2poM1Z3NDE2N0FFeTQz?=
 =?utf-8?B?L2RsVnVNYzFEL0dPOVFRVFovTW5LQ3NOT05aZ1VMRWdtaEVCektVZTZ5OFQr?=
 =?utf-8?B?M0dwVDBUeGpJSHVCME9YMGlvd0g3UGFPTmZvWk9zWHNSbGx5bjFXdGdscjVC?=
 =?utf-8?B?ZVFuODRpRGh0SEE4bjFWY2Z2QnRtbWZFcEhwR2RTU1I3YnM2VkkvMVV2VWFC?=
 =?utf-8?B?L3Y5WjhZaWRBb0o4cndnOTRnK0tCL1AyMG8wdTFFM3ZxMnpDb3dzKzVMS0Zo?=
 =?utf-8?B?ZDBRQ2RDODdyTEMvYlU2VVM2cEU4WVhWWHNJM29OS1NQNGJHNEhsVkZBWTAv?=
 =?utf-8?B?TkFlTkVkSk1XaGRHNVJYN0FSeVdEcVc4dHJyREpmTENzdlF6WEhVSnE4OHcz?=
 =?utf-8?B?TVZIb3IxWkJDV1gxMm9IWHFTb0JkODZaWjh1dDhZWkVkY1BXNDA4OEExUDJk?=
 =?utf-8?B?bkovL0hmSllzSmhHTlN4bjR6YVNDWmh6Qld0aVBGdDM4a0dMeHdXdWlPci9Q?=
 =?utf-8?B?ZzJHbSs3YUVQek5KVnpNd2lSTGNaREhLektodW5hbEpPMTUySG5Gc0pFY3Q0?=
 =?utf-8?B?b1dtNmZKRWFsbitrV3ZaUzh4WVJDQzJlNmxleTFUNXcxbjlxdG5QQkprYlBx?=
 =?utf-8?B?NkVtWFcwMTk1WUo3MWtScy9wQkZrbWlJek1TMklZSXIvNzdwY1FEeDgvbGVL?=
 =?utf-8?B?Z0RpK3pPU0ZyVUhQQldwc05WY1BreFg2dk5WcytDdFBvREF0ZkNLL0xlcXo1?=
 =?utf-8?B?a1lXaGVCRkdRY000QmtsZENkcmdTRlV6YWdQckxsZ3VYcmlyOE1mSnRGbjNY?=
 =?utf-8?B?VWVxb2YxSkhjZjc2bUhUVGxmNVV3d3VrS01EMjdxY1IxUjRtN3RTOEh3ejJG?=
 =?utf-8?B?dC9NemdENUoySUFmZ2VsSkhUZW16Sno3Rjc3TytYSkNtZlh3NGl2eFVmZ0VG?=
 =?utf-8?B?YWtuaFJxNDR6WWVZZ0tLUGMwYi90ajdneElMajNOeXF5dERZSllRWGF6SjAr?=
 =?utf-8?B?K2dReUIrTjZKL2VXSmxvSU1DMSt2cGdVTnFyRjhqTlN2ditoNlBXRW15bU1q?=
 =?utf-8?B?bjhMa1lsL0Y5Zk4rbVhKNGxqTEVxTUV6UU5LZWQzaE1UcUlhbGNjMWpmdDFP?=
 =?utf-8?B?TlR1R290ZklNL3p4ekhyL1kyU210eENJV1REQ2NRUUVJdXh4TnZtMmZlNXdr?=
 =?utf-8?B?ZEhucklTTUJGb2hhVnYrSHdlRGRzdEdISWh6TDJUV1RCRHVNSVVoZ3A1aHdk?=
 =?utf-8?B?MEVVbUtCL29EZGo3dFprYkx2cGFTQjduZUUzQXdnV3RnRnorMjJaRnRxQVBk?=
 =?utf-8?B?ZzY0c0VSY01MYnU3eDh5NlZlMCtDaGhnRHdmQWRSdmhGMjFVRitKbTNTU1Y1?=
 =?utf-8?B?MVpaMWhDMFV0cStVWjBwT3QzK2xBTVo0RXJpWmxrRUFIb3dsQ2dicnlhcy9y?=
 =?utf-8?B?bHdxSCtqS2crckhvK1RTSUxpZVhIbFJFajZKWWxETXdQNnJUMGJDVUVJN1RJ?=
 =?utf-8?B?bWlxcU90WEE1cGg5UnUvc250ZTVZd1pxbkt0UlhBZDNLMEhSbWpSUSsvWVFD?=
 =?utf-8?B?Vmh3NlROcUhSWEhUbWJ2VWdyYS9hVlNZQmhVOTdMUTRObEhGUW1GRjhmdUVC?=
 =?utf-8?B?NHAvbHNKYmZ4enNrK0dWRk5NbmYyakZGaEZRd1FHL3gyWVQxVmFpbTQ4VVlt?=
 =?utf-8?B?ZkhZMmFHd2Q2Ty9YeitObFI4SHJWVFZOUGxLWnJRS3J6UFZmcU1FZmxucjF0?=
 =?utf-8?B?dXN4SGlCQVlOZW9zbTA2YUpIb3VyVVErU2t2Mm0yYzhlTVZIdkhqMFNmMnBS?=
 =?utf-8?B?TFNrQzJSbEx5Q2Q0M3R2OWxVOTFDR2tVWEQ4QWF3RldvQzNpRnZwWUdPWXJ1?=
 =?utf-8?B?dTNrUFpRaXJWT0FaKzMySDhGWXpGREhMN2hFdWJqemZsMzc4WWlDbSttQUpa?=
 =?utf-8?B?c3N0RTlzR2h4L1d2MGpUWjloNFpuQUZSeUJhVnc4ZE5hVlhFY0hDOGprdGRJ?=
 =?utf-8?B?ZjdMSElzVWo2amdhWUV0Qkk3U3J3OEJjTTFRTDhMT0VjZmZuZlFyVmE4STdW?=
 =?utf-8?B?ZlNkMlJWK1hseXBuOEI1cTI0NngranVlVERiWlJRRWJtR21DR1BxSGtlTktL?=
 =?utf-8?Q?xR3dj5krITniKEwZlH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0b99ee-2d67-4270-865e-08df456acc11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:55:10.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gBM3rbarE0ncy80XEAQ6CWaY380aMIkHx3qfIR85fCYA3Tz9vnvWJDYBUhPm3G5AE7JwkHrpE4uQKsU7G1reQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620


> From: Alexandru Elisei <alexandru.elisei@arm.com>
>
> Don't invalidate gmem-only memslots when responding to MMU notifier
> invalidations, as the entire point of gmem-only memslots is so that KVM
> doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> page faults are resolved by going straight to guest_memfd, using the gfn
> and the associated memslot's gmem.file.  I.e. whether or not userspace
> happens to have valid mappings to the same gmem instance is irrelevant,
> as are any invalidations for those mappings.
>
> Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> detect and handle relevant MMU notifier invalidations even if there is *no*
> memslot whatsoever.
>
> In addition to the obvious performance benefits, avoiding unnecessary and
> spurious SPTE zaps and TLB flushes will allow KVM to support features like
> ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> both of which rely on the pages *never* being unmapped from the stage-2
> page tables.
>
> Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [sean: rewrite changelog to capture the new gpc behavior]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   virt/kvm/kvm_main.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9938b753948c..f0d95e8c37f4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>   			unsigned long hva_start, hva_end;
>   
>   			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;
> +
>   			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
>   			hva_end = min_t(unsigned long, range->end,
>   					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
