Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FA380FF7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075218; cv=none; b=XmA59VKIFigCFjDVOa1yrSy9P5ikdCIHZasFDuZFDi7InQB57Im3HMnOerdhHQgx7sHdlHiQrMv40u4B9q+1OozMWbrP8n0748OOS/iqATTZ80/6JYMQ6HxWtyn472GsftHHggzkdyNpjUF5vYztFLLuE+7GWdy2V9zmSZg0VgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075218; c=relaxed/simple;
	bh=NaIcNssE9/zt3L5JnlC7uY1j+zcxCb1PaGhwA7m3Q9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBmL0BkSZj8VD860hErLAULZR0lN3f51FfUITOioQzfxC8E8x1NVmpYSimnQaP2p1NBtzr2iEmWVaI/1BF6fqP37BXu+NCP9kt2s7rFnZ4lc8KNSUj+cLBVoOHbpo05vZnuj/cRKd01sj9Xw+HvqKFrmT1k0wGHOJJQmuhwbkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig6w/4xD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig6w/4xD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE851F00893;
	Fri, 29 May 2026 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075216;
	bh=R760zs5Tnc+H9lKHk0neDs0Tliun93PlZ0xX0SkhCCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ig6w/4xDNc6zBcz4Dh7tVv8l05iFKPsNTGwEIO7t/2B67C+Jn18vG6qKPWZmRALiH
	 B+1BIOPCaF2xAUCY8s29sN1Uo+p9OeiNCYo9T9Afb35UTcSfjtab8AjB1bhH1onkRZ
	 VZy1p7MRT6hAPqFc3p0YiW2++wA8TWjsoZipsQA5gB2Ki1SBC8XnsDXAGg2+tLCNjv
	 owRhpUhlZyhti8yHo9MA7mJSOTKKpBG+w6N77cRDcvXeJ/IoHutwvVL00zO1xP4R0h
	 RUsLJvb7TYDqX91KBrmfyQ7o56Lg5UUrQ2vitLv4NM6XAyjn6rumdbu+jgOXZ1svC4
	 ezYhBGbAHlckg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/20] KVM: x86/xen: Use read_trylock() for GPC locks
 in hardirq/atomic paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-3-seanjc@google.com>
References: <20260529165114.748639-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:20:16 +0000
Message-Id: <20260529172016.ACE851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbalanced interrupt disable causes permanent hard IRQ disable on =
PREEMPT_RT
--

commit 13e357726c8cbadaf777f9052a529db65b824338
Author: David Woodhouse <dwmw@amazon.co.uk>
KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths

This patch modifies the GPC lock acquisition paths to use read_trylock()
instead of read_lock_irqsave() in atomic contexts. It introduces an explicit
local_irq_save() to prevent issues on PREEMPT_RT kernels where rwlock_t
cannot be used with read_lock_irqsave() from hardirq context.

Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D208f7f3e5f59c11aeb90
Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and even=
t channel delivery")

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 91fd3673c09a2..9bdb8e3cad58b 100644
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
Does this result in unbalanced interrupt disables on PREEMPT_RT?

When atomic is true, local_irq_save() explicitly disables hardware interrup=
ts.
On standard kernels, read_unlock_irqrestore() restores the interrupt state
correctly.

However, on PREEMPT_RT, rwlock_t is a sleepable lock and the implementation
of read_unlock_irqrestore() ignores the flags parameter, merely dropping the
lock without re-enabling interrupts. The interrupt state saved by
local_irq_save() is never restored, which would lead to hardware interrupts
being permanently disabled on the CPU.

I noticed this issue is resolved later in the series by commit 625a2fc07daa6
("KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xen.c").

Should this fix be folded into this patch to ensure the kernel remains fully
functional and bisectable at this step?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D2
