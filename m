Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738725;
	b=2XBWkDpEF9IeEtX+Ud1G/lMBOxmiSjTbC9P/BZ5Jv0XxsZjF7dJ1HFTWIRLU/50Fo1I1
	 35eLMSOXyPFgmmzZ8hmMy7tMJgyDirkmiguv21Eq/YSyeJWUiJ533lGIn2NP5oujtQWlR
	 ZH6CYpeKkb1f2Gy/cxvvutV7tsq2tCJL2xRJj+dyDPtvvj+Q/Gw6+usVy7eYsS1gUS/cL
	 NZIj0ZHaY9ry0GcwoHcpHJv7d4GYbSvSn4wesq8ONbs6c6Lkkr+Q2mBWH1pIas9puf5HC
	 dnLKeMyJSK6Gc5OtNzD/A5IwY67T7JsmI22RejxYYk6dqjpEGcZXWZGO9xI+HoeWgHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738725;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h3CjNfApqm1G3rihN7r2fU4pCLRo4/ubore+n9nJHlg=;
	b=Q9hl+pIrU4LsikhTYbK3yGCu5ZDxv2kW7GrirYVd9Od8dvpdfKAc0EBi2npl8Jtu+SZV
	 1uWe91QgRJo8XFr2MhdZ+436N9v+3bzHKjPTAVqAB5C7OT+cjZPq+XA8HP/xb9jJlYGuE
	 IgZYZVOQbcr8LvXoaC8wQ7vIo38urEvjkX5n8xaQzUGx8WlRHmcwEE4I4X/G7NtDx8Bnm
	 GPtuafXRSEqhVsJ2dcg0QnMYnAEecYZeYZCF64IfwiL7CK5hzxjMfJjyo8vlBJN7KN5Mb
	 c/gE/X4cMuNPToHZ+w9yAJ03UdIoXZuUXtZqOXNtCZXHjsxHVuK1PBvJtJGHXJdHJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJopjG3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB3606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJopjG3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD6B1F031E1;
	Fri, 23 Oct 2026 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792738724;
	bh=h3CjNfApqm1G3rihN7r2fU4pCLRo4/ubore+n9nJHlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJopjG3AO3RvXjcn+zIkTsic7mt7FBpHt4ZZNwWb9fwifC24GKEv4ofA/yGOr+Mha
	 m4g1zZ3cwgo4MSnhDdNTR7Lcc90/eRXMRFKzLFFoRtlq23fQSDNQCalw3xti0GEUYj
	 NO9CnqqHGT+/UaHG+C5XyakGRkFcFQfBtYNseOkzAqVxrBRKdyjAJ8fyp8CZG0tZ1v
	 71W6JTwo/FDuLrAXRGHMCIHg/nrDwrHzbRvkt7+hkA3mIyv2LvFygvc60Iv5GbifYm
	 JPnOF2Vs2Do/xj0E5ykOKMqXaJkIlUCLeOjqADPPr6ICkATRwA8+XEqRMaAskdmo/j
	 hnQADc8zvGV7w==
Date: Fri, 23 Oct 2026 08:58:38 +0200
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
Message-ID: <atsFnklBAg73Smes@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
 <atoe77pJ119cDcSF@red-moon>
 <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>

On Fri, Oct 23, 2026 at 09:30:36AM +1000, Gavin Shan wrote:
> On 10/23/26 12:34 AM, Lorenzo Pieralisi wrote:
> > On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
> > > On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
> > > > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > 
> > > > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > > > 
> > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >     target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > > > >     1 file changed, 76 insertions(+)
> > > > > > 
> > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > > > --- a/target/arm/kvm-rme.c
> > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > @@ -15,6 +15,7 @@
> > > > > >     #include "migration/blocker.h"
> > > > > >     #include "qapi/error.h"
> > > > > >     #include "qemu/error-report.h"
> > > > > > +#include "qemu/memalign.h"
> > > > > >     #include "qom/object_interfaces.h"
> > > > > >     #include "system/confidential-guest-support.h"
> > > > > >     #include "system/kvm.h"
> > > > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > >     static RmeGuest *rme_guest;
> > > > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > > > +                              Error **errp)
> > > > > > +{
> > > > > > +    int ret;
> > > > > > +    void *buffer;
> > > > > > +    hwaddr size = region->size;
> > > > > > +    hwaddr base = region->base;
> > > > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > > > 
> > > > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > > > 
> > > > It will always have to be qemu_real_host_page_size(), KVM configures it
> > > > that way.
> > > > 
> > > > > > +
> > > > > > +    if (!region->data) {
> > > > > > +        return -ENODEV;
> > > > > > +    }
> > > > > > +
> > > > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > > > +    if (ret) {
> > > > > > +        error_report("RME: failed to configure initial"
> > > > > > +                     "private guest memory");
> > > > > > +        return ret;
> > > > > > +    }
> > > > > > +
> > > > > > +    /* Allocate page-aligned memory */
> > > > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > > > +
> > > > > > +    if (!buffer) {
> > > > > > +        return -ENOMEM;
> > > > > > +    }
> > > > > > +
> > > > > > +    memset(buffer, 0, aligned_size);
> > > > > > +    memcpy(buffer, region->data, region->size);
> > > > > > +
> > > > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > > > +        .base = start,
> > > > > > +        .size = end - start,
> > > > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > > > +    };
> > > > > > +
> > > > > > +    while (populate_args.size > 0) {
> > > > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > > > +        if (ret) {
> > > > > > +            error_setg_errno(errp, -ret,
> > > > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > > > +                start, end);
> > > > > > +            break;
> > > > > > +        }
> > > > > > +    }
> > > > > > +
> > > > > > +    qemu_vfree(buffer);
> > > > > > +
> > > > > > +    return ret;
> > > > > > +}
> > > > > > +
> > > > > 
> > > > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > > > is 64KB. The question is how do we know the added regions due to the alignment
> > > > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > > > 
> > > > Getting back to this because it is important. Can you define "safe" here ?
> > > > 
> > > > I think it is VMM's role to load with the required alignment and make
> > > > sure it does not double populate (that is anyway prevented by KVM), what was
> > > > your concern here to make sure we are in agreement ?
> > > > 
> > > 
> > > For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
> > > host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
> > > and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
> > > TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
> > > by the second population.
> > 
> > It is not allowed by the RMM and it is a VMM bug that we have to prevent.
> > 
> 
> Ok, thanks for your confirm. It's why I asked if we ever see an unaligned
> Rom region. If all Rom regions are aligned to host page size, then we needn't
> to handle the unaligned Rom regions in rme_populate_range(). Otherwise, we
> need come up with a solution to address the issue.
> 
> The solution would be to generate a temporary region list based on the existing
> Rom region list. For each region in the temporary list, its start/size are well
> aligned to host page size, and the temporary buffer is allocated, and the data
> is properly copied over from the original Rom region. The population is done
> based on the temporary list. For example, we need to have [0 64kb], [128kb 192kb]
> regions in the temporary list if we have Rom region [0 1kb], [4kb 5kb] [16kb 17kb],
> [132kb 133kb], [136kb 140kb]. The host page size is assumed to be 64kb in the example.
> 
>    [0 64kb] covers [0 1kb], [4kb 5kb] [16kb 17kb]
>    [128kb 192kb] covers [132kb 133kb], [136kb 140kb]

That's exactly what needs to be done.

Thanks,
Lorenzo

> Thanks,
> Gavin
> 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks,
> > > Gavin
> > > 
> > > > Thanks,
> > > > Lorenzo
> > > > 
> > > > > I guess we probably just reject unaligned regions if they're not expected.
> > > > > 
> > > > > Even if the unaligned regions are allowed, they seem not well handled.
> > > > > 
> > > > > - @aligned_size is still 64KB instead of the 128KB ?
> > > > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > > > >     [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > > > > 
> > > > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > > > +{
> > > > > > +    Error **errp = err;
> > > > > > +    const RmeRamRegion *region = data;
> > > > > > +
> > > > > > +    if (*errp) {
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > > > +}
> > > > > > +
> > > > > >     static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > > > >     {
> > > > > > +    Error *errp = NULL;
> > > > > > +
> > > > > >         if (!running) {
> > > > > >             return;
> > > > > >         }
> > > > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > > > +    if (errp) {
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > >         kvm_mark_guest_state_protected();
> > > > > >     }
> > > > > 
> > > > > Thanks,
> > > > > Gavin
> > > > > 
> > > > 
> > > 
> > 
> 
