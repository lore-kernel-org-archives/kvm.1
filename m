Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B91364052
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539079; cv=none; b=VEHtn6ADDcPVHxiX56ZM9WwWNeKLjqWN7/1WqhcMRqTe3qkZnY4sQtP1REognOuFR2jJ4qN9memXBIDP2LmMKk9hD3sVCSouXS00RAkvHp8s8G/AJ96LDBgdoMkUjwvb9njqNH2B9ZctCEHBViW/sa2uBL2Yj3aV3NQeRndH2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539079; c=relaxed/simple;
	bh=L/GJ3dtdBVSaCJ10jrP76Nerw7h6pRD40YDAIxjICjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtfq7J+KX0oAArX6k6gAlstU4ImsUCjw2+yTddyIc1VvnMxgnfFx0zkRC+KlEy6N8kJ/4pK5WNYz6Nvgp9hbbWtk97uJVmAycwgoSRZWjFtoEzC1XLp8XTY1IViVRgsUrpFBpkYswh8epL08Wst1gFptsDCi7S66KIZtvjhpWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QdlmU2x0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdlmU2x0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso1173510b3a.3
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788539077; x=1789143877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUW7zAhH9a6+Eq1CxsZDjyjXnk3sjjEG4PIOkiEC1b4=;
        b=QdlmU2x0tbbovg6fXFLor1No50vj6RUcBOfXAnmLEEzOCpa8XnzYBGLf9Wt0ESBGPk
         aVpF3GK6UpzxQMWsXsPOh6+1VA+3lH18iw87Cdy5JzQtOMSNMTU/sepV9kUSmvVYO/M8
         3ocxbFyc5fgUOyCfRMvqcirVU315B8jJVkFHl21ujjEEFB+7TJekbJhBv95d7PeQS/Hi
         lqut6xlG298BHXVmPxRm2ZX6whybfEx6wVxnH66/cIUFKgJ7RcMKXlkxI/sLitahRF3C
         lPi2VdYPohyaP9l+wqaIjLxnP2YcRxrcdOILYaTt8XyBieEAEFojHOroLazf+EmvAIcr
         zw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539077; x=1789143877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUW7zAhH9a6+Eq1CxsZDjyjXnk3sjjEG4PIOkiEC1b4=;
        b=FLaEBV3x1dfJHxp66+0uAnxGXve5fdvvc1WJHeEx9eLkMogQoVm9rqv/V5TEbksEUL
         jtyxS69q/X3bHLHc6GsBi6UUTJbiYx0DH+LtbEUBP3JbGRogiwWwx6MjM5GbBFFuSneV
         UF/oH4V6/qavVWWxbmPy0tHmk8U1Wo8XtvRQUy6BdlCJ7Y/ehJG9uqizWRwQh6m+n5U9
         UG9qo5YT5/EwURA8hDyYB0Tra/0aL1cRfxmKF2lQlyJrwCBNYz3nNDEYZk3cF0rDxYSl
         9Tp7ISpqArKM1ivZN/2MPL8ahPtlp94M1h9xk0Q2rwmKIFFmVIjeHZ3Jz58lgGyX1fGc
         RzXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxq8rMzORmSlMEaO5s4U32Ze9D7EQ0H0dQYXOJEHbCrEO4Dm70T3DYjCEuJz8enoeGAqY0=@vger.kernel.org
X-Gm-Message-State: AFuF++m09L2P8yA40Pk1VQFczImJ5HK92CXDd0v5td/dvircOxKjeWXz
	PURA1AZaQQlFlvPQerrw3LHhoCBr//g+2paHLUd4MByVVvRqiDWM23z+R1TiXMQeQGc=
X-Gm-Gg: AYBFou3dozcyQ16ALUbF3wZvGNHk5bQJn1T2WNMKhH/RomfnCtr33g0BnSq3TIdTQjp
	VsC0+e7j5ZwpP/mk5mPqvO7cqVr19g3XUzkYOGwnx40XeG61Tf+kJI0c2zqS8w4+aiRQX3LNzlN
	kmGPg98jU+hsk8q1D8Sw19YelaE0X672avaB/2wc5hghRZ2XwjtpB7VBrWbNNSSr4JJzEFgKnJ0
	CGwKPb+oEOTNPwdzg8Ym4BYZ9Mkd8NYoRwSqdpXf/ZTojBrzYA7DAMi2RRF6juH8Jj87OmBzF6P
	1Y1ZveQuK+ybPNZTRjHRwBsmKiHbmkPRYcojjGo3xXfx9QK5iti123U4hSCl5xVx09DWzuA7/Qu
	rIsgZ9ERhocHG7rcxkkuVx19TvlNLBLnehVHMG5xjxsZfPJvL/MBrAnbdutgwsvPvVnnaND6Um4
	4imedUMO1Wh6wcwPQ2duuNBPMinteVIgyeKpfNg0I35vgW1Jh/AgG94CcnHBJAwSxkDG0CRzX+g
	2I=
X-Received: by 2002:a05:6a00:3ccd:b0:847:9015:e68c with SMTP id d2e1a72fcca58-8616ad5265dmr10153169b3a.17.1788539076507;
        Fri, 04 Sep 2026 09:24:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f95f:75de:b3f0:3bf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f74sm1375802b3a.10.2026.09.04.09.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:24:35 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:24:33 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 01/24] linux-headers: Add RME related definitions
Message-ID: <aprwwdhwkaDn9xo1@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-2-mathieu.poirier@linaro.org>
 <b06c933e-b8fd-4e03-8f50-9a9086542ccf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06c933e-b8fd-4e03-8f50-9a9086542ccf@redhat.com>

On Fri, Sep 04, 2026 at 04:07:49PM +1000, Gavin Shan wrote:
> Hi Mathieu,
> 
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > This is a temporary patch intended for testing purposes only. It provides
> > definitions related to supporting Realms by the QEMU-VMM.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   linux-headers/asm-arm64/kvm.h |  9 +++++++++
> >   linux-headers/linux/kvm.h     | 10 +++++++++-
> >   2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> > index 6aefe7973814..4c08631ec7d2 100644
> > --- a/linux-headers/asm-arm64/kvm.h
> > +++ b/linux-headers/asm-arm64/kvm.h
> > @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
> >   	__u64 reserved;
> >   };
> > +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> > +struct kvm_arm_rmi_populate {
> > +	__u64 base;
> > +	__u64 size;
> > +	__u64 source_uaddr;
> > +	__u32 flags;
> > +	__u32 reserved;
> > +};
> > +
> >   #define KVM_ARM_TAGS_TO_GUEST		0
> >   #define KVM_ARM_TAGS_FROM_GUEST		1
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 29f81c05aca2..8b7627f11447 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -689,14 +689,19 @@ struct kvm_enable_cap {
> >    * address size for the VM. Bits[7-0] are reserved for the guest
> >    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> >    * value 0 implies the default IPA size, 40bits.
> > + *
> > + * Bits[30-31] are reserved for the VM type
> >    */
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
> >   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> > +#define KVM_VM_TYPE_ARM_NORMAL		0
> > +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
> >   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
> >   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> > -					 KVM_VM_TYPE_ARM_PROTECTED)
> > +					 KVM_VM_TYPE_ARM_PROTECTED | \
> > +					 KVM_VM_TYPE_ARM_REALM)
> >   /*
> >    * ioctls for /dev/kvm fds:
> > @@ -719,6 +724,8 @@ struct kvm_enable_cap {
> >   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
> >   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
> > +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> > +
> >   /*
> >    * Extension capability list.
> >    */
> > @@ -988,6 +995,7 @@ struct kvm_enable_cap {
> >   #define KVM_CAP_S390_HPAGE_2G 249
> >   #define KVM_CAP_PPC_COMPAT_CAPS 250
> >   #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
> > +#define KVM_CAP_ARM_RMI 252
> 
> Both KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI aren't consistent to
> the definitions in Steven Price's (v16) host series [1]. They need corrections as
> below. Otherwise, realm VM can't be started and the following errors are raised by
> qemu.

The changelog is clear - numbers for those defines have been bumped up to keep
pace with the definitions in the QEMU master branch.  RFC v3 had defines that
were similar to Steven's v16 and as such used an older QEMU baseline, but Markus
said it wasn't appropriate.     

> 
> [1] https://lore.kernel.org/kvm/20260803134403.80630-14-steven.price@arm.com/
> 
> root@host:~# qemu-system-aarch64 -enable-kvm                  \
> -object rme-guest,id=rme0,convert-in-place=on                 \
> -machine virt,gic-version=3,confidential-guest-support=rme0   \
> -m 2G -cpu host                                               \
> -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2  \
> -object memory-backend-guest-memfd,id=mem0,size=2G,share=on   \
> -numa node,nodeid=0,cpus=0-3,memdev=mem0                      \
> -serial mon:stdio -monitor none -nographic -nodefaults        \
> -kernel /mnt/linux/arch/arm64/boot/Image                      \
> -initrd /mnt/buildroot/output/images/rootfs.cpio.xz           \
> -append earlycon=pl011,mmio,0x10009000000
>     :
> qemu-system-aarch64: VM doesn't support Realms
> qemu-system-aarch64: failed to initialize kvm: No such device
> 
> 
> -#define KVM_CAP_PPC_COMPAT_CAPS 250
> -#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
> -#define KVM_CAP_ARM_RMI 252
> +#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 250
> +#define KVM_CAP_ARM_RMI 251
> 
> >   struct kvm_irq_routing_irqchip {
> >   	__u32 irqchip;
> 
> Thanks,
> Gavin
> 
