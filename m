Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1629B799
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229303; cv=none; b=HQdMJWywzEEDJFLm7VY4VOtb0woO7BK7IQ2XmW/IGzJy4zLXKbz8QKwrQxjjCjA6fh3G6aqVx3zUxYonM5r4NPTh3ClcltZKhWQip68wdZ9Q56WUACRMuX54X60X8JbPIOo9vzndqSINZI0tmntvDZAT4XuEXF57aTjnvvmDlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229303; c=relaxed/simple;
	bh=g+3d55fMPKViU6ChE7NTvXFutKsWjbM371a/Tuod32Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvObX/emqnR4ZNb4Ct0k1nuVDWxM2pp1fr4dIa1sregLI6I4xScvWftwbi6CLol0c1kuLgaggrCuK8Z+0+wERDiocd443f/acJaYZrK/uEZ+sOwMHOr8wU55cxMqV6UjOlf4NErf1yHmIIB91QoBYmIwaG8z5jl92DTZn31hDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDGq+kOd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDGq+kOd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b06f37a7so803777a12.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229300; x=1775834100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ptwfU+j19Wd0dPmULTZjnTSFZRUyk6iv3v3ykVVGD8=;
        b=rDGq+kOdAyHm8VLc5yYkDIXnOGZ/dsOZgMQtsJeWwPsXoVuuQIA4OwSWw/72+bVBTg
         rWUR5DKbX+x832NfQHcj2aMNIex1vQ7h/FRDwoZFi9vvM3ajFt1OclgJZm+64CltR2zI
         p8uoY8Co9s/RHTBYwURpkSg4jso5RT7O2PaqmkQlP+pVXhN6NXgDCp1X6iM8SVAQijQm
         crXXn9XrKS2mN3TAJOcOxx4PidX42tOhiPzJr/qEllxefU+lw2aRJVxb57z2jGmBrfam
         FyJlY3G5zxAaly3btYWNBkmpRUEvXB1tz/BxG/MVKj91axOZ8QMeh+nYble0kgdAkHQr
         7lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229300; x=1775834100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ptwfU+j19Wd0dPmULTZjnTSFZRUyk6iv3v3ykVVGD8=;
        b=m8Tsc0ciUmFuOStygK/h0GQZPIhFPWZYvrRVYSbTyLrhBF9hLCazCjwGPmv7ONylFb
         41eDEN0ENOMCvhdYQTQWoqOoqNXr/JVD58MuK1kChx2gNw4/bKht1qgtuPxjyK0HGTcp
         V9RMmiSfZbBNzbGWPQZnc2y9OD+MdCOluXWhJXw0KUaU+ilwhgQl9jy/xGQGIvl634ER
         OpAYunIljDhqy7/uwWJJErdL25DRz3Io8PTPGSC67UdCnGLJZVN9dTE5IO/4Ovv3TmnU
         jbEG1E/15PClsna8tvMcMoQsXU3G27wUgH7my0fXokfTZjl6yxg0uMitH6/y3nBVANJC
         TD7w==
X-Forwarded-Encrypted: i=1; AJvYcCUNKXeb2YD1bER/5UdZcZOk7fDUPvgtr7x7WeYgAIkn/A0uwBGnaysf3GUXl4flvD9vUjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluqAr4CFUztZn29Si+4DAcSpqC/503eD6hK+TPq/Etbfk4S88
	dCteAeDlveOTwO8hpvwDJquajOITq6hDEJZe+GJPDx1gTIYWltFiS9V44aa7ZZqRb1W8Uj0TE1k
	SenW0TQ==
X-Received: from pfbdn8.prod.google.com ([2002:a05:6a00:4988:b0:824:ad09:9202])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da1:b0:82c:db43:969b
 with SMTP id d2e1a72fcca58-82d0da8c12bmr3096470b3a.22.1775229300186; Fri, 03
 Apr 2026 08:15:00 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:58 -0700
In-Reply-To: <20260306210900.1933788-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522865445.292320.10294806708944708275.b4-ty@google.com>
Subject: Re: [PATCH v2 0/6] KVM: nSVM: Fix vmcb12 mapping failure handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Mar 2026 21:08:54 +0000, Yosry Ahmed wrote:
> Jim pointed out that VMRUN/VMLOAD/VMSAVE injecting a #GP when the vmcb12
> GPA is valid but not mappable is not architectural [1]. The series
> handles them as emulation failures and (mostly) exits to userspace
> instead.
> 
> With vls=1, a VMSAVE/VMLOAD with an unmappable GPA will cause a #NPF and
> be emulated. The emulator currently hardcodes the GPA check to 48 valid
> bits and injects a #GP otherwise. Fix this to only inject a #GP if the
> GPA actually exceeds maxphyaddr, and otherwise fail the emulation as
> well.
> 
> [...]

As promised, applied a tweaked version of patch 2 to kvm-x86 nested, many weeks
ago.

[2/6] KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
      https://github.com/kvm-x86/linux/commit/520a1347faf4

--
https://github.com/kvm-x86/linux/tree/next
