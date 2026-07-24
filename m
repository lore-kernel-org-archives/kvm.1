Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7718335091
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907229; cv=none; b=jaAqwD50U5cdAdKmEAxOMFPsSCpgvQJFYW5itTExi1WSsUyj5t+eRGVgHgQKapSWO2ZscSMNBojPWqLRH5vtLMk8QnD2rrwjnfADmQgcuNhP6/NnYGocnHv0H1KfEM8Po0axP3B8YZTCXZXNwKY/OfQFoKIXZBEp62UDO+7vDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907229; c=relaxed/simple;
	bh=ExGE/Tz8BMlcEAbntt6AlmxIumHrZhwjsIEcy2V5MRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nk9U+a3OWVrSbfaRIaqp8EQoK3PPOAG1qe8t2uQjvdJWfYVkS28PzC8xDfZZHlvheRip4ICErT0Nq3Sd6AGru1st1BIhhlsZk+T0gcCnylON3FNocZaUwVVp6J43QraDLUO+puZzQEpTRFCxE6dga9RtlgibnF4/hDgL0IIiZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uiJ2GbxG; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiJ2GbxG"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so824080b3a.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784907227; x=1785512027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hm4z4Zh7eSOZrfZXnQy1FnY6M/P9c/h4VZu9DS0hqRQ=;
        b=uiJ2GbxGb3rT4W4Ei/x0/E7rmUdhZMOlzPsQ4i01hncMd5j9wghgTjbVFSoNlzYNfu
         1uOHxGCI1kbCTo3kfx3xFnPxpZsG0FNIt+RtcKAVwP/MN9DHR8EfxtolpYi5wkVXw5nX
         UXE8FeWpLsMcyYicb2c1ODzkQ7Fe4FfH9+ujnCrv2SxbI5rlH2npAenSsVIdZLuhRfKn
         LF4U0k/5yMiBycGFl6ozBmlnNEN7zoUFtFh4j30m21rijO8u5ccrrQfUvvLiZtMZC5aT
         cfjh900FW4J/rwuV59PzJyZCXmV5cAoo0iKPfg/rO5Alv754baRoc11EwowinltMYRBg
         wV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907227; x=1785512027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hm4z4Zh7eSOZrfZXnQy1FnY6M/P9c/h4VZu9DS0hqRQ=;
        b=EAidv3h/vFom15zUMtqQkKpkWeHPLFSMcz9rw7A2Mn16caz/aXrqcs/znDrM3JD8PT
         vkYqVmPUz2IV/dsjv5M4rzayOcMdDMlDSykjbWLFS55OpU36vApCKZGqFdC3Z0Dmv3ZD
         m6Gcyr+awZB+1S4sGczskp7sq1a67pa4B87zrcMOHajIzHyywOwd15cEPYfYKZC1NAtW
         7Ypg1eL0tvFd6JEN2CPHbsFmjTFSsvS81tONZXS3VRLMLLvsx5tYqQZW3L24h9xdrUeY
         64Gc1+8kXyynCUWjU9UWuzHqkpf83nMByDiDdQLMqzkUKM3FZlO9JEFC54BwOLB7v48F
         LNhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrw/JBbhLktfMxeokLmmIQbsVuMFFAOn2e3DqRjh2L7ezKA77YgvbJW4WIlWgY4EOwP/Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRS+2cdgOMG1RalEC692dddbIiVgwm/KLGBRnJkPdS0rm1/Zpg
	Ogey4hJefi5TUNLOdL2uIu9dHcIe6mJFGSz6iZJrY9IYDB3t8rwrVRoFVgTIayBTdQ1k2ojLDUM
	WwCSN9g==
X-Received: from pfbcg8.prod.google.com ([2002:a05:6a00:2908:b0:847:84b8:2dcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9295:b0:848:4123:68ff
 with SMTP id d2e1a72fcca58-84e2bc02764mr8213181b3a.65.1784907226911; Fri, 24
 Jul 2026 08:33:46 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:33:46 -0700
In-Reply-To: <20260629183746.699840-4-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-4-yosry@kernel.org>
Message-ID: <amOF2p2tTjOXcRS_@google.com>
Subject: Re: [PATCH v3 03/10] KVM: selftests: Use an array for guest_regs (and
 fix offsets)
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> The assembly code defined by SAVE_GPR_C uses the wrong offsets for some
> registers in guest_regs. For example, the offset of RCX should 0x08 not
> 0x10. Also, the last offset in the struct (R15) is 0x78, not 0x80, so
> the code actually saves and restore beyond the end of gpr64_regs.
> 
> Eliminate hardcoded offsets by using an array instead of a struct
> (similar to KVM's per-vCPU regs), and use the array index to generate
> the offset. While at it, rename SAVE_GPR_C and LOAD_GPR_C to a single
> macro, SVM_SWITCH_GPRS_ASM.
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  .../selftests/kvm/include/x86/processor.h     | 36 +++++++-------
>  tools/testing/selftests/kvm/lib/x86/svm.c     | 47 ++++++++++---------
>  2 files changed, 41 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 7d3a27bc0d842..535f26e077570 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -396,25 +396,23 @@ static inline unsigned int x86_model(unsigned int eax)
>  #define PTE_GET_PA(pte)		((pte) & PHYSICAL_PAGE_MASK)
>  #define PTE_GET_PFN(pte)        (PTE_GET_PA(pte) >> PAGE_SHIFT)
>  
> -/* General Registers in 64-Bit Mode */
> -struct gpr64_regs {
> -	u64 rax;
> -	u64 rcx;
> -	u64 rdx;
> -	u64 rbx;
> -	u64 rsp;
> -	u64 rbp;
> -	u64 rsi;
> -	u64 rdi;
> -	u64 r8;
> -	u64 r9;
> -	u64 r10;
> -	u64 r11;
> -	u64 r12;
> -	u64 r13;
> -	u64 r14;
> -	u64 r15;
> -};
> +#define GUEST_REGS_RAX	0
> +#define GUEST_REGS_RCX	1
> +#define GUEST_REGS_RDX	2
> +#define GUEST_REGS_RBX	3
> +#define GUEST_REGS_RSP	4
> +#define GUEST_REGS_RBP	5
> +#define GUEST_REGS_RSI	6
> +#define GUEST_REGS_RDI	7
> +#define GUEST_REGS_R8	8
> +#define GUEST_REGS_R9	9
> +#define GUEST_REGS_R10	10
> +#define GUEST_REGS_R11	11
> +#define GUEST_REGS_R12	12
> +#define GUEST_REGS_R13	13
> +#define GUEST_REGS_R14	14
> +#define GUEST_REGS_R15	15
> +#define NR_GUEST_REGS	(GUEST_REGS_R15 + 1)

Eh, these aren't guest specific, they're architectural x86 values.  Ideally,
KVM's own VCPU_REGS_xxx would be X86_REGS_xxx, which is possible now that KVM
doesn't do pretend RIP is a GPR.

I also prefer arch/x86/include/asm/kvm_host.h's approach of using an enum, e.g.

enum x86_general_purpose_reg {
	X86_REGS_RAX,
	X86_REGS_RCX,
	X86_REGS_RDX,
	X86_REGS_RBX,
	X86_REGS_RSP,
	X86_REGS_RBP,
	X86_REGS_RSI,
	X86_REGS_RDI,
	X86_REGS_R8,
	X86_REGS_R9,
	X86_REGS_R10,
	X86_REGS_R11,
	X86_REGS_R12,
	X86_REGS_R13,
	X86_REGS_R14,
	X86_REGS_R15,
	NR_X86_GENERAL_PURPOSE_REGS,
};

And I think it makes sense to squeeze this in with the other architectural
definitions, e.g.

diff --git tools/testing/selftests/kvm/include/x86/processor.h tools/testing/selftests/kvm/include/x86/processor.h
index 7d3a27bc0d84..bbb7c71bb768 100644
--- tools/testing/selftests/kvm/include/x86/processor.h
+++ tools/testing/selftests/kvm/include/x86/processor.h
@@ -57,6 +57,26 @@ const char *ex_str(int vector);
 #define X86_EFLAGS_VIP         BIT(20) /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID          BIT(21) /* CPUID detection */
 
+enum x86_general_purpose_reg {
+       X86_REGS_RAX,
+       VCPU_REGS_RCX,
+       VCPU_REGS_RDX,
+       VCPU_REGS_RBX,
+       VCPU_REGS_RSP,
+       VCPU_REGS_RBP,
+       VCPU_REGS_RSI,
+       VCPU_REGS_RDI,
+       VCPU_REGS_R8,
+       VCPU_REGS_R9,
+       VCPU_REGS_R10,
+       VCPU_REGS_R11,
+       VCPU_REGS_R12,
+       VCPU_REGS_R13,
+       VCPU_REGS_R14,
+       VCPU_REGS_R15,
+       NR_X86_GENERAL_PURPOSE_REGS,
+};
+
 #define X86_CR4_VME            (1ul << 0)
 #define X86_CR4_PVI            (1ul << 1)
 #define X86_CR4_TSD            (1ul << 2)
