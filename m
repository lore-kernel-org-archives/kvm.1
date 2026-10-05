Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91042DEA93
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172080; cv=none; b=gtYRRpHzebgNeGVUS43aTmMPThsmUUbbUZgi5MeLLcN7wokWqpMcZ8vbJfCFnJjFnf2in1myipQO7NNnvObmgff68g6gv5wRvHd7z6X04FWXDiTmq3MX7m5W3kS8Ki947il0yvyWI2h1FqEPEkQfAX4Vyj37luLf62Ra51qyfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172080; c=relaxed/simple;
	bh=6K0x5TLULsGiDePBL5sXyC+y3q6f1TV2jirLnbU54ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFZengdImE3ONqM5j9rbWF29PMjobbkfn0Cc/11YKwSqWSUz7nvX04SF87aMAKZvk1A6fIcO04d0ERb1tvRELy4gL9i7bHXVpweeuEAihcRla8fp69ZdZRrRNl0AxW/uIAxHJ1XBSnvWVNIv9tWEZ3NbR6xNFMHi0Tt8QRjJCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3g+dv3A; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3g+dv3A"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so3957713eec.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172078; x=1791776878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1SCblXYMeeDfQwJe65yiAdl+ST+ro3b/dUm5JimbFA=;
        b=f3g+dv3A2I5pbNNLG5evyYZhFjfoHf0TaeAT7jZGIhD3S2AkN20+AaqdMC3iRmrlPO
         y5PAEgldTrnzoyC5xnitkfoErAwSjVC60bJBXD1EqwVgi6ClfiDozNd6woXt1CRPk8OZ
         37zhS4lGCS2eBov9f+ZdEo8mSHn20IOMXM1VaGI1udBWQHvcSahy5/NOZG8hr7lipG4I
         oupBS/ugZSVgtxJREhDwG+bBgpVdNSb5T40+6gu+efPQwHZbyDMmS//DIYFM5dnuQQz0
         /wrTNuOIYWhbJyAFffMgWZOHVXr2Iw9s2i6+OwTDVWq3EigazMXYdVMiGq5F+3JxXeAY
         IA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172078; x=1791776878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1SCblXYMeeDfQwJe65yiAdl+ST+ro3b/dUm5JimbFA=;
        b=UbuFQJiCOnsT2prSoIiAU53LewojnwReY53doHS21IyHUrCfqyQMuQpYOHdUTdQQDn
         Wc42iAAqUURxiRcRrCPTU4uDVyEaXmB4/alsFCwS7Y9tZQUbPcBd2RIyaYjeUfiFhhO9
         mFKkH9nprwH1JyIqmx+P4FxIKmVDAADgzssMUV8t9oKN0GtzKbnL3T5KmYNKQhXoLhHb
         mBoVwLGlglo77njxCvpnKt/yq7qmFyHtkwP+G3brLWy0D+6hLdn5FzFPuAlnfFX03DTT
         4oAUYWxCA0TfSZLw17KpoTmLQSe16uQIhF4sT/9SP8osZUgCiaC3C5dyb1K8E3nehdSp
         B0Pg==
X-Gm-Message-State: AFuF++lMMFDlH1OC/U6Mdn0jkKZRsvnX/Cdivzeo8KMIC7XuDx44oT4w
	7zum6Q/KCW6tPq199Tvt3zKrLfv+2rCd0wVHwTDjhov8PgAmwwpcz93arARk7Q==
X-Gm-Gg: AYBFou3bShUZJvZB/cwQpFqK6W/YIAtRLMsi+Ot6JSRKKX/wuD17gYKKh0lZom1VBZA
	EopZu1ZNcKkW1Fb4GlFE3BYENc9ckUn9dpQOQ9RYdB/i3YrOFnMPGTrJ12Te3UUjS15iGvdkVJ1
	DQx8/NmSP/pvbgaL+ATKPpaXEKAXfwmvkK4r2thJsAnzjedqJ3TtPefo3S6NUi1UU9uul7tKX3c
	u+UDScfRGZvqxx9OBDF9XAge+LRI6vBQds78kFC754A5j420bMbReQtyO+hTXYXsl71Ry+ZrbVZ
	EcuK+5p4ae9Qp++V4TbHho3z1TEfU5LI/S1mx7Sz4c9rF1XeYUiRtsTdgK4VnItEIk+1MMLfHYH
	SktPnDWdWYesIQUEIxEFkIplVgQdQHYNQqDTmsPXxRBM1mH3EOeCIUwf1JCfUmczcPwf4V6Rjmm
	VMaWj38fyST5mCApjzvcUS438YUObLerA7K7T4O7gI0+0nzr9vi7R0ZTfyNPiZgmnm4av1GDbb2
	fFMn2KOLV1S8ok383ly7PGzDco34nOMrl1KBFRgQUXh+Hujw4MC+0+B8EB3GFX8VQlwIeTH
X-Received: by 2002:a05:7300:8282:b0:340:9d9f:a5c with SMTP id 5a478bee46e88-351117064b9mr9289417eec.36.1791172077441;
        Sun, 04 Oct 2026 20:47:57 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:47:56 -0700 (PDT)
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
Subject: [PATCH v6 3/5] KVM: PPC: selftests: Add helper for checking if running nested
Date: Mon,  5 Oct 2026 09:17:26 +0530
Message-Id: <2f57ae5266c12f34cb12d68c65abb643d2065ef4.1791014924.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

access_tracking_perf_test needs detection if we are running nested guests.
This adds the needed helper.

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index f0ee21a8e2d4..a46f6828991c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -6,6 +6,8 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include <linux/compiler.h>
+#include <unistd.h>
+
 #include "ppc_asm.h"
 #include "kvm_util_types.h"
 
@@ -36,4 +38,9 @@ static inline void cpu_relax(void)
 	asm volatile("" ::: "memory");
 }
 
+static inline bool is_pseries_lpar(void)
+{
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+}
+
 #endif
-- 
2.39.5

