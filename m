Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB230499A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940940; cv=none; b=VW1wcFoTNVQWTvHeSwg9GaFK1Eh89/kYxH9VLGQyyBj592Yw2bhm6PJZS/QRqK4c9RRgxYMUmDYlqXc+70zJySMDsvUbFLfCPXzYVMr72K0zFB0wVXLo3mN4MI9M12vPuREGdZn4uJP6kUvx/390EFdhxV2//qJRDMlGyBGBWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940940; c=relaxed/simple;
	bh=0ICOVEjH+1nWeDNxLy4BQ6ZHqnPlt0PufSqAhq0Ii84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsnjv7KHAknrEXXls6ngW7GPwujUpF8m0dX9bHn3jF/cxiuTGAnN2O0BUgle99sZGmQDlKnvzAcVtab0yguZLDf30Zi0NSVHbiTbu059BQwhgacfwvD8wo8Y7cwnJRF1grP8yFy53RYCtS3/zFE1BNykSR6RnL6VQYHBjTxi6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZsJcp5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZsJcp5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF31F000E9;
	Mon, 13 Jul 2026 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783940939;
	bh=/ADE3k48hxt8EXc2UxbNIK2AsK4ZHv7AsMY+dwote8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZsJcp5amczTQpmNQRWw05srMUoJjC27bnJF++USP7GSYHKdrhGx+36uA7pKmQRd0
	 qj93dnN/Vp2Kcnivimx/STy8Rn3KxshQAe5qqi5pwuEB+LiRCktiRrLxUi3l6T6QGP
	 7UAjpVQmHGXUNX0IY7tLs+16ZFIxoClHJnOi5VFAEpfjTXrH7B95bI870ahEW9OE6q
	 iOW94HdCDjuPWEJvuIN9FjBZLYSddr8rSlWyzVO6ZWkg8ypPfZRGYnDjssDOHn4zUG
	 4aJi9GljHIONBLF1vjDOISZWmVV0VSfxagxqHNkzAXBPKuJSHhKifIBdrQFJIybAHr
	 0COrzbslsfoeg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU
 running state to IOMMU interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713105033.15405-4-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-4-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:08:58 +0000
Message-Id: <20260713110858.EAEF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM continues to infer the vCPU running state via `is_running =
=3D apicid >=3D 0`, completely defeating the purpose of the newly decoupled=
 IOMMU API.
--

--- Patch [3]: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU ru=
nning state to IOMMU interface ---
commit bbb2175fc26e0d5c105e610aeee4bcf1fe796a2d
Author: Sairaj Kodilkar <sarunkod@amd.com>
iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface

This commit adds an explicit is_running parameter to the AMD IOMMU guest
mode interface. It states that this decoupling is necessary for GAPPI to
pass a valid destination apicid when a vCPU is not running. The change
intends to allow KVM to pass the vCPU running state explicitly rather than
inferring it from the apicid value.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 8e87a7f2f64f7..3b2d92a587098 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
[ ... ]
> @@ -1008,6 +1010,7 @@ static void avic_update_iommu_vcpu_affinity(struct =
kvm_vcpu *vcpu, int apicid,
>  					    enum avic_vcpu_action action)
>  {
>  	bool wakeup_intr =3D (action & AVIC_START_BLOCKING);
> +	bool is_running =3D apicid >=3D 0;

[Severity: Medium]
Does this assignment defeat the purpose of the API decoupling described
in the commit message?

The commit message states that KVM must supply a valid apicid even when
the vCPU is not running, and that we can no longer derive the vCPU running
state from the apicid alone.

However, by defining is_running as apicid >=3D 0 here in
avic_update_iommu_vcpu_affinity(), aren't we continuing to infer the
running state directly from the apicid?=20

If a caller attempts to pass a valid GAPPI destination APIC ID for a
scheduled-out vCPU, won't this helper erroneously force is_running to true?
Because of this hardcoded logic, other KVM paths handling scheduled-out
vCPUs would be forced to continue passing -1 for the APIC ID rather than
a valid GAPPI destination.

>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	struct kvm_kernel_irqfd *irqfd;
> =20
[ ... ]
> @@ -1024,9 +1027,10 @@ static void avic_update_iommu_vcpu_affinity(struct=
 kvm_vcpu *vcpu, int apicid,
>  		void *data =3D irqfd->irq_bypass_data;
> =20
>  		if (!(action & AVIC_TOGGLE_ON_OFF))
> -			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
> -		else if (apicid >=3D 0)
> -			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr)=
);
> +			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_runnin=
g));
> +		else if (is_running)
> +			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr,
> +								   is_running));
>  		else
>  			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713105033.1540=
5-1-sarunkod@amd.com?part=3D3
