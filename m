Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D338889B;
	Wed, 29 Jul 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354245; cv=none; b=P9nQxHD4WlSG3vMI1LWEN0eefajO8G2T9lSbZcu25uGazCxvevc5BdAFLSDS5jAQ6WdJ3Dm9nIAOGETr8DniOcZLdmGedmejPseiI9gXX+3OWpk97in/+cHwqL3ey+AiMxRSPQ5vdh+M4wgX0WaGJUuCUeeS0GK4DFdQ1jlm1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354245; c=relaxed/simple;
	bh=6uCcnulSABEeTlE4lQI/MpQP8kkqc07y5hMWHwPijIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmL8ycmtdiypd3jRa/nszGzpY9MEYgXS79YjhnZoRImtp4IGZLa28NLSnYpD2rAbBoAnf4ACd8RRuDJfS+GvtCje1KPzC9pBQqcsGRn8w2ipi+gy+gzPoqvb5oXoMxxE/yA3dsVsGEHgepnu03RuUwqA4kp5f7LxwxG8Ct1gYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0UmnSYr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0UmnSYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354237; x=1816890237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uCcnulSABEeTlE4lQI/MpQP8kkqc07y5hMWHwPijIQ=;
  b=U0UmnSYrFJDoP6kZF6Ha7fhpD+rgN1dTtiRiE2xLlo04zE3urf1jcFz3
   d6GfqZjRY8ycOWjSSzqvEknp65AlL4QrT0iur3sAXqDzFI1Jr00KxtYyW
   zokk9GNo+/2ckHs+nEfVJ5iEvH5Sd5V+Muew/s2qcqFzDYd3TcFZq0Bi1
   hJYJxiEA01Vbtk/t8+4ntpSLgCYQEl8fF49mIURj2ZJQ2Bdnl4c3LfTe1
   pkzfAMcTqx25Q+PIyOanUMFqgHCt+KnAsZ6fIHwJ9qyZ5c1QMyHc14XpS
   A17hDrjcXtQ2DOokZCEcK+b+Ef5uhsNsX38WNv0ZIu083UQsjc1197G1+
   A==;
X-CSE-ConnectionGUID: tn9sNjfwTOOWbYaOs+Uo8Q==
X-CSE-MsgGUID: 60lFi7tYTK+MBuFSJd9uLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508302"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:31 -0700
X-CSE-ConnectionGUID: 3AguvMecTaS6arTjrmJ2aA==
X-CSE-MsgGUID: QJRyvqU/QwiezwMpImHL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769266"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:30 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 15/20] KVM: x86: Guard valid XCR0.APX settings
Date: Wed, 29 Jul 2026 19:16:51 +0000
Message-ID: <20260729191656.598771-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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

