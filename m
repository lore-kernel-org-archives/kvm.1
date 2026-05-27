Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AC3655C4
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909108; cv=pass; b=RYWwvyw57e0kw27jQW0fmG0AVKGF7/oHppc8G+qbhOy8dg+aMwKB2YHuhhnA/wydQBUmswx1fyD/12oeJt9k0LU7B9kImSqSPKzQBH8kF2AV6saXMIzeA/aiNDhJkjqJ14xk3k5SSrxrJnyumI0OGpzNLSI9xUhoQtQx4n4ty+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909108; c=relaxed/simple;
	bh=rS5bK7IwIlskYEDOipfKrEuNeVXLgKbZp9e4SthEl0U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUM4eaRms74qGR/PNiWseh+X+RvH4jqdIGqXmWdGg1kP8AF4V9cZ2xNM0/YyPdt5tPO3OW4coXoFLbUeI8EsGsAeWQcY1wwGYbb3ExA03hQan/2EdxLxqaVwGbPhkupkpp2aVXqzYKd4IwyXMH0V+K1hNrxUW8CeTvIC6wl8Deo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hObYjZJD; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hObYjZJD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12ddbe104ccso8940387c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909106; cv=none;
        d=google.com; s=arc-20240605;
        b=AMkCSoUhMLTkrTYNNza4ny/tHizzntGjZRHm+B+KRvXhftZZnOCxYqiJH4eR+eZdDg
         qp9SDUQ75QvzUidqDbMwUjKQTlGX8XxuXHAaSOk+ZTP3gQ0rhyS+up8Zxx1KqXzIZn1m
         HEAqo4hJl4OyBXgGRGUlRbmOdHaNZBiD8LhqG7OS6lGnZBX78aM58VL95galUQC0hnCe
         A6T1iOtih9rLmJgVtTL+CecZMz39CYSnkyn+JCAzNujhtLV4UOhXbYdCyp+ydutDIc9v
         5QEIkmKY9pjVAkJHMB6ljivuet7ryIzAAs4Jsu/QZbPvnsU6vTaJC9avBSRqqA8ONCnZ
         bvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/iOy9oeAWJWkVK3CTYdsdZ3vk3yFbXZM1XcJc1qE60c=;
        fh=GeIn1lAshYjRaJrdVoHZf+XEZe+na/HnY9hoz8ewmOA=;
        b=CCr8ZDCM6bbAj9ZJq8/NXYIGVrXH7NE8RNkAtSqATV6plpxXxreTkWd+eoRXPnqDaX
         POTIrgIPJHd/mZpQ40HMpQ9U+HvjDfcq0VEni74Pza3PrxViisxEKISlLA/zBjWtksJv
         /Rciw4G0c10Ms8KGfTc5YXJ8v4A5yAN0AkoS8ylnKbWcO068lch9In0P+1FYvp/o9e6j
         ERBsUUvNUqvQ9ttcVd0A9/HfmqziyEbzIJ+DiVSjLyeqLzckzYYze4S3RkyBOzfPn9jx
         M5xx8pjq8++31HqguMe3Aj1rk9gm1MBAUU/KIO+1pm5bpnW4RzQ4h7f49lW68+cQKcyV
         2dKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779909106; x=1780513906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iOy9oeAWJWkVK3CTYdsdZ3vk3yFbXZM1XcJc1qE60c=;
        b=hObYjZJDyX6wds1SjEZbISo1A//I21GetEQmlSJLEgcamKm5eTGJCaPEZSjlA/BLEK
         ZOtbzGc8zm2kNShUiCgOMCYtJV9Qj5vLsgmQ6XYspfy1vQ5/ctnh8lqaL2kSGkq9hvXl
         QD4TRVZ4DNvULWgb/vBIDxwISHxA4a8Pbzs0gthlozy5SVsv1lfNEI7g3zGM6VT0naAU
         g6E2PPQrgNMOYe//RlQdyIoTkYsyVpoauS1HhCSsNXH+iGFkeoCkbmks5EC6kvpow4ch
         BhHY1GeN637++nsa1cd7phqftGmmzU/e15QN0xkv1PAZfRaRIXRfOrcj/rr+B8dgmQnh
         mEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909106; x=1780513906;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iOy9oeAWJWkVK3CTYdsdZ3vk3yFbXZM1XcJc1qE60c=;
        b=of9nOxZzet/BB69pIyLAd08IW6E727+BfwjKF1zc6x0nfbb11Cp6Z63rBQl0LnyGwG
         1IBk/JSuxbozZzUODA1TOIbKBvdEoKHUh50EhubxoStKn0E8quAXM2DZ6QnlO/iChtKe
         f23y3GFv0FzRAC79xlV7dZl4ImKyLaP07+l6Bq5qGMUju5z3b8eR9CF+yF1d90EzoXzZ
         wDQEVX0ngrsTB83uQdTxG0EenOso7WvRUDt+UhEudXE4KQ6rOljUg7Ojsag3e8Pf9zgE
         DXUoKRv09K5Jxoh9W0MsiJLRuwWi2/K6Wfs4AX+zoibVFHXcFljidbQdV+0kEgaUV+pw
         H/rQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lJBglcYlec4oqh1m0HcL9ayqGqA4W/I51TLn7AFTJmyIxwGlQTIjrmsZeYPXXbpni8oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHzt85VTJKbEdglmW3IBuY1OMQdFfGRQBETxgbAzpIkxcEoBV
	/epU3mnBYLa8hEVYnsrUOobmGJdbCypS2qaYw/qaWdxnpwbbzrsytajYJC9Bgc2249Allrfx+9z
	/bcwzXmj8fnehIZ9DMTtLB727MEnEqVPHQ5QeLh0x
X-Gm-Gg: Acq92OFF+v2nJiAr10GJMF1Y20nnDFGgZ0fiQONRBECkazw7A83w/qDa91ahcSHgj4Z
	SNt7XXlDnSGoRt/4YJ2s9+PDmQcoGc/z6EG7NPbXqvSHDTqMIgsyF5kNZXGdCV9/wHJ3aZhhACE
	2h0s9Eizqx5rrrSMG4YX4FhbsIQun5pENrk4gJEFWZjzBH9i0Fb3sCzc6nLorRAwm/6rpQkYSzr
	BQZMvIAXjvLBIX+47F3wkeGZJbHcIUsOUjLyKJ0Y/ca2rceoEIevgGZf157dNpFBECVz66WlivU
	EOJyJOCQFtcr6a3E13rq0Zs0p2jH1+wKYbB8oRUpAL0ZA0pLMwemO7ZLysj8EEiCykFs7etaxjD
	71ijsbbpVPtwL+Q==
X-Received: by 2002:a05:7022:6624:b0:136:83f5:c99 with SMTP id
 a92af1059eb24-13683f50f0cmr7372245c88.5.1779909105156; Wed, 27 May 2026
 12:11:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 12:11:44 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 12:11:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahXMzPz1cQl6kZge@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-3-3f196bfad5a1@google.com> <ahXMzPz1cQl6kZge@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 12:11:44 -0700
X-Gm-Features: AVHnY4IPedUzJdSkNoWjnu4aPO2wBw2uvc56SVrS-WCZO4xFwUugZXQCckX4e_U
Message-ID: <CAEvNRgHnxEO+jXqEKuewiDgFBDQDSr68A8MnJJSyf9K5AgbwWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] KVM: guest_memfd: Handle errors from
 xa_store_range() when binding
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, May 22, 2026, Ackerley Tng wrote:
>> Unhandled errors from xa_store_range() means kvm_gmem_bind() might falsely
>> reporting success, leading to false assumptions in guest_memfd's lifecycle
>> later.
>>
>> On error, restore the unbound state and return the error to userspace.
>>
>> Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index d203135969d13..5b4911ffa208a 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -648,6 +648,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	struct inode *inode;
>>  	struct file *file;
>>  	int r = -EINVAL;
>> +	void *result;
>
> I would rather go with "xr".  "result" is too generic, e.g. begs the question of
> "result of what?"
>

Good to go with xr too.

> Actually, I don't think we even need an intermediate variable.
>
>>  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
>>
>> @@ -688,7 +689,14 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	if (kvm_gmem_supports_mmap(inode))
>>  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
>>
>> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>> +	result = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>> +	if (xa_is_err(result)) {
>> +		r = xa_err(result);
>> +		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
>
> I'm not convinced this is necessary.  Sashiko "asked" the question:
>
>  : If xa_store_range() fails midway through storing a large range (for example,
>  : returning -ENOMEM), does it leave the already-processed entries in the
>  : f->bindings XArray?
>  :
>  : When this error is propagated back, the caller __kvm_set_memory_region()
>  : will abort the operation and free the memslot without calling
>  : kvm_gmem_unbind().
>  :
>  : Since the partial XArray updates aren't rolled back here, could this leave
>  : dangling pointers to the freed memslot in f->bindings? If so, when the file
>  : is eventually closed, kvm_gmem_release() might iterate over these dangling
>  : pointers and write to slot->gmem.file, resulting in a use-after-free.
>
> but I think Sashiko is hallicunating.
>

When I updated this I kind of just assumed xa_store_range() always
iterates indices (so for a range [0, 10], it would store 11 times), and
an earlier index could be set, and a later store could result in
-ENOMEM.

Since you called this out, I dug into it more.

> If @entry is non-NULL, xa_store_range() pre-creates the entire range, before
> storing anything into the range:
>
> 		if (entry) {
> 			unsigned int order = BITS_PER_LONG;
> 			if (last + 1)
> 				order = __ffs(last + 1);
> 			xas_set_order(&xas, last, order);
> 			xas_create(&xas, true);
> 			if (xas_error(&xas))
> 				goto unlock;
> 		}
>

xa_store_range() doesn't actually always iterate: if last + 1 is some
clean power of 2, it'll create a higher order xarray node.

Otherwise, it falls back to creating and storing 1 index/node at a time:
if the above did manage to create an xarray node, xas_error() returns
false, it goes on to the store below.

> Yes, the API handles failure on the subsequent xas_store(), but I can't imagine
> that failure is actually, barring garbage input from KVM:
>
> 		do {
> 			xas_set_range(&xas, first, last);
> 			xas_store(&xas, entry);
> 			if (xas_error(&xas))
> 				goto unlock;
> 			first += xas_size(&xas);
> 		} while (first <= last);
>

So if a later xas_create() fails because it runs out of memory, the
earlier stores would have already been committed.

This ignores -EEXIST being returned since earlier in kvm_gmem_bind()
conflicts were already checked.

> Purely from a design perspective, providing an API that can fail partway through
> under normal operation, with no indication of where failure occured (AFAICT),
> would be awful.
>

Do you mean the API of xas_store_range()? xas is updated by
xas_set_range() so that should track the last store. Since the cleanup
is storing NULLs and won't allocate, I thought it would be fine to just
store NULL on the entire range on error.

>> +	} else {
>> +		r = 0;
>> +	}
>> +
>>  	filemap_invalidate_unlock(inode->i_mapping);
>>
>>  	/*
>>
>> [...snip...]
>>
