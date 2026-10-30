Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793395143;
	b=FqQWPIqvCZLukJN6mOczrEk+DxFl8SOZ/ZTBORd0TMPqZq3+gSsUVGvwMQfwR3thsCFT
	 SsuH8ttlbCCGNhdCrOJZrBI9GCqGkd8berogNJcuH++ltbPV9QFHpRAkFAxjcY1M5Yfkd
	 jRVGtuGj2bn5NSNf1FWlaIqsU1+t2BOxcr073/LgjCA8U7jDNvMTdLrKdG3F5VS1BVsVp
	 VmCh+vT4ocTnPYVezEZX7qy0Lrhf9RKUqFFlRPgXkv+IsioxwY/rw58TO+xSNE36rPg4D
	 yldilZoSA/ZEjl4OvALAGBu2KooRF0ipqGnErddEiGDJaqwN2oZhEfHzPEmjW1fm4Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
	b=cM0V74AE+eVH3JwLhBpK7WkkiCi16L1vHwyYzXZI7tSwsX3mwts5HcTXCbyk4dE5ak2c
	 xLYtI3U38hdwfZ82ri11f6OwCMax9uUpKuMjn2yVeAXlJvxxJKVoZhtcc1sQBY7Q0Kkwj
	 0JDWzmNd7gbBLiOP0+1SllrNTXeyNRZAk+N5oQQ/JlL5qBhgnOu7JZaBrMIbKEN5l8PlY
	 aaEghuJ7ME/iqnC3/87POjox9fQw6F3oCqlg6MpoVsT2iDuUoHs7oP31KRT8ieRSB5XOl
	 4K2Re9wSY4atympFPxQgPChLJq9ZrvOdJOphv+s4obAOxWj24CuHU+wkj8QFJ0ygWiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XlTMXilF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848D606A326
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D848D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XlTMXilF
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b55859245so16943296d6.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793395142; cv=none;
        d=google.com; s=arc-20260327;
        b=T0FEsWGKKYydNKL6Y/cXmErdboTrMNE069ewKx4Fbk+LJY4IKsQxtXHOBWlEczD1Qa
         zsv/WB9vY6c4PpbymCU5HMyNETHcmTMXBV0d4AD9qtJu2URXTJJjpyOq0dZrgRFGl8mX
         oc0vYkmQ8CKGuGdjghtHNw1S/V46LwpxUFRKHh31rFLtG+QGzcV9Lc33ttEYYjosPDaD
         /8ivHRumwrnGiIGR3vZZttc5IXkdUrFE0zXzOvoCusuO4yTkQOcx31sEloeajy2x/OOT
         3+Vvp/Y0PYgXRp+mzAldmyEQqs/Q7PxY9xd8+PCUSM93XGhX9tEMNx3AlRwbYQ4ufBRV
         TvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        fh=DeyrYRssUgJg3AOKcRTou3r+kSwZ/sl7L6GqPSE79i8=;
        b=WpI6FIl1A+rRobi4bkhYbo5QVysFl58UagpkB68cSu+2LM7Ay6JPnbUKQe6wDC/Urj
         2QfL6QtIzU5Yp5wQYPjspE9+SGPy5iUMEkLeZCDX9XGO7CWkkIS7cQhmIAItFMc5LCgI
         Ifu5bOJvD1MHOCiPCIS9L3WUw5ycruV7goxjg+qvlj0xSUn+HfDDn7Gy3hHudKagkRHX
         /7Ho8PdMgZDwjy6+ohra1sbECPeLPZ9nqZMEitQsriXTuqrZCLRlsOTZ/7HS+7ZZehtW
         b56z9urmaxXej82NDJ3dWOfMfbvnMtvobBvWNdHterKUVtPPh1nTMbHJKF0hJ4vGEKzz
         jbXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395142; x=1793999942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        b=XlTMXilFKOMxoLlH35fro8troT9JUMR6MY3c4yhR7w1eLq5ZvQeN5X7GSej360noTB
         7KgKmNjKBlzfuYQA+AO15XthG4Bsa2COYsH7lrCkbuxo9BbcjbJqftrR2KvYnflcHhso
         hnNlulveH9LVtak7Nxgc/IRr7jN93aU6CP8EZyLihhOg8h5ST1FX+/L/1+H7Kt26FMJR
         9KDi3ZDqzQI6mNLpW068sRGos4X9RWlc3Evb63JvkXqlxmLTiLazg7V6AUACRJcBehAu
         QqZ3vTKi9Ebuyb5KKmlBH0InWpKKSJI/qrEkQSqItoBlNsxKycnt+NIaXNZixUqtA4NV
         63hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395142; x=1793999942;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        b=oCXwgwWQdfFY2rWFjkkcWBsHd1uRnezDGH3r/DTs4UQmDV5VANHue80hwbr+o9FOsw
         NuT4sWJndP8S8nTsAuaTBXTAE0x71pD9qlzhFV1UTrfTpVMElWiGRT3w+TomSnZq7MGX
         0HLpWULdX0izbcc7UjQHHx8HaaGbbnoU0AgaD6XyFlz0tJudF+jqY771FVNDMR1m28aH
         W8ciDe5sVkW+2ukgzEGAgU2rbF5n1Z5zChU+q2w8+oXRuad+ueuL1FhI+an+8sqALDWU
         ngSDitSO3YSkrPoBvhS1R2EFaIF71uBb5oLE5CNB0FTiuNkDXvMy8utjWqeaCwYtfgNm
         MKdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwhrddimGjmdxStd1M8Sp+GawN1FrWOAYEe6wvZrAW8A+WfdMDuNDVVzk8w2cmJuy27xA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuefUX0Io53IDweljfYg/1OuOKV3NPO/Jr6ssAmCFB91PGBVXO
	EqdP8fkF4+fqgbFVIhZt7d5rTuSgBK69ZkIcCHUohV8foCFvhtqqjODb3AyYrdoQ6JYtfgRvSUB
	n4jf2/iYcvjZNpnRmwMVqISyBG3nao2WqKvPE6JUQ
X-Gm-Gg: AYBFou14eMZIpY4vITNfuTZAFcGOtK7ZBIZ+WLkWEF2aTyJeo3PvcTCSsUBBc4LtbzZ
	fwI17JlNp55uGPzJBD3G9JvUYyolUnpc0UTbL/3jGJ/BB+BC8NBh5SN6mx5+9E7TKOsulQDwSco
	wU/C7esiJQga8ckpcrkYoI19AA5WXcGTKpDdLsRqLhplTFrMjKlUpal33jIllJD9/Pd+RfYSuFM
	4t5Q4k2KeRFJMw6E9HBb2oJTovcP2iQ9RYf50UxrBccTH/hqaZixtei5SCj5Ct1YKWWZS11lzub
	EA9dFJihx45o0JYh/LAA1PyqhRC4KV+j+Os4VZ+a/D+zzYwy/OdHbG+qgN54JR9lnbGuljDQbsQ
	Iqo3cDuIpc7HOv1zwBI4a7iPaHc0iDh6RQ7Z81Lhr6+3VKu/HwNp2s/cSgYjSfIRwpiI3WoWUdl
	ZI3djvE79u1/LAKTGFeFNYKg==
X-Received: by 2002:a05:6214:240a:b0:91c:450d:8f34 with SMTP id
 6a1803df08f44-91ca4bce34emr58846786d6.46.1793395141110; Fri, 30 Oct 2026
 14:19:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 14:19:00 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
 <20261017073149.1303738-3-aneesh.kumar@kernel.org> <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 14:19:00 -0700
X-Gm-Features: AclHuK8aNtmB7JK_qHjJeH9V34MC2DCp5vnYn4fAUI82UUtxS3pHz4MfNJXrVPA
Message-ID: <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] KVM: guest_memfd: Support private/shared
 conversion of device memory
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

Ackerley Tng <ackerleytng@google.com> writes:

> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>
>>
>> [...snip...]
>>
>> +static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
>> +		pgoff_t nr_pages, const struct guest_memfd_device_request *req,
>> +		const struct kvm_memory_slot *slot)
>> +{
>> +	struct gmem_inode *gi = GMEM_I(inode);
>> +	u64 attrs = req ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
>> +	bool prepared = false;
>> +	int ret;
>> +
>> +	MA_STATE(mas, &gi->attributes, start, start + nr_pages - 1);
>> +
>> +	filemap_invalidate_lock(inode->i_mapping);
>> +	if (__kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs)) {
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>> +	if (req && !__kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
>> +		ret = -EEXIST;
>> +		goto out;
>> +	}
>> +
>> +	ret = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>> +	if (ret)
>> +		goto out;
>> +
>> +	kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED);
>> +	if (req && READ_ONCE(gi->device.kvm->vm_dead))
>> +		ret = -EIO;
>> +	else
>> +		ret = gi->provider_ops->prepare_conversion(gi->provider, req);
>> +	if (!ret) {
>> +		prepared = true;
>> +		if (req)
>> +			ret = kvm_gmem_device_make_private(inode, slot, req, nr_pages);
>
> Is there a way to avoid making private from within the conversion flow?
>
> kvm_gmem_device_map() below already does it as part of vcpu_run.
>
> If we do the above, we'd be aligned with regular conversions, where
> to-shared conversions eagerly update arch state (make_shared) but
> to-private notifications to the firmware are done lazily.
>

I was a bit confused above. IIUC to handle
RMI_EXIT_VDEV_VALIDATE_MAPPING, the conversion is not done from outside
the kernel, instead it is done in the vcpu_run completion hook.

Can we make the flow that userspace is required to do the conversion
request from userspace after an exit due to
RMI_EXIT_VDEV_VALIDATE_MAPPING, and then just do the delegate + map +
validate in the vcpu_run completion hook?


The rest are a little outside the guest_memfd field, but I'll make the
suggestion anyway.

It looks like delegate and map don't need the vcpu context, only
validate does, so validate has to be done in the vcpu_run completion
hook.

Delegate needs the host physical addresses, so we'd need to translate
the IPAs to PAs, could that be a VM ioctl? It could look up the memslots
and translate IPA to PA?

RMI_RTT_DEV_MAP also doesn't need the vcpu context, IIUC it does need
the VM context so it could be a VM ioctl too? If it looks up the
memslot, it'll also find the guest_memfd, where it can find the device
information.

I'm just thinking that the vcpu_run completion context is doing too
much, and there are so many possible errors that could be better
communicated to userspace if they're separate ioctls.

Or perhaps at least delegate + map could be one required ioctl call by
userspace before doing vcpu_run to continue after a
RMI_EXIT_VDEV_VALIDATE_MAPPING exit.

>> +		else
>> +			ret = kvm_gmem_device_make_shared(inode, start, start + nr_pages);
>> +	}
>> +	if (!ret) {
>> +		mas_store_prealloc(&mas, xa_mk_value(attrs));
>> +		kvm_gmem_device_update_private(gi);
>> +	} else {
>> +		mas_destroy(&mas);
>> +	}
>> +
>> +	kvm_gmem_invalidate_end(inode, start, start + nr_pages);
>> +	if (prepared)
>> +		gi->provider_ops->finish_conversion(gi->provider, req);
>> +out:
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +	return ret;
>> +}
>> +
>> +int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
>> +{
>> +	struct guest_memfd_device_request req = { gpa, pa, vdev_id };
>> +	struct kvm_memory_slot *slot;
>> +	gfn_t gfn = gpa >> PAGE_SHIFT;
>> +	struct file *file;
>> +	int ret;
>> +
>> +	if (!size)
>> +		return -EINVAL;
>> +
>> +	if (!PAGE_ALIGNED(gpa | size | pa))
>> +		return -EINVAL;
>> +
>> +	/* Caller holds SRCU across the pending architecture request. */
>> +	slot = gfn_to_memslot(kvm, gfn);
>> +	if (!slot || (slot->flags & KVM_MEMSLOT_INVALID))
>> +		return -EINVAL;
>> +
>> +	if (!(slot->flags & KVM_MEMSLOT_GMEM_DEVICE))
>> +		return -EINVAL;
>> +
>> +	if ((size >> PAGE_SHIFT) > slot->npages - (gfn - slot->base_gfn))
>> +		return -EINVAL;
>> +
>> +	file = kvm_gmem_get_file(slot);
>> +	if (!file)
>> +		return -ENOENT;
>> +	ret = kvm_gmem_device_convert(file_inode(file),
>> +				      kvm_gmem_get_index(slot, gfn),
>> +				      size >> PAGE_SHIFT, &req, slot);
>> +	fput(file);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_device_map);
>> +
>>
>> [...snip...]
>>
