Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F139C637
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133858; cv=none; b=C2lJIRGShkEsStrrcTS3+w4nbfs1gxup8z1siFumq784fBioiYPx9C2K/jNlubsF0hkn9n41xQqtg/ovASeGpovtnsEBLmjOODQOX2iPGBJPJ/GTR/ZSXk/mLW9U/UOaHZjZqAxXh/RISh2tWvUVx7teMD9Tq5RNgpTz9mENCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133858; c=relaxed/simple;
	bh=brrnJVOqQ+HmlXP6bRZSNZ0XkAOugFpp2qAEvCN/zkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oH2heEy20CzmueR1zfOO91ptGhyxfgcLiJQvUs1SUPfIv5Lmjn/5WMd9eNojhzSGJM9MFZ1F/LS8z2WnKeUQ3jzs7CNLbKI41LkSR3LtGH/C8SndESLbs4sdkxJaTzCjOuSvHdY9BdouLUQN+pLoTzlAhZkO1r0eNGnodsVagI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW3EorQn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW3EorQn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1561429a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792133854; x=1792738654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YISc5oMGhcHW7+1utxN5bTXf7xFDmvdTaxjR4KsInxQ=;
        b=JW3EorQnRsUbKT5vrJ3oh5K/Xn7wpg439eLIJN0+W2ak0XhE/CnuBMGRNSIObq+GdX
         jZz3Dlz0Ezq72+ZMQ5Brrm0iVBnwnXqrQYGGE0zeCL1I2ISzWqmlGsUSVQfA1D/3QYU3
         mS8Bp9EujGDKOX/EVR5lqxck/oUJ/3KDolgD/rkdsfs2SKVLiM/ieb95gVpYYWWEtg4s
         G/wE0e4OWN02V29FdPy4NRkEC1+n+ybekvDvSR2DvVJN7JmE50Axp4NTENV0jQGkYmCm
         aAnnB5gHLHcbm3MSOain+S0zwiLL3O5iM9Sg8RGpoMmGOSi79aWEv05smQlyaKjyXi1D
         r6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133854; x=1792738654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YISc5oMGhcHW7+1utxN5bTXf7xFDmvdTaxjR4KsInxQ=;
        b=MsYRGX25pnRkUdRBC3aKSWWv7AhQ+y3J8A2gxZ6b6KB49RqTl9u+2YYBz8d+T7S+XD
         0fzVJQ3RwBYOc0x7OjH0uHE00iKun04tgocpu+wRtQ0qO/SQwC/KfzKltRCIuooisCgf
         9cSzA47vxkwMwxWiW3O8m9FDo4SVmfzVhRjcPVaGLqz0GXdGEguq/ImjsedDb4XPKZCc
         2rkoWwXPBBn41Ab67G0Rdk6a1/vS72v5Ig/OrESNr4w1Hhn1MBUVPXwz464fD6EwfV/J
         RPphpv2LEzA1hjc0WCZMWEiHj5X/FBRLS9YnUtdBqdvdTmFtvGnljCdvxBnfUKy2rEVF
         +B7g==
X-Gm-Message-State: AFq9FYL8Rqn1Z+6WWwt5wcRGAHCAVqPC3hqtO9oyePJeNNIVdCqWX9xq
	aOilob6LZRKuYqV1KBs2kkthBqtSooV5y+BCihFSGXX0B6uVSfE21RGj
X-Gm-Gg: AYBFou1VR6GQLzaTDj/JlgBzXH+xWqhPpXMVPB2eWs7WbNo7GzN5e9AFfr9K2JogoRN
	yiZVADVsqRQzYdu2ZQJXhkwgBMHlHFtsnXM+ImlZ17FWJq+lx5N6gy0s64Z4An4QFygrvCrRyzV
	ApEfW5p9VkLNKXATk370AbD7T85R21z96cshUJG0vpxrGPWD43TCJJYXIUCkhxa21ZhohxS9xlZ
	KNM/P1RMiXTUTGZCYnbtLP8iqM3aSXWtkg0dOo6R2efw522SdShMYAy+C1EsKbDfBCDvbSie8OP
	03GXdudtpbyQs6sdN7fOIYYqyU2mD3RBA9ZX72Ph/Ym6qPp63xgOxS7c53GgympOxLUBb0YsHlL
	hXCFk+XMnI/c1ekfoJnGNhbGG8HsHTmqEvX19yTmF33dlIO/SWyKLHqVmNulFVTOSEwfzsssgZL
	j41d9PNoKMSZbKqSmiAsoRnJEpt21fV3g33AxsfQhTEdlj2+jJOlIUMRUe4mDr1ORG/cvOGbAGw
	VYKMQA82HC94ZyUXa1gXl5PCUjXTyRx6RyqfEZPmQJH2muf+6yAyKyM0cCBSdafpo1wjGmWF+CO
	6Cj5OqSDvEkK05qQcmjXV9uyZ/1c/FnE5l0vrCTPy9BI
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3abbe66e034mr14548452a91.20.1792133853729;
        Thu, 15 Oct 2026 23:57:33 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947dfa00sm7765410a91.17.2026.10.15.23.57.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 23:57:33 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: Reject KVM_CREATE_VCPU when the host TSC frequency is unknown
Date: Fri, 16 Oct 2026 14:57:29 +0800
Message-ID: <20261016065729.85873-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If host TSC calibration fails, tsc_khz stays zero: tsc_init() marks the TSC
unstable, clears X86_FEATURE_TSC_DEADLINE_TIMER and gives up.  KVM has been
papering over that state since 03ba32cae66e ("VMX: x86: handle host TSC
calibration failure"), but the guest cannot actually run:

  - kvm_set_tsc_khz() computes thresh_lo == thresh_hi == 0 via
    adjust_tsc_khz(), so use_scaling is always true and set_tsc_khz()
    divides by tsc_khz to compute the scaling ratio, i.e. #DE in host
    context.  This one is reachable from KVM_SET_TSC_KHZ alone, no guest
    cooperation required.
  - kvm_guest_time_update() re-requests KVM_REQ_CLOCK_UPDATE and returns 1
    because get_cpu_tsc_khz() hands back the (zero) global tsc_khz for CPUs
    with a constant TSC.  vcpu_run() only breaks out of its loop on
    "r <= 0", so the vCPU thread spins in the host kernel rather than even
    failing the guest.
  - Everything that converts guest cycles to nanoseconds, e.g. the lapic
    timer advance logic, divides by virtual_tsc_khz, which is zero as well.

Each of those has been growing its own "is the frequency zero?" check, and
the list keeps getting longer.  Cut it off at the source instead: fail
KVM_CREATE_VCPU rather than letting userspace walk into a host #DE or a
spinning vCPU thread.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..8dd75d60eecf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9342,6 +9342,17 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	struct page *page;
 	int r;
 
+	/*
+	 * The host TSC frequency is unknown, e.g. because TSC calibration failed
+	 * at boot.  KVM cannot virtualize the TSC in this state, and every
+	 * consumer of the frequency ends up needing its own zero check; fail vCPU
+	 * creation instead of handing userspace a vCPU that cannot run.
+	 */
+	if (!tsc_khz) {
+		pr_err_ratelimited("cannot create vCPU, host TSC frequency is unknown\n");
+		return -EIO;
+	}
+
 	vcpu->arch.last_vmentry_cpu = -1;
 	bitmap_fill(vcpu->arch.regs_avail, NR_VCPU_TOTAL_REGS);
 	bitmap_fill(vcpu->arch.regs_dirty, NR_VCPU_TOTAL_REGS);
-- 
2.43.7

