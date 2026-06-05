Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52717423168
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686898; cv=none; b=RpnUAPgmB+MhsDfJ8fHSfPFsRs+DjZ5/fW1JSoSRBQRGFWIUwWHsffUfMDmyPf4UrLPeoEfZr3wE7x6p2KrfUgUBdGpVoKDf+mNWkYFMmF6q7eTb+Gtpvuq4XHLSKmWCiBgiCCc2yNa+S+aqeLr6vZ0kY0nz1Uc9fPreWBjAzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686898; c=relaxed/simple;
	bh=At5Udh8CHpF85N4U7U4JZfbUuattsLHjBR78kcVf0AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LOATeS34jePQH3p1S6lGj+qEoNC36ZJieqj+aYRCoZd6BgIw96JSGbTCQpz9DfixmWkpXVOul7Phy+iNVEssYzqU4uU2cxJ/UWNAsX7rOMA0AQZIRIli4hlDWJaZAIHAS8jIKS8Q3dtjShgcBqsH4k35Mm4qvpnyCmPHg+cZn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AY7Vth/Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AY7Vth/Y"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422b1354edso2564879b3a.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686890; x=1781291690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2XqhZdHrHkagtDnOySYIP3nI8ujGms1N4fcjgqsFN4=;
        b=AY7Vth/YCDCT2RH0oj1f6eMMTnTM0jUmpXyzvWTzSB5nC2y6RCS03dptjKLeQmpGl/
         3VtXYMbZsKGf355i59aC7v+9dNRAs1vRQCzVHQqg7AmnZOLeTCZCVKx68K77q6WPpHad
         DdSR7HyBQzZB/1V4SVVr+jjeX0Y7aCiIwQV0WoraXoomE426Pl7hpTBRTwWSxjc8YW66
         VpYM7ut07ccr5qbBBUvL3iFOfIiBa/k5PYdL5TE58LApOvskwY6eal5/6I+Op2qmV8il
         FE9PwO3tI2a6ZGY1NwL6l/ANAZ5fbQXDUP65nonVMNNogyCVZzi6dTgkufRelSRRC/sz
         lQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686890; x=1781291690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2XqhZdHrHkagtDnOySYIP3nI8ujGms1N4fcjgqsFN4=;
        b=K7upkZhGPXLSXz+MMS1t0c1lJ2mkWz2XYfG+GS6QZCSi9T+Ilve1r+jd3u3TgC8xm3
         +ZerKUc6Q3dF/ykOBMvxGmWotclSTxGwitv5qO1BiAztshTvs+zS7BKZKPbZ67jU6zpk
         UYbSR6X1zDegZFktSptdYJ2Czcq8O6HRekm2XuQLibZRliFLMYi4ci2WAHOLlgG9dKf4
         G0bKmGt5XIboGJQqGw9xiIgBZ9jBfly7ZtdDWPbQwT+jbL0vGagT+TJPoFAEYpakB3Z+
         7gzcs5nAP2ejTIPvF/YHpCIMJ/5/TXdRtcX2Rv75QDx1Cyaw/V0cR27kmG5FF+JmVZmv
         h74A==
X-Forwarded-Encrypted: i=1; AFNElJ8dgfmKppE2n4Zlhb4q43IYRKX90A3snCmjm8HfSPcY/APb2X4RqVD3ORIXgSWahx6y4rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+lePEX85IGHUS7B2mDpsVjh5ROn3+pP/lDZKBScrskAffl6T
	32UKbbVnuS6ZJxOh/SdfSi1v1pQa8hVlfTYc77bf3qqa0WU32BbvYN75/gNXZrIG1LQCcLoXh5Q
	jbcydxw==
X-Received: from pfblh21.prod.google.com ([2002:a05:6a00:7115:b0:838:4903:1f13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1489:b0:82f:5034:77a4
 with SMTP id d2e1a72fcca58-842b0e006a3mr5264197b3a.21.1780686890031; Fri, 05
 Jun 2026 12:14:50 -0700 (PDT)
Date: Fri, 5 Jun 2026 12:14:49 -0700
In-Reply-To: <b615b8eab2929f8b64c220bb4cb9fd4a917db472.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-24-seanjc@google.com>
 <b615b8eab2929f8b64c220bb4cb9fd4a917db472.camel@intel.com>
Message-ID: <aiMgKb3XjHjwPGyw@google.com>
Subject: Re: [PATCH v3 23/40] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Kai Huang wrote:
> On Fri, 2026-05-29 at 15:22 -0700, Sean Christopherson wrote:
> > +/* Swap (qemu) user FPU context for the guest FPU context. */
> > +static inline void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
> > +{
> > +	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
> > +		return;
> > +
> > +	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
> > +	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
> > +	trace_kvm_fpu(1);
> > +}
> > +
> > +/* When vcpu_run ends, restore user space FPU context. */
> > +static inline void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
> > +{
> > +	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
> > +		return;
> > +
> > +	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
> > +	++vcpu->stat.fpu_reload;
> > +	trace_kvm_fpu(0);
> > +}
> > +
> 
> Nit: to me it's a little bit weird to put the two functions before the typedefs
> and macro defines below, though.

Yeah, I don't disagree.  But I think I'd prefer to keep it this way, so that the
typedefs are more obviously bundled with the ugly XMM/AVX register helpers.

> 
> >  typedef u32		__attribute__((vector_size(16))) sse128_t;
> >  #define __sse128_u	union { sse128_t vec; u64 as_u64[2]; u32 as_u32[4]; }
> >  #define sse128_lo(x)	({ __sse128_u t; t.vec = x; t.as_u64[0]; })
