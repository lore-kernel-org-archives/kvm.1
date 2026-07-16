Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE193C98BA
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239500; cv=none; b=DjsowvHhNPqIl1AU/fyyGFT/oLlKMFCjZcGFOaUIRHKj0JlyXEjUCK5VaN9sIT8OhqkO+Us3aL5wdjyXyTkPIMbSuuqjo3CmKRU/C9KDFLS6kqHaeXp5DdLOxw1/ID++JPtWTv7FVHYHGySIN+fTJyJEofMDQRA5RgX480l6rmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239500; c=relaxed/simple;
	bh=tLLNcnRyoNkqa4lxBo5888pOjthTkMGHwhqzPyj+N2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a87OZaQuqP51zcvHs57flTi26aGSx4AZ/4KId4QuDf1wLGvY0X3gpHXU35t2nEo5A4mpkpcaMDJIhI//vvPq7RBBMS2+4VeUIjlRd1QFcTPLm25Zrakeq8ga1OVLSHlC1U496fay3lOvzqtKeJ/N7GWoCXeNkiIggk0h/dYq0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=riMi/W9t; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riMi/W9t"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so4188909a12.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784239498; x=1784844298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b5j0f+ollCEoqfIjlMJS818pgRqCyg9kfb00GQ3Q4P8=;
        b=riMi/W9t7DjZ+Hq+4GHfcRrqgl63OpQH1NDKjuAcx22OXtZglKNVl4UG4apmSmdv3Z
         M0UabXc9vbhBwavFis0HqMlnEndTkKLLFtBxTl4YZW7igfBDIVkUmdnS7ey94uleOtJW
         A1RSQj/neiutQeXm1O4uVWYvcV8zQIuifhZvf9ak4HWZsPUJBeJ36Omx9wrQ3Tf85Kxx
         dJzHmriNm5/wBxctxKmg7a1DepPxAogvh/kDI2cNshTXib0LTD+qAOrBxBW0McOnM7j+
         csRFr45tp8nHdgMIx5CnPH0Bl+e481RoO/C3Tu1dD7uXzLa4OcqQ22QnFbHIICoB1UZS
         C/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784239498; x=1784844298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5j0f+ollCEoqfIjlMJS818pgRqCyg9kfb00GQ3Q4P8=;
        b=HUq5e2ya0yc6UVpoEdJUwEfGiyVewgo0ld6W3opJpjaJgG9Urz3SOXFj11/zAW5Ylw
         fIqWKyU1HRN/rXl3BCwK7ES94mqi9P3LeBTFwLCamkWuEss3idQO3dSzgk7VG6AghzMk
         kRUPlmx+RVVC/WsLGzC54d6eJYeGV9LH+E+AWO00HiXK0zLiPDcSAAjMF+Gy/oMpBBCX
         9HnrQ1OoBFImkUsNU/QibDVytT3wfYk9D6enAKF+rs2otHcADQPvqZ1a31YmtylciYGU
         /IS/tqTtx6bcTU1CxqVYLcamOCY9HVxPBEwtiFh5DNeFkkZYjExrcZcN5V8xdWAIh6iW
         TQmA==
X-Forwarded-Encrypted: i=1; AHgh+RozpcAX9lTgYNUqwqeEP2OKShHosOJhds3+jIbO5s9LrunQmvqrHrbRnnISz72+SkhVk+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHrk9ZPGtQRlbkoPxWKQleGFcDFBAFvjd4WyJXZlL93BnEk4f
	TVDmLhXhzWpbP9lQTUjB3Ljco5nexGfemTAHQVlXmvfJIkip0qiIkPICuCTSPwovMfk=
X-Gm-Gg: AfdE7cm1PXnVt6NNrl0kBRX/LexHpDQhra1zWNxpg0tik00EJDwn+X+qDCZ5m5kC+JS
	sf57Q0WI6sHPqh/itY7aloWY/xN3jcHz4n66tRisjWjRgAhCsHV8KVojCwH/rNxaglSOWuZBvAK
	9TRt6lpyxmRyPCIjI0uTeSqqa5VGv2k+f3hXqsjYOpEYamC5eNhCNHov0W2Nj/fGLMScbwdm5I1
	+f9HWArGpSVvHoiTyrztzx1UOcEnL5b9iSQdxHB8VlIbLlbsRfP9OOPYzM6HcJbUA2VU8MapuET
	VNgARdx17SL7MrOSmrFrs/CEPJfHCQ71F3QZVPaIwoEH8tknZ1FhsLayyaRxQ4LNbp6W2TJxHNE
	My91a0ZCX1gTcfJEV6+0PAMOh0u3wI2sH8VW0z6n4e+6Lc3lvFP9b4xa95al6STZcS3IO4QzsK9
	w1fp2seA==
X-Received: by 2002:a05:6a00:a29:b0:848:2f71:b656 with SMTP id d2e1a72fcca58-84a6739e5b1mr9204252b3a.65.1784239498450;
        Thu, 16 Jul 2026 15:04:58 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc8e7sm5355094b3a.47.2026.07.16.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 15:04:56 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:04:53 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial
 Address space
Message-ID: <allVhevKwehXUoqz@p14s>
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

I scrapped it.  There is a lot of churn in the kernel baselines and it is easy
to overlook a patch.

> 
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
