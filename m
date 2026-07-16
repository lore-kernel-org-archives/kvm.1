Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6F3859F3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226563; cv=none; b=QsGJHqHu3g4DXPyFggCSC1emAA0gXfLkwoNcfx5p6CIl+h1VIDS+deesTGlYnsXxPphw9kQn2mI4VbILKCgErZ6REjhoLlbu+hap4TEKNAlMKyWinXGjGSbsjAlHG+JJsHVAochON6RBpPDOIXIPZqgxTs2blawq50a2s/Rs0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226563; c=relaxed/simple;
	bh=C0RBB2CjwmUA9FUWbAzEQ6Ck9T/7GGnqslkk19QOIes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RnIwFo0idxU1dSoYlMwCt33ksV+DdixcGRnDIp7uMiSPBqhFMc2B0L/jiqcLFgFjROkmocMucjKN9yEMhVmcTYS83zvGlebG8M75QjCwCs/ejxnz4GIyDaKCBx6waKL1UoBLbkNeIr8ZsI334ysr1u1f4yEIA9cPN0qyH0lepEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoCGlEwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoCGlEwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12371F00A3A;
	Thu, 16 Jul 2026 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226562;
	bh=fdKP6N7IpXfT5zopdcbbE9rvmANLm6QOmcTS4E+FLtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoCGlEwxxAXa/yuQAh/lmf665Flc5Vth2f+hVqWvC/x3oI8CKQgeIz7NZd8VM2j4A
	 5l+tB4QWRkea4sIgLKAYextpn5GQwjzngi1nkYunlXnPRHM9SENzU/FkRc9OTNRWHi
	 Io2pwnp1ozZtnekz18i22cXGtSltEYB8dH1Iu91/gj+TMUZKY+BfzyMawERV1JMr+5
	 uHXamaMiai3ldLviltGNgZkjCTL1DW8ggjDNIFvnXT0ON47nBR8ShYnORmlU3dRLUW
	 5FIJUIPUJfHYbWcTkT3rlgQczGQ7C9nspOU0RtVX1AfTIHKGKUD3XtA6qlZ1/ce5yN
	 wKMjim++16mMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/24] KVM: Include memory protections in result of
 gfn->hva conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-11-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:29:21 +0000
Message-Id: <20260716182921.E12371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional NULL pointer dereference in gfn_to_hva_prot() and kv=
m_vcpu_gfn_to_hva_prot() when applying memory attributes.
--

--- Patch [10]: [PATCH 10/24] KVM: Include memory protections in result of =
gfn->hva conversion ---
commit bca8d72704eb8c45ae205232d29cab272cbba365
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Include memory protections in result of gfn->hva conversion

This commit adds memory attribute checks to paths leading to guest memory
accesses. Functions like gfn_to_hva and kvm_vcpu_gfn_to_hva now return error
values based on memory attributes, though cached variants will need separate
changes.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -2796,15 +2821,37 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_=
memory_slot *slot,
>  unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
>  {
>  	struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);
> +	unsigned long addr;
> +
> +	addr =3D gfn_to_hva_memslot_prot(slot, gfn, writable);
> +	if (kvm_is_error_hva(addr))
> +		return addr;
> +
> +	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
> +		return KVM_HVA_ERR_BAD;
> =20
> -	return gfn_to_hva_memslot_prot(slot, gfn, writable);
> +	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
> +		*writable =3D false;

[Severity: High]
Does this code unconditionally dereference the writable pointer?

If a caller invokes gfn_to_hva_prot() with a NULL writable pointer, and the
GFN has memory attributes that restrict write access, will this crash the
kernel? The KVM API allows the writable pointer to be NULL.

> +
> +	return addr;
>  }
> =20
>  unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn,=
 bool *writable)
>  {
>  	struct kvm_memory_slot *slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	unsigned long addr;
> +
> +	addr =3D gfn_to_hva_memslot_prot(slot, gfn, writable);
> +	if (kvm_is_error_hva(addr))
> +		return addr;
> +
> +	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
> +		return KVM_HVA_ERR_BAD;
> +
> +	if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
> +		*writable =3D false;

[Severity: High]
Similar to the above, can this cause a NULL pointer dereference if
kvm_vcpu_gfn_to_hva_prot() is called with a NULL writable pointer?

> =20
> -	return gfn_to_hva_memslot_prot(slot, gfn, writable);
> +	return addr;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D10
