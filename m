Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C331F9BB
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430184; cv=none; b=I0AWRTQERypwCziXCOOaz7K+PYxfm/7QdH7y+D+b97VuiivSx7HFeFx6pVPXKL/lKLhN+i70sU6HLM9s6pBOmmsSDVuwXI4K07EaiSiNneBCCruhW1HbDY+C1+a9NspI0FNGcjBPrdVzvueEvtD9B/Jyj3ExUPxa66Qrr4G61Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430184; c=relaxed/simple;
	bh=SHRlHnFBb6RT2uduseTlAIQY7IM8h3BgQ8QNxXI74p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNmPVZtK4OaaVaT64ffgfJ9gvv+Pac3gS6/LxFxuDdKevtyOijaWoE/XPS5hwQG+ygpHLoiB5LGoy0bQB/U0ztp2Kz2SdNmHeQr45tc8Pwj0Vs+eVhlokcozsMprHPGKE55+91AMgZs23UJtspV+E6SIhzzudG/KHGKyw4htlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E3YbTB6N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=130IaMDj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E3YbTB6N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=130IaMDj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E3YbTB6N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="130IaMDj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E3YbTB6N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="130IaMDj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6887466E66;
	Tue,  2 Jun 2026 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780430181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RMlsky+J/IILv/e9JcIsus1sOb/ywUIZw+tr9gxaYM=;
	b=E3YbTB6N1ljcCvsMC8yPnT8G5ja35oTCyGYpehgvtdMsnAgqmpUlTIsp9j2D52Vx7q2uKY
	tSdn1oDbIcaV1+sl2kSnw2HdLHhP4E13FhgW0sFtzXIHzQZtaI7BhgKq1N74sJHDMRjl00
	1Bd8jywyKeK4+FlXNqzrKHnK64GmIqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780430181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RMlsky+J/IILv/e9JcIsus1sOb/ywUIZw+tr9gxaYM=;
	b=130IaMDj4MuEJ9j/pdKrcq4O/c7SmO+UrsdY0K3p8gipapRd6lH+RuOBBZQ9HwoGGroNce
	bnIFbyIoQXJshZDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780430181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RMlsky+J/IILv/e9JcIsus1sOb/ywUIZw+tr9gxaYM=;
	b=E3YbTB6N1ljcCvsMC8yPnT8G5ja35oTCyGYpehgvtdMsnAgqmpUlTIsp9j2D52Vx7q2uKY
	tSdn1oDbIcaV1+sl2kSnw2HdLHhP4E13FhgW0sFtzXIHzQZtaI7BhgKq1N74sJHDMRjl00
	1Bd8jywyKeK4+FlXNqzrKHnK64GmIqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780430181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RMlsky+J/IILv/e9JcIsus1sOb/ywUIZw+tr9gxaYM=;
	b=130IaMDj4MuEJ9j/pdKrcq4O/c7SmO+UrsdY0K3p8gipapRd6lH+RuOBBZQ9HwoGGroNce
	bnIFbyIoQXJshZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C513A779A7;
	Tue,  2 Jun 2026 19:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ViRmLWQ1H2qyKwAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 02 Jun 2026 19:56:20 +0000
Message-ID: <b43be54c-329c-4b75-bd53-29ac63c1dd37@suse.de>
Date: Tue, 2 Jun 2026 21:56:20 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Fix array_index_nospec() protection in
 kvm_vcpu_ioctl_x86_set_mce()
To: Sean Christopherson <seanjc@google.com>, Tony Luck <tony.luck@intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Jue Wang <juew@google.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260516163412.601908-1-clopez@suse.de>
 <agsmQaqJ5ShSaV07@google.com> <agstY455kTIumJ5P@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <agstY455kTIumJ5P@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 5/18/26 5:16 PM, Sean Christopherson wrote:
> +Tony (questions regarding IA32_MCG_CTL and IA32_MCi_CTL behavior)
> 
> On Mon, May 18, 2026, Sean Christopherson wrote:
>> On Sat, May 16, 2026, Carlos López wrote:
>>> Commit aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and
>>> handle injected UCNA errors") introduced kvm_vcpu_x86_set_ucna(), which
>>> accesses @vcpu->arch.mci_ctl2_banks[] using @mce->bank as the index. The
>>> @mce struct is user-controlled, provided via the KVM_X86_SET_MCE ioctl.
>>>
>>> The caller of this function, kvm_vcpu_ioctl_x86_set_mce(), bounds-checks
>>> @mce->bank and applies array_index_nospec() to advance the @banks
>>> pointer, but @mce->bank itself is passed through unclamped. On a
>>> speculative path that bypasses the bounds check, the raw @mce->bank
>>> value can index mci_ctl2_banks[] out-of-bounds.
>>>
>>> In practice this is a very weak gadget, and would at most allow leaking
>>> a single bit in a 64-bit integer, but prevent potential future issues by
>>> clamping @mce->bank in place with array_index_nospec(), before passing
>>> the struct to kvm_vcpu_x86_set_ucna().
>>>
>>> Fixes: aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and handle injected UCNA errors")
>>> Signed-off-by: Carlos López <clopez@suse.de>
>>> ---
>>>  arch/x86/kvm/x86.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 209eae67ab18..2d2415031267 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -5497,7 +5497,8 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
>>>  	if (mce->bank >= bank_num || !(mce->status & MCI_STATUS_VAL))
>>>  		return -EINVAL;
>>>  
>>> -	banks += array_index_nospec(4 * mce->bank, 4 * bank_num);
>>> +	mce->bank = array_index_nospec(mce->bank, bank_num);
>>> +	banks += 4 * mce->bank;
>>>  
>>>  	if (is_ucna(mce))
>>>  		return kvm_vcpu_x86_set_ucna(vcpu, mce, banks);
>>
>> As a follow-up, I think we should fold kvm_vcpu_x86_set_ucna() into
>> kvm_vcpu_ioctl_x86_set_mce().  Splitting it to a separately helper makes it
>> unnecessarily difficult to see the usage of mce->bank.
>>
>> Hmm, and isn't the handling of UNCA errors misplaced?  Per the SDM, the only
>> allowed values for IA32_MCG_CTL are -1ull and 0.
>>
>>   IA32_MCG_CTL controls the reporting of machine-check exceptions. If present,
>>   writing 1s to this register enables machine-check features and writing all 0s
>>   disables machine-check features. All other values are undefined and/or
>>   implementation specific.
>>
>> I don't see anything the SDM that exempts UNCA from that logic.  Ditto for the
>> similar IA32_MCi_CTL check.  So on top of your fix, over two patches, I think we
>> should end up with this?
> 
> ...
> 
>> Unless I'm wrong, I'll send a v2 with your fix plus two more patches.
> 
> Heh, I was partially wrong.  I think.  The IA32_MCi_CTL MSRs control whether or
> not a #MC is reported, but don't change error _logging_.
> 
>   Setting an EEj flag enables signaling #MC of the associated error and clearing
>   it disables signaling of the error. Error logging happens regardless of the
>   setting of these bits. The processor drops writes to bits that are not implemented.
> 
> Ah, I was definitely wrong.  Section 17.5 CORRECTED MACHINE CHECK ERROR INTERRUPT
> explicitly says so:
> 
>   CMCI is not affected by the CR4.MCE bit, and it is not affected by the
>   IA32_MCi_CTL MSRs.

Right, so the existing UCNA behavior is correct, since it always logs
the error and delivery is gated on MCi_CTL2.

> Actually, that means the existing code is wrong, and has been since commit
> 890ca9aefa78 ("KVM: Add MCE support").
>
> Hrm, and I'm not convinced KVM's handling of IA32_MCG_CTL is correct either.  The
> SDM says it controls reporting of _exceptions_, it doesn't say anything about
> disabling loggin of errors.
> 
>   IA32_MCG_CTL controls the reporting of machine-check exceptions.
> 
> 
> Tony,
> 
> Does clearing IA32_MCG_CTL affect error logging *and* #MC generation, or just #MC
> generation?  And if it impacts logging, does it also apply to UCNA errors?

The AMD manual does not clarify much either (9.3.1.3 Machine-Check
Global-Control Register):

  MCG_CTL is used by software to enable or disable the logging and
  reporting of machine-check errors from the implemented error-reporting
  banks. Depending on the implementation, detected errors from some
  error sources associated with a reporting bank that is disabled are
  still logged.

But my reading here is that MCG_CTL *does* control logging in the
general case, with some implementation-specific exceptions.

So if I get the picture correctly:

* UCNA error logging in KVM is always happens (good), and delivery is
  done via CMCI based on MCi_CTL2 (good). Nothing to fix here, unless
  MCG_CTL does affect logging (although it would be a bit strange for
  this to be true while CR4.MCE and MCi_CTL are explicitly mentioned to
  *not* have this behavior for CMCI).
* Non-UCNA error logging is broken, at least on the count that logging
  is gated based on MCi_CTL, when it should not. The spec is ambiguous
  on whether MCG_CTL controls logging for these. Current behavior in KVM
  is to *do* the gating based on MCG_CTL; the spec suggests that this
  may be correct at least on AMD (but it is not symmetric with MCi_CTL
  behavior).
