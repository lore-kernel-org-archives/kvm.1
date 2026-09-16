Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBA4A387A
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594825; cv=none; b=RznGko152X4KCaztss67EZ3+22/NvEE3Vnr85/msQo6zVc7F9rR9YRR6wuEdEQrN6bIzss+dK3wluIsQyxlEn2LUQK7KWquhfpwi7cU5ribe+1im5zrAGqJ+lj3CMB3O/V9Xwj3L/YVuB1fKS6CCIe9JkNO/CiGTRxcEMwujWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594825; c=relaxed/simple;
	bh=ObRkihXpH/t8wd8DCK74upBNs//oBwrRFXpFaePoPgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLBvztvNVRw2a2Ad+RlI/zgtP9aaNRYw+r9nGit0j7zMzFhJYPu258esLYhvMlaMjV2Mci6qNrxhKjqUsk2447sSl+DhbtFmcj8OSBNHKMSqlle8TLmfq68YOk7JvMO7ckglp/SlPqi1clNgYOLXwEdHJLH7zeNFqAgoI1RiW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEH5UO9R; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEH5UO9R"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso152228a91.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789594810; x=1790199610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MOqIR1QOnXez06E1wQXG6QO22jSC2ZUg23ltXaD7bv8=;
        b=IEH5UO9RQ6UqTYrM1GvtHBIqLBQiVze3ZyktzlqDcBnXKFg70bCjhd81/dLlPYdx4W
         a4FzCR4628q9pPOb9w1m926IPqrbDWwJMEEg9rUUMdg3dSkIAj/BEpqZ65k2tqVQwWym
         GltsXk1S9WnE2BNCOm8OkcBiIye6oRPivHGgpbuLo52Vy70GmgLsYvaRbAJ1b4P7JhJx
         mRfUwoAHb8jlgJZejtXvz4kB3BfMAzhvi26ZY9T7hJTpesN5wjNibHqKnRjth3uhh/8r
         W5KKX20FFq1X2yUGBB/be3LwxrnbJwuRSu08mDiRlgPMuU9NwhWq+LuR8BquK8P9shEY
         f6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594810; x=1790199610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOqIR1QOnXez06E1wQXG6QO22jSC2ZUg23ltXaD7bv8=;
        b=N3iLSWBQvjpE2Qgw9MToA8Nrzk3a8ONzU3Y/1QtwwbuL2i6ubo2OlNQYxNIxGzO5hU
         M9oZSsag5Q4YV+6TMFAFgdKw25nQBuR+Ja9ERiMWVdBchQDiJCs/bQXKDYtRv+PKQIxe
         /pzJEHXf3p8GIMrG9skIwQxAzIXrz0S27OjZXzh0RqEFhhsHJPeU2oEkdKkd5HJMaoQe
         Tci4ZlPXv7yPfmF41oxIa3+ZebkHd1buxpGJQAX6dQC5ty4XooqZ1DpM1j6mWQlyzcp4
         PObNwYtIYolmCcqZS7uWB4y7LKWNdWb90rC5znx57qJ5mzkMi8tuCl/MXdALI9uqcZGq
         5OUg==
X-Forwarded-Encrypted: i=1; AKwUvByJjp5oMwlqYvYpU/Kg24OVhZktRZVJ15kCQphFH3WbxyEPxKYZ+N9qTF/ErkjGSwG4acM=@vger.kernel.org
X-Gm-Message-State: AFuF++nFFMbuVYomgiddRUcZ5zQ24UDqvb1E4CjDOMbA51vaCjEcFxH4
	HZWhBWuHO8qnvB+1TyGsU4fjT7JTkKTzx7G5leyb/zI6HOV/J+MtD49xVAKgpwN9y/4=
X-Gm-Gg: AYBFou2k0mcv1TcQ2F7JsXg9cqIulQmFOtlm3f4cjzjxqnJxxPWjn3WvcvE9UB8JzjZ
	OfXLk7UfgtCPGuZlbos9SiEfdO+1CVnXRm71D/KnfIkajiKqSeLTm32MRvvaNMekNF9TnMKWU1k
	cW14ZMbAdMAxh01pF2MUHWBTF6uG9eVULmytJV39S26lB1akG6/bgQjIBS0dwwxV8iy8MwpypTl
	JFomBg0+HR+9kdntreV5JM4qImbY0XK/p4SwYAyUDzI2bf0Qx5ndJlJytmOFrsBesQ4+zOFsoCO
	mt0iYo6B0KTieNMwmMMl2FMOp1k5XL2eAW5mceYl8XfmjQkfhM4q6xlf/BpLLIPwBz+4T2VOuiW
	2L3vKUW9HOkCKqA+8Thu2z0c/aBVX/KAn7pwrhMr4lH18aa/Ogb5FTt1Q0QgjwLbRs1iqMs3P6v
	oLZ8eoMQBgXnDYpAtwP/riHfxkkhQ1zayRWg460O5wEW/4iYrs2Bb5+SLa0ysU2SnF5lQ8BDSXa
	LQ=
X-Received: by 2002:a17:90b:1fce:b0:39e:2faa:2e83 with SMTP id 98e67ed59e1d1-39e2faa31f1mr4703559a91.10.1789594810007;
        Wed, 16 Sep 2026 14:40:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5703:e05c:9814:52a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm1206938a91.3.2026.09.16.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:40:09 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:40:07 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Michael Roth <michael.roth@amd.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded
 in Realm memory
Message-ID: <aqsMt8etnjhTgfK9@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
 <e3cpd54xpkgonmn4rziolhqvdkge5ke5mhi3cx57j3cfcc7qwd@eq7btw5en54c>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cpd54xpkgonmn4rziolhqvdkge5ke5mhi3cx57j3cfcc7qwd@eq7btw5en54c>

Hi Michael - thanks for taking the time to review this work.

On Tue, Sep 15, 2026 at 05:50:37PM -0500, Michael Roth wrote:
> On Thu, Sep 03, 2026 at 01:35:57PM -0600, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> > That way we can deterministically calculate the Realm Initial Measurement (RIM).
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f7c2cc786e2c..9985f5daba89 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include "hw/core/boards.h"
> >  #include "hw/core/cpu.h"
> > +#include "hw/core/loader.h"
> >  #include "kvm_arm.h"
> >  #include "migration/blocker.h"
> >  #include "qapi/error.h"
> > @@ -22,8 +23,18 @@
> >  #define TYPE_RME_GUEST "rme-guest"
> >  OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> >  
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +    uint8_t *data;
> > +} RmeRamRegion;
> > +
> >  struct RmeGuest {
> >      ConfidentialGuestSupport parent_obj;
> > +    Notifier rom_load_notifier;
> > +    GSList *ram_regions;
> >  };
> >  
> >  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >      kvm_mark_guest_state_protected();
> >  }
> >  
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
> 
> Are these entries also added via the rom_reset() path in the previous
> patch? If so, wouldn't it be better to filter them out there?

Duly noted.  I will also wrap the previous patch into this one.

> 
> Also, if that's where these entries are added, then it looks like we
> might call address_space_flush_icache_range() with this -1 addr before
> adding it to the notifier list. Is that expected?

Function address_space_flush_icache_range() is indeed called with @rom->addr set
to -1 (0xffffffffffffffff).  Since this address is not accessible, the inner
loop of the function skips over the entire Rom area without ever calling
flush_idcache_range().

Regards,
Mathieu

> 
> -Mike
> 
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
> >  static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >  {
> >      KVMState *s = KVM_STATE(current_accel());
> > @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >      error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> >      migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> >  
> > +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> > +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> > +
> >      /*
> >       * The realm activation is done last, when the VM starts, after all images
> >       * have been loaded and all vcpus finalized.
> > -- 
> > 2.43.0
> > 
> > 
