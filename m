Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12425B0B8
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912752; cv=none; b=iaXWH3gK3tjSgMJdN9QjViWV4kpTEMArAw1t1tOxvedKAO/mJCRkvtqyU0cUmkT8ezSyCH4SCGhJHvTxQs6EkxJBSQlyuKHS9ELha3byDmsnQ5b6o8ZwL9VqH3gJrqKd/1e2enkzfiKejj5Wy1McS/7ulkBqpUYu+dgKhAI/qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912752; c=relaxed/simple;
	bh=40CxDXt/B3p+o7pPRudwZy3MUKpdIu45Zsh1Hi3sJg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NymrZ84lEH9cvtS1gVCqL8XcGGZpcUOSKSMs/qluWR4uWKByfzbfOusxN3v3cIpdFswqPdP2NZUlcgunTUlSh4mD7gKbAaVFFohTLKtqw2dgH6jYxNujRWZqrDBkFVnXRH6YNGlnBqnZ2PMHgB88FavcPgvuo08ogCaWnvNG4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inoSRcpe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jisSRm76; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inoSRcpe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jisSRm76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790912749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOG04gR6jk7TC5RkNmLmTcyHuCdzIVz02xDk4zXcQjY=;
	b=inoSRcpeYNHfAccCf05ar5XMys/R4Q8thlaR1wL0HpqINy+vxf6pmKHtpMcCWE6UnEMlcS
	bm4m1iWhFZ7s9JaVoLdkhNaNi9g/WcBAyJGztlQPZ7xo4YT9pxf3gPQxdjFbrcFHNzGLhs
	kEf7JMDo9UR2IG7Gscy45sIcQwpXaHY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-u5OLtpXGPpqQyCsNo7cmgg-1; Thu, 01 Oct 2026 23:45:48 -0400
X-MC-Unique: u5OLtpXGPpqQyCsNo7cmgg-1
X-Mimecast-MFC-AGG-ID: u5OLtpXGPpqQyCsNo7cmgg_1790912747
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b6416441eso12097243a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790912747; x=1791517547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOG04gR6jk7TC5RkNmLmTcyHuCdzIVz02xDk4zXcQjY=;
        b=jisSRm76TYU39Kza+E6v2q2tvAJiodbNfIJtvmSxaBt4FBIu8CpkgLMb8wh93XKVCO
         e/UZRYX9RJyQBAk8TIcZlYI4U5kWypitJDDP7NzuCK48yAbZc/d3KsknN/bPKsy1Jcwy
         Ov12M8wRWl2H7S4g/1torGwUQpWT/n69/p1DNmfuhdFJcwolZGLycpG4k0QEH+2+249W
         UnvdAGBxOXctIXJaW2Ef4lD04HbAYdMj4ekhRVS9DBgs+1CxoH+RUxwBcXuq7ZfuUBLL
         NMR4BkR5D22H/00pa5Qw3kz3bNtM7yENvjapYPS+ctQei8ryEFE+WpPNB4wRo5kzW2Jk
         qckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790912747; x=1791517547;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOG04gR6jk7TC5RkNmLmTcyHuCdzIVz02xDk4zXcQjY=;
        b=B9ArcW9Hy+rZPKrzvOQaUo6DvxHrpQKKQO0CIxnM8GxSSVlc45TeYeplE0kT30TaV4
         RWCLrtKYXc7YDwj0mSaW/6FO2/9W8SQANvWnwSDaqPZawmju0XqLSMk7jIbsw2yYiztb
         Zr5RKUMrdE8ZI9p5PerkvaeR7bhD17oOuH7e+rLGDyQ2pEha98yHuobFA2hjxioJNaQq
         3fmMughAOEZ5L7krtrHDotNzLyRERDdHb6Aq3CFZ9IAsqvqoLiaZp9C2UnoorQz2O16P
         nOXb9RLgmGmlktVMVTYEhXbOB3Me+tm+v4E7iUavFNEr7bMqV3yWooSDGYp7ZIaU60pN
         x0LQ==
X-Forwarded-Encrypted: i=1; AKwUvByZBfksSroSSSAM8K/euyIyoEeascSghEkhDkP0Ee0h2YbCXCP5llmMVtow8UxC7hGFEkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuvwD8v1cVQMsXLsuKq7kjeo03PqlO2TTHBwFs/NTxbXopu4Y3
	+F1X/OVRGPgHUwOGVNm2VhrKbashOVksg+Z1eFFsZYRA6wgOjaEKZzyYc7JalyLjNoW2svYFK5M
	xOIc38qbg4f7fewVHYsiLP/8w/4Q5N4BmNJ+/iWWFDhlW5De+cQ9ENQ==
X-Gm-Gg: AYBFou3b1U8st+jIcuK5f2BVFyTT/O3E3EHSEBPugZaH8Gkq83DiOpb/53fWr8tnPI7
	FJiDOgfOfReUDta3UN60X48v/OnjHHiP+Vh7IRFWzLOdwVO/8ZJ44CxtjqZieV7uaxFyZqyxoUu
	i5OOzuMPAYmtJxkdMVk7j4RDiA0S3FNJ3TSp4CvJumPawVIiMI6dpGq9Is5xHr6kleVkZwowCt0
	shhtnebLCG4/29tZXEd5MOWfE10hBEjP1l65c1aDxd9jXOlGu+H7F1VtijOCL9SoZmQXLfQW6Eo
	XiY2bbXHYqXRC7b6XeREAdsc4AL9XsNru0S3e+v8hZy0CV/JXbQ1PY8g9g1H9P+Q6GUSt+Iqxrc
	k6WoZjTSfVD81uHSNRkhw+7GUCcBYlmcX4TDxu4SHEw==
X-Received: by 2002:a17:90b:4c05:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3a6ce3a9747mr1427605a91.1.1790912746999;
        Thu, 01 Oct 2026 20:45:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:39d:f4a8:75ef with SMTP id 98e67ed59e1d1-3a6ce3a9747mr1427593a91.1.1790912746533;
        Thu, 01 Oct 2026 20:45:46 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6e7401d04sm759255a91.14.2026.10.01.20.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 20:45:45 -0700 (PDT)
Message-ID: <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
Date: Fri, 2 Oct 2026 13:45:40 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-12-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Once the Realm descriptor has been created, tell KVM to transfer runtime
> images (kernel, DT, and rootfs) from guest memory to Realm memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 9985f5daba89..c082a5d8f3d1 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -15,6 +15,7 @@
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/memalign.h"
>   #include "qom/object_interfaces.h"
>   #include "system/confidential-guest-support.h"
>   #include "system/kvm.h"
> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>   
>   static RmeGuest *rme_guest;
>   
> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> +                              Error **errp)
> +{
> +    int ret;
> +    void *buffer;
> +    hwaddr size = region->size;
> +    hwaddr base = region->base;
> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> +    struct kvm_arm_rmi_populate populate_args;
> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());

s/qemu_real_host_page_size()/RME_PAGE_SIZE

> +
> +    if (!region->data) {
> +        return -ENODEV;
> +    }
> +
> +    ret = kvm_set_memory_attributes_private(start, end - start);
> +    if (ret) {
> +        error_report("RME: failed to configure initial"
> +                     "private guest memory");
> +        return ret;
> +    }
> +
> +    /* Allocate page-aligned memory */
> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> +
> +    if (!buffer) {
> +        return -ENOMEM;
> +    }
> +
> +    memset(buffer, 0, aligned_size);
> +    memcpy(buffer, region->data, region->size);
> +
> +    populate_args = (struct kvm_arm_rmi_populate) {
> +        .base = start,
> +        .size = end - start,
> +        .source_uaddr = (uintptr_t)buffer,
> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> +    };
> +
> +    while (populate_args.size > 0) {
> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> +                start, end);
> +            break;
> +        }
> +    }
> +
> +    qemu_vfree(buffer);
> +
> +    return ret;
> +}
> +

I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
is 64KB. The question is how do we know the added regions due to the alignment
([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
I guess we probably just reject unaligned regions if they're not expected.

Even if the unaligned regions are allowed, they seem not well handled.

- @aligned_size is still 64KB instead of the 128KB ?
- In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
   [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.

> +static void rme_populate_ram_region(gpointer data, gpointer err)
> +{
> +    Error **errp = err;
> +    const RmeRamRegion *region = data;
> +
> +    if (*errp) {
> +        return;
> +    }
> +
> +    rme_populate_range(region, /* measure */ true, errp);
> +}
> +
>   static void rme_vm_state_change(void *opaque, bool running, RunState state)
>   {
> +    Error *errp = NULL;
> +
>       if (!running) {
>           return;
>       }
>   
> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> +    if (errp) {
> +        return;
> +    }
> +
>       kvm_mark_guest_state_protected();
>   }
>   

Thanks,
Gavin

