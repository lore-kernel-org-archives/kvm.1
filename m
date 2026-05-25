Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E293382DC
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704329; cv=none; b=u01dB8JFojrhCE9Juydf9FDTGRgVwI6klp4Rs2pcld8NYQBTfHE3LaOFyIzD0KTP9ry3Wf0j5YzFTSG4WjD3pjDXKKZBtzmk6maYx/lJmZ1t4V8LswYbzD/WuZJp70tlQ1pitV/fUZsTW+4syA7IQWrhfg4t5Fomr9+D98yW3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704329; c=relaxed/simple;
	bh=gezKptKHQJ6Fbc36vcGICBuy1B7dsf5PBldeRqHZarc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oSB69g6/xTl+vQP6cg52og8GYFG+zqdlhHdim0VsBzUjSzijGEJdCjwlSL892xS6gRv45GoE+Zw38YoGF0yuFcbg5/GTLdWvPOWeLDO8xfIizZKgE8gm9vtRH86Gv0ZtnXIF5uLIO2gRX8oLkT3S86iaBL46wivLRj7sPKKhQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDdWRs8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDdWRs8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430F31F000E9;
	Mon, 25 May 2026 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779704328;
	bh=ap295fnGU4+PQ6IKuRqZxYgqp+uekliM0RyLtWKK6t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDdWRs8S2Vji3QlXtLLCV7bS3UWZlJah9cGKmdQtXgfdUBnA6hUs6pf71z+vh5YP7
	 zMX7n8uLv7byJfg4ZXfxCIYS/63xDbRgm5V2V9KMPhsKneZL48jsSkpYjr/Kn2Kqtn
	 pd48jiw2HrDn+t6rWAB16ln7Gkeq4+DPNmvbk+2Uan7ZfkAB4RsLDk/ORptlIFDqtx
	 dvahpyV+WNw6R9QnwPuC52GKXxZ0rwxI8gp7fcCbb3thtegxBGvbFWMNtil/XnSm+z
	 mLpCLUPpqPfE3HkfTjV4ko81mJTbMbqYBoJQjb7tBsVZ30ujFw+5cJNUL6beaDTQgF
	 hO+7gfLgYIJJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] irqchip/riscv-imsic: Add nr_guest_files in
 per-HART local config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525094945.3721783-2-anup.patel@oss.qualcomm.com>
References: <20260525094945.3721783-2-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 10:18:47 +0000
Message-Id: <20260525101848.430F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The loop searching for the correct MMIO location uses `nr_mmios` a=
s its continuation condition instead of `j < nr_mmios`. This acts as an inf=
inite loop if `nr_mmios > 0` and can cause an out-of-bounds read on the `mm=
ios` array.
- [High] The calculation of `nr_guest_files` can silently underflow to `0xF=
FFFFFFF` if the remaining MMIO resource size is smaller than a single page,=
 leading to an incorrectly maximized guest file count.
--

commit 15182effc09715c1274ad73e7c779ccf2a70e30d
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

irqchip/riscv-imsic: Add nr_guest_files in per-HART local config

This commit adds nr_guest_files to the per-HART local config to represent
the number of guest files available on a particular HART. This allows KVM
to use per-HART configurations for asymmetric big.Little systems instead
of relying on a global minimum.

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index e3ed874d89e73..b8d1bbbf42f73 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -920,13 +920,12 @@ int __init imsic_setup_state(struct fwnode_handle *=
fwnode, void *opaque)
>  		local->msi_va =3D mmios_va[index] + reloff;

[Severity: High]
This is a pre-existing issue, but looking at the code just above this hunk
in imsic_setup_state(), the loop searching for the correct MMIO location
uses nr_mmios as its continuation condition:

	for (j =3D 0; nr_mmios; j++) {
		if (reloff < resource_size(&mmios[j])) {
			...

Since nr_mmios is a constant integer greater than 0, this acts as an
unconditional loop. If the condition is never satisfied, could j increment
past nr_mmios and cause an out-of-bounds read on the dynamically allocated
mmios array?

> =20
>  		/*
> -		 * KVM uses global->nr_guest_files to determine the available guest
> -		 * interrupt files on each CPU. Take the minimum number of guest
> -		 * interrupt files across all CPUs to avoid KVM incorrectly allocating
> -		 * an unexisted or unmapped guest interrupt file on some CPUs.
> +		 * KVM uses both local->nr_guest_files and global->nr_guest_files
> +		 * to determine the available guest interrupt files on each CPU.
>  		 */
>  		nr_guest_files =3D (resource_size(&mmios[index]) - reloff) / IMSIC_MMI=
O_PAGE_SZ - 1;

[Severity: High]
This is a pre-existing issue, but can this calculation silently underflow to
0xFFFFFFFF if the remaining MMIO resource size is smaller than a single
page?

If the remaining resource size is strictly greater than 0 but less than
IMSIC_MMIO_PAGE_SZ, the division yields 0. Subtracting 1 from 0 causes an
unsigned underflow.

Because min() is used in the following lines, it compares both as unsigned
and selects the maximum allowed guest files instead of 0. Could this
artificially inflate the guest file count and lead KVM to make out-of-bounds
MMIO accesses?

> -		global->nr_guest_files =3D min(global->nr_guest_files, nr_guest_files);
> +		local->nr_guest_files =3D min((BIT(global->guest_index_bits) - 1), nr_=
guest_files);
> +		global->nr_guest_files =3D min(global->nr_guest_files, local->nr_guest=
_files);
> =20
>  		nr_handlers++;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525094945.3721=
783-1-anup.patel@oss.qualcomm.com?part=3D1
