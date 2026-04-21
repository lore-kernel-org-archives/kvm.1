Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E438422F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814145; cv=none; b=kCdsJgxtP90L0X0bS49W5HIfMED3yh9Qo9S3l+OqnaU7SbhqYhYfGMnQemxrQR97zKxSLH8xcfmEFAOFXLDxoeDJAipCL6EdcEF1yL+kfQcqVey7OBjHeYgAOkeyJTPxCIdb00H7iQM6pkXIWZP/IIEVneFVKRI7St9UTjA6pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814145; c=relaxed/simple;
	bh=5pVjND2zS3BS94LVyguRQfamNNOmirLhH50CvnXpJts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/0MvYgifFWYO3yjZvX0NNg27RY5g7qQXWTHcGwCxpZxOTrAhYHR/nxLZCQDOE3Jb7Xr1ItJH1u4yliaqEHMYn0ebqRNNA8hiZ2MjgVBmaKxPLUOgDls8Z7opsgAZC5HiGnpudGjifqCci3vV+DPeiHPcK1bag0SnJdWiJnDrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huH9MA6e; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huH9MA6e"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f220f1dabso3485530b3a.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776814142; x=1777418942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWZYxE3QD5cUq20TfuzmdK/ApbS+ouPpLPbbjRuSCrk=;
        b=huH9MA6ej5DlDKSI+LFYPw3opqiszPdd82YMyHGedluMVXsQrt7RrZRse8gPDAXsp8
         lzp7bIK0pmSEBxPX8Xp+e+Gq0xJZ2iK0w48tpmAPVn+it8drUBlKep2KVEgPKYcKDZyK
         OOgnHsAeDf22Es9w/kXR/9eGarViHX4bmq/xAg75OLXdQ1HrJhBcKjahN4F2VBAIXUtM
         eQypXqNed/O/6C+ZlfV8fACOXBWnh1jFKNLNKGDM+zjmGoIettQSxVNgbrgcOhAE3qZ9
         FonNkl/3/D8TogdvyLpdbZqJJnW5HdXfVSlhbGkQG4Edqcmd3xmePxdY+4pfiJ+LKqZA
         ANaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814142; x=1777418942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWZYxE3QD5cUq20TfuzmdK/ApbS+ouPpLPbbjRuSCrk=;
        b=YDCVEflSJeqve2TeHXa2EykRBfdZ6J7XhUaiiD31iR+Rg6967+UMRMzlewkKqgJ2rQ
         3kpp0dCI+bn0NjhPq2PhoU4I4wccQq2ZsKHwTVl32Bw7rqNlKpCJnyuIuD/m49pPBQ10
         rz/nD30bfo2SJDtYxPEku0Q68uDIR0A0TPMNfGWKo/SOwP8S5ZEvI9t+lV4mH7lNQ5SP
         izWqxMu2gNP3REKj8b74JtY/jj54Wz1Ou9xzlXiq+5vmixceOjiGX987MGboNKhngYQb
         JBSKV4o+PnUzeN2kZvg4YVu3S4XC/85NTjRodiKoZycOhbqTsKdZHLndXoiiWLYRtNCM
         3/WQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Taeg79V0WB9WNZVV0TtCLwAQU4ULcVHKS7UNHiexXTv9gTsmbnCV1f2YfntMFG49SJ5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fKMCTEew4d45imxT9IkTT33SXHLbI9ig75Avo8HGIv1dpdfY
	LGQbxJ2me6OI7PxbrVE1l7ToNAoCFHogNQ5N4Fgz4l3C4w2C4ryg1mFl+mVS/I+WkRVyg8F/BcX
	IWnJ19Q==
X-Received: from pfve12.prod.google.com ([2002:a05:6a00:1a8c:b0:82f:6a57:a9aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2889:b0:82f:4d2e:5a9a
 with SMTP id d2e1a72fcca58-82f8c8c5b8emr20478533b3a.29.1776814142280; Tue, 21
 Apr 2026 16:29:02 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:29:00 -0700
In-Reply-To: <aegF59gToidudIUC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com> <aegF59gToidudIUC@google.com>
Message-ID: <aegIPGYPH-nxGsua@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > > boilerplate at call sites.
> > > 
> > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > fundamentally GFN-based.
> > > 
> > > No functional change intended.
> > > 
> > > Compile-tested on x86 and ppc, which are the current users of these
> > > interfaces.
> > > 
> > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > ---
> > 
> > I was going to suggest a WARN in kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> > usually hates my paranoid WARN suggestions.
> 
> Heh, for good reason.  Adding such a WARN would be triggered by this code:
> 
>                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
>                         vmx->nested.pi_desc =
>                                 (struct pi_desc *)(((void *)map->hva) +
>                                 offset_in_page(vmcs12->posted_intr_desc_addr));
> 
> The PI descriptor only needs to be 64-bit aligned, not page-aligned.

To elaborate a bit, I'm all for adding WARNs in flows where something bad is all
but guaranteed to happen if an assumption is violated, or in APIs where there's
a history of goofs and/or subtlety in how the API behaves.

What I'm against is adding WARNs because someone could write bad code in the
future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy just add
noise, and can even be actively harmful.  E.g. in this case, ignoring the PID
usage, a reader might look at the WARN and think it's _wrong_ to map a page in
order to access a subset of the page, which is just not true.
