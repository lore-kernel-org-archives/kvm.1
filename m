Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0521A6822
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898157; cv=none; b=rI18jfb0ulsYw6UxeAmHwaykK2bIrI+00jSTemhId4uzZDLoWLlBshK2pix6fapZpvbiLAC+KG+UQdB035V5TfQVydUKxPCC+Ru39azT/qbWFz4VbKi3n49Z2gpj2KeJVGau/TXFni+FVeTwGOq/qxOQMKdm7rkBj4KaxS0nE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898157; c=relaxed/simple;
	bh=Mnj9eQTJq9AbYkMiVW7FLEPJnNChGUp7wHKL5gHsvx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoSqYfg341j/8ba2eTaqNNoXCBCGgZywO+R8aOUMLt1B2NZd3IyPb7fR80hj2p2ht5Bf7W35cH46UEMrDrVuiL5WjNVW6vQqoeN6NyxyDJZqaZVW1JozHs6mVr8VdEcjWhXaSg3oVWDJ8uQ1o/lmEuW8YiHuw7jDPQcf/eBfwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHsULws3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPPKWbJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHsULws3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPPKWbJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790898154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
	b=JHsULws3a327/0dvdabsfgKW6zi32GbaIqzjvl++L51NJLCXxbtdEu9L2aFcOxnATAtvYz
	UmJvBGCNP0DJuFLtz7TLvLII8SuZ1TN75icc1jAsZ4qjnMgxleZYDvfriESwjdKrljjlT6
	v1h950aa1F7wtYIBh4kq9INatZ2MSqI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-qlNqmVU8NDGA9xW0gy6qmA-1; Thu, 01 Oct 2026 19:42:33 -0400
X-MC-Unique: qlNqmVU8NDGA9xW0gy6qmA-1
X-Mimecast-MFC-AGG-ID: qlNqmVU8NDGA9xW0gy6qmA_1790898152
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so5140074a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790898152; x=1791502952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
        b=tPPKWbJU3rK8oNWTO3htvZaUuW2b2Es5lnDaCcNL2Ku318HJxUWp5uod1rQ5VjRZba
         K+RdviQTp61c+ciXbbpsWjfSjeg1hK4FIoO3KOiFqm+KP9IxcAF5svbLUPq18H4VURGC
         mcNlq3CGmbW+OslqjC0l26suxakR7apnak2+ftQrPETnZEeJY2yKkSEvLWL0vzzE4F0C
         AKpgXQb09SbKqILpSZUGHZCqkQeG9HJDYRwXwwlvpdfvZGNg5rVAXDF4x+3gpYt4O2Jq
         a2FaAtu5MfmQwbwWNfiezhV7NTPd/VjGGMuoSz8U0c/3yYpHy2qRFWlS6TflSEdkhhaC
         FPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898152; x=1791502952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
        b=C1W88x9KiXb8VBMj6IteKx5DPJNRITz3Bwwu6YJ+Z/BLA8Z29byFyzMmpWWEJ4MrEb
         Zv+jgjF97HzILWeYEcufufDd7KDVqfn/OB7l/hKbaPCM/axv3gVjVZ+7xXJq3fYqgyP6
         QktmII9CLTp90cip7h2kUpf+zdWPebfqdcN/6QBfMH50yJvMjvoVKWvJay/biwxbmBjt
         axRzXEeyh5upE3hHy5NYivi/dM54i8iGGMjTe8SOfgL3mfJw13OVIwMD8Cto+LhHHSa2
         gxKGaK8iCKdtA5z8Oj4xXdSMLsaN7GFIKKfy/SCL5turuFCS0xXVHcPpZJDHmjuUIUT9
         6WYg==
X-Forwarded-Encrypted: i=1; AKwUvBxSgmPjJ3rgb9aZ1R6yqAEfQvD21+AR6bj9dK0Frewyk4+ur8uBGS+SfK7wCzqvvAW14Cg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfW3mgwy3BDG67To5Ip9RPc/uIaesaibT5QmoeRmTn5QRvDA1f
	X0VLMU9PCrNOYI5vz4pw1lgVuNQ1a5K3N1wfScWYpeU2izJ+hLICRDC/A1XLytwvr7za7sSEEhc
	eNptBuFQ2N81Ekdu7j6LjDCR7Q8psPqWtNs25djTUNcQklXWrc6UYlw==
X-Gm-Gg: AYBFou1cHWPT0YZgKQ4AWoCeAoZWpKDd0FggVVUw6Lt4j924LP2FVT7PPAFZORWDlY6
	Hmi8j8h2aq7X7xpBWp8NbxsV/zEaKj4VvPWAmCitLqWWEd3Vm+iWDQjK4gwID9IBYxcyShJNWT4
	4qxfMO75DXtiPeuQafdKQ5XeCQaao6LbZL63YSwyFnAnDNWhsAj/s3uEAkZ03k+jrvzdMZoAheT
	VACzEtZBN6Jj2oAHC1V0FZC1eOKses+0SaRzdXHK9kpIyqYtGmaGCAWWV85uDB116aSc+C7npnZ
	mZnuO1RdKvCGG3wjm1FTPd2hPnp6B8p6IOD604bzfuNsbuQGhO2WrG0LDanX4p2gszeU/mK354o
	pZb0IHhjsUnhUQnk/8rg+rkvLO/VhVizrIZXIKZ3naA==
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id 98e67ed59e1d1-3a6ce9b0fe4mr918284a91.65.1790898152000;
        Thu, 01 Oct 2026 16:42:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id 98e67ed59e1d1-3a6ce9b0fe4mr918273a91.65.1790898151463;
        Thu, 01 Oct 2026 16:42:31 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4709a7csm6244308a91.8.2026.10.01.16.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 16:42:30 -0700 (PDT)
Message-ID: <5461472f-8ab2-4549-b04f-85f0030b4b79@redhat.com>
Date: Fri, 2 Oct 2026 09:42:23 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 04/24] target/arm/kvm-rme: Add mechanic to initialize
 realms
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-5-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> Initialise an @rme_guest object and install a handler to get notified
> when the Realm is ready to start.  That way we can finish reading the
> Realm once we know everything is in place.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm.c     | 15 +++++++++++--
>   2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 42e1d1e7b859..a4a5e195c196 100644
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
> @@ -29,12 +30,62 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
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
> +static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    KVMState *s = KVM_STATE(current_accel());
> +    static Error *rme_mig_blocker;
> +
> +    if (!rme_guest) {
> +        return 0;
> +    }
> +
> +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> +        error_setg(errp, "VM doesn't support Realms");
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
> +
>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
> +    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> +
> +    klass->kvm_init = kvm_arm_rme_init;
>   }
>   
>   static void rme_guest_init(Object *obj)
>   {
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +
> +    if (rme_guest) {
> +        error_report("a single instance of RmeGuest is supported");
> +        exit(1);
> +    }
> +    rme_guest = RME_GUEST(obj);
> +    cgs->allow_convert_in_place = true;
>   }
>   
>   static void rme_guest_finalize(Object *obj)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ed99be7fd80c..401a6f669cbb 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -33,6 +33,7 @@
>   #include "hw/pci/pci.h"
>   #include "exec/memattrs.h"
>   #include "system/address-spaces.h"
> +#include "system/confidential-guest-support.h"
>   #include "gdbstub/enums.h"
>   #include "hw/core/boards.h"
>   #include "hw/core/irq.h"
> @@ -596,7 +597,8 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> -    int ret;
> +    Error *local_err = NULL;
> +    int ret = 0;
>       /* For ARM interrupt delivery is always asynchronous,
>        * whether we are using an in-kernel VGIC or not.
>        */
> @@ -610,6 +612,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>   
>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>   
> +    /* Initialize confidential guest (Realm) if needed */
> +    if (ms->cgs) {
> +        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
> +            if (ret < 0) {
            ^^^^^

            Code alignment issue here.

> +                error_report_err(local_err);
> +                return ret;
> +        }
> +    }
> +
>       /* Check whether user space can specify guest syndrome value */
>       cap_has_inject_serror_esr =
>           kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
> @@ -660,7 +671,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> -    return 0;
> +    return ret;
>   }
>   
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu)

Thanks,
Gavin

