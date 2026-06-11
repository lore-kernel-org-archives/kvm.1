Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E303F6C50;
	Thu, 11 Jun 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183191; cv=fail; b=Dix3Q7AO7tHt6D4g3zYJQlUNys01KN0iz9TnD2AQkAIbCB9OOqWlY0uNbyhGTfQ7xELA42BJ4jS3umGq3TW7DL0S8Xp/MVZ2BenuNCMvWvgVLk5QiXP7McfDPKUFkOYeYG1+IcWIRPC7CHCH2Hy/xdIBt0N4rL53TN2b7oUUtPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183191; c=relaxed/simple;
	bh=0vEf8TcJYj/jra3f7/gl1PJYMpUia9Tb4gpiYZ1ToPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kz8EffQhNmsO1vZHM4ooiWlOZfM9A4F09KzgVGbnKJ+gmkXU+Fdxp6EERmnP+m8n72y6u8oimWKmErLsMW02JNKMY92flHSU7nBCO+zGqZAMc0SD2AL2a8VOhA7de2GKWDAUx3EVbYz+kzgs/FSAwvyJZd3MfNiCl49rcvK0RIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NXLHaqB2; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NXLHaqB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMnhtHJAbgMOzYMrg8Fld1hyeQDnY7y7P96pnnRPP8QvXIIZ6xkBKVCViO7I0ciCT4lcbMZw7O0JRGlCosXpkWwHiKgF9/xazTyVJiN369Ufs+0B3vW4p21uaGYMbpJoO+N7V5VoGW1bu5IGFGmfQkU+OtEMBeGy6EuPZU8FLpYWjUROSfcV17He9AnlIxaV+La/7yyiFXKeAT4GWk2dINi0RenqRdGSULBOlHuTjxi2e/ttc4Z5dAqDJOTQ8XwagsF+0Awmxk2ZmIFobF+PUNoWsr/dS0zxHGKs+IrjFKEDPln7F+tykQfzHGi1+I5nXmS3BEI+UWmw7QGL0wFVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfbkZXmmFzTTcMljeslZnR+zbaNpTdlfJkd0sm9M0fc=;
 b=OoxVEZ2lNJce2st/IkwgS50fG80eLtyfCLdwxb7jKdUGdaf9NkSi4WoskD7AsIMd35BhLfkYcThUalf+RsBiRDACZbDENtvzSX1cLComFtHk8MiCkwiabu8HcQffrSIcZwfadFzl5plnH19BBXa236f/Wta+rkGQNec/xUIN+kcK2lfzlFLgBl0l/CFClQANSnrL5yfhcsci4EBRhhxUtqWT8lSmKBHZHCwIYLDgDgEzIbquoq1vFukPfFv13nPsa3hYQ2H8+9mo8/6bvgidoGfUXtyTtCxQ5LiGCKHNFnvRHA5R1hdBOpb2bc7Qp/5arSUXN1r4ldT2E52CMnM1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfbkZXmmFzTTcMljeslZnR+zbaNpTdlfJkd0sm9M0fc=;
 b=NXLHaqB2zH1RvLIYPLmbtk5hPWQyUTx8Qgh/zhMN7zfChZpjJXTL6OHRvLudrbPB5199aOpJF05r3rfhWhu5M8wcQk17oSZJznlLPJ3AgrUh6BSa9tU4MElglzq9n6ImPzG60lYbImrdxyVQBxZ+qJBrpqYquld1JdQSA1Kw5M8=
Received: from BY3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:39a::24)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 13:06:25 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8) by BY3PR03CA0019.outlook.office365.com
 (2603:10b6:a03:39a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 13:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 13:06:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 08:06:23 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:06:15 -0700
From: Shivank Garg <shivankg@amd.com>
Date: Thu, 11 Jun 2026 13:05:09 +0000
Subject: [PATCH RFC 2/3] KVM: guest_memfd: support folio migration for
 non-confidential VMs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260611-shivank-gmem-migrate-v1-2-2d266bfc6f95@amd.com>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
In-Reply-To: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
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
	<chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Ackerley Tng <ackerleytng@google.com>, Fuad Tabba
	<tabba@google.com>, Sean Christopherson <seanjc@google.com>, Vishal Annapurve
	<vannapurve@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick
 Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>, Ashish Kalra
	<Ashish.Kalra@amd.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781183157; l=3567;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=0vEf8TcJYj/jra3f7/gl1PJYMpUia9Tb4gpiYZ1ToPU=;
 b=v793qmU10vx9OQOPZ5kJ4GneAizF1RxE+2QmnGpF5lHUGUFQYZC8PT6apxiv10xlnBbjhpCpE
 0hNueh7rmCuAq3sn1Svsd9acaYISnjzvkft1JArWqxZIVQjOTIi0efa
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b52ceb6-4f0a-4452-ca58-08dec7ba3d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ttF8yth1YCBvNdGCvGEocW8V0qFHg9u3xlKhiGoBn6kMBGTroMfOkcOVBmdhcORbRZMzRruQvWnQw2PZiFsVtWXGh5ocJTfJsl6+s4yt8/qPFkQseDcFv0TwnkEcRuAFjGGMUiNRbVHSp41xpY2xNFTVkGfHerRS/BpupjPsqeY9gwDdkHEfFzPmbI1LN1DfwatapY7eGd2URtOBkWeXVX/dOD5n9UMBIZiIAY7JtHd9cLHyQj1yO+Bim3GZEdAMUST5fJxD/4818uaf2q5OfiNGB+60Me+536rNmGGbCGUXkVB9mXXfrv6OD/BVYrw34TpyJe3l4Ft7Y4Fxa6aU/vrgCqI4kxf16pso7Hl5Kk01ZZFf7MQkKPftIX3oJ9+DzTsv8T5SiyzKjQVahReyKIQZrazP0NrsOp+SZCk2hshZCCwImN5Gh2PNmWKmeL8qn8w9QjQayITQePgIRT7U9vwDFX2K5Mr370WJC3GGPIj4trbBkoicCWWHp5pscyuKaKDp3dc+g3EjjpicPRVYRVyx4USZCC852GmeDh4MZtQvcdKV6ChsiB4/PcpiWOOQSGYcRsn2jd0hc+27yH/HhIA2vE+Vk8oiJtfMt9b1NBV9jEBOfqxZiSjHIlkR8jb9nLpekhbRnxunBNvGgsWEvVJ09z1bAosyA7uXJcuAkDbCkGT04cIhIMpTgpH7ieFCUJCChh8qVWBUx92QY/TApXmm7UdWQDTgM5ObxiNgkG9RawaPFbX7XVIauBTnSUFtOkCRHWeIcuQ1I1tg5GIRDEM/WQYq+SavNCAaJpjDcLM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dVn25/scKOpTAiq9Lkr/WkcH/U1GYQz4pMBadKEK0/93zmnadT/JQOYCjIRONe+YWCSlabHyadVEl69+x41VnjdfZcqEyvwjP9o/pdwPB6nLrO+aG4QoTcQStdkf5KP0aTnWBwFpDW32hZuRGPAcOyX5/MAfbdvyUBQwnHO0hosmwtlpqBkpTKX+Z+8ujQxRCz66EVt9CUuxReHkHz2mEmQlI30iWdVC0lL1dgFBvvxXaphGEUFi1h9UkcUk780jAs53cVqigyFHlAqyV/BfXmuOZ5XBcbxXjfeTrN+VP4CkEZfCFPvAqYIgHx8Ow8elcrhYho8SQ+QAgBglfTKzAvT7iV91Yw+QZ0F6W+gKl4xNRHsbnzo4bXc2HGTQgwuW8Lo1tWivQ9P5/0KWwQg7+/xmlP5Tonrw96/mh9cCNu7uGfrAffEdnohCLO+iHrNG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:06:24.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b52ceb6-4f0a-4452-ca58-08dec7ba3d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

guest_memfd folios are currently marked unmmovable, so the kernel
cannot perform NUMA-balancing, memory compaction, etc.
This is unavoidable for confidential VMs (SEV-SNP, TDX),
since memory is encrypted and copying it need firmware assistance.
However, for non-cofidential VMs (like firecracker), we can migrate
the folios.

Mark non-confidential VMs as movable and implement
kvm_gmem_migrate_folio() using filemap_migrate_folio().

This lays the ground work for migrating cofidential guest_memfd
later. Once the firmware-assisted copying support is available,
those VMs can be made movable. The confidential folio content can
be copied separately, and the destination folio can be marked with
FOLIO_CONTENT_COPIED so __migrate_folio() skips the host-side
folio_mc_copy().

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 806a42f0e031a1c7729f53c786316d2502532553..e4470106fc7792f328bce5275419683328c8b4ab 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -487,13 +487,45 @@ static struct file_operations kvm_gmem_fops = {
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
+	if (!filemap_invalidate_trylock_shared(mapping))
+		return -EAGAIN;
+
+	start = src->index;
+	end = start + folio_nr_pages(src);
+
+	kvm_gmem_invalidate_begin(inode, start, end);
+
+	/*
+	 * For non-confidential guest_memfd the folio is host-readable,
+	 * so filemap_migrate_folio() can copy the contents itself via
+	 * folio_mc_copy().
+	 *
+	 * This is also the hook point for confidential VMs (SEV-SNP, TDX) once
+	 * they are made movable: the host cannot copy encrypted/private memory,
+	 * so a firmware-assisted copy would run here.
+	 * Idea: https://lore.kernel.org/r/20260428155043.39251-8-shivankg@amd.com
+	 * Mark the @dst->migrate_info field with FOLIO_CONTENT_COPIED, so
+	 * __migrate_folio() skip folio_mc_copy() for confidential VMs.
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
@@ -592,9 +624,17 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode->i_size = size;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_inaccessible(inode->i_mapping);
-	mapping_set_unmovable(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	/*
+	 * Confidential VMs (SEV-SNP, TDX) bind encryption to the physical
+	 * address and require firmware assisted copy, so their folios cannot
+	 * be migrated yet.
+	 */
+	if (kvm_arch_has_private_mem(kvm)) {
+		mapping_set_unmovable(inode->i_mapping);
+		/* Unmovable mappings are supposed to be marked unevictable as well. */
+		WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+	}
 
 	GMEM_I(inode)->flags = flags;
 

-- 
2.43.0

