Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884A37DE9F
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710801; cv=none; b=NtiC0QzX27Cbx76T24VwhDxNmgTpDJRvkfH3RjamH4XM5E0Qinsc+155pK0KJyy6BS4n/NdwqHFpYmW+FQuWBLJqu/F7EJi+xm3wchR+uCWwPL90ZGpoJCqLwkN4+WQh/c+bD2pR4i3k08nWau6JcrUFwHXCYbT7ylR5z8+Yk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710801; c=relaxed/simple;
	bh=K7hftySqJ84syS01osrFM4H2/IChZzhHyOIGxBhocj4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oD58rhq0z8TsmddttaWdPG0yf1oYfwYWFqvnzXi00lJFF4emXq+BVxP3ubv1Kv0cLspXX39c6ju+1pR8R9VLmhbtV7xIa0iX6tQZ7isBHJhwsiu0PaggC8uExsOB40UfTCpcI8ftaybd/bfWQuM9F82AR22xE/uDAitwxQsAka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIaGV3Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIaGV3Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328441F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779710800;
	bh=mJX5NWrfZP8G4i3ze9qPnICO5C7TRKekeXibWesECR0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EIaGV3AmwweOHB9tFSnrOJAGD1ID6W5+xMPeLhuShBvisye7YB1rKw+nSXtqUtwR/
	 MUKgazMlRzT80WzR4fXxDtX/WPR4TdSNl1afBuobVUHvF5ZZCYc4uH0zRF4Ya7hDTf
	 Yh/BZMKJSdn7ptvHUPtjGpT3oWaqO6GOLypNzulabklTc7LEYgnuUjksFusWDSBq/N
	 fGOt55NSY/dKRM9N3trQP7NawzcIBecsdfs0SoAcUgUUIK0053dPz8JGbkLF40fBKV
	 2A77yzVP0krCS+SbULuX/+6gSDE925PZr/VW8+/sU9GwzVi1qP3lH6WMvTzOz3t4No
	 Ai9UzY2LeDItA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] mm: decouple protnone helpers from
 CONFIG_NUMA_BALANCING
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-2-kas@kernel.org>
References: <20260525113737.1942478-2-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:06:39 +0000
Message-Id: <20260525120640.328441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional selection of ARCH_HAS_PTE_PROTNONE on LoongArch caus=
es boot-time warnings/panics in debug_vm_pgtable on 32-bit configurations.
--

commit ce0e2bca623ff8e41c100c4e1e7335cad7b9483c
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: decouple protnone helpers from CONFIG_NUMA_BALANCING

Introduce CONFIG_ARCH_HAS_PTE_PROTNONE to decouple the protnone PTE
infrastructure from CONFIG_NUMA_BALANCING.

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 606597da46b8d..77e9a9a30483f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -67,6 +67,7 @@ config LOONGARCH
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	select ARCH_HAS_PTE_PROTNONE

[Severity: High]
Does unconditionally selecting ARCH_HAS_PTE_PROTNONE introduce a regression
by causing a boot-time warning in debug_vm_pgtable on 32-bit LoongArch
configurations?

On 32-bit LoongArch (CONFIG_32BIT), _PAGE_PROTNONE is defined as 0. This
makes pte_protnone() always return 0. During boot, pte_protnone_tests() in
mm/debug_vm_pgtable.c executes WARN_ON(!pte_protnone(pte)), leading to a
kernel panic on systems with panic_on_warn.

Prior to this patch, these tests skipped 32-bit LoongArch because they were
gated by CONFIG_NUMA_BALANCING.

Will this also cause a regression for generic features depending on
ARCH_HAS_PTE_PROTNONE (like userfaultfd RWP), causing them to fail silently
on 32-bit LoongArch since they expect pte_protnone() to accurately identify
PROT_NONE PTEs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D1
