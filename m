Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368A4766B7
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824218; cv=none; b=MAIkMdr2Rc4BFw67K3W789AcH2/QacBmbU526ig7qquLKiuLFT7IMhyWuNzGskFRW2IIcAguKjUemG9P10qOjv8XmDe6LHi7iwOrw2ZJD7yXfijZ8Xc05B0q9Ysb5b0suqFEozQBZbNfCtdUItK9ivAmU5eA+Jriita1Mmzq1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824218; c=relaxed/simple;
	bh=viUWhZiQQGM7M0SERpgRNOfQ0uZayWrUGwWqoqY6V1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RX3mdA3BMnZRHCbun8Wg56ZJ3OxNw0dOJxD8ibAqruwStJLVB6eQw+6g+2Xq3FbL4X7ba3w8KmGjjYpUIjgHgpmfuQwY9HM5O8RZSXRzOlArMJjUXjPk1TETtO5rWGveI5KpY8HtaTViIzOgN/NM9tO/pp3vWiPSKyAaNqmPNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjsQNVf2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qbYdaouC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjsQNVf2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qbYdaouC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791824216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LYf73kst/fyWQSZYkXZ8I9kSX4ZicbdExkkiQPdtnsQ=;
	b=GjsQNVf2OM7qpNX/KLmgVlB7g0Hv2lWn5rTP8athSrJ3Xfd64eoe623UBlYQTudM038IkW
	BDVOIqflxvRKf2kbPS//naozUJISyEpe6i1PGiKAwlON6V3coxXiELHt5W3b4/jT+8d5/x
	G6TjOCTZ8lCJvBKa8X0TLafBvo2HFdA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-cLPJ1pbUPqWjQ_qrexaRig-1; Mon, 12 Oct 2026 16:56:55 +0000
X-MC-Unique: cLPJ1pbUPqWjQ_qrexaRig-1
X-Mimecast-MFC-AGG-ID: cLPJ1pbUPqWjQ_qrexaRig_1791824214
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c4445512dso1729954f8f.2
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791824214; x=1792429014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LYf73kst/fyWQSZYkXZ8I9kSX4ZicbdExkkiQPdtnsQ=;
        b=qbYdaouCJALKg9alU9h5dHz+v/NIwPmAgOICS5rBJWqxduwmLzEZ2MSZ4exJMgmMAG
         HnbNmvShzUGegedyvSO71frgYhr2tGdEx9FWUgsv+mDO19oWHKiN9KebCquXYmb2Wsem
         +c/AbpxcxJNLx64S2seo7OeOvVvuVk+L/9clKEhUODPJr2Um3eT6qZ2dK2fuSLGcV/ke
         pQUPxXnqFJKYSanW+gI/YW3ZhaBcSOztck62kLBqbT3i9XbXEElaw5OOEFQeo8A4g77A
         u1sUU6ymOy8UIbswqFEwp3A3wxby1cVFSyOrdOMGV9+ldu3bYYtwLcAB6Ikz7CWID2OL
         RAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824214; x=1792429014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYf73kst/fyWQSZYkXZ8I9kSX4ZicbdExkkiQPdtnsQ=;
        b=YXRkuY0Xy8qIMQBFBvm+WX6FJ/5MmXLGgMtVukTIG27+mLGukc446sfYwDzjeW1vZk
         NBZvZ0ZAq896je21FWgBsoGAqEBxdoLHQPhqde4t5owEs1N6O7dAj2aect2/2P2mIkrh
         LCc/nsGNpfxSxiGG1WupbjnHqqZveKpTCdM2Y1C7GQBhcQedhvFGuuPkVyT86m9mXg/Y
         1frJZo2VmvfKEi1PdN3NWnat5MittXr1OPnDZm4+DNZI57F1bgDC+buqlQLRYCgLC4kj
         qnEFf7abGe/Nzc6WLKU46Mwq+cTnukC3SVDa3WLq1nHQ18IhjsgumcxAVhOhiqUiCS2J
         7XvA==
X-Forwarded-Encrypted: i=1; AKwUvBycKp9eAoEwGJi1OOO50xnQAyjWMrZA74x6xGB0krCFzjP5q2cFfX63mOcXoZz2EEt4ymI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXrGaANCsRDkr92UhBDeYWbXelRWCeffbuYef0W1i5stdbR50i
	qcbqTM01DGCSqkKzwP9WXDugVb1fFg14GXrGmBCu87AdQvLLiRW5d+H/ughRqiOkQ7iONIJNub7
	kL4mFqSx0KO37OCdYzwqqO4uQhoR0HE/NGNcGtz+FBBERq7Gb1Qsz0g==
X-Gm-Gg: AYBFou33uxW2qqK2DzYBkQ4slrSaJ9kgSnrnVPj9No8eH0fjfFA8QqEkn1Y+XZ4Cjqj
	NC5yJqpdZnt8nCs9bRyKHuJeQtxaDx0sZVWdZUsr3ZpDA/CzMdFVoOYAylMCQ4j5l5uKDK++m4O
	jC0RzOsDpYt5upqzdov3n5PuGOrgqPwZdK6Ej+JRasRT3SQlTOC5uvY7SzWyDsmjNz2Agyy0eQi
	gau9yLQJKu31YQL0tMWAsSVYdZwy4o9IsZW2xdEUNTtbr+2BjP02YkYctK9wxSXRCOoqwIP+pHT
	FEyuvlzVax2S1OkRPLa5Ws78WLRDrnqYbE+v5k6VIymys+nZI08g5ERvy+xPdjzGs0L0hsOrHjV
	9pxdHUS/2Gg3laUUnvFBT5n/TLlfyCh8EIQoltRTf4OzL1mpmoHJxalJZ4IxfdF00Jn5V6664n5
	pAa85r
X-Received: by 2002:a05:6000:2601:b0:48a:f571:7b50 with SMTP id ffacd0b85a97d-48dbaae7245mr20060979f8f.27.1791824213554;
        Mon, 12 Oct 2026 09:56:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2601:b0:48a:f571:7b50 with SMTP id ffacd0b85a97d-48dbaae7245mr20060940f8f.27.1791824213108;
        Mon, 12 Oct 2026 09:56:53 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab506bsm459592f8f.27.2026.10.12.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:56:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: SimonP <simonp.git@mailbox.org>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
Date: Mon, 12 Oct 2026 18:56:51 +0200
Message-ID: <20261012165651.130826-1-pbonzini@redhat.com>
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
of the VMCB.

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

Bisection shows that this started happening with commit 687ee95c1b6d ("KVM:
nSVM: enable GMET for guests"), even though SHSTK was available to guests
since Linux 6.18.  However, this is not because bit 1 of MISC_CTL (GMET)
somehow enables reporting the SS bit; rather, it's simply that Hyper-V
never uses CET unless GMET is also present.  The WARN is reproducible
even with gmet=0, with some hacking of kvm-unit-tests's cet.c testcase
to ensure that the first access to the shadow stack triggers a page fault.

Reported-by: SimonP <simonp.git@mailbox.org>
Fixes: 8db428fd5229 ("KVM: SVM: Enable shadow stack virtualization for SVM")
Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  3 +--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..8c3fc0a15c6e 100644
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
+	 * fmt->permissions, RSVD faults are handled elsewhere.  PK and SS
+	 * are not included in EPT violation bits and are not supported by
+	 * shadow paging, but SS *is* included in the NPT exit code.
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
index 27427e7f22fa..e5450faa669e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -328,7 +328,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	int offset;
 	u64 walk_nx_mask = 0;
 	const int write_fault = access & PFERR_WRITE_MASK;
-	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
 	/*
 	 * Note! Track the error_code that's common to legacy shadow paging
@@ -486,7 +485,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MASK);
 	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 
-- 
2.55.0

