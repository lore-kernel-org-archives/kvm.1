Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928136683B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405456; cv=none; b=KMjHl0vo4p5rcNBi9K2l9fME20pEVYFQdbHFaYr3s4Htx6PDCGnH5s6pJea2/irIRRPyQ12HKaOp3OdVniPZpSjAFEjrnBxCmE0i8xQmP9NLxIoiLn1VHzBpriveGMLoleFt5Ri7viiS6VIqWMkhnC1lkZ3aV+73RG53wX9Tl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405456; c=relaxed/simple;
	bh=JnAB6QOxWpHlGcbP0fmoB+xvPSibMNTRiB0Xtn3yzBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nI6PikAo/mel3gfHPhcZSjolYF1j1kPyyoQjY1f8Rz/0O/BePFL7KxoYHaHhRjI/knufYhEn1dOXGIFsVyqrTAayEl4Nd/VNWQxn9yvH5dybfFPMrkqfCCQN+Sf2P52OrvK9YO0U2aRAHsnoKnnEL2vEoHrcl5V097o6x8y2enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3UFWyUW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3UFWyUW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso2529688a12.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405453; x=1780010253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYqvejVJWhV6aW28w0DTqDCei/XyqM9XZYqN7Ny5D3U=;
        b=V3UFWyUW04PJpT9i8qgC0c8lCg2wod2J74mW8BigXkwTyZ2+F0aAWFeaxETIUK2h3D
         KJJp3AB79WHmaBoofvWdiLgOou3fKlkkwYo6OV1ynFib6LX1MymHIu+FkIVAssViSygI
         I9Fv5ozlsKrDcf7sj51nq0Q+e7ZHZzLF2vGDDaLeXs5OeR6y3FkHLhVXXxWkz14qQdte
         lWcFzzjLVHOzkD5+uCG88hcooiz+Nwu/ZZwzNt4PYFGuxkQ/vUM9DwfLC0t07Q2Ur53c
         lV4ct0LOJC+vk3Ne6BDKnA/HIEsknFhGPubNFKq9t+VyJUNt7nyrLVFt2FX338RKRrtU
         tTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405453; x=1780010253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYqvejVJWhV6aW28w0DTqDCei/XyqM9XZYqN7Ny5D3U=;
        b=To0nWGIS1/H2UvOd1el330M0oZfJ9Col5R5G1tn5S1tgj4Uz+MawhQVt3ZLQ+xYpUw
         2QBwIHRJ2MD/j00d3i5enENfqumAaLiM6VuOHnACdIJp3+HUCSpWcGkkp22qmkYuCEwP
         PpfxgwfHynlOY1yGaKBLwDjSpr/UL0rU8Mgqp/DKnSXvaWlPJt1j/UB7KOAv9jfXsVPg
         8UkXjr0ADv70SPWH0oU1yuOjhIkChpSTOsxxn5pGhGAorMiz0pP+5aiNi3oEYdVBeFkB
         YtefGFvTB/zJS5VFK7GgdvXGM9XJsPRZpOIeFhRE4GgDYsmoZsnNdpEgFZ6Lpnw+Llyd
         YOXA==
X-Forwarded-Encrypted: i=1; AFNElJ84udYs9ry14bLTOr28y/xLmu1eg2nfzlKcaICoLJoElUUc+Vol1XOZAnvjv7v9o39y7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DOYDzKy9ZxNTeEtw4pLzMQv+88fMo9jeNh0mFv1o0fm6DiRv
	ZEEwKiS/pnIrfNXoWVHLijwJkiyAWnmccfrljrZaiFOwHLr1wHXzaOBpfnC1n9DJsRd1QRzeuH4
	IWS9TPQ==
X-Received: from pgjp8.prod.google.com ([2002:a63:e648:0:b0:c82:7805:9e3d])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d491:b0:3b2:8675:4866
 with SMTP id adf61e73a8af0-3b328ecda83mr927887637.31.1779405453357; Thu, 21
 May 2026 16:17:33 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:53 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=908;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=JnAB6QOxWpHlGcbP0fmoB+xvPSibMNTRiB0Xtn3yzBk=; b=z6LbQDrkS1jrkTbATNNebtrydZtJzMJH8yWsyolcf7v1pujKmhYJXQuhs/aFvdKH8ZA4boOf4
 MnOUPP8sDlbDQkfmsmFlhEgnAVOmZXPDV7wEdqlxWWi4QEM78ca2YOR
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-12-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 12/22] KVM: selftests: Back the first memory region with
 guest_memfd for TDX
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

Force GUEST_MEMFD for the primary memory region of TDX VMs.

TDX must use guest_memfd for private pages as there is no alternative
mechanism supported by the TDX architecture.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d1befa3f4b30..9a29540fff40 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -472,7 +472,7 @@ void kvm_set_files_rlimit(u32 nr_vcpus)
 static bool is_guest_memfd_required(struct vm_shape shape)
 {
 #ifdef __x86_64__
-	return shape.type == KVM_X86_SNP_VM;
+	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
 #else
 	return false;
 #endif

-- 
2.54.0.746.g67dd491aae-goog

