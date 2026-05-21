Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1967383320
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358656; cv=none; b=ZRFvaD1RqsiUhJxSC97eLo5ql3S+Mzha9nuK6I2e74Sq88QrQt02J2iMd3PT81U7rNau9y8KHHO96f8L+3tnHF/e/ZAECosLPb9yqbAzObdv4NnhAAKzEmv9qN5MwpXWDqybiR17QihhUIgqDwKo0l2W7ksGVEIMGb8VgLoUW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358656; c=relaxed/simple;
	bh=om62lwyjnfBnjVBHsCckDGqEr6XydXu9RxvZ8V6XC3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0e+JvMeBES1+q1MJ0ym/jhTDUkPiFA6h81C2Wiqb6ca3FpSzSmVLDnLoiUTcz8k3UjnAkgF/qo1nsJDls3NyGqO2cw2jvfBx8Gx6H4WDSRp4O5cDPfqqsxSF2K0/5nF78nJYotDXprNXW5DJ+5lqZIa4f0CA/8H68yy/1yGmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeWNGJ4b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tjGMUq8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeWNGJ4b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tjGMUq8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M+kPlExxEWjdDobSQvNg/nmmUwrBjk73urkzkUE4yPk=;
	b=UeWNGJ4bNmLLXVQGA8L+/FK7wytD6hU3xaFG0Iy7IvqMlJ8e3HlJMRX3veOmkc/9HXO665
	tKj+ruztTVGzVgJ6+UpfjPF7+xzxFkMgY2D8EaCMWPoqq5wy6YqjEbO9uPpEjFiNJmAr9A
	nJh8aYOccj89sSDX2UzlzwnZ5gAUhFU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-d7hwdTN-NbajkvnSXegZpA-1; Thu, 21 May 2026 06:17:27 -0400
X-MC-Unique: d7hwdTN-NbajkvnSXegZpA-1
X-Mimecast-MFC-AGG-ID: d7hwdTN-NbajkvnSXegZpA_1779358646
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-680d4986ff7so6057276a12.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358646; x=1779963446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+kPlExxEWjdDobSQvNg/nmmUwrBjk73urkzkUE4yPk=;
        b=tjGMUq8pjljFpLVVMKj2qFX78I0lmX/a40nz32sXLWO7PidE4zPiZy0xvvhafvgFO/
         W0A6p+Nm7CMV3pTbhC0s+wmioM1uKUKWBcPrCAf2rfaAHOxJYBG4XaVIua9EAz/UGPk3
         qJ/xEhf7fFK+ioVOFLaR+oaos8yoStOI0AVVTs6Y55CWc+cOD18zu5jF7e0eQ+QEbdWO
         VviiGrl7lX2NOywczP3aG13rZK5xnFUqnP43siQB4PoKelX7tyzlkF6uBPcPPsghGI5D
         fzyLjdfwdV07Dq1bxmfiIFiBvQEN5pLjSqhAxpin6uaYAM1yR9zMeSlkPnRFNDWliSMF
         JjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358646; x=1779963446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+kPlExxEWjdDobSQvNg/nmmUwrBjk73urkzkUE4yPk=;
        b=DY0dj8wRpErSf2lJUZ1+WZpEpp3VFh4gBW18+/EE6L8elPP0l6pxEX7yC7Fd7xkbj4
         jiL39HiDnGe8+6dRGgcluM7hRqK1o4vP7gRxcUFkexjIQ+63rL+mP/E/oocn5TXR6xnf
         ixU0ROpb2Fje1C/IBxS2DEPs2DDMT+W1p5EssfYcI3xBIVmDc3nn+hycbF9Q4tCn0EwE
         Goo8m9v1KkH7q60kPuKWzINzhiNiFCoGakGg32QjNldnSOL2KVhrKHP0IGOUWYbHxvZN
         torodmJekbidXxVkjI1dPO5kRSye8/GogA8+VTBBJNSzE6xPpDgtRHXx/TyR8CposkOw
         ISmw==
X-Gm-Message-State: AOJu0YzE7E7TVCxwZ1rnIUu59I+CPECANnJGy/b1vXcycMEr/nHx4nIA
	NbQTZ2gA3TAnIgl8lexhmjnapRkeB0fl4Lr4tcaxUK1TSLwJZ9KOYol/I/VIX8W1OIe4ahEJJdB
	+KBW/pbsRlc92ecPte/ok3IskIQ+ta/Fy0jtm960Emb8gWUPNxWuAIuoMZ1qbNgNUO2qcEfPHaK
	QVudneacwkmJbwUT9vJ1JMa+DwDVQhsnHqHZa8jIvK
X-Gm-Gg: Acq92OE9BoRQvJ1ea4H/JOzNcJZswh1lDurL58Eeg0RBmalXAehgt2V/Q6SoNcB5vlK
	ZKaGHMi6RD5jQfJK0np7a12ZW/R2r5Rl8jCOoWza486Nraq6UwthWU8rxJACoTv8R5S8QopM/fa
	v2qutoRxBcZP2vOw4fjLErk2FolBEBBqR3mb/zOt6OzUbmy2cv/z+0Dw1xVGrkiaGqe4QzQTXIL
	yxG8/eGhC0W6vKDnJ7XuK09M1nnBcLwEGfVXPmX4GQ9VVcBOezxAgzf41qm917QPSy0BeQN7zSm
	EQQ7EiYKbxLnbdB9d0KyX/4iaF5QYK3BOPqoyfemccBEzPKDl2IHWEr+EpaR0NCpU+tErJaATIO
	vTAtcM5HEdU3s877eouNcziZbxWxbau2Iw9Rj5nSRYTdW4RLDO4QCMswRBOV8XVuWsKxCa2DDMp
	n+18ttQ+V4fMN6SDQgC8Y+dKr6cw==
X-Received: by 2002:a05:6402:428d:b0:683:9a51:306b with SMTP id 4fb4d7f45d1cf-68832a45754mr1072283a12.9.1779358645650;
        Thu, 21 May 2026 03:17:25 -0700 (PDT)
X-Received: by 2002:a05:6402:428d:b0:683:9a51:306b with SMTP id 4fb4d7f45d1cf-68832a45754mr1072269a12.9.1779358645116;
        Thu, 21 May 2026 03:17:25 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-684744d13aesm6334757a12.18.2026.05.21.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests v2 0/4] add minimal tests for 32-bit guests
Date: Thu, 21 May 2026 12:17:19 +0200
Message-ID: <20260521101723.101100-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMX and SVM tests are only running 32-bit guests.  Add a minimal test
that they can at least start a guest with both two-level and PAE
page tables; for VMX only, check also the case where CR3 is bogus
but the PDPTRs are stuffed correctly in the VMCS.

Rebased on top of Sean's regs rework + the brown paper bag fix at
https://lore.kernel.org/kvm/20260521092311.86030-1-pbonzini@redhat.com/.

Paolo


Paolo Bonzini (4):
  vmx: add test for 32-bit guest
  vmx: add test for 32-bit PAE guest
  svm: add test for 32-bit guest
  svm: add test for 32-bit PAE guest

 x86/svm_tests.c | 159 +++++++++++++++++++++++++++++++++++++++
 x86/vmx_tests.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 351 insertions(+)

-- 
2.54.0

