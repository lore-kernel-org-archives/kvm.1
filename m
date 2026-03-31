Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFB2417D1;
	Tue, 31 Mar 2026 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928000; cv=none; b=WpJa9X6fozRmgVEql+nIJhZrcCna0AaNwzILBqWMutrK3+25W13M2DwfMBuU1XXZSuKQpqTF9npzJASi8VGl3y13RM0amiUczHi1nO9aUKFZEPqAYQ6imPZ0mniSx+yPF0ZUrvNO8nYRsR+dwwOJrE9PtOALhOsfJ7Blbw/EIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928000; c=relaxed/simple;
	bh=GJTZklG1sKmF/WrfX8qINx8zDJviAcgKqqdK+YrWwGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBnAmdWxvTI7B0WUdAD43ohFNMgNXSp0kOQXjDu+YhxUwHMmISfFEmwuMHCYhMOgf41nLwpdm1iz7HktohdN94PK7uT20ebOX3Zd8FKHAgjeaIy3S8SIwjKic0YE6AK4mYeNNXLMWl/5yXJFAEW166LsrfwFh2jG0bUizi7vO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sanwzxU3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sanwzxU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB6BC19424;
	Tue, 31 Mar 2026 03:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774928000;
	bh=GJTZklG1sKmF/WrfX8qINx8zDJviAcgKqqdK+YrWwGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sanwzxU3DS9SwZaOPuydSXSU9Pk16mt7rrDRoYhsMp9Okbj/gYJPVBAfRWia9b9Mi
	 wCGflSfwtRHBB4zKWEHDat5VETvwzfrA8NwQB25Mrqwlz9JVqdnfANXwyJVprS05QF
	 EGB0S/NYVdt2FSbX3VB8UAYTq8U/8kZSJPbKuH0Vwsbo8EkWliF0blYzIPH124vaSh
	 g6sNUyYvpHrPFrkS2sCfReyXu/FimdZjvsgJ6DHaBsnV74g7aBJIWUCdhHvWjs0Ddz
	 5GeJbcT7uXRrAE93lS59cdUtV0ne2sus6eFYwPAzEbfjnebtsbRZa4jwBRqU24HLBJ
	 kxfaTlEGYJe0Q==
Date: Tue, 31 Mar 2026 12:33:18 +0900
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
Subject: Re: [PATCH v3 01/15] userfaultfd: introduce
 mfill_copy_folio_locked() helper
Message-ID: <actAfiUYvUjUNiZM@hyeyoo>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330101116.1117699-2-rppt@kernel.org>

On Mon, Mar 30, 2026 at 01:11:02PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Split copying of data when locks held from mfill_atomic_pte_copy() into a
> helper function mfill_copy_folio_locked().
> 
> This makes improves code readability and makes complex
> mfill_atomic_pte_copy() function easier to comprehend.
> 
> No functional change.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
