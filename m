Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9B2EACEF
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670207; cv=pass; b=cMI9owXDQdGpTjqLYA2WqDcc+nf72EEjXDiKUHqn2fn+iXFbPxdb8nEKa/v5JZCAXSaAmXGCoq4RPzTs27MvDffoYfmI8JKduMrZmDtdyqmOR8i5YO1LZjrKYCynbazZ5FP0jCmOIy9r4801xWBRBgaN3/54WkhAB+7R+RDJd+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670207; c=relaxed/simple;
	bh=o1DRAm9tCUcAEMO8HAy8bZAsGoCCc/LMs+RRH+wopYw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV76v4ue1gryzxa36xwhwSDIyc0JLApGpwcn8WU0akqbQqqYyA9/e26l2LcNem6Q7dCIQW1MGFTPI/3V19NOeCbVQdAlZWt6e2/rmWNV3IM2thIUwwkqO3rCWRLGEuZqWIsz0X6b67sUhWP+PkTBhRARWaB1h2pZJ7+5rLtjLJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRHZLhx9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRHZLhx9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a10d130b37so2344189e87.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 14:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777670204; cv=none;
        d=google.com; s=arc-20240605;
        b=fXdtlui3Bg/iEO+fwQNYpfEDYBTiYIJ8l7KtwJ49H44QHFNEwqCa8zxYd/sPd3BAHr
         tp5V0T0/zL9Z097HB0xR/0DeFYwa8wlGA7jrXZ4UAsPaKBQ43gWxU2UONj+RG8q1CEJG
         gmB0jGi9XiSRAivwsepgGpO+/v04nvuE3boCnaUjavLfLTAObbD0tu8nU43Au2/Ma2bG
         E0dt776MH1pgVb4KGDB0Z1LkpCTJZb9NKNhZ3PuIYH3MYwir2s+eSagNneyPrDXfSh/G
         H2EtqqPlzbFB9yghJ2d0oIebl8IhRD76AjhwEXSK4/348Sm/YsBk8INuzDJfR8g1mDMw
         NheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uei5dSrRSpY1oDti79iuwPuSAl+03f5yYDW+CeBzC5w=;
        fh=QuqHXuzTpH9tWZK8CGg4ZNFH0mZ6HL5F5pTNXTYjz8s=;
        b=Mj5VGIj9c/ph98X2pxns/1krLE5riXkA71HxZfwJr8enkbMaJLvN4hZ8zVh8sKTsGl
         ePVDrFED11XduXiG2h4syrlJyK0XQal1BnH0g29qnGGxvUptLcZZ5nzoo7PPk60Idfv5
         DNM81mhvdyq5E4JDahfcJ4RMozHWnf4FR9JKnaL0zSMCd4J8H09/jW/mdrq66mPEm89K
         OSRnFUvXf+fw0CUDhkpjxv0gftxXx1JLGTetZm/vfBMbcgigS7iqUAPd84HB5KzreYJW
         8xG8GrHUI6ZpEOtIsYfFVHvRUDKeyvMvopOXfAyZqKVr7er+6bDWZtK95PoxoBPfBP8t
         LypA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777670204; x=1778275004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uei5dSrRSpY1oDti79iuwPuSAl+03f5yYDW+CeBzC5w=;
        b=HRHZLhx9+Bc0GBzF8EGwsbuUq2j6ZOlIBHzrFJR7a44t8V1F+93WCsBIIjLwoICxxv
         +y/uQ8Awa/qu58oQUic8/sdTCkLlKcRQMNpezWx4bGsawZLcVjQdHiRvZq2rq3Ofg36Y
         9ktdjWM/9b2d14nDisGGEyMvqtAMnHwNOhXbShTkAPhk/wroMi/3Pu5SqM8eXmargz/H
         cBuIEtQKekZoMF5u2IfdNEIc/5Xuq1jTdSBlvgk8b70RwNlqGehbN8Rza23MGTDmaF/D
         p+ouUm0dkjZmKprVHk1WeLKOvhxjTDMO8JBPdisgnzJyxeayBsUq7BK88sRHE4HVi85z
         MrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670204; x=1778275004;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uei5dSrRSpY1oDti79iuwPuSAl+03f5yYDW+CeBzC5w=;
        b=gRIS8ny/gY2gIhRvnzJhw1tdoQ6HiRb/Qzyr7FrN7gegR4+jDitDYuqn6mgkmPZJXZ
         Lv7+9p1ct8KVF0PEnXaB8AWvqlV5npcrsHIEt2bNCjRWZiftkCvnAU5es43356NGcss5
         NH/3lOdKTu8UBhAuTzEkfyu1ep49H5UFSmEZPOuHDYRC1RRZuqBy3ojYoY+CN5duYzQf
         0NckH0OTh0sa/p96vdCMINzzmTewQ+J8qP9kD61PG2gzGmjvDkvNwRg9zv+Xq7kqT8Pu
         GN9mZBjqUsprUU5FRuCIrs6eFYAXW+IWVEbtjzVuCFIm4RfLctJVYYeEoAHqFF3vAnd4
         oFjg==
X-Forwarded-Encrypted: i=1; AFNElJ+7IGfbUjzwYRvvmgwnSUHVl3cI5CvBUoSncjN8/H+P9xk7MIUug8kIZYFSYDhKgM5Yv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcfn36XPZF/I2g6ITI7QWQNjkQ0uqkBNi17QNUNl1Z6rjBgdW2
	eDU/FWZUUTqB4jPAX3E68fDreQcrIl/fMMCAXDqRgezmC5IHOsZpTMLQLrQg0ObgBiPo1b9Jh9t
	15oImk+OdEy74XLJXYM1MW4Q5AjE3sJ58V2fPTLAN
X-Gm-Gg: AeBDievkaFeaDf4vMwGtY2Abc34+8AhcV0MiV1cK3SaWYD5dcgRvnHGHUzE7R4yQERm
	idN+4jIsJjJKT9EvGc5UPeXrv/v8Lv03Z1FaiuV1kVjRamsmJnhDMG7gwZOQ/0K7oJYXlAL3Fjk
	qq82sHO7+ZJvGZGrJ/qkBwYMFYm7DgzE4D+QNUTdVgamk8yHaZVo09m98lxYPx/ArZyOFdMjNZ+
	c+N8COAWlyPS1kqvw6zju6pJWzytUilIfx+UMELASBqlR/IwUdD/eG7yhh+CEMxNYnoHGciV6Ms
	JmySL/uhb3+50y20QO4VR4XZHI6alTmSDxptmbJsekH6JeVkoUw2JrT9VG/qeu12G94r/BSJUpy
	BtzSEVw3vtUH3AS8=
X-Received: by 2002:a05:6512:23a6:b0:5a6:31c8:8a9c with SMTP id
 2adb3069b0e04-5a85271c807mr3184070e87.1.1777670203705; Fri, 01 May 2026
 14:16:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:16:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:16:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260420154720.29012-7-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com> <20260420154720.29012-7-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 14:16:40 -0700
X-Gm-Features: AVHnY4LFLtvgB1joBn3gjShij7pw67cx5Xcm4zIH9p8b0SyKRJFitgJVM_ea3AY
Message-ID: <CAEvNRgH2pVdfgPXYrspyRLA=jySbzA0CK_axVRnqW8-o0HzfHw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/7] KVM: selftests: Test pfncache with gmem-backed memory
To: Takahiro Itazuri <itazur@amazon.com>, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Takahiro Itazuri <itazur@amazon.com> writes:

> Add a selftest that exercises pfncache (gfn_to_pfn_cache) with
> guest_memfd-backed memory by using kvm-clock as the test vehicle.
>
> The test creates two VM configurations:
>
>  - NO_DIRECT_MAP VM: All memory is gmem-backed (MMAP | INIT_SHARED |
>    NO_DIRECT_MAP). KVM_MEMSLOT_GMEM_ONLY is set, so pfncache resolves
>    PFNs via kvm_gmem_get_pfn() and maps KHVAs via vmap().
>
>  - SW_PROTECTED_VM: Memory starts private. pfncache resolves PFNs via
>    kvm_gmem_get_pfn() for private pages. This validates the private
>    memory pfncache path for future extensibility (e.g. pKVM-like VMs).
>

I think to make the test very explicit about what it's testing, perhaps
always allocate a guest_memfd memslot for the clock, and then make
setup_vm() like setup_vm(vm_type, gmem_flags), where gmem_flags is

+ MMAP | INIT_SHARED | NO_DIRECT_MAP
+ 0 (for init private, hence no HVA)

setup_vm() can then check if the vm_type and gmem_flags being requested
is supported and skip if not supported.

Perhaps then have a test_gpc(vm_type, gmem_flags) that calls setup_vm()
and then runs the test, then main can be like

    test_gpc(DEFAULT_VM, MMAP | INIT_SHARED | NO_DIRECT_MAP);
    test_gpc(SW_PROTECTED_VM, MMAP | INIT_SHARED | NO_DIRECT_MAP);  <== new case
    test_gpc(SW_PROTECTED_VM, 0);

At first I thought nothing about the VM type being tested here but I
guess your goal to test that non-CoCo VMs using guest_memfd with
NO_DIRECT_MAP can also use the updated gpc? I guess adding the middle
case is optional but perhaps shows that the vm type doesn't really
matter.

The path where the gpc gets invalidated is not tested, but I guess
you're probably waiting for my conversions series :P (sorry!)

> The guest writes MSR_KVM_SYSTEM_TIME_NEW (triggering kvm_gpc_activate()
> internally), reads the pvclock structure to verify KVM wrote through the
> pfncache KHVA correctly, and reports the kvm-clock value to the host for
> bounds checking against KVM_GET_CLOCK.
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
