Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016A42E424
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950075; cv=none; b=nyzFRjOjdoFZGeWBfaOwibUfgAkOqE3+ooyPpKIsN5enoIjSxYEIMB4Uo2WIGSaF0Z/Pst+2E93ZL1nZl7HUsw87xlsnMaPsMVWI81pIl+UWrIzJwT5VxgeDo6S9Xi4xUsht6uprBWAXOfFjgCvq/qBhkYfvICf5kVbHFYPB4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950075; c=relaxed/simple;
	bh=Z6vWnLaMKsCMtM5OcetmBwSdEYgF0UFBSui8tqPu5IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxEKLxHbcbnY+ZE3PJaCec0n3mFjJnN1obhM76H7vTe6XpCo3off5i973ar7ZLopkNpl2yg6FhPd/z60qtMnJQkAMWvzMxPjETAmY+YbbNamB/Dk0i5YKlpEzRnBRh2zGivnjDT/kqB/QWnJQ9W/drWhHDXWNCneYI0Qz8c5hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GccoYShw; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GccoYShw"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db8c152622so51288785ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790950073; x=1791554873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WI2zqPTBhJ8GRkUm/HEcbRgAE3CHxE7ecFpI0xjRhAM=;
        b=GccoYShwNicsxmiesJ1PQ8rKmDJmBI0xj+ONvQVQmZbKT9hHqHtIJeZrCzz+riu8r5
         8hZrrf3D7Jq8BVbufMDDYx4IKT21aw9U/bGqg6vIVNlu2/I9X+J4S8pW9uH5DC1SbiHJ
         8OSmO79IovxgVTTOjoJdjoBMs8s3K+IJuAWdepAuwtVxnVQbhK2uME12RlPnXXO4G4o0
         y+i+9uNs0Akl6e8gaYVrP8V4oJPsxfEGPFlFmvXA3o2Myhg/pcMaasd0eNS2JI6HgPrm
         0P6d5FrDA4Cye9PJcOnDvnxbuTn3f0KnFbMkGYQwnnWc/bHxBoUs9tEfunrrcCjBoAvt
         azvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950073; x=1791554873;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WI2zqPTBhJ8GRkUm/HEcbRgAE3CHxE7ecFpI0xjRhAM=;
        b=0jFqKtcrIxIy9CZLtSaPe1WBqielp/bsLbu8Qb398hx8OC4tWPQ0dbWACVpkVA5d0D
         R0FFQYtRIscEOiRQrxgkfOoojukRYEsKwBHngYcbw+Ghv3Gym2Qy3bgudytfsB/5s86a
         7fGVZ5ARi5gCFB1pXLpo8yn075xK7LzRDDw93rrj4CcGnABZliK6+HYP1xCsI367BHfu
         GJ9lhkAu/H/OaOkEtqU7IGsDPeKzliThaeQTI4M1PXrFcYgW2ft01gu54nEuk8dE31d3
         S47b/s6CFTXT5hBCdJD6v/eAM7Ae6GZ/rIUrZIjLBWQsSTThLvHInQgpHmdoogmyNr/0
         mz+A==
X-Gm-Message-State: AFq9FYJQ6xErDHfudUYr2oViua2jm1ht6rts2euHOIyxtLHaTU7A7zJP
	ipipd+5KxvQGR2P1hX9SS9Xb+EkJCpzYBaJcYhwDoMopHCQ1TID/EITUbtYs4Wq9DWRfyU61RSI
	GEGKKyw==
X-Received: from plik12.prod.google.com ([2002:a17:903:384c:b0:2e2:afcd:ce93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d509:b0:2e2:dfe4:adab
 with SMTP id d9443c01a7336-2e49b61597fmr24447645ad.10.1790950072820; Fri, 02
 Oct 2026 07:07:52 -0700 (PDT)
Date: Fri, 2 Oct 2026 07:07:51 -0700
In-Reply-To: <20261002091347.630461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-6-seanjc@google.com>
 <20261002091347.630461F00893@smtp.kernel.org>
Message-ID: <ar-6t9eJExIEEgGh@google.com>
Subject: Re: [PATCH v2 05/10] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] kvm: x86/mmu: Kernel panic via NULL pointer dereference in g=
fn_to_rmap() during VM destruction
> --
>=20
> commit 51cc08e54e96c8c842b1348871cdf24648cdd20a
> Author: Sean Christopherson <seanjc@google.com>
>=20
> KVM: Destroy memslots immediately after mmu_notifiers are unregistered
>=20
> This commit installs dummy, empty memslots immediately after unregisterin=
g
> KVM's mmu_notifier during VM destruction. It aims to harden against
> accessing memory from the wrong address space when tearing down a VM.
>=20
> > Instally dummy, empty memslots immediately after unregistering KVM's
>=20
> This isn't a bug, but there is a typo (Instally) here.
>=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index f368240aa1cdd..770a2c3bd4458 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> [ ... ]
> > @@ -1302,12 +1321,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >  		kvm->mn_active_invalidate_count =3D 0;
> >  	else
> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> > +	kvm_destroy_memslots(kvm);
> > +
> >  	kvm_arch_destroy_vm(kvm);
>=20
> [Severity: Critical]
> Does calling kvm_destroy_memslots() before kvm_arch_destroy_vm() risk a N=
ULL
> pointer dereference?
>=20
> If a user creates a VM, maps memory into it (creating leaf SPTEs),
> and closes the VM file descriptor without terminating the process
> (mm_users remains > 0), mmu_notifier_unregister() is called.
>=20
> However, it does not invoke the release callback because the process's
> mm is still alive.

Ha!  Sashiko: 100, Sean: 1

mmu_notifier_unregister() invokes the subscription's ->release() callback. =
 FWIW,
at one point in the past there was a no_release() variant, but it got dropp=
ed by
commit c96245148c1e ("mm/mmu_notifiers: remove unregister_no_release").

  void mmu_notifier_unregister(struct mmu_notifier *subscription,
			     struct mm_struct *mm)
  {
	BUG_ON(atomic_read(&mm->mm_count) <=3D 0);

	if (!hlist_unhashed(&subscription->hlist)) {
		/*
		 * SRCU here will force exit_mmap to wait for ->release to
		 * finish before freeing the pages.
		 */
		int id;

		id =3D srcu_read_lock(&srcu);
		/*
		 * exit_mmap will block in mmu_notifier_release to guarantee
		 * that ->release is called before freeing the pages.
		 */
		if (subscription->ops->release)
			subscription->ops->release(subscription, mm);   <=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D TAKE THAT SASHIKO
		srcu_read_unlock(&srcu, id);

		spin_lock(&mm->notifier_subscriptions->lock);
		/*
		 * Can not use list_del_rcu() since __mmu_notifier_release
		 * can delete it before we hold the lock.
		 */
		hlist_del_init_rcu(&subscription->hlist);
		spin_unlock(&mm->notifier_subscriptions->lock);
	}

	/*
	 * Wait for any running method to finish, of course including
	 * ->release if it was run by mmu_notifier_release instead of us.
	 */
	synchronize_srcu(&srcu);

	BUG_ON(atomic_read(&mm->mm_count) <=3D 0);

	mmdrop(mm);
  }
  EXPORT_SYMBOL_GPL(mmu_notifier_unregister);

> As a result, kvm_arch_flush_shadow_all() is skipped and shadow pages
> remain intact.
>=20
> Next, kvm_destroy_memslots() replaces the active memslots with
> kvm_empty_memslots.
>=20
> Then, kvm_arch_destroy_vm() tears down the vCPUs via
> kvm_destroy_vcpus(), calling kvm_mmu_unload(), which recursively zaps
> the remaining shadow pages.
>=20
> When leaf SPTEs are dropped, rmap_remove() looks up the memslot for
> the GFN:
>=20
> arch/x86/kvm/mmu/mmu.c:rmap_remove() {
>     ...
>     slot =3D __gfn_to_memslot(slots, gfn);
>     rmap_head =3D gfn_to_rmap(gfn, sp->role.level, slot);
>     ...
> }
>=20
> Since the memslots are now empty, __gfn_to_memslot() returns NULL,
> which is then unconditionally dereferenced by gfn_to_rmap():
>=20
> arch/x86/kvm/mmu/mmu.c:gfn_to_rmap() {
>     ...
>     idx =3D gfn_to_index(gfn, slot->base_gfn, level);
>     return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
> }
>=20
> Could this lead to a host kernel panic during VM destruction?
>=20
> >  	kvm_destroy_devices(kvm);
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202234.37=
94060-1-seanjc@google.com?part=3D5
