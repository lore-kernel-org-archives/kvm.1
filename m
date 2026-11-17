Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883489;
	b=coDcYJKIuxpv0NjE/BEfq9L477l3vfgRC0FdW121DFsC46czj162tssBNVGW+wsRts5w
	 OTZS8rGKybjtt9o6nA/9i8jpgGCvriuUBjGLOAO+6dzup6GJ7sy28jEYhtB36dMBd3fhb
	 WObI9miVdPA2k32Pgl1VZsi+IbiaNGhXWVJwhPZ7TeKdv389kqiDuY89Tik689gixd/Bw
	 bPNaNz18fjEUoQ2SA4g6N77iLISQrvosQI5adXsK/LmbdbsV/LqvP2qf/xJxE8RgH6fah
	 XWfRrwE+MUB59EoQMAELsgBettweqlTJMK9F/LMJKNH0FcHCzY/NYbttMeHARUP7tsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Y71Zhi4GfiQqdnuwaNE8zOzr/2i8FDu4fO8GyDaycAQ=;
	b=vXylIw58r9w1b+Hle+VSa95v0r0g9iAfGc7TSNdABjAq84sIfFZvN5b7sKs4fEqrd+FC
	 uLp7qoxhxJjjQqY+6jO4Mtb0pr8hi3OqvSSlOjIB8Dnaop9gLzaM7yewuUn1a4EFDmVLt
	 /ZF+j5Zb+rSLGAmdvcq4LddziAo24YuHeWHW5IafSy/tpQ8oZsUPYXzv+QV81FJ5J3SFp
	 1AlfMbXBgSVJXYrWR1mqLc6dhG5fKRZ/BVUKF0iCdyxSz7zzlzT0IiQZlXXr1N+CCp9Vn
	 z5+BaFv3MEtCC6HkXe3ZrEF1CjGHk0rPUiOkZnO///LrzkaZedDdHOUkSOECMYYV8VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S3PtxR5c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAB606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 02:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79BAB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S3PtxR5c
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ecbdf5343so5016516d6.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883488; cv=none;
        d=google.com; s=arc-20260327;
        b=GSltecTNFPt8vsU0v0n3cEwbuqUxQg3+ZTryTir6JucwUZvaHI/cEv2jV2Cynf5bs8
         ky3DHA00IkDU2M3alnJZ4FA+als5p5XA9C4CCOl+Zv3BXPG+RpfYd0ofzqlpfVAyej4z
         halwSgz2D9k/2jkozoSEpFZMbgMWBtcsAgph33FUU5djs0LUZzsCKpokVDiihh/dOBCr
         iE2NXUC9bGan/6M+o4NOL+6QFvlWLeucwwenAAo3+mm2BSFzcN5IgsEhJOH3XpQmD1M4
         MO4IwfsTxg2b4+HeabaNvO5qk6jRVqQiIxCmpiYPpzV6PzgqRtbQVcRJHYZF9aWt8rOC
         H50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Y71Zhi4GfiQqdnuwaNE8zOzr/2i8FDu4fO8GyDaycAQ=;
        fh=FBp/GeSkksd4Rh18gk81thmBVYpjk254L7kiolu5tNg=;
        b=MiEgYUrXyglQxyamoHt3lQkCQT4WpMlFC8+wuGJlT/YbmNXbU8iQ43NK5WkAKHVOlN
         4wkQrd6+mlkwapWYQ544yVeKX3dNndxR/UJqii8zRI1UHGaxWDzciIk7wFTYVNuGmFYR
         pXJUvvDV9vFx4xg3F2yNvPN5DuUrDh5U1iTHU4jnkPs2i/D+oaKK0GrstNhaVO7cY+GF
         B6mYgF+7H9HNBSslJIAUxqLO+v39bXQ6Xjwn+q14oUjtuDHuwE6JjqOyhwqTRQpZJ6wa
         XUEzq9/TouaEELAaiCZFSRTFxvTDB9zzxMm6ysqJHan67AlDtEvhgOh/gooXwM/yDIYA
         ai+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794883488; x=1795488288; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y71Zhi4GfiQqdnuwaNE8zOzr/2i8FDu4fO8GyDaycAQ=;
        b=S3PtxR5crawhGaXvPrwpPF8zg//TV85U3T9rNUedoFp6EGDoRGxEMdknDkDzyB4+LO
         SE3hUFtHDnqczXQ6uTEDOwNUuGnxYPRFatOOd+lb+hhrhnLxDlHC+Rw00e34mxGwriU3
         zA3uj71LwHwIbxqerIEQ1BCcqWCkBYZElQms2cUFBjOgjtTEX7R5o4YJwLI+5m4S4dCV
         figtLs2nJJhpHqcSzwxwdCZvD5n9WdfOg5ZYD7oW52ptdBGXjYJI/Sa6jrvmi5MeahLf
         Ofl43azmnWH5ciBOKHPxvkp8NwdXrEctET4b7qBhfvb5wyGGyReMXplK3RiwNrG4eA/i
         etPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883488; x=1795488288;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y71Zhi4GfiQqdnuwaNE8zOzr/2i8FDu4fO8GyDaycAQ=;
        b=estIBQU2JmEmTR4QLzXxcxaNoP1C+P5bVo1o9qVmPuYrgQyjIABNuAVP1EWRSyVcyF
         g5yO8NFk0v1VvSt7YyHIrhsFlhijuVFgdWrMs0kT7qoZyaUPid4NBzVDpd5WmUOGxMvS
         V5PnXTtzfVQfrfqhN09eaEiFXWkUydPfZ4FTAjVd21sQ0/JVrqgQcJb0EELVZTOnwkKQ
         +8PZHw2NriVzCPWUg1tNlRJ6WZeSJjcORLpaCf2b7+RnS+kFTedwvkbjkpQaADcyBVM7
         4IkMm1i70dhw9OqTiBrSS2AiT1Phk1rEpgmdj+AhwWQAkVBfiALrKsQ+05HT/tAhOCAt
         eZdA==
X-Gm-Message-State: APuU4Z86aGF+qqT4vRBmSqOsiumGFqqHc3jO3MIqD06iV9ZwIZJz7xqf
	Dt/B2AQCBUYkqB2fl/Nn96BDOW9UD7ylT/UBcTAz2cTQtmLXPSO6Wi5dvCgSJXtWsWBlDVy1lMS
	Fta+1LttDKX6jaVH05i4mgHtO8SEy8cK6LtcD8Jm+
X-Gm-Gg: AZFdTZdthhQqS+TxLWKUuBTjnvvbOuJYOwBI4T0lnTZxhuFB/z//0cYuqWipop70NH5
	2Nkfx9/XqXSNcqlUkXoNPv4u9TY3RMwJV/z0G5sjZP+IR8TIDb5YeEHTZTzm12DBCQ91kwi7HJz
	BajAIl0YBqPmRyW2GxMgapuolIrYOiy0fD29F//vZ5DK3OPfghOqsZd6aiedMLghAaM/b22oSqv
	qisJgHWmmncH2WOxlxkYruSwMZvVFxIBlsz7B+z0UVTZI9Rxv02/2LB2ENDmDsGnj/MvIOcwKJI
	cX20XFI4jYt2uiO8GbogpnYzD/iia/26+NYOl6fjBul/xflY86W1nUud8EAAo8s757XGLdiTkHA
	zdSojWyyeBg8i2FsMyySjechwUQAd6Kr7ejvU7QAT7MwTgSO0NFrqa3HHEF4gjU2kIA==
X-Received: by 2002:a05:6214:33c5:b0:91e:a483:3f3a with SMTP id
 6a1803df08f44-920fd43ff0fmr22934896d6.32.1794883487876; Mon, 16 Nov 2026
 18:44:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Nov 2026 18:44:47 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261117011513.39419-3-seanjc@google.com>
References: <20261117011513.39419-1-seanjc@google.com> <20261117011513.39419-3-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 18:44:47 -0800
X-Gm-Features: Aa3M54qtM-vil0xv5LnJ3Zg50xXvT7pXuvhebpw4qAE5ZwUljOeOKWcaz5t5YJU
Message-ID: <CAEvNRgHSxudw-6C5t-90dnmmoXFjVHz4m+Gr7a7QzC_Px8oCjg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> From: Alexandru Elisei <alexandru.elisei@arm.com>
>
> Don't invalidate gmem-only memslots when responding to MMU notifier
> invalidations, as the entire point of gmem-only memslots is so that KVM
> doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> page faults are resolved by going straight to guest_memfd, using the gfn
> and the associated memslot's gmem.file.  I.e. whether or not userspace
> happens to have valid mappings to the same gmem instance is irrelevant,
> as are any invalidations for those mappings.
>
> Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> detect and handle relevant MMU notifier invalidations even if there is *no*
> memslot whatsoever.
>
> In addition to the obvious performance benefits, avoiding unnecessary and
> spurious SPTE zaps and TLB flushes will allow KVM to support features like
> ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> both of which rely on the pages *never* being unmapped from the stage-2
> page tables.
>
> Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [sean: rewrite changelog to capture the new gpc behavior]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9938b753948c..f0d95e8c37f4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  			unsigned long hva_start, hva_end;
>
>  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;
> +
>  			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
>  			hva_end = min_t(unsigned long, range->end,
>  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
> --
> 2.56.1.703.gf848ed807c-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
