Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB434445AC6
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798048; cv=none; b=XS4rjAONYwCjWjJIHuuQ4/nmo+BaRN9DcNsqXZ7O7CAbbqp0xMq13h3JoFkVuWVwdOgaUIKVbWL02tVcPUUDoSOT83EpNJLVkVS1ZQ1oEWLjtaLq1gVMhWJnxxnJja9xIkRmXcQE/mPpK/ugU878oBYwmF7S1dN7mGMmzeyDXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798048; c=relaxed/simple;
	bh=2x9oLAPsSgigCPAtcDKkEVK9wBTsjKYSv0lHgVETnsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eeHXcpd9U+lwQReOTT6yUSq2pCYnipPSQrMebFhdvSwbxhIAG1JaR/AxcBF78OB/YhsdZeovpBL9FxvqY5RlngvGVOIM3sSEmJl+qxdYxwQPWiZYKdN0nm2WLVp6pv0qUlL0HSAVUe6dOtg8VgdpAhS3X32wE2N9OUIRT+I/fzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEmkp/Ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEmkp/Ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A811F000FF;
	Wed, 30 Sep 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798047;
	bh=mH2RN0FdWJmaJDvn12eYfzH5L+pEs5nsbnv5v5T6d04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEmkp/SsLxo5POGtACeufOUGa64JOfy4Hd9mfEEWiY0nhwJp1Te7h6gG1mWu8M22b
	 fJ0xcE5l0kt3VdNJDO83JLqfVt+6VFH6wF488D7NajIpu4v5EPDI1HW+fIu3vsqbfe
	 a1mAl9/cxaaXShmL6mypVAI6EoIMkPdZAnt4lKuDeMFXhiOjjRVX9dMoPEt7KJIDy4
	 R+0k6HwZe74dSSMp4l6gWhoVQe2SdK6t1IvI4DigqNe/LjewBNBtPciAQYgmo+DaKA
	 4L7s3VnzJ021vo4wfikMHUNjyOP0f8BvxSYiaSFfRBcufeBbBq5vmLngxGpHxjBcsJ
	 hF5VO+OXtAxYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/12] KVM: SVM: Add support for virtualizating Bus
 Lock Detect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930193634.3415089-13-seanjc@google.com>
References: <20260930193634.3415089-1-seanjc@google.com>
 <20260930193634.3415089-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:54:06 +0000
Message-Id: <20260930195407.28A811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: svm: missing host_initiated check in MSR_IA32_DEBUGCTLMSR r=
estoration
--

commit 6a801e9cb8e116e2aead8b9c8e78497f605d7a2c
Author: Ravi Bangoria <ravi.bangoria@amd.com>

KVM: SVM: Add support for virtualizating Bus Lock Detect

This commit advertises support for virtualizing Bus Lock Detect on SVM.
It allows the guest to enable BUS_LOCK_DETECT via MSR_IA32_DEBUGCTLMSR
if LBR Virtualization is enabled.

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index c3380d865b751..6d0242966dc87 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
[ ... ]
> @@ -789,7 +789,12 @@ BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
> =20
>  static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
>  {
> -	return DEBUGCTLMSR_LBR;
> +	u64 debugctl =3D DEBUGCTLMSR_LBR;
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +		debugctl |=3D DEBUGCTLMSR_BUS_LOCK_DETECT;
> +

[Severity: Medium]
Does this restrict host-initiated MSR restoration? By making the
DEBUGCTLMSR_BUS_LOCK_DETECT bit strictly dependent on guest_cpu_cap_has(),
this might reject host-initiated writes to MSR_IA32_DEBUGCTLMSR if the VMM
restores MSRs before initializing the guest CPUID.

In svm_set_msr(), the rejection happens unconditionally:

svm_set_msr()
    if (data & ~svm_get_supported_debugctl(vcpu))
        return 1;

Since svm_set_msr() does not appear to check msr->host_initiated before
enforcing this capability limit, could this regression break live
migration when userspace sends KVM_SET_MSRS before the CPUID is fully
configured?

> +	return debugctl;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930193634.3415=
089-1-seanjc@google.com?part=3D12
