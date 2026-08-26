Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E543BDA0
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769907; cv=none; b=Ap/ZrSM3ETcc8xgx+Oh5xGFJ9Y6c0RI8rDkUX3NptwJv8S3BmsHIRlaun8hv12klvw4wz4Z2g2bjPuSJc8+zuUP95DrsaVMBfUzikq/HrVTvKDScuxxmTSE5V5rhy2NvqcLGNT+o3J694mEEpmQXutOv+7wVzbeF2rlIiKkZZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769907; c=relaxed/simple;
	bh=1b8Qr855KYUK73BAwj+crcS6Ne53L5zvJVEQY+vroN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qOEhhOvL7KfSAD3OxysXwipbJl5cW7z329q2/ZE/kYfucfdP48Yp0t54m4u+8oOCkJznC+hrjqcOoHUmnYa29gwkGMoD+v4YByvUXpUggNBHfM++fhSwqt0+hRcPhW2OfjxHTl4XI9ibwBy1YRDOIOu1j0oLRvpJwCjAgT7E6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/uMkde3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/uMkde3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so25907075ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787769891; x=1788374691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=loiXTTHQz/zpU95R8TVM392sAaOQqoIrCXBsU2v94TM=;
        b=P/uMkde37bpsG2Yg3XbYKHdh41VtYUBlahR/9S6TXIlCLXlrxln+lnQh1aRAXX5H3p
         yq7hTtbOqTFg4NToUq/rUb/0y9BKo3Uu9UYSd4ZHLv8HrgPAOKXNWUoSWunUu3uU2aUN
         AqUebaC9i5zBM3QgHpq9DGrQ73UhDgi2ykLxUSHmk1a/WjELAyHhJgPlqFV/wkju3WfS
         GLuChxI4eiZFxaHPvYo4QvAWnYbSEKAUrLFKmUNY5ZO/RCfR9sqwfHvAdtfcrjVGGAAW
         HdcLWZaslYUfbAmwfA9Cg4tGhvVK0ZHxmNM2z6r9cogGg9VUP1ljrQpUdENxKqyMpyCn
         RCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769891; x=1788374691;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=loiXTTHQz/zpU95R8TVM392sAaOQqoIrCXBsU2v94TM=;
        b=SEIfv8GjEZbNzZI65KrhEtarymig6Xsqd8wqVYTxZS6alSmFbixXv57MDlYHkbO1nW
         oD7c7NYT4SLJDK7d/P7RtMxeZ2/m1xmE+Q9bjP8pIVXhZ5j3Ykth2q9LkzAMD3pBzTlE
         jnmIq3L9McLQmvUgYKrXHDR1XgI78kKY7tdu8ya3C8p3sXthAeGYknetcL8S14box7+T
         FKt1aR3gf0xNCF67Ya+CBhfokUL77ngNXfGVn4JSDk6rv9KKKbzYF5nTcCGEM8NBu104
         YO8cbQ8FRRsHK0i3A/n7vA8FVElWfpAyfoytbjkphsWAW+ZNXPoLol9YSR49Czx2Uuj6
         pPuQ==
X-Gm-Message-State: AFuF++maOwTaMZfdFCEITVLPo7Z5FrNvpvtoLdqXSWs1YUuXxBIeiGXF
	uZswBUpjEW6Srj82klTGip3wNhN2ewZ0FIo7LDgqkSbDXZV0uAZZW9gZlK2wv5Ksc4pEbXH2KBw
	BKWlAnA==
X-Received: from plho15.prod.google.com ([2002:a17:903:23cf:b0:2cc:2c68:b71b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c9:b0:2ce:9c48:22d3
 with SMTP id d9443c01a7336-2d707af8432mr169786675ad.11.1787769891000; Wed, 26
 Aug 2026 11:44:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 11:44:49 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826184449.814130-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Zero reserved synic flags when delivering message
 to avoid stack leak
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure all reserved flags are zeroed when setting the msg_pending flag as
part of SynIC message delivery, as setting only msg_pending can leak seven
bits of kernel stack data to the guest.  E.g. gcc typically uses a
bitwise-OR to set the msg_pending flag, without initializing the on-stack
variable.

Precisely zero the flags, e.g. as opposed to zeroing the entire structure,
to make it somewhat more obvious that the flags *need* to be zeroed.  E.g.
it would be quite easy to misread the initial read of guest memory and
think that zeroing the entire structure is completely superfluous.

Fixes: 3a0e7731724f ("x86: kvm: hyperv: simplify SynIC message delivery")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 604651cb2739..8d2669d8ef34 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -802,7 +802,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		if (no_retry)
 			return 0;
 
+		hv_hdr.message_flags.asu8 = 0;
 		hv_hdr.message_flags.msg_pending = 1;
+
 		r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn,
 					      &hv_hdr.message_flags,
 					      msg_off +

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

