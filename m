Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE51400E08
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525030; cv=pass; b=K23axKG5jEz1fjki84Nvin38LYdP/lQUj/yUfIA40LMxtpjrdyaGs1bpWSl2EHqS+1ZqnmDOiRQZuSSXVX72S2yBP0Oi2j8MJHWAjKptuRtUpuC4n8rGR1ijlLklyziUDdqgI5QQsPenJcEjkxFODiggSMGEs8F1grbLsP7v5mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525030; c=relaxed/simple;
	bh=gx3Oklyhw4/29KJrqtyCgK2OIzmZLnxgN7Pih2TRWig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFjEi7N6h8dGidyq7FjT/gvlotWZbi428GGYNFOERhTDej/Y3ckV26XI+pjFdsARKCNDZZ8kq48sdDRbywr5kYpG66QTiG7ArhpBdq1rSruUG+UQJcexubQBq61SiqXio2qMB/xU4iIAQ+xPu1RE0RA3cIlT8ajx4t0l7xW1a+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4SYhr2u; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4SYhr2u"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13721dfd471so59611c88.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 15:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780525028; cv=none;
        d=google.com; s=arc-20240605;
        b=PJ5F8PcwSmqkOymotKyith9kbBa0rL3/Gz7UVgr2LX0CCgfLUzec1MF/jHb+JFwsUY
         sJ7PQxJelUbl886rLF9JtNcWl+xddZfjcP+uMgg9CxQnpV1meao5XEyjQk8ttYud3ctZ
         +HcZUsE4vj6AJ3b5zN/SoqKIqqLAuQ+/MX10ize1Gg05V39V3jq8ZuVQ4b8MGf3i2Hqw
         r8UAcL/apx2QdCvmFHgsedUWTY7AuMkmIyXuYoOMEWSfTzx3PAwMVVVdn2rBjqtes+Hz
         dNfdODz0KXhMvhWjFO1/phz6hHuQabRBjAgW1outxphnNa4LItX37Y85YZm/Xq6jQynu
         /y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        fh=LzsSvsh6reHA5KK4UDWxRv5E6WxeUl+IzTynha2/sK0=;
        b=MZC564mYDgVaxpZqGxezkK5BebSCD34yrKMYGUwLuM8frDEESwZISYrGd5yarDLaH2
         UP7furty34t5DnaHjAz5iLR/6dt0aVpQVEJchYdYpiQ7PahKDWASFH28wq8ZdSXuHTPc
         fJJS6zrw+g6y8T0JqNyBOHSGYBh3xzd1lMh1QCFSLUWjTXwt3raWT/4oAzYT1CH/uV+N
         qfWhZseKzjjM5Qz+PfNRTt0HXCdr9KaiFueix4sNvnyQoQQepQ/Elpc9FJX1iGlaJjCo
         xLCYsHfsk5mjGFtg+Fnza9NfoKmvuBAdT0nQgfLV4zAvivjPvYr+WHk1r8+I/GST3IR5
         E7Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780525028; x=1781129828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        b=H4SYhr2uRLDPzz6f83p5O1Fer8tULbvijZOnixRCgPM2XuQ0Qqm5bkxekfoA6O8pLU
         LFu3tR/Bggkc21XKyBY+nkh/9nrbQPsTzbaDis9Q49I08+fHEMCyRwNOmUjhiA313Utc
         NV6f9RLeJJ/LzV9JePM/H9ttJjHsB65yPV+wzNZuYk0u7XXxB50nbqrZgVCv1A7RcYWb
         jA597R8xdbOAu5HX3aob4HCoogIXuiLckfzkbj70Z9O1fbigqRCZYEaYmEoGTo3Z2fZG
         IAmxnjjpD8+NzCHCQvk0aUHc/aT3L3RMJP9IrzykbUn0h5t7A4DWdciV5l04/UKpB6ng
         m23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525028; x=1781129828;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        b=foCUQnwGqGfMJr9H12AseKiz00OVQAtk0JfToJQLEU0HkasnScwUechoowvshhrk0D
         C+7gY4mwuBZ/KdIoN9EhK7j3a3+AcNuYLkElrVxik9PXcjA+Dw0S6ndUMh8rZBj+MkiI
         B508m718/SZNl1igYY1axXx4skl6a2OcWbgrD3oc5Uxr2gZ1e6yxsZZunQATGwPXCDxS
         gPtnyTaQ9S//HsquD98hbksQ3TQ7sb9OxTXFvZhUqAEbxbvPTxPAfgmDJMvD4DHi1u4r
         x+mQXFoIdSN7RsgTxBeBNnzLiD1S4ORZXu48Cox/NdhWAFs3AUWzOCL4/aPe5qTscSqi
         wG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ilyYbaAVpIVVwZzOj3g1AhcE9nNfIgbLuFBkHm1okTrjV7DCc3O6WJVBnysoKxIbKevo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksXwI5rGXMqT9GfXHXHEWyH7XBxDHKj7CJiHepkwfgjepqIhf
	NtsLpAKhY8BLAXXL301vfaHnS5/l4dxbk6IeA4CeURYtCOp3ZzzUKMlhxsNHs6zv3cnYE5QPVcs
	0dAaYbXA513bOOH1OYkYcM6wjAaX/gVuVBfLzIWkd
X-Gm-Gg: Acq92OFhv237rM7uHbkF2MR0RsYzJNtPB9LrTRlIM/ZGxg5s0CldTBpGYg/7GUZg5V3
	TC53vq2QPnWTttG+UY6daVgN3YmMsoTArCt9qA+KuBqpdmit+cffEABN5LyEa0tKD5N10lgyK9h
	/obMsH4Ok5WJSE2J4/g3viw3JWjXAt+IZOCIDl8U46LBjU5jdyP+2upFn9958A77rSQJCYS2Z3w
	aqy43mT35TYPgQ8mXRcVS6ra3Hs6Io1K01ZjMNlraw2CTgSGMWcOukUi4vbbtyO+Y/lSj0HKwiC
	GMb/jyRM3j72ea4pd0rJHZR8OjNIbDD2/0jTZ5WwXNmrFE7v5N7T8+LlvgaMhj8bvChIYvGGkGj
	6CHwY
X-Received: by 2002:a05:7022:7f19:b0:137:ef27:e29d with SMTP id
 a92af1059eb24-137f6c126b1mr1478374c88.31.1780525027812; Wed, 03 Jun 2026
 15:17:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 15:17:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 15:17:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahmbVaCUcBrYK8qO@google.com>
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 15:17:06 -0700
X-Gm-Features: AVHnY4KwIBznOQxPeeZp-k-7DNYvQD8SHlCWDjhKoWsxt_QvgGRs8hmrB0P3Bno
Message-ID: <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
To: Sean Christopherson <seanjc@google.com>, tarunsahu@google.com
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, corbet@lwn.net, dmatlack@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>>
>> [...snip...]
>>
>> we have one open Question left:
>> 1. How to check guest_memfd is fully shared.
>>
>> [...snip...]
>>
>
> Given that lack of support isn't going to be limited to _just_ guest_memfd,
> simply disallow preservation if the VM supports private memory:
>
> 	if (kvm_arch_has_private_mem(kvm))
> 		return -EOPNOTSUPP;

Makes sense. Tarun this was the other option that I was suggesting when
we discussed offline.

I think (?) it is possible to create a fully-private guest_memfd for a
non-Confidential VM, and even after conversion lands, for both
vm_memory_attributes=true and vm_memory_attributes=false.

In that case, your preservation series can still preserve memory tracked
as private by guest_memfd but not used as private, right?

I don't think anyone will use this combination before guest_memfd
write() support lands, we just need to make sure there's no kernel crash
or corruption in this case.
