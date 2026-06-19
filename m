Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DF54654
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828240; cv=pass; b=eiTPseSZ0mYh3eXl6d/fDavp6J+V1Jlv4ccpht5czT/W3ktbOoERQnBC2mA4c67MYvnsTT7DvwN8mG/H0itxcgap/bTaned8Ng2ZggfKnv5bToB3vKSCU8A11MErms0VjUJgTCkqWjjU9W1dJSfPJhSI9hPABhtSlDDewbbJ8Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828240; c=relaxed/simple;
	bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itoeHy3I4wVhwT63CULD2pz4pTN6jK22GJtxGZ5RBm8MFmVcu6PcWXE0Zzo473Xvh+Jlsw0Bk9ZVRhdg7KONmAmoiCT4GNIWa6alLpTKGBpPcKMfJNqKkUnf8bz0zvkUpBiwQEJrwwm00kLlJgcYfAqjLxHLfbLI50CVrbVRhcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noNjZZVJ; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noNjZZVJ"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1384ebe7a10so3131981c88.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781828238; cv=none;
        d=google.com; s=arc-20240605;
        b=Xhn82ZqddTDyBBTfti5RYHk2ZOorGGLuKEBjKjjlWzI10Y7Y61AjwvOzWcOik5Xo1J
         M9Sn6r3pOL4BoTDqzYCzKkIqfIHgPBMg5E4DMV4D5OQaKqvRcmNFCVSlQMDFbaZJ6JC1
         Tw4W6rKAXgIDZDlMxrTiLbTBbNDx8QuLLBB2XuKIB9Cyakyy6wPauzIC2BDYLmSh9G+d
         /Z+zoGbNQTuoMHtU+jO3ARGymtbwy4GI0M34EUYE1Ttw+DIDB/KbbjF3KdgC2pYIpjHu
         Xclm+IIy5YDDOGtYHrgFdiIhq4sz+QkgXTpk1RCZ90N2SnOln3eQA2lQb6jf0hnqIP+c
         4VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        fh=B0Sa5brbE/Ua3otLWA1xgm7I5fj+LFAa2JQLllGmumg=;
        b=b4RD1EIcmHWQ9DUQiO2lKilCEKDzasEIt8eEJ3d/F9dnlpCbu9veYaCvUvfgOSirAs
         LrQUwKMg1KG+dVWJacSUj/FEwHPjbgQpYQD80pVNHG40ELrH5W6wIPC6Id4RLZEiPtIK
         rWN2Lu/E90nsjWbs5oWtJ+8PkoUumCllMSJYNCd07Xg2+eSuvfhVPGbw7uAcgDQ5wqSW
         xvjGZUdQgbpyFrdyDAlOLscyr3QcUMP6vq07vpdjBv7lE9wC84Qm97cCOmorvJFLT3MP
         EGiaoKx3hapT+mzXRjiWaEZh6guCZyN6xEM6FDMmYyo8Y0tfUHXQktJCp5cXht8hYyHO
         iUew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781828238; x=1782433038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        b=noNjZZVJSVpNT78mkJIlyr9NrDBYKny13jo4T5YHNT13Wh/uj8GgVXqRPHWUUlAgJv
         kG/Lhn08EyrGhSXGE1jGHYc6OOrYzWHL5hca2/qcXkqX69q70/Qass9Y7NGwovU+AGd1
         W7P3D/zv+RmcleXAQsbs1EY3/1aQ62OZMOaJ7yy/j7x6fNKYGJ4bsImFHqLYdtVhX2bO
         cYhyRTYXL2amzXZExnXoAzDjimAHqfEoS4h4mDmSNYaWzLHfT7lri+FfoPppxGRU11Zy
         hUhOSnScFFwVdQPC499GZxp5jGvNRBxrKd4fTDwgRvo03cHJNOi1E3JTuyDs9TkRmGE/
         VXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781828238; x=1782433038;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbpfyvqJcFkrtmEYwnR99Bs4srke7ZgaUq2BE34tWXg=;
        b=UQrVR7gMyvVdAYSAMSnSBhKs3H/EuAYs+14r4Pcq1mNTz8BRPLxlpkB0x8ehq0lCuN
         ejb24ACGou1kkRfvzuwI0TaSBMV+eCK/srf3twwoNr+eJVsfiTMIyM/OijmFan11XyH+
         ARkA9Hkv127m+MS7d1yU9U5A74G+LYRXpKzKufoEPo0ickYcEMXU/rOGZYhc71Ly1prN
         Rzl3FTe/RUjiAS+Ury19F8mQGD16ihp/DhGDS3CFgZk/w/CIbDwMgxBpog1GOaQjJ610
         16auPhM5pjWjHSNa7akBjBPqtdN6EpJ5J41sWuIZSA90gU+Zm1ePSMkDzYsdcTFwDico
         IHDA==
X-Gm-Message-State: AOJu0Yw8RYVYXdUTmD21FLSpE+PEoV70rMqi8/e8s5zuTUHUadDugRHf
	M44cSElK3QBuNVLwYZPkNfXoLHYBGdHs6hW7aSgz+rCc4hs5zpplIKZpXQR17qGbE3CLZhzvDYW
	9BNOvshXRqF76XxLhSwQ07JIl2ZbFD6a9RPed3QG0
X-Gm-Gg: AfdE7ckM4y5pr85PSVrlwoLgCliO0wE8y+kPT2f1uBVWlhOiM9n/GX7qG8M5RJSPj9m
	uqhfO4op6NKgdbI0hzN4ltnkLuhRiK/gJbquA57VM64O2+NfpPe3vmJkj7adyGpCqF2BidG6lUQ
	UP1WCSXQGDguUG5thbhbVq0IHob54dsZ/gOkyyztclJXpl6gsbldEae1Z7ojAC+oPHEOnxzK2h3
	JEwtgeSIWq2n6chsV+DXeSsi5LZLaKxdMIVd8xSne8hIOrcRtrjXbOqdNkUuKqDm+t3aHKahGks
	TqY4rtc2atnnzvTAqzVadkugOZXFb+Y/kJ5JW1iXWZ/6xe4hyKa1IEitQf8=
X-Received: by 2002:a05:7023:a53:b0:137:eac4:82b3 with SMTP id
 a92af1059eb24-139a5030901mr102913c88.17.1781828235521; Thu, 18 Jun 2026
 17:17:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 17:17:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 17:17:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <509f9a66-5ae9-4c05-bef1-ced89fd29bf0@kernel.org>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-10-2f0fae496530@google.com> <509f9a66-5ae9-4c05-bef1-ced89fd29bf0@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 17:17:14 -0700
X-Gm-Features: AVVi8CewB9OSB5ydvz-H83kPwJbWVO-CyG6kASZWbX7de4UUA5H3gpKgSOQyYIY
Message-ID: <CAEvNRgHM4a66Jx9++6iioQLpFY-KgPvjY5+bg_X97DfSjpXzRQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Vlastimil Babka (SUSE)" <vbabka@kernel.org> writes:

> On 5/23/26 02:17, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When converting memory to private in guest_memfd, it is necessary to ensure
>> that the pages are not currently being accessed by any other part of the
>> kernel or userspace to avoid any current user writing to guest private
>> memory.
>>
>> guest_memfd checks for unexpected refcounts to determine whether a page is
>> still in use. The only expected refcounts after unmapping the range
>> requested for conversion are those that are held by guest_memfd itself.
>
> Is it sufficient to only check, and not also freeze the refcount? (i.e.
> using folio_ref_freeze()), because without freezing, anything (e.g.
> compaction's pfn-based scanner) could do a speculative folio_try_get() and
> the checked refcount becomes stale.
>

I believe there's no issue here, since the main thing here is to check
for long-term pins on the folio. Perhaps David can help me verify. :)

> Might be ok if we know that no such speculative increment can result in
> actually touching the page contents, and the extra refcount and something
> inspecting the struct folio won't interfere with anything else. Then it
> could be just a comment mentioning why it's safe.
>

In this series guest_memfd doesn't change anything in folio metadata,
guest_memfd only updates the attributes tracked in the guest_memfd
inode, and updates the RMP table for SNP.

With the upcoming huge page support, guest_memfd needs to split/merge
the folio, which means updates to folio metadata. That will need a
closer look.

I haven't added the comment, mostly because it's a long weekend here and
I'd like to get Sashiko to run on it over the weekend. We should
definitely continue this discussion on v8!

> IIRC the compaction's scanning can result in a migration here so it's
> probably ok?
>

Migration isn't supported for guest_memfd yet, so I think that's ok.

>> Update the kvm_memory_attributes2 structure to include an error_offset
>> field. This allows KVM to report the exact offset where a conversion
>> failed to userspace. If the safety check fails, return -EAGAIN and copy
>> the error_offset back to userspace so that it can potentially retry the
>> operation or handle the failure gracefully.
>>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>
>> [...snip...]
>>
