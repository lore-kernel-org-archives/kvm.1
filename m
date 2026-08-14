Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D648BD46
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723896; cv=none; b=H22o2uf/506OFq2At05BZImEX0aOqTFUfgKyumxd4qew7+8v1RBqHULmksYHK3e0jKEAOlbAojpAsTfeBbLnK6ruaisGSpkokrJlSLEF6ZabsfEUzK8hzsGevxfmeeMHy+XhUDyPO6429mDlpyIkG84dr46G+2kWk5btyOlbSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723896; c=relaxed/simple;
	bh=Yjwp5sXg8hA+IFzilFQC+IgVznGjRjghxOVmLb6eHpE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o0QGDX/2YVmW0RraiNgwEt6LO0vtwq2lMOsMNMe1OYMaxh/5a8kgsHgZ5puIiy4efG00AWm4J18b0QGA1J48pu1PYPpMTeI1Fsb9LKJOh3t0JWexHJNVaz15dRGp8hEVDBRVxo/lNalngM0jeBrY6AUkLba17/qnFK8JQruLj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qltv+PQx; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qltv+PQx"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so1782036a91.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723891; x=1787328691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1QOpGA/mOfm9r1jqGgG0mT+xGoxs+eURoQ2xm4eLKI=;
        b=Qltv+PQxSyw0/tlKWfSDW9CAJCpkSRpSUo72cg0XhSi457U0yVVJtSsz3d3BoP3Srg
         N+6re9DFRj44WFJgMLmqYC1FW1278fOHxmrikTUTlW0r8F8G8AXbQxCMPq27f9zzR4M/
         Hbh9SMDHJfesFkRRNqE9xQQAirX85OdReILNlLQ6/fO1t95OY6QrA60t0fXvEyUOXQgL
         CAc/QXvU2+EueqaywAvO6lGCaT47Lx2KKiY9WuAyPoL4vWQAByyxU/qAedR4uzte0UWN
         IL3zJIQj+YhTb7TrMXyjRbib65mmVELh9dC1AoIi1xIuUV+WU57pFMbVZ+0N5Uvx2bQH
         AyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723891; x=1787328691;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G1QOpGA/mOfm9r1jqGgG0mT+xGoxs+eURoQ2xm4eLKI=;
        b=LA4mFeYLmfF/1VmWQEUqZzohZd803yrlZ8pfD/+LrV/h6NpUMIUjWxrMgQGp7VUaMY
         NKB1ok2y5BtueTzNN+UXZcRjeHZw4MvR8g42GtU3rvDb81Uf4pyrEx8NSbAKO7f+J3rn
         IMRMTh3GhQwCfhEphgwDSrvPmIvD/xoxHWMBnTMZmolj5aC1dmp1NT3ORRnyrF60p+44
         AZJxRokIVkPpB/PdDceuJQSt76cVpCLMMy4gTdNRdZBGSUJBWj17czN3FxAIibjAPLIj
         MbuMbuNxvTDSVHQJpamv41kILhfLo3XboykQ7W3LykNT2ucIWNNpiz+UDeX8fQDC8bQC
         Fi+g==
X-Forwarded-Encrypted: i=1; AHgh+RpucxkafYCVUWPLu/f7Z0tyD3G5sTmpAD0ON8+sQPtyBi7qVCcqVF0Z4MSjBi6hioQmREQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7K7eJ66CsTXI9b8sagTbLUJzCR7Th8okwvWnpz3HWA8gcpT3
	mpeb/XJXBVkLQ2s2a3ZPRmFmb206/MsDiTltiZ0lniBj/xcrzLXXqfr22+fFE250VspbDqlYEIW
	/Mh0OAg==
X-Received: from pjte4.prod.google.com ([2002:a17:90a:c204:b0:38f:749d:db46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384b:b0:37f:e1af:df22
 with SMTP id 98e67ed59e1d1-3933ba90e38mr7162627a91.17.1786723891326; Fri, 14
 Aug 2026 09:11:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Aug 2026 09:11:26 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814161129.2177118-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: VMX: Harden against interpreting TDX vCPU as vcpu_vmx
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move vmx_handle_exit_irqoff() and all its helpers to main.c, and then poison
to_vmx() for the common .c files to harden KVM against misinterpreting a TDX
vCPU as a VMX vCPU, i.e. consuming to_vmx() on a TDX vCPU.  Spotted when
working through the bus lock series.

TDX changes are compile-tested only (one of these days I'll track down a host
that's fully TDX-capable).

Sean Christopherson (3):
  KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
  KVM: VMX: Disallowing using to_vmx() in common VT code
  KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"

 arch/x86/kvm/vmx/common.h      |  6 +++
 arch/x86/kvm/vmx/main.c        | 75 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/posted_intr.c | 18 ++++----
 arch/x86/kvm/vmx/posted_intr.h |  8 ++--
 arch/x86/kvm/vmx/tdx.c         |  4 +-
 arch/x86/kvm/vmx/vmx.c         | 78 +---------------------------------
 arch/x86/kvm/vmx/x86_ops.h     |  1 -
 7 files changed, 97 insertions(+), 93 deletions(-)


base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.55.0.691.gc56d675ccc-goog

