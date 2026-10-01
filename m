Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8E52269F;
	Thu,  1 Oct 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867640; cv=fail; b=ZaifpKKbzues9+t1DCG1j8DbDELOnSlNFIx2R0JxCTuBkv+gVk5X44Ewa1AK16l0uh+oE8eEd7GeSxY4St1hW5pThNOqZoAg11yndZps8lrNC5Dd25i9U7EF3ZiiXfCKwbyUha7OZJZk/O6GEaseE64inIMI1rrSqbXl4lrkXv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867640; c=relaxed/simple;
	bh=2qCrh4W0YrWFjYXQcYIaXSA/bhGF4C2rBhSfKwk/y+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePCTMbs9TNEHOHOZnbAZLaZIuFPa13Sk7eZPgVbigNABIH/3V34+MXlvSDhYFt3EMOiCbI9++arCUBh1t0maLX4S1D7xkWrc1bButASPGL/C+lLf3xhy6vbijxgJC04ctZbJC44rOd5V/VHx1A/NUK27ddk6E2mbfhkNPPawA6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndWP8+Rb; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndWP8+Rb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYLWXbEXDIHKrzKRLrVIV9M+dSRKRMUIPU46ZpJf2jGNP94RBIc7q6rMUdu5tonK/jDg0vaO29IxbqTFDMxxpsEieJ1eACCSMyB+S7XmpIKm1ibUn5enZIqgUBCEDjLIZqgQLdwcC+lqAoPT8a5amlrXrKUrXYiMe3XLqIC/v3zdVCg5g3q3Bw3pOlmq7KqUDyxGs6huh5EifcYZhDpLc/izD3qLCMKKpNi78J1Rjfx7XpYeOMhl2Ct+anHJZoTr+pE9S8jK1Wyzl7wxVrsbZMCqN/4FKqMzIMQh51IYWPp5gdG1Dx5IfdaAqypHIPNqwDtbuYeLJ7iOQW592EnFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77edS3kbIGMYuPoHzVNsDUiGvb39aAjlqUWZ4wZbE1s=;
 b=EdwD5/sSY6rY+c+p1ocqYCPJCOjh99J1Gm2VqUZA2NoMWOQUxsY4M3HydcjnYZJBULkX+c0EitmIBDa4rr724pzyyiCQYaJlBCuEsAAeeVqzqOaUhgDm96FqayZggMxu/Ux5mdg+vPe/cngzyaUnr89rLmVKhiUahYR9BZbccZP7aeBIZJdqPiaaNqgsROPG9Uo7rdS9Dlrd978aO6KMkqSGcYnTxx5tXjIiDOScNqnoUG+FHDSwXlkH9I6d+NtQT694MsnWSZNxYIPGF/+ZGTSw7ITVS4/bHYOX5XLtFPy7Tevwm2Lc5sgkSoFUnMWjjlnyqlil/EA0OXNlqEmMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77edS3kbIGMYuPoHzVNsDUiGvb39aAjlqUWZ4wZbE1s=;
 b=ndWP8+Rb6dXnCCuVtyv9k80Kp9xBEcyzYLTSaoCtAsa0hS+E+gqqz2TqsDY/NIo0USUGW2yIxfzyChgITyO3uK/u59qg0/s7d82lB1phZ8lUz53cjEn4SB/1Kp1XjJzI2OfNlUGFF000tSs7Cx0tkiQmebcnmE4mFqB/ICag+KI=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 15:13:36 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::1) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:13:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:13:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:13:34 -0500
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
Subject: [PATCH v6 18/18] fs/resctrl: Add kernel mode documentation and examples
Date: Thu, 1 Oct 2026 10:10:41 -0500
Message-ID: <92726abc0b3248b90278158ec95748da30d3e941.1790867441.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9366e4e0-a1da-4e04-21a4-08df1fce90cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SzQ3oX4ZpXrimtULQbevahOOIgUoimkQLGN0H31pYz3CvRGlW0VvFbCSgK26O/9vQgcdVDiuOXCZlCV8ursBtq2DhGG4MzjwN7PJgYPTtMOGfeUKCqfVacHY0PrCxplBhlAzgJWCgjUG1+c6JYm2U7Kaw5OAivTUod76QGC0YNEoavHNRnBMsy3S+rb7eppUY/L1XViR7b1UqQDQL74oFqxbUEh0URBsR/RdfwB/Dm9uO4COc3TYBs/2mLpc6fyKeCnPwlTyPYJuOMgDPXiDBOycxpC88d4a5HOhzwB6mnYP9Z3DIN9fa1/0tkFBJiEUGnxn70i6KKaN31k6JA0qWRkOdjh50GeHK5BFPHGKmusxB567IJzXyHd/WeL4D1ajgDXVKkIaGq+igw9ZCrln4QJkvlPXaFTb4ISEWUqFx0wq9BdPo/1DN53/qFt1+HuanUPnC7xp31dl2X0FAxhjES2XOgs/gl+cuU7agYyyFEEMjlkujgWdR2zmygD901KBF4R3R27BsaXyqXIicEoLqWJiVV6B1GzFtyZ/pFtS1Hjyf+477iz+hvtqrpTQMVsGwVwu/Mru722/sAn934pfB125LTc3awFfVi0BYY+OjFdN182JwnVrget3BSIAyBNG2PdDw53A/dWXfXc8bVffRS/Lm4sahTtUSCNBDb5YqKJttWpENdtOt1xXDPQHfu2HhoPPIcEnZzZKFEMQTZHZbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hymmtyXeTV/LG4Zao/VeEWVAYn45jmka9BXQ+KPF5PkNzHbe8DGodPxbU360bNll9YoS4CLzMZtQal7epWZTmCYTvdrnZHZSuDmc4J17R9XK1nk5s3kX5uj5u+YtwGiBqOdoqacbuFnDAbUGh04BJJXM52WDl2509qCYZbKRGqKgXPKZFgv3CzeYh/7mgB0FprdjJfTnUed7lnOuis5rDzmEvMI5NmeoOtJJqcEjqLv7sTU3dxku5TEeGFrxMw/7eLXTK0RJuXeCfIG+Zz15M5BISKIZUllw6Ey8EEURykF/cU5echeYJoa8N80Fm553Gg5txNf8UOIBLqH2QF1mlINlv6N7G0Wh//jcAznhc/xuBqqR6BMaSwuca+MBZws2EhAsalsxYbgai8+ZSkTa2uagrf/ikndy5IJb8L3hqfTLbOqy8wREpuZAmZzcPekL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:13:36.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9366e4e0-a1da-4e04-21a4-08df1fce90cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Kernel-mode configuration is exposed through info/kernel_mode,
kmode_cpus, and kmode_cpus_list.

Provide examples showing how to query supported modes, configure kernel
mode associations, and manage per-CPU kernel-mode associations.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Renamed assign_global_enable_per_cpu to global_enable_per_cpu in the
    examples. Replaced "policy" with "mode" throughout.

v5: Update the example for the collapsed kernel mode model:
    inherit_user and assign_global_enable_per_cpu with ctrl=/mon=
    association options, and <CTRL_MON group>/<MON group>/ paths.

v4: New patch. Added examples in the documentation.
---
 Documentation/filesystems/resctrl.rst | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 0d9dac38210c..c0999d4d96d6 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -1888,6 +1888,108 @@ View the llc occupancy snapshot::
   11234000
 
 
+Examples on working with kernel_mode
+====================================
+The kernel-mode interface spans three files:
+
+- ``info/kernel_mode`` - select the global mode and associated group
+- ``kmode_cpus`` / ``kmode_cpus_list`` - view or adjust the CPU scope of the
+  active association (visible only on the associated group)
+
+The walkthrough below covers a typical workflow on a platform with PLZA
+(Privilege Level Zero Association) support:
+
+1. Discover supported modes.
+2. Associate ``global_enable_per_cpu`` with a control group.
+3. Narrow the CPU scope through ``kmode_cpus_list``.
+4. Move the association to a monitor group.
+5. Return to ``inherit_user``.
+
+a. Discover supported kernel modes
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+
+  # cat /sys/fs/resctrl/info/kernel_mode
+  [inherit_user]
+  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
+
+``inherit_user`` is the active mode. Kernel work inherits the resource
+allocation and monitoring of the current user-space task. The second line
+shows ``global_enable_per_cpu`` is available; square brackets mark
+the active entry when read back after later steps.
+
+b. Associate kernel mode allocation with a control group
+::
+
+  # mkdir /sys/fs/resctrl/ctrl1
+  # echo "global_enable_per_cpu:ctrl=assign;mon=inherit;group=ctrl1//" > \
+        /sys/fs/resctrl/info/kernel_mode
+
+  # cat /sys/fs/resctrl/info/kernel_mode
+  inherit_user
+  [global_enable_per_cpu:ctrl=assign;mon=inherit;group=ctrl1//]
+
+``ctrl=assign`` uses ctrl1's allocation association. ``mon=inherit`` uses
+the monitoring association of the user-space task. The group path uses
+``<CTRL_MON group>/<MON group>/`` syntax; a control group alone is written
+as ``ctrl1//``.
+
+When the mode is active:
+
+- ``ctrl1/kmode_cpus`` and ``ctrl1/kmode_cpus_list`` become visible.
+- All currently online CPUs are associated initially.
+- CPUs that come online later are added to the association automatically.
+
+c. Narrow the association to CPUs 0-3
+::
+
+  # echo 0-3 > /sys/fs/resctrl/ctrl1/kmode_cpus_list
+  # cat /sys/fs/resctrl/ctrl1/kmode_cpus
+  f
+  # cat /sys/fs/resctrl/ctrl1/kmode_cpus_list
+  0-3
+
+The write replaces the association's CPU mask:
+
+- The association is enabled on CPUs added to the mask.
+- The association is disabled on CPUs removed from the mask.
+- Offline CPUs in the mask are rejected.
+- An empty mask disables the association on all currently online CPUs, but
+  later hotplug CPUs are still associated automatically.
+
+d. Move the association to a monitor group
+::
+
+  # mkdir /sys/fs/resctrl/ctrl1/mon_groups/mon1
+  # echo "global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1/mon1/" > \
+        /sys/fs/resctrl/info/kernel_mode
+
+  # cat /sys/fs/resctrl/info/kernel_mode
+  inherit_user
+  [global_enable_per_cpu:ctrl=assign;mon=assign;group=ctrl1/mon1/]
+
+Kernel mode work uses ctrl1's allocation association (``ctrl=assign``) and
+mon1's monitoring association (``mon=assign``). A monitor group requires
+``mon=assign``; ``mon=inherit`` does not use that group's RMID and is
+rejected. Changing the associated group through ``info/kernel_mode``:
+
+- Resets the CPU scope to all currently online CPUs.
+- Hides ``kmode_cpus`` and ``kmode_cpus_list`` on the previous group.
+- Shows them under ``ctrl1/mon_groups/mon1/``.
+
+e. Return to inherit_user
+::
+
+  # echo "inherit_user" > /sys/fs/resctrl/info/kernel_mode
+  # cat /sys/fs/resctrl/info/kernel_mode
+  [inherit_user]
+  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
+
+Writing ``inherit_user`` clears the active kernel-mode association and
+hides ``kmode_cpus`` and ``kmode_cpus_list`` because no group is
+associated with kernel mode.
+
 Examples on working with mbm_assign_mode
 ========================================
 
-- 
2.43.0

