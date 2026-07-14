Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A241A923
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054639; cv=none; b=MYIiX/quROCT17ro90CNVZuCIIpKiT2VTQ8NJIrCyPTZcwHL1CmUEl52GUBRTpVIn/x/jX/128SP7/K/JtgGquqLvr6vEuEw/lLsXxDwK2/6rhAgGMnZ9V9rE1LX4ZXUBvodLwMPzoLpnNhaf5KwEixFjZVrHflPmdP//19J6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054639; c=relaxed/simple;
	bh=twDf0pCPc5AXQC1Yc2tviS/GkD1I03OiwE7bIlzB1nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hHU/DS486wdUCDlHddVXN/Qi8/lUJY8Dws0VHRFvSLmfxHQkoBjAu4xmXuXiemyMwrwkpq7R7lp1xQ+RbEYLU1aoNlB2GfarfOkeoJlQ2mGjXQ+GriCHdF/Qpp8wGRmrTXN+C14nQIBu2B2uK7GS5/y7gluzQNECTcQWgGPOD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Px+/4LT8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Px+/4LT8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8486ffba174so7690876b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054635; x=1784659435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzOg2fUbAiirgWWpjClnkBDsCpT0ejrIxHDCfEtbiDY=;
        b=Px+/4LT83/2WEHMeRTVeD85ncbZ7wq750q0J84fWzDMIYHS6gqzYgNEYOMkOAIewyD
         WB5P+P46gM2uCkRgRe0wXyiYduS7z91yCcjFszSw4dzb/tpYuDtUGS6fkFhHwLGRaG1z
         6TydYwuXBDSdsaJUWMTUqA/IfWTkNtaGPcL2TfoL85rjlOPQlG8WP50b28J9Lyformhk
         qbxnbs1Mre9kpqJfINNkrQ8QfRPfKLibp6o2g3W+UiJ3+fKN8d85+hsQWD6GYb5ZZicM
         jPjSdagI1amgCQZlL50UrNtzjOVORmGfbMXxT0SSuhqhu6iDOBPGoiRtTMQYQAWEViG+
         iDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054635; x=1784659435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzOg2fUbAiirgWWpjClnkBDsCpT0ejrIxHDCfEtbiDY=;
        b=tKvoOVMN1cZuk7mZ3qAkyjR/8LN4Uqd8agIk3imc3bq8/p0L1il6P8r0khONKDj6hK
         9Wx9r/Mh4WFcXfHpwU+lA2xdSZ6hdvOysdEyoJZUBvS/OgtqxpaV+i0z/AamFYlSb9HP
         X+QZ5iwvC7civlAvvWAw1JphfI37l73smsfVlWBFi3CytZ8sPT3o115YScj3ru7rtqzF
         ahvdVsiiBlqf+U26JZM+xejaqXELRa8dzTHavUK4zNpvOVfC7v4bOsqLLp1F3ZBvigkr
         VNr2W3tpUdSndsrRyUP1YbfYvbgvnc9wN98Wn6rb8BQbXpJi08KOx5pfKsqaIbMNySn7
         do4Q==
X-Gm-Message-State: AOJu0YxnxrO4j3IE+0kG2UwBW9umH+r0nMao9CB58Wl+zzDMafBozgaj
	KPgh7Pvks8cL0+gNO4Qoq1Fitzlt4vWmfzse5UVp7ZkqnsR7XA/j6ASFIYUf6hWef1KbIWV2mDE
	pZb9IQQ==
X-Received: from pfks22.prod.google.com ([2002:a05:6a00:1956:b0:848:46e6:1aac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1701:b0:848:42d0:bc91
 with SMTP id d2e1a72fcca58-84a554fa58bmr3605833b3a.12.1784054634455; Tue, 14
 Jul 2026 11:43:54 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:11 -0700
In-Reply-To: <20260624220516.3033391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405354131.3120774.17173754637791499948.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 24 Jun 2026 15:05:16 -0700, Sean Christopherson wrote:
> Ignore KVM's internal "service pending PV EOI" request if the vCPU has
> disabled PV EOIs since the request was made.  Asserting that PV EOIs are
> enabled can fail if reading guest memory in pv_eoi_get_user() fails, i.e.
> if pv_eoi_test_and_clr_pending() bails early, *and* the vCPU also disables
> PV EOIs.
> 
>   kernel BUG at arch/x86/kvm/lapic.c:3338!
>   Oops: invalid opcode: 0000 [#1] SMP
>   CPU: 4 UID: 1000 PID: 890 Comm: pv_eoi_test Not tainted 7.0.0-d585aa5894d8-vm #337 PREEMPT
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:kvm_lapic_sync_from_vapic+0x12b/0x140 [kvm]
>   Call Trace:
>    <TASK>
>    kvm_arch_vcpu_ioctl_run+0x1075/0x1c30 [kvm]
>    kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
>    __x64_sys_ioctl+0x8a/0xd0
>    do_syscall_64+0xb5/0xb40
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    </TASK>
>   Modules linked in: kvm_intel kvm irqbypass
>   ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs
      https://github.com/kvm-x86/linux/commit/9285e4070df2

--
https://github.com/kvm-x86/linux/tree/next
