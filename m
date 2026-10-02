Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530531F986
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914763; cv=none; b=YN4BrDnONLNE75oK6KQ5GhXaJu3x3LHc5iyJQPnZ2C9LycqoUTo4Omqifr8quXzhMquv6nI/w0HLCldcNM6PKBWQHXuvRGhnGL929uQ3jkrQ/wRG00+Ia3mimkLdv/FEjyqjYpI+2ZNUx9AaZsMUqCba6mJXBoWaHMzw4KRbuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914763; c=relaxed/simple;
	bh=qWQI5mIEnHjt267oPCiqZMKOqMKVcpDcx0eoR5Ve/Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCAtGabn3KO7Baek6967vyMdB5GkF8uB1fFw01wWr1FZJ6Bi4J5HYlMLeruP5ab+x7QZ4G4e5DOfXjRatVNDzBgs7/FnUTEIyqMErbOUYZF25zFQ2QJ/j99BQkXeHueUp4vVXu0uCX9ckqhAOPIQx/ZNfPXLrht1Q5hYmylETd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOvAUPZC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m2983FT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOvAUPZC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m2983FT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790914760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
	b=UOvAUPZCFhyr+dnD/jxYM/2R+KvMU/BClFdVyRZZRt+DV5l3PFDV3C19znPAv3D3ydAbBP
	rxrl4K9hR4gxfB6eqxNVjsifnFLKk/SDCrl74yMD2CPxryGZdq++q+KXe5BVIC8kTBjhcW
	FWFjKGJvYG3eJ2lLFDzDHM47XfadbiI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-k-JrpbVROlGaqVrq29dIsQ-1; Fri, 02 Oct 2026 00:19:19 -0400
X-MC-Unique: k-JrpbVROlGaqVrq29dIsQ-1
X-Mimecast-MFC-AGG-ID: k-JrpbVROlGaqVrq29dIsQ_1790914758
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so7648407a91.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790914758; x=1791519558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
        b=m2983FT5QGXOqiJklajkxmjRY1K8Nf5Rq95boLvhZqFcjVDPSNugEQuv66FVBRGa5D
         sf3xjX6R/cMsWtkfQKyrBeBU1D6f5WG0gXoMp1UhLA6Mo+CY0AdVAafB0MxZjiKhPwMK
         43bjaYQJt8cXEABu7TA/gHW7rjSlxJzZGzNKDYtT3+F/ksRDMiRoTXFCPUFdzqSN+rqM
         VglgYGD3cJe6cJhJmsxYR6rUIMWEBIYwldNudSkquB1WdMfYGljWdFvxsN664QCOlFgW
         Hd/tRTkjY9raZ+XASrKrAfeLTBHvrzB+OWvpPebaRHybxxpyUupc7o/yAuKjEb17d/pQ
         kGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914758; x=1791519558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
        b=RVcABkn9nPQYmgoY/PR5li2jTgZiaxbPymV/uqkx4VEwMWc2jyuMDcMZmQ3F7t+7Jg
         z8rZS0fosco0S3S/2AQWmjI2RDBLj37gfd5BRgrOyGRaog3lAYS6QFOnCyYywcEwkg98
         VJVPe2WnYpLFlO5/XaPsb3VpqpjrGcn1KwFfEY1A1ujysY7CFdXP9hiqm1Pu2vnU91la
         EwmQIfXpIK3IKB8SA0Op614Ri1PUesNn8nN7Kjli0G7n29df+NOwvmgZMAT/Kg1cyQjB
         /iwFRI14RLZ2BxlsEuePueIMbzhOBJQcczSAzYmV7qAFPS9fHz6lnQS+uv4xDMalFoxE
         VHHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUic2B1gsBb2Qik0i5Y0k5ejISzHe3IH6JVgKKegOx3pSkCMZIccWRRMWoIO1f0FlOgfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuSH6RmTVLA/fdDGIy36e2eU8CmHfPhgP5Dd2n4EDatupdyOVT
	85XZLRNv/aR9t7Lb82DFVf3uTJzSfLJWENMhKgb6zhtlpM+oipd5eZdVPRBbxm9ig48wmV3mKZ/
	drE+5QMBfn9QcwV/6WVHAwd0JdCXPXVSvDvqEujcJbPO8ejy8XiNr2A==
X-Gm-Gg: AYBFou3zfRSCr76ZZ4siXBS/rMYbNXb7whXpqQtHeA4aNmTBklKDKX1pKgOpNXDTImI
	RdAIIVJYnUCw3/q+jjUbpvFiy748YR7h9WnAgP7v5SROclb4vHTE3vzR/IadsqbASTi6DOOoaPp
	EduGx94cRwj8Lc3W+VrsVmwGskZiifMSdiRAmNZkiJ5j8xZMRp5xxHNPlXohOw/mD/59oIN3Jaq
	r6nJSXYuO8WB9GhnzCsf4aAGH+8l+ZbpVsY2XkiSrX0ADYQxU24C6w5YydnrJfJGqBFaPhuF2iY
	he09/iFCNWmvkN+sQtx6c28xb9K2AHoSyAwW0pI/On3ILJrgamNt9b75S8bWAKIvL5AA84JpvrC
	WBYqabXO/BrThRn5UKH8/9TaTH0a+GvqyilThMZcqOw==
X-Received: by 2002:a17:90b:5805:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a6ceca1622mr773321a91.44.1790914757842;
        Thu, 01 Oct 2026 21:19:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5805:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a6ceca1622mr773296a91.44.1790914757356;
        Thu, 01 Oct 2026 21:19:17 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6c8421fe4sm2371429a91.12.2026.10.01.21.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 21:19:16 -0700 (PDT)
Message-ID: <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>
Date: Fri, 2 Oct 2026 14:19:11 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical
 address for RME
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-18-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-18-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:36 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When RME is enabled, the upper GPA bit is used to distinguish protected
> from unprotected addresses. Reserve it when setting up the guest memory
> map.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 61751aa31e0d..cf3a9320dc3a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>       int max_vm_pa_size, requested_pa_size;
> +    int rme_reserve_bit = 0;
>       bool fixed_ipa;
>       int vm_type;
>   
> -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> -
>       vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
>   
> +    if (vm_type) {
> +        /*
> +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> +         * Reserve the upper bit to ensure that highmem devices will fit.
> +         */
> +        rme_reserve_bit = 1;
> +    }

"if (vm_type)" are mapped to any VM types other than KVM_VM_TYPE_ARM_NORMAL, meaning
it can be PKVM in theory. So this would be:

        if (vm_type == KVM_VM_TYPE_ARM_REALM) {
            ...
        }

> +
> +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> +                     rme_reserve_bit;
> +
>       /* we freeze the memory map to compute the highest gpa */
>       virt_set_memmap(vms, max_vm_pa_size);
>   
> -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
>   
>       /*
>        * KVM requires the IPA size to be at least 32 bits.
> @@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>           requested_pa_size = 32;
>       }
>   
> -    if (requested_pa_size > max_vm_pa_size) {
> +    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
>           error_report("-m and ,maxmem option values "
>                        "require an IPA range (%d bits) larger than "
>                        "the one supported by the host (%d bits)",
> -                     requested_pa_size, max_vm_pa_size);
> +                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
>           return -1;
>       }
>       /*

Thanks,
Gavin

