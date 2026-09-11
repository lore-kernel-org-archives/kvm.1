Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30944839E
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159533; cv=none; b=SHvb407hiwhRfcBcWvgsCxfEvPO2QjNH3CpxWkVTJAZcDUoWovDbc28h2MOBkYXqxtNHRF1bWM3iM8U7QYgbJ6R0EpUSL7ahRVNegvKiFc378uUplvVoqFDpWSYRIcS8lIhk3+Sprme2nRRo0x5tL1d+vPifhsg+uj/HJ1DUi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159533; c=relaxed/simple;
	bh=y3iT1CRIXPnDT82x/QLL8scU0Q75UKYzEMBDo7V96vU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZcY1REdLefXSdXPWiY91owCKQE3TrUWyBN5v5SoBR1HaapWMj4iUUSadbfL5kzfZmRFBNh8UgtJHy6FY1TCf/rvTjLYNRSUYS6DL5yD9JeG+q0hiI410syLd6eCGWCwra/9P/ZdEV3qjWjTFyRy6deD9Zr+KXcyMwXKj61d7KIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5iSOVaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5iSOVaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91311F00893;
	Fri, 11 Sep 2026 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789159532;
	bh=fQ1wBEmKs9+mhlAi5z05DcGdJS5byvCeVsP6u6tTFjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5iSOVaFE7ERMmedfOiCWxr9HujhGZwox4liDFUdgf70U3eCW4HNrMbUxsPHgqTKC
	 qWrFqPmWAFCBveseZzQq6ip8K3J6YJbGtpxrFZg4LR1tQhVvev9Cjvk8NDUNIK49yn
	 9pXoS7o30f0i2+2GmTfa1OdVvyRAVf5j+Y1p2hEHjKrlVtPasfeKz5DTYm/BEGQDMd
	 3ozg99Gn6LxqKi/l0Qh+YvICVT6uGuC9UUgHjENaoeRgOdSOe8JOzhOlih26F57oq1
	 RHmE8sARcm2jwMH5laG7pswSgMBv8KAW1X9fkbb2aGN11POEVrzJe0KtofZA9BMBhI
	 9Vmtl4alQ7uVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] KVM: Bound per-VM GFN materialization in
 KVM_SET_MEMORY_ATTRIBUTES
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Ballesteros" <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911203238.30088-2-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
 <20260911203238.30088-2-davimaba.v@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 20:45:31 +0000
Message-Id: <20260911204531.E91311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleepable functions called inside an RCU read-side critical sectio=
n established by `guard(rcu)()`.
- [High] Asymmetric accounting of `mem_attr_gfn_count` allows permanent Den=
ial of Service via budget exhaustion.
- [High] XArray iterator corruption by modifying the array with `xa_erase()=
` during lockless `xas_for_each()` iteration.
--

commit 3f5796ac8ce025c5b7da5cd6adbb4331967a81b4
Author: David Ballesteros <davimaba.v@proton.me>

KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES

This commit bounds the number of GFNs materialized per VM in
KVM_SET_MEMORY_ATTRIBUTES to prevent kernel memory exhaustion. It enforces a
limit under kvm->slots_lock and reworks clearing requests to avoid allocati=
ons
by erasing entries directly. The per-VM counter is maintained incrementally=
 to
improve performance on non-failing paths.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 108d42c5c1d6a..f623c5f07344e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -2544,6 +2545,34 @@ static bool kvm_pre_set_memory_attributes(struct k=
vm *kvm,
>  	return kvm_arch_pre_set_memory_attributes(kvm, range);
>  }
> =20
> +/*
> + * Return the number of GFNs with a materialized entry in mem_attr_array.
> + * Serialization against modifications is provided by kvm->slots_lock.
> + */
> +static unsigned long kvm_count_mem_attr_entries(struct kvm *kvm)
> +{
> +	XA_STATE(xas, &kvm->mem_attr_array, 0);
> +	unsigned long count =3D 0;
> +	void *entry;
> +
> +	guard(rcu)();
> +	xas_for_each(&xas, entry, ULONG_MAX) {
> +		if (xa_is_retry(entry)) {
> +			xas_pause(&xas);
> +			continue;
> +		}
> +		if (entry)
> +			count++;
> +
> +		if (need_resched()) {
> +			xas_pause(&xas);
> +			cond_resched();

[Severity: High]
Does this code call cond_resched() while holding the RCU read lock?

Since guard(rcu)() establishes a function-scoped RCU read-side critical sec=
tion,
the lock is held until the function returns. Calling cond_resched() inside
this loop could lead to scheduling while atomic panics or RCU grace period
stalls.

> +		}
> +	}
> +
> +	return count;
> +}
> +
[ ... ]
> @@ -2579,6 +2609,49 @@ static int kvm_vm_set_mem_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
>  	if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
>  		goto out_unlock;
> =20
> +	/*
> +	 * Clearing never materializes entries: erasing cannot allocate, so
> +	 * there is no reservation phase, no bound to enforce and no way to
> +	 * fail partway through.  Iterate the present entries only (absent
> +	 * spans are skipped by the xarray walk) and erase them; xa_erase()
> +	 * takes the xa_lock per entry and node frees are RCU-deferred, so
> +	 * the iterator is safe under the RCU lock while kvm->slots_lock
> +	 * excludes other writers.
> +	 */
> +	if (!attributes) {
> +		XA_STATE(xas, &kvm->mem_attr_array, start);
> +
> +		kvm_handle_gfn_range(kvm, &pre_set_range);
> +
> +		guard(rcu)();
> +		xas_for_each(&xas, entry, end - 1) {
> +			if (xa_is_retry(entry)) {
> +				xas_pause(&xas);
> +				continue;
> +			}
> +			xa_erase(&kvm->mem_attr_array, xas.xa_index);

[Severity: High]
Can modifying the array with xa_erase() during a lockless xas_for_each()
iteration corrupt the iterator state?

xa_erase() acquires its own lock and mutates the tree structure, but it does
not update the local xas iterator state. Modifying the tree without updating
the iterator might lead to skipped entries or infinite loops.

Would using xas_store(&xas, NULL) under xas_lock(&xas) be safer here?

> +			freed++;
> +			cond_resched();

[Severity: High]
Does this sleep while the RCU read lock is held?

The guard(rcu)() macro above establishes a block-scoped RCU critical section
for this if-block. cond_resched() is called unconditionally on every iterat=
ion
while the RCU read lock is actively held.

> +		}
> +
> +		kvm_handle_gfn_range(kvm, &post_set_range);

[Severity: High]
Is it safe to call kvm_handle_gfn_range() before the block-scoped guard(rcu=
)()
closes?

kvm_handle_gfn_range() acquires MMU locks and may block, but the RCU read l=
ock
acquired by guard(rcu)() is still held at this point, since the block hasn't
ended yet.

> +
> +		/* Exactly @freed entries left the array; no resync needed. */
> +		kvm->mem_attr_gfn_count -=3D freed;
> +		mutex_unlock(&kvm->slots_lock);
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * Bound the number of materialized GFNs per VM.  See the comment on
> +	 * KVM_MEM_ATTR_MAX_GFNS.
> +	 */
> +	if (kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
> +		r =3D -ENOSPC;
> +		goto out_unlock;

[Severity: High]
Can asymmetric accounting of mem_attr_gfn_count allow permanent denial of
service via budget exhaustion?

During a SET operation, the counter is incremented by the full logical range
size (end - start). This overcharges the count if entries are already popul=
ated.

When clearing, the counter is only decremented by the exact number of entri=
es
physically erased (freed). This means alternating overlapping requests could
cause the counter to drift upward monotonically.

Once it hits KVM_MEM_ATTR_MAX_GFNS, future requests return -ENOSPC. Since t=
he
-ENOSPC path jumps directly to out_unlock without recalculating the true co=
unt
(unlike the -ENOMEM path), the budget appears to be permanently exhausted.

> +	}
> +
>  	/*
>  	 * Reserve memory ahead of time to avoid having to deal with failures
>  	 * partway through setting the new attributes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911184819.1011=
23-1-davimaba.v@proton.me?part=3D1
