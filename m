Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453A389109;
	Thu, 12 Mar 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347918; cv=fail; b=B2qW09hhEem98eCYtgXVYNubIiMxImIMrTQNuEjZ6rwy0PlsL1vWqhV9wco8nOovZDBZZ7u6/1hM1AJvQDx9y0NVck426XL25pURedW2rg/d7y/qjWBjn9NpvFJ9eXclxwXGaGCSTA/Frs/8sJV3/Af8Ou9b0wtbP8f3bOphkXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347918; c=relaxed/simple;
	bh=B2aGWhXTql8tZArIiiUUsoZPITyBHCIWN/W5hGULhZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqdHU8VBobPP0uHwZdL4mMTzPbkr5rZYZcA9PZCKg9QcnI4C8nCUnbzA5HD6vmKqUehJVlb305k1CJnD2Cm19R0I/pxSBE5kahigE2FvxdUtQp1gIET6a3se0RMaKzfz3UpBCmk9J5GO9+Wos5P4A6NvE46Bd+82BfE4DFueKWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZAhgF+M; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZAhgF+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOO73lthjqeOajSjhcsXF+3H++usQ7gFjDJEwF+We9ALqaZ4PqG1rjDe8S8u1pZej9ULvxkxFMFWPMpeQ0ws0PG6hzJ9NKMJORXMvO5j14edwQaEepAjEUw/HA6BhS7KBnWSxr/i7tnKFpP2vhtYHHnJu2F0a0wc2S8BFIkVrzKN3o3hsWllkZYQAQJgaCXPY3eTeUlhjnmU4AKwbWFGh8CO4e8DQs9fYuwvRx0k8/ggNjVLODUNyRtlvzxLVlHleWSP3KFJFRcZm2+9n+1u7Ox4St9zZySua9X7JX3SMk15c+HhJZPz2fI/b5Hb56iAqldFvVKbX6/lZoGtsQ9UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8NQdcMsRzcVftojZ3P2JqwFtt72iVnVkt2YXOzrefs=;
 b=EtyJBkSgEyDznXSfxbIhl01ZdvWbeQMm+icOd8MapIlX2oOPLuVFASioazxfWexdnqGTSUkbkNenmb2DbiLw34d4zcdgoqTBoAMK0PHx6DIfJm9RyuR6uBFGEzW60BXybcUTxv+RU6JHTXxMAA0rxO8w6MrMyH4FOsD2q+NmEHei0jzq1KW2TFVoAyPBKunjaae4U931ZwENGYZWNC+ohLOxIFDPfwfIDPMQRvlXgjHI/K5E8IN5YfC/m1ZNWRT42dCZbFKYr/YEY2tFzow0Vz3ysNRsP65IWSPMQdwF3hFXYTYfZxwDz0vWGauE/TLH4WwxW5y6thYOL+2VCeZ4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8NQdcMsRzcVftojZ3P2JqwFtt72iVnVkt2YXOzrefs=;
 b=CZAhgF+MLQi50eUqR6wo+Egko8SUi4MpMnlvLBmPqM/o6H4cmDYxaNRdMvJ3P+OX9B18EAt4WaYMIEHESSFem69xqhpqV7SQ19lun5ywJmBzeZgIw20Vahenjg+Z3A7Qhf3RYxPrCV6Y65jZ+VzTqut4JF/UbDZ566Z8tLHFDxA=
Received: from SJ0PR03CA0168.namprd03.prod.outlook.com (2603:10b6:a03:338::23)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:38:30 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4d) by SJ0PR03CA0168.outlook.office365.com
 (2603:10b6:a03:338::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 20:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:23 -0500
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
Subject: [PATCH v2 08/16] x86/resctrl: Add per-CPU and per-task kernel mode state
Date: Thu, 12 Mar 2026 15:36:53 -0500
Message-ID: <cb7276e8ea2ddc392be79460efd5ed6cda76ebb0.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6df55d-bebd-489c-227c-08de8077522c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	huc0//eB/j5biwdYKMv2N2VV5gcrVTLOFGaApdU50inQwCi9zFl3vLv0+oHTJf+hjuNyeDp5Cw/xlw8aL10jQnjY9c6/tlxF7p3zPF/cPV0IyeQhgfV/QHikTRgQTw27d2V8XLppp63eAfYiS7XUhLYskzO19M3ISenS/plQbvAy0ya2VeRgOeRZ1MSJa/AIi/BincPg9V6sF6iVuPjj8OIpVM0tGow3ZVXHXEldONec1njrMemoeVn9RjpYyPmw2JhLm6ZP0mLTm8QIML7pInhqEDdf/01711mrj+PPMW3jwCyW+6mecSagqT17Ij7nOPMWkMyW4DwKco9RZQ4qpXIpcju28rW4OJS5Ja3rLJJrOXKXDbqvVwKdOr9RMvBiODu2ixjgiLVWHwLx7AtUIwqsEauNS4JghqF6YB2ViaAhX7iAggejY6E3To37bsjjzdqOx77uX7614qN9dpHOU/GacHUCe/NNheFvofB8DpXzsnu9M9qpEQaSOQ15oiXpyOVappzjPECQSuXoPXFrkZW0MnnDV1AvmjDohGve0wIaUPogY0uoYhEz/b0qJzdhFCP0ccYXJsqj+owxPdY2q82QYuQ22v6gbhy78vwMLjQ7d4p1XapjwDwC+PRg8KdTITB0KSTcExOEXr7W1konk/Qd9Q3PISHjBumk0cBzJULQtT6CyxCULW8z+hN0Ws7oIZxVsznVe0LA82Zgaemjg3+rBeD8CSKR32kO+uzmER13mMC7CJno1QhI9Z9DLgu0o8vINMMZEy8fI7DQFAZXgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XaU3uqObDQJI2ScUkSxm0BGQvbd1ODqRLOorbzjeTotBlp0oSfb+kwG5/jgxA3Cv2SpSHv0ypCTh7uGl6y4G4RS+tPRscJ7iyUMcL7G9vaVqw/gb2i+u/h9ttVOJbkEfU/wy/MOkHGVddb+AiQnwTI2kcYRT9nKf1KQlFsUheJFUunnRGkAVuN89KmCXD8IK55UB9VE9aHL8RmxSEfwCLHPa4z9KYGz9RGGb4w+edGiAH4Sx3klPqw2nkhbeUO86cKz7/irQna0dHWRUHKLpDoVN2H51iEl8O4rIm+C7lCqVz9zxzQivbpDTDDabUFrPZ6sCBpeOC7K7diaBwwDES3eBFLunp5P8l2aYpC8i4xfsuJ+fKHiabza9nMpa/2VGQbw1iTwGZTt2C+rF6bHXtjUulxH/u2nSX3TQNn2lZp5X3/IN7GN1KlOg4zPruVwV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:29.9911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6df55d-bebd-489c-227c-08de8077522c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Add per-CPU state and per-task state for resctrl kernel mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Minor name change from plza to kmode.
    Tony suggested using global variables to store the kernel mode
    CLOSID and RMID. However, the kernel mode CLOSID and RMID are
    coming from rdtgroup structure with the new interface. Accessing
    them requires holding the associated lock, which would make the
    context switch path unnecessarily expensive.
    https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
---
 arch/x86/include/asm/resctrl.h | 14 +++++++++++++-
 include/linux/sched.h          |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 4b4291006e78..e0a992abaeb4 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -21,9 +21,13 @@
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
- * @cur_closid:	The cached Class Of Service ID
+ * @cur_closid:		The cached Class Of Service ID
  * @default_rmid:	The user assigned Resource Monitoring ID
  * @default_closid:	The user assigned cached Class Of Service ID
+ * @cur_kmode:		Currently active kernel mode (PLZA) bits for this CPU
+ * @default_kmode:	Default kernel mode bits for this CPU (e.g. from resctrl mount)
+ * @kmode_rmid:		RMID used when executing in kernel mode (PLZA)
+ * @kmode_closid:	CLOSID used when executing in kernel mode (PLZA)
  *
  * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
  * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
@@ -32,12 +36,20 @@
  *
  * The cache also helps to avoid pointless updates if the value does
  * not change.
+ *
+ * Kernel mode (e.g. PLZA) state: cur_kmode/default_kmode hold the active
+ * and default mode bits; kmode_rmid and kmode_closid are the association
+ * used when the thread is in privilege level zero.
  */
 struct resctrl_pqr_state {
 	u32			cur_rmid;
 	u32			cur_closid;
 	u32			default_rmid;
 	u32			default_closid;
+	u32			cur_kmode;
+	u32			default_kmode;
+	u32			kmode_rmid;
+	u32			kmode_closid;
 };
 
 DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f..2ec0530399be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1328,6 +1328,8 @@ struct task_struct {
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
+	/* Resctrl kernel mode (e.g. PLZA) bits for this task */
+	u32				kmode;
 #endif
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
-- 
2.43.0

