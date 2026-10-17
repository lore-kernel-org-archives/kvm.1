Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A038B14F
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219661; cv=none; b=AAhhKXiiPja7PyvTs6tdxCl+kUYVpDo/gK1mWb72c7LEwqmVtRDz+FLbIMXcKku2nvoifXASRbAcMnCMWEKogt2SobybTRh7dcOmbLmok1+qJjUP7pUE41xFdzV1TwM/AfTG5GsnErqHf8L3qLVIDarNVg2w+loorHoqTpW+ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219661; c=relaxed/simple;
	bh=vDL4eRYOU70NHW3c0Z6bi/ZAGOULay+LzXOfNl2kzgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFmYfSDocT/A8mdPijUIhOsfzn4I905BxCd/qWYUMAJ56vNw9B2rLRlEkjfAhAmPLzleW8k6fuKdA9YNMN9YHNEF6q0t3khfvPvJMQQ4raJHM8PC2CDjMs8IAXD9c49K63EZvZd+UvwYqpJs14i67Wlkwaqidy1csDGWYpbprmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enqRWGDX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enqRWGDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792219657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Oa4F7t0+0NDXxalX71XAymg9taDjr1JExEQgwq3otA=;
	b=enqRWGDX4g2PBoHVZcOj1L5OVOOqxhGUVbvRSPEN3OSP1xrYqFo9a2eL6mgOBf793twXF8
	SL5DA+qTc9QyGS2ZJmKKC14DZRlWGGT7UiyqhKKHUGP0vr23uoh23pUpazko1zML/4Q5hY
	JPZg4yu5NqHVc+md9AOYWqUG1wSYtUg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-NGdJZHomM3KP7CpweHORug-1; Sat,
 17 Oct 2026 06:47:32 +0000
X-MC-Unique: NGdJZHomM3KP7CpweHORug-1
X-Mimecast-MFC-AGG-ID: NGdJZHomM3KP7CpweHORug_1792219650
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5052F1956065;
	Sat, 17 Oct 2026 06:47:30 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A97E11800495;
	Sat, 17 Oct 2026 06:47:26 +0000 (UTC)
Message-ID: <866179b6-8303-4c30-aa59-005fa4554362@redhat.com>
Date: Sat, 17 Oct 2026 08:47:24 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] accel/kvm: Add CGS flag to control in-place
 conversion support
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, xiaoyao.li@intel.com, chao.p.peng@linux.intel.com,
 david@kernel.org, ashish.kalra@amd.com, ackerleytng@google.com,
 lpieralisi@kernel.org
References: <20261007134323.1606088-1-michael.roth@amd.com>
 <20261007134323.1606088-8-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261007134323.1606088-8-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/7/26 15:41, Michael Roth wrote:
> For confidential guests, guest_memfd is currently used only for private
> guest memory, and normal guest memory comes from the configured memory
> backend just as it does for a non-confidential guest. It is now possible
> to use the same physical memory to back a particular GPA regardless of
> whether it is in a shared or private state. This avoids the need to
> rely on discarding memory between shared/private conversions (to avoid
> doubled memory usage), and is intended to be the primary mode of using
> guest_memfd for confidential guests moving forward, and future features
> like hugepage support will likely require it.
> 
> Add an internal flag to enable this support. Since
> ConfidentialGuestSupport is already used to track some
> guest_memfd-related functionality (e.g.  whether it is required for the
> configured machine), similarly introduce this flag as a member of
> the ConfidentialGuestSupport object.
> 
> Also add the KVM-specific checks to enable this support, but leave the
> option disabled so that required changes can first be implemented for
> CGS variants that intend to make use of KVM's in-place conversion
> support.

I would make this on (either by default, or by removing the option 
altogether) if KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES is available, 
otherwise you need a special option to run confidential guests on kernel 
that disable the "private" attribute *on the VM* file descriptor.

In fact, I think that since migration is not supported by either SNP or 
TDX, the extra complication of being able to toggle it is not worth the 
effort.  The old code path can still be tested by changing the 
gmem_in_place_conversion module parameter for KVM.

Thanks,

Paolo

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c                         | 18 ++++++++++++++++++
>   hw/core/machine.c                           |  5 +++++
>   include/hw/core/boards.h                    |  1 +
>   include/system/confidential-guest-support.h | 12 ++++++++++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f1deb458ec..862539aed4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3074,6 +3074,24 @@ static int kvm_init(AccelState *as, MachineState *ms)
>       kvm_guest_memfd_flags_supported =
>           kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
>   
> +    if (machine_require_guest_memfd_convert_in_place(ms)) {
> +        uint64_t guest_memfd_supported_memory_attributes;
> +
> +        guest_memfd_supported_memory_attributes =
> +            kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
> +
> +        if (!(guest_memfd_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +            ret = -EINVAL;
> +            error_report("In-place conversion is only supported if private "
> +                         "memory attributes can be set via guest_memfd. "
> +                         "Please ensure the 'gmem_in_place_conversion' KVM "
> +                         "module parameter is set to 1.");
> +            goto err;
> +        }
> +
> +        kvm_supported_memory_attributes = guest_memfd_supported_memory_attributes;
> +    }
> +
>       if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>           s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>       }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d9ac4b419a..e9cc6c2420 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1346,6 +1346,11 @@ bool machine_require_guest_memfd_private(MachineState *machine)
>       return machine->cgs && machine->cgs->require_guest_memfd;
>   }
>   
> +bool machine_require_guest_memfd_convert_in_place(MachineState *machine)
> +{
> +    return machine->cgs && machine->cgs->convert_in_place;
> +}
> +
>   static char *cpu_slot_to_string(const CPUArchId *cpu)
>   {
>       GString *s = g_string_new(NULL);
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index d0e4ad9820..9ea124b224 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -44,6 +44,7 @@ int machine_phandle_start(MachineState *machine);
>   bool machine_dump_guest_core(MachineState *machine);
>   bool machine_mem_merge(MachineState *machine);
>   bool machine_require_guest_memfd_private(MachineState *machine);
> +bool machine_require_guest_memfd_convert_in_place(MachineState *machine);
>   HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
>   void machine_set_cpu_numa_node(MachineState *machine,
>                                  const CpuInstanceProperties *props,
> diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
> index 5dca717308..2c9a9ff217 100644
> --- a/include/system/confidential-guest-support.h
> +++ b/include/system/confidential-guest-support.h
> @@ -92,6 +92,18 @@ struct ConfidentialGuestSupport {
>        * so 'ready' is not set, we'll abort.
>        */
>       bool ready;
> +
> +    /*
> +     * CGS implementations will use this to indicate whether or not
> +     * to enable in-place conversion for guest-memfd.
> +     *
> +     * If set, the machine re-uses physical pages when converting
> +     * between shared/private (as opposed to using different
> +     * physical pages depending on the access type, which is the
> +     * default mode when 'require_guest_memfd' is set without
> +     * additionally setting this flag).
> +     */
> +    bool convert_in_place;
>   };
>   
>   typedef struct ConfidentialGuestSupportClass {

