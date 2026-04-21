Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013075.outbound.protection.outlook.com [52.103.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156A2D9ECD;
	Tue, 21 Apr 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761948; cv=fail; b=DEzX/5p8IOz7un/vwMOv+4L9bO8LPMo+AQB538OIo/wJLpZmA/H10o5Y3Qpbcn9gi/PVSU3bZlYgTwvdj6zUZ40/6rx0QOIhMdYcLDqnMVsyFi19MfEIo05Ue42ARy9L51EWWVSrcebIR1cq1tCEYMfVu0bb2Nnh5Zcopqcuggs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761948; c=relaxed/simple;
	bh=NokonzZuvXtjqF4bjgjXSAsh4sHFzRqAlXBmQJLe9pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+cj2Fvhh5TKWxWl8uwJkcXJXwpNl9rvorwI4pCmdcib9PrOFnQ5p+CiJ5dKIBIk8bloPinQfUCYPXWpLklDTywjYqQNIKioxhgBxqEv4F1V2ZG2hsj3C9K4k/NcocfYIgZoK76gd7s4BJCePsEBwezAkAgTpEgQGe6q2XudQhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YeYKypEt; arc=fail smtp.client-ip=52.103.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YeYKypEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+LnMJQ3/zkSiefx3/vkImGCINPkF0AOP7EmluBGzSf8+hwUBj7qE64ZRSd4ZestPRtuqkFjbkquN4t4rLOS4fPIG+iK3qau/tXU4fkzJvc0jLY9Kvv17SCSIhOfEqU4UqQr3CdXdXTIt7cHu6fRStRZ1wTyNv4xF/CnBE77F6yDq6XCg7+79YP00oFwbwY8N8VtxskwNUumhWnKZl4xzvxw0dCT7QNMSpdRJ8yEG/JbUbISS+y1em/0tluS/FPixdxaleBmg7VSxtXZ7ETRwRMrp+66kI0PUIdu4GPfl4XhX7oh6k/6/2iyjUalBuGH70CwLU+04D7GzllZ0gsKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duyCc3MulzhCf6MuyPdfhWEmckTc5p1/WTYFSt5JomU=;
 b=Z+jQdUkt3A5szxObrkExymOKHmW+nvIyri7dAfdfokIWApB3fviPXvuSSIgx0T2jyoczhZZqE6MMISgScLZrV+EDrdTxtyPEdCUNdBA6qZhPjlx/ruz/NLXULbI6d0t43VMQ+fkOm9WjSGHzmghWRzTsFBKxR255S0iTDhPHKor0Ydyt0lRi+Ezuf962abzQChOZCWhV7EwSFDXaZvLgRvsor/RXp2JHf2hdydX5qZE8Qrks7NOsXaaZXTqDvz0zGrpliJTi/aacHrR6W4LJgnS/2ZC+H9/d6JAdfhp4FsxggPemSxZXqPUR822Nf1tuobQnLzlgW86geE3RTfByYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duyCc3MulzhCf6MuyPdfhWEmckTc5p1/WTYFSt5JomU=;
 b=YeYKypEttIvlgRULntCJdJg399euKuwY4P9vSjosu92hgBuF/1lfQhNRMuy/uj9OH8z/wunHcjzMZPBahchjpFBzqW9SVubrBaYIhlVF+MopcZuodbBQhlr7QoelcB5bgf7vzE+7A9pJaWboBDy+IsDLMvdfnBzgitHs4bDylEuVQSom8IsksYWIc9s5jINUwEMS165mGpxYZXoRWERxvLLBjbohic9jQgJKGLTRS8WuFW3fQo8/a4cRmnp6x5srWngQUlu2A+G3dSw8/NxBzBJdxeMNMs7SMiSKxKWgaGQUXCbm8h/MR6LOEbAnX33i1f8VN5WXi5sn4/u6v18Pmg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by OSNPR01MB7771.apcprd01.prod.exchangelabs.com
 (2603:1096:604:31f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 21 Apr
 2026 08:59:03 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 08:59:03 +0000
Message-ID:
 <SI2PR01MB43931A8F02B985CBC7AABF49DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 21 Apr 2026 16:58:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Dynamically scale directed-yield retries in
 kvm_vcpu_on_spin()
To: zhanghao <76824143@qq.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_91386147982D1B2901B22D2423D4643AC90A@qq.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <tencent_91386147982D1B2901B22D2423D4643AC90A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <9b884a56-5891-4f31-b775-b350197c309a@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|OSNPR01MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4af21a-b8af-4db8-7da3-08de9f843bf1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|5072599009|19110799012|15080799012|461199028|41001999006|8060799015|51005399006|23021999003|6090799003|7042599007|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDl1c05sNmc3N254MXliRytPeEsyd1RFQ0Y5NlVRRHZNalpPbGx4NnVzNHhL?=
 =?utf-8?B?OUtlTGttVTFrd0ZTdWxlU0ljWTJuL1hnckY1VGZNQ2UwdWJwMm5vMUpFOHY1?=
 =?utf-8?B?VCtRcWk2dHRaZVpCTmFXRStGVURWaTAzUXR2bmxpcDlEeFpWbm5VZGZYUnFL?=
 =?utf-8?B?TldFQ1dxZlBqSGlKandoblA1REk1ZGQ2K0s0eFl3TTExLzlhb3pnc09uWFRI?=
 =?utf-8?B?YlZoZ0JkbFRlOGFaRXJQSitIdjNybTZleWd2K3hkRmxBdUpiZ1UzNHJPSGNU?=
 =?utf-8?B?b0NTNlNWZjV6SG0wVXNjWjNYdUp6eS9xRWh4bnQ0cy9HTStwN2NZYVlCL0c5?=
 =?utf-8?B?STd2WVVRZHhub3Iya0twMjVleUVnTGttNlByRERXTmVZYk5ReTRGUGJZUGZk?=
 =?utf-8?B?blBwNjBNRmVWV1hOdzh6cmVPb29PM1RkeGYwU1oxUUpEaWdIQ0pxWkRkcEo0?=
 =?utf-8?B?eW0vZU5Mbi9iUHdOSXFNbVI3enJKUmlDTlVqSDUwQ2JLYnFURHRHVHBnY0xz?=
 =?utf-8?B?NU9xbWxyZnJxNVJBaml1TnNCVkJiTEx1OTdrSUh0S1cxamprSFh3N29nbGNw?=
 =?utf-8?B?Ykw2dFVZQ25aSkZXTGJkRUJJT3h1aG1UQzU2YmZQMnBxOVpsaiswSkJDVmhB?=
 =?utf-8?B?bW5pV3k5dWhVRm9ENmxKVDZ1Sm5HS204bmhuWGRBMU1lTGtZdDV1bzlIWjJ5?=
 =?utf-8?B?MUNIVXRidE5YZ0RjUm1vR3IyajdiM0pJN2p2d3RUL05vRGQ4Nzh6MkRBdCs2?=
 =?utf-8?B?K042cGVWcE9xdEE3UjVEWFhWRzVmMkZ5Y0xEZVg5Y3VVcUxJQWNCNStoS1RZ?=
 =?utf-8?B?ZEN0dS93dG9PMzhrVGhxRXFPZFdWdDhYQ0ZUSEx3U0xjMzFVWnJMbzNlaUtF?=
 =?utf-8?B?N2hEZm5ybmtjQW5RSE9MdW03UHlVbFgxbkpUUXFpQUtxcmxnUkpXZTFnSDdo?=
 =?utf-8?B?cGM1SEhmbDN0ZC84b2Y3R2crMDFaQkxMMllkU1kwS1BrT25EU0c5d2hxTkUv?=
 =?utf-8?B?RWVWbnE0eUhVbmxHYmcvMTNwQ2hGTEU0UU1ZaDJ1VVIrMGx1UkxKWmVWQy91?=
 =?utf-8?B?Y0svVFk3SmNFK2dhR1pydkhuemNrME8ySE5QbmYvQk9jMDFDT09WdlJlbWIw?=
 =?utf-8?B?RnBtNmNwS1ZkWWhENWpXT1pnU2tkOE5TVTZlZTRVNkZnengzdTdxNC8vMW1G?=
 =?utf-8?B?bW9qMlhaZmFiRzBVclpKdkZsQzNZYlAwSVpRNTI2QXNoNXJVS21JVHQ3UDlw?=
 =?utf-8?B?cGdDSktScnNGR0Q0Wm80UHMwcEwvY2tobHkwRW9SSG9HOGRaR3ZuaVlmRUc0?=
 =?utf-8?B?ZlkvTThvd2xTTUJ4MUR0b21zN1IrZnlhRkRhb3B1Z0ZMZWhlNzEzKzFIaU5V?=
 =?utf-8?B?cTE2eGlGSDFBYnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3ZHR1dXbWtCVmNlaHpLQlN4NTk4TEdURnROaHRYN3BJb0hWYnFxNnRiWnFD?=
 =?utf-8?B?U3NoZm1LRzluN0YzMzZSeDZibHprYUhqSHlVc3hORjFJWmY2T0lNS2VjSGNm?=
 =?utf-8?B?Wm9SanlSc29ZYndneTV2Qm81N0xSOHB0TGprUnZQWmlIQ05KK3lRb3ZidEpT?=
 =?utf-8?B?QWN1eGZyZFRCNmdKYldoVDRmWUxLQVU1VkttUEg4bVY2TVZtWG0vOWwzcW9m?=
 =?utf-8?B?WmFjVC9CRmdLK2xJTVdDNmg1SlNXZEVtNXIwWElpWnpSZW5KUWxWcUJFTkRk?=
 =?utf-8?B?Q1dsdTVrNU8wZmRwaytyVGpkT21WNzNIK0lIMTV0OFhuTjFjUXZ6c0w1cENn?=
 =?utf-8?B?a2dTaGQ0MmtIbzJzTG5tWEhCRGdIelRPQWczditXY3haYnhzdGovZXNoNnFV?=
 =?utf-8?B?emFBY205VzRZaVowR01sVTZqWUdFakxrNWw1c0Foc2tuR1F1THhlNnVILzVC?=
 =?utf-8?B?UE9FUnd3WFRPRXBSZS9FajdaazlMN3VhUFQzaGVuL21PQ0FzckpFbTZMZUpx?=
 =?utf-8?B?YUVCVXorV3k0NVpkMnRKMHBhS0VQU29oME5QaVRpT3RVQjFhK2g0U1VzS1Uy?=
 =?utf-8?B?TjByS041VXJRZGVyaGdGcjdhc0ZDVjhiNW12WkJ0cFpZMFFIOTNYalhjOXRo?=
 =?utf-8?B?Nk95c281ZGZ1WHRjMUZTUVVUenhTQkFaeHU5QnFQeStVd0pORlNtdEVJOEg0?=
 =?utf-8?B?VUNoU2JvZUlSVGN6UTRGWWVPSGJpeHZ1WjNGL2RiNnR5WC9INWJ2Q3NXblg2?=
 =?utf-8?B?aU1XZnMxUVZjUWp4RnR1NGRGajZ0S3VzOTFsUEp2djcyWnFFamNCbUxZa3RI?=
 =?utf-8?B?WlN3c1NiU0ZCZTZmUXRHMWtVWkphNWswOWViMmdRbmdBbC9BYjVnM2ljK3lD?=
 =?utf-8?B?eHZzVWUwL1NJYTdxQWVnZFJUY2U2bEp5eGQrK25UL2JVOUhIS1pCSm9NeER0?=
 =?utf-8?B?Nml0R3FyeElWa3RGS0p2VUgvUTk3Z0xLZEJTRE9ST1RUYTNkMWhyanB3MnBk?=
 =?utf-8?B?MG1zVXNKZU9ra0w5YVFvR3l6RTk3UlpIRkgrWG5DRVNRamhDTEdTZkVkR09Z?=
 =?utf-8?B?OUlIenlBZ1NPeTJpeElpTTVFcjF3K05zT1RkNk9IZ3RPYmFpRmVEMVFMMmYz?=
 =?utf-8?B?SVJUZnRPWjFXTnFyWGtKakRrN2UvaDBtWWVIcDlyeDNVU0xZVWRYc2V0aFBy?=
 =?utf-8?B?VzRnV3o4UVdCV0c3dkd5bkN3U0lMS1JUTE1OZjQraDlFN05MVHRWZ1QrOUZj?=
 =?utf-8?B?SjhMSWdVYy9HUzBrdTVBK1FQTFRBZ3VlZTJEKy9kL044RFc4cmpBYmp5STMr?=
 =?utf-8?B?d3RzMG9MZEViMmVxcjQrUHRUK1FBdjhYQUlZMFRFVExMKzJGSWEzamg4Qmtn?=
 =?utf-8?B?MStNZ2wyZ08yc1lkYUE5OWk0VUxaS09UQ0VzNnBxSHBkbXBqdkRHbVVxUHVW?=
 =?utf-8?B?ZjFDRHFEaU9jL1JxRzNGOHV0NGlkYmdVRjA4RHB3TTIyd1lGM2ZWV1VxWERZ?=
 =?utf-8?B?aUltRC9pWFZEb1liRklWODdpNnk1WFNnS2xIWU1YZzJvRHFpL1N5K0ZsbmdI?=
 =?utf-8?B?aVl5ZytDQXZab2ZieUNlZnhDZVNmVk03WlRFZXU2VW1tQVRqdVh0UE5lWkgy?=
 =?utf-8?B?M3dFaGovbXMrSjNqS0RuZ0E3NHAwVHlpUVFnVzhzbmZNNy9JUmJRYnNtR2FX?=
 =?utf-8?B?cTJYSmExcEVYcEszakVseFFTNW5WeHo2aGVTRld0dDhmckpPYTNZTTdqa2dD?=
 =?utf-8?B?Ni9MQjZpazlqa0xCNUw4VjBXemtDQXFUNWJoRStydkV3Zk9TbElPM1RZbGR3?=
 =?utf-8?B?UkVjVENCZjREVjRtcVYza25lUWdTYjRGS1NtblF1dS9vbjZ5Uk1aZ0EyUy9w?=
 =?utf-8?Q?vOzCqg0T5Jjbm?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4af21a-b8af-4db8-7da3-08de9f843bf1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:59:03.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7771

On 4/20/26 10:31 AM, zhanghao wrote:
> kvm_vcpu_on_spin() currently uses a fixed retry budget (3) when
> kvm_vcpu_yield_to() returns a negative value. That fixed limit is
> often too small on large VMs, where candidate selection is more likely
> to race with scheduler state and transiently fail.
> 
> Replace the constant retry count with a vCPU-count-based budget:
> 
>    try = min(nr_vcpus - 1, 8);

Why is 8 the right value here?

Also, the probability of hitting these races depends more on host
overcommitment than on the VM’s vCPU count.

> 
> This keeps retries bounded while allowing more opportunities to find a
> yieldable target as VM size grows. Small VMs keep near-identical
> behavior, while larger VMs get a better chance of making directed-yield
> progress under contention.

Increasing the retry count also adds overhead. Do you have data showing
that this could provide a measurable performance benefit?

> 
> No functional change is intended beyond retry-budget tuning.
> 
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> ---
>   virt/kvm/kvm_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..cbe53cea10a3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3961,12 +3961,14 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
>   	int nr_vcpus, start, i, idx, yielded;
>   	struct kvm *kvm = me->kvm;
>   	struct kvm_vcpu *vcpu;
> -	int try = 3;
> +	int try = 0;
>   
>   	nr_vcpus = atomic_read(&kvm->online_vcpus);
>   	if (nr_vcpus < 2)
>   		return;
>   
> +	try = min(nr_vcpus - 1, 8);
> +
>   	/* Pairs with the smp_wmb() in kvm_vm_ioctl_create_vcpu(). */
>   	smp_rmb();
>   
> 
> base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428

