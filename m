Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1F40DFD1
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607285; cv=none; b=C0dj2V0m/kYqwer870FSLIL0gGvM1mowBpY9lcpaejpNyqPMCPTdc3P7jRu4SCVIXquuPvOcWoSs7CQKz63Q9G1TlCSU5+fHvLvvNMutvHPasnr1GDmbM24UeB12J5kR/PVDRUZugXFgz2yPM7w6Vo7nmp/P25h1MCRsN9O+Rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607285; c=relaxed/simple;
	bh=myshdu0wUsQa43X+Mru0as+d76NbzjD6qLvfjjN9vz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rxH8HaX0if8NTRA7MswdzIpo9KsgwREoxbX2vAm0Q/MOgQmpI5i8IXNrd2SUWEJKaSG8FJWMphfyc0AqxuyWdXYLksUFG804uBk6NOv+ZXSnR07DLivh3yVMN/P+eAcU6O3X4nxQEHEd4AGCdrZQme3AzMZbt7rWdbZihCVIRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9C73GAa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9C73GAa"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6d4337bso2956853a12.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607283; x=1776212083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgTCX/ofbDOTHq/UdV0rpq2HLJ8Mx4LSdkKD0Ovj9BY=;
        b=K9C73GAaqJIbqJg+FgDyESOby6IA0WzKVZg9UruFfcjdTgteVCJY8Il2gJFbLKz0S2
         Gm5EOmh/bewVpsqVSAW88gFO6VgRkwgv1t2fZgqpEDh+8VCyguNQuPV9961DkYWZtpsm
         JyMC7ouH9+gKM4Mhto2s/q9q6PcKe5d2xjMTbYT22SJGQTf26nGG4VtXDOFvlNo6AD9C
         ooSSTPzVwNDFDosox6dEQdCoZTS50lcZiRiWtll9+li260sV2UFUGfA9SLOwWCOXFm6s
         KnwcrlF8pqshebYRc1jIulg3ErX4lRPZdQb8+7BSQS2XslWNeSwxGgc4sqayBI1lUBBv
         qqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607283; x=1776212083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgTCX/ofbDOTHq/UdV0rpq2HLJ8Mx4LSdkKD0Ovj9BY=;
        b=k9NRLxWa37FbyfAAe3tHyz3hctYYL21SERWMjwJT5LTxK5H3V7bhu/4kBmy3usY93/
         UCEkNlkloWe5dT7Xyd8iLVN++FydobCoA7EYdjjJzgYa9y6oyWp9YCQWHpUNCutiO8op
         uYp/a88lou/DQrvYidgfobaNuNfSvIcBwVvKOuFt5ykgQq0I5DRnhwhP2rDXMt/IBZz0
         +7nmL/Q7m0drIqtDrAOOjvxZdTqRZ9mwGDU3qVfJ1zZaBGtaebA3wT6230P2MoGFSUpC
         9hhbqwMjT6G3YtCluu1vP+WgxjoDtHBRzFt6uckTLcU8PlKssdj5RpDRs05rjwsgdfCY
         BEWw==
X-Gm-Message-State: AOJu0YyqDY01mNRfBzsofj5+ebD+n+ok03tJV+3FHJLiu89tBOk0Uaox
	BTntEWwTOijBAXprGCkQEv/ldsmRV//f3/JIM2FnZY94w6lxNvFnP7e3aQBsw0ZVNMjDSpaqnxF
	YDvv0RA==
X-Received: from pfbic2.prod.google.com ([2002:a05:6a00:8a02:b0:82c:efb6:4087])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2393:b0:82c:dd31:b83d
 with SMTP id d2e1a72fcca58-82d0dba0775mr18933513b3a.38.1775607283332; Tue, 07
 Apr 2026 17:14:43 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:14:36 -0700
In-Reply-To: <20260312234823.3120658-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312234823.3120658-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177560706203.1572452.5325835766446538096.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: x86: Syzkaller nested_run_pending defense
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 12 Mar 2026 16:48:21 -0700, Sean Christopherson wrote:
> Stop playing a losing game of whack-a-mole with syzkaller over
> nested_run_pending, and simply treat the flag as "untrusted" if userspace gains
> control of the vCPU.  I.e. don't WARN if userspace _may_ have stuffed vCPU
> state to force an impossible VM-Exit.
> 
> The signal:noise ratio for nested_run_pending WARNs when syzkaller is fuzzing
> nVMX/nSVM is awful, and playing whack-a-mole with syzkaller is doing more harm
> that good at this point.  While it's possible syzkaller could find an actual
> KVM bug by stuffing vCPU state, if the _only_ symptom is the nested_run_pending
> WARN, then in theory the bug should also be hittable by stuffing L2 state prior
> to nested VM-Enter.
> 
> [...]

Applied to kvm-x86 nested.

[1/2] KVM: x86: Move nested_run_pending to kvm_vcpu_arch
      https://github.com/kvm-x86/linux/commit/3d4470d71fbf
[2/2] KVM: x86: Suppress WARNs on nested_run_pending after userspace exit
      https://github.com/kvm-x86/linux/commit/7212094baef5

--
https://github.com/kvm-x86/linux/tree/next
