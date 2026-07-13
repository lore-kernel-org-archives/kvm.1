Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCC35FF5B
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919660; cv=none; b=IjidNwYprxEnCffeRobTveWGbKMpR4wnqkKpaJD5oYhxfmkZJ6R+CO/M/VF/fXJEz1vXVlgOgPLa4IzVsn5X6VZFOV4egdQl02999R0h8mPj1g365fIWFVW5PGYQ0GqVoBJ9setdJfGgJHQASzmWXZR3s22wOX6Gwvizfl7QP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919660; c=relaxed/simple;
	bh=LeOG7yPNBRfkrdLxuU5wPH463seAq2elIdG4jjsZ4t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ostTxEsF7dLSA8TphUo7XheWi65cYHMs5GpJaRB4j//anMb96zM1KxUEH/5OlwaQ3satGviL4ZTKd7dr640f0HwjWnzq7tJZXNjkxG+iBGHK55Kbbt/IpLgzr6cq/44hHum+l+UDOdmreqg1VkEmiWIyP0qK8VXHusUE2Okmwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOZqtyxM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M47G1Bj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOZqtyxM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M47G1Bj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783919657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
	b=SOZqtyxMyyqbyC546TvoIIny3UcSZf4tmNLdDNsIm6H67dR3lwsUI8pHHCoWubNH23Uzix
	DKH2r8rUBkReIpKrgDq42JZduKcXK/q2ljG98hsCqJMa5p5U/OyZtcUQRQvGZlIEjNarHZ
	qaIRj7aprBUyej6a4AgVbKQRQ24vekY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-T1vW04E9OOa2OPDMV5mgjA-1; Mon, 13 Jul 2026 01:14:16 -0400
X-MC-Unique: T1vW04E9OOa2OPDMV5mgjA-1
X-Mimecast-MFC-AGG-ID: T1vW04E9OOa2OPDMV5mgjA_1783919655
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso37377855ad.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783919655; x=1784524455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
        b=M47G1Bj03OYpeQoLIAyJYNwsz1M1AVEE60h5dhK4ozDsmdXHIoAH5+pWcEjvn/nT65
         o8ixUZZouit1Jvze9sXOCbdet9lULB/N6Uinofd7vb3nqGhOSUCkyMgh5WKb0ubsToTt
         8zzWqQ38xPp42cOTL9qGVr28Eznru1R2XQS6C5AS6qhL/V4dF4ob6tfc94OvaLS0mjD4
         +gVA8Ulp5prJMH921c0YcoilCnMF1NT8Bbb5p0UL/Ot9DmVaewlKScgTkHm1RkFwZE6d
         CrmDx/H6mmIRIrH3Fw70cmh5put80p9vZpwk9eJs3rnCpRhpR+8t7mW5gB8WBhcq8thl
         xIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783919655; x=1784524455;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
        b=mQi2MKeN/zsNiE03hvyhliWMVdwxbJ+d3lHtwzKIcO1hm4cHb/hQbhsZLYEwWvQaJw
         ctsmcC1SsYUIlb5jmbp8gxnWSPdBPqAWmEGgZr6uC48Nj9Hpq9F+nlfMmQ6xoabfVHUg
         XcS9paWd7u5KiNJJ0lE26oEbWNzODw4ELWr4RSirkcT/LvYgQ8yybz5C5vmuB1naIuk6
         x0h0BVBUV0qR8TONYJ9nKQWj3SxOYA+BRV1gX8/J7Cm2yYA0Jvi0CxzzJkpldsWWxFNC
         3+qpA56JTBfXvNxkwBNFTPOpqEJdZDxcAxbii/BCelQAwvov+IfpVq0mXbrTODfPLMv1
         mxdg==
X-Forwarded-Encrypted: i=1; AHgh+RodPiL3g1c5IQmBWHE5WQ1Yi33OnaM62aavWwKafMF043qOWU2RIoCAKrMJKaW4rL1zrgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhVR9lgl1MovBUxxln+2z75x/AE+9A5k/v2xXIQbAsoeUnKIM
	aNQFWPw6MLO4UOvIAwRcxZaDG4P/K4gZ20D7aCateYuMn5Nm9N1/eQa8KdEmDaomApuFd/YytR9
	W2NXMXAmPvz1OnDQlJqxmjamcdvEuKzIN+BqtrO2Ks3RcfrirW9Hv+g==
X-Gm-Gg: AfdE7cmBVthXvRkeY8OJ9DoJbtW8hbW3p6enCNK23rEJhVIGmANc+aYSYZEadDZ66g0
	uZ5bF6pmz/CfzKAUWPviUQFWRoBsn6ICPP3R9Qix+iuna2WH15NFhLbslFIYUxymDBSLHbSeWjd
	1KtPj+KdGk4t6dOz58JGbaCcZwXuY5FbgdDS3RFFNO2UdP+2kKoFpDJgdaRT/RVNhpcp7go7GW6
	kTlSUn8uMvTwP2uPzrsubesNKmuI0jMwvZqUKpH2UqPvmSPAhlXiU+FlrrWeadppYbkHuGai0Hl
	hJp697xVDNmc7zz6fRXHYGtyafHo56Y1c9nK7eASPxiBtphyTN6cMMP4znl6gnzCYuV0wIi5yfL
	Glg0MZT0veigj6LUd82FqQxAkkAqMRUTn+wMaL8RkoSRfurf4NuvQHA==
X-Received: by 2002:a17:903:2a88:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2ce9e9b9691mr77163575ad.12.1783919654717;
        Sun, 12 Jul 2026 22:14:14 -0700 (PDT)
X-Received: by 2002:a17:903:2a88:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2ce9e9b9691mr77163245ad.12.1783919654157;
        Sun, 12 Jul 2026 22:14:14 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm93166495ad.0.2026.07.12.22.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 22:14:13 -0700 (PDT)
Message-ID: <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>
Date: Mon, 13 Jul 2026 15:14:05 +1000
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

I think it's more reasonable to set ConfidentialGuestSupportClass::kvm_init to
kvm_arm_rme_init in rme_guest_class_init(). confidential_guest_kvm_init()
gets called in target/arm/kvm.c::kvm_arch_init(). With this, the pattern matches
with that for x86.

More details can be found from commit 631a2ac5a4be ("i386/tdx: Implement tdx_kvm_init()
to initialize TDX VM context").

Thanks,
Gavin

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

