Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C71419FBE;
	Tue,  6 Oct 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305762; cv=fail; b=mZOv07ZvTVDBTikC1DOwsU9HJ54qDfaBCx452HWCog4S1XTAPsCUUfyfN7NcglKHH7yw5b6cMeqA0AAVibXPPmLXhOceEnwoy4iXgzw2a3BTWd9f3QlSKRnNwVMB6Wp/dTMIUw1jxFM8tYsH4HwksfJk2UHroWmtWt7cxKrjTsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305762; c=relaxed/simple;
	bh=PkIS2IL1usrc4e6KnrQJfU/nyX2RpsZno3RqmRdxMDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDjxY4KbZpJr9uXcb6k5fQBjfVUF4WRJTT1fQ6uaql6bGf8+vkQMLRJhF+gjceebjpLTX5TmcuuMCrfZ8J9gDpWwzQC8drEBZ+V+Nzy7IsbzG9z3BNyf7EUtT4VaL6g1vIZema9lCNoUlbdwjxbjlPUDLOIiOiv0O/0FZjPy2zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3DzWi6Bm; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3DzWi6Bm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3zFmZNjBIRlUKMDOiSB7eJtNfS9GbQA9+ACs0ZB67iMFLIROmhSfbxyAioWF7FrObUpUBhYwmA2AT7g9Ousld5/z4VL8vuhqHq/K3AympK6u2wOFPUuMK+pjpdg2KkiWd2b1t09MelJuNeTj4jI3yqUeq6prPeqtvneHolqQkWelqjL8lJXI/URZZj4ogUXKRES0PMPYAQdaXBoj0YAmi39GkHg30xllCMssAxERhokPbYpNo+9qQ7W7ROV9GTN5QhJpp8ROPxZZ+EehhyLfBY7DemuLm/W140OQbcrduwOAJRSpOXBEuVYa5Bgo9Lln2Z1T0yOZXTWrbgxihoI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbhx/vHp6F73Y8tBnrqktusN2Zed40d3p5oQgWYF5rs=;
 b=KRtqoBQerrtm8HxVQFXZJhLOGlqsPUAtFbN40WECboHYrMMP4BsXQ12SXIYnkGKqHoKq0CNjWM/ECX3/UI1hg2QhkX0enu9Y3jERfm6DJaVwRq2RPsPnEmJh/qjgNUyaezzLHg+2rW+JOan76ZLS4kRq5qdepvDBaD7tZI1cQhIkQXrmq+RUvJLxyU4TeYCffKv3WK1ktt1CU3eWhS0b35FONR5DYdGhPJt68y137WccyZrXO+4jCoq7grg5lNLFt8xjyDseAvlluAkvsCG2p9WnT3Q6kfWp2YHC/48M0wzYHFJaBZIUd6qGzqdq1BJa/SOF6fqtIhrMTMp9Alu6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbhx/vHp6F73Y8tBnrqktusN2Zed40d3p5oQgWYF5rs=;
 b=3DzWi6BmrefoZrQqNmZnQzdo30vPhb8Lxh4hvyFR1Rw8QMei28UyjiPZUVr7qIldqv+Doej7fH7z5E7B93azgJsudnYSi9BVOuAWTa1Lx6bVHiWa30qyJQxcnEOZ4OypaHXxB2XR8Z2O6foaKasXxdcm+oqUTchujdMrzYfv53s=
Received: from SJ0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:a03:2ef::15)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 16:55:57 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::22) by SJ0PR03CA0190.outlook.office365.com
 (2603:10b6:a03:2ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 16:55:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:55:57 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:55:55 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v2 4/4] x86/hyperv: Add guest support for Enhanced SMT Protection
Date: Tue, 6 Oct 2026 16:55:01 +0000
Message-ID: <3bec0f45fc1ea446070cda4339b407c8085f6eb1.1791302373.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 381e9399-8893-4946-b8da-08df23cab118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wr1yT9oH+KNSIBH+D4o++zR8/8IKYZOQUNMUWrXIoAF3E6b5VD3gXN/XWjLdkyYkptGRDKm3pa9OyI/sCq3+JcRJ6VYAqjQ6atpLk6jGBq9m2nVq/d1ixt7NZsxTLtt4NfgxGuVv5Wb4fecq1Rjza8ZXR/OmfF/NMc0WVYRimfEHlvMifa+3BFCavL7gOSHP1KLudDxEkT4ybueFgpkUdxPl4EylDmkJZVf/Clw4fZNY3rgJomPhIzy/CCpaTySK/vJRH9tU4BM0KiQxmNcVJi0HTIo1I7jw8ZTk16mbALR/DrmOYEM5Wk1+sKydDY7ekkhVV7ziwsQXwWmO4bb5+LhrpxYqizMznvT16wZJ1iOkJJMus9zb2X38CuIDekiMVVtrLMgk0pD4ls7/rbYmCkHQc6ZAaI3xYMPC7m0vT5vKjvlVTD+BFT4Y4fsJPNAZ6QMNl8cQHhdkZdEOCX3Pv1Vm0lD6xt2poTDHcHXZCEzZm/4QVEheuvg60d657reYOxDreT4gClySbYwdF9tJa3nfEdA8f2Yc0MVmcHrSWv+ceBPoPBvykV7TkdE+CfrMgtmajbptpByGixtn4ZtlK8M8R/fGzaqAYdjp8VHbpKPbDc8QZKDhzt74b6rsVWzl1UrzwntUjVGPqngvgl4myK+TIdMYWrvYua+mGMci9SFHzXvkP5ztUUegTKshdBRxTegCyPfUUmU8nIfv/bil6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sopl+s1gxgcDzlXGsn5b26r861T6JFUCBGhWQ7ZO62nplSz48kzc40prZEXq/OLSfsy6m0uazhvXqeYfrpfXOezesuBL6sHGaoCPkqLJdtevDJV21OSdHYzUUoxcRFE1C3qppAEp2npCRDrE0lcCaLipKwLwr7KWLBGEHwZnwJqbM1LucUGSM4i8/5ReONGhAHQfdbAw3P3uIfB1piH/yuOas7ZkrbRV0fqeUgx+Zn88p0dZA40iDtLHdun6Q8YcAVFtcn3rqfZjwpg6w05/ZGOZhTsjcJy+e8Rx/u4Jvo+KR7+Y8H4eu+VvZPNB4sueiiZzPerTZOZN95/SZfmUWLdRYzZDGenpoa74g42XSiC8302CfKUv1QMWjHcYA0acFr9ih1f6CCRPpypOluELJYIoU9mOkefFj+cKzvhgdXCkFqMH3t5z17ZfmX67pIPO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:55:57.0158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381e9399-8893-4946-b8da-08df23cab118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

Add corresponding hyperv support for Enhanced SMT protection. A fully
enlightened SEV-SNP guest on Hyper-V builds the VMSA itself when
bringing up an AP, so populate both fields there, before the page is
turned into a VMSA and while it is still writable.

Similar to KVM, fully set the sibling mask so that all threads of the
same guest trust each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v1..v2: New patch
---
 arch/x86/hyperv/ivm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..40dd252f333a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -347,6 +347,17 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	vmsa->vmpl = 0;
 	vmsa->sev_features = sev_status >> 2;
 
+	if (sev_status & MSR_AMD64_SNP_ESMT_PROT) {
+		vmsa->vcpu_id = apic_id;
+		/*
+		 * The mask fully set puts every vCPU in one group, so any two
+		 * of them may be co-resident. A legal ESMTP sibling must
+		 * also match on ASID, so the sibling of a vCPU in guest mode is
+		 * always either another vCPU of this same guest or idle.
+		 */
+		vmsa->vcpu_sibling_mask = U32_MAX;
+	}
+
 	ret = snp_set_vmsa(vmsa, true);
 	if (ret) {
 		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
-- 
2.43.0

