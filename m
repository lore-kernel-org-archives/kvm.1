Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF638F652
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336949; cv=none; b=Htg5xBy7TIM9sH3spfiHRdlG1X8wbnrvVSf8O7M4j+szs1LvOznnUZlarIaJQ7gEi3L/C3E0RGVQCcy503y/zONyXDfIow/+PCL2T5ztTz7aYWM8QKmWUou5FCbhXhRlVEpdhFlD/eWkdBAgCEo4WzghclAwt8qaKvwa0B7YT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336949; c=relaxed/simple;
	bh=+5CU38TjayLgUsMwABxHDvHoIdxKMOk6Azb3VwX8dK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F79Dh4mzfUsU1VDUl2Z6yYQuReAwBXc971HszYyE8biUpgH1QC7iMbeORsKW3gKEUfM/Q1zkM1uAB1xN2HIds5/QtZqJ8v72E6ctLTy2SORR+zT15fM121YHUxlT2ZoVv+BSzxFnu70iKx06y4YJUoVLwajDhyPmHGiUnSGFLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfKK6+PE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfKK6+PE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae669a8ff1so81157735ad.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336948; x=1773941748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxk9c6Zd8eZqtwP+AY0gZxtNA4u+UHveBD+XZhsy40c=;
        b=nfKK6+PENGU3/iTf5Rwxfq+nP19r1dZe7w19AL1Sc1Iv4VqUpIoXISkVH27PNTDpUU
         kNNsK8R0qTXyNSGELQKodld4HivkrXm7Px5CRuZAarZ5k0paW1PMcaS8xIYEVe/fFe4l
         08KvqLN9+R9r+coEk+BtLtAGOf9h0v8/6ADCV3sj4XHmrSQs9tAFmMxmrhU0nrYrn+z6
         qYYko3asObHbhkVz9lT3F1FhiLRmMpb2pj2LxGU8JVI2rn6v/C1IJRxoSLUI8ToiRTWH
         jXEMrCGWvyb1yI14uwH4ABU/tNOcXVl0kO9xR0NK8HbcUu5n7sBvi65C+h1584BKgcIR
         a+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336948; x=1773941748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxk9c6Zd8eZqtwP+AY0gZxtNA4u+UHveBD+XZhsy40c=;
        b=CQyzm7k9J/uGQrDctD4Mrfy7w9ZCsZqgvWTsbOINPCCv1ahZZp+8Jgc5hHdejMNYUd
         i1wWYeyKSU6IUbR/eIyfQav88CQ1CHHoo4iFIHGlSbpNzh3lcPvcTC4gc/NseUOgFp0e
         GRJhCUFF3nZcrVaZvdJcv+UvxDtIclRdBXGpeJ9KEAFRbbwQny54HHwHusEyenu486VX
         N5CzAyRgxqNKhFQDBe3MiR4Mng5JN5RtKx1p/Mb0h0f9oFL2a+qe+L2fWJWV+0WJS6cy
         1RrEj+tuil2sV5aQYHUGLiFhuZX0CIjXS+GVyoHaEFQcXfS5ny6uboBUAVYTvG7rs+uT
         MB3g==
X-Forwarded-Encrypted: i=1; AJvYcCXa5Ah5j1wijvda7kBScyuTJthkMO0B6QtR1tTHudwdC1I40IwfQEh8F5giCrel1LKwO+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOA7gYDOaxgRteuSXKGuD+gLdLS+/eUU179K95TL3s7H9j1BTG
	KoDRIZ41mM1UvzBar7zrXAq6CNQ++9CKWW0fwpjc9Wi3pYREnS/YDeqVjXTuB+pcsovSlRGP5Oi
	inIR1iw==
X-Received: from plv14.prod.google.com ([2002:a17:903:bce:b0:2ae:506a:658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230a:b0:2ae:45b3:b688
 with SMTP id d9443c01a7336-2aecac5fa42mr3094135ad.45.1773336947572; Thu, 12
 Mar 2026 10:35:47 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:35:46 -0700
In-Reply-To: <20260123090304.32286-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123090304.32286-1-jiangshanlai@gmail.com>
Message-ID: <abL5ckz92pGbZ5uc@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Don't check old SPTE permissions when
 trying to unsync
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 23, 2026, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Commit ecc5589f19a5 ("KVM: MMU: optimize set_spte for page sync") added
> a writable permission check on the old SPTE to avoid unnecessary calls
> to mmu_try_to_unsync_pages() when syncing SPTEs.
> 
> Later, commit e6722d9211b2 ("KVM: x86/mmu: Reduce the update to the spte
> in FNAME(sync_spte)") indirectly achieves it by avoiding some SPTE
> updates altogether, which makes the writable permission check in
> make_spte() much less useful.
> 
> Remove the old-SPTE writable permission check from make_spte() to
> simplify the code.
> 
> This may cause mmu_try_to_unsync_pages() to be called in a few
> additional cases not covered by commit e6722d9211b2, such as when the
> guest toggles the execute bit, which is expected to be rare.

Hmm, but it would also apply to spurious faults.  The TDP MMU largely guards
against that behavior thanks to commit 386d69f9f29b ("KVM: x86/mmu: Treat TDP MMU
faults as spurious if access is already allowed"), but the shadow MMU does not.

Booting a 24 vCPU VM with shadowing paging gets ~3000 hits on the optimizations,
which isn't a ton, but it's definitely not 0 either.  And while I'm generally all
about simplifying code, I'm also generally very hesitant to tweak shadow paging
optimizations without strong evidence for doing so.

Is there an ulterior motive to this change, e.g. does it allow for additional
cleanups, or is simplifying the code the main goal?
