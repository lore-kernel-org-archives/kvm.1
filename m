Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7B37F8B0
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406391; cv=none; b=LvgrhypeiaPf9wSucW/KKIF41kRgJrLNC2A0UtwQKVmGEYC1lyBOmkHWtmtKxyekGzjk88x2FKxVWSD2WDszSOg2Np7ewao7+DN4ntaSvmyW0KNDNStbdLNayniQschjnoAc3p/LpCv+aIz5OHJcq+FYzksij2SQxJHa7NZzTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406391; c=relaxed/simple;
	bh=AjhfEKfJnxbpx7iSwIohkMv8+SwNLShxEj3M5sjq250=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg2RaJTlcp6u2TxG2ppvBPV3X0fJLflBdgyxCLrj4UbpVHDIo6WSRCfMuPD8yiYsTkmNwACF+1F2w21ZowG26LwGSF/tfOv131NEkvAqrqFBFZYRbS0lFNa+fUvDqQMbFSruyD3prf8C+PhpKKtsvjWg1RI7/yib4GN7cN7goqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5FapgLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5FapgLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D03DC2BC86;
	Fri, 13 Mar 2026 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773406391;
	bh=AjhfEKfJnxbpx7iSwIohkMv8+SwNLShxEj3M5sjq250=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5FapgLtiay0paa9PPbTUZtDwyh9cBMsHwRLMqwsDolS9v3sB5C7Zu96DSn9olPN/
	 VyJKI4tjy9vvTxAorETQan+ZpweP1NyOqXlvA1Bi4VwpnZmuOo2Y6MMXEfeF/xZ1CL
	 PCNW9eo4t7fMg+tEKH8HxAjY9j5khfOyLykWyPvLivEirVU0JoCftCUGRKmOD5H0qx
	 /vNrNbAo/pe07vXwOsw3HoXiqPa05PTtF5MowJ5v/NKKEQ/BhGG7Jjmhw4fRQIWGbb
	 AZEje03o9E/4a4k/Uk9T1Sx28aPjYoA9pVRcLka162aT+S35j4z3DPsfmv/lYNM5BJ
	 4VAftMQIYEv7Q==
Date: Fri, 13 Mar 2026 12:53:06 +0000
From: Will Deacon <will@kernel.org>
To: hbuxiaofei <hbuxiaofei@gmail.com>
Cc: kvm@vger.kernel.org, julien.thierry.kdev@gmail.com, mst@redhat.com
Subject: Re: [PATCH kvmtool 1/1] linux/virtio_pci.h: Include kernel.h to
 provide the __KERNEL_DIV_ROUND_UP define
Message-ID: <abQIsndYnBk3VC1c@willie-the-truck>
References: <20260227004224.269441-1-hbuxiaofei@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227004224.269441-1-hbuxiaofei@gmail.com>

[+mst]

On Fri, Feb 27, 2026 at 08:42:24AM +0800, hbuxiaofei wrote:
> GCC Version:
>   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
> 
> CC       builtin-balloon.o
> In file included from include/kvm/pci.h:7:0,
>                  from include/kvm/vfio.h:6,
>                  from include/kvm/kvm-config.h:5,
>                  from include/kvm/kvm.h:6,
>                  from builtin-balloon.c:9:
> include/linux/virtio_pci.h:326:2: error: implicit declaration of function ‘__KERNEL_DIV_ROUND_UP’ [-Werror=implicit-function-declaration]
>   __le64 supported_caps[MAX_CAP_ID];
>   ^
> include/linux/virtio_pci.h:326:9: error: variably modified ‘supported_caps’ at file scope
>   __le64 supported_caps[MAX_CAP_ID];
>          ^
> cc1: all warnings being treated as errors
> make: *** [builtin-balloon.o] Error 1
> 
> Signed-off-by: hbuxiaofei <hbuxiaofei@gmail.com>
> ---
>  include/linux/virtio_pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
> index e732e34..fb2f66a 100644
> --- a/include/linux/virtio_pci.h
> +++ b/include/linux/virtio_pci.h
> @@ -39,6 +39,7 @@
>  #ifndef _LINUX_VIRTIO_PCI_H
>  #define _LINUX_VIRTIO_PCI_H
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/const.h>

Hmm. This header is imported directly from the kernel sources, so it
doesn't make sense to patch it by hand as changes will be overwritten
next time we run util/update_headers.sh.

Looking at the kernel history, 205dd7a5d6ad ("virtio_pci: drop kernel.h")
suggests that linux/const.h is sufficient for __KERNEL_DIV_ROUND_UP, so
we probably just want to copy that header over (e.g. like the diff below).

Will

--->8

diff --git a/include/linux/const.h b/include/linux/const.h
new file mode 100644
index 0000000..b8f629e
--- /dev/null
+++ b/include/linux/const.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* const.h: Macros for dealing with constants.  */
+
+#ifndef _UAPI_LINUX_CONST_H
+#define _UAPI_LINUX_CONST_H
+
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specifiers unilaterally.  We
+ * use the following macros to deal with this.
+ *
+ * Similarly, _AT() will cast an expression with a type in C, but
+ * leave it unchanged in asm.
+ */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#define _AT(T,X)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _AT(T,X)	((T)(X))
+#endif
+
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
+
+#if !defined(__ASSEMBLY__)
+/*
+ * Missing asm support
+ *
+ * __BIT128() would not work in the asm code, as it shifts an
+ * 'unsigned __int128' data type as direct representation of
+ * 128 bit constants is not supported in the gcc compiler, as
+ * they get silently truncated.
+ *
+ * TODO: Please revisit this implementation when gcc compiler
+ * starts representing 128 bit constants directly like long
+ * and unsigned long etc. Subsequently drop the comment for
+ * GENMASK_U128() which would then start supporting asm code.
+ */
+#define _BIT128(x)	((unsigned __int128)(1) << (x))
+#endif
+
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+
+#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
+#endif /* _UAPI_LINUX_CONST_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index df42d63..6c22f1c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -8,9 +8,6 @@
 #define round_down(x, y)	((x) & ~__round_mask(x, y))
 
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
-#ifndef __KERNEL_DIV_ROUND_UP
-#define __KERNEL_DIV_ROUND_UP(n,d)	DIV_ROUND_UP(n,d)
-#endif
 
 #define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
 #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
