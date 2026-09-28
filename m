Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246E488757;
	Mon, 28 Sep 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586772; cv=none; b=gjuo8SBzR+hqdsSI2D7j+9LjVU4bcOLB3ENpakjHmrVdX1eHcAfkUMQckQ+WMnLdE9pR8zBGdfI1eUZGdyEh3Q9K2DKu+arxRqkzWplgLsKs7i5cSjC0kDaQpRO/yivKgYRl2nRxgpHRGaYQZVBo50WzQLe2ORpLlNpiwQ1+lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586772; c=relaxed/simple;
	bh=rpXoGQtt2CZeKY+gCBH1uYhn5b3rmPJ9pE3fsTPOehE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYc6MyBrHXP4IX4Ni3mzaFk+ucNxUu75dHRi3jas2gnPMtGrTF65Z8QSBDa/+4EGnRAjVXM8tbs8+XIsDzT6u0M5OIsSE3m4THLwv06yP2DWuc4FilwtxYBQLeJuk9GDId/K2dX3UUDuOLV71ip8WQKIWorKLcbzPYS+M4nuI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+/dnBVH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+/dnBVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586771; x=1822122771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpXoGQtt2CZeKY+gCBH1uYhn5b3rmPJ9pE3fsTPOehE=;
  b=S+/dnBVHhs5vPzFZ6f/CHqu29hwuEzJ6DgudTeWfsISgQJlxGgIvF1pV
   Vtf8lja4ly9JGdH0pDsijpNzuzzKmz4vrdq8zc9sJkYjTmEmmxrCSaj+a
   dB1h998cYgtENBYYXfkbcL8R0Hy/vqkHrHM8EG8YuSd7pQMqL+6u7jb/M
   zprk4tBWKF5sfns1WandyBGtSEkYajsUEj5fSRLxqfaoQNVs7xn3+5cm+
   CMCnpPfY1UZ+f+4c77itYhczupUqqhtU67/pl47JHW8cixAyjjh+8RTWu
   XlvBdy0K9cvzMz72Jb40RO8kg8/DNmwBN2Vk7Dt65cQTlymYjBVqjHx6p
   A==;
X-CSE-ConnectionGUID: cginprvyQQu/mUQJptOhVQ==
X-CSE-MsgGUID: f7oHsR8HTUSLLOp0rjNiHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323555"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323555"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:51 -0700
X-CSE-ConnectionGUID: P6Zhbe/ISy2SsYu5v1RIHg==
X-CSE-MsgGUID: IdAJaIaPQaWAFa3JdsBWdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278819591"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:45 -0700
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
Subject: [PATCH v4 15/17] [GMEM-DEPENDENT] KVM: guest_memfd: Add a pre-zap hook .gmem_prezap()
Date: Mon, 28 Sep 2026 17:12:12 +0800
Message-ID: <20260928091212.15711-1-yan.y.zhao@intel.com>
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

From: Sean Christopherson <seanjc@google.com>

Add a gmem 'pre-zap' hook to allow arch code to take action before a zap,
e.g., for shared<=>private conversion, and just as importantly, to let arch
code reject performing the actual zap, e.g., if the conversion requires new
page tables and KVM hits an OOM situation.

The arch code and hook will be used by TDX to split huge mappings as
necessary to avoid over-zapping PTEs, which for all intents and purposes
corrupts guest data for TDX VMs (memory is wiped when private PTEs are
removed).

The hook is allowed to fail, however, there is no rollback when an error
occurs. Therefore, the hook implementation is expected to be safe without
any rollback on error. For example, in TDX, the hook splits huge mappings
as necessary to avoid over-zapping PTEs. It is safe to leave the preceding
successfully split mappings as-is rather than merging them back.

Currently, the pre-zap hook is invoked before zaps for memory attribute
conversions and punch hole operations. The invocation in punch hole should
be a no-op if the punch hole range is aligned to the huge page size. There
is no need to trigger the pre-zap hook before releasing gmem, as all
mappings will be gone anyway. The pre-zap hook is not invoked in
kvm_gmem_error_folio() to avoid introducing additional failure points, and
since when kvm_gmem_error_folio() is invoked, the VM is about to be killed,
over-zapping is not a concern in that case.

Not-Yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Yan: Renamed to .gmem_prezap(), used attr_filter for private/shared info]
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
- Rebased to gmem in-place conversion v13.
- Renamed .gmem_convert() in [1] to .gmem_prezap() as previously noted in
  [2].
- Added a comment for .gmem_prezap() noting that the hook is allowed to
  fail and must be safe without any rollback in the event of an error.(Yan)

[1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com
[2] https://lore.kernel.org/all/anLrGmbZwgWnNUkp@yzhao56-desk.sh.intel.com
---
 arch/x86/include/asm/kvm-x86-ops.h |  3 ++
 arch/x86/include/asm/kvm_host.h    | 16 ++++++++
 arch/x86/kvm/x86.c                 |  8 ++++
 include/linux/kvm_host.h           |  5 +++
 include/linux/kvm_types.h          |  1 +
 virt/kvm/Kconfig                   |  4 ++
 virt/kvm/guest_memfd.c             | 65 +++++++++++++++++++++++++++++-
 7 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index a2eec24fb326..ada0590b4a1b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -157,6 +157,9 @@ KVM_X86_OP_OPTIONAL(gmem_make_shared)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 #endif
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+KVM_X86_OP_OPTIONAL_RET0(gmem_prezap)
+#endif
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 #endif
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5dd1db64562f..ac1af1a083a6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1744,6 +1744,19 @@ struct kvm_x86_ops {
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
+#endif
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+	/*
+	 * Preparation before gmem triggering MMU zap, e.g., splitting huge
+	 * mappings in S-EPT to prevent over-zapping in TDX.
+	 * Note: Though the preparation is allowed to fail, it must be safe to
+	 * proceed without any rollback when an error occurs. For example, if an
+	 * error occurs while splitting a huge mapping, it is safe to leave the
+	 * preceding successfully split mappings as-is rather than merging them
+	 * back.
+	 */
+	int (*gmem_prezap)(struct kvm *kvm, gfn_t start, gfn_t end,
+			   enum kvm_gfn_range_filter attr_filter);
 #endif
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 };
@@ -1866,6 +1879,9 @@ enum kvm_intr_type {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 #define kvm_arch_has_gmem_convert() (!!kvm_x86_ops.gmem_make_private)
 #endif
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+#define kvm_arch_has_gmem_prezap() (!!kvm_x86_ops.gmem_prezap)
+#endif
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 578d624aea28..f28549b3ae73 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10667,6 +10667,14 @@ void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range
 	kvm_x86_call(gmem_invalidate_range)(kvm, range);
 }
 #endif
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+int kvm_arch_gmem_prezap(struct kvm *kvm, gfn_t start, gfn_t end,
+			 enum kvm_gfn_range_filter attr_filter)
+{
+	return kvm_x86_call(gmem_prezap)(kvm, start, end, attr_filter);
+}
+#endif
 #endif
 
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 284fc7d68c60..1debafa18d77 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2622,6 +2622,11 @@ void kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 #define kvm_arch_has_gmem_convert() false
 #endif
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+int kvm_arch_gmem_prezap(struct kvm *kvm, gfn_t start, gfn_t end,
+			 enum kvm_gfn_range_filter attr_filter);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
 /**
  * kvm_gmem_populate() - Populate/prepare a GPA range with guest data
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..edd19584a3a1 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -49,6 +49,7 @@ struct kvm_vcpu_init;
 struct kvm_memslots;
 
 enum kvm_mr_change;
+enum kvm_gfn_range_filter;
 
 /*
  * Address types:
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index a0678ef8ee3f..564ea066ed1f 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -116,6 +116,10 @@ config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_GUEST_MEMFD
 
+config HAVE_KVM_ARCH_GMEM_PREZAP
+       bool
+       depends on KVM_GUEST_MEMFD
+
 config HAVE_KVM_ARCH_GMEM_POPULATE
        bool
        depends on KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 60417008b21e..0b49c2215183 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -217,6 +217,53 @@ static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inod
 	return KVM_FILTER_PRIVATE;
 }
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP
+static int __kvm_gmem_prezap(struct gmem_file *f, pgoff_t start, pgoff_t end,
+			     enum kvm_gfn_range_filter filter)
+{
+	struct kvm_memory_slot *slot;
+	unsigned long index;
+	int r;
+
+	/*
+	 * Since kvm_arch_gmem_prezap() internally holds mutex, no need to hold
+	 * mmu_lock here. Let kvm_arch_gmem_prezap() acquire mmu_lock by itself.
+	 */
+	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
+		r = kvm_arch_gmem_prezap(f->kvm,
+					 kvm_gmem_get_start_gfn(slot, start),
+					 kvm_gmem_get_end_gfn(slot, end),
+					 filter);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+
+static int kvm_gmem_prezap(struct inode *inode, pgoff_t start, pgoff_t end,
+			   enum kvm_gfn_range_filter filter)
+{
+	struct gmem_file *f;
+	int r;
+
+	if (!kvm_arch_has_gmem_prezap())
+		return 0;
+
+	kvm_gmem_for_each_file(f, inode) {
+		r = __kvm_gmem_prezap(f, start, end, filter);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+#else
+static int kvm_gmem_prezap(struct inode *inode, pgoff_t start, pgoff_t end,
+			   enum kvm_gfn_range_filter filter)
+{
+	return 0;
+}
+#endif
+
 static void __kvm_gmem_zap(struct gmem_file *f, pgoff_t start, pgoff_t end,
 			   enum kvm_gfn_range_filter attr_filter)
 {
@@ -326,6 +373,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	pgoff_t start = offset >> PAGE_SHIFT;
 	pgoff_t end = (offset + len) >> PAGE_SHIFT;
 	struct gmem_inode *gi = GMEM_I(inode);
+	int r = 0;
 
 	/*
 	 * gi->page_order is 0 by default and is set to PMD order only when the
@@ -342,15 +390,20 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	filemap_invalidate_lock(inode->i_mapping);
 
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+	r = kvm_gmem_prezap(inode, start, end, filter);
+	if (r)
+		goto out;
+
 	kvm_gmem_zap(inode, start, end, filter);
 
 	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
 
+out:
 	kvm_gmem_invalidate_end(inode, start, end);
 
 	filemap_invalidate_unlock(inode->i_mapping);
 
-	return 0;
+	return r;
 }
 
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
@@ -497,6 +550,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
 	__kvm_gmem_invalidate_start(f, 0, -1ul, filter);
+
+	/* No need to prezap since all mappings will be gone */
 	__kvm_gmem_zap(f, 0, -1ul, filter);
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
@@ -824,6 +879,14 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
 	kvm_gmem_invalidate_start(inode, start, end, filter);
+	r = kvm_gmem_prezap(inode, start, end, filter);
+	if (r) {
+		*err_index = start;
+		mas_destroy(&mas);
+		kvm_gmem_invalidate_end(inode, start, end);
+		goto out;
+	}
+
 	kvm_gmem_zap(inode, start, end, filter);
 
 	if (!to_private && kvm_arch_has_gmem_convert())
-- 
2.43.2

