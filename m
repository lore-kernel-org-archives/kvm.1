Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F237F73A
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223360; cv=none; b=bD7DywNN30/61ocPWskgGNCnJLd4+njvcjNZJTFoukkwDfmKuQv47imiML+yaops6lS1oyVRMY1GSH7+yhQ54GWO4Z0tbX8TXWmy5QnCxQiWjEIvtgDDtvn0Q2UUDbJeypfBv5CBH4nrH4+vXWUJ7fN5V/iKo9xvw8dsYCyNGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223360; c=relaxed/simple;
	bh=uM16q7ixvDLNzU4v08QmwcMF9g91pvd5QII7UaO6Yl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ehrm9zhHtktyx0kOoHSYcyy6rbVXHFCXQuLPBo5XFWKZpGkxyyqDWoP8zyXsMVZ8zqZiB7twIJg5cKCmKo8I7pq/Id9qVMO4scewX5ZYzT3gss7QPyGAdjLBf2bBv6stG80uwH1/offaLG7vDE+Vnik1FurWOfwk0revI/jP4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUNvbXav; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUNvbXav"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-697ce645cefso1358929a12.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782223357; x=1782828157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8d+9heMc41zxWGzXNGvGuprR44PnpkmTW2E3tdN2iM=;
        b=XUNvbXav7totg9vS3uJFoyrO2JD6MXExwdAUNIVXYLKbXcgYGp/cxfLU3wO7MdFrmy
         065ALXDwDX9vqdgDKMnyzBMHvkDJlTpLMn9fSN4z/fLnEIDPNx0k90Q905Ys+/KMyTqu
         s3qL1trpKoYT2CEAVT5s2TZadm1SeFGQjTPqO/NhUNQU1Iv00e18PeM3rtkeWdtUfQCn
         WgT+KFaqRn75t8KsBx3YSNwUPOQWEHG6BvJtLcIwg1/xhjwQUqykV0C7RfrTFQhbdzXR
         1j9mABmqXjj2i8As7bIkFYsFlhXUYYQtRl1UhB7gaDcsrpc5+fbXOgHd5pRTzdhQm4A2
         Os6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223357; x=1782828157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8d+9heMc41zxWGzXNGvGuprR44PnpkmTW2E3tdN2iM=;
        b=KlM7E1KgxatZYdgvntS7Ndmxw69bg4XbIa7LhBAiZmyglbopjhDcF9FwnAm69bEucd
         WrMzUmQfjcOWhZiVYhM8bdtGxpjFfdmvia/7CpZYMW5hEi8c6OXkksrQEADLHnYp8KbQ
         naFQ8xHU/fRMEaXhrZqdQXkdY2WUlCVsuYJH21FJIJcuZCtIxYjafYiUREbZBEC8HqbA
         OwEMejh0CIJshF5TtBOuB1YAEJEvmpkNsRu+9p1e+2KCzJBexOarU36zqSz5w7dh+3hr
         +8SQzh97x3wfL4Uxh4ERVdtpFdhOcPXdhaOJ+vfOEpRIcNyfVXfOx/Wq9VFNKHEMfMTt
         ONCA==
X-Forwarded-Encrypted: i=1; AFNElJ+lfgIc7mxOt61j3bNZqgisNfrNSxHH0Jkni9NuWoAqtbSi62OeF99t7SlfKPB1oCbTEp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99s0ZYOq1Xq5fChTzFwdBZ3RZ+KEhBXnYviWMRoUldzv8xUsr
	1Z1B15b/5yGIG6l1IHeKR9OTRD2LzB74QjDqHOFxj+L69yDfsGhiQsMYpxp5T1E6xr8FMlYKIRa
	xcQU9gFwaDmtoI0bH+Q==
X-Received: from educ24.prod.google.com ([2002:a05:6402:1018:b0:688:baf2:39d7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3487:b0:693:2a2:9e41 with SMTP id 4fb4d7f45d1cf-69711df46a6mr10466827a12.19.1782223356390;
 Tue, 23 Jun 2026 07:02:36 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:02:35 +0000
In-Reply-To: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Message-ID: <9huzzf0lmk1w.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
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


Thanks for reviewing!

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> This patch introduces the freeze on gmem_inode which prevents
>
> Can't find the reference now, but commit messages should take the
> imperative mood and avoid "this patch" [*]
>
> [*] https://lore.kernel.org/all/YKRWNaqzo4GVDxHP@google.com/
>

ACK. Will take care of it.

>> the fallocate call and any new page fault allocation. This will avoid
>> gmem file modification when it is being preserved
>>
>> Used srcu lock to synchronise the freeze call, where write blocks
>> until all the reads are free. And reads are re-entrant.
>>
>> Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
>> must handle this properly as every new fault will fail.
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> [...snip...]
>>
>> @@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>  	if (!IS_ERR(folio))
>>  		return folio;
>>
>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return ERR_PTR(-EPERM);
>> +	}
>> +
>>  	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
>>  	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
>>  					 FGP_LOCK | FGP_CREAT,
>>  					 mapping_gfp_mask(inode->i_mapping), policy);
>>  	mpol_cond_put(policy);
>>
>> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +
>>  	/*
>>  	 * External interfaces like kvm_gmem_get_pfn() support dealing
>>  	 * with hugepages to a degree, but internally, guest_memfd currently
>> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>  			       loff_t len)
>>  {
>> +	struct inode *inode = file_inode(file);
>>  	int ret;
>> +	int idx;
>>
>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>> -		return -EOPNOTSUPP;
>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return -EPERM;
>> +	}
>
> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>

Right. To catch punch hole case. And read lock being re-entrant, so I
blocked the fallocate call completely.

>>
>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>> -		return -EOPNOTSUPP;
>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>>
>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>> -		return -EINVAL;
>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>
> There's some reordering here. Why not let the validation happen like
> before, then check kvm_gmem_is_frozen()?
>
>>
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>>
>> [...snip...]
>>
>> +
>> +/**
>> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
>> + * @inode: The guest_memfd inode.
>> + * @freeze: True to freeze, false to unfreeze.
>> + *
>> + * This API is used strictly during the live update / preservation transition
>> + * window to prevent host userspace and guest-side faults from making any
>> + * mapping modifications (such as fallocate or page fault allocation)
>> + * to the guest_memfd page cache.
>> + *
>> + * Synchronization Strategy (Sleepable RCU):
>> + * To avoid high-contention VFS locks (like inode_lock or
>> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
>> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
>> + * (`kvm_gmem_freeze_srcu`):
>> + *
>> + * Global vs. Per-Inode SRCU
>> + * ======================
>> + * A single system-wide global static `srcu_struct` is used instead of a
>> + * per-inode SRCU structure to completely prevent unprivileged users from
>> + * exhausting the host's per-CPU memory allocator. Because
>> + * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
>> + * is not accounted by memory cgroups (memcg),
>> + * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
>> + * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
>> + * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
>> + *
>> + * Flag Modification Note:
>> + * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
>> + * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
>> + * flags are creation-time flags which remain strictly read-only), there is
>> + * no possibility of concurrent bit-modification races. Therefore, a standard
>> + * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
>> + * synchronization loops.
>> + */
>> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
>> +{
>> +	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
>> +
>> +	if (freeze)
>> +		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
>> +	else
>> +		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
>> +
>> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
>> +
>> +	if (freeze)
>> +		synchronize_srcu(&kvm_gmem_freeze_srcu);
>
> Why only synchronize on freeze but not unfreeze?

It was not needed because

Freeze => True
When an user setting freeze to true.

"Preservation will be stalled till all the current ongoing allocation
finished, and future allocations are already stopped."

Freeze => False
When an user unfreezing, current allocation/fallocate will
return -EPERM, and future one will be succeeded as freeze is set
to false. Synchronization will only stall the user, behviour does
not change.

Unless, user expects that it should be waiting for all the ongoing
drains.

>
>> +}
>> +
>>
>> [...snip...]
>>
