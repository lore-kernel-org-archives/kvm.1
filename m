Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DD25B08E
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787265336; cv=pass; b=dNyLK/+h0NNuPkOIcffQJYYfsPXWkl20g2nPiHszQNfo8hi7t2MW3fXlvgcA28eGKAJLESB9RB0lWtLpJThiRsgl3oykNSmT+kTgeXq5owRcR56EKH+oRtCkIMd5/XQstvxoHEmLvO45McpVhNeLt9HLE7a+WClP7qwS4/+G240=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787265336; c=relaxed/simple;
	bh=88UtQ2NJEocC70tkZ7mM0N57DjBU7D9YDSEXq/qc3yg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZbqdMIrYi7OnVHXu/BF+Z3TuPGE93ngEWUfqpdqhunJw9M2e+RyRIGaPlZALVnaoW8HJ1z2m6oK2dCcodx4bQVj2RSR+8kBBWB0+s0b2sYaaMIrpashT166YyJ4k3rgfblzFUEYok1kXBmkBTcBJi+5bf73O8rBaap2oJJOoX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKVjSnQd; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKVjSnQd"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c4436d02cso2016521cf.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 15:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787265334; cv=none;
        d=google.com; s=arc-20260327;
        b=ZeQbjPBy5qqKr7PAZlxWrbPKaCpX0mZsVTCDHTvWvfvc5SV89tfYEB4Y16E2FaErze
         cdDi1NzGk10m/F57qumqdxLK7jN+NUZB5k/arCblFygd83PtzrIwWVZW+l9+1JV90+iS
         mmjtl6KqQvyIG7z8P7r/77OBTZr3NEYgE1oJKKJNaOWJXnvDqxX0Xt+/aqqe9/CqvkmS
         GvX9Cwk4SIrTdxy5dubLdE4/H8gtSeK71Br/LuNjPVrWf7HAyfUNPAYzasCt8kiiNOEc
         bR8y4nHloSDcAemOEkw75EWzNr07sK1qtUxd2gUmB1aRiLEzsPI/kmPKzX+OKky1lGC8
         +Lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=keAmPabRaMdcX1QNc/BNoLOz/4Bjfzbm/F1rysZ+lHU=;
        fh=Z7gYblnKExv55lQkAlhkZ24p1B0EWOaq0j0X/ua/rXI=;
        b=NZgzSH6Dy9rpykGkOBoJmB2TkLrZA2ICJlnvnta2gM8KPXxAZFuO0qwC9dQp/UOzbz
         Gj2mdE7oT8H/Ug9oTcRu6PVdHtoJWpjXiws45wWBs6IBeCAa1nDZses+n9JmgC1HcEWC
         yTMupqqo7T3fkN2sWSXbYteFt4aQy1bnqQtkiT82LkIP3g2y6O6YFGSiLPmiO4zENiey
         Wp/S3zovF0vbMvFzoIF9JMfRbhzHfLDm6qmFN1Qe8VM7Z46b9dQtqPUuc24CrVBLwQee
         rjIITmxDIiGEWDKcOs7c01IXL09gfhquiEma7GC89GX+q4bhu0DVKqXKBmQTDNj6uPiT
         v4Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787265334; x=1787870134; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=keAmPabRaMdcX1QNc/BNoLOz/4Bjfzbm/F1rysZ+lHU=;
        b=nKVjSnQdfQBd6snCJ8zO3fa6pA+OKlf0BSHvi543L3bWUUI4+WH2gxzQF6WWuWJA9o
         cCe3QiP+g/9I5s33D9Eezqh7l7Mjr5L68Hf/ZB0BUogycHYSFMf07f8lb1wTAw25AXQ6
         NHoUdFgQx2N0G6XaQ02YmQzz3A+uoTt7D6po00Q9GVEWrGY/H2lJBF84IUKHXG5wZ32x
         yLnQaTLFmXOHnGuhjDlETDxUMVS1WZMQ39juAm52MwKXpreQSUyGPCJUaf1/tEBbzH3W
         0lEZusePi/cAcz0T5dvxbLzLLPE7z+ZPirVhraKMBJSkyyjBGysABpXPxK5Ph4pGMxsA
         mXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787265334; x=1787870134;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=keAmPabRaMdcX1QNc/BNoLOz/4Bjfzbm/F1rysZ+lHU=;
        b=De0gMkiwLSaaHW/53mEetmgmTl1bTR3Oy3csYDMRaP5CGrEG0yQG7ZvNM09q18iFA8
         BGUwfKHa9qgXkUylljak6byNqgMcfiF+f9sX5QKuln4dLgcqzhZCNXSlShiFDf/CAtVS
         +IC3rl5/1SJPiuV041b1av6HohcwlE07/pqTZB+PzvHejNGI80FpwFzn3qxwLBgthEwT
         KUydlOPZQh82UFyIdXFSvUIUXuar6l1jgUf6FBN6bxCd/ItpIey4N5CK4JKf234jw4Zg
         bQSQR4kPxhbVXlye5A6vtIkU/km/xEPO+EvG9yb6oDkZFfwCmb+qT53Y5Rh8J6pK0zol
         SpmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSu5Xo5Cs/MO7LvoYeOqbCzi+I7jcC8jglvXDl91Hvn1sxe2cJK54gA580sVuMgJBZPUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwofEPCUZjF0/hJx4j8Fa6atewJ9XnVKhRlyY28XezuA4P/vGBC
	Wy49rO1KLNEdFWm4GP4FdOStvZqMYtwdKKP3UZpqFybhyJvtIyPtI+DBKj/NPEj/5pqjhiGGWES
	knLKLKBFrz/4CloqGlrY8ooz5/zCzL5zZSbfKqKmC
X-Gm-Gg: AR+sD12uqelUAh8EpADL6CS1QAnNpyDeTs1vJoTJZdU9c9tL/PQt6Ocyl7nJCT/gVIX
	zmc154Z95ei8Fi+l6sKrl5K0QMf/9aofwVw8AaCY1izryJ3txkp3j+ukV1LC8wvZfr6Sr5lAvEc
	s/J3B6DbIBp3T4GzCe6vy5G9T+/6QnC2puL6jb/bHSiV/K98annsB4jMp52Y90CXo9GC5MPXtFg
	SbpYNMUdIIODgwQtNP+6eMRJ3wNlrp5jivy+fzuNWKn1vBGb8pTqhn7jbl/PkNjtHgfU9Bzi+7i
	wSDAlhCDJdg4MvJeG3cAbDqOTt5RPz2kpvGN1hhjYrv1nQxJD5kqJcxHkLIaeWIlVAvBOwFGQu8
	UtcY=
X-Received: by 2002:a05:622a:1ccc:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-52df5a07b4cmr19910241cf.21.1787265332903; Thu, 20 Aug 2026
 15:35:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 15:35:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 15:35:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <zb5krzhrg3soslplynegqo52brd53wk3meas45udqpjms6oluk@zecqwzn7zziy>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-2-5298f42d49bb@google.com>
 <j6bfvbzjivlcsu3slbnaoomxxqyypmfl2bupo3k5ipnt6fc5lo@e5ntbx7yd4qw>
 <CAEvNRgEruoa4d_8Y1MpkdzbHg3j1Yv=-Y6w6Yy=v6mJgPajjWw@mail.gmail.com> <zb5krzhrg3soslplynegqo52brd53wk3meas45udqpjms6oluk@zecqwzn7zziy>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 15:35:31 -0700
X-Gm-Features: AcwNN1VgRdjzQciaY8CryBJfmg5HGuqOzIWFzcFZzObegOXkA-aa77jVpFBsdqg
Message-ID: <CAEvNRgEHEE67+vjQqJjYD3M4yuwuR+4-36Hw4-sp5caYzmxbkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] KVM: SEV: Drop page refcount early during RMP
 fault handling
To: Michael Roth <michael.roth@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

> On Thu, Aug 20, 2026 at 07:58:19AM -0700, Ackerley Tng wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>>
>> > On Tue, Aug 18, 2026 at 09:15:53AM +0000, Ackerley Tng wrote:
>> >> From: Sean Christopherson <seanjc@google.com>
>> >>
>> >> When handling an RMP fault, KVM retrieves the PFN for a private GPA from
>> >> guest_memfd.
>> >>
>> >> Drop the page reference immediately after retrieving the PFN instead of
>> >> holding it across the entire handler so that the later patch can follow up
>> >> with completely not returning refcounted pages from kvm_gmem_get_pfn().
>> >
>> > Regarding this point:
>> >
>> >>
>> >> On a first look, existing RMP table handling (psmash and checking for
>> >> errors) might seem like it works fine, since truncation of the page from
>> >> guest_memfd would have called rmp_make_shared() and removed the PFN from
>> >> the RMP table. However, that is insufficient since a freed page may already
>> >> be used in a different SNP VM.
>> >
>> > In the code this patch is applied on top of, I think the kvm_gmem_get_pfn()
>> > ref is enough to avoid the reused-by-another-SNP-VM scenario until after
>> > caller releases the ref, so I think the above explanation should be adjusted
>> > to also be preparatory for "the later patch".
>> >
>>
>> I think this sequence of events is possible:
>>
>> CPU 0: sev_handle_rmp_fault()
>> CPU 0:   kvm_gmem_get_pfn()
>> CPU 0:     filemap_invalidate_lock()
>> CPU 0:     refcount++
>> CPU 0:     filemap_invalidate_unlock()
>> CPU 0:     refcount-- <<== because kvm_release_page_unused(page);
>
> Prior to this patch, the kvm_release_page_unused() isn't done until
> after the snp_lookup_rmpentry()/snp_rmptable_psmash().
>
> It's possible CPU 1 truncate sequence below can run concurrently
> after filemap_invalidate_unlock() above, but even though it calls
> free_folio(), which might zap the RMP entry, the filemap code will
> only put the refs that it has on the folio so it wouldn't actually
> get freed back to the buggy allocator, so it doesn't seem like the
> psmash-another-guest scenario is reachable. I could certainly be
> misreading things though.
>

Ah I see what you mean. I think we mean the same thing, let me add to
the commit message that I meant after dropping the refcount early. Does
this help?

  The filemap_invalidate_lock() is already dropped in kvm_gmem_get_pfn()
  before returning to sev_handle_rmp_fault(). After dropping the
  refcount earlier with kvm_release_page_unused(), these scenarios are
  possible:

  1. Since the filemap_invalidate_lock() is dropped, the page can be
     truncated (or in future, converted), and the RMP entry is now
     shared.

     In this case, existing RMP table handling (psmash and checking for
     errors) would be sufficient. On finding a shared entry, psmashing
     would fail gracefully and no warning would be emitted.

  2. The page is truncated and freed, and then re-allocated to another
     SNP VM. The RMP entry is now assigned, but to another SNP VM.

     To address this, adopt the MMU invalidation protocol to guard
     psmashing.

> The psmash-a-now-shared-entry scenario because of a race with the
> VMM/truncate path seems possible prior to this patch, but that's
> pretty similar to the psmash-a-now-shared-entry because of a race
> with the guest scenario and which would generate spurious warning
> messages to console, and that would be similarly addressed via
> patch 1 I think. I'm not sure
>

Yup. I like your psmash-another-guest vs psmash-a-now-shared-entry
classification.

> -Mike
>
>>
>> CPU 1: truncate()
>> CPU 1:   filemap_invalidate_lock()
>> CPU 1:   refcount--
>> CPU 1:     kvm_gmem_free_folio()
>> CPU 1:       sev_gmem_make_shared()
>> CPU 1:     folio is freed
>> CPU 1:   filemap_invalidate_unlock()
>>
>> CPU 2: in some other SNP VM,
>> CPU 2: kvm_gmem_get_pfn() gets the freed folio
>> CPU 2:   sev_gmem_make_private()
>>
>> CPU 0:   snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>>            <<== it's assigned but to some other SNP VM
>> CPU 0:   snp_rmptable_psmash(pfn);
>>            <<== this psmash would be smashing in some other SNP VM
>>
>> And hence I think we do need to check for invalidations using the MMU
>> invalidation protocol.
>>
>> > Other than that:
>> >
>> > Reviewed-by: Michael Roth <michael.roth@amd.com>
>> >
>> >>
>> >> Hence, adopt the MMU invalidation protocol to guard committing anything
>> >> based on the PFN.
>> >>
>> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> >> ---
>> >>  arch/x86/kvm/svm/sev.c | 39 ++++++++++++++++++++++++---------------
>> >>  1 file changed, 24 insertions(+), 15 deletions(-)
>> >>
>> >> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> >> index b2738362a928b..b34b11d7f8fad 100644
>> >> --- a/arch/x86/kvm/svm/sev.c
>> >> +++ b/arch/x86/kvm/svm/sev.c
>> >> @@ -5003,6 +5003,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >>  	struct kvm_memory_slot *slot;
>> >>  	struct kvm *kvm = vcpu->kvm;
>> >>  	int order, rmp_level, ret;
>> >> +	unsigned long mmu_seq;
>> >>  	struct page *page;
>> >>  	bool assigned;
>> >>  	kvm_pfn_t pfn;
>> >> @@ -5030,18 +5031,22 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >>  		return;
>> >>  	}
>> >>
>> >> +	mmu_seq = kvm->mmu_invalidate_seq;
>> >> +	smp_rmb();
>> >> +
>> >>  	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
>> >>  	if (ret) {
>> >>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
>> >>  				    gpa);
>> >>  		return;
>> >>  	}
>> >> +	kvm_release_page_unused(page);
>> >>
>> >>  	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>> >>  	if (ret || !assigned) {
>> >>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry found for GPA 0x%llx PFN 0x%llx error %d\n",
>> >>  				    gpa, pfn, ret);
>> >> -		goto out_no_trace;
>> >> +		return;
>> >>  	}
>> >>
>> >>  	/*
>> >> @@ -5069,27 +5074,31 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >>  	if (rmp_level == PG_LEVEL_4K)
>> >>  		goto out;
>> >>
>> >> -	ret = snp_rmptable_psmash(pfn);
>> >> -	if (ret) {
>> >> -		/*
>> >> -		 * Look it up again. If it's 4K now then the PSMASH may have
>> >> -		 * raced with another process and the issue has already resolved
>> >> -		 * itself. If it's not assigned, then this must have raced with
>> >> -		 * another process that made this page shared.
>> >> -		 */
>> >> -		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
>> >> -		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
>> >> +	scoped_guard(read_lock, &kvm->mmu_lock) {
>> >> +		if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
>> >>  			goto out;
>> >>
>> >> -		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
>> >> -				    gpa, pfn, ret);
>> >> +		ret = snp_rmptable_psmash(pfn);
>> >> +		if (ret) {
>> >> +			/*
>> >> +			 * Look it up again. If it's 4K now then the PSMASH may
>> >> +			 * have raced with another process and the issue has
>> >> +			 * already resolved itself. If it's not assigned, then
>> >> +			 * this must have raced with another process that made
>> >> +			 * this page shared.
>> >> +			 */
>> >> +			if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
>> >> +			    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
>> >> +				goto out;
>> >> +
>> >> +			pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
>> >> +					    gpa, pfn, ret);
>> >> +		}
>> >>  	}
>> >>
>> >>  	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
>> >>  out:
>> >>  	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
>> >> -out_no_trace:
>> >> -	kvm_release_page_unused(page);
>> >>  }
>> >>
>> >>  static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
>> >>
>> >> --
>> >> 2.55.0.699.gb54405d56f-goog
>> >>
