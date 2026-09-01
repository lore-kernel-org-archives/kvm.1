Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE440BCDF
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303068; cv=none; b=tp0bjl5d1fcgE+4FirSHvjrSaku0ZNsZ7Aiosoo/O2hlhf2FgE9LmbuU0LZNUbIbZ0feKTIoy+WpvL1gh0SJOiILtZ4xzWCAhpcqH2Tu/H8ecqwtJRGoT4qj5Ejiclxr5dJVfTm0EOeu7Pse30Bir9YJmpftY4/pGHOteDgZBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303068; c=relaxed/simple;
	bh=pOEYibe3mwsw1wifNGruL3Eh+txznin4GWEktrs9o/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtYfq5PPixtoLf/EFcwMU+r3o1+5hltYOsOKXd3tY1AHKmLLeuWoP1+GW/cquuCDaMpNwz3PT8j5Je0Ky/WSzwqpoz4o7PFf6nTnevL6cbH3i5jo2n4h3DTUlU5faiY5c6CUQ8wl1jz16+lbz3ilTeaIgabDVVioYHDbzFKJdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIBdycxg; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIBdycxg"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85599cf98e5so674500b3a.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788303066; x=1788907866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CyjsuaiM3cxUtm6fL7D4dZzUePgQ+dg4iTlfcvKm+Nk=;
        b=JIBdycxgix4BMVzpVhZQ/jgMUg5Fkqv8Neawq5Kt9csrXnrD++rQJOJ0sOa/gZGisF
         Tt8KQl+S0Y4bhaOnl7j5uek+1Y6Rhre67yL30/7OLac5CSAdB49x+l8Cea8XgtDU0v/i
         7GiTM9IUZ3B12viNs6FOOQFnoYsF0srT8HcFdPCwGfrtxQY0t+ZG1ooRXr9RQPcVth+6
         xf79wJ9N181jFoUumUjHG7alRPG1YMlm8XX4Xu6KHEgijbQ6Z804huy/ucFvCL8qwUr5
         deGE4pKpCAFuQZFhPl0dmWJ8QEssVKosGK0fBSlrqMwtEJJ/X5hGF/kqocEG4YN0jfWF
         Spxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303066; x=1788907866;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyjsuaiM3cxUtm6fL7D4dZzUePgQ+dg4iTlfcvKm+Nk=;
        b=odhGdMN2OY5HMMlbTd9JCMShcOv9qnQPa6d1iOpb0KTc+NWwoR9V/sdMCi4WmhwyNM
         xJ0sTjF2RxJm2jjRd2FTFg/a4j60oniDLAHddHFykASFRJIMI6ciDpZ50QLNiO+N82a2
         UxtokziYqOfrVFLwsxITCX5dH8JC71SIBTQdn1c4ps58KY+NnY2MfATm+kaLPKKxFhOU
         4ru/g/HZNDDz6tyFubK1JDR9SIoTI965/QE73abZ6e7CSbPVbf1U7SK6oKO01ZkoZFqm
         p7FTw1v8pfCqgdYN9vEKXrzEtDScZz5c45kQNa/8/dUBto5ko2ZiQ01dJZMOFD6I13sH
         o3kg==
X-Forwarded-Encrypted: i=1; AKwUvBwY9F4BeILy7+uE5VivoB2EwMMTOzt4n1HRZXVJiD9sSGBlVz+V4OJOfjBrgLqPL8RvM24=@vger.kernel.org
X-Gm-Message-State: AFuF++mayGH4oCcRSeW/kcHOY6zx6AJgC3ALn8vD2j1s5R1FdguKZ1uc
	hJvnabdMxMRvt9imaTT9kS+Y9uWiEkFHuBynTKgDzebGWEhx6OEiwA5bKqQCGFAJ99ffc8xti8H
	3txRwYA==
X-Received: from plhd17.prod.google.com ([2002:a17:903:2311:b0:2d6:f308:c74a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b87:b0:2d8:d4d0:792f
 with SMTP id d9443c01a7336-2daec7571c1mr7978855ad.19.1788303065982; Tue, 01
 Sep 2026 15:51:05 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:51:05 -0700
In-Reply-To: <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop> <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
 <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop> <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
 <apcjs83XSU4Eb9hm@google.com> <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
Message-ID: <apdW2edsT_ZKfuUR@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Jerome Glisse <jglisse@redhat.com>, Christian Koenig <christian.koenig@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026, Paul E. McKenney wrote:
> On Tue, Sep 01, 2026 at 12:12:51PM -0700, Sean Christopherson wrote:
> > On Tue, Sep 01, 2026, David Woodhouse wrote:
> > > On Mon, 2026-08-31 at 17:58 -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> > > >=20
> > > >=20
> > > > > =C2=A0 * 23f10e07aba3 srcu: Add try_synchronize_srcu() for caller=
s which can prove readers absent
> > > >=20
> > > > I do not intend to provide a separate API for this given the possib=
ility
> > > > of indefinite postponement.
> > >=20
> > > Makes sense. In that case, calling it internally from the 'right'
> > > places becomes important, as the callers who care can't do so for
> > > themselves.
> > >=20
> > > We discussed the fact that synchronize_srcu_expedited() will also wan=
t
> > > to use the same fast path.
> > >=20
> > > I'm also looking back to Sean's call_srcu_expedited() patch from Marc=
h:
> > > https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.co=
m/
> > >=20
> > >=20
> > > | Due to differences in how VMMs manage guest devices, and in the
> > > | architecture being emulated by userspace, some updates trigger call=
_srcu()
> > > | with concurrent readers (i.e. while the VM is active), while others=
 occur
> > > | without readers, e.g. when configuring devices during a pre-boot se=
tup.
> > > | For the later case (no concurrent readers), using the vanilla call_=
srcu()
> > > | is problematic, as it can kick off a normal grace period (totally f=
ine for
> > > | freeing the object) and effectively transfer the non-expedited grac=
e period
> > > | to the upcoming synchronize_srcu_expedited().
> > >=20
> > > So the offending path uses call_srcu() and triggers a normal GP, whil=
e
> > > the victim calls synchronize_srcu_expedited() and gets stuck behind
> > > that non-expedited GP.
> > >=20
> > > Sean, if the victim is the "no concurrent readers" code path, as you
> > > said above, do you think the fast path in the victim should suffice,
> > > without the cost of an expedited GP for every bus registration?
> >=20
> > IIUC, you're asking if being able to use try_synchronize_srcu() for the=
 fast/happy
> > of synchronize_srcu_expedited() (i.e. for kvm_swap_active_memslots()())=
, even if
> > there's an in-flight GP, would suffice for a fix of the regression intr=
oduced by
> > commit 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_regis=
ter_dev()").
> >=20
> > If my understanding is correct, then yes, that should work, and presuma=
bly would
> > be a notable improvement overall.
>=20
> Then we could abandon synchronize_rcu_atomic()?  That would not be a
> bad thing from my perspective.
>=20
> Just to be sure, please note that synchronize_rcu_expedited() can and
> sometimes does sleep in order to avoid odd corner cases that could
> otherwise pointlessly monopolize a CPU.

I think one (or both) of us is confused.  I thought David was asking if we =
could
avoiding adding call_srcu_expedited(), because the proposed try_synchronize=
_srcu()
would fix a regression related to KVM's use of synchronize_srcu_expedited()=
.

I don't think that has anything to do with non-sleepable RCU?  Or is there =
a
separate discussion and/or implicitations I don't understand?
