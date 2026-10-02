Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79ECA6B
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903121; cv=none; b=KPtSTcD+eIgmSbjl/dv0sxk7sdqztuZXRVTwFqUtRPoXlQJjK0mzqK7ioJJBjYeG5sPNHQLYmOotfyUvPB1LCB1aDnjUmaSrEkUrp0t1yANt5v6BnnQchFtvGus1rl0fHZt3cT3i6kccVwmFeWCFEnJ7K8i+kRR9SJibE4M0UEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903121; c=relaxed/simple;
	bh=TVcUv4if2emSRNzBKd4d1dhytJJ/hKTnIl2m4q+MTwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXyHqnVEtH6gbwNdvOyh8XsRaxKp3gA6m2eBiMhpgvjY+zYxHZ5pqtG+ElbqImejV5ikq8kqHlxBTPKjIRbbgEu0rM7R/BVaQgJU1yf7uk2Os4UCcwZIA7Acq9+gqRJ7MWd6eAA4cJN2Zwo0KKY3SKJY9ic7U3q4GK5TGRQOOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRxLjL2G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+F6jit1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRxLjL2G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+F6jit1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790903119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
	b=BRxLjL2Gw4rNalNK86mAfBl5f4jcaCIUso5XfvmgIu+zWJGh4wghCFw1831j6XO40gK8U8
	PYw5Rsz1bFJT0DeCis0eXoaqiJUZ2uAmD91h/242YqT60+fpOxP8VxWKjRuPuguAv4p9Qh
	H1tBYKdwyADnGvhg8n6tAeogtJms8J8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-TeGHmNdPP-S6lQljMuqcaw-1; Thu, 01 Oct 2026 21:05:17 -0400
X-MC-Unique: TeGHmNdPP-S6lQljMuqcaw-1
X-Mimecast-MFC-AGG-ID: TeGHmNdPP-S6lQljMuqcaw_1790903117
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a0f55a3941so6860367a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790903117; x=1791507917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
        b=W+F6jit1sdeb868O+wUdsPCXHv5y7ahuv+vxeKsQkHuPTOxfTu80V690Ip0WHMGL59
         Jgp43goaM0C6pdYREWE38wbCJ/P6vc0hjDJPGQb57zuzBI55jYIiTFN8pRxi2fOYfby/
         VwwsUqKEcHKgsLCuI0aYc0hglRT3/T+c8TBfugTOjZVnicr/luJXvarHDJByRSfIevII
         SV57O7H/tX9VjDXfBrE4Wq4kJo0/Ub3x1JWUlag9GPkyl5i1FzvIXVgFZ1nZ84CXhKwj
         IxA2a9K+pelS44/PzvvIaIgT5UsnkrYualsQ0/BC42g9PUiwhpjtFSRVg/E7A+YZIN7I
         58Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790903117; x=1791507917;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
        b=2ca1cQJjKkCToNHSQcg0GD4zA6FkVnM9XPLLYDMA2A2SCnp1phSnRcGkoVwNlVJ5Ea
         JlxIn79DXPewl78JuFqkmqtm2acEYkS75sgidnFShuo6qTtAWpFPYHnxePQj4eiu7qPT
         p6pxjD8jwj1fCWGY/PDsd96F65Djn6bahlGMxZ6hSVxdeiHVZ8z531HaznRavEzX/NZn
         oNqsEHDAP4pCbAGsL6yQ+Sj3di+0lQghN4RhUNu+kMAwdMmeUDXZJDyzsoObRbUlXMGv
         dixSVmgWvxtenjxxv8+P6nHt4OPI1p0LiZJVoiX3EjIzyM4+N0DlCVRwWSEwvbFnLBdi
         qpYQ==
X-Forwarded-Encrypted: i=1; AKwUvBw00Pvwvj/qHGM3xfCvDtqefzNhgc8SO6J5cxfpRAEb9gfuz0LJPUh05IXPkP24UAWsIj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0acZFWfitgRIkIfYuGUMklOzdnVaC/SdWBtUJ7zYer6YaQyz8
	jT0Gq6pmJkRUKb7uisa/xm2EOL/J74oMBcJs6MZUJq1IKWprFWs9o6W8UCdbSoVZ5vD3IzlxdVT
	kWvW7wx7CqykR5QJmP3T9DZt6JBPA/4mJcoDP5zHlokdYhZqF9yyXrQ==
X-Gm-Gg: AYBFou22lAE5sulGHD6oRaAM1r04tSQBD022MSiAoStdTD0KLjCVx/x+uC0AhYdh/2K
	CwZfvMzhlAwbBzHi5N3dtOxhQDnpOCyvf6ieEi1QgSznCRdpDPKAwWqhO8j+Bo7GOqlSF7y98jb
	wOmF9ZdO8HcOmcH2bsGyWA5IKIAi1QNYNyck3Umg0MC+xaRZF/RFx6DrOUTJECPDIhmAXncp0xw
	wHmylhGlc8PWQSaXR6+fpZQtzCdjOzNES0NjPdXFSaZe4IS18PPcFrIjmDoq/syiOrXJH+QkzpB
	gbkoALmMMpkR4LrUREN1JuIt8fXkdj/9Ykdrop3oPlqMlSvRijZs2SYpZtUzt/pijtSwKtqGrUn
	M//CYl+BUh008ehKhcMAJlsgVcIHvwPTY+OU3Zv1wyQ==
X-Received: by 2002:a17:90a:dfc6:b0:3a4:eebd:2410 with SMTP id 98e67ed59e1d1-3a6ce993df6mr1096533a91.37.1790903116437;
        Thu, 01 Oct 2026 18:05:16 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc6:b0:3a4:eebd:2410 with SMTP id 98e67ed59e1d1-3a6ce993df6mr1096480a91.37.1790903115746;
        Thu, 01 Oct 2026 18:05:15 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6e7401d04sm198743a91.14.2026.10.01.18.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 18:05:14 -0700 (PDT)
Message-ID: <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>
Date: Fri, 2 Oct 2026 11:05:09 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8
> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c6da1fb9f3..d86e66e056b9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>                                         struct kvm_vcpu_init *init)
>   {
>       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>       int max_vm_pa_size;
> +    int vm_type;
> 

@vm_type can be initialized when it's declared.

        MachineState *ms = MACHINE(qdev_get_machine());
        int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
        int max_vm_pa_size;

   
>       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>       if (kvmfd < 0) {
> @@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>       if (max_vm_pa_size < 0) {
>           max_vm_pa_size = 0;
>       }
> +
> +    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);

() aren't needed.

>       do {
> -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
>       } while (vmfd == -1 && errno == EINTR);
>       if (vmfd < 0) {
>           goto err;

Thanks,
Gavin

