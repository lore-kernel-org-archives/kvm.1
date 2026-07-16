Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E52F3C3E
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227164; cv=none; b=XQ4PLEGEGWwpeljFlRI2mNA1eqchslpyZyFIx6ehBvsjcNI3gSLsdmPRyr9jZZrulfr5mV2gu1HXG/lYl9Fo0ndumnJJjJGyTphg9LV/JjSk2Oi5f4J3g1vhwDqJEWUUkcL0VMjmt/NaWhKFWl5rsFdSe2grNWwQLd04RjuAT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227164; c=relaxed/simple;
	bh=tiw8gGPlEiND6zzq2H1vgaZ6xOevaTu2V2Bx+peYyK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNVmO5Qc1ga9YEtIMKPOxEQ2sSK7wHwJ5fWwqH0/d8iEidINn2qZCzc623E6LvEVWWnbw6dvc3CB2ya9Rl6PSK9+UGPiKG7np41qXs6iFZQ4x/vEkx6sTeYLeBjNgDHa3c5+ZBN+Wt4/v7ikpzMJtqOBmAZ3ZgIbrLjY+4Evuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUtNauSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUtNauSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD05F1F000E9;
	Thu, 16 Jul 2026 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227162;
	bh=xZ6Te2FS4D5qeRjaZNke/tm3OpeKVGZ4zOsaM9mHfn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUtNauSyyF1eNpv5Z2EYuEl9YXhCxU2oL8oTANf9bUu8VVku24Ob72PGKQl0GgvhY
	 MX7AbkiE88j1OR3o49YxGmpV/ngdGybW0qBfIhVCiS5FL3gTb4k3N/9uKbUHADX6l4
	 ET1Na9wFoQwkADpp9X0SBOlp/j+P/ebIpcrspm36Lrqf+XtkKbzDpRGVBpl+PdsyR2
	 3CZ4PF22npXleREHLiUsIFEdyaPMPFuDFEqRFQzt6IcdFTKlLYRQVTWl3WyeysvWXM
	 I+d+mk/KK1u5WvKV4mgqEACc96oTxjV1+81TwrWfXwPQf8c2XuKOpncD8uYhVikjGt
	 fnOXEmY/irXfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/24] KVM: Introduce NR/NW/NX memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-10-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:39:22 +0000
Message-Id: <20260716183922.AD05F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] KVM advertises and accepts memory protection attributes (NR/NW=
/NX) but fails to enforce them in the MMU, leading to guest sandbox bypass.
- [High] A guest-controlled ioctl can trigger an unbounded, non-yielding lo=
op holding `mmu_lock` in write mode, causing host soft lockups.
- [Medium] `kvm_range_has_memory_attributes()` incorrectly assumes any pres=
ent XArray entry means non-zero attributes, ignoring the `mask`.
- [Low] Incorrect usage of `WARN_ON_ONCE` with a string literal condition.
- [Low] Leftover debugging code (`trace_printk`) and unresolved `// todo:` =
comments in production code.
--

--- Patch [9]: [PATCH 09/24] KVM: Introduce NR/NW/NX memory attributes ---
commit dce195fe8dd20af5f86a55891fc7d52cd1a8ed11
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce NR/NW/NX memory attributes

This commit introduces memory attributes to map guest physical memory
regions as non-readable, non-writable, and/or non-executable. It defines
the KVM_MEMORY_ATTRIBUTE_NR/NW/NX flags and adds basic architecture-specific
callbacks for x86 to support these protection attributes.

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 3b235e9539239..6a96eb3218dc4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1653,6 +1653,9 @@ struct kvm_memory_attributes {
>  	__u64 flags;
>  };
> =20
> +#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
> +#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
> +#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)

[Severity: Medium]
Does the introduction of multiple memory attributes break the fast-path
optimization in kvm_range_has_memory_attributes()?

If attrs =3D=3D 0, the fast-path optimization ignores the mask:

virt/kvm/kvm_main.c:kvm_range_has_memory_attributes() {
    ...
	if (!attrs)
		return !xas_find(&xas, end - 1);
    ...
}

Now that there are multiple attributes, a page might have
KVM_MEMORY_ATTRIBUTE_NR set but KVM_MEMORY_ATTRIBUTE_PRIVATE cleared.
If a caller checks if PRIVATE is 0 (i.e. mask =3D KVM_MEMORY_ATTRIBUTE_PRIV=
ATE,
attrs =3D 0), the function incorrectly returns false simply because the NR =
entry
exists in the XArray.

>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> =20
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_gue=
st_memfd)

[ ... ]

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 80f581afb6a01..b6463b0b0b6d4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -8088,16 +8087,23 @@ bool kvm_arch_pre_set_memory_attributes(struct kv=
m *kvm,
>  	}
> =20
>  	/*
> -	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
> -	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
> -	 * can simply ignore such slots.  But if userspace is making memory
> -	 * PRIVATE, then KVM must prevent the guest from accessing the memory
> -	 * as shared.  And if userspace is making memory SHARED and this point
> -	 * is reached, then at least one page within the range was previously
> -	 * PRIVATE, i.e. the slot's possible hugepage ranges are changing.
> -	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
> -	 * a hugepage can be used for affected ranges.
> +	 * For KVM_MEMORY_ATTRIBUTE_PRIVATE:
> +	 *  Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
> +	 *  supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
> +	 *  can simply ignore such slots.  But if userspace is making memory
> +	 *  PRIVATE, then KVM must prevent the guest from accessing the memory
> +	 *  as shared.  And if userspace is making memory SHARED and this point
> +	 *  is reached, then at least one page within the range was previously
> +	 *  PRIVATE, i.e. the slot's possible hugepage ranges are changing.
> +	 *  Zapping SPTEs in this case ensures KVM will reassess whether or not
> +	 *  a hugepage can be used for affected ranges.
> +	 *
> +	 * For KVM_MEMORY_ATTRIBUTE_NR/NW/NX:
> +	 *  Zap even when loosening restrictions R=3D>RW, which is nost strictly
> +	 *  necessary, but will allow KVM to reasses whether a hugepage can be
> +	 *  used for the affected pages.
>  	 */

[Severity: High]
Does setting these new attributes trigger an unbounded, non-yielding loop
holding the MMU lock?

When the KVM_SET_MEMORY_ATTRIBUTES ioctl is called, it eventually calls
kvm_arch_post_set_memory_attributes():

arch/x86/kvm/mmu/mmu.c:kvm_arch_post_set_memory_attributes() {
    ...
	for (gfn_t gfn =3D range->start; gfn < range->end; gfn++) {
		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
			gen_update =3D true;
			trace_printk("needs gen update! %llx\n", gfn);
			goto exit_loop;
		}
	}
exit_loop:
    ...
	// todo: what to do with kvm_tdp_mmu_zap_invalidated_roots()?
	// add kvm_arch_post_set_memory_attributes_unlocked?
	return false;
}

Since the GFN range is controlled by the ioctl and can be massive, and the
loop executes under mmu_lock for write without cond_resched(), could this
freeze KVM and trigger host RCU stalls and soft lockups if no GPTEs are
found to break the loop early?

[Severity: Low]
Are the trace_printk() and literal "// todo:" comments in the above snippet
intended to remain in production code?

Using trace_printk() permanently allocates a large trace ring buffer at boot
and emits a loud warning banner in dmesg.

> +
>  	if (WARN_ON_ONCE(range->end <=3D range->start))
>  		return false;

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fa4473d7c920a..a47b62c2c9cee 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2421,10 +2421,15 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kv=
m *kvm,
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  {
> +	u64 supported_attrs =3D 0;
> +
> +	if (kvm_arch_has_memory_protection_attributes(kvm))
> +		supported_attrs |=3D KVM_MEMORY_ATTRIBUTE_PROT;
> +

[Severity: Critical]
Does KVM advertise and accept memory protection attributes without enforcing
them in the MMU?

KVM advertises KVM_MEMORY_ATTRIBUTE_PROT support to userspace here and allo=
ws
setting NR/NW/NX. However, the page fault handlers (e.g.,
__kvm_mmu_faultin_pfn, direct_page_fault, kvm_tdp_mmu_map) do not appear to
query kvm_get_memory_attributes() to intersect the requested access with the
memory attributes.

When the guest faults again after the SPTEs are zapped, the SPTE is rebuilt
with full host permissions, bypassing the memory protections entirely. Can =
this
allow a guest to escape the intended sandbox?

>  	if (kvm_arch_has_private_mem(kvm))
> -		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +		supported_attrs |=3D KVM_MEMORY_ATTRIBUTE_PRIVATE;
> =20
> -	return 0;
> +	return supported_attrs;
>  }

[ ... ]

> @@ -2596,6 +2601,25 @@ static int kvm_vm_set_mem_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
> =20
>  	return r;
>  }
> +
> +bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsi=
gned long attrs)
> +{
> +	WARN_ON_ONCE("KVM_MEMORY_ATTRIBUTE_PROT requires kvm_arch_mem_attribute=
s_supported_prot()");

[Severity: Low]
Should this use WARN_ONCE(1, "...") instead?

The WARN_ON_ONCE macro expects a boolean expression. Since a string literal
evaluates to true, this will print the string's memory address or pointer as
the condition in the stack trace instead of the intended message.

> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D9
