Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A693624A8
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776420310; cv=none; b=dq201ACEfWOmzY8F8IDxieoTUwgc7HzM5mmvWyhhNTNxJIxNLEBV6XQ/ihia1jjtb1m8Y8q89xgIrn3NfbX72r1N3iXbZISuODOdYFGjNuPEMm/j/Y9/KQpiK2Ax9Pzkl9KnsaRzEx84KxQ4vYP0UbZYPKK9lhKUlc/z9XciDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776420310; c=relaxed/simple;
	bh=HFUf647vhRg08shNRvrLdCirC3ivpFdX+Uw+/h/X180=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaSsA30gqm0cZeMeXiP8aeEScFkbQ4qPnKp3FRHTRM/6xLUGENYexdnfxAA8sZV3DmgwaX6zB29GQvcab7ZUiPygW+aD9jkhoCdgYtdVPNRXSmtLNCoJefF8K2KC5H0f2M+gtZmbkkID73A/tRVx9tSHa+JilJxXs0HwjE3b7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XzcyCnV/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GQkIh40F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zcdsa+Ci; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzaWq8PY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XzcyCnV/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GQkIh40F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zcdsa+Ci";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzaWq8PY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B66626A9AD;
	Fri, 17 Apr 2026 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776420307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbiHQuxbonHtZcHsPM48e0n+anyN/Gt9HQiY7pfRgxk=;
	b=XzcyCnV/6wl2GJvBhbYBJ2lNpoB/xoUhJriUKlCnalCGwX0fY7AMmTRv/oO+2wtvyzVyAh
	Zfq3Y0h4Ha53Scv2sPYlzGLwU4j9M+hQu9e2uYwFqTsvUoWpewbI4fhscS7xiLoipoa/R8
	kg1t0rPBcj70vEYgY+X8R4G6QnGuUjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776420307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbiHQuxbonHtZcHsPM48e0n+anyN/Gt9HQiY7pfRgxk=;
	b=GQkIh40FLHWl1e8SIMO/67FZT30VYrN0CXq6ZLC6u1qantg4coO9j33VyoiNEsZlaMq32U
	2qIoWJ7spOk+dZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776420306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbiHQuxbonHtZcHsPM48e0n+anyN/Gt9HQiY7pfRgxk=;
	b=Zcdsa+CiZmUjG4Yd+dP11iGdJW0G2wIqrNgEXNBnMkcsev3wLL6rL6umYoVcOQKcnOu4nB
	pnjIXw9ib1A4N0ugUwUVsqFLheo8oynAJCdwuQFOHbuALnwUgoCUK1Ol57SLAomm4TLXx/
	ssLT0q0F7jc4tCnRozT4KRFkeH9P/Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776420306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbiHQuxbonHtZcHsPM48e0n+anyN/Gt9HQiY7pfRgxk=;
	b=PzaWq8PY2L7SJg6/9WQoPvZSYw6spvcHs9W0rhSGstsjVUZGLvELIqpEszjs+kBk0id+9N
	qD0aRDn+SEE4aYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CCB5593AF;
	Fri, 17 Apr 2026 10:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UcBTENIF4mnkHwAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 17 Apr 2026 10:05:06 +0000
Message-ID: <ce3e8a51-63fe-4723-b1d8-6555b8b77817@suse.de>
Date: Fri, 17 Apr 2026 12:05:05 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] KVM: VFIO: use mutex guard in
 kvm_vfio_file_set_spapr_tce()
To: kernel test robot <lkp@intel.com>, seanjc@google.com
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
 pbonzini@redhat.com, open list <linux-kernel@vger.kernel.org>,
 kvm@vger.kernel.org
References: <20260313122040.1413091-5-clopez@suse.de>
 <202604031640.vckbuS2S-lkp@intel.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <202604031640.vckbuS2S-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 4/7/26 5:48 AM, kernel test robot wrote:
> Hi Carlos,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-L-pez/KVM-VFIO-clean-up-control-flow-in-kvm_vfio_file_add/20260314-053050
> base:   d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
> patch link:    https://lore.kernel.org/r/20260313122040.1413091-5-clopez%40suse.de
> patch subject: [PATCH 2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260403/202604031640.vckbuS2S-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604031640.vckbuS2S-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604031640.vckbuS2S-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/powerpc/kvm/../../../virt/kvm/vfio.c: In function 'kvm_vfio_file_set_spapr_tce':
>>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:219:13: warning: unused variable 'ret' [-Wunused-variable]
>      219 |         int ret;
>          |             ^~~
> 

Sean, should I send a v2 for this or will you fix it up when applying?

Thanks,
Carlos
