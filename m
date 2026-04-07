Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF4387354
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584882; cv=none; b=Edr/JXaiSg3760BreQkPHB/pxioCp4UYCaa+jOr2H9R55CxSwgTbt8gRWNFwsaQD1/N7MfX8jPtjPvjLVlmZEXXjvy1d1hvXrI5WIRLhEDWgq7ZYpFIqocn2MpD5Oiz98vKAMNIcUCbVDLBEU45YyTTppBOUr8i3Jt1kxvb9fMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584882; c=relaxed/simple;
	bh=Ig6ui/9Zd4Zwo9nawdQ8zMjEH0FlUfcIiXPW0/Rtlls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRDh9oqRWI73RTw2JCwvqveS4IVcsmkTjFQToCKiFhTlkrGxEIurFnaTZUPqvKaiw2UMJsFh9qI964WKS0kcenbwtaZ00bSsIqe4K4luhd8P0IPEZmwscjkYK6ZcDVmginJICMpL3ehS93SVAarzY0lX/+TZBBgWdW29Ws0Yjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJOP/dn+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1di7ySc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJOP/dn+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1di7ySc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EoxBwdftF7ZHqM58cd4+7nkJVXRUJjxP6QSRipaPkEY=;
	b=YJOP/dn+QkYm8uXMfrnbfn84Vv6IDOuIP94F2xBf0dLKzyEMAUIORvftDSk33aaxn8pnFJ
	LeTnp7NrrrX+CNHxEr7w2+VpusOyz1xJvFsN5W3hZGUqQlMaZkdzzdQqLHcvPUsfALnyCH
	GabMbr0j/h833P9LRKTUe10dqeGsy3o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-L9aaIJU-MaqLzKURIQY13A-1; Tue, 07 Apr 2026 14:01:17 -0400
X-MC-Unique: L9aaIJU-MaqLzKURIQY13A-1
X-Mimecast-MFC-AGG-ID: L9aaIJU-MaqLzKURIQY13A_1775584876
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488ba9dc026so8927155e9.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584876; x=1776189676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoxBwdftF7ZHqM58cd4+7nkJVXRUJjxP6QSRipaPkEY=;
        b=E1di7yScjPAjN92oCkzc2yo6q4GiwFwEuDzLjrGmx0I9AjKBxtIFDoaoVfJutnFhPG
         ji7HwJcHu+yeIFEO2auBzinyPPI74kxsZ1n32tju38UwshdhhRFij+SJe28eiUwZ/oPu
         9bftCjaMd1cHRsE7BHspd/RttmLQBo7CN0wsLP66U7MFmUaryKjunm5FIorAoc7RY3Vc
         2mX5Unz5SLJ8oNQ2MYxkmkuu7FMYO4w2TmwL3pVkteJg3aCOrlyUFHgCbdCMPQspVvKQ
         FuirTZ6GumRf3PLNUqD/uoEcxXThH/i4xV4C3T3mjeRQ318lpNKthcgiJnC+9HKbV1wm
         +XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584876; x=1776189676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoxBwdftF7ZHqM58cd4+7nkJVXRUJjxP6QSRipaPkEY=;
        b=hQU4v7jsPm6MNVfZqKXh6CZQsXrw9xIhETAywcEvpoXZHKZSNbzeWTvnbL0AuBA2Ws
         E50nfjR5GxZtaxMFrMHqXLPfdjwzH2kZVj5f/0mJj3UGmw5vaPyHND23USEzkIOhi8g0
         qps4LbcpKV5nPx/JUpllw5Y5sbomuocdBzWQ9ZTJJ0YL2rNB5UYbqH+/c5/8AJ6vR5hA
         +6XciTvWdao98CUvK66Otk8xk2N3XjHqymGSPIYUd2rhXFXlTv0hZxfzdc3bqwWe1nwO
         8/NWZhaYv8fTUuOtt0fIE8lGxKOK+ByDRC0w3fizSjHaaCMh8odcXYnGglUpnFPHSjwt
         X0eg==
X-Forwarded-Encrypted: i=1; AJvYcCV+jWCToHXLFasCABeJv4me/OfkjJH83oAMuSjrhv2wArmqD620YH9K29FKTv41mQHsjjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBF2DDsTsj9kEuAlcpi1nU3077qidQJZ5l0zer55MwoQ1ARvPY
	Qq66IbqZ0uepztktUOB78CAUKOKT1A4ZPBMpEUGCiI2Flbc01KWjKFzzknuJLKVEAvipZyoJplL
	hjmOzsGi8mHxukPpYcG3vpC7AXZ/g1ZXIvhTUkqzjXgmZut5USLNghw==
X-Gm-Gg: AeBDievofGk96tlkgP2AC0bs4PlkhJrY+pQ1DDQE/5V5oVoJm7juXu444icfkNDkkD/
	9+QzYXaWlKS3y0IklYiwiHofRRELDtN4PZZrCpAU8O3U7QP+IlNYc2ALwxf44NsAkX/3SSnNLXI
	L2gZVbhI4nGUZwWbHrKL+Ngl6tSBPjCyQz8I9Pm5Y3pOD8eyMqflt9w2WpSJf0cCUjbyeCuGt9O
	TyL9ronVqfEmeh1/dlAFT6c0iThj3uzDHvA4bmKXQI5uLF87lpm0W7ZfKCuflB4j3QqRia/X4ax
	BUkAgYjqVCruDkaXyHL047rgpNSwBMf8KcT8jg1qXA9iqDCq8RoaBoH47jdyQns00iatDJCVh/c
	X9FiXuiUZwzdwsJg21IZPt0KbaiPGTrgJDK/W9Y8f7HvBPFYkPKvruu9CrvVo91Xz2/IpctYXfR
	hR9esP+i6f61vYSat3/QzzHrBA
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr273887655e9.0.1775584876224;
        Tue, 07 Apr 2026 11:01:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr273886975e9.0.1775584875698;
        Tue, 07 Apr 2026 11:01:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c555a6d3sm1510945e9.27.2026.04.07.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:01:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: [PATCH 0/3] KVM, vfio: remove exported KVM symbols
Date: Tue,  7 Apr 2026 20:01:04 +0200
Message-ID: <20260407180107.1603697-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM right now exports three symbols for the whole kernel to manage
the reference count of "struct kvm"; these are used by VFIO just to
keep the "struct kvm" alive.  This can mostly be replaced
by inlines, and in fact the entire definition of struct kvm can be
made opaque to VFIO.

Besides the cleanup of removing the sort-of-deprecated symbol_get() and
the bidirectional dependency between KVM and VFIO, this is useful for
the recently posted support for Arm VMs on s390.  In that scenario each
KVM implementation module wants to have its own copy of kvm_put_kvm()
in order to call the "right" kvm_destroy_vm().  With multiple modules,
VFIO has no way to do a symbol_get() from the right module.

With this series, that problem is gone because kvm_put_kvm dispatches
through a function pointer, set by whichever implementation creates the VM.
The main issue is that symbol_get() was implicitly taking a reference
to the KVM module, and that has to be preserved.  This is the purpose
of patch 1.

Thanks,

Paolo

Paolo Bonzini (3):
  VFIO: take reference to the KVM module
  KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
  KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio

 arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
 arch/x86/kvm/vmx/nested.h  |  4 +--
 drivers/vfio/device_cdev.c |  2 +-
 drivers/vfio/group.c       |  5 ++--
 drivers/vfio/vfio.h        | 15 +++++++----
 drivers/vfio/vfio_main.c   | 51 ++++++++++++++------------------------
 include/linux/kvm_host.h   |  9 +++----
 include/linux/kvm_types.h  | 30 ++++++++++++++++++++++
 include/linux/vfio.h       |  4 +--
 virt/kvm/kvm_main.c        | 34 ++++++-------------------
 virt/kvm/vfio.c            |  4 +--
 11 files changed, 80 insertions(+), 80 deletions(-)

-- 
2.53.0

