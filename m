Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB83390231
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773497; cv=none; b=FzuiRO6OrzwzQar4u1hfPvDcaLzuZ/Qr8G8yqN4We5hl8ZpOq5+7as2kBAzliWpn5EwsH3ZQRE59uDvDT9b1co+rZ5oG3ZagGmUT8w82xe57bXJQXSdU5bpeNaBmav5a0jNzZwFvU7s0qRUi5WEYkCRUdv8D0z2xIfX99uJmdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773497; c=relaxed/simple;
	bh=bwNBy556uWw+vxyMnVKrtkSXVtDCpK9YM97eKS/QmIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TqBa0HuyjeARcoWni5vUZrjp0rN9RCBBskL1K0Zx+nB/qxnM9dHGgWjvi4NE42lWM2dzJVzlrqqoRGfLokidMTmQkEV+aGtY9IrhfLI/bIAtjh18EByIo+vgcm1NP09Kg53aP1iPUxsavHsX2L3AT9E+I5Cavd5rxKYpbuV0AsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwqCZmwI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwqCZmwI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso956987a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775773496; x=1776378296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b1NDe4ZG8zbUX0n/F/WNtfK/EhzR9hlGfWDGoGHPoI8=;
        b=jwqCZmwICAiv1wrNzDtwReNlzgUa9ec3urRofqOlzW587BeTzFnNu0XngLit7dNid2
         qTlPMqLnbyQ5chq7b+KuZm5bgU/ArMVSvGaJF3o8wmk5LO5VPxsE8FY6aPTzk9NMssXf
         CfH6z3Wo3tD4alHKaeOAy5xXk7FQZwSGiWNeIbuEbWDOau/b4+rWbnGmPxrb4BxBvtBD
         CX/ZfyBNJg838ikhmneuR0pZ+Qv64T6qVEiJgB2i1twHd8NG6+EKhVW0Onqpz1CPXjY9
         sfNYPPHFdA3tUVwkukSe8OaExX6NNeqTbp6olZkSlCdf6topntRi8YOeUlyNCftvrC3s
         cjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775773496; x=1776378296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1NDe4ZG8zbUX0n/F/WNtfK/EhzR9hlGfWDGoGHPoI8=;
        b=F5V8VNN22cv1kNruYk0vydWCei4SuD2lhmuA/4ClFlsoF9CKq1JHHaLlFxxnPRIb+a
         S/H8dwYYI3wpqQ2kPvygrvkJIzxSZzpXU92XzoFxp7cyUGrATs7aXbfWAx2O0oG32X2G
         cNnU8D6gtcfXSTgUB7yskOM79HsMMaMPvKTKo9m32Yllnu5fZNWeYPXG0hgFEl8hF1+R
         IXtVll/iFPNB56n4XKKBmyyDzT6H3nn7fk2OKd2VRQMRJ8QqRSN1p1tVGMNYWB2lDhBk
         qXJEAzaSBr8nvBvnUCtjutIUgIyQ2dRLrdGrcxX/mfml8zzUbCmUtL7vTJa7wUgS10WZ
         GEmA==
X-Gm-Message-State: AOJu0YxUnOzmCknWz0SuLp8ed8DkDSSDcsBOhx0vWjiEz1b6otMNnmvH
	Kzg/pT6wz9I6F5/09uridkBHFzRtwyI6kFFqtK3Zq5m/aYNQZ2sQOueMsLNFhrGV4w0VUCl674E
	3Plk2gg==
X-Received: from pgbcx10.prod.google.com ([2002:a05:6a02:220a:b0:c73:fb05:a2e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9987:b0:39f:1f92:28d
 with SMTP id adf61e73a8af0-39fe3f1d7fbmr682362637.29.1775773495509; Thu, 09
 Apr 2026 15:24:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:24:48 -0700
In-Reply-To: <20260409222449.2013847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409222449.2013847-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: SVM: Always intercept RDMSR for TMCCT (current APIC
 timer count)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly intercept RDMSR for TMMCT, a.k.a. the current APIC timer count,
when x2AVIC is enabled, as TMMCT reads aren't accelerated by hardware.
Disabling interception is suboptimal as the RDMSR generates an
AVIC_UNACCELERATED_ACCESS fault #VMEXIT, which forces KVM to decode the
instruction to figure out what the guest was trying to access.

Note, the only reason this isn't a fatal bug is that the AVIC architecture
had the foresight to guard against buggy hypervisors.  E.g. if hardware
simply read from the virtual APIC page, the guest would get garbage.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index df974ee290d0..c9e9872ad880 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -171,6 +171,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
 					  MSR_TYPE_R, intercept);
 
+	if (!intercept)
+		svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+
 	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
 		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
 					  MSR_TYPE_W, intercept);
-- 
2.53.0.1213.gd9a14994de-goog

