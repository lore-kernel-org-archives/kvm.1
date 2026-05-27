Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B05421A08
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895419; cv=none; b=DnF+c+AoP3rOaqcwHYG39N9rrFivSu7Xpm2vCgXPFnC0YoY8ukvRDtB20X2UPv5ukAb2d0pq633lSD2TOHJupeqTz1w8a6Kf+ruhUHxQnb2DHz+8p6O8jqhewCaQaas0Gw1per+fZ7E/gWoljAE43GE9auXf8M6qU3bO88uVazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895419; c=relaxed/simple;
	bh=AjlIxRrBReuiZFbeWYmRQcFa64cxvjwsE9oM+RwKVxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gtdx193CheN6DDSFHfD0q1brkPEpbeytnAuPQZ5uUP443WlYzJ3wBKdl7kjvMtKP8KT2ZuaZuWe6M16rkKk1NLKiewWR94I0mDKVqV5RA4ogNya4KKrEH9mdwXUvbV39Fvok9EQnMJECqPVN2yTpygXNUoZ5RDncWYRLZhqbjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvWlj3hI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvWlj3hI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8531d89e59so2905095a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779895417; x=1780500217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lo7D00bbpiEaXBovIaGGW2MACTvaJrUrdKFpFJ3OmGU=;
        b=CvWlj3hISKlYFJQNRxOkZSVGW67Q6ZRQQCj8PQZ4yhqnpQ3WIjVUOX0hgDxfFt5WA1
         qPbGBusEL8smT31VoZDXrY8gg3p/LqGujxmJlpB1zpTyzBKiaVs3hWz0u+XLBm3/daOA
         KePrms3XuOt+k6ROQoqrlPj1S0IXIqzyfZeyoDsRvgG1Ey1/YXg85xSLhYnP+0Ji6Fgm
         n8I4IAQiTVDcFlkUvD1UQObGMNBFdj4bbkP/h+7e0iFYKq8px1RLdwwztOHKf5mIqjo0
         q8z403tGdznH8SRjVYs5N2RV/kSEDjjj6K1HjWzIj680Q9SXQrkuvvKRcSTeRVMOVOXU
         VuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895417; x=1780500217;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo7D00bbpiEaXBovIaGGW2MACTvaJrUrdKFpFJ3OmGU=;
        b=qE7BzyLyydPnozjHPcXDgJ0IW7j+LiHVhYPXvmyhfVtSD/z1n41U6yxPYU18eg/mT3
         rkfudI69IBOBgpQ+Ux5UgyL5j3Qp8JCU8RlgGvMw38RNcBVWLXGDyfFz3uSekA6r8iMp
         9YmN0tGkYX6CikFc+b5lfxh2p4bQpf0k+zLn2G+QZ49I7w0ygppaWsd8AFr/E1Ku3XZi
         WmudktAGoibCRw2MlDFhL3LDiJHGFbGjqhV4FOZTUl9ypB0vwSx2taj7U+D+qzd8A0kd
         +DGvHWF3eJFPdguY58FPV2hwjfUK4POHCDP9LxwbiwJC8FYziXw2BeF2wyhrC4s6JGxW
         xPVQ==
X-Gm-Message-State: AOJu0YxrCxtbxiXQCIXeHSiIP4Kk1XKZzJywGux2q4osWjaNem01yTC9
	HR4HiwYJuNr5wW9UtOwdKkfTpVZfLzGL8SC8aK+j1UwDCvsGagTCgr1kw6hCvLKsvFJ1AEAbqmH
	gPM0sWA==
X-Received: from pgvz20.prod.google.com ([2002:a65:6654:0:b0:c7d:a2e8:5b54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7485:b0:39b:8571:3051
 with SMTP id adf61e73a8af0-3b307f420e2mr23565536637.28.1779895416806; Wed, 27
 May 2026 08:23:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 08:23:33 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527152333.4062942-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/vmx: Remove the superfluous vmx_cet config entry
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the dedicated configuration entry for vmx_cet as the test is NOT
excluded from the main "vmx" config, i.e. it's already being run by the
main config (and thus obviously doesn't need a timeout of 240 seconds).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/unittests.cfg | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 48835eba..1a8c7e63 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -463,14 +463,6 @@ arch = x86_64
 groups = vmx nested_exception
 check = /sys/module/kvm_intel/parameters/allow_smaller_maxphyaddr=Y
 
-[vmx_cet]
-file = vmx.flat
-test_args = "vmx_cet_test"
-qemu_params = -cpu max,+vmx
-arch = x86_64
-groups = vmx
-timeout = 240
-
 [debug]
 file = debug.flat
 arch = x86_64

base-commit: 05b7715ffd4ae4ef8f0a5dea869f1543d89f936d
-- 
2.54.0.823.g6e5bcc1fc9-goog

