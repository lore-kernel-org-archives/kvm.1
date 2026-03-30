Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D186387591;
	Mon, 30 Mar 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889928; cv=none; b=ZnD5bGUYo7jle0syvMOY6S6syR+r24oZSzYe+M/BZvygOHOC7chN56HHSqhvuJYc4yHsS1JmNoKtw0m7rwgOozyASDvITb3R6IJ3TyiFN2YGmNATkFeYljsH60z3OI4KxjF3/Q+4erYeI2LK5o8BoRKe1+WgDjqLTOn/SU3igqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889928; c=relaxed/simple;
	bh=VKLvp+uMOOd5LtXSPJlywGPSf2VfxikxJgexH7lMKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjdwG3qA9wT8xfrKKPSWnUM4TIWWXzDCN3DYit3a8fEjx7HDqgtBTsG+vgo+pwS4T2xHZXG4NdzB309dGJ3388LT0Wg/TrieC2B2PS7hFxuxwLvfQ5X/a7G7pIEWkdjBQSGPk/retUM8+fAsIoOpIVN3NWn2Vwyg+fPcbYEe3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+KSHUsn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+KSHUsn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LTYcvaP5MEZnE+DljoPd73awiPBytEGfcZ6MHlkjhGA=; b=R+KSHUsn6FqBDM6KGGgxGj/Cz5
	bN/ZlNffp9KiVMc1nTrjrIIRvoWeIrimELIrliaHthag29/n0qpvD056G6AlgpwiekIx2e5aXWZIx
	Co0B1gG4ciOcSm0kV0C6iVZe6jiaZeSeVVs5cjJdzOONR3pPfput9jGav1GyzT0eqJPkMb2Twp8Ss
	0J1byszlS+zY6BY63OJFURoYN7LQM2/Qq/YqyO2f/YNwdVxW7075NyzG1u3op0PWbVrhJ65Zr2wTb
	N/BM0a+FKiRiiQvjkOpyi/Pfgq5zBORtaPDe10yNXJbCwIFHa+jR4sNvJ80Ze9jQF5A7FCfarA9LR
	+w3gOueA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7Fwb-000000071eX-3KA4;
	Mon, 30 Mar 2026 16:58:29 +0000
Date: Mon, 30 Mar 2026 17:58:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <acqrtd7E6UxrX6Ji@casper.infradead.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-8-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330101116.1117699-8-rppt@kernel.org>

On Mon, Mar 30, 2026 at 01:11:08PM +0300, Mike Rapoport wrote:
> First, there is no fundamental reason to limit userfaultfd support only to
> the core memory types and userfaults can be handled similarly to regular
> page faults provided a VMA owner implements appropriate callbacks.
> 
> Second, historically various code paths were conditioned on
> vma_is_anonymous(), vma_is_shmem() and is_vm_hugetlb_page() and some of
> these conditions can be expressed as operations implemented by a
> particular memory type.
> 
> Introduce vm_uffd_ops extension to vm_operations_struct that will delegate
> memory type specific operations to a VMA owner.

But the VMA owner already gets control of the page fault.  We don't need
the vm_uffd_ops to be accessible from the vm_operations_struct.  The
page faullt handler can pass a vm_uffd_ops into the uffd functions that
it calls.
