Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E827442;
	Wed,  1 Apr 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028975; cv=none; b=tpOZvfEhxmzMol7HXRnp/S5CGXW/8XcHkYnGJh9tTCzttKNZtHCOz2LfX+DzKYGt3Nevi8rw1HkT9E5m4xpj4D2tUYR1fzRsVRbGOGQF0CiV8Ix79YzNes/FWbT1LzzE4aYWMFbmoz4CDu9F2Z0Y/jl77YvQ/fIHhXMTCmexpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028975; c=relaxed/simple;
	bh=5rTB7ibb4EJd260wLqdjnMqvReSP2z55srJA8vs8o5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuEt21VIF7AHnGnmdHhrxlJszG0WmJidT+sAEeGxtg5MCLhcwF5y/u+VFJkKrZyJK7MbL9HyenJssjPk1hmbZXVq0hucGbcIHlNpVK3noZtAy6DM9t181X4L92MDIQlEKig4dL6hyAFZZK9VB9Nr3rgMh0r2bJr23IW/kcxl9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4CtlpsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4CtlpsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380D7C4CEF7;
	Wed,  1 Apr 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028975;
	bh=5rTB7ibb4EJd260wLqdjnMqvReSP2z55srJA8vs8o5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4CtlpsL26Rsw+EZZiTev651DLF0iUWb89sMoje+UpM9F2+9JyFQZV7uiePHV1H+n
	 /i2ukQTEDcgSXP4NUwDuAFdXGGwo/Skow9y1ktYu/p7/E3VMhv2M4hEufIewFANfj8
	 p/BLMWEdSs+wgnXhSzjJHNiUJoU+H+Ex153JmRFl3GB3ug+v36/cIap6jkeDHIb3Q+
	 JRUnqk4t12bzXNjWSMzpk1U40HVspfd5ZbNgLe5tm1fZfUSyJLrweLyQKM44XGSoKI
	 DaMJMVfeLeLKAMo2esv8n7fnhIzaVPkwV2qo94yC5nfESljP26VOXlECeRxjDtAXLF
	 kONBLyKbWn1wA==
Date: Wed, 1 Apr 2026 10:36:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
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
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <aczK4-vrULRiTvyh@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-3-rppt@kernel.org>
 <actxscYZGFiyvUcs@hyeyoo>
 <acva_NKf7T5rbIC8@kernel.org>
 <acvnEd3-s6XI26vb@hyeyoo>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvnEd3-s6XI26vb@hyeyoo>

On Wed, Apr 01, 2026 at 12:24:01AM +0900, Harry Yoo (Oracle) wrote:
> On Tue, Mar 31, 2026 at 05:32:28PM +0300, Mike Rapoport wrote:
> |         /*
> |          * Make sure the vma is not shared, that the dst range is
> |          * both valid and fully within a single existing vma.
> |          */
> |         dst_vma = uffd_mfill_lock(dst_mm, dst_start, len);
> 
> It acquires the vma lock (or mmap_lock) here, but doesn't set state.vma.
> 
> |         if (IS_ERR(dst_vma)) {
> |                 err = PTR_ERR(dst_vma);
> |                 goto out;
> |         }

...

> |         if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> |                 goto out_unlock;
> |         if (!vma_is_shmem(dst_vma) &&
> |             uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> |                 goto out_unlock;
> |
> |         state.vma = dst_vma;
> 
> It is set here. So if anything before this jumps to `out_unlock`
> label due to a sanity check,
> 
> [...]
> 
> |         while (state.src_addr < src_start + len) {                              
> |                 VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);             
> |                                                                                 
> |                 pmd_t dst_pmdval;         
> | [...]
> | 
> | out_unlock:
> |         up_read(&ctx->map_changing_lock);
> |         uffd_mfill_unlock(state.vma);
> 
> the `vma` parameter will be NULL?
> 
> If I'm not missing something this is introduced in patch 2 and
> fixed in patch 4.

You are right.
Here's a fixup (it causes a conflict in patch 4 though).
Andrew, I can send v4 if you prefer.

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index fa9622ec7279..c4074b6f4aca 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -764,6 +764,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		err = PTR_ERR(dst_vma);
 		goto out;
 	}
+	state.vma = dst_vma;
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -804,8 +805,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
-	state.vma = dst_vma;
-
 	while (state.src_addr < src_start + len) {
 		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
 
 

-- 
Sincerely yours,
Mike.
