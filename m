Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD352941C
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868660; cv=none; b=aBc08qH+RgusrgtFEvL0ep9GF6PTI9qagiGoAH21KH37uY/QE8EW5/kLyNGkq2LntRI4LCvdHWivCt/qLFJNooPnY+skTcHjGTEc9HnLu4e6hh+1dy6ssaHLR9WpUUx0aI+dj65ZkfkVRlZxKNyk2f8tpUjLPJnfDXOTNipfL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868660; c=relaxed/simple;
	bh=LrFCB2QV6LJomikkSmqmFUaeFu3C0zvIWzQvnmxgbqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u7fIaiGFv76qHn58rQuAN2Rle7Pb0h58c1Ue6iCqPiFR/T2ub3+0RzSKOvAjFuPYfg+DPpsKPvQhYJVd3a4HgxFLWPJ1FRTjjyyoQFfB8QFBRSUVSoZFyMbb9B69ONvy/+wTZY02AcGkbYD3/j41bcpUT0xLFF4w/sra7hSfL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtzuX9+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtzuX9+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373AE1F00898;
	Thu,  1 Oct 2026 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868658;
	bh=kg/J+1xAQJMd8rGsrR2l/xVKdVcC96NCdEkj9saZBDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtzuX9+BTlHUadk9HbMfEsDkaSbE9mW2/WYANt19OA41rNYJPQxBy2hIkKdLGcVIj
	 qVfLz0jZB6qKN/aZddjS0fqMO/hv39DyI5uYjnV8wKTDLqyc4adckN1HEFz8XQwFZG
	 ZhiXLhdsFTzTGuq/9IFe4DQq749u26NTqVaGIpo7gzKbqq1N92hGvnGsmSu7l/oaou
	 HZhO2XzUR6WhXBcMQBeINjs9jc6nySgkwpYk2wOFBj6pYSHLrotnLYgBRo8DSNt3IG
	 CC4ymcRCOvjrhYODCClj6q7Hfs4toJue1b/2T7P+xZwfVUgA/tvs0FR1HpbTS2Y9av
	 Ro5sEX+a5n7zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration
 definitions and data structures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Babu Moger" <babu.moger@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:30:57 +0000
Message-Id: <20261001153058.373AE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/resctrl: silent truncation of closid in msr_pqr_plza_assoc
--

commit 850d244de0af8ce075ea53a011e816d9227fff52
Author: Babu Moger <babu.moger@amd.com>

x86/resctrl: Add PLZA configuration definitions and data structures

Privilege Level Zero Association (PLZA) enables the kernel to switch to
a different CLOSID and/or RMID than those used in user mode when entering
kernel mode. CLOSID and RMID selection are independent and can be
configured separately.

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu=
/resctrl/internal.h
> index e3cfa0c10e92d..44ecde20b1b43 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h

[ ... ]

> @@ -222,6 +222,55 @@ union l3_qos_abmc_cfg {
>  	unsigned long full;
>  };
> =20
> +/*
> + * Privilege Level Zero Association (PLZA) is configured via
> + * MSR_IA32_PQR_PLZA_ASSOC.

[ ... ]

> + * This allows PLZA to override only RMID, only CLOSID, or both. If both
> + * rmid_en and closid_en are clear, the effective behavior is the same as
> + * when PLZA is disabled, with RMID and CLOSID used from MSR_IA32_PQR_AS=
SOC
> + * irrespective of privilege level.
> + */
> +union msr_pqr_plza_assoc {
> +	struct {
> +		u64	rmid		:12,
> +			reserved1	:19,
> +			rmid_en		: 1,
> +			closid		: 4,
> +			reserved2	:11,

[Severity: High]
Does this correctly size the closid field?

The closid is defined as a 4-bit field, which could cause a regression
through silent data truncation when assigned a value >=3D 16.

resctrl dynamically discovers the maximum number of CLOSIDs supported by the
hardware via CPUID. If the hardware reports support for more than 16 CLOSID=
s,
resctrl will allocate closid values >=3D 16.

When a resource group with closid >=3D 16 is assigned to PLZA via
resctrl_arch_configure_kmode_global(), the u32 closid is assigned to the
4-bit split.closid bitfield, silently truncating the upper bits. This
programs an incorrect CLOSID into the MSR, breaking the requested
cache/bandwidth isolation for kernel mode operations without any warning
or error.

If the AMD specification allows a 15-bit CLOSID (like standard
MSR_IA32_PQR_ASSOC), does the struct bitfield incorrectly split 15 bits
into 4 bits for closid and 11 bits for reserved2?

If the hardware is strictly limited to 4 bits, should there be a bounds
check (if (closid > 15)) or a cap on num_closids when PLZA is enabled?

> +			closid_en	: 1,
> +			reserved3	:15,
> +			plza_en		: 1;
> +	} split;
> +	u64	full;
> +};
> +
>  void rdt_ctrl_update(void *arg);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790867441.gi=
t.babu.moger@amd.com?part=3D3
