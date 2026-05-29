Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46B32ED55
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061073; cv=none; b=uNDP9mxB/PvBFjHDe97pISjeem94i89k12BVIoTblkXvF5eC3TuNIKZua+TsdP325hw+9U+zIlBktx9/HUM4fJKp3tcakUwqtMGkQSQ4cRFN2rQkYP+lC6vR4/WABqKp7TIODirqhgEBYy+l2nqcJ2VV0sbiciZNS+iiNVOKLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061073; c=relaxed/simple;
	bh=2ibxLK2d2nHMil68CLe+zIQaT9mcEauOlK1p68CnYdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYn4yCIPPNrkbvMutbiDa8HYmEjmWvuLBbmx9YGdj8K+lmwxORastjAJAC0lDU/NtfomqqRXmSNin//BZB+XyMWMNWlkGYnI1et94Xzj7M+lTV9HKgasF5m6cmotIuo3SbO3w2swDA1EzB6dosWIW7QOYxsJL2qjeGmjFPdWrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCgKHquV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCgKHquV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba3245a43dso158880725ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780061071; x=1780665871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmBmVT1K0qRRQvsSc3WIbJk2+VawOhHvfWgErZcdak4=;
        b=mCgKHquV1CICUwb8PGhoHbtfFfy0szgYVIzBB+0nPdYw/Vy6EldpH2sE2rwqE2Jr6A
         xJuJ8JDkz4HWh8keigYJ5EwuASQepw6wJte+3AYNE/2W5QjGvnerFZfuQC6q5kc6g4cV
         /3Ne4RfZewaL55l3AtFBQYzAH+n8y8bMGQhs7yPMLyRN9eiAL5wMmGf8XGr5rAT4XHhT
         ReLIM5h9OBtIefmC+P/wDzwlmUbnBmWX52xXCtgqEVUdIWek5QyHWitnTBlxWXh0vl4t
         24daxq0SsXIOuXoLlMUSWrYW0EkvRl0hxSi/sP0LfjDiVqb1caQRQxQzR/TMi+2TLCFW
         pwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780061071; x=1780665871;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pmBmVT1K0qRRQvsSc3WIbJk2+VawOhHvfWgErZcdak4=;
        b=bb1kxjgldlKTpPwUdzbbyB3AKVYFaJ4sOJAvXUDL4N2sIaGVPAmoi9Z/dk3U2e57Rl
         fLQugpTUH8Fvpyqxses7OaiePIyXjq6Jq93NEsbj1LDaKiMRUUUbEsugZXJ42AxQaLXG
         ZGxjmiHIuuMI5rIBFOfMiapOhkFSDXeaUMUH4QmVw/5AUYIevn8tKNXx41y1waX/qeMh
         sFPl3vmCLWoMdeXXp59XjAKW0wh5GsJbbJMUPPX+YZE2ekZVC6euhtA9+5T2uVKHyy4o
         tmkVsD3bKoAeD2YVlJ38WC7leFf8RbmcKMb073giXM3cLv5dhhrYtuw1s37LXh9/lyZk
         UfcQ==
X-Gm-Message-State: AOJu0YyUgen4Pc48oMLFVfPmqlAjfzu7oHJYxYYdnxoNC+NQ/55/iZ9p
	9xintwz3mFX4Azo2PlUiWFHKeMP3TWY19O9NV0tkXYWB9WsZ2TBlk0m3HS67tdf9/4Hq7082q18
	xJCykSw==
X-Received: from plbkk16.prod.google.com ([2002:a17:903:710:b0:2bf:222e:c947])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84d:b0:2bf:af8:7de8
 with SMTP id d9443c01a7336-2bf20bb94b3mr38276425ad.30.1780061070656; Fri, 29
 May 2026 06:24:30 -0700 (PDT)
Date: Fri, 29 May 2026 06:24:30 -0700
In-Reply-To: <20260529091714.287963-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529091714.287963-2-clopez@suse.de>
Message-ID: <ahmTjp-95M5IjGxu@google.com>
Subject: Re: [PATCH] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@qumranet.com>, 
	Qing He <qing.he@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026, Carlos L=C3=B3pez wrote:
> When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
> the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
> updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
> same PIC state does not grab such lock, potentially causing torn reads
> for userspace.

Meh, if userspace hasn't fully paused the VM, save/restore is going to fail
anyways.  Heck, torn reads is probably _better_ than the alternative, becau=
se
at least that might cause visible failure during the restore.  If there are
concurrent modifications in-flight, then KVM_GET_IRQCHIP is going to return
stale data (assuming userspace doesn't redo KVM_GET_IRQCHIP), i.e. save/res=
tore
will effectively corrupt the guest.

> Fix this by grabbing the lock on the read path.
>=20
> This issue goes all the way back. The bug was introduced with the
> addition of PIC ioctl code itself in 6ceb9d791eee ("KVM: Add get/
> set irqchip ioctls for in-kernel PIC live migration support"). Later,
> 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU
> ioctl paths") added the locking for kvm_vm_ioctl_set_irqchip(), but
> missed kvm_vm_ioctl_get_irqchip().
>=20
> Fixes: 6ceb9d791eee ("KVM: Add get/set irqchip ioctls for in-kernel PIC l=
ive migration support")
> Fixes: 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CP=
U ioctl paths")
> Cc: stable@vger.kernel.org

This isn't stable material.  There's basically zero chance this actively
problematic for any VMM.

Honestly, it's tempting to I'm tempted to do the opposite, and yank out the
locking for the KVM_SET_IRQCHIP path, because userspace really can't be rel=
ying
on kernel locking for correctness across save/restore.  I don't _actually_ =
think
we should do that, but it certainly is tempting.

Ah, actually, maybe SET has locking because it's also used to reset PIC sta=
te,
i.e. isn't limited to just save/restore?  Doesn't really matter.

> Reported-by: Claude Code:claude-opus-4.6
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/irq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 9519fec09ee6..251df563427b 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -584,14 +584,18 @@ int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struc=
t kvm_irqchip *chip)
> =20
>  	r =3D 0;
>  	switch (chip->chip_id) {
> -	case KVM_IRQCHIP_PIC_MASTER:
> +	case KVM_IRQCHIP_PIC_MASTER: {
> +		guard(spinlock)(&pic->lock);

I'd much rather use "manual" spin_(un)lock() instead of guard().  Or scoped=
_guard()
to avoid the curly braces, but even then, I find this:

		scoped_guard(spinlock, &pic->lock)
			memcpy(&chip->chip.pic, &pic->pics[0],
			       sizeof(struct kvm_pic_state));

to be much harder to read than:

		spin_lock(&pic->lock);
		memcpy(&chip->chip.pic, &pic->pics[0],
			sizeof(struct kvm_pic_state));
		spin_unlock(&pic->lock);

And no one can reasonably argue that guard() or scoped_guard() makes the th=
is
particular code more robust.

>  		memcpy(&chip->chip.pic, &pic->pics[0],
>  			sizeof(struct kvm_pic_state));
>  		break;
> -	case KVM_IRQCHIP_PIC_SLAVE:
> +	}
> +	case KVM_IRQCHIP_PIC_SLAVE: {
> +		guard(spinlock)(&pic->lock);
>  		memcpy(&chip->chip.pic, &pic->pics[1],
>  			sizeof(struct kvm_pic_state));
>  		break;
> +	}
>  	case KVM_IRQCHIP_IOAPIC:
>  		kvm_get_ioapic(kvm, &chip->chip.ioapic);
>  		break;
>=20
> base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
> --=20
> 2.51.0
>=20
