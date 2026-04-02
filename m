Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B7361DAC;
	Thu,  2 Apr 2026 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775104600; cv=none; b=RZY5caQKXbls5sCEouQL7O3A2fTVrtAme+jNy9Gr3+tMELFMylXgu2lU0uM1e+PV7lI/R/xvvSc2zZDbHy6oVNknKx++ZAoi1XDFxnV01BPwKheieiVjhbtyc0zVKSsc0ztPVRvyfMkH7ApQQ5F6NOx1k/EiHsW5cCHz++FkFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775104600; c=relaxed/simple;
	bh=BO7fsz3RgyTfGt+qlAE8Bxk0+VWTbQ00x2Lk1ONZHt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkxg80MzsT1VDmoI8Fs4iUIXrgzyLTaw/c57VwTmRboBHkMye0Pwcc4jqUBn6+IZAlx6iwZjihNfDmyM1QvhEwkpsmLtk07Xah61LHQUluWOgAby0GMFlcYpV0Vr05kce7xnqRhFc9v9PqRHA/fT13HpChI7r++EjFCFRKEb8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqcNtByW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqcNtByW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B2C19423;
	Thu,  2 Apr 2026 04:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775104600;
	bh=BO7fsz3RgyTfGt+qlAE8Bxk0+VWTbQ00x2Lk1ONZHt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqcNtByWtkQTQsw0jAe6rL7YrwTF43tjIQnYEYJvhKocqUKTazKj+U0NtDDdgSVj9
	 PPPOcN5qR+/3PV9PS2bXWxShnlL9s+povpRCGvGMgKf0M/y4oEu/T0A0ObQecQnxEq
	 CZyLKctaCMPGy28ehZM4mruaAZtp5GRovrtzKuxrhTUnlWesSR5XUImiu47/SWZjly
	 96XCdyUiuPbdcEbb9+pM8b65GfTbFbm35BF1+2y/Ri8zF8ySeA2N1DrXbXmUTqAS7W
	 TSUPWUxcmY0cyJ+vZ3wuww5/gQi4I9fp3HUPq9XQDhd2/8gvVrhM6XBj6Ds76F+U/v
	 5o7jwiTOXS71Q==
Date: Thu, 2 Apr 2026 07:36:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <ac3yS0F7clWYDptU@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-3-rppt@kernel.org>
 <actxscYZGFiyvUcs@hyeyoo>
 <acva_NKf7T5rbIC8@kernel.org>
 <acvnEd3-s6XI26vb@hyeyoo>
 <aczK4-vrULRiTvyh@kernel.org>
 <20260401103717.b236b271a2856d536a48663b@linux-foundation.org>
 <20260401104449.42123600e33e08b5ebad10a5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401104449.42123600e33e08b5ebad10a5@linux-foundation.org>

On Wed, Apr 01, 2026 at 10:44:49AM -0700, Andrew Morton wrote:
> On Wed, 1 Apr 2026 10:37:17 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Wed, 1 Apr 2026 10:36:03 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > Here's a fixup (it causes a conflict in patch 4 though).
> > > Andrew, I can send v4 if you prefer.
> > 
> > Looks pretty simple.  "userfaultfd: introduce mfill_get_vma() and
> > mfill_put_vma()" now leaves things like this:
> 
> err, actually, it gets messy.
> 
> Can we please have a v4?  I think there are a few other things pending?

Sent.
 
> I've noted
> https://lkml.kernel.org/r/202603311743.uZYPu1Gn-lkp@intel.com

Alice fixed this on the Rust side and the fix is queued to char-misc-linus:

https://lore.kernel.org/all/CAH5fLgg63SYHQ34yqy7o2cA5f2Gh0aNTwTeQkzbWb+kV4Rr3Qw@mail.gmail.com

> https://lkml.kernel.org/r/acqrtd7E6UxrX6Ji@casper.infradead.org

We've been through this since Peter's first posting and I think there's a
consensus about necessity of vm_uffd_ops and the argument was about what
exact API they should have.
 
-- 
Sincerely yours,
Mike.
