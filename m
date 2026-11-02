Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642655;
	b=atxuhNwyVxd7URQ39r4B+FzuoLiia5JY2Iyzmo3/QJFC3si17sumccd3f2TgFQT5Y+uD
	 37xaAtsjxcg+FSuHv1h1ow0wjo6IGXqH92izCJKhnGhOolahadzv2q+79Q7f7DLXu8cKk
	 V9Qwof8yaT4KN2TfPPWae3e94B8n4Cnoux5Q6VfwlETw7/0gZTtBr/JusGwZSs7ZMcF+/
	 WXJPWbLrfZtp6LfQrKfawZ+zPOOSnkpX0s5Xwo/3GWOEKQyPgfq7+NXCtabsWgvL+fOtn
	 oJybmq3VzhEMQMk5OpWzBWKvfPN5t91VUhqOjQ6DygdL1wDrovJl2F9Nl/T+uca/iMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/GZK79Amf1BBoCmu4fsbgM4jSO74aG8LvFVSGH5lxEU=;
	b=1Q6c4i435Rq33pUJtKaBXm8eC0BgJn5AswaHWTxaqo43aBCDEn29OzN22rmdY2d53VzG
	 B172zPplPCEgZd61iU0uU4ZYEByrUD3O19zIpXFgTDCobVbVTdfzl4iTuRguwaLBtcrFm
	 MAmdi2P5ATz+H4jxMdJ/BJQBTQJEpdLaQTQu0klV4FR7S1JtSVZEKgfvCpX/nBD3iH030
	 npIPrP2YGEd5M3yGAufdCO/Qr0wJhpc/gGje7S0pkKZVpNivimBBnVhdErMvQliCoDyqm
	 IGSmsssIG2e/DBqIqmcl2schfWPgjYuzjo+a/A2f5XOKx+ZC1W3XswkFdfcqO9R0i0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3sHnmhO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F07606A595
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3sHnmhO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1A41F00A16;
	Mon,  2 Nov 2026 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642654;
	bh=/GZK79Amf1BBoCmu4fsbgM4jSO74aG8LvFVSGH5lxEU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=k3sHnmhOjKexPNqwB0VrLyyk1Bb0GMEh8pzYzFyc4Hd6WoaAZRpuAMzTrjK7i3+0E
	 vSTcjxq+AVOfy6bHymqXdYWPtTq1UL9rqgPq/EPBhjFioPsHBmN1OD5Tqsp7+VgZxT
	 c9bxw4H+9TH5BBBEjq0uDCfBFzEcbohJcVyx5nA8QbWEq4He0lISxOQiuYwlAyptTa
	 kqqxviq267GayJxdr2uqGupNWQ+vkgCE6sO3pCIuNAXPhkjYFO5yGfnifWNaqVyJC4
	 SQ9aVruBPbOPJYDLTxI1LXs8g/TE2uk9Z3qBjkBWukvTEH9ByeQED3QKuC6t0TlAUq
	 E5/cwxjtxLfvQ==
Message-ID: <sashiko-outbox-193900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/45] KVM: Introduce NR/NW/NX memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:04:13 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: wrong macro in #else of kvm_supports_memory_protection_attr=
()
- [Medium] KVM: x86: selecting KVM_VM_MEMORY_ATTRIBUTES on 32-bit breaks bu=
ild
--

commit 7813791b6014f78cd1b4dde881abb82a354594d5
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce NR/NW/NX memory attributes

This commit introduces the KVM_MEMORY_ATTRIBUTE_NR, KVM_MEMORY_ATTRIBUTE_NW,
and KVM_MEMORY_ATTRIBUTE_NX memory attributes to map guest physical memory
regions as non-readable, non-writable, and/or non-executable, and adds basic
support on x86.

Link: https://patch.msgid.link/20260918135030.171564-14-pbonzini@redhat.com

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1719059570fb7..3cde8bc5ff016 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -44,6 +44,7 @@ config KVM_X86
>  	select KVM_GENERIC_PRE_FAULT_MEMORY
>  	select KVM_WERROR if WERROR
>  	select KVM_GUEST_MEMFD if X86_64
> +	select KVM_VM_MEMORY_ATTRIBUTES

[Severity: Medium]
Does selecting KVM_VM_MEMORY_ATTRIBUTES unconditionally in config KVM_X86
break 32-bit x86 builds?

Previously, KVM_VM_MEMORY_ATTRIBUTES was selected by KVM_PRIVATE_MEMATTR_VM,
which only depended on 64-bit options (KVM_SW_PROTECTED_VM, KVM_INTEL_TDX,
and KVM_AMD_SEV). Selecting it unconditionally under KVM_X86 enables
CONFIG_KVM_VM_MEMORY_ATTRIBUTES on 32-bit x86 builds, which triggers the
compile-time assertion in virt/kvm/kvm_main.c:

kvm_vm_ioctl_set_mem_attributes() {
	...
	BUILD_BUG_ON(sizeof(attrs->attributes) !=3D sizeof(unsigned long));
}

Also, if KVM_VM_MEMORY_ATTRIBUTES is gated on X86_64, removing the
CONFIG_KVM_VM_MEMORY_ATTRIBUTES guards in arch/x86/kvm/mmu/mmu.c and
arch/x86/kvm/x86.c (around kvm_mmu_init_memslot_memory_attributes() in
kvm_alloc_memslot_metadata(), and the calls to kvm_get_vm_memory_attributes=
()
and kvm_range_has_vm_memory_attributes() in mmu.c) will leave those callers
referencing symbols that have no fallback definitions when
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is disabled.

[ ... ]

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3d0293ebc864a..8442fb29a1ee8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -726,6 +726,15 @@ static inline int kvm_arch_vcpu_memslots_id(struct k=
vm_vcpu *vcpu)
>  }
>  #endif
> =20
> +#ifdef kvm_arch_has_memory_protection_attr
> +bool kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned lo=
ng attrs);
> +#else
> +static inline bool kvm_arch_has_memory_protection_attr(struct kvm *kvm)
> +{
> +	return false;
> +}
> +#endif

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 17341c689d11a..717d7aec9a6c9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2473,13 +2473,28 @@ static u64 kvm_supports_private_mem(struct kvm *k=
vm)
>  #define kvm_supports_private_mem(kvm) false
>  #endif
> =20
> +
> +#ifdef kvm_arch_has_memory_protection_attr
> +static u64 kvm_supports_memory_protection_attr(struct kvm *kvm)
> +{
> +	return !kvm || kvm_arch_has_memory_protection_attr(kvm);
> +}
> +#else
> +#define kvm_supports_private_mem(kvm) false
> +#endif
> +
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
>  {
> -	if (gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
> -		return 0;
> +	u64 supported_attrs =3D 0;
> +
> +	if (kvm_supports_memory_protection_attr(kvm))
> +		supported_attrs |=3D KVM_MEMORY_ATTRIBUTE_PROT;

[Severity: Medium]
Should the #else branch here define kvm_supports_memory_protection_attr(kvm)
instead of kvm_supports_private_mem(kvm)?

On architectures that do not define kvm_arch_has_memory_protection_attr as a
preprocessor macro, the #else branch defines kvm_supports_private_mem(kvm)
as false. This leaves kvm_supports_memory_protection_attr() undeclared when
called by kvm_supported_vm_mem_attributes(), while also overriding the
preceding definition of kvm_supports_private_mem(kvm) on architectures that
define kvm_arch_has_private_mem.

In addition, when kvm_arch_has_memory_protection_attr is not defined as a
macro, include/linux/kvm_host.h omits the prototype for
kvm_arch_mem_attributes_supported_prot(), which is still compiled
unconditionally as a non-static __weak function in virt/kvm/kvm_main.c when
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled, causing a missing-prototype
warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D17
