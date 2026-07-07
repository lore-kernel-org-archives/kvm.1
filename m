Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE01684BE
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383919; cv=none; b=mgERfa6HcNbgM1nMff7kfI1+v8Kd4e08J0FJ/4/1CW25S9Hl/huTEqrTxizjLhQA/XXw8E4x1hNTSAymNwyeaRNQwGcBCqInpDiN9IC0ENX5UaCW67DxCF6DtFvNcknmMGQpGBmhklK6VNT6n/y4iUuPqhxYZFX/Fmtd+MUzodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383919; c=relaxed/simple;
	bh=7x/R57qudJvKK/D5Vz7Hi1BoiQPVT6Eb3LFhPmwn7/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BIPt4Zu7/87xI7jNdMgYZ4gd7IvTkALYMrWtZE9MQ2hTYHoAQyIRFtXvnhuoplkS0GbWSQAm0T5K5EnbZJ49NPdCfeH+1gX5fcpknKMbd1N2Dtia4Mu6yPzu7n9zLaBScEktLpGU3qWxSxY7Y1LOh5X4me0/GMppUn0oXnSqSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UevzTKaL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UevzTKaL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c8018f11fbso45881425ad.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783383918; x=1783988718; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2tUu5e71+Sget3gJMSknqgMwie3pm4NkHG0E3M9coA=;
        b=UevzTKaLqFeXEg8KXz9f4gfJ2fi/x6L1C5AIWHVRJy7xeYePfp95tchpb1Z5LnmWP9
         ptfVoKSviSRTRq0bSktMaertVyi/rergZQR1vW0M6NfF0iLdPn7x4VzxutD6DBdNMQno
         wL8bBkxDA4Hf4i8YlN+5FmvGf7dsysHKhXglM/JiXcpLPgKrqQ+dr2AGGQfon6cKoj1t
         i7wRYBWxFqumr2gPvtvMlBflMWLCJDVAqbypHr2LfLJdN09oLwYVDHQUhpWmBotR+knh
         jpIerBf+sQoaggQAvdGCNbZ57LT5HJE3GjG0czflvwUujWfxNIpVXBPinj0xLtAwG59R
         aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783383918; x=1783988718;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2tUu5e71+Sget3gJMSknqgMwie3pm4NkHG0E3M9coA=;
        b=nigt5RYDPHLSODI9jroRZeQ6q+KxkmQvCZCNjnmDsgbE0XTZnuvzal1IrvgnkBSNMh
         hV1bctylQYjfWu+mlIx2i6fq2/bUGzsZqgpvmBWwZCko6faFt/JfD7zIpqJylmsoq+st
         Y5MIy12ObRdLG4kXk1syoFoJrB84mb/YMw9RchqhoBunE9Ea7Jb4m7JKLyODA2gscpuW
         TGToPGk96Fjb+s4Prd2DKNQ7oUKlIEynYbqdVq8IdSlaj3ZsmkDEzTnUgDCg2H/QJxjW
         9m280PuxrgFaBp4CqZw3vnZ/Y4iS6Vw3M6YPPj5oll3NDx02iy6jXIsd/YLdEpGxqnoq
         TvTg==
X-Gm-Message-State: AOJu0Yw8s5WCvjkmnTgle7XSv4xH3XbOYlxQ3nx5aV0/ZC4bhXurZwbu
	/HSPSQW79lXkbN9ZNBHkGYPO5iB6ItOhnMjer4X5uvK/rvKp9cN01RPlhhhfIHnMVOcXCi7MiUs
	3PN2rGQ==
X-Received: from plq4.prod.google.com ([2002:a17:903:2f84:b0:2cc:73ae:7d4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce01:b0:2ca:52ce:6f91
 with SMTP id d9443c01a7336-2ccbf056a99mr33058945ad.27.1783383917478; Mon, 06
 Jul 2026 17:25:17 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:25:16 -0700
In-Reply-To: <b9e2c377a21a53329cd70ac48309981957814686.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com> <akw-dgBE_dycts0o@google.com>
 <b9e2c377a21a53329cd70ac48309981957814686.camel@intel.com>
Message-ID: <akxHbKbMyF7PZ0Av@google.com>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Rick P Edgecombe wrote:
> On Mon, 2026-07-06 at 16:47 -0700, Sean Christopherson wrote:
> > On Mon, May 25, 2026, Rick Edgecombe wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Use control page helpers for allocating and freeing TD control structures,
> > > such these operations can work for Dynamic PAMT.
> > > 
> > > The TDX module tracks some state for each page of physical memory that it
> > > might use. It calls this state the PAMT. It includes separate state for
> > > each page size a physical page could be utilized at within the TDX module
> > > (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> > > allocated dynamically. So the kernel must install PAMT backing for each 4KB
> > > page before gifting it to the TDX module, and tear it down after the page
> > > is reclaimed.
> > > 
> > > TD-scoped control pages (TDR, TDCS) and vCPU-scoped control pages (TDVPR,
> > > TDCX) are all handed to the TDX module at 4KB page size and are therefore
> > > subject to this requirement. Replace the raw alloc_page()/__free_page()
> > > calls for these pages with tdx_alloc/free_control_page().
> > > 
> > > Switching between special Dynamic PAMT operations or normal page
> > > alloc/free operations is handled internally in
> > > tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
> > > calls. Just call them unconditionally. Similarly, drop the NULL checks
> > > before freeing, as tdx_free_control_page() handles NULL internally.
> > > 
> > > No functional change intended when Dynamic PAMT is not in use.
> > > 
> > > Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> > 
> > Exactly what assistance was given, and when?  I certainly didn't use any of these
> > tools, and given that Claude Opus 4.6 was released after I posted the v5 RFC, I
> > doubt Kirill did either.
> 
> On this patch specifically, lots of "review this patch" type experiments IIRC.
> Probably mostly around the log.
> 
> > 
> > And in my strong opinion, even if AI tooling was used to rebase the patches, I
> > don't think that level of "assistance" should be presented this way.  E.g. I would
> > rather a more informal:
> > 
> >   [ Rick: enhance log, rebase with help from AI tooling]
> > 
> > Because unless I'm missing something, claiming that AI was used to write the patch
> > is misleading and disingenuous.
> 
> Yea, I was just trying to follow the policy. It seems things are swinging the
> other way now. This works.

FWIW, my read of the official policy, even before any change in direction, is that
it only applies to using AI to write code.  It's not like we given any credit in
the patch itself when changes are made in response to code review from human.
