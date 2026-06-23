Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA53C1977
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225392; cv=pass; b=gIk0lSslRbHkOxTkQ+kFrgCa7u9I0PysIlz0rvSIvDA90N3u9WMPKBRnfmEPslLG4zCydVYSrm6EBDZvBrwEtzfnIA/KmFbalaSz3pHu7L4tBhQRmOGEuSjmku8dwZeOmfgYceweDiS2QsOSrASwkI5LwopBj69qjpXFVW37O14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225392; c=relaxed/simple;
	bh=/3EwYVse55XcLg2zXjtfzrzJAQ2yCF8sQYzT3W5N7/Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsCFqvzqumFh1SV2D9rg+OdP3cNeb/ANazF9YFZ1F4zxnI999XKYBonU1XwbziUMEhX25++ddHjYuXoy0Fc9fPff0Kj3kdLMS1TPLAwHCWwdzWb//h9uDezt8qVEihUYQpj4p1OPEdAg2UVRVEphx7AdOAkwE17v2A/oN0XYb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzO+Weqh; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzO+Weqh"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso9298639c88.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 07:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782225389; cv=none;
        d=google.com; s=arc-20240605;
        b=GeUr71fORtYyUgCInEGnN9sQC3V6kuKkZfpwzNOJQTVGgXuFqeP/EY2O2a8zcBCKw9
         cjCVWh8q1mnJdtTDGVFA8zil5+9fL/BrOWtg3+vYVfhUXGWklpu44ixQfsUqs2wtn7Jc
         9palWJre/utLrKhjcD4CirkvEx2BjVRP4P4Exl6t8ndR1eVk6nttlP2HqN8xc/z6aPCs
         8OCHQyOcYwL9Busr9ghc/+y9gFkHLM9zjrx7/hOJQNr1rlNp+agBTfpoJ114xp+r6Sch
         ABgdHmp7PhypyRRlvzq/fHE9I9wCpqqnHrGX1F9hIwJQV4T8+XvHmoKqL2fFbXDbshxS
         diyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=vJgphXJdnNJlLlw3xwPgUoTcSpATvUHMKFRtOKS6dyU=;
        fh=oQKl3z1YuZQACL71AjnmcQxoL4FYVaXJJeOF6RdgwfQ=;
        b=Nt9LA1PmJs/MZWpM9ZHIQAezYqb+JIqp1CijyioonWsCBAeSqdsHQnMhKUo/n1RDI1
         nnYfxWYaRjasmyBpAtyjVKQuaRizsCxWHZ9bLyNDZuUyzAsw40tzoO3q8yR9KPJPo5oL
         2rnVmqZqkLk1NS/hhIAe95UQi+pOcLCo3vDffP7lY1+uXf6V0Wzx3edg9pGHPuuKB23z
         /bqaSGRV66DndOiImwZCQQ/asIE0S5jftmz0jiy/6R7soYZmqQ7YfVG0DdGw27FkLcrm
         kLv/65F5DxSFAiU2BKEUdCLGUrX13ibS+bTmV+hxgyXWC2bFoCt+T+3jdiYaWXuQqiXX
         90+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782225389; x=1782830189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJgphXJdnNJlLlw3xwPgUoTcSpATvUHMKFRtOKS6dyU=;
        b=JzO+WeqhdW1akn0JULHUDOCZmtj7Rb3qytab1TBtG1zWLPy1Eq0liT3siTT4sFvfgW
         9ikO2e1mQbON/IB0GKNQMMvJgwsf7pUr8YYwNRnBY2Lyd+QF5zbO+mL6OEQE68Tb+ut7
         G6y+0bNmJYGic0tyiRG0ED5FQSS70y7GqUWgB3mTMfuFg1Mx2SgN42b9jWC9TmLEdY8S
         GgEUqmGq7s9+Kj+TjxprPazxLY6kOql3U902CVRVyPXLFMFiPuMumltdJaFP3EHkNPlr
         cn7bgZ2Wx2YTI0Sueuxvd5Z4UYyG1j/Im3rfXkFoHLmNCBgfNqpa8GFTcrwIXUkBVpLi
         XPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225389; x=1782830189;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJgphXJdnNJlLlw3xwPgUoTcSpATvUHMKFRtOKS6dyU=;
        b=Eg1jRW5tltB3mXiHExH21kkno8lgN7d7fJI6roGKAroY4Q8qXPqDVRatrFPHNj0jIe
         zZePoSvPOHXhjPAYkHtFyXbNWevnF4cuwuszuFmGygjtKfbist4jU2u1fL8USy5GmULk
         0G+s8MEc5Ge4T2Z8u3mtUbMicqow+Hn1q4SZ+KlvD+0a+mBlBBphIHEO9LTzRPYLPXwo
         LbBjnbsjoidIN4Sc/C+WwJ07UgKiRksym9Svk3FHwk/ALs7BeCsf3s1Nqkk9E6tY0cG2
         UjTQPR2G+pqmgXoNX1bQQ3ttxe72PWwH8aspSnqV2gGsDLwK/y1MhmjsDUPKh7QbXE3g
         gEjw==
X-Gm-Message-State: AOJu0YzJXbca2BxcYUrDSzeLgDC4Q6TzjvmKg0JomFborvrEnNOINl7R
	LO6a9cCM+degJBjRe9855GSjVFE1KC2U2q18J2PyYK+5DqdoGePcy90bheT8sqsLqmBbWCW+2Vz
	t0ypCb7DXW914b2h1OsGAkB2eIIcFFHAvNjhvFHKexCNM4VC70KHvH4Mf
X-Gm-Gg: AfdE7clmK6lYtQi/5g07D0WCuTSp+P1z80AP4c5pmYp8S45qsYzK2sy3+nd37ntspRl
	gQLHrrn6bP2mtwQsMp8twNTeqKx2BzQOw1Oa8Okf6AT3DhJxsIrYqBKrjn4MYcpFOdM84LCc8v2
	rWkTEqtKXRJ0zdoV+IKV9B4ZNoAl4xLLDeaplTmoU0TzJTUrZkUMc4QweqxvhsEOH77u11foah+
	hjn3FMJLAfBr8swBPLdoLPOpLQsOwY0dsKbhS9KH+P691CMLN/EDBxBw+w/+gNZjccx6KUmd298
	h0bhnxMgkCRLZhgKmR0jIgbktsJr
X-Received: by 2002:a05:7022:2204:b0:139:7f71:9ce8 with SMTP id
 a92af1059eb24-139a3456498mr9963525c88.0.1782225388222; Tue, 23 Jun 2026
 07:36:28 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 07:36:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 07:36:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260623093335.3C1F91F00A3A@smtp.kernel.org>
References: <20260623091556.1500930-1-joro@8bytes.org> <20260623091556.1500930-5-joro@8bytes.org>
 <20260623093335.3C1F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 07:36:26 -0700
X-Gm-Features: AVVi8CfVMQhPCLdKi-Kz2N8bfv78RoIZSO1YpQwS89D-4s2CIn8OJqjaOGeR-hw
Message-ID: <CAEvNRgHy9m9RZzu21Un6rNh6iQs55xVjiFZw-Lou9ES3cjqc_Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] kvm: sev: Acquire a writeable page reference for
 CPUID pages
To: sashiko-reviews@lists.linux.dev, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
> [...snip...]
>

Thanks Jorg, commit f13e90059908 ("KVM: SEV: Pin source page for write
when adding CPUID data for SNP guest") is a combination of this patch
and the previous, so this is fixed too.

This report caught my attention:

> [Severity: High]
> This is a pre-existing issue, but is there a data race and use-after-free
> risk on kvm_memory_slot between memslot teardown and kvm_gmem_error_folio=
()?
>
> When KVM destroys a memslot, kvm_gmem_unbind() fast-paths the teardown if
> there is no file:
>
> virt/kvm/guest_memfd.c:kvm_gmem_unbind() {
>     if (!file) {
>         __kvm_gmem_unbind(slot, slot->gmem.file->private_data);
>         return;
>     }
>     ...
> }
>
> This deliberately skips acquiring filemap_invalidate_lock(file->f_mapping=
).
>

Here's how kvm_gmem_unbind() relates to kvm_gmem_release():

This unbinding without filemap_invalidate_lock() covers the case where

+ During VM destruction, the memslots are being destroyed:
  kvm_gmem_unbind() is reached without holding slots_lock

and

+ There's a concurrent guest_memfd kvm_gmem_release()

slot->gmem.file is not NULL (yet, kvm_gmem_release() would set that),
but the file is already closed, hence kvm_gmem_get_file() returns
NULL. (See CLASS(gmem_get_file, file)(slot);).

Since kvm_gmem_get_file() returns NULL, there's no way to safely take
the filemap_invalidate_lock(), but we must still do the
unbinding. Without unbinding, kvm_gmem_release() would iterate
f->bindings and use slot after free.

> If a hardware memory failure concurrently triggers kvm_gmem_error_folio()=
,
> it iterates over f->bindings holding only filemap_invalidate_lock_shared(=
).
>

To get to the above unbinding without holding filemap_invalidate_lock(),
the file would have to already be closed. If the file is closed, the
inode (and folios) can still be alive. Memory failure can look up the
folios and hence the inode.

But to reach __kvm_gmem_invalidate_begin() from kvm_gmem_error_folio(),
we'd have to iterate the files associated with the inode
(kvm_gmem_for_each_file() in kvm_gmem_invalidate()). Since the file is
already closed to unbind without filemap_invalidate_lock(), the
kvm_gmem_error_folio() side won't see the file.

> Because xa_for_each_range() drops the internal RCU lock for each element,
> could it yield the slot pointer right as kvm_gmem_unbind() completes and
> frees it, leading to a dereference of freed memory here?
>

No issue here. Phew.

> virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_begin() {
>     ...
>     .start =3D slot->base_gfn + max(pgoff, start) - pgoff,
>     ...
> }
>
>>  	if (count < 0) {
>>  		argp->error =3D sev_populate_args.fw_error;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091556.15=
00930-1-joro@8bytes.org?part=3D4
