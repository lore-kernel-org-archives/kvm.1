Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E437CD2B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382411; cv=none; b=fVR9YN7J2eOMCofnPFjxP29r5L01PDQh7ofKRElbtcoi3XR9iZfNBgbyTdOnEAM/oZ/WYH4xd/xQBH17GiaxV4GPKl4cG40ZPLPSqX8hIUWmOOqgW3uaVpUzAUY/ol9rm5/R7aGi3lkZT5bcyZOdwJU3QCdmIyyxxbDezcmjpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382411; c=relaxed/simple;
	bh=MEMjE4y0f6LhKehfiB3tEKsufTe0/3lqX56LNLOryw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MuS6jF9gMD2x234oi42VI6Hfv8xWPAPuvmTyp6jBjZ2BeI5K00A1YaCQkt+9C99rwrRa5JvOYUHmhmplytyxwhm9LxRbSKlaAyLxLAZErO91VlD/ge5ONj5UG+FCB4tVqIscMX7O5/SXOhsVPW6uROH4dkJoF66z1y48DBbRgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCvpItMr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCvpItMr"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1572461a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382408; x=1773987208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy9U1Yzq6xW4Th7f+ij9YnI65zWgo+o6WIuvEc9wDEI=;
        b=PCvpItMrjaeVJNGTuPpKNj5fOiZLmSkSLpRzFSncoeyM/6KZBHNcqQSWQm9UFyA6vG
         vn1koSVoD3UmqL9LfQ1FYvb8gRGvOTiyu+0wYKEkmK8YImOZ0xaWA2wcUmpKIJ6Egp+q
         kvnkFOP0wATHEQ0o9QCX7FHje+Nt6+aZC3LGos9qUXQ1fEQrkM8JOmEQ3QaTpyPZsnY8
         LekJPDI6gHnsPoYV/Afxz/NbVV6fQGvv82s33Cqp7qcutiehXHGGtm0yglruW60NEjC4
         l4G5Tww0J2LcZduRIo8QDDoJs+1xixaFX55v8Js4BTfh1lBLBWE8iBlTDJ+MrgkeuUlk
         o2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382408; x=1773987208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy9U1Yzq6xW4Th7f+ij9YnI65zWgo+o6WIuvEc9wDEI=;
        b=RrID9k/aHSaKpF4lS9bktDZruRmTIp+P2pbdjGJvHy0giCBwSwJD8Reum3awYn5Sn6
         cjsdILY8X6tisZo7M3JzI/3tgEZpTgtdut4FAIm++ffsbLcfiM3alGs9y4MgZM2vW5hE
         zvAl0QWk/2GGMIQ4jYL6vbbGMN7oN+Kcr4lvZ8HwP9qgsJGlTnWLDbWOVnDJzbgrzUfO
         N3PDpCCrpNBkLfbrmohlCItHLltBUR1UraW6DxEoKH7Qe0RnPT6qDq3PuBsRulRocDY+
         ymnYa6otqtSbODcwBKH9JmLRZo8B1w+EdfQKknBH359oD4dxUQi1G9GLDb/S3UdEZHAR
         92Qw==
X-Gm-Message-State: AOJu0YxFQMEzZx7YjM9hjAyoKd0g3t3Ha/HgzHTFFQWCyAlIwI/QBKuW
	LbxtWYhIM0iGbKTHEG7qln8CgWdQRcuMYP79Z/B7hRKYaRVkMCxi628pgg6Di+IoUf+Nbgm4OOJ
	F+umiIBS4Ax4rjQOpP1zNk8GVOA==
X-Received: from pjbfz16.prod.google.com ([2002:a17:90b:250:b0:35a:624:7b40])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d2c8:b0:359:8d70:c4e2 with SMTP id 98e67ed59e1d1-35a21e9918dmr1865751a91.11.1773382408169;
 Thu, 12 Mar 2026 23:13:28 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:03 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2213;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=MEMjE4y0f6LhKehfiB3tEKsufTe0/3lqX56LNLOryw8=; b=oNq0kuW26yPSYn9oq/nhubUv5O2dPP0/W8tRj/6R2mWwZXnJf1A8F24iejaOWNgvwxoSBckOV
 iuOURBWHN2HA7FkQ/wo060NPdk3fi8GDpTOL3GcHBC/7nPnhCfrsT3v
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-24-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 24/43] KVM: selftests: Convert with allocated folios in
 different layouts
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

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index b48aa5d9f8cd4..9dc47316112fa 100644
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
2.53.0.851.ga537e3e6e9-goog

