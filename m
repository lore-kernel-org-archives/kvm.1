Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387292;
	b=cuKO2sSvQY+2ElCU2lbK0HZqNMVVrrvViTzFL2+cRuM26zeqC9nIFez0kj5Es5OeCHRL
	 NFVUZvXi052cQ5H7/KnsB5dtXN5VABiqtsO7vxzUWdh//C5yigBCyq2HOyKtHIiWxZBqT
	 AcTXlgt5ACfDQnUULEdzhbvod/aRMKcAZxeEnZjwNKoFJIT6F0LyAGBFZrDErvzS0BTkp
	 0HhHkfiuKAadOjGJfi81+wNN22uEC76PC3HVJ9xQX+vw1sTCJokeEVF8o3cIx3AkPv5LS
	 mmkHrxca4hEQX0fOTftEE4LQaekRRgA1C1e9v0/6au5RJZbZJgZP8TS/sgrh5cX7Nmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387292;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h89S9x+6FNbsx1kk0qOjiYteMD3ffDL4FelhcMuCPmM=;
	b=rnuBPOIEhtwg+D1eE/SNa075Fy5woC8UsCsc4LoZLWS5DSw0MEb6knTP+ryekM4At4cA
	 EMjPCAz7hR28TSd1zcatrkrBbCo6BaKZO7yWegZz9swNZV5T789vbEu4wY8fB/5qlDOkE
	 0Gykb21r7YVXql3B0iET0aT2DEIufqadHnkNeHSi/b8rreI4O6Wl+3kNTlWjp2odJ/iv1
	 MoreJ3dBj0eRKfq9yIhhLlRDf83g+oeyjmh/EBrX6YHcgz1QMQRgeWZr4o9crov990nSa
	 eKJNibsD4g4XsW2Kaa+mIBLPdO4tLdguN6pgTbDzHFvNZYhxS8b8dosDrV8/Rf5z0ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TnwNEjHG;
	arc=none smtp.remote-ip=91.218.175.40
Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564A606A33E
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1564A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TnwNEjHG
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WIWob8CPC1BsEJZy81fYICtAeoeG+8SX6viRZjO9vQE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794387290; v=1; x=1794992090;
 b=TnwNEjHGDHf/4d9hy33NMTCRg+LPASjHssOb1iOXg0B7ACIvPbt4VAT/eqxM3Cr8Mbk2169E
 PE7QTn8aMebYU7RYBYfbR/DHIyKbe5NdaTq4gT/7k+OhGC6wBOB9//VcJ3HANVbd6BVxWHVY741
 dA6eB5l+1SfuLREPTS5v+ztI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 170e20bcb6536ab6;
	Wed, 11 Nov 2026 08:54:50 +0000
X-Mizu-Trace-ID: 170e20bcb6536ab6
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mips@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 3/7] Documentation: KVM: Fix the function that implements halt polling
Date: Wed, 11 Nov 2026 08:54:44 +0000
Message-ID: <20261111085448.1130701-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111085448.1130701-1-fuad.tabba@linux.dev>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic halt polling code is in kvm_vcpu_halt() since
commit 91b99ea706578 ("KVM: Rename kvm_vcpu_block() =>
kvm_vcpu_halt()"), but halt-polling.rst still names kvm_vcpu_block().

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/halt-polling.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/halt-polling.rst b/Documentation/virt/kvm/halt-polling.rst
index a6790a67e2058..c311aac1ff9e9 100644
--- a/Documentation/virt/kvm/halt-polling.rst
+++ b/Documentation/virt/kvm/halt-polling.rst
@@ -22,7 +22,7 @@ savings of not invoking the scheduler are distinguishable.
 
 The generic halt polling code is implemented in:
 
-	virt/kvm/kvm_main.c: kvm_vcpu_block()
+	virt/kvm/kvm_main.c: kvm_vcpu_halt()
 
 The powerpc kvm-hv specific case is implemented in:
 
-- 
2.47.3

