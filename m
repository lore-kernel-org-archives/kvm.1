Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3544B663
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981288; cv=none; b=Kh3wcAmiAEuu7Gvb1UplFWCet19Ne4YV/sYbQDdZ6sM9XQA7EdvdXn8jWKGObyVyNjmulxco/OQ6TWdFrp/GHP7H8ZhWGhF0LrRHNmh83deh+dOrCC4AsZHWo8VxY4/0/Qg00PYI1xssvdjHG+QI1aGT/o5WJYaxQMzc6VJm1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981288; c=relaxed/simple;
	bh=HOvbfkYEBubZmB+9AFhEihDy3yakfIIhtUmaI32aMpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c1RQZRmXxAS5yezn8T8aJN7U1nlU9RVqhlLkl8OR4mw4A5K83X2TqO/ojQWoDo/kPCGDh0Sv3Wn79i0jiH4CUt4GUYnhJ6dewHGcaZoRZ/GpO+2G6TtkEHwxulw+6NuA9b6UC+pAqJr7A2NUnoRi/+yxaEH3KYbdljGQT59vcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyWNYQuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyWNYQuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0151F000E9;
	Thu, 28 May 2026 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981282;
	bh=cOwC/2RnZCqpmv60aerJJC1YNaAe4SO6ijSdfpUoqpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyWNYQuFbNqt5PiGbB0X8noNjMlGXUz7CHIz4XnvNhTSpo/cMAxTknAhBAQXjMgFZ
	 e8/zniQ4c1e8iJqxMRA6q96jBBVXdjxpM5DsczTroc5OFSEh3QtriiZabpdL5U70/w
	 ppAAkeJwiyI3pLRbt3wVT+wqVe3U0fo8acihP6fzuKeZIqeCsqV84LiS9jpuW/CGIA
	 0qrUHj2fpd1AydYqQXlVhd2sx4HnM9PxeB/TFb6AjL+WoAaD/8tfCacC8bsScOGyLO
	 FBDGCPKPtOgVvI4xDuHdjDNVW07yMkL+czLh7Y5rWQmpKqQJcdHKlgEo27bWEzjRhX
	 Ji4KGSnFIGEpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] KVM/x86: Return -errno instead of "1" for SVM
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528111357.264809-6-jgross@suse.com>
References: <20260528111357.264809-6-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 15:14:41 +0000
Message-Id: <20260528151442.4E0151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning `-EINVAL` instead of `1` from KVM MSR emulation handlers=
 causes the `KVM_RUN` ioctl to abort with an error, allowing a malicious gu=
est to crash the VM.
--

commit 3c24eb40043531539adbce28beb46f96bd3b2db7
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for SVM related MSR emulation

This commit changes the return value of SVM-related MSR emulation functions
from 1 to negative errno values such as -EINVAL.

> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 7aa298eeb0721..1c325d602baa4 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -144,7 +144,7 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, str=
uct msr_data *msr_info)
>  		return 0;
>  	}
> =20
> -	return 1;
> +	return -EINVAL;

[Severity: High]
Could this regression allow a guest to crash the VM?

In KVM's x86 MSR emulation framework, returning a positive integer like 1
from MSR getters and setters conventionally indicates a guest-visible fault
that should be handled by injecting a General Protection Fault into the gue=
st.

Returning a negative value like -EINVAL signals a fatal host-side emulation
error.

For example, if the underlying MSR write function returns a negative value
during __kvm_emulate_wrmsr(), it will bypass exception injection:
    if (r < 0) return r;

This propagates the negative error code up through the VM exit handler chain
and terminates the KVM_RUN ioctl loop.

By returning -EINVAL for guest-induced invalid MSR accesses, could an
unprivileged guest intentionally crash the VM instead of receiving a
catchable fault?

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e02a38da5296e..f8d9df822ab34 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -2907,7 +2907,7 @@ static int svm_complete_emulated_msr(struct kvm_vcp=
u *vcpu, int err)
>  		return kvm_complete_insn_gp(vcpu, err);
> =20
>  	svm_vmgexit_inject_exception(svm, X86_TRAP_GP);
> -	return 1;
> +	return -EINVAL;

[Severity: High]
Does returning -EINVAL here cause a regression for SEV-ES guests handling
MSR access faults?

Because this function serves as the complete_emulated_msr callback, returni=
ng
-EINVAL might guarantee that any MSR access fault triggered by an SEV-ES
guest will crash the VM instead of allowing the guest to handle the injected
exception.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528111357.2648=
09-1-jgross@suse.com?part=3D5
