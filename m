Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E72F7F0F;
	Sun, 23 Aug 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492225; cv=fail; b=taZkdbHGM6jGf3Qzki8BqGRSDhjL1iKy+tXDIPmcPp7Lpn8c+fxNe4/XCwLjaC2CA6dzkblh41oMV6PWXr64CT4Bq6QWK+ET/53VcCA/SqMYpAutxc/qx79JFOBV6L27q1IGlP8ryVmEyfGgdRVkc4kGRHJa6VbIEBEM2cnZItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492225; c=relaxed/simple;
	bh=4zperuRefGS9/dWP8CCI2r4B3olGwgompH/Zj9KXkuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=s1SeXTXfOkPmhJvwEyttp8QNgzCiU6C+68awCorflYH+ZkfCMeR8RLS9lTVTtCVWvlXMfFdolaiUn/aWkpVorIgReherdqFa82tzCLb/ZJ+7V8X36u/WYgD6gYEiM0HZjbm6bjNp/tK/S1R0b469oguK3dLkCM6lJMzLTPdN4xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sYlDddWL; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sYlDddWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGi38Ne5cGeU4R3xhe02iKvvLHvXjJYoiS9MAEmUvNhuxtPq7UHc0IvQVkXym6oB4NPczMpVSRjEgQCq4bLfyG2FQ0EwFLyuF5w8/+scbR7D0LmnQ7SmBZ8Qx8anxeMOfi+rXOHV/jRI+MR6f7LgxDAoeOJdZHMoFQX7DsPoPQRmcqQI68gtH0YQduqbw5L9PCs7e8LymrEdW1DKTu++tAxv1BqoWEJnIIvAeig8pzfxyaWRYf3U0ae8WQeOJ7NFwVhJ9wA7fQRxyu0nl2smNNxpNOl0CPZ5wOGFlp2/WhF2SIJR6jRTTUoYGGWIO+y6FWjq9qo8bBBwJnJ8F5PVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAOKOFsD0mkH/dUzG78vyaDwu0cWpfSC6Roky+0Uwv0=;
 b=BiEyVnrv7/Yk2kp62mu6H+8ct/pe3M9LRpTXsIgNFkxC1if2bVUM/zNsQ0OCzXWef+9BYFjRjY6qF/aTvB3Qvk14fBc0ySTNle76yuJIzEnzlemLVzeBiGN2t2ix69ugBPNkH9awX/pDf1Ul9G9VZovFpJ2Fr0V6jlnlPV1d2p1lj4SLWaNFcdNp/mQZcN61DvosukQdoJUtMvDvjTcoReUdjrihIVlFFbDbxpJNnTXX7RKTuZjfsRI0rSxokydAY8EyL5r6ieco8ScFAP0nSfKyES/DisUcj+ityQRlaoIclcmpXzCweoH3gb7DeeAaa3ifNQgFD3mM+QiuI77Pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAOKOFsD0mkH/dUzG78vyaDwu0cWpfSC6Roky+0Uwv0=;
 b=sYlDddWLjktvRPg4GR7kX7U+myRrdXDMELCz8mWZbF/GdPU/08qPCnC73b29zZBnyV5blnAjKpNEPnj1yB7zR4WxMWe/ROSJea+pxAsJ7b0uNbBNXl3q4ijA18m4BiC883VGTLst9irgRKn/mOtyEfHQ8XDAta3IR3czPzqq5fw=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:37:00 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::82) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.5 via Frontend Transport; Sun, 23
 Aug 2026 13:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:36:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:56 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 23 Aug 2026 13:36:32 +0000
Subject: [PATCH 4/5] KVM: selftests: add get_numa_mem_nodes()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260823-shivank-gmem-fix-split-v1-4-512a29fb8e86@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=2451;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=4zperuRefGS9/dWP8CCI2r4B3olGwgompH/Zj9KXkuM=;
 b=yFiJ09FRSfNoA7zmGdRTNSNuTbJvaYTKKq1Xp0ZNv+cVNEdY0J1D0PmW4e0dfuh90vtRYTvhn
 hN0YevfMkb4DphGvlUZZRsVTwPCmJ4HV0TgwkAIV3+bIyjOjtG3hxAL
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e5bca0-9a8d-493a-a0b0-08df011b9b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xsCW/kK0Tibt7IkzL9T+6sq1qEFjIVyvuRG6hD19V9QAN/5aLEaMza6Km8nrdRhDUnsQbt4Blc2LaNNcwb3pBG5dJ/BrXdbWYh7wUzuDotdLHjWTY3Jk4y/U5gzsZaA2fw9RKI/4kOrQ9awnIQzT3OekdTQZtsPam5upXZ8humPpZwTX/7/4QckELTTN0BsMtaYEwUZpk8ogY4iUrMz8wlmun1ulCEq4OMHA+u571Cdm27Oc8TkeDg5djcsK/pCdUknyO+XQ/iWQaPqMK7cykCbUiFNKlxSoF7Cvm9jG4va48YfpsGWclsGFXPyX7nFyrzzsdQ07YjrY01FaWenIgvVFTnZsQ7a+aGoubbhCaZ0UtoSRMmEiayjaEHgifN+6DfjS8mXl1dwK8AAvZf2UaeB0VoJKPZCrd8enA+6fio+PxGkkUH3C6GTHoju8Aq0cuP2X5kXejwztc+Mc0UpFAf/FVqZEICjUiNyKCpxK309vHNqmUYnxyUBe1nB3tvf0EOXryVzxgSNwcyI+HYOiqyM5KKH1K2x/HgtR6zFT6KWyDF0vriuhnHvOO81Wrx6Pm+su/LvTRRZ+PIgMYofBVFO4ZQnVvFUm8bTGkIYYLUcgaCarxU0gUzQnT2haQic1yMPjZ91DQKdCWvt7U1puqeJu85JrCp+ILpCPwEM1G+o1AeBauZXHkQRdGTNueIPXt3+Ln6/KrHJ/SwMRUNz19Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9jr+pqGrZCL6QxAkOWKPfYRoHHqNYMJF7nIUEnCGvDZT+hpQAiDgGwgs6IA96edL5Z3KShYqB8HGeeP+PB0Kw4UZsGZZedIUCIbA+bbr3ZOYNTkNs9+U33CUOsdhfOvI/oGip8IrvXB6TL7r0lS5LzuWTCRvNbk4TdbfyDFBePmyAB+80o1NJukyD+n0Q+4sPNCyRL375VUWu82n/2FHwIhz7D1lyTvx8CFWP4/LZoC3OSydqVghBt7bxJCjqsjr1wj12DQDd4VkQrpS6Qr44xrUm8WjPQt2NzQoSIGU6A3zvXbRCe+Mwy4+fgOcxnQIq3oFij9TyOEym0GSHd2GFEAQzsLhW2FU6Z0UBlofe1Wejj7/Yv1KYKrJNP35V0ZtQy7XjVguVQ/WLESJAII6iWX2KroPwb7susVDSmwFR/TIte9z69mwra3wJ/7Tu6qo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:36:59.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e5bca0-9a8d-493a-a0b0-08df011b9b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411

The xAPIC IPI test uses MPOL_F_MEMS_ALLOWED to get the memory nodes
available to the current process. Move the query to numaif.h as
get_numa_mem_nodes() so other KVM selftests can use it.

Call get_mempolicy() directly instead of using the assert-on-failure
kvm_get_mempolicy() wrapper. The xAPIC test already asserts its two
node requirement.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/include/numaif.h     | 12 ++++++++++++
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c |  6 ++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 29572a6d789c..55124e2330ab 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -75,6 +75,18 @@ static bool is_numa_available(void)
 		(errno != ENOSYS && errno != EPERM);
 }
 
+static inline unsigned long get_numa_mem_nodes(void)
+{
+	unsigned long nodemask = 0;
+
+	/* Get set of first 64 numa nodes available */
+	if (get_mempolicy(NULL, &nodemask, BITS_PER_TYPE(nodemask), NULL,
+			  MPOL_F_MEMS_ALLOWED))
+		return 0;
+
+	return nodemask;
+}
+
 static inline bool is_multi_numa_node_system(void)
 {
 	return is_numa_available() && get_max_numa_node() >= 1;
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 769d8d95ab2c..66dcf36398aa 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -251,7 +251,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		   u64 *pipis_rcvd)
 {
 	long pages_not_moved;
-	unsigned long nodemask = 0;
+	unsigned long nodemask;
 	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
@@ -266,9 +266,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 	fprintf(stderr, "Calling migrate_pages every %d microseconds\n",
 		delay_usecs);
 
-	/* Get set of first 64 numa nodes available */
-	kvm_get_mempolicy(NULL, &nodemask, BITS_PER_TYPE(nodemask),
-			  0, MPOL_F_MEMS_ALLOWED);
+	nodemask = get_numa_mem_nodes();
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
 		"(each 1-bit indicates node is present): %#lx\n",

-- 
2.43.0

