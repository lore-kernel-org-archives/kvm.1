Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AD3D76
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393821; cv=none; b=QaRHUGBkvVXTZkGPrdbyJ3l+HT7ukbyiobFn81XecYVqJ2lrskvBsk9hJ99s5ZUxJmjW/DdRwgsbnMmtA6N1e8DhclEMx7MpJVR/pn//2YhL9Wjei8nz1LZgaosZlbBvDpWrj8HKqhrMNqT7S5lm+iqD+1+OTSfIXMba+DfxO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393821; c=relaxed/simple;
	bh=4bOUM9SqneLmuOGjaCbKT2K3+I7j68NoiUuvTB0+iYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lxZlRBGkiMOXmzT/peMmrICByIXd6LKV8lsyLFRhYg05iQYc5btHi2HkWIjk32ewr7KDEKqXFdzbwh8Qz+KteZrZQLtnVYzEu5zJx2x1M5QNcxKk0CxWB9TSmg0V01qxoouG5ppok6hdbdQ+1JbnugWhgEJyiAOwmZCzoL5hyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnLXiPVt; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnLXiPVt"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d52734fc41so31373725ad.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788393819; x=1788998619; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PtrGZ8c2EjX4OS+R2zOI0XlmpBoBwI0YX1JBim1uXc4=;
        b=bnLXiPVtk5S6Ag9fLq9ZjHI01TH4V4OHiXGw0EaM5tBbKGj5A7y66fZXcUlSMHsasy
         IOWX81HdrQOLZjM01lvln0mrC2uV0VF4mbVg7grJFMzsqVxWeo68Crm9Tee21GJZUSQR
         fzDOcGm/xFeECCSEXfl3WVoyrubQZiJybiyEiHYx/HwshgEmzYFTyI80vHLrGHpf9yNS
         CuqBXOB8cko1Wckq9G+YucExO1BTNMZ32A6gLPl2tOs03VdpUQupISKRReHVJAximGrx
         PdVy5GjxsY970Z6sUrxtC0Bv5OZoaUY9N7iq85DAuozwFQguOPdkthdG0T3NtLMHG5L3
         CPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393819; x=1788998619;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtrGZ8c2EjX4OS+R2zOI0XlmpBoBwI0YX1JBim1uXc4=;
        b=qqjYQzCcNEVh0Rk0Nv2aQ3cJVpCNlHN5vevIHTnIsddHnthV0lD0LKaHKrXztH+g0q
         zhHe7vhiRBxmb8axNNqnCEl35T+QX0Ahr8SzNnmeJD6K9M6WrMjFxuSGF6jaJ3a8UeBh
         KoM7ofj/6TRiU3BeX2fqLL1hvYppI62fgKpRJIHFme+ktG+a5znJgy/vceLStix9aK9B
         y6lM+0+0Bm7ZszWrRa/Hj1ogvUQEKhX0P44CIYJcmnwe5NayTVuiPPxBEhL+89Cyev5o
         v/lTxMgGuTw7JwcDx9qAjUyN0NJgmB6bgl+PTqzuTJmH3DAAAxrnviNcqDDXnxq1MjCg
         Bplw==
X-Gm-Message-State: AFuF++kxkp0l9+yvmtUd3gFHw/knFJH7Yd1wmGfJVAajOkgxmxBZfWMg
	pmkoFQ2athBZZJ6xS6zpfTAmN7XPDrfqJztv6AkFXM3bzWRw2+ik3LXV53VQKrFvNrjZH0QaupH
	Qjq8JFQ==
X-Received: from plll21.prod.google.com ([2002:a17:902:d055:b0:2da:efa4:6509])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3884:b0:2da:fa6a:b04f
 with SMTP id d9443c01a7336-2dafa6ab21cmr45722325ad.2.1788393819396; Wed, 02
 Sep 2026 17:03:39 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:03:38 -0700
In-Reply-To: <20260902234003.B3A561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com> <20260902232028.2767071-3-seanjc@google.com>
 <20260902234003.B3A561F000E9@smtp.kernel.org>
Message-ID: <api5WjBiSpJW656d@google.com>
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 49fb10ad1f9f6..23d29597d6bf2 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
> >  
> >  	kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
> >  
> > +	/* SVM ignores EFER.LMA if EFER.LME=0 (instead of failing VMRUN). */
> > +	if (!(svm->nested.save.efer & EFER_LME))
> > +		svm->nested.save.efer &= ~EFER_LMA;
> > +
> >  	svm_set_efer(vcpu, svm->nested.save.efer);
> >  
> >  	svm_set_cr0(vcpu, svm->nested.save.cr0);
> 
> [Severity: High]
> This is a pre-existing issue, but does this logic only implement half of the
> hardware VMRUN rule? 
> 
> While this correctly fixes the invariant for EFER.LME=0, could a malicious
> guest desynchronize KVM's MMU state from the physical CPU when EFER.LME=1?
> 
> If an L1 guest creates a VMCB12 with EFER.LME=1, CR0.PG=1, but EFER.LMA=0,
> and executes VMRUN, nested_vmcb02_prepare_save() skips the LMA update
> because LME=1, passing LMA=0 to svm_set_efer().
> 
> Then, when we reach svm_set_cr0(), it fails to correct EFER.LMA because it
> expects an edge transition (!is_paging(vcpu)), which is always false since
> L1 must already be paging to execute VMRUN:
> 
> arch/x86/kvm/svm/svm.c:svm_set_cr0() {
>     ...
>     if (vcpu->arch.efer & EFER_LME) {
>         if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
>             vcpu->arch.efer |= EFER_LMA;
>     ...
> }
> 
> Would this allow the guest to trick KVM's instruction emulator into fetching
> arbitrary instructions from a different physical page than what the guest
> actually executed?

Maybe?  But unless it negatively affects the host, I don't think we care?
