Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578D2F0661
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010754; cv=none; b=bLB4c4l8ZlVESMyTqP0+8GFBeJer+S1/5Cnix2abboTrvwvmkk2qbT3LEOlCP/Jto+4suO9hoXnwGYuZxWMZVG+ljepp8Ze6LSb8bWNjXwZAAhj15o74m5x3/ybQFcbJoCZOrzwihfxIH4JEmx28dpU5iMR9gBHrarSJEbHuPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010754; c=relaxed/simple;
	bh=g3feqe7PMEOm6xbZixqwHBXhrUmiJOHmNmVK+oyA9jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFcjphUvquxUNOM7o6DLKlYV/VfdoHW7Z3YZCR89m5n8mMP8258G/jsJqKOBcsxcRSig2yHVrHgc48YfsdEQga0SaFwPaPUuj0/eP2rAPJ/+krCWLXqRCxRZbzPhd070fpb8AugOKrLEo0JOkwuG0xbXk3CUhlz8l+1sfTA4qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcREBLXz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m841XWcQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcREBLXz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m841XWcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IzwBflnfA6L/c6KgZO/swmpBoE0dsUEmdFJd3CVAXgY=;
	b=bcREBLXzmh4Y/FCuo5y+mdRRKJaUdDQP6/DnQOTbLGzalzp3E45BdnZELh0iciSz0r8Iyx
	lWpU3f3y96CwNOAFm2raT0M3kdmQ05qoOXPN+k6rP5NAjlSlrgxanW/FK8uBopA1A51qW0
	tavBeAWdZ+VQo3SguxZnRgPDXm6TIks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-PIqwsgQZOqCae6D_lpk34w-1; Tue, 05 May 2026 15:52:30 -0400
X-MC-Unique: PIqwsgQZOqCae6D_lpk34w-1
X-Mimecast-MFC-AGG-ID: PIqwsgQZOqCae6D_lpk34w_1778010749
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44ffa15dc73so982938f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010749; x=1778615549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzwBflnfA6L/c6KgZO/swmpBoE0dsUEmdFJd3CVAXgY=;
        b=m841XWcQ6B1oJsljY/ag2gXhMXB0J/eWc1EHopYdwZ9j0wE0HDoTi42uwal7/C7EGG
         BIpcz+K9DOydde0qrLuXWzu8vaDjMXibQNEaT/e/X06Zg2l/k5gpiR2Fh9d054i8SanB
         JINdHCDVOadYMcHNCS4JT+yt++yvN3ulzUycQzJmZUtYKTZj67rZbuOHAyAeZRO/hYuK
         C60eZcjtqScsi8sMrNVVyuOh+7xL2+cWHehVZkLPKzVPaTKk5QwAsv8X+ZJD+cDHIw3u
         8JTGJcCeUXYrDxcmrooHgK9pwhrAeW0Cjjj8xm+7oFtn5jB1r9pin2+tpUoQQajVIqgm
         g2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010749; x=1778615549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzwBflnfA6L/c6KgZO/swmpBoE0dsUEmdFJd3CVAXgY=;
        b=bNf+EyYVtFuzokP331HUKFyw1IExOIYzZjk+OrGK20uf628vyOb+c8NCCRmoo9da84
         lC69pLuyq1csEkrOMPpnvpkVB2qvlRxjb/pVr3IfzZSNSO4d3Xy6pmB6RFviALM93MZh
         pyJSPOQm50PRGlRgWNV6Xn/n0gMyKZiE+iEhOWAWnCrDHHPMyrScCAJpQD5r1L8Nu2su
         P1K5iyo2wNByToZdzvOUkR8g9vxSZLTuKq5wexd9eo5shZLa82jKKoKmg1yp5RBOPwgx
         cJbE4hy1uOwR7MUSdJzWGwv5Ex64+PofDqC6owzIs9TnDpO1NRjKin6+H/qAHbC5G+QQ
         RxRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cgUZGFNCYxVyVBDZDTSlq4FtspcnVnfzo3zImf9AXxysbFfA1pMHR2aAPWG4+tsTiegA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVK/FZ232GIDsr3onf5F3r7D+Ib3lGU1iidhoy9HyYbwY1aKI
	yuxRU9xO31a5WzchwCzLToS/poOJQqZuWsP1BrZJpn+1M15rMkFpj0nDcAK5aJJ1T6rgR0IIRuB
	aKlVOrmz4rj7Zf0iXZmTcbaK/65SUsWPT+gaQth0XnORQ300LH2Yr7w==
X-Gm-Gg: AeBDieujGrkVtcU1WbHJ+YI0KL6SRid1bcwTk/EhGZ6VcxUFG8OtFgk38YISuVJ9ibg
	3/ZILRHY9rpx/aINLivaZcfNKhzWIjoBsZaJeJDuIAqRpgtOjUEIbNTLGwO06Sy8Epb+YqWXbTW
	lB+JPHppHiO9tN84PlVYd/sfUhHwpJW7mbT2fDwoVTPjT/sKndbYjuKSL/wVEulFpyUJ7yALC3u
	TWtsn+REKmOlJWOAfedfrFb2KMxpJW5MYWaUK30BO1TwsEJzw6PKIpabEU6YDTRxc0EACT8zm7Z
	uZFUtLgxBhkq0xs37UyAbPBzUna2u/QP3WCMNMyLzqGHs9Ti0SDGnc4n2iJGG0t1/bqmQfgtybX
	2BI7HFPlIx3MFO6AL/OWkRquNOcjNnpR30BLoBHIabx8LlQIUwHCT1Po2ROoOEp7miZ2JGuH2lB
	LAbvAIx22fy++Iy6V1IUT84GaO3AA7wuvm3HKzAdA=
X-Received: by 2002:a05:6000:1a8e:b0:43d:76d8:5798 with SMTP id ffacd0b85a97d-4515cf124e4mr867686f8f.27.1778010748757;
        Tue, 05 May 2026 12:52:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8e:b0:43d:76d8:5798 with SMTP id ffacd0b85a97d-4515cf124e4mr867638f8f.27.1778010748238;
        Tue, 05 May 2026 12:52:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d381c8sm6485345f8f.33.2026.05.05.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
Date: Tue,  5 May 2026 21:51:58 +0200
Message-ID: <20260505195226.563317-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version can also be found in the "queue" branch of kvm.git.
Since it should be final I'm including again for reference the full
description.
    
Both MBEC and GMET allow more granular control over execute permissions,
with different levels of separation between supervisor and user mode.
MBEC provides support for separate supervisor and user-mode bits in the
PTEs; GMET instead lacks supervisor-mode only execution (with NX=0,
"both" is represented by U=0 and user-mode only by U=1).  GMET was
clearly inspired by SMEP though with some differences and annoyances.

The implementation starts from two changes to core MMU code, both
of which help making the actual feature almost trivial to implement:

- first, I'm cleaning up the implementation of nVMX exec-only, by
  properly adding read permissions to the ACC_* constant and to the
  permission bitmask machinery.  Jon also had to add a fourth ACC_*
  bit, but used it only in the special case of nested MBEC; here
  instead ACC_READ_MASK is the normality, which simplifies testing
  a lot and removes gratuitous complexity.

- second, I'm enforcing that KVM runs with MBEC/GMET enabled even in
  non-nested mode, if it wants to provide the feature to nested
  hypervisors.  This makes the creation of SPTEs looks exactly the
  same for L1 and L2 guests, despite only the latter using MBEC/GMET
  fully; the difference lies only in the input access permissions.

This strategy adds a limited amount of complexity to the core is limited,
while providing for an almost entirely seamless support of nested
hypervisors.

Later patches have to use slightly different meanings for ACC_* in Intel
and AMD.  On the Intel side, some work is needed in order to split
shadow_x_mask and ACC_EXEC_MASK in two; now that there is an actual
ACC_READ_MASK to be used for exec-only pages, ACC_USER_MASK is unused
and can be reused as ACC_USER_EXEC_MASK.  However, unlike the older
ACC_USER_MASK hack these differences are backed by concrete concepts
of the page table format, and there is always a 1:1 mapping from ACC_*
bits to PT_*_MASK or shadow_*_mask:

                            Intel                 AMD
     --------------------   -------------------   -------------------
     ACC_READ_MASK          PT_PRESENT_MASK       PT_PRESENT_MASK
     ACC_WRITE_MASK         PT_WRITABLE_MASK      PT_WRITABLE_MASK
     ACC_EXEC_MASK          shadow_xs_mask        shadow_nx_mask
     ACC_USER_MASK          ---                   shadow_user_mask
     ACC_USER_EXEC_MASK     shadow_xu_mask        ---

On Intel, ACC_EXEC_MASK is used for kernel-mode execution and is tied to
shadow_xs_mask (when MBEC is disabled, ACC_USER_EXEC_MASK and the XU bit
are computed but ineffective).  update_permission_bitmask() precomputes
all the necessary conditions.  On the AMD side, the U bit maps to
ACC_USER_MASK but nNPT adjusts the permission bitmask to ignore it for
reads and writes when GMET is active.  Despite the smaller scale of the
changes compared to MBEC, there are some changes to make to use GMET
for L1 guests, because the page tables have to be created with U=0.
This means that the root page has role.access != ACC_ALL and its
permissions have to be propagated down.

Note that with MBEC the user/supervisor distinction depends on the U
bit of the page tables rather than the CPL.  Processors provide this
information to the hypervisor through the "advanced EPT violation
vmexit info" feature, which is a requirement for KVM to use MBEC,
and kvm-intel.ko passes it to the MMU in PFERR_USER_MASK (unlike
kvm-amd.ko which computes it from the CPL).  This needs a small change
to pass the effective XWU permissions of the page tables down to
translate_nested_gpa().

The former "smep_andnot_wp" bit of cpu_role.base, now named "cr4_smep",
is repurposed for nested TDP to indicate that MBEC/GMET is on.  The minor
pessimization for shadow page tables (toggling CR4.SMEP now always forces
building a separate version of the shadow page tables, even though that's
technically unnecessary if CR4.WP=1) is not really worth fretting about;
in practice, guests are not going to flip CR4.SMEP in a way that would
prevent efficient reuse of shadow page tables.

Paolo

v5->v6:
- rename make_spte_executable to change_spte_executable
- rename byte index in update_permission_bitmask to index
- use (u8) casts before "KVM: x86/mmu: introduce ACC_READ_MASK"
- make commit message for "KVM: x86/mmu: split XS/XU bits for EPT" more accurate
- add XU to shadow_acc_track_mask already in "KVM: x86/mmu: split XS/XU bits for EPT"
- fix compilation error
- use alternative code for __vmx_handle_ept_violation suggested by Sean


Jon Kohler (5):
  KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
  KVM: x86/mmu: remove SPTE_PERM_MASK
  KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
  KVM: nVMX: advertise MBEC to nested guests
  KVM: nVMX: allow MBEC with EVMCS

Paolo Bonzini (23):
  KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
  KVM: x86/mmu: remove SPTE_EPT_*
  KVM: x86/mmu: merge make_spte_{non,}executable
  KVM: x86/mmu: rename and clarify BYTE_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
  KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
  KVM: x86: make translate_nested_gpa vendor-specific
  KVM: x86/mmu: split XS/XU bits for EPT
  KVM: x86/mmu: move cr4_smep to base role
  KVM: VMX: enable use of MBEC
  KVM: nVMX: pass advanced EPT violation vmexit info to guest
  KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
  KVM: x86/mmu: add support for MBEC to EPT page table walks
  KVM: x86/mmu: propagate access mask from root pages down
  KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
  KVM: SVM: add GMET bit definitions
  KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
  KVM: x86/mmu: add support for GMET to NPT page table walks
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  48 +++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |  14 ++-
 arch/x86/kvm/hyperv.c              |   4 +-
 arch/x86/kvm/mmu.h                 |  30 +++--
 arch/x86/kvm/mmu/mmu.c             | 182 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |  19 +--
 arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++----
 arch/x86/kvm/mmu/spte.c            |  92 +++++++++------
 arch/x86/kvm/mmu/spte.h            |  70 ++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
 arch/x86/kvm/svm/nested.c          |  38 +++++-
 arch/x86/kvm/svm/svm.c             |  31 +++++
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/capabilities.h    |  12 +-
 arch/x86/kvm/vmx/common.h          |  26 +++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |   9 ++
 arch/x86/kvm/vmx/nested.c          |  46 +++++++-
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  27 ++++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |  18 +--
 27 files changed, 536 insertions(+), 228 deletions(-)

-- 
2.54.0

