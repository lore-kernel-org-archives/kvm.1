Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436331F993
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097907; cv=none; b=RvzYpnjftOykCMAv5O9v6K7/b4Wy8PKSk4DgL3z17MLNRC45m1gYDo+ck2L9zj6NqUkoZQc+5NQqoNc3rW34j7Nhx0XE5oCA6H4x9z48idxIEdTgzzai1AzvaeIyGX1vj9WvPZfccg9dbtt9kBfU8TtAUhfB43Q+7l7LDgQA61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097907; c=relaxed/simple;
	bh=JkyMY/sgrPjWT9eBvFu/JdWUkcmlyKhHRSr3cA6Zprg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a3c805pYO5S3FzMI+gMloCHZAHJVH7POxcpWa+srvM4uAd0Zn8/o0F38ldHV3V85H38aOkQTCSKn6UA75POHopiNTuh3PpBpbJwjoj7tT9kVolzEdXNdYSxsntYV6m4WHTvAxCROphma+F4bEKv+s1/el5kwxfbLrE73kun4J6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/cg+s6Z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/cg+s6Z"
Message-ID: <307287c7-9f08-48d2-b238-ef83081570bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784097893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DiiSS3Xk0KtU3EIg267oZbsDRPjJKGw4ANPn0xW1mM=;
	b=K/cg+s6ZPlqsup+zL0UfxK29lJ7oSNJ4i/rtKbVKxmPIoxb5CqEEnKnoRW+IZsJ5HPKIl7
	s3wHtfmmwkKcbMJdZ+6QC69Gk8gtoO0ulWrVPrfwDjUAAkB6nchCmpJ71hCukAHvWSMncm
	09tRgpBJU1EX0fa6uHZCMPVNw1kt4i8=
Date: Wed, 15 Jul 2026 14:44:44 +0800
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
 <5c4f0ea6-b13c-4263-964f-cc4653c5cf6d@linux.dev>
 <7ce5c447-87b7-2e8f-9c58-af1d8a211f0a@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <7ce5c447-87b7-2e8f-9c58-af1d8a211f0a@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/15 14:21, Bibo Mao 写道:
> 
> 
> On 2026/7/15 下午1:53, Tao Cui wrote:
>>
>>
>> 在 2026/7/15 11:49, Bibo Mao 写道:
>>>
>>>
>>> On 2026/7/15 上午11:28, Tao Cui wrote:
>>>> From: Tao Cui <cuitao@kylinos.cn>
>>>>
>>>> kvm_restore_timer() rebuilds the remaining timer countdown from
>>>> vcpu->arch.expire, which is host-internal and is not part of the migrated
>>>> vCPU state. On the migration destination it is still 0, so for a one-shot
>>>> timer that has not expired yet the computed delta is 0 and
>>>> write_gcsr_timertick(0) injects the timer interrupt immediately instead of
>>>> after the remaining time. The guest observes a premature timer event right
>>>> after migration.
>>>>
>>>> The expired one-shot case (TVAL = -1) is already handled earlier, so only
>>>> the non-expired one-shot path is affected. When expire has not been set
>>>> (i.e. on the destination), reload the remaining countdown from the
>>>> migrated TVAL. The regular preempt/resume path on the source, where
>>>> expire is valid, is unchanged.
>>>>
>>>> Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>>> ---
>>>>    arch/loongarch/kvm/timer.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
>>>> index 3829f35a4070..57f53d19a00a 100644
>>>> --- a/arch/loongarch/kvm/timer.c
>>>> +++ b/arch/loongarch/kvm/timer.c
>>>> @@ -132,6 +132,14 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>>>>             * during injecting intr async
>>>>             */
>>>>            kvm_queue_irq(vcpu, INT_TI);
>>>> +    } else if (!expire) {
>>>> +        /*
>>>> +         * One-shot timer on the migration destination: vcpu->arch.expire
>>>> +         * is host-internal and is not migrated, so it is still 0 here.
>>> Good catch, I ever noticed this issue before however without good method. My previous method is to recalculate vcpu->arch.expire in function _kvm_setcsr() when LOONGARCH_CSR_TVAL is set and value of vcpu->arch.expire is 0.
>>>
>> Thanks for the review and for sharing your idea. I also considered
>> recalculating expire in _kvm_setcsr() when TVAL is restored, but ended
>> up keeping the change within kvm_restore_timer() to avoid touching the
>> core CSR write path. Both approaches are functionally equivalent since
>> the first save_timer() after restore will set expire correctly either
>> way.
>>
>> That said, if you prefer the _kvm_setcsr() approach, I'm happy to
> The problem in _kvm_setcsr() is that there is only register LOONGARCH_CSR_TVAL however no context of LOONGARCH_CSR_TCFG register, it seems that it is better in to restore it in kvm_restore_timer() function where all registers about CPU timer are set.
> 
> How about something like this, it should work with period timer mode when migration.
> @@ -119,6 +119,17 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>         delta = 0;
>         now = ktime_get();
>         expire = vcpu->arch.expire;
> +       if (!expire) {
> +             /*
> +              * The field vcpu->arch.expire is host-internal and is not
> +              * migrated, so it is 0 after migration. Reload the
> +              * remaining countdown from the migrated TVAL.
> +              */
> +               if (ticks < cfg)
> +                       delta = tick_to_ns(vcpu, ticks);
> +               expire = ktime_add_ns(ktime_get(), delta);
> +       }
> +

Thank you for the suggestion. I agree that kvm_restore_timer() is the
right place since all timer registers (TCFG/TVAL) are available there.

I've updated the patch to compute expire from the migrated TVAL before
the normal path, which also fixes the period timer case during migration.
Suggested-by added.

Will send v2 shortly.

Thanks,
Tao
>> rework the patch accordingly.
> ok, that is fine. Thanks for catching this issue.
> 
> Regards
> Bibo Mao
>>
>> Thanks,
>> Tao
>>> Regards
>>> Bibo Mao
>>>> +         * Reload the remaining countdown from the migrated TVAL instead
>>>> +         * of firing the timer immediately.
>>>> +         */
>>>> +        delta = ticks;
>>>>        }
>>>>          write_gcsr_timertick(delta);
>>>>
>>>
> 

