Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB122325706
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914471; cv=none; b=OSExCHtIbjiARV9+Jcbz7Ytl5nrCtc5IsmGXbufjCyY8wxRvKSOxYisg+jFr9b3INdHKTXfN5Gv/xFsMzr62hDVOm05NZ9MioNLayvNc5G9vKlxxaqFRzZplm2hy7xTXx3uKcTrGdACOr/viy4TPp7MgyCdbMG12ZB3Ha4JmEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914471; c=relaxed/simple;
	bh=rLkMc5AOpVKMTLuxHjDhFbknUJV0WEQRy7oPL6tNQKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLLT+Z8DGIzrtoJsMxZ/016qCsay/G+m09UCIXqt6XB+IZE344XwWj/5gprtiDcFlnHlddxqZJD6AlW2c3tMFIOOdgabH1eTZPOnGcncfOI9e8HggZPgORN8KWd/V/sFLILh0dH4aMs5zt0HP91WfXK77dE7yH0zQeckT77YPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Crk8PD5a; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Crk8PD5a"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so11532435ad.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914469; x=1785519269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o72EGRo2pvQ3WbX6SzXXg6Q1ixoc9GAPCSAe802AzLg=;
        b=Crk8PD5auDoxf/+KWPpYZUIrMltPh9A5H+eeFhbaRG79SympiQC2ho13OsX9xLNZ6i
         /hCtmfEyMjZcO/bWRqjHAhSJU2XXdt9dD4pg3V0CAnPnqQ6hIW8FMO+gL7UvLz+7pqnl
         QjsGzWgWktYljz2wup/tC7os0K9Pqf5Hnd59lJwrnT4Kl17WWiwD8b3Wp8rrnj/8ylGz
         S4T7KSLlC88zG7vZlgLdbYRJSj0yTIHTdodL9Nlgv3+AmWNfKPBmKJw2G2YXej2LKAEX
         diRT0p85RPKfTWWkfKE/f2RtNqmwSQzUcgOCu9dW6AxLTQS+RaIj1vfZWpb+7uw5bgMd
         rh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914469; x=1785519269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o72EGRo2pvQ3WbX6SzXXg6Q1ixoc9GAPCSAe802AzLg=;
        b=TDmuAutBUe9B9otCeqe3MfZNCeFQWUdSJG63v0KriD9/AkUpufv3iKyTNYA4VFSapx
         Vynf/MbHcZS0HoRYo/iZCN4xDX+kKfPchwJt0AfcKNpytdivUK4BkFtARIbhys+Tjujr
         tn/zKBJFWLtVMtWDYMGkqQcHD+2nr/9XjKXNFjG2+Y1QcUTq0sSMo+GuBqxDCdKam6am
         DAr69OVMSJYYoyHqT9QHmcExrks8ADCQyD+0DwRJpE2Mkhuj7uiny5Su/h0pITq6tlF5
         GetaP8cyoztlyM6BtKt5aSzRl432NWEkVE31dTCijPhc6ECkEbYiHJ/PGWckKLaq2Itr
         rqRw==
X-Gm-Message-State: AOJu0YzcrGyP3kZGUp8k+JH0OcUOwdk1DRlU3otJ6Pnu0SO52TYMHK04
	C7/AEIYZEIF4JQHaNuxBnUbjaZeSTSkIMZaKoWy0ZZsklJPjJR+jCplYp6TIE9V2nt7A+ox0Y1x
	gM2H8xQ==
X-Received: from plv5.prod.google.com ([2002:a17:903:bc5:b0:2ce:fc90:1592])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f43:b0:2ce:8551:318c
 with SMTP id d9443c01a7336-2cfa6d879b6mr98306685ad.40.1784914468877; Fri, 24
 Jul 2026 10:34:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 24 Jul 2026 10:34:25 -0700
In-Reply-To: <20260724173425.278753-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724173425.278753-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724173425.278753-3-seanjc@google.com>
Subject: [PATCH v3 2/2] KVM: x86: Don't WARN if IRQ disappears when Xen
 emulation is enabled.
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+dd769db18693736eee89@syzkaller.appspotmail.com, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When getting a to-be-injected IRQ, don't WARN if the IRQ disappeared and
Xen emulation is supported, as a guest could concurrently toggle its
evtchn_upcall_pending flag in shared memory and deassert the IRQ.  Even
more annoyingly, userspace could disable Xen emulation for the entire VM
KVM_XEN_HVM_CONFIG.  So, suppress WARNs on lost IRQs if Xen emulation is
supported to prevent false positives.

Alternatively, KVM could track if the VM has ever used Xen emulation, but
the added complexity isn't worth carrying given that the vast majority of
deployments can and should disable Xen emulation.

Fixes: bf672720e83c ("KVM: x86: check the kvm_cpu_get_interrupt result before using it")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index eeaf527cecc4..a74f03858004 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -130,8 +130,12 @@ static inline void kvm_warn_on_lost_irq(struct kvm_vcpu *vcpu)
 	 * another vCPU grabs the IRQ, or deasserts the interrupt (which is
 	 * level-triggered), then it's both expected and "fine" for an IRQ
 	 * seemingly be "lost" from this vCPU's perspective.
+	 *
+	 * Similarly, Xen's event channel isn't entirely within KVM's control,
+	 * e.g. Xen emulation can be disabled entirely per-VM, or the guest
+	 * can desassert an IRQ by writing to shared memory.
 	 */
-	WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm));
+	WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm) && !IS_ENABLED(CONFIG_KVM_XEN));
 }
 
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
-- 
2.55.0.229.g6434b31f56-goog

