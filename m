Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44F3B583C
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554011; cv=none; b=iMoZdXRGnrfWSsGa5Je1uiSbtLwKZxqoVwhra2r997brNICxW/+t3p/lMXJjPrdaIfgwFjwec52qJJCBHztjJuFIqjAB4cKUfzV+yJ3UzRJggEL79kUZODX0Unnapud92DwlQkIUL/A0nlDYwOX2GJTk5EbBBd37t9sreh+0PB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554011; c=relaxed/simple;
	bh=ZKK8AjK/a981cASpfClZS+uWsqj4JMYj3fORUpv+zng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZrZdRkASyrAZyCLxK3iQwdMqostgznq6fxkpb3OgK2XFgc17Wxy8VcSVxZ0GmbgT442SNZEQBYo726rMfunCvrVxZ58W5y8jgvB2NUY/OhB+fpk3+yVDJmm7mwdh7wjIgcE4vkt5aAdU5sPB22LP0PfYpNWcNAXvCULtwp5aSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRsO+Hhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRsO+Hhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B421F000E9;
	Mon, 15 Jun 2026 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554010;
	bh=gtoMGeBfqpY2kF8PW1XTWrMKKxSid3aVYEVo+C9v7DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IRsO+HhuP7UEelTjwM2j4Tugb42MoQ/zgQkdUYFs3ZF/J/EADczeTCpEWflO2FcZL
	 ku95w6qAy/R2mWx5JoLGIPnvfZwHT6delWcFpm5WTBtZ+xIH+0TROiO8gjoiuU44Vl
	 Kt0Cwd7jXlT/GXsUjRc4+moLGX3ia9jtdslP+RJq8F8Dps5oYHHCy3S+uHRfCFa4HU
	 fiStH71MeaBuRIILcoLWCo9jBpHt2lUwy03Foi6ScXS2/n51zUHRHeYbbwXKqkIM+s
	 W9W+aMDpE2++oqXYx4FOH+pEKWxzImt9HIMUlK4R8gh/vUsk0EbBikyWK3tlLXBnnF
	 jlKhMEgzMWZ0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] KVM: SEV: Perform RMP optimizations on SNP guest
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <25c3693a59c8f00796e84f1ffa668df6e3b734b5.1781419998.git.ashish.kalra@amd.com>
References: <25c3693a59c8f00796e84f1ffa668df6e3b734b5.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:06:49 +0000
Message-Id: <20260615200650.09B421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] RMPOPT optimization is skipped for large SNP VMs because the 10-se=
cond delay starts before memory is converted to shared.
--

commit b9cfe7528db8b373ee160983c730e4dd4a7d1b8a
Author: Ashish Kalra <ashish.kalra@amd.com>

KVM: SEV: Perform RMP optimizations on SNP guest shutdown

This commit introduces an optimization to perform RMPOPT after an SNP guest
terminates. It calls snp_rmpopt_all_physmem() in sev_vm_destroy(), which
queues a scan after a 10-second delay so multiple terminations can be batch=
ed.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4272293478766..0e94f81907ec2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2992,6 +2992,8 @@ void sev_vm_destroy(struct kvm *kvm)
>  		 */
>  		if (snp_decommission_context(kvm))
>  			return;
> +
> +		snp_rmpopt_all_physmem();

[Severity: High]
Does this delay start too early for large VMs?

In VFS, when the last reference to a guest_memfd is dropped, __fput() calls
kvm_gmem_release(). This drops the KVM reference, triggering sev_vm_destroy=
()
which starts the 10-second delay here.

After kvm_gmem_release() returns, VFS drops the inode, triggering
evict_inode(). This frees folios via sev_gmem_invalidate():

arch/x86/kvm/svm/sev.c:sev_gmem_invalidate() {
    ...
    for (pfn =3D start; pfn < end;) {
        ...
        rc =3D rmp_make_shared(...);
        ...
        clflush_cache_range(...);
        ...
    }
}

For large VMs, sequentially converting millions of pages back to shared
takes significantly longer than 10 seconds. The RMPOPT scan will execute
while sev_gmem_invalidate() is still running, observe the remaining pages
as private, and skip optimizing them.

Will this result in permanently missing the optimization opportunity for th=
ose
pages on large guests?

>  	} else {
>  		sev_unbind_asid(kvm, sev->handle);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781419998.gi=
t.ashish.kalra@amd.com?part=3D6
