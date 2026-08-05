Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67831B3925;
	Wed,  5 Aug 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896471; cv=none; b=Ga9E39cAgucFI2gz9gi7LSLAcdfDRQTRISHm04U4DAQKr9eFrM4DivEmeHMNmfIqw8Ejpvvim8NkwOVigdtLLx+fblXGcMdyrXifqONFXcBmCJywGjCRc3Gr6ys+Z1mOFdece5BplRO8hJfzO+elzUKinI44lKI9Qf8sLBQsD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896471; c=relaxed/simple;
	bh=CkIv0GL7V0YUyp83j0JvLPK9Esh2kKr1oM/xrZWcdqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeo28IjYXSNqMBpu1qDUkTBwhiNvg/u7NPke3rmFZ0kNGXBJo1/owubePel/jCadSDQOaxLGFJP3bSJ3TRz26Ehzvon8pbTBYpfKI2MUPFGNEuCDVKMOCRBsML3xHTjDGaMTcckTk2YhKqHIkU0EC/9wi0oKMidv1cZlwlkCTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vnp3M33s; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vnp3M33s"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785896466; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jTDX4mKcgPJ9srE81obhGh53TCP4fN/R36nyLgZBHpU=;
	b=Vnp3M33sXfUbxVbL4m2xyFjHGSgBb7x/EIyPtaWriFbS/Ghq81KcdcnhIyEmhUKG+G/YUWisy1KmUQnYJFIMhypPlldhb3mn2LOA0lF0jgF8XkxDJM3kYFMCgBVnc41grKq65VU5z9WHk/eYXsTs1cq8+JtzW+v9REoKLeV5ObU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X8Pjkxs_1785896463;
Received: from 30.221.106.215(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0X8Pjkxs_1785896463 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Aug 2026 10:21:04 +0800
Message-ID: <36b6646d-3f14-4821-a804-fb590c62432d@linux.alibaba.com>
Date: Wed, 5 Aug 2026 10:21:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/kvm: introduce pv idle time
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 vkuznets@redhat.com, geert@linux-m68k.org, sammiee5311@gmail.com,
 lirongqing@baidu.com, schuster.simon@siemens-energy.com,
 kai.huang@intel.com, shannon.zhao@linux.alibaba.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/7/21 11:00, He Rongguang 写道:
> Hi, this patch introduces a PV mechanism for guests to publish their
> vCPU idle state and accumulated idle time to the host. This allows
> the host to efficiently determine whether a vCPU is currently in its
> idle loop, and knows vCPU idled for how long. QEMU patch and ARM64
> support patch will follow in a subsequent series.
> 
> The guest writes a GPA pointing to a struct kvm_idle_time via
> MSR_KVM_PV_IDLE_TIME. When entering idle, the guest sets the flag field
> to KVM_PV_VCPU_IDLE. On idle exit, it clears the flag back to
> KVM_PV_VCPU_RUNNING and adds the elapsed idle duration to idle_accum
> (in nanoseconds).
> 
> The host can read the flag at any time through
> kvm_arch_is_vcpu_pv_idle() to make better scheduling or resource
> allocation decisions. For example, host may overcommit those vCPUs
> which are mostly idle. An in-guest agent may be absent, or may not
> report the status in time.
> 
> The accumulated idle time provides visibility into per-vCPU usage for
> monitoring purposes. An in-guest agent can report VM CPU usage, but
> this PV mechanism allows the host to obtain guest CPU usage even when
> no agent is installed. This is especially helpful when the hypervisor
> enables exitless-hlt/mwait (for better guest performance) or when the
> guest uses idle halt-polling, both of which make QEMU vCPU thread usage
> deviate from the actual in-guest vCPU usage.
> 
> This feature is advertised via KVM_FEATURE_PV_IDLE_TIME in CPUID leaf
> 0x40000001. Guests enable it by writing the appropriate MSR during
> initialization, similar to the existing steal time mechanism.
> 
> Ping, any feedback on this patch would be appreciated.
