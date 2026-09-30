Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA25335AF;
	Wed, 30 Sep 2026 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804116; cv=none; b=A6iCwDqtSXzn9gkCQeWdB+GPxk/nf7W5IwWMdGVsfFTPwq2wSWZktArTz9sfUxLj+xTBwbGecAlCWuJ2Qbx2ISZkoz232HxY8m306+MoFhsr3FUE+kFdgXPVJ3HS09+xMiSWJgcaNhkqpf+1fAQLTkqpCNSTAqpDcDLdYTVHFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804116; c=relaxed/simple;
	bh=aqp2eCPxYY6kae/5tCGwq82KFshw1+YOgz0Wy3zMwFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFmd20q2w2HWAaayWzheR0Eg82o5rC4cMc5QIlClAxumxNgcVkDbAqkaEAjtjdXUNgx0vNvMUv6h0OkLAkQVT0m1hPWi6LWV8vQ77FzzoOEmqriZkmohiAkP4RR/iY/mmSh0D6b5+0NEziqnAEK6z4f/xJ54Sjh7naQ0wX5ZPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUr6A446; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUr6A446"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804115; x=1822340115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqp2eCPxYY6kae/5tCGwq82KFshw1+YOgz0Wy3zMwFU=;
  b=mUr6A446l+02uZkknsDO2RbhMamNbp8Ge1cPiY0qMbYQZMBfp2nIqnag
   Cr39INT/gqH/keqNyHD5mHmvQTNTvk+peokLN9lb005rRrKHfKYZtSHLa
   WdADfSnROnMca2rZcXlYrxlU1eC4YMswCFyYy8xSkikMlG8j7jSBZoTPe
   q4v6czeKOILRsT9FFwhVRQ4DGKW45qmf86LtF6dLwm5ML2LHtlr9jjN8F
   iaGhaDk/TAEoyvxB07JsKZLQkpN6VqFQo1LMdRcu3I7Dz5UY0ImCOiexs
   DHfKeu2VHST3eOSp0DSbW2Z0uiqfchlpUxX0xIHEu1qfsOyTP+tIWF/k6
   A==;
X-CSE-ConnectionGUID: qZfhnPsLRLywbhwI92NSEg==
X-CSE-MsgGUID: K4jP+gF2Tjy/NndJXyc0kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432720"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:15 -0700
X-CSE-ConnectionGUID: 1Nd6ruGZQMqDGxiQbajpVQ==
X-CSE-MsgGUID: 0Z5N8tKBRKCdL8YLw/wjsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867381"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:14 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 15/20] KVM: x86: Guard valid XCR0.APX settings
Date: Wed, 30 Sep 2026 21:07:45 +0000
Message-ID: <20260930210750.1487547-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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

