Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC63515E9
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219383; cv=none; b=apU1Koah8aaSBG6csvKSn1lnr4jEjmpGn2VMcOBng4W9cFBahI/o0/vMK/1jf6TzFQ4j0nvH+gaKjdrr8WsECJg+bZuZrZZuPW9J1CGAq0s0u3h3tYHiIWIFwo/1qxSunvdSmyOKarrX6ob5G9TmW8oxrHQsjICkTq07fPdZ2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219383; c=relaxed/simple;
	bh=3MXWzcMe+D2OxRizT++iRXLItOMQdOtAg8q0KTC06IU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qI3hu/C1Dp9uXQyYdz3YPCiBZyaNXrAdewG7UqCKPVAGEh5ls5+FScAOo9GYq8mtKGzJPL9r4GyvsqzmWwweqCXXQYAcZC7yOzmJTbpjve/kDDC7eNU1IodsB54xASx6Mdy//V7N7DK9rpuXmOZFiOrU36sm4wre9R8NleZHwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6bD3x9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6bD3x9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136B31F000E9;
	Mon, 31 Aug 2026 23:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788219381;
	bh=an1XC9THNjfmp/X2Gp/JVDwuWvy1tFoUjcjZAr0fsdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6bD3x9PsxGR+VXhy6KU/QI5tP9rKSdgYYYKINncClZguVtg85fZaWSbdPmLooVMQ
	 AI7pTS3EYkGfiZQrrBhGCf0TTvHM6Q3nkEDcLu+DppRUy8YjwETYUbBDpMtVeYUVVD
	 g2AcePT+mLuXHTDSQzn/OmXw0OTs4xC5an51ZWFYFbpLLDbwRwhM9dHmtnEF5d0ZKi
	 gUqV4wscNEPnvFjY0X9rL4J3nCUb6HrD73soT7icEIeOkSyU8tkwM59ZycBaxEHDh+
	 +x+UrjjcR+kNYuFDA+HBZah2h+jh0vQxKuESCkD0AKCTivj9rGxq5ZHfVXtFHmislc
	 xxR/2acJyJkaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] KVM: x86/xen: Convert evtchn_ports from IDR to
 XArray
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831213632.81023-14-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:36:20 +0000
Message-Id: <20260831233621.136B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Type confusion in evtchnfd delivery union allows a userspace g=
uest to crash the host kernel by assigning an EVTCHNSTAT_ipi event channel =
to port 0.
--

commit 365d4c87b9f4941190fe8a9a101dce7853ba1e18
Author: Furkan Caliskan <frn1furkan10@gmail.com>

KVM: x86/xen: Convert evtchn_ports from IDR to XArray
   =20
This patch converts the deprecated IDR used for evtchn_ports into an XArray.
It replaces idr_alloc() with xa_insert() and idr_remove() with xa_erase(),
dropping the explicit rcu_read_lock() in kvm_xen_hcall_evtchn_send() since
xa_load() is internally RCU-safe.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index b024a09de55a3..b59c6b747c2f6 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -2214,13 +2214,13 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
>  	}
> =20
>  	mutex_lock(&kvm->arch.xen.xen_lock);
> -	ret =3D idr_alloc(&kvm->arch.xen.evtchn_ports, evtchnfd, port, port + 1,
> +	ret =3D xa_insert(&kvm->arch.xen.evtchn_ports, port, evtchnfd,
>  			GFP_KERNEL);

[Severity: Critical]
This isn't a bug introduced by this patch, but could this union type
confusion allow a userspace guest to crash the host kernel?

When a userspace process calls the KVM ioctl to assign an event channel with
type EVTCHNSTAT_ipi and send_port =3D 0, the setup code just prior to this
insertion does the following in kvm_xen_eventfd_assign():

	evtchnfd->deliver.port.port =3D data->u.evtchn.deliver.port.port;
	evtchnfd->deliver.port.vcpu_id =3D data->u.evtchn.deliver.port.vcpu;
	evtchnfd->deliver.port.vcpu_idx =3D -1;

Because of the union layout in the evtchnfd structure, deliver.port overlaps
with deliver.eventfd. Writing -1 to vcpu_idx corrupts the eventfd_ctx point=
er.

> [ ... ]
> @@ -2235,7 +2235,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm=
, u32 port)
>  	struct evtchnfd *evtchnfd;
> =20
>  	mutex_lock(&kvm->arch.xen.xen_lock);
> -	evtchnfd =3D idr_remove(&kvm->arch.xen.evtchn_ports, port);
> +	evtchnfd =3D xa_erase(&kvm->arch.xen.evtchn_ports, port);
>  	mutex_unlock(&kvm->arch.xen.xen_lock);
> =20
>  	if (!evtchnfd)
> @@ -2251,7 +2251,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm=
, u32 port)
> [ ... ]
> @@ -2376,23 +2374,23 @@ void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
>  void kvm_xen_destroy_vm(struct kvm *kvm)
>  {
>  	struct evtchnfd *evtchnfd;
> -	int i;
> +	unsigned long i;
> =20
>  	kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
> =20
> -	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i) {
> +	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd) {
>  		if (!evtchnfd->deliver.port.port)
>  			eventfd_ctx_put(evtchnfd->deliver.eventfd.ctx);

[Severity: Critical]
This is a pre-existing issue, but does this check trigger an invalid pointer
dereference due to the type confusion mentioned above?

If an IPI was assigned to port 0, evtchnfd->deliver.port.port evaluates to =
0,
making the condition true. The kernel will then mistakenly dereference the
corrupted pointer (overlapping with vcpu_idx =3D -1) by calling
eventfd_ctx_put().

This exact sequence is present during deassignment in
kvm_xen_eventfd_deassign(), as well as here during VM destruction, which
seems like it could lead to a kernel panic and a host denial of service.

>  		kfree(evtchnfd);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831213632.8102=
3-1-dwmw2@infradead.org?part=3D13
