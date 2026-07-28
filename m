Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7C23EA83
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199921; cv=none; b=NIvlJzCvcHgwgXiqID6Ig/KdthTpled6gmeyz7CxOI85VB8ZNu0eNNlUgDHGxY+jB2+C6mSSJzhFU/+qVZdKASZ0QU515Dv3uQYvBUyFBnyRH9IKwbIKZHuYYPhJIXngyDZlzyeEtWqDHLdsEequ5tmYXgmSGXUg7uTWI42xKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199921; c=relaxed/simple;
	bh=f4H3IH81xz+uOCdrbsf7SRi0ExkOj3mz9Ecxb6nQTsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RMJ+qTGd6LcRwlcLhiwNpRfCGJgTzKxaM23CGNhkm2S+DMKFrdSdA/rQ27z2pTe2W8fOFDkW0nywFupP7dABvjxrn0hw7DeLeKFxNCDCL2aRFhEnoy/KoFCyTIDbs6zSWNEhg23tulhqTxPe0hU8KZF8wMZO91RVNogT8KRZkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svmCO/hg; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svmCO/hg"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so90729055ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199920; x=1785804720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GQi7x436nDykBGBr3THdmSxZ/qUpCFOrJDr01TocQQI=;
        b=svmCO/hgcWGDPCkMI7bBY0J79vrJjcH51C393MSQImOG93bYozgXpz3EJuRdc+MFSb
         IoD99nn3UTdrJ0jEEx64f82yToPdT35TMbW31Lj3O7RnzCIlwy0CgjACYYtgO7HKzs8f
         qJrg/RcYP7T1eGxtAOPXe9Ay00ask67aUZXxwompFK/ofZh3UKF1UZ5nnvsIUum3ynW+
         9qrBWzi4lhAtBEGflUbGFGiDwkz1jx9yUpceylV/GtDA5BjwLYr8LzVrxhw3HzPufCqv
         Tver2Rzm07sNPQi1hW+DbpOVdGqLaA4tkd5nuVh8Tkldc7I5bVF/FDwOeb/2ziYsEe8J
         e4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199920; x=1785804720;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQi7x436nDykBGBr3THdmSxZ/qUpCFOrJDr01TocQQI=;
        b=E+V28OLkBci83yAGFGcx/eIlD7uXsebZfQ9SXFibUC2CoVOA67pbEXgL3BZ2tao+da
         seFTIFb8iEybi4t9AkLiMvUkOBj9nhDt4sYB29kmlu8oFYKnTyBuVXqO/qR+nfRBefpx
         9ewxWEAc4nBd1VIPJA771jUjpVd1mgMZ9r32Vft/2C+mdfJthn0UX6oaS/1IX/Ef93uR
         Y9QTXfzQ5J+47t9tLiY+IDyaGEZn88OwsRVok1Lux8jsM9r6IHN87lvfvE7jy2vuz8+8
         hpYNau6K9KIn6ruZp8C9q/dowLYy4wW3oL/IWJLg77bO1iLvan7gDeNPFxORHZRyk3Ak
         8r3A==
X-Forwarded-Encrypted: i=1; AHgh+Ro9G1sKvUaBfLZrsOUuXza5E/6rctQAY+aGvmv7SkCiqWOb4CpCB7TNt4kLb9y/PEyvphM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodcynUBPbqHk5mWUS/jx7eyLUOMj1QtCtN6Z/vRgMXCeRY05L
	b4+VMwYqG466l5zrzH49YmvZfAGR0+k8Qxjwhyu9EEBvJeaw101fbjsGpUS8fnFDxAehLUmdhbn
	MaPTeLg==
X-Received: from plig13.prod.google.com ([2002:a17:903:458d:b0:2cc:ed0e:f302])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce11:b0:2c9:e5ff:995d
 with SMTP id d9443c01a7336-2d015f01e44mr1928135ad.31.1785199919741; Mon, 27
 Jul 2026 17:51:59 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:51:59 -0700
In-Reply-To: <b38f67187d3312c4bf2c9eddf89e14e8b10573d6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703212145.343527-1-dwmw2@infradead.org> <20260703212145.343527-16-dwmw2@infradead.org>
 <amPYq48J9TPbmFNl@google.com> <b38f67187d3312c4bf2c9eddf89e14e8b10573d6.camel@infradead.org>
Message-ID: <amf9L65ZlPOqJm7A@google.com>
Subject: Re: [PATCH v6 15/36] KVM: x86: Fix compute_guest_tsc() to handle
 negative time deltas
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026, David Woodhouse wrote:
> On Fri, 2026-07-24 at 14:27 -0700, Sean Christopherson wrote:
> > On Fri, Jul 03, 2026, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >=20
> > > The compute_guest_tsc() function computes the guest TSC at a given
> > > kernel_ns timestamp. When the master clock reference point
> > > (master_kernel_ns) is earlier than vcpu->arch.this_tsc_nsec, the delt=
a
> > > is negative. Since pvclock_scale_delta() takes a u64, the negative
> > > value wraps to a huge positive number, producing a wildly wrong resul=
t.
> > >=20
> > > Handle negative deltas explicitly by negating the delta, scaling it,
> > > and subtracting from this_tsc_write.
> >=20
> > Does this need=20
> >=20
> > =C2=A0 Cc: stable@vger.kernel.org
> >=20
> > or is this a "technically a bug fix, but can't happen in practice" sort=
 of thing?
>=20
> Honestly, there's so much hosed in kvmclock that we could debate a
> cc:stable for half of this series. I'm not doing *any* of this to
> actually add new features. For this one I'm not sure it's reachable in
> practice; I think I did it mostly to shut Sashiko up.

Heh, in that case, throw a blurb in the changelog stating as much.  Knowing=
 that
a bug is likely unreachable in practice is helpful, e.g. in the super unlik=
ely
case that this change breaks someone.

> I think even in the KVM_SET_CLOCK_GUEST it can't trigger, although I
> have fantasies about changing the way KVM_SET_CLOCK_GUEST works to fix
> that final =C2=B11ns imprecision (which requires separate work on the
> timekeeping core), that *might* trigger the negative delta here...


