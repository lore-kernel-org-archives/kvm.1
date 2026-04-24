Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E59D531;
	Fri, 24 Apr 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777006651; cv=fail; b=mqkzuRFpQNeTHXpf0Kmi8/1XUH4izuhbOwYuPNkIvHwawTSKcKIhX5omN4DBKbm5ZM794iarZmq7U7Kgf1ZXdh4iEMQmxdOGvACKOvHL424sVr0D1L4T9ZBiazNPWDy6xYbYkt1vNLLeC1QrnP9nbDvZswe01ICdDAGDfwJFDvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777006651; c=relaxed/simple;
	bh=lvw2z+7FbxSylJIsRNSAo7+EhcEVdDmHE7yoBBGrXNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qm5lDMSPdnRJV/KnxwoA40sY/1oMLdjsQXQIo9jQFRMKdhY4BEEPxd2KoGBKweL3VJwbJZM+CURD+zk5kZhtmH3rNu4sNkVG+cGeD9MP6Gf8OGWfRk44nOkrCbpplyC9CZx1OpK4ftaZmj8jjp5orl7O4tFPWh6IGwSCkEhGWI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/VoQiGa; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/VoQiGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDfAXMPI7E7qsmAQWE0yxhJUa3lHzhzo+dCC8jM3J/Ar9Cr5KQPj0xeZF9l+nc4W50No6OKQwMuBqPRSci1IgM7WiI+WmSwAQYoLu+V770+JG/KfJ8eBMU0uu8/YWv0h5BmP8kaSuD4890s+XJ1wCLzE8MHTQ3VmDBlxOg4BVt8lXMuFNyvUvlHqwXS6oNVVv8xClH9dm3WUviCc/syIL4JidTyGwuHvZfC72ScESirlJnFviSP9vMIaecVwWSNaDwiCr7NKrAauzd9+01U4hmNOcBcZfy4oz35V5ePRC8OMb3v2L0l6Aoe8vdHniZh2Jud70VER9u3FJ8ErOoGuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xckzwv7GbfsU/9VVdcHNWBgN5vR6fWUN+Z5wWwk5u6s=;
 b=N+ix2ArhP0Ru292UPmi54V6Eu8oBjG7Fbjs+q5PWzsOWlZQNY48dwyqNdLQ+KTGbPpYVu3FvuB61tBDVY5ASS9gRb8ybWI+5V6F4HeRQUEPeklEsnnwrxX0AnCMbOr8MqXcrh/Jk08WspRvcCrl+53oYI00odF3tBQfNQbB3T4KFxdFQDcg1K4O1oO7fi7Nx5Ju4/WblAFdLfVYhY0xhUSFFOw37fO/Dp4kbhEAgmT5QSwH3PkQv7V+kLAWY5m9MpitW7DR9vymz6ewWIxXHtg2ON77gYnpY+eLj2q7MLoV7FZ87KqKyBDtJ61jYi9LmqluY4Uq0qG7X2VBM45BSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xckzwv7GbfsU/9VVdcHNWBgN5vR6fWUN+Z5wWwk5u6s=;
 b=a/VoQiGaWS9HEmbcrbS9k1bWrhzsEcNsEoi+4KEPkL+3P3Bc3ldi/XJswhtMCcC3xWVUUE1lKsEJ6v+LRbyUq5+Wpxkj/mh7/URtTnoNxLJFunIAYbRDa4DnRGONCB7k9Xx8CffXAnTXjOJVHypSXuMJnv+J+AUNFF4NBXCzjD4=
Received: from BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::12)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 04:57:23 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:5b6:cafe::5d) by BL1P223CA0041.outlook.office365.com
 (2603:10b6:208:5b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 04:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 04:57:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 23:57:22 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 23:57:18 -0500
Message-ID: <31128d13-40c0-43cf-8eee-6b7b30b20562@amd.com>
Date: Fri, 24 Apr 2026 10:27:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] KVM: SVM: Enable FRED support
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 84894b92-11f9-4da0-e320-08dea1bdf899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|7416014|1800799024|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	baP1GkB5tOz1cIHktIhu/tIPqyqyNQB6EwiNg2rpPSmzqM7L4ghdR3Fe1xWKaoKfXSSl8hHOcQRSryvLF9Dhbydv/o+SGP6LmF1Db2R3DC1GcKjEwW7Rp72VAWAehSSgk4OSG1xBX7zMn/lT1CaREt6yKmhh6P+L2mzVm6P6/0chNHzV+ouq2qxQoicjVzVTybAgcj9D5CLWTk/7NQ+5crM4gW8ObDMLlHmFnMHgU7xbLb1ZFc+XvT1xAPA3qBhFFpPKrAC7x78KKc57wQCeF0yklItH+jmeGPi+/nqEWcIhiVNJdqHrCwGw+gco2kk5SRrL1AG9DTB7dF+7K8+OeY/5GaKlv4l1NYFbLm6InULqyTP7xBxBW4wpPRNTRhMHfw00raQOiDdSL7zvfQPsFPpDXagTf8Cq6nyuGiS5SVnRpk6FH5zh8ww1OPJXnLowtoax6UwdV1yOTuWNGFms6kgP5Ggnn3i+bLxYCnB/mNfjIgm9s7I9sXgyeoI0GAvpPpg4TISUMXNhJzFOX4iwm0xr2MbUmezlKxvx1kFqO7jPzMCjcfOcNLTbzcf1ZR5B2/EwaK3dZe9TK+U2nP8nb0WAalyFmKpx7CghJ/7ze9roYwgz4zYXUQlEj7ukwxeqy5znwNgMaGYbmYFxoSUDxKuKKxX/1HLVOTSiVclcaH2uf3MYIxJ3wM4SLpmHHyw8bbnqX8hhvQOi3r/Mzroo1EO41sqKvb19iR5tVU1L9VfO+s12jVMYdNfs7rafW9ccGljsC15KP2/17Q+kc/TkTDBmLlnP6O2B9YwR5MdRTkY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oeSQIm7zG597/mu6Wm5CVNuT/5DcIHUHKMythyaYiuNCkjyrjMHPMC0Qa184Nla1Y9xiqMvwJivFTMgjMSenEU2fKXiPwhTsvzuAfsdBWYsLSoXYxp79tPgtllT4IvzyIJLG8ST/vVp5FpOcQgVW7K+3LmnJtKcEHdkQJ9PgJnm54KmzikXRhUaSJ3ivfq4fWj4TKtLhOkY1/JuLZeTkwQCqw1FmY1VL+nwwwDS8mKKVKpiuxyJcGfKvbDuYqWEXs6MED77r/uUyZoT4ktDyO91sy6pVYZG5KtuEGu+r9hc8yq9M/Foh4mbCDD9WFUCPsp992N5onK9KYYAEyRWILJm6ai8/Eblad5HJzVzRB7NyBzF49IRV2Br0iuk8uR9+qreCsK8gPtC+l6QjuenS3x2hexzVZxbYplNOjgvYIBrJafYhfc2z81o8xXLORk5L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 04:57:22.4474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84894b92-11f9-4da0-e320-08dea1bdf899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

Hi,

I'm planning to add another patch to this series in the next version. This is
related to dependency of FRED Virtualization on NMI Virtualization as mentioned
in the vFRED specification [1]. Any comments are welcome.

[1] https://docs.amd.com/v/u/en-US/69191-PUB

Thanks,
Shivansh

---

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4b270490b2fd..f1fe407ea5da 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5379,6 +5379,9 @@ static __init void svm_set_cpu_caps(void)
        /* CPUID 0x8000001F (SME/SEV features) */
        sev_set_cpu_caps();

+       if (!vnmi)
+               kvm_cpu_cap_clear(X86_FEATURE_FRED);
+
        /*
         * Clear capabilities that are automatically configured by common code,
         * but that require explicit SVM support (that isn't yet implemented).



On 03-04-26 00:12, Shivansh Dhiman wrote:
> This series adds SVM support for FRED (Flexible Return and Event Delivery)
> virtualization in KVM.
> 
> FRED introduces simplified privilege level transitions to replace IDT-based
> event delivery and IRET returns, providing lower latency event handling while
> ensuring complete supervisor context on delivery and full user context on
> return. FRED defines event delivery for both ring 3->0 and ring 0->0
> transitions, and introduces ERETU for returning to ring 3 and ERETS for
> remaining in ring 0.
> 
> AMD hardware extends the VMCB to support FRED virtualization with dedicated
> save area fields for FRED MSRs (RSP0-3, SSP1-3, STKLVLS, CONFIG) and control
> fields for event injection data (EXITINTDATA, EVENTINJDATA).
> 
> The implementation spans seven patches. The important changes are:
> 
> 1) Extend VMCB structures with FRED fields mentioned above and disable MSR
>    interception for FRED-enabled guests to avoid unnecessary VM exits.
> 
> 2) Support for nested exceptions where we populate event injection data
>    when delivering exceptions like page faults and debug traps. 
> 
> Changes in v2:
> - Modified the zeroing of FRED MSRs from INIT to RESET and updated the commit
>   message (Sean Christopherson).
> - Used guest_cpu_cap_has() instead of checking VMCB bit in recalc intercepts 
>   (Sean Christopherson).
> - Variable rename from 'fred_enable' to 'intercept' (Sean Christopherson).
> - Moved FRED MSRs save/restore logic from svm_vcpu_enter_exit() to 
>   svm_prepare_[host_switch/switch_to_guest]() to reduce some MSR accesses.
> - While switching to host, added a safety check on guest_state_loaded.
> - Removed the need for a new function parameter 'reinject_on_vmexit' in 
>   svm_complete_interrupts() (Paolo Bonzini).
> - Replace variable 'nested' with 'is_nested' (Sean Christopherson).
> - Formatted variables in reverse fir-tree order (Sean Christopherson).
> - Gate all the FRED MSRs through guest_cpu_cap_has() while dumping VMCB
>   (Sean Christopherson).
> - Confined the enabling of vFRED to svm_vcpu_after_set_cpuid() only
>   (Sean Christopherson).
> 
> This series is based on top of FRED support for VMX patchset [1],
> patches 1-17. The VMX patchset was rebased on top of v6.18.0 kernel.
> Previous version v1 of this series can be found here:
> https://lore.kernel.org/kvm/20260129063653.3553076-1-shivansh.dhiman@amd.com/
> 
> [1] https://lore.kernel.org/kvm/20251026201911.505204-1-xin@zytor.com
> 
> Regards,
> Shivansh
> ---
> Neeraj Upadhyay (3):
>   KVM: SVM: Initialize FRED VMCB fields
>   KVM: SVM: Populate FRED event data on event injection
>   KVM: SVM: Support FRED nested exception injection
> 
> Shivansh Dhiman (4):
>   KVM: SVM: Disable interception of FRED MSRs for FRED supported guests
>   KVM: SVM: Save restore FRED_RSP0 for FRED supported guests
>   KVM: SVM: Dump FRED context in dump_vmcb()
>   KVM: SVM: Enable FRED virtualization
> 
>  arch/x86/include/asm/svm.h |  35 ++++++++++-
>  arch/x86/kvm/svm/svm.c     | 122 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 152 insertions(+), 5 deletions(-)
> 
> base-commit: f76e83ecf6bce6d3793f828d92170b69e636f3c9

