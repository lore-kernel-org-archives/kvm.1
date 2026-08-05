Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA53DB314;
	Wed,  5 Aug 2026 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912162; cv=fail; b=WhgH0Sy9lfQNPz1IeKJqqTLPhosv5DBT2UKmygZFQm8FSmxDtfD6cdcCFNpc156eJEs89II/tlQiwfuvz+7vrMjBVa7a3xt2YIixYp+Do2oU1YNNCTLFSvG9TbuIKKpKORfIFj+VLB/TkTOgVaO3bKMJkyfeWGYcqOA+3Asv9o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912162; c=relaxed/simple;
	bh=4zperuRefGS9/dWP8CCI2r4B3olGwgompH/Zj9KXkuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cn9JMBRVuhndoQW7Hg3/V/cAnAnzkf3KrvHQjdpiLwY8H/rDHJUHtYBxb7igmxdfxg+3wvu45FcDaEaWhCu/BG3U+dzwHqm1ro7tbKznCtL9Cb2WiA45S7moyLbRCgWpJRRFErcvXghvvaFeAUq2OV0a9e6Qk/+opcb/gse1AJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yj5y7vn2; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yj5y7vn2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYyQ7J4UDEcGPWpmAHQJS1dtk/c5dHf4LSQDs0YZSE+E5u1Covk6Gqct7h1wG2WFnYAutp6/Wx+Mon/fg5VKd3nsv0i+vvc6EKbo0pqgtvm3Nqy/4FwhT369ZWwA6YiGL0wzf5/fO6CtMrhTAHm11VHcw8dZBmBgPpoIIngBRsPf+BCI+i+UOBqfx5qg17tAqfnGie+tMgznz7I9SuWzwY67oyTV943n7Zsnbqk14dK6UOZulxdn79Wr5KgoJkjTlG3ZxR5mB0Tx8a7zlbFjc4hKTYDeMet0ex2c6lEuhKnk7L60w0P7u3wPFRrLKgPSsPAfFeNw8Fv2hQwEQUPBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAOKOFsD0mkH/dUzG78vyaDwu0cWpfSC6Roky+0Uwv0=;
 b=daBkytS2C3PY9z4C5t+IDsTUH057nt1cqTLWM3fmYTWuCArW+T00NdVEPrPSQYzZrTjQuGdlykvf5PUZAes9g6B1BPrfb8s0VIxQ+3uEfDeydd+y56CQWueKdrbxIA/MEbc1X/3MVEz6mWQ0lGp8WnxcXEA0JySlWnjZo+PkviiHMHqUtK5Mzf/fRqAOpuSVKIJoGP6GzJ252Jw9rCEyNoiMHfiv1OKNSBmoxJ8a1e0qwmYO1f1BonHkXC01A35X6pbuwAsqcimh6pUUBL2Q3Gb3+2+SVVVju+Wj0UMt4vHuYWdohcdYpwHtHtaTGJsYIcJy/ig7O6Dk2aeVfsElwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAOKOFsD0mkH/dUzG78vyaDwu0cWpfSC6Roky+0Uwv0=;
 b=Yj5y7vn2L+WzTJPKyl1QCQyTTxeJdVrg49FHAmORdkGu4AUw58rEcu7R97WQPuJ4r1XXdmp0/LZdwBqikmcszzy5K2TEuZm6dhBMvGgzXQJ1dKKYkk4sdMjOsaTM48RUzX/QCAmyfNMczIsQQHDnOZINT1pkrdbcn94YJGUfuCA=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:42:33 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::28) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:42:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:42:21 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Wed, 5 Aug 2026 06:40:36 +0000
Subject: [PATCH v3 7/9] KVM: selftests: add get_numa_mem_nodes()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260805-shivank-gmem-migrate-v3-7-00d8bdec4e1d@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
In-Reply-To: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
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
 Tng" <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>,
	"Vishal Annapurve" <vannapurve@google.com>, Nikita Kalyazin
	<nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@linux.dev>, "Pratik
 Sampat" <prsampat@amd.com>, Ashish Kalra <Ashish.Kalra@amd.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Peter Shier <pshier@google.com>, "Jim
 Mattson" <jmattson@google.com>, Ricardo Koller <ricarkol@google.com>, "Ira
 Weiny" <iweiny@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
CC: <linux-fsdevel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>, Shivank Garg
	<shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785912059; l=2451;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=4zperuRefGS9/dWP8CCI2r4B3olGwgompH/Zj9KXkuM=;
 b=8vnBGeQVnQPENKHreqngCe6f6MtTd/FEYlGvK4zNzKwVNIZ5Gl0Ht7siywk3YQvDt0/wnBgUN
 2ceK2/bW0XPAuF82/xeQOius1z5nBupWTyfF+RKTcuLgfV7BXF9gegF
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0620b8ec-804e-462d-c910-08def2bcbaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	mFQqW0nsUedRXzuhPpGiy/DnlhX9WmvbJYjVH2m2pfVT/8/xpmniohXbc5czTv8qcpGWpcXkScB0tMcLfCK5FsBCRqMjvCjtx/UOWj/ii0Xlrjk6FD9OXhGOitGLVYglSYT1fpy4MUgqWvcHdcLqlpDQb+r2DN/jMQc3yCUzVPxFWpuDQgv5jmoJe3IBpbvF6ud9Nol5OPiVPdTCOFkG9pzNpxLrLAkjx7+woBarMdLbFsYfMnYZaKiBZUOp27h8KITDIZcqafrdnZyNlgNg36DHA+ceIQsntghKbQpcMqg8UcraiVOv1i9+QCjZybDxQqaLh6MQ31rJysHAxvHpa7qvl3hVz9VGCu3mLYRDdifs+io81v8GOzFLPQFGW0TGIzlIT686KXzA1dTV/f9StKnNstTH8WWgWIcMPdAmFrrspXT30nANn33P2MLHZUKGWrDRy5AVF6e1jFV7AlLBxHFtZgN9wASeoytq0xtCcW8H9yXiycYZEx4NyEFXOriaqaHWo6iU1Uk3xW4YAGG8CRjEMH53ojDXZMQOyujVj5NN0eGLq0mb311bS3DqdSMqNx+VtlLCHffJD3MGb/JNFMeHXnhqmUGRsByoR5pgebcgiLEywP6/kxxPGVddXMrK1mIHHuHznDECBIalhOSlBQhokx/Lg+iK0efgwKYnJbe7P0M/TkDODLWnut/mHkEY/hJhodwuIzOJwBiKHDi2FvRm3+MMadp3P2xfYmDjHIfbO6grXBQM/A0LPjniGNdi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ouzo43kgJNaBHJUCTe4NU/sTg6JnDIh/XY0SmrH7gKPjCLnt8fhrdC0BdxrQy1sxbte8vVFn6UyVDJtPpT2ucaggYpZrtSPRYqJqnyHvTFFTYxONiOsvJ2H26a39xWAQ+3OyuBjM1YkNDHi3JHu1pqogKr/nAiAGhFyZUJQso94/FMl4iQC4+xSES//Lkdv5b3urA+i/4pALoSlLVcfQPOKdCsQAB32p26PHlyqbcIcAQ7sECUWVFw+DldaP/ER5FJYROoS/UnXQfR5Q2a6/xXTP8XhOzEA4QQTG5Pq5kP9nfWmnAl34NHCfB++pcK0pM5pXna9fA6UOxYxZyucKVkPwOvmZ+ynaVVf5B44Wq8Nlj8CchYXmCEItrwWpw6r7vn2gmiyR6qVWf8JQqR6ZM9OIEshY8cR1Hcj1FYxl6XcUWbNZVqtTwjVJqZufT4fc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:42:33.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0620b8ec-804e-462d-c910-08def2bcbaf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

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

