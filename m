Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BA4779A5
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905008; cv=none; b=O9k4hwIFYZ8C2/QT2xjYCc7mecxVPGai5lwGYqxLePk2h3NnFIP1R6/jw/dutASGT4Q4+ECFT828AEmia1dVFOoa/FhvfhKxzxd8EuuTUv0p1g+u5lVQEaoFWhz1/PIoCAmFkTN+qImykWqv38iQ9dvkZkJ6DNLjt0yKd29yKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905008; c=relaxed/simple;
	bh=qsnNXS1ET4WHyrGSrI95UKjqOte2PCNihqcuTj2mIYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9dqWHB2CNELGNZsllBIsh4XvOIi0Nk6U3YjLzqyOWlv+DeLRv33gx2zjO9z8cIo9gOWbVOb2JoOBf2NA2USEWPwMCoDhD2EBB7Nqs5FGUcz53m8VZCGWdYqmtMOHxwxjVh4C9LLydNmjXTB1UXyk6wKnOLsIwJ2x4/j+KF9tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF9e5kjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF9e5kjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEAB1F000E9;
	Wed,  1 Jul 2026 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905007;
	bh=ntLAvDUktYez30iZHbT2B05+vBQQJQ6aY/bvSti9AvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UF9e5kjtjtrZvYigJg/jH5LdShLHQt4KBCyuODQRdy20M5+teDaztdsYNFgdwbVFF
	 DD4ElSHqiXhZOcrmBWfCm6DBIL08fr9zr6kOLMdCbCS1dd8fTnI1bCMg5ZoQcW4Z6T
	 tWGSJVJRv/jgxhHezSP4VcfPqcyVozTuK6sB/rM//M124YJtkuTOcKOO6u1hiVQURP
	 DpwBq6T36Ye2/84OC0OmUcrEE8mmz8ZqfQwqKqmBtvxt8v0jWoHOUkOnf70z2UWfFA
	 DHRo/DZc/sZPQpybBYXKzsn0evBohpAf1b6qfxQrN5Pq4ZvhSRHUnvlsKxZ1h7cWQt
	 eDGDwYxcrIvpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] x86/tdx: Fix off-by-one in port I/O handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701110547.764083-2-kirill@shutemov.name>
References: <20260701110547.764083-1-kirill@shutemov.name>
 <20260701110547.764083-2-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:23:27 +0000
Message-Id: <20260701112327.5CEAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SEV-ES vc_handle_ioio incorrectly zero-extends 8-bit and 16-bit IN=
 instructions.
--

commit df84d995a704008239da9f3f6b57944d2f071dc7
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
x86/tdx: Fix off-by-one in port I/O handling

This commit fixes an off-by-one error in the GENMASK calculation for port
I/O handling in the TDX module. It corrects the mask to prevent it from
being one bit too wide for all I/O sizes.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 29b6f1ed59ec5..b8bbd715fb624 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -694,7 +694,7 @@ static bool handle_in(struct pt_regs *regs, int size,=
 int port)
>  		.r13 =3D PORT_READ,
>  		.r14 =3D port,
>  	};
> -	u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
> =20
>  	/*

[ ... ]

While reviewing the port I/O handling changes here, I noticed a pre-existing
issue in the related SEV-ES code:

arch/x86/coco/sev/vc-shared.c:vc_handle_ioio() {
[ ... ]
> 		if (exit_info_1 & IOIO_TYPE_IN) {
> 			if (!ghcb_rax_is_valid(ghcb))
> 				return ES_VMM_ERROR;
> 			regs->ax =3D lower_bits(ghcb->save.rax, bits);
                        ^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does this incorrectly zero-extend 8-bit a=
nd
16-bit in instructions?

When a guest executes an 8-bit or 16-bit in instruction, it triggers a #VC
exception (SVM_EXIT_IOIO) and calls vc_handle_ioio(). The function extracts
the result using lower_bits(ghcb->save.rax, bits) and assigns it directly to
the 64-bit regs->ax field, overwriting the entire register.

This violates x86-64 architectural semantics, which dictate that 8-bit and
16-bit register writes must leave the upper bits untouched.

Can this cause data corruption or crashes in guest code if the compiler or
assembly relies on the upper bits of rax being preserved across the in
instruction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701110547.7640=
83-1-kirill@shutemov.name?part=3D1
