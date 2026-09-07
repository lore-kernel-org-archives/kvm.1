Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CF4028E2;
	Mon,  7 Sep 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765938; cv=fail; b=kr5bLWtL4v8notUvCXJP5nvmwTh6Tq7vE65qYxXERIZZStW9a97Q0uCNec3zAchyp8k4P0pWrkixtoWx173MrEgXvRrMp+yA5a6BOaXWQTbvs2Qjsh5qOurWn7WWzea7rvwf5wndxyK/F546yal184PVxgiuGEP55zmkk/BLMEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765938; c=relaxed/simple;
	bh=xrU7H+LuLzy+SuPJFHHxlAVuqVsTz9sRLWqyKCys8DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DXrRpdUpnB2EZqgWP12kEXY0IDwyqoE0O2YjXKrG9TUj2XhakQEO3Ll+m1RKPxW7GgIKvkpKHn7QuSBsxAjjYeF12CofKQBa55bjdbfKAL3dm3avCgHyo7JsmFv+N89T5nq8Fu8iffehaSz90uhdQEyzA0XMZEb0Eo+Vmg0EbRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYbXACIo; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYbXACIo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+JcBFcSEerYhmonKa0avUI+1FGDUf8Ua3LEPhYwMNAAwSJ9zTe2YRwZ9lx5SpbvdTIsrpRsqbRvdWbT2oaVhBjeAk7pOrOi/b7VLqTC0teqv3RFLM1wP9AABlEjXa3/L3/GkzcWAekARboHVHOm2FwEkGbeEbEWp9gHOg4iOM/65l2XfET/h3n4CAK2f2zHnmJo7RJR/3J6UwW8R9uE9QJkKGVMPYFsB7aVXNt86nOILosyrMh8BGdFkCwX6K7JP1ef5SDooj1NGWgmTfLDEH7t6HD4LvJjXXZssVfpvkFdP0R2aSFtqFdb+4nrwFSew4dkpg1nvYZDJYcwnK/+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPdIjorzRTedDhsE33KExSW424HIfCF+NQS7ruuAws0=;
 b=EdOLGXKPaOTOHEvsuSP333xYD+bUWD6A4TsnLlCEObZpCvq8/e7gNFVUBqBJMDBBeJhEmDyG1nxZRG8awE9vBjT5yyWASP7j0gz5NbisnDz4kS64NSSok9xdxFu7y7cVm9tMa7/b3pK32o4vsw82qRv8rATkiMUU5reVgeeSej5eUS6rzw9Tf2bQy+JG6jXM8rJ9eNB1oR8GufZ1aLDXpdZ7JSPfprwGRrE+Z/H41zCMwHEby4s2SCUELO4X+Srksn7gT/2HapfGdEMTX7QKacqAB3mJuYdmj+axx7HX61xMbpR1BE+h3eXvjIeYMi+p/2B1R5YZsOsU5agnj5Xqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPdIjorzRTedDhsE33KExSW424HIfCF+NQS7ruuAws0=;
 b=FYbXACIooldUmueZHH4GFDecmAMO6Hqh1Yw5SwjHBTxfaraWz2soMToGeDH0aiVAnq2wEXgRU5EHiIXmR5SCAPh1bPJaN6I+FwlcPZoGnjSytT1pFT7DDywnzVLT0RdOZB5+eRtyvZDks+PrxDrUPhUulTKasz4Nhu24InNMyR4=
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 7 Sep
 2026 07:25:32 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::31) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Mon, 7
 Sep 2026 07:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 07:25:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 02:25:28 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 7 Sep 2026 07:24:57 +0000
Subject: [PATCH v3 1/4] KVM: selftests: Prepare guest_memfd_test for
 arbitrary NUMA nodes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260907-gmem-selftests-fix-v3-1-7a4be5c1cc8a@amd.com>
References: <20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com>
In-Reply-To: <20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788765924; l=5772;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=xrU7H+LuLzy+SuPJFHHxlAVuqVsTz9sRLWqyKCys8DQ=;
 b=Amu+goajO5c/yF7vi9DQPyKUuWGur1ZKTYB2rq/c+o5V+uG+wYU/iktPT/IsZXmLzFkO/IyE+
 TTZd8Di217sDBZxxMliCd06ptEb5dtcIyNkJ5q0985Nnor2PsFSGVnv
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0eb053-8a18-4c1b-7acc-08df0cb13361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wrm+WjTSRydxH4GFJeD9VubnJm2YRUMa3EjRNL4GwCUuV5I8qBc2d0at+zcIZYFEUOUXKRCGf7UplCAPadQSq4qfxxzzwFdrwP9GndIVAukN0jlAZxffQeRoqAKIWwyEUr/fUJ3rpm5ukHzw+LgUmLQhpHMa5vAm82iJNwYzwhkK/Z0qaK8COyhHs32wVjz5Sg+WdW1czNdB7+Klu12xUe923m5OPuxP5QI5NBrEIsx+EBQrTBwsjoBf/lbwOVLr4jmNk7f8q8YjbRW3TuOKBqDN43gpADRGGVXn26bCF+ZCbctR6T4YNDag1zy5f0TDfZU/utQHIHuXAbyyyU1t9NHdjvVzIlrbBzYvAsn8XzqEwovWwvaTqS5AjA+Mg1hTsOnrBUbmZOMeooNbXRHrWkmdOM0ivAztRHCihXkgTAtwdWUpHrE6KOqf863ShF7xmbxxHpgaBO2/xng1caQH3ej+uaIJTYHheMk9Aj53LZ1Bukt/tIwWLQwWKZ/SFxAtDbkPvkXtdNXydFLcziMb0ACsqBSpdyuyKD+q4lbg4YdF6gyqyak60xiRBZjIyfWMTuzgltaP3ZU99455EeQFI7I2N2rqUIgGDpJJz2SSIm5f2btHcuJPfpRwlwA+2S0VOpwAZdwZWKWH0lrm/c5jr8HAvrb97tIgddJ4J2PXJHfRSdaVT01LZt0/RH00BaSbXzMc9bxHk7qBLY1kEeOBHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5vJYChCvxmPknaotJyLz2GCm0g/tkkpJQIEr/tw+0KT1U9I7brKW6zJqS9RFwcYNRLQNEYnaSnLGs0I7vNjDBv9JzWuZS4KkKAid6Ve5xSsgHXLJShgfB7joqoWVVL5ofoCcd+ljtcYljg90WrDeipVnDCRP6P1YYaKBdOsd8D0mw+wdONeDICD8cII0IbyYrMVA+xbDhXAPQ9ooPyV8RXw52uFJOGIMWIPLNAAze2A7Mr/WbdAoHmaNelnCbsC+f1mjyj8+CNDOtNMEX+tGZfyXMS5a44ZhK9M+Odnfc2MyumycYcUksJ5LtCzmrt7vLEtjpfo+9qZqPCgfkI48tteh4VUwQiVSqyUg1CsnJNJ2YY3v5BT2Y5w0Ek3Wk2vqpsnbpbA2e3Dz5giwc14cED3rHGmJ8smYpLoVJ2UyX8idDbWjUGjcW8KEv7lXUVoQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:32.0234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0eb053-8a18-4c1b-7acc-08df0cb13361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

Store the NUMA node IDs used by test_mbind() and
test_numa_allocation(), build nodemasks from those IDs, and use the IDs
when checking move_pages() results.  This prepares both tests to select
nodes at runtime instead of assuming nodes 0 and 1.

No functional change intended.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 53 +++++++++++++++++---------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index cd5df88bc642..b3bd03167ba8 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -78,31 +78,35 @@ static void test_mmap_supported(int fd, size_t total_size)
 
 static void test_mbind(int fd, size_t total_size)
 {
-	const unsigned long nodemask_0 = 1; /* nid: 0 */
 	unsigned long nodemask = 0;
 	unsigned long maxnode = MAXNODE_FOR_MASK(nodemask);
+	unsigned long bind_nodemask;
 	int policy;
 	char *mem;
+	int nid;
 	int ret;
 
 	if (!is_multi_numa_node_system())
 		return;
 
+	nid = 0;
+	bind_nodemask = BIT(nid);
+
 	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	/* Test MPOL_INTERLEAVE policy */
-	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &nodemask_0, maxnode, 0);
+	kvm_mbind(mem, page_size * 2, MPOL_INTERLEAVE, &bind_nodemask, maxnode, 0);
 	kvm_get_mempolicy(&policy, &nodemask, maxnode, mem, MPOL_F_ADDR);
-	TEST_ASSERT(policy == MPOL_INTERLEAVE && nodemask == nodemask_0,
+	TEST_ASSERT(policy == MPOL_INTERLEAVE && nodemask == bind_nodemask,
 		    "Wanted MPOL_INTERLEAVE (%u) and nodemask 0x%lx, got %u and 0x%lx",
-		    MPOL_INTERLEAVE, nodemask_0, policy, nodemask);
+		    MPOL_INTERLEAVE, bind_nodemask, policy, nodemask);
 
 	/* Test basic MPOL_BIND policy */
-	kvm_mbind(mem + page_size * 2, page_size * 2, MPOL_BIND, &nodemask_0, maxnode, 0);
+	kvm_mbind(mem + page_size * 2, page_size * 2, MPOL_BIND, &bind_nodemask, maxnode, 0);
 	kvm_get_mempolicy(&policy, &nodemask, maxnode, mem + page_size * 2, MPOL_F_ADDR);
-	TEST_ASSERT(policy == MPOL_BIND && nodemask == nodemask_0,
+	TEST_ASSERT(policy == MPOL_BIND && nodemask == bind_nodemask,
 		    "Wanted MPOL_BIND (%u) and nodemask 0x%lx, got %u and 0x%lx",
-		    MPOL_BIND, nodemask_0, policy, nodemask);
+		    MPOL_BIND, bind_nodemask, policy, nodemask);
 
 	/* Test MPOL_DEFAULT policy */
 	kvm_mbind(mem, total_size, MPOL_DEFAULT, NULL, 0, 0);
@@ -112,7 +116,7 @@ static void test_mbind(int fd, size_t total_size)
 		    MPOL_DEFAULT, policy, nodemask);
 
 	/* Test with invalid policy */
-	ret = mbind(mem, page_size, 999, &nodemask_0, maxnode, 0);
+	ret = mbind(mem, page_size, 999, &bind_nodemask, maxnode, 0);
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "mbind with invalid policy should fail with EINVAL");
 
@@ -121,9 +125,9 @@ static void test_mbind(int fd, size_t total_size)
 
 static void test_numa_allocation(int fd, size_t total_size)
 {
-	unsigned long node0_mask = 1;  /* Node 0 */
-	unsigned long node1_mask = 2;  /* Node 1 */
+	unsigned long node0_mask, node1_mask;
 	unsigned long maxnode = 8;
+	int nid0, nid1;
 	void *pages[4];
 	int status[4];
 	char *mem;
@@ -132,6 +136,11 @@ static void test_numa_allocation(int fd, size_t total_size)
 	if (!is_multi_numa_node_system())
 		return;
 
+	nid0 = 0;
+	nid1 = 1;
+	node0_mask = BIT(nid0);
+	node1_mask = BIT(nid1);
+
 	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	for (i = 0; i < 4; i++)
@@ -149,10 +158,14 @@ static void test_numa_allocation(int fd, size_t total_size)
 
 	/* Validate if pages are allocated on specified NUMA nodes */
 	kvm_move_pages(0, 4, pages, NULL, status, 0);
-	TEST_ASSERT(status[0] == 1, "Expected page 0 on node 1, got it on node %d", status[0]);
-	TEST_ASSERT(status[1] == 1, "Expected page 1 on node 1, got it on node %d", status[1]);
-	TEST_ASSERT(status[2] == 0, "Expected page 2 on node 0, got it on node %d", status[2]);
-	TEST_ASSERT(status[3] == 0, "Expected page 3 on node 0, got it on node %d", status[3]);
+	TEST_ASSERT(status[0] == nid1, "Expected page 0 on node %d, got it on node %d",
+		    nid1, status[0]);
+	TEST_ASSERT(status[1] == nid1, "Expected page 1 on node %d, got it on node %d",
+		    nid1, status[1]);
+	TEST_ASSERT(status[2] == nid0, "Expected page 2 on node %d, got it on node %d",
+		    nid0, status[2]);
+	TEST_ASSERT(status[3] == nid0, "Expected page 3 on node %d, got it on node %d",
+		    nid0, status[3]);
 
 	/* Punch hole for all pages */
 	kvm_fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
@@ -163,10 +176,14 @@ static void test_numa_allocation(int fd, size_t total_size)
 	memset(mem, 0xaa, total_size);
 
 	kvm_move_pages(0, 4, pages, NULL, status, 0);
-	TEST_ASSERT(status[0] == 0, "Expected page 0 on node 0, got it on node %d", status[0]);
-	TEST_ASSERT(status[1] == 0, "Expected page 1 on node 0, got it on node %d", status[1]);
-	TEST_ASSERT(status[2] == 1, "Expected page 2 on node 1, got it on node %d", status[2]);
-	TEST_ASSERT(status[3] == 1, "Expected page 3 on node 1, got it on node %d", status[3]);
+	TEST_ASSERT(status[0] == nid0, "Expected page 0 on node %d, got it on node %d",
+		    nid0, status[0]);
+	TEST_ASSERT(status[1] == nid0, "Expected page 1 on node %d, got it on node %d",
+		    nid0, status[1]);
+	TEST_ASSERT(status[2] == nid1, "Expected page 2 on node %d, got it on node %d",
+		    nid1, status[2]);
+	TEST_ASSERT(status[3] == nid1, "Expected page 3 on node %d, got it on node %d",
+		    nid1, status[3]);
 
 	kvm_munmap(mem, total_size);
 }

-- 
2.43.0

