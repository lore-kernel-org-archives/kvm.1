Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AA1F16B
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173346; cv=none; b=E5cxAE9TffUp/4OSdFoqQZ7yW64AbuctBR94+NCwW60YbUttL7OR4G5p7ndA1wjuFVjQPmrNkhhRorFC5PzGkQV1cho+xiVYGY4wvYW8VxFe5xEptMb/FszHJG+AMqZHwRtV4yw8CyL9ZXPsuBF1JiDkPUhgA6xibrtgM7MjBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173346; c=relaxed/simple;
	bh=yd2+TEOv7FExuypFSi9d8xWFqZaT8pV4kh4tpwR5c98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jh+8XKc82erXa2tRaphSDIFAn6wr2KRDEhq7YknOAYsft5JZzsVWYeCf8cpFyVlD6RGpk9NOB2r/fvgXi8YSEotl8JCPqwSuPAx5YtnmikcLhRLx4kt7w5+Ozv+Vv1x7uIrhuMDLhgsM4MAPGcketOxLlgbnQi+EPj5VNLety58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gO8kormo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO8kormo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c725d3e886so64369425ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782173344; x=1782778144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDYTMQB3fQDmgyevIQsrlSuuHRIIVN5YGJEE9Jzg0yM=;
        b=gO8kormoM1600hw6wApml3oRPggplSFcmTscSLVOKhtgOtU1bgaWFM2T4pBfh1m9NA
         jWQNdAEMcN/jF2W3qHdFh/qt3grUJ6WrSTkHzQmROQnGIcjVROqiJKidx5VRJMwyb5ra
         MUBhSY1SPGr9Oa4bxjBNORKgoXd0cMOXu1vFhpvfI09tLu+uzFwwKgYnNHapEyHT7BOr
         R48vAPNLqr0N0P2ec1g0Tic/RLbeg2wcYoovx6MGpHMC4vuKLVG9FLGDH+RPDJp3TjrO
         tcXacYbqn/CwnRsyqnTQ8X2G4wSu9iA1N/gd6dhKD+0McZHMfopffIbCSCGXviA0DbjT
         lU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173344; x=1782778144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDYTMQB3fQDmgyevIQsrlSuuHRIIVN5YGJEE9Jzg0yM=;
        b=QlOuSMTJTWKz+hosKxaHrmpwnXQwuzDmhLvi84vRKvnT2HENhjiBJNiaKTNQjhoSFH
         bIzXd9yQFsegFmrE1BgXMV40y6bwA6DZM0yPbwoOD4S+u/WBuUdymENw8ulPHiDY8CYz
         tfk4IYbjCnAUjgjz0kdRTHXV4oywl9UlNaLrCpDl0EqXXLGkTueXs+s0HYFr4SO566bf
         3ZLVPItNTRUY6U/OtmrjQxsb3ehLJ9CLvbc6sFzvJf+XmZmMh1xZKnTGg6/bkgS8RHLp
         pHtjI15OUhYzkkm3guy7bM2guzY0/mxDFvARiFv/LNtB/Z1AtQeQjBHTHhbUsa6wA9N5
         lnDg==
X-Forwarded-Encrypted: i=1; AHgh+Rrzvo42Rzu0rkn+sdzCJUMa87E6K+FFUGLEuA2d8uyHJ/YFvWw3D5TeVoEpHRVN1cr3EJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcvM91h5BmPUEb4V0XQTQpsMDKSyIhk7EnjMjrJ7P6N1Zz6jj
	H4vI2pWkOyqpZqECSXGmU0ySYqQvIK3AWbEq7qWZmSVaGfp4P4/y5/NGxp8SGhDGJYSjz3k9UgO
	dYnvZgw==
X-Received: from plae21.prod.google.com ([2002:a17:902:e0d5:b0:2bc:bb08:92dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e881:b0:2c6:cd96:6a8
 with SMTP id d9443c01a7336-2c718f3fa54mr191868605ad.30.1782173343880; Mon, 22
 Jun 2026 17:09:03 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:09:03 -0700
In-Reply-To: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Message-ID: <ajnOnzdknfwbuJ9g@google.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	axelrasmussen@google.com, linux-kselftest@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, Ackerley Tng wrote:
> Tarun Sahu <tarunsahu@google.com> writes:
> 
> > This patch introduces the freeze on gmem_inode which prevents
> 
> Can't find the reference now, but commit messages should take the
> imperative mood and avoid "this patch" [*]

From Documentation/process/submitting-patches.rst:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.

Documentation/process/maintainer-tip.rst and Documentation/process/maintainer-kvm-x86.rst
elaborate more on the preferred style (I do most of the guest_memfd maintenance,
and so for all intents and purpose it's bound by KVM x86 "rules").
