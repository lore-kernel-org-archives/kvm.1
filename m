Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402207;
	b=h5P1YYPfbcxiRcl1sndFnyzScKmzmAPBJyeOjdK4D28ULpZypRVebMkZHUVtcfckaR2h
	 O0ccI9RR5jPZB/kBJ+xK90VX1icnc3G6ZcyPyonWsosxolo+d2V70KK8spt/AMBWbLvVg
	 mGS0Azc9VFlzv8lU0t5CQhwHhGrea2I4HxikxbyjMFsJfxeXaUt7Tp/XpnxU9Og/m0YHN
	 XbPcRuvQayeRW1B35B0yd7xRJQcJimEoS/NCAL4AUucEK9bLKVCWMMZamhxB8y9wrY/Zz
	 wNd9230oa+2eg2EzylKWFpDYHom3OGbE+1+80hmdQhHg/1qVfwgyLtmyTKKaABgHAzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GLP9wWiTUzqvaRv++L3rxBUC5FSfIL3i5/KGVA3kwt8=;
	b=a3kE27mJ9+PxwoaIIojmTUX3MxnfzMwGKUQA/lMjwpB1Z9evUPsutOHLpigcjT6prWdK
	 2pmqcigMeL117dcYPzkLXEgL7I7UMrH8VBXCjRxpAj/Ow/QVkEECHnb4ly6rwt5hiUVXU
	 Cd/TUKbXaanMTv66JWWt1ofKVUKksAGFAngNhp/n+Ue0p/2eI0erPWoHVTpjp8/UP2Yya
	 Ahdw5EygyE9OVyTQjH3S/Wf8mkHhabsu0Jxk4bpxkGUPSXEeajhZl7+x5pn7LvRCm15uv
	 KEp6eUEV9ktXnJAtRnQdkx8HllIertxexCJWtQAXrYP/y46yWB9n0a49UHSzZI//FgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baiy9D4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80F606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baiy9D4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B011F000C1;
	Fri, 30 Oct 2026 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793402206;
	bh=GLP9wWiTUzqvaRv++L3rxBUC5FSfIL3i5/KGVA3kwt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baiy9D4LWfuAY7z8KDxP8onFyYnLuKiI9EZ6Mkmy/CfapGxeMmCkYfmT10kPfwA2Q
	 MPd/K9hZI55/sEcs/dV9tcMESsNmp6K+qH6LWmBf40gA6wMIh8Ie8DWvfHtHZ2FXYf
	 bogDllLpcs4Wr4Lz+bATPYRLfZXPsKIKlwJJQJBqLQHwiI4dEOGRoaAycmo95mQ0ip
	 ePqGnlHGcu8rLlX12J2GddWMg2dF4OnRQYC7w2sh4SA2ZfgG4vF/VscWSBqGlNYQt+
	 4Q5vtruZ8AV/sz8C+1GnqaSvcO8UI8tH/5khH/FFuGBlVUpPjPKanulqpDFZzJHMCR
	 oarX44rFCstdA==
Message-ID: <sashiko-outbox-191627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261030212112.2598640-13-seanjc@google.com>
References: <20261030212112.2598640-1-seanjc@google.com>
 <20261030212112.2598640-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 23:16:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_al=
l_nested()
--

commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
Author: Sean Christopherson <seanjc@google.com>

KVM: Destroy memslots immediately after mmu_notifiers are unregistered

This commit replaces active memslots with an empty memslot set and frees all
memslots immediately after unregistering the MMU notifier in kvm_destroy_vm=
(),
prior to calling kvm_arch_destroy_vm().

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fa548b12228ff..2eda12a52bf4b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm->mn_active_invalidate_count =3D 0;
>  	else
>  		WARN_ON(kvm->mmu_invalidate_in_progress);
> +	kvm_destroy_memslots(kvm);
> +
>  	kvm_arch_destroy_vm(kvm);
>  	kvm_destroy_devices(kvm);
> -	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> -	}

[Severity: Medium]
Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV when
destroying a VM with nested virtualization enabled?

In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i]
with kvm_empty_memslots and frees each memslot via
kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memslot_h=
v()
in arch/powerpc/kvm/book3s_hv.c:

    static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
    {
            vfree(slot->arch.rmap);
            slot->arch.rmap =3D NULL;
    }

which frees the slot->arch.rmap array without freeing the linked
struct rmap_nested entries.

Previously, those entries were freed before memslot destruction via
kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:

    srcu_idx =3D srcu_read_lock(&kvm->srcu);
    kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
            kvmhv_free_memslot_nest_rmap(memslot);
    srcu_read_unlock(&kvm->srcu, srcu_idx);

With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
already been freed when kvmhv_release_all_nested() runs, so
kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
entries remaining in slot->arch.rmap at teardown (for example, when
KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return early,
or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte())
will be leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.2598=
640-1-seanjc@google.com?part=3D12
