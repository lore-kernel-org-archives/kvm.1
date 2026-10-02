Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A14519B6
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979543; cv=none; b=hbX9Xc7lmNH2Um3JbQDdmurifcoQCANicGFisZrpqtBy++R+VJK8N7Y6ik1+ZqJBF0dAXeIQZBsOuJfi4bDo0V9OTKuJwtTm5hGBPVwtSOMy38LQxOQqRq1HlCZ2MVdBZQ+a1K/y8UO7RIc2l0PbpxQ0XAUIYUZTFKIzBcrCQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979543; c=relaxed/simple;
	bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDI6nfCGFjUG+8i72TIiP1EUeQjsD5N+IeAXLJvDZI8bOcC9CzYp71s6KZruxun4LG0AJ+U4IX1VAIvlYzWaW/wk5CXE2IryP2XcKGcB15oirWdkzTA3X04qsWMlgelXW2FuRO9zbkfZSIiQN+gR5LQ8auB4AotKuXJhVTIiuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMLZH8s+; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMLZH8s+"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso289844a91.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979542; x=1791584342; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
        b=SMLZH8s+LCQgFO7oNe4vcV8iJuWUxaQfX4dgY3ghhp+dTzLGGmVw5v/eeIs85vHGip
         Sa15lgiibSVx5HU/lqpieb+98WbsTIpWBlJC2PyKWxPuN9TJ3mqqdizSuARl1ZwY6Lo3
         AF0gZcVT9kkBPpvh7N3F7+YJrgrQMp6ClYQaQ6A6GBmTsNxUWD+vr8NpQR47XPLe7/gz
         P0CwwqXnBzgFni0Zc9dbZ0x4Jt/xviv4JkAe+s4smszurz4casTwUCHFziMd3dpsyFJU
         uV1gGOL+ob+D4KQXRhnJsyvxrkMbvX2qrFB2WLcjqNOiaw5i9daf6f8Sd9DZ552QG3ba
         sLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979542; x=1791584342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40qd9siKCBRYB3f3NGKHhJbH3BpIYlDe6X8yX7Hpuwo=;
        b=ylrW1EK+PgkTwPMeGlBieruVendCeaxbvKJIg9yocNoLuqdkooMYdm1ruq3zUdv1OL
         HHGdAp62jiJjK9Xjz+tnCqO8u466icfRX1Q0NV6FbpnhrMu5oVa+aIwmqN/XoYwZMxCu
         dO22Q2Tfr4VTNPR6s6Ch2q3GC5pFHsK+71Y7iZ+Ipid5ppElQ8augnPbO7hkPaHNhsYO
         6tDtvm62KmyIFQM+XC1VOnm5dyoGXKnhmbd8xdvYpCZYgQOCvRRiP0Z5ZnnJAzTTKe4O
         QjLsXf+Nvgt4X5EOrN3b+3FbE3vOzvDsFHEnfyhZGjTj5sHHj6z53G/k1eIho8H3kyu3
         ijkA==
X-Gm-Message-State: AFq9FYLhbjgD4NOl+jHcEWoVY5idIzzN+ZvgRXw+rTbd+ZENPnheCSck
	6QwVTNC1elkJCMtw+r7l/wZLiEelAbGsOzfJD/5EyBc7l7o42RKqAu/pbLYmvQ6MWpXPLGxxe8d
	Qi6l0FA==
X-Received: from pjtn8.prod.google.com ([2002:a17:90a:c688:b0:3a0:dee2:7813])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b48:b0:3a4:71b7:eb63
 with SMTP id 98e67ed59e1d1-3a6ceab25dbmr1825054a91.10.1790979541549; Fri, 02
 Oct 2026 15:19:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:19:00 -0700
In-Reply-To: <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAt1NhGFs5HNbvl@google.com>
Subject: Re: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
> limits that number to 4 when we know that we are running in constraint
> host environment. The number 4 is just a safe minimum when
> kvm_arch_vm_create_may_enomem() can be true.

Please actually explain *why* this is necessary, and where the magic '4' comes.
I assume there's some system-wide resource at play?
