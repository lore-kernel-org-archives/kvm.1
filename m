Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D53BED11
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735934; cv=none; b=iWBjTFVkbM4AKEtA9OeRPeL0RCEb4pnfKHXBZeQ+8h78cZXRrP8lM/aE7Js2qvmwwmmlV3Q7IMHX7KgIPrbFU+yL8CnUCN37QVOf81vNqRdNmqrmhMIs4YIZ920MoUAH3oL9sVRPFKmJq7ktpM2n15USQ9lM4tOkukRsyNzEV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735934; c=relaxed/simple;
	bh=coen2YTr1jMY7N8jgQMR4KIO1rvqehu9jtUhjuViG0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H7qwbEVnPa//htmUpxjAunSbvjugiflUkpQ9+TmZNATe8SmTQAZULS4/lqZmc8mJ46q8PRxFDaCUDHESQIp8fkzFVAoCTNxdAt15JD7ZFlftIu/8FCr6V0Cj/7XiY/tbzBVbtYd4RksBYr9WrCPVwtbIGc+aqfToLEkHAtTWGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aq3iBo4x; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aq3iBo4x"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so13415885ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735925; x=1788340725; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PoPcctCxCU9xeD6IUV2UNVUEFjzWLV4ASul8wcFVUE=;
        b=aq3iBo4xLsEdHK5WqHTTz5DD1IcHdOZ+YqT9u0B4nDN44B0Nb/LinBH5ql+WkJqVpr
         qq2NWys/aC8DUaPd/OZOjCeDRWqE8FUVqgW3uBwCO3tdDBqkndaqzzmlsJMEhFbMIcZx
         KITJptpRjJ+4+I/L3nZNLe+CRwXKpkYnGVbPMxAuJ6Li7M1ArPBm7DttnMEjwsyyyaUF
         64s+wNgK9PKX5rFaFe+snV+3BBo+aETiJnBHw+bq6TWp9hS4edD3TP+WpZW84JtNGWVs
         /XhSwJyhmRr98NppBJmGMN1hbxh5RjIz2U8sbhkA7f2UKx21nJGZMcBKX/i4oUhAbisI
         pGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735925; x=1788340725;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1PoPcctCxCU9xeD6IUV2UNVUEFjzWLV4ASul8wcFVUE=;
        b=Ff8aqmCQ68BmcQENXOYRM6b2hgBgOyjDdL1gHQp8xuFsFPFodEIETL17NxGPjlI6oN
         1WZ8Pfjk3qopTH1lcxFGYcZbBPdNwvY8Z353+Rr+tl031q1KNh4hcb2+OQGdAwJqbGpz
         7kd/616ILp3I/0duMLRngDgOmVmEtvQFqvUAKijS9h4ULqaNulwnapf4Yckn1bdrU6SB
         5dH1isAA/stgohgzZJDfWSUXc/uo4CxIhIxisrZGDsRq6iA4C7CWMp7I7EyG7jyiGYTO
         xWfxiws8hk4GizRy/XVVPY3zPdWaqKL+oAGiIcSFwIdwI+v9MEZS3a8RFJGPXwCNKuxZ
         zT1g==
X-Gm-Message-State: AFuF++kkVCn0Cl8G2thtRA0cUwePs8or3WgMKBgn48kyh75aAJ2OwZ6m
	U9YUtZHSM3dcSyNQECUPXaYd1+2NCrNrrDSeT/V8TF+rTtxeCXMTXAdHtdOqSaaEnYlonFJGuCJ
	J8OqE7Tu4vrNdoSK9GUb5e0dizg==
X-Received: from plri12.prod.google.com ([2002:a17:903:32cc:b0:2cc:7709:3bc8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a45:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d707a9fecbmr93422125ad.7.1787735924909;
 Wed, 26 Aug 2026 02:18:44 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:20 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2002;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=5+fsxDOXBXvxtjSmr4LTesZGOQ7aAAqTF+3X7TBXdZA=; b=Rx5ixHeP0JEHh6BXcEuohPdB+7Rs9tkd/Cq94uHcIXinftxcsawhYkswrSTC+BPLDcx78kRwU
 vASNv9iu4SlANU6cEaBK5QarVqaCef2nf28MCtJrwSE8k7ohH/iAF11
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-22-0a15d8a799aa@google.com>
Subject: [PATCH v11 22/46] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
from adding support for per-VM memory attributes, because tracking private
vs. shared memory on a per-VM basis is now deprecated in favor of tracking
on a per-guest_memfd basis, and while RWX memory attributes are on the
horizon, they too are expected to be x86-only.

This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
Now that guest_memfd supports in-place conversions, it's entirely possible
to run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.

Leave the code itself in common KVM so that it's trivial to undo this
change if new per-VM attributes do come along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/Kconfig | 3 +++
 virt/kvm/Kconfig     | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2f8e1b5a8a72c..abb108886733a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -80,6 +80,9 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
+config KVM_VM_MEMORY_ATTRIBUTES
+	bool
+
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index df575449d97b5..a0678ef8ee3f5 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -100,9 +100,6 @@ config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
 config KVM_MMU_LOCKLESS_AGING
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
-       bool
-
 config KVM_GUEST_MEMFD
        select XARRAY_MULTI
        bool

-- 
2.55.0.887.g758fc8c411-goog

