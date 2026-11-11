Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427423;
	b=O3uNqPqHl9xTes6pu+lSjN5Mq99rgBcnmjUyVg4Mg/BCCV0pXCy7x5eaPUxQ8kObPw1v
	 5zuP1F4JNlFz/yy96VwaqyILLY/PHHLBo/WD3vK/fim0PsFc3KPiSnLXUYHNjlJyr6D+/
	 0NBiom6vMajDmGqaaeuLpGvqCSyDnzQ+bC7/XpT/A+khgABxUVh8iHYY2rJxyH9R8LhMD
	 lS5lHYC1DCNqIuhMB98tC8niLlrD2rWEsjMFKgizXrzZqfrhf8Fj3lAVbN+RGYNy2iWy9
	 AVmKgh44cSX+4efYyl6YopoqY/SnnP/vsnAncgdkOM6mnlegOw5FMOU3WnpFWkXzuvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427423;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=clYOcOnlOp5XUtcXbby2PrA4MJzHeQuP1FvjXgxCqAk=;
	b=jlrZksDioyeCp6vObym0s+7aSAvwTokLJEPkZ4zdhJWPV9Y0WepeuA2AmbO4chatavx/
	 RMnX1v7fk/dBJDTBtu+DZDrC/R8wAxSdTUvTH2aWMWQeuRve/xOmd93GKZkyTiFLpddjB
	 lTfBgBRsmDiR1unmUEirJmWTRFijhAEbBjbep0GcDTGef6PJwbMH2GdMHp98Dy37B8MPO
	 PqWcCntCiU8UzyMNwQhprbZHHtT9w/6JgSTQ0KDI48rhMvtncxp19jHLdaDS218N6wj+/
	 k/DY+N3EZS/ZBn4kM/F4QYx8BmkMmOs5uqOd8F92Iwko43r8fxwdqtYBTwFaeIqJPVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH2tVseh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A08606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH2tVseh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0739F1F00A05;
	Wed, 11 Nov 2026 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427423;
	bh=clYOcOnlOp5XUtcXbby2PrA4MJzHeQuP1FvjXgxCqAk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nH2tVseh3gAnmY/QqpmSfUCFEKAIrU3WeIp9TUprcgGudgItltf1Wujvo/LGtBrDT
	 8aP/2LfikwZD9jPN7JYv4/XQXwmu9G18+rGVbkCBXz8M6TOQfQNACF+iK8osKX1cRy
	 fUxUC0Ia1cv3bGAUgeWAfBAGghluWTi+5QqfnVz14EPhaeMUorr4e2mRUUxJulm5jM
	 Fjk8dBAFMpfXy9/bC3pbl6qNtRF4AsrdGCmJu0plkYfIB/urRphl9g+YRf08nc1lzN
	 qpUJKRUBBXWNTRK9gaSGng/gsPrB11eBEZJ22e3ZF84rDCNPrHFuFFfog12oPLGa5N
	 uc0+x/30bc9pQ==
Message-ID: <sashiko-outbox-209604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] riscv: KVM: do not save host vector context for
 vcpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Chiu" <tchiu@tenstorrent.com>, kvm@vger.kernel.org
In-Reply-To: <20261111184359.1239821-7-tchiu@tenstorrent.com>
References: <20261111184359.1239821-1-tchiu@tenstorrent.com>
 <20261111184359.1239821-7-tchiu@tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:03:42 +0000
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
- [High] riscv: KVM: build failure in kvm_riscv_vcpu_enter_exit() when
  !CONFIG_RISCV_ISA_V
- [High] riscv: KVM: guest CSR_VCSR state leaks to host in
  kvm_riscv_vcpu_host_vector_restore()
--

commit e0f5ce69db9b4e847c776901421a3c6de8e57845
Author: Andy Chiu <tchiu@tenstorrent.com>

riscv: KVM: do not save host vector context for vcpu

This commit removes the per-vCPU host vector context buffer and replaces the
explicit host vector context save and restore in kvm_arch_vcpu_load() and
kvm_arch_vcpu_put() with deferred thread vector state restoration.

> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 60fa280309444..06409c870a069 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
[ ... ]
> @@ -77,11 +76,7 @@ static inline void kvm_riscv_vcpu_guest_vector_restore=
(struct kvm_cpu_context *c
>  {
>  }
> =20
> -static inline void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_contex=
t *cntx)
> -{
> -}
> -
> -static inline void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_con=
text *cntx)
> +static inline void kvm_riscv_vcpu_host_vector_restore(void)
>  {
>  }

[Severity: High]
Does building with CONFIG_KVM enabled and CONFIG_RISCV_ISA_V disabled fail =
in
kvm_riscv_vcpu_enter_exit()?

Earlier in the series, commit "riscv: vector: refactor vector context
operations" renamed __kvm_riscv_vector_restore() to
kvm_riscv_vector_restore() under #ifdef CONFIG_RISCV_ISA_V and at the call
site in kvm_riscv_vcpu_enter_exit(), which is compiled unconditionally, but
the !CONFIG_RISCV_ISA_V stub in arch/riscv/include/asm/kvm_vcpu_vector.h is
still named __kvm_riscv_vector_restore().

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 730c32f7de504..6129a6e184049 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -61,17 +61,9 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cp=
u_context *cntx,
>  	}
>  }
> =20
> -void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
> +void kvm_riscv_vcpu_host_vector_restore(void)
>  {
> -	/* No need to check host sstatus as it can be modified outside */
> -	if (!kvm_riscv_isa_check_host(V))
> -		kvm_riscv_vector_save(cntx);
> -}
> -
> -void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
> -{
> -	if (!kvm_riscv_isa_check_host(V))
> -		kvm_riscv_vector_restore(cntx);
> +	riscv_v_vstate_set_restore(current, task_pt_regs(current));
>  	riscv_v_flags_set(riscv_v_flags() & ~(RISCV_V_VCPU_CTX | RISCV_V_VCPU_N=
EED_RESTORE));
>  }

[Severity: High]
Can the guest's CSR_VCSR value leak into host userspace after exiting the
guest?

When the host task enters ioctl(KVM_RUN) via do_trap_ecall_u(),
riscv_v_vstate_discard() sets task_pt_regs(current)->status to SR_VS_INITIAL
(or leaves it at SR_VS_OFF if the task has not used vector instructions).
While running the vCPU, kvm_riscv_vcpu_enter_exit() ->
kvm_riscv_vector_restore() loads the guest's vcsr into hardware CSR_VCSR (or
CSR_VXRM and CSR_VXSAT on XTheadVector), and the guest can also modify it
directly.

On vCPU put, kvm_riscv_vcpu_host_vector_restore() now only schedules a
deferred restore via riscv_v_vstate_set_restore().  When returning to host
userspace with SR_VS_INITIAL, riscv_v_vstate_restore() calls
__riscv_v_vstate_discard(), which resets v0..v31, vl, vtype, and vstart, but
never writes CSR_VCSR:

arch/riscv/include/asm/vector.h:riscv_v_vstate_restore() {
	...
	riscv_v_enable();
	if (__riscv_v_vstate_check(regs->status, INITIAL))
		__riscv_v_vstate_discard();
	else if (__riscv_v_vstate_check(regs->status, CLEAN))
		__riscv_v_vstate_restore(vstate, vstate->datap);
	riscv_v_disable();
	...
}

This leaves the guest's CSR_VCSR active in hardware when host userspace
resumes (and across riscv_v_ucontext_save() on signal delivery or ptrace), =
or
for the next task that hits __riscv_v_vstate_discard() on that CPU if the V=
MM
task had SR_VS_OFF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111184359.1239=
821-1-tchiu@tenstorrent.com?part=3D6
