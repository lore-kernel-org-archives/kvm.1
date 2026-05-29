Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A834B662
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063036; cv=none; b=mVZCGyfsE22j4U7sbaqox1uddUoGCdmWIu0gEHd5CH6yDvjsEeYv6o9wLM8x9WexpyOlK6qLCoW4Q+J95lNN/SIyCFHqOaqztnshHIR2P5DB8+vZtYYwH8oVxB+A9mHwCaI1w+l2kSkbjtYbMhDjwdlzdyNT6TU6FUTpZWd6rF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063036; c=relaxed/simple;
	bh=6QpY26GkcFxuw85jvgp0WSu/YGhR0058kc0DMxRj8CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKMw2vu/UQUkmse/CqWjL9PG8d9CxOwMnQm41LslwCd+kzeYQNXyEK5l2hObcMjQktkuyqmWuUyuLVM4kTG6j/9NZfN5Aqm1WuFhnARpTzBUrWzYJQ0DWaFCKmsbxYt3hK38DW5CZy9rxb9DDIyXe7o+rGggQNGP7IIX6BWdRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H5xh2tiN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W7gin8J/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A6n4eWd8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=onoMqQdM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H5xh2tiN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W7gin8J/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A6n4eWd8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="onoMqQdM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F059F66E3A;
	Fri, 29 May 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOmM9f7syCZ9oJNRkWLqR2+sZGzcBzO9HkWKUtKZfpE=;
	b=H5xh2tiN537quDhGlDOV9BzNfMq/4HZrD6+YhSOAew98w1eYHSjWIBBEPNxF5tUqqqvZnm
	xhPStexj9jwKaq3TA1mg2gxVgtjeF2DElpsPz6vYFbY8qwd/9hP476tEZHIDuplf8cgJJO
	pxrQz7h7q2lhImgfnUXlKTGCslRZqTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOmM9f7syCZ9oJNRkWLqR2+sZGzcBzO9HkWKUtKZfpE=;
	b=W7gin8J/d8gabDJTYwd+oBsUD4s+t0q7fIc9AFj8NIcKG673McJtz/oPvNnydX4NZJDG8I
	XQLSuEDpufPjhZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780063029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOmM9f7syCZ9oJNRkWLqR2+sZGzcBzO9HkWKUtKZfpE=;
	b=A6n4eWd8xPWD9qGTCLSAIHU3xmm/BugxeInd8vzwEm8whNe2PsalhSoJsD3IGroJFY4/hP
	e7UTl8WQL/wEjuLz48Rwtp8M+fEk2s8F0O8AD447RZj+fapCdFEUpJ71ffXyrwfEp7S8Yv
	9YtNyUGhhnlh7VFfIpMlUFmX1jSKGxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780063029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOmM9f7syCZ9oJNRkWLqR2+sZGzcBzO9HkWKUtKZfpE=;
	b=onoMqQdM/G89VnIUT00vpuhQrtTjsHNn4vBQnZyjhj5XJ8isP7tvzsgVs7e3qyPFgZAwbr
	Q8UbvepaNHgqPXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23519779A7;
	Fri, 29 May 2026 13:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9m+wBTWbGWpPYQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 29 May 2026 13:57:09 +0000
Message-ID: <99613b74-44db-4233-9480-26cc04bc0c7b@suse.de>
Date: Fri, 29 May 2026 15:57:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, stable@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@qumranet.com>,
 Qing He <qing.he@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260529091714.287963-2-clopez@suse.de>
 <ahmTjp-95M5IjGxu@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <ahmTjp-95M5IjGxu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/29/26 3:24 PM, Sean Christopherson wrote:
> On Fri, May 29, 2026, Carlos López wrote:
>> When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
>> the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
>> updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
>> same PIC state does not grab such lock, potentially causing torn reads
>> for userspace.
> 
> Meh, if userspace hasn't fully paused the VM, save/restore is going to fail
> anyways.  Heck, torn reads is probably _better_ than the alternative, because
> at least that might cause visible failure during the restore.  If there are
> concurrent modifications in-flight, then KVM_GET_IRQCHIP is going to return
> stale data (assuming userspace doesn't redo KVM_GET_IRQCHIP), i.e. save/restore
> will effectively corrupt the guest.

Right, do you want a v2 to at least prevent userspace from reading a
torn state? It seems wrong to have this asymmetry with KVM_SET_IRQCHIP
and other save/restore ioctls (e.g. KVM_{G,S}ET_PIT).

>> Fix this by grabbing the lock on the read path.
>>
>> This issue goes all the way back. The bug was introduced with the
>> addition of PIC ioctl code itself in 6ceb9d791eee ("KVM: Add get/
>> set irqchip ioctls for in-kernel PIC live migration support"). Later,
>> 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU
>> ioctl paths") added the locking for kvm_vm_ioctl_set_irqchip(), but
>> missed kvm_vm_ioctl_get_irqchip().
>>
>> Fixes: 6ceb9d791eee ("KVM: Add get/set irqchip ioctls for in-kernel PIC live migration support")
>> Fixes: 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU ioctl paths")
>> Cc: stable@vger.kernel.org
> 
> This isn't stable material.  There's basically zero chance this actively
> problematic for any VMM.
> 
> Honestly, it's tempting to I'm tempted to do the opposite, and yank out the
> locking for the KVM_SET_IRQCHIP path, because userspace really can't be relying
> on kernel locking for correctness across save/restore.  I don't _actually_ think
> we should do that, but it certainly is tempting.
> 
> Ah, actually, maybe SET has locking because it's also used to reset PIC state,
> i.e. isn't limited to just save/restore?  Doesn't really matter.
> 
>> Reported-by: Claude Code:claude-opus-4.6
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>  arch/x86/kvm/irq.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
>> index 9519fec09ee6..251df563427b 100644
>> --- a/arch/x86/kvm/irq.c
>> +++ b/arch/x86/kvm/irq.c
>> @@ -584,14 +584,18 @@ int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
>>  
>>  	r = 0;
>>  	switch (chip->chip_id) {
>> -	case KVM_IRQCHIP_PIC_MASTER:
>> +	case KVM_IRQCHIP_PIC_MASTER: {
>> +		guard(spinlock)(&pic->lock);
> 
> I'd much rather use "manual" spin_(un)lock() instead of guard().  Or scoped_guard()
> to avoid the curly braces, but even then, I find this:
> 
> 		scoped_guard(spinlock, &pic->lock)
> 			memcpy(&chip->chip.pic, &pic->pics[0],
> 			       sizeof(struct kvm_pic_state));
> 
> to be much harder to read than:
> 
> 		spin_lock(&pic->lock);
> 		memcpy(&chip->chip.pic, &pic->pics[0],
> 			sizeof(struct kvm_pic_state));
> 		spin_unlock(&pic->lock);
> 
> And no one can reasonably argue that guard() or scoped_guard() makes the this
> particular code more robust.

Oh well, the guard seemed more readable to me but I don't have a strong
opinion either way, I can add this to v2 (if you want it).
