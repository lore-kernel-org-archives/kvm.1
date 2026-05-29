Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36153FBB7E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073498; cv=none; b=ANBmRINeJcjZ6AX1NboKYpbGwojYRf1mjlHWPI/pFCQfgSpYaIn7fD83FipKKmVLFhqpYyyyxyo1OwhRz21t7qFk/50M6ke8x0+oy1dnFNtaB2I22vNC/Qe6YZpUWsn7QJrPQQMHwDobbpnhOHMfdA7v8Wo4rtQislDV25ruPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073498; c=relaxed/simple;
	bh=sxiylftm2Xrx+BcnKKefzVgCGCX1y+gcVBkU3gV1EsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mjFrMeXIaQdUhyrfnZ4IVaOcECJzUn2PWP7jLEAEz+5S8IL+5Qcy9uCjdHt8SJ46V7V1Mn1p+j5biyg5m4sx62EexRVWwpB9KPHeMa+qiJA+pV6H+AYXowcATdqBsYVgZoiDFFBFzOS1MsCBgP/9QbLR+38ccT6DKfFB8W9ljzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHDNgvdz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHDNgvdz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so7261964a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073493; x=1780678293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6jFRO5B5gIjR7rsGbbPkzABaqNE8Q13YLBC9Ee7R2t4=;
        b=PHDNgvdzhEz6j+GjOJE2sfVGto1xoIsb29B9+KJXeyrOkcz3T4TCMRRMNgpREqh9MN
         7vU7K8uNKIfKyiTpRux8n/oN42HcGHW6cM+/JbgxcZixYBJb2CjSt+PFTlkj0EluvGia
         KEleUMohIoduKh4Nd8Oyd8r9A0zXMCRGLeK2rFi44xRpDlAvOUlMuZ+sPslcOyCGfu0k
         TVhVDvl/P1zK6gWbLi6tK8gsToqTCZbHqk/Tr7pvxSe28ggXF4AGxGCYuLt1d4IjANcC
         TAT/91YuiIsOjZlCEyy08RHPjo0dFGKTlRyLh68zX4/n/sfQ6DojJxrCxn8Vd1G7l7uU
         C9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073493; x=1780678293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jFRO5B5gIjR7rsGbbPkzABaqNE8Q13YLBC9Ee7R2t4=;
        b=sGxtEBlTAUMcTvpflXEkTQRd2lgW27fO6Mek/Bb9udyx7n47oSeN0cYWJvMLhjd577
         lmXu7sOV2l5fF2ipyB2nW3c7Naer8pagUM1raJosdr/ICspf0T5vDuU7j2MQGSccmWPT
         K92Gc7NVHh/1bLXwFzgttfOjPIcjgOyvisS3mBI7dY7+8SjBA9+8XBfOciVEf9I/HKG7
         lZZOhezaecaGsxtmzY0g6A/7wb8ImR4R2jn/CA8L5zv/DoIAKffRa6gOPzi9RaBPriAn
         I++Sv+w1ffgS0SqsxOIpIomBI7Bbd4DKGx6iZmzeYuYjNJ2S1fetc5gFu7WzuVp9TNxf
         r+LA==
X-Forwarded-Encrypted: i=1; AFNElJ9wP2j9CS8Yzj7D7fwb4UyRTnBDaKtvuTF48H2mtKra6vFTV+yL+AphD/iH8m7eDqHcnaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpEUunJueJnODvytfPaOh+37f8uWLVCxbtDDBWLqFhr40qfb6
	arbWHMbpq5+OomdjAExKy8dxz2q7LDGL93lRBd2RjOPmgMtbfM8IHW7uJT1tbb0qYG9aZUlUXE2
	ADTRkiw==
X-Received: from pgbct3.prod.google.com ([2002:a05:6a02:2103:b0:c73:fc44:8baf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a44:b0:3b3:1951:489b
 with SMTP id adf61e73a8af0-3b427f5bd55mr45061637.45.1780073492919; Fri, 29
 May 2026 09:51:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:03 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-10-seanjc@google.com>
Subject: [PATCH v2 09/20] KVM: x86/xen: Don't dirty track "vCPU info" page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Give the Xen per-vCPU info page the same treatment as the per-VM shared
info page, and never mark it dirty, as KVM clearly relies on userspace to
assume the page is always dirty.  While the page is marked dirty on writes
via kvm_xen_inject_pending_events(), it's not marked dirty when written by
__kvm_xen_set_evtchn_fast().

Furthermore, as was the case with the shared info page, writes in the event
channel fastpath may be done without an active vCPU, e.g. when called via
timer callback or irqfd injection.  I.e. attempting to fix the faspath
would run afoul of same issue that was fixed by commit ("KVM: x86: Fix wall
clock writes in Xen shared_info not to mark page dirty").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ab8e95647406..7b527a983cfc 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -679,7 +679,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock(&gpc->lock);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2313,7 +2312,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

