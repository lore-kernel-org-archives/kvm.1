Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0173A6B82
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914049; cv=pass; b=iMeXjjtEQ5niyFeNnpIU0PsGrwUDfOXEOxE6kd7xMrzADpUGc/MwlukV6RW4s8os4LsJws4oeE8nXSeZGBS2HmD+b3hi6tNGEJqNkrNZogJOcqN6vMIE1MrTgx2XQgd0EkCTU0NxxE98sTg74MGqnapTPt1/HNdCV+Qae0gIWMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914049; c=relaxed/simple;
	bh=JdY+nYpi6ys5MsewwaA1hEzziJ9Shq6jtmhApeNh1s4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXFDp6yz5p9/VZfGQadwPOj/KptzzIEBSl3rO78TEM3nQzKFSPKRPwWBoA9vk4LOGkcsapj48by3oUMdKbTNvElhC3dxzvdkdW18+V6fe6goyDcDGkb901ynDVHEPOsAO8ivwadmQbfiG6VoDTMWTj6yjPTppb1idLxJR8ZAako=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UT6zIby+; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT6zIby+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1600d040e4so93066766b.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784914043; cv=none;
        d=google.com; s=arc-20260327;
        b=l8lVfobUQxeGj2C3dRNeuq9I/FCbYknemYyelF3uEsGavwRZz/W6EfldVWk3HNJcev
         CxuPYh02B0dutb/ltPcrmbFGZObFbH5ejZUHHnmXuXFbrjUCxAP/PF00kSxApWzz9hwL
         BFVFm7IjjIIPlU+bmm7EEfwBOClZIRFn6KtyTvxlhMJhIjfZRnKueX1gUVG5Ont8h6VD
         AfFixk5PYqhwwSvIE4fwRp0yeLCqKrmcT4xsTelR0Jf/4dVYwkKx/DhLstsR1ju7QOcK
         3PSSnkPSJjiabqLwqFNKEoTryCv4JYJuE8uq2adyRqJ9Gv6l8Yet2i4UxHboqCrqyOc2
         2g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=d5AhwjwYukV9mT3Xe6Qftz4sVEeZ8cM9ZQqM9u/iG/Q=;
        fh=7SN3e5ugeAz/7JT2NybV2giSTabVlfmXLVH9k1v4pJg=;
        b=hEUf40CtcfLu9itFKJrHx4FlfnU+2wflQVneghI6LCPOQJPPaYmDj278sihKwbOccs
         7yi1+ZrRslbZlDYuPEau54j2e4F4QlVTh5kchmBMw9EG8ZoKqW3w0oYObBqkMcVNrBP+
         /hyYFdmqp6AG28nvSirxbwkZ5cJtZndUlr8gQThrT8SkBmiqnohevBJaxuMR0FvsSUvB
         tgkibkx7sDtV+Hhi7IyOZakuBO4wST5OhR8TpNldTf6AF+6QDhoP4+mDmXI15uK/PFVu
         OvWBeHrWO9XcYvZJtMYq2JkeKKCSdLM5XfGw1g6eLGe13EkzW64JKkpLUWVFV4ARr4iw
         4xYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914043; x=1785518843; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5AhwjwYukV9mT3Xe6Qftz4sVEeZ8cM9ZQqM9u/iG/Q=;
        b=UT6zIby+vjl270QiNVns0GzcSacVd0D52J6/r6tRu+tYYlBEp5iPqhrBDFgRBzTWWG
         Wwaoa2QCB+TOCZQqAx9PTKQTff5tWXe3HFR6EsU3e/YsAsEWAa+Rcb4RZT4hwmj0GNkW
         kz5r4z8282302/D9A1WBeiqm2KhDsM+6FWKz97UrJ0vx/Cbu+8uL4katSpKTGEPboIhZ
         XlqFZtWxIkTCo5r/cupWhGTk3HkDVaWhr3avFQTEWzbn6eHN5wg4nuhDC3gbNI09Zh9u
         RlkiKarJSQsZVJeLyyHehY6EjYPxWkUX95pLLyB7U7Hdni3+nIT6VI0L+mkDEz4bWMHP
         /pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914043; x=1785518843;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5AhwjwYukV9mT3Xe6Qftz4sVEeZ8cM9ZQqM9u/iG/Q=;
        b=e0ir9+G4ZF/krC3LI4JcTiXsFeo6Ru6HZSNKROE6jq4rreEiAvJMVldu3jDEF0U9o3
         wuvJa5fTlccWklNfe55fxEGl7mxchmTqmR3yPUlhkafVQmKiXfz80FMn4LujODHBTbWN
         ozzdiFoUGhuYg0XluwJFtcTgF1I5sK5uKssL5Wf79rx75jx8zpeTqCw7f6UH1MdttwyA
         aR/MxxQtcXtmF6eu/iW1QtIUJzzvpRtQRZKLYaB8rj9d1fwLCjm0cmo0nBRikV361vTV
         ZbMD3+9HYhpZn5lssdLyBnMZ3frEAie1R3mrZ+9bcsaVLqJxXc1SnZYmUmdq297Ka4h1
         psXw==
X-Forwarded-Encrypted: i=1; AHgh+RofBhD6bCRNgfs4yQZFw6K7dIo9xwIjx8GXIJSpm+HpzG8XW3naxt7BwgnHxlLFzCfBbW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVxGUBNG3dOiJR5abm9RVQ3RP4XQSK3Lja/rE3cDJUb+I0sNw
	LSnO+VHi4+4pdnp/PF6xrzqiGpMWBuaBN2c2GKAbfgvT2aJRtHmPDJyxGSwIP3BBOI7YowyAVoI
	bJS2dtcl3d+zK1j1a5ZgQoJhUuLjBiRwJjAqOdWyEnw42Mu8pOYUBXSaz
X-Gm-Gg: AR+sD12t7kLJ7019XKhWB74zz20LBWh0Mj0inr5gu5t5EK1KxZWzvbv3yySSwSk3VO8
	4b5cSXW0ou1pexDDj65GHE6NtqY/IwCK9Q6BhUHXPuhOaxTN7r7RcOgBysYMjfnl7A+Xx+L5OMs
	hzNHHvy5l9LDDcCI3kKGnkSus4D/ZlJBZKxC1XGiRjKmHUp/KUz0WU+lrDJfVULVXXK0uVqxD+E
	xOCmRT6sUiAcz2HgSO+koXMnMmJx3+v9cHUb2X8X6XHCLKn04breRdtCbbp6K7uJWKqUIvMc+q1
	qZVW03rn3lA7Lj02QASyODfNU9dV8cng/GtSpfFnAHxvmGwL
X-Received: by 2002:a17:907:3e24:b0:c12:8ede:77 with SMTP id
 a640c23a62f3a-c1f139fc1fbmr68967566b.22.1784914042761; Fri, 24 Jul 2026
 10:27:22 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 10:27:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 10:27:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amN6VptoRxbZJE2y@google.com>
References: <tencent_7DA064CAC9B463EB9B651801011E2CE4230A@qq.com> <amN6VptoRxbZJE2y@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 10:27:20 -0700
X-Gm-Features: AUfX_myujysoy-q0RE8ijQGrElo0RZfIbuFKRTq9XjjZiWqF4W-rxv71cx9e6Jw
Message-ID: <CAEvNRgFTz7LETUpNeuR1sBXPFJ9N1e3ZYyPRg7R_HWARKmPcJA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Fix ABBA deadlock in error_remove_folio
To: Sean Christopherson <seanjc@google.com>, zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Lisa Wang <wyihan@google.com>, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jun 15, 2026, zhanghao wrote:
>> >From e7f25639c05eac51b4ac8add3dd3e3a76f6f7340 Mon Sep 17 00:00:00 2001
>> From: Hao Zhang <zhanghao1@kylinos.cn>
>> Date: Thu, 11 Jun 2026 15:27:27 +0800
>>
>> memory_failure() calls ->error_remove_folio() while holding the poisoned
>> folio lock.  guest_memfd's implementation takes mapping.invalidate_lock for
>> read before zapping KVM mappings.
>>
>> That lock ordering can deadlock against paths that hold
>> mapping.invalidate_lock for write and then try to lock the same folio, e.g.
>> guest_memfd punch-hole via truncate_inode_pages_range().
>>
>> The invalidate lock is needed for page-cache invalidation, but
>> ->error_remove_folio() only needs stable guest_memfd bindings while walking
>> them to zap KVM mappings.  Add a guest_memfd-private rwsem to protect
>> established gmem file entries and their bindings during invalidation and
>> removal, and use it in ->error_remove_folio() instead of
>> mapping.invalidate_lock.  Update bind, unbind, and release paths to take
>> the new lock when modifying bindings or removing a gmem file entry.
>>
>> Keep taking mapping.invalidate_lock before the bindings lock in paths that
>> need both locks, so writers cannot queue on the bindings lock while a
>> punch-hole operation is blocked on a folio lock.
>>
>> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
>> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
>> ---
>> Changes in v2:
>> - add a guest_memfd-private rwsem to protect the
>>   gmem_file_list and each gmem_file's bindings
>>
>> Link to v1: https://lore.kernel.org/all/tencent_4B051B84CDCC0D1964EC00337AA32E40DC07@qq.com/
>>
>>  virt/kvm/guest_memfd.c | 38 ++++++++++++++++++++++++++++++--------
>>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> Well shoot. I know I suggested this approach, but oof is it uglier than I was
> expecting.  I forgot that it's not just the bindings that need to be protected,
> the list of files also needs to be protected.
>
> And thinking about this more, I'm not convinced a separate bindings lock is
> sufficient, as a concurrent __kvm_gmem_populate() could establish mappings after
> kvm_gmem_error_folio() completes, if kvm_gmem_error_folio() runs between
> folio_unlock() and post_populate().
>
> So for a stopgap, I'm leaning very strongly towards going with the trylock
> approach you proposed in v1.

I think we can go with the stopgap for now, with guest_memfd
conversions, the filemap_invalidate_lock() is relied on for even more.

> Longer term (or maybe even as an immediate fix?),
> I think the ideal solution would be to rework truncate_error_folio() flows to
> allow .error_remove_folio() hooks to unlock the folio.
>

Actually it seems like having the folio locked is part of the contract
of removing it from the filemap. IIUC filemap lookup relies on folio
locking too. If that's correct, then it kind of makes sense that
the .error_remove_folio() callback, which is meant to let filesystems
take folios out of the filemap, is called under the folio lock. Or
perhaps that's an assumption that all filesystems use a filemap?

The folio lock also prevents concurrent faults from happening. At the
point of calling truncate_error_folio() the folio is supposed to already
be unmapped. If we drop the folio lock for a short while, then
truncation can't rely on the folio already being unmapped.

Since guest_memfd kind of monopolizes the folios it owns (on behalf of
the guest), and with the restructuring that will probably come with huge
page support, maybe memory failure for guest_memfd should be specially
handled?

>>
>> [...snip...]
>>
