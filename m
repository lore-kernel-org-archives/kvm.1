Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC9194AE6
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669077; cv=none; b=UHi67Gyy4LifsU574f7tKs4k/g/9kFW7iH3uRi9UDONHG6mmEKXZl6Lrp9wsgsh6FSv6DXRGsZbJO7DIf1HhiloAUo8lcfCxbrnasGvBYB/GQMoRsUSD7kcNw/ojJfgG5TwQAJFcSVX5xSQp2AYLM44iK1jCLpsuLHIj3kjr3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669077; c=relaxed/simple;
	bh=g7tLc67vSjzuyA0nW59/5j+fy5flTlL++y8buLKJiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1dQAVAc8jDOVGG5lHtNKKsWy2/t0uYRA61hgMAprBRk+8bdAhN6h7eiT7COrKIeyIONWsfbhG+ecQ3uFpSPLT9pqMwIJpeXW5rXq6mpMxQm8qvnhwaXCb0Sjrudkn96GVKZDF1Qpob1+i8WZjbcO+NHfj9JqESnBTdZDNfcUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiMRSLSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiMRSLSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7191F000E9;
	Fri, 10 Jul 2026 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783669076;
	bh=sO4JbAuoMHHDfXYAV3OqvEzK+SH4DRXfZJ8SmtSpxWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aiMRSLSBPAl+lNwonpGe4KXsFqweRJHWHmdxIRcnXNdkJsffH+IEnc952a3AeU26z
	 m2vFKcJGDL4BP6kcaRMmE+eZ/jLxg76EQHwNGPzf4WeZA+eoNztY44+dUt806yRoL2
	 Yq7gZYbC+hEylLR+1JT+iMUGJctnW8Cp4GH/HtLTuagjNW5Aw0cJjvu7jASCjCh9ZP
	 e4XHsMwDs9gvj8Ged20Npian8mPzHBHqGVM87j1oTvnfa8K9CUmPM//71MdaikV3Iy
	 /mu+FBRVFoi38QNEQ/YI6+6YOzE0yZhqPRCjb46WipG9iOCAiDAfXnj8lODJwHiFpN
	 SyZU7QC00rbcA==
Date: Fri, 10 Jul 2026 09:37:50 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	jpb@kernel.org, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial
 Address space
Message-ID: <alChTvF5k4sOOqcJ@lpieralisi>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-10-mathieu.poirier@linaro.org>
 <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>

On Fri, Jul 10, 2026 at 09:44:11AM +1000, Gavin Shan wrote:
> Hi Mathieu,
> 
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Initialise the Realm's initial physical address space based on
> > the VM's configuration.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/arm/boot.c         |  4 ++++
> >   target/arm/kvm-rme.c  | 18 ++++++++++++++++++
> >   target/arm/kvm-stub.c |  4 ++++
> >   target/arm/kvm_arm.h  | 10 ++++++++++
> >   4 files changed, 36 insertions(+)
> > 
> 
> Thanks for the posting.
> 
> If RmeGuest::init_ram isn't needed in the future, this patch can be dropped.
> There is no API exposed from (v14) host series to initialize RIPAS for the
> specified IPA range, as we did in the earlier revisions. So this patch was
> added for the earlier host serieses, not for (v14) host series any more?

Yes, as this series stands this patch looks like a leftover.

Thanks,
Lorenzo

> Thanks,
> Gavin
> 
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index 9b7553dde5e1..bcab21d349b4 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -32,6 +32,7 @@
> >   #include "qemu/option.h"
> >   #include "qemu/units.h"
> >   #include "qemu/bswap.h"
> > +#include "kvm_arm.h"
> >   /* Kernel boot protocol is specified in the kernel docs
> >    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> > @@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
> >       /* We assume the CPU passed as argument is the primary CPU.  */
> >       info->primary_cpu = cpu;
> > +    /* Mark all Realm memory as RAM */
> > +    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
> > +
> >       /* Load the kernel.  */
> >       if (!info->kernel_filename || info->firmware_loaded) {
> >           arm_setup_firmware_boot(cpu, info);
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f763d5ed6199..697e7d507f0d 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -22,8 +22,16 @@
> >   #define TYPE_RME_GUEST "rme-guest"
> >   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +} RmeRamRegion;
> > +
> >   struct RmeGuest {
> >       ConfidentialGuestSupport parent_obj;
> > +    RmeRamRegion init_ram;
> >   };
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> >       return 0;
> >   }
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> > +{
> > +    if (!rme_guest) {
> > +        return;
> > +    }
> > +
> > +    rme_guest->init_ram.base = base;
> > +    rme_guest->init_ram.size = size;
> > +}
> > +
> >   void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> >   {
> >       if (!rme_guest) {
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 6d52f172c5df..790e1940fd8a 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
> >       return false;
> >   }
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> > +{
> > +}
> > +
> >   /*
> >    * These functions should never actually be called without KVM support.
> >    */
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 65ec1b970606..c7dc45595159 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> >    */
> >   int kvm_arm_rme_vm_type(void);
> > +/*
> > + * kvm_arm_rme_init_guest_ram
> > + * @base: base address of RAM
> > + * @size: size of RAM
> > + *
> > + * If the user requested a Realm, set the base and size of guest RAM, in order
> > + * to initialize the Realm IPA space.
> > + */
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
> > +
> >   #endif
> 
