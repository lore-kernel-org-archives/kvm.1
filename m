Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388741A5B9E;
	Wed, 27 May 2026 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862804; cv=none; b=i/6EhwTU+K6DSS8pI1qUPHYTZX65som+o4UsBMKGOsqwshmgJIE5GGYOWEBohylxjsz+8foHLDQRNGf3UF8fNpLoeLsplCshaAE6F96l6X+mWLs1YT+pZSPMgMqRUXtPFdg3bYgpS4TXPfvOFEmNlzfSiSoMn+4R9zaLQ6Ou5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862804; c=relaxed/simple;
	bh=Dc4bmFMHioCyNUCDB8qvw8hFLzO7OBv/AaO8yAqhk8Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nhsdtM8V3RWxlTASXg/iQVRxC1ng11JqOC7EeuRIcZ9a2C0Xw3kQ9aEMwzLs2JIzBnfv5/MmMlLWZRcX5BhFs9dwslVfjOpRDjKKZsIJ2k3kf+TlFlNbsiC+qA56a/rcFBB1cBqGIyaGTL43PoCondahGLGnkHlaWe9hhBclod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxrcAOjRZqIqwNAA--.15213S3;
	Wed, 27 May 2026 14:19:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxKMEHjRZqDHySAA--.1572S3;
	Wed, 27 May 2026 14:19:52 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Check return values for put_user
To: Qiang Ma <maqianga@uniontech.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260526074202.789799-1-maqianga@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <cd6fa852-5893-2dd9-bff9-2a773ab85cf9@loongson.cn>
Date: Wed, 27 May 2026 14:16:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526074202.789799-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMEHjRZqDHySAA--.1572S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw1kKrW3uFy3KFy5JrW3XFc_yoW3Wrg_XF
	1Skwn3WrW8Ja1DXw1vg34rCry3Jw18JFsY9as8Zr97J3s5Jrsxurs7W3ZxAr1q9rWUCan8
	GFZ8Cr9xCryYqosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=



On 2026/5/26 下午3:42, Qiang Ma wrote:
> put_user() may return -EFAULT, so, when the user space address
> is invalid, it should return -EFAULT.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   arch/loongarch/kvm/vcpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 782dc1a36e29..67441edf0e1f 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1104,7 +1104,8 @@ static int kvm_loongarch_cpucfg_get_attr(struct kvm_vcpu *vcpu,
>   		return -ENXIO;
>   	}
>   
> -	put_user(val, uaddr);
> +	if (put_user(val, uaddr))
> +		return -EFAULT;
>   
>   	return ret;
>   }
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

