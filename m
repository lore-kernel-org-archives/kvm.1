Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110708;
	b=3nDnayepMFubkqggD+YIblPSnt6rnItYjX1ZMcPnYDnltfSFe0ujVS4MAqCRMrFRt2bs
	 qNtp1984jV59eiIMl7cPMi8bOlo/2os237NvW1SGku5H/+zauYpk33LEQwYbCI6TqTpCN
	 rSpAq0kuk91gnJ5BjzrpBZhAVcU8Dx153cTtCYamZMLold8F/q5tuma4uNuaFnGcX6PTh
	 GpY6tz1vD53cazuz9ZyQ4Rq2pyYM5xo7H12/UA09UUdjCmzOJN1o8mw+FnDTMLpshPr6h
	 b9sd9ehEr55/Z8d8PGC7dBicoFmAW5e0w2AyUnt6tqfdxKS38O32lawjPOIJdvTcqmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110708;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=kLUuXEct/70Wa2hXYkLLPK9YJxHHE+htCI8+KKJrGKw=;
	b=WJVPmq28pfbomcEXas5M/VkmKuWFqgD/R4qkgNQGlaMCDPOVW9sD3UxS+mxUQEfFQsLr
	 2T95YP9RWMjZY0p6BRCAugKZSEYM8tHykmuweDbI/dxICSNObMxLvrboL8eyKTyuZnpGX
	 gSulv6BM0Go+ueNWSMzJ77qKAaj0+7olTneLQRMOEk97FyS9Tux8CO86zM2jokRCVOfKs
	 TRnNMRG/unnLyzpugHPWcwfMvwPd4s1pkBTst0zzAmjHM7+fhoas+AwL5WqlQpjlMr4YO
	 rsMDvhk3zL1vR4xmsN1ZMZw3TpJd1c75LeZvn7oaEkaFQ3pn2WKD4XgzNCCF13ogbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2RUKIbab;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3mWbV5fy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=thpH4jmM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=M2HUgMsk;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCC606A31A;
	Tue, 27 Oct 2026 14:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37CCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2RUKIbab;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3mWbV5fy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=thpH4jmM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=M2HUgMsk
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14F71F454;
	Tue, 27 Oct 2026 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793110705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLUuXEct/70Wa2hXYkLLPK9YJxHHE+htCI8+KKJrGKw=;
	b=2RUKIbabcxDnkd6NG+v1ee3UincbPQnP+/Qjs+8JXhr3FeuV14PVtv5tY9fqFVvZ+qIxOr
	l3BsLJG3PaG5Tb8YM4+1aMSMQMhdpZtM0vBNSlKfTOy4GCGsXYjoYSRKYfTaKk1mEo7Rth
	ipxjAC+imVsYhWOSPhOUodn7Y4QnKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793110705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLUuXEct/70Wa2hXYkLLPK9YJxHHE+htCI8+KKJrGKw=;
	b=3mWbV5fy8dOlTUvv2cicPxtpcV1If7eNcNUQfYEwNnSG42s5eJsxBH/ELvPN9F6N66kfhX
	DK3oPMfz6bShPYCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=thpH4jmM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M2HUgMsk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793110704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLUuXEct/70Wa2hXYkLLPK9YJxHHE+htCI8+KKJrGKw=;
	b=thpH4jmMtZ7LtwKLphMNfsV6glfLUePahuULXo/kIgTHV6Gl5/kQj13s9qaud6On2OVjgd
	UiOS48FBus9q6ZVyxqa7gjZeEOU/GpX+KcJR1hejp4ZLgMcUZ6jFfKe1NBzpZlHDoHajVW
	9I9x+DilG/C0kxTnCuKe989ttZTpb/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793110704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLUuXEct/70Wa2hXYkLLPK9YJxHHE+htCI8+KKJrGKw=;
	b=M2HUgMskzTahn2Rmd2YDsmATgsPrM5B144gm8rds7TcpUSGpIbp6BpjHp33GhWfjod2595
	AyeqW5W2JJT1PbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4995D1321C;
	Tue, 27 Oct 2026 14:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9nDDBLCy4GqpfgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 27 Oct 2026 14:18:24 +0000
Message-ID: <c76191d7-6be8-41bc-928d-5bb2f5df77f7@suse.de>
Date: Tue, 27 Oct 2026 15:18:08 +0100
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
Subject: Re: [PATCH v3 0/2] KVM: x86: MCE fixes
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 pbonzini@redhat.com, kvm@vger.kernel.org
References: <20260609131856.2562222-2-clopez@suse.de>
 <178405244468.3109537.2871662581077641578.b4-ty@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <178405244468.3109537.2871662581077641578.b4-ty@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: F14F71F454

Hi Sean,

On 7/14/26 8:41 PM, Sean Christopherson wrote:
> On Tue, 09 Jun 2026 15:18:54 +0200, Carlos López wrote:
>> These two patches are somewhat unrelated, but patch 2 came out of
>> Sean's suggestions from reviewing the first patch (see [1]). Patch 1 is
>> unchanged.
>>
>> v3:
>>   * Address Sashiko's review. While incorrect in pointing out MCIP's
>>     role, it was partially correct in the sense that the MCE logging
>>     rules were still not fully compliant to the SDM.
>>
>> [...]
> 
> Applied patch 1 to kvm-x86 misc so it doesn't get waylaid any longer.  I'll
> respond to patch 2 at some point (hopefully today, but it might not be until
> next week).

I believe this fell through the cracks. Did you have time to take
another look at patch 2? Not urgent.

> [1/2] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
>       https://github.com/kvm-x86/linux/commit/249f9be58c7f
> 
> --
> https://github.com/kvm-x86/linux/tree/next

Thanks,
Carlos

