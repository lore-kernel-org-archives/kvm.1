Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB823393A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979878; cv=none; b=FnUYseiGFqoK+rlR3kcOAkpvTOM73yGfzeW3jfHYMuhrTf0lHSAlXshcQBhgh6UDtKtvqMPNOXzq4Ein5aCqf3WUzaUh4bFxYroAEavlRXTktKZ3NyENWFIW+JxZOTq5+Uml9fiyiU17hBVH6rc95bVBukFEtUgmephJbIDop8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979878; c=relaxed/simple;
	bh=vKmptvpQywRNQf727CIAbUHsMUmC67nn8Xhx93zSlk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwO3qduj9jMn07OeCC5JpW41FS2QQ6kVJ2bKqOhlfakIDwmJ8ABqaDQqLXyAppEsQdnDGIInc98ojP6G1uVlLtCgo1rNy3yzhD5Nd3J3aPEfzkYbUOlgX82XQSugMhuVNq5fcjnqDhjB7z3IWKAH+eBPE+wvE9zyiKcRaxGhbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOESuGnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOESuGnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBCC1F000E9;
	Thu, 28 May 2026 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779979877;
	bh=SRbTsKN4y0/8XI6iOed7lQMvzH+d0h5i2ssjeKdcKbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOESuGnu1hWWp+wbPZeypxf+UrvUpcnCJgH8l1edpfJjf2U8WiZYfHHRnSSR8B/zQ
	 nYV7ewyECMCl/MfjDv9qbTRMPTVCwwEoG1J9qD/pQgpq2hTeNZ9AftJ3UyMxU1fW5p
	 6jOay24I7giTCG4JuzC8fk/muZCuYuhyL1ni+nD9AqtoTFWyTubIFufBjoI4nCwtmP
	 YYWsCFDZQg3/ssaI8z9JRysSxHZ0NFy3lIcy1poiYuO5hB1IUept4UVIgCaEc5Udu3
	 CeGemsZ9/q1RJ8XSBVmJpV4XFL4DKiq8deCGn5SCVwxaKdF008JQ+mABLCy8ce45T5
	 JRd7lZ+CTjgxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] KVM/x86: Return -errno instead of "1" for SVM
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-6-jgross@suse.com>
References: <20260528113605.267111-6-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:51:16 +0000
Message-Id: <20260528145116.EFBCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -EINVAL instead of 1 from KVM MSR emulation handlers bre=
aks the KVM error handling API, crashing the VM instead of gracefully injec=
ting a #GP exception into the guest.
--

commit 4acdcc8f1417c1c797f8ed84011c6082e6aae48e
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for SVM related MSR emulation

This commit replaces literal "1" return values with negative errno values in
the emulation code of SVM related MSR registers to signal an error.

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
Does returning -EINVAL instead of 1 here bypass the #GP injection logic?

KVM's x86 MSR emulation relies on a return value of 1 to signal an
architectural fault that should result in a #GP exception being injected in=
to
the guest.

By changing the return values to -EINVAL, the errors become negative. In
__kvm_emulate_wrmsr() and similar paths, there is a check for r < 0 which
immediately propagates the negative error up the call stack.

Could this cause the KVM_RUN ioctl to fail with -EINVAL, crashing the VM
instead of gracefully injecting a #GP exception when a guest OS accesses an
invalid or reserved MSR?

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
Could returning -EINVAL here cause SEV-ES guests to fatally crash upon
invalid MSR accesses instead of receiving the injected exception?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D5
