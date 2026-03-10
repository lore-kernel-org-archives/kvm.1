Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2936C0DD
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184351; cv=none; b=OD/r3L2GVaf8qfvkd81pJGl0yBBfw6P9YWDpw4EJaYxrun1lcyMQFUrXeQvdz/EFu4J1BB6hKXRFmCjTQ5xPhq60pQ3MlfRV2qlx9ACpXXYHb/48c7H+AAqd63qX0FSntoweMY6IwfrklEo6749OV32HEnyj1wc03SQ4xzv/F9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184351; c=relaxed/simple;
	bh=Tjs1OZVra2n3huyBmN5QCBfV3DAvkk3floZpEuptYrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMSKF7pNvS+dasB53w06s1qfXV/xs2TGYvMYoq/w+5q4Xs5QY9Vr8xy1ErsZeqNNq53DbQpE1Yp5DQfwSfaT62fC1IBp/FJn34w4OCWgaUTO6naKq4uf7kzm26Qxs7tc2LviybMasGpXtZ3Y/qUK/KwnD9lswL9fOuWIflgeR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9GBxNsx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9GBxNsx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adc527eaf5so82232435ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773184349; x=1773789149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1leDsb8RPc9uphgU7OUO7uZEtpg/5r81dXHSE9Lmy0=;
        b=O9GBxNsxmS9TPiZP9CekMSUDUcxArUVavy6zB1z25VWoRR+qMzK9hfeEk76AXxC/Lh
         NZ1GSOzvCAftHHRTeGXfCvLtoRt1zBLKSZjuNCoGa0tNvzYP7HzpGA+gQ5IhplejtyTU
         PDbaxQYPzBiuH/WumuG/n4IYnIjqascT/+KcHE1PVpVA+Nps2YjqsJi8Wm6rW5hSwcmg
         8Frjb772xZv+pNxmQHpi0Ej9nUIffs2tJzcSBSf+DW/GdhCRviOoZ3ZF+ziYqGA9ZYyn
         v6+Va7w6tqHEh167FcrG7iqekXz958/eY/FiIK6j0SUlEyFEUxKDq6Y3QLA/LvD9jVcM
         CtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773184349; x=1773789149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1leDsb8RPc9uphgU7OUO7uZEtpg/5r81dXHSE9Lmy0=;
        b=I7L93CMJ3E+pIS1D+2VSfmih2xZDo/Lb/2YJPJsIYCWLQtW5AeckQOO1cynGQ5ogdM
         wUhw322SrIyc0Cxh8RN8jLedc9/AjPUTMwIT4urNtNLkDtes0a3F2NE5tOrdwUe4lJso
         ys7pg/c8guB0vhRAIjfengPQ0PwOPaqHhvh+q0tdp+bqla85xNqmkL6zMwbpSy0Nc5vb
         63rPUS1N5s6D1BEcwRspdHXiqg5DURq8MB2pXS8EOCgjdosO7Nn2hhuB9Z3EtOjZQmHT
         EK9HRoqO2OuQ0TjqBWYWybuhA612tNR4SAQcd60Lesg0+k3m7VpH5WMbPSKgEr67NWEO
         T1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW674k2SbsATlPi3xJu3QAq2PohlT7Lb1v0YW0wzuglq8AuNtuQAJnECC3HWi4q0bM4ub0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsU3KgmJPCq18VhAcsvKLRnQ2+mEkL71T9BAhVRJEBFkqpIzff
	FPffTV6JrFwxoj9DtxISddas2VcrQj33ASxVQPZjrKSgfMa2HAMsQBEzt3pIF65kLVlot3FJ8fb
	NqhwHgw==
X-Received: from pgam2.prod.google.com ([2002:a05:6a02:2b42:b0:c73:97d4:afe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7703:b0:398:951c:b67
 with SMTP id adf61e73a8af0-398c60df84emr266304637.46.1773184349173; Tue, 10
 Mar 2026 16:12:29 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:12:27 -0700
In-Reply-To: <31093743-97e2-42a7-a989-84704f25f40e@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112235408.168200-1-chang.seok.bae@intel.com>
 <20260112235408.168200-2-chang.seok.bae@intel.com> <aajd6Fa8gHz6lW78@google.com>
 <b5b9efce-9205-4282-acc2-380d348c4f50@intel.com> <aa9ym-SWeOdTrz0O@google.com>
 <31093743-97e2-42a7-a989-84704f25f40e@intel.com>
Message-ID: <abClW229Q_LHobgX@google.com>
Subject: Re: [PATCH v2 01/16] KVM: x86: Rename register accessors to be GPR-specific
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Chang S. Bae wrote:
> On 3/9/2026 6:23 PM, Sean Christopherson wrote:
> > 
> > Oh, yikes, I didn't even see that this series is playing games with the register
> > indices.
> > 
> > Whatever we do, the changelog asbolutely needs to call out the real motiviation.
> 
> Given the discussion here, it looks so apparent the changelog is missing
> that detail. I'll ensure something like what you wrote here to the revision.
> 
> > I'll try to come back to this tomorrow with more complete thoughts and hopefully
> 
> Sure, you call it. I know you have a lot on your plate, so I hope you feel
> free to take your time. Thanks!
> 
> > E.g. passing in VCPU_REGS_RIP to kvm_gpr_read() will compile just fine, but will
> > read the wrong register on APX capable hardware.
> 
> Right, so new semantics likely need to be established. As responded before,
> one option would be separate them in structure:
> 
> diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> index ff07c45e3c73..ff8a317be5cf 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -795,10 +795,14 @@ enum kvm_only_cpuid_leafs {
> 
>  struct kvm_vcpu_arch {
>         /*
> -        * rip and regs accesses must go through
> -        * kvm_{register,rip}_{read,write} functions.
> +        * regs accesses must go through kvm_register_{read,write}
> +        * functions.
>          */
>         unsigned long regs[NR_VCPU_REGS];
> +
> +       /* rip accesses must go through kvm_rip_{read,write} */
> +       unsigned long rip;

Ya, this is where I ended up too.  And then as prep work, we can and should
convert regs_{avail,dirty} to proper bitmaps so that the size can be dynamic
for 32-bit vs. 64-bit vs. APX-capable (or we could just use a "unsigned long",
it would only change what BUILD_BUG_ON()s are needed).

E.g. I have

        unsigned long regs[NR_VCPU_GENERAL_PURPOSE_REGS];
        unsigned long rip;
        DECLARE_BITMAP(regs_avail, NR_VCPU_TOTAL_REGS);
        DECLARE_BITMAP(regs_dirty, NR_VCPU_TOTAL_REGS);

and then the below as a final testing hack for APX.  I should be able to post a
small series later today, which will map out out most of the register crud (I
didn't do anything with the emulator, so it's not a complete prep series, but
it should be enough to allow us to choose a direction).

enum kvm_reg {
        VCPU_REGS_RAX = __VCPU_REGS_RAX,
        VCPU_REGS_RCX = __VCPU_REGS_RCX,
        VCPU_REGS_RDX = __VCPU_REGS_RDX,
        VCPU_REGS_RBX = __VCPU_REGS_RBX,
        VCPU_REGS_RSP = __VCPU_REGS_RSP,
        VCPU_REGS_RBP = __VCPU_REGS_RBP,
        VCPU_REGS_RSI = __VCPU_REGS_RSI,
        VCPU_REGS_RDI = __VCPU_REGS_RDI,
#ifdef CONFIG_X86_64
        VCPU_REGS_R8  = __VCPU_REGS_R8,
        VCPU_REGS_R9  = __VCPU_REGS_R9,
        VCPU_REGS_R10 = __VCPU_REGS_R10,
        VCPU_REGS_R11 = __VCPU_REGS_R11,
        VCPU_REGS_R12 = __VCPU_REGS_R12,
        VCPU_REGS_R13 = __VCPU_REGS_R13,
        VCPU_REGS_R14 = __VCPU_REGS_R14,
        VCPU_REGS_R15 = __VCPU_REGS_R15,
#define CONFIG_X86_APX

#endif

#ifdef CONFIG_X86_APX
        VCPU_REG_R16 = VCPU_REGS_R15 + 1,
        VCPU_REG_R17,
        VCPU_REG_R18,
        VCPU_REG_R19,
        VCPU_REG_R20,
        VCPU_REG_R21,
        VCPU_REG_R22,
        VCPU_REG_R23,
        VCPU_REG_R24,
        VCPU_REG_R25,
        VCPU_REG_R26,
        VCPU_REG_R27,
        VCPU_REG_R28,
        VCPU_REG_R29,
        VCPU_REG_R30,
        VCPU_REG_R31,
#endif
        NR_VCPU_GENERAL_PURPOSE_REGS,

        VCPU_REG_RIP = NR_VCPU_GENERAL_PURPOSE_REGS,

        VCPU_REG_PDPTR,
        VCPU_REG_CR0,
        /*
         * Alias AMD's ERAPS (not a real register) to CR3 so that common code
         * can trigger emulation of the RAP (Return Address Predictor) with
         * minimal support required in common code.  Piggyback CR3 as the RAP
         * is cleared on writes to CR3, i.e. marking CR3 dirty will naturally
         * mark ERAPS dirty as well.
         */
        VCPU_REG_CR3,
        VCPU_REG_ERAPS = VCPU_REG_CR3,
        VCPU_REG_CR4,
        VCPU_REG_RFLAGS,
        VCPU_REG_SEGMENTS,
        VCPU_REG_EXIT_INFO_1,
        VCPU_REG_EXIT_INFO_2,

        NR_VCPU_TOTAL_REGS,
};

