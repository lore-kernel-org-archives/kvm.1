Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397152;
	b=NO+Q2sA+HfsRNMJKklQPTRNNRGq5U24wpOtBvL3Q/Gg17pBtdnKg04ca4fsMq2tHu28q
	 WIIY29izSF4cj5IrHcQlDjnHrBRsS/O2AmbFrsniCMI1qZkdLfnCMLcTbWNukmK7D+fJv
	 xmiTnePfxoa7TNN2EO9ll45TnXcea/Vjn2zMxYrVrhF28yzejCLJjb9/Z9B5jlGA4syIA
	 WrWocK4MFp7+WjdyYABv+pABEiNbdcAlZ/k5KIpijxpqx+cIhcBbADAliDr1GwJby8bhb
	 rP5AK1EisRaw/x076e7/5IJVozfsDhyjwEyg7HOdFFyq7WHmOIALKOp+v90iUeuOwoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397152;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=EvpUTOu7fCXkl48gy8W+3c6mikMHnobx7dplACt6G1k=;
	b=krpd7LV/hWAzjKC/klgUyM62kUVnzRSMPW8Xpc/utkyHf0DXTqB/AQhy8PZOQFKl/kHf
	 GGxS/daXT7zpFNd9XZxprMOF4NwdwlnZyWFGI2nwkIUlch0NaH9EtFKyAp6DG/32wo3Av
	 jVsd7GF8cbaH11qV0cnIBwYxt4+gfJsjXMmhZuyGwsrwBW7tJNbZdupMucP53cZZyhJAg
	 f/No1IZ0rm7wuCvL4YL9x4uX2XoWs9nMuPTUV6KGSL3haShwUgq0jIx+Stxo6VfGyE4Zm
	 5ZtKE76IYDtCer2oS7WT6EDwAiZZaFH2VpRTwL9MCS1GueNx2rlHzEybxVEIC25Q10g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204E606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 01:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4204E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxX9MVlgNrohQiAA--.31668S3;
	Mon, 23 Nov 2026 09:25:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJDxg8w+lQNrT782AA--.16154S2;
	Mon, 23 Nov 2026 09:22:09 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Remove unused macros and declaration
To: Zenghui Yu <zenghui.yu@linux.dev>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev
Cc: zhaotianrui@loongson.cn, chenhuacai@kernel.org
References: <20261115151204.82817-1-zenghui.yu@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d08f20ee-f34a-3b7d-7ad3-0b3879de4278@loongson.cn>
Date: Mon, 23 Nov 2026 09:23:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261115151204.82817-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxg8w+lQNrT782AA--.16154S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF13tw4rJry3CF13tryktFc_yoW8XF4kpF
	97ursYqa1xWr4fC348Kw1DWwnxWrn7Gr1agF9Fqa1ayF15tw1DJr4kKF98WFyqva1Fka4S
	vF909w1UZF98t3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U

Hi Zenghui,

Thanks for the fix.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2026/11/15 下午11:12, Zenghui Yu wrote:
> The KVM_LOONGSON_IRQ_* macros and kvm_restore_fcsr() declaration are never
> used anywhere, drop them.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>   arch/loongarch/include/asm/kvm_vcpu.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
> index a70a32103523..439731f715aa 100644
> --- a/arch/loongarch/include/asm/kvm_vcpu.h
> +++ b/arch/loongarch/include/asm/kvm_vcpu.h
> @@ -44,14 +44,6 @@
>   
>   #define MNSEC_PER_SEC			(NSEC_PER_SEC >> 20)
>   
> -/* KVM_IRQ_LINE irq field index values */
> -#define KVM_LOONGSON_IRQ_TYPE_SHIFT	24
> -#define KVM_LOONGSON_IRQ_TYPE_MASK	0xff
> -#define KVM_LOONGSON_IRQ_VCPU_SHIFT	16
> -#define KVM_LOONGSON_IRQ_VCPU_MASK	0xff
> -#define KVM_LOONGSON_IRQ_NUM_SHIFT	0
> -#define KVM_LOONGSON_IRQ_NUM_MASK	0xffff
> -
>   typedef union loongarch_instruction  larch_inst;
>   typedef int (*exit_handle_fn)(struct kvm_vcpu *, int);
>   
> @@ -70,7 +62,6 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu);
>   void kvm_lose_fpu(struct kvm_vcpu *vcpu);
>   void kvm_save_fpu(struct loongarch_fpu *fpu);
>   void kvm_restore_fpu(struct loongarch_fpu *fpu);
> -void kvm_restore_fcsr(struct loongarch_fpu *fpu);
>   
>   #ifdef CONFIG_CPU_HAS_LSX
>   int kvm_own_lsx(struct kvm_vcpu *vcpu);
> 

