Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DB3911BD
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338880; cv=fail; b=EGO5c5jNSfS6eZ/jWyZijzZib8i+ITdhx0AIu0GIjr6XJiQlV6+NqB0aLcRdS/AyOLIvQe/PwX+rRSPr0O8DCeM8Kn4fphHvU67nmSCilmMhTt278IlobGWT1oE8Ta985L9GRu1cKiPtrAykZxcO8xjZJn9lgEW3eJDFXFQhFcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338880; c=relaxed/simple;
	bh=JyTcuvyP05eDg5Ue4xwVDrNRSD+kiyaMQMxaQESLZcw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H2jhfdK9dPLUKkl+U9VXaQS+wFfvYppVKS3WVoJ+J3nJ02gdV0gI7KUPHw3i/PLTMbEHvilAggJacqBTtwkRk17LiVAQlIbBbGYAGkdba4XmYcKv9tMCWiF7l2gK1rvQF4xnzZYJPOwLlz3wz6wOSWGLgsi81OUl49FD/RBGy/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YcP7Ik0w; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YcP7Ik0w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMxT2BtYYHSXpc72mTnaWnhLiF/YJcTI3pF3U5zFodfQcB0HUfGiOjGKovwKqsQvzbu9ArFqYtg/U8rkVw6BukwwY+rvgsxNmicZqgKcF7CK6t7KXH+RiFG/yYfhfHCUkhBuHqHhpJeIFAEkHd69loxy7bisgsZqOLYqABL7Wt7NEC2dy6lUudOb2IMlbgQ1XRYayA+67D6IpIjIzcxQrTL4PIOEOGEkGUIc4VP68LVVJLm8Ib2ICdlF5UxHY4RrKlcwYq7TZ4hsP3qB9Xj9EXIpWk+p/fZg2QCMePgFuhBBkFOc8k6iOFKhrboF2X9O+HW5Bgh8hwcvH1qGWyC1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KocaCA6TzvihU+ao501Bnopc/an5ItknCruyyAnvVvU=;
 b=QOCCE/3uImchVdKR7+9EhbJIcjFjzwv/wM4p74eAjMHaLNL108QvhPyaaVjbOnW+8F9cO5IT7ZBFD+jHGbJ8R8cjdfnrOixyJZ2oCJktjCp4EtfPGPyLE9CWDp1yzVcxmP3KKxsYwUwuo4b2ApKjrdPsyWCvy+Dh/fzMlS8k3Hmbjq/oB7StyCttxV4mdon5YIOkmYuCOIKac5582GU+gr6bHP3e2zGfWq8oZEHFu5Kj6ZJrbQeWRR1vtcuOMiQ1VMQTCLiRP/SY9gpsYD6RtTRKa52nyGdT/OFAyu1txpWXIQPOk6DKCgUFg4AwsD26cNgJFJUpGPr1onziuUFaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KocaCA6TzvihU+ao501Bnopc/an5ItknCruyyAnvVvU=;
 b=YcP7Ik0wAjMHyccDArFaWlH65ePWCg4CgoHDyyOSU3EKZR5HOlcFXgwSEX6DsxrbjNYKdNzemv5LmHj4ew+7C0yhfNcvAQzn7nz5ih3AD6joax83wGLBrS8+hpg6lFDOcULIAisx77rA5qvcdSeLpwa+uFQ6jgL744NMyxWRBKA=
Received: from SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:14:33 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::96) by SJ0PR05CA0140.outlook.office365.com
 (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 05:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 05:14:32 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 00:14:30 -0500
Message-ID: <86d6bac9-3820-44a1-ad2b-c7e35b9341c6@amd.com>
Date: Mon, 10 Aug 2026 10:44:28 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 4/6] iommu/amd: Program guest-mode IRTEs for GAPPI
 wakeup when IRTE[IsRun] = 0
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-5-sarunkod@amd.com>
 <20260713110754.9B8351F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260713110754.9B8351F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: b7821dcf-0c3f-4841-8cdf-08def69e4331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|11063799006|10067099003|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6K5TQe2UQhlwpC+rPCpaH2XFMbjs50smxpLaSQriXluYXlA2zmXEWEgroQJQrICFjlJfOtJ4lI+vzCCbLsMjA5F9XQO5Y0mNJYV19Ilh97I47pgKo0FFsOPO+rOAzPiRujL4p6wFsSqva16/NsX8UexBynzHdw4iFu7CahHJZemrAo4zoiQZRNX5R+J3WJCTXR8e+GmDWI8KFqhRc4e9EvBKJ28cjAdFNquvaAwMhb0JGW11Q2fomXezV2YF6GdIWAwYGuwPhR6uFjeE5x+maUDP8L7JZve4lBmTMZ4jbP03pvBSA7zimmJZHPvjBJX+l02/jvecD1JG6FamsCEBa5nhpDNnfdpvDYS2Cob49EVJvtUjyutNkijuNOyrHOKNTCGWdg5rRo3uEVLB3SH2EFpw261yGDlxSahkC0MsVtqWi2/Rgovluu8D4ONh7Z8Ctlmtyt+L6kaNBhz4TWPzcD95h1Naub7qhGAJmhUMG0QLSLCxEP+dm6q4IRCBHRPjfrDhSTIw3CFcjswmERVHf4mSFX+Yml0JtDHcRtI+ClA/6iRx1WoNUdS35mdUJdJ5ZmOttfsHqJm/KTKAnForUgC69oHKG7VokCyRC7X2MAXwJserab+yyFl0nZhI00EHNSbl5InlLb7bmOpauspbVTVd/OW+3SqlgYxNu0vvyFaoyQ357Pz2c3GN2ZPGUi8w77Ax0/oqTS0FAKtlj6zK6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SXiur/dbOJ3j5TfS2ob4dDQNcMTWb9kUf9m8/NeTu//DkCjAf6s5EQ807f45bEGg76b4gy7WrgXRj/nS7aDQMoU+rh57zyT+hSBjDD89IsyZ/B2M3wHv04Y7Et2DNlVpREnt+N5k18I/iLpLxP7pBDPoe8Z3VYCbRVw1VYJ1zyqTk0FVaQk0LvS0IhVJQmW8B3PBtmipDZLDTioHzB6AftoalO6ejNpwiyLHItS01XnlTp6z9VcJmOtQyjcEusPQGFYx9zI5pUokAyi8nL4hWMX8GHVF6SaQrfRHl3AnxVgMP68afPMoNxmoa/E+QQYXcA5ZoPOVCUqfz7uPj9d6Yx2E+XFVPzDHGlDoSUEl9WMr1emVc/DlUETmyf3heMXGtf2SLYTiYXi+cL6B5nFFMpawcmoaJ6PQZsrNMbzEA305ZpY1f731S649nxnIVvp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 05:14:32.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7821dcf-0c3f-4841-8cdf-08def69e4331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720

	

On 7/13/2026 4:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] GAPPI uses the lower 8 bits of the IRTE `ga_tag` as the host physical APIC interrupt vector, but this tag holds the guest's unconstrained `vcpu_idx`, leading to host CPU exception injection.
> - [High] When GAPPI is enabled, putting a vCPU into a blocked state configures the IOMMU IRTE with a broadcast physical destination APIC ID (0xffffffff), causing an interrupt storm.
> --
> 
> --- Patch [4]: [RFC PATCH v3 4/6] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0 ---
> commit aad2d4e0f82cbce4cf0a8e8b65994633202311a3
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
> 
> This commit enables Guest APIC Physical Processor Interrupt (GAPPI) support
> for the AMD IOMMU. When a vCPU is scheduled out, it configures the IOMMU to
> deliver a physical APIC interrupt using the IRTE destination and GATag
> fields to wake up the blocked vCPU.
> 
>> Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
>> GA log for notifying the host when a device interrupt targets a
>> non-running vCPU (IRTE[IsRun] = 0). Per the AMD IOMMU specification [1]
>> (section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
>> interrupt to the CPU described by IRTE[Destination], using
>> IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
>> backing page IRR as usual.
> 
> [Severity: Critical]
> KVM constructs the ga_tag using AVIC_GATAG(vm_id, vcpu_idx), which embeds
> the guest vcpu_idx into the lowest 8 bits. This unmodified tag is
> programmed into the IRTE's ga_tag field when a guest mode is activated:
> 
> drivers/iommu/amd/iommu.c:amd_iommu_activate_guest_mode() {
>     ...
>     entry->lo.fields_vapic.ga_tag = ir_data->ga_tag;
>     ...
> }
> 
> If GAPPI uses IRTE[GATag][7:0] as the physical APIC interrupt vector, and a
> device interrupts vCPU 0, will the IOMMU deliver a physical interrupt with
> vector 0?
> 
> Since vectors 0-31 on x86 are reserved for CPU exceptions, could this
> regression allow an untrusted guest VM to trigger a host kernel panic
> (e.g., #DE Divide-by-Zero) by firing an interrupt while a low-numbered vCPU
> is blocked?

Currently GAPPI depends on the variable amd_iommu_gappi which is 0, and
is turned on by kernel command line parameter in the last patch of this
series. So IOMMU will not use vectors 0-31. In fact next patch sets
ga_tag to POSTED_INTR_WAKEUP_VECTOR when amd_iommu_gappi is 1.

Thanks
Sairaj

> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 91405e71b3c3a..7eebf4745a678 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3970,8 +3970,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
>>  		entry->lo.fields_vapic.is_run = true;
>>  		entry->lo.fields_vapic.ga_log_intr = false;
>>  	} else {
>> -		entry->lo.fields_vapic.is_run = false;
>> -		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
>> +		if (amd_iommu_gappi) {
>> +			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
>> +						check_feature2(FEATURE_GAPPIDISSUP);
>> +			entry->lo.fields_vapic.is_run = false;
>> +			entry->lo.fields_vapic.destination =
>> +						APICID_TO_IRTE_DEST_LO(apicid);
>> +			entry->hi.fields.destination =
>> +						APICID_TO_IRTE_DEST_HI(apicid);
> 
> [Severity: High]
> When KVM blocks a vCPU, it calls amd_iommu_update_ga() with apicid = -1 and
> wakeup_intr = true.
> 
> If apicid is -1, won't APICID_TO_IRTE_DEST_LO() and APICID_TO_IRTE_DEST_HI()
> convert this to 0xffffffff?
> 
> Does this regression result in writing the x2APIC broadcast address to the
> IRTE destination field, potentially causing a host-wide interrupt storm when
> a passed-through device fires an interrupt?

No, When amd_iommu_gappi is 1 and vCPU is unloaded, the SVM layer will
pass a valid apicid. Please see next patch for complete SVM side
implementation.

Thanks
Sairaj

> 
>> +		} else {
>> +			entry->lo.fields_vapic.is_run = false;
>> +			entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
>> +		}
>>  	}
>>  }
> 

