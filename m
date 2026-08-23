Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F22C15A9;
	Sun, 23 Aug 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492218; cv=fail; b=F/jAqtO9El3tjpe60RSRPkkjav9xSrLB+3GaUa87ZyhHf+XARdHXoC+Pcj6EqvpwrlzqrFa3wnsQtoWLJ/sRd7Yxoyi9Vh3CRZuZuDUXWCXAV3SKaYAInTdzuA3Y/pc+pl1itL0/aeF8qls7CBw3hXmicdScaxVKfqgw42fqWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492218; c=relaxed/simple;
	bh=xGRMZIhvtPEKnVuNDdGvO3JI0/kk7eDcykQCBsL0+q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WeIAkwI5QK1gBbfxb42A986DC55QFWsW410me/1ZKz4lxoZSbUH2SIm/P+vXvDuWHGna4NQxIbxtwLYH7Q3BZI49UzL3Wt9FmONX4Uw2C+cK1GzQdHqDe1Ia4onHLQnE6rDhx+ysbrRDyEoEfcc/x0HjVlh2kN3AfFGx+VlGG7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RaGXURhF; arc=fail smtp.client-ip=52.101.46.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RaGXURhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSk3e7Y+vvj1a3ADH7o9I3XbiKg5Ppq2OJdqqssjnwIQbQu65iRYP3LKNeMV7ftbUgEvz1ptfKGuZds1v2XXVafV7m92tQZTz0ues2uMrA8nfNM4Bx0A+h1sS2kSpYhDLEvw+oI8ttkw/C41XRl7ByJPsKP/wvpAqj1ALSOIeKcEW1YlZDZl17g5ebRDmz88+QjoA2YmtT0nEONOh0hpz4LZkFPhx0RQm7xJpH6nFYYXucL583rapEY4Vrnir0dAmmRiJRGQxz5yzHBie40pjj9wyyS9/Zmb/2tmqk/zgugCNajeKFrR1gXtMkFp9eEOzHXZHmP2QrhTMcXLS/+48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUJpy5866Qg3JiRjZNIXIy3xtqBtLkeoIzlrzNHrdQE=;
 b=GMhFbplyghO2y32gXszgD9082Npc/rSNYvO0pMUerSO4YnxqzuMHnhyXj+u6ySppHKcNPEZsgCQ682Olf6GpXqI/FwmN0VO5SMLdJWb1F2KxEXDfCCvole9Jveeq7ngp7bL83w2q3X7TlAAdz+Dnr/cDoo6zQPCAMLMeTxBgFBsz8+WmlWQHpLsynBP3PzCyXgHyeBdYk5SXXi2oHAraTQch0UEZd0C2830eUPw+J4h/kkSkAFu6Ic+zir1XD5knmyEayACRgB1NKA2v1JgCmQTdsZvV+gJYa3jJu2K91BUL89BVFeHLer+BRK6EXXhlsHwn7vL429ne6B+ki/JgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUJpy5866Qg3JiRjZNIXIy3xtqBtLkeoIzlrzNHrdQE=;
 b=RaGXURhFL1xxyqBtr6GBVXuuGNu8YBaEGgLKBvFx/KVi9ZcQHehtKCTYWO83CFOq56jZ2ZOdYi+ZGpwvWQPU1PCBDCRmk1sW9fUjaTTG7sSv2WtMvnKbVmKG4IlDJ7Dq6j99pvlnzlO/0qL6GKANMQllEdCWsE+4wKTHyvGZjzk=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:36:52 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::35) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.5 via Frontend Transport; Sun, 23
 Aug 2026 13:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:36:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:49 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 23 Aug 2026 13:36:30 +0000
Subject: [PATCH 2/5] KVM: selftests: fix maxnode arguments in
 xapic_ipi_test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260823-shivank-gmem-fix-split-v1-2-512a29fb8e86@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Jim Mattson
	<jmattson@google.com>, Peter Shier <pshier@google.com>, Ricardo Koller
	<ricarkol@google.com>, David Hildenbrand <david@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=1369;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=xGRMZIhvtPEKnVuNDdGvO3JI0/kk7eDcykQCBsL0+q0=;
 b=7YB62OiIBMdBB5Di+lb+BBbJLPN/xk3JV8TqhTWDD54rom+ZWRNnGn0o4txXubdS2ZDJN42Ax
 CcZq+OfSFCCCgW2tfxGFhhvCrdTiQfckJkcx1P3qc6fV2ZnG96b8FrY
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cff135-6fe6-4d0f-3a1c-08df011b9766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HRLPgJP2a6Jz7Co5OaaqdLOAp/ANX3km6PVLcaJaNPRpVfkclQz/Jq6i1pzLSL8JwVehknmKICxVlAv8cccclyT10nyaMLBZ2qsjMHu7l8g7A/rmK8EiV70G1VoebFZ5RfDt+IoqErqLk5LHkkwDo22HK5CIUHmobyWbk37wo45QIbk7PnF+tRPSL5eFRsWawfVNuhhSe6jIqT+cUbwqozxLvpJGxa2325lcqrhDZYBioU2EhYtOwT16Bn9s6ii+q29qsXZQr6Rn7064juFu/cWlFJjAf2W1XiyXwrS0dRZyqEVXtifG3vGTDihyomt5C4k/7sO+dj4vYUouVnwVWsWb+52fNIshOcgYnIdybuwLJsF/0w2FaAzOpBiI9Up3T6B4H9LaOhbLx+HHc07ETWnZyipw7lahrFDGR1lFhTuT8IMttgvAoiGJT/HQfD1ytRTsZVHlSnVkx7sUtifpZkUYDLcg0aYuFqN6vMODlbcVJ/+9Ac/yqfW1+MpJIsSbxljqAutHYzl7zau7LiHjZY4ecxeFJQfU3Z6xpNhi/L79e2BJmj6A4A9LSnnL6NH4fdmi4EIsDLLtCq+OpYihu4yfmS/KmVr5TWatYdD5ilL1peJddEJnUtV5qBh9RyfjUT6M4tTpSJFQnbiWYQSqJeWz4MFxafzMvo4QNEqtERK9ljxuWBxz3sqDItRJ8ra0erE9sYWJwmNL/6qMinRRIQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U6EPNehHptRU9kCSYw5l1ridkAWCyDuBd0vnmekGnD+UIv5nJAFTiJJRfRJEBcJR39oVBL3WXDz150iT1amAG9QtfNHHcwbyLg7Zso0kl/7aodJ/KUhKWxHcDgUAcUyadVdFmaZedVi1MOtcfF8hxnHkfbYn7G2GHiMO3LKYzlRRppPSe5aKtg1IctEhdlbYm4wMcl5qJJs2zjb7IEAIqxJll6lBX6QDAGlVIK9DFfmgCmjQi5YP6My0nVdAFEoslyWSQH5jMtvD77PAFzwa+Qij9Gc25K8f0rzuJIt8HFZkUfTmse/ZScn5TzxgfOsiG1vz2L+9jMIPp04dn7qdVGV46Mo3PIiInu6X0+n1/Khvia0fzmCp2WDiVIKGojAsb4VS1uxhI9e2idMu83UmmlDNoVJWzVmMKrmd0uUBLCz36qlZLlFgXx/AkjSand3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:36:52.5004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cff135-6fe6-4d0f-3a1c-08df011b9766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

migrate_pages() syscall expect maxnode to be one greater than the
number of bits in the nodemask. do_migrations() passes the size of
nodemask in bytes to migrate_pages(). This sets the maxnode to 8,
so kernel only checks node IDs 0-6 even though the nodemask covers
node IDs 0-63.

Pass the nodemask size in bits plus one because get_nodes() in
mempolicy does --maxnode.

Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 39ce9a9369f5..761e47e4cae2 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -310,7 +310,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
 		 * test may break or give a false positive signal.
 		 */
-		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]),
+		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]) * 8 + 1,
 						&nodemasks[from],
 						&nodemasks[to]);
 		if (pages_not_moved < 0)

-- 
2.43.0

