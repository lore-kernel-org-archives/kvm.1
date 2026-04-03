Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D203BD64F
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229250; cv=none; b=O1fsP6WfMHf0wyIgxKbRUaTScv2l084zWcZLIuydzb69PFwpvDU+Jy7emXpLlTdyG4jjruRQIAEcAytZtEr98CpIVPMebajq5HIkq3unKsgKe91ZGplLjx0mGjSFltBCD627n/qoi3AEFuRqgvhh+QlBmKr0rCmoPJcwsjyvrPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229250; c=relaxed/simple;
	bh=pimQSmZxVPaRKhg4+NROSz8fmGTTL70/pz9J7w9m5JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxNA0UsdkW5ZB51wxq9EB4K3zJtYcRNZCmw8MikaPmNHRYdmuk1OaA1Kbz0U7DMUF7+GkBPgr7sJ19CehSmx9jrx7Ib5sB4qfDT5jx4xkpz0G3EV64xXzV/Mj/mVUobFbwK/zGhChWp4Wy8R8/qwzQt1sh91mS7/x023zpvWObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bquHvIXE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bquHvIXE"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so2065214a91.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229248; x=1775834048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmGDNHUD2JGD7Cr/+zQDYzTq49jiZ6xutoZpxMk8fpU=;
        b=bquHvIXEcANxAXcf4dPUayjXnc8R2IeGorqWLTduI6WZ5M2Bi8xYns2en9bBcMIMzY
         4BCOPwdsqgyc84FQXUyrZPLTATSzg2GpYXKZ375hwEjtqRahaXrJy1mXmMcWGa1qXCHi
         E2/43P2oMuR+rSd6Ksto7nBVMo2BLfH8MRawpikhKOq0BEsGLOfrsR1jqOtgQO1n4L2S
         1Twb3cgNaowR72GiSqA7yjf9xJFwAic6tToWheGCPfErHb2ePeb70zVFDtxZDTsJacWB
         VipQm8MBcHtRuYeUFHxAeeAc9vxq13BHJ52Q54oEgTBdGf7mI98y5vdTpr0UsGMRMPTz
         nG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229248; x=1775834048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmGDNHUD2JGD7Cr/+zQDYzTq49jiZ6xutoZpxMk8fpU=;
        b=oio+8co61X7vdU+DeQWD9h1kaEfGsAMd1elQIOwq2rBe87lFFBQdjzkOK79bthFF/n
         ip5CYLhPFdNP58onlprYNC5XRdt1PWrmzF2M9iu5hMlkX/ozmNniCLCMHdMwpqRwzlG1
         pJyUpEGRl8gEGjzU9UOn0HJaP5y1zcN5/xs1n9JllV+Pc8FeBhvUSE9KTmbrPfWb+Gnf
         xHRzzvP7kvseVS0su1Gb62uQQWS88ykhXysqaOU2uhrR2ZIoB6H+KiB1noq01Iy/QFuL
         ALZgYw2ofASpyxfWRi4Su/d2M/0Z87LV+Ibj8eyGgxVP8gx4l/XAMKKBOTdUVcySbHxI
         GvfQ==
X-Gm-Message-State: AOJu0YwBei5OIZWyaJz8uWUa7q2uwRqb23aN0U/jgpSqvzp44imrQEy1
	y7d4003kLW3o8N1LUHETGMbC2n6vZpjVi82Zmyo4RCcV6aibApAWyVbryGVbkmesK2k9K1UxKEE
	A0uEwfg==
X-Received: from pgnh19.prod.google.com ([2002:a63:3853:0:b0:c5e:38a3:151a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9145:b0:39f:21a8:1e1d
 with SMTP id adf61e73a8af0-39f2f046ab9mr3497586637.10.1775229247445; Fri, 03
 Apr 2026 08:14:07 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:44 -0700
In-Reply-To: <tencent_7A9F1B4D75468C0CF5DE1B6902038C948B07@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aamiMBRsSwn7yxu0@google.com> <tencent_7A9F1B4D75468C0CF5DE1B6902038C948B07@qq.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522885515.294316.11875518116992037404.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Add LAPIC guard in kvm_apic_write_nodecode()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, xuanqingshi <1356292400@qq.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Mar 2026 17:12:32 +0800, xuanqingshi wrote:
> kvm_apic_write_nodecode() dereferences vcpu->arch.apic without first
> checking whether the in-kernel LAPIC has been initialized.  If it has
> not (e.g. the vCPU was created without an in-kernel LAPIC), the
> dereference results in a NULL pointer access.
> 
> While APIC-write VM-Exits are not expected to occur on a vCPU without
> an in-kernel LAPIC, kvm_apic_write_nodecode() should be robust against
> such a scenario as a defense-in-depth measure, e.g. to guard against
> KVM bugs or CPU errata that could generate a spurious APIC-write
> VM-Exit.
> 
> [...]

Applied to kvm-x86 misc.  I still want to understand what "Found by a VMCS-targeted
fuzzer based on syzkaller" means, but this is decent hardening regardless.

Thanks!

[1/1] KVM: x86: Add LAPIC guard in kvm_apic_write_nodecode()
      https://github.com/kvm-x86/linux/commit/26c9bfc0fac2

--
https://github.com/kvm-x86/linux/tree/next
