Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E292F7EE4
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781825554; cv=none; b=fxBq/Y9y4hoLryBIKQbpmBXgq2HC7ENsMfRvbgTuG/eS+spqRZ6EKAHwQIValYJRuCX31D6fWYOpJX7XS45rfFqVKBQ3XMHzVKE5XEo4GpHSTGpw26DXJIjLypCJ8NwnwsMbwEV3hW7KKxI9/K4FkKElBFqNHY+NeZ5xanFP16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781825554; c=relaxed/simple;
	bh=aOBaHP4DOk4vq3tW3rv9yXUlZFd1+xiTupwDlFmXHKA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dxQ7KNgE7g2hlDLeN/f8D95zOJD6HFvKIUbYbURRsyChYUNU1ODi2uwNtGwB1vZ1s53zDqsRqqJYpW+zB6BNQENDJDka4Yw3aQHuA/hj3RqSiMzFwHxntBKsbjETSHyBDg45wkuB9IYW/Olc4WkKNKIb1RogeNdoW2iBw52ZSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIbBeGKA; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIbBeGKA"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48638da0e05so1713639b6e.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781825552; x=1782430352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwWYCnxdR0CMlBSotsz1RrmN4O2SDrdrRioZC+xeVso=;
        b=iIbBeGKAiRPB/YS1s9Oxi9L0oJrB9PN4tcvDyNcyEHh2gMo04HY4O/S8d9I17GBaiL
         jOnq5tpDfWcB7mmRXo/w8BQB0rC2ZarKIr55zQ8wwaWcS4P1t7SwSa4/jJPjNgiyU/C8
         4EGaGPyLqA1RRcd/hrWwrCYkyJk+4B9AjU9T8utLbAqSn0agyfqEeCtm+DrbpF+mjg1h
         qlY+Q/e1epyuca6ImMUQVk8mBSHym0iEGD+TkJwq9YG2n27TjyE1oOT8XUqM33WiFLAY
         1U6cHnbugFtIQIBCHb69XVpK5Ozl+AFpMzeYVSDMi59Le3/wCpXGzzWeefGtbDx9BRi9
         KcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781825552; x=1782430352;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwWYCnxdR0CMlBSotsz1RrmN4O2SDrdrRioZC+xeVso=;
        b=CbXbtCedAPKw1Z2jmyd2FFLMV58twdyWeEwmSdkVZ4N4f/dKxCEabXcKp35l3oQHxv
         o8Phmc6Cj9dXq+4SyRIdaFLPvbINVKIGR3wWBj1eVZ1LU1ZbnIOnwYwFRZngfd6zXJju
         D+NPMVi4IBoX1E7CPsJ6GQ/+T9xgoGKP2IB784tcEgpSjJYCpcOJME3cliisMLk1Dp0H
         piG9sMVAL2RNpzLeqx/9SO9Wj2aALYNBQPoKFc7Cc3CebT2jDvAr1IVPbosxcUU2ydoB
         +xnuig0hPIPxes82vDhhL7mFDf0jgl+q3i6mLXDtZ3pn7o1+CV8StD+B9FRwsFzx5TJI
         0KTA==
X-Gm-Message-State: AOJu0YweHvwv3omv7tmjluxpjSouTEdJ3fLT3M03rnDjp27psAKULkUX
	raunvqNK429viNw8QrUe9/0nKo4ol7IQ0M18Ta3hLCXFnQMvrQIbDpt6PpKOwo/nORishH3W095
	usuba/NQmY7ziYQgsXBVvnbFiAA==
X-Received: from ilbdv1-n1.prod.google.com ([2002:a05:6e02:4001:10b0:502:e73:d02b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1808:b0:46c:e542:cc25 with SMTP id 5614622812f47-489aeaa5634mr180520b6e.9.1781825551504;
 Thu, 18 Jun 2026 16:32:31 -0700 (PDT)
Date: Thu, 18 Jun 2026 23:32:30 +0000
In-Reply-To: <6dca2d6e-54d0-42c4-95df-45a30a473e0b@huawei.com> (message from
 wuyifan on Thu, 18 Jun 2026 09:53:15 +0800)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntse6jctm9.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 15/20] perf: arm_pmuv3: Handle IRQs for Partitioned PMU
 guest counters
From: Colton Lewis <coltonlewis@google.com>
To: wuyifan <wuyifan50@huawei.com>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	james.clark@linaro.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wangyushan12@huawei.com, 
	wangzhou1@hisilicon.com, xuwei5@huawei.com, prime.zeng@hisilicon.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

wuyifan <wuyifan50@huawei.com> writes:

> Hi Colton,

> On 5/5/2026 5:18 AM, Colton Lewis wrote:
>>    static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>    {
>> -	u64 pmovsr;
>>    	struct perf_sample_data data;
>>    	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
>>    	struct pt_regs *regs;
>> +	u64 host_set = kvm_pmu_host_counter_mask(cpu_pmu);
>> +	u64 pmovsr;
> kvm_pmu_host_counter_mask() is called from armv8pmu_handle_irq(). This
> interrupt fires in both host and guest contexts.

> However, kvm_pmu_host_counter_mask() dereferences
> host_data_ptr(nr_event_counters). This indirection requires
> kvm_arm_hyp_percpu_base[cpu] to be initialized, which only happens during
> KVM hypervisor setup. When the interrupt fires in a guest kernel where
> KVM is
> compiled but not active, the per-CPU base is NULL and the dereference
> faults.

I will fix that.


> Thanks,
> Yifan
