Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560644A3F8
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779130; cv=none; b=iQiEqLHmxx9m/1JBv8EHuk85xgMadzSnRr2Q43vMTQPlYKPUBZaJOaguXLFCdpth9VwiHnJDWyJzRYcvxEB/TpmZAFCT1bk9kc+qqRygfGxI0/R8g060uAPh8OnKshnmNZObsKAs8mJmbSCi/bH5nt307YJzPNjCgXlVpT4iyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779130; c=relaxed/simple;
	bh=D2SeNS61d9dVgtDOWdeCnHOyaoz2w294vOhGlL5Cxr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3P8RL4n2erk1PunOA8iV4GTVBnanXqu2DEwZsSHTXmdjUz5m51kdInyTLvkIG8fRlFpbgOBiI15WO8TPehVv0F7n7LOk59JhMwSQ0dX17I2EIjQWWj7LWL9RVXpLblt+20oidDgWZNeOxxByEsuXpV56zycqw37tln2vDY5TG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSZCL3Bi; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSZCL3Bi"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088202so18350a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779129; x=1788383929; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gm2xvEQmU0KWTaMXq3LZgCB6my4zIF400tJYxp9L68k=;
        b=uSZCL3BiHFNexQmRE6w4G3AdF2spVvBYXeZU0pKe2PKH+LuZUO57ZtUYNTy+j7i8qF
         ad1SbhwvxecMMDIqb0s30cZTdURxqDtlGRL1w0kky+ztGxGMAM20kKBdLpxG86+3AORD
         ogeeRtR5XI66EDfw0RWMsc1XS7DvSrsItokzQrwryh609F7nrIg7uVa3a2Jr7KN8REyg
         Shctr3lgPAGFxx28MauXit3jL9evPRnZ1aeslck+hIr9tbolXhdqqENxDnkzUj0XNMNC
         UEtq8YvyAxK/LmHgOvTP9FJuWGhiZHWSXfGWxgS/5ElveUp7ibmfRNenI4q89bTS1jQL
         la6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779129; x=1788383929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gm2xvEQmU0KWTaMXq3LZgCB6my4zIF400tJYxp9L68k=;
        b=ZDepdA3apu/5NKQkMcJ4/cd3XKnlb22oWlCEqlzh7e3aDqcCdDtZzHq32bbtnR/Xxt
         MMTg27VE9Pk1ZBT5sYw5/6ADRpwWUWs5kQU/w3IyjrIxG6KcWUh4pwZueRYtGQZVjmnN
         L0LOfOE6bDqU14xZwS5KCfbfC276r21ZvNRZTrMvlY41icUFSqBGnDj6PfJdR/ZguU2P
         mYwL+pqS16XAdggWxFfni8foY/Jyuy1DwrZKebzbsCmxef+hwCjWZF5MOdSFGguLkIng
         ojrAVH4qyy20QTIKi8j3xlAO5E3KQQslpdiQVd+0SKWn96l3UQsZN7eH8sy1Jw3VHBFM
         NP0Q==
X-Gm-Message-State: AFuF++k6EUSgoG5M6zfwZUaxi+NfF4u4d7Yv93DyptksLGZfYKduxf9U
	fCNPqnmfqc2c4bWFQVQjd3bDB/8xyBWIjjyjT9kY9xbebdYQbK6ZcPGl6fkmIDU2XuO9Ycw/BG4
	YKuc4UQ==
X-Received: from pgbs186.prod.google.com ([2002:a63:5ec3:0:b0:cc1:c943:f652])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c85:b0:847:7f3c:b5f5
 with SMTP id d2e1a72fcca58-85374ec9fe4mr16903779b3a.11.1787779128400; Wed, 26
 Aug 2026 14:18:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:18:42 -0700
In-Reply-To: <20260826211844.884951-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826211844.884951-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: x86/mmu: Bug the VM if KVM attempts to walk more
 levels than the MMU has
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
against KVM configuring a paging32 MMU with more than 2 levels of paging,
with a very explicit check for exactly that: that KVM isn't trying to walk
more levels of paging than the MMU template provides.  I.e. harden KVM
against all bugs that would cause KVM to generates accesses beyond the
bounds of guest_walker's arrays, regardless of how KVM ended up with the
misconfigured MMU.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 27427e7f22fa..46a0f7796e55 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte_access = ~0;
 
 	/*
-	 * Queue a page fault for injection if this assertion fails, as callers
-	 * assume that walker.fault contains sane info on a walk failure.  I.e.
-	 * avoid making the situation worse by inducing even worse badness
-	 * between when the assertion fails and when KVM kicks the vCPU out to
-	 * userspace (because the VM is bugged).
+	 * Queue a page fault for injection if any of the below assertions fail,
+	 * as callers assume that walker.fault contains sane info on a walk
+	 * failure.  I.e. avoid making the situation worse by inducing even
+	 * worse badness between when the assertion fails and when KVM kicks
+	 * the vCPU out to userspace (because the VM is bugged).
 	 */
-	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
+	    KVM_BUG_ON(w->cpu_role.base.level > PT_MAX_FULL_LEVELS, vcpu->kvm))
 		goto error;
 
 	++walker->level;
-- 
2.55.0.887.g758fc8c411-goog

