Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C2313550
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238146; cv=pass; b=Yqsu3U/pcLjtqhvHz5WGioCHwZmGjmj7R2sPG0lL5Nt3OyprnGTxjU64x4swskrYc1AktvmIB9wEQlXpbZvIV0R/+3Ooevib09mPVjd8ciIH2a9Wpkab40wthWga2xHwNVNlbmcto6yNti0+hCdidjtfSaf/7sKl70uDK8pbxGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238146; c=relaxed/simple;
	bh=K1XwcmlHD8GKn3K0WyP7nUyryobefrvezMejetBDIq0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc6SDJ32BuuNWxwxdza3LgrSfYosbx+kKgBg+mcqeYzii6Smw1Ga62VgByqEIOa5nG7roduZq+XUIFddUShgrzzpHnwVtgxCCANuwF2QURIhkeg8Ie57P2s4Gkll4ATYAqWoRuGOQaPkydp8z8r1w3r518ZSEBkQ2kXspCU8Lz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YN1UdPYH; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YN1UdPYH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso87400435ad.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 14:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784238144; cv=none;
        d=google.com; s=arc-20260327;
        b=AwpLLfQV5kzHsXULQ24lxVpGojOk7o+3ugCYz1bTfSh4jZQgyOcvWEdYOG5hea6FMp
         +4nJsv1X22ZlfVPU1xspzCW+sehxCUjLpgzGs8U++oBm4qSOjkOZdXkBJVW6VcG97sSl
         6orakImwQYYYJIxvqqJVhBBm170i9OxFxiC4yMVmTzA8u0m6KH4sD6GL6vON6meLfvsi
         Fh97md94jCsIROhecZiSYd915Wg5WiLZBhdraDj8m1OFau2OHZCQLTy0IFMAdg6KADXC
         STpC2r1Zl0mdnZhA1UcutakWnsTpuL4MvClsSYRcVBuO/FGH7GQpRB/JS//XG1sm5AGi
         0lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jgZKN45+I/JTFc1EhYAUwr+BvCmfXGL3CG7uH8bW3rs=;
        fh=ntAqyAPUC5S0zXBhvATmimLk4ai4PQVCftFFHR2Jc0o=;
        b=cppshfs3QppEK32IxMLHWg2nWeyg3NJYz8pojgaJocX1+uodldAEkQKqvVPd2FOQQM
         qmO/O/qDfvebo+fxmERvUBTuDhgpPHTHvzgaYasfIoLPXLP9nAtac4wf1C9N8b8EqbzR
         n7L9QeVz3CYwzJXvoeX8YmFEZ8YzT/4TykCTdL6B4CiRft8VJTUyXIwFqtdydk34g+x/
         YNU+qm91RRC9PdsRFMrmEzJDpLeanEktFN54OLOaQbzadl0XCKPMliaVMxqYyPIu2vrN
         HaglE41hSeypykkrRAMpFxkFydWvDl0UCvHvkplcBj6mQBu6jI3hAZViWij1/zePI1sS
         aVxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784238144; x=1784842944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgZKN45+I/JTFc1EhYAUwr+BvCmfXGL3CG7uH8bW3rs=;
        b=YN1UdPYHnE5WyLlm4Lsw2SBFvEfW38verZApc7xNQ6Zsvpi+9uPawzvFdyUINgbvm8
         n8F1qBYSK/7jdcsc4DLOjpy3V5Dsu6Qifb0pr4RXMDDaVoxwmAvXoxPj+ZRFGYVQfqTC
         iBJvnss7bsAYgcuV29e8AKxzl4jcXGTk+J1eDYjhQajG7UrF1Ox/KF3huh1XvEHinVru
         iCCUV0Fhmy1nDCUTjUsgy/KCSWQdlM1QDBWAoeN79BVrdSHb3wW5L2JAFbx6LRBfDiqk
         QBYRpGHfcLkXzJZiBOoEAFODSngeyAkP2jmHfN27JZTmDxLjDGprV+524+JpfWfZvTHe
         jJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784238144; x=1784842944;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgZKN45+I/JTFc1EhYAUwr+BvCmfXGL3CG7uH8bW3rs=;
        b=PnJVjtW6ClWmDSaG8RkcCLls6A0EIbAz3F9iOPw7x7yT0V7qO3KFh1199F7ClWaM/r
         WRxoMoFsIP5GWaYeJbQeDeWj1o3sYa5UzkT2doZX+7RtdWsvfYAKY+fDWZwmpqhFUt/b
         ybmD0R/XOBJvBcLFnB75LMq/UEa7cXeJyhWS6zmTYm9x6Qtqt4SEm2aNMB9yLsrB3hxy
         z42gb1HEaw8+HAI1Km7YqXERT3vOZY7dt4GnpVYysQFMu5BOvvqhxJ0tzUaLbjX/2KsN
         CS4FBIhbe1T/bEqQn2Q/ULA4yjfS86O6GxD5cCAG4i7T0SEB9jkect739YA9iAtgY/h6
         7E6Q==
X-Gm-Message-State: AOJu0Ywb86C+492+L53J04PWvCdenE0++m3+rHYaWmqjNfgqKUCN4kr6
	HmmI+eIMp4ILginCRvt9Ekxov3KjWzTTlix8kybRb7O+uz4pBDgBuTRpVqD3s5KZUJCaACvbCcE
	b4BYLvY9Zd8jZPp/thylZkBjXVmhss17dU9SvVgow
X-Gm-Gg: AfdE7ck/QgAp9Vj6Ljld2JX+F8fZS7T1rHHoplEfDYrs5/PToKVtlZ39ptfZf1UgJWk
	NZl+Oj/uRhbGp0vnxZWd9mg/GUrmZlulwturDZr1AY36886LhR97dhwf8jM8tW4TL4mdQG8OBnQ
	96Of2eF0pjO7X1aK9TOUGnepoVsjDmZbMLvm87bXigOaOU+0pubI7N625AFqRPXLILBjTxv9QWX
	ieZRxLRlI+Hst2umBTlBm8zsSz94cP9G8Ij8PuDHSrcORJkJRaZOc0pX2epSaZZY5gjYM+CPksQ
	oZNN5AXAYG322NzOcB+tRq2WWUJGQ0n2CwpSw5Hc8sZxl0h4nA==
X-Received: by 2002:a17:903:19ec:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2cf03cef84dmr94490085ad.22.1784238143561; Thu, 16 Jul 2026
 14:42:23 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 14:42:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 14:42:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-8-seanjc@google.com>
 <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jul 2026 14:42:22 -0700
X-Gm-Features: AUfX_mwDdmoshrS8cdNdteZn70Xc4zcu_ntWSVV36lwfZSNTUg38XQ37kpdsEkk
Message-ID: <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/15/2026 7:10 AM, Sean Christopherson wrote:
>> Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
>> anticipation of supporting in-place conversion, at which point KVM will use
>> the hook for both to-private and to-shared conversions, not just to
>> "prepare" PRIVATE memory.
>>
>> Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
>> to better reflect its role.
>>
>
> [...]
>
>> @@ -90,8 +90,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   	gfn = ALIGN_DOWN(gfn, nr_pages);
>>   	index = kvm_gmem_get_index(slot, gfn);
>>
>> -	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
>> -				     nr_pages, folio_order(folio));
>> +	return kvm_arch_gmem_convert(kvm, gfn, folio_file_pfn(folio, index),
>> +				     nr_pages, folio_order(folio), true);
>>   #else
>>   	return 0;
>>   #endif
>> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>   		folio_mark_uptodate(folio);
>>   	}
>>
>> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>
> I think this and above renaming don't make sense, because
> kvm_gmem_get_pfn() can be invoked for shared memory for non-Coco VMs
> when KVM_MEMSLOT_GMEM_ONLY is set.
>

Makes sense.

> Maybe this patch can be moved to gmem in-place series and after [1]?
>
> [1]
> https://lore.kernel.org/all/3b64e897-93a8-4f9c-88a9-f416ff44b09d@intel.com/
>

How about doing everything else in this patch in this patch, other than
this:

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 173a7ed008d17..9df6927dd8f55 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -66,8 +66,8 @@ static pgoff_t kvm_gmem_get_index(struct
kvm_memory_slot *slot, gfn_t gfn)
  * On successful return the guest sees a zero page so as to avoid
  * leaking host data and the up-to-date flag is set.
  */
-static int kvm_gmem_make_private(struct kvm *kvm, struct kvm_memory_slot *slot,
-				 gfn_t gfn, struct folio *folio)
+static int kvm_gmem_prepare_folio(struct kvm *kvm, struct
kvm_memory_slot *slot,
+				  gfn_t gfn, struct folio *folio)
 {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	unsigned long nr_pages = folio_nr_pages(folio);
@@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}

-	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
+	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);

 	folio_unlock(folio);

I'll move just this renaming to [1] like you suggested.

I think it's okay to continue to always call prepare_folio(), and within
the prepare_folio() function, only do conversion when the CONVERT CONFIG
is defined.

I'll also move "Opportunistically rename kvm_gmem_prepare_folio() to
kvm_gmem_make_private() to better reflect its role." from Sean's commit
message to [1].

>>   	folio_unlock(folio);
>>
