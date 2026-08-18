Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949B397935
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043897; cv=pass; b=nyOHnEUaTN6dQV4FyJrBtEWqEgF7ukQjCyvGVPPg8TFOdIeirOtJELvGgsfs8v4kM1srL6mmecPEYz+zrVTnEyqZGTMmF0WjwObP0XehGyTSgiEsmbPY9I7LWdBGlJsoexLYlnxikFwGPJTGJnDUnig9sYDxH8rGYMrtS9JxytQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043897; c=relaxed/simple;
	bh=u0iX0ZXqqeDNbxxfcHZ8oa2/UskWfEs4uf2Cr7iZDNE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeS8f7z4Xqq5G8srb2uQdM/wGMgO8puCFe7bq3r1FYXRj0eKGk8CGd2PSR1S1bbXxukuSSegwIHPRGiaVstjOiRQBEARzQDE4dRCOten4lNiPNFBB2HWz/c3R82IPuaoMT9am93rWpvXRSwF3Xcy7C2PGGpdLyx+mbsObAtlJ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WeerIMJM; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeerIMJM"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c998fd549a8so3327802a12.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787043895; cv=none;
        d=google.com; s=arc-20260327;
        b=JWPMFemPT3UVN24rgxNED2wU4PqU6TTpS2OBEuPBlAMMSpNLODHShhKVQHp7cSV3nK
         2aEtxtfOSxHQMV/IXITY0qD28eqEjoKBKVCJrCc4cVPhMqXmfIT3GGDtn6t2oAhyF/5C
         fT2mGs4b8xJxnyeRitn4Moo8jf+KBldSCYVbZf4K+CRMjS+dtxpWDr2vPmCcIPXvAS5V
         n1bEhGp5pi6052pdaC/ghBBox7MmfP3AYyK7S/ERu5vnZA8CXHMAUTM+BATFP41tiFfZ
         H5Fdtqb4KOlb8L0jgJWqWZPcQqXjd2OU16HCj5Kt29tV65ep/ujo39q4By87A0Wj0pUc
         dENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RmZFJZDIQbP9rBN00CF0YOoIPLZVCPcoza0mwPaURTk=;
        fh=VtANIWD9hGN8GExjq7oVVxE0HmWNaDCQb3M/aGzSP+M=;
        b=NwMJUs0VHhvxDbTpd0xBMw4GaZ6B410q4ofJZeA6KQNAy0mFZbB/2303sJr/cx/97+
         78L4TcWKvMdnu4t3MHbjBdNyoL1HLf0m+Chqrzj4+q92FSAuuR74kh7Jt2BDzWfX1Ysi
         ukTtCNh9zcob4IH9Z4yyfy6RUY/mQA59JqEnx9zs3q7w/FQdu6UNrRI+KE0i37jFvwdX
         fE02U+TwPZpg4zlZ5ZepfuSuDa42yE/ie0GPdH/VpcQU9pmbVFN0yHoW1VPkspbv8WsZ
         04lVftmOO+j1vpm41mBN/zCGcyfSvDQ6iGPJJepARfDSOxh5yzgGy95Abzw5q1K9i8x2
         CDVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787043895; x=1787648695; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmZFJZDIQbP9rBN00CF0YOoIPLZVCPcoza0mwPaURTk=;
        b=WeerIMJMO8ti0i65eoTu3p0ZdbzZdxisKb64+VmqYrwBqHjLskr4j8R9RA8c9jrw0x
         KWczAkDfy1LmJ4LOCMrRBJdxSbgFYjbKw4nulR7Uw5+Q/fK+PAmA6AhbfLJxb3eA/6nQ
         7xtbCy/4ZUDncctsQY27tsh4UuAPklIN39NCVq+SULpxWlLT7GMwiAF3zxLS24Dtt9H6
         aOqI/UtGfim4QLWw6PAeOwKwBdvYY6v7JDwJ2KRlh/hyqFqcXlNYkLzh636t0QTJfcw2
         GinKmCpx0PB3nLiJlROS2S0+XeySHA9S1s/s3kuMm2yD15vb3q8/kHHGhedj7dYiEG5I
         h8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043895; x=1787648695;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmZFJZDIQbP9rBN00CF0YOoIPLZVCPcoza0mwPaURTk=;
        b=OyRlvqO0rIijV6TC7LlI7Ah54798CjCMhbwTk6b/6I0CkvNCek+rkBrORV4lxuplZY
         SVUnd/yszFLkXHKc15BHwVO3xIs4kTrufwq/NNrvHBcpp0TCeikWMIisDGHYn1+pIQpz
         mfCmqP9IXnX6LQMGGjaVM/u6wj36FVyY+KMg1siuLPhbZaoGIAARi/S+9sgc9tAoHrCs
         MzvX0rCxg2wMCR4vNOZF9zZj0ac0UCqw47MJ6zqN2kx0entUgndniQWaXCTANXPgatJC
         ZDerKvN6g6FcaBEBgDPxRw9pf8aBgCGkGqcwRJhGavW54ObTyu3Mlfo6ByyLu+YXzpVa
         6cPw==
X-Forwarded-Encrypted: i=1; AHgh+Rrn86ETJW4dKlJC4J74waxbV8sKVmXDWGMVc/J5jLfZCbHlQeXb0roel8afo+7o2+ik4KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTAu0N0R3wlqsDkxa6EpdWnHmW4DRqxSmH+fVI5Glexy+98Mz
	+cnyQF9ZlpIZDqqaBPgmxGOqM8CpgyWkPh0ZNeMxQ241XsICORxClMfjUv0c7gbSjZk2ReaQa0u
	0Hv2g4195+LniBVX1PGxE9kUemVigIszpRTRFPdjT
X-Gm-Gg: AR+sD13BlzB1PLbqoidWqRBoy01RhLYuMWQ3AIfXkd4jVZTJVBQDqmiGw15dmQphvZ+
	8nB8JYs5X4BSe3zzC9Y6cu9nokHrw8zPMR6LRhzRiQV9f4namVXAo9K44AeSdYHdxCl5++hsxJ+
	I7Lid1q6yp9w8LTx4TrubKOpjZbNY4iO42gqgCLk+jcOiavEPQ8vNwN253n6uiIJ+c7IOfWCSO8
	e/OzC0BVznyDUGMWNaOIJqd1bN59jQ1tbi1M/gSAKZ2wtHI0/xlEikGUO/IN8UsHUh/UbVVf3CN
	16tHJl6MrXq+W6iMcMVKcrqK4EXjHF5BqArsTCO2fDsv5F8zVN77L7FZdxFwS5TjMUoUm7BnYeo
	=
X-Received: by 2002:a17:90b:4f84:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-3933bd186f4mr33702008a91.4.1787043894543; Tue, 18 Aug 2026
 02:04:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 02:04:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 02:04:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aoQT00rN8a5TQ88+@yzhao56-desk.sh.intel.com>
References: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
 <20260818-gmem-no-return-page-v1-2-4f8d939efdbc@google.com> <aoQT00rN8a5TQ88+@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 02:04:52 -0700
X-Gm-Features: AcwNN1UM5CcnTZUcMQPeXSglijNaI2oVBWDnjgv4CaplShdt0x4B0EyQ_Yo4Fyc
Message-ID: <CAEvNRgGiYFaKAH-qAWy4W5nrmP5fYR0AkhU_t0X_NdTTcxgv7g@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: SEV: Drop page refcount early during RMP fault handling
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Aug 18, 2026 at 08:12:36AM +0000, Ackerley Tng wrote:
>> When handling an RMP fault, KVM retrieves the PFN for a private GPA from
>> guest_memfd. The page reference taken during PFN lookup is not needed for
>> the remainder of the handler, as checking the RMP entry, splitting the
>> 2MB page via PSMASH, and zapping shadow page tables only operate on PFNs.
>>
>> Drop the page reference immediately after retrieving the PFN instead of
>> holding it across the entire handler.
>>
>> A later patch will follow up with completely not returning refcounted pages
>> from kvm_gmem_get_pfn().
>>
>> No functional change intended.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  arch/x86/kvm/svm/sev.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index b2738362a928b..19c31fa944e34 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -5036,12 +5036,13 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>>  				    gpa);
>>  		return;
>>  	}
>> +	kvm_release_page_unused(page);
>>
>>  	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>>  	if (ret || !assigned) {
>>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry found for GPA 0x%llx PFN 0x%llx error %d\n",
>>  				    gpa, pfn, ret);
>> -		goto out_no_trace;
>> +		return;
>>  	}
> Hi Ackerley,
>
> You missed the parts in [1] which save mmu_seq before invoking kvm_gmem_get_pfn(),
> +       mmu_seq = kvm->mmu_invalidate_seq;
> +       smp_rmb();
>
> and check mmu_invalidate_retry_gfn() before snp_rmptable_psmash(pfn):
>
> +       scoped_guard(read_lock)(&kvm->mmu_lock) {
> +               if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
>                         goto out;
>
> [1] https://lore.kernel.org/all/an5RJYTwlYeym--O@google.com/

I thought it wasn't necessary after the fix in patch 1 but the
maintainer is always right, lol and Sashiko is right too. I'm preparing
a v2.

>>  	/*
>> @@ -5088,8 +5089,6 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>>  	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
>>  out:
>>  	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
>> -out_no_trace:
>> -	kvm_release_page_unused(page);
>>  }
>>
>>  static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
>>
>> --
>> 2.55.0.699.gb54405d56f-goog
>>
