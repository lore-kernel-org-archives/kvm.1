Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A203A0E8E;
	Tue,  1 Sep 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251033; cv=fail; b=BR/0r34IC1zS6pwJEGOw10BuEBOwFPfzGwIeMbbiwlv3ph4mz+sX3wHu1PW8JlScnDK53zYcg2BzbN5qVp5I6O4ky0XCxKBacd1TfsAvxh7BXCIx5U4Hhke6bLypmwzTN5oZ6GtixeTwSvXyAKQkcr5cUes5nDgkR+wOvStzIT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251033; c=relaxed/simple;
	bh=BBl1Tm7P/OzM+h2Kdl5bx0mDHHBfcZNO6rNdtpbVK/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f75H1EQd7qtqG95VORwsKwcABl7BKiyEeVNgaV623ov7B69BTRCQeFJR9QMx2E9F8wX+CZZfBS0JydTf8gDobCOQukpnyVqTaocu9MLQPYYCXiqV1T7AD9S2ZsA7VWNILSfNKVJzTu5O7Y4v3s7Xo0yxgtiVkDS97b6m5Jc9h4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiFcwmKx; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiFcwmKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTOQsPWoM8tkLsCmPcWlIorlhGvsNcdWLFKn9ajVY/YZXCrgczV546k9Oo3oS3d2kU3l4xU0Uzx8aq82ja841jWzYlASppAW/KEF+L3XEDvmxW/VeIgA/rancV72oBgej/Kb1z2Sasb+qsrhTV9qt0d+n+racrVeKeM2g2WqplS9A+ImGulrMsW2JG3dVEqYxlH1R2nwXdSUAKX+sRlXrAC5CHnKdP00nLc0i/lbrEft6s1/tjtUlxqng4sr98Iqs/q9Q5LtAa4SoVEEr4a8QztHNFcT7w7bwvbrHqcOmFjCOPwb619kvgd4HI0bpn3Qbyt7YId9DSVibvxlSImpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqZbRBaimtUBpwvNoE3za4Q+BTZ33nirepG7+JsrnTc=;
 b=bFBQcINLXihY8Wjv2x2E/1r3ntNtxVX9Mji3z8PbDzcVXK1fxFQsJo+aeMpzkHtStiyYa5/lbxCYy/Hi5vz6/jcOmsp+P7+wjSWcNwvlVchH1OjuB0fH3ZBnWYqUwS9xinoMrQDULNTs+01Qv3mh8/2XuYj2YeuifMjOhdzIFpquIF+gw6zMP14dvMLk4rfBj0AWJrfuDgcsYUGSdhweyQi/XXg50zdClEWmzl8S6HoffMMSkEh1pq8juFvaD20KK4sXfN/FesKn//FkRmiqtziE8XOrn9S1sH+D+QlMZH1xk1hhy0sdaAY4Gky7cLQmpJDnCJxTvLNSMinO111iUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqZbRBaimtUBpwvNoE3za4Q+BTZ33nirepG7+JsrnTc=;
 b=JiFcwmKxP3P70dQjU28AoWLPmbeizjyrl8qSxlaqjv2gjL93R+GGcv+0f26CcaxYTXJ7fO2HjSqMsg0Hs5IuaGI2wZ35kFgLBt8khJ/Z1gD8lvkpqSHt52kqz0VZ5KNqczacHmDDC61dIxKu4SLT0k/VwEq4N1EsLz7PutWQxEw=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:22:58 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::81) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 08:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 08:22:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 03:22:54 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 08:22:40 +0000
Subject: [PATCH v2 3/4] KVM: selftests: add get_numa_mem_nodes()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-gmem-selftests-fix-v2-3-5a273153354c@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788250963; l=2585;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=BBl1Tm7P/OzM+h2Kdl5bx0mDHHBfcZNO6rNdtpbVK/g=;
 b=Pz5rRQC2AqOpkSGhexYlcsC5dvyh3Eu8h+H7iPMurDSQUioA2rSHWtgFhYr65wICQNr3sAlDm
 cbf/0Gmx6HgAyntzf/DVZ1VA7DvFJQLYXthnZQ2vMG6DNW6gatrvkl1
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: b23c9297-491b-437a-7514-08df08023b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|7416014|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ll2JlPbDVW8DLX5D/aGb96O4euzDM48weTAZHxBMSWwki1tI2R7Prs+0gIuS25tzrTfvonGLsejcfJjzq04Z9FvuxoDT1tSGAB64cgmxROxCzoUCcJtHODrFrPV1kJZLhK7FX+vS0JJTXB1M4TIFL9d9LehMPOAy3ad1d8upcQG3945mqJyOsVxfyegE64t+QChojzFlkCDWtxhCrG9yYTVIO6ecAL3Ln4AsCGvVTsDjY5EJIZQQX+Irbt1W7OJ/5FNhdFgjvuex77xUy7hysjq7hs2DuNSD351JebPLnoPfghwydN+ttqaK3yawk8lQjW6hoK7dVvkWd0r5F2zxJiwKtaFYoKKnfql8kzhkVyuulYXIlkIKZqFgDdaNMJIed50iU4i8RuCM6vrRvZ1sUHer7yqFdJy7yaV4G08pvD+VIKerZkQBVrEBTnxzBNGaDC1DQvmUO9awLcWwQEtEH4jrp5IsoeTcIcu8NISVBydOaX7Q5cFN5Y/Ay6Ol7WmE0tieAYzEXqUhVtOgOYYN55CWShRvva33bcrxSQ0PDB4/C0LpV6/0gsPqLkIoIzxuzom755VvObAbbvuQrIM2mKXwYipRjJLmA+17+5TcuqI1MsLx9HK5myCsVgTrl3TKsj42/QyqjDw6HWccQyCM/GUeVVxgQPzelQyh4JmWYntahyoK50PQWBPlDuY9mvVj/4M5GdMIn9FwGkylAeqAEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(7416014)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sJ8wIxa9HDuoRBtB/zb67kal7i9+1mJGOfEn7pmwfEJogw9N9wXAhLWaK1yhiVDatGESS9PZ5v+THyyCAZnEGQBOhQV85gdgbIxO9oUSStHEFSzFkLEdG3vQ3OK8osrxo7ikoVsj5au0qOZw97bn87CV1ZJ5pXAEGi7IaWLNu6TsK422d1HQ4YUJO4rBQtPXXOGo7oruE/pzs+TKwFWJoP8fzYyaF+YLqdqokAJYoZSkDIYVDLW4xZ1YCLxLl+hEjstEzKYndhXsmoxzRQGHAYekOfnuu+vfX2QdeuOrDBB93eS6XTUsRWZwslpo6a6Ev7bTFOz2AbhZCkcEHxtXf/xtMKhYpkjjQqpcnULlzI35CYJpoQolD1A5CeFoh2tquYwulSgIZGzI4f1yUMpUjxcEZWTKtfkDuR/s48kfS8moTbA+1GsZpFlFcpvFepql
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:22:58.3357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c9297-491b-437a-7514-08df08023b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

The xAPIC IPI test uses MPOL_F_MEMS_ALLOWED to get the memory nodes
available to the current process. Move the query to numaif.h as
get_numa_mem_nodes() so other KVM selftests can use it.

Call get_mempolicy() directly instead of using the assert-on-failure
kvm_get_mempolicy() wrapper. The xAPIC test already asserts its two
node requirement.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/include/numaif.h     | 13 +++++++++++++
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c |  6 ++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 29572a6d789c..98cf77cfc481 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -6,6 +6,7 @@
 
 #include <dirent.h>
 
+#include <linux/bits.h>
 #include <linux/mempolicy.h>
 
 #include "kvm_syscalls.h"
@@ -75,6 +76,18 @@ static bool is_numa_available(void)
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
index e5706dd62d3b..b5f4ed671218 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -232,7 +232,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		   u64 *pipis_rcvd)
 {
 	long pages_not_moved;
-	unsigned long nodemask = 0;
+	unsigned long nodemask;
 	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
@@ -247,9 +247,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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

