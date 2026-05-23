Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70796388E58
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534913; cv=none; b=jtKOdA+ke+BPuN983nzP/vssKfW+q+PJrorZLbHtLeEQSmnzhcnre619gV/h/kAisLCJvyuQaKhi0bOBLVyEgFLV9Dubz3hYFWIP4g7SaJP7RTKaYBzJaef//P16nfvY2mycwa+UU/GyyDj9Xd2/oFz4ROFfE9NG7Zq+zZD+zZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534913; c=relaxed/simple;
	bh=CkqwvECTMAFehZ2OT21YjJpmutFK8TTNcnulnKesIu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYLwlPvP6S2yVqTF5gNrtSJpb0FJOcRl6RDTZdu28rtlFLGCUJKpo0BS/llycSP0KUMJf/OBMZlvH82M4t3EMPjsV2Tg4uYqWVd8feWyqwBTEII83EyxOQiXlzhj8DkV1IvtiEc+IPAj3YFCtt8gtqFAxsT0PwjFgbBqg+LKoLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlbv/S1P; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlbv/S1P"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-835b78c3797so3617463b3a.2
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534912; x=1780139712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=dlbv/S1Pnr71XvLhS5Ack3ziGHo0J9nskFswkxecBzlw3ve+A6qiOVcP4hQQn4Z6L5
         pmutIh/obD595aEzz4ZRImnmVBQNxT06Y5hYYcNL903X7xkabwdEn57xrCVuuIoSLQvI
         4SIy2viVR+uuMFogLsjzO+QOLX+RpXtHLFCRfFMbM5MIEmTnKDdW3/wjzbduvSqJ/+du
         /nZs/bx84CGvIlLQtDhNztNsiNTnHpShYhy+cJlRmkAlcwSEsQw3r0xBSMGqsnta4xED
         j4+quCQ4v2gG/7L4mAeClL44Vns9THEvsIxs0e5ZU61LTqsIgdGYY9siElfKWvDMz+IZ
         mO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534912; x=1780139712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=SyhNNuec7UInVlW94WgionCDMBm/5fMhCl1Wo4UXYvOwQhSR/zaV4MYPeZBwOYWg/z
         if1GXAQdWsMRETFof5FiJwirvhruK/FdDIZ8if5XJZArEwneCtvoXyNN1z5MUKwLNIOv
         8vhMLku3lBgQBherNb8G2ErQrQ8qpuUP/Z4LQXdN5DWdBPBxto7da+9Om7fgV91zZMhP
         ZNuoR2HAIRENJZhV0Xyqv2Apq28nav9w2vE77BNM5WNDRUiFmeMbCbQ77Dln1/JMd598
         RHxlIa0h5JXDr+WMkBQQJRaygxQokKxDwe+xBu1b0q6TbslClrj8h7Fler/wtc5ycuZ9
         s41w==
X-Gm-Message-State: AOJu0YzEAoin7udMMdDnQTzwzol6LfTHfDwbAp5HUGa0Loo/MfZ/kbVh
	XCPtXc+gstWvpwwYwcQG9jMlfS+r8LN140Y0UqVEaRy6GWTae6/XLOZRkEhc3w==
X-Gm-Gg: Acq92OESoXEfa7RMRAcjdF3SP7jlgJzLmwehI2yVNUAFg84jxdgrYU1Dtht33jb3/it
	NEH/bPUmxh5QzyaBcSVMJ+Qdntk+h3Q55xCatXqskasotbiMTqjHJVUhlAZaaBTTK42LONyubru
	5615YHvB4RzaizV0pQCwFm+dNpH/frPRIp1BN+Gty/ni/ewqhqJ6+DqCNMPqKU6fM/Eo8DQNTpH
	NyPAjU1e87fPucPtSJ+yTIRmNoi8IXc0rQSvmYxDeS5fLL05RtN+WgRFhwD7AxcdgHdFXTctbN6
	9/6mTzxvtSjhauAG8I8ifOE53oBJg65Xh1sXAAWIWEsNNbVjev+PwjSYPuqp4uoF2MhKxuBfgUl
	rizeR7RYqrwF40aBBt5Unjh0qx1YOxyi8Zfgr9CxxMqb4SaF88yns49NS3yTSm86U1c2IYroHX4
	hJpNSap7jtXi9eNlLE7Iq5Omy0Sb2eGng/OfAs/zM=
X-Received: by 2002:a05:6a00:bd0e:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-8415f3f73b2mr7274322b3a.50.1779534911562;
        Sat, 23 May 2026 04:15:11 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.15.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:15:11 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 4/5] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Sat, 23 May 2026 16:44:23 +0530
Message-ID: <cb27fdc2348a933351619bbf1beff53a242b045e.1779524962.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779524962.git.ritesh.list@gmail.com>
References: <cover.1779524962.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..a82c13d6cdf5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -56,6 +56,15 @@ int main(int argc, char *argv[])
 		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);

+#ifdef __powerpc64__
+	/*
+	 * powerpc has a particular format for the vcpu ID that depends on
+	 * the guest SMT mode, and the max ID cap is too large for non-SMT
+	 * modes, where the maximum ID is the same as the maximum vCPUs.
+	 */
+	kvm_max_vcpu_id = kvm_max_vcpus;
+#endif
+
 	test_vcpu_creation(0, kvm_max_vcpus);

 	if (kvm_max_vcpu_id > kvm_max_vcpus)
--
2.39.5

