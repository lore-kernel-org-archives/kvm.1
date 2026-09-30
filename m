Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D73E315C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797000; cv=none; b=eWD05dcUm8uAw4/APQg2OKXEHTRe2NFbZIhH/eJc4oD8iDdiMKOwNng2p8pmvV1TCZDtPmi4usMGIRxCOWSB8O1zcPytpl2U2E0J38SzVVGx9T2nk53zmwkUHb4FtEzYDP0dBlCkpkzS3MVUlCqOo3C0mp4vqMIEJZexEe2rCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797000; c=relaxed/simple;
	bh=A/nFV5I8OILCijxu4ThN2Sks1ZObqHSvT04Eu0v4C6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tmLJNOpZBC08XNmj0hFMe09AObpgsgxcW/9n7X0hIwB9r5NKFShlRRLoYWuBOYSZ8p3FqCMrSdru4WZT7oQv0ihifOVnmlNtUy7VNsrEQdrYzlHpPkNKL2WEMyoNrE4S87HHf9aYTdW8/93o3+N/XlBgXxm+unWlfKql8oPq6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcXVhaAY; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcXVhaAY"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e305755a01so81555ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790796998; x=1791401798; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A3HfqFgv58Oe77VJobLdkIke4fLE6/94erxxiYljr/o=;
        b=pcXVhaAYTG7jONtryJiaD6+6Nq+oCIBi0ieL8tGy0qroGzGGT1o8nD2nNsRyeiCI3p
         wO0Kubyr8axlglLV2WaJ4lWFERQyPbfvloLNj0vJ56MDSm/JYnC6TGAX0FQvPBqfMdyD
         Vzn57HdyhPnHuRE1htoLXqvu+J28z1n2qgAWTeNfU7cdiuHQegQ4bWKYw8ziASx7YdLN
         pl3gdfghhMOuQnzl+y1b4iv7XulaVO3al5wI2AgokcvF61h+LmSgK6zI3Z/adD+kSJ68
         EHwXS7mPtlG4l9MTl8l8Bw/9LlNUjsDomAxCPU4bpF6QxujqBo6E64js2aZwnAYArZpo
         sjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796998; x=1791401798;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3HfqFgv58Oe77VJobLdkIke4fLE6/94erxxiYljr/o=;
        b=R4f+K8/yCe1K2LLI2FpvcVajXlkItUhyKotb0yuaXXv1nEfNJFZK++yZzlmc9ftiqM
         /3hBm4AWKWnNR6B8IIDb7Iq/+DTrOwfu/2FkA8kG/q/ekNVJAyuGawQdqbEwXMWrACQx
         /nMO5vOqzLHp4jeP64NGlLd7Kx/LeTUTZvf6xmjNU2UooYiEfVEhva78e14nQ1vYYKVO
         FHDGjB5swzsqEwPTBqq75xa02tFxPEL2CxVsp7km+Y0xEpgrH8RG41aGLKt1axnwQwc6
         XLozHb+CAgyiQGJhIbr64A9NDF7RTsjU2akU3j57I1hpdPEpTavQ9N0+uMhZHAt3ajWL
         3vfQ==
X-Gm-Message-State: AFuF++n6zcvf2DGfdTSlDfNIOCt2BlJtMhzncsxqPDkb8gEFBtquRt8b
	ZWfX2aEd1acOhmmYtwkCKXLhWzyGGotz1c7iiG0c8dNpCrslIDkpx7YcmoQryMRFNWfQ+NMzvhG
	qUytmcQ==
X-Received: from plae3.prod.google.com ([2002:a17:902:e0c3:b0:2e2:d9e8:ae73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a8f:b0:2e2:d77b:e586
 with SMTP id d9443c01a7336-2e2e4bbe047mr20545405ad.60.1790796998157; Wed, 30
 Sep 2026 12:36:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:23 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-2-seanjc@google.com>
Subject: [PATCH v6 01/12] KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when
 delivering #DB payload
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Preserve Bus Lock Detect if it isn't present in the payload.  Unlike RTM,
which is explicitly modified on every #DB,  DR6.BLD is modified if and only
if the #DB is due to a (coincident) Bus Lock Detect.

Per Intel's SDM:

  Other debug exceptions do not modify this bit.

And AMD's APM

  All other #DB exceptions leave DR6[BLD] unmodified,

Restore the explicit RTM handling that was clobbered by commit
9a3ecd5e2aa1 ("KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW"), as the
semantics of any given bit are feature specific, i.e. are obviously not
consistent for active-high versus active-low.  In other words, while the
bug was technically introduced when support for Bus Lock Detect was added,
it's really that attempt to genericize handling of active-low bits that set
KVM up to fail.

Fixes: e8ea85fb280e ("KVM: X86: Add support for the emulation of DR6_BUS_LOCK bit")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf3fcdfd8ad2..ea1406c3b260 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -401,30 +401,37 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 	switch (ex->vector) {
 	case DB_VECTOR:
 		/*
-		 * "Certain debug exceptions may clear bit 0-3.  The
-		 * remaining contents of the DR6 register are never
-		 * cleared by the processor".
+		 * DR6 is a mess.  Reserved/unused bits are fixed-to-1, and so
+		 * to maintain backwards compatibility with existing software,
+		 * features that use previously-reserved bits have active-low
+		 * semantics, i.e. clear the bit when the feature is present in
+		 * the payload.
+		 *
+		 * Further complicating matters, some DR6 bits are preserved by
+		 * hardware, while others are explicitly modified on every #DB.
+		 * The trap bits are always set based on the payload, as is the
+		 * RTM flag (but it's active low).  All other bits are modified
+		 * if and only if a relevant debug exception occurs, e.g. BD,
+		 * BS, and BT are never cleared by hardware, and BLD is never
+		 * set by hardware (when supported, excepting RESET).
+		 *
+		 * Lastly, the payload does NOT have active-low semantics, e.g.
+		 * so that it's compatible VMX's pending debug exceptions and
+		 * qualification fields, and to avoid bleeding the DR6 madness
+		 * into other KVM code.
+		 *
+		 * To compute DR6:
+		 *
+		 *  1. "Reset" the bits that are modified on all #DBs
+		 *  2. Clear active-low bits that are present in the payload.
+		 *  3. Set active-high bits that are present in the payload.
+		 *  4. Clear fixed-0 bits.
+		 *  5. Set fixed-1 bits.
 		 */
 		vcpu->arch.dr6 &= ~DR_TRAP_BITS;
-		/*
-		 * In order to reflect the #DB exception payload in guest
-		 * dr6, three components need to be considered: active low
-		 * bit, FIXED_1 bits and active high bits (e.g. DR6_BD,
-		 * DR6_BS and DR6_BT)
-		 * DR6_ACTIVE_LOW contains the FIXED_1 and active low bits.
-		 * In the target guest dr6:
-		 * FIXED_1 bits should always be set.
-		 * Active low bits should be cleared if 1-setting in payload.
-		 * Active high bits should be set if 1-setting in payload.
-		 *
-		 * Note, the payload is compatible with the pending debug
-		 * exceptions/exit qualification under VMX, that active_low bits
-		 * are active high in payload.
-		 * So they need to be flipped for DR6.
-		 */
-		vcpu->arch.dr6 |= DR6_ACTIVE_LOW;
-		vcpu->arch.dr6 |= ex->payload;
-		vcpu->arch.dr6 ^= ex->payload & DR6_ACTIVE_LOW;
+		vcpu->arch.dr6 |= DR6_RTM;
+		vcpu->arch.dr6 &= ~(ex->payload & DR6_ACTIVE_LOW);
+		vcpu->arch.dr6 |= (ex->payload & ~DR6_ACTIVE_LOW);
 
 		/*
 		 * The #DB payload is defined as compatible with the 'pending
@@ -433,6 +440,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+		vcpu->arch.dr6 |= DR6_FIXED_1;
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

