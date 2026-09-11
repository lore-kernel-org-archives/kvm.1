Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CC3EB0FB
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152524; cv=none; b=ZltxlBIMTXlbkVZCPRn/poBBENH4B7xmQcZfonAXcE4tNEayhYaA2tsaftieEEuP7Bzyw30qGcCLEnLhoEwtS74SrjEU91G/FwhH99HYdkzNhY3szDAnnXWks8bIslr/tN8GkreaUJusF4n1/99OzbT8ZT9lvdeZUyjLZHcmqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152524; c=relaxed/simple;
	bh=R0cSHGTivImm5E2vhTmLqFFMFlDkkoGYSYYd9PSSEe8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cAsmcs071A+vGM7DkA323L3f6g3XKZMARA9wzg2rsUdzl4U0zG6bUz9vF6oTWvYWp6JJP3c32Kn8pq0Yrn7iedb8WGon3t9OHFy8z+BLJLUkKtbxocu8Ju5LhaaUKaoIVK6HInBx46j30KbwXNzo/ul6yV3/jIHdTFGAmGRxLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bfCKR6cJ; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bfCKR6cJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=w5zwmdb55verxdk52baibi64lm.protonmail; t=1789152509; x=1789411709;
	bh=85r3YDwJ6NVUqAA9xIMn3dcEER15Rxl+yNUrR4aU65A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bfCKR6cJZKwtOEMouLOgQU3NEbGRh8r+YF2/Gn0Dm0Y0RehNg+7gZp352iw4x/Mlw
	 Tbf/I/tIMUm5s5u+7oF0+bhyT8m0vZaA+6RGKZnBRgIlcXnCqdDKAR4x9NWPeHjXQF
	 W2ziYipVShBMxlke4Z6c+y7tLk8HwOI5BAhJs9GE20B3pj9k27WPG/6t3Rv+WMq04d
	 MfuHQEFnsMQm1SLcNHGeNFHr6XCIBzSIKriq70hWEl3g1/6eXRjXhWYDpL++yYBkrT
	 ssDhV6r2seISaZsX5Fa9mk+55aDYU5JD+3rzS8QCzK4oa4UIl7A/Y1IZog1j109s5T
	 pWTwjuBy2d2iQ==
Date: Fri, 11 Sep 2026 18:48:26 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH 0/2] KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911184819.101123-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 6d8039135b8db9d42eb0b1f244cb100afd4ef3c3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Affected version/commit: v7.2-rc5 (commit 699594e8888d is not needed here;
verified on v7.2-rc5 as of 2026-09-09 and on v6.18.48; the code paths are
unchanged between them and present in mainline. The ioctl was introduced
in v6.8 with the per-page memory attributes series).

Problem
-------

kvm_vm_ioctl_set_mem_attributes() (virt/kvm/kvm_main.c) validates the
user-provided range only for representability (zero size, 64-bit wrap,
alignment, supported attributes) and not for magnitude.  With attributes
!=3D 0, kvm_vm_set_mem_attributes() then walks every GFN in the range:

        for (i =3D start; i < end; i++) {
                r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUN=
T);
                if (r)
                        goto out_unlock;
                cond_resched();
        }

xa_reserve() materializes the full root-to-leaf path of xa_nodes for each
GFN even though the GFNs need no backing memory and no memslots need to
exist.  Each xa_node is 576 bytes from radix_tree_node_cachep; densely
filled, the tree costs ~9.3 bytes per GFN.  On ENOMEM the loop bails out
without undoing prior reservations, and the only release path is
kvm_destroy_vm(); the memory is therefore retained across calls and lives
for as long as the VM fd.

Additionally, the intended memcg accounting does not take effect: the
nodes are allocated with GFP_NOWAIT in xas_alloc(), gaining __GFP_ACCOUNT
only when the xarray carries XA_FLAGS_ACCOUNT, which kvm does not set
(kvm_create_vm() uses plain xa_init()).  Measured: a process inside a
cgroup limited to 256 MiB grew host SReclaimable by ~450 MiB while its
memory.current stayed at ~488 KiB.

Triggering conditions
---------------------

- An unprivileged user with write access to /dev/kvm (sysfs default and
  the common udev default are 0666).
- A VM whose type sets private memory support: sw protected VM
  (CONFIG_KVM_SW_PROTECTED_VM, depends on EXPERT), TDX or SNP.
- No memslots, no guest memory and no guest CPUs are required.
- Verified outcomes on v6.18.48 (KASAN builds, isolated VMs):
  * ~9.29 bytes/GFN and ~75 MiB/s of sustained growth per VM; linear
    scaling with parallel VMs (4 VMs: 3.56x).
  * global OOM killing unrelated third-party processes while the
    attacker's own memcg stays uncharged.
  * when all surviving processes are OOM-disabled, select_bad_process()
    finds no candidate and the kernel panics ("System is deadlocked on
    memory", mm/oom_kill.c).  Reproduced twice.
  * one ioctl holds kvm->slots_lock for the whole reservation loop, so a
    large range blocks KVM_GET_DIRTY_LOG and memslot updates of that VM
    for the duration (measured GET_DIRTY_LOG latency 1us -> 7.7ms with a
    single concurrent call); KVM_RUN is unaffected.
  * replicated through a real container runtime (podman/crun) with
    --memory 512m: the container grew host slab by ~450 MiB while its
    memory.current stayed at ~488 KiB.

Reproducer status
-----------------

A reproducer is available on request (KVM_CREATE_VM + the ioctl in a
loop, plus slab/ accounting measurement), but following security-bugs.rst i=
t is
not attached to this report.

Test environment
----------------

All dynamic results were collected in isolated inspection VMs on a
single AMD host with nested virtualization enabled
(kvm_amd nested=3D1): QEMU -cpu host, Debian 13 guests, guest kernels
built from the audited tree (v6.18.48) and from v7.2-rc5 with
CONFIG_KVM_SW_PROTECTED_VM=3Dy / CONFIG_KVM_AMD=3Dy / CONFIG_EXPERT=3Dy and
KASAN (with CONFIG_KASAN_VMALLOC=3Dy where noted); the PoC runs as root
inside the guest, host networking restricted (user-mode net,
restrict=3Don).  Nothing in the host kernels themselves was modified or
attacked.  The container replication used podman 5.4.2/crun inside the
guest with the host kernel having the gate enabled (a stock host kernel
without KVM_SW_PROTECTED_VM rejects KVM_CREATE_VM and the surface is
absent, as expected).

Proposed fix
------------

Attached as 0001-v3.patch (checkpatch clean, build warning-free on
v7.2-rc5, runtime-verified on v7.2-rc5): it bounds the total number of
materialized attribute entries per VM to KVM_MEM_ATTR_MAX_GFNS (2^25
GFNs =3D 128 GiB of GPA, ~300 MiB of xa_nodes), enforced under
kvm->slots_lock after the idempotency early-out.  A per-VM counter is
resynchronized from the xarray only when an ioctl mutates the array
(ENOMEM partials, successful sets and clears), so idempotent re-sets
and rejected requests stay O(1) =E2=80=94 runtime-verified: a 4 KiB idempot=
ent
re-set on an exhausted VM returns in ~4us; a fresh range on an
exhausted VM is rejected with -ENOSPC in ~17us; the bound cuts growth
at 2^25 GFNs.

Patch 2/2 restores the intended accounting with a one-liner; it
attributes the memory but does not bound it (see the analysis below):

-       xa_init(&kvm->mem_attr_array);
+       xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);

Design notes for reviewers: the budget value (2^25 GFNs) is a trade-off
=E2=80=94 it is well above any current consumer's usage but small next to t=
he
GPA space TDX/SNP guests can have; a tunable or a symmetric decrement on
clear are alternatives if maintainers prefer.  The -ENOSPC errno
distinguishes the bound from the malformed-input -EINVAL paths.

Why a constant and not a derived bound?

We considered bounding materialization by what the VM has actually
declared instead of a constant, and rejected it because the declaration
itself is not proportional.  Two candidate signals:

- Memslot coverage ("reject ranges not covered by any memslot"):
  semantically attractive =E2=80=94 attributes on unbacked GFNs are inert s=
tate
  with no consumer (kvm_handle_gfn_range only walks real memslots), and
  the only in-tree consumer (tools/testing/selftests/kvm, private_mem_
  conversions_test.c) sets attributes strictly inside its gmem memslot.
  But it is not a bound: a memslot requires only a MAP_NORESERVE userspace
  VMA (no committed pages); its kernel cost is the lpage_info metadata
  (4 bytes/entry, __vcalloc proportional to npages: ~16 MiB for a
  maximum 8 TiB memslot) while the same memslot's GPA span materializes
  ~19.9 GiB of xa_nodes =E2=80=94 a ~1200:1 amplification of declared metad=
ata.
  Three or four maximum-size NORESERVE memslots suffice to exhaust a
  64 GiB host.  As a semantic follow-up that eliminates the zero-setup
  variant of the attack it is worth considering on top of the bound.

- Sum of memslot pages as a dynamic budget: same flaw =E2=80=94 the attacke=
r
  raises his own budget by declaring free memslots; without a constant
  the ceiling becomes the physical address space.

Per-VM accounting to the caller's memcg (patch 2/2) attributes the
memory but bounds only cgroup-limited tenants; with the common
/dev/kvm 0666 default and unlimited cgroups it does not bound the host.
Hence the layering we propose: accounting (2/2) + hard per-VM bound
(1/2), with memslot-coverage rejection as an optional semantic layer
the maintainers may prefer on top.

Mitigations
-----------

- Restrict /dev/kvm (mode 0660 root:kvm) where the default 0666 is in
  place.
- Monitor SReclaimable and /sys/kernel/slab/radix_tree_node/objects, not
  SUnreclaim: the growth is reclaimable-accounted and never reclaimed.
- Per-tenant memcg limits do NOT mitigate the common path today (see
  above), which is why the counter bound is the effective fix.

Notes
-----

- Not verified: the TDX/SNP hardware paths end-to-end (no hardware);
  the software-protected path was verified end-to-end on both versions.

--
2.47.0


