Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B293C872F
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563933; cv=none; b=gTYNynD3C1DKGw9KgK7QpikXjHXWXQ7LfMn1cHMdSy2hvhym/yieaQx/WGKbYbXPAl6AYQ2eWg7J+JD2aJM1X2pOPX2cuAFt5u0u/GoAx/qZ8KSDTVLyezRCu9luIkNpqzhTx7E8LRjRshWSPKXvp6nY9At1ZM86UDCdKOWmHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563933; c=relaxed/simple;
	bh=2ZYGthoKRbcvONZFk1cPKbY2ke749z4V+HjyMMraW/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bkhQAtRwE0pOF9EykHZ0oWZzKzOsTBn0L6DGNZ683vd1ymcvVcawMtx2BrKw2uXoUEOrqCVA+TDSy04h2SrTM2WwH152YJdx0BIQAPrzdN8xCJjuaCSLtW0J5LxEXC1AYRQUS0UI41ULTFlS7YAt21LSiFXEYvBLb8zK0h/Mihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA2XYR9P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA2XYR9P"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35c0bd3a968so1468149a91.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563932; x=1775168732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM6bcucdXi/Ue6i8Gkw8+ejbHTWQvbY6+osZOGX6pUs=;
        b=SA2XYR9Pcw2sO3cMCtwq1AB53c20PAPn6O2RXTpzkcLIc9wStt99NA/rBbPR1xurFE
         IHw7Rc6XHWv22dzyxo9MMebcybRHTA3n9b97PNwXWSKsf8d5G9qSHN0dxEIPDifz7pda
         bKsGMpxR6oI+QHmSqaKa2WzczX5F+t8OwxxDeoUVZXP6rE0PGhK7WRQoaSIeCvhvEAH+
         O4qRPeJHxLsuKLeJhYiu4Bh7VhPjeUVsIDaL5HrsT1Sjss7kY/BIKAG878tEaYRwzvzv
         zlAE7kBEyT1g9NTNQaJT4hU3xIWFmenuvZzej9+pl0zAQblNMiKq7itcm+y/g6O98Mv8
         sGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563932; x=1775168732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM6bcucdXi/Ue6i8Gkw8+ejbHTWQvbY6+osZOGX6pUs=;
        b=JODpa+MEd2HhKBZ9DBEQ6KyI1oi1C9UGTXfcEY5H/VDlE81XOL6CiIEHac+IF0yhFM
         g+Eu2RjWyVnoKB+ILDpay/j1ImJWgDj+wsKo0UHGu4L9ScclPs2gTBPmQNIonKL3q+lu
         99Us/MVG3hMVzVikbF8+hH1o/3PuD8A5DquM5zy34PHu4kgGbz1YppfafgCtOZc5Z/ck
         8eToMdXiMyhAnbhsfnDv6VEhZLfVOxmdz8HOZkD0UxMj2EbHWzxUaybw3NcjCdQA8PKM
         9rK+RCW/93dnrCtITrTDb+DztVUlvWDdfa7o73WeXO7h2WTMjGu5wTxOV9cbSIGpC7Q2
         ww0Q==
X-Gm-Message-State: AOJu0Yz8qC84XWzCBefAyjplotLXVigVcQ1f4q5+bqj7Ip5QlhVqixbP
	2H56dMVTT4Xj3RAPHpaEeRSDuDzbo9U6624wm5n49il+m0IjQ3NHEGdE5k902uIBuYyWVMnIhyP
	p7hCr0Luv9Zfpr4dgFqJ7f3+0Pw==
X-Received: from pjvg12.prod.google.com ([2002:a17:90a:db0c:b0:35b:963b:d15c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35c2ffb6610mr255604a91.4.1774563931699;
 Thu, 26 Mar 2026 15:25:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:42 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1295;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=2ZYGthoKRbcvONZFk1cPKbY2ke749z4V+HjyMMraW/E=; b=VuHoCdb1cXqd/SymNBIuKfRDMf7jBA8kvor2Rc5njfBTsWjLGscdR6iz+qugvp9JbPMpMjCNe
 rHxLUQdCHQNAA95+Me/U0IMElwV2qBwPhOOGr5EKNAKqarJ2Dw0SRzt
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-33-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 33/44] KVM: selftests: Test that conversion to private
 does not support ZERO
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Test that conversion to private specifying the
KVM_SET_MEMORY_ATTRIBUTES2_ZERO flag returns -1 and sets errno to
EOPNOTSUPP.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_conversions_test.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 4ccd3d515bb26..c0abc69f15332 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -488,6 +488,21 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(elevated_refcount, 4)
 	}
 }
 
+GMEM_CONVERSION_TEST_INIT_SHARED(convert_to_private_does_not_support_zero)
+{
+	const loff_t start_offset = 0;
+	loff_t error_offset = -1ul;
+	int ret;
+
+	ret = __gmem_set_private(t->gmem_fd, start_offset, nr_pages * page_size,
+				 &error_offset,
+				 KVM_SET_MEMORY_ATTRIBUTES2_ZERO);
+
+	TEST_ASSERT_EQ(ret, -1);
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+	TEST_ASSERT_EQ(error_offset, start_offset);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.1018.g2bb0e51243-goog

