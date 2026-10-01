Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE484BB263
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860879; cv=fail; b=b7rZJwxocOkE25pjozz5gw5pw+9YTt6grYKAF0V/20KVH2xzHLONJ6PHTc7q+CvosmQX1HMvWVr1bYbucxUm5+GAahWnza332JxJY6OGWcs//UpH/Co0GZKaZwIgYftKTd+aZhijTRJaPyYqHZ/eGIZJc2QwcUsvyNADJ/7bGoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860879; c=relaxed/simple;
	bh=u1P33HFPgH28GVl4vtKKR2enGdTVpkGF51xuMS8n1lA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbnXgYFnDY/yhsQ4gbcUZV2m+JbjfQcQ9HfO5gcARrv9IfDApJGo8pVHvathr/xHR9Nz/BocR72n88doV+kS0pdSE7O1UOb+VtOhm7GX9FdrZKuqL0DpdL+BNvI/cnU1pD3uFVA9F0p3Xcf2IeQOWoLPIcOU5K1UFNsc655EK50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YJyNbsZm; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YJyNbsZm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1D0Pl3QcKO0IcRKgSo6AZDjazJEKvDz0IzB3Dpa2WqWLQG1Me7Ui3lgaAccsIdCqX+1G7spHqwZ00FdFzyRdSUo4W/lSdmV+ksBJko53fuqqi01csxaImQQx8nCIw1+6MneJETU3iF6uiqaOrBvgArk/hNixqUt4LZjXyTm00AXzr8J3yRQkRm/ey5KtgZAYuj9h3MvCRcMTMa2IWPzELaE+ENb1biaZRkEWUQdFW2as9zX884Cs253I15K/YeIYAW5u7hr5LF+bGV/XLSr21qa+OgmnJM7AzKKSozsHMMRQ7yMydgUch2NiXK2EJGLLBoHsFx3j1GjT/qXD2ADsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNRJ7T7tt964iHwKkEV2A7CAUcyosQggMwmQxKUPXCE=;
 b=e14jP2+A5ZkdETFHjLCmu8WgFvslDdaj7O1iQMCcaboujU2V6jZmGoWztoDUy8Fsx8vmJcl5SzegLMU50790IZPPjLQ//NbtWxIJBV6INQoVSS9RXEIeYb6tPEVaImLzlYYGrZ6HammbPhReHU3e+nYJbMEJdx4UfAR5vqV7fksFOgJgNd9hExZl7Xibi0rEE2irA7Qy3SJ+CnhKo83lzDpe9CVYoxzfYRWIuDyNxHgd4D8TepveXkGdAylcIwc3dkjxfMRGCm6TcgSZ7q+bV2JD8liiT2eTv3+zp8RE7qcwCc//JgTDG8g+z2urgCAyl/ZQvaTcs3TmgRWPmMHq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNRJ7T7tt964iHwKkEV2A7CAUcyosQggMwmQxKUPXCE=;
 b=YJyNbsZmsZz/QbdhaPDKzzCOh62g14dbOWB+A1oyyg/REc9DBcg+xrD0oSQi+ik23l2fn7O5iEL63MeR+MN8hV9dbHZA4EdfQ/1H2tbVqITJMVA+l3JW53XWiG00KiMmXs+soMmYC3sn95PjOV4n/vai8FPAdiBYgmYG3KEuw5E=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 13:21:14 +0000
Received: from BN3PEPF00022BCB.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::75) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 13:21:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCB.mail.protection.outlook.com (10.167.248.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:13 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:21:09 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 5/9] x86/sev: Forward trapped PMC event-select writes to the hypervisor
Date: Thu, 1 Oct 2026 13:20:17 +0000
Message-ID: <20261001132021.254270-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCB:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 908d2768-7990-4aa3-31b9-08df1fbede04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|260925021911599003|260925022911599003|260925021311599003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nRl8FWv6cXBWwnbzCReAFid8K3KSP5hwxDBP2YR77c+dz8BlxavUHRtZPZoV8V17eWsp6wQAxVT5O0RSTLOBNFTkTole9wwVclpxTJaqdbOIpAuaddXKzu/0xzyQE60LBHkbznV/yAzTxmEhi+PW0/0YdDgY+5rJXmLtReeh2n+zz6WnpfHcVDtB2WmZk2CjuHQemQymdpLZC7zEuO4BW7PJJxDzraT4m79JJE9z2QlnoQxyYgCq+nFeSiC7BI3ntvvM4CYN/hGjMZCyQkbdWPToGxXIpaHo5qy92U9OayUeenHS/x+GVs3ETcLroydIiizPX345bRWGh71MmzEUuJmM8wtrXV+JaHsstSCGRJcTxvYDD/EPSYnKjaQbhXuRbNXKlB5OXpYFDWl4kl7+D6awwbwEm1rNW107nFD1ouRXr+ZsD2K1z4n9zoFbOEbD1PSvwPg99PT5NJurJaJGhHtyl7KjdzxiumntcuOFQJuXI86/tgpNq6GeI8KLvruN9sdqKHoLahCazGco9ZQUqbViCJpf2bapN0miJJfFttB6/U7s44GFQ5hOyjeNI3tAorDQcaS6SMUyU/8lmmK7qKKrgLgd+bQTvVuCpwfAqHi6j+DYMlreUOk3CciWfqBm7jMH1/IBZ1+CytKooTfTqqP0jZ/Prx/MXf8HfxBIjMIKleLlL4r6yNIdN5Sxbb1hrN0ywjs2iQBGx/5RPTkcfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o+8Ai1njH+50NWWrClSwO7m5eMAt9uTkycrPBF5dDbuaJ7R1RDckttoSoxlgyabhIEokzIST6MRszmJQFTwOlkIc5VzephRzVUFt1nzoPW35Vx1OVzjVcZt5q9kVWczz9wGH7IqnJdtq1Hfv/3To+6XgS+CSFs2fg8XLIoEFfZBBPNzRKK00M2OIuUhWYq+neZQ6Sid2E9Sf/38Q88Wf+9RDQDwjF2v3VIb+CjUB8m3tB4X/DqtzPnOA3tHskgldjBjWzCqUH14F3TFMl5gZxY3eR4mAtRqZ2j05tH6BFn3mVDJFy60JaEwuGdbO7iXFzhlGsBwpkGuaKu1uPJMYQORsCuIHtdFBpap4eHv67PHkktjI+QwZlCezHK/O82DjxuIzi1MJru0B8wvJ1GI+gJiCHe+Ut34kxGPz7wxJh3zu1shek+xIHinMH4eH2/Ne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:13.8218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908d2768-7990-4aa3-31b9-08df1fbede04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684

With PMC virtualization, an SEV-ES or SNP guest writes its event-selects
directly, and the hypervisor filters events in hardware: a write that
enables an event missing from its allow list raises a #VC.  Forward such
writes with SVM_VMGEXIT_PMC_FILTER, along with every event-select, and
program the value the hypervisor returns.

Write the requested value ANDed with the value the hypervisor returns.
This way the hypervisor can only turn bits off, e.g. ENABLE for a denied
event, and never turn bits on.  Turning ENABLE back on for a denied event
would trap again inside the #VC handler.

On a PerfCntrGlobalCtl write, first write each event-select ANDed with
its returned value, which turns off the counters with denied events,
then write PerfCntrGlobalCtl.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/coco/core.c          |  3 ++
 arch/x86/coco/sev/core.c      |  2 +-
 arch/x86/coco/sev/internal.h  |  1 +
 arch/x86/coco/sev/vc-handle.c | 68 +++++++++++++++++++++++++++++++++++
 include/linux/cc_platform.h   |  8 +++++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 989ca9f72ba30..d8249a3acb605 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -107,6 +107,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_SNP_SECURE_AVIC:
 		return sev_status & MSR_AMD64_SNP_SECURE_AVIC;
 
+	case CC_ATTR_GUEST_PMC_VIRT:
+		return sev_status & MSR_AMD64_SNP_PMC_VIRT;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 60a0403898e4f..8b89725290af1 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -756,7 +756,7 @@ static void *snp_alloc_vmsa_page(int cpu)
 	return page_address(p + 1);
 }
 
-static unsigned int sev_pmc_nr_gp_counters __ro_after_init;
+unsigned int sev_pmc_nr_gp_counters __ro_after_init;
 
 static int __init sev_pmc_init(void)
 {
diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
index b9632c0fc3916..78486007d22ef 100644
--- a/arch/x86/coco/sev/internal.h
+++ b/arch/x86/coco/sev/internal.h
@@ -6,6 +6,7 @@
 
 extern u64 sev_hv_features;
 extern u64 sev_secrets_pa;
+extern unsigned int sev_pmc_nr_gp_counters;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 96b62b49b2b53..7486762969f63 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -33,6 +33,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid/api.h>
+#include <asm/perf_event.h>
 
 #include "internal.h"
 
@@ -368,6 +369,63 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
 	return ES_OK;
 }
 
+static u32 sev_pmc_eventsel_msr(unsigned int i)
+{
+	if (boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
+		return MSR_F15H_PERF_CTL0 + 2 * i;
+
+	return MSR_K7_EVNTSEL0 + i;
+}
+
+static enum es_result __vc_handle_pmc_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct perf_ctls *ctls = (struct perf_ctls *)ghcb->shared_buffer;
+	u64 eventsels[AMD64_NUM_COUNTERS_CORE];
+	struct pt_regs *regs = ctxt->regs;
+	u64 val = lower_32_bits(regs->ax) | ((u64)lower_32_bits(regs->dx) << 32);
+	unsigned int i, n = sev_pmc_nr_gp_counters;
+	enum es_result ret;
+
+	/*
+	 * Disable the counter first, so it doesn't keep running an event the
+	 * hypervisor removes from its allow list while handling this request.
+	 */
+	if (regs->cx != MSR_AMD64_PERF_CNTR_GLOBAL_CTL)
+		native_write_msr(regs->cx, val & ~ARCH_PERFMON_EVENTSEL_ENABLE);
+
+	ctls->num_counters = n;
+	for (i = 0; i < n; i++) {
+		eventsels[i] = native_read_msr(sev_pmc_eventsel_msr(i));
+		ctls->counters[i].perf_ctl_idx = sev_pmc_eventsel_msr(i);
+		ctls->counters[i].perf_ctl_val = eventsels[i];
+	}
+
+	ghcb_set_sw_scratch(ghcb, __pa(ctls));
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rax(ghcb, regs->ax);
+	ghcb_set_rdx(ghcb, regs->dx);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_VMGEXIT_PMC_FILTER, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (regs->cx == MSR_AMD64_PERF_CNTR_GLOBAL_CTL) {
+		for (i = 0; i < n; i++)
+			native_write_msr(sev_pmc_eventsel_msr(i),
+					 eventsels[i] & ctls->counters[i].perf_ctl_val);
+	} else {
+		if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb)))
+			return ES_VMM_ERROR;
+
+		val &= lower_32_bits(ghcb->save.rax) |
+		       ((u64)lower_32_bits(ghcb->save.rdx) << 32);
+	}
+
+	native_write_msr(regs->cx, val);
+
+	return ES_OK;
+}
+
 /*
  * TSC related accesses should not exit to the hypervisor when a guest is
  * executing with Secure TSC enabled, so special handling is required for
@@ -426,6 +484,16 @@ enum es_result __vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt, bool
 		if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
 			return ES_VMM_ERROR;
 		break;
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+		/* Odd MSRs are the counters. */
+		if (regs->cx & 1)
+			break;
+		fallthrough;
+	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+		if (write && cc_platform_has(CC_ATTR_GUEST_PMC_VIRT))
+			return __vc_handle_pmc_msr(ghcb, ctxt);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 559353ad64acb..5b98a357f3e20 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -104,6 +104,14 @@ enum cc_attr {
 	 * to run SEV-SNP guests with full Secure AVIC capabilities.
 	 */
 	CC_ATTR_SNP_SECURE_AVIC,
+
+	/**
+	 * @CC_ATTR_GUEST_PMC_VIRT: SEV-ES/SNP PMC virtualization is active.
+	 *
+	 * The hypervisor filters PMC events in hardware, trapped event-select
+	 * writes must be forwarded to it.
+	 */
+	CC_ATTR_GUEST_PMC_VIRT,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.43.0

