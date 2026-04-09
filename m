Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DC3112BD
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759918; cv=none; b=RfX8+ub15DcwiIEHCxrhk/CLcJexQbR6UkZzxeN51A6Lk88jDyS1ndDiV4ft+R454CvADuKwuZMPAGpofjgB9zlIXKV240t+gVf3YEyOMpuuvQ8uhbsr+wfeXICydKLOZC6RevTAEWpsuUoZLQd/W8xq9jVyKqEBZRJrGr6PjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759918; c=relaxed/simple;
	bh=Gqq0qPDhRj1ViS0hdYCDLoJ6C0DL5yAvzqkfva9cQRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoO5ujYiI5zZ32VZJRNRcRbI29LxrIDCNeWbHPv5DxVB9MwD2GXj1w54LWQ/QLbQHGeT+QrWvadaLnriMui/CAxWSVFUf6LFoUTiKBECxwtYd2Jtu9nGtkKqhJNge55hvawN4y2tMquN/XIHrj1N7d/13YzyjrKB/yxvjs96q2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFYjINoW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFYjINoW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741b950511so656831a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775759915; x=1776364715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVTgkJjg/Y8v5u56Zdlg/Uwr9pfljLNL1gOzjVlRH7A=;
        b=IFYjINoW1hbHrATaTp/0Xg1A+VjtSSd5sEgS+yWqJHtCXjYCLun3hEaZeZRD04ltI0
         3NbWaVGpG1Kom+ZCDjqyGjMd4C4rxh9Ce6Q8nTlLgm75PYbKBY4rj1YdCLIFSgMiixRZ
         Hm+jSiEdA3P8t4QQvqa5XIq+fsYrYsrupsnM475aVsESqZnjm9ESrz1SZp443f0MyQ/i
         jgMucJJnAZPvJ5KVtLJLaI/WDa8mynGBHcmnsrtwBNadoW7b3c4GVRjuti68dQBqi+O6
         KdNf5yl55ryxtKP3KtYtcL56Y+exu5ndNs9OMv+c4Z0NtyTbofQuFyOHgAGQF7bQDIHh
         KWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759915; x=1776364715;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVTgkJjg/Y8v5u56Zdlg/Uwr9pfljLNL1gOzjVlRH7A=;
        b=fgfEeox6YM3KAWEaxRRhSfpRKZph3Hcx62nq2TyArJvROHArSN+26EHuC1U8aHtPNt
         zIOZPT4RC+dpkTfv9UuFG8OSIzzTOB4pFZe1OJZkjeLIrynOatlk/6GQWE212Wt+SpRF
         kn5auL1eIlu+pHF+jFqvl3Edd2uBRCn7erXnnMMTTqS53DTwNq+d+GF8TlS+6Q/H4LMk
         HY86uCUx8wV46sVth95Llj1dNrx2amgGQTQoRxz8OWQozRxY0M4NFfkxqzXE/v8PGiwU
         MBg1TlIKiHIXlLcH9WIvz2yL3Haxfa5jsI126kjEbqFtmlXa4NkZk4GNTjOezdilFU0+
         Amgw==
X-Forwarded-Encrypted: i=1; AJvYcCXSXE1q5fpLTT/3VUu/rgLUEG9rn1quHMeNDfHSFH2sQKQ/1Xb8xgps1Gp6uBrCymz7qkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFL/Ur2uD7fXy7RO/0yH8R7pco8LB5wzp9WDr4bMxdxfKqHIr
	/cCoxFWJFeq4wQw6/xUMWuN1bidCoebbiPx9Nevh8yXJTvbYVED5u7XV1ZSetve2kbqrLF3S8TB
	847Wd5g==
X-Received: from pfbjf13.prod.google.com ([2002:a05:6a00:6e4d:b0:827:4734:567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a241:b0:82c:2480:4e95
 with SMTP id d2e1a72fcca58-82f0c302aa3mr266790b3a.33.1775759915130; Thu, 09
 Apr 2026 11:38:35 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:38:33 -0700
In-Reply-To: <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
Message-ID: <adfyKU5WUiW4OnUg@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026, Jim Mattson wrote:
> On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > In general, this deferral is misguided. The G/H bits should be
> > > > > re-evaluated before we call kvm_pmu_instruction_retired() for an
> > > > > emulated instruction.
> > > > >
> > > > > > ...
> > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > @@ -9,6 +9,7 @@
> > > > > >  #include "kvm_cache_regs.h"
> > > > > >  #include "kvm_emulate.h"
> > > > > >  #include "cpuid.h"
> > > > > > +#include "pmu.h"
> > > > > >
> > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > >
> > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct =
kvm_vcpu *vcpu)
> > > > > >  {
> > > > > >         vcpu->arch.hflags |=3D HF_GUEST_MASK;
> > > > > >         vcpu->stat.guest_mode =3D 1;
> > > > > > +
> > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > >  }
> > > > >
> > > > > This happens too late for VMRUN, since we have already called
> > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction()=
, and
> > > > > VMRUN counts as a *guest* instruction.
> > > >
> > > > It's just VMRUN that's problematic though, correct?  I.e. the schem=
e as a whole
> > > > is fine, we just need to special case VMRUN due to SVM's erratum^Wa=
rchitecture.
> > > > Alternatively, maybe we could get AMD to document the silly VMRUN b=
ehavior as an
> > > > erratum, then we could claim KVM is architecturally superior. :-D
> > >
> > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> >
> > But clearing EFER.SVME while in the guest generates architecturally und=
efined
> > behavior.  I don't see any reason to complicate PMU virtualization for =
that
> > scenario, especially now that KVM synthesizes triple fault for L1.
>=20
> L1 can clear the virtual EFER.SVME. That is well-defined.

Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  That's rea=
lly
annoying.
