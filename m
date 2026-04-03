Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00C292B44
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229270; cv=none; b=YBhrH4zucNFQrcPawZu14GrnhUGpJqTWmpqI9f33+jCcFy5rVudhajxCM8ZeZoixg0A1cuEstaVxpB09ZvAT7Z4b2GzSOsucy4CfCcq0qYU1fFdf+rBd1eCOahWjpE/atahOm+5yLryAGFOeBI3KmVrTszyWeAyPhm1mgTq8J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229270; c=relaxed/simple;
	bh=O+0S7eEWYfs5uOlDgo2+EzsasMhaAFaz5rc3D9MQsy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qKVBgzPy3owjQr8AFF6CV2BN/9p/0QiuZtVz6FEvSh2Jd/F3BuBJFMt/0AV09cRxxFxK2BlmzK12osUxnCdSOF7LZXELWjqISC0AOay4AAE1z3ugttOZW9cyj8L1vpxXr+2JOfeZ2HwDUKDX/BRVwp5a1BRjxFFOMHyOf4XK1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTcVnFFh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTcVnFFh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76acbe2829so3013804a12.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229269; x=1775834069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ielt6KrhYC6C4d0jXLSEQKkK7y21oxcsahFNOtjDcoM=;
        b=tTcVnFFhrzd87GJwrbypVPicL9p1deRFGLhwhO9K5/jFm7sfODnLbHnQGaOimMLXNw
         T+m+9/qI4bw68wSawatqfeB4E40EDqsGc7zxlFQvFWKQ987aZ3wB92/zmRwI72UtaBbI
         t+9gZGxlPiExfi+t3t0p4bQ9/Cl039IoEoogESrhfph5dvYGQZnQzOTR6CXT5rYq9/6L
         pBNU8MvxGuWNRk3ikck5IKf0pivF7oKgDK5wxIsYm6pDpGI2csjfijCkFkaPkOgfQCkm
         gSEe5FOdtpLT/h2ieH5Z5xnCV3fpLw0IxbuELewPB37EJwo8plopxrYO8htAiMDncpmX
         4I2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229269; x=1775834069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ielt6KrhYC6C4d0jXLSEQKkK7y21oxcsahFNOtjDcoM=;
        b=lb8XcRaLeMfHDCG8xyq+UZ9tK/w+3mZ1PRh9hVkvPDM7vo61+IlFzBOAuye6cTCT0X
         uBtBbPK31Q+PV1Mxg4OpBmT2fqYJ09efARjHnmdpp98GQyyVr7GQhXZNo2XeVIECbCS6
         QE45IRZX/ILJX5SFUJ02HaUBgwfjEl8v/3GSPpp5Vr74hCoambeAuWwpZzSpEhEbCS4d
         79pgkheZ6JGcvj6vxO9mD84RBELaNibe9tEPH9iHI+8hmWiREhTS/r+jsLdQ/+o9w5VH
         iH4KX0uVn7IugY6fhP6jEIbQ9unMl99mY45Dv5UnXfWPPG6AJImpXFZ0qo0C1y5nE2ab
         kBLA==
X-Gm-Message-State: AOJu0YzWyYK6BkgUO7Lp4R9DHanI6m3hHXXT9JaRBV/wH9oc/ad9e385
	2IE2Mmb8fl5YV3QW5Us3anS1egNxzdOi4brJfm8WUZTMVQlF9zJSywHLqsYv4YGzhNPdeK7kUFG
	c4F9jGg==
X-Received: from pfnv17.prod.google.com ([2002:aa7:8511:0:b0:829:8405:f4a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca8:b0:82a:786f:e39c
 with SMTP id d2e1a72fcca58-82d0dbca63amr3278436b3a.47.1775229268778; Fri, 03
 Apr 2026 08:14:28 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:50 -0700
In-Reply-To: <20260302212619.710873-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302212619.710873-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522902081.296138.1256520235945773865.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Immediately fail the build when possible if
 required #define is missing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Mar 2026 13:26:19 -0800, Sean Christopherson wrote:
> Guard usage of the must-be-defined macros in KVM's multi-include headers
> with the existing #ifdefs that attempt to alert the developer to a missing
> macro, and spit out an explicit #error message if a macro is missing, as
> referencing the missing macro completely defeats the purpose of the #ifdef
> (the compiler spews a ton of error messages and buries the targeted error
> message).
> 
> [...]

Applied to kvm-x86 misc, many weeks ago.

[1/1] KVM: x86: Immediately fail the build when possible if required #define is missing
      https://github.com/kvm-x86/linux/commit/55be358e17af

--
https://github.com/kvm-x86/linux/tree/next
