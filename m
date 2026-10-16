Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684C55C1CC
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170867; cv=none; b=XIHrmnTn70Agf2QvCWdMpTpeWqpeKXwv0/Tv5xw3CfDGteqoFIb7nqe4LZ9fsFv6FKGfvWZBkdeCUIE5fON6azqYP8lRdcmssWhZh8l07MdQ36F0A5pgTBEIH13zLl1UYn5tO9GuQfUV+Ttkq4W8db3FcBt7Ig5q8EMCnjD8Dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170867; c=relaxed/simple;
	bh=6Bh+A7BuYKO8u0RzcMkA27VimbBpim8zKQeuv/QiJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPJDttQ6Ip01KbDZVB7wJC7j1vukrYjAvyp0NeGaPkpATubVTcSULN+w/7M0bRaDQnewvJd4vzUAob/N/d+QGFvQ7JB48idJDhANgFxasjRldk3bZgRQm0l4dMYQFDSpMRzP3+BCDxRfgs1Ci47ofthZrPP0yLr1MHLjoXKw2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8VM95P6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8VM95P6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso111693b3a.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792170863; x=1792775663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5HJrOnAZYpIuuAfp/L5yO221qV9COB5ByPC6P2WDsDo=;
        b=w8VM95P61cGt1cOLViwTBIMitw1Y5QsuTmw9/XfJ1Piu5g8DiqbIKRUDrSVcmGDz6U
         gM8XiCLTWh3zT67ArhSihumTZuc5by42VfLFEHQ5lN/8+oVZp+fA0QELN9AY4uUhMaWU
         dhxUN/1JY1oU4BbO2WEdzfv5Hs7JALGKjKDbalrNmILzef42Kn3PUT2FUHGG7cQiYHML
         ilvgYXyWqzkWbqfMVFc+M3GqlkUX9dCZf10Q0OpBdWFxmmCWG0DCh7NXawAebehCiewx
         Xw3Y3fFw9yE+hCls2OOOPr/83ovAhkbQHQWDMkpVldGZVsUYh3Oqoi9I2O0gA3NdWtgd
         ycKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170863; x=1792775663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HJrOnAZYpIuuAfp/L5yO221qV9COB5ByPC6P2WDsDo=;
        b=txaZLgHtAhJDxt01B7qsdi6dkqTk2Jl7j2k4GZYXgozkbQV65WVL9ObzC2U9PAbJCX
         zrxSWkK1TMesa04yiut9RVhe+ECguVtWLnukkWRSPf/ByiyNop6JPEX9gI9+Tkfy6Uac
         pgHIO2XptUc1/Ix7r6tU261UmyLKyYkpGSiUSywpMzkJmPG+us6uJ+79p4zgdyl+drYm
         SHv4QA7miaHFDxq8Tvxl8EydGTRSDRjCWuRJYPIu1sztGv1CFcalr3hPjbBy8zk+H2Mj
         A100M2zzXJSo39pjduUX6x1S95ZlhwY8SHjOwTmiew3Y3rVEMntjO42k+g107XXcZySr
         ngzg==
X-Forwarded-Encrypted: i=1; AKwUvBwtMV9DA1ME/fRjeXzPgabWx3hBUKpShNyBsyoofUBqOAa/jabYnCPfd1KOs7WqgJBIHcI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJofOZRtF2nliqGzq+ITvAETt55xueJpN6FONI3WbF158g+d6Fj
	oJue05tqtYQiQLodn3Hdpi8P04JL6J0NnUZuPTudVjlZQwdJuBTJm2ncnIXAdyp8hJE=
X-Gm-Gg: AYBFou1c/yb1afHvLcVCMzfoODIWj5ICbpsbC1uqNkIQCQS7sMhRAokJmHOlb2yBL4H
	ITNVpXL3Oua2div6lU/TI/CtSvY/7UK8ViZoauaYziNBg7qebKliibT6sxKMeRVwsC2OuMPjzeX
	wv7WOXHdsr3aiEFZ+0Iiqbd95DAyAYDQAHPhO4ME7v6wpqKdTl741gvlzulPr5ud4GAe3+vf9dr
	39v41hs3bCf6Q5Mxkcii4KTaCtwuJwW4ol6d3kf25sJGnQiuIGlBXl55W0FRHouAdg4kRopL9HY
	bIfuYqczHcwFUlX5JV6lvRy7aK2jlYgmib9/f9P6q4mkQDOyF98RMtEx+91l2MeBnEGpwtY5nGj
	ZbiO2vZyPZazqvG/92jGKWnVIMdBM1oZQh9yFBITJiLGGVfaZcYVMLzg4SAP2SNYknbRRR8HxdW
	fz+ZlnNTddBmbTXUwCkb0MSu6Y6Y8hCPcUhArGVWA4T59/n7j6fqK+zkFBfjGZg11aZbz2STfdU
	A==
X-Received: by 2002:a05:6a00:4404:b0:89e:df2e:cebb with SMTP id d2e1a72fcca58-8a04d33cba9mr189265b3a.59.1792170862923;
        Fri, 16 Oct 2026 10:14:22 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579464besm1491750b3a.34.2026.10.16.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:14:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:14:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded
 in Realm memory
Message-ID: <atJbayxYy4qePc_2@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
 <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>

On Fri, Oct 02, 2026 at 11:23:58AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> > That way we can deterministically calculate the Realm Initial Measurement (RIM).
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f7c2cc786e2c..9985f5daba89 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -10,6 +10,7 @@
> >   #include "hw/core/boards.h"
> >   #include "hw/core/cpu.h"
> > +#include "hw/core/loader.h"
> >   #include "kvm_arm.h"
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> > @@ -22,8 +23,18 @@
> >   #define TYPE_RME_GUEST "rme-guest"
> >   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +    uint8_t *data;
> > +} RmeRamRegion;
> > +
> 
> This is the equivalent to 'RomLoaderNotifyData' defined in PATCH[09/24]. We may
> use 'RomLoaderNotifyData' if it can be renamed to reflect its purpose, no need
> to define an identical structure.
>

I ended up using 'RomLoaderNotifyData' in kvm-rme.c instead of 'RmeRamRegion'.
 
> >   struct RmeGuest {
> >       ConfidentialGuestSupport parent_obj;
> > +    Notifier rom_load_notifier;
> > +    GSList *ram_regions;
> >   };
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >       kvm_mark_guest_state_protected();
> >   }
> > +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> > +{
> > +    const RmeRamRegion *ra = a;
> > +    const RmeRamRegion *rb = b;
> > +
> > +    g_assert(ra->base != rb->base);
> > +    return ra->base < rb->base ? -1 : 1;
> > +}
> > +
> > +static void rme_rom_load_notify(Notifier *notifier, void *data)
> > +{
> > +    RmeRamRegion *region;
> > +    RomLoaderNotifyData *rom = data;
> > +
> > +    if (rom->addr == -1) {
> > +        /*
> > +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> > +         * Instead the firmware will load them via fw_cfg and measure them
> > +         * itself.
> > +         */
> > +        return;
> > +    }
> > +
> > +    region = g_new0(RmeRamRegion, 1);
> > +    region->base = rom->addr;
> > +    region->size = rom->len;
> > +    region->data = rom->data;
> > +
> > +    /*
> > +     * The Realm Initial Measurement (RIM) depends on the order in which we
> > +     * initialize and populate the RAM regions. To help a verifier
> > +     * independently calculate the RIM, sort regions by GPA.
> > +     */
> > +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> > +                                                   region,
> > +                                                   rme_compare_ram_regions);
> > +}
> > +
> >   static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >   {
> >       KVMState *s = KVM_STATE(current_accel());
> > @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >       error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> >       migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> > +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> > +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> > +
> >       /*
> >        * The realm activation is done last, when the VM starts, after all images
> >        * have been loaded and all vcpus finalized.
> 
> Thanks,
> Gavin
> 
