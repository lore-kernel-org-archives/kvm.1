Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994B392C4B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077561; cv=none; b=cUNKFGCXd5ninlPm1Kb1PVTObS1zodAqrqHIiPt8LJ5MqUQUH5k6ioI3HyTHffT7FyTGc8AimRVgj/aGqgiYnYNp2i+g22zpeKRcHAaHYqINl6ZX0SvD1P6JDbAn+hHsvLmiIKKMSgyVmZPdxK7EFxT1nLNmkNeaCjFwGzk9leo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077561; c=relaxed/simple;
	bh=0UaXMordpbpDhhM/NOEcEnJf0klKFxxxB5KNLcgNOcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCcMGkp7oWTzUZFpFuCiUMjGu8WQJaeEkTDJZcrMhqbsk6b5Iz194Gt+f3rSwN/EMVrHZdVd3a6tY4gVrSNYrOmwj2bYfKBIkyjoxMW1QTKbvDkvV/b75i2s+iy34j+pFBCgzOpJzxqxx3k4nRQHJHscwIhSzYz/PfsxxbmxsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzS2mgS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzS2mgS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331371F00893;
	Fri, 29 May 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780077558;
	bh=s8eFqlkjYEk91v5fzGrFmIftnsmIBZ8RUqkME0H+iFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzS2mgS2IbN+JeMxcrDxkH1nQ/5g3trVMkFT7GbRGN8A9scYeZVmud++qnjeGPsvY
	 k6v+WesW0KGcYZthVCYtwGYmKiLE1ruB/uH+dnM/P3BX2p9nVc2IVJT9VcTEYLTFOf
	 xnYNhigQmIXoLW8TtIxeleURMdddO8To0ff14zVLXveL09/3YTlGgddivGoqlnxoQb
	 QN+YQRjRxBTKu9UExAYJfc0fbgPPLG2X6duGnTI/0ym1gn/NkSOFXdLdYFisRvZ8xM
	 IklfQNWj1QFiiFD8uHAe7jlpnyvy47KbRyNrhfIGFTcxk94Xm+C01Ktcm7XI+4Rdoo
	 XD4rYVr88kpsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/20] KVM: Add CLASS() constructs to automagically
 handle lock+check of gpc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-12-seanjc@google.com>
References: <20260529165114.748639-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:59:17 +0000
Message-Id: <20260529175918.331371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The cleanup wrapper defined by `DEFINE_GPC_CLASS` uses `if (!IS_ER=
R(_T))` instead of `if (!IS_ERR_OR_NULL(_T))`, failing to guard against `NU=
LL` pointers. This leads to a guaranteed kernel crash if ownership of the c=
lass variable is ever transferred or if it is initialized to `NULL`.
--

commit 88a61c5d744692bfbffaf3ccd332184029a7ffee
Author: Sean Christopherson <seanjc@google.com>

KVM: Add CLASS() constructs to automagically handle lock+check of gpc

This commit adds CLASS() definitions for mapping a PFN given a gfn_to_pfn
cache (gpc), deduplicating lock, check, and unlock loops. The pvclock code
is converted as the first user of this new construct.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> +static inline void gpc_map_local_unlock(void **khva)
> +{
> +	struct gfn_to_pfn_cache *gpc =3D container_of(khva, struct gfn_to_pfn_c=
ache, khva);
> +
> +	kvm_gpc_mark_dirty_in_slot(gpc);
> +
> +	read_unlock(&gpc->lock);
> +}
> +
> +static inline void gpc_map_local_unlock_ro(void **khva)
> +{
> +	read_unlock(&container_of(khva, struct gfn_to_pfn_cache, khva)->lock);
> +}
> +
> +#define DEFINE_GPC_CLASS(try, ro)						\
> +DEFINE_CLASS(gpc##try##_map_local##ro, void **,					\
> +	     if (!IS_ERR(_T)) gpc_map_local_unlock##ro(_T),			\

[Severity: High]
Does this guard expression properly handle NULL values, or could it lead to=
 a
regression?

Since IS_ERR(NULL) evaluates to false, !IS_ERR(NULL) evaluates to true. If a
user of this class manually sets the variable to NULL or uses a primitive
like no_free_ptr() to inhibit cleanup, the destructor will run and
erroneously execute gpc_map_local_unlock(NULL).

Inside gpc_map_local_unlock(), container_of(NULL, ...) will produce a large
negative pointer. The subsequent calls to kvm_gpc_mark_dirty_in_slot() and
read_unlock() will dereference this invalid pointer and cause a regression.

Would it be safer to use if (!IS_ERR_OR_NULL(_T)) instead?

> +	     gpc##try##_map_local_lock(gpc, len),				\
> +	     struct gfn_to_pfn_cache *gpc, unsigned long len)			\
> +
> +DEFINE_GPC_CLASS(,);
> +DEFINE_GPC_CLASS(_try,);
> +DEFINE_GPC_CLASS(, _ro);
> +DEFINE_GPC_CLASS(_try, _ro);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D11
