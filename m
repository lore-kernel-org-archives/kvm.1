Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F373BE8;
	Wed, 18 Mar 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820640; cv=fail; b=M8eMEuMhoHBOphet84ghN3ATT5ByAmNjr0ivWijO/q2TnSe4BwZ0mOz6pooC9/JMc+pPJcwQEijskOIKGjOBIdMedra0CpbWnQuM5FCpdVAsRb4mfotXd/0DjGebLWN2LSaCoTKD3JY+nhz82otrNgBT926pn+X3kg70PAaGC1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820640; c=relaxed/simple;
	bh=ZAzVGyBNfs5pM65azbr6Zxd71KdYfY0obdEAxAa7s3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0zf9svI71CNGmDrZQNSaVB9uV0SZb4M5OfuNtiya9LE6jpuhvXeo8bu2qV9eIo19bXInQMCsfmcO7ZzWlyCArW2mxLeoR9u1GP/VWW5k10usFy7fyICOqkWIVYPDYgQgIAy1GTffZrgKuYIgT4KIiWqGSfE/t8KdrCO4RGphZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BrZgZMJu; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BrZgZMJu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k513RkOjQ7NX64Z8mzRUe2Z+4QEi6xV7k1AQK2aff6nIfjdYcPu/OyR5V9hgYyrKgcgaRpbvgmuzHIXeoOv/Uyfyhho35B0Tv7+YTmGpremvQ0JWgM3WLV/h+g48knOFcRuHHgGsguocyiI4L+Z/2U27akrGArpCv8dPdy1MMFWsUBcWrNG2MJknXoCEC/ZCqqtxumNy+epE9PJvZw/Jk1VId8/ds+bLdO0n8Hb+UuGAw9SHCSNQ5RIRiSiIv7TPZUgBh/Lw8nwFF1NEAovW20L2rfuIz2Z65w/uWzKinapDk3QdQQGS6ai13EyXCvSN+uBoZvFKftLVAV9Ut0xLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAPHy0XJZetBZ0e2m3lBj2DwA7pfBQcwB7w/J7UJP6g=;
 b=EnqX1DzYBHDtu8NZblpiqT1+VlHnGhvuGl4oTrWaP13y5U6CPGl6Cgwmjym8BKRVddW4sxmWh4wl1FBvg4JHKPVexrozTTEu8Z/aWfQl2jFGH1vsHZND1HAUIyzyQyYFOYD64RvImq1S5bRfvqsHGcbt9zKb58toaLBenOBWD615pQfc0g4Je3fRZHbTMorM5vyl5ZOeNtDaLHekdS8AgG2vv/+1KGIqHBKkbZgK53hxSxPbDfis39nqckria57tvF1zYB797OP/Ai9SN5xqfVyxK4AQ70NMelsjN4xT1IFHsh71dpmYarj9D94aZCsvZiw6m3ARIEjTwvpqQi3utw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAPHy0XJZetBZ0e2m3lBj2DwA7pfBQcwB7w/J7UJP6g=;
 b=BrZgZMJusXZBLGvaSShJRHNlmEmAB3oep7g0klUSU1kCjO76UFqxhnYyAvhaWHD1WIV8Dj9oXT5H/VswFTfFrM3TGR4ZdU0I9mDyGKgEHMQqrcza3Id8SeP6ZFcPiq58CIg4uLBXkk3qenltmnQXSpQRCj6dsY2s2/xUDsOkNZE=
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:57:15 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::47) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 07:57:15 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:57:10 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <bp@alien8.de>,
	<thomas.lendacky@amd.com>, <dave.hansen@linux.intel.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<sohil.mehta@intel.com>, <chang.seok.bae@intel.com>, <jon.grimm@amd.com>,
	<nikunj@amd.com>
Subject: [PATCH v3 1/3] x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()
Date: Wed, 18 Mar 2026 07:56:52 +0000
Message-ID: <20260318075654.1792916-2-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260318075654.1792916-1-nikunj@amd.com>
References: <20260318075654.1792916-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 138326ec-ff22-4420-5b11-08de84c3f873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IwLDyesaZP1mWprklC6cpjPMD6V8KIieJ26Bxzb442ZbokXfEowsU5PI+LlTEuR0PcI9SvzTDY9aUw7Pi7dsEDLRefqr+rb8Tbjq7aVd734ZW+s+wXIBwVaNaZdPHKVH2Rjq3KI87I1olwDMypFENDKNwJ65ZjR4IxBuUnbczsmQRmwqSNfRHK0eresGCI7nUXO98F0lsf9TTvWsHsqQ/dnu7aVpXC2rPqIOM2zBrdopu7DNnAF2nUXLnD5b4XKi+ZhYP5Yi9yJl9baCRu/aqYAGcqB0rjDovp1sNL3ZCBXuDABho50N3CtFZ+JafknsiK9G7G1FYh96MIGWzLN1VpaGZOJyRMxEjnMc31rQ8O6eylO4FSEjb+v69YesrYFBx25bqVdOxkxgs59EuFJYdvoqHm1v3YN65hom3S5V1cyjNjPzB9Q7JhBYo+xzR8Ok4AB0gL+sm6InL6CpuOw23CW0kGc39qN/EjvF4VdPf3PLaFmn5ONdEftJvlamU9PliDYq/O/5lBa0/lR3Br6JgI7ScwoK3YqgjvlMyeIRTL1imcl+DOiOQT6DuNdxqQwK3xCmjScFGqR7DVIXIlzo8ayiGk9lCZEuu6dFJRKJxN3BOzvS9DGZfc5Clw7M7kyVq3H9WF8d2fD0YmV9lZBnM6y77Kem27brXid5Ee7BwFN0rYHqHdIJszSMA3+PlebmH3Gl4iqDNEsrq7EStwoPeIo994WFODTm8evHPKcouYlMv0eaTF98aOky1KNjZQaUGftdt/m0eMdbJcuH9h/OJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ou3tWcLq0likC57GQh43+AWaMy/eQFt8wKhso9TQg1eWPyiWrMpfGDubKJZ0UQWSFfDOTB1kp2QE25qD6TqrJKQgTI0BfVFIOXgFqdWt2GnqncOBMM2KbvrtNAc04KY8vY/O/d8bH+4s/UFd2cCAocBdjY7DkWckC00smoJYfU4pk8pwbtksf96HOX6y9evsYE+HcM68cU+RiUZXeuSogsUmbwasCxenq4eXJiunCK6z5hGmiSL4D8zUyroc50ZoPnj/moVnzZ6WMAGNa+ud+FKGPfKVxVkIIXUd2aK0XHzKrs1RvMc01S7tMMQrEoqO5GSZgKiqcSp+ZThloRAfQJ7yPL4WEuzP0pkb2EVFLah2msoj4OwyyWmfz8KfQ44nZyqIK7F5gQKNg7PlwzpvyMYI7nZqCYLu+A7Rf9urr1P1CSalKQd5hDZR1T1kAdoA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:57:15.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138326ec-ff22-4420-5b11-08de84c3f873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197

Move FSGSBASE enablement from identify_cpu() to
cpu_init_exception_handling() to ensure it is enabled before any exceptions
can occur on both boot and secondary CPUs.

== Background ==

Exception entry code (paranoid_entry()) uses ALTERNATIVE patching based on
X86_FEATURE_FSGSBASE to decide whether to use RDGSBASE/WRGSBASE
instructions or the slower RDMSR/SWAPGS sequence for saving/restoring
GSBASE.

For boot CPU, ALTERNATIVE patching happens after enabling FSGSBASE in CR4.
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

Currently, for secondary CPUs, CR4.FSGSBASE is set implicitly through
CR-pinning: the boot CPU sets it during identify_cpu(), it becomes part of
cr4_pinned_bits, and cr4_init() applies those pinned bits to secondary
CPUs. This works but creates an undocumented dependency between cr4_init()
and the pinning mechanism.

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

Enable FSGSBASE explicitly in cpu_init_exception_handling() before loading
exception handlers. This makes the dependency explicit and ensures both
boot and secondary CPUs have FSGSBASE enabled before paranoid_entry()
executes.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Cc: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/cpu/common.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bb937bc4b00f..6778ec5846b6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2066,12 +2066,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 	setup_lass(c);
 
-	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		cr4_set_bits(X86_CR4_FSGSBASE);
-		elf_hwcap2 |= HWCAP2_FSGSBASE;
-	}
-
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
@@ -2432,6 +2426,18 @@ void cpu_init_exception_handling(bool boot_cpu)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
+	/*
+	 * On CPUs with FSGSBASE support, paranoid_entry() uses
+	 * ALTERNATIVE-patched RDGSBASE/WRGSBASE instructions. Secondary CPUs
+	 * boot after alternatives are patched globally, so early exceptions
+	 * execute patched code that depends on FSGSBASE. Enable the feature
+	 * before any exceptions occur.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
+		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		/* The boot CPU has enabled FRED during early boot */
 		if (!boot_cpu)
-- 
2.48.1

