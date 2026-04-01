Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1C3DEFE0;
	Wed,  1 Apr 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065039; cv=none; b=aTBdIWoOt0X/t4vGtkw63OGieQnr8QCRTMwBhC/rHzslAeOowLZTkvceYxqley1LC/rea08etz/xwEXNhFANtuD6Ou9EHXsbQAcJsZcu3C53VBnXTAUXlKzhwQPkTSmBLImBuhG9Y8obaUatkcn6RGFWkTL/RlfPmYC/CqJ2gBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065039; c=relaxed/simple;
	bh=QmcnS3tunksGoYi+iCesvBhUK2kH7XFD5ftcMv/BXsQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZOjyMh2ZueRzI3mBM98rncZkFm1otapyIJLPdt2uCeF2GjsLoPaPtZTA1lW4UUZ6iC/oqb5FawnjfVzyx7Waa8LHg49mCA8/MhMg+Y05rqv7NzVDkdD1llM56+CrM/Ba+TcicwGtWTSHAR0/z6Dq3APiLJLRgBmmBJ9qAqwK2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mwIDp6FB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mwIDp6FB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F657C4CEF7;
	Wed,  1 Apr 2026 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775065039;
	bh=QmcnS3tunksGoYi+iCesvBhUK2kH7XFD5ftcMv/BXsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwIDp6FByrI4mxsw47udOkD5cNG1MxeD1cHCBXZY1mgNVQC8np/HoYpcQ8mz4shaf
	 fRI/wvkzpdKYrIa6qQfjJdLevmo5IzBMNee9Q4H4YzcWhb3D/LKSjw7w0dfEJNCDSV
	 xH1xXd+gw3c+bBphnXqjNNoPmOMD++IpR0ThjHfo=
Date: Wed, 1 Apr 2026 10:37:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 James Houghton <jthoughton@google.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin
 <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-Id: <20260401103717.b236b271a2856d536a48663b@linux-foundation.org>
In-Reply-To: <aczK4-vrULRiTvyh@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
	<20260330101116.1117699-3-rppt@kernel.org>
	<actxscYZGFiyvUcs@hyeyoo>
	<acva_NKf7T5rbIC8@kernel.org>
	<acvnEd3-s6XI26vb@hyeyoo>
	<aczK4-vrULRiTvyh@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 10:36:03 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Here's a fixup (it causes a conflict in patch 4 though).
> Andrew, I can send v4 if you prefer.

Looks pretty simple.  "userfaultfd: introduce mfill_get_vma() and
mfill_put_vma()" now leaves things like this:

retry:
	err = mfill_get_vma(&state);
	if (err)
		goto out;
	state.vma = dst_vma;

	/*
	 * If this is a HUGETLB vma, pass off to appropriate routine
	 */
	if (is_vm_hugetlb_page(state.vma))
		return mfill_atomic_hugetlb(ctx, state.vma, dst_start,
					    src_start, len, flags);

	while (state.src_addr < src_start + len) {
		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);

		err = mfill_establish_pmd(&state);
		if (err)
			break;

		/*
		 * For shmem mappings, khugepaged is allowed to remove page
		 * tables under us; pte_offset_map_lock() will deal with that.
		 */

		err = mfill_atomic_pte(&state);
		cond_resched();

		if (unlikely(err == -ENOENT)) {
			void *kaddr;

			mfill_put_vma(&state);
			VM_WARN_ON_ONCE(!state.folio);

			kaddr = kmap_local_folio(state.folio, 0);
			err = copy_from_user(kaddr,
					     (const void __user *)state.src_addr,
					     PAGE_SIZE);
			kunmap_local(kaddr);
			if (unlikely(err)) {
				err = -EFAULT;
				goto out;
			}
			flush_dcache_folio(state.folio);
			goto retry;
		} else
			VM_WARN_ON_ONCE(state.folio);

		if (!err) {
			state.dst_addr += PAGE_SIZE;
			state.src_addr += PAGE_SIZE;
			copied += PAGE_SIZE;

			if (fatal_signal_pending(current))
				err = -EINTR;
		}
		if (err)
			break;
	}

