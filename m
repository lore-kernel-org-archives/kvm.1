Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0955C1CC;
	Thu, 15 Oct 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095727; cv=none; b=AiSfn0WFHP+RYcSL4YeD1LLcoQl22Sskoj1h4jSmhZ4LZOgZDAAtmZikkhlQSnDCWq4ocgNldYZhvyQ/vWcz0KN1vOb40VoJnR4aeQZrvgi0hDlT4RTQ+2gOGQ1tkLwhEmHcbyAkSQZvZRbAUZ9w2B1rmlW8MFWXBrYVsfJCF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095727; c=relaxed/simple;
	bh=FYLCcnpyCZgCtke9hcMbRzLqqcNwkQcjacFto8RrTKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dig4B8psMK7JmJ85CWDwJ/kqify5X9ILi6UVw7DtsGy81Q5yCJh6SmM+w5UiYIZJBkAD9FgGQOuoN8SE2/eZ2q2iNeBuWfh88qzm7gRqsdajRF90cOtyho8xkcn4wTP0L3jMPxkbG1rBaGegd5Xy3oQSrnz58XEkxsXmxh291y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKm7IlRX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKm7IlRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095724; x=1823631724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYLCcnpyCZgCtke9hcMbRzLqqcNwkQcjacFto8RrTKo=;
  b=IKm7IlRXKsHO94yhF8I5KEFhiN+EQXn5A70N6qgEwl+7E31hyNXNyDJH
   4+QOppyv/j+lZc2C9+sias1iRSrNFhkZE7+gaqdDxDGbA4369j0XqMO54
   N6d7Cs+P45E6ucuy1ahqTvOU3Nt6TIi+6sGUFBhQAj06vNt3PZij6Ljrp
   ICAW5ouSqSR64DmsPmN9Nbx480QJR91p0tdbTZM6jdGeISCGPVM/GhWgQ
   D7w7AQtMZqZbr8vP2HMLcLet1bPljeXpmNqtfegD7CdUWDDSVrnYaIN/a
   4w8glQb0C7oilt5yF1k4Vv5DLJx6JwdwECj5Rx9elha0W4OYs3zPbkBRb
   A==;
X-CSE-ConnectionGUID: oLTbJpQ9TLSpBMWMzyfPKw==
X-CSE-MsgGUID: eMJ2hVaET+uqz8AEgD4PeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911128"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:22:01 -0700
X-CSE-ConnectionGUID: ugIUIcZeTDu5BQZXE1elJA==
X-CSE-MsgGUID: 3OG4PUg7Q32MwJKFWRBpMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844495"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:59 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 5/6] KVM: x86: Virtualize LASS and advertise support to userspace
Date: Thu, 15 Oct 2026 13:19:39 -0700
Message-ID: <20261015201940.1655956-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015201940.1655956-1-sohil.mehta@intel.com>
References: <20261015201940.1655956-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Guang <guang.zeng@intel.com>

Virtualize Linear Address Space Separation (LASS) by letting the guest
enable CR4.LASS[bit 27]. Allow the guest to set CR4.LASS only if LASS is
enumerated in the guest's CPUID. Set CR4.LASS in the emulated
IA32_VMX_CR4_FIXED1 MSR so that LASS can be enabled in nested VMX
operation as well.

Keep CR4.LASS KVM-owned instead of making it guest-owned. LASS is
expected to be enabled once per vCPU at boot and rarely toggled at
runtime.

LASS is enumerated by CPUID.(EAX=07H,ECX=1):EAX.LASS[bit 6] and only
works in IA-32e mode. Advertise LASS to userspace on 64-bit kernels and
only when it is supported by the host. Notably, it will not be exposed
to userspace if the deprecated vsyscall=emulate is set on the kernel
command line.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v5:
 - Replaced Binbin's SoB with a Reviewed-by
 - Picked up Tested-by tags

v4:
 - Split patch diffs and reworded the commit message
 - Use X86_64_F() instead of F()
---
 arch/x86/kvm/cpuid.c   | 1 +
 arch/x86/kvm/regs.h    | 4 +++-
 arch/x86/kvm/vmx/vmx.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..3941f5ce9425 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1016,6 +1016,7 @@ void kvm_initialize_cpu_caps(void)
 		F(SM4),
 		F(AVX_VNNI),
 		F(AVX512_BF16),
+		X86_64_F(LASS),
 		F(CMPCCXADD),
 		F(FZRM),
 		F(FSRS),
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..a1ac69ac20f5 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -28,7 +28,7 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
 			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
 			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
-			  | X86_CR4_LAM_SUP | X86_CR4_CET))
+			  | X86_CR4_LAM_SUP | X86_CR4_CET | X86_CR4_LASS))
 
 #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
 
@@ -404,6 +404,8 @@ static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		__reserved_bits |= X86_CR4_PCIDE;       \
 	if (!__cpu_has(__c, X86_FEATURE_LAM))           \
 		__reserved_bits |= X86_CR4_LAM_SUP;     \
+	if (!__cpu_has(__c, X86_FEATURE_LASS))          \
+		__reserved_bits |= X86_CR4_LASS;        \
 	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
 	    !__cpu_has(__c, X86_FEATURE_IBT))           \
 		__reserved_bits |= X86_CR4_CET;         \
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6245de123ec3..273c09f15fa3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7751,6 +7751,7 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
 	cr4_fixed1_update(X86_CR4_LAM_SUP,    eax, feature_bit(LAM));
+	cr4_fixed1_update(X86_CR4_LASS,       eax, feature_bit(LASS));
 
 #undef cr4_fixed1_update
 }
-- 
2.43.0

