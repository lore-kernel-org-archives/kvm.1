Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9A47DFBD;
	Mon, 20 Jul 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569613; cv=none; b=O7SKhzyBJxqVlCiGx2TpsPfzYkI6fbOTG8/nDUT0Svshj+14MKHzdlV8ceSF1P89R92EBvUPKH7p66DpzTbK2JSFb7phFJV+UDt/az1ov+wG6baaNFCTdtNfSomVUTVy5a2uvlTGN0UBd28vQIue4akUzNEMcGn5QXtTE0hig3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569613; c=relaxed/simple;
	bh=dWEdx2vtF+kR8c3/Y7QXeQKcBYYo4wB2YJK9sr/AYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuoTkxxiFcDtF5PaN5MA+y/CBgWSI9oKSYXequ8Cl/+luyU11Ikn98rMat022arvMdDPi8Tn7pzifVlzeIPdLA3zuojOAO6gzHjBakIiJygofTn3aZaafFTXNm8JscVrTCjWQrUQKtPjZUBQ5aS4lYyxjCDDZYcSQjtyfoUixMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVJgOPHf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVJgOPHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569605; x=1816105605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWEdx2vtF+kR8c3/Y7QXeQKcBYYo4wB2YJK9sr/AYLs=;
  b=RVJgOPHfoGjQwF5CT8zOvLkDjbjgSKMTUIn1ZHF7DR8BdustucjiDuc4
   liTFFQzap5g43pZiuATliV2IdMXBCwCCo1d5It4iEtVGRgPps16kT+eX1
   Snjt71H17axJxP+nv0FJ4ZWfCx9kyCwdkw+Cw9bNJbh/aLzIlRvk1IVIC
   02idxI1Faec+XmRBXBMSoEB929/yN9qmj7dLmV8CUi9+uAEBH0fqKK6l0
   hxp3s3x9Xk+74Dv9dEMw14Ff35y2ro1NEimbrQoJFzejLbodn7IGsBkZn
   oiBMNzOnB+aGK/S9DYTdmwgZVDQ8/T2XQ2Kkkz/8YY7B/qhcSunRdOPcv
   w==;
X-CSE-ConnectionGUID: +9O7mBf4TCCD1DWSimtXoQ==
X-CSE-MsgGUID: 3TQakZBHRMiFeShzLvWp6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691705"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691705"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:11 -0700
X-CSE-ConnectionGUID: Cavo8xnxTAaJ+xjply297A==
X-CSE-MsgGUID: nBNctmIjQbywpxgjJRvHRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575393"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:11 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 16/20] KVM: x86: Add APX in supported XCR0
Date: Mon, 20 Jul 2026 17:19:45 +0000
Message-ID: <20260720171949.498680-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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
V4 -> V5: Separate out from userspace exposure (Sean)
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 266d7a02855b..48f8a2d69987 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7082,6 +7082,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		if (IS_ENABLED(CONFIG_KVM_APX))
+			kvm_caps.supported_xcr0 |= kvm_host.xcr0 & XFEATURE_MASK_APX;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
-- 
2.53.0

