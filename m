Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A91B4257;
	Fri,  6 Mar 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792172; cv=none; b=Jc6jC98gMaNAZr5FLZHAShjkWRaTe9mQA9RdDq04ehNQP/F5c8RvWoY961d8nrY5sG/yMQB770BIuTfYE/FOw8HSlDSEcOFFOMzWVIImI7vEcbImucVemILHVHs+MzmjfvOfUxYTq39A5oZqEb7BTcgeYCWUHK4eu7JqfhlVjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792172; c=relaxed/simple;
	bh=aN1f11VNXm8TEP7a6s26GhJ/SMe/0NluR98vebxUP6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPwbuUsCqhDw2BYmPdoJfAXdaTdlM5xma+ZywQ6zh/PQKfeXvyNSNP0GOOyhdb1laV9tVtpHgwIt2c7aR507WrW+FFu6kZ6PysIHrnuFPfC7/sWOBNCrcM9VDFBtMDL81RDv4jKj8P4b6yI+u2C8gypJWPFuj5aKIChemImJz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHBI0MPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHBI0MPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A777C4CEF7;
	Fri,  6 Mar 2026 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792172;
	bh=aN1f11VNXm8TEP7a6s26GhJ/SMe/0NluR98vebxUP6U=;
	h=From:To:Cc:Subject:Date:From;
	b=CHBI0MPcs3WqAo1RU5sZKFW8fwe2JFRLkXD2gEBfA05SDEdafzPVDHMH8aw0ejrD1
	 crqje38RReq5vJVpM1YI1zNvWsClMXXuzPbjwWw2W0Br0k8sZvXTCojMTKdsEYTBoF
	 TQZEpdbvWip2ZmFiT0To1T7WuSrRK/oAtsAHSsmxayfcl3ww60vjF9VLaepfe0bLPX
	 d9L6oZeF8Ol+LMb77zqQx3p9ZtaiJ7pb9/WGw38ryflhSGSDKO4NV7WRWCCrWtG+lG
	 kpXRz5yWs5U5TkzVWGjSi37i/3Xtj+xBxmdbgu53ij+gVc0IPtQbMLSP9cYAJC/xSl
	 sb3JchfU6+kZw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 0/4] mm: move vma_(kernel|mmu)_pagesize() out of hugetlb.c
Date: Fri,  6 Mar 2026 11:15:56 +0100
Message-ID: <20260306101600.57355-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking into vma_(kernel|mmu)_pagesize(), I realized that there is one
scenario where DAX would not do the right thing when the kernel is
not compiled with hugetlb support.

Without hugetlb support, vma_(kernel|mmu)_pagesize() will always return
PAGE_SIZE instead of using the ->pagesize() result provided by dax-device
code.

Fix that by moving vma_kernel_pagesize() to core MM code, where it belongs.
I don't think this is stable material, but am not 100% sure.

Also, move vma_mmu_pagesize() while at it. Remove the unnecessary hugetlb.h
inclusion from KVM code.

Cross-compiled heavily.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>

David Hildenbrand (Arm) (4):
  mm: move vma_kernel_pagesize() from hugetlb to mm.h
  mm: move vma_mmu_pagesize() from hugetlb to vma.c
  KVM: remove hugetlb.h inclusion
  KVM: PPC: remove hugetlb.h inclusion

 arch/powerpc/kvm/book3s_hv.c |  1 -
 include/linux/hugetlb.h      | 14 --------------
 include/linux/mm.h           | 22 ++++++++++++++++++++++
 mm/hugetlb.c                 | 28 ----------------------------
 mm/vma.c                     | 21 +++++++++++++++++++++
 virt/kvm/kvm_main.c          |  1 -
 6 files changed, 43 insertions(+), 44 deletions(-)


base-commit: f75825cdfc4c5477cffcfd2cafa4e5ce5aa67f13
-- 
2.43.0

