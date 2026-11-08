Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098660;
	b=WYfUgUo35oQXd01+M0vyqWE53GmadFtbMiAe56/c3jQgF15eglKsuRUwJfEivoIYbkqa
	 A7Vgga23R/KHHboeNrTYMvUPRZT1RvsXbJvv0ghxbBi/9rUR7zi20FNFcWpmDAEN85UA/
	 uZSW0mKOYZfNfWWaKjNDmkxRLqf6wMOtMsOJSBT62zM8ZM+AhO/xFPEJql/9Y3mHpSOFg
	 23n4efT8ns3UNtQ5wx4hy1+ohYjUs+pp8+XgIJYccmLoHEfFEZ3SldscbNJp/0EUb46Bu
	 1ZVaZm8gzG6Fbfkeiqgyyn0leZSCuFrNJKCJ9Oi8uHSOVJ66ZplN3O1YB3piyGOyjCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zEqwgXBUkUu4Dpqk2uwW/tQtSdU+sYZ8iNDY55vkAus=;
	b=kzBH/7zy2TIHycTLvW7FakBWSUOXNoh90y1ITo1eFlydmPutoJdEh4s57AoLkhil9Hio
	 9Lf0oeH8H26Z98A2cofWdhYrPBdirec2OpfYBOlua5duLO/3YvKPYM1UAwrUSG8F4pwzK
	 B3rlGO3BnEMo79wjOV+U3FPVzUOpKU2k8ieYI7qnEu46Qn6y6o5CbC5KMWSpekO9e8x/8
	 LfO0eSvxmLwhlYIiXrpyEOScpza67o2M+c8N83q57+VgLkD6WpPXd4+mgS5WMwhquRHRA
	 LwFwNj3iN3ywycpJLjgu/bJoltS9GcB34dcQmhPcI/9JOOVDPj+HTFZLQDmZp32+1xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCkuDqb3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AA606D80E
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCkuDqb3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592DC1F008A1;
	Sun,  8 Nov 2026 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098660;
	bh=zEqwgXBUkUu4Dpqk2uwW/tQtSdU+sYZ8iNDY55vkAus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCkuDqb3j2PdOcknM1a5laLqJTvBB0GsnOfqSVLeM8ElbY8GU3d4l+hjxxBJpMlcr
	 E9wrWaJ6ih6PcaU+0zZ8z5uzFDCRmGYOfuOnnS63ZHbDDPDRHvzu1HmVudS3q8xvbr
	 KF1P9nop0AiLgeLv9cLKJV35rAy9wIJnX6SuZ5fXEM8szUG/al/yWnhRNAtRZs205E
	 18oER2IvlSYoozrfLJtEjPWgxIEfKBxASbWUxA+I3H8hJFJKffSzDpcK1hFhQl0DgA
	 24BJtPhgCliROfn/LRDFKbXevhRq56BOM0wfM/ncSFM4umTU53AuGEGx3lDGSE3T7x
	 h2wictlrvgXwQ==
Message-ID: <sashiko-outbox-203467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 56/88] vfio: Support
 VFIO_DEVICE_BIND_FLAG_CTRL_ONLY
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-56-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-56-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:19 +0000
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
- [Low] vfio: UAPI comment for VFIO_DEVICE_BIND_FLAG_CTRL_ONLY documents
  wrong errno for BAR read/write
--

commit 25f54ac99c18d430e01125c8ec278111ab821c3f
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Support VFIO_DEVICE_BIND_FLAG_CTRL_ONLY

This commit adds VFIO_DEVICE_BIND_FLAG_CTRL_ONLY to VFIO_DEVICE_BIND_IOMMUFD
to restrict bound device descriptors to control-plane ioctls and non-mappab=
le
region reads and writes.

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e41437fa17ad0..ea62d4e72d3bd 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -926,12 +926,19 @@ struct vfio_device_feature {
>   * be provided the same token as VFIO_DEVICE_FEATURE_PCI_VF_TOKEN provid=
ed to
>   * the PF.
>   *
> + * VFIO_DEVICE_BIND_FLAG_CTRL_ONLY restricts the bound device fd to
> + * control-plane ioctls and non-mappable region read/write access (such =
as PCI
> + * configuration space), rejecting mmap(), read/write to mmap-supported =
BARs,
> + * and all other ioctls or device features with -EOPNOTSUPP. This should=
 be used
> + * to prepare the device fd for attachment to guest_memfd.

[Severity: Low]
Does this comment document the wrong errno for rejected BAR reads and write=
s?
vfio_df_check_rw_access() rejects non-control-plane read/write accesses with
-EINVAL (as described in the commit message), whereas this comment states
that read/write to mmap-supported BARs is rejected with -EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D56
