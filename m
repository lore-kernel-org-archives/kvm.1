Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544423;
	b=GwscQ6vjP+EGizjKO852bCZle1xof0L2jSJdKwTWoDvzy234tpLeJOGY90KYWrgyrgaa
	 XkPSf9fzinb8WPw1J+P7ZFyMSfFpF1DMIkFXT9TZhjalLqy1FmyUXqT9gEwQc92+R21A9
	 bkobmm3FpW8Q4DzP9V0+MGYjcuqq1y67CzezVzsHZuPiW4Dee+qwj7IVTa2VNEv8Id0XC
	 0ExE6tco6bwnHCHFp6ZlMRHkghFdyzIPYFfovnjzHBjGmwRa/XWsFQfwhPRbuxjPT4BCC
	 4fCpMPKujRMEYKi05VuepJ/HkFvAOe0DapRWsadBi/oYSqp39DtOimsMRM53YZXgOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
	b=BXpk/J3tVxMaU5byJeThAqeWoOLYX5v667WZVbU0VvwuA/E4WhpVAT77lqo2sKa8zjqK
	 pmeCzYDleyBSk1/KcIVkt3p+EtgyYzwDQjEVBJfJlb4jOKcG+wNxgRrbZw/vB/ZExTxF+
	 JoX6yF51idXd2moJ8yfSU3R8MRlZwcfwikMHNziVebDrOI8ufAN9R2Fv/nhNJU/b6vVUY
	 ieHvz17l/QzAMNH9dfuEm2XvI7D+jan8Rz7eOLhhMYtL34D9KWJj6G4sxVdOZxp2tlgSO
	 WDw3CmF8IB9BTddpc6noP5VFsEoQLHfnfFNhtBazg0c+L1Ns6YhaYLeDFng84L4rffg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHkCTlsn;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC738606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC738606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHkCTlsn
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so4426124eec.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544422; x=1794149222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=mHkCTlsnC+ULlBwO0LLogM3r/7h1XFLev4Vzeb6v8xf1ToE9UTsLWSd5zmThTz1vAh
         1StTDZoLI+UDUEU1F9/Xq++fo9/xj+Ak95vmt1EZu1jm73CZd3ntY23BlFlVHPT9Vz1l
         KszdZVnxSOeoFAcr5MiadymyzCAvPELM8ff+HBlopKvErZZMAFZsCVA4mbfbVfoBdMOM
         3bmFkykvwu+MbqJ6ZMN3fd2LgA7DsBku/Zeh8+k6k981wh1sxSG4kZAmMfu60pWlo1Nt
         zi/NPbZM4YgVVTDftf+V6Mw4YiW4GzCDrZTBZU6fXIhH0TqpilGxW3PPZ/oTZcgw77dC
         0cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544422; x=1794149222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5gRU5GAL270mGkO9O483YONp/GPCEfficmu0iainJg=;
        b=AYboqKEtUBlTuA2U1VwLu6jy3uXcnC0yHfryoSWx6mWMXtAWxRfOihqGLXQ3O4unnm
         z31mofhDO0R5IYLkHwceWct501kFvV+ODCoJSPYdrt/QuIrbduMTRRoYsT4xrKBt7Oi+
         qbQU5mDCU8EoK3T9txDYow3t0mbRvApeE43IrOag5+hjmq5RmODToAi5+f4yX7qi36Z2
         FYG44HBcCfyKNowZT4Mu2zl1GRZKthv/hT0DzMuVFKzo6xBfdVZ4bkNKTD2nAZg/1b3Y
         emqbE+EMbPIVIJTfFsf5ScBo586Bm4gXHLbFyybqtZ2YF+p3CYhWqeeCz+3uUdRW10UP
         w0Tg==
X-Forwarded-Encrypted: i=1; AKwUvBx1UqwM8fyhlgDy0i55+BbqCwzsuKV8XtTqOWtlUE1KzTovNEEhCJtXvJXwAbyGtXT8dgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oBeGvDb1NjhTjaABOqd9I/fxXBr7A2xUkju54VJZYMEF5Esbp
	vQHhhaL6buFDF6neMYzKPvCyRYd7dg2MjjF01NaMeosDErw/qxzVXOzX
X-Gm-Gg: AYBFou2CcK/OHHiWUGQu87/I1s1x7Piwfv387c9uO28uP2A6oF44Zo1uwoeXoempa/w
	CAyt4hCMG/Q3aIG00q96Q6PkcyJ6vKL+Iia2zbeLleJGgeXMV0awU0GmJl2/5ni7AAEdV/W8kqR
	pMHzD4jGVnds3B6/p5TarUAtgOhZLRaDhtGUot1+xINO1GgcX+OzUiAQwOdbJSgiVxcZOolBJqj
	xxCHsT7gfh6oE20n1/40dVpEN0qjMY3FclVGd91EHhPO4WEuvHalyGBit9syUXg1q191wdFph+X
	2ksG4V3dcb5PNbZc8ATQOw3g58T2Onjr590sY7hZ+S/ZcVtR7Bpfmq9szHLiWIulesQLHSgs7a1
	ovRu/Xu1ZpuEFV1O5MqkVeFMZTe/nmusOe0thAz0EpL325Fz8sEWpVtpApbLFm0CEvqzL5Vow6u
	blNAPqrEEstGoU3E1dsuKSNQDc2CmOjOLQOp26KsF16KB/RhS+av+K69HBWeVZVrK8DK9/m75zi
	o7PfuW0GznECYm5bFOQLgSzjhOO5jteWRkgQ2dMIgkyNuRx5KToxaZrkDsaSW2gkqSsSGRXeeXl
	RYmdvztkUqb+kzxeIfAVVCXuTk8JUERcimIrvUioB6rNmhzS/C5Ru0A=
X-Received: by 2002:a05:693c:88cb:20b0:36a:1e50:e45 with SMTP id 5a478bee46e88-36a423624d5mr10929945eec.9.1793544421715;
        Sun, 01 Nov 2026 06:47:01 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:01 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 3/7] KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:16:28 +0530
Message-Id: <50c8d501783acd86f7b4a25257c70505b96ff7c5.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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

kvmppc_core_check_exceptions() has the same pattern as the Book3S code:
it starts the scan of the pending exception bitmap with
__ffs(*pending) and is called from kvmppc_core_prepare_to_enter() on
every guest entry, so it routinely passes 0 to __ffs(), which is
undefined.

To be safe here, let's use find_first_bit(), which returns the bitmap
size when no bit is set.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/booke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 13ad4cf5fa71..9794ee6f7204 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -692,7 +692,7 @@ static void kvmppc_core_check_exceptions(struct kvm_vcpu *vcpu)
 	unsigned long *pending = &vcpu->arch.pending_exceptions;
 	unsigned int priority;
 
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_BYTE * sizeof(*pending));
 	while (priority < BOOKE_IRQPRIO_MAX) {
 		if (kvmppc_booke_irqprio_deliver(vcpu, priority))
 			break;
-- 
2.39.5

