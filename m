Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2342A140
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505022; cv=pass; b=L3VIphCBkt9kTj5lPfsN40LhMf0ndkh3YAPmcwjvVfhBB6Mgkp93NokvKUUfIUA94sFxT3bHuyKv9GA75A+c98FJaTMxA5e1Jp0ji+HNnGJEJOJjdzFbIPcrqgpImYVJ4lhmbTsQ7HrurFTGYXgG1YvUfXUBEZmK+2cezr1+Hnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505022; c=relaxed/simple;
	bh=O8lgQZv0EhREtn+ZGoyq/yhwqzh62FdMyJDRuyqhZbw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hnh3d1dL5Jk8owKp2EXWNZG08iBILcAuo1rB8IvehIxNS2/Juh+9Aj9/NlzhSs/3hyBdFf/XrKLRaRqmMNNA4zClfbYJyB1WodDfusWw7PLcgy4R5irjtilAOuj0Tzr1bjtxTYOIt9mRFxnqXOyKSg7P9sxds0rXPIuRSLcYquw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hju8ADbw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oqlj/bEU; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hju8ADbw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oqlj/bEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785505015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn8fqy4vdaHN1KhMsDJh81YTcfcAIDlvczsTaPLPHXs=;
	b=Hju8ADbwUGUWHN43sGhmE/3QAlbbnDfudUfdQa04pQTNEO65HV+s3TTor9KxcCKhy9Kcen
	5y0+JeTiJbJsImBnsp6JaFnWQ8M7yc67LRjpcWg9tpkKfWpJQ5/sDOht98TFlVamxpR4SP
	fSXVoF8AX6SUgjwsSjAVbDvhvH6W02k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-xqsAaoxhM1aCHNMMOQmqRg-1; Fri, 31 Jul 2026 09:36:52 -0400
X-MC-Unique: xqsAaoxhM1aCHNMMOQmqRg-1
X-Mimecast-MFC-AGG-ID: xqsAaoxhM1aCHNMMOQmqRg_1785505012
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so13324856d6.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 06:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785505012; cv=none;
        d=google.com; s=arc-20260327;
        b=gLL53N28+55kbEGGXlVgsh8Va0Hpq+KhmsT0Ox7YANQnG28ROMX0UsBTPfv+ZiMnit
         FzFlTbjdpK9P3BWx2NvxNQHE8P+PPGvfqRDoslOZjBqnfx5yijBGnjL2nddpQ1oZ19WT
         BVphxuBygx7uCDh/034sFACtPJOf9SQufoz9XT+Dvt2WAQUkqV04Y9O/EDY/zhnthICW
         dmfjNeoyukL+gJsOicRIVyplYkAjsnkTxIxbSsdNFsO1YwRzR3B3Yv7+KTLhCF/9PfHq
         G4Cquk4M6xYxHjHx/FgdUa2mRU30sRpunfRjfVG028hpI6u+CI515f4I1jfQADw+aqpA
         8gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=tn8fqy4vdaHN1KhMsDJh81YTcfcAIDlvczsTaPLPHXs=;
        fh=rMplUhOyHHsJZzPJC6Hv8XB1IsuJe6/xvf3lWE6JyGI=;
        b=hov1Ts3n06c8fiVB173/Mb52vz7peApk7TTBT44LWd1NihCU8HW/jHveEfhjBgVNgN
         JapLjGcLUeY+uOqVF9BsEUHQhDY/7lSrAUNIzRqpv65TG+Xjrd7gSrAdBeLucUuDXWWq
         TYzC0U+68qnwQPfgvhEM2Nk9iSdeiDoLv4+QeGwBqEXTLeiD+sMwrzot9vrLDFD/tm56
         Mr/i6tUr+nMcULtPkIkt8PC/jpbTVruB3gUxvaz5oqxSN+Ch9WW9NKMrmtYHKym8vqN2
         UuirIWsmxBctzLvx39kJzxQbRUXmtDFCmblSU1mNLoM5qLcZtE+lEwyhL6H/qrarvmfz
         KRag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785505012; x=1786109812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tn8fqy4vdaHN1KhMsDJh81YTcfcAIDlvczsTaPLPHXs=;
        b=oqlj/bEUjngEDvM3sIJwSaPNzhN1vz/l3NkjM0XtVMAXtyUzQ8bYS2cwPATMsRECw3
         zSAmNI4X9ukUWI2RO+lr4bpDcRHeQ8ZcufbEhkhsd4LYuVM6t4ef3JZAWX18D7x8g7DP
         DH6Ys0Y1ZllMYAFzPLFXWH/fWOvkdx0Iqa/MenZl20kV4CC2Qp7TFt4COzZ2qePDB+e5
         KrEl63pziLhWPj2zh8EXrtJaZQB2TvXfexN1xarkCdsPFcq8OYt5bvYJ1v472ml2RilP
         s9DIztklIPtMH+LYZuQoA1IvLzpiTHJgTLpBp0DWGT67HUt+PCSdqB3bZi196yFCASTn
         BFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785505012; x=1786109812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tn8fqy4vdaHN1KhMsDJh81YTcfcAIDlvczsTaPLPHXs=;
        b=neRxBCPS6A68FMrAClaIIk/EckVYlRAGcsc1CNoqegfeYBxmJO+s+nqfXMLgL40oR9
         G/cfcFeZ0H7p437G85TogM3UQn/+6iKqwUVI2oXcOoOT0dyuAnnxu7rYUCI2KtCfi4FO
         Z+J4eImRiHFY6GIagYKZQmu/M59C8py8OEESXiusv4tUGf2YAC29PI/d/2M06Upbu580
         jZ6X9FdYLqLVNwGgUe9iGG5fhMh4FdTFVCy1YBPczgQZSdJJMD5jIMnyK/sH4+Zx+ikM
         KG+ApyRPUaq6KYPKg1Gmcpq4II1EJP9kJe5cMpsTz4TBLqvmnSspyRgA8hskCgheDvBl
         Mr0g==
X-Forwarded-Encrypted: i=1; AHgh+Rra0bfzC9blDLuIJuRkN+QJlPAqgfsyYzhq0HsX6twttXmbZ0UiYsqEDFnXaAOGjE1TmGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDc516IsLX/6YnYw11QxrAHlEN3PrNqdcvYQxXZi1zFfEqROzL
	QgxYP+u27za88qT2CggSd4/eFsVrDTdcaROFjbVcOW+T63yl4HTeYBlSBtdEZuXB0Ek6/l3tJ/J
	1eH/Oj1zsAnSGLjA8xhquwf6iID5Uyzcqo8Z8XGkswCf0b5K4u+Ty9Fxf0ebmo4azYtmbs7Qejb
	kq3dVqib3MVHLTY9BAcoC7+mW02kv1
X-Gm-Gg: AR+sD11ADeAAjR/9yoaPnswDZh5/wdhkN4ilYjlHP7hg5kGv3RhI/41cPj1MEUs/ymh
	MN7H1OId/770jSBALpqyHNF5GiWmnBxM9hxC/etVmSEDVRtTkv1qEhkJAeaJnaYAXqcTt92sSSL
	Z0yc1E6avXPa7CrjulPRHJ+fq1TC8hcePTiJWX2I7PcER7c7RkRuGM8HE=
X-Received: by 2002:a05:6214:2dc9:b0:907:aec2:6cdd with SMTP id 6a1803df08f44-908421a5243mr42797456d6.6.1785505011624;
        Fri, 31 Jul 2026 06:36:51 -0700 (PDT)
X-Received: by 2002:a05:6214:2dc9:b0:907:aec2:6cdd with SMTP id
 6a1803df08f44-908421a5243mr42796706d6.6.1785505011043; Fri, 31 Jul 2026
 06:36:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:36:50 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:36:50 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <amybygGUiPlbiDE2@google.com>
References: <20260729072044.25796-1-slp@redhat.com> <amuKVfib5kela8AD@google.com>
 <CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com> <amybygGUiPlbiDE2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 31 Jul 2026 08:36:50 -0500
X-Gm-Features: AUfX_mxTWTEF0GHeD15trpz_anlVnc6uPQ4VfJ9QhdmGqGZkQ_Y4Wx93RG5tJ7A
Message-ID: <CAAiTLFUFDa5X+Gg6WKeovcs5h3D9kDRaU1MYFRKdspkJSpiusA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 31, 2026, Sergio Lopez Pascual wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Wed, Jul 29, 2026, Sergio Lopez wrote:
>> >> After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
>> >> mmap") was merged, a guest write to an unpopulated PTE from a mapping
>> >> backed by a DRM GEM BO triggers a VM exit with EFAULT, with
>> >> hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.
>> >>
>> >> This happens because that commit implements pfn_mkwrite for
>> >> drm_gem_shmem_vm_ops. With that function present, vma_wants_writenoti=
fy
>> >> returns true in vma_set_page_prot, clearing VM_SHARED and leading to =
the
>> >> entry to be installed as read-only. This is done on purpose so the
>> >> fault handler gets notified when the entry is going to be written.
>> >>
>> >> In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
>> >> fault handler but, as seen above, this one might install a read-only =
PTE
>> >> even with FAULT_FLAG_WRITE present in fault_flags. The check at the e=
nd
>> >> of hva_to_pfn_remapped notices that the entry is not writable despite
>> >> this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.
>> >>
>> >> To address this issue, have hva_to_pfn_remapped issue a second
>> >> fixup_user_fault call when needed for write-upgrading the PTE.
>> >>
>> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> >> ---
>> >
>> > NAK, this doesn't belong in KVM.  Expecting callers of fixup_user_faul=
t() to
>> > retry a FAULT_FLAG_WRITE fault on *success* is absurd.  Either manuall=
y do the
>> > retry in fixup_user_fault(), or return VM_FAULT_RETRY so that KVM will=
 naturally
>> > retry.  I assume the latter is the correct approach.
>>
>> The issue goes beyond fixup_user_fault() behavior. If we're faulting on
>> a page which already has a ready-only PTE installed,
>> follow_pfnmap_start() returns success, fixup_user_fault isn't called at
>> all, and we're still hitting the "(write_fault && !args.writable)"
>> condition, setting p_pfn to KVM_PFN_ERR_RO_FAULT.
>>
>> Without this change, KVM can't deal with VM_PFNMAP vmas with read-only
>> PTEs installed.
>
> IMO, that's a bug in the APIs.  If a normal #PF handler looked at a write=
 fault
> and decided a read-only mapping sufficed, that would be a bug.  I don't s=
ee why
> this is any different.

In the scenario I've described above, were a read-only PTE has been
installed on a fault generated by a read access, and a second fault is
generated later when writting to the page, we aren't invoking any #PF
handler. The call graph looks (roughly) like this:

          kvm_handle_guest_abort()
            =E2=94=9C=E2=94=80 gfn_to_memslot() =E2=86=92 gfn_to_hva()
            =E2=94=94=E2=94=80 user_mem_abort()
                =E2=94=94=E2=94=80 kvm_s2_fault_pin_pfn()
                    =E2=94=94=E2=94=80 __kvm_faultin_pfn()
                        =E2=94=94=E2=94=80 hva_to_pfn()
                            =E2=94=9C=E2=94=80 hva_to_pfn_fast()
                            =E2=94=9C=E2=94=80 hva_to_pfn_slow()
                            =E2=94=94=E2=94=80 hva_to_pfn_remapped()

GUP rejects VM_PFNMAP vmas, and hva_to_pfn_remapped() is not calling
fixup_user_fault() because follow_pfnmap_start() finds the PTE. So no
fault handler is involved in this path.

Thanks,
Sergio.

