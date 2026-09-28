Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09B48C8DC;
	Mon, 28 Sep 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586689; cv=none; b=MT1OE6Zpo6b95zyP5yJR7RLWyylh3Q+t/q4HGY9jfgLriuebJkX8jedFbJSRhH6TH9z+iGfvj8BfrPNQEaecnrdN48eeqXpUNmHeowOLdJQuJ3Eav3GSWTc2qz6tZy5/abiB1eaUcR1u51dZZhkXlqMbnnwZ08jlP5fpyKlG4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586689; c=relaxed/simple;
	bh=Emy8agkXxBnpWSZjr/X2QtMOErfNiMKF1lDR0cnFicg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A79Mgg/0j62YjfiuItgEGnDGLq0LVMokYlui8uMsnmjsDciRh2tY8ztuvSG5OQuSyxEFtTURoPDKg/dIJpPGm9mHOMryxw3EgSglhozjKPQjaLSeA/tb08OSKf1Kk5eXkRHGbVvK8+ZhNq9RwuEKY0IqJdKm25ZVduw6TO6zjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9Dqq5GF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9Dqq5GF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586688; x=1822122688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Emy8agkXxBnpWSZjr/X2QtMOErfNiMKF1lDR0cnFicg=;
  b=X9Dqq5GF10L62kqEt3wEvj2mJhc10zujXUVbpdwwYk+hR2rrXPBTJurT
   2Lgxh7JhVhVkomi200u+1znOaaKU3Q/bDDwH0vInqNy/HSZreL96vHL/t
   XfgxQFE1f48QTxgyWaIO4yAxXUrafTXmuqGc64Vtc5ZPRId+C6RBCa3jW
   v6mOPMgbL8LwSs0+mRMmxRQVZg3P0kR/n1j/7poArHQZ/s+u7MyeCDckI
   fRwPcqQTOgGqRFmSKF/jLRTXvRbDA0Hvinyxhak0HagobKVhsUbtqxC4n
   HNR/tqUocENyz+KX2R1H9qm3xcSkYt81T7GzsXU8pJQVFLqQfBydPBhkk
   A==;
X-CSE-ConnectionGUID: d1DhoDNFR1aA+b9JD6bCbQ==
X-CSE-MsgGUID: 3T/jluSvR8+rNRelQ3I5Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323398"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323398"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:27 -0700
X-CSE-ConnectionGUID: FGhIDbikRh2hnpgr9qePRQ==
X-CSE-MsgGUID: BWfncxUXQHCloIXNlHTHiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278819280"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:22 -0700
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
Subject: [PATCH v4 09/17] KVM: x86/mmu: Introduce hugepage_set_guest_inhibit()
Date: Mon, 28 Sep 2026 17:10:49 +0800
Message-ID: <20260928091049.15615-1-yan.y.zhao@intel.com>
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

TDX requires guests to accept S-EPT mappings created by the host KVM. Due
to the current implementation of the TDX module, if a guest accepts a GFN
at a lower level after KVM maps it at a higher level, the TDX module will
emulate an EPT violation VMExit to KVM instead of returning a size mismatch
error to the guest. If KVM fails to perform page splitting in the VMExit
handler, the guest's accept operation will be triggered again upon
re-entering the guest, causing a repeated EPT violation VMExit.

To facilitate passing the guest's accept level information to the KVM MMU
core and to prevent the repeated mapping of a GFN at different levels due
to different accept levels specified by different vCPUs, introduce the
interface hugepage_set_guest_inhibit(). This interface specifies across
vCPUs that mapping at a certain level is inhibited from the guest.

Intentionally don't provide an API to clear KVM_LPAGE_GUEST_INHIBIT_FLAG
for the time being, as detecting that it's ok to (re)install a huge page is
tricky (and costly if KVM wants to be 100% accurate), and KVM doesn't
currently support huge page promotion (only direct installation of
huge pages) for S-EPT.

As a result, the only scenario where clearing the flag would likely allow
KVM to install a huge page is when an entire 2MB / 1GB range is converted
to shared or private.  But if the guest is accepting at 4KB granularity,
odds are good the guest is using the memory for something "special" and
will never convert the entire range to shared (and/or back to private).
Punt that optimization to the future, if it's ever needed.

Unlike hugepage_set/test_mixed(), which are placed under
CONFIG_KVM_VM_MEMORY_ATTRIBUTES since they are unneeded when per-VM memory
attributes is disabled, hugepage_set/test_guest_inhibit() are invoked when
per-gmem memory attributes is enabled, since TDX huge page support is
intentionally enabled only when per-gmem memory attributes is enabled.

Link: https://lore.kernel.org/all/a6ffe23fb97e64109f512fa43e9f6405236ed40a.camel@intel.com [1]
Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
[sean: explain *why* the flag is never cleared]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- Explain *why* the flag is never cleared. (Sean)
- Explain why hugepage_set/test_guest_inhibit() are not placed near to
  hugepage_set/test_mixed().

v3:
- Use EXPORT_SYMBOL_FOR_KVM_INTERNAL().

RFC v2:
- new in RFC v2
---
 arch/x86/kvm/mmu.h     |  4 ++++
 arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..84a96ac94ada 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -410,4 +410,8 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn & kvm_gfn_direct_bits(kvm);
 }
+
+void hugepage_set_guest_inhibit(struct kvm_memory_slot *slot, gfn_t gfn, int level);
+bool hugepage_test_guest_inhibit(struct kvm_memory_slot *slot, gfn_t gfn, int level);
+
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a9a7c015256b..0725b92b7008 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -750,12 +750,14 @@ static bool kvm_gfn_is_lpage_allowed(struct kvm *kvm,
 }
 
 /*
- * The most significant bit in disallow_lpage tracks whether or not memory
- * attributes are mixed, i.e. not identical for all gfns at the current level.
+ * The 2 most significant bits in disallow_lpage track whether or not memory
+ * attributes are mixed, i.e. not identical for all gfns at the current level,
+ * or whether or not guest inhibits the current level of hugepage at the gfn.
  * The lower order bits are used to refcount other cases where a hugepage is
  * disallowed, e.g. if KVM has shadow a page table at the gfn.
  */
-#define KVM_LPAGE_MIXED_FLAG	BIT(31)
+#define KVM_LPAGE_MIXED_FLAG		BIT(31)
+#define KVM_LPAGE_GUEST_INHIBIT_FLAG	BIT(30)
 
 static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 					    gfn_t gfn, int count)
@@ -768,7 +770,8 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 
 		old = linfo->disallow_lpage;
 		linfo->disallow_lpage += count;
-		WARN_ON_ONCE((old ^ linfo->disallow_lpage) & KVM_LPAGE_MIXED_FLAG);
+		WARN_ON_ONCE((old ^ linfo->disallow_lpage) &
+			     (KVM_LPAGE_MIXED_FLAG | KVM_LPAGE_GUEST_INHIBIT_FLAG));
 	}
 }
 
@@ -782,6 +785,18 @@ void kvm_mmu_gfn_allow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn)
 	update_gfn_disallow_lpage_count(slot, gfn, -1);
 }
 
+bool hugepage_test_guest_inhibit(struct kvm_memory_slot *slot, gfn_t gfn, int level)
+{
+	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_GUEST_INHIBIT_FLAG;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(hugepage_test_guest_inhibit);
+
+void hugepage_set_guest_inhibit(struct kvm_memory_slot *slot, gfn_t gfn, int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_GUEST_INHIBIT_FLAG;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(hugepage_set_guest_inhibit);
+
 static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	struct kvm_memslots *slots;
-- 
2.43.2

