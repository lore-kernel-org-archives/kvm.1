Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027664;
	b=QESJzDAO+BVlZTDt6kdHjlLNLAyh8vG8ovU/DmLbjJqegw9dyCmjaLPoXTyQMqoZlirW
	 JjP5bvON9CSYp+6vVrGZdRCNi5PFaugE7W9B9z97xhjcIKiEuQGcSjvP9l3/n0kmSegfl
	 OhC1aKJhtwB1je69lFQCSRdiMfr4GoJz43KUZJfhyqGZTQxHB3t3FW4gwmUVhnOKjIUnl
	 upB+2gW04984WNJ/yfUxQ0WS2v6T40YWyBbKUjxlsBCLDXeahTKZgzZrrKh6zKAZZgYSM
	 pUN2Gf9j6700fPuKdT1HddGFghn45xvupAsU1J6mihb7pBx9qhvUkMWH1Rk3/jsWhMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027664;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=Lq+YmYsleZxYvgI44dKpncvv6ZUxoH3YcUKCOHYsvZ6+REDKI7GrCpLtyAHgw9Vqo1Rn
	 S+z7Yk/bg8MHTfFXktsh4RghZFmpNtO/2iaZ01esU70KT5a6C7CTz80Hqeh6r8pFV4gfb
	 6jNFik+f7zLjBhNtjy7XUZQHQeKsMsS8iZoXEbJkMqc7hy75j7RwptbAtqgBgLh9z4m1T
	 7hj5UkNHW5NkIPMueaqJ4pzaYn12OtZoPp+VxIylbnyZPI1eVW3gUJMEyLOiEV4TmWMwn
	 VBErrUpYpqYJZg5T1X+8XMHiVlY/CCmW6p4nzTJJnddpMidCCj9YHsblfwMlbfr6TxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="dvuSE/Xn";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJQ+NzhT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jMW1r8aV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wepXcgmH;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22461606A331;
	Wed, 18 Nov 2026 18:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22461606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dvuSE/Xn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJQ+NzhT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jMW1r8aV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wepXcgmH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC3B51F7C7;
	Wed, 18 Nov 2026 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795027661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=dvuSE/XnDgqLbANKpVfx8oUNYECbT0RdRs08BEllXDPKl1Z32x9pYW6MTnirgOj6fUczFC
	klEnLNmkw+P/mkHsVnKZMbLLgDWQnkxBE4qR5Df4udIiUcTUbOZxTvgXIJuLUG2tuoHPN9
	xJ76bPWQlE1FjK6YDSkhqK9Rh54NxnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795027661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=XJQ+NzhTXoI2ZUPkNxcNYLvAH7c/XliuFA0tIXQ0Xj5DdykhaGHSzo/YQUPJKU1EvJBFIa
	r5Mb9VNzRcooFBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795027660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=jMW1r8aVAkUzZcWFC0j51MBdUOXrl/vxRfgOWnt9S7degrCFopORJosN3nGPckcL+d0AXp
	bRLfn14Qxp/uLShZzuBM4qrlPpXdVSBTUze/dJqRLq5b0DoamFoKUpoKaDdWCn2fuhv+5e
	IEpGN8Y3l0UlJx1xcxANh/dCq2UapcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795027660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+ZReWpqC3ziwBie1A6+O54PEO4HYrof10s/hSkC4G0=;
	b=wepXcgmHx+uxHrB/DhLUH1pWJk57/keea82HsgrGjJrtAt3nZpxZsGDFbbI8fg9CiTvRRv
	LB/9c8ckpT2crWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58DB8134E9;
	Wed, 18 Nov 2026 18:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ipXLOMvy/WqYTQAAD6G6ig
	(envelope-from <farosas@suse.de>); Wed, 18 Nov 2026 18:47:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem
 initialization failure
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 15:47:37 -0300
Message-ID: <87pkw2q8mu.fsf@suse.de>
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
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,163.com];
	FREEMAIL_TO(0.00)[163.com,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
>
> Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Change the Fixes tag.
>  - Modify the patch title.
> ---
>  arch/powerpc/kvm/book3s_hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 22283d46e8fe..620097f292b8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
>  	r = kvmppc_uvmem_init();
>  	if (r < 0) {
>  		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
> -		return r;
> +		goto err;
>  	}
>  
>  #if defined(CONFIG_KVM_XICS)

Reviewed-by: Fabiano Rosas <farosas@suse.de>
