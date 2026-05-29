Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94B3AFB13
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093366; cv=none; b=gtcUw/SAy+VKBHi7/22izFr0I9avUFXLRGYTZOaCk2QuocrBTwTeImc9tDhGPNnv5P/P6ZF+E/TbKDsurFcvVMAGj4FLvm00CKpRpT06DXyrezCyZuBCC9UxkwLlLc+fKm/6C7mr+lGHDtWEUKx/demWfLXZ1VbEJgkNZ+rPktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093366; c=relaxed/simple;
	bh=HVJcLc1+iQzcxGBbY8rv4XaVVOVl53XEoJsD6aE5Kn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pzC3H0BB1FK2e7jv4r5qKZuf0kkwwjuVR4YPMCywH2SlbFWKyg/wB7HFyKxlNtQ+x/TIyx2oPKHdsOCRoWlLKH5q0g3BE2zoWwMzhiNo3XdFcTxa7jqS+k8raTKGvR/6SBQemcKOZHqa4K5k+cUyKYjjijiyrLC4SU2P3M/6yeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKzM47U+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKzM47U+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf3636d6c0so4481835ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093364; x=1780698164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PzVLZm7rmlBKzWSViLi5m09WnJImm2miEV9qMFfztnU=;
        b=iKzM47U+iSl180sQHYVr1wKo4CPWCQ/Yj/s/9adVUcQ5ahi+qYqy21LrNss7p76Kvu
         96xSOcf2xnO4j7h49+8wSC30hvCsS+ygQ0YjPE2ias3WNhGoYw9rX2ytvDa9RjcWOtI3
         juUDcfqQYcq+WFTxHAIdDNjP+5ZRmKXhlHKKUo9s1FyrdD30jKKYDcQM5F0NKG/JYVke
         lkyhu6j96M9FLX2OEUf9hVWqgIUixgNF+IIGoq/N7f1NFu15FKu7MgVYxNrq8Lfkkn3I
         +t15RHSxvPiM17DWKuofD1UuiDY/zhEOmwTdEx0ql4I7fzfz2c/C5sm1AoJoz8Tz5NMg
         s7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093364; x=1780698164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzVLZm7rmlBKzWSViLi5m09WnJImm2miEV9qMFfztnU=;
        b=OzmjKniuZMcpyPk1c0OYVfqsDQMetZPxn/R8BLExoTmBwRJufb/irZQBpKoO5KbWYf
         8x8WEaJ5EHutI4t880WaluWln6ho23cQa4uRsYCutLdDImNf7bNFB4Vt7MQtq5w9K0GJ
         13lrvkS4lBwyo1LHF0U0xBybpBx1Qc/ciUw0BFp3r7p4u3ldG5jYlk+WTP2rrLFks6TN
         bjJW9NDdbjdnAqM6RIuaKUU1HkxrP8XbSPFjxgOhDTbHYjTpFkpCcubMpUF965uPwuEZ
         7l9PVM9QWnw9Zy3JbZRdbUK7uQ3IkYmnpS04ywjN1U2ZIeP/z4yCdaI7tvmiJHNdVYzM
         RhAQ==
X-Gm-Message-State: AOJu0YzxGXtkDn2qyGAG1VKIdJ5uTaGTzJyQ2Lp3INEw+Ad7zfEM7pCx
	rA5D6j2NFU2D3jcFr7cbFdo4CMBmQ9PgcCoccG9E+VsLKrG1fNYaBre+ARTv+zDmjg89ViGq3ct
	DGT3pkw==
X-Received: from plmc1.prod.google.com ([2002:a17:903:e81:b0:2bd:859d:8959])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2bf:e5c:d90b
 with SMTP id d9443c01a7336-2bf36858d29mr19511515ad.32.1780093364326; Fri, 29
 May 2026 15:22:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:44 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-2-seanjc@google.com>
Subject: [PATCH v3 01/40] KVM: SVM: Truncate INVLPGA address in compatibility mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Check for full 64-bit mode, not just long mode, when truncating the
virtual address as part of INVLPGA emulation.  Compatibility mode doesn't
support 64-bit addressing.

Note, the FIXME still applies, e.g. if the guest deliberately targeted
EAX while in 64-bit via an address size override.  That flaw isn't worth
fixing as it would require decoding the code stream, which would open an
entirely different can of worms, and in practice no sane guest would shove
garbage into RAX[63:32] and execute INVLPGA.

Note #2, VMSAVE, VMLOAD, and VMRUN all suffer from the same architectural
flaw of not providing the full linear address in a VMCB exit information
field, because, quoting the APM verbatim:

  the linear address is available directly from the guest rAX register

(VMSAVE, VMLOAD, and VMRUN take a physical address, but their behavior
with respect to rAX is otherwise identical).

Fixes: bc9eff67fc35 ("KVM: SVM: Use default rAX size for INVLPGA emulation")
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 717af5c4d057..7d8a433b5c5e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2416,7 +2416,7 @@ static int invlpga_interception(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* FIXME: Handle an address size prefix. */
-	if (!is_long_mode(vcpu))
+	if (!is_64_bit_mode(vcpu))
 		gva = (u32)gva;
 
 	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
-- 
2.54.0.823.g6e5bcc1fc9-goog

