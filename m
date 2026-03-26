Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5C35DA40
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549052; cv=none; b=tt8we0d9QimEw0TRYv27Oh0fc+Gx8LQygiCyIxURGkjZjlwLKCyC1fQ2Cw6klsjCW3GCx4AHjrWdzYX+p5bvCc6KUnbRAXMxDISWz0UQhTYZ3OYjduzfvk5VXVfeOO9knFCgPg+yyNveP8GhRUUnOhG+KTuDOqaETbIm/AL34kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549052; c=relaxed/simple;
	bh=niZG6VkAN51JLK1t6c7HcEhniMJlR8fYX5mWvzEBmCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=CduIcu6wGFOkwTYBEgxmZLDsg88A2eHc+YC5j4fG1QY4cuSML8xQcjaK8F/32/4AIFIlRhho6uTKNHv+Tko/wh6yZFjjtKR6lprSjkE3CmisTG6Hkk0EyK8LABVKVkwgx2Q/Yb64PXcMTikItQdhr5Wmlzvccp4GoipceWeo6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC7ELX2O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oCsZgRu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC7ELX2O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oCsZgRu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FCQZKgTIkSlxtemeyvfWASWksZ4VRjPQyyE17m0mqP8=;
	b=GC7ELX2OImmPJ/drHVvK8HwBUkuKNVjM/Jk9ODIQJS7Vo1lA6qriwbkUO618Pd0FTzldLU
	99eIWz9lCZj2JMJZ37oAI/CSi3lPnRFUCZzS+ZsKOcTl68JexFutRfPcDrE5ldnwVetvrQ
	bpNOzPgfQt/6vmGHGFiYab6sMMMFPEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-HubIez_ZOS6aNF9jPFR6BA-1; Thu, 26 Mar 2026 14:17:28 -0400
X-MC-Unique: HubIez_ZOS6aNF9jPFR6BA-1
X-Mimecast-MFC-AGG-ID: HubIez_ZOS6aNF9jPFR6BA_1774549047
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so27003995e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549047; x=1775153847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCQZKgTIkSlxtemeyvfWASWksZ4VRjPQyyE17m0mqP8=;
        b=oCsZgRu4YiKVEZu2FfJXfosFFa2lt4p6WafNXOPotEeI/IWsQ4I2tGInS5wRKI/7rb
         wKZLGpxbecEkSTbmkn+WLlS8Lk3pyr/j1NK1kwgkGbE0727Q3dUZrsSu13o77nhX2cWJ
         8cpyYfk2PRohnQSLVdjCQsV3Z06Px0JOZlg6Iiud3/wv77k7fb+D+QtGFvLZh9WcPngf
         pdYTnkO8jCGuHH9VMFCBLlXNqy4k3oS4vxBtLGt70ALo46YllEiBP3NPEXTrZc+LFtHH
         vKVu+pcr52KpCtfQZ59jFratU7FKhBah0T7qj1wwwmVgoEEbUA6EiJ89QxY/oxfXZ20A
         dCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549047; x=1775153847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCQZKgTIkSlxtemeyvfWASWksZ4VRjPQyyE17m0mqP8=;
        b=pFbbAbGJg4jpvNubw8+MwLALxk0KCDDHsg0yHdhcX3BNrbzLgp/IhTpSpZr6ZD3Udx
         MZPlmJPABwtKx6mKEkKQn+Ly4pivhF7C9kGCPPoTlTRyqCcCdk63qYLGQBa2cLKT1PCa
         Zc1OS6K90hP3G0E4QiE6CSjxveB1nmeHRIjnLpZOx+I1nhCSM0l50cXMrIY7FDG9LxoN
         0fnQ6ORTpw3maDpaTmX4qx3Sb5TEuMGZq5dv8kPJJkioWOs/iPLxaKtQ3zH1hkssYtNj
         VX2LDTPoXJ+rdTm8NrPhBz9MTlrp7ycJHTSALDxZyBaE0Im7sKgRBEW4GqqMIzd/tjka
         rgFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrZcqN5Vkzl+IpJNMUj2ktH4B5pzb9N05bfeqDD3XlYHT6hmoJ8kH+wzpfwxoK1biTlDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrfMPBbt8DwPVmU4BzgT8VkkfqWaPu9weW2FSMUdW3kMB8/oU
	BGdmCuIjMASWC+gAb6iVOoJ18ZsGjmO7FE5C9S0QNp+on2mYaVTBSg/ytkwUP0+3aebGQ9tSlvv
	ZXXxRJpE1opakNwh7Cqfwn6ffTG2X6/BGcu9uBZO3tETFhw/+j+E5ng==
X-Gm-Gg: ATEYQzxNQA/NuZviKsae/O++Z85d01Or9J0/JiMTAMlRpfiexS7G/QQrRXIGUixVtd7
	x9RdLf9NmrvYS1LEwT7xNGZwS2KYQohgS68fjN0qZ7s176jGW//rs80dA0ceaS2T9G5sz07h9ij
	+8+FV60tX1Kiyi2RvixIVLeXj4SRaGar141fJVVnrmCB3wctcEhuSiRoNSvORdppdBxp6gbGIIp
	fg6AAnRp6vPZgJw0enEDIIQpesfWynC6y/2Wgw6m/HoffO+8/lS3i7/yPEJrbBO6lJWVaHyiVv5
	6W/c6V2xpuruLeJo5KgwNVpnTTU3FiKCIcurofbl4aL7bKzTnneWiZB/sFJx5mMNomNxTVS40M+
	VaRKkyYHjgvdjDTZhMsN1bUH3C2rzO0JifJG+d4brrDmPYm/px3mljPB0Lej5W933HxmaPjZyUc
	6mWgJOvjZ2TYJ1I/diBMyxjwLu
X-Received: by 2002:a05:600c:3e8e:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-48722ba925amr41934765e9.6.1774549046723;
        Thu, 26 Mar 2026 11:17:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8e:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-48722ba925amr41934105e9.6.1774549046154;
        Thu, 26 Mar 2026 11:17:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d9acb9sm1679495e9.1.2026.03.26.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
Date: Thu, 26 Mar 2026 19:16:58 +0100
Message-ID: <20260326181723.218115-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

This series introduces support for two related features that Hyper-V uses
in its implementation of Virtual Secure Mode; these are Intel Mode-Based
Execute Control and AMD Guest Mode Execution Trap.

It's still RFC because it can definitely use more testing and review,
but I'm pretty confident with the overall shape and design.

Both MBEC and GMET allow more granular control over execute permissions,
with different levels of separation between supervisor and user mode.
MBEC provides support for separate supervisor and user-mode bits in the
PTEs; GMET instead lacks supervisor-mode only execution (with NX=0,
"both" is represented by U=0 and user-mode only by U=1).  GMET was
clearly inspired by SMEP though with some differences and annoyances.

The series was developed starting from Jon Kohler's earlier version at
https://lore.kernel.org/kvm/20251223054806.1611168-1-jon@nutanix.com/.
The difference is that I am starting this implementation from two
changes to core MMU code, even before looking at nested MBEC/GMET;
these are seemingly unnecessary for that goal but they make the actual
feature almost trivial to implement:

- first, I'm cleaning up the implementation of nVMX exec-only, by
  properly adding read permissions to the ACC_* constant and to the
  permission bitmask machinery.  Jon also had to add a fourth ACC_*
  bit, but used it only in the special case of nested MBEC; here
  instead ACC_READ_MASK is the normality, which simplifies testing
  a lot and removes gratuitous complexity.

- second, I'm enforcing that KVM runs with MBEC/GMET enabled even in
  non-nested mode, if it wants to provide the feature to nested
  hypervisors.  Initially I thought this would mostly simplify the
  testing; but it actually has a big effect on the code as well, because
  the creation of SPTEs now looks *exactly the same* for L1 and L2 guests;
  the difference lies only in the input access permissions.

Later patches have to use slightly different meanings for ACC_* in Intel
and AMD, but the differences are driven by whether the underlying SPTEs
have U/NX or XS/XU bits, and propagate from there.  In other words,
unlike the older ACC_USER_MASK hack these differences are backed by
concrete concepts of the page table format, and there is always a 1:1
mapping from ACC_* bits to PT_*_MASK or shadow_*_mask:

                            Intel                 AMD
     --------------------   -------------------   -------------------
     ACC_READ_MASK          PT_PRESENT_MASK       PT_PRESENT_MASK
     ACC_WRITE_MASK         PT_WRITABLE_MASK      PT_WRITABLE_MASK
     ACC_EXEC_MASK          shadow_xs_mask        shadow_nx_mask
     ACC_USER_MASK          ---                   shadow_user_mask
     ACC_USER_EXEC_MASK     shadow_xu_mask        ---

As can be seen above, the Intel side needs a little work to split
shadow_x_mask and ACC_EXEC_MASK in two; now that there is an actual
ACC_READ_MASK to be used for exec-only pages, ACC_USER_MASK is unused
and can be reused as ACC_USER_EXEC_MASK.  ACC_EXEC_MASK is used for
kernel-mode execution and is tied to shadow_xs_mask (when MBEC is disabled
shadow_xs_mask == shadow_xu_mask, and ACC_USER_EXEC_MASK is computed but
ineffective).  update_permission_bitmask() precomputes all the necessary
conditions.  Note that with MBEC the user/supervisor distinction
depends on the U bit of the page tables rather than the CPL; processors
provide this information to the hypervisor through the "advanced EPT
violation vmexit info" feature, which is a requirement for KVM to use
MBEC, and kvm-intel.ko passes it to the MMU in PFERR_USER_MASK.

On the AMD side, the U bit maps to ACC_USER_MASK but nNPT adjusts the
permission bitmask to ignore it for reads and writes when GMET is active.
Despite the smaller scale of the changes compared to MBEC, there are some
changes to make to use GMET for L1 guests, because the page tables have
to be created with U=0.  This means that the root page has role.access !=
ACC_ALL and its permissions have to be propagated down.

In both cases, the complexity added to the core is limited in comparison
to the benefits of a pretty seamless nested support.

The former "smep_andnot_wp" bit of cpu_role.base, now named "cr4_smep",
is repurposed for nested TDP to indicate that MBEC/GMET is on.  The minor
pessimization for shadow page tables (toggling CR4.SMEP now always forces
building a separate version of the shadow page tables, even though that's
technically unnecessary if CR4.WP=1) is not really worth fretting about;
in practice, guests are not going to flip CR4.SMEP in a way that would
prevent efficient reuse of shadow page tables.

Patches 1-9 are general cleanups, mostly for MMU code.

Patches 10-17 are for Intel MBEC, with the first three covering
non-nested use.

Patches 18-24 are for AMD GMET, with 18/19/20/22 covering non-nested
use and the others covering nested virtualization.

(Patch 25 is a nice little hack that can be useful for testing).

Paolo


v1->v2:
- fix EXPORT_SYMBOL_FOR_KVM_INTERNAL goof
- drop bit 10 from FROZEN_SPTE, add static_assert to catch it [Kai]
- fix exit qualification for page table EPT violations [kvm-unit-tests]
- add XU to shadow_acc_track_mask
- propagate root_role->access also in shadow MMU direct_map()
- add requested access to kvm_mmu_spte_requested tracepoint
- include support for passing advanced EPT violation vmexit info to guest
- advanced EPT violation vmexit info is now required for nested MBEC
- fix nested MBEC to gate XS vs XU based on the U bit of paging structures
- drop SECONDARY_EXEC_MODE_BASED_EPT_EXEC if L1 does not set it
- add commit message to "KVM: nVMX: advertise MBEC to nested guests" [Jon]
- fix checkpatch.pl issues [Jon]
- drop gmet from /proc/cpuinfo [Borislav]
- fix running L1 without GMET



Jon Kohler (5):
  KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
  KVM: x86/mmu: remove SPTE_PERM_MASK
  KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
  KVM: nVMX: advertise MBEC to nested guests
  KVM: nVMX: allow MBEC with EVMCS

Paolo Bonzini (20):
  KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
  KVM: x86/mmu: remove SPTE_EPT_*
  KVM: x86/mmu: merge make_spte_{non,}executable
  KVM: x86/mmu: rename and clarify BYTE_MASK
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
  KVM: x86/mmu: split XS/XU bits for EPT
  KVM: x86/mmu: move cr4_smep to base role
  KVM: VMX: enable use of MBEC
  KVM: nVMX: pass advanced EPT violation vmexit info to guest
  KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
  KVM: x86/mmu: add support for MBEC to EPT page table walks
  KVM: x86/mmu: propagate access mask from root pages down
  KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
  KVM: SVM: add GMET bit definitions
  KVM: x86/mmu: add support for GMET to NPT page table walks
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests
  stats hack

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  45 +++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |  14 ++-
 arch/x86/kvm/mmu.h                 |  12 ++-
 arch/x86/kvm/mmu/mmu.c             | 162 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
 arch/x86/kvm/mmu/paging_tmpl.h     |  66 ++++++++----
 arch/x86/kvm/mmu/spte.c            |  77 ++++++++------
 arch/x86/kvm/mmu/spte.h            |  65 +++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
 arch/x86/kvm/svm/nested.c          |  16 ++-
 arch/x86/kvm/svm/svm.c             |  32 +++++-
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/capabilities.h    |  11 +-
 arch/x86/kvm/vmx/common.h          |  20 ++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |   9 ++
 arch/x86/kvm/vmx/nested.c          |  25 ++++-
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  29 +++++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |   1 +
 26 files changed, 437 insertions(+), 191 deletions(-)

-- 
2.53.0

