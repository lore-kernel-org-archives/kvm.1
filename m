Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939E271450
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538975; cv=none; b=gnavF5YKg2IrlUyEZtJbGPsLyhUpX9CHIB05m+JCGuMAPsT0tF9VH9/v/iVx/FNT+2aup4zITKjdiwJ93KAkaugFV72VkFS9kJ99/qAGFqB75c4boVkj6FlK+3iwZGqfD7cXW3u8VYkFLTd3wgB+D/5dfVkB49XmKR/D3xNSs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538975; c=relaxed/simple;
	bh=YAt2ABc6WYckCRGLLonwMVLvo2Hi8jnHjCcDw/m9HRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQo70VrIEivVmJI2MKpxS0FF7025fGGKo67P3DOFVp40GTJx/RrAa8GCeWuStNg1Mw4o1vFymE0Atl+hQuEREk7dkIwrFsayjRSx1zqrD6ZR1Um9K3uzy4IyEFV/Fk69WY4IMDWwcAxPtcj5HG3/iW0kwxItJE1UBlyW2FffsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIOOfV0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIOOfV0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5FA1F00893;
	Thu,  4 Jun 2026 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538973;
	bh=F4dnp2O2glZqRrVwFktN6jXXyK4/nZU66BKoUEKMvT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aIOOfV0PiponWlbyCBLQHfi0C3agxZfm1zI0YgxHnGqDKGG7LGvN165D/GBMXl/2G
	 P8gdOwclQi9sbcmbFyYXz3/kFdMxgYAMBThm5MHIq4/1vltKhHI5aPvyZ/dVBG4O09
	 gHV9YHCD6s7gEQyARD3QreCIROcCrmSnoRIPS2EtlsknCpXEYF6sTUc0he6wmq9icd
	 bltYvo0jqx7qPLvLNqgYpzb9txWvZ4SRFXCNNIVQc8kDdt1ZS14XlGwmD0NUrWPKWT
	 /AdKsuJ9DZL6N7aAD0j+mDpn9qsmjJUWEFAXRjNTZtchxJKrEth7hI0MyiYnNcZTot
	 BFPpDcH7wXoRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/21] KVM: selftests: Add helpers to write proc IRQ
 affinity for IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-9-jrhilke@google.com>
References: <20260604020143.748245-9-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:09:33 +0000
Message-Id: <20260604020933.9C5FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unchecked return value of `fflush(fp)` in `write_proc_irq_smp_af=
finity_list` masks kernel-level errors when setting IRQ affinity.
--

commit f8e5a1088978380d14d1dba883635775118bfd1b
Author: Josh Hilke <jrhilke@google.com>

KVM: selftests: Add helpers to write proc IRQ affinity for IRQ test

This commit introduces utility functions to open and write IRQ affinity
settings via the proc filesystem for use in a subsequent KVM IRQ test patch.

> diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/=
selftests/kvm/lib/proc_util.c
> index 84d30f055a0a9..938c90d94f4dc 100644
> --- a/tools/testing/selftests/kvm/lib/proc_util.c
> +++ b/tools/testing/selftests/kvm/lib/proc_util.c
[ ... ]
> @@ -38,3 +38,23 @@ unsigned int vfio_msix_to_host_irq(const char *device_=
bdf, int msix)
[ ... ]
> +void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int ir=
q_cpu)
> +{
> +	int ret;
> +
> +	ret =3D fprintf(fp, "%d\n", irq_cpu);
> +	TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, irq_=
cpu);
> +	fflush(fp);

[Severity: Medium]
Since fprintf() only writes to the userspace standard library buffer,
wouldn't any kernel-level rejection (such as an offline or invalid CPU
being provided) only be reported during the actual write() syscall
triggered by fflush()?

Should this code check the return value of fflush() to ensure the kernel
actually accepted the affinity setting? Otherwise, couldn't a test
silently proceed with incorrect affinity and cause confusing failures?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D8
