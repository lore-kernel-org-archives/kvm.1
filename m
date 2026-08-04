Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280E44E670
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886778; cv=none; b=uTqgQmqkrcMAbt2E8MKx/OnZab1R14GiKVIRNkqA4B5sc7brdmCD8/2fRE4Gu1K1049CmQ9USX1PJDiSJsrVE3NvQB5jixs0VGEGU3pM11Lq9qxarNO3DrpG2/BryiUjfKparPoj1MJ+xwkUmqaQhkveQIca0fuErKO6+VJdaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886778; c=relaxed/simple;
	bh=ve0XlDTIVdsxLZuAiRZTN8Znz8sHjY8CmLeSt9uNPNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6Mx6b1LJOe/O7gvQbgLAPNijlR5WYHaZaoDDT+r4i/ovSoznxOvdnQ1x5Ab7F9Xkgcyf2sxDH5gFjc/+6LiHyJ+FTXB8kDI8R+BHl0j0iSv4GeYhcI5CZ6oT0UeIrJTm5nWvMO3t44YAtUXillXOmDlbOiiZfJ+bK3pzJ6wfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbtO9BIU; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbtO9BIU"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1948551b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886776; x=1786491576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pJI7d/gfSbhu3N7yByL0K0SVBnX3vMhWEbPVi3eeE6g=;
        b=GbtO9BIUPg3zry2zRc+CXvdZxW6gcRINv8Fo4b4E3K9v3X+qx0nxWpHYmV1jQqTOCy
         wRzUgNhP1Ntkt82jmFvQxfJEdepEZxbf+uxRHqrYB5sVka0jd95kJty5/tpLhCnTiw2a
         sv1Nra+CgwOcPHey/IF74cS0F/apPepaIJcDvE5M0bAAlkR7DLybwnFYVNJGSLugD6QY
         u8aNf5Xfl8G/JS0wrCci84Eij0cqUc7lPm8Z3FHjn3uGOWuAHYvjwoZIvmVhKs8N+ZSw
         hgYsgse4yPpoTGtyaB7GYFVP6nIAljDJhBIVXFVVGLOaqTArrkZ0LEdCF6UXTMfPj+co
         qLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886776; x=1786491576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJI7d/gfSbhu3N7yByL0K0SVBnX3vMhWEbPVi3eeE6g=;
        b=oawoSlwR7wT1gp2wCi0rUcwf0QjjyWnOhR/Dcrc/Upulz1o4ZSBcklS9H2eOfC8/kj
         epwkT2FDkn85SWiM1BBN5dn/0lXWDULDApgNB3Gjmhmijnue25Gm2R8y1h3b1ju5iNfx
         wupvyWE5qLw4OKXLsBnGsC6TSfjkZHqNAx6vi/3jNn4QHk+QLdBx41LSCRY/4BgPYEjC
         IzBSEjQ3ndlJaAJ1qNT9/oy4gwOFMC3slHd+6JtXw3ze+sa0GW8YsFVlGH3E+OsI+qgQ
         L1WVYwj11l9a6Ge602cFvJC5DR00GLPPrAkqrtH35V2HuuIfOL6Vvb6sr7APd6vcVKLZ
         ez2w==
X-Gm-Message-State: AOJu0Yzs0S+q87nDRP9L++BAhhfD98tsRmsAB8vCnQSumVidt1EJ1HRD
	P+erOSUSVp4vSozAanpyDxr94B8w4d/n0sFh1llOSsqQCU1dQOPvwoeloeyligkDsvXqs6R1rWt
	H1/Q88Q==
X-Received: from pgkn3.prod.google.com ([2002:a63:ee43:0:b0:c86:61a1:3390])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728a:b0:3bf:651d:fee0
 with SMTP id adf61e73a8af0-3cb85a5cf33mr2268115637.19.1785886776244; Tue, 04
 Aug 2026 16:39:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:13 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-10-seanjc@google.com>
Subject: [PATCH v8 09/17] KVM: x86: Fall back to non-master-clock if clockread
 fails in get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

When computing kvmclock and it's currently in master-clock mode, fall back
to the non-master-clock path if the clock read fails, e.g. if the kernel's
clocksource transitioning away from TSC but ka->use_master_clock hasn't
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
index cd2a140e8e63..7768a8909cf8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1674,14 +1674,13 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
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
2.55.0.571.g244d577d93-goog

