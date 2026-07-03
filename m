Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E3D25D0
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081943; cv=none; b=p486Qwvw8JGvDXjRjMwUEH5nKkTd9SQOvRIP1vDL+V3W9y21/tTghIhN+Bz2abxC43j7AFB34rE3nyZsDYn624cJSw9ojNoG2Sc/oKnwyFAk3grZmIA2yTTmdJ1+uMfBdbAL1khPtuV+j+fKJuDNvsQKjZfqPWJ5PBcvU60uwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081943; c=relaxed/simple;
	bh=cmR9VJOKrJgbT61YdHqSSIWKWJQFGpRTZVcruEzFTuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HyN7/vk47JkG3HVFPWkzfhtog5pCRsrV0iSkL8zH1kbu1J61ae08Sr41AsIWZyKyg65Y2Jze0/MPvnwd/mwd9byRXpk3aVGhfY3++sIR0f6g3pBL+GBRLe1Jb4MpDG7AgsiTyMJEc20INSbNdRAHlbsK4sCy5IJNZtPq2V2WPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6HJciWw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6HJciWw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso2858555e9.0
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081937; x=1783686737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnDWaO67kOtoHBKr0HS5m4PtTKwANjm9WdLJsztRd4w=;
        b=J6HJciWwT/wg2yShO2VHIFZfRNQ18VPpf106deIVgatocQt6aC38HEQrtVxkMvlWDq
         8KOSDm2jNjc7MHI2Gx933+xcmqGSYUGDyO/qsseMGBVuf2UBvNs6gbGbEehrR1oZYpot
         ODUbAtzYQgpILj2pjXpur1T+7Nw1AMfGjMUJFtW2OIQ+NIYzNAMBN0x2BbZuz128YezX
         Nc6dbM/AFd4rZm5OMSJgYbcNR3tUaGHF7E0RzizcJN7LC/pllMYGvNVovcvrJ7SrlYKd
         rbt0VilVej9NkfK6ML0zcZHICIMqn7WDN4BACOApkJKyq+DovdX5bY8XMvC7mOhp0pkw
         3uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081937; x=1783686737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnDWaO67kOtoHBKr0HS5m4PtTKwANjm9WdLJsztRd4w=;
        b=QX8HV39eY9SqraQfUQCbQhG0SO0RIGizcSg0GIxZZelxhNJ7+1weA6tY4nPaVQJT89
         MbP4u4jAuWvqLwC3XmHOuc+OxHKbTxwG+JvnIQzQ2Yh38u44IEB5Vtu82xnC+Yg7+fey
         mt096eGN4jNGssPNY4KOO92FumV+nvS8BYjpAvmZ6w9Fm3N2pherUUJz2AMCv0zBLl4S
         imtyrxmKd0DSFCqjVYcv+udTaz5n7jsx2pE2yjiZZ/Gtn/Dwbr5XGJufSqoNTWrYkVpy
         BfDtCNZVhYgOzslpeULI2UdmOrekPrLh2v7gHhlBoSzen9MdP0Trhj3akBaTfmfD7tLI
         ED8w==
X-Forwarded-Encrypted: i=1; AFNElJ8/xoE9BK6S5PTq3TyGZy+0zFe+rwYZ8TcakITnbC9hqLtWKg23oZhOihIJPcF/AOVKx70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj77QQLuFLQTCTC/PoJ7SUUIZXssfeA+jdG2oE738vEWM8IAbZ
	jptezrlovXlxtl9Zg9KphJGDrc8k1vaUp3dxL/ZYib7WM8wL5S60NGVcRaVTZDIhdIg0K/zEJtk
	udcsVQwGmP7d5Kg==
X-Received: from wmer11.prod.google.com ([2002:a05:600c:434b:b0:493:aecc:774a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6692:b0:493:bb6b:5bda with SMTP id 5b1f17b1804b1-493c2b983b8mr139426775e9.29.1783081936166;
 Fri, 03 Jul 2026 05:32:16 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:40 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKyrR2oC/3XNTW7CMBAF4Ksgr2tkzySx2xX3QF049ji4TTGyQ
 1SEcnccWPATsRo9ab73zixTCpTZ1+rMEo0hh7gvof5YMbsz+454cCUzENCIRipu+j5aPqRTOb9
 cVsahcqZFVKyYQyIf/q992+9bzsf2h+wwl8wfu5CHmE7XwVHOf++6R8kl1+id0rXWCLTpYux6W
 tv4x+byER44wCsHLjhKjxIb5SoQC46P/POVY+G1askLMq61sODVnSuxWK8KF8Zr71Er0s/r0zR dAFKCqT56AQAA
X-Change-Id: 20260617-alloc-trylock-14ad37dab337
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Subject: [PATCH v5 00/18] mm: Some cleanups for page allocator APIs
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	derkling@google.com, reijiw@google.com, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="utf-8"

Based on mm-new.

This depends on moving alloc_tag to mm/:
https://lore.kernel.org/all/aj5QBtJcphPElczI@lucifer/

Some tweaks and cleanups for page allocator entrypoint and flags. This
is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
become ALLOC_UNMAPPED in its next iteration), but all this is supposed
to be an improvement to the codebase in its own right: unifying code
paths, reducing API surface, and removing GFP flags.

[1] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54f41@google.com/

This started with unifying  __alloc_frozen_pages[_nolock]_noprof() and
expanded from there.

Unifying the nolock allocator entrypoint with the normal allocator
entrypoint means adding an alloc_flags argument to the later (only
exposed within mm/). This presents an opportunity to take advantage of
that arg to remove some GFP flags, if we add that alloc_flags arg a bit
more broadly to allocator entrypoints.

To distinguish between mm-internal and "public" allocator entrypoints,
it makes sense to use the __ prefix. There are already some public APIs
with that prefix. For *alloc_pages*, just removing those variants seems
like a nice cleanup anyway, so do that. For get_free_pages, the "__"
variant is the _only_ variant and it's very widely used, so it doesn't
seem worthwhile to modify that. Therefore, scope this "__" change
specifically to the *alloc_pages* API, which means we leave the
*folio_alloc* API untouched too, even though that could probably be
cleaned up if so desired.

Tested:

- KVM, mm, and BPF selftests in a QEMU VM

- kunit.py on x86_64

- For the ALLOC_NO_CODETAG bits I just booted a VM and read
  /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
  kernel crashes in early boot, so I was at least booting code that
  depends on this logic.

I used Google's internal version of Antigravity (AI coding harness) to
do the repetitive bits, those commits are marked with Assisted-by, the
rest is manual.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v5:
- Just trivial non-functional fixes.
- Link to v4: https://patch.msgid.link/20260702-alloc-trylock-v4-0-0af8ff387e80@google.com

Changes in v4:
- Fixed some (harmless) missing applications of ac->alloc_flags (local
  Sashiko)
- Fixed various build issues.
   - Note that Sashiko pointed out a KMSAN build issue [0], I have
     fixed it but KMSAN builds are currently broken by objtool [1]. At least
     mm/kmsan/init.c compiles.
     [2] https://lore.kernel.org/all/20260629141642.628271F00A3D@smtp.kernel.org/
     [3] https://lore.kernel.org/all/20260630104434.GC751831@noisy.programming.kicks-ass.net/t/#u
- Avoided setting ALLOC_NOFRAGMENT under ALLOC_NOLOCK (Sashiko, Harry)
- Added patch to tweak alloc_flags_cma() interface (Vlastimil)
- More commit messages fixups (various)
- Added patch to create can_spin_trylock() (Harry)
- Link to v3: https://patch.msgid.link/20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com

Changes in v3:
- Created mm/page_alloc.h
- Fixed EXPORT_SYMBOL() issues
- Reworded commit messages per Sashiko's pointers
- Dropped rename of alloc_flags arg in prepare_alloc_pages() (Suren)
- Renamed gfp_to_alloc_flags_nonblocking() too after rebasing onto:
  https://lore.kernel.org/all/20260623004600.113347-1-jp.kobryn@linux.dev/
- Link to v2: https://patch.msgid.link/20260622-alloc-trylock-v2-0-31f31367d420@google.com

Changes in v2:
- Fixed up whitespace in nolock unification patch
- Introduced ALLOC_DEFAULT to replace literal 0 for alloc_flags
- All other patches are new
- Link to v1: https://patch.msgid.link/20260617-alloc-trylock-v1-1-83fd7858832e@google.com

---
Brendan Jackman (17):
      mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
      mm/page_alloc: some renames to clarify alloc_flags scopes
      mm: name some args in a function declaration
      mm: Split out internal page_alloc.h
      mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
      mm/page_alloc: relax GFP WARN in nolock allocs
      mm: move some stuff to mm/page_alloc.h
      perf/x86/intel: Use higher-level allocator API
      KVM: VMX: Use higher-level allocator API
      x86/virt: Use higher-level allocator API
      sgi-xp: Use higher-level allocator API
      net/funeth: Switch to higher-level allocator API
      mm: Remove __alloc_pages_node()
      mm: Move __alloc_pages() to mm/page_alloc.h
      mm: replace __GFP_NO_CODETAG with ALLOC_NO_CODETAG
      mm/page_alloc: drop alloc_flags arg from alloc_flags_cma()
      mm: factor out can_spin_trylock()

Vlastimil Babka (SUSE) (1):
      mm: remove the __GFP_NO_OBJ_EXT flag

 Documentation/admin-guide/cgroup-v1/cpusets.rst  |   2 +-
 Documentation/admin-guide/mm/transhuge.rst       |   2 +-
 MAINTAINERS                                      |   1 +
 arch/x86/events/intel/ds.c                       |   6 +-
 arch/x86/kvm/vmx/vmx.c                           |   2 +-
 arch/x86/virt/hw.c                               |   2 +-
 drivers/misc/sgi-xp/xpc_uv.c                     |   5 +-
 drivers/net/ethernet/fungible/funeth/funeth_rx.c |   2 +-
 include/linux/alloc_tag.h                        |   4 +-
 include/linux/gfp.h                              |  54 +---
 include/linux/gfp_types.h                        |   7 -
 include/linux/skbuff.h                           |   2 +-
 include/trace/events/mmflags.h                   |  10 +-
 mm/alloc_tag.c                                   |  23 +-
 mm/compaction.c                                  |   5 +-
 mm/hugetlb.c                                     |   4 +-
 mm/internal.h                                    | 275 ++------------------
 mm/khugepaged.c                                  |   1 +
 mm/kmsan/init.c                                  |   2 +-
 mm/memory-failure.c                              |   1 +
 mm/memory_hotplug.c                              |   1 +
 mm/mempolicy.c                                   |  11 +-
 mm/migrate.c                                     |   1 +
 mm/mm_init.c                                     |   1 +
 mm/page_alloc.c                                  | 269 ++++++++++---------
 mm/page_alloc.h                                  | 312 +++++++++++++++++++++++
 mm/page_frag_cache.c                             |   6 +-
 mm/page_isolation.c                              |   1 +
 mm/page_owner.c                                  |   2 +-
 mm/page_reporting.c                              |   1 +
 mm/show_mem.c                                    |   1 +
 mm/shuffle.c                                     |   1 +
 mm/slub.c                                        |  17 +-
 mm/swap.c                                        |   1 +
 mm/vmscan.c                                      |   1 +
 mm/vmstat.c                                      |   1 +
 tools/include/linux/gfp_types.h                  |   7 -
 37 files changed, 536 insertions(+), 508 deletions(-)
---
base-commit: 32af3ff0925368eff29b2fed62f154150eb5dc10
change-id: 20260617-alloc-trylock-14ad37dab337

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

