Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4A470456
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932428; cv=none; b=LVNOuFr3Kqf+eHqmzAyQGZJTnLCPuQ/rmnxIMw3tpbJfmhWacNJ2IMZuL8ZJ6ilM6k3XNME3p1p/VrGKlQaYQWA6/NALdfnf8UOAO3h0bdea04TNNQ4p8JCdyvZogEzWK3pCHdVbUQvs5ujAnSJBcxskMTn5ce1yIUgseNB9Xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932428; c=relaxed/simple;
	bh=DOL4k2TlaRP9CsqcxlMaiuFf3pag8tNBE/QuGTtVe1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iymX5JJSdOyqFwj2eXS5scLGdRjCAdoAVWOIqQTb4ALiAD+sLSfJ7STI5U+5ZKZTEouYzfdLrRfuagTpUuIDDd44E5Qe1ypC/lsUXO5Qsltn3GssoqnVYFEBl8yIt9Hzq8PMhF53ATIcUcAlkhSxpVtQoeOKeqnu+LkHVrc8aiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9mylHFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9mylHFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630461F00893;
	Fri,  2 Oct 2026 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932427;
	bh=6uGr1e8RSte6V7pThGS8/F/ksvlZ7Tqtk7oiIwQDtrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9mylHFXtgpfItUKHy2+LZpCNp3rDd+8vzfcHHAzIsZV90O0E1BRN00FImJef1XGs
	 2vCNtdTG+kYMInW3mq5n1YXvdD6Nn+ehFAU3hd8eYiEpQZ5h/4TNyLUvmUBkoQhRVr
	 fsqd2Z3O1gVRHqmgtMyKoWVp7eEb7wr9WGEfs7Yc6EbOOwygaTsdl+PSE38WBilKp1
	 ncqkHpfkZ0J8yYB5GAHvioMFFnahntkJqpbCATCSUaqyS9mBkp3RZjq5DUTNqzCu2r
	 MPVcqLrQBjKeYSA2rRLJpCB77aGyfpP0R6emQbncCSlHXk1Drvfm71bhk+qgorWPQn
	 /npcdWxmcKTfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001202234.3794060-6-seanjc@google.com>
References: <20261001202234.3794060-1-seanjc@google.com>
 <20261001202234.3794060-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:47 +0000
Message-Id: <20261002091347.630461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: x86/mmu: Kernel panic via NULL pointer dereference in gfn=
_to_rmap() during VM destruction
--

commit 51cc08e54e96c8c842b1348871cdf24648cdd20a
Author: Sean Christopherson <seanjc@google.com>

KVM: Destroy memslots immediately after mmu_notifiers are unregistered

This commit installs dummy, empty memslots immediately after unregistering
KVM's mmu_notifier during VM destruction. It aims to harden against
accessing memory from the wrong address space when tearing down a VM.

> Instally dummy, empty memslots immediately after unregistering KVM's

This isn't a bug, but there is a typo (Instally) here.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f368240aa1cdd..770a2c3bd4458 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -1302,12 +1321,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm->mn_active_invalidate_count =3D 0;
>  	else
>  		WARN_ON(kvm->mmu_invalidate_in_progress);
> +	kvm_destroy_memslots(kvm);
> +
>  	kvm_arch_destroy_vm(kvm);

[Severity: Critical]
Does calling kvm_destroy_memslots() before kvm_arch_destroy_vm() risk a NULL
pointer dereference?

If a user creates a VM, maps memory into it (creating leaf SPTEs),
and closes the VM file descriptor without terminating the process
(mm_users remains > 0), mmu_notifier_unregister() is called.

However, it does not invoke the release callback because the process's
mm is still alive.

As a result, kvm_arch_flush_shadow_all() is skipped and shadow pages
remain intact.

Next, kvm_destroy_memslots() replaces the active memslots with
kvm_empty_memslots.

Then, kvm_arch_destroy_vm() tears down the vCPUs via
kvm_destroy_vcpus(), calling kvm_mmu_unload(), which recursively zaps
the remaining shadow pages.

When leaf SPTEs are dropped, rmap_remove() looks up the memslot for
the GFN:

arch/x86/kvm/mmu/mmu.c:rmap_remove() {
    ...
    slot =3D __gfn_to_memslot(slots, gfn);
    rmap_head =3D gfn_to_rmap(gfn, sp->role.level, slot);
    ...
}

Since the memslots are now empty, __gfn_to_memslot() returns NULL,
which is then unconditionally dereferenced by gfn_to_rmap():

arch/x86/kvm/mmu/mmu.c:gfn_to_rmap() {
    ...
    idx =3D gfn_to_index(gfn, slot->base_gfn, level);
    return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
}

Could this lead to a host kernel panic during VM destruction?

>  	kvm_destroy_devices(kvm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202234.3794=
060-1-seanjc@google.com?part=3D5
