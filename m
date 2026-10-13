Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC9541E67
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925458; cv=none; b=k0d5R113rqrJQPlqfM7iq4eym2asWB94WrXZk6QTEIhZJa33RFV1ChLgtfSYD/WmAXiueFpDiA+J73wpRkBuo9zf0rggsWiGWOMSpkbk+HYxHvWnUDcmvTNHIpVkx5qUh5PAZTCNP0hINBkJGvwwESJLQ4F0xOH3solOVsrYoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925458; c=relaxed/simple;
	bh=+QaT3MleV76sCsJ13YmPn8i14KXQrHhVttLr0/9vNxw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=T2ENH9lSVahik/qR6uXeyZrNmcDOUCdglgY4ptmJhtqutPUFoctlmlOrhQIbbdBXReG//HRxiyQ/kbsPnv7vqtXT+TWSQEMzZ2Y62YLTGmd6xIXrcrF6/eNYpaLmys6QlfOY8b6THMCIVf9Ka77X3CFSpHgBFb88Yc3bhhRwvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnJ6YVXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnJ6YVXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DC81F000FF;
	Tue, 13 Oct 2026 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925456;
	bh=Ji9bLAwkiL5VJqrJ/ygqlYq9VB78wCjKIONPlKDcUoA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AnJ6YVXIStekiYnf2rJ0ig0MidjGOs8YCBf/Qs3JQMtJD7ktzsyRHKtiWOt3HaxyJ
	 O6Zwy2zwuxYoE9XyUGcmVE/StA6k4wdqsSfdwYugVDSXPrBxAZTTh5+1purgvoiq2M
	 4YFTgJuRfJPzjXqkRWYrZJFdxI9klxEwjBj2RNijj34PSgnvyvpR8LonF2GHjFj8fP
	 x/8Q9HySpW1kVN11rU2D0m9F27tXPTeRDeZ0n4w8ONeQ9Q/I5zotJL5cyP8kppOm3S
	 /jfhlFb5c3iHFhS+MlRWyeyQjr8Ptvz/tUJEjGGK5v2n30hyZvHxTcW9jui4mkmxf+
	 62Psr0EALuhOw==
Message-ID: <sashiko-outbox-170507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] KVM: x86/xen: Wait out memslot updates in the Xen
 attribute ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261013204824.454208-4-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
 <20261013204824.454208-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:04:16 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: UAF and lockdep splat in kvm_gpc_check() due to dropped SRCU =
lock
- [High] kvm: x86/xen: 3-way AB-BA-CA deadlock between srcu, xen_lock, and =
slots_lock
--

commit 34df3b53ec91de034b47e7637dd9880ba9d6c924
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls

This patch updates Xen attribute ioctls in KVM to handle memslot updates
by waiting them out (passing wait=3Dtrue to kvm_gpc_refresh and
kvm_gpc_activate), instead of returning -EFAULT. It also drops the
srcu_read_lock sections around activation calls.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index fae893cd5762c..76708b8960265 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -36,7 +36,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *=
vcpu, u64 param, u64 *r);
> =20
>  DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
> =20
> -static int kvm_xen_shared_info_init(struct kvm *kvm)
> +static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
>  {
>  	struct gfn_to_pfn_cache *gpc =3D &kvm->arch.xen.shinfo_cache;
>  	struct pvclock_wall_clock *wc;
> @@ -44,13 +44,12 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
>  	u32 wc_version;
>  	u64 wall_nsec;
>  	int ret =3D 0;
> -	int idx =3D srcu_read_lock(&kvm->srcu);
> =20
>  	read_lock_irq(&gpc->lock);
>  	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code trigger a use-after-free and RCU lockdep splat?

Because the srcu_read_lock() was removed above, this loop calls
kvm_gpc_check() without SRCU protection.=20

If we look at virt/kvm/pfncache.c:kvm_gpc_check():

bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
{
	struct kvm_memslots *slots =3D kvm_memslots(gpc->kvm);
...

This dereferences the memslots array and requires SRCU protection. Without =
it,
a concurrent memslot update can free the memslots structure before=20
slots->generation is accessed.

[ ... ]

> @@ -792,19 +790,15 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kv=
m_xen_hvm_attr *data)
>  			 * to make the call anyway.
>  			 */
>  			r =3D kvm->arch.xen.shinfo_cache.active ?
> -				kvm_xen_shared_info_init(kvm) : 0;
> +				kvm_xen_shared_info_init(kvm, true) : 0;
>  			mutex_unlock(&kvm->arch.xen.xen_lock);
>  		}
>  		break;
> =20
>  	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
>  	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
> -		int idx;
> -
>  		mutex_lock(&kvm->arch.xen.xen_lock);
> =20
> -		idx =3D srcu_read_lock(&kvm->srcu);
> -
>  		if (data->type =3D=3D KVM_XEN_ATTR_TYPE_SHARED_INFO) {
>  			gfn_t gfn =3D data->u.shared_info.gfn;
> =20
> @@ -813,7 +807,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_=
xen_hvm_attr *data)
>  				r =3D 0;
>  			} else {
>  				r =3D kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
> -						     gfn_to_gpa(gfn), PAGE_SIZE, false);
> +						     gfn_to_gpa(gfn), PAGE_SIZE, true);

[Severity: High]
Does this code introduce a 3-way AB-BA-CA deadlock between srcu, xen_lock, =
and
slots_lock?

With wait=3Dtrue, the thread executes KVM_XEN_HVM_SET_ATTR, acquires xen_lo=
ck,
and calls kvm_gpc_activate() which spins in a loop calling cond_resched()
while waiting for a memslot update to complete.

Meanwhile, a concurrent vCPU thread exiting after a WRMSR to the hypercall =
page
MSR might enter kvm_xen_write_hypercall_page() while holding the srcu lock:

arch/x86/kvm/xen.c:kvm_xen_write_hypercall_page() {
    ...
	mutex_lock(&kvm->arch.xen.xen_lock);

This vCPU thread blocks waiting for xen_lock, which is held by the ioctl th=
read
above.

A third thread performing the memslot update (holding slots_lock) calls
synchronize_srcu(&kvm->srcu), which blocks waiting for the vCPU thread to
release its srcu lock.

This creates an unrecoverable 3-way cycle where the ioctl thread waits for =
the
memslot update, the memslot update waits for the vCPU thread, and the vCPU
thread waits for the ioctl thread's xen_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013204824.4542=
08-1-dwmw2@infradead.org?part=3D3
