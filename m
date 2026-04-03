Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721D36B042;
	Fri,  3 Apr 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215191; cv=none; b=PCT5AnOlPRCxv6sZCf7UttRzSjbchxt1wCvZgAl58TGwH5hC34wS2S2ay8C1MC+VqpCscfW1pSsL3TbSdG2vm4fCovGxbdF2QdSF6/dkSJTmQqfaAg9PldPa2lPu45JDAo5w4o253Iz6mMfUkamKI/Uw+oWULZiTwEmnJKE1c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215191; c=relaxed/simple;
	bh=hRrSUX5Y67DodyvbxDmfIiZc+tcYC4iUUoSxWjobaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic8kW+UKy8uO2/y669gmy7TYBC5HuelVBCluXEArCLZ4CSpk0h4AYXDLZOjJvfMkcE4ObwYCcKa9qNWMnGsAIMcUeXQhNEVnLY0QMo+SJeQ9Kq2gzS8yPB4yMKShvK4QA4XCMilf5KdR00ZVwtPeeJwFjD5FF8gLB7cFnEsNRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIfnoZ5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIfnoZ5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F51C4CEF7;
	Fri,  3 Apr 2026 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215190;
	bh=hRrSUX5Y67DodyvbxDmfIiZc+tcYC4iUUoSxWjobaA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIfnoZ5qQxessDI+5NuWCseFDkD92kIvmF+Bkr/BNYTmAUBcMY0ue+bEpIvtnMES6
	 lPEN7268SRB5gRkMLFHvVd3U0dA6d03XhHuhdc28C4xmadPRl7Ulczx8S+r9RxmCK+
	 PC4BszpdWHOSXgA8a8YlhWDLJ+gTyScVwn2Yg48N6l3eYX7VjQ+MFZGZ4lotKIUvZb
	 u+0OAoyGErcYBrIwTaqEgJkjhRWz65uZCiTlU/ne069HRhqBYMrTgqv8dTQRu3Ub5i
	 yTox3WKhYjGwhDdfDtfjGMjXwKE68aQVQg5rUIfwNAYQbBlADCQK/bsNKkv8S+kKM4
	 dB3Wj8lqwkqag==
Date: Fri, 3 Apr 2026 20:19:48 +0900
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
Subject: Re: [PATCH v4 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <ac-iVOJZ8B8MLOl4@hyeyoo>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402041156.1377214-3-rppt@kernel.org>

On Thu, Apr 02, 2026 at 07:11:43AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> mfill_atomic() passes a lot of parameters down to its callees.
> 
> Aggregate them all into mfill_state structure and pass this structure to
> functions that implement various UFFDIO_ commands.
> 
> Tracking the state in a structure will allow moving the code that retries
> copying of data for UFFDIO_COPY into mfill_atomic_pte_copy() and make the
> loop in mfill_atomic() identical for all UFFDIO operations on PTE-mapped
> memory.
> 
> The mfill_state definition is deliberately local to mm/userfaultfd.c,
> hence shmem_mfill_atomic_pte() is not updated.
> 
> [harry.yoo@oracle.com: properly initialize mfill_state.len to fix
>                        folio_add_new_anon_rmap() WARN]
> Link: https://lkml.kernel.org/r/abehBY7QakYF9bK4@hyeyoo
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
