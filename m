Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92E492E2B
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398137; cv=none; b=C+SAFsQvgpNB1oZoPrOVbnyLJ/5GrWRhnAlqcHRBb55L5Tm4jILPD4UdzrAi2LKICd+oinPLBADnffTpIJBaaFC4KWD47PoxD20vXv6UKh39DaN7ppW92mZYCR6cHrpUL0Z5KchhM/Mogdrc2fQh8BvIQFZWj2vRsXInuwvvcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398137; c=relaxed/simple;
	bh=TPGTnjpVf0WDSuEFgPl3kKsiDfrMjqyYE2CTILr49Ss=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lYdopA5LDd4j/2JQM+slTWSIlNRMcDnJIOnO4yx8RdSvCRYW+xjPVPveSS/zBTkxbd8ppPKpX6cbpDstRGThafc8PgiZ4dxId8zXk6mPuCb/CoV9j/dlv1Z6195TsRJ2LgBC0XNCkoyaKU4NuZ8SxolfQbYzQyF9WhLAmiSdNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb5xEn74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb5xEn74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972F21F000FF;
	Wed,  7 Oct 2026 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398135;
	bh=Fal5goMK7n7B9qHxJJcYsDNvNcYhEqB7CoURYyFf2cQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb5xEn74UGXCnoesq3LMdFB5tkS4eMogtfc2yReR1X9GN4aHwGN/Wh23lvEG3dFHA
	 lcTDVSxZTxPdujUaR/Th8EjYrW7phrZRYAVznU7aRvfC5ZN5//Bdx48G2JtT+4vNZJ
	 9BKKndDpEyAAkklvyMGFTbuBUlTgnphaas1P1XG4LMHATdhn+hp3Ya8pM8ZYdszWnF
	 ofn1O5lFSiVGCks62CEHc487DhYcfonW4LS/IpQ8c74nOHhUanPCyslgcrlHFu4+oZ
	 xKE0REWsVCZ5w/QdXKec2Sc6rWHwywgktZgUSTyKr42TK0w7XeDJfEh4qqtvsPTCbG
	 g/LYd0ZeR7Lww==
Message-ID: <sashiko-outbox-163294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] KVM: PPC: Fix get_d_signext() 12-bit
 displacement for paired-single D-form
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261007182608.17188-1-amachhiw@linux.ibm.com>
References: <20261007182116.12479-1-amachhiw@linux.ibm.com>
 <20261007182608.17188-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 18:35:35 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: ppc: out-of-bounds host memory access in magic page emula=
tion
--

commit 7a374e4096a679cdf2566d00b45341748bfbac50
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form

This commit fixes two compounding bugs in get_d_signext() related to
12-bit D-form displacements for paired-single instructions. It replaces
open-coded logic with sign_extend32 to correctly handle bit extraction
and two's-complement sign extension.

> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/=
book3s_paired_singles.c
> index bc39c76c9d9fe..532f96293de0f 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_=
vcpu *vcpu, u32 inst)
> =20
>  static int get_d_signext(u32 inst)
>  {
> -	int d =3D inst & 0x8ff;
> -
> -	if (d & 0x800)
> -		return -(d & 0x7ff);
> -
> -	return (d & 0x7ff);
> +	return sign_extend32(inst & 0xfff, 11);
>  }

[Severity: Critical]
By fixing the negative displacement calculation here, does this allow=20
negative displacements (like -4 encoding to 0xffc) to reach the magic page=
=20
emulation in kvmppc_st() and kvmppc_ld() without bounds checking?

For example, in arch/powerpc/kvm/powerpc.c:kvmppc_st():

	/* Magic page override */
	if (kvmppc_supports_magic_page(vcpu) && mp_pa &&
	    ((pte.raddr & KVM_PAM & PAGE_MASK) =3D=3D mp_pa) &&
	    !(kvmppc_get_msr(vcpu) & MSR_PR)) {
		void *magic =3D vcpu->arch.shared;
		magic +=3D pte.eaddr & 0xfff;
		memcpy(magic, ptr, size);
		return EMULATE_DONE;
	}

If a guest VM sets up a base register pointing to the magic page and=20
executes an 8-byte memory access instruction (like psq_st or lfd) with an=20
offset that translates to 0xffc, could this memcpy copy 8 bytes starting=20
at offset 0xffc, overflowing the 4096-byte vcpu->arch.shared page?

A similar situation appears to exist in kvmppc_ld():

	/* Magic page override */
	if (kvmppc_supports_magic_page(vcpu) && mp_pa &&
	    ((pte.raddr & KVM_PAM & PAGE_MASK) =3D=3D mp_pa) &&
	    !(kvmppc_get_msr(vcpu) & MSR_PR)) {
		void *magic =3D vcpu->arch.shared;
		magic +=3D pte.eaddr & 0xfff;
		memcpy(ptr, magic, size);
		return EMULATE_DONE;
	}

Could this allow an 8-byte copy to read out-of-bounds host memory when=20
the offset is 0xffc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007182116.1247=
9-1-amachhiw@linux.ibm.com?part=3D3
