Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4F36D9F6
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382388; cv=none; b=bKTxl7+6E1Vi78gmGTsuKbEb7X/8k0GCteoXwSU3BxpQOGDRfaVSWz8FECb54rM1cJlEsvVTI4h8AaZMMCxj86/1DcwOJVxNPwT9QES6TTdTNHRoDlInxpuJPTPixfkGd4FOQyBXUNVy1mFm23rdFKMAjCGEOA8N1nbUlqXQbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382388; c=relaxed/simple;
	bh=+yxvt6miDsLo0aPzGIl2cuUjXFw4HY73dvLlkFiduNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XD6uhXuZqQhs2QsBN/Qs7Sxt7jWsUNd8wrn/poAqTVaZduJ4G/NwVBvj3zlrXTLtwo5oIBJRYP/DeGIbbh8/n3AIhSO7LajEmX1ShQrPC9VnD6DwXON91GiyBGTyMfKGK3KMwMNzteyivDlLBvzBs07dSwpSkYkCoqw0HvrvWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L11UPzTQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L11UPzTQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso2143978a91.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382386; x=1773987186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b75o2IzoSOCf08/jbE8J7pfDBRNnIyHyOWOLbNdF1vQ=;
        b=L11UPzTQZsjVyClKszCwVBPJIrNF+Lz8QhVKb65MhKcV6iGa29FOaTCr1GzQB7tq4y
         EkgBAOzbT+ij3CdEbQfesgvj6AWS40x2fdqnlO9UaW2z58sIRIXvtePGKKdxFTWIO7mU
         C5HgYPEnTl4RTxSxE2yzpgqF5CHm3Yq8ryH0r5NK2sN/X2pZGxZvOyP9FMq0+FLLWg1h
         /2u3VIQBMwjtl9S4c1fErcSYWoXfZ4qEpSBeKz5caw0rnVthWev48VFdCemS6Gh8oXIA
         Rl1YKQNlDdehxL9AF3xgH+D9I8B76DQ7JxIwaN2IKFuPUhTlQNgV/udksfk86pfXnK2f
         PDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382386; x=1773987186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b75o2IzoSOCf08/jbE8J7pfDBRNnIyHyOWOLbNdF1vQ=;
        b=TiW6T/J546oEZSzSRmZnmNPENUWc4bEnQUSV7RKhOsF4OHZ5q5sjI55oIzXvBO2Tox
         9t9fY9JUeOhFq9WE0GmRnuOfZxgUqYZ/fiPUkUpNo6AoZDHnV+lt0zslOgpG2vYJH0zP
         suCZSWO/gX2TQydDcJD+gxtXGV+mWIlgFgw04w9sBLHeOfeJiozEVwIWFzBJHd6VexcT
         fa5a/cEQjIw+Azg2nKH08Q8+LI9KMaLBu5Lbt+6dLZRcugFQQzmmbcgXFXR3v+a/lcKo
         c9vZNQSkEZCYRaMKgXz4QjDnh9zGaFBjj51e1l/lqMLvBecL626qZzH9dX92KGNmay3q
         pWBQ==
X-Gm-Message-State: AOJu0Yy0FFVxqttAoYdJYyRKGgY7CpaTi5QXWjMfIrezmHuEAlRIurAs
	Lcmf52lqS9qr3XC1a6VPkRAC24S2vzJzb9ew2oQ+mDI0E3LaX2l7/DyQtC16ANILNgbwzz8dAzW
	wn4f3IN4fWnOUD/deVAO5EDZHmw==
X-Received: from pjni7.prod.google.com ([2002:a17:90a:8387:b0:359:78a3:a05b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e45:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35a21e3958emr1821235a91.4.1773382386033;
 Thu, 12 Mar 2026 23:13:06 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:50 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1751;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=9Ip75FUnko/0RMTmmR8hpogS1RIjLLZ87GSWphxWeLk=; b=TeyrKLRZr7KdaZpJOnTQ82Tnubf0KxrjYIwwgyxVitGP6OaiDEw2tA9byUcAF7CMB/WOPpYan
 mVI26pDsudzDK60E97MrrbP9QYf3ETOPcuNtgVvZGbWGXV3ovh0UE2P
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-11-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 11/43] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
from adding support for per-VM memory attributes, because tracking private
vs. shared memory on a per-VM basis is now deprecated in favor of tracking
on a per-guest_memfd basis, and no other memory attributes are on the
horizon.

This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
Now that guest_memfd support memory attributes, it's entirely possible to
run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.

Leave the code itself in common KVM so that it's trivial to undo this
change if new per-VM attributes do come along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 4 ++++
 virt/kvm/Kconfig     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 26f6afd51bbdc..b6d65ee664d0f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -80,6 +80,10 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
+config KVM_VM_MEMORY_ATTRIBUTES
+	select KVM_MEMORY_ATTRIBUTES
+	bool
+
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index e371e079e2c50..663de6421eda2 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -103,10 +103,6 @@ config KVM_MMU_LOCKLESS_AGING
 config KVM_MEMORY_ATTRIBUTES
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
-       select KVM_MEMORY_ATTRIBUTES
-       bool
-
 config KVM_GUEST_MEMFD
        select XARRAY_MULTI
        select KVM_MEMORY_ATTRIBUTES

-- 
2.53.0.851.ga537e3e6e9-goog

