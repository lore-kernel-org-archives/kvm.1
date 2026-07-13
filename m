Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCAEACD
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920645; cv=none; b=QqJX2PMEJLz+ATBiw3AG5rgAQ98SNcfonREeINObOOf47N2aH7UFtXMroFW7U9DuYZjRTLjYBtajVI68qSlixCQthditstYhWcZ3UtGnKXWTP0fB8FEpvBm9iRSCo/8Z6u+AT+05myyR3Jur9SYAFQQJm1WE9nqqBJMYGhM+eGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920645; c=relaxed/simple;
	bh=Fi7z1vH9bca0XOH/qOCTNLEzS7ZXsjGMcy0nMajKyfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8TPUn1W1SgLcT8mJcbmFNqjW5WrdkfLgIgFTHsKI4bvIymhyMIZaMD9DsGpLl59tWR31J4uqVPj7uAyDZEv3PdBx5IAMHNvgfqXt+Nphjm4lRw8EF0FAyYvRiOLHZKWEY1rYtEbex3felP/zylEWbb2Ag0t5n81i/pQ960LK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ap78OqRA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXYePIe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap78OqRA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXYePIe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783920642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
	b=ap78OqRA4hTtrOEBnZV+c7Zpw/kycxNoQP1oCiReKyUfm9AeLfF2SjZFvQaLrUBU0U8w1x
	ff7lvUBEpHo8rC3TqIBb76W+JtUJ2h9UKr3nJQnqG4BVDZaPpmmMGKAeg+899Y24VJkbad
	Gyvnwef+pNsE4p/8EnFI2+nuUK0D7X4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-1Dj7_hdMO7uDMc1wSf1ZDQ-1; Mon, 13 Jul 2026 01:30:41 -0400
X-MC-Unique: 1Dj7_hdMO7uDMc1wSf1ZDQ-1
X-Mimecast-MFC-AGG-ID: 1Dj7_hdMO7uDMc1wSf1ZDQ_1783920640
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84865f326efso2911710b3a.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783920640; x=1784525440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
        b=KXYePIe7/qU6FVKLLWqS/DRZUhqjPO4quLjcsoDdHoXl+awsPIVqb5xGVP7dziqhq3
         XaV3RuUPzrBh/FBj819vDhvvoQKpz8DY/IFUeT0TzmVAoRUDdgGWFueXlgrG1BDwiwNW
         qow7D0PlDL4yX9HC9mNnqPE8dHyoh2gAZVwr06anez4KWG/BBCt5XQKa4CgdH9LxX8Nk
         Fg/WYeBxO7zSinj5hi0eELl8wT6QiaulSExF9zVYfXyFDkn5rb91eZccwVclSy+gC5fH
         A3IYHiwsuqQlvZjUSEpo5WCHt4TD8jlzGpWNHD3fwcD2K6m/mK3syWNz8SNQ+T5c+7pf
         3KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920640; x=1784525440;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
        b=IfXmeq8j4fbhvuKwRr4dUMnVw3gmo72G8BNgwhNvqmcnTcj7pwPGWvO0BSQCXpnbs7
         BeuMOE1K3cTjpTBM9GaLWxvp4i3ZBMV47IXMmNuL78ry/NBBffpdD7o7rCupDA36/xXE
         YUgqBAHInALjuhVa9nmk2cGqe2WU2NDCjotEcyulwmSqolZye8j0Z0zCSyFq7aQ60Mnv
         Pgrk4PkVsssaCEhXy2OlbQ6SPrmZxFUByuCv9Csvjgc3LYAJ8pymlPB+NW0m2PFVTxl1
         u445dymXoGcDO9DExEZEOiMAg4N1UvWiGr3Wf+MxKOVu3POjKgbRI+8JcSvWu9H8y7b5
         jVQA==
X-Forwarded-Encrypted: i=1; AHgh+RqTL/iW1rLiDRyOL5DXaCOjR8uQX/f9T59QblaMCMiPZhCCq9Wm7+o1FhWOLv9MF0vOFR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFZvrWoYy12Kgd6OST8Q/ZqvAsXxepWL9QijDp6QZOmZSY0gb
	xcHoScKOhQDHU9NbOqhUBxFjKBRkB527fehEvdIt4E0j8o9X8WTiMF8US3g11qQQIvUWkFDjA1d
	uPaAE42Vk0VBn4kKGx/zu/zT4yjiIrasU0VnI7nqPKjWoVsKjPsCZEA==
X-Gm-Gg: AfdE7cnGRdPk2FAAd1Jp8vW8Lr611ClqbFIP+9ndNOLh6LmvZdXplI1O1CJsE2zTzYk
	9Z195xR4+pTsMmeT95ENE9mjf3Jm+yypEf+OYz/7sM+Oe//Orhq6B03hozGfslhocDpPrAeiCBy
	KaSweV7+q5OvTDI/vXMv57fd/fFGaNZ5RI+dBxceroDT+X8Lh+v7vbTAjW5YXUWJkl/8lmlIp1O
	RZJLQThVI/EmOkPn+zGD5BXIvgArmwG3NhbBMlhfBSLsQDCqebcVjU38HxQP3G+b8B8Q4cLDsWF
	qTkh64FJzwfb8lFTySPPbgEcgS7n2AM87ZL88gq9qnmShaHAzqYRPCD80qGVfIXoHUqWMLjS3Yg
	lzoZmMm53/k8pY34o8+g9pTkSDdzcrL4/G1JxdEkB4mURS7NYoZvxeQ==
X-Received: by 2002:a05:6a00:1d90:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-8488975aab7mr6391954b3a.43.1783920640060;
        Sun, 12 Jul 2026 22:30:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d90:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-8488975aab7mr6391920b3a.43.1783920639587;
        Sun, 12 Jul 2026 22:30:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a30026410sm1590698b3a.19.2026.07.12.22.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 22:30:38 -0700 (PDT)
Message-ID: <ac26ac91-6809-4429-9750-e7d671e952bc@redhat.com>
Date: Mon, 13 Jul 2026 15:30:31 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 07/25] target/arm/kvm: Create scratch Realm VM when
 requested
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-8-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8
> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c  | 8 ++++++++
>   target/arm/kvm-stub.c | 5 +++++
>   target/arm/kvm.c      | 4 +++-
>   target/arm/kvm_arm.h  | 8 ++++++++
>   4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 90c1d30ba24c..f763d5ed6199 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -99,3 +99,11 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   
>       cpu->kvm_rme = true;
>   }
> +
> +int kvm_arm_rme_vm_type(void)
> +{
> +    if (rme_guest) {
> +        return KVM_VM_TYPE_ARM_REALM;
> +    }
> +    return 0;
> +}

We had official name for 0, which is KVM_VM_TYPE_ARM_NORMAL. Another question if
it's worthwhile to have this helper since it's equivalent to something as below,
which can be directly applied to the caller.


     int vm_type = (current_machine && current_machine->cgs) ? KVM_VM_TYPE_ARM_REALM :
                                                               KVM_VM_TYPE_ARM_NORMAL;


> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 4ab6f08637d1..6d52f172c5df 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -129,3 +129,8 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   {
>       g_assert_not_reached();
>   }
> +
> +int kvm_arm_rme_vm_type(void)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4c212ed0c337..6aa1cd04e484 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -108,6 +108,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>   {
>       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
>       int max_vm_pa_size;
> +    int vm_type;
>   
>       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>       if (kvmfd < 0) {
> @@ -117,8 +118,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>       if (max_vm_pa_size < 0) {
>           max_vm_pa_size = 0;
>       }
> +    vm_type = kvm_arm_rme_vm_type();
>       do {
> -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
>       } while (vmfd == -1 && errno == EINTR);
>       if (vmfd < 0) {
>           goto err;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 12ed1eee18b4..65ec1b970606 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -259,4 +259,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s);
>    */
>   void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
>   
> +/**
> + * kvm_arm_rme_vm_type
> + * @ms: the machine state
> + *
> + * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
> + */
> +int kvm_arm_rme_vm_type(void);
> +
>   #endif

Thanks,
Gavin

