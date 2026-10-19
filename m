Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411D48D884
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395919; cv=fail; b=MtIq9FW2wXRW7fzbuAKPLxz0z8Bfp2eh8No55sUQ2NGIBe4sqkOgaJlcIyiJxU1fnFXN7E6UDOleEOg9bo/I3AznOzdF+z9ROgJBOjSgsIZduN093vby6p6H+zq3THre4Gz5zwQdJul1c0AMyBj/Zm55BqOnEc6apWBchDv8E+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395919; c=relaxed/simple;
	bh=vjTZ7zblH48qngVv6GNb+hPFGIJsV8qj7omFqvG4ZqE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JE8s5qufFjEgiD7+VkbjY/lbinLWDZ+IpwwHHZNcH9zZeTBhoiHXAOlazigJe+wRD2hVR7KYSswanmJawvQZv4i9ZxNWBPetMl3FZBbFv09SoUf8jm2iGcbwkwywFzSIZKa9RJqcQ5dPM3jzgyPaOSY7dIiTJROMjIGude8IbBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yib0ae9P; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yib0ae9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGPXibMZowKC/uIfBawQIUKti1UbOFlORDfJDCUIUgzsnvyO8un/Cudq+g7QKV9mQ8Jq/i/p01S5yrfoHLIlukCnRtfVKZ5gzYedcdzxCteQ4dg3AC59a31kOeC6iO3mPSfg3Ib7TCX2to1aIRL0IpRGwEPDajdYAEA/CbgEA7TGYT50/oaXBjp3wNXCiUcr5jfgOAgt9ZRAja739nFTk1/DxPWwxv4a2YB5Jun/rJd2k+rl3GGRgoyY8gLyh9rLDDz7QXeb5N4kIQfvZApScMKUya2D0+8hydfIFXs3T4DXCvIxPuHeMIFua+ybw9H7ve4Nr3WXkQUAVow0AYwqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM7Jdtu+HmnU8PW26EP/MnbYIobd5zsbVe+h/ktfqf8=;
 b=qqR1/3sRJ/8ejqGDCPDa2/dU7eeE4bb+G6CugkLVyIAclAF9b/8oGjXGf9NWEgH1OzAt+St6sPQHZ/584MnajvjI1NmZpqwh5GTTbiQNDeXIMglg6j7lIhKnRr4vgkDM1RyqS3OTU8tDYUqwtD8i8KEapM6MQkkcP8fGRiFzCTVU5MLPfRdJM5blouKmw6auUDzckEoiDJ3NblmiECU1u1XnFYhBV32VBRz11xkYnU5E8Arj6IXz1lUYGlEPEu4ZGHM3vQak0rVSgek3gql30025XCJomBuU93KS8QZR/cS7qI8W4IEBqP/cdtz0zcbzJZz2yCi3VNZyq9xf4KXk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM7Jdtu+HmnU8PW26EP/MnbYIobd5zsbVe+h/ktfqf8=;
 b=Yib0ae9PEYJtD5QYh728ql6BqmXcv9P9anS/5q39ZnOAy0sytuCpteKsG88AP7APnZ+fsdaORKvD5k6m1sBxnZ45c7Id7w0trp2iT7Nh5gpIWOj0rs4xc8md1cy4gmZsvYQKNtxizTKCi6Jx3XN4URyNbEAUI5XoCmmX9PwsdvU=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 07:45:15 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::18) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 07:45:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 07:45:14 +0000
Received: from [10.85.34.241] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 02:44:57 -0500
Message-ID: <134cdce2-ef41-4d23-9972-d184e73b2e42@amd.com>
Date: Mon, 19 Oct 2026 13:14:50 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v5 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-7-sarunkod@amd.com> <sashiko-outbox-172379@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-172379@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 963d7c74-95d8-42cd-f933-08df2db4e958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zb3Fmq41UQklEc39V+e+RFxjHILET7NWRXAw8igGGoeWpMK7X5Wdg36erTCKLGtn62gM1UKBVW7OQVezu+48k2AbcZNJKZLraWEDByyqJJ7tIElDMtLXTZ9JNNbos/gfDJNvH7Y/mGJ22aFs7GeQd9w1vosmn4FcfXevdbK7ItGyM58hgkRwKLwxm1Y737/KKxuQJf/uxvMPs6fRXf014bxDe2yXFs4OA7a/G27an8x1mFfm9DEh/GnrM9lCkZavCCuCMBViCXntod/++ahZTU3FnJlVeC0lVnoQs8GGNH9RDjAmsRkQ+eXWSvoYW4PIFZfQt1HBeU37COQUIOpWVx2VLnZo3TLE63CFfN//HrD26nvxKmtwnRzbyiizAUF4qr8L9eKYtLBDmuNsSlI8MYXVhaHWaEJj2JNGo9R4vonh4nddNrMQ34roK36zB0FXH7/gdKnTpx4brGO9bgmTmWwsKFzb5NJAFMXcgw+vgnM4xiGcZf6BnLIYVWjNgwjvkFTR09YwbwWh4vu/Zd4qmmRacqkTcteBXnjeRwbBA1Q+9UZONOB9a9bZwbyQLTEKJWOfBftlG5v/kI80NgrSIGyf9YnnajEgnALO7eUNyCJUcwTgCvXqaIYcL1kHO31hpjHrBBR376PxVj9B+pnD7PhKb7MaHVZe9/jCSvdtz1yTY7mg0L+9M6CaAnYWFrRcxyX+X90yIFZ5JVywcXwUlg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OQQq7NSENs1w2MOoUlvMdKgFiHEw9s1JsUwGRYMOBpBGQ5VEHTd8AuEZNJvVng5KacdHHAaOsNajiUr8DR82B/gcKUuQSvg8BmRd94H4Tj6fwZZMntbfnGHms2tfgob8vxgcpdN4GPMcx3mxrOAB+x6TOfcEA0V6aDtLr7qkeoAROuqg4dWsz0I69BTf2tcoFYpZvfLI45dO/v647WtT7199tExeyikFPHDL24wTplVJY4q6Puj4bBCPTDhN3SbsTIyOsJ1l05YrkYMQVqrPfsFvg9ZV5l46UC8JX8WDSb3CsTC7T/INjxv7sL4Qx4unXvE7Lwjd4IcNuTxx9NwdE2Oi5EnGoWdo3DO/EgaDQDL0oSeNe+HSovZYdYTWgZkCiMVat3GrwZD9uGMTJrAECqqvha1q6F6jaHOJzSSHQYegMvGCas2O4ByMt43OYVsq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 07:45:14.1394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963d7c74-95d8-42cd-f933-08df2db4e958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093



On 10/15/2026 12:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: svm: vCPU leaked on GAPPI pi_wakeup_list when AVIC deactivated
> --
> 
> commit cd7fa3c00904984a2127bee934d4e48326ead7a8
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
>     KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
>     
>     With AVIC guest-mode interrupt remapping, device interrupts are posted into
>     the guest vAPIC backing page by the IOMMU. When the vCPU is not running
>     (IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
>     path uses the GA log.
> 
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index 8b1fa5bded3db..054b89c3cb0f9 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
> [ ... ]
>> @@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
>>  };
>>  
>>  static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>> -					    enum avic_vcpu_action action)
>> +					    int cpu, enum avic_vcpu_action action)
>>  {
>>  	bool wakeup_intr = (action & AVIC_START_BLOCKING);
>>  	bool is_running = apicid >= 0;
>> @@ -1027,6 +1047,14 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  
>>  	lockdep_assert_held(&svm->ir_list_lock);
>>  
>> +	if (amd_iommu_gappi && is_running) {
>> +		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
>> +		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
>> +	} else if (amd_iommu_gappi) {
>> +		apicid = cpu_physical_id(svm->gappi_cpu);
>> +		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
>> +	}
>> +
> 
> [Severity: Medium]
> Does this unconditionally add the vCPU to the pi_wakeup_list when is_running is
> false, even during AVIC_DEACTIVATE?
> 
> When AVIC is deactivated via avic_refresh_apicv_exec_ctrl(), it calls
> __avic_vcpu_put(AVIC_DEACTIVATE), which in turn calls
> avic_update_iommu_vcpu_affinity() with a target apicid of -1 (so is_running
> is false). This causes KVM to add the vCPU to the pi_wakeup_list of
> svm->gappi_cpu.
> 
> Since AVIC is deactivated, the IOMMU falls back to legacy mode later in this
> function:
> 
> 	if (!(action & AVIC_TOGGLE_ON_OFF))
> 		WARN_ON_ONCE(amd_iommu_update_ga(...));
> 	else if (is_running)
> 		WARN_ON_ONCE(amd_iommu_activate_guest_mode(...));
> 	else
> 		WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
> 
> Because the IOMMU is reverted to legacy mode, it will not send GAPPI interrupts
> for this vCPU.
> 
> However, the vCPU remains indefinitely on the per-CPU pi_wakeup_list because
> subsequent context switches (via svm_vcpu_load()) ignore deactivated vCPUs and
> will never call kvm_pi_disable_wakeup_handler().
> 
> Could this cause KVM to unnecessarily traverse the leaked vCPU on every GAPPI
> interrupt targeted at that pCPU from other active VMs, wasting CPU cycles and
> risking spurious wakeups?
> 

You are right about this, it can cause spurious wakeups. We can simply
skip list operations during activate and deactivate.

Thanks
Sairaj
