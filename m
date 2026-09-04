Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9F415F29
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502433; cv=none; b=SmqZU1DNTtC2JPB411urAzOTDTvSOLGkGdG9Gt+IV1wJsCZxsSRZOoN4aJRPEMwvf8Ttz156uJyjHkHcirax12GEmV3gdlN/naykM7XU9dQlqw4jQOUyBfoej3v3f6PQ4eaWro2g9vu5X3tgq+PntGTCz1AGmQJ52jrX2QYrboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502433; c=relaxed/simple;
	bh=/5xEd1WFw//Xcmt2lCz5azWI5y/0Dnt1PmpBGAqwDxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reyFeX6iQAFNG4vIL7p0EhbfjERPV1zfwv/RUpNyoK6yzEL+jSPl/KkcHJpT7T+27q3wY5gapNL6VcBvKyCKPsDgVvFD7LRL30cNQQDLQ3V2rgsub9aJ0vV9J4N2pT3Ff5xbdGHyTmJoWl7B5mg5IsCSxrpju57Oe/8jTxihGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFtOc+jZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzuPEMzY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFtOc+jZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzuPEMzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788502430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
	b=hFtOc+jZNxJ68zSo7QJ4quZp9TkZ3EQ+i2idaaBpieZrG2df2+UB/9DZH9ECXGr/vjPNNZ
	6V7kTWauAEo3BDsIcAAyGxJ9WUYzeEcuGDJw3kf9MtwEnfmVxowJYn+/BWzSdo2ozJjLdJ
	OdpyjgD+Oi+X1Rmf/5LY/g3lyv4oeHE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-AXfEuL-EPJatAGpnxskR-w-1; Fri, 04 Sep 2026 02:13:49 -0400
X-MC-Unique: AXfEuL-EPJatAGpnxskR-w-1
X-Mimecast-MFC-AGG-ID: AXfEuL-EPJatAGpnxskR-w_1788502428
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1197453a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788502428; x=1789107228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
        b=OzuPEMzYKKyjXRIUtyAxUfSXnIfdaHraSQ7MUIoGWLwLjQCGrNmXYWtgXWAmr9AWTb
         eCs7assnz/sXYbmE/IhdzMOTdjAPUMIxDpxkDbc4hUVij44nhgkPfKugiGA/NZcmWNfO
         KP7nv3OTK+wXNUeWDRvv0tLvYHemQ9Gl0R7XDivJUmOY0wNCTxbNMgOiYr+n6UkWzSDH
         SIlx0GsQrBdG8kY6sZfDRa8QnUnqCTaQTIMxvvAuNhZ/ECqOXopvkz2pGd2Y/dyOsOVz
         lSZvnHwtdLfqm5Z48zL2aVwrc3MrnNbhWBW69YZqyhVX3FcyclbJ/cz+6MuNhyoRdGut
         Mohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502428; x=1789107228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
        b=eIUoqz6/7W1iCnQx5lx/7G60yi3dv8C2GVRdU9GyQFr4KDHn3Wgw/azxMdfyYglEDN
         wQfQvPThNNgCyhdzS8W6Rug/cfC1Q5+5xokHjhmnw7OCIfbi99iYyh7SN1POp4tI2s04
         rC7qldmxITtFDgrgOM/dw64wpWExy4fo+BgiFms7KTWSBsET0LZQOomjCwK5g7bkFs7K
         PBJ+wfacdydZ5O9X1l4LXIxw6AFxqyG0RveQy3QRYXXUDjDWtS8tGNvzxjemCdFxOmbP
         PQAPNgaQcW+5N2X2aTJfvnQkzv0GF7ZQP2yTgwdlpKnmh6MBXSE546VIWwMdp+KacZh5
         WDtg==
X-Forwarded-Encrypted: i=1; AKwUvBxDe/MAKLQGEBFlnfaGueVGAu26aAYaANN/cDOoAnGUTN1furlPO5AE4xuDs7+8U8voHSg=@vger.kernel.org
X-Gm-Message-State: AFuF++l8S70qBTfejn/jcsQKC4lvlO7BOxlafhiRFrC6dh7YlosLWL7n
	JtLR43Bh5C5gDLuWu4c/7FYpQhY9/9j622b8EfLFpN3K+4krM64K9fi8/EU1iBeUlMdh8eNRRCl
	7Mx9ESc1UJANnGmE3s62okwFOEGwXBD97TcB/uo8XMsXPEG0Sr/q42rFxwoY4vQ==
X-Gm-Gg: AYBFou1TMu7ZywCupBS0UvKs+8HxfOYSkQc6t0O3okIjrh3MjsvBu8+T2YX/dabrNho
	qdGdV3/7Xv9glCB39aU2pRGKa2zoU35gzCE2h/bewvWfKKBCeN5xsbstybjq5oCtWiGEo3iHJRA
	+MisO3uhXbPSiIuZnNN1DkgwTup7BHPV7F9RH95g/nendEmC9GA05tANk83+12SM4jK6UHh0M83
	S5islbGp+Fd4jjRvuZmD+beL6wKrIWpjPwIb/aAxTEpZSbwokEpgk6O+Ky8gF+4RmkWbgASH5di
	mnGEufpdeJ2Ki7zEegOYOEzXtWOW/UT1ZzDtsqAQSTaeQ63njyQEOlAlFOmBq2XlST5kdVGUSj9
	sLj3QIFncB+LISMZm2QwDZbYZcUQPzQrS/01Ezyt1EA==
X-Received: by 2002:a05:6a20:1609:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3da39fef371mr6522760637.18.1788502427863;
        Thu, 03 Sep 2026 23:13:47 -0700 (PDT)
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39b2623ef65mr6523936a91.24.1788502077992;
        Thu, 03 Sep 2026 23:07:57 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm3852026eec.27.2026.09.03.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 23:07:57 -0700 (PDT)
Message-ID: <b06c933e-b8fd-4e03-8f50-9a9086542ccf@redhat.com>
Date: Fri, 4 Sep 2026 16:07:49 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 01/24] linux-headers: Add RME related definitions
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-2-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   linux-headers/asm-arm64/kvm.h |  9 +++++++++
>   linux-headers/linux/kvm.h     | 10 +++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
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
> index 29f81c05aca2..8b7627f11447 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -689,14 +689,19 @@ struct kvm_enable_cap {
>    * address size for the VM. Bits[7-0] are reserved for the guest
>    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>    * value 0 implies the default IPA size, 40bits.
> + *
> + * Bits[30-31] are reserved for the VM type
>    */
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>   
> +#define KVM_VM_TYPE_ARM_NORMAL		0
> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> -					 KVM_VM_TYPE_ARM_PROTECTED)
> +					 KVM_VM_TYPE_ARM_PROTECTED | \
> +					 KVM_VM_TYPE_ARM_REALM)
>   
>   /*
>    * ioctls for /dev/kvm fds:
> @@ -719,6 +724,8 @@ struct kvm_enable_cap {
>   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>   
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>   /*
>    * Extension capability list.
>    */
> @@ -988,6 +995,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_HPAGE_2G 249
>   #define KVM_CAP_PPC_COMPAT_CAPS 250
>   #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
> +#define KVM_CAP_ARM_RMI 252
>   

Both KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI aren't consistent to
the definitions in Steven Price's (v16) host series [1]. They need corrections as
below. Otherwise, realm VM can't be started and the following errors are raised by
qemu.

[1] https://lore.kernel.org/kvm/20260803134403.80630-14-steven.price@arm.com/

root@host:~# qemu-system-aarch64 -enable-kvm                  \
-object rme-guest,id=rme0,convert-in-place=on                 \
-machine virt,gic-version=3,confidential-guest-support=rme0   \
-m 2G -cpu host                                               \
-smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2  \
-object memory-backend-guest-memfd,id=mem0,size=2G,share=on   \
-numa node,nodeid=0,cpus=0-3,memdev=mem0                      \
-serial mon:stdio -monitor none -nographic -nodefaults        \
-kernel /mnt/linux/arch/arm64/boot/Image                      \
-initrd /mnt/buildroot/output/images/rootfs.cpio.xz           \
-append earlycon=pl011,mmio,0x10009000000
     :
qemu-system-aarch64: VM doesn't support Realms
qemu-system-aarch64: failed to initialize kvm: No such device


-#define KVM_CAP_PPC_COMPAT_CAPS 250
-#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
-#define KVM_CAP_ARM_RMI 252
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 250
+#define KVM_CAP_ARM_RMI 251

>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;

Thanks,
Gavin

