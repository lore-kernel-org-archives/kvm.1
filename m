Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02523B5830
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330882; cv=none; b=DYl7C8HEHeri43hK167e+N4ScSBBob10zSASKRy5iEwtOnz6shgnATMmA4OdovT4zRjT4iCXNdlEL+XhgM8hBMFu1I8t03cJ5BRoEMOgU3Tgqqml5lyU+TkTu77R4abUfWtn8tX/h43KqbS7IYor/UC6xuXemalnkM7UAKI54Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330882; c=relaxed/simple;
	bh=EzwWxXyr18y9/WLhPSXyVTO/E0MDxwC8co9A06bM940=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P8+Pysj0SaOqJ51p0QbgLzXbnT0z5d5P2YHuSFCa8paI4W/nztVUUuodnSmb5XwKEF7S37WsfaJ4k5yawKY+dNyvE02vXkALMWEnrY91ugPiTRYzyD79Ad6yzV1guY4IxTC7cbC3tAKbEpH1V6CNvY8ZY/HWRq2TWGmVyQuv6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2t3dcjN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2t3dcjN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so4823974a12.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773330880; x=1773935680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgQPl3tY5OJK3ny0f4wh3X3LNjdt2+3T3Ndt2tt/3Dw=;
        b=K2t3dcjNV9nh1cZ8q89NK8K/49XhgMppIB2ImfDwn0GiaJlt6aIFU0kLIpqngQO/57
         ycLMsXM5FFiH2Zt1XnmXzjPo3UbxpB7Y2/jOYjkaWZV/6hVaKqg6gEqsEpvDi7i6Zn6H
         raGC7Ttga8wWcYnNkPkpoTkOXaiQYeiQMTf7N6VgIRqlBWGdalk+nyVHLJrjUp7uvGf0
         kyEK2rilxK+FqwsZ8x2zqflUV/ZBFEf/vj0Zh+1TYxMqRA3ybdhO4VtYyngte0AiEH5l
         yKELLy9T0Q09+qJw1Tvjntjbb9mXubQnld2vFKkZEEy2hiiYFjSQM1uXD9r5sRrLkwEz
         Ye8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330880; x=1773935680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgQPl3tY5OJK3ny0f4wh3X3LNjdt2+3T3Ndt2tt/3Dw=;
        b=qZoVdAvuuchtV+zPm63qhddUzxXytBfz0hXY/gZb0AY/5tPSq4YR0rrN7oGL5WWiKT
         qgUnR+v62AHOhuiqsCTxu1UZtk+ljsCm1Lp/1wv9MslLYIAUmpjkQsJBYD0xAwt+uGyr
         ocWcK3KRhEohBZoyHSBomwPrVW8tkzgklxDq5Fe9933ABDYbB1WIq/Goh0Dsy12DiJrU
         kBaM6VA7/J5U2a6BgaKwtKD9qY08Yy+qYXWNwrVXIlUC73/eoPW1gvY70PVrGAYR84aL
         3vGZb+n+IUIkeiyFy2XYDeovDcP77OhhqlPDyFt9Q4n/cH1kaJe1suyBebHZR5/6InDD
         mmeA==
X-Forwarded-Encrypted: i=1; AJvYcCVTBaqoQCBrIjvBX7zj/h78yGh/KA4C5OpKASaT971wTTZ6+18sEvScQhIOyd0K7hsqTyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTqS2Y7sL6nFXJHRCw4Q8Ks+2D8OJfBN1z2xzkDUg7LeZ850S
	UjlgzoDjETp5211OKIaxZ1r7Pqy8v3EiE2EMip38oF7lO8KXUMOkfpnrHFmeRNYZtyruP3aB786
	zJn/hPQ==
X-Received: from pgx11.prod.google.com ([2002:a63:174b:0:b0:c73:846d:a381])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3984:b0:398:9ef1:fc5
 with SMTP id adf61e73a8af0-398c5f3e1bfmr6183866637.25.1773330880020; Thu, 12
 Mar 2026 08:54:40 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:54:38 -0700
In-Reply-To: <CAO9r8zO_Mo-98MqREwHq4JN0bA11H2EpmNmUkAU5QvNm9OGNbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
 <abH0RdnM29Xyh_4G@google.com> <CAO9r8zO_Mo-98MqREwHq4JN0bA11H2EpmNmUkAU5QvNm9OGNbg@mail.gmail.com>
Message-ID: <abLhvoAg17OKMrxR@google.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 12, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index c8e292e9a24d..74df977a38ca 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -3867,18 +3867,10 @@ static int check_svme(struct x86_emulate_ctxt *ctxt)
> >         if (!(efer & EFER_SVME))
> >                 return emulate_ud(ctxt);
> >
> > -       return X86EMUL_CONTINUE;
> > -}
> > -
> > -static int check_svme_pa(struct x86_emulate_ctxt *ctxt)
> > -{
> > -       u64 rax = reg_read(ctxt, VCPU_REGS_RAX);
> > -
> > -       /* Valid physical address? */
> > -       if (rax & 0xffff000000000000ULL)
> > +       if (ctxt->ops->cpl(ctxt))
> >                 return emulate_gp(ctxt, 0);
> >
> > -       return check_svme(ctxt);
> > +       return X86EMUL_CONTINUE;
> >  }
> >
> >  static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
> > @@ -3984,10 +3976,10 @@ static const struct opcode group7_rm2[] = {
> >  };
> >
> >  static const struct opcode group7_rm3[] = {
> > -       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme_pa),
> > +       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme),
> >         II(SrcNone  | Prot | EmulateOnUD,       em_hypercall,   vmmcall),
> > -       DIP(SrcNone | Prot | Priv,              vmload,         check_svme_pa),
> > -       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme_pa),
> > +       DIP(SrcNone | Prot | Priv,              vmload,         check_svme),
> > +       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme),
> >         DIP(SrcNone | Prot | Priv,              stgi,           check_svme),
> >         DIP(SrcNone | Prot | Priv,              clgi,           check_svme),
> >         DIP(SrcNone | Prot | Priv,              skinit,         check_svme),
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e6691c044913..e1223c07593b 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2294,7 +2294,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
> >                                 EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> >         } else {
> >                 /* All SVM instructions expect page aligned RAX */
> > -               if (svm->vmcb->save.rax & ~PAGE_MASK)
> > +               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
> >                         goto reinject;
> 
> Final observation (hopefully), this check needs to be moved to the
> VMRUN/VMLOAD/VMSAVE interception functions.

Gah, yeah.  I noticed that when initially typing up my response, but lost track
of it when I got distracted by all the emulator crud.

> As kvm_vcpu_map() failures will stop injecting #GP, we still need to handle
> the case where allow_smaller_maxphyaddr is used and the GPA is illegal from
> the vCPU's perspective but not the host.

allow_smaller_maxphyaddr is irrelevant.  My read of the APM is that the intercept
has priority over the #GP due to a bad RAX.  So with vls=0, KVM needs to check
RAX irrespective of allow_smaller_maxphyaddr.
