Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794281433;
	b=DrLTOMMgBALUhMdo+BWneDkjkTlyx+Rb45TZnO7InONmRln0evHbc2C8pO9YCxBDVzyq
	 qjQ8ZnU91qw4RWkkdTs+DnL9zoHdzHcr3o6Dq/0XBFX6L3LaEoRJF+y4FugeiqACL1P05
	 kHwA4l7vag9iwIxZGdU60PcemeUWrW5EbxWw81/O2PX8Jl/lBkcpGgV5Gab//aO7uSdw7
	 fpwzC+HcISYEVP1RBBe6qXtCTe8ojOpqY54O8Pfaqw8ggs9UeeGhtvczH6Dw3ce3PpFGZ
	 VjJJeO4T9xN3Wq6g6SpfI0XMDlN0KKdMFDiAMipKyCRqUR2RCqvwVuViY9vJH8O2GBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4qRqqhKQqWrrboy8HsAud/37m8y92m/NCTDkQF7hqO0=;
	b=RjrEevSEWUwhZKIqt9OLgGX5i5QmeBslumV1yFpoUJ0M+j+8P+o8+hoPwWyxEGFszlei
	 e5M7zbBGZYrjVI3udTvHBotQrZUIFm7TI+gWIvACULP3xX4cFO9Fn14Pg7K5tDqezbtm3
	 rGyqL1Ak2HsAxxqWEVakywQfOQmcQ21cDXJUZ6kd2oPkoSRg13clPSjoo8kKwfnzdk0v/
	 xGCIQxJgezfHRbm8iHxxY0MmkCv66fAZ0umTKthcKfnx+687BYlfSz0pLMnw+PiJChuzM
	 S4UAOwgr4S4YrmqgHSYU4K6kZJtLS9LFIpH4/nKJ715PH02hBawSMuS20lFTlqTW1ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCToDWVt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7C606A332
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 03:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E7C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCToDWVt
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so4063a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 19:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794281432; cv=none;
        d=google.com; s=arc-20260327;
        b=OfQ5hUhXzgdeG5S556tGu+p30OM8ZAyciA8A7U3hpg09TkdOqgaHmEbkfRZCGKjMCZ
         A4O8SkNJXU1nizfQbpYikuWtN9Z+HkfYpIRXIYSQgAqE54/pNXEqo/JUAea6zpu6KOkI
         KtnmE1tZ5I7VCBs2vFoBZAa016DbEjQuZnDcMduG0may/lm8x7nqpgdxH4JIxUvypqtG
         9Msb/sbvhq5oSW03Cl0W8PJmehvTQuHFyWT69pXWOIlVC5E97ISQPdx8hHSnDX937NfJ
         cwSDvnzBXlK3fyIlNNvj4RqLuo5RxkicxSAej0c/gB3zzl0SH+pv/OagdZ1AO0jKkw5M
         Nmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qRqqhKQqWrrboy8HsAud/37m8y92m/NCTDkQF7hqO0=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=R5QFZKpaCBfxWk1+pzHUCOm80UpYgsM+M+vLUwc3ZetONs9rFByVmJ4wATxccnVgV0
         1faYdQJxy1I6WviFo3hwm6sJxEoEVaF/YlBarXb1pdCL6f5vwFCvpvfuEqS12GmRNCbR
         2wpzJdGAOWNOyu6GvuUkNo2jlNvuihXAgoH7m+gRdlTm10r9AJ7Yiq9ngQ7difx2fiNa
         uDcIFRhmJM1aowFPt7VUPZNYM3yzu9C7JQ4VbaIXkOGV/tRn6ZF2pd+obUAnyiud7R5O
         OwCAfcE3zucDJdW3MzOrNGeFgdc/C8mFbdWOubBmDTQKzsf1kxhAI3QxNsL23LcFDsKu
         2MiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794281432; x=1794886232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4qRqqhKQqWrrboy8HsAud/37m8y92m/NCTDkQF7hqO0=;
        b=pCToDWVtWHcmju2i5vo1ell0RBVvrpSRYxCwjiconV8v/uq4tgwU8at6PDl2tvAMqi
         447UHOcguLgSCm6oPr4dAe//Pfsmk84NIA3Lcupak7FBeh0yDoQmNOyG78nDnOywGcxm
         iNrsTBdot33vpfPy7ZteHYySRhyw2q1EOMLnSWEx8nF6hXG5nXIbUwk8fME94Ehzp6C5
         6BwArLQh9ywNsX/Xa/d/JKWqeMQ/Xz4OpYR3ZDxLs/jnkvjsfRdl1LDV06Rcjz226wRF
         65+M6Aby1nONvsI+xtEktOrLdlD528szT25d0i8w0xhwNCDvy6Qzz8PIeDz79s5gTRZ/
         5rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794281432; x=1794886232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4qRqqhKQqWrrboy8HsAud/37m8y92m/NCTDkQF7hqO0=;
        b=qRROlNWMPVJw1RX1Yk+1MR5RrCNK1t5JV1ZxP4VB3mrJ3WOfChEcgtSOQp+VAwLQud
         DpWNnMoJ0wTkxhuRbiBnbWNTaQBw9X4OrAVGt8U6mWge4PsSPj4/KouZgmKAsG44yjZ4
         aSXcL86P/rTIqCcBJElZ8Go0THSvgKp573mBRt1heujqzSIP0ueHix/T24x1B4KaC61G
         waLa1pbSB1oC07EnWmtkAgiqadQ009orhhxTs7RaQRoWjmUvICoGdTJSVqWp/VK+Pw7Z
         l6WO2wCdJbL/dS7GGBMNOa4rMrGI0DYJdsX+CpUN5IkEWGqfU+pTPbPGiBQP+ditGiHR
         QTZQ==
X-Gm-Message-State: APuU4Z8xbD8vC3lvyfH0g3Ti+kqZoH/BTjz7it3cD1Ob+1a4ocWw5EdJ
	YPJK8cy9sPGeUYNXJO70zMfaIQevyKTfSPHfy7uCXxjlM8EoHLsBfojeUst+02UTAjpvuxy3yJn
	24jliUHuKi86Rcin3M9FyE6gnFzJJJZwDBxOorCelNxJx7HnBznppHhGJI6s=
X-Gm-Gg: AYBFou0aCgLao7yt43Ue3hIHMSk1ZGaAsY2Zo2+GKZQ+UTzETopZ+70HOMTx9Ud06H8
	bTp55VbkhBf9tY4oWmhQKu59Dc9v3akg8FSLeYlmbqf0jHAsZumxGS14dshDioyrYlfLRP6lA4d
	Vsut4KXew+/inN4iFnRT/didDyg4QoZZrmWqIWgLT4DHH24vXTM4b62sV43rUWxhvQE0xR/GOrr
	QOfUJwZTrSqF7kbR5ODexvgR5jN5+7SKAUH2w+BMH4L2BWZFPRzhwzdkoJTR3VYAjxfdvfGLxvI
	MuHpFDm0Byx20cZ3TMhuSSODqf9V5Lxyhmjg8lF9HsewllizPFMuqampCoBzhcAx+s6K+eFDwfg
	gT/AOxYj0WhlDtmPHAtpTjvwbWoT02HdePYMGaIGQl6ybCmkgfsKvpC1StxyqZ4QvwmI0m0GN
X-Received: by 2002:a05:6402:a2c8:20b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b75a7c6522mr28354a12.16.1794281431344; Mon, 09 Nov 2026
 19:30:31 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110004037.125692-1-jmattson@google.com> <sashiko-outbox-205939@kernel.org>
In-Reply-To: <sashiko-outbox-205939@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 19:30:19 -0800
X-Gm-Features: AclHuK_t2oHdnmeVqgjWcz_GKdX1UpYOLcrSY1YQYKpKAAI9ePQZ2Ojqfb1wqFw
Message-ID: <CALMp9eS9reJ07aYs3THr7oboWqw3Ji=Pv_LyvzVpuW4DmLN_TA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:07=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] KVM: nSVM: vCPU left in guest mode when enter_svm_guest_mode()
>   fails in RSM [1]
> --
>
> commit b87b2411f4552cf28fa62d1f5b9a2e342f4694d4
> Author: Jim Mattson <jmattson@google.com>
>
> KVM: nSVM: Add missing CET VMRUN consistency checks
>
> This commit adds software VMRUN consistency checks for illegal CET state
> combinations in nested_vmcb_check_save() so that invalid states trigger a
> nested #VMEXIT to L1 instead of KVM_EXIT_FAIL_ENTRY.
>
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index f9090b601efaa..a3affdbc15c24 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu=
 *vcpu,
> >       if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
> >               return false;
> >
> > +     if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
> > +             return false;
> > +
> > +     if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> > +         CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
> > +             return false;
> > +
> > +     if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) =
{
> > +             u64 u_cet =3D 0;
> > +
> > +             if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet)=
 &&
> > +                 CC(u_cet & CET_SHSTK_EN))
> > +                     return false;
> > +     }
> > +
> >       if (CC(!kvm_valid_efer(vcpu, save->efer)))
> >               return false;
>
> [Severity: High]
> This problem wasn't introduced by this patch, but can nested_vmcb_check_s=
ave()
> allow an illegal save->cr3 through on RSM and leave the vCPU stranded in
> guest mode [1]?
>
> nested_vmcb_check_save() only checks save->cr3 with kvm_vcpu_is_legal_cr3=
()
> when both EFER_LME and X86_CR0_PG are set.  When resuming an L2 guest fro=
m
> SMM with either bit clear and save->cr3 bits set beyond MAXPHYADDR,
> svm_leave_smm() passes nested_svm_check_cached_vmcb12() and calls
> enter_svm_guest_mode():
>
> arch/x86/kvm/svm/nested.c:enter_svm_guest_mode() {
>         ...
>         svm_switch_vmcb(svm, &svm->nested.vmcb02);
>         nested_vmcb02_prepare_control(svm);
>         nested_vmcb02_prepare_save(svm);
>
>         ret =3D nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
>                                   nested_npt_enabled(svm), from_vmrun);
>         if (ret)
>                 return ret;
>         ...
> }
>
> nested_svm_load_cr3() unconditionally checks kvm_vcpu_is_legal_cr3() and
> returns -EINVAL before kvm_init_mmu() runs, after the vCPU has already
> switched to vmcb02, set HF_GUEST_MASK, and pointed vcpu->arch.mmu at
> guest_mmu.  Because emulator_leave_smm() returns X86EMUL_UNHANDLEABLE
> immediately when leave_smm() fails, it skips the kvm_leave_nested() clean=
up
> at the end of the function, leaving the subsequent KVM_REQ_TRIPLE_FAULT t=
o
> run in guest mode with an uninitialized guest_mmu and un-restored SMM sta=
te.

Thank you for the review. I believe that Paolo is already addressing
this issue in https://lore.kernel.org/all/20261102174130.8779-2-pbonzini@re=
dhat.com.
