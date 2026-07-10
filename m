Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27371A268
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645797; cv=none; b=PlvHBXfb/fI3dCJvYIFbsqVDcsOKiMYCE6/Py5Z/BboGzmdgckSyUQ59rjnlATZMsyHnHJyoMKukwwF8Yc4YVizdjXq9c94zRUADXgcAIsqSolejmM/X8apIO/o4oPEu/rn9aLKYorUKkz84/KLwXjl7eStiDRdv7nfUFObJOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645797; c=relaxed/simple;
	bh=64bxvq3Hrhvx2OGfBZP7KPipW68FicMgzjgIXRnubaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuJfaeCD6ASpiCGEHWOecL1BE9g7TMRW5AtzOnapkbz7wf5i96ZACDnIMQZvOioLWnmRKmgfShZ6drlIZzFu8rtBD2fHOtUwa1IJV3qqD0V9E/1r6Fkbi5GyG2GjSCNZESEqC+14ql6sfCiTBCUWHaWmD3VzyvHYlqgVVZ1DwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b02ThrQ/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pS9lF/8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b02ThrQ/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pS9lF/8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783645794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
	b=b02ThrQ/hqYV6XYQ7uqouccoJUlgq8tkDuLRcuaYdtdc/LnDwLfVQ0jJ5Ul6aXUuswLPCq
	538EP1qobTlaG06tC4pWc0/962DaSAqX1l/41QzgaoVRgbWDJvHOYWtmeXNPohMGfT1h0d
	gdMdvsJOU1fYVbiV4Zs2w6cXGeZNzD0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-d780NzwRP5K8NYFVA27Sfw-1; Thu, 09 Jul 2026 21:09:53 -0400
X-MC-Unique: d780NzwRP5K8NYFVA27Sfw-1
X-Mimecast-MFC-AGG-ID: d780NzwRP5K8NYFVA27Sfw_1783645792
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so709018a12.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 18:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783645792; x=1784250592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
        b=pS9lF/8/HaW/s4hF5R2VHr/+CedGxCONdW4+24UuM96bfxqc0KwSxpCCjM8D1Okm4d
         EJ5uWXmmpRGikmNHzjXMNMaygHwZq1+mF0gHxacTSkCwruNBTCRef91NhgN39Uzpt/X+
         T5qqntenL92NoQFVVLT35uM9QErFiO1eXgZ7wROsBVjHwAs1XIQp78scmZ9ZnJN3Y+rG
         c5V1r1i5/VTJ0H6GWI6ZGvTX8O840GKsXyRGDPPmzgG4QKVCvDmdjNb6t6XWQQrT+Moi
         +3AO41uGVGiJcv65NS7YLtzNXM2w5hy6IK4fUwhLRYCbJRohtDpdDT+3ox3zLMPwo4Vk
         fxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783645792; x=1784250592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
        b=iQdg0YofDaKdUhb/AvK7PCVF8ysi+s1dVNGYw5f3L8mp7QPcv9PtGvgIpC++m/UOnW
         vjTbP2dvel7RuL+vUphirXUt6aJA0txagurq3Mh7Zg4PBUyCCGrWmRpRCY+yMiFi0p/D
         xrgoe0tYrTNpLyOo47eOtnNRPQj7Xh2qTj77It5OczEnAAlNyxuHXQad6QJ1jvi8F5mf
         O/p+1lq/v1mQ/M6YASJ3m+Ts2IBx+2P/3Lx7800E+/55I+dkjZR3hRgR4es3BvMrnBjj
         JS2xCfMtJARe9LDCMGVHJMVi+RhSOjYnZcZCpPx1ABqDhk3vZ3AonrW2JLnINDz0GPiO
         n+cA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9DAUQUcpNQroq6fTGen2TyV+L6RDkyPv2KlPqfkfQUYE07piyOYsLeplKnFa62yYToAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq7rfRQLdLz36O75lSfFRgnw8uTMtS13i26Dqqw8DvXA8Dupx
	QPsEeAwRKS1Qe4vRS9gqY7cSqAswvHHH2xcNuVtxsutgZExUVNZa4BsoccbYx7IIuqULBTPuAQn
	ohDv4ph+CPCjT0W15+XHoGpcGn5D3HXfinn0i6PKxQ12RsvnCRifCyw==
X-Gm-Gg: AfdE7cnzu8PK4N2Qu9lrPQgzW7lOXHC6w2+agjXEFurFsx+6hPTVqxn+JSsRNtnozTu
	NTVxtMUZ0rYrbMRU4CQNIAzyHm2D3bL1EePsu9JttaHBwDK7Ln+BF9rvPLB//dSHMrYDB4ILDFM
	3jmVWCIrvl1p7kMDVbboqb8nfqKdrXrPTpkYSgMlS/GjsK/fPkDphjH5wT6hqx9JVLMvohuWsK8
	BZ9lp/kSMZOm39z9fHVZws9DI4YKlPJiBZSF7nspgxHL7Bi5oQooDVF8yvpSmMb+mqEOtZzIJL8
	yIqFmbxjJvDXoWDMT7K3Sb7jms2goK/BF07nBkVIcU92X+EqH/xrWKGm4Hf40Lhjlk+k7GlwJpC
	rE4Eqhuu2zjo3ibBbYa+mmK2NR3NPCxbB46am8E0TgMk0wISN3XFJ1Q==
X-Received: by 2002:a05:6a20:d708:b0:3c0:b62a:2b8c with SMTP id adf61e73a8af0-3c0bd3983famr11784211637.70.1783645792257;
        Thu, 09 Jul 2026 18:09:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:d708:b0:3c0:b62a:2b8c with SMTP id adf61e73a8af0-3c0bd3983famr11784169637.70.1783645791764;
        Thu, 09 Jul 2026 18:09:51 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm37162096c88.12.2026.07.09.18.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 18:09:50 -0700 (PDT)
Message-ID: <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
Date: Fri, 10 Jul 2026 11:09:43 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   linux-headers/asm-arm64/kvm.h |  9 +++++++++
>   linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index 6aefe7973814..4c08631ec7d2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
>   	__u64 reserved;
>   };
>   
> +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> +struct kvm_arm_rmi_populate {
> +	__u64 base;
> +	__u64 size;
> +	__u64 source_uaddr;
> +	__u32 flags;
> +	__u32 reserved;
> +};
> +
>   #define KVM_ARM_TAGS_TO_GUEST		0
>   #define KVM_ARM_TAGS_FROM_GUEST		1
>   
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 50e87ed72c20..dae6e5ba8457 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -685,11 +685,21 @@ struct kvm_enable_cap {
>   #define KVM_S390_SIE_PAGE_OFFSET 1
>   
>   /*
> - * On arm64, machine type can be used to request the physical
> - * address size for the VM. Bits[7-0] are reserved for the guest
> - * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> - * value 0 implies the default IPA size, 40bits.
> + * On arm64, machine type can be used to request both the machine type and
> + * the physical address size for the VM.
> + *
> + * Bits[31-30] are reserved for the ARM specific machine type.
> + *
> + * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
> + * For backward compatibility, value 0 implies the default IPA size, 40bits.
>    */
> +#define KVM_VM_TYPE_ARM_SHIFT		30
> +#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> +#define KVM_VM_TYPE_ARM(_type)		\
> +	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
> +#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
> +#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
> +
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)

The definitions in this section aren't exactly same to that in (v14) host series,
leading to KVM_VM_TYPE_ARM_REALM = 0 in my environment and the realm guest can't
be started with the following error message. At least, KVM_VM_TYPE_ARM_MASK has
been redefined with different values.

   qemu-system-aarch64: KVM does not support guest_memfd

   ----> linux-headers/linux/kvm.h

   #define KVM_VM_TYPE_ARM_SHIFT          30
   #define KVM_VM_TYPE_ARM_MASK           (0x3ULL << KVM_VM_TYPE_ARM_SHIFT)

   #define KVM_VM_TYPE_ARM_MASK           (KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
                                           KVM_VM_TYPE_ARM_PROTECTED)

After syncing the definitions with those in (v14) host series, I'm able to boot
a simple realm guest (no virtio devices) with one warning.

   qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap

Thanks,
Gavin

> @@ -719,6 +729,8 @@ struct kvm_enable_cap {
>   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>   
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>   /*
>    * Extension capability list.
>    */
> @@ -985,6 +997,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_USER_OPEREXEC 246
>   #define KVM_CAP_S390_KEYOP 247
>   #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_ARM_RMI 249
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;

