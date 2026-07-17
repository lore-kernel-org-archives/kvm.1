Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACB3E4C8D
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329556; cv=none; b=dGR1sh/UqPMxh777PISu5GCIab1P1/CKTl5BJEP43xWPIiQ4RWyMjnZrjK5LH0tpIf0DVlOmKujG3zZOkdUQLy4gMrZgYN6Y9xGa4f27G+ahAjjf4QFfyPstDUCL17kIAE+wZJcFLLDg0SLok1Y4VUYLJM7urJYoAIR/qcxv08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329556; c=relaxed/simple;
	bh=8DP1Nv5mrntUisaMj/2XiJxUBQCjHH/vmDN6cjhcl/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=megX5zDu0MAVx4Nk4rMf4ofsKBMvjfFoXFbE3aV48xPZQe10qYEw/ja7E5BPe8qIKxpNgkDfaKsaHYdwuzilIbSGVMsY0QfNFTTKPZuWtzan2TSJbHLVgKeooeevECmUOGSwOlC7tTXb7LEPGpNDKiWMR81LBsaVVFVzU/LlDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qC0tIzXw; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qC0tIzXw"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cae455cf6dso115369075ad.2
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784329554; x=1784934354; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=caaPdFlBKo2jqor4RiYmx0NOfk13xGgUe7w7Kj5cTuI=;
        b=qC0tIzXwVol8v7EBfcgkeCUUooXrKa/YcJQWsWfoN1dDNeeW7zx/sYow1Hb/4b6TQY
         jfor8XuDfV3lktIrfDqHTgsIAY5MitijuXy8MIsDIHsyTjD8FgOxwboIkOkp+H8GPuYh
         HHyGdPcL6Ju3VH/Cd/8RQ7ew5T6J+1mLE3dn0ahTu8Jf4Se8iuKNevMmcoYTziNPS4CB
         BtxMzlnJNaERiS0ZkxNH9jwhBb2aSe2kFVffwB+p5ZHqBNA2chWOrJZpqOnqUCd1Jbe2
         uCMQH5eg2OCWdHmk55GP7flfz9ZCm/3gav6X0LMu71TSUL4tbdRmqnwL8SfOraEBMZ5W
         U10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329554; x=1784934354;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=caaPdFlBKo2jqor4RiYmx0NOfk13xGgUe7w7Kj5cTuI=;
        b=itNv4NIzyTrRhXJYfBfdp+EEOu8kRjlVIwdODroQ+0ETAmYu6WhmmVGDobf5tIyvcB
         eNWBpm1hZCOUuigQqdtwNy5BgxvWuxNNV2TvztsuHj4GMWsfTFNgYi7WX2sJJ9heXh/W
         eer9niUFTlQ/nelVpHuYmRuZwA9eh0cYWBbKTjROTrHv3xXwreZI18e+1IEPwB6X8Xat
         6gPu8RbdnheqTeu6Zz20l68Hw8aGn4ZNiGhTunMQhSpte9KQPA1szJuEz/nX3xpEwBXq
         E6c0TDci0CAX2tVmsxMPl8/Q7/PDws+xxiIBcTA/WPe2IArcRvjVUnfrY9XW0gpucrdl
         Oydg==
X-Forwarded-Encrypted: i=1; AHgh+RpGR1uDE9DCXzW/W4PyKVzBn+s7JQj3q15K7MUmj8E90r68HmOkZHw7Qa7huyEYojh/53U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27VAvL45q/PiDT4tSM/cmPGAfUt2YwtgkewLB3oFJ5/PJysCP
	dEWVVaUjxJQmkK3GdDt1Iwrj2764kWpeuP4AF/wXVGE9hwWBfDoSStTJwCo+z9y3UBiJGpma4ru
	SxI4p+mXSzf60vg==
X-Received: from pgx32.prod.google.com ([2002:a63:1760:0:b0:ca7:7de:194])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7493:b0:3c0:9c19:65b4 with SMTP id adf61e73a8af0-3c3ada7a5b1mr5830824637.76.1784329553794;
 Fri, 17 Jul 2026 16:05:53 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:05:41 -0700
In-Reply-To: <20260717230542.3555587-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717230542.3555587-3-jmattson@google.com>
Subject: [PATCH v2 2/3] KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
From: Jim Mattson <jmattson@google.com>
To: jmattson@google.com
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"

Per the AMD APM, ERAPS clears the Return Address Predictor (RAP/RSB) on all
implicit TLB invalidations (e.g. modifying certain CR[04] bits).

Move kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS) into
svm_flush_tlb_asid() so that any ASID-level TLB flush marks ERAPS dirty.
Centralizing the ERAPS dirty call in svm_flush_tlb_asid() ensures that all
ASID flushes (flush_tlb_current, flush_tlb_all, flush_tlb_guest) properly
set ERAP_CONTROL_CLEAR_RAP on the next VMRUN.

Remove the now redundant svm_flush_tlb_guest() wrapper.

Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bf868da14cd2..f2fdca341dac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4171,6 +4171,8 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
+
 	/*
 	 * Unlike VMX, SVM doesn't provide a way to flush only NPT TLB entries.
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
@@ -4229,13 +4231,6 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 	invlpga(gva, svm->vmcb->control.asid);
 }
 
-static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
-{
-	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
-
-	svm_flush_tlb_asid(vcpu);
-}
-
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5383,7 +5378,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.flush_tlb_all = svm_flush_tlb_all,
 	.flush_tlb_current = svm_flush_tlb_current,
 	.flush_tlb_gva = svm_flush_tlb_gva,
-	.flush_tlb_guest = svm_flush_tlb_guest,
+	.flush_tlb_guest = svm_flush_tlb_asid,
 
 	.vcpu_pre_run = svm_vcpu_pre_run,
 	.vcpu_run = svm_vcpu_run,
-- 
2.55.0.229.g6434b31f56-goog

