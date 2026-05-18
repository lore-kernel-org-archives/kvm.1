Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CE4508E0;
	Mon, 18 May 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108927; cv=none; b=guV/aiXCuVh6ElqPqreRtQ9DI+Xk92yoD96kvEp380yjzDHjpmEpuPHKmQQf1MgP+4YMtPIGgCNPaHK1pG1zMp/799TYQFZ8l9sXRiW8ZZYXz32VJwz5qLBc7l5+XR2PMHNDdRapnivHH2lNzEEvqweQIk8ZhwDV+MlBOKC7r2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108927; c=relaxed/simple;
	bh=TsnwzaRYKCZk9fAfCvB6ylKKPgnmH6O40n1/23cglBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1nGeppu+T4kLKR337lOX15aBJZz4Ybht1R2QtlS24YmdecCVCeKwJZ3lUpkbAnwbSocr3A8Psl7j6jg0GpqMeVTwQAZkBhZ6nM3VjxArtWEKL+4uS6mwrSch/k2AMAYHgifw6LjzymWSLs0ZkyW239LRByPutQ7++V5anqqeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lC427nXP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lC427nXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=CrDEAo7psewF/Zo6NTuk77pv1DJdNaLBNAD0ghaWzHc=;
	b=lC427nXPvIjwiNmYFg/EZ/bY2f01kkqizgwT6ZxEcbkcVrzaAjXF5M7SV+IYPV
	sXbPF76d/xj+TKNqP2aVu90z3McknrtM8SAd+IYUYWZY0ea6E6q1c6IlTl63PiPj
	r+E/5byfzxXrboWTXGYok4Hd1XL2GITtdX1Je6vcqI/Mc=
Received: from [IPV6:240e:38c:8516:b200:791b:8dc7:75fb:a430] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnp4GVCwtqUaZZDw--.170S2;
	Mon, 18 May 2026 20:52:40 +0800 (CST)
Message-ID: <22e32ff9-3d79-4130-a3cb-3a4ec2efd498@163.com>
Date: Mon, 18 May 2026 20:52:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: selftests: Add unit to dirty_log_test
To: Sean Christopherson <seanjc@google.com>
Cc: wu.fei9@sanechips.com.cn, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, shuah@kernel.org
References: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
 <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn>
 <agO_0ejKd0x38_-E@google.com> <f64029bf-1f4c-40a7-860a-eb04fbe5317b@163.com>
 <agck1WqW-TyEqkqd@google.com>
Content-Language: en-US
From: Wu Fei <atwufei@163.com>
In-Reply-To: <agck1WqW-TyEqkqd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgDnp4GVCwtqUaZZDw--.170S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4kKFyrCrWfWw18Cw4rZrb_yoW7AFWDpF
	WSga47KFs7A345Cwn2yayDXryFkr43JFWDA34rt3s0k3s0gF1fXr1xKFy09F95Cr1rZr1S
	vrZ0q347Zr1DuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYD7-UUUUU=
X-CM-SenderInfo: pdwz3wlhl6il2tof0z/xtbCzRlG52oLC5nAxgAA3A

On 5/15/26 21:51, Sean Christopherson wrote:
> On Wed, May 13, 2026, Wu Fei wrote:
>> On 5/13/26 08:03, Sean Christopherson wrote:
>>> On Mon, May 11, 2026, wu.fei9@sanechips.com.cn wrote:
>>>> Currently dirty_log_test hardcodes usleep 1ms in each interval, which
>>>> could be too short for guest to write and fault in enough pages, then
>>>> there is less chance to test the write protection mechanism, especially
>>>> in the case of (log_mode != LOG_MODE_DIRTY_RING).
>>>
>>> But when log_mode != LOG_MODE_DIRTY_RING, the individual sleep time is largely
>>> meaningless, because the test won't reap the bitmaps for iterations > 0.
>>>
>>> 			if (i && host_log_mode != LOG_MODE_DIRTY_RING)
>>> 				continue;
>>>
>> The first usleep  matters in the case of KVM_DIRTY_LOG_INITIALLY_SET. The
>> dirty bitmap is not precise in the first get_dirty_log, all pages are marked
>> as dirty but most of them are not populated in page table, this creates the
>> situation I mentioned in the cover letter.
> 
> I suspect something is messed up in your workflow, because the actual patches
> aren't properly threaded with respect to the cover letter.  E.g. patch 1 has
> 
>    In-Reply-To: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
> 
> but the cover letter has:
> 
>    Message-Id: <202605111108.64BB8RFR010522@mse-db.zte.com.cn>
> 
> Copy+pasting the entirety of the cover letter for reference:
> 
>   : The current gstage range walker unconditionally advances by 'page_size'
>   : when a leaf PTE is not found, e.g. when the range to wp is
>   : [0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
>   : returns false and page_size is 2MB, it skips the whole range, but it's
>   : possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
>   : only [0xfffff01fc000, 0xfffff0200000) can be skipped safely. Both
>   : wp/unamp have the same pattern.
>   :
>   : dirty_log_test intentionally sets up the unaligned guest physical
>   : address, after riscv kvm enabling KVM_DIRTY_LOG_INITIALLY_SET, it's easy
>   : to trigger this bug if there is a larger window for guest to write more
>   : pages before first collect_dirty_pages.
> 
>> "when the range to wp is
>> [0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
>> returns false and page_size is 2MB, it skips the whole range, but it's
>> possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
>> only [0xfffff01fc000, 0xfffff0200000) can be skipped safely."
>>
>>>>
>>>> Unit is introduced to replace the default 1ms if specified in command
>>>> line. The following test can't trigger failure on my riscv vm:
>>>
>>> Failure of what?  And does the failure really not reproduce with a higher interval?
>>
>> On riscv, it fails to write protect some pages with valid page table entry
>> then loses track of dirty pages. Higher interval doesn't help because only
>> the first usleep matters, after the first collect_dirty_pages, all dirty
>> pages are tracked precisely then there is no such problem.
> 
> Ah, gotcha.  Rather than let (and force) the user to provide a larger sleep time,
> what if we instead randomize the delay before the initial reaping of the dirty
> bitmap/ring?  That should provide a good balance between coverage, complexity and
> user-friendliness.

I'm fine with your solution, I applied it and it did trigger the same issue.

Thanks,
Fei.

> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 12446a4b6e8d..74ca096bf976 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -694,7 +694,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>          pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
>   
>          for (iteration = 1; iteration <= p->iterations; iteration++) {
> -               unsigned long i;
> +               unsigned long i, reap_i;
> +
> +               /*
> +                * Select a random point in the time interval to reap the dirty
> +                * bitmap/ring while the guest is running, i.e. randomize how
> +                * long the guest gets to initially run and thus how many pages
> +                * it can dirty, before collecting the dirty bitmap/ring.  See
> +                * the loop below for details.
> +                */
> +               reap_i = random() % p->interval;
> +               printf("Reaping after a %lu ms delay\n", reap_i);
>   
>                  sync_global_to_guest(vm, iteration);
>   
> @@ -729,13 +739,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                           * that's effectively blocked.  Collecting while the
>                           * guest is running also verifies KVM doesn't lose any
>                           * state.
> -                        *
> +                        */
> +                       if (i < reap_i)
> +                               continue;
> +
> +                       /*
>                           * For bitmap modes, KVM overwrites the entire bitmap,
>                           * i.e. collecting the bitmaps is destructive.  Collect
> -                        * the bitmap only on the first pass, otherwise this
> -                        * test would lose track of dirty pages.
> +                        * the bitmap while the guest is running only once,
> +                        * otherwise this test would lose track of dirty pages.
>                           */
> -                       if (i && host_log_mode != LOG_MODE_DIRTY_RING)
> +                       if (i > reap_i && host_log_mode != LOG_MODE_DIRTY_RING)
>                                  continue;
>   
>                          /*
> @@ -745,7 +759,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                           * the ring on every pass would make it unlikely the
>                           * vCPU would ever fill the fing).
>                           */
> -                       if (i && !READ_ONCE(dirty_ring_vcpu_ring_full))
> +                       if (i > reap_i && !READ_ONCE(dirty_ring_vcpu_ring_full))
>                                  continue;
>   
>                          log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,

