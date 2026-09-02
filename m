Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E853345ED7;
	Wed,  2 Sep 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317107; cv=none; b=m9dyanuG+qzGeSASq+YxHFNh9/FcAaWZpxLIVjnCnQXN9m1oaD/1rFP4U7xocpU68qyvDp7FIDt05Mla19VZz8t9EvvaV99GXKZe3nf3A1YW/I09uAX6Nqm35ZvQ/UHTIF16gdzNPH0OUenzHJPePUl1Y8NOsPGp6w8yv8T3IYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317107; c=relaxed/simple;
	bh=aqp2eCPxYY6kae/5tCGwq82KFshw1+YOgz0Wy3zMwFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKBPjr1q6TPftNSro+I4ij9z0vRwcxlIbh2pClCZP4ovg+EITkt3GkzMXSTWsAiIQscL5j/o9hn+/6KPm0vsr0Un3+PJnZwrwg3bkzUDCncjJ7J/GOu8RZ2vKpu58cqUj8rI4jL3cBmI06g2MMLNnJStsm+LHtSrVObH+FPwVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBXCW4Gg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBXCW4Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317105; x=1819853105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqp2eCPxYY6kae/5tCGwq82KFshw1+YOgz0Wy3zMwFU=;
  b=MBXCW4GgqH72XEpmHHvWKqUsOc2LqM8mda5STEke5rPrYRPj8mbQsD/6
   8BQpCEDbPJhi0vnh0QNPwQU3OBr7QstAHgXf9qYbvL/6n1ATav1Soghy+
   vk+4ObrYn87lUp+HIBRhd6xrMC2d1qIjJmQFpmL7Gbv2eN2V4kre+EagT
   /HMLkRUnh97SiGh3nBHTAeSAXIiBU5ECedrRgsntkgHMSPFVjXl4OntYJ
   9Ja7W2B4b76oB5RpZwSTYOh+rEdTuXAShba6BtFefccqypoJMimJoMMFT
   mbEEhhHmEEJtw6V0ZmJaehEOsSEK1IvDNYKZxLiY1nu/xyk2zVOji11KH
   A==;
X-CSE-ConnectionGUID: DrcsrBmOS6OcGuuuq4oaJg==
X-CSE-MsgGUID: oNXtbtABS46cR/39hHmW3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282970"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282970"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:45:00 -0700
X-CSE-ConnectionGUID: TEvYgEn0TQKaMAh/IR/cAQ==
X-CSE-MsgGUID: VL0KmKbKRBS03C2vfFaBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775533"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:45:00 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 15/20] KVM: x86: Guard valid XCR0.APX settings
Date: Wed,  2 Sep 2026 02:17:59 +0000
Message-ID: <20260902021804.718676-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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
index 7d59d301e1e5..2962501c4b67 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5616,8 +5616,13 @@ static __init int svm_hardware_setup(void)
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
index 91666b868ab9..76f70d2631f6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -699,6 +699,10 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
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

