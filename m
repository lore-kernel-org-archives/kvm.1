Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D03BD646
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031517; cv=none; b=Lw0fr08yp5aG9EwbsJeatdumy3j46970J4Q1/TsQAqd57I677DC36TMheShrdfAPeYww1TreOTOmtOL6N2psordbikjTyg51Qha5eovMEy1m27wOsNRjzWq47sNcP6Gq/+wFO9uFFLC6G8mgillvBiQpTrS8cOs7edGE49kHxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031517; c=relaxed/simple;
	bh=IXqkzhjdS3SL5Z8Nxy9tqGO8aU/DK+0un1yN9Rbn0xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtZWb7/NasBpcH0OpBD3uDmUWlmnRy5lfmtn6sdX04ZNZaN316BxOYbtjwQU+BE593619l08AjZlpbiT7ayYLCpPWzOAT/NGlA0HZEhjjsEU7cfGAxMCRN0ryvCwQMAUk0o9zn7bTf/aE9wvW7+GcxRV/JyAgR4JFT3Zw10+kT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5K9SVJ+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdQ9Lijl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5K9SVJ+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdQ9Lijl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777031515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPTaXwfQ0pC1v72UmTco14ZekCM1pyHL+NlaDMIoFPc=;
	b=L5K9SVJ+MGx3grQ5bxwJIC0VUiR+qE5/uPHJ9bjFyPOPra2YxU9gSUHm/FFYDlu8mHYAoD
	g9QKRlw9ol6ue70PW/93N6DVKUNBWLDnFWFA4Hr2gJ/ZEmR7X2A8SPD00mgPZtzpGhCYkq
	Jh5xqlWku5VAvnXOXGNto/twbp5pj8Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-B0Mf0QP9O8iP5XMJrPfahw-1; Fri, 24 Apr 2026 07:51:48 -0400
X-MC-Unique: B0Mf0QP9O8iP5XMJrPfahw-1
X-Mimecast-MFC-AGG-ID: B0Mf0QP9O8iP5XMJrPfahw_1777031507
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8eb04352924so1086112685a.1
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777031507; x=1777636307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPTaXwfQ0pC1v72UmTco14ZekCM1pyHL+NlaDMIoFPc=;
        b=KdQ9LijlYdyIePsA96+0tQrmQ/2KInYM+BppFx9SFezDqQyzH06iA1iHysYqS0fgeV
         BXBu4HfK5C5yhLx+xc/nvy1Rx96JCNzAursLSYlEtYnA/X5hIN+Anejxf/treDAJG+1L
         w2I/O7qyBPn2iIeDPjNRCGLlZWw7OflePeRzMeXjyG39Ua2rdln5FzRU02xDUd3f3i+V
         5mH55cBxZzAum7NWuy5IJGRxG4eC+z6H6Y+qO430IcgUrDL4Am/huCZG9i6UMxC1yq3I
         gpkT8SwvitwqTy3i8v++Udr4KLgg4Nm4OdWTWgzJY6F+/r2S7rCcmTvyz1z/MHkrqR0V
         MSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777031507; x=1777636307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPTaXwfQ0pC1v72UmTco14ZekCM1pyHL+NlaDMIoFPc=;
        b=hnOi6DrNaWX6ZKVduLTQIe4dJHtwR+fp2Lk1iUyGYkq2+TWs/8cy968xNiFugX3b5p
         24IH3KTQurI6lsghUJE01UttXQ0JfJFsUaUzsB1V6cs8/JOjtqHDmeBYths0ILKrLQ0A
         opvRf/Fx3gj7kq0fGfnBwSmpybMTQ9K0uoPtaUbTd2ZkU/e2QP8bbeMX2SV3bI03Ulox
         xPQIvv0JwJ9YJh+fdGOHzXTI76MHjyRuAYOfpVj5kGOch150atxv4t+sPFG2ItEPwbUh
         iSmB1GdA57fwEX7wSHKYLS4KrkskkJUVJw52Ufgn7aD47c1m9NnMtLPGEfzlSz63kuk3
         7vWg==
X-Forwarded-Encrypted: i=1; AFNElJ/fqpc6Rghbwt6zDbe2D6M+DAup7dAnFKIPjUXTd+CYc/AWMN9VdUgJak/MwoS3JOHIgmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iiQKZxh9ZN27PGUsBfLpWsxdycrj1i2JevxG/sFVLuYYq1iO
	X7SxU1Bm58LRc/Tnx5e+BmLsWS0YVZwkLvPhjlJdh/Ur+xExa6dYg3IGMIxd+e86lkI7PqE0Tur
	WX5Tb+sTxVvki1QSJnWNcN34nB/mrGWjirwGrgqDwJAvTfJQyHzCECg==
X-Gm-Gg: AeBDieudokQ72ndBGeWbBtAKkhWc19GYCyCDCgzhjk7kt1addoc5WG+DoBgqvwVTGIq
	xWBRjfdlpJNzds6QuML585ve3iwKSX8WI0Y8U7QYSoo/bOzc8ZZVk4HSipu9Tp/9SQ/6J16KAU8
	JH1RKa+js7n3EsfxZSu7ugNzHiKDbTIPNINB26WQHR8+M5rSmVL3tKWiFbHBaaD2rHt9SKCXrhR
	Fx0mAH/mDm0qFtJFXzbRenSxLt5Q2CS6sFOHzJUbAVZxwb6rLP6MuQaffmdof8DruF6YMyfRaL+
	h+Bq4YL5+FMCQh64IxhoTrs/dQQDqMEKNZ7aGbBxPb+n91ImkD92prD5Yk9qXsYKh7F/4Zd1AiR
	bzzhQJgiS0+jBG/ZRo3n8EDYIL4DgEPanvND52eJQgeRfo6eH5mGmuAqQOA==
X-Received: by 2002:a05:620a:5698:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-8eb605f8de1mr2383251885a.60.1777031507397;
        Fri, 24 Apr 2026 04:51:47 -0700 (PDT)
X-Received: by 2002:a05:620a:5698:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-8eb605f8de1mr2383245685a.60.1777031506710;
        Fri, 24 Apr 2026 04:51:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cce76sm1958573085a.14.2026.04.24.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:51:46 -0700 (PDT)
Date: Fri, 24 Apr 2026 07:51:44 -0400
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
Message-ID: <aetZUOINzfTXChLL@x1.local>
References: <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <aes7b17nG0cXrtEd@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aes7b17nG0cXrtEd@thinkstation>

On Fri, Apr 24, 2026 at 11:34:48AM +0100, Kiryl Shutsemau wrote:
> On Thu, Apr 23, 2026 at 02:57:34PM -0400, Peter Xu wrote:
> > On Thu, Apr 23, 2026 at 07:08:00PM +0100, Kiryl Shutsemau wrote:
> > > > - Whether read protection is required for an userspace swap system
> > > >   (e.g. did you get time to have a look at umap?)
> > > 
> > > I looked at it briefly, so I can miss details.
> > > 
> > > IIUC, in absence of read tracking it doesn't collect hotness information
> > > at all. The eviction is based on fault-in time: the oldest faulted-in
> > 
> > For example, let's imagine if we can have a per-mm idle page tracker, would
> > it work for you to collect hotness info?
> >
> > The other idea is, no matter whether we use MGLRU or legacy LRU, if we can
> > expose a better interface to share hotness info from kernel to userspace,
> > would it be possible?
> 
> I don't see how either fits our problem.
> 
> Both page_idle and the LRUs (legacy or MGLRU) track accesses on physical
> memory. We need visibility in the virtual address space domain.

Yes they are, but ACCESS bit isn't.  ACCESS bit is only about virtual
mapping or any similar mapping (like EPT's access bit).

What I described with per-mm tracking (either we call it per-mm idle page
tracking or using other interface) is about relying on ACCESS bit, not
pgtable changes using RWP.  IMHO It's more efficient and it will also
achieve your goal of VA tracking.

In your case (and also ours), if you're looking for VMs running virtual
machines, I think you need both pgtable's ACCESS bit and EPT-similar ACCESS
bit.  Here what's redundant is rmap, not ACCESS bit tracking.  When both
MMU and secondary MMU supports hardware access tracking, AFAIU it's faster
than RWP.

> 
> We don't care which physical page backs a given guest address at any
> moment. We want to know which piece of the user's dataset is cold, and
> the answer has to be indifferent to kernel actions underneath: the
> tracking must survive migration and swap-out. RWP gives us that — the

This is exactly what we hit...  that's the reason why I was trying to
propose a new API to read directly from swap (swap_access) or similar.

Btw, from another perspective, I believe we could also persist ACCESS bit
across migration or swap out.

For migration, see e.g. remove_migration_pte() has:

		if (!softleaf_is_migration_young(entry))
			pte = pte_mkold(pte);

For swap, it's different.  Normally, if an userapp would manage page
hotness, it will record the hotness within the userspace with whatever
algorithm it wants.  Then it will also survive host swap happening because
that hotness is per-VA.  It should be deduced from any hotness tracking
system it previously used to sample (and it still can be idle page
tracking, even if not efficient enough; when the VM page isn't mapped
anywhere else, rmap is pure overhead, it doesn't introduce false positives).

> uffd-wp bit is preserved across swap PTEs and migration entries, so the
> "this VA was declared cold" marker stays attached to the VA. A
> physical-side tracker loses its state the moment the folio is freed or
> replaced: a refaulted folio is a fresh object with no history.
> 
> Scaling goes the same way. Per-mm tracking of the form RWP does can
> scale with the working set. A physical-side tracker scales with all folios
> on the LRU/memcg, then needs an rmap walk per folio to map back to a
> VA — which is exactly the reason page_idle doesn't scale for this use
> case today.
> 
> There is also a cgroup-level confound: memcg hotness mixes guest memory
> with the VMM's own (worker threads, I/O buffers, vhost-user rings).
> VMA-scoped tracking is the natural unit regardless of the migration
> story.

This kind of further proved you're using shmem and you have separate
mappings.

Again, when with a per-mm idle page tracking these issue should all be
gone.  That per-mm idle page tracking needs to:

  - Ignore rmap so it's VA based
  - Still consider secondary MMUs, hence mmu young notifier needs to present
  - Work based on ACCESS bit (to leverage hardware tracking accelerations),
    rather than relying on a kernel fault to set the access mark, which
    should be more efficient.

The other thing is, could you please still answer why RWP is required for
swap impl in general?  It's not yet mentioned in the reply.

Personally I really feel like we're looking at very similar problems.  It
is a great news to me, because if you can convince me on the new api it
means our use case may likely also adopt the approach, vice versa.

It would be great to share the new interface no matter what it is, instead
of trying to push different ones.

Thanks,

-- 
Peter Xu

