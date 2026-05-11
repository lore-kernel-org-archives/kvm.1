Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1830C62E;
	Mon, 11 May 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483216; cv=none; b=mo4tXbglerXQLvdcgdkUAzKJupNZLrqVPlcsjNBdyaDel7+xYWtkx3U5WIP6dtr8Oo8TN7d02oB1Jqf44g4RcD9ZzMbXQ0HmuNnqI+NbW/0AuFaPfhm70NPhKxXdx6WN9DMNY60zqt7JxY49waEkDIZ1514y3uhdyFx9GnJHBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483216; c=relaxed/simple;
	bh=DzY3vVqr/7DSs0lBAsbK1QIH9OFYtM3cIXdiQty5+AM=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NQ0YiwfKyv5yEZZ26+225Nc+Luv9GZMzGa8ena5sodKQ0o1J0z0x7eM36IFDS4icy0SWqbkqxlka/SQp6TztJZrWN0Q8vrL4fKWVxdmEzdY09i92RcaOLr+y8n+6IxrySWAlL0WHGanyQrDNN353jwUIzjLZWTF4E4nL3dYjObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxVegJgAFqeI4IAA--.20628S3;
	Mon, 11 May 2026 15:06:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDx6+AJgAFqk+p+AA--.45507S3;
	Mon, 11 May 2026 15:06:49 +0800 (CST)
Subject: Re: [PATCH 0/5] Small enhancement about interrupt injection
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260511065146.680650-1-maobibo@loongson.cn>
Message-ID: <96f15a3c-5401-d654-6a4a-0a5d41a1bafa@loongson.cn>
Date: Mon, 11 May 2026 15:03:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260511065146.680650-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+AJgAFqk+p+AA--.45507S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF1fAFy8Kr1DXF1kuFyfAFc_yoWDurc_WF
	1Iya45uw48GF4UtFyFvr9ay34DGr48XrWftanF9r4xWwnrAr93GF1DZF13ZryS9rWUJrs8
	JrZ8tr1fZry2gosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

Soryy, that is too quick.
The tile of this patchset should add "LoongArch: KVM:"

Regards
Bibo Mao

On 2026/5/11 下午2:51, Bibo Mao wrote:
> Here make intterupt status acquire interface simpler, add new interface
> kvm_vcpu_sync_intr() to sync pending interrupt to software ESTAT
> register, and remove expensive vcpu_load() and vcpu_put() function call.
> 
> Also interrupt inject is handled with batch method, rather one by one.
> 
> Bibo Mao (5):
>    LoongArch: KVM: Check msgint feature in interrupt post
>    LoongArch: KVM: Use existing macro about interrupt bit mask
>    LoongArch: KVM: Clear interrupt with batch mode
>    LoongArch: KVM: Deliver interrupt with batch method
>    LoongArch: KVM: Simple interrupt status acquire interface
> 
>   arch/loongarch/include/asm/kvm_vcpu.h |  40 +++++---
>   arch/loongarch/kvm/interrupt.c        | 140 +++++++++++++-------------
>   arch/loongarch/kvm/vcpu.c             |  22 ++--
>   3 files changed, 106 insertions(+), 96 deletions(-)
> 
> 
> base-commit: 917719c412c48687d4a176965d1fa35320ec457c
> 

