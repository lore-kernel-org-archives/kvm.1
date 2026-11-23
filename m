Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457891;
	b=174pTZR9tR9UFCvXtuTFMsikAOhgwUI3wIlifwUmZm4Muy5fET8+x7sRLxcAFzfuz2Wt
	 TXkrc0jkFd03Z19YZw78gw9mbVmoAtCeA+CYt8tsbMbdUQTnFvdzTqDC7LSKFI96WWjos
	 IojsjJQSL6hEwGwD3r9YK0nGnmhA39fziplVKXE7TV3un84w6O2s/mDMTqi/X1O19iOXu
	 UYF0tFcSvlniw+Ahp4d4VbNL5L9ZMD59pzW+fb/ExSGn/4pMU9Fs5PzqzRAaYH+8Uzp7I
	 osWP/t6vMmPnJJ3VhdKP+Rybe9mPJ6mkiRvgc4Vz7MPg3aBmFkGyTw51IoRsM/jO6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7AHMhl5x8WOuLtu9FsH21uADnHuh0FQgIBWGDmLTDZQ=;
	b=g+LC3CSuz2TEnuGTKoWrc4WKA6fwh/28HeCESxaqtOuPMlo389k7zdPKGpNbBeLHprFK
	 NsWwkW/qdfsgWuyMvcrYSZpqTtKzIxush12+Mh7oXhoOBk2dBfpT4383x7GT4lk4I2PWm
	 WaxcN9/dmACs++Hlu1+HmDHdjCGsBDfshoqu2Txl+7srWvz8+Mfn3WLac6X1IH31X6I2K
	 gB96HO8XJko03VmupRHYywaB8YnpbEJasUE9++gSLtZ/9RQ95IeE2n3daJQc71WlYFuiA
	 k2by13fU4sG5njaRcuC8f0YQqoP3aUkAALaQkrGbyvKZSjhiF0rypVVvAY+rVNgWTCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GhPFhyE9;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EA606AE12;
	Mon, 23 Nov 2026 18:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0EA606AE12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GhPFhyE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457891; x=1826993891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFfmmVN/bLp4SS1l3G++XeRB114qgSyhY8clCuM1Caw=;
  b=GhPFhyE9kTfrJ6SGPSA0kIu8Q6tnYcO5eHw9J1Q1+XshcDOttsy1ueiD
   beqr60pOKydK1tQY4EyD82dgENt3M4IAYvtV9EuLUxrkkHUHXO53nRLIY
   yFLnbZTtnggQRVGF52GC1mMxNQIOkMzJZjDPY/rBCy+sXVazzbd/F1cfb
   iiKfeimXRCKOfo0wWN2z5PC2LFbI+gVC6yMhuQj0kuOJaNLDemNwJBoq3
   tpdmi+EWOOUZCenN92MDx3xTX0DzyF8mbeunNd5+wStzUIEf+r1iUFCZs
   oly57X+YE1SRq2MYjLTirx2SpL4WTWw4XZbOxWLD2p/cWyncweoi1Se3K
   Q==;
X-CSE-ConnectionGUID: I/jQRVwyRi+GrN10QgY3zA==
X-CSE-MsgGUID: 10Dy8kGyQSOLV+EjzdVRFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288893"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288893"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:34 -0800
X-CSE-ConnectionGUID: xODkiDvvS7eGYOCp6wTtUA==
X-CSE-MsgGUID: dFiv/z7dTrCDMBCII1k//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241172"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:35 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 17/20] KVM: x86: Add APX to supported XCR0
Date: Mon, 23 Nov 2026 17:37:29 +0000
Message-ID: <20261123173732.1072124-18-chang.seok.bae@intel.com>
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

Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
along with CONFIG_KVM_APX=y, and eVMCS is not in use as eVMCS does not
support APX yet.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++++
 arch/x86/kvm/x86.c     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 87a84157a51a..3c1d4629a00c 100644
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
index b1d11d07f69c..5d48f4212431 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7194,6 +7194,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		if (IS_ENABLED(CONFIG_KVM_APX))
+			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-- 
2.53.0

