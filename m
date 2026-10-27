Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141362;
	b=OjCoBT3DK8rzHM22+0XaIcu4d4YDMR57wrCJQytK2SiCp2Pl33L2z1G3VRSvMkmOqURT
	 tCsKbQJ8SijxxPr3lDOxLWD5qCBk1ZWGax2E9LtlsrQ4vDpElrsoL3a3e/v9uRt/SKn1D
	 wynUCNf8/lEB8oHLPIVkcLiY7E9YiHjAOycvMe0FDxdUdPOQAKb9fh/t1aEc/5A6RYehY
	 x4g0+5eRgiLj55aNdINJMWn0xZvts0JcPU8xukOOUrl1fl6a8ai6Uspx76uN3wGK+A6uo
	 fHhIAeFERLGrobVafclq4u2ear72hXUgj5kbATSwTzPfJATvv8iHfd2RU9rJdT3aGPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QtXNxPuc5kmlWJMCDMXsX9xtsHAgPfmmQaHcRlB5NfI=;
	b=gU0GIRHZwRlq0/1fnbAWlEEIkJcibKTflula6XdSslkrXKq5IFNF0VoQixfN68/VdKVv
	 VjFHtQ24V05KjIlmwYPPY2xzMzaLyfdXZYr6xvSgjbbMmiwyxH8aHir+E2S4WA3/vbqa9
	 Uk6+d/+Bspvg8Dmoe/mu9ilrxV7g8M4mpl0VLptCSHSVwP7q78V0SIsIVd2X78MneZJ+O
	 fmQfA9TSTdPvZ/Afxhl4i5reFQPxg1urCd/mG7el6JnnarhvNcIfawDbk32kvYcabv37t
	 1/C/ND7K7JIdTdhPNHfuM8cql/Ma98xBD6egFcTc+4dFjyrFTSwvMtbwqcryCrYKtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kpdVP+Lv;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997ED606A325
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 997ED606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kpdVP+Lv
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso497910a91.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141361; x=1793746161; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QtXNxPuc5kmlWJMCDMXsX9xtsHAgPfmmQaHcRlB5NfI=;
        b=kpdVP+Lvma2A72eGXjAbp6w3wnwfGcLHGXF1lsQmRXvVsjgKb6418Knm/dEx8P6dPv
         qjUvXSNDlhS1uT43yao4m7wsNNvIRGFrG0MJKDWCNIPrEOtcsq5PRlSgjnXl7VRmk+zP
         2N89Mqgd2x+Ptv3b1KmSKKndOSo1dA9JxOeGuWEJrIpodS4TydlwNuL3vzGPOsXprWqn
         wm7OFVnoMfVj41yZgd7GCjxaA6OylHJGzWFFFEpWDBYGmLkryMmCa+jAVwPoq7/Tr4xX
         n7vd7MLLNSGRj1d5jQUgDG8NtBHu4uE9PwKwwmvt2h/ZQkPDUHi3yjcI8+gwQe/E7Nm8
         RRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141361; x=1793746161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtXNxPuc5kmlWJMCDMXsX9xtsHAgPfmmQaHcRlB5NfI=;
        b=OqI/eRiNEVvdrL20VFiXFRGZTQjMTvQH/QcTFn5AXWczkOlS5D0x0ZB0whLOw98MC3
         dAs1CjEU1BJAdlx7dzAdKMGNpxNICJ/Ih/4ZRyMGo90nybtX0wAxc9iVRGDWNbftmOWD
         JFdtB29bN3A+YNxTdN5wyGTZ+2LVqXEuUZeDYNKpQN336xViSMRqGVJPPcQIn4XQXN7f
         AVlUXdNIVmOPyUc+DIfxNQ8+4iPOMXDPmsrtq9mUyk739J/2AanyaPoKZeRvVT+NtFC7
         Oc1mAU3LS03Ua8YBArcCVsurlZHg4elyIeOvEWIhyI2WLOcIrdb++lr8tlte0govk6Fe
         pQkg==
X-Gm-Message-State: AFq9FYLIRKCFZp/Wzd3Rq4qbcY7rmR1Xe4MOaChj0gHY8aNQB6cwmOuu
	kbLhsqUTMd4k04d7tOD3tkE2U/k2/7YB9W8cgEekoyC+lUq+8cy0tvVpE68ZuTDNlivGejvAkXD
	vetDs7A==
X-Received: from pjbbw9.prod.google.com ([2002:a17:90a:f609:b0:3ab:d09d:a37a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec8:b0:3ae:2969:9031
 with SMTP id 98e67ed59e1d1-3ae581432f6mr406676a91.54.1793141360760; Tue, 27
 Oct 2026 15:49:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:09 -0700
In-Reply-To: <20261027224914.1574319-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027224914.1574319-2-seanjc@google.com>
Subject: [PATCH v2 1/6] Revert "KVM: x86: Skip EFER vs. guest CPUID checks for
 host-initiated writes"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Revert the misguided-in-hindsight decision to allow userspace to violate
architectural consistency when setting EFER as it has since been solidified
that userspace is required to configure guest CPUID prior to setting MSRs,
and skipping the CR0.PG vs. EFER.LME check in allows userspace to load an
end state of EFER.LMA=1 && EFER.LME=0, which is supposed to be impossible
and trips a variety of KVM_BUG_ON()s in the MMU.

This reverts commit 11988499e62b310f3bf6f6d0a807a06d3f9ccc96.

Fixes: 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..2df42276fd82 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -580,8 +580,11 @@ static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 				 kvm_get_feature_msr);
 }
 
-static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
+bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
+	if (efer & ~kvm_caps.supported_efer_bits)
+		return false;
+
 	if (efer & EFER_AUTOIBRS && !guest_cpu_cap_has(vcpu, X86_FEATURE_AUTOIBRS))
 		return false;
 
@@ -610,33 +613,18 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 
 	return true;
 }
-
-bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
-{
-	if (efer & ~kvm_caps.supported_efer_bits)
-		return false;
-
-	return __kvm_valid_efer(vcpu, efer);
-}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_valid_efer);
 
-static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	u64 old_efer = vcpu->arch.efer;
-	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & ~kvm_caps.supported_efer_bits)
+	if (!kvm_valid_efer(vcpu, efer))
 		return 1;
 
-	if (!msr_info->host_initiated) {
-		if (!__kvm_valid_efer(vcpu, efer))
-			return 1;
-
-		if (is_paging(vcpu) &&
-		    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
-			return 1;
-	}
+	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
+		return 1;
 
 	efer &= ~EFER_LMA;
 	efer |= vcpu->arch.efer & EFER_LMA;
@@ -1547,7 +1535,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		break;
 	case MSR_EFER:
-		return set_efer(vcpu, msr_info);
+		return set_efer(vcpu, msr_info->data);
 	case MSR_K7_HWCR: {
 		/*
 		 * Allow McStatusWrEn and TscFreqSel. (Linux guests from v3.2
-- 
2.56.0.307.g5fe7bd680c-goog

