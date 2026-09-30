Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9E4F30F0
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779636; cv=none; b=islGkB+pTtp3RNGiwMYJpvpne/tnPz8EIlYjSzsbh7TGvj6/w1RmcqHE7QpK9ThFdY/ZiQf7+pU+MWO027qvrtiH6onHjQv4rzfzVQ/bhcZRun24Bftg+kJPD4vJ8yfW+Cvo++zXoAA48qfd1qzsPGWKxgtnc1TSFeddTdO6tUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779636; c=relaxed/simple;
	bh=i/lAhqJUZPas0av5O8+wvuX+nlWqKiyEgEnOlgk69JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4OtEB41QzsvL+VA6epoAPhkAHzZlZNWYZprPoc5IEW1SvHlI+wsUxC5Pq3XZlwwKfTG+xgiUlVQviJNozS4m7FTrHIlH6hOX2bxofha5NgUxsbsPFfE4ue7RslZlqmF2jBBAYWL+5HjJQ1mW14bPcqCYLqLxF4ZDw1bFfcnRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFXXtdAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFXXtdAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB91F00898;
	Wed, 30 Sep 2026 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779631;
	bh=i/lAhqJUZPas0av5O8+wvuX+nlWqKiyEgEnOlgk69JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFXXtdAVbm5kbeebekqVkPglJotfzmiabBasoMw90OLtwcRLvgC8Wq9GdO7xCyagP
	 oik4NmM7qqEQZ5uf5DpehqqRonNZr9ZPoeQcoM2dB4dsEU6Xe2j1wZEuEJJ2sbjVqN
	 ihJJ4grEEbATtKGI5VfjBXMXTmtaKgzW1gfuzrVbqszRjGWfVgpyclqZlbI6Q437gg
	 aSjNQTTiKljk1/U9CjtgD9AXQNxL4q076enMr0QpDRb93XVstyc7gKZ6Ab0K5VcYeQ
	 OB8x8WdLLmWu/l7s+YVJphjJJX7o5YC5B83mKDN/mG7F9yYrTcqmycosyzmvLq6l6H
	 fbLMTwHrvUeaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] vfio/pci: Remove the core dependency on driver
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930143641.4160785-2-xinmengs@nvidia.com>
References: <20260930143641.4160785-1-xinmengs@nvidia.com>
 <20260930143641.4160785-2-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:47:11 +0000
Message-Id: <20260930144711.97CB91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pm: dev_pm_ops unconditionally assigned without pm_ptr()
--

commit 3f91e92ded670b6d793f7c9ea8fda1f011d465c3
Author: Simon Song <xinmengs@nvidia.com>
vfio/pci: Remove the core dependency on driver data

This commit introduces VFIO_PCI_CORE_DEFINE_CALLBACKS to generate wrapper
code for each vfio variant driver. It updates variant drivers to store their
private structures in driver_data and use the generated wrappers.

Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/

[Severity: Low]
In drivers/vfio/pci/vfio_pci.c, inside the vfio_pci_driver definition
around line 260, the driver pm pointer is assigned directly to
&vfio_pci_pm_ops.

Does this unconditional assignment prevent the compiler from eliminating
the dev_pm_ops structure when CONFIG_PM is disabled? When PM support is
disabled, the dev_pm_ops structures will remain in the compiled binary as
dead code. As mandated by the PM subsystem guidelines, is it possible to
wrap the pointer assignment with pm_ptr() (for example,
.pm =3D pm_ptr(&vfio_pci_pm_ops)) so the dead structure is safely dropped?

[Severity: Low]
Similarly, in drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c around line
1728, the hisi_acc_vfio_pci_driver assigns the pm field to
&hisi_acc_vf_pm_ops without using the pm_ptr() macro wrapper. Does this
result in the same dead code issue when CONFIG_PM=3Dn?

[Severity: Low]
In drivers/vfio/pci/ism/main.c around line 395, ism_vfio_pci_driver also
unconditionally assigns .pm =3D &ism_vfio_pm_ops. Should this also be
wrapped with pm_ptr() to ensure the dead code is eliminated?

[Severity: Low]
In drivers/vfio/pci/mlx5/main.c around line 1454, the mlx5vf_pci_driver
assigns .pm =3D &mlx5vf_pm_ops. Can we use pm_ptr(&mlx5vf_pm_ops) here as
well to avoid leaving an unused structure behind when power management
is disabled?

[Severity: Low]
In drivers/vfio/pci/nvgrace-gpu/main.c around line 1427, the
nvgrace_gpu_vfio_pci_driver directly assigns .pm =3D &nvgrace_gpu_pm_ops.
Would applying pm_ptr() here ensure consistency with PM guidelines and
allow the structure to be compiled out correctly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930143641.4160=
785-1-xinmengs@nvidia.com?part=3D1
