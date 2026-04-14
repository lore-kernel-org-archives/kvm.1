Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006293033E1;
	Tue, 14 Apr 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132765; cv=none; b=pnrT5c5Xb43MgKTVUw4AT+rwN3gv2XIfIpaNtsoTSBoDIqd2u/NOezPR2VWvwVmq04rN2FSpMXJysCH4DhmQfTWxQfadqZVLi/fW5gy4IferuYLlilE9bycp4HmL/FTceuKb//w7qlulLyVSLYeNyrrC+7mMIv/QtXhYzOrkN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132765; c=relaxed/simple;
	bh=KJbDkychRdVGmMyBO+zTH0ERqsjf79i8oIFYa/qax/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYaL13fTrjMaq1OE7w/WFZ/VR3CT8sxD9/SwZ8PGwGEM0oPp+fxaPgD/Z21zuJ8gcANWQnsXEXxQ3dpjpAPjwMTfaGkwar+jfZuI1/xqQDwiKhvPpgvIBPKA945ANNhcvRo5peuWWjSdBcCMLom7Z9UbkJMiJAQ5gUlfO2+pWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5GoTQ2m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5GoTQ2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776132763; x=1807668763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KJbDkychRdVGmMyBO+zTH0ERqsjf79i8oIFYa/qax/Y=;
  b=C5GoTQ2mwVU9r62QxxUEGtoiMefflxKU40XSARyCJsC7IpNoXzTxt7Bw
   FQw8Ep/zFgywDb+OCy3HLpmlx6EYdG1PI5TJ6gLsF+5i2yP6bFlon7DVg
   BlliOpy8dmwp7RupdBrCLHuVrtxXMTtMtE3JPGlb+9fTX0rKCtC1s7AsP
   Af/+7Tf52eWcQn8K/kJ4JTcY41mnUGXRRVoiZ7JirFNw5W59ZHJ2jSSPS
   DdGj++WuABSQi+Sua+1SF4lN+Klk4c7AZIQzNSqi+7l1HnregJ8yfnQBK
   873nfimXk8AztEkx0ShIBk4nk5cWtSVzCnKJ7r+JJXRj+eetAwhSIPqym
   A==;
X-CSE-ConnectionGUID: neaKg63zQBeSUxjvcJjRvA==
X-CSE-MsgGUID: 3F77PYZ4QyiOqUfqzL5Rag==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76244468"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="76244468"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 19:12:42 -0700
X-CSE-ConnectionGUID: uUD4u3e2RU+pZHihsWHRBQ==
X-CSE-MsgGUID: e75EzWiyRhqQHgIXxSmDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="229891733"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 19:12:40 -0700
Message-ID: <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com>
Date: Tue, 14 Apr 2026 10:12:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
To: "Huang, Kai" <kai.huang@intel.com>, "seanjc@google.com"
 <seanjc@google.com>
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
 <kas@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com>
 <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2026 7:03 AM, Huang, Kai wrote:
>> Because VMX and SVM make all GRPs available immediately, except
>> for RSP, KVM ignores avail/dirty for GPRs.  I.e. "fixing" TDX will just shift the
>> "bugs" elsewhere.
> Just want to understand:
> 
> I thought the fix could be we simply remove the wrong GPRs from the list.
> Not sure how fixing TDX will shift bugs elsewhere?

I'm curious too.

>> More importantly, because the TDX-Module*requires* RCX (the GPR that holds the
>> mask of registers to expose to the VMM) to be hidden on TDVMCALL, KVM*can't*
>> do any kind of meaningful "available" tracking.
>>
> Hmm I think RCX conveys the shared GPRs and VMM can read.  Per "Table 5.323:
> TDH.VP.ENTER Output Operands Format #5 Definition: On TDCALL(TDG.VP.VMCALL)
> Following a TD Entry":
> 
>    RCX   ...
> 	Bit(s) Name         Description
> 
> 	31:0   PARAMS_MASK  Value as passed into TDCALL(TDG.VP.VMCALL) by
> 			    the guest TD: indicates which part of the guest
> 			    TD GPR and XMM state is passed as-is to the
> VMM
> 			    and back. For details, see the description of
> 			    TDG.VP.VMCALL in 5.5.26.
> 
> I think the problem is, as said previously, currently KVM TDX code uses
> KVM's existing infrastructure to emulate MSR, KVM hypercall etc,  but
> TDVMCALL has a different ABI, thus there's a mismatch here.

I once had patch for it internally.

It adds back the available check for GPRs when accessing instead of 
assuming they are always available. For normal VMX and SVM, all the GPRs 
are still always available. But for TDX, only EXIT_INFO_1 and 
EXIT_INFO_2 are always marked available, while others need to be 
explicitly set case by case.

The good thing is it makes TDX safer that KVM won't consume invalid data 
silently for TDX. But it adds additional overhead of checking the 
unnecessary register availability for VMX and SVM case.

-----------------------------&<-------------------------------------
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Tue, 11 Mar 2025 07:13:29 -0400
Subject: [PATCH] KVM: x86: Add available check for GPRs

Since commit de3cd117ed2f ("KVM: x86: Omit caching logic for
always-available GPRs"), KVM doesn't check the availability of GPRs
except RSP and RIP when accessing them, because they are always
available.

However, it's not true when it comes to TDX. The GPRs are not available
after TD vcpu exits actually. And it relies on KVM manually sets the
GPRs value when needed, e.g.

  - setting rax, rbx, rcx, rdx, rsi, for hypercall emulation in
    tdx_emulate_tdvmall();

  - setting rax, rcx and rdx before MSR write emulation;

Add the available check of GPRs read, and WARN_ON_ONCE() when unavailable.
It can help capture the cases of undesired GPRs consumption by TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
  arch/x86/kvm/kvm_cache_regs.h | 60 +++++++++++++++++++----------------
  arch/x86/kvm/vmx/tdx.c        | 25 +++------------
  2 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 8ddb01191d6f..b2fa01ee2b4b 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -16,34 +16,6 @@

  static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));

-#define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
-static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu 
*vcpu)\
-{									      \
-	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
-}									      \
-static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	 
      \
-						unsigned long val)	      \
-{									      \
-	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
-}
-BUILD_KVM_GPR_ACCESSORS(rax, RAX)
-BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
-BUILD_KVM_GPR_ACCESSORS(rcx, RCX)
-BUILD_KVM_GPR_ACCESSORS(rdx, RDX)
-BUILD_KVM_GPR_ACCESSORS(rbp, RBP)
-BUILD_KVM_GPR_ACCESSORS(rsi, RSI)
-BUILD_KVM_GPR_ACCESSORS(rdi, RDI)
-#ifdef CONFIG_X86_64
-BUILD_KVM_GPR_ACCESSORS(r8,  R8)
-BUILD_KVM_GPR_ACCESSORS(r9,  R9)
-BUILD_KVM_GPR_ACCESSORS(r10, R10)
-BUILD_KVM_GPR_ACCESSORS(r11, R11)
-BUILD_KVM_GPR_ACCESSORS(r12, R12)
-BUILD_KVM_GPR_ACCESSORS(r13, R13)
-BUILD_KVM_GPR_ACCESSORS(r14, R14)
-BUILD_KVM_GPR_ACCESSORS(r15, R15)
-#endif
-
  /*
   * Using the register cache from interrupt context is generally not 
allowed, as
   * caching a register and marking it available/dirty can't be done 
atomically,
@@ -92,6 +64,38 @@ static inline void kvm_register_mark_dirty(struct 
kvm_vcpu *vcpu,
  	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
  }

+#define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
+static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu 
*vcpu)\
+{									      \
+	if (WARN_ON_ONCE(!kvm_register_is_available(vcpu, VCPU_REGS_##uname)))\
+		return 0;						      \
+									      \
+	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
+}									      \
+static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	 
      \
+						unsigned long val)	      \
+{									      \
+	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
+	kvm_register_mark_available(vcpu, VCPU_REGS_##uname);	      	      \
+}
+BUILD_KVM_GPR_ACCESSORS(rax, RAX)
+BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
+BUILD_KVM_GPR_ACCESSORS(rcx, RCX)
+BUILD_KVM_GPR_ACCESSORS(rdx, RDX)
+BUILD_KVM_GPR_ACCESSORS(rbp, RBP)
+BUILD_KVM_GPR_ACCESSORS(rsi, RSI)
+BUILD_KVM_GPR_ACCESSORS(rdi, RDI)
+#ifdef CONFIG_X86_64
+BUILD_KVM_GPR_ACCESSORS(r8,  R8)
+BUILD_KVM_GPR_ACCESSORS(r9,  R9)
+BUILD_KVM_GPR_ACCESSORS(r10, R10)
+BUILD_KVM_GPR_ACCESSORS(r11, R11)
+BUILD_KVM_GPR_ACCESSORS(r12, R12)
+BUILD_KVM_GPR_ACCESSORS(r13, R13)
+BUILD_KVM_GPR_ACCESSORS(r14, R14)
+BUILD_KVM_GPR_ACCESSORS(r15, R15)
+#endif
+
  /*
   * kvm_register_test_and_mark_available() is a special snowflake that 
uses an
   * arch bitop directly to avoid the explicit instrumentation that 
comes with
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index cefe6cdd60a9..2b90a60e6f64 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -969,6 +969,9 @@ static __always_inline u32 
tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
  	return exit_reason;
  }

+#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_EXREG_EXIT_INFO_1) | \
+				 BIT_ULL(VCPU_EXREG_EXIT_INFO_2))
+
  static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
  {
  	struct vcpu_tdx *tdx = to_tdx(vcpu);
@@ -985,6 +988,8 @@ static noinstr void tdx_vcpu_enter_exit(struct 
kvm_vcpu *vcpu)
  	tdx->exit_gpa = tdx->vp_enter_args.r8;
  	vt->exit_intr_info = tdx->vp_enter_args.r9;

+	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
+
  	vmx_handle_nmi(vcpu);

  	guest_state_exit_irqoff();
@@ -1017,24 +1022,6 @@ static fastpath_t 
tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
  	return EXIT_FASTPATH_NONE;
  }

-#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_EXREG_EXIT_INFO_1) | \
-				 BIT_ULL(VCPU_EXREG_EXIT_INFO_2) | \
-				 BIT_ULL(VCPU_REGS_RAX) | \
-				 BIT_ULL(VCPU_REGS_RBX) | \
-				 BIT_ULL(VCPU_REGS_RCX) | \
-				 BIT_ULL(VCPU_REGS_RDX) | \
-				 BIT_ULL(VCPU_REGS_RBP) | \
-				 BIT_ULL(VCPU_REGS_RSI) | \
-				 BIT_ULL(VCPU_REGS_RDI) | \
-				 BIT_ULL(VCPU_REGS_R8) | \
-				 BIT_ULL(VCPU_REGS_R9) | \
-				 BIT_ULL(VCPU_REGS_R10) | \
-				 BIT_ULL(VCPU_REGS_R11) | \
-				 BIT_ULL(VCPU_REGS_R12) | \
-				 BIT_ULL(VCPU_REGS_R13) | \
-				 BIT_ULL(VCPU_REGS_R14) | \
-				 BIT_ULL(VCPU_REGS_R15))
-
  static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
  {
  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
@@ -1108,8 +1095,6 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 
run_flags)

  	tdx_load_host_xsave_state(vcpu);

-	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
-
  	if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
  		return EXIT_FASTPATH_NONE;

-- 
2.43.0

