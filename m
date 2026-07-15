Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7148C8A1
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146897; cv=none; b=JYszX+m7eAc2PYJmDST/NSrCecZrIMroLjsD+tVjwBpxM9mbaBrRY+kDW8cq2v8WyQa9ZNm6AUBf+Ib6x4RWgdGmwVmtVaN0QHUbhjhoMbQGFmK5aburTys9hAS3aloQ1k7f+Cv9Ev+A8kOxg9oAbPdh4LpDkJmag/2wW3y7K4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146897; c=relaxed/simple;
	bh=TMO+ZtzOekX2OtuNgEzrmbwxifGyKoAWld9R+o0jWjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNicCmZ644Y7824LtoeXv4UpRVT5w0J6mBRc+dnBxk+LCa4X8sNZHmRS1TEz7F+01GQ5yafFFGx8mYNHTNMn7kVk2vuutotrBnPPzJYpZk2V8jYOWLdcCLWxlyWpbWH5wbmMQ0JMZ4CnXLxBUMDKKmfjf5K0jo0V6BRnrnnqNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpfpiO1f; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpfpiO1f"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2778689a91.2
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784146895; x=1784751695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fBNMuYev9SK9XP/q4UAGz8mTO3r2lm4owsLqkSYGd/A=;
        b=TpfpiO1f7umugSa6EaiIH4mwOfmLcR5DNL8UOsNyU7Oeh9ZLnbUDnZJ78ce2pk6U/g
         WoIcTNVqugFco9ta4FHPYolpjJltguRDcXOG+sIpNGhdgyof0g+ph7GEM79Kxga4ucKC
         9tR8CJPmZMfAXYYZzq8BcfSiGrgMYO8P7zK4UuZ3u2SxShM6oy9EbNlu54tezpHEWNAl
         j2rq13KIGaFfEzDUEy2iyonPjR5ZO6vGvn2nFKpZSJ5OVTaeVDGfwdF4cvdfcpnjbzTy
         EK/kWhLXTL5s/uD+UJ6tPOC0xqfVAC1+J8ihSdHJLlirpFF2p8XRuRy2vI/mnpOsUYt5
         jOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784146895; x=1784751695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fBNMuYev9SK9XP/q4UAGz8mTO3r2lm4owsLqkSYGd/A=;
        b=XrrmbDL5VbKR7umfeA3D8geMLMUSpoxAWwljzM7LTigJlYDOSpe4XrXJOXRRwesIlU
         eJfb9KDHUZ9YGKdyRmkdT1TYjEc2Fn0/zgBFL2EbHI15MO5PR+bGwXIZsqLDrjjVLAg+
         pCR+HvBzxUN3VS1sMteg8wl1v4PwhjOQKwFTPpm6BRUHkloZPXY5kY7+me6mpRdfkUeQ
         UU2PNlt6XiFcpHPnmhOjBRLxyFnSJCtxpFw3HQWDK3DWe47tSatNysFcf1ljQAR44o4k
         NuKszBjtB228nKMTNExP+msRhHkE2pcVQgeZidyFRMpMxvqz073dOmETqvjUvXfI5LO7
         ielw==
X-Forwarded-Encrypted: i=1; AHgh+Rpy9oOaZCe7zAY7D7XNDKRgLmmpiGgryJosPGVM8Z2ZlBt3Gkb21PlWM0CPMmMRVEciJRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKZ2/w96ULuE35njzc+hzSzA/d9NnaQ8Ee/RT0gOPYjzGEL+I
	+ZyM9CUSTrvX+2XX+kWeI9KaNtavZii4oQ7nA+uSZYZii47ayRvbTx+vpo3GsoTVhuU=
X-Gm-Gg: AfdE7cmoVh2To4BSiiLUOkabkym02f3uoqFe7tgFLO0usHRZnh4tvBkBvGODaz+pymd
	KWmaCGhGQs3z0btcdajHIZchrTqgt8HIjpmx9ABAL2WIQ3gkNhMa6LUinTaD2CN5kwlGEcR/z0O
	mHMUIcJCieKYflAvLBDEjFkOe4Hb2c2DZmDtvVNGFmwNkLbEJoSmi2YYAVTnh+4GHyMi1RyDwqb
	xhp+9O/INBZ0yczCh9YJJLBpKr6YJu5G/FSuYC+rCiKVxqaVlpPUCEytS821Wtm8jq8F0jxCjdB
	NgSWGNiqe00QLt7Ocqg6zHH8y+9EFjVnNxvt2XEcYPCh3tAVdfjRqkQKSBvOdk5YNCBcGq9JxdZ
	1imDkCHQUJvzIivEHdZNg2khecNO6vqWCQWigPSuR3KiO2Bp4hKw1V8TXDQiYEq2nb72DQaILSp
	YQIvTZoUbHXWsSaRzG
X-Received: by 2002:a17:90b:38c8:b0:38d:dbc7:5178 with SMTP id 98e67ed59e1d1-38ddbc75254mr15794311a91.22.1784146895116;
        Wed, 15 Jul 2026 13:21:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4f38:9a5e:fd18:7a9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e74279sm134375a91.17.2026.07.15.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 13:21:34 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:21:31 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize
 realms
Message-ID: <alfry2MJwRFz2hPS@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
 <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>

On Mon, Jul 13, 2026 at 03:34:20PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Initialise an @rme_guest object and install a handler to get notified
> > when the Realm is ready to start.  That way we can finish reading the
> > Realm once we know everything is in place.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
> >   target/arm/kvm-stub.c |  5 +++++
> >   target/arm/kvm.c      |  7 +++++-
> >   target/arm/kvm_arm.h  |  9 ++++++++
> >   4 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 42e1d1e7b859..b86b9d6a25cb 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -13,6 +13,7 @@
> >   #include "kvm_arm.h"
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> > +#include "qemu/error-report.h"
> >   #include "qom/object_interfaces.h"
> >   #include "system/confidential-guest-support.h"
> >   #include "system/kvm.h"
> > @@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >                                             CONFIDENTIAL_GUEST_SUPPORT,
> >                                             { TYPE_USER_CREATABLE }, { })
> > +static RmeGuest *rme_guest;
> > +
> > +static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > +{
> > +    if (!running) {
> > +        return;
> > +    }
> > +
> > +    kvm_mark_guest_state_protected();
> 
> This would be called in kvm_arm_rme_init(), why we can't call this to mark the
> KVM state as protected in kvm_arm_rme_init() ?
>

One of the very last things happening in qemu_init() is a call to
qmp_x_exit_preconfig(), which ultimately ends up calling qemu_system_reset().
If we mark the guest state as protected before qemu_system_reset() is called, as
it would be the case if we move kvm_mark_guest_state_protected() to
kvm_arm_rme_init(), general purposes and the program counter registers don't get
pushed down to KVM, resulting in a failure to start the Realm.
 
> > +}
> > +
> >   static void rme_guest_class_init(ObjectClass *oc, const void *data)
> >   {
> >   }
> >   static void rme_guest_init(Object *obj)
> >   {
> > +    if (rme_guest) {
> > +        error_report("a single instance of RmeGuest is supported");
> > +        exit(1);
> > +    }
> > +    rme_guest = RME_GUEST(obj);
> >   }
> >   static void rme_guest_finalize(Object *obj)
> >   {
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    static Error *rme_mig_blocker;
> > +    ConfidentialGuestSupport *cgs = ms->cgs;
> > +
> > +    if (!rme_guest) {
> > +        return 0;
> > +    }
> > +
> > +    if (!cgs) {
> > +        error_report("missing -machine confidential-guest-support parameter");
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> > +        error_report("KVM doesn't support Realms");
> > +        return -ENODEV;
> > +    }
> > +
> > +    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> > +    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> > +
> > +    /*
> > +     * The realm activation is done last, when the VM starts, after all images
> > +     * have been loaded and all vcpus finalized.
> > +     */
> > +    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
> > +
> > +    cgs->require_guest_memfd = true;
> > +    cgs->ready = true;
> > +    return 0;
> > +}
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 88cbe8d85c41..eec1ca3dd2e5 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
> >   {
> >       g_assert_not_reached();
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index ed99be7fd80c..28d5643d6779 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > -    return 0;
> > +    ret = kvm_arm_rme_init(ms, s);
> > +    if (ret) {
> > +        error_report("Failed to enable RME: %s", strerror(-ret));
> > +    }
> > +
> > +    return ret;
> >   }
> >   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index e7c40fb003e4..6d058b0e08a2 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
> >    */
> >   char *kvm_print_register_name(uint64_t regidx);
> > +/**
> > + * kvm_arm_rme_init
> > + * @ms: the machine state
> > + * @s: State of KVM
> > + *
> > + * Prepare the machine to be a Realm, if the user enabled it.
> > + */
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> > +
> >   #endif
> 
> Thanks,
> Gavin
> 
