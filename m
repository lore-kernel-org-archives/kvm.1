Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5F42A82;
	Fri, 27 Mar 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595834; cv=none; b=oB+XgzxMV2a735up5LBB//4rnY+LWi+jVStuLw3MC9EaDyHIh+I+5HKGIakD41Cm4lkfKLDESYaVGcg0TLLWIFbAaB7BsVQx7yAsoVAxw8h1YwryzKozGcNePRk4j7DpeEEHaTsarwld0jaXaSEaM0v6oANPAhHBsXJ4+Qzn9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595834; c=relaxed/simple;
	bh=IUYSIF0KW3Qy7E/Goib0L6h6MkvUQflSfro+xi0ix5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN7z2+Kx+pawF3TC6RmXQ9Y1G6mlSlVpoIe7sJ7yZZVaxhkftlpossI+zDl1wRhnE0zB636z1ABAARyyvLOsxrFXc7VvvijXi7HX+biGLhsmECS5RpQDC6jvHp3j5FW63VO2c/eh7S4WFNT8X9mnJ0H8jqxbpIJgktmDckGlmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrApkn7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrApkn7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE0C19423;
	Fri, 27 Mar 2026 07:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774595834;
	bh=IUYSIF0KW3Qy7E/Goib0L6h6MkvUQflSfro+xi0ix5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrApkn7gG8vBjF+SCfFHdfy/8oIgFR+Akh5d7BCU1Hohx54Is9QxXoNfoa9uGQ4xo
	 eflLiTJzu+tR8+wLJNWrOtLgcHXWatjoA5kp3SnT35BEGfuDE7YgLi90cne6xcF67U
	 2h6tesGWXERiMxErSowF0IgsS+5sAD+EmQRXp24N+AFOSgHCAv6Mw2EHM274kKi7Hb
	 qTEAVBhSF8GjVmtd1bfwyrtH+sRaAWotyofj4MN8LIlyhA+3yvRsT/SlQzEJT5PiSZ
	 EXe0zx0WhTbGdPXf/iCs4Pbju/YkGV9cunDQD4qzBUts4ESi1PJ6H2eHxZs+uZOUAi
	 xeuaWZkdh54lQ==
Date: Fri, 27 Mar 2026 10:17:03 +0300
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
Subject: Re: [PATCH v2 09/15] userfaultfd: introduce
 vm_uffd_ops->alloc_folio()
Message-ID: <acYu77eY_brO1blK@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-10-rppt@kernel.org>
 <CADrL8HUE1iBSPPDQZ3e-1gxN0Ts9kHAzb4o5X_XqSmQy2y9dRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HUE1iBSPPDQZ3e-1gxN0Ts9kHAzb4o5X_XqSmQy2y9dRA@mail.gmail.com>

On Thu, Mar 26, 2026 at 05:07:08PM -0700, James Houghton wrote:
> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > and use it to refactor mfill_atomic_pte_zeroed_folio() and
> > mfill_atomic_pte_copy().
> >
> > mfill_atomic_pte_zeroed_folio() and mfill_atomic_pte_copy() perform
> > almost identical actions:
> > * allocate a folio
> > * update folio contents (either copy from userspace of fill with zeros)
> > * update page tables with the new folio
> >
> > Split a __mfill_atomic_pte() helper that handles both cases and uses
> > newly introduced vm_uffd_ops->alloc_folio() to allocate the folio.
> >
> > Pass the ops structure from the callers to __mfill_atomic_pte() to later
> > allow using anon_uffd_ops for MAP_PRIVATE mappings of file-backed VMAs.
> >
> > Note, that the new ops method is called alloc_folio() rather than
> > folio_alloc() to avoid clash with alloc_tag macro folio_alloc().
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Feel free to add:
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks!
 
> > ---
> >  include/linux/userfaultfd_k.h |  6 +++
> >  mm/userfaultfd.c              | 92 ++++++++++++++++++-----------------
> >  2 files changed, 54 insertions(+), 44 deletions(-)
> >
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 66dfc3c164e6..4d8b879eed91 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -91,6 +91,12 @@ struct vm_uffd_ops {
> >          * The returned folio is locked and with reference held.
> >          */
> >         struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
> > +       /*
> > +        * Called during resolution of UFFDIO_COPY request.
> > +        * Should return allocate a and return folio or NULL if allocation fails.
> 
> "Should allocate and return a folio or NULL if allocation fails."
> 
> I see this mistake is fixed in the next patch. :)

Endless rebases :)
Will try to sort it out this time :)
 
> > @@ -483,9 +498,15 @@ static int mfill_atomic_pte_copy(struct mfill_state *state)
> >                  * If there was an error, we must mfill_put_vma() anyway and it
> >                  * will take care of unlocking if needed.
> >                  */
> > -               ret = mfill_copy_folio_retry(state, folio);
> > -               if (ret)
> > -                       goto out_release;
> > +               if (unlikely(ret)) {
> > +                       ret = mfill_copy_folio_retry(state, folio);
> > +                       if (ret)
> > +                               goto err_folio_put;
> > +               }
> > +       } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > +               clear_user_highpage(&folio->page, state->dst_addr);
> > +       } else {
> > +               VM_WARN_ONCE(1, "unknown UFFDIO operation");
> 
> "Unknown UFFDIO operation. flags=%x", flags
> 
> seems a little better to me.

Yeah, why not.
 

-- 
Sincerely yours,
Mike.
