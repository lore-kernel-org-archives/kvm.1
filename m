Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098663;
	b=BVKn6MTMMRpvGoHzLIcoSp5vplVIs5vwj6MAMzCE+IH10Tw2Us97lWSjYQs73c2ToPpm
	 /f+tFQ700BAQc4hW1AveaxMciijT2cHb5xB3qHzysHodUEDgjlHHJsnhvwQlPqX9XssLw
	 u6vjZN/WfFXZEKH3ozLxbpTMFmIcCW19EnHcmOhbpN+4UcpEVcVbccv0m7l65oiAYrczn
	 xcZgXOOpxrfCkZcVcKh9bW9Pt1ralRAicdwx5UwL4HMIveegvyW9l7kDiDbVYSI7lGbUR
	 I3msCG3qAC1glfvBj01J+2uo5JLPNwvR4yXoE2y80/TCmbdevkD/h956cOk4DawSA6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GLAng9GU2q0DAhSwRoFsK3zaIaNi2hoXo+hI//Uk/Xk=;
	b=zOLx69bzckUQrjSzFJ46J12ztMWLghTn3ea4aznIDhXRd6K9jhY/H9f4J+IPgI0S9aeD
	 mhCiR1oWA4NE9VfV4zlDX+Wntb3umFVIwDhVMmVhUpMXW/OHNLolBNcmHJV12xLFu4Sdf
	 GFfXCUOQbB6UA6y495TpYsgiMhqpGFRR5/Yu0Im4UZHHFpqFo10wfNN1xBccIH1nwcJyx
	 vyn3XWQ2AR6RMfiqjWJ26qKdHtDqO07xsgUd4MGFkQ9HRnYiWgRzmhViIOti+Z5pLB4ij
	 qFLpbg9Z+jNx+4Y8yz2O9nt+2EWRta5oS/gEzcQy/dEhJrklNYKmdsyu4RXDSGaMG/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9x7Xwzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E881606D810
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9x7Xwzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E781F008A2;
	Sun,  8 Nov 2026 00:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098663;
	bh=GLAng9GU2q0DAhSwRoFsK3zaIaNi2hoXo+hI//Uk/Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9x7XwzvfE2FoAjufaWcAvibpkwt7zCH58rv+Vcmng/QxPVswQEfBl88BOWIqgu/z
	 NYTiAzrAfdtp/Rik5JdlTmukxN7C9mODZgg7jQy63kFJxDlaDr7JnYyV7jUiUim7XY
	 c9664m3PonLJXfYt71GzM4WbS95fTA77mqpY3bDDnmsbXVmWrFuVcorsWMb8UbtMgO
	 K5slUbND+WUR5A7xNlGCSM2e2kmgA7AxJqXm/O77wJpXUA2uuq4t98ouYHhBNGnXde
	 evCMysJz/YCd1+sm7KyFY1CRcRzv6ECBBniI5j8dI1U9bWMPWYT+AVzg07e0vkXztf
	 1PNHmVOJLTv9w==
Message-ID: <sashiko-outbox-203470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 59/88] vfio: Dispatch guest_memfd get_pfn
 provider op via vfio_device_ops
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-59-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-59-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:22 +0000
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
- [Low] vfio: missing kernel-doc entry for gmem_get_pfn in struct
  vfio_device_ops
--

commit aa1fa472e3013956533385442614d3f6291a86c8
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Dispatch guest_memfd get_pfn provider op via vfio_device_ops

This commit adds a gmem_get_pfn callback to struct vfio_device_ops and
wires up vfio_device_gmem_provider_ops.get_pfn to dispatch to it.

> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 65dc2cb523351..51e04b980a381 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -122,6 +122,9 @@ struct guest_memfd_provider_operations;
>  struct vfio_device_ops {
>  	int (*gmem_attach)(struct vfio_device *device);
>  	void (*gmem_release)(struct vfio_device *device);
> +	int (*gmem_get_pfn)(struct vfio_device *device, pgoff_t index,
> +			    unsigned long *pfn, int *max_order,
> +			    u64 *pfn_attrs);
>  	char	*name;
>  	int	(*init)(struct vfio_device *vdev);
>  	void	(*release)(struct vfio_device *vdev);

[Severity: Low]
struct vfio_device_ops has a kernel-doc comment block right above it, but
@gmem_get_pfn (along with @gmem_attach and @gmem_release from commit "vfio:
Dispatch guest_memfd provider operations via vfio_device_ops") is not
documented there, and the struct guest_memfd_provider_operations forward
declaration placed between the comment and struct vfio_device_ops breaks
scripts/kernel-doc parsing for the struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D59
