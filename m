Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50831440A2F;
	Mon, 28 Sep 2026 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580258; cv=none; b=edKjGNdvcEKst0EdSqJkmRsX4pkiEwD0Kbv9muq6NUDkyInHc/6XCdqKKO3rpVYJpCaQobxRR77vA8K+Po5cYTc67fe3VhA3OnF5UcET/su64Zjgmxgo7xaXGYhKWZezAZyCZS78RUm5WsloV2atBjOtF/icvVmLeNSDovemow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580258; c=relaxed/simple;
	bh=pTRrziAADNEo3SKTEZv+QdRm+LRgn0RQf61ooZ/Ph6I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M+nDgu/WRtciAyK6IeS5li0LJlXbaSowWWk87cMxN7hEnmtwyC3rS2L/8NSYmUgfkMORjuhUngQOr3/ZFECoQ3mlQxAKd6IgZWgHOGD/eIXdPXFAPPmPZo/6XUnuB5cdQxpyKoTTp1BZsh0JpxKbXIm4t1D5pVm1zoadHLdkKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cx_9IfFrpqoW4QAA--.48232S3;
	Mon, 28 Sep 2026 15:24:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxTs8eFrpqAv0lAA--.15195S2;
	Mon, 28 Sep 2026 15:24:14 +0800 (CST)
Subject: Re: [PATCH 5/6] LoongArch: KVM: Propagate real error code in
 kvm_pch_pic_create
To: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-6-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d3c94dd4-c449-82ca-981b-fcb1cc7c8003@loongson.cn>
Date: Mon, 28 Sep 2026 15:25:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260927075240.3007947-6-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs8eFrpqAv0lAA--.15195S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw1ftrWUGF1fWFWDKrWfWFX_yoWkAFc_Cr
	43KwnrWw48Ja1Uua1av3W8GF43XFs8JFZavr93Zry7G34DtrWDJr48Jw1ava4q9w48AFs8
	Ga4kJrZ0yFnFvosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=



On 2026/9/27 下午3:52, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_pch_pic_create() replaces the real error of
> kvm_setup_default_irq_routing() with a fixed -ENOMEM.  Return the
> actual code, as kvm_eiointc_create() already does; the kvm_ipi_create()
> case is fixed separately by "Return the actual error code in
> kvm_ipi_create()" (Chaithanya Lagisetty).
> 
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/pch_pic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index e33d6693c37c..136211f154d4 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -448,7 +448,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
>   
>   	ret = kvm_setup_default_irq_routing(kvm);
>   	if (ret)
> -		return -ENOMEM;
> +		return ret;
>   
>   	s = kzalloc_obj(struct loongarch_pch_pic);
>   	if (!s)
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

