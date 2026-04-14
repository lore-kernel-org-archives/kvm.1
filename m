Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F103E8C79;
	Tue, 14 Apr 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176650; cv=none; b=a2EBBWkNEGiMmQQsNbaHeq2CoEIqAWRkENphpkQGyIim4Mt1mMnTm1TvkyVJNkAM+R5009eRmIfSuOwMpgalbO+CYGKxQbobOIjnGa53zXxll5qZjwFQZrnbbBGrp8FFiiQSGU9Er6QisC72LjAc7YJhoHnOibLiZ9w5GrnkNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176650; c=relaxed/simple;
	bh=m+QZFSoN1KHyBpdT/lFOUcMBNfMoQG8FWyZoa+3hWE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi68ncTM/ozwGxPiHD3/3DGslFf4r4qL1WA654Bjh5jTlQ9azh492QeUKbLDz2FcI9LxfHM6/qCgctjvCgOuJLjp4LRut3DYmUEPYMqYhGyAdvb0nXhNkGMrF3keW0U0ep2L8e7GZ+D+MPZW5J1MjC4RPqHZJaBZn7kZpjgkMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3N3FcF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3N3FcF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC1DC19425;
	Tue, 14 Apr 2026 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176650;
	bh=m+QZFSoN1KHyBpdT/lFOUcMBNfMoQG8FWyZoa+3hWE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3N3FcF8j1cl9QhM0roD5U+FQK/bk8whCC91NDffJsKAn3I3Dw1WAuV8QnPA4vvzh
	 w/bpTNK1D8emkJd9Bi57CcDL5Dc0nOQAbp+YRFl7H9td2UAyNFQr33yAmzaEZaISQh
	 hKPvJgpgmEotVPP2ntvhnnOc9M4iI9s+NJ9X8UqgH8agfD9REyRoiyUJi2yZ8UlFPr
	 C5TokRgk3GrjlbbAj0KNvs3sMevo6jWrIPm7wcBdsUImKv9yl5q8zmJtjZTyvCTNEn
	 gByarjgJ8H6Hf84kivOVCxAd4ch3Vx0kdt6ka8iOcIR+lvPdaTS9TT7WBZh5bqmwbu
	 lG3/9vOAT1i3A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D52AF40068;
	Tue, 14 Apr 2026 10:24:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Apr 2026 10:24:09 -0400
X-ME-Sender: <xms:CU7eabIpxTPG45onsRcikDQxMRXerezZzHYli_8nk_CTT1BhP-t9Uw>
    <xme:CU7eaWEKZA9px65WkVS8_nbZSiQhowTvJ2erLXFIEJMFZhZnTl6yrvME6v8qeN7b9
    soP1tMegTqA-Yy6BGrgcvniiS8fmqQR2UlrP4a-98LtpPM6hH_hLtU>
X-ME-Received: <xmr:CU7eaYzjRtC2l3_b1TUA5PmMEWbkR1ZOSVZ7gPb2KfkrpnlxpwcBN5wPp0XS-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepfdfmihhrhihl
    ucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhvdefvdevjeevhefhhfevudefudejfeduvdekheeludfh
    iefhhedujeffffeigfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    udeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgse
    hshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    uggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:CU7eabjiZLALMUNh56rbUI0YOZY01Gh7ZIfSB8kVV0GuL2UFl7PB0Q>
    <xmx:CU7eadLMpGoLRW0PkjUsjA-ww25wco0zTFQ7E0mKOZ6gY9t0TO0eHg>
    <xmx:CU7eaeC4meJ0gyd_L6D8X5Fc71Mb8yuIMJ0p8iNmxm07QLi_J2ZrWQ>
    <xmx:CU7eaeQ_WXkewkruAKXcO7rZSYkx3YczRIJ6JOc54XpCC0XBsx23gg>
    <xmx:CU7eafpamlT3pfumAqUGcRCV3xHiBgfzrn2luZ8stq86Z4dwMnYNs7lw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:08 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC, PATCH 07/12] sched/numa: skip scanning anonymous VM_UFFD_MINOR VMAs
Date: Tue, 14 Apr 2026 15:23:41 +0100
Message-ID: <20260414142354.1465950-8-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid protnone conflict on anonymous VMAs. Shmem unaffected.
NUMA stats fed from uffd fault path instead.
Add NUMAB_SKIP_UFFD_MINOR trace reason.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/sched/numa_balancing.h |  1 +
 include/trace/events/sched.h         |  3 ++-
 kernel/sched/fair.c                  | 13 +++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 52b22c5c396d..5668074a4271 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -23,6 +23,7 @@ enum numa_vmaskip_reason {
 	NUMAB_SKIP_PID_INACTIVE,
 	NUMAB_SKIP_IGNORE_PID,
 	NUMAB_SKIP_SEQ_COMPLETED,
+	NUMAB_SKIP_UFFD_MINOR,
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..02e79b56db28 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -728,7 +728,8 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
 	EM( NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )	\
 	EM( NUMAB_SKIP_IGNORE_PID,		"ignore_pid_inactive" )		\
-	EMe(NUMAB_SKIP_SEQ_COMPLETED,		"seq_completed" )
+	EM( NUMAB_SKIP_SEQ_COMPLETED,		"seq_completed" )	\
+	EMe(NUMAB_SKIP_UFFD_MINOR,		"uffd_minor" )
 
 /* Redefine for export. */
 #undef EM
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab4114712be7..57beb04562cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -25,6 +25,7 @@
 #include <linux/hugetlb_inline.h>
 #include <linux/jiffies.h>
 #include <linux/mm_api.h>
+#include <linux/userfaultfd_k.h>
 #include <linux/highmem.h>
 #include <linux/spinlock_api.h>
 #include <linux/cpumask_api.h>
@@ -3459,6 +3460,18 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
+		/*
+		 * Skip anonymous VMAs registered for userfaultfd minor faults.
+		 * Both NUMA balancing and uffd use protnone PTEs on anonymous
+		 * memory — let uffd own the hinting. For shmem, UFFDIO_DEACTIVATE
+		 * zaps PTEs entirely (no protnone conflict), so NUMA scanning
+		 * can proceed normally.
+		 */
+		if (vma_is_anonymous(vma) && userfaultfd_minor(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UFFD_MINOR);
+			continue;
+		}
+
 		/*
 		 * Shared library pages mapped by multiple processes are not
 		 * migrated as it is expected they are cache replicated. Avoid
-- 
2.51.2

