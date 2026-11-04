Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775348;
	b=ZuZrZgEWs9clYhAbx8FHNBqVq63uxXnNGQNlXcgdnntzWlWZl06FjH7hccZx+pfcvFmx
	 TNo/ggGw9RPLxK+yoX7P+Ybi4LC+1fUmrH29h1+p1UMD9/st5P25OPoQ+YjZ7GwKbmsLH
	 yLG/C/YnLZ8fmkzmmj8Q+aJ4ffzbLepjUuQ+pHOwpnOO5wcNPSUq7czLB/zU/cw3QgMtn
	 wTmMy7xmKPg/hGREHAMNyaAkMhDXyD7T8a51bYJsBQmHRoKQXvRy5p1XK68kQlacQHsxp
	 tAsE18w65RghD1seTziSXXq5j86zo3rmKRTMy38K1QPKdm2qToExVUHwJKJ2Rf6KE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775348;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=sqfPtn0zg6Qdl7aT0C6LmJN7euXmQOXZY3o9xBLYezE=;
	b=DSLBlEqpxgJ85lW/kJlEDRcd0tK2EonrF6UG8FIFBgZr6qG0VOoNgPIZAP/VbixImO7m
	 ME65dGJxT4c51jrV0dMeUf0eXMdQbL8A4ZPgDJQ7l839xRgjRs/tH+MOjQe8INGksxXvK
	 bYte4+G7SD69oz8I4ssLepOTXsST2oDAufB2IeSXAr+dyLa3XShWPARQm6+gOxqlUPfcd
	 GNxDH9Nx0mn0BRTn71mE7nOnEFNzBqQwHT0WLxGWn75qnbXYXdKJMPrEAkr6C8WVkgd0U
	 fTEqWZfTVK5XppCKkpOWj6kqFYq/XbhCQo8BT8EyqCPV+Yk00B69s2d6PxxqCP9OLVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YAXQsLva;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799F606A33C;
	Wed,  4 Nov 2026 06:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A799F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YAXQsLva
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1C3A20B7166;
	Tue,  3 Nov 2026 22:55:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1C3A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793775331;
	bh=sqfPtn0zg6Qdl7aT0C6LmJN7euXmQOXZY3o9xBLYezE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAXQsLvayck0qZ+zZJrofxVn4uQVnnJkiKV+WQy9TERjkn9dchQ8pgSwlruRpsf03
	 1RUOEj8TM/hldweqhHsNsBua+xvxpd1b1B1Q7OxZ2wVXuJt9NcuIDTPhLynFUL9/CE
	 pZNUNsBVNRCNbLIFGKKe1wB0NjPkBzQe2bVEHHR8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [RFC PATCH 49/55] KVM: SVM: Carry instruction state on reflected plane-protection faults
Date: Tue,  3 Nov 2026 22:55:45 -0800
Message-ID: <20261104065545.15377-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017122501.610248-50-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org> <20261017122501.610248-50-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

The tools copy of the KVM UAPI header also needs the final memory-fault
flags and comments introduced here. I synchronized it as below.

The last hunk is a related header synchronization from patch 09: the
RAISE_UD completion bit requires a forwarding capability version of at
least 2, and is only honored while forwarding is enabled.

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -481,10 +481,25 @@ struct kvm_run {
 #define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 #define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
+/* The fault was caused by the vCPU's plane's memory protections. */
+#define KVM_MEMORY_EXIT_FLAG_PLANE_PROT	(1ULL << 5)
+/*
+ * insn_len/insn_bytes are valid.  For an EXEC fault the faulting
+ * instruction itself cannot be read: insn_bytes stays zero, and
+ * insn_len is the length of the instruction which performed the
+ * fetch (reported by VMX hardware; not available on SVM).
+ */
+#define KVM_MEMORY_EXIT_FLAG_INSN_VALID	(1ULL << 6)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
-			/* set on plane-protection faults when available */
+			/*
+			 * gva/insn_len/insn_bytes are set on plane-protection
+			 * faults when available, and are zero on every other
+			 * memory-fault exit.  They are enumerated, along with
+			 * the PLANE_PROT and INSN_VALID flags, by the plane
+			 * memory overlay capability.
+			 */
 			__u64 gva;
 			__u32 insn_len;
 			__u8  insn_bytes[16];
@@ -1043,7 +1058,9 @@ struct kvm_enable_cap {
  * Userspace completion of a forwarded Hyper-V hypercall (KVM_EXIT_HYPERV_HCALL
  * under KVM_CAP_HYPERV_FORWARD_HCALL): setting this bit in the result makes
  * KVM raise #UD at the faulting instruction instead of completing the
- * hypercall; all other result bits are then ignored.
+ * hypercall; all other result bits are then ignored.  Only honoured while
+ * forwarding is enabled, and only on kernels where
+ * KVM_CHECK_EXTENSION(KVM_CAP_HYPERV_FORWARD_HCALL) returns >= 2.
  */
 #define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
 #define KVM_CAP_HYPERV_VTL_SWITCH 256

Thanks,
Sriram
