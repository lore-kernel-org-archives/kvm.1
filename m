Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8493D1A99
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984568; cv=pass; b=X2BC1YrRP3Ay7/kZoVHtDjO2Zdl1JrxLTg/eMN7OfkNoV3KNROaE7BdMbkzSJvIi494AypjVu7aWgpaoc+4S91TxVjHZZmWqaaWcqu4yXgMpGpNgFgW4FeTeNWo3qPRbC169eZH1J5x/o/dJO3kObfwRvm514rwr54S1zYDqAlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984568; c=relaxed/simple;
	bh=jNitDBOyiAnqLYAVTV2WWuN1NaJEYQUlElQBlTgvBIA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK/b44Ej5PeVXmacDe//9EltNmlo1KfgX1KWvDI+mhtFWvSn7MD0FJlfQowKKhvUH1L9r7J/Jtir2oPNnT59w3Hq7whPGTvG5LwtsMdBFICXBxEnF91W8Boyu7715EmhelUNG7Yd98EeBenq/HZUDD4m1Hmbc5VLv6KVNUK3TFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtrAYmM5; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtrAYmM5"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2464911a12.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 16:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783984564; cv=none;
        d=google.com; s=arc-20260327;
        b=cVRWQpLupVXS3/b1NAmsf8yYEjs9Cp98CpNMLceKTcZN1VNxnuEfV0hObr1ruWkdK/
         tSf+LsuHQsm/Q7R7uV8XVDv+tu49DKLk0uoHjtknQ3yhuMkizu7OO0T65s7cXj/c25j3
         9r/XYLb+B5IfWkXRnIvTffUXIX1OyYKv+07bAMyc1tC9geSsjTnylDxQJBrFg2/lFig6
         Fy+fNlPHwtjfhyaZE7HTd9Tic3p6dl4vXnHmaUQTq6kvioQaN++r0v8ffKI/lsDzPqWx
         xXFFCGj+IwXkiXe1JXNYzMwoCsNQ7Eb9SG4lP4X8Qr5/d1Z7Gt7vNTKBQg9aT2o4yju9
         FCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        fh=medT0Y8yb5CpPamot5j0vSB8aDoV/9CxINFWE1YKmhU=;
        b=R8GXVgwDCIK38lDL+N2Wjq5fbLwAwf7YWp/ofjiEy2VkT42wBXnnl3Jgw5zRcYrwqJ
         TckB/SwyUYcXntCap2pPjrPFMiNdIiZUhSvg78Y/NtdZ9Riz6o4F117iFfMp7f3y0J7R
         TV4NOKVAdnIrknC+ddFy+CqZ6lrDg1kDz9CNNJ/XVy57riZjr4PQjJVrYTJ1cjG123Dr
         ACPhUa1C3WqHdDF6hLLTVmsY014lehG2psRzw/+YWkIfD3DsSX/bqGNKa85jgY0NH6Fe
         /ydsf5v3QwuuV/ZElnyC/cM1DefrpD70KCuCkqYBmeWEoE9gRdYUwha2TXbfRU7hdG+i
         4cvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783984564; x=1784589364; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=dtrAYmM5gcCKTMBJFLfIdvxLIN1TFGu7RAukrH3sgUGEoQIdT8jn7K/J0o1Ob92z8T
         a0cprolYrryzquVOKVdD9Tso/apjFQx0S/TWnaNDzT+4XKP8+TZVK4AJYQG+obu3DXBq
         oPXv+706nt3OtvYOng38qlKNuVbBw98VjmQZMMpw9xy4EDPIiaM3AFPrQrSI0vGXNKQd
         efsZF/YHau9aw97qE71JeoAQlOSlS859bm0v+3++nIT4x6FAjIMt/wlG5frQ9FXlar25
         BVqUYnbQe/TsL8Sr0LkuE8MunM54JmYxjhxr0hvppPg0JBL0pEzFq0FC6FlGAxqBiR8+
         ALDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783984564; x=1784589364;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=Wx2moV845BogMVXdS8DDCUmKwUHywS3C0426091g65nKLp0Xqt8aB9T1yqt9Cv6wiA
         A+b0DuY5Oc1g3Pu6jQA0rWi913aEW1ZNqYNyGLfXStG4sy+041yRdK3sZafkn9LkNONF
         EZ4kzukzPcBmDJ+uzlNeNncg5SdJ3K4fAgIpnNVk1TFx6q6qUM9j/CDqPfVn11bvd73y
         07eXzl00Jg5ainIcgKJn16Q7FQ1+SiGi7FnHH4zW64ninCJ2LewhfRFXqUW+b3nGycRR
         NUvVc6syeUBPt+01f/fgDyiQqQDfSg4PG3AFUTp2d2LMqhRnTsn6LK4MftYNyouXqRcV
         B43w==
X-Forwarded-Encrypted: i=1; AHgh+RqoW3THZB2dUL842DA/QGB8uwUm3Mm8YyZI5P72i5woGChaJGYwsKByD6eZEdJw1YbRfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxliNXg4iNKSeIQZ3vBj3GX+kBVn+l6roiwRN3wYxrcNGdeWKih
	oGKXIJhb3NVOKRZBJY82B3d2yEQ33Xk0ECI/VyhmFGA3iVYVslSzC3fBp41emBgn0bFlruB+cHm
	9Jj+gsgG4CeXP8rMLAVdUqxtceJrMs2lCODBvxWP0
X-Gm-Gg: AfdE7cl3DwOdeOg04wOwM4nyppJoZikdt0PCgAcZi+jvfFmLrVwAWtAilvQhxpLLoPb
	gyAE2drKU3V9/p2/V4R0+oCCmrDcIN/LVD0VIb/yk8ylgwnsgFuza9jgribHATF9GCmOyznXBrA
	7IvU6grn93FxIEi4WMN1U7sTU/BxcCxdgf56Tfha/Bk88X2MaYLWzGFISu3FRk1hTqcg6eIjTW9
	DFsy5m+4QilQriHlUu9HFAb/EPepcvBblD9VCJIcdEl3+yzcb0L8kOPu+8WD50QMbUa8k8pHMmL
	moUEgo9ITvPFur07bd6YYs41p3Wr1T7jaNKQzxhHJAIjLnvk2kEwM57OPUM=
X-Received: by 2002:a05:6a20:cd8f:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3c110a7b287mr11689858637.29.1783984563364; Mon, 13 Jul 2026
 16:16:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260712221934.GF674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com> <20260712221934.GF674038@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 16:16:02 -0700
X-Gm-Features: AVVi8CczeGanVcGdhsy5HlDfD2XYPmjZautNceRH5dXiMXcxQCHaSODxjV4xdX8
Message-ID: <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>
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
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Sat, Jul 11, 2026 at 06:01:31PM -0700, Ackerley Tng wrote:
>
>> In the course of a CoCo guest's operation, will the guest need to
>> convert between private/shared MMIO? Will the guest need some pages
>> shared and others private? If these are required operations, guest_memfd
>> already provides the tracking and is going to have a conversion ioctl
>> very soon. Instead of further extending dmabuf to track more things, how
>> about letting guest_memfd track it?
>
> Use another FD type was sort of my fallback if we couldn't get DMABUF
> into something workable. I'm kind of surprised to see guestmemfd
> proposed as the other FD, but I don't know much about its insides.
>

For now guest_memfd only supports 4K pages, so the interfaces we're
interested in are:

+ The .fault() handler, which core mm calls to service any page
  faults. For this, guest_memfd first checks if the page is shared, and
  if so, proceeds to return a struct page.
    + For VFIO, guest_memfd could call vfio_pci_mmap_huge_fault() and do
      vmf_insert_pfn().
+ The kvm_gmem_get_pfn() function, which kvm calls to get a pfn and a
  max_order to set up stage 2 page tables. Now guest_memfd returns
  folio_pfn(folio) and max_order = 0 since guest_memfd only supports
  PAGE_SIZE pages now.
    + For VFIO, guest_memfd would need some way to get the PFN, so
      probably something like dma_buf_get_pfn_unlocked() [1], but
      probably from VFIO instead of dmabuf. Perhaps pci_resource_start()
      is good enough to get a pfn.

[1] https://lore.kernel.org/all/20250529053513.1592088-2-yilun.xu@linux.intel.com/

> If VFIO can create one

At guest_memfd creation time, guest_memfd is always created for a
KVM. This is the first place where it is bound to a kvm instance. This
is one place where it helps Yilun with Confidential VMs, so KVM can be
sure that the memory was meant for a specific CoCo kvm and not any VM.

I think it might be weird to have VFIO take a kvm fd to create a
guest_memfd?

I was thinking that the userspace VMM could do something like:

  int vfio_fd = open("/dev/vfio/devices/vfio0");
  int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });

and creating from a template fd would also disable/close the vfio_fd so
that the following will fail:

  addr = mmap(vfio_fd);  // Maybe this should fail too?
  *addr = 1;             // But this should definitely fail so that
                         // guest_memfd gets to block private writes.

> and fill it with MMIO physical addresses then
> maybe it is OK?
>
> Jason

What interface would be used fill a guest_memfd with MMIO physical
addresses?

When a vdev is associated with a vfio file, can some other vfio file be
created that can also do MMIO to the vdev's PFNs? Would I be able to set
something to block any future associations to those PFNs? This will help
guest_memfd to prevent any other writes to private PFNs.
