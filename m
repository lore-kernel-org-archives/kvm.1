Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD9175A68
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411255; cv=none; b=EMLoOvjAMfB780fCZQ6qD7VxUtnOdHjGEeTLVaLR4KEHJe5r0Jbf2rrJ2P8aR6sQk/WacXZKf2n/lPCEqXaqn0pk0YJ5NWeaiCcz0+8dwvt1uWw9rlSWVYiKPF0iyWvpj8GigF0XNMoFE6MLV8p5y+3R29T3F9SHw8dIKqttvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411255; c=relaxed/simple;
	bh=eGPnWXp+GL8hUpKa2K1bhY+g8iszTicAX7oPuceWU0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQtmNZFKr/AqbOgsQiaty2VgXGf0hs56skqSxPWFECca8T8ezAIsqaXFjgmfstvOB06ps08mKdAtyEcB+BqoL2FuFAssjuPm4nLsA0JMAWB5iVvJS1YLyN3HJrl0O+ztf4+TnZAo8dzdH/NnPxiupTsiekpaCCkQSyP2KUbAYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3d3x801; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3d3x801"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C759A1F00893;
	Tue,  2 Jun 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411254;
	bh=XONIAE1uAUXduMjv42WVeXjbvoFtwdDkWk8C9nOTdWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3d3x801DxzZfGZ5ZzxbP4VVzEjtQy7VyCWBzLNdNgomlx6QcO93ZELOVYyNXfpoz
	 92JBB/PKj6XumGZ/RBFK3zKRkx1VzIUY7fn2AsfxI9cNujBq+34jBdQ09Rt6npIR7T
	 k5U+n+PC4a2O6v1aZ82hyg1vpH9A4orcMURTUjYhtsrm5U51hNiwcMCURy4jmNiA7m
	 g1eVcRDgJvtM0sTUoghEVHU1BC2a+nD9B4A7Hd84jhIu5o71amQ7d8Zr+EocOCfbsd
	 ce31ttirne8oDcCTdlVCtZVe5xTo12c+Df5KV8hwWWZhP8AcjFzORfdaOjMigcByrc
	 /ACjfCqWSIR6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] KVM: s390: Prevent memslots outside the ASCE
 range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602142356.169458-9-imbrenda@linux.ibm.com>
References: <20260602142356.169458-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:40:53 +0000
Message-Id: <20260602144053.C759A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Asymmetric and Order-Dependent Limit Validation
--

commit 7a66168c52b7a30030450cbbdcd5db0e9145bbfe
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Prevent memslots outside the ASCE range

This patch aims to prevent userspace from creating memslots above the
maximum allowed VM address, and prevents reducing the maximum address
below existing memslots.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed1..ffb20a64d328f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -999,7 +999,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm,=
 struct kvm_device_attr *att
>  		break;
>  	}
>  	case KVM_S390_VM_MEM_LIMIT_SIZE: {
> +		struct kvm_memslots *slots;
> +		struct kvm_memory_slot *ms;
>  		unsigned long new_limit;
> +		int bkt;

[ ... ]

> +		ret =3D 0;
> +		scoped_guard(mutex, &kvm->slots_lock) {
> +			slots =3D kvm_memslots(kvm);
> +			if (slots && !kvm_memslots_empty(slots)) {
> +				kvm_for_each_memslot(ms, bkt, slots) {
> +					if (gpa_to_gfn(new_limit) < ms->base_gfn + ms->npages) {
> +						ret =3D -EBUSY;
> +						break;
> +					}
> +				}
> +			}
> +			if (!ret)
> +				ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
> +		}

[ ... ]

> @@ -5672,6 +5693,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  			return -EINVAL;
>  		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
>  			return -EINVAL;
> +		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npag=
es - 1))
> +			return -EINVAL;
>  	}

[Severity: Medium]
Is this creating an asymmetric and order-dependent limit validation?

When KVM_S390_VM_MEM_LIMIT_SIZE is called, the exact new_limit is strictly
checked against existing memslots (e.g., rejecting a 4GB limit if a 3TB
memslot exists). However, new_limit is never saved back to
kvm->arch.mem_limit.

When a new memslot is added later, it is only validated against the old
kvm->arch.mem_limit and the rounded-up ASCE capacity here in
asce_contains_gfn().

For example, setting a 4GB limit configures a TABLE_TYPE_REGION3 ASCE with
a 4TB capacity. Because the exact 4GB limit was not saved, userspace can
successfully add a 3TB memslot later since 3TB < 4TB.

Should kvm->arch.mem_limit be updated during KVM_S390_VM_MEM_LIMIT_SIZE to
enforce the exact limit symmetrically?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602142356.1694=
58-1-imbrenda@linux.ibm.com?part=3D8
