Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D93D646B
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181370; cv=none; b=VoCILWPsYvbEOEKL5SrfKwL+MG5aX+Nz2G7y2FvXWE5nRbUUEWlbn9adLtZr9lhhArSazDK/53vnyg4n8yQo3nPcii4MLnHG2KRWxNh4c8gQ4HcyTwEwl8J1OnBLM4BK//AnXc/1KENTr4GaXW0QYQHAK/gLNEhnV2QSeiPvxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181370; c=relaxed/simple;
	bh=S8+vq4C7No8RdCKXtCPXGcGqwFaTIj4YDbtEl4T8ijU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IaqpVhIsFC9xdDoIXCtgMFYWCLvg37y2zeB26w+tN3gI0d6yJ0scCmNbGjC39QtgzOjM8x3nU4bz5dIEe3sOslB/V0RKwRGhZdCq7QCKemSrl0VjX/wv7SXH/t7x5Ht1Xge2OjFNGbDj0MdZZxUkks1mFgcClx1EZOWtj7xSvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn73bqLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn73bqLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159341F000E9;
	Mon, 27 Jul 2026 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181366;
	bh=FMZAKo24RCuNigb5rQXZMUr23nLPHRCHh8/ZB3FaHLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yn73bqLMxYcHlcFu+7hqgfJEp7XHLQcN3bAR+fXKPj4I4GkXi3bajVnhMf92b8QVm
	 8Py/oS5dCF37+OCFZ883po5udLXAvv/s6WpUrgJmrh7UxmG/1my/KYN/Lw//ZaX+JE
	 mJZj7ChezvpXMQQHfSjEhB7Pnjc3+ioQH5fUFlvqjMKGabltkdPDWJgUcbG0V5GN3+
	 DMW6zkdSHQdQ15Gmpuemx50uZ/JtBgXY4mzB9WanTLPkTLsJxGuS3sQA6OciWT11wz
	 YqpGILw7DyTvefX38v55RM0Cfe6RQm3Kvs2dr5Qr5EBUCs2jw/mX5UJIOSBE/Y1Of8
	 LV70LRmKBB/pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] KVM: x86/pmu: Rename and move
 vcpu_get_perf_capabilities() to pmu.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727192131.582105-4-zide.chen@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:42:45 +0000
Message-Id: <20260727194246.159341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit header inclusions after refactoring.
--

--- Patch [3]: [PATCH v7 3/9] KVM: x86/pmu: Rename and move vcpu_get_perf_c=
apabilities() to pmu.h ---
commit fb5ce8bc24fb7de4e71c57bef960ab9beca9bc0b
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h

This commit renames vcpu_get_perf_capabilities() to kvm_vcpu_get_perf_caps()
and moves it from pmu_intel.h to pmu.h to make it accessible to common x86
code.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index a5821d7c87f93..1b2f66a2e9153 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -271,6 +271,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_all=
owed(struct kvm_vcpu *vcpu)
>  				  X86_PMC_IDX_MAX);
>  }
> =20
> +static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
> +{
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> +		return 0;

[Severity: Low]
Does this file need an explicit include for cpuid.h?

Since kvm_vcpu_get_perf_caps() relies on guest_cpu_cap_has() defined in=20
cpuid.h, it seems like pmu.h should now explicitly include cpuid.h to remain
self-contained, even if it happens to compile due to implicit includes in
the compilation units.

> +
> +	return vcpu->arch.perf_capabilities;
> +}
> +

[ ... ]

> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
> index 5d9357640aa18..afdbbc9991d6d 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.h
> +++ b/arch/x86/kvm/vmx/pmu_intel.h
> @@ -6,17 +6,9 @@
> =20
>  #include "cpuid.h"
> =20
> -static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
> -{
> -	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> -		return 0;
> -
> -	return vcpu->arch.perf_capabilities;
> -}
> -
>  static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
>  {
> -	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) !=3D 0;
> +	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) !=3D 0;
>  }

[Severity: Low]
Is the include for cpuid.h at the top of this snippet still needed now that
the function relying on it has moved out of pmu_intel.h?

Also, since fw_writes_is_enabled() now calls kvm_vcpu_get_perf_caps(), would
it be better to add an explicit include for pmu.h here to ensure header
dependencies are fully self-contained?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192131.5821=
05-1-zide.chen@intel.com?part=3D3
