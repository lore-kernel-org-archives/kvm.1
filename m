Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457891;
	b=VG0q8J1VmP8tbXVE56oPmY5/bsqRgroUoAYLXkg9K7yR7t6h33ZO5BFFYVF1tWb0TgJ2
	 FMzOmOsktoxY8ezjDjplLTqUZ590zz6eq6DpKcX+4OaScvC/2NpPhyDrlvkwc+zJ96ec1
	 12hja1KMG6HN8/8xZIAx+MGngg/IFc5cRdIFOpBGVj9P8KdUvpI4tLrN1KnbOOxwcmiBX
	 nyPcXlv5ccJ9bBRDY6703/ZeXvpelDNrmtTuk+svun/wXW1rM9Q8B2ofEWrwVyQg1C73q
	 lp2X/HCSEFeAo2/hN5cdujtCn1pGNobE61LeibljbvxOY7TOGpgxkdQw1mBlDy91jxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nyCdt5SC32QZrhVU/I7UF+3eBUcNql3WV/2ZcpOAicw=;
	b=zLyhzEUYQcSJJ91rlZr7DXZI970U9NIh2ppnGdpzg2NrwjZ53LVOCJBMgWQuY1AhkR2H
	 WvckIl9FYVGmP1+EwVg5y9tM1i4ujI9eky+fVAhPlTvi8/KcypNT5e7b/gJ6B6Yw1lBOQ
	 4TiC5FdRXBYenq1TGBbtePzFEgLwYqGKRcZrovpL1u4IDvgflmdsI00HC52Q0R8Ku+ypk
	 6M51zXZNA1/l8ygV+SP7Y4gTJCEJLNLScgo7nuIzNayGaSrGo6RKbfrm85SLOFcSEN2jL
	 CgV4mdtthPW6WWk2bxFFCJjX0e92e3td7yQbLn83FuV6B77nyBVmXBC1l4E9mkQku5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AlNvxcat;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3437606A327;
	Mon, 23 Nov 2026 18:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3437606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AlNvxcat
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457891; x=1826993891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/8VXaUbqp9YzYMDDL9yJosSX66EG8qCXHMWi50Eg3w=;
  b=AlNvxcatx/oKXgl2UrbY0YBhyHWasfGKnjEcdHQ0H34933f4laTMF1mT
   5670vHP/edVnhO+SDzFzIL8tPhTLqq7FBSPDwTtb/I8DNBKHRBcW69thC
   83QxU0RShOpE2gbjHEbG0TGgw7TN1VpoIYu4eQKX5UwufA7/yX7nMj1lV
   Fw55EoHb0n1pb3uv95fXu7H6S6F9GeHNXZxG9jU3UFPYr0VDIb4pvTPzV
   apVBxGkQuTfGbfB4aGWW3qiR5FdR4Jv4KmSuq6q+UurJGJXqVQ32MSrat
   61kMWNDuxUvuw8CTdoqro04T3ZkF7Jt1jDlGXBMR+hYxvrP15R0Jae7XZ
   g==;
X-CSE-ConnectionGUID: Fpwf6biaSuinKeFhc8PrYg==
X-CSE-MsgGUID: Xlpr6T30Sou2eUsO9VeXSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288887"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:34 -0800
X-CSE-ConnectionGUID: pMcv6EwhTq6/Kag0WnH+xA==
X-CSE-MsgGUID: mj1thyxLQL+bHIzUOBsTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241169"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:32 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 16/20] KVM: x86: Guard valid XCR0.APX settings
Date: Mon, 23 Nov 2026 17:37:28 +0000
Message-ID: <20261123173732.1072124-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
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
index 131f18534816..b1d11d07f69c 100644
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

