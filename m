Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDBA3546FD
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094832; cv=none; b=p6SFKPMk6M45qF/2OYIZ4xKkd58A4uzWeUI/wjX5blUErYIZDyg3V9q6gXMZ3LMC2OlZTE+saienk8qDQDp/5w1XZuHkv2IPf3HBUDwXOweDippxtQ1URK/MLxNxX/gbcF+HjyhIhWZLUiYMRJ/glHcXbWjPYAGF9xPwS6RyG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094832; c=relaxed/simple;
	bh=mh1vCbq0AjnG2jjglQrce4FGyktG13wVT2zI0y1Swhk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oOu03brRsyV6FFjJ2GOVt6Hv/aJG6aWFIM5QUQ84IDs4x5YV0bXekX/KIbzeqDzM8TkXpRhDmLyvo0taJx97zn/UZHDo860eM4D8Mn3B5kaeGE3WGYvB294TW9vWZv8ZCdPMZxqZciCgXNo+46WmQlJZvWP0OqIVbL0Gnp40EHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BeDlWy/0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BeDlWy/0"
Message-ID: <5c4f0ea6-b13c-4263-964f-cc4653c5cf6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784094826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+scqyocUQL7GsnyVGF39blNq5Nv51aV4mHYAk+g538=;
	b=BeDlWy/04CNtpBUg/5Z0ZA7jYM2UVVNXEzawfTnPK1umlI+99iw/+LPQX/lRKftUbtjqss
	fdj1HMwb0uo87PLqLth8gJf6ELWmrwjyreUhCQXyLjBFenatpxE4JEN/bzI01uuETJu3Tb
	SzXVUfErW4oecSdro13eZ3w51ak/mvk=
Date: Wed, 15 Jul 2026 13:53:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, chenhuacai@kernel.org, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, lixianglai@loongson.cn, cuitao@kylinos.cn
Subject: Re: [PATCH] LoongArch: KVM: Reload one-shot TVAL on migration
 destination
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn
References: <20260715032831.1411664-1-cui.tao@linux.dev>
 <a93bc0fe-58b9-f5af-aefb-f5659e54304f@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <a93bc0fe-58b9-f5af-aefb-f5659e54304f@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/15 11:49, Bibo Mao 写道:
> 
> 
> On 2026/7/15 上午11:28, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> kvm_restore_timer() rebuilds the remaining timer countdown from
>> vcpu->arch.expire, which is host-internal and is not part of the migrated
>> vCPU state. On the migration destination it is still 0, so for a one-shot
>> timer that has not expired yet the computed delta is 0 and
>> write_gcsr_timertick(0) injects the timer interrupt immediately instead of
>> after the remaining time. The guest observes a premature timer event right
>> after migration.
>>
>> The expired one-shot case (TVAL = -1) is already handled earlier, so only
>> the non-expired one-shot path is affected. When expire has not been set
>> (i.e. on the destination), reload the remaining countdown from the
>> migrated TVAL. The regular preempt/resume path on the source, where
>> expire is valid, is unchanged.
>>
>> Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   arch/loongarch/kvm/timer.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
>> index 3829f35a4070..57f53d19a00a 100644
>> --- a/arch/loongarch/kvm/timer.c
>> +++ b/arch/loongarch/kvm/timer.c
>> @@ -132,6 +132,14 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>>            * during injecting intr async
>>            */
>>           kvm_queue_irq(vcpu, INT_TI);
>> +    } else if (!expire) {
>> +        /*
>> +         * One-shot timer on the migration destination: vcpu->arch.expire
>> +         * is host-internal and is not migrated, so it is still 0 here.
> Good catch, I ever noticed this issue before however without good method. My previous method is to recalculate vcpu->arch.expire in function _kvm_setcsr() when LOONGARCH_CSR_TVAL is set and value of vcpu->arch.expire is 0.
> 
Thanks for the review and for sharing your idea. I also considered
recalculating expire in _kvm_setcsr() when TVAL is restored, but ended
up keeping the change within kvm_restore_timer() to avoid touching the
core CSR write path. Both approaches are functionally equivalent since
the first save_timer() after restore will set expire correctly either
way.

That said, if you prefer the _kvm_setcsr() approach, I'm happy to
rework the patch accordingly.

Thanks,
Tao
> Regards
> Bibo Mao
>> +         * Reload the remaining countdown from the migrated TVAL instead
>> +         * of firing the timer immediately.
>> +         */
>> +        delta = ticks;
>>       }
>>         write_gcsr_timertick(delta);
>>
> 

