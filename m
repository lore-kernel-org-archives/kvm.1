Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463F485508;
	Fri, 25 Sep 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336700; cv=fail; b=JkhDd87BWEWIQ8gg+BGxt1ewI1Elmf8MdwJq8TsjdOXUDoDVEThgI2lirciXgOzqXVkv9Ub00VnzSQZwmlHUUMmVIkwbKyMrqbGcufd43FBvnoWDksguEj+plhnHrgV7oV9223BySdFnSTe+V4VNDLzBIloNL+QQeWumnm5lmWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336700; c=relaxed/simple;
	bh=wg/F4pkhz2HTqPXWWwTPVR9PWPpcUY2I87mf3/KtlQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRJ7drbzhsiNtrmJFDE5ODUxn/4LPnaeXld7lK3fiou/q2psMm4kWOZjtbHz8tgRxCoOFkvRuMbMQZAPWCkdSzS/aqrO8xr/A20lJUMXPpVeVVvs5VXauPjV3HNqEpYH5S9kGFJPyDHIZkQ7yA+FlLXtgPsJ0pxTDBpQNPfxjZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=txSHbiUE; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="txSHbiUE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM4tYWo/yWjzyrJS72cXeKNduzIkFDNggUXQu/0JZL7vU2eXAQp4n6C0231MTmccE21Y2FHOQG0EDHOzwtDvDipSxS2Sfhtg+U5h7tyLUOsjZG8b/aAM9RbuMPucM2hbA27IeERRvExCSTaOZcOnxIbmhIPRsaQxXhYmgPWrZEgng0UIcG8rVDE3wwyak+TiBOGVUe+3K9hFbTXXQz2F+2KrjaSroXDzkNIgdsP0l36NXAkki8rEJ21e+TuH8jd3xL82XSjfArcF/QN9tZuU9hwHh/PROcnHMo9QogSa4jiR1G/i4C0ejDT/MsvCC+OBNgcbzlnIbnzTIhCXKxtH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuNiy+9uGtH4fewkNgeFmlsO/R+F7+WJ/35Eo6ASPH8=;
 b=WFgdIzDTE3ONvTUuMwHcfHoY7wr/VjxYFIeYowTFZnDPUMbdnssVmxQ1CFndf6nqsa/wtq7eUbrooID3RGJFApTbDz+ieh4PHopkXCK3RcWMB0ED8Yfy6JBdcIFgdIv4SnkDBNgexQnOOr98/m2oyreQrrm6YVy8Lik0Hphj2GDL4COZrIAKr3aX3UuedH8GgxYQOgrS8X6f6Ut+KmJKt+qhZepqdrqZYaHf5n3XeVSrkENBNeQELgf5gjjjEbYgNYbUcqkRK9cfe075R/h7VWBueZ79jyhwQjyrcfmbGpSzZFK9VnlGsP7maxcZWyD1F6y24epdwomHh+RLDly/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuNiy+9uGtH4fewkNgeFmlsO/R+F7+WJ/35Eo6ASPH8=;
 b=txSHbiUE7pfrIzA+58CtInQfLKGgISB4nZcM28/2P6MTXeJa5IXre3Qb1VNFTivEQIJ61oEWsaxFFRNRgaZUmBVmKAfJGBhY4URefukFfsc5y2Xg2ryMWwWp/Yv2NIfdbLRu22ynJDcUtRJD6D+jUZ8cHg49qmGkcOI0dUR6XN8=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 11:44:55 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::12) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:44:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:44:54 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:44:49 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 7/9] KVM: SVM: Dump FRED context in dump_vmcb()
Date: Fri, 25 Sep 2026 11:40:15 +0000
Message-ID: <20260925114017.2208531-8-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 72355121-7317-48a2-ec62-08df1afa6a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fH0itcYAN5WmbVc++iOa32ItdCYiMkVcwzJQaeW64Qm15iv6QGMMikGRb9sH3sn7EmC3TPsUSP/vBZpFrKd3mBy1S7UGny7ho8OPQog8o9ghOh71Qxl3thJzKgFghs1tolxGrPZ8NvkeQOqdwgpV/P9zkk+oIklvSe4wH5GTtNz3VS3g7ZRJJROP9oUxmZ4QsPNquZ6KT9vaZJeQE3MOdS6weAMMhtHsmxOT/eCAadjLBD1JQ+WXAJRRj8zz4hKPo1ifv9WXRcy3VHpff1/7he9FniwLvCvhB7MEfKTihLxmV+n/wtLSK5E54LTLZ9em7KHDs8iA5Lokmvz5EO3GBi29YbBgvpOdzTuogmE5h5aUhTwK0oMSqy6irh5d36f8A6/o8ZBxkhG2nT147T0XvzqXBlOG8PQhEMmIn8IVW/kJ3ANmP4sbJnoVWn/zEYZ1dWMg+ZsIxPgGCPdYuYEup3WOWhG43lC+YmrDyh/LEsl0+gzt8pzZOzQEmQkauLbOESfC0WB0+riXJD81zcBcHYMhvSqEoEsxmGfS9RCey83gZ/MOvnMd750beNXlWoHMzfm4uRFm0uWYuWAf1HWPGiDqB1+lCPzYnVT95AkWlv4PL2SptQrbwIfwCWkDmJVZk64OwS3EG7FsuiFa51i/xKENoyOn4dPnBxLd4dOGnAZtDxxeuSUZ6DxrY5oVnY+sQ1tbq+b0+uc8QWZVAoBilg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAR3l/Ts1P/eFNn1lnNcz7aUlaUn+UpPF7p5tQwTIEz69BWxzRAiNYh2SHcOgVGXWeo+MqJpddXa6GU4wcVhUixuhrToThPQY2AH62CoOofIX8qElgypUOxhMruege5Ub6dGiNwB7pTAcxx+xGBzpkmfxYcgC0wAuuwALlBNHSIBZTUkZ7TU+9WYd/qk2xd6g5ezHYcUVUvmpz1mMXUFx6nCQdTb4C0dizYgAlZFve6k2vhLsiVpuvUo+23GPC1vBRG6/SGan5Ez6vnCnhcYxz7GyG3KkPcyRxGP1iF036LvoQT/14m2f1cNSPEHcCuz0dx2SAMkNnG3Ee1GjL2i49ANNCaCAC4k7gZqRmp3m9LGFblaxVqIILSYNELHJfi0dGnk/mlLdcbA/mPhPmy3uRf702lOC8qFOC/dRQRo/bdpgje1FO8HqC9JRlDmzz9y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:44:54.2418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72355121-7317-48a2-ec62-08df1afa6a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

Add fields related to FRED to dump_vmcb() to dump FRED context.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* Update the print statements to align with fields in VMCB save area.

Changes in v2:
* Gate all the FRED MSRs through guest_cpu_cap_has() (Sean Christopherson).

---
 arch/x86/kvm/svm/svm.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fb6b94405f88..86a3ba54aab2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3589,6 +3589,11 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%016llx\n", "allowed_sev_features:", control->allowed_sev_features);
 	pr_err("%-20s%016llx\n", "guest_sev_features:", control->guest_sev_features);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+		pr_err("%-20s%016llx\n", "exit_int_data:", control->exit_int_data);
+		pr_err("%-20s%016llx\n", "event_inj_data:", control->event_inj_data);
+	}
+
 	if (is_sev_es_guest(vcpu)) {
 		save = sev_decrypt_vmsa(vcpu);
 		if (!save)
@@ -3703,6 +3708,27 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		       "r14:", vmsa->r14, "r15:", vmsa->r15);
 		pr_err("%-15s %016llx %-13s %016llx\n",
 		       "xcr0:", vmsa->xcr0, "xss:", vmsa->xss);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+			pr_err("%-27s %d %-18s%016llx\n",
+			       "is_fred_enabled:", is_fred_enabled(vcpu),
+			       "guest_evntinjdata:", vmsa->guest_event_inj_data);
+			pr_err("%-12s %016llx %-18s%016llx\n",
+			       "fred_config:", vmsa->fred_config,
+			       "guest_exitintdata:", vmsa->guest_exit_int_data);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp0:", vmsa->fred_rsp0,
+			       "fred_rsp1:", vmsa->fred_rsp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp2:", vmsa->fred_rsp2,
+			       "fred_rsp3:", vmsa->fred_rsp3);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_stklvls:", vmsa->fred_stklvls,
+			       "fred_ssp1:", vmsa->fred_ssp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_ssp2:", vmsa->fred_ssp2,
+			       "fred_ssp3:", vmsa->fred_ssp3);
+		}
 	} else {
 		pr_err("%-15s %016llx %-13s %016lx\n",
 		       "rax:", save->rax, "rbx:",
@@ -3730,6 +3756,23 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		       "r14:", vcpu->arch.regs[VCPU_REGS_R14],
 		       "r15:", vcpu->arch.regs[VCPU_REGS_R15]);
 #endif
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+			pr_err("%-15s %-15d %-13s %016llx\n",
+			       "is_fred_enabled:", is_fred_enabled(vcpu),
+			       "fred_config:", save->fred_config);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp0:", svm_read_guest_fred_rsp0(svm),
+			       "fred_rsp1:", save->fred_rsp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_rsp2:", save->fred_rsp2,
+			       "fred_rsp3:", save->fred_rsp3);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_stklvls:", save->fred_stklvls,
+			       "fred_ssp1:", save->fred_ssp1);
+			pr_err("%-15s %016llx %-13s %016llx\n",
+			       "fred_ssp2:", save->fred_ssp2,
+			       "fred_ssp3:", save->fred_ssp3);
+		}
 	}
 
 no_vmsa:
-- 
2.43.0

