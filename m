Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6A3D9023
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529861; cv=none; b=aWXyAONW5qTssIromFfaA1UEUKHoeDumN5yJ0tIHkpZb+65SJ2DiLyTe+rAa2SwaafsazOhYzw+ZjcFvtINqkfNnriyFm+iAcYto3de7Gkzq6YbMPEDL98guUM+jl16nCRlLSepRXZPoUgQDgRlv2Ay5GHhpZ6nFO9mkZ/XhyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529861; c=relaxed/simple;
	bh=8p9pX3f/Jni4/804dN03aY2QgzvCn8h0nT7REjf25z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7F3/4TxfxdKhf57RU2pEiFCKsH15lRw/aGmLaUDHHB9jMelfR63vvO23YYiO7dTn/AQgIobd1ttKOOa3vlkHV5nzmT6gReLa9fRgALZHoaO6Kmbz0awHCHIFRx0o5k4BMWw1C0P3cGNtv2E0wcI5Gw0xn2x0KUfcwj5cdGRxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1XL0SMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1XL0SMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529859;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMGOFQALV7U5ZmaS0qjL9QRN5TZgiLFu8RShunh6mL4=;
	b=J1XL0SMPzeN/pTsTn3S/K6tNYeB0An6MfrpPUR6HRP+hNs0Sn3AWmRFK4jyM4aA9GuqfMF
	dE/ENOqDvQCg+GbI0VKt5MiyTN9kAE5G8PeLtX+kE0ILAk++EBeATZwlOROpGvAXNKAJoy
	hI78IusMHhoky3KWonVD3vWfpC52GpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-jpBiMpqnOCirmW93qEET8w-1; Fri, 04 Sep 2026 09:50:57 -0400
X-MC-Unique: jpBiMpqnOCirmW93qEET8w-1
X-Mimecast-MFC-AGG-ID: jpBiMpqnOCirmW93qEET8w_1788529857
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48439eea716so753692f8f.2
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 06:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529857; x=1789134657;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMGOFQALV7U5ZmaS0qjL9QRN5TZgiLFu8RShunh6mL4=;
        b=pR0q+a47+sH2h9XFjS55ZDx0ZDWLSdLP8U8LxJniXDK48kGOCf2u5cv8xgaBS6LRHV
         oVmU5vFxlZlhh12vb2VK0AMCZiH00rU7Z87qyjB0csWttkNfGpSHvjTumJ9MJMr+5JCp
         rSgO2WsEd916SWcF4RFMlfQmtygB0O78oLbdbuuXLT4XZW9asMPpfigSImqYtC1gV+UC
         Hz3jRClBKL2HptJTE03fQ6vnzAzFtnSnKn0sYp4Q9G5eIz7jcCNiGeJosL/7Frgwg5U/
         +ufDI+nggn5vMoSexykPTsdnSfzuqNzoUmGCmLi2YfzOdHI+lzktZe89+g6aDs3GHjBw
         pNVA==
X-Gm-Message-State: AFuF++kbNh1xKNumY81FsTJ21HJi2Bs/yCnvWC39Snpsajn6xnfVo25h
	NY6Al6h9Ab+MBOilB8ub47jiPJ/kXtMVGRhnr47vHerqt4hHLMy45k4JKTCIpQ7wuRPiUsh8j9u
	vMBP5zuhN8BYpljg+Q0f3hqHHae635LraDr5rgA+yvpKTY2cGuJ80mQ==
X-Gm-Gg: AYBFou1HIa9ZJTosuyhlacZidp90CyDOiyS4hq2dpGxSAa4xDs+I2g1Nbds132/9aRk
	etQOcx6u3G1FznUA3SoopJRdVqAwaQO25gcaXp3gvRhtQKNHTPPZhS6M+s1kfpbPq0sEipAdhtp
	RVTFxFCDsCcwaImfRoKAe0LwwnOoMNCsvxs2VXktECju4w88GY6szY1+XmBPDiiglIwn7sSYgTl
	0+SOZPbrEEJVJVCz5SP8Gb3rKYOwC2m/tE0X3ZIt++JfuE92Wy8ZBx6sufOL6aLZo1/NkEnRrR2
	tZKPk6yRGso28rlj73I5a+U6ajsVP0Lw4LL2+Ngm68bnc+A6tPwOewEc2GdbJ7k8+ExULI3fPmx
	0bIB0eZvyA1iljVXNz/1TwL91/2SqE6cS3D2Sa1lusy6NCLRH
X-Received: by 2002:a05:600c:c1d7:20b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49cffe32f58mr2114035e9.3.1788529855656;
        Fri, 04 Sep 2026 06:50:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c1d7:20b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49cffe32f58mr2113475e9.3.1788529855165;
        Fri, 04 Sep 2026 06:50:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm172660985e9.1.2026.09.04.06.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:50:52 -0700 (PDT)
Message-ID: <75c62e73-0c71-4143-84ff-a1707ff822ab@redhat.com>
Date: Fri, 4 Sep 2026 15:50:51 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3] vfio/platform: prevent read-only region mappings from
 becoming writable
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
References: <20260903092907.419-1-suruurism@gmail.com>
 <20260903094814.EC02F1F000E9@smtp.kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260903094814.EC02F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/3/26 11:48 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [Medium] Modifying VMA flags post-merge inside the .mmap() callback silently breaks future VMA merges, leading to fragmentation.
>
> Pre-existing issues:
> - [High] Incomplete mprotect() hardening allows unauthorized read access to write-only hardware regions.
> - [High] Assigning a raw physical frame number (PFN) to `vma->vm_pgoff` for a file-backed VMA corrupts the VMA interval tree.
> --
>
> commit 6c3ce3b68057fa0dfd3b9b92fc8493eaac414153
> Author: Abdifatah Suruur <suruurism@gmail.com>
> Subject: vfio/platform: prevent read-only region mappings from becoming writable
>
> vfio_platform_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set. Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect(). This
> commit clears VM_MAYWRITE for regions without the WRITE flag.
>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index c72db5a99ebda..20d87c244ca28 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -595,6 +595,10 @@ int vfio_platform_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>>  			&& (vma->vm_flags & VM_WRITE))
>>  		return -EINVAL;
>>  
>> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
>> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
>> +		vm_flags_clear(vma, VM_MAYWRITE);
> [Severity: High]
> This isn't a bug introduced by this patch, but while this hardens the WRITE
> path against mprotect upgrades, does it overlook hardening the READ path via
> vm_flags_clear(vma, VM_MAYREAD)?
every MMIO region in vfio-platform is marked as
VFIO_REGION_INFO_FLAG_READ so write-only regions do not exist. I don't
think there is such symetrical need here.
>
> If a user maps a write-only region with PROT_NONE (or PROT_WRITE), they
> bypass the initial vma->vm_flags & VM_READ check. Since the region lacks
> the READ flag, the user should not be able to read it. However, because
> VM_MAYREAD is not cleared, couldn't the user successfully call
> mprotect(..., PROT_READ) to upgrade the VMA and read the memory?
>
> Can this allow an attacker to gain unauthorized read access to write-only
> hardware registers, which might corrupt hardware state machines, cause CPU
> stalls, or trigger fatal bus errors (e.g., SError on ARM)?
>
> [Severity: Medium]
> Will modifying VMA flags post-merge inside the driver's mmap callback
> silently break future VMA merges and lead to fragmentation?
>
> When userspace mmaps a subsequent adjacent segment of the same region,
> mmap_region() attempts to merge it using the proposed VMA flags, which
> still contain VM_MAYWRITE by default. Because the existing adjacent VMA
> had VM_MAYWRITE cleared by the driver's .mmap callback during its
> creation, and VM_MAYWRITE is not in VMA_IGNORE_MERGE_FLAGS, the flags
> will mismatch.
>
> Won't is_mergeable_vma() reject the merge, causing VMA fragmentation for
> adjacent mappings of the same read-only region?
Isn't it pretty unlikely that the region gets mmapped in several
adjacent chunks? At least for devices officially/publicly integrated, I
don't think this happened.
>
>>  
>>  	vma->vm_private_data = vdev;
>>  
>>  	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
>>  		return vfio_platform_mmap_mmio(vdev->regions[index], vma);
> [Severity: High]
> This is a pre-existing issue, but does assigning a raw physical frame
> number (PFN) to vma->vm_pgoff for a file-backed VMA corrupt the VMA
> interval tree?
>
> vfio_platform_mmap_mmio() explicitly overwrites vma->vm_pgoff with the PFN
> before calling remap_pfn_range():
>
> drivers/vfio/platform/vfio_platform_common.c:vfio_platform_mmap_mmio() {
> 	...
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
>
> 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> 			       req_len, vma->vm_page_prot);
> }
>
> The VMA is inserted into the file's mapping->i_mmap interval tree using
> the raw PFN as the index instead of the file offset. Won't any core kernel
> mechanism (such as unmap_mapping_range) that searches the interval tree by
> file offset fail to find the VMA?
>
> While remap_pfn_range() expects the PFN as an argument, it does not
> require overwriting vma->vm_pgoff for non-COW shared mappings.
the same pattern also exists in cdx/main.c, fsl-mc/vfio_fsl_mc.c

Thanks

Eric
>

