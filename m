Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE483B38AD
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782514698; cv=none; b=MQ10n96Pd7b1kJO3wSU3Y8vG7lf+B1hUOIkBOaht0uQ7TQc8dKvG2rVrJTCKjVSVmg/QvB6It+w9gIUKsSsdOG2Q6/2qAZbPisCIwIBwW993T6abn6WOt0QjGO4IdkVZmLhUT0/UAV0+pF6+Lwtx+B6NEQiKmB9QbRksIHMR4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782514698; c=relaxed/simple;
	bh=6WHDhyidbCWcfTLInoBD66M/6Dz5q4WpdNIM4v4UFJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gxfCJlEirei+v02WK+Srq/sZyFW6+/jgCpeverCE/TWzZL+HPh58QwScgKFyAcHukmnuie4ICxZdxLwI5vi8SxSzCAFTm35kE3tAdFv3iElSPcp0jX6B8pmFLZ7gqB0CktisdRkOQR973Y5OY+BRzPiQ2lwTMJam2aVQyin3g/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mK/gFY4T; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mK/gFY4T"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e09788d95so1502565a91.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782514695; x=1783119495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9gGwkese4zbw3bCzxMCwFgG5L/K1YadWyARS/3sfc8=;
        b=mK/gFY4TJiClZM8PAc2d+6QlAXALPBZcpzsJ0XcnsH+aCVOpDxhb1AtdOj2Q+e2lI2
         k9rHMSb/7C311MIB7K88m7O4Ih92yKH6dwkNfcmLIlb/7PgEAEqK+Zo2wcdQ7MUNeuYB
         qSrnhFhYtyhzvtHHbhPgo18ftPWfpVGPAVFqfWnBha1iLY8AHtaSlb0aSt56i1vnuA0d
         zltJVn4mIPUItfA66FrVIPeLr5z6ZgB8WYeCezYoQkcJTPsNv65dF76USgZ7oUiPFlQU
         QwCzCXHXdYacVcI3hcKV4CnKFjt9v3ZblFvqI6YLzw49+TMQhpJOE87jLRTdFtYtEFUB
         h/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782514695; x=1783119495;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x9gGwkese4zbw3bCzxMCwFgG5L/K1YadWyARS/3sfc8=;
        b=lZcDOgbqDPSp80g1YSu/SSHRQj/xpNh5Hz26sxFSUZxlIrRPRU/qa9xFasYi8XV2sk
         AJlylQhtr++GWE9cPP4KJKDyDq94m7fsqnXOTL7kdM2KAbq3IzaP1Znd/XNydEyF1SxN
         wdZ9Rh5PU4UkjszRsDY5TUwYhLk7YXcXOSSniYboI6PoT2uT8lTXfUSIye5KKfAZDe25
         nO4LJugZkBI68bBshxNbqmwjqnQ/QHQ0NyKyCjq3ltWnApIAUmNdWJuVoTYCRLkL5mfT
         K2UEpSNFVIcHrw5W7Zy+vEIYVC5mkq1f1axdq+nM5FN5ChXWZAu2qCXSFINMJBNaKhpG
         QPLw==
X-Forwarded-Encrypted: i=1; AHgh+RrjxZv3RmDATV3xnhA03XaCmAlt9pi8QDi4+eKylVpwyU5eHbX6po2JxvwX0BrpOh4Uky8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzw/iytmVXpxImjf9Rbog2pn8QINV/85hFAgQLBKQRW9E+RBM
	MYBT3xGY3Z5t0rcZuJNS3EUSo8/o1Z8nkEGLfMVpdmYvfzMoO7mIxIf3vjHq2u2s2I34XQh6crt
	eA1aCJA==
X-Received: from pjbaz7.prod.google.com ([2002:a17:90b:287:b0:37c:9369:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37d0:b0:37f:9ce1:cdb2
 with SMTP id 98e67ed59e1d1-37f9ce221d5mr1565774a91.32.1782514695286; Fri, 26
 Jun 2026 15:58:15 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:58:14 -0700
In-Reply-To: <e8d802f9f1ca831f99f991567243b5d74578a514.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
 <e8d802f9f1ca831f99f991567243b5d74578a514.camel@infradead.org>
Message-ID: <aj8EBrA_Ygg3mxZT@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, jan.cipa@gooddata.com, 
	jaroslav.pulchart@gooddata.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, David Woodhouse wrote:
> On Thu, 2026-04-09 at 22:22 +0800, Lei Chen wrote:
> >=20
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -5210,8 +5210,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, i=
nt cpu)
> > =C2=A0		 * On a host with synchronized TSC, there is no need to update
> > =C2=A0		 * kvmclock on vcpu->cpu migration
> > =C2=A0		 */
> > -		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D -1)
> > -			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> > +		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu =3D=3D -1) {
> > +			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
> > +				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
> > +			else
> > +				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> > +		}
> > +
> > =C2=A0		if (vcpu->cpu !=3D cpu)
> > =C2=A0			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
> > =C2=A0		vcpu->cpu =3D cpu;
>=20
> I don't like this.

I don't think anyone likes this :-)

> We do the GLOBAL_CLOCK_UPDATE in non-masterclock mode because
> theoretically, a *failure* to do so could cause the guest to observe
> non-monotonicity across vCPUs.
>=20
> With this rate-limiting, we *sometimes* protect against that non-
> monotonicity. Why even bother? Why not just rip it out completely, in
> that case? AIUI the guest should cope with anyway if its
> PVCLOCK_TSC_STABLE_BIT isn't set, and enforce monotonicity for itself
> side in __pvclock_clocksource_read() ?=20

Because we needed a fix somewhat urgently, and I didn't want to risk more b=
reakage
by going with an aggressive change.

> But also, I would *love* to kill non-masterclock mode completely.

That's not feasible until KVM drops support for hardware that, per Linux st=
andards,
isn't _that_ old, is it?

> In this nested case, the L1 TSCs *are* actually in sync; it just don't
> have the +invtsc CPUID to *promise* that they will be.
>=20
> Could we find a way for L1 KVM to use masterclock mode for its nested
> L2 VMs even in this case? Could we make it use PVCLOCK_TSC_STABLE_BIT
> to enable masterclock mode, instead?
>=20
> At at the very least, could we find a way for L1 to trigger the
> GLOBAL_CLOCK_UPDATE only if an *actual* discrepancy in its TSCs is
> found? (Or, if vdso mode is not VDSO_CLOCKMODE_PVCLOCK?)

Or just advertise invtsc?  I appreciate the desire to eliminate mostly-usel=
ess
overhead like this, but at some point doesn't this boil down to "don't mess=
 up
your setup"?
