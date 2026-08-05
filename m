Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F03C3442;
	Wed,  5 Aug 2026 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897069; cv=none; b=e6m4+eTrFQWoG4razX3uZWL7rVvUHyUfG24hhFhZGuTBkOWlb/g2aFGIY/Vx86ob36NXj50u7Fq1g2HYvwWpHcuiQjlM5otBjUlbXbKUlrGqnDFI0bm8BZfupeJ7vI8c3b9jCzIl9RK5Hve8Rn7lg3q926Pe7R5Du9f/FWBAWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897069; c=relaxed/simple;
	bh=OHdlbRBEytdaz2OZJXal6evrARgiQzCPKqL3FAQuecA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgS3Ht00bKNC/gwg2/fWUtof6x7Z+HVfAzjjoELddba5uQu0UIXroGTQNYFIk2prBNXeYzsF9HXRebn42kk/UMKBqaAEUGtLEdn/WuE+nAI872s1VNABR5Re/SpgKPYtt7aOkKKDIz5rDRimxt1bqPWN3ROuHi/lRidE88YM7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lKOn1On8; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lKOn1On8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785897063; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4sRwgKt6/kzaEj31mtkG3npSA1XNMSbnP6nju+RVO4g=;
	b=lKOn1On8nKP6KL7aLJhLgHlj+wvwcG347LEWRukgDiKavrpulVUItli9KDh62z1Zn62J4MDey0COEb5lne7iPXWgVS0ypbsJ5syl5SIKMz7+tmcbpDxcdfqOGBpPZWdJDW++MXmMCdtpuvi8YG19vR3r7Ih4sKU5cMOhNjTR7Qs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X8Plfrq_1785897060;
Received: from 30.221.106.215(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0X8Plfrq_1785897060 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Aug 2026 10:31:01 +0800
Message-ID: <25605d8c-4e13-413f-bb50-6c65684fafd3@linux.alibaba.com>
Date: Wed, 5 Aug 2026 10:31:00 +0800
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
 kai.huang@intel.com, shannon.zhao@linux.alibaba.com,
 He Rongguang <herongguang@linux.alibaba.com>
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

Ping, any feedback on this patch would be appreciated.
