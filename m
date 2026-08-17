Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F691443AB0
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983093; cv=none; b=HlFmC7YLsDfF+PdasKao6Y9SQ2gT8IX8bPXaepCF8B2fFGr3EtBza3de9V52F1v8PvbzGTi4TH+yXpVeYJmRKqxHYhZ1NmtFlOilT4Jcw2SYa9syA3NXsXuuYekNpdLv5CrKWqv17FKmchB+AVXxI66D//M2WNBmSKRd3g/HwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983093; c=relaxed/simple;
	bh=maTJIFyFTmShrCTg5Rs8PrNSoifzxS99wIMG/4caijw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezvN0ZMgF3oFn1s4L7t3nhLtkQIe8KlIZGiCECaRZWxV+bpVB0bCjPdd+p7Ucx71lXG50rzTf2/QXp9GQ8y2Drk1QNeRJ8KfPBYpQQZpzAgyachRaqaK5iSP5slSwVrAnDso42ZfMVVYRDrxi4ssz3Kju/YZSWZlp4xdkxJ/12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pkj1bcyh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkj1bcyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786983089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A75/MH0dF78NqqlN7VMRp0DUbxdXIfUtAoPwCbnyY04=;
	b=Pkj1bcyhA+sStfFwdAsN4izA6q008U8kuQruSM16YBpGvajo6lsLrIP+cKfn3qvWHxGsnS
	OtvmEPs1tGudVH2cVhpRT2mhPlRTOBUodEuHRIE93QLKrZTXiU/MM/04XMODPt/ly81mL1
	YXdA35ncuF19bY7ay4HxHAcgorSmECw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-8RwKSPObM0a1Sc9aTXzx0A-1; Mon,
 17 Aug 2026 12:11:23 -0400
X-MC-Unique: 8RwKSPObM0a1Sc9aTXzx0A-1
X-Mimecast-MFC-AGG-ID: 8RwKSPObM0a1Sc9aTXzx0A_1786983081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9771955F7A;
	Mon, 17 Aug 2026 16:11:20 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F121C3000223;
	Mon, 17 Aug 2026 16:11:16 +0000 (UTC)
Message-ID: <3fa59521-1420-49e3-9d73-652148f946ea@redhat.com>
Date: Mon, 17 Aug 2026 18:11:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] target/arm/hvf: Lock BQL outside of the vCPU inner
 execution loop
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf
 <agraf@csgraf.de>, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-14-philmd@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260813181640.6537-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/13/26 20:16, Philippe Mathieu-Daudé wrote:
> Reduce lock contention by acquiring / releasing the BQL
> outside of the entire vCPU inner loop.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/arm/hvf/hvf.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index c14ea54a67f..9c6408d2e25 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2598,20 +2598,20 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>           }
>       }
>   
> +    bql_unlock();
> +    cpu_exec_start(cpu);
> +
>       /* Inner vCPU loop */
>       do {
>           if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
>               hvf_inject_interrupts(cpu)) {

It always return zero, so you can make it void and change to

           if (!(cpu->singlestep_flags & SSTEP_NOIRQ)) {
               hvf_inject_interrupts(cpu);
	  }

However, a bigger question: who calls cpu_reset_interrupt() here:

     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
         trace_hvf_inject_fiq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_FIQ,
                                       true);
     }

     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         trace_hvf_inject_irq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_IRQ,
                                       true);
     }

and can this be changed to do something like arm_cpu_kvm_set_irq() instead?
Having the function called only with level == true is a bit unsettling...

Paolo

> -            return EXCP_INTERRUPT;
> +            ret = EXCP_INTERRUPT;
> +            break;
>           }
>   
>           flush_cpu_state(cpu);
>   
> -        bql_unlock();
> -        cpu_exec_start(cpu);
>           r = hv_vcpu_run(cpu->accel->fd);
> -        cpu_exec_end(cpu);
> -        bql_lock();
>           switch (r) {
>           case HV_SUCCESS:
>               ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
> @@ -2624,6 +2624,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>           }
>       } while (ret == 0);
>   
> +    cpu_exec_end(cpu);
> +    bql_lock();
> +
>       return ret;
>   }
>   

