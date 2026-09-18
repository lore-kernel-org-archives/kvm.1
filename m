Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73C4F68AB;
	Fri, 18 Sep 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738301; cv=none; b=cMW8wXrBFRoOwk5HhfSrEHvdv7FhFoAd01zEjSEvz0LviV9qbtLzCKDUhAGsTqWrNsNGwKLhALCOAXjhi4Ts3fU8figmOHsqTml8wwqb5uGTYEDID1ZrfttFINVqLJgWFTd8EjG1uHhgb70Gt5NY1nwVR4kOAtFAfWSGJrnrix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738301; c=relaxed/simple;
	bh=x9FcjygSuDmHthKzChzm1j3Gi0Wm8e5vmtA7K3N744s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEWGpz6RreTSu8tJk7dYah5cRXEIubgB5aXOIPFSKtwYfg7bStQme6FfyELNlzSvvhDpJWqmrdoL9bNv3n71Viucl7b083syqSey0P+IzUXauuk6ETllD1y96CVhtf05OXs0lsqZVkMo530035WUy9JlX7otsJp9eFFVKnQr9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUKZb0CA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUKZb0CA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738299; x=1821274299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x9FcjygSuDmHthKzChzm1j3Gi0Wm8e5vmtA7K3N744s=;
  b=bUKZb0CAnsU8rop4Pi2fHGXwjAa3LxcQe5BWmQyLthOhiSboWmwywQPH
   YO/2uW/U21Q4VjJvb908fKUgs4CY/vLqgrtQ5nvTBbBNPICSHMNSrSQ44
   ZidPuNkLQxfgDXXyDnURExUf8gn1Oi/CuxFhp4eXXRdgElc4fcOP2vws0
   lqB9/rdVxivntj6bD7X0+2CSSiVljQkdA338PL9lWB6Lh8ZatFid4B1h9
   sAIo9cCpZ371CNe/590gES9NLSQqLU+TqUszDmAoyC6u/0wUv7tdqc9ol
   gsO/+My9dEl8TIY6so9snUWlCd0wPc7GQJu8C+4HgKOEkadIXlGMj0piY
   w==;
X-CSE-ConnectionGUID: G0lAJ11eTseuAxcURpyOcQ==
X-CSE-MsgGUID: NwhtPnz4RJ21fKZ4O/chcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776093"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776093"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:38 -0700
X-CSE-ConnectionGUID: c8hT+xyRQFC2mRXTpIPxnQ==
X-CSE-MsgGUID: 4iUg8d0KRp6OSvsFZTuLzg==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:38 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global metadata code
Date: Fri, 18 Sep 2026 06:29:19 -0700
Message-ID: <20260918132946.76533-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the TDX global metadata code. It has two goals:

1. Replace the generated code with a table-driven metadata reader.

2. Make the existing code easier to read and maintain, and simplify
   adding new metadata fields.

During the v1 review, Dave raised concerns about signing off on
AI-generated code. I have since rewritten the affected patches based on
my own understanding of the code.

The main goal of this RFC is to agree on whether the table-driven reader is
the right replacement for the generated code. Please raise any concerns or
alternative design ideas.

Feedback on the patch organization is also welcome. In v2, each patch
converts one metadata reader. This should make the individual changes
easier to review, but results in more patches and some repetition in their
changelogs. I am not sure whether this is the best organization for the
series.

Dave, please feel free to ignore this RFC. Kirill, Rick, and other TDX
developers, please take a look.

Changes since v1:
=================
  - Reimplemented the code and rewrote the changelogs for patches
    generated entirely by AI. (Dave)
  - Expanded the problem statement with the history of earlier TDX metadata
    proposals (Rick)
  - Dropped the false claim that literal u64 field IDs are unreviewable
    (Dave)
  - Rebase onto tip/x86/tdx and convert the metadata added by DPAMT.
  - Name field IDs as their readers are converted instead of naming them
    in a separate patch.
  - Convert one metadata reader per patch.
  - v1: https://lore.kernel.org/all/20260804112941.19894-1-chao.gao@intel.com/

The TDX module reports its capabilities and limits through a set of global
metadata fields, each read using a 64-bit field ID via TDH.SYS.RD. The
fields are grouped into classes, and the kernel mirrors each class it
needs in a sub-structure of struct tdx_sys_info.

Both those structures and the code that fills them were generated by an
out-of-tree script from a JSON file.

The script was not the first approach.  Kai's first attempt paired each
field ID with its destination C member in a table and walked the table in a
loop to read every field.  Two pieces of feedback on it drove everything
that followed [1]:

  1. Compile-time type checking. Metadata fields have different sizes (u16
     and u64), so a common helper takes a void * and a size instead of
     a typed destination.

  2. The check that a field ID's encoded size matches its destination
     member ran at runtime, although both sizes are known at build time.

The discussion did not converge after several rounds of review. Dave noted
that, despite the void *, the size check provides the safety that matters:
it catches mismatched field and member widths [2]. That left one problem:
moving the size check from runtime to build time.

Before that was settled, the direction shifted to generating the code with a
script. At the time, the TDX ABI definitions were published as JSON, so
checking a field ID required consulting a machine-readable file by hand.
The script parsed the JSON and generated both the structures and their
readers [3]. Generation also made the size/type check unnecessary. The
field IDs and destination members came from the same input, so a mismatch
could only result from a bug in the script, which is less likely than a
mistake in hand-written code.

Dave concluded that the JSON experiment had failed [4] for two reasons:

  1. The JSON file is not stable. The CPUID config arrays here were once
     sized for a maximum of 32 entries, which has since increased to 128 [5].

  2. The JSON file is not authoritative enough to write code from by itself.

TDX ABI definitions are now available in human-readable PDF specifications
[6]. So, stop relying on the out-of-tree script and maintain the code by
hand.

Yilun later proposed a single table whose entries carry the offset and size
of each mapped member in struct tdx_sys_info [7]. That design does not
cover the new handoff metadata because it is not cached in
struct tdx_sys_info.

This series gives every class its own table: each entry pairs a field ID
with the member that holds it, and a loop walks the table. This also covers
handoff metadata, which is read into a local structure rather than into
struct tdx_sys_info.

The common reader still takes a void *, but each mapping verifies at build
time that the destination member size matches the size encoded in the field
ID. A field/member width mismatch therefore fails the build.

AI usage
========

I used LLM tools to review the patches and refine the wording of the cover
letter and changelogs from my drafts. I reviewed all suggestions and adopted
those I agreed with. For example, AI review suggested the
read_sys_metadata_table() macro, which avoids repeating the table name when
passing both the table and its size.


Testing
=======
Built each patch individually and successfully launched TDs.


[1]: https://lore.kernel.org/kvm/66b16121c48f4_4fc729424@dwillia2-xfh.jf.intel.com.notmuch/
[2]: https://lore.kernel.org/kvm/c3b1e743-6d34-49ce-8e60-a41038f27c61@intel.com/
[3]: https://lore.kernel.org/kvm/f25673ea-08c5-474b-a841-095656820b67@intel.com/
[4]: https://lore.kernel.org/kvm/1e7bcbad-eb26-44b7-97ca-88ab53467212@intel.com/
[5]: https://lore.kernel.org/lkml/55f97ca1-8f32-4e33-96fb-d82ed2109f9a@intel.com/
[6]: https://www.intel.com/content/www/us/en/content-details/865803/abi-definitions-for-intel-tdx.html
[7]: https://lore.kernel.org/kvm/20251202050844.2520762-4-yilun.xu@linux.intel.com/



Chao Gao (10):
  x86/virt/tdx: Add a helper to read a table of metadata fields
  x86/virt/tdx: Convert the version metadata reader
  x86/virt/tdx: Convert the features metadata reader
  x86/virt/tdx: Convert the tdmr metadata reader
  x86/virt/tdx: Convert the td_ctrl metadata reader
  x86/virt/tdx: Convert the handoff metadata reader
  x86/virt/tdx: Convert the td_conf metadata reader
  x86/virt/tdx: Remove tdx_global_metadata.c
  x86/virt/tdx: Use early returns in get_tdx_sys_info()
  x86/virt/tdx: Verify structure member sizes against metadata field IDs

 arch/x86/virt/vmx/tdx/tdx.c                 | 222 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  54 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 154 --------------
 3 files changed, 275 insertions(+), 155 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c

-- 
2.52.0

