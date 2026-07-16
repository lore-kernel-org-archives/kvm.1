Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991337A832
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227211; cv=none; b=OGUoGyqAC9FqBUyMhnHl8JOr4ru1ps1/iQMotBglwiJQzxkaRFfBQ1AvNf6zRQx5KR8XVqeSLdJWXGukm2RAmWb+jIFnsWuF+OvDO5QTT7ZsqeVRlYs5kUy2LmG0x+MczOqH8k15sveK0724CrSKdEIJ4lRA+59k8r5TJNfO61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227211; c=relaxed/simple;
	bh=F/EHhhzuBXw9YX4Su3+3QyszK+q1zNA41YYgH5D9knM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhC2Yy7rZX+YJkTblQuUp7Ti3VEFFBbpINUVp+kPi53KVGob41N4RCtDPyYQUN67HQBA3oSU2PuUtMuT9HBrfP3BFRhKan6KMU0BP5N5Tiyt07ZiFJ4GgZDAw2VUbZO4jtzjICVgMAGjLVhqwGJA+fcyRE6KdrDppXHUIgJL/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT/4Ke5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT/4Ke5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1412D1F000E9;
	Thu, 16 Jul 2026 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227210;
	bh=RhBOqEutEr928XSNKfUchuwR+xwAeNuJbp7kSHhpxBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JT/4Ke5nbz1Cgs9Mk2PHNZRwmDaR5NLNIwOWikXJP1Rq9ZwbQADHmAGk7D0g87FE4
	 zj9AUj6iiJ5CozweoD0l2EfvOcGbTxETj5Ved/kLEJ6xmhEHGImSpEFfI8E8ohRxLE
	 nUJI++BQmjlzyN/PqVYEv5qIzQzfNOLWlMRr7fyPZw8uApRje8KhDc3YFbTHyGZ6fU
	 G2hDnZ+4X0iG5Ddm3c9j66VFS2RL8mxGfY2vbZ8uvxmw15MoWF758wDKIvbKeocuqf
	 XPFKyauunrJFtXEMWLy7JXEb3+AryLJf9qSum1ZNNGK3RT+sZXpASXS82ACmrBIigS
	 tVPuY2r5NCX/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/24] KVM: x86/mmu: Obsolete all roots if memattr
 contains gPTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-22-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:40:09 +0000
Message-Id: <20260716184010.1412D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unbounded iteration over a potentially massive guest-controlled GF=
N range while holding `mmu_lock` for write causes host soft lockups.
- [High] Invalidated TDP MMU roots are never zapped, leading to a massive p=
ermanent memory leak of page tables and root references.
- [Medium] A `trace_printk()` call was left in the production code path, cr=
eating an information leak and triggering a prominent boot warning.
--

--- Patch [21]: [PATCH 21/24] KVM: x86/mmu: Obsolete all roots if memattr c=
ontains gPTEs ---
commit 6d375c0ae74e01be130495175a78c166ea5a1aac
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs

This commit introduces a mechanism to zap obsolete pages and all mmu roots
when applying memory protection attributes against a GPTE page.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8e85f672a08d5..676bc6b61f032 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -8281,6 +8297,33 @@ bool kvm_arch_post_set_memory_attributes(struct kv=
m *kvm,
>  				hugepage_set_mixed(slot, gfn, level);
>  		}
>  	}
> +
> +	/*
> +	 * There are special considerations when applying an memory protection
> +	 * attibute against a GPTE page. If set read-only, access/dirty bits
> +	 * within that page shouldn't be updated. If set non-accesible,
> +	 * accessing a virtual address that requires traversing that GPTE page
> +	 * should fault.
> +	 *
> +	 * On TDP enabled guests, the CPU faults on the GPTE address upon
> +	 * detecting such a situation.
> +	 *
> +	 * On non-TDP, upon detecting this situation, and based on the fact it
> +	 * should be a rare occasion, invalidate all the mmu roots.
> +	 */
> +	for (gfn_t gfn =3D range->start; gfn < range->end; gfn++) {

[Severity: High]
Does this unbounded loop over a guest-controlled range cause host soft
lockups? It iterates over every 4K page from range->start to range->end
while kvm->mmu_lock is held for write, disabling preemption. If a massive
range is passed (e.g., hundreds of gigabytes), iterating millions of pages
without yielding could stall the host CPU.

> +		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
> +			gen_update =3D true;
> +			trace_printk("needs gen update! %llx\n", gfn);

[Severity: Medium]
Is this trace_printk() intended for production? Using it unconditionally
allocates tracing ring buffers globally and emits a prominent warning to
dmesg at boot, which is generally avoided in upstream code.

> +			goto exit_loop;
> +		}
> +	}
> +exit_loop:
> +	if (gen_update)
> +		__kvm_mmu_zap_all_fast(kvm);
> +
> +	// todo: what to do with kvm_tdp_mmu_zap_invalidated_roots()?

[Severity: High]
Does this sequence leak KVM MMU page tables and root structures?

When tdp_mmu_enabled is true, __kvm_mmu_zap_all_fast() marks TDP roots as
invalid and takes a reference to them via kvm_tdp_mmu_invalidate_roots().

The caller must subsequently invoke kvm_tdp_mmu_zap_invalidated_roots()
to consume these scheduled roots and put the gifted references. Since this
cleanup step is skipped here, the roots appear to be leaked permanently.

> +	// add kvm_arch_post_set_memory_attributes_unlocked?
> +	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D21
