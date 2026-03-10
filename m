Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB03CCA03
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122449; cv=fail; b=RzC5YFqNWJsZcg9xuIJ5H/3Yh9i1XreSrUZpxX92kYmcBp1JIO+vJX5tp+jQTCVJ8lGRxWMjG0JuWYo8RrYiyT8ns4egrouwlqpXnkiZynpExXHwc5MdebndPVUiRjC/aAkoZFDmYuYZ25nsj0xFZ3fim+a/v4b9EH/Srap2MO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122449; c=relaxed/simple;
	bh=tzabU7rZCh6TwUZ/uNW3HZqrA9lqIAhuB2EeOE2/dKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3D9V8fYozdAX2+bPuN/T1ByYVpoxpUP+CdZkBIynZVDliAt/JmypLFdveYb6S3mB5d+wZEAZeCxRiHi94Ns+QNjnblkx3FEHJ5+XGjqewz6FiVUVxmRyhGvnfp92boZTxnxkdBk7qGQceuap3v2506NwvOJeOD4qYO0l0KMakA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3cMl8cR; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3cMl8cR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdFGAN/jRaVad8dJkqqQYVDtEVuFVgkdd3VjKbXW0eKujtnn0CL2GL2tsie1Q8fPKMtAsQXcUDc9Wab8q0F9DYoCXXUElPi9AEaD9DgyRCSId9fthSmJrC5Ya5YDDlmjUqf24Ou5ZZcgiZfZZbGMZInpmr4KMbtq4n0FlF800rdmuSyeSyh5xcpNPYFULs/gRXUOxJplMLVLLySDoBBin2ME4OVblWAfSf2mBiORrM5MCLCJBuCSHY7nrsm6r7TGDBAQX5f4WF/vJazNbWWvuD6wWXLCFl9621/h2OVP+ifbYPCYm87IVzY703xK6u/Gal2jXfaEq+6/DphZqLupZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuPFLTdy01CJdUaTbJEtdKBwH7fBGXgIRyM3UbVDf0I=;
 b=mzpEk9q3LhkQP03Z5r7ZmJS8Bg7jcmr2OOaVhrmGK2wSo2qM37gnWwEv96zjv8KK5LeSaJObQEtA3ATpYc7XTqDYqP+P+Bcj223wHLzghCjp71CR6k8UkUAp6viElb6YSvCmk2BmVr5fTVRTlmbi2KbLxaBxPUK8L7AWKK7yN8RWnmLF+OmDniA4XHuylf1kEVLYvURJnW10YPjvmqgfXwbdso7krqF69RSJsZueHIC3QagaQhKjHuRmpyxzWlgcmgdCdN6AYeaJ0BOfAq+EdI64yrt64Z6Y48lOcPOCYZLsdCeg8EwuN9sa6Hf+Ji5bOuT359CeIR/nzH9gXIst1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuPFLTdy01CJdUaTbJEtdKBwH7fBGXgIRyM3UbVDf0I=;
 b=w3cMl8cRITu1ZO8upxDwQ4RaMx7R49GAtgmiCndh3P1RS/7iGf+u3taQyQT+B4K9V2/nMRctgWPiq8ipwxqIqmKhVAYkKNOAep+/6o+BhlQcGe8gCaR7hRe1VkHkW3fJfuEqIjpdtT4NHxVJPNf7dqkkCRmxI01CW4v21SNu2kU=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:00:40 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::42) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:40 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:38 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 5/9] KVM: SVM: Extend VMCB area for virtualized IBS registers
Date: Tue, 10 Mar 2026 06:00:17 +0000
Message-ID: <20260310060022.15120-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: ed614ebd-01a9-4d15-e54b-08de7e6a5bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	+hXjCncwxabj9XNrg1E+oeBTva6sMONHcnFQJo1Dl+LRkPixyCEfqm/1IciM9oQvL+pzbDuKKBTTfovwxA1AXIwQgjjwgcpP6HgZvKc7ybuFog0NcNbanYLN+Witwh5Mq4FyoxuoMmyGxaEUTYTvBtxlrYF2TQ7Etq/9Qd5dACmuqzZRnmmnMM0HUEnnOapTiRLLlx77jITrdcAJgpcgTf5lms39RCJ6A1tqos5LrrNHQlL3TYQ4uk84UQzDWY9APgu4+HwUI67ijY+t4QHu0fNCA20zcoxoxjPHAhiivZCdzDyAcAGaFp9/OBp7Tq6UGAnvoYF6fin1gCzXWgKXyzHdwYCxsTLTbNuP3nh8eTRejNIFYYgSEQGQJmoH9iJHi3lLsbVBjbJ7541vPrjhAj0Enak74RHDgBlCEURS/hOjhTyp+HBaPbWsoga6PDZ5/FGO47kddWl9EEer7lUzFy9DZM28jeK2aJnn2W2rqlAc1Pvxfb1G0a3f9A87urCXE6IB5rhCj99hDUB5avoP9dLFARW+BnYaM/dUhudKDqGvyH/eXGdZrIc4CtASZ6F7yFFLS257LjRgiB4l6qLST5ipqaPKKkBiln6Pw0E0/rwfF1p/eWin976fQmo0S6Yv4hQ8AiUJY9lDoiPCDIM7dE2I/a/P+ImOVoOV7YiPHgpw+mz0uC4Mlvx2udoEAouQHp/ejSNaPbKdt+awqb+F0nylxA7dVs7cdvm3K1T08pOg7h/E09iX4v/F/tg5EH7ymvFE89XL5obUt+XqhH9Teg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uYwNFYX9RlLvw33MlzrJD8C4BskEbQZlCzuYZGyp9b+LDfmI6CMzqT842LxMovxI+IS02I1Ol7WqIHvMeU6ZT/owlp+Vr3tvHqcLxJBc8Ew9up3IfYz7AgUQ5MvSqo5DgTV2bbhdy/92VKd0ihW2npoxq7z7q+70FSl1PCOZt2quyXfLHpVX+pLpkMztt5r0sdFhdPci7uOTKIGAugtQkaHu9rm42t7J0L0h1gyse7ZKVTErzNMnlf8tjBqTx3rxWn5xSURCprkg+g09r3SEj5U0keRAwxfPTXXR9Ti/mIqHElxPPhXgfqBorg3A+409QU/saiyq1004FgzmgcDyz3NbmV6o+Sm99nH9XcXP+E45trX5x3jRkwOALxbQzIOl3O5XfVTEChTENiXQcbosHGK7nLEvzFSEn0zDAZJFDaxrR6JwzBaTTYzTKmjbWRLV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:40.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed614ebd-01a9-4d15-e54b-08de7e6a5bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811

From: Santosh Shukla <santosh.shukla@amd.com>

Define the new VMCB fields that will be used to save and restore the
state of the following fetch and op IBS related MSRs.

  * MSRC001_1030 [IBS Fetch Control]
  * MSRC001_1031 [IBS Fetch Linear Address]
  * MSRC001_1033 [IBS Execution Control]
  * MSRC001_1034 [IBS Op Logical Address]
  * MSRC001_1035 [IBS Op Data]
  * MSRC001_1036 [IBS Op Data 2]
  * MSRC001_1037 [IBS Op Data 3]
  * MSRC001_1038 [IBS DC Linear Address]
  * MSRC001_103B [IBS Branch Target Address]
  * MSRC001_103C [IBS Fetch Control Extended]

Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index bcfeb5e7c0ed..4296efc1dafe 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -369,6 +369,17 @@ struct vmcb_save_area {
 	u64 last_excp_to;
 	u8 reserved_0x298[72];
 	u64 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+	u8 reserved_0x2e8[1168];
+	u64 ibs_fetch_ctl;
+	u64 ibs_fetch_linear_addr;
+	u64 ibs_op_ctl;
+	u64 ibs_op_rip;
+	u64 ibs_op_data;
+	u64 ibs_op_data2;
+	u64 ibs_op_data3;
+	u64 ibs_dc_linear_addr;
+	u64 ibs_br_target;
+	u64 ibs_fetch_extd_ctl;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
@@ -551,7 +562,7 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		1992
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
@@ -577,6 +588,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
+	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x2e8);
 
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xc8);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xcc);
-- 
2.43.0

