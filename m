Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F17370AFB
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207152; cv=none; b=b7RaHJF/KXyhghsB3zBndmBPJoftom/RXLCtCviz0jn5645AXLHwS/iKvGddadqHBtiFL0SQ6eDn+efCjWxCP538w3Bdm2e0W2ZytCRGvkp9ecoptE6ulpLHTIqOQHZYStGL8ofbSSR9NuOfiCwZJAnqG2YbOn/7KuXtEnGWhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207152; c=relaxed/simple;
	bh=+wxlvSMAbdrFyG+OgYuFlEQYzekN4jdJj778rHb/V4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDv+HR5VLV9C/IpZJbFQf2R+cJ773G0ar+Nsn1F5Kt4eYbpmOGFnaRhJfIe1C8llpva1GYt6Zw6OFajDsLGUi1EG9EWlE4i6CqMldde1K8vNtG6EWEIwZ9Est/UJGQdSngAILGxiUwfO8CvmGpw8UoF9SSMYVj7cwWvOjkC/lA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6u/uPtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6u/uPtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C863F1F000E9;
	Tue, 23 Jun 2026 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207150;
	bh=HalZF/JSA4thuvnnAew5owk2j3alNVIOAoSLIt9VPiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6u/uPtkVIUxTPEAF5+yLSLGaR1JqcJJ7GAChleT9N6UUrwSKi/UIMZjM64tuVWnN
	 4Fu68Jr1KMfukpIJLIZzQVKP0HQi8MSqd51iDdJOutXSp7DJhh0vPh1POgoYBAXalp
	 +5YfsPyIMjGCuw8Zg5SsO/y+9oHlLBEDB3Vh8mthpfueAXzd6Y27cmUkNMgJhrdNAT
	 sLv1A1l4qx7TeVaZFlbXVSqcg4VkigHssztEv2S4oa7WdNr3Resu7Vnpe/gDNzb75I
	 K0OQFaDKUA1eNwa8M+XJMSuWt1XNk0LZQAJqn6iIKbTbmfUHKZ0UKCVUsANyaKJaYJ
	 aQl3VoXTLopLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] kvm: sev: Fix user-space triggerable WARN_ON on
 snp_launch_update path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623091556.1500930-2-joro@8bytes.org>
References: <20260623091556.1500930-1-joro@8bytes.org>
 <20260623091556.1500930-2-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:32:30 +0000
Message-Id: <20260623093230.C863F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `snp_launch_update` unconditionally returns `-EIO` when `kvm_gmem_=
populate` fails, discarding critical error codes like `-EINTR`, `-EFAULT`, =
and `-ENOMEM`.
- [High] `sev_gmem_post_populate` unmaps `kmap_local` pointers in the wrong=
 order in the CPUID firmware error handling block.
--

commit 9048d7bc73d4ef4c2ccbf4550c4b2feff1f1822d
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: sev: Fix user-space triggerable WARN_ON on snp_launch_update path

This commit avoids a WARN_ON_ONCE in the snp_launch_update() path by explic=
itly
checking if a user-space process passed a NULL source address when the page
type is not KVM_SEV_SNP_PAGE_TYPE_ZERO.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e296..41dcba5180cad 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2438,6 +2438,13 @@ static int snp_launch_update(struct kvm *kvm, stru=
ct kvm_sev_cmd *argp)
>  	if (!PAGE_ALIGNED(src))
>  		return -EINVAL;
> =20
> +	/*
> +	 * Make sure user-mode did not pass NULL as src with
> +	 * type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO.
> +	 */
> +	if (src =3D=3D NULL && params.type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)
> +		return -EINVAL;
> +
>  	npages =3D params.len / PAGE_SIZE;

[Severity: High]
This is a pre-existing issue, but does snp_launch_update() unconditionally
return -EIO when kvm_gmem_populate() fails?

arch/x86/kvm/svm/sev.c:snp_launch_update() {
...
	count =3D kvm_gmem_populate(kvm, params.gfn_start, src, npages, write,
				  sev_gmem_post_populate, &sev_populate_args);
	if (count < 0) {
		argp->error =3D sev_populate_args.fw_error;
		pr_debug("%s: kvm_gmem_populate failed, ret %ld (fw_error %d)\n",
			 __func__, count, argp->error);
		return -EIO;
	}
...
}

Returning -EIO unconditionally here discards important error codes like
-EINTR, -EFAULT, and -ENOMEM from kvm_gmem_populate().

A userspace process could receive a signal (e.g. SIGALRM) during the ioctl
execution, causing kvm_gmem_populate() to return -EINTR, which gets
overwritten with -EIO.

This breaks standard Linux signal restart semantics and could cause VM
creation to fail under signal pressure.

[Severity: High]
This is also a pre-existing issue, but are the kmap_local pointers unmapped
in the wrong order in sev_gmem_post_populate()?

arch/x86/kvm/svm/sev.c:sev_gmem_post_populate() {
...
	if (ret && !snp_page_reclaim(kvm, pfn) &&
	    sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID &&
	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM) {
		void *src_vaddr =3D kmap_local_page(src_page);
		void *dst_vaddr =3D kmap_local_pfn(pfn);

		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);

		kunmap_local(src_vaddr);
		kunmap_local(dst_vaddr);
	}
...
}

kunmap_local() requires pointers to be unmapped in strictly reverse LIFO
order.

Here, src_vaddr is mapped first, then dst_vaddr, but src_vaddr is also
unmapped first.

This violates the API requirement and can trigger kernel panics via BUG_ON()
when CONFIG_DEBUG_KMAP_LOCAL is enabled.

While an earlier patch in this series ('kvm: sev: Unmap pages in correct
order in sev_gmem_post_populate()') fixed this in the first error block of
the function, it looks like this second error block was missed.

This can be triggered by a userspace VMM passing invalid CPUID data to
KVM_SEV_SNP_LAUNCH_UPDATE, causing firmware to reject the page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091556.1500=
930-1-joro@8bytes.org?part=3D1
