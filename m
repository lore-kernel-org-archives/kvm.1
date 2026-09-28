Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61084582E3
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579120; cv=none; b=S9MwCXH81uibHSO7/WZ9gj8yHdmzrAXADCmKJwaAmYVwgZLTRd863tXFMv4b9rx0va06qhGG9jVdenAJ9xOPmaFWGCU7oV+WnPCBe063IPyV8mcycNcVSNqCueToFCLGp6PqT2u1SGZDhSs7wy8Pf1WfLhY7gW5UkJZMAAGJfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579120; c=relaxed/simple;
	bh=7yWrYCjRlcBrzi4nT3qt5n1tPD6yOFXGRb4bNe5DRbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l4gchrk9OIaKPTUh7EB3YyNyevv56kvvCFeMohxz1911AehUU4rUMIkpVlZ4iKDI2u9saMoKnKPrJiYumEyKmLIwsaiKZcehdVOEi+wI5SsNtzA6DO9waWT/AFY+KODxl8r7vHiqA2WsSfF2SiDKJiZbei8JB+C3ceSBZI3nXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWVDffkW; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWVDffkW"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so1466984c88.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790579118; x=1791183918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NaWk7vWFivX+dxtJi64qprK3NUUcpha4PML/mDC6+0w=;
        b=eWVDffkWhASJ5Vi50PyZg5jfNpRN+wClp3zG3Tw5os9iQ7xXc3niN6ljy4lYSKR1bJ
         IPF6XVTenLnn5JhNxKWgmGsS3CG/Im0g/WirSyOCGzIwK/o5zKEookcVZSn2KSbsa4xI
         qELqZZN0t+uxYkgWp27xGqTbgH+PZ8Cg/VqaQ2Lhnz0c1YwEMkJ5AyZuDayqNue948vX
         4c7A3GF8yJMkVBjJZPIfRHNf8j0IdtUruOHmWGkygSWHA3wYLJgG1nCQHX6pr2NYl/lw
         AU8QUH7F0aOG61cIl42kERxthj55etK1Y/4mSxiZBS8lCw8fBs9FcrB/m26PvuTNQreF
         sirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790579118; x=1791183918;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NaWk7vWFivX+dxtJi64qprK3NUUcpha4PML/mDC6+0w=;
        b=hJs0DpGAhdzASvLBLV0T5YbjmILbidLKtSGngdfr7t3wd5jajZcIsnUm9/bM+ZJQls
         LHmNO7V1aLWo6Bt4nx01BfpopqRRC1dv67tMWtkt2iPknmcTBC30t3eO7+P3D55AZCF+
         /I0IzjkbaUutDMGNJX7fus0BMY0cOKVq14hTZ6QqhDDtJmgV5MN8WjHqHLAXl2AGoSDS
         WgOVfldve1D3WaUanmef3qdPs3WTNagW7q3A176iZ7XOLI5TjsrcBy6k7N6ndlSOtEPs
         XO+OHQnSwoGev4XkO7zeFlFpt8mDTUXlpuSL55drcgUW393rWpKUB3bi2fIm2fOB0aOd
         4gvA==
X-Gm-Message-State: AFuF++nlE7Hom3jn+/zSxHDCrdFeGrsud7uot166W7cMytfIsodIiHV4
	LogKTTjua6zs0Xo2HcKYk9ycXxDHTkALKx9Kfo60vOQbWgWypt8d/YJWkZtdQR0N
X-Gm-Gg: AYBFou3qikzDODAOgP5bwMqWi6K+iX2zg4NW6fwVhMUo8zJTWOZFi2123qnUsTyHbF9
	yA2mYDWsTE5yU8f/RotdR9Eq2/jUtUd0nhR6cgPMl2Em3c78j4vg5R5OZSuyvhKlpUttCfWEGNK
	rRROkDi/5KSKw980a4d0fW6WVV5lEfp8FDTPAmsSjrdB66vTbMRx5URnRsRW2f9pDboXlDuYwA/
	7quebL9v9vYLOZs3ka1ZixZanOzl69B/0QfPRy2pDKCF28kErrRK4EVymCZR+apCqwQP2o9mr0O
	fwojMYy7FBaMHNhMAoRPOcW8Wwb2uhRAlm1BZ0Otwz80Ty74EyvqQSukLLkzBKFPDvcqh6+eROK
	SmOk80j1lY0ZrvN3ztUfubOnILq6+TbPNwkcV2l5b/uWk6jZ4LXEKZ+3EzjiBOMyfwUayum1CgT
	gMcBhw0Uk5obiwximho8pONEzGcUeRZxwhCbamuR44WfPKwrdMw8rR5nDZYN5KQ+w51+37lv+Rl
	4M=
X-Received: by 2002:a05:7022:ea86:b0:144:c128:4c4d with SMTP id a92af1059eb24-146d077b6a9mr6920103c88.38.1790579117618;
        Mon, 28 Sep 2026 00:05:17 -0700 (PDT)
Received: from wujing.localdomain ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14a7c03ece2sm900781c88.16.2026.09.28.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:05:17 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 28 Sep 2026 15:05:10 +0800
Subject: [PATCH] KVM: x86: Clear CR3[63:32] on SMM entry from long mode
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-kvm-smm-cr3-upper-bits-v1-1-138f52dd531e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrDtgEqjGq5QuUjvRQWLDjIoQv
 HuDy7f4v4CSMCkMTQGhg5V/a4V5NDDOYZ0I+VsNtrXP1tselyOhpoSjONxzJsEPb4q+Nz6YYKN
 zHdQ4C0U+7/HrfV1/1Kn2pWgAAAA=
X-Change-ID: 20260928-kvm-smm-cr3-upper-bits-9819a1a2f337
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
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
host.

With paging disabled outside of long mode, only CR3[31:0] is
reachable: a MOV to CR3 can only write 32 bits, and the SMI handler
must load its own CR3 before enabling paging.  RSM restores the full
CR3 from the SMRAM state-save area, which was written before this point.
Clear the upper 32 bits so that the resulting SMM entry state passes
Hyper-V's VMRUN consistency checks.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 arch/x86/kvm/smm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index f623c5986119..3955fa4e9ad9 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -361,6 +361,17 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
 		if (kvm_x86_call(set_efer)(vcpu, 0))
 			goto error;
+
+	/*
+	 * CR3 is unmodified on SMM entry, but with paging disabled and outside
+	 * of long mode, bits 63:32 are unreachable and RSM restores the full
+	 * value from SMRAM.  Clear them, as a CR3 above 4GiB with EFER.LMA=0
+	 * fails VMRUN consistency checks when KVM runs nested under Hyper-V.
+	 */
+	if (kvm_read_cr3(vcpu) >> 32) {
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

