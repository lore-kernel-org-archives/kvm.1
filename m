Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA2357D1F
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528041; cv=none; b=Al0daVKP33UB5G1JQdb+UsEiZzWa9xR2I1UyUAFbkrALyn9v4nBu2XMTP56W8S0cA1KIB1mh6w8neaSa6dfiSofqDicDGrjWL1xQE0R77hoQquMPtjqBc8NqG3HMo+h1y+Y6kx0VMys9eiCefMHM39BEsCIgV8KkKPSby2ydJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528041; c=relaxed/simple;
	bh=dv0W6/7mKtoUuSzLZzK6PX7bKgTqjgzZlkJHnx6M0e8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b4XnQES7+Kcx7pdqNr7sfN3ej4+KdnJOK9CRTgzEwYlTfXZEdL56OiyhaOO/tbKyW+XqWausIYGlUS/e7enfkXNhQ5yjaObhkW7d7ZnJrvoJvN1IRfN8xqlXYZM7z7q//yB52UKs47VLJIuD2D9imgifsM51iQjkm6o9JpyQufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4v+8PQU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4v+8PQU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bcfce8a33so946142a91.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528040; x=1781132840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Q/oKHzjo8CamEORK7vKcc0VNuVsIBynECmHK3W1QOE=;
        b=U4v+8PQUP55BPH79qVXxj4aCh3iBxGZPUuJGeJRfkZ1B5nFuXt6lExA1UG1j88A8WV
         dA+jxsW/w4U4Lc9VAcUvrLJGMHmXmRLE316ijJonkCy42WozayHJDg7kVazVfHIXLzy+
         6VZXkZNqGuf0yD0dh4CGiTPzGS3Qxss0U9+bjYnWpPv1LuAF7DJzv12MY2jSpx4A3Sv6
         pRCty/821KiOCJdpYL9VWw02g2BMyHxSRQwZgoRBEFrpmLt4r7e6m/h/VgeDlNR+peGt
         3a7+P/UABNWz+cgjGbEj5eLGlW2idEouw2IbY2QANpdFdFiLaB3F3+Hgg0Td2QLWkHIf
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528040; x=1781132840;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Q/oKHzjo8CamEORK7vKcc0VNuVsIBynECmHK3W1QOE=;
        b=j4gHYObrrfWOEn9T9yeOZnrAz5kOJ+aYg9jyV2HG+o6nfJGYdtdcE2qEpMu8+sfWZ6
         JmIVyteRBQsB7TQPqyWWnZvJThTpA0Sop2osHMrODuuObo3/0glRwnXFUWChotH4Mesd
         liU4pB/ky5Ls8ZYEpLqUfVjh7e27hDAsH6/kT7JnfwYXpSi7+U/bTbzgelsOwOTgSsWu
         dHL/lk4A5aptOv6FNKEhePudYBPFXz7QjZvim2Md3AYmoGdW/dR1YYqAMydQNJhHzPTr
         RuUzJVaVxDf6Ap0QbmiGFDdHAop9o3OX3QVySQE5HkJe0n4YEuKuiTNaoBS/q60pwQvE
         m8JA==
X-Gm-Message-State: AOJu0YxhhU2X53TZjfw2WRuEcyh5jt6E13QH4ZA3p1GawM8JRkhI284y
	utSbBKKlc34BHjY+9QFINiWsp2BIBnn8zxj2EsjdEzRVof9U67pK0lCa7yn163E2t0fxF3TT0zW
	DJFE/Wg==
X-Received: from pgjq16.prod.google.com ([2002:a63:e950:0:b0:c82:283f:132f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8d:b0:3b3:edf:9efc
 with SMTP id adf61e73a8af0-3b4b1fe8a61mr1043815637.21.1780528039727; Wed, 03
 Jun 2026 16:07:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:07:12 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603230718.1733483-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: x86: Fix emulated MOV DR{4,5} #GP bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Carlos' fix for a bug where KVM fails to signal #GP on emulated MOV DR to
DR4 or DR5, plus follow-up fixes priority goofs (#GP vs #DB, and #GP versus
#VMEXIT on SVM).  The rest are opportunistic cleanups.

v1: https://lore.kernel.org/all/20260601133320.91479-2-clopez@suse.de

Carlos L=C3=B3pez (1):
  KVM: x86: Treat any non-zero return from set_dr() as a faulting
    condition

Sean Christopherson (5):
  KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
  KVM: x86: Manually check DR4/5 write values to fix SVM intercept
    priority
  KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values in
    emulator
  KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
  KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or DR5

 arch/x86/kvm/emulate.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
--=20
2.54.0.1032.g2f8565e1d1-goog

