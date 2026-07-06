Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4F36A364
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305609; cv=none; b=FwU1dXOnF0VlMnhYoqW06HlX8UcuKLDYwlJfA657a16LoylMdo9HP3OnWyvXaQ5fu3UlmChJ0f+O7mZvpupPrcxBhLtiv02K1trHQiAzB+wgvrf9M3ZQJBi0jeyd3BwbkU5Br0fFkX56LXmj/tCPye442UWJA2yMqvIzIg+9FL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305609; c=relaxed/simple;
	bh=AfX6Mj08iQOonTDxss2nh/3Zdcn2MsK5s7QMBFukE8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2fxUeM0fSXLYtcPmHGaGdNL5ek31OUuoalJBSmZ+tbqiIWQFZ0MXpa6uWmjlvHkiuR4FB5+x1n7Pi6wnlpk+K0CMr8PXzRTFfMKwPssLD776jeRwowpSXshNndATJlCQJG+6ZCk0L5vX4l1SKVQcbCOCzv9/x8I1QGKjbflh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDLg3K4C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDLg3K4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB2E1F000E9;
	Mon,  6 Jul 2026 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305608;
	bh=uelY3EYO+ZJNkhO5tzN4dEy4iYPhYy4+ZMwyx650C9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDLg3K4CKP30Cy+j4XnXPhe0h5yWJfb4oweDU3qrPZK5wFtdpWwiFKpA6Q0duz1CK
	 RgOEluEsLoPczO/JX/UZ5ewo0PNuRSul6ffa9Trk+U9ooAxhtWCrdMYCNZw2q6Minc
	 vzfrV7qhKfvAO4Eta9kCULLLpBpEwZFjSRjdyG7PGvm/5Vu2F5D9WyTC2PH3LPBd82
	 RlBtBi+6YTmwIYFF4hBwzRNg3TrXbg+3ZpqT5cuyg8YxUI586YU8kGd/UVMSAUD02b
	 be9vdEaUso2mzB+tDEGkl1ALbpebKs6StcMvoDKCDmz6P8Qt94ELre2WYqGVFZQ8lw
	 bGwTttyTqZMzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706022046.214956-2-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
 <20260706022046.214956-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:40:06 +0000
Message-Id: <20260706024007.CCB2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling ncsr_write() with preemption enabled causes per-CPU memory=
 corruption when NACL is active, and unsafe host CSR modifications.
--

commit 08e867d22007707b3dd632ffff55b12837db2498
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add support for Svadu FWFT features

This patch adds support for the Svadu FWFT feature, controlling hardware
updating of PTE A/D bits through the ADUE bit in henvcfg. It allows the
guest and VMM to enable or disable this feature dynamically.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd8..01db40b532951 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -94,6 +95,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_=
feature_t feature)
>  	return false;
>  }
> =20
> +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> +					       u64 flag)
> +{
> +	vcpu->arch.cfg.henvcfg &=3D ~flag;
> +}
> +
> +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> +					     struct kvm_sbi_fwft_config *conf,
> +					     bool one_reg_access,
> +					     unsigned long value, u64 flag)
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
> +	if (!one_reg_access) {
> +		ncsr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			ncsr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);

[Severity: High]
Is it safe to call ncsr_write() here without preemption disabled?

KVM handles SBI ecalls with preemption enabled. The ncsr_write() macro
evaluates nacl_shmem(), which relies on this_cpu_ptr(). Using this_cpu_ptr()
with preemption enabled will trigger a CONFIG_DEBUG_PREEMPT warning.

Could the thread be migrated to another CPU after computing the pointer but
before writing to it, resulting in per-CPU memory corruption by writing to
the NACL shared memory of another physical CPU?

Additionally, when NACL is disabled, it falls back to csr_write(), which
writes directly to the physical CPU's host CSRs (CSR_HENVCFG). Could this
leave the host with modified hardware state if the vCPU thread migrates?

> +	}
> +
> +	return SBI_SUCCESS;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706022046.2149=
56-1-inochiama@gmail.com?part=3D1
