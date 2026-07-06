Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1333BCD3C
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330840; cv=none; b=qJZCFlv9/czqXAw3xdmn5MKKJo1tXfcup2R21zepZYFaZdGcBJ47Kd8maIR3cwYhWbEynT/4db5a1JGs2kPRlmkIR7qaB/oHPeyCtaUTmbLD3plv+Fc02eskPm8yf+fDikPoiFTQ8XNCn9/cx9kRrEraPGaRh2/v2usEyQF7ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330840; c=relaxed/simple;
	bh=fwE45Cz0lOLaLjCZHFSQkDCjLtBslmqbv44Ncf+LRKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLir9wCqd2DLo09Q6PpUQs12crdED6qrfVyBSLP6YJeN1e1Dg8+lqK82K12EmvQ8nmcE/xxcOzerz0hs4cY+e6Yiu4z7uyfL0jhTtupO3Z7fP5ct9rnmX+v+FkXJFBfrYYTxmILycA6bxQMLAg6pgXz9i6IQOjybUvcOMxTeIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtD+de/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtD+de/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104AA1F000E9;
	Mon,  6 Jul 2026 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330837;
	bh=cr9hpfKkpYn5/wljN6YbRjUSxjeuc0Gl0yYsnYy6KkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NtD+de/pY7iCeV6BEKTDoXTTax3LZzwQRRGAs8hYdTOSc7vulc7FD+tSoW6bB7s/d
	 5cUOx7jD8nJwtmhV19Ud431zzpEPAmm6pHTwSYbUMBroa/9AR9OFUc1gav5CC4T7RW
	 t/p7nCTSL0xKDK1OD/5FUmG0fubxOnelVXAmog0uVU0t+IiXlULv3UNYYtPQ3QXplR
	 YWt76I67KEcp6PuvSQaUrVGk0JcE/R8a1mmsMw2w7sPVamnVuoQYHTWe8vcWlp/dej
	 WT8bQhBbVT9hFZ3XZO6Hroh4U4pPQWM6Xda3IKKEOZ0B8xS3sXC/nYYkyHWK9RhLv9
	 sqq50hb/GhU3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: x86: Reject KVM_CREATE_IRQCHIP if APIC base is
 already mapped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Wiederhake" <twiederh@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706092021.3625908-5-twiederh@redhat.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
 <20260706092021.3625908-5-twiederh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:40:36 +0000
Message-Id: <20260706094037.104AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `gfn_to_memslot()` in `KVM_CREATE_IRQCHIP` without holding=
 the SRCU read lock (`kvm->srcu`) or the memslots update lock (`kvm->slots_=
lock`) leads to a Use-After-Free and triggers a lockdep warning.
--

commit 69e98e42c78858b7858a1956e233c569faf47ae1
Author: Tim Wiederhake <twiederh@redhat.com>

KVM: x86: Reject KVM_CREATE_IRQCHIP if APIC base is already mapped

User space must not map guest memory that covers the default APIC base
address when using an in-kernel irqchip. This commit adds an explicit
check to KVM_CREATE_IRQCHIP so the conflict is reported at the point
where the constraint takes effect.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -4413,6 +4413,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		if (kvm->created_vcpus)
>  			goto create_irqchip_unlock;
> =20
> +		r =3D -EEXIST;
> +		if (gfn_to_memslot(kvm, gpa_to_gfn(APIC_DEFAULT_PHYS_BASE)))
> +			goto create_irqchip_unlock;
> +

[Severity: High]
Is it safe to call gfn_to_memslot() in this KVM_CREATE_IRQCHIP path without
holding the kvm->srcu read lock?

Looking at kvm_arch_vm_ioctl() in arch/x86/kvm/x86.c, only kvm->lock is
held when KVM_CREATE_IRQCHIP is executed.

If another thread concurrently calls KVM_SET_USER_MEMORY_REGION, it replaces
the memslots array under kvm->slots_lock and calls synchronize_srcu().
Because KVM_CREATE_IRQCHIP does not take srcu_read_lock(),
synchronize_srcu() won't wait for it.

Could this traversal of the memslots array in gfn_to_memslot() encounter a
freed array and result in a use-after-free, as well as a suspicious RCU usa=
ge
lockdep warning?

>  		r =3D kvm_pic_init(kvm);
>  		if (r)
>  			goto create_irqchip_unlock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706092021.3625=
908-2-twiederh@redhat.com?part=3D3
