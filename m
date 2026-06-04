Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD96279798
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538982; cv=none; b=Dw6uTi1Ih6owAIyV7mPN7LUExSa5KDZE7qEioriS5Ghdv/0TiYGaDWWsJ46eJUyDP9JU9YkMi47G7Yq6Obxi/OlTOaSB/skn9NvOKM/P9tjmJ8jAk0uKNMey7h/ZrwwJbKSN5XGkXq79OMqmwObBFDt97dxcYOUKX9b0qtCGQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538982; c=relaxed/simple;
	bh=GBkwi1bL9o5zkfwWC1h+9dcBO5ncimaNtnH78nvlJUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HOBWh6K0X/I5Bz7R9Ud7qbrLaCWNkqHPHWgQyD06lf3bH5Y+ldNKHYEVdXJdTVSUqzgVgLPxlnR3feBWmZTMnLgG0F0SiO68wpbTbGB2/pmr1zVVrUs1b2EyHS163VNHCr8MCP4vHCbzQg5xoxvKn2yfIAk6W2cwgu7IgxYgQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FovVjfIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FovVjfIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D12C1F00893;
	Thu,  4 Jun 2026 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538979;
	bh=5Vdm7wuZPJoJnGd0ZerUCesR885Hbt9L5+j5qsXZy9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FovVjfIlrIb492HEOIGXJ3c2v10RDS0N5rs4K9MNW8o3jR4+6obnbakg4N98vDLlI
	 42Jk32MYF/zO4wI/wkTa5+KBpjc91fBgMZYEG/cwx5XScDFT2aG1liu9JLOFKWNBa3
	 TXdk2TOczKMoQHWcQlma9uE6FMeVnB9z5gHZAoGe5NDwIFhHxdxEXVhaUrnNJ5Lfxi
	 p3uJrSj/icmpyoj2Ac22xuNqwC63wMTm67DCSFI0JMWQJliVjonwWDmo6hrPppzO/e
	 PmQGamoumIoBewRpfJmOeyylhiHg9KXZrO0K9VPzJh3LTGNSDO2odgJPGrufc26y2r
	 YyKiZSdvU/D5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/21] KVM: selftests: Add helpers to print proc IRQ
 affinity for IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-10-jrhilke@google.com>
References: <20260604020143.748245-10-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:09:38 +0000
Message-Id: <20260604020939.3D12C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Silent buffer truncation of smp_affinity on systems with high CP=
U counts.
- [Medium] Bypassing selftest logging framework with direct `printf()` call=
s.
--

commit 5691e1b7c72b1da31e3e650e6d818488952fb296
Author: Josh Hilke <jrhilke@google.com>

KVM: selftests: Add helpers to print proc IRQ affinity for IRQ test

This commit introduces utility functions to print IRQ affinity settings
via the proc filesystem. These helpers will be used for debugging KVM IRQ
test timeouts.

> diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/=
selftests/kvm/lib/proc_util.c
> index 938c90d94f4dc..24a8de92e2290 100644
> --- a/tools/testing/selftests/kvm/lib/proc_util.c
> +++ b/tools/testing/selftests/kvm/lib/proc_util.c

[ ... ]

> +static void print_proc_irq_file(unsigned int irq, const char *file)
> +{
> +	char path[PATH_MAX];
> +	char buf[256];

[Severity: Medium]
Will fgets() silently truncate the smp_affinity masks on large systems when
reading into this buffer?

CPU affinity masks are formatted as comma-separated 32-bit hex words. A
256-byte buffer limits the output to roughly 910 CPUs.=20

Because masks are printed from highest index to lowest, truncation would
drop the affinity data for lower CPU indices, which are typically where=20
IRQs are pinned.

> +	FILE *fp;
> +
> +	snprintf(path, sizeof(path), "/proc/irq/%u/%s", irq, file);
> +	fp =3D fopen(path, "r");
> +	if (!fp) {
> +		printf("  Failed to open %s\n", path);

[Severity: Medium]
Does this bypass the selftest logging framework?

KVM selftests typically use pr_info() from test_util.h to allow standard
informational output to be suppressed when QUIET is defined. Using printf()
directly forces unconditional output and can cause log spam in CI
environments.

> +		return;
> +	}
> +
> +	if (fgets(buf, sizeof(buf), fp)) {
> +		buf[strcspn(buf, "\n")] =3D 0;
> +		printf("  %s: %s\n", path, buf);

[Severity: Medium]
Should this also be updated to use pr_info() instead of printf() to respect
the QUIET mode flag?

> +	}
> +	fclose(fp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D9
