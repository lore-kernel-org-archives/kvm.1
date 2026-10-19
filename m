Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441434;
	b=1G9EMcaAiYWW6JCA0n98rSLCdDqKFyAKclu8vB1Gqh8ms/BendogM3oUmAnsIF9uYHKL
	 KX9RUG4wvJbkOYpRdnLchXXAG1ju6xIfnEFPT+s8HTYpaa9IGzvJf6jt3sQLCDovwHkLu
	 hdzaxrYLWWk488ZvZoYORMGh8qOirdGN8oq4LFg2klwiMOsXX6XlOoDF5DbhpWG8HgQLC
	 PtVgzIapa/yY+KNbP+/bkzbPlmPnJs4WJ9I8fQ+hXafAS/BnRtsxyFhB+W5hhQrINkS2c
	 wqOvUPJ9x+xJXrQwsz8+IMRx+BFH5N9JKGhysMjsYF1UvmO1YilnIJnxPIQJuH/RGkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gAVvIbf3n7kTx1Uv7q3TSJJCpEWn7N4psAyYUl6HiU8=;
	b=A0dqQZ+f4Ioclt1pHJYsFvhklSr6nYbRLaX4dlVfCichdsyT6IeOT8Kz9ndqfqSBeU0r
	 7TjEfxlufYoil7Dmv79IHiDg3JStd00noGppFL4iigv+wKqmMG8MBDmm07Pf1CpcyVlJx
	 s9g9SlnKxrd0v+w9v1/MNkq7y7zZ1ina2OaNTK4qBliZo6qf4sHbWo/9gA6boH9wuBp1b
	 MTaun0/NSEYvV+SsmNIQIjT4A9Rh8IQZch6NwpeZ5h9chCsgl/gcaWe3+uOXtA3JU7S09
	 qIbKei6LfO7PISXAsYISl4x6OxD1+bqeJ2lIQRXt+228oMI02xup427GHPkfQHym6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eNNnZZeT;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52EF606A319
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C52EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eNNnZZeT
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f85edd210so1140041b3a.2
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792441433; x=1793046233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gAVvIbf3n7kTx1Uv7q3TSJJCpEWn7N4psAyYUl6HiU8=;
        b=eNNnZZeTHNuKSdqFt4ratEuAu4zkers0n+LThDDWGcqSf1picbjzOHuwACSVyla4DM
         Qv4id/DUmuxCaYpDNoNuUQ82A/NHztdewfMG9JP68FE/l5qpdZM5vMoa7KqPoXL0f1yO
         KMOui61OipHlhRWycJCVe3N2zdER9wyZPtRuzo3q5UIBeoU8ngwR+OJ9RgRJWmXoZTGv
         7yh4d2HcGkJR8GNRGJZWb6+BMondQxfIrvp8v7SnVMIFCECrjF0AF7u5w2Wg1yNagR8l
         d+EL7M5fXlj7G3f8VDYdqzKWZDwAC0rslvJZHHJx3N8D2D5gQ90fh1swl937iM38yBhc
         WVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441433; x=1793046233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAVvIbf3n7kTx1Uv7q3TSJJCpEWn7N4psAyYUl6HiU8=;
        b=Noe87qXADxkaqkkI8WFGgu6/hA+AkKFaO4LiDEZOnKpvSUjnY/UTnxXX5ozVlrgDfH
         HFhEbxzmmn52LPSt094HOpkRGtT/7dZbiFM1v6uaSyqbqc234ngyrLbhLUMOD8f04tzG
         yCeWgLYTG2PqpGNgmppxcfbtZ6rwofNlA4E8iRfm6RtGVBMnut99khBH2I1qkJs0oC6c
         W37jNrR9A1HIOXmN2hMtrEtPL9fUwkg9AGJF+5M0KxkdcBn3oiglrdpgXcST1WKzU4SL
         TYL3GkRHAtzR4rCHcOkaojyeuCs9SlQiOI0qQqnb/Rv7LlFuMTqb1Axn/WgruS3GNeS4
         2Rmg==
X-Forwarded-Encrypted: i=1; AKwUvBx8MXvsG2YtgTntUPUoiiDYnfJgDMnQaO7W8QXOYkxweQncZsmvqfvhcrD713LJraFjr+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWhvH+bUdP/qP34EJhw0dyyD+Aa6fDsgy5hEZc54T3t9QYUvU2
	PpXcLtnF8zfnurGsbeLulczYO5tI+RjEYXUOi9prNJsgqq2HwchjH4/hGXgsQRxQQWY=
X-Gm-Gg: AYBFou2IFFcSOVMOjncKTnToGfN+ls8l+ZXhbySajjLpnrhNkVyZyAUdDWe59cLDhUt
	7NXl5rE09fcqaplWX/8lvLLDkhYaQc4YTn7osUqEV59MhFK2DZkORRRx8GfgjDZ4TQea119lbVN
	+1w2lbwonhVYTxWdcgwkZSGIMkNvq/esLKFKd00Fy1e1ccPVNN92zr2bN0VVzfiZ/o37LCjNaQm
	oaJtIuMdR0kNzY0lpb/etCAXfKDSBqgydit2A5h181hE0E2J2+o3AJl3wT/OhzI+De3R8zoBl4Y
	2aNALb1/jR/yuBdvkP6p4uvUgiN1FHJieQCex53llJFFZ1Y+5ka68huwggkO1GbhN3fNiIYeFSJ
	g5nv7PQLp3ZRhT6zgMG0b1y/6HCEZUlSE4A1w5KLqVwFC1o3Z6BLDjGYtuGNmUImc4fFA0ZOVWC
	o6ZvnURcLDrJoMzhmP4PwDS0SfwkACkBiU5tojtf5H8MZtP1iQIvYBFCIlsYmnG4akZVtPKpEz+
	OPbvuTH98lwztAtVK6CfkVzXKyHCyTu9LL21QjKWpbfEnkubBUaX/43Vyg=
X-Received: by 2002:a05:6a21:b89:b0:3e1:29b:bb35 with SMTP id adf61e73a8af0-3e2260dacb7mr6272242637.88.1792441432136;
        Mon, 19 Oct 2026 13:23:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5410:6440:73bf:119f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a06a6407e0sm1511818b3a.5.2026.10.19.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:23:50 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:23:46 -0600
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
Message-ID: <atZ8Uiq1wfoyUVNT@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atKEWmnXA-Gu1Y9T@p14s>
 <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
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
In-Reply-To: <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>

On Sat, Oct 17, 2026 at 11:06:49AM +1000, Gavin Shan wrote:
> On 10/17/26 6:08 AM, Mathieu Poirier wrote:
> > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 76 insertions(+)
> > > > 
> > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > --- a/target/arm/kvm-rme.c
> > > > +++ b/target/arm/kvm-rme.c
> > > > @@ -15,6 +15,7 @@
> > > >    #include "migration/blocker.h"
> > > >    #include "qapi/error.h"
> > > >    #include "qemu/error-report.h"
> > > > +#include "qemu/memalign.h"
> > > >    #include "qom/object_interfaces.h"
> > > >    #include "system/confidential-guest-support.h"
> > > >    #include "system/kvm.h"
> > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > >    static RmeGuest *rme_guest;
> > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > +                              Error **errp)
> > > > +{
> > > > +    int ret;
> > > > +    void *buffer;
> > > > +    hwaddr size = region->size;
> > > > +    hwaddr base = region->base;
> > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > 
> > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > 
> > I refactored this function in V5 [1], along with the above declarations.
> > 
> > [1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/
> > 
> > > 
> > > > +
> > > > +    if (!region->data) {
> > > > +        return -ENODEV;
> > > > +    }
> > > > +
> > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > +    if (ret) {
> > > > +        error_report("RME: failed to configure initial"
> > > > +                     "private guest memory");
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    /* Allocate page-aligned memory */
> > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > +
> > > > +    if (!buffer) {
> > > > +        return -ENOMEM;
> > > > +    }
> > > > +
> > > > +    memset(buffer, 0, aligned_size);
> > > > +    memcpy(buffer, region->data, region->size);
> > > > +
> > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > +        .base = start,
> > > > +        .size = end - start,
> > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > +    };
> > > > +
> > > > +    while (populate_args.size > 0) {
> > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > +        if (ret) {
> > > > +            error_setg_errno(errp, -ret,
> > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > +                start, end);
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    qemu_vfree(buffer);
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > 
> > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > is 64KB. The question is how do we know the added regions due to the alignment
> > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > > I guess we probably just reject unaligned regions if they're not expected.
> > 
> > To make sure I understand your point, please expand on what would be an
> > unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries.
> > 
> > > 
> > > Even if the unaligned regions are allowed, they seem not well handled.
> > > 
> > > - @aligned_size is still 64KB instead of the 128KB ?
> > 
> > I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?
> > 
> 
> ROUND_UP(64KB+4KB, 64KB) corresponds to ROUND_UP(size+base, 64KB) for local
> variable @end instead of @aligned_size. @aligned_size is calculated as
> ROUND_UP(64KB, 64KB) and the output is still 64KB.

Thanks for the explanation - that part was also addressed in V5.  I will
spin-off a proper V6 where we can continue the discussion on updated code.

> 
> > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > >    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > 
> > I agree with you.  That part was refactored in V5 [1]:
> > 
> >          memcpy(buffer + (base - start), region->data, region->size);
> > 
> > > 
> > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > +{
> > > > +    Error **errp = err;
> > > > +    const RmeRamRegion *region = data;
> > > > +
> > > > +    if (*errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > +}
> > > > +
> > > >    static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > >    {
> > > > +    Error *errp = NULL;
> > > > +
> > > >        if (!running) {
> > > >            return;
> > > >        }
> > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > +    if (errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >        kvm_mark_guest_state_protected();
> > > >    }
> > > 
> 
> Thanks,
> Gavin
> 
