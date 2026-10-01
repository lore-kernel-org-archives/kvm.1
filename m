Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05425535FC7;
	Thu,  1 Oct 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867616; cv=fail; b=rXjD/HXmikALc0Trr11G40nhI0NfYupZXbBU7IfiD40+VhyNurpORBDQfKE0D5DUp57pgYZOWji8cALMqFnjApVRRUz3sb80naWBdLtmWExCoJ2z6TMWp9CI3BbOUJBYVG2juq61r3zIE+qrGTWDFL2rL5YnA5QgxqUo+6X/Oa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867616; c=relaxed/simple;
	bh=9EdvmlYvWw1P1lPJU3NDRFEHfVtT2kcsAfW5ll6nJ9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhmVcpfzvahK7uV7Hx3IuoHXJvmVuaYffK4nhwjhgtZydte3TIa3Y0TFspKobjEBotrKINf4GYX3rKFip9gkZoiBDkqkEoHF6zPIAtwMA54wswU4fos6tV0AqCwCgvQoYDyBmhdM0aQcZX9OXg+GMSTrLPYSgQdfgVn7Lu27PdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oSfm27kr; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSfm27kr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB5a9/yNYvKzMgyFYQcrrIWoclQMbMpQTolDJ9e0A+TdKYriaWNuoEuNbPhbGCASjL9tFhiKy5ekgagTq3JG46Zbx07C7c2qHyYkTA4RKFUPjSL3C/kj0SPZ1Zyg3Sx/ZTvvhgr7URCdBEqc/6te2/JbYs8tkgxQ+0qJ83ho+j5hG+X7aygMKtlfXAj3QmnutnX5gM0yVA5YCT74lokEW66F/FLXRa+9meY59LBh+mlkJvm+j2V7ZegWsDdauTKuPgCeiURBSJyvzyAA6+hpGV0dPmvQo7J3MlORdYa4iWtddofHqaSgg/v/2JiQUkS6h2K7gwyYNuuzFGOMjcXR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWXIa+ZxeUIVSeRrKxOnaCRsxvE72ApDAIJHoYuXgT8=;
 b=Usg/q5eZouQG3eXz+bRBYPlt3Rgt991uHEb/EGwRnTVlWLfD982rm5mjh2Cvd4TDlp6Zv8srPuCw2Vhs7VeRWuHrRxRRCfRcSQRJ1mo7/asFCk7hrIaQbJp0kcD8I9qa8+0PXwneExGI5hqhrRhuXlemGNIStfQlaavniQb/VDOe3Azw6FU2VUw323Fxm0K0M27JkDcyheRN4wqOTdXt0XeRo5zmLaI/DLUNF+Z/qbZgZ8u8NDVftUlEJ4Gu3x/5EnMFrrwiE+uSrPQ9C7ioyDWYQGiwfRlFgTMvsjoIaToOd/8y3we8hT5oVATMh6pLiahH12R168Unf9MD/8bvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWXIa+ZxeUIVSeRrKxOnaCRsxvE72ApDAIJHoYuXgT8=;
 b=oSfm27krRkOUYnSCt8sh+/fcbb77E8DaRJitu1oINezQmTVnFTXpvWP99+q1Ael2kWaK3Dm8dXFAEeHkVxTO8N8g8NN6Qsd+ylY/SkfT3lo5/2N8g7DUgkLEjch1v6kfVEdDVlcChD9P1GVbx170is5G3U0Qw2SvsKXBMQ1AGo0=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by DS0PR12MB504719.namprd12.prod.outlook.com (2603:10b6:8:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:13:28 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::96) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:13:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:13:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:13:25 -0500
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <fenghuay@nvidia.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dapeng1.mi@linux.intel.com>, <elver@google.com>,
	<enelsonmoore@gmail.com>, <jlayton@kernel.org>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <seanjc@google.com>, <ewanhai-oc@zhaoxin.com>,
	<binbin.wu@linux.intel.com>, <peterz@infradead.org>, <ashish.kalra@amd.com>,
	<superm1@kernel.org>, <chang.seok.bae@intel.com>,
	<prathyushi.nangia@amd.com>, <kim.phillips@amd.com>,
	<ackerleytng@google.com>, <elena.reshetova@intel.com>, <naveen@kernel.org>,
	<darwi@linutronix.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v6 17/18] fs/resctrl: Allow user space to write kmode_cpus/kmode_cpus_list
Date: Thu, 1 Oct 2026 10:10:40 -0500
Message-ID: <d8a3b72acffa7470464daf8030e88562e85b26c7.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB504719:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8f036f-1b7c-401c-aac7-08df1fce8bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|6133799003|22082099003|18002099003|10067099003|3023799007|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	uVtlNnH48L/4RTtdKkHW3NRw2vKM+TtL2r5tihBufy+5n6a2fHWKtT3hdZPjRO0BRrL4+Z2bo45aJBizoVi6jXnV4CquaBUkuPoUOKfaaCkKLUzYsYTDWbPz2IsqeP68U3g6LUWfAunjOPdS93nUzFBuw2cTxNd+WMKkZBLuNT4ri9zkZF8NPdaU9Ug+JOBLB+A9mL6Ytq7QEgrq1pSsxusdxwju3ugHRuPWSqtFLZ40a+0DJjxOW+eJUpLqX9OUwtuXU9ieiTjG4tyY7sU7WQUKniub6+nNsjfytya0gvZwL1Z0/VpC2gGv2/CfydWsMTOF6ocfDLxHmtS8ojxvRBbxPIGpVQzNuEr4GWj/YINSlsE3zAXK8ZXRKjB4wTKamcEK9CO4ZoTFyK9rfDcIkE6bn6QNn4M79Pk/k7fiyofdSbK8jWbU03a0JErCFljotB44D1YGLTrRhhCopH/pZzyhi5y6T2i64yDBC8e601oR1OFS3zq3CRtzH11WsPBOiDf01u0vt7HeADCDWzJgj/DLjozHLS76/IKNrJdGNauqrO5+/LuFFis3DlHtcZQf2Q2j53exCssoauKYQz/0aDAGk0h/UCWnpAurhcTj0/Zbg5PkdnA3TEL/Ptxlidchg+u/EYBL9uP0w7HctM6ABQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ctux/ckC9OtfXeeAH+SoQvIulq+QsnXB57rXQXI7OH6MB/In9f3V8SxLTELbRFsIDjqIdW2i7QrFriCp5wCSWJmiJ/Z+vHUP+B7czymuKrJgLC855V/oIYwXP2SShQnGVxoRxGbzIWLm2xvRrZTYHCiKOM7kwtAXjbUflBKGMkAkJCn146qwULzC/0tXfhZA5V6+fFeDRbIV6PMcbjC193+milttMTeoA6mleKlKVYQU/l5IbYPcaT/h9E+J7K9HV+D/3PiZTXt1EODLjIwLZqo+oKymn8ezjaj1aG1tltuq5wGte4fYIguUjmLFvfrbCwysfKRCs3efPgj+zCQpwDpDoThmpLWPvl6QHGr6ny7SRn4hv06enY0CPHO7HeQr1wx3sD5Mgw8T3yjgylLd/lM/NX4HINfq/unQSzQg5dRc4L5j/qMC8VCC/o9agGdc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:13:28.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8f036f-1b7c-401c-aac7-08df1fce8bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB504719

The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode supports configuring
kernel-mode resource allocation and monitoring associations on a per-CPU
basis. The CPU scope of the association is exposed through kmode_cpus and
kmode_cpus_list.

Add write support for kmode_cpus and kmode_cpus_list to allow user space
to configure the CPUs associated with the active kernel-mode group.

Document the interface in Documentation/filesystems/resctrl.rst.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Use flattened resctrl_kmode and global_enable_per_cpu.
    Fix the sashiko reported issue.
    https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com?part=15
    Update the changelog.

v5: Adapt to the resctrl_kcfg caps and active split. Use
    resctrl_kcfg.active.ctrl_mode and mon_mode in kmode_cpus_write().
    Use full ctrl=/mon= syntax in the kmode_cpus example.

v4: Empty masks are now allowed and updated masks are in rdtgroup->kmode_cpu_mask.
    Updated the changelog.

v3: New patch to add "kmode_cpus" and "kmode_cpus_list" to support
    kernel_modes.
---
 Documentation/filesystems/resctrl.rst |  30 +++++++
 fs/resctrl/rdtgroup.c                 | 114 +++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index bf9d34d6a335..0d9dac38210c 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -671,6 +671,36 @@ All groups contain the following files:
 "cpus_list":
 	Just like "cpus", only using ranges of CPUs instead of bitmasks.
 
+"kmode_cpus":
+	Accessible only within the resource group currently associated with
+	the active kernel mode (see "info/kernel_mode").
+
+	Bitmask of the logical CPUs associated with the group's kernel mode.
+	When kernel mode is activated through info/kernel_mode, every currently
+	online CPU is included. CPUs that come online later are automatically
+	added to the association.
+
+	Writing a mask replaces the association's CPU mask. The association is
+	enabled on CPUs added to the mask and disabled on CPUs removed from
+	it. An empty mask disables the association on all currently online
+	CPUs, but CPUs that come online later are still automatically
+	associated. The mask must contain only online CPUs; masks naming offline
+	CPUs are rejected. Errors are reported in "info/last_cmd_status".
+	Example::
+
+	  # mkdir ctrl1
+	  # echo "global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1//" \
+	        > info/kernel_mode
+	  # echo 0-3 > ctrl1/kmode_cpus_list
+	  # cat ctrl1/kmode_cpus
+	  f
+	  # cat ctrl1/kmode_cpus_list
+	  0-3
+
+"kmode_cpus_list":
+	Just like "kmode_cpus", only using ranges of CPUs instead of bitmasks.
+	Writable with the same semantics and restrictions as "kmode_cpus".
+
 
 When control is enabled all CTRL_MON groups will also contain:
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 73749e5a4ad0..5c812a9941cf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -421,6 +421,114 @@ static void resctrl_configure_kmode_global(const struct cpumask *mask,
 					    enable);
 }
 
+/**
+ * kmode_cpus_write() - Update @rdtgrp's kmode_cpu_mask from @newmask
+ * @rdtgrp:	Resctrl group whose kmode_cpu_mask is being updated.
+ * @newmask:	New CPUs for @rdtgrp's kernel mode association.
+ * @tmpmask:	Caller-allocated scratch cpumask used to compute the
+ *		incremental enable/disable deltas.
+ *
+ * Enable the association on CPUs added to the mask and disable it on
+ * CPUs removed from the mask.
+ */
+static void kmode_cpus_write(struct rdtgroup *rdtgrp,
+			     cpumask_var_t newmask, cpumask_var_t tmpmask)
+{
+	/* CPUs dropped from this group: old & ~newmask. */
+	cpumask_andnot(tmpmask, &rdtgrp->kmode_cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask))
+		resctrl_configure_kmode_global(tmpmask, rdtgrp, false);
+
+	/* CPUs newly added: newmask & ~old. */
+	cpumask_andnot(tmpmask, newmask, &rdtgrp->kmode_cpu_mask);
+	if (!cpumask_empty(tmpmask))
+		resctrl_configure_kmode_global(tmpmask, rdtgrp, true);
+
+	cpumask_copy(&rdtgrp->kmode_cpu_mask, newmask);
+}
+
+/**
+ * rdtgroup_kmode_cpus_write() - Write kmode_cpus or kmode_cpus_list
+ * @of: kernfs open file
+ * @buf: CPU bitmask or list from userspace
+ * @nbytes: length of @buf
+ * @off: unused
+ *
+ * Update the CPU mask of the group that backs the kernel mode.
+ *
+ * Return: @nbytes on success, negative errno on error.
+ */
+static ssize_t rdtgroup_kmode_cpus_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	cpumask_var_t tmpmask = CPUMASK_VAR_NULL, newmask = CPUMASK_VAR_NULL;
+	struct rdtgroup *rdtgrp;
+	int ret;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	if (!buf) {
+		rdt_last_cmd_printf("%s: Invalid input\n",
+				    is_cpu_list(of) ? "kmode_cpus_list" :
+						      "kmode_cpus");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
+		rdt_last_cmd_printf("%s: Kernel allocation failure\n",
+				    is_cpu_list(of) ? "kmode_cpus_list" :
+						      "kmode_cpus");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	if (resctrl_kmode.kmode_cur == RESCTRL_INHERIT_USER) {
+		rdt_last_cmd_puts("No active kernel-mode association\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (resctrl_kmode.rdtgrp != rdtgrp) {
+		rdt_last_cmd_puts("Group not assigned to kernel-mode\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (is_cpu_list(of))
+		ret = cpulist_parse(buf, newmask);
+	else
+		ret = cpumask_parse(buf, newmask);
+
+	if (ret) {
+		rdt_last_cmd_puts("Bad CPU list/mask\n");
+		goto out_free;
+	}
+
+	/* kernel-mode association is only programmed on online CPUs. */
+	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
+	if (!cpumask_empty(tmpmask)) {
+		rdt_last_cmd_puts("Can only assign online CPUs\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	kmode_cpus_write(rdtgrp, newmask, tmpmask);
+
+out_free:
+	free_cpumask_var(tmpmask);
+	free_cpumask_var(newmask);
+out_unlock:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 /*
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
@@ -2684,17 +2792,19 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "kmode_cpus",
-		.mode		= 0444,
+		.mode		= 0644,
 		.hidden		= true,
 		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_kmode_cpus_write,
 		.seq_show	= rdtgroup_kmode_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
 	{
 		.name		= "kmode_cpus_list",
-		.mode		= 0444,
+		.mode		= 0644,
 		.hidden		= true,
 		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_kmode_cpus_write,
 		.seq_show	= rdtgroup_kmode_cpus_show,
 		.flags		= RFTYPE_FLAGS_CPUS_LIST,
 		.fflags		= RFTYPE_BASE,
-- 
2.43.0

