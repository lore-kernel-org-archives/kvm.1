Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587161;
	b=WhLJRnSVwaY/WIQqNzP/EH6ggVeHXn3+mBfvlV0F8Ak3C6GCSmHS+z+AEkus8euiB/5M
	 XmzbEQy6hZRFtm2HVlTVt4Adv42yVYExwJ6m6Htqy9ZbNQRsKRmIZ/tSCG5SB4Bs9DxKa
	 ez8pPOVVJu3WrfTFgqvMck0J3QCDwdXYkWyP0xStI1l2fpqlH9xlLywgg2F592T88Tz8W
	 VYX4h9iycIQUS/zcAV7nnd66IglTbVJSmjz6a6u5P7Q55TQbB7IDIVPW5gW9ZylJvaT1t
	 iHZm9gOoOLJbsD+NV0QNxgeMe8bzPf9vkmPv/UT8YSE9Uc0IEwxrfS/HdhkU4C3kUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GZ6f5D4ZsupQmpduex2pVghjzPIcHrDqNZlVzGqwV40=;
	b=3kRldibFh2waVNMquGhtESzhebhwgnxaOMes0bOzS2wIeZ3DRJoXEOj3ME7NamYLfhzm
	 zggoiWwlBHho4YV6mKEHGswndHEUJC7GTHktJ+9ayDWoHd8brFKnrP5KGzDgKGpSgJEUm
	 rnlYDCwCc1Gir8dT7YtULBW84DeYy4RIWPgdaUG/OCdYIGSU7CVk1KXLzhJwAiu5xpr/I
	 m381+92mF+xQXPEKr+07eeaQMWyE2wAmfB2LgBZBRAXZQyeewFZIb2RphPA1F7Zax1AmJ
	 ZN1qOwBAJ+gHOOx1cf+zsQsOFrveROfP/mgARp1v9gI25Jp5ycGjnU96S/QVlMgZ9EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nEjKJlZ1;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE27606A884
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE27606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nEjKJlZ1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so1185010a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587160; x=1795191960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZ6f5D4ZsupQmpduex2pVghjzPIcHrDqNZlVzGqwV40=;
        b=nEjKJlZ1JgWD64WbJdFiIqM49Qj0M+pBGto6I0UCMRBRMoK0E8DXLO2UjyTnx3Cy8A
         U+wcCi6qryr4ftL2193yBXjYwXEr+7hSWZcgyVGEVhRdfNGO/wRIijeAWQp3PoTD29/I
         iVA8975nLHbJgUOHKI9qGgs29bi0Fjpk6Yh2I5raEhiix7eYWtMiiehQa90k2yOr8scf
         7g/Hc5nNDxU9RKYq1Mbn+jNc2lo7fOOFN1neE4d9j5vls8ROSRPI84/wv/UGucsbqskn
         4zJuYxtcXou8ofRiCbfBIPMtQu2YcZ44NdVP60m/28WDXrrROC5bJUZwGX52bKdDL+sr
         G/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587160; x=1795191960;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GZ6f5D4ZsupQmpduex2pVghjzPIcHrDqNZlVzGqwV40=;
        b=WkFGWPspYWrqE3lVnJ2OhBeQVkWD65FR4LxlbpGIQ9NX441QvqxTa4Bk7+KrPvAhh3
         ZYAcS9fWymUJr6zJHJ7e5ZTEbddxEXi1IHjf+nRgHVOzMv1O3YKgx5NoWqtzcval0eM+
         XY0A3wwuDeabGJ3jxZvfLYavTX3+7U6ua0pNjq1JfbLY6lcwuRi3rjdGD8/EFWdxv1c+
         gIPRdP6rg8X/5QPHvVUxLizBSWU2Jh9OwSQzJSmq5RD53PB4VMzVBk0Ix1a+Yw4z/tsC
         3vZIpQOxk/6qAcczD0xkv5ZM27SQrh4RF+Dv03mNCAWUVWBL3sczkfwd6Dfsd51KZtcd
         0Crg==
X-Gm-Message-State: APuU4Z+1fXzNT6EbkBD23BP1BsWXiYebVHT4pzrPkHZYfCpfNmrU/kr1
	hxkcmHJwOWtj07A0RDMJ2qBtawkfslJKUqM8arHMjykUoZcRJjfAcWZ9fMmjBf7ATquv/7tYQKP
	VYYjbBg==
X-Received: from pght24.prod.google.com ([2002:a63:eb18:0:b0:cdb:8e32:f9c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:67c7:b0:3ed:b2b6:9bdc
 with SMTP id adf61e73a8af0-3f7a81b6293mr3098328637.54.1794587159785; Fri, 13
 Nov 2026 08:25:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Nov 2026 08:25:56 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113162556.461390-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Sync CR8 to the local APIC after marking the VMCB clean
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, Stefano Garzarella <sgarzare@redhat.com>, Chris Oo <cho@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Chris Oo <cho@microsoft.com>

Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clean,
as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPTS
as dirty.  Clobbering the dirty bit can result in KVM failing to detect CR8
writes if the underlying "hardware" uses the clean bits to optimize VMRUN,
e.g. when KVM is running on Hyper-V.

Failure to intercept CR8 usually manifests as hangs when running Windows as
L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQs.

Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept on =
PPR update")
Cc: stable@vger.kernel.org
Cc: Carlos L=C3=B3pez <clopez@suse.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Not-signed-off-by: Chris Oo <cho@microsoft.com>
[sean: rewrite changelog, massage comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Chris, as mentioned, I need your SoB.

 arch/x86/kvm/svm/svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 581bc3a23c95..3152846a6ccd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4726,8 +4726,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_=
vcpu *vcpu, u64 run_flags)
 	if (unlikely(svm->vmcb->control.exit_code =3D=3D SVM_EXIT_NMI))
 		kvm_after_interrupt(vcpu);
=20
-	sync_cr8_to_lapic(vcpu);
-
 	svm->next_rip =3D 0;
 	if (is_guest_mode(vcpu)) {
 		nested_sync_control_from_vmcb02(svm);
@@ -4758,6 +4756,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm=
_vcpu *vcpu, u64 run_flags)
 			       vcpu_to_pmu(vcpu)->global_ctrl);
 	}
=20
+	/*
+	 * Note!  Any action that might dirty the VMCB must be done *after*
+	 * marking all VMCB fields as clean, e.g. syncing CR8 can toggle the
+	 * CR8 write intercept and thus mark the intercepts field dirty.
+	 */
+	sync_cr8_to_lapic(vcpu);
+
 	/* if exit due to PF check for async PF */
 	if (svm->vmcb->control.exit_code =3D=3D SVM_EXIT_EXCP_BASE + PF_VECTOR)
 		vcpu->arch.apf.host_apf_flags =3D

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
--=20
2.56.1.703.gf848ed807c-goog

