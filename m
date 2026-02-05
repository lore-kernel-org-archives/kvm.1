Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB3337BB4
	for <kvm@vger.kernel.org>; Thu,  5 Feb 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333840; cv=none; b=NwwFM+dyd2QWybrQGLTxiBdI/QzW7gZctR4WcVjpUEJYTnSlWFAOuDUfBjK0okfbEsocJHNlAnwAK+Eil4ZCV4FbMCUL9isFUI2MGz/d24PB6S7HOsNTM9O3WRPu0yWPDFD7iStAHlK+97il1Wj03dGkjGlPmisXhENRXQwPq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333840; c=relaxed/simple;
	bh=kYJ0xbtYMF9eSWTHi1gW1Fy43B/P9OPaa7XaKm1WNzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MR4QnWLwjYYcku4qlq8vA//hJokxs0doXwmHzLG+Q3yX85i1JMQpy+uupuVj5QCpDlukvGNztL8+a3NVI2fzECYlC3C8vo32I6ZodddzXiuKyj/8lU530FODIlQW3xhPv5uTAewrr2HzcZxwqicGDZqarLXek7nbfDrEZYSW0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sb5fyJXR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sb5fyJXR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so1426999a91.1
        for <kvm@vger.kernel.org>; Thu, 05 Feb 2026 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770333840; x=1770938640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjrOHBwOAp+rfRNqktTmxKMOj6iLbUuyVutwNWbVhG0=;
        b=sb5fyJXRwqQhs/nRjbTFG1HV+pm90DN/h41vwLmCHtifIZ6YiiV9RNjjOHzywEurGE
         zQQ0XP+/MWsaoBQneZpjCZkKJzRqRbs5xcA9o1lY0p52xUyoAicD4WRheN684uil2eN2
         0oKZ68/hS+RwpP3V8wyz3TPJH9d2LW9U4zj+DRAp855njdYoVuetRCHd18CS+A+5778D
         +ZRzf1ZuoIT8X5HCmQXmeJPTMEShU4+XoimJihlciQNdh5JhVhG+bc9GBQmyLv2/Xc8E
         CREBjfum/NVXsRmF3ybOVsJY4w0tAPfXB0UTZPa+gjUeIYmzNU+bEfXbeXCTRvtuRWyC
         Oejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333840; x=1770938640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjrOHBwOAp+rfRNqktTmxKMOj6iLbUuyVutwNWbVhG0=;
        b=C2a/ftf6MyF0TLvflUkR74yS6rZODg2Ja6+gRS/bSh7P98SKHdlm56gYBeENF2TVh+
         i9svmwPsNqm0shCzkAflkHJtDglY07BYc6+qvs02Jo48rOTscAmDJobXvXfZV7hTEBIB
         qTSHydaDulhv+4DSBdpkzdywo658tQ+op4AJ+7UFyLcOjpMqyBxuipbEq9zBt5a8Xw3z
         g0IbPlbZ9OlTJ8BITa5nbXf4gX6rJ4x7S1z9exRoCPPbegYTyVOKxjIVgL4DSP/DFZDe
         j231WtLAvSb+7s4QTEMGf3euZBs9WVMSM55jjCwiWQb610EdtCqVyiELYIIhgyNT+u24
         cKlg==
X-Forwarded-Encrypted: i=1; AJvYcCUWN+Zk92JJOCn73Upfdkl3m3hyeM8wk6Riu95AWSRp+vrzdpLP+EF0M52EerVg4V3A2YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcL/GLy3vrInX5LSZJdK7v7LdQOYOOP5FZmh27VS2v3drw5hTp
	Z5/LfWhXE8+kYlhbufqq+OF56IKCRjTXGmTawMYfwLjxqEjxCzgEH9fyiDOooaP1w3hxwJyc7Yq
	d1hUbrw==
X-Received: from pjed23.prod.google.com ([2002:a17:90a:1157:b0:34c:2f52:23aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cc:b0:32e:4924:6902
 with SMTP id 98e67ed59e1d1-354b3c406ccmr629203a91.3.1770333839918; Thu, 05
 Feb 2026 15:23:59 -0800 (PST)
Date: Thu, 5 Feb 2026 15:23:58 -0800
In-Reply-To: <20260205231537.1278753-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205231537.1278753-1-jmattson@google.com>
Message-ID: <aYUmjpXZfDhDiuuk@google.com>
Subject: Re: [PATCH v2] Introduce KVM_X86_QUIRK_VMCS12_FREEZE_IN_SMM_CC
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 05, 2026, Jim Mattson wrote:
> Add KVM_X86_QUIRK_VMCS12_FREEZE_IN_SMM_CC to allow L1 to set FREEZE_IN_SMM
> in vmcs12's GUEST_IA32_DEBUGCTL field, as permitted prior to
> commit 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM
> while running the guest").  The quirk is enabled by default for backwards
> compatibility; userspace can disable it via KVM_CAP_DISABLE_QUIRKS2 for
> consistency with the constraints on WRMSR(IA32_DEBUGCTL).
> 
> Note that the quirk only bypasses the consistency check. The vmcs02 bit is
> still owned by the host, and PMCs are not frozen during virtualized SMM.
> In particular, if a host administrator decides that PMCs should not be
> frozen during physical SMM, then L1 has no say in the matter.
> 
> Fixes: 095686e6fcb4 ("KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter")
> Signed-off-by: Jim Mattson <jmattson@google.com>

I'll tag for stable, but otherwise LGTM.  It's too late for 6.19, but I'll get
it queued up for 6.20 after giving others a chance to react.  It'll miss the
initial batch of pull requests, but I'll try to send a fixes for the second half
of the merge window (I just realized I need to create+send the pull requests...)
