Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997066;
	b=KVx0QN0RpDCuCyYqWzqRWumgXFecQePFK74QCHQ3uDv2XtE0l42GxE3XSHsUEX+/TTFH
	 WAPGnA/CiQEiY4dyn98SMF1p1ScBr/JY8jHT4fKAHeWNeZweld49bolbeDrTvyCkFs4Sm
	 7ghkh3ARPOCFG4Pi5VxUSgWbvr2nD8a3Wkm3ZteUs/LrTUcP5K/0PEMMR3vxhr214sB6c
	 7ayP2n5W+WxuxZOgtNd+rcjCyVCSucoa+jK0B4HIvW5ZvUg2w3xsUJHJtc1xMHFeqM96n
	 br9ngWhLA+k7JtIO751YqsO/g8M87oxJYY1EBBm6NV+0Ifb4VMOrUeh67tv9iFWo19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=4z6v3tcaLUknSyizTZBG4Psqu25Q3ieXoWj4ZLsIugA=;
	b=aGrJK42lYuyhAA2B5a4IMIfaTEUApV8qKlrijNblc6bWrVmmU4Tc5IZN38o4SU98u23l
	 SzNTWItO4b3bLeyGYxhHZg9rbToUW0ycL/ZF33cVb6OpIbSVSIl64opDiQcIst9Ft5vV/
	 w6hYTBo3etV2ucIAE45aaJwsRGIa7YFPqRgBE3LcOGK8Zt2mCPGxdLKB+/rGa86UoBGBu
	 cGTY1z+hw+u8HPZxsmxkPVPShGaCE9/9k7mISaBW8eK6UOn0/oAb6ilfHja7sXOcJ8BTt
	 2RHCb4wr6S4/DicVSifVt/BJjvqSWdO2dUGUxqXxhh1mwA1o17YJlmMa0ZP+0mD+PYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Av5ZG38x;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46528606A325
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 06:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46528606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Av5ZG38x
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdac8b7169eso65088a12.2
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997066; x=1793601866; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4z6v3tcaLUknSyizTZBG4Psqu25Q3ieXoWj4ZLsIugA=;
        b=Av5ZG38xNkTyJLRj0cn9KvE8lWzWs+/V5hBlltzmk5kvPt0/0fuF/9bUC9l2PcgVV6
         +db+QYl+1WAgZB+/jcWOUYzr/gsa3jqritTymf02yS0XpDdvojIQuVABTlYWDhhWQ8R1
         1pOBJGTq4gBEIUV45tOK489Dw25m/UQw026dglksnh7QGoOEvivJhyvIiORVgDx4NsNT
         l4/mbAn9kdO6nUXfOmvHq3dSOZ0tCVXAlAnyhgr+NEeRozZqZc0RxJMytFibj6jC5PAF
         YSvxcYSjr4UFxu1vTdpFwdZ7c17Ct/6uS9ryhVbauF0Qd/qh1ntTN7R5XLoEeMXc/Qy+
         RuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997066; x=1793601866;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4z6v3tcaLUknSyizTZBG4Psqu25Q3ieXoWj4ZLsIugA=;
        b=ZeXleamTD9kUT9Og+6tKhZvYGqFvgvXws0MRujxZic6BWpKHutLjlNEJ9Ibuj9gN0X
         keJnkBC/e8MY/ccl6kCicqh6g1hApW05TNMFjlKbz8NER+sj3kmOzTi5xlerhXwavbSU
         IvHXroF9r2Gr3z3Mk0DYSRbkx9tR5Emo29z4vEbqmi667BRoj5JdPOCACeXyQb0Im+IC
         vavVp+7WuSbjepMH8MA0IL1wOyWmzs1fRFfs/s1wFHMXVC05LHpxSZjubZYMSOK/B5++
         LikITP5Rirm5gmSAwuayw1iu7b1ja19p0tG3ZzGb2aBkd5mlXu0kxSoLWLf9+UtwNs3H
         7u0w==
X-Gm-Message-State: AFq9FYLxdnUhCjbMqirNkVsVpyEa3bg7CY0befExxfjYSRVJUJoHi0TZ
	k35exsS8Kgc61EniyG7PjsrN9Kk6JuS1XzzQ9jwoyGilpIv+OX96L4kupSZPPp2QTemTCUjR+PY
	CVT9tQme6EgXOr7+LQQPHiVI2+gMlFP7wyHxASfuL7NCrynH0PmExFAH9iYRr3PbRlWnTKXBTIY
	/P/6KnxtSvv+PJe/CLHkxgoInYaSMQqYLQ855big==
X-Received: from pgbcq4.prod.google.com ([2002:a05:6a02:4084:b0:cca:dcca:4599])
 (user=gongtao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3f94:b0:3e5:396d:1f89
 with SMTP id adf61e73a8af0-3e7af7e9aa3mr4608722637.6.1792997065214; Sun, 25
 Oct 2026 23:44:25 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:44:19 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026064424.3003536-1-gongtao@google.com>
Subject: [RFC PATCH v3 0/5] KVM: guest_memfd: Add KVM_LINK_GUEST_MEMFD ioctl
From: Tao Gong <gongtao@google.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Tao Gong <gongtao@google.com>, David Hildenbrand <david@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Sagi Shahar <sagis@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

This series adds KVM_LINK_GUEST_MEMFD, a VM ioctl that takes an existing
guest_memfd fd and returns a new guest_memfd fd, bound to the VM on which
the ioctl is invoked, that refers to the same underlying guest_memfd
inode.

It is v3 of the gmem linking RFC [1][2], rebased onto kvm-x86/coco and
reduced to the linking part: the prerequisites from RFC v2 are upstream
now, and the KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM memory context changes will
be posted as a follow-up series on top of this one.

Problem
-------

A guest_memfd is bound to the VM that created it: binding a memslot to
a guest_memfd requires the file's owning VM to be the memslot's VM, and
there is no way to reassign a guest_memfd instance to a different KVM
instance. Passing the fd to another process does not change that.

For VMs with private memory this is a hard limit. Private memory is not
accessible to the host, so it cannot be copied through userspace into a
new VM's guest_memfd. The only way to move a confidential VM to a new VM
instance on the same host (intra-host migration, e.g. to replace the
VMM) is for the new VM to take over the same memory in place.

Design
------

guest_memfd already splits state between the file and the inode: memslot
bindings and the owning VM belong to the file (struct gmem_file), while
the memory itself, its flags and (with in-place conversion) the
shared/private attributes belong to the inode (struct gmem_inode).
Linking creates another file for the same inode, so a second VM can bind
the same guest memory to its memslots without the memory being copied or
going through userspace.

Linking is only allowed between distinct, compatible VMs. On x86 both
VMs must have the same VM type, so that e.g. memory private to a TDX
guest can never be mapped into a non-TDX VM; the generic fallback
requires both VMs to agree on kvm_arch_has_private_mem(). These checks
are defensive; the underlying rule is that KVM must never create a
stage-2 mapping for a confidential VM to another confidential VM's
private memory (see the cutover question below). Linking therefore
does not make private memory shareable between VMs: a private page
remains usable only by the VM that owns it.

Use cases
---------

1. Intra-host migration of VMs with private memory, where the
   destination VM takes over the source VM's guest memory in place:

   a. Userspace passes the source VM's guest_memfd fd to the destination
      VM, e.g. over a Unix socket.
   b. The destination VM calls KVM_LINK_GUEST_MEMFD to get a new fd for
      the same inode, bound to the destination VM.
   c. The destination VM binds the new fd to its memslots with
      KVM_SET_USER_MEMORY_REGION2, at the same offsets as the source.
   d. The remaining VM state is moved with KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      (SEV only today; generalized by the follow-up series) and the
      destination VM is run as normal.

   Linking does not revoke the source VM's access; the source simply
   stops using the memory, so every private page keeps a single owner.

2. Sharing guest memory between non-confidential VMs. Both VMs bind the
   same inode at the same time, each through its own file, and the
   memory keeps its guest_memfd properties: neither VMM needs a
   userspace mapping of it, and inode-level operations such as a hole
   punch apply to every linked VM.

   A related use raised in discussion is Nitro Enclaves-style memory
   donation, where a guest gives part of its memory to a sibling VM on
   the same host ("nesting without real nesting").

Alternatives considered
-----------------------

* Passing the VM fd to the new VMM and adding a way to reset the VM
  while keeping its vCPUs and guest_memfds. A KVM VM is bound to the mm
  that created it (VM, vCPU and device ioctls from another process fail
  with -EIO), and its memslots and MMU notifier refer to that address
  space. Re-homing a VM would be considerably more invasive than
  creating a new VM and moving state into it, which is the model KVM
  already uses for SEV intra-host migration
  (KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM); linking extends that model to
  guest_memfd.

* Keeping the memory and its attributes in a "memory provider" and
  creating two independent guest_memfd instances on top of it. The
  guest_memfd inode already plays that role today (page cache,
  attributes and the list of files), so linking gets the same result
  without a new abstraction. If guest_memfd grows a provider layer,
  linking could be expressed on top of it.

Open questions
--------------

* Cutover: for confidential VMs, an explicit cutover that delinks the
  source VM's file at handover, instead of relying on the source to
  stop, may be required for security: it is what guarantees that a
  private page is never usable by two VMs when memory is transferred.
  That would be a separate operation on top of this series;
  non-confidential VMs probably do not need it.

* IOMMU and DMA: whether iommufd page tables and in-flight DMA keep
  working across a handover, and how they would be transferred, is not
  addressed here. The pages themselves stay alive for as long as any
  linked file exists.

* Conversions: with in-place conversion the shared/private attributes
  live on the inode, so a conversion by one VM applies to, and
  invalidates, every linked VM. That is the intended behavior for
  migration, where only one VM is live. Between confidential VMs it is
  also required: with today's hardware they can at best share their
  shared ranges.

Patches 1-2 add the ioctl, patch 3 advertises KVM_CAP_GUEST_MEMFD_LINK,
and patches 4-5 add selftests, including a test that transfers private
memory between two KVM_X86_SW_PROTECTED_VMs.

The series is based on kvm-x86/coco at commit ad06cf5338bc ("KVM:
guest_memfd: Avoid deadlock in error_remove_folio()").

Tested with the KVM selftests (guest_memfd_test, set_memory_region_test,
guest_memfd_conversions_test, private_mem_conversions_test,
private_mem_kvm_exits_test, private_mem_migrate_tests) on an Intel host,
both with and without kvm.gmem_in_place_conversion.

Changes from RFC v2 [2]:
+ Dropped the anon inode and guest_memfd inode patches, which are
  upstream now (anon_inode_make_secure_inode() and commit a63ca4236e67
  ("KVM: guest_memfd: Use guest mem inodes instead of anonymous
  inodes")).
+ Dropped the KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM memory context patches
  and their selftests, to be posted separately on top of this series.
+ Rebased onto kvm-x86/coco: uses struct gmem_file and the inode's
  gmem_file_list, and takes the mapping's invalidate_lock when adding a
  linked file to the list.
+ Renamed kvm_gmem_alloc_view() to kvm_gmem_alloc_file().
+ Only allow linking between compatible VMs (same VM type on x86).
+ Reject non-zero reserved fields and fds larger than INT_MAX.
+ Dropped the i_nlink increment, which had no matching decrement.
+ Take the inode reference before creating the linked file.
+ Added KVM_CAP_GUEST_MEMFD_LINK and gated the selftests on it.
+ Documented KVM_LINK_GUEST_MEMFD in Documentation/virt/kvm/api.rst.
+ Selftests: fixed the negative tests to exercise the intended checks,
  added tests for out-of-range fds, non-zero reserved fields and VM type
  mismatch, and made private_mem_migrate_tests work with in-place
  conversion.

[1] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/cover.1747368092.git.afranji@google.com/

Ackerley Tng (4):
  KVM: guest_memfd: Refactor out kvm_gmem_alloc_file()
  KVM: guest_memfd: Add ioctl KVM_LINK_GUEST_MEMFD
  KVM: selftests: Add tests for KVM_LINK_GUEST_MEMFD ioctl
  KVM: selftests: Test transferring private memory to another VM

Vishal Annapurve (1):
  KVM: guest_memfd: Advertise support for KVM_LINK_GUEST_MEMFD

 Documentation/virt/kvm/api.rst                |  50 ++++++
 arch/x86/kvm/x86.c                            |  10 ++
 include/linux/kvm_host.h                      |   1 +
 include/uapi/linux/kvm.h                      |   9 ++
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  |  64 ++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |  18 +++
 .../kvm/x86/private_mem_migrate_tests.c       | 118 ++++++++++++++
 virt/kvm/guest_memfd.c                        | 150 ++++++++++++++----
 virt/kvm/guest_memfd.h                        |   1 +
 virt/kvm/kvm_main.c                           |  12 ++
 11 files changed, 407 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/private_mem_migrate_tests.c


base-commit: ad06cf5338bc5501bd989584db6dc71972bb436a
-- 
2.56.0.257.gf7497c7d27-goog

