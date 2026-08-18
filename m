Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF144998E
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046277; cv=pass; b=cvq2uZwga0Aaq6OaBdlqzrMKgb3IiqsyBNAo0070qenY5vy8YirbMwvq2buVbAYr9vwDv3Dq3H1XXEOuP2rCF+uwjYEMQ+5pSOJdsEWotaH6EKgSiuuWptXgbfQlqx+ABNUtPE+bOCNwKPD9T180YBbeXGp5K5iyQaAI3hDRfGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046277; c=relaxed/simple;
	bh=7WABSuV4sFXi9VKk+Z6H39gC3g1G29463lKuZYgZWTA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md69wDKE35N8hzitw5MNCYrYQHJZVD1DH8Ig7L0MiAPwGQPRdKyjG7h4d/ah/UnhadijdDGMscfU5AsqQeH8KgB2ZI5SUDPW1MMBxmq1JS3ttK1sj94ovO5BgEUQxPa29sUlUHyZ3FqNQx8+TjC1TCXXSc6VzeRnmkIYo7TGMvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTcJjeLg; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTcJjeLg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3121302a12.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787046275; cv=none;
        d=google.com; s=arc-20260327;
        b=J/PEyVdixKzTMR3oD40pDeoUeOtnGMk8fkUYW6zsaTP7K9EcoP/O+iNUL1gDvI4Dsn
         aKybI5WVwzuPThENLsUZbWFlvY2u0Enl7XjYLIRUAVKu6t1rKqiqOfwa+Z1enfOvd11E
         S31L6ETghX/ULPUwOFii/y+cFO2jFdCRg0inMEvtpi5NLaok3ncXi1696Cy9KhF6LFk0
         lwLqUqHTGmt+KkaiWfuV9yFNITU1np8t8nDK1FqCJAGZuloLRG4vmLIvqAikLnHoDMaK
         uUg3gGUzIRxLFvw3kWI5T0/nmg99onXc0RoYJ4xmOD3gOS3jmENqlk0vcPd8ZgkW0dEI
         z2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BeFyeN+d7Fl6w7s7F00mypvhcoz1q5bXaJcc27nMLck=;
        fh=aGCEZ7tm2f5lbA7VGqX3pY9NGWlbijFGzKP2MHCO/OU=;
        b=ao5mGOHD/IUCaFCOYIi6ARBmyENCNRyZPBfeRTJZSkTwauIGGjq6a7wBrg/o2ty/Kt
         leV0Qu2/ULxRZOkiVlGMHIwCIaLyKg3+MRe10f5vADqTC0JQahUIheOnMGigTYZRDQbX
         2fwIpGy2ymmXKzf6zam90CPcGJ2PhRvedO320hXjBfIGfmgRnL3GN/4CUdk5Lf2qxgkR
         qo4FplPEai7ahWvvWy+Mnwvphm9KrRf3pIjHHBFwpoI1UuXp/i+8t6AVK70Xd36arxa2
         BReehgWi/LIyb12/eoEtbp31xHrjheOmExykPNTzQGzhlq8TfoBJ0IdTYovt1C4IKA18
         Kmmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787046275; x=1787651075; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeFyeN+d7Fl6w7s7F00mypvhcoz1q5bXaJcc27nMLck=;
        b=HTcJjeLgcgeL6Zd+7ca0p/flnRBqWvciNEYbTaCce2j0ObjsnW7g64aGynQ4ihs3Is
         scA416O+id3g1onkEmz09nt4JVf8fAAfQV8B4c/q60VHhgT5FhDsd6xaDGQj1DBv5n8W
         hufNn3pMD1zUnk1OTdOkjU06zlsbTFddgJnnw0XUaSzAyTQ5ShKwS1SsSXu8oijJgqht
         T8NqqqUG3F6EaIXx/y5Gty9BNIuxcU6QeZQZA2bdT9Gh6ehzZV+rt7GUK4XNdRLqsKnn
         xxnZ6+M9HoDLFYw+HRTMXEESwDVtJVSt32Q3tnKHFHisx0AZDTA69n2dgF0JHC8N4OJK
         cI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046275; x=1787651075;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeFyeN+d7Fl6w7s7F00mypvhcoz1q5bXaJcc27nMLck=;
        b=Ft0ZCakoWe0asDFkCMKhj3hABRgTOCil0iZTR7blDwgVA1ZOS91gU4/bna/hNof6Hl
         GToohARygIvUKCHHGPWamKUEQ4Pmhe2iYq2Gkc3Tj6X2xJ2J30/1Vv8XkKVbyFmSHZAJ
         gMw7cHuAwW9hrbWxJgHoBKdI829hprtCpPHs3BoTiDzwmT70pEgQ8hhBA+yt2o7C0mQ8
         jTsDdEWpiuEeUp9Hai1QcSqoBVyoNcgQ6FNoi8HhRZ2nFryuO0/rcPrQCd4sMYZMH3bI
         mYx7fJuchlhBO4a6/UCOl4abYd1ydp/H4xc1h4DxId/g7nlu30v2dLchevzVGEISF2ic
         y8UQ==
X-Forwarded-Encrypted: i=1; AHgh+RohYngBOnMn49QYcMEWW1iWqq6xzgOmBioQkcWTKIOrV2G5UMZQp8WWTBrZMO1WIJfOizI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJ4ySUZP/NETubIP4l59n7DRKJxZVpheznArJbqdCwlrTCE8Z
	yIWWFAj3gqFBuHLwLWw/xVt1cp+7CP/jA+0YlvhBHrUPqUvLMycaIO0+hE3s6AhbHyyFH+zjFkw
	pdOVXPp/rxavDdLinpQpPcV4C69IngLbqHFy0eEVY
X-Gm-Gg: AR+sD10TG8hbr3U4/1uX+Dx+THr8Kg+cmIoy4mjXxGziWqditMQ2qb1LZhPf37cde4W
	SbStei45NNN3BhnyAAOa9o/fxXbqsk0ER3SKgVGBS3xpJHViMZLfgYu79UHkQ3tRq3Af8nKc8MJ
	3Kt4UmyWHA858cIQ+HdHU3q0cXTEbo5uz8V6HPYUvpOOUxlYKSnAUZoAiSxU0hMyS2rb/G4/zhl
	2jGCoiziVLqO55lgTLuEUyyvCSWUzEYkhEh3SocKPTOJAMZgoq+Bf7UI3yCiylB8MLWD0hEAWIt
	R6f6C7N5wDsd2HrxjkzS1KMKymGvTjrHMaCqDD6m/OeOh5BzAu+C4XrqjPQHb+Oe3RlCMpF/kJm
	43BrYrfJvdMeZtso=
X-Received: by 2002:a05:6a21:3103:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3ccda9ad8e4mr10134494637.10.1787046274831; Tue, 18 Aug 2026
 02:44:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 02:44:33 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Aug 2026 02:44:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aoQZFtSd671ti4sr@yzhao56-desk.sh.intel.com>
References: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
 <20260818-gmem-no-return-page-v1-4-4f8d939efdbc@google.com> <aoQZFtSd671ti4sr@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 02:44:33 -0700
X-Gm-Features: AcwNN1U5ehd_NTGTo4zZtHEtfJhdWWWuVuXA16suZpoLtMBQBlqamb-zw5aEarA
Message-ID: <CAEvNRgG8gxZSmOrsENemNqbaZuDyqNXj35M4VyChA6HQ_ofYVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: guest_memfd: Stop returning struct page from PFN lookup
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

> Hi Ackerley,
>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 6c941aaa10c63..e5d637a5ec558 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1613,7 +1613,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>>  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>>  	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
>>  	unsigned long mmu_seq;
>> -	struct page *page;
> Just drop the page should be ok, since
>> +	struct page *page = NULL;
>>  	struct kvm *kvm = s2fd->vcpu->kvm;
>>  	void *memcache = NULL;
>>  	kvm_pfn_t pfn;
>> @@ -1641,7 +1641,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>>  	smp_rmb();
>>
>> -	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
>> +	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, NULL);
>>  	if (ret) {
>>  		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
>>  					      write_fault, exec_fault, false);
> here missed a hunk:
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
>         kvm_fault_unlock(kvm);
>
> I will fully test this series tomorrow.

Makes sense. gmem_abort() is purely gmem and there's non-gmem path to
fill the page pointer in, so the above is correct.

I'll not be respinning again today, sorry about the flurry of emails!
