Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D389488D8F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989942; cv=none; b=gWI94uCGXDejMqK38+F3ESnmvdChpf27Q1V9aHJ2PT00YmoUXwZ5m5LSTE2CbjafeXRaKvcp/vowOPup9SbtsZsxomBn2jOteZ3UVlbgcJsN9pBCo+pwdzq9V7ZMBhhny1SoS5ujZzkMX7RM4aocD3Q1CZe5ZQi0uA7A5I3mnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989942; c=relaxed/simple;
	bh=075wQmsRbe4dwRnVtujVElsjWbgKRuQundLRAjNXeo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F7hr8PZumkXFZc/fwvbz64aLFqgqZGltOBggQhjAW9sDcDoyosbnQAi/PN9dkT4PaR8FOpFfGouZNI4VNjaL3qVXYKOAgsktiv7Cd6dIpSIJkecczMR6yllagzVLb5qYbWfiXWztkgKvqkCnzTTBHIsLzYsJGhtr3VabDJXKqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXVDIqpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXVDIqpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7101F000FF;
	Mon, 21 Sep 2026 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989939;
	bh=0/Rd4TVqvrrVZMuQX+K/7uFwnuFwhdeYgCR/U07JkC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXVDIqpCnLzH697x5j3fLcHWfUz7zn//9BTF3kcTKS0mLPh+b6vViBdyhwduBB3n1
	 xzAYsFAlCI6Ooe3eP4LFsaGqNpl3kDooWwJgJJ19fLQHxRCrGQ/D1bszLNkOQQrID4
	 bYnhNnMOoxETByXe18tJb2elgdhUP4Y8UW7IERksmIWjDRl8d+OQiW2pVRXhAxLXLd
	 auPjq+fM7dIUXdYqBCLhiUjNBsVMLALSnDjFV2d8Xgv0TjI2D2VlxueBxchsRZBVxv
	 0VDhSYUZ1OOanhqRq+w6VQKjoagBW3kfl18W3EbsC4fvCa7Ve6alnV2z1IkI3XNun8
	 UnIZianODQDxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts
 caused by LPCR_MER bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921111043.49825-1-gautam@linux.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:25:38 +0000
Message-Id: <20260921112538.ED7101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: ppc: lost LPCR_MER interrupts for XICS due to XIVE state leak
--

commit 215dda3f95780a965ce67c9c452b6f7d1948e486
Author: Gautam Menghani <gautam@linux.ibm.com>

KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit

This commit avoids spurious interrupts for KVM on PowerNV guests by not
setting the LPCR_MER bit when native XIVE is available. It introduces a new
helper, kvmppc_xive_native_enabled(), to check for native XIVE and skips
setting LPCR_MER if it evaluates to true.

Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.=
JavaMail.zimbra@raptorengineeringinc.com

> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 169ea6a7fbad4..580ad2548c2bf 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcp=
u *vcpu)
>  	return vcpu->arch.irq_type =3D=3D KVMPPC_IRQ_XIVE;
>  }
> =20
> +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> +{
> +	return kvm->arch.xive_devices.native;
> +}
> +

[ ... ]

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c89..cb2bb29451a7f 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u6=
4 time_limit,
>  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>  				kvmppc_inject_interrupt_hv(vcpu,
>  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
>  				lpcr |=3D LPCR_MER;
>  		} else {
>  			/*

[Severity: High]
Does kvmppc_xive_native_enabled() accurately reflect whether XIVE is curren=
tly
in use?

If a VM switches from XIVE to XICS (such as during a kexec or CAS
renegotiation), the XIVE native device is destroyed. However, the native
pointer is intentionally not cleared:

arch/powerpc/kvm/book3s_xive_native.c:kvmppc_xive_native_release() {
	...
	/*
	 * A reference of the kvmppc_xive pointer is now kept under
	 * the xive_devices struct of the machine for reuse. It is
	 * freed when the VM is destroyed for now until we fix all the
	 * execution paths.
	 */

	kfree(dev);
}

When running in XICS mode after this switch, kvmppc_xive_native_enabled()
will continue to evaluate to true.

Will this cause KVM to bypass setting LPCR_MER, and subsequently fail to
inject external interrupts when MSR_EE=3D0, resulting in a guest hang?

Could this check instead evaluate the active vCPU IRQ routing, for example =
by
using !kvmppc_xive_enabled(vcpu)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921111043.4982=
5-1-gautam@linux.ibm.com?part=3D1
