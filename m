Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A28308F3B;
	Sun, 23 Aug 2026 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492229; cv=fail; b=q3eolibYr0NrJz/Y0ngLVZQ2/gkhL0IwhVXd9ex3auW0Hvznln4RwrrvJGq3qhNo5oRGpIJva1IjNc333Ce0oYbWrDU+jGvVe2u+SaZZHTQ4SOEL8qikswjLDRcamMRYtmBRlZ1Srn7HEVGhUJP6H94cnN8wvJ7uMXIQeG1iQts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492229; c=relaxed/simple;
	bh=dXBKg5fXAKj1J06FIg2E6wP+hH1T9We3hGHWo+1DfNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J/l3xceXz98VygmSW3uSqbJxLs4ujZAOyjZrxlO0x0AzLKmS/kbej+oTAPLp1K/FzxGxd/W67W5bJENYkVH3zytoSuC2PDeppHuPHOc4LdrbkTPkJZGZIaMLN1MOgrTt5FgIecMoak5uR3DFCV+EalOUhrUEZuXMv0x5BErVBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F96IVbui; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F96IVbui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ8I/GzUwgRnrt9Yn24+NKb5svknXwqI2BhwCxj9ywDf2UnyxQeZ2UZnxpTpqaYD/kTxylL5tg3YrJgkeq0/4QSuoo5uh7NrMa7H8V7hlCzJHutT1RpO5g5hcgeLo7Fb3jS3wyQ+mlSwy37qofKq/RSD8ygehfmVS/CTnPXpjx7FFecS5prW3U9v7Qth8fEkHiHSwbSO2xBDgBtqtBK3ES2IS+1rtWTUtobmXhQuXmO11Qtf2KPimgmCG72u8WjkRSezauFN/eiyeiu48vBgz8ay/6iEURlvflZXBhqoSE1Dhb4UryMTdRzBpSMFlVGQ7BFylbjqzmnCRyfRDtOndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KklIybxAVesquBLCUQC12uQsLRjArXF17xfa2W0HOEM=;
 b=BpgoonOcBVZeZCLpxzfYw1AwAU9HGRBQyCn7faRAUy5JWUEVc/ovpTnRlmx/APSeEA5juTC2uTSURw1ADEn9N3091f8lTjPJ8o0enNeyXyKxUK/K1x/tr9eeLBxjIjkX7w7jrSrP5f3xisO56+BpUbaYWeuMllhQ/F6uPMgPP5wWsSwfJ9YaaMmTZv+3P68UwxOhL2EELwCgngdPY3D9Twf+529QLt1Eb3oZ9DH6mG1OKmEyrEXospvK+91WFa2ak8n5ZzNLj1kBmhvbl6M6zUoDKC1n84CvwcxLK3IxmyD4/B5ycS9+gDg1//azLruJRoA8jJP+GE7d+lA0vwH3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KklIybxAVesquBLCUQC12uQsLRjArXF17xfa2W0HOEM=;
 b=F96IVbuiH3Odq142Mh35WnV94GkQmrpyktcUUaw9YOlI93fPVe01190Qga4g39R5tWZx0LH8O1/dPKnaL9SUGXZv7KKCamrN0GCa6bvrU2+WmiUt7wAMvyUQGCsOldcbwoJ2E7tgti007T70uIaFgy7zRcvqkwd363bz1JcXHjw=
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 13:37:03 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::4c) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Sun, 23
 Aug 2026 13:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:37:03 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:59 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 23 Aug 2026 13:36:33 +0000
Subject: [PATCH 5/5] KVM: selftests: use allowed NUMA nodes in
 guest_memfd_test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260823-shivank-gmem-fix-split-v1-5-512a29fb8e86@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=9670;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=dXBKg5fXAKj1J06FIg2E6wP+hH1T9We3hGHWo+1DfNo=;
 b=QfEynsOzsFQsZQeWLNzdEeowxRDIfc8a88pRRvsRtU7zHn2gf7i+P2LK5TGpYQa+xw7dygxn5
 eUF/t1W3IgXDAK7gZ06EN+58TZTjbqnC0fQx30lnFVrhNVgGyct9OjE
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7903fc-3392-4166-96c8-08df011b9db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CxW7Un8mM+6NzJzG5gsLCtaXLFucB0mSQZJRZOxkkEYHt7ELgpea2sxd5tXxBco4E/jP1zTekyzqbWaNEafgiybZwDWn5dRpivYKIQZ0fxbQpW1MdhVUlz5+cqOLTe4DoVkLW7TlrMkN6pyK61fuHE6t2iCX5FFPx5QgO28yY/yZd8GHbao79SLDMUMja0hLKzHEPYHZHNuPkfq9Q2eIQ7+p0FxvNUh6t+cO8uzgQcmV8668HfFE0bwdHJ46fjzOfahFMaWof6UCwZkiAqn/oDYmtIfFPqUHTk8Jtw8PD7UzpiNpP9dlsPXYJarcgsicP4Riumccd9Dfd+0vhKPHjpsO9YLCtYRkAZ6DcUalUTUzgIdCQQ68rkqzEoQ+7v9RyQ1DmrR1GeUZJvmfmDqZTHoTqeGasOd2+RubOPqVoIy4lPiDsgBJ8YMHnp4Sdbm1cUZuFa6d9uJWoCJEYTrrCDD5HaaYPQbP71G1eeBSnYGDjya+ypOVgllchOKCBMuLZKeELVZL0NPA0d+k/gcOYWYeSkKenjFn8JxWYgf++0yn7t5VBARdYk1QQptVZOjWSBv9JMbxseYkBPVBcrIeefhJrmK+6SUgFlDLR8dB+lIIITmQt7oZqrfcT0n7n/VAMR5WclEI83iIeqjH6DoZpf9Hk6ZZihuqAoPah6SAGJtNO5ouq43B8Oge8PIcxF5l
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5PO6mL25gVNFNdANWDYpxZKgP4SIl6Hgk1og++T00iEvGZbaTE6Z/tPr1jSyxW3WMh3g6pJ+YyiEU7SmVosW5xiNITtNOJIiW931kn67qQZcwz9cAnqF53tU+d4RF89iCWB9pi/7+Sr27dOaL6BIP/IuqP5Esc45nrz9eBESd9iV8OaqiZhgNhxlvn7bHp4KQWv7KadL5tkUlFEQsuqZLcMMjzO/sye9aGsnvgrp+YvQEr936bOI8i3ZmrVWyS17rLZIUM0RVTZ3dF6+RD6gbm6Dll2LaqImNd6UqhcQPtqR5fYKcAtEjJZRtpL7aEp30gtL7dNnl9com2QNRHqroPeDLoz1LHcufHeV1twyETVtKYTW/H8SjwPymOIHy6fXTqNuLaCenpES8Z0TA25J6sY70PT+GO+eDRZW+NkqK7pNOwo8xJoyX3fp2TrfgVHN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:37:03.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7903fc-3392-4166-96c8-08df011b9db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787

guest_memfd_test assumes that nodes 0 and 1 exist and have memory.
is_multi_numa_node_system() only checks that the maximum node ID is
nonzero, which is not enough for sparse or memoryless nodes.

Select the required nodes from MPOL_F_MEMS_ALLOWED instead. Use the full
nodemask width plus one to mbind(), and let test_mbind() run when only
one memory node is available.

The sysfs helpers for finding maxnode are no longer needed.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 86 +++++++++++++++++---------
 tools/testing/selftests/kvm/include/numaif.h   | 52 ----------------
 2 files changed, 58 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f..aee80dda6229 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -76,33 +76,53 @@ static void test_mmap_supported(int fd, size_t total_size)
 	kvm_munmap(mem, total_size);
 }
 
+/*
+ * Fill @nids with the first @nr_nids nodes in the allowed mask.
+ * Return false if the mask contains fewer than @nr_nids nodes.
+ */
+static bool get_numa_node_ids(int *nids, int nr_nids)
+{
+	unsigned long nodemask = get_numa_mem_nodes();
+	unsigned long nid;
+	int nr_found = 0;
+
+	for_each_set_bit(nid, &nodemask, BITS_PER_TYPE(nodemask)) {
+		nids[nr_found++] = nid;
+		if (nr_found == nr_nids)
+			return true;
+	}
+
+	return false;
+}
+
 static void test_mbind(int fd, size_t total_size)
 {
-	const unsigned long nodemask_0 = 1; /* nid: 0 */
-	unsigned long nodemask = 0;
-	unsigned long maxnode = BITS_PER_TYPE(nodemask);
+	unsigned long nodemask, bind_nodemask;
+	unsigned long maxnode = BITS_PER_TYPE(nodemask) + 1;
 	int policy;
 	char *mem;
+	int nid;
 	int ret;
 
-	if (!is_multi_numa_node_system())
+	if (!get_numa_node_ids(&nid, 1))
 		return;
 
+	bind_nodemask = 1UL << nid;
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
@@ -112,7 +132,7 @@ static void test_mbind(int fd, size_t total_size)
 		    MPOL_DEFAULT, policy, nodemask);
 
 	/* Test with invalid policy */
-	ret = mbind(mem, page_size, 999, &nodemask_0, maxnode, 0);
+	ret = mbind(mem, page_size, 999, &bind_nodemask, maxnode, 0);
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "mbind with invalid policy should fail with EINVAL");
 
@@ -121,17 +141,19 @@ static void test_mbind(int fd, size_t total_size)
 
 static void test_numa_allocation(int fd, size_t total_size)
 {
-	unsigned long node0_mask = 1;  /* Node 0 */
-	unsigned long node1_mask = 2;  /* Node 1 */
-	unsigned long maxnode = 8;
+	unsigned long bind_nodemasks[2];
+	unsigned long maxnode = BITS_PER_TYPE(bind_nodemasks[0]) + 1;
 	void *pages[4];
+	int nids[2];
 	int status[4];
 	char *mem;
 	int i;
 
-	if (!is_multi_numa_node_system())
+	if (!get_numa_node_ids(nids, ARRAY_SIZE(nids)))
 		return;
 
+	bind_nodemasks[0] = 1UL << nids[0];
+	bind_nodemasks[1] = 1UL << nids[1];
 	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	for (i = 0; i < 4; i++)
@@ -139,34 +161,42 @@ static void test_numa_allocation(int fd, size_t total_size)
 
 	/* Set NUMA policy after allocation */
 	memset(mem, 0xaa, page_size);
-	kvm_mbind(pages[0], page_size, MPOL_BIND, &node0_mask, maxnode, 0);
+	kvm_mbind(pages[0], page_size, MPOL_BIND, &bind_nodemasks[0], maxnode, 0);
 	kvm_fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, page_size);
 
 	/* Set NUMA policy before allocation */
-	kvm_mbind(pages[0], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
-	kvm_mbind(pages[2], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
+	kvm_mbind(pages[0], page_size * 2, MPOL_BIND, &bind_nodemasks[1], maxnode, 0);
+	kvm_mbind(pages[2], page_size * 2, MPOL_BIND, &bind_nodemasks[0], maxnode, 0);
 	memset(mem, 0xaa, total_size);
 
 	/* Validate if pages are allocated on specified NUMA nodes */
 	kvm_move_pages(0, 4, pages, NULL, status, 0);
-	TEST_ASSERT(status[0] == 1, "Expected page 0 on node 1, got it on node %d", status[0]);
-	TEST_ASSERT(status[1] == 1, "Expected page 1 on node 1, got it on node %d", status[1]);
-	TEST_ASSERT(status[2] == 0, "Expected page 2 on node 0, got it on node %d", status[2]);
-	TEST_ASSERT(status[3] == 0, "Expected page 3 on node 0, got it on node %d", status[3]);
+	TEST_ASSERT(status[0] == nids[1],
+		    "Expected page 0 on node %d, got it on node %d", nids[1], status[0]);
+	TEST_ASSERT(status[1] == nids[1],
+		    "Expected page 1 on node %d, got it on node %d", nids[1], status[1]);
+	TEST_ASSERT(status[2] == nids[0],
+		    "Expected page 2 on node %d, got it on node %d", nids[0], status[2]);
+	TEST_ASSERT(status[3] == nids[0],
+		    "Expected page 3 on node %d, got it on node %d", nids[0], status[3]);
 
 	/* Punch hole for all pages */
 	kvm_fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
 
 	/* Change NUMA policy nodes and reallocate */
-	kvm_mbind(pages[0], page_size * 2, MPOL_BIND, &node0_mask, maxnode, 0);
-	kvm_mbind(pages[2], page_size * 2, MPOL_BIND, &node1_mask, maxnode, 0);
+	kvm_mbind(pages[0], page_size * 2, MPOL_BIND, &bind_nodemasks[0], maxnode, 0);
+	kvm_mbind(pages[2], page_size * 2, MPOL_BIND, &bind_nodemasks[1], maxnode, 0);
 	memset(mem, 0xaa, total_size);
 
 	kvm_move_pages(0, 4, pages, NULL, status, 0);
-	TEST_ASSERT(status[0] == 0, "Expected page 0 on node 0, got it on node %d", status[0]);
-	TEST_ASSERT(status[1] == 0, "Expected page 1 on node 0, got it on node %d", status[1]);
-	TEST_ASSERT(status[2] == 1, "Expected page 2 on node 1, got it on node %d", status[2]);
-	TEST_ASSERT(status[3] == 1, "Expected page 3 on node 1, got it on node %d", status[3]);
+	TEST_ASSERT(status[0] == nids[0],
+		    "Expected page 0 on node %d, got it on node %d", nids[0], status[0]);
+	TEST_ASSERT(status[1] == nids[0],
+		    "Expected page 1 on node %d, got it on node %d", nids[0], status[1]);
+	TEST_ASSERT(status[2] == nids[1],
+		    "Expected page 2 on node %d, got it on node %d", nids[1], status[2]);
+	TEST_ASSERT(status[3] == nids[1],
+		    "Expected page 3 on node %d, got it on node %d", nids[1], status[3]);
 
 	kvm_munmap(mem, total_size);
 }
diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 55124e2330ab..4bbbf314e9d7 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -4,8 +4,6 @@
 #ifndef SELFTEST_KVM_NUMAIF_H
 #define SELFTEST_KVM_NUMAIF_H
 
-#include <dirent.h>
-
 #include <linux/mempolicy.h>
 
 #include "kvm_syscalls.h"
@@ -30,51 +28,6 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
 		   const unsigned long *, nodemask, unsigned long, maxnode,
 		   unsigned int, flags);
 
-static inline int get_max_numa_node(void)
-{
-	struct dirent *de;
-	int max_node = 0;
-	DIR *d;
-
-	/*
-	 * Assume there's a single node if the kernel doesn't support NUMA,
-	 * or if no nodes are found.
-	 */
-	d = opendir("/sys/devices/system/node");
-	if (!d)
-		return 0;
-
-	while ((de = readdir(d)) != NULL) {
-		int node_id;
-		char *endptr;
-
-		if (strncmp(de->d_name, "node", 4) != 0)
-			continue;
-
-		node_id = strtol(de->d_name + 4, &endptr, 10);
-		if (*endptr != '\0')
-			continue;
-
-		if (node_id > max_node)
-			max_node = node_id;
-	}
-	closedir(d);
-
-	return max_node;
-}
-
-static bool is_numa_available(void)
-{
-	/*
-	 * Probe for NUMA by doing a dummy get_mempolicy().  If the syscall
-	 * fails with ENOSYS, then the kernel was built without NUMA support.
-	 * if the syscall fails with EPERM, then the process/user lacks the
-	 * necessary capabilities (CAP_SYS_NICE).
-	 */
-	return !get_mempolicy(NULL, NULL, 0, NULL, 0) ||
-		(errno != ENOSYS && errno != EPERM);
-}
-
 static inline unsigned long get_numa_mem_nodes(void)
 {
 	unsigned long nodemask = 0;
@@ -87,9 +40,4 @@ static inline unsigned long get_numa_mem_nodes(void)
 	return nodemask;
 }
 
-static inline bool is_multi_numa_node_system(void)
-{
-	return is_numa_available() && get_max_numa_node() >= 1;
-}
-
 #endif /* SELFTEST_KVM_NUMAIF_H */

-- 
2.43.0

