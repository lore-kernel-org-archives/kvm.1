Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77112318EC9
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235867; cv=none; b=YJk2OYay+fQOm/05IZnWJXiaHKNuV6EHE8OZvtfHTPaj1FetiZquNSxArUzC6q6O9cC4z2Cn+iq09+iwVQ6rVSTzuQOUou59UsUeELOXImq3H/3BIiYGhNDeZDhVdu1OXnGEWOhFlgABYrWzd3aohJomfBATarA4AG0kLWcW0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235867; c=relaxed/simple;
	bh=/ZCHNQR0K/KHtlF/tI4c3P2/31qh0EwZ5OC2MqCjQzo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bE1BhmYuHK9wDLfwjNPCqJMyJ4f2mh07FDnv7MMgo9yTAJAXVhSC4fLzWYv9eYnKHgeoxUjoy3ksG+WbXKm0FmDt64Ff1qx2fnawLUNmBVoayZsxygKvu3FNd+WxGKHYAI1GBbPGHPYrpgyOqoAAiYkqM6XHXJR+3dNccf7R/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipioCNx5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipioCNx5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c73939e0314so3378068a12.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773235866; x=1773840666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZLhg+7nDQkz8+/rpm0J7Hm6SsaOjD5Jd9IV860eNcY=;
        b=ipioCNx5IgOM1fQBuQHAJ0oQ66Ds/02ZYFnsR5erXlHAtMqmkzI5UFJnSTpO4w165E
         dQewrLI70BjNRkUp/oamvLZDIIgwwxTwDHq+BT6/MCddm+f4Xx43aF0ZQNdyniITyGlM
         wKeKS1Mrfy2bsXzaJC3bXirRBXIrvnjbijDBGz7ofeEFrCmQ2gsJ4X4Eyz13WjOCPH3L
         JQJSZlSLtBaPBn5peQUQJEoAM57u+UrMEIpz/qkHSA7s6V9qoDUB6J4kD9U5u2/92DAA
         pu7U1vlRrGpySP2+F9GI6QywSd0Kx36D65Ed726HosKZvPrKeCtpMRfB2CrsZ0IWxjlR
         zdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235866; x=1773840666;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GZLhg+7nDQkz8+/rpm0J7Hm6SsaOjD5Jd9IV860eNcY=;
        b=Vacauj5hTzLosLvRCyPfQgDkc+GtI07tQwxVikJQ5RNjjM3m5EzPJcDU0oaJC6Wxt3
         7lcueDi5eUwzgBiTiMBXluSGGW9bngLJmYJbX9ABaOW7sFsetFsvRsa58juf9DcbUr0K
         F2l2DNF+2quHczFfHozLSRk3x9Ol/NvqAJ0eRe6JGShdZVKPExPZoQXEVWaflLxzv4wC
         ahdHaAu3K+47bw93S2GlRfELG5flJyrmPBEHCQqHTtLQwH4DHl8K/awuJEWfuxrkbkDc
         QNDkiP7AaoIVRmQr/8L4IMIP67YrkgFXVaBaxOJucxEoVel3cu3sKx7ZQwgxxMJGJbK+
         z0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQTzvy3x5+F7oL9JpiKdir46/qNhpIJp2aL4PaVogvFI+nhtAG+CEE85Q7Kf1dEx37Lyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6N7vWWcDgaHxtYIQ7gz2xpB7g6CJozF5BG2Higk+puGzNCexA
	ZRntD5l8abDB/HAoIV8Ew3IhldsY/jrYzuGym1VsUbbIrB1Hz0k5xnOpnKlAfJQgh/wTH2UzlNK
	sVXJxlw==
X-Received: from pgjc17.prod.google.com ([2002:a63:d151:0:b0:c70:ab5b:1db6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a94:b0:398:9bb1:ad07
 with SMTP id adf61e73a8af0-398c5f3d48cmr2534716637.22.1773235865707; Wed, 11
 Mar 2026 06:31:05 -0700 (PDT)
Date: Wed, 11 Mar 2026 06:31:03 -0700
In-Reply-To: <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <20260311003346.2626238-5-seanjc@google.com>
 <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com>
Message-ID: <abFulxXuRziXj039@google.com>
Subject: Re: [PATCH 4/7] KVM: x86: Add wrapper APIs to reset dirty/available
 register masks
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> On Tue, Mar 10, 2026 at 5:34=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Add wrappers for setting regs_{avail,dirty} in anticipation of turning =
the
> > fields into proper bitmaps, at which point direct writes won't work so
> > well.
> >
> > Deliberately leave the initialization in kvm_arch_vcpu_create() as-is,
> > because the regs_avail logic in particular is special in that it's the =
one
> > and only place where KVM marks eagerly synchronized registers as availa=
ble.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/kvm_cache_regs.h | 19 +++++++++++++++++++
> >  arch/x86/kvm/svm/svm.c        |  4 ++--
> >  arch/x86/kvm/vmx/nested.c     |  4 ++--
> >  arch/x86/kvm/vmx/tdx.c        |  2 +-
> >  arch/x86/kvm/vmx/vmx.c        |  4 ++--
> >  5 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_reg=
s.h
> > index ac1f9867a234..94e31cf38cb8 100644
> > --- a/arch/x86/kvm/kvm_cache_regs.h
> > +++ b/arch/x86/kvm/kvm_cache_regs.h
> > @@ -105,6 +105,25 @@ static __always_inline bool kvm_register_test_and_=
mark_available(struct kvm_vcpu
> >         return arch___test_and_set_bit(reg, (unsigned long *)&vcpu->arc=
h.regs_avail);
> >  }
> >
> > +static __always_inline void kvm_reset_available_registers(struct kvm_v=
cpu *vcpu,
> > +                                                         u32 available=
_mask)
>=20
> Not closely following this series and don't know this code well, but
> this API is very confusing for me tbh. Especially in comparison with
> kvm_reset_dirty_registers().
>=20
> Maybe rename this to kvm_clear_available_registers(), and pass in a
> "clear_mask", then reverse the polarity:
>=20
> vcpu->arch.regs_avail &=3D ~clear_mask;

Oh, yeah, I can do something like that.  I originally misread the TDX code =
and
thought it was explicitly setting regs_avail, and so came up with a roundab=
out
name.  I didn't revisit the naming or the polarity of the param once I real=
ized
all callers could use the same scheme.

No small part of me is tempted to turn it into a straigh "set" though, unle=
ss I'm
missing something, the whole &=3D business is an implementation quirk.

> Most callers are already passing in an inverse of a mask, so might as
> well pass the mask as-is and invert it here, and it helps make the
> name clear, we're passing in a bitmask to clear from regs_avail.
