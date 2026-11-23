Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456523;
	b=jq6gBWhC2yg9s0u6+ILCISw12u5HjDzRA9QV32Eqr4CRBRaUDPjltqnHr3q8P5Nf00RW
	 NDzjcRMusdLvJ2OjXNjE7lT5DTd8z3MSjmu9GKumlN80lGaabLDbfxFVzu+TmtfqGSJsP
	 HNaOLST3WFzBkFR+XFJvnK1546fIhzD64a4Y+AWeLZR4pHvdB9ChRhstU1BLnrFFR3aPF
	 pgb5op/VyYATKVMy+ZoDgVx7eq1RoTJslm3nBzWBJ5gpPy3z+wrxG2ZFbGn9gkaePPBNH
	 Fqq7WizylRkQXfOfO3zTHgbJT22BSAScjDCJxaOlYUbq0KQu4fqXzMqosRKvLO+yViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456523;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=WKeK6rC5TYbPCuIOGwQmwi8vd5Hqix85xNAWF5l41qk=;
	b=3g7s9ugnN58A++GZVXQsEZsFF3n5sUFktIhat6nkrrS/fpvty0csDBdwJzUbdYotxAtS
	 w6/OPUnH0wAfY6Q0fLN5lY35+HN2u5NAl/2VYFtnds22YYULSC5ou2UIy5+7DaeIeWAIx
	 E6h0waspKL4hMTDORUfgVmkoWAhD5uoaN/JFZ3J+z+VweLQXYw/7EaUQrpFbYd6+IsEBP
	 u5czWylzRwJ2u0N9opsG+hpTutyetwSkP4unPCVeGQJvqYct9pWcy3FjsDGojJbs3ZHMD
	 rKWMnXst9F3DMeX9QCLUKpRTPShkpF83XCK2NUDXh4lGl2a+fMY0UUCc0ALxkezjtGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9ht5aJw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0B606A682
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 17:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C0B606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9ht5aJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795456522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKeK6rC5TYbPCuIOGwQmwi8vd5Hqix85xNAWF5l41qk=;
	b=W9ht5aJwCQtf/cFmwv6q/8U7FAvo3Dwp+zOOeTTgrWgGCJ8y2p/6ovDLmb3ty1nTI7mivR
	4TMj5/pyUwIgpmhNCmIFNJrDtAz/llPfQRCoDiHNcdtuPKjuGE0Hy02ekgbdXm3pUA+KWp
	zAzAHk9snad2qkCRivMG4Jj/ONWcZfs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-LGGOjtYVMg6s6LgYYSCTig-1; Mon,
 23 Nov 2026 17:55:18 +0000
X-MC-Unique: LGGOjtYVMg6s6LgYYSCTig-1
X-Mimecast-MFC-AGG-ID: LGGOjtYVMg6s6LgYYSCTig_1795456516
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E73881955F72;
	Mon, 23 Nov 2026 17:55:15 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5F69421;
	Mon, 23 Nov 2026 17:55:14 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 1/5] KVM: nVMX: don't check PIR.ON when processing nested posted interrupts
Date: Mon, 23 Nov 2026 12:55:08 -0500
Message-ID: <20261123175512.80438-2-mlevitsk@redhat.com>
In-Reply-To: <20261123175512.80438-1-mlevitsk@redhat.com>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
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

Despite the suggestion to test and set the PIR.ON and avoid sending
a posted interrupt if it is already set, there is no requirement
for this bit to be set for posted interrupt processing to happen
when the target CPU receives the posted notification vector.

See section 30.6 POSTED-INTERRUPT PROCESSING:

   "The processor clears the outstanding-notification bit in
    the posted-interrupt descriptor. This is done atomically so as to leave
    the remainder of the descriptor unmodified
    (e.g., with a locked AND operation)."

Apparently Windows' implementation of APICv does exactly this:
it sets bits in PIR, without bothering to also set the PIR.ON.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..e336dfb8d6b9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4041,8 +4041,16 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 
 	vmx->nested.pi_pending = false;
 
-	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-		return 0;
+	/*
+	 * Don't test the value of PID.ON.
+	 * It is valid to trigger a posted interrupt without setting this bit
+	 */
+	pi_clear_on(vmx->nested.pi_desc);
+
+	/* Ensure that guests sees the change to PIR.ON before KVM harvest
+	 * the PIR
+	 */
+	smp_mb__after_atomic();
 
 	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
 	if (max_irr > 0) {
@@ -4209,8 +4217,7 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	if ((max_irr & 0xf0) > (vppr & 0xf0))
 		return true;
 
-	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
-	    pi_test_on(vmx->nested.pi_desc)) {
+	if (vmx->nested.pi_pending && vmx->nested.pi_desc) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
 		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
 			return true;
-- 
2.56.1

