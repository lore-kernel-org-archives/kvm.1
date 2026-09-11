Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852975A5157
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158783; cv=none; b=iJ0O9QhN/WXjb9VXU+OmOvgwtD5riKX3njN8G/2HD4EhFgVVEXp5ddpDAl5FlcmfPf3gpmnQbMu42JyxwTyL6h4snPDwlQ34EkatgtOAMkO6K2A2bJfZOVo0RhqwZsGigZHystuyMxvFjpzH6lgNGGBs+lElj1ets0gAw6cdDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158783; c=relaxed/simple;
	bh=TPYsUdgRymaB/Jt1f1Dboojd4rRWJZ4bSVGb2nI9CZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlNAhX9D72vE+S0ABPBCxMEYIkOe+fK2v2LhB2B+uce/x2AOdQypEIa04Q7aHLTedB6dvIEIL2eCMR1UxmxQ4MKDVPg2mlYnj11CwPbR5P/iPZVSWWhRqXIAbZIPvDnu+HxjltfqyEE44GwnLBrutSBJuEBhGMWTwtdORVfq6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T0iYv8Wn; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T0iYv8Wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789158769; x=1789417969;
	bh=2UNrRvIefflL8160ndAwQCyY+CDVeSgpUPFUddt7R/I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T0iYv8WnoWmlPd2GQm6HQyylr/jallsl4CbybgDBJ//cOE/jPmg5/KAUjZnSUh0xe
	 lUl6awbcc8S2vGOqgLTVDG2pwih9i+HmofQC6HKtjZtvLGAANgZD2OjDEGjb5U/Dln
	 m5gPnguhp8Ilk7qJdzq5wsPz26iTjYueejQak78Tz99OJZyD3dArGy0EbKbCzIekY+
	 v/yPGnPGDb1yuxHoWvReFu+uW5ohbCUGie7jMc2GfZlItPySBtyyO/HSRiBD5hG1K/
	 a2NAhOxqtZZP2xey1VlpK5JSWg0vFO/4M17+VIPOaIo4aipBDbT94eCmPiG7dW0pfG
	 /qVcTn0fw6qbQ==
Date: Fri, 11 Sep 2026 20:32:45 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v2 0/2] KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911203238.30088-1-davimaba.v@proton.me>
In-Reply-To: <20260911184819.101123-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 1ce0421cc612824da54f48a848361712086e0822
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fair bot, you win.  The clear-path bound bypass was real, and v2 of
this series exists because the automated review caught it before a
human did.

Changes in v2 (thanks to the sashiko review of v1):

- Reworked the clear path to erase-only iteration over present
  entries.  v1 could bypass the bound: a clear of a partially
  populated range went through xa_reserve() for every GFN in the
  range with no bound check, so alternating set/clear of huge
  ranges materialized kernel memory without limit.  Erasing cannot
  allocate, so clears are now failure-free by construction and
  bounded by the population they actually remove.  Runtime-verified:
  eight consecutive clears of a 2^52-GFN range containing a
  populated GFN leave Slab unchanged (v1 grew it to ENOMEM).
- The per-VM counter is now maintained incrementally (sets charge the
  full range, conservatively; clears subtract the exact number of
  entries erased) and a full rescan runs only on the ENOMEM path.
  This removes the O(array population) cost per mutating ioctl from
  v1, which was significant for legitimate confidential-VM workloads
  converting small ranges on a large array.  Runtime-verified: 50
  alternating 4 KiB set/clear conversions at a near-full array take
  0.01 ms each.
- Added guard(rcu)() to the rescan helper for consistency with
  kvm_range_has_memory_attributes() and to satisfy lockdep.
- No change to patch 2.

On the other review points: the 128 GiB budget value remains a
deliberate trade-off, discussed under "Why a constant and not a
derived bound" below; and the other KVM xarrays do not share this
exposure because their indices are bounded by construction
(vcpu_array by the KVM_MAX_VCPUS check in KVM_CREATE_VCPU, gmem
bindings by KVM_MEM_SLOTS_NUM), unlike mem_attr_array whose index
range is the user-chosen GFN range itself.


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
2.55.0


