Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F42DECCC
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616825; cv=none; b=EA2hZSh3Z6YO+IiuqurOizrwIsgTpWK7YR0hNTLasQ8EbsgP9cqyx1egPjY3rNaaHahDPnW3ENS2bkc1gZ3T6sZmNTm8I5f85Wu2Wwlp7V45wGTwtSCt3xrn+iKFhFpxxq3DlocN+VKg08tcABMs66COp2JTW++0Mqe9fC+s7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616825; c=relaxed/simple;
	bh=Ji2I9v1x/zo7NPk+NFQgmhy0u8ZeKVJIYMlijduMUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiPCaPdHxIcMuN6wySl6RqxStRbh+SknB+QKhRA4IBLz8/A/KT5nGJ52BSiSDTcO+UkJCM3W+VyotD7AZ+q6uc7IRZ+jAMva9Fkl5CZNyou/rpolv+XS1Fif3rSF57hksEbwutNB3vkm7mkJ128IfBQU8O4Tde/2/S86dPSzE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMhc3zqN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWrOrpw5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMhc3zqN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWrOrpw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780616823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P95+fYJ3vYLC521V0/dnSJW7Xac+PprHiZPgTv1UdmY=;
	b=DMhc3zqN10TCVBVJcRjKekdJXvcS+Slrkwo9MEwQeOSSFimE77zKzT6HlA9bPxM/AYk6dl
	j+LTYIATJfkkBG7fYK1l5M2vWK1jua+0lJJ/nBR/+DRBYf8mGW5ohIxRm3PID4KdpzE28i
	zqhne5h/nqOdh3BkNVCUiW3ANYontKQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_jEd9fIjOAKH_LBCNhQd0g-1; Thu, 04 Jun 2026 19:47:00 -0400
X-MC-Unique: _jEd9fIjOAKH_LBCNhQd0g-1
X-Mimecast-MFC-AGG-ID: _jEd9fIjOAKH_LBCNhQd0g_1780616819
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so882317f8f.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780616819; x=1781221619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P95+fYJ3vYLC521V0/dnSJW7Xac+PprHiZPgTv1UdmY=;
        b=SWrOrpw5uKmqcBPCvrBhHu1PyG8vxX6ayUSmr6FSEcN5NBDgFNZpuvnw8kvtha/eMv
         77Hu8eFVPRJLxoxT3EGPGGS/y8tHC26s2WZmegu+OVoLEfIGhYmimDYP11RIjQIrpR30
         LCg1DjcOXr82nahvo5vS/zWXg03PNhtz8KNGsxSLI1UTWzNDkJzc7AUoHlMjezsphFiq
         9O69haP+8F/uchGUzUX6pcaDyFBeXoJj/zOxePNcFdvmGZN2uhm/ayVe0UJbFXfERu2a
         DnSgp5v1zWdlPN1zI4h9mfdI5k0s8ugVZyUk5ya2qdNwVDj6OQ0zWA5hV/1lpuVHvuSK
         PzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616819; x=1781221619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P95+fYJ3vYLC521V0/dnSJW7Xac+PprHiZPgTv1UdmY=;
        b=GYUTN3kznhvEwsnAqtWc2w7oPSKFP5t3urPD8/x3JMYITQLMPn8SxlYpycr2gKGGxt
         ADCgD6wUGY2MrG6QimqUzAbyGFT2T/yY4tPPgS9uY2qQTD95+aRSHjw0nn9uI029mxOT
         hiusi5vORhSNHYRUDjoouBeXl/gF6Dle6lXEuM8kUIKoxz5pP3KfvNWBQV7ZC3tqvFGc
         Dxc2I4mWvDLItn9r0d1kRhTnIUdjPbKqVXArsJqdd51AJqPcLcciPxY2oKx7CUEQvGz0
         SFXYGy77SeC98mJGr5zEXnJFTwuIudaOyTh110fAJoaQObnV7x56D0uup4ruJ8NjXoIs
         YCyw==
X-Forwarded-Encrypted: i=1; AFNElJ/tOVzcbWIkI3KPRdl9yNDNM5HhW7XOg6aGLE9A5pLNWq9T9qTtSuRgxhZLxvr3AaFv5N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXg4jI4BlQsdCe+dlrJK/WIqM1epNkZuwLN2k5o5iARcR7AVl3
	NQoMeEEA+XD/cHuzV/MgQZNkXupOsuaZvQgSvTPry/Sk0mZtRHonHAUJJcxOS3O4TLFn0ok5rS/
	2QLoJOk9FI/vt8nlynWszSayWwWBhqFeziOOfJm/tBMIduOJzLF8rbw==
X-Gm-Gg: Acq92OHrjB2ghTCHih9JpkSQNkNMdy9ZkxYhOl+NaG5A3I4b8LSKgz03Zw/1IFLqVVA
	TSILZ1u4fPcChvrx3OqspkTP/pl36fUmz4IZdZ/nMUeLMy5zYKT6Pnl8bwhlAI2PXpHI2vk+dAC
	qvqKXY2dibkNksqEWe/8Aelm8aIvHT/vM4eV6MQrY7PxqQrP4vHE0BNWIkUwKgCuRtqjg5EYpfj
	94sY6E46cXkuxtqNTpa+H/y+pMjLMbMuAca6opZ3OkeDs1f3/FYWoIaBcXlLfOzHJHq/lEVILCG
	VYIv3rc0jAJwzJy74z0iHOF1Kas8o6hku0OoHHqnq3CU7/4PxzAb5zmhJGelLa4qyrVLmb4Jp85
	1xngl+y+HStjT5rF9NVBRfLn88wc2w1kmoILv/e2hebntOrVXTykBKgs=
X-Received: by 2002:a05:6000:4b01:b0:45e:739b:2750 with SMTP id ffacd0b85a97d-46032b82296mr255384f8f.9.1780616818707;
        Thu, 04 Jun 2026 16:46:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4b01:b0:45e:739b:2750 with SMTP id ffacd0b85a97d-46032b82296mr255353f8f.9.1780616818258;
        Thu, 04 Jun 2026 16:46:58 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm19912888f8f.37.2026.06.04.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:46:57 -0700 (PDT)
Date: Thu, 4 Jun 2026 19:46:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Message-ID: <20260604194613-mutt-send-email-mst@kernel.org>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>

On Thu, Jun 04, 2026 at 12:21:15AM +0530, Garg, Shivank wrote:
> 
> 
> On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
> > kvm_gmem_get_policy() sets *ilx to the full page offset
> > (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> > offset on top of *ilx, so the offset is counted twice.  This
> > causes NUMA interleaving to skip nodes: for order-0 pages the
> > effective index jumps by 2 for each consecutive page.
> > 
> > The get_policy vm_op should return only a per-file bias in *ilx
> > (like shmem_get_policy does with inode->i_ino), letting
> > get_vma_policy() add the page-offset component.
> > 
> > Fix by setting *ilx to inode->i_ino instead of the full page
> > offset.  The page offset is computed by get_vma_policy() in
> > mm/mempolicy.c. The full offset is still computed
> > in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
> > shmem_get_policy() follows the same pattern.
> > 
> > Found by Sashiko (sashiko.dev) AI code review.
> > 
> > Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  virt/kvm/guest_memfd.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 69c9d6d546b2..0bcf6fc08e2d 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
> >  }
> > 
> >  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > -                                            unsigned long addr, pgoff_t *pgoff)
> > +                                            unsigned long addr, pgoff_t *ilx)
> >  {
> >         struct inode *inode = file_inode(vma->vm_file);
> > +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > 
> > -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > +       *ilx = inode->i_ino;
> > 
> >         /*
> >          * Return the memory policy for this index, or NULL if none is set.
> > @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >          * can then replace NULL with the default memory policy instead of the
> >          * current task's memory policy.
> >          */
> > -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> > +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
> >  }
> >  #endif /* CONFIG_NUMA */
> > 
> > --
> > MST
> > 
> 
> Thanks for fixing this. LGTM!
> 
> Reviewed-by: Shivank Garg <shivankg@amd.com>


Can u actually test it though pls?
Because I think another patch I sent in response so Sashiko
is also needed.

> Best regards,
> Shivank
> 
> 

