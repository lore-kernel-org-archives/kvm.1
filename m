Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBD3E0C6D
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671354; cv=none; b=XinADAQ9Llhc2gtUsxJB03tH9MudLDTSNLXlC1tXITtAFzwWulI2kV3wFgtK0pdTVs5d8y51uncMhieITmZPs/g+CThT8bCg7eY6zHs4qrRUaHeUxDa92HC3Q58ZNyEV/3UG6XT++v+NwBz0Fy+ZPNHXqj/3dpQT4c8JB9hUkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671354; c=relaxed/simple;
	bh=XkPdGUmNRSBGr3+ifPjcHl2PrQBpsF3QBH5hEZpZ54U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htD+vqvov2RRGR6KugxHFlP92S/Dg+lipkgtZPVwgxsKhUV2DioJh9kcix8pAFhtrPcTJW59DYwxQHA5eaFpoCkH6i1urcX6HZV0nnq1zCFcGDkRrEzXKbvbHS0+kntpic3PYsx7JhlgdPsTH0sXISf1uknvMo9Ac3fF1mRBQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehHH2RYz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyfKeRIU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehHH2RYz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyfKeRIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbnEVeFbG8cpEs96wFiXUr8pcbuq1jm4ef3IcsDU6X4=;
	b=ehHH2RYzwAQpN7vcgo5KbDPaXkPiiHGYXOmwa7tULO7cEUlA/6Ka73LLf0aCAGPurTPga9
	Efvcjkrh5qa/r0EsL5w2fV70Zcb5quRM0oei87Oxpwsns/isPBE6+T0uZiJuAxt4bWn/JH
	JyIQ8HxYTbxyLxV2OK7G4t+uNjzO+RQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-68lxpSocPUKEoS9UcPp5Dg-1; Fri, 05 Jun 2026 10:55:48 -0400
X-MC-Unique: 68lxpSocPUKEoS9UcPp5Dg-1
X-Mimecast-MFC-AGG-ID: 68lxpSocPUKEoS9UcPp5Dg_1780671347
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490aadb1386so15075525e9.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780671347; x=1781276147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbnEVeFbG8cpEs96wFiXUr8pcbuq1jm4ef3IcsDU6X4=;
        b=SyfKeRIUksTHxBI2L20h53+DdWGAUJLwgfsgadXrnJA6JW3b/UncRg7HoH5g/1qxZH
         o9dgmz4yQdZiSuv/1OGdMi+aamhpDFtWrtY56S71/8i13yDPTSGqQGyHxDs0BeBUEUPM
         GWJoOHb6eCBePzuHB6ZsNGwztyZek35Arq31w8GSkNvQaeXkf5MUWUe+/lQS/KtiSPFt
         lx45w0LRweWwZXCxVPwnCt1fcVlZzNpocU65umGEuM/0mz5WhWZiOsEgDIAxn5vZoOUa
         jksMEinpn6CY6CGRTkpZ+37KT1+GJ4QDGXvK4ckteoi77qIuq/9X4A66bcGiBtvBbJg8
         SfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671347; x=1781276147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbnEVeFbG8cpEs96wFiXUr8pcbuq1jm4ef3IcsDU6X4=;
        b=ACSjAXolQoPYrAuvSLGnka8GUGAB3JH2s1rib5KkWPteDZElMMuIr7++LslXTyR3FS
         xyZj47732coFmXs49X7b8Rd8X5A7R7glUuqcYzhOeT2ilHl3bPK37Lxy8P5iBgU4Fgvm
         sLj7MHw6Qp9lB7NaK3/p/vNL6f8qlB6iagrZcq6PUdsGeBIq+tJX/fZRMJB0T5/g8Id7
         99SrjCL28VnU83oPTCc1rPIYgzNxlCT1myfnK9mhHg5JiiAdgv6sftzr/wepWtczewBT
         oS7wUjnRNTugn6Y21oiDy3GmkOWG3+N+s4tZpuVN3CWKRpwG48DZg1lbwYcHSx9NKGR0
         /ETw==
X-Forwarded-Encrypted: i=1; AFNElJ9lyNl7K25bD5Ob4IhqgbqtsPEduk3uBBjIFxzfH3g1ZMeo82bTgzxwj/17O5OIbVlHLZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GsiIneXVdxoT2MJxt9dOsPSX+LM2dd4kSXs+ki6LjdTByg2u
	9Vdlc9WLweOE51xEzuTtF4PAhM66EKeXHCYf8LAfmT1KOs1Zamj8iY9lw2LrTQNv3AO0SosYCGb
	123GfOxwa7z2pr/jeRuQD7c2DgWI83aK5mWqaND4Pkc3RRNCHYeSQSEDTjM4xjg==
X-Gm-Gg: Acq92OG2dbxkFXS2RIynQeLxljP87WdG+X3UoXBOY8OZZ1n7hSbdFGOkRYFRsxDelPf
	occrYfcPeTMhCdAgqb6cpYiFFYScClnVicRCjwwEWeaPoj2waxzopRQ2eXh/jj2UiWv/6OUNIkn
	OtEOxww/Zrl7tPSg4ratRQaDOMKAc9cOUopTZGYljhpeMm0H90YWiU2PTwU7heKGP3Yfq9k50a2
	N8oJEAC17Zt3WuUwnTD/FFe8L/hIkXapmji5LNT9vRKv4BZ0zf/ej1kHYzD5vID/qdZX1yr4y2x
	FzLrvX5nXWpdU9BKqdS2kLhMNuO/kzmY6FFZ4tmAGOVvAnSx39yKBi314vh2Zh+GcINBmd22P3T
	Ap4gKNIz4CkPfWke+1kdAvUCdwPxAwH99Z8yE6O0HJ1Yes2N8oEQNhf8=
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490c2d1fb35mr52046465e9.15.1780671346840;
        Fri, 05 Jun 2026 07:55:46 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490c2d1fb35mr52045885e9.15.1780671346297;
        Fri, 05 Jun 2026 07:55:46 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm13729661f8f.32.2026.06.05.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:55:45 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:55:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Message-ID: <20260605105455-mutt-send-email-mst@kernel.org>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>
 <20260604194613-mutt-send-email-mst@kernel.org>
 <42c42370-2cf1-4b98-8d6a-8d7cd62f95f4@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c42370-2cf1-4b98-8d6a-8d7cd62f95f4@amd.com>

On Fri, Jun 05, 2026 at 06:31:51PM +0530, Garg, Shivank wrote:
> 
> 
> On 6/5/2026 5:16 AM, Michael S. Tsirkin wrote:
> > [You don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu, Jun 04, 2026 at 12:21:15AM +0530, Garg, Shivank wrote:
> >>
> >>
> >> On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
> >>> kvm_gmem_get_policy() sets *ilx to the full page offset
> >>> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> >>> offset on top of *ilx, so the offset is counted twice.  This
> >>> causes NUMA interleaving to skip nodes: for order-0 pages the
> >>> effective index jumps by 2 for each consecutive page.
> >>>
> >>> The get_policy vm_op should return only a per-file bias in *ilx
> >>> (like shmem_get_policy does with inode->i_ino), letting
> >>> get_vma_policy() add the page-offset component.
> >>>
> >>> Fix by setting *ilx to inode->i_ino instead of the full page
> >>> offset.  The page offset is computed by get_vma_policy() in
> >>> mm/mempolicy.c. The full offset is still computed
> >>> in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
> >>> shmem_get_policy() follows the same pattern.
> >>>
> >>> Found by Sashiko (sashiko.dev) AI code review.
> >>>
> >>> Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
> >>> Cc: Sean Christopherson <seanjc@google.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Assisted-by: Claude:claude-opus-4-6
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>  virt/kvm/guest_memfd.c | 7 ++++---
> >>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >>> index 69c9d6d546b2..0bcf6fc08e2d 100644
> >>> --- a/virt/kvm/guest_memfd.c
> >>> +++ b/virt/kvm/guest_memfd.c
> >>> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
> >>>  }
> >>>
> >>>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >>> -                                            unsigned long addr, pgoff_t *pgoff)
> >>> +                                            unsigned long addr, pgoff_t *ilx)
> >>>  {
> >>>         struct inode *inode = file_inode(vma->vm_file);
> >>> +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> >>>
> >>> -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> >>> +       *ilx = inode->i_ino;
> >>>
> >>>         /*
> >>>          * Return the memory policy for this index, or NULL if none is set.
> >>> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >>>          * can then replace NULL with the default memory policy instead of the
> >>>          * current task's memory policy.
> >>>          */
> >>> -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> >>> +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
> >>>  }
> >>>  #endif /* CONFIG_NUMA */
> >>>
> >>> --
> >>> MST
> >>>
> >>
> >> Thanks for fixing this. LGTM!
> >>
> >> Reviewed-by: Shivank Garg <shivankg@amd.com>
> > 
> > 
> > Can u actually test it though pls?
> > Because I think another patch I sent in response so Sashiko
> > is also needed.
> 
> Hi Michael,
> 
> Yes, I tested this.
> 
> I used kretprobes to read *ilx on each kvm_gmem_get_policy(), while calling
> get_mempolicy(MPOL_F_ADDR) on consecutive offsets(0..7) of guest_memfd mapping:
> 
> BEFORE:
> page offset:  0   1   2   3   4   5   6   7
> *ilx:         0   1   2   3   4   5   6   7
>   
> get_vma_policy() again add the page offset on top. so, it will increase by stride 2.
> 
> AFTER Fix:
> page offset:  0       1       2       3      ...  7
> *ilx:         128376  128376  128376  128376 ...  128376
> 
> It store i_no, so after get_vma_policy(), it will increase by just 1.
> 
> It's hard to show any wrong allocation with the bug because this index value is not
> used by allocation path, which uses NO_INTERLEAVE_INDEX.
> 
> Tested-by: Shivank Garg <shivankg@amd.com>
> 
> Thanks,
> Shivank
>


So for this to be useful at all
we do need the patch I sent in response to sashiko, right?
Mind trying out that one?

-- 
MST 

