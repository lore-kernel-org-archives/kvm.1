Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1303B19B4;
	Fri,  3 Apr 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220854; cv=none; b=oZT2hw4buybT1oCotLXkLwv0Mp2VvjjiJWUUxfXfCyHtRvlsnthX2nTmkKTol9TFGdywgbjcJ/QHiSWzgZFcXij2LxPSEjNcxJ9D/x1Ld3egZFdC0Tom3pn01qZvG81mXQGfXCo1JuhwBU3eplub7flQBkhgs61N28D/+1vPeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220854; c=relaxed/simple;
	bh=JSDMZ50zmxlMSJSrQFbFqlAhhbTJtyO9Jz1PP7WSjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkkkR6AVAWVpIXoeWLOLPZ3KMcl4bYKPSUuHYarl8CzAM31u+t5wdzKX2HQgvyzRvCfAuSaj3lm54eXvFOxq/YTLMEBBMtAItBVL3lytO9T+kYuPAY3c3AXDZZyiHQ+K1v2G+9T0bA3tCoMzCwunDvbweVscg9P3GRYGQtNOZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5RK7Uaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5RK7Uaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D305C4CEF7;
	Fri,  3 Apr 2026 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775220853;
	bh=JSDMZ50zmxlMSJSrQFbFqlAhhbTJtyO9Jz1PP7WSjUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5RK7UaaStNBNTjrkkZugF9FaAH48CF6+MsNeYxjXQJlBC11UeEqtJTn54kJtCCye
	 y12jGio1VmWi5qVjhGjcIVZh4mPy92MUaurFatCaP3hySoPLwib1lCfZxz64Mgobtp
	 AZOHruz4CeULWx789vkplewzZ3kQYGU0JF3+OHtIgExCPlGrGqciiQ9LvGX820GCXZ
	 hJl+MrErarKqqdiKWR5RmQvOJCTOn7IWv+8ULi73jY1BqPAc3RFN97UCoGFY2/3+zs
	 Sr/POPOu9BZPg8GOJDuSAeESXxv8AMAqWcUkoREqPTA7yx3M5oVQTA1itREe5cyGmP
	 XZ8WLJxiE4s5Q==
Date: Fri, 3 Apr 2026 21:54:11 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 04/15] userfaultfd: introduce mfill_get_vma() and
 mfill_put_vma()
Message-ID: <ac-4c0hlgdrxktvJ@hyeyoo>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402041156.1377214-5-rppt@kernel.org>

On Thu, Apr 02, 2026 at 07:11:45AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Split the code that finds, locks and verifies VMA from mfill_atomic() into
> a helper function.
> 
> This function will be used later during refactoring of
> mfill_atomic_pte_copy().
> 
> Add a counterpart mfill_put_vma() helper that unlocks the VMA and releases
> map_changing_lock.
> 
> [avagin@google.com: fix lock leak in mfill_get_vma()]
> Link: https://lkml.kernel.org/r/20260316173829.1126728-1-avagin@google.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
