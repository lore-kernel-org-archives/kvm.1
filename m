Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C83644AF
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311852; cv=none; b=OT+skVp3J6UcVGC+Eb+ZVHYDLgM7Jq8H8L2ahrtTKrR5rDVtMUrJwHL7QrUlA60ujR7b2LMy7iaP1pV8yxIpmxH9q7wCKd9VIHhbmBi5A/GQSQ8ZJ1r3efabgmj8vgyxEd6FsMo6D0y6PB8DzHalrwifc6r+k2YW5HJBt6y+joY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311852; c=relaxed/simple;
	bh=h3IgDNniyjikysk9RK0mzTK2gcvDjlX5EV2d7ID7n1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L6Dr1GA+9nE/o2sjg3d5W/Tgi3Dea7EoyknEQIFnsVR1GTuee6IxVY4b3uaLBxH0DmPpXvXEkcTJmOs4KI8XY2GFkj7GoJVJ9SwJHKTXJm8pg436mvapAuES7fwLvqJ0HhGNMT2LWhNMM6w9F93rSm0ZEvw+ICMQDTTSoX6dUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF7x04an; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF7x04an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C41F00893;
	Mon,  1 Jun 2026 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311851;
	bh=9Kmer67ywj82XSEf6lQI+3VCbq23qfxwX0+UPJddy1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QF7x04anA75RBDQ0wz+NQoRuHswAx83CjQlniE2hkEJAtCcbpnESF7td/yXgWzdfj
	 f7VSjHg0fkpA8eHRzxJ+raibJw2benv2CeXIMz16vGvnv7E+XackH29R/tr5pVKDbm
	 QDE7FKVmKer8AqV8vmybZfLnlOnQ5ixxn3hdPc9zysj1dhK27q0ige16YsLhEpt0v9
	 rHaYGFLqx4FJeDQ2peXeIVjL6h4X97ne2CQyAa6C1SW0o4H7CM7KVN/8azme8SD2rk
	 H6HeOFR8OUS6pbOwosWNzdXhurQOcDMl7tVAA/A7Ce4t9VDqKI7Lwy35POvK31mYuZ
	 qCEtcYf58knDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty
 after setting feature value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-1-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-1-415d08a2813b@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 11:04:10 +0000
Message-Id: <20260601110411.030C41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional setting of csr_dirty contradicts the commit messag=
e design intent.
--

commit acd5b6b18e2d1bc390b68230f877d70bd8155368
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after setting feature value

This commit updates KVM on RISC-V to mark vCPU CSRs as dirty when an FWFT
feature value is updated. This prevents the guest from observing stale CSR
states after vCPU scheduling or migration by ensuring the modified state is
properly synchronized.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694f..5e4aafb0cbf16 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -521,6 +521,7 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *=
vcpu, unsigned long reg_num
>  		break;
>  	case 2:
>  		ret =3D conf->feature->set(vcpu, conf, true, value);
> +		vcpu->arch.csr_dirty =3D true;

[Severity: Medium]
The commit message mentions marking the CSRs dirty after successfully setti=
ng
an FWFT feature value. Does kvm_sbi_ext_fwft_set_reg() unconditionally set
vcpu->arch.csr_dirty to true, even if conf->feature->set() fails and returns
an error?

Could this lead to unnecessary CSR hardware reloads on error paths since the
return value in ret is not checked before modifying the dirty flag?

>  		break;
>  	default:
>  		return -ENOENT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-kvm-get_re=
g_list-v2-v5-0-415d08a2813b@sifive.com?part=3D1
