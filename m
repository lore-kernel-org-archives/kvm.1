Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406B3859EF
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181212; cv=none; b=iFKOJvuGTwYqRSzi7A32f/vJS3uzaTkD81+AcTuPJ9P9wp7WT9zmmGIc6xSwOE/V45c1nholyuyP8Rdo5U9wlTsRK3nZ8/D5c9eZyQYNrifmZTG6BPQbkErTKzIEg9lDkChqM8KfRlnnaBk13vmadAGeBHssol0dtNN0pHOs0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181212; c=relaxed/simple;
	bh=UmEqer6UG9O3E6DIbEIr7SZYSphsfnJwtmb/wPRplb4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PMVR6cKmP3mVlnKdagHuZKttdIYVZMU+azI7QO7zbJ0RpUzlThi/BNehBQg8t5qrnFC/PmC1ujrcgWNhjBZ3D/WYIaMxeY7TAHo/kmvlGXEY6hySLCgb0Bn3CxwztVAabvGj5BbzXYSab8c3belqEZ1x95W4m9Wc+HZTZaGTeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hh3oQ+i+; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh3oQ+i+"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so1236353a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790181204; x=1790786004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eXmgICAmgo6FOUU/+FNDCUIVBGaQ+4Ki2nli9SL6tEk=;
        b=hh3oQ+i+slcRSq+KidKbqa6iBrKX+GmoEsGQN1ileRhW1w4kBQDb4FzW8VJ/tzSJy5
         LKuJzbt83l98/QfYF8Sjg89rMPSmTRTUhy1EY6SfjZulK5t45bB4y1oGgpcbPs8riOwC
         HEtCUMz5yY4nPjtmlwTQgbb5l+xgLaUJYlNMxWikLP3oR8Z0Z243OjhbM6Ta9z9hnos1
         cks0eEzZDICGfZXNGLCMYmuWJbRJDFbnVD2UHVN/VgMZwKjM6MOGkTYWxJiS82jFUUnS
         aPCiyjw9T51RTN0ZGbClsNwWbw2P314o2TnAYKG/jFXnDSN4iAzEkXtjyTJn2O87v1Mu
         dZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181204; x=1790786004;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eXmgICAmgo6FOUU/+FNDCUIVBGaQ+4Ki2nli9SL6tEk=;
        b=AuDWgmAKWTntQlNqKy5bTt8S3gjFkTkpqrag7drumripIriAtEGNLCWfoexzckQymS
         toXg1/0wx9PkjldT08RYAhDlQJs6gUqISjPJrObvROIWMX06XdyIQopo+qpfCo0UzNrb
         +JF5cexW+U2wLO5TcN7mgCOfjuU1RS15q/ogRCjFAtGhq2JUh8eqZuUlDyrjBl0L0oMa
         FL6RTR4gHH6zGiqa0AJ6VZ38ywJSApq2I5mTWT0lpZVaCiyuBLXx/aBAYfIxQ4Z/CBoA
         Bwm6ZVZuEHs+/B+GmtIGVh8g+oLDi6CMCjmdsl9xzFah4xDmFgyVmPVZVL3VMHsUu5t2
         hm+w==
X-Forwarded-Encrypted: i=1; AKwUvBwda2McfsY19e/QvRsw5NKrHBUy49hGwnCZzqVc1D/DN5lrKwDeKdpfQlXBWF9l2/ZlGXs=@vger.kernel.org
X-Gm-Message-State: AFuF++kpalAcA4nE45neiGcjQZXRLJUQtC0IqRIPMlbO+ohlhxZ/4NlN
	VJ8qWluWqZ8i6JVcqyywJWP3Vbrn0rXpDhIkzZVTGV4XLUsstfvbD5rbCuddc48CoJbZ39U7zQZ
	5nd162g==
X-Received: from pjsc3.prod.google.com ([2002:a17:90a:bf03:b0:3a0:8ea7:1935])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d10:b0:3a0:8050:2ec7
 with SMTP id 98e67ed59e1d1-3a08050315amr1517256a91.13.1790181202701; Wed, 23
 Sep 2026 09:33:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:33:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923163315.1580860-1-seanjc@google.com>
Subject: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO on
 unhandled EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Synthesize a triple fault, i.e. exit to userspace with KVM_EXIT_SHUTDOWN,
instead of returning -EIO from KVM_RUN if KVM encounters an EPT Violation
due to a guest access to a pending page.  Returning -EIO implies KVM is
buggy, and most VMMs will respond by completely terminating the VM, versus
rebooting the VM in response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the
option of trying to keep the VM (from the end user's perspective) alive.

Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
need to extend run->memory_fault so that userspace knows the fault can't be
handled.  This scenario specifically occurs when the guest has deliberately
disabled #VEs on unaccepted memory for security purposes, i.e. the guest
literally disabled the mechanism that tells it it screwed up.  But, because
this is fatal, and the whole point is to NOT try to fixup the fault,
jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
make a whole lot of sense.

Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
Cc: stable@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Compile tested only.

 arch/x86/kvm/vmx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7173ef3fc398..eb82f739a7c0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1938,8 +1938,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
 			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
 				gpa, vcpu->vcpu_id);
-			kvm_vm_dead(vcpu->kvm);
-			return -EIO;
+			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+			return 1;
 		}
 		/*
 		 * Always treat SEPT violations as write faults.  Ignore the

base-commit: 30b5175943e709911702d8a9364145e911f57e3f
-- 
2.55.0.1082.g2b9226bbc0-goog

