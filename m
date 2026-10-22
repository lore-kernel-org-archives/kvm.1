Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635150;
	b=y97RKRZwC7VnVdgXGRBXbbnmkq0YWqXn8waPPqq0R7Boh6PB3LJfco/vR7gbnjYVXioY
	 PpT32JrZdq2pkpiF1BA8sTEvCVHLHuTtYqAm181HD4It00gB+xt5GRKuQYLO5nZZyt5qc
	 FpRUSqVwBm8ZsjhURKvBgcsSX1WTs5Yb11WT4HdY/h656LLB/Mi2jN2r0OUcvMX9/TcLK
	 VtonwPAb0vstAt1j/e4jI6N/VnvFN0XpMnc9edXDIsfs5HbULfJLEMzC7HO3FI5ShjwMo
	 AkpFJn+fnNrYY/VQNBAuzkvS3uW/z4C3346ysXDwrvy+tDem1uy6hONdtaVhBQBIsGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=F6RPqsYmIYaB9md8HBgOWfKW5EE+1fjGEEB48wFSvxw=;
	b=VtJQEU7WKFjXbNMryjdXIiR84Q9yO+zsXQH3YqVJ99aaUc3GC/CdcNdAW12umInHuoFz
	 D2dEw8+V84mxoqJVH3qJkxDaYbSx1PieZIUYR11/f6/So8002zSNbJB7F56GIw5/qOTDY
	 3DxZZxNCiUA9CB7obj2b7lbC941JtZ3CXn4WRdQRQ+8HLlvl4lSzPk/vJjBzCx+ArAxJo
	 Ydmq1qTcpVzeFfQxkCvbDqcF4rjB9UZa/n6cazDxp1AL3gVqP/w6EzzXDKznEG/S53Iyk
	 +/gBqbbXqkfgKvVn0sowW/ZRstPBnwVQzrmrwmukunr2fT2xAEFPJYKd4LFlRka4JQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jWP1mS3Z;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D1606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B1D1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jWP1mS3Z
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so1401787a91.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635149; x=1793239949; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6RPqsYmIYaB9md8HBgOWfKW5EE+1fjGEEB48wFSvxw=;
        b=jWP1mS3ZrEbM75axaIPKuXagPBAwhfk+cKUThFGFMqaFKvj/Bk+1epwt8bEpBH5iQQ
         L4cdx79QORaDBSoK0yURjjS/uP6O37oRUJAeV5ZX/JcRtV9X/vpiGWJYtpPfSeyo8a9k
         BsE4uwkyI0MZgViooR0JZHuzo8Q7dbN+AsjxAa3kMu/mwmUpjda/n0Gl4ND9WWPCStXl
         NhY/Z01X+p0Vnb+n847p9frX94pj93zkAhJ6RFvBt8K8e67gDpQPbWNvZc83qweKFx9n
         TffRb4m9iIx+wptS4cI9m9Jy4We4BkFmLlDEmPpzlUYrl/hSKnaktQItKsrqY+oeuTJz
         fEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635149; x=1793239949;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F6RPqsYmIYaB9md8HBgOWfKW5EE+1fjGEEB48wFSvxw=;
        b=syzOwu7GKfcjx1tVMxy9GKqRzSmzYILXGYiVqfvlS/9GIpL//rb6U29rJVYY55wTM4
         Kj6ISG1D0FQL36evuKs3F4jtNc9JBCfcVJj6LUQ8gonBWd8r4ZfH40wkmu7ciif3r7Pm
         apkZ7jM+6XbqB6Fo+Z69OHuwp1UbZQQg3ANYP897kIKOLV+hp0WK+uaWAA1xDxzsDfUp
         NIdWRt0QdCj6mxA88vTGPI7NTzxwTkBCGBM/PrmBekA47gA56HH0eErN+7wmXefgcohJ
         ifszTIrh5OACdjRUp6zfUppInsbpHPozkfaljolSNdWv3aBWsBp8oemlrjuEdyikLshU
         6EJw==
X-Gm-Message-State: AFq9FYIFsPgWcL/3AgI9G77m8g2L+qJSos8/uvWhuHDlhmGeApL1rb5s
	UcUPfzX45EbJoAqzDnSCuX3KxELCJdlDDpRUMHm58Oj74BZacUnwxdEZ7SVa1myRUGFn/w/R+zp
	Q/udcOA==
X-Received: from pjwx12.prod.google.com ([2002:a17:90a:c2cc:b0:3a8:cbf9:5e52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582f:b0:39d:efa9:cd1a
 with SMTP id 98e67ed59e1d1-3ad86b0bc8amr3360752a91.4.1792635149221; Wed, 21
 Oct 2026 19:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:12:27 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022021227.295495-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/hyperv: Explicitly reject VP Assist Page reads if
 cache was clobbered
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

Don't try to read the VP Assist Page if the shared PV EOI cache has been
reconfigured via KVM's actual PV EOI MSR, as trying to read 624 bytes of
info when the cache is setup for only 1 byte will trip the sanity check
WARN in kvm_read_guest_offset_cached().  Ideally, KVM wouldn't use shared
state to track the VP Assist Page, but in practice no sane guest enables
both KVM's PV EOI and Hyper-V's Assist Page at different addresses, i.e.
not allowing both to co-exist independently is "fine".

Fixes: b63cf42fd1d8 ("kvm/x86: implement hv EOI assist")
Cc: stable@vger.kernel.org
Reported-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Closes: https://lore.kernel.org/all/20261017093016.32348-7-amirmohammad.eftekhar@cispa.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..c08eeaac8bb7 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -949,6 +949,15 @@ int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu)
 	if (!hv_vcpu || !kvm_hv_assist_page_enabled(vcpu))
 		return -EFAULT;
 
+	/*
+	 * KVM reuses its own PV EOI feature to emulate Hyper-V's EOI Assist,
+	 * and rather stupidly reuses the same MSR and cache storage.  Treat
+	 * the assist page as inaccessible if the shared state is configured
+	 * only for PV EOI's single byte of data.
+	 */
+	if (vcpu->arch.pv_eoi.data.len < sizeof(struct hv_vp_assist_page))
+		return -EFAULT;
+
 	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
 				     &hv_vcpu->vp_assist_page, sizeof(struct hv_vp_assist_page));
 }

base-commit: 814607cd40df80d5727957adaa857e0feca43497
-- 
2.56.0.218.g1ec904b173-goog

