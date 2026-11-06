Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944467;
	b=1iwutJ4jX60i/jjGjenFs0cDSFlwcIa3+swGt3cd8fC78mB0qHxZHX+2R0kVogy+Iawh
	 E6/Z/mVeSZd1F21OhYxcQ8qZmIuC6nf6fAAmrR//CQ8x6RCp0nFyzos4Hnxte3bdIDf3P
	 Sut2kJRAdQWvgHDUVaCIH2FBWp5hqyJpmJ9SkLA+glHFwB3dWlU2KBshDrsuA1fc4Vq/5
	 yYJyG0aeuRokfHAcdg+KBDTH4/WY8UtU6AbwEYEm59DIVSU0H4p7JxarelvPdQUFBmYxa
	 tRa7TVPgwFHGFiLOVVj/osS4OQ6lbG/jEEi8qKhmBSBf/jVFtIOhoJsTrVMzS+TBvEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944467;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZkVgJPqUyM/MWdECKVhoMlY0/kmR087+Z++BChEE7DA=;
	b=uTWzvjD+Qru4B527E0RmHl4SION0gH7p8Fa/Mr2Y6sp0szeGwZ/F5ds8cE2jb896OIcM
	 i9Y5VJy0gjiFbDl+9vkeQoSpgNPLf2P722a9UtBrgT1n4cJliyAzpoypWC6QPKvVPY3gf
	 rRypgyGU+OENrZI08xK/Z80xF45R1KoaakdHeAXPiWfoEz6ildrYU2mJZGi93CrEM8eCQ
	 PyGvugGKQroh7NSXi4Tg4JC9j5eoZHLIDL2wHJEgdN9RVfSAhLwNoV1ng/6n54OCH/ZEm
	 TQFGsb/J7aSHNeJ2W1YGDV0nbfLpquUoADgtw/T6FRsAQD1PLlgmv8/ROYNwUnujPRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p+5ATKcy;
	arc=none smtp.remote-ip=95.215.58.79
Received: from mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F9606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B4F9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p+5ATKcy
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZkVgJPqUyM/MWdECKVhoMlY0/kmR087+Z++BChEE7DA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793944464; v=1; x=1794549264;
 b=p+5ATKcypUGZS4VBqs6eMheOi6I74aXlfRwogwAjhKBYw21b1VUhmGNGpK9SSQyZMEJBoKV4
 FckvjSRIpg6ENHbkXNGTrjOnx+hHqUfWH8RrwDdGDeB5IreeZ6cJmJnQk4qRX1/j7CRotF/+VY9
 7Lfilw4xylzHGllFPm9ybBRc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 578f26654fbdc28a;
	Fri, 06 Nov 2026 05:54:24 +0000
X-Mizu-Trace-ID: 578f26654fbdc28a
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
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 13:54:15 +0800
Message-ID: <20261106055415.42873-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:30:54PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
>with vma_flags_t values.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
