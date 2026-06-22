Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBC29CB24
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172461; cv=pass; b=DwNngBEY9OhwtzQ2EPPeLGFpNqAugo6RsfhRrO8S3INucOLcY4gEW3ebCYDZPEkfxF6IYzpaOUC6dT7iXFh46K+GFPEaKkZstxg6axE5iEc2TyJFdhPQ8dj9RqW1im0zrwgakJ5BoBdmJH3siVryB+ye+2Ubp6iO1EEC+hqOQCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172461; c=relaxed/simple;
	bh=I1YUlMWYpoFKoByVcCt8Rqs1cgeontbmcE6KLy6U/tc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7CkKAfQWPO1V05HmJDjllaSQrQswxEibGxiYciBUQaNXv7fhLpS4Shl/8UcwxvNWocqEJ7JI/5ba1eiCIBakmkYTlDUReOp8yD7YoTGKIhJhoXq+RBonbDzn9hZHYoBLNRYIfch9c96F1FzIpvICRsL2xeKBXGP2lTkEqA+r9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPsTpHfr; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPsTpHfr"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c07ea058c0cso828418266b.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172459; cv=none;
        d=google.com; s=arc-20240605;
        b=E/hIa9zKK5JsSKk/I16wNQumnVri+HagMxropIAQb2ZhWsznPJqTEPVuMuXqzuZYm8
         VAa1IRVCO8P7JNCP1DslBI6pyyRfR8NJFfd8ItDb5a7fw4ATUJDppHpoGBolpNmTRtTl
         T3AUDYLiGkSPpgeDuspVt+Uu/4u66xcJpwlL12ddOdrsTwOcz7BxroF3dVtlaSME+zvJ
         2pHMmhVteJtU+YdVNhTyThDLIsAN/WPHKlEZaKcrQDzvlBFK/0Cf2RAoPs8ADqV5+yc+
         4op29NGx0v9dm8L4M0HS2ie5iT3ziB69fyQqn4TiAityQjCGn5V3P/1+/ktYpAgbt6Xd
         4Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        fh=U6i/tVyzdbx+Ij+pdj0GDdskIJhdNEnff2tJca196Yg=;
        b=iFZEi8ZeiaX8cZ128cf3mmsuC511igK40D2NcmmOLSBnCBRzbmfcFjyCtYI6DUDAzl
         sfE2e+bo0/UZ+uLi5WDWjaP7fOQX4z9G2faWyIEdI48rl0CgpPosgNQR0qDNrYTB3BRb
         rQeNm/KhoXw4HBCSG98kyJ9lwqaQCSC6Rj62gCQlBvAUoaPLFsaOAiKDecZGcGj9uSFS
         +j8+Hb6comrzXiXIXmGzNgOrOKy+G0zXYxPSmxMIPyFit0f5LTDywxwU91MY7wHlVqb0
         /KZxxh2vqUFxt5KU2aLX8X0qalRKJ79okS8Ah1qh8E6vDEzxff4HvdiyQJA27Qi+8jv5
         titw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782172459; x=1782777259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        b=jPsTpHfrfh5ppMR+gyIUraMIwJm/OYLJsOd3N6OB9vvTjThH38ksYWY8D2FkYROTyT
         ZgSscTWoUdDnsJQqcFcC/PUIqjc+4bmZymQRLfc0ygApUzPtlp0kouCgEcRg7wTXtuov
         ubH5HACVSgpKbL6ZBAosYe5cg3G+ndkWDi0S5sNXeff0DrhdbBd5SnvLvSCP1ix0N8Bp
         7v2sUOKQ7v9//5QbDiEfzd8xgU7FGkmplZdLsYMwI7oEvh2uz/O0tI6/btHYt+nyrl38
         9Vxnt0A9w3JRt6Yr2k/5pM4l8AqrMV4PPjvsAi7U01/bXYcy4/tk6rrgZfHbYlJV1cQ1
         v2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172459; x=1782777259;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        b=I7Cf/P9KYfrplTJPegqBr8Dj6Ivd7f7QjzOpTdBa1lw1D72MqCnn+2+dOfET8Wj9a2
         G6wWZnzXtRVGTKetGkj9U/tpXAX4T/Dzn3Y864jUYBvlm80nCbnFRYANUStl89/bS/9b
         +MlZXbi07DmvdWqqOrUitvkbJt20F9UnPtHdXjvIRRfqpeaj6u2/wOt8vMPyqocjycU9
         iwuf7gdrI0bZzXRKRNe0odTYlORIKam5NmI/5PBBKUNWLfLLiFEIw8MzCl2uQjlWW0rH
         /jMgk/w1oMlRhx4+Qmv2fQUlz6BNcBFIDPGiwe8ZUKZspSy8d/kpqwRufVuTSQSw3rH/
         ZZsg==
X-Forwarded-Encrypted: i=1; AFNElJ/L4GNhQXmYH5skBawFXg5FD0K2uU9eXiApG0RUTmfsHi4Uhi7oeJz8aMFjYrykoRkLbaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdS4fUBZnKBPBZoUre3h2x5PxubJpGDMOdaTZvO77TVy1mqtD
	YSqigJ3r8iB/OozV4YDSWJ8SwwoAIE52dYlP3WvT0gwsnRxGlfSQ7WzJETZOKatrTki93Zha7tY
	EVrYSP2AAj6/CtzGaM80mVU1ZdstCwhKF92+uMT06
X-Gm-Gg: AfdE7ckdbBpkAU3iYiqUnDre3Yoj+2ut2+okA7BqYO5VeGeSP2MjUpMRSXr9r4RPVv+
	gOlm34UwHH4rC2+gCoTmJrraYicgaZ/4mp7LdjnBD76l3XugFRzPBaiTWHmjXps4W/7o2HCaEpI
	wSeEN1RwyfBnY/yam2+nUdZ5nKNPcz25PKgZdnkoUjbdMD3CKQy02lBZIGZ8MufY/d4ed6oX99X
	GbNglaGBOkblhlovd/gsurBeYLdLBnTMXdADuMN8aHA5L/xqDZpe+vDAXZmDY1ExG720GOzEJbX
	g2nfSZ04i5KYQTTZtuvGCSg4M82OqsmsmHUInsxJNtAk+jEJcUxl04z9RRg=
X-Received: by 2002:a17:907:a394:b0:c10:1041:65a4 with SMTP id
 a640c23a62f3a-c1080b8e977mr13124066b.42.1782172458193; Mon, 22 Jun 2026
 16:54:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:54:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:54:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:54:15 -0700
X-Gm-Features: AVVi8Cc74PEpV2YXCZJIskraOwZy9-czhUt_HBd1DYeN4YnAJwWFzkRCg6GbGig
Message-ID: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
To: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

> This patch introduces the freeze on gmem_inode which prevents

Can't find the reference now, but commit messages should take the
imperative mood and avoid "this patch" [*]

[*] https://lore.kernel.org/all/YKRWNaqzo4GVDxHP@google.com/

> the fallocate call and any new page fault allocation. This will avoid
> gmem file modification when it is being preserved
>
> Used srcu lock to synchronise the freeze call, where write blocks
> until all the reads are free. And reads are re-entrant.
>
> Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
> must handle this properly as every new fault will fail.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> [...snip...]
>
> @@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	if (!IS_ERR(folio))
>  		return folio;
>
> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
>  	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
>  					 FGP_LOCK | FGP_CREAT,
>  					 mapping_gfp_mask(inode->i_mapping), policy);
>  	mpol_cond_put(policy);
>
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +
>  	/*
>  	 * External interfaces like kvm_gmem_get_pfn() support dealing
>  	 * with hugepages to a degree, but internally, guest_memfd currently
> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>  			       loff_t len)
>  {
> +	struct inode *inode = file_inode(file);
>  	int ret;
> +	int idx;
>
> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
> -		return -EOPNOTSUPP;
> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return -EPERM;
> +	}

fallocate may eventually go to kvm_gmem_get_folio(), so that would check
kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?

>
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> -		return -EOPNOTSUPP;
> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>
> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> -		return -EINVAL;
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

There's some reordering here. Why not let the validation happen like
before, then check kvm_gmem_is_frozen()?

>
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>
> [...snip...]
>
> +
> +/**
> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
> + * @inode: The guest_memfd inode.
> + * @freeze: True to freeze, false to unfreeze.
> + *
> + * This API is used strictly during the live update / preservation transition
> + * window to prevent host userspace and guest-side faults from making any
> + * mapping modifications (such as fallocate or page fault allocation)
> + * to the guest_memfd page cache.
> + *
> + * Synchronization Strategy (Sleepable RCU):
> + * To avoid high-contention VFS locks (like inode_lock or
> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
> + * (`kvm_gmem_freeze_srcu`):
> + *
> + * Global vs. Per-Inode SRCU
> + * ======================
> + * A single system-wide global static `srcu_struct` is used instead of a
> + * per-inode SRCU structure to completely prevent unprivileged users from
> + * exhausting the host's per-CPU memory allocator. Because
> + * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
> + * is not accounted by memory cgroups (memcg),
> + * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
> + * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
> + * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
> + *
> + * Flag Modification Note:
> + * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
> + * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
> + * flags are creation-time flags which remain strictly read-only), there is
> + * no possibility of concurrent bit-modification races. Therefore, a standard
> + * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
> + * synchronization loops.
> + */
> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
> +{
> +	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
> +
> +	if (freeze)
> +		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
> +	else
> +		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
> +
> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
> +
> +	if (freeze)
> +		synchronize_srcu(&kvm_gmem_freeze_srcu);

Why only synchronize on freeze but not unfreeze?

> +}
> +
>
> [...snip...]
>
