Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA01F16B
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158691; cv=none; b=dVFIDPtuqzFfDi8Is8IDtD68Y5OKTFsrRq1POw+B1Lu45e68/TIixdPDbLKtQYP5NAvQMYfJBOUwrc335iqyoitpV/fiMF+gQ7kPsJDz5yOeGGZAPWRuIHbr9EDxiwEZ2lL6ixjLerusck/CBQ6nyUT95CHFdc2nZD33wHojsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158691; c=relaxed/simple;
	bh=taYV8ip3HYX017n+fLy+sGpTkBIlklQhY8Wl79DuX2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQxs6Ra3gz4k15Rqado9+qtYY/vPjvodUJqsWaVA1G3aqZgRcVFIU8FFTPbi08oxQBaUCf+FAxZubtuVypycKSJgfbWvB51gmJ3cGoXp8zsHftBhlac72fHvdASzb5M3YkYelC8l6O6uHoYtcciXossx3LRKeo79+FRaJIC9MjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GldzoT8B; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GldzoT8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Tz5alX+HaI6xug9ngSXJqyUnMaYjDwjMcSK6cXv1pMw=;
	b=GldzoT8B8M797j8UuzwaBhOoTFNH4kvkIA8waHpnKKgnSqEIyAZUvuYCB0rpkj
	SI5kRTv0WdpBHOFtgxNo5MwEPg1SDwFpj2Af7E2saeEP7ylWQogtpV/+MOy/NsVM
	5XEVf4OHGWYRAaeCEg4mQnqoJ1MNy3rdabM9ejr4nn+go=
Received: from [10.42.12.49] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3015LIpVqDOd_Sg--.7758S2;
	Mon, 31 Aug 2026 14:42:20 +0800 (CST)
Message-ID: <e09baa74-368a-40b7-8e7e-44d1f6cf0968@163.com>
Date: Mon, 31 Aug 2026 14:42:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in
 snapshot_set_shmem
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260826064117.58029-1-min_halo@163.com>
 <20260826065551.DC6791F000E9@smtp.kernel.org>
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <20260826065551.DC6791F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3015LIpVqDOd_Sg--.7758S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF17Ar15Kr1UJw1xWF1ftFb_yoW5urWDpF
	WfCayYqrs5tw10k34DZF4ktFyUArZ8WrZ8GFnxGryrCws8Cr15Ars7KFWrua1Yyw48W392
	qr45CFykAFs0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5GYJUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0gybR2qVIkwgrQAA3e


在 2026/8/26 14:55, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Guest-triggerable `pr_warn` allows a malicious guest to spam the host kernel log.
> --
>
> commit 26a57cbd434dd543af868b0052521f7a8fda7faa
> Author: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
>
> A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call overwrites
> kvpmu->sdata without freeing the old buffer, and if a later guest write
> fails, the error path frees sdata but leaves snapshot_addr stale. This
> clears the previously installed snapshot area before installing a new one.
>
>> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
>> index 752f1014d633e..14f73490f12cb 100644
>> --- a/arch/riscv/kvm/vcpu_pmu.c
>> +++ b/arch/riscv/kvm/vcpu_pmu.c
>> @@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Clear any previously installed snapshot area to avoid leaking
>> +	 * the old sdata and to keep sdata/snapshot_addr consistent if
>> +	 * the re-install fails below.
>> +	 */
>> +	if (kvpmu->snapshot_addr != INVALID_GPA)
>> +		kvm_pmu_clear_snapshot_area(vcpu);
>> +
>>   	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT);
>>   	if (!kvpmu->sdata) {
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the PMU
> snapshot code I noticed a pre-existing issue in the same file.
>
> In kvm_riscv_vcpu_pmu_ctr_start(), a guest can intentionally trigger a host
> kernel log spam if the shared memory becomes invalid:
>
>          if (kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
>                                  sizeof(struct riscv_pmu_snapshot_data))) {
>                  pr_warn("Unable to read snapshot shared memory while starting counters\n");
>                  sbiret = SBI_ERR_FAILURE;
>                  goto out;
>          }
>
> Because this pr_warn() is unconditional and not rate-limited, a guest can
> configure a valid snapshot area, invalidate the backing memory, and repeatedly
> call SBI_EXT_PMU_COUNTER_START to spam the host log, leading to a denial of
> service.
>
> Should this pr_warn() be converted to a rate-limited print, or perhaps dropped
> since the error is already returned to the guest?
Thanks. Note this is a pre-existing issue unrelated to this patch.

The printk hygiene concern is fair, though the flagged path is not
actually guest-triggerable: snapshot_addr is installed only after
kvm_vcpu_write_guest() succeeds, and a later kvm_vcpu_read_guest() on
that GPA can only fail if the (trusted) VMM removes or remaps the
host-side mapping -- the guest has no control over the memslots.
If I'm missing a path, happy to be corrected.

The clearly guest-triggerable one is pr_warn("Invalid counter id ...")
in pmu_ctr_read(): cidx comes straight from the 
SBI_EXT_PMU_COUNTER_FW_READ ecall,
so a guest can loop it without any VMM involvement.
The same applies to the similar warning in pmu_fw_ctr_read_hi() on RV32.

If desired, I can send a separate cleanup patch converting those to
pr_warn_once() (as already used in this file), pr_warn_ratelimited(),etc.
>

