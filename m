Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F347DD40
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905712; cv=none; b=oz3yF63glZpy28P2b/ztdSuGqTmVoXIrothc/cWWy6EAryu25JrqYmCw08NyKw5Iz8MejGnhVuKpvDmAIdK+d2cJgEWlViJcSk/8/bHHNCaYAtMiK10KvTMJ2KWJvek/OM3tURGbQFcjL1qFonE57+F39Qa7pj8ge1p8NYsLS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905712; c=relaxed/simple;
	bh=5bPgBRtRtdsQFi7VtUaqyb3XuhjTmF4O/ibSzQdmq+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GMvIKHhZqzDX53ZC4gMnmLNn9Y1nd6nufQuWNhU1z+nEs9luP+UtBLBalMU3bvXdkyRIZivaCwF/HAQ7I3UxorX4XQjNlrhR1N5MV2a4lhhqKVOj6ml9bzs3g029RKIqUlhA3rhgaEvhmAJbohEb3fH93XpjcJYgttPs6XaqPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHCflPjQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHCflPjQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-841d02525b5so2126577b3a.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905708; x=1780510508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJKVmvwBIPG5NF/Yuin660fdr1QbYU6pDQytWb9VX18=;
        b=MHCflPjQ803IzEzc4yRt1FIW7nHMEHV4d6fnF5OofySzr6dfvqmO+gIJ+xLjYlM++S
         HwyAIHTDkSyI9NPV8puDSfH8JOhrR5G4DKOJlwrDaXYzQr2drgp1qv+SUdMiMO1sqNju
         PSEmnsuHsJTtZTMgmt12DL1Wl5SjoPoJXO+k46MTPjn2+SptsJojTENVwr7xXDliMtdD
         y/n9uQvjPDw7lw+2D8+bbwQulJYXi5fALIF4EtJ4MqGZW70hLt3ifWYmxrHwBEJxS2sv
         u0Xllou8lP34cVB4ytcviYMF+P/RgeUbBDCMrt2puzqjJ6B5qLHVr0ZAP8pzgNzV8ygB
         LE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905708; x=1780510508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJKVmvwBIPG5NF/Yuin660fdr1QbYU6pDQytWb9VX18=;
        b=h0VsqddI5vRukvG3Tfqx7DTZ0kcXL5saNj88ZSkO/LxCQBjI272rPnbrSs9Y2io2Pp
         bkBudo6DeHlfsCgZVQCVaiSKl6udsTaF8TCCCziZAQ9n/G6BZeNb5fks/S7+WjQTLdcc
         o5pLAtsZB0hp9SxCbjraZq6fzuB3AGzalCH0BZlTdxjTk25/IdpDX0yqEMLfmodezqD6
         e98MuWypIvKLETQilrzX9PkQJ7yfyNt3+gHUXmIS5gT+TtL4Z7r2L2cSLub57YMjacLP
         08WPAXCPUfU3IED1FnflKVm5XYPV8Gyy3CSDusKHPmb//LaOuw7hc2lv2mkQNEUW79F+
         lCeA==
X-Gm-Message-State: AOJu0YyktyqDiZjAoUlB5RQh1aTkYeZSuOT3rjMXyor1NQI5PJlXyOrU
	D72fgAOK0RI//EA5NbEdwPfYt99ZDzv1zbehhvUUvrvUgvJtRGQO0IxgBkEImOatdYVfnSJn9jc
	egn0cDg==
X-Received: from pfny13.prod.google.com ([2002:aa7:854d:0:b0:841:ac37:c9bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd0b:b0:83e:b443:9651
 with SMTP id d2e1a72fcca58-8415f0f01cdmr24424110b3a.4.1779905708212; Wed, 27
 May 2026 11:15:08 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:22 -0700
In-Reply-To: <20260514213115.1637082-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514213115.1637082-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990527535.4121628.213299391904873238.b4-ty@google.com>
Subject: Re: [PATCH v3 0/3] KVM: SVM: Fix x2AVIC MSR interception issues
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 14:31:12 -0700, Sean Christopherson wrote:
> Fix a variety of bugs in SVM's handling of x2APIC MSR passthrough for x2AVIC,
> where KVM disables interception for MSR accesses that aren't accelerated by
> hardware (pointless and suboptimal), and also does NOT disable interception
> for practically any of the "range of vectors" MSRs, i.e. IRR, ISR, and TMR.
> 
> Note, I tagged all of this for stable, but I could be convinced these fixes
> shouldn't be sent to LTS trees, as there are no functional bugs being fixed.
> 
> [...]

Applied to kvm-x86 svm, with a fixed blurb for ARBPRI (hopefully :-D).

[1/3] KVM: x86: Add dedicated API for getting mask of accelerated x2APIC MSRs
      https://github.com/kvm-x86/linux/commit/8ba621f335a5
[2/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually supports
      https://github.com/kvm-x86/linux/commit/7f4b7092d9a1
[3/3] KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are accelerated
      https://github.com/kvm-x86/linux/commit/8c63179d975f

--
https://github.com/kvm-x86/linux/tree/next
