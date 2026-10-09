Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89338E8D8
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551098; cv=none; b=b+RhvQo1jZ1nSsg/x3YgsO2g1Cpa50d90w6rGuwLg/fBmeIZWVHPCv+WkV7NurFk9ft97GM2/rP4gLYLgdEy0K4Qjl3S/UmZcDOFeWPt9QXitOPTySe1BdRhRRgpZCy0VA00Oux7PyPdwxnYmex9U4GqK9YEPkVmvtzFU4F4kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551098; c=relaxed/simple;
	bh=wu7qPu0I/hvfIuP8Kg+HVnLAD157Z9fBDyj65s9OurM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMquEw/iIVLBZzP+Vn+dA73vld3WeTXc/rtqKmXH2GwdXEpXbua8/4WzLaPd/3pQD6e+0+hsFEh7s9prqv3S61oQx4AjjNpdw7z4nbOzaC4fHkrLTwxitDt0+VKD+qadMeNlcZbe7pqCxZULD51Th1GimYRRTkXIm7jSYLLXSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPcfc9+S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BegyF0xa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPcfc9+S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BegyF0xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791551095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
	b=UPcfc9+SbzvReIoB8QAgaD7KrvOi7zTfrpwYMhz5pEDYpREW2qu6bH9gEbZN69OnvQ9NXj
	MH260T9clSgxew0ZGJWZUjeM2S838B2vcozgbEouUJ8H90RncJRxR/vdae8qNj8NrYw57H
	nlicYM7O1TLnZJOMPA4qm3Et2Rvs/Hs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Wjs5Y7RVMcevWnBDB3LO1w-1; Fri, 9 Oct 2026 13:04:54 +0000
X-MC-Unique: Wjs5Y7RVMcevWnBDB3LO1w-1
X-Mimecast-MFC-AGG-ID: Wjs5Y7RVMcevWnBDB3LO1w_1791551093
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16fefb7acso41998025e9.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791551093; x=1792155893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
        b=BegyF0xaO0mqr6bUbjy8CsAv8S57jP+KSPDm2vhw8JYYVaiAbUP8Bf6mMFDxzikAhy
         H7fH71JHuG4bFpxax++ms5vzrrF/CVkZSCLzu4FM0c4L/R2gyBAZeJHrO4b+WYFgCQG8
         5Xmjg6n4593LFiyme74ETXzT9ymp9+GBKp15CNB+2WRlHj1PDLIWAFq5D2VKtT+RcDLn
         Hz7CptwwmByWRQ+FA7BjINioCcO9fEl1H1KwmT+yOPtuum9x77MAfggEgofA0rveVflz
         1nRDZ9hcfZeCMj+x1noEYUbvoxnkt7vedR0hgTPAi7Lv2a7j58r0zVkN2MCw5zA+Pb3j
         FdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791551093; x=1792155893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
        b=ctnSnVpiAVAeGTuoLQEbfPS4HHz2Qo8xQWDyZ94n7rLHPErbP/u1MMgm4Wd6muLOE6
         +muv2lJuhQkXGQnGPvZzbpIF5c/k+ax3TsmsJIWw21Fj6/GlH+1Shay1D/jIRE1c+DC6
         rBgiWx0vC6PJUqlJu+0LrhQ6VUzzHhYMvn9h7kc1HvnQ8XDa6+h/XmVZ/TpFnL2c/KX/
         EU84bKgbwCGos73ukN2ROzA8DQ3q6kVwm6h6OAb9gVIavJP8gYM4JyMLVr30z0VI5CHu
         Ep9AFqMdufeFhxoPtBP3tvC2OtAgC+flYHcRQr0sOZx59Ie6FdNliQwZMmN0VIjVo0ve
         HI5A==
X-Forwarded-Encrypted: i=1; AKwUvBwlBcJLxiWoQ9/m9pJnQBo/iDxkoTQmTcmp8BhL/lcnPiOLerdQ/7B5kXzEJJR++39waTY=@vger.kernel.org
X-Gm-Message-State: AFuF++k2owGURAFCn/YbttjQNeOWAiTQ0EYFXFntN0+fTaoTH8OpS8TN
	GCOJd26kwRdYnBimBvvAQFFceFb5rfG+pipEvMZvCd9o7iYw3rW0BZsRFMsH2/huvrQ6CWy6CYe
	BhFMLSgztNUfHLVzEUniOkYMAerjB2g8cKg0CPPVtP7a+hdJt8kvMRA==
X-Gm-Gg: AYBFou2zPCdamrWMRe7o/i9ko94jY9DpjO68yL++8IdaRdtzf1AyOw80dizZxaaURm2
	0CZkwS9CthNlvUnfAB3ISgCQkxnX6FnS/s9tmzSSKcnK3KGt4Py4C6zMGJbodKkfEo1W/hrNVmp
	pdReB1VwYzy2MhK8bdd6yeAfdS9JQQWbyISkz7yhtH4ySpwxYc5atGfBmmAwEBxOOBMH+gBV1iB
	fIj82CAbEvlO6bJ8YohtQ4alk0CYaMsdCt4NihrNI0FaAGJSvfWPrUjmOCXffYcHfYLqe9Pq5Mx
	y2JgCf4l6PteuKqgxWJemfaJh0UuNRx/o3ppCdTii0y1tnRQqZvpxl5LLYpm/wSELm14hHxZSPC
	VWcIoRChqSuTCqpRjQG6SpQRORem2y0QIUFEMoQoYHx2VGZrCSjU9t+aJuipF7WOFQMPXOt4q+4
	MtdzqU
X-Received: by 2002:a05:600c:3b0a:b0:4a1:779c:dc8e with SMTP id 5b1f17b1804b1-4a18e4a01b7mr35867335e9.10.1791551092752;
        Fri, 09 Oct 2026 06:04:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:4a1:779c:dc8e with SMTP id 5b1f17b1804b1-4a18e4a01b7mr35866325e9.10.1791551092103;
        Fri, 09 Oct 2026 06:04:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm93839695e9.9.2026.10.09.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:04:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: SimonP <simonp.git@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
Date: Fri,  9 Oct 2026 15:04:50 +0200
Message-ID: <20261009130450.361690-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running Hyper-V from Windows 11, KVM is seeing the SS bit set
in nested page fault error codes produced for shadowed NPT.  The AMD
manual is unclear about when SS is set, including whether it can be set
when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
of the VMCB; in fact, bisection shows that while SHSTK was available
to guests since Linux 6.18, this started happening with commit
687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrelated.

Nevertheless, the unexpected SS bit causes out of bounds accesses in
permission_fault(), seen as either WARNs or UBSAN reports:

  kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
  kernel: index 34 is out of range for type 'u16 [16]'

(in this case, the page fault error code is 34*2=0x44, i.e. SS|U; the
report shows SS|U|W happening as well).  Fix the handling of unknown
error codes by dropping SS and (with a WARN) any bits not among those
that permission_fault() expects to receive.

At the same time, given the uncertainty about when hardware sets SS,
follow the processor's behavior when constructing the fault's error
code, and preserve the SS bit as passed to FNAME(walk_addr_generic).
While the behavior is surprising, there's a possibility that Hyper-V
expects it (Hyper-V does not even enable CET unless it finds MBEC/GMET!),
so retain the information when reflecting the fault to L1 instead of
unconditionally discarding it.

Note that, even though KVM always tries to run L1 with GMET enabled, it
copies the GMET-enable bit of the VMCB12 to the VMCB02 when L1 requests
usage of NPT.  Therefore, if the theory suggested by the bisection result
is correct and GMET enables setting the SS bit as well, this would not
affect hypervisors that enable NPT but not GMET.

Reported-by: SimonP <simonp.git@mailbox.org>
Fixes: 687ee95c1b6d ("KVM: nSVM: enable GMET for guests")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 40dcbcbae173..36a3a42e0b18 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -275,8 +275,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	/* strip nested paging fault error codes */
-	unsigned int pfec = access;
+	/*
+	 * Of the error codes that do not contribute to the index in
+	 * fmt->permissions, PK is not included in EPT violation bits and
+	 * not supported by shadow paging, and RSVD faults are handled
+	 * elsewhere.  SS however is included in the NPT exit code.
+	 */
+	unsigned int pfec = access & ~PFERR_SS_MASK;
+	if (WARN_ON_ONCE(pfec & ~(PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+				  PFERR_USER_MASK | PFERR_FETCH_MASK)))
+		pfec &= (PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+			 PFERR_USER_MASK | PFERR_FETCH_MASK);
+
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
 
 	/*
@@ -301,8 +311,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
 	fault = (fmt->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(fmt->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index dc0155ed1cbf..a1afe2ae28ca 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -504,7 +504,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MASK);
 	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 
-- 
2.55.0

