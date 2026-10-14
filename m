Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68123645D
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939456; cv=pass; b=B8R19Bp+KPS0pV3FSldhpd/RnvTNDP7BP2+vqltrnk3/tiWJN8XloNGdx7gO8ScIeDT8hUbRoStIIIx2LD6h7kH2mWg7qcm4BXDKajqTnly4O+EeTLGu70xucOlcXbbNI2+q7rZ57nJQEoea9AGGeoRRgYa54olvyAI9Y15XABw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939456; c=relaxed/simple;
	bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ+55IgCj2LRXimVKLz9/qTnYt+/JFAXt3cXLPS4mIaRPOjHN/4aFfyAEN180APOrhqKsJrqY51g49N8oNAQLgbNO79IafDLJxlzjn1hK/oiWsJKdaxUTA8wcc1BpqsbLU5nhWw+6b+veiU/Oyp7Jv3X2BRnUlaQMKxlRZf/ynI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYADnTgt; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYADnTgt"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5352a876d5aso47054761cf.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 17:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791939454; cv=none;
        d=google.com; s=arc-20260327;
        b=g/0CWhQHIqsEUFVg+nSkfKRwDRS1PSSih0a7sEFrTy5u2Y7Q1Z/jN1ArToTzlf6ugo
         oQ1/CTChhzdfpsHpREi3OWiSii4LQb5NpXfyEVihsYFvAOc1vLM53e/rIXv4qiIbBRzW
         ZljxoNmfEmX8XoCrdZViHAtCKxKqcRi48orQYgWHGRzXgkc44JdOkz8EjEVhMzB5menH
         UemGEFWEwEYDp0HSvsw1vu37+tdg4mTjrd7+rv+pa2pA7DC2O1a4FwCXXK9mKlXlCk4B
         LyQ/dNLQaxtXweN4Wn7j9EEX0q9AHjtCKJowV11YuSMfjFnJpJMYS6U849v1bVydknND
         QCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        fh=HewVLyHfeMiQE5qA0yai/xb8dXtnk1iQYDZoZMUzTjQ=;
        b=XoAzARhAPTxPTLL86jb3ERj8nEEPDuFUul1Zh0XzOse1Me59+ILrOxljGRohDRk1qb
         Esv1y2SB3Dpxff5FUjrrGqavAYg6UYvbGbDHSpqqSt9or0ZHoB3btopwlx7ZFfFH7feo
         AskHXGaH8feWf8oeGIQERN89/JODV8ZYk2Vac8iPBxnNzb931+tnVZN2+BfccxpnFEiS
         A00Sd0IjpGH4x+kFFCdujpAJEcxhOYT97EQSO3Hrue41/qtODLFTbuCKl3kjADON4Koq
         HEANNHTbUXPEqbrO8Y28VUexs7sQ6fmUTMyLKcY+7OJ3p6CToY6Xx4K1sA6T2sMhIUu/
         37mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791939454; x=1792544254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        b=pYADnTgtO/MBIpKX0GcPbGnt/HW/kCMpYmqE+FhDazUFZhcCG4AB5cnyaUIpuXJ1tX
         F5WfQET5xyNVW9pa9QycMrtgPVBzBgjPLKbyyaI50WH1FBjmDsofoC3Bqn5hBt0Z7nbX
         xF1Wg72lHB5pyO8uRIJfCL4bHIeTySskUXdIUsqVI+xhm+JhPcGoIkyS9NQFj7Kc+o4o
         0DWMpsvWGS5zGOklDGCkGtf/z+djgqlh6tjQeBhzOT7wric3r0mj9vaosCZ9e9jNGmpK
         WZfpLsw2EDHoFf2Lf2+yNFzyyQ0nJ6WUy9W3MwgDTwKN1lfRh2Pc7hl9SbfvHBcPzAg3
         fUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791939454; x=1792544254;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        b=dmRmJEi++DnM0R+h+0Lbo/2SOtC0rQZ77Qfc0JMSP8dq/QV2WFlhONHR6tA7mijeWX
         oIzVbS5MZ1py8M90JNmge8Yen5LJ/NgOjizN0n/EYg707qETZrxMmNa2KPqV5Rq6gWI3
         ZvSgdKpG7T3EDWnVqAeyGcYZUVJxBIuH7YEn7gKwLP7No1o4IJsteGjBxEKiocTxxLGE
         rl1dxTfeE8SZeEiSAQ0uJjA2CVTe0JZFtKUnzGFNgl9KWfWog6KYyQiR78ZXJuSxr46F
         H4aq5z/GlNlRtU2ovUQeTPJ1s53pBfy4+xlQwfN5U/7YTDs7G2OLgOXscZv9Y/VeVzmG
         biag==
X-Forwarded-Encrypted: i=1; AKwUvBxm7kcZeRcuosjkb5OEDrYkhJYkA+f8Msrpfng2XhP1YInDmfrPewFA1JcDRJIhVcUm8KM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0rkUnWAaktwujX9cne76ms+ljp+yotvH4wcmsjCNV4KX/Wp1K
	CIKrWiO0iayW+spSvLD/ragUTPJZwxnpfzUHfo0JmHCc0R4LX6Fv4qyFGbvNIvmOKgQvhtQh33K
	ByqeAnsA3rAjcRTbRSf1EBHZ22f/qIkxPUnBQiPwq
X-Gm-Gg: AYBFou250K1FL2jwO7e+e00WhiTb2TkzRQUSbleYbNzNHP8tY6GvcNleLgvvO8f85vL
	aHA91UfSxZFHuhSZ05U3VcBnCwGpaxdyc+mcXEVwhxe0n66hyKfpf+b/h5PDQsy0WyfuHoTs0e+
	zxAl9CDOZWelK1TO7Gl30taqC5ZlmN/pp1jI/FLPQnkRPM7c9UMt7QBEqBYy2m/N1zqIMPzfFDV
	cVTfFLfQJOJgljh560XlEbyhVcls9WEQgKRTO2gERHtguHZy3Gi/si+PPqBNvJuFk5MqmQsWMwD
	uKId3EyK5ehXPeyh7mpSnfx7S8A4FsF4/itRR8jiZnRjICWbYNbWpslIzJqRYWdmcJCQfUyEGjv
	6Dx0qrmLTsA==
X-Received: by 2002:a05:622a:1b89:b0:535:a5fb:644b with SMTP id
 d75a77b69052e-535a5fb697dmr226430261cf.69.1791939451986; Tue, 13 Oct 2026
 17:57:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 17:57:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 17:57:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261010072504.536230-1-aneesh.kumar@kernel.org>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 17:57:30 -0700
X-Gm-Features: AclHuK8IpfUaX1YzXwxxGXLTDx_2ZBXI8B7jbHF2vFIgFQSAyamwlt7EhEC2s9U
Message-ID: <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device MMIO resources
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds a guest_memfd device-resource framework for exposing PCI
> BAR memory to guests. The intended use is confidential device assignment,
> where KVM needs to coordinate private device mappings with shared access
> through VFIO. The Arm CCA backend is provided separately; these patches
> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.
>

Thank you Aneesh!

I definitely like this since it builds upon [1], the model where
guest_memfd coordinates zapping during conversions for the
provider. Please see comparison with the alternative at [2].

>
> [...snip...]
>

I have questions:

> Userspace creates a device-backed guest_memfd using the ordinary VFIO
> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE,
> GUEST_MEMFD_FLAG_DEVICE

With the model described at [1][2][3], I was thinking that the VFIO fd
would be the resource fd. I'm hoping that there wouldn't be a need for
GUEST_MEMFD_FLAG_DEVICE.

The plan [3] was for resource fd to represent just the resource but not
provide any way to access the underlying resource, so that after
.attach(), guest_memfd's fd should be the way userspace would access the
underlying resource.

For tmpfs, the example in [1], fsmount() returns an fd that has no
.mmap/.read/.write ops, which fits the plan above perfectly. It tells
guest_memfd about the resource, but does not give userspace access to
the resource.

In VFIO's case, vfio_device_fops does implement .mmap()/.read/.write,
and I don't think there's a better existing fd that represents a single
device.

> and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
> intervals are registered as guest_memfd memslots. File offsets use the
> existing VFIO region-offset namespace, allowing one guest_memfd to cover
> multiple BAR intervals. Device-backed guest_memfd rejects mmap and
> fallocate; shared guest faults obtain bare BAR PFNs from the provider
> instead of resolving the memslot HVA or allocating folios.
>

The model I have in mind is kind of opposite from above. Instead of the
guest_memfd rejecting mmap(), I'm thinking that the VFIO fd should be
the one that rejects mmap(), read() and write() once guest_memfd
attaches to it.

If userspace needed to mmap() the VFIO fd, it should instead mmap() the
guest_memfd fd. guest_memfd doesn't support read() and write() now, but
support can be added. The read/write for guest_memfd just forwards to
vfio if the offset range is shared and blocks if the range is
private.

For mmap(), for regular memory, mmap() is always allowed, but faulting
dependsd on shared/private status. It would be nice if the same logic
could apply to guest_memfds that wrap VFIO.

I prefer the userspace accesses to go through guest_memfd to VFIO so
that the shared/private-ness can be enforced from guest_memfd.


Is GUEST_MEMFD_FLAG_DEVICE there because GUEST_MEMFD_FLAG_USE_RESOURCE
tells guest_memfd to look up
resource_inode->i_sb->s_op->gmem_provider_ops but for VFIO,
gmem_provider_ops can't be stored in super_operations? If that's the
only reason, that's a very good reason to store gmem_provider_ops in
file_operations for gmem_provider_ops to serve different kinds resources
and include VFIO.

I also noticed the need to guest_memfd_register_device_fops, so that
guest_memfd knows the device supports being attached to?

What do you think of this: we have a common attach function for all VFIO
fds in file_operations that would look up the struct vfio_device to
determine if guest_memfd can attach to the vfio device? Actually, which
devices would not support attaching? Wouldn't all devices support
attaching? I'm thinking that using a device that is all-shared via
guest_memfd should be no different from using the device directly. All
operations should flow through to the device.


Regarding conversions, I would like to check: with Confidential IO, are
conversions at runtime actually necessary?

Is the only "conversion" the one when the guest accepts a device? If so,
maybe that "conversion" can be implemented by replacing memslots.

Pre-accept, mmap() the vfio fd directly, set it up in memslots.

Post-accept, remove the old memslot, wrap the vfio fd with guest_memfd,
set up the guest_memfd statically with shared/private ranges as the TDI
report requested and never allow conversions, replace the pre-accept
memslot.

> IOMMUFD resolves and pins the device's existing vDEVICE for the VM and
> serializes MMIO conversion through its MMIO mutex. VFIO supplies BAR PFNs,
> checks eligible ranges and excludes independent dma-buf exports while a
> guest_memfd provider is attached. VFIO host mmap faults, read/write and
> ioeventfd accesses check the requested range's guest_memfd attributes.
> Conversion revokes cached host mappings and shared guest mappings before
> installing private mappings. Other shared intervals remain accessible.
>
>
> [...snip...]
>

[1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
[2] https://lore.kernel.org/all/CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com/
[3] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf
