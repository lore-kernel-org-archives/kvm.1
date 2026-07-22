Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1046EF9A
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707415; cv=none; b=poF3x7b0+fXgFxqY6opHnGZxNN8ez012H49GpYJQmieXKbl9mpmNW7FdfNbbvMCpBC7ZoENZiVIrt801g1JnMnkv5A6o29IeJpyDd5pNJ3WbtikF5SRlhG7PvGb1R5RRPcWTCoHzy016C5kSIX3D2VoPKMZmANNw3acahHBnREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707415; c=relaxed/simple;
	bh=ueQuY2k/YhmZTxmwvSq8RjHj8IW4s+2wuadO3pcxxxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1plgFybxXMRuTN8Fq0RxY8zg9iC1QbEBYX5AgzFhP7Hw84V485snSjMwldZEO0rgOK8dsnDB/kIQ/xjAinibentQZuD4nB5QDr/00GjLnIdR1A0Zpj7brIsJj3ytLbwTttvUgz560pLV96H6yzLzyDMD/ZXg5xZcyet05wTYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDgdVPbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDgdVPbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF2D1F000E9;
	Wed, 22 Jul 2026 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784707413;
	bh=gNZZSZunjUBNADrxLeteZpb5koToirugJjkcnviRQ5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDgdVPbrjY+48Llb6I215W63loMjtK29HESvAo6IxmoMKh+rE7VCP3mREXYD2t5AE
	 6U4t94uYCDlivqC/E2wnJKUEbPqDKXTN0cYWGaLeVNtmdh0DXwOY9ELDIR/YA1GzuJ
	 Fyny9mvqhM6hXkRg89/OE6E7vQbdlXw3FNladDMfJ1bbyMDKV6j5Elu54t+YFUWNBH
	 fCUTLL47nQXNuXvNmkxG4ccATwSsqDpfHZ3KlUXtNLHZVQzPkS1g5uef8NmVMKeRET
	 Y5gD9V3YPAzjUfFO4saQVWXvR3xRri3TPWIU3CBTagRnklEBplVNBrNjK8gEGU5UTG
	 ZbCAz+pgS7JMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Add KVM_LOONGARCH_GET/SET_CSR for
 bulk CSR migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722074346.239507-1-cui.tao@linux.dev>
References: <20260722074346.239507-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:03:33 +0000
Message-Id: <20260722080333.AFF2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing bounds checking on the user-provided CSR index allows =
arbitrary out-of-bounds kernel memory read and write vulnerabilities via in=
teger signedness conversion.
- [High] The new `KVM_LOONGARCH_GET_CSR` and `KVM_LOONGARCH_SET_CSR` ioctls=
 violate KVM enumeration invariants because they are not discoverable via a=
 KVM capability.
- [Medium] Missing validation of `pad` and `reserved` fields in UAPI struct=
ures prevents future extension.
--

--- Patch [1]: [PATCH v2] LoongArch: KVM: Add KVM_LOONGARCH_GET/SET_CSR for=
 bulk CSR migration ---
commit d9e42903e3c1617b11882f82d3b16f57b379c8ac
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Add KVM_LOONGARCH_GET/SET_CSR for bulk CSR migration

This commit introduces bulk get and set ioctls for migrating CSR state in a
single call, replacing the need for many KVM_GET/SET_ONE_REG calls. It adds
the KVM_LOONGARCH_GET_CSR and KVM_LOONGARCH_SET_CSR ioctls and their
associated data structures.

> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/inclu=
de/uapi/asm/kvm.h
> index cd0b5c11ca9c2..59b3b7efa0397 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h

[ ... ]

> @@ -127,6 +127,19 @@ struct kvm_sync_regs {
>  struct kvm_sregs {
>  };
> =20
> +/* bulk CSR entries for VM migration */
> +struct kvm_loongarch_csr_entry {
> +	__u32 index;
> +	__u32 reserved;
> +	__u64 data;
> +};
> +
> +struct kvm_loongarch_csrs {
> +	__u32 ncsrs;	/* number of csr entries */
> +	__u32 pad;
> +	__DECLARE_FLEX_ARRAY(struct kvm_loongarch_csr_entry, entries);
> +};
> +

[Severity: Medium]
Are the pad and reserved fields validated to be zero?

Looking at the kvm_loongarch_csr_io() implementation, the structure is copi=
ed
from user space but the padding fields are not checked. If userspace leaves
garbage data in these fields, could it prevent the kernel from safely
repurposing them for future feature flags without breaking ABI compatibilit=
y?

>  struct kvm_iocsr_entry {
>  	__u32 addr;
>  	__u32 pad;
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..9b411c694718c 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c

[ ... ]

> @@ -1009,6 +1009,73 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu =
*vcpu, struct kvm_sregs *sregs

[ ... ]

> +	for (i =3D 0; i < csrs.ncsrs; i++) {
> +		unsigned int id =3D entries[i].index;
> +
> +		if (get_gcsr_flag(id) & INVALID_GCSR) {

[Severity: Critical]
Could an attacker pass a value greater than or equal to 0x80000000 for
entries[i].index?

Since get_gcsr_flag() takes a signed int:

arch/loongarch/kvm/main.c:get_gcsr_flag() {
    if (csr < CSR_MAX_NUMS)
        return gcsr_flag[csr];
    ...
}

Would this unmasked 32-bit unsigned index be implicitly converted to a
negative integer, bypassing the csr < CSR_MAX_NUMS signed comparison?

If the out-of-bounds read of gcsr_flag happens to lack the INVALID_GCSR bit,
could this negative ID be passed to _kvm_setcsr() and eventually to
kvm_write_sw_gcsr(), leading to an arbitrary out-of-bounds 64-bit kernel
memory write?

> +			ret =3D -EINVAL;
> +			break;
> +		}
> +

[ ... ]

> @@ -1266,6 +1333,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			r =3D kvm_get_reg(vcpu, &reg);
>  		break;
>  	}
> +	case KVM_LOONGARCH_GET_CSR:
> +		r =3D kvm_loongarch_csr_io(vcpu, argp, false);
> +		break;
> +	case KVM_LOONGARCH_SET_CSR:
> +		r =3D kvm_loongarch_csr_io(vcpu, argp, true);
> +		break;

[Severity: High]
Does adding these ioctls without a corresponding KVM capability break KVM
enumeration invariants?

Since KVM_LOONGARCH_GET_CSR and KVM_LOONGARCH_SET_CSR are unconditionally
enabled here without a corresponding KVM_CAP_* constant, userspace tools li=
ke
QEMU might not have a programmatic way to discover if the running kernel
supports the new ioctls via KVM_CHECK_EXTENSION. Could this silently break
live migration or capability negotiation?

>  	case KVM_ENABLE_CAP: {
>  		struct kvm_enable_cap cap;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8e..aade65751721d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h

[ ... ]

> @@ -1670,4 +1670,8 @@ struct kvm_pre_fault_memory {
>  	__u64 padding[5];
>  };
> =20
> +/* LoongArch: bulk CSR get/set for migration */
> +#define KVM_LOONGARCH_GET_CSR	_IOWR(KVMIO, 0xd6, struct kvm_loongarch_cs=
rs)
> +#define KVM_LOONGARCH_SET_CSR	_IOW(KVMIO,  0xd7, struct kvm_loongarch_cs=
rs)
> +
>  #endif /* __LINUX_KVM_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722074346.2395=
07-1-cui.tao@linux.dev?part=3D1
