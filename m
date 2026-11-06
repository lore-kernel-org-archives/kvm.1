Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945013;
	b=ds0wX9KCBXxvBg723lDF32n6wVffpFhiSlCcvuOJ/AkL31R53YARUN/sbhuvj29aLtjW
	 SqS8seCeBV6/SwN/kwQti/Z0fGDOMX+6Sca4TuupTsvCk1bmq8/vgMzNeqsJcisvTLsSt
	 NIjLhzSr8ssT+g7fWX05mYbyVkH/NpbIr5qZSDPy3JQRBdbsvwSv6mmsrpg2ZL387ut4J
	 SOc4imguukxxdfNA2m5TDMJProJVB6q7x1d34dES1EcwOWBS9UXj6zlU8jVtdJV3bXbKd
	 /hE95HKT2a9pGvcT9RUMLC+P05ih74qix6SIoQp3Jn+XX10os1U4OYdzquHI/sd/Edg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945013;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1dv3z5zT9lsczFcdl5n0QdTgMSuVwfBVBoxw3rRXK20=;
	b=nA4oF8N4Am5Zdy6nHoHGGBs8wpRkc/UQx1bVPQt2Ez+2QOeSNe4ek+O0M9KUCNF1S7xl
	 VW6qHHCE+7Lujpn7Gp1SkjKep6o1Fb1Jf7474sNVOFtB7eDtEKU4IuHKzob3FBtplmvxo
	 vZhivaq3z6CxzGnZhHL2bAQ07nka7RiROMahljCIuM9CygQzjCB9D12Olg/SLy9TdZuB/
	 mBvlcQLRgTmolsDbRC3FzIqOOm4lNIdYerMO6e9VKlDtnDC7ISVltJl8FCyLlxSZZRu6B
	 RuaIIwwIAVOfC0Wu0u4FUbQBrdWW1+/DB7fvpKYrE9bsS20lgwujqYCA1TL2/C1osUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vGhTI5Jc;
	arc=none smtp.remote-ip=95.215.58.201
Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86190606A331
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 06:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86190606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vGhTI5Jc
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1dv3z5zT9lsczFcdl5n0QdTgMSuVwfBVBoxw3rRXK20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945010; v=1; x=1794549810;
 b=vGhTI5Jcges3xN8teMHtI5reOTYKqavOiI4erKeXtHNGBd2MmoVzh5L6oS8tm3u0xmpLXqd0
 XFFtJSkPTXN5xdEHo3dGJDwurk9iHCKsGYGwp75BKCp+3zpc4fei9wKZzgMKD/lFEg9AdWtWWRt
 MQdJEannNuGJ9eECrX1QLhUo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d15d1ba08f67e7a1;
	Fri, 06 Nov 2026 06:03:29 +0000
X-Mizu-Trace-ID: d15d1ba08f67e7a1
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:03:20 +0800
Message-ID: <20261106060320.43724-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:30:56PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>VMA flags are tested directly in the THP and khugepaged logic.
>
>The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
>khugepaged_enter_vma() continue to take legacy flags for the time being.
>
>Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
