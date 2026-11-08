Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098672;
	b=4HhXzo8jZNI0Ts+w14ja8lQCyiQ5vkjNqLEFIsQL0MtWQE7TpW6KsgF34A++4ZTCLcq7
	 onhayDeSbricY4gEwyivMNr9/ptX0auuZ+tU+1OZo853kNVRIaDi5nhpMIqYztr3ycBDf
	 hDC5a2Hq3ucOJB1pVyGRDCYlWY6E4i6NxKRLMMc1kUietluJVe5e3b+Zm073BVmoOMgJx
	 yEbocTpnQnqEbpmMAIWA6N+cxsY1Ofo9GIiYZRZKfQv7WQLO7pMvyOrQ//Ka3FEEo2YbB
	 kXhokrkHzXh/a8E6h1psEu64uQXj9DeeyX7JJ51JYD/ofaHLDZ1pjzOzWmOMuJQ4U9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3rGJF0FCPP3fPG4q/g5L5ArDWBTGYY2qT2p2rmUvCjM=;
	b=PopFpJQI2tYPxwez3tqaOH61Ew2aZVUEBYDIL935BTN1kkpBm/Gwr119ljwP42sFFNhc
	 SkAafn7HmJpF35PF/vzz5XaDXnfN6QidsLh1aen9RsM4awuQ3e9Fxp4YWAxk+U9d6h/Pq
	 PbdHdsIsbdmdRcuhEK5vX/3PVblMrDb6altx+IS/boxEINBsDdLvjroLsFfgOjNT/oiOB
	 Oz8hioJ4/EsIc3bR6bO5mDdI1/UEhZXH6iqm1m0Keltn8uUOSGiB1/Q0pLH6lufff4vH8
	 qV6yGUvCmK84DLOypC7dBowLiMXwmJag/Nx8Q1Wa0v4BrKa9h1YYmlSSKgkHUn53lAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRwLQCKt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4449606D80D
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRwLQCKt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE391F008A1;
	Sun,  8 Nov 2026 00:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098671;
	bh=3rGJF0FCPP3fPG4q/g5L5ArDWBTGYY2qT2p2rmUvCjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRwLQCKtv0uiN2QX1YQz1g+TlfnDublSXPWLIrnPnjapW2gC2Mexk+uMkp4JuYttS
	 CP1n4n7fwNpY/g9gLhnJpfINqkAorXz+A9+vgQUsjKsBtazXuTUCCIhlY0GEf2TFuh
	 I+JRiNl15JluL82VgOkKdL+Bl9VoAhjxCti+S8Eqx+be9K1kwr6ceGo2SW7lTv2BeW
	 BGCl5j6Og6SCp0OkxLLp19qSAjtEKfthUZdd2msM25C5C1A6fSFK6DNpllW6zgv8/Q
	 Q0S1P+/WdJ7xt02+x8zAGqGcZeuQOKWIq8Gf9GPhKlZSOZxi9jDbzL6c9aLRN4wQLY
	 wKHkmCqHfIPlQ==
Message-ID: <sashiko-outbox-203476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 65/88] vfio/pci: Revoke guest_memfd memory on BAR
 invalidation and reset
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-65-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-65-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:30 +0000
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
- [High] vfio/pci: BARs marked available while pm_runtime_engaged is
  true
- [High] vfio/pci: UAF race on gmem_inode between vfio_pci_zap_bars()
  and release
- [Medium] vfio/pci: vfio_pci_core_runtime_resume() fails to restore
  bars_available
--

commit d6c318d12802531d9e53ee3087896bdf7d1f3349
Author: Ackerley Tng <ackerleytng@google.com>

vfio/pci: Revoke guest_memfd memory on BAR invalidation and reset

This commit revokes guest_memfd mappings in vfio_pci_zap_bars() when BAR
access is invalidated and marks BARs available again after memory decoding
and D0 power state are restored.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 9914f3ac69aef..fae3980fb8d9c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -630,8 +630,10 @@ static int vfio_basic_config_write(struct vfio_pci_c=
ore_device *vdev, int pos,
>  		*virt_cmd &=3D cpu_to_le16(~mask);
>  		*virt_cmd |=3D cpu_to_le16(new_cmd & mask);
> =20
> -		if (__vfio_pci_memory_enabled(vdev))
> +		if (__vfio_pci_memory_enabled(vdev)) {
>  			vfio_pci_dma_buf_move(vdev, false);
> +			vfio_pci_set_bars_available(vdev, true);
> +		}
>  		up_write(&vdev->memory_lock);
>  	}

[Severity: High]
Can this set vdev->bars_available to true while vdev->pm_runtime_engaged is
still set?

When userspace enters low-power mode via VFIO_DEVICE_FEATURE_LOW_POWER_ENTR=
Y,
vfio_pci_runtime_pm_entry() zaps BARs and sets vdev->pm_runtime_engaged =3D
true.  A later config write or reset ioctl wraps the access in
pm_runtime_resume_and_get() and pm_runtime_put(), so pdev->current_state is
temporarily PCI_D0 while vdev->pm_runtime_engaged remains true.  Because
__vfio_pci_memory_enabled() does not check vdev->pm_runtime_engaged, this
sets vdev->bars_available =3D true, and when pm_runtime_put() suspends the
device back into D3hot/D3cold without calling vfio_pci_zap_bars(),
vfio_pci_core_gmem_get_pfn() will map BAR MMIO pages of a powered-down
device.

The same applies to vfio_lock_and_set_power_state(), vfio_exp_config_write(=
),
vfio_af_config_write(), vfio_pci_ioctl_reset(), and
vfio_pci_dev_set_hot_reset(); unlike vfio_pci_core_gmem_attach() and
vfio_pci_vmf_insert_pfn(), none of them check !vdev->pm_runtime_engaged.

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 894b1332f8a0c..2b29d0ec6a0c9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -464,8 +464,10 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci=
_core_device *vdev)
>  	 */
>  	down_write(&vdev->memory_lock);
>  	__vfio_pci_runtime_pm_exit(vdev);
> -	if (__vfio_pci_memory_enabled(vdev))
> +	if (__vfio_pci_memory_enabled(vdev)) {
>  		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_set_bars_available(vdev, true);
> +	}
>  	up_write(&vdev->memory_lock);
>  }

[Severity: Medium]
Does waking from VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP leave
vdev->bars_available set to false?

When the device resumes with a wakeup eventfd configured,
vfio_pci_core_runtime_resume() exits low-power mode by calling
__vfio_pci_runtime_pm_exit() directly rather than vfio_pci_runtime_pm_exit(=
):

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_runtime_resume() {
	down_write(&vdev->memory_lock);
	if (vdev->pm_wake_eventfd_ctx) {
		eventfd_signal(vdev->pm_wake_eventfd_ctx);
		__vfio_pci_runtime_pm_exit(vdev);
	}
	up_write(&vdev->memory_lock);
}

Because vfio_pci_set_bars_available(vdev, true) is only in
vfio_pci_runtime_pm_exit(), subsequent guest_memfd BAR faults in
vfio_pci_core_gmem_get_pfn() will keep failing with -EFAULT after wakeup.

[ ... ]

> @@ -1727,8 +1731,31 @@ static void vfio_pci_zap_bars(struct vfio_pci_core=
_device *vdev)
>  	loff_t start =3D VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
>  	loff_t end =3D VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
>  	loff_t len =3D end - start;
> +	int i;
> =20
>  	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
> +
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +	if (vfio_pci_get_bars_available(vdev)) {
> +		vfio_pci_set_bars_available(vdev, false);
> +
> +		for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +			pgoff_t gmem_start;
> +			unsigned long pfn;
> +			size_t nr_pages;
> +
> +			if (!vdev->bar_mmap_supported[i])
> +				continue;
> +
> +			gmem_start =3D VFIO_PCI_INDEX_TO_OFFSET(i) >> PAGE_SHIFT;
> +			nr_pages =3D pci_resource_len(vdev->pdev, i) >> PAGE_SHIFT;
> +			pfn =3D pci_resource_start(vdev->pdev, i) >> PAGE_SHIFT;
> +
> +			vfio_device_gmem_revoke(&vdev->vdev, gmem_start,
> +						nr_pages, &pfn);
> +		}
> +	}
> +#endif
>  }

[ ... ]

> @@ -2726,8 +2753,7 @@ void vfio_pci_core_gmem_release(struct vfio_device =
*core_vdev)
> =20
>  	down_write(&vdev->memory_lock);
> =20
> -	/* Pairs with smp_load_acquire() in provider operations */
> -	smp_store_release(&vdev->bars_available, false);
> +	vfio_pci_set_bars_available(vdev, false);
> =20
>  	up_write(&vdev->memory_lock);
>  }

[Severity: High]
Can vfio_pci_zap_bars() race with guest_memfd release and cause a
use-after-free on device->gmem_inode?

CPU0                                  CPU1
kvm_gmem_destroy_inode(inode)
  ...
  vfio_device_gmem_release()
    mutex_lock(&dev_set->lock)
    vfio_pci_core_gmem_release()
      down_write(&vdev->memory_lock)
      vfio_pci_set_bars_available(false)
      up_write(&vdev->memory_lock)
                                      vfio_pci_ioctl_reset()
                                        down_write(&vdev->memory_lock)
                                        ...
                                        vfio_pci_set_bars_available(true)
                                        up_write(&vdev->memory_lock)
                                      vfio_pci_ioctl_reset()
                                        down_write(&vdev->memory_lock)
                                        vfio_pci_zap_bars()
                                          vfio_device_gmem_revoke()
                                            loads device->gmem_inode
    device->gmem_inode =3D NULL
    mutex_unlock(&dev_set->lock)
  mt_destroy(&gi->attributes)
kvm_gmem_free_inode(inode)
                                            kvm_gmem_revoke(gmem_inode, ...)
                                              <-- use-after-free

vfio_device_gmem_release() clears device->gmem_inode under dev_set->lock
after vfio_pci_core_gmem_release() has already dropped vdev->memory_lock,
and even before vfio_device_gmem_release() runs, kvm_gmem_destroy_inode()
begins tearing down the evicting inode while vdev->bars_available is still
true.  Because vfio_pci_zap_bars() and vfio_pci_set_bars_available() only
take vdev->memory_lock (and set vdev->bars_available =3D true unconditional=
ly
even when no guest_memfd is attached), nothing prevents
vfio_device_gmem_revoke() from dereferencing device->gmem_inode while the
inode is being destroyed and freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D65
