Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC03AC0DE
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329554; cv=none; b=RBwCxYGKIAPVQBEs9ZxgY9CA3sFVH8T+ZFtyKj98SpHuaby1RDAwbg9Nasbvsrbd0wPc79vGd0uDJ9jdJAHNKePrCv2ZfE9PwqSofVcKsI02zUv9RB76zuAUvM0DJ3ATwhFlKymLsYVXnwFbg5moKCCSItEfBT5971Na4nkVS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329554; c=relaxed/simple;
	bh=YFo3zkbVTjs0YmJ2DjKSL0yUhxfM+VLs8APaYv2776A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hRlU+bEY5kMKXciWqrw9UVSrWv8LvmwPhXr88XF07TeZwUdlSE6HC3Q5QuA5IwYoQIlqAfcIyWTtp1NFWsJP9OnmcANOP0SVj7GVVCAgRb2tjS26XzY/wnVUqKvmFHRQjsfPAYwpH9e5QNH0a465B6PPF97xUkVoN4zEN3PQZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFdm6KmQ; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFdm6KmQ"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso9199509b3a.1
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784329552; x=1784934352; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LImVjT29mh2j7uDBMLgCCOMxIGI8tmVyPAD/C/xGkiE=;
        b=nFdm6KmQcqt5FgRuSp7bOkm3K173HKVyLkhPGDCRenLY7hh597eLzmBlehp586MZoP
         egyhlfe2EDu4mZpsbv3hwF+62ti5CFvsGtDWRfiFmh94/vYs65pZFW+c8bvDeLYIEqBc
         eS8ahh2OiPKt8uvlkMXGy/vsy6tRILtF1I2BlJx+1iMLNF6ONeEqSIT4ZR+me6NSiL/D
         8KKvI4uR/LwRACxDH8bt80p6gHtPetcpFxIG6LcMyCn/yhFE4wYjGJwZ+ttKpE7haNHt
         uST86gmfLNFi1o8iXwE6eBKjqMUfK8Jx8lB43NwP5g4RbxZDj+Ih7n/X2ZABew/3XNTU
         Wv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329552; x=1784934352;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LImVjT29mh2j7uDBMLgCCOMxIGI8tmVyPAD/C/xGkiE=;
        b=iMR5gM4lY9vniQNb+uokkOvnKMYQemyHEx5685biiCK6fR0OKVbIv2eThYW/17Dn8+
         XmQttR/cgtn6G/vQgFPyGZEDD1BTWlQi+PbT4f3HU4xYotcyuN3E9zj3y2t2L/cg/V3x
         sSepOJupYVtHoiWorBIpTw417C66UkgeN4McedkfWQj/n/XjiYTOQNss7oQy94X7hhIq
         NAeQUHcg/q3s2jv3Z4hJUhL1Q+YzTL2n/lonsNDuJhTry88IHfCCh2fu8XKhb0qH6l/8
         frMcnmNaOKoV6k2qeqjQYTVDHOwO1vxb3CjWF0aH5XXHYDUO2SAGBxEAbpsjNYQvNitS
         nMzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgmQmprQIHDnKdbBWbxbCAzVJFk/B+e5yAXuNi5VwR3fpBE81TunalYL5XDO8Tj1kMQxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yIc1tfKJZhqjVxVcgzuxnq70ebanUjbdLiZ+p6dbwN7czf8X
	L0CW3Uwd3mnYL5NPNSl29ZuptsMi7q3Iu7YAnQNm00CFYfTKyDLPv0kWsrggjgUw9S+gBHRGz+F
	scObflmAozte69w==
X-Received: from pgmk20.prod.google.com ([2002:a63:5a54:0:b0:c8b:19f4:6228])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e13:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84c294d4123mr4971069b3a.37.1784329551821;
 Fri, 17 Jul 2026 16:05:51 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:05:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717230542.3555587-1-jmattson@google.com>
Subject: [PATCH v2 0/3] KVM: x86/SVM: Fixes for AMD ERAPS virtualization
From: Jim Mattson <jmattson@google.com>
To: jmattson@google.com
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fixes three issues in KVM's virtualization of Enhanced Return
Address Predictor Security (ERAPS):

Patch 1 adds ALLOW_LARGER_RAP configuration to svm_vcpu_after_set_cpuid()
so that the BSP will be properly configured. The ALLOW_LARGER_RAP
configuration in init_vmcb() is retained to restore the bit after the VMCB
is cleared on the VCPU triple fault path.

Patch 2 moves ERAPS dirty tracking into svm_flush_tlb_asid(). AMD ERAPS
architecturally requires clearing the Return Address Predictor (RAP/RSB) on
all implicit TLB invalidations. Centralizing dirty tracking in
svm_flush_tlb_asid() ensures that local/current ASID flushes
(e.g. same-value CR3 reloads under shadow paging, CR4.PAE/SMEP toggles,
single-context INVPCID) correctly mark ERAPS dirty and clear the RAP on the
next VMRUN.

Patch 3 adds a KVM_REQ_TLB_FLUSH_GUEST request to kvm_mtrr_set_msr() when
MTRR MSRs are written via WRMSR. Per AMD APM and Intel SDM, MTRR writes are
implicit TLB invalidations. Requesting a guest TLB flush restores x86
architectural compliance and ensures ERAPS RAP clearing on MTRR writes.

v1 -> v2:

* Restored the ALLOW_LARGER_RAP configuration in init_vmcb() [Sashiko]

v1: https://lore.kernel.org/kvm/20260716232524.2092085-1-jmattson@google.com/

Jim Mattson (3):
  KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
  KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
  KVM: x86: Flush guest TLB on MTRR MSR writes

 arch/x86/kvm/mtrr.c    |  1 +
 arch/x86/kvm/svm/svm.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.55.0.229.g6434b31f56-goog

