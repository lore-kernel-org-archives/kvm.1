Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6D3A8FE8;
	Wed, 29 Jul 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354207; cv=none; b=Bu9B90lK28cuy/L7zidyZt5GpbVuwTYfvauzEXDUnXGhP2ZmUUVq2decvD/OTgtoyoqPPGXbXNR+qu26V9XIm4fm+Cw7GYM9y2ULloEUpvGdYmw+V6QtcCYupGG6lKCP2t4OESSaaGKYPkNbzi3amJtXpniqOJnBGGIQUrj1NwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354207; c=relaxed/simple;
	bh=cPmzi01/ZLhdABcjMjlUHBte7VRdK4w1HW4jeNZEJ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdv61hsTLmYnhVeIHy7avPPa1stNWU5+S7/OmLMyhIODQVCDi0w4APKKtuNOVLdcjGLv5fN/2I57S3BJbKGa+Ej8mjhXL3/gBkhQ0PkrLVKNlnXquzraMCYXOTEPw42pLkMSRVI1xXsq4ekJTv2aVkQpuKWvLhspkCUbmc40IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMPLXXze; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMPLXXze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354203; x=1816890203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPmzi01/ZLhdABcjMjlUHBte7VRdK4w1HW4jeNZEJ0A=;
  b=fMPLXXzetujE6w4XNzrNZzEvOB+aPKg5ibKZtmjBglQbtCieWHo8aQaK
   dMJ7EyQqGNuRWfCvuFeX1AZjWYWPXlWYav6ds2Ivn0stdb462bG6rmoaq
   GPN5nsaUFi+yeWD9Xddxo4e2fiRwpyVVjlsV7GMKq/qSeZu2UOtl3VzyW
   EWM+ZG2JUe9aK2RQinIO3ZjbN7ra6KiGWxZW9pjHvdkWUOuUp/tKQ1yPk
   tXsR21+y8rxmZWbCalCTuMM4eX2yAI8Ibg12qFcyO7wb+ruOXhyuGrEjQ
   c+9jGikcjd826UxI+i5RNcul8vb+9M+GueQJLp1fwT5aQAICbuSGm4AwQ
   Q==;
X-CSE-ConnectionGUID: GSpj1hlKSvmaMQua177vZA==
X-CSE-MsgGUID: zajbRYs/RX2VcERjHz0NNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508234"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:16 -0700
X-CSE-ConnectionGUID: A/mvAu2uTlWDgMbPTVOeLg==
X-CSE-MsgGUID: uKgd6hgxSvCQjh24dllKuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769219"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:16 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 01/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Wed, 29 Jul 2026 19:16:37 +0000
Message-ID: <20260729191656.598771-2-chang.seok.bae@intel.com>
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

Extend the storage to include extended general-purpose registers (EGPRs:
R16-R31) when CONFIG_KVM_APX=y. This option is for VMX only.

Although EGPR state is XSAVE-managed, and thus could be stored in the
guest fpstate, VCPU storage provides a more convenient and efficient
access path for KVM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
 arch/x86/kvm/Kconfig            |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..48547842d9fa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -178,6 +178,24 @@ enum kvm_reg {
 	VCPU_REGS_R13,
 	VCPU_REGS_R14,
 	VCPU_REGS_R15,
+#endif
+#ifdef CONFIG_KVM_APX
+	VCPU_REGS_R16,
+	VCPU_REGS_R17,
+	VCPU_REGS_R18,
+	VCPU_REGS_R19,
+	VCPU_REGS_R20,
+	VCPU_REGS_R21,
+	VCPU_REGS_R22,
+	VCPU_REGS_R23,
+	VCPU_REGS_R24,
+	VCPU_REGS_R25,
+	VCPU_REGS_R26,
+	VCPU_REGS_R27,
+	VCPU_REGS_R28,
+	VCPU_REGS_R29,
+	VCPU_REGS_R30,
+	VCPU_REGS_R31,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..f27e3f2937f0 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -93,10 +93,14 @@ config KVM_SW_PROTECTED_VM
 
 	  If unsure, say "N".
 
+config KVM_APX
+	bool
+
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
 	select X86_FRED if X86_64
+	select KVM_APX if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
-- 
2.53.0

