Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED9399CED
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268976; cv=none; b=hHuHhMmwR2+jocaExGin0wSTy7yQCu6KnoWSQYt3lodoFdv0ek3miLHPwuw/AQqnv4VyMl3GIDc+R8IH2jpjMdWwuULU9/gbbMApzs1ejCq0v49xNmMPLisAVzNlW57hO1qo2A46ni4UXhizlmXQEHsdxF7Gb10utU0Jqh1xU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268976; c=relaxed/simple;
	bh=mUhbrxi5Wl4bcx3T2WtFkFet1O+S4n63de4seDdAqcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8DJPfoDBEkR6zQ5sxZ8rpd2c4BpzEV+jbY01UPnKIl44hq0l240i/Slnb5JtXa3Gq5wi8Mi//b0oXNAsmoEHQa0CXzDUXA7BCBwvgbdaDd36N5cX4gtJFo+lwV5UORvGlvPLCK1Wtdp6I2CgPaVO9oIC8n07Q2YTttsL4AnfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0UcMIeE; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0UcMIeE"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so358172a12.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787268975; x=1787873775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FsF+dC/ofr8sxGFtHAB/t3yjlu1tenoFlMvm24uheM=;
        b=X0UcMIeEYzE+HvGzuIO4GobeKkhKoDXut+KKSgEe8UWa7rVRTNfqkSUZoPfgUUIBce
         KIx97fFwd83HKGqulmY4IKmVUwpcznDYPMBH/zBgHzU1qqGsPaJdpLtV1VxqfPlAZgCT
         /HMxyhCdU9D2kIK3JFOKelctrzrirDzAKlFuRzdVSSn0WmiMhTFEWhYihzfo0AvmAkzB
         WOCHxq48JgrG0VcxCVA56b/QP7LmM3xhVxDHMsJa7j5x+i9yly2fI7dFsNvugFlcLVsN
         AmPtYWeFj2pzgzjn2JyKOcyog9iElzRg4e+IkiXtuWWf5gIUST5Nj49Z4iaTPU641qGT
         Wpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787268975; x=1787873775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FsF+dC/ofr8sxGFtHAB/t3yjlu1tenoFlMvm24uheM=;
        b=eq6Ea7e2RrF+E7KcnVHMKd+n3Y57rXCwsF8O2KGcXFgY4ebA4AHM8LpDL4H/gvqeX+
         EQbQ/mfQp6da4/O1Qv40O4mxcg55fTZOrBfURIhBnjPY8ltWY2Y38Jymcr7UOC6q8fW9
         wqfdKlfmLRxPDlHOi+tPrr/1MQxhdf152Agwi3TWJZF0z6fBuzD3Xqlj4xYxkzTaCLT1
         /xuDE805o6xjgd3T51W9oflqbi7vy9Nkmv5eNPWqt1RoXyGdfm1PFJRZkMkL6AK2d/QE
         UwtG2GEvB8BKIMNAtWSnDWvbzbhINdcnyMCOKwmM0KxO2+SlhGFjVPpb+Q5lKqDaDhs3
         7oqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzXr/S2ElI0gjTeea1CJv+u5kIsHWkoqsRsA+IrZ5npTTUBrsmHY9C4rItU/2vbpshegw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJ1Id8Q3V0lUz+0Vh+qMZOgbnx1Pzig4cZUaaxI6BfDyExmE2
	j1JC2dxfDAjSd4oEtnebzLNgQZL9ub+psT7838FE3aqYsMmPkZUxKLvBnclO/TiBO4bBOV4Yhuh
	e9TiaXg==
X-Received: from pgmj16.prod.google.com ([2002:a63:5950:0:b0:c97:228f:37ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6001:b0:3cc:fb7d:a9ab
 with SMTP id adf61e73a8af0-3cd2fd8e99emr4211436637.2.1787268974429; Thu, 20
 Aug 2026 16:36:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 16:36:13 -0700
In-Reply-To: <7kapvdum7qk7l4epbeqvrybqxapuhvwltz7axfprxldw2utozh@t4url3mqbpom>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-2-5298f42d49bb@google.com>
 <j6bfvbzjivlcsu3slbnaoomxxqyypmfl2bupo3k5ipnt6fc5lo@e5ntbx7yd4qw>
 <CAEvNRgEruoa4d_8Y1MpkdzbHg3j1Yv=-Y6w6Yy=v6mJgPajjWw@mail.gmail.com>
 <zb5krzhrg3soslplynegqo52brd53wk3meas45udqpjms6oluk@zecqwzn7zziy>
 <CAEvNRgEHEE67+vjQqJjYD3M4yuwuR+4-36Hw4-sp5caYzmxbkQ@mail.gmail.com> <7kapvdum7qk7l4epbeqvrybqxapuhvwltz7axfprxldw2utozh@t4url3mqbpom>
Message-ID: <aoePba0sbVFzUl_9@google.com>
Subject: Re: [PATCH v2 2/4] KVM: SEV: Drop page refcount early during RMP
 fault handling
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 20, 2026, Michael Roth wrote:
> On Thu, Aug 20, 2026 at 03:35:31PM -0700, Ackerley Tng wrote:
> > Michael Roth <michael.roth@amd.com> writes:
> > Ah I see what you mean. I think we mean the same thing, let me add to
> > the commit message that I meant after dropping the refcount early. Does
> > this help?
> > 
> >   The filemap_invalidate_lock() is already dropped in kvm_gmem_get_pfn()
> >   before returning to sev_handle_rmp_fault(). After dropping the
> >   refcount earlier with kvm_release_page_unused(), these scenarios are
> >   possible:
> > 
> >   1. Since the filemap_invalidate_lock() is dropped, the page can be
> >      truncated (or in future, converted), and the RMP entry is now
> >      shared.
> > 
> >      In this case, existing RMP table handling (psmash and checking for
> >      errors) would be sufficient. On finding a shared entry, psmashing
> >      would fail gracefully and no warning would be emitted.
> > 
> >   2. The page is truncated and freed, and then re-allocated to another
> >      SNP VM. The RMP entry is now assigned, but to another SNP VM.
> > 
> >      To address this, adopt the MMU invalidation protocol to guard
> >      psmashing.
> 
> This reads kinda weird to me, as if with #2 we're documenting a "bug" that
> this patch fixes, but the bug would only exist if we partially applied the
> bits of this patch the drops the ref counts earlier and left out the
> bits of the patch that introduce the mmu notifier logic that replaces it.
> 
> I think with patch 1 applied (which covers the
> psmash-a-now-shared-entry case while retaining the original refcount
> logic), the only thing this patch is doing is replacing the elevated
> refcount logic with the MMU invalidation logic as prep for dropping
> reliance of refcounts entirely.

(I had already typed this up before I saw Ackerley's response, so dagnabbit I'm
hitting send).

Agreed.  Less is more in this case, unless you want to explain all of the gory
details of how KVM handles MMU invalidations.

  Rework KVM's handling of RMP faults to rely on MMU invalidation logic for
  safety, instead of the current approach of holding onto a folio reference
  until the RMP operations are complete.  I.e. drop the reference gifted by
  guest_memfd immediately after getting the PFN, and instead do RMP updates
  under mmu_lock, after checking for relevant MMU invalidations.

  This will allow dropping guest_memfd's reference gifting entirely, which is
  ideally how KVM would operate for all "follow PFN" operations (GUP has many
  more complications, which is why KVM holds a reference across page faults
  *on top* of the standard MMU invalidation logic).
