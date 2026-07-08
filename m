Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A821C84A6
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483293; cv=none; b=Bqji+NDdpD68adzaUCYOZnh1bRTbazNOzp8KFS76VVYCKo4yKe2icDohXhdVPnbzQBcNM89M3sQAuBBLOziTzdh55f+guBm70t6/p1zfZuANVXj1NQ/vjgBb//8KvYIHUkZMT70wiEeoytjUp0YWPfSAdYe7WIGOKKutHjRRJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483293; c=relaxed/simple;
	bh=zTtBvWWHdtxh0ey2adYunlOAsBt0EVMBOMalsjiJWLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwq7tJ+XpRfvQ+chewQ4BxSDHQRLw3ksyilS6Q8oBfOF6msv8uz4VqYZ9b6ALaBrALyQ6ZaooEqYuN0w/wKAIxOYYwrVQWRMywyjkpHP6Mn+PuMz2GdmZaCHjGvJl3VcHaSdPn7skbuCegmXIaG92XRSv7etmJeaWuyglitSe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgQl1TrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgQl1TrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C7F1F000E9;
	Wed,  8 Jul 2026 04:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483291;
	bh=CiWpOqjEBOKCjt4D7XIPDy6D/CPok7fd/KJ8ewIvJzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgQl1TrDHr88dsEkORjVd1FH3zH1kvWc2k5Lq/cNcMbsHVxbdosnoL72PKDJKNVct
	 KHD6mI5DTWaXokN2nLfYJQyJznLx3LbrbecLevoUnktKu1PbV9D3F9fYvihGd5ROSv
	 Lf8DofLmB3u42gTOxPJYFS1ETSAcTPDu/0TJ6lihBbUmTBMWrb3qDD1eowQN/ookXV
	 KXxlU6LSwqUtcOGGnpBg8kl9gEChYrYc7xnAjYqFLtmxhq8ylz1lkTXcvSCnWUpMo+
	 4hio37qyc0j3V054qLKjFeIwyFhUCau7bRnrt5Qdis3w8SoTHfG5EzgcT19NPfWDK3
	 QEHntCgLktjNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/17] riscv: kvm: Use generated instruction headers
 for mmio emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-12-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-12-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:01:31 +0000
Message-Id: <20260708040131.94C7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Signed left shift leading to Undefined Behavior in `kvm_riscv_vcpu=
_mmio_return`.
- [High] Incorrect register extraction for RISC-V compressed load and store=
 instructions in KVM MMIO emulation leads to guest state corruption.

Pre-existing issues:
- [High] The `mmio_test_destroy` function calls `kvm_io_bus_unregister_dev`=
 without holding the required `kvm->slots_lock`.
--

--- Patch [12]: [PATCH v3 12/17] riscv: kvm: Use generated instruction head=
ers for mmio emulation ---
commit 8d80090faef41d1000ad8ee985dcdaa3df7c12d3
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kvm: Use generated instruction headers for mmio emulation

Migrate the mmio emulation code to use the generated instruction headers
instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index a1898ab8bbe85..78adc28308193 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c

[ ... ]

> -	} else if ((insn & INSN_MASK_C_LD) =3D=3D INSN_MATCH_C_LD) {
> +	} else if (riscv_insn_is_c_ld(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(ulong) - len);
> -		insn =3D RVC_RS2S(insn) << SH_RD;
> -	} else if ((insn & INSN_MASK_C_LDSP) =3D=3D INSN_MATCH_C_LDSP &&
> -		   ((insn >> SH_RD) & 0x1f)) {
> +		rd =3D riscv_insn_c_ld_extract_xd(insn);

[Severity: High]
Does kvm_riscv_vcpu_mmio_load miss the +8 register offset for compressed
instructions?

The old code used RVC_RS2S which mapped the 3-bit compressed register field
to architectural registers x8-x15. Without adding this offset, won't this
corrupt guest state by targeting registers x0-x7 instead?

[ ... ]

> -	} else if ((insn & INSN_MASK_C_SD) =3D=3D INSN_MATCH_C_SD) {
> +	} else if (riscv_insn_is_c_sd(insn)) {
>  		len =3D 8;
> -		data64 =3D GET_RS2S(insn, &vcpu->arch.guest_context);
> -	} else if ((insn & INSN_MASK_C_SDSP) =3D=3D INSN_MATCH_C_SDSP &&
> -		   ((insn >> SH_RD) & 0x1f)) {
> +		rs2 =3D riscv_insn_c_sd_extract_xs2(insn);

[Severity: High]
Similarly here in kvm_riscv_vcpu_mmio_store, does riscv_insn_c_sd_extract_x=
s2
also need the +8 offset added to map to the correct source register?

[ ... ]

> +		*((ulong *)(&vcpu->arch.guest_context) + vcpu->arch.mmio_decode.rd) =3D
> +			(long)data << shift >> shift;

[Severity: High]
Can this introduce undefined behavior in kvm_riscv_vcpu_mmio_return from a
signed left shift?

If a guest reads a value with the high bit set (like 0xFF for a 1-byte read=
),
casting data to long before the shift evaluates to 255 << 56. This
overflows the maximum positive value for a 64-bit signed integer.

The previous code safely did:
    (long)((ulong)data << shift) >> shift
   =20
Could we keep the unsigned cast before the left shift?

>  	}
> =20
>  done:

> diff --git a/virt/kvm/mmio_test.c b/virt/kvm/mmio_test.c
> index bd5f21a43ba87..b3fec6988333f 100644
> --- a/virt/kvm/mmio_test.c
> +++ b/virt/kvm/mmio_test.c

[ ... ]

>  static void mmio_test_destroy(struct kvm_device *dev)
>  {
> -	struct mmio_test *mmio_test =3D kvm_to_mmio_test_dev(dev);
> -
> -	kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS, &mmio_test->dev);
> +	kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS, &((struct mmio_test *=
)dev->private)->dev);

[Severity: High]
This is a pre-existing issue, but does mmio_test_destroy need to hold
dev->kvm->slots_lock around this call?

kvm_io_bus_unregister_dev has a lockdep_assert_held for kvm->slots_lock.
Since mmio_test_destroy is called during kvm_destroy_devices without
holding this lock, won't this trigger a kernel lockdep splat when
userspace closes the VM?

>  	kfree(dev->private);
>  	kfree(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D12
