Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979E39A815
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615964; cv=none; b=XdOiLuxNTZ2nk86PV5zeD3d9FjHj/sYPZWtZxL1WIfj36AkG70FxPQ1NHIc/pC0x8Ctb+mZBK4CqgJssjVAxpTuiZbXUb9KnLHph7t46VOYyFxXgX4Y8y6mwGTK8/kVVFw5qDrs8xjUqwmzvtXcwtWLh0p8etFgX5ETVbwcPwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615964; c=relaxed/simple;
	bh=9yWW1rfG08mjiXMbiWWD8T4F5l3PF0vkB9a41Sif8zU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CemHxJr/6BnDViaI8oJkiUZCITGWV8aD+6NH4L9ekydT6KeqlBNw/3NZqXDdKs98HE31EaJ+1r7l9l0KRRgSsNnOaclXjmVJXIcwck04+/2xiakHh2gZr/WNpkcSjFINBtIIL3Ll0uVw/hyPC0ACa2JYqbrWMbmMOvwWpniycKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lM9eAaPS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lM9eAaPS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8479cc04d8fso3809984b3a.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783615963; x=1784220763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yWW1rfG08mjiXMbiWWD8T4F5l3PF0vkB9a41Sif8zU=;
        b=lM9eAaPSAUO8NOnP/ETwgdNPptS04u/KjkY5uVRaYiN6uwG/MDPodKzStiZofuY0v2
         coJ7yl/39Mm+FKHrGM9kB/h4buHweXpn3Ut4TwQJBwmZES0evVm1/RbYtTtNABfeHWvN
         IykzNgjjVbOZihZ6Pm6zo/H2wCXmEwwd+fOx+mwkKSkcPijaifqVZLfHdrxVWTrk8k6K
         PrUUpgl2fYnMI7lDimGD5N2pSYHgB4/xWNFvyItP/K3OZS6YALmpKj/MZpcbSHJDBpEM
         k7Vp37F3jl7mevBK3qsoh5mX5i9TQk5Bsf0eeWlnPlBjUbCOTt37PnjblvoJmm75BmX3
         WEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615963; x=1784220763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yWW1rfG08mjiXMbiWWD8T4F5l3PF0vkB9a41Sif8zU=;
        b=UPQis52NuyOyvhS5z1Gj/Fof2VwWQU8XVsDw8AgOgB1vhuJjq+facibCMDuGo/mZ9t
         7UbpbbTZyMy/r931ue6f4G/Bu4SB/KaOF8bpz2SfipBif0tFRTmMblTH5u91lDygdc+f
         GyZOE0ScnoEDYZG+DN737katBEng6G/Xuc/AjSIzLyPE/0PN1o8rsS/zFNvDV9srzDn7
         PKugkq279Pf4jitO7CjQQm71tp4pbNB9uXFLQ6i2zuTyeQjTDV4TNZAf15pU1pw3+AUz
         tHoGAIDrOERy7PuHLfuW8gHpqesUiLS8DbaSOA2YhJtCLi4HNrOCcyEafHZqyIXAKq5I
         proQ==
X-Gm-Message-State: AOJu0YyRn/XaBgCmS1FAFE5awZMX1vB1U+9mBxf9Xx1aDzxI47RDX8Jz
	Gt1NVX8dkQjht35gX7hQ8Fkvg39sPx366aC6j2URt2rs6RZL1XxHyakscFm8MGJFpUYybTeUpaW
	2bxxamQ==
X-Received: from pfbjo13.prod.google.com ([2002:a05:6a00:908d:b0:845:e4c9:a310])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d06:b0:845:36a0:9eb2
 with SMTP id d2e1a72fcca58-84842f5bd85mr7668383b3a.34.1783615962518; Thu, 09
 Jul 2026 09:52:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:52:41 -0700
In-Reply-To: <20260709152154.235233-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709152154.235233-1-seiden@linux.ibm.com>
Message-ID: <ak_R2YrPFRVVmX4P@google.com>
Subject: Re: [PATCH] KVM: Add missing debugfs cleanup in kvm_init error path
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Steffen Eiden wrote:
> If any initialization after kvm_init_debug() fails the cleanup code did
> not remove the debugfs entries. Therefore, the corresponding debugfs
> entries where still alive but the backing fops are already freed,
> creating a use-after-free scenario. Fix this by removing the debugfs
> entries if vfio init fails.

Already posted, and applied locally on my end.

https://lore.kernel.org/all/20260706095910.39798-1-leixiang%40kylinos.cn
