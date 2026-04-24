Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4783CF663
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046147; cv=none; b=hoDx3ltiWDFXs2FJ9w/7MzFUy5DRp2DQjP8pWafBE6awlW/UVF7F42aTkhFg3sU3iPBRY1Hpj4/6lb+PewUpiFK2k41197/4vm1yzjYKNkLZGS9fEANjKinFztH+JNhcuRSr6fr1mGwklVdonEOfEYJQBtfH6d3MQGfMcuOOkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046147; c=relaxed/simple;
	bh=LZ1g410fGp9cQzldzvNuJ90pocHt3VissIO7Xj+d5+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDUpzCcdAwEvGzzgs/7U9GQctOoVPX9/3pi1xyNDg/eDdnhfRpf+kKY0FgByAT0J+RwSuaW2Zldsggmni1LzqxC5+9jvReATBabqRdIbMs8liW1VetIBGV38ktpUjidscCbaMre0wiYD/GQUCoTmHS2UO2Yu0j0TjBV6VN1+I1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyIPXdrC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUBEQbAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyIPXdrC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUBEQbAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777046145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLmU//rnAAA5yNF6Ee9JskKj79xD8INjyMeyu+N95bA=;
	b=eyIPXdrCyXs6HcPqszAVrsCQuSSmAK6cTv07bGV0QgxhdzuI/hgtZYKLwRAEXOL7VPKkF+
	AJsysCaJJat/HdfIICE4RcVvyasL3psA2hCb7AuI0IY0gWCcj6QiDvI5qJWhv8lDmNSlT6
	GhobYteBdQnYM/sg0BP4dZZ5VAWvQyM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6---CJ5srXN8eYG7COzDDTUg-1; Fri, 24 Apr 2026 11:55:42 -0400
X-MC-Unique: --CJ5srXN8eYG7COzDDTUg-1
X-Mimecast-MFC-AGG-ID: --CJ5srXN8eYG7COzDDTUg_1777046142
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a5f6110cadso187698376d6.3
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777046142; x=1777650942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLmU//rnAAA5yNF6Ee9JskKj79xD8INjyMeyu+N95bA=;
        b=EUBEQbAkbuNfos+bk1ZVgR3yyz+3sYi2/npQVvto4J3EOkqB1553h1EZ45IOMkFADF
         syoO3jVLZO1ij7mS0IVGuI8KRsg/XIcSMpXCRYzQqM6m3OsfMuQown9Tzoxw4IKZHl4t
         /6uFTJQaS1/BuRURFHtbaKMgwkWdmncOJigOEM9Z1MDM88ZxzJxYaagpCRSQNCuVoISk
         Myeq/4wAmlLFF5Eg4US2OYW5azIHcjhEvxuQ6ZBTO5KqDffjorfx9QYyeFtiP+0sMqLA
         L3sTNLVw4gbgkzLRhoi44pNZ9DghKLfwMxDnEkOSOwqcGP8MkbSDVfqkic7RcoU8oPoo
         /xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046142; x=1777650942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLmU//rnAAA5yNF6Ee9JskKj79xD8INjyMeyu+N95bA=;
        b=e6NilvZBkRyXxse2ShcjYhR9nKqhmk05jVG81UlhYdX5WUPS4vWOlmSSzLxeGFifDN
         nSDbl7poqm2/D4Ny+7PukUMVq4JD58Bor9ONjMBKIMgz3GfFxe0/LDYm2iS93G+G/dzS
         xXZlkm+hM66qsyswYKPJkVAwMpPMhhBy6M9+ZK/ebv+80p3Pqad7A77ZZZPs6zB40c2+
         S7IU7oefW2rCCHij5Zjvz7BC1Gv7dJZ8H3rcvc8EjEt5w0vzQjPUemedn3nBWtbvqTcq
         z31jH02KC8EAGXsX6WIRoqlokaa6W7oUlXras1gfwsHLXrTqZs6zdB7oXd50caZDlWhe
         lVNg==
X-Forwarded-Encrypted: i=1; AFNElJ/c2Wqm3j8WQ1Sk7UZgc2HDEogWKS0vaHZ4Ag+ftMV/PvFlUKsUWd0/2NmhyK5hrpHXqQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zzDP7je7ScR+brgLw8EvXyboXK8U1lIYaq4w22lfFd9U8lff
	hhX1XMcjA/tp97qI+XfGRUm5YPkeknbu8TIdSoNV5yeKWxx3E9bTEqrEaoAAZWXSvRVNo98iIiw
	MhXqny1HvG9NfpJbGg+PeQbqezwyV2jk607CgXBcZbGJJ9vf4mFToMw==
X-Gm-Gg: AeBDiet+huvpjD7ytVWP+UZbVikchnlNksATAByC1632PTXPMWVGwsnYpkndEHf7ERL
	rcoRu2y+HvAEOJjfQfQzWwb57PYLjot8Ldwgbi4zm/oFab6z1kfECiFwhw2swe1MNfjk8mrpQFJ
	N/ypa7eLzrPqBY3JVMN+b9UsCCxgyVEkCkDpGNIQEIlg4uNaxPRc55qhVD68IPXnWql4ygGZ9XG
	Pe+2Av9xcOlU4Nq1PbvOkvXnpvJlgdHp+hgwZYIGIckJJ95xd9I+tJLNN4B27ma1nkZHuABmno3
	c1Dm15BECO0gtyMaXYxOS5MuIVVELm2m2aIG5Y0JoAjSmqM3CfAy3uhM+dJu8muB0MfC6h5Jo+Z
	nodngNIoJyoN1YTZVopFFCNzqrLEiuzkZEeiAZ0OKIMZt05H6idONIGg5SQ==
X-Received: by 2002:ac8:5892:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-50e36b41242mr499700251cf.23.1777046141626;
        Fri, 24 Apr 2026 08:55:41 -0700 (PDT)
X-Received: by 2002:ac8:5892:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-50e36b41242mr499699791cf.23.1777046141002;
        Fri, 24 Apr 2026 08:55:41 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fafe9674csm148150631cf.3.2026.04.24.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:55:40 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:55:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aeuSe0PY-g10KNUF@x1.local>
References: <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <aes7b17nG0cXrtEd@thinkstation>
 <aetZUOINzfTXChLL@x1.local>
 <aetyhki-UD70dyRL@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aetyhki-UD70dyRL@thinkstation>

On Fri, Apr 24, 2026 at 02:49:58PM +0100, Kiryl Shutsemau wrote:
> On Fri, Apr 24, 2026 at 07:51:44AM -0400, Peter Xu wrote:
> > On Fri, Apr 24, 2026 at 11:34:48AM +0100, Kiryl Shutsemau wrote:
> > > Both page_idle and the LRUs (legacy or MGLRU) track accesses on physical
> > > memory. We need visibility in the virtual address space domain.
> > 
> > Yes they are, but ACCESS bit isn't.
> 
> A-bit is not a reliable signal for userspace working-set tracking
> because the kernel itself is a concurrent consumer. It is exactly why
> page_idle needs PG_young on top of the A-bit: PG_young is the "kernel

I assume you meant PG_idle.  I actually don't know whether PG_young is
still actively used anywhere in the current code base.

> ate the A-bit but the page was actually touched" escape hatch. And
> bringing PG_young into the picture puts us right back into physical-side
> tracking.
> 
> > For migration, see e.g. remove_migration_pte() has:
> > 
> > 		if (!softleaf_is_migration_young(entry))
> > 			pte = pte_mkold(pte);
> 
> remove_migration_pte() only propagates young-at-unmap. It does not
> cover the common case: A-bit cleared by reclaim before migration
> started. The concurrent-consumer problem is what breaks the signal,
> not the migration boundary.

IMHO it's a separate problem, and AFAIU it was well solved at least with
old LRUs with PG_idle. It's just slightly unfortunate it doesn't yet work
with MGLRU.  Also, when the extra bit is in folio->flags, it only works if
both the consumers are reporting per-folio, not per-mm.

I'm actually curious whether there're numbers or solid proof showing that
in your case the per-folio perf is too bad already to justify a new per-mm
API, like RWP.  It's because currently this proposal is still so far very
much about "let's implement a swap system".  It really doesn't yet have a
lot to prove on hotness tracking POV.

Not asking for a time-consuming test immediately, but IMHO these should
really be solid clues to first justify the overhead with current rmap in
production.

For us, we know the overhead in theory, but we never really measured how
much.

Even if so, I don't think it's unsolvable.

I want to explore if there's something that can still be generic and work
for per-mm tracking.  I believe if we can have some bit in the ptes, then
when mm reclaim code walks clearing ACCESS bit and sees some vma is being
tracked, then instead of setting PG_idle, it can just move the access bit
over to that special pte bit, and only to this vma this pte.  IIUC that'll
benefit from both worlds: fast HW-accelerated access bit, and no minor
faults.

Would something like that worth exploring?

-- 
Peter Xu

