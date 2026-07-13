Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB535E952
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982424; cv=pass; b=XbWGFzhUVH5WmgfCpJ9a+WN2SgKSVAW/OsBBBbk1i0i9zwc+SiWp/7++WWO8dCrIa9N3V+guXvkiJ8BxNFApk9eSjX71r58y9haoAewDIvsXrYovfpfB6jj1FrllcNhu3rMHY2Zmq4sERSlM+jLrT+ob7LtYj0YTTdjUYynQ1Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982424; c=relaxed/simple;
	bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIqhvCieTlIDAuxPGnEBvvF+X0xUfc9Y7PEI0bSilrIpCQHnO0MgsL1n9B8EM04OU65nQ7yW1XIWPFfi4/T8LVnukLySiEh9kBYHYbGcnQvx6sMrANpIcNY2BnE8CTOqJO1vIDPkBEXkXGiP9/9SGobIeL1WYdjm6mfwM6TiKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MET43OUc; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MET43OUc"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso398640a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783982421; cv=none;
        d=google.com; s=arc-20260327;
        b=ILlBZJUxKPuFf2+dfatmAVT1Byyy2iyYBvoE4aP609VbQg3C1zXHTg+GITLGtKz3jO
         WHlFwskwn7q2/QpE7ZRCShMwKhz7A478kHXG42LGIuK3cJsW6wHpK7rIES4I/G48/abp
         Bo02nEoc3iSNuHC3U6fdVHj1Ey9iDzhZc2jo9z3hGUO1rQAK45hRcH9qC/olbyjF04DR
         HWqdAY7ekplygR4QGng3bMJiQX7mG6nkIJs/L5OlcF8aMi92vX9ug8bVNnz2fZaacufw
         M61z2Vwh5VfpoWqhteEKlcBOloNSRTtvO3PZ3X24rQnYBiP5aOGWdzQ1X0u41o08yjaL
         iCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        fh=2esgR/BAuzzzaHyQ9xdZLgBBiSESRdurua54EpBsyJ4=;
        b=eqDr0CfOyt2oL4nfjGvYVk4nOlQIEf33Wz0RdI/Kba8VYS56v+1d/4p54t5m02Z+wL
         p3xTQmJ2Ji6hw/xteXeps4nc3/qUtniIBXJKAsYx3FjuGhGGGkXKROYuVWRKiMfHjxGe
         sQ2f8RUfp1FWsqjaWUtbOmS76LkBboeKT1Ac5yg+UaXPnwXZFh/heZiEwGu1hm5ExsyX
         3Y7nBUmcoMo+ouNOskP969QHfDcsQvsJIkPMZdCfnlEibAN9DbIqEb9WEyCTnl45w30s
         roCtkfHoDcbXyy5XlAtWKOnQMCnFXaQS5hwM/+UxIok9m5GzioVyRbj2DHbDUJJUmHHD
         wcPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783982421; x=1784587221; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=MET43OUcURM8pFPrJQDWyENy3H19795XEqQCyrqsduHYio7M5nTQXLYG/OmO9cp7pu
         NSSIOdLDvXWVZ9I0oqHIPHx2CUMjFjdXlMjUOYtxQRcEe+Dvyq3MDcJYRF4IZqwcNW2Z
         1hfEhawPHBmOGGjG5SGkQ5i2ptqFmy8aS9H0YzRMa+i6hYP7EPL5lZkT/Eo5A9f2ZEIF
         xZcjgdxAwdiRI8yIW1fMgK8wsKugVNDr7Cl3XaNqvTN64quYFZc3g5Rxu1pspm/jay9b
         GeMTQKsBFEdtQKWr0fqjg8EB0f2b9eodHg8CqAhpyh5mMy+THoxXrrWrVf7r1k2OZbPh
         uuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982421; x=1784587221;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=EG52VXrqGeCoPCv7ftP05vIobBnbmk5Y8iemne1hhRM43zOgrEgcw5Rkrw8DjUBTsB
         VPRO6MLaf4PPwu9zoioLAP6u9G3fjXUt0Gumz3o37YQHLIQrOI0IngQfWlIuJFy99nZJ
         M5jzLHY/QVQihqoNjw5N86X/gJkSY76e2KRRfP9AGCUFNTIW8xIev4BJKEjreiNRo+bO
         nGko3PLAqiuQT2tuBhCPqW7kE/zOFYdJBwNmT64Vm8lj6+XgppHd1r01xnuHFK6G0k8E
         SZ3meoX86ADgWUOzO8qNA5IGS9OFEDWb2CsIQOFm2xNJ9IYp32K4iKDzhAvKm6VcitR5
         PuMg==
X-Forwarded-Encrypted: i=1; AHgh+RoIodPkeZGBHMpuaYsgLYZNUrsPV4yMOoEQ6PIh3rZD2Moy8bYuARyIjoptOQmrU3l9b6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPwTzMECbndB7XyGfE4pF1UJgZzwZW47cdeNPY/o14fTK4Nlx
	vIYx9936WYWLrsdltZbgYnCMY9YovdS/M9vINxB2F86+TQiJX6nKUxSDau/oMT7n+iekP3UFZnM
	9bM4xg1rH9C1BBgRqacf/07tNUPF4ndDCGmVowfQn
X-Gm-Gg: AfdE7cmlM/eVWPG4taf/pH87i6cJ3lbp+i/1vPbi10KlHwO7HMU0yeXlCRJoO6qj4Ak
	4M5jS22zuQryYx5VzyTkgmGg9Q6Ozqv32YCbSA9KOndf7bpEaju2Ux0U2lzd/OGoz+M9qxA4P+H
	W/PgrQoWgXczQ0H0E7uWuajc8uM7/KDLtfQTzaNFxVzTTyIiT4CAhNArLQud6mtPMrE0qr1aMzN
	Qd6u5AAGjQU3mtyZV9ZsYe/MVdCzplz8ePFs7N6XhLadNZKwMhd5lMOWIuEJeBVab5oixvL51Xf
	sImgEdqxROhcxhsgGM6YHFhY6SNwl9RhWZ/5pyl8iehOusFpHN+l81fnwww=
X-Received: by 2002:a17:907:398c:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c161de05ceemr462764166b.0.1783982420699; Mon, 13 Jul 2026
 15:40:20 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260713191727.GH674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com> <20260713191727.GH674038@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 15:40:18 -0700
X-Gm-Features: AVVi8CeLrPp9U0h6s0bW1dfkDuvwNQDlx835UcZJGSgXNK2eLWnyQH0juXRBY34
Message-ID: <CAEvNRgEvGmOK3dXD4qdw5uXYD2sXNEVGT9NV2Zz-4H8VPb+KUw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, pbonzini@redhat.com, seanjc@google.com, 
	alex.williamson@redhat.com, dan.j.williams@intel.com, aik@amd.com, 
	linux-coco@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	vivek.kasireddy@intel.com, yilun.xu@intel.com, linux-kernel@vger.kernel.org, 
	lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, 
	leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
	tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com, 
	simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com, 
	fvdl@google.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Jul 13, 2026 at 08:08:14PM +0100, Fuad Tabba wrote:
>> On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Jason Gunthorpe <jgg@nvidia.com> writes:
>> >
>> > > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> > >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> > >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> > >> importers to fetch these data. Exporters identify VFIO dma-buf by
>> > >> successfully getting these data.
>> > >>
>> > >> VFIO dma-buf supports disabling host access to these exported MMIO
>> > >> regions when the device is converted to private. Exporters like KVM
>> > >> need to identify this type of dma-buf to decide if it is good to use.
>> > >> KVM only allows host unaccessible MMIO regions been mapped in private
>> > >> roots.
>> > >>
>> > >> Export struct kvm * handler attached to the vfio device. This
>> > >> allows KVM to do another sanity check. MMIO should only be assigned to
>> > >> a CoCo VM if its owner device is already assigned to the same VM.
>> > >
>> > > This doesn't seem right, it should be encapsulated into the standard
>> > > DMABUF API in some way.
>> > >
>> >
>> > I'd like to propose an alternative. I've been working on guest_memfd and
>> > new to the world of IO, please help me along! :)
>> >
>> > It seems like using dmabufs are used a little awkwardly here. IIUC
>> > dmabufs were originally meant to expose memory of one device to another
>> > device, mostly meant to share memory. Dmabufs do expose MMIO too, for
>> > device to device communications. Without virtualization, userspace MMIO
>> > would be done by mmap()-ing a VFIO fd and having the userspace program
>> > write to the userspace addresses.
>> >
>> > Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
>> > VFIO fd and setting up the userspace address in a KVM memslot for the
>> > guest.
>> >
>> > With CoCo, is the problem we're solving that we want KVM to know what
>> > pfns to set up in stage 2 page tables, but not via userspace addresses?
>> >
>> > guest_memfd already does that for regular host memory, tracks the
>> > private/shared-ness of the memory, tracks which struct kvm the memory
>> > belongs to.
>> >
>> > guest_memfd functions as KVM's bridge to host memory. KVM already can
>> > ask guest_memfd for the pfn to map into stage 2 page tables, and already
>> > asks guest_memfd for the shared/private state of the memory. guest_memfd
>> > already also blocks the host from faulting guest private memory
>> > (mmap()-ing is always allowed).
>> >
>> >
>> > Instead of using dmabuf as the intermediary between the MMIO PFNs and
>> > KVM, why not use guest_memfd?
>> >
>> > What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?
>>
>> This is interesting for pKVM too, provided it covers more than MMIO.
>>
>> We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
>> only for device MMIO. There is mobile hardware that doesn't tolerate scattered
>> private memory (DMA engines that can't gather, IOMMU page-table size
>> constraints), and a CMA-backed dmabuf heap is the practical way to get
>> contiguous memory at runtime.
>
> Why can't guestmemfd allocate directly from CMA? Allocating struct
> page memory through dmabuf just to put it back in a guestmemfd sounds
> very ugly to me.
>

I'd like to understand this use case better too, is using CMA through
dmabuf basically because CMA doesn't really have a direct userspace
interface? As in, for HugeTLB there's fd = memfd_create(HUGETLB) and
HugeTLBfs fds, but not CMA?

I did hope for this API shape to extend beyong VFIO and HugeTLB to
anything that has an fd today, but Frank did bring up the counter point
that not all memory has an fd.

>> HugeTLB doesn't help, it wants boot-time
>> reservation. Those pages are struct-page backed, so it's a different problem
>> from the non-struct-page MMIO case, and the shared parts still need to be
>> GUP-able.
>
> Isn't dmabuf pretty allergic to mmaping refcounted struct page backed
> memory since that wrecks its lifetime model?
>
>> More important for the API shape: conversions have to work on subsets of such a
>> region, at page granularity. A pKVM guest doesn't know what backs its memory, so
>> it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
>> given.

For my future reference, does this mean for the CMA case, some page
splitting on conversion to shared (so each page can have its own
refcount to track users) will be necessary? (and merging)

>> If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
>> use it for memory, and the guest can't be taught to care.
>
> More reasons not to involve DMABUF since guestmemfd already does all
> of this...
>
> Jason
