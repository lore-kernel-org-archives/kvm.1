Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FA497B63
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164576; cv=none; b=jsxnO75LQgkLC/SXHnf773VzQ5VRlQDSiQhG8rCaekBys2F2/IdaPM1JR+f+g9LxNzpiHaVuIiOlC5KB0JplD/XVjHktk6vQFxmKLkdiGYTTyLwkfpz8ktJE2F3YFCtxGlVnY7c8L8QyWxy/MdaZinCGN9opca3ZIqayI91Dkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164576; c=relaxed/simple;
	bh=zedo3BWpFfXXb0OPnVFKY2fidVlxIfnxdRbb2gRDYPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7v/ouHKzAjzW2Y/1+Do2l+qLGegb7Zh8A/sMJJ3+y9f49Ax1Nr/d1/QkX36AS6w7r3BKyMz5FVkYMSHpwC/xR8B32l4i1m3C1jDgGKD/7sExKnDecpz11NXJ6rU17irecVZTpLv8OrMDY70F0jcKpyPsotT1mpKGUW3nyfRz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRQ1hM91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRQ1hM91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0831F0089B;
	Fri, 11 Sep 2026 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164573;
	bh=HMDUEBr1Nm43XvBsVBJJk8oJ4x8YuImLOsJ+ORDRRTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRQ1hM91KipwLkAYzjpn/WZnx184Glj9/qqjPf9P19V0LIymxMlN/kINp2WRPQauF
	 YMDcjI5XlYXelvpr0iA81UNvrEa0k9ZL9tfUFWz7y5dBHvMFxSEaNR8AidTc23XrMp
	 ZvFjK+Z5Vm1AbJLgiRnnv8cVFCUfYLkR4vdFwn2Fq3cCooCzd8dUlJH2tlRHPB5U/S
	 49XDSJi2B96D9HWLJrk6sb6RXxPfGofUyORUPc5dzutetZ2DTWPIBxbbuyLzfnJhpr
	 6GFjM1zl8dlYrB3IGdHkm0OEY1MHjD+YP4OEuFEnMgccF9sjHITe+AS6E6I3N5v7wW
	 rrdMoXCwF6tSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/28] KVM: VMX: Virtualize FRED nested exception
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-14-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-14-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:09:33 +0000
Message-Id: <20260911220933.AC0831F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM incorrectly flags an exception as nested when it replaces an u=
n-injected, merely pending exception.
--

commit a3ba5314358330c25b6d179842584793ca6f0e34
Author: Xin Li (Intel) <xin@zytor.com>

KVM: VMX: Virtualize FRED nested exception tracking

This commit adds virtualization support for FRED nested exception tracking =
in
KVM by setting the VMX nested exception bit in the VM-entry interruption
information field. It also updates exception queueing to track and save the
nested flag across VM migrations.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 01198aba27cf0..94d684210cf6c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -510,6 +516,9 @@ static void kvm_multiple_exception(struct kvm_vcpu *v=
cpu, unsigned int nr,
> =20
>  		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
>  	} else {
> +		/* The new exception arrived while delivering the previous one. */
> +		is_nested =3D true;
> +

[Severity: High]
Is it correct to unconditionally set is_nested =3D true here even if the
previous exception was only pending and not yet injected?

If KVM queues an exception in software (vcpu->arch.exception.pending =3D tr=
ue,
injected =3D false) and a second exception is queued before the next VM-ent=
ry
(e.g., a #PF during subsequent KVM request processing or emulation), this
path replaces the purely pending exception with the new one.=20

Since an exception that hasn't commenced hardware delivery cannot cause a
nested exception, setting is_nested =3D true here will inject the new excep=
tion
with INTR_INFO_NESTED_EXCEPTION_MASK. Could this violate the FRED architect=
ure
specification by causing the guest hardware to incorrectly interpret the ev=
ent
as occurring during event delivery, pushing a FRED stack frame with the nes=
ted
bit set and potentially selecting an incorrect ring 0 stack level (such as
IA32_FRED_RSP1 instead of IA32_FRED_RSP0)?

>  		/* replace previous exception with a new one in a hope
>  		   that instruction re-execution will regenerate lost
>  		   exception */
> @@ -538,7 +547,8 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *=
vcpu, unsigned nr,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D13
