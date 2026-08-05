Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D21F419A;
	Wed,  5 Aug 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897417; cv=none; b=Sa0dK8Sw/wGEcFtZNMA2EkjtgTG1ycxXM/cIMadZymYZD+rh4+inR4C8kf2zM1Ciq1DZLppNBXhgkeroOmRQTNXy4IxSA+DtSF12U5OAKLn5vegLPM1xWB+G7C/tMiMlK4Gf3cdrQhWoRTvDIS6I59arP0UGiWdnFlnG6+4lv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897417; c=relaxed/simple;
	bh=rTW1eer9rX9UkPFiKKz7hwuNMEOs+yhUf0sg6v2ehQY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=joZIPZAJDQu6tPbELz/sRtI+SUPxNGlfCDURsSzhKAPD+1O+w51ZB+LO4l58V8T9XYRLpM1mCKJwm7fhamvA/TmlfMs8Tougf14dZelA6huws/OMUltsSyAQvIixYODETOCD5pznwQXPG2nfIcXj11qOx7aO54TbFTqdOfPdfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxvKHEoXJq7oEKAA--.10895S3;
	Wed, 05 Aug 2026 10:36:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxTsW9oXJqYS8kAA--.64818S2;
	Wed, 05 Aug 2026 10:36:46 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Advertise already-supported capabilities
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260804082604.178092-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5bbfd376-d3e2-e62a-f07d-9a4ee0635780@loongson.cn>
Date: Wed, 5 Aug 2026 10:36:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260804082604.178092-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTsW9oXJqYS8kAA--.64818S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF17trW7tw1DKFW5JF4rCrX_yoW5JFW7pr
	409wsFyFW8Jr92vas7J3ykWF4F9rsrJrWSqa4Yvryjkr15Kr1jqFy0krs8XF1DGr1furyI
	qFnYqrnYgayDKabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJU
	UUUU=

On 2026/8/4 下午4:26, Tao Cui wrote:
> Several LoongArch KVM features are fully implemented but were never
> reported through their standard KVM_CHECK_EXTENSION probes, so userspace
> cannot discover them and either ignores them or takes a slower path.
> Advertise the ones that already work:
> 
>    - KVM_CAP_STEAL_TIME: steal time is fully implemented (host-side
>      record plus guest paravirt), gated on kvm_pvtime_supported().
> 
>    - KVM_CAP_IRQFD_RESAMPLE: the resampler is generic code backed by the
>      in-kernel irqchip; advertise it so userspace can use irqfd with
>      resample for level-triggered interrupts.
> 
>    - KVM_CAP_VM_GPA_BITS: the guest physical address width is already
>      computed as BIT(cpu_vabits), so return cpu_vabits directly.
> 
>    - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
>      implemented (CPUCFG, PVTIME control); advertise the discovery cap.
> 
> This adds no new functionality; it only makes existing features
> discoverable via the standard probe.
> 
> Signed-off-by: Tao Cui <cui.tao@linux.dev>
> ---
>   arch/loongarch/kvm/vm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..d7dd08d9be5b 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -120,8 +120,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_READONLY_MEM:
>   	case KVM_CAP_IMMEDIATE_EXIT:
>   	case KVM_CAP_IOEVENTFD:
> +	case KVM_CAP_IRQFD_RESAMPLE:
By my understanding, KVM_CAP_IRQFD_RESAMPLE is used for VFIO intx 
irqline interrupt injection, is that true? now IOMMU and VFIO is not 
supported on LoongArch.

>   	case KVM_CAP_MP_STATE:
>   	case KVM_CAP_SET_GUEST_DEBUG:
> +	case KVM_CAP_VCPU_ATTRIBUTES:
this is ok.
>   		r = 1;
>   		break;
>   	case KVM_CAP_NR_VCPUS:
> @@ -136,6 +138,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_NR_MEMSLOTS:
>   		r = KVM_USER_MEM_SLOTS;
>   		break;
> +	case KVM_CAP_STEAL_TIME:
> +		r = kvm_pvtime_supported();
> +		break;
this is ok.

> +	case KVM_CAP_VM_GPA_BITS:
> +		r = cpu_vabits;
Feature KVM_CAP_VM_GPA_BITS is also to control max supported GPA bit of 
VM, only only max supported PA bit on host. For example max PA bit is 48 
on host, it is ok to set GPA bit with 40 or 48, only if it is smaller 
than one on host.
If my understanding is correct, it is not supported on LoongArch now.

Regards
Bibo Mao
> +		break;
>   	default:
>   		r = 0;
>   		break;
> 

