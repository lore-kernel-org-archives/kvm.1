Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B369393DD9
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419214; cv=none; b=oB/6f4q/pC7RjR5fZtvLa7ac4q3Fg4wtlWc5W1zu4DrTGM6iA6QWxoMc2nsUWnFXiW2ucOhSJPmTUX1ZMTnxOEPQULfsqf+u+DDrXERnOmOs/hFBjJvDvhszsa7z73HSObecpSYStdbnx37QJsJaOxkj78HVcpBMxoZVzkF1koI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419214; c=relaxed/simple;
	bh=Nfygr8MpIrK7JcE/WoxSsKJQvLtZfLIiToBsPwm9bVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTb3P8DTPc9UP21GKwDS+rWNZwsGRmOgbah+LhQPftx1GXE1J4Rf1NX0974P68B+CC6bkThKI9SWuEPXUoL1vxntWRQFGOcM2vM6LTHxzYZE3B2eStsAswB3f3PfjkchvuM7dzQcZIl2CwuW95kdbYHjwWGM1zvCd++cRTCOO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yezx7Zy9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yezx7Zy9"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso13828939b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419212; x=1778024012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKlqfvGeioYCy/1YHyXYlqGH92j3/mbwl8rUOBF5k84=;
        b=Yezx7Zy9h7hGs644cRx0X6c+NhGlr9Bu0VvzOc7Ns60GN2ug3/SGuvKwqxJT/dxB0+
         bmUPGgXL/15wOKW1VeSyotgUg/YVR29L8yVniMX6xpNYSC8FvGha5J2dElqlVU0LwoZc
         TLN624tqkph+9UzEeB6EYfS9ghg7UrxUWMnKTb7GZmcN2Jn0YHveCpbP7/85yxRuetTa
         beYI2ZiKh1b6x8o5Un7E8OnhNJ6tInjQvvyLQyLC5IWDhjlYrJ+EV3AkImGHlg4Hk6o+
         fnI02T8xyM5+4mWRhlQSdLkEYQgyz0iDyRKGXuIZu5P9/zMIP/mjG9P85fbwFEqHTSET
         P0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419212; x=1778024012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKlqfvGeioYCy/1YHyXYlqGH92j3/mbwl8rUOBF5k84=;
        b=Q8eFOQ4ZaO6O3HHBD0LWiX4x5fuFfsIIGHCPoKEO9WcwwyqJ4FanonvwCjzmOx7O8h
         bolnY8etIGwYLtWTa1+pls//2AQglzGV4NVfhbVkLeSSdBlC6qAh97IBWRGhOIehXtae
         fDl9B+PQu8QXe3MaYoVtp174/FnDmEiMLMZcsr8Yg45DYGxovxsIVk1FlKjOLUOZYdDT
         enbKvtieO5JYQlvaLd/JUgXXn94gxt7gkwsrNXJ7EK6xU1IN8S1Zw9j61J+6PNRUxwas
         w+I8EJHtRFTR4SNMNipSi5HfYgVUqOzcTlRu7sqeEvwKeyP78kz64uSflnELLcNkgBc4
         eN8Q==
X-Forwarded-Encrypted: i=1; AFNElJ81ueGWAhQtWSv7eza8CYCeanKu1aBorgC1IycFwZGn6oZqhBaKK/w6a+bkZrJg3DoaIMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMWFvcZc3bMGtYBET9CTzuF+Xucidd6DK7Gm4r09ae6M42IrF
	4kRpKAN5q7RpqybhbxN4Ni82Q17z6U0WUkoEv12avf5c9ANQdwHKqDbS6DTXfcUvLFAWg8wmmuU
	e2lKIT7Wx16+haARLFaqH5kN6eg==
X-Received: from pfwp18.prod.google.com ([2002:a05:6a00:26d2:b0:82f:61ed:8b2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4487:b0:82f:77c9:a89f with SMTP id d2e1a72fcca58-834ddc57adfmr5463785b3a.37.1777419211701;
 Tue, 28 Apr 2026 16:33:31 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:22 -0700
In-Reply-To: <cover.1777418884.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <cover.1777418884.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <bfbf372d037a77504563fc6e1f25306fdaf1f48a.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 2/6] KVM: selftests: Use guest_memfd memory contents
 in-place for SNP launch update
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Update the SEV-SNP launch update flow to utilize guest_memfd in-place
conversion.

Include the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE flag when setting memory
attributes to private. This is permitted before the SNP VM is finalized.

In snp_launch_update_data, pass 0 as the host virtual address. This
instructs the kernel to perform the launch update using the guest_memfd
backing the guest physical address rather than a userspace-provided
buffer.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index d0205b3299e0b..72b2935871fe4 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -32,13 +32,14 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 		const u64 size = (j - i + 1) * vm->page_size;
 		const u64 offset = (i - lowest_page_in_region) * vm->page_size;
 
-		if (private)
-			vm_mem_set_private(vm, gpa_base + offset, size, 0);
+		if (private) {
+			vm_mem_set_private(vm, gpa_base + offset, size,
+					   KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
+		}
 
 		if (is_sev_snp_vm(vm))
 			snp_launch_update_data(vm, gpa_base + offset,
-					       (u64)addr_gpa2hva(vm, gpa_base + offset),
-					       size, page_type);
+					       0, size, page_type);
 		else
 			sev_launch_update_data(vm, gpa_base + offset, size);
 
-- 
2.54.0.545.g6539524ca2-goog

