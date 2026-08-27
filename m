Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CA494823
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857064; cv=none; b=QG3zZrWF3oJH1sUiFyB+s3ag1+OERhMBA1/LLmv7YIlWnBDouWa5gjLQCNdp7QYdTacIcaUZREnOIQjmetT1R+RhCTS0JMkR1zLR/TyXRz1Cfcv/p0DhkjIoXYOW+u8NM+RtlQ6HuPxXnEiIq1iH0rXY0Huh1E+/X08xjQmq7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857064; c=relaxed/simple;
	bh=mAHHUsoZXJKt4PRoppmG4agr4sysisrSRDaStOA5n88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIfDJU3rM2TqMbTYdm5gWipRw39+6kVtHkvBEMwyRpBUzBXHk+WV+NqQQR7iIUB++7Ov22IadMUdBU7AawoHj8LuIy9QkxcUqIDnxAiJXntIhpgh2L9csCpW1mryCifpvOJDWIcqKLc4ILswpmUIh3F5RSFN7nIirPj+j0ZxMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlis0DEG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlis0DEG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d3b445a84fso23235ad.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787857054; x=1788461854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aX0MxhiMRKYlP1maDxCRQnyd/bhRIltclM/n9JE7KG8=;
        b=dlis0DEGyv2KcKXGzdOrpBOVZpVyJAR8IA4qfkLZvlUZuRUYQ+6IbkaBCEIXsJzCbF
         3ogn/NdULyT2obZwY19zmLVGEQizjUTxACHzlYRNiRoOp9yXYjjNeo4PuKckwEfBa/uO
         NVGPLiefio6LKLB1J1cMYpezco3hA/l8KVDQ6fqpwTYHbYE/43/Q3QcfpN6BckTY0LZ7
         QUWEcQ7QxN/nn07lKabL7gIynJwHJ5+KLvLTuCiCQBNjHQFzxQpYqtor8+DUx1MUD3Tz
         jnirba/FXTlyp4y6jpAjIrYIKEz3ovx6efmNkel388vSR9XUFg3p0UTzFxvqLLBHPoca
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857054; x=1788461854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aX0MxhiMRKYlP1maDxCRQnyd/bhRIltclM/n9JE7KG8=;
        b=E49KrprIGOfWdL8B7BH0GMDjjmyl15GUVgVg4etaYtFOpqEYpS2r7WrZ64g3wTG4ss
         DSMjKzy9JUIl7G5U6zcYiltPi/B+z0SRvd9ZaFl0zjP+Z1IBvzTSG8uNjhQwx6aLFOgR
         RMF3u7w5UG3+BSqRefJ6HdnKjfUBCTNqqpfVFx7lJO1FaXcb4QlXC9MZc20M721vKMPh
         RlYRpynA4aPGf39Zal6A3IwPqMm5Lk/Xf2jD5m8+oGRsL5IOTsWYC39QyTVab9tzR/xG
         qgl+LdoCNpvgPs16WaLCGpjX2jGiHCW9h++3SKCIT0iGlqx7QLvfdNQ0zmn1laAhD7zU
         y/3w==
X-Forwarded-Encrypted: i=1; AHgh+RoRlr3tUN26G/hROHOJKnsx0+A5lMogcxJmVTMF2kUG7CNdJxqlt/+u7/LQjCc7gwEQOcc=@vger.kernel.org
X-Gm-Message-State: AFuF++nAfofKT42+xQZQD/eyyZwu4GuzF7JwFpP2V7B8Afvr4L3bz42d
	uakXKxZhGqEAOp1OXOTIrFxUHDGlS/UXPEPD+bnFspAMXWaQbTe5S9cLWqQpUTf+wQ==
X-Gm-Gg: AR+sD12/CkDlAt7y2o47uobGqCwiPrnt8CVXUpudoVa/ebtbpHr+797EjCgl3WPP1Po
	zJPs+knYXfXDtkTEOZo1/6/U1/F7m1c1o+dWUL+98GXI3WNFwYIYCxd+uZKsBLD48adjFpvU3y7
	lIf4CJgarSVD2Oy8kEfLnPfr4RdBemjm+y05LNnI7YhsnYRTqYg97baPA4kpw9EbMhoHzC2KGSJ
	N7doSk1glxCIuMiLw/GRZEHQ9RAGkipXwDiIP+2aY4klV5O8qI0P9Zfoq2+p+aP/4HXKt0kWd3D
	a7sE/J2qoGa8RnJOC2fckS9nAd8FRCLpsbuVXzgcW6fcIX9C3DDXSUBklVvwVo47+M4UsIOWdPX
	64ci+98UcOPnHStanjR82slYVsWb5ys3/QLuBTy1LGK/k4YP7OKhmnhxMmE4Bba1Qd8b4Z42tam
	de2VEearHppie54Ga40ntTSVd0/ZpHldP4AfWoCBykc2SR2vCrMrm1180DZKCXJ8QlOQVmNp6Lg
	8Dd9o3AK2WqrBSUB4IfCsnMldzjrooAi0x/xarmFQJz9XlQkSoo6Vszobc=
X-Received: by 2002:a17:903:2283:b0:2c7:a13a:7fe6 with SMTP id d9443c01a7336-2d74f558e3amr1143855ad.10.1787857053361;
        Thu, 27 Aug 2026 11:57:33 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d44651sm3782064a91.4.2026.08.27.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:32 -0700 (PDT)
Date: Thu, 27 Aug 2026 18:57:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <apCGj7ePWtmpnOzk@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
 <ao9ADjoGzgNX4t1M@google.com>
 <5862e3cc-e7e4-43be-a829-8569d12d6bb4@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5862e3cc-e7e4-43be-a829-8569d12d6bb4@linux.intel.com>

On Thu, Aug 27, 2026 at 02:09:26PM +0800, Baolu Lu wrote:
>On 8/27/26 04:30, Samiullah Khawaja wrote:
>>
>>>>+static void clear_unpreserved_context(struct device_domain_info 
>>>>*info, u8 bus, u8 devfn)
>>>>+{
>>>>+    struct context_entry *context;
>>>>+
>>>>+    /*
>>>>+     * This cleanup is done during shutdown, so it should be 
>>>>fine to only
>>>>+     * clear the entries here and issue one global invalidation 
>>>>later to
>>>>+     * invalidate all cleared entries.
>>>>+     *
>>>>+     * Note that the device IOTLB invalidation for unpreserved 
>>>>devices is
>>>>+     * skipped this way, but that should not be needed as the 
>>>>devices are
>>>>+     * quiesced at this point. This should improve the 
>>>>performance of the
>>>>+     * cleanup process and avoids any invalidation timeouts 
>>>>because drivers
>>>>+     * might have moved devices to D3 state.
>>>>+     */
>>>>+    context = iommu_context_addr(info->iommu, bus, devfn, 0);
>>>>+    if (context) {
>>>>+        context_clear_entry(context);
>>>>+        __iommu_flush_cache(info->iommu, context, sizeof(*context));
>>>
>>>For tearing down a present context entry, please follow the VT-d
>>>recommended sequence:
>>>
>>>- clear only the Present bit,
>>>- flush the updated entry to memory if necessary,
>>>- issue the required cache invalidations,
>>
>>Do we still need the individual cache invalidations if we issue global
>>invalidations (context, pasid-cache and iotlb), after clearing all
>>entries, as they would be done if a new root table was being setup?
>>
>>Looking at the VT-d specs (Invalidation of Translation Caches), each
>>invalidation type (cache, pasid and iotlb) defines granularity in both
>>register and queue based interface. And the granularity indicates that
>>Global invalidations clear the cached entries for that specific type.
>>For example following text is used for each cache type (in queue
>>interface):
>>
>>   Context-cache:
>>   Global Invalidation (01b): All context-cache entries cached at the
>>   remapping hardware are invalidated.
>>
>>   Pasid-cache:
>>   Global Invalidation (11b): All PASID-cache entries are invalidated.
>>
>>   Iotlb:
>>   Global Invalidation (01b):
>>   - All IOTLB entries are invalidated.
>>   - All paging-structure-cache entries are invalidated.
>>
>>A similar note about using Global invalidation is suggested in the specs
>>when setting up root table (Set Root Table Pointer Operation).
>>
>>   ... software must perform a global invalidate of the contextcache,
>>   PASID-cache (if applicable), and IOTLB, in that order. This is
>>   required to ensure hardware references only the remapping structures
>>   referenced by the new root table pointer and not stale cached entries.
>>
>>Also please note that this is happening during dmar unit teardown and
>>system shutdown, and while the context table entries in root table are
>>being cleared, the memory is not freed until the global invalidation is
>>issued.
>>
>>Since this is during shutdown, issuing global invalidations instead of
>>multiple individual invalidations for devices and aliases is simpler and
>>would likely also have shutdown time improvements and reduce the
>>blackout time during liveupdate.
>>
>>Please let me know if my global invalidations and granularity
>>understanding is not correct.
>
>The global-invalidation approach (similar to the “set new root table”
>flow) looks correct to me.
>
>On the device side: if ATS is enabled, some translations may still be
>cached in the device. My understanding is that unpreserved devices are
>already DMA-quiesced and then go through reset + reprobe (as in a normal
>reboot), which should flush those device-side caches. Are we aligned on
>that assumption?

Yes, we are aligned on it. I already added a note about unpreserved
devices being quiesced at this point, in a comment above in this
function.
>
>>
>>I added a comment at the top of this function to explain this, let me
>>know if you want me to expand it with more details.
>>
>>>- then clear the remaining fields of the entry.
>
>One important point remains: even if cache invalidation is deferred and
>done globally, we should still clear the Present bit before clearing the
>rest of a context entry. While Present is set, hardware may fetch the
>256-bit entry in multiple chunks. Rewriting the full entry is not atomic
>(it becomes multiple CPU writes), so hardware could observe a torn value
>(a mix of old and new fields), which may lead to undefined behavior or
>spurious faults.

Ah yes, I wanted to write that in my previous reply but it seems I
missed that.
>
>So the recommended sequence is:
>- clear only the Present bit,
>- flush the updated entry to memory if necessary,
>- [add a comment about the delayed global invalidation approach,]
>- then clear the remaining fields of the entry.

This is exactly my plan for the next revision. We are aligned on it.
>
>Thanks,
>baolu
>

Thanks,
Sami
