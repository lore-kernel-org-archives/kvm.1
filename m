Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282931;
	b=eE5HL30NMkr0Z/p9A71mzRxG1ig+criC+mRN5Q9Z8u8jmhdMUBnrBAVYXSFrqGUOUapN
	 kM3t7mXjG6EbCvb3/t8khk2BxLJDrlC2mCsSkuDaw79TWftaoM0PAIYqARruKy8Y9gcI8
	 Sgb18t8neL7UZLvsXTRnr+O9IyKo9xWKnALdutqQJ44gNR0IZ2NiM20DwETXLx8oOC7gV
	 VkRAEPbFfRzTLoZPoFG46ZR+HVG+AOIKSQU0v1yXU9ZYNAxvwM1VtKAbxRiUkqF8J7HS9
	 6wzZ87kU5o7Fg3KoovHnxWTrhEHJXUOiAZ2GrQU3QWnHItDV92zJ4/OVfj3YrsK5L5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
	b=wzBE0uTFRmN72/enE+U37j2gyfHO+vL+f1+19b8UyjOKVFzWhiBRdbFTZZRTJhNmxhPN
	 HymAUTUwjBgamdrdpwGN/a9QRYC77e8zSMlRUGewkmdLRGrK+6+1qU70viKbBQl+DkqoN
	 9b6tnMTU6pfbHWdkL1rOngV0rkwQR2m3/9EqRw5OlnaA+kNLqG8v0Hn9sQY7WGXkYvqSx
	 QHYc+cI0DioMHE/J0h1hRo30OSTgaJBGN/x0StH0kHIhJsVUHj7FFeTTPq5THn2Q5r5Yg
	 VwgrXzZXv1V5lRSK63N/qWB2Gzyr2mr8fUj4o20axB+xeJhg4frJTcidtICmumH+tTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtkFjV7g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE59606A31F
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE59606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtkFjV7g
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b9e758c50so10979936d6.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282930; cv=none;
        d=google.com; s=arc-20260327;
        b=pC7dImS+qVKCBmuH1RCMFKqoroLMWO6ow5zibzzymPhwn170Zw1ya/JTssobRbrBYD
         UWu1SEdMUxK7p22qWbkzu42wu4+DAPLHVolf+WTp13evYMqxpN6P/szcU/ktDn4MbHHh
         eTq/Xb6nNm00PW1B0w8nHbrR3lnAkrE7DYaAo+noGf8hF+G5uhGt/7mw2ePLzjlTrYrq
         yRhaWyE5xbRsnaTosB1fH4TVeOk9QGKPfQXJ0UDZbN1aROm0Cp5L8GQEv5C4mewrbndX
         FMmwfch7IXUx4kLPnL4y1irCBTZc+CkFMVqvIXL4BPQLoXglDizYPkfm1jJpHSb38Qo9
         owTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        fh=2tATt2IztrKT5qJzgMYFkwNwUUwu/supb8MMz6VSYY8=;
        b=kiV0sK3cCt8H2LsqzT6/zvZEMa5E2quvp6RX9Sy5u+h8jVJ9896idPfNL0rLn2cRtN
         gHl1Gd2MrUdMQPeIxT+JHdTqtz9rJU7QKnjFEWujZfR1Q6MjKFy0vQ29sqeBEn7EZBeg
         nMMtqz56oQQxceu2v+MjqKcuskXVsI4+fT8JFPWiaWgfHgFjuFW/XvHsMNEf8VtIe3hc
         4hMir6Y3KxsWfN9DoNV+Vfm/o/VDRVFt+6FCu/AYe4g4hH4SICOli/d8hcLWq651vDRL
         zsI3BYW4jC0hRmneoIXH3jDLSiqLA7u7H/OBCrxFsC72eDNwWo8UWScNAuX3EE+QbO9T
         pCtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793282930; x=1793887730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        b=WtkFjV7g0ToV00v8yrSM9PA1SDdq9vQXINOrbjuvFyIlNcULS0boES8NVv+LAPu9jP
         kzHrDUjXGPkksXhZAwKRjAutyaJ+9er85NSCUHcZbVprTPE37JY3YQg+yYmG/QSo4EZT
         ecJG/I3JBONTYDKc16JKyMZf1mNEbslwJ/QRdmjBI/qvFa+lmD5QuB2ZdETfc9TdRt0m
         ODIIsB/3oI65RzUha7T/uPMoyGLo28LuJ8Z6keo77+56WtI7+ZPw9RTo8lOwum0UbKdh
         zjqjxlil5mNQur53BosdHjickAw5W9X9hQ7L17cBiDiaDctrf6jsP9zjQmGmDwy5+NBc
         SRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282930; x=1793887730;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        b=oE3OaU/KDqMFpOhFTOqARtWFAu40WFK5YI+BfENO5vcItN15J7EEi0ZN8eRQROI8vu
         b56lsB9JDKxB3v2CChaM33Ugbe/FlrVIKXqv/neBjUaqiZWmhN2LvIvSuUg0Z9CYtb3j
         CETGFQAlU+bz2y7O+YJYLSRwq2Cyo35EyNP/8v4Z3XArZJYd7G7AV4/vwlY+zW/oX7iu
         ykf8fiD4UDIcxldHiJLGD4khBlMpgArfyik4ywnb//e43FJPBfpX1DX38er7bguI+/TZ
         7saeC1q8o8XO748KGRQd0mCSqvoSovHuGhayhInx2dBdiWMRW+w6wBBdR54dD72QgiJE
         P5LA==
X-Forwarded-Encrypted: i=1; AKwUvBwsZ1SP8pYewyf+icuhBw0OlSH4YXEHd2Cn0aTmXKxIngSEfzhbq4STF3Yei+OCikunpzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+RYT6bM7hdhatLxGjfmX2h8JUDev5U9tMgJhRw15HWC85yDkd
	3+RZ0ZD9VL7xxhH/v7cA+NDs7sVtvUOKSe5+NerGUq12Ome5CkPD5SB2Kkjq695Dt/mmPQ7LALt
	4y5PcZfL7TBeXq6DJ1iA3tT1oB30IeHJOPDV080ot
X-Gm-Gg: AYBFou3wQgcGNuz4HRz8hu+I88mOnnlptxY8B/V8BJu5jYXMjmWH9iDJyLeZS3KGn7U
	zz7ufaiiNBLw8tjh1QCu+op8bv0ZQdQs/C19Tj7TdMG6w7rWmtavhFchZdnXE4QIDnzEbu5NIdb
	cvg0dKbsEHALXZud/8HIGrHPn+3FeSQJrh87QuaFWv8NpVhztiuxPRRxM2biYkaLroyyAuBrPO/
	NdPwL9cGuEun6rCgUGvuMP7a37/BPVghjb7NC2BHCqlH+oxs4UjbXHwZ+il1yNQQSTWio6iBwMf
	JhyIB+2JP6sCvCRo5wsWTb+Kuudz+VwIKZ9Bed6uqBPxknPvh06cUFUO9tQ0TXp+1A8ehyrDYGC
	QmkG4dYmv61TvcwABAER9ZFrhm4Mu8sjwiVFFaPmW3W/y76QuFiWj5lORbVARwwbDcQ==
X-Received: by 2002:ad4:5dc3:0:b0:917:9703:48b5 with SMTP id
 6a1803df08f44-91c90742c32mr40775726d6.26.1793282928607; Thu, 29 Oct 2026
 07:08:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 07:08:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 07:08:47 -0700
X-Gm-Features: AclHuK_fk7ikZ1Ry_rR0lNw1rkr7m6j782yki2DT2D_WNr6A4h89KzpbSsJWlnU
Message-ID: <CAEvNRgFb5zLkTph_9k3io=7UD6S-j3QPnjE3qVTvzeGZxEJSHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] KVM/VFIO: guest_memfd support for device
 MMIO resources
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds a guest_memfd device-resource framework for exposing PCI
> BAR memory to guests. The intended use is confidential device assignment,
> where KVM needs to coordinate private device mappings with shared access
> through VFIO. The Arm CCA backend is provided separately; these patches
> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.

Thank you for this revision to guest_memfd + VFIO support!

>
> The guest_memfd framework and Arm CCA backend are available together at:
>
>   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-da-gmem-backend
>
> Userspace creates a device-backed guest_memfd using the ordinary VFIO
> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE and
> GUEST_MEMFD_FLAG_INIT_SHARED.
> The resource mapping superblock selects its
> provider; get_pfn identifies PFN-backed memory. Eligible BAR intervals are
> registered as guest_memfd memslots.

> File offsets use the existing VFIO
> region-offset namespace,

Yes, this is great, thank you. I think we should have guest_memfd and
VFIO share the same offset to PFN mapping.

> allowing one guest_memfd to cover multiple BAR
> intervals.

Yes, this is an advantage I see of using guest_memfd to wrap VFIO too,
instead of requiring separate memslots for each shared/private range.

> The device-backed guest_memfd fd rejects mmap and fallocate;
> shared guest faults obtain bare BAR PFNs from the provider instead of
> resolving the memslot HVA or allocating folios.
>
> IOMMUFD resolves and pins the device's existing vDEVICE after its backend
> validates the VM association. Its MMIO mutex coordinates conversion and
> device state changes. VFIO supplies BAR PFNs, validates eligible ranges
> and excludes dma-buf exports while a guest_memfd provider is attached.
>
> Without GUEST_MEMFD_FLAG_MMAP, attachment rejects existing VFIO BAR VMAs,
> and new VFIO mmap calls. With the flag, existing and new BAR VMAs are
> allowed through the VFIO fd. Attachment invalidates existing BAR mappings,
> including huge mappings. Subsequent faults use base-page mappings so each
> page's shared-range attributes are checked separately. Mapping the
> PFN-backed guest_memfd fd remains disabled (We can decide on this later).
>

I saw your other email regarding how to handle read/write/faulting
(mmap). I still think we should have all these be blocked on the wrapped
VFIO fd and have it handled through guest_memfd.

The gmem_device_host_accessible() function in this series has a comment
that explains this, which is that the shared/private attribute is
guarded by filemap_invalidate_lock() in guest_memfd, and so having
providers call back into guest_memfd is probably going to cause locking
issues. That's also what I figured when I was trying to implement the
integration with the sample memory provider in [1].

[1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-45-5dd1dc6c660a@google.com/

> VFIO BAR read/write, ioeventfd and userspace mapping faults check the
> requested range's guest_memfd attributes.
>

Thanks for calling out ioeventfd, this is one other backdoor to possibly
access guest-private memory. To avoid calling back into guest_memfd to
check shared/private status, I have these suggestions:

1. Treat the ioeventfd setup as yet another "mapping" alongside stage 2,
   host userspace, IOMMU page tables. For IOMMU page tables, guest_memfd
   will have to do mappings eagerly on conversion to shared since the
   IOMMU cannot handle faults. We could also "zap" the eventfd-to-VFIO
   connection on conversion to private and "map" the connection back on
   conversion to shared.
2. Take a shortcut for now and say that if the VFIO is wrapped by
   guest_memfd, always block ioeventfd setup.

> This series depends on:
> * Ackerley Tng's "Allow guest_memfd to be created using a resource (pool)
>   fd" RFC, which provides the tmpfs resource-provider API:
>   https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
> * The IOMMUFD/TSM series, which provides the vIOMMU and vDEVICE interfaces:
>   https://lore.kernel.org/all/20261008055955.4014342-1-aneesh.kumar@kernel.org/
>

For easier testing, is there a VFIO sample we could use? How about mdpy?
Is mdpy representative enough for selftests?

>
> [...snip...]
>
