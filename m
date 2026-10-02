Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33E223DCE
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933256; cv=none; b=T8FxkvyX19FvgfX1I6cUDLDOECoMAL1hcKGeaJhoIFsDLSEtWfggbuovPAx1FdHrdqd7lJJz4oZf2MIjPv0J22Skyfyr+9osE+VznlUI0wJSqrtg4Rlp2meIgpkJNKJSmaU8TDAs540MKigz4f88mSbReVZj4NX61UBDAYhccEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933256; c=relaxed/simple;
	bh=1J5uKQsL+Sw7Qe99LflIks2lWWfhdhmcN0UngYQNI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDriJdxJ3hMZt4WoMCB6cj8cUull55KczmfK7UIPzCdmYqR91t0GprZzkDmAXKduP7A01Ow5z+5nCLlhNiausCd9h9sOLlFnbRSosE/FsOLeKya/377GjPs84oPpJb5X5iPV9saoiF/fIgUbTfZcAVGTEApabgVdP9CWiR/YCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6YhVy0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6YhVy0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E621F000FF;
	Fri,  2 Oct 2026 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790933254;
	bh=sdF92FcaRvybcpGC5UwGt2780kuiZGnx+sDD25qOGeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y6YhVy0SuLIVscc1LTUdXoJ4kUXBDjI2mPhYHrfPwLjnhYJx3EjmhlMXu+5aExt0b
	 6fCHoaFCbDamh5Kz60WQWicwHXUcAA0aSOwa4TLRzGD5jEvNQiFxoynp8mTo5gs9C5
	 ue1dpD77T6Puvyszkrc15XJn5f0Zkjk29OQ5yPS6Dk4n3b66XjuV9myBvIOxmT1G7f
	 yPFHiQDfWHrUifvosGjgt7JnXXqA1rNqzb8Uv4S1U9/2HpIn7pI/ktFWj2I/L6Y3X/
	 pv5GzoZ0cs5DKM2q0osqzNZ8jPtSXwBzThk2UYUgGqBgjklqDYdh4xFlcvlVZzrpiF
	 YML82Vi1Gn6Pw==
Date: Fri, 2 Oct 2026 11:27:28 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <ar95ADk4pEL2K4hd@lpieralisi>
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

I think that IPA base and source_uaddr should be host page size aligned.

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

I don't think they should be allowed either.

> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> is 64KB. The question is how do we know the added regions due to the alignment
> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> I guess we probably just reject unaligned regions if they're not expected.
> 
> Even if the unaligned regions are allowed, they seem not well handled.
> 
> - @aligned_size is still 64KB instead of the 128KB ?

Yes, given how current code is written this is wrong.

> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>   [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.

I can't follow you here. We are filling a temporary buffer so that KVM can
populate from it ?

Anyway - we should refactor the code to discard regions unaligned to host page
size.

Thanks,
Lorenzo

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
