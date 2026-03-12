Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E663815F4;
	Thu, 12 Mar 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347973; cv=fail; b=O/NLhArTqnW3+dGOkuzKMpO4ymv52ZwDDQ96gu590NqAn0LZmK5XtKhezIhoFyKcSbECJD03O8T7DSctGWFeEOFuuSQLVKIfpPj/+CYbp6kZqKtuQj7ybm1ErfD3DYE9fbXqPrcO92i/QEsZxapKsCTdbIDAjVn2KJ7g6G3zCeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347973; c=relaxed/simple;
	bh=B7w/CpKWe48VT+mL9VYzc6mGRs9LLekTo6FEYcNYCZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mqrp3Glh/nYSgvVOeOmm35+ce7Q/rQSsRimOyGKgLJ+ZXpUK8fJS+OtOfGCCXXRPivDADagwx9Ey3QOSgOZqo8iEnk2iZr6ZXTO/3JXj9s9TK0ugf5/kPWtfqYhaCBb3W0z0bwObydr/V9QdwLrJgPu4AW1Nkyi+lIl460QqQdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T3p8zp7s; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T3p8zp7s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvC3T1W0yJf3kaGlfW1FGi/uSGHTzUkFc3fZYDSzUrWvQerAnkB8eJAgds2jhbKJzWVG1vzfb1RDm7Hlea+YVwkE0ADUjgh9PHwmYq7KmXUrgFMHCWl8KnPDESHU35hk9YRblyBvXw0O/GTeQwy42SXFkcBTxGQ4Jk/Z7i52MlwVA0hoBEDIeKgSS35zhUqdfBpnN1BhnJ+3mKz2AdfbDP4g17xlw0GbiRFOA5Ut8YrzRjMGGVL70gWI/MOisZYPP3CJO5pxLpjZ49DD/Wyetz3QZxgFZZnQ4mPj9QbE+z/Typsqeo476ipxn8WVWb7Am8BCQWpV1mhEo/IZjpdWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P8dK58culFkqcTx6EMXHzqv2VJzB1nStPi4Ms6/PHY=;
 b=UagXelOydXzeAiu7aAoZ9OqRV1FdCKRTGbUX4CaVLgbbxOf1DcRp/fxVBOo7Tq+jJGTHd3yU+i9PqInAgtztaOYwjRfN2lneqn9JofBzpoKYVGD0ZyxJY3JFhtZ0Q8t3zJ9PWM6VNJR3h06sho5a682LzOFGZWF+J+F0zvBHzXoaRJn/s8Va/PR18aUQ3MAGD/NiNG5dCGtcGBGco6jViRgEQaLT4cOKFj0uP5DoDYjOOG4iYy5lWBI0FGSAIWgaEm5vxOltct1SXLYvsQvKw2YMPQlCD9bYIEP0GSNW1pnF+g1ImaiQV/Kk1Ddd3nb663iCZtVbFvxUope9xDxXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P8dK58culFkqcTx6EMXHzqv2VJzB1nStPi4Ms6/PHY=;
 b=T3p8zp7s60Srjq6E9giH9umyQHNV4Wu1rn/r/WwLh0ol3T4SwAOgZ7T+5qBAkUK07MGqbL4zRTXEmDIRZy45gzQn9S0IUWTu7GCEW9VSssBhrYp54fXHKB9LPq7RO/GWG4/vCt8eEB0SW+a5r58eakcEhXQjN8m2RjQ13/LEzpE=
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:39:22 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::9) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Thu,
 12 Mar 2026 20:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:39:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:39:20 -0500
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
Subject: [PATCH v2 15/16] x86/resctrl: Refactor show_rdt_tasks() to support PLZA tasks
Date: Thu, 12 Mar 2026 15:37:00 -0500
Message-ID: <b22078b618513e2413a8211ceb0146b817a126aa.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 503ae0ca-e835-48fd-8846-08de80777179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LGuwqHmsf0VS0E2XMFi2I4BXH98sUVIOeQ2sSrhLtPOwK9VpacXCOCz0jEpb6WgHVbs4dcbbTJEuWvT6+ZFfBGTydRtw8mzX+SVx2NY9J/xBKNKT6IGcWU3NfidrnQKgxf2ap65pPOfu0l9Wz8hwGxRLLtDeFhea+AFn3XZ+jkyBiphGPtUlY87G4L6cG92WGLf5E5ThrQHOxoiKoirpyjhjzaqfak5mTJgFMQbx/czgrHs6DN8nOt5kW1OUgoHvV7+nqjoW7fmt8yOaAVZjIPBXgTlKPK8RBrPaFX71CNas68s8dlBECfIh371Pu5koy3/kvM5xpz6HdnGHIt73FhPX9foYf3HJlw5CiRt847SjczfASrMT9trRtrOBDd3XOE7smNaJxkrQVhEYJPQEvz/ECt0Q+8b6rX1b/PXa6P2B9PHxX8Vmj+DJLi1EwkdtVJeXCvgFHCfFOA3E4o+8B6Un8INX05zP/4DcGZKvEzFe4kGi/09CNET1OMEQfncQuOtbLmJvpxq7ydDT9+xy898vaapCIaBkM1NmfF3ASjq0Wz1ImorJ9sLC9Gq9hrA1ZMj/311stsD1Z27NtrHGkaQolorQ7VmEW9BLKKbJsj7wWB1Rce/3qh1Zp56nN4nPs0PrTCuk7T9KEqZLNXUvADP6Nbj+vPpcUwJmsv8FC17ZUwBJy1X9mxNj5Npx8+ufy/wd4U0PL1/SVfZi7aHz5V4Ig9/pGBgB0EjpXFmD8u0MAu4tefB7+amaz/y/Ec/+hd3KTLrDnwXrGnHUfg+1PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dFaUYgECpcy5mK/tWIe909QR+S7dI9Rw4e/qsQ60aBq7Hhtg9epW9hEpATOKCs7afR1cPNrTG4qQ+y3pv1/giEnlZKx77JVYPXFs9X6mF2yFAPArGOQSRLyE3qHJ+C3KL2bgWAbZJQNufEaQbPFHc0VtE7TcBFtIY1rzc33H0Sr/NbFIdsYhG6c1F57Vd4cAR+KmoqMYrGMoQqWaYohmvr/j9PpWhErncMaLA0ubU/V4Bq8K1agifnN8OtalVotEd5rX7VRxcKpVVfEwJJBmpoQuWEcOFd3e+00yt4QkM9AHvb3k95NEgEr+jb2A1spwm5cBWoNsHLSQziyADzAkGyZW3ZuHyv7F6O2gKdI8C3ENfSmY36GsLDsbfoxA2f03xu5y5ZklT2WZwheLv0fk9VXPIjiNgeG0xfJ4p9kWeTLm+USlJuS8u55fXjmkwycg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:39:22.5087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503ae0ca-e835-48fd-8846-08de80777179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

Refactor show_rdt_tasks() to use a new rdt_task_match() helper that checks
t->kmode when kmode (e.g. PLZA) is enabled for a group, falling back to
CLOSID/RMID matching otherwise. This ensures correct task display for
PLZA-enabled groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Added more code comments for clarity.
---
 fs/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 31479893633a..b41e681f6922 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -966,6 +966,34 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/**
+ * rdt_task_match() - Decide if a task belongs to an rdtgroup for display
+ * @t:		Task to check.
+ * @r:		Rdtgroup (for CLOSID/RMID matching when not kmode).
+ * @kmode:	True if @r has kernel mode (e.g. PLZA) enabled.
+ *
+ * When @kmode is true, matches tasks that have kernel mode set (they are
+ * associated with this group via PLZA). Otherwise matches by CLOSID or RMID.
+ *
+ * Return: true if @t should be shown as belonging to @r.
+ */
+static inline bool rdt_task_match(struct task_struct *t,
+				  struct rdtgroup *r, bool kmode)
+{
+	if (kmode)
+		return t->kmode;
+
+	return is_closid_match(t, r) || is_rmid_match(t, r);
+}
+
+/**
+ * show_rdt_tasks() - List task PIDs that belong to the rdtgroup
+ * @r:		Rdtgroup whose tasks to list.
+ * @s:		seq_file to write PIDs to.
+ *
+ * Uses rdt_task_match() so that when the group has kernel mode (e.g. PLZA)
+ * enabled, tasks are matched by t->kmode; otherwise by CLOSID/RMID.
+ */
 static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 {
 	struct task_struct *p, *t;
@@ -973,11 +1001,12 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
-			pid = task_pid_vnr(t);
-			if (pid)
-				seq_printf(s, "%d\n", pid);
-		}
+		if (!rdt_task_match(t, r, r->kmode))
+			continue;
+
+		pid = task_pid_vnr(t);
+		if (pid)
+			seq_printf(s, "%d\n", pid);
 	}
 	rcu_read_unlock();
 }
-- 
2.43.0

