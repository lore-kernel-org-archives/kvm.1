Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795433322;
	b=NkLH2M0xaA47gDvbmOwqbT8/0U0LleHJ8uV2U3/Jxn3khNfHhocDArx6UhS/DqdeojLO
	 V+1j/5my8tMc5R6f0bNFOQ9bu4hrNE5AVVHsITYZwZcYylcCm4Txj2rKpE9l2JGsBxhrD
	 NoGaDuBlYvQ7egE9+tpPHsWc8rmzhHUKIbe8SwhQpKvH/6BK25EROmR4PMT7vbrkektPc
	 A5r5Jjr1Kr1zCrrxGQKt3vL+Y5HznyhrUUMk2UsLzK9qshcVPbikHNV9XfIQ0e8zXE71O
	 ElajVPlcZjT2nWtsTz6bWk/7KhBOf0LJ+AhJ6S8U/F0FTP2RdTRLRAnRe+zwrIypeng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433322;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-ZohoMailClient;
	bh=HBmcfBMsncZWaLYvWSW4Mgzs7WRw3YFpQ2wUaFbGx9c=;
	b=UhDO+9kxmd7xdXtQ5dwM8kcGALkN3StNYSn3NOhPgoz6zaZKkjE48O0Jt6He+6F96DKb
	 9wMD4hyb6u+sfkNIyeSXTLWM7VQtEvSdcov5sapBWYttNm4YQju0e78rqRYVo6H73foqn
	 ZSenT2EKGFhdtlFRroDyNQYGdR2BkgyJHLSWgLnampooSZ1XsjMQgPaE4VNOp+Tu7tx6P
	 yGpjac2M5g80Fdyr0I2sYMaE8Db7ucxIeYO5Cmbij7wAGzllPuo43B+d9Hvg3q+YOVqby
	 pB/IV8nuO+yf3H2Vb8wsrCBaFoWNIWBiyrWIx5B54RtrMddgZeSQ7qeNweK6RYAPGZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hGwIk7UN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056B606A31A;
	Mon, 23 Nov 2026 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F056B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hGwIk7UN
ARC-Seal: i=1; a=rsa-sha256; t=1795433306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rd9dL3w5RmM5mNjMIZK5GcbwkUrkfRsX8xvy2c/fFR3Sa7lGIMAtGd2dqAnqhWU0lbffuI88emP9BkZHs5yyvZo0d0hlpDUirUDhgDW7LJ0/+LxaqWQkhorLptSiBOBQTIPB4UZOTobQldj2gtGhelPOWB8W7v7A/RU92aqL0oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795433306; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HBmcfBMsncZWaLYvWSW4Mgzs7WRw3YFpQ2wUaFbGx9c=; 
	b=iA+zThXqapx8kVop40FijmJvkL5lFYRCpRedOBrWjsLxdZJgE8CWA5Mjk2FJaBrfoG3NZt1jokMCgNpZI71U438vzEuRqg1dyU0fa7FSA+DQe/n6fQ0bAtEvtzB2bbQi5ZpPoEuSN/ph6tDg8I4VGgJ/UTlPXKYw8lsu9xupQB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: a=rsa-sha256; b=hGwIk7UNQaUYI/S6vqf/9wFUIRBsTUd0DMd5tA8cEAo0vgXJ0BLI2IpCB3MU00fXl3yADSOC2OKQ0nRf45Gm/2hsNKjcy52Sixxu2rHMkUzy6d/6+azXRXweO0YSB6i8/EwgJSb1TOBmKMGT+CL4OvC8e/syqVZ24uZoY4THj1c=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=HBmcfBMsncZWaLYvWSW4Mgzs7WRw3YFpQ2wUaFbGx9c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795433301737770.8977295672257;
	Mon, 23 Nov 2026 03:28:21 -0800 (PST)
From: Matthew Leach <matthew.leach@collabora.com>
To: "Jiaming Fan" <fan.jiaming@hotmail.com>
Cc: "Sean Christopherson" <seanjc@google.com>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  <kvm@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <kernel@collabora.com>
Subject: Re: [PATCH] KVM: x86: Reevaluate pending interrupts when enabling
 ExtINT through LVT0
In-Reply-To: <OS3PR01MB10251C0B5CDCF9538DA3A1727E77C2@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <auuQ8pE439EB63tm@google.com>
	<OS3PR01MB10251C0B5CDCF9538DA3A1727E77C2@OS3PR01MB10251.jpnprd01.prod.outlook.com>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Mon, 23 Nov 2026 11:28:17 +0000
Message-ID: <87wlq3n5wu.fsf@collabora.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

Hi Jiaming,

"Jiaming Fan" <fan.jiaming@hotmail.com> writes:

> On Wed, Nov 04, 2026, Sean Christopherson wrote:
>> Ahh, but there's nowhere for edge-triggered events to be latched, so this only
>> affects level-triggered events.  Which means, this?
>>
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index d6e5fbc3c58c..b72930a8516d 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -2554,6 +2554,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>>  			val |= APIC_LVT_MASKED;
>>  		val &= apic_lvt_mask[index];
>>  		kvm_lapic_set_reg(apic, reg, val);
>> +		if (!(val & APIC_LVT_MASKED) && (val & APIC_LVT_LEVEL_TRIGGER))
>> +			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
>>  		break;
>>  	}
>
> The trigger mode check doesn't catch the case Matthew hit. Linux's
> setup_local_APIC() writes LVT0 as plain APIC_DM_EXTINT, without
> APIC_LVT_LEVEL_TRIGGER, so no request is made and the "noapic" hang
> remains.

That's right, this version of the patch wouldn't fix the issue.


> For ExtINT the pending interrupt is latched in the 8259A, whose output
> stays asserted until the guest acks it, not in the LVT entry, so the
> trigger mode bit doesn't tell whether anything is pending. Your first
> version (any unmasked LVT) does work for LVT0.

That matches my understanding. I think the right approach is Sean's
first suggestion (any unmasked LVT).

> There is a second path with the same problem that neither version
> covers: hardware-disabling the APIC through IA32_APIC_BASE. With the
> APIC disabled, kvm_apic_accept_pic_intr() returns true, so an ExtINT
> latched while LVT0 was masked becomes deliverable, but
> __kvm_apic_set_base() doesn't request KVM_REQ_EVENT either:
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2825,6 +2825,7 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
>  		} else {
>  			static_branch_inc(&apic_hw_disabled.key);
>  			atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
> +			kvm_make_request(KVM_REQ_EVENT, vcpu);
>  		}
>  	}

Nice catch! Looks like a very similar problem.

[...]

> Matthew, are you planning a v2? If so, I'm happy to hand over the
> selftest and the APIC_BASE fix. Otherwise I can post a series with
> your patch (reworked per Sean's first suggestion) followed by the
> APIC_BASE fix and the selftest.

Looks like you've done much more digging into this than I have, so
please go ahead and fold my patch into your series.

Regards,
-- 
Matt
