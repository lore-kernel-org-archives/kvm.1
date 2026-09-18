Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720D3CAE84
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720752; cv=none; b=IL6/5FVE/hNLBcCLXJ9rLWWGyLYooZ6wNMzxqu9RdiYjKN1XgObv5Bcp5xwDyU9q4EqLrC6wsNpRUGNYGz4Y52+FjZDhOsN7blW7ieGLgw0TCuEY75awoIl2uyVPr1oIzuPL7XYwKQwbnpNlRexiUqEwsAzgwIcC/lSATX+wkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720752; c=relaxed/simple;
	bh=4SvgQNBbLDfwz6q+zibLCfmyZYRuqtRW4G45tqyALKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Skg1i9MXbA57uj+G3riNZj6dUHvGxNzv6+7m+rUXC0gbhj39OwxqGm2qZvEYpWl7xtIEvR26D3XCtu3qQJDKe7LCF1hrHqnRcsQ5iwwvVTuhHn480kfp+KyKA47pSyagjICmaVmG7e7vtn5etnwJixvAaP+J6G5yHB/eN+8OuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8bLxrLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8bLxrLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9241F000FF;
	Fri, 18 Sep 2026 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720750;
	bh=dowGVsTAX/kHTfAiGM/QJesApRpGDmz6wjD9Y8+Vt4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8bLxrLRb9UFBeJb+0m8QXDeT4HeERpkcfCe1Qob7TQvVPjfhLWcq+VzPIQdU7InG
	 hgkbkS/+ydmC9Dosf8L5VdB3Yef4Y3FC+SEoPPeagTR4v/6pS7uKLjieYKQ5/pE5oR
	 dOJH0tLaMcwPUXuSQM4ITqBboEXfAXGjGkckWfN9qNlQagFrMy3yqW0VkbF9UvJagR
	 Zdan7sUXjnYmJursnHRJPuMuyHaBWQRV4IbEkg5s86dmuEpQFDPH5SHXNN3nb/Yz9V
	 8RmRanBl57OWkZmj1lrMuuv1o8LBbCdn8HiWQVn5vMZDGakjvdIIVA6HF9uqH5aeMn
	 iBS1KDwGHCOVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/28] KVM: Introduce a generation number for memory
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-19-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:39:10 +0000
Message-Id: <20260918083910.9F9241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: RCU stall in kvm_range_has_any_memory_attributes() due to XAr=
ray bounds mishandling
- [High] kvm: LoongArch compilation failure due to removed generation field
--

commit fa1df61c99941c6c01fe6e64de2dd5831dc8ad7d
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce a generation number for memory attributes

This commit introduces a generation number to track memory attribute
modifications. It ensures that cached guest physical addresses and
permissions are validated against this generation before access.

> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a568d8e6f4e82..7d911220e00d2 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -74,7 +74,8 @@ typedef u64            hfn_t;
>  typedef hfn_t kvm_pfn_t;
> =20
>  struct gfn_to_hva_cache {
> -	u64 generation;
> +	u64 slots_generation;
> +	u64 attrs_generation;
>  	gpa_t gpa;
>  	unsigned long hva;

[Severity: High]
Does this change cause a compilation failure on LoongArch builds?=20

It looks like kvm_update_stolen_time() in arch/loongarch/kvm/vcpu.c still=20
contains a direct reference to the removed generation field:

    if (slots->generation !=3D ghc->generation || gpa !=3D ghc->gpa) {

Should this architecture-specific file be updated to check the new=20
slots_generation and attrs_generation fields?

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index eede017d41411..2d85d7c9e0046 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2480,6 +2481,51 @@ bool kvm_range_has_memory_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
>  	return true;
>  }
> =20
> +/*
> + * Returns true if _any_ gfns in the range [@start, @end) have attribute=
s that
> + * match _any_ bit in @mask.
> + */
> +bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, g=
fn_t end,
> +					unsigned long mask)
> +{
> +	XA_STATE(xas, &kvm->mem_attrs.array, start);
> +	void *entry;
> +
> +	mask &=3D kvm_supported_mem_attributes(kvm);
> +	if (!mask)
> +		return false;
> +
> +	if (end =3D=3D start + 1)
> +		return !!(kvm_get_memory_attributes(kvm, start) & mask);
> +
> +	guard(rcu)();
> +	for (;;) {
> +		do {
> +			entry =3D xas_next(&xas);
> +		} while (xas_retry(&xas, entry));
> +
> +		if (xas.xa_index >=3D end)
> +			break;

[Severity: High]
Can this loop stall infinitely if a user provides a range that extends=20
beyond the populated indices of the mem_attrs XArray?=20

If xas_next() goes out of bounds, it returns NULL and sets the state to=20
XAS_BOUNDS, which means xas.xa_index stops advancing. Because the loop=20
relies strictly on xas.xa_index >=3D end to terminate, an out-of-bounds=20
query would never break out of the loop and cause an RCU stall.

> +
> +		if (xa_to_value(entry) & mask)
> +			return true;
> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D18
