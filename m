Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940343;
	b=Fdd5dI63ITzgl8g/iL6i+W0EuHeMtwRU8zKfZnmTjlzv0A1bLvucj1ooSkZ1IdANeTXo
	 lwSolC2eI9/T5gskbSQlIR9fXrkttyk/xtKckfmeI9IUJI0qxDVeEK2f12ND5qoWA+0yS
	 mnWFKEnXqJzPtiI+wSXuW+zAPIi+XA88ZoPgHw+KZSnSjz4TOju7YIeqXPUZAVtUQBtW1
	 DT9IbWlYfvlJVDPteaKK4FxhXpj6fch0UyeiKBYqU2RxEvysSzUd9JY3gzGacaI0DOZ7s
	 e9Rs1RrIU5JhnPxjcqEGRaVCCSXrqJm1GamL9RMtkeW+Es3bBdGNmzWtuuxsrAGp66A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940343;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+fyAgE90+XUjR3AYWXkfBpO0uYRnXvYqMdLJBuOAJ/w=;
	b=U6EjQgXpNG9ovDLvEgLlhcXpvZ3B/VtYrwYM/LCh5gCm6KMUosoBLg8gC+e8AqywX96u
	 u2IJysKTQFVk9+6bESCjsqnfk8kHqS+eFsYKAmmLnorEzFy6xmQpL20y8OG+sBEHhTUe7
	 3gRfKf1/IC8pionIFpEt2q0bGiaCCw96H6CKez61S50gyKhSiiwLI02Ep6QrWKzXvxnWd
	 vR0Q1RRVFMuFXU3nUyH1GAzd9hgtsgtPi32sR3Wb82joHNSKJzNWLhJH2AHYEFjZaTAQX
	 aagQkOAUM8fMHld9ezd9izGkTd0ehU/23Q5hijjB9Gr0FMrh7OA8FmDmqKcoek0Xv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AZ6ww5I+;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38B60A2639;
	Tue, 17 Nov 2026 18:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E38B60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AZ6ww5I+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940343; x=1826476343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRquEFh6wNU6C6HaOWS+kOQCyFwbromw1eZng+ePFdU=;
  b=AZ6ww5I+6PdAMsHLAnUKnrec4SALfCuqqOMrboTm7XPUrrhMo2BG6l/l
   rINVUMqJekrhd0cLVBMDjlFTwgzkNiWmHPhihKk7vkPgv9PfvFh+L/TH0
   n0h+jBACBxcZoXTfwDoCD70rVpW7CLte24BSGxKILa7khEfEJb0hDsTbB
   O1ioyvT+vwPiAt3q7rgTZRgaVF/rEyHLaDuxeR489qWvI1T0xzPCKGg3t
   qphmgwziOKMjc6Ve+y7UTmwjIVqqnXJyOuFn/2087BnFQSXzFELu3k/sX
   d8X0ZFmI9FtmMbm6H5eJuJRUeB4nxpg5I3TyOUAIVb52fsoNHj2gwRej3
   A==;
X-CSE-ConnectionGUID: NijTAKb3Rna80j6RKPkQZA==
X-CSE-MsgGUID: XFJHOSGmQcCPH2kD0wWfIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607366"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607366"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:31:03 -0800
X-CSE-ConnectionGUID: LqXkvKcDSsWhFvmNwKc9Ag==
X-CSE-MsgGUID: FbQrV++LQn2hN9l2jg6cDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775089"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:04 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 17/20] KVM: x86: Add APX to supported XCR0
Date: Tue, 17 Nov 2026 18:03:07 +0000
Message-ID: <20261117180310.921701-18-chang.seok.bae@intel.com>
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

Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
along with CONFIG_KVM_APX=y, and eVMCS is not in use as eVMCS does not
support APX yet.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V8 -> V9: Tighten up with eVMCS gating [*]

[*] vmx_instr_info_extended() already has this gating from patch10 and
    next patch (patch18) clears APX from KVM capabilities with eVMCS.
---
 arch/x86/kvm/vmx/vmx.c | 4 ++++
 arch/x86/kvm/x86.c     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 032c8988d50c..ce6024a19cb3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8571,6 +8571,10 @@ __init int vmx_hardware_setup(void)
 		kvm_caps.supported_xcr0 &= ~(XFEATURE_MASK_BNDREGS |
 					     XFEATURE_MASK_BNDCSR);
 
+	/* eVMCS isn't prepared yet for APX */
+	if (kvm_is_using_evmcs())
+		kvm_caps.supported_xcr0 &= ~XFEATURE_MASK_APX;
+
 	if (!cpu_has_vmx_vpid() || !cpu_has_vmx_invvpid() ||
 	    !(cpu_has_vmx_invvpid_single() || cpu_has_vmx_invvpid_global()))
 		enable_vpid = 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71378e02ee0f..a58b67810a4e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7193,6 +7193,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		if (IS_ENABLED(CONFIG_KVM_APX))
+			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-- 
2.53.0

