Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763735AC17
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630905; cv=none; b=ugNSQyOTWJiJB0uAvX4ivTcHAp1q3BOXYIzgdfy+4Oe+pWymEjmbwn6bB8khSLBjbiZ4gdRhhkN9LT+fJ2QsAia9HjH7T2zWQgQ77/7QODU9zOQmpSZytSRzuOfnkYZ5gjxP0ZOaofGZPYuhPhBVAPyMEJyaoDlGsg2hp4A6f+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630905; c=relaxed/simple;
	bh=r4o+KObdYXf1v88imr6WghCrQvA5zRKt88qbhclbR6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbkxdfturupfMlO+WEE1wqEZVFQoIz+szsL+3ORpRLmOb368Jv+QojgHskzY4rcyNRSE8kV5BjIckynCmuPCh/Ok/IdYPFXzVYBJsxprrcPmw5FpIqpwPzD8ys2hDnCPnBj88EI8BKJydTkENO9dbaSaWuQvm2Sw80aOApVs2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH1rDbwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH1rDbwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A101F00A3E;
	Tue, 21 Jul 2026 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784630899;
	bh=nBntv6nZTJrOSMXmQYC4cvl3X4vCMjbTpJJVp0T+hck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HH1rDbwve3XR7dtJ3V5jSCj1ocAFiVJPiZbpO22klQoRPe0JQ3V0FdaEnNArVE2HC
	 Z25s9n/N4R2W02C30KK1+0gXZJMOeLRlKcieVp6l+Wwlg1OQ2BeYjhF7vRDoGMTNJW
	 aBkz7vNIq9sdUbyIEFGe9NYt8tZnXASkG1Kdxf8zLBQ0b8m/JaG9ClGZ6DAEgK4ljF
	 /Mb3DaaLogrym9Bu/PbGsCYi6CutD+0ycrXsCuBQpLAbS17MsCknMu2x+PoT3Nkkrz
	 zs6Puzx6NLd1/GQ9GRvBDww+/Mf4Yz0F/Ul+C/50IpnWDfitX/H4/UU+KGxkhdcgOr
	 dS8z/mcer+1Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260721102827.313208-1-pbonzini@redhat.com>
References: <20260721102827.313208-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:48:18 +0000
Message-Id: <20260721104819.B5A101F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler barrier allows pointer nullification to be reorde=
red before VMCLEAR, recreating the UAF.
--

--- Patch [1]: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR ---
commit 002acbf68f96812492b255bf63d17f12b9b5b24a
Author: Hyunwoo Kim <imv4bel@gmail.com>

KVM: nVMX: Hide shadow VMCS right after VMCLEAR

This commit updates free_nested() to keep the shadow VMCS pointer visible
until after VMCLEAR has completed. This change is intended to ensure that
if the vCPU migrates, the migration process can still clear an active shadow
VMCS on the old CPU.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6137e5307d0f6..d63cfdc1740e1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -350,9 +351,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
>  	vmx->nested.current_vmptr =3D INVALID_GPA;
>  	if (enable_shadow_vmcs) {
>  		vmx_disable_shadow_vmcs(vmx);
> -		vmcs_clear(vmx->vmcs01.shadow_vmcs);
> -		free_vmcs(vmx->vmcs01.shadow_vmcs);
> +
> +		/*
> +		 * Keep the pointer visible until after VMCLEAR, so migration
> +		 * can clear an active shadow VMCS on the old CPU.
> +		 */
> +		shadow_vmcs =3D vmx->vmcs01.shadow_vmcs;
> +		vmcs_clear(shadow_vmcs);
>  		vmx->vmcs01.shadow_vmcs =3D NULL;

[Severity: High]
Does this sequence need a compiler barrier (such as barrier() or WRITE_ONCE=
())
to prevent the compiler from hoisting the NULL assignment above vmcs_clear(=
)?

Because vmcs_clear() relies on an inline assembly block without a "memory"
clobber and has no direct data dependency with vmx->vmcs01.shadow_vmcs, the
compiler could legally reorder the store.=20

If a preemption occurs right between the hoisted assignment and the VMCLEAR,
and the vCPU migrates, vcpu_load() on the new CPU would IPI the old CPU to
clear the loaded VMCS. The old CPU would see the NULL pointer and skip
flushing, potentially leaving an active pointer to freed memory in its
hardware cache.

> +		free_vmcs(shadow_vmcs);
>  	}
>  	kfree(vmx->nested.cached_vmcs12);
>  	vmx->nested.cached_vmcs12 =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721102827.3132=
08-1-pbonzini@redhat.com?part=3D1
