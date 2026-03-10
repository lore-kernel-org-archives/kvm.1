Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50B3D170D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163073; cv=none; b=lgKNi+s8OHyOSFTXVM6RXRpq0KBsQY1O5sOdVc4fsJcKeIgNj0GevNOLA/WbKIeTnFIxF7cNdfq+UDbUeTBReXvoFcn0+mw1KJvir3D8DoPBZZ8WBDsPxxwZmxq6U/kIHNAkAHK97XMwgLN9YTFiDhINo72jCsnGZJojBz+ZOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163073; c=relaxed/simple;
	bh=dFBW1esMyuAMDnGGVmYCP5OFXGVjP11B15JkWZWu76g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HG0Nq0kXe/lb+XuuNCsLyswjR8VeONm8xKRQwKWNKrwg/gIc5+gh/OEWHkORz75OhzQuXOmCv4laMHFmkEgdhg7nqsiz9narCchczRvW7/s4dVUWXZoTSKPJRG+As4GICOwg89BaKQOtmzeVtK8UBKhHU+MQ6eMjzsmDQg5jafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPcgJ1cN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPcgJ1cN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae3badc00dso112343595ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773163072; x=1773767872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2js8TxS1hyFxPiQX8Ai3FJPqj5QUTTd9TcNPsknpgQ=;
        b=YPcgJ1cNESr9iZZw6H872ZGH6hkzWyyiY8I6G9XnJbpd3V108BeorMqB0VgI4z+9ww
         GJF4fPxtchm2Slw5M6mO2H2hTCLwC+MQponioIRgTBFmD5ZpLaNK0+QOxvqDLAxXiNw6
         2VO/4lD9jg0ug8WxGI1/t7QfO01/bZiAVVb5d64UUS97/FoHWWBzOuBJwX/iP9WjTqPu
         t8tRjdO35qU8z3QtwownN6xIVgIGi7AvAGg4ZThW9DFD1XNlGlV3lioWJK9ynF4Rdtpv
         UggES2MLFhi5tDhIXU6MgBJECsF+PENMnGuyD6T+TiW/E8H/alcHtYClHpNSqQ3E/rKe
         WW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773163072; x=1773767872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2js8TxS1hyFxPiQX8Ai3FJPqj5QUTTd9TcNPsknpgQ=;
        b=TFwGffdFhtET9Zd50ejdpkfHJKuvN+NiRbJqBYccbXn7TCkl3awaYkM2G2t4ws6ukv
         4qterePqHQMPkOA4bnj0ww32lR+ntPr91YWnsO7gvrppBdjD9VJ4ofBl3/3Ln+soALDr
         dlYo8rRMwTKehbVj3BirhHO4cjyF4NwP5qWuvhzqOuQx4mcq+NOPysFd3FXrVAhT90v/
         FNjn5Mn5Xkq0dxyTHMI6kEa9LjH6qIylAkuZnkOzkkrfL0y52o2EJZZ1K/t8ArMkdKrv
         gkzLl1BpJQdvmnks7SmWaNOCLJNB6bNq3cWtna4OTLpeWw35/d870gQtzgBSAgDAbbIm
         Oo8A==
X-Forwarded-Encrypted: i=1; AJvYcCULxY97EPgX6LtT3Nw/Zmujlz8q9TtBA9BNA0ZBr2+A1jjP+pN44Za/d8MDVOsEBdY6eYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY6TgcmOx/qk4ElOQof14j7vQVtjBu3RPxyTogl3VUf8wVnkp
	9JeyG67LgZIK87x9oXIQvYP1qm7vXkARgdIPct8OFGstGl/laa6pYSF//NPZuwCRbA/UBy20DD9
	xNpnmeA==
X-Received: from plbms4.prod.google.com ([2002:a17:903:ac4:b0:297:eb04:dff7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:2ae:5eab:1338
 with SMTP id d9443c01a7336-2ae82366c81mr142402395ad.8.1773163071674; Tue, 10
 Mar 2026 10:17:51 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:17:50 -0700
In-Reply-To: <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203190711.458413-1-seanjc@google.com> <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com>
Message-ID: <abBSPkKmMiFCfKek@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
From: Sean Christopherson <seanjc@google.com>
To: Srikanth Aithal <sraithal@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Naveen N Rao <naveen@kernel.org>, 
	"Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Srikanth Aithal wrote:
> 
> Hello Sean,
> 
> From next-20260304 onwards [1], including recent next kernel next-20260309,
> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
> failing. However, on EPYC Milan, the SEV-ES guest boots fine.

...

> Bisecting shows that this commit is the first bad one. When I revert it, I
> am able to boot the SEV-ES guest successfully on both Turin and Genoa
> platforms:
> 
> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
> Author: Sean Christopherson <seanjc@google.com>
> Date:   Tue Feb 3 11:07:10 2026 -0800

Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
blame the architecture for not simply making CR{0,4,8} intercept trap-like.
Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
huge gaping security flaw, especially for SNP+.

Anyways, this should fix the immediate problem.

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 33172f0e986b..b6072872b785 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
        vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
        vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
-       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+       if (!sev_es_guest(svm->vcpu.kvm))
+               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
        /*
         * If running nested and the guest uses its own MSR bitmap, there

Argh!  The more I look at this code, the more frustrated I get.  The unconditional
setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't
need to trap CR8 writes because hardware will update the backing page.  I'm guessing
Windows doesn't support running as an SEV-ES guest, which is no one has noticed.

Actually, it's worse than that.  sync_cr8_to_lapic() will straight up clobber the
backing page.  Presumably hardware never actually uses TPR from the AVIC backing
page, but it's still gross.  sync_lapic_to_cr8() is also beyond useless.

And all of sync code should pivot on guest_state_protected, not sev_es_guest().

For now, I'll just post the above (assuming it fixes the issue).  But this code
needs some love sooner than later.
