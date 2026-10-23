Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787148;
	b=e5l35pk2ZPO7ej8aV18W/9+kY5o6mLRA9jHSSm9bPRav7cJWjc4bKqu6Gw6iTftBF74Z
	 7IEg1QG9fNds2f9PXV4RzVZH7/VhSxakApjm1smrHNe11kbQG/6Vj58bdAZ8teSdIM5mw
	 Se6ML8VyS4vcjlrHxuuIJpde2P7tnusseZFd9wbTEHSTb+P/vy+Tccrf3ZBHitp/NV2LT
	 Q7vu1rNMhmSd/IxWIUKZZi/g/hucd2zETCQfWs1z9pxA3Pg/17UgA6p4H5cEmDQ6tSgwX
	 kU4Vt25F7Zm2Ia6XgeIVAV4Hezzrqs2qQnCuQxf3o7cS7HxImdgDkrn11QH3jAvwnSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HWEUe7jMIqDdmEz/IUXEovYVrzXcaS1CDzk92S0N4y0=;
	b=4fqYuXeKV5xqfuqdpWgWy+4jC5FaZRKI0pJKzMYiKeyZxjNpcOByPXKxlTdNpyAZQL/B
	 GVhiJ5ZKvLwplzfRkODxREpP7lYgILwZDusBrS2NHD/+lhGeaDoi0HEagd95c9XUFWKNh
	 sI5/XQAaEbLa2LPfUst0DxoyaKt/IPq3LEmW3wQLBdQ0JhWV3R6/jPxw+JBx7OmyLPDSa
	 z6HTOP9H1S9mX+Ca/DUWZcZz9/D9Zj+3PxIKnoC0sYkkwvL4C7IK1GeWI28E6RAf1rg97
	 ZO3O7QV7i1nAnnwWTOdADObrSJ+uTQXE8UJbjldK3V2or2ILS0yWe2TC6rypK1mJJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g8aJLCTB;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF1606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 20:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28BF1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g8aJLCTB
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1003409a91.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792787147; x=1793391947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HWEUe7jMIqDdmEz/IUXEovYVrzXcaS1CDzk92S0N4y0=;
        b=g8aJLCTBbLpdi2fWpcVq8rkr5yIVAuNoRKOIHOehlI8xui0G2Z2lOuGPxpue24ARaR
         +COg+ekfeCgGGuYHBhG6avqjfiBikkHnQA+WV3gprb0xgUeo5FQlUxW6b3ftIayFp+yS
         nA9v6733LyV3xL049tGJujkUxd5uFrzGjhqRp+8D9VPoBZh8EduCFzy7nBQjydpau0R6
         /aVkrlftkGc3cJT0plH1g5fcnLSeC4xF8qm3LrVCpwtjgVIzVJjMJMS8q+OIzKr0OQP+
         KfCn1AeOUFQPAxEjPGKYB+LSS4nC+crin8owiiE3qXZabS2hfNNLb3FoZu/fw+4S5tVN
         /ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787147; x=1793391947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWEUe7jMIqDdmEz/IUXEovYVrzXcaS1CDzk92S0N4y0=;
        b=BzJ6rzh8QDC7QYDMVLD2uCynP6Bomnv907MAb2gkhItp3LaCKIUHsHuIOQqu8FgT0Y
         3DNNmcL0/OFviai4TnUPSuNWFJL8U6ZeI9jthRq5ul3Yr6j0JgIAvqZyCjlSn/5LVzKs
         jJHPeTB6pg+AQpKfvC0FGcwEWjTxVe+SwkCzNOTMNWQAebvZ7HYThFagkrSxjibZX2lV
         2HczO1ZS+2T5kuGp4uSdQQegtAY6esp7SuOESwy18hAV8D8UjxKotm5qOgzb1AVYQoZV
         /rpnXW6munPBtDaHwd1PgA50eJ/EUHE/3Njyc2r70Xs7rLQ7pq6KCtd3BwzChevsNmvg
         IcqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdv3zsI9NAtPrVy1MMNzhcA9DuvQunOv59ORMYk/TvF6GGaIfClVQxYm4buD83h2xvNgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPOYQihXQbICLMp4QNHp99BZ59X2K1cNO+oxn3uwQ+EeHr6ttz
	gpAVSURcinzMh3DxMpWJFz947UMwLTVrM6AXhDRsy657mmIIrL+RGVEV/oVgWIooVdg=
X-Gm-Gg: AYBFou0KpomfsoLyiP9CMZuWbbIegKmQyBgKUHa3f8t+A6VPlshLG6Sqy2YOhRPKxYr
	puCwIkPvXEQzJ0y51Ys3fKYvI6Ryk/Jh+jbzrjLuRUUSNReqb8E+zkgrlw7uEt6zxX64Pn0gdP4
	Qvr5/9HPzyuxlzPnAdxeFX2zDMKgGWm47q1USw6pPECFva7cXUMWORJ6YHGFLEijKep7bLjzX5k
	IaJ+fRuBilqVZlnlGsgCZHt1/dpAA+g19YYR7e8MKYbFgN+YwNj3cRZKxAEiihPDIr+3oJnJjvK
	jeoG/fgpbk+mhiltd5QzQzww2cKSDOiS1/MKVKD3ulVU703gYVEO1mfi7wPx7DR1VWcb8tNJcYZ
	yTAX+rrmfo/TALoaXC3H4eQLpHdVmRa4Kxl9dVCTLK1MSxHfi+lIK4X/YddnA87EOCkrSrc2bDP
	Gs71beJn/qr5IbURqg2gtM0zA+yQ5Nxi9uOXozUWd609EkBCaKYT6YZSYgJj0JZylEAKWmU2eyk
	dV0TvW/hkdYQQPiwePdwoPg93sS/Wx0upADPwiZWNNN2JtBl3oh9ieCi8A=
X-Received: by 2002:a17:90a:d2c7:b0:3ab:5832:727d with SMTP id 98e67ed59e1d1-3adead5d229mr332494a91.35.1792787147293;
        Fri, 23 Oct 2026 13:25:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:435b:3f0e:f3fe:d04e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm313704a91.12.2026.10.23.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:25:46 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:25:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atvCx_Embi4sXAqG@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
 <atoe77pJ119cDcSF@red-moon>
 <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>
 <atsFnklBAg73Smes@red-moon>
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
In-Reply-To: <atsFnklBAg73Smes@red-moon>

On Fri, Oct 23, 2026 at 08:58:38AM +0200, Lorenzo Pieralisi wrote:
> On Fri, Oct 23, 2026 at 09:30:36AM +1000, Gavin Shan wrote:
> > On 10/23/26 12:34 AM, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
> > > > On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
> > > > > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > > > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > 
> > > > > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > > > > 
> > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > ---
> > > > > > >     target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >     1 file changed, 76 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > > > > --- a/target/arm/kvm-rme.c
> > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >     #include "migration/blocker.h"
> > > > > > >     #include "qapi/error.h"
> > > > > > >     #include "qemu/error-report.h"
> > > > > > > +#include "qemu/memalign.h"
> > > > > > >     #include "qom/object_interfaces.h"
> > > > > > >     #include "system/confidential-guest-support.h"
> > > > > > >     #include "system/kvm.h"
> > > > > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > >     static RmeGuest *rme_guest;
> > > > > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > > > > +                              Error **errp)
> > > > > > > +{
> > > > > > > +    int ret;
> > > > > > > +    void *buffer;
> > > > > > > +    hwaddr size = region->size;
> > > > > > > +    hwaddr base = region->base;
> > > > > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > > > > 
> > > > > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > > > > 
> > > > > It will always have to be qemu_real_host_page_size(), KVM configures it
> > > > > that way.
> > > > > 
> > > > > > > +
> > > > > > > +    if (!region->data) {
> > > > > > > +        return -ENODEV;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > > > > +    if (ret) {
> > > > > > > +        error_report("RME: failed to configure initial"
> > > > > > > +                     "private guest memory");
> > > > > > > +        return ret;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Allocate page-aligned memory */
> > > > > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > > > > +
> > > > > > > +    if (!buffer) {
> > > > > > > +        return -ENOMEM;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    memset(buffer, 0, aligned_size);
> > > > > > > +    memcpy(buffer, region->data, region->size);
> > > > > > > +
> > > > > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > > > > +        .base = start,
> > > > > > > +        .size = end - start,
> > > > > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > > > > +    };
> > > > > > > +
> > > > > > > +    while (populate_args.size > 0) {
> > > > > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > > > > +        if (ret) {
> > > > > > > +            error_setg_errno(errp, -ret,
> > > > > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > > > > +                start, end);
> > > > > > > +            break;
> > > > > > > +        }
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    qemu_vfree(buffer);
> > > > > > > +
> > > > > > > +    return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > 
> > > > > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > > > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > > > > is 64KB. The question is how do we know the added regions due to the alignment
> > > > > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > > > > 
> > > > > Getting back to this because it is important. Can you define "safe" here ?
> > > > > 
> > > > > I think it is VMM's role to load with the required alignment and make
> > > > > sure it does not double populate (that is anyway prevented by KVM), what was
> > > > > your concern here to make sure we are in agreement ?
> > > > > 
> > > > 
> > > > For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
> > > > host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
> > > > and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
> > > > TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
> > > > by the second population.
> > > 
> > > It is not allowed by the RMM and it is a VMM bug that we have to prevent.
> > > 
> > 
> > Ok, thanks for your confirm. It's why I asked if we ever see an unaligned
> > Rom region. If all Rom regions are aligned to host page size, then we needn't
> > to handle the unaligned Rom regions in rme_populate_range(). Otherwise, we
> > need come up with a solution to address the issue.
> > 
> > The solution would be to generate a temporary region list based on the existing
> > Rom region list. For each region in the temporary list, its start/size are well
> > aligned to host page size, and the temporary buffer is allocated, and the data
> > is properly copied over from the original Rom region. The population is done
> > based on the temporary list. For example, we need to have [0 64kb], [128kb 192kb]
> > regions in the temporary list if we have Rom region [0 1kb], [4kb 5kb] [16kb 17kb],
> > [132kb 133kb], [136kb 140kb]. The host page size is assumed to be 64kb in the example.
> > 
> >    [0 64kb] covers [0 1kb], [4kb 5kb] [16kb 17kb]
> >    [128kb 192kb] covers [132kb 133kb], [136kb 140kb]
> 
> That's exactly what needs to be done.
>

That is also what I understood.  My goal is to present this enhancement in
RFCv6.
 
> Thanks,
> Lorenzo
> 
> > Thanks,
> > Gavin
> > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > > > Thanks,
> > > > > Lorenzo
> > > > > 
> > > > > > I guess we probably just reject unaligned regions if they're not expected.
> > > > > > 
> > > > > > Even if the unaligned regions are allowed, they seem not well handled.
> > > > > > 
> > > > > > - @aligned_size is still 64KB instead of the 128KB ?
> > > > > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > > > > >     [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > > > > > 
> > > > > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > > > > +{
> > > > > > > +    Error **errp = err;
> > > > > > > +    const RmeRamRegion *region = data;
> > > > > > > +
> > > > > > > +    if (*errp) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > > > > +}
> > > > > > > +
> > > > > > >     static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > > > > >     {
> > > > > > > +    Error *errp = NULL;
> > > > > > > +
> > > > > > >         if (!running) {
> > > > > > >             return;
> > > > > > >         }
> > > > > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > > > > +    if (errp) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > >         kvm_mark_guest_state_protected();
> > > > > > >     }
> > > > > > 
> > > > > > Thanks,
> > > > > > Gavin
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
