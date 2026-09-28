Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7A4968F3;
	Mon, 28 Sep 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586788; cv=none; b=U3swsgj1iuYTBPrdEjIliyhEENdZuIeHEH8ZeHem2cHPRrMXbWNXy0rGQeUulGTi3TMvHInvOa8wtYvj3a87LtEweI1DrunJgz+o31IU1tv8BT9GTRiATKb50GZpFxmcSQglhxikKipvYndppw8LqCwFYc9Lm2U7pRotV8vDNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586788; c=relaxed/simple;
	bh=nLjkDQbjdc4gFwPXd1mnrqvY6V/gqlJAueFtd5SJgks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqFlkZhRsIF8B8lNXSeymtrFojuYwQEv9UTv2wbBq8OJNWHpN9kwUFK1U9F+aPRgTE4kavncMGDUW2eA7h+d8eArlZOq11lEUmeKCGvQey5D/DtBV+YPxwTfN8fTpfhZZzCcMeo0RnA6WK/tfE5qk3p9al4e6GZoM2at57WuU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHnNQFc3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHnNQFc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586787; x=1822122787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nLjkDQbjdc4gFwPXd1mnrqvY6V/gqlJAueFtd5SJgks=;
  b=EHnNQFc3hhBSZz+jQoJt2AlKbGwX65gHziaZN3sFpZYQjlQ7UQNHIhRO
   2Oi5B5N8P7FSpSvBeDR5/PX10LJ8m4qwZbkqBkl5DRquzuu8YSfAKjzXk
   NpD3m7QaJqAfgE+Jc/oMNgMVB9ZJ19K3e+WZAI2kpW4mzLQHBNZso/JBE
   cYyZVCIy6VEQchvTsgfxLSO7QPkCdKLYDYsvue4x++TFpECc9ln5eoXAK
   9oMU+Hee9vNfn7yR9ByLWZ/S2Zm3e0F3JS60BVFggK3vjfOIW4OMywlJe
   MFwNQkujZhNsSvsuAMFK36eNU41Fp+46Hc2OqG+gYxHB9EdbadUVBodfJ
   w==;
X-CSE-ConnectionGUID: Crv9tpIXSqKqaEI4uLPcaw==
X-CSE-MsgGUID: gn69zcnlQR2DEd7RpuhEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90333827"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90333827"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:06 -0700
X-CSE-ConnectionGUID: UymRjMy2R0eHQKVNJEzuUg==
X-CSE-MsgGUID: SzjokRVwRbSkWvu5HOc9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279725133"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:00 -0700
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
Subject: [PATCH v4 16/17] [GMEM-DEPENDENT] KVM: TDX: Implement .gmem_prezap() hook to split S-EPT
Date: Mon, 28 Sep 2026 17:12:27 +0800
Message-ID: <20260928091227.15727-1-yan.y.zhao@intel.com>
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

Implement the .gmem_prezap() hook to split S-EPT huge mappings before
guest_memfd zaps S-EPT, in case KVM zaps only a subset of an S-EPT huge
mapping's range. This allows guest_memfd to precisely zap/remove S-EPT
entries to avoid clobbering guest memory, as the lifetime of guest private
memory is tied to the S-EPT. That is, KVM must first split a huge mapping
so that it does not over-zap irrelevant subranges of the huge mapping,
which could cause TD termination.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/Kconfig   |  1 +
 arch/x86/kvm/vmx/tdx.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2c3c22aeafa5..9ac79639dfba 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -147,6 +147,7 @@ config KVM_INTEL_TDX
 	default y
 	depends on INTEL_TDX_HOST
 	select HAVE_KVM_ARCH_GMEM_POPULATE
+	select HAVE_KVM_ARCH_GMEM_PREZAP
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
 	  confidential VMs on Intel processors.
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 5c5919b76bdd..0ecfc17e6235 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2089,8 +2089,7 @@ static int tdx_sept_split_straddling_huge_pages_to_level(struct kvm *kvm, gfn_t
  * per-VM cache of pre-allocated pages used to populate the Dynamic PAMT when
  * splitting S-EPT huge pages.
  */
-static int __maybe_unused tdx_sept_split_huge_pages(struct kvm *kvm, gfn_t start,
-						    gfn_t end)
+static int tdx_sept_split_huge_pages(struct kvm *kvm, gfn_t start, gfn_t end)
 {
 	guard(mutex)(&to_kvm_tdx(kvm)->pamt_cache_lock);
 
@@ -2103,6 +2102,20 @@ static int __maybe_unused tdx_sept_split_huge_pages(struct kvm *kvm, gfn_t start
 	return tdx_sept_split_straddling_huge_pages_to_level(kvm, start, end, PG_LEVEL_4K);
 }
 
+/*
+ * Before zapping private mappings, KVM must first split any huge mappings that
+ * straddle the zapping range, as KVM mustn't overzap private mappings for TDX
+ * guests, i.e. KVM must zap _exactly_ [start, end).
+ */
+static int tdx_gmem_prezap(struct kvm *kvm, gfn_t start, gfn_t end,
+			   enum kvm_gfn_range_filter attr_filter)
+{
+	if (!(attr_filter & KVM_FILTER_PRIVATE) || !kvm_has_mirrored_tdp(kvm))
+		return 0;
+
+	return tdx_sept_split_huge_pages(kvm, start, end);
+}
+
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector)
 {
@@ -3799,6 +3812,7 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
+	vt_x86_ops.gmem_prezap = tdx_gmem_prezap;
 
 	if (tdx_supports_dynamic_pamt(tdx_sysinfo))
 		vt_x86_ops.topup_external_cache = tdx_topup_external_pamt_cache;
-- 
2.43.2

