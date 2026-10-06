Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D03E559A
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282625; cv=none; b=ZwXVI4fIzquqBWuazLDfLGQ0NdOqbg06DfHsGT2N/xiHBc0Rj+SSjTwyCr+sQZVxe8UefbjRgu9G7Sl9EdF79Ib/4Zcef2mIg+y/dAG1InelG5cJ3qn7QNbLv3qzwGcoh5U0Gzfvy5sNr/ubqgNrbcGU4ZpukDlWajHhkCrMy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282625; c=relaxed/simple;
	bh=KE/VAfOA8574I5li9eEfgHcBUlxNUQrSaLDRnqQEUVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQuM4UARErIRiorKgrOlBSyks38MPyfPkJJrQ0GG74IdiMXqPNsi4yLnQTyw0/oq1LeCUWfFaZN+rHqsmyAgyD8UTq89yAxw2JHuOxuz7gt7fAbBA00q6yuLwsWQlbJHp0D9zSs/kP1BRrMw/ileRjzgWS2GqLPlanIJ6ttEFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZfLOpSt; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZfLOpSt"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so626749eec.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282622; x=1791887422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bol8X0wJHH74pShfR9ELa5dHnrFIGHJN+N1Iz8VFSIU=;
        b=TZfLOpStJkQED5qFzJYyMO8XLvti+Zt+rfPrdWAZoNoOBn2HaY/qXN2tWELVl1izUR
         rpcGYwSsYh+bCi5BqrxAL4qEJFEHGCVOGkmBdBDwEfMsws7raYi24JemFWWnUgHW06ov
         wRlYcmaxsE2FeCgDPTaSIupY2s2TQYCrexgn93+gqsIzyQUD73+7c+CE1NlMVLGRLbh4
         DQSk12Lxg3YWM/V+HQen72Jjq8ubkxDX29ue0R7p3xG0Mh0f3+xSVnG3HlC/kl5s2T8M
         +0jslYZjhqaPa1Rzw386tOs9bzChaypyq0tTW/o3clxHKC/sqTi5v2sv+2gVblUoN8O9
         5Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282622; x=1791887422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bol8X0wJHH74pShfR9ELa5dHnrFIGHJN+N1Iz8VFSIU=;
        b=HUcHi1QLS7vX2DsBd8/OK0HtKxcFoNwOAjIdzk67BsKRMnQcClqZ29l4VRhYfY4l2p
         55rRhhVDxXuOSM/5SIWPrNBwd7R9GMtJw31VP1413ax2Sjnh44rP2tjAzljuPUcwYLuV
         G3N99tqRazmsQO6wmMlcHVnhfUrQAhU+8JkJV+dZKoE6VLD/zdbUFvFVIZc699t3I0id
         AbgkaJqec+qGXd743i6lsXJFs2k4ptf5305NBrcRNYSeH8hYSRTX+dAnMH/S5kBdRBL2
         BTtHKqQukw94iqTiLoNreHAPTCZbJDGTfJm2KfS+bMRlViVf1CoqaqfP5Ra3t7+q0vbs
         +t9Q==
X-Gm-Message-State: AFq9FYKl4j3kSHn40J3RGPjL1EXiAdaNoUbeARKxZvtTCzmcl87WvcDe
	BU8TLDlkbdPJmwKsKOsB8TLTVtuA0tjc2J7XyZbvL537tV7b8saqto/KMCrUt62o
X-Gm-Gg: AYBFou214YCNGdcUDsfNEOAG4QYOnJtjrJAdPcyDqIbIjsNfJAzaxk5SXzfzUTiGrOX
	VqaSOPWuezkfJ0RwPbs3tNh0txbdGskHwrW0im/c0FDEXDJZiBSxaeSdLRT2jR9ckNt6Lpb8CTs
	ZlDXuvbLpXbzinsflfLGpfJ5sPUTjyU14Sfh3OeMwANqGEsps95LK97Mq0DkbUBbCv5vhsjwr+M
	4BO4mLiaLHESAp/2F35QU5ff3Kd4d8rv+K4Xd/LW+95M3ph/vZSU6KqTJ8kDLPGIEdzwBFVZ2tq
	9su6arXEiSI5Gs+00bDsn9iyE4eZGyHet3sOi9f00SLOCDLMIcdkFCAuQwWDq6ygfGl4mjrADxb
	pt13kLZCaBAco+oIJQ0Zk2wT31cNCtbfDVYuDthsX7e3ZV73Q4wQtFCDBEFgKEOJPxMuFjLO6S/
	MGmj/HrD8myEAr2VDI7o6sK+U7q80KJaPUKwIDqjakPV8/0wkbQz0uZIe6mVpChMQJ9mSVseHSU
	K+BuLe/zTMT3BufxW4vWwCLHbrIyd4clrJuZo60vd1QfsmEAAlKUoERjjE4
X-Received: by 2002:a05:693c:88c8:10b0:34b:7c9c:9a71 with SMTP id 5a478bee46e88-3512e446222mr7496069eec.1.1791282621782;
        Tue, 06 Oct 2026 03:30:21 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:30:20 -0700 (PDT)
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
Subject: [PATCH v7 7/8] KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR
Date: Tue,  6 Oct 2026 15:58:41 +0530
Message-Id: <0227000da4e6fe69b278dc971b74b3f65b73ead9.1791280439.git.ritesh.list@gmail.com>
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

Same nested TLB/access bit issue like x86. PowerPC nested KVM (pSeries
LPAR) can hide accessed/idle, since KVM (L1) doesn't explicitly flush
the TLB for access bit update, so L0 keeps translations cached. That
also means that the L2 accesses do not refault and L1 thinks that the
pages for L2 memory are still idle.

Use kvm_is_ppc_pseries_lpar() check to detect when running nested on
powerpc pseries LPAR and only warn on the idle-page count.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm               |  1 +
 .../testing/selftests/kvm/access_tracking_perf_test.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4b7f6ab0ee54..692bbae44a65 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -257,6 +257,7 @@ TEST_GEN_PROGS_loongarch += set_memory_region_test
 TEST_GEN_PROGS_loongarch += steal_time
 
 TEST_GEN_PROGS_powerpc = $(TEST_GEN_PROGS_COMMON)
+TEST_GEN_PROGS_powerpc += access_tracking_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..eb6939065e79 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -471,6 +471,16 @@ static int access_tracking_unreliable(void)
 		return 1;
 	}
 #endif
+	/*
+	 * PowerPC: Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM
+	 * doesn't explicitely flush the TLB for access bit update. L0 keeps
+	 * translations cached so the guest won't see the idle bit cleared.
+	 */
+	if (kvm_is_ppc_pseries_lpar()) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
+
 	/*
 	 * When NUMA balancing is enabled, guest memory will be unmapped to get
 	 * NUMA faults, dropping the Accessed bits.
-- 
2.39.5

