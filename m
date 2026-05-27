Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211230DEA2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906416; cv=pass; b=MDliCaR6PNX+6FtPpahj45c5fgyrEKm+akRd1QTIFekruLT8i+7jVypNRbSwxUEd/2MUY7e24GhT5qXv/d2/z7ewnUAo0aKOSTEYwbANm4So+OhV3mu13xN13Ja4ev8gLcqVwhHQ+ZDfUZneISJTA3jKNV5Xtr5W5hR/MhRdg5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906416; c=relaxed/simple;
	bh=tPsrfPW5bZefyiKbaf6LHkY8HvaXssuCnsvnGM6KYho=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/d70vq5IeNDmwhIBWLqIn+lTk4W1dOw2VxVgsuzwsoRHuRJD/tvaaNKceXhbQILKOoQN8465om8f3PUuaorRLf2Ui9HdfH0kxOKFDaiDwIKC/lY3FMkSY+jg48Ojk6otOdFebWMOWQNcLQWa6ZJeWvyiERhZoriuWJQJC3JAy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyKegGBn; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyKegGBn"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1353c2f35cfso2395731c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779906414; cv=none;
        d=google.com; s=arc-20240605;
        b=h9bBkHHW9yh7T5DEKEqIdkxZJeHWCkpLgdCE12j8xL43ssYXNlFHgzkAaGuBfwJzBP
         i4uGtE42xZV+pVRzXUVMyYTSMCCeVoSWuUd6KK4DkPnELATvsSrutDCoToBWBNcLIu6K
         wVyzhM2ANMZ8wV2KywqZ1M6MgTQc8PXmT4JgZWUcLrkbW4FtCy8YbBXnml8EUG6f8ruM
         nbPqrXoVUmuZkkDE7p7QYMqIr7iBLqwOaP4pWS9gVpl0lemduSN3AHaXX2eaFsfORFjr
         bIDM5l2cyDPY52k8aKOB14+O1I9LXTu5r71OGb+ojm1oAAobpKglX1zKPGq5zLeCc/Q/
         wtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1M8LOk215LWTMh/84HS+iqt1k1lVeoWrd0lr6YJMoS0=;
        fh=Vk6w1sE1wLaCKcKtqA8kGXORJpy0PrD2TknXo8xVuZQ=;
        b=kzMOs/U4Z8pYTzO0GURGhMk1DxYjn520m2rN7kFm9uli6Ci1k950VA9wiWHpSlXZHG
         Uejm1gQwC5kCaW5SRGyR0F9JgBq5mpPgt7yOoa2NbAN5mTPKv3950GvzR9ADmwVX1ubl
         6dInjKivu4Y5T/m5h9jNXJKSPjpTM0dr4Bur4fAh15SWpl0I70bCyRarMryRmhS8G2W4
         rj+XHuOov/cLtPdLv6NZnpa430CZhFxFY4xLivwk4lDXRVtAawok5R3YSlu2x7U9niIB
         hPg3vl9CT8UoNO7yiAc0ra/mcaPFzpJq0j1OKgOuLGxNspINvqtzcU55Q/LPZt15WBdN
         XvlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779906414; x=1780511214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1M8LOk215LWTMh/84HS+iqt1k1lVeoWrd0lr6YJMoS0=;
        b=dyKegGBngSg9VmdkGm/0V+BdxQG1q+FDsGY49OmBjrn3R7b3JzZEbV18PAxwspV/gK
         Ksgp5p7C5UYONUdnbsWiNh7VnlbJB2lsxudaOYDmo8Lx91KfUmfuvgRblXFd2g4FGH5o
         3fa90V01OdMpNXpqmy6gf/HEEiQN28Hg9I+a02GqvtU7wqF2xz4Xc2qAURiHfpsyewyU
         ixt/aLH1ZZoSc+QfyGmuvHplMYY05qU2JQ/SxiEnqPUXff8v2KYt1Ds5FmIdarUsOtKw
         4XmeWfLSGi2MOvOKS3gCnacrOLjkgQQeWoVf7V8Vy3OBFOUFurVsB41OTzMiB+mttydT
         1AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779906414; x=1780511214;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M8LOk215LWTMh/84HS+iqt1k1lVeoWrd0lr6YJMoS0=;
        b=MsH8/PQdIBHl1A/2NXf0G9s33ovUEUPbkYy7f2OAlIIMzyowlUXT2cOOQOPHdRUPk8
         5/uu4s7YLMTEvGQFS+9mRAF1XAIyBFhaoHfrrk9+PkY29AHnhNbqbLt9H/kqF7PEKTNg
         Nxdv59bNBy352FA4Z+YHSX5vG91ITUE0451786V71diEBtY7BYx68tmeOTQ6iijj4q5L
         PYBCkOM6hCjNyDbZ0a/RqLdqg2535dBGaOI6tO5c+ulEBHFvHiYXVzzplemxuXPN2UPF
         MupICqqqxegcfHvoWklKm26pD4lPS2lPNMVSe4R6CHY0Q4rRH4z8ZDF61X2xDnC9CmCe
         WBMg==
X-Forwarded-Encrypted: i=1; AFNElJ95g+2VconJ/RLlUHLMDQmgNH8f/sIhd59gKT6tXPZU2tlQCiM/+tjBAt7+AS43Sig4J0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iMyqqvPJTr/J2xw0Y4ggyxlyqwS2QEr5OVToxl9GqYJ5D6gi
	TZOSgEJuXjyb6pGSiJkn6g9QAScniP7GuV8eXtVSk0XAbS+RGwCP/4p6ZqIWUXupXWDqombedX0
	Ob3Z9gmfFKR77m3ilCMao7aba94Kr0W6D+HtivNNv
X-Gm-Gg: Acq92OG3DBTzAh9HLYvyAnkxWwnNYGm5///oyAhWCDOYhHgGkmympuUQs24P7CVN637
	IkI0nRjX/t8nuFKZyL/3DCDkQb3p0AFoQwBfshozbpAmG+3QVEmN4CdyfsiBxhcCVnFtM23djc8
	jAJOOSLCqOiLbRq8S0qox6k/vsx/SaIEoQdxGrr8svT9YvjKZhUzJgotARTOn2Sc2JyWSwm6s5B
	oBS3R4xFvU6QF/9FECrjavjUpssq48ZSoDEjuWysiNcb/1DNnHWObQmWAkWElUeTNqZHljS2Ef2
	hc9VatZ25J5+bTtfV7wpQBHa5G68BIqu/BAnrYseC/1KMwmQ3lTNBSILLYNU1aEPgCSHhd/j5o3
	b7B8j
X-Received: by 2002:a05:701b:2213:b0:136:6d82:18ce with SMTP id
 a92af1059eb24-1366d821b5dmr5566033c88.23.1779906413085; Wed, 27 May 2026
 11:26:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 11:26:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 11:26:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahXB_tBWakUUjt6q@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-2-3f196bfad5a1@google.com> <ahXB_tBWakUUjt6q@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 11:26:52 -0700
X-Gm-Features: AVHnY4Ls2kneN5XVP2dglAqAa4pgbDzMnuIqiys0DrGdKxZiolxkE6U_yQMFg7A
Message-ID: <CAEvNRgEN6syKVLjvFX-s=xU=r3CBZ3KtmeKvVYOC09uvFGXSFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: guest_memfd: Fix possible signed integer overflow
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> For shortlogs (and changeloges), when possible, describe the _change_ itself, not
> its impact is.	Sometimes "Fix xyz" is the best shortlog, e.g. when fixing build
> failures, but here, I would go with:
>
>   KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
>
> for two reasons.  First, it provides a lot more context for future readers, versus
> "Fix possible signed integer overflow" which doesn't even capture what flow is
> affected, how the overflow is being fixed, etc.  Second, if the fix is wrong,
> incomplete, etc., we don't end up with a follow-up patch that start with "Really
> fix ...".
>

Thanks for explaining!

> Oh, actually, three reasons.  This doesn't only affect the overflow check.  The
> check on a negative offset is flawed, as it means KVM would incorrectly reject
> bindings with (comically) large offsets.
>

Makes sense.

> LOL, four.  There is no bug.  The size of the memslot is ((1UL << 31) - 1)
> pages, i.e. 0x7FF_FFFFF000:
>
> 	if (id < KVM_USER_MEM_SLOTS &&
> 	    (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
> 		return -EINVAL;
>
> and so "loff_t size" can never be negative.
>

I think the bug was that the sum of offset + size in kvm_gmem_bind()
when interpreted as signed integers could be smaller than
i_size_read(inode) and allow binding.

So IIUC even if size is small (and not negative), nothing catches a
large enough offset where offset + size (interpreted as unsigned
integers) doesn't overflow, but offset + size (interpreted as signed
integers) overflows.

> As for the offset, the negative check is intentional, because KVM_CREATE_GUEST_MEMFD
> takes loff_t for the size, and so an offset that is negative would also be larger
> than the size of the file.
>
> I still think it's worth taking unsigned values, because teasing out all of that
> information wasn't exactly easy.
>

Yup it's still easier this way, and your proposed shortlog is good.

> On Fri, May 22, 2026, Ackerley Tng wrote:
>> From: Sean Christopherson <seanjc@google.com>
>>
>> The caller, kvm_set_memory_region(), checks for an overflow in an unsigned
>> u64 guest_memfd_offset. When guest_memfd_offset is passed to kvm_gmem_bind,
>> it is cast into a signed 64-bit integer.
>>
>> Hence, a large 64-bit offset could result in a negative loff_t, which could
>> result in the overflow checks failing.
>>
>> Make kvm_gmem_bind() take u64 instead of loff_t to consistently deal with
>> unsigned values to avoid this issue.
>>
>> Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> [Use size_t for size instead of u64]
>
> Why?  Oh, right, because kvm_memory_slot.npages is an "unsigned long".  The
> discrepancy between a u64 for the offset and a size_t for the size is confusing,
> as they are both conceptually in the same "domain".
>
> Rather than u64 and size_t, we should use pgoff_t, which is what KVM already uses
> as the storage for kvm_memory_slot.gmem.pgoff.
>

I picked size_t more because I thought it was semantically correct to
use the size type for a size. size_t may have different sizes (64 vs
32), but in the comparison offset + size > i_size_read(inode), size is
promoted to 64 bits, and signed inode size is cast to unsigned for
comparison, so I think that works.

pgoff_t is also unsigned, but I think that should be reserved for page
offsets/indices? Is that the way to think when choosing types? What does
"domain" mean above?

> I'll send a new version as a standalone patch.
