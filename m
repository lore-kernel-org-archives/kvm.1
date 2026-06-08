Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435A3E5570
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946622; cv=none; b=eKWd05HbSaOVJpkF7nXtjClmhgnpXalqP+m794QKQTgSjSp/Dy5vhf45CIdhwjKShlfgvrDFDNscoFdtQid3GpJ/YR0PdWYllbgk4EVLTLgpPHX2gzfNwBSk/ZmzrFt2ZKIl2SIdf9bYVzGZGQs5EmFw2yDTnsig5hX9yQXeuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946622; c=relaxed/simple;
	bh=b2mhH2Zlc32tXQ+NNHk/elZFvFwi4gD9bA3HUFNSHJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tZ8Mc4asoKHKvbq0zhmWs39i8BlC1XMHCdz0TPffVT7yY/jwvagHZbbqYHoGU4QbB/aGy72jyDE0POp40MSGkGzYvxgukECvruUjkVDbXLCxwvEEi6S5zVC5LMK9JlfuNhjUGISTjyDRpbS2VWkoWDr9htTFh95/5lOzcRhykvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrTUL5jq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrTUL5jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FAB1F00893;
	Mon,  8 Jun 2026 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780946620;
	bh=aO5gO7YqgigpX0mgc5JeujoV7aKywRwSAeUAbDkwRjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrTUL5jqk1C0O/ksjYww4j3x/kSYWMsCfcIAKEJqhgLkDlEuAYc7rIfu7PzGhYHV+
	 pUoQYA1NAevwF1udRnWvj9T7Kl44dChEch+Y3amcrne5J2cUYnehXi5sgCpQxAYlAV
	 Rdht17tot/P5YgBEFJ4A5t9zy1w12QOp2fI7ielg2PSTZeFvVOi66IwzOxbku99rU1
	 DFE4l0+xSwQDXnuPgpXSmPy8yId6C1Y2mVSNWrBVJfnHgB91mKiL6VopRQX2AtD4g3
	 VB5oSEjbIsaiHAoO7v++0qxt6acWbgKcDp+dYzRTsHjwfmPvXubMTcwztEMcE9twqn
	 Pqdn77Gycc9qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 39/60] kvm: Make KVM_SET_GSI_ROUTING per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-40-joro@8bytes.org>
References: <20260608144252.351443-40-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:23:40 +0000
Message-Id: <20260608192340.D1FAB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] NULL Pointer Dereference in KVM_SET_GSI_ROUTING via uninitiali=
zed planes array
- [High] KVM_IRQ_ROUTING_IRQCHIP ignores `plane_level`, breaking intended G=
SI routing behavior
- [Medium] UAPI Design Flaw forces all MSI routes to a single plane

Pre-existing issues:
- [Critical] NULL Pointer Dereference in KVM_SIGNAL_MSI and KVM_CREATE_VCPU=
 via uninitialized planes
--

commit 7d28b1526ab90d058ab359f062a984d50de2e8a8
Author: Joerg Roedel <joerg.roedel@amd.com>

Allow the KVM_SET_GSI_ROUTING on each plane.

There is still only one GSI routing table maintained per VM by the KVM
module, the plane this IOCTL was last issued at will get all GSI
interrupts.

> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -146,7 +147,7 @@ static int setup_routing_entry(struct kvm *kvm,
> =20
>  	e->gsi =3D gsi;
>  	e->type =3D ue->type;
> -	r =3D kvm_set_routing_entry(kvm, e, ue, 0);
> +	r =3D kvm_set_routing_entry(kvm, e, ue, plane_level);

[Severity: High]
Does KVM_IRQ_ROUTING_IRQCHIP ignore the plane_level parameter?

While KVM_IRQ_ROUTING_MSI correctly captures plane_level, the
kvm_kernel_irq_routing_entry struct only includes plane_level for the msi
union member. The irqchip struct lacks the plane_level field:

include/linux/kvm_host.h:
    union {
        struct {
            unsigned irqchip;
            unsigned pin;
        } irqchip;

When architecture-specific handlers like kvm_set_routing_entry() process
KVM_IRQ_ROUTING_IRQCHIP, the plane_level is discarded entirely.

Does this structurally prevent binding IRQCHIP interrupts to a plane?

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4918,6 +4918,34 @@ static long __kvm_plane_ioctl(struct kvm_plane *pl=
ane, unsigned int ioctl, unsig
>  		break;
>  	}
>  #endif
> +#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
> +	case KVM_SET_GSI_ROUTING: {
> +		void __user *argp =3D (void __user *)arg;
> +		struct kvm_irq_routing routing;
> +		struct kvm_irq_routing __user *urouting;
> +		struct kvm_irq_routing_entry *entries =3D NULL;
> +
> +		if (copy_from_user(&routing, argp, sizeof(routing)))
> +			return -EFAULT;
> +		if (!kvm_arch_can_set_irq_routing(plane->kvm) ||
> +		    routing.nr > KVM_MAX_IRQ_ROUTES ||
> +		    routing.flags)
> +			return -EINVAL;
> +		if (routing.nr) {
> +			urouting =3D argp;
> +			entries =3D vmemdup_array_user(urouting->entries,
> +						     routing.nr, sizeof(*entries));
> +			if (IS_ERR(entries)) {
> +				r =3D PTR_ERR(entries);
> +				return r;
> +			}
> +		}
> +		r =3D kvm_set_irq_routing(plane->kvm, entries, routing.nr,
> +					routing.flags, plane->level);

[Severity: Medium]
Does applying plane->level uniformly to all entries in the user payload
force all MSI routes to a single plane?

Since KVM maintains only one global routing table per VM, userspace cannot
configure a routing table where some MSIs route to plane 0 and others to
plane 1. Any subsequent call to KVM_SET_GSI_ROUTING overwrites the entire
table and binds all routes to the single plane targeted by the ioctl.

Is this intended, given it limits the ability to manage multi-plane VMs?

> +		kvfree(entries);
> +		break;
> +	}
> +#endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
>  	default:
>  		r =3D -ENOTTY;
>  	}
> @@ -5506,6 +5534,9 @@ static long kvm_vm_ioctl(struct file *filp,
>  	case KVM_CREATE_VCPU:
>  #ifdef CONFIG_HAVE_KVM_MSI
>  	case KVM_SIGNAL_MSI:
> +#endif
> +#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
> +	case KVM_SET_GSI_ROUTING:
>  #endif
>  		r =3D __kvm_plane_ioctl(kvm->planes[0], ioctl, arg);

[Severity: Critical]
This is a pre-existing issue, but can kvm->planes[0] be NULL here for
KVM_CREATE_VCPU and KVM_SIGNAL_MSI?

If planes are not explicitly initialized at VM creation, passing NULL to
__kvm_plane_ioctl() results in an unconditional NULL pointer dereference
when accessing plane->kvm and plane->level.

[Severity: Critical]
Does this same NULL pointer dereference now apply to KVM_SET_GSI_ROUTING?

If kvm->planes[0] defaults to NULL and is passed into __kvm_plane_ioctl(),
the new code dereferences it immediately:

__kvm_plane_ioctl()
    if (!kvm_arch_can_set_irq_routing(plane->kvm) || ...

Is there a guarantee that kvm->planes[0] is strictly initialized before
this ioctl can be called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D39
