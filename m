Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD0333745
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099616; cv=none; b=IzQMY1t0xs84Jp9hxzA2WCzGRfI2bj2QT9DmGK7SX6pJ4kxoCVLCfInr6MQ6iMB7vGchMJyk4lp6oQVFEdbRe9DB6vkqP1p3//bHCJCs1MpiE2QVmp6YL/ZpXl2bbwBjIhatdTutFg2wBeLs5VV/Wss0QZ5gI4I5e93ikcwI+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099616; c=relaxed/simple;
	bh=1xEDXnOwtoc08m6CY5KQcDEvUc8PssGPm53i+rhKRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Onh+3Q1PRPSZnLgZn7pDrogJm1mQcM3KOGqByDXVrZsF6ERWQDCWJdG/mGhQPPQBkb8wb9Dh6aEhLpYHKiQBu4YFkgFSU2Cq0BKMaH4GsQtOEasQFK9Li+2XZ5eCGXTxS7q40sMoJXpGqTMXzXU+Jg6PurJRNNTOkFVQbZAj17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzNhizq8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uE//lr91; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzNhizq8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uE//lr91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776099614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NGe3it6Xaz/9PfNFm2RNw8/yb6f7tozExOEz32v1TvI=;
	b=VzNhizq8t+dqwcm3LSsyOrElN4jHAuqNK56TYO87imOwEVJHcmJ17IrTcNaLcWeu+/eUpq
	QfAOMMGFtuOupy3/EpgZJ5duVMKrLtkhCR5BSCev7PYTBst4F0Afl/PmOMgldw3GDD92x4
	v7WiGwSvQkHe81P1kHsCfrnDiY1DXnA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-p6sbeAovNdKWgJ1T2PBbvQ-1; Mon, 13 Apr 2026 13:00:13 -0400
X-MC-Unique: p6sbeAovNdKWgJ1T2PBbvQ-1
X-Mimecast-MFC-AGG-ID: p6sbeAovNdKWgJ1T2PBbvQ_1776099612
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d76eeb303so1329383f8f.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776099611; x=1776704411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGe3it6Xaz/9PfNFm2RNw8/yb6f7tozExOEz32v1TvI=;
        b=uE//lr912SByo0pI09QH1YfMfXbIPo27z7OZVTu1l+dRqYsDOABMhv2BP7Rj1j96fR
         cKECM1Oss4Rs7hxotmWW5byW022+IUef/xuiAYu5M1K1oQ8AvJMSSgIg9J3w94anQVnA
         e8ty+aDPRvnqwcAu46fyH1EYcqqJioq8cuhyTR/nlKc2xFRpH1am+PcH4iaG4yDlXB6a
         XRzqCQlpEN0WnWwL+thzfLme7PECckXYF08D05abo9hie76im1Gi071hi4nPhp6+VD0i
         9y1EH+7EpK59KPR1efKbNZYDpT5KIO/fNm0Q2hVj2EIkAqe1WFPLZuoJQftGQgZf8ULC
         ePTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099611; x=1776704411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGe3it6Xaz/9PfNFm2RNw8/yb6f7tozExOEz32v1TvI=;
        b=WD4i/vTOjhKEmvT9+NP1+dsvc9pnV1sNHs23u1XzYj75BbXKGyFxCQY9yKJ+ZOwWd+
         GtTh5Qs1V7Lv1Lim/qcCv1ksBBRFBzrkm+eLwEes+7teWPX+9GO+bsqBMW9lYsgnHYtN
         jV1+EqNRb/LWMo6b4nSKzf+Y71clYQR/AZ0W1mixWbDyjLH5QkTQxMHATj+ND4MIMN/A
         +TkBNJHWtaa0blMvPCJclifxojYMQ428fBVc/WJ3Db9CRC3pnB21m9vgEQFfUjAq/r4u
         lTr6U8tMWx6p/0p/ryWj9NOkqeDYIc060WXpuR6GgcY0ptFm8lCgtpBd4rPnmCE1pkTo
         R2Bw==
X-Forwarded-Encrypted: i=1; AFNElJ90kCzc/+twMqwQYWTDATA+kTfA3KVeQLGjFPko8H4kxj5VnujrYQy3DrgAbZ9BIT6TLsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6aE1JaC7t9mHiE9knqUJdLqc9UVyU31QNQXRHqYT7E+K4Wv+L
	12JKboHQkTJ96w0SUron69uPMUBVCJrZStnE1Tfsk1zPICpBGh1P9U+M8dFyl6JzQBQAYvtgojI
	Hab49cVmdwxHscPToBmDs55oIx5PEcTsMnOVjdykeyuO1i2DzsncHH5Vm439EHQ==
X-Gm-Gg: AeBDieuq3HFu5fnqFSLvGq12ArWQoA1Df4ODmKlawRTs+Wz2mlVWWMvm/qk6je+CKfY
	02dQZ44OJpO6L8UPmhXZdm7prHPMLwXvjw+JZPlEdk6UCmyjgN/jbJe589rT8z1L7xhbKgu/0NQ
	IZZvvuTDSUEYA6x131E1BX8ZoKLi3I+34wwgMrYkeBb80cUpHQctZum6CT77BBIbLKYSRNpPpuC
	D4fd7lvfNLQWjy36hqU8E6lI1+gSGUcqsVsXIMDIDy4n4nkBdwGr8RHaEuJvsP4sOjHGY7hjZCi
	dh/GI7szXPo4dTooaDIakRkRFE4OmoxZ3C8OVcwxZecNtGpI+7wLNM+vEp0YPXjXUk7H/2m9TN2
	MSx14evxfN8kDag4jvpgXdqOxgXFvlVWMcikfKcphlC8d/GOHtoM1ub8lT/6jUoxvjfVT6vU2tl
	CmM8332ZtFE8ybUdw0C+Enq2b2
X-Received: by 2002:a05:6000:240b:b0:43d:7633:2649 with SMTP id ffacd0b85a97d-43d76332872mr8869232f8f.45.1776099611175;
        Mon, 13 Apr 2026 10:00:11 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:43d:7633:2649 with SMTP id ffacd0b85a97d-43d76332872mr8869175f8f.45.1776099610668;
        Mon, 13 Apr 2026 10:00:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7a6054dfsm8417483f8f.17.2026.04.13.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:00:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH] KVM: x86: use inlines instead of macros for is_sev_*guest
Date: Mon, 13 Apr 2026 19:00:09 +0200
Message-ID: <20260413170009.380778-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helps avoiding more embarrassment to this maintainer, but also
will catch mistakes more easily for others.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fd0652b32c81..a10668d17a16 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -422,9 +422,19 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
 	return ____sev_snp_guest(vcpu->kvm);
 }
 #else
-#define is_sev_guest(vcpu) false
-#define is_sev_es_guest(vcpu) false
-#define is_sev_snp_guest(vcpu) false
+static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 #endif
 
 static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
-- 
2.53.0

