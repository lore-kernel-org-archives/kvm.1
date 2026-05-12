Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC537BE80
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624148; cv=none; b=S+UstGJ7tJnyGP3FRerBKlYByUoGUpvSE/+TldWHNFBNpYfJlooTniUUih4pQlniJKAGTwELLKFdxkiYEMbAN0jw1IR16N6L+FiznnDo4eWby0E/Fk6JwSFtbwelyWP8Ew28YT3HKtcgBTIAEoRQ/0xdQ7/+cH3jGqcNxUBqLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624148; c=relaxed/simple;
	bh=0YvYsXF3XdE4p6SyNQHAi/RyftiKppjLIyVDA8tCpqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUYoQ3t/b2c1iAlCe3kUjoWKvfU1HPguoT6yiFnDmy9smVBamf30ei4VXjib8zRbPYzmDjCAkKEHnThRn2SrCbUY8hWJT8wMGJ0L3Y19ba2zbUoQDhqToH8sCTzCvrYLhTWxl4ML6t53G+ToCUCvl9cE8FO80sTl9tr8dn/3rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DQZNAJ3w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lhNTJJ+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DQZNAJ3w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lhNTJJ+j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DQZNAJ3w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lhNTJJ+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DQZNAJ3w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lhNTJJ+j"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E427759B4;
	Tue, 12 May 2026 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778624145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxe/+Jpbp8E/HlM8jj6RcPcuy9MGGGKnNGD9NCchGHY=;
	b=DQZNAJ3wu8l4mffzZf4S6f8uY7lpsPns9eI0dM6D/9kFQNks9Kr635wBOQ8pCYsJ0qL+Nf
	CLCJHws0gMew4aYmhD0QB1x+OqPKTaSHSdiWt0XPmCE3EOw+v76dUo6WLz/g9rnIcPPlZp
	bUvYCkQCC0TaCn5QC/X1UDgfvyvI348=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778624145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxe/+Jpbp8E/HlM8jj6RcPcuy9MGGGKnNGD9NCchGHY=;
	b=lhNTJJ+jvnNfayLkKpjZDhQheYLAlvVnsuW7Y01TemObq5iC7J9XqgiMUJ9yRIK2OSGid5
	wXzO5rX593uEiSCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DQZNAJ3w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lhNTJJ+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778624145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxe/+Jpbp8E/HlM8jj6RcPcuy9MGGGKnNGD9NCchGHY=;
	b=DQZNAJ3wu8l4mffzZf4S6f8uY7lpsPns9eI0dM6D/9kFQNks9Kr635wBOQ8pCYsJ0qL+Nf
	CLCJHws0gMew4aYmhD0QB1x+OqPKTaSHSdiWt0XPmCE3EOw+v76dUo6WLz/g9rnIcPPlZp
	bUvYCkQCC0TaCn5QC/X1UDgfvyvI348=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778624145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxe/+Jpbp8E/HlM8jj6RcPcuy9MGGGKnNGD9NCchGHY=;
	b=lhNTJJ+jvnNfayLkKpjZDhQheYLAlvVnsuW7Y01TemObq5iC7J9XqgiMUJ9yRIK2OSGid5
	wXzO5rX593uEiSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89AE6593A9;
	Tue, 12 May 2026 22:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6hTGHpCmA2oxXgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 12 May 2026 22:15:44 +0000
Message-ID: <15a8f740-6e88-4455-b38e-81779b6d9c91@suse.de>
Date: Wed, 13 May 2026 00:15:39 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260512213719.20974-1-clopez@suse.de>
 <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3E427759B4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/12/26 11:48 PM, Edgecombe, Rick P wrote:
> On Tue, 2026-05-12 at 23:37 +0200, Carlos López wrote:
>> In the x86 architecture, 32-bit operations zero-extend the result in the
>> destination register to 64 bits. This includes the CPUID instruction,
>> which writes 32-bit values EAX/EBX/ECX/EDX.
>>
>> When handling the CPUID instruction via #VE, copy only the lower 32-bits
>> provided by the hypervisor for the output registers, and zero out the
>> upper half.
>>
>> Fixes: c141fa2c2bba ("x86/tdx: Handle CPUID via #VE")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>  arch/x86/coco/tdx/tdx.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index c8b9e86d0488..a2fe1ae019bd 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -543,10 +543,10 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
>>  	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
>>  	 * So copy the register contents back to pt_regs.
>>  	 */
>> -	regs->ax = args.r12;
>> -	regs->bx = args.r13;
>> -	regs->cx = args.r14;
>> -	regs->dx = args.r15;
>> +	regs->ax = lower_32_bits(args.r12);
>> +	regs->bx = lower_32_bits(args.r13);
>> +	regs->cx = lower_32_bits(args.r14);
>> +	regs->dx = lower_32_bits(args.r15);
>>  
> 
> Can you explain the impact here? Why should the guest fixup what the VMM
> emulates?

It's a correctness issue. The CPUID instruction has 32-bit operands,
which should be zero extended as per the SDM. Other code like read_msr()
in that same file does the same zero-extension. There was also a patch
sent for a similar issue in handle_in() not that long ago.

In terms of how this could materialize, if you have code like this:

	asm volatile("cpuid"
	    : "=a" (eax),
	      "=b" (ebx),
	      "=c" (ecx),
	      "=d" (edx)
	    : "0" (eax), "2" (ecx)
	    : "memory");

The compiler would be allowed to assume that e.g. RAX can be used as an
already-zero-extended register.

Best,
Carlos
