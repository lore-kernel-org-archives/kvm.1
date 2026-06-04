Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E93905EB;
	Thu,  4 Jun 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540194; cv=none; b=OK+rp1DwJgswKHQe/1ijiGR69OxcW9dgZZesA2kGHvEhqOR95qVKbXjOqSMhgpew141xcmq3NIsjTgz2E6FYbDWzUvNWgImeVXoc6SffFsbpPW99bCkAEqmiacppH8r/H6mL6FSKxkNY0omNbbc3U6FAEegh5EloSyF4yEwU3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540194; c=relaxed/simple;
	bh=pYl6liv+2TMJ+8mh4MCfBv7ITSiH+H9Y0E6l4W2nMww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfevAGPz8Cn4v+dI38DwUZtXSHIipa/6sAXgeKMuug4WrQALEywZWPBLvyVDw9RUN1+UwfHgkxRdtscKXA8SbyPDW62xXSYdsJy3DY0dj4Sk9012LqiBQVI3JPX18IgNH7i+6P2VHnfoxUFt1snGfy19kmDxTEe0kgbfhzGlN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7xcTr1V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7xcTr1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540193; x=1812076193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYl6liv+2TMJ+8mh4MCfBv7ITSiH+H9Y0E6l4W2nMww=;
  b=G7xcTr1VunZyOSi6kj+1BeoBDTeIsEoz3J81b18ZDt/KffccWnOCLfB4
   tF7HrxgLQLnz4ZI9j5gZgwi0pHsxTkftrrryPMhwmMw+wpI8t6xL8+/wK
   RexAV3B0+KidWYgis28mu64/dZXXnQgHp7Wg5wXeotehuw/RfjYklT4xe
   yWxpvirKbohj7Z7+l4Y2BUODAMYii7koUY+3mAIBFHkbP6zgWMsVYSoel
   0KTQU30Ndn0gPgNNZZqO/x1E4b7biwRlLlCs5kTVczLrwSLARqgaXxcPT
   Nlgo+p20dgt/1z5+aPEnjj6ITcVWUdAmNrb7nW7c7w+PKNj6W+cCMSVGN
   A==;
X-CSE-ConnectionGUID: OAJYiaRISPKcWYVjvn6dRQ==
X-CSE-MsgGUID: B9q47kFkQ8GTABRmgnvJpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045256"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045256"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:53 -0700
X-CSE-ConnectionGUID: hP8yUHYXQy6HJ5ViOVE0uw==
X-CSE-MsgGUID: LmwZ6O+OSpWo/XTYXSMdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239940510"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:50 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as supported
Date: Thu,  4 Jun 2026 10:33:14 +0800
Message-ID: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to the TDX configurable
CPUID allowlist to accommodate legacy TDX module behavior.

KVM doesn't support MSR_IA32_CORE_CAPS, however, some older TDX specs
define CORE_CAPABILITIES CPUID bit as fixed-1.  As a result, userspace
may expect this bit to be enabled in the TDX module for TDs.  When the
CPUID bit becomes a directly configurable without reporting to the
userspace, it can not be enabled.  To avoid confusing userspace, report
CORE_CAPABILITIES to userspace via KVM_TDX_CAPABILITIES.

Although KVM could determine the real CPUID setting by reading the
metadata via SEAMCALL after KVM_TDX_INIT_VM, doing so is overkill to
cover such a corner case.  If CORE_CAPABILITIES is exposed to a TDX
guest, and the guest reads it, simply return 0.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e44a862c6219..58647bb70708 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -175,7 +175,7 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 		TDX_F(SERIALIZE),
 		TDX_F(TSXLDTRK),
 		/* PCONFIG */
-		/* IA32_CORE_CAPABILITIES */
+		TDX_F(CORE_CAPABILITIES),
 	);
 
 	tdx_cpu_cfg_cap_init(0x7, 1, CPUID_EAX,
@@ -2401,6 +2401,14 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			return 1;
 		msr->data = vcpu->arch.mcg_ext_ctl;
 		return 0;
+	case MSR_IA32_CORE_CAPS:
+		/*
+		 * KVM doesn't support MSR_IA32_CORE_CAPS, however, in some old
+		 * TDX modules, CPUID.0x7.0.EDX[30] is fixed-1. As a workaround,
+		 * just return 0 for this MSR.
+		 */
+		msr->data = 0;
+		return 0;
 	default:
 		if (!tdx_has_emulated_msr(msr->index))
 			return 1;
-- 
2.46.0

