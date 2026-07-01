Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723C19067C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898056; cv=fail; b=TqXscNDX8Q9e1Z9KFbk1ape4CkOlzyeVHusJc7ro3x20UsCY67y2fqR+H9ey+jg/8mu3I9aGxD9MVxQQCQePfkkKAfS2FlxNhkzJ4nWMnHnFV9WKClcOk95PaYtPd4Pc9BgHG+oDKwuROyjYU7QZ04F76xOZ3SOpWc65p8hjd+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898056; c=relaxed/simple;
	bh=1222LZD0IbxJQAP4t7Kr8gToCAclbvbIlGVr0kTpexE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nD/X7zxgr665vPToJa9SmUBckEYnt1sRsnYHl8HtG5tPcDsHz5d+T4jFL4vnIbADnuX9hZGU/UqhUZQ5fIr6TgAyQmzdWYJ4f7kwRyCObmYd8yTmtdriIlXNz6W4OLCZMFnh/MUlzP3UCrq4Cw6FVRnpjO/Bk3ogwbOssW4Fex4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OKOyEipe; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OKOyEipe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJoe2+i73vO5wCdu8H/LmfNb41NTc0bFbgJmU8nu+TsPa4m3X4S9biLr1LtSuf1LBWaSAHgHOQOu3bO8Nx0H0SNWH0Qql2uRPyMRFPhOpUreq+tu6M5bJ0NUxg4un6A8B+gqjkK8vKAlE27Gzx2eusc5xW8h7JB9v/rjm5VD7oyTI6laq4zE0vBHc4IP55AOTnmCZnh2JjRMk/QQMkaRAT/mB594G9vM6B1Cz0N3naxmSXYbngjSFe1vWOHWmNB29paxRwazrEP6Y7g7BJyVBexwf87WQvOkomBQXn6gMdYcMX/SswbSiAGHCnpn2GQVYgjt6pWCzc5WlKXgypmjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQL9Q2ZnWVtgmlE11y3D9FXignpvloN3i6Npt5y8GuU=;
 b=YzBW2MkYhO7m4/c+xP6JfadLkpqL2IjvB8Ggm0L/gjC2znPNBuxYMTG9rDDZTA+O/46Y1CVybJUwFHV8jurqUkF9tb/1bQ8umj+F8HAHlEF8HbsItusXYvYMYnBtOf1vI5ZIDQGtlxg9we3kEwqHZjrmri+7njQkVsazWSCvQASuNclnFgnCdrqnJr3rZswMZbEY1UKiNy7xs6pmazCxDf+tRzLL5XsZChdqNDLhNYHUJhtbmpIONcIZrwocr/Ej6nEwpofcyrjn9UqLAK70P5pThsRBvhND/QMDwoHJsiWFA5xAZjvzA6Mg126wTn4Wdobc1aJHcvSmGWiNsuev0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQL9Q2ZnWVtgmlE11y3D9FXignpvloN3i6Npt5y8GuU=;
 b=OKOyEipeFgwSjNOjBez07t1hXNmkumlr4kRhlzIFaO5cAhb6oZk9zg5uYIvQLL7c6ej3cxW/bSR8f5H6YN0OD/JDyS2s5wK5e9uB6iHvlQ/psXawo/hri6y+X7GTYGa2sn9Q+0E/NE98moN0QyliRqsH+t1bw79zP63YRGT+laU=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:26:07 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::5d) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 09:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:26:06 +0000
Received: from [10.252.216.131] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:26:04 -0500
Message-ID: <07317a28-cde6-4ded-86b5-8251062fb2d4@amd.com>
Date: Wed, 1 Jul 2026 14:55:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] iommu/amd: Provide kernel command line option to
 enable GAPPI
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-6-sarunkod@amd.com>
 <20260626112537.22F0A1F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260626112537.22F0A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b40f56-edf8-421a-4f67-08ded752c771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|13003099007|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	PTFwCHIALjzOau2I4xhudW/oEtF6RzADzEhIVdP+HwLOxSHQamu9y7jZa6YA2bJw1O1mJYWbykzGiIH7Vdqhn7Nfvfn4elbgmC0gGMXmw1aQpHEXmeDbi8vvb/fEcBmbcaiFpjj1d3GT0S3CEyp3On75uXiqq9iQ8m5TdjFGgJ6YrO1I5OfCTGlJd2ti6R+3E0sANE2/xGJeRiXiVOV5Zn2HuLtK6KAGj+lAo0Br9NH4mIP8kJu3pEyWZ6k+BCXWbzk41EwmGaSWlMmGcF4vqFyz3rAAPLeiSElFYXfVF6HACMD18OWdYuUQ2EOEBhHTxRFIcYJOtwMCHgekpeqsj49SVd7AoJjDdc+kIKoZxv9bRWj5y5/kIEuoTTD9Dl7jk5Ud0La/URTfzKdEp+pBVzZoikFWOlciWOHzU0JBOBBAnLKhTcuEJmOr790Y1kW9/AHY810r3VoMJiZTM2M6vybDunPiFTFeY+BORz6PVBTa6Jo7qrf4gfHLzII9kzDfrYqPn2v1UQVI8aeYdpD7n8c0SOnj4WtzNFHZ5k9L/LxxBBA88lCm6bSJG631JkIwE24P1hmkRFHyL6df8ErF/x50qBecfQAXm502zqaHbQrV7QricJZUrGSJvHR92wM6UJ4pwJz37BkxxjmmF/NzeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(13003099007)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HDzRNactijzHo+mWChMmIV27OIy5r4xKJDve7RkR9cmjapwTe6sH/VJ2qD47ibQAALsaBPd0P+DJWmBHUc2CuAqymsrT4w7ospJjlM/OGlXI0gfC7xI87mmHRt3paZ76R+OhNMZKAlun8hJ4zn8Ry8nEMc4pnKQ22jVfeqKYbj0RqeyUpxmc+0VW0wXcVNd7Ta+6QL43cTD1b5YkdMILtcN5QTEMSI7/SsBMhTyiLa2zMrD3Le/uIT6sdqiRkm1oJxnUxhTV3KzTLDX7HZ9Ih6efkw5MXxyfDUWRZuBXsq/9Ms714XkHMUCGYteuNo5o7gqXxRj5fSH6dzPoJrLLJ7lkmyvwkJ393i4dThoRps7AXZ/rxUO+ebcDe3uijnTG3Eg74wVJLpeHK6S+duo7EkxGniAphgpJtWpd0pTC/3W2DOiayG44qNhURx0ZWrRN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:26:06.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b40f56-edf8-421a-4f67-08ded752c771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171



On 6/26/2026 4:55 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> New issues:
> - [High] The global variable `amd_iommu_gappi` is not cleared to `false` when `enable_iommus_vapic()` returns early.
> - [High] The `CONTROL_GAPPI_EN` feature is enabled but never disabled during IOMMU teardown or kexec initialization, leaking hardware state.
> - [High] The GA log interrupt handler unconditionally re-enables `CONTROL_GALOG_EN` upon an overflow event, even when GAPPI is used and GA log memory is uninitialized.
>
> Pre-existing issues:
> - [High] `iommu_init_ga_log()` unconditionally allocates memory with `GFP_KERNEL` and reallocates pointers during suspend/resume cycles, causing a memory leak and a sleep-in-atomic bug.
> - [High] `enable_iommus_vapic()` returns immediately on error without rolling back previously initialized IOMMUs, leading to an inconsistent initialization state.
> --
>
> commit a43ef908c557e1883a80f54d875c75488a6d0f52
> Author: Sairaj Kodilkar <sarunkod@amd.com>
>
> iommu/amd: Provide kernel command line option to enable GAPPI
>
> This commit introduces the amd_iommu=gappi command line parameter to enable
> the GAPPI extended feature when supported by the IOMMU hardware.
>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -3038,11 +3038,20 @@ static void enable_iommus_vapic(void)
>>                return;
>>        }
>>
> [Severity: High]
> If enable_iommus_vapic() returns early before this point because
> FEATURE_GAM_VAPIC is missing or SNP is active, the newly added
> amd_iommu_gappi flag is never cleared.
>
> Could this cause issues later in amd_iommu_update_ga() when KVM expects
> GAPPI behavior but Virtual APIC mode is logically disabled, triggering
> warnings and failing interrupt delivery?

No, this will not happen. If enable_iommus_vapic() returns early, AMD IOMMU
will not set IRQ_POSTING_CAP capability. kvm_x86_vendor_init() checks this
capability before enabling interrupt posting. Hence all vfio device
interrupts will take eventfd path, in case enable_iommus_vapic() returns
early.

>
> [Severity: High]
> When recovering from a previous kernel in the kexec path earlier in this
> function, the cleanup loop clears CONTROL_GALOG_EN and CONTROL_GAINT_EN.
>
> Since this patch introduces CONTROL_GAPPI_EN, does the cleanup loop also
> need to call iommu_feature_disable(iommu, CONTROL_GAPPI_EN) to prevent
> hardware state corruption if the previous kernel left GAPPI active? A
> similar omission appears to exist in iommu_disable().

Yes, this is a valid concern. Will include this in the next version.

>> +     if (amd_iommu_gappi &&
>> +         !(check_feature(FEATURE_GAPPI) &&
>> +           AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
>> +             pr_warn("GAPPI is not supported.\n");
>> +             amd_iommu_gappi = false;
>> +     }
>> +
>>        /* Enabling GAM and SNPAVIC support */
>>        for_each_iommu(iommu) {
>> -             if (iommu_init_ga_log(iommu) ||
>> -                 iommu_ga_log_enable(iommu))
>> -                     return;
>> +             if (amd_iommu_gappi)
>> +                     iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
>> +             else if (iommu_init_ga_log(iommu) ||
>> +                      iommu_ga_log_enable(iommu))
>> +                      return;
> [Severity: High]
> When amd_iommu_gappi is true, iommu_init_ga_log() is intentionally bypassed,
> meaning the GA log memory is never allocated.
>
> If a spurious GA log overflow interrupt fires, amd_iommu_int_thread_galog()
> processes it by calling amd_iommu_restart_ga_log(), which blindly re-enables
> CONTROL_GALOG_EN.
>
> Will the hardware then attempt to write log entries to an uninitialized
> physical address, potentially causing kernel memory corruption or fatal
> IOMMU target aborts?

It is not possible to have the spurious GALOG overflow interrupt without
enabling the GALOG in an "ideal" scenario. But to protect the kernel against
buggy hardware, I'll add necessary checks inside amd_iommu_restart_ga_log.
> [Severity: High]
> This isn't a bug introduced by this patch, but returning immediately on
> failure here leaves the system in an inconsistent state.
>
> If a subsequent IOMMU fails initialization, the loop aborts without rolling
> back the features (like CONTROL_GAM_EN or CONTROL_SNPAVIC_EN) enabled on
> previously processed IOMMUs. Could this result in partially initialized
> interrupt routing?

You're right that the abort path can leave MMIO state inconsistent across
IOMMUs. For this series that is acceptable: we never set IRQ_POSTING_CAP,
so interrupt routing is unaffected. Proper cleanup belongs in a separate
series. I will keep this hunk as-is.

> [Severity: High]
> This isn't a bug introduced by this patch, but calling iommu_init_ga_log()
> here unconditionally allocates memory with GFP_KERNEL.
>
> During system resume, amd_iommu_syscore_ops.resume calls
> enable_iommus_vapic() with hardware interrupts disabled. Does calling a
> GFP_KERNEL allocator in this atomic context cause a sleep-in-atomic bug,
> and does unconditionally overwriting iommu->ga_log leak the previously
> allocated memory on every resume cycle?

Yes, This is a known issue in IOMMU driver, which leaks the previously
allocated memory for ga_log. Cleanup for this one also belongs to a
separate series. I will keep this hunk as is.

Thanks
Sairaj
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626105906.14577-1-sarunkod@amd.com?part=5

