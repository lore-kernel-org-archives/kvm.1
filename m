Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC3379C2F
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854825; cv=none; b=CEGRpnxDXqOFLAlEgn9aO86bWt1Q5fkSljXNOEmKKt7aAwg7tsGXsEhGgZx5T75sfkgBp8+w4rVLFVp1/UTNFPC60B3uZGlzqmI63EYoNG7SRHXNqcxbUp16xaQv7lnoeigNhpkxdKRlx86QTDBPVY0tTmRm3ckE8elH5aI8vA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854825; c=relaxed/simple;
	bh=a0CQFFjGAoUgHIzygwskRfunGgt/LgtQR7hlrZcl7VQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TwxSGmS17HA/Yefvq11RjfyrpknlQFRSCXSnQWVDed2pkeuT44Ft/o/pelYJj3V4lpwK4d3XJ5E1MyKRyEGhjvo0yi1G+JVuIHWN6DVnvNNCqHb3TDTl0oeBR6NwEseq0vt0oVT8kCM2dQvp5azQv7GU438q6SITzSPM94OHdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwXp+sZN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwXp+sZN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7aba0af02so96254975ad.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778854824; x=1779459624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZQSM9XuzaJrMJ765GqHAyC1jvYGH24il9g4f0fClRs=;
        b=KwXp+sZNujmDTLsESupr5knNExmhAsumWVZbpACAxpzteBDHj7dZTyFpbuPe5KKW/z
         ls/9gDxsNEen3sDQpGg/Hd5biTEWFTD/p+uXY+Xdrhn6zF4fddQCEmm3DV+ugnr+bTUE
         gDDw1AVU6E0XShykwHQNdonpBNiOjvKULEZaswR33OGNltTM8KOpu99Y0PnW45z576c7
         QJ8/Cy/CALrGeLIRyGfb6FYa2WnLHhIRn7+KnlTrxJFdwkZ8Iv7ftc8phnQ5tzmHYh1h
         a7d8ocfSLhubNHClmviXUdOKy1WllS8LxLmDGcB2wam37/12YfMqbJYhiHbTRWN1TbuD
         ou1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854824; x=1779459624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZQSM9XuzaJrMJ765GqHAyC1jvYGH24il9g4f0fClRs=;
        b=LgEIBp/aA8BZNqQANxr4wHUNr+UlgZNhYfa+lB0MsSIRDN5IqDOEfOCe19qg0f+1W0
         ya2Z/diIOMcP5gHcTe1jZQG+yURkMdgQe3TZf274DfQxvx7xyfxjInaMXLiDxbX0cnr7
         06JCgTuBgr6jHnt2dTFggjKbsNlXokA/j5yf+klMLV5MA1KCdVJLMiZ0fBno3RAZb2/K
         0oW65eGp7YeEhD/BjpuMvlGKdSGRLK2yq9QeBH7sY1v/1NvO68n+gV2C2RISzxe/+sKr
         wXosWoET/7Dl7kh5JaB4B3FGBf18eESvhwXu3MwF129rDUSEUHohsYf4ed65P3uN9BZw
         nwiw==
X-Forwarded-Encrypted: i=1; AFNElJ9rz0p95GPu5PVfVyLRqPafkty1T9JiOrfA1TgcqJD0NWXaP8VDbb7tGZfjTScskkIb05Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9PgpFgaLheAIT1twp43LefT+yS1ilHzX4kCEzs2Xp0y6tDIr
	hEkU5kXQik6vZzJ2Gn23TqHafSr8c0q2EZg/ndVzSMHimSGUA/NufvWeVaU/LqKX8vsOz+T1dCm
	kNHmkig==
X-Received: from pgww18.prod.google.com ([2002:a05:6a02:2c92:b0:c79:67fe:6d9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3298:b0:3a2:e0d3:37d1
 with SMTP id adf61e73a8af0-3b22ec5f790mr5156353637.41.1778854823479; Fri, 15
 May 2026 07:20:23 -0700 (PDT)
Date: Fri, 15 May 2026 07:20:22 -0700
In-Reply-To: <agZwE6kX_94AjCQ-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107235724.28101-1-aidan@aktech.ai> <20260107235724.28101-2-aidan@aktech.ai>
 <agUgeO5QNenQM9pT@google.com> <agZt4V4Ur8cQgikY@google.com> <agZwE6kX_94AjCQ-@google.com>
Message-ID: <agcrpj6rKoxoedtE@google.com>
Subject: Re: [PATCH v1 1/1] KVM: x86: Merge pending debug causes when
 vectoring #DB
From: Sean Christopherson <seanjc@google.com>
To: Aidan Khoury <aidan@aktech.ai>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Aidan Khoury <aidan@revers.engineering>, 
	Nick Peterson <everdox@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 14, 2026, Sean Christopherson wrote:
> On Thu, May 14, 2026, Sean Christopherson wrote:
> > On Wed, May 13, 2026, Sean Christopherson wrote:
> > > On Wed, Jan 07, 2026, Aidan Khoury wrote:
> > > So while I don't exactly love the idea, I think this?  Compile tested only at
> > > this point, I'll try to properly test it tomorrow.
> > 
> > Confirmed the below works, once I remembered how to configure debug breakpoints.
> > I'll plan on sending a v2 on your behalf, along with a KVM-Unit-Test testcase.
> 
> Ugh, and of course the test fails on AMD.  I'll still send the KVM patch, but
> I'll hold off on the KUT mini-series until I've done at least a little digging
> through the APM (I'm not exactly brimming with confidence that SVM can handle
> this correctly).

Ok, I'm not crazy, AMD SVM simply doesn't support this.  E.g. from an old paper
on making a VMM/hypervisor truly transparent:

  Similarly, native x86 CPUs hold off debug exceptions for a one-instruction
  window following MOV %SS instructions. AMD's SVM provides no information
  about pending debug exceptions if an exit occurs in such a window [2]. We
  constructed a simple SVM detector based on this discrepancy in less than
  100 lines of C and assembly.

The easy solution for the test is to skip it on AMD, but before we do any of this,
why do you care?  I.e. what prompted this patch?  If this is purely an academic
exercise, then no small part of me thinks it might be better for KVM to take an
erratum.  I.e. consistency might be better in this case, maybe?

[*] https://www.usenix.org/legacy/event/hotos07/tech/full_papers/garfinkel/garfinkel_html/paper.html#tex2html2
