Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7674848A6;
	Mon, 28 Sep 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586676; cv=none; b=aQaPGx1iiQLZeplKSEZ2AOKDrmxjkVr0uxsjiDJ3RCbjNSgXhvhfbaoQkTAO1VIPGOqbyyUJgELKXZBUgotXWGn1IcrsNVrh/dfby6FaASxs1XIMDWuOD2vmEERofBQMOAoC4AX7i6OEsoGFZvaSQRGflgoudxw2jMS31EnPnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586676; c=relaxed/simple;
	bh=VUj14DSXmUTODfmfQEWnPX2yd1a4ycR6M2uRXIA0/d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inq/MwaY4Pg7WQqn9yO82VUihVLWw1Y/WGAnk9Y9xYymqHqxlEGSDyzubskvRlcvQ3Lf+UhAB64s44s+38Kt0qPUiL5570Zi71NgyR3Dqnqv88Ut91lHcLH1I+kTK55O+yZmV52gEyxdWcDURNOopBT3so6sEYpwrmgZ1VTAsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORWsAzEx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORWsAzEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586674; x=1822122674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUj14DSXmUTODfmfQEWnPX2yd1a4ycR6M2uRXIA0/d8=;
  b=ORWsAzEx8seaCmQmY+5pw8L4Sg8pN+RJBaaa7IywcNIiiCwhqALC5wTf
   ezT7s4yLgEP8Qe94/FnvH0P2DY8lmcuU09hWo8JAKMY/aNR9SJJaI/SFb
   iT6xP4xnZejBf6c/8x6H2sQRUC3TSYGGENLuIIBMHn9/W7fb0L6B4RyD2
   U6RxQbY4G3N8k0pVCAvgx7VxgRMSBgnq/PRcrbuQqId8wILiK/N1OYsDc
   6RQZyZJPIw1C0k7Zg5bUaxT5cIC6drxZvwivkXf474VgQSNM8MO31XkYW
   PyY2+YH7Jh29uTaIWX8svByxi6iJgOdCt34WKu1mnFsO8lj1KJ7S88BUC
   w==;
X-CSE-ConnectionGUID: pZKCGao8Tv6NqALNBmLbtw==
X-CSE-MsgGUID: Bm8Zhs0xTgyKIR/oPIp4vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323370"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:14 -0700
X-CSE-ConnectionGUID: ouH18APYROOpqfuclOXg8w==
X-CSE-MsgGUID: JVi7EctTT065HX6ESSeVqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278819225"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:08 -0700
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
Subject: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page pairs for splitting S-EPT
Date: Mon, 28 Sep 2026 17:10:35 +0800
Message-ID: <20260928091035.15599-1-yan.y.zhao@intel.com>
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

KVM needs to allocate enough DPAMT page pairs in the pamt_cache for
consumption by both page table pages and guest pages. Since the DPAMT page
pair for the S-EPT root page is already allocated during TD initialization,
there is no need to allocate the DPAMT page pair for the S-EPT root page.
Therefore, previously the DPAMT page pairs required equals
"min_nr_spts - 1 + 1".

When splitting S-EPT, min_nr_spts does not include the root SPT. So, limit
the -1 calculation to when min_nr_spts equals root_level, though this will
cause one pair over-allocation in the normal page fault path because
PT64_ROOT_MAX_LEVEL is always passed even when launching a 4-level TD.

Additionally, KVM may need to retry tdh_mem_page_demote() a second time,
causing the DPAMT page pair for the guest private pages to be drawn from
the pamt_cache twice in the worst case. Therefore, add an extra +1 to cover
this worst-case scenario.

The slight over-allocation is acceptable since KVM already pre-allocates
more pages than needed (e.g., when mapping huge pages) in case of the
worst-case scenario.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3186c4808cae..397a308b834c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1630,16 +1630,34 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 
 static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
 {
+	int dpamt_pairs;
+
 	if (WARN_ON_ONCE(!vcpu))
 		return -EIO;
 
+	/* Exclude the root SPT, as its DPAMT page pair is already installed */
+	if (min_nr_spts == vcpu->kvm->arch.mirror_root_level)
+		min_nr_spts -= 1;
+
+	/*
+	 * Each S-EPT page table page + 4KB guest private page needs a pair of
+	 * DPAMT pages.
+	 */
+	dpamt_pairs = min_nr_spts + 1;
+
 	/*
-	 * Minus one page to exclude the root SPT, but plus one page for a
-	 * possible 4KB private mapping.
+	 * After each topup, KVM may invoke DEMOTE at most twice. The first
+	 * DEMOTE invocation draws two pairs of pages from the cache: one for
+	 * the S-EPT page table page and one for the guest private memory.
+	 * Since these pages are not returned to the cache, the second DEMOTE
+	 * invocation still needs to consume one additional pair for the guest
+	 * private memory (the pair for the S-EPT page table page is reused for
+	 * the 2nd invocation). Increase the topup count to account for this
+	 * worst-case scenario.
 	 */
-	min_nr_spts += -1 + 1;
+	dpamt_pairs += 1;
 
-	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
+	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, dpamt_pairs);
 }
 
 static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-- 
2.43.2

