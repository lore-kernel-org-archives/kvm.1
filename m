Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7C1E5714;
	Fri, 24 Apr 2026 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777010747; cv=none; b=HwqR8Yo3Arqt6SzQbpOWd+fDhwUwequL3y2B4cCVlDvFmDHB816K4Dn+1iqbmC4CEC3yye8WhnDWQOBTj7i2XTv3uDxZnodEul2jwmMxa4B8DvsjPSXiQFRtIDy4p+jg4Z1Kg285gvScbYPr78L1EjPq8UcA8OXeXGGVwxm0/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777010747; c=relaxed/simple;
	bh=KPY9LU+s6/YDRas0SFY1KqBhJRbkyGskwzXCiErzSPQ=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=AguzVpajgaVb2uvEGegcPFwgNb1ZfeZdCmWNZjOuZpH+ZxSAInQepSbP5b1PGyiatR493RIyGUHGTgss86zcGs2t1LVakQCxUFttHrdARy+4RnPIWcXJfQjT9MjdVyZCCvdP1/dEOxlCDF183a/9BeWDbDBiPL+H73KwiruSE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h21B76iN; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h21B76iN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777010732; bh=VJqV86Sgq8sxLBsspfWAxFISZUkddb4uMrE2fByw0wM=;
	h=Date:From:To:Cc:Subject;
	b=h21B76iNH/mIlP+fg4/M9ootZUoxYYTiA2chRAFRbA9y8GXfbjNe85YDu6e0ZcMBP
	 7wGm8NrTXSys9EdUuEeKKvjP5OyqeX2i0C4kcHcWivxW0JmV+YEqB7Jo0nxlBBV6+z
	 VJ46jm1d/yRqukGI+ReTEZSl2h33kzXTwCPPjxE0=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 15E01E72; Fri, 24 Apr 2026 14:05:30 +0800
X-QQ-mid: xmsmtpt1777010730tf7gck55k
Message-ID: <tencent_DB120129B359660BBBD7CCC9681F507C0105@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznyGnvpbpn/g1nLxH7SdtCA24fqg4vXsfAG27TBxKSY/RP/zuud1
	 di1ZjLCvzpHkY3BYz2Jfnjp6FbtGO5DmG4hyHuYlDRcf+7kHoiGzSBHqT9OTwT8IZDae/WMhb6a7
	 3nwbwNQnDvAOprSO16qk7UCuWqpTVb3idfAPeqZVlZ+BqsWzndiLSQ/27YwFZlC1KID9JjumDgaj
	 ZzEFYk02qf+bBk++ekMoX4BpS/Dcd1jWYr7JagjLGzdQaN7GPlg6w9Os24+dcTuJ9HnzBGih+vwX
	 fW7Z5LjyM7+diehglfNKU6+MPLRp19k+T02v4IDFow1Q5u6Ehdh05+ikmRYtMvy9p9k2HOAqNVBL
	 9l2SElu/M6qWP8lI6gObvMXF2YTYPreBh+XAumbrRkoScEyfVa8slK21Q0iPDYyO2Aw8K2fzdG5Q
	 pvDrg9J+NULrGgV2dN3VBwsFJKS7G/tqE3wCbXs496WAu/gSEez4QEo7tjYDOUdTZhn4CD8Ddakb
	 /nkvAn41zlHR77RVetzoIhBiHdhWwriHL3xw3hy9TlBWbDRilOA3xbjkKF/CeAcwLcVGN0PrbmJS
	 2vuAlTyzU0npemSXmQumLP5+ryg5E+vPLQmbsKR4Hi9wDoxKcHs8O+7cBJz0/8f6kThs+N4UKzRt
	 Pne7Gy8XlaEh7fRNA/nXngD2e+EDO0+Qm1yFHvqmSQm/QL/dm4Guv1kYJw+fu3gGGDhssT567Iz2
	 1TIrvmN93N/gb4GRn5FolARmmg8pl/n7fETHHUdil8hAJCJ/2vcLp5VMfTpneg2bcthaBOD9hz8y
	 1KhqFBw44WpAHQQyjtBWl35i2KOz+xpsuUudgexzsSVeu93PXTXTgahWuYcTpZXPQnhIkn0Sbsab
	 WK+7gG7/FMKZpN/knYmOCffR+B+hd3mzfNa7zVt/iSwgK8UIRuTnDCDteNP8UBnDHOdW20EFoVN/
	 4HUE7i5jtowdBTXdBmzehKcCejNA9ZuwTVX5Bl+GOpuFgqO/eES9MR7ToCwbZNP8XSSQv1Xu9c8P
	 ogsqgIq33ySJN5vZUC
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Date: Fri, 24 Apr 2026 14:05:30 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: enrich kvm_fast_mmio trace event fields
X-OQ-MSGID: <20260424060432.GA119955@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

kvm_fast_mmio currently logs only the GPA, which makes fast-MMIO traces
less useful when diagnosing access patterns.

Extend kvm_fast_mmio to carry access metadata:
  - access direction (read/write)
  - access length
  - access value

Update all x86 call sites to the new tracepoint signature. For VMX/SVM
reserved-bit MMIO paths, keep length/value as 0 where detailed payload
is not readily available. For TDX MMIO write path, pass through size/value
that are already available in context.

This improves observability while keeping existing fast-MMIO behavior
unchanged.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/svm/svm.c |  2 +-
 arch/x86/kvm/trace.h   | 22 +++++++++++++++++++---
 arch/x86/kvm/vmx/tdx.c |  2 +-
 arch/x86/kvm/vmx/vmx.c |  2 +-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..1820a78d3e70 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1981,7 +1981,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 
 		if (nrips && svm->vmcb->control.next_rip &&
 		    !kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
-			trace_kvm_fast_mmio(gpa);
+			trace_kvm_fast_mmio(gpa, KVM_TRACE_FAST_MMIO_WRITE, 0, 0);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
 	}
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index e7fdbe9efc90..d04d05d17d77 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -207,19 +207,35 @@ TRACE_EVENT(kvm_pio,
 /*
  * Tracepoint for fast mmio.
  */
+#define KVM_TRACE_FAST_MMIO_READ	0
+#define KVM_TRACE_FAST_MMIO_WRITE	1
+
+#define kvm_trace_symbol_fast_mmio \
+	{ KVM_TRACE_FAST_MMIO_READ, "read" }, \
+	{ KVM_TRACE_FAST_MMIO_WRITE, "write" }
+
 TRACE_EVENT(kvm_fast_mmio,
-	TP_PROTO(u64 gpa),
-	TP_ARGS(gpa),
+	TP_PROTO(u64 gpa, u32 type, u32 len, u64 val),
+	TP_ARGS(gpa, type, len, val),
 
 	TP_STRUCT__entry(
 		__field(u64,	gpa)
+		__field(u32,	type)
+		__field(u32,	len)
+		__field(u64,	val)
 	),
 
 	TP_fast_assign(
 		__entry->gpa		= gpa;
+		__entry->type		= type;
+		__entry->len		= len;
+		__entry->val		= val;
 	),
 
-	TP_printk("fast mmio at gpa 0x%llx", __entry->gpa)
+	TP_printk("fast mmio %s len %u gpa 0x%llx val 0x%llx",
+		  __print_symbolic(__entry->type, kvm_trace_symbol_fast_mmio),
+		  __entry->len,
+		  __entry->gpa, __entry->val)
 );
 
 /*
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..2b4acead3d0a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1403,7 +1403,7 @@ static inline int tdx_mmio_write(struct kvm_vcpu *vcpu, gpa_t gpa, int size,
 				 unsigned long val)
 {
 	if (!kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
-		trace_kvm_fast_mmio(gpa);
+		trace_kvm_fast_mmio(gpa, KVM_TRACE_FAST_MMIO_WRITE, size, val);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..af26b895f267 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5970,7 +5970,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 	gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
 	if (!is_guest_mode(vcpu) &&
 	    !kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
-		trace_kvm_fast_mmio(gpa);
+		trace_kvm_fast_mmio(gpa, KVM_TRACE_FAST_MMIO_WRITE, 0, 0);
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.25.1

