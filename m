Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626E26738C;
	Thu, 16 Jul 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182479; cv=none; b=hDXCGTSx8D+Goj0g3UUN79DCT3FN53sDDBb88HK3+RBGT+EEloCD4R3595Ud7AfC5gNrUn2HRV0Ny7YWOSAI9Ac5KDVq3HVcZoz3Mnq6/QHM6qufvnXO1M9UyulHVvXKuRI1lVFKLZW9rXALhiyw+FzM4gDj46UL3AcibKei5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182479; c=relaxed/simple;
	bh=f63iR1haWxdrEVsqm6P3FDj68FEMPMBgw1UodpktTCg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GUIyZ6fAlp8kpWH25PK127SpAF1pNRq5CLT0TFDJPCvbD+cfQtW3R/qY/RuweBYa62UOn7oEspfu1aZ8lj3sJcQDO6tTmieFv66r+h3k0xSosIvvCpcFNIYMdgWyeoVeoEga8wCyAOG3as7ZvoRqJqYkgB66R80x12qfHk5PMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxOOvLdlhqLxcEAA--.16488S3;
	Thu, 16 Jul 2026 14:14:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxEuTKdlhqSq0OAA--.6405S2;
	Thu, 16 Jul 2026 14:14:34 +0800 (CST)
Subject: Re: [PATCH v3 2/2] LoongArch: KVM: Prevent division by zero in
 periodic timer restore
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, cuitao@kylinos.cn
References: <20260715100640.1454413-1-cui.tao@linux.dev>
 <20260715100640.1454413-3-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <82dba701-e64a-e20d-fea0-203192995805@loongson.cn>
Date: Thu, 16 Jul 2026 14:14:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260715100640.1454413-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuTKdlhqSq0OAA--.6405S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr15uF1Uuw1kXw43tryfKrX_yoWkuFg_WF
	ZrJa4kArW3Jw10yFnFkas3C3yxKw1qya4rCry7Wrsrta98tws8Zr4UX3WrAF97KrWDWFZ3
	ArWDJ3sxCwn0qosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EeHDUUUUU==



On 2026/7/15 下午6:06, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> A guest can write CSR_TCFG with the periodic bit set but a period value
> of zero.  When kvm_restore_timer() later enters the periodic branch,
> period = cfg & CSR_TCFG_VAL evaluates to 0, causing delta % period to
> trigger a division by zero and crash the host kernel.
> 
> Clamp the period to 1 to avoid the panic.
> 
> Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/timer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
> index 96f33e34855a..524d4096bac0 100644
> --- a/arch/loongarch/kvm/timer.c
> +++ b/arch/loongarch/kvm/timer.c
> @@ -135,6 +135,8 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>   		delta = ktime_to_tick(vcpu, ktime_sub(expire, now));
>   	else if (cfg & CSR_TCFG_PERIOD) {
>   		period = cfg & CSR_TCFG_VAL;
> +		if (!period)
> +			period = 1;
>   		delta = ktime_to_tick(vcpu, ktime_sub(now, expire));
>   		delta = period - (delta % period);
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

