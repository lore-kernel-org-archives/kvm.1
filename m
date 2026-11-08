Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098676;
	b=JtvokKB4kzwvGNajDrxNbLZg5GbAB1ZrUPmAjNHyFxte3JpjBkrvxF/Dakk1Z6iGk4Un
	 PR2K2fqFXBivpwU+dZXmfMlcsrDTRbadf3umT6DuxiE3iZ9zgopgjIIowANBKeb09a76+
	 Bkw84tjedp+1YFi2AJsOdo25JtjdKzaOVLTgzessDDCesJdEC/4budD/vZeoSeezFPIhN
	 +HVcbyOBx7MkdHrRdzDkpjVxGt1AN8QQhePwB+AWKlT6Ze7WXC5fw1l+SE/6tIh/0ACkO
	 Km4V8dsZX4MDMEfoyXH1vKLOJ2VZVXuBaSfueKpryv5iRhh7E69JOpMBQvcA0mYg5Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w0rhvPH19u7tz1SnZv54KCQaJt1s6QEE0Sc/KUgXCZM=;
	b=P473eoi41Fbdtp1dlW0L6AO0ZHb2eWS3sGZBuvuHVtgGbc2Jcu99SA3yKD+/wodzYRK5
	 +tzcPN3vrEnmbDyj9BmuZnQiRT0VJUjzINoQ8Rfl07KYnXSCGIam5VHFuS8OFvl0AhSGG
	 l+6fqt4kWpH+aQpb+hZgieHSROPXufUDJs6K2ZnLYAX+zNXEgIefn8v2OK2oxnqNaWOEw
	 HV/ldCHyP3jhxEJHwHN2vzpL4JSwU0qw0IUiQqJvsC+pZMbG4d61t00Z3X+oTeHmd8jre
	 2QXv3NXRX2DIvTtxeCbM9nq/V2anItTaRSWexzfgk0ZaCH0I5U9QzKjrIvSzzxVtmSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8dY3e+n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB25606A338
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8dY3e+n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4101F008A3;
	Sun,  8 Nov 2026 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098675;
	bh=w0rhvPH19u7tz1SnZv54KCQaJt1s6QEE0Sc/KUgXCZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8dY3e+nVEQMeRaRSX+egwqFmjzHP+yfZe7X6T4CcyUPU+sxOVE9xC3+2ossojcxa
	 BKxqC6XLqS9L+nIRtq+h9RGwBMPXXZiKOcsbq9+ycC2vCV6eyQ2BgOSdygi4HxsORL
	 OYDQMtCMa+U2YE5pKPpE5YzdU0G+xObb0ebgT+CeSy8t2PJ0Udo0xg90ZuYMc9BEtO
	 bl8m5tHjXunSSqkzPbWu3hY/J2NA0sT0tbGSTyY49atDC9gDF+YjTltpHt4f0LiFgX
	 Q7ogNMCaYYxMOO3V0xNeAhspD6LcDReqO/aIJYWfiw6hUobeDiVogocx46nFq/IoQu
	 Sg2gYoI3RDLWQ==
Message-ID: <sashiko-outbox-203482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 71/88] vfio/pci: Implement read and write
 provider ops for guest_memfd
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-71-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-71-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] vfio/pci: unserialized sub-page BAR access in
  vfio_pci_core_gmem_rw()
- [High] vfio/pci: D3 MMIO access in vfio_pci_core_gmem_rw() when
  runtime PM engaged
--

commit a60cfc9fb84848a43b5d6f8b77f7f250457c4495
Author: Ackerley Tng <ackerleytng@google.com>

vfio/pci: Implement read and write provider ops for guest_memfd

This commit implements the .gmem_read and .gmem_write provider operations
in vfio-pci to service guest_memfd read and write accesses to mappable
MMIO BARs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a9274d95e9066..c976574782663 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2871,6 +2871,42 @@ int vfio_pci_core_gmem_lookup_pfn_range(struct vfi=
o_device *core_vdev,
>  	return -ENOENT;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_lookup_pfn_range);
> +
> +static ssize_t vfio_pci_core_gmem_rw(struct vfio_device *core_vdev,
> +				     void *kbuf, size_t count,
> +				     loff_t *ppos, bool iswrite)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	unsigned int index =3D VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +
> +	if (!count)
> +		return 0;
> +
> +	if (index >=3D PCI_STD_NUM_BARS || !vdev->bar_mmap_supported[index])
> +		return -EINVAL;

[Severity: High]
Can a sub-page BAR access here race with a reset or power transition?

In vfio_pci_probe_mmaps(), a page-aligned BAR smaller than PAGE_SIZE has
 its remainder reserved via dummy_res and vdev->bar_mmap_supported[bar] set
to true.  Unlike vfio_pci_core_gmem_get_pfn() and
vfio_pci_core_gmem_lookup_pfn_range(), which reject BARs where
pci_resource_len(pdev, bar) >> PAGE_SHIFT is 0, vfio_pci_core_gmem_rw()
allows them and calls vfio_pci_bar_rw_kbuf() with test_mem =3D false.

Skipping vdev->memory_lock relies on vfio_pci_zap_bars() revoking the BAR
range in guest_memfd so __kvm_gmem_revoke() takes
filemap_invalidate_lock() and drains in-flight kvm_gmem_rw() calls.  For a
sub-page BAR, however, vfio_pci_zap_bars() passes nr_pages =3D 0:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_zap_bars() {
	...
			gmem_start =3D VFIO_PCI_INDEX_TO_OFFSET(i) >> PAGE_SHIFT;
			nr_pages =3D pci_resource_len(vdev->pdev, i) >> PAGE_SHIFT;
			pfn =3D pci_resource_start(vdev->pdev, i) >> PAGE_SHIFT;

			vfio_device_gmem_revoke(&vdev->vdev, gmem_start,
						nr_pages, &pfn);
	...
}

When nr_pages is 0, __kvm_gmem_revoke() returns early before acquiring
filemap_invalidate_lock(inode->i_mapping):

CPU0                                  CPU1
kvm_gmem_rw()
  filemap_invalidate_lock_shared()
  vfio_pci_core_gmem_rw()
    vfio_pci_get_bars_available()
                                      vfio_pci_ioctl_reset()
                                        down_write(&vdev->memory_lock)
                                        vfio_pci_zap_bars()
                                          vfio_pci_set_bars_available(false)
                                          __kvm_gmem_revoke(..., nr_pages=
=3D0)
                                            return 0;
                                        pci_try_reset_function()
    vfio_pci_bar_rw_kbuf(..., false)
      vfio_pci_core_iowrite()  <-- MMIO during reset

This allows MMIO reads and writes to run concurrently with a PCI reset, a
transition to PCI_D3hot, or clearing PCI_COMMAND_MEMORY, which can cause
Completer Abort / Unsupported Request errors or synchronous external
aborts.

> +
> +	/* Lockless check on availability of BARs. */
> +	if (!vfio_pci_get_bars_available(vdev))
> +		return -EIO;
> +
> +	return vfio_pci_bar_rw_kbuf(vdev, kbuf, count, ppos, iswrite, false);

[Severity: High]
Can vfio_pci_core_gmem_rw() issue MMIO accesses while the device is
runtime-suspended in D3?

Unlike vfio_pci_rw(), vfio_pci_core_gmem_rw() does not call
pm_runtime_resume_and_get() and passes test_mem =3D false to
vfio_pci_bar_rw_kbuf(), relying on vdev->bars_available to be false while
runtime PM low-power mode is engaged (vdev->pm_runtime_engaged).

When userspace enters low-power mode via
VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY, vfio_pci_runtime_pm_entry() zaps BARs
(setting bars_available =3D false), sets vdev->pm_runtime_engaged =3D true,
and drops the runtime PM reference.  If userspace then performs a config
write (or a reset ioctl), vfio_pci_rw() temporarily resumes the device to
D0 for the duration of the call.  Because vdev->pm_wake_eventfd_ctx is
NULL, vfio_pci_core_runtime_resume() leaves vdev->pm_runtime_engaged set
to true, but the config write or reset path re-enables bars_available
without checking !vdev->pm_runtime_engaged:

drivers/vfio/pci/vfio_pci_config.c:vfio_basic_config_write() {
	...
		if (__vfio_pci_memory_enabled(vdev)) {
			vfio_pci_dma_buf_move(vdev, false);
			vfio_pci_set_bars_available(vdev, true);
		}
	...
}

When the config write finishes and calls pm_runtime_put(),
vfio_pci_core_runtime_suspend() suspends the device back to D3 without
clearing bars_available.  Subsequent guest_memfd reads and writes see
vfio_pci_get_bars_available(vdev) =3D=3D true and perform MMIO against the
device while it is in D3.

Conversely, when waking from VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEU=
P,
vfio_pci_core_runtime_resume() calls __vfio_pci_runtime_pm_exit() without
restoring bars_available =3D true, leaving guest_memfd BAR accesses failing
with -EIO after wakeup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D71
