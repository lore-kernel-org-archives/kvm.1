Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1A3F2100;
	Wed,  6 May 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061411; cv=none; b=FaMgzBrYhMfscOA/XW0Aa666LlJUeIRpVF6IRZZdWhPDMDvCd4F+Qc7JZ5H/EOVCBkJY7MDaEXEj3uD9sZ8jkgdNjHrXgD4/6bTkAk3BafYvI9igR8jJVrAcT17aYOHK7H45Z9bMB3IPAzEmmjfpicBfn2AfhUw/A37o5hVkCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061411; c=relaxed/simple;
	bh=GGV9DNdwCRoaJL90u+Hhuk9ehoDj8FDOovIw7TYhYJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giTrCoHZSw/IsAK7qw3vaYT3X4qJS3NE+8k/kzWXu4KojrDY1QVWZlTJgH1K2LQgySW39TRUZBJ/3YYgdtfZQJvJOR0t2M6Rs+8BjeY9OgeG9iKadT3mEQHkmX0Wn/nW21GxdKzVyyogFHsFSIkPSDwtTWqMz8I3D1yCEj5exLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FVvWscX7; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FVvWscX7"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4g9VvD4dgGz8hfY;
	Wed,  6 May 2026 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778060920;
	bh=GGV9DNdwCRoaJL90u+Hhuk9ehoDj8FDOovIw7TYhYJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVvWscX7l78GZ/COWVrEW371dC842Ox4zJZbjbu8ezaSwRI88S5zpSBNMbelTXxrl
	 cXjbH2J4Y7iR3vSM7s8VZ88Dfj0hn8rB2lhYHNkAsMrUlRQAY1juw8Usi8l2FStUX3
	 2zRxbRmMudGavMdOPR1fcbkKb3quZXUakyzx9jm7tBvV85ikWjUVzKY1HsVIvsK7Z/
	 NqWx+okx+sAp0icBvCdGEdVrcn3w2+IxDnvnIVfNcViZWcqkyjPMdFnZm4cehROGBN
	 ncMZbmWHNp09YgIvi6kkwnJavbF+YhQt5eIYl65NIVPaNLa2dLy/D9dDRIAmTKZvMI
	 3FyvnmgfMe0aw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4g9VvD3tzzz8hfV;
	Wed,  6 May 2026 09:48:40 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g9VvC5lhdz8sgT;
	Wed,  6 May 2026 11:48:39 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B06F763304;
	Wed,  6 May 2026 11:48:38 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
Date: Wed, 6 May 2026 11:48:37 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
To: Sean Christopherson <seanjc@google.com>, Lei Chen <lei.chen@smartx.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <adVGrJaRlRooO4su@google.com>
 <20260409142226.2581-1-lei.chen@smartx.com> <adf8Q1VSeAMMyCa_@google.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <adf8Q1VSeAMMyCa_@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177806091922.3821122.18141829574976920146@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B06F763304
X-NC-CID: wK9o0aQCpElR5NBNPkBy66XV8zKmcEwDpfvEQeJ+o3KYVLhZRyM=

On 4/9/26 21:21, Sean Christopherson wrote:
> On Thu, Apr 09, 2026, Lei Chen wrote:
>> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
>> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
>>
>> As a result, kvm_arch_vcpu_load() can queue global clock update requests
>> every time a vCPU is scheduled when the master clock is disabled or when
>> the vCPU is loaded for the first time.
>>
>> Restore the throttling with a per-VM ratelimit state and gate
>> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
>> scheduling does not generate a steady stream of redundant clock update
>> requests.
>>
>> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
>> Signed-off-by: Lei Chen <lei.chen@smartx.com>
>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/

Was this performance regression ever addressed? Looks like this fall
through the cracks, but it's easy to miss something.

Ciao, Thorsten

>> ---
>> CHANGELOG:
>> v2:
>> - remove comment of kvmclock_update_rs
>> - make sure kvm_arch_vcpu_load make KVM_REQ_CLOCK_UPDATE for this vcpu
>> - add RATELIMIT_MSG_ON_RELEASE to kvmclock_update_rs
>>
>> v1:
>> - initial version(https://lore.kernel.org/all/20260407070046.2336-1-lei.chen@smartx.com/)
>> ---
>>  arch/x86/include/asm/kvm_host.h |  1 +
>>  arch/x86/kvm/x86.c              | 11 +++++++++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 5a3bfa293e8b..5e750c49d21e 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1453,6 +1453,7 @@ struct kvm_arch {
>>  	bool use_master_clock;
>>  	u64 master_kernel_ns;
>>  	u64 master_cycle_now;
>> +	struct ratelimit_state kvmclock_update_rs;
>>  
>>  #ifdef CONFIG_KVM_HYPERV
>>  	struct kvm_hv hyperv;
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 63afdb6bb078..a534e8391611 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -5210,8 +5210,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>  		 * On a host with synchronized TSC, there is no need to update
>>  		 * kvmclock on vcpu->cpu migration
>>  		 */
>> -		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
>> -			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
>> +		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
>> +			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
>> +				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
>> +			else
>> +				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> 
> What I was trying to call out in my review of v1, is that prior to commit
> 446fcce2a52b, the effectively ratelimiting applied to *all* instances of
> KVM_REQ_GLOBAL_CLOCK_UPDATE.  Which meant that KVM's existing behavior is that
> kvm_write_system_time() would be subject to the ratelimiting as well.
> 
> That said, I don't see any obvious problems with immediately honoring writes to
> MSR_KVM_SYSTEM_TIME{,_NEW}, and it's probably a much better experience for the
> guest.  So I'm a-ok with this approach, but we should call out that skipping the
> synthetic MSR case is deliberate.  No need for a v3, I'll add a blurb when
> applying.
> 
>> +		}
>> +
>>  		if (vcpu->cpu != cpu)
>>  			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
>>  		vcpu->cpu = cpu;
>> @@ -13189,6 +13194,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>  	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
>>  	mutex_init(&kvm->arch.apic_map_lock);
>>  	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
>> +	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
>> +	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
> 
> IIUC, so long was KVM doesn't explicitly invoke ratelimit_state_exit(), setting
> RATELIMIT_MSG_ON_RELEASE means we won't get dmesg spam?  To be clear, I'm 100%
> in favor of suppressing dmesg output.
> 
>>  	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
>>  
>>  	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
>> -- 
>> 2.51.0
>>
> 

