Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E42F7EF1
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172084; cv=none; b=siLo41Dw1oQSwI3BjwwBHgGuWLNAAajGrJass5bKn1/VoQ9rrfsY6JRbFvIWTCa4QcYgg3XiifkgIxReDQCttycAb51mKWd6of6EVbLu5XrDLAUrScEDRone6AbzDhyJyv00/V05mBl6jNuUITmugrhVGcd3MsnK1TAv6tUrpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172084; c=relaxed/simple;
	bh=rqxsimaprYVjujnTGY969FMw+LFcgYA+LhchZVvIVEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsWOracW1jKvJRv8B0D9nLWShvlimctYwGdaS6EWgwkT8kgc6/uHD7N9h66g2zOkQI/RZgGa7uMF20ODGh5rWCG+8sIEuayr9WqMueN3yxJq9msCoLB7RzaBgLDtRsI6UvAxrg+beks0iCuf36LUDlo/DlOaOh/yt/jI2li0pqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7PG7soF; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7PG7soF"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14373bcc010so1027329c88.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172083; x=1791776883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLwPHwcyBpbEdHoUdZEu0832fJUKg87xyYGklLfVx8A=;
        b=B7PG7soFD3o324cjBr6uzuVqL5RKq5Af+xngs6Kcc2saOPElq09vl/qLw2zJAA5fvg
         5EHQmGiAxjqP0jZCD2ts0hEMLhvDbT2TBw7903l/HM6MT5jwqBy05Z55oH31d+xM8uam
         q8Dqvx9U6VGsGlwfP9UU+rARvicAoxAqaWXNFkY5P+/OEWTKsA6AT4Lzs4cm9Fp2O47W
         Vzeyx9jWdKzKeVzn2jVqUJo1TDPy/V7INt5Y+BqKXXjYnCEBx80fgD4BVNbTvB4JfeHa
         EjasiMmOtBvUKaqxsSEIZR29zBKm1pA2A/SZS4hY39LunmAk8iLsBizQhqNKH2Of1VT1
         cPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172083; x=1791776883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLwPHwcyBpbEdHoUdZEu0832fJUKg87xyYGklLfVx8A=;
        b=T0M63Y3ne3sGlj1FNNTI9fQlRHdUMinhBrJdwIwINiU7nzYkx6Z9glyxGKDNTWrpr5
         Vm7nQSEeMs6qVzawZVMT6bBsNBCdylDzn1pscvQ3IKPsugFsbfgs/a5AQXV9Y1HksYyR
         DLyR5jZP+IUnrsLZLOkBNAg5uNAD+4RCnsS7U2rDVsDpYMbVVF0O6dm8adszZIPYKPF6
         3jAp1E51H37Uw+Pmho9G6ZpSvZThQvNm1HwRmq556aXKakJwlTJ71wAY0ndH+djpFTtK
         OCONQ8dhXP3UwbQlEG1zy98p984pePLNmpXyiGhn1hW1Lj+9X2b7tT4K2HZYbU4XWvoa
         J7PQ==
X-Gm-Message-State: AFuF++nrZu8x/LVfrl4XOnKCelji7hq6aBjdLDEfNR4HhppLmhQceqJK
	KRcRLCWCTTeaql8R0352ojkdsi5LSM5CevPU4WwRjmscfY0JhaI5/9A2CQHUUQ==
X-Gm-Gg: AYBFou03+zROIVIeIpPAz2ZkcNxa/BHJCMnUvJu3/RmGQ06b0CdCKrpwsbLqhEDk54A
	bLnBqf6zBJtBKauyPOOFQA58kNp0tTBpZ3bt9nvQZ1j7CwWIdMVHpOyEhyRX9tHZIpeIHo/yjVS
	ERKUe5V563YpLTM1vSVPgl+G5d/7c47KQKH52SWAXUIWa61qbbJs+pHkSTdzh3rZTHj+hEnavq3
	8F3z9lQXxDJOe2GD+sskZns+p6dy4mC4bjGVNSuiNIQLWw7Gtu0ovv2PDKXRJKL4JjLE1i4jWCW
	TSoWTxG632qkwP1pHvlplGFA8By9eVepOO/4CXaeXv64yJyvPtx4Oqbt60tm+Q7tqDtds224aFJ
	Tj9u0PP8vMSa13XcHiz6YyTgw/Lvs5md+FmLc1WB6GeuY9allhJ3+Jg0X2JtPpxxK8WcEk6LO6Q
	+GueXNXEg3+oXs1EnvbNmmVFhltJdgXCbcwYIdiAP8vS0sDfJNwDlF36VIjFOFRoo+USt0pOmIM
	Xe4gQQ/0mtyO3osCyOOl0pEiN7AvYAcOSxfmApH4emT45am7WuHZEAA26b7dg==
X-Received: by 2002:a05:701b:2803:b0:157:cbf6:8a1c with SMTP id a92af1059eb24-157cbf68f96mr2608778c88.33.1791172082536;
        Sun, 04 Oct 2026 20:48:02 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:48:01 -0700 (PDT)
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
Subject: [PATCH v6 4/5] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
Date: Mon,  5 Oct 2026 09:17:27 +0530
Message-Id: <4e9622b3c3329cd32c120175b06bd30a933b8375.1791014924.git.ritesh.list@gmail.com>
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

Same nested TLB/access bit issue like x86. Use the is_pseries_lpar()
check to detect when running nested kvm on pseries LPAR to only warn on
idle-page check.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm              |  1 +
 .../testing/selftests/kvm/access_tracking_perf_test.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index a7ecd7a242a9..57d1bf994fe8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -263,6 +263,7 @@ TEST_GEN_PROGS_powerpc += kvm_page_table_test
 TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
 TEST_GEN_PROGS_powerpc += memslot_perf_test
+TEST_GEN_PROGS_powerpc += access_tracking_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 4415c94b2866..94bfb82f7b79 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -470,6 +470,17 @@ static int access_tracking_unreliable(void)
 		puts("Skipping idle page count sanity check, because the test is run nested");
 		return 1;
 	}
+#endif
+#ifdef __powerpc64__
+	/*
+	 * Nested KVM (pSeries LPAR) can hide accessed/idle, since KVM doesn't
+	 * explicitely flush the TLB for access bit update. L0 keeps
+	 * translations cached so the guest won't see the idle bit cleared.
+	 */
+	if (is_pseries_lpar()) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
 #endif
 	/*
 	 * When NUMA balancing is enabled, guest memory will be unmapped to get
-- 
2.39.5

