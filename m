Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188735;
	b=YxBKSDbb6PkC9FmydhtmdumdEgpQsB7ZUFWhrgO2fHbn4dyuGLk5YKSvoAmVclc7twaH
	 2+8GvSJqvGzJNYcNfX0gTCRPJBPM99Cb/2+7DcJMyPFG5izhZW3jVHnckR7Ims5PG4Lbk
	 UbCN5IwTWUb/avkgVfOatk+qoMxqs2VAqpp4UtlApfcapkui+C6LmN68HkJpLUZuMPGC7
	 xDO98DxPqD/+aHxksydpgFIuDmgIWMKIlgkOgnrMGecFpjGBUIy5ILPVjRFow8N9CO5Rl
	 LfxK4B2fsJrKj762pjLFd/DhOIInlAZMPNZHlOzouqBkNYCTMJhIlfpm080i8qYLdsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BW2fDy/Vt2sJUYJgjwFLPoP/4bkeGxiEgE+3idyxGG8=;
	b=puZgZ3kBJanSAyBNAsKtT6pQqMar6IduDoIbzL10CE4whDdu77autAr8iQyW9aQKPAto
	 SZcluH+mxnv0PNJXeTLIqrQpPsntRJ6pBXaodeTJNlDULq7bOu4Vg4f02r9rcY3ck6BgU
	 PV9EJA+qIGi0bsxcHIrBHrLy4wg3S0TgGxV8oTa794EDkqw46s2sQyUfh4K3JMKPKN1s6
	 rKlag9y/q0VKK2Loi2vG+q4PmhIfjWPq7NvkHt+aSBzI57u/Zg35ePENfu8M/XX8q6Kmo
	 yuAfQ0oDX+P90knol28Y6P8bgTAY3sqaNYADdImj0n1yD/RnyXChIeE08VEbkaYKV7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7xz+w4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF2606A320
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7xz+w4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D539B1F0089F;
	Mon,  9 Nov 2026 01:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188735;
	bh=BW2fDy/Vt2sJUYJgjwFLPoP/4bkeGxiEgE+3idyxGG8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H7xz+w4QwlHNv75gxSwEUlydcyLAr0WUawdBE1JMMiab1nwJZAstOvGhCtWCyssdW
	 NRUVOtl7ddipqLp1FDgRbsWXvs6vUVQbt+bYRmghNRDpmJw87ylYBbeDeRWTkXTYU7
	 W0ZvA00ds2bE4rFbCO3WOOFIr2zvPJDkuLsVMZPrnaRHbBM1NQSwaC+3cZveFyhfCH
	 HCYKTvVWkUwoF6bRZqxzeZyX0zk9T4U/V82HuIO6Z+8bA8Sl6KsKur6TUXyd3q7tsN
	 KIBCY8E9W1kUwJiPMd2l5trAFQ2sUzzX8Im3/AzVmrULiHsRR8agsbGkK6PccNG+Cx
	 wb8lXUuxayMtg==
Message-ID: <sashiko-outbox-204317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/24] KVM: x86: Allow KVM master clock mode when
 TSCs are offset from each other
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-5-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:45:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KVM: x86: missing masterclock update on error in
  kvm_arch_vcpu_postcreate()
--

commit 63e87344888586250d53904cdb6246fdd7dee791
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Allow KVM master clock mode when TSCs are offset from each other

This commit tracks vCPU TSC frequency matching separately from TSC offset
matching so that master clock mode remains enabled when vCPUs have
matching frequencies but different TSC offsets, while requiring matched
offsets for PVCLOCK_TSC_STABLE_BIT.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d29e5bc75f7a5..73015825f2188 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -9568,6 +9636,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
> =20
>  		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
>  		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
> +		ka->all_vcpus_matched_freq =3D false;
>  		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
>  		return;
>  	}

[Severity: Low]
Does this error path also need to call kvm_update_masterclock(vcpu->kvm)
when mutex_lock_killable(&vcpu->mutex) is interrupted?

Without kvm_update_masterclock(), pvclock_update_vm_gtod_copy() does not
run, so ka->use_master_clock stays true while the new unsynchronized vCPU
is runnable, and already-running vCPUs do not receive a
KVM_REQ_CLOCK_UPDATE broadcast to clear PVCLOCK_TSC_STABLE_BIT in their
guest pvclock structures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D4
