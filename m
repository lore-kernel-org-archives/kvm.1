Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185C3E8C5D;
	Tue, 14 Apr 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176640; cv=none; b=fh0+e5k7UsfKOBTfCsYA+Ux/Db3lEjshjgiBdtoQ9Wlu4rxZXV+R8DdB2oSrNuyrvgpcHtzV/BsZHfC/uVTKfu9dslTvwjuNOCLChGW/ohj2ALKib+yPFqBKD9WYDWDL+ZUyfBbWcJ+0BDqcp4Rj3TWBCJhfi0QxxUdiv1XHzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176640; c=relaxed/simple;
	bh=D3Xb8PeTvLmTI+UVvNhEzjipl2DCTEFkVuBJpSK3e5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBnrnsTdZxJB5bo84meijjsOmuxy6NZUGQEc5Kxdnd8zcghrkuCBTJI9OKDUQQp2yL9ZmkIp9+xCeAETxpuTW+ZVaEjNXwi9+jFyYDnLAy/iN9EVIcwIffk3L88/zALug2sqhzmwMKt0FM5+oWg30Eqz9ygsqIwoUpPX2Qah/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne7QX6p4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne7QX6p4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF77C2BCB0;
	Tue, 14 Apr 2026 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176640;
	bh=D3Xb8PeTvLmTI+UVvNhEzjipl2DCTEFkVuBJpSK3e5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ne7QX6p4nh9f/KVkal6ql22E5r/yWYe9JHa7nSlxz3j6Ic+3FzQVmlFp+3vAuTlat
	 v0HqOSM0yhyjH6x1IQIW9w1yjn1IpsgQgDA/ke4oZiY/c7jkPkLvQfTXTCThogjp9c
	 ZZ3+3pIh/vV6BvtlvbyB+osol2DpabaFs7qIIRZHHN4zTEmevQYfc0MyFMUA4qppiy
	 sdM/Otrt5Eojdb4TREddxEgauSm1zgx3ntLtbVEHXfIQD7M+Bz89OCnyxFO+NHEVs6
	 XhYHb8/aDtAjTsZdr3Zbwz6M8YnRJuertzI2MGpRZHLYHmlPILZh/g6rUS8mxGV2eT
	 Hh2UjFnmMz96Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CED13F4006B;
	Tue, 14 Apr 2026 10:23:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 10:23:58 -0400
X-ME-Sender: <xms:_k3eaYmXrNrN-qr501zOHDvLusSEZrkoDcPvW9apto0ahi-91bljqQ>
    <xme:_k3eaez40MANzPpm30026fJ4PDz3487xgWxj9TEKvvM2fmiAib5Dg9Ql1qdH-EGrQ
    bxyM_XfPNKMvU9VFC49vbAR3DFmTmm4LIkTabJS0zeWN7cNi8IF1qg>
X-ME-Received: <xmr:_k3eabtWHaxRcRP1t_HLdqSd-Q6r5vaa2gb_6yQl3oZxbQxQy1v0GkAOlV40tQ>
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
X-ME-Proxy: <xmx:_k3eabsnhOdE9eKCW0R68cYIHgOaEaZxDTCFAzAVBLPx25eeefpF3A>
    <xmx:_k3eaRnhuTNrXVfuV_mLnq6M8pGgr3R6DMaF_omhSOYQchz-nxaw-w>
    <xmx:_k3eaRslP7TT9Rcx3n0gDnpay90f8thXQ4qARLyxXIiEqh_TLbKebw>
    <xmx:_k3eaQNXaUwZz4ioIGby9lE2uyqI55Lashhrx0c0ggrmizG6SCA2Yg>
    <xmx:_k3eaS0NztkyBvinGJLL4VbWZxe8tP2fhhjcyGW5Tm0TQzPqLjo0RaBw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:23:58 -0400 (EDT)
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
Subject: [RFC, PATCH 01/12] userfaultfd: define UAPI constants for anonymous minor faults
Date: Tue, 14 Apr 2026 15:23:35 +0100
Message-ID: <20260414142354.1465950-2-kas@kernel.org>
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

Add UAPI definitions for userfaultfd working set tracking on anonymous
memory:

- UFFD_FEATURE_MINOR_ANON: minor fault support for anonymous memory
- UFFD_FEATURE_MINOR_ASYNC: auto-resolve minor faults without handler
- UFFDIO_DEACTIVATE: mark pages as deactivated (protnone or PTE zap)

Not yet added to UFFD_API_FEATURES or UFFD_API_RANGE_IOCTLS.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 include/uapi/linux/userfaultfd.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 2841e4ea8f2c..336d07e1b6de 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -79,6 +79,7 @@
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
+#define _UFFDIO_DEACTIVATE		(0x09)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -103,6 +104,8 @@
 				      struct uffdio_continue)
 #define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
 				      struct uffdio_poison)
+#define UFFDIO_DEACTIVATE	_IOR(UFFDIO, _UFFDIO_DEACTIVATE,	\
+				     struct uffdio_range)
 
 /* read() structure */
 struct uffd_msg {
@@ -230,6 +233,18 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
 	 * existing page contents from userspace.
+	 *
+	 * UFFD_FEATURE_MINOR_ANON indicates that minor fault interception
+	 * is supported for anonymous private memory.  Pages are made
+	 * inaccessible via UFFDIO_DEACTIVATE (sets PROT_NONE while
+	 * preserving the page) and faults are delivered when the pages
+	 * are re-accessed.
+	 *
+	 * UFFD_FEATURE_MINOR_ASYNC indicates asynchronous minor fault
+	 * mode.  When set, faults on deactivated pages are auto-resolved
+	 * by the kernel (PTE permissions restored immediately) without
+	 * delivering a message to the userfaultfd handler.  Use
+	 * PAGEMAP_SCAN to find pages that were not re-accessed.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -248,6 +263,8 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_MINOR_ANON			(1<<17)
+#define UFFD_FEATURE_MINOR_ASYNC		(1<<18)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.51.2

