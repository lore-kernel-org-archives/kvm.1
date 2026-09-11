Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7333EA97E
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153346; cv=none; b=dGyqBsdKaMt2noU5tpMeGeVbD7i8hB2MqrBrck+eiKzG6Y7vXwBejw6JVDk4MhK8Ub4xi9k2ii/WTjeyNrwK6wYPiZKBrIj6c08ELxKu7sbE1UWwlaF73aINJGyEGHtXA4+QHHfOfvjSAau9mwIjkABIi+5/RMJLz0O0hzO2YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153346; c=relaxed/simple;
	bh=dCTyRhxihGlrCUTWHaGUFFkjSgz6sgy4/yw1IgOI5qQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdZlLAPOxuAreHZsto3dL731LfVB+fM1dfKN+ZbxyMgAUD2O5PD/g0YOBbC1yYm9a+YjEQqGeuCZv1bjf4Gn6PwHjk3HNpAO7BfT8sMCfafgk1KNDzmEPSKMZSmdAXB7ledeNGwpEynuFUmZVIhP7J+O0mi5JHLil3Sqc/BuF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw+xgcJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw+xgcJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315CE1F00898;
	Fri, 11 Sep 2026 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153342;
	bh=9qMQYjDSuU9P2T67JNsYpG5dN53hax5M+uN/XE/O08A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iw+xgcJelpd8nF4Ph433fWnTsWM7/HRrbakPLwkF58vvHQ5nRsqwo0Bn6A2zWTTqr
	 /iA2pPu65Qa6GW0uSX2KPinfQ04sJzf/ujo02eo5SlJqzCwIBQ/SrFPmOlQ2RlXzAS
	 eB1amHZ65Bx9o796H8B9frFv74+RIqBi+qQntokWDmTj+9N3Ny9TgiaEv1WGDWY/4P
	 43538IqTH17A2Vlk8S0q9rZ8MJWRmt6uvVfsMjzMekULlqO9bQGirBqrbpdCfcBVLC
	 bRJAonW9nbCD8wCmhv0pK0DU5q0sn5an/blogvjSLOwxbpHpYlYvUZ9WTjE7q9UOec
	 dzi3gro4xKeSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: Account mem_attr_array nodes to the caller's
 memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Ballesteros" <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911184819.101123-3-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
 <20260911184819.101123-3-davimaba.v@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:02:21 +0000
Message-Id: <20260911190222.315CE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Bypass of `KVM_MEM_ATTR_MAX_GFNS` limit and missing error cleanup =
when clearing memory attributes leads to memcg exhaustion and stranded XArr=
ay nodes.
- [High] The patch fixes a memcg accounting bypass for `mem_attr_array` by =
adding `XA_FLAGS_ACCOUNT`, but misses other KVM xarrays that use `GFP_KERNE=
L_ACCOUNT` for insertion and share the exact same vulnerability.
--

commit 32c232444c0ef12bbcc23f63ec3c6ef9046e4c0d
Author: David Ballesteros <davimaba.v@proton.me>

KVM: Account mem_attr_array nodes to the caller's memcg

kvm_vm_set_mem_attributes() passes GFP_KERNEL_ACCOUNT when reserving
xarray entries, but the nodes are allocated by xas_alloc() with
GFP_NOWAIT, which only adds __GFP_ACCOUNT when the xarray carries
XA_FLAGS_ACCOUNT.  mem_attr_array is initialized with plain xa_init(),
so the flag is never set and the nodes are never charged to the caller.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f07d2ae9a4ad0..25c1ff0c2a93e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1127,7 +1127,7 @@ static struct kvm *kvm_create_vm(unsigned long type=
, const char *fdname)
>  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>  	xa_init(&kvm->vcpu_array);
        ^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does vcpu_array have the
exact same memcg accounting bypass?

Looking at vcpu_array, it uses GFP_KERNEL_ACCOUNT for node insertion but
lacks XA_FLAGS_ACCOUNT during initialization. Since the xas_alloc fast-path
uses GFP_NOWAIT, it relies on XA_FLAGS_ACCOUNT to charge the memcg.

Are there other KVM xarrays that share this vulnerability? For example, in
ARM64:
- its->translation_cache in arch/arm64/kvm/vgic/vgic-its.c:vgic_its_create()
- dist->lpi_xa in arch/arm64/kvm/vgic/vgic-init.c:kvm_vgic_dist_init()

>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> -	xa_init(&kvm->mem_attr_array);
> +	xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);

[Severity: High]
This is a pre-existing issue, but does kvm_vm_set_mem_attributes() bypass
the KVM_MEM_ATTR_MAX_GFNS limit and leak xarray nodes on error?

When KVM_SET_MEMORY_ATTRIBUTES is called with attributes =3D=3D 0 and a mas=
sive
address range, the KVM_MEM_ATTR_MAX_GFNS bounds check is bypassed:

virt/kvm/kvm_main.c:kvm_vm_set_mem_attributes() {
	...
	if (attributes &&
	    kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
		r =3D -ENOSPC;
		goto out_unlock;
	}
	...

Then xa_reserve() unconditionally allocates nodes for the entire range. If
an allocation fails partway through, the error path bails out without
cleaning up the successfully reserved entries:

	for (i =3D start; i < end; i++) {
		r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
		if (r)
			goto out_unlock;

		cond_resched();
	}
	...
out_unlock:
	mutex_unlock(&kvm->slots_lock);
	return r;
}

Can an unprivileged userspace process repeatedly call this with
attributes =3D=3D 0 to exhaust the memcg limit, leaving permanently stranded
memory allocations?

>  	kvm->mem_attr_gfn_count =3D 0;
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911184819.1011=
23-1-davimaba.v@proton.me?part=3D2
