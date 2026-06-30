Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D724221721
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798654; cv=fail; b=SaIChwYNrInMjWe2LJfFOk49KodP/igHRWKHOlS7+XejE0/kJ4JZ51+yHUSMx7X4T0L4DnvI0tIHpGf5aLapfRh699/Dzm9KgEzzocpcTnhxqtTTUGtF4XXx8paXumKI8EXdyjbNNVlnxlyuOzgef/nL0nJGQFoHrLv5A+11lH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798654; c=relaxed/simple;
	bh=zZ1/zThnYd7iPXA9tspoXEZpC1ZovgRoFt7TKnz4aH8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o0WSSZ7wgY/Ec9PntFNsYdFizfvCSdUEH19+H0SAFujpERpWmRZSXGmUKwPmYbFZoITAmRfTfgcc3UQhErDHIC2L2n7eT/PHMhoYk5fwmIjiJeKYwd688RkOeWwQqJkFQQ7OcI5gqnEhO+qBWm7LoZnBvOmD00tCmmxTFN2A3DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEl5/05+; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEl5/05+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNaRVFg9zD4xts6Gw64BXeDtf9lE7Wb2xTdn8TNSkFEwomqPn/+e8YlAF6/uYbFHju+DUCyt0xFemNJbPFya8k4bfrW4q39Rjc1M+uHUxGoPMAfRLTm0OuOW+UkmHsLY0ox9I+UEOS+iItfzrs8eUJP5ZPozfLaGWTX7eHfgJIXJBccN7MG19uvz1wKZsyK8B07hEV5rypuaBEiXbT0YUD+vrN0dDr3cycGgYTaoHqclJqibd2lrjkTQMzDZd2/S6tPA4TnfquSRRPF6mvAHuqWw56o8qf6OCNwvY6Ce0wqkfLPmXpE1UqLPsi9q7dWkfAjskUxrSulTc02ErOjYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN3kIxpJaoyFHrY6LnH2C5pDDG/miJy8/WhUVJil/0U=;
 b=svl805Pqt1hlwxfQT1z3cCKVQNZjO44J45GBwBpzp7lcfJfwBxBsxD0LbqncrqlO5h2daJ5tVAVKAmQzDs4r/TFDe4xoI63AzYWacXPgQXhrZOb1LkTSPj2lVzRSQ+1S/yc2BeG9WsD+Hrquur6pS99z6QhhJrUtcDupPCpesQF48czhxrL2KnNvlfYydj6Nrqp3j5hHNmDu3Yexs2evhNKJ4dF5R1qDli+lO664sz04Ttw5WXvpJrl1q+zGN9hsNZJf8nasTa572fqOLZbtOTQwvNX9ia8ySiptKMTmtD1BDUdKAYQMQsLbcjjJCE8giq8K+YozTZsXqLz0EMRRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN3kIxpJaoyFHrY6LnH2C5pDDG/miJy8/WhUVJil/0U=;
 b=PEl5/05+JjVd4SZ/CYy7zKluPuCUWSI2hKLPJKFZWlccn+41SCjDKWzzwL0V92LZ9U2dRnJox0aGQ90PhE9FoHX017/8529eOIMSvNBGqRgwRnY2ICsAKotkYfPJH4HWJVi6iJk1z9vzjP3nwjuBDuzXFGtIDArNdLooBn+t6NQ=
Received: from DS1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:8:457::14)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 05:50:50 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::a6) by DS1PR05CA0003.outlook.office365.com
 (2603:10b6:8:457::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 05:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 05:50:49 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 00:50:44 -0500
Message-ID: <ff1cf59b-65d7-4c85-a813-a81945f3a8a3@amd.com>
Date: Tue, 30 Jun 2026 11:20:42 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] iommu/amd: Configure IRTE to use the GAPPI for
 posted interrupts
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-3-sarunkod@amd.com>
 <20260626112941.EC3D51F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260626112941.EC3D51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: b0279f84-c79a-48cd-4c0a-08ded66b8a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|4143699003|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	+QEDAsrCbFhVt/H+eXF5Z1dbpoiRA088shhklIEDHWawG+llNwDv3CAsAtqhnLNHRO2NiRF+1WvHLxpHD/qZ9jPEWgLqfX7KQBt7lHMBdTOCczWi351E30LANTHJJ6rOjMYCHPuMbMHyfnLoJr++KKJWfU/fJB1FxuUEX4UeBNw/4sMv5/XFlvJ4SnJqLMBW3/h2rhNXJNdbLBRrVJmEXd1rL3RrxhcJZ1luo/mhT91my70Hwc7bXTyx9+DHA2AtK5UHHtHY6RJ4FDYkLm3ApWWhlYE/8C9U352dQ660LCgmhjP+axyzo8tbiMfrr/Qol6WLvdhsID21lq13txouGH34Wa0PSn6i856sdwODr+hLkn6rMKJdCFH6eOY9WB9UqofqchH8esFdkH2Pq6G6tEaeX41W80bYKOrg3QZynLfxPUgSU7srH3kEKpc1gSe17S6PBM0aGB/29UfRQTkejOdAqCsE8/kieKZHKLud6PXCOxwZb0ho1ot3sFe5yzcRJv1ksyOUnSGnHDC4sGpqSEXzkY/b3p1E96DZVfxED0jXZYnO8/V4F1WdgV8CrcJmsHVrF8mVYhn2V/epVnx5KSEn8RX4fAgdllQLedBnORnc01097E+PTuPOTX1mY7VYk8Jv/o1EQLf+e+4GPp+pxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5uTtwxr+8zbgFAYJ8IRM0AVkiT1cOLETwUoqAnHDFOBDGHAraJsUTJpiUzr4s1X0E4VPuE7wb481jLVMn6Y4P9WNDpd2o6xxGwLZpjAJitZNAkpTWQMss/9y71NWwnrBK6WeFZn8DIqikVVnOtKY7v8HjK/Lf3kFiER1RW/Yj5UsZHH8J5QmpUuv9lQg5uiuHCn0nTk3ryCUuiurnerrCz9GwUIw6cbBDSlZOXYFWIxrLVrJtBtEQ5znJ2b2DYfUPaB/zGhuHhxB217XbVfVC/PNBpo4bept2KR1n07kr3yLeY189ChlO++NCkqQ+9HotFGuTbJXu90j05T7XEim7FJe5nAae7EarnmhlOsnoPpuBmpIOL23Hq8LZa+sdXNrhRTnBFGwnu9d+Yse++k1qZZVZ7QgSScUfBBLpQWsbp8R+OnXXeEPhaBrnQz6Stx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:50:49.9692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0279f84-c79a-48cd-4c0a-08ded66b8a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814



On 6/26/2026 4:59 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `amd_iommu_update_ga` dynamically modifies the `gappi_dis` field in the IRTE without issuing an IOMMU invalidation, which may result in permanently lost wakeups.
> --
>
> commit f265b23208b1df21d27bc13bee3b5f94ce45d71c
> Author: Sairaj Kodilkar <sarunkod@amd.com>
>
> iommu/amd: Configure IRTE to use the GAPPI for posted interrupts
>
> This commit updates the AMD IOMMU driver to support Guest APIC Posted
> Interrupts (GAPPI). It configures the Interrupt Remapping Table Entry (IRTE)
> for wakeups using the reserved POSTED_INTR_WAKEUP_VECTOR when the guest
> is not running.
>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
> [ ... ]
>> @@ -3969,9 +3969,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid, int flags)
>>                entry->lo.fields_vapic.is_run = true;
>>                entry->lo.fields_vapic.ga_log_intr = false;
>>        } else {
>> -             entry->lo.fields_vapic.is_run = false;
>> -             entry->lo.fields_vapic.ga_log_intr = !!(flags &
>> -                                                     AMD_IOMMU_FLAG_POSTED_INTR);
>> +             bool posted_intr = !!(flags & AMD_IOMMU_FLAG_POSTED_INTR);
>> +             if (amd_iommu_gappi) {
>> +                     entry->lo.fields_vapic.gappi_dis = !posted_intr &&
>> +                                                        check_feature2(FEATURE_GAPPIDISSUP);
> [Severity: Medium]
> Does this code need to issue an IOMMU cache invalidation after modifying
> gappi_dis?
>
> Since __amd_iommu_update_ga() is a fast-path update function, it appears
> there is no subsequent IOMMU cache flush when gappi_dis changes. If KVM
> schedules out a vCPU (setting gappi_dis = 1) and then the vCPU blocks
> (setting gappi_dis = 0), hardware that caches the gappi_dis bit might not
> observe the transition back to 0.
>
> Could this caching behavior lead to permanently dropped wakeup interrupts
> and indefinite vCPU hangs?

The gappi_dis bit is not cached. See the IOMMU spec [1] section
2.2.5.2 Interrupt Virtualization Tables with Guest Virtual APIC Enabled
"
When virtual interrupts are enabled by setting MMIO Offset 0018h[GAEn] 
and IRTE[GuestMode=1],
the fields IRTE[IsRun], IRTE[Destination], IRTE[GALogIntr], 
IRTE[GAPPIDis], and, if present,
IRTE[GATag] are not cached by the IOMMU. Modifications to these fields 
do not require an
invalidation of the Interrupt Remapping Table.
"

Hence we do not need to flush the IRTE after modifying gappi_dis bit.

[1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Thanks
Sairaj
>> +                     entry->lo.fields_vapic.is_run = false;
>> +                     entry->lo.fields_vapic.destination =
>> +                                             APICID_TO_IRTE_DEST_LO(apicid);
>> +                     entry->hi.fields.destination = APICID_TO_IRTE_DEST_HI(apicid);
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626105906.14577-1-sarunkod@amd.com?part=2

