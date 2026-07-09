Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FC288D0
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577519; cv=none; b=HCYrsW86V6kqCvbwInI1A9hUdXhqL6B7SASB+zUdxXqtnlUN5/wgf2ADnfU4g3QDTs34zk2toGtTT8NdzRY/EaXqoumh+EZTRrsi9VSX/htdtiYTlWC/LH/wqN5GOTwJXgmmZ46iTnm1BYA7aJNulkZkEjlSD4Qfo1Fu2c098M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577519; c=relaxed/simple;
	bh=0U56aPE17ZmSSHpDxqT8Gx0D2VIqHKTjSG+x17Idas0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJZ60EC1Gtfg0anazQINfUgFcKch6cyqQ6sFKpSIttVOvOxGxMY8tzYlJnm4lcVdFAUse14AS9qpyl9BhRB8opu7mKqQcKSTbNTBkZM7sAw5mWW3a/bQ2nSTS+/z86IrZ+syjnuSfeYoa2gwN0CAowlDlNCFe/QXRurtS7sGHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1/1GWlr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1/1GWlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578101F00A3D;
	Thu,  9 Jul 2026 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577517;
	bh=ynvcn/VUAs9et9w6rvn2fX+Jbs2yfr53RJWH2fz/fIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1/1GWlrHS5XQ6/WtYjmJWK2faFf7q7Ds4pEVl3TytQl3AFW35Tv/vz3gEV/m1Ec0
	 n5TraubnuHeMqpbsOfFw2d/+afw97jXFSUn4VdvWEg+hz16KW3Cnc2pH55X3TLZTEG
	 p0lmimzyrSTh6ywziqGotH5agdXoaUAVSLxVfWJVtVgs6mNIVgoHCieJMws/IA0F+c
	 1ap97065LRQcf2o/4LJhzpcK0pSCMZ9luFqGDitYs6v+b5s2/DNqrulCwmmEIYNPcJ
	 ttzZrYRWiz6ObVs81JNIZy6UvlPXuZR2BsCyZ5bqhvXY+bX5LCDJSK5ifjt3WuGG6L
	 xhgYyajFIKI+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on
 success
Reply-To: sashiko-reviews@lists.linux.dev
To: leixiang <leixiang@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709055755.31297-1-leixiang@kylinos.cn>
References: <ak59frQUBl9Gs3Qn@google.com>
 <20260709055755.31297-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:11:56 +0000
Message-Id: <20260709061157.578101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] On x86, `kvm_arch_irq_bypass_add_producer()` leaves a dangling=
 `irqfd->producer` pointer on failure, causing an exploitable Use-After-Fre=
e during subsequent IRQ routing updates.
- [High] On ARM64, `irqfd->producer` is never assigned, rendering `kvm_arch=
_update_irqfd_routing()` dead code and causing stale GICv4 VLPI forwarding =
state.
--

--- Patch [1]: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on suc=
cess ---
commit cb5d1de2b1bfd4aded0e24ab02c54c7d0fbd846f
Author: leixiang <leixiang@kylinos.cn>

KVM: PPC: Book3S HV: Set irqfd->producer only on success

This patch updates kvmppc_irq_bypass_add_producer_hv to only set
irqfd->producer when kvmppc_set_passthru_irq succeeds. This prevents
leaving a dangling pointer if the bypass manager fails to register the
producer.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..ff7b256291250 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(stru=
ct irq_bypass_consumer *cons,
>  	struct kvm_kernel_irqfd *irqfd =3D
>  		container_of(cons, struct kvm_kernel_irqfd, consumer);
> =20
> -	irqfd->producer =3D prod;
> -
>  	ret =3D kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>  	if (ret)
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +	else
> +		irqfd->producer =3D prod;

[Severity: Critical]
This is a pre-existing regression and was not introduced by the patch under
review, but does x86 suffer from the exact same logic regression being fixed
here?

Looking at kvm_arch_irq_bypass_add_producer() in arch/x86/kvm/irq.c, it
sets irqfd->producer unconditionally before calling kvm_pi_update_irte():

arch/x86/kvm/irq.c:kvm_arch_irq_bypass_add_producer() {
    ...
    spin_lock_irq(&kvm->irqfds.lock);
    irqfd->producer =3D prod;
   =20
    if (!kvm->arch.nr_possible_bypass_irqs++)
        kvm_x86_call(pi_start_bypass)(kvm);
       =20
    if (irqfd->irq_entry.type =3D=3D KVM_IRQ_ROUTING_MSI) {
        ret =3D kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
        if (ret)
            kvm->arch.nr_possible_bypass_irqs--;
    }
    spin_unlock_irq(&kvm->irqfds.lock);
   =20
    return ret;
}

If kvm_pi_update_irte() fails, it returns an error but leaves
irqfd->producer dangling.

Later, if the guest updates IRQ routing, KVM might invoke
kvm_arch_update_irqfd_routing() which calls kvm_pi_update_irte() again,
which uses the freed pointer:

arch/x86/kvm/irq.c:kvm_pi_update_irte() {
    unsigned int host_irq =3D irqfd->producer->irq;
    ...
}

Should x86 also clear irqfd->producer on failure?

[Severity: High]
This isn't a regression introduced by this patch, but while reviewing this
change I noticed that ARM64 seems to have the opposite problem.

In arch/arm64/kvm/arm.c, kvm_arch_irq_bypass_add_producer() completely omits
setting irqfd->producer:

arch/arm64/kvm/arm.c:kvm_arch_irq_bypass_add_producer() {
    struct kvm_kernel_irqfd *irqfd =3D
        container_of(cons, struct kvm_kernel_irqfd, consumer);
    struct kvm_kernel_irq_routing_entry *irq_entry =3D &irqfd->irq_entry;

    if (irq_entry->type !=3D KVM_IRQ_ROUTING_MSI)
        return 0;

    return kvm_vgic_v4_set_forwarding(irqfd->kvm, prod->irq,
                                      &irqfd->irq_entry);
}

Because irqfd->producer is never assigned, does this render
kvm_arch_update_irqfd_routing() dead code on ARM64?

arch/arm64/kvm/arm.c:kvm_arch_update_irqfd_routing() {
    ...
    return kvm_vgic_v4_unset_forwarding(irqfd->kvm, irqfd->producer->irq);
}

Since the core KVM code in virt/kvm/eventfd.c relies on irqfd->producer bei=
ng
non-NULL to propagate routing updates, this looks like it could leave
hardware forwarding in a stale state.

Should ARM64 be updated to set irqfd->producer on success?

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709055755.3129=
7-1-leixiang@kylinos.cn?part=3D1
