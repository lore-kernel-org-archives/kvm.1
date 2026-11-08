Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098674;
	b=qsu9N7w2nz0EbJ5l6ILkYVO5IYGNV5q6+nDH1JNRYwhvfGhK4hSw0QSpPcEP1qfLxi9s
	 0joBs/3giSziDnxSFHz1Hpxmqz9PGrbZQSUSCBul4sakTqRJRHWArp+Qux5psI+3D5u39
	 4Wr36DAAwaGmI8ZmRxPLaLJaUsBDAoN12Jj3DgSjNlKm+0GVPjEZLytU8RNwE6hBf3/8e
	 P7WUOSb0/lQ1kucSFY4eFSG7n0GCi4spySE1zQ8CVhylkK/ldnm/WTHa4p5rk9LxHoMQO
	 G9zG+d5bP7FBg3/vrSNTKyD8n1UdibObD0eCjLO/U1GomqVBhP5v4nkc5Az0VfJ3KGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RmJ7M5blQgPkbOX5TxgxTr5nIo11N9om45iOa6C2Vkg=;
	b=fFSP5B6rjWNiu80NmOLf7GoVg+iX0RdBmZBa8Z6s52A7BJmVWMD9Jv18L5BRWipyf+fq
	 9bXM5Cl7UaoSq2Wh9bqM84XXr9OQGoFrja/yODd1liT+GA+lqsO8E1D6e+tI7hcPnCxGc
	 Uo1W8tixSN+OEXTUp2MZkzfJoJfSsgXRJPpoqiyn87SEbZhU47Yg9s5fznrIwvTmjR5K+
	 OCv9Gb28j1yOz2moLq4BVjj20FrrBf52lE/OMzkkpR8Hs+sb4AlXiNChsdhdLiBQ4oKUa
	 ruYuBBDY9ByO68rKf5CMtWZHzCckfibHrJJXnPXBL4alFJBkZQRmHnM9bB6WDOCrAaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyjKx80N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D666606A331
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyjKx80N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657391F008A1;
	Sun,  8 Nov 2026 00:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098674;
	bh=RmJ7M5blQgPkbOX5TxgxTr5nIo11N9om45iOa6C2Vkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KyjKx80NzW7hR0AOJO5TecuHZDm4+kHqkWhd3wh/cikDNlwYq7UuehUENlT5VvGml
	 51T6arQNg3tui+MEgdfVbZLsPAUKbhbjPxNEUAP2HSmD6YNMO228pR1/i9F3ZPcFlS
	 8Ne1EuVQmlPDtlwwirP8xa91grh76JGNip1BTePfD3myMj1W14aKoNe1wHRx8L6Iu3
	 ihwJLpdJmP/hP6iK71fRoJ5ls12dTAfLbKCvdUKUDuWGA0T0H0hnCFELotgiD0jjGa
	 EtN2XJmsuubSnQOa0NPb+VUTiZe+s2VfnyK+Ody/GS0jkCXeFoUcGAhHQThU3PUiyi
	 bniB0Jkhg+EEA==
Message-ID: <sashiko-outbox-203480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 69/88] vfio: Dispatch guest_memfd read and write
 provider ops via vfio_device_ops
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-69-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-69-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:32 +0000
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
- [Low] vfio: missing kernel-doc for gmem_read and gmem_write in
  vfio_device_ops
--

commit 1e0b7bdc6352dbf69f404e2847472ddba12fa151
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Dispatch guest_memfd read and write provider ops via vfio_device_ops

This commit implements the .read and .write callbacks on
vfio_device_gmem_provider_ops to dispatch data-plane reads and writes to
the bus driver's .gmem_read and .gmem_write callbacks on struct
vfio_device_ops.

> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 8022adedc26a6..012a233a375ab 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -130,6 +130,10 @@ struct vfio_device_ops {
>  					 u64 attributes);
>  	int (*gmem_lookup_pfn_range)(struct vfio_device *device, pgoff_t index,
>  				     unsigned long *pfn, size_t *nr_pages);
> +	ssize_t (*gmem_read)(struct vfio_device *device, void *buf,
> +			     size_t count, loff_t *ppos);
> +	ssize_t (*gmem_write)(struct vfio_device *device, const void *buf,
> +			      size_t count, loff_t *ppos);
>  	char	*name;
>  	int	(*init)(struct vfio_device *vdev);
>  	void	(*release)(struct vfio_device *vdev);

[Severity: Low]
Should @gmem_read and @gmem_write be documented in the kernel-doc comment
above struct vfio_device_ops?  Without descriptions for these new members,
scripts/kernel-doc warns about undocumented struct members under W=3D1
builds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D69
