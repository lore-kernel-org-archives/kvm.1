Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DC38F92D;
	Thu, 18 Jun 2026 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771944; cv=none; b=SWc8JnoDGbLAaw2FS48aatClJQ5OpENIvDDNCfw8xUKiuDFTAuoKU50gFxSf7oJXnJSoqLTsY+nQUB5bajbNwnLwFB/uudyfT5zo5sMAhiPuKL5l6fivmsoMKYMZLc6AR9QUvSMt87F0CDODxxW8AGlmKdJo2gB0nDSQEbeoSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771944; c=relaxed/simple;
	bh=pQqkQ0d0Cwu6speH476hyRJ334B2J0cZc/f+1YHX0eA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ajiWL6jbTrOwpImSEIIbCG3GF6iTpFhDhW1je1zhlstZaEaEObrYds3sD+DygXpJAJxDonlVv470piBAVBXrqEwchBvo/wN6B0ip/osOAkCDiDF1sLHtOxt/BfljiCENznCYl3Gi9z8zK1kThiBVVmqVqhcjVsgannlf4dKTlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvbbpTlB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvbbpTlB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771941; x=1813307941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pQqkQ0d0Cwu6speH476hyRJ334B2J0cZc/f+1YHX0eA=;
  b=CvbbpTlB0h9n2Zeka758m/xAdPekH5PWRnPgOnXoBavLSGgTxy5wDRRT
   XbdJxdWW0kpqKNov6/b5xt/I6b4pPNvcAPFVtn6uHv52cBPywXXx+21RY
   PYEP6ooZ+2NFh4W4ZQpoNibzxF/BUdG8q8SU+xCzdllNiOJMTvTesaWp/
   szmE3FQdQJ27vageIdiqUbF2V8N1SPW4Bg9uyv3Q+EZCvomhgIc8h4m55
   j3/uHJOn2Q5/bIQ7pJZ1yS8t9seBjKC3BrGFEbkSsJICZ+px2dS8w5uol
   bxeTKjn3/qQ0D+aMu9s3hBGUMZxAASsf9FZO4gekQ0PtQvZuKe4CzwDGj
   A==;
X-CSE-ConnectionGUID: WM6OchTQQEi5AcBLbo3RQg==
X-CSE-MsgGUID: YbaMKrLkRDCpN2Z6vy9CfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584604"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584604"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:00 -0700
X-CSE-ConnectionGUID: ay1jMGVKTc+uUVWke/A3kw==
X-CSE-MsgGUID: Rr4xM7vcQZ2d2Cq2tLg7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392112"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:38:55 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 00/17] Enable DICE-based TDX Quoting Extension
Date: Thu, 18 Jun 2026 16:13:38 +0800
Message-Id: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds infrastructure to enable TDX module extensions and
then implements DICE-based TDX Quoting extension. This is the 2nd
version and a significant change is that we want the quoting part to
merge along with the basic TDX module extensions part, rather than
serving as an example. So the quoting part drops RFC tags and requires
initial review. The basic extensions part addresses v1 comments and
needs more detailed review.

The quoting part contains some KVM patches, so we sorted the series for
easier review and pick:

  Patches  1-6:  Enable the TDX module extensions support
  Patches  7-14: DICE-based TDX Quoting, x86/tdx part
  Patches  15-N: DICE-based TDX Quoting, KVM part

== Overview ==

To date, SEAMCALLs have been short lived routines that monopolize the
CPU for their duration. This limits their utility for implementing
higher order security protocols, or pushes complexity into Linux - such
as by fragmenting a protocol setup service into several SEAMCALLs. The
Linux appetite for ingesting complexity is low, so TDX now adds a new
class of SEAMCALLs that are preemptible and resumable. This capability
allows for higher-level API constructions - like "create a DICE-based
quote" - which are more aligned to what is a good fit for Linux.

This new "extension SEAMCALL" capability is akin to ARM CCA's "Stateful
RMI Operations (SRO)", and achieves similar externalized complexity
relief as a dedicated hardware co-processor like AMD SEV-SNP. The
mechanism is "give the service environment some memory", "invoke the
service API", and "continue invoking until complete". All protocol state
is internal to the service API.

TDX introduces "TDX module extensions" as the service environment for
some add-on features - such as DICE-based quoting, TDISP, and live
migration - to use "extension SEAMCALLs".

The extension SEAMCALLs are designed to be transparent to the host,
using the same interface as normal SEAMCALLs, but the service
environment should be initialized in several steps. First,
configure/select (via TDH.SYS.CONFIG) add-on features during basic TDX
initialization. Second, check if TDX module extensions are required to
support these add-on features by reading TDX global metadata. Third, add
extra memory to the TDX module via a SEAMCALL (TDH.EXT.MEM.ADD).
Finally, use another SEAMCALL (TDH.EXT.INIT) to initialize the
extensions.

== DICE-based Quoting extension ==

The first feature to use these extensions is the TDX Quoting extension [1],
which converts guest launch attestation reports into a document that can be
verified externally.

Today, the TDX host requires a separate software service to generate Quotes.
The Quoting extension allows the TDX module to generate Quotes directly,
without relying on a discrete Quoting engine. This simplifies the overall
attestation flow: KVM no longer needs to return to userspace for Quote
generation. Instead, Quote generation is handled directly by the TDX module
through an extension SEAMCALL. See [2] for an overview of TDX attestation.

The Device Identifier Composition Engine ("DICE") provides a standardized
framework for layering attestation evidence. It replaces SGX-based attestation
and moves away from Intel-proprietary formats. It also eliminates the SGX
requirement to contact an Intel service to obtain a certificate first.
Instead, all attestation evidence is embedded in the Quote itself.

== The trade-off ==

The extensions create an extension instance for each feature that
requires extension SEAMCALLs. More memory is consumed when more
extension instances are created. There are 3 extensions (quoting, TDISP,
Migration) in the foreseeable future. Turning on them all will require
tens of megabytes. Note that the host can never reclaim the memory added
to the extensions.

According to the TDX module design, basic TDX functionalities can run
without the extensions. So theoretically the extensions don't need to be
enabled at basic TDX initialization time. They could be lazily enabled
right before the first extension SEAMCALL is issued.

However, Linux applies a simple policy for TDX: turn on all the features
that Linux knows about all the time, unless and until any evidence makes
this approach untenable. Enabling the extensions along with the basic
TDX at boot time aligns with the policy, and offers several good
reasons:

  1. Simplify TDX state management, avoid runtime state transitions that
     could introduce race conditions or unexpected failure modes.

  2. The kernel doesn't have to keep track of which SEAMCALLs need the
     extensions, as there is no HW/FW enumeration for this.

  3. When no extension is configured, the extensions initialization is
     virtually skipped. So no impact on existing kernels.

  4. A small trade-off is that eager initialization allocates memory
     (tens of megabytes) at boot time before any feature starts to work.
     However, these features provide critical security capabilities in
     confidential computing. They are expected to be enabled eventually
     when available. So this merely advances the timing of memory
     allocation.

== Restore the extensions after runtime TDX module update ==

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. As part of the
restoration process, TDX module extensions must also be re-initialized
to re-enable extension SEAMCALLs.

Similar to TDH.SYS.CONFIG, TDX module extends TDH.SYS.UPDATE with more
parameters for the host to re-enable desired add-on features. Then host
must re-execute all extensions initialization steps to restore extension
SEAMCALL functionality.

However, Linux runs the update in stop_machine() context, which prevents
memory allocation. This introduces a hard restriction that the updated
TDX environment must not consume more memory for the extensions.

Fortunately, Linux applies another policy that no newer features should
be added during runtime update to avoid disrupting live TDX operations.
To adhere to this, TDH.SYS.UPDATE must enable the same features as the
TDH.SYS.CONFIG. This policy mitigates the memory allocation problem a
lot by minimizing the chance of increased memory demand. So now the
restriction only affects the compatibility rule for choosing the update
image.

The same memory constraint applies to the Quoting extension. A compatible
runtime update must not increase the size limit of its Quotes, because the
buffer used for Quote generation is allocated during TDX bringup. Otherwise,
attestation could fail after the update if the TDX module requires a larger
buffer for Quotes.

== Some history ==

The TDX module extensions support part was first posted along with TDX
TDISP [3]. But quoting is the simplest consumer and is chosen as the
lead vehicle over TDISP.

== Misc ==

This series is based on tip/x86/tdx [4], because we need the extensions
play nice with runtime TDX module update.

Link: https://cdrdv2.intel.com/v1/dl/getContent/874303 # [1]
Link: Documentation/arch/x86/tdx.rst, Section "Attestation" # [2]
Link: https://lore.kernel.org/all/20260327160132.2946114-1-yilun.xu@linux.intel.com/ # [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx # [4]

== Changelog ==

v2:
- Support runtime TDX module update
- Refine quoting patches, drop RFC tag
- Change the patch order. (Xiaoyao & Tony)
- Fold metadata readings changes into patches that use them.
- Read the extensions metadata at init_tdx_ext() (Rick & Xiaoyao)
- Don't do get_tdx_sys_info() a 2nd time after TDH.SYS.CONFIG (Rick & Xiaoyao)
- Delete tdx_clflush_hpa_list() (Rick)
- s/TDX Module/TDX module (Sohil)
- s/Extensions/extensions (Dave)
- Change the data type of ext_required to bool (Rick)
- Change the data type of memory_pool_required_pages from u16 to u32,
  the Module team see this problem and promise the change (Sohil)
- s/init_tdx_ext()/init_tdx_module_extensions() to disambiguate from
  tdx_ext_init() (Kishen)
- Cover-letter & change log re-phrase (All reviewers)

v1: https://lore.kernel.org/all/20260522034128.3144354-1-yilun.xu@linux.intel.com/


Peter Fang (11):
  x86/virt/tdx: Initialize Quoting extension
  x86/virt/tdx: Prepare Quote buffer during extension bringup
  x86/virt/tdx: Add interface to check Quoting availability
  x86/virt/tdx: Move tdx_tdr_pa() up in the file
  x86/virt/tdx: Add interface to generate a Quote
  x86/virt/tdx: Reinitialize the Quoting extension after TDX module
    update
  x86/virt/tdx: Enable Quoting extension
  x86/tdx: Move and rename Quote request structure
  KVM: TDX: Factor out userspace return path from tdx_get_quote()
  KVM: TDX: Add in-kernel Quote generation
  KVM: TDX: Support event-notify interrupts only with userspace Quoting

Xu Yilun (6):
  x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
  x86/virt/tdx: Configure add-on features on TDX module init and update
  x86/virt/tdx: Detect if the extensions initialization is required
  x86/virt/tdx: Add extra memory to TDX module for the extensions
  x86/virt/tdx: Make TDX module initialize the extensions
  x86/virt/tdx: Re-initialize the extensions on runtime TDX module
    update

 Documentation/arch/x86/tdx.rst              |  19 +-
 Documentation/virt/kvm/api.rst              |   3 +
 arch/x86/include/asm/tdx.h                  |  35 ++
 arch/x86/include/asm/tdx_global_metadata.h  |   9 +
 arch/x86/kvm/vmx/tdx.h                      |   6 +
 arch/x86/virt/vmx/tdx/tdx.h                 |  33 +-
 arch/x86/kvm/vmx/tdx.c                      | 176 +++++++-
 arch/x86/virt/vmx/tdx/tdx.c                 | 465 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  34 ++
 drivers/virt/coco/tdx-guest/tdx-guest.c     |  47 +-
 virt/kvm/kvm_main.c                         |   1 +
 11 files changed, 755 insertions(+), 73 deletions(-)


base-commit: 2b9ad7a6154e0938b9458691536296dd0224942d
-- 
2.25.1

