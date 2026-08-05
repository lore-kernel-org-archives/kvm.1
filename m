Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FD3DDAF6;
	Wed,  5 Aug 2026 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912118; cv=fail; b=G+ejbkxmJYPQzQX8YJ6KMwKFRoRM3kwc3/ypt4QtOZaFSLMKk6+QWdNcrslFf0Spyw0q2o63cxU/oukLPQRl9xupjM5uWMW02yG/sy6/Bq+yIBglcrgaEdnOETTkrhMCRWB8CkS90qdhh7T67rEK0qIxNSh4s+eKRTAY8ZavidA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912118; c=relaxed/simple;
	bh=UrdSd3QSpWnCKVjuxuM9F79TXeGwovan7hpw6KGq9zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BPBKjpfOGBuvWGH9qEMVHaPq5n3tmRj0oJF+wHYfXhB2Y6NFyhzbwOkwts2WEj/iuY6sNHd/voVD+bOnkK2Y6mA+x0IY9c6P2jDwl1+maL+EExs7RBcbBKHKUJwEnh+GjPtnMav3fJXO95Mp14aRetRZI7kGtthYgMmogXzmD8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erOkuVHw; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erOkuVHw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1+4aQYe+5n0LtJXyGMFTZwGph+pxyue62GspVBnTfw5uPwoWx3xv0CFKgR25XaQ691lP5RIAwEJNd7nA6URYgiq1hAo8tm2xgXAjgiDQYbxMqcjRCjBz8kXINNuppz93CarxMhDb1qHnAvgtfp+MUoFlnVDekYeC9w+9ccgLtxqS3QJT3vz/10zaVKR0I2jYjPL0B6RQT0A1EmSYZhRcTHzaU2xWGlPO81jSYqj3/2h1+EVojehVmNFZkgmdLdzdY3vIhyBlRJZJ+mgIM9mIkItNDlWA2JYBzOkYne7iIxT8wzxj+j0bqv+gTCtjqh6z2uvb/sk16WnlMo/MnjZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qFsgzcnV0HezLIHw4Kxk1DEB276/tY/e7dDoGsmaM4=;
 b=mK/FjR6Zeg37eQoDFIN4/tg2AQB/9tmnYucKp0NsBoJ2XcAyQwTLbvIduJLspkwqTo1eABvSCRsg8Up4a6IoMEaEbTAH4TgsPSEwKM/7ftEzeo1uGXCQYBEeRCUP155ioW9YmrV8eu0K9UFOgeQ7Hon3ZOe+lDYlF12AlU+bFeBOgL2pbpSPOmVUABcw4hlNIKpraB8HZMh2AKAcHLxd8YVBLBE2d9lYcv+oDzST7xOYmAcyl8r5v1fgSuvH/tggeuAg5tOdGcrQnq9Eo9Dvf2VsU/Mzjseqcumj55c/Bh6z/wYXb1S5PAR8GRLmRmyXGwrpnHx21gF6b9JrydLWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qFsgzcnV0HezLIHw4Kxk1DEB276/tY/e7dDoGsmaM4=;
 b=erOkuVHwErnnLFOQ3H7v//hxlNCXcxUer2Kc5UE4TbiqXuuOpKExtlxvO8fKuS05XBZN6L3QuBzTcOH52FSXPMwQDyvLaGOZzjckL8N4A2hnEpTm22SwyHhMD30f8rqnNps+5168+2PblU6eQBCgootuWuK4WWc3/fXlJDdx1/8=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 06:41:46 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::1) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:34 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Wed, 5 Aug 2026 06:40:32 +0000
Subject: [PATCH v3 3/9] KVM: guest_memfd: implement folio migration for
 non-confidential VMs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260805-shivank-gmem-migrate-v3-3-00d8bdec4e1d@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785912059; l=2535;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=UrdSd3QSpWnCKVjuxuM9F79TXeGwovan7hpw6KGq9zk=;
 b=QfzT5bgvAo0dPE2y0d+uYNGu85zH9jrWDJNAuliUXU7sDkiF0sdDA3XfOqSoQP3+Fxsux61Nd
 C530F3lq3CPAFIhUHqYQKg4f4Fg8pc71n1AOkogTzpbqHjw/33PF+5x
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2658d4c6-14d7-4d1d-8a05-08def2bc9edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|921020|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	CZFf6bdHY55uSNEr+tB3krxzR1nY2PA2yTT8atAJE/OJ4pxOLKkzpUluynA7MKggKv/0TzI6IHAbAndMoanZprhHV+h5Ud5Zb2ybKcZjLpP3ChjtrDbGdfKHQe+CKxQ6+RvmGqlerSAiRuuy7V5oVhZb7ZO59Z6ZUiJMdK2FVIFhJPHKoZO3pzGpfuHFkEmbfLqfNbqXibZ4mxWTz+EGXd1d2CCBJZdWVYFwagDmTyzR43vPoZlKVJyr+1kHeNN6EhsNUIR29CPMV1rcJfXiGb+Nxz9qkBuc5704EBbIEVUAkHIcI0s7dCXz6wgKU64j3/AUrN/k+Jq9tt334AJ7pYK7ZkwP62wVRY16tLT9xICfHCKZJgcP0rx8tmpZvqtVTsFKI33zQURLUmPd0N2SYxHaTRncVcExQeeHfk6J7egeUYD9FhzX5hHwaY45py24wMu6ww9zuqhRPsJrlfHq8rUb6EJ7J/7Ql851mN3V4WH5FbW4jOmz3JpSUiN2RyI1NZnlupGB1muQTLeg5RDiUZx0MWFrVD0vATyhoq6j9K7odNs28pPIcL0PMrs2eHC9S3My1K/tibUWt+ZyzjuBS11VYhgUEuuCj3lMtv4YP03JFHIJCbDM7tYRRfK6Vwww2N7PCB3hZt6X5/uPoklJXPbQViFVz+9JKFjaFEVT110q1UKXrrpgeRed3h4ALGCgjTwyc/xzptFFjR1KcHDs1oyr5TXQfreHZe0ox1M/Buxzi3MHfMonIRXO9YzArODr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(921020)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nEIVylMk39Rn75qV0NS9PLpyWfwyl7UfhaXn4+ZEk1T3Das5892D5CKzhUp8hbnKTgnkfr4np89E35UydCGvrWGEUkvzfVBh6qr+OYf5lEFuf7rIO9Ym8Cq6zlLCHi6NbO3WUZZfpqa1GaFMGO9aklr7FEXIGbKBHe8EH4giLjpi8s9up9Vg3L3EnKPv7T7BL3sbGz5z8v+xuHIomWgs0Srsk4u1YwBRme/xLACk9TLc7ZJYgvwm2X7jjbqAtn12bzA6kQDsmSs7ZMf0Io4vQo4ckQIOfGMVYt85dMO8a5VtY8wQI28PVTLD8uuBVmW3Oxf08vTh3qpzfQLdbFn4mZ+vIUxCBlU/agsVFtTEGCgj+HtvuyPkjuX3bgHXBi5P8LbZ4pJye7h3aGhNfXzX6TBRjKu8HrBMiZQjy1O7zGuYT5LQ31f2ZdVQ4xFRLkU7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:46.5855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2658d4c6-14d7-4d1d-8a05-08def2bc9edc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

Implement kvm_gmem_migrate_folio() using filemap_migrate_folio() for
non-confidential VMs but don't enable it yet. guest_memfd mappings
are still marked unmovable, so MM never calls it.

MM invokes ->migrate_folio() callback with folios already locked and
acquires the invalidate lock afterwards. kvm_gmem_punch_hole() takes
the invalidate lock before locking folios during truncation, so
taking invalidate lock in migration callback can cause an ABBA-deadlock
situation. Use filemap_invalidate_trylock_shared() to avoid this.

A subsequent patch adds an opt-in flag to change the mapping to
movable and enable migration. Non-confidential VMs can use
host-side copy via folio_mc_copy(), whereas confidential VMs will
require firmware-assisted copying before they can opt in.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 169f75f95433..583341d593c9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -488,13 +488,45 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };
 
+#ifdef CONFIG_MIGRATION
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
 				  enum migrate_mode mode)
 {
-	WARN_ON_ONCE(1);
-	return -EINVAL;
+	struct inode *inode = mapping->host;
+	pgoff_t start, end;
+	int ret;
+
+	/*
+	 * Migration invokes ->migrate_folio() while holding the folio lock.
+	 * Use a non-blocking trylock to avoid inverting the lock order with
+	 * truncation, which takes the invalidate lock before locking the
+	 * folios.
+	 */
+	if (!filemap_invalidate_trylock_shared(mapping))
+		return -EAGAIN;
+
+	start = src->index;
+	end = start + folio_nr_pages(src);
+
+	kvm_gmem_invalidate_start(inode, start, end);
+
+	/*
+	 * For non-confidential guests the folio is host-readable, so
+	 * filemap_migrate_folio() can copy the contents itself via
+	 * folio_mc_copy().
+	 * For confidential guests, this would need firmware assistance.
+	 */
+	ret = filemap_migrate_folio(mapping, dst, src, mode);
+
+	kvm_gmem_invalidate_end(inode, start, end);
+
+	filemap_invalidate_unlock_shared(mapping);
+	return ret;
 }
+#else
+#define kvm_gmem_migrate_folio NULL
+#endif
 
 static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
 {

-- 
2.43.0

