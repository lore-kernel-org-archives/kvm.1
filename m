Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44F1E1E04
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658189; cv=none; b=bN9b6v/tL1q8B/oCq6El6YU9LYrmB+fWgl3us3e3/jsNCdXYsIqaBLaNwhfyHjC2T0GJfsUoJrxBXQ14Vr56ASQ9XcWzmbiKYoUw0woaOcYoMdSc5FLssPD80rrnM12oeGpElXBStxZcSZBL+ph/0Y7bPJPRstKYb0q9EnivuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658189; c=relaxed/simple;
	bh=vUtFdcxOD+EZi+ORtljV1N5EiGNHsOPnGe4+YilormM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d0cM/GAAU2o8vp+CdJShTJdE2ENzYducGJhttGJ+QGnEHQdCIt/L3AMamIiTZPVm1tN1yinXUqlQ3C1Vh/516EECqmbJmPMrp4fzRJy9KhnbDTudszcl4KKFBLPvoh7eOkCRPahIK8aQd/wZdb6aTliEkF8Me7lxEhUI0OPe388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bxt3hH8jFq0PYUAA--.30119S3;
	Wed, 17 Jun 2026 09:03:03 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxzsJD8jFqA8SoAA--.58513S3;
	Wed, 17 Jun 2026 09:03:00 +0800 (CST)
Subject: Re: [PATCH v4 3/3] KVM: selftests: loongarch: Add PV TLB flush
 performance test
To: Tao Cui <cui.tao@linux.dev>
Cc: chenhuacai@kernel.org, cuitao@kylinos.cn, kernel@xen0n.name,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, zhaotianrui@loongson.cn
References: <4efcc81b-bf7e-4d78-ba82-9f4590673486@loongson.cn>
 <20260616154231.10982-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ae81919e-10a1-6389-141c-5a652ca3edd8@loongson.cn>
Date: Wed, 17 Jun 2026 08:59:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616154231.10982-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJD8jFqA8SoAA--.58513S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw13Wr1xCr4ktr13ZF4kZrc_yoWkGFg_KF
	Wj9F97Gw1UAayayw15tr1rCrW2ga10kry0qFy3uas8K3s8W3Z7GF1kJrsaqa43AF4FgFn3
	Ww1DW3s5AwnFvosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==



On 2026/6/16 下午11:42, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Thanks, and I share the stability concern. I don't want to land something
> that adds risk for a feature that isn't clearly earning its place yet.
> 
>> Do you have real workload to show the benefits of the PV TLB flush,
>> and which TLB APIs should be hooked.
> 
> Completely fair, and to be upfront I don't have a large-scale real-world
> workload to point to yet. So my plan is to build a set of local test
> scripts that simulate as many usage scenarios as possible: mmap/fork-heavy
> paths, kernel-range flushes, and an overcommitted setup where vCPU
> preemption is frequent. I'll report the IPI and TLB-flush overhead with
> and without the feature, broken down per flush API. The coverage is
> synthetic rather than a single flagship workload, but hopefully it can at
> least give us a rough, preliminary sense of whether the feature is worth
> pursuing.
By the original patch from x86, https://lwn.net/Articles/740363/
There is ebissy benchmark, maybe we can use this test case.

Regards
Bibo Mao
> 
> Thanks,
> Tao
> 

