Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833535972
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050291; cv=none; b=QSZiNL0B1jgNkN1eXzVlNB8W6A11dj39LMihYJJ9UNqgAJX7AH1uQXW9OBtRqPFzmr3xhFvehEh+mfvNwm0S8zqNx6LHHxw09EJMBetKecxj844crikgvPTlx97z5VlP5jqkiPAvTdWD1gva7lyKg95YI6vR0ZiOrSVPk/9vss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050291; c=relaxed/simple;
	bh=hZFqquEZqJBGrnGxDSkR0ndXDNP5R9GcijNMkFqmzpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qA8P5nMJ+qml7D+d8pLtNquhC9zJmQRV8Xz0Jkj5t19qU3igskN7bgSL6+3j0EUslhoU1rtgJHqslM/vokUMxw/PfcB78H9yOpezTWG2xlb4GzMyTAD1ZE1QMdQJGvzjILQ892Ea8Bh8ZO5EbzD/gqjBy7sBmYKK3dr0BhJGuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCqM/Lw8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCqM/Lw8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2b64850easo10664215ad.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781050289; x=1781655089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hEZdMtlwFOOH1VupywFc8dFw7czdrMA0OQSlYyLi9c=;
        b=kCqM/Lw8hsqU8T+qNHD3GrayTwJU1X/uRFT/X+DR08eTsogyTXk0ugGdNK1iUjXQVk
         4j5/Twy0H30pGqSqdfCSftx3MRPG7UtpsLtt0tI7m+CWR1Ys9nSoDbHejHj5cNr8oAyo
         vGniOXSe5ZaVprmMkoZKnU9w8kr9ic805eGJjGxkcogCIeni1019Wx2hL4N9TA1u/RJG
         GajJdZD6sdHNY9mgYW/+Vf9Iau6fm91I5ZMZvHvqmtxRS9dyH27R2OlQTf7D+gpUIsq7
         4L7SF2Fu/vOmSEU4w/BwoT0VEi8wknnLs8tNlspcbaAV5rnKVavSebLKcDuVQ8QM0Swh
         RHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781050289; x=1781655089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hEZdMtlwFOOH1VupywFc8dFw7czdrMA0OQSlYyLi9c=;
        b=SefULhGHbrvGRD1wmru09wzSEWzTLNmVC3+EoYQDTiQvhmRCqS4F7dLXYEZpis4PeS
         MEufOG8LGz80yY6atryDZKUotWI3BUYmZYDhUEJstZRBMYasfJQb1vp/+vtAvENWaXXH
         3lKzo9P0Prgz0TAL4S2RYUYPgbnadPH5x7lP78FnSt/ptTuYu8vp9mqZsUBoXiUJmfgc
         FdC4nRB8UScfRtPsaIQpCgVx/u6XJ+FbGQja9/SSltnYuybzgzbI6HdFyo9yv468nHu3
         Vbgia5NsUErbquzMWmdAg6Hn570+xj6K8dgwOdgX5HXT/E6Dm7K/mIVJ3GGJzAuzXjCk
         APEw==
X-Forwarded-Encrypted: i=1; AFNElJ959TRptxQrynLhJ60osmWTvGOvSLggzUUNfBALWFgWRssjoL2VeZVvVvkJO+Vnc333pGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2GO8MDcCIH6B1iPzjVu9CaX4jOImva6lcdvVMsXU0SQkgPXr
	ZeyRVzqlgsG8u0D6LPQTp+9E3qIsg1xm5OeUFkMMV8U0ejMrLJjS4KO9PKTIepXIwq5vmqYxpVL
	Mv2NUpg==
X-Received: from plbkn11.prod.google.com ([2002:a17:903:78b:b0:2bf:b2c:fa1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef09:b0:2c2:5446:30e1
 with SMTP id d9443c01a7336-2c254463556mr145784535ad.11.1781050289164; Tue, 09
 Jun 2026 17:11:29 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:11:28 -0700
In-Reply-To: <CAEvNRgFkfqirL6hZDk5eugeaf4u7J_=a0xj6RdE=QnG5T6N29A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
 <20260523010752.CA7AF1F000E9@smtp.kernel.org> <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
 <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t>
 <44o2z5j553adpapnyequmk2t6cukor2wjm5urujhrnqhufogh7@jbsolz5b4i2b> <CAEvNRgFkfqirL6hZDk5eugeaf4u7J_=a0xj6RdE=QnG5T6N29A@mail.gmail.com>
Message-ID: <aiirsJFic_naddv7@google.com>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Michael Roth <michael.roth@amd.com>, sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Ackerley Tng wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> >
> > [...snip...]
> >
> >> > > When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
> >> > > __kvm_gmem_populate() attempts an in-place conversion. If the target
> >> > > guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
> >> > > using GFP_HIGHUSER, which lacks __GFP_ZERO.
> >>
> >> For in-place conversion, if src is NULL, it's generally because src *is*
> >> the target and it makes no sense to copy the page to itself because
> >> userspace already initialized it, which means userspace should have already
> >> trigged the uptodate flag to be set via kvm_gmem_fault_user_mapping().
> >>
> >> So maybe to address the malicious case that Sashiko seems to be worried
> >> about (where VMM purposely doesn't touch/init the memory to try to leak data
> >> into the guest), we just need to error out if: !src && !folio_uptodate(folio)?
> >
> > Of course immediately after posting this I think of exceptional cases, like
> > SEV-SNP can set up pre-zero'd private guest pages via this path, where
> > userspace wouldn't necessarily have done any touching/init of the page
> > in advance.
> >
> 
> Are you referring to KVM_SEV_SNP_PAGE_TYPE_ZERO?
> 
> > BUT.... in that case it would be okay, because the kernel knows
> > everything would get zero'd.
> >
> > So maybe the post-populate callbacks need to be the ones that would need
> > to implement these checks, or some API to that gmem can do it on their
> > behalf...
> >
> > So maybe your proposed patch is the more straightforward fix for now.
> >
> 
> Is KVM_SEV_SNP_PAGE_TYPE_ZERO expected to be used for a large number
> pages? If not, I think we can defer this to a future optimization, like
> in snp_launch_update(), if KVM_SEV_SNP_PAGE_TYPE_ZERO, pass a flag
> through to __kvm_gmem_get_pfn() to skip zeroing?
> 
> For all other page types, __kvm_gmem_get_pfn() MUST zero to avoid the
> issue Sashiko pointed out, right?

Or we do as Mike suggested, and outright reject the populate() call.  But I think
for ABI purposes, zeroing memory is the right approach, otherwise we'll end up
with a discrepancy between the userfault path and populate().

As I mentioned in the cover letter, initial guest image will typically be a tiny
subset of guest memory, so I don't have any concerns with unnecessarily zeroing
a few pages (memory that is ultimately overwritten by userspace).

> Currently, kvm_gmem_fault_user_mapping() will zero, and then userspace
> presumably writes the entire page. Can't avoid zeroing to avoid leaking
> uninitialized memory.
> 
> To avoid that zeroing, I guess there's the future guest_memfd write()
> syscall too, userspace can write() the entire page - write in the kernel
> can avoid zeroing since it knows which parts of the page was written and
> set uptodate. Then, kvm_gmem_fault_user_mapping() won't zero since the
> page is uptodate, and populate will not zero since it was also uptodate.


