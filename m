Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909D361DD0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975311; cv=none; b=aRxBUE1fiEYhf7hCSqIOySNTt/jwsTP0fsB18nKdYDj5erTj4YOinZ2OHo7jA+zw/BWPukftEInyu8IYg7R/JNHGGMMIYHYycFF6VTzjEd+/HpIFqdwNbjbKppmh39/eK8aTzxULveeysvtyAHVScW5EgHbi0px6Q7hx5hMlNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975311; c=relaxed/simple;
	bh=CPIR4cfOO+pVho6ZzHD6dITdUhwyfOO57ppsJY2rNm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nfy14TowUcPMZCIcAaU/OhsPpS/F9xIqN3KWAGP864PBdGqexa8vEUBSB1WiDwNEu8tQW5OUiz0dt2XcHGwYPas9jZYcR+shYOoF2XvVX5+SKTug3araTPN+8S9M2iwq51snSomQcqEXgM9248ycSFAkTyvMb5UHiF58OeepJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5woJoWe; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5woJoWe"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so170805ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975310; x=1791580110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4dRToHWOgfT+4W7XiwNEWOQk4GJ2aF9LF091uh62WE=;
        b=O5woJoWekko6Eejcw4RiBwEsqEudfAjVTDHszs0sjK6afBWE/UfpU0aGLXTbsrMR1c
         WmUm01kqe7hH2jsdHun8ZDuskXNGsKe8mbi5MJy/AIz9nMbC/QXnwax1/2LLQljBrOIu
         nYuoEjd92wbFqHwFzRvelZIQ5ghNysu7hArNaKs7TBGi1HcFaSMB6nwI4mz55CigHXR9
         PmIFwtGF5GcjQoIVrVm9X80pUYPhlWmMzZDuzHLSKlmHHAVjpyPtpfgW+aFHUy4u/0Be
         9d13eaSvTbn8wJ2IMCeJ3lPhLEXq6Prux6KrTeaNqXbT7qXSwFhTJGv5+9xFqZz0xpkS
         uH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975310; x=1791580110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4dRToHWOgfT+4W7XiwNEWOQk4GJ2aF9LF091uh62WE=;
        b=0s6YFog/WpkZmZLWCmX6JXKnEsfk/Ee28vi4OZ3LzP5AN25ICRhM0ijRpNxfPa4yUS
         GNfymKARH6mmS0CWh0ee6wo0RRdYimEnV+qg7V6pZO0jy+xE0RgwubB8JQQcwGNhxpcN
         aPnZ+MZAnv0vX97lvnS/VU4tz654W17aU3yOTeOfxwHpDXT7iOSRQEAm+qLlxlcsQ4Mk
         7vdmFfHI8Y6GjwPVSTvrqo5UOBJ5aqc0RIQhOc2x9bpcKn2Q8EUbyJxwgmhZik8zEWQH
         SklJuZJNAicN65NeYt0JYBBqDQn4sJAde4Qx+9XrwhntxBhQKCqZ8Ww0/81AuCSNPqHW
         zWoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmkhM2nz3pCO36h9dFBwFeiLe866U3sI5+J+GEGC4cbMGkIvXk583Yj4FPcYEM6tLjyGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+7jO2WmNkl8HHBZjBxQDoB0kjWTrst3pCI4YScmJVRLS2CwAu
	PIp3w/9WwLjsm1wp2cZkJwKfLqB4Z3PU+3/0OZ0FpvsVQ3MxKVndfedgTpkhFd9TuYrQ5GlH6B9
	BSlfpog==
X-Received: from plbmo11.prod.google.com ([2002:a17:903:a8b:b0:2dd:288d:db3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f84:b0:2bf:7b62:a038
 with SMTP id d9443c01a7336-2e4ea1bed43mr6601705ad.9.1790975309288; Fri, 02
 Oct 2026 14:08:29 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:58 -0700
In-Reply-To: <20260918033658.21842-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918033658.21842-1-kylebot@openai.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097489635.4079213.16506372444537724558.b4-ty@b4>
Subject: Re: [PATCH v4] KVM: x86: Restrict saved GPA writes to hardware write faults
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Oleg Boiko <oboiko@openai.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 17 Sep 2026 20:36:58 -0700, Kyle Zeng wrote:
> A GPA supplied by a hardware page fault describes the access that
> faulted, not an arbitrary instruction decoded afterwards.  A guest can
> change an MMIO read into a store before KVM fetches the instruction.  The
> saved-GPA shortcut then skips the write-aware guest page-table walk and
> can issue a write through a guest-read-only mapping.
> 
> Carry hardware write-fault information into the emulator and retain it
> alongside the saved GPA.  For guests without protected page tables, only
> reuse that GPA for a write when hardware reported a write access.  Reads
> and faults with unknown access direction do not authorize an emulated
> write; fall back to the existing permission-aware translation in those
> cases.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Restrict saved GPA writes to hardware write faults
      https://github.com/kvm-x86/linux/commit/e70f812ccdd6

--
https://github.com/kvm-x86/linux/tree/next
