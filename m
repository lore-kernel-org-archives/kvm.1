Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39C2236FA
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645638; cv=none; b=UD+qQwalJIRmdY2ivBmxKE8vvfOSzSlp1c0QP9zzQKZ5uUDI/2OXyWf6vpTXaDsSl5qphXE1kgrfkvCl1jIW3J4vRikwbwOSac9F2Ocht4ZYQzV8gDGzFe2KBz+tyY2KzhqpSkvLZWd/o/kvFKATggKdXNFlXYyuWWqLGZtaWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645638; c=relaxed/simple;
	bh=kxGNE40utXqOB/ZP/mcvhOu56gwEzydqUUJpeOle4aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Shq0OPVeRSayhXxrxwNXvoM5Glmq4xq52LDvqUOHCBrASGRreFhtMS1wBPayu9TdPaDWCGSK0aajBbkHUQM3oC6HqJQuoi0FWXjnbEGnzDcRTNSv7jODw0PLAXnqZiqv/6BPAycReomTETt7E7BbX0qCCydFsUEeIMuxTt89uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxEiB5GV; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxEiB5GV"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so3188905c88.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790645636; x=1791250436; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzdBs4uL28XU4a9dZRzwsUcYZMoE3Q6Rk7PhwLzbkoU=;
        b=KxEiB5GVti091qrkdEoltwpfex+tcD525Bi6QhejHUvimokPQA02dirb2B6Zh6qpyL
         HM09k3RJ7RFLdlcQa5u6hpVKSeVsgCmKMIWRQtmrgU4BjM/bNcbNblqhixZeYieMh4la
         zORV/BuPtUCzQ1LDehxwHnrSY/b8D+0y3+mS6haUrF5X2w8GMo4MUGm35hLJYNSSWYDl
         0Q3nEuXIz2TuYa20FvifP2Hw6FZ4qkqYw//5K3jVdDSFK0OFX0bI2cudKcnmQef6y5Nf
         2mOYHo0MOP4ODUrPAWiIi8J6/c60fXQtl+Jo2J2tBN4rXimKnLUcYf/hvEihX2+Gr1kX
         i9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790645636; x=1791250436;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZzdBs4uL28XU4a9dZRzwsUcYZMoE3Q6Rk7PhwLzbkoU=;
        b=cuRZGLBLiTynOQ9qkMUT6wv+Ikf7/GutpeX5ETO6YzoGobD1rxsXPn17mc9yNoB6/H
         2f0TidUgFpzFeIW89jH9i7/aKpvGiG/s4pCbJQ9+nU/9wzH8u65a/xw5UMoqGEQh6KRU
         almuT152raNI6aJfsl7Sph7UZ3K3p1bs/iUtzxb/gSJ/pVJgNIGBv1DP56kY9arsjmKQ
         TqHtTuX1Hgz0x4Ga26d3O0oVGdlENuEvOWUWEtXrN9a4mNIL/dbG08su4CxjOHEHn8fv
         Xu0nqkwG4vvQ6Keo/+GPmu+h2YEUOIdPjpQM3wQxO3dDCsnXcTcpd7PQ05iiYrgp33vL
         FHAA==
X-Gm-Message-State: AFq9FYKPXfj3pJy+1e1AO1vQ1hOtN5nTXiuvMJAixG4ngNR/nk9q2/x+
	UND0vs0GD1eYH2E466BGK+yZBzM2pqntaeij1fg/Y10booAcREOWnydN
X-Gm-Gg: AYBFou2Wz/SvyN9nOP7IWP781bKLDlZ0SXmX6Ise5Ov9/GQ0YyKSFiD4bmwS5Jdr4Ix
	ApuSZzjJxF6gItsDnyYH41UFqNCvVgNmNXp8x4fRgc2Nb3mtqGHhEz+qk1OWDFurG+31kemRQM1
	G6wx3ZmK+2SIL+/ynJRkTkHB6lxByY/+rZ/x8p00C2qaQwdaSzCvquTtqnQFDB8czQQ6b2xPqWV
	9gq4GCbbsGC4Ph1mjsgwnn1rdU19plwqYXZBsKR9H8UxuAHgmZBtH6BOWNQiW3SR5j+NfOj2OHA
	40NQUsGW2bxisKlJPQ+NCvues6J6M92JQ9m6iONL9TDV4uG/k1453UEFLB4dRKHo5id07nSp/8F
	Z3aFtjYbjosQBiiKkyjK4N2BKf5cIHqG1mjdcbBYB3QzSHAv2ezv/+1vfWYXrnXesDLtOiPWFNF
	KG05ME4wVI1ppS5LQoB1LsL53iXyPTkBDGHoZkOkum/0AcXTsiJjc+Cyal0/B5thQFXbOSIhPBb
	tI=
X-Received: by 2002:a05:7300:3395:b0:33e:3f5b:3ff6 with SMTP id 5a478bee46e88-342710b5401mr10486609eec.18.1790645636296;
        Mon, 28 Sep 2026 18:33:56 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3433628f5basm23265646eec.18.2026.09.28.18.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:33:55 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 29 Sep 2026 09:33:47 +0800
Subject: [PATCH v2] KVM: x86: Clear CR3[63:32] on SMM entry when running on
 Hyper-V
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-kvm-smm-cr3-upper-bits-v2-1-622429d0cd3c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RjaBgVX3sOwqDCFiZY2LTYa0
 rtbuYD5q/eT//4GkQJThEu1QaDEkd1SQB4qGGa9TIQ8FgZZy1PdyRYfyWK0Foeg8OU9BbzzGrF
 rRaeFlkapM5SxD2T4vYtvfeGZ4+rCZ/9J4tf+VSaBJao1jRzHRgm6Tlbz8zg4C33O+QtF1ipav
 AAAAA==
X-Change-ID: 20260928-kvm-smm-cr3-upper-bits-9819a1a2f337
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 linux-hyperv@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.14.3

enter_smm() clears CR0.PG and EFER.LMA/LME but leaves CR3 as-is, so a
64-bit guest whose page tables live above 4GiB enters SMM with
CR3[63:32] != 0 while outside of long mode.  Bare-metal SVM accepts that
state, but Hyper-V's emulation of VMRUN for a nested hypervisor rejects
it as an invalid VMCB, and the vCPU dies on the very first instruction
of the SMI handler:

  KVM: entry failed, hardware error 0xffffffff
  EIP=00008000 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=1 HLT=0
  CS =f900 7bff9000 ffffffff 00809300
  CR0=00050032 CR2=2a91044a CR3=77681000 CR4=00000000
  EFER=0000000000000000

QEMU prints only CR3[31:0] here; the CR3 saved in SMRAM for this vCPU
was 0x277681000.  All vCPUs that failed had a CR3 above 4GiB, while the
one vCPU whose CR3 was below 4GiB entered SMM without issue.

This reproduces reliably when booting a Windows 11 guest (8GiB of RAM)
with Secure Boot OVMF, i.e. with SMM enabled, in KVM on WSL2 on an AMD
host, with Windows 11 25H2 build 26200.9457, the latest released build.

With paging disabled outside of long mode, only CR3[31:0] is
reachable: a MOV to CR3 can only write 32 bits, and the SMI handler
must load its own CR3 before enabling paging.  RSM restores the full
CR3 from the SMRAM state-save area, which was written before this point.
Clear the upper 32 bits when KVM runs on Hyper-V, so that the SMM entry
state passes Hyper-V's VMRUN consistency checks.  Leave the behavior on
other hosts unchanged, as the problem belongs to Hyper-V and should be
fixed there.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Only clear CR3[63:32] when KVM runs on Hyper-V, leave other hosts
  unchanged (Sean)
- Note in the changelog that the latest released Windows 11 build
  (25H2, 26200.9457) is still affected
- Cc Hyper-V maintainers and linux-hyperv

v1: https://lore.kernel.org/r/20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com
---
 arch/x86/kvm/smm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index f623c5986119..34c16b8c2c0b 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
+#include <asm/hypervisor.h>
 #include "x86.h"
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
@@ -361,6 +362,20 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
 		if (kvm_x86_call(set_efer)(vcpu, 0))
 			goto error;
+
+	/*
+	 * Work around Hyper-V rejecting VMRUN for a nested hypervisor when
+	 * CR3[63:32] != 0 with EFER.LMA=0, which is exactly the state left
+	 * behind by entering SMM with page tables above 4GiB.  CR3 is
+	 * unmodified on SMM entry, but with paging disabled and outside of
+	 * long mode bits 63:32 are unreachable, and RSM restores the full
+	 * value from SMRAM, so clearing them is invisible to the guest.
+	 */
+	if (hypervisor_is_type(X86_HYPER_MS_HYPERV) &&
+	    kvm_read_cr3(vcpu) >> 32) {
+		vcpu->arch.cr3 = (u32)vcpu->arch.cr3;
+		kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	}
 #endif
 
 	vcpu->arch.cpuid_dynamic_bits_dirty = true;

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260928-kvm-smm-cr3-upper-bits-9819a1a2f337

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

