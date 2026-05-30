Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8335F5F8
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780125815; cv=none; b=pMGxjYhdE7+oJOXudMAnhkSGHBll1piuYF8DFBkQ3/LBZsfh6R3iKpfsnbvSvgXtNggvxrisR2Gph6z20SEApP1ZUw574XMxqIdERHhNDNdWCGTytpcfH11Ty13o2L8TRKWGdoh8qayOKZRibSZ9wPwyyo3yQt1MFmkV94rc9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780125815; c=relaxed/simple;
	bh=wUQFTSEzO8xGJ5rs7jy4YtU2XuFZgLhL3i5yN19sFeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXEBgJ+wD9uyA065uTUDDWyTVa0K4dy8/NzOX8YaHKhhnUvRE0ZGqVCnKx8x/dQAKkyTquZGWgGJJjZc42ItKUZvy09E7Se6I1J+YYsqu64Tgs+4JBHGxrurHUJn11qX3KpfiyQUJp190+ZjLlboyT4S7/vC8HeowLzsvjh1crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgdPyFng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgdPyFng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426771F00893;
	Sat, 30 May 2026 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780125814;
	bh=p1Mi0AX+DQ9lepqyZs0t26xdJTx6E885uxEgyxzXPcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgdPyFngPZmHJltxM9121W14X9ykTbusVoNAjtW0savtFI5VmSXTGeAIkULwAPDXz
	 N4/nYNon5YSGvfFErzRKLqk2z5ZVHPJCEId+YEImpbt388otFoCcCNZOvoKdhGsJvf
	 P6+523MxHbYupaBcVSFga3kmvdA6ppxjJ8Y2QSqH1aQb37VPAdVXeGseZQ59wjxDbr
	 FavSySpeYD01P/J4JepMOd6ElEv8OIh05Ykyr28vt79X7KMYpkCVQnb5u7AUDajWOF
	 qHIVGdpXrHJpvgGsEuNE2qFjUo57DaHKk9ZSdSbne/gm9D2nO8UhMWYG/RhqCvJ9pP
	 0CJPLfNd4XPyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/27] KVM: Remove KVM_MMIO as config option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-18-seiden@linux.ibm.com>
References: <20260529155050.2902245-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 07:23:33 +0000
Message-Id: <20260530072334.426771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Brittle header dependency introduced in `virt/kvm/coalesced_mmio.h`.
--

commit fd122dad5412c5f1816bc36167f1d3f0cd523036
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Remove KVM_MMIO as config option

Defining KVM_MMIO is not flexible enough for multi-KVM systems with
different Kconfig options regarding KVM_MMIO. Therefore, remove KVM_MMIO
from the config space and use the macro HAVE_KVM_MMIO instead.

[ ... ]

> diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
> index 36f84264ed257..a8430d41945b9 100644
> --- a/virt/kvm/coalesced_mmio.h
> +++ b/virt/kvm/coalesced_mmio.h
> @@ -11,7 +11,7 @@
>   *
>   */
> =20
> -#ifdef CONFIG_KVM_MMIO
> +#ifdef HAVE_KVM_MMIO

[Severity: Low]
Does this make the header implicitly dependent on the inclusion order?

Since HAVE_KVM_MMIO is no longer a globally available config macro but is
instead defined in <asm/kvm_host.h>, evaluating it here without explicitly
including <linux/kvm_host.h> relies on the calling C files including it
first.

While this doesn't cause an immediate build failure with the current
includers (kvm_main.c and coalesced_mmio.c), a future includer that does
not include <linux/kvm_host.h> first would silently evaluate the macro
as false, resulting in missing struct declarations.

> =20
>  #include <linux/list.h>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D17
