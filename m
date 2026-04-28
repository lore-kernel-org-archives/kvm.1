Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B835B137;
	Tue, 28 Apr 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353998; cv=none; b=Fbt7CVQzRjN1jT3z9WMNR/II0Ksr2AlDaKx0qD8q2heEFY4FipoYsfJyauQDN/W+jaRKrr1WyIh2Y7LOnA+BimQt131OLHMkg8Ph3Hy8JK7bE++6OhtL/EhlTGfRoBlwjI0cRWfdtd0CZPdzzU/5+2iLUe5cveYZqrmZx/qYnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353998; c=relaxed/simple;
	bh=lKMmtvjdL4BPq4MT5dCOj2Yrr1Q1jrgNWqSMvybDPWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUtaX9A21wvQuHT35N6g7KMkHyZNRNiDpX8pi+/cFJwyXqLVVe88e3NTe9/8i216YdkDH/EqwagZ89oPI3Dz3EyQO/y6Wtj02Hy+HhzhClecE2aKbiTyC4daEolQRC8A9C/bjz/qu4NlYJqdkCIJdn2hzE2nxAX2w1XQfakkNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIT/w5Oc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIT/w5Oc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353997; x=1808889997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKMmtvjdL4BPq4MT5dCOj2Yrr1Q1jrgNWqSMvybDPWM=;
  b=NIT/w5OcFHIpsQr0cTeCGFFwqOA1CQ1vBonusAFb5mU5WHDqH00Xa8Ig
   BK6YzFRxpHM2m17ACoifGZARpjG9JncmUyurnM7EGYqBxi9R6D/PPMXWc
   xDrQTPN1DQx+/D0sARb1oObADd0yI/aRtRD447TaX787EvmnOQo9sHqew
   KUJlTHKJKgIDvyV7bWzn7t1HK7Ri+S2U9RKEJAuJDXy8QLuggEZCmz2AZ
   8WXeJIX8//wnjCXlOQ4pUgGCAo4AGNsaJIrI+m4HgZbGpjfxjq6KgrM0d
   TFOpW2JH+uBCjkPJ0tycQrgb8hNsnQzVcG4delO0yuCZKfSRu1uPJY3Oe
   A==;
X-CSE-ConnectionGUID: Lc0NZszpTSyWsznJaWtHuQ==
X-CSE-MsgGUID: +oVVH2CpQ7KUuYXWlsEkGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131740"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131740"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:33 -0700
X-CSE-ConnectionGUID: BxWQ7IbrSH+/48nP5rJeTA==
X-CSE-MsgGUID: kQxsbH89Q7W9bk3kPsrEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130225"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:32 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 16/20] KVM: x86: Guard valid XCR0.APX settings
Date: Tue, 28 Apr 2026 05:01:07 +0000
Message-ID: <20260428050111.39323-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
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

Link: https://lore.kernel.org/ab3f4937-38f5-4354-8850-bf773c159bbe@redhat.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 arch/x86/kvm/x86.c     | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 73febbb24340..080bc2f829d9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5546,8 +5546,13 @@ static __init int svm_hardware_setup(void)
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
index fb77869f0233..b6b2fd877893 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1290,6 +1290,10 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
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

