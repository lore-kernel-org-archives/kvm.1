Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0024D17B3
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849465; cv=none; b=Yc0lXkpPh2QFqkWQXyTQcsR3rj2gsFs7qIV16YfJg0J9EdrfDL+W8qj++hUl/4y2L2ANiWQ3nttO/hJzLjfDECUQzBMkLygAo54ssWyraYpMMc+BrYtZ27/HVOGJH4vK3S+FcgLE6Cpcs9s5hl8GVX033iSrMDOcFwZU33jI/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849465; c=relaxed/simple;
	bh=eYIrjqlXvtI+eE7jrrqS057mPQf4mhgy9UkXrIbZPX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n2Kvd9vwwCWIpX1xyYQg8B6KduVzAPjltIAACvtcvsqk1dqeUkhJotu5+jFY6kLlb4+cVX9KKWohowkc4QmXS4bUs8wGX/b7z7PwDkDHM8lazWYM6UNkkJw2MDe92+CDbmj0SuiV4I2Y1lPyoyoC+P/7tGDYc7yEnwPjWTunrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCeJYqfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCeJYqfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CBB1F000FF;
	Thu,  1 Oct 2026 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849452;
	bh=QvyPwxyCtnPo4mH6AqExlvtj9+5LsuXJYL3dirhfG/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCeJYqflNreh/EJ5xhUHhHcsppgDIOX6UpofAK8dopm7lo459Gi/a85rsyxMUk8mR
	 L8HhoHICoLE88zQWtuw0HQscPNRDRdaIFeAtq11Uqugp4K0BnVYGqR7LbZE9XMEhtm
	 yDNYLXk6xA6J0X2fnFnD9XkT9ZM5+w+zNr167IamUIO1fktE0zMn+E6WVDMucoypQB
	 Ybwn/wvqZHsSb0ZREzP8QhubMISF4Do7KU06EIGTJfwo/Teuq/AQlYNT/OlOueQT6F
	 MnokzHySEqOEBekt/VhwN6BYv2Pz+BqaE2omZRDiZQd14bbgZWxVhOZetLBjkSMufM
	 nTprQVJGi3hhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: PPC: Book3S HV: XICS: Update irq_type for
 cleanup to work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001100208.1271628-3-gautam@linux.ibm.com>
References: <20261001100208.1271628-1-gautam@linux.ibm.com>
 <20261001100208.1271628-3-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:10:51 +0000
Message-Id: <20261001101052.42CBB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] xive: host kernel panic in kvmppc_xive_cleanup_vcpu() due to u=
ninitialized eoi_mmio
--

commit 2d2dc3956268ca839bb2cf6d3521ccdcf2a1831b
Author: Gautam Menghani <gautam@linux.ibm.com>

KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work

This commit updates the assignment of vcpu->arch.irq_type to occur before
vcpu configuration starts. This is intended to ensure that
kvmppc_xive_cleanup_vcpu() can properly execute if early setup failures are
encountered during kvmppc_xive_connect_vcpu().

> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 1d67237783b71..67219044fb8c7 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1937,6 +1937,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	xc->vp_id =3D vp_id;
>  	xc->mfrr =3D 0xff;
>  	xc->valid =3D true;
> +	vcpu->arch.irq_type =3D KVMPPC_IRQ_XICS;

[Severity: Critical]
Could this cause a regression where an early failure leads to a host
kernel panic?

If xive_native_get_vp_info() or xive_native_alloc_irq() fails shortly after
this assignment, the code jumps to the bail label and calls
kvmppc_xive_cleanup_vcpu().=20

Because irq_type is now KVMPPC_IRQ_XICS, kvmppc_xive_cleanup_vcpu() no
longer bails out early, and unconditionally attempts to mask the VP IPI:

kvmppc_xive_cleanup_vcpu()
    /* Mask the VP IPI */
    xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);

Since xive_native_populate_irq_data() has not been successfully executed ye=
t,
xc->vp_ipi_data.eoi_mmio is still uninitialized. When xive_vm_esb_load()
is called:

xive_vm_esb_load()
    val =3D __raw_readq(__x_eoi_page(xd) + offset);

Would this dereference the uninitialized eoi_mmio pointer and cause a
fatal page fault?

Could an unprivileged host userspace process intentionally trigger this
early failure path (e.g., by exhausting IRQ resources) during VM creation,
resulting in a host denial of service?

> =20
>  	r =3D xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
>  	if (r)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001100208.1271=
628-1-gautam@linux.ibm.com?part=3D2
