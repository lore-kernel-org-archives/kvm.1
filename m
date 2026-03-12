Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0B374162;
	Thu, 12 Mar 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347850; cv=fail; b=iX4cUP2QDfKzwSzxHnIt1KWe/DNHruMeSca70LygwrX+OgH66HXdmx/8G3DN9AkcEzuyRRgXxsSuumT2nqmGvYHs6VSi3pXSNFZuq4bKDDaoEKC2EIyQIAXr9QF0hh6x5I6X14lgeAICzVF4utcomLKpIUwFI/9trn6wykjmTOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347850; c=relaxed/simple;
	bh=LZwC2yhfGjSzrOyVVOvbiRkMZIHZukXmBKXTHYY1Y9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvFd256rEkaqgzaFrnc98Ir5WDAzmjFUrPgtwUL4zVKRCrehaG4/n+C9LOOrzUyK6RCOCZKEoTxwj6G13hfiUF36cC//hs4c4xRFcWwAcgZggSvFEajfjvZd0z6teW98tcF76Z8VB7J9V7s8laThC+RhbovobdqE/poNpYHjuEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XbWcMfYX; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XbWcMfYX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1Ub+wwhaZMpS+6Z5FgwPzuy0YBxMMpE4i9jRcmiBcJgKhOzkyuiuyHdwLLtIsCZysm9GGR2RN05Zy8ABTyAxVI4MDldLCiPPtkAUObcZl0juuuYj6RapPIiYMaf74VyduaKMpfXsD4WUKxoRlPwTMtL/2kY/MIdLDtdHh4gOnBTCBgPpQ/bkrvmzPa1EgYSekNqORnTbWEVZKZEYWPyg6Ny5yI5eifkm9ie9fCn8Hj6MkqxPyttMru5HiSPQh1g0jJeHAAvT6e8D41lu13+Fp3PuQHpgEjbPyIVaISKZG194e8xt5qqV4+wRtbu4p/IJSFW53pCkI7IwYZVVyR05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+VQ5jkS9m6C4J1QBhef2ptcLSFrnPV4NcVj86hTn+o=;
 b=IzTHksSIlWb02rDttHP9IqIr8MUwpDtBu1dZHfoYPD4+aAmT1MlD7Kpfjisc8qJw7QdsgUvYIM3JWUI0SrJ6fe+Kk8x2GYp/QuWsGqrlePujGeTJcMuX8pUc7C6oeGJ4xDC3th8QWn1IQjEgvzF4iliAUB/L26G4rm7KzVWBuIKsGJp8mO2Y5cx7RhcTZX8zwaf5t27InqnVgB2JMmnjgGLOynFg3uM/zp5XS7YrC2k8lvD9XU7vhnbGkavSCJx09JcuOi/6nep9wnYC60a8ftPZURkPHmEgTXyuvLVWPAxj9rHe4BdUosEF6lTcT3i9fJ/OaszbsHwIDOpbhpI8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+VQ5jkS9m6C4J1QBhef2ptcLSFrnPV4NcVj86hTn+o=;
 b=XbWcMfYXyevS89gw/JUu1Rj4cCjIZyD/edCl1G/Uzz4+wCxfYC1fDJ0yAVkMfR70yALh7uD30psYLxet42nK4JoMx3XBcSsYDCSWnOWF4P5HDuqAYDixiAZk1v7IuIsWXq86h37Vq+NCsuGp4wyqh3znjYLKIycyIN7uOYwUfAo=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 20:37:24 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::c) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 20:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:37:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:21 -0500
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
Subject: [PATCH v2 01/16] fs/resctrl: Add kernel mode (kmode) data structures and arch hook
Date: Thu, 12 Mar 2026 15:36:46 -0500
Message-ID: <c3381fbbce357b00895252572907645a92cd9718.1773347820.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773347820.git.babu.moger@amd.com>
References: <cover.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3253d4-04e1-4ddd-5f72-08de80772aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GzvHRhNNV+bcx/zPc/EqdV1CHZ6YVywjpGJ5ZewYk702luxRM2lgbPvpcMbX35VrvOJNBq4p5qyMmpVBFpKqKzgQRznoGasJJ5GpTN7/QfGWW99TIw+QyPdHU9fRK4QoC6Af4pE0cgr1J2DHzAH4HY7JDvfSFh3tiCKWDUI7B5kcF6qeo3iWhXRNBnqmq+U/1dKC+ZkkstNxF3l65awmoccLaRPSdlmBoCAuRmhnQESsVAvenGFIEwXjYAkGUv0zaB4OksbuhtOVdVkR8XDrVr1oNgcEBhBnFKFZkz7rowHDnBcTtM0GcivUTH5IkFtb4wiEghwFVzEjWht+lYVqFxqZRCWsiHNel/rrmIWG1ZpS6tsKaMQF69IXy63wHiJSACIGDawGABQNCu1fVs2cr3ND1lUxDUVJNSNNOiPodyO78iNK9kfdbJ3uOHDsaEe043d3GiVLIAGb9B8xhtmLfQ1oUDE5FbpTYFxQbq1jkfvMMHleUowdu0XeqNlhpRLIpaDVnzo9S1qH2GH9Cm876xcVWut2t9cijqzcsA7nyXybEtxmVrmcq+t1foilauPqyTGlUIv8Wz62mHY+rDtt51KH6b6hLyNzQ9XgVPLsXWIhcsvIcYtO951SetAwtU8XMHz6cs9dh7kdCocxyaVbY31y7B4FMB4776nIlE6GlVJOlAhW9FwKgSslWlxuUoNbOuzUkdEI+Rdl7MXtOy4eFKalGVIMhLYR0b1d91UjiBhdGOaZXmwy+ph23ivicCvyp2M3PpOnaiSH768kpZa9Ig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R0lBaIQQIUgAzEH7EXNK7LF3XIXVmMNlZ09nvy55NWwxB1CmvVJY/EIVHOFustUreKMUa0kyys4/VWHbaFT6UGPBshRL2qJLeL1trLUbWpPLneOo44OZWX2cqmfEsjIG6Zz5T4yIUGQSrsE+x6dp8N5zb1wznsiwbT2IO3JPGUZRGO4zcS68h5ZDJ7+SXPfPm3DojH1pVm/YBvSbusEOlrsPB3meMUXqC6df5iRrSHCkw7MESvehKwFqBbzfILmmN7r4W5lMkslqzBjRUS0xLx03gJovtAJ/dBPxRxCVU8UU87LHFDF6hdypf8risX3CTujr538Y4Qh07yk2/G7RSCOb9+a2TwyiJj+uT5xTx4IlDLzPev6Mu3fbqXf/kjGiDkksBmS2+NbrN6D49LU4fwcsIyaaYnRZg5Vjc9dJlwPr+FNAI3vCpXtw0mJGNurM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:37:23.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3253d4-04e1-4ddd-5f72-08de80772aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

Add resctrl_kmode, resctrl_kmode_cfg, kernel mode bit defines, and
resctrl_arch_get_kmode_cfg() for resctrl kernel mode (e.g. PLZA) support.

INHERIT_CTRL_AND_MON: kernel and user space use the same CLOSID/RMID.

GLOBAL_ASSIGN_CTRL_INHERIT_MON: When active, CLOSID/control group can be
assigned for all kernel work while all kernel work uses same RMID as user
space.

GLOBAL_ASSIGN_CTRL_ASSIGN_MON: When active the same resource group (CLOSID
and RMID) can be assigned to all the kernel work. This could be any group,
including the default group.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 include/linux/resctrl.h       | 10 ++++++++++
 include/linux/resctrl_types.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 006e57fd7ca5..2c36d1ac392f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -699,6 +699,16 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
  */
 bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
 
+/**
+ * resctrl_arch_get_kmode_cfg() - Get resctrl kernel mode configuration
+ * @kcfg:	Filled with current kernel mode config (kmode, kmode_cur, k_rdtgrp).
+ *
+ * Used by the arch (e.g. x86) to report which kernel mode is active and,
+ * when a global assign mode is in use, which rdtgroup is assigned to
+ * kernel work.
+ */
+void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a5f56faa18d2..6b78b08eab29 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -65,7 +65,37 @@ enum resctrl_event_id {
 	QOS_NUM_EVENTS,
 };
 
+/**
+ * struct resctrl_kmode - Resctrl kernel mode descriptor
+ * @name:	Human-readable name of the kernel mode.
+ * @val:	Bitmask value for the kernel mode (e.g. INHERIT_CTRL_AND_MON).
+ */
+struct resctrl_kmode {
+	char    name[32];
+	u32     val;
+};
+
+/**
+ * struct resctrl_kmode_cfg - Resctrl kernel mode configuration
+ * @kmode:	Requested kernel mode.
+ * @kmode_cur:	Currently active kernel mode.
+ * @k_rdtgrp:	Resource control structure in use, or NULL otherwise.
+ */
+struct resctrl_kmode_cfg {
+	u32 kmode;
+	u32 kmode_cur;
+	struct rdtgroup *k_rdtgrp;
+};
+
 #define QOS_NUM_L3_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_EVENT_ID + 1)
 #define MBM_STATE_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
 
+/* Resctrl kernel mode bits (e.g. for PLZA). */
+#define INHERIT_CTRL_AND_MON		BIT(0)	/* Kernel uses same CLOSID/RMID as user. */
+/* One CLOSID for all kernel work; RMID inherited from user. */
+#define GLOBAL_ASSIGN_CTRL_INHERIT_MON	BIT(1)
+/* One resource group (CLOSID+RMID) for all kernel work. */
+#define GLOBAL_ASSIGN_CTRL_ASSIGN_MON	BIT(2)
+#define RESCTRL_KERNEL_MODES_NUM	3
+
 #endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.43.0

