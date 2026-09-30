Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CED53445B;
	Wed, 30 Sep 2026 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804118; cv=none; b=E9vieTlBdaKOfZq7P24xVJnWct9Ym3lcJ2LlZYgXcsrTLAN1EQNVkIqIQf6kCKxHeondGb/alI2f4a/g5lAyKK61jhpgAFNSeO4T8cr9/vPfGjrvUQWrgDwRpjG/jt4xpDEQFjvAtlE/kLvkeTHqyfHQ9MEc0PVLCzdOxHCSxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804118; c=relaxed/simple;
	bh=0MctO1ayCTT7HaN0dZFykZ6YWqJQJDpX1PP1Kg+ehh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpbV2IECrbn4xWEMloGdFbeZZZOGV1xNDvymphEih1k4glDXgp2ilx0QaQ9tTwzUY6zkunZX0QiuvSLP9ZKYkpq49e+8YQ3Kt7lRpCNCd66CZ/MOpa+FkWI7ccDeUOqLAoqRoeB2ws0QTLek6jQf+WxBZt15vaZLqpVxzMfCuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBVjpsWB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBVjpsWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804116; x=1822340116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MctO1ayCTT7HaN0dZFykZ6YWqJQJDpX1PP1Kg+ehh4=;
  b=kBVjpsWB4OTXCF0CgHAQW1oDQvtooBtwi1E/1HsvsEHD3iiVkJEx3qs9
   RPUOhJnmVQqWjWTpyg5C3c0tGx5yKQHdL7cDDpIkdrDToYkKg/43wjIQ0
   CDgBRquLnu3Pbf7CvCJfG5fr8xJOuv8zJ9sSkMRLe6b8/F1qPUAmwgFxM
   Cw5uxGqQuuSYYTNbyrM958eVJDv5ogbRkDi10+UrI85NyMVJtce3HuAsF
   uBHw6NOJoP33rPMeTV43BwAqRgkqx5VOmS6qPX4HLmkDphgPf7dZqxI+f
   RnxErDbp4+qXx3QCtrP7uVGCs5IGAyNzSR4MRZq3kLjg2arptAz2DVMjQ
   A==;
X-CSE-ConnectionGUID: bjH5XkFbSW++fDC+rgDDkg==
X-CSE-MsgGUID: d9iSUKQxSC6UuWAIm974iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432724"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432724"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:16 -0700
X-CSE-ConnectionGUID: bWtg+CuRRXaE/KyrmtfLxQ==
X-CSE-MsgGUID: OAR2l/YVQOCeYGHDAZ2zpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867390"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:16 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 16/20] KVM: x86: Add APX to supported XCR0
Date: Wed, 30 Sep 2026 21:07:46 +0000
Message-ID: <20260930210750.1487547-17-chang.seok.bae@intel.com>
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

Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
along with CONFIG_KVM_APX=y.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
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

