Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD43148D9;
	Wed, 25 Mar 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430564; cv=none; b=OSi6/Bk8zWgi5k4g16RvVDtQSD4oKOxPMT6PPRC1Ny7yzDv5+vmTC7uKK6zA/zIsid/FVrkrsWibwKH5MU7fztHajvcKSsizGhA4SOQhjs9aJ2Onm0BDOkKXqXOpl7XfJKyTYub+P9y+auSFbnovp9dnjGU56vpdwU9p+TPuU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430564; c=relaxed/simple;
	bh=YvJCLeYzS5c4wGvH6ty0BM9THyyLKkk8rn2stjariRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ+S2JFzhEEOeFBQLEJaJw+y/k2lP7rLc5hK68aAAyUfXkLjcljiyPx/E/RI5LmeZegq30xubZ5MNX2Av0kVVMwku4ZbzlSc/ujHlyjmRgLJuN9xe2tjbdMpQYkaBxPR2782J3F9eXJ8WLGl39mUSgVqHoqb4fCa3/pPoyZ0baE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHQyDlun; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHQyDlun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774430564; x=1805966564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YvJCLeYzS5c4wGvH6ty0BM9THyyLKkk8rn2stjariRI=;
  b=GHQyDlun28m3GHinvJO/zSV2aFBWMW+JcR5OtBM7wFZ87px/5SuFiSBE
   3GXLZYLjpi6wT7yWOKnjC/oMIcZKg4DY4mkcaMALpt+/dHaGX+X4nZ+QZ
   IGgPxNikrVklrtmwoXF77jQKYV06OwoYa8+8p8GpylXkLrfJe43Zkk6iS
   AY8oC91oHNxngP9NjZ99FhRE20WYKKflnrmN251tq4nKYeUq+8O7wBXPw
   +32u4gR2y0bKFGtLpMrr7OtEAy/Jg1HRJubc1rpDta9Vh3nIlmn4e0Qk8
   qfrcMC5PXuI11j+qJKjmG8jO6I6NIk3g6pMira7RrAqoMhCK34t2ispuW
   g==;
X-CSE-ConnectionGUID: SKs960Z9Q9eFVHq+HhFtDg==
X-CSE-MsgGUID: 1AxWWB6ERvKGxJ7GG2tHJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75485068"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75485068"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:22:43 -0700
X-CSE-ConnectionGUID: CBHXsM8bQGGn+mPoUgQuJQ==
X-CSE-MsgGUID: yiKoLH6QSgqivBCc9U9b3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223827898"
Received: from scvirtpf.sc.intel.com (HELO pedri.otc) ([10.144.232.27])
  by orviesa010.jf.intel.com with ESMTP; 25 Mar 2026 02:22:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Peter Fang <peter.fang@intel.com>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Date: Wed, 25 Mar 2026 02:15:11 -0700
Message-ID: <20260325092001.613025-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
a gpa. This appears to be a result of the original kvm_vcpu_map() being
declared with the wrong function prototype in kvm_host.h, even though
it was correct in the actual implementation in kvm_main.c.

No actual harm has been done yet as all of the call sites are correctly
passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
this change shouldn't have any functional impact.

Compile-tested on x86 and ppc, which are the current users of these
interfaces.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 include/linux/kvm_host.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..4e3bea92a06b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1382,20 +1382,20 @@ void mark_page_dirty_in_slot(struct kvm *kvm, const struct kvm_memory_slot *mems
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map,
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		   bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
 
-static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, true);
+	return __kvm_vcpu_map(vcpu, gfn, map, true);
 }
 
-static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
+static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gfn_t gfn,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa, map, false);
+	return __kvm_vcpu_map(vcpu, gfn, map, false);
 }
 
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,

base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
-- 
2.52.0

