Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408894;
	b=sqPURV92J+NfHmz99IbzXHqLUFhiB5uzKsQFCOSG3bjH8IlrwfVNTT+v3B+H4DW5zdV0
	 y+WFYO0U4TmvOCAiE/cF8hJFjVraW1W3ebia12DFT9+2DLnBWD8L8HLB3awS6X0JfcZNO
	 ti+7N4aMbVCWxkD/Ln8mvjf7Ztg7xi5Jrgk2lYDTILSkA315dWe3CXSoDq1ivZZOfhzMX
	 j1SrUkzhi2aDjzmPwVtasiX1c34tLNjPZ8vQrsobQs2uRhjwaQPmSgMp4tmLSnyaxd/gz
	 PpasFgFh810jqJH++4l675rDbROXkq6y//famQu/Tu6ruxmZxwwebcKpO7sALS5xqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408894;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UBGwpvxng8YWkU7ZTvAl2v1tzqyQSCQj5Ob46jz5lV4=;
	b=G8JiBJOUSM/6LlSEwnWAl9150CsJGuWBIrWs9zfxD5zEUuaiOafXsQnVEihgmZm6dE+O
	 pYNCzY3JmmLvo6+Hk5bpBiNr8sJUsuWpoAe4EmzKr3h9Gug/O9sFGWf0c23Pp2FowIKfy
	 wR6wNQmtl77EA1I25n4hewql6nlsSZ6NsdB/l1eHVrlJuFTfH/l//mqLRVM5PDPuOA0qQ
	 IJIULp1tll+c5jobQQG3Wq1sEEevXFjnYfqFiQyuORuJ4+QlHwBvWtFTLbejvlQreE5q1
	 qDtPyaCizYGLFX4RYUyyjB9PeYcq6vlew2pMpb9sc/wpAeQGonCtsVmV5rvP7TIMuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=jnyaiDsG;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97E606A31C;
	Sat, 31 Oct 2026 01:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C97E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=jnyaiDsG
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1079B40E02B7;
	Sat, 31 Oct 2026 01:08:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bjktjXMRBRaY; Sat, 31 Oct 2026 01:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793408887; bh=UBGwpvxng8YWkU7ZTvAl2v1tzqyQSCQj5Ob46jz5lV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnyaiDsG1rK1Fyz9AS6XoWn5oQ4piwfCFwEVlyVXpiG2JJxf0XoFVS3USSHGZcIOh
	 /2ehUaczjNbZyKNE3VVPLEpfx+ygcZC5wZI5uoq3Em2PL9t/xgyIUoPqrbFVsvpgJu
	 LTXEnkhIfxSX4zXaLUGViZPA/62w59/kCr4G3UImLFfxbdSq/WoxL99bAILTx2YFCG
	 /qj51yq3v9KXNRZqJtmg9q0Bs8t+L6XsIfEwZnYDxKgIfE7A7k3ZeiNTppZ7Tlno2M
	 egldhHCqqZ3aKQn3gbI9H56yRfmdhiHwXPezHnJlRDC3JF7euQYMQBfH64ycnEswMF
	 3gDuNucCUM4vVeTSk9H30c+t2TD+twyXTj6KnVQ4kEpSeIWZCCYeAmblA5+LwfJvco
	 bgWK8XXnE0A2HT1Cch4WiWu13EL+bYLgax6cIMcFzR/aMlNExVwleNBTR2ChjE/47t
	 XBs33kNw3exH9k7Kb9kq6Ez3viUjk0TGbbZKEpvJJ8dFqmKDwK0r7okGRbJd38gGgF
	 kTYUOCk7GhEdiBxdW6CMzDt0XK1vms9hYrvlmP/HorQ9ev6mH4T1uD6tZ5+tg5p1wr
	 Wh2QJJX2na94Yl/D/sut+jaSbPDD2prSgU/acl1gMHrmQy3VlxhDTyRss+Cq2Sz0u4
	 Ka1T2u4fyXQjDlwhsYRDaVfo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E386840E0298;
	Sat, 31 Oct 2026 01:07:47 +0000 (UTC)
Date: Fri, 30 Oct 2026 18:07:44 -0700
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, x86@kernel.org,
	Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
Message-ID: <20261031010744.GFauU_YJdX2eV6GoHV@fat_crate.local>
References: <cover.1793392128.git.babu.moger@amd.com>
 <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
 <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>

On Fri, Oct 30, 2026 at 03:08:09PM -0700, Reinette Chatre wrote:
> To help future readers understand how we landed on this I think it may be useful
> to add a link to the decision that resulted in this fix. For example: 
> 
> 	...
> 	Leave mbm_assign_mode in default mode during initialization as decided in [2].
> 	...
> 	Link: https://lore.kernel.org/20260804191608.GDanI6eK2Q07w6pNcb@fat_crate.local # [2]

I can fix that up when applying, yes.

Any other Links I should add? I don't have a problem with leaving enough
breadcrumbs for the future...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
