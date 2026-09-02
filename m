Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5A328B7B;
	Wed,  2 Sep 2026 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336297; cv=none; b=cLSS/AKgXjII7tJGnQ9T523Huo36nOaYTAyOGBywZbpyjFumZu+n9mIfao92WCzA8jfIyNkmTVEZnPr2kEWhrko2JKFFIo9SaygH7sr83HY5d1SXZ3nRImqbU5QaAEgdWfP6E9udSLCItF6fLuM6gx0ocQk2JKRk1vuDa5wsty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336297; c=relaxed/simple;
	bh=iaX4bSY8tECv0GJk95N9F797wm7D0nwMhGAYdtcSszs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mqf7SA6Dhae1BagEPDunCsGeyKxb6m39Pbpr8qF8pVWI4vXjuyF/lWSDNOgctACRowrpP/NtU3lgHhskNcPyaRKgQyKmk/n1ujcB6K01k8WkHSDScZc/mDNyov0Ew5a5mKTBYX1z3RSixQUjBB1AFI62W4Mst3+o9J0FLp+2l28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxHNKl2Jdq_K8HAA--.21730S3;
	Wed, 02 Sep 2026 16:04:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxRs2g2Jdq9mwZAA--.41017S2;
	Wed, 02 Sep 2026 16:04:50 +0800 (CST)
Subject: Re: [PATCH v2 0/2] LoongArch: KVM: Fix kvm_loongarch_env_init() error
 path
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
 zhaotianrui@loongson.cn, chenhuacai@kernel.org
Cc: kernel@xen0n.name, lixianglai@loongson.cn, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
 <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0fa4066b-81b5-d0e9-36f1-9f0cbadf1e2c@loongson.cn>
Date: Wed, 2 Sep 2026 16:04:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs2g2Jdq9mwZAA--.41017S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryfWw1DJF17Cry8Gw48AFc_yoW8uFyUpF
	y3uws8Kr4kKr1fArZIka4Duas8Xr4fGr4aqa42y345Cws8Xry0vr18tr9rZFyqv3y8GFW0
	qr1Sg34YgF1UZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==



On 2026/9/2 下午3:07, Chaithanya Lagisetty wrote:
> kvm_loongarch_env_init() leaves everything it has already acquired behind
> when one of the IPI/EIOINTC/PCH-PIC/DMSINTC device registrations fails, and
> kvm_loongarch_init() does not call kvm_loongarch_env_exit() on that error,
> so nothing else cleans up either.
> 
> v1 unwound only the memory and the perf callbacks. Bibo Mao pointed out
> that the device registrations should be undone through wrapped unregister
> helpers, so patch 1 adds those and patch 2 uses them to unwind the error
> path in reverse order of registration. Patch 2 also uses them in
> kvm_loongarch_env_exit(), so that the device ops are unregistered on normal
> teardown as well.
> 
> Link: https://lore.kernel.org/all/20260817115847.2705791-1-nagachaithanya9911@gmail.com/ [v1]
> 
> v2:
>   - Add unregister helpers as suggested by Bibo Mao
>   - Unwind device registrations in reverse order
>   - Use unregister helpers in kvm_loongarch_env_exit()
>   - Split into two patches, so the fix only uses the helpers
>   - Reword commit message to avoid implementation-specific details, and
>     retitle from "memory leak" to "resource leak"
> 
> Compile-tested only, no LoongArch hardware: loongson64_defconfig with
> CONFIG_KVM=m and CONFIG_KVM=y, W=1, each patch built individually, no new
> warnings.
> 
> Chaithanya Lagisetty (2):
>    LoongArch: KVM: Add unregister helpers for the KVM interrupt devices
>    LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error
>      path
> 
>   arch/loongarch/include/asm/kvm_dmsintc.h |  1 +
>   arch/loongarch/include/asm/kvm_eiointc.h |  1 +
>   arch/loongarch/include/asm/kvm_ipi.h     |  1 +
>   arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>   arch/loongarch/kvm/intc/dmsintc.c        |  5 ++++
>   arch/loongarch/kvm/intc/eiointc.c        |  5 ++++
>   arch/loongarch/kvm/intc/ipi.c            |  5 ++++
>   arch/loongarch/kvm/intc/pch_pic.c        |  5 ++++
>   arch/loongarch/kvm/main.c                | 32 +++++++++++++++++++++---
>   9 files changed, 52 insertions(+), 4 deletions(-)
> 
For this series:
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

