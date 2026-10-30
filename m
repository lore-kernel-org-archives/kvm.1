Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392589;
	b=2d4+N/P86Sb7snuIJ5WG16wmCkPeDOi4Ms+fieA14s5x8mJWCOQkiA8UzZ32wUInIbbi
	 MkCSata/LSNgyHlArQuBlxwVSjeaKht2DqPJD9u6/AimdQpfqOHlMqHpYw13A/dvnbBaQ
	 0yQpvWBPYBMKD/fQDhEwSpfBDMmXEON/sHd85tmSOWKX8XlXUBcCyyoQYcB78IXxbSVw1
	 CgGvzqYxDBQ66tIiRO6wwg84V+duYgPaX10WZAAFUR9Bl6DIauzYMejJ3DNR2tzNn0Sff
	 /BvA55uMwGzcPtmDWD3mwvOsvoBhSrH3uSWhkeCy4EjGJdVGWoNhDg8z05mxL6XviPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
	b=jPErYd1LVcVj1r0/pa0Er696ExH78BVAo3groOasUbgcaOn+yfwvLbFhAHTW2IxrK4Rd
	 ulvSWpn1+wWmt9Qu3a3eESbfwz1Bv/jDTpuOl3aQ1dPq01sNdSoVVQRPMRSEme2QqcYN4
	 e6zv0t+9bR2YCc5r7Rf5f6H+c0hPoyVeeH+sLgYdbnGljqHC2/zj6R4XsIMUY5piQolJ+
	 BhvYd1qllyMbNWdvW+eDFWaIeawZeN8k188d9q/I5+6R5EMNG8ONN4euuC8sail+8ky6m
	 gE6ODQsProX6/JWoNCuD7buf4jo+RVZl/jj/usl5xI6GW5pTiTIuENSRqwQr5ut6+mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jT2ZxRM+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B2606A31E
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 20:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B6B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jT2ZxRM+
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533797e72e8so6882451cf.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 13:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793392588; cv=none;
        d=google.com; s=arc-20260327;
        b=UYOGH5wgW2uVIL9RXNaWrcZAMCp/RHysmQLfZFCePUDG/7cLoYCD/Boe9JzLr/z9F3
         72FcpBRvBxPI4YKaZ2IIuJ3nu1lTeO72R4G3PNPmrhL78yIit8t8zqeOI8jnLFnWFMeS
         w/8jdslq9U4GMjyLJps/gL5qJ80jo9atFAMDycFZHFvGGZ2c7n0HtJ4BvZkuwFTwREh8
         Xw5B/3zTtJ2R/mSVaFpJFSrAXH3aK8lfKLOZN0iMsWMr2t+WyQ6JnPvwihwgh+OKocno
         TiuCeQ369DLswhiHBqsi7qA/8Q2IMk0R9xqTTQKryZ2BqYwGufPNRcAZ4tG7y25ujmEn
         YQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        fh=sCemghWibzE9rAU/HsNl48gnTTE9GeLmj2DbXWEx5XE=;
        b=RHU9hb8jRK3yP1aWBe3vT6L9pgddx+L3dMogTYR8bnA/2CzZH1TaAi1zk9i5QHkGV+
         bCKcYLJ26XHVZi6KvIy0opbHdAv7pr/2s2ZcQaA+VQILV6g7m5hmkVXY/pmUbq4MDONp
         EdUs2sgU1seOjLS/R6ECUansD3UE6N9Y6pgdS7n/Iku+hguK6/60khamYyB0vK4omsvf
         DVCM1YZETWJ2ktWC7NEZdGcKfEkcdlyxFUMUu3q5F0qbSHC9TruYKhSkdECm6AAmKKhH
         DiZREuI7xSbqS0YEFSLaU130P1fLnmA3fPgpA4wx+THUA7lFDlNNnrpLWNunxLbEbFU2
         ifPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793392588; x=1793997388; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        b=jT2ZxRM+/yRo/io2XOH/K1FfzctfE3KgODsAU2qT3YqxJtyk7knft04qPnR5FJETR2
         IoD25FOwot0wvpz59LuLB5UlH+QOuRmd/qQsEJ/4HHl8PY1RMjLVvVN1Dh7QnXIO4SQL
         EeHjePn6cNbLkaNPwBcVLPJ303ndT0A9x5IlWFd/Vv843/8r4EmQKWnLSToy97JYJB+k
         dxqQzQADI/8qrQBTdEemYuysGKMsjAaQe5ezmiF1XPJjS558TsjHy1EkPGX7+RzIsuOZ
         uQ50X08YQHhqN4ez46QDgcQzoOuQlh5t0KFOd7Q0PWdY1sNM9o2X7aLDr5AqHmi5xPeo
         yCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793392588; x=1793997388;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        b=cS83JFBntsA8Bbhsu+eYGJDGSeRPUkTVACu8g3bZOmxIrnNT69wtclpXsO+VhdMWx2
         2jq++PGU00joBtMMd0bR/SWyAIKEMX9ivUxg+FYv7n+EWaJLzCpKlm9fV1kiKzEB7yO5
         bZnSgmMBlYX62uFnhG6C+vPVkjaBr2zMwbZQGyza3QWogY0MJCVXxeCP46vtDwc/crBH
         AT580LxKCbLxhwV9+G1CILrQ86HIz7fiNOdIbBz5ls/2BxhAYRspa6khgEDxMWvUALez
         tWIkh+wla9igWC9xUls4Z8mD3RADpr/ZzpEBMRmMjRWc/3aAcpIitLRUKyHP/XqUp9n2
         UHbA==
X-Forwarded-Encrypted: i=1; AKwUvBzrOPQUNFc4gzRy2kMym/ID4EeXbd+scSsD11J28duXoM51BNk97K4HMA/1fuEGT4Yl67o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIPRNOHRhYGCF8WAcFlgOs/lBeFk63F/hdpDHMap6lvaN9tYBC
	J9b5BK6b75+VYHQCFE+isUZ0I1erzIn9og/jxc3lCbzCvo6GKYopXoVSNmgyf2HYwwxShgUbZQt
	UMgC7IzZSYeKoxzbUU5cx7SeDeDQs1wkRJxelZk0m
X-Gm-Gg: AYBFou2p+fFpGqkVTwr+VUX5z/2opFM00NTLJakbaAx+E/qTIvl1nUaoRV12H5Br28Q
	1FBF0bmLsx8acLvsElYsp0IViNAsHJt4FgbOSQVN1ntPf5+TbqkfLGTQA5WdU9TaumI8CClobRJ
	qCAWcRUxEUJA4fWkz2NN5KtQJP6C0rM6gYB5Un5WiVtRMd6Wr5YjyYVpOH5YHPolTKRqFNb/IUV
	pbNB37oKXhB4ZyxScU4xOc+pLW25HcDPpRcvQrbA8U+hgxKngHPBH5TpE8sqiEofZQrItOl51ls
	qxm3rme+R0LQr6SyCsd2Zxgz/xtMXFRuk+onqXxQ3WBwp5ev47+D90ADCR4sxRpWdOeHa1xWLKL
	FlW+vYxT0qVbtHeses/DtKi3OembjL3EBECrIWBNuZYzjhhjgeIbYLctFodKsaOMEp7oUl3qrRU
	+BgfwCEpKufLBka8Yql0p8qg==
X-Received: by 2002:ac8:5c94:0:b0:532:af50:8d7d with SMTP id
 d75a77b69052e-542b6a6d6b2mr54363611cf.33.1793392587437; Fri, 30 Oct 2026
 13:36:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 13:36:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261017073149.1303738-3-aneesh.kumar@kernel.org>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org> <20261017073149.1303738-3-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 13:36:26 -0700
X-Gm-Features: AclHuK8zIRE7fPt_40jzHY6DMSgwjgRywbF83YSieVT16EbHUHdKI8X5dSRrGPc
Message-ID: <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
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

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

>
> [...snip...]
>
> +static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
> +		pgoff_t nr_pages, const struct guest_memfd_device_request *req,
> +		const struct kvm_memory_slot *slot)
> +{
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	u64 attrs = req ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
> +	bool prepared = false;
> +	int ret;
> +
> +	MA_STATE(mas, &gi->attributes, start, start + nr_pages - 1);
> +
> +	filemap_invalidate_lock(inode->i_mapping);
> +	if (__kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (req && !__kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
> +
> +	ret = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> +	if (ret)
> +		goto out;
> +
> +	kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED);
> +	if (req && READ_ONCE(gi->device.kvm->vm_dead))
> +		ret = -EIO;
> +	else
> +		ret = gi->provider_ops->prepare_conversion(gi->provider, req);
> +	if (!ret) {
> +		prepared = true;
> +		if (req)
> +			ret = kvm_gmem_device_make_private(inode, slot, req, nr_pages);

Is there a way to avoid making private from within the conversion flow?

kvm_gmem_device_map() below already does it as part of vcpu_run.

If we do the above, we'd be aligned with regular conversions, where
to-shared conversions eagerly update arch state (make_shared) but
to-private notifications to the firmware are done lazily.

> +		else
> +			ret = kvm_gmem_device_make_shared(inode, start, start + nr_pages);
> +	}
> +	if (!ret) {
> +		mas_store_prealloc(&mas, xa_mk_value(attrs));
> +		kvm_gmem_device_update_private(gi);
> +	} else {
> +		mas_destroy(&mas);
> +	}
> +
> +	kvm_gmem_invalidate_end(inode, start, start + nr_pages);
> +	if (prepared)
> +		gi->provider_ops->finish_conversion(gi->provider, req);
> +out:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return ret;
> +}
> +
> +int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
> +{
> +	struct guest_memfd_device_request req = { gpa, pa, vdev_id };
> +	struct kvm_memory_slot *slot;
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct file *file;
> +	int ret;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	if (!PAGE_ALIGNED(gpa | size | pa))
> +		return -EINVAL;
> +
> +	/* Caller holds SRCU across the pending architecture request. */
> +	slot = gfn_to_memslot(kvm, gfn);
> +	if (!slot || (slot->flags & KVM_MEMSLOT_INVALID))
> +		return -EINVAL;
> +
> +	if (!(slot->flags & KVM_MEMSLOT_GMEM_DEVICE))
> +		return -EINVAL;
> +
> +	if ((size >> PAGE_SHIFT) > slot->npages - (gfn - slot->base_gfn))
> +		return -EINVAL;
> +
> +	file = kvm_gmem_get_file(slot);
> +	if (!file)
> +		return -ENOENT;
> +	ret = kvm_gmem_device_convert(file_inode(file),
> +				      kvm_gmem_get_index(slot, gfn),
> +				      size >> PAGE_SHIFT, &req, slot);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_device_map);
> +
>
> [...snip...]
>
