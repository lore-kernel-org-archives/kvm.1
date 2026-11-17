Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883283;
	b=0NJ8WRpg1p2zDG9akvRT+RLFa3FrIhj72quwEqdvuIKxnA5/xuPJXFS8LzMOw3TsIwKJ
	 s3rz0eW7YekSoxrDNCcXOK08ZQzM9pKjlVQmUXAsdnOpz80EzqWA6alJiSMutPpJPr7re
	 fkxIwUBRNzMWIRVmHAkbU3lgWX2daSXR1kvXJ0rvfOqk+427oT2NMVEDQovzCJDVYAh4T
	 1cqVUWS59NPQ6HNdjBVIGRpavc0Y4RcjFBxnTZ6b08EGrUvrQO1J+7YiPFGk3mK8mAw6j
	 ADS29/makx1fhsNiRH14NnxhlWBctH+mV/eUVotRdLFhlBMMZDOOaV/uXyAaHKVj8kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
	b=mW/T+BObJ4Sg52E0WYEZ35Wpz/1U9bXd4zyRWJU2LacSi9FnGs8w2n4W2/vg5aM703C0
	 2CeBzqj5Cp2qc9QdR6EnDojkjfwlKgeLMTP6SoLsTDsRI2Z7tZrnIZ20G/gvBkfdrVBgR
	 DAGv4PNAIeySXgK+vK9A580nSBcGuBfvqgQ7LH9ydwp1QPg/2Ofy/4i4bSybj0jt6Nq7o
	 6CBsgTVHmfSEFcEcqubdY9sdO8g0i1s+6+CwDFMq4eWpMLfibj9mNmHNeIcxC67PawE3u
	 HJOPSc6UEHzgtbdHvzgrJTbY2mzI1db7fmNVbjITCxvWbrUHfudwoyP1qfsjvbl9iEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iUqEGC9n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A8606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 02:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C26A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iUqEGC9n
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ea5600c9cso5106516d6.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883282; cv=none;
        d=google.com; s=arc-20260327;
        b=lIXVTLlopKSiCVSxQM5IaISYyFky+72xgYRWR/ZRhj7gAecUcu5O+ltXDY2WZhHlPE
         wf/oCA8S+HkjsyoGBiiRlODt6LqOTB/hdhPmQz8+/mkOQE0ACWYHOAob1+x/0fcP6IPb
         He0Ypc/KucbuBWqBw1WYmdrYjAVyt37nK4wE+It8DgV4RxSPSrUz5plFqYxRqofjitCb
         bS1GxY0RTogOqZ4xBB3wXW8jyb5jfBWmpnkUnlvNZ3MMezf0sNgBtnr36LiFFDwKUUCk
         7Bw7UnFojIkmHB4mJ2/9B6dhADz0SVd52LyXOV+b7P9598grzaWg3lZhX6qRKGbXvM2h
         W+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        fh=FBp/GeSkksd4Rh18gk81thmBVYpjk254L7kiolu5tNg=;
        b=SOftm1LZGBc5uCJD3EgUsK5Ilcyfwtag/CH9a2hsnm3crIov+43KzhhsHJKtTrJg0a
         HXSPI57rsVknVmc0eDEMALJAPbJDDA1ZTa4S6/pI4os5G1fDIlL7c5iwNijDhUhh2kgB
         MQ7naH4JdbVdMxqusnWHzH8Bu7ocFu/Mu9Lb+O8Dv1eAsQIFSeIp1dL7CB0Nxn7kKT28
         Q+R/xYv+iwuonxMhlgxNx49CNf/+eWdTS2TqpVipkmy1KNb5OAYF5R7/OmjxRfONmUYp
         UZrHIaBuOagIbQ8krNZbJJ1XVj9qPS8M+Q51GcJm7JoTl7IRR9+mJIq9nog8dUx/S9qx
         aEhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794883282; x=1795488082; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        b=iUqEGC9nnx8o7ijuV/qO1rJEsb6fK6NoBQHYd8uDM5RHQ1J/W3lZOazsoDrHTwxf8j
         IoRa/6lYq5mmAd5bVuwwZbcBJa8LztEz0ljoa3leuR56F6DRGWXEZjhMSYN1bpvPn8qZ
         PAcsnLRE22rjrVR7tmAw972Op7VIW1PVnHWi5qZnp2E9Kb7RIdbIgjcw8xHC0gpyL18g
         CvOmtNQzFs2S8112gGfB8HWjSyPos6qVzrrGMHZFt6JmZQy7ludvGdnCLfdV3ikM+8JB
         fRxKHLBxvkobzW536bC+KOTMuH0milGkbC3u2xxVd2zIGJou/X7iQYDPb5KNH19tXQLj
         LqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883282; x=1795488082;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        b=lIu6Z/xSzG7Q8bv8GcieHbmg/YzbVRzrJU/tMdMoT+b8q/7aAOsTz/O0zJKqYzgQXa
         zuaRT5p2gMnq2iELwgGWapdrtfLeIH2rBh6O1er5UYShuFNZKxNLtX1IHolQ6uCWg27G
         7Dz9F1GE29HhItza0Yp/+Z/STlkcDo2J97jzETxWkyKqhXewzftNSyDC+brw6tIf4slD
         MttrOh3XnMcaTPdhIZNTA6pze/vv+hXPendlNoFqqmlZgQuups6Y56Gk5otTMJcABxZ3
         1qt7dIeLHE6IEaLlrZJq4rQra2bznNvE0TKCS59B8coYwEsG4dET9S61wvBCRWE8F73P
         wCAA==
X-Gm-Message-State: APuU4Z9tR4vRXGrgz1vyv7pVNBkAWXreIbOI5ABijveQy3ls+Rup/BGD
	lji7N/Li8vyeXG5qBeJ+zNXm2a4RtP1reW0jH5V7DGeDYQkub1snRV0B5n6KzgH1iTmA6cBpgJa
	yNjga6rU7Sp8uOMJuagKN/tTRejhSY3F0XVNK6xI5
X-Gm-Gg: AZFdTZdLnOuYjcN2fD58gYgSEAmceGc6OWFW49GscCokXawO9sU5/0XNBhGBVw08YDs
	k7Pf9OMCX3D3ybq3/8gjon2H6OWH0QQNky14GyItWHn0+r9FiICbCx2VED64UUUBt5Z2/QWDYek
	nbbvoyPop+G8EgKYRyK7BHCiVUCaLR6yyexf//+EBo1h5mkWjlmZD/ppdqAWzfN8A4Q3Nlt3nl4
	NDSQQdx7bW17/MdWm7jrT7kTBn1AHO6uigmwNjtR9xzA3J9iKC3Bru8k1NrAOTKbyFeGYGdXQZL
	rukmJ26ytJtkiLFZd3wv6fQJbFK/F3nsTH+228JLKTbMC507e7z1Fn93rl0la5QUqHk687Yqgqg
	GMEkLKiodpTRoh5qQo9ZXiTH2ukwv3o/B9q4hV290gKyZRMW86oV35yz0BdSPS3ucF8Cpnjxjln
	t/nIbs+2vN/hQ=
X-Received: by 2002:a05:6214:83c8:20b0:920:fed1:a8da with SMTP id
 6a1803df08f44-920fed1a991mr13219076d6.7.1794883281247; Mon, 16 Nov 2026
 18:41:21 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Nov 2026 18:41:20 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261117011513.39419-2-seanjc@google.com>
References: <20261117011513.39419-1-seanjc@google.com> <20261117011513.39419-2-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 18:41:20 -0800
X-Gm-Features: Aa3M54r-riMCYzwFL0iUhgl_cPKG725IFXZzjFvHz6XTzkSM6fUmx3t1Iz2ifRk
Message-ID: <CAEvNRgFB539gu4hhRaM8qhoJUiaU2jjmCRze+WZHbtGSc=x9Fg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] KVM: Disallow prefetching PFNs (for SPTEs) via
 VMAs for gmem-only memslots
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Disallow prefetching SPTEs via fast GUP, i.e. by VMA lookup, for gmem-only
> memslots as the whole point of gmem-only memslots is that KVM MMUs should
> get PFNs *only* via the direct guest_memfd interface.  More importantly,
> this will allow skipping/ignoring/eliding mmu_notifier invalidations for
> gmem-only memslots, since it will be impossible for KVM MMUs to have any
> mappings based on the to-be-invalidated VMA (as is intended).
>
> Fixes: 576d035e2aef ("KVM: guest_memfd: Track guest_memfd mmap support in memslot")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/all/avdAIMDfgL_wy1rx@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..9938b753948c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
>  	unsigned long addr;
>  	gfn_t entry = 0;
>
> +	if (kvm_memslot_is_gmem_only(slot))
> +		return -EINVAL;
> +
>  	addr = gfn_to_hva_many(slot, gfn, &entry);
>  	if (kvm_is_error_hva(addr))
>  		return -1;
> --
> 2.56.1.703.gf848ed807c-goog

FWIW, I also looked into kvm_read_guest*() after being pointed there by
AI. Those take a HVA, but don't take any kind of long term pin or have
any reliance on MMU notifiers, so those don't need extra guards.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
