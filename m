Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5413A9D85;
	Tue, 31 Mar 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957333; cv=none; b=aQfpF3Zz721gIFHtmF+Ga+3fKfIXSAeNrAwJzBXARyoCUmHZagmdXw+rYDzjU+79pzRWxs0X89xxi7NCgeY3MvuGD8RKMR7lnzLSxcn5GzTfJBViW9CL5ld7ZlKOl6UYlqOAM3BFzercUHFkJD4KDgie1e/wCZjhr2OPtLZ9nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957333; c=relaxed/simple;
	bh=v9/AUUMGVf9+nhrOWCMNuXE2J/EJf4Yx/A5I91wqayM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQzJLD46vgpBBo0ACSjAH10pfNsdf3ZzN2h5KJlD1It7rXjZuSZRBpgw9Ny2udJukvx9GDcy2FWuCegmIegs0g/OkkUZGSoJT3YWklJAHAMoAHgWRj7fl6A/ODAP+MkjnDmWixxlHqafOgcOrISpA3FNQFtzofov72ET0xsUtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eklxj6nk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eklxj6nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A17AC19423;
	Tue, 31 Mar 2026 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774957332;
	bh=v9/AUUMGVf9+nhrOWCMNuXE2J/EJf4Yx/A5I91wqayM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eklxj6nkgag9phGSwi3AtluNOuSXDrudDeC/1PoarzkDyR4p3o0WsR5+F14ZRDl5g
	 K2Nl5yCy0RGOJ0DRUiYL4OX7lS9rHaVpZcs/Y14YToXTDAfwhtXM5q/OBBwVM6+9rC
	 a5PY+jeY6+oE9/UgIx8ASEbSIyVGTC4HR0AcfqfaLCYhekdoktZLfYZ2+11xgMDX/l
	 Wejb1KLzSWw22xCDrro+pnvMhSvIuDD7yHMaAR6HJWWaIHeb/lR56OmzTWLRk1p3mj
	 zt/MN2oV2Jzvs8jCoFDoR2DNo66mXetay7g3pMu7BgyOJjl9SFicy9OxWrV0FhxgiZ
	 d+DZbWhjK1q1A==
Date: Tue, 31 Mar 2026 14:42:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
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
Subject: Re: [PATCH v3 07/15] userfaultfd: introduce vm_uffd_ops
Message-ID: <acuzCX1GHZRLSu_x@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-8-rppt@kernel.org>
 <acqrtd7E6UxrX6Ji@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqrtd7E6UxrX6Ji@casper.infradead.org>

On Mon, Mar 30, 2026 at 05:58:29PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 30, 2026 at 01:11:08PM +0300, Mike Rapoport wrote:
> > First, there is no fundamental reason to limit userfaultfd support only to
> > the core memory types and userfaults can be handled similarly to regular
> > page faults provided a VMA owner implements appropriate callbacks.
> > 
> > Second, historically various code paths were conditioned on
> > vma_is_anonymous(), vma_is_shmem() and is_vm_hugetlb_page() and some of
> > these conditions can be expressed as operations implemented by a
> > particular memory type.
> > 
> > Introduce vm_uffd_ops extension to vm_operations_struct that will delegate
> > memory type specific operations to a VMA owner.
> 
> But the VMA owner already gets control of the page fault.  We don't need
> the vm_uffd_ops to be accessible from the vm_operations_struct.  The
> page faullt handler can pass a vm_uffd_ops into the uffd functions that
> it calls.

Not sure I follow you here. The ops are not required by the page fault
handler, they are needed for uffd ioctl handling, e.g

	userfaultfd_ioctl(UFFDIO_COPY) ->
		mfill_atomic_copy() ->
			vma = find_vma();
			/* do VMA specific stuff */

-- 
Sincerely yours,
Mike.
