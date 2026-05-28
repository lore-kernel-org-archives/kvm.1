Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EC4028CF
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991301; cv=none; b=KMSQezG4yqMSq/Ht84DvMLUgH6VnY6HagpODEMTcqOP6eVZmPx3M+gzHJ2Kr0g2eLBRJGq24MeJCF2ZzPAkWrALNPHThpCAtUSPqKgh0vM54WPNp64INOcLeHcYhBdvBlmh2JELPQwMVztfvRvI8dDTiZ+tBaxWww45sPzsp9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991301; c=relaxed/simple;
	bh=cfQuRTSFGpuROy8sOY9+zm602caKcY7BSXa/YhoQBlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhjIbn83PXvsZ7FJRKReNSu8MpT+N2W42gFCH0nccmvsjy2/on8U936K9e6o73DzAzY83W4S72Umw6eLbY2JcSrK5JP3aNDA4xrF1OcTCJrHfeGZiyfH/ruTrozn/YJvt9Uetu1yoZGSjRiievh1uRotDww/zv1MH4STxCXyMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3TwIA2M; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3TwIA2M"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso5339074a12.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779991299; x=1780596099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqxIbCcsyYXCWcOhnGOc2rtddu5l+XPaABmEAFuWVho=;
        b=q3TwIA2M4MMoC0KRFoj0WRd3RxgbtomAgjrE1i5xixtAB9u9AhWGzEuJdmaca+oQZ5
         5gCaXPhOlSTPvU6zi97mbx2pUWve8ErzL1s1u9znj4xbjl3TRVlEYnn360jhL6axMCBU
         pkYbzrRywi9bw4nU19yJ9gqKRJimQkvwSzxIeq+CBztvhHaJXjMk7aAg6aTIPJXCCyXv
         T8lyE46Zsv2MbbBdZHwGhqqTknymbBoII/0e2c/0bBAJA8I1jYu51pBUmG6mG/Wm8uGo
         aJxKidmXqtfu0TukC2GrJz/OobCuM3KeFi5o8AwrwgHBH9NEU3kjd8OxMG534CpDeNQX
         G8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991299; x=1780596099;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqxIbCcsyYXCWcOhnGOc2rtddu5l+XPaABmEAFuWVho=;
        b=h/34trU/WEE9RskXkSeFPYNu7PdZTla+vBrUAAJ0ymIp8t+ZMtM59otIrBMJC8ahO/
         1hXwp/sNKerE11KM5sQiAmit/idobwQ9XLGdX2Udk7AV0h9vLbBpqOIgHrMZvksqZOIs
         WAPi3qU/0ig8Hfo9FaGQIaiuYPbVULiLAWl4LslKHq3UVuk/6VG9x4FAhfsvRpiQqIiq
         QeCx4kVPFiVhoBuzIimTTfMCFjl2bIyQA7F5r3BQXFvXnN0hTK4FnqzHrcdXUjoxSu3w
         Ul+eRHl9EXLR0+wdsFePUxuuyHbh6gOMVUfEMxX/hYDiSPxAlIFxH+4Cm6LiJaCY3tbg
         sFOg==
X-Forwarded-Encrypted: i=1; AFNElJ/xSDrvTLPteNf57k8lShrNz/PkHhPiBPgsuKdrS8Txi0faolKTKWAYpCNf/At4g2uOos4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNwR8SJrN216kxPQaf4IhAg4T+akc/vZ7267KDGK8cK1JpfyX
	XyU0yN0JCN/g3NCU7LevdvAGY1LAU5iG7WgP/8k5J+PdYKWCY2sFPAxoe5qSW00R84H6u4RwT51
	2Dnp5Cw==
X-Received: from pfbmx6.prod.google.com ([2002:a05:6a00:6ec6:b0:841:9a22:890c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10ca:b0:83c:928:6e5a
 with SMTP id d2e1a72fcca58-8420bfbf1b5mr92594b3a.13.1779991299023; Thu, 28
 May 2026 11:01:39 -0700 (PDT)
Date: Thu, 28 May 2026 11:01:38 -0700
In-Reply-To: <CAO9r8zNw+iFdZn3uE6p7cCZYVPNeBxAwKhGtKgTErWQ3WL9tWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-16-yosry@kernel.org>
 <aheu-KReRnd7qK1l@google.com> <CAO9r8zNw+iFdZn3uE6p7cCZYVPNeBxAwKhGtKgTErWQ3WL9tWw@mail.gmail.com>
Message-ID: <ahiDAiyU6M2iNJJH@google.com>
Subject: Re: [PATCH v7 15/17] KVM: selftests: Allocate a dedicated guest page
 for x86 L2 guest stack
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Yosry Ahmed wrote:
> On Wed, May 27, 2026 at 7:56=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > Instead of relying on the L1-provided stack for L2, which is usually =
an
> > > array on L1's own stack, allocate a dedicated page of VM memory for t=
he
> > > L2 stack in vcpu_alloc_{vmx/svm}() and use that as L2's RSP in the
> > > VMCS/VMCB instead of the L1-provided value.
> > >
> > > Most L1 guest code does not do anything with the L2 stack other than
> > > stuff it in RSP, so this change is transparent and the L1-provided st=
ack
> > > is silently ignored. The only exception is memstress nested L1 code
> > > which puts the vCPU index on L2's stack, so update this code to use t=
he
> > > newly allocated stack.
> > >
> > > L1-provided stacks will be dropped and cleaned up separately.
> > >
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> >
> > Blech.  This exposed a nasty edge in selftests.  For tests that enable =
TDP, the
> > slots need to be identity mapped *after* allocating SVM/VMX.  Found out=
 the hard
> > way: the gPAT test starting failing.
> >
> > Not worth worrying about right now, just one more wart in selftests tha=
t needs
> > to be cleaned up.
>=20
> I would squash that diff below to the gPAT test rather than this
> patch, but up to you.

Ya, that's the plan.

> Generally speaking, the tdp_identity_map_default_memslots() API sucks.
> It has to be called after all mappings/allocations are done, which is
> soooo user unfriendly and when it breaks it takes time to figure out
> what's going on.
>=20
> I think it should go away. Ideally either:
> (a) When TDP is enabled in the VM, tdp_identity_map_default_memslots()
> is called, and then every time we create a new mapping in the VM we
> mirror it in TDP page tables.
>=20
> (b) Every time we update guest mappings, we mark the TDP page tables
> as "out of sync", and we "resync" on vCPU run as needed.
>=20
> Either way, it is not as straightforward as just calling
> tdp_identity_map_default_memslots(), because the current code reuses
> the same logic as stage-1 mappings, and it fails if there's already a
> PTE. So consecutive calls will fail if they try to map the whole thing
> -- unless we free all TDP page tables first.
>=20
> I don't think I have time to spend on this right now, mainly
> documenting my thoughts, and putting this out here in case you (or
> anyone else) has enough hatred for the API to go do this before I get
> the time to.

We're on the same page, this probably doesn't even crack my Top 10 list of =
things
I want to fix in selftests.  Ok, it's probably in the Top 10, but not the T=
op 5.

I responded on-list mostly to point out the problem in case someone else ha=
ppens
to have in-flight code that will be affected.

