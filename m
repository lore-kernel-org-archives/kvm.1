Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139140;
	b=RoAJyGLRHWiHZCmnki/z1/eUghy7VJK+5lAax/uH4o2rcO/pD6vggxteIX6Myy/7xQYP
	 +H8YZxkNNqgZ79EYmwOgWC10ps6EXuqnwyyZAiGDhuCj/PqqoKZArJDkXsEPBnzBg94TL
	 xusDd/21QV+sV6/Msz2gGPlUO74OP68u0d3RyUDJhYx94MPzMsTzdbxi42U0a1ytK0ErI
	 hSnV0rdJaSL1SSDXKJ16ZZi5GVCTrsRPkLwN7HIpeE2E5f806t3LNMicge+g9pK0DH32D
	 Ouvv5olzaKBCgEMQ68aP4H3QAveULfDI7QgNR6p2aNPeMCvO3yOpTbv4UNLQfdrllaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
	b=2+McoCCIyF+3BVcf8mDsrMgi/SPlo+CGaHYQiDyWAykGkVfPcxLbWztBYWHmATwPtc5j
	 0EA3eaeBTfp0CCLCGBpPUK2mxO8V3OBov6xs3I/DvpEoHwMe8WrQkd1VSAMNRTivqwn0t
	 5KrDosTHvwmleovo4ckKHFayWlzvw7Q6CwyAKQyTC+1xEcCKsK1GiG6DtMJgMaokHZZ3M
	 1EWkIBgIgpC9gDKem+KV1eUmNZJC54bNN0rrlDHHxlo0s9wp3JuaDBA+8Fkp/K3IFk/Dw
	 z9ouebUx/+Uxl3wN9pA6udHPA7ktxBxK+/gVnZLb0wdtuEYpzIBGswSZ88EBnWqQFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nxWeFCyA;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8960A2626
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A8960A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nxWeFCyA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf8ea208bso2359965ad.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139140; x=1793743940; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
        b=nxWeFCyASb/m1rFC8xyiuDQhOTyiQ31EvOFqXYQE3+z0t+tx5Syb2Jd3/U02IL+dH+
         zW3tYqTyeHjeBF53i0gkeEAmlGB04gFfkMVe2dZOG8rwIbXiR7EZJU/Wur7VCQQrXX0U
         3Zwwwsz225npZp5YQIwdpGvqMRDRsokI/Fwyu78x3iJv5cYY0oJ5a2Ru5m9UWmLeu8uJ
         eXbvjCduFvPCtzwMf/XsrG1b5kmugUPB1xb8mXzZt/vCPW57hAJZY+9TKw2R2W/JDS7/
         zHU4MREB5bktC9ueTP1LOeC58nCdSbO5tgw0XfgY8KIYYs3zmsMmCgjXlfXIbIJMkdkT
         ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139140; x=1793743940;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Of8T2K/5s+DYFHs2DSa93Ge3Q/T1My3lt2s33kdfKI=;
        b=euy3LRCpOzLn6oKgymWJFwP5APaZ71GPMZIT7YtK8/L+t/xZu3pmkTgxmKo/1B8MIP
         ZbVmgAUT2X75eWsn12IBASW1I4DoS4bu4l8Vb/jyTdEJv4vMnh84GQPRB3WbFUlzFY5s
         S47jLgDC/kCt48KfUIJEXVUlgTO3Dg+9PfirauT+LC367oijwtav1ooYhNGnjxaJYOSL
         RfYWo6rlOqlm+QpOxj10BOXq9cr4ivjWNav6HphauTIw6PH63ct45I3rx/LQnP93XfXE
         XEyq9/0b1TFUUPJiNMVOELmQ/WaTIq+9QKQFx88Fl9MgMUlEPBIUut/S/JJFpNk5FEbY
         jeBA==
X-Forwarded-Encrypted: i=1; AKwUvBx9SGAYVxmOniOXzURVG+SMo8D+sSEVYMpsLtOLfc3AwCoR5FBBAdSS4jwD0szW8DXktzc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0RbuFk6hmZF2Bf8QCdbAldA/umGsSmy53Ymsbk0aVrMpDAN18
	9suYgJ0Iwiz+jXLfoK1pbXEChfus0KtMV1WBg7CcTMhONoyHRIsHa30ELZI2IL4vHBzYzdkNpY/
	CHKTmKg==
X-Received: from plbjw20.prod.google.com ([2002:a17:903:2794:b0:2e9:84f0:65ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c408:b0:2dd:ad73:c989
 with SMTP id d9443c01a7336-2eb004b1c6dmr5194065ad.33.1793139139723; Tue, 27
 Oct 2026 15:12:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:00 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-8-seanjc@google.com>
Subject: [PATCH v3 07/15] KVM: WARN if KVM attempts to do guest-related
 uaccess with "wrong" process
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that memslots are torn down before kvm_arch_destroy_vm(), i.e. now that
the massive, unaudited path that is known to have at least one rogue access
to guest memory should be short-circuited before attempting to access user
memory, WARN if KVM attempts to do a user access to guest memory with the
wrong address space.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index be27b4e8f12d..f3f59bdf7e18 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return current->mm == kvm->mm;
+	return !WARN_ON_ONCE(current->mm != kvm->mm);
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.307.g5fe7bd680c-goog

