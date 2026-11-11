Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387314;
	b=ifgqD7WcXaw7HLp5i2d3kAZR3DZ3ahpPZ+sbuxG3dL9IrrZBM5Pmm4qzTszmFnGu0StX
	 AVPonTcys+UXCJ3psHt05r54TqaQihaSLoMTyk4EcUfSSHVh7VJ81rmpRnWJ5NsLsUKeT
	 FsLrN7Bq7VA9MM7/sDz++DyMBWX4zy3If0OE7Elk7i4igWPGybAlBoPEdR09PdccEx3uB
	 iwOzO9Wvg9aH7KMz/dHamFDji46Mi/LNpO9taxG7xvqE1UqWo3muT/CfnwrMHLi4DmsI/
	 Jub4ZlRTFjUbblZY5te4aXNUP2wulLwWgl6O0st2p2UvfXLpGtDALSmvbvBFqUdILEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387314;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sU/uCzkrcw4yzr4Jgej5zFnIX6J1nsjRWMYoNMeMIes=;
	b=h1ZYCqqlFuKh3KFCfYGI7zTRVa7EwZ5QceYVBj4KebN24gJ6ZIcstKGd1PlAfzkfSl1H
	 hdOZiUNnLf9rWpT9F9bwK/r5vuoiYeS1HLZL6ACIxSwuN3g4DsdOVyzmUr3zHw1VpMU+4
	 jBzQxs30P8EJN6Mi1PtE+tlKE+GkJzxCvqC6TUegY/hlLekFZ+MrZf3QIiHJ3xnWvp0D8
	 UNW0herep3e4D2KHzXtkxzTqkNXFn9qcnRCPHuTKFSsYrTkwthfD8DIF+IFc6xkH/YTKT
	 uK86avRHZhtQ6WvcHBGiAowNhJq4uAnnR0eYX/4eg95i4HZmQgK6cwRoBjlf7YasaKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TBMn4ro+;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38760A5BC6
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F38760A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TBMn4ro+
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qMpJUnOcEqt7DYSuh3G5DlyHK2LhQjmbYg9/ai4nvKw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794387312; v=1; x=1794992112;
 b=TBMn4ro+oyrnj1x8AuMyvcHaazb2xV4AXJWy6Nw6oHS84BcgHPFhuOE0d6LvKOM0FqIGpVkO
 bgD7HAIOpvUzx+LBWvH7oFevDTtHBt9iFcmPEti5WMniWymjCw15TeOdlO8peiGTQJUzW6MBbxC
 RgO4a43oGiH/apIXhuQOuz/Y=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 797d428f08b91c42;
	Wed, 11 Nov 2026 08:55:11 +0000
X-Mizu-Trace-ID: 797d428f08b91c42
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
Subject: [PATCH 6/7] KVM: Fix the range of reserved arch-independent request bits
Date: Wed, 11 Nov 2026 08:54:47 +0000
Message-ID: <20261111085448.1130701-7-fuad.tabba@linux.dev>
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

KVM_REQ_DIRTY_RING_SOFT_FULL is bit 3, so the bits reserved for more
architecture-independent requests are 4-7. Fix the comment.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4b91ef9667703..21207d234618a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -165,7 +165,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQUEST_NO_ACTION      BIT(10)
 /*
  * Architecture-independent vcpu->requests bit members
- * Bits 3-7 are reserved for more arch-independent bits.
+ * Bits 4-7 are reserved for more arch-independent bits.
  */
 #define KVM_REQ_TLB_FLUSH		(0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-- 
2.47.3

