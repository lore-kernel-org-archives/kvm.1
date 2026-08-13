Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FE42C505
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633214; cv=none; b=Cuxxoyq8ex+BnPPiNiaJa+pGqRLWrxU56TILFM1aoH9Y5m6nk9pE+YpAavl9GuLlCXOxsiDkjxo5cd0jQ7/17vR87qMLfkltokNOMtISVHdjZyW3iZLWwkkLaKdgqqEK1pnpcdHH+HBKJlx5uDWWqaPw35uBvD/2DlssrZYo59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633214; c=relaxed/simple;
	bh=zlpuBNvhEWlH4yvzKgyw1eRO1rsqYEg+EtN5KWY+PAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m93XISZvHlBa/Axac/pWkIa/NVcBnoW2mWTrkjIlKbf9IalmvCMtp+n75ar3KPihCi9Mdiy1l+0ZvToga5AZQMUNEs8hFNG4LHYXgyXl9RCdQivqbih8hcLBBg1gVw33yysYmnaug07V3jxgr5OU8B8I574kDWQ4+VsD8U5uHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJAA6g66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJAA6g66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3091F000E9;
	Thu, 13 Aug 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633207;
	bh=zlpuBNvhEWlH4yvzKgyw1eRO1rsqYEg+EtN5KWY+PAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJAA6g66YPZ2/wBrsxr0bK+Chaudalh+E4tWcRxSTsxWwGkpYtSw4uc6Y1/ZppQ9C
	 Ej3WuHolgsmPJWmlXAQhw3Eef1f2J//UmWjsHnBSF4Hz47UxyGgZigjfZlcbP49xTJ
	 v3adz0XCnP1CYGJQNPV5s+dnOgc8eDf/ryq1DEFeK9IWaZb7PCi0KL3H9oROxPH+hp
	 y5DcnlcXCxofYQSRFTIrZlOzk0/YjOpdGlTfXc1AJVPbRvxaz4S0iRhCtLTOZxCsQv
	 Fnzz4AKyU8+v1jtAzQK6EvQuV+Bdj2B587mxyaYGWW+YRGU10FkMHWF2J4xbF/U+mg
	 5lognXJTceDew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] net/mlx5: Extract MLX5_SET/GET macros into
 mlx5_ifc_macros.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
References: <3-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:00:06 +0000
Message-Id: <20260813150006.EA3091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly extracted `mlx5_ifc_macros.h` header lacks necessary incl=
ude directives for the types and macros it uses, violating the kernel's sel=
f-contained header rule.
--

--- Patch [3]: [PATCH v4 03/10] net/mlx5: Extract MLX5_SET/GET macros into =
mlx5_ifc_macros.h ---
commit 76e6552b0716c94811acb9f5971adc7809d4dee0
Author: Jason Gunthorpe <jgg@ziepe.ca>

net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h

This commit extracts the MLX5_SET/GET macro family from device.h into a new
standalone header, mlx5_ifc_macros.h. The extraction allows VFIO selftests
to use these macros without pulling in the dependencies of device.h.

[ ... ]
> diff --git a/include/linux/mlx5/mlx5_ifc_macros.h b/include/linux/mlx5/ml=
x5_ifc_macros.h
> new file mode 100644
> index 0000000000000..d357acfd351de
> --- /dev/null
> +++ b/include/linux/mlx5/mlx5_ifc_macros.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2013-2026, Mellanox Technologies. All rights reserved.
> + *
> + * Accessor macros for mlx5 IFC structures.
> + *
> + * Extracted from device.h so that code which cannot include device.h
> + * (e.g. selftests) can still use the MLX5_SET/GET family directly.
> + */
> +
> +#ifndef MLX5_IFC_MACROS_H
> +#define MLX5_IFC_MACROS_H

[Severity: Low]
Does this new header need to include its dependencies such as <linux/types.=
h>,
<linux/stddef.h>, <linux/build_bug.h>, and <asm/byteorder.h>?

Since the commit message mentions this header is intended for independent u=
se
by VFIO selftests, without these includes, files that include this header
directly might fail to compile due to missing definitions for u32, offsetof,
BUILD_BUG_ON, and cpu_to_be32.

> +
> +/* Internal helpers -- 32-bit */
> +#define __mlx5_nullp(typ) ((struct mlx5_ifc_##typ##_bits *)0)
> +#define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v4-021df3fb5a3f+9=
8e-mlx5st_jgg@nvidia.com?part=3D3
