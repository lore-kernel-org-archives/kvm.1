Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B24156E8
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153552; cv=none; b=EGYwlH2Owkw2EAfHK0KfDuYdW6uIvnaveb4GX/lXxD2jgxH7YNMTjJ2FV0sgRrvpus07Kiczkw6eC5IN/G/oFD5Xf14IIAATAhXGKTzOaEAvQlZYURgQXXRjlDUjG8FV/+9A4V+ED/A/BcEGSrYBLIvCKw+KGxelOUhLMUQfmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153552; c=relaxed/simple;
	bh=l9P087qq8yp+CbrhpA3ocyf994Jx0xeOHeQ2wd/gMfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kT8t2bofF5IXpPVRDni4Pa13bITVPnQEP3DBF7fSLMtl2OrDLqbtKDb3VAEAanibIfMrbWvyVPugyWDwBz2Eu+z1AegMQ+DBT8RGsDynWr5E5jAEPdQnIZLyxNeIQChXLhvoFDG8bJAlEU7RHe6yDTcS6aI463GacasmGWHSztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzDaIrOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzDaIrOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9AA1F000FF;
	Fri, 11 Sep 2026 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153529;
	bh=0Kf8sx2lgAD3E7DyHv88sMWY2QUD8yAKynCxwXRyGcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzDaIrODMZre4fzxhH3Zo8DNJ8NP4xprrU0RezYhjOJQePsYeSqn8cmaqX4wszp5l
	 8ro+vJk4yluOnL67c5sWJl6GUesHk4g/v5WEwSEmlEVFXnyUgXSwyeGc8rpXBT3F+C
	 u8hwkFKFLU0o2HRLVChCM6BIe6Ek3PJu/1PLqvvmbUANOQhCeqAIFphhvpkuYxCBXg
	 U4sHBqBT9nKh18+lnpknkabTxlm5ZsCT+cXjSn71i7QuoyynIZLtYV+xkn5FBJn4Qe
	 Ok070RhahpWRiRHIq9VYaGMNLuuZkyY6E3UJJ2oUxUuPfNXxIboP2aeGG47QIbFZS8
	 ppxyzFsjP1PYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: Bound per-VM GFN materialization in
 KVM_SET_MEMORY_ATTRIBUTES
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Ballesteros" <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911184819.101123-2-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
 <20260911184819.101123-2-davimaba.v@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:05:28 +0000
Message-Id: <20260911190529.2E9AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Recounting materialized entries on every mutation is an O(N) opera=
tion that causes severe CPU exhaustion.
- [High] The arbitrary 128 GiB limit (KVM_MEM_ATTR_MAX_GFNS) introduces a s=
evere functional regression for large confidential VMs.
- [Medium] Iterating the XArray using xas_for_each() without holding rcu_re=
ad_lock() triggers lockdep warnings.

Pre-existing issues:
- [High] The KVM_MEM_ATTR_MAX_GFNS limit check is bypassed when clearing at=
tributes, failing to fix the memory exhaustion DoS.
--

commit 200db6833ee43dd9cdcad914e3c4e7942e9f7e5a
Author: David Ballesteros <davimaba.v@proton.me>
KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES

This commit attempts to fix a memory exhaustion denial of service by
capping the maximum number of materialized memory attribute GFNs per VM.
It introduces a counter for materialized entries and restricts updates
exceeding a hardcoded limit.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -573,6 +573,13 @@ static inline int kvm_vcpu_exiting_guest_mode(struct=
 kvm_vcpu *vcpu)
>  #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
> +/*
> + * Hardening bound: maximum number of GFNs with a materialized entry in
> + * mem_attr_array per VM (~300 MiB of xa_nodes at 2^25).  Without it,
> + * KVM_SET_MEMORY_ATTRIBUTES grows the array without limit (~9.3 bytes of
> + * kernel memory per GFN) on GFNs with no backing memory.
> + */
> +#define KVM_MEM_ATTR_MAX_GFNS	(1UL << 25)

[Severity: High]
Does this limit cause legitimate large enterprise confidential VMs to fail?

A limit of 1UL << 25 pages equates to exactly 128 GiB of memory on systems
using a 4 KiB page size. Since AMD SEV-SNP and Intel TDX VMs routinely requ=
ire
hundreds of gigabytes or even terabytes of private memory, capping the
allowed private memory to 128 GiB per VM seems like a functional regression
that will break existing large setups with -ENOSPC.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2544,6 +2545,33 @@ static bool kvm_pre_set_memory_attributes(struct k=
vm *kvm,
> [ ... ]
> +static unsigned long kvm_count_mem_attr_entries(struct kvm *kvm)
> +{
> +	XA_STATE(xas, &kvm->mem_attr_array, 0);
> +	unsigned long count =3D 0;
> +	void *entry;
> +
> +	xas_for_each(&xas, entry, ULONG_MAX) {

[Severity: Medium]
Will this xas_for_each() loop trigger lockdep warnings when PROVE_RCU is
enabled?=20

The caller holds the slots_lock, but iterating the XArray using this
macro implicitly dereferences node pointers. XArray requires either
rcu_read_lock() or the internal xa_lock to satisfy its lockdep invariants
during traversal, neither of which appear to be held here.

> @@ -2579,6 +2608,23 @@ static int kvm_vm_set_mem_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
> [ ... ]
> +	if (attributes &&
> +	    kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
> +		r =3D -ENOSPC;
> +		goto out_unlock;
> +	}

[Severity: High]
This is a pre-existing issue, but does bypassing the limit check when clear=
ing
attributes re-expose the vulnerability?

Because this check requires attributes to be non-zero, a caller can set a
single attribute at index 0, and then call KVM_SET_MEMORY_ATTRIBUTES with
attributes set to 0 for an enormous range. The kvm_range_has_memory_attribu=
tes()
function will evaluate to false due to the index 0 entry, and this limit ch=
eck
will be bypassed.

> [ ... ]
>  	for (i =3D start; i < end; i++) {
>  		r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
>  		if (r)
>  			goto out_unlock;

...which causes this subsequent loop to unconditionally reserve XArray node=
s for
billions of GFNs until the host hits ENOMEM, exiting without freeing the le=
aked
reservations.

> [ ... ]
>  out_unlock:
> +	/*
> +	 * Resynchronize with the actual state only when the array may have
> +	 * changed: on ENOMEM partway through the reserve loop, partially
> +	 * reserved GFNs are retained and must be counted, and a successful
> +	 * set or clear changes the population.  Non-mutating exits skip the
> +	 * walk so idempotent requests stay O(1).
> +	 */
> +	if (mutated)
> +		kvm->mem_attr_gfn_count =3D kvm_count_mem_attr_entries(kvm);
>  	mutex_unlock(&kvm->slots_lock);

[Severity: High]
Does this trigger a severe CPU denial of service during standard memory upd=
ates?

When a guest issues a series of 1-page memory attribute updates, this mutat=
ed
flag will be true for each successful update. Calling kvm_count_mem_attr_en=
tries()
then iterates over up to 33.5 million populated entries in the XArray while=
 holding
the slots_lock.

Performing an O(N) iteration that takes tens of milliseconds on every succe=
ssful
mutation yields an O(N^2) complexity that ties up the CPU and monopolizes t=
he
slots_lock for long periods, blocking memslot and dirty logging operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911184819.1011=
23-1-davimaba.v@proton.me?part=3D1
