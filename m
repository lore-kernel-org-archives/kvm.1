Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5147F3DF
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324362; cv=none; b=cXLdUsnirxxXRizsBi0F8yovwOSSc0c1Z+vksTOLS5jOKfO3lOL04sDFTiew5biKSHPAkECVT+n/OYlcx7Cq+1LxXToBua+vhwuczXX5zAjOX0W7w55uiZ1GhG1qf2C47YvDjl/oR3SPkhM3PEmJDx3mmexZZfSBTKqH5cbshGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324362; c=relaxed/simple;
	bh=zlzDZ4QVexn+gJWuPsMt6yyp+RIDGLTBxGTrkJHBfTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKrSnJeuXLjI2N0GaLqFZmmdRMmOpR6hhmUU602y/mwpPIZ2SpqJI5SKR0+9zlPOGCVQuAjvYD86NJs2P+QQLaf9mFaP1/uFFzstJazBhzs51YU0CC4rt6i+iy1CY3JousqllperqKf+W25BUKu7/5jmkO9cik1cVR2fIjQBRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syK2D6Re; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syK2D6Re"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so17341305e9.0
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792324357; x=1792929157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOvtpeBhbTa2IsJhqs4AYerg0y8pdKV2Hefh53RZuO4=;
        b=syK2D6ReV+rDITG838XBxpfaov5Tw8Fy6SHv4h3ayJs2yZpn/njWD2bIkXLTYzJ8oE
         Rbb/Ukel6n1RwrZtYecYMCvZl9SJLcfgtJpr3ZjDZV6WH1wHU2mWplLV2AwD+CcHrTzD
         M8qvWxvk+E5py0dDTHqkD4usi/CoJAskNP9ufh0vFYjwNHnERoA+dtGZlTEcrglD8yl6
         ceVCbg0qkjaI6mdQ7Tn3YtdQ0PN7u/XI56kp0+MCsk+05xwH8+9bWnA3CEvnMkLh+W8p
         bn7iru1yb+soNNGK+UiEreKd+s7d9jAJJoqssKGWBAfuOkJFW5b/WkGvePoL516zDp2s
         3PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792324357; x=1792929157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOvtpeBhbTa2IsJhqs4AYerg0y8pdKV2Hefh53RZuO4=;
        b=hZKNQ58JxarniAOzb1zlWLv5UOOgMzm6wCiOTK4GuP2WOmP/NLzsJ57yEaqymW3yq0
         V5LtH5/m6DHIkXJncONEMtqlpXoNGoj94XlOjHZWmklF6bwUyESArYS666kK2sdCIpIA
         yq07tl8JzKs1UO/GJBkCnC5n8J3cNvY1zplxLore0dUFeBw8MIeyflcnvBxFLjLn61eO
         43T85AR/CmqcwwtDihBKfN1WrawOZK2x85XUDM7+lLCmdJ5Tx5eWhmHuRCvbWmh57Pde
         EpoxqhawNvbLappm2J+Gb2DrWf8RDRnv9keRSJjXoVXOK9WpqYPA4suwkX+yn7va88ee
         tY5Q==
X-Gm-Message-State: AFq9FYK3vno858RErvH9o8kC0pttzsB6IsCS005cuELShZrSLTpZL6zu
	bjX/qty+3Dik9Ixe0EHNElj/Oylfv6M/mQVmevy0IV1RUh9L8gkn+I/K
X-Gm-Gg: AYBFou3v9yIeh8iXT33+Sd9ANjvr1uc1oOjo0dq7TmLUHgGc98pQyljGGugh+WWTOkY
	AhyFGoAq9rfkxFwqKlhyPd2WGTGUt2DQfSGZmgegNt6PzNUqPdNu1BYJi3tRu57kxfTn5rnDlgC
	xxhnSxhZkepDK5JPHtGWdjSixmMmqp0wCBfmfDLoWcBm/XJhBtohTDD71dT7YaMw03pIIWfonjU
	5G7ta13SvASNG0uS0qeQTQjL2Gx40sVhSDtE8Foa1sviVr0J+hYKp1NuZ5a8T4PhuJmVXASI79D
	OgmOpmJb/xwLzXept9HT7NxRtfVTxmEJTVsspMjk/+sTD2PLjF5aMkttWI7kuGoiXCoGjn/8mVt
	xFng+Rt47U+Mqm/59aX0DCSQzwDDnesfs5741w8dyr2C8p+uIdeWKn+U/nHlEV4EFRFDojUlQsy
	oILYRY531eyIKpqvg5Fj4TeAJVDq41ptWi2LESL7l2gzgi8/nkk2wZVgnBKfWN65OmUwV3rfLWA
	6uarV05q54L5W1pa0ScQ65PtonDCbMaWRWmrpJqT/wDEzxacQSR5+aGcjrpjBLaglk/nj2NxPRT
	SXGBxdt77JPZIRrdDho8tO2H0XE1wDIZ8pL2HJJPMW+javVyX6rS0I6/95SFOVC1+nYihzHPXxF
	kBD5zm9VSqLCAb1UkGtQFDe/8c2NLClVmudJHgSHijGf5HF8Dt657UAZzaR4=
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr96775045e9.17.1792324356624;
        Sun, 18 Oct 2026 04:52:36 -0700 (PDT)
Received: from DESKTOP-42GVE6E.localdomain (206.red-88-16-64.dynamicip.rima-tde.net. [88.16.64.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d756ce69sm123877385e9.4.2026.10.18.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 04:52:36 -0700 (PDT)
From: Pablo Azuaje <pablo45154@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] KVM: x86: Initialize the PIO bounce buffer on PIT control-port reads
Date: Sun, 18 Oct 2026 13:52:29 +0200
Message-ID: <20261018115229.315110-1-pablo45154@gmail.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pit_ioport_read() bails out for reads of the control word register
(port 0x43) without writing to the PIO bounce buffer.  The read is
nevertheless reported as successful, so the guest receives whatever the
buffer happens to hold -- typically its own bytes from a previous OUT
or IN on the same port -- as the readback value.

Real hardware returns undefined data for reads of the control word
register, so keep KVM's behavior well-defined and predictable: zero the
bounce buffer before returning.  The read is still reported as
successful, and returning the guest's own prior IO bytes as a
pseudo-readback is observable state with no architectural meaning;
zeroing is the least-surprise choice.  This is also hardening rather
than a security fix: the leaked bytes belong to the guest itself, never
to the host.

Fixes: ee73f656a604 ("KVM: PIT: control word is write-only")
Signed-off-by: Pablo Azuaje <pablo45154@gmail.com>
---
 arch/x86/kvm/i8254.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..a4c23962f161 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -522,8 +522,16 @@ static int pit_ioport_read(struct kvm_vcpu *vcpu,
 		return -EOPNOTSUPP;
 
 	addr &= KVM_PIT_CHANNEL_MASK;
-	if (addr == 3)
+	if (addr == 3) {
+		/*
+		 * The control word register is write-only.  Zero the PIO
+		 * bounce buffer instead of leaving it untouched, which
+		 * would feed the guest whatever it last wrote (via OUT or a
+		 * previous IN) as the readback value.
+		 */
+		memset(data, 0, len);
 		return 0;
+	}
 
 	s = &pit_state->channels[addr];
 
-- 
2.53.0

