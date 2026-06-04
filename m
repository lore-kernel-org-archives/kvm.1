Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57878175A87
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539001; cv=none; b=ii96JShyaC+kDN3f0pqa8t6oNaCc1FNnfNKajoqyAQuYDH4LTTP37vi3gI+HYruulBFPM4iSnKqYHekQWYHV2qmFUQo8zfkLwbbCpUa1X1gMMxJV4zHtRVsTf3kS8WW96NfqiLIKVwM4RqsRbbElUF8sRhg2it6RQVCfzs/JJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539001; c=relaxed/simple;
	bh=dwQzc6WC1bwspV2hl5KdZ0s84rQspzAaBpXzU5n25dQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHkJNK6EIyIVy/7yGpZTIbqThrZ40WOcbjoyIwBGYAe8uheJgXlgeQpG1PfgfxuVO7FiLqcWWqx0K/k/RNwdkWeVXqmX2x/r1S5QL/t0wingSZK0mQ8VptnDmr5FIqB7yF4HM24zFolSz9V6obz+ISvF0lrn7lw5cY9rA8skPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTbnp9jW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTbnp9jW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E008F1F00893;
	Thu,  4 Jun 2026 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539000;
	bh=/8UfWOh+w9L+sjMBxQHn0T8WCT3lax8AD4/7C15c8tY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTbnp9jWY5SljIMQmr3tR5Khzy/corIE7MXn5PO9ShtZTGFTutvYD8KHW8yQ/4qoM
	 kxDxcokDXYdMW3jmCF47nz73SAWSiMti8GAZ9XRcyKrZ36+luLWxCfvtzTUfuryhEx
	 Dc3FkQ7ZLXprMNXrvRtszj/VsxoXp7eZ3+p9h3Pa4B0bTJZgaqxIt0jH6Ck2Usvs0q
	 BbWx1DDBVPLpyWkaZf5D/z4Frvpv4HJ9XhjD6VQi0E8nuW5iYYAR2zuPTr6Kv13j9o
	 tZx64zgC1QNSnsDzapL4wBfUzmkjHIQJBl3iRfH3VARAQQw7brXQPPEYkpuR6fjDaH
	 5WJMTHxmC2duQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/21] KVM: selftests: Add helper to get host IRQ
 from device MSIX for IRQ bypass test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-7-jrhilke@google.com>
References: <20260604020143.748245-7-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:09:59 +0000
Message-Id: <20260604020959.E008F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fixed 4096-byte buffer for reading `/proc/interrupts` is ins=
ufficient on high-core-count systems, causing line truncation that leads to=
 silent parsing errors or test crashes.
--

commit a5706dfe149c4f11538fb9fee08d9fb4a971e2d5
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Add helper to get host IRQ from device MSIX for IRQ bypass =
test

This commit introduces proc_util.c and a helper function to parse
/proc/interrupts, mapping a VFIO device BDF and MSI-X vector to its
corresponding host IRQ number.

> diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/=
selftests/kvm/lib/proc_util.c
> new file mode 100644
> index 0000000000000..84d30f055a0a9
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/proc_util.c

[ ... ]

> +unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
> +{
> +	char search_string[64];
> +	char line[4096];
> +	int irq =3D -1;
> +	FILE *fp;
> +
> +	fp =3D open_proc_interrupts();
> +
> +	snprintf(search_string, sizeof(search_string), "vfio-msix[%d]", msix);
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, device_bdf) && strstr(line, search_string)) {
> +			TEST_ASSERT_EQ(1, sscanf(line, "%d:", &irq));

[Severity: Medium]
Is the 4096-byte buffer large enough for systems with high core counts?

In /proc/interrupts, each online CPU gets its own column for interrupt coun=
ts.
On systems with many CPUs, a single line might exceed 4096 bytes. When
this happens, fgets() reads the line in multiple chunks.

If the line is chunked, the first chunk contains the IRQ number, and a
subsequent chunk contains the target device names. The strstr() condition
would match on the later chunk, but sscanf() would look for the IRQ number
format at the beginning of that same chunk.

Since the later chunk lacks the leading IRQ number, sscanf() would return 0,
which would then cause TEST_ASSERT_EQ to fail and crash the test.

> +			break;
> +		}
> +	}
> +
> +	fclose(fp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D6
