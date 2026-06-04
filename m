Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EB47D928
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579169; cv=fail; b=d5TOV7F9DXz5eY6GwWW5hpfQH9atFm+wtSqmRRyJRQ2EKl1KEhNHJB8O9DrU3N1Agbl1HGhGrio0mpE5TPY2dm5+hZeiHzk7J0FmGvP28blXB+ke6qFBWJ1ZvuT89FsXBfdBrpKV47KBZEbqZ/XKRGx6TDPoP3aTmQOh3s/3m80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579169; c=relaxed/simple;
	bh=fVmPVTJv1+ABHz2ckFLLTP2tZ9DFQniKmZgxstRcleU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5DiLRyR2n/XkcGfs3fOXpbcVWj/5xHyelrKeKaQkOKCQWy5GQuktkRWGk5rSJSK2n6GjmQvJ16Bl/GI9jIvmyLPSmLC2qs1eWkKnsh6MEwN0dyb5yZ8tHHE9ENYPlFZB2M5FhXMB9LODms7Lp++HNvE7BBNsrD/vRmHhasYkhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k66IklEZ; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k66IklEZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWDRDyS+l5dhCX/aXIgAsOahLKkqvLoQ/SO7DvvafdsZ8M4mLeyVFMB/D1k4Xm3enG4vB3KeYrsmZpJBrc0l3LI06ojLeP5Smd2V5Xb3MUobjTGhikAPGOjIJfSsxrM1gY7+VdRVd2y2mNK72pPdxEpwZd00Yp40Ch3hPs4pCDzld/fInpfPBK/5phB6DXRhCLRku8QsOc8X6ye2hUjxkNDwzIRtotbyuJtx+D6Xcppig9cuHTitAXaZ9EzDNyTjM7PlCkySnfxpQtoxSS3uaT72Kb83B88fTYVmwz4a+/1UO2gLXomdnvdJkBYDI01izhDV18iJDjsy0iST6giU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VwY7ZkiilEqpvhfWYOFRq6u/6q4FLYvk5sw7kD+O1E=;
 b=nQqosnKTwu8ZUKq8WR13RODVwXxHds4cZpKXoEOtITL2H8lF2T7wvRdEekc9tR1N33k2vtBcJyCjTj+9OgWPedM7ZDY65YtJUlZZh8od7NeuuemdvTINcvhePWYKMj4fXiHNkh3UF7Xuy23S5aJLYx/ekUx7B0R+Ezh+r5kaRCWDD6OoQb+vvTgjk+49wSs0mPqI9xUgmxhf2vljWL4AmJkTby3/j4UI0S8Zv/MEBGpZBUUTUFbq3uniRxJiZY8/9G+WanCB/Q0sdv+fzPgqNvZqGjpwPG8IgHrQd4ctWavpl/6yNAp0JZVycGrfCVBUCNCq2LBXmg3EwYySIRj5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VwY7ZkiilEqpvhfWYOFRq6u/6q4FLYvk5sw7kD+O1E=;
 b=k66IklEZcFmQaz22xHUqzmKyPsUNQp8cMrUEqS9RZIMT+jyJc/ffWBeADnwOu/hoVy57H8ZViQjSvevWCQHLZbt5Gt06DwXQpQyf6iNfOyqZcNcJ6qeYfTw8lXpGWIGcwDYfvjcs9ips5g5YYLVkMS5lXcHan1WqTKJ1b6ulba4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 13:19:22 +0000
Received: from CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6]) by CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 13:19:22 +0000
Message-ID: <22bda2bc-97ba-4b08-ac75-a8807293441f@amd.com>
Date: Thu, 4 Jun 2026 15:19:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/12] accel/kvm: Support shared/private conversions
 via guest_memfd ioctls
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
 ackerleytng@google.com
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-10-michael.roth@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20260528000416.8161-10-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::20) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7433:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: fca69368-f754-4ecb-e802-08dec23be456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YN+B39LlKJnxx6zQcqzZKxbBbYfh1Dfk5LIzYgIIuk+GKX4vAVh1NYIphRZsuJWu+rER/8wvcta/0dHmiyeqPYMVFlb+cOZ3gJQfqRtynElJkPcdLTi5O3AIT6bqcpXr8WKt1jgAvDpjg4V8tFwRjbYnY9i6jO0+lExN2GP6cUqfcAViwxBmM7e4hKpFiT/ffqNpjRAaJQ1iNm3vzDBlKsqHZDR3j5shpq2DOGi16A7ZOWAcgbYVEumokx7QNxFCLexGueicLY4i3sDgoI32zEN4tH97eXS/lxRsTqEJP5jrhVt9Pszja/Y1HqeF6Ze3sZnfl1CBotT/opPZUoPky2vXGc9NyxisXtIQIKBD9AXiLNi2eFk7JfjYC5xERMM5EzHC1fpTvCUtWXFuB6RCB0SLCXVcuNT7pnDlT48l8S1SCIVkMr+89cVEDxK/cGP66/AFAy6fc1Fg7lZFHd6X6aMoYx+ct1ZCWpoSJdgO/4NpHQekx8OeSBfqCIJ2u8jWoM/VwTdybq5C5DOrYSUd7OH581w2xun3q4hMN0V2qVJ6cS4LlpIneAzZKMUCTt2hfPldCcMA545dhH6fCX8kLIyc1BIUT0BRo7yndoRjMO96oXy0+CWyvpc90m/5gYnSFJvWDJJkeBRqlG0EA2gTn0/oIFGtswMGl7xiwyGCsd/s0mLyiDLDNbs52opmpKp4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEJydzU4dmI4dnJDTWJuS3JHRDdSdTFFYlNxUE5EWXQ5WmYwK3lPU25BeVc2?=
 =?utf-8?B?WE0xWE82WDhsYWtJL3g1bm9GSGk1U25LVFNEUDZFZGNRQ3pOTnNyd2pXSkxt?=
 =?utf-8?B?eVFRQkpXKzB4V0ZKUjZ3Q1Zud0toT1NFTThsSEV5Nmd2NHF3SDUxbmx2dHlr?=
 =?utf-8?B?WEtuNWRYaENhcmhHR2ZyTkwyT1loUG9BaGVxNDZYK2hrdm0xZzk4UE02SFQy?=
 =?utf-8?B?MmpZVzRDY3ZvV0tEVkt3KzluL0x2eTloQkJBNnIrZWhIUUZ3Q0ViaFQrM2tl?=
 =?utf-8?B?dkxtT2xSQXg3THFMakZaejBSZVlZMDdKZlZiLzFBeFhzZWNSU3BpNFJlaUtH?=
 =?utf-8?B?MkRTQ2FzWEJlNnZ5OWpFdEh0eFZUVU56YjUxa1c0VzBLMVlPb0dBN1hlaHFL?=
 =?utf-8?B?N0pReDhnVTJUT3h4a1kvLys0d1NRVHBBZG5EZXRiTjh3bVZGUGVoN1djSkxU?=
 =?utf-8?B?dzRKWWNqMGFHZEtnOWlFWE8wajdFY1I3S2VYaC9xV0hiTHFsZVRlYkxSSTZT?=
 =?utf-8?B?eUZ0Y3pHejg1YVJaSFpqTGtwUHF2NWhWT1hKejhia1U0ZVBVaGRrdE5GRFlW?=
 =?utf-8?B?ZllpT3dZeC9IdkllUFRvTVJvUUpNMWUwUFJ2UnQyQXRLUllqQlZGYU1nbXU1?=
 =?utf-8?B?bDliRUpMem1MazdWcWJsT3ViMmFwQy9MSXFyalQvUFgxeDlkRWMreTRndEJU?=
 =?utf-8?B?L01xSTRCaVIyYi9SRGkvL1JMU0RYRG1YNHhVTWlQRnpsSGhYR1NJKzJIRW5z?=
 =?utf-8?B?SjhUN0J4WDNLRUFDNmdXMzdJQ21zN2E3cFlUNVFPcExXQll1K0M1Wm0vUTcx?=
 =?utf-8?B?elFWN0dEVXd4Y2dDWDQ3YlNFSGQ3RGtUVExZa3IwSlQwakI0Q0xLTjFzY3N1?=
 =?utf-8?B?YnplUTZWbm9XRS9ZSFBhRDZ5cmZIQ1UrSkNOV3dPNmlEQmhtYmtQL3ZBcWxa?=
 =?utf-8?B?RFhDbzlTOFRDa1l5MUcrS21FNnZVSjBRMmltOUVOYjlHckVTUDZUV2Q1aUd0?=
 =?utf-8?B?c3FLdCtPWWoveTJYV040ZjVCWG9QYjZqZ0dncXQyQnNmdG41WEIvM0F2bUNk?=
 =?utf-8?B?UjdMM0NObTNTMnRGK3pydGxVY3E0ZG02cVkwam8xWHNIY2N4VWNsV0xZQ1o3?=
 =?utf-8?B?OFNpMklBMCtkdFdRbHNxbkt6aUkvc0NpUUpvN1J5QzREWGVJTjExQjB4RzA4?=
 =?utf-8?B?empkMVpYRGZHY3NGYjdSTFRDVVRXTWp2ZDZGOC8vZzhGcU45ZGJEU2o2cDlO?=
 =?utf-8?B?VGNrTDVpekVhdFJDR1dGOWFPbC82c2g2RW1zNnc4MnZnOHAyby9wMFdhNmFC?=
 =?utf-8?B?NkEyVHg0OER4SEpRUTJ3YmMybXVyYVNCdW1Qb2FaSHBRRUl5NGRtU05pdmxk?=
 =?utf-8?B?RWNrV3I3SVNMSFhCRkMrc2xpWm5Kck9xbzVrNVdTcnhEa0ZncURGeXpFRWx3?=
 =?utf-8?B?VE5wQUxZaHdydlV0MWtKdDBBV1J0eEZIb0J1NmNGTmYwNnpSWGt5Z0k3cEEx?=
 =?utf-8?B?UjZ3ckdnTHNkK0R2K2lPYndGZmJHWUhBMkp2SW5RNFFmaHZHM1c3eFlLaEpr?=
 =?utf-8?B?UnBRMUxsQzR5RUE3L05DM29ubTRKdmlCcU9EM1ZvMGUxWi9FOHgrZ1dTT0kx?=
 =?utf-8?B?alkvcTZqcFdtdUdtS2tBajVmVHUwRStnQnJLelF3YzVScEM1VE9kazJXY2VX?=
 =?utf-8?B?ODdDb3R0ZjRyTDA1UjlBMUNIQklpYnpGdTV3UUQ2ajEvc3I4enAxejU2TEs3?=
 =?utf-8?B?QVB2ZHpnMHgxY25hb1JMOTFyWWJLblE0UGJRbDNQVEhhd3Q0VVpiNVFVZVBS?=
 =?utf-8?B?YTFmeDJBd2RIallVanFiSzAwdFhDcVd6dmN2ZXhNZFU4SlZWWHc0eGhXMGQ1?=
 =?utf-8?B?aXV1eVZUTHJDSnEzbnJJT3ovZUN6ZXUyUmpZS2tlaUhFNm5YN2JLb1QrcG1W?=
 =?utf-8?B?NkRRVXpYRkZLNW5IQy9tMHFkcEovZWZTc1UvS2swdTk1OXl5UkpyZTN1TmtJ?=
 =?utf-8?B?c0VPclM0Q2dUR1FwdjJiRUJKWVJiNncrbi9qUUV4TjZ1aHlTMnlyTnRCSVBk?=
 =?utf-8?B?ZkVEME5HNmUweko5TE1wTUpwbjFqZ3BCZlY4bDJHQ3ZxNEpYVEJUbWhvRkdh?=
 =?utf-8?B?ay9wQWEzSnVzMDQyTkdSaHVGVEw0cm1kWTBRS0t0MDV5S1N4NUppWVUvSWR4?=
 =?utf-8?B?YjhsMzZXWFMzRGRLVEcvQm9XV0l5aEZrOWlpMWN6WStVcjNzVEFrTjJtK0tj?=
 =?utf-8?B?K1QwNXAwUVJHMUdFWGUwYThaTzBLYXlZRDFab2Q4eUtncHRNZ29qMW9wa3BM?=
 =?utf-8?B?WThXZWJBS0ZkWmYvcHlUYU8vWkRQeFBPQ3ptc1B3Y2NNelpMY2NLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca69368-f754-4ecb-e802-08dec23be456
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:19:22.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh97bfBkXxSP8RtS34LrFtDtlBSY695DUFVEUWRRtOv0w38GSuSFXJWJ1rgD0TOAaf75MzYJ2IrSlaa4R+CDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530


> When using guest_memfd with support for shared memory / in-place
> conversion, it is necessary to use the guest_memfd ioctls to handle
> conversions instead of KVM ioctls. Implement support for this by looping
> through all the sections within a converison range. Implement everything
> in terms of the kvm_convert_memory() loop, which already deals with some
> special considerations regarding various holes / region types that might
> be encountered.
>
> Also update kvm_set_memory_attributes_*() to use the same common path
> when convert-in-place=false. This potentially results in a small change
> in behavior due to the additional MMIO checks/skips now being applied in
> that case (generally qemu-triggered during setup) rather than only for
> kvm_convert_memory() (generally guest-triggered), but this is arguably
> safer, and it provides similar behavior between convert-in-place=false
> vs. convert-in-place=true, the latter of which *must* skip MMIO holes
> because the regions (and associated guest_memfds) themselves track
> shared/private state internally and passing the whole conversion range
> through to KVM is not an option in that case.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c | 131 ++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 114 insertions(+), 17 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 62f2e8aa15..fd01435a0f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1626,14 +1626,78 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
>       return r;
>   }
>   
> -int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
> +static int kvm_gmem_ioctl(int guest_memfd, unsigned long type, ...)
>   {
> -    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +    int ret;
> +    void *arg;
> +    va_list ap;
> +
> +    va_start(ap, type);
> +    arg = va_arg(ap, void *);
> +    va_end(ap);
> +
> +    ret = ioctl(guest_memfd, type, arg);
> +    if (ret == -1) {
> +        ret = -errno;
> +    }
> +    return ret;
>   }
>   
> -int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> +static int guest_memfd_set_memory_attributes_fd(int guest_memfd, hwaddr offset,
> +                                                uint64_t size, uint64_t attr)
>   {
> -    return kvm_set_memory_attributes(start, size, 0);
> +    struct kvm_memory_attributes2 attrs;

-    struct kvm_memory_attributes2 attrs;
+    struct kvm_memory_attributes2 attrs = {0};

Zero initializing 'attrs' fixed a '-EINVAL' error, caused because of 
kernel 'attrs.reserved' check failed in 'kvm_gmem_set_attributes()'.

Thanks,

Pankaj

> +    int r;
> +
> +    assert((attr & kvm_supported_memory_attributes) == attr);
> +    attrs.attributes = attr;
> +    attrs.offset = offset;
> +    attrs.size = size;
> +    attrs.flags = 0;
> +
> +    /*
> +     * guest_memfd may need to delay conversion requests due to
> +     * the memory being in-use by the kernel. In most cases these
> +     * will be transient uses. In some cases, userspace itself may
> +     * be the cause of the memory being considered in-use, though
> +     * QEMU currently takes steps to avoid this (e.g. via
> +     * RamBlockAttributes). On that basis, this code loops
> +     * indefinitely with the assumption that only transient cases
> +     * will block, and that those will be for relatively short
> +     * periods vs. the overall conversion path.
> +     * If those assumptions at some point prove false, most likely
> +     * this will manifest as guest-side lockups on their conversion
> +     * path, which seems like the appropriate way to surface this
> +     * situation to the guest owner rather than some hard timeout.
> +     */
> +    do {
> +        r = kvm_gmem_ioctl(guest_memfd, KVM_SET_MEMORY_ATTRIBUTES2, &attrs);
> +    } while (r == -EAGAIN);
> +
> +    if (r) {
> +        error_report("failed to set memory (0x%" HWADDR_PRIx "+0x%" PRIx64 ") "
> +                     "with attr 0x%" PRIx64 " error '%s'",
> +                     offset, size, attr, strerror(-r));
> +    }
> +    return r;
> +}
> +
> +static int guest_memfd_set_memory_section_attributes(MemoryRegionSection *section, uint64_t attr)
> +{
> +    hwaddr convert_offset, convert_size;
> +    MemoryRegion *mr = section->mr;
> +    RAMBlock *rb;
> +
> +    assert(mr);
> +    rb = mr->ram_block;
> +    assert(rb->guest_memfd);
> +    convert_offset = section->offset_within_region;
> +    convert_size = int128_get64(section->size);
> +
> +    return guest_memfd_set_memory_attributes_fd(rb->guest_memfd,
> +                                                convert_offset,
> +                                                convert_size,
> +                                                attr);
>   }
>   
>   /* Called with KVMMemoryListener.slots_lock held */
> @@ -3447,10 +3511,18 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
>       hwaddr size = int128_get64(section->size);
>       int ret;
>   
> -    if (to_private) {
> -        ret = kvm_set_memory_attributes_private(start, size);
> +    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
> +        ret = guest_memfd_set_memory_section_attributes(section,
> +                                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
> +                                                                   : 0);
>       } else {
> -        ret = kvm_set_memory_attributes_shared(start, size);
> +        /*
> +         * Without in-place conversion, attribute-tracking is handled by KVM
> +         * across all guest memory rather than on a per-section/slot basis.
> +         */
> +        ret = kvm_set_memory_attributes(start, size,
> +                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
> +                                                   : 0);
>       }
>   
>       return ret;
> @@ -3544,7 +3616,8 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
>       return 0;
>   }
>   
> -int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +static int kvm_convert_memory_full(hwaddr start, hwaddr size, bool to_private,
> +                                   bool pre_hooks, bool post_hooks)
>   {
>       int ret = -EINVAL;
>   
> @@ -3588,10 +3661,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>               continue;
>           }
>   
> -        ret = kvm_pre_convert_section(&section, to_private);
> -        if (ret) {
> -            memory_region_unref(section.mr);
> -            break;
> +        if (pre_hooks) {
> +            ret = kvm_pre_convert_section(&section, to_private);
> +            if (ret) {
> +                memory_region_unref(section.mr);
> +                break;
> +            }
>           }
>   
>           ret = kvm_convert_section(&section, to_private);
> @@ -3600,13 +3675,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>               break;
>           }
>   
> -        ret = kvm_post_convert_section(&section, to_private);
> -        memory_region_unref(section.mr);
> -
> -        if (ret) {
> -            break;
> +        if (post_hooks) {
> +            ret = kvm_post_convert_section(&section, to_private);
> +            if (ret) {
> +                memory_region_unref(section.mr);
> +                break;
> +            }
>           }
>   
> +        memory_region_unref(section.mr);
>           size -= section_end - start;
>           start = section_end;
>       }
> @@ -3614,6 +3691,26 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       return ret;
>   }
>   
> +int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    return kvm_convert_memory_full(start, size, to_private, true, true);
> +}
> +
> +static int kvm_convert_memory_attributes(hwaddr start, hwaddr size, bool to_private)
> +{
> +    return kvm_convert_memory_full(start, size, to_private, false, false);
> +}
> +
> +int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
> +{
> +    return kvm_convert_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
> +int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> +{
> +    return kvm_convert_memory_attributes(start, size, 0);
> +}
> +
>   int kvm_cpu_exec(CPUState *cpu)
>   {
>       struct kvm_run *run = cpu->kvm_run;
