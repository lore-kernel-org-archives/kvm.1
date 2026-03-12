Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FF37DEAE;
	Thu, 12 Mar 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347907; cv=fail; b=KEFfI2UktPFt94VzyY0FW8uJR4ohCK9BOx9mZZW4XscAtM+Vn3zH6oNvKbCZ1BZ/XtPKVxTa94WtROubS+6jltl4K2hvcQdk+qcJRHfHGqrRRgrjU77I1Rb12E5hg4t0Mrnji/i+/0b72V6lBTdSv42WvftLy7ia40nsZ/I0ZOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347907; c=relaxed/simple;
	bh=huxGwEzCXrqvdwyjZ7N/0rMkfpsvo0w9S2IKp2l6T7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/MGZgyHrJPdRNUlG0t4ray8inlqfepTg7kLKy04roAID2k/ke1DC9zPQJ7xzf0y6wow49ifh7Hxmc+tGjW/1wZ89OcMDbmEEvMUqxfAgqoXApNRwC+YnJPwqEyniETLf1WZJLoMnWZ/JdVLY8IN3+B03tR8QSzHWRH7qd768C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PYxxjvjm; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PYxxjvjm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ+elGn1+t+hEGPViDrcxcIICNkoe/mWm52pZoYo0JQznRQQAvo6mJhgywqYBpmBevFx8jKtRmaEB2XpCstDw98wQVgxC4hYmgUOdV5c1ppCCRcfCCxy5er/eJ2+0X6VEd2GPfpz3DLq+xnYmfkoOL1H8FDSNSDpjTXifQE00CddUAyR+uGoMPDMXoTeGs9/ZQHXHP3BC+xMacGoSv+i1EcaBs3Vziz/UK3NzD26ncxYXaWKpZYe/UXk9AkXdf5jESSm2mSNUgVGtjpbiV+YzEslYvmFfhMDS3cRlquanbjxn8xtzUrEx80qGOu0Ck/pa87kK7e93vIt07RJYgrHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHNADFizIFxMD9lyOtdmwUk0hHrDSaJSjXwFtWv/8jU=;
 b=QM75UNsyD42kAeiHspoj7QGIrnzOmeh4RU00w1g2DOIroHe/C99aZFtRcAGAQ8kEdjNm5ZYL1bx8dTTWq6C0+jt/wd+P3AvdjjjUAfmoMosvJRNBm0BKgnY33xfco3VDPmyDl0jD38ZXnsIZxVv2S1t3VTLkLYliw62s+TCVjqhti0FOKrb/PmXsm1VQ9XjtyKGhhYdjjFE5jFVT1e0+k5P/Vtl4VN97mf+jv7pvYE4smxtmXjcONxJDSHaipfNmAbMXGJHl55K+28JUPlH2CTeH3I0b6aJAKKy1M1Jm0WqMaS/FJnRPZOqlKAaEM3ZyhN/TV81A3TcYUSHOrpHgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHNADFizIFxMD9lyOtdmwUk0hHrDSaJSjXwFtWv/8jU=;
 b=PYxxjvjmo6/22Yf6CzNhEMON1bXeaoxMWbiv7Xt/G3BH/lyf5lPTNIIJzz1t+Q+nayUUKNCuG9Ez0VmeFJMuA/ezYfeUg+kWUyJbz5jVrs+PE9Uth3JHRXib6AByhslTZaFpa6UA3fA3juF+dki3ozg5OaypOmEzxJE7OseVhg8=
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 20:38:13 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::93) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Thu,
 12 Mar 2026 20:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:38:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:37:59 -0500
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
Subject: [PATCH v2 05/16] x86/resctrl: Initialize supported kernel modes when CPUID reports PLZA
Date: Thu, 12 Mar 2026 15:36:50 -0500
Message-ID: <cd41d553847006a466b7e197456ce2d42885c885.1773347820.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2cd503-847c-4405-4c92-08de807747ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0D6REfoxihKbtzzfEwoUKrYcqL9MgS1sPlG/R73fsZfWa8JJu9YH5zZcgRQ6trBQJ3zLG9OkpyypH36IKEQjv8vDIBysFZkL062aS9QZrKjAQDuxuMdBh0OVIgqKcvDpmB7qxklhXlQha8EVonTeRhfaNLkWHLejS44nAZDR4caNKBgeUldWMaz26dcGLd8Oj6hIOSAlAeoL/j+S7BZrd0lZKxey4+sGeUXZcQcIUPoFrcZifVAcNr+QJhNxW8/hwF9kwD3PWIXvA+8s45Hg8TB94hzqkCjC5AsBhYwlLnRO9a7/Bt0wzxAgZS/FK3KGNVFeGquPWBwBNZcqMU4UevayoueOAZYO7CpGyF3Czy++schmBRQU2T/mARGt8b/cBjKONN3iNRVv2Lx3xYdXzBXsdNbf808EdLTqJRsOIdgm550340MsUSGsi+kXbOJHlppKu7VRtbOB4s4p2OnFGGy8Z0qoV6koA8muy56mbe7xJ6lAPN+Vej3RLNzxmc5l9iEHs0Hn9wG4Oz548Cn5whT1SsuG+KiYPiUAZ4wiq0iDEX6IRtzshnDCEeKZVgbznesN5kMjlbrVfW17oki29bsAZW8efrNpDXnKb5vojTzYIVA/rrjH60LnX73xl9FDZLUWjOCNujGDOP8q5QWzUcpQIBXvqhw7h8GL2xiU/EozCoG1nQpl54wMSBNzCq9vDkoVtcSV7D+hvl+k6qr/jhBm//m48soPp+HXsIzUczpJbEBI5HyAGhRp8Enr5knBW8+u1aSJ3yYjAcZADAAhjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nYrBZMXC/rU8QyjMQzeJ+5geYQ+SrIwKtCmzcbmzmJAae2pFKq9cS3HyXtVIO6mj9u5SWIlQAwrGnrZRx91u/tf7AN8gmxFpnKmZyOkrEqH0jB0etrbm4NBQqFgDt3r0oys94gEjz7TCl7PTXNondg6jfL9PRktiD6nPFL8EM8/Eb2W6fdoCuh3i5kor7gswgE4XfWDh/lFWHBAi5KMGQ9xmzCia35S3HWIl3NMI/5jH8B8p/DRYnPfOR7sW5j1JScJ/f0T02OItdy1GLk8cSXMgaQAEy9WkzuYxiKs77uC+pxNl7wNwhdkqFUP+WI/8bkOGGU9Zgigk6Rr9R3x9Od9wChJmp1Ks2KXrH2zZAHbVqahX8XkkBfKD/iBJPM3sB7moIur6Fo8a/Rt9yK991b/ddDkX7B9F9FmHSyB6FHoC0SQF25WIj3iOPg9l9cGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:38:12.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2cd503-847c-4405-4c92-08de807747ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

If X86_FEATURE_PLZA is set, add GLOBAL_ASSIGN_CTRL_INHERIT_MON and
GLOBAL_ASSIGN_CTRL_ASSIGN_MON to the supported kmode bits in
resctrl_arch_get_kmode_cfg().

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: New patch to handle PLZA interfaces with /sys/fs/resctrl/info/ directory.
    https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
---
 arch/x86/kernel/cpu/resctrl/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8fb9029fe547..739190ac96d3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -898,6 +898,9 @@ void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg)
 {
 	kcfg->kmode = INHERIT_CTRL_AND_MON;
 	kcfg->kmode_cur = INHERIT_CTRL_AND_MON;
+	if (rdt_cpu_has(X86_FEATURE_PLZA))
+		kcfg->kmode |= GLOBAL_ASSIGN_CTRL_INHERIT_MON |
+				GLOBAL_ASSIGN_CTRL_ASSIGN_MON;
 	kcfg->k_rdtgrp = NULL;
 }
 
-- 
2.43.0

