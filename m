Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034332D2488
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905431; cv=none; b=Pyf2W5nk7Iio2Y8ZNaFbKEgzySOgwaXhwuQssx32ibEyBre+VQSGylVgbw2LJ1Y4KOsXR+p1OrQBvjZbsc4RveK7y/h0GmizbGReaVF9FnApxbbhyT3dtHMZGgE1+M7PbP92z8KcKPHR7wGuNKiuCIqlqFqo+Pj+n4FNHwFAs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905431; c=relaxed/simple;
	bh=KsitsgupVmJ/JgX1sAvjL8NpETNPbirdrIFBG75Pwug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTnvvZjKyhoA7gVBFWb3fpUVkMhqqKPQsAR/OV5UtYuXDrX8Qu54q93sT6LEwIox1bYm/jmuoo3V8kEJd+QjKSiR2uW+i/BlwFbvU8biqBiGKnLo9ta80aPztjjN8TxxUMTammqZw7sKG6p1fNnhVi7GHvn1IbxROV9UiuDZta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXuHrs9L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXuHrs9L"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba6fe41283so128667245ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905429; x=1780510229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEEE1YoGH0jFeVCJaKIXnPR39dWTuvsItNcK0xbSu58=;
        b=QXuHrs9LsFd2uizvNTmRRhFNSGbUMlaK0Gm0gw2/hdTXri0+y/7DMZ7aIC0b4gTMje
         tgXMJuj8gVguMzQuu+ArYJaw6X9w8zm/lhitaAqej6h5e4Oo6LsjknaA3YrwjgPqp7Vt
         yn5A4+fjarhQL66Wwcnu2sH1Rolqo1tTgy8c0zinNXtPbDlcjU7MldKiXq7J1PmsNaVi
         KTHOHOwTCkE7nCBAVsyvHiNa6Gz4m/n/gbpdTkp62vsigW5Gy6WTYwbgvh9icmhr/MKT
         XmfhWorh1n/Y93EDUAIzDVtzAO+Xlcxfw/8TdzQ2eJ0vZjY7R5y91u4Xx5l9dVBhS3d0
         A/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905429; x=1780510229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEEE1YoGH0jFeVCJaKIXnPR39dWTuvsItNcK0xbSu58=;
        b=SUFBgBoPPmAkW74UiAnm80yAR6SJMhNopSx5zZMDd5GK/eq7LS1I6qW556g08NeVVg
         1Fj67G9f8/CiISHi4FVD6SfGEoT48D8pr2pEwN38o0RpcF5quuE/uUhuedIDU3yr18Bs
         6d33Iq2MU/DhA6b+/AcFCS0aie6LXzTTKYulIoygm6pNTrFMVnydnO5QGlalnyGcKb5m
         nWdQ9kgcSW3KhnJN2pi74qeUc09RDt+uckAry/IsUFmJaiQKt7kK6qEHPoAzXpLOKPEe
         0X5JXIe65jF/VO8CC+VzAhb+c/YKJSItMiytxJLHSsfidYqAiLw6kv8wdIXJyZSfPyyp
         EH0g==
X-Gm-Message-State: AOJu0YyWUm8kolWLfCFBpcfMjJrY4gimgPHCB1KTYluvJrRo9KU2dLkK
	smHohMGYrZmz6PLQYrOWsvS1Z7MZpSlqusbZK/5LMOxeCUT96WRG45iusY75vREAzEW7nSLElNb
	YeRcHdg==
X-Received: from ploe14.prod.google.com ([2002:a17:903:240e:b0:2bc:a589:91c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54b:b0:2b0:6e6a:8504
 with SMTP id d9443c01a7336-2beb061327amr264594395ad.27.1779905429166; Wed, 27
 May 2026 11:10:29 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:00 -0700
In-Reply-To: <20260522172151.3530267-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522172151.3530267-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990525893.4121416.4733019500372362112.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix guest_memfd binding overlap errno and selftest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 10:21:48 -0700, Sean Christopherson wrote:
> Fix a goof where KVM rejects guest_memfd bindings that overlap an existing
> binding with EINVAL instead of the intended EEXIST, and then add that specific
> scenario to testcase that's supposed to verify overlap checks.
> 
> v2:
>  - Collect Ackerley's reviews.
>  - Keep the GPA overlap testcases (because why not). [Sean]
>  - Add a patch to remove superfluous %s formatting. [Ackerley]
> 
> [...]

Applied to kvm-x86 gmem, thanks!

[1/3] KVM: guest_memfd: Return -EEXIST for overlapping bindings
      https://github.com/kvm-x86/linux/commit/7ea987a90585
[2/3] KVM: selftests: Test guest_memfd binding overlap without GPA overlap
      https://github.com/kvm-x86/linux/commit/772989854acd
[3/3] KVM: selftests: Remove unnecessary "%s" formatting of a constant string
      https://github.com/kvm-x86/linux/commit/b0e476eb755e

--
https://github.com/kvm-x86/linux/tree/next
