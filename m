Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465335F61E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500405; cv=pass; b=M7wx+rm9Hkc6lka6GZcLUBWDNONVjr7n0xUYQFkWNTzuJ8ArGcM6LaVMxWUuhci9XvK3S3gOp5ZJjG74QWitpxgf+cxbWDyMJFFbxt49Jn4WTM4POYyZGRcEbq80ztX/BHQsjB2Iir6xGBg/u0gsVELe2g29qubS0BVWqTKDJRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500405; c=relaxed/simple;
	bh=2MkVu9hAjUPt6vDEn5B8wra1y0BjXn05vKU6y3W7ZOk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqGTsWXr7PwgD1Y0WhjCgOeBRuthK9ATYrKLfMU41x9DogsFCx37+4OFx0GrvdQMnV+A0NrBp3y81ZTAiD4KBSEE5D1A7DZ8UOLuVYBsLKlNHIqxroz88QCY8RvkKIFKvNbqU5qNql0ywZGrOmIF7IczLJxtjZ9qVShI1YGCMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frqk1CCb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUIwxxkw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frqk1CCb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUIwxxkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785500402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5D9+gVdQYRPzbfLg/FIhYF67kDFn9zSZhHkHh+1bXFI=;
	b=frqk1CCbYAaTqUmzRSwjzZnql1ZiyGxfZTk49BuSLrtspHJtHgWzahO+eIZ5mfj0eOebDS
	cxa3CroSsWrJXt+FVsZD2pSmOG5Ev7Np6mcw5ucSxekbqMPAtftyNc36xgRjheaQ2XmTq9
	4nuZ6y02TXt3XACo+Rv0eyjeQ7CIDb8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-44XaqfxwMaKo_5jghg5UgQ-1; Fri, 31 Jul 2026 08:20:00 -0400
X-MC-Unique: 44XaqfxwMaKo_5jghg5UgQ-1
X-Mimecast-MFC-AGG-ID: 44XaqfxwMaKo_5jghg5UgQ_1785500400
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so10683746d6.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785500400; cv=none;
        d=google.com; s=arc-20260327;
        b=WImhOytxHpkOyCf5sxJNbV9WOGx5TkGxG4raES/m8I3FSeEp9i+wTmwBnwyzYFWsCw
         V5k+SOEeHOMipyc2ji15tXfENt5iWnii+TfHTn2SV1eMedUkKYWhYZNdLy15CdwILQAf
         m2OLeLwgMaf5fBCVWs/8oQDokEc4EtmUKvlgu7EtK4VqkvGG/LZbn8Ie17gimSwLWxH0
         nCtLowrzDN+3qDntHLHkOzZ+tu9KPJYJ5TifljpMIz8GGjuga03jP0T4BZW8x7hFExQz
         O2h+5CBJl2MWtIDJ21cVLdUu97uxb0vZeY9vsgT/gzfEbiDXZ/p7/qnOvsZyFo1jDUOM
         u+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5D9+gVdQYRPzbfLg/FIhYF67kDFn9zSZhHkHh+1bXFI=;
        fh=1PWwIdajsYQL6SecyMAnSXTvIc8xHSelwwcBRg5A4T8=;
        b=MLZtH8i/d7h3JTYPD4j12/bGZKl4a6QU9cjtP4R+i+wFu7w9ZJK9PLH6By+NSFWlsR
         WVGzDCmLYPYskhrvaawrWa9/SMTIguiPQaUn72A+pwwYlnn9cn2Lj0g2kUjY6H2hUt9K
         /6SQQ28r81lzPf/sVSNGdiTq5oY6d6AqVwQg5o8gEOCF5X8D6DLfSs8f9r0moVXuAmLH
         Db1F0xZRtAoGvXnZ1vuqO2Sn60ot+ZD8RyrdHeLBajI1kmtrmX2q6a8iq4RAOF13KKlE
         XcYeIHV6T5YnOvSzZk6ZMZU5Ly+2HclKbKO6cazlpoC9i8yNb627rYNWOsyT8vaF7jxN
         M08g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785500400; x=1786105200; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5D9+gVdQYRPzbfLg/FIhYF67kDFn9zSZhHkHh+1bXFI=;
        b=KUIwxxkwiK5q3tIWX9lrdgSB0KrLvxJCsV1XR5QTRPAlDHwPsVO0F5e3I7pvHAQ89m
         mIxK8OpL3OZ9HekN8UTshoaBoGND2BxQTIwBunDScoqRPBFmQ00Ie6YtjaFkwvKzAsRm
         SX+NdSkHqqGLYZGplLEcX3wIWPqgJ6kLvPTCHagoQpDlZwyKEcXMW0rEj/SjyAQ2UTpt
         aDMBSNp5bSgzomE4eZwX4Fva6ZHu5fvvCoZSkxk6qhBfoQD2tZPEgAVIqoAAURvPqk92
         JlCdQMBZQnsFQWsJrR8ta24vqMPkDujJgJq5QrooZLwY+FCDNN3HuOSe8ZBttRxbUj8u
         4VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500400; x=1786105200;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5D9+gVdQYRPzbfLg/FIhYF67kDFn9zSZhHkHh+1bXFI=;
        b=oKhj0s2bgyUCSjB+sLIbmYElyeGGJZIYMYU5I7b/noK/Ods85ZjVwsHQ/AC1mZA5gl
         VT2w15zwa9ibHF6FQMMHETJKdvE2qXpmZXEm0r2ZN93hohvdqNEFb6O6tnEA3rCcc5iF
         CKPYi36pPevx3adof+85fBDHtemKH647E3Lj//s2Pm/JZaKq003lBV9kB571PXW40w3W
         W4jPrKzvp9jLjTx2TcZiCJ24G2lMxj90ruhEzrnQxsbWz68U67zsVl93myLnybjvq0ho
         /Jfwj4GFqJXcSwJx7fxe3rEBeU1VM3YxxIGPeevdP+UORkHh0ifHywKv6/OvUF+bB/WQ
         +diA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3+GIQYF67gnPV6BOpdhYMNX9l3VaB3ULahpYgG1MHjimDTPs2y9/+89EZFL3Rij2qTZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC36htD0btZJxuUUPKtTGQOiOKIg/a+IE8aUW5tdWCwIk/Tim
	cY+NsaUdEU7EutfWNQKW8IHod8EZQzlPKu05Lxy+kdAEZm9us1FitebytHgYB1zGIViAA27vvz+
	bDkBsw0cAwm4/LsmdE9yGZpBiImBBYlfJQzP/uB05pJPt0vxgMf4uda4NP3+ooIqz0G3EN0toux
	mrv9EZn/uJZCkE78Wb9pX4gHmHAFGj
X-Gm-Gg: AR+sD13cNe7njP5qyxc3qZfomu+AvqWwsGIsCvBMhyAdCn83uClpg4jAVZG59Wfprfm
	TTPtS9qwgOR5AeF/d0GzwwF7hHLONiY1RJwP0UsRg3QtwC3cdk3xUgLSTDcfKpJjrJY5yGMBsJy
	RknGUn4ggaVS4H9089bBzoQhvGHR3ja5hM39z9YIh2IGxv9hNo/yCT8GE=
X-Received: by 2002:a05:6214:3d9a:b0:8dc:ad48:70a7 with SMTP id 6a1803df08f44-908421d257cmr32733246d6.26.1785500399696;
        Fri, 31 Jul 2026 05:19:59 -0700 (PDT)
X-Received: by 2002:a05:6214:3d9a:b0:8dc:ad48:70a7 with SMTP id
 6a1803df08f44-908421d257cmr32732206d6.26.1785500398586; Fri, 31 Jul 2026
 05:19:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 07:19:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 07:19:57 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <amuKVfib5kela8AD@google.com>
References: <20260729072044.25796-1-slp@redhat.com> <amuKVfib5kela8AD@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 31 Jul 2026 07:19:57 -0500
X-Gm-Features: AUfX_mwO1zLTRujieOu0N6jIbiddaK-q1uUqJA1ua8ugYzqIInNy7PLBCVjm2lE
Message-ID: <CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jul 29, 2026, Sergio Lopez wrote:
>> After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
>> mmap") was merged, a guest write to an unpopulated PTE from a mapping
>> backed by a DRM GEM BO triggers a VM exit with EFAULT, with
>> hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.
>>
>> This happens because that commit implements pfn_mkwrite for
>> drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
>> returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
>> entry to be installed as read-only. This is done on purpose so the
>> fault handler gets notified when the entry is going to be written.
>>
>> In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
>> fault handler but, as seen above, this one might install a read-only PTE
>> even with FAULT_FLAG_WRITE present in fault_flags. The check at the end
>> of hva_to_pfn_remapped notices that the entry is not writable despite
>> this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.
>>
>> To address this issue, have hva_to_pfn_remapped issue a second
>> fixup_user_fault call when needed for write-upgrading the PTE.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>
> NAK, this doesn't belong in KVM.  Expecting callers of fixup_user_fault() to
> retry a FAULT_FLAG_WRITE fault on *success* is absurd.  Either manually do the
> retry in fixup_user_fault(), or return VM_FAULT_RETRY so that KVM will naturally
> retry.  I assume the latter is the correct approach.

The issue goes beyond fixup_user_fault() behavior. If we're faulting on
a page which already has a ready-only PTE installed,
follow_pfnmap_start() returns success, fixup_user_fault isn't called at
all, and we're still hitting the "(write_fault && !args.writable)"
condition, setting p_pfn to KVM_PFN_ERR_RO_FAULT.

Without this change, KVM can't deal with VM_PFNMAP vmas with read-only
PTEs installed.

Thanks,
Sergio.

