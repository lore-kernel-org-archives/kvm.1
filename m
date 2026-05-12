Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54445362138;
	Tue, 12 May 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550040; cv=none; b=bHfxafS341SjZqCfhvGAg6NgaHH61ULS+V64NQS+Yd6b9qyzx4p/PxR+GH+hy2FGpEBJsqPT2Xsj0S5hzGRd/pwov3LCMmAHT4yz8nBQmH0zkNJx7OS3vqgeZcRQ2/u31VuEml0CmrHuBbcSkzDcyHPlOrFgRKVK1blOS5vPIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550040; c=relaxed/simple;
	bh=XGCinmsiaPR3O0fki8p/XHJGLGrJzZGZbj5i794FOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXR3yDJvyR/snDDNhUMV8IoOFBqw/Pa40rDoLU5UvPnJMRkVsA35Oa3ub+o3A9+goaxEsA/CBCE3CkQGz8ZphtZ1RcHvdqtPlkFeBzg+9Q8yO9G7IljiCgNU3QP+fO7fsdMR1n6F67s7+YBfgRrCJFxP9L8fWxjPDDQz5SuZLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI+DOido; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI+DOido"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550035; x=1810086035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGCinmsiaPR3O0fki8p/XHJGLGrJzZGZbj5i794FOHg=;
  b=bI+DOidoGo504h8quVvRBKt6Y5vinRjQ7iuy56xM8WR1J9p9ERmbrjUT
   4of3ho5ZiB4GI8z5/rATGaFAdgBIRr5qupaMKYa27EKoYT6o9240FywwV
   C4Wu8w6bg7VOVJmSzEKRfoTbNliWi17yVkzdUcS96qd2Lt9ngciBuOdKt
   UBG0hQZhkHvFGJo6d411BDWbtOJOkyQsHcFvU7bQ7BCi5kA2693JUozoC
   Ay8xBKtADhkC2Myug79Ua6l2s5vYZN37ouelQT+T9pCsNxbRt+U6/4BS0
   XP80/ZRyF5hzqzWOQT/2ZV1LWvuhR8lVEO7AITmr8f4f7kpm9sN2ZrCiQ
   g==;
X-CSE-ConnectionGUID: fQATLBoGRE6nfQYXThZCzw==
X-CSE-MsgGUID: +IgFyrOwQqKSajKT0cGmtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322182"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322182"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:31 -0700
X-CSE-ConnectionGUID: 69oaYYO1RbWzwenvG++f6g==
X-CSE-MsgGUID: y2KZahThQf6cJGDWihgArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572825"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:30 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 17/21] KVM: x86: Guard valid XCR0.APX settings
Date: Tue, 12 May 2026 01:14:58 +0000
Message-ID: <20260512011502.53072-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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

Updating the supported XCR0 mask will be done separately with CPUID
exposure.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/ab3f4937-38f5-4354-8850-bf773c159bbe@redhat.com
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 arch/x86/kvm/x86.c     | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b78dd8805ebb..85d4087ea927 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5573,8 +5573,13 @@ static __init int svm_hardware_setup(void)
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
index 3f029f9272a2..f5f27e7b00b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1291,6 +1291,10 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
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
2.51.0

