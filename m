Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921683E5EC7
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282614; cv=none; b=V1W4PFgHQ7JI9qYvcYPnHzkJRnm/kZgal0Ok4YCy/Aw6ksMo+FtUQz+LvaEKgNIiZgiEajf+OcxD0FuKE9W8yB3VvDo2YCmlHrlWEhKpvbgqj6vC+jgVTXpqSyd7kR6oJfOOK1zuf43S61op+Gj2miOBzAHMw/htBrHXcHN3x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282614; c=relaxed/simple;
	bh=XTktCJaBUl50p3dwCGibrPPIEyla8e0KXF878DSWLXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uowbusLTOEfVJQ0moaEgZ8jVvyAlcAhN3wmSv/e6GMoRYSavMsFz3qM1qp82PGXju7GcdpS+cAUGIgOiklSjMSgUi9DMxitluJC3aubgO3pGLa5ngZBwrcWvZmA6JESrFmol55Pi8vMsJWsLEOqpkQ7ys9SjjmxHJZhphZqqL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUWtA6jX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUWtA6jX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35120d43ecaso3868866eec.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282612; x=1791887412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s2Zcwb3I3/jpfEE/S/vABdVy3sksCEmjvmUeEvSUJ10=;
        b=rUWtA6jX3UmjmoikLIlkZQlfjjdrfSJkT5PhFeV7nmp5z8DPLVmhEKG49uOoZ/TR0K
         IoQblsrr624vIm0LGyWXl1xhnvvyFRZwhRIjR12uxEC+4X0VlgkUeYp5h96wrFfqSLhQ
         c9BJuDAeB98aJQGFGs8HEPFInRF+j8KJxHo3ZV+/X7CplW6a0Xkm0YKw8yjVj/+lH0Vf
         msAO9PFuf08R6m2gM0DM+RUbWRzs5fuknNpM/gTknhO5t8it7QuT5nq1zLGLBcaKcb83
         pONYkyvljyXxT5Bx+HRhUV4Mj2pq+jSqxWp8ZybPJKQE+IlmPi8RxNUCHLFXrxoMlPDa
         xMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282612; x=1791887412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s2Zcwb3I3/jpfEE/S/vABdVy3sksCEmjvmUeEvSUJ10=;
        b=cxiYenoSka21yrBNXhomYEDFfe3np9PFlMIxvxchYluuhB+vHao1IbhEdLvgr05rcC
         3ZxpgN3zj46k2FyKRT37zBv2oq/i6s94rqeBRlTK/cl3zlJZZUx5jHZSZcnkBlaA+k+e
         /COF119hb/nmhLGCi1LoqECgjmTB/X46XPoubVcWju8tp/jRLFUnxBJ22P1SzRczcII6
         v2XnTA25K7wqKO3OTc1QVq11kLURfETduwZfhIfIByRzpnN69sU45uxfS/IVimScZO+f
         7w9AmqRLscXzym55M98MxNzQzm4XDWAt7k7xrp051ZTEKwGY0oBJl63mE53g8M0qChUT
         Tp2w==
X-Gm-Message-State: AFq9FYJnYrxAPWPyQbGIkOyZmNh7MwUq7/5zzyKqms1fOrY27mrNFBka
	OMA/MwEHNTnr8sm3bpRkS9hV0bA9Uv/Qq6NQENDGFhNXkuUCxVnkrcKhARwUfU8s
X-Gm-Gg: AYBFou2pBTsaOMaXuO4VyIzetbCy9VGk8MxrqDp/nJZPxO6h/knjAbZCfMMMe/YhFxu
	XLbK7gx4dkhTROC5u974En4CYgTliDdFg/I7bvv54K12yef5cwRwo/afAEAn/7yf1Dsq1KDqeOe
	ZlaJJt/IBVClp9p9w7oGoffznoEXIDCcrhagaxKq9Fc+yfy//JYEdRLcqDctYRrdlJIpkabSpRd
	k1YLa2OJppG2LvSBI77XsZHgheKKkCqlqXSgsyRfd0kzURWxV0Um3mOkQFSOQsjKBIa6ftUtl7y
	RcfrGhUUDWN5AMmgB9/0GFUpv4Ccv6ubs4YCqZFE4snvcWx80fuoAFeZP8NeM8JFoOO9QlG+FmW
	ihNZBiBlkl15yECgYdL4YYiTwz1kIUwRNI6n0WUDv+w7QBe/AtAHWyJuk9ove99QeiX1wL9hq3w
	iR1nU7HzEslqSdoDV1/XGWIlR5YuZnw7zminD7O6yIQgbn4UwSMC4+BgSxHMtIuz2OcpAoeHNbR
	iiPU+1Y3hQ/KLfTH41F0tI+8YMoLihM0TGSeARpC045OGGa+QLgKA2fjyzJ
X-Received: by 2002:a05:693c:88cc:10b0:33c:b64a:3b82 with SMTP id 5a478bee46e88-3514df98ecamr955005eec.10.1791282611239;
        Tue, 06 Oct 2026 03:30:11 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 5/8] KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:39 +0530
Message-Id: <294c0fcd19d6b00626e230985cf9906f98934d1c.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PowerPC's PAPR L0 does not guarantee H_GUEST_CREATE/H_GUEST_CREATE_VCPU
hcalls to create upto MAX_VCPUS or hundreds of VMs, this is due to
limited resouces at L0 for guest management space. This helper allows us
to skip such tests which creates a lot of VMs/VCPUs, when we are running
nested.

Note that there is no easy way to differentiate between running nested
on PowerNV v/s kvm-on-powervm case. So we use a common helper to detect
any nested case.

The helper is added to the common kvm_util header file to avoid
sprinkling multiple #ifdef __powerpc64__ everywhere.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9df16c8dc82a..258ae5879a5e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -14,6 +14,7 @@
 #include <linux/kvm.h>
 #include "linux/rbtree.h"
 #include <linux/types.h>
+#include <unistd.h>
 
 #include <asm/atomic.h>
 #include <asm/kvm.h>
@@ -1063,6 +1064,22 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 bool kvm_arch_needs_naturally_aligned_page_tables(void);
 
+/*
+ * True on powerpc when this host is a pseries LPAR (nested case).
+ * PowerPC's PAPR L0 does not guarantee H_GUEST_CREATE / H_GUEST_CREATE_VCPU up
+ * to MAX_VCPUS or creating hundreds of VMs - due to limited resouces at L0 for
+ * guest management space. This helper allows us to skip such tests when we are
+ * running nested.
+ */
+static inline bool kvm_is_ppc_pseries_lpar(void)
+{
+#ifdef __powerpc64__
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+#else
+	return false;
+#endif
+}
+
 gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
-- 
2.39.5

