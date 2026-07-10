Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3023ADBAD
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669022; cv=none; b=DwVBGhzptxX4T70T4HgM7lrMiWomDTWIoJQ3lIB68c5Qq7QwmQS03NIEsL/aqj/Pmg1eBAXNxVV75ho/2O0nGpzB6WaGzayi9aYN0RnHIbryTTqHyWCSqzn1EteqtWowzW0LIWjDLHwgKg/FojHNQXTlaZQyxgDOUjMtYtfDx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669022; c=relaxed/simple;
	bh=MLChOdhr5aZKfu9rxZ1o9h2MpZ/MjJvqxbOPstGkJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYFWEbmI+Dl1yFEGiU9JtVYOqsZFAlhp7I40sLzMtcN3T2ZXRTgvSdF9j2860caXwF5EUJn18wVyoucYKvFaBkD8tntxZMqEq8tacviHzJXNiRiQYhrY85KbC8sNcG85u8vXJ8oetgcxJP+LG9Uk75gUX/fuSixYW4mFtZbePZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkPuQLIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkPuQLIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6025B1F000E9;
	Fri, 10 Jul 2026 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783669021;
	bh=b84j8BRb9WotFlaTbggvLYyWIKKk/t181LGP2ZV1jvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gkPuQLIjaexg36f+QvwVppKPu5AdXMJt06ZvxQqk/Xfw5H8PJDRCY/yTUpzSN7lc7
	 8/WdF9UgQeUwMV8YJeKITpCZJ3Zc7AJ6qe5coYROm1C64C8mO3yeOSewADEKItg9gu
	 WuNLMCAim32wOEBIzQ1smD+/E/mZWcHe1DbtI6RFaTFF5c/mNg7EJNQGBebIWf+KKJ
	 RwF57n2VGiLpvCqtikH+b2zXMqw9AWtXBECWfZWoVkRrBx4R8NOnH7mkr/ljPyPFmp
	 TPse0yg/2+8cKKAlY3BB+XUIH3C9bZaqz6Jrg0vngSuukfgEZtnvm7czkRyVbWEnmv
	 eyB0GkZ4wJqsQ==
Date: Fri, 10 Jul 2026 09:36:54 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	jpb@kernel.org, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
Message-ID: <alChFhS7HwGXcVh+@lpieralisi>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
 <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>

On Fri, Jul 10, 2026 at 11:09:43AM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > This is a temporary patch intended for testing purposes only. It provides
> > definitions related to supporting Realms by the QEMU-VMM.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   linux-headers/asm-arm64/kvm.h |  9 +++++++++
> >   linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
> >   2 files changed, 26 insertions(+), 4 deletions(-)
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
> > index 50e87ed72c20..dae6e5ba8457 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -685,11 +685,21 @@ struct kvm_enable_cap {
> >   #define KVM_S390_SIE_PAGE_OFFSET 1
> >   /*
> > - * On arm64, machine type can be used to request the physical
> > - * address size for the VM. Bits[7-0] are reserved for the guest
> > - * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> > - * value 0 implies the default IPA size, 40bits.
> > + * On arm64, machine type can be used to request both the machine type and
> > + * the physical address size for the VM.
> > + *
> > + * Bits[31-30] are reserved for the ARM specific machine type.
> > + *
> > + * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
> > + * For backward compatibility, value 0 implies the default IPA size, 40bits.
> >    */
> > +#define KVM_VM_TYPE_ARM_SHIFT		30
> > +#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> > +#define KVM_VM_TYPE_ARM(_type)		\
> > +	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
> > +#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
> > +#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
> > +
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
> >   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> 
> The definitions in this section aren't exactly same to that in (v14) host series,
> leading to KVM_VM_TYPE_ARM_REALM = 0 in my environment and the realm guest can't
> be started with the following error message. At least, KVM_VM_TYPE_ARM_MASK has
> been redefined with different values.
> 
>   qemu-system-aarch64: KVM does not support guest_memfd
> 
>   ----> linux-headers/linux/kvm.h
> 
>   #define KVM_VM_TYPE_ARM_SHIFT          30
>   #define KVM_VM_TYPE_ARM_MASK           (0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> 
>   #define KVM_VM_TYPE_ARM_MASK           (KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
>                                           KVM_VM_TYPE_ARM_PROTECTED)
> 
> After syncing the definitions with those in (v14) host series, I'm able to boot
> a simple realm guest (no virtio devices) with one warning.
> 
>   qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap

Yep, that's correct the VM type handling has to be updated and I am looking
into the cap failure.

Thanks,
Lorenzo

> Thanks,
> Gavin
> 
> > @@ -719,6 +729,8 @@ struct kvm_enable_cap {
> >   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
> >   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
> > +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> > +
> >   /*
> >    * Extension capability list.
> >    */
> > @@ -985,6 +997,7 @@ struct kvm_enable_cap {
> >   #define KVM_CAP_S390_USER_OPEREXEC 246
> >   #define KVM_CAP_S390_KEYOP 247
> >   #define KVM_CAP_S390_VSIE_ESAMODE 248
> > +#define KVM_CAP_ARM_RMI 249
> >   struct kvm_irq_routing_irqchip {
> >   	__u32 irqchip;
> 
