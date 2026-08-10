Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E362D592C
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356656; cv=fail; b=QuoxmG9EiNYd+j1xIovL/W8XQ4ZlHb8feocy3QV37Svf9XN6l6fiPxnzgUlCFpy+sfbx3JjrznOcRKYkHSrA2wY10qz0sQxPZE0NcEAlk3Y5Jh2J6ZI5MY0XO6TNaQJHPNMMToQxp53tK2sqDICmYd35FLjvjNnkDsb1Zw3bx+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356656; c=relaxed/simple;
	bh=7eSEXaxkiEc9WStjnV+sG5i5ca428HJblDgx50bnK18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WW1o3AJw7Z0VOt+uOhPDAzCuc0bhVTgUjXMdsjHZQR/bT42dWYgZFNi7fIP43VUqOZ7EGS4qTJeEAG6Bi7/JyE49f/7EVgD6L0GWr/ZUQvjixAhZZ7DydQu6d/5eH+dlI7xOoyaHRW9vOLO9PtHpzc78k6DoYsquJuQSfLC60ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asdbq/DR; arc=fail smtp.client-ip=52.101.57.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asdbq/DR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/sReo253jZhS1ZdLi4tHMwwy0dyR7x3PA/7jUe7UUjoF79Rh+TZ6hD7a/+aWI/msK/Zxt3ZRy26cyAoVYFjRL+zPcpB2rYEaw5Ukc6JJmVCoZsirSlFD2KGohYy082PVQDgXzLxkXfSFflaNkkY2lp2k7iz9p1x7DixQjJC32NONjzZFC7uWNjbZe1YlSSwXjqIPJXyOifvslMaBw7SREB10waMuRfVmAx9xfpsnP4Sf5P9lyi9XGnId3gQimUcSOHmO23+X0x4WcrDGTKU1McwQXTIYPVmwflw6NTvtA+dJ3Oo3YO/O28ngB8sJ4N3mRqhxxn/lR87IQczkepGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSDSxf2WDwWh3MZjkgT1R+wxPZW9UGCr7JcXwMeeeA4=;
 b=I0M/xmFIW0JMnPjA8dgB4EPltDr9zKFsgSPw6Lg+b69KTix/OkWx0dORaKY0aCymeh+EJ2JWHq/ohrCRC9RG+YgvD7TKQCqZUM6ilUCKTmEHgALdKUJv5xFm1QkmrxPwItbgAEf0lPC8fkIbLYPwLWf03iCP+RY68hPRayKBVPBr88/QbtQ8seBc6xl+J1oKKhYC+UeKBwYxdjwLTf2zssk5/T+GsPlyiiPPurZtyvjQU54I8icxpETuausP4oK9mFogRCNYL4mcg/MQhQ5NB8WZQobwOpYnF1CKGS8RITaip6FdGuagPFFhsC5/oyE6KLnT2PXhsaL/KOYELYuFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSDSxf2WDwWh3MZjkgT1R+wxPZW9UGCr7JcXwMeeeA4=;
 b=asdbq/DRnPox1IWmOt4sElm8deoA9xU8EQ+IwAsE1aKzg0m7VwuKp6Apvg3U0p9ZW1rqhek7FGasQMhTeX5UI7PL7VFyxv+fGb61xcnIHtKUmVmFixqMoFZoaIppb3Re2YdelzeSq9CHQP4SlAJaJypqSH4xdEb/N2kdJIYA5HM=
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:10:50 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8d) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 10:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:10:50 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:47 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen
	<zide.chen@intel.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, Manali Shukla
	<manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [kvm-unit-tests PATCH] x86/pmu: Add option to raise NMI on overflow
Date: Mon, 10 Aug 2026 15:40:02 +0530
Message-ID: <106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6919e0d9-f5c4-419f-c780-08def6c7a7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|18002099003|10067099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nhepL/Q4H7gIqN++RbMmRpmhF7YTN6orNAKIHO4467q9w53jvrA+AuwGi5ByLXiYhKx5i38M4impxRZrmddA3jvVVHDND8IVRMI4K8Nq/4DuiTxexoEqHrgXJE3SIt422tKSaxW1DoGWrfckbFjW90wnhkR8U1cnGRAGT57R5mc9GUnFfqXBSeuuqJF6dvalh9sqIX1qywaCcBMw+gYCQIMSc/criciSwjguTCF6JFPZNdQF3ZbLDHdUXbIqc5jOQbsZkaNOszbprDBEsmpE09pgnw6RDKbw5LbIUKNpEDc3LilN1xOzrLtRKB/tr6tt4ZGF1LKNv+XLMGKu5dFpbXXz2ZPfS7YvWF9S3hCOE4X1ytGg8ieoVWPjlGp9+dbSBKX++VBQVScYRdHiUuKWd6xBqmiVvt0CY0cQudX06OnrYK6J5H3b3FPBnDvTrXJ9I7CT/nRIa/nB3YJGLAWZY9qq40K+J3qhNsI5ry/q7tk/jAzUXoV+sGjRxmYJXAYTqI12W1iOoPhG2aT7Hs5B9t5sQVKC/t0AKCTrufz1RXynH/NXOD7dlqFFfitUmsNn47DYnWU3SPbloUPP+F433Z3SIgALSvRORcv7l/E6DMTFxTzh9H1E2gTwuzC1GIBqd+07M3lknoSVR03tbuaS67IFs51IvgXnCTfhiRx9ATNiOG93kKoMVkciXGWzXrF3fEwrht5j3QxWAYKfYDkKdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/x9XNpKDKQ8uLl2ymQxXPV8AaID1CBTwpjAx7Bb8dInupWez+wvMBzlmYuEHBD6rARm4erIfimjXOsQWnEA/2TDiniXq5eltuBUaWrkLxb9qeH/RgiVaM9vMw+n3EPYDrMqR1kOADy4+CQvkh/nfh0WC+byIO9BQKIhCO1tABPrpOP/Yq8WyUzRYvorE9EV4YnvXHwNcXKExnX6M9yVz3rqfBh1tx+5ZsykeRxydjC0xvmQVh0yGL3IuRzYzB0NeZXQRl56VRBuG63JkPrJc3Up5DElgKK72adxNV4dVdLM6UowFAmRKXJNw4OK8Eo+RHRolat+CVilzdDYbP5mv5PKZX3zqRiGJWSsbe0UzuEybfqUcdkqYopGgU4BH1U4EFE0sUtIerBgUMeh29GdoFB7mYEXpFwSXalgehkWHHFm2PBcaYm3/LSl0B0cM/ohK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:10:50.6457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6919e0d9-f5c4-419f-c780-08def6c7a7c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

Interrupts raised on counter overflow are currently delivered through
the PMI_VECTOR as regular maskable interrupts. However, for some
configurations, like SVM with PMC virtualization and VNMI enabled, the
guest LVTPC is ignored and the interrupts are always delivered as NMIs.
This causes the test to crash, as seen below, because it does not
expect NMIs.

  Unhandled exception 2 #NMI(0) at ip 0000000000400326
  error_code=0000      rflags=00000056      cs=00000008
  rax=00000000001300c0 rcx=00000000c0010202 rdx=0000000000000000 rbx=0000000001019f58
  rbp=0000000001019ee0 rsi=00000000000f4240 rdi=0000000001019f58
   r8=ffffffffffffe000  r9=00000000000003f8 r10=000000000000000d r11=0000000000000020
  r12=00000000001300c0 r13=ffffffffff6768f0 r14=ffffffffff6768f0 r15=0000000000000001
  cr0=0000000080010011 cr2=0000000000000000 cr3=00000000010fe000 cr4=0000000000000020
  cr8=0000000000000000
          STACK: @400326 400de1 401715 401e51 4001bd

Add an optional "nmi" argument to improve test coverage for such
configurations. When passed, the LVTPC has the delivery mode changed to
NMI (APIC_DM_NMI) and the overflow handler is installed on the
NMI_VECTOR. Otherwise, it keeps using the maskable PMI_VECTOR.

Unlike maskable interrupts, which stay pending until EFLAGS.IF is set,
an NMI is not gated by it and arrives as soon as the counter overflows.
Clearing the interrupt count after the counter has overflowed therefore
misses the early-arriving NMIs. Hence, reset it before arming the
counter so that overflows are counted regardless of the delivery mode.
The downside is that all future users of check_irq() will have to
maintain this ordering.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 x86/pmu.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index ea31a7a3..236c39b9 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -250,23 +250,27 @@ static void adjust_events_range(struct pmu_event *gp_events,
 		gp_events[branch_miss_idx].min = 0;
 }
 
+static bool nmi = false;
+static u32 lvtpc = PMI_VECTOR;
 volatile uint64_t irq_received;
 
 static void cnt_overflow(isr_regs_t *regs)
 {
 	irq_received++;
 	apic_write(APIC_LVTPC, apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
-	apic_write(APIC_EOI, 0);
+	if (!nmi)
+		apic_write(APIC_EOI, 0);
 }
 
 static bool check_irq(void)
 {
 	int i;
-	irq_received = 0;
-	sti();
+	if (!nmi)
+		sti();
 	for (i = 0; i < 100000 && !irq_received; i++)
 		asm volatile("pause");
-	cli();
+	if (!nmi)
+		cli();
 	return irq_received;
 }
 
@@ -347,7 +351,7 @@ static void __start_event(pmu_counter_t *evt, uint64_t count)
 	    ctrl = (ctrl & ~(0xf << shift)) | (usrospmi << shift);
 	    wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, ctrl);
     }
-    apic_write(APIC_LVTPC, PMI_VECTOR);
+    apic_write(APIC_LVTPC, lvtpc);
 }
 
 static void start_event(pmu_counter_t *evt)
@@ -582,6 +586,7 @@ static void check_counter_overflow(void)
 		else
 			cnt.config &= ~EVNTSEL_INT;
 		idx = event_to_global_idx(&cnt);
+		irq_received = 0;
 		__measure(&cnt, cnt.count);
 		if (pmu.is_intel) {
 			if (pmu.errata.instructions_retired_overcount)
@@ -984,14 +989,32 @@ static void check_invalid_rdpmc_gp(void)
 	       "Expected #GP on RDPMC(64)");
 }
 
-int main(int ac, char **av)
+int main(int argc, char **argv)
 {
 	int instruction_idx;
 	int branch_idx;
 	int branch_miss_idx;
+	int i;
+
+	argv++;
+	argc--;
 
 	setup_vm();
-	handle_irq(PMI_VECTOR, cnt_overflow);
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "nmi")) {
+			nmi = true;
+			break;
+		}
+	}
+
+	if (nmi) {
+		lvtpc = NMI_VECTOR | APIC_DM_NMI;
+		handle_irq(NMI_VECTOR, cnt_overflow);
+	} else {
+		handle_irq(PMI_VECTOR, cnt_overflow);
+	}
+
 	buf = malloc(N*64);
 
 	if (this_cpu_has_perf_global_ctrl())
@@ -1044,7 +1067,7 @@ int main(int ac, char **av)
 			    "Please update test case.", pmu.nr_fixed_counters,
 			    (unsigned)ARRAY_SIZE(fixed_events));
 
-	apic_write(APIC_LVTPC, PMI_VECTOR);
+	apic_write(APIC_LVTPC, lvtpc);
 
 	check_counters();
 
-- 
2.53.0

