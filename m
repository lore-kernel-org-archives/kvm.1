Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8E41DE04
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489087; cv=none; b=VhdxEhMrIkGbgHehPgE8wW/5mJIMUir8yemNndZJQ+C/J5OFgE+IYbkz4RO3vCggaLwt6//OfYiSoeRKXmJV52rABDu4AkEq5ruJrpkagSjvEcIhEeTPZn5ZO0ixg6+vz6eBWHz/4HNNsv+Em8mETZzyCF312bGXv9Vi/ye1zgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489087; c=relaxed/simple;
	bh=HgHvOCxjxAKo1KYeiWhZk6fIUQpt9oKnV2zvDdq7/kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9SPL/xbosML/tVwG7Bu8GPvgxctNkXGIIfMxh8/DdqYPMSoRTb0dzjUMmkO9lOMBgWt1t6f64X3cWcbF0bdr7uTI+u6QrasL6H2bB/PdI2er5ba+xB8sTAjQW+terv/7zyXBrAlrSCL4chPyFo9P7A1+dFobxf50LTwepXFN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdsHXRep; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdsHXRep"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84fa3b14ed2so245029b3a.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786489085; x=1787093885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cEzv9TziceYkcHbMHh7lHIVizJF1nhviTwKFOEAR9lQ=;
        b=OdsHXRepQi5HEYXdMis0AZb1N1IQH0YBjbapqsImWlv7tPy9tbiCJ2J5gv+2J08Rjc
         8xjpO5KN45Wzk3PvICD5ouwcn4vMXhd2mkqgSOdS3Kri/ZK60xmFfMak4OPB46ZIWrIx
         D1fR+jhyUBeyNaIXJdTlALGTmLnDxGllrZ1o8cNynap2KR+OQV7q8GQjnujz2Va8dxe7
         +KhdHJHocMg2xnXiHGu5HRcufuKJl5Ta1OJYGUgQPlc9qmt8wgQLrEMYLtjKsRjkL7qP
         MdH6x0Piv/ql86PEKOWgupbD3amWLTcKpztMoal16Amm/75iXvdM+Pt4SOIapQOf+Flx
         oRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786489085; x=1787093885;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEzv9TziceYkcHbMHh7lHIVizJF1nhviTwKFOEAR9lQ=;
        b=Cc+l6jUdOoeeOmhdJBj2RBrIpIVt0hRNqddYuycuAgRHbvIgOD1AIq8PLk1ToR1Zxi
         X1Uf59DiEw1AIhO0XgdPAQ44cNPZWWzOS0gi6DbNOOERLyBpvI3H7fh5GkyC8IQvMh4c
         n/zYqGs5sdq4f1fL//XYemmPtRlp4hiMB7v2sM17yiBTHgj0+KcAmZP4J3T6Xo/vHBrV
         w9tH8VjIAvvb/ocNwcJV2pTuY4DhvJyRwpE2eKTYB0PZH3IYo1ZQ/0apVacGlNNJYLrj
         xy2KYfX66fAhfP4mykzE/jG0dzZuXLQLrSYogrjTUJ/5aRERPuQkcly+ZPWK72o/6dH4
         T6nw==
X-Forwarded-Encrypted: i=1; AHgh+RplSDDkCTd0kY1xc2OYyJ1uezwHxBieWy8iTKpbhvoX7LEhGcLeaTRhIOlfPX95bNDH5/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIJCdxzpHFckZ3HkkslzCwOCPrWs8F4ETrr9D0WstWg+a8A4G
	kIqVdgHWw7hCw90Qgw20u2b8iQOTNvRvKNn7Gp+EmCXiEYhUGwD3NLvr/tU9ij8saCRvDSqjKxv
	xJWQXRw==
X-Received: from pfbhc13.prod.google.com ([2002:a05:6a00:650d:b0:84f:4ff1:f767])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:985:b0:847:8be6:2177
 with SMTP id d2e1a72fcca58-84fb54f6116mr651351b3a.34.1786489085251; Tue, 11
 Aug 2026 15:58:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:58:04 -0700
In-Reply-To: <27f2326dc66d6341174c0e510aa518a1297b66ae.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca> <anuAq2s4mtyw4_Ql@google.com>
 <CABgObfYR+vXBuSm3v5jbbZL8vF=XnocFAnjumdShgXBzod-HCQ@mail.gmail.com> <27f2326dc66d6341174c0e510aa518a1297b66ae.camel@infradead.org>
Message-ID: <anuo_OxfvJbQnn71@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, 
	david@kernel.org, mhocko@suse.com, rostedt@goodmis.org, bigeasy@linutronix.de, 
	simona.vetter@ffwll.ch, jglisse@redhat.com, christian.koenig@amd.com, 
	paulmck@kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 22:21 +0200, Paolo Bonzini wrote:
> >=20
> > for_each_present_cpu(cpu)
> > =C2=A0=C2=A0=C2=A0 if (per_cpu(kvm_gpc_reader, cpu) =3D=3D gpc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_set_cpu(cpu, gpc_rea=
ders);
> > __kvm_kick_many_cpus(cpus, wait);
>=20
>=20
> I'm literally sitting here watching you reinvent what SRCU already does.

The problem, for me at least, is that SRCU does this and a _lot_ more.

> Which, again, is *fine* given the behaviour of *these* read-side sections=
.

Well, yeah.  Why use a nailgun to put a nail into the wall to hang a pictur=
e
frame? (other than the indisputable fact that power tools are fun).  SRCU i=
s
fantastic infrastructure, but I genuinely think it's not the right fit here=
,
especially since we'll likely need a different solution for in-guest reader=
s
anyways.

> I get it. RCU is a versatile tool, and in *some* cases the *Sleepable*
> variant of RCU gets used in ways which would cause grace period latencies
> which are thoroughly unacceptable in an MMU notifier callback.
>=20
> But in the specific case of a dedicated kvm->gpc_srcu whose only
> readers are tiny snippets of code that until today were always run with
> rwlock_irqsave? That is *not* Jason's worst-case bugbear. It's fine.

I agree it's more than likely fine for your use case, I'm not convinced it'=
ll be
fine for use cases that heavily overcommit memory, or do NUMA balancing, or=
 (close
your eyes) enable KSM.

E.g. it doesn't take all that much for even a single expedited sync to gene=
rate
a delay of 20ms.
https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.com
