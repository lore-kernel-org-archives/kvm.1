Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAF3624C9
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166006; cv=none; b=GSJgm6MHO87b/AeGt8ZhhpMGOA4styazbhEbpVTDcTLAmh811+4REQyMDK9izuGX+KjvK7LcHamx2FFTRhgtLItwl3zjfkeslX+owHauinbOzA8dVVWp5ynUrz9wo5DgqCuWeMPxFbR6Rw2gsBw04QZOqtLTgrpz/97Y9PobzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166006; c=relaxed/simple;
	bh=LtL4dKR17MxcHpQnJgQbUWi7Lxy8UUcxFoB3RAaXA7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2TqQtm+Gscn1/V+bazGk8TDNo5N9xLkkSvysvnuBRLBHmeqkcWXCRRYsaxAjZb2MQLCoydydFdvWdwoup0tACxXUdI8Mw9GTY7SDG4/9AY8OJQoRkfirzeCtzyiNoTGWscaoK+1aG89aUfVZ26Jz49jNwfS4tXrZPpgwaEw4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MovG2GY2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MovG2GY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VLrNFBb+HkD4+F2K1pz6M+GL9jAEqixZHMEFWb9Etys=;
	b=MovG2GY2kqGN2SLUCxG5FI4sMlC1of5cbbUzw3iUZJcIy0hndxphkHo8UwTAaW
	AaJZwMkO5nfRrmqOHPbDl0tvNW0qTdxKlGRsvCUm3f9QHW7XqT023SythxCTIMrW
	uPVnIx6PF8A+5bKLlQ08ad+x+h1gvbDPAHuYfE3Hxed0Y=
Received: from [10.42.12.49] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCn5Z9kP5VqnHvgTA--.1543S2;
	Mon, 31 Aug 2026 16:46:28 +0800 (CST)
Message-ID: <1bb7c920-e891-4cfd-ae47-15056ceecc5a@163.com>
Date: Mon, 31 Aug 2026 16:46:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: riscv: Fix NACL hfence entry update order
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260826075009.68952-1-min_halo@163.com>
 <20260826080204.09A0C1F000E9@smtp.kernel.org>
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <20260826080204.09A0C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn5Z9kP5VqnHvgTA--.1543S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF13WryfKw18tF45tw1kZrb_yoWrXFyrpF
	Wftay8KF4rKr1fKwn7Zws7ZrWag3ZYgFy5Gw15ZF1Uuws8ZryFvwnFqFZ8uF95Jw1UWw10
	yr4jkFyvvFn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zROeOJUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0QTolGqVP2QyzAAA3z


在 2026/8/26 16:02, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Using `smp_wmb()` instead of `dma_wmb()` or `wmb()` to synchronize with a hardware device or external agent.
Agreed. This shared memory is read by an external agent (SBI firmware or 
NACL hardware), not only host CPUs.
Since arch/riscv KVM can be built without CONFIG_SMP, `smp_wmb()`
would fall back to a pure compiler‑only barrier() on !SMP builds,
without emitting any hardware fence instruction.
I will replace `smp_wmb()` with `wmb()` in v2, which unconditionally
provides the required ordering guarantee across all kernel configurations.
>
> Pre-existing issues:
> - [High] The retry loop in `__kvm_riscv_nacl_hfence` can spin indefinitely because `try_count` is never decremented.
> --
Already fixed by commit e971f19e4c82 ("KVM: riscv: Fix infinite loop in 
NACL hfence entry allocation").
The code snippet referenced in the AI review corresponds to an older 
version and does not match the current source tree.
>
> commit 7e01a77077e49fef54c573574fad3624c0817345
> Author: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> KVM: riscv: Fix NACL hfence entry update order
>
> The commit fixes the order in which nested HFENCE entries are populated
> by writing the page number and count first, then the config word. It uses
> WRITE_ONCE() and smp_wmb() to prevent hardware or firmware from observing
> incomplete entries.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the retry logic in
> arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence():
>
>      if (ent < 0) {
>          if (try_count) {
>              nacl_sync_hfence(-1UL);
>              goto again;
>          } else {
>              ...
>
> Does this loop run indefinitely? I noticed try_count is initialized to 5
> but doesn't appear to be decremented anywhere in this path. If the NACL
> hardware or SBI implementation stalls and fails to clear pending entries,
> could this cause a host CPU soft lockup?
>
>> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
>> index 08a95ad9ada2c..f922e9f62fee3 100644
>> --- a/arch/riscv/kvm/nacl.c
>> +++ b/arch/riscv/kvm/nacl.c
> [ ... ]
>> @@ -42,12 +42,24 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>>   		}
>>   	}
>>   
>> -	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
>> -	*entp = cpu_to_lelong(control);
>> +	/*
>> +	 * Per SBI v3.0 section 15.1.2, the Page_Number and Page_Count
>> +	 * words must be updated before the Config word with its Pending
>> +	 * bit set. WRITE_ONCE() stops the compiler from reordering the
>> +	 * stores and smp_wmb() makes the parameter words globally
>> +	 * visible to the SBI implementation (or NACL hardware) before
>> +	 * the Pending bit is set.
>> +	 */
>>   	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
>> -	*entp = cpu_to_lelong(page_num);
>> +	WRITE_ONCE(*entp, cpu_to_lelong(page_num));
>>   	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
>> -	*entp = cpu_to_lelong(page_count);
>> +	WRITE_ONCE(*entp, cpu_to_lelong(page_count));
>> +
>> +	/* Ensure the parameter words are visible before the Pending bit */
>> +	smp_wmb();
>> +
> [Severity: High]
> Does smp_wmb() provide the necessary hardware ordering guarantees on all
> configurations?
>
> Looking at arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence(), since the
> memory is coherent and shared with an external agent or NACL hardware, I am
> concerned about non-SMP kernel builds (!CONFIG_SMP) where smp_wmb()
> degrades to a simple compiler barrier (barrier()) and emits no actual
> hardware fence instructions.
>
> Would it be safer to use dma_wmb() or wmb() here to ensure the memory
> ordering is strictly enforced against external hardware, regardless of
> the kernel's SMP configuration?
>
>> +	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
>> +	WRITE_ONCE(*entp, cpu_to_lelong(control));
>>   }
>>

