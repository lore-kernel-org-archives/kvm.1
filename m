Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141365;
	b=UNyWW8fbN6h3r0kBPFbmYsazQt52XZLrn8v2HShfsLuOPeaOoT4GQ3nYLGIctJQ/Geoa
	 Zu8Q+a7MUaD1eWjtPGy3v2fCSml1qOk+Wjb1jLW27trOYdNrKoVDuTwqsRRA31WMxVGU5
	 s2julPFncgzTT8oQHXPynCCUmgL81kl987blo+doY2r9sNTeYT21yp1mKS3cin2gsO7qu
	 n2tdkjq+3+yuf5s6NObfAFh/8L2aarVMHHwb/UnanHMplk940udJSl73c76D+wTfTbkWU
	 jxXxKOv74ZKm3rSC04b/p7hS8txnTKTOKZCnJs/iAqae/8JT8wI7Xq1YU8K0fm65BOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aSoNBqYVK3VlZ3H2DD3fucLQYFYLFibv+ua6L8aCHtM=;
	b=0IyiEzSLv79JhnXmFATLEIrQfqhGQGjAwGb28YWeIEtA6qzUL++TBk2nCaMJ/vawrU/t
	 UMLWqxPJrUuW5a/nftC4GNU8O8H/T57rhmIgtbUaBiElH5moQlLlTDqXb+NWRPzIe3GNt
	 1lfkjXZAM32k+YQrwCBhkQ7PlcyarVG0vaaur5dhLju8Nm200Q8lhUEy74TZJYraOdzU8
	 IcYMbrAHiwWbbbY5eXi/YKJx56PosgtFtjogaBn83JXFZ5VH0hmrlOjmPvKB1x2ymXzbp
	 Yow1OtMJ86SN4WQ7QmBekqUymbl5WImsDIFwi/dkbxSosrpCD9UO4yESxp5fZldUZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qHxIIYfa;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50D606A329
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B50D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qHxIIYfa
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9501034c4so4925055ad.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141364; x=1793746164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aSoNBqYVK3VlZ3H2DD3fucLQYFYLFibv+ua6L8aCHtM=;
        b=qHxIIYfaNIi2RnJ1zuauvL7UYv09CVn4qtH8jbor3+cYUi4WwQy070dmq59iVNCV0d
         mjG9ShfbsI9nzFaSyIoD+yd/k2e+KHsYWl/kuD1GlOqKZ3cg64HdadgGENF5SgCgExQf
         Vr00U7D1qfPisfn1pbDbluHXT//dA0nr47lzjAmn3VNxNmH+Es0LTyC0qPFWuSihWFgI
         Vl7bZodNVccSAyehxipg2PgkrdvtV+IE8LOT3FFGnLP2lewGuwscnkk7BffmQ9z4wA69
         GwUxVaPYuF/3HCawUIgb5oPO89VsglyowShvT9FbDpdJRbYYbKLNWLgeJIbaGmxbmBPi
         oNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141364; x=1793746164;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSoNBqYVK3VlZ3H2DD3fucLQYFYLFibv+ua6L8aCHtM=;
        b=V9L1zzOQPCioYr2kQL+JIq+ZvQMf0ypmcDUplSbeqjoxTLeoYOInA6rCjDo/dn0nrJ
         n6wuIJd3Kay1whxhsKC10036FRy6dEtoAZPloSaWN3irAabmE88P42HGqaoKCmKo5si2
         sdYoZArQIjENV4WPkiSrhjerT+S2rzjAOFMf30M7pfPX37Vgkq6U/Jhb9PAHEqi0RGRf
         UKgfyUwRvd50ZjFeBUwHOlSvTansZezI2BhsEzk4zu/s04SrqSUMFO1HkzvHlxmj64Pf
         ctrWFv/FQYwXb8IVBxRoEd8Shu9D6TlBuySlBT6wCtPYSPgmOalJogmqAheBzTytFHPD
         Ph5Q==
X-Gm-Message-State: AFq9FYKZIxt93l8VUVJwYBq06oW+c6ufcShdYJaIG+eEBdyi91mWp5cx
	8Kx4dDcqeR7+bbzE+mFchwH9FXlH6V5luMCEWFlnHox/M7f5Nqxt+pL8i4yx5eBayiWYXuxJXo6
	nbcPiFw==
X-Received: from plld11.prod.google.com ([2002:a17:902:728b:b0:2e9:5b68:4b7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d987:b0:2e9:3dd0:c8d
 with SMTP id d9443c01a7336-2eb0051d0damr6542845ad.14.1793141364326; Tue, 27
 Oct 2026 15:49:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:12 -0700
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
Message-ID: <20261027224914.1574319-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: x86: Recompute EFER.LMA instead of inheriting the
 current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Recompute EFER.LMA on bare writes to EFER (via WRMSR or KVM_SET_MSRS)
instead of carrying forward the current EFER.LMA.  While it _should_ be
impossible for EFER.LMA to end up in an inconsistent state on such a write,
KVM has had a rash of exactly those bugs, mostly because SVM is quite lax
when it comes to consistenty checks, which in turn bleeds into KVM's nested
SVM implementation.  Retaining the existing EFER is also rather confusing,
as understanding why keeping EFER.LMA is correct requires a lot of a priori
knowledge of both x86-64 and KVM.

Keep the core concept of the existing logic as a sanity check: WARN if the
computed EFER.LMA would be toggled, because as described above, that
_should_ be impossible.  Don't return an error if the sanity check fails,
e.g. don't inject a #GP, as setting EFER.LMA based on the current state
provides architecturally consistency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c3cb1575fe66..c55402970a34 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -638,8 +638,17 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
 		return 1;
 
-	efer &= ~EFER_LMA;
-	efer |= vcpu->arch.efer & EFER_LMA;
+	if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
+		efer |= EFER_LMA;
+	else
+		efer &= ~EFER_LMA;
+
+	/*
+	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
+	 * it means KVM allowed architecturally invalid state at some point in
+	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
+	 */
+	WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA));
 
 	r = kvm_x86_call(set_efer)(vcpu, efer);
 	if (r) {
-- 
2.56.0.307.g5fe7bd680c-goog

