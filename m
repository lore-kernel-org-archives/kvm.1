Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107EA279DCA
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700332; cv=none; b=XMf+CJDg9DrQGGsTnshYH/72w3KiMUpXDjGVKccVGz6mIfNMXYSAgcjEcNo+iDCJ0yo5q9VSzUbZ3t1/NBjUkAlNGbpmtTeuoB3y2o9ia8k+lVdfl0iQlEShDd7k8DSi15/vWsmp4PRRLnWqaZf3o/iFRjkbT2MeEmOpnyW7x/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700332; c=relaxed/simple;
	bh=hh6n7UFBPPgd/d8JB2iGkqVCZj53sfLCKd+u7dwvt2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/ODesermq0jWYmEXm6/cnugn4xsZjzahn0iZ//pw9f9zf8zUaDsrk5pGvP6Syq9z4iudsgNQhWV6+hJsxXd2y/ieImK3h0J8qeR1SLcqCZOUd77grdTkKXIJgWfiRj05W3a1hukounSgpgGkR8fJk5VGsG8VsUywQpIpQiS0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obw3lWGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obw3lWGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756551F000E9;
	Wed, 22 Jul 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784700330;
	bh=diX8/xoMTgQJiOqVfiLG5YiVVRHnf1oi9gk7qgXNe70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Obw3lWGTCCa1Q4+rmkWxPS30PJSuhfedops3ZdFdU6sgAErxR5BeJFrN9AlnjExDC
	 d7uUTy6CJLry0zDPogUu9a2gNiXmMLDoidIVJ3nBBMWrc2XK2QUyDfRLDyMj4RLgI+
	 fLwZI/AlHnaUA6i6EHRpIzRU5ECUKV2rGyEIBVoysNlT3dmXRUuj0apu6q931ierRH
	 4fOKECpDP0ilaK609aQzDKnvs1MUix4du5IpTLwy/B0aF4VoLktPD783sBY32LEKXu
	 9YMvtVklbGaBkdNOzy6+WDcXLk7XLOFU2Fm73FkZX71/MHuiZthTnA9ggxQjb6C0Xz
	 iobJWxlacRI1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] KVM: RISC-V: Add CPU PM notifier for
 non-retention idle states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260721-kvm-cpu-pm-v4-2-146bf942547d@sifive.com>
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
 <20260721-kvm-cpu-pm-v4-2-146bf942547d@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:05:30 +0000
Message-Id: <20260722060530.756551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The CPU PM notifier unconditionally enables and modifies hyperviso=
r CSRs on CPU idle exit, even if KVM hardware virtualization is actively di=
sabled on that CPU.
--

--- Patch [2]: [PATCH v4 2/2] KVM: RISC-V: Add CPU PM notifier for non-rete=
ntion idle states ---
commit 83431725c3b11b5900d8a08aafc1ec74ad462c04
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: Add CPU PM notifier for non-retention idle states

This commit registers a CPU_PM notifier to restore hypervisor CSR content
during CPU non-retention idle states.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index bafb009c5ce55..4cf351f91c643 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c

[ ... ]

> @@ -587,16 +597,17 @@ void kvm_riscv_aia_enable(void)
>  	csr_write(CSR_HVIPRIO2H, 0x0);
>  #endif
> =20
> -	/* Enable per-CPU SGEI interrupt */
> -	enable_percpu_irq(hgei_parent_irq,
> -			  irq_get_trigger_type(hgei_parent_irq));
> +	if (full_cleanup)
> +		enable_percpu_irq(hgei_parent_irq,
> +				  irq_get_trigger_type(hgei_parent_irq));
>  	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
> +
>  	/* Enable IRQ filtering for overflow interrupt only if sscofpmf is pres=
ent */
>  	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
>  		csr_set(CSR_HVIEN, BIT(IRQ_PMU_OVF));
>  }

[ ... ]

> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 350e4f097d6e8..b48bbd1855c1e 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c

[ ... ]

> +static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsign=
ed long cmd, void *v)
> +{
> +	switch (cmd) {
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		kvm_riscv_csr_enable();
> +		kvm_riscv_aia_enable(false);

[Severity: High]
Does this CPU PM exit notifier execute unconditionally, calling enablement
functions regardless of whether KVM hardware virtualization is actually
enabled on the CPU?

If a VM is created and destroyed (which triggers
kvm_arch_disable_virtualization_cpu()), and then the CPU enters a
non-retention idle state, will the wake-up path re-enable these KVM CSRs?

Since kvm_riscv_aia_enable(false) unconditionally modifies hypervisor CSRs
by setting bits like IRQ_S_GEXT, could this cause KVM virtualization
features to be re-enabled unintentionally after being explicitly disabled?

> +		return NOTIFY_OK;
> +	case CPU_PM_ENTER:
> +		kvm_riscv_aia_disable(false);
> +		kvm_riscv_csr_disable();
> +		return NOTIFY_OK;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-kvm-cpu-pm=
-v4-0-146bf942547d@sifive.com?part=3D2
