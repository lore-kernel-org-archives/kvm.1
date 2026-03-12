Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78237DEAE;
	Thu, 12 Mar 2026 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347977; cv=fail; b=jNRrLYDEAA1RYE/wIN0Wb9VD8mr8pqAw+yFg/mHWWmN4Y+1u9WRySrxPffZ1gtcXSMZyrEMVA2Zb3uoynZPRoxA74kbl89t+4g6wrYg47n/LaelUMIN77lIlkM/SLq10baPO7LxKyaz1G3xllrFx5iRqTSsnlcpMOx54coShaeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347977; c=relaxed/simple;
	bh=jKM9FkSjrzWrkPpsisfV6uCds8FDHlHEymWNMM7gKfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiNJzBc3i8CAE/vAHiAiYxNN1BYVGuEgw+jcs7PKGPtXJ/nzUFedoZ2WAcClYEhqmZgEJQDSgIZiQToSIvkt27jPzrQeROMjwpyvd+2LRZ7qdcANinBByx5p0/d5ipPkz5BEuIAc3byGJjJ6ykg6KNYMJMsbfowEdj43kB/aveQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lKV1Ezto; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKV1Ezto"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kto1FauL6P2eqR4sXbWAxnu5iZmRYB0yuEpM1wP7TlgfQ4JCaOMdskF6iMIk8JeMJWSlTOQhQjXluRwPxRMx/2G9GkcOPNpBYuLuzvKdlc+p0P5BJiy2r9bu1vzZqRrWcI4sX4hsPrqJ1cqdSWchmBRkysDdTAmT7ygDqBghspUk2P4efDhDTRu7CPoUitk/z0WOjouBku8WpFgrUZFgNjmDzq0ABD1PLhd3xVENs/e0UtIWWfeNenmAouqAbKqmloNxL/2ZrkJsu12pQgB1jhCdM7CpjgoIEPfWKvGLxvJeguY5K2Rp3PzZORbfKYhYqc1g3XeNbRRUJ+HeM8H2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SngrGLAk6sd3U39pb3UBVS2a/XrG6R326BNVpMw78Ts=;
 b=C9TdxPHzotdQTT5Dqqzdty4rTyGJr8at+AdnQMsfbldYXDhaEgVptV7w1MpHLnkGZcXmVBtVXAkqEBSOVL8wtqs3C/5BmGNe6EW+Rup7+N30rfB1vG7ot0Fs/dNkJnimwWBq1Kgo5LIYSwoPdN9h5wwlQvvvhLDNqPcJR2w6JlbvHxPNmdkGI3oWriyLJtfQEo0tzU7ioRn7YfVPsLihNDj6ciZ0oS0NzDG5pMKjuZX6FpW9kgiEVwdTrQk3KpIePzkaXiuAOLP/u/PSGGbASowowP0+NoIFtrn/93qYOrtWfy2bdB4BWIaprx2VaZivpl3pSbAdG+5F7FXLxVt9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SngrGLAk6sd3U39pb3UBVS2a/XrG6R326BNVpMw78Ts=;
 b=lKV1EztouP7tojmpi+D3fOy6duLMZkHL40d/0ddqXogpYVnaQtX4p5Cq1T6c2YJZgklHiELM25cq4bi4VPwXwRLszFVv1kTPuiMDlpqf0NkAR8L9R7md5qAA9WisdAoyk3VOFfnuaQ1IZ/7YU/uTS3+inMU/GuPSNAdHlJ9+UCo=
Received: from BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:38:16 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::1b) by BYAPR06CA0039.outlook.office365.com
 (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 20:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:07 -0500
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
Subject: [PATCH v2 06/16] resctrl: Introduce kmode static key enable/disable helpers
Date: Thu, 12 Mar 2026 15:36:51 -0500
Message-ID: <03eda07e09a7716a78610962952c1ac63b12a7ff.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dd1207-b1dc-46d3-06aa-08de80774a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Nf9KRTJ4OpgkGCMPdj00b1lDvaBlczON96MenEvki6rS14fg7zC32JU3peyQ+G7UEESnO7bRA4aP2KWGmf3IEgTmUN4ex+TEIIY30im9QDAbhHLt0xIk5AESc4n0oCKkW8U20XcM+PM1SCNd6aL//Da2Ug9DgSzLhQ9XYba9OCHLLgkGcRNegEzWTJu886SL5JEWRvXNyuFsp7AtalTYz+k2AIKyR1Oguwt4SPX8cG8UFfH0RxVEREdfS17GwFxY47jz+7tONPKUG/SRnQg2TiF613PHql8uWCNN4neP3X3LvS+Yy8G+DvzUXIUG5JX4IN0TV+VrDq1Lfgj/Kqpuruk5aWcpcpfBTd0qwe6JFlEM7HGhuzWLRoetwOt0b3Qa6mJbyM8aNjCB/dBAhnmVOZxUW91IIWdq4ZiesnERhqOsCE2lHBq/GV86Y7UfdebyszU4v3Hbc4pzfu/Sa2bFD5y7cKtxNzNETazYHVaVEh96Ld4li6Stas5ZHXdN8UUW+5CDZ6DFrU4Id7+P71GclrK2TkH72cmqZt9uvRePSWYCjLXKO2qBqnrF9Y2/wk9fJqnsLtcy8T7NS1ipp9pnb//4xpMXvIlkbuM49Vgn7F0WQVFXgF7p7bljg3KmOkBHG4tXectSh4T0FhlOBuGqwXXW1C547HTt2al/R1Jtd66w9HlDVlU8e0GpPRDI7vLnU+tizDIvEhjrk58mF3VnwcHew2coS7nenFDKbSsy2+3M93ABhbcReNMQPAtIk0qZX25/U8L2l2y9+rolR3+zmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8VhDgUgJbkqrBas50j4DvJRKjSCjdslMS4WeQYfnUqu3ODjS9DQfW+f8PXAhZowuRDnBJul69ldQJyYIMukcaKVHvjE2MVB66c5e3M4Vak4gfk37/wbBLoGBez1Ll8b+mC8hYuz9XiwMCYUWmuyFbFvB9CHajYeGgQ7fgzOomhEUjImXXOm0CP4j8h6S9X2OvWHd8gHhCvAilefyU7h0TMFnkEUxZpNkjl+/Fs1vVneXeoDMzCYNy+9TIKxjohC5LUIE8e++YFC3buLFk5shqu9UpU7aN+0F3qz2hP7rpxM5Nfa9MM22EWVC6NcdrCrewtnsCPckHXhoT7Ed3+j9vdPxp0iRiE4llzWwgvvyNyGo0UlYVEPm9u2abZM1twMZ1Xz72rBcRw0LM8GE/iF0F6AAca6kybgujE5DEtVrWfpJ9xYeqVHGkd1HNHk9ieD/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:16.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dd1207-b1dc-46d3-06aa-08de80774a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

The resctrl subsystem uses static keys to efficiently toggle allocation and
monitoring features at runtime (e.g., rdt_alloc_enable_key,
rdt_mon_enable_key). Privilege-Level Zero Association (PLZA) is a new,
optional capability that should only impact fast paths when enabled.

Introduce a new static key, rdt_kmode_enable_key, and wire it up with arch
helpers that mirror the existing alloc/mon pattern. This provides a
lightweight, unified mechanism to guard PLZA-specific paths and to keep the
global resctrl usage count accurate.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Changed the name from PLZA to kmode to better reflect the purpose of the static key.
---
 arch/x86/include/asm/resctrl.h         | 13 +++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 ++
 fs/resctrl/rdtgroup.c                  |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 575f8408a9e7..4b4291006e78 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -48,6 +48,7 @@ extern bool rdt_mon_capable;
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
+DECLARE_STATIC_KEY_FALSE(rdt_kmode_enable_key);
 
 static inline bool resctrl_arch_alloc_capable(void)
 {
@@ -83,6 +84,18 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+static inline void resctrl_arch_enable_kmode(void)
+{
+	static_branch_enable_cpuslocked(&rdt_kmode_enable_key);
+	static_branch_inc_cpuslocked(&rdt_enable_key);
+}
+
+static inline void resctrl_arch_disable_kmode(void)
+{
+	static_branch_disable_cpuslocked(&rdt_kmode_enable_key);
+	static_branch_dec_cpuslocked(&rdt_enable_key);
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 885026468440..05299117d871 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -38,6 +38,8 @@ DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+DEFINE_STATIC_KEY_FALSE(rdt_kmode_enable_key);
+
 /*
  * This is safe against resctrl_arch_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 081da61bfe84..bb775afc78f5 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2911,6 +2911,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_arch_enable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_enable_mon();
+	if (resctrl_kcfg.kmode & (GLOBAL_ASSIGN_CTRL_INHERIT_MON |
+				  GLOBAL_ASSIGN_CTRL_ASSIGN_MON))
+		resctrl_arch_enable_kmode();
 
 	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
 		resctrl_mounted = true;
@@ -3233,6 +3236,9 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+	if (resctrl_kcfg.kmode & (GLOBAL_ASSIGN_CTRL_INHERIT_MON |
+				  GLOBAL_ASSIGN_CTRL_ASSIGN_MON))
+		resctrl_arch_disable_kmode();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.43.0

