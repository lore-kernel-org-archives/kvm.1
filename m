Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311495;
	b=ci1y7GOo0ZchFTaQVs8SXfLFAqwq/ZggVM4r3cc4pSqMfV6pDcjgPOvfo2deq8wvjQeD
	 p4QVatoFt5JaYBqBfyq+m/U74DPG/aTLWODdpgusuLCtrBAaoGTBqBZkFX6dOMJYyzYCc
	 gw8p3BVkX0IFsLdpvJjqCjZuiVgNfxUIXGT/irRYDfit6LmYvoGDL1MlrJaMnp71QdVBL
	 j9ZjworQZX8Zz2BKhPJQU5jJ5ak4NN6MeImnp9fzyu96LCAzRe+Z49YY455OOSqrtVm7N
	 g6FWghVhy5PTIG3cqdUKSFXPF/ex2cpFyA7xQ5OwwzoETIKsfa1IN5Y88XNBaXxMFAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vcjS2XWAO2PVPZ4E8IA6fWD7RE9agLKIkmYjROKzQ6c=;
	b=YRLfKvaDX7Y6u3TCDO/lnm5S0k0ATMltQf/8zAaQDgoYxrNhJP7DFzA8mCx0Hzpxo5pg
	 Oa1BC333h1V3oEcrILH460dld2ArdbWnDynkpmlLzWYvnZsZDcj6sxIgT9TijnwF5Sbps
	 CBkBrk8roAcm4nwCT8rSPhc24+opqzt/mshisfFW+/wJ+Unsqp/kinLFDmH70BeLTWT03
	 4u76iw81SVh1dqiSJABydMloE3fJC5fMkCB49QcenXpAkHTiRVm4GylLmfB67aQBFqJx0
	 jZUxSm2V/rN7FpTIuKOncpQyr1kdiSHpj7tIQPggkzBmGsi+GUZhSxpl1Jb+NDsVm9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EoZYrDRq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CE606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EoZYrDRq
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso4949a12.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311494; cv=none;
        d=google.com; s=arc-20260327;
        b=him8rHsOTqJ9264sDk8I1UNZxfAB26RL0UzfHhh+6zRW391bNrFkMdb8iqtMr7Mi6f
         zUxWbZ7NFj0LW93WOSUUS3yfSTpyTMJHaq1VPM/88ZcG18Sv3phZg2xAQFxNWiUg/jIi
         37h512lw0uJSaNHrppvmy/rlQuqXDyret88rhn7130x4FUqoZQPlbKv6okOfzGJZMHFF
         s8QZ3WSKiG0doy2vJwllMUGN+IZYjJ5EDRjRQVHAOawgAH4AymlzhYT+OZl0J78GCOCA
         9dRsKn0sTQuDNF6WrvteMSGcazn8Vz90E4T2nB3i7HrYK+16Fzh8PucYa5I6g/l9hMlQ
         ZCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcjS2XWAO2PVPZ4E8IA6fWD7RE9agLKIkmYjROKzQ6c=;
        fh=qsyGTynt3jLukymni07/0jCZM/bZ8AcGiZ2jzbueZ7Y=;
        b=gNCt8m8un4QGg6EvPQSicDnx3JdNKV2eoeQ+4NilWbWA4uDIiS6CD6sPlhzPmh+T0V
         6OTNY6YS/D6jkFfL9VTz4xN8bqOeWFfRYKlqw7g12FCnhOqTQNf9EEtfq4kEoYG2V7SB
         lli0UdqW2Q6ENGPmSsV+wRSsZf2pQ/jRfED+aS8qqV0MZBvds/LHm+WAP2HStQgrS+ys
         gJar9Y5ikgFKk7ifMBR4jnhGqmQWakkR6Q4WsH7T/hG6oT4sfSrOmgHvud46pO+6w5dj
         iPGlu5F5zkXjbPNrQlwOyixzVE8Osf9Wr/e6RALN8gunhYCkOPoyVYZNMQKDXNmJs8q6
         Jp7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311494; x=1793916294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcjS2XWAO2PVPZ4E8IA6fWD7RE9agLKIkmYjROKzQ6c=;
        b=EoZYrDRq09IAHfGFnB6PhfFCC8BohHQL3muqXimashHCmHChePNgkWhfxO9y5MpA9Q
         Y/Ry0dNNIBodVgVAZvKmaTm05tvUuLIjs8k515ashbM6WctShEhMk1OOh8+B4xfpDNgW
         S0qWb2UfXumsusqqhYlwb9ewzluD1G/lQhSIDJyX4BcREmyCJzBUacg/A3GSFBa3fdy6
         kHGqSR1gEJzIWieotrGcwpdTnXERAC41+PfmfXz5k6Ugc+2qygD9Mqy82uV2mVMyyJ+A
         38lipn9hFrNT9H/JgkUTQWTvL59P2MzRKm9Ww2Oo1t8S6keL75vN9AVGmi02y+Ler8aJ
         xKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311494; x=1793916294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcjS2XWAO2PVPZ4E8IA6fWD7RE9agLKIkmYjROKzQ6c=;
        b=GFjcwvElCNv30YghynbSt5iMmgAdOOl1Rw8Appwy/aplxzmYeehxpspenu1Fen73Lq
         HGRtjxwljVg4scHQMV/jYlDP20UlfJPApqvDwQPfsEaM0zgX9V7eGZgHwRc/OYlncry/
         1Av9F8GfD+BsqW3YRw7lgzh+h+yLpP3IC9OVI0Rh9CSr/QQds1dpGiQS+OPqvBKqvxZT
         5qvz8R+nFz7gU3+gCfeLfoGVUmznGR2KBe9m08qPpjDJgYI4HW9wNyRD57sQErrfTmsj
         d7hQRP8oO7XozG9e6tPQyKd1NGELfcit95fEwdqq5zaO/RSl4cNsMuorNOspCQ76Cuf2
         bqLQ==
X-Forwarded-Encrypted: i=1; AKwUvByvWfW7U60rJo2WHpiD8i/zCmnj1wy/wB846WMcsAIF63uk1Hu6ta4mukZknc8rTlC7aGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKNmvQs9qHWXkSCxvsrsWJ2iHbJHkSrQZBFbwBVbrhon+0wlnt
	Pqy4onm0PWNKE6+roYrDBmvTZq6XuntaUXZ+aITcRpp4oJXuIGWTJybKyd0oiGGjbKJvSmsK/dB
	QJu3VTmYrMzGbnq5JBypIhYQ01hGst7GRJBXzJMnN
X-Gm-Gg: AYBFou2k425Y8PKdL/1euwbrklUxv4PYbklwbNZTlgfL0mRiCe43LAXK6teMnUb7/ZV
	LiLCJATFx0vxyvko3ikxafdB33ErzKy/RzhEqzfOlxcOBVLK7rCU7qneaBjgsqguFA8dkCEljj6
	BaVbj6n2BKu8SqmOcdFXDoFoyyCm0DHTOx7i1WazO3yiIq43wjK7OJbjQGug8i+UQ1yjb845Lx7
	xBHiuxneFdu0JvS+F9lupDot4rUP6QHPblu5Mh01Nxxk/5CQPKyKEL8i8STPBCBrjwOyS59e7uQ
	LLQx/BfqPa/+wxe4SGW3N1aWWBPJp6bOhX+pGSR2i2kCbYBsQlxETPX422sULNpe7eCbUb9C1TU
	3T4Sezg3GojKkCAiixWs+Nz7zEJuqnYUuAQBu56JLVHGaP6NXXbql//TgxQ==
X-Received: by 2002:aa7:d3ce:0:b0:6b1:c6fc:aba0 with SMTP id
 4fb4d7f45d1cf-6b4b38e3229mr100799a12.7.1793311493406; Thu, 29 Oct 2026
 15:04:53 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029202817.901145-1-jmattson@google.com> <auO4UueaV0mTVzzB@google.com>
 <CALMp9eTKXa9v1TxJMPrE-tSXajwJCErCk=g34dOPJtG057t5mg@mail.gmail.com> <auPAFxXy4ulcK_jq@google.com>
In-Reply-To: <auPAFxXy4ulcK_jq@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 29 Oct 2026 15:04:39 -0700
X-Gm-Features: AclHuK_ENQe2XaR80YT1-r3wPysVO9nAq8MWJ4g7grxHkMKrLjeivCR9yTj8Qmg
Message-ID: <CALMp9eQdtvjQkdgnJ_NTt=2ArdzUtqqzieXLccv9Vb_My5G+fQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Check EFER.SVME before updating MSR_VM_CR
 on guest writes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:52=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 29, 2026, Jim Mattson wrote:
> > On Thu, Oct 29, 2026 at 2:19=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Oct 29, 2026, Jim Mattson wrote:
> > > > (Host- initiated writes are allowed to set any valid MSR_VM_CR bits=
.)
> > >
> > > Eww.  Why?  If we allow this, then we'll end up with the mess where t=
he guest
> > > can't write back the current value (if userspace is being weird).  I =
get that
> > > we want to avoid ordering issues, but there's *already* a required or=
der here,
> > > unless userspace ignores the failure from svm_set_vm_cr() and continu=
es on.
> > >
> > > KVM doesn't advertise the MSR as something to be saved/restored, and =
none of
> > > QEMU, CHV, CrosVM, or our VMM appear to save/restore it.  So why make=
 trouble
> > > for ourselves?
> >
> > OMG! I didn't look any farther than the obviously broken svm_set_vm_cr(=
).
> >
> > It looks like svm->nested.vm_cr_msr controls nothing other than itself.
>
> LOL, nice.
>
> > It's just 5 bits of storage with some weird locking rules, and it
> > resets to 0 on suspend/resume.
> >
> > What is the point of such half-baked support?
>
> More than likely, so that older kernels didn't crash when writing an MSR =
KVM
> didn't emulate. :-(

You're not going to let me get rid of it, are you?
