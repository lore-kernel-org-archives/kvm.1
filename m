Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F03AEB40
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235284; cv=none; b=bDz0dJHUc1QKuEQctP0h1/D/pvGfhV2b30u5xxDBXZJV7M1RLzTwuU/XfzbS6NIp9bCesm7dnKwrXPd0E+HDQ09BZ97A9J2QVVtoYY/c0wQxUiAK2OaJsJwumUB7IUTMCOMr3R019fWaNjiG5/1ST7nGb0m5wgNOGfulya+nZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235284; c=relaxed/simple;
	bh=QlDleFf1thsudBLvDEeQpD3uIYK5RhVqCf8AZj/Gqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8+52bRYQ3Zz/iAWO1iCADFQS5GkZfxCZ/BK4VbHHEvoZUCmwZLgO87RRGt+0UKkwRQIz0u/Dwfp4WVjWsf5ZzCnw6UqqAhXRLx4sntP2tN2q7vTSrXO2MPVSMZuxUDHldC+0Ni2z9JGoDn4SLJPjmtl3060tjDCqA1nB16Yovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GqSjwfzK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqSjwfzK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3872048b3a.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784235282; x=1784840082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HhLYnr/qR2b4y0zZ+sDHUxX9VDtn3ie68FSiMVa5FBY=;
        b=GqSjwfzKzSOmSjZLQUv9jQmXaXRaBc1PFmPURZy0mmEjdOtPOmWEbsnaI3kQIAfiMF
         TPR76XkYqG+6ZqJuAi8WYLfWaxdYlTfzxNv480pA4x38DIdbuJ+sspWTkRnKk/Nyv9Zd
         AulJqxi85cAnScLhK4aVIWqHAL2Kk7bH9thj4eqbxfm3bUYqSYrT9G7rKDJ9wZmxc2s3
         fRLiqHiD9VE2E/DNWak3R5gPMQhHQoLeGgUu7keiLp/ZJLRwaBY6kYmwJTlZ7UUYhW9v
         v2Il3SUyRBPzLKGy+827RmlFrJXLvN7YL3rPo8/6a7tizSiCl9w4zv+Pw54JPTJTmyTQ
         RFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784235282; x=1784840082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhLYnr/qR2b4y0zZ+sDHUxX9VDtn3ie68FSiMVa5FBY=;
        b=T2VvQjPMq0jOPVbVhg8A9brWyc4NFzVnwxRWnh1U4aPL1zaQJ+keZqjDyAGJs59uTg
         g21ZX+0fS81pmmaSGhkEpOfwIIAvm1k3eGPLQOww7sJDBVVEEYR3GV/GZjfMFcEaBKvh
         5XJ7x5gHmFOXgQ/egg54jZObanXANjnaRzPhRCVDAGsvDScDu+OSgqQTPE+97blBngRn
         gowHCCRioClkz29JhJYSrd5yCT+z4RtkuCXmGK8KOq8ugKMQrA3kxMphqEx35JT78Gl9
         wM0xifPPZtvhNboL+Gasw4TPrNE/HdFWlgc2vVVXHR3D3ZG+vRhiIOb69/IrTEZotHXA
         l62w==
X-Forwarded-Encrypted: i=1; AHgh+RoYBLuuc8eLNg5QldpnOeMQpEYwTGwM3xc6KCDFQPuzwyKRnA8ZGGDc2kca9IDByB8GT3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxaSyfKM17oEYBiqPv+ki+YFXN0rmb4/2n7LWMPlRrN3xmtu3
	T35G+WS8IY8atj/vQyt8E3AeIYhGH0kf/1+RWI+n23AnUl/fSDOkyeET3y4P8Lm8TZ4=
X-Gm-Gg: AfdE7cmQJrkx1BUUGf0c8/ES6kbIScNhwlE9eXmKwprjFJdp1XP+DeB+7BcNThrp7GA
	8sbAqTxVVh2j38zD3hf9TAGg0L6h+Vc1TgD3GzYYhol54AtMurOqIGj+hZxQZ1M70oBj36yFtkF
	NWr1PrLcv98+7XaT4tYKr6/wnw3VgdWncrK2oVOvAndq9FMXBgsoimdHn6WPDulhYB3ZD1NOCvM
	srOIV/2EGeK5w4ahmBIPPPsdiMdGMc5qvePS4K1Z1BCeWqyNxKlN05NNmBswnrzC6s9c5wKzO0M
	Fpla4/0VqMCHVKTT2icpoH4djv8v4QiV6W4ajS9QrsAoCL7XrYOn3fTTBieTVibljidDHg8xPN+
	SG05XpaUUK+jVIMi3UtqZdKCtjH5ODEdfxI4gyPlcnZxcR+a4Ux2cW2VkvmhxN1+sNgdcWVhHqE
	3XSGQQVQ==
X-Received: by 2002:a05:6a00:3a01:b0:848:75a1:a0fa with SMTP id d2e1a72fcca58-84a6738bde1mr8608393b3a.67.1784235282318;
        Thu, 16 Jul 2026 13:54:42 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc8e7sm5302307b3a.47.2026.07.16.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:54:41 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:54:39 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 07/25] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <allFD6P0162v4Dcp@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-8-mathieu.poirier@linaro.org>
 <ac26ac91-6809-4429-9750-e7d671e952bc@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac26ac91-6809-4429-9750-e7d671e952bc@redhat.com>

On Mon, Jul 13, 2026 at 03:30:31PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a Realm is requested, create a scratch Realm VM by setting bit 8
> > of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> > for the guest PA size.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c  | 8 ++++++++
> >   target/arm/kvm-stub.c | 5 +++++
> >   target/arm/kvm.c      | 4 +++-
> >   target/arm/kvm_arm.h  | 8 ++++++++
> >   4 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 90c1d30ba24c..f763d5ed6199 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -99,3 +99,11 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> >       cpu->kvm_rme = true;
> >   }
> > +
> > +int kvm_arm_rme_vm_type(void)
> > +{
> > +    if (rme_guest) {
> > +        return KVM_VM_TYPE_ARM_REALM;
> > +    }
> > +    return 0;
> > +}
> 
> We had official name for 0, which is KVM_VM_TYPE_ARM_NORMAL. Another question if
> it's worthwhile to have this helper since it's equivalent to something as below,
> which can be directly applied to the caller.
> 
> 
>     int vm_type = (current_machine && current_machine->cgs) ? KVM_VM_TYPE_ARM_REALM :
>                                                               KVM_VM_TYPE_ARM_NORMAL;
>

Addressed.
 
> 
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 4ab6f08637d1..6d52f172c5df 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -129,3 +129,8 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> >   {
> >       g_assert_not_reached();
> >   }
> > +
> > +int kvm_arm_rme_vm_type(void)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 4c212ed0c337..6aa1cd04e484 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -108,6 +108,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >   {
> >       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> >       int max_vm_pa_size;
> > +    int vm_type;
> >       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
> >       if (kvmfd < 0) {
> > @@ -117,8 +118,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >       if (max_vm_pa_size < 0) {
> >           max_vm_pa_size = 0;
> >       }
> > +    vm_type = kvm_arm_rme_vm_type();
> >       do {
> > -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> > +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
> >       } while (vmfd == -1 && errno == EINTR);
> >       if (vmfd < 0) {
> >           goto err;
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 12ed1eee18b4..65ec1b970606 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -259,4 +259,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> >    */
> >   void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> > +/**
> > + * kvm_arm_rme_vm_type
> > + * @ms: the machine state
> > + *
> > + * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
> > + */
> > +int kvm_arm_rme_vm_type(void);
> > +
> >   #endif
> 
> Thanks,
> Gavin
> 
