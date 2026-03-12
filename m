Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C5374162;
	Thu, 12 Mar 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347932; cv=fail; b=rcrkWyzMV63u3j1ermPeVYqCeuWJKmTkV2EmVoHYqLv1NoaRFlyfNShWZdms4UeLZh1iVw2lJfflFgqlnIpX71IKoIO6PA9uS4zYmJqza47H16xuPzJBVtbLQLA19bQJj/bIz3BCop9O54d6gOYrovG/6rIRawBeevDj6NgkW74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347932; c=relaxed/simple;
	bh=ewfdkeoSE0LU+mwNyCGKnpANXRbey78B3Ev1b6ioXCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG3FnXi+XVzya9tuQGdTSW/y/7h9ifvZf3QDN/wQ7OEUwypw3K3r7UesqLwPJ39DL4fyGgzcvGoQWTQBFSgmjxuhiollio7L7b+XIRHxUXNKW6mBHTU2xXU3j4Qpi+lFJsJWAnyJRv5ojfn7zs7vYzvx3Fpo9apKLaSE3HkYBps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2EqGGVUI; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2EqGGVUI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA5Hya82+gCdAuSLSzzB5RUnVIi5BQypBZXw//5NydTtYWSLBdvrJWR1lqWJNLCJ1V0PdcpxD5pOZkAx/jXP8IyPQPSsLAoxntkGcXLebW/j94UkV6nen20GvYiiuZk+xRFAndUm3z6r9vM+LwdbAT62fzSM+EZOKAtRrerqm9jMKU4ki2/T64gs03W2wjslDBdZdBkDApYupyPoRaAggyKdZMCYTRu7KsaH0PKZfwso3a6Sw9DN23yb/4n2MjVZU9RanEwOmig8E5lyrjyRol/YQ7/+2lZn+IIrOLxW8o9OE6mS5LSLoeaRACdYytx8rSJDrhQz3Ikzwhua920Ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMeChVdLUw1WYm4EQW0EiCsfzMggrTqbWQZY8aBLmc=;
 b=wxxfKeJx+qfLD53REb0DJOlqE1bcoaSjkF3HXcHyGgU2eKojZHoAH2dQnTGCyYwaQ6bbvcennpVvzp8P6xV9M9JfMq5fh/Et1S/GM6pQUS+3/x8Q4cJsDfVgHYEPHhkOvEkoKDx6M/gxVWeLxBg6goW+8u3ofykk5n82zTpoyPhTFzX91qWOJJ/7Kwb2F+ejB5yupgcpKdcfIdhlPibPKn4j5MolAitlmeJx8v/tpg+5mFW6xmdUHCAreM0HcJQjQ3YcjLHx+v4IcZEKGfrbDzOIDHgk/465HZrq9koIXqoQK8kzLBlb37KGPj66eT7xWYPNzX7NlXSwgolAcXGmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMeChVdLUw1WYm4EQW0EiCsfzMggrTqbWQZY8aBLmc=;
 b=2EqGGVUIwJkDMAqWgFs5ZTpEhbZdy6ios+p9re/1GmyJtzrXQ5AMkyUYhKlEVu8KWbASg4z+YMpSx2z+BSs7af18fAgyUmzwfFdSLLGHeNgKQzD1DDaBdzgiuVKDbpBE5U4UQpnMD262Amf8U/eTOvEqla4FUZAsT1776KHSY+E=
Received: from BYAPR06CA0040.namprd06.prod.outlook.com (2603:10b6:a03:14b::17)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 20:38:44 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7f) by BYAPR06CA0040.outlook.office365.com
 (2603:10b6:a03:14b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 20:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:38:39 -0500
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
Subject: [PATCH v2 10/16] x86/resctrl: Add PLZA state tracking and context switch handling
Date: Thu, 12 Mar 2026 15:36:55 -0500
Message-ID: <654954974f71dd267c706968f8477e6d7065e789.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cb3bc1-da5e-4e8c-a7b9-08de80775a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MsjWidwv8X2K2tfJIu9WJMv2Y9gIJGIKWlU1Uo55lYc4p2/bJK3S9KTirCz7jtyRdppLbavSN4xkD5XZXTviALtqotvIWfOaxJGPX2SH5Wivi/myu2SHNbxW94eX4NfDmlHDmflqcSN6SFCrntou6QRwxjbHQGe0KUeua59dIRhgI+x9pgQJSm5CaukVPXFL3j1pDIDhjgRSrwYH8oQFqfAUpfs3yaQTsqblF9qoJR+jqbaMsvZwMJrvZcpuSNCn54BZ46X/o1fs7ZDWHVYK5saFVmcpqxeBa3APvujBXRmT7OYnKLu+hRvMmNRisLQ3i/xNyNvv6BI1UhElpRpUuL+KZ6ZhZqRhyw79FwHp8h0bQTEx3vCvEVeCAYw2jZlm5lG/zZNyya+KW2XNOOk9c8FGqvVvaHE7upbeu9Na/IiemTn15Po+S3cxSdVMu10anWlF/Ey9Gjal7ZTeXlkDMT110e/I7+KfuRDuILpUWkwctC2VyMjqL3zLzvB6lFwf+Z2cuZ30Cz+rVPQ456rRQRQ4zbwe/W+UbS4t0kGp+IR+7Wc6o/ohzk51AyCgkaY6zZGQl6Er4YDOkkHEGXcjMCm4xwsPeciFbFXjHEjM2kSusQC5GoLWLSfGJUqDxJhzabHxP1snrY8IgYbZEwC2874lTG8tqqDJEEam7NDIUj3Ks5QM4PX7KbJL2L34qexg+VV4WaCadQgsFuHjXi+0Sa4h0rx18MVGokDLc5yClwnw8pdfe4m93tNSsBXpUMI2tEqAgxUgwaAxKRO4Z43UiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vhInSXajZW+sSEUvKJJqXcNpmlxEGomOBrs4gWJHdyn+Y9q1B4QHZbqoPwvVqwypLF85b6xrSfopWTnPuptnf/1ZPgmaKvXwGoLXRugTbcmB0UTeswEQZiiUr1+3L57eDEFmRtlapJlWz9JVsivRCzgdH3CBD92RUHKRCdAEtBm+y4ZTEo1c5L/Q5MgT0VgL7ACRCGRTyUOZi+EQTRN/DDxwATqb9002UIONng1CJHD4yqyvHps/Q6x4NiSXUtKQWYpeQJQMpjSBSfONzb448n2HpbouUT/pKXGJWA3IO+Bpb83h0zvwuDLLFSBwnI+D5tNEiCwMgQmBl0TjW5PTj1g8ehrWU5osWNhJtvNgFe4J5+6qcI+TQrNpKlN9BdTmd+AWDSAa6DwMVs+YRonlGTEdQbZVYPp+eADe65v6cddKfDdtlrkM2WUcYHlxrs6b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:43.7449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb3bc1-da5e-4e8c-a7b9-08de80775a5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

When kernel mode (e.g., PLZA) is enabled, the resctrl sched-in path must
program MSR_IA32_PQR_PLZA_ASSOC in addition to IA32_PQR_ASSOC.

Add resctrl_kmode_mon_en() to indicate whether kernel mode monitoring needs
to be enabled (GLOBAL_ASSIGN_CTRL_ASSIGN_MON). Task's kmode takes
precedence when kmode is enabled for that task; otherwise, fall back to the
per-CPU default_kmode. Write MSR_IA32_PQR_PLZA_ASSOC only when kmode is
changed.

Protect the PLZA path with rdt_kmode_enable_key to avoid overhead when
kmode is disabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Updated code comments.
    Added new function resctrl_kmode_mon_en() to check if kernel mode
    monitoring needs to be enabled.
---
 arch/x86/include/asm/resctrl.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 167be18983c1..ccfd95b98bac 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -57,6 +57,9 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 
+/* Global kernel mode config; used by resctrl_kmode_mon_en(). */
+extern struct resctrl_kmode_cfg resctrl_kcfg;
+
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
@@ -108,6 +111,17 @@ static inline void resctrl_arch_disable_kmode(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
+/**
+ * resctrl_kmode_mon_en() - True when kernel mode requires RMID in PLZA MSR
+ *
+ * When GLOBAL_ASSIGN_CTRL_ASSIGN_MON is active, MSR_IA32_PQR_PLZA_ASSOC must
+ * program both CLOSID and RMID for kernel work; otherwise only CLOSID is used.
+ */
+static bool resctrl_kmode_mon_en(void)
+{
+	return resctrl_kcfg.kmode_cur & GLOBAL_ASSIGN_CTRL_ASSIGN_MON;
+}
+
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
@@ -127,6 +141,7 @@ static inline void __resctrl_sched_in(struct task_struct *tsk)
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = READ_ONCE(state->default_closid);
 	u32 rmid = READ_ONCE(state->default_rmid);
+	u32 kmode = READ_ONCE(state->default_kmode);
 	u32 tmp;
 
 	/*
@@ -150,6 +165,24 @@ static inline void __resctrl_sched_in(struct task_struct *tsk)
 		state->cur_rmid = rmid;
 		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
 	}
+
+	/*
+	 * When kernel mode (e.g. PLZA) is enabled, program MSR_IA32_PQR_PLZA_ASSOC.
+	 * Task's kmode overrides per-CPU default_kmode. Only write the MSR when
+	 * kmode has changed to avoid unnecessary writes on the scheduler hot path.
+	 */
+	if (static_branch_likely(&rdt_kmode_enable_key)) {
+		tmp = READ_ONCE(tsk->kmode);
+		if (tmp)
+			kmode = tmp;
+
+		if (kmode != state->cur_kmode) {
+			state->cur_kmode = kmode;
+			wrmsr(MSR_IA32_PQR_PLZA_ASSOC,
+			      resctrl_kmode_mon_en() ? (RMID_EN | state->kmode_rmid) : 0,
+			      (kmode ? PLZA_EN : 0) | (CLOSID_EN | state->kmode_closid));
+		}
+	}
 }
 
 static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
-- 
2.43.0

