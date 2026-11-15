Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770217;
	b=lAAZzFKafw86SFCnQuYRfkiEghgpDcE0R+FWdlYX4M4x0zEXJCa8+KGQ11rRY+R9eLLz
	 efqLljlI05dRrhd2OUJ845obAVaVMFrmBs1B3dtDKqPCToVh4gEgzmnP+GoiFY7k8Afo1
	 wTG0+p3p776V+f0+acCMfLl3ihSzUzrOtIAXwcJRo+HDoGtNZAfac5Y3YeiAci5uA9kvf
	 r81RIYbcaTinqGYo/54T0mlcxDTpGGrwSObEPQQRXZmg2FdPg4xuDW6k6KA5G87Y2pd8w
	 /EPCYR1XOsbDuXuEyJiVsRS4choyhutTfr0hV4SnoTqWFpvB7NmzJ2BWTCRde2RJisg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770217;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=gj/STAif1P9RZJBVspyigsA9jI1Pz88cJGa45owyE14=;
	b=dhWboOmUZhQdE5OsUmcjnFGtEiEq4h3IDsO4oB+SK32w3Miqxm3YFW4nHwwB2SO+yva9
	 7qhdAa4B9skTlaE5ZRr8JhzIzdIAO2eJqYRUkyQ/bperAURARX0w5XXeQb5YoqnJPQG6d
	 HPvsPjU1PTttDtE22c9F7MYNNYHtsjzWKcszqvGhgqp+DDhCoiiTC6a06zvtfT9mUwbCT
	 dtX8EAs2vm4qE0/P97Y7M+IQlVhKDlnhkp9pTUVCBhtrG3s7C7RyHSQsB57E55kV0e3VM
	 JTqidkokho6S2uF86bzNysmX2ae4FHlwIwe6LrC0Bpbvb6AvvHUanLdT7fhl2D5tbMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NFRqlvca;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fQzbBMrP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NFRqlvca;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fQzbBMrP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A6606A31F;
	Sun, 15 Nov 2026 19:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844A6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NFRqlvca;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fQzbBMrP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NFRqlvca;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fQzbBMrP
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30C011F453;
	Sun, 15 Nov 2026 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794770214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj/STAif1P9RZJBVspyigsA9jI1Pz88cJGa45owyE14=;
	b=NFRqlvcaRg6/6Yg9Vbo1fs6+OtdRO1OF52jH6rmaLsrLo7pRJ3alJel+EZwvzTEdovbnf2
	EpGj64g5vhi91s7GQ/nVLmhzfKNYZMC0mrIcHgHT/g0zhKuBn4/UWDCk48ApC/T0kMiZmO
	/Szmwot3zrtutZsPWHyPJRc+h/ac+QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794770214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj/STAif1P9RZJBVspyigsA9jI1Pz88cJGa45owyE14=;
	b=fQzbBMrPOhGBR+R3g4cRtqMN6L6rfItNZzKtBVYpWJlusQyrxF2MW/06F6sN8k4lEHY+OP
	K60XtcWKDst97DDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NFRqlvca;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fQzbBMrP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794770214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj/STAif1P9RZJBVspyigsA9jI1Pz88cJGa45owyE14=;
	b=NFRqlvcaRg6/6Yg9Vbo1fs6+OtdRO1OF52jH6rmaLsrLo7pRJ3alJel+EZwvzTEdovbnf2
	EpGj64g5vhi91s7GQ/nVLmhzfKNYZMC0mrIcHgHT/g0zhKuBn4/UWDCk48ApC/T0kMiZmO
	/Szmwot3zrtutZsPWHyPJRc+h/ac+QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794770214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj/STAif1P9RZJBVspyigsA9jI1Pz88cJGa45owyE14=;
	b=fQzbBMrPOhGBR+R3g4cRtqMN6L6rfItNZzKtBVYpWJlusQyrxF2MW/06F6sN8k4lEHY+OP
	K60XtcWKDst97DDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D07013408;
	Sun, 15 Nov 2026 19:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VsV1DyUF+mpdTQAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 19:16:53 +0000
Message-ID: <4873551e-05d8-47e0-a034-2dbc75fb3459@suse.de>
Date: Sun, 15 Nov 2026 20:16:52 +0100
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
Subject: Re: [PATCH] KVM: SVM: Sync CR8 to the local APIC after marking the
 VMCB clean
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefano Garzarella <sgarzare@redhat.com>, Chris Oo <cho@microsoft.com>
References: <20261113162556.461390-1-seanjc@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <20261113162556.461390-1-seanjc@google.com>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 30C011F453

On 11/13/26 5:25 PM, Sean Christopherson wrote:
> From: Chris Oo <cho@microsoft.com>
> 
> Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clean,
> as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPTS
> as dirty.  Clobbering the dirty bit can result in KVM failing to detect CR8
> writes if the underlying "hardware" uses the clean bits to optimize VMRUN,
> e.g. when KVM is running on Hyper-V.
> 
> Failure to intercept CR8 usually manifests as hangs when running Windows as
> L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQs.
> 
> Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept on PPR update")
> Cc: stable@vger.kernel.org
> Cc: Carlos López <clopez@suse.de>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Not-signed-off-by: Chris Oo <cho@microsoft.com>
> [sean: rewrite changelog, massage comment]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Looks good, thanks!

Acked-by: Carlos López <clopez@suse.de>

> ---
> 
> Chris, as mentioned, I need your SoB.
> 
>  arch/x86/kvm/svm/svm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 581bc3a23c95..3152846a6ccd 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4726,8 +4726,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
>  		kvm_after_interrupt(vcpu);
>  
> -	sync_cr8_to_lapic(vcpu);
> -
>  	svm->next_rip = 0;
>  	if (is_guest_mode(vcpu)) {
>  		nested_sync_control_from_vmcb02(svm);
> @@ -4758,6 +4756,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  			       vcpu_to_pmu(vcpu)->global_ctrl);
>  	}
>  
> +	/*
> +	 * Note!  Any action that might dirty the VMCB must be done *after*
> +	 * marking all VMCB fields as clean, e.g. syncing CR8 can toggle the
> +	 * CR8 write intercept and thus mark the intercepts field dirty.
> +	 */
> +	sync_cr8_to_lapic(vcpu);
> +
>  	/* if exit due to PF check for async PF */
>  	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
>  		vcpu->arch.apf.host_apf_flags =
> 
> base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e

