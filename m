Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C8364049;
	Wed,  2 Sep 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317108; cv=none; b=GkRgTNaQOsstvNMQKCyYTzRdCevad/FgMDK9Zfpjr5Sg0OM9F4j/AZFv3uiMr3PEGPVUrbHMW41DKfqpMmEH4GuhBGBUl9aE/IvLURAOdnXb+lAeg6v18eBmkLZYnNGAwJeFTUtcZEQ21aNYRHR8MRZjBv47IgWn9M/RdRQdX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317108; c=relaxed/simple;
	bh=oo0SZQglIvwBmenoG++AhLmCHt4S3BiOvFD6X4rGYUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzdeUeUR1f/bbLV/gFNw5XQARxHM/PfvQjco8LxHAYzoU6PVC3034/2wkru/lBQBxgMASbSsBIUK80BTVoq1WrCzjeTkpXVkddG6vxKrhrMWhQ31MvxLRY6WxZof4dMLNW7Pk8D0Taw1ssLo5j/TFOwvpgDmHsGNHbe1/qAOaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2xPUVCe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2xPUVCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317106; x=1819853106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oo0SZQglIvwBmenoG++AhLmCHt4S3BiOvFD6X4rGYUA=;
  b=N2xPUVCe62MBb0EcW1zyObDu7yNDM8zYlUJA/J0v1mXIt31PYFlP5KNd
   hHs7MnVbF80dv7UxjRizBWrpCqe+fjulVQm7wwFiC0IOUgzP2gfxwR2G1
   g2nPHgG+KIbWz/mCaiAu3ZFxDuz2cNb0CtlxM4ZyNqWrC/bYCY8JWHddf
   g13ohZmnLxYeoOVuk9a7zP5a8P6/pjCC0BJ+4ReQ5GmBDhvhiDfdkdFqj
   T5lJ9eLdXaZaXKMoh5h5VetHorzyfpRx4EqZNX+VqxyD1cEyAoTS3ir/7
   3+YGcuyEOU6g24FANbD1tFTWE0QRrv9bdelwSPajQ5ggEm91oSCEc4Exx
   A==;
X-CSE-ConnectionGUID: 4y5UTQRnRrSHMmTHknhkrw==
X-CSE-MsgGUID: Y5E2neR5Qgm9CRuyiA6JIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282975"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:45:01 -0700
X-CSE-ConnectionGUID: JUy+XZtIToK8yGSZE8rPvA==
X-CSE-MsgGUID: K0cLTd3fSkmL2jUT5uTzBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775542"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:45:01 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 16/20] KVM: x86: Add APX to supported XCR0
Date: Wed,  2 Sep 2026 02:18:00 +0000
Message-ID: <20260902021804.718676-17-chang.seok.bae@intel.com>
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

Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
along with CONFIG_KVM_APX=y.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 76f70d2631f6..8c6365122efb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7132,6 +7132,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		if (IS_ENABLED(CONFIG_KVM_APX))
+			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-- 
2.53.0

