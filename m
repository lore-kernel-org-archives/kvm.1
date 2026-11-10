Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271243;
	b=iC0N0OseAex3J+tNqln6b1XT3B8bBSphN8OsdNvuLDpwt0FcsiZoNmWqC/ErGlqk9Yyu
	 ZAgP0YJKUdz9eisPfQ9AKJO77pZvbSAr448f2ZCufBEJhy0P7TdczAKLNN7uw1Or2mrtK
	 lMGIx5NJiIEDuYfYATqPtq+OWdA8ZJ9ZT/A1tUN2+tou/CAZiiclBaqT+gBkdTCBuxS3X
	 h/wYjztkrXqVMvLJcBmOxjRQBF6NM8DRot/h8pc2Oyoj5NDmarmp6iynKAWdhOrc10oyD
	 HLuSe6/O5x5qk+A0M8diPEFy6HuWVqReSz23tBvrX8Q7noFd/m+52axKP76vW+wQe7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=g/b9kIVqE8FBGxMZo7/8K2qykpzXHnDK16SJKlo2ikg=;
	b=kxlI/Xups0qFiLbXQYO43Dn8ayt+549OzDICYrQCtmJtJ2m2B/6Yw5U8u/bZvlPKsUzC
	 vos8h8EACQeJXOLY+C7z9J7+L35HOFwhONwt2I7go3F0JBqo+6Vbm2KKZw3wHJHeAlT+n
	 WYId/A8y/z3BSHas4NIchs8SoYTIlD6moqYE5dR9x51maSugk816nDXtUM0eXAft1ARNc
	 1sKoPKl+VSilbXQ+Khcg5tgEnx59aOdclPl/w45vQAeeTrFnMnwNJw8xKzIlQGMxPyrGZ
	 JWSnBqXebOh9I4fG2qRtunrX8YkESvmYAo1r/ApuROElKwhVNjUleG3mpGj07dnly7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7l9QrEE;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60742606A325
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 00:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60742606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g7l9QrEE
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4519ef1babeso914142fac.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 16:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794271242; x=1794876042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/b9kIVqE8FBGxMZo7/8K2qykpzXHnDK16SJKlo2ikg=;
        b=g7l9QrEEEOXA/X3sgL7HtamjAHPgBfmncdUqwXN7KozQyY75iPoixThv5uD4v6/3OX
         UQRMbv9IkXHMPHDcBY2B08w9nJ/mcyfEiXR1fHCbtbcyu8E170bungSsMCT7/nIYxweX
         PTHSvZv2BKmGVX96m76rkzeRtjks4y7V3JTE+mlZCLUpeMd3qpsUhQusIgjd50tjmkFp
         w1GAxkdzDXhz8SmhZksNm8GMM9XlfM1rWZdbu5IvaVXzKLuCllAgorv9uwEWKLll/SjP
         o07vPPm54tQsN5pKUcWlyvVIf/QoKjlxP5q8wYJlCFxluMBJNSdLnON8ez6Z8G8TXDy6
         aahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271242; x=1794876042;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/b9kIVqE8FBGxMZo7/8K2qykpzXHnDK16SJKlo2ikg=;
        b=1se/prexkH/FaAnSOOvMO1P2EaygO45dXNkUsss5aHgwL/LpuX+qUds6Ezq6HCSZ4G
         KgOYN3nJtoaOPxpBv3t5trEBZ88NDAofyFv3kJ7L0sa7Ni8ve0n/KipdBOXie/TS33dF
         L9wNl9ty+GWowHNai4RmGs88TiUl5RXTFpaDi+RG0sBJJ9IKV4RnVTAfQ94QzsQEelmR
         q3fHwEvUdaxYKH6g6tZiohogrgZRxDqE9wFTuiXOoEpcohv8dNCppEcQtQgI4FYiaW+J
         IOk2/uoTMT6HNWqFqiaOhcOyqHSC1CChAju6PmgZq0EpT2aZDWaM46r76llO3sZlQrOl
         uyLw==
X-Forwarded-Encrypted: i=1; AL+hErGgQ2tm3q6UA/N6w9biUhkih/KGdYFheXok8a8M4oeyjuyfSYZMokIC1V9zG5eUWkFV4do=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YDbyJQtIvpRetIx4+bnfcNmwMbX398hZYHHVZ2u0QpIRuxjo0
	rJszr3bkD9N4hsHClr8tKD3WRCMRP9YVLd8Y4RYuI92wY72oT1R7OZ11x9E3ktuq5hwCGxKMGQS
	57URa3qqOOf3D/g==
X-Received: from iogk24-n2.prod.google.com ([2002:a05:6602:c498:20b0:9c7:b2b5:20af])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:250d:b0:567:cbf5:bb96 with SMTP id 5614622812f47-5683cac433dmr906887b6e.44.1794271241975;
 Mon, 09 Nov 2026 16:40:41 -0800 (PST)
Date: Mon,  9 Nov 2026 16:40:37 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110004037.125692-1-jmattson@google.com>
Subject: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: John Allen <john.allen@amd.com>, Chao Gao <chao.gao@intel.com>, 
	Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per the APM, "Canonicalization and Consistency Checks,"

  [t]he following conditions are considered illegal state combinations:

   - CR4.CET=1 when CR0.WP=0
   - Any reserved bit set in S_CET
   - CR4.CET=1 and U_CET.SS=1 when EFLAGS.VM=1

Check these conditions in software before trying to VMRUN vmcb02, so that
the illegal states result in a #VMEXIT to L1 rather than an exit to
userspace with KVM_EXIT_FAIL_ENTRY.

Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/from vmcb12/vmcb02")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..20ede403b62d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
 		return false;
 
+	if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
+		return false;
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+	    CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
+		return false;
+
+	if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) {
+		u64 u_cet = 0;
+
+		if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet) &&
+		    CC(u_cet & CET_SHSTK_EN))
+			return false;
+	}
+
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
-- 
2.56.0.506.g506a7eabc5-goog

