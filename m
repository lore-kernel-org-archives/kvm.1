Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3530E85D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977088; cv=none; b=erVuBl7SPUU8mfOl65t7l3FWmKex23z8vbL3jRHsnjSQHqjB9I0hNDesZsJ5uaPX8WWlL1fGblFyXttVVJx38UOfKOi54dX6jhpdwBxkTWHbOWgcqF5dgvSmxEQ0QJISvh5FK/iXJzec2nxWFz0V1mwOSS2KxcXdUu3gapjqRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977088; c=relaxed/simple;
	bh=RlBQ1BVc48mLS97mhVNas8rRRx2MGY9TB6RBuGhvhJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN6KIg+X0mzLv3BsqJa0i5dZY3FUP0sXwWN7FKfmiChTzobuJfMYprtV9zZkjh/yHHmP5daA7PrHBH/hYBBGqeFIycXCLQ6CY3AVKP2I+Zyf0uO3Uh68tgObQHqnLtbN4Cwe6X9s92NlnTlE130x3qVlUB4O9d2AZmVeYpBMojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzq0HbeW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzq0HbeW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca80d708489so220875a12.1
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783977086; x=1784581886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GW/F3qWXwwX4AhwH+nP/rLsXsp8Fz7nEuN27rGBIfgo=;
        b=wzq0HbeWCTXmY4oQq2+nwLRQhXNJJqmMVSXUaCWwWaw0yKYEDCdC9O7cBcyNQnGkq1
         dvn+6Xt3YlaoxI4NGgZm+xAq35CFBSvcDG+GuXh9/8Rrx8++exzP8DSCAnVRiXqNvvej
         l0cpRK5qN6pA8BxOoGLYHaY4AwM5SmbawD4YIkv4eVdaVLes2tqjyNzr1iOyoBESFu3R
         xapnYw4luKeq9bBgVqoxDonY4cEeAVaAemsZTXiYI0LnSg89qHXbFHKcL+vj3nD4cx02
         ftWum95hMbKehVTVDYD0BtgA3cU8t5ea4zuYiRiV0gU0xmpBCUvvsuwGy1rk0Mfm1CBP
         kFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977086; x=1784581886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GW/F3qWXwwX4AhwH+nP/rLsXsp8Fz7nEuN27rGBIfgo=;
        b=Jtwu8hZ2m8lGlkK5Gbc9PZayoOhoTxOOrBBV8sQwM7FrNZBLmORCShBP0Odc01wP+B
         zHmDkLAmNWXQayFOsO4jQ0nBBIPMpb85wN2sto3tjEukTejY7u+PKJ6WeqT9YlvS4mx1
         MopDA6eBxYIRAoAKexSiKw8uUIlGB6TiSLT4xR2+8izCW//lGk4B+HF1YUsvQZ+Wc2EY
         lXJmPNGAAlkJa8gxwPm993H3PZOmuJ/V+lAUgegxREROdphsYHIiVm7FlmL2UgQWjPB+
         IH89ESX8nWrHTJW30vvTD6Sb+HG3AjL3U1tcvogGznYRbwseXpPuJBtU1hJ9E1ZI9x6E
         Mdpw==
X-Forwarded-Encrypted: i=1; AHgh+RrG7xbTRdmjBPGmHwcf9AdqEcJLV4FGhYqypvp55yPzUu+0HVnVKVzPkx2xe9D0NfLx0Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9UbyVMQmVg/MQ9cTng/EqDa5l469q97AjoIg6U1l9jK8rPJg
	YtI8/QFp/3fAPXLmpkSUGzNgbKr+er90+wRVic2wdaPF3U40vWutO7UhC3dAtIj2giE=
X-Gm-Gg: AfdE7cnOfZ2Wg8iwJ6txqOakPrgvc+yZJjwn8g/qbVqiKjy2HNqyWavUR96KhkXEAnL
	a4kQJ1cWoCD44gaCbBwUOtHxWiYdCB8fMu1ihe/jIpYfd+T8la6oa/XwpOndSe73pR+LqXiwqNm
	NZkBHZLUcaqmFU0AgwLCuK9/yK/PazYIfFSUSFUHUxNTet76/M1wDIPG9jdr9tzenAXSgPo3ZWh
	BJUDp0dRJ5tNvTLvjQutkwOJqrlCepj+V5eXjbVKhxHAQEz3OAqJCXw8GZbZo47u4BkjVyClYBv
	Lv7AQLOnIb+imFhxURPrgjS7WyD3x870895crbi302F77eFQ2IFVMfvP8HsM0Zq234RMgOoBjHX
	rRK+ao/BAgOgLg+uyCBP/7mvNmqn6pR2JMlrN9mFqSTCIhI3DY6QAaVwUoOs+R0b64VojtQvz7i
	820+4uFrhdkOAFft+1
X-Received: by 2002:a05:6a21:9210:b0:3bf:8de9:c64e with SMTP id adf61e73a8af0-3c112b9c1d2mr10234471637.2.1783977086349;
        Mon, 13 Jul 2026 14:11:26 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3ead:2a56:27bf:77cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2bf6bsm9108149a12.27.2026.07.13.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:11:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:11:23 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
Message-ID: <alVUewIPbsAClmau@p14s>
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

I agree with you.  Although outdated the above should work - left shifting
0x3ULL by 30 seems to be causing issues.  

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

Right, that one is useless.

Both issues reported here will be addressed in the next revision.

> 
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
