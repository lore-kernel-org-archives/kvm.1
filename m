Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79EEEBA
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053320; cv=none; b=PtTuq8MAH6zAyZ5zPVjoQiBMyYXdVSqtkUxIlyCcoQnIY/okQt0XuQmF0V9zUYLKS6mGG7LPFMioTsdPPBiW8FiOasviMLczea6+JZnn/cYITdOrwS8lxPesQ7zWP8P/3sQbUQrVPbt5RyweaI/7NvNvTr8krlfAdaHbU3pjyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053320; c=relaxed/simple;
	bh=IUymJ0+kyHTOqEAgusELFWfzgana5Oag94LjiahJa7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XE5uv1sM1qc+Jk38L9fUVQpJwQ+9Mq1gfNXCmFMChASe21bwPa5i1h72VOp/PccGgiNsRL11deSn0YZcF9uxjpuj/2T7PDCP7XdEoYAFY4w9C9C1UGBAJPGfl7N0UnSrf6BRre9vUcxTnVtjcA9BsumD0X6RcJVmHgDA6VYq9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo7L9leF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo7L9leF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF361F00893;
	Wed, 10 Jun 2026 01:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053318;
	bh=zTFQddiWGqZIaxaaO9Fskr35XkYlFbRBs9EJzZMG8OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mo7L9leFgcoYkPQdFIatZorjd/HSHaAUqV76riwsezE0QwpKC+CvECY0ypVtns3/q
	 9+X+I7D8bXygi/h/ZC/czA/vhTFSJk3ZS1YX3BUD4fpoV9toCB8RffI0IQ909rbbuh
	 otAUA+25D6D7c+raofZzZ0ujtwz20QVUt+ZzOC9SO3CBBseVa3BeUxql9c3Y3iFPh7
	 Lu+lqr8gePCF0VcDkUPuOCCTeMWSnC1IcWL6naYm6WPATo+TPnbD3NMAiXS1o3waWN
	 r1swM7wzP+5O1V6Zi4GyKuRmyl13rLRs01lzA3ZtgRO6Rz6/KPMpMlta2EeMnrmvmW
	 23ibJk85BX/QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/18] KVM: selftests: Add helper to get host IRQ
 from device MSI-X for IRQ bypass test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-7-seanjc@google.com>
References: <20260610005338.2967132-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:01:58 +0000
Message-Id: <20260610010158.9FF361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Buffer truncation when parsing /proc/interrupts causes incorrect=
 IRQ extraction or test crashes on large systems.
--

commit e51d631d9d46231f822d202d28c9466d2c3d253d
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Add helper to get host IRQ from device MSI-X for IRQ bypass=
 test

This commit introduces proc_util.c and proc_util.h to provide utility funct=
ions
for interacting with the proc filesystem. It adds vfio_msix_to_host_irq() to
parse /proc/interrupts and find the host Linux IRQ for a given VFIO device =
BDF
and MSI-X vector.

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
Could this fixed-size buffer lead to truncated line parsing on larger syste=
ms?

On systems with many CPUs, a single line in /proc/interrupts can exceed 4096
bytes. When this happens, fgets() will split the line into multiple chunks.=
=20

The first chunk will contain the actual IRQ number at the start, but not th=
e=20
device_bdf or vfio-msix strings (which are at the end of the line), so it=20
will be skipped.

The subsequent chunk will contain the device strings, causing strstr() to
match, but this chunk won't start with the IRQ number. When sscanf() runs
on this later chunk, it could return 0 and cause the TEST_ASSERT_EQ() to
abort the test, or worse, silently parse an interrupt count as the IRQ numb=
er,
which could disrupt the host system if the test attempts to change the SMP
affinity of that unrelated IRQ.

> +			break;
> +		}
> +	}
> +
> +	fclose(fp);
> +
> +	TEST_ASSERT(irq !=3D -1, "Failed to locate IRQ for %s %s", device_bdf,
> +		    search_string);
> +	return (unsigned int)irq;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D6
