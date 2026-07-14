Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFA35AC3E
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026619; cv=none; b=Z7UwclUerewzdL7DRfSx8/8SIaFCNUUITLNjaNsp4dFR10P14hL1LUM+IfoWfOY+xFLhzkwNPUh27RgBsZ0sFkaXH8rxw128l3EAp4Y63+uGxIrW5WAj58WRqGcXcEu9xEZtXj973HqpcPqB672FwizgdZNn5gsB5WJxUwqbSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026619; c=relaxed/simple;
	bh=ObacvuGb6BVryBHOjbt+VUwNdqdBSBQFPhP2cpHEltM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D16wjYyGHY/BK/+arsTrTUcZUyREwULsJ32MuzwvsgQx05gIURRAPEH39NTIoRX3bK5wkUJhpOIzt6TNUmqhtTTeMbMO7Vg/Sif+RMrhM1ArnqDMB8wxTbxCtIaNli+smRB1Y6bwNS44q8XaxBBBwaOnzriJgnjPF0uaiqj1YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu+YGLcH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kUxtjiNj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu+YGLcH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kUxtjiNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784026616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
	b=fu+YGLcHLq/aEJWYFdaaHc/Wc2E2qPBCo0XuD6Gi+fISC9M0g/Q1zflcsVLcePRGCCjVpT
	47rTTaf6DufvP/yQk+DxIDQHcNLHBq7KaAdz+VeKVY5aBZW1R9gH+aV6RB/mdLokhMDrBU
	WRDLJAXdKjgnVWF654BogPKecHlRiM0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-4lPvuYHuMiSTvTMB6fupvg-1; Tue, 14 Jul 2026 06:56:55 -0400
X-MC-Unique: 4lPvuYHuMiSTvTMB6fupvg-1
X-Mimecast-MFC-AGG-ID: 4lPvuYHuMiSTvTMB6fupvg_1784026614
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce406883eso8012845ad.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784026614; x=1784631414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
        b=kUxtjiNjS8dfRDVyzGjxBu6Ni1jeJngjSuPiIoPRrov7UWRn2w+RPPg5/ZmnYoBk/E
         93SISOtiv/dWEcBFwWAi8zo8Cx5mO1xYiryEgTV9EtPINOOHtwswAOhntMXs+rHi+YJS
         Rn/fP+ks33OOG/G+gdyELnkxCYdF6uDWR1Fniz1jNLMZ0PvwRC67+Ug4Q5ohAyrcsCQ9
         KjAmAU6l9W+QUoThLqUoSfZtM26DTvi48B0y5nmKUcUEbGw8+t5SllEknQfPSs5iOJ+S
         bqrurwhxwWU3AKplc018Bc8AeYcW9p2VC/aKFJ5fY8ZYo0dvFgGXppHUoJz3hvQ1ZuDN
         tHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784026614; x=1784631414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGmtfTaKNjnVMCFoWirR8Pe5xgMzaRCEBNCSNOefk+U=;
        b=WmNyRwW+8N6KjQQ03v9pgRF25yVWIe+YXZJSVfiBkVxLs9HC0Qxmgwaa5a5H7Q5F4P
         698isxPCsx09H+/cLPge6wWKGUZWnPKJstnKzSLhwHBWlnwuF0SOe3aViGRhnEuLpa1r
         0q6o/Euzs2DSAjbelX4WrszqXdcdeQYTLWv/dPDBfN+/0rwLk5O3abtJKjvEILj5fX7K
         s1oE2xf+KSRy49O0qGRhYFZTLU1CtVakIyueXKUOMyWiS1dv3OC6ng62rcYS6ElE6sLt
         g5y+JOuO/mCcjHbTgcSlH7hxwgyPJWKwIvBA8Od3IacxmdHWfLZs5EEl7uMzdPQ3PE7f
         HeGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2B4ClvE/VbKgtUkhI85nthsLFKdrIeQgxEqQkbiWgfONQpirVnbwgEqLuGODZjEiUIl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ws0pIVyr15yec5GmRY/8dXueG+fAdeHvD4QYbucXL8xyHgPG
	T80RwhnLsj75echqUOreYbKyosGOdXOmsmifjd0kgmsSb/5mx9CU50Ty0Wnt4+7VtO1NvWL34uE
	tpl/MqvrD9A42qru3ie0EMGE5jB8I6lPfbE7Ai5D5t5uHjp51VRB4NQ==
X-Gm-Gg: AfdE7cnR4Gl0n2Dc8Bj2E/XDtcZIeCrgrzNyaroHGdKufmD68A3dhdghJi+pfHOxN6J
	MAdrUOGbqBCpQYR+8NA1iTzWschYJtZCvR0QqJlRaL0z/GLxgfNnNM7+JyAmKTQyN2vrAmOrSOr
	lDbK4tg9cJHVYXvBJ/9AMTn6yfnPwiQkM7pJtKnQCr81+dvsjPC+6IHU9GzP8CEenrGYygDBJ+l
	MTPrNSVCRLkRoMQqRyfOm0+n3VVL5XQP9JwuS/NnznfzR+CaFh1yLQtaQ5j304Zv49rADAdDJpM
	J8kTx4UEsi46PBF5cnvjYyjNmPhSoe132I9hnFOUgyVRos7w2OPoGoUm8IW7NLLSDqiE6dkrgat
	oZZKXX6wV793a6OvKF2u4pgQpKWM8Q8e1du7OxT0Nc7nPNn0zxrjozA==
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id d9443c01a7336-2ce9f3d32f3mr117741805ad.41.1784026614237;
        Tue, 14 Jul 2026 03:56:54 -0700 (PDT)
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id d9443c01a7336-2ce9f3d32f3mr117741485ad.41.1784026613721;
        Tue, 14 Jul 2026 03:56:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm115846435ad.15.2026.07.14.03.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 03:56:52 -0700 (PDT)
Message-ID: <1bd09a58-a207-46ba-a470-f67cc8509f07@redhat.com>
Date: Tue, 14 Jul 2026 20:56:44 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 12/25] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-13-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-13-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Once the Realm descriptor has been created, tell KVM to transfer runtime
> images (kernel, DT, and rootfs) from guest memory to Realm memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 97ec7c8934c9..58669f4a50f1 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -44,12 +44,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>   
>   static RmeGuest *rme_guest;
>   
> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> +                              Error **errp)
> +{
> +    int ret;
> +    void *host_ua;
> +    hwaddr size = region->size;
> +    hwaddr base = region->base;
> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> +    struct kvm_arm_rmi_populate populate_args;
> +
> +    host_ua = address_space_map(region->as, base, &size, false,
> +                                MEMTXATTRS_UNSPECIFIED);
> +
> +    populate_args = (struct kvm_arm_rmi_populate) {
> +        .base = start,
> +        .size = end - start,
> +        .source_uaddr = (uintptr_t)host_ua,
> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> +    };
> +
> +    while (populate_args.size > 0) {
> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> +                start, end);
> +            break;
> +        }
> +    }
> +
> +    address_space_unmap(region->as, host_ua, size, false, 0);
> +
> +    return ret;
> +}
> +

Nit: The argument @measure isn't needed as it's always true, passed
by its only caller rme_populate_range(). I guess it's leftover for
the earlier host series.


> +static void rme_populate_ram_region(gpointer data, gpointer err)
> +{
> +    Error **errp = err;
> +    const RmeRamRegion *region = data;
> +
> +    if (*errp) {
> +        return;
> +    }
> +
> +    rme_populate_range(region, /* measure */ true, errp);
> +}
> +
>   static void rme_vm_state_change(void *opaque, bool running, RunState state)
>   {
> +    Error *errp = NULL;
> +
>       if (!running) {
>           return;
>       }
>   
> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> +    if (errp) {
> +        return;
> +    }
> +
>       kvm_mark_guest_state_protected();
>   }
>   

Thanks,
Gavin

