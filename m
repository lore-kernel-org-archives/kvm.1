Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB63B101D;
	Thu,  6 Aug 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979130; cv=none; b=kUlluO1gCIJ+asOu3/L3DERtQ/ylSGpIIQI9aDq0lb4BiQFVb+Y2riPaFj08kL4cQzPhC54U/zKhjLpidAIoPSzdt2AkGDpJGMs22FPRn6K3RTQuN6/0EejX8ychT4dgzUN+KkoIbgk7Id9Kmz0R6WNzFunK1esrkkNCHjB5uUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979130; c=relaxed/simple;
	bh=+RfBcLbFUN/D147MllSCMMdSCWzEhZhyPSzs2MYGYSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNmMjd61wzXKGZKjahBC4ReMYpnGmhkxdw5xT+WNwXNU9QUILgEIRxHGaBJ/zNtRyFkYYLQiaCIOyLx8VrsWHxTm9rFNUN6vWejmg8SqrRBlY9fzUr3Tecb9+aIKUL9rySuBk0IItftvHN4nr/xvXsyn+TP4wTCndXmbdEf6e6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwUzRKKC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwUzRKKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979128; x=1817515128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+RfBcLbFUN/D147MllSCMMdSCWzEhZhyPSzs2MYGYSk=;
  b=BwUzRKKCu41AH884yTuqFjitLZ47QK8HzNW3Y2CUTCn0NbflPLGhA1sa
   Ep2bpFx5TkK1Vgy7ihZ7USbpLl2hkyaPEX0/J+qQQ1iZiIMiRjvfjC8M3
   o9lJS+rU/CCcpoh3/1KACmaTElxfN+Gk+/pw+jbbsWwPBSGc23/DPdxYT
   FyoAJag0v+N+xWnZXUvOnbJN3rKg+KP26iscH5E5czZ/jXOukvbOadJJ0
   OKyvkAb7aqPtrR5vbM34jUr1U57iroLrmKYIHhF8aW7IzLaqA/Pa+6R6v
   OXF3OmlXO1lys6q5f7jSKfhgiX7YBErX30NrfTwRf0App5rrEealytQvM
   Q==;
X-CSE-ConnectionGUID: 9QBGUUy/SMGOQX+xbh4JXA==
X-CSE-MsgGUID: AAO/zvUlQ2CXyml/o2vgbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86594011"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86594011"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:45 -0700
X-CSE-ConnectionGUID: vKvQF3FESPq+xNZNHLGJpg==
X-CSE-MsgGUID: if5boMr+Re+jXBBz1kRseA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804622"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:45 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/7] KVM: x86: Virtualize LASS and advertise support to userspace
Date: Wed,  5 Aug 2026 18:15:34 -0700
Message-ID: <20260806011536.4172258-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
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
to userspace if the deprecated vsyscall=emulate mode is set on the
kernel command line.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v4:
 - Split patch diffs and reworded the commit message
 - Use X86_64_F() instead of F()
---
 arch/x86/kvm/cpuid.c   | 1 +
 arch/x86/kvm/regs.h    | 4 +++-
 arch/x86/kvm/vmx/vmx.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9e9cf6538a96..c4dbd00f5e4e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1029,6 +1029,7 @@ void kvm_initialize_cpu_caps(void)
 		F(SM4),
 		F(AVX_VNNI),
 		F(AVX512_BF16),
+		X86_64_F(LASS),
 		F(CMPCCXADD),
 		F(FZRM),
 		F(FSRS),
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..be8621695c41 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -28,7 +28,7 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
 			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
 			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
-			  | X86_CR4_LAM_SUP | X86_CR4_CET))
+			  | X86_CR4_LAM_SUP | X86_CR4_CET | X86_CR4_LASS))
 
 #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
 
@@ -405,6 +405,8 @@ static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		__reserved_bits |= X86_CR4_PCIDE;       \
 	if (!__cpu_has(__c, X86_FEATURE_LAM))           \
 		__reserved_bits |= X86_CR4_LAM_SUP;     \
+	if (!__cpu_has(__c, X86_FEATURE_LASS))          \
+		__reserved_bits |= X86_CR4_LASS;        \
 	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
 	    !__cpu_has(__c, X86_FEATURE_IBT))           \
 		__reserved_bits |= X86_CR4_CET;         \
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ecd105f35c78..3082195906da 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7885,6 +7885,7 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
 	cr4_fixed1_update(X86_CR4_LAM_SUP,    eax, feature_bit(LAM));
+	cr4_fixed1_update(X86_CR4_LASS,       eax, feature_bit(LASS));
 
 #undef cr4_fixed1_update
 }
-- 
2.43.0

