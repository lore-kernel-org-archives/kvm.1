Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098662;
	b=l9cSGhIo29r1Z+iI8bEatzjv2K0NINADXk2u2xOPBtXxJt8vbnHLawNDSLvGf7vL+HwF
	 wNdSCJ14xwTAYkiGtCGPOw24Gaabuph9EUREnc3cycGlh5dSNq3FIfkgZlxMobW7bUfrC
	 5iXcd0BI7wq+X7IlSwXlPUlEsESx5800i1AaU7C/z4Ma1kQ2ZXNCNUzrNm2iLKAVkjSIM
	 pwpzhPi2jHiIWUYOiIsnqPlweR3BEo0u2ScrZUf0chR8QAPiRaVM3LA/bibcVcNE1RHWk
	 n0SjaKT8GQJh+JIcVdBN4XhbRnNMxVPBnJQFOlIBlS+uLEFd9Q0M+cZK3V3wmJ9YK5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2dNPdJpPL73VkFeXaGLHTmJbbYE7hZ1MglU2xGcUkII=;
	b=lf8ej2yRLw5u9oPwVLLYAEZvT2Xz+zwdzXzXDALUBmHfnHykgIJ7MTyT0Vme8Ypin1lI
	 pZoHRxV+wyXvZNfg4cjJBLKlZNJrbxYEp5LykAYDmPLEdnGA+6lwjwh9V4D9HPFuTYcRg
	 rJFjcc5s2U3rPnwWOkKA6jIdttpxRuB13uk+TKN+S2D630RODuIJdLCQyl69BGQ96G/xw
	 +DcbtvcCA9tL8tj1QlKffh9ytpy5XFq/Pw34NnnbldIVeIJG2eZ50spTEgGaojVofY1bc
	 YzzwOe/9Ooyv/XN4vtxGv/Y5ccIr4C0CoItm8+6hNSIPehJjPsHaTAG+nlYN1uLtTtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIxgKo1a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CC606A32E
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIxgKo1a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBECC1F0089F;
	Sun,  8 Nov 2026 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098661;
	bh=2dNPdJpPL73VkFeXaGLHTmJbbYE7hZ1MglU2xGcUkII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIxgKo1aFSfUEsfUUqgav/Km2q+VyJ2XmbnJPwdON1Sf6HlTlKrFqGWa4H+OO4QXE
	 Rv98OIyylzXcUi0kboCu9MukVPmds0vJTERDAGA3V3NbJI1j6wOCaDjJajoblbFYNZ
	 FzJ7KbumKvCrkdohOp1CfzPrVdFsqWG/miWHJnuFNN0YS2dWXkLK9QHEFSuIqAFpsw
	 CfC7AX0a490baUnF+HJbTuwa8+Qe+96CqfQ8bykUnleL1icX5to4pJzzRlj5wZKU2R
	 E51+F+sTVsJ0S6Pg2QuzGF7v3hNuuaS0+P8aJr8zknDISaF9gegixK7ZV9Mny1sknt
	 lPY28q8Br0Xuw==
Message-ID: <sashiko-outbox-203468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 57/88] vfio: Dispatch guest_memfd provider
 operations via vfio_device_ops
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-57-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-57-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:20 +0000
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
- [Low] vfio: stray forward declaration before vfio_device_ops breaks
  kernel-doc
--

commit cc851a01b26fbe73cfc6ac69613c43e8df1f4787
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Dispatch guest_memfd provider operations via vfio_device_ops

This commit implements guest_memfd provider operations on vfio_device_fops
and adds gmem_attach and gmem_release callbacks to struct vfio_device_ops.

> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index c81373ddf2a9c..65dc2cb523351 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h

[ ... ]

> @@ -114,7 +117,11 @@ struct vfio_device {
>   *             this device is attached to.
>   * @device_feature: Optional, fill in the VFIO_DEVICE_FEATURE ioctl
>   */
> +struct guest_memfd_provider_operations;
> +
>  struct vfio_device_ops {
> +	int (*gmem_attach)(struct vfio_device *device);
> +	void (*gmem_release)(struct vfio_device *device);
>  	char	*name;
>  	int	(*init)(struct vfio_device *vdev);
>  	void	(*release)(struct vfio_device *vdev);

[Severity: Low]
Does placing struct guest_memfd_provider_operations between the kernel-doc
comment and struct vfio_device_ops break kernel-doc parsing for this
header?

scripts/kernel-doc stops collecting the prototype at the first top-level
semicolon after a kernel-doc comment, so it tries to parse the unused
forward declaration as the struct definition and fails with "error: Cannot
parse struct or union!".  In addition, @gmem_attach and @gmem_release are
not documented in the struct vfio_device_ops kernel-doc comment above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D57
