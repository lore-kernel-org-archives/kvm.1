Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F101A6802
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929132; cv=none; b=syYrmoI+/KN3kSmoMrhtR7213+mqOGg/ZuJOkHAhhgZo/bRtc7gzNs+aC/y29zNfXPt8NQl29k0I5sCSg+CUsl02ZNM3sKm38ShBPZr+stLMFl97x4xDUHH5solPASP3UmUmIbzwkJS+jZeuXAMUb2EnYUylE2BMOFB/4jmGuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929132; c=relaxed/simple;
	bh=JA0BqZ04yYF8xsUUeOCflFd37NHMKqHXbwZ0H1ONiT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugAnJgqHIfGmcDT4O5vIU9tW6VebhMn9u/f1CrQsezz7AMgdcM3llm8I2lpG1CulwEoRIh9aISyQMPpqG34TponEei6d05EPKSjTsk9no6Z5PBobUqC8AW0+2eEhlUA7KKhaT6RIHd4V+H9Olot2ui3T55ss5ZSpCEWLxATSkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjKJNQTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjKJNQTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C8D1F000E9;
	Thu, 28 May 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929130;
	bh=/OWiVpc8wrGuBHVf5mokxY6vo9jyplb9Etii8cxiU4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjKJNQTI9mRqIR4uo0wgd2hhFFVR2JzXgbKoQt5DcdVWT1zvjp+9AciUnzC9YV4jQ
	 XWCAilIX6n6yhJ3FJ6wuEQ26k/htmXbdwmokHP6jndQA3P4RHx0Jpb8SD6CGbPhh7E
	 0IPfOukjg655St3Yl0L25JYYMnHGrY+pfd0bjtXSui3hCXh+Q5SrKnmjHdHZAVPwNb
	 AttFdnZDEd/TmqFj2yc76LpFGc5lJtrT0zcSxmR8N7lfdSD1Z5LvmtCwgs8hm7Hf69
	 tXszKYWBHYDQ9Ospvx881Z/SxOFw3cU7aJVMl8kK2Vn7kwsdh4LZ5zNOGc0/QVa7lm
	 Ygc101M6kzqWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/17] KVM: x86/pmu: Track mediated PMU counters with
 mode-specific enables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527234711.4175166-12-yosry@kernel.org>
References: <20260527234711.4175166-12-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:45:30 +0000
Message-Id: <20260528004530.C3C8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic modification of `pmu->global_status` in NMI context can=
 cause lost updates.
--

commit 0456def2f622ab0d0efee8781cb983557b090999
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86/pmu: Track mediated PMU counters with mode-specific enables

This commit tracks mediated PMU counters with mode-specific enables by addi=
ng
a new bitmap to the PMU state. This avoids having to constantly check if a
counter needs to be disabled for mode-specific reasons, such as Host-Only or
Guest-Only bits in EVENTSEL on SVM.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 0f3cbf9fc1ae1..32a413182a751 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -615,6 +615,8 @@ struct kvm_pmu {
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
>  	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
> =20
> +	DECLARE_BITMAP(pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);

[Severity: High]
This is a pre-existing issue, but can the non-atomic modification of
pmu->global_status in NMI context cause lost updates?

Looking at kvm_perf_overflow(), it runs in NMI context on the host when
a performance counter overflows. It calls __kvm_perf_overflow(), which
uses the non-atomic __set_bit() and __test_and_set_bit() to update
pmu->global_status.

Concurrently, the vCPU thread modifies pmu->global_status during MSR
emulation (e.g., handling MSR_CORE_PERF_GLOBAL_OVF_CTRL or
MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR) using non-atomic read-modify-write
operations like pmu->global_status &=3D ~data.

If an NMI fires between the vCPU thread's load and store of global_status:

vCPU thread:
    u64 status =3D pmu->global_status;

NMI fires here:
    __kvm_perf_overflow()
        __set_bit(..., (unsigned long *)&pmu->global_status);

vCPU thread resumes:
    pmu->global_status =3D status & ~data;

Will the vCPU thread completely overwrite the NMI's update? Does this cause
KVM to silently drop performance counter overflows, leading to lost PMIs
in the guest?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527234711.4175=
166-1-yosry@kernel.org?part=3D11
