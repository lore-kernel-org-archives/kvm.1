Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3103E958D
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176649; cv=none; b=dvUt0A3Im658QmgFCdlzuQXT06i0sr7uC2GBsOe1OUh+LQw7cXNcf782FCYg6ucQJ5k8MuyOZo06/240M0nNsmCJSMLwORDC0TlOZQGPgrAp0xCLOQJUhpBUcbxW6UVFiIFsrE8RUZLxbsCts1ur19l5h/sr2PhGWdr1FGeb/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176649; c=relaxed/simple;
	bh=T8LSXzdMMBigtmoOeSLgAOloW5y/jN/E21D4tN7gU44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+MCUwJiX+IG/iPzMN9hvFpKUaNxnO3xLUbymJMYWSI5ngsEPduoF5MyQ2gmE/c/P7BzLOj66Mcc+OimSmKubTj5awGSjLH5vvePhBBg8IOc44P3b+KA5O7LmosjrmZb+V/VftObD12KftlcwEpvGe7pfbaRcw2Xm1FPZpAhTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+UwIEDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+UwIEDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71BC2BCB8;
	Tue, 14 Apr 2026 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176648;
	bh=T8LSXzdMMBigtmoOeSLgAOloW5y/jN/E21D4tN7gU44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+UwIEDX2Hno7gZ503jzP6kL7LODZ4sZ+n63LCpskA+XB/LGFfhvxV7WdIshMiueP
	 MMT/fvUJSbgCgMW/NpkAKJYpyj/aJ9XcFmqAgqvR826+dY37p7ftcNmsX9hcUpPyW+
	 aodKxUyfnQJDjn1uWyuv5rN9eM+BtFI7/1AUKembwagUrYr9pj0XFP1G6w/eUdUKy+
	 cozWgNeXmuep77Cp7V0HVnMur3Loy2I8qq8IC8V8LoJRzZ5MjblvRQmYFALCC0vPUm
	 PtQjau+pBPSuQJ0m+IlbLzoVgsUIhkn03gtVs0ZbMCdDiKDkxLW0Bbj2nI1mwBfbiN
	 zO4vQaUUNN4Bw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 876FEF4006B;
	Tue, 14 Apr 2026 10:24:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 10:24:07 -0400
X-ME-Sender: <xms:B07eaamlq86m5G7fwWFFR89ilsVMxxDzx0XuBlJMg5xo323pXDsMKQ>
    <xme:B07eaRGXbaDkgYaGFJr8RBXQht6hLx4UgETebC_5OafBcTY7SEBW0NVJvq24OnlG4
    KJtnqKMxTzxlLSNk9o6aMiDCQgTvg95FOW78mrBSzDbQn_2ePchSA>
X-ME-Received: <xmr:B07eabeMbeDUVLk-Wa0m1mAAVLvqnaejVtBwAYt1XNG5BhJBHLWUPfNM_2tmwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfdujeefvdegkefffedvkeehkeekueevfedtleehgeetlefg
    feevveeukefhtdetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
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
X-ME-Proxy: <xmx:B07eaWErl-LdWJDCm7RWmTfhyWg3YDUCMEWb4RILl456wawMgM4uZA>
    <xmx:B07eadHmDpoEsd3AyN0xUeV-fLAvQCQUHiYBBe7xfVuHbpMB1fazfw>
    <xmx:B07eaeNbZ96vkjZ1yFqGzoVG9Wqyy4UlHfThJLX1-emptJRERr-_mA>
    <xmx:B07eaar45yZpIUMhk5LThQEQds1mx9n6UdimwEXg3QZCGnR9QuApxQ>
    <xmx:B07eaXCGWPatpEzoVg1MgpCPmIqFcAfTt3ZSkrpQjgy7K-ulPvEs4HXd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:07 -0400 (EDT)
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
Subject: [RFC, PATCH 06/12] userfaultfd: auto-resolve shmem and hugetlbfs minor faults in async mode
Date: Tue, 14 Apr 2026 15:23:40 +0100
Message-ID: <20260414142354.1465950-7-kas@kernel.org>
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

When UFFD_FEATURE_MINOR_ASYNC is enabled, skip handle_userfault() in
the shmem and hugetlbfs minor fault paths. The normal fault path
installs the PTE from page cache directly.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 mm/hugetlb.c | 3 ++-
 mm/shmem.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 327eaa4074d3..c10d2432768c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5847,7 +5847,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		/* Check for page in userfault range. */
-		if (userfaultfd_minor(vma)) {
+		if (userfaultfd_minor(vma) &&
+		    !userfaultfd_minor_async(vma)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..ce47e77fc090 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2489,7 +2489,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(inode->i_mapping, index);
-	if (folio && vma && userfaultfd_minor(vma)) {
+	if (folio && vma && userfaultfd_minor(vma) &&
+	    !userfaultfd_minor_async(vma)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
-- 
2.51.2

