Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868238;
	b=NdSOOn4NyTxSWhXq8Ko1pAIe3oodMUT9hL33lFXTiyJJulUUBzJ14/+FAE7aWroVXG/S
	 CeJWogz6CsTkh6NEwMSppo3fVCyhClBJ141FvPQ/58UgViwqrB4N8AhNzAIlE2VEzJ7WS
	 GfIAhN/lcT1u+dz66D/F9qmIPOEbsaTLsSx/3Ymf/5F3SL3e0sf4ZAKJNdvKCQKnA5nol
	 K5LjjaUmVQRKE7DJ7nVLQH+J1drlV8/E1gcc+6dfPW8ytHswphnt1K8j13oxjFsiBr/8p
	 X55iY75lzGH7LgwzUabLOYf7NkiiCWfUhfwHLa3qAVzdmdLb4TC5IN+X2U8qFMHksWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C0gexXoY+SLiE6S59pTDegfKVc6UD8M7O/wbYmXheC0=;
	b=Nt967sBYfozxfRV+ANNnKeukyfl4x4AP/Px31e3m+frCYQ2XTyLAwh03P12kIURDF0SH
	 0bP6iBMcJbXkfy9aoY2N4M6n7qyIjZiDa+XtsMbNAEcn0THUIHhr4kUq4Z+6rk5oYjsss
	 dgCWAcc5+31XmF2eced6Ps/lDziOeOLvKvO8wdzpmQtGWux2QhXvOYUkKk/AXoKgnmJT5
	 U8zh6ZPn7r/zx9Mreaj/C4CkVJ5qnpc0lXgtMW4S69BTLCqrbtSaEzdfQXsY6UAygoG0z
	 o7eaLcytWZhAUVx6ym9dO4wVnkYjMvvAmOq8WQYWtFLlzvwof5xS7/qe1U+8sjS0RzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X+VEt9v;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B753606A882
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 22:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B753606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X+VEt9v
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1557652a12.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 14:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868236; x=1795473036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0gexXoY+SLiE6S59pTDegfKVc6UD8M7O/wbYmXheC0=;
        b=0X+VEt9v3lkfg3CTHkk2K5why3V7N8328n8SLfJtO+t27n3Wy9a2BTqHYU2qiWfdV0
         oiL+xNWie+Tb/c2TCRzMb3wsfHnvom1+RuaNxKF0mUMHCG90X6ygaysAkRehBOX8l6ic
         x/+GcVGvadXmaQ/YANAoesBcRlABXBGFCiqWq+J/63NFkqnHHTtLnHTJP6AvWCR1nLZt
         2jQyur6uHqsFCXV29VDfGNaBcBSN/vw+qoH/GsFQJ176UBsE4qorWl8gjTJjZRqoLZiB
         hVcS1e8l7bjoo0WUsyscy9GdwsG7ht+d3EmeJFtelhg9Ay4jTMAfWppT2k7evyK2t4OE
         PFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868236; x=1795473036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0gexXoY+SLiE6S59pTDegfKVc6UD8M7O/wbYmXheC0=;
        b=IWFRrty/Ku4xlm8Srwb0LdRVHWb+dZwxlGOQG9hUPdBqdPELo0qjeqykhZm0mlwMHS
         Sw2HfIapqq8lF+2bc9VAoD6KtqhWBHETOD7/Gtteh5+88TBHSKGizDqvPEsewYhRyzBS
         h9B6pyBE83y5ZMgNe0HWrQuM4L2lMMXPhlUzFt8ymwaRLlgg49EEf2TtBLHcV+L6welE
         i5mASawuUkx1LNNJTemCgn/z1TdF6CYqTfe4dPRtdKxyCe/VIPGfbNU0CqO3VeFKYJ+I
         VzuSpw4GfF/Tf/s4TWYVtKBI48eEayo3dRMCNU1R+ugId7IC8ECwoN/b3XSW2fPKkdVZ
         DvbA==
X-Gm-Message-State: APuU4Z8sJ1n0T2H/EQEZ08yXonAHlKHofWJW/mv0mOESEqJ/fQTFX+uX
	b8Br1DI/eCmjFlRIkjH0rX9j7h+UqLeGKIw5xBC3rtAwe4sPCxhaRLm7
X-Gm-Gg: AZFdTZduSFyZQN8yrS7+lYsS5HRWW11kDwkUxlvDU73O1Qrv258L4HoubmEBXeIIxhy
	ozcGQNMeWmbHbbZQdG0wUUwxjVoOhNBj3fOBK4wZ/gOTz1l1iQybLSezwqY5tWOGFl5sRHNfBr4
	nqHR+sYm7qWuTR69S7l8P+/x78BUToC+xjex9G2KQQVNLL5AUqNsdqCrnqg8M8zjvTGQ3O8qMdC
	TQeZqxvBVj0GMpjN9styZCdFidX5xQ9GjkDkkToTKy/w5POntWfMjrEsbFfAYXhrEqdG3P1AFcO
	IWzWGAjZH9IelgMtvZPEMl/XUt6JFErbuSLpAPHltwrgWSst7AkxMi5gfQrypsuZxO7EsUBbR8X
	u8OCi2QlSwJ5PEyRsvg0PqauY+gIZ5qf9Rw6PjSWCPEgm8JrfdHUM6cvN19HgmI+j00URhFwdi/
	YfD+Qufh0KT83jYxcGvShDWlWCj5uDW4LJi+OuSrshHV/sPhIkBAe91cRR2Z5tFPgjVm+3qL0/y
	riH+AY+oxo8sU7yI0tvqhyXUn2a/ErlJ8xM1qNNn+ELnqDk21yVep9z7gRHbGyPiD2Iv9Uvfa1E
	4HAv9Csp094IQIRYGxWnJq7zWJPgB031yFUY5VMFe1F73fzpxubKHiPwD0emtmpIonKJmk84/r0
	1qVMP3D0OvpWZuLsLM2ImWIxjXHzZpbrlbDBGY0pBnqleFnsZ7ujCF6Ye+tFqke8mjT5j0ctD+U
	BNBH5s+5COfg==
X-Received: by 2002:a17:90a:c110:b0:3ad:93b4:718f with SMTP id 98e67ed59e1d1-3b1b0ccda1emr9629636a91.65.1794868236231;
        Mon, 16 Nov 2026 14:30:36 -0800 (PST)
Received: from cs-arch-srv04.cmpt.sfu.ca (cs-arch-srv04.cmpt.sfu.ca. [142.58.10.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm944375a91.5.2026.11.16.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:30:35 -0800 (PST)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 0/3] KVM: nVMX: Don't clobber VM-Entry instruction length on soft INTn exits
Date: Mon, 16 Nov 2026 14:30:30 -0800
Message-Id: <20261116223033.3866283-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM writes the length of a soft INTn that L2 was vectoring at the time of a
nested VM-Exit into vmcs12's VM-Entry instruction length instead of the VM-Exit
instruction length.

Patch 1 is there because Sashiko pointed out that prepare_vmcs12() overwrites
the VM-exit instruction length that vmcs12_save_pending_event() saves for soft
events.

v3:
 - Rebased onto kvm-x86/next.

v2:
 - New Patch 1
 - Same Patch 2 from v1 (with commit message changes)
 - Patch 3 now extends nested_exceptions_test instead of adding a new test
   (suggested by Sashiko).

Mahmoud Abumandour (3):
  KVM: nVMX: Fill VM-Exit instruction length before saving pending event
  KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft
    INTn
  KVM: selftests: Verify nested VM-Exits while vectoring INT3 and INTn

 arch/x86/kvm/vmx/nested.c                     |  6 ++-
 .../kvm/x86/nested_exceptions_test.c          | 39 +++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.25.1

