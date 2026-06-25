Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA315377004
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371746; cv=none; b=l4coxnBD4T5++c7z/73jGmqD+UhvCTPoLeG3J4bp4NmXlkHT8Ex9AqxA1S7DaC0t9R4P9TeUWaD2mNTiIq3pXXq0kaq0b4dQ2XYLqriv4p/hOsUxa8KEZrW1u7G7G4225rF+uRMBI8hBFMxpw5KBaN1k6a5o5rfKcqtOl2XleZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371746; c=relaxed/simple;
	bh=3jxl8WvXJzWmZ6mb3yKgKPh8bX2T1pCjW/L8efSc798=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HbaIIc5v1klmW54vDTCpgoDNyjmanmqZPC1ZH6bvZuPLmxJvEwXEdEJV6hZfbne0So4eaoUgF9Ac3OOt/K0XqnmfdiOlGQBzl38GPL+/RmXlzhcvCriGktZMllPbjAMc0akF9CQvudqkGykJwHyy/xtQG+Vz5Y19ZfnRtdKl2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MwEuoEnZ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MwEuoEnZ"
Message-ID: <013459e1-f817-42b5-a0fd-20b38d9b6140@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782371732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EB9lIcTVf5g4cHke/c3/iHfKqDrGDzB7JmDY9CPXhI=;
	b=MwEuoEnZoJoJdPMiuTTgGkfDdj6qb0qVMgsgxQi3Ltz65voR6SihEdC2sFkjtzeBH8X+Vx
	KcrzsWCFSE4VsNyKFbP0OhwsuV4UKkfPkH0JtGehi7uknPCPgjWfhcEgYJP5MLUWx6v2UU
	lWrlpjf7msGFzb9RjXq9FOUBGjtKYIo=
Date: Thu, 25 Jun 2026 15:15:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kernel@xen0n.name, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4 2/3] LoongArch: KVM: Implement guest-side PV TLB flush
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-3-cui.tao@linux.dev>
 <0c47ce21-9a4d-4cdc-9bec-ce749e31512e@loongson.cn>
 <1bfa4941-b94b-410a-9b64-c13f2712edf9@linux.dev>
 <9ec9d22b-93fd-3dcb-c6b8-19563f1b7c0a@loongson.cn>
 <404180d0-c734-4465-8752-f43279730692@linux.dev>
 <6f837e00-e606-ddaa-b22b-dd30348a18fb@loongson.cn>
 <084d7bec-592c-31b5-aa44-099bff87af9a@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <084d7bec-592c-31b5-aa44-099bff87af9a@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/25 14:11, Bibo Mao 写道:
> 
> 
> On 2026/6/25 上午11:31, Bibo Mao wrote:
>>
>>
>> On 2026/6/25 上午10:27, Tao Cui wrote:
>>>
>>> Hi Bibo,
>>>
>>> 在 2026/6/17 09:05, Bibo Mao 写道:
>>>>
>>>>> Rather than argue from intuition, I'd like to try the hypercall approach
>>>>> you suggested and measure the performance improvement against the current
>>>>> path. I'll share the results with you once the testing is done, so we
>>>>> can decide the direction based on the numbers.
>>>> well, that is the best. It is my pleasure to discuss this with you.
>>>>
>>>
>>> A quick update on the testing. I put both the hypercall and the
>>> steal-time variants through two benchmarks on an 8-core host with a
>>> 4:1 overcommitted guest (32 vCPUs), and wanted to share where things
>>> stand.
>>>
>>> The two workloads:
>>>   - ebizzy (all threads busy, mm-flush heavy)
>>>   - tlb_bench in sleep-idle mode (1 flusher + 31 sleeping idle threads,
>>>     so the idle vCPUs get preempted)
>>>
>>> ebizzy (records/s, higher is better), 32 vCPUs:
>>>    no-PV       ~103,737
>>>    hypercall   ~105,779
>>>    steal-time  ~105,872
>>>    -> all within noise (±2%); no measurable difference.
>> Hi Tao,
>>
>> what is ebizzy command? ebizzy -m or ebizzy -M.
>>
>> could you try command on host and one VM without over-committed at first, and then two VMs and three VMs?
>>
>> Here is result on my 3C5000 Dual-way machines with 32 cores and two numa nodes:
>>                  ./ebizzy -m          ./ebizzy -M
>> host             8633                 158898
>> VM(32 vCPUs)     6610                 133153
>> VM/host          76%                  83%
>>
> just ./ebizzy -M is enough, it seems that CPU number is one key factor.
> 

Sorry for the delay — it turned out my ebizzy command was wrong. I had
been running `ebizzy -t <vcpus> -S 10`, which is neither -m nor -M, so
neither mmap mode was active and the workload wasn't really stressing
the TLB-flush path. Thanks for catching it.

I re-ran with -m and -M on host and a single VM (8-core LoongArch
KVM host, 8 vCPU guest, 1:1, no overcommit).

                 ebizzy -m        ebizzy -M
host             ~20,000          ~55,000
VM (8 vCPU,1:1)  ~17,000          ~53,000
VM/host          ~86%             ~97%

The -m ratio (86%) is close to your 76%.

I then tried multi-VM overcommit (2 and 3 VMs, all running ebizzy -M
simultaneously). The initial result showed a large gap between the
PV-TLB-flush kernel and the baseline under overcommit. Both kernels
have CONFIG_PARAVIRT enabled (PV IPI and steal-time are active in
both), so PV TLB flush should be the main differentiator — but since
they are two separate kernel images rather than a clean on/off toggle,
there may be some noise from other differences. I'm now re-running
with a QEMU CPU property (kvm-pv-tlb-flush on/off) on the same kernel
to isolate the effect cleanly.

I'll share the verified numbers once I have them.

Thanks,
Tao

>> Regards
>> Bibo Mao
>>
>>>
>>> tlb_bench sleep-idle (ns/flush, lower is better), 1 flusher + 31 idle:
>>>    no-PV       ~166,536
>>>    steal-time  ~149,553
>>>    hypercall    ~88,686
>>>
>>> ebizzy's workload is mostly threads staying busy with alloc/copy/free,
>>> which drives remote TLB flushes against running vCPUs — that may not be
>>> the path this feature is meant to optimize, so the flat result there
>>> probably says more about the workload mismatch than about the feature
>>> itself. I need to take another look at whether the benchmark actually
>>> exercises the cases PV TLB flush targets before reading too much into
>>> the numbers, including the tlb_bench figure above.
>>>
>>> So I'd hold off on any conclusion for now. Next I'll re-examine the
>>> test setup / pick a workload that better matches the feature, and keep
>>> you posted once I have something more representative.
>>>
>>> Best,
>>> Tao
>>>
> 

