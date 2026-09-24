Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F4334BC
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237820; cv=none; b=am4EQM5fW/CatdTauZh1QGIhos4iBdMV0d9p4uiahws6CqW6uoN1MnHcLsAtrckRXtFg6RJEBA6ol/Dk9L+DhSGY8YVN+NHc0yeWstiKkUQTYr5bxQbZGAkBudEKc12+orGqXjwqTF9jFp3un0DM0MLKjKHj46YVTe5Chl2m5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237820; c=relaxed/simple;
	bh=RAwTc8wSK+pF7Rjqyv4CKEBKuyOyb9g0qb5WuE7P0SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ESGriXE6AbZZdwFNXh3FYybybsVdCObCCpz/kLpiFHyimJJqg4MaZz7v/sCbDqY0qngXh0oEB1zJx1w4OK3IudTIRWJsW+mk6EYjrARTOYIM6sDkpWIofXOczu/hCPjCGxJm89q40kLgiX4f3b81jDT5vjmzhdZgkG4iU9Zl1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpn1i0wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpn1i0wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8D1F000FF;
	Thu, 24 Sep 2026 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790237818;
	bh=LvMb9fM1jynmoWPzqnhVN9ka1qhu/3SBIsjjNEi3ELE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpn1i0wbUHRfcjfUSBvT/j/jSAwAdMQhhMNtXk7quys8EhsvN9r25jWFo/bBmCuxf
	 IqdrqrEdTShSYzQmpjlmjobhki0QYYdTU8Snqj04nhdoJIymtyvUYUlgzLgl2J/N2B
	 Us3e0qBA3fw19Zmi1QP6v0Wgslz3E6NOJny8gQt8pWjGPSWn8v0Xxxo2/0NB6QeUpr
	 uo8PANbTMOyH8D5A05B4v2WaH0QbprfWxojxqEa/7cb62bh08p/UXKobJ/0bsLIeXV
	 dP2QPeVzeJ3n1lKPjUrxr2GLBqqkftrHr4/ltzDlYJHEOlEnGcFHun4P56z4LyLd7G
	 sgz5P3ir3u30w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: fix the Zicbo[m|z|p] block sizes in
 GET_ONE_REG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260924-kvm_fix_cbosize-v1-1-e57eec1b19cb@sifive.com>
References: <20260924-kvm_fix_cbosize-v1-1-e57eec1b19cb@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:16:57 +0000
Message-Id: <20260924081658.53E8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: riscv: reversed logic in GET_ONE_REG for Zicbo block sizes
--

commit 66e4542b7a02ac3b1e7a491baa6d04283e1ccc3a
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

RISC-V: KVM: fix the Zicbo[m|z|p] block sizes in GET_ONE_REG

This commit modifies the ternary operator logic used to determine the Zicbo
block sizes reported to KVM userspace via GET_ONE_REG. It changes the
previous behavior to return the block size or 0 based on host extension
support.

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 877ba823fc747..f2b1255694491 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -50,13 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_v=
cpu *vcpu,
>  		reg_val =3D vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -		reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : riscv_cbom_block_=
size;
> +		reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? riscv_cbom_block_size=
 : 0;

[Severity: High]
Does this change reverse the intended logic and cause a regression in the K=
VM
userspace ABI?

Looking at kvm_riscv_vcpu_get_reg_config() in arch/riscv/kvm/vcpu_onereg.c,
kvm_riscv_isa_check_host() returns 0 on success (supported) and -ENOENT on
failure.

Because 0 evaluates to false in C, the updated ternary operator returns 0
when the extension is supported, and the block size when unsupported (-ENOE=
NT
evaluates to true).

This causes KVM userspace to receive a 0 block size for supported extension=
s,
which can prevent VMs from starting or cause guest crashes when performing
cache operations.

>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> -		reg_val =3D (kvm_riscv_isa_check_host(ZICBOZ)) ? 0 : riscv_cboz_block_=
size;
> +		reg_val =3D (kvm_riscv_isa_check_host(ZICBOZ)) ? riscv_cboz_block_size=
 : 0;

[Severity: High]
Is this subject to the same logic reversal as above?

In kvm_riscv_vcpu_get_reg_config(), the ternary operator for the ZICBOZ
extension similarly returns 0 when the host extension is supported.

>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
> -		reg_val =3D (kvm_riscv_isa_check_host(ZICBOP)) ? 0 : riscv_cbop_block_=
size;
> +		reg_val =3D (kvm_riscv_isa_check_host(ZICBOP)) ? riscv_cbop_block_size=
 : 0;

[Severity: High]
Does this also share the same logic reversal?

For the ZICBOP extension in kvm_riscv_vcpu_get_reg_config(), the ternary
operator evaluates to 0 when the host supports the extension.

>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
>  		reg_val =3D vcpu->arch.mvendorid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-kvm_fix_cb=
osize-v1-1-e57eec1b19cb@sifive.com?part=3D1
