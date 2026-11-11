Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425437;
	b=YlrsrjH01zSqzT4kEZEFhGBWiqb6on6bBM90wEHjuYrKY6J45MeTpsrA7bicvmFIcRpH
	 93814xuPhnWR29zcFvVyhFmoQ2P05vVyQArhQHT11UP4o5I4+Pkt3Q0hLqmUKtTjFbzOu
	 QscPRA7cwhEQzyBqvWTnfrjOv4hV7HbjONQErir9TKXYvU7/AWGXM7T81Yr9o6+AUJpE+
	 qge0N+KNm3x46OZz5KpcdJLOfJAREee/NY8k8PEipDjNA6aKLOiepefEQ6Y7eSctF4P3L
	 +hP8RnZU5lx3YK8H6dq+rSJ/ajCefWCEaupEpOz3UnuA3epL2lvVoJ6fFQ2GVhWD83g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MtYC/sa7VXSOmj+3QtioMivBT5nMzQqCuP/fgR0mmjs=;
	b=zCYUhAZ1NT6M5YSMfhj6FN9LrkHPsUpoVT7cFlYDm5WRmU50RgsP2BWztRj25ZODSWkD
	 bpF7r2X1paFKi3mA1VfeGXCouaVkfn8if0UUNEc2PqZm1c0l6PaRdbrT8SSovr9NphuTJ
	 zPPqkUMip9FNmu4RIpNSoYtqYPEP13YfLYKS/WE/YQUaL9O9g5sSfv6FYUatVm/+leBxW
	 DSdlXxj1Wr+ZRm4/RexDMgL9v1DzAQTfBMpUa1FxKeAPGC7eIbHJ7S4hUj5kVSWY7nUm7
	 FiYSx1QpZmUmkxfJ1kYC93aVg+9bzYHguVlb6JXCPdG9f5fpiQXFIpCCBd684qyDeWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA5R9P4K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC7606A324
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA5R9P4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8654B1F00A05;
	Wed, 11 Nov 2026 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425436;
	bh=MtYC/sa7VXSOmj+3QtioMivBT5nMzQqCuP/fgR0mmjs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cA5R9P4KrmWG5PDQh6yaU7TkdrX44puyFtesN9E9+JwHco7MMPfv5Wn5Va0jii6Rj
	 /I6TXrRpRlDPhE+GZx/2kA76wRamBSJk+8YpxzVefu3LHIXdnYpKReHpILQoFgUmEx
	 TplSczlokANHxV/hBPbYhWaGotmshHuwiUEQDRg0Xph9ZEK+tanayFL0JkQpIyv9Z3
	 whvwDmItkHYgKav10Yyf8VKkukHe6rEihMmxhTv1x3iLgHcZr5IvsVYlIVOj36RUIB
	 QqpNKRPQSFnmSt6MbnfCPpJOIY1XGJlncGdX5W3c6dszUrPv++v5YDOYr2uKwmYQHa
	 HQSasDBgiKSNw==
Message-ID: <sashiko-outbox-209563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] riscv: vector: refactor vector context
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>, kvm@vger.kernel.org
In-Reply-To: <20261111184359.1239821-2-tchiu@tenstorrent.com>
References: <20261111184359.1239821-1-tchiu@tenstorrent.com>
 <20261111184359.1239821-2-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:30:36 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] riscv: kvm: unrenamed __kvm_riscv_vector_restore() stub breaks
  !ISA_V build
- [Low] riscv: vector: commit message describes preempt_v changes not in
  diff
--

commit 7053b3ce403daff58cb731616963dcc0c16f7edb
Author: Andy Chiu <tchiu@tenstorrent.com>

riscv: vector: refactor vector context operations

This commit lifts riscv_v_enable() and riscv_v_disable() out of the
low-level __riscv_v_vstate_{save,restore,discard}() helpers into their
callers and renames the KVM vector save/restore helpers.

>     Also, refactor and document about the user context save in preempt_v =
to
>     make code more readable.

[Severity: Low]
This isn't a bug, but the preempt_v refactoring and comment described here
are not in this patch; they were already included in commit b5060a4aa33d
("RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector").

> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 50d4789b9cac9..60fa280309444 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -16,14 +16,18 @@
>  #ifdef CONFIG_RISCV_ISA_V
>  #include <asm/kvm_host.h>
> =20
> -static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> +static __always_inline void kvm_riscv_vector_save(struct kvm_cpu_context=
 *context)
>  {
> +	riscv_v_enable();
>  	__riscv_v_vstate_save(&context->vector, context->vector.datap);
> +	riscv_v_disable();
>  }
> =20
> -static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_co=
ntext *context)
> +static __always_inline void kvm_riscv_vector_restore(struct kvm_cpu_cont=
ext *context)
>  {
> +	riscv_v_enable();
>  	__riscv_v_vstate_restore(&context->vector, context->vector.datap);
> +	riscv_v_disable();
>  }

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index dd786f758eb76..caf6e0ad72efd 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -825,7 +825,7 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct =
kvm_vcpu *vcpu,
>  	if (current->thread.riscv_v_flags & RISCV_V_VCPU_NEED_RESTORE) {
>  		current->thread.riscv_v_flags &=3D ~RISCV_V_VCPU_NEED_RESTORE;
>  		current->thread.riscv_v_flags |=3D RISCV_V_VCPU_CTX;
> -		__kvm_riscv_vector_restore(gcntx);
> +		kvm_riscv_vector_restore(gcntx);
>  		gcntx->sstatus =3D (gcntx->sstatus & ~SR_VS) | SR_VS_CLEAN;
>  	}

[Severity: High]
Does this break the build when CONFIG_KVM is enabled and CONFIG_RISCV_ISA_V
is disabled?  The stub in the #else branch of
arch/riscv/include/asm/kvm_vcpu_vector.h is still named
__kvm_riscv_vector_restore(), so kvm_riscv_vcpu_enter_exit() calls an
undeclared function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111184359.1239=
821-1-tchiu@tenstorrent.com?part=3D1
