Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961A3C13E6;
	Wed, 11 Mar 2026 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225691; cv=fail; b=dllpZfSpnUdjItejoBX+nnJ3d5qqqWhVino8agPbYp/ozRlCoS5l9JfYcGLEK0InsZmNBwX7/vGxiOhPNAMAemWd4Zzohm33hCV04t3js0r1Gbrp4yUZs9v+6M3KKUgyd6tsMgFlqugUNSIbsXwToRE7FwfT5Lv2wACIgDV0FQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225691; c=relaxed/simple;
	bh=y3kQ6WqKxhmp4m/LNpoEmgqfgA0QWXzSuRmpWFzRovk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iywXQeWB42xAfW/YvtzaBANsHo6X2H+OjnVA69N8kjd/u7i4UQytOplaoDPgI9sX+G+D2SRXVWj6WG1yKJou5dtfa0LUCesflZiSdH28KXG1ejwBCanhGKX6Hj2NCuB9+VCNxg+H06CxnInC1lTUG3xYw76xCZTnEpuNCl5D7rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QiqIanVh; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QiqIanVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VptzUKQupElyrbI/wKylZlv8iy8KPRvq7NgUb2mivGXclVYcBsBk3hCj3FMY2MUPQD4wILACPDo93n+rCqyGYZW+6hCJLjDbiqvuuqSeKUZJe2U+n22CEhdUTBQp9WoJqXjIYslgBJVROyBWjSbuEU1ZmMrJ/4yxEuMszFt7+XESZK1VKB9+guxAjXNECWNXx3jkNgD4SjdcdtU6MI4qk34Z0Bd2gRxp0V8FUPfwnM/1coeYuqlRFX/Ox5EcSqo08mHPzhrXcWKnmh9WebzB/7cZKka1f6EnpJvmrbtqDcBNhRD5/dreqGANoLZo8p1m48jVs6zshWeOJK717+B8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjWtgPYMJ3Eu3814rxW7AwIrisgNGqAoGzr1mM90Jic=;
 b=kbo6dQYAYWzYGwAOmv0Otw/czvfb1ywDj36xAVkksSDJ8Gj/1ccxR86hFPlpIY78M2q3wYfJ+kFLln+wyk1Q6zB8ZpvE4ns9cGubFF5/r5mgNRZj6ANrRf5yc/RqQnK4bcV4yrVYxvguSUOZIyAmnlUiVj+U2quJjw2A9vxAI7NumxctULqeXY8nfDmHYDWfVud+bDqNW5kkmg41CQOJBqjXXcMEZ8puDlQDDFumLHeDIyMElJoCBBC2ZKu49gl4e6Qub6eegd8vEWhDbO6JJi8RIU68FxyEIal5tEq/6TjcX4xhJ+RBC/tJR59EUGzMFdyaRFLG2N8i9zDwMeAweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjWtgPYMJ3Eu3814rxW7AwIrisgNGqAoGzr1mM90Jic=;
 b=QiqIanVhbWzrLfRcJPqvxqeL0Mbn50OA/OtbdruCOt5oU1M8TVMGxVR3nIEo6/MOb5dbk9S44HHlKRck3Y9u1/4KPd4WBTgh9Tld+cb/isWJxpOUIGqtXVW3GKzGFdpdiCs5kcSSHGbs/fPlYGmqGhqj80e57Sr8rqpb5ncx7F4=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:41:23 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::95) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 10:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 10:41:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 11 Mar
 2026 05:41:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Mar
 2026 05:41:22 -0500
Received: from [172.31.177.76] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Mar 2026 05:41:18 -0500
Message-ID: <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
Date: Wed, 11 Mar 2026 16:11:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c09202-305f-4861-6781-08de7f5abd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	X0G1XxpGaGi7nNmNaDBSuBz84DG16m8J0XtPO0QXLlkwD7M+/PPSX+cgXctyoLO8pSAYyBJsjaTtApA3uega9hVTdMJLbTn7GqGqKlqIV8P1F/TL04z9WbQRUrvWezZK0vvLP7VJ20b1Am+gpDsPfYb8MzRFyfTwk19rBT3LAbz38ZB1klyIPbDHBFF+77gpCvqOvwDmQc6CSLamZtU6GMXKG/qNP6yLemtCSt5flzYK1lbFwDDqrWvGR78bO1nC6nckX2xeFzkRZ7hJGimEYhEtMvVHo/Mt5xft+N4NwB0q26p/zMGVP/NrVYbpd0bS9dC2EUvJsGFUhZe9+OgQAHYTAQRK7HINn0j4GL7HYqQcfSgjX2J0YDywtTdF9pjAK5kP/BPqEYY3iiHk5ymTvPoI9JYXq5ViOE96+TkxJlEQyGlAyrKjk46uLAYwDQ0bAO4iy71hoxRldWadUkK96UCsvXu2zmwI1ipxRw8HqQDrXowXeQfxV3z2ZM2An8AcefhC4okDQxAmhIEchPPDdRPIDu1CVy3Nzd9RTCIrDeh8iI9wJCSncRMzkuRi3V2dKx0p+bqaspxZTkxqEbgrkbmbZIdIlXFDyh8R6t35fAyRFroBSXMOaBIJiU/PjZqLFVGheQ7byUC1ykPlh+K4oGROdKezWZtgCtiqrxMir3Q9BSgFi2q0Qgm5UBBVcO1c77RxW2bgqavhCnwrKwQju7lGytj4w6cNT+1OXDkUPc57eofoRc48+yg3qiHEicjtluiyw0Hk+SNASTNJEPtcZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9x6LJ07A8rCaxu3pXr+LjlD/r+ydqTVlT3YG+inb7jm1QmcKcNTmkYWFSOptUvaGsyGQkutRxibfZkD4pW2kf7ky3iniNg0N7eyjiRWpufGXE9NO+fdn45cxDZb3cMPxJ6G4Kaz2EpZMTS6dWS8VLauKorjW1hwSRRLHSQpZZVtBuc6/aAvZAYAWPSBIMsaJAAuRDJPPf/3V+jkuPtkuzUutJZ7BdlM67Ffmg3yVqfHnRwtdkI8xWO9HriPnmh3B4MryNKcSx6O5UDhfbufy4dLN9+fNcnMv1MjSINSfybzaX/9Lim2WO1hjDX9cwQ09DIAdEO74nKkStQpVolKnnm5zXArbYx0Zyi2FL7f11vhTZn7SfW1/4AoovXyYeY9FMVjknWkMgqOqsZErH+JDH4VnWUM7d3nbyNCz1a1MCEWSgzeZ2itNmpOJYibeW0gl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:41:23.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c09202-305f-4861-6781-08de7f5abd36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32


On 3/10/2026 12:57 AM, Dave Hansen wrote:
> On 3/9/26 11:40, Tom Lendacky wrote:
>> The SNP guest is dying in __x2apic_enable() when trying to read
>> MSR_IA32_APICBASE, which will trigger a #VC.
>>
>> If I set CR4[16] in cr4_init() then the SNP guest boots fine.
> 
> That sounds pretty definitive.

Thanks Dave and Tom for the help to uncover CR4.FSGSBASE implicit dependency.

> How does this work on the boot CPU? How does it manage to get FSGSBASE
> set up before __x2apic_enable()? 

The boot CPU doesn't have FSGSBASE enabled before __x2apic_enable() either.

> Or is it on the early exception code, which might not use FSGSBASE instructions?

Correct. The key difference is timing relative to ALTERNATIVE patching. I added instrumentation to verify this behavior:

  Boot CPU sequence (without CR pinning disable patch):
     traps: trap_init() ENTRY: CR4.FSGSBASE=0, cpu=0
     traps: trap_init() AFTER cpu_init: CR4.FSGSBASE=0, cpu=0
     arch_cpu_finalize_init() ENTRY: CR4.FSGSBASE=0, cpu=0
     identify_boot_cpu() ENTRY: CR4.FSGSBASE=0, cpu=0
     identify_boot_cpu() EXIT: CR4.FSGSBASE=1, cpu=0
     SMP alternatives: BEFORE apply_alternatives: CR4.FSGSBASE=1, boot_cpu_has(FSGSBASE)=1, cpu=0
     SMP alternatives: Starting ALTERNATIVE patching

The boot CPU enables CR4.FSGSBASE in identify_boot_cpu() *before* ALTERNATIVE
patching occurs in alternative_instructions(). This means 

  cpu_init()
  -> x2apic_setup()
     -> __x2apic_enable()

executes unpatched paranoid_entry() code that uses RDMSR/SWAPGS instead of
RDGSBASE/WRGSBASE. Due to this, boot CPU does not have this problem.

  Secondary CPU sequence (without CR pinning disable patch):
     smpboot: start_secondary() BEFORE cr4_init: CR4.FSGSBASE=0, cpu=1
     cr4_init() ENTRY: CR4=0x10f0, FSGSBASE=0, cpu=1
     cr4_init() EXIT: CR4=0x10f0->0x3318f0, FSGSBASE=0->1, cpu=1, pinning=1

Secondary CPUs boot after alternatives have been applied globally. They
execute already-patched paranoid_entry() code that uses RDGSBASE/WRGSBASE
instructions, which require CR4.FSGSBASE=1.

Currently, secondary CPUs get CR4.FSGSBASE set implicitly through CR pinning.
The CR pinning disable patch removes this implicit setting, exposing the
hidden dependency. Without CR4.FSGSBASE enabled, RDGSBASE/WRGSBASE should
trigger #UD.

Note: I also verified the root cause by disabling the FSGSBASE ALTERNATIVE
patching, which forced the code to always use RDMSR/SWAPGS. With this change,
SNP guests boot successfully even without CR4.FSGSBASE set early, confirming
the issue is the timing between ALTERNATIVE patching (global) and CR4.FSGSBASE
enablement(per-CPU)
 
> Either way, I do think this needs to get fixed up. It was not acceptable
> for cr4_init() implicitly to set pinned features and then have the CPU
> boot code come along and do:
> 
> 	cr4_set_bits(X86_CR4_FSGSBASE);
> 
> It all basically worked by accident before.

Agreed. The attached pre-patch makes the dependency explicit by directly
enabling CR4.FSGSBASE in cr4_init() when the feature is available. This
ensures secondary CPUs have FSGSBASE enabled before any exceptions can
occur, regardless of CR pinning state:

  Secondary CPU sequence (with this patch):
    smpboot: start_secondary() BEFORE cr4_init: CR4.FSGSBASE=0, cpu=1
    cr4_init() ENTRY: CR4=0x10f0, FSGSBASE=0, cpu=1
    cr4_init() EXIT: CR4=0x10f0->0x310f0, FSGSBASE=0->1, cpu=1, pinning=0

-------------------------------------------------------------------------

From: Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH] x86/cpu: Enable FSGSBASE early in cr4_init()

== Background ==

Exception entry code (paranoid_entry()) uses ALTERNATIVE patching based on
X86_FEATURE_FSGSBASE to decide whether to use RDGSBASE/WRGSBASE
instructions or the slower RDMSR/SWAPGS sequence for saving/restoring
GSBASE.

For boot cpu, ALTERNATIVE patching happens after enabling FSGSBASE in CR4.
When the feature is available, the code is permanently patched to use
RDGSBASE/WRGSBASE, which require CR4.FSGSBASE=1 to execute without
triggering #UD.

== Boot Sequence ==

Boot CPU (with CR pinning enabled):
  trap_init()
    cpu_init()                   <- Uses unpatched code (RDMSR/SWAPGS)
      x2apic_setup()
  ...
  arch_cpu_finalize_init()
    identify_boot_cpu()
      identify_cpu()
        cr4_set_bits(X86_CR4_FSGSBASE)  # Enables the feature
                                        # This becomes part of cr4_pinned_bits
    ...
    alternative_instructions()   <- Patches code to use RDGSBASE/WRGSBASE

Secondary CPUs (with CR pinning enabled):
  start_secondary()
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=1
                                    set implicitly via cr4_pinned_bits

    cpu_init()                   <- exceptions work because FSGSBASE is
                                    already enabled

Secondary CPU (with CR pinning disabled):
  start_secondary()
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=0
    cpu_init()
      x2apic_setup()
        rdmsrq(MSR_IA32_APICBASE)  <- Triggers #VC in SNP guests
          exc_vmm_communication()
            paranoid_entry()       <- Uses RDGSBASE with CR4.FSGSBASE=0
                                      (patched code)
    ...
    ap_starting()
      identify_secondary_cpu()
        identify_cpu()
	  cr4_set_bits(X86_CR4_FSGSBASE)  <- Enables the feature, which is
                                             too late

== CR Pinning ==

Currently, CR4.FSGSBASE is set implicitly through CR pinning: the boot CPU
sets it during identify_cpu(), it becomes part of cr4_pinned_bits, and
cr4_init() applies those pinned bits to secondary CPUs. This works but
creates an undocumented dependency between cr4_init() and the pinning
mechanism.

== Problem ==

Secondary CPUs boot after alternatives have been applied globally. They
execute already-patched paranoid_entry() code that uses RDGSBASE/WRGSBASE
instructions, which require CR4.FSGSBASE=1. Upcoming changes to CR pinning
behavior will break the implicit dependency, causing secondary CPUs to
generate #UD.

This issue manifests on AMD SEV-SNP guests, where the rdmsrq() in
x2apic_setup() triggers a #VC exception early during cpu_init(). The #VC
handler (exc_vmm_communication()) executes the patched paranoid_entry()
path. Without CR4.FSGSBASE enabled, RDGSBASE instructions trigger #UD.

== Fix ==

Make the dependency explicit by directly enabling CR4.FSGSBASE in
cr4_init() when the feature is available. This ensures secondary CPUs have
FSGSBASE enabled before any exceptions can occur, matching the boot CPU's
final state.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Cc: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/cpu/common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..f5f9b242a983 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -502,6 +502,16 @@ void cr4_init(void)
 
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |= X86_CR4_PCIDE;
+
+	/*
+	 * Enable FSGSBASE if available. Exception entry code (paranoid_entry)
+	 * is patched to use RDGSBASE/WRGSBASE when this feature is present,
+	 * and those instructions require CR4.FSGSBASE=1. Secondary CPUs must
+	 * enable this before any exceptions occur.
+	 */
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
+		cr4 |= X86_CR4_FSGSBASE;
+
 	if (static_branch_likely(&cr_pinning))
 		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
 
-- 
2.48.1



