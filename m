Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9123306D2A
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904251; cv=none; b=ATL5rE085DEBKJ6Q4ICAdzkpodfugORPpJQyGKqs95/DiAks9K5EEOBnp9+W1U+el7AmYZcLeo/msaVkm//rxnBM0DZmAA0MXMbD52tIUpigpoRXMqbeX4ggGisktx6KQfYgLgzZPJR9lKFBSY5xSyVnm8alj6YdkqQ+obgDPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904251; c=relaxed/simple;
	bh=hlKAqMPZJbvDE7CqkVeaLDiiesHx2akKKjSHXGc7AyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpASXq0NuKu36Yj7HMIuD+0cWqzweZLzZ52zLq/83EPJ96BAbOqafv0/EnNIfC9vRd6GTGO5Yso86us0ll64bdc+7i3QGuyTDx588yefOywhb9m1vPWWCOUtYzacD/+Q/grthqetKfPvmfO2/sqxI37PzOC2Fg1T7jb0cqwFrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBHmScSA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua/W0hUl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBHmScSA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua/W0hUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790904248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
	b=iBHmScSAGKAYGOj/7M3Fr2s4rNVTYKPVxd7l8mtvuir2g5IU/uYAyJHCFU0ifcLqQBPo3f
	9ungz8N00Z4Xr3nMfQCQBHtGCjZspz+YU+AsKISeFI0r0sDkTQJBIFDcnAETGk0eYPiLDB
	52Ad9DHk+4fAT3Lep2X4113DUftHbfU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-KI2M7TfzOqKx_obWj3-AEg-1; Thu, 01 Oct 2026 21:24:06 -0400
X-MC-Unique: KI2M7TfzOqKx_obWj3-AEg-1
X-Mimecast-MFC-AGG-ID: KI2M7TfzOqKx_obWj3-AEg_1790904246
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso7998238a12.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 18:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790904245; x=1791509045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
        b=Ua/W0hUl7NxCjhONWKxYtxMFd48fHb1xecHA8rGK48bKT7oCuiifqJyOon1+PbZG27
         1AWUCbYn9HgABpdSYO8Pgs7ZSmHm+UiCzTCfww74e9gsYUWLChx1oJUri+PQael2ZviQ
         7PRe4v/yCL/hrAxJIDenj2G6LdQm2CDm2gnHzJ3Qxt7m4wylAtd6pglMUGe1IQQWJqA4
         BOA2eeToD0znfamuYE3YktlVDevmc14kryXrlH763rZFyWz+DC5uM8e2WZ/R4hQ9YFo+
         W2qVwKTSiapojRH2L0EWS6+54FGAtbQ0ra2aIsr2HGLvCKKN3AxW7ht+okhU7Bholm9t
         yrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790904245; x=1791509045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=De8yorP9FudcMiIi/X0cxcjwqsKGIT811EzMXUc/PSI=;
        b=OkLyBU7uC+2Ku9j1+l8f5tobbANrtlf+erFZrg6+3bGVakSSWzZQB+nsTvc7cy4XK/
         XOJu3vU64OZIgOBWHWME+3+BYVm4ZsktnkWnxsrY7iO2IfjlDdJ5tgqf67LpjmUTbygJ
         f9xPNttVerJc4EzUnzPdPQHhaEwA1F87mlVUowCeoLSZLaQTygRdvgpohKPQSlVw06B+
         alAjx24L2rg3TguF19SyI3Sm3sLWM7ByY0M85xmEf4EmTocmSMQpKcya9ZnMy8B8SHwY
         Se2cXnHGa1kAyIlFX5HsuJ7wf/sOZ65TzTjtqNG2ZlBEJBn8sTY7mBlVLgWuGP8crnSr
         7brQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9RZqPx0vomX5pu2t/uhH1AD1X/42SkiNNlASm47bJ8/0anAGXDqYVnvauJyV5539o5/k=@vger.kernel.org
X-Gm-Message-State: AFuF++nFBU49elvMNGDSng0wX/BMh5Np7qqGg2vuC3HRgQdPgnWm+3DM
	NKjCoh93Z09jj51gKZ4CNaiGKecKLsjjtiMQ9U4HV6in0Qz0iedyLt0Y3ItsGHYgIfdOnIjprAs
	f3PgKn2IQyP8tb9AzcnB1aSy5jxAiKpfCYTJAGnDgVoGLqyAy05rCog==
X-Gm-Gg: AYBFou0SXBr8C8PMac3/T91Qar+rMSg4UE1kOTTIglazFIs3IBcnvkh1Osd8KJp+16W
	wZzj1gsFoLW3iXYDzKZLEqGRJY75XpoRFVck9eJ8YhWGYOEPXQLmFcA5QV0LA2juf9NvHPQY9Qd
	YEvwXc6cXqoauOn2tmjstz1TTv+m4Sqifmkgd+yahx8p/+APFaVabqt/uHxt3sqsCkmT3lFd9Fz
	T/ZQs1B06bfOvAgCyzJbmeVz3aOtS3iNU9Nwk/oZsACJvlHJgUA1xIJErhiegqvnUQes7n3xufW
	6zFbWcx/YhF4BDgMxJYXYTZlyZIEk5HuurFsAIzwspFpx5/EWlQSNxZChed13NjInMXvKENmQol
	UEI4xZOMugEi5NjNM9cIXOSmEbwtmOS+9ENab9Bz8bA==
X-Received: by 2002:a05:6a21:4ead:b0:3dd:a196:69df with SMTP id adf61e73a8af0-3e0bd12e409mr1203135637.58.1790904245525;
        Thu, 01 Oct 2026 18:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ead:b0:3dd:a196:69df with SMTP id adf61e73a8af0-3e0bd12e409mr1203101637.58.1790904244966;
        Thu, 01 Oct 2026 18:24:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7384ca1sm297063a12.21.2026.10.01.18.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 18:24:04 -0700 (PDT)
Message-ID: <062da66b-73fa-40e5-94cc-80b1ca760687@redhat.com>
Date: Fri, 2 Oct 2026 11:23:58 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-11-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> That way we can deterministically calculate the Realm Initial Measurement (RIM).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index f7c2cc786e2c..9985f5daba89 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -10,6 +10,7 @@
>   
>   #include "hw/core/boards.h"
>   #include "hw/core/cpu.h"
> +#include "hw/core/loader.h"
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> @@ -22,8 +23,18 @@
>   #define TYPE_RME_GUEST "rme-guest"
>   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +    uint8_t *data;
> +} RmeRamRegion;
> +

This is the equivalent to 'RomLoaderNotifyData' defined in PATCH[09/24]. We may
use 'RomLoaderNotifyData' if it can be renamed to reflect its purpose, no need
to define an identical structure.

>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
> +    Notifier rom_load_notifier;
> +    GSList *ram_regions;
>   };
>   
>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
>       kvm_mark_guest_state_protected();
>   }
>   
> +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> +{
> +    const RmeRamRegion *ra = a;
> +    const RmeRamRegion *rb = b;
> +
> +    g_assert(ra->base != rb->base);
> +    return ra->base < rb->base ? -1 : 1;
> +}
> +
> +static void rme_rom_load_notify(Notifier *notifier, void *data)
> +{
> +    RmeRamRegion *region;
> +    RomLoaderNotifyData *rom = data;
> +
> +    if (rom->addr == -1) {
> +        /*
> +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> +         * Instead the firmware will load them via fw_cfg and measure them
> +         * itself.
> +         */
> +        return;
> +    }
> +
> +    region = g_new0(RmeRamRegion, 1);
> +    region->base = rom->addr;
> +    region->size = rom->len;
> +    region->data = rom->data;
> +
> +    /*
> +     * The Realm Initial Measurement (RIM) depends on the order in which we
> +     * initialize and populate the RAM regions. To help a verifier
> +     * independently calculate the RIM, sort regions by GPA.
> +     */
> +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> +                                                   region,
> +                                                   rme_compare_ram_regions);
> +}
> +
>   static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>   {
>       KVMState *s = KVM_STATE(current_accel());
> @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>       error_setg(&rme_mig_blocker, "RME: migration is not implemented");
>       migrate_add_blocker(&rme_mig_blocker, &error_fatal);
>   
> +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> +
>       /*
>        * The realm activation is done last, when the VM starts, after all images
>        * have been loaded and all vcpus finalized.

Thanks,
Gavin

