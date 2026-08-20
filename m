Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EC3164C5
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268858; cv=pass; b=NCLo4FJL16KL10jkQEeYjE2igvxHzywCw2NRhJSlkJu4QbRKwisHhTUduRyAK4T8iduKVpPWWNyxChCTACt64+6um0XK5QXJyurr72AnHxPLbo2iEZyo20aZd2ur5x2ynIUldRl54Gu1B/o827b3EOOVA7yB/H5IWehdbMN9UNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268858; c=relaxed/simple;
	bh=j2vJ3RtatjAElJDd5YoRQerg6SFrDWzJGAfiVSg6HHk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvtktae0nBQw7RoVs0lAVTzg9srfBJTQyLGVaETobivQFPKHyxcvUv24HQNHB20P9tJmpKrDtZ9994SiOF2yOw5xdanGdjpY9lHbKVhWnGYZn/y4QDqGTZDSd9dEZvVcLi7rrBh1pbQAO5y1ty+OCyE5CJwgX57FsHRAMZfoXw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2SL9zxm; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2SL9zxm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efb708b1a0so3430606d6.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787268855; cv=none;
        d=google.com; s=arc-20260327;
        b=CoY/pPWvoodMzDCPKD3SnMIrJUTLv8p35Dpzqw3c6LSdBJAVbHSLWrD7/AOzjUQPKg
         rGGGbemgllClQg+xjOijKxPARtHl1Sw4ePdcZHRy6+EVzb9tfdxgxlNhJRztsIbY9EVZ
         tERKCp5/P+tr9CZ36ADFOOy8H56ufeehKw7E2lRW+9WnJNreQ0WN1JQcwQTGv53XWP+G
         ypXOhV2NthP9oziNZxjPvOIXPxHH7Qa+N+ggP8NZ68ufuk9FjrWx4ZlUXdcWUuCBSmLE
         OlmkUFSql7um3dJ5pwrWrC6wOeQRxF81EXmOd27bwYQ6wO78P6EKjcyjgBFc2PY/RILL
         39fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dqgdGAes/vZjiy7MuCsDmVoVgUg9hSFwRvHXcvcjdsw=;
        fh=PrEU0A0mOyQ0Xfln0zlB07u639Acq+hitX7OU/B6QHE=;
        b=cxHnNMUB2lq2iCvaIEaBeWwpjlOVhu+aw+Yj+SsUOYXgpP9jR3yjrTULq1QbY3aTi5
         fggx7ZpXT8nfClsmveWHNgQFkxlceHoeW04761vOzwwBw4F6xp+97eSOM3k1mK7jD33W
         8Q75n6VJ1RF3kkv+SVUYTPntcbONspHoW8+io0pd66mtzZYaMfdZvl0Q51S/xvUddrkA
         1/rSq45/YP+csHhzOGM41fdL0WfJ+gDFAJxxiry9yBsjAfF9+aOg/JnLp62SnHek6Xgt
         OXy+dlzc+9KK291RVv5o5lZ4bDQEuQccWKm5TGussOB4Tsw6B0iFpVJithc6fBum3gZC
         YstA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787268855; x=1787873655; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqgdGAes/vZjiy7MuCsDmVoVgUg9hSFwRvHXcvcjdsw=;
        b=t2SL9zxmAiKVNX6Lr3pWMLsubZP6IFF/psf8QbFoUkXC/Sq38sP5sUM0EWen0epC4N
         72TVAYABQoBL+Y9ARMKqoVXnBzHQRAtbqUN3nNMXzk5bh4J9HS50xa5cgUgI/HQkwv2s
         qNaZ2FZD3YBlLhNtUc9LCJXksxvWBL9ZLJ+pgg9sF+AOvb8X5xbPbbqsTe2L+LcbW9wA
         g4yeFlna6hTDHlVGklVw1UO94GJ46Q12vihIiqwPdyPSwOAGc8svJfilICELPt9laURA
         b7BY1CKlmNyXwa7HOC1p28Mw0hwYAGXl1i859/Z0etmCrBD3HxENA4wYk8gDa1H1Z0jH
         zPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787268855; x=1787873655;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqgdGAes/vZjiy7MuCsDmVoVgUg9hSFwRvHXcvcjdsw=;
        b=ON4DmUEONgfVs1+wFruDpo2MUx9nS2TsUrwJvQeOmAABbtRbZMU0ycCzEcIyAxFC7B
         8fiQhNc2t+TptmVp8FFRsfCN1nAVEl9vYbL95tQaRJtrOi1oL4hpBRh5qPSkSs/fv+4N
         v4J3eNV1bWYocZDmTomoRT4nMc9XhKo22KIxmIzbnzxdJvw3MZ7wkQoY1pKxjq9ijtJ7
         ihhq19P1w1A0rfRNrmTCvQtvp6R6BWJC2Xrj71AImfZc30jz/kzV8TDxmm3eKFB6mplN
         0i4tY2EGzCzoG7oeFBZPAt2SEabs3xyVIs3zg+0V4skVvklXrXNPEsrCoM/Wu4aVuDZ4
         GAcg==
X-Forwarded-Encrypted: i=1; AHgh+RrIdi2n6LP8DBjORswT/teQM/xe3nhHTqhps/ejAUtiM1S3zN4HPVRHWVONY5hxBmo3RCc=@vger.kernel.org
X-Gm-Message-State: AFuF++meZiNEi4+Fw0h+w9T7DdR+yrq+WvF6QH6Iqn2Y5y/Sc97ZCd1z
	/koh9XXtqB38G4WhrSBS0FqV0LcxWWdf32a0ogNob1/amyb2yeWwLr4zMax9wvwtVwyIyIAyp2U
	bmx/ni5T6O21xuUXwezPtWGuw8knSg8+By0BOXnMU
X-Gm-Gg: AR+sD13Swr4nHsv8dTw1/QPbA/KWY1vwMgOnZsbKdc4+EJuKQzZGKhn4hHBrdMt/ns0
	a5G4F5brxhJl+JlDqo2PJTTcSYFuJsjCYmetXUEkIq2jS9hAdc4QQ3lJ5oKAmpj+w6bKMBEMcsL
	OhSs6kxQ0ZDn85t2GKsK6p49Ctbc+6Q1C5fI7YtGqCRLz9KYU4ZxsZrZ35YeyJ7kGhK2/ocMkVY
	rjoSaT2hxlnE16IYlAMkNbaP9WgOI2dLvgTD/arkmXBywggkFjz3BKPBqzYORmrn34ILyp9pC7P
	YIC5jjq7H4ZdkcIWcQI9VkU//EfDzLpr7Or94nnqV7vCODGjstuzthc9PGM7oM9j68ZIK+YiRFg
	CQtQ=
X-Received: by 2002:a05:6214:124a:b0:908:23fd:813f with SMTP id
 6a1803df08f44-90c80c5c0d2mr19422596d6.15.1787268853735; Thu, 20 Aug 2026
 16:34:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 16:34:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 16:34:12 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7kapvdum7qk7l4epbeqvrybqxapuhvwltz7axfprxldw2utozh@t4url3mqbpom>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-2-5298f42d49bb@google.com>
 <j6bfvbzjivlcsu3slbnaoomxxqyypmfl2bupo3k5ipnt6fc5lo@e5ntbx7yd4qw>
 <CAEvNRgEruoa4d_8Y1MpkdzbHg3j1Yv=-Y6w6Yy=v6mJgPajjWw@mail.gmail.com>
 <zb5krzhrg3soslplynegqo52brd53wk3meas45udqpjms6oluk@zecqwzn7zziy>
 <CAEvNRgEHEE67+vjQqJjYD3M4yuwuR+4-36Hw4-sp5caYzmxbkQ@mail.gmail.com> <7kapvdum7qk7l4epbeqvrybqxapuhvwltz7axfprxldw2utozh@t4url3mqbpom>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 16:34:12 -0700
X-Gm-Features: AcwNN1UxC1y3hgXaqd_BMNMsuIls7jzT9HkqjaxXUN2vJgZZQJ3KLiKDnMBj6Ms
Message-ID: <CAEvNRgHCJ9KFW1LFG3HBWBM-5DP+qUZb653802NY3x1fAYwNaQ@mail.gmail.com>
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

> On Thu, Aug 20, 2026 at 03:35:31PM -0700, Ackerley Tng wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>>
>> > On Thu, Aug 20, 2026 at 07:58:19AM -0700, Ackerley Tng wrote:
>> >> Michael Roth <michael.roth@amd.com> writes:
>> >>
>> >> > On Tue, Aug 18, 2026 at 09:15:53AM +0000, Ackerley Tng wrote:
>> >> >> From: Sean Christopherson <seanjc@google.com>
>> >> >>
>> >> >> When handling an RMP fault, KVM retrieves the PFN for a private GPA from
>> >> >> guest_memfd.
>> >> >>
>> >> >> Drop the page reference immediately after retrieving the PFN instead of
>> >> >> holding it across the entire handler so that the later patch can follow up
>> >> >> with completely not returning refcounted pages from kvm_gmem_get_pfn().
>> >> >
>> >> > Regarding this point:
>> >> >
>> >> >>
>> >> >> On a first look, existing RMP table handling (psmash and checking for
>> >> >> errors) might seem like it works fine, since truncation of the page from
>> >> >> guest_memfd would have called rmp_make_shared() and removed the PFN from
>> >> >> the RMP table. However, that is insufficient since a freed page may already
>> >> >> be used in a different SNP VM.
>> >> >
>> >> > In the code this patch is applied on top of, I think the kvm_gmem_get_pfn()
>> >> > ref is enough to avoid the reused-by-another-SNP-VM scenario until after
>> >> > caller releases the ref, so I think the above explanation should be adjusted
>> >> > to also be preparatory for "the later patch".
>> >> >
>> >>
>> >> I think this sequence of events is possible:
>> >>
>> >> CPU 0: sev_handle_rmp_fault()
>> >> CPU 0:   kvm_gmem_get_pfn()
>> >> CPU 0:     filemap_invalidate_lock()
>> >> CPU 0:     refcount++
>> >> CPU 0:     filemap_invalidate_unlock()
>> >> CPU 0:     refcount-- <<== because kvm_release_page_unused(page);
>> >
>> > Prior to this patch, the kvm_release_page_unused() isn't done until
>> > after the snp_lookup_rmpentry()/snp_rmptable_psmash().
>> >
>> > It's possible CPU 1 truncate sequence below can run concurrently
>> > after filemap_invalidate_unlock() above, but even though it calls
>> > free_folio(), which might zap the RMP entry, the filemap code will
>> > only put the refs that it has on the folio so it wouldn't actually
>> > get freed back to the buggy allocator, so it doesn't seem like the
>> > psmash-another-guest scenario is reachable. I could certainly be
>> > misreading things though.
>> >
>>
>> Ah I see what you mean. I think we mean the same thing, let me add to
>> the commit message that I meant after dropping the refcount early. Does
>> this help?
>>
>>   The filemap_invalidate_lock() is already dropped in kvm_gmem_get_pfn()
>>   before returning to sev_handle_rmp_fault(). After dropping the
>>   refcount earlier with kvm_release_page_unused(), these scenarios are
>>   possible:
>>
>>   1. Since the filemap_invalidate_lock() is dropped, the page can be
>>      truncated (or in future, converted), and the RMP entry is now
>>      shared.
>>
>>      In this case, existing RMP table handling (psmash and checking for
>>      errors) would be sufficient. On finding a shared entry, psmashing
>>      would fail gracefully and no warning would be emitted.
>>
>>   2. The page is truncated and freed, and then re-allocated to another
>>      SNP VM. The RMP entry is now assigned, but to another SNP VM.
>>
>>      To address this, adopt the MMU invalidation protocol to guard
>>      psmashing.
>
> This reads kinda weird to me, as if with #2 we're documenting a "bug" that
> this patch fixes, but the bug would only exist if we partially applied the
> bits of this patch the drops the ref counts earlier and left out the
> bits of the patch that introduce the mmu notifier logic that replaces it.
>

Thanks, I adjusted the commit message to focus on drop refcount + adopt
KVM MMU invalidation protocol in v3, please see v3! Thanks!

> I think with patch 1 applied (which covers the
> psmash-a-now-shared-entry case while retaining the original refcount
> logic), the only thing this patch is doing is replacing the elevated
> refcount logic with the MMU invalidation logic as prep for dropping
> reliance of refcounts entirely.
>
> I think if the wording was simplified to just say something to that effect
> it would make it clearer that this and patch #3 are prep for #4, and that
> patch #1 is the only patch here that would make potentially make sense for
> a downstream to backport without the other bits.
>
> -Mike
>
>>
>> > The psmash-a-now-shared-entry scenario because of a race with the
>> > VMM/truncate path seems possible prior to this patch, but that's
>> > pretty similar to the psmash-a-now-shared-entry because of a race
>> > with the guest scenario and which would generate spurious warning
>> > messages to console, and that would be similarly addressed via
>> > patch 1 I think. I'm not sure
>> >
>>
>> Yup. I like your psmash-another-guest vs psmash-a-now-shared-entry
>> classification.
>>
>> > -Mike
>> >
>> >>
>> >> CPU 1: truncate()
>> >> CPU 1:   filemap_invalidate_lock()
>> >> CPU 1:   refcount--
>> >> CPU 1:     kvm_gmem_free_folio()
>> >> CPU 1:       sev_gmem_make_shared()
>> >> CPU 1:     folio is freed
>> >> CPU 1:   filemap_invalidate_unlock()
>> >>
>> >> CPU 2: in some other SNP VM,
>> >> CPU 2: kvm_gmem_get_pfn() gets the freed folio
>> >> CPU 2:   sev_gmem_make_private()
>> >>
>> >> CPU 0:   snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>> >>            <<== it's assigned but to some other SNP VM
>> >> CPU 0:   snp_rmptable_psmash(pfn);
>> >>            <<== this psmash would be smashing in some other SNP VM
>> >>
>> >> And hence I think we do need to check for invalidations using the MMU
>> >> invalidation protocol.
>> >>
>> >> > Other than that:
>> >> >
>> >> > Reviewed-by: Michael Roth <michael.roth@amd.com>
>> >> >
>> >> >>
>> >> >> Hence, adopt the MMU invalidation protocol to guard committing anything
>> >> >> based on the PFN.
>> >> >>
>> >> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> >> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> >> >> ---
>> >> >>  arch/x86/kvm/svm/sev.c | 39 ++++++++++++++++++++++++---------------
>> >> >>  1 file changed, 24 insertions(+), 15 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> >> >> index b2738362a928b..b34b11d7f8fad 100644
>> >> >> --- a/arch/x86/kvm/svm/sev.c
>> >> >> +++ b/arch/x86/kvm/svm/sev.c
>> >> >> @@ -5003,6 +5003,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >> >>  	struct kvm_memory_slot *slot;
>> >> >>  	struct kvm *kvm = vcpu->kvm;
>> >> >>  	int order, rmp_level, ret;
>> >> >> +	unsigned long mmu_seq;
>> >> >>  	struct page *page;
>> >> >>  	bool assigned;
>> >> >>  	kvm_pfn_t pfn;
>> >> >> @@ -5030,18 +5031,22 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >> >>  		return;
>> >> >>  	}
>> >> >>
>> >> >> +	mmu_seq = kvm->mmu_invalidate_seq;
>> >> >> +	smp_rmb();
>> >> >> +
>> >> >>  	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
>> >> >>  	if (ret) {
>> >> >>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
>> >> >>  				    gpa);
>> >> >>  		return;
>> >> >>  	}
>> >> >> +	kvm_release_page_unused(page);
>> >> >>
>> >> >>  	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>> >> >>  	if (ret || !assigned) {
>> >> >>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry found for GPA 0x%llx PFN 0x%llx error %d\n",
>> >> >>  				    gpa, pfn, ret);
>> >> >> -		goto out_no_trace;
>> >> >> +		return;
>> >> >>  	}
>> >> >>
>> >> >>  	/*
>> >> >> @@ -5069,27 +5074,31 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> >> >>  	if (rmp_level == PG_LEVEL_4K)
>> >> >>  		goto out;
>> >> >>
>> >> >> -	ret = snp_rmptable_psmash(pfn);
>> >> >> -	if (ret) {
>> >> >> -		/*
>> >> >> -		 * Look it up again. If it's 4K now then the PSMASH may have
>> >> >> -		 * raced with another process and the issue has already resolved
>> >> >> -		 * itself. If it's not assigned, then this must have raced with
>> >> >> -		 * another process that made this page shared.
>> >> >> -		 */
>> >> >> -		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
>> >> >> -		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
>> >> >> +	scoped_guard(read_lock, &kvm->mmu_lock) {
>> >> >> +		if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
>> >> >>  			goto out;
>> >> >>
>> >> >> -		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
>> >> >> -				    gpa, pfn, ret);
>> >> >> +		ret = snp_rmptable_psmash(pfn);
>> >> >> +		if (ret) {
>> >> >> +			/*
>> >> >> +			 * Look it up again. If it's 4K now then the PSMASH may
>> >> >> +			 * have raced with another process and the issue has
>> >> >> +			 * already resolved itself. If it's not assigned, then
>> >> >> +			 * this must have raced with another process that made
>> >> >> +			 * this page shared.
>> >> >> +			 */
>> >> >> +			if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
>> >> >> +			    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
>> >> >> +				goto out;
>> >> >> +
>> >> >> +			pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
>> >> >> +					    gpa, pfn, ret);
>> >> >> +		}
>> >> >>  	}
>> >> >>
>> >> >>  	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
>> >> >>  out:
>> >> >>  	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
>> >> >> -out_no_trace:
>> >> >> -	kvm_release_page_unused(page);
>> >> >>  }
>> >> >>
>> >> >>  static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
>> >> >>
>> >> >> --
>> >> >> 2.55.0.699.gb54405d56f-goog
>> >> >>
