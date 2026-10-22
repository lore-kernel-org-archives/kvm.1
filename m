Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672556;
	b=fE9ntuxVm0Na+De7MfayivgJiTRzKmFFFUbbMuSNwyNlA442Map8Qg6tMtBXeAmFtCr2
	 xpYO4JM1NsmxOjrauXS51l6oTxMX/HLi2ZZubrKdB0WVaAAKxBTUtOx8/YpBQXeAYq0ow
	 XJNq/O+Kk+oROWbHxstoISd2vwBn5PJwKqZP7XigGtnc8XQ+5TBXkd22W4X9mk+OVNp3T
	 kqSzRyAV41XNwv8I635TDGw/SJ/N6DlWx2du91jK9M16Lzw5+HjCWTK5W7GvWuLHdNVQN
	 RVqSinUTNwTNPEJZt9T27k4KFTNgJW9FOSQKavL0in1VsAqKmHaD6hxw0lc6GwtV3ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672556;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=q1XGNiupac/jj2V/5Zux9ZKLEMDxBHJrQDyFB6h5kX4=;
	b=b+eygds55dbEb/qMhC28LbEYoti3d1UFNJa8Y30fNB5iHqWIlfsE25nYajK0NlF08M5E
	 9ybvB0XSoMmQD9rSONYZjJaz8hO3yK9ixByx7IuAf1+Hm/FVvGz+4U8uJ0/HE7105MdDv
	 CSwTSKYMyMVtWItdg9V6b9yrU9QwxWn7yz3EcXKpu7ttFGyUkKmY4heRxD9Ti51URM8qY
	 4nwsY0us51i8oiibWjn0wJ+v9qZ+KtTKDXPlpCNBZR1Rvl24hOKFLSkLhyb77mJUuQyRN
	 G3MLEkg8OnNdiLosq14PL1oF374ZmL/dpubia7AVuEvScuEpjIhImUmnwMCYkFNUVfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="z8Hc/d0Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB3606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z8Hc/d0Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRT3V7xazzwpp43d2U52VsfRnRHRpnvv3K/syp7bZWl+qEvJZMXphpbdeolEbISUaej67XiBWvhrfb8fUHxj4O3eUUOedRKvcbaLrd2KEmE2iZjc8hm8FyJarkKNTkeT8w/bc+b4d86Jty7gquKZRapEhs7rwgHTgKiuZA6Xjfh6zj0XbuV6jaGCf7iUImqLQrl7RckZ40XqOSlW+bzfJwrPXMeW5rmKBccNX2yEyv+WDPciv2UguRqjjDbdqwvFV8dpp+RM+eRseW0h0r0BRM+jsHNaVrSXRDjt8tEjye8SCRBKMW+jbva8ejO4ppaHmrZzaIZz/mvpNTgFQRHlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1XGNiupac/jj2V/5Zux9ZKLEMDxBHJrQDyFB6h5kX4=;
 b=Fk9G8zyrEF8POXeq2Le0ouXHCKZuxFkUA8bVr0vxBCy6WobVQMZ0X8cATONAxrkE8yXiDLUYHH4R3plB0s2nkCp4jRvNuD22LLQdrp4zgilBpTWJp/gzc865UAx+QGs58DZzQ7NMHyZo2Bww+Ra2mznJ4Lm7QPRB5mWJhMqyy2pyTCjY86SFAEAVXxwY1mAxA1MhQF16tybLsnT09Un1sVmP01MaaGg1WKjJho9yQa0z9Y79S+i9VIXOt95tXFcWNEPsHldLHjEGN0PxMPXDuVccGvAt0YxhMWGN0MCrzPLWvNV8TgO1/wqaG/2jWmHO7AADSEEWISwU4H1MPFI85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1XGNiupac/jj2V/5Zux9ZKLEMDxBHJrQDyFB6h5kX4=;
 b=z8Hc/d0QRestjtjMlqzMfkFRNneNFd9nVAAukrqIALjlTbOhMdLbCJKTR+c3tE49wDkvey9DX9rUIzIpBdFUTTnjVV6FX4LBUj5r+3RM4j8VQExsDEXuXpPTpV4sDhOR+1dOQufFQTWCHvSW46x9qzepmj7bLcuwJDS3OnO903Q=
Received: from ROAP284CA0066.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:a9::17) by
 LV2PR12MB150617.namprd12.prod.outlook.com (2603:10b6:408:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:35:52 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10d6:10:a9:cafe::46) by ROAP284CA0066.outlook.office365.com
 (2603:10d6:10:a9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 12:35:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 22 Oct 2026 12:35:51 +0000
Received: from [192.168.1.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:35:49 -0500
Message-ID: <267fe25f-79af-477e-be8b-c5c3def9b2dd@amd.com>
Date: Thu, 22 Oct 2026 18:05:46 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v5 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-8-sarunkod@amd.com> <sashiko-outbox-172380@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-172380@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|LV2PR12MB150617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e45b245-e73b-4282-fe33-08df303901df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|6133799003|18002099003|22082099003|3023799007|10067099003|11063799006|4143699003|261021135927099003|261021123027099003|261021130227099003|261009223027099003|261021121427099003|261021133027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ce95KYOnbePHN+gG9JVwaj4dFV4qyPGcJVuxzxcBQh4p4j13K/ZgbgaDh1zqA3T3PF5czlnq7xJrQTStP9CF8CzDu0iHdKva52r8HWD0c2y0XSi8MfNDUjBJpz4Ece0XpWVvK7UbEdr+cOzBU+uEcCSk408d73kRRTvlLl3uz6Tw4FdxRJdrNA6hUPZPFMAS6RToWe3IKQtgXrT5+DTG3qD5HGB4I5YeF31W+PimYdxPM9zBEpjDaWY5PGEG0qSgI7xwSZ0i1zg0NHRTyf22NQFYCnxuUdTP/Amzsnb1arGhU+4gCIF7TeMpxQhkjtanck/ikF3pctLLrdAwjTg82Aa/7ZxvtdU7qJ0A39DMxWDQFRxH3jQlbgo1UW/QMv+ZgIsleT/OfN4ACMukgT1qGyMS2D5RtHOhT0TS4gi+2eWBjIkEBu4DFdLU+flME72Ee+FsIYOy5jfSD47j1qSw2XqS6WwV/ZQTn10bBtcHHGxAovEpiZ+VfslO5o6ooT+g3aQxdQorOx0OQmqkiwLvYCuRKwcwVnhOaAKNeIiHfwxB9f3vfrNVWBQFZ1s5cksWm7lp0HJOvZh8KHlemSPyD1OxNgTQv0fiuve0oBKG8lSVOJgcnIY4gako/OKcU0F297wWkuS1H3QGM+jsNl2e5xnCnY1xFRdIIuCbq2re02OA7jRTN3pGmz2ncIjS2Sg9KDS63CTmNOi7ic5RI3aA/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(4143699003)(261021135927099003)(261021123027099003)(261021130227099003)(261009223027099003)(261021121427099003)(261021133027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G3vrOaygm32LkjXJyoIWmdvRCnzep/vnnTkOG/Ic1q8rrjsP13o+1Np1AtSJfDQFFsRvLs/t7aOPZHreF67y5I/KO7V/uI2BOzT0NPOHxckyPun4Ab4vXa/YgUygldcYyD1N4LC3KDKvDliRIb0Qi4y5JEnpBECTeKqC+7mklZIkv0DoNH00PhahPiA2vR49ho8WhFTu6ZI/8w1AdQi2uIL+co2Zx1WIfi1FDomYNntjQqFhe0SoBq900mvGWOET/WshVA97EYqSERqn9Q2JGGASjjlN76WIZOu5hU22xyzl1SVAAp4jKIHZOSnbzhVZ+N9qhirCTrrxc4EA0VlF2SmEb7avamD0zc9CErX6bd73WGb3LxzV0Lb9vYd1a+quSkgjrfEO7ujMqZT8q96SZUkCfXDa1PdA03oyZJGMr+NN6NClRpdDixXHS93U8N2L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:35:51.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e45b245-e73b-4282-fe33-08df303901df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB150617



On 10/15/2026 12:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] iommu/amd: NULL pointer dereference in iommu_poll_ga_log() with GAPPI
> - [Medium] iommu/amd: amd_iommu_gappi state inconsistent on VAPIC fallback
> - [Low] iommu/amd: missing GAPPI in feat_str feature name array
> --
> 
> commit f3f34d41f6c88bbaa635da8109c52cf22d09f580
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> iommu/amd: Provide kernel command line option to enable GAPPI
> 
> Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
> the kernel is booted with the amd_iommu=gappi kernel parameter.
> 
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index b89a2b3df0a49..51edd617ddca2 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -78,6 +78,7 @@
>>  #define FEATURE_X2APIC		BIT_ULL(2)
>>  #define FEATURE_NX		BIT_ULL(3)
>>  #define FEATURE_GT		BIT_ULL(4)
>> +#define FEATURE_GAPPI		BIT_ULL(5)
> 
> [Severity: Low]
> This isn't a functional bug, but FEATURE_GAPPI is defined as bit 5. 
> 
> In print_iommu_info(), bit 5 is still hardcoded as "[5]" in the feature
> string array:
> 
> drivers/iommu/amd/init.c:print_iommu_info() {
> ...
> 	static const char * const feat_str[] = {
> 		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> 		"IA", "GA", "HE", "PC"
> 	};
> ...
> }
> 
> Should "[5]" be updated to "GAPPI" so the kernel boot log displays the
> correct feature name?
> 
> [ ... ]
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index ef23e0755c32d..c536e0b3c4ff7 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
> [ ... ]
>> @@ -3025,10 +3035,19 @@ static void enable_iommus_vapic(void)
>>  		return;
>>  	}
>>  
>> +	if (amd_iommu_gappi &&
>> +	    !(check_feature(FEATURE_GAPPI) &&
>> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
>> +		pr_warn("GAPPI is not supported.\n");
>> +		amd_iommu_gappi = false;
>> +	}
> 
> [Severity: Medium]
> If VAPIC is unsupported or disabled due to SNP, the code returns early just
> above this diff and falls back to legacy mode:
> 
> drivers/iommu/amd/init.c:enable_iommus_vapic() {
> ...
> 	if (!check_feature(FEATURE_GAM_VAPIC)) {
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}
> 
> 	if (amd_iommu_snp_en &&
> 	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> 		pr_warn("Force to disable Virtual APIC due to SNP\n");
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}
> ...
> }
> 
> These early returns bypass the new fallback check added here that sets
> amd_iommu_gappi = false.
> 
> If KVM subsequently reads the stale amd_iommu_gappi flag and attempts to set
> up IRTE entries using GAPPI parameters, it calls irq_set_vcpu_affinity()
> which triggers this check:
> 
> drivers/iommu/amd/iommu.c:amd_ir_set_vcpu_affinity() {
> ...
> 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> 		return -EINVAL;
> ...
> }
> 
> Could this result in a kernel warning and failure to configure the affinity
> since the IOMMU driver actually fell back to legacy mode?
> 
>> +
>>  	/* Enabling GAM and SNPAVIC support */
>>  	for_each_iommu(iommu) {
>> -		if (iommu_init_ga_log(iommu) ||
>> -		    iommu_ga_log_enable(iommu))
>> +		if (amd_iommu_gappi)
>> +			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
>> +		else if (iommu_init_ga_log(iommu) ||
>> +			 iommu_ga_log_enable(iommu))
>>  			return;
> 
> [Severity: High]
> If GAPPI is enabled, we skip allocating the GA log, so iommu->ga_log
> remains NULL.
> 
> If the previous kernel used the legacy GA log and left an interrupt pending,
> or if an unmasked interrupt triggers the handler:
> 
> drivers/iommu/amd/iommu.c:iommu_poll_ga_log() {
> ...
> 	head = readl(iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
> 	tail = readl(iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
> 
> 	while (head != tail) {
> 		volatile u64 *raw;
> ...
> 		raw = (u64 *)(iommu->ga_log + head);
> ...
> 		/* Avoid memcpy function-call overhead */
> 		log_entry = *raw;
> ...
> }
> 
> Won't the while loop unconditionally dereference iommu->ga_log which is now
> NULL, crashing the kernel?
> 

This is a valid concern. This is a pre-existing bug and can arise if
second kernel has IRQ_REMAP disabled or fails to enable ga_log. Hence it
is better to address this in a separate series.

Thanks
Sairaj

