Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0732B121
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640666; cv=none; b=DAfaBnXug/B8z3ZQlDD4QZR26TLvJBrLD8SuC1hzbHHWWSWwdPa2JJt9R4lhtc404OaYOtDChbh2ATFBu3ZoMOT460d7nB3HYplHI2E28TS15XQMJHqxrlOhd7W52aZ2c+ToUL8xs6+1u4lLM3B9C0NjjqX9sB6iMvBa+6G4P04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640666; c=relaxed/simple;
	bh=Ki4bSDHElFRn0aod5PsG3pg00/l504Bqjy1URpDQ0xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvPdkYNxGW/D0Ct1nRF+AnM1yKc3nzoS8L1KAd/PGM8EukIC80Ie7bLQsbew8maQOPddTj20kjR6dvLHby4cpv2zhfXEJaEQtqF4+NswrJ/ucrEmLDEHbO5RM2SQ+uC957kRCtqbGrBjJ/40Xf5QNreC5Awflcj5OWlaTDn/Geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHOysPoS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oepjnJ7k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHOysPoS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oepjnJ7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783640664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
	b=IHOysPoSJxUODgm/SsHhq2PR4HPNC6GaxyRwfkTDEgzKrpLlBd69BiBuczRGTFIUOOiIva
	QaXChgTDfTy7PhorvknVRLCnXQ2SJpdiShKUWSzNSIOC9tlagGEW3E0wbSTjUP8uDZ/Xfw
	Xegckww+Y7T1B2P0Liz0HHVy2DvuA90=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-pDiMua3XP-eD-VHZRTU7PA-1; Thu, 09 Jul 2026 19:44:20 -0400
X-MC-Unique: pDiMua3XP-eD-VHZRTU7PA-1
X-Mimecast-MFC-AGG-ID: pDiMua3XP-eD-VHZRTU7PA_1783640660
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so284320a12.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783640660; x=1784245460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
        b=oepjnJ7kT8KHoHERCgOqPLVIAjNgPJ6PmyUnTA2HU8IywR84BEBYmDUPjQqQtLBqqV
         Esd3ZFbNyBIYTzS6Qk0Y3v5o4m+noW7FSauXC9tnD5f7mmYFFqu3QyHrzSpv5GVC9Ocm
         Ii7G3Uku9Vpj7a5Tr9IfeOF6rhZJWtsJYftZ05SzihKyycs6QZ/IADAJjc89ljpQKs3L
         GCH1EEXK0TuapzlDP7eOCBp+8jnBeaxiTyXCnVywppxIc/3TjEQ0BYaZsB0hYSyR+Xzr
         fOLF3GqX2EMjn240WjJYUzEm5Tl4ZQsX1YOkBAXMPlv1VC/EFF4eA5t7O7I7hbW61PMy
         b+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783640660; x=1784245460;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
        b=ST57em3FX569+aPXHsXucXBQijyJgbr6XG1RkBQEldC1OqXD8TrQdmEnXYeg9maveq
         OgjxSoSG9ig7tO6qlPL2BbX+fCES401RbXuQzJ4Ds1N97gx9Tw+PHDnWi8tcDwdXMRcz
         Hz2HbjtLHoVs29eohegNSe7595UToYsRlZitTlkBTR+71QXbbQgSTZVSmxa7CJi8FRIH
         uvN+BpwCIFu1cyl3MY7wSWElc3qn0qym1WX1CWCJoSSkyl+KEiZNgn+XYUFat2Kb0n/Z
         imClCDQqohednEA7Au1LU+VIPzaDL/pZwyjRe66nNPrVoxFvQA9PKwTTrbcFJ1xbCyk9
         L0uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRANJAUSEcT4Rr0yGYq71DCPP7VrfPehfIpsldFkyv10eTiwUaEz0jJEd/3lA77oMco8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+znmJGyipUGZ0IHLj1Oz8JKpQ9nF9jgKn2qHocozSx/LifOmr
	mIwefSSD3xI7uPydpyImldxqNMlfyU/EF0Cok5srz8OCrxfeZtcJ/HuYkuTrBJkkClDnM/9ij6F
	c4lBX+1OlurnGAZbk8XDnWnlSC/6OBRi+GNItmUcU7x5ovGPhg9aKjA==
X-Gm-Gg: AfdE7cmOeECHKP+Of6/9nMbo+O4w2i30M6b+C34gyedM1P9V6c16KA8YfskOxi5PqTE
	GILm1ldNfCxq3wfVeHzqD9Me4Ehxq1hZ87astwcbKgdKjEfI4Q5JTzKb4o5lttT+NCu/6axiAxT
	85SFy5XD3O+hsgbRMEB2TZ33mRcOFPe8K0KFTlYqT+HxXvG5OSW7qbkeRHbq47VOfXtjwmiw9LA
	nTVxsBxdlNmQN1Bdv6F4slxuTuoTW00FbdX4qsrpYT+aSpUm8JOEIgPPPYNfgKfgBMtDj9qrc2a
	DCSQWss4+eiaxKX5i/AzvIepABSSZd921y0NTd1dzMiSaCgO5vmjf7d5IGDcaojdJ4TeWuaeKVP
	ZL4UNbfOe2lFe01/Qf5Xus2xaVGRkefRcaizsTgP55wZT7zsKwro22g==
X-Received: by 2002:a05:6a21:4c13:b0:3bf:5539:f8f with SMTP id adf61e73a8af0-3c0bd0fa84emr11241157637.37.1783640659791;
        Thu, 09 Jul 2026 16:44:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c13:b0:3bf:5539:f8f with SMTP id adf61e73a8af0-3c0bd0fa84emr11241136637.37.1783640659263;
        Thu, 09 Jul 2026 16:44:19 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm35146664c88.9.2026.07.09.16.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 16:44:18 -0700 (PDT)
Message-ID: <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>
Date: Fri, 10 Jul 2026 09:44:11 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial
 Address space
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-10-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Initialise the Realm's initial physical address space based on
> the VM's configuration.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/boot.c         |  4 ++++
>   target/arm/kvm-rme.c  | 18 ++++++++++++++++++
>   target/arm/kvm-stub.c |  4 ++++
>   target/arm/kvm_arm.h  | 10 ++++++++++
>   4 files changed, 36 insertions(+)
> 

Thanks for the posting.

If RmeGuest::init_ram isn't needed in the future, this patch can be dropped.
There is no API exposed from (v14) host series to initialize RIPAS for the
specified IPA range, as we did in the earlier revisions. So this patch was
added for the earlier host serieses, not for (v14) host series any more?

Thanks,
Gavin

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9b7553dde5e1..bcab21d349b4 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -32,6 +32,7 @@
>   #include "qemu/option.h"
>   #include "qemu/units.h"
>   #include "qemu/bswap.h"
> +#include "kvm_arm.h"
>   
>   /* Kernel boot protocol is specified in the kernel docs
>    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> @@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
>       /* We assume the CPU passed as argument is the primary CPU.  */
>       info->primary_cpu = cpu;
>   
> +    /* Mark all Realm memory as RAM */
> +    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
> +
>       /* Load the kernel.  */
>       if (!info->kernel_filename || info->firmware_loaded) {
>           arm_setup_firmware_boot(cpu, info);
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index f763d5ed6199..697e7d507f0d 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -22,8 +22,16 @@
>   #define TYPE_RME_GUEST "rme-guest"
>   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +} RmeRamRegion;
> +
>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
> +    RmeRamRegion init_ram;
>   };
>   
>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> @@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
>       return 0;
>   }
>   
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +    if (!rme_guest) {
> +        return;
> +    }
> +
> +    rme_guest->init_ram.base = base;
> +    rme_guest->init_ram.size = size;
> +}
> +
>   void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   {
>       if (!rme_guest) {
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 6d52f172c5df..790e1940fd8a 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
>       return false;
>   }
>   
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 65ec1b970606..c7dc45595159 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
>    */
>   int kvm_arm_rme_vm_type(void);
>   
> +/*
> + * kvm_arm_rme_init_guest_ram
> + * @base: base address of RAM
> + * @size: size of RAM
> + *
> + * If the user requested a Realm, set the base and size of guest RAM, in order
> + * to initialize the Realm IPA space.
> + */
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
> +
>   #endif

