Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBB3A1A55
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056562; cv=none; b=gTtBClcr23vrOEfIa5cGdMv5gLjGV5yyNwk9aPOa3R6LoPhsHwJgm+4I8lXbW3BvdS65CJTrxYKr4ORPcmYrwlerTKHv3oyDKrP2tiDVcWkShbeCyw9nE12eYvQvSXjvlSycDBX/yDJLJgeL4eUR2UnKrODPX5ScM/auJhyJBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056562; c=relaxed/simple;
	bh=Nt5Vw+tkYUE0noyKyk3+fahA9VicdkAnycMJcpDJU1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9HHIx04lxGM9z3AbigJM8zubUpZvhpPP7CmWnYqD3ati432fODDyfVjQqgXQsbUCntoW2oCtiPONlmuyvtPOCoe784nfm8mbpttSIvPk3ONjSI0FD7VKrq1497ykWtuUB0haFNLUWVSiV/q87sdkVxB1xlmGjzP2lYzRaicE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rrEPqHMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uLdBqfyv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rrEPqHMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uLdBqfyv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rrEPqHMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLdBqfyv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rrEPqHMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLdBqfyv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FEF34D1FA;
	Mon,  9 Mar 2026 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773056559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9dcjx44x1l7Xkd6W45YBGBYjn4gAtqSJ05zAZ1TlVE=;
	b=rrEPqHMTQV0IUHbUnCr4xfKryl5PN7j/XkwJ1J88Vin40m3Oihx9IljPSyNqfvJJewGWm6
	W51+bYg0r1O+wOloVQa1Ql6Kukx3WgEr2rjcygN2iVpGyKI/MgDS0txS2uOyTd5n4dnzWD
	IxANiH2GhF4ORkL5BBi1TDUgaA8MJMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773056559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9dcjx44x1l7Xkd6W45YBGBYjn4gAtqSJ05zAZ1TlVE=;
	b=uLdBqfyvHY7lF+c0Q1lRyu/GuQ9uXGhJtEGa28HGIWAE5OPy7yLcSUS6P+ze6ntszL1sne
	Q6GsfVkcQx1dPaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773056559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9dcjx44x1l7Xkd6W45YBGBYjn4gAtqSJ05zAZ1TlVE=;
	b=rrEPqHMTQV0IUHbUnCr4xfKryl5PN7j/XkwJ1J88Vin40m3Oihx9IljPSyNqfvJJewGWm6
	W51+bYg0r1O+wOloVQa1Ql6Kukx3WgEr2rjcygN2iVpGyKI/MgDS0txS2uOyTd5n4dnzWD
	IxANiH2GhF4ORkL5BBi1TDUgaA8MJMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773056559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9dcjx44x1l7Xkd6W45YBGBYjn4gAtqSJ05zAZ1TlVE=;
	b=uLdBqfyvHY7lF+c0Q1lRyu/GuQ9uXGhJtEGa28HGIWAE5OPy7yLcSUS6P+ze6ntszL1sne
	Q6GsfVkcQx1dPaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 232303EE9E;
	Mon,  9 Mar 2026 11:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y8WOCC+yrmm1CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 11:42:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4870A09A4; Mon,  9 Mar 2026 12:42:38 +0100 (CET)
Date: Mon, 9 Mar 2026 12:42:38 +0100
From: Jan Kara <jack@suse.cz>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] KVM: guest_memfd: Set release always on
 guest_memfd mappings
Message-ID: <5blfhtmxxudflnekbdd47dh6cu4eherrrdq2n7e4k2em4qiix2@msak4r6zcc22>
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
 <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkt8wp3x8qpcm6dn39p5ieksq)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 09-03-26 09:53:53, Ackerley Tng wrote:
> Set release always on guest_memfd mappings to enable the use of
> .invalidate_folio, which performs inode accounting for guest_memfd.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

I'd fold this into the previous patch because that makes sense only with
this patch in place. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

for the first two patches.

								Honza

> ---
>  virt/kvm/guest_memfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 77219551056a7..8246b9fbcf832 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -607,6 +607,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	mapping_set_inaccessible(inode->i_mapping);
>  	/* Unmovable mappings are supposed to be marked unevictable as well. */
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +	mapping_set_release_always(inode->i_mapping);
>  
>  	GMEM_I(inode)->flags = flags;
>  
> 
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
