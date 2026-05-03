Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD1313547
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839432; cv=none; b=FNbF23hGdbVFd8JHL4B9tr5wki6sMrWan2UsGimfE22znnQYcBpVPvwJUVqN0X6i712F9jLekr824pdp+U03w3yB4U8aT0F4rcZ++QLRwzCA+DT8GjbSX+np5WXwzCSl/pFG3e4KuJzy8MhO4A6dk3QZRjus0S3XEF+/FpW9rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839432; c=relaxed/simple;
	bh=tg5C5/C+EqqVBA24JLVvLf416DUebNdTAsd+ICZc32k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3X+vmdkMrJoOHoY2+bLdrX/60Kiw8CGQ9WegkWHhNQKWReYmtOzJCqkFvWyv2TpBo3/ULPCr1SuZtc7JYj2frof9IRbvHo+vSu3n1IG/iFP9fzTOOMht1tB/lSnzJmg6b3jDYstF7OtGiIRjFa6H+uHWCsiOQoVC3qjncfoK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAQ9wVFC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT4ugPUX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAQ9wVFC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT4ugPUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BFJt93VKfRQVJsNnrLhXt870S2R7gt8sYQHY+rSI/RM=;
	b=eAQ9wVFCXdqu4NEyMlsT0+WmKkz9m5EvZRUttSI3/eY3pwzqBXaxX//Rh0w0UZd7OiQzac
	8r3CrR3ddonYXx39ipVw54aCmyejLcdPkdLaULySbfYPDxleoT8fE7LvjgX54jg5jIwzDF
	pC6VvalrAB0CdquRtI79hsSq8Pc9r7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-TMRvOlHyNNKUN_T_tAAxFA-1; Sun, 03 May 2026 16:17:07 -0400
X-MC-Unique: TMRvOlHyNNKUN_T_tAAxFA-1
X-Mimecast-MFC-AGG-ID: TMRvOlHyNNKUN_T_tAAxFA_1777839426
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a9592f666so8497295e9.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839425; x=1778444225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFJt93VKfRQVJsNnrLhXt870S2R7gt8sYQHY+rSI/RM=;
        b=jT4ugPUXIwsowh4HOS/aTT4QzzUeZGC1QIelrUhsDHDhg0yyk9PQPu3QghVdGNZRbV
         ObLQC9/6jQN2NNHfREqWOPHAw1E9AoTtkKlMtpV5lrGn2jdz5/j2mODg1rGdsAaucROp
         DNOH2irF/xztjZDYewcHptu+bXOR5nc2Hsg5ZfbNCABZSFdC3anqizKj2nk7GKcXm5SY
         GNXhh05FAtrNsBYhkhjJARWDRLQwBF6nwz9Y3WgIWkKD5SQZqjlrLfP5NMjmxdldQLhZ
         FEoP5P0XXCkOG0JVuGHfBWJfxvAx9Iveafv148TLrnimjipO5lrlDeJKvt/lmcnZENvV
         Hgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839425; x=1778444225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFJt93VKfRQVJsNnrLhXt870S2R7gt8sYQHY+rSI/RM=;
        b=snuIgGDHeKL7HEM6CNPbDaw88FhAu3hvrkmrc9vEoCoZbVZR0xUauucDMEtO7ndBx+
         YxsfKLyIsbVgCN0lbI7anNZvagmIMvEijwr90MTe5fYLqS7HJRTxvvxdIUwHZd77eu6/
         A9GPtFzQlUdWQz85V9yAc1FNIndSWmbRhQvwqt5sSUDK9D1DKBEFAUSdoQLJLU92LkRg
         I0NoYJse6qK4QU/xfELJfPyaWnmi1Kl2jUvV32OTlWXSbihqqXT1DUD0EFw5BxPtf+Rf
         1+pSyPk2JElP9OamKBO6vyxh0hgjKs2nPMhMrlURcJbyzRO5u2vIUIPTgQcGHnbTogQS
         bDlw==
X-Forwarded-Encrypted: i=1; AFNElJ8LRne+iIbhrUkLzHGbwySFSXuf7iwAmVBRVJe+qz7gr3bMstECj7YhskYZ1Aww0uLeiF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7K6c4sf1c53mAygY4RCVtm/U/ZvVOvZsHNbjmwgSQB6FLup5
	WYNRS9oOo5m/RShkcalqc9e1nB0Nsxi5p7QncmmWfElLP4wm0snQKfPTTRn89xWQOBITYaOJCcF
	bynOWn09uAz+jjw0oh7BseZIxy7VXvsVX94lw5l3PmF1LjRpwxTU5mg==
X-Gm-Gg: AeBDiev8Ov5syQmoj39GkD71Htb9ilaJQnRgYxIbPDRkXFBz+PKs6rDgU1jZekGIS0C
	yYyTby2ls+avG8wwiemkw7OLjnq2XHecIQ5IMiFR9SHWTWcACtJZ4i/LIB5tOjtxB6PSeghDk7f
	vFJ7pEwWhU1hSx8jcnvA1Ktxfbr3dEbaIaLiYsO2O7aEXsTVBzm/CjhuTL2Huwx9ZHnxHTRLb1+
	+GNNBZxdVR8pbUeIA65rchkL+JULmQ4TSRMjSE3mnKYvgL8g73FOhGM4Fvpf7uxmWqIoa9sypDD
	LyYLjx9L3o3a0yZytyZLa9oKufvMoBiGQnmApaR/S9uCByL9X6/1+MHqyXpGXJyKejjaz+JGj7C
	36ywUr2PlwVqkh52S1VMllI/y5s8QMovs8cG/F4RyNMYx1oYpnu1z5p8dU/7yXeZhQ0g6V48Osj
	1+HOFXdJtI/Aj/2TcVBnf49DhtxDwNyYqDbDM=
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a98638a65mr80712305e9.8.1777839425596;
        Sun, 03 May 2026 13:17:05 -0700 (PDT)
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a98638a65mr80712215e9.8.1777839425248;
        Sun, 03 May 2026 13:17:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm463374905e9.13.2026.05.03.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:17:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: chenyi.qiang@intel.com
Subject: [PATCH 0/2] KVM: x86: Fix and clarify PIR->IRR transfer
Date: Sun,  3 May 2026 22:17:01 +0200
Message-ID: <20260503201703.108231-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a WARN in vmx_check_nested_events() due to
a specific interleaving of vmx_sync_pir_to_irr() on the target
vCPU and __vmx_deliver_posted_interrupt() on a sender vCPU.
In this case vmx_sync_pir_to_irr() sees an interrupt even before
__vmx_deliver_posted_interrupt() sets PID.ON; while this is harmless and in
fact intended, the problem is that a later call to kvm_apic_has_interrupt()
is incorrectly told that no interrupt is pending, just because PID.ON=1
but no bit set in PIR.

See original discussion at https://lore.kernel.org/kvm/20260428070349.1633238-1-chenyi.qiang@intel.com/T/.

Paolo Bonzini (1):
  KVM: x86: Do IRR scan in __kvm_apic_update_irr even if PIR is empty

Sean Christopherson (1):
  KVM: x86: Fix misleading variable names and add more comments for
    PIR=>IRR flow

 arch/x86/kvm/lapic.c   | 24 +++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.54.0

