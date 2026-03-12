Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88137B013;
	Thu, 12 Mar 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347843; cv=fail; b=bu4ITNkg/Zi2xwzZmkWx3LTwgd6fkvWTS3gA9Kkqqq9W1vrQ+gIRBmbtjGAEwLWSLeM+Is67bwyzET+TRW9d+mFOVgRz6jKV0KqJ4AnYQtImQv5pI5ar8Oofo30EJhXAXbMZJ44FzNwKWzJyi0i3pptmhXbOO45qRRDWyvoRaYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347843; c=relaxed/simple;
	bh=If7UazzBK7IVnKme3kOJip1N0Se4NVbUKB6h5pMIz5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pkFNMGeTatdS6WNrXF6mmb/P4Bk4+wcC00r/y7ARLOqP3XQUHLdCbHRwGAnZpyIhRyGt2S6kFJBh+t2MfFkeem89sLtVS2Vaxk6vgKlYWptI2+Tvl1zHKpX0Ha5Y7Lbd6j9nv3zBJ52qPnq/ENb8t7M7HXzkLiLrILpQxcv8rac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bjsyPhRQ; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bjsyPhRQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXFgGctUGVL8QKDc/M6+Y7qGw/kA2qQ3xCWUp44sG4jaruTjTl7hHOl1xrSVNcQ2dyaxGFENlFH+0D/RvzbupcUDnXfrQUWCu+Zn6WtITo/bI+KQB69fMCH/0hkFxuwseHXtpWLh3I8JAyoJs+x0EfCc5aBimHNpRv4zgLw71sjcrH1AxKkiOyjp3+L85Dp1XKNsGI2EMfjKm97dr8lyxn0fyLaQoHWklp3puNF1/AypyWVYTCugnM1nYrCYG09Vy0RYc4PECEfiSu0XRF6fr1DBBtHWtZumdQflIfxJKuOBY82R5oum32r0TYA15eFMq3VawTWA0JJyJrDx9zL68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPDS2OhLXnGjcR9jz90FaDxiOozOyfszw1n0XJtFcI=;
 b=XJh08Itah7m7k1HLh6Dgd+qQ+da9m3lN5t9mLbkuG9paQHZM6/PHbrOxnvmO/GkOEa4piR21HrrDB96OWbEqW65gKVWe921SruUh53f13lspXZXv9uD72IDM1kghBmQNgdQLXtkCrlURVR0tWRWy4Uwz7fqGjsAFTER+DhbrtXysgZblMKohdTmFM8T0lPYQbJ2SMfyaHo4t5nTm9NGkQwZH8vAlJQTTkxXGfA7xAu+ZLBnwlCxh+38SulGDKdb7nrToMhVA2mzHrx8Xd1KkpoV3//3QBJdU9I8SK74Uk9UDvJKC9hO6up3F2PtPD/s+la5+9ywpaM6zBoEzA/4NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPDS2OhLXnGjcR9jz90FaDxiOozOyfszw1n0XJtFcI=;
 b=bjsyPhRQS2ujEMtN9Ms60hhZgNbir+QsE+E2UQhAY9wCVAU2pjAe+iL+AO06AKBfYArkJsSJhgl0WeHO12F26S+152Vb9Qzx/3n6zWjS3/253BrfEamLLQDnvjs01a0DYiH2nDY1u6PJq8Q1hOGpRdXzhMX6NJUCLw7h+xJsbgM=
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 12 Mar
 2026 20:37:16 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::64) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Thu,
 12 Mar 2026 20:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:37:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:13 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <babu.moger@amd.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
Subject: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA) support to the resctrl subsystem
Date: Thu, 12 Mar 2026 15:36:45 -0500
Message-ID: <cover.1773347820.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a4aac8-8477-4fea-dcf4-08de807725d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|13003099007|18002099003|18092099006|18082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bI4RY4Wm9178dENVPe1Qj8um43l16k8bDqyIaJ2Ynb7QGRxthJatJhjS4+1AMIaIQzLozJCGJxsJD3qtXWr5RHRqmJyeuMBkaqhhLok5/NtHVNDjXRB0oWIfTsG3EM8TirAolL4CpOrRhxRb2MIefU6d3ae3+73gcMb7f6Iwxc9OG3ZGrIa9KdnZTaRdkVJcTXe/sP6Nv5LeVW+VV/P/XJ+c/c9de/dgZbQjN9DxXoDEKu05GkgX8OeN0r5uOVqg4VLJ2HS3ZErjAKX/ykDmQQ85RYXTHJsDLHcyu5gd7c7WeJe7puhVHIysFWJOE2XgF7hq8em4szz0mEcC9/07m0LpolJz0s1ERG49/E382xhofC024jcn84sd6E1bapatHSyLxzr+IKjtQtt4qFK1LWegyaCQiQn/OepwXqipUG+hoCMO2wgihYRnX5lJjHA3l0gPwwjd0dDbeT2AMjSaWB1VLe1a4eLu7Fot9r6gOnGkvcYCzB1XyLZQ0fT65mi61L3l9IF983RPFyZp6gFq5x8wqlTGtb7f1LGddEiSoE08kU+Ddb7yImoW1yEWOEiUHqXSV0JUDCq15a86nRVceTxqsUeVHzk+x2EnazSGTE2vH2nbqwRRX3MsvLk/qKXxr13imSc3TxbP+8BA01xogIoXpStPVeNjXh3QTBVXj3mfG79BCLeRqxy/BG+gnYEG2GszM0qFw1dYSrLgIqAEE0iCS53uO2DrNAfdlk5Gj7A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(13003099007)(18002099003)(18092099006)(18082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hiiAEPcJ/wfv5A6fQUYSpfgPITKkPMuiRo10aVgjaiHJyYTuwUR70Fx2OX3pq0sbqpag5e6oXxTq5NmdXIt1otCoEK6HqYsab3jcRw3Ppm0Xu4eywt0L2T1c1kIwKZH/cEvnvmZ4c9cmmVkBuANDXYZHg84CmaZ3xAijFmFuo5O63MMKCQY9GyqUVnKn0D5ZmTNLBH+Uqd0CcMraN/+/ZYfGBFzwFfcozPVglX1/DbyVtbQ89IcuEvMjTGvH4atLuaCBjtowDTNz+tfo93MgWWK9d8yVCO7q7FoDK3E4NFap3FmXVzryX3qH6rpUfuglK8IhbFSutoN1+LlVyVWHeSltcavVF7vqyUtsgKCqsWOkoRgWnFLFKgZTIVwYtwVHUzSJHn0Esd/zgeTSAN5NOXFttuY7slTI8QdOb4DjwEHsqA+fw2aU1l0GwL4ptZQQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:37:15.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4aac8-8477-4fea-dcf4-08de807725d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772


This series adds support for Privilege-Level Zero Association (PLZA) to the
resctrl subsystem. PLZA is an AMD feature that allows specifying a CLOSID
and/or RMID for execution in kernel mode (privilege level zero), so that
kernel work is not subject to the same resource constrains as the current
user-space task. This avoids kernel operations being aggressively throttled
when a task's memory bandwidth is heavily limited.

The feature documentation is not yet publicly available, but it is expected
to be released in the next few weeks. In the meantime, a brief description
of the features is provided below. 

Privilege Level Zero Association (PLZA) 

Privilege Level Zero Association (PLZA) allows the hardware to
automatically associate execution in Privilege Level Zero (CPL=0) with a
specific COS (Class of Service) and/or RMID (Resource Monitoring
Identifier). The QoS feature set already has a mechanism to associate
execution on each logical processor with an RMID or COS. PLZA allows the
system to override this per-thread association for a thread that is
executing with CPL=0. 
------------------------------------------------------------------------

The series introduces the feature in a way that supports the interface in
a generic manner to accomodate MPAM or other vendor specific implimentation.

Below is the detailed requirements provided by Reinette:
https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/

Summary:
1. Kernel-mode/PLZA controls and status should be exposed under the resctrl
   info directory:/sys/fs/resctrl/info/, not as a separate or arch-specific path.

2. Add two info files

 a. kernel_mode
    Purpose: Control how resource allocation and monitoring apply in kernel mode
    (e.g. inherit from task vs global assign).

    Read: List supported modes and show current one (e.g. with [brackets]).
    Write: Set current mode by name (e.g. inherit_ctrl_and_mon, global_assign_ctrl_assign_mon).

b. kernel_mode_assignment

   Purpose: When a “global assign” kernel mode is active, specify which resctrl group
   (CLOSID/RMID) is used for kernel work.

   Read: Show the assigned group in a path-like form (e.g. //, ctrl1//, ctrl1/mon1/).
   Write: Assign or clear the group used for kernel mode (and optionally clear with an empty write).

The patches are based on top of commit (v7.0.0-rc3)
839e91ce3f41b (tip/master) Merge branch into tip/master: 'x86/tdx'
------------------------------------------------------------------------

Examples: kernel_mode and kernel_mode_assignment

All paths below are under /sys/fs/resctrl/ (e.g. info/kernel_mode means
/sys/fs/resctrl/info/kernel_mode). Resctrl must be mounted and the platform
must support the relevant modes (e.g. AMD with PLZA).

1) kernel_mode — show and set the current kernel mode

   Read supported modes and which one is active (current in brackets):

     $ cat info/kernel_mode
     [inherit_ctrl_and_mon]
     global_assign_ctrl_inherit_mon
     global_assign_ctrl_assign_mon

   Set the active mode (e.g. use one CLOSID+RMID for all kernel work):

     $ echo "global_assign_ctrl_assign_mon" > info/kernel_mode
     $ cat info/kernel_mode
     inherit_ctrl_and_mon
     global_assign_ctrl_inherit_mon
     [global_assign_ctrl_assign_mon]

   Mode meanings:
   - inherit_ctrl_and_mon: kernel uses same CLOSID/RMID as the current task (default).
   - global_assign_ctrl_inherit_mon: one CLOSID for all kernel work; RMID inherited from user.
   - global_assign_ctrl_assign_mon: one resource group (CLOSID+RMID) for all kernel work.

2) kernel_mode_assignment — show and set which group is used for kernel work

   Only relevant when kernel_mode is not "inherit_ctrl_and_mon". Read the
   currently assigned group (path format is "CTRL_MON/MON/"):

     $ cat info/kernel_mode_assignment
     //

   "//" means the default CTRL_MON group is assigned. Assign a specific
   group instead (e.g. a CTRL_MON group "ctrl1", or a MON group "mon1" under it):

     $ echo "ctrl1//" > info/kernel_mode_assignment
     $ cat info/kernel_mode_assignment
     ctrl1//

     $ echo "ctrl1/mon1/" > info/kernel_mode_assignment
     $ cat info/kernel_mode_assignment
     ctrl1/mon1/

   Clear the assignment (no dedicated group for kernel work):

     $ echo >> info/kernel_mode_assignment
     $ cat info/kernel_mode_assignment
     Kmode is not configured

   Errors (e.g. invalid group name or unsupported mode) are reported in
   info/last_cmd_status.

---

v2: 
     This is similar to RFC with new proposal. Names of the some interfaces
     are not final. Lets fix that later as we move forward.

     Separated the two features: Global Bandwidth Enforcement (GLBE) and
     Privilege Level Zero Association (PLZA).
 
     This series only adds support for PLZA.

     Used the name of the feature as kmode instead of PLZA. That can be changed as well.

     Tony suggested using global variables to store the kernel mode
     CLOSID and RMID. However, the kernel mode CLOSID and RMID are
     coming from rdtgroup structure with the new interface. Accessing
     them requires holding the associated lock, which would make the
     context switch path unnecessarily expensive. So, dropped the idea.
     https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
     Let me know if there are other ways to optimize this.

Patch 1: Data structures and arch hook: Add resctrl_kmode,
	resctrl_kmode_cfg, kernel-mode bits, and resctrl_arch_get_kmode_cfg()
	for generic resctrl kernel mode (e.g. PLZA).

Patch 2: Implement resctrl_arch_get_kmode_cfg() on x86, add global resctrl_kcfg
	and resctrl_kmode_init() to set default kmode.

Patch 3: Add info/kernel_mode and resctrl_kernel_mode_show() to list supported
	kernel modes and show the current one in brackets.

Patch 4: Add x86 PLZA support and boot option rdt=plza.

Patch 5: Add supported modes from CPUID.

Patch 6: Add rdt_kmode_enable_key and arch enable/disable helpers so PLZA only
	touches fast paths when enabled.

Patch 7: Add MSR_IA32_PQR_PLZA_ASSOC, bit defines, and union qos_pqr_plza_assoc
	for programming PLZA.

Patch 8: Add Per-CPU and per-task state.

Patch 9: Add resctrl_arch_configure_kmode() and resctrl_arch_set_kmode()
	to program PLZA per domain and set/clear it on a CPU.

Patch 10: In the sched-in path, program MSR_IA32_PQR_PLZA_ASSOC from task or
	per-CPU kmode; only write when kmode changes; guard with rdt_kmode_enable_key.

Patch 11: Add write handler so the current kernel mode can be set by name.

Patch 12: Add info/kernel_mode_assignment and show which rdtgroup is assigned
	for kernel mode in CTRL_MON/MON/ form.

Patch 13: Add write handler to assign/clear the group used for kernel mode;
	enforce single assignment and clear on rmdir.

Patch 14: Update per-CPU PLZA state when its cpu_mask changes (add/remove CPUs)
	via cpus_write_kmode() and helpers.

Patch 15: Refactor so task list respects t->kmode when the group has kmode (PLZA),
	so tasks are shown correctly.

Patch 16: Add arch helper to set task kmode.
--------------------------------------------------------------------------------

v1 : https://lore.kernel.org/lkml/cover.1769029977.git.babu.moger@amd.com/


Babu Moger (16):
  fs/resctrl: Add kernel mode (kmode) data structures and arch hook
  fs, x86/resctrl: Add architecture routines for kernel mode
    initialization
  fs/resctrl: Add info/kernel_mode file to show kernel mode options
  x86/resctrl: Support Privilege-Level Zero Association (PLZA)
  x86/resctrl: Initialize supported kernel modes when CPUID reports PLZA
  resctrl: Introduce kmode static key enable/disable helpers
  x86/resctrl: Add data structures and definitions for PLZA
    configuration
  x86/resctrl: Add per-CPU and per-task kernel mode state
  x86,fs/resctrl: Add the functionality to configure PLZA
  x86/resctrl: Add PLZA state tracking and context switch handling
  fs/resctrl: Add write handler for info/kernel_mode
  fs/resctrl: Add info/kernel_mode_assignment to show kernel-mode
    rdtgroup
  fs/resctrl: Add write interface for kernel_mode_assignment
  fs/resctrl: Update kmode configuration when cpu_mask changes
  x86/resctrl: Refactor show_rdt_tasks() to support PLZA tasks
  fs/resctrl: Add per-task kmode enable support via rdtgroup

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         |  69 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   7 +
 arch/x86/include/asm/resctrl.h                |  92 ++-
 arch/x86/kernel/cpu/resctrl/core.c            |  12 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  77 +++
 arch/x86/kernel/cpu/resctrl/internal.h        |  26 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   2 +
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/internal.h                         |   2 +
 fs/resctrl/rdtgroup.c                         | 635 +++++++++++++++++-
 include/linux/resctrl.h                       |  40 ++
 include/linux/resctrl_types.h                 |  30 +
 include/linux/sched.h                         |   2 +
 15 files changed, 989 insertions(+), 9 deletions(-)

-- 
2.43.0

