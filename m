Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098677;
	b=3J57SnT63Y/KsHHZR2UTj6HrFswjSeDeuaTbgMaiPlvIoysy+fOpqEFs0Ki3Pqm3DUrl
	 Y2xMPu3sFwen1wkmnpm9WfPSohqEes+As9Jm+hIgI+buV9EaQ4euswyIWYTmyoRAwYWHM
	 BfGNEJBZdfESwZ2Ct0ohfVimtxSFA6mV2KJ9cktK0Po+1NkBOF+CpRt15JOf6e/e4ywse
	 cm6mbaOme1vKPeCapz5XzbRjrIaca2TKkVUyPkZ/BgP4WIDK4BFbhU5LFFmm2MjpCUXv9
	 DvU80eFwhFHJAypto9xPUo0qVLxxG3kI+BtCZuE1bnbEuW0+Ux8Q6QMMMOz2AtP07ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098677;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0FjExzab0Z/hM4O7U69ttoJFEAdHA5oTfFDTRTjZy7k=;
	b=K+XsJUeuvqwHclRn/IYFQbOShHGoYXpynvzqYw0hfB1P5tT4vnMHGB3WCCBHLCpc1Rms
	 rJZPAqzVGlVKRnw30kOXW9jpQHS/YVEdPv83DreaD4KlMv9gVWNIJZii8D7SLnsISxJw8
	 xkZgSuS7xxRDqXeFXlbCotZkruKiHh8vIQ+1a6u/4lpVyb6e5GB8KBLvO35hGF7lNc9B7
	 2QDwWUhr9k+hqWxTTtDQaWyEjWT9atE5oSekQ8KjAvf+9TgSrEgckKAoU8fc32SSuedYL
	 mHO3M2cNRBl1ZvWAB2uj7XJg0k8KzAGGDab7rBRm/noXesKKLaV6oikd/EdrlDfd27A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLLG5k+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414E606D813
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLLG5k+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262801F0089F;
	Sun,  8 Nov 2026 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098677;
	bh=0FjExzab0Z/hM4O7U69ttoJFEAdHA5oTfFDTRTjZy7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLLG5k+V9m5YUrEVXkSiiZDNoV3sy3GY4PGnHfdHwozpuBAq6Biz9qC9BkwjLyBb1
	 gr7byvzLiRK9VWpZNIg/6U97K7WGh13xHzFcKDRzO+ZnbSqB19hA4Z26+bsIHSVeS8
	 pgBw7lB5p/1oSejZJg0V/iGsf5xpbgAj5rDJGb9LPCRWzuM9xExnMOgNiXc3JqCz3S
	 kH94LNDx0jwZ3AeAUqKRumsuDJYVMvlwdQ793HDfew5MSIPMEhCJ7u/VJ6ARIc05Ta
	 O9NWxIwMeQvYFmlnDE+auEWajfRksxsvnA0zB4FnJ9sdkb2VmSqwrc226RpoW+BxEP
	 GG4TqOtjU4t7A==
Message-ID: <sashiko-outbox-203483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 72/88] KVM: selftests: Add initial VFIO test
 verifying device info
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-72-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-72-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:35 +0000
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
- [Low] KVM: selftests: missing cdev availability check in
  find_igb_cdev_path()
--

commit f49eda30798c7be85f256d365f245ff1c80a3c8c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add initial VFIO test verifying device info

This commit adds a standalone KVM selftest that opens an Intel 82576
VFIO cdev, binds it to iommufd, and verifies the device information
returned by VFIO_DEVICE_GET_INFO.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/to=
ols/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> new file mode 100644
> index 0000000000000..669acc6058b5b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c

[ ... ]

> +static char *find_igb_cdev_path(void)
> +{

[ ... ]

> +		/* Found an Intel 82576 device. Check if bound to vfio-pci cdev. */
> +		snprintf(path, sizeof(path), "%s/%s/vfio-dev", sys_pci, dev_entry->d_n=
ame);
> +		vfio_dir =3D opendir(path);
> +		if (!vfio_dir)
> +			continue;
> +
> +		while ((vfio_entry =3D readdir(vfio_dir)) !=3D NULL) {
> +			if (strncmp(vfio_entry->d_name, "vfio", 4) =3D=3D 0) {
> +				snprintf(cdev_path, sizeof(cdev_path), "/dev/vfio/devices/%s",
> +					 vfio_entry->d_name);
> +				closedir(vfio_dir);
> +				closedir(dir);
> +				return strdup(cdev_path);
> +			}
> +		}
> +		closedir(vfio_dir);
> +	}
> +
> +	closedir(dir);
> +	return NULL;
> +}
> +
> +FIXTURE(guest_memfd_vfio) {
> +	char *cdev_path;
> +	int iommufd;
> +	int vfio_fd;
> +};
> +
> +FIXTURE_SETUP(guest_memfd_vfio)
> +{
> +	struct vfio_device_bind_iommufd bind_args =3D {};
> +	int ret;
> +
> +	self->cdev_path =3D find_igb_cdev_path();
> +	if (!self->cdev_path)
> +		SKIP(return, "Intel 82576 device bound to vfio not found\n");
> +
> +	self->iommufd =3D open("/dev/iommu", O_RDWR);
> +	if (self->iommufd < 0) {
> +		free(self->cdev_path);
> +		self->cdev_path =3D NULL;
> +		SKIP(return, "Failed to open /dev/iommu\n");
> +	}
> +
> +	self->vfio_fd =3D open(self->cdev_path, O_RDWR);
> +	ASSERT_GE(self->vfio_fd, 0);
> +
> +	bind_args.argsz =3D sizeof(bind_args);
> +	bind_args.iommufd =3D self->iommufd;
> +	ret =3D ioctl(self->vfio_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind_args);
> +	ASSERT_EQ(0, ret);
> +}

[Severity: Low]
Can FIXTURE_SETUP(guest_memfd_vfio) fail the test instead of skipping or
trying the next matching port when /dev/vfio/devices/vfioX is absent or
already in use?

vfio_init_device() registers the device under the vfio-dev sysfs class
even when CONFIG_VFIO_DEVICE_CDEV is disabled, so
/sys/bus/pci/devices/<bdf>/vfio-dev/vfioX exists without a corresponding
/dev/vfio/devices/vfioX node.  In addition, Intel 82576 is a multi-port
NIC, and find_igb_cdev_path() unconditionally returns the first function
it sees in sysfs, so if that port is already bound by another process or
if the cdev node is missing or inaccessible, the test fails on
ASSERT_GE() or ASSERT_EQ() instead of trying remaining ports or skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D72
