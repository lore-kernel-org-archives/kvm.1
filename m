Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C935423E94;
	Tue, 22 Sep 2026 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067158; cv=none; b=h+fKpJpicn7UWSk78DUpvZCA1o2EnHI5UHCDBmnchOif8JTV8J2YpyWpB6OII69dyg2LT43hP+hizqeqAHsowJfxXmOg9/5K8P5WR2212U33dI2h2EurtRyxYvCrrOA3mcFgI5UzT8o1530IX/Uqm0AXnFyaojz8SFiUCXQ89Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067158; c=relaxed/simple;
	bh=zvI+8GSETn7LNlbozl86U4Ok7dRLxjq4JpmI16q0F54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkix63N4X+QViCal8yN2QAhLpdMAEHZhHBIkfGUBLTPu2ZVnZJ5MLTBbWyJ6TUoaw2Sv4FkdCoO0HfXaV+12mC8CF+G1vL/TVcUHywaXJJ4oWEz6yKvRBIU3bgh03eKI45nRxMMhkuk2/EnAf/a1OPR7xPZrgH5XkHM5tL5o2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=GYGFi7Cf; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="GYGFi7Cf"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68M8p4AY014493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 22 Sep 2026 17:51:04 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aSkso6VTuE1j2eIC6Omi4Exf0hrumTUhbwJQCS8v0Jk=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1790067065; v=1;
        b=GYGFi7CfxySCHkGNYbviQhaWOIu1Icg3BpQNl8WTUTnxz6bpbIpzI/2GnR3wN+5C
         /+NmBvMA6MgnGbzs3tydcuW8Joxi4k8evpn9t9aeX+GsspiZG8s3KAyzq4wQWZ9p
         4pi4AkOg+S0lMC8DVWBSyu03KE3H6d+fhYpu3/ovlHVKtNzFYHIbX242v6ARhL4P
         nuajrFOV+CvPgjNvzkEDCsQfQgY+Oj61G8zWDMJGWmdzCfp/7HzoNBELyQsAyDMY
         I/W6QKkNfvvgU2nVb90KvmRugT+HS7wpKpX1ex1jGX3DymUno/Fcx7STsKXcXHms
         tMDWY7Hnfy1e/O7ACYz74w==
Message-ID: <67b1a5dd-372e-4548-a44d-ea77f38ea07f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 22 Sep 2026 17:51:03 +0900
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/21] KVM: arm64: PMU: Recreate events after MDCR_EL2
 changes
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu
 <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fuad Tabba <fuad.tabba@linux.dev>, Mark Rutland <mark.rutland@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260920-hybrid-v11-0-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
 <20260920-hybrid-v11-9-03618771b0e1@rsg.ci.i.u-tokyo.ac.jp>
 <arImQ6SG7s1k9uJk@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <arImQ6SG7s1k9uJk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/22 15:54, Oliver Upton wrote:
> On Sun, Sep 20, 2026 at 08:15:50PM +0900, Akihiko Odaki wrote:
>> +void kvm_pmu_apply_mdcr(struct kvm_vcpu *vcpu, u64 old, u64 val)
>> +{
>> +	u64 changed = old ^ val;
>> +
>> +	/*
>> +	 * HPMN determines which counters HPMD and HLP apply to. Changes to
>> +	 * these fields require new perf event filters and sample periods.
>> +	 */
>> +	if (changed & (MDCR_EL2_HPMN | MDCR_EL2_HPMD | MDCR_EL2_HLP))
>> +		kvm_pmu_request_recreate(vcpu);
>> +	else if (changed & MDCR_EL2_HPME)
>> +		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>> +}
>> +
> 
> Urgh... I'm not a fan of this. Can you just modify kvm_vcpu_reload_pmu()
> to discard all backing perf events and recompute them only for enabled
> PMCs? We set KVM_REQ_RELOAD_PMU pretty rarely.
> 
>>   	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, mask);
>>   	__vcpu_rmw_sys_reg(vcpu, PMINTENSET_EL1, &=, mask);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 75624725adf1..7dd2cafce247 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -3114,17 +3114,22 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
>>   	}
>>   
>>   	__vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);
>> -
>> -	/*
>> -	 * Request a reload of the PMU to enable/disable the counters
>> -	 * affected by HPME.
>> -	 */
>> -	if ((old ^ val) & MDCR_EL2_HPME)
>> -		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
>> +	kvm_pmu_apply_mdcr(vcpu, old, val);
>>   
>>   	return true;
>>   }
> 
>> +static int set_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>> +		    u64 val)
>> +{
>> +	u64 old = __vcpu_sys_reg(vcpu, MDCR_EL2);
>> +
>> +	__vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);
>> +	kvm_pmu_apply_mdcr(vcpu, old, val);
>> +
>> +	return 0;
>> +}
>> +
> 
> Just keep the old ^ new test inline for access_mdcr() and set the
> request unconditionally from set_mdcr(). In the usual case
> KVM_REQ_RELOAD_PMU is already set on a vCPU that userspace is restoring.

Hi Oliver,

Thanks for the feedback. I'll make both changes for v2.

I originally tried to preserve existing behavior and keep things 
consistent, but I agree that simplicity is much better here given how 
rarely KVM_REQ_RELOAD_PMU is set.

Regards,
Akihiko Odaki
