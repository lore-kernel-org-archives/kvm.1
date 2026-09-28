Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8B48BD54;
	Mon, 28 Sep 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586759; cv=none; b=DVTEqcNriKpXhjpgTO+hP4O0KSxUNcKFIQ1vqC+5TGTYxjtmiLieInVauPZrwpDIaQjsr/WhBOvKGfCpJBgu0WLT+7h1Kx1YOVgyAbQgRQnAStugawGgUZVAgt3goXoKIlsIaYkppPkzHdidvTEqgMU9mEUEwWQNgPOV1J5aIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586759; c=relaxed/simple;
	bh=v6IsfCBj5NU9m5WC/noYqKIvoCnmCaLGniiaTnzqIOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRUXF9fWkeIXvMtImq6grN31qN49rLb5STGUYdebVsWEs2sujRsmW9L1wXF3RFe9cyQL9K7TiOWjbyaNfg6I61kYBOEk91LJlIPBDQSnqYfLEvdy17ouY7zuT/BtXLqm7sSYyAESlgAO5x5mVaHckqvrtyh1xNT1xjGlszYmV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdy8aQeP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdy8aQeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586758; x=1822122758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6IsfCBj5NU9m5WC/noYqKIvoCnmCaLGniiaTnzqIOk=;
  b=kdy8aQePiTLiq2cfF49SidTfSg5AOrB7Hj9byi1b5C3tmLC0wpOZKBik
   YQiWMmfX2RO5bF2yTTiZDGHS7GgadCh/t0frCAllaK32jjCoEPGrALYHV
   J2kWUP0Tts2YumkugjkpJ1udq0qs3qx9dN4XaO3uIYVW2f+Ru0A9cVPFJ
   lwdRCWDcwRlbQ2Nk3vsm7usQozBBIye573j6Afg5pRAgzLPMKUdFjVNtd
   pOnDiZ3EHnqi48IRPwBV1fM3hAh9hV71kqivHXmohmUtvYcTw0w+8gHjs
   xr9Ov/Mhx7MAZXWgcvpjEWL6tVip2e0uuOvRemdhVAaCd45nDFVB2a4qe
   Q==;
X-CSE-ConnectionGUID: RtZnaNaBQi6BvW+TrunRHg==
X-CSE-MsgGUID: OItQ0v92Rkmnd9zLs+r9/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323537"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323537"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:37 -0700
X-CSE-ConnectionGUID: eeH6BpqTTpSeS4/Hi/WZDg==
X-CSE-MsgGUID: kfalOLR4QNW6e0z/ERbIMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278819549"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:32 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	tabba@google.com,
	ackerleytng@google.com,
	michael.roth@amd.com,
	david@kernel.org,
	vannapurve@google.com,
	sagis@google.com,
	vbabka@suse.cz,
	thomas.lendacky@amd.com,
	nik.borisov@suse.com,
	pgonda@google.com,
	fan.du@intel.com,
	jun.miao@intel.com,
	francescolavra.fl@gmail.com,
	jgross@suse.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	chao.p.peng@intel.com,
	chao.gao@intel.com,
	farrah.chen@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v4 14/17] [GMEM-DEPENDENT] KVM: guest_memfd: Split kvm_gmem_invalidate_start() to start() and zap()
Date: Mon, 28 Sep 2026 17:11:59 +0800
Message-ID: <20260928091159.15695-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260928090729.15468-1-yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the kvm_gmem_invalidate_start() to two parts:
1) kvm_gmem_invalidate_start(): notifies KVM that MMU invalidation starts,
   and updates the invalidate range.
2) kvm_gmem_zap(): triggers the actual zapping of KVM secondary MMU
   mappings.

This prepares adding and invoking a .prezap() hook to guest_memfd.

No functional changes expected.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 virt/kvm/guest_memfd.c | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fea460e5e503..60417008b21e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -217,9 +217,8 @@ static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inod
 	return KVM_FILTER_PRIVATE;
 }
 
-static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
-					pgoff_t end,
-					enum kvm_gfn_range_filter attr_filter)
+static void __kvm_gmem_zap(struct gmem_file *f, pgoff_t start, pgoff_t end,
+			   enum kvm_gfn_range_filter attr_filter)
 {
 	bool flush = false, found_memslot = false;
 	struct kvm_memory_slot *slot;
@@ -239,7 +238,6 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 			found_memslot = true;
 
 			KVM_MMU_LOCK(kvm);
-			kvm_mmu_invalidate_start(kvm);
 		}
 
 		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
@@ -256,6 +254,41 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 		KVM_MMU_UNLOCK(kvm);
 }
 
+static void kvm_gmem_zap(struct inode *inode, pgoff_t start, pgoff_t end,
+			 enum kvm_gfn_range_filter filter)
+{
+	struct gmem_file *f;
+
+	kvm_gmem_for_each_file(f, inode)
+		__kvm_gmem_zap(f, start, end, filter);
+}
+
+static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
+					pgoff_t end,
+					enum kvm_gfn_range_filter attr_filter)
+{
+	bool found_memslot = false;
+	struct kvm_memory_slot *slot;
+	struct kvm *kvm = f->kvm;
+	unsigned long index;
+
+	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+		gfn_t invalidate_start = kvm_gmem_get_start_gfn(slot, start);
+		gfn_t invalidate_end = kvm_gmem_get_end_gfn(slot, end);
+
+		if (!found_memslot) {
+			found_memslot = true;
+
+			KVM_MMU_LOCK(kvm);
+			kvm_mmu_invalidate_start(kvm);
+		}
+		kvm_mmu_invalidate_range_add(kvm, invalidate_start, invalidate_end);
+	}
+
+	if (found_memslot)
+		KVM_MMU_UNLOCK(kvm);
+}
+
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 				      pgoff_t end,
 				      enum kvm_gfn_range_filter filter)
@@ -309,6 +342,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	filemap_invalidate_lock(inode->i_mapping);
 
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+	kvm_gmem_zap(inode, start, end, filter);
 
 	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
 
@@ -392,6 +426,7 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 static int kvm_gmem_release(struct inode *inode, struct file *file)
 {
+	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
 	struct gmem_file *f = file->private_data;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = f->kvm;
@@ -461,8 +496,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * Zap all SPTEs pointed at by this file.  Do not free the backing
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
-	__kvm_gmem_invalidate_start(f, 0, -1ul,
-				    kvm_gmem_get_all_gfns_filter(inode));
+	__kvm_gmem_invalidate_start(f, 0, -1ul, filter);
+	__kvm_gmem_zap(f, 0, -1ul, filter);
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
 	list_del(&f->entry);
@@ -789,6 +824,7 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+	kvm_gmem_zap(inode, start, end, filter);
 
 	if (!to_private && kvm_arch_has_gmem_convert())
 		kvm_gmem_make_shared(inode, start, end);
@@ -890,6 +926,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 
 	filter = kvm_gmem_get_all_gfns_filter(inode);
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+	kvm_gmem_zap(inode, start, end, filter);
 
 	/*
 	 * Do not truncate the range, what action is taken in response to the
-- 
2.43.2

