Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0594C97
	for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818096; cv=pass; b=RhwDSFVYFVMHkGMO2o2kCwgIucKRWCxF29vghRnh5IZVSEis6O+G0iM3gw6/i1p8itV4UzZU7tszu0TIuoI+10/5WBXcqZEyJ/6mf2Ji8ka6/9qUKz5dLhJX+fVeO+TvvqMYAP3Z8qkm+qmtZDPO+XQpzflR8aVYOviLClMBTuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818096; c=relaxed/simple;
	bh=R8xlg3RI6zLmG7lgrIZL1li1QImUsqosewBmuLTRodU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwR6Qd7yki1NqF+JmPbP/upL78QJ+76Zhi1WxC3qpErA61Nol9+cZj0nHxZ3JLweWgq6hGNgaw77MSLn2MLuNAJ8RvYK/4dLPV12F6wPQ8TWY+73R+h7XSOOrkXd06u78gE0OITLcNgnbE7TZWy5fzonkpYhbJBROglynu05hs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2Bcm8Hw; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2Bcm8Hw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so1414351a12.2
        for <kvm@vger.kernel.org>; Sat, 11 Jul 2026 18:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783818094; cv=none;
        d=google.com; s=arc-20260327;
        b=jrsm5I7wj+k+j77iewjCXf7hs35BSQXi4yv0vzcfrFHT9BMKWC+oscnymaqacLjWa4
         QvpaLjBWHWIHQ7NphDwfb+uYJ7ecEnRlFuGcZrQDzolpva6MJI9vdpCPWb5guLzbFSaC
         UKWdUxAt3RSbsA5XwmHwh0wEGfCb9zLMNmEnt+2xfv3wvrR3zhbjNkPJNwYmVsDjtyYh
         NO62s3vNxM2iOh9+dntanyORN53QvZCtW93zKLBaOPgu1DsIVULo95crdbXlTqkW2UTP
         NQGvI/Lg6gpcZQqQFwqcfqPrbMbwQzC8xAfBP6S2QvY6V0J0Z9b+qAivXXHlDxkO5CVi
         v4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        fh=Hzm4cuYzR3uiJoLVhotIhcu2Ult1VH2ZISzs9m3zGkw=;
        b=dxR9YLJjghe+4DeqYfH1BEUGk3ELALvKQBlAzc2j7eW6uu+RRbEfE0HuW7plLV2QsG
         cQTwBkknYTCAnXN+QS4rsoCrXKliA7k2FgxKNbwN3W1fxwu1/rdFunCRdf3ziirh9JTF
         Kyg4F1YqjTJmnV2A3SELpnGwjhpYftk2eHGDeh5z9ng+BaaLPs1joEmmrjcImxy/Hegg
         6dXdFAFuu60ATzjsB2dl4yMyTBrfub4IjpiC/+QBND3PxddqoYj1TN3M/Yidaaw4pKuA
         gfFHBSObD1LmM2t4szYVEUmmXa9ZvSnnf6vcOG6+O6kbk6OfWMGu/BVhx8wf+EJZ5KKe
         k7zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783818094; x=1784422894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=F2Bcm8HwvOLs7bxy896OiDRS7aOVkXzSRJUgxn73pPsUhRXl90cRBS7fWeF9Pq3i4P
         6WF4MlA/qmoiDZyT4/6EZCgWbHBs7BHU/SEJlV1KHoEKOTV509ukjVajnPveJcqhRLzA
         H4VeEjDgBH1i+to9Y+rirt/kVSzSt9LYgl7M8a0sh0p/lBukORhcnzPCxs6CDPwFEbGV
         ya9lBdjhTycogmawCL+ZGwIYaqxCx+drVf/hhVHlRxHBXHeTvlXHfcVH0/L0RGmPpq3L
         fUp6erk2+3hEnf9ynGSI5RbRvqqGid5Ng6zLWYZohb6uvBZX7A5VGQruM8nGFYeKrhff
         XAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783818094; x=1784422894;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=T8CgD7WZ0S41VGKX577nVm/3Djpp4/LvVOpcoES7hEJnc0owbZFDAfFREQowBQ2tjk
         f439nFFe8oR/ispznw35wc3Dtvbx/IdZpGln8Nj9J4zYq5ylKWts27ntCEiS8zwImM4f
         KF3rbfHu7w+hElquI94P0e+gt4SzlhgDAUTy5pzGUo4U7nCj5y2+Ld1UqQzD0H5h+2jJ
         PsVQiz44jWxhsDnKK6b0QGbkMoho/1COntOl22wEeYtY7rr+n3IZaZYr7H3V/XN2O7mK
         C74tDPO08hCduYvzSzpwRFMH4uD3O1DMqMkKwya6AA7iy/jCcc4O7O3qnz9i4KV5E2uN
         dsnA==
X-Gm-Message-State: AOJu0Yy6TECRwQQWw8O4gKsTiETE+mFG1NFjyng8192006ANF1DwGZ3x
	4XW5L4JzNUzzGEjyGW8VBYgo3NQaofrJ+Agep329NEJImh8l9/Vq/GQjKTxhy3QI772z9JNK8Zz
	+welsNhDxpmP0tLGnZOUm323rf8QVSdv8Fq54OVV0
X-Gm-Gg: AfdE7clF3TvC2CnfkYi4QnBOq9RyC53HlX5/nYW47CmSJF7E3ILbhCfgc6ONIQ9Feho
	XxX0zIX2yJGwnFU5Pin+Z7yAYcssD1oxtjC3LTg8/QcqSNTGv+q5D8RKeCPnTB39go74fNC4h/X
	FeuU4d7w6a+rxMuBLEK2BlC0EtFtjsAoW6Al9FrMKhFEGff/xaPwpk9d7dIpDJDp2sXtUr+Ty0h
	Puzztg7s7+hAdFvXfkpqdRhFwcBtUdHPYObgutUXvnNPaOrscCjolyKPrwMhLQWJCpmQuH1r2Ee
	XVtzaHA6h70hcK2VSZ1w+45XNJn8
X-Received: by 2002:a05:6a21:3990:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3c11075f8f6mr4812182637.9.1783818093599; Sat, 11 Jul 2026
 18:01:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20250602133009.GC233377@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 11 Jul 2026 18:01:31 -0700
X-Gm-Features: AVVi8Cd0bGOMjMsYrL4vU20fXx-xb2mKPsbs-m9K5p8jfizmd9no0laxFphKWjw
Message-ID: <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com, 
	dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com, yilun.xu@intel.com, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, yan.y.zhao@intel.com, 
	daniel.vetter@ffwll.ch, leon@kernel.org, baolu.lu@linux.intel.com, 
	zhenzhong.duan@intel.com, tao1.su@intel.com, linux-pci@vger.kernel.org, 
	zhiw@nvidia.com, simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> importers to fetch these data. Exporters identify VFIO dma-buf by
>> successfully getting these data.
>>
>> VFIO dma-buf supports disabling host access to these exported MMIO
>> regions when the device is converted to private. Exporters like KVM
>> need to identify this type of dma-buf to decide if it is good to use.
>> KVM only allows host unaccessible MMIO regions been mapped in private
>> roots.
>>
>> Export struct kvm * handler attached to the vfio device. This
>> allows KVM to do another sanity check. MMIO should only be assigned to
>> a CoCo VM if its owner device is already assigned to the same VM.
>
> This doesn't seem right, it should be encapsulated into the standard
> DMABUF API in some way.
>

I'd like to propose an alternative. I've been working on guest_memfd and
new to the world of IO, please help me along! :)

It seems like using dmabufs are used a little awkwardly here. IIUC
dmabufs were originally meant to expose memory of one device to another
device, mostly meant to share memory. Dmabufs do expose MMIO too, for
device to device communications. Without virtualization, userspace MMIO
would be done by mmap()-ing a VFIO fd and having the userspace program
write to the userspace addresses.

Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
VFIO fd and setting up the userspace address in a KVM memslot for the
guest.

With CoCo, is the problem we're solving that we want KVM to know what
pfns to set up in stage 2 page tables, but not via userspace addresses?

guest_memfd already does that for regular host memory, tracks the
private/shared-ness of the memory, tracks which struct kvm the memory
belongs to.

guest_memfd functions as KVM's bridge to host memory. KVM already can
ask guest_memfd for the pfn to map into stage 2 page tables, and already
asks guest_memfd for the shared/private state of the memory. guest_memfd
already also blocks the host from faulting guest private memory
(mmap()-ing is always allowed).


Instead of using dmabuf as the intermediary between the MMIO PFNs and
KVM, why not use guest_memfd?

What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?

guest_memfd can then take the mmap() calls from userspace and .fault()
from mm, and then forward them to VFIO or dmabuf. This way, VFIO/dmabuf
can stick to their original functions, and the changes to VFIO/dmabuf
would probably revolve around disabling access.

Disabling access would probably involve some of these:

+ When guest_memfd receives the fd, it could return error for existing
  mappings, or perhaps it could just force-unmap.
+ 1 extra flag or field to indicate that guest_memfd is controlling this
  file, so that if userspace tries to take some actions with the
  original VFIO or dmabuf fd, the request should be blocked.
+ Perhaps just close the original fd, like dup2(oldfd, newfd) closes
  newfd?


I'm about to restart work on guest_memfd HugeTLB and I'm thinking about
a similar approach for guest_memfd HugeTLB, where perhaps the interface
could be that userspace will give guest_memfd a HugeTLB fd at creation
time, and then the original HugeTLB fd would be rendered unusable in the
same way as above, perhaps like with the S_IMMUTABLE inode flag, but
also blocking reads, and not userspace-modifiable.


In the course of a CoCo guest's operation, will the guest need to
convert between private/shared MMIO? Will the guest need some pages
shared and others private? If these are required operations, guest_memfd
already provides the tracking and is going to have a conversion ioctl
very soon. Instead of further extending dmabuf to track more things, how
about letting guest_memfd track it?
