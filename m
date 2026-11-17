Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940340;
	b=cC+OJFz/s4tTSE3UNvyYm6WLZMQi7cp4UzsOGxSfcBH2Mq3ogg56IDo2q4RqqC4C96c+
	 LUVJTvr6Ugu16qBTwlZRezn1LA4tPlkirfxpXXivBmn2S77QpxNSSL1G7m+ANvWaku8fZ
	 fTxMWrKT5dJi0/OiS1ccY/q99iwVqmS2XldQkagDDQm3vsebcs0hfQ49MJRs2LG3y3y49
	 ywDtUmwC2z5uspVm92wLnLOiq123buo5+kPt4pQXuFOST2mjw7fnwBeAHtFhgGJ9Exfpr
	 XDI5ZC5zukhMNMU0PdWtWV7TdgMAaxtbof3PCi2/4W/5zEc5lXK+MGhBDKZ9LiGOG5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940340;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/aJ7p/wA8XFoLEF1mZ5bPlhftSKXYwPv0CaANDszNPs=;
	b=Fk1OvQ6tZS/wk0UsBCucEpJYP5e2SzCSaMCZAN+2CtYXgIpzWWte4cpkxRvl914oRzZz
	 oxcmizrhxpE8RUn3pBh9DIKZui8W0mbj4C/JdETENXpODSk4U2GHIRZUap9YZF5f5eRKM
	 iU5OnGnE+fkgiGJyN+L9/bakMkCvfGJDpNB6UNOURukkMwmDmbhIGX96D2FYMX6WKpQH5
	 puchWFnNk+JWctiGWxkqogq5uIB4dFnleYr5OKi/hCbwnw9T5lEP4bwsO9GW1n2+tDm8u
	 kiffrE47gnq9LKxOtwWRhqVxwIr/8XvdUtwdHjAMsOn400nmp9gS53qcfT6UUSKXVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XX5v5o2y;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BC606AEDC;
	Tue, 17 Nov 2026 18:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F3BC606AEDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XX5v5o2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940340; x=1826476340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shMb4h8Pd9oIgprGT0RY2Tt8ETN9oIAb0rjhf9PTQJM=;
  b=XX5v5o2yxFGQLNU0Eaj17g7aeBvkAzNLGWCY8lwxfMLjBEWnYZzGkSPm
   O6f4cFqAfEpPcnjAun3+8xkw5UKpAn3/rIvepoRSOrFgHRPvrE/tx5Nm3
   ds5ed17xiItgl3D1BPlj3ncCVs+e4m8jhGBB6K2K+6pEcRfaWzAHRK7rk
   EfsPjTCUjtxenSoGxXF6TSJH3Q4thsejr2npNsV1pCtCReXnCvBjxBRVr
   Y0BsGFxFTWK/wZsF/hO8g/7XcphM+fgDWmPDqZWPBRJf1t8hT0/rsirt6
   S1/XgDjzijcm2YLPFB/psCMUhL8VdVhAXssh62vRQTbggjzC2hwBnYgCr
   Q==;
X-CSE-ConnectionGUID: MFP03DaoR7apZfm9dpR6/Q==
X-CSE-MsgGUID: SRxjVM2DT3KyAppZtzUodQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607358"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607358"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:31:02 -0800
X-CSE-ConnectionGUID: OyzWdtn0QXy+tLDo7f0LEQ==
X-CSE-MsgGUID: aVQroep5RQ6vK62kblNQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775086"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:02 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 16/20] KVM: x86: Guard valid XCR0.APX settings
Date: Tue, 17 Nov 2026 18:03:06 +0000
Message-ID: <20261117180310.921701-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent invalid XCR0.APX configurations in two cases: conflict with MPX
and lack of SVM support.

In the non-compacted XSAVE format, APX and MPX conflict on the same
offset. Although MPX is being deprecated in practice, KVM should
explicitly reject such configurations that set both bits.

At this point, only VMX supports EGPRs. SVM will require corresponding
extensions to handle EGPR indices.

This is in preparation for APX in KVM's supported XCR0.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/ab3f4937-38f5-4354-8850-bf773c159bbe@redhat.com
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 arch/x86/kvm/x86.c     | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 721dc5e7e13a..5ef785811e3f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5758,8 +5758,13 @@ static __init int svm_hardware_setup(void)
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
 		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c59a5234284f..71378e02ee0f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -711,6 +711,10 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
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

