Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47007310645
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953319; cv=none; b=dbouxGFk2h4MyK/SOgi6HuE9ZyO0/0qW9wwIfhm+g9GfjErblDorG1VUY9c3SzpRzo+972/cfkawpPiy0GSXwSZzynAikSAnpzvGntLrawhknN7WStOBcSnLstyDBg2LEM2xbW1dTMlabChoILLQPUOPg3aQNUGTLAKTcUsgBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953319; c=relaxed/simple;
	bh=aYYZKfrBBRP59cknzep5wtclWoocNRNyv8+vaFmKz3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HkoHEqhAQQMN6A1mwcw9QRRmLaMkeuL5LUm3LerR3cfmMs+GdB+FE6lpwm/sVlX/xY1Sh9sfQsQirnRR5TkWe9W8Dlt/jxXkGJo1UE6pc+ZfUvuDBEAH7LxREIiNFH4x7rhVnhT/o/5BE8rovIiyUR06/MDiDRG43T1U1LGHdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4PG/cql; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4PG/cql"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so7870311b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953318; x=1777558118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ylEEux23AikXo/xyLo5LwNKSYgYTDLnGu41LajwZgM=;
        b=X4PG/cqlpa2hb/SXLrDCOj1ZzWbSoeQAhUvguovdwxzK6QaJYR6gTdpHU9ZtbdWI8f
         s/SSEpPa7/ImTsQTf9i91ZN0UQ/ZzmPZcg7MjqwWU90l+sBh/E8rL+2NozFRq9gY9+B/
         zCAohaXcboytmpmp8fGNc8wEYTeoeg18DZLDCh0HO56thABtIljfKlAcIuRV/9kF1kE4
         M8iXflEBjfXdlkuJWTAppCbW75t7djiWcf1Q0vzLpMppvaAHmkxdZXs6d79dIviR0qyJ
         lbIVA2761vfbG/dTFlLxJ2Xj8YimsJLhFMk+9w9sRCTYRf3iOh2uyLXHlIRtDGF36J+2
         nFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953318; x=1777558118;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ylEEux23AikXo/xyLo5LwNKSYgYTDLnGu41LajwZgM=;
        b=EGw/UeT+fFNwc9txuurM7XratI/rGN+SAg8Z6xOR0y8bXgS0KkO4ar5Tn6r859+Aju
         DBHPKG2BO0VGGhUfhReIiAXsq16I2B1EgstRe+gbeNmeohG1FWH5WLEjC0pCa37eZ/Di
         xPp2OkZ6IFU/ueevrByC5zbrA1ux8RKzmCVEO4XUmZd/8oDVUkjLuw/QmWprPzLETaG5
         P8SA60pPMHiySwR+lYjf8D3mIuS+PGi40rvaqR4r1t/tdBQAm59j3dcPTk80YNKXWQjk
         uCCVdFACZLzZXk0tWYapV6vlqdFBOt7p7YvrownomJaraJ+2UO3B3g5XSlrlWRVsHDXG
         gtxA==
X-Gm-Message-State: AOJu0Yxz6P1ZQliCyPQ1ibeCpbHEYZPaMTsNZPaZYBlJpN5CvkEUMBBD
	db6a7sw1ckcL7nRasiE5d3vNmt240a8qGCE9JeL0rgdoAbRkrCIszsLAhGhR7bsoWceRO8nAw2v
	DhfqH1Q==
X-Received: from pfvb9.prod.google.com ([2002:a05:6a00:cc9:b0:82f:3a14:9636])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b87:b0:82c:9c4f:da3
 with SMTP id d2e1a72fcca58-82f8c902057mr30368698b3a.31.1776953317446; Thu, 23
 Apr 2026 07:08:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 07:08:28 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423140833.439512-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix a bug found by syzkaller (on a Google-internal kernel) where KVM consumes
a vCPU's HyperV structure before it's fully initialized, by concurrently
triggering PV TLB flushes (queues flushes into a vCPU's FIFO without holding
the vCPU's mutex) on a vCPU that is in the process of activating HyperV.

Harden against similar bugs by asserting the vcpu->mutex is held when using
the "normal" to_hv_vcpu(), same as we did for get_vmcs12() and
get_shadow_vmcs12() (also in response to cross-task races).

I'll reply with the C reproducer (which may or may not repro on an upstream
kernel; I was never able to reproduce the splat myself, and relied on syzbot
to test for me).

Sean Christopherson (5):
  KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
  KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in
    kvm_hv_get_tlb_flush_fifo()
  KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on
    cross-vCPU accesses
  KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
  KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active
    accesses

 arch/x86/kvm/hyperv.c | 66 +++++++++++++++++++++++--------------------
 arch/x86/kvm/hyperv.h | 26 +++++++++++++++--
 2 files changed, 58 insertions(+), 34 deletions(-)


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.545.g6539524ca2-goog

