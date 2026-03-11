Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2F3E0C62;
	Wed, 11 Mar 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243768; cv=fail; b=q44joUCd1miRxmc97gBkC63POzy//q6yMLohocieb7WwPkigPqJst5uTAmEexDffE2y4988rpiZ3/oMe6m2PnSPb0dhvlkP3bBHA7n7SNarYeCB4vqa5nyKkwhG2dMyRedYUGALAssd+rg1xhdSlPjFF19FoLeBjDZPynk3t3CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243768; c=relaxed/simple;
	bh=0FWVh6yW5t6KJkLNIk7nWZxo31GHOefal/mjMTGVuNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TflirzJrvE+WIyFCyQhN9xUi6JAoWsr45yTijbUUcAn6jLZOOZUz3mnohi0bRalv9LntNoMYmTBxf/nM4GFbQb4eH7nK1ZibMVJXxV6TAlvzQh8LELk65ccXNjAVcAOt9WOSNXsQShyd6J64kUrqdVB06UiekxfsmDqDEXKtVsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sXmM3Kpm; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sXmM3Kpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9KdybSfeFIE1922eYVibzMKmss7SpbX4aTNRoZy6AmWxCFOzAELgK679XdSqaTgSPQhEk4gqdEalEnCf4CUv1yvcTasc8kMzHtUaQHwDP9luMZTNxbhWIo7vdsow87b8zBNskqZ1qXrDSMKQUz8W0ZMt9HuwC4mbwZon0gsAFrb0SqukIYF43QdWQBCjCtj9ozCpOgtfsEnnDszh2hs8TQmFqYPHT9ay8ktiW4fQdJNf28kxVQ5+oMVzJ65x1McepcajFSLh27AncR1wIxLP/kgJCLzXYC86HlXH5xNpmGrUWBHGcrj9vadVp6lGJQSSB/LK1iMPl9G9D69BFxOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qILe/AO6/RxuOPniFZKEUcveQS4QnrxjZlnj+b/6Tu0=;
 b=YV+3d/jYEinLTFqQsZUR9NAm9oYPdyovQEaTFqoarUMaIb58Lp2Db+JXnJkC+CFTU19nWiCj2Eve1yEA6LboQRX/H20E9cIg8LOc78osrqZEDeVQ+vwbdJUxGapnyZXzOA7iPfg5xNfElDQSPAfzZFeT39reoIvPQq+U14CYqMeAiBw86UWz3Q8nUyZYLpcDvVeupGqV5sm50vpdz+nIpPXcyJb8IK1iq+7edQH1yF4zPuKTXc1v4T/sUF35Wyp3ZJfyetiif7An42tb73yuod92FldDoc9+7Fyt7sR22vX9N/DGcy2Bv4E0+MFz+yYbskF8AfhTp5779dzCkjQ21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qILe/AO6/RxuOPniFZKEUcveQS4QnrxjZlnj+b/6Tu0=;
 b=sXmM3KpmnQHsMzZEuJdo6QYXfdhxJtUAGzhLcQYcF8nYGgkWfSSJLzVdL0Jh5v6l0wyjB4e8ZGm30RRYchO7bfM/s5lKEWhvaPLrA++Sxvc0H/wGZeH+IWjGKemqUeBcptmxbNkKZ9p8b1m9H83pZUOWKlfQQB1mVRXe8F9clTs=
Received: from SA0PR11CA0206.namprd11.prod.outlook.com (2603:10b6:806:1bc::31)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:42:40 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::34) by SA0PR11CA0206.outlook.office365.com
 (2603:10b6:806:1bc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 15:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 15:42:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 11 Mar
 2026 10:42:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Mar
 2026 10:42:39 -0500
Received: from [172.31.177.76] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Mar 2026 10:42:35 -0500
Message-ID: <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
Date: Wed, 11 Mar 2026 21:12:34 +0530
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
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c9dfbf-87d9-404d-f9c9-08de7f84d429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K2GXjVZraZyb+dW9g1FV8HnMuGMo/GcnxfXW81TVhGVJ4+eoCqFlrEya6rvWNOhTDD0yFOkOvOqmQlGQd0ozCal8LB+63FeSkQ2mTtTUNyUriCj0naybugQIZMJ1dgkfiTgU5mZXuiuqwIlEq0e7RDEUY8iTp8LATFjNUfmc/+QrhmW/5z+7WX11YmZbgQCjfe+asc3gisHEPoUvYwiD5yiOSBsOxmwLcE/aqu36PGEU5rZaOYPuG8Dug7Hy+sIFVmg2veN9MxTVttWpupciYEN1AO6uizOYppUloE0SCJcdOGN/zUx+N5Aa29ieBxcz9ujc0ycqi4W1ldWlgVFYOaZz39Ourz2PpC+x7o0eRmQlZf7aOz8oAWgC+3NAIbocpUOxaPJJVB9bXzhmgK3twQ1CFkicJxzSNyuRvsrkaz+4xbdOM+wduPUtO4fjVV2Mz8kf9HYUNZjfuQ4Q4SNbA4z9PPYnZrotKSxqGZthBH2i7hG7qEq9vpAseBQ5lOgTfo6ncdrgipHI2KpRGrBI8juNuRM5ExNz1gRUsEpNcPJQY97ZZ7HDmaGoKkXWneg+vqfJ9pZqsI0masdUuAKbuB4wceYtKSMAW87WCsEm4PBtLmKqq7F2yhF6KajEGBHug7UVsbpUNRgaeb8UQ1eTebeOIpl1/eb703B2nt/PghHClkjiuTIOpTKIPRiVD5yNgkop0tU1iIcI5joitDre2GmQLfVwXRURLZzNsYMoNZJ5++5q4dtZB8X7TWx+z+O1YDoSyQpsCuBXc6eXh0WMlA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IsVWcpRRf6c+exCjgotUshrEhSnc+fOrcpCZxHwZXuvam9JDHf4/u7QbAKj3kJXKpO4GLR3LpcoeW7o2Gon296jqSib47Vhdb90jSrAFd2iNwVLSYxaQAVapI2u1b+DA4KZDr8787dfaSNA+TGo6/eNJ7q7XUb0yJIK6IKfnMo/7mCWSpIscFfwLIz1EbhdkAnOt1Y1hy7plvmV0B1bTbMsCIpLR3PKdRlHczfI7EGkGZOq4jtcWq69xvGJ52qVQqrn6KH2cE4Zx5ghL+Yi/8NmJKlSCXA16QjL5NqVgrNeTQDZPE9L2DzKEGRyEYrBngj5c7vTQ9CBm/pwjASg3W+/qbCEsuE83gGn3lJ15SFJxxbpyeaKH5+xnEEtaVFw4854kM4pkRrgz3K4UjmSk1+yqcLoXVzeExkF3RZIcpO+Q5zC5LSbKem+vIoigmeWc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:42:40.4462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c9dfbf-87d9-404d-f9c9-08de7f84d429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40



On 3/11/2026 7:37 PM, Dave Hansen wrote:
> Nikunj, thanks for tracking this down and filling in the last piece of
> the puzzle about ALTERNATIVEs patching.
> 
> On 3/11/26 03:41, Nikunj A. Dadhania wrote:
>> +	/*
>> +	 * Enable FSGSBASE if available. Exception entry code (paranoid_entry)
>> +	 * is patched to use RDGSBASE/WRGSBASE when this feature is present,
>> +	 * and those instructions require CR4.FSGSBASE=1. Secondary CPUs must
>> +	 * enable this before any exceptions occur.
>> +	 */
>> +	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
>> +		cr4 |= X86_CR4_FSGSBASE;
> 
> But this still double-enables X86_CR4_FSGSBASE. Could we initialize
> X86_CR4_FSGSBASE in *one* place, please?

Makes sense. Moving X86_CR4_FSGSBASE enablement to cr4_init() and calling cr4_init()
early in the boot CPU path eliminates the double-enable. I've tested this lightly - 
let me know if this is the right approach.

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a24c7805acdb..98efbd13a5a6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -595,7 +595,7 @@ extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
 extern void cpu_init_exception_handling(bool boot_cpu);
 extern void cpu_init_replace_early_idt(void);
-extern void cr4_init(void);
+extern void cr4_init(bool boot_cpu);
 
 extern void set_task_blockstep(struct task_struct *task, bool on);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..aa07e2eef228 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -496,14 +496,26 @@ unsigned long cr4_read_shadow(void)
 }
 EXPORT_SYMBOL_FOR_KVM(cr4_read_shadow);
 
-void cr4_init(void)
+void cr4_init(bool boot_cpu)
 {
 	unsigned long cr4 = __read_cr4();
 
-	if (boot_cpu_has(X86_FEATURE_PCID))
-		cr4 |= X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
+	/*
+	 * CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
+	 * paranoid_entry(). Enable the feature before any exceptions
+	 * occur.
+	 */
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
+		cr4 |= X86_CR4_FSGSBASE;
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
+	if (!boot_cpu) {
+		if (boot_cpu_has(X86_FEATURE_PCID))
+			cr4 |= X86_CR4_PCIDE;
+		if (static_branch_likely(&cr_pinning))
+			cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
+	}
 
 	__write_cr4(cr4);
 
@@ -2047,12 +2059,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5cd6950ab672..52642908c2bf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -233,7 +233,7 @@ static void notrace __noendbr start_secondary(void *unused)
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
-	cr4_init();
+	cr4_init(false);
 
 	/*
 	 * 32-bit specific. 64-bit reaches this code with the correct page
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4dbff8ef9b1c..0f7400257ce5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1685,6 +1685,13 @@ void __init trap_init(void)
 	/* Init GHCB memory pages when running as an SEV-ES guest */
 	sev_es_init_vc_handling();
 
+	/*
+	 * Initialize CR4 early, before cpu_init(). This ensures features like
+	 * FSGSBASE are enabled before exception handlers run, avoiding double
+	 * initialization later.
+	 */
+	cr4_init(true);
+
 	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling(true);
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index db9b8e222b38..2ab0e20288e9 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -58,7 +58,7 @@ static void cpu_bringup(void)
 {
 	int cpu;
 
-	cr4_init();
+	cr4_init(false);
 	cpuhp_ap_sync_alive();
 	cpu_init();
 	fpu__init_cpu();


> 
> Also, please avoid passive voice in stuff like this. It's just more
> efficient to say:
> 
> 	CPUs that support FSGSBASE may use RDGSBASE/WRGSBASE in
> 	paranoid_entry(). Enable the feature before any exceptions
> 	occur.

Ack

Regards,
Nikunj

