Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32D332918
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354461; cv=none; b=HuOsbHTMcxbXq0lOKgJsLSmo7vDfkejiP37EUbMJn3g0ZPGCwKpidUBS3ExulUIn33zZN3cwaYyz5q9OrydAAW3FlDqaS5ENSdINE/p7GnGp+otXaGwhMXR9o0pmLy/umqSEJXDw+1hhdb0Q5XogTPjmiLSBgdLDAQ8VZKlI0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354461; c=relaxed/simple;
	bh=uhwCJjOx0RRcOeQ1GrJvK1wVL3EQ4y0qYMSWsJFYTvA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AjoTraFIL72FCh5YZXUSZ43DPlUgRCNkaOirgdpvoKrx449L9dSZdJmlP8oeqJs/aniR20RtH26g5Q+1Bu+ARPUjcDT3MWKG/TsSG904NS1au3s2ZhDBmXV1PK/OMF69c6UXXt39X+r6CTZrjycR3rnSXYXMir9N7NONk2NaZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IIoCBHSH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IIoCBHSH"
Message-ID: <404180d0-c734-4465-8752-f43279730692@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782354448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RexzsFyKUpqnLGWUfFRnHWPPcCFNo2VQKsuPWYJRXY=;
	b=IIoCBHSHl3qD/fmWl2OjeAOQvz+ZVqVu+W7E8m3Nf0z/nSU5zHcHTzXaYiKGsnFeErV8K5
	yATz0GbIZQFeWqmJSJLRP/V0SGHk8YVD+kfBlnnrGEPfIZ34RhNEupXiLKMrQ3UqjSzIzL
	UQ49vlLZhDrpmdNji2lByzESJ3zxl4g=
Date: Thu, 25 Jun 2026 10:27:14 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <9ec9d22b-93fd-3dcb-c6b8-19563f1b7c0a@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Bibo, 

在 2026/6/17 09:05, Bibo Mao 写道:
> 
>> Rather than argue from intuition, I'd like to try the hypercall approach
>> you suggested and measure the performance improvement against the current
>> path. I'll share the results with you once the testing is done, so we
>> can decide the direction based on the numbers.
> well, that is the best. It is my pleasure to discuss this with you.
> 

A quick update on the testing. I put both the hypercall and the
steal-time variants through two benchmarks on an 8-core host with a
4:1 overcommitted guest (32 vCPUs), and wanted to share where things
stand.

The two workloads:
 - ebizzy (all threads busy, mm-flush heavy)
 - tlb_bench in sleep-idle mode (1 flusher + 31 sleeping idle threads,
   so the idle vCPUs get preempted)

ebizzy (records/s, higher is better), 32 vCPUs:
  no-PV       ~103,737
  hypercall   ~105,779
  steal-time  ~105,872
  -> all within noise (±2%); no measurable difference.

tlb_bench sleep-idle (ns/flush, lower is better), 1 flusher + 31 idle:
  no-PV       ~166,536
  steal-time  ~149,553
  hypercall    ~88,686

ebizzy's workload is mostly threads staying busy with alloc/copy/free,
which drives remote TLB flushes against running vCPUs — that may not be
the path this feature is meant to optimize, so the flat result there
probably says more about the workload mismatch than about the feature
itself. I need to take another look at whether the benchmark actually
exercises the cases PV TLB flush targets before reading too much into
the numbers, including the tlb_bench figure above.

So I'd hold off on any conclusion for now. Next I'll re-examine the
test setup / pick a workload that better matches the feature, and keep
you posted once I have something more representative.

Best,
Tao


