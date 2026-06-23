Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE393932FF
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245205; cv=none; b=CVwlK64rHUkE/vYimJBrQwfnY7Z4w07tMCsRzMWOEo2SN/nz4oz/5lCrd9a1Kft/2gW1BK208HXb+avBaqyhnC5aEcK4qF1tEwKSf7ZdxTT9WI7JP+g+xkje0cQLMh1E0mHyV04mqJrmpj/wd+kRkB5kj7crIIbiB4J1mQPaIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245205; c=relaxed/simple;
	bh=ykMC2ieYQYVSxbapdFkuFJd/A1i/SI/0S63Ag5SQ2+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IRMx8gS1Lay8UvSxPVBWG/DGUeYrsRsp4uX/dip6xO//elmATS3dypq/RmYPxyn9/cZUyKgoOp7PxR5hYlsP6NFvBkETtaDOoA/yxt4d/sHmet6gpGLwxL7TjExNg3GAAG29vEpDA+BZZunNvL9jFBxRE7Jkj33EZZ2Yzv5xHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hItVHB/p; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hItVHB/p"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-695796f97aeso163050a12.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245203; x=1782850003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPy5Kp/eciXGU33EP09NXjsbX2uzzGfRHxirk+T+0A=;
        b=hItVHB/p6ViFVNt7PxMzW+TnRr3F7wzqELOAGwnVrgdqD7j0ceDj9QeSkB/wMVAvZo
         bV/gGRlk+etAb/RTu9kTPIS03VXX7FdRRuQz8FrfWfscyJLD7OOxHdNYaAj9B4ka5KTE
         iH5bxbf+4A3d6ZhCrc0zzuiEARShuiAiP+m89iv94cok2uUkaNbxLjOSPMbUkYV6Bvp2
         4bvOBNPQTjO/+VkQCqn0YjKra2i/UVG9w5OG0HvdqLFrEweVYQXclb2EB3sYoQHoKDNx
         oCpWw77zyfkhx7L9foHDxNstlsTNv94HID+mnWG2As+J9ck6LEul/e2p47tGaycrbjGC
         Bn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245203; x=1782850003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPy5Kp/eciXGU33EP09NXjsbX2uzzGfRHxirk+T+0A=;
        b=atwro/ije4jh/repIGgoJxt1U8/KfLsQfHHDfJeIt03zor18avqeNRrJt/Xt79F898
         fi2MRqpfS15+Zgk/IbDjEByi98wBqFqeOWAdCyn+u9MKq5s57CLxAeuP/zTonx2/4RAO
         5W3NIKJwyePuBrGoGiDUfSIBNAVzlnJPdfSRoXQo7q4QW1TJSWKoOemQCUDIaxrlFRhZ
         s95fvGm+wt4sE9wLnisaUzR4o3Ny1ZLTKkpsJrx/vl9yIWvgSJf8NVx9W9s1PixrxpDM
         HttlU8oNqXLp1iSPsvEZQ4A5XSc1HIBWwAStTfxuW8PWbS4gooyNA4OUkGo592XQh5tP
         ZAWA==
X-Forwarded-Encrypted: i=1; AFNElJ+zVVJZGW1LSkE56fXZM8ujtiEkQn2GT4s1tSm4v9iZqO6H/A5Oe+1Grac4qwdExILMWrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTth6VOM37a9XrM5rsGO39TvjXPn/0aGCCe7EB776AuwYtiDV2
	8GdjPcaAaTxUkJuy1I5WybcVmNmC5di4GDuxvhOP8fsRalMxp0TEXLj7Tm7u5ESlQGxeaN4/Ayt
	KiZYTChWzcEu2IM9MSw==
X-Received: from edyc13.prod.google.com ([2002:aa7:df0d:0:b0:697:e99f:d111])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3554:b0:691:b5aa:5a7a with SMTP id 4fb4d7f45d1cf-697f3adf4a5mr19296a12.21.1782245202451;
 Tue, 23 Jun 2026 13:06:42 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:06:41 +0000
In-Reply-To: <2vxz8q85mdyh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
 <9huztsqtmihs.fsf@tarunix.c.googlers.com> <2vxz8q85mdyh.fsf@kernel.org>
Message-ID: <9huzv7b910oe.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com, linux-kselftest@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Pratyush Yadav <pratyush@kernel.org> writes:

> On Tue, Jun 23 2026, tarunsahu@google.com wrote:
>
>> Ackerley Tng <ackerleytng@google.com> writes:
>>
>>> Tarun Sahu <tarunsahu@google.com> writes:
>>>
>>>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>>>  			       loff_t len)
>>>>  {
>>>> +	struct inode *inode = file_inode(file);
>>>>  	int ret;
>>>> +	int idx;
>>>>
>>>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>>>> -		return -EOPNOTSUPP;
>>>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>>>> +	if (kvm_gmem_is_frozen(inode)) {
>>>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>>> +		return -EPERM;
>>>> +	}
>>>
>>> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
>>> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>
> Yeah, I reckon you can get away with doing this check only in
> kvm_gmem_get_folio(). Normally you'd like to fail early, but as of now I
> don't see much of a problem. If you drop the check here and fail in
> kvm_gmem_get_folio() you'd end up taking and releasing the mapping
> invalidate_lock, but this isn't a fast path anyway so I don't think it
> should matter much.

No, Don't agree.
kvm_gmem_get_folios already have the is_frozen check. which blocks the
kvm_gmem_allocate. But not kvm_gmem_punch_hole. Your argument is correct
for kvm_gmem_allocate only. So is_frozen check in fallocate is to
block the punch hole as well. What ackerley said is correct.

>
> I think either way can work just as fine...
>
>>>
>>>>
>>>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>>> -		return -EOPNOTSUPP;
>>>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>>>> +		ret = -EOPNOTSUPP;
>>>> +		goto out;
>>>> +	}
>>>>
>>>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>>>> -		return -EINVAL;
>>>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>>>> +		ret = -EOPNOTSUPP;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>
>>> There's some reordering here. Why not let the validation happen like
>>> before, then check kvm_gmem_is_frozen()?
>
> There is no reordering, if I am reading the diff correctly. The diff is
> somewhat misleading. The kvm_gmem_is_frozen() call is added at the top
> of the function, and then all the later checks are in the same place but
> get a goto out (and hence a full body to the if block). So the diff
> reads like reordering, but there is none.
>

That is right. I thought Ackerley was asking why not add the check after
the all the if condition and before the kvm_gmem_punch_hole/allocate calls.

> It would be very neat if scru had a cleanup.h style scope-based locking
> function, but on a quick glance I can't see one.
>
>>
>> To align with design. "stop the fallocate call if inode is frozen, No
>> need to go further". I dont have strict opinion on this. I am fine with
>> taking it across punch hole as well to make it more fine grained. But it
>> will no longer claims stop the fallocate call (allocation one is stopped
>> in separate path: fault path) , though functionally it does the same
>> thing.
>>
>> WDYT?
>>
>> ~Tarun
>
> -- 
> Regards,
> Pratyush Yadav
