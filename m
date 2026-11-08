Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098667;
	b=yixthyeyVnYVbQia5TRSQtwMJhvqJsj/BmSJiTUi3wRnt61O8emPKnZbzlW3WvimnCzi
	 kWBXB+IUIbZaei2LU8QHkPAvItYJYHXCA9fu3lE7dVSsCFg3+NVKARhY5tyJnAfXXyWFz
	 B5+JSww9VQpbA+t8q+q7i2dnDVtz2ZM+1ogwuqM6yB7YdVggP9H6uXwjTobuS8hy41lcm
	 /UtWqZeZ15dZR6JNutVueg6p+cIQdhSNPRtVTQbKpGdyEO9d6mEl2ma6JC5EMIIvfrtLX
	 s33c+ETlXYKTQTQ2hqq7GvyRPbeciXYp5ymPvI3LZ5kXCux4LlcKJJ0yqYohTwT9mrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DQu96n0VZ/08CUzUzSjmxbmnQa9ZmqvzehBEI4XjsKY=;
	b=e/CMR23wHPQBSujr+lTPh2CgVAMwvqFj7B+b19nklN4ok2vGUf7MLzAdhV1hnvZ4eOnp
	 E76GZM9diq3mXKyZF+GhetktzZpeXlAtd+6vR7xOX11H0uBuDUi3USKGsxS62OqLmTC+2
	 0RiQiy7SmdcAeJ8ODIWAYI9k8rmADqzN3IkHwT59XfY76BgwP+1qzxQv2+jhiTEHWtcmB
	 haFNgVRyTqR2w54ZNJ37wTp38IZCNPiUJL9AdXbDQfEQhxo3lupc9MJDKqLeFK7jebQm+
	 FEo8pX+KGmYHrPjzK4hMyclhUMAB+ksTyUgYA4J/fp3FCzCNxKQmVAJoc3xx0a2tuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fiv9oq8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCB606D80F
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fiv9oq8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264C61F0089F;
	Sun,  8 Nov 2026 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098667;
	bh=DQu96n0VZ/08CUzUzSjmxbmnQa9ZmqvzehBEI4XjsKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fiv9oq8yYVP5vsgwiMw3nunwdAT/AWs8HCr72UJm/erbxLm1Pfefo8GZz58hglXk3
	 xDY4c69FqIMHTYpIRodeBYxIwI+ULyjVMJIKE7VX9mZx+ptBhRWQ/PU70ZZwxU74Yc
	 ArgoHqIqMBTOPtnt8KyBOUV2SXBpbuPL8lnaHF5PoLseHCQg8VX2o/rwTdtf6PrfPy
	 H45JqQi7rMKokWHpw796b2FBNOY9SYVGG993iee+krSQUh7c7PtOvqANawc5imlmuW
	 6iGrZ15T29nF4fCC1L/0595DJZmQao88t+LxK1Jl1vodEIBVeXIDCRaoKRVdXfWkFj
	 TvG7r3IfoT5bw==
Message-ID: <sashiko-outbox-203472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 61/88] vfio: Implement mmap provider op for
 guest_memfd
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-61-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-61-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:25 +0000
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
- [High] vfio: uncached and decrypted vma->vm_page_prot lost in
  guest_memfd fault
- [Medium] vfio: vfio_device_fops_mmap() returns -EOPNOTSUPP instead of
  -EINVAL
--

commit 6c78c8834b1a41506b88de16d4e56626d4ac8609
Author: Ackerley Tng <ackerleytng@google.com>

vfio: Implement mmap provider op for guest_memfd

This commit extracts a vfio_device_mmap() helper from
vfio_device_fops_mmap() and wires up the .mmap provider callback in
vfio_device_gmem_provider_ops to forward guest_memfd mappings to the bus
driver's .mmap handler.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 93bd0a200ad22..979ed69c5ebf7 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1503,20 +1503,25 @@ static ssize_t vfio_device_fops_write(struct file=
 *filep,
>  	return device->ops->write(device, buf, count, ppos);
>  }
> =20
> +static int vfio_device_mmap(struct vfio_device *device,
> +			    struct vm_area_struct *vma)
> +{
> +	if (unlikely(!device->ops->mmap))
> +		return -EOPNOTSUPP;
> +
> +	return device->ops->mmap(device, vma);
> +}
> +
>  static int vfio_device_fops_mmap(struct file *filep, struct vm_area_stru=
ct *vma)
>  {
>  	struct vfio_device_file *df =3D filep->private_data;
> -	struct vfio_device *device =3D df->device;
>  	int ret;
> =20
>  	ret =3D vfio_df_check_full_access(df);
>  	if (ret)
>  		return ret;
> =20
> -	if (unlikely(!device->ops->mmap))
> -		return -EINVAL;
> -
> -	return device->ops->mmap(device, vma);
> +	return vfio_device_mmap(df->device, vma);
>  }

[Severity: Medium]
Does extracting vfio_device_mmap() here cause a regression where
vfio_device_fops_mmap() returns -EOPNOTSUPP instead of -EINVAL when a bus
driver does not implement device->ops->mmap?

Direct mmap(2) calls on full-access VFIO device fds for drivers without an
.mmap callback (such as vfio-ccw or vfio-ap) previously returned -EINVAL,
matching vfio_device_fops_read(), vfio_device_fops_write(), and
vfio_device_fops_unl_ioctl().  Returning -EOPNOTSUPP changes the user-visib=
le
errno and makes a missing driver .mmap callback indistinguishable from a
file descriptor bound with VFIO_DEVICE_BIND_FLAG_CTRL_ONLY.

> @@ -1604,10 +1609,23 @@ static int vfio_device_gmem_get_pfn(void *provide=
r, pgoff_t index,
>  					 pfn_attrs);
>  }
> =20
> +static int vfio_device_gmem_mmap(void *provider, struct vm_area_struct *=
vma)
> +{
> +	struct file *file =3D provider;
> +	struct vfio_device_file *df =3D file->private_data;
> +
> +	/*
> +	 * No control- vs. data-plane filtering is required because
> +	 * vfio_device_mmap() already only allows mmap-ing the data plane.
> +	 */
> +	return vfio_device_mmap(df->device, vma);
> +}
> +
>  static const struct guest_memfd_provider_operations vfio_device_gmem_pro=
vider_ops =3D {
>  	.attach  =3D vfio_device_gmem_attach,
>  	.release =3D vfio_device_gmem_release,
>  	.get_pfn =3D vfio_device_gmem_get_pfn,
> +	.mmap    =3D vfio_device_gmem_mmap,
>  };
>  #endif

[Severity: High]
When kvm_gmem_mmap() overrides vma->vm_ops with kvm_gmem_pfn_vm_ops after
vfio_device_gmem_mmap() returns, does the guest_memfd fault handler discard
the uncached and decrypted protections that vfio_pci_core_mmap() sets on
vma->vm_page_prot?

vfio_pci_core_mmap() configures vma->vm_page_prot with pgprot_noncached()
and pgprot_decrypted().  However, on a user fault,
kvm_gmem_fault_user_mapping() -> gmem_insert_pfn() recomputes page
protections from vma->vm_flags instead of using vma->vm_page_prot:

virt/kvm/guest_memfd.c:gmem_insert_pfn() {
    ...
	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
				   vm_get_page_prot(flags));
}

Because vm_get_page_prot(flags) derives a fresh pgprot_t from
protection_map[], both pgprot_noncached() and pgprot_decrypted() are lost.
On architectures without PAT PFNMAP tracking in pfnmap_setup_cachemode_pfn()
(such as arm64), PCI BAR MMIO pages are mapped into host userspace as
write-back cacheable normal memory rather than Device memory and without
PROT_NS_SHARED, which can corrupt MMIO accesses or trigger synchronous
external aborts and SError.  On x86 systems with SME or SEV active,
vm_get_page_prot() sets _PAGE_ENC, causing host userspace MMIO accesses to
unencrypted device BARs to be performed with the encryption bit set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D61
