Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098673;
	b=DfmDKOiUZg1B+kHWyTC1I5dYZHS4hAunDLBzx+Hm9QaMPKpLX7wh5HBYFaNreWSRA091
	 0z/Ded68gJIoo9ORgUjH/ccM4mJqr1VhiPtuoj4uYiX6VKPhhQGkQxZLz19NadH/mZ0iz
	 qUYOoBgE4id8fdlYc+UoegRa6VMhwrIbe6QBbLFQTi2Ww/L0Q0KHE/Y3WfnIKigWI7YYh
	 Oqu/H4AFICA0e80enqhaaXIMsdMXf4Yui6Cf4ItiJBPvNRQQ/7Of42U8Iw8PRdtesoWy7
	 8fVOTbQTJqXxiFwnQWEmotjWnCQVXpzk3/cLz4iY3L6sOuTEj9/eQCAWEO0PS1X8t1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FYDflmfipi1PjLcDGCMu62uuoKoinLSLqz7eYoqq+KQ=;
	b=GhPWO8qpGM8/0C88wqz6a3IYLfXuAuPcGXcsSj+ZIYiXYCdwGG9v8qM6zWVCMwHx0mZ3
	 EzapYTgcWshW7Ver0LLoHM8E55MhogB4zYpjBsXxkGSRgzxLT2Gmq1s1SL7IoBLz/cYYH
	 j+lA2yqcQL/gr4z5wXYJPxr9h65VhMqK8TKoonGpzHXtWg6TT2FSGgkUXJI6zsnfHbqhj
	 Dq5StPA253CP8ReC5/hz8krvtf9BeT32yuxmLzG1Y4kx2pcRA1E5kI/xPxUc9mbWZd7ps
	 7k3o9OukY32KOqhffDKL6RvP5APmzNw20uJI5XsNtcGa5lXx5vkkE6yHJppKbg03nKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROnDo2up;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04179606D808
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROnDo2up
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D031F008A3;
	Sun,  8 Nov 2026 00:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098672;
	bh=FYDflmfipi1PjLcDGCMu62uuoKoinLSLqz7eYoqq+KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROnDo2upa0yparepTbW0CMUrMFlVNDpAMXV4nnDDtZ5aSls0t0S4WbIrCopMEAQO3
	 n4fcDVYvu2tYz31BvFH+Pz4lod5myGGr7GK1i2n2x6K5gvdN1GdaMDNmdoHGYx54aZ
	 zpQ9R7gxyOMgEDpM5WYJXtsNDaPpiybZlN6pBC3Y+oen6u3Y93MhJL572CUBiW45i/
	 SXfG4FPspabqXUCX655V3wv26QpLh2mY9o8eL313drTpnQH45ONM6zLHTjd7lO+pWV
	 cnYZM5cnTje5SOd4Y+4YfjGLg6Yu6vM/alHVAgfKsfg13Tq9OpIh9CbTtMTUabOXid
	 mdYE8LF6yNG+w==
Message-ID: <sashiko-outbox-203479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 68/88] vfio/pci: Use iov_iter for MMIO read and
 write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-68-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-68-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:31 +0000
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
- [High] vfio/pci: missing linux/uio.h include in vfio_pci_rdwr.c breaks
  build
--

commit 857abb2cc1a3ab7c6f488750b101680f17be6f5d
Author: Ackerley Tng <ackerleytng@google.com>

vfio/pci: Use iov_iter for MMIO read and write

This commit refactors the internal MMIO read and write helpers in
vfio_pci_rdwr.c to operate on struct iov_iter, while keeping
vfio_pci_core_do_io_rw() unchanged by wrapping user buffers with
import_ubuf().

> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> index e5f1f60513709..cc64722d1ab9a 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -91,34 +91,34 @@ VFIO_IOREAD(32)
>  VFIO_IOREAD(64)
> =20
>  #define VFIO_IORDWR(size)						\
> -static int vfio_pci_iordwr##size(struct vfio_pci_core_device *vdev,\
> -				bool iswrite, bool test_mem,		\
> -				void __iomem *io, char __user *buf,	\
> -				loff_t off, size_t *filled)		\
> -{									\
> -	u##size val;							\
> -	int ret;							\
> -									\
> -	if (iswrite) {							\
> -		if (copy_from_user(&val, buf, sizeof(val)))		\
> -			return -EFAULT;					\
> -									\
> -		ret =3D vfio_pci_core_iowrite##size(vdev, test_mem,	\
> -						  val, io + off);	\
> -		if (ret)						\
> -			return ret;					\
> -	} else {							\
> -		ret =3D vfio_pci_core_ioread##size(vdev, test_mem,	\
> -						 &val, io + off);	\
> -		if (ret)						\
> -			return ret;					\
> -									\
> -		if (copy_to_user(buf, &val, sizeof(val)))		\
> -			return -EFAULT;					\
> -	}								\
> -									\
> -	*filled =3D sizeof(val);						\
> -	return 0;							\
> +static int vfio_pci_iordwr##size(struct vfio_pci_core_device *vdev,		\
> +				bool iswrite, bool test_mem,			\
> +				void __iomem *io, struct iov_iter *iter,	\
> +				loff_t off, size_t *filled)			\
> +{										\
> +	u##size val;								\
> +	int ret;								\
> +										\
> +	if (iswrite) {								\
> +		if (!copy_from_iter_full(&val, sizeof(val), iter))		\
> +			return -EFAULT;						\
> +										\
> +		ret =3D vfio_pci_core_iowrite##size(vdev, test_mem,		\
> +						  val, io + off);		\
> +		if (ret)							\
> +			return ret;						\
> +	} else {								\
> +		ret =3D vfio_pci_core_ioread##size(vdev, test_mem,		\
> +						 &val, io + off);		\
> +		if (ret)							\
> +			return ret;						\
> +										\
> +		if (!copy_to_iter_full(&val, sizeof(val), iter))		\
> +			return -EFAULT;						\
> +	}									\
> +										\
> +	*filled =3D sizeof(val);							\
> +	return 0;								\
>  }									\

[ ... ]

> +ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool t=
est_mem,
> +			       void __iomem *io, char __user *buf,
> +			       loff_t off, size_t count, size_t x_start,
> +			       size_t x_end, bool iswrite,
> +			       enum vfio_pci_io_width max_width)
> +{
> +	struct iov_iter iter;
> +	int ret;
> +
> +	ret =3D import_ubuf(iswrite ? ITER_SOURCE : ITER_DEST, buf, count, &ite=
r);
> +	if (ret)
> +		return ret;
> +
> +	return __vfio_pci_core_do_io_rw(vdev, test_mem, io, &iter, off, count,
> +					x_start, x_end, iswrite, max_width);
> +}

[Severity: High]
Does drivers/vfio/pci/vfio_pci_rdwr.c need to include <linux/uio.h>?

struct iov_iter, ITER_SOURCE, ITER_DEST, import_ubuf(), iov_iter_advance(),
copy_from_iter_full(), and copy_to_iter_full() are defined in linux/uio.h,
while linux/fs.h only forward-declares struct iov_iter. On x86_64 with
CONFIG_IA32_EMULATION=3Dy, linux/uio.h happens to be pulled in transitively
via asm/ia32.h -> linux/compat.h, but builds on architectures such as arm64
(or x86_64 with CONFIG_IA32_EMULATION=3Dn) fail with an incomplete type for
struct iov_iter and implicit function declarations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D68
