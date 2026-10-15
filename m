Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D14A3D43
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047658; cv=none; b=U1z15un1n/Ftj8RfRGeGLqGBKJeGz5lGXgIQzIYtDxk9DLgizYundJgfMMp86G6pqIzpNoOkaQeKGGYrTvG1ehEopziHv5mYeIw22fjxQIjSyAIG16yvVv211o5aD+lRv8HN3ntB27IdxwYJBuWpivaI2jZ6Cx1oW94TTwAle/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047658; c=relaxed/simple;
	bh=HQudrdFWdXtigw65AVjjwXJilPkHLFy8pg7nityqZlY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=EY4DlIv9MUJ22zk/cumnOH8rapRSTmT3AQygyhruuDUdfqt2+AFc9CG3LauZPcrLUT4LnwPl+GkEy2cHqLKZHTECfsmA35FsSfuagFFTP0nU5M/jDXblSO+xmc1p7cUOrnZ4zcEVc6VxLe6wT7HOZ9SRZ4nWvgo0rmzTzc/0k1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcMOvK0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcMOvK0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF5D1F000C4;
	Thu, 15 Oct 2026 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792047649;
	bh=N2nklHYDozmKkaycvwVIIqvmAygdWXJ7gO1OmbY93LA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JcMOvK0GuCR1EjVlOM1kdQD7PJraWeRy+FIj9Q1a+wj1dgZ5s1pCX/jUlV8fuKU7e
	 OEIZdpj2e4QGJTIZn0EyV11NX6srNUs3cSspr5gP/gwFiW92qMLgvJRQH/pe09ivkC
	 NdhegKD+eJp9AqfFlUJTZNcgwmC7itEZKJiLSsliODVKqHAsn3g0nrONP90KQHdnyK
	 MJUK22sLkQAfbZsvQCHuJr97pznF7uICzxz/gcms+q6vRQyzwO/h83ZvjruiFsy5jf
	 LpJDlJLNJvelUQsN2Tnu6AkxFdBfClQeAlc++jvlaCyia2pw9jiunNMbdy5Kek+cZy
	 /afcmes6f4Rng==
Message-ID: <sashiko-outbox-172375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] KVM: VMX: Factor out wakeup list handling code
 to KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015064515.10700-6-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-6-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:00:48 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: uninitialized return value from vcpu_irq_pending due to KVM=
_X86_OP_OPTIONAL
--

commit 56cc0b2c3b271017f40149e674efc58c033886d7
Author: Sairaj Kodilkar <sarunkod@amd.com>

KVM: VMX: Factor out wakeup list handling code to KVM

This commit moves the per-pCPU list of blocked vCPUs and the wakeup
handler from VMX to common KVM x86 code to support AMD. It introduces
a new optional vcpu_irq_pending callback so Intel and AMD can
determine if a queued vCPU has a notification pending.

> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kv=
m-x86-ops.h
> index e213c9ae3e301..5d337f9336c5d 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -30,6 +30,7 @@ KVM_X86_OP(vcpu_reset)
>  KVM_X86_OP(prepare_switch_to_guest)
>  KVM_X86_OP(vcpu_load)
>  KVM_X86_OP(vcpu_put)
> +KVM_X86_OP_OPTIONAL(vcpu_irq_pending)

[Severity: Medium]
Since vcpu_irq_pending() returns a boolean, should this be declared with
KVM_X86_OP_OPTIONAL_RET0 instead?

For optional KVM operations, if the active vendor module does not implement
the callback, KVM patches the static call site to a dummy trampoline. Becau=
se
KVM_X86_OP_OPTIONAL is used here, the trampoline does not clear the return
register.

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index aad065d035fbb..0c637a18bcfa4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -2688,6 +2709,79 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)

[ ... ]

> +/*
> + * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
> + */
> +static void kvm_pi_wakeup_handler(void)
> +{
> +	int cpu =3D smp_processor_id();
> +	struct list_head *wakeup_list =3D &per_cpu(wakeup_vcpus_on_cpu, cpu);
> +	raw_spinlock_t *spinlock =3D &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
> +	struct kvm_vcpu *vcpu;
> +
> +	raw_spin_lock(spinlock);
> +	list_for_each_entry(vcpu, wakeup_list, pi_wakeup_list) {
> +		if (kvm_x86_call(vcpu_irq_pending)(vcpu))

[Severity: Medium]
Could this evaluate uninitialized garbage if the vendor omits the callback?

Because KVM_X86_OP_OPTIONAL does not clear the return register, this check
will read whatever was left in the register. This could lead to unpredictab=
le
behavior, such as spurious vCPU wakeups or missed wakeups on platforms
lacking the implementation.

> +			kvm_vcpu_wake_up(vcpu);
> +	}
> +	raw_spin_unlock(spinlock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015064515.1070=
0-1-sarunkod@amd.com?part=3D5
