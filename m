Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800733;
	b=iJq58GgpM1xG1fH+q2+8szfDJQ64kHgZyyNgBHFPLeRmDLjhrZdOb+4cjY2JiWHlkzxL
	 jCy1bReTVoKSNm6M0k9DdLQ+kQ97UnFgzjBsXst7pKUYHnyYZ7roq9OSYaNrHT/t/ydm7
	 fqbdCRPiPhbNsYf+q0zEQPZKSyjA4D6LrjcOOS1Mz01CWq9aQCSl7UKOMxPgRlR+RLPHP
	 DqkWTgVZoMtDo6xn4ieb5GJ7zSdHHEen04q4fmluWXr+zTicpJkzU0NM9d161Jit4mDQR
	 suPmBzXJkRttMX0VL2Xyvec2ie0LwXkCqRPBOLXQBDoo4EJZgPhhwXdsBeNyLJIC7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+hZDwNFM+9l5TJl0pTc/phM5xXNFDw6tS2mS+HIJziA=;
	b=v1QTbp1qQsI7Pu6ruF5h/k+/YG+oXmSmtkR2AAIKmMdRsE409KbMszYJ/PFu2dhk5d/8
	 pv6v0p65lnnpxi15f2XHNNp2QnaFx7+RAEYjo1bbFgC74dYtrk83183Qvg7VRBqkQsWRI
	 RY9zkQVJb1FOQfbzp9vi3hW/5WymWcW9FZJU6Df+B5i+gbJ5w92eaoWv385NRWiuysZEU
	 HeL9zHnJxmG7TTmfDJ0nxnG74oo2GjtKsWOb8qwEJJQp2jKCPecgUDmAYtCgjjdrFmYXU
	 3D6yDbrpHKHLfGJUyaWUGFo0UERHzYzlIY5ad3J2L7JTBYEwV7cEiR4ummf+zULiS0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NdEAY6u+;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26212606A336
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 13:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26212606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NdEAY6u+
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso453902a12.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 05:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793800732; x=1794405532; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hZDwNFM+9l5TJl0pTc/phM5xXNFDw6tS2mS+HIJziA=;
        b=NdEAY6u+xEDu3Lil75qvCMq+2MrJ9IlHqk6e7I5Qt/4N0W5WDNtLytdtx69qagZt+K
         dD9tyMSM3EgrXvvFXPRECUSHj2bDj7Z0oD1u/s37zleYkhHJP7B96X1Tn6tAS3oqVk3S
         yZFp6NlFwo702B9CF/gzVmFZIcK3c0914F9dMU+HpP602iVaoLijrXzfJfVUr6bOR+iT
         kHJn4iTfy1K+KOChyWY93UBeWgwosD+G6aNIt/99lRRc3uIyIuIhhj0W6WFhyl70fLgg
         IkdXJyYKZ3ZQYmQ3mocZ13AjJfeo3m5ra57t7fjbbYSwwe5NsVItqyRFgjPzOVWaDpHu
         s2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800732; x=1794405532;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hZDwNFM+9l5TJl0pTc/phM5xXNFDw6tS2mS+HIJziA=;
        b=tW4SG8QGcXfAD6GRTSvyVRAlnzqdV0z1oEUs2Vv68XLFHJLcmCcMjxJ9D5tMf4v95O
         hvPmivVDdggCcLiytLzz15Ew7nzRKr6la8+RXmoICZg7ODGZ4Nm2pH/8Sr2lfxFZeHgB
         07Z+qPTjdVNw1cRtxunOZZSrYTGrR7urNV9YW7QNCHC3BSdj/2lvXyqqtDVuH5BS8MEy
         idgsh+LCQoJnT38XN2BSL8VmDwD3BnU3djDxDo9jHcXX7pDskSQZhRRmPiRifAdjHDn3
         OLk6mkBZcTi1SbmVk2HlJQyBhgxpxRcP1KZZZJ9xtBZEvfCYPE/HBr4DYIWVjWxa3jY3
         mlcA==
X-Forwarded-Encrypted: i=1; AKwUvBzPBv+tRE/b6A3SWN7fGdKhqZsGpIcKqgkm1Mw3KmpkMSaENm/sca4cyFy/cUBaOV2Ep44=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oxTprfwNn83OzpW8KevqALpv3ZeHa9M9dr8Y1Y6vqpZj9aUSD
	JEloTCZ4cOLGPVHOVTBR/MAsmNaAHCHZfoLDGlW5KQo//d7Qv4QtVOPw5mudPVsVaHdPkn/edee
	y+aVKBA==
X-Received: from plle16.prod.google.com ([2002:a17:903:1670:b0:2eb:37ed:a32d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88d:b0:2ea:8442:db72
 with SMTP id d9443c01a7336-2eb364f19aemr150809535ad.54.1793800732154; Wed, 04
 Nov 2026 05:58:52 -0800 (PST)
Date: Wed, 4 Nov 2026 05:58:51 -0800
In-Reply-To: <20261103234734.45413-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234734.45413-1-griffoul@gmail.com>
Message-ID: <aus6G5VqWJv1gq7U@google.com>
Subject: Re: [PATCH] KVM: Add helpers to allocate memslot metadata
From: Sean Christopherson <seanjc@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mushahid Hussain <hmushi@amazon.co.uk>, nh-open-source@amazon.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> __vcalloc() makes every allocation at least one page, so a memslot
> that spans a single page uses 8 KiB of vmalloc for 8 bytes of
> lpage_info, plus 4 KiB for a 16-byte dirty bitmap once dirty logging
> is enabled. The waste grows with the number of memslots and VMs on a
> host. kvcalloc() avoids it for small arrays, but refuses allocations
> above INT_MAX bytes, which the rmap and write-tracking arrays of a
> large memslot exceed.
> 
> Add kvm_memslot_metadata_alloc() and kvm_memslot_metadata_free(),
> which use kvzalloc() up to INT_MAX bytes and vmalloc above, and route
> the dirty bitmap, rmaps, lpage_info and write-tracking arrays through
> them. That way, how KVM allocates memslot metadata is decided in one
> place instead of at each array.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
> Mushahid's patch [1] switched the lpage_info arrays and dirty bitmaps to
> kvcalloc(). Sean suggested dedicated helpers for memslot metadata
> instead [2], which this patch adds.

Split this into two patches: patch 1 to add the helpers, patch 2 to add the logic
to pivot on INT_MAX

As is, the shortlog is comically misleading.  Pretty much anyone is going to read
this and assume it's just refactoring existing code.
