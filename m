Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098680;
	b=kdJnzPN4mLJcmahsyQK//L7kT5ZsQ+3RCt/lRB+d5tL6TDC0BfApJpUlb+U/kx6Oihib
	 ImnJ57CpgSPhCvdztFxj/AzRTbk7O7s1z8/UTKBwlZ43b98ktdNcllFVCD95GdsZMf5Jn
	 AXT2nBxwiAe/IOYIhFk/RbDrquOVKB5ywXH4PTZTUpk5lyk2DTpLeH/O0YI3oAxBFdkdJ
	 4sL3LOgj7IDxD6klESQFSq/HPhajV8PXdgpuS7IRBKf120YPk2QAuoECUzicfhtJp5d/n
	 svusMWLZMS9e6Z8G/fTk8VNNSbolufWJHigAAVzO7iEa3Z7fnNsOhE4j791yLq0ZLiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hcG40dDe6eONlWF95luQZ5gasf6jPGFMuaspMiLYjug=;
	b=s9NVoxEhUCz2y49H8vHmUQVoXpoYccOeF8Cq4YShV3mHfIsCGDWs6FVAWgzPvdrwVGZc
	 QbfNLRUrA/cGOzyzPN/EOhvLt+hae95BW8kARdMrRF3FMy/TMupw1XOZWcLP35LAP77df
	 cbLkEO44mCZnlBlLrdCtTG+B5KC5qNzd1KYiMdzzm11wcOsjeWSlfMP6cxatAew6rSIvX
	 kqrrHi3S+bik+Ey0eT6R1mBHefF3fIXsZ+zaWhPaYIxKNFXJYNAJ+kU4+Sgt3PJZBgvy2
	 EVYMS7Rx6XO4t7yFm67OFmz5JksL2xAlXA0/QNlsv/8YOj24vypGfn2MJrkjgube8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TTavj1U/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02576606D819
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTavj1U/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DFA1F008A1;
	Sun,  8 Nov 2026 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098679;
	bh=hcG40dDe6eONlWF95luQZ5gasf6jPGFMuaspMiLYjug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTavj1U/myGqLFZD6+KicnmXy1BtBuGpP/tZKjRXIGCilnrf+Nd1AhZYlnCWwT9w8
	 /XaZKfF4GX5UnsXwEQyZp8a0mrgCsSGEGIj/JYr/o0nbHKVlSDxLvEZ4tbcxUEMQF4
	 3PKm2n+9G2AxihGhN9MT0wTofZH+75dBxGhLbMd78uUqsDd7NKyrQFeK2npVbc1TMm
	 6QxtbLd/pHjL1KwlanGZDP4A5Bi8q4TojxuerELBfbyXQwzybjDlqptGuM6jTcQ1/f
	 BNToga2SouexEh5H2LILp1uDJPz3WS8FeFQe5ervIkXzxjc6qtHxwOpXUz7+dSUujS
	 eBUxSlD8vmUsQ==
Message-ID: <sashiko-outbox-203490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 79/88] KVM: selftests: Verify BAR revocation and
 access gating in low power state
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-79-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-79-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:38 +0000
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
- [Medium] KVM: selftests: low_power_bar_revocation() fails on direct
  VFIO variant
--

commit de038c6f26d71384fc01f1fa33e4f547141e9831
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Verify BAR revocation and access gating in low power state

This commit adds a low_power_bar_revocation subtest to guest_memfd_vfio_test
to verify that entering D3hot revokes BAR mmap mappings and rejects
pread/pwrite accesses until returning to D0.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/to=
ols/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> index 03c324f7f618d..cf2d46a365504 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
> @@ -443,4 +443,90 @@ TEST_F(guest_memfd_vfio, device_reset)
>  	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
>  }
> =20
> +TEST_F(guest_memfd_vfio, low_power_bar_revocation)
> +{
[ ... ]
> +	/* Enter low-power D3hot state */
> +	feat.argsz =3D sizeof(feat);
> +	feat.flags =3D VFIO_DEVICE_FEATURE_SET |
> +		     VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY;
> +	ret =3D ioctl(self->vfio_fd, VFIO_DEVICE_FEATURE, &feat);
> +	ASSERT_EQ(0, ret);
> +
> +	/*
> +	 * In low-power state, BARs are marked unavailable and mappings are
> +	 * revoked.
> +	 *
> +	 * - Host mmap accesses trigger SIGBUS because page tables were zapped
> +	 *   and get_pfn fails with -EFAULT while in low power state.
> +	 * - Host pread() and pwrite() on the BAR descriptor fail with -EIO.
> +	 */
> +	TEST_EXPECT_SIGBUS((void)READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_R=
AL0)));
> +	TEST_EXPECT_SIGBUS(WRITE_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0),=
 0x12345678));
> +
> +	val =3D 0;
> +	ret_bytes =3D pread(self->bar_fd, &val, sizeof(val), bar0_info.offset +=
 E1000_STATUS);
> +	ASSERT_EQ(-1, ret_bytes);
> +	ASSERT_EQ(EIO, errno);
> +
> +	val =3D 0x12345678;
> +	ret_bytes =3D pwrite(self->bar_fd, &val, sizeof(val), bar0_info.offset =
+ E1000_RAL0);
> +	ASSERT_EQ(-1, ret_bytes);
> +	ASSERT_EQ(EIO, errno);

[Severity: Medium]
Will these pread() and pwrite() assertions fail in the direct fixture
variant?

In the guest_memfd variant, self->bar_fd is self->gmem_fd, and
vfio_pci_core_gmem_rw() rejects the access with -EIO because
vdev->bars_available is false.  In the direct variant, however,
self->bar_fd is self->vfio_fd, and VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY
wakes the device on any descriptor access through the VFIO uAPI:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_rw() {
	...
	ret =3D pm_runtime_resume_and_get(&vdev->pdev->dev);
	if (ret) {
		pci_info_ratelimited(vdev->pdev, "runtime resume failed %d\n",
				     ret);
		return -EIO;
	}

	switch (index) {
	...
	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
		ret =3D vfio_pci_bar_rw(vdev, buf, count, ppos, iswrite);
		break;
}

Because vfio_pci_rw() resumes the device to PCI_D0 before calling
vfio_pci_bar_rw(), and __vfio_pci_memory_enabled() only checks
pdev->current_state < PCI_D3hot and PCI_COMMAND_MEMORY, pread() and
pwrite() succeed and return sizeof(val) instead of failing with EIO.
Should the pread()/pwrite() EIO checks be gated on variant->use_gmem, or
should D3hot be entered via PCI_PM_CTRL in config space so both variants
stay in D3hot across descriptor accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D79
