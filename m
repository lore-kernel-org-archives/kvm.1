Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636097;
	b=tXBXrQIvSs+k4xsuOzi4pFaGox9b3PBNfqOqNWv/fGrf+FQBIkqJlw00DnDbHDzRRxEO
	 W2pULvg+Myj7n+yD/wEQDJ23OG+rbfust4tiaoqVRB1Ua5Pxppm9TAUhqhEjxcon5QzUa
	 kCXp8TsAzp/1HRftbCux3KEC99jzp7PPjR+N7CTqe6pQt/PeOum1WOJlgvbhw/SLkRu4f
	 BYxRcBKaNoaJSzFMhlNBGIIlR5vy2N7bdedcIx6PxjS4OPsZ449wVRTBezfXElnKXWYAX
	 iKeHAHakFHb03Ua8ammLHx9w3L8QeYAkYiqByB1M71MKZvwDIBLZXhFVPzs0uZNekfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=r7COp7eSdmI3KWQdqQlR04zrDpvtCg9K9xahMpH03/8=;
	b=ZEUZQPNahMbQDjyEdKxIwbJbShFVDvZy6u2r9Qx2hkNx5mZ8h2wOI3bWkrsOd3D9yORm
	 yjhpX3uLv7dxE0I80ehVBOuahzD9Lzj4zKrtiTgB8EraZZUtqpAvteTnrp43CxDlqPfaB
	 Owk/D5BYMsP9Djp3GN35nPY7L4AGlwtGKWh8vAbH3xI9cXCBiF1C9OyZHn1YSbMYEfeN+
	 M6W3A5cXW6qblzS45tdnU9S3PhBi+oxbXO6qsKcbzRItJxtRoVDy3SNdKYPW56H5EmeuE
	 F2opksfI1mN4q0Eyv1/OZs8qn+xNG+/VSQtAcm6EYgrbR4mKhxW/R+E1ix8FTwNtqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Td8AW8Mx;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B490606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B490606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Td8AW8Mx
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e80f7acc67so14395695ad.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792636095; x=1793240895; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7COp7eSdmI3KWQdqQlR04zrDpvtCg9K9xahMpH03/8=;
        b=Td8AW8MxqevqQ5s9rozozIe6yUPmCMYWdP1+M1KZ26QmRay/baJiIlJ7r4V95fWpu1
         Wg1WBH3PfxSejXKwlg7uSiGgVyx5SA0qy7nQ1M800/PHbWxaa8t8Qzl/xtdIW7Yw7tHt
         OURL1ftyosl7Y4U9inFkhrO/WHXWq/eLX4KXGmiY0hWrr+/BY8MrBVIYQxFFsaND0SKY
         e63thHRbrmqKChEDgTxlc8A0UZjk4zBegumbVpBtdSrJI5wnX0CDG3GUf1kp269V2tDm
         q9815mGxRU8lUmGdsUnWkX0HzDwBg6d5X7FkqIQiPYk9BYDNPaeubF6BUqpdN/+xrkOV
         /5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636095; x=1793240895;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7COp7eSdmI3KWQdqQlR04zrDpvtCg9K9xahMpH03/8=;
        b=w7nSAm6IhQe6GmvUmjte7y2gsxfjZ2TG79LII+8WAexfDF4rEm9Vx9ISazDMQ/EUYg
         Ypr47tYzmY8q7ISPoiXsd7WMSo3k49oocM1fAJF1acWobTPCopdjXSBfahwi0LnokAQh
         TO+qOkYAGjtHcJ6c+R3kQ8uEmuayjjHBpU4vmveilwJYFHZSVw+3HLUKGVY90dCflJ8d
         uJRR5OvEdJMbhrn5EmhijbLteQpvODcVDbCbYpx4x46aEhMeG351vfZ+BfRJt1LtcWsL
         I5cQGB9Y8j/HjgppU0NEAkfRcaZIGUsuds5R4Nr2H5k7qcHWtdW+n3R5J4I+r6VyFHAB
         gFgA==
X-Gm-Message-State: AFq9FYIGsbZQoV1dSZvKDhbVirDgV5YBwkNolyTmT5kJ2a6wrGaTrLDd
	A1cHk4gy2t0Hky0X6MZcpRtNP29j7RXWuuY9kQcMqob58OSsTjwasHgtf4gBuQew8tZa4J8xQvA
	zvSnbfg==
X-Received: from plbjk3.prod.google.com ([2002:a17:903:3303:b0:2e4:b03a:397f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cb:b0:2e6:13b1:e196
 with SMTP id d9443c01a7336-2ea43d8876bmr28645595ad.74.1792636095139; Wed, 21
 Oct 2026 19:28:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:28:11 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022022813.303978-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: x86: Drop deferred updates of EOI bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

Stop deferring EOI bitmap updates.  As pointed out by Amirmohammad, I missed
this one when removing all the other cases where KVM defers an update until
vmcs01 is active.

v1: https://lore.kernel.org/all/20261017093016.32348-2-amirmohammad.eftekhar@cispa.de

Sean Christopherson (2):
  KVM: x86: Switch to vmcs01 to update EOI exiting bitmap on-demand if
    L2 is active
  KVM: x86: Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/regs.h             |  6 ------
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/x86.c              | 27 +++++++--------------------
 4 files changed, 10 insertions(+), 27 deletions(-)


base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.218.g1ec904b173-goog

