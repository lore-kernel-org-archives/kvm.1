Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540336D51B
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431745; cv=none; b=uNcYUr8XIlPaIEhpgY9BUT8ZzqJkxQv66B0sFyCUAEJH9i4ByzXHPkwGB5dyOGo1K5gunma/7RK+h+iutcbrnahcZhl563BwhG+kEe7ChWHMDnmAST4LTHkCOD6Yb5fO1FGesbkRw4kBwMdiSA+163GOoRf+ooqap651Qf9rYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431745; c=relaxed/simple;
	bh=Qv3JvDkm8hCcmrjfiniUl+Y8ziJM5NqqVyuyWRG1av8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u6aldWms58lxrj5vk0dm5IFlalz/Mgtl9wMDloam0SEl+6CJ7Bs60uwqX0DYzCHv/vNgNDoT0QVv6ghBfVGFI5jSCFeNQdmagohyNbstmzGv2nHHgES81purtu9K7RMjuRGgD97nB4aGhOihdokBwh4NACRxDPnINvb/J8t+Kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TrnV+ets; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQBcsbVL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gie+lCBN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zY/IO0x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TrnV+ets";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQBcsbVL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gie+lCBN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zY/IO0x"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0EBE66DC9;
	Tue,  2 Jun 2026 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780431743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjnQQwkahzIkILAnzRaCar7FIkcO2tCSoW/hwwQZz08=;
	b=TrnV+etspDJ4+Dcz9FVQEj+/ybOQhSIMikawBoPzmpmAJXp/oV3a07CkqupCthD3jEgYuw
	rK+hhkI+LyB1rlFtwOIhr5UOjvNFuh3L+Glpoc9/9yI7Eirv6fbi6zixjW3pnMgQsTo9HA
	F6vLYOX21Dvez1RECA536zj+1YcP/iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780431743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjnQQwkahzIkILAnzRaCar7FIkcO2tCSoW/hwwQZz08=;
	b=kQBcsbVLIwVs+QrJTKoH4hnX5YdeZphL3m5bSyr0ZT9pchjxs8+lH6o+6nOpgEksCl9NvT
	isoEh5E4lBNtKwDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gie+lCBN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5zY/IO0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780431742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjnQQwkahzIkILAnzRaCar7FIkcO2tCSoW/hwwQZz08=;
	b=Gie+lCBNPvVf60u8AKXUJ2g14oEZYVLKxSrN0oaL3FV/RuxngFg4KAEccaJrUeYSIgHoGz
	jX4yD6/ew0296Pqntkhzb7zhxNpTz2VChDL2eP4Sh+QjkEAJ4nALrStg9xCLY394H7j7Aq
	uXrT4cQpOd3ZK3XFel4YdxbczplSe1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780431742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjnQQwkahzIkILAnzRaCar7FIkcO2tCSoW/hwwQZz08=;
	b=5zY/IO0x8ifsJWuWD4yryYPp4lmbK0qFB+/PBWJoZpMtcWWDTwJJNlypNmgMELfXAItFyb
	OaODEsal+lYx3KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41F30779A7;
	Tue,  2 Jun 2026 20:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1IaWDH47H2qqQwAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 02 Jun 2026 20:22:22 +0000
Message-ID: <a6c36a35-c39c-4dec-b1e6-238297aa7159@suse.de>
Date: Tue, 2 Jun 2026 22:22:17 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Fix array_index_nospec() protection in
 kvm_vcpu_ioctl_x86_set_mce()
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
To: Sean Christopherson <seanjc@google.com>, Tony Luck <tony.luck@intel.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260516163412.601908-1-clopez@suse.de>
 <agsmQaqJ5ShSaV07@google.com> <agstY455kTIumJ5P@google.com>
 <b43be54c-329c-4b75-bd53-29ac63c1dd37@suse.de>
Content-Language: en-US
In-Reply-To: <b43be54c-329c-4b75-bd53-29ac63c1dd37@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E0EBE66DC9
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/2/26 9:56 PM, Carlos López wrote:
> ...
> * Non-UCNA error logging is broken, at least on the count that logging
>   is gated based on MCi_CTL, when it should not. The spec is ambiguous
>   on whether MCG_CTL controls logging for these. Current behavior in KVM
>   is to *do* the gating based on MCG_CTL; the spec suggests that this
>   may be correct at least on AMD (but it is not symmetric with MCi_CTL
>   behavior).

So something like this?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9e40f2a5996..259dba2a3299 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5505,24 +5505,31 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vcpu *vcpu,
 	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
 	    vcpu->arch.mcg_ctl != ~(u64)0)
 		return 0;
-	/*
-	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
-	 * reporting is disabled for the bank
-	 */
-	if ((mce->status & MCI_STATUS_UC) && banks[0] != ~(u64)0)
-		return 0;
+
 	if (mce->status & MCI_STATUS_UC) {
+		/*
+		 * Per the SDM, error logging always happens independently of
+		 * IA32_MCi_CTL
+		 */
+		if (banks[1] & MCI_STATUS_VAL)
+			mce->status |= MCI_STATUS_OVER;
+		banks[2] = mce->addr;
+		banks[3] = mce->misc;
+		banks[1] = mce->status;
+
+		/*
+		 * if IA32_MCi_CTL is not all 1s, the uncorrected error
+		 * reporting is disabled for the bank
+		 */
+		if (banks[0] != ~(u64)0)
+			return 0;
+
 		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
 		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
 			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 			return 0;
 		}
-		if (banks[1] & MCI_STATUS_VAL)
-			mce->status |= MCI_STATUS_OVER;
-		banks[2] = mce->addr;
-		banks[3] = mce->misc;
 		vcpu->arch.mcg_status = mce->mcg_status;
-		banks[1] = mce->status;
 		kvm_queue_exception(vcpu, MC_VECTOR);
 	} else if (!(banks[1] & MCI_STATUS_VAL)
 		   || !(banks[1] & MCI_STATUS_UC)) {
