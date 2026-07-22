Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CC3E3DBE
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711656; cv=none; b=KOSJiGkAVyIWFjvaeM0Qy/X2DnN26MKoRf5JzgxnV+RDPSK2FwjU+/LPkk+s1ElkNp8NZFvfxn5rFcRsPP+pQSLfJxAMjl5xSihdBSyOOW+wdBBjwWsjMPzfhu8lm/mRyksf+E4uvl9KpVjFECSfqliq+VHWGe+Mv+wtb5WhLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711656; c=relaxed/simple;
	bh=DIq87MglmU+GEuI0VpKnEJpftJCQwSF7b387+9oWHi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WspoFVHSHyLSYu4RQFj0o/X3VApDrIChs99ckgT2PTf3whfE5kgKWQf48C14WX95yQn0CENfiDJzcEJw7gJhXVYB1DQHFa3QCnWdnxk3tBpk892vGEQJfYmBfrA9MX54TxyEuAAIzSrXvJ/hSEVaeUFH8ZzfvsnVsWVoA+CMAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX3BoolB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX3BoolB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E842B1F000E9;
	Wed, 22 Jul 2026 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784711655;
	bh=rSpyAXlmcoSUil5703F1zRsYh7kDHnX52Ys3NbLelbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RX3BoolB5Q5e2nwUesX5a0gB8zxwzhcMdgr7Q+4AunBr+xXyHDW/oHfzEB2LjPdVu
	 sMQuThiva1MJ96OC1wJIgGmVjOd0YBG2Pv25Za/rbRRS0ESMQo+iSMpvFMczdpe9L0
	 VodEw+1BOYzT95oIX+KlKNBvXw6PrXmC0AN+Tnqu1gUV50eDrb611IHTNsy6odZNH1
	 IjtCQHf1fYbvF6lojNnSxJmE6HsMQ52J0B/566/6lf7fACiW9CUT3MaHB/Q0RtaIya
	 UNnBI6jLlNLzHpPgWo9Rhic8XYAn90hYcebd0aV08wR2G+7JvsXm3eXzyVePukJblp
	 0124NpDSMptCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SVM: use wrmsrq_safe() when writing the nested TSC
 ratio MSR
Reply-To: sashiko-reviews@lists.linux.dev
To: amirmohammad.eftekhar@cispa.de
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722084702.1028983-2-amirmohammad.eftekhar@cispa.de>
References: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
 <20260722084702.1028983-2-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:14:14 +0000
Message-Id: <20260722091414.E842B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to write the MSR on an invalid TSC scaling ratio leaves th=
e hardware MSR unmodified, allowing the guest to run with and leak the prev=
ious tenant's TSC ratio.
--

--- Patch [1]: [PATCH] KVM: SVM: use wrmsrq_safe() when writing the nested =
TSC ratio MSR ---
commit 1572db0bc125650e334549b4e8c1388d585aa8c9
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: SVM: use wrmsrq_safe() when writing the nested TSC ratio MSR

This commit updates __svm_write_tsc_multiplier() to use wrmsrq_safe() when
writing the MSR_AMD64_TSC_RATIO. This change aims to prevent a host #GP
oops if a guest configures a composed nested TSC multiplier that exceeds the
40-bit hardware limit, falling back to a warning instead of a fault.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -467,7 +467,18 @@ static void __svm_write_tsc_multiplier(u64 multiplie=
r)
>  	if (multiplier =3D=3D __this_cpu_read(current_tsc_ratio))
>  		return;
> =20
> -	wrmsrq(MSR_AMD64_TSC_RATIO, multiplier);
> +	/*
> +	 * multiplier is derived from the guest-influenced nested TSC scaling
> +	 * ratio and can, on a composed nested value, set bits above the 40-bit
> +	 * MSR_AMD64_TSC_RATIO field.  A plain wrmsrq() would #GP in host ring 0
> +	 * (caught only by the WRMSR extable); never let a guest-influenced
> +	 * value fault the host MSR write regardless of the compose bound.
> +	 */
> +	if (wrmsrq_safe(MSR_AMD64_TSC_RATIO, multiplier)) {
> +		pr_warn_ratelimited("SVM: rejected out-of-range TSC ratio %#llx\n",
> +				    multiplier);
> +		return;
> +	}

[Severity: High]
This is a pre-existing issue, but does returning early here leave the
hardware MSR unmodified?

If wrmsrq_safe() fails, the physical MSR_AMD64_TSC_RATIO retains its
previous value from the last VCPU scheduled on that physical core. Since the
error is caught but not propagated to abort the VCPU run, the guest could
enter with the unmodified, cross-tenant MSR value.

Because kvm_calc_nested_tsc_multiplier() in arch/x86/kvm/x86.c lacks bounds
checking (as the companion patch mentioned in the commit message is missing
from this tree), a malicious L1 guest could configure a large nested TSC
multiplier that exceeds the 40-bit hardware limit:

arch/x86/kvm/x86.c:kvm_calc_nested_tsc_multiplier() {
	if (l2_multiplier !=3D kvm_caps.default_tsc_scaling_ratio)
		return mul_u64_u64_shr(l1_multiplier, l2_multiplier,
				       kvm_caps.tsc_scaling_ratio_frac_bits);

	return l1_multiplier;
}

Could this allow an L1 guest to run with and deduce the previous tenant's
TSC ratio?

>  	__this_cpu_write(current_tsc_ratio, multiplier);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084702.1028=
983-2-amirmohammad.eftekhar@cispa.de?part=3D1
