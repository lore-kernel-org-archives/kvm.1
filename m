Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866433B38BE
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577739; cv=none; b=bi3SyHbMRghLMP9rnEuN5mP8nBpMDkUNGweqHRgjii/xNWJKOOytv0BwonOQyaUeKJ6xXzoXPj32MK6BdRvNh2WHhe7E08TCoamr29+FGh/i7KGHEa+u9v+a4PKpQ+es+A/ktqEDO+jYoCBffPN8P93sztzta/10gCe3TCKOwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577739; c=relaxed/simple;
	bh=yUQPM6hzoMdbkZJj0Y4Je9Blrhtr7QGrgWuRgmJOAsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWEV+cj0Etqmq490MoU5hv2yuNSFCcznbieFQoRSTIDoueiY0PO6JZdlGMDAXFN3qKA5GrKVz45Ot8BBAScvrU1QERd3QmK0+AROQE6m0Rw+y+5zjxyk5GPCp3SGPS7JZQRChzPbFWD/HSg8XwcZatX1Kl7oqynC5lCYlqbTXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4RPd0lN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4RPd0lN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf41bab353so41245455ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784577737; x=1785182537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=amB8DRIkab9kI0m0AGrWYRIFfBIRp35flDeBw4O7HsU=;
        b=S4RPd0lN8rdWCSfauA4GBj3rKu5CgX50LYCvW5TSKwWc/93UQDuIFFrJGSVfpPdtGB
         KI7d5aZaAZTFNQ8LkrGddUSHNVtPD79QX/3wvRqwnoOo4cCGX7Gp3oiiWBWzyx9m691d
         KP5H8ErLWx6safbL+n6mHpSyZ2KA3vLxhrx24/LbThRDKk1JmsUugxRktC1lcuvHnix9
         VF+uiojGjZ/RftCwnD500T6/8+rYCCAsx8KlaaH0z+9SOxi8vYOMViz5EApKwLm/wbL1
         f6v5QNbPidmzcE+X+DMX9tFUIEH6YOUJ2tqfg/ku6JT0j92Zvt3B2Yjc8pojo+QnS2Lf
         nWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577737; x=1785182537;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amB8DRIkab9kI0m0AGrWYRIFfBIRp35flDeBw4O7HsU=;
        b=b7FMKCmRQnejZHsJsvB68gGAuPFCjp6QfnhNGUPYyjp1an6SO9fGxmO9iyrM1zyaF/
         OEzMImE0Vpa2Srrv0p9so43cKRhZ+sHJSjE3zD8DbA8ucJt9r/WcA/J+8KiJ80Xa1vCs
         CV79Nc3ms0QCb1jnlQCeAYFVXJJ9D7KklE03Z5ROVI3zC8eRA9LOGs2m6OwfAWpJLlKT
         Zi//aUEdUrQSD5+dICyWKR0MAJwgBkwaZ3Or53QhrPtQm71AIGYwE9WWzXDYS3eoxAPw
         oiCjwdPz7E65yXy6w+qhzHLRt/y4He3bEr47EYeKf6nBnPKaEFEhFeegUY0nShALVtMK
         31Ew==
X-Forwarded-Encrypted: i=1; AHgh+Ro6EnXn3qRiJHpWzdpp+ZcsxeqPQ1Dj5f+W/04gmYCYpgu7l6VwRJqQ7YK1imU5bnnNbEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5I9ePOiBSx3TF8vCMl9IdURzYCqkxsvAplUNkwIXUY3T6Htzy
	mSi9hS8Ma2e3QiecAuKGdgRnn4sHiMm/PePQsprQ1S1V0+FnZjqaPPbBJdYQ7Swk/Mo=
X-Gm-Gg: AR+sD10hVAdj8vEC0dIZuedDb7lG6nYptb6uEtuhCZAk7Gu5rmWbQxzER5ONxZcS+GV
	GgcQZTmV30rTLMsmUYfRKSV1TE5LpVdIew1KhKPMUCNgE/V7L/t+oYA5sdLNzu1bEqZYou5/9dp
	b1ny16/FBkN/GFX+zNByYi8hQuBuTnaovFC8Q7AAQBzZba5LwlGAZs23Fzq+PTGUMBNJG9muu16
	52pyYVE2PjDQhoLdlMspbx8YgVmMAEnUyCZgQnFGTokDdx1lABiRTuwwXM5m8fDiO28CLaC1kV6
	OE6cU0tuv15YTm9kYvQqJkFQAjEO+s4HjkWv+n9nPXyxUMeK15LxwTWPSSfHF9C2b0FBR1K5CzB
	EQjgqbJY+0nhtbAvbrO8WGlDWB/cUpNvFzGb8XzCeB2g2/ShNm46KATxBdSaijuEOsYhFTeaTT5
	Pc9U2E
X-Received: by 2002:a17:902:d48f:b0:2cc:d807:369c with SMTP id d9443c01a7336-2cf34a3000cmr173069645ad.45.1784577736510;
        Mon, 20 Jul 2026 13:02:16 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:966a:e23:19e7:951a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476e491sm61808635ad.76.2026.07.20.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:02:15 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:02:13 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 12/25] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <al5-xc-kNZhCcN9p@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-13-mathieu.poirier@linaro.org>
 <1bd09a58-a207-46ba-a470-f67cc8509f07@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd09a58-a207-46ba-a470-f67cc8509f07@redhat.com>

On Tue, Jul 14, 2026 at 08:56:44PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 56 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 97ec7c8934c9..58669f4a50f1 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -44,12 +44,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >   static RmeGuest *rme_guest;
> > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > +                              Error **errp)
> > +{
> > +    int ret;
> > +    void *host_ua;
> > +    hwaddr size = region->size;
> > +    hwaddr base = region->base;
> > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > +    struct kvm_arm_rmi_populate populate_args;
> > +
> > +    host_ua = address_space_map(region->as, base, &size, false,
> > +                                MEMTXATTRS_UNSPECIFIED);
> > +
> > +    populate_args = (struct kvm_arm_rmi_populate) {
> > +        .base = start,
> > +        .size = end - start,
> > +        .source_uaddr = (uintptr_t)host_ua,
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
> > +    address_space_unmap(region->as, host_ua, size, false, 0);
> > +
> > +    return ret;
> > +}
> > +
> 
> Nit: The argument @measure isn't needed as it's always true, passed
> by its only caller rme_populate_range(). I guess it's leftover for
> the earlier host series.
>

I kept this one on purpose.  The KVM_ARM_RMI_POPULATE_FLAGS_MEASURE is used by
the kernel and as such, it is a matter of time before we make that options
available on the cmd line.  I can remove it now but it will come back soon
enough...  
 
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
