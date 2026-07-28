Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC941B36A;
	Tue, 28 Jul 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229669; cv=fail; b=FAmE3rGL0E4m06Da+c27wk19NmENMniWgbzX5hH5qa+Ag4tR3NDnHCsIsfhhqxBbnTr1uYv0+1H2hNvOc40VfJoQNFvuBf8GV+F16N1vu1Sc/fNGG2KRsB35W5XzMGtmfp9/V1dm667zbxifk/GfsGP4E1uMp7EJ826Fdz7UZ+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229669; c=relaxed/simple;
	bh=VNdI96t0KQwayuA0CeJ2whh9QjY4LVFWJDKSPaZu8RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KA/+DOdUOEOHbnB8R4QUYVDutL5IdpyC6FI0JTQPRz5gyejaTpSKqepR7nZTxSMpUVD48l9k11oO9K62dYgtW9olfFZi/wjtqQ+80y2O33rElTluj93T8J6omJizcKCE93WWDBrKSo/hrVVLZq0vffBYaydCvUs+2mz/9RFtWb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDQn2oSR; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDQn2oSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFcRXyNqh3FBIWh5YTn4u5XxVJQn4rjV+PfZfNmUiISpMewf8MUiv3QOqcGNZ+hRxngPR2Vkp8lbQdFclX9ore9MTXXgj6C0P5w0OGUWvXTZ7PpmHNpiICuZh8NOZeXQRuiKx6OKMkPxP8nZbT5xO1R6F+HJby1SNa0OU07uswJVB7P+uzXbCTlugAFKu7KPMll8gAhca14DH2rPTpA+jwohBZWmosVy8GKMm6tLnesI8eAy4b3u4stFP0dMe8lSC7JZRzvvKEu3dnBY+xvuCQ7gXcFWb+xP8XDVLgArSzQTY07BHU2WFJAuum3m1Dvat47euEd/TmqrCb/xr48u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbZXUDovpD5wFeivRWzIFccj7JVz9qdbtF6TmjRN8Js=;
 b=C+Xr2ZFQBR0P/dSl8zWss2rjTNuMUofPKUokuuVjWtdci5Htuvo9KTeTguZ91HkshQIh//4LRkJn82r2/aQj/r3WAothIGPHJ9mMC7dwc+jOwS51fGyeELPm9xJQifH8xfwAj6HyNMHRnzFdsfHbYEfwMLtav4MwaynXm9ISSMY3J23TWMMPy/BwZaf7mYlMBXAwMw9GfjbzZfMRuFnc6XsvzyIpdFwTy0vJybz+MxYKTTxs2pyR2Gvg+OJPIhX4a7MVAvNg2hOj7tx3KBpfdCojf12Qr7xSbRjztHSgV34a/eu8cCcIidy8nuXsgqLh2LZTaeJjR+d9kisRJ9+P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbZXUDovpD5wFeivRWzIFccj7JVz9qdbtF6TmjRN8Js=;
 b=pDQn2oSRblfYJgYvamkuxMzU42baBs0s+JIVLwnDB6YDVJwViQqB28SsJR6wn60bLPFctwmjgAnkA/912ua/6taODK2MkOCnZ2iqlP85m0p9hKcPi5VEo450fxa+7WMEBeincmfn24Asolbd32aWXWmZpjS4D2WCuCigQ1nkPPY=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 09:07:40 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::14) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 09:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 09:07:40 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:07:30 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 28 Jul 2026 09:05:37 +0000
Subject: [PATCH RFC v2 4/4] KVM: selftests: exercise guest_memfd folio
 migration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260728-shivank-gmem-migrate-v2-4-269ac1f84e2b@amd.com>
References: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
In-Reply-To: <20260728-shivank-gmem-migrate-v2-0-269ac1f84e2b@amd.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
	<david@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Chao Peng
	<chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, "Ackerley
 Tng" <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Vishal Annapurve
	<vannapurve@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick
 Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>, Ashish Kalra
	<Ashish.Kalra@amd.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Ira Weiny <iweiny@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785229610; l=4543;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=VNdI96t0KQwayuA0CeJ2whh9QjY4LVFWJDKSPaZu8RU=;
 b=Syu99l0mo7WyZLlDq/6jRactcfMfoQw5H+atF+briDh90+Ibp+4jh4WkDy0uZKk9uKLN01z+q
 3O18EzffbBqBkxTNsVs6Gcl/u6sCXrwtLN4vXHkIAInrvBWc6Z6pTgU
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a2e1f3-c42f-469b-e683-08deec87ad76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|23010399003|1800799024|921020|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Jzrm5BdFPKlQ53ev/00eeMGDIvDR0ipnEZrkVWwngxaZu/TKf0Vv/42AuSyvTP2zG6qI5Zargm6FUHpv9uBLdNEObON/9lxO7vMNrAjPuK8NNAYl5CvlNlvbcSJNKlLKfsIzOl6YO1tmtI2siA3FPQj7k3/sE/fkFu4NmBbEpjhs5wo1hK2RGZQ3TAynNhBNZsPMi5EAnEWLfWu7xzehYjFUPXEi9JolxNJwvUkZHXsWU7DHNZiLM9a+7ETY1svyj+J9YLgAtY/4n2kjTqdyT33kSsFOMSIZm2Gf/sJjqU0d35W+jWD9PWG23ZDVV5mB6jF85NQL6AiNJ8vJGYZyGrieNW2ovQSilKobTWtoe7j4gwG/duUPhAqGlT1Q3hyMOtkS5nEm7hnyoTytPHX++2LPjlAcUZlp+uj9ME2MlQzgXu/MGhGPUS9bzs++vo0NPqUUNYGVONubGzNeIc7jUKfixzLnS7JOSAHlI74la64C0I+sKD6kLagl3CvmGiasgWXhFlmyenCZuN+mvqHEw9WxyR1qA9+2YCPWobV8QBLDH/0TfldhliGK8W+OQELfs1IXvov5kOw2MFKEM3FT52lj/Zv5gZlND4ixbkc+v03HRiAaSAzDczcTo6hSYEwRzgMZIgFFhU1oy1TXLAAe8ASSj0vo6IG9gfHOe2KHdVBiQpUN9aMJBYQxYqJM6r+ICQ0jWtPwTWPzkbFVrsDSj1aRttBp2ZEZhMH/MpCqmJUorYnPJmR09R3vKTFNqXLv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(23010399003)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	USv4GbUztay1QfkhYuIBA4/9zdPG55Hw2O40rCtd6ORgB5m5In1gb2wevimqms7rc48j3WC6OCK1Nx+mZngUiYER4GJgItI3VaYfsrZxrNjaSHythadWx4MRM3oEh7fYGlRxz1i5QQetfK0wiDKDVZ9W95DTsb4J9KH6DkLSZJCpAX0JSm+7/Ntq56K2EWIQMdiMu+19hXbH2IH8srM2YN/mcaT9lTvUO+UmEe0CtATSQaQllnz83vGao5kmV7dsTPSAPjt6/I+r6JoeIlMzk1Q5qAqfOmp62qlZfrKlXxjhcujJKRRTPFcEG6Wm0L/4/tlD0gYRZsrYW/7GXPWM6ImGjqLaKHJohCRD0qP8nroAL9Kj2lLCLMZgbMAYsymBcQqgzdFYVZwrwz31a2qKGbZBJZqcWj2mBxuxmamEoiue1ArbgnooZ4y3XRMUxUR+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:07:40.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a2e1f3-c42f-469b-e683-08deec87ad76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

Add a migration test to guest_memfd_test using guest_memfd files created
with MMAP, INIT_SHARED, and MIGRATABLE. MMAP and INIT_SHARED are required
here because move_pages() operates on userspace mapping. Run the test
only when the VM supports all three flags and the system has at least two
NUMA nodes (skipped otherwise).

Migrate every folio from node 0 to node 1 with move_pages(), and
verify both the resulting node and contents. Migrate the folios back
and verify their contents again.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f..77e034a9d587 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -171,6 +171,82 @@ static void test_numa_allocation(int fd, size_t total_size)
 	kvm_munmap(mem, total_size);
 }
 
+/*
+ * Each page is filled with a distinct byte (its index). Check every byte that
+ * data is intact after migration.
+ */
+static void verify_page(const char *page, int page_idx, size_t size,
+			const char *when)
+{
+	char expected = (char)(page_idx & 0xff);
+	size_t off;
+
+	for (off = 0; off < size; off++)
+		TEST_ASSERT(page[off] == expected,
+			    "Page %d corrupted at offset %zu %s", page_idx, off, when);
+}
+
+static void test_migrate_folio(int fd, size_t total_size)
+{
+	const unsigned long nodemask_0 = 1; /* nid: 0 */
+	unsigned long maxnode = BITS_PER_TYPE(nodemask_0);
+	int page_count = total_size / page_size;
+	int *status, *nodes;
+	void **addr;
+	char *mem;
+	int i;
+
+	if (!is_multi_numa_node_system())
+		return;
+
+	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+
+	addr = calloc(page_count, sizeof(*addr));
+	status = calloc(page_count, sizeof(*status));
+	nodes = calloc(page_count, sizeof(*nodes));
+	TEST_ASSERT(addr && status && nodes, "Failed to allocate page arrays");
+
+	/* Allocate all folios on node 0 and fill each with a known pattern. */
+	kvm_mbind(mem, total_size, MPOL_BIND, &nodemask_0, maxnode, 0);
+	for (i = 0; i < page_count; i++) {
+		memset(mem + i * page_size, (char)(i & 0xff), page_size);
+		addr[i] = mem + i * page_size;
+	}
+
+	kvm_move_pages(0, page_count, addr, NULL, status, 0);
+	for (i = 0; i < page_count; i++)
+		TEST_ASSERT(status[i] == 0, "Page %d should be on node 0", i);
+
+	/* Migrate node 0 -> 1, then check both the location and the data. */
+	for (i = 0; i < page_count; i++)
+		nodes[i] = 1;
+	kvm_move_pages(0, page_count, addr, nodes, status, MPOL_MF_MOVE);
+
+	kvm_move_pages(0, page_count, addr, NULL, status, 0);
+	for (i = 0; i < page_count; i++)
+		TEST_ASSERT(status[i] == 1,
+			    "Page %d should be on node 1 after migration", i);
+	for (i = 0; i < page_count; i++)
+		verify_page(mem + i * page_size, i, page_size, "after migration");
+
+	/* Migrate back node 1 -> 0, then re-check the location and the data. */
+	for (i = 0; i < page_count; i++)
+		nodes[i] = 0;
+	kvm_move_pages(0, page_count, addr, nodes, status, MPOL_MF_MOVE);
+
+	kvm_move_pages(0, page_count, addr, NULL, status, 0);
+	for (i = 0; i < page_count; i++)
+		TEST_ASSERT(status[i] == 0,
+			    "Page %d should be on node 0 after round-trip", i);
+	for (i = 0; i < page_count; i++)
+		verify_page(mem + i * page_size, i, page_size, "after round-trip");
+
+	free(addr);
+	free(status);
+	free(nodes);
+	kvm_munmap(mem, total_size);
+}
+
 static void test_collapse(int fd, u64 flags)
 {
 	const size_t pmd_size = get_trans_hugepagesz();
@@ -472,6 +548,9 @@ static void __test_guest_memfd(struct kvm_vm *vm, u64 flags)
 static void test_guest_memfd(unsigned long vm_type)
 {
 	struct kvm_vm *vm = vm_create_barebones_type(vm_type);
+	const u64 migrate_flags = GUEST_MEMFD_FLAG_MMAP |
+				  GUEST_MEMFD_FLAG_INIT_SHARED |
+				  GUEST_MEMFD_FLAG_MIGRATABLE;
 	u64 flags;
 
 	test_guest_memfd_flags(vm);
@@ -486,6 +565,9 @@ static void test_guest_memfd(unsigned long vm_type)
 	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED)
 		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
 				       GUEST_MEMFD_FLAG_INIT_SHARED);
+	/* Testing with move_pages() requires MMAP and INIT_SHARED. */
+	if ((flags & migrate_flags) == migrate_flags)
+		gmem_test(migrate_folio, vm, migrate_flags);
 
 	kvm_vm_free(vm);
 }

-- 
2.43.0

