Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AA41B36A;
	Tue, 28 Jul 2026 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229657; cv=fail; b=AFlq4f62QuIWdoJTK9MX5v+DLfbw5K5UEtmGbRs7f0WksquvXRW0icHcbAd3HT6OdjQD4t3dDzOPEzpYdf/eHTUsKQerbmbYy9wzMZGfdVMlnlLyJoynnazLhD9sccl7yoGLiye8JJFg23AjF2wk/z/5qqMLAUoJj1/Tz83V3RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229657; c=relaxed/simple;
	bh=IMSnpRwtnbdmwUY+h0CLbLlpwIbNZFMcsWZgQy8zydw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OIcUfH/p518A+LfRugX1YXxLjvhBssZkXWlIlDtHvg1Bm0UxTVVQ65sbw3Cu29CGaaoXjFYVR8IRLZfvNfsIw9iaBbL8/q1MkCo0KFoKo3SiJSqDdIYJwzV7zfR986M7aN2GUSsZcWxCoKTlNjeLaCBieOrNmZEfgvcP9rQKs5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RJq+5Kei; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RJq+5Kei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+1TYsxvIKz9Spz2zuLmgRyflUnL3pw2sZbTXmnQtqT0YL+6ZysfXmSWHuI+MH5fdjWjfYyPzsvD8Xgz0rhRSjFzBcPxDFfQqvrGrTYzOiXwmmpZhEQ6P0isyeAruwuHMfE1yh5Rh7ka75PX/QaKHfwd5FZxHYt7lq2eZgZpU7U5ddQP5gTdTfySbwwtP0Hi8TXccS+O9WjhijfpOYIy/13UyYu7tyKnlHEd5NU7hw5huEsP9LHI/J6zYmwi/iILkXdLESXZ48tZDM7KFbd7rO25S5NXYymVDq34oK+pDUKU2G7xwz139kGCAxDvK2OQzPZlVcXCcg2f7a9NxAJZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v44GMLyxXjYgJYgtpdi0Tmu8DOg/kdmy60zmupCzOA8=;
 b=Co1144QzAsQCq7a/T8cUbv8nVA+UIhhY3zBTkognCobqG4uL0bZotRWMGK/+8H6Whw+hSJK0ppayVx+FE9fQOxHPB0qKsPdr3PhRuT6yNiqrim0hZcKPDO4YW6Q3ycv/bqPl3oA2fB21GIHc4ia10kIAG817DvXriwMub/7LjZCbRavHt67BnzAWah9KVTEA+HPw2FGOJSLqhlTlXitl2/P6GT24m4gjKqAVSEHoyF/ujpFNBSW+aju5QyZ0pX5uWvou5c9UyxaPZgvesE5WAqUU7F1QXP3m/HBUxXhif4sY12TFaaRmGr+RK1UshNknfoj1jzMHdrnAhg7tJBhlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v44GMLyxXjYgJYgtpdi0Tmu8DOg/kdmy60zmupCzOA8=;
 b=RJq+5KeiwXgor+R7YIxKfcIV9+P/f4IglTUMhiGTqHFSkkG94QpFRamaHnSOQ5mpwdMFckSEg6v65PplzcdilggyuFOj9wtuVFx7ruqdYQt+11BgEhPSqjzilzoBj1BmliUaD8XemB1Dw1iLLcwoBKuiSbbR44t7B3Xc1VMh6Mg=
Received: from MW4PR04CA0291.namprd04.prod.outlook.com (2603:10b6:303:89::26)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 09:07:30 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::32) by MW4PR04CA0291.outlook.office365.com
 (2603:10b6:303:89::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 09:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 09:07:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:07:20 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 28 Jul 2026 09:05:36 +0000
Subject: [PATCH RFC v2 3/4] KVM: guest_memfd: add
 GUEST_MEMFD_FLAG_MIGRATABLE
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260728-shivank-gmem-migrate-v2-3-269ac1f84e2b@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785229610; l=5033;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=IMSnpRwtnbdmwUY+h0CLbLlpwIbNZFMcsWZgQy8zydw=;
 b=9mMce+YlvRkJmDaedQnGK6dE4X6aUZ95dGCWqfT+A6HTFiOzNtWCDw/wNwHVrfFcajmhhXtdL
 aI9CW4Rd0z0CdiM0QFYh7YKiHDxQSk6xNyAU9xU4DAzzlfe8vMv3EmP
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c38adb-02ed-4d3e-dc88-08deec87a771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|23010399003|921020|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fqPqAQouwOP/EMbZBR+JAamTFGeb5ksObjmX/rAiwFuwzkzp+JrrFL92c3WinZpyE6XoEg7M8mrRcFU6Ted2B89is8IOv+MGfxSRPgH9G2MC1g9DwAb2KetMN8U4eDAaLTB7GQwEjcersTkUdlHuwAzeg4Tjy+WdX8Y+YLAXz8k2xODFZDF6zVcS4YMmisqRw0t2xhkY2OBLvmp/3AUsic+8vlMYE5PL79dpQCBTGhtfBNCItKuhqeGlodJIrBGP9vicYjU4meGSF4U8XCdSiRSXSB3rhlGOw2rpx5SrNA2nmn/5/QnnSOA/y4S3v5Fp6sBeUxET17yi5mENCY1cwMM+90xtrgtftHS4h7LuLpEhhi4OTRL0XctUV+5xiMqlZ6fNsnaBSc6+aEkfApoS6Zu95QbR/1NVsC6Rsi0NlX/nUbd2AEnDfDWv8MwDDFth3t2wqczATcRBrR0o0XKfOLCr1fPlPkpG0EAmOyrrgKxRqqoxf18weSZFppSGPC63rXPxLK0DuPrEy9Qk/VdZlReNkH3IAMlgiKOF0yQk39T6Hkdb3RZ1L+bO3WSziQSEm0570RA6rxq0QLlPqFNxb2+eogDGs68WcDPzEzZs5lrJnJLWPwf6wc1/rmocOHNtt2j0QmUEuRGHi9NoHEikk7Tqfc7jL0dbmhbuFIHECstCPbUfZBbSwYyl3FSM9ez9AvzSH1jZq6M3S4S6UdsS1LtEyXVZoq3ng5sAdPXgFKLvj3J3vrdgey1047tlvsYl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(921020)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nRglpX4g5yH0NmkKWZh4pmiow6S7OGntjaxCsr+JcUX3VgZSy4M+fZtYNzJxd6Y0H+F+Hg626JEaIIaVprpCl2htrN8UzW5V5wxhlD2InmoyCWXF/kPqwtxK9k05pXMgu6AHd5fMpqDVatIuU/xHfN6SoxVdY5aDI5vIfz8Gci7uB5TE56Gb9iWWP9hICRcFA6Uo6AZO4ckJMGHcRvJu7ztjnJkt8vE/zo1S/uzonX/n57635hSmalUbdvWCJpCUH47geeyKnz5E5qLNgnONPGqcH97RiaS0cbJlhA1exPxaXRmNex25mumr+JfhMhGl/dIPZuHz+oMn39K/KfQgIaa4pjZrg3qUuhb3WUzqWeZCBtXvNaflWiIBxDkopGakRFoL2VgaBw/A90TN1xmdflDbHuUYH/QkrqKxo35DHwwsRXPrCXO8bbzWBFn907VA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:07:30.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c38adb-02ed-4d3e-dc88-08deec87a771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784

guest_memfd folios are currently always marked unmmovable, which
prevents the MM from invoking ->migrate_folio callback in scenarios
like compaction, offlining, etc. This is unavoidable for confidential VMs
(SEV-SNP, TDX), since memory is encrypted and copying it needs firmware
assistance. However, for non-confidential VMs (like firecracker), we
can still migrate the folios.

Add kvm_arch_supports_gmem_migration() so an architecture can control
whether migration is supported. Add GUEST_MEMFD_FLAG_MIGRATABLE so
userspace can opt-in to folio migration.

For opted-in guest_memfds, use GFP_HIGHUSER_MOVABLE so their folios can
be allocated from ZONE_MOVABLE/CMA and grouped by mobility, otherwise
keep the existing unmmovable behavior.

Remove redundant WARN_ON_ONCE for checking unevictable mapping.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/kvm/x86.c             |  9 +++++++++
 include/linux/kvm_host.h       |  4 ++++
 include/uapi/linux/kvm.h       |  1 +
 tools/include/uapi/linux/kvm.h |  1 +
 virt/kvm/guest_memfd.c         | 18 ++++++++++++++----
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..4a7016013271 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14124,6 +14124,15 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return !kvm_arch_has_private_mem(kvm);
 }
 
+/*
+ * Migration of guest_memfd with private memory is not supported yet
+ * as this may require architecture-specific handling.
+ */
+bool kvm_arch_supports_gmem_migration(struct kvm *kvm)
+{
+	return !kvm_arch_has_private_mem(kvm);
+}
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..7b2f15b21970 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -731,6 +731,7 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
+bool kvm_arch_supports_gmem_migration(struct kvm *kvm);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 {
@@ -738,6 +739,9 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
 		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+	if (IS_ENABLED(CONFIG_MIGRATION) &&
+	    (!kvm || kvm_arch_supports_gmem_migration(kvm)))
+		flags |= GUEST_MEMFD_FLAG_MIGRATABLE;
 
 	return flags;
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..e1615a62ed78 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1654,6 +1654,7 @@ struct kvm_memory_attributes {
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
+#define GUEST_MEMFD_FLAG_MIGRATABLE	(1ULL << 2)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 419011097fa8..e1615a62ed78 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1654,6 +1654,7 @@ struct kvm_memory_attributes {
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
+#define GUEST_MEMFD_FLAG_MIGRATABLE	(1ULL << 2)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ec881cabe8e3..8ae455a6b38d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -589,6 +589,11 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
+bool __weak kvm_arch_supports_gmem_migration(struct kvm *kvm)
+{
+	return false;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
@@ -623,11 +628,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	inode->i_mapping->a_ops = &kvm_gmem_aops;
 	inode->i_mode |= S_IFREG;
 	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_inaccessible(inode->i_mapping);
-	mapping_set_unmovable(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+	/* guest_memfd mappings should be marked unevictable. */
+	mapping_set_unevictable(inode->i_mapping);
+
+	if (flags & GUEST_MEMFD_FLAG_MIGRATABLE) {
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER_MOVABLE);
+	} else {
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+		mapping_set_unmovable(inode->i_mapping);
+	}
 
 	GMEM_I(inode)->flags = flags;
 

-- 
2.43.0

