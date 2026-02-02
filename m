Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AB37F8CC
	for <kvm@vger.kernel.org>; Mon,  2 Feb 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071464; cv=none; b=aV+BqmWDeq2qMZ0QgF+oT4w0d0WtGwjiGr2ZF9xKVfxVuNGa3Iits12d+H4PP2JaJxvNkA9/lgJirCK9Oi8w51zkQuLnfKMPWyExBYP4Waqk3lIgGflksvbfWT2JcufGnF8aHcQZymEph6RtEPVumu1DwYbEpMyS3ETn9NwkANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071464; c=relaxed/simple;
	bh=5KmV4dgrkEB2RUbnt70mUMQ2h5TuygpqKJ3ihuxidvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DpBP9fJtKJibYdFOPozLAQH/nHmNHxuhy6rsUyqYw47ARxuYsvrxt3Stsou2Y2d1QPnS5ZtzvZX9srMJYOrvDOC/NJTZVIe80rBw21bhbGXsHlxip2i9GrcZ+bPr2NO80469Q2zOBKM1GOuhduzlJ7wqFQik7Bi139ptnSey2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMnL7c/p; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMnL7c/p"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3391686a12.3
        for <kvm@vger.kernel.org>; Mon, 02 Feb 2026 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071462; x=1770676262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBnZ3VzpLOL4qeo77W08DpNE8o4qzNbw4Fy/F+yFoKE=;
        b=IMnL7c/p5IWD2xMj/Mp5WkdEMbcfDPrtU0XZ/l+Y3xqAANPOorl3TVF/xIdsoFzVYx
         UhHKM/IyfYRyCOVN+kj9P1Dg6Tl0oSU56KXAH07cyhniRKphH/OxUY4SJGBDsHlDp1qb
         btZ+2ox8Zv8VZTSFXab1gOscLL+CKYIhmRnQP9nwxSlxzThb4k6LbwRIEF8ax0kbWmeY
         MBlJjxo0kpUpT82ocWsVagUGNAZiCHGzsJZABIpgisT/eAGwAfG+oZx2TZKFlA74FQNo
         anlTxweW6G/QIM1uBop0lCxBAt9hvGqTqEkpCwPHCXKTYVgHN8iOA9EygcxPE+i3aM3k
         CKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071462; x=1770676262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBnZ3VzpLOL4qeo77W08DpNE8o4qzNbw4Fy/F+yFoKE=;
        b=LZo6acvoSJG61ICyy80EISIX1pAItA9/ALMCs5aJ6liQH+3luZ1uT1q9qWgiS7XnnH
         MsZ1UpA9tKYxdsmQ1E3tX7fzmYVylaTIXpfm3rI5V/oeasq7dKyfq6ocL9zl2q2UHdOR
         QTC0hmoZN3Ivawh9Tp8amzHOs3fM/EdmpXjBdHdZeNEBEDwae3y1fPGj73P3wX9vQ4bx
         sMImW7qFa+vFIxhyp2pZYstWLMIFaxPmPYXpQJVi3O+UOjnpRJUDzIWia1KDIdV0cUhH
         9IDqR9cooswlqnPoBfxALVRCAKjCt2xCjgaCttHrRk8EpUAnZKLS/ODbgOWGPwhpCJz3
         ZRpQ==
X-Gm-Message-State: AOJu0Ywwc4r/Et5H0M2Ima6CPvpFLo+N17uOJ9nzjhOit8aEzjpgEptt
	wwM9du0tscmIHoBcx4lg7p9J6bWIqvR6qAKMYBEEAxGbLtxC/BiDlrptPLlJ2h2K4kn2TrXURq8
	2y4FCNwEsJEOfsiK7O5sMzTdlJakmQiYG63BmWcGzIyQakzfcr6DYdjFEJRWZcW8vKIxihNow3k
	Q4A3rhEt7O42czwgxXuvoreO3tAGepiMtn0tLMXbxtpWovAz9qcPSRoLqNmS4=
X-Received: from pgda6.prod.google.com ([2002:a63:7f06:0:b0:c65:e57d:fb55])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2451:b0:334:7bce:8394 with SMTP id adf61e73a8af0-392e0116e7emr12645870637.51.1770071461307;
 Mon, 02 Feb 2026 14:31:01 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:02 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <80c165b185cf36cfe2b12386cd7de3bc12bd9886.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 24/37] KVM: selftests: Convert with allocated folios in
 different layouts
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index b48aa5d9f8cd..9dc47316112f 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -269,6 +269,36 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
 	test_convert_to_shared(t, 0, 0, 'A', 'B');
 }
 
+/*
+ * Test that when some of the folios in the conversion range are allocated,
+ * conversion requests are handled correctly in guest_memfd.  Vary the ranges
+ * allocated before conversion, using test_page, to cover various layouts of
+ * contiguous allocated and unallocated regions.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
+{
+	const int second_page_to_fault = 4;
+	int i;
+
+	/*
+	 * Fault 2 of the pages to test filemap range operations except when
+	 * test_page == second_page_to_fault.
+	 */
+	host_do_rmw(t->mem, test_page, 0, 'A');
+	if (test_page != second_page_to_fault)
+		host_do_rmw(t->mem, second_page_to_fault, 0, 'A');
+
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+	for (i = 0; i < nr_pages; ++i) {
+		char expected = (i == test_page || i == second_page_to_fault) ? 'A' : 0;
+
+		test_private(t, i, expected, 'B');
+	}
+
+	for (i = 0; i < nr_pages; ++i)
+		test_convert_to_shared(t, i, 'B', 'C', 'D');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.53.0.rc1.225.gd81095ad13-goog

