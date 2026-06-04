Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A0478E5A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577999; cv=none; b=EGHQYolx+FGtfnZLoJadU9fmbQ3804WIh1soBEmlv+C9t/clioCowKcd/2CYMcet5eCDKa/rqxloyFMP981ltHHvcYWau45TghLAUMw5/gMlqoAsWuAcKKnEtjN1QngAIGnCzQawnzNxl2vLYOOJotG6iPElgdPN4U7GBgrQyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577999; c=relaxed/simple;
	bh=D9rqrC++/PNHmcV5lESFIpKfINKfIitgRZDK+5jf1v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HnPdaVM0/55vTPvpYcbTCdMvVPS3oAfkQawQmjpWPRUmCwvzE+rfzisRGhlmgJRU1qfOf7CSENWvWccQMoqP/1r/wqSxztzQhsq+EGFS6UhhuUjlM3FApm4ZEGxXyzCOTrt++0wKRd5mLpozPh5f3XC5DgU2FlioQBYysVIButA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2ojeHw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2ojeHw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F211F00893;
	Thu,  4 Jun 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780577998;
	bh=G8Bbb1ClJk3/SEhaeFcOAJ927CU6rKfdRuN4dCl7bRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2ojeHw6pHMmCKzXO7DnN/kIDJAn7gs9zUHPmSQfeoheiq/h9yR+bib66diX5wPWu
	 VhA5MDyNC1gnxAyEp7SPY19rtUwfpSxN6hPVp0bOv36jxylRQZ9wtxFJGsiVCCUHN4
	 TPRaboI6OGk/+XyHOMLQTqn/5ViDiSRF/oDxQkoqxEtV+PnlBhi5DwBPbAp57xoVtF
	 6Co7x4tCaSdpNAn0qOjMuCKPub+jbUIXLWiUjIfT9A8XyRfnZRPDAL+vkGJKaoh2im
	 YI44eQattKYLNIKJtHITDAUvf3/M9Kh4ir30cWC5lFrEV7JQEUIFkJWUjR0/jPNb7w
	 BEcJUl9licHtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: return full old CSR value from
 kvm_emu_xchg_csr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Ma" <maqianga@uniontech.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604123433.3182173-1-maqianga@uniontech.com>
References: <20260604123433.3182173-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 12:59:57 +0000
Message-Id: <20260604125958.97F211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Emulated instructions writing to $r0 corrupt `vcpu->arch.gprs[0]` =
for subsequent emulated instructions.
--

commit 8b252fdbff14650492d9c9a2864373942e2fb35e
Author: Qiang Ma <maqianga@uniontech.com>

LoongArch: KVM: return full old CSR value from kvm_emu_xchg_csr()

The LoongArch CSRXCHG instruction returns the full old CSR value in rd
after applying the masked update. kvm_emu_xchg_csr() currently masks
the saved value before returning it to the guest, so rd receives only
the bits selected by the write mask.

That breaks the architectural behavior and makes a zero mask return 0
instead of the previous CSR value. Keep the masked CSR update, but
return the unmodified old CSR value.

Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
Cc: stable@vger.kernel.org
Signed-off-by: Qiang Ma <maqianga@uniontech.com>

> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 3b95cd0f989b0..264813d45cbe0 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct kvm_vcpu=
 *vcpu, int csrid,
>  		old =3D kvm_read_sw_gcsr(csr, csrid);
>  		val =3D (old & ~csr_mask) | (val & csr_mask);
>  		kvm_write_sw_gcsr(csr, csrid, val);
> -		old =3D old & csr_mask;
>  	} else
>  		pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", csrid, vcpu->ar=
ch.pc);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the return value from
kvm_emu_xchg_csr() overwrite vcpu->arch.gprs[0] if the destination
register rd is 0?

Looking at the caller kvm_handle_csr() in arch/loongarch/kvm/exit.c:

	switch (rj) {
	case 0: /* process csrrd */
		val =3D kvm_emu_read_csr(vcpu, csrid);
		vcpu->arch.gprs[rd] =3D val;
		break;
	...
	default: /* process csrxchg */
		val =3D vcpu->arch.gprs[rd];
		csr_mask =3D vcpu->arch.gprs[rj];
		val =3D kvm_emu_xchg_csr(vcpu, csrid, csr_mask, val);
		vcpu->arch.gprs[rd] =3D val;
	}

Since $r0 is hardwired to 0 on LoongArch, if a guest executes an emulated
instruction with $r0 as the destination, kvm_handle_csr() will write a non-=
zero
value to vcpu->arch.gprs[0].=20

KVM does not clear vcpu->arch.gprs[0] between VM exits. If the guest
subsequently executes another KVM-emulated instruction that uses $r0 as an
input, KVM will read the stale non-zero value instead of 0.

Can this corrupt the guest context state for subsequent emulated instructio=
ns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604123433.3182=
173-1-maqianga@uniontech.com?part=3D1
