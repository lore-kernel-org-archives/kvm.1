Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8D4A0EE0
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289978; cv=none; b=eTPKA3oypSOeYrcZw621oi8J4KMQS7KcqOniFRCF9NRbXZv0RtqwZ8d4sg/yx6ANn/3nV9v7IJ/Hav594qSpYBf48Zg03AheubteJN4wOx96rwv/pvqI/2S5WopbbgksMnwrp2ZQpvtg4irACI/JeIBnGq6Je+u6ZxQ9c7LHFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289978; c=relaxed/simple;
	bh=Kt0LuE28XbF55ehOiA2DPZrjnmRa799DCvT54SE1CAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JciiMtoM5LpiLs3yH7s/TQ+AIiDJGuuKoHRKhep+f0T6BLwut/XLR4NQo+ca0NkF+PIpcgC0C59LSF38uOX5NBqyoXnQ4areYKZ5zsc7jKwONe6LGZfOV28gVjXpOJR+aBlV3L3M1YJljnqSxD5mSa8g/TNhal7I604mS61tCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=No1iT1h2; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="No1iT1h2"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so310950a91.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788289973; x=1788894773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kt0LuE28XbF55ehOiA2DPZrjnmRa799DCvT54SE1CAI=;
        b=No1iT1h2iKaXTQOA9OkWxHG6FhK8w5jL0CJaazPx2MHKHmRIhuWCsP84S1PCM7KTXc
         4nz/xlR27+SzNBL5EH/wZJEJ/Zs0PZC6NyTBGfWhtCLEsdpvzoonPbWSTFmpFaZX9aV0
         2TCXCwRnKAJmYf7LBAZFXuHqmfFBN69SA1GrOah/cc7GkDsmKzgIAKFDr2lrAmGcd8e3
         E69xfyUAl4gUqkIJUa/N8nYZKj/zZB9RErK21w/GEsN4KbigMIPbYbpBjiZ69D5VeNo1
         DizQzZn5Fxr3sOMOSFdwBGf1JLmTPPc1GANfoZrgzSt3NVRetpHENmQxryJq6x7xEs+C
         XwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788289973; x=1788894773;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt0LuE28XbF55ehOiA2DPZrjnmRa799DCvT54SE1CAI=;
        b=s0A04Ov3RXdjOGAFzC4Rb6frBDaNyNinyVzXS0UvhBLI90GFNSQJIKPmHjS4EVmPj2
         pG7ajwpS2px2pkIXD8NeAzkS+dun1XOjutXkXYLX4AMerneKhU0bL4JatrLsj4pw0OfS
         7UApUWQd9i2NUksadJ02bJ+fZu6VbVznIuD+wjl3r6k3rXZWPOPk7dHn1+MeG3e3VBCy
         BnZ85vDWgYuYXz4hPy/kbz32+CYk6g3QpIJFWfn1L3ok63a9AZCOfvFpYsNBfpsJSiBz
         9qaSq8RzNzpL6++xpEAx9EoWfAQGK14LRqW2XJjLaZXHbXx/3E1Rva7lJFrUe7e1FrbG
         L22Q==
X-Forwarded-Encrypted: i=1; AKwUvBxVvY5J+MNo0Xn6O9eQdkQ9dUtMxqzQjwHGbuDOhiVQu7CTkAQg9oKZOjYRb0JW2tl5fRA=@vger.kernel.org
X-Gm-Message-State: AFuF++npkhZr42cyelQ++uMGELknJRBCaBYZcCA8XwFROyQpl4Jjwjq6
	Dlrb91lPkLJQXToOiLRjmxpqqGIxxgK2Txoy/nznhmpaJAnUKeTMZ3C+UMOJABSap8PoG9B4T3F
	IbiQOww==
X-Received: from pjtn13.prod.google.com ([2002:a17:90a:c68d:b0:39a:e7d1:b083])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d06:b0:38e:5964:97a8
 with SMTP id 98e67ed59e1d1-39ae83ec5demr364047a91.16.1788289972383; Tue, 01
 Sep 2026 12:12:52 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:12:51 -0700
In-Reply-To: <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop> <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop> <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
 <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop> <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
Message-ID: <apcjs83XSU4Eb9hm@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: paulmck@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
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

On Tue, Sep 01, 2026, David Woodhouse wrote:
> On Mon, 2026-08-31 at 17:58 -0700, Paul E. McKenney wrote:
> > On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> >=20
> >=20
> > > =C2=A0 * 23f10e07aba3 srcu: Add try_synchronize_srcu() for callers wh=
ich can prove readers absent
> >=20
> > I do not intend to provide a separate API for this given the possibilit=
y
> > of indefinite postponement.
>=20
> Makes sense. In that case, calling it internally from the 'right'
> places becomes important, as the callers who care can't do so for
> themselves.
>=20
> We discussed the fact that synchronize_srcu_expedited() will also want
> to use the same fast path.
>=20
> I'm also looking back to Sean's call_srcu_expedited() patch from March:
> https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.com/
>=20
>=20
> | Due to differences in how VMMs manage guest devices, and in the
> | architecture being emulated by userspace, some updates trigger call_src=
u()
> | with concurrent readers (i.e. while the VM is active), while others occ=
ur
> | without readers, e.g. when configuring devices during a pre-boot setup.
> | For the later case (no concurrent readers), using the vanilla call_srcu=
()
> | is problematic, as it can kick off a normal grace period (totally fine =
for
> | freeing the object) and effectively transfer the non-expedited grace pe=
riod
> | to the upcoming synchronize_srcu_expedited().
>=20
> So the offending path uses call_srcu() and triggers a normal GP, while
> the victim calls synchronize_srcu_expedited() and gets stuck behind
> that non-expedited GP.
>=20
> Sean, if the victim is the "no concurrent readers" code path, as you
> said above, do you think the fast path in the victim should suffice,
> without the cost of an expedited GP for every bus registration?

IIUC, you're asking if being able to use try_synchronize_srcu() for the fas=
t/happy
of synchronize_srcu_expedited() (i.e. for kvm_swap_active_memslots()()), ev=
en if
there's an in-flight GP, would suffice for a fix of the regression introduc=
ed by
commit 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_register_=
dev()").

If my understanding is correct, then yes, that should work, and presumably =
would
be a notable improvement overall.
