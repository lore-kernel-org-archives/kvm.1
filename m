Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9D28BA95
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174261; cv=none; b=BMi6mNx0H90HXXM6PKaM30vTssOOsPsI4XybMDWWUgAh2FwtgbIGOZUHl2iACOAn98aG1N/Q4ToxDkTyoEDSAqrDsDAkFSYxSqY/J/aklTC2kQhhKX7Aw4u6oDseJSu0dnvgDv2LGSCxm5EsD/KG4CYRTMdzOTmeXvmkIkwF3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174261; c=relaxed/simple;
	bh=gi4vXovfy353ltXptWp6oxrDr/O9AdriHG1iPUCC2gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myyO5H7H3k29OH6qQCWFrDrbTORxrWupate+PiR+McfLL+9kxIPGG73VUi20VWNUrxdjtAfjKw5P2y6pnGxFbCPgkZ59DETG8onKHkbzoW+LtIjLyMK3PNMUaPap6IRV5kAJHE+D7/k7gar85iNZPDuYSAk9H3t67+qYDaQIY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijWyxg3z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiF4qK7k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijWyxg3z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiF4qK7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pv3ata0kOEeNqFcrcQ8GDlYqMPsQTKXZ6uyNDxDUgnk=;
	b=ijWyxg3zukePgI/qpgpLKGFBM8b7BKBUcryCL+umkM0F2TPndMJwlGcISDUaBtS7PaTssB
	n5unHpaUAyGlZgN1MW1/zXH0WKjXuyBEhd9IUkcYnQbdGhNaPlNmcsmzyNjht5XqdSZoDQ
	WHGqac01NSubYykdSKqwKXqEYnnr3ks=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Bq19VsncOByyPsDGYMDatg-1; Tue, 10 Mar 2026 16:24:17 -0400
X-MC-Unique: Bq19VsncOByyPsDGYMDatg-1
X-Mimecast-MFC-AGG-ID: Bq19VsncOByyPsDGYMDatg_1773174256
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so2511655e9.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174256; x=1773779056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pv3ata0kOEeNqFcrcQ8GDlYqMPsQTKXZ6uyNDxDUgnk=;
        b=OiF4qK7kcxrqYn8nFhe7yaM/H110heB5Yn5jFmes9C/Avqt26b0r8pqKiULaKc2e+1
         gS9VFt30CQbaOCjOqUR3gU1f7bvqoQYWuHboGbNLPg3xKiT+kNiIIhJKnqCQ6mTo5Q8P
         J4wTsYluXCCxrXO9fXYm6GmGfoAI+o8Zbdza1v9EMkijDes8CK0V/Mgka4OfKFEoS9bY
         xE1kTdd1cUHXBj6mTyNZniaTJFKPS4m1pghvXnq9brRGF+wxayrgIc2SgthmWakmopID
         0lySTNm9EE9Kdci0oiGSmAJbMJ4oFloHnbIUMdaDy7sLXC4ghVOad4n2zHsBMea9e0kr
         hLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174256; x=1773779056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv3ata0kOEeNqFcrcQ8GDlYqMPsQTKXZ6uyNDxDUgnk=;
        b=xFkvI1o0WM+3t8nOp5RtajnJG/r6Szm53AGjk955vLssMjVDvMa8TeOCek82JsYZmc
         UAHmKgwvKpA6djMH785fmIEndFpAowww35gKlmlITtdqqat96MEAxdR+1cQpY6Kh4eQL
         acFDOO5/JBmb73AGsnmJYyg6Wgs/Y2ZqL0rDqmpTJGXtf/GIuayvkGvts/nZFD+Gn5HZ
         tIrxxLt9SPPVpolsp2XvpOmkH+CuS2JrULXC9bEE9D2VFDUp0G2R0SMNW8sJW6l/dZUS
         Hg7YYZ7iMpryKwV1erl8HYQRItqaLi5xb9YREkQNyy7OVKDROrsdfHDglWM9nP4n2+7P
         Fe1w==
X-Forwarded-Encrypted: i=1; AJvYcCWKCw9frmrOPK/Cf4jIqRfr25xLGIuA6kjlEafao9KdN3pp/gnFuSpnHGYRqVBVZIZNG04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1s9Fs40/9y1AqWDs8r7OUr0EyVhk3Y1d4m90MeFNa/nUa6ev
	lKoNik0GF03v8rm9kOXniqrbWAEpiwNaf1Gq5oyAZRphJk+qEvuMY6NX2YYSA8eJwZIlsPnnVw0
	DOhCSaw2YlAEmsc50iYgLurUqn50vqyEFwh4FLhSeer67/va1fy3HkA==
X-Gm-Gg: ATEYQzzSzZg/3bNY9aYh9CfivFx96j6X248j2XIAP+mHOn2SdsL/rq2VvvMyCGf2xIC
	qQpmobU3huC2I21L+E+HW4q0jHMtqLPla9RBanalhxKGN0VC1OcftumI8JxCe6SamZMVQUDHoB7
	0NbxNMlsvbz5O1MLLItG2kB6z/CUXaBSqok16awpT7vpVD47ugICi1GUYi4i+s7LAgfgN83Pxbl
	xbt9xsM/AVecGUmVxtL0UML9tdRktHnGlisY21Ka0DP5k5qLdKzmtjf6hUMSaD/eGZszSgSka2O
	h+cPmAulMhzAkJnPjQTrUJ2tM+XvV9XEtZBSc8x6sVhQyZUhJBljl4kdZ1uUrpMRvzrcPmTqKOj
	JEDxqFZ6D+PZyO87OzQkpYXRQkZq4k6Qz4jreJmb6uwsSR7FuEQeVz+S2dqwF7M7j56MtG70XU9
	UZCMfxygsGCf/foMqYLUPw1hkOzSE=
X-Received: by 2002:a05:600c:3b23:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4854b24aff3mr568155e9.6.1773174256332;
        Tue, 10 Mar 2026 13:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4854b24aff3mr567725e9.6.1773174255920;
        Tue, 10 Mar 2026 13:24:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm140403735e9.11.2026.03.10.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com
Subject: [PATCH 0/5] KVM: x86: check validity of nested state when returning from SMM
Date: Tue, 10 Mar 2026 21:24:09 +0100
Message-ID: <20260310202414.406078-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMCS/VMCB state for a suspended L2 guest can become invalid while
the L1 guest is in SMM, for example via changes to the eVMCS or to the
in-memory image of the VMCB.  On Intel systems this can also happen via
KVM_SET_NESTED_STATE with KVM_STATE_NESTED_SMM_GUEST_MODE and a
corrupted VMCS12 image (kvm-amd.ko stores the flag in memory rather
than out of band, so it's not affected).

Because of this, nested state has to be checked for validity when
RSM is executed and would re-enter L2.  The existing checks already
exist as part of KVM_SET_NESTED_STATE (the other "not your usual
VMLAUNCH/VMRESUME/VMRUN" path that performs a nested vmentry),
so extract them to new functions and move them to the leave_smm
callback.

Paolo


Paolo Bonzini (5):
  KVM: VMX: check validity of VMCS controls when returning from SMM
  KVM: SVM: check validity of VMCB when returning from SMM
  selftests: kvm: extract common functionality out of smm_test.c
  selftests: kvm: add a test that VMX validates controls on RSM
  KVM: x86: clarify leave_smm() return value

 arch/x86/kvm/svm/nested.c                     |  12 +-
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/svm/svm.h                        |   1 +
 arch/x86/kvm/vmx/nested.c                     |  39 +++--
 arch/x86/kvm/vmx/nested.h                     |   1 +
 arch/x86/kvm/vmx/vmx.c                        |   8 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/smm.h |  17 ++
 .../testing/selftests/kvm/lib/x86/processor.c |  26 +++
 .../kvm/x86/evmcs_smm_controls_test.c         | 150 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/smm_test.c    |  27 +---
 11 files changed, 247 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/smm.h
 create mode 100644 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c

-- 
2.53.0

