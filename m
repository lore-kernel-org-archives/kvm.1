Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110A345757
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436829; cv=none; b=qEz5mRTrz+VXzfTQLehjP7NepHSc4G1GmrThddPFjGErMjxtxM0QcNdQHz7sG0lyGlZyXhfrWx/7xpvtbcJcX8PvZASjCTdPLXc5aUTFFWuid/y7a047VDCKUMt2Xi13kAXUqVb0rWdqD3LtcRSNA1+bRBNDD/VU2nIRS5Ik6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436829; c=relaxed/simple;
	bh=ZSiw/2TZ3pqWPSpq33OMJkVVUHMdHhjnofu5/GQIRfY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mrGOL1xSzFhoryfFcMdk99UBWfh7hu4+hVuUVnDq7JMQz/k4ICdd5IhnnP8KXsYYjTIt/4JxUeiyu+YNYm5hd94d34l8Go4XVKMSRAECKi5TwymA7vEWSeLVKU+TIBAtWG8PWdWRYudIcGhoVomBOz+ovE+YWjkqUcA2Ap7DWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFxv2a9o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFxv2a9o"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc640dfde3so42351335ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436828; x=1784041628; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZ7t16MfIAUbMs3r9Guv1L5v7tA4h9/RtiAV5upRcgQ=;
        b=SFxv2a9ofMsKXF/2oy5bV/SM5t4LgH1gXNOkUVdSlkHPfIMeyWO5yFHF3n1kh1f9hx
         ygMP1ukubZmKrAq2/Mu8uwpqKPHTUdL06notn9LkbpEEcs4au3WsFbr383Lq08/nRve2
         qDM4jldMhdR01sJHLVEBmuwulFAU8RjDNdkvLWWYNfq+/hFHYVyuhyNHAnwmCasMFjjl
         mj5ryMbL6C4IgVVKMxnneFxyW3jh66FgwpAYvq0mTxl+dRzxbGRx5kJplj07+ta7me81
         2sPQhze4Z+BZVA+c3mN6Pl5r1uXsFV8jhQnKIyRONAs8dNjgKszp3PX5KLjVhm7HM7dL
         se9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436828; x=1784041628;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UZ7t16MfIAUbMs3r9Guv1L5v7tA4h9/RtiAV5upRcgQ=;
        b=Pn7y+ElOsDJbasaDrbq/bdfCLD0O7lyGjhVFI8F/HLgXMG1EjSUVvcBC9IlUHwPUlk
         sVdx/Gk2oZ36vWDOzcECTPefxM4PVx9JXRT50g5HF9KXAY5nK7MCIeE4/J6BiMqJQnAI
         rUrGCWMVUUFMzW2RtK0FYxWOCzRvCcaiJ7KR7bV2+KUwM+sOIdmpsVVekLeJnLfnoxZP
         4uM+DAKZUV0huHyYC/Nn2HgNuNTWuPWy7sV0dGfT6jRzXoTU5PKKSyf/ijdPQIF4ByUp
         pAZH6F2KJ5CpTmh8uW90yepcp8d3S+u6OegYIJprKr1SYQBPQFUgX8UVXxlNEMcPwkTK
         UScw==
X-Gm-Message-State: AOJu0YwhCsvLaV6h4hcs3VzGSbAd6kFkPLPjbMf2LxQWLQK4aiPX4nA3
	ebcXoutcRS9rGMETC6qlepKHtkWe1kq7hJK/eT1tvdPrO6uPhM51YwEn0HRzCuThsCO/3uq6uqu
	cCQAP6g==
X-Received: from plth5.prod.google.com ([2002:a17:902:7045:b0:2c8:903:9ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c5:b0:2c9:97a8:aff0
 with SMTP id d9443c01a7336-2ccbf189941mr57137215ad.41.1783436827780; Tue, 07
 Jul 2026 08:07:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Jul 2026 08:07:04 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707150706.1198541-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: selftest: Fix steal time w/ non-glibc builds
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hisam Mehboob <hisamshar@gmail.com>, Aqib Faruqui <aqibaf@amazon.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove unnecessary usage of pthread_attr_setaffinity_np() in the steal time
test so that it can build against non-glibc libraries, and opportunistically
expand the test coverage by pinning the test threads to a random pCPU instead
of hardcoding the pin to pCPU0.

v2:
 - Rely on CPU affinity inheritance. [Sashiko]
 - Add a patch to in to a random CPU instead of CPU0.

v1: https://lore.kernel.org/all/20260706163649.155548-1-hisamshar@gmail.com


Sean Christopherson (2):
  KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
  KVM: selftests: Randomize pCPU in steal time test

 tools/testing/selftests/kvm/steal_time.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

