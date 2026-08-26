Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D048987D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780003; cv=none; b=NAMNZBDCK9aPXTM3O9UiWeYOamQoskgBX2b8FXeXjcGWPPSGWmFGRetLFUJfYrSFNN9HqCjYGASlZazT+hAgyvwBOEKfoj94IQAjGziKIA8WJBE2EJd1KXyQ5gUdDM2rLDOtNTOJFg90GYmzOrcr/zbT586Pq7dDVjr3IAaD0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780003; c=relaxed/simple;
	bh=Dyer1ULn/a/i4L4ozp6ZOIcINMbH4yOkx+5FletSldI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=al0juO5eaErFKuiG5cXL7jiO0VbzgTBD8G7dhCO6i/DWXtFk1DiCXtgEjgNylGM3mrW5CdP1/T/GayT7HWReI5497iUMQVH7Dt2dcASn82Z/eHoADPG2O3XyroGJfg5qAumz6qIOXWgRSu8hWFMfruHDr6NywBGkWgit9A58xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERe9rvgW; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERe9rvgW"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c2f1acebso52833a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779996; x=1788384796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=goM61cDq5JnxRmzeon6yIX5IBAcd9O/5+qmf+efG8yU=;
        b=ERe9rvgWNMRNhq8CSzZF0bpo/QSW7+SbU1gXN5J8tzv32LQy5Pj7iJ9fIWGrIf3jc7
         uMuC0BByzFxhcuH57U6YvqacPdjbluk7GpxIqgBz2IWqCJHHd9/CdWa60+oa7Q3VnKkA
         6TZC9OAF6DBGz27LL31cz1RK9KXB+W3nNtKFUU+oO0XWyl4XxfoSfeTXQIh5svILkzxS
         Ri0nD4mfmcbwxp0ZE/UvMyLtZ0rOmJKCQLn9HrOS5Ire7BOKAZJbFdIOAkw/2yERTCQc
         hMC1nzzkVEJ7NdceuymLMK3MUSVIKQS9hR2/BcKopFbzHLagNtgINoXg6/ihZnP6VxZo
         m1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779996; x=1788384796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goM61cDq5JnxRmzeon6yIX5IBAcd9O/5+qmf+efG8yU=;
        b=Nxb8bocWA2H1f+3PcDXYKYcMt4fEbiMasHbhnnZJa3kUt/KZCac0s4NR3CEiIAC9Cl
         D1sY73B4fpbz6MDXoxVjtgEdOMIGDl5Ue8KwBBUzeAWBsAQyDOauQG+UHRL2OnbGqc80
         P2n7IChXZMEL8msiD5HCISpEWIywR0kg8sWrBtMfG2jE6/uoKxXPaC961wdeDDgJizRR
         +XQ3M4N4hhzj4lVcYYLC7fR9ql62uW+pTFw4sLJDkpRsPrT0P4YZo3pH9BxDTPt/1XiP
         1nHqrTcIkvqYF1IE5HSgdUthhuEcMVe0e/8K+dRYDYmIZfhVC/UD6ZCgQXdxSmX4yq3u
         eQOg==
X-Gm-Message-State: AFuF++nU63+s06U7WUqwfAUHVjS0nMLPLVWr4dOtNB6xuuB9gemANi2D
	UY35tUzi8i3Y5k7FXFcn4flVo/3mVRdtnt/o4bOfU9Y59U+IZbguJLbaTcU8jxNUsUgiisTXqj3
	KqF++kw==
X-Received: from pgjh17.prod.google.com ([2002:a63:df51:0:b0:c8b:2706:11a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:93a0:b0:3c3:791e:5e18
 with SMTP id adf61e73a8af0-3cf83341769mr21745880637.7.1787779996284; Wed, 26
 Aug 2026 14:33:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:50 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-11-seanjc@google.com>
Subject: [PATCH v10 10/21] KVM: x86: Fall back to non-master-clock if
 clockread fails in get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When computing kvmclock and it's currently in master-clock mode, fall back
to the non-master-clock path if the clock read fails, e.g. if the kernel's
clocksource is transitioning away from TSC but ka->use_master_clock hasn't
been updated yet.

The rdtsc() fallback was added (well, kept) in commit c68dc1b577ea ("KVM:
x86: Report host tsc and realtime values in KVM_GET_CLOCK") purely to avoid
uninitialized variables and compilation problems on 32-bit kernels (already
addressed).  In hindsight, keeping the rdtsc() was a hack and a mistake.

Link: https://lore.kernel.org/all/CAOQ_QsgVqS_PuJo8F10Gg5Xw+tKt+5gDx+kJf1j3CiPO4MAOqg@mail.gmail.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: isolate from refactoring changes, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 64df8da3aad4..d8bdc64b31ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1676,14 +1676,13 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!tsc_hz)
 		return false;
 
-	if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-		data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-		data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-	} else {
-		data->host_tsc = rdtsc();
-	}
+	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
+		return false;
+
+	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
+		       KVM_CLOCK_TSC_STABLE;
 
-	data->flags |= KVM_CLOCK_TSC_STABLE;
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 	kvm_get_time_scale(NSEC_PER_SEC,  tsc_hz,
-- 
2.55.0.887.g758fc8c411-goog

