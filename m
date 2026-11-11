Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434792;
	b=Jhta2Bp7yySW7EWjhFyExqLceLU3j8Tc8xTrw83Hgbwfv88v+4SugewPZ3TQDmG2V7rE
	 MlrrD5LRY924XQ4xqCKzUS5Qe9NuH7kfn/cefDwFSxp8lBPTBOq5tcRCWGr7FqYWas4SS
	 8OiumtIiN3A5l1fbY2y3OzisrEMTnQ10ppjEqrndodbir62n3f3nUorv/NV8R1Ol7CkBj
	 sqPv3ai7hylS2Sr7zuOXXeaXb3o0/6VZpvr4/2E426LF2qXOqOR9dM8K69g+8mTjr8LIm
	 ZrYB/q1igX8OxqOolKL+m9CQaJA/KFAC76jIfpnLzrZYQMFl5q6hkp495Kgb30XPYfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ESjAgXHs3Gy0KvjqbGvuDJ/IGAgiy7CMa+zEJkbGQcU=;
	b=c6OPSnfkcMlKH02NYa4hQI/Iei1GPxjyNSrpzCYovR+1dvjRlyAM4Ug8FMuhP+Dv8PHa
	 zXLvU35O3U9Dh/qQD52ICsyC9pGzg5D9nAFyBJ4pr1gj95n9TOtXl6Wx9xoWbjec7BdhC
	 9laLuta87I5Z8bFnEv6hQ3+EQIjeOrEKVP90OBTkSiGdWFXkeWypEb3a8kA3yx5RDd9vB
	 NyKf8R6Yp5poxurTSKFbahXbEqbCndSHblTddomuLCqLg6gk/BcDJbs8K/jUXAuXjVyyt
	 qUcpkQh/fhb3ZenLK+VYkbnD4YFnd2dk8cdEeK6TgGuAps8T9IUXAA9NCuHsSiP0OJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djGIBgjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B624606A880
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djGIBgjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30711F00A07;
	Wed, 11 Nov 2026 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434791;
	bh=ESjAgXHs3Gy0KvjqbGvuDJ/IGAgiy7CMa+zEJkbGQcU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=djGIBgjwwZSetpsRBnlymJqgmi8JzFxrocKHSSk//a+5T10Sh3ulukTGUaB0sS0ax
	 yGpY4m4cMVCumprp5NwsW+k1cgIfDtymck2P7/UbuQVR8XNxBjBnYRccEpz9UtPrC7
	 iF27ic5DrSyJ5Kr96P+O5lMCwRRg+KUZsq7eY4p6s9FwJzpXLK+RUvt2n+bce8L9y5
	 gPhkMqpstn3tc+uY1nhl1ejOUBeFtf0/lQOOJ5er5CrJeeVU2+pK7aRTB9RtxjHKkG
	 aERLVL7mBxo0UJV8CxX1vuPLEtB80igHuhoGREfE5+Z/H5j8lvfzzx5Zmefdh8kT+P
	 /2RtDu9733+cg==
Message-ID: <sashiko-outbox-209744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 14/26] UAPI: x86: Move pvclock-abi to UAPI for x86
 platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261111180922.4177927-15-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
 <20261111180922.4177927-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:06:31 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] x86/xen: missing asm/types.h in xen-hypercalls.sh truncates
  xen-hypercalls.h
--

commit 02c9335f9071a6232c46010946be3c3ff37343b0
Author: Jack Allister <jalliste@amazon.com>

UAPI: x86: Move pvclock-abi to UAPI for x86 platforms

This commit moves arch/x86/include/asm/pvclock-abi.h to UAPI so userspace
can access struct pvclock_vcpu_time_info, switches its field types to UAPI
types via linux/types.h, and passes -D__KERNEL__ in
scripts/xen-hypercalls.sh.

> diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/uapi/a=
sm/pvclock-abi.h
> similarity index 82%
> rename from arch/x86/include/asm/pvclock-abi.h
> rename to arch/x86/include/uapi/asm/pvclock-abi.h
> index b9fece5fc96d6..6d70cf6403629 100644
> --- a/arch/x86/include/asm/pvclock-abi.h
> +++ b/arch/x86/include/uapi/asm/pvclock-abi.h
> @@ -1,6 +1,9 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  #ifndef _ASM_X86_PVCLOCK_ABI_H
>  #define _ASM_X86_PVCLOCK_ABI_H
> +
> +#include <linux/types.h>
> +
>  #ifndef __ASSEMBLER__

[ ... ]

> diff --git a/scripts/xen-hypercalls.sh b/scripts/xen-hypercalls.sh
> index f18b00843df3f..51a722198997d 100755
> --- a/scripts/xen-hypercalls.sh
> +++ b/scripts/xen-hypercalls.sh
> @@ -5,7 +5,7 @@ shift
>  in=3D"$@"
> =20
>  for i in $in; do
> -	eval $CPP $LINUXINCLUDE -dD -imacros "$i" -x c /dev/null
> +	eval $CPP -D__KERNEL__ $LINUXINCLUDE -dD -imacros "$i" -x c /dev/null
>  done | \
>  awk '$1 =3D=3D "#define" && $2 ~ /__HYPERVISOR_[a-z][a-z_0-9]*/ { v[$3] =
=3D $2 }
>  	END {   print "/* auto-generated by scripts/xen-hypercall.sh */"

[Severity: Medium]
Does scripts/xen-hypercalls.sh fail to find asm/types.h on a clean x86
build with CONFIG_XEN=3Dy, producing a truncated
arch/x86/include/generated/asm/xen-hypercalls.h?

When scripts/xen-hypercalls.sh preprocesses include/xen/interface/xen.h, it
pulls in asm/xen/interface.h -> asm/pvclock-abi.h -> linux/types.h ->
uapi/linux/types.h -> asm/types.h before the __HYPERVISOR_* definitions in
include/xen/interface/xen.h.  On x86, asm/types.h is generated in
arch/x86/include/generated/uapi/asm/types.h by the uapi-asm-generic target,
which is a prerequisite of asm-generic.  However, scripts/xen-hypercalls.sh
runs during archheaders, which archprepare orders before asm-generic
without a dependency on uapi-asm-generic:

Makefile:
archprepare: outputmakefile archheaders archscripts scripts include/config/=
kernel.release \
	asm-generic $(version_h) include/generated/utsrelease.h \

Because the pipeline in scripts/xen-hypercalls.sh ignores $CPP failures, the
build continues after $CPP aborts on missing asm/types.h and writes a
xen-hypercalls.h containing only HYPERCALL(mca) from xen-mca.h, which leaves
xen_hypercall_name() in arch/x86/xen/trace.c unable to resolve standard Xen
hypercall names for tracepoints.

Having archheaders depend on uapi-asm-generic (or avoiding the linux/types.h
dependency when preprocessing the hypercall headers) would ensure
asm/types.h is present before scripts/xen-hypercalls.sh runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111180922.4177=
927-1-dwmw2@infradead.org?part=3D14
