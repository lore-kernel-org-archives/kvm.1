Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315F39EF2E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039489; cv=none; b=S840S2wTKg8hVHOe5DVUnVElKci6ZTg/axCb4lC4RYzsnJQSuT8vkwzZ7kV4M8NESP0DEbxHEd2rzSdp/e9WU/8GJqjOfW1vtmEoBHx8VxG/ApmBtOepc2QpsqhYN/giThaJYKM8n02j/nLStkBGZw/NJiWUUWGK2Vms7c5BPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039489; c=relaxed/simple;
	bh=1CXNIaFa5b8R76gVBrs+gftIR9XDhZ6PEsxzC5hne34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdC/RQGKJu6dyQYTbuITxgsI27os7bMYJi3Sea6myH5qIroSHs/5KpbWfJagZ4MV+y0VulWnpv8e5XstuvV5I3AwCD5PW0R7uUC3h9F/gVvnkizUxbFsXZx9E+FWqR2Pd36k6oINmn8afDBdBFB1/In4AeTak/1ncauYj0IHRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXgbi0Gs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXgbi0Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A921F00893;
	Fri, 29 May 2026 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780039488;
	bh=oTM6FHzxYipnMgJq0xKNl6zVF7S+Y+3vmkGpDXPfaTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXgbi0GsW8P3cs5dGKaMFEYmR0mt1v7DDBY6sllwCEL3+cgTlISfYAs3zBtyj6edh
	 FhTUb3fEr9ePh8sqp4njj2Xn+QdT0S0lApzndTq2S+9JFfH7UuBXQ2dbMNVA/XHvRA
	 zukK1yhhTF84G7QG0SiTMrL6A4LGtpUerxcibcB5VUkyYdoOUsGIFoKDBcJL5ROYo/
	 zOQLJLjTJPVA4SrC5qk5gqrrc862pUjTLXHLnhOTpY6N+w6hxARFcgtD8xIA5B0m6H
	 Uzq1BrmKRBzGhlqlqzm8niI68bj80/QReRaJnwXoylmZFHFXaYwcfHKzzP+MZZDNGM
	 vCBacKC1p2jmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] KVM: RISC-V: SBI FWFT: Fix stale feature
 exposure after runtime extension changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528-kvm-get_reg_list-v2-v3-1-170969a8599f@sifive.com>
References: <20260528-kvm-get_reg_list-v2-v3-1-170969a8599f@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 07:24:47 +0000
Message-Id: <20260529072448.21A921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Spurious hardware probe failure due to unprotected CSR read-modify=
-write sequence
--

commit 1818d2355a5a82890474d03e62ad6819c760155a
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension c=
hanges

This commit fixes a bug where FWFT features could be incorrectly exposed
to guests after userspace disables their dependent ISA extensions at runtim=
e.
It introduces an init callback for features requiring hardware probing and
adds runtime checks to re-evaluate feature availability based on current ISA
extension state.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..dde6e39aab5e9 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -137,10 +147,12 @@ static bool try_to_set_pmm(unsigned long value)
> =20
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
>  	fwft->have_vs_pmlen_7 =3D try_to_set_pmm(ENVCFG_PMM_PMLEN_7);

[Severity: High]
This is a pre-existing issue, but could this hardware probe sequence fail
sporadically due to preemption?

Looking at try_to_set_pmm(), it executes a sequence on the host CSR_HENVCFG:

static bool try_to_set_pmm(unsigned long value)
{
        csr_set(CSR_HENVCFG, value);
        return (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) =3D=
=3D value;
}

Since this is called during vCPU initialization which runs in a preemptible
process context, could the thread be preempted and migrated to a different
physical CPU between the csr_set() and csr_read_clear() instructions?

If a migration occurs, it seems the read might happen on the new CPU's
unmodified CSR_HENVCFG, returning 0 and causing a spurious hardware probe
failure.

Would it be safer to explicitly disable preemption across this hardware CSR
sequence to ensure the VCPU reliably exposes pointer masking capabilities?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-kvm-get_re=
g_list-v2-v3-0-170969a8599f@sifive.com?part=3D1
