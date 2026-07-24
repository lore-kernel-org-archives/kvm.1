Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2237C91A;
	Fri, 24 Jul 2026 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916304; cv=none; b=pbtWaHWGfe39/YjaIMT4pEctq9CFcUgny7ck2sLxaqi7OW/JfdX5WWT6ofyF3WCmOn3mapg2em+cPOPsYtT7sG8au/HV6scdD5yDx1evD5ee6QyIsrGgsSCuMrrhdBNcB2Nufa0A0gqbpNhVvz21GVjR4Mssu2ygo6Jyt1Ahh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916304; c=relaxed/simple;
	bh=6DJxZIGmDJUfE8dh5YDFcj1z+gXWM/0bQDdDFFXEwY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+V3WqlcjfVu0B1hawMrclxfaYDBDNjKj93juggNNw51B8Oc8qH/oKFJn/RQDsC+l8mucn724BAbi/IBH+UB8CzYF9U+UJTSiFa14AijSyOxu916gC4wmUbCJYPQ4WqRW/3Uy6U6ci6kC5ApvVmI4+wzHki/66yhx3GLDXDjVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PVgKgyGZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVgKgyGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MBK/aUXq2BzjcKKQY4Ho923DaPXp4qxTWkADm4EVxbQ=; b=PVgKgyGZTx58jiWkMjbJ8OYrAX
	EZhBGzYit/hlONjBPpLfGVfKBkRmMPJT68RznWoopXvybLWGkdpFpPiOl5hr97hmgbV4/IZrJqMDi
	bvSOhh56AipUZL5vMVE6cAEsuH1m5AnhWgtUKghBJvfvU+YtyCi9T17/94YQJzUaJnHSzT3GPex2p
	9/JtOKbbPf07q1I52X1CEs0Ctxp/4AJdNlt64KqhaUJj3xhzG1ML0cczNiSmd/q1dyCfCuAz2OBvH
	FHZZf+xq1RDlm2WJLQxOwpSzIz4aT+mMsh0F+b7qoqtcwwHjZGla6/DqOjHAVF/rxDc9fmcvxXRfu
	3iG4ht3A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnKGT-000000043U5-0DxV;
	Fri, 24 Jul 2026 18:04:53 +0000
Date: Fri, 24 Jul 2026 19:04:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Michael Roth <michael.roth@amd.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <amOpRMpkyFGm0j9c@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org>
 <amOByZH4oWzmO3Zj@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amOByZH4oWzmO3Zj@google.com>

On Fri, Jul 24, 2026 at 08:16:25AM -0700, Sean Christopherson wrote:
> Heh, you don't want to sign up for a week or two of onion peeling?

Oh, you have no idea!

Here's my onion so far ...

1. I want to simplify filemap_fault()
2. That requires changing all the architecture fault handlers
3. So let's push some of that down to the MM with a new wrapper around
   handle_mm_fault()
4. This would be easier if we could hoist the creation of struct
   vm_fault from __handle_mm_fault() to handle_mm_fault()
5. Which would be possible if Jane's series to fix hugetlb use of pgoff
   had landed
6. Oh, hang on, handling hwpoison on hugetlb is actually broken in a
   few different ways (some pointed out by Sashiko, some I noticed
   myself)

I honestly thought I was just going to rearrange Jane's patch series
a bit and resubmit it, but fixing the hugetlb hwpoison handling has
consumed me for the past couple of weeks.
