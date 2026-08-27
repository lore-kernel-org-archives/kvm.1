Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893441A92C
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840251; cv=none; b=PuMKqyX4ptuHRIWrft2mxjK8x++Ib5mAkl/lPfA6pSM97Oq5t2WlZqE8mvZrj26EZRRTi+WflJJfXcreRSBQWHQq4op+gwego/Uj8UryJzj7tkve6arl8oIqJCmTBlYNexTYNJJqKY21cbfDhJMTGTqxKoLB+tVQPwNE3lg9ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840251; c=relaxed/simple;
	bh=CzGD0M+GV0Z2XyN3jEMf9PGYCT7WsEp7DuhwxBrrJDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXMRmHMH3V1YzNeQyZMy+eSpYho0zG6b6dvCogRLNXaP2qvZza/o56i5JAZknDoUBz2H/SR2aevxahvHtYyzlgB1kPC/Bn+Q2QUJDPf9v4iMCHWYtpD7B/4rT1jpKqd3xXMbWY7SKJpc8J+z5GUlqVk3HTq8wL8xNVSNlwY7liM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3/RNop4; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3/RNop4"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so30028345ad.3
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787840249; x=1788445049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWmnW83IzTswbxgz8o7s09c8o1T6+xe+Q9kAf0B9pfI=;
        b=j3/RNop4MCQP0J85W3PCsU2g1ToDWiDXy2T1v7QyAaM7udKPv4s3PRn4ukpuXtMost
         7Ih1VXkzZn+SA5nTopxzpdV5wzrS9ihPzHkWwiwp6day+U6LS/6IjTaW96YExMVCohHu
         jDhRDcx7kj5K75hFhQlxxCB3WGGo6NyJPJ2hW/zo5lbSrueB9a3VWSX8WXXr1YF09p5p
         o1O1rpv2JXPAtqFg0d1u9Phx0aHPFrthubME/liaz1rgxoR7CFNS03yd7GXCQMWRHTrL
         WBrXK7c2kYV/wDSllwJK336sSPyqoRXH+qCS/q06dqCH7ok3HPJuiMoxB/BEOk6hDcv0
         OSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787840249; x=1788445049;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWmnW83IzTswbxgz8o7s09c8o1T6+xe+Q9kAf0B9pfI=;
        b=UEntbv9nJrXisVeFgK1rOpvvEVnoPuAcNpOJ5uVDGx1nxMoqQL1sLaARURwt4qLQxt
         dOS8BwelfRC5AoPt1xKXlGxmzycQrU63ob8ne9T6QbXdK5W5FHV+xKVVKUTxPV1QyH5o
         +lE3rCeygUN71no96eWMrsa5+lc0SsKas06H7eq7r/pBx+cd6Sc2qv/j6ZOLFCDggmoU
         XU7yxzk76pia9yCE5CvMtvnQUCUn6YuKyHPqPADhjg4XswY52oqpzcXZdlPzmX7rV9pW
         RnCmvD7YpRvwCKa5wGdBS09FOZiBs3LqkbQi2IDvi66cgcs+i+GKGIkQIH5yrMjqg7zp
         4dMw==
X-Forwarded-Encrypted: i=1; AHgh+RpAH5sDnh8UFOT1QP4/CBpSsnNJ0u1EzfixDNDOi0/aNPqUMDAcs31bHFiMVIbfI2/8gbg=@vger.kernel.org
X-Gm-Message-State: AFuF++nuAtxbyh8Ar7qYEljgyWSuy/FvM5qdBHd4P9+4+snOk8sl9WQq
	uajGbpcoUOdlA+O48Sba/gJbKO1oOhZEX8Jvq81qeNZjD+mS+s3lfDqghgeSD6GMMt1yS2xKsoj
	UvE+5Aw==
X-Received: from plih4.prod.google.com ([2002:a17:903:37c4:b0:2cf:afd2:6506])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf4c:b0:2d6:f9e2:af7f
 with SMTP id d9443c01a7336-2d707a3485fmr332494315ad.1.1787840248482; Thu, 27
 Aug 2026 07:17:28 -0700 (PDT)
Date: Thu, 27 Aug 2026 07:17:27 -0700
In-Reply-To: <d0d318a4-3f27-40dd-b089-2dd2638e8c53@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com> <20260826171246.777729-5-seanjc@google.com>
 <d0d318a4-3f27-40dd-b089-2dd2638e8c53@intel.com>
Message-ID: <apBG9wO5VeWKur9J@google.com>
Subject: Re: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Xiaoyao Li wrote:
> On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> > index 4b1d46eafd0f..ff4f6a2b6402 100644
> > --- a/arch/x86/kvm/vmx/common.h
> > +++ b/arch/x86/kvm/vmx/common.h
> > @@ -170,8 +170,8 @@ static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
> >    * Post an interrupt to a vCPU's PIR and trigger the vCPU to process the
> >    * interrupt if necessary.
> >    */
> > -static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
> > -						  struct pi_desc *pi_desc, int vector)
> > +static inline void __vt_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
> > +						 struct pi_desc *pi_desc, int vector)
> 
> Nit: Maybe we can just name it vt_deliver_posted_interrupt() without
> underscore since no collide with vmx_deliver_posted_interrupt() anymore?
> 
> But it's OK to keep the underscore to indicate it's an common inner helper.

Yeah, I went through pretty much the exact same sequence of thoughts.  I'll keep
the underscores unless someone feels strongly that they do more harm than good.
They're a bit odd, here and in the EPT violation handler, but I do think it helps
communicate/capture that VMX/TDX-specific code needs to run before/after invoking
the inner helper.
