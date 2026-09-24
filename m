Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C846A5FD
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245702; cv=none; b=Ho9+0Uvhyjpa4OXBmIdoi6/SlmUHwGQAUIs+mIUQ5m7/DxbdKUHUmdFPlhfFPcC4yy97KW8HYUGpRC30ujPJCochnJ8b9hiZQ3XlXolA7uK31ZyTySHepZ3DXVfiPdmI5MwK0JJ3dWt7gI6ydPOey/O5gyTWyBXAhIkplXUFtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245702; c=relaxed/simple;
	bh=66jrx2lKFMrfbaEwRzJhsHLSUbz6+NPzJ6cOOW2jiIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=In90dBmPXpMXJeF2Xu6RRlkdCKJsy4yOmhdvW+AR1cBS6lxifXHnBES7D/HfOzXOLfk6U7unajTdoWgRB9RPjHFhNV7KyYrvu8YbdUe+AeG0xpyRpKQCutfF6gpXQUfsOWvqo33p8epWMHBOyE5d/A73bOjGJWQD1AZzi51s8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APNxTbYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APNxTbYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF81F00893;
	Thu, 24 Sep 2026 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245701;
	bh=brMHlaI+IE75DQcibhsmZ1XekR3oS7K3Eru1k8wJBSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APNxTbYY4gVNJa5/EwyY1XmI/EcY2D1BrU9VBH8TFsfRXFMb8cJhA7Vqmn2xMHjHM
	 MzoHGswDESQ0WDUnfkWQyiuV1QB/lbxcEQMHkeLegRF5yeUjPbx0rvpOdnNDhKOGIa
	 m4h/bdU+/pWwlDNgK6zu2JMyjCM/iICFCD2UtgSQgn46mBrkbazOvqB3KIxA1Mg2IZ
	 B4MPY2DJPtEn6uvzy4n8mjzUzPcbXOtjigntWUVdpzGqJqBHsVKnqDXkRv2cZSyYXk
	 4QqyeNB8Ui6ep8rRUvzbAq/xYEZP2pGhmm0INR4nojYgRwQGfLJqOG6QGR/ABtz0jB
	 mQId2fYGE18dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: Clear HSTATUS.HU on CPU initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260924-hstatus_hu-v2-1-7e970f5f1d8d@sifive.com>
References: <20260924-hstatus_hu-v2-1-7e970f5f1d8d@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:28:19 +0000
Message-Id: <20260924102821.09EF81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] riscv: incomplete HSTATUS.HU mitigation on asymmetric MP due t=
o global check
--

commit 34c26113f845622c7a6f9c472ce2342eaac66df7
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

RISC-V: Clear HSTATUS.HU on CPU initialization

This commit clears the HSTATUS.HU bit during CPU initialization to restrict
hypervisor instructions to HS-mode. This is intended to prevent unexpected
guest memory access from U-mode code.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index f46aa5602d74d..80767a0166026 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -1183,6 +1183,18 @@ void __init riscv_user_isa_enable(void)
>  		pr_warn("Zicbop disabled as it is unavailable on some harts\n");
>  }
> =20
> +void riscv_clear_hypervisor_csr(void)
> +{
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_h))
> +		return;

[Severity: Critical]
Does this global check cause a regression on asymmetric multiprocessor setu=
ps?

If the 'H' extension is not present on all CPUs, the global
riscv_has_extension_unlikely() check returns false because it relies on the
riscv_isa bitmap representing the intersection of all CPUs' extensions.

This would cause riscv_clear_hypervisor_csr() to exit early without clearing
HSTATUS.HU on the specific CPUs that do possess the 'H' extension. This cou=
ld
potentially allow unprivileged U-mode processes on those capable CPUs to
execute hypervisor instructions (HLV/HSV) and access host physical memory.

Would it be better to use riscv_cpu_has_extension_unlikely(smp_processor_id=
(),
RISCV_ISA_EXT_h) here to ensure the check evaluates correctly for each CPU?

> +
> +	/*
> +	 * Clear HSTATUS.HU to restrict hypervisor instructions to HS-mode.
> +	 * This prevents user-mode from executing HLV/HSV instructions.
> +	 */
> +	csr_clear(CSR_HSTATUS, HSTATUS_HU);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-hstatus_hu=
-v2-1-7e970f5f1d8d@sifive.com?part=3D1
