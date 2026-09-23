Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A455408C
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182431; cv=none; b=e1ostE85x3LxBDIxUwQNvJy8ai7FhVihjokeWZPOjcAnGAeMR1Gdz1rQmUT0b8cmNlgS2rZJQPnziF9RlSRG/WjQjLChzfchOUkg8pB+a09cejVRcdMzx77m51wrjGfuL/mZnJzBObRt+ohBvvH69wZOXArL0OLKTKDAr8Cq0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182431; c=relaxed/simple;
	bh=NV+QiVZDYUgsZIju9thP3oAYtiVsfOM7qQ0Za3wGzbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NCnnzEn9fzRm2asRwfn5fGNBK7mnn+taqeYJp+gV4zlu30wyaCDFNdQz57rwipyfIaGk6JlTgnloeXrsAB9qsb0NjHinUFctp6xqNo3dYXZ6n8okxnYMGnkjNEdOm6gOv1L2AVYsrfUZD+5dH2Js7xdt2T0Sbvuqnc++vXOGaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLWkDN7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLWkDN7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAF01F000FF;
	Wed, 23 Sep 2026 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182430;
	bh=tMpK0+Z+Or634gRRo0MmjLXBH4XcKPXl9e+yYgSkhA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLWkDN7t9hmk+UEzq7n05M0U0GtzZkA263Nr2rtMSPtfVCQijW2ByVofOa7B10Xef
	 0M8DRxyrJcuxoVF3fKwn5654yokg4ZpNPFD6jdyPQ11Fq4r36+hWbR5HNpbBMQrAS0
	 d8PhQRU81vJ/9T1cark55Gbb3IRNaymoi6EQOh0rzhiumoIqovYCuQ1GAmcE9sx+5a
	 4tPW5up0BL/qIFQcqsqSta+POutpyBc2HZ1hub+ZhyI8OxCrb8cNe9hX7vIxFZ9jRm
	 8sSL4Zemd9L+LzwakmNTeVKRX/iqiHsBQzprNlj4OkwNfzMP8zHs9ydvRoSvvS+8no
	 SWn1EDIKKaFfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: SEV: Free have_run_cpus during VM destruction
 even if VM is no longer SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260923163721.1584779-2-seanjc@google.com>
References: <20260923163721.1584779-1-seanjc@google.com>
 <20260923163721.1584779-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:53:49 +0000
Message-Id: <20260923165349.CAAF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: double free of sev->have_run_cpus on initialization failu=
re
--

commit 35fcc7370ece167eff16a7738a6c47e4815c1ae4
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Free have_run_cpus during VM destruction even if VM is no longer =
SEV

Unconditionally free SEV's "have run CPUs" cpumask in the VM destroy path,
i.e. even for what appear to be non-SEV VMs, as an SEV VM becomes a non-SEV
VM if its state is intra-host migrated.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 63e8cfa9bf559..c9242c936a401 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2981,13 +2981,17 @@ void sev_vm_destroy(struct kvm *kvm)
>  	struct list_head *head =3D &sev->regions_list;
>  	struct list_head *pos, *q;
> =20
> +	/*
> +	 * Free the mask even if the VM is not *currently* an SEV VM, as it may
> +	 * have been an SEV VM prior to intra-host migration.
> +	 */
> +	free_cpumask_var(sev->have_run_cpus);

[Severity: Critical]
Can this cause a double free of sev->have_run_cpus?

If a user issues a KVM_SEV_INIT ioctl and __sev_guest_init() fails after
allocating the cpumask, the error path in __sev_guest_init() frees the
mask but leaves the pointer intact:

arch/x86/kvm/svm/sev.c:__sev_guest_init() {
    ...
e_free:
	free_cpumask_var(sev->have_run_cpus);
    ...
}

Because free_cpumask_var() receives the mask by value, the pointer remains
dangling. When the user later closes the VM file descriptor,
kvm_destroy_vm() calls sev_vm_destroy().

Prior to this patch, the early return on !sev_guest(kvm) prevented the seco=
nd
free. By moving free_cpumask_var() before the !sev_guest(kvm) check, won't
we unconditionally double free the dangling pointer?

> +
>  	if (!sev_guest(kvm))
>  		return;
> =20
>  	WARN_ON(!list_empty(&sev->mirror_vms));
> =20
> -	free_cpumask_var(sev->have_run_cpus);
> -
>  	/*
>  	 * If this is a mirror VM, remove it from the owner's list of a mirrors
>  	 * and skip ASID cleanup (the ASID is tied to the lifetime of the owner=
).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163721.1584=
779-1-seanjc@google.com?part=3D1
