Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792573028;
	b=HzQW+2uCVgka3YUQXsBwBdwgDb5hl3seG9ZGuQWuL/XnzMjYBTSAaEQA7iSnNtiJyKqi
	 QzedS50ZDn66/8Hbu6qLWn4Be8GNrQH4zS2FUgc5pixgc7uJaL/C8DY1ETS3CmO0PnZPF
	 Ykxtwexioth6178OJyVCD8yfI3dxhcvnyEAagSB+yS7bnK7bZMKh2Q5ltKGdRNCsIR0L5
	 IZrfXBZc4Smyua6IPO+7nplcd/DHsBK6rHnM74TrpIvqeqTI4WJLBc+6iP3H/0X4iqbsn
	 7q5+J/YgE64RIz67s+p55V96Uw10xtDdfQCKWw6B1PGTGuWJUAEdOgkwsdcSmRTziWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573028;
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
	bh=SM/1LaVOr3aM9IIvFk96Yis6rJgpYG50rC/0645EMIA=;
	b=c3EZCHkWbfNQrVuCpXd5aGHV5KswD1qYEENNJpWOjzVRxn0T3K/lE1DH928CWMrTwRSs
	 HqUDSv8xIzrXksehCoKmhjctIYwHtxGZQdC/SROVI+5DYV2ldSFxp5Z/FCTsLFoZ7YZWM
	 0923H1EG+0yFyoeoVBtVu9RzCLCTlDsz5MFSh6wOrBiwKkxjrukbVWXzWKxQetR7tC/G+
	 EXM9ax6UDfaNW1IwmVCUIztCsmTKYxL7BaCBMoVhIAGCiudxmVR+04PXj7NmYPiZhVXTG
	 VOapXSeFWrEdehKZ0VO9YpyWMvVFvlsQ2arXNcWf8vjBxN3dpXzsVpsMJac44AvhXTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxkXixhV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD72606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 08:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxkXixhV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8kUN8lMSjAn1lDh1aPv55iGpzkth6ohNNR/n8XIbr6rCGjej/M1AJy+hY7LYUGM77zlWvYDAtzN9MwPp2Hwaoti6XVGRG/dgbXXYW/+fdvXtBOIOSMB8i4FW9pNNjUM0+eNfM+JzC/aABFRZC7OEXRGiwTMhKQ6Fs2PLHUqJsBg4Hjb5zV07uNn5nT308kBWp0MZi8Z/jNZF7ZFpqlOaK01zM4KIdEArMPnR8OAPi4WzcLC0RrTzDuZbjfsvGc6zFa5aad6bK3mw4JJZzXxOh1M0/6xhflp8bM94Oy8OuKWKEXW0z37Vf1RP70xSJOkA0BAZJ+0T9VcvRNplmYWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM/1LaVOr3aM9IIvFk96Yis6rJgpYG50rC/0645EMIA=;
 b=J8pu/ndzhTMQMVG7lWWaLm65dObck3/VJWR9X8ZXpb01eiSAnXpRDlvHny85P+VqfmgWEGm+DcnwTY3vuCAX0piE7tlN9tKrIMoIEKJjK1s0shmzugwR2H1S6uVNu41sZX+2lgY4TR0x1sR+3YSNnpNQ0AcWf8W3whrB/EpH8NeNIeDRRhFd/vqClv7z+O1BiBKw1uAjMr/5tmq/SgA0bm7nvJXaXoLBkNyob46SPsPAWJvk09NfA83cpfIMGPYrXO3dFs7dSFaOS5LZJUX0aC44ywyDxjeBAUwwLud87aHq7o/vGDZAJiPNDGPvhV3fG24XUiowywr5yECr41jDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM/1LaVOr3aM9IIvFk96Yis6rJgpYG50rC/0645EMIA=;
 b=cxkXixhVs81qKkDcywaIDvRlZqVb2ZhTkdK+rKIwU5j2scbFI/yKZFAkiWrdrPk/0VHmK/DuRWrVR6PwXwalS3TFnOc5uj0sc5t8A3Asqqqs5cYTERJu4GUvPgeZElUAmRpFbbmIQz9/8qmoQA26QkOfCXVV6NfZDHbb6gWuILM=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:57:04 +0000
Received: from DM3PEPF000265C4.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::56) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:57:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C4.mail.protection.outlook.com (10.167.23.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 08:57:04 +0000
Received: from [10.85.34.241] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 03:57:02 -0500
Message-ID: <051a00a2-d96e-4c7a-a787-ac454400288d@amd.com>
Date: Wed, 21 Oct 2026 14:27:00 +0530
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C4:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd0ff93-59c6-4fd5-78c1-08df2f514719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kTjKRmo3FoMXd3Nh+7fKAaTovR6KWkRSRwb6tkOrljcIK4agwuC2lfoYG7u+T+hwtxVYPMFZxg9mxBOyB0H2cgQJFfebzjgrR+h2oBid6dS/Sa1lCsL7fOmS3k4mrzX2ysNCIqmf4kQkuLg7YVFusPwJiZr/ADCbLJwehM9mE6hOoLv5mR7it8wCE5VkB2btFLCP2xp3DdYdc3ZoiJnXENkzCnW1hZMC89kcyJN7cSNibUs/bx+LsCKCXvDBrK+0FauZKxXlrY/wnjCxjv3/CS37/A5ssBWft9jcqSQADbgkwYl8zWHn0dLs4lUJrvRcRazoS+EiKdSr38KCVgfvYta6v4fb3pZ9fxPGnDqL+Mh8OYWP6/FQUhXIAN/Yy2h7coZRN2qEUrfBZOGEE2wtPf507eI19xavsoCWdPAkPQCU7W+9/T75dCsSMaJJUgrDt0dC5CpzPMDOK6PNAB2Jfshwa/N+BKAwOMheJNwy5VcGbOtYPMF4euuuHqp7WVtg0Ev7HuMKHpJkmCjJ7tqipPhb7W8OmfIxwXARLA2b82rVjjlhMLc9oA7fttvo3sIYEt/zj6Bb3wtbNVyIHHryEerZ9X/k8j18i7zl2ytN8PaINjD/6+PWgRbIxyHR07LvosJYdzr12Uv5os3iIXvjIi13ArIJLLm3sus0/KDNBs5SLvJPOvJlVswCdvkXY6KSTfQDZFnW/zD4X+aM5Ed6PQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qtUwPiwHWxDR/f4Z5Vk8j8vEkJCvL5GSH1Uk1JnAOrI47DJ7pUcEAy8AYpfHxWEg1xNz2jVxclhRDev36VYt3/jxeeb+bY1632BVo3Gv1oOQ7XlE6jvdQYeGj5RtK3QThKxZ+TAp65vP4qcAoRWIBA6luU3jh9oFzAvJDNIkkzo6F6FIjrGBtcdrz6B5nJtnRb/m8DXteG+J2+rcLMW3VhFRPK2iNFgcSKUv1TWjg2Y6fLI04Z1kfdtCJfRBRn/WV3p2P5r3wAAc2gPJxse8OpGD0z1lKmHqAY1CGLe55X9mIvNGtxJYVZWrapgJDLw8unuwkw65dcGcg5PPQumriKmjSsH0+CjGSNiaO28mnyZxq0MoPSybq5yyz+5V7KYpw2/w/xrEW2DpvwG3cX682/x32ivJbrQ8DCpcFBnbtsdAIHnP39l0IXhxeiS1Vl+m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:57:04.0813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd0ff93-59c6-4fd5-78c1-08df2f514719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095



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

The early return will skip setting up IRQ_POSTING_CAP flag, subsequently
KVM will use legacy mode interrupt routing (using eventfd) instead of
setting up IRQ bypass. Because of which KVM does not call
amd_ir_set_vcpu_affinity.

Thanks
Sairaj

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

