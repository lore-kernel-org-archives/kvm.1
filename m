Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433841D4FE
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975428; cv=none; b=Hu1XnjsjDtDYXAocicIDo0RaynuN28McoSKXUDTydmAQmUV5mIhac3suDKt/IW0eDiqb2GfS7yb49ZlIrXDQ5kcUzDXXxCLmXLpiYIrDkA1/zjU5JeQByQBVGl1Sp/S0woAn8OWxjHGxZ5JKLd9SiiDrZh05HsrOTeGV3T7CjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975428; c=relaxed/simple;
	bh=y8fYDrUE0WXcYQqA08a6svA6NhNoU29Sy+B69Y//S9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAjjHrdN/3JYIIhGdlzDkSwcAOdy1WZ807dffV+0iSvsn63RxKTilcNnbHLANqrAoB85Ph1B2mWpABJ22XQUGy9z9XiKzVSI5cQEm/ibTNInRKynZIeKFVXOSP7WjN5hYDJm/uclWBh8RDRcXLryIl7OBNYGNTpFN252rD+ubzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+Rlx2T9; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+Rlx2T9"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so19666a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975427; x=1791580227; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63q70fN9I/+r+J+jEEjQOxrn4KtkDTlOQRtquUPHzOs=;
        b=m+Rlx2T9eOwo5EhlVO5dzuQn6906tTK2a3a2Jle9ppi75mmllYrwLvM0Ko02eIqB+u
         1JDMDRWXBXnItanG5weeHKAGCEF33Ac/k56wzikLMOmSFmM5CBd55JqFc2OTveifp9XV
         K4yW7sLgZKN0TfxtBGdSAdZ7gUdNfylzd9GzrEZLt03pQmt8U1Z0uebnpRAHeKyX7szP
         LBs1CeMQB7uW7biQpy6wNC9nTuAWhOhH5O9tjV3CZ1HqNL3m8eFkkrrQ/sidU8Tq4qGv
         NrzVb3DTvYLfFU1Xy4Tj+iDYXwGGKBbp/wKseWRDGkL2PYUQgnrmFxZ5/xkE4jAKlA7Z
         GFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975427; x=1791580227;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63q70fN9I/+r+J+jEEjQOxrn4KtkDTlOQRtquUPHzOs=;
        b=dsA9l1g9QIciGEAWQXdODF+I9cqSdh+Z75hLP4UlrwqL7UVIMbVLbNZWDbgVCfloqJ
         9I8OqkIQ6wS/1eWSo3KvekmNmz3I5JmLcr76W/jG/u8VE1jvDiRfV/V1k5PkYA56Ltxx
         8Lsd81MAfupLyMXBoJv8IS2wuRZTuOOWGXSXDBAnMUYdICLrU/+T8dIbNFynxIE7CmFI
         5xXcu9vlliE+nnLJZp9CRbzQlDmRnjZBH2kROWB9bYhF5y8iLDJz4kucrsr1F4p9jdwS
         KZ9NkWJN76q5wkc+IMlHbO2EiqNGvGcPqIaUhkYc/FcGNS+9Q7US7BZzp084GmXN4D3Q
         q5Rg==
X-Gm-Message-State: AFuF++kqw4kCX6WSpnBFC2zVTjWCe5iOmcvxDCcnVkZqr+gH99G9yVPa
	pqhoNnI0sKH5Rc+n2jhrdKeOmr8eC9ev6w8dGJdwngfKVJIK8/LUU4D+M8/bVX/wPj2NZI2ksg7
	TQv8L+g==
X-Received: from pgbj2-n1.prod.google.com ([2002:a05:6a02:61c2:10b0:cc7:f591:cab0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4514:b0:3dd:a195:dd66
 with SMTP id adf61e73a8af0-3e0bd150711mr3761620637.72.1790975426717; Fri, 02
 Oct 2026 14:10:26 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:18 -0700
In-Reply-To: <20261002162119.3957230-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002162119.3957230-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179095814148.3960305.13892443963858808213.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Relax overcounting checks to
 allow for 1 VM-Exit per 5000 nops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Oct 2026 09:21:19 -0700, Sean Christopherson wrote:
> Relax the check on the allowed instruction count range in the PMC overflow
> testcase for AMD CPUs (all of which overcount instructions retired due to
> treating VMRUN as retiring in guest context).  Empirically, modern CPUs can
> overcount by ~150 instructions, which seems high, but is reasonable when
> considering the main loop executes one million nops.  Arbitrarily allow for
> an "extra" 199 VM-Exits in the loop, expressed as a function of the number
> of nops in the loop (the "per 5000" math was derived from wanting to allow
> for ~200 VM-Exits).
> 
> [...]

Applied to kvm-x86 next.  Sorry for rushing this in, I want to get a pull
request sent to Paolo before LPC (getting the fixes into the main repo isn't
urgent, I just don't want to forget about this stuff for many more weeks).

[1/1] x86/pmu: Relax overcounting checks to allow for 1 VM-Exit per 5000 nops
      https://github.com/kvm-x86/kvm-unit-tests/commit/1aaec1f90618

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
