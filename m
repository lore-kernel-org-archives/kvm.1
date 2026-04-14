Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA53E9292
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176654; cv=none; b=GBfkTL7Lz1DE7/6Fnf4vNtrTQpRfVfmWTR0zvXDM5qaQkikB6Sx/qVkrAZQVSnyZZiW3KCNhJDEmeoZ+sjmwXNZwrfLZ71vynHbTtuoQZEqRBMPgTDq2xQwoRSGXoYNq3AQkq1sw70P2Fqzh3WLRCYkS4CiDQRZyAqpn3y4lsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176654; c=relaxed/simple;
	bh=oOUfU0VXNyHpbUZg2Wz9Ad/eUIXrqX/a1NFbEQbuFDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwlddiS9kqLK4XQKxLFWFE+2R5URqxZDz+w3unrW9Q+THs+ZyT+x4xbt+gQFghrPcy/H3NkroGIN+PLxbvyQKnt4KPBoHOuf/IQtBU9jm5OD28LFKd6wfkDYu8+tZenhyGopTdgZc6zUXVI6jHGMTX/+unUF43Cl3EqtwBFL3Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGCPFRti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGCPFRti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B1BC4AF0B;
	Tue, 14 Apr 2026 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176653;
	bh=oOUfU0VXNyHpbUZg2Wz9Ad/eUIXrqX/a1NFbEQbuFDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGCPFRtijZvEvu1HXnZmA/JE+X1We8vOVr6IiVlOdHpVjH88vQEJbD9DlqBaTXQ1a
	 79oW7Ww9Rx6Fwm+7BbASpPRXsIMjxev/3PjmWHKBflqHcuTaBT4e3sIi76vmYj9hsq
	 2Y170gaGDn2IFT2Xf8F3Fsd5Kd1VDaTZ+zZ2AdYyObc9/E/s3YWIlr0SeeMLPp/H/O
	 kaS89/m6unbSicheEjUdxo/sbaUN48PDWOHfW1Qf07miVgZciaHoNzKCIklO2N5M9w
	 XP258VvGz9r3sl1W+wTtqETUUUTLZFelL5kTyT7xSf/yjIWbE2Q+a0odF5TGnDfNjN
	 y4lwvjyks/H2A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EB9DF40068;
	Tue, 14 Apr 2026 10:24:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Apr 2026 10:24:12 -0400
X-ME-Sender: <xms:DE7eaRJsSqUyKkUujdh5oHCEMfuxxrA3QXSu1wgzsKfCgI-Eos2C9w>
    <xme:DE7eaUGNQ48Rum9mswU4fXgpqLXR9t405IKOfZTwhdrv7zxHM_XYRUR5bOgatmHgC
    d56XNG-aEKeWKaU214rNTRJYe7eC4bS0sIK6YSdrxtc_7nnljnHgow>
X-ME-Received: <xmr:DE7eaezchvjcbOyJ1q4PWG9cqTm81Yy52V3WStDVsCWYLJI2g0bVzLdPMPuvfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfdujeefvdegkefffedvkeehkeekueevfedtleehgeetlefg
    feevveeukefhtdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddu
    ieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghessh
    hhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
    rghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    rhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:DE7eaZhQLnLO_Dfm3ta6I_-g5-mBiDi4wTk_x7AjSAdFMbBNPWcAMg>
    <xmx:DE7eaTLVn3Bs7uGdfEReC3Z-pcEkaKgVWbLYijLzN5Ugl1SwZOh9Rw>
    <xmx:DE7eacCJgvBPdnrwIvAKoGdRB8WFzSTLoIolIzXckarWkkbTRINl5A>
    <xmx:DE7eaURvo18OjfXDw6oxglQ3Z9k1BiyqjAQd2XIoLYMkJTgrQbudnQ>
    <xmx:DE7eadrGQPUzV8QZvZNj92j1e6CsQA118JxIR7FwKdyEVEj7q4NDyOTB>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:11 -0400 (EDT)
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
Subject: [RFC, PATCH 09/12] mm/pagemap: add PAGE_IS_UFFD_DEACTIVATED to PAGEMAP_SCAN
Date: Tue, 14 Apr 2026 15:23:43 +0100
Message-ID: <20260414142354.1465950-10-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report deactivated anonymous pages in PAGEMAP_SCAN results.
Only set on anonymous VMAs (shmem cold = !PAGE_IS_PRESENT).
Both PTE and PMD (THP) levels handled.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 fs/proc/task_mmu.c      | 11 ++++++++++-
 include/uapi/linux/fs.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..fc42cfd5720a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2329,7 +2329,7 @@ static int pagemap_release(struct inode *inode, struct file *file)
 				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
 				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
 				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY |	\
-				 PAGE_IS_GUARD)
+				 PAGE_IS_GUARD | PAGE_IS_UFFD_DEACTIVATED)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
 
 struct pagemap_scan_private {
@@ -2354,6 +2354,10 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
 		categories = PAGE_IS_PRESENT;
 
+		if (pte_protnone(pte) && vma_is_accessible(vma) &&
+		    vma_is_anonymous(vma) && userfaultfd_minor(vma))
+			categories |= PAGE_IS_UFFD_DEACTIVATED;
+
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2422,6 +2426,11 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		struct page *page;
 
 		categories |= PAGE_IS_PRESENT;
+
+		if (pmd_protnone(pmd) && vma_is_accessible(vma) &&
+		    vma_is_anonymous(vma) && userfaultfd_minor(vma))
+			categories |= PAGE_IS_UFFD_DEACTIVATED;
+
 		if (!pmd_uffd_wp(pmd))
 			categories |= PAGE_IS_WRITTEN;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 70b2b661f42c..af5b28901800 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -455,6 +455,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
 #define PAGE_IS_GUARD		(1 << 8)
+#define PAGE_IS_UFFD_DEACTIVATED (1 << 9)
 
 /*
  * struct page_region - Page region with flags
-- 
2.51.2

