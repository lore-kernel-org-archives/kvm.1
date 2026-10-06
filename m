Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8B3EC69C
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306521; cv=none; b=crYuVRN2aKN9yzG9sxpb5pQmSvdQPdgpQ2DFMM90rd6Pt3YSH5HCFNFrm/X2seqTZasCBpzggi/x0LZJeZCr6Y068REmwGNJmv0w2cU+wNjUK1BpZh6TVCcxCh9Koa2H4a73t0yXf03f71QVcZ6nDeF5sYku+JjBiXaLhY6FUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306521; c=relaxed/simple;
	bh=MDCuudnSQp+RpeMh6j6hq8K5SNrLywHgIG2BYYNmrWY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r5uiZE5/PFA5KuIlqi6fRJ/zQ3vwvyq+omuOTAsZI9xHI3wJAC30pA83lEhy37yTrVwYhdA1UfFSg2hPMbTIQKIHkGdR/R9Z1GfTWVmpkj2YjI9m8iClP+1iwawxVcOOv/mOZQva+apjetaHnCErbZBr1Et6jT74Kv5+7y3EnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/yeU1IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/yeU1IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2241F0089B;
	Tue,  6 Oct 2026 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791306520;
	bh=Z/YPgm8XdfXxu0Tra/ZIQkYxCvf37/Iscqz4T4hieJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/yeU1IRi2gxaba/OxXtRDW4w50OVG8EdoF9UOKGEX1premMgbtXweWXjzHai8ujH
	 OFH4wJlFpfUwK3T7EeDYWkv5MlByMk4ESXt01S8Tbl6hhiUDOJWkDm0uttMmLjLxUr
	 51jWBd32QRXJfeIHwkB4gwwcZfWTspFKv26KgxdCFDsjXcZ2nOkvCckWilxkIrrd8q
	 2drBHPz4LH/gt8XuEGa0owU+e5+/qdkKKf9uKhknkIESrdewX88LcypKkCGzlwdvQi
	 g2yTkLnqEtcTnwwBl/lg2iZRg9KnO6+IEUDXsrBjwhhP+EX/VNI1Oy7hY4XGJMfHhA
	 iXXJMBc6VC6Ew==
Message-ID: <sashiko-outbox-162293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 2/4] KVM: SVM: Add host support for Enhanced SMT
 Protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <64ea6ba62315d33b7bfb48ec6cab29ac4ee2fa06.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
 <64ea6ba62315d33b7bfb48ec6cab29ac4ee2fa06.1791302373.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:08:39 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: svm: host #DE panic when esmtp_timeout_ns is excessively large
--

commit ec4daa3c1cc021f9f7a5cc29bfa1c4493cc845b8
Author: Pratik R. Sampat <prsampat@amd.com>
Subject: KVM: SVM: Add host support for Enhanced SMT Protection

Enhanced SMT Protection (ESMTP) protects SEV-SNP guests from SMT side
channels by stalling VMRUN until sibling threads are idle or running legal
sibling vCPUs. This commit introduces the hardware enforcement logic,
non-fatal exit handling, and a configurable timeout parameter.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 944aaea6501f2..24701f06fce81 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -67,6 +67,11 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 044=
4);
>  static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
>  module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, =
uint, 0444);
> =20
> +static unsigned long esmtp_timeout_ns;
> +module_param(esmtp_timeout_ns, ulong, 0644);
> +MODULE_PARM_DESC(esmtp_timeout_ns,
> +		 "ESMTP VMRUN sibling-wait timeout in nanoseconds (0 disables the time=
r)");
> +
[ ... ]
> @@ -4708,6 +4750,10 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm,=
 bool init_event)
>  		svm->vmcb->control.allowed_sev_features =3D sev->vmsa_features |
>  							  VMCB_ALLOWED_SEV_FEATURES_VALID;
> =20
> +	if (sev->vmsa_features & SVM_SEV_FEAT_ESMTP)
> +		svm->vmcb->control.esmtp_timeout =3D mul_u64_u32_div(esmtp_timeout_ns,
> +								   tsc_khz, 1000000);

[Severity: High]
Since esmtp_timeout_ns is writable by root (0644) without bounds validation,
could a very large value here trigger a host kernel panic?

The mul_u64_u32_div() function relies on the x86 divq instruction. If the
resulting 128-by-64 bit division quotient does not fit in 64 bits (for
example, if esmtp_timeout_ns is set near ULONG_MAX), divq unconditionally
raises a #DE (Divide Error) exception. Because there is no exception table
entry for this instruction in mul_u64_add_u64_div_u64(), this leads to an
immediate panic.

Would it be safer to enforce a maximum limit on esmtp_timeout_ns to prevent=
 a
sysfs write followed by a VM start from crashing the hypervisor?

> +
>  	/* Can't intercept CR register access, HV can't modify CR registers */
>  	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
>  	svm_clr_intercept(svm, INTERCEPT_CR4_READ);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791302373.gi=
t.prsampat@amd.com?part=3D2
