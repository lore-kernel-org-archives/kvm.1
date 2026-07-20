Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAF39C657
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586468; cv=none; b=bCZCGTi8NP7RZWmH5oe7pI/RtyDJ6fEPgnGJKod1iNBx7HO8K6bMEHohSxoVEpXvVFiyzwDc+S8mUl+y2/yrWUXfiEUgIFReYn567lz0BTs6c0TJ/XXa20jOV8zNXbvlUv8KjtNfShhJLoSIZW+5JSHulZDbJuF/ze3xndQ7jHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586468; c=relaxed/simple;
	bh=+3zvmdX/AUa5Ass/AisUI0/xOQ7LXZ32buEYAGnRgUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iY1UZt8jXBYxKrJOcUsfUf84fwsYVWmv9sndJ/QyCI7Dhg4aPt+Hi+7Q4dhZ4yrDeIYgAy7ZRmB6i+2ocWVxCXVbYnuY0oQby5vxkf+G68tfz1paKQ7PYtQ92PVamxZ7Ot2Rby25WKbMAVlWU3KSUmjA+MDqu0SUsqMe96ZKC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HndPX2dK; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HndPX2dK"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so199920995ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784586467; x=1785191267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=civ8YVfloZNtfpGATb0SeVYinnAw4hyl4f6AMPkBa2I=;
        b=HndPX2dKfmMDzGGxJqtGN1+J4BvIywXSNNFOOfo5Y7vX9+4bgrZ85zdN7gdYbDj9uy
         fTcaJixesqGnhBSIfFg4TyMQg0XmlTIPQZMVRrUKKwega8UJ84T9LgCraDkURRd8+mBz
         2g3zhKcP3RpGttykDHGOZ3ZQDqpp2HQ+BV4rXXaCY7IpZdbr62qTNhIZsyGCfSidtig9
         DvhogN/5CbGLT/4ThMgL/may+6/nW9HJXAZj8oPnZTCT8BxxUBIx+TjcSMwE3BbTHlHm
         NFolAzZfxaeR4Vh5DoxPMeAE2H5JRJsqgtoFn8/ROJ7FRVrnylb5tcJH6m1mMOPPbS1N
         JhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586467; x=1785191267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=civ8YVfloZNtfpGATb0SeVYinnAw4hyl4f6AMPkBa2I=;
        b=M0OKDa2/ZY8nMrEcsOdlD0wyLWuNU1HSqKlaeqnE3g4v6nTkUauzdw5potEyJXQrQK
         XVu7Ofl2LxgFzLWr9kZLQVGSmCJ++1DohF1q/jJXTBrvOwDKKfgqGLUdYxAF3Kwg1/Y1
         WbV5llWIxLGoy8v8st4FUFrUSiex8UW9fuSsBEXBT1q1WXVJkvZWgTiFMQ5xkxcAf3Im
         7CnHg3NcG8I+rf9byOsnoZ2JbDdgsS+C7pyFYwu7lIutihJIPm9OYlEmglF5hdhSlvlX
         XCoinU8fha0Xxf85W1vCgAcLUdWLq7/KbY7OlBy4dXZWsfK5MJyLc0NNAQYBVsEi+tYf
         Amqg==
X-Forwarded-Encrypted: i=1; AHgh+Rqnsb3TMz4pwrPb+kjv5NQ/qs+mVRRXjrLYeAe9wNDOVT4DGpAFHXWaugoDWzoc7Deqcd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLJXlyVZEhRDx2cD+v3/v/sNPGP/LGljj8Kevda1+BJ3Zm6QY
	lW8m8AlUywy78HTsNd4FMGsvlqPWunTjUuv/6cH2YdpwmiGWQcoPS1jQhgGjSQX3g4sbhXiN0Jl
	okF1bZg==
X-Received: from plcz4.prod.google.com ([2002:a17:903:4084:b0:2c0:a677:42a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:2c8:1c05:16bb
 with SMTP id d9443c01a7336-2cf3494f91fmr169924915ad.24.1784586466619; Mon, 20
 Jul 2026 15:27:46 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:27:45 -0700
In-Reply-To: <20260720192221.72912-2-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720192221.72912-1-absandze@amazon.de> <20260720192221.72912-2-absandze@amazon.de>
Message-ID: <al6g4VA4l-ZIAr9Q@google.com>
Subject: Re: [RFC PATCH 1/2] KVM: x86/pmu: Add CAP to disable SW accounting of
 emulated instructions
From: Sean Christopherson <seanjc@google.com>
To: Luka Absandze <absandze@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Luka Absandze wrote:
> The only functional change for an opted-in VM is reduced accuracy: a
> guest counting instructions-retired or branches-retired undercounts by
> the instructions KVM emulates in host context, i.e. the behavior that
> predates the accounting cited above. Hardware-executed guest
> instructions continue to be counted by the backing perf_event, and its
> overflow/PMI path is unchanged.

Do you *need* per-VM control, or would a module param (or a magic value for
enable_pmu) suffice?  While I mostly buy the "it used to work this way" argument
(just "mostly", because that commit landed 4.5 years ago), I'm not exactly keen
on adding uAPI that is effectively "re-introduce a bug to workaround fundamental
design issues in KVM's emulated PMU implementation".

If we do add proper uAPI, we should extend KVM_CAP_PMU_CAPABILITY, not add a new
CAP entirely.
