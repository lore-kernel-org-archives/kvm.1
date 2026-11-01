Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544939;
	b=ZhNdFVdmUYkMxd1UUEQkINdIPqesCqhaUS+UKTJTNfi9LSflFpCeMYmOXm+CUnbv8FY/
	 XCZXXsMCU1DYA5Pqo6QodFN6dfwwSQYWTNKYBMvvNDx0PI6M/h/usd/56PqWGCjNaO+Ui
	 aXFK2mvY2K7JdAsTKZtKkuqlXKnMfbwly7BegPXPBhuJtgsnpC0UH9NaT/Xpy3ka2ddLL
	 d5WYfBKqKf2X116xUpbvgi5OoYnH/3+i0yfxB+hBUPqYvb0lH8aCJfLpeP8qQ5TwA4/W8
	 Iu1gfwtxiWpNO/oCCoXi/IFgRjlokxhTDFUqmZ/PNUDUxg21REGKaGD+u91KRfAzFXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PCJuGcZNycluYT9X5ZF5sLU+zufd1XdA3IlFUiuxwTA=;
	b=NWc0krei1U5b9W/Hhfi0UdanaeS05eBEarngSegTc9ymvcD8f9tfhwKz36gfjT1AXYvL
	 G4NLavUlGHp10QNEfEdS9SXKXvf1W69AXXv5HVXsXUS1s6YdDtNdEr+5T4EgCevMiLMlc
	 noWFaUoThlYZpneFncFiu5eg7TIr4jDu4Vm07pB0le7Y4TNmOntuH+6608GmdH87OZ+Cr
	 D/2HmQpJecfNidfX9BN223UXyONSODUcRq7aKdXt3FADB09BeWdFtusmtrjz2R9nQPzG9
	 DSwaG+RiNe7Qxr6GYQ0c7wTo/j2FyDkIN6ZXFJQKHaML2oKoufQYJ03E1rdRYEt3Hyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu+fR9ag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA4606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu+fR9ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413291F000C1;
	Sun,  1 Nov 2026 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544938;
	bh=PCJuGcZNycluYT9X5ZF5sLU+zufd1XdA3IlFUiuxwTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mu+fR9ag1sqbUcfTfztkZxFElkAP1W812SA+DMSbQWTDpfKuhHXArXRFduzE3wnnJ
	 QoAzcTCCVMbbyIS3a5/iWYYfB6pcj6a1R29BGINNjs6YHxQlua0GHksuio8A1gLTa+
	 5+977bAJasD2XbYQZ2n72XfxSS4XPvjNWkDeddR9Nij/K3eAhcIlngOdBW8autlBzs
	 2rmk/a6zbnr+8U2AG6pnkB/O6djmlyYny3I+4IH0Aiems89xd219Qov+/eTB0cDcub
	 72JunlC3AoZFiXgmiaCGgNLHE3HG0+ycyuPFvenFosLEdrW/YLgQCunoXCNCGVBa9b
	 D2jHpidHVztQA==
Message-ID: <sashiko-outbox-192459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 6/7] KVM: PPC: Book3S HV: Fix error handling during
 vcore create
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ca419693358e3af49b1dfa7887b34b8ef91a5daf.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
 <ca419693358e3af49b1dfa7887b34b8ef91a5daf.1793543627.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 14:55:37 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: PPC: Book3S HV: inverted vcore check in kvmppc_core_vcpu_crea=
te_hv()
--

commit 03a4203b0b5c05e6f77faafc6f01a945c2457b16
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S HV: Fix error handling during vcore create

This commit adds a NULL check on the vcore returned by kvmppc_vcore_create()
in kvmppc_core_vcpu_create_hv() before updating kvm->arch.vcores[core] and
incrementing kvm->arch.online_vcores.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 22283d46e8fe6..7975e5de89d0e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3090,10 +3090,12 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_=
vcpu *vcpu)
>  			err =3D -ENOMEM;
>  			vcore =3D kvmppc_vcore_create(kvm,
>  					id & ~(kvm->arch.smt_mode - 1));
> -			mutex_lock(&kvm->arch.mmu_setup_lock);
> -			kvm->arch.vcores[core] =3D vcore;
> -			kvm->arch.online_vcores++;
> -			mutex_unlock(&kvm->arch.mmu_setup_lock);
> +			if (!vcore) {
> +				mutex_lock(&kvm->arch.mmu_setup_lock);
> +				kvm->arch.vcores[core] =3D vcore;
> +				kvm->arch.online_vcores++;
> +				mutex_unlock(&kvm->arch.mmu_setup_lock);
> +			}

[Severity: High]
Is the condition in if (!vcore) inverted here in
kvmppc_core_vcpu_create_hv()?

kvmppc_vcore_create() returns a non-NULL struct kvmppc_vcore pointer on
success and NULL on allocation failure, and kvmppc_core_vcpu_create_hv()
checks for failure immediately below:

	if (!vcore)
		return err;

With if (!vcore) guarding the mmu_setup_lock block, a successful
kvmppc_vcore_create() skips storing vcore in kvm->arch.vcores[core] and
incrementing kvm->arch.online_vcores, while still attaching the vcore to
vcpu->arch.vcore. Because kvmppc_free_vcores() frees vcores by iterating ov=
er
kvm->arch.vcores[], any allocated vcore will be leaked on VM teardown, and
callers relying on kvm->arch.vcores[] or kvm->arch.online_vcores (such as
sibling thread attachment, duplicate vCPU ID detection, kvmppc_update_lpcr(=
),
and kvmhv_set_smt_mode()) will see inconsistent state. Conversely, if
kvmppc_vcore_create() fails and returns NULL, kvm->arch.online_vcores is
incremented before returning -ENOMEM.

Should this check be if (vcore) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ca419693358e3af49b1=
dfa7887b34b8ef91a5daf.1793543627.git.ritesh.list@gmail.com?part=3D1
