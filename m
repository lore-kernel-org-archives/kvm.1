Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174ED233704
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782360713; cv=none; b=ap/q6bvYuUJA04mADcDEcr6lO9BDzYyGD4ogjIThO2Xocnpn9UKjsWqolUEb+p52k/Ir74KMAtXFIknvUoK3jqEN0dDIlB8k/G9I+So39mK2aSleJY/thdCGexPIeAdD+vyO7gz3y1aj108pyMzbDZoH8n/rP+fbgfxfVB81cTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782360713; c=relaxed/simple;
	bh=LGcoVmjxmdHngZDWUJ9oXMx6pbNMvNUCvKq7jo2Ph1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJdQPAUooHE0+0qEi+QnQNKcmBc22RygZjS6fDYo4ffArLL2X/yj0S3eHXRILwQBkZRCzBcqLcPHfFt/2GOaXtnQtm8u/TqL+JEFHuuKMTDlFNl3dvUixDZOslVzxNIfmmiTGeW3Sz9i5H/iuv9iDOUaRX13KoNVt0GDfhLamKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H20lYr5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H20lYr5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C4C1F000E9;
	Thu, 25 Jun 2026 04:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782360711;
	bh=jfyLqctjqWPqHkjz99TByO226DTOjhHzqQIa8KtgkEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H20lYr5KT3tYzg9gyiqzyXSpcNOx3Nfwn6zXJhSWn7Ho15MD1a1sF5H4bj8NynddV
	 HeZnCB80k72/saXmj6Jvu0suA2JUhBewMbLXa48ze1s444w8dBOcGqwuTu10sErVvP
	 /UeNPZnyyRfeO0Ax4YTli3uy3wrdwfFUHwV29TMYsXsRP981jw308xb8sNKp1n3FW6
	 T82xUVKPvMF8fswvwXDoVHEoYP6fBxCYoulhu9j6LRh0ETAbHMgs61VrXLqEOakmAJ
	 b2+/rxLHkLwJaBmvRvuDNtFnJpDU6SL+ZBPtagrtukulbvmY/A0uY2Uuny6OYvNtI7
	 P7petqkgAH7gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 6/7] KVM: x86/pmu: Emulate RDPMC on performance
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625034555.141453-7-zide.chen@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
 <20260625034555.141453-7-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 04:11:50 +0000
Message-Id: <20260625041151.70C4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bitwise AND check `idx & INTEL_PMC_FIXED_RDPMC_METRICS` inco=
rrectly matches any ECX value with bit 29 set, causing KVM to bypass archit=
ectural #GP constraints and ignore unsupported modes like Metrics Clear Mod=
e.
--

commit fab478b9c41c710e48463a5a45a9ebb508f99e32
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Emulate RDPMC on performance metrics

If the host has the PERF_METRICS capability but it's not present on the
guest, RDPMC interception must be enabled and KVM should inject an #GP.
If the guest has PERF_METRICS, KVM emulates RDPMC with type 2000H.

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -755,6 +755,16 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcp=
u, unsigned idx, u64 *data)
>  	return 0;
>  }
> =20
> +static int kvm_pmu_rdpmc_metrics(struct kvm_vcpu *vcpu,
> +				 unsigned idx, u64 *data)
> +{
> +	if (!kvm_vcpu_has_perf_metrics(vcpu))
> +		return 1;
> +
> +	*data =3D vcpu_to_pmu(vcpu)->perf_metrics;
> +	return 0;
> +}
> +

[Severity: Medium]
The commit message mentions that Metrics Clear Mode is not supported.
However, since kvm_pmu_rdpmc_metrics() ignores the idx parameter entirely,
will KVM return success and provide metrics instead of injecting a #GP if a
guest passes an unsupported index variant like Metrics Clear Mode
(0x20000001)?

[ ... ]

>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  {
[ ... ]
>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
>  	    (kvm_x86_call(get_cpl)(vcpu) !=3D 0) &&
>  	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
>  		return 1;
> =20
> +	if (idx & INTEL_PMC_FIXED_RDPMC_METRICS)
> +		return kvm_pmu_rdpmc_metrics(vcpu, idx, data);
> +

[Severity: Medium]
Does this bitwise AND check incorrectly match any ECX value with the metrics
bit set?

If a guest provides an invalid index like 0x60000000 (which has both the fi=
xed
PMC and metrics bits set), it appears this check will evaluate to true. Will
this bypass the downstream #GP logic for invalid indices and allow the guest
to succeed incorrectly?

> +	pmc =3D kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
> +	if (!pmc)
> +		return 1;
> +
>  	*data =3D pmc_read_counter(pmc) & mask;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625034555.1414=
53-1-zide.chen@intel.com?part=3D6
