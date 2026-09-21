Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756404A4EEA
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999724; cv=none; b=cYuYzFxK3ZgBKxT6St5HX2BNKVlpzV+zb3kpOK9jhpDN7+onA7u55JUdOe/flgaT29rpE2KT5zAvpEKTkwDjBpY7fcKkYWJPkUWu7H0peqr9cWap7k6iS0MxQQAnw0PrZ8h1+zjVgWuYu2ImAIrYbIbCqRWHnjKOQ5S109NsNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999724; c=relaxed/simple;
	bh=8xT+GzOJLxfUBILySpIuyhu8B0aQwVSLd13zyLaekXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AVLf8ZoOMBfZP/+6KKFgNFXGZGW7/GrOdZt/pKp341WR1fDksgTHlsKEmVRmkQG96xcthqWM4OiGtBOsH9G+agS2lsluHpgLh5lUp7Li2yuTZx7oHi1h+TMg/7GHbi+YwgGcpAAMWZan8BgoY1jpuCa6eZWQElhIL8d+H+lqq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkESoyy2; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkESoyy2"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso56748865ad.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999723; x=1790604523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+qBlq8BnUbUU+3sQzihzuChI//oTMLdvd1/u4oZi5w=;
        b=dkESoyy2BeGJ+Mz8uftEY3FgIaqLNsMxMRwuBLVnug8S+UUaPZBStbkB9FhuaqC3mj
         kvuQH016pWhPmOOmD433YeDYizeeeY2Y/1qGn9SN9KoCfCeEsXrXKtl4A2sY9lU2E9/M
         y75WtscObSdUXIj/eFMVZ7jjfOuGzn+HRz/q2n5N25K++MnilYG9bI61wlmaG/qV1G3N
         h+U0YalRWOiMs+6k73dK2leWn2v6Hi9YlBC2SjCX9hVB8Z1iLbVJQheDseaMz5Zxaqcd
         TTZ0tl8xkrCJaydebxOp2zsqcn5egUbYDOil5jxxxmFnixTjpOq4lkOSsUlr0zFXsaio
         cslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999723; x=1790604523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+qBlq8BnUbUU+3sQzihzuChI//oTMLdvd1/u4oZi5w=;
        b=RCNSiEzv3NeivsxB8UPcVT6gpwAmIxnadnjXwtHt1PfKmxDyvNr+nGNnfGpHVI60ZT
         K+gEUoFz6dBsNVtolr8DNMv6y9QxOIG15oXpPhndRH3fmfeGNUne1N4cmp3AFwNbpQi7
         /6z1G35zzNqyxjrG0p60TVJT++e6C/Ra5Ie4q+rz83PAH9EyNneVakEleVg6ARBtCzVZ
         FUlDX2Z9cw0Q/0HBiNP0kPivnqrdBttAQueDWtB+nwwIdAvBjhFFa9cLTrRPQ1IupRw4
         X/H2o0EA2PnlJ8dM5n3eQDNFJVg5Fv6r1/IrGlsCTkKravMTtrdD++3SXn3BgCh5bGnK
         rdBA==
X-Gm-Message-State: AFuF++kIHU+K7JtPWqO4jjrWiiqAcW+ofz6ZIkKzht+HblPTlg14W5w7
	dnJ9AuwUnWlc91P8m9FsfFt97Wz8A5xwnRNmHy2fl1y3ZVaNeWLDSxdL2D2yX0r6UJX5nT+p43T
	/kEw/mw==
X-Received: from plsm1.prod.google.com ([2002:a17:902:bb81:b0:2dd:c160:878b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c05:b0:2dd:4070:8eb
 with SMTP id d9443c01a7336-2ddb1b97f0amr166391375ad.20.1789999722721; Mon, 21
 Sep 2026 07:08:42 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:56 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999918502.750661.11881169009752034088.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] KVM: VMX: Harden against interpreting TDX vCPU as vcpu_vmx
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 03 Sep 2026 18:03:45 -0700, Sean Christopherson wrote:
> Move and rename "all" (read: everything I could find) common helpers out of
> vmx.c and/or replace their vmx_ prefix with vt_, and then poison to_vmx() for
> all common .c files to harden KVM against misinterpreting a TDX vCPU as a VMX
> vCPU, i.e. consuming to_vmx() on a TDX vCPU.  Spotted when working through
> the bus lock series.
> 
> v3:
>  - Collect tags. [Kai, Xiaoyao, Binbin]
>  - Move the poisoning to patch 1. [Xiaoyao]
>  - s/Disallowing/Disallow. [Binbin, Kai]
>  - s/vmx_needs_pi_wakeup/vt_needs_pi_wakeup. [Xiaoyao]
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/8] KVM: VMX: Disallow using to_vmx() in common VT code
      https://github.com/kvm-x86/linux/commit/05a0c1e2a525
[2/8] KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
      https://github.com/kvm-x86/linux/commit/903420c26086
[3/8] KVM: VMX: Move the shared NMI handler/trampoline to common code
      https://github.com/kvm-x86/linux/commit/81fbafddf6e5
[4/8] KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
      https://github.com/kvm-x86/linux/commit/09c6f74ecb86
[5/8] KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
      https://github.com/kvm-x86/linux/commit/96a113536fa0
[6/8] KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
      https://github.com/kvm-x86/linux/commit/881455777a02
[7/8] KVM: VMX: Move common VT getters/converters to common.h
      https://github.com/kvm-x86/linux/commit/d238df58b1e1
[8/8] KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"
      https://github.com/kvm-x86/linux/commit/decbd448b05e

--
https://github.com/kvm-x86/linux/tree/next
