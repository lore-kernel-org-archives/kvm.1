Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB633C9EE9;
	Thu,  2 Apr 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137661; cv=none; b=humutGnivS7SBs4wHZpKAmirHUJRU4LZKgRvqg0jStKD3BVaeYdixhc1j8m/UwHMN0HPMhbQdTWOjkTVVz7GyZjI0y+JjqIazg89/cAhaTuzqxWAhhOTwIFHvomwB5DY7JmCftIg7Fa08Yb69AUy0KMqj4gVEYpE0iuxCgZ/CVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137661; c=relaxed/simple;
	bh=LAu2eve5d40LPtMFRUfSuD6GUgpv9j8UkuT3bPR2L5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8hlbuPKfMtEQ41Opv3wwvlYRPiNA2knQNbGRH1A96kwwsjx5PQA/KdJMGaE4Dxwjx/WGqLtDErxQXQ2bpX76vDspo/IvcaoCqYhShGcDQjS2d/fJJDTqTwZg3iRXfvgNl9YofCPxmmAT6Vi0aF/BW9yW0/pG46/RXG5b8Rpa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPX8t+va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPX8t+va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93135C116C6;
	Thu,  2 Apr 2026 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775137661;
	bh=LAu2eve5d40LPtMFRUfSuD6GUgpv9j8UkuT3bPR2L5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPX8t+vaywKlBFPjhiAJSEPq9JqJXSnDJGTjoLCQr9bsJVcqeh0t9l8Ekh9B1Vyww
	 46kiK5HAiXJIeWs/EYTNRSikJka+SfXoDBMUaLdn8ArBAfmP2TSQ/uubYGR40Pq6zV
	 a6VQJQ+odfmnUPlM1AT48ylZmf9s99Yt8SeBu0ENcnQ0cWdtGuqJ4JIJtkDVxtZc2B
	 SNv7jkf6OZMDfrduV4N57zbBRHBicOs4cMwvPJb7MiT4vlD9BAaIo9ZO/sssigcA7c
	 xsY/nCAhBbZnPf+ZW5Ny5TULfVb8RndY5PWcJt+bkSn//Otfbq5W1WzV8jwjAHwKWt
	 CkdMDnZSZ20qA==
Date: Thu, 2 Apr 2026 16:47:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH v4 11/15] userfaultfd: mfill_atomic(): remove retry logic
Message-ID: <ac5zcDUY8CFHr6Lw@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-12-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402041156.1377214-12-rppt@kernel.org>

On Thu, Apr 02, 2026 at 07:11:52AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Since __mfill_atomic_pte() handles the retry for both anonymous and shmem,
> there is no need to retry copying the date from the userspace in the loop
> in mfill_atomic().
> 
> Drop the retry logic from mfill_atomic().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/userfaultfd.c | 24 ------------------------
>  1 file changed, 24 deletions(-)

After discussion with David Carlier about potential replacement of VMA in
mfill_copy_folio_retry(), I looked again in the code and realized that
after all the rebases I didn't remove the bit that temporarily prevented
returning ENOENT from __mfill_atomic_pte().

Andrew, can you please fold this into "userfaultfd: mfill_atomic(): remove
retry logic"?

For a change it applies cleanly :)

commit 5173c8f4fd32f314907b3804217ef57d4e3a2220
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
Date:   Thu Apr 2 16:38:39 2026 +0300

    userfaultfd: remove safety mesaure of not returning ENOENT from _copy
    
    Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 935a3f6ebeed..dfd7094b1c40 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -530,9 +530,6 @@ static int __mfill_atomic_pte(struct mfill_state *state,
 		ops->filemap_remove(folio, state->vma);
 err_folio_put:
 	folio_put(folio);
-	/* Don't return -ENOENT so that our caller won't retry */
-	if (ret == -ENOENT)
-		ret = -EFAULT;
 	return ret;
 }
 
 

-- 
Sincerely yours,
Mike.
