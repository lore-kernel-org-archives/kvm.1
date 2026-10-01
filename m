Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D19521892;
	Thu,  1 Oct 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867465; cv=fail; b=CWSN8IkGr/BvoNmRaRx0+7VwuSu/z3bTR6P6+IAWjpX8wWbFPdSvDdKYgG5RnI0ywg962XnkQmnh0WuZIHZO4+qh4Jx5TWln7P/MRUKfBLiA+Fl3vjcb/bKGOBh8WsaAkXs6ahgnX2HNeSOy8AqY3Ylfe56yyxfZyjR91+sdXec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867465; c=relaxed/simple;
	bh=uu62wHA61H/e/RRnoED1wCjEG7XomC0T94KXAW7IIZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=muu8Kfnpe8qcCB1rUj0du3nvzsEiTgfsg61fBVoQU4CU8+HATx4VCiahstm/dR058CAaskpQMqlC/F0wuOaD5UV7W5eymnpv3r0gB+9UOKyfiYUeraVfSc3GBu3DdqMcJsIr9IiU9FaKF9QjJd7+OzFhAxH+F072gYbWhMnXB60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VBE2ZLbL; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VBE2ZLbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny1STCF4jBqdcFJdD82VQMF/qef8Xx4/hozXE0hTyiiRByKML++Hm+H1HpN7uZH70SLZAhOft7Ob2a4f97f6ZaXhY0UahVOm6p+tqnvOvJ8XNwwZcDahQZiXDRui9x4+J70u+9YA+FjvhqCvtkNG1Och1trcVIbEIHolyMn44jbldFXx/KxMVq9dkXaUDLPZSB/dMqsLr1gKv6/Ulmqw4aHN3xrIYHs/6E8Mhx1GcTk1cGEsCeeBci+NrII5JiXctvA3RYAC8r9hbavgpkMhBRk8So0g8OVRd/ztNstJ1zZjv9wihO/duVMZRZgqa/0/uZFbT9psBYfgdBt3gccV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOLy3SOQuWEyQNqwX4HcAAn9PcC/I4jUW+uLisujz90=;
 b=Cac3NSLbGWJPbwTJxxwa50jJUA0XgcJWThya+MJ9+P7Gj1sUBI+Sr8NpgDoY1fcY78F/VbwqzecLaVL8wgk5YpaISFwD9su2OhYdrL3aZ7tbklcQ/haA2s5i4K2SbXsk1c8Y8HZP+baJEl7KdLnHg07/Lh+NpZsZhj29jNmwuTnh5NpfpN80W3M0GGEDUayeY5JxcaDiabaY7PhucOnxZYlWEZvqnLGFLjF6iQnJINKsRFGS1xKFFchNlH8RxFmwu/zCFqFq7TAKlC0xfho9ez1jKzOit6zzEpJins4j9B7smw3sH8bmAuNpLjgyG5B38JSsHvb/+pHuN4qXSV/3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOLy3SOQuWEyQNqwX4HcAAn9PcC/I4jUW+uLisujz90=;
 b=VBE2ZLbLffVVoxZ6TtwPTulQEKMBGgAuujrR65rmd7ntskdIIFVW0rDvaabxPwcXwNB3p5LVcXd5O71CpKQBeRkINcrcsLyVIH/KO8l7WcA2m4ZMDngFu8fnrnK/ifJbsyVb+CBfi2fZr4dpwkAVjHxf44GbnEtaGKyesrLt7LU=
Received: from BL1PR13CA0218.namprd13.prod.outlook.com (2603:10b6:208:2bf::13)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:10:55 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a2) by BL1PR13CA0218.outlook.office365.com
 (2603:10b6:208:2bf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:10:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:10:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:10:52 -0500
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
Subject: [PATCH v6 00/18] x86,fs/resctrl: Add kernel-mode (e.g., PLZA) support to the resctrl subsystem
Date: Thu, 1 Oct 2026 10:10:23 -0500
Message-ID: <cover.1790867441.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 28254df7-c7a8-4656-0366-08df1fce30b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|23010399003|5023799004|11063799006|56012099006|10067099003|18002099003|260925021311599003|260925021911599003|6133799003|3023799007|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	Raf9T0RIHAIWH/Bkni26vntIjxja5WkW37CA6tkcRgub2A99pXuFoAe6/5YNipfxxIvo+Ax/2xcAwDwVmw2c0VkNVSU/8qJzmTCFYE3ei6UoliKyfqwU+sUebzpvhDCwhLzrtXlnoOfEZ2RQ9YGzUXH0/qJIqv1CHecxbjhDDzryQRYR8HMElKmRlpwxK+4jxCfpwVmicm35PqcxSsOVjphqZFTsa1Tx+PCMD7YDzVH/DJxMdNEw65Fvv5RjN+n9Dct94u3AYjy1uxa2LQX0skFO/XivqTfDL6erCIlg/d6S953Wy4Ft3GJIsUNmUDAcUae9BDP7MvPs9/zERUnH0a9aRXkYth5Qg975F1v95sp7FLko2q+XyzFLn7X1jC0SOLygUxQt27J18F0GrdDZRFIjJwk8dbvASEnnM1Qd4/CfSy8AYqoeW3BkYk0RK01YYcPMEY16mzSRjd+0yS8WsT3JLMIQ3jZxSkne6xTdbZJgrmW4BcwSD79MpE4rh7kH7yG6HKUN4RHaPj0VLWCeqZRAKJPWAfcxxbxBXEPr6KQBqdWvmtBVPbP8H0F2PEOPa/oi6gbjHN7jq648tuHfnKU+uGqZzH2CH7vEKJLpSOikcz7wGKRMquPbcYx7G3oDxZLYArMHlHOv+caiG3pF443eQGM0Os+Ng+GC5gtXH20=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(260925021311599003)(260925021911599003)(6133799003)(3023799007)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DbtflMag2CHZXod2n+gt2poEUAynnIaQL8ApKDG+HWG4QLNqQ7ZKb1l1ucMnCAwpC86A9b4HHaS35fWEqIRca3j8VbtI3HSYEv1wAe1goW93tdZq0QGL1PDctF69wceoa/RBLnUqt6KFObGX166f6j+IeI91XPNsJDl6B03ZMkkSZKABhbP6nFAp+E2xOv+iQ3DNCW5u9Y+8QGzHD5z5/L1zaEdbPOz7liWJKC93EPRxkHjqPV62aY32UTtVMvud6lspegc1NBxipwUViJsUvWb6ZnJ9wumwJsnwqG3wTfW6c7bqZxsH+DCoLTF6O8jRex6K9gjBlzE/S+L8e+r+gPQwHfEML95gYzZYOi2BEnNvUvO0I1vd00weOLlbF+JFOj6WH4KpmQW0izDg8P2dkKoG/LtAg1fxicF6cVbMgSMJ6smSHxlFmKAbbYVFtMqI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:10:55.0415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28254df7-c7a8-4656-0366-08df1fce30b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000


Hi All,

This series adds support for AMD's Privilege-Level Zero Association
(PLZA) so kernel work can use a separate resource allocation and/or
monitoring association from the user task, and wires it up through a
small generic "kernel mode" (kmode) layer in fs/resctrl so future
architectures can plug in without touching (hopefully) core resctrl.

The features are documented in:

   AMD64 Zen6 Platform Quality of Service (PQOS) Extensions,
   Publication # 69193 Revision 1.00, Issue Date March 2026

available at https://bugzilla.kernel.org/show_bug.cgi?id=206537

The patches are based on top of commit (tip/master):

  8cf07e484290 Merge branch into tip/master: 'x86/tdx'

Any feedback is appreciated.

Background
==========

When memory bandwidth associated with a CLOSID is aggressively throttled,
and a task with that CLOSID moves into kernel mode, the kernel operations
are also aggressively throttled. This can stall forward progress and
eventually degrade overall system performance.

Privilege-Level Zero Association (PLZA) allows the user to specify a CLOSID
and/or RMID for execution at Privilege Level Zero. When PLZA is enabled on
a CPU, kernel work at PL0 uses the CLOSID and/or RMID from MSR
PQR_PLZA_ASSOC; otherwise, the CPU uses the CLOSID and RMID from PQR_ASSOC.

Design
======

A new sysfs file, info/kernel_mode, selects the kernel mode for resource
allocation and monitoring of kernel work and, when the mode needs one, the
resource group that backs it. Reads list the supported modes and the
currently active association; writes select the mode or the group. Look
at the thread below for design discussion.
https://lore.kernel.org/lkml/14a8ad0a-e842-4268-871a-0762f1169e03@intel.com/
https://lore.kernel.org/lkml/e4c95002-ae8a-48d0-bedd-772db58b937e@intel.com/

Two kernel modes are exposed:

- inherit_user: kernel work uses the allocation and monitoring
  associations of the user-space task on whose behalf it runs.

- global_enable_per_cpu: kernel work uses the allocation and/or
  monitoring association of a backing CTRL_MON or MON group. ctrl= and
  mon= select assign or inherit for each, and group= names the group
  with <CTRL_MON>/<MON>/ path syntax. An omitted parameter keeps the
  value the file currently shows. A monitor group requires mon=assign.
  A failed write leaves the current association in place.

Per-rdtgroup files kmode_cpus and kmode_cpus_list scope the association
to a subset of online CPUs. They are visible only on the group that
backs the active association. A write enables the association on CPUs
added to the mask and disables it on CPUs removed from the mask. A new
global_enable_per_cpu association sets the mask to every online CPU. A
CPU that comes online later joins the association. A CPU that goes
offline leaves it only when that CPU is in the mask.

A group that backs the association, or a control group whose monitor
group does, cannot change mode, including entering pseudo-lock setup.
The backing group cannot be renamed until the association is cleared.

The arch hook, resctrl_arch_configure_kmode_global(), keeps the
fs/resctrl layer arch-neutral.

resctrl_set_kmode_support() lets architecture code register each extra
mode during resctrl initialization. inherit_user is already registered
when the platform can allocate or monitor. On AMD, PLZA registers
global_enable_per_cpu when the feature is available.

Only AMD PLZA is wired up here; Intel and ARM can add their own support
later by implementing the hooks.

Examples
========

(See Documentation/filesystems/resctrl.rst, "kernel_mode", "kmode_cpus",
and "Examples on working with kernel_mode", for the full UAPI.)

  # Mount resctrl
  # mount -t resctrl resctrl /sys/fs/resctrl
  # cd /sys/fs/resctrl

  # Read the supported modes.  The active mode is bracketed for display
  # only; do not include brackets when writing.
  # cat info/kernel_mode
  [inherit_user]
  global_enable_per_cpu:ctrl=assign;mon=assign;group=//

  # Create a CTRL_MON group and back kernel-mode allocation with it.
  # mkdir ctrl1
  # echo "global_enable_per_cpu:ctrl=assign;mon=inherit;group=ctrl1//" \
          > info/kernel_mode
  # cat info/kernel_mode
  inherit_user
  [global_enable_per_cpu:ctrl=assign;mon=inherit;group=ctrl1//]

  # kmode_cpus and kmode_cpus_list are visible only on the backing group.
  # ls ctrl1/kmode_cpus*
  ctrl1/kmode_cpus  ctrl1/kmode_cpus_list

  # Restrict the association to a CPU subset. The association is enabled
  # on CPUs added to the mask and disabled on CPUs removed from it.
  # echo 0-3 > ctrl1/kmode_cpus_list
  # cat ctrl1/kmode_cpus
  f
  # cat ctrl1/kmode_cpus_list
  0-3

  # Return to inherit_user.
  # echo "inherit_user" > info/kernel_mode
  # cat info/kernel_mode
  [inherit_user]
  global_enable_per_cpu:ctrl=assign;mon=assign;group=//

Tested on AMD with PLZA; builds on x86 without PLZA and does not expose
global_enable_per_cpu unless the feature is available.

Layout
======

  01-03  x86: PLZA CPU feature, command-line option, and MSR definitions.
  04-07  fs/resctrl: kernel mode enum, arch hook, kmode state, and
         resctrl_set_kmode_support().
  08     x86/resctrl: register global_enable_per_cpu when PLZA is
         available.
  09     fs/resctrl: info/kernel_mode read interface.
  10     fs/resctrl: hidden rdtgroup files.
  11     fs/resctrl: per-rdtgroup kmode_cpus/kmode_cpus_list.
  12     fs/resctrl: CPU hotplug for the active association.
  13     fs/resctrl: deactivate the association when a group is removed.
  14     fs/resctrl: show or hide kmode_cpus on the backing group.
  15     fs/resctrl: reject mode changes while a group backs the
         association.
  16     fs/resctrl: info/kernel_mode write interface.
  17     fs/resctrl: kmode_cpus/kmode_cpus_list writes.
  18     fs/resctrl: documentation and examples.


Changelog
=========
v6:
  - Addressed all the comments as discussed in v5. Anything missing
    is not intentional. Please feel to comment on any mistake.
  - Rename assign_global_enable_per_cpu to global_enable_per_cpu and
    describe the interface as a kernel mode rather than a policy.
  - Flatten kernel mode state into resctrl_kmode. The arch hook is
    resctrl_arch_configure_kmode_global().
  - An omitted ctrl=, mon=, or group= keeps the value shown by reading
    info/kernel_mode. inherit_user takes no parameters.
    ctrl=inherit;mon=inherit remains global_enable_per_cpu.
  - Selecting a new global_enable_per_cpu association sets that group's
    kmode_cpus to every online CPU. A CPU that comes online later joins
    the association even if user space had removed it from the mask.
  - kmode_cpus files are created hidden and shown only while the group
    backs the active association.
  - A monitor group requires mon=assign. Removing a control group
    detaches a child that backs the association before the parent's
    CLOSID is freed.
  - Reject a mode change when the group or one of its monitor groups
    backs the association.
  - Split kmode_cpus visibility and the mode-change rejection into
    their own patches.
  - Use the parsing similar to ctrlmondata.c:parse_line(),
    ctrlmondata.c:resctrl_io_alloc_parse_line(),
    monitor.c:resctrl_parse_mbm_assignment().
  - Re-wrote the changelog as a feature and not as a bug-fix.
  - Remove implementation details in function headers.

v5:
  - Collapse the two v4 global-assign modes into a single
    assign_global_enable_per_cpu policy with ctrl= and mon= options.
  - Use "association" terminology consistently in code, errors, and
    documentation.
  - Register assign_global_enable_per_cpu once during x86 resource
    discovery when PLZA is available.
  - Reject mon=inherit when group= selects a monitor group.
  - Split hidden-file support, deactivation-on-teardown, and PLZA mode
    registration into separate patches for easier review.
  - Fix msr_pqr_plza_assoc truncation on 32-bit systems by using u64.
  - Refresh documentation and add a readable end-to-end example walkthrough.
  - Block pseudo-lock setup on kernel-mode-associated groups.
  - Reject mode changes and rename while a group backs the active
    association.

v4:
  - Reorder and split the series into 15 patches: separate read-only
    info/kernel_mode display from the write path; add hotplug support
    when a CPU comes online; add an end-to-end documentation/examples
    patch.
  - Introduced resctrl_set_kmode_support() so architecture code can
    register supported kernel-mode policies during resctrl initialization.
  - info/kernel_mode write: validate group type; run fail paths before
    tearing down the active association so errors retain the old state.
  - kmode_cpus / kmode_cpus_list: writable with incremental enable/disable
    deltas; empty masks allowed; offline CPUs rejected.
  - Hotplug: newly online CPUs are added to the associated group's
    kmode_cpu_mask and programmed when assign_global_enable_per_cpu is
    active.

v3:
  - Generalise the layer beyond AMD: rename "PLZA mode" to "kernel mode"
    (kmode) in code, sysfs, and Documentation.
  - Reset the association when the associated rdtgroup is removed,
    instead of leaving stale state.

v2:
  - Similar to RFC with a new proposal; interface names were not final.
  - Separated Global Bandwidth Enforcement (GLBE) from PLZA; this series
    only adds PLZA support.
  - Used "kmode" instead of "PLZA" in the generic layer.

Previous versions:
v5: https://lore.kernel.org/lkml/cover.1787772750.git.babu.moger@amd.com/
v4: https://lore.kernel.org/lkml/cover.1783461016.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/cover.1777591496.git.babu.moger@amd.com/
v2: https://lore.kernel.org/lkml/cover.1773347820.git.babu.moger@amd.com/
v1: https://lore.kernel.org/lkml/cover.1769029977.git.babu.moger@amd.com/


Babu Moger (18):
  x86/cpufeatures: Support Privilege Level Zero Association (PLZA)
  x86/resctrl: Add PLZA support to command-line options
  x86/resctrl: Add PLZA configuration definitions and data structures
  fs/resctrl: Introduce kernel mode enum
  x86,arm,fs/resctrl: Introduce architecture hook to program global
    kernel mode
  fs/resctrl: Introduce kernel mode states for resctrl
  fs/resctrl: Introduce resctrl_set_kmode_support() to register
    supported modes
  x86/resctrl: Register RESCTRL_GLOBAL_ENABLE_PER_CPU when PLZA is
    available
  fs/resctrl: Add interface to display kernel mode status
  fs/resctrl: Add support for hidden resource group files
  fs/resctrl: Introduce kmode_cpus/kmode_cpus_list per rdtgroup
  fs/resctrl: Add CPU hotplug support for kernel mode associations
  fs/resctrl: Deactivate kernel mode associations when a group is
    removed
  fs/resctrl: Control visibility of global per-CPU kernel mode group
    files
  fs/resctrl: Reject mode changes for groups backing kernel mode
  fs/resctrl: Add interface to modify kernel mode via info/kernel_mode
  fs/resctrl: Allow user space to write kmode_cpus/kmode_cpus_list
  fs/resctrl: Add kernel mode documentation and examples

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         | 209 +++++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |   6 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  38 +
 arch/x86/kernel/cpu/resctrl/internal.h        |  49 ++
 arch/x86/kernel/cpu/scattered.c               |   1 +
 drivers/resctrl/mpam_resctrl.c                |   7 +
 fs/resctrl/internal.h                         |  35 +
 fs/resctrl/rdtgroup.c                         | 713 ++++++++++++++++++
 include/linux/resctrl.h                       |  81 ++
 12 files changed, 1142 insertions(+), 1 deletion(-)

-- 
2.43.0

