Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223781AA8
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313860; cv=none; b=NUaD2YvRdr1+X5ca3y33phVbpvCV6Qf29VwRZFvS/7ascopxLuDcHfm/I1rVsFsAFjv2NkRPhBjbt/R3SjuvqQs8+JvRvQFJTxYvraDat7q6D8CsaiPU+25X78P3N+JQs3aPpBMR2Fm458GVDffLpRli1BEVOERTBVnJIPS7Ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313860; c=relaxed/simple;
	bh=lOr4O0MVxV2ndVUSDNhUpuIKkr2/4d+hpyg23RWs9q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTzrFQlebXeSP3agQP702PvMc+fc18Wc7CrdPg3LtxyVxic7+DwL6IMjcfTXiROA7QLEa2yl+kl80awUHxlDOkJtdo3n8J1nGGQoqPPr5FyIE0NcWUZeWJ0HtgDgnOv9G8hkcXgfvpPDXrezpX42nrbZLT+2ZipqO7xZWUyzHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKusZAXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKusZAXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501F11F00893;
	Mon,  1 Jun 2026 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780313859;
	bh=BNBmvXepfislu0pX4USp7/aJBk2ogOS3lwslmQcFVE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKusZAXCLV9FV7Oxrw5gA9RUFOYEGwxKhnDQCbp4jZGhn2ySDNZ47VopgcDYqttlP
	 CC/XWk+dYFBaSO3O0eG/bq79euAlZOF6+sJkcfPZEpFOiqXhiBFwY0AmVUXAG5SI2B
	 rihFrTYmou+N1q0ht7NlvI8/aq922XPs4j8nHmRsGKmGVbj6ht49HvPgypYQYf9TjY
	 IfHhZ5Mi/HSO7u8YTP4AjRtrtKF57YCGemZO4o7nUtoAoEyaMuEa+kLw2zVlSOLR/N
	 Y48rALpIts+qUFPUh9uJvz14tom+OvlGBRIBSP7ngqGM/tCtNCcG48Drd6z0AwsEiB
	 eZkxbzwoQNsbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] KVM: RISC-V: SBI FWFT: Fix stale feature
 exposure after runtime extension changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-3-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-3-415d08a2813b@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 11:37:38 +0000
Message-Id: <20260601113739.501F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State mutation on error path in SBI FWFT set operation permanently=
 locks features on invalid requests.
- [High] Hiding FWFT features at runtime without reverting architectural st=
ate causes hardware to run with unadvertised features.
--

commit 7286cc45c5a1525ff749cb1b680b09d20f49fbe4
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension c=
hanges

Fix a bug where FWFT features could be incorrectly exposed to guests
after userspace disables their dependent ISA extensions at runtime. The
fix adds a two-layer checking mechanism to ensure feature availability
is re-evaluated based on the current ISA extension state.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index aee951f2b8e63..ab39ac464ffd8 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -527,6 +535,8 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>  	conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>  	if (!conf || !conf->supported)
>  		return -ENOENT;
> +	else if (conf->feature->supported && !conf->feature->supported(vcpu))
> +		return -ENOENT;

[Severity: High]
This isn't a bug introduced by this patch, but this dynamic check might lock
userspace out of clearing the feature state.

If userspace disables the prerequisite ISA extension (e.g. SMNPM) via ONE_R=
EG,
the extension is cleared from vcpu->arch.isa, but the dependent FWFT
architectural state in vcpu->arch.cfg.henvcfg remains intact.

If userspace then attempts to clear the FWFT feature state via ONE_REG, this
check returns -ENOENT because the underlying ISA extension is now disabled.

When the vCPU runs, kvm_riscv_vcpu_config_load() unconditionally writes the
stale henvcfg to the physical CSR_HENVCFG register:

arch/riscv/kvm/vcpu_config.c:kvm_riscv_vcpu_config_load() {
    ...
    csr_write(CSR_HENVCFG, cfg->henvcfg);
    ...
}

Will this cause the guest to run with unadvertised hardware features enable=
d?
Should the architectural state be reverted before hiding the feature, or sh=
ould
userspace be permitted to clear the state even if the feature is unsupporte=
d?

> =20
>  	switch (reg_num - feature->first_reg_num) {
>  	case 0:


[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in how
feature flags are handled during guest set operations:

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_fwft_set() {
    ...
	if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
		return SBI_ERR_DENIED_LOCKED;

	conf->flags =3D flags;

	return conf->feature->set(vcpu, conf, false, value);
}

If a guest issues an SBI_EXT_FWFT_SET call with an invalid value but sets
the SBI_FWFT_SET_FLAG_LOCK flag, conf->flags is updated unconditionally.

If the feature-specific set() callback rejects the invalid value and returns
SBI_ERR_INVALID_PARAM, the hypervisor will return this error to the guest
but the lock flag remains permanently set.

Does this permanently lock the feature on invalid requests, preventing
subsequent attempts to set a valid value? Should conf->flags only be
updated if the set() callback succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-kvm-get_re=
g_list-v2-v5-0-415d08a2813b@sifive.com?part=3D3
