Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A13A7F60
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305725; cv=none; b=BwgNxQUTn9eXAXB6dYVsvVJq593XXz+OmpFV7Ahr8u2calcXggE2JuS9VSy0a0SWeDeTm3YLtJ0cYTCpYrhc5KVJOsILrzYcUFj3z4Y7UCQetICz74QozND/240MFoSL4vQ3s9Zqa1J13e0FIONrxd+Q6xsDvGJpCu/efN3zqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305725; c=relaxed/simple;
	bh=9emfFE57BwucBux8RQhGG53oqkpSLxhYKrULl/8sWnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n12bbe6tqSe+EqccuSheiaE7+52429kpXdXQcBqz6zYtbWbZn/bGThfyMR7idiPooRndrAuWe6Xw/9QJnNsx5b+nPPiEWqDKMDgBbOepZpzdWNRuF+0MuOsGLfOPKxWhVbwXaDM96QKHRefwe2lshNWQRl9rfyc7di4C9IH3zDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw9piDq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw9piDq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED71F000E9;
	Mon,  6 Jul 2026 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305723;
	bh=i7Kk9cSeb2oX9J7MsJUUhhqis/kpuvC9+TpIuioBxPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aw9piDq9UQAzvZEaJJTgbbNNjwxCnd/tyoufDNzgsqXUXE14DVaeAxexuVef5MlPd
	 BPtxnqRjyahTAUYIGTvS/SzDDq4VNysbR032z+D5RZsZFdrpT6dnS5Esd8Zbh3DR3c
	 C/37raYG5nXb721BlM2FnIljr9D45j5C3vZGuwxHwsuLXWlsAAHW0l6NV0ib20tc0P
	 4DmrlmXx12KA+F8wdAgq56xLyYiDg2BHnxY8eVZ7DyJ5YiyvOl/9s1IeK57USXykLE
	 Btr6dth1GY9Vhs0gm4XaS6Iupwtml4x5cqsXKfhQraBYDI25S8TuyVJcwwn/dxUYD8
	 7BQAfOhGAR14Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] RISC-V: KVM: Add support for control-flow
 integrity FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706022046.214956-8-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
 <20260706022046.214956-8-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:42:02 +0000
Message-Id: <20260706024203.5EED71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Evaluating `this_cpu_ptr()` in a preemptible context via the `ncsr=
_write()` macro causes potential nested hypervisor state corruption.
--

commit 3bf03d5d2c60c30185d31cbc3e653f9c3b28377b
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add support for control-flow integrity FWFT features

This commit adds support for exposing Control-Flow Integrity (CFI) FWFT
features (Zicfilp/Zicfiss) to VS-mode. It allows the VMM to control access
to these features by modifying the guest's henvcfg and hedeleg registers.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 01db40b532951..bc514ae6521d7 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> +static long kvm_sbi_fwft_set_cfi(struct kvm_vcpu *vcpu,
> +				 struct kvm_sbi_fwft_config *conf,
> +				 bool one_reg_access, unsigned long value,
> +				 u64 flag)
> +{
> +	struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
> +
> +	if (value =3D=3D 0)
> +		cfg->henvcfg &=3D ~flag;
> +	else if (value =3D=3D 1)
> +		cfg->henvcfg |=3D flag;
> +	else
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	if (cfg->henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
> +		cfg->hedeleg |=3D BIT(EXC_SOFTWARE_CHECK);
> +	else
> +		cfg->hedeleg &=3D ~BIT(EXC_SOFTWARE_CHECK);
> +
> +	if (!one_reg_access) {
> +		ncsr_write(CSR_HEDELEG, cfg->hedeleg);

[Severity: High]
Is it safe to call ncsr_write() here with preemption enabled?

When a guest makes an SBI_EXT_FWFT_SET call, the KVM exit handler
(kvm_riscv_vcpu_exit) explicitly enables preemption before processing
the exit.

Looking at the ncsr_write() macro, it uses nacl_shmem() which evaluates
this_cpu_ptr():

#define ncsr_write(__csr, __val)
    ...
    nacl_csr_write(nacl_shmem(), __csr, __val);

If the thread is preempted and migrated to another physical CPU between
evaluating the CPU pointer and performing the write, could this write to
the new CPU's view of the old CPU's memory?

This seems like it might corrupt the nested hypervisor state (like HEDELEG =
or
HENVCFG) of another running vCPU, as well as trigger CONFIG_DEBUG_PREEMPT
warnings.

> +		/*
> +		 * Both Bit LPE and SSE are in the lower part, so it is safe
> +		 * to only write the henvcfg
> +		 */
> +		ncsr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +	}
> +
> +	return SBI_SUCCESS;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706022046.2149=
56-1-inochiama@gmail.com?part=3D7
