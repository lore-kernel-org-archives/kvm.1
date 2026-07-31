Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D448988E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502669; cv=none; b=PurICLCU3YR4y8MYZ1ba3JkaqnbstDiR3RCb5Gw7OjtXxSJuzdGH9Q4eleRkQmnlnzqdiSh4MmHr4z5XdUmnThJwfuz0Ma0tFZysuGBhg830TvZc5p0ttim8Hm6MzZB3rPAZ9ExA+vgRikkn+HzfGz5KuTcKEVskyhewoskfmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502669; c=relaxed/simple;
	bh=Qf+YMuIQNVyb8s5FLB+yWhk0qzi57BBRwHsHNMzFjXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sS9OsYUixd8gsmXjoLP/JV3+Br4aiCCnq2VuX5mhrEJTa3rnkD+GwPH2eMyzBAqFTHqxoD9YVoh5/RlCtOeS9jODwMLHkI4CtRZMV0KIvuDmBa7ezhplqHKzmreB61/9d46h1/l1HUxhUXUikPdFOlIMySPaKrttMX7tPH6xeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVyLAm2x; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVyLAm2x"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso942671b3a.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785502667; x=1786107467; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+MYtEuS2vtFWuFLVJK+8nkcZ8WpqUgMlXXAQz8N1+I=;
        b=uVyLAm2xZZPdIlDrFsaM46p7AuBOf1B1SiNwDTWxOFodHqnegDNb+DMCJ+kSFwYawB
         czYgauqgdsZyhfd6SkqVlQETaY+hcNTanZIAfDOPFGU08E2Doz3cG3S3Vy5DgBRCDEu8
         cwdpCkp33iDF1GbiWRyYZvsCXurbxmGix5lt8ecwKtt0wVKb4Mu7PGQdwYmTYVp0utoY
         78PsR6jKT1TtaGTwOmAjnICCo/BmHhisYsqjjVHfmbrEclFcptH+Tt4Cyhn2rvWEFhuK
         An0mJlMvNl25k5u6MompWwAqUaVatlaFeifWU2XDgRAe33iRUxFdp3bhT4aafwnZHv8T
         JQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502667; x=1786107467;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+MYtEuS2vtFWuFLVJK+8nkcZ8WpqUgMlXXAQz8N1+I=;
        b=eZXeXnFY0EDUc3E078Q6DMxm0/tnoJFVrFmWD0m97q3A+jCyUnMyI94qZD2EM8IplY
         NxmWAZZi2U3zZUoPt2UwbCUugp9KC+4jThxyVGDnHMJvSkuXWVZUSQWrQohx9EJk6Tzq
         6aRdrAHODgbkM1SS06yoP4wsFvifd/CsuP5GEmB+WCoG327e3LL+lXTr3bWNJXq+8ujU
         vjazWSemXVDktOnSprY3dj9sGth/kAozee4yGoqn21ZKsfP4QxCQaagiS+U5jaqMEAko
         rpwJKWg9JLrFRkWeXXtQE/JXzV1Qyr+XBDmj/9HoU4Ra6CyxfEIcJL9TjA+V2mhdPxVa
         IOSw==
X-Forwarded-Encrypted: i=1; AHgh+RqtDESKuzIWDfszkYlDEom6gO63pWo6wYT8QU7ayt3nmVcIJ8+Z96+klwURnVRGUVwNp8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MNHmcSOeFIC5fZ63qjbtXXcdWC8KaqrqdMOo0GFsoPsqQr/v
	VCWk2vrBWF4DlFr4E3iXfh2dx2fSy8YvUTbJft1twCF1kOXmYLPy4wodGHO90BSk8anh87gMJCz
	iVInMMg==
X-Received: from pfxx18.prod.google.com ([2002:a05:6a00:112:b0:847:a13f:28e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240e:b0:847:712d:19ac
 with SMTP id d2e1a72fcca58-84ed6d4b3aamr1665328b3a.8.1785502667024; Fri, 31
 Jul 2026 05:57:47 -0700 (PDT)
Date: Fri, 31 Jul 2026 05:57:46 -0700
In-Reply-To: <CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729072044.25796-1-slp@redhat.com> <amuKVfib5kela8AD@google.com>
 <CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com>
Message-ID: <amybygGUiPlbiDE2@google.com>
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
From: Sean Christopherson <seanjc@google.com>
To: Sergio Lopez Pascual <slp@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, Sergio Lopez Pascual wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jul 29, 2026, Sergio Lopez wrote:
> >> After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
> >> mmap") was merged, a guest write to an unpopulated PTE from a mapping
> >> backed by a DRM GEM BO triggers a VM exit with EFAULT, with
> >> hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.
> >>
> >> This happens because that commit implements pfn_mkwrite for
> >> drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
> >> returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
> >> entry to be installed as read-only. This is done on purpose so the
> >> fault handler gets notified when the entry is going to be written.
> >>
> >> In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
> >> fault handler but, as seen above, this one might install a read-only PTE
> >> even with FAULT_FLAG_WRITE present in fault_flags. The check at the end
> >> of hva_to_pfn_remapped notices that the entry is not writable despite
> >> this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.
> >>
> >> To address this issue, have hva_to_pfn_remapped issue a second
> >> fixup_user_fault call when needed for write-upgrading the PTE.
> >>
> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
> >> ---
> >
> > NAK, this doesn't belong in KVM.  Expecting callers of fixup_user_fault() to
> > retry a FAULT_FLAG_WRITE fault on *success* is absurd.  Either manually do the
> > retry in fixup_user_fault(), or return VM_FAULT_RETRY so that KVM will naturally
> > retry.  I assume the latter is the correct approach.
> 
> The issue goes beyond fixup_user_fault() behavior. If we're faulting on
> a page which already has a ready-only PTE installed,
> follow_pfnmap_start() returns success, fixup_user_fault isn't called at
> all, and we're still hitting the "(write_fault && !args.writable)"
> condition, setting p_pfn to KVM_PFN_ERR_RO_FAULT.
> 
> Without this change, KVM can't deal with VM_PFNMAP vmas with read-only
> PTEs installed.

IMO, that's a bug in the APIs.  If a normal #PF handler looked at a write fault
and decided a read-only mapping sufficed, that would be a bug.  I don't see why
this is any different.

And if KVM has this problem, so will other users of follow_pfnmap_start() and
friends.
