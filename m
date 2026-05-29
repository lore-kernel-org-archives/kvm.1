Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFC423A65
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079766; cv=none; b=QThu3TP0eYlUaPGQQgtUdVMymqs/ZHt5ygVJnxmOdfNurvVnlfEuVEYqDu4sRDuVvuYuQU0UYplFDyNWWObhlYkyDDgFWd0aCGYY3tAoqbM6S6gTM1TUMXlF/k80CsOOD4kuxqol+wjPBvbyhgWHscKnzrgPEUbWy4FxI8iGa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079766; c=relaxed/simple;
	bh=Ic42NJxjVTuyyhMYhy6XU5l/gYDKkJGnaGzHHnNqay0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FouwRGxeYJMrYBOeE2ot1RP3qvmZll0L2fH5wL/81tUdBh/1B6k/yud/zhI2UNjIivVz/lIobIBhd8MXQzApkxWYcmACkUslrDW4APDr7QjE72GxFI08RqfTKcirAbZ0CTLklykVMu73Me2JZJ94u8HzvKiqjq+SAj1iGoJ8N2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Inkkcvls; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISL1fgGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Inkkcvls";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISL1fgGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
	b=InkkcvlslYfs93hdMpYdDv5UWc/JWssnTPDHxwZBcFV4htGH42Zf23EUiN00CJ/NrBoas5
	h+W+nKQ3EkJYCSnZK9t0xVVRd7OFBGUGCaAn3zOXeyozmayaklBiVlcaXcIjvldbvGF7F4
	ijSiCRcmGE6CuLBdn/PvNp/WDihxly4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-3r9mjbalMtWkUsgui7Ck2A-1; Fri, 29 May 2026 14:36:00 -0400
X-MC-Unique: 3r9mjbalMtWkUsgui7Ck2A-1
X-Mimecast-MFC-AGG-ID: 3r9mjbalMtWkUsgui7Ck2A_1780079759
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fdad6cce4so71825275e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079759; x=1780684559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
        b=ISL1fgGNShxnQjGfQF2kQ7B/utyID71pnDqI5ctnmKMnLPWhl0v5/AZ26TygE50CIQ
         o3VGT/Iof0LL9/c+H8RDCRDW9HXa8RSLV/CmUjMqwMYCKfvDRAF2zPz9OE+zEAEDhqQD
         rImawR8DEYDvjnFw9Bb7DcB6tJUahKaO8rax+kT4eL5V4rIrHbsTo/PW4Fc8mDfmT/uS
         W3Spib4Mh9kMeKSlwXp4h7TwORZITWSu6OaTGLYw+bQzj6K3uFMf19lXznTxJtKCtNww
         C299CHBLK8uHLRlFZdOgKG5Jspv8R/nTAQpz7EOjJy+YBo5id9ybssMOFGKhfT/g2pUA
         9hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079759; x=1780684559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
        b=m4/FIxOCIS6O8n0kRlIVfOYEgDZPxI4uMGQhmMgs3VyvRiizjnoGbjDYOBlbaq4ce1
         gn0uTTgqkqI8hpYOwl73X+YR77TbM2PNTGEivjx+YxRTXSp4jXQz4DPVxQMSYBQlcZXJ
         oAOBiWZcYC8arp05bGCnEGMJkwsvJL76htimbYPY5ZOElsvZsF8mfEtj9TY7dQwfGE5z
         VBMrcnMN3GZt+fLir5YNMiUsrXJETCXPsXH5tEegws+XiawRyji7eZKKw3UhlKrW12kv
         93LRTk2lAb5TGA33n+LWD429DoMrAmDwtwORah5wYUioxSHXEsoEz90PRSi7Jv/b1PA6
         OPYw==
X-Forwarded-Encrypted: i=1; AFNElJ/QEypwt1tCtzWDyAq8oA2Xv3CxME4LzKwtHNBCkR7fkYXcv45byZNE7m4lSYwYcnLbcNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfmt+3n0XHsz4y3eHW3q1VhSQr+KiTZvh1kQQAb9yoS3H8bHF
	nsIahSAu976P7gxQqzzkBNAvZtYuQb/zLAJHvq4xW7+UOOr3klyV7SGLoN269a9HUUeT0HMvIft
	LcwG18NgYTG4ZnoRjXSGIokDOfT7UNVIbQ+xcROSSG/ixTSbrN6EDmHrlIsHupQ==
X-Gm-Gg: Acq92OGHMdy51vC+eb6tcRCfjW1VwzMwd1T4jrYFFilNGI6IMQooZywxzy2F7NT30Wk
	wFWhIDgFpQux7O6fIHCMOxIDMkKUgdk/m6fUp3SLsK73Tgh0Z7C3WehlyHONggrRIk4kzRx2G3o
	fb8B0wOA1l6usY+6m9ixULK145UELELFAGgUbAXrMeDMndi1bgPfUU1zItiY0y2P79f7HEaHS8R
	4vQG74g2f29nS1BfNDwX1zdsleNuN37iICO9i0eYIxzMHIjbwIT0aGytjJwT3zSFsCgoBUTpZRC
	Y5br9h1nJ5bpShexIjebFjgy4MpU4A9zttmMYGhgQb7wtahjR6BGDaD9ci/qd3zZx8FdjLxRKuE
	vEGrSsQLpuak0hUvheBIgKaLicsR0NjCs53xCZigR9sWMYLJWFW2gCKzp8MbzHznWrjdw/xuxJO
	zO0DOLvTShYh4LkhNk/NMhZZJwne3dI4f1GtOrFQ==
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490a2a4bac0mr7346565e9.12.1780079758996;
        Fri, 29 May 2026 11:35:58 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490a2a4bac0mr7346335e9.12.1780079758656;
        Fri, 29 May 2026 11:35:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c114e99sm19737625e9.25.2026.05.29.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/24] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
Date: Fri, 29 May 2026 20:35:28 +0200
Message-ID: <20260529183549.1104619-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

When using GHCB v2+, reject MMIO requests that are larger than 8 bytes.
Per the GHCB spec:

  SW_EXITINFO2 must be less than or equal to 0x7fffffff for version 1 and
  less than or equal to 0x8 for all other versions.

Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fb2174b6d1ba..e6579ca9f364 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4502,6 +4502,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!len)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 && len > 8) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;
-- 
2.54.0

