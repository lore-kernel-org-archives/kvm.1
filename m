Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386222D739C
	for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783847470; cv=none; b=OAYHhd/OQG79bk3UxKHRB9IUwPmhxGHOM8GdmKD/9sEorIC6mDQB9424r4knJhAk3TVSxbq3BgTvCapGdh9nK9WZ5sWkyF02nY/2OK2sZpczCwr675NP3oriXVndz+/yM8xGcVlPz1goLHBpEnYQJd3/tx7PJmViOSn+8x9sQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783847470; c=relaxed/simple;
	bh=6TfFb/q81hAqkT8S7x4FJDgB5v0KiygivnvQIn/Y4Zg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Il/ft40Jk8D6V5GhLYm8SA35ayO2HnlGE3VggKlFF/npGk4MmG8MPzpZpMFI234D7Fj2KDtzx1PaZ3Pkfw6I4Pfe80C+lmvjwy5qWuOocyzWHWkmv2Vv/oMsY6xhMc8HARaooXPp17fKaoNpH3xkd4qUfxd980J5YBdCDdKqRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvPTlpVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvPTlpVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903141F000E9;
	Sun, 12 Jul 2026 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783847468;
	bh=iHqX4auErUgnaVJowfeIqTbTJvzjdn9tRdFwhga15gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvPTlpVR/n9N8HiQtA5TZ3pKR6FaUVIjJb96OybAai8cAVMUyXwC29N1LzH21110D
	 4+fTMMGyxTXHg75sAw+CNeEms2zvn8ZdgZ9oY2r8Z6WNH1KubRxSszbt7ILMcFAdGu
	 EdkIl73uBiaASK9692Kyd4FytbPrRXXVQIBeuyvoYizw1cRO43uHIt3EkENnwo01K5
	 n/hkUkbJl9qpFKr8XXabqg5LYRv08+5ZDC3yF05LXnF5xiKx8pz/2wIIWpB+dHNgCf
	 RYnkM1HejNGUdXvXsaljnC3dEX/lVE12adxhpAJ2zq0uPpW1CXcjyYUBWpEp8DOx/x
	 dG5SDu8ZQ09Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Handle -1 return from kvm_cpu_get_interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260712090039.36038-1-kartikey406@gmail.com>
References: <20260712090039.36038-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 09:11:07 +0000
Message-Id: <20260712091108.903141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a control flow bypass regression. By replacin=
g `WARN_ON_ONCE(irq =3D=3D -1)` with an early `goto out;`, the function `kv=
m_check_and_inject_events()` prematurely aborts. This inadvertently skips t=
he critical trailing check for nested events, potentially breaking nested v=
irtualization.
--

--- Patch [1]: [PATCH] KVM: x86: Handle -1 return from kvm_cpu_get_interrup=
t ---
commit 5f633807782c397266e8aeeaaf39fb310a7b09ee
Author: Deepanshu Kartikey <kartikey406@gmail.com>

KVM: x86: Handle -1 return from kvm_cpu_get_interrupt

This commit modifies kvm_check_and_inject_events() to gracefully handle a
valid race condition where kvm_cpu_get_interrupt() returns -1. It replaces
a WARN_ON_ONCE with an early goto out to handle situations where another
thread has already consumed the interrupt.

Link: https://syzkaller.appspot.com/bug?extid=3D9dcd0a11dc9703a49511

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff8812f3a1293..ec449e9a3f954 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10765,11 +10765,11 @@ static int kvm_check_and_inject_events(struct k=
vm_vcpu *vcpu,
>  		if (r) {
>  			int irq =3D kvm_cpu_get_interrupt(vcpu);
> =20
> -			if (!WARN_ON_ONCE(irq =3D=3D -1)) {
> -				kvm_queue_interrupt(vcpu, irq, false);
> -				kvm_x86_call(inject_irq)(vcpu, false);
> -				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
> -			}
> +			if (irq =3D=3D -1)
> +				goto out;

[Severity: High]
Does this early goto out prematurely skip the remaining checks in
kvm_check_and_inject_events()?

By jumping directly to out, the code skips the enable_irq_window() call and
the trailing nested event evaluation block:

	if (is_guest_mode(vcpu) &&
	    kvm_x86_ops.nested_ops->has_events &&
	    kvm_x86_ops.nested_ops->has_events(vcpu, true))
		*req_immediate_exit =3D true;

When a concurrently consumed PIC interrupt results in irq =3D=3D -1, wouldn=
't
bypassing this logic prevent KVM from setting req_immediate_exit when
required, potentially causing the vCPU to incorrectly continue executing L2
guest code instead of exiting to L1?

> +			kvm_queue_interrupt(vcpu, irq, false);
> +			kvm_x86_call(inject_irq)(vcpu, false);
> +			WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
>  		}
>  		if (kvm_cpu_has_injectable_intr(vcpu))
>  			kvm_x86_call(enable_irq_window)(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712090039.3603=
8-1-kartikey406@gmail.com?part=3D1
