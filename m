Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688738;
	b=Mwed3MODPDM4y+koEFrOPI3lf5yQhVAtsF+Lj2vP3I9Od/E/zeL0YYxursw5i6A7u46v
	 Ivanl7WcQQ8VpQsZI4um34YNt06i8WIcPUIH+DonMRU8Z8C3FARC/lTZtiC7coT/mUBEQ
	 8SA1YuHJqtjrFGJnC0HfLNoQ4wkJIIXTtt+Z8WM0zoFqc5CpnwC2inc3SOC1UTiz8QEj+
	 /pYs0eADq+c/NQoU8iUq7ccz63CVu6Np6WPMDy42DDsFEd7uKtiklkKehYxlHGUtur+i8
	 Qll6769ciqMfeDyjXeVF7AiCnUxIXIlhpZi5IKbHN7cv4CC0sAL+J95qDqvE0M//fRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EIBh3I4kBpuolM9pnCBMio81J/gT/rvUXvi5tC4Fdno=;
	b=cxcFwdETqDPw0rGbAGT7HWoBrh8pviSWscIiIQt7B8XM8nn8oY4luIQ5p7Lgd+4O0cBi
	 sEJ2i/BqT8ldAG7tE5RJnPfdFyvcc2PXoSCNyRgc1S/7FPkepmEU6a58PitaR6ZdA620k
	 ccps63fHqCa9SDz/ojZ+hg+o5weo9BiZ05GRu+Wod9n920ojGaWiNBpVyWLKt4WkLCXfi
	 YBOBovtUL1VJW8FliCiziZicIAkn/3ovB2leKKuNaVBvFokIRyQKFT91s/YHTfWX536fo
	 KE6f8Il0DlPc/KPZPeXANHDiF3hBiHoCuukworVQWUemKlPxsizTvu7B0ShMwWHVF8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=ipQPgJAW;
	arc=none smtp.remote-ip=129.187.255.138
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F0606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=ipQPgJAW
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4jZt3S6S65zydX;
	Thu, 26 Nov 2026 11:25:24 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:to:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=tu-postout21; t=1795688724; bh=EIBh3I4kBpuolM9pnCBMio81J/gT/r
	vUXvi5tC4Fdno=; b=ipQPgJAW+7EwHl7CIxQ6oLhAEgnrT3W+9x9EJhhD5eSL2h
	ziy6yuU5k/dbasolbySlbnKt8GJ/toZQErJWXMOk6fs8Xj8mDHT80HmlX1dAkfZP
	WFxY97YVnS9wgcoQ4OxjMcT5m1jwk2Ik5GSQwoKy/k+oB96w2kDAntqRm3CIn4cL
	Dz5DTMuZ4Rxjfq0YvWlo8P4IBYVhv4Hc7KJxnaTDtQGyeNn1jLKkaI8s5iAOg7b+
	umD06ZxicwjGJTeZzqyUn1qLlGc9vFkqVavGxs2vkzPewZ1U1F/GBqyham5Iv6wt
	drqqvWrheMMacXWbPZifiiXJJlYM8lDE6w7w2dZA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.868
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id TlFJMxPpoVke; Thu, 26 Nov 2026 11:25:24 +0100 (CET)
Received: from [IPV6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614] (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4jZt3R6pTqzybT;
	Thu, 26 Nov 2026 11:25:23 +0100 (CET)
Message-ID: <3aa3966f-3fc5-423e-b44f-007a5db2acc7@tum.de>
Date: Thu, 26 Nov 2026 11:25:23 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: nSVM: Reject EVENTINJ of #BR/#OF into a 64-bit L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com
References: <20261118133741.1185904-1-manuel.andreas@tum.de>
 <CAO9r8zO480eWUqDA6a-4P_tKv2D9Bd5tKNdG79uUBAVtmT15aw@mail.gmail.com>
Content-Language: en-US
From: Manuel Andreas <manuel.andreas@tum.de>
Autocrypt: addr=manuel.andreas@tum.de; keydata=
 xjMEY9Zx/RYJKwYBBAHaRw8BAQdALWzRzW9a74DX4l6i8VzXGvv72Vz0qfvj9s7bjBD905nN
 Jk1hbnVlbCBBbmRyZWFzIDxtYW51ZWwuYW5kcmVhc0B0dW0uZGU+wokEExYIADEWIQQuSfNX
 11QV6exAUmOqZGwY4LuingUCY9Zx/QIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEKpkbBjgu6Ke
 McQBAPyP530S365I50I5rM2XjH5Hr9YcUQATD5dusZJMDgejAP9T/wUurwQSuRfm1rK8cNcf
 w4wP3+PLvL+J+kuVku93CM44BGPWcf0SCisGAQQBl1UBBQEBB0AmCAf31tLBD5tvtdZ0XX1B
 yGLUAxhgmFskGyPhY8wOKQMBCAfCeAQYFggAIBYhBC5J81fXVBXp7EBSY6pkbBjgu6KeBQJj
 1nH9AhsMAAoJEKpkbBjgu6Kej6YA/RvJdXMjsD5csifolLw53KX0/ElM22SvaGym1+KiiVND
 AQDy+y+bCXI+J713/AwLBsDxTEXmP7Cp49ZqbAu83NnpBQ==
In-Reply-To: <CAO9r8zO480eWUqDA6a-4P_tKv2D9Bd5tKNdG79uUBAVtmT15aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/26 22:17, Yosry Ahmed wrote:
> On Wed, Nov 18, 2026 at 5:38 AM Manuel Andreas <manuel.andreas@tum.de> wrote:
>>
>> nested_svm_event_inj_valid_exept() treats BR_VECTOR and OF_VECTOR as
>> unconditionally valid for TYPE=3 (exception) injection.  However, the APM
>> (Vol 2, 15.20) states that injecting an event that is impossible for the
>> guest mode, e.g. #BR into a guest in 64-bit mode, makes VMRUN fail with
>> VMEXIT_INVALID.  BOUND and INTO are both invalid in 64-bit mode.
>>
>> Because the check depends on both the control area (EVENTINJ) and the save
>> area (EFER/CR0/CS), add it to nested_svm_check_cached_vmcb12(), which covers
>> both nested VMRUN and RSM, rather than to nested_vmcb_check_controls().
>>
>> Fixes: 7e79f71bca5c ("KVM: nSVM: Add missing consistency check for EVENTINJ")
>> Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
>> ---
>>  arch/x86/kvm/svm/nested.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index 1cecb82702e2..c69d334e3c3c 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -378,6 +378,8 @@ static bool nested_svm_event_inj_valid_exept(struct kvm_vcpu *vcpu, u8 vector)
>>   * set and:
>>   * - The type of event_inj is not one of the defined values.
>>   * - The type is SVM_EVTINJ_TYPE_EXEPT, but the vector is not a valid exception.
>> + * - The event is impossible in the guest's mode. However this depends on
>> + *   save state, see nested_svm_check_event_inj_mode().
>>   */
>>  static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_inj)
>>  {
>> @@ -398,6 +400,31 @@ static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_inj)
>>         return true;
>>  }
>>
>> +/*
>> + * #BR and #OF are invalid in 64-bit mode, but not in compatibility mode,
>> + * hence the CS.L check. VMRUN ignores EFER.LMA and derives
>> + * long mode from EFER.LME, CR0.PG and CR4.PAE, so do the same.
>> + */
>> +static bool nested_svm_check_event_inj_mode(u32 event_inj,
>> +                                           struct vmcb_save_area_cached *save)
>> +{
>> +       u32 type = event_inj & SVM_EVTINJ_TYPE_MASK;
>> +       u8 vector = event_inj & SVM_EVTINJ_VEC_MASK;
>> +
>> +       if (!(event_inj & SVM_EVTINJ_VALID))
>> +               return true;
>> +
>> +       if (!((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG) &&
>> +            (save->cr4 & X86_CR4_PAE) && (save->cs.attrib & SVM_SELECTOR_L_MASK)))
> 
> Why not check these conditions in nested_svm_event_inj_valid_exept()
> for BR_VECTOR and OF_VECTOR?
> 
Thanks for your response!
As it stands now, we cannot perform the check there since it needs both control
and save state, and we explicitly don't pass save state to
nested_vmcb_check_controls(). I documented this in nested_svm_check_event_inj().

Obviously, we could change this and pass save state to
nested_vmcb_check_controls() and then forward it to
nested_svm_check_event_inj(), but I figured this was an explicit design decision.

>> +               return true;
>> +
>> +       if (type == SVM_EVTINJ_TYPE_EXEPT &&
>> +           (vector == BR_VECTOR || vector == OF_VECTOR))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>  static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>>                                        struct vmcb_ctrl_area_cached *control)
>>  {
>> @@ -488,6 +515,11 @@ int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
>>             !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
>>                 return -EINVAL;
>>
>> +       /* This check requires both save and control state. */
>> +       if (CC(!nested_svm_check_event_inj_mode(svm->nested.ctl.event_inj,
>> +                                               &svm->nested.save)))
>> +               return -EINVAL;
>> +
>>         return 0;
>>  }
>>
>>
>> base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
>> --
>> 2.56.0
>>
>>

