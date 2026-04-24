Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA493D34A1
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035612; cv=none; b=l7ZMGauHQXdduxMQeErztWaTnJfD5epVw+eKtPXADWT2tF0pYeSCOksHmOUnnPfkUytG/UIt8E0J9w2p8HDzq5xnQZZ5opLO1RhY8RxCmwGmlWpUypAbJevq/HCR+Iz3aAP6K7d9dU6FJGKEMRbBMIOu3W0dgpEQt5An4DTJBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035612; c=relaxed/simple;
	bh=mNaMVJ45d/XkfX9LnPfVcMylCsWv/6zRlhpVNM52jUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIWnuXW+ife1DVCcbSXPGQEFHwTNsOudemYVAczwgUdvryQDhMe4TdKku7q7XoC8S1lk/s+mrSbSurliVUFVdqDuSwShbFTBcaaOg0hrHICnPA4ZLzIiPdJXRIpESbzpuGvU21dyKWaJPsQX3kT2uWLZxVqk5dxzzOB3QGZoNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFTV7/OR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbSQaYvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFTV7/OR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbSQaYvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777035602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuxHqotWAXKQn8tfukv8Lxf0MCnzWeGdcx1e3ImXNv4=;
	b=fFTV7/OR0y9acSovjvOioYx8UWjqexln4e+IcnaaPu2GDGFVpatcZaqVGWJLuAa00un+Cx
	s/Gp4c4b6QqFYLzrPwK2HfkpKfCejVleXCSJPLcN4HH5G8Te+51ncYV0A3egHdt4+ieoux
	6sh3LcfKAdW0P8g1GBtpS7sZMpAAXhY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-xS8wbEqGPEWAd6GByxLtEg-1; Fri, 24 Apr 2026 09:00:01 -0400
X-MC-Unique: xS8wbEqGPEWAd6GByxLtEg-1
X-Mimecast-MFC-AGG-ID: xS8wbEqGPEWAd6GByxLtEg_1777035600
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb55e55362so1106785585a.2
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777035600; x=1777640400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CuxHqotWAXKQn8tfukv8Lxf0MCnzWeGdcx1e3ImXNv4=;
        b=KbSQaYvK0+FHgvQDrgrmhoPEgDWwUnb5mawymHIH/7+J0/T1I7pa4LdpgEi/5aBxo7
         /xo05V/MLnkBDbH4AyEbM9WuEpoF8NhfCIENq+KMsJrplaAZikmVzZHVJqSi6lZJzDeN
         IPqaKjLsSW7o/Rz4fhQWNVkVeNNomvsKunceOnC/RbKhxLCmFsu3h7/IQnlvR+W+NA5g
         hKFnBSVbVEanfm6lxLjEg8FKGcZ+l57+n39rB8KjrbEEqLJmh5ZRYEMkQqkjg6LehPlz
         us4t6G3xuelpWXedBb76zRp37UaBmrm1w9OTFhX1IFMw3bPdLLC7+m2w2vgxmiXS5hti
         WjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035600; x=1777640400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuxHqotWAXKQn8tfukv8Lxf0MCnzWeGdcx1e3ImXNv4=;
        b=D5+8uUwuDhxgwVNgYE3q94YtnWvpFyClVxwMnIv8yPQ7Mx+L2AIV73PyJken+MJarh
         fuyN/4QaTNtsg/SgN5nE6DlYjzsMfAgCVBMsqxJgP5j4cnQPyv8OVXe/pUUFyPT/RP/f
         aVtr2fl5Ykj3NhqMgdfquFgDp2KD3ZLv5CKCHUYV3P6L99S6mlrE4/fukmuG2kn6AGB5
         DaFMT6TFYmyOCJ63yWqtD+RM9lA9tV5mrimiGaEQ1p+QWgszvmcxlkY1VCOqdeUXgJo2
         885sI7M7yGVTSzN9lBlWnOZlNShmAkeVkaivGXLjbX5MATZ0avtTlu7cWVe5nmqX4O/W
         TVyg==
X-Forwarded-Encrypted: i=1; AFNElJ8M7imeUoKAAr+jAyRVcY/efwAvIRXz1+e9cB/Elkb0oD6HbKqtiL4F4qhgvTAg9IqZP/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/CCTU0pcPA3JF0MjaQ3oX4bY/UcaHlP8Fb/s3YM++339DcG5
	Sr/03sFFYpPJtMpisDlYVu16DWLkQC7SyNNGtvw3w5nkH3xWgfPMSLqkX8iM7VCd4qjFV9+0JqT
	XVZpSSmFsWv8Kd9Vn7NHDjBXk2nodb0j/2jjHqux150TZBTVyJd1mQQ==
X-Gm-Gg: AeBDiesPeBwr9qftum63hA+mlkhfqIXZZPx6QH1E866Zio8jr5KjHR4SMR2uUylm4GS
	SweoXxglKZEQ8cqM/cBRSlkl+NaeUsVBmgrRAkq1al7FOX06H88OTuutLczubdTN7iATZiWnUdu
	dwJTDQsAfFHA62OYMrCXq+6Dq+WcPKfY8MkL0NQXgq/w0DDXhviF8UEVo48bifabKMF0hb/ZCIR
	wWc2UJE+NIztXaSg4m+PDfWOqPB+IQN/5FIat0ePpQKYtJ4I3PKk6COyZI2I5NQZoKcacOsksZ/
	JB30zrLpuQGr8RQv4m8bItQ8Fm1tBmJSkGJHtvHuy6EZsDYbp8zUVIBC1yQu0RR1LR9UoeoHGm6
	UjU5sRA2ZqNZjz6+9DJMIoKbPdrxXtD4XHBafZqiD97b4pHCT3ng+y01g2A==
X-Received: by 2002:a05:620a:40cb:b0:8ef:47ae:94de with SMTP id af79cd13be357-8ef47ae9518mr2002364585a.39.1777035600012;
        Fri, 24 Apr 2026 06:00:00 -0700 (PDT)
X-Received: by 2002:a05:620a:40cb:b0:8ef:47ae:94de with SMTP id af79cd13be357-8ef47ae9518mr2002358885a.39.1777035599426;
        Fri, 24 Apr 2026 05:59:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb3aa60b99sm1676032585a.42.2026.04.24.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:59:58 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:59:57 -0400
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
Message-ID: <aetpTUc9ojwF6Is7@x1.local>
References: <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <17b0dc02-eee3-46d6-9afb-5f81a3a20216@kernel.org>
 <aep8tsYFfr_Xe54q@x1.local>
 <aetHWMZyEEIEzsJZ@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aetHWMZyEEIEzsJZ@thinkstation>

On Fri, Apr 24, 2026 at 12:37:35PM +0100, Kiryl Shutsemau wrote:
> On Thu, Apr 23, 2026 at 04:10:30PM -0400, Peter Xu wrote:
> > On Thu, Apr 23, 2026 at 09:25:30PM +0200, David Hildenbrand (Arm) wrote:
> > > > 
> > > > The other thing is, as I mentioned in the other email, I still don't know
> > > > how the current RW protection would work for anonymous.  I don't yet think
> > > > the user swapper can read the anon page with RW-protected pgtables.  So far
> > > > my understanding is maybe you only care about shmem so it's fine, but it'll
> > > > always be great to confirm with you.
> 
> 
> That's true. We use vhost and therefore shmem in our setup.

I see, thanks for confirming.

Side note: I believe host works for anon too since GUP works for anon, but
it doesn't matter as long as we know anon isn't a must.

> 
> One idea I had about how to make atomic eviction for anon is extending
> process_vm_read() and process_madvise():
> 
> - Add a flag to process_vm_read() to bypass the protnone check on
>   accessible (or only RWP?) VMAs.
> 
> - Allow process_madvise(MADV_DONTNEED) when the caller already has
>   ptrace write access to the target.
> 
> The standing objection to remote DONTNEED has been "destructive", but
> process_vm_writev() already lets a ptrace-capable caller overwrite
> arbitrary anon with attacker-chosen content. DONTNEED is strictly
> weaker — it zeroes, it does not inject — so the trust model is already
> established.
> 
> > > I wonder if uffdio_move could be used for a swapper implementation instead?
> 
> I considered it. UFFDIO_MOVE can in principle relocate the cold folio
> into a staging VMA inside the VMM, which then reads it and drops it.
> The downside is the VMM has to maintain a second address range and
> serialise eviction through it. A purpose-built primitive — something
> like UFFDIO_EVICT that zaps the PTE and returns the folio contents
> (optionally to an fd for io_uring) — seems cleaner.

Right, the other thing is unnecessary overhead on the extra pgtable
operations when moving to the staging VMA (e.g. tlb flush).

> 
> 
> > If RW is justified to be useful first, maybe.
> > 
> > I had a gut feeling Kirill's use case doesn't use anon at all, then if
> > nobody needs it we can still decide to not support anon.
> > 
> > > 
> > > If we ever have to read from a protnone page, maybe we could teach ptrace access
> > > to do it, or have something that can read from prot_none areas -- like
> > > uffdio_copy, which can write to prot-none areas.
> > 
> > Somethinig like swap_access() in my proposal can also partly achieve that.
> > 
> > https://lore.kernel.org/all/aYuad2k75iD9bnBE@x1.local/
> 
> A maccess()-style primitive that reads through PROT_NONE is a reasonable
> building block and overlaps with part of what UFFDIO_EVICT would need.
> 
> > There, it was only about reading from swap so far, though.  But that one
> > might be easier to be extended to read PROT_NONE and directly put data into
> > buffer user specified (ps: in my local tree impl I named it maccess() to
> > pair with mincore(), but it doesn't really matter; it doesn't even need to
> > be a syscall..).
> > 
> > To me, the interfacing is not a major issue.  The major question I have is
> > why RW protection can help in swap system impl when we already have uffd-wp.
> > 
> > So I want to make sure the use case can't be implemented by uffd-wp already.
> > Because that's really what we might do for QEMU.
> 
> Race-free eviction can definitely be implemented with uffd-wp already.
> But not proper working set discovery.

Good.  Then we can focus the discussion on hotness tracking with RWP and
its benefits, and compare it with a pure access bit focused tracking system
(as I mentioned in the other reply).

Thanks,

-- 
Peter Xu

