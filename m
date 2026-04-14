Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657D3E6DF9;
	Tue, 14 Apr 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176652; cv=none; b=XPTd2nZgbkPxxVXiRaY3XAMa43da/yQWcwU/jP+41A7FGsLVWAt9be/C9rq8HBpE5lb0uL7sPqVYL6qtP9qH6HmG0wUK49JblqV67T5dzFjlc2LqtzuWrVUr6CgAytoL32g/fZvY5do56h1cjqWvgMsV4neT9OcHjuBC/iuIX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176652; c=relaxed/simple;
	bh=bdNn47+Nx91eslEieZ286KWtw/tnSdy4Rxa/tQlVFSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe4cdFDKxc1DvX3rvy/3JTdMj/YT7EhgRVyWZ+ksgZ89fRBuTWQkZK5m2nbNv1OGn4Q3xBDjf0tmQXJzoAwVpZPou/xv4yOWt+24Goc4D9T+pPNKQmM7GKxUaMJf/NMcWhy4ffTeGy2kxjKahQirS+jCiyGH2kykLSHeTuoSuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smzIiwzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smzIiwzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE429C4AF0B;
	Tue, 14 Apr 2026 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176652;
	bh=bdNn47+Nx91eslEieZ286KWtw/tnSdy4Rxa/tQlVFSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smzIiwzkviWVR7lnj73JVWnCQ+zBpvJCTqLUI3rfAoHi80IfNutFZUb982WabLJdp
	 RV1EHtoV0XM8U5Lvh6R6BERnAHbxeaIWOyOTq1r1cgtn4s17TLEIXC4Czy1xUKl5/N
	 zmzLM2Ig+HUpqpMApLtLHsYyinprvvb5thjin3NmUf4IqX94OWT09zuu8KXP9bmTPB
	 0h3kNPAZ2HcYJCbuRfx63vGGdEnfLqOOYWavV5a2qtXHfA7mYS1UxHoDAbRR9ZLYLw
	 D0I5zhRWXTgJDj0qq2R7C5PShhH88aEmokXZzPaoA1H0sftf5qJ2BSXT5I4nA8ZBZJ
	 LNaGsT5Zhu3Ng==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF7A6F40068;
	Tue, 14 Apr 2026 10:24:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 10:24:10 -0400
X-ME-Sender: <xms:Ck7eaVIlxL6gOMHnrotiu1Aq2wA_g2vVcrpAXkPVT6yYDcz0V3RS5w>
    <xme:Ck7eaYHthgumh1dkOCOzDnRilG70A9ktdRrDr3hP5Sd3rh2AUmzhloqbv9NAe3GQ1
    hqceh6DORm9RS_eebYzCXgUboVCRIXfsO7vxbuP_Fgh5d0aVhfLHvU>
X-ME-Received: <xmr:Ck7eaSxYsKTSd-N2Uvwi9HwB9SGKN-1eMU-nLf7guVhKn0slOdMJQm5IE5PF0Q>
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
X-ME-Proxy: <xmx:Ck7eadhKkyMSHzEZVrk8qVizVP-x_HMDg3Ml2GcB9nOmIqgN2x1tAw>
    <xmx:Ck7eaXLic-Q5TKN6jkpmkLTrh_zTVGW9-0YwrimJQp29TkHP6kjeAw>
    <xmx:Ck7eaQCus3xC9UxalN-U84MZRkTX50MHGVg9Pyo5DkPAYMTJQSEZWA>
    <xmx:Ck7eaYReISLLG7mEHLpRZRqQ5XjeqE4JrodK7dWh4MhDS6RYM6V6Fw>
    <xmx:Ck7eaRol0_iVa8IN7w3Vs3Gzyv1QZl9rkUikTVZnrTUcVY9I-PSC24Fs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:10 -0400 (EDT)
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
Subject: [RFC, PATCH 08/12] userfaultfd: enable UFFD_FEATURE_MINOR_ANON
Date: Tue, 14 Apr 2026 15:23:42 +0100
Message-ID: <20260414142354.1465950-9-kas@kernel.org>
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

Add UFFD_FEATURE_MINOR_ANON, UFFD_FEATURE_MINOR_ASYNC to
UFFD_API_FEATURES and UFFDIO_DEACTIVATE to UFFD_API_RANGE_IOCTLS.
The feature is now available to userspace.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 include/uapi/linux/userfaultfd.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 336d07e1b6de..775825da2596 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -42,7 +42,9 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_MINOR_ANON |		\
+			   UFFD_FEATURE_MINOR_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -54,13 +56,15 @@
 	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_DEACTIVATE)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_DEACTIVATE)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
-- 
2.51.2

