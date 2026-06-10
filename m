Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EE23E33D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053520; cv=none; b=A+hIn87j37wK2L+JEJFxJT9vBJNmumWS4QbU5Tge7yVhI41zGyRlT9OHlPA2TiDmJictcd+ZNuuLOwyRyfVWgG8BebZTkQWBXqqNVzfjtqZ1MuHLyZrEXDpLXcCZ/eQ5bbWLmOAH9VTom0gRmkeydOV/64XBfveTi8shii7rK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053520; c=relaxed/simple;
	bh=piiyC9M18SpUnABaQZHzRm7dCIZj+EB7/naJs7sHSfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJXrm1iR8AvGJILNhvkxd/vBrcO+YTKCprN9qGafj9m5Y3tUilLx9mYqOk7iUJhIXmJhHtndQ4Pbp7Z6iNKjSGZZOdnLyt/6XwNcIk9EgIFO5qDUH/Yb+o2s0R4/SLQY57oLhbTzStWNgu/yT2rrCtEyuVfM3qdZN03bNyFDLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyqV2lOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyqV2lOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1333F1F00893;
	Wed, 10 Jun 2026 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053517;
	bh=r21NDtjf/tdgr6noH0bXBBlZFURQ3RpcFLiqamF4NiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyqV2lOGK7LALoPdN+3ajFgSmVGFn8nJv4KnNeVGRkM1RTHcysBLk3Q2j2Zrl6W4l
	 oZpo4C93fzSQ/QCmUbrzY4gUeGpDZNxi3p553lj2IAYIKwveY2+yl1aT0zF3fuqw7F
	 JdAHWgWsxANA6dTeMiGdHy3yIICy+AznfZjPoK+CBiGtVw3RDfQGOqJ/q3tGMcrbXX
	 Vn9k4BKLOGgAMvrYUcp6+Jy2Uqgz0g1NOQ4OHWOYPzbi+A0j6vMNd6vwy2eV9Bfifd
	 gS75HQivsL/Oss6cNM0GsxpeAtWnYzHLzSgBSdAY+8ARcog6COxKGizWvwqm0ERhKg
	 7q+3OxesntRCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/18] KVM: selftests: Add VFIO device support to
 eventfd IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-8-seanjc@google.com>
References: <20260610005338.2967132-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:05:16 +0000
Message-Id: <20260610010517.1333F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `probe_iommu_type()` incorrectly checks for the existence of the=
 `/dev/vfio` directory instead of the `/dev/vfio/vfio` character device, ca=
using the test to fail instead of gracefully skipping on systems without VF=
IO.
--

commit f5addd74013c3a4a3fb4fedd4bad238886d29e95
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Add VFIO device support to eventfd IRQ test

Extends the eventfd IRQ test to support triggering interrupts via a VFIO
device instead of manually signaling the eventfd. It also introduces logic
to auto-probe between IOMMUFD and legacy VFIO.

Link: https://lore.kernel.org/all/20260602222941.3133236-1-jrhilke%40google=
.com [1]

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 9f8895b898214..6888be54ee4a9 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c

[ ... ]

> @@ -74,11 +107,29 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi=
, struct kvm_vcpu *vcpu,
>  	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
>  }
> =20
> +static const char *probe_iommu_type(void)
> +{
> +	int io_fd;
> +
> +	io_fd =3D open("/dev/iommu", O_RDONLY);
> +	if (io_fd >=3D 0) {
> +		close(io_fd);
> +		return MODE_IOMMUFD;
> +	}
> +
> +	io_fd =3D __open_path_or_exit("/dev/vfio", O_RDONLY,
> +				    "Is VFIO (or IOMMUFD) loaded and enabled?");
> +	close(io_fd);

[Severity: Medium]
The commit message states that the test will auto-probe IOMMUFD vs legacy
VFIO and skip the test if neither is available. However, probe_iommu_type()
calls __open_path_or_exit() on /dev/vfio.

Because /dev/vfio is a directory, open() with O_RDONLY will succeed if the
directory exists (e.g., created by udev or left over after a module unload),
even if the VFIO module is not loaded and the character device is absent.
Opening a directory does not trigger the kernel's character device module
autoloading.

If this occurs, probe_iommu_type() incorrectly assumes VFIO is available and
returns MODE_VFIO_TYPE1_IOMMU. The test then calls iommu_init(), which atte=
mpts
to open /dev/vfio/vfio and will fatally abort, resulting in a test crash ra=
ther
than a clean skip.

Additionally, using __open_path_or_exit() will cause the test to exit rather
than skip if the path does not exist.

Should this probe instead check for the /dev/vfio/vfio character device and
use open() instead of __open_path_or_exit() to allow the test to gracefully
skip and trigger module autoloading?

> +	return MODE_VFIO_TYPE1_IOMMU;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D7
