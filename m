Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB733A9E9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483777; cv=none; b=htBC413N5DDKPyHbmwSdR156OWiI8He8LnW17VOUYXr0NsO9kQf96aUVgauguc1CtRo7N8xqcLswneTnopl6olsgW0dCKF7Dvd4GutiFwq6twfCyvitAhnHY+Btaf6H9Q8jdzoxPhH7IdDoUxR8/zHov2ex8+2UYDGP/P89xqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483777; c=relaxed/simple;
	bh=ljW+cwA7R28FLxZi53mQdus4awcRzFkR8iTRyaEuAwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ghLRl7F1qCa0+Da88vLUROO7502p9QwbTd/oYq6/EH74nzGfzg1Im95rfxpNSxtn8LNRwd5TtRV6AtaR+68dPFjvhA972GR8XGtMfEimeCBUo3LAWDS+DDqEhc5YXQnILAKNfijWUccj4h6W5qLTNJLCMnZlcdxMc9my6jng9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8jQZUMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8jQZUMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA8B1F000E9;
	Wed,  8 Jul 2026 04:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483775;
	bh=WAJz+0bm1Dl6RVFrPUmxqssf89i3M3rsfVcnFYNT7MA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8jQZUMuhjye8UnlrBUEAEEbipPHs/Z/mmR35I/tsI0F9lkZ/At50+34N0zReHW44
	 sI8F3eOAHVrIHC9vSivNsEIftdtv9s9bfRTnkqTc2e+tzBBtsnFmyXN+1sSD8+VZ/y
	 nq+6hzINTAJm6351We8vJTBhsWq906682K4IR80xVVby3Kf/812BEtvCv1lXqF0M6b
	 rdgJKPADUnZurUIHxFwB010djNPB5RwBt0fUAe7wE2ArV37+oGdjNzSSH+sN1JDPGP
	 6Gr1bY8jK14Rkb02xlPf1ZSCwZRFGbySgidKJb1xhZwehXDPIHRlg8TKtEuejwjibi
	 FTVHJTIqrg+jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/17] riscv: Remove unused instruction headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-17-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-17-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:09:35 +0000
Message-Id: <20260708040935.9BA8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The mmio_test_destroy() function calls kvm_io_bus_unregister_dev()=
 without holding the required slots_lock.
- [Medium] Missing sign-extension modifier for floating-point memory instru=
ction offsets in insn.tbl.
--

--- Patch [17]: [PATCH v3 17/17] riscv: Remove unused instruction headers -=
--
commit 4c51ea6677f4f9f14ba5d191936c510b5b961ed2
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Remove unused instruction headers

All usages of hard-coded riscv instruction have been migrated over to
the generated instruction headers so the old macros can be deleted.

> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index bf6f5d530491b..ea1f139d6d904 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
[ ... ]
> -#define RV_EXTRACT_UTYPE_IMM(x) \
> -	({typeof(x) x_ =3D (x); \
> -	(RV_X_MASK(x_, RV_U_IMM_31_12_OPOFF, RV_U_IMM_31_12_MASK)); })
> -
> -#define RV_EXTRACT_JTYPE_IMM(x) \
> -	({typeof(x) x_ =3D (x); \
> -	(RV_X_MASK(x_, RV_J_IMM_10_1_OPOFF, RV_J_IMM_10_1_MASK) << RV_J_IMM_10_=
1_OFF) | \
> -	(RV_X_MASK(x_, RV_J_IMM_11_OPOFF, RV_J_IMM_11_MASK) << RV_J_IMM_11_OFF)=
 | \
> -	(RV_X_MASK(x_, RV_J_IMM_19_12_OPOFF, RV_J_IMM_19_12_MASK) << RV_J_IMM_1=
9_12_OFF) | \
> -	(RV_IMM_SIGN(x_) << RV_J_IMM_SIGN_OFF); })
> -
> -#define RV_EXTRACT_ITYPE_IMM(x) \
> -	({typeof(x) x_ =3D (x); \
> -	(RV_X_MASK(x_, RV_I_IMM_11_0_OPOFF, RV_I_IMM_11_0_MASK)) | \
> -	(RV_IMM_SIGN(x_) << RV_I_IMM_SIGN_OFF); })
> -

[Severity: Medium]
Since we are removing these macros and relying on the generated instruction
headers, do the generated macros correctly handle sign extension?

In arch/riscv/tools/insn.tbl, the floating-point loads and stores (which use
standard I-type and S-type formats with 12-bit signed immediates) are decla=
red
with imm=3D instead of imm~=3D:

arch/riscv/tools/insn.tbl:
    ...
    fld common 011<12|0000111<0 imm=3D31-20 xs1=3D19-15 fd=3D11-7
    ...
    fsw common 010<12|0100111<0 imm=3D31-25|11-7 fs2=3D24-20 xs1=3D19-15
    ...

Because the ~ sign-extension modifier is missing, will the generated C
extraction macros (e.g., riscv_insn_fld_extract_imm) incorrectly zero-extend
the immediate offset instead of sign-extending it?

This could mathematically corrupt negative memory offsets (e.g., -8(sp)) in=
to
large unsigned positive numbers. Although no kernel code currently extracts
the immediate for these specific floating-point instructions, this acts as a
latent logical defect.

[ ... ]

[Severity: High]
Does mmio_test_destroy() need to hold the slots_lock here?

When a KVM VM is destroyed, kvm_destroy_devices() invokes mmio_test_destroy=
(),
which calls kvm_io_bus_unregister_dev().

virt/kvm/mmio_test.c:mmio_test_destroy() {
    ...
    static void mmio_test_destroy(struct kvm_device *dev)
    {
        kvm_io_bus_unregister_dev(dev->kvm, KVM_MMIO_BUS,
                                  &((struct mmio_test *)dev->private)->dev);
    ...
    }

Because kvm_io_bus_unregister_dev() contains a mandatory
lockdep_assert_held(&kvm->slots_lock), and slots_lock is not acquired by
kvm_destroy_devices() or the device destructor, this can trigger a lockdep
splat during VM teardown.

Can this be triggered locally by unprivileged userspace executing KVM
selftests or deliberately creating and closing a VM with the test device,
leading to kernel log spam and lockdep warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D17
