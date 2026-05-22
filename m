Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF038E8A1
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491448; cv=none; b=HCb0Q9j9Fump/Z3hl/uJU+fWqLHBLNjnfaPAZiGc5EIjd06uoC6WxNNq3H/G1SsZFwvTL23w7NLYPjqDWRKvOGYISsruwRJr1irvBaIN99SmJ6Euj2VaIwsqjDpXYOSOq0UkMS9vqt/2AewJUrPMPWx/rOXn04wVaGav4IpH17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491448; c=relaxed/simple;
	bh=Sr9XOyYGYH0nZyHOFB70YpQHij+Q9Bdp8f6jcW7cfNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTH+GNKn16PeqHGQlKu6JcB+OIXmCtJNpBiKpAwFTeq14nE4of8jgHSOd2SvATMuZtyLR019vPjcrCck83P0mqB/y6ag9XZ1YB28wy/XOJYfgCjA6Ts/kMPdXinKdUJbg9uMagpvBMb7vXYzG00AeV4JfjOe/YydHE85fYfDgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8st0boL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8st0boL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba115ab6bbso82170205ad.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779491446; x=1780096246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpOdttCESEioEoKDO1qBEf4+FNRAFJIi5whlp2t234I=;
        b=C8st0boLeM7YDEA9Y+6K973YR6bRLGkaDXrl4zSb25R7G8FpgEFmiXgbLa4CnC178M
         PdIH/FVAuns1qmHKfhnJQGwEBOMsHcWnGOYCqMT7wCAbIJwcKCHV6haGlxonVDMuEiuT
         bEkdkZX7fCHyBfVqlmRqiOORry9zABxQv08hLzWJE8Ehv70V1xpFT5QpDNOuJ2727Vgs
         Nw1OtOhTu7nWB9OImbUfyFI7gqqiPTqn1wlmyx8tV+CVuAIYceVsgi9POLsDghh7cm/6
         OUwmcNtHbNLpkw6ylcrQu6grto2QMIr9zNLal7Gcl0q7QxRavUKqtm58KJNNEvE33KJS
         CCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491446; x=1780096246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpOdttCESEioEoKDO1qBEf4+FNRAFJIi5whlp2t234I=;
        b=YTE3o5P4iaW8v+c/f/2H/Xpx3bQHh+GMJ4scRwebpOkJz3v9/o879CC3D2YNobiAO4
         X37qkIG+fSbpZerbij4fXu7mJj8YpIU5uaDEXGWrDICkcECFW1T55sgjntUCHpUKpir8
         PUhrXlPteYdKlhaYmkkGQpCmTSmfVaMp+Rn5P508yGSJBFJTpFK5qaMLOCyPvs2EIML4
         FmztgmTqGgftaiEj0bb3FHnawMXSwTZ7pjhKEqb4/l054qXtV8nACb7tWuGEjR97sVTq
         gw6tZ5G399YdN9h8TTpqg1hggXzuzZb4LClsalBSapNld6qPw2HswrWnnVcxxkId+VS8
         ureA==
X-Forwarded-Encrypted: i=1; AFNElJ87ziDj7zZoHIXCkF4jNBONVFqjAXeV4JcNNR+zJkF+f44HWfKLmK0UmGzTXSik3ghfVQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbnZqk3g8PKAv5RrOU+IFBI5DJXvOwbKX2nHwASu87/4JfaLW
	F3eqAsPqWDHPL8KpD0Ln0v0iirYjtUxmDpeFEMBM7DNBRH6Inkn2PcxYl3IyRqbebtEOs4HC0So
	tJoZrVQ==
X-Received: from pgr21.prod.google.com ([2002:a63:1155:0:b0:c79:81bb:79dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:486:b0:3aa:f9cb:d435
 with SMTP id adf61e73a8af0-3b3290e7749mr5752743637.11.1779491445825; Fri, 22
 May 2026 16:10:45 -0700 (PDT)
Date: Fri, 22 May 2026 16:10:45 -0700
In-Reply-To: <20260506015733.1671124-2-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-2-yosry@kernel.org>
Message-ID: <ahDidRRVYHD6x50P@google.com>
Subject: Re: [PATCH v6 01/16] KVM: nSVM: Stop leaking single-stepping on VMRUN
 into L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Yosry Ahmed wrote:
> According to the APM, TF on VMRUN causes a #DB after VMRUN completes on
> the _host_ side. However, KVM injects a #DB in L2 context instead (or
> exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
> kvm_skip_emulated_instruction().
> 
> Introduce __kvm_skip_emulated_instruction(), 

Eh, just make svm_skip_emulated_instruction() visible via svm.h and call that
directly.  No need to bring SVM's mess into common KVM.
