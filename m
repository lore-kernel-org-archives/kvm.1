Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3F330D43
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342055; cv=none; b=ZmspBbfzcSqX8vHGUHx+XqHhwr1YFnRi4RKN4YmTwfO2SrHiCAJp+UPqDhnmdMiLIgV7RhS6doyPwXlVifTdUsSIsvcXYMMrX4x8F5LWF4inGBEDHIBjKHe+EIfHe64Fov5D41gTVRugQGc09O5nHpNjlTaNh99LaobEAIka85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342055; c=relaxed/simple;
	bh=o2KJMtYMykxG2p5wBZaW9rrM8bHQ6s9Eh8atWvH/Hvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pg6om3B44JAbwitTyrFsV1Zzz/nZZBqIiwzF6KuVPtLuSnjNJaUlDoVewwBBdM8Avnnple0MkDwdlKfiDRyqJKaqgoU61129ur6Ql+OEfPuXtgHMEgXAcO2kBpzv8hPLss2WPKMmiToJe3xArOrdTca6XXqFiAq/fqPfS+L7FTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03FDQh7a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03FDQh7a"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3598733bec0so8632800a91.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773342046; x=1773946846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azrlEIUFQPXd0knJ73Otkr8SjGPNupTIDsw2LzFABvI=;
        b=03FDQh7amxeftR9jGM7TA7Q64tYykf6nqIjU7U3VYff6TL37L1AaZFCKXLsNK/pwNw
         7Ro9UQIrmD/a0KdYQ/s98Ci5NxotidKn1/2FQcDbV4EpmPOxBXvY/dENf86huEeayI+u
         SLdPx8x0pcTpxuISFzpgnZAC+bUa47UibyMOUcjVF5r1XmRMPq+MQIOyANVW9CFtsYU/
         juMkwoqjaQTE4lxA7sCjOEDSIUdOpgoOQpeyG1aqt/UFqavCEkdwaTr4Um7msU511r9t
         1DV1ltj8hfLCHvrb0NSObi1Wdz5sVZC5EwAG42dDpPqGIXezZamEQCUtjVVoiXcixl4q
         WSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342046; x=1773946846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azrlEIUFQPXd0knJ73Otkr8SjGPNupTIDsw2LzFABvI=;
        b=hoRW3CvNpRtuROnx9dLwjluv0TI2sQnc+1hOy97+wlWePS4Z5jNYVfgP4VFehXqNDL
         n3XE3v1sIYV+kvbHwNyTZd2Ue89eWVjcmC7qKfEZIoeug66gtbgdl7Necw3Uohejx/rx
         cEMduv7gF2LdXgZoJuX4qRTL0CEtJwQtnkifTlM1C+EuhFzUr1098xfISqsRJIIuYzOu
         dPL8d07iDZMzlL4Ubc1J2UjhfClrM5ASIhVJs7rLuZ7WFufXdVIMI+DJUGEiEYSCFlWF
         EBJ9OLKRBKwUgffwpfuODg4iHQBYy9h6bpWAYauvbkKL8JK+K44xcxu163KPTxGHSQuI
         Gg4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvdRFkB5y/woNoNqQxR93jJ37St71ulvlmgEqZ2JNCuLgHthYmX8Pkcsc3c51J8gKGJyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlHAkVuo1sjV6oAFbE5LLmxltMrM9CbacR6mwUDDJI4CHCI1F
	m5kHk7styccZGMO1NF8ok6cGNnEh9nsv8elVGtQQ2AnrP4PsUNlx1K+4rdvRdMTRi+QirF7eT02
	O8xCpFw==
X-Received: from pjbsy11.prod.google.com ([2002:a17:90b:2d0b:b0:359:8f94:bc6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b10:b0:356:3ba2:122c
 with SMTP id 98e67ed59e1d1-35a21efa8cdmr623149a91.9.1773342045999; Thu, 12
 Mar 2026 12:00:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:00:44 -0700
In-Reply-To: <CAEvNRgH1RAV0rcaUx717JcHryB6=teXYoGtEzZwGwmy3MWwOcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
 <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com> <aa9uiQ_KBcX7X0My@google.com>
 <CAEvNRgH1RAV0rcaUx717JcHryB6=teXYoGtEzZwGwmy3MWwOcw@mail.gmail.com>
Message-ID: <abMNXBQUpFD8W1iM@google.com>
Subject: Re: [PATCH RFC v3 2/4] KVM: guest_memfd: Set release always on
 guest_memfd mappings
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	rientjes@google.com, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Lisa Wang <wyihan@google.com>, Nikita Kalyazin <kalyazin@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > On Mon, Mar 09, 2026, Ackerley Tng wrote:
> > But even if that's somehow the "right" behavior, we're doing it purely by
> > accident.
> >
> > As for this patch, if we fix that bug by returning 0, then filemap_release_folio()
> > is definitely reachable by at least one flow, so I think guest_memfd also needs
> > to implement release_folio()?
> >
> 
> Is posix_fadvise() the one flow you're talking about?

No, I'm saying if we fix the memory error case, then filemap_release_folio()
likely becomes reachable.  Though there may be other cases.

> It indeed calls filemap_release_folio() through mapping_try_invalidate()
> -> mapping_evict_folio() -> filemap_release_folio().
> 
> >From Documentation/filesystems/locking.rst:
> 
>   ->release_folio() is called when the MM wants to make a change to the
>   folio that would invalidate the filesystem's private data.  For example,
>   it may be about to be removed from the address_space or split.  The folio
>   is locked and not under writeback.  It may be dirty.  The gfp parameter
>   is not usually used for allocation, but rather to indicate what the
>   filesystem may do to attempt to free the private data.  The filesystem may
>   return false to indicate that the folio's private data cannot be freed.
>   If it returns true, it should have already removed the private data from
>   the folio.  If a filesystem does not provide a ->release_folio method,
>   the pagecache will assume that private data is buffer_heads and call
>   try_to_free_buffers().
> 
> I could implement .release_folio().
> 
> Returning false seems like the easier solution, and is kind of in line
> with the documentation above. A guest_memfd folio does not have private
> data, so without private data, the private data cannot be freed.

Eh, not really, If there's no private data, then freeing it always succeeds.

> (Took me a while to notice that having private data is not the same
> as having something in folio->private, so this doesn't change even after
> the direct map removal series lands.)
> 
> Returning false is going to break shrink_folio_list(), but that probably
> won't affect guest_memfd for now.

Definitely not a problem, I'm very against putting guest_memfd pages on the
kernel's standard LRU lists.

> Returning false also breaks page_cache_pipe_buf_try_steal(). Does anyone
> more familiar with splicing know if that could affect guest_memfd?

AFAICT, also not a problem until KVM supports .splice_read().

> Returning true could also work, to indicate that the folio's private
> data has been "removed". I'd also have to do inode_sub_bytes() in
> .release_folio() then, since in mapping_evict_folio(), remove_mapping()
> doesn't call .invalidate_folio().
> 
> Then we will have to separately ensure that in truncate_error_folio(),
> guest_memfd doesn't double-deduct the folio's size from the inode. This
> should be semantically correct though, since IIUC .invalidate_folio() is
> when a folio is removed (clean or dirty), but .release_folio() is only
> for clean folios. If .error_remove_folio() returns MF_DELAYED, the
> truncation didn't happen and so there should be no call to
> .release_folio().

Before we dive deep into solutions, what's the motivation for making fstat() work?
As I asked in the cover letter:

  P.S. In future versions, please explain _why_ you want to add fstat() support,
  i.e. why you want to account allocated bytes/folios.  For folks like me that do
  very little userspace programming, and even less filesystems work, fstat() not
  working means nothing.  Even if the answer is "because literally every other FS
  in Linux works".
