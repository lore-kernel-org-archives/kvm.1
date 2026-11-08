Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098670;
	b=jsrC8H9a8L342vKG2VRfEBXc/8l26CHsTUOOekAvYiTyy3E/Ky08ofIqMp1D5nfaxsmg
	 Zrqv+4X5qOI2x7VF3BNEd8l+njMkRmVPxM6QDF6b98LqMYFCOpOKT05iAFdSwlLNEUbEB
	 ZWTPjLKiSNNSpP1o0wL2AqkUX8n0iaV7T7nnZAOP4sMOapIUWEo0E8Jt6a6QsibBWDQHN
	 /RklXP778PPTvIakFkKOHioMkGCe6shRsINpVNry2J9fdJt3tAMNCAq39O6It4k5sZQcf
	 YyXOcXSnBNghiqXSGmDTievfrMIfRcM+G/leYDlgMTmsa/9zgbD1vM8fwDYnNyfCIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=53jOGcdJbwLaYFDK5Dh64G/hXGRygLL9dNirpw1N2ig=;
	b=NdnZcccjchge4KXovj8oe2kS7v8yqdUBx2iNkaNhWJ4vDtOMKTLlaY575EnmLk+BLt8t
	 WudC+DHkp8GyG6MWPc6UAdm0kV4tIZtR34NOtE3Lr9xXf5vBS1DZ/yfOabTuUTmGqM1d0
	 i7dDLBA+J7+6WHNSPgWtSntRtvm3Rx512GiGEJA/P9SQzcR3yz+dBZFWN6/VUst4qKQiE
	 PnIJ3KkNn2GtnCfXlmNqLXYdovyaNmiMocoiQ0NRKn1/wIPxdOg1AasI31jWRwINmVJBh
	 vnTElO9fRBdIrCM1cHMo2kZU9qArSn2j7R49Q7lxrb4yjYBf/i9Q915vRLlbNNUxu/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AraWm00e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB45606D808
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AraWm00e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0CA1F008A4;
	Sun,  8 Nov 2026 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098670;
	bh=53jOGcdJbwLaYFDK5Dh64G/hXGRygLL9dNirpw1N2ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AraWm00eB9oFyPpMsM8m+NWCtLo8oJT8FInaPIGYHgp7ScgO5eBQYAysuQRxMjbQ5
	 EaVTqRgIOPi3g4I+1xm1TtDGdiW+xGudhM+NaovOAN/wwzgbvJDyaarioLNI+i1YhM
	 OtuR8I1geoc48G512UKAGtWVRTj+aUZ+kiVTdCswm4bLkhIgrfRi0f8UEP4myE3DF/
	 ZQ6a4r/Fo+lZJT4+jGSjNOWLwIlhUJ3Z74e90tod8S5rTyyS+SaRmewKlJHo4I0/UF
	 jd4as/iXE6vF5BklxlEHTieiT7AUV3v3IQnamJro7MmFbOK2l4NsyZGOoDoD2Fjy86
	 X7v6XEVg4S5Hg==
Message-ID: <sashiko-outbox-203475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 64/88] vfio: Add vfio_device_gmem_revoke helper
 for guest_memfd
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-64-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-64-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:28 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] vfio: link failure in vfio_device_gmem_revoke() with
  CONFIG_VFIO=3Dy, KVM=3Dm
- [High] vfio: unsynchronized gmem_inode access in
  vfio_device_gmem_revoke()
- [Low] vfio: return 0 in !CONFIG_KVM_GUEST_MEMFD
  vfio_device_gmem_revoke() stub
--

commit 64f7b4c8e914dff002926c09d51e57c7fda9c500
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Add vfio_device_gmem_revoke helper for guest_memfd

This commit adds vfio_device_gmem_revoke() so VFIO bus drivers can revoke
and reclaim device memory ranges from an attached guest_memfd instance.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index e4e7bfe77d03b..fd5f71dfc44b7 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1643,6 +1643,16 @@ static const struct guest_memfd_provider_operation=
s vfio_device_gmem_provider_op
>  	.mmap                 =3D vfio_device_gmem_mmap,
>  	.check_set_attributes =3D vfio_device_gmem_check_set_attributes,
>  };
> +
> +int vfio_device_gmem_revoke(struct vfio_device *device, pgoff_t start,
> +			    size_t nr_pages, const unsigned long *pfn)
> +{
> +	if (!device->gmem_inode)
> +		return 0;
> +
> +	return kvm_gmem_revoke(device->gmem_inode, start, nr_pages, pfn);
> +}
> +EXPORT_SYMBOL_GPL(vfio_device_gmem_revoke);
>  #endif

[Severity: High]
Does calling kvm_gmem_revoke() from drivers/vfio/vfio_main.c break linking
vmlinux when CONFIG_VFIO=3Dy and CONFIG_KVM=3Dm?

CONFIG_KVM_GUEST_MEMFD is a bool selected by CONFIG_KVM_X86 on x86_64 even
when CONFIG_KVM=3Dm, which links virt/kvm/guest_memfd.o into kvm.ko while
vfio_main.o is built into vmlinux.  With CONFIG_VFIO=3Dm and CONFIG_KVM=3Dm=
, the
direct symbol reference also forces vfio.ko to depend on kvm.ko even when
VFIO is used without KVM.

[Severity: High]
Can vfio_device_gmem_revoke() race with vfio_device_gmem_release() and
cause a use-after-free or NULL pointer dereference on device->gmem_inode?

device->gmem_inode is set and cleared under device->dev_set->lock, outside
the bus driver's lock (such as vdev->memory_lock), while bus driver
revocation paths call vfio_device_gmem_revoke() without holding
device->dev_set->lock or pinning the inode:

CPU0                                  CPU1
kvm_gmem_destroy_inode()
  vfio_device_gmem_release()
    mutex_lock(&dev_set->lock)
    ops->gmem_release(device)
      down_write(&vdev->memory_lock)
      ...
      up_write(&vdev->memory_lock)
                                      vfio_pci_zap_bars()
                                        vfio_device_gmem_revoke()
                                          if (!device->gmem_inode)
    device->gmem_inode =3D NULL;
    mutex_unlock(&dev_set->lock)
  ...
  kvm_gmem_free_inode()
                                          kvm_gmem_revoke(device->gmem_inod=
e,
                                                          ...)
                                            <-- use-after-free / NULL deref

Because device->gmem_inode is read twice without READ_ONCE(), clearing it
on CPU0 can also cause CPU1 to reload NULL as the inode argument to
kvm_gmem_revoke().  Similarly, in vfio_device_gmem_attach(),
ops->gmem_attach() finishes before device->gmem_inode is assigned, leaving
a window where a concurrent vfio_device_gmem_revoke() sees NULL and skips
revocation.

> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index ffb01e655735f..aade091a91fe8 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -394,6 +394,18 @@ bool vfio_file_is_valid(struct file *file);
>  bool vfio_file_enforced_coherent(struct file *file);
>  void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm);
> =20
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +int vfio_device_gmem_revoke(struct vfio_device *device, pgoff_t start,
> +			    size_t nr_pages, const unsigned long *pfn);
> +#else
> +static inline int vfio_device_gmem_revoke(struct vfio_device *device,
> +					  pgoff_t start, size_t nr_pages,
> +					  const unsigned long *pfn)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

[Severity: Low]
Should the !CONFIG_KVM_GUEST_MEMFD stub for vfio_device_gmem_revoke()
return 0 instead of -EOPNOTSUPP?

When CONFIG_KVM_GUEST_MEMFD is enabled and no guest_memfd is attached to
the device (!device->gmem_inode), vfio_device_gmem_revoke() is a no-op and
returns 0.  Returning -EOPNOTSUPP when CONFIG_KVM_GUEST_MEMFD is disabled
makes callers that check the return value fail even though no guest_memfd
can be attached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D64
