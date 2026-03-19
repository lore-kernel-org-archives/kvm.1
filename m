Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1E3F0A9C
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941997; cv=none; b=XwPFc4bQyDO3jI/4bj9eu/jv4ovY9V0LT4LkH/sy0ctPPAY+M+o8A+/qy9Y+dg+b0oJbhEJpwWqjV1eZiVlu5rWe6S+AZikSnLj/IBTEMjJZPfz4tV5yRr7i/fxIsku8Z8deDNLALLy8XrLiEd5htBxy2G91Y7sesO1vb3N0rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941997; c=relaxed/simple;
	bh=zTMuINw8W8phBAzy0nG3RLE34S4gbnvq2zDkdk4Gu24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaN2vsFy9sqMegmrIFZE2Q2HEsnNgxLePoZoOLF/daCMBWCos8tfNQfMDEDjahwpY8jNCpnVPshj4BarayzdLY48LUtmukzoS6Vhq3Ve7OcABU39jVkXG2TIOYw5g4jsYeWhAVqMxJqFz6APraH1clRxQe43smNoS6W4OkV1va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UtGoAnIr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UtGoAnIr"
Message-ID: <27ce6795-1bb2-437f-a3a9-0589c1d65cdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773941980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSxHFEYoFillK/vghC83MQ1uH+vyR2Dj9tQeSVBrBRY=;
	b=UtGoAnIruJX7JI3e/I4TMz1seX8QDTYsVbZbOgAtJdFVhC6SNwApe9D1m1+SojpEFueKfP
	nJLzlLM1oukuALmSy0e05d5TKeRsXXpTxcsATT4MDfwe+vV1g9/GN/1OHAxdns0Q1ZxOSI
	1mKvJLPZbyk3oiCxhyExH9/UQdfiGOw=
Date: Thu, 19 Mar 2026 10:39:29 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RISC-V: KVM: Fix integer overflow in
 kvm_pmu_validate_counter_mask()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Jiakai Xu <jiakaiPeanut@gmail.com>
References: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/18/26 8:59 PM, Jiakai Xu wrote:
> When a guest initiates an SBI_EXT_PMU_COUNTER_CFG_MATCH call with
> ctr_base=0xfffffffffffffffe, ctr_mask=0xeb5f and flags=0x1
> (SBI_PMU_CFG_FLAG_SKIP_MATCH), kvm_riscv_vcpu_pmu_ctr_cfg_match()
> first invokes kvm_pmu_validate_counter_mask() to verify whether
> ctr_base and ctr_mask are valid, by evaluating:
>   !ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu))
>
> With the above inputs, __fls(0xeb5f) equals 15, and adding 15 to
> 0xfffffffffffffffe causes an integer overflow, wrapping around to 13.
> Since 13 is less than kvm_pmu_num_counters(), the validation wrongly
> succeeds.
>
> Thereafter, since flags & SBI_PMU_CFG_FLAG_SKIP_MATCH is satisfied,
> the code evaluates:
>   !test_bit(ctr_base + __ffs(ctr_mask), kvpmu->pmc_in_use)
>
> Here __ffs(0xeb5f) equals 0, so test_bit() receives 0xfffffffffffffffe
> as the bit index and attempts to access the corresponding element of
> the kvpmu->pmc_in_use, which results in an invalid memory access. This
> triggers the following Oops:
>   Unable to handle kernel paging request at virtual address e3ebffff12abba89
>    generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128
>    kvm_riscv_vcpu_pmu_ctr_cfg_match arch/riscv/kvm/vcpu_pmu.c:758
>    kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:49
>    kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>    kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>
> The root cause is that kvm_pmu_validate_counter_mask() does not account
> for the case where ctr_base itself is out of range, allowing the
> subsequent addition to silently overflow and bypass the check.
>
> Fix this by explicitly validating ctr_base against kvm_pmu_num_counters()
> before performing the addition.
>
> This bug was found by fuzzing the KVM RISC-V PMU interface.

Thanks for fuzzing. Do you have a detailed report that you can share ?

> Fixes: 0cb74b65d2e5e6 ("RISC-V: KVM: Implement perf support without sampling")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> ---
>   arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..a098a9b417ad8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -266,8 +266,10 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>   static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ctr_base,
>   					 unsigned long ctr_mask)
>   {
> -	/* Make sure the we have a valid counter mask requested from the caller */
> -	if (!ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu)))
> +	unsigned long num_ctrs = kvm_pmu_num_counters(kvpmu);
> +
> +	/* Make sure we have a valid counter mask requested from the caller */
> +	if (!ctr_mask || ctr_base >= num_ctrs || (ctr_base + __fls(ctr_mask) >= num_ctrs))
>   		return -EINVAL;
>   
>   	return 0;

Thanks for the fix.

Reviewed-by: Atish Patra <atish.patra@linux.dev>


