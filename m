Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BF59B56;
	Tue,  1 Sep 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251009; cv=fail; b=PdNWHl3XRKsGySQOGTACfF7h0NQZdxsS2+0VnvrBtY9Pzjov5426DxY66QYWGLIKlX+NUorncsaFG6TYHlA5STZRdSUWbrOuWGpfcaQg8Sxp/qt+Ij3exrJVl9KolQe61IGqicu3srx6JTZuvyAvall69k5vGKY9G/HId+qq6aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251009; c=relaxed/simple;
	bh=qZsi+lWaZPe33wazwqQ0e5b4+vXjBypkRgp+LGRfPYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lDIXYEwxVrz+MV7YFVVXK7udsKcPfkCizH1EVyQLFVwEdkIAl8OGbPylPPs3WWdh3+TA5SXYUCCNRdcnL+PZeSYji3QVQhmEdM1gVwIXFuWibhuYNJ9dke107nKqoXaWyxGYbrc/gASaYSQ8mejJyIuMuGiYtnRvxaWg44NHFBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NhBFM30V; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NhBFM30V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4LMitPE7IFeH98cypJlY8pflor6UgQMawlYmci/w+XckwoJac79BmUseDHjSqL1gCxty33SzbsPdIKB7NZcsweR6dR3/b3WXaCpYLjYVjbS5Pxr+EUs9F5+AWSfbsw9oRCGA3FEyxsIcEA8pvWT1NXupjy+6FoaCwiXnGv+X462gwaeUVJmpalAqb5P2DY+W4NLePmol4Lrwat0qlDDbVRouwD17lAyBgCEt5ZUuf2EvEYa9tLeqJWfwsQ8y6eN6qvv8d4zEKj8DpVdrw7gWKhRDoXdks8SggAQn8Y8GVe2Eo03sjTfkK1mHlZfCqoberbNZXooX0Nlh1l1+//Hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXZFvQkcGJsmYnkTO32YQC7/xL8lKTen1UzNwphV69E=;
 b=RmcgRh+i6oz1Tkokp5TNf5x4NghRRtgeq53AvmTCoA1gEstrqPtb0Q5MzaIw26cVdSWlq/XI+3FLKItKQfHsUN+sO/TRBYmQ+bcxCUyNWosmThK19v9KRJ6O2Xg0ezkaI7Qobr61xzsTTUlXlL5vroVwVLWw4gHpHx/dGhdWqMueM0HmwPLyV5QruYgA2iIVYruls1GmELnoD9uDNHGMPNdwBAzL4adipuNqTf+FQYc6l9YrleupgsApWN1hLkBV+h/hDzC27OlI+APT3Aooba+a29IkSqYfRqlJgX/vdsU96VsXCy4MxBJuRWkOKiriNt126ZOqBTN2pNPk1mxp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXZFvQkcGJsmYnkTO32YQC7/xL8lKTen1UzNwphV69E=;
 b=NhBFM30VTE2WL2StI7g4prtFUM1Xh4D8Y1sFVU99nvXSatl0TZGv19Vyk8yrFG02artJQ8cUiHy8S1ipL37UKS1GzPZnzsCXOzEVNIj4usevcHw4mKcs4PYF48EyTgFq0OY4HQq+0Ip2sM8U4Xta2DC8c1oJuhJUEFAdFrZ9ANM=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Tue, 1 Sep 2026
 08:23:01 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 08:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 08:23:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 03:22:57 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 08:22:41 +0000
Subject: [PATCH v2 4/4] KVM: selftests: use allowed NUMA nodes in
 guest_memfd_test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-gmem-selftests-fix-v2-4-5a273153354c@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
In-Reply-To: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788250963; l=9668;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=qZsi+lWaZPe33wazwqQ0e5b4+vXjBypkRgp+LGRfPYM=;
 b=BUDZaINVBcm/LW9HWb6h1ah8gbNGmRAjPfErmKgtPMr+Hjg/X1z3jNzn5L3G36JwLdbBCF7k3
 OhAWV3PsAMdBLee0mqOA+O+8RWIBt9GUu+LZCywbSVJy3As5NMmDyPx
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: adccd9fe-f6f5-40a7-d6e8-08df08023cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GsOwRiro/Sdgge7B7pETQJiPFI+T4lnAxv4kNHo2YrTpyJ/Zykn4dg8KUUUlIwAvD0z8ZpjDI6dtknS65pQaIPALqaRdPitvrp29wli2eLSPTE8m9xIOqSVg5WElPlolB09Hh90qQx+QPSWjy0aRT/U8JhthmBziFLgEySMtIJQF56eTO+FGCebaVMTuXJM06kCa9i/vC0wEBiPIE9w1OMDOrlbB3GWdZl2BBcIpIVNgBE2rKyUV/IRK610wMO1opo8ImuhtCXDKXS9Lxu3kpcHwEO3O8OgfSdZRW34Nl3lJuNPm5nSkQHyjy/2mn+4ZbDEyboDRVB/fizYuWb6S3+4jeqf/MuGtuTv0dOfFa2pCb3kUs1ID8/uOKGac+5cioFZm3AEGU4fDaxWW8sSO9VWP9+3iVieosRJsDwE/Nz2MGQIaNPvEKqJTPmgY8DJmH4/fuwggHFV6tJB2hXRIhgngll+QYJL6n5Ym2jlasEq3o8Vls11oLHDNCJ6CiRshyYFcta4sadCi0kXpUNXdoM8Y0hh2U+K61MUGz1/7fgPYp0Qors+lsIibAodz/zd2RBMw7KNOtHxAlBfcVFZVZTMsTq1YNpxq/kZ8eyB8/HFFQkNIVm/Amlq/zCw5QD0JSi5JWiQtV9UC5GYwvuHOQxkM5mHBKQUwAUIr4xMCPY3Ge8lRAhgJRM+ewif/u5+u9iwkw937D23K46KpBdlyrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TQARpS5v0mBzchoDkmXZknt1f572/RqsoXg+6H4jOWUxQA6lPlL+XVO124yrNZTG3ySpMtvbJwzGkMT3oyZhdL8aQD8mUcV4Tza3Y74UXSrhFp/SNN3bCdLwqMtvSC6ZCutD6evCknKTKp2mDCrrfTHD1yUFK0h77U5RjUCANQec8Bqo0ChsUS7GjilJGt2hz/2CsfxgeVl0gcbsbPuFeinNeup2zAIrSXHTSC1xS8Z6fDfg8ukcaAOlEiuiLIOJ2wqPrtUw/pDLbzUw+buUs8kvVpgN5ud291r3nA9yAXl+Mgq3JWv1kgjiKdZzcbjGwJSAWUYc4qZ6d1AX4Vtg9/LzsG4FAUTuroi7o9yECUDQh+pRFz3gssI6pN6k0vAL3FVmX22NJ+RUeCKNQolxMTEOvi6SnausOUTArMvx5Vtj0fvvFnjfWq7ddcpjSEA+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:23:01.4905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adccd9fe-f6f5-40a7-d6e8-08df08023cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774

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
index 98cf77cfc481..b89559b6ea3c 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -4,8 +4,6 @@
 #ifndef SELFTEST_KVM_NUMAIF_H
 #define SELFTEST_KVM_NUMAIF_H
 
-#include <dirent.h>
-
 #include <linux/bits.h>
 #include <linux/mempolicy.h>
 
@@ -31,51 +29,6 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
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
@@ -88,9 +41,4 @@ static inline unsigned long get_numa_mem_nodes(void)
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

