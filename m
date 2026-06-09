Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C734192E1
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009801; cv=none; b=EYZe0j8Vo/tkjuMss2jRD3t09mx0KmpVV8g7+J/Wt+sbj19E3HtG6G1vdi4A9I9833TDe1C5H8NtGBvF50/+UZFqiWOz5a91pKsoSnhyilD218qhLjy49mlogqoUFeC77L5AmPNG51NojJxP9/NC1rwvRRW4V/3anzDSXIbvVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009801; c=relaxed/simple;
	bh=W3VVv8w7O8NsuvevGkI+HPwIbasarLMRJoV8rL4P4/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gySQ0np7pevWYbS9JV4RjJQojemdGOgZYF2j3MqGUwd74oNZESHMt7f5roDGlcsspoZ2sYNUn6vXqLVhPvLUp/yt8SgF9lFEGkI1jrqVSC1aG3xcB5QLlPHHLAQVRuMn5MYTSTBc3YIo/mzbocin/O6ChfLEh8cYZ86qe/+F2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSu81QoH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zGaKbvY3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSu81QoH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zGaKbvY3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSu81QoH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zGaKbvY3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSu81QoH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zGaKbvY3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10DB16AC3B;
	Tue,  9 Jun 2026 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781009798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T66gqKrB+hOrTOe+15wRB7xkdjL7vspaccmWAvn9gYw=;
	b=eSu81QoHeoupr9FT5wLWuHfSqkttPYMTWZD/Nwti6otDsohmVsxDsjJEWV9Hbthu5Rln4f
	br77kdq33JynWcONKlxPle53S8zkPR6eaGTdDBzHptetQFpB/6pua9rjGBs++Re1BGl8+q
	pY1/VVQHuw2X/3QpmvvSC1zVJDMe6Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781009798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T66gqKrB+hOrTOe+15wRB7xkdjL7vspaccmWAvn9gYw=;
	b=zGaKbvY3InEeLbar4s+a01V4kZhMXqwSodtJAl288cWDoH1SC72lnOu8bRDI1kZm+KQLTg
	3YgbNyLR9KazE/DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781009798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T66gqKrB+hOrTOe+15wRB7xkdjL7vspaccmWAvn9gYw=;
	b=eSu81QoHeoupr9FT5wLWuHfSqkttPYMTWZD/Nwti6otDsohmVsxDsjJEWV9Hbthu5Rln4f
	br77kdq33JynWcONKlxPle53S8zkPR6eaGTdDBzHptetQFpB/6pua9rjGBs++Re1BGl8+q
	pY1/VVQHuw2X/3QpmvvSC1zVJDMe6Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781009798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T66gqKrB+hOrTOe+15wRB7xkdjL7vspaccmWAvn9gYw=;
	b=zGaKbvY3InEeLbar4s+a01V4kZhMXqwSodtJAl288cWDoH1SC72lnOu8bRDI1kZm+KQLTg
	3YgbNyLR9KazE/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5883779A7;
	Tue,  9 Jun 2026 12:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJwmMYUNKGpmcwAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 09 Jun 2026 12:56:37 +0000
Message-ID: <a071493a-185b-48b2-a0ff-ba02a1c4730e@suse.de>
Date: Tue, 9 Jun 2026 14:56:33 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: x86: Do not gate MCE logging based on
 IA32_MCi_CTL
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260609105525.2545638-4-clopez@suse.de>
 <20260609111012.8B1111F00899@smtp.kernel.org>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <20260609111012.8B1111F00899@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -4.30

On 6/9/26 1:10 PM, sashiko-bot@kernel.org wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -5486,24 +5486,31 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
>>  	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
>>  	    vcpu->arch.mcg_ctl != ~(u64)0)
>>  		return 0;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this global control
> register check also need to be adjusted?
> 
> Just like IA32_MCi_CTL, the Intel SDM states that error logging happens
> regardless of the setting of the IA32_MCG_CTL bits. By returning early
> here, KVM skips logging the uncorrectable error to the bank if the global
> reporting is disabled.

Does the SDM specify so, though? As Sean noted, and as echoed in the
cover letter, this is pretty ambiguous.

> Additionally, KVM currently suppresses generation and logging for all
> banks if any bit in IA32_MCG_CTL is 0, rather than checking the specific
> bit for the bank. Should the logging logic be hoisted above this check
> as well?
> 
>> -	/*
>> -	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
>> -	 * reporting is disabled for the bank
>> -	 */
>> -	if ((mce->status & MCI_STATUS_UC) && banks[0] != ~(u64)0)
>> -		return 0;
>> +
>>  	if (mce->status & MCI_STATUS_UC) {
>> +		/*
>> +		 * Per the SDM, error logging always happens independently of
>> +		 * IA32_MCi_CTL
>> +		 */
>> +		if (banks[1] & MCI_STATUS_VAL)
>> +			mce->status |= MCI_STATUS_OVER;
>> +		banks[2] = mce->addr;
>> +		banks[3] = mce->misc;
>> +		banks[1] = mce->status;
>> +
>> +		/*
>> +		 * if IA32_MCi_CTL is not all 1s, the uncorrected error
>> +		 * reporting is disabled for the bank
>> +		 */
>> +		if (banks[0] != ~(u64)0)
>> +			return 0;
>> +
>>  		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
>>  		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
>>  			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>>  			return 0;
>>  		}
> 
> [Severity: High]
> By hoisting the error logging block above the IA32_MCi_CTL check, does
> this now incorrectly overwrite the MCE banks when a double or triple fault
> occurs?
> 
> According to the SDM, if the processor encounters another machine-check
> error while the MCIP flag is already set, it causes a triple fault and
> does not update the status registers for the second error.

17.3.1.2 "IA32_MCG_STATUS MSR" does not say anything about updating or
not addr/misc/status depending on MCIP, it just says:

  The occurrence of a second Machine-Check Event while MCIP is set will
  cause the processor to enter a shutdown state.

Claude helped me find a good counterexample to what Sashiko says
regarding MCIP. Table 18-40 "Machine Check Error Codes for
IA32_MC4_STATUS" says this about bits 19:16:

  Model specific error code bits 19:16.
  If MACOD = 40CH, MSCOD encoding should be interpreted as:
  01H: MCE when CR4.MCE is clear.
  02H: MCE when MCIP bit is set.

MSCOD=02H is precisely a case of an update to an MCi_STATUS MSR while
MCIP is set.

> Since the logging block in kvm_vcpu_ioctl_x86_set_mce() now executes
> before checking for MCG_STATUS_MCIP, it looks like it will overwrite the
> original addr, misc, and status of the first error before requesting the
> triple fault.

17.3.2.2 "IA32_MCi_STATUS MSRS" does say that a second UC *to the same
bank* should not overwrite the first:

  OVER (machine check overflow) flag, bit 62 - (...). Uncorrected errors
  are not written over previous valid uncorrected errors. (...)

But this has nothing to do with MCIP. So, IIUC, the the new behavior is
still not completely correct because a second UC to the *same* bank
would overwrite the first. I can prepare a v3 with this.

> 
>> -		if (banks[1] & MCI_STATUS_VAL)
>> -			mce->status |= MCI_STATUS_OVER;
>> -		banks[2] = mce->addr;
>> -		banks[3] = mce->misc;
>>  		vcpu->arch.mcg_status = mce->mcg_status;
>> -		banks[1] = mce->status;
>>  		kvm_queue_exception(vcpu, MC_VECTOR);
>>  	} else if (!(banks[1] & MCI_STATUS_VAL)
> [ ... ]
> 

