Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39E3C1961;
	Fri, 27 Mar 2026 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595560; cv=none; b=oIEEF5wQk6PMBr7LDtzO47nwXlYvp5lH0/08RrbMmb0xnMOuHOdJImn2Pp4oJFnhEJTvDt0GJ6Fi1GbxyNc1IDNfw3d0G2LCCwm/uo4o8M50So+UoKkxyIzfBOkwe17/EQ39Zqs+KeK1nSireYsATPpYk6n9haG5LABwDRwsklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595560; c=relaxed/simple;
	bh=PItmMBxubPXbDaDdFWXsnbR+luD1aEAhbzGl7SFLZPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un01UKcLog+FPRq0AKAWrXtj5tAWTwv4ibJDtAIUqTc704qDIah8lYLZ4kBuLEVYwe7WvH8O9juLsj4RT68MLc2d4KoZwCgXrWZL/yryBz0bimXQ2pp8BuryciOpdJgFQwQ6f9RA6mv5s3BdIgTHKOXFkL/gN+9jMivpQiw+9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp6tuO5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp6tuO5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1E2C19423;
	Fri, 27 Mar 2026 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774595558;
	bh=PItmMBxubPXbDaDdFWXsnbR+luD1aEAhbzGl7SFLZPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sp6tuO5d9pGV1raZoHXRtGY96jXKIm4ROm5AlCmZXFn7QxpwFuNJUeFg5gTbc/TII
	 6PT2AR8Dpl0fFzcjkgh+RVmOBuO6IXUKbuoFf9MqUlnMgWx/Gmebdl973ejK4pWYgW
	 Y4bMkQNxNBlQwnG4nVDKdjsYUDmbZjHSoeT/wXL/jHmmiSxaTFr44P9TS/lONeSPea
	 0ofvniHWmQ+y4X3P6pnbZawHQQPvNsBIwY1yJIfadGRiHTn/KED7vwXxMCk9pUSqBm
	 PD+/iriMqKRAwyFQxBYj/LD7T01X3kL1e7CTVQnYPlIfEXm9laHcfaBlYpRC/HtywN
	 Nhso0JpjQendQ==
Date: Fri, 27 Mar 2026 10:12:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: Re: [PATCH v2 08/15] shmem, userfaultfd: use a VMA callback to
 handle UFFDIO_CONTINUE
Message-ID: <acYt3EA3TCgcgxX-@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-9-rppt@kernel.org>
 <CADrL8HWLnuQHEPFN9SZbAd_Lq1USJDV=Di4fsQuztwp4v5oXOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HWLnuQHEPFN9SZbAd_Lq1USJDV=Di4fsQuztwp4v5oXOg@mail.gmail.com>

Hi James,

On Thu, Mar 26, 2026 at 04:43:27PM -0700, James Houghton wrote:
> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> > it needs to get a folio that already exists in the pagecache backing
> > that VMA.
> >
> > Instead of using shmem_get_folio() for that, add a get_folio_noalloc()
> > method to 'struct vm_uffd_ops' that will return a folio if it exists in
> > the VMA's pagecache at given pgoff.
> >
> > Implement get_folio_noalloc() method for shmem and slightly refactor
> > userfaultfd's mfill_get_vma() and mfill_atomic_pte_continue() to support
> > this new API.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> I found myself asking why HugeTLB wasn't included here; it's because
> we call into hugetlb_mfill_atomic_pte() pretty early. It would be nice
> to have HugeTLB implement get_folio_noalloc() and use the same path as
> shmem, but we don't have to do that now.

You are welcome to join the effort ;-)
 
> Feel free to add:
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks!
 
-- 
Sincerely yours,
Mike.
