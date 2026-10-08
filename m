Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC73CF1E7
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450018; cv=none; b=D2CTnJUZu4xQyq3NTUerSPJDnGwXqQpTL+nv9KIfkj8vPEJmsXV+xkjbQclNeb5vtEW2BFfsbQBfrc/HZM2pTl4WabYYqgmfB4cQCGddza75TOh4PZGGOfhjy9EKBbbp6TnGNJ1pGKOGXcaPrKza/tXc2mHEH+Ap4i8RwbHLH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450018; c=relaxed/simple;
	bh=8xCN6Tvqz0pcsznR6v6m6OkGJanue95i2/2BfJ+SlIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8Qa+h9DrBI2OzEnhwLRUGKwpaSepZoFXoZdEns9XgcPwnvnCoia6fl7ieGekh0+OBpzLWK77JBSt/j11JjiC1ilCSGNd5UycaacsQlhGXxNz6wxoEmg/+YdQ+86A4b7LXekZXaHa7sP3i4RAP4nVgIvEgvRKiZRDjjytbk4mF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgQjO1qD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgQjO1qD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2510984a91.3
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791450017; x=1792054817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MofLqtg8FWarkgbX8GUaWLJMa5TwpVOagZ0XterzGe8=;
        b=cgQjO1qDSzpXdKFKC/n6EsQE1RdpUHNbNRZZsELYkEwK8qIh2eRytKLoHTw1rusjFk
         jc23z3oDndjNjb/AH+McHpotFkgd+TtRoKk95WcB1HGOCo5vTjeGKbED5KtPh68fuMfC
         x6bgwhJtfUpdthLbczAu2honcTGyhDIBD8LxhH+F+TrkMSVU+ptV9L3k5NbD3o2rDF7q
         fxlG4zgJE7dMzhRBwcKk0lgyR93aOu7QF5xdT3A6epNQzD+cmvuINNx0UXobzFsaUATc
         j6EftG9Ae0YhQJzOe3qoTt9nEBSWELH7YL0jAZ5WFgU4hRqDDWvi9kBIYLHXR7wd3Ggn
         otWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450017; x=1792054817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MofLqtg8FWarkgbX8GUaWLJMa5TwpVOagZ0XterzGe8=;
        b=wonHonUd0JzZJK793eQinVWiLIDQFew1P4dF+ArMohBOnx7IWeoMgBMDE2m0BBBzUC
         9qthlwpSx0dmc3pwVQmPVc67q0GSTsCbozkrVnbdCiQkNwBIcRu4+XDdfQUHP74UlTVN
         6m/9DSwQqJ2z7Ur7HjLtBmmitPjrx+56LLjLyxpxENtUdo6Vm75aYtgiNT7jBfYasZi5
         RbhdEfLywDO1a1nLOcwsQgRgLF4uJ9EHQcIuKP+M/uERstneRSntGQDk+1jED6dmVhbz
         ZVYaghPp5xzA0YDo4jFiw+vqOUbnMVFwrz5P3q8vYL3TutBvvmcUq10p+KhA8CdDjcFp
         qF4Q==
X-Gm-Message-State: AFq9FYIeKmgOEEDUCExYTOMl0HSOo/d0RHVbkA3uRcNhNDZNfVfQtCDq
	mhB1fv1GFmfdg7py5eu6i3M1HUnZMCHSPJj3wQ3xlt7qy/KTIQCxcApzovAogg==
X-Gm-Gg: AYBFou2GEDGIeMhh91LBTo4YOjUEX0qYLHfXNL3Ev8hC7gg9VilqyJjdA3ieXPGnyNy
	qX0Gj03eSUPErXRPLic4SA4Ske3EKijrfWBR24JFNmpa2+LvXoaI5kVwhr4ThSvyhWL5Mzp7vMb
	oqRByytpZejw9pE1GRJTCl6zEBHiHduqb0mYONP63ByG7qz/vuCH0dtxlD8upwDqIXN/XH6vXNU
	43ZAJCRpIkNrthPldGULKWTb11GBaWwQEpo0swEJcF+uJ1SBtLCTitC8/a4Ivw1/J/nvPHUa1/f
	3CE+Q2L+0lI2rW9Sj3O4HV/bg5iVjXzY7B82/cNI4N5b38UaVGvIAroYeHhcr9Pa4X5CkAFDRSF
	sNah36RWZXuexI6GMtakm7ShoM/KoogRalUr8R+M+b/pKayh3QueewYgDQ/ne85aI9X+SRGC2gh
	04wiL/62oJgcy+a4DtXquA9ZKPfDXZuW9OFdCDaKpp8I+lV9/QoCGEW4hhYVFB+O179//jotdDG
	X7JF1tkG9AyAv8Xe2qZ8KZ7HTo0QeAE53vAzQoqFg==
X-Received: by 2002:a17:90b:2b87:b0:3a8:796e:ca18 with SMTP id 98e67ed59e1d1-3a8a1522834mr4345848a91.59.1791450016680;
        Thu, 08 Oct 2026 02:00:16 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cbccea3sm3278150a91.15.2026.10.08.02.00.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:00:16 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: Guard against division by zero in __wait_lapic_expire()
Date: Thu,  8 Oct 2026 17:00:11 +0800
Message-ID: <20261008090012.86252-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtual_tsc_khz is zero whenever TSC calibration fails and userspace
never programs a khz via KVM_SET_TSC_KHZ.  In that state
kvm_set_tsc_khz() forces vcpu->arch.tsc_scaling_ratio back to
kvm_caps.default_tsc_scaling_ratio, but a nested guest can still end
up with a non-default tsc_scaling_ratio via the L2 TSC multiplier
path independently of virtual_tsc_khz, which sends
__wait_lapic_expire() into the tsc-scaling branch and
do_div(delay_ns, vcpu->arch.virtual_tsc_khz) with a zero divisor,
crashing the host with #DE.

Bail out before the division, mirroring the existing
"!this_tsc_khz" guard in start_sw_tscdeadline().

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/lapic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e1f3cea14765..13e32c4915e2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1970,6 +1970,10 @@ static inline void __wait_lapic_expire(struct kvm_vcpu *vcpu, u64 guest_cycles)
 			nsec_to_cycles(vcpu, timer_advance_ns)));
 	} else {
 		u64 delay_ns = guest_cycles * 1000000ULL;
+
+		if (unlikely(!vcpu->arch.virtual_tsc_khz))
+			return;
+
 		do_div(delay_ns, vcpu->arch.virtual_tsc_khz);
 		ndelay(min_t(u32, delay_ns, timer_advance_ns));
 	}
-- 
2.43.7

