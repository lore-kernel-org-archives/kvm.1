Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726D4C6F1E
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985789; cv=none; b=coca9nAFILtHNyJtQVGsZ9NiCXwy2dnwLPoadMqetTAug7NxAVi0l0qb9po+p1Z8a0cX0E/UN/lRfk3Drsbwse1ETzKEg5v153jo9ie4WBKw8AQ0V1y9RxpiAt7nfndfjZiczW2VPAKJrZZNi+AgPMdL/e3wZaZIf9MyTkEA3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985789; c=relaxed/simple;
	bh=6dfl0493FiKCVdfH6IISSpAPeMP8atcIuPuXeABh7So=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WSzvBZXoAJSlOQlTFOT25AT3oU5oXzqBrdoSBgVcrbuSXLcFnzT3gLXwL48kL+NFzJ0WM2hu3XAbE/fEFr9/kqtXGYxYgvx+PjJexZ2FbtyVbstxDZaTrAYBL5GbvKj/xghwUzK3mksnyfCuZLbKJoLSDdUHFenx3ConM0DIlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dg0LsYWU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dg0LsYWU"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767b782so15218535e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985786; x=1783590586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uA/CbX05otjpJrCB5vyhlF2BO1G5eOxSm1QrF783BDY=;
        b=Dg0LsYWUMjvsBtQ8A63ragNWe6JIdf+3boKvLsOUZnLofJdkHGJL5amC0bzHKU3DB7
         DHd3iFIdORFXICaJiNbh6Qgmpznm5ImmuJ6kkg7i1ZZJwzaZTwO/0KaV2MoTAsoXu5C/
         88YlPlJmgUoRo/n/vkJo0h1hUqrk4KCI7QwEdYNrtGExYR8OFsJIBOh5D7FfWHD043vj
         QonL6VyNo84lAmL3QeF1bVRIwgFqYGFM7mIaMzMOUXt1VLeQvSVRrUWPM8q6hvaOVLPY
         Pn8Ix9CpeBClajOHdGyEc4vpGUWWY2Lt2blNNGdqVjE/73gZyE91+SNb0kDIsPqjLL8u
         +SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985786; x=1783590586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uA/CbX05otjpJrCB5vyhlF2BO1G5eOxSm1QrF783BDY=;
        b=L2VsEMWOnHtYvPnP4EHLO5c1yN1Ddjs/0Iz0Cm8evDdvRp4Gnzdf2HW3Ig3Lqj9RjR
         hxrIHwgS0VOwJt2yFKglNsERgQTzkXWRmwmkUEOnerWi33iiAeXDht55I1EzMC6Rc+ds
         Ep9u0mKZ6i25tsT45Us1YGKzaB7f53+h6uKa93S+U2v0msahzelTphgdGMcyrLT8xvXK
         V+YMS49ImFo+WgBHfbLm3kptEYHE61GLj2Gel8u0mM7qVbdYwFeig1l9OynpNijGWL2E
         PDF3JCVC3NJMF+ksz4EyCDIw+ae+J5H++MPDW3uipnfDkp8PygXyScSFwqQgadjZw8Yv
         6Qxw==
X-Forwarded-Encrypted: i=1; AFNElJ9Fcgkd6LhIn6WLub1+xGDhwoIQtcnDkrDb4OWjjfFqwel3411cIzdfPyRDlpPO4rufw7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxc5cN/mDhvA+vPRPF6KIvGe/96fInwO7PlnmwJ2NMuYvL/MZ
	m+vFIZ7WvaCAeLHuPWq9QTwA6wpIoSvk/2nMHX3A1fFLjfw96SQ88qMjjXTSNw9OW031dRfW5aP
	Z3lkQ+/E6fVsPag==
X-Received: from wrpl7.prod.google.com ([2002:a5d:4107:0:b0:43d:7e53:c76a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a4c:b0:493:c55e:9fa1 with SMTP id 5b1f17b1804b1-493c55ea121mr31277505e9.39.1782985785380;
 Thu, 02 Jul 2026 02:49:45 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:31 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACw0RmoC/3XNTQ6CMBAF4KuYrq1pZ5CiK+9hXJR2wCpS0yKRE
 O5u0Y0/cTV5yfvejCxScBTZdjGyQL2LzrcpZMsFM0fd1sSdTZmBgFzkUnHdNN7wLgzpnLnMtEV
 ldYmoWDLXQJW7P/f2h1eOt/JEpptH5sbRxc6H4fmwl3Pv33YvueQFVlYV66JAoF3tfd3QyvgLm 8d7eOMA3xy44CgrlJgrm4H44fjON98cE1+rkipB2pYGPvg0TQ98Sd+GOwEAAA==
X-Change-Id: 20260617-alloc-trylock-14ad37dab337
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Subject: [PATCH v4 00/18] mm: Some cleanups for page allocator APIs
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

This is based on mm-new, it depends on moving alloc_tag to mm/ [0].

[0] https://lore.kernel.org/all/aj5QBtJcphPElczI@lucifer/

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
 mm/internal.h                                    | 276 ++------------------
 mm/khugepaged.c                                  |   1 +
 mm/kmsan/init.c                                  |   2 +-
 mm/memory-failure.c                              |   1 +
 mm/memory_hotplug.c                              |   1 +
 mm/mempolicy.c                                   |  11 +-
 mm/migrate.c                                     |   1 +
 mm/mm_init.c                                     |   1 +
 mm/page_alloc.c                                  | 269 ++++++++++---------
 mm/page_alloc.h                                  | 313 +++++++++++++++++++++++
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
 37 files changed, 537 insertions(+), 509 deletions(-)
---
base-commit: 581a9d8f214b3f9d8777e66795ca86dbd9ca44a8
change-id: 20260617-alloc-trylock-14ad37dab337

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

