Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10991489881
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779993; cv=none; b=fdOjR9Lx8C73YdOqfF2/BfNQpBotzSAKgHWqK0NaIKBKgALxrBhG0y+RVim0qq5pnDVJ2p7ij2FRl6M/KkpLHHAYlBm78ZL7jyikiReztQCT2BrcK+ykmCHuPmn/ZVbbMrc22CkDZbIYMjiD88vZxGS/r/LJxS3Pz1n/dM6UVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779993; c=relaxed/simple;
	bh=KAoJX+w+XmJqc4fTFJNWN+O9Ca9qWU4Lqdvsuqf+0RM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCJ6g2HcQFuZEisYjjIMQrRpVfJ3JZo6NaD6O45mGAnFPAc7KTzBOh1h9yyUuce5BbGxfxPS2QXzZtZl6WNpflwtSTQZ0dj/kuoN6RRqMYiKRzt4Sv5d1BeuObXl2P2rWCeeyMrSm61dDz/QQzuHTuC+p9d9ZP6RzPT0g4Wscec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYtiMiUm; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYtiMiUm"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a67b16217so2281992b3a.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779989; x=1788384789; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=91h2s+bdxLI8Fb+8IZGu8PwUcENxYkecSoLgiBQY74U=;
        b=NYtiMiUmudWyTLp8skkR+9KlrIGHJ5oLHFEYEEKCZZmT2F3mdXry9io0sh1PqUVQyY
         UbwQzCYz655VGCbTHhWJh91h4k6fbsBYnL7gpShFpcGSoiIsBP3cx/8qBvP8Eh/0OnZL
         ee5dwwNsji5AI6E2ngHC+0JJi+8un6IZxG3H2bV33jSgWsSi5IntiRCbmZWGct2G8R77
         YTVZW1pshlb+OjFp8wKfyAhqU5UovfOyZOoWfPDaMjGxVx/VgfUOzve5mpTCC2z/jcPu
         W7TWCsIvJ6zZ+/QZU/tMtErBLtqXgFIZokBgM5SA6JjQRl2SqHABxPQ9x5hD4GoU6b3l
         F3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779989; x=1788384789;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91h2s+bdxLI8Fb+8IZGu8PwUcENxYkecSoLgiBQY74U=;
        b=YA4XGPvMGfs8lTJWOEA/azLKgCbxY1weL4fZKhsapJf1GVUhajadkjMSUYsib6qauB
         dw8nk6ZQmyD2Z5gZDonikcLN3cXc2o5fmFyIOUrgpXTwb48HM39tq5OMUH/GYUs687EH
         z4j+IziUTN6S+D+7ZPdrJ8tiAWFcQ2F+79kHYScgy1wX3CIJYpS0xBhcIYD80hitu3ot
         fGE4f4RJ4DT98uyOeBPiufCcmwBgB7D5TrbUGoL+J1b75b7Zr2c/2j7Nbz88UULnEKWu
         +Zbi4aTqk4lQN2EeXb19baRPcgi+ssdds8g1vT6gHZFNn8PYnyW+n1yh1JebiIx/+w6j
         X8Xg==
X-Gm-Message-State: AFuF++lCw+73Jfvv9MAGyOtil1doqIAmtqhlyM0J0ziDaMRDPG64/piT
	Ezqpw4JXHlZG52N4wHVDpFRzkThe2IieZ+D8HWDpFdZ7KJSFqAOMwDiwUvsANTGqxjDIO/+PhdL
	2yWxd2g==
X-Received: from pgby7-n2.prod.google.com ([2002:a05:6a02:6507:20b0:cbe:9dc7:9ee8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4ac6:b0:845:e9e8:645c
 with SMTP id d2e1a72fcca58-85372ba1874mr19864472b3a.6.1787779989166; Wed, 26
 Aug 2026 14:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:44 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-5-seanjc@google.com>
Subject: [PATCH v10 04/21] KVM: x86: Activate master clock immediately on vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Previously, the master clock was only activated when the first vCPU
processed KVM_REQ_MASTERCLOCK_UPDATE during KVM_RUN. This meant that
KVM_GET_CLOCK could not return the host_tsc field until after the
first KVM_RUN, making it impossible for userspace to follow the
documented TSC migration procedure without a dummy vCPU run.

Fix this by calling kvm_update_masterclock() directly from
kvm_arch_vcpu_postcreate(), after kvm_synchronize_tsc() has already
set all_vcpus_matched_freq. This ensures the master clock is active
immediately, and KVM_GET_CLOCK returns a valid {host_tsc, realtime}
pair as soon as a vCPU exists.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e18158f51103..4ab0a41eee7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9447,6 +9447,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
+	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+		kvm_update_masterclock(vcpu->kvm);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.55.0.887.g758fc8c411-goog

