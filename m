Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B548640D
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164810; cv=none; b=f1V7FSfNhcYWgfpuspwBxnU7RiLuY4NLBTnnKoHWRUuWppcHLOgBtdtgfPo8kaix5ME9lBD83VB5OFF9V5nAYJQ3I9/S6f4KbDqcpLK0M+G9EDMZETp/Cy2b2Z6pngsMa5S8ijaCc9Qo8Y8q2jNC62BoNUIzodQo5OdglBoH8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164810; c=relaxed/simple;
	bh=K75U+erw3caw2MLYePOC8RsaWWWA3HZHp7S4SGtY7Po=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSI9r7W+5l4NItEMlLRbKKeT3LoeqeAsaf13UifwqRhlY1GZ35wbuAgaTX/i9Z+MWCpBlPZ54JmUskIEDiEL0t9epjBBDrbljGniZ0P4Wq2pQmaeGXeWmaGKsGAl2V4Wd4YjXykAQ+mSJkAPso16h3VQl6Blm3FHxl0u7ZefnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nT4e0kfy; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nT4e0kfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789164797; x=1789423997;
	bh=kE/jyc1nB+q3iFrlEpeJVfOt0X3SoCS4sQ5fw2oTkas=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nT4e0kfy5cqi7QY+k+wfmuJNaK+L1CVOR9cBpPAGAwH8lPvAQA5MRRXICxJaBbsXy
	 47pi6EB/7EFUCtNESBGFYvvS7N82uEI1noGIDgF8OeOO9m+2H/p02/NS0ECPp8s8dt
	 PyiUbHdFqqMICAZX/pRtGCN9kwiaOjEjCaKuj9Dt2JkYvhRAyNcWWV2rRKCMmt1BzJ
	 gjy+0GyuGrfLowSi6RQYi8xlQJa29HHwOaZODDaK4J8vxN4YwJSTw/AT57sipzkig3
	 SANE09L/vzF1h1pn8hI40pwOLJFJ6EmXN8PUJPjs+4KD3DsWUKhhlQryiYtdv2gOVA
	 87uMaOedZH2QA==
Date: Fri, 11 Sep 2026 22:13:11 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v3 0/2] KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911221302.53013-1-davimaba.v@proton.me>
In-Reply-To: <20260911203238.30088-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me> <20260911203238.30088-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 2dcde3fa1b6523e86543800ea304e2449b67bd87
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The report and series are intentionally public (AI-assisted finding, cf.
Documentation/process/security-bugs.rst).

Changes in v3 (from review of v2):

- The clear path now iterates with xa_for_each_range(), which takes
  and releases the RCU lock on every step.  v2 held a single RCU
  read-side critical section across the whole loop, which made
  cond_resched() illegal on non-PREEMPT_RCU configurations and
  wrongly spanned the post-set MMU invalidation handler.  The
  per-step re-find also makes erasing the current entry safe with
  plain xa_erase(); v2 mixed xa_erase() into a lockless xas_for_each()
  iteration whose state could point at nodes the erase unlinked.
- The set path charges the budget exactly, using xa_cmpxchg() (i.e.
  xa_reserve() with the old entry returned) so only GFNs that were
  actually absent are counted.  v2 charged the full range of every
  request, so overlapping sets overcounted permanently and a caller
  could exhaust its own budget with an empty array.

Changes in v2 (from review of v1):

- Clear path reworked from reserve-then-store-NULL to erase-only,
  closing a bound bypass (a clear of a partially populated range went
  through xa_reserve() for the whole range with no bound check).
- Counter maintained incrementally instead of a per-mutating-ioctl
  rescan of the whole array.


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

Patch 1/2 bounds the number of attribute entries materialized per VM
to KVM_MEM_ATTR_MAX_GFNS (2^25 GFNs =3D 128 GiB of GPA, ~300 MiB of
xa_nodes), enforced under kvm->slots_lock after the idempotency
early-out.  Clear requests are reworked to erase-only iteration over
the present entries in the range: erasing cannot allocate, so a clear
cannot fail partway and cannot materialize new entries (this closes a
bound bypass present in the first revision, where a clear of a
partially populated range still went through xa_reserve() unchecked).
The per-VM counter is maintained incrementally: sets charge the full
range, clears subtract the exact number of entries erased, and a full
rescan runs only on the ENOMEM path.  Runtime-verified on v7.2-rc5
(KASAN build, isolated VM): growth stops with a clean -ENOSPC at 2^25
GFNs; eight consecutive clears of 2^52-GFN ranges containing a
populated GFN leave Slab unchanged; 50 alternating 4 KiB set/clear
conversions at a near-full array take 0.01 ms each; clearing a range
returns budget exactly.

Patch 2/2 restores the intended memcg accounting with a one-liner:

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


