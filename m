Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BC390223
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843494; cv=none; b=Nn2vRqHUd2YBIWVe0fpCJ2ifYUDmKDNMarVMXnusfxt2Nc29EnyQTMgs6tH1/ngMbZeb6CAhOcyROx44T61dm+3jhgNjzNji1yMXnQwbg8yQ13pwwFoLWJoJytUqqBZlpvwkvea7385/duAm2Es6rcKtlLkkt5ybevCCkCgxC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843494; c=relaxed/simple;
	bh=GqrwJo5LFNqWNYi8kK2KawIL+bvYezgIq8D/EvWHPbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cerxV4GRJrpw5ZcddLzd4dzfC3sZhZr57jg0a+Lfhjy7zGegUCCnwrlBi46Xxl592r3lUMS08rlIzI5hCKUKU0gJ/9yaROBrypW+PzEqM1vSGK/q/LrhzGs+7BDQbOyrzWm06ssbKMn1/YnGmPPLJqH6JT7gFmakfm6sh63izFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVERInA4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKVk15ml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVERInA4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKVk15ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778843492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHOjInx7JBCVSTQLeejvCFU5UaZAPn04GMUXTkQbXhI=;
	b=IVERInA4R7F8mpOCYNIYYtM39fV63hzQnzU5NIuwczwf+dZUdZsl8iLKKGrhRFLPWI6jt3
	DVKL0BPFzgpjaazJKT+FW7tOYmWansNiYyEb8TuqNPskyeZgJcHhIbWGrYjFrnfevEblZW
	nAjo5RdeNDOqTZlgIoGIGF+hvOAH3Uc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-8UsctsxLN1GTdBjwN8dDCg-1; Fri, 15 May 2026 07:11:31 -0400
X-MC-Unique: 8UsctsxLN1GTdBjwN8dDCg-1
X-Mimecast-MFC-AGG-ID: 8UsctsxLN1GTdBjwN8dDCg_1778843490
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e79219704so39489745e9.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778843490; x=1779448290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHOjInx7JBCVSTQLeejvCFU5UaZAPn04GMUXTkQbXhI=;
        b=NKVk15mlEPB3LvDzr89iiG3ncYrkWGOwGttyfQF1tla5t935nyO2Ycv1rMiM93MMzn
         5djaZl2ByHs8tZz77e4k7NaZVXetmSK5ddJrW9ghTTKkCrXaIOsLQFhIiJ49oURFjD2k
         VAHgC/eyleNVF9Le0YAabdAdh+F0C+aVj4nmPb1QMpYWUqQBr4SBCWwZiOOz998AUVnS
         pJE4ULd6wPD1yRv6dAta36stJ5Me0nyOccvcviTGLS/97a6xAk+3pRyu6MvuclFKTJea
         o95276hJapE0DQMnjnXaJdZP6Ek1hP3FZl9icMWKQRgsPdHo1s0x2WaJWOBP53xuwYRI
         CpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843490; x=1779448290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHOjInx7JBCVSTQLeejvCFU5UaZAPn04GMUXTkQbXhI=;
        b=HO9mhTqmpJITQZHlb88GUOjZuQKxm2FXw2gDNDP+xJACwY8mZ7nyV4yaqG7PEIaJ1E
         yUPL2NAw4Dim+hzoD7nX/hD4ZFnMxe8qI7gMSTG36WnC84HC/T424ifYxcdBIkmlWLy3
         g50/6h0+WAkGl+7Gik7HgBtszcQ0Ms5y0K7lYYZvrAHZp2Qj1ajAaBczb5XA25T8f/4N
         8t4Sl6+UNMWvWJvLfJGhdBI9XYv2SmM6B5NF9jS06Xn0SV6FLO4peGH6RYUPm/SDGXGV
         ijt4DkI2nm7FdQkzxlaQFqZMau11kJvMwlGij2FHxP9O0ap6FtSzsudBHqtPkdby2LQ8
         Cnkg==
X-Gm-Message-State: AOJu0YwxxEDkveS0K6Zzr1leVjMiQiO8i2wV4zr8sdebCKETjhlgryPT
	wFDCcOPsDK6QbpBLg695jgf5WRugw1RB+nLau4ukOfuj0umIDtcjmrlAlSdg0eOMqYGyqyXWbD0
	0NuIULAT2MsbAMl7iSuiHcu4vXOm0ANg5oH1hAjrGVrZMqQNN4x02SG9+6pnWVYmJSSk8gEMqfv
	vZF0r6KHMmdQ7Y/sUdD158aol9o3tBzXwNp98rVg==
X-Gm-Gg: Acq92OFKHW4PAnSfW/xb+6P1CS62wowXe699dA98msOAffqvu8h/LH0lZtJNCs69Bzy
	S1O+HdeU7qLDTKahqm2upk+P9UKcTIQ6GUQR8lTVq2RuejXeQJvd5+6bn9ONcbzHpRb40VuJsaJ
	XjMzJjB43UAUP6Yv1gNkQFvQ5kj8f4Nzfqkf57/MFqppQjMDM+XM/tCIj/J5oYjS0Yy46Wau28g
	aGPVx23UI6dETn7O6RKml2MyIboQ2AoszhBatsMEe5OBH3sR92oGY8J+fhb+nV2uH6g50Gxv3PC
	mgYMepV7pb6nU2JzBnppeNXpmvyFEk9/wr50yiLOb5aUStBxIuvuuPXF1revHapfjX8Z+vKGSMd
	ZxQsFRQ==
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-48fe6631679mr49429355e9.33.1778843489761;
        Fri, 15 May 2026 04:11:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-48fe6631679mr49428965e9.33.1778843489325;
        Fri, 15 May 2026 04:11:29 -0700 (PDT)
Received: from imammedo ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm12804239f8f.3.2026.05.15.04.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:11:28 -0700 (PDT)
Date: Fri, 15 May 2026 13:11:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, babu.moger@amd.com
Subject: Re: [PATCH] x86/svm: work around Virtual VMLOAD/VMSAVE bug on
 Naples and Rome
Message-ID: <20260515131127.0b13249f@imammedo>
In-Reply-To: <20260514113424.4136527-1-imammedo@redhat.com>
References: <20260514113424.4136527-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 13:34:24 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

forgot to tags it properly, pls ignore. I'll repost.

> AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
> have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
> on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
> address as seen by L1 falls in [0x78000000, 0x80000000) range.
> Reserve this range on affected CPUs so the page allocator would never
> alocate the VMCB there.
> 
> Given that it's relative old CPUs + nested env + only performance
> impact, it's not worth fixing on KVM side (which could involve
> messing with allocator or reallocating VMCB, until it's not
> in affected range). Hence a quirk here, to prevent tests
> failures where we can't do anything about them.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> there is not official EOL dates on both, but using a newer
> generation(s) release dates it appears that both are effectively
> discontinued for ~3-5 yeas
> ---
>  x86/svm.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/x86/svm.c b/x86/svm.c
> index a85da905..706ff2ef 100644
> --- a/x86/svm.c
> +++ b/x86/svm.c
> @@ -334,6 +334,21 @@ static void setup_npt(void)
>  	__setup_mmu_range(pml4e, 0, size, X86_MMU_MAP_USER);
>  }
>  
> +#define VLS_BUG_START	0x78000000ULL
> +#define VLS_BUG_END	0x80000000ULL
> +
> +static bool has_vls_bug(void)
> +{
> +	u32 sig = cpuid(1).a;
> +	u32 fam = x86_family(sig);
> +	u32 model = x86_model(sig);
> +
> +	if (fam != 0x17)
> +		return false;
> +
> +	return model <= 0x0f || (model >= 0x30 && model <= 0x3f);
> +}
> +
>  static void setup_svm(void)
>  {
>  	void *hsave = alloc_page();
> @@ -413,6 +428,13 @@ int run_svm_tests(int ac, char **av, struct svm_test *svm_tests)
>  		return report_summary();
>  	}
>  
> +	if (has_vls_bug()) {
> +		phys_addr_t addr;
> +
> +		for (addr = VLS_BUG_START; addr < VLS_BUG_END; addr += PAGE_SIZE)
> +			reserve_pages(addr, 1);
> +	}
> +
>  	setup_svm();
>  
>  	vmcb = alloc_page();

