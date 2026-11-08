Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098645;
	b=n7wmNZS6YL5rMmOxYuU7zzLE0InTGpM2RupEXIdpHibnxlndteRi3bSvMUf2TsiRS4xy
	 KQ7p/2KZCFdKbdL68Te7LVjhyZymDm+7SOycDFEUeSxbELzhFYTCG1bxPAtz+59d/2zsZ
	 HY8ffBSinV54OApG51IGTIzv9dcUu9XsCT7Lrc0/EtHKTkr7Q92JzCP3biMU1U1y7CiDh
	 NL7YGcBW2OdXhaDozC6//V6/zhUZl74ye8pYkzQ4dUj559U25uBP2jXBbJMwksN4X3Skp
	 isAMM1e7IzySHxAwMcduFx/qxAN/YMcSyLjrr5QTJ03aA8pe5+UfKlamZWXzw2Xst9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fPYv4Lm2lHfwZGyOll642ASLShdeptYnNbr9dmQu7GQ=;
	b=PMEnrthwAweY4YsBrkwVNZqZeXF9TDasOJWqMzWQSvjotW6anHvIgGSE0thQhFgjtiaa
	 Hazk6SkoP1/sC53x6X9J9DExNUugEK+LOqReRldUxfV8+gg2+Yt4MxqRHFatasnSLyBo8
	 WjOBY+Xlaj7XgfTxOa32a3F4dZhMoERK1JWh4exDwcMS1GUBy+QHvCZIvMdXV7si6R0Zv
	 EJ3S3GcSDP5BWLrsdLRFZ5bNA2wHz2xZK/ZJ82H0IcC7G/61j+Z2TVbrlBDYsRKk74OA/
	 HTqtIS+bO71Od9JxEdppcFtW4jvR32YHt/erlQFWZCslB6q9z3wiIGsq9D+Mo7RHnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ6Ch8a2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8F606A33D
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ6Ch8a2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F51F008A1;
	Sun,  8 Nov 2026 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098644;
	bh=fPYv4Lm2lHfwZGyOll642ASLShdeptYnNbr9dmQu7GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJ6Ch8a2TWqNB4cnUPhWbetuR/LO3WVXdHo2yWxHEVsaSwD6MBOwBaDFtOX3MNQz4
	 P5/okLw+luz/Y2IP7wb7eh3BVqk1oQHr8p3+SCea6YLlkq4X82iAacZV8hhTS8sf49
	 vzWAhl7lsS5g0AcOq+tkXK+zzD6qfy18ziZy7ts2EWcp/doWKYumQA0BZgJJi9io7U
	 S3Lt53h32K7xvL8KH+hsaLIYbPheJb6Grg6bRie7VM4K0G39ys7C0laLurPOT/ON7D
	 bOxA6UnGpKR5NbHDZ5ZAOi9A3qsaOZB8R1FWMPuqgJ/h1lEzfyCCtla2uY2qKMaomc
	 LPE+Rn6WSWOGg==
Message-ID: <sashiko-outbox-203439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 28/88] KVM: guest_memfd: Support reporting PFN
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-28-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-28-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:03 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] KVM: arm64: gmem_abort() exits on L2 write when L1 S2 is
  read-only
- [Low] KVM: arm64: nv: unresolved TODO comment in kvm_translate_vncr()
- [Low] KVM: SVM: shadowed read-only PFN check in sev_handle_rmp_fault()
- [Low] KVM: arm64: nv: unaligned GPA passed with PAGE_SIZE in
  kvm_translate_vncr()
--

commit 0c51d556213ce4b6cb7adb6d1befd0cf237a2240
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: guest_memfd: Support reporting PFN attributes

This commit adds a pfn_attrs output parameter to kvm_gmem_get_pfn() and
__kvm_gmem_get_pfn(), defines GUEST_MEMFD_PFN_ATTRS_READONLY, and
handles read-only guest_memfd frames across x86 and arm64 fault paths.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 705f6d84770e9..8f0217185973c 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
[ ... ]
> @@ -1773,18 +1775,21 @@ static int gmem_abort(const struct kvm_s2_fault_d=
esc *s2fd,
>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>  	smp_rmb();
> =20
> -	ret =3D kvm_gmem_get_pfn(kvm, s2fd->memslot, canonical_gfn, &s2vi.pfn, =
NULL);
> -	if (ret) {
> +	ret =3D kvm_gmem_get_pfn(kvm, s2fd->memslot, canonical_gfn, &s2vi.pfn, =
NULL,
> +			       &pfn_attrs);
> +	writable =3D !(s2fd->memslot->flags & KVM_MEM_READONLY) &&
> +		   !(pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY);
> +	if (ret || (write_fault && !writable)) {
>  		/* If result is non-NULL this is a synthetic fault. */
>  		if (!result)
>  			kvm_prepare_memory_fault_exit(s2fd->vcpu, gfn_to_gpa(canonical_gfn),
>  						      s2vi.vma_pagesize, write_fault, exec_fault,
>  						      false);
>  		kfree(mapping);
> -		return ret;
> +		return ret ?: -EFAULT;
>  	}

[Severity: Medium]
When L2 writes to an unmapped shadow Stage-2 IPA that L1 mapped
read-only in its own Stage-2 page tables, kvm_s2_handle_perm_fault()
returns 0 on the initial translation fault so that gmem_abort() installs
a read-only shadow Stage-2 PTE and the retried write traps as a
permission fault to be forwarded to L1:

arch/arm64/kvm/nested.c:kvm_s2_handle_perm_fault() {
	if (!kvm_vcpu_trap_is_permission_fault(vcpu))
		return 0;
    ...
}

Does checking (write_fault && !writable) without checking whether
s2fd->nested permits writes cause gmem_abort() to exit to L0 userspace
with KVM_EXIT_MEMORY_FAULT instead of installing the read-only shadow
Stage-2 mapping when the backing PFN has GUEST_MEMFD_PFN_ATTRS_READONLY
set?  Checking (!s2fd->nested || kvm_s2_trans_writable(s2fd->nested))
here would let the read-only shadow mapping be installed so the Stage-2
permission fault is delivered to L1.

[ ... ]

> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 4d83281a7a28b..4519e92d89d66 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1615,14 +1615,24 @@ static int kvm_translate_vncr(struct kvm_vcpu *vc=
pu, bool *is_gmem)
>  			return -EFAULT;
>  		}
>  	} else {
> -		ret =3D kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
> +		u64 pfn_attrs;
> +
> +		ret =3D kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL,
> +				       &pfn_attrs);
>  		if (ret) {
>  			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
>  					      write_fault, false, false);
>  			return ret;
>  		}
> =20
> -		writable =3D !(memslot->flags & KVM_MEM_READONLY);
> +		writable =3D !(memslot->flags & KVM_MEM_READONLY) &&
> +			   !(pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY);
> +		/* TODO: Explain why vt->wr.pw needs to be checked. */

[Severity: Low]
This isn't a bug, but this placeholder TODO comment was left in place
instead of explaining that !vt->wr.pw must return 0 so
kvm_handle_vncr_abort() injects a stage-1 permission fault into the
guest via handle_vncr_perm() rather than exiting to host userspace.

> +		if (write_fault && vt->wr.pw && !writable) {
> +			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
> +						      true, false, false);
> +			return -EFAULT;
> +		}
>  	}

[Severity: Low]
VNCR_EL2 and vt->wr.pa are 4KB-aligned regardless of the host page size.
On a 16KB or 64KB page size host, does passing vt->wr.pa with PAGE_SIZE
to kvm_prepare_memory_fault_exit() report an unaligned GPA range
[vt->wr.pa, vt->wr.pa + PAGE_SIZE) that straddles into gfn + 1 instead
of gfn_to_gpa(gfn)?

[ ... ]

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6427db390b1cd..5e37ea4bc7937 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -5092,13 +5097,19 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, =
gpa_t gpa, u64 error_code)
>  	mmu_seq =3D kvm->mmu_invalidate_seq;
>  	smp_rmb();
> =20
> -	ret =3D kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
> +	ret =3D kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order, &pfn_attrs);
>  	if (ret) {
>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for pr=
ivate GPA 0x%llx\n",
>  				    gpa);
>  		return;
>  	}
> =20
> +	if (pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY) {
> +		pr_warn_ratelimited("SEV: Unexpected RMP fault, read-only backing page=
 for GPA 0x%llx\n",
> +				    gpa);
> +		return;
> +	}

[Severity: Low]
Can this GUEST_MEMFD_PFN_ATTRS_READONLY check be reached for a private
GPA?  In kvm_gmem_get_pfn(), a private page with
GUEST_MEMFD_PFN_ATTRS_READONLY set already fails with -EFAULT, so the
if (ret) branch above catches it first and logs "no backing page for
private GPA" instead of "read-only backing page".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D28
