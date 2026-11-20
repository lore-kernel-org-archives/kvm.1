Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174144;
	b=usjvraH6eH3dsLCR85IZdqAu/1KVUA7Xpoq7VATLTfsPWoCqd1nCj8Yubh8Oaq63+hwE
	 aaDEdQca4LhiR8Gxrtnr9q/b3uhLOtqkJ4EPzZZaIIss/JCMAUvlzZQaG7WIFUTYkFKUX
	 Ti2Tkwr7pmURJygEAvIiXPT36Us068QupqGAL+nAktTGRHmYxz5sHR/CoW0h7rE4a9sZR
	 G1CkqkiKM82F+5s0pXBXWsPFtB644Aoyhnryssyq/ln/kzULnAr2KYkhsZmL+cu7qAb5c
	 /lcxWybADzmuKTkHFwjYd5NSE12ilDDC8AploAPdYFLkm5NCZIRcu7h2K5juWyDCArQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wWToSiKRAsRKT/5OiQwHnJqL6/EgcT4uX0i+K+swT9M=;
	b=nAz2R6tmYtrnvkgpc3fjqeD6kVEfYmWRbxKwZRIWFN7iNZmPVh676o8tsCMWfKGx9guI
	 T2QoyfZECTjJR+FLSCzHF7LY06DjmJOtOrFbc4eiZw086qTQxqPCR5HPsMYT9nkZggPh4
	 WNczMg+/kJxWyXJIGWeGMf5Bvu8RLfm8iGNHhTDqJ28u9SHGaZda8l/EOnS8RhhC0wv9c
	 9a3rvkSs+UCXzQdNSaZbdN5O2eCbzed/6dyM42FFI5YMcCo+sz7lPvyJ5s5ATLpadpstp
	 dzBGUNj4KUxPeKPx5Ha/SO7K8W9qoF4ctX/ehZhO8hiOY5UO23xmQxNEqEr7KxROG+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LDWPzGEZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.47
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D606A326;
	Fri, 20 Nov 2026 11:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LDWPzGEZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDWWRZoaajKTwAh1gK94OaWllsmrDR3PTNxfyMPitpTjWly2BaDuo9hh4PAkpB1z0quUIytp6oSS/8Ax7ZPIajWw7rhemuQvKhC7RpkixIUXrMiYRNy18iZGYzRxIGtf+LqULuJsLNsMqJ09i8M79q0mRuFSzDpImshmyGcvok1GSqZmaZ+i9VlwgZENxHZNtlFXzcsuOAZxQtoGK9qEKio27KcnbHUIK4UQnBVq3mUr+9X2ZhDX38gNHlowY0DBXuSuxbQT9s6cFUNnsb2EWHvsBkhAu9VhfDvkiPhszk9fObN2oq0bn0+6lIywAdqzmAoYm9Akr9DfziPoG5wO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWToSiKRAsRKT/5OiQwHnJqL6/EgcT4uX0i+K+swT9M=;
 b=DZbXroqes2+++rkSLYkBKxlkLumWcaroN3hTyMmtChtJTtXcXkRrB6k6trvu+kK7+Bpzom7EjSevZ+urDlw660csxsNHAXWK1HDaI5pkXR8PAvqfecNJoVtirLqUTF39P/KbtqjTOvRzKbWlX92BsJJ8spiao8kFdTzyIu9K0NrcZpwFU9zGNvcafEQ/pGTcxyX4OvYjRmW6rnjUFHDxcSiWE858TXpFSZDAcKtYD0c3vxreDgAv7uGpEYeNlarRahcWPQhinsY65gLmUMN0+I5P3D+67UihTCXt0FwXjG7hF/H7oKuSw2Ln9df+UOPxTP1K7lhg60i4Zglm2gGDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWToSiKRAsRKT/5OiQwHnJqL6/EgcT4uX0i+K+swT9M=;
 b=LDWPzGEZUSNaG8F2XI2YmSAAOBwc6UFEIPH5vL8JtYOCgsVnpaGTcXKWkyQ7vmgc/R0HjZb/fQt8HWUaMknDTH5U/4a+KKbdYrztuRp4df0vY740t9InhxkPt1LqSdkVhTHT3TKBacRllPDd9rw45ENHkYA0NBSFLuwLPEhHQYA=
Received: from DS7P220CA0060.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::25) by
 BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 11:28:59 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:8:224:cafe::56) by DS7P220CA0060.outlook.office365.com
 (2603:10b6:8:224::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 11:28:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 11:28:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 05:28:54 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Fri, 20 Nov 2026 11:28:39 +0000
Subject: [PATCH RESEND v3 1/4] KVM: selftests: Prepare guest_memfd_test for
 arbitrary NUMA nodes
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-gmem-selftests-fix-v3-1-d94ffe17ead6@amd.com>
References: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
In-Reply-To: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>, Fuad Tabba <fuad.tabba@linux.dev>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174124; l=5772;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=o0ENxN5scgtW4qPSQidhouUo3qOYkeufndh1ddmSKe4=;
 b=1kuYYZiUVhu7J2N5rcF+A6ZbYoF5ZbV8xr1xfi9RA9AhSSSjopPb8pqFyfiObbj+UgzwO10ng
 zvU3pJW2MvpBQguhd2S3siQjX9xd24p9hgsihXgoF5LqhFRXaMVwQJE
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: ee056b92-eb64-48e9-8ab2-08df46f97862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|6133799003|18002099003|261009223027099003|22082099003|921020|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	jgxZiEdnAaOkFq90Nhdvlxg/CQFeKQMuitiUF5rUttEhX61nxXS4I61WO5qWAfzFBXCdlCZmx8vEJVeO0l8vGgIR/vDNQyt5UqnrjT3n0qxndvJWGu6YdNWqkqjhOnPdr4lZvOnld1M75bS4ysE1RvX02Nr5tvyHJ8/O3RJJAhqzeeQ3j2cT08V/o7xBFA5cV8zaNulmzjOcWfMe1xTy6R6LTrYGsZGcYzySSx55EICSZlbcrdWH+AQDFt7xSdtKGeGKbe225Weue3ja9dRZsPOmWWhe6C85mPQ54AaFtB3KaAivB1HamDSntm/fwpOflUiVx/Nsh87Dl+OAPUOhOUrr3adLeyb5m2ncllLG7yVwbCSn0/2l8Wp8UrePSMaN/VpApXq82kaDhWY7EIr/6hdzwcD/PaF6gkg19Mbtw1yW0ZZxm9YiYJgD5flSIv5AFygnnF3KbZMCdOLnK+lkyj9B+g9CcF97UoriVdwFHV+KGqla9r8LJEqzjvkYtygduODn5HM97unI+MhotsCEdYH8LB8Sz2hBo5sT6xNMGdldtaG3EKWdh4aH96gLn7I4pejkix/YLd75/fXAQ13H4XQx5Tc5FbqLtX+s7Xp6JSYAA8ufctv1ZV2u1uWBIacYrkOAKSD6bh3QjvvVCkV+IcLfojuEjvaQnf71FLmhscwkAuekpsHW36F3Do8fqIMlEL1qLyDcCDlC3AN0rvMmAJKYn9a5a7IgH1C7VXXZzXOzlON663IsBF/WN1KQoPfZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(261009223027099003)(22082099003)(921020)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xj3idMLsmAhgapBecybFfceF2JdMr30jtdjz8JIyVp1Gduor6Iv2lKXNWoz3tz0iwdJyJh9TVc3AJrNq5kslPTjXO/X8uhqmXyuqX1G4ISVNDB8nxU/rJhj+xxVJFyMf35yvlt/qNh0Qek8mxdiL4ty5+JUFLEiVS1hxfQQms2nyfimxaJyDAk28Jg8z/nqsXvUp2Q8/KXAvAwWYQIVrVhG3C69DNUOU6oVIMewwgBMEJVyjLDay14zsLgGZcqTKMHKlHGxo6x9u4qkwqYxtrbDO/FCr6QG4kslI2Tpt56hYwbWxl4zAaM4IbtlqiaLHjsEJ7qH9hSOJlMmztQ6WoMUVcA5sixAMl0Nt+4INs/h2nGwxPjGAaxKBDgROFxaLYa+nyUSFzSOyOTZVM1BoriM29uqcAbRhAS4jP8BEsmmwz9frJcWXlyTXHpbfOw9w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:28:58.9537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee056b92-eb64-48e9-8ab2-08df46f97862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

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
2.53.0

