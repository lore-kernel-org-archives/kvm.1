Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059643CB2FA
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181344; cv=none; b=qavGVhGoW7V2nzv6tlRnB57jNGJLcNvxPz4wrBBpBufH4jhSgvuTUoOLRyc5Q9JZ198yIR0gk5spAdAnJoCTlupkR6C6MEH3sFk6O9sL6qbSScsRiL5Y5bZ7CXXk8uv5LRNGzvs+IsQe58GdeuwTB/Vn4ybRq82pNQgS60auAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181344; c=relaxed/simple;
	bh=RI04OnsvMB9uQ7ea/1UpgCPq9PltzrbbletOSbqIk8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC41X12oJ7tf+NK7O/8hIStPwv/TcOQJKJXCZe+w4MjfDpbkZI/8012bBiphuUBcpMaFI8Kfn2YKOiY9ikmaMUA+pgtIr9SgeAJn0DmwilZ2ADHgNyxx2QirtKkKjPhRwhC5/TUCfLosict+sMF7ATyh/cX0Lb6rOSBedJ/dSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nu66+NBk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nu66+NBk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so357033a91.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792181342; x=1792786142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9qKt714wTpFnQNXIMAii1yJHjNpuAXnTO+pThrST3To=;
        b=nu66+NBko4mS+MCnexIkWteafWvdP8iGNWAMoX85gcNo7kWOpBA/p5brN/GJOhO3Pl
         0F5fkKHV5WyujcFgmX1YhUiTp3apmWZl/GLIia3ihtKgGC+21Lqb0s1DcZNSu0smffbe
         f9uBfp3+8/iFamVbE5nKBs6q0/yVBPNEMxMg5ypLj/G/XTsqHd5fc/dXudjWa9DgLXiu
         ge0Gkwnn3qK1tu737mfBJXXb8lHa9vRDRxDrZWSD6TCKCadC44AD8pn/qKw4wPBWO0yq
         5KVLpceUqDl8VhKc7d2I8LttF/yyHNFnwV+rpOawAXMKYDVNQ6Sl26KyDZYwkeGU6Ti6
         2jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792181342; x=1792786142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qKt714wTpFnQNXIMAii1yJHjNpuAXnTO+pThrST3To=;
        b=I0t2A05G7C6yIomLCsZ5dNYukJF15BYh3/oIs1SE4J1aFeQ5e+YrerQjycyXAcCype
         o15YuYvGgfQw6aPFk/GqydWND05tf2L08MdOD8+WZn/S1lckCUawzxsqIUlIkH8Y4TD5
         mmuWJa/kUazBzeZdQRhLY96c6bX+aKQAt/a6VXlJ6LvRcaTdx3kBalXI5Wiq+UtFIqGT
         Jj6HQzM+ovnjYdQPvqShMm8bnFZggqnRum0TDKzQHPjIqJRSbm+RQE+xu54zHBQQjqEe
         iD65s81RF6oh0hXWLGeQmxK257llpF/DXGR1Rx+1aIy9Yq94HG7dHcUP735uI6sMS45L
         worw==
X-Forwarded-Encrypted: i=1; AKwUvBwgEc+OTyKp083Acg6Rv65TlMMr7vXsxQCeG6g5C6+PEADHVr+0PWtg5Q5QdDq7OWXBTWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz9twSOi61gDMBnhxmUh9ee9oS7H/Nb7GhGRIOoVDkyVSdYXwM
	5fFANdH8GXEsyeAUDMlLTBENzkwcqbFt52nJPb/Wln7DAI0Vecn758TsahbApZz6vcM=
X-Gm-Gg: AYBFou1IfWWTj1pPZjoFyGYiSjIvgP0i+h0a2DoGhQDIxkGwxdZ3s7a2pFojOq8Vv0/
	m9Wx3AevK9Y8wzbKIdHq3bzcXaef+mcqWSISKDVnst2TyFRG5VCoXTDo2aZd55SXe+MEouW0TtL
	Cge1GYJsrHPKmpuMomlE5haNoKQ+w7OlI8+p4LoSaDncc9UJZ40+FtFMa30vHaR6c1IxPnaoG3m
	x72ylbAeP5ixnXypr9DsfKmjhxEaVGM0Jo2a+i23gQdFeapvrOn7Ncteefhh2XRt3ciSRJgYD/y
	HRWNh/Iybanv8zxqtEadOFXFZBEGPeuX0MxtOzXmvPbCt1+3C+oRh/EaVkGkHuv4ZIM/sHT8V/B
	Rr2T4dnpwfpNQtcD9ST9DHhtzd578RX1YqJE+3Zs/nlp8ULMhnRsm/Cwwo497YOMaSb9EDA8QEY
	hOMsGViY0lPDpP/hIy3nCjwOgpn1L72L/SFcH0+lC9jMvcNPoVOutKY96G+w4Td9cFjjVUgFPOJ
	xx6dvnVLoWw
X-Received: by 2002:a17:90b:45:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3aceeb9272dmr792959a91.15.1792181342239;
        Fri, 16 Oct 2026 13:09:02 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc49c263asm5207912a91.17.2026.10.16.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:09:01 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:08:58 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atKEWmnXA-Gu1Y9T@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>

On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 76 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 9985f5daba89..c082a5d8f3d1 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -15,6 +15,7 @@
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/memalign.h"
> >   #include "qom/object_interfaces.h"
> >   #include "system/confidential-guest-support.h"
> >   #include "system/kvm.h"
> > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >   static RmeGuest *rme_guest;
> > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > +                              Error **errp)
> > +{
> > +    int ret;
> > +    void *buffer;
> > +    hwaddr size = region->size;
> > +    hwaddr base = region->base;
> > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > +    struct kvm_arm_rmi_populate populate_args;
> > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> 
> s/qemu_real_host_page_size()/RME_PAGE_SIZE

I refactored this function in V5 [1], along with the above declarations.

[1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/

> 
> > +
> > +    if (!region->data) {
> > +        return -ENODEV;
> > +    }
> > +
> > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > +    if (ret) {
> > +        error_report("RME: failed to configure initial"
> > +                     "private guest memory");
> > +        return ret;
> > +    }
> > +
> > +    /* Allocate page-aligned memory */
> > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > +
> > +    if (!buffer) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    memset(buffer, 0, aligned_size);
> > +    memcpy(buffer, region->data, region->size);
> > +
> > +    populate_args = (struct kvm_arm_rmi_populate) {
> > +        .base = start,
> > +        .size = end - start,
> > +        .source_uaddr = (uintptr_t)buffer,
> > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > +    };
> > +
> > +    while (populate_args.size > 0) {
> > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > +        if (ret) {
> > +            error_setg_errno(errp, -ret,
> > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > +                start, end);
> > +            break;
> > +        }
> > +    }
> > +
> > +    qemu_vfree(buffer);
> > +
> > +    return ret;
> > +}
> > +
> 
> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> is 64KB. The question is how do we know the added regions due to the alignment
> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> I guess we probably just reject unaligned regions if they're not expected.

To make sure I understand your point, please expand on what would be an
unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries. 

> 
> Even if the unaligned regions are allowed, they seem not well handled.
> 
> - @aligned_size is still 64KB instead of the 128KB ?

I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?

> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>   [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.

I agree with you.  That part was refactored in V5 [1]:

        memcpy(buffer + (base - start), region->data, region->size); 

> 
> > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > +{
> > +    Error **errp = err;
> > +    const RmeRamRegion *region = data;
> > +
> > +    if (*errp) {
> > +        return;
> > +    }
> > +
> > +    rme_populate_range(region, /* measure */ true, errp);
> > +}
> > +
> >   static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >   {
> > +    Error *errp = NULL;
> > +
> >       if (!running) {
> >           return;
> >       }
> > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > +    if (errp) {
> > +        return;
> > +    }
> > +
> >       kvm_mark_guest_state_protected();
> >   }
> 
> Thanks,
> Gavin
> 
