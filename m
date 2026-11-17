Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941971;
	b=MwQOXft332VFLTrp39lrX/NaVysrTYypR4GlpbnJ0E5d8A6FyoKYZgEUieM85eif2yWY
	 SkjDeoyI/59pELj9PchDmsxLcKL1F7vOlZx+mrGUkQWMh0+E7myqGJzTE9VkElnHwbLtr
	 kQkrO3U95OtE2H6JZcF2ytB4ObxomLOixP86tallbwPIwmpC2QMJO2/elspc6LYiZAAro
	 fHXKTF/GVq4BV8dsiXp8ajhP6ckuepL+gUfxz3kCsDzhMRYJNhTyd5GdRb/1RPgUck2OJ
	 ROba7uOuOwR2EWCXwf6AtY4ercaDOYqF1J2GAfg/mL9cLV4woIuTYsdpEEGUR6LrV1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941971;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=kUIRrOyVQBuEg1TQbMeXEdWhbbHNohGKlJQkYvjkyFc=;
	b=ZKTJXfzeeWUufjyRpvfUZr0ipjSfVjRYAp7A1TKymBTu0yTsti/u9HyvP73Mxcj5S0uE
	 n4hJBPQ+BSdZLpByvSmp3xG3b+Iyk79+RJ+Ywh/a3fM5uEtQ0glSEjPj13zvxYB0Wyqwz
	 gdCio/uQrv72SatiJbU4BNKUzXdMOGTA12pamxXyGt9DMqLT2gBLr3gHKuCEr0PaFW+tz
	 ne2OMxGghodol0sNXDARHpW/uDXwX9RftztDiDHlMLLYnQd5rlwVeHDedUyFuzSoX6Wd5
	 5CQXNIEzMk6XL15d//+/C7j/qFwfDX3GGrKlhmqR5yKTaxNkbhk5uAUkA0LUkYf42AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAHfJboI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAF606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 18:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8AAF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAHfJboI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794941969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kUIRrOyVQBuEg1TQbMeXEdWhbbHNohGKlJQkYvjkyFc=;
	b=OAHfJboIVlFiq3/dn3iWSllzTAH6QfpiRxprg8AyW0fDwf4BQTR6OTsyg30Haw12Ag75+B
	xCs+9TQcxMOTS/G6+vb00SENQd1b3RPVlhNcYUBLnuZIEyxXfZk6AFNF5nEk3Xt0QuWMIJ
	43dPPBj+giGi4pG8QyKMR3XrBemvBBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ZxyyJxPwOGm3PRZUR8-wzw-1; Tue,
 17 Nov 2026 13:59:26 -0500
X-MC-Unique: ZxyyJxPwOGm3PRZUR8-wzw-1
X-Mimecast-MFC-AGG-ID: ZxyyJxPwOGm3PRZUR8-wzw_1794941965
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E05C195604C;
	Tue, 17 Nov 2026 18:59:25 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6DA6589;
	Tue, 17 Nov 2026 18:59:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] KVM: SEV: never retry after #NPF on paging structures
Date: Tue, 17 Nov 2026 19:59:22 +0100
Message-ID: <20261117185922.466255-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

KVM cannot walk the encrypted page tables of SEV guests, so there is
no point in emulating the instruction if the #NPF fault was caused by
either data or code.  In the latter case the instruction buffer is going
to be empty, so emulation was avoided by resuming the guest, but in the
data case KVM attempted emulation which is pointless.

Apply the existing check for PFERR_GUEST_PAGE_MASK even if the instruction
buffer was filled.

Reported-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index af0deb198a84..4f42da3642b6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5513,19 +5513,29 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	}
 
 	/*
-	 * Emulate for SEV guests if the insn buffer is not empty.  The buffer
-	 * will be empty if the DecodeAssist microcode cannot fetch bytes for
-	 * the faulting instruction because the code fetch itself faulted, e.g.
-	 * the guest attempted to fetch from emulated MMIO or a guest page
-	 * table used to translate CS:RIP resides in emulated MMIO.
+	 * Under SEV, page tables are encrypted and cannot be read by the
+	 * hypervisor, so there is no way to resolve a fault on page tables.
 	 */
+	error_code = svm->vmcb->control.exit_info_1;
+	if (error_code & PFERR_GUEST_PAGE_MASK)
+		goto resume_guest;
+
 	if (likely(insn_len))
 		return X86EMUL_CONTINUE;
 
 	/*
-	 * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
+	 * The insn buffer was empty; the DecodeAssist microcode could not fetch
+	 * bytes for the faulting instruction because the code fetch itself faulted,
+	 * e.g. the guest attempted to fetch from emulated MMIO or a guest page
+	 * table used to translate CS:RIP resides in emulated MMIO.
 	 *
-	 * Errata:
+	 * A data fault instead could be Errata 1096 Fam_17h_00_0Fh, so only
+	 * retry for a fetch fault and otherwise try to workaround it.
+	 */
+	if (error_code & PFERR_FETCH_MASK)
+		goto resume_guest;
+
+	/*
 	 * When CPU raises #NPF on guest data access and vCPU CR4.SMAP=1, it is
 	 * possible that CPU microcode implementing DecodeAssist will fail to
 	 * read guest memory at CS:RIP and vmcb.GuestIntrBytes will incorrectly
@@ -5552,12 +5562,8 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 *       retrieve the instruction bytes is legitimate (see abvoe).
 	 *
 	 * In addition, don't apply the erratum workaround if the #NPF occurred
-	 * while translating guest page tables (see below).
+	 * while translating guest page tables (see above).
 	 */
-	error_code = svm->vmcb->control.exit_info_1;
-	if (error_code & (PFERR_GUEST_PAGE_MASK | PFERR_FETCH_MASK))
-		goto resume_guest;
-
 	smep = kvm_is_cr4_bit_set(vcpu, X86_CR4_SMEP);
 	smap = kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP);
 	is_user = svm_get_cpl(vcpu) == 3;
-- 
2.56.0

