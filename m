Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0776367B8D
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304203; cv=none; b=EuGntWFeJTp4sGMb6fRW/61yNW/7ElYT6EvqiRxrllgPUpdYMJsAdqbYSbKCA4czG8P8BHThWLNpv5MGPiA8I+mCKbNxq4j+/An3dhjZAJ6Z3ZB1YRow1+5jP+tDoeIZLJW8vJJKVBtrO1PucpZhLPbG72fp6zB9cMlKsXTkrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304203; c=relaxed/simple;
	bh=YpZXjVM7pQiqFlv64/Z4sOIz6rIxCWi8HxNUGGOmNkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQ0hNgv1tNC8l1nwh3Vx521RX+0FYet19bzuhcwDxqoLa2HSqPQGvvnAnf7wDIEtAEo1rNLv4bULbvvdjpn7GufYVNBl940ywG4faLryR8PMqujK556lgSf1o7k8+HFMgAtlg3z05e4/r+mZMv6Uffe06/r4m7ObCEATFBFYofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX52tI73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX52tI73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD651F00893;
	Mon,  1 Jun 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780304200;
	bh=KiOEXeV9WlqvDTZfopxJAwQK8d5z2g93sfJyxcA7E8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VX52tI73f0zCYSmHRK2KF8fvkMMcAdfYORulNLBZEC65FCDT54Qm/OjvcG1fX0Xk8
	 n34mK6Vfbh0r9OiWqlyCt1nAGDXjeFf/BC2DshdqqsSqo1M3oeAWgL+3zI4pIqRTAU
	 xFXsIQBSZ6mymGJFy+y9KoYrSiMGNrTXwREdzgn/pmIh6NNUvdGls73+dyy5+dZRcl
	 P2YiQnAEAPlvWafD0HB3MHXE5jBwE25UW96zT4aA0kPgopmidJOxoh/kGCsIBE7/X3
	 TVeuhryQ31mgzXkTU6QiMZYYhx8E8aO9DC4SKN8mmW4KUn4ZpYR3SYoiGwiS4szZUB
	 aexLliWApaeqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] KVM: RISC-V: SBI FWFT: Fix stale feature
 exposure after runtime extension changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-kvm-get_reg_list-v2-v4-1-c88abc81ebda@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v4-1-c88abc81ebda@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 08:56:39 +0000
Message-Id: <20260601085640.3CD651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying the host CPU's CSR_HENVCFG register during vCPU initiali=
zation without a `vcpu_load()` context corrupts KVM's lazy CSR restore prot=
ocol, silently breaking the hardware state of previously preempted vCPUs.
- [High] The runtime hardware probe for PMLEN availability in `try_to_set_p=
mm()` fails to clear the `PMM` bits in `CSR_HENVCFG` before probing, leadin=
g to incorrect capability detection due to stale hardware state.
- [High] FWFT set callbacks for `KVM_SET_ONE_REG` modify configuration CSR =
values without marking the vCPU's CSRs as dirty, causing the fast-path vCPU=
 load to bypass syncing the updated configuration to hardware.
--

commit d959405261fa6c3dcd522a13db8a39c36f4243be
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension c=
hanges

This commit fixes a bug where FWFT features could be incorrectly exposed
to guests after userspace disables their dependent ISA extensions at runtim=
e.
It introduces an optional init() callback to separate one-time hardware
detection logic from the runtime availability checks.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..2ad269a210214 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -137,13 +147,17 @@ static bool try_to_set_pmm(unsigned long value)
> =20

[Severity: High]
This is a pre-existing issue, but does the runtime hardware probe for PMLEN
availability in try_to_set_pmm() fail to clear the PMM bits in CSR_HENVCFG
before probing?

KVM uses csr_set(CSR_HENVCFG, value) to probe PMM bits, which performs a
bitwise OR. If the physical CPU retains leftover bits, setting PMLEN_7 resu=
lts
in a combined value. The subsequent csr_read_clear() check then fails, fals=
ely
marking supported hardware features as unavailable.

Is a preceding csr_clear(CSR_HENVCFG, ENVCFG_PMM) required before csr_set()=
 to
ensure correct capability detection?

>  static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu=
 *vcpu)
>  {
> -	struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +	return riscv_isa_extension_available(vcpu->arch.isa, SMNPM);
> +}
> =20
> -	if (!riscv_isa_extension_available(vcpu->arch.isa, SMNPM))
> -		return false;
> +static bool kvm_sbi_fwft_pointer_masking_pmlen_init(struct kvm_vcpu *vcp=
u)
> +{
> +	struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> =20
> +	preempt_disable();
>  	fwft->have_vs_pmlen_7 =3D try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
>  	fwft->have_vs_pmlen_16 =3D try_to_set_pmm(ENVCFG_PMM_PMLEN_16);

[Severity: High]
This is a pre-existing issue, but does modifying the host CPU's CSR_HENVCFG
register during vCPU initialization without a vcpu_load() context corrupt
KVM's lazy CSR restore protocol?

When try_to_set_pmm() clears ENVCFG_PMM bits, it clobbers the lazily-preser=
ved
CSR_HENVCFG state of whichever vCPU most recently ran on that physical CPU.
When that vCPU resumes, KVM skips reloading the CSR (if !vcpu->arch.csr_dir=
ty),
causing the vCPU to run with corrupted pointer masking state.

Should this hardware mutation be executed within a vcpu_load() / vcpu_put()
boundary to avoid silently breaking the hardware state of previously preemp=
ted
vCPUs?

> +	preempt_enable();
> =20
>  	return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
>  }

[ ... ]

> @@ -502,6 +528,8 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>  	conf =3D kvm_sbi_fwft_get_config(vcpu, feature->id);
>  	if (!conf || !conf->supported)
>  		return -ENOENT;
> +	else if (conf->feature->supported && !conf->feature->supported(vcpu))
> +		return -ENOENT;
> =20
>  	switch (reg_num - feature->first_reg_num) {
>  	case 0:

[Severity: High]
This is a pre-existing issue, but do the FWFT set callbacks for
KVM_SET_ONE_REG modify configuration CSR values without marking the vCPU's =
CSRs
as dirty?

When userspace modifies FWFT state via kvm_sbi_ext_fwft_set_reg(), the .set
callbacks update vcpu->arch.cfg.henvcfg or vcpu->arch.cfg.hedeleg in memory
but fail to set vcpu->arch.csr_dirty =3D true.

If the vCPU resumes on the same physical CPU it ran on previously,
kvm_arch_vcpu_load() evaluates !vcpu->arch.csr_dirty as true, triggering the
fast-path skip of kvm_riscv_vcpu_config_load().

Could this cause the guest to execute with stale CSR configurations, breaki=
ng
functionality?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-kvm-get_re=
g_list-v2-v4-0-c88abc81ebda@sifive.com?part=3D1
