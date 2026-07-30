Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C131716E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435528; cv=pass; b=ogL469Wna54ZvkifNE6b4huS0GL771HM8+qixoTNPJgUNYeioyffaFN8ym5dRpzFH6Ru8ouk10fs2ixqpJG4dMhRq+lOXPO4wtFhcdv7ZInKfi4LoY9hxtXUwEPGnaZVZ4qmSJpw0sYiUQuSJl0+jr1EzG28M0kOr8ogaQk6Km0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435528; c=relaxed/simple;
	bh=gJHV3b2Sc8xEI8IKQeSL3rSLGGFn/d5inPeMCN2Ei2g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTzQ0FwawNYM0E98kQ+5QzIQgyhIH82PE8JfN4TkXEtEOkIMMHZ4awCFM+nWw/QERPCKDoTTyEwBAP6SDcG07GJVR8c8Pd4OhkhYEJAqv6Wz2zFmiUwK1yyxqA//wCOvLcvSodzhQFkPG3JGZWlqOsQKhlDU4DOuXGlobzNyRfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBYHkGsk; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBYHkGsk"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dcbade417so186245a91.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435527; cv=none;
        d=google.com; s=arc-20260327;
        b=Vn+WueZGN+UphgJ4v2Hv5JXw7c4O2YFe1PdVLqjt+ykzQikJgZNVk1o8scLCvDaoi1
         W5wrcxnCF0HIrs0hRNyYehl83FcCMcz3jMYzL5w09lSGOEnQksFpgmafdurALqL8SAem
         gerUHXRnKtthK/2yZtOtXVBRUdFengRLdoNWBYTSw5QaAB/Ym2f0EdmZb9uSGjrxUfLU
         kSGlKbMwDC7MZ5PSwtIijWZk3daNK/zAEQA7uLI0WtcIS1tRN5fM9FZaIhxgeo0/Qrn/
         cKfzAXvd+4QcYqQoQL6+mQj6jYntZxWlC9g28ejmUpMBCOT9P1HMfHUZMxqgg4O2ask0
         5oAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        fh=lJvb6MjQO/bnRRYza9g5fsRuvP4xFQx4YVnqUwNpQ5Y=;
        b=qFKYZhsJY0k8t6htWa+K5abJkmnc9D6au032iblgag2wM8FG0Qupq5X79CepDSCuxZ
         F8p+iblN7IaIkfzguObgV+B55XRypazAqhmUEW3bZD6Vp7xiaOCq6ufyOKNfELds6r10
         MpXJKPxias5kTwwxjTCcLr69nb6V6O+E8Y3b0lcjj0xZrBTQdzqQ9ONqxi41btu0at9i
         2S3pCmduyIcB6uUoEqlFkgBYIv8O7mvAL6N8yzwxKf1XkABCLSy+Yvg6pioglwfiH1jN
         A698KHsASbIEiyko19JLiDpXhGUVsDcOSy9x+wTPSADchizT1LuHMRQnB2LYrbg3W+Nr
         LcnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435527; x=1786040327; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        b=GBYHkGskC3W/60mVgxyZuq99MzKq6IwMmllpmiuyP8fW71ofh312bKprI4rBFRkvmn
         RsrziMBdwyHcnbvEkVt0XvwqT/wekwoMY/FxanxEMuPFZSbQ3eCBBfcQ8U9ga2zRwXZm
         T8gmVfC/AYMjk+PEYSrqZnt19/ePl98DZOBJ3f1pJ7jWAz/D/rzkWrhWLVnLxUe9M1oF
         8u/4XmZplHV0yq72RRTP3gNS3Bl3eTHE0oxlVLtz2r4zLH2ZzxA4UUnH5UB/1OcVrLFC
         hCc3Pv6tkQkM7VhysQnVzUL4Jx4ED+mK1iuvB/lq7oTFBZ1v/X66ElNlbfhPXA2gj0tM
         HoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435527; x=1786040327;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        b=RLQwqym8iFPpNufpK7sqI17gvdzeSbPApvsmZoLMkvBVwU0MV6mR+Jjd8CnKV9gBPD
         uBOY+51iJ19XBWz12T2TVpI/WQA8ZLfUYNZHYVUdUToazQiTYdmW4Kvn0yA13M/ZSUFC
         75J9BhV5ThqyQ9EZPvEHHk1XpLW8nHdOwarm6Bl/Bz8SiOnFNUyhjwwWqomiFdg35ucB
         eQ6GjdJLEx4/UIUPMsm6hq7jb7Ejb6HoCf+27dd8P/Jqgdvn5vrUqgaz6PeK1i7K+ks5
         pZ2wNzD100ij2aOhqTvk4FVTtbDmY3pAzzGBV9SKcu2fHF3O6Jm5yu3IhxQwtdUtIHj+
         LsMg==
X-Forwarded-Encrypted: i=1; AHgh+RrFI5YQnze+xv6M7UgmMaOlGwKExgVICTDfCohZom238DMMoEkMya3W516sY4fQHTGMY9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxooyuca9KjQxXTYMZRVZ0ChlGiE5xpz0+41OCFspvuOztAeX07
	D2m54rPqqHvMuKKqglAGh3zEZgumpelnCveAkYclu/rybyjB5ESJlUefh0I9vCE2jNhTbfnKvbp
	VISmOHSuSx2UKKOPJcR3oHsc6XOHyil5gMMCLsnCg
X-Gm-Gg: AR+sD12mw0CiEzmY0o6A+Uv4bOUpcaHtI+XaM7DcuIpSPfRnQ/w0uyuZmAdKDvdzya+
	dN0xBHBQgDkuEDd1j+DLbWKFcnO9XBEMKVoeedznjEPwVpvlQRrxXbpQ1ZOMT/Ao4nzK7imOkfA
	5JBFjX4IUbvRjhSWyE49y8HoCkGlnubG9edxpVQLgeVn7rW8+CCrEeENBh6sz88hm7QmiBuy3ru
	UGGKXy/I3PrWvPB5uK94L3c4HeU5eFSkPQWjmdvmt57eUWmNxB01slpa2CKommgX9nW4bPVpdHm
	OzEpySn1HDkthg84KE4tA0TBajfQJ42THR1jX/o/AF6N+adjV/kbNZXFA+Z58E3+GCl7pOOrrj9
	rsIWXIXgOVWjAd3UI//fZPzu57IamdkFSkg==
X-Received: by 2002:a17:90a:d007:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-38fa7dcb036mr912482a91.8.1785435525974; Thu, 30 Jul 2026
 11:18:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:18:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:18:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-12-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-12-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:18:44 -0700
X-Gm-Features: AUfX_mzurojFzFl7kQ4jInKyqzMda986c-EWBvJn_4YyREdNQpyHfl__fqR3AfU
Message-ID: <CAEvNRgEbS06snhyHznPSqxnUrdudVEKUuOpPwnU+AJATWFBRBA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Add guest_memfd_preservation_test
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

> Add guest_memfd_preservation_test to verify that KVM VM state and guest
> memory backed by guest_memfd are preserved across a kexec reboot via Live
> Update Orchestrator (LUO).
>
> This test includes multiple tests
> - (A) Test to preserve non-guest_memfd, non-memfd which must fail (/dev/null)
> - (B) Test to preserve guest_memfd with no INIT_SHARED flag which must fail
> - (C) Test to allocate the guest_memfd memory after preservation because
>   preservation makes the guest_memfd frozen. Which must fail as well.
> - (D) Test to verify guest_memfd with INIT_SHARED flag preservation across
>   kexec: Below is the details of stages in this test.
>

I think we should split this into multiple patches, where each patch
introduces 1 test.

>
> [...snip...]
>
> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Google LLC.
> + *
> + * Author: Tarun Sahu <tarunsahu@google.com>
> + *
> + * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
> + *
> + * NOTE: This is a MANUAL test and is excluded from automated CI/testing
> + * frameworks because Stage 1 daemonizes into the background to pin resources
> + * and requires a human operator to manually trigger kexec before Stage 2
> + * is executed. Running Stage 1 automatically would leak the background daemon
> + * and cause CI runners to falsely interpret it as a passed test.
> + *

Usually there aren't many printfs in tests, but since this is a MANUAL
test, maybe that's ok?

Would like to know what Sean thinks of this, and printfs in general.

>
> [...snip...]
>
