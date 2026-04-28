Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12037419A;
	Tue, 28 Apr 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370021; cv=none; b=ZwVsJhl1AquzTge92Zsw9oX6Xqn18bhTgoW5B/S4m+oDOlO6F9q5+yZMXhvmsgrZZNAAw1rQr+ZlPmk1mqKTeUD/xPML0CnK0XCVfQ1x/jspeDWH2P/u+3pA05U3hZmXXZkJBS+j/FWA7K431WLFmNqysjPElQHmyx48TmHBHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370021; c=relaxed/simple;
	bh=KNBThQdX/1sMmn5AxkdbTKL4cyR01I3xziXqQPTdjsY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ee02xBPoKxTcOrluydQYgGr1LFFdmNMCwNjqVmqiD+bF21L6wfzINDkMGDrO0QfjtWcGA5nGTfKhZgcFGT7EggIJ4W2NadcJZy24aP3OrI7rQif5QgjaopBS55IGt9QQXHr7APmnrOLSnEbZyRXzvTNjozDv5c7iYZy+QzPJXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxEvCgg_Bp+LYEAA--.16005S3;
	Tue, 28 Apr 2026 17:53:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDx6+Cfg_Bp83t2AA--.29591S3;
	Tue, 28 Apr 2026 17:53:35 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
To: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260428074742.2274610-1-maqianga@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2074ae0a-5a3a-c0b5-cd09-040696679715@loongson.cn>
Date: Tue, 28 Apr 2026 17:50:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428074742.2274610-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+Cfg_Bp83t2AA--.29591S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryrWw18tFyxWF1fGrWkZrc_yoW8GFW3pr
	ZrCa4qqr45Grn2kry8J3y3ur12kr97WrySqa4a9Fy7Ar4DXryrXFyUKrZ0qF13Gw4rCrW0
	q3WFqwnYga90yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==



On 2026/4/28 下午3:47, Qiang Ma wrote:
> It doesn't make sense to return the recommended maximum number of
> vCPUs which exceeds the maximum possible number of vCPUs.
> 
> Other architectures have already done this, such as Commit
> 57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")
> 
> Fixes: 482795cb62aa ("LoongArch: KVM: Implement VM related functions")
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   arch/loongarch/kvm/vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 8cc5ee1c53ef..1317c718f896 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		r = 1;
>   		break;
>   	case KVM_CAP_NR_VCPUS:
> -		r = num_online_cpus();
> +		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
>   		break;
>   	case KVM_CAP_MAX_VCPUS:
>   		r = KVM_MAX_VCPUS;
> 
Hi Qiang,

yes, this is better.

Though value of CONFIG_NR_CPUS is 2048, currently max CPU number of host 
hardware is 256 still because of limitation of AVEC and extioi HW irqchip.

If there is HW machine in future which supports more than 256 CPUs, the 
max online CPU is no more than 256 with existing kernel version. So I 
think that the "Fixes" tag is not necessary.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

