Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587E3783AF
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342348; cv=fail; b=LrLtRj6LrzPcnvpOPk9GrEHnfKcNEID3utkKs4afOjkvN5WbkjLYtdF9rC1BzXnIVUgV5MKhpwLpIx/eOYbBmdb7RP9ZNuHbRR/vp/tDC6WO3MAkJwl4K1FHYj48KXZn0QB+FQswb/GaofV10RVI9dHCNc1DyL72j6iGb6WuO74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342348; c=relaxed/simple;
	bh=gjei86QODtOL3iE+ya5WNHGD+hNI+McRap+w1RFuDzQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oDO5LxgHpJEoDWQX8RQnIi/hHp62ldIOfazQfkRJ7AlG6g8OIocMJlyG8iPWnZ8aNnX1LUjChPGs2GYkN+xSrkbkEztbNUWp/RA0m3OWVTxOOa+csjJxpCUpN0PgGJdBqNIZnjNJD7OFyV5kteKcE3pNuItCXSR6qCRjm6OjNzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhwdRkZS; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhwdRkZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg0EpaArLD2dksF+J0ThRhMCs8QIYRLECyJWh8khRKdWTPcCB8BCmzoc2BQgTTM2hnfk3YCRTpTXtPbInS0L3D5yh1NcxuZYtiNYEDN6NoXSZmu4VS2qRjA5U2KECSlXca7BBCQpfXQFk+kACmoif3S3IW3+1nmSHG8FNReVZsRRkTchgmr1CCZtYF41FbH55hcVFVvoe0mMarYjBW4Fx0VXYdJc4IbzPPu/DocPa1ZRIvN5rHtSulju7TbHV9z42pPDK8y4dAu//lSaWILRrcr7sm1r+V/uIJID2vvOopA6yFSwfFTBHgbG+dGwZjMEBTPawvyH++o8xnaTwDMzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD1VZ+0OdHK0ApNCIeHIRDfBxfb2xBhsjxgE9syi7C4=;
 b=GQ6ci7Ygd2jyIAWcmOcaCsJ7dgjDrSzsVkmqn4G45VWyUFcqeYTgmtUQthns2n568D3ch7WJkkAMuPsl6nXTyxdfKgSCgekUJ6ktSWrz759agA3ECP6NfSg6qVsjn6df1KbzqzDyTRbuosWRTlPMjE9gQgtDSiawG7UYGCCoZODLKZc/vrsV/WRDdyYVaZ3/hjIn2V8Ps0+relhH642Yk9oerWtwJgp9V4RJy5jt0paJQNqWlw6nJmGxSGH16xwdKrPSwlvrW9gwKLYg3WEI6YO/Lo1CLE0s0y2hjw9RnmmJAaZBk9lYeEKpSDyBin0PnX+upG5N5p22nE9GTo9JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD1VZ+0OdHK0ApNCIeHIRDfBxfb2xBhsjxgE9syi7C4=;
 b=PhwdRkZSwK+rUi3YIcFgp7ynMitwBvFdNXkqDbh4EgF88zCT2dqMZisQ7EfBUbDc0a4hUr5uGMC8vo9nR5/TyEbMOt2JUyhzksKLBlq9+2OHkM7SfjG1XM1k/D2p0A3G0vJoyNyB8XbKwsSGmPMrmtyoJoqv26GuWbsbnj8SM1s=
Received: from CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::17)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:12:21 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::50) by CH0P221CA0021.outlook.office365.com
 (2603:10b6:610:11c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 06:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 06:12:21 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 01:12:20 -0500
Message-ID: <c63943d0-f336-4b66-98d6-fddad60f394c@amd.com>
Date: Mon, 10 Aug 2026 11:42:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 6/6] iommu/amd: Provide kernel command line option
 to enable GAPPI
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-7-sarunkod@amd.com>
 <20260713111125.9DC2F1F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260713111125.9DC2F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 374a377e-c730-437c-866e-08def6a656d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	G8JOj22WX7caoG9KEAYUBgIVYuFw5Ok52AD7uyKtDk69cUaWyy1oXB6X6nACkDufwxsAJSTTRkRTefrc3SqkBHkUM0QrLzRFO9M6RJLFA/s6r8XUJ0Z5Bt8RJOKk1Jd+U0CrBKqMcMHzIiWaFCoZBpQINYrjTfxU8dX4LW0KpjHe61GxugNxtaKj9Wv5FLYvFHjisVNZ+/SnSvkTruI5906S2xpNW6Q8AuUggoupn09eQ6DZKn3mJPlLu9+w+zE59dcELbYmpAvwHgS40x/WJrh1vUhtS7PMYrXUheWWK6W05YdcXEyOa8lFbZgDOxa+Ltpnvm/VNaRA7rcR7kqhzSki4wx0hWjKln3vwW0HWu3/+zcD3bDXEAct4Yy4cBGYJNzPhs87NtdLK9BGsDQi0pyWbLRUxytRBh0gHgHjaZFZ5cg8BFZC48+blV4fIsNAJ1QxbvLIgrDhLQj9o+d513L8dY0+bnXcBZjIfyQpmKTo67tZUavgTq4kMWBX+dKSeKdWawvyIE3l/d9YL1fggCjBBdhd1tNh59sBl3I+N04wVAvsfdNjF+oOAP9k6wcjc54ZtjohweFP2jEEodZEq+VWe2R22pvoJO/8VrvwUpY4va8fva1rheK1gmExMTuLheYYCp+xQ4AFDchtmJvJ9OEssMPfGUzLJRHM31AJzwE333cL0ku0s9HHPRJB2/5GpWSpFogCK8ImI4gwu/QHYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VD9pLoU6C9xAxhKG0DQVOvLB5R1qUpuVsdMaJFXaqfkZjxnDA2kumXE9Yi3KhTUnrLNOLAsswDC5hFpA0MgC89eadl2Csv2riCgWMUIIEkfRUOfqcXDehNeahsoyuMg+zsN2xejN1abOZXQnaDnMelU7UBXnz0rpWu7pEkKpVu+xTeN45Z+UNe06rCJrEt8p6BjNcWF7GcagUyrFP0jTgg3AEpJjEOtAP2NgdsrdYUSojs2/qTUZggHn1pYg9lkT7JgLorN/PsnXSuhmvh51sxFjAGpJTQiCUMRenqxHRlP/foQ75ZMrsEcEauBZ6MZx4kAAH1YJ7fhBV/IWbN3npG7PlHUi93eX/o1a3NyRFgnJc8ljHrDho4mQWiWT0VuCV76MQwReDJaK7TbtB+ouwMoGlMRtjJ0xw/b2T4CinsfuGAWVOG3T9PgIumcFJbs2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:12:21.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a377e-c730-437c-866e-08def6a656d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020



On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Unconditional enablement of GA log on overflow in kexec/kdump environments with GAPPI leads to critical DMA memory corruption.
> 
> Pre-existing issues:
> - [High] Lockless read-modify-write of the IOMMU MMIO control register causes a race condition that can permanently disable IOMMU interrupts or GAPPI.
> --
> 
> --- Patch [6]: [RFC PATCH v3 6/6] iommu/amd: Provide kernel command line option to enable GAPPI ---
> commit 38ebc4ddc54202efd2ae74234b7ee4169af3e39a
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> iommu/amd: Provide kernel command line option to enable GAPPI
> 
> This commit adds a kernel parameter to enable GAPPI for AMD IOMMUs when
> the GAPPISup extended feature bit is set. It also modifies initialization
> code to handle GAPPI alongside the existing GALOG feature.
> 
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 2e1889f8a9e42..7d2b1c24f6ecc 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
> 
> [ ... ]
> 
>> @@ -2999,6 +3002,13 @@ static void enable_iommus_vapic(void)
>>  	struct amd_iommu *iommu;
>>  
>>  	for_each_iommu(iommu) {
>> +		/*
>> +		 * Disable GAPPI, do not check amd_iommu_gappi as it may be
>> +		 * false in new kexec kernel even though previous kernel has
>> +		 * enabled it.
>> +		 */
>> +		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
> 
> [Severity: High]
> This is a pre-existing issue, but does this unlocked modification of the
> IOMMU MMIO control register cause a race condition that could disable
> interrupts or other features?
> 
> The iommu_feature_disable() function performs a read-modify-write without
> holding iommu->lock:
> 
> drivers/iommu/amd/init.c:iommu_feature_set() {
>     ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
>     ctrl &= ~((u64)mask << shift);
>     ctrl |= ((u64)val << shift) & ((u64)mask << shift);
>     writeq(ctrl, iommu->mmio_base +  MMIO_CONTROL_OFFSET);
> }
> 
> During initialization, the IRQ thread could be running concurrently. If a log
> overflow occurs, the IRQ thread calls amd_iommu_restart_log() which also
> invokes iommu_feature_disable().
> 
> Since this read-modify-write isn't synchronized, could concurrent
> modifications silently overwrite each other?
> 
>> +
>>  		/*
>>  		 * Disable GALog if already running. It could have been enabled
> 
> [ ... ]
> 
>> @@ -3038,10 +3048,19 @@ static void enable_iommus_vapic(void)
>>  		return;
>>  	}
>>  
>> +	if (amd_iommu_gappi &&
>> +	    !(check_feature(FEATURE_GAPPI) &&
>> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
>> +		pr_warn("GAPPI is not supported.\n");
>> +		amd_iommu_gappi = false;
>> +	}
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
>>  
> 
> [Severity: Critical]
> If the system is booted into a kdump kernel with GAPPI enabled, could this
> lead to the IOMMU writing to stale physical memory from the previous kernel?
> 
> When GAPPI is used, iommu_init_ga_log() is skipped, meaning the ga_log buffer
> is not allocated. However, if the previous kernel crashed with a pending GA
> log overflow, the hardware's overflow status bit remains set.
> 
> Once shared IOMMU interrupts are enabled, the pending overflow status triggers
> the interrupt thread:
> 
> drivers/iommu/amd/iommu.c:amd_iommu_int_thread_galog() {
>     amd_iommu_handle_irq(data, "GA", MMIO_STATUS_GALOG_INT_MASK,
>                          MMIO_STATUS_GALOG_OVERFLOW_MASK,
>                          iommu_poll_ga_log, amd_iommu_restart_ga_log);
> }
> 
> This calls amd_iommu_restart_ga_log() which unconditionally enables
> CONTROL_GALOG_EN:
> 
> drivers/iommu/amd/init.c:amd_iommu_restart_ga_log() {
>     amd_iommu_restart_log(iommu, "GA", CONTROL_GAINT_EN,
>                           CONTROL_GALOG_EN, MMIO_STATUS_GALOG_RUN_MASK,
>                           MMIO_STATUS_GALOG_OVERFLOW_MASK);
> }
> 
> Since CONTROL_GALOG_EN is re-enabled without checking if GAPPI is active or
> if the log memory was allocated, will the IOMMU resume writing GA log
> entries to the uninitialized physical address left by the crashed kernel?
> 

The IOMMU driver does not evaluate GALOG overflow status bit unless
IOMMU delivers an GALOG interrupt, which is not possible when IOMMU
switches GAPPI mode.

Thanks
Sairaj

>>  		iommu_feature_enable(iommu, CONTROL_GAM_EN);
>>  		if (amd_iommu_snp_en)
> 

