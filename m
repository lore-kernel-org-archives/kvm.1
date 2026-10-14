Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2A490C14
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013175; cv=none; b=VW43NJWeWGOIeAZILrY0ZWagmEgZka1L2bl/Ct6B2AoudjJYjD1f9qQuy9+kDpZZKi6ZzF+NLSStABXYDkYa2cf4Q0hR8p1ReTM3UwSBnddLtaTXoFAytI8cvPhY4WQ3+hbvLTLUhVEXbYCIWEgfxJmwQvo21+HBEpwMwoXGuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013175; c=relaxed/simple;
	bh=LgCJlkvpyKOaNmeDVh7S1nzobjg4pSxn+flIWYVnDZI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MxW6Vy8myq9UggLD1X445pXB0ecGgpBFzHusFy4QIaRS4g4Cgic5pYL1JjWO2qqDgNDPVS/Cgn0rrbEaBvAn3XVzSzaMk0i8AmrceC2p0E3oON/xMVWnQlNqNc689x8DTab2kWcPzl6LtXcXq7Gx+XRtGhFZtDVrgO4q1QNWoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcqoXyoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcqoXyoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4EE1F000C4;
	Wed, 14 Oct 2026 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792013173;
	bh=NJvzMJ0O8GkdRTEkyOF9BCfhPMykYqCtmBxVCq+Dt7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcqoXyoMi7BC3DduEZPBz9Y1ZQiIg2vbIzbvR3OQwoMYlzU2R0usOUhshnwn+EGDE
	 47UJAAbe2Qv1vDxkiv6ZE/yBoCvUfCiRcB6d5Cx5JuH/bl7LsxK5XFKLQJoA7EMgD6
	 yBCaspJZz1qX75TtnYIMcnzJg6pEM1NEgRHyTXQptN7CqPCXQVdLfFRahJHULJf1wZ
	 UoxOPh0D19h2FLVqFNIakBCTjWRF7N3gbIh1UrQB/3z8y1vyZE5e6I1YWRHvkG7i3c
	 rvHUM1bi+JUahj4OmNoIGwUPxGvzIaVmz3aZNFB4b1BXPV959YX/5JYCjbLuWl7299
	 54eTRp0RC5/zg==
Message-ID: <sashiko-outbox-171925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] x86/sev: Only announce RMPOPT optimizations when
 SNP is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <5fbbf065e912fc011ec0f043db90f530b55c4517.1792011434.git.ashish.kalra@amd.com>
References: <cover.1792011434.git.ashish.kalra@amd.com>
 <5fbbf065e912fc011ec0f043db90f530b55c4517.1792011434.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 21:26:13 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] x86/sev: rmpopt_init checks CPU feature instead of CC_ATTR_HOST_=
SEV_SNP
--

commit 4dd9ce9c71a0a62c99cac5b242adafc6f676a4ec
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Only announce RMPOPT optimizations when SNP is enabled

This commit updates rmpopt_init() to check for X86_FEATURE_SEV_SNP in
addition to X86_FEATURE_RMPOPT. The intent is to avoid allocating the RMPOPT
workqueue and printing the enablement message when the host is not an SNP h=
ost.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 43e4945e6cdf1..81b9efd55c511 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -639,7 +639,8 @@ static void do_rmpopt_work(struct work_struct *work)
> =20
>  static int __init rmpopt_init(void)
>  {
> -	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
> +	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP) ||
> +	    !cpu_feature_enabled(X86_FEATURE_RMPOPT))

[Severity: Medium]
Will this reliably detect if SNP is disabled during IOMMU initialization?

If AMD IOMMU initialization fails to enable SNP (e.g., RMP initialization
fails or IOMMU is missing), it dynamically clears CC_ATTR_HOST_SEV_SNP but
leaves X86_FEATURE_SEV_SNP enabled:

drivers/iommu/amd/init.c:iommu_go_to_state() {
    ...
		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
    ...
}

Since rmpopt_init() runs as a device_initcall, it executes after IOMMU
initialization (which runs as a rootfs_initcall). By checking the CPU
feature instead of the software CC_ATTR flag, it seems it will erroneously
allocate the rmpopt_wq workqueue and print a misleading
'RMPOPT optimizations enabled' message on a non-SNP host, leaking an unused
workqueue on a cold path.

Should this check use cc_platform_has(CC_ATTR_HOST_SEV_SNP) instead?

>  		return -ENODEV;
> =20
>  	rmpopt_wq =3D alloc_workqueue("rmpopt_wq", WQ_PERCPU, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792011434.gi=
t.ashish.kalra@amd.com?part=3D2
