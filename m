Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D9EACD
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920874; cv=none; b=qkTXlfCDUrOK78hTJf8PSbVPqF5YA//0QPM0rN1oEvCWLTVNgNgp8Tdy02yeNu5eaH3+DlFY5ia7HWVWaxy25ElHEMEaJdswJ53lv+tAQsDwf50HgrZZJPKsnVzFdH8ATTWtMOSn2X2kFKiV2+SBMAUd18jy0m4KSS3Qe2sF4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920874; c=relaxed/simple;
	bh=JZHFCLOfahPIutk6bsYrkK0LkMAxgRjCHdkaEvufP80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCRMs1CER1C8hlXofBgdswzJ7kDgVtRABxSJqiQ6CmT5HPbN2oTuxoULw4EAu6+PwWcRfBYq60EYsFMHLi9o8nIvVHTd8DUsViwMOauRXAG5CNBU3leElVMha6KQiGZuYCkBmPe6eyTzKuq6a1encb+2OVLsDCq4m1JJaADdVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw4+YTSu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/i8zEsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw4+YTSu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/i8zEsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783920871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
	b=Bw4+YTSuqpxUBjcScVu7+aw8wvSQwIRQ8PfHUjrplNfVlxNEhwFMRLkE8n0jQ8Rj3Bxn51
	Beq1AkAeDPtPzHVZwvZ54qdXbXQB0jMhX35bWLWqKrIJrCEVrtTain7F9ZbBtlNGks863+
	f/kTKeVe/y5JBFrKZ/dyc1Y++Jy9M4s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Leq-YeL8MwSBS0y97yzWIw-1; Mon, 13 Jul 2026 01:34:30 -0400
X-MC-Unique: Leq-YeL8MwSBS0y97yzWIw-1
X-Mimecast-MFC-AGG-ID: Leq-YeL8MwSBS0y97yzWIw_1783920869
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso40360205ad.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783920869; x=1784525669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
        b=F/i8zEsg+W1xqf/Phh7MyH2S4trI/A9O/oRQjwQIG/bJPYdigKqhO1cxXlCw5A6KhT
         7mFP98TXCo1gJuS4ye0Toc8L3craWf2blgqnOaTBEGmbOJNw7ZgLis33EmAogAPOH6Zw
         Ci+uMW7PdGhfdU43Vcl1f8Xr2ElrKpKTNoeTDwbznr2SAoywKGtMcSy68w5+7dVU6n5y
         s4Y/+JI8mK5V7n5Y4ydiAnq++BzrC+s92f4FJQX30oNprMcQbGAUfiZ6AHEDetTxWMrD
         ZS61xNeO1NE8lMd13G6BfolSEIdshrPEUwj7NDhmojfr1Ug3ybSdgOJe9fgeQpyB2zpx
         iQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920869; x=1784525669;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
        b=q6xlm/KgxmaJWlN4E5CKAi/JkaNxcnaPhqAOLZsV554bDSXdvOXCjse+JpzeeIyJYs
         B7YLDIGkVTItSvq5P6sjVNk2KbZI3o6Sxg2JrEjtcU/Q6QoRQcNJTdy+H1cc4t9ziptm
         jrYUxsxPRx6T/cKsza1mdAiha/qFadcepSsdfWkImc9Q0YDGrm6a2jGRmj1/L2ffef5H
         BkaGU4Ho1k4ywLd7wY5wSmX3T0G5y7fCAmO4uGgDykDYP2B4rdg5a9V4Q1h5xkuVLPEa
         zs70DF4/cshMjAfaX49x/t5XJq8KPhOuB7KG7SkrQn+DUe3o6DpAqs2MQS7gb4fcvU/X
         8iRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnM/7m/t9U4I/OUJ6L82JDE9NnSBwowSVvVphrW0qznR0QmCIm9t7D9eFSAbxSO8fBMAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+H5eknioDo6hz+ekD97ANoKFMLWah3XVuEBNoRK0KfIIHvVUh
	EhEcwUqZXI3bVw4LFaFlDfDMActHedCZq7fbVmayPD22GnjPDRlsr+6tmFdHtHj16AnxmEIXbX8
	Vir5LG7VfmovYWaTD16MN9xeiTex+avSVLGxO0pG4YNHIM6qzNbOO5A==
X-Gm-Gg: AfdE7cmJKqtOPXbMpRkAZr2mvcL+Er0CAZTd2CH0j1a1ds0FTj/nbZrEVqqbcA9rcGV
	FMab/fSm5ryFGnUOJ/TjMAHVwY4nocdBzupoNdxyLwCM4+k9G1WI0jA+PbX9PgGlYlnZse+qTDn
	eaKms3Ot+StgUc8+I/83D3jp1G03FXotFO8B+Z2hVYfj4XQdqcsxSqEM/vLi/QzwZp2TzdiVMPq
	AwKghGWwYOZzI2RGLoqX+a4IuSzMy3abxOZYxPXHEGJO8UMTSaI9wRnJgtHPYJKs7FbY7wi/uWM
	NaapUDKZqom8r3zAvu1bkcj+73ZmdrxuQhzOfC/XZOPbyTpYGsmWR7k2x1c/z7BOrdKzkO/RkBx
	yITtLxvymvZUtbY1s7LRBqG5IfSOBU2o3qHpSN6tKJcaZJTTURchYZg==
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ce9f27e6f1mr80488225ad.38.1783920868998;
        Sun, 12 Jul 2026 22:34:28 -0700 (PDT)
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ce9f27e6f1mr80487835ad.38.1783920868533;
        Sun, 12 Jul 2026 22:34:28 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb746sm91888925ad.7.2026.07.12.22.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 22:34:27 -0700 (PDT)
Message-ID: <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>
Date: Mon, 13 Jul 2026 15:34:20 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize
 realms
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Initialise an @rme_guest object and install a handler to get notified
> when the Realm is ready to start.  That way we can finish reading the
> Realm once we know everything is in place.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm-stub.c |  5 +++++
>   target/arm/kvm.c      |  7 +++++-
>   target/arm/kvm_arm.h  |  9 ++++++++
>   4 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 42e1d1e7b859..b86b9d6a25cb 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -13,6 +13,7 @@
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "qom/object_interfaces.h"
>   #include "system/confidential-guest-support.h"
>   #include "system/kvm.h"
> @@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>                                             CONFIDENTIAL_GUEST_SUPPORT,
>                                             { TYPE_USER_CREATABLE }, { })
>   
> +static RmeGuest *rme_guest;
> +
> +static void rme_vm_state_change(void *opaque, bool running, RunState state)
> +{
> +    if (!running) {
> +        return;
> +    }
> +
> +    kvm_mark_guest_state_protected();

This would be called in kvm_arm_rme_init(), why we can't call this to mark the
KVM state as protected in kvm_arm_rme_init() ?

> +}
> +
>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
>   }
>   
>   static void rme_guest_init(Object *obj)
>   {
> +    if (rme_guest) {
> +        error_report("a single instance of RmeGuest is supported");
> +        exit(1);
> +    }
> +    rme_guest = RME_GUEST(obj);
>   }
>   
>   static void rme_guest_finalize(Object *obj)
>   {
>   }
> +
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> +{
> +    static Error *rme_mig_blocker;
> +    ConfidentialGuestSupport *cgs = ms->cgs;
> +
> +    if (!rme_guest) {
> +        return 0;
> +    }
> +
> +    if (!cgs) {
> +        error_report("missing -machine confidential-guest-support parameter");
> +        return -EINVAL;
> +    }
> +
> +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> +        error_report("KVM doesn't support Realms");
> +        return -ENODEV;
> +    }
> +
> +    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> +    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> +
> +    /*
> +     * The realm activation is done last, when the VM starts, after all images
> +     * have been loaded and all vcpus finalized.
> +     */
> +    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
> +
> +    cgs->require_guest_memfd = true;
> +    cgs->ready = true;
> +    return 0;
> +}
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 88cbe8d85c41..eec1ca3dd2e5 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
>   {
>       g_assert_not_reached();
>   }
> +
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ed99be7fd80c..28d5643d6779 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> -    return 0;
> +    ret = kvm_arm_rme_init(ms, s);
> +    if (ret) {
> +        error_report("Failed to enable RME: %s", strerror(-ret));
> +    }
> +
> +    return ret;
>   }
>   
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e7c40fb003e4..6d058b0e08a2 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>    */
>   char *kvm_print_register_name(uint64_t regidx);
>   
> +/**
> + * kvm_arm_rme_init
> + * @ms: the machine state
> + * @s: State of KVM
> + *
> + * Prepare the machine to be a Realm, if the user enabled it.
> + */
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> +
>   #endif

Thanks,
Gavin

