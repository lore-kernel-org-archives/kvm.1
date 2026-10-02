Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332529BD91
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914583; cv=none; b=iRKseAxNSWn3VoxMOgp0/KbIVdQDhDZBB9KoQsOfRhwHqkywJPE8cPIyaJ05IcYS94S/DsHLTGfg6JVoTaNU8MTGqryXHJHXiYEIKFutyg02Pjd+erhXS+5oqqWeaSHDFNil82lowxULOVB6hgmekkwEeBLqyt+o4orHSLBTwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914583; c=relaxed/simple;
	bh=c+B9MTsi323GHgkE/bMl6e794q9n9b8SXnOgvijxnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj53sHKvXZBeHiCbk9cs5TqLFkTJcUjrhzWu3VV1VT+vtvdoWpvjMq7psiV5WDnq4ijFOAW/h3RUu1W2D++rAl3+ArDk5m7mYznbf1Saxc7/lqrz6wBvGKrcl4ouFNj1t1X9ZUbZ9rwNP0muoW00axt69c12DSaQUoafei+yn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/wtgMQc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eI9ih5k1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/wtgMQc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eI9ih5k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790914580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nY/HDfa1K8lHV/bOI9KXS6udwAbaiCBgMf0RYAo0w3g=;
	b=Y/wtgMQcIDAxs2NmkH/69OW+Npmfodn4lURDuK9+W85lates55ZQ48KJJZc8hmQW8JRmBA
	Jja5dqnjeDsHFSvKG+q9TTicF7RrSz2n06J73PwlaZuCkYdOA4cFxZw8Aj4YUTII7VzO2W
	WWJ8pRbFD6s3ON/awu17FvvLKn4wnGw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-grkz_VELNxir5gHMe6qyUQ-1; Fri, 02 Oct 2026 00:16:17 -0400
X-MC-Unique: grkz_VELNxir5gHMe6qyUQ-1
X-Mimecast-MFC-AGG-ID: grkz_VELNxir5gHMe6qyUQ_1790914576
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-887e45c7063so1517709b3a.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790914576; x=1791519376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nY/HDfa1K8lHV/bOI9KXS6udwAbaiCBgMf0RYAo0w3g=;
        b=eI9ih5k1roVypjvRDQKJahrrquDgT5TuJipFQe0CFGkoeOk+Rc/b+Jz5NEM2+K1EFB
         PbdCe8Zt2quQpq0XAE+ltnZ72wnYlFxglWbdXx2zQiLPfITOtsa6NMbJaQPn4B1erJD6
         TKA868uSiIOMs98MsgU2iJRsoqqzlPip/0lOLFQ76Rgt7tfXymGlfNyzRurJBXsTrPLF
         8YrabJjCqvCKJmNX3tad1HY5L/K9n5YPI3zG0ldb8Jba/EpQ1DXqltH+7cv/uAoYY7Q1
         vj3wqWzobKP2x2ZLfqZe+BI6nxudDfjrD/DrgEJ1DI4CvOb4jnKiFbMCFnnAA9E4CLDo
         lONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914576; x=1791519376;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nY/HDfa1K8lHV/bOI9KXS6udwAbaiCBgMf0RYAo0w3g=;
        b=vsF8DNiSvBbV0+cg/QM6vz2HEHPBOjDBj4FoBkYCLJWW4EQFn82LVNkF/ZJcSEXXGE
         +1Fqg+2gbvEADRfccIwoKrwkObSxbBnq8cbrhmfMvge3TfO/vchpn7I66UKyPxqJqwiC
         0Ay+UclnPCuna3NHSh3i8ia6jm7ROjdjiBII4sMmphxRHubf8wmAofFTIc95OFwE91qB
         08lo5hW9xkpVaa9q0TyGBkQCIWCN/1HQ2ouxjnCw7S1XokrXxF3qeK6/QgMGiKGzjWQA
         j4T1we5K/EvQPBFXcneJlGqvEfxLbIjWMWc5k/pZ3un2cpEWtHirStO+ULUxdojvgC0T
         xnXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmcRucw0hUgsfjq7eV/LhPZMoJlYEcPgHYlURqi8BFxJZujnQbu67GsDvnV8NWMfIm+wM=@vger.kernel.org
X-Gm-Message-State: AFuF++keu8pd53BptL0WEm9BEF2b4UaC0BHfZ1/qS8F0oubUu42aKy7w
	BFIYonJolms8BgXpGgNphww2VgVPnYVwOis9QBjCxghjYId31ovsvFt8vn519RYkOnCKOc/mT68
	83JgEi1S5uAVdxirg5JOXxiSzZtaFpPwNTygB4g2ZL2k2QkhPcN6cnQ==
X-Gm-Gg: AYBFou1PX3YXFUK83HiACa+bi08a2in1R703GQWBp8q1SK9CUWMlzEH+uHYl4wuh8yL
	ib7san4qGKaZ85uQU7Iacx5irm9J/bpjDElkesUvnFCS2m2ynYQ5Sp+BkBCuqwkHkBXN8lC5k9h
	W1twOElb0E6mqfOjf0Ac9q4uSkFy0kJvOI1JsFGXjaruG4k+vADS1R95xquEvj556HXGsV1pxOo
	xsA67ZSe3yJ1ziX+8e4NAIDYxep42zJqAvjP6OQFqSHifCrsSu/dFuY0yENxLj7wQlP3FHCO0wY
	Z0HLo0cIjzqdrJWm9LO59y4JY82NHJZFReFlnbPPPtAHRJ55TrnNSD3CPk5NH3zFzF2aQDO8Y4p
	WP9IKB3ruHB+LrFf1eqVwgyhMq1ZUSrZ0CcQ5pc3i9w==
X-Received: by 2002:a05:6a00:13a1:b0:888:add:a07d with SMTP id d2e1a72fcca58-88af4b4844bmr1532484b3a.29.1790914576007;
        Thu, 01 Oct 2026 21:16:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a1:b0:888:add:a07d with SMTP id d2e1a72fcca58-88af4b4844bmr1532459b3a.29.1790914575507;
        Thu, 01 Oct 2026 21:16:15 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c1b1df0sm406453b3a.27.2026.10.01.21.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 21:16:14 -0700 (PDT)
Message-ID: <5fa30b18-7894-4024-9a87-8cb047979f2a@redhat.com>
Date: Fri, 2 Oct 2026 14:16:09 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/24] hw/arm/virt: Embed Realm VM type with IPA address
 space
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-17-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-17-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:36 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Set the Ream VM bit in the IPA address space size when needed.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 37211bc81926..61751aa31e0d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -97,6 +97,8 @@
>   #include "qemu/guest-random.h"
>   #include "hw/watchdog/sbsa_gwdt.h"
>   
> +#include <linux/kvm.h>
> +
>   static GlobalProperty arm_virt_compat_defaults[] = {
>       { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>   };
> @@ -4053,9 +4055,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>       int max_vm_pa_size, requested_pa_size;
>       bool fixed_ipa;
> +    int vm_type;
>   

Lets initialize @vm_type when it's declared:

        VirtMachineState *vms = VIRT_MACHINE(ms)
        int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
        int max_vm_pa_size, requested_pa_size;
        bool fixed_ipa;

>       max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
>   
> +    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
> +
>       /* we freeze the memory map to compute the highest gpa */
>       virt_set_memmap(vms, max_vm_pa_size);
>   
> @@ -4080,7 +4085,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>        * the implicit legacy 40b IPA setting, in which case the kvm_type
>        * must be 0.
>        */
> -    return fixed_ipa ? 0 : requested_pa_size;
> +    if (fixed_ipa) {
> +        return 0;
> +    }
> +
> +    return requested_pa_size | vm_type;
>   }
>   
>   static int virt_get_physical_address_range(MachineState *ms,

Thanks,
Gavin

