Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7914AD20
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309019; cv=none; b=o9+qLYrXP2EYkL+sHnyTf3LHd/qnCVq+3M9TLhPt3ION9VhCm95h6lZuv6VWuDx9S68oFf2pUTAHLh9eNcw1dFcJWAeKWusahx3E60etocDKR+0NGSIgh6IefxKCUIGX7GvY6dJpLbjb4D3hWGVpqilRKTzvmpH8gqt1fwdHvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309019; c=relaxed/simple;
	bh=In4NOF3Xo+nlLOJhRSnIFnzlBGSkoLA5xCcKpS39ens=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WDCtYabl0hgvdR/4b7hbmbAhGCxy407zJHpCZMjQ2cL2GFrFfZ489ZrLDvkCMRV1ntfC6GSf/+FSr3ui55GTgL2FgL24B09EfsU6rr34dzogBK2FGd1zZHE2e1l3KAX4bqEdK1S+v1dxpe9v08YRP6CNJo8+09RTvCVBbH9S0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwWX2+Rk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwWX2+Rk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a366b61fso827946a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309016; x=1781913816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Am1D4FKXByCRIicUxneaTvJ4m6zq+vw7dK+UxCmM7+Q=;
        b=kwWX2+RkDtQ76eR7hRbvMIZ/tundux64injlvMaY2UKd2AzbN3dyUpssusR/3/dx/z
         bDhQpPGzbmoNtwvT8n0COlb6ytegxFze7sVvSeqSVcS6xVQwZf4xy8MHuCyfH1WGpnkA
         JKV2UV2TGaEULmRW38nAW4QF+XGe2uY+Iyk9wUXxXvVes+a8o8KSKLoEfyJuQ7BYFvVo
         jZQYe7kiKUC3ogOPgEy37w09mq7WOimvzJsn3v+gIlU1ciqVZPcSew5IlA3+qGVsC4wO
         s2sCgaEpQsFhWA9yAUCP8UNRenGHNjBbAEUBEP+3raRvqwWTfpYMLcTK2GCvPTgV7WKJ
         k5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309016; x=1781913816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Am1D4FKXByCRIicUxneaTvJ4m6zq+vw7dK+UxCmM7+Q=;
        b=AHDSU512k53S6P82zb90h33legmqFzhea8th47W9nkcEFjaVsRF78riqZD5cXLsPNO
         xDSbO2ai/i3nAX0n0cMjlEkouwQ6roBxbnSFQKCfzDQGHPbA0TbWmDOkNOJkV4Kpgqf+
         tGG3WfT7n6na9Q6TcFaMPJ7nk6ysG0Zl9U+43+ShWhppero9YfIijjb0phrpnbFbouec
         PN2Kq5CTVbXOIzNfRBp2SwySrYJk/tlS7yRh2VHOBU3FLtodkLyXsUrI7n3xb6IR3+Ky
         2bs/S5gHESgukF8ZmBTIYoGL7/jsdyPDBsfZlK1RrDqAuu/GEpB0rbr44YzF6xq1km+/
         /s8g==
X-Gm-Message-State: AOJu0Yx0OK3559e089eab5E7BRkoGnKkRK6dAbKIx57oRQ4vH6AjyaMf
	cVwQBl+h67YT+9VxlOqyY9EutUZhddgCcshCjClfiaPk2HjSpX5B3aPc21vL5b1AhWb2E/fQEMf
	916SAHA==
X-Received: from pfms21.prod.google.com ([2002:aa7:8295:0:b0:842:39c0:1203])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:3b4:6c68:b11a
 with SMTP id adf61e73a8af0-3b783fb48bbmr6178517637.36.1781309015885; Fri, 12
 Jun 2026 17:03:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:02 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-4-seanjc@google.com>
Subject: [PATCH v4 03/30] KVM: x86: Rename __{g,s}et_sregs2() => kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename the KVM_{G,S}ET_SREGS2 helpers in anticipation of moving them out of
x86.c (while leaving the ioctl dispatch behind).  Having globally visible
APIs named __{g,s}et_sregs2() would be "fine", but ugly, given that
__{g,s}et_sregs() will NOT be globally visible.  As a bonus, this makes it
a bit more obvious that the helpers implement newer versions of
kvm_arch_vcpu_ioctl_set_sregs().

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f48cd630c32..0fa8a9e3b8b2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -133,8 +133,10 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
 
-static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
+static int kvm_x86_vcpu_ioctl_set_sregs2(struct kvm_vcpu *vcpu,
+					 struct kvm_sregs2 *sregs2);
+static void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
@@ -6623,7 +6625,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!u.sregs2)
 			goto out;
-		__get_sregs2(vcpu, u.sregs2);
+		kvm_x86_vcpu_ioctl_get_sregs2(vcpu, u.sregs2);
 		r = -EFAULT;
 		if (copy_to_user(argp, u.sregs2, sizeof(struct kvm_sregs2)))
 			goto out;
@@ -6642,7 +6644,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			u.sregs2 = NULL;
 			goto out;
 		}
-		r = __set_sregs2(vcpu, u.sregs2);
+		r = kvm_x86_vcpu_ioctl_set_sregs2(vcpu, u.sregs2);
 		break;
 	}
 	case KVM_HAS_DEVICE_ATTR:
@@ -12210,7 +12212,8 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			(unsigned long *)sregs->interrupt_bitmap);
 }
 
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
+static void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2)
 {
 	int i;
 
@@ -12480,7 +12483,8 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return 0;
 }
 
-static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
+static int kvm_x86_vcpu_ioctl_set_sregs2(struct kvm_vcpu *vcpu,
+					 struct kvm_sregs2 *sregs2)
 {
 	int mmu_reset_needed = 0;
 	bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
-- 
2.54.0.1136.gdb2ca164c4-goog

