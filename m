Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF0478859;
	Mon, 20 Jul 2026 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569603; cv=none; b=TsOhtasPLr1NggmatI20icK4kL2tldG48ZL3Lg+5Ed9ncuIb7L0WUqRNPhBsyha9hjCOAhrt8bLzjNUqhPMUSy46uQ8/dzIUC+z5wGOLAFiVWM7NWnU7mRECiE/YwV8S7DxmChTlvIbYG63jSLySdvp5BPGrib7xlStTINjh5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569603; c=relaxed/simple;
	bh=6uCcnulSABEeTlE4lQI/MpQP8kkqc07y5hMWHwPijIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbOlZ6ITPwzHPQ0hreuIeaHR6jESu/bRU4bqQqlzMATdP/ioP5MZtIfJemq7fVmrnPJQWIxIa7HQggBK5X3kY3mBdOCpu6c5Ek43mL7awRdJmb6oBSNvTptKMW6cL0nsv5ly4cwzXpNyv6+R7F2z7we+RjlHr3tmM+XjyhLvroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK0Ug1n2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK0Ug1n2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569597; x=1816105597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uCcnulSABEeTlE4lQI/MpQP8kkqc07y5hMWHwPijIQ=;
  b=kK0Ug1n2Ul21Lj97rHr8LpJDvUBJyMljckeJN94Wl91Fmlw2KPuS1okh
   gOrmyKmQ7xkrb49AVNEW/WQ+JkjTQkaS7WS6duKOC7rCb4vxBi1oe92gM
   ofFNGxqrn4rE4mPHuZTzHVLw4hHgo97zOH2FkkpvKhTa6NrKdlAIOgYml
   FgJgbWMGpAfCRT2CihTVlO1yQ3ES2LE4Qf2z3gnjcIzqDFyXygUQpNpK5
   3XzwUOoHJbfjp+V3oBqkMSyWFeRdLAe+sglRHEUwps2LNGQOkumRGQDHX
   0C64Xh2Eo9V6O2I1xTJZeu6CFf+mwhkOUVUCTP+rQ0Ca/SSdpm8mDPDd0
   A==;
X-CSE-ConnectionGUID: TqCMJLVISoSYXKHMujzk1A==
X-CSE-MsgGUID: UqOFqop7QM+7jphUWEWlLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691700"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691700"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:10 -0700
X-CSE-ConnectionGUID: B/ws+TGVT26LGmaBarRWEA==
X-CSE-MsgGUID: hK7yXLCmReSbD8L3AgyZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575389"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:10 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 15/20] KVM: x86: Guard valid XCR0.APX settings
Date: Mon, 20 Jul 2026 17:19:44 +0000
Message-ID: <20260720171949.498680-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent invalid XCR0.APX configurations in two cases: conflict with MPX
and lack of SVM support.

In the non-compacted XSAVE format, APX and MPX conflict on the same
offset. Although MPX is being deprecated in practice, KVM should
explicitly reject such configurations that set both bits.

At this point, only VMX supports EGPRs. SVM will require corresponding
extensions to handle EGPR indices.

Updating the supported XCR0 mask will be done separately.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/ab3f4937-38f5-4354-8850-bf773c159bbe@redhat.com
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 arch/x86/kvm/x86.c     | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..eb1b2ba1261d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5612,8 +5612,13 @@ static __init int svm_hardware_setup(void)
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * APX introduces EGPRs, which require additional VMCB support.
+	 * Disable APX until the necessary extensions are handled.
+	 */
 	kvm_caps.supported_xcr0 &= ~(XFEATURE_MASK_BNDREGS |
-				     XFEATURE_MASK_BNDCSR);
+				     XFEATURE_MASK_BNDCSR  |
+				     XFEATURE_MASK_APX);
 
 	if (tsc_scaling) {
 		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 84b2dcfcb007..266d7a02855b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -682,6 +682,10 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 	    (!(xcr0 & XFEATURE_MASK_BNDCSR)))
 		return 1;
 
+	/* MPX and APX conflict in the non-compacted XSAVE format */
+	if (xcr0 & XFEATURE_MASK_BNDREGS && xcr0 & XFEATURE_MASK_APX)
+		return 1;
+
 	if (xcr0 & XFEATURE_MASK_AVX512) {
 		if (!(xcr0 & XFEATURE_MASK_YMM))
 			return 1;
-- 
2.53.0

