Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DE26ED59
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982661; cv=none; b=DO7G3Mq32+lwFp1iXj2t/HkzoRa5+BkBwpQV/mUN1EVFDo+DVsxSrzNlTp7gsh1uq0Y9Y1PtPsN/O8BKliW/nDuDgQfIq5eRa04DktW9Xt15Tzj/73bfZ/ih/WdKOiHOEpsDdS172lrl6JiwHMxVV4iaiN8AZ0dDcgAQQnK7S2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982661; c=relaxed/simple;
	bh=Wsm61aa6wzZBuVPSnrhdLkXCNbriieWkIeHznl5KG5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlc7c3/BaCBqSfx2BolFYA3uPyJdUvYjNWlQ8WnEraDcrvz38tbiUYncUadOkCHWS7I/v7lNEdNxQWvHmHAj7uqI2YcgGBi+HTSdRXgGa8XUFy5db3ljUBAGMF2sI8pnR/nmEr4nn1bJCqEF68GJOu6QAb3N5QVirajK+45/YIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qkudrccL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkudrccL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a2c90e383so291607b3a.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783982659; x=1784587459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LgcBlPclbkMdbp/HtCXTu51Kc/xPI2S2dvfoAEfAMNM=;
        b=qkudrccLLcWWQa4L+sDOw+Ey3i+7iNRCjOlCF2UIX3v1tTMSg05mrB+pjWdWXp8DFe
         JHFpr3DerAB7wSr+Xfb18ZMfiG8m8wTdmDtgfuvwbhCzZrd56nDlxbMDl757G6u6G0P7
         Y5HtJeg42wuO5ewIeAedjPgUxK4pwUFSkq8erjdXM1CS2W7HVjIFNQ/Mk8btU93p14s1
         e+Cc5N1HrFosJkR0LA+rQGBXsleFwL6oLwxhzVBCAgVhd83CvB19XQt4/qejwW3CGspo
         ZHO/3GRLqJCB48uaLbXrxZvUdnJ9qt9sWGE5HmhnpFMtenGnzDvsDizqJ2jKLs7q1+Xs
         m7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982659; x=1784587459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgcBlPclbkMdbp/HtCXTu51Kc/xPI2S2dvfoAEfAMNM=;
        b=Hz3j98axTNUR2r8S75HQ20B9kG4ouNl+AkFWYEelo7BLXxxf61D74ywOnanIrP7duA
         2GaDhcnYx7Pk1W2+427n3svhX/pnR+exd/RfETBCqZrcv+gQm7Lm3ZiSxijTWKmhAIrk
         cZv73pgE0hjaPxgBjSj45YDvmHNtKHizoFHdhB3P2ov1/yfpfi+BJdgUD1LwmM5K8ez9
         cKP+QiRoEaftP03L/lW3ShO9vyHL06MKdVo5aT1SB6Np6nQSPJjePBuGjdCP1F9Z/4Oz
         HqD0UdkxpODCacsgLvyMZmI2nGdpDab3cXuAi/mZYHFqdViaxJFe4agZQuzt47beFK3f
         POYg==
X-Forwarded-Encrypted: i=1; AHgh+Rrx2KhcgKi1UquyMYpCXHvG4NRKeerWqhd2HaMj9IrODznEpGJdMN6nVdiI1YeyGFo6DMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKl+DmCPhRpOrjBT8ACLDr38wQC+VyxrnURB9kmmpIT+ICAFy
	X9C+dXPnB1xN896vZ+4BagFEQKvVRtygfWi9Fq5cON1JChOoS5fhQ2XptW87P7kRix0=
X-Gm-Gg: AfdE7cl6I5SQAf/2LaJEUJS0VsxlsDDJOdIcIdBknqHa+c3FmJLgXhxsPDLtPDoqLWU
	RPpqJTtf5vwKqBwHK3F5luZ7C5b0yy3OS00J7fzI1T6ojMAPN5UzNAvUDyG3snfsd3YPIpF3se6
	QZaPCQa3Mrlpwq+Cm6s0ASfebSe1YIftHQaRhZMmE+S/EzoLEpm+GlOVjTSCnv9oMOX2H9ikdF3
	v1NYEckQmZL0r4y2oDQ/Fa+jLdnOppoxnhMChLF/QDgtBxHxo4Hf95I5PSUQVDFeoodNkCj+qPp
	VNCa/8Kr/K9GeslliVwpOXZYx2eR9BZf07jup9a+IGT9okVayj+u562eNizgFjZKNEaZy8yiFN5
	1x0zea6vjyIls9gp12TfzSekvW/ArimGLQ1uyqS3wfN518j1HmF05wUSnmt+DjNvMmyxuNSd7Xb
	A3tc58l0mvBp5y4qiL
X-Received: by 2002:a05:6a00:2286:b0:845:d2e3:b9c8 with SMTP id d2e1a72fcca58-8488acd5302mr8622187b3a.28.1783982658927;
        Mon, 13 Jul 2026 15:44:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3ead:2a56:27bf:77cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm464398b3a.9.2026.07.13.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:44:18 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:44:15 -0600
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
Message-ID: <alVqP3H9N5Hh5jyF@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
 <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>

On Mon, Jul 13, 2026 at 03:14:05PM +1000, Gavin Shan wrote:
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
> 
> I think it's more reasonable to set ConfidentialGuestSupportClass::kvm_init to
> kvm_arm_rme_init in rme_guest_class_init(). confidential_guest_kvm_init()
> gets called in target/arm/kvm.c::kvm_arch_init(). With this, the pattern matches
> with that for x86.

I agree, it would be nice to align Arm with the other architectures that
support confidential guests.  Let me see what I can do.

Thanks for the review, I'll look at your other comment tomorrow.

Mathieu

> 
> More details can be found from commit 631a2ac5a4be ("i386/tdx: Implement tdx_kvm_init()
> to initialize TDX VM context").
> 
> Thanks,
> Gavin
> 
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
