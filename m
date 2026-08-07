Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E592D5937
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105712; cv=none; b=O47GFlZ0vuw+WtpfRqrdP+yTrw6ZjQHyEDMzAEZJS5UOpoYhvEBxMZRZrSXnDSpqyLuGwOOzj1GX81G7xRedELatcqgRGbfaBPxlPx9VAe9Hfllgv9fHJSt6/uUH2XBUTgwf2dv4TJO4EmzMItWTPl7ov+Gzr8VE21VzT0onp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105712; c=relaxed/simple;
	bh=dlZmi+oG/Rd090FS7NEffn7yJsAbeyGLU8uKVrQRE9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XgxpXs0purfxxcEJUaEyQXsudxwM5XJQ/+McfUDPtTqgvcUb+dkWGpI3u09Mou5/cWmXOpPDgjompJvuQ+6AIjTwr6Rgv9HLZe1hlRxBnYkAE+MbjJiA6L3H9QTPYXc8fucWeMJdeN6Dv8CjG0LDyxLKUgT/fp0VqijdOxMlg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2of/K5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2of/K5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6AE1F000E9;
	Fri,  7 Aug 2026 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786105686;
	bh=Ri9jT6oGquWaqYtq0zr/hrirIVyCa3IkUFZyqIT02ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2of/K5ikF2CnRWBO3S1vEO3bQi6kNVcAueuOEQr/cOTQtYn0E2PoQq+i5a5ftNxa
	 FVNYKHZYjSVl7LBFU6XBTRCD1HcHvVHZNAd3u/ySP1m6VdjwLeR9N1b2aZKE9QiHQO
	 WyOA1IpEvvjLVcnkY0Skub9t8JIBqqNr2bXPipaVynysFFOeLSNtn+SBx+w0aVkPcA
	 crS79N0jf/YjeJ299MDOxTEgOwhiwn674X9KsUmNCtRPs6xPdTJfwgILLUhITGnxoU
	 rK3nmh/IUyvZ7w4x5JU035FejRXZjwIdfOkZYG+Wp/DXE2/H8GMJ40b6dr2twUWPx2
	 WF/IPa+SMqq5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/xen: Use read_trylock() for GPC locks in
 hardirq paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "sai madhu" <suryasaimadhu369@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807121906.925704-2-suryasaimadhu369@gmail.com>
References: <20260807121906.925704-1-suryasaimadhu369@gmail.com>
 <20260807121906.925704-2-suryasaimadhu369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:28:05 +0000
Message-Id: <20260807122806.5D6AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware interrupt leak on PREEMPT_RT in __kvm_xen_has_interrupt()
--

--- Patch [1]: [PATCH] KVM: x86/xen: Use read_trylock() for GPC locks in ha=
rdirq paths ---
commit 094309ad41a72add2b4de793f00e2fe6f42178a3
Author: sai madhu <suryasaimadhu369@gmail.com>

KVM: x86/xen: Use read_trylock() for GPC locks in hardirq paths

This commit switches GPC locks in hardirq paths to use read_trylock()
instead of read_lock_irqsave(). This prevents sleeping on PREEMPT_RT
and under lockdep, returning -EWOULDBLOCK when the lock is contended.

Fixes syzbot: https://syzkaller.appspot.com/bug?extid=3D919877893c9d28162dc2

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 694b31c1fcc9a..02f30d79513db 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -713,7 +714,15 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
>  	BUILD_BUG_ON(sizeof(rc) !=3D
>  		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
> =20
> -	read_lock_irqsave(&gpc->lock, flags);
> +	if (atomic) {
> +		local_irq_save(flags);
> +		if (!read_trylock(&gpc->lock)) {
> +			local_irq_restore(flags);
> +			return 1;
> +		}
> +	} else {
> +		read_lock_irqsave(&gpc->lock, flags);
> +	}
>  	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
>  		read_unlock_irqrestore(&gpc->lock, flags);

[Severity: High]
Does this leave hardware interrupts disabled on PREEMPT_RT?

Since local_irq_save(flags) is called manually here when atomic is true, but
the lock is later released using read_unlock_irqrestore(&gpc->lock, flags),
will the hardware interrupt state be correctly restored?

Looking at include/linux/rwlock_rt.h, read_unlock_irqrestore() for rwlock_t
on PREEMPT_RT is mapped to rt_read_unlock(), which drops the lock but
completely ignores the flags parameter:

include/linux/rwlock_rt.h:
static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
						   unsigned long flags)
{
	rt_read_unlock(rwlock);
}

If atomic is true, doesn't this mean the previously saved hardware interrupt
state is never restored here or at the end of the function, causing IRQs to
remain disabled indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807121906.9257=
04-2-suryasaimadhu369@gmail.com?part=3D1
