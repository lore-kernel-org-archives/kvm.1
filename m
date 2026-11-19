Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074491;
	b=mMBT3MCTGrGUSl1gW/MqD/PiFT85LGOb2ChYqwFOzVvgiCCyWkhA8HzTXOjPrOC96/0P
	 A3uYRH+nCdk2c7jD+RHVNSHq1fy5tB8C1O2A/JjtAJLNpSq/q2Mdp4scWP4LJPEOLqrtN
	 o9E50uo+x0W1d3e/8G3uWHnptN8BlAW8Ye84/VKOAVQlIFOPFqoDRYZpR0lEJb/pFT6XT
	 bZfTa1IcyDL/2l+8xnddop1GeUy7BGdrrYceHNrijnSIvgsz28CrB9hOXxpI/BigUqiJp
	 oRSF5ex4z4a4u84mUfi3MnTwVLo1Ly3i6TzdNgqTIGuzht9EdazhBjDGvnr5s3l001w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074491;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XlDJSyi9j+ARZ1pSnvbzJR+3WOFZ17M85iHDgDnRjlw=;
	b=4DZ0hQsndHaVLLc5gGWE40RjRnKKagEEpWIUynYrIwFFGezbLvpCJjXSLSWyZXpKvgVl
	 AVRed37+oikKMqLDL1KpKOXKvVYP0oUHwXHa65SWjVHmrDaUxL2Zx9MUf7amw7xR8s+c+
	 PvZkMS7HKTxJUUhP5zcldwLG6AnEJGrBVEmyGih7d87nOvRlwHd1Xgmx2W0p4IudBhCz2
	 /WseLY0bqur2Ga+drnpS9MOnlf+QuJrQXNcWhh/9j4FkCyR8hgjccYy6swcT3wPGWAAu4
	 e2E/BIqUez+Hv0hd7zMe9I0hwtKRyvAsfJwM7CNTu5NA8iqwoupSuMxozRbkObr0htA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Efl8vFXG;
	arc=none smtp.remote-ip=91.218.175.43
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCE60A2627
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CCE60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Efl8vFXG
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=M35Q8JweTHDpChhtGlZR4K4Gqkq4axvTIFtPga+8QRg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074487; v=1; x=1795679287;
 b=Efl8vFXGeNuHH0CMp279UwnUDUO7jPqXKVe1LHqngGOVpzCFlW0GUnZEGELVYWFOjNHghulI
 8KZU0BumjUNWcwMFWj1RL5jWWAEeI9PLXZvAiBlTqqEAEM9GvvvAv1c+D4a/R+7VjOtG3GXoEHf
 BnOB/xg4xL7aqtc1Jj71axL0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 16235cd6a3feaffe;
	Thu, 19 Nov 2026 07:48:07 +0000
X-Mizu-Trace-ID: 16235cd6a3feaffe
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
	Randy Dunlap <rdunlap@infradead.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 3/7] Documentation: KVM: Fix the function that implements halt polling
Date: Thu, 19 Nov 2026 07:47:48 +0000
Message-ID: <20261119074752.1027729-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119074752.1027729-1-fuad.tabba@linux.dev>
References: <20261119074752.1027729-1-fuad.tabba@linux.dev>
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

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
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

