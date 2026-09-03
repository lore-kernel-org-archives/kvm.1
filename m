Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543C4EA374
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470190; cv=none; b=cZE8+dsUDNGNuDPUxNmV8XJTwymxIVoUccWB0z4X4Y+0mYgT4tMvu2WgofHp4AfTnnh/BwYo9AW7J3f6AonZ6tk45d9mbWtOxsHosBCDzP6IMeCbR+/4BEgiq2OPJPN15yi5G/FkcAuzIUBSEC8Zmi/OFDGMjyfFJIe4qn4Cu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470190; c=relaxed/simple;
	bh=PFIs+vMm4hweJIn0gcgg2F80KEb/eFKmBkIrPpHTD90=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TxtPZuqRoFtqy19fkEq5KqtspgGUu3D591ZlJBlINRBMyCYwE4vxp+ppOBftWmB1svQPjguzpJem6mzmrn6WMNf/hrYGcdA8zbPDEVX2cLseOXXFUpEwQUsX3OAj/OSRel7rltm7YL0nxJ4jUOhoIqDjBW3knWguvBHVVA8lU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+gs3tLD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+gs3tLD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843e9c5960so337028f8f.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788470183; x=1789074983; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jxWmd683wXRp2hoXvhyYXLFlHrKBqMmFrYRvT36j1tI=;
        b=J+gs3tLDJr7wO+07vJ+/Rb2Ztf59K80/20rsHw/xjSfdxuolRvQWmJcZiaV1kAnHfp
         j9hQflJGvJAd35oCVPtQXvnPpQ9moBBGSfKyHgmin3k9rHuudJ6RFheiXoTUQ7QpFSLA
         aR6Cvxi44KFIFqKUW2qVYJY++oA9CiA1IhmiDsgnlrQrHoeJgNJ/rq3oSDomyXNvxX40
         /tXWop0r5vpGF9YlMLwOCNvesinGCWNq9iYiwODTgHhSMA4BSxxwG5o7WRlc4eDoVlNh
         /U4DlDbNVsZxJ+UC2glKuLm+u7zrWbR40vZZx3+/xEH1JjEzr9lA+ocdCK1EcZKjE2Tf
         YzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788470183; x=1789074983;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxWmd683wXRp2hoXvhyYXLFlHrKBqMmFrYRvT36j1tI=;
        b=NT6UV0eITpSgnKnX1a89/+cNF/e6zNZHh6GzTpO2to8uXN38NhRj5Qg6cb1SiXG2nx
         Gj1U/zfaOfPM6bt8P0ZFp9XUwaLI23vNY/eg/91hvSoWfV2/u8FqtosBsx14eqmLmL7N
         cSKbxbXsFl0gVE8J7wezA3sC2H0GYH/AaN0Bq1Eh+EtLP1lGGp8Z12hwWFXf1X6Z3mN0
         D+ECT2gb/vJmavPmfusZY2qBk8oFpbnnGkdPsRqdTOEubOgyMRq230kbYyO9OPu8Kww3
         tvrVgFaeNE8onbLN6rtMigrWBW9c5ce2JR4J9opsBqEXFtFDlRGIwCInlFWwxrYddFrd
         4sxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuagqQGl8hpDe5jOplXCIOoLC6c9YaqJKZdxE1vs7FxRiW/LQEgieRIOCBp2Wi9yQxJ40=@vger.kernel.org
X-Gm-Message-State: AFuF++mAx/0ZMlzK8LmcuwkDPwJMtMg2dliwxVoMbubSrdA0q4iU7God
	NiRNIkDTleloD5Jr5cruJjGYGGxezWYK1IS+JTsbD6rkaVC8iIVgZe9PGap8Cy6Z
X-Gm-Gg: AYBFou3SlOLff5KSFSbIEoqT5jWh6YuB17dskr1wpFzalHQP0lwe9rFbESdEdsKq7J1
	lnNfeV4ST24mBDbVyt/tPfjCUYMnducOJQlEgKRqfrTmZo7UaZezTJMV17PM7+q1GRNXV+4YsXV
	se/IF9zNItO0MjchvUpsFbmMn8j//nChZjcjJPWD1+c8+NUKco1nelm4m7kBB0t3Cfg/3Zh9jsq
	5ZZJ5P1Jbdve8UVu6gveO2GREMdZZ1+Q4JcpJ1TLcze03LV4Q4nrvW7gLT5KVbZi9daiWlogi/k
	HZ9hZ7Q58+M3Wm+bw9BcqsKZXDFwug23OJwBvd50lIs+MBiqzK60kp/q1MBJDRjZ/rrW098Dlaq
	KnE32vMyNrVMuhBD4TrkmqBPn0lnHS8gJxbz7CyRofRNFPoLm/aIekdbPaCNLaWj1we3AXF4qX0
	PBZduR/oY1EghBzXSsd6cl0I/62+eYdxD0CiAFP6wDI1o/bvFi/WwqTGzCuiJGTwoiJN8BCZ4x+
	TlSNOApU9Vb
X-Received: by 2002:a05:6000:658:b0:482:e1b0:8a1a with SMTP id ffacd0b85a97d-485872addd6mr2956885f8f.15.1788470182134;
        Thu, 03 Sep 2026 14:16:22 -0700 (PDT)
Received: from smtpclient.apple ([85.195.251.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm1158381f8f.21.2026.09.03.14.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 14:16:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
From: Joris de Vries <j.s.de.vries@gmail.com>
In-Reply-To: <CAO9r8zO6CiKo57aqZpbOKwfoS-xGvuAg72AN8-M7MO6u6P8B7w@mail.gmail.com>
Date: Thu, 3 Sep 2026 23:16:07 +0200
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Alexander Lougovski <alougovsk@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6439A7D-77EA-475D-BEBC-6BB6EDA10A0C@gmail.com>
References: <20260723094419.630204-1-pbonzini@redhat.com>
 <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
 <CABgObfYhsq-h4t=onAhCrbUX3p0beFM9jvj3bCKY8r2bRs=y-A@mail.gmail.com>
 <CAO9r8zO6CiKo57aqZpbOKwfoS-xGvuAg72AN8-M7MO6u6P8B7w@mail.gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 25 Jul 2026, at 23:33, Yosry Ahmed <yosry@kernel.org> wrote:
>=20
> On Sat, Jul 25, 2026 at 6:32=E2=80=AFAM Paolo Bonzini =
<pbonzini@redhat.com> wrote:
>>=20
>> Il sab 25 lug 2026, 01:44 Yosry Ahmed <yosry@kernel.org> ha scritto:
>>>> +       /*
>>>> +        * INVLPGA has had errata on Genoa and Turin, and even on =
older
>>>> +        * generations there were reports of Windows BSODs if =
INVLPGA
>>>> +        * was used for Hyper-V tlbflush.  Use it only for shadow =
paging
>>>> +        * where it seems to be okay.
>>>=20
>>> Is this an actual errata documented by AMD, or is this just an
>>> empirical observation?
>>=20
>> There is the VMware knowledge base in the commit message that =
requires
>> new microcode:
>>=20
>>>> For Turin, the microcode version was 0x0b002162, which (assuming
>>>> this is the same issue) should not be affected by the problem =
listed in
>>>> =
https://knowledge.broadcom.com/external/article/419026/bsod-on-virtual-mac=
hines-running-on-amd.html;
>>>> on the other hand that problem should not apply to earlier =
processors.
>>>> AMD has not provided any information or analysis yet, and when we =
asked
>>>> we didn't know yet that it reproduced on Milan as well.
>>=20
>> and I interpreted that as an erratum. But we reproduced it also on
>> Milan and with supposedly fixed microcode.
>>=20
>>> I ask because the APM says:
>>> ---
>>> The input address is always interpreted as a guest virtual address, =
so
>>> INVLPGA is typically meaningful only when used with shadow page
>>> tables; it does not provide a means to invalidate a nested =
translation
>>> by guest physical address
>>> ---
>>>=20
>>> While this is terrible wording, it seems like KVM should *not* be
>>> using INVLPGA when TDP is enabled
>>=20
>> While it is certainly an odd case, here the guest has requested to do
>> an invalidation by GVA on its behalf, so INVLPGA should have worked.
>>=20
>> "Not typically meaningful" is a friendly hint to read the manual
>> twice, but reality seems to be more like "doesn't actually flush the
>> right entries" when NPT is in use. Especially since Intel has INVVPID
>> for the exact same operation and it works just fine.
>=20
> Yeah I agree that it makes sense that INVLPGA should work if we are
> just flushing a GVA on behalf of the guest (e.g. guest making a
> hypercall instead of INVLPG).
>=20
> I think we probably need clarification from AMD about what the
> intention is. Is INVLPGA expected to be broken when NPT is enabled (in
> which case the wording in the APM needs fixing), or is INVLPGA
> expected to work but is actually broken. IIUC the erratum you referred
> to should already be fixed with the new microcode, so maybe there's
> another problem with INVLPGA?
>=20
> The third possibility is that INVLPGA works as intended but the
> Hyper-V code in KVM is broken in some other way. I am not sure if we
> can ask, or if people at Microsoft can answer, but it would definitely
> help to know how Hyper-V handles these cases. Does it actually use
> INVLPGA to flush GVAs on behalf of the guest with NPT enabeld? If yes,
> there's a good chance it's KVM that's broken here?

Hello all

I have encountered a bug that to my unknowing eye looks similar and/or =
related to this discussion. A session with Claude to tweak a local LLM =
configuration on a kvm guest with GPU passthrough on an AMD host turned =
into a multi-day debugging session to chase seemingly random guest =
crashes that entirely subsided when setting npt=3D0:

During debugging this, I searched the kvm list for npt & amd and came =
across this thread. If my message is correctly placed here, please let =
me know.=20

Please allow me to forward Claude=E2=80=99s message and analysis. I have =
tried as much as I can to have it ground its missive in factual =
findings, but do realize my knowledge is not sufficient to fully contain =
mistakes and would be grateful for any assistance.

Joris


Summary
-------
With AMD nested paging enabled, a KVM guest reliably kernel-panics with =
a
reserved-bit page fault whenever it tears down a 2 MiB-aligned mapping
whose lower page-table page is then freed and reused for other data.

  - THP collapse/split does this fast: a small stressor panics a
    1-vCPU guest in 2-3 minutes, deterministically.
  - Ordinary glibc thread-stack recycling does it slowly: an idle
    Ubuntu guest panics in ~35 minutes.

The NPT in host memory is structurally correct and is never modified by
KVM in the minutes before a panic; the guest page tables are correct;
the host is unaffected and logs nothing. The stale value the hardware
page-walker uses exists in no memory - it is inside the CPU's own
page-walk cache. Every invalidation KVM can issue - guest INVLPG/INVPCID
(native or intercepted and re-issued), VMCB TLB_CONTROL at its strongest
value on every VMRUN, a fresh ASID after each guest invalidation or on
every VMRUN - fails to evict it. Only npt=3D0 avoids it.

This is the same class of bug as the kvm-list thread above, reached
locally (single vCPU, no hypercalls, native invalidation) rather than
via the Hyper-V TLB-flush hypercall path.


Environment
-----------
Host CPU     AMD Ryzen 9 5900X "Vermeer", family 19h model 21h stepping =
0,
             microcode 0x0a201030, Gigabyte BIOS F41c (2026-08-18)
Host memory  4 x 16 GiB DDR4-2400 JEDEC (no XMP), no ECC, no EDAC
Host kernel  Ubuntu 7.0.0-30-generic; also reproduced on clean mainline
             v7.3-rc1
Hypervisor   QEMU/libvirt, q35, <vmcoreinfo/> + pvpanic, no device
             assignment (GPU passthrough removable, not required)
Guest        stock Ubuntu 26.04, kernel 6.12 or 7.0 (does not matter),
             1 vCPU, 6 GiB, NO hv-* enlightenments
Trigger      kvm_amd npt=3D1 (module default). npt=3D0 -> stable.


Symptom
-------
A guest process takes a page fault at a virtual address that is a 2 MiB
boundary minus 0x48 or 0x50 (a glibc thread-stack TCB slot), the fault
code carries the reserved-bit flag, and the kernel panics on the death
of init:
  systemd[1]: segfault at 741bf3ffffb8 ip 00007fd69b0a0675
              sp 00007ffc6813ea88 error 44 in libc.so.6[a0675,...]
  systemd[1]: segfault at 741bf3ffffb0 ip 0000583d040c17a8
              sp 00007ffc6813dda0 error 46 in systemd[157a8,...]
  Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x0000008b

error 44 is 0x2c - user, read, reserved-bit set; writes fault with 0x2e.
A reserved-bit #PF means the hardware page-walker traversed a paging
structure marked "present" and found reserved bits in it. In a full
cascade a dozen unrelated processes fault at the identical address, all
attributed to the same logical CPU. The host stays up and silent
throughout: no MCE, no EDAC, no IOMMU fault, no KVM warning.

The determining factor is a 2 MiB-aligned region whose lower page-table
page is freed and reused. One page-table page maps exactly one
2 MiB-aligned region and is referenced by exactly one PMD entry; when
the whole region is torn down, that page-table page is freed and the
PMD entry cleared. A THP split/collapse churns this fast; glibc's
thread-stack cache releasing a thread's 2 MiB-aligned stack and handing
the address to a new thread churns it slowly but continuously on any
thread-heavy guest.


Relationship to the INVLPGA / hv-tlbflush thread
-----------------------------------------------
Red Hat is chasing the same class of bug from the Hyper-V direction:
Windows guests with hv-tlbflush=3Don BSOD on AMD only (Turin 15 crashes =
/
3300 VM-hours; Milan 2 / 500; Intel Sapphire Rapids 0 / 8000; Turin
with a full ASID flush 0 / ~7000). There the guest offloads its
cross-vCPU TLB shootdowns to KVM via hypercall, KVM issues INVLPGA on
the target vCPU (kvm_hv_vcpu_flush_tlb -> svm_flush_tlb_gva), and that
fails to flush the nested part. Broadcom KB 419026 attributes a related
Turin case to microcode and lists a fix (-> 0x0B002151); Red Hat still
reproduces on Milan past that.

This report is the same failure reached without any of that: a stock
Linux guest, one vCPU, no enlightenments, no hypercalls, issuing its
own native INVLPG/INVPCID (and the CR3 reload the kernel uses for a
>2 MiB range flush), none of which NPT intercepts. The full-ASID-flush
fix works for the hypercall path because the hypercall is a VMEXIT at
exactly the invalidation point; the native local path has no exit
there, and forcing a full flush - or a fresh ASID - on every VMRUN does
not help (modules A, F above). So if it is the same silicon defect, the
KVM fix is correct but covers only guests that offload TLB shootdowns
via hypercall; native invalidation - every Linux guest, and Windows
without hv-tlbflush - is not covered and cannot be, from the hypervisor.


Evidence it is the CPU, not KVM
------------------------------

1. KVM never touches the NPT before a panic.

A bpftrace script filtered to one guest's struct kvm, covering every
NPT-mutation and TLB-flush path, over a complete 53-minute run that
ended in a panic:

  present-leaf SPTE zaps / repoints (handle_changed_spte) .... 0
  kvm_flush_remote_tlbs / _range ............................ 0
  kvm_unmap_gfn_range  (mmu-notifier) ....................... 0
  svm_flush_tlb_asid / _current / _all ..................... 0

The guest's RAM is fully NPT-mapped after boot and nothing perturbs it -
not KSM, not page migration, not an mmu-notifier. There is no KVM flush
to race with or to get wrong. svm_flush_tlb_gva() is likewise never
called on this path (0 hits), so commit 26505e1b5b has nothing to act
on here.

2. The NPT and the guest page tables in memory are correct.

A drgn walk of the frozen guest's nested page tables straight out of
host-physical memory:

  huge (2 MiB / 1 GiB) NPT leaves ............... 0
  PD entries -> 4 KiB page tables .............. 3082
  qemu /proc/<pid>/smaps AnonHugePages ......... 0 kB (host THP =3D =
never)

The NPT is 4 KiB-only, so the stale entry is not a huge NPT mapping -
it is an upper-level step of the 2-D walk (a guest PMD fused with its
nested translation). For the faulting task's CR3 the NPT resolves
cleanly through all four levels, no reserved bits, to a host page that
is byte-identical - full-page MD5, not spot checks - to the same page
in the guest core dump. The faulting VA's PML4 slot reads 0 in both:
the guest's own page tables say the address is unmapped and call for a
plain not-present #PF (error 4/6). The CPU raised a reserved-bit one.
The value the walker used is in no memory anywhere. Repeated on four
separate cores including a 6.12-kernel guest.

3. page_poison rules out the DRAM / use-after-free path.

The guest runs page_poison=3D1 init_on_free=3D1 slub_debug=3DFZ. Freed =
pages
are overwritten; a use-after-free would surface as poison, not as a
coherent stale translation. The page tables in the cores are
self-consistent. The discrepancy is translation state, not bytes.


What does not fix it
-------------------
All rows still panic with the identical signature unless noted.
Guest uptime at panic; npt=3D1; hugestress2 unless the row predates it.

  npt=3D0 (software shadow paging) ..................... clean (only =
fix)
       single-VM 25 min clean rejects "same as npt=3D1" at p<0.01;
       bare-metal hugestress2 45 min clean
  commit 26505e1b5b backported to the 7.0 host ....... panic ~30 min
  mainline v7.3-rc1 host ............................. panic 31 min
  BIOS F31->F41c, ucode 0x0a20102e->0x0a201030 ....... panic 12 min
  HWCR[TlbCacheDis]=3D1 (AMD flush-filter disabled) .... panic ~24 min =
x2
  module A: TLB_CONTROL_FLUSH_ALL_ASID every VMRUN ... panic 14 min
  module B: guest INVLPG intercepted + hv-mediated
       flush (~112k exits/s) ......................... panic 33 min
  module Q: force-intercept guest INVPCID + INVLPG
       under NPT, fresh ASID after each ............. panic 2 min
  module F: new_asid() unconditionally in
       pre_svm_run (fresh ASID every VMRUN) ......... panic 29 min
  KSM off / 1 vCPU / tdp_mmu=3D0 / pku,ospke masked ... panic
  GPU passthrough removed / CPU pinning removed ..... panic 30 min
  transparent_hugepage=3Dnever in the guest .......... panic 45 min
       (removes the fast THP path; the slow glibc-thread-stack path
        still panics - the fault landed on a systemd thread-stack
        address, not the workload's regions)

The corrupting collapse -> teardown -> re-access sequence completes
inside a single VMRUN, in guest code the hypervisor never traps, so no
between-VMRUN action - which is all KVM has - can land in the window.
The only untried lever is an nCR3 (NPT root) reload per guest
invalidation, which is a full MMU reset per INVPCID and not viable.


AMD erratum search
------------------
Checked AMD publication 56683 (Revision Guide for Family 19h Models
00h-0Fh, i.e. Milan - the same Zen 3 core; AMD publishes no client
revision guide, so Vermeer / model 21h has none) and the RemembERR
errata database. No published erratum matches. The closest siblings,
all marked "no fix planned" and affecting both Zen 3 steppings:

  1193  Page Remapping Without Invalidation May Cause Missed Detection
        of Self-Modifying Code. If a PTE with the Accessed bit set has
        its physical page base changed without first making the
        translation a permission violation and then invalidating it,
        the CPU may execute stale instructions. Same failure class - a
        stale translation surviving a change of a page's backing - but
        scoped to instruction fetch. This report is the data-side /
        nested-walk analog. Note the workaround text: plain "clear the
        PTE + INVLPG" is stated to be insufficient.

  1277  IOMMU May Mishandle Fault on Skipped Page Directory Entry
        Levels. When guest and nested page tables are enabled, a nested
        walk that skips a PDE level is mishandled. Confirms nested-walk
        defects exist in this silicon.

  1455  PCID-Based INVLPGB May Fail to Flush Global Translations under
        specific conditions. Confirms "an invalidation instruction does
        not flush" precedent on Zen 3.


Workarounds
-----------
  kvm_amd npt=3D0
        The only reliable option. KVM's shadow MMU does the guest page
        walk in software and never routes the hardware 2-D walker
        through NPT to a guest page-table page. Cost is a higher
        VM-exit rate on guest page-table edits; near zero for steady
        GPU / compute workloads.

  guest transparent_hugepage=3Dnever
        Removes the fast (THP) path only. A guest with no huge-page
        activity at all still panicked at 45 minutes on an ambient
        systemd thread-stack address. Rate reduction, not a fix.

  AMD microcode
        The actual fix for the silicon. A related Turin case has one
        (Broadcom KB 419026); no Zen 3 client microcode fix is known.


Diagnostic module diffs
-----------------------
Built against linux-source-7.0.0 (=3D=3D 7.0.0-30.30), vermagic-matched,
disassembly-verified, loaded as a drop-in kvm-amd.ko.

--- 8< --- module A: flush all ASIDs on every VMRUN ---
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ svm_vcpu_enter_exit()
 	amd_clear_divider();

+	/* force a full flush of ALL ASIDs on every VMRUN, =
unconditionally */
+	svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ALL_ASID;
+
 	if (sev_es_guest(vcpu->kvm))
 		__svm_sev_es_vcpu_run(svm, ...);
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
--- 8< ---

--- 8< --- module B: route guest INVLPG through the hypervisor ---
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ init_vmcb(), if (npt_enabled)
 		control->nested_ctl |=3D SVM_NESTED_CTL_NP_ENABLE;
-		svm_clr_intercept(svm, INTERCEPT_INVLPG);
+		/* keep INVLPG intercepted under NPT */
 		clr_exception_intercept(svm, PF_VECTOR);

@@ svm_flush_tlb_gva()
 	struct vcpu_svm *svm =3D to_svm(vcpu);

+	/* no INVLPGA under NPT (unreliable, cf. 26505e1b5b); =
hypervisor-
+	 * mediated full guest-ASID flush instead */
+	if (npt_enabled) {
+		svm_flush_tlb_asid(vcpu);
+		return;
+	}
+
 	invlpga(gva, svm->vmcb->control.asid);
--- 8< ---

--- 8< --- module F: brand-new ASID on every VMRUN ---
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ pre_svm_run()
 	if (sev_guest(vcpu->kvm))
 		return pre_sev_run(svm, vcpu->cpu);

-	/* FIXME: handle wraparound of asid_generation */
-	if (svm->current_vmcb->asid_generation !=3D sd->asid_generation)
-		new_asid(svm, sd);
+	/* assign a brand-new ASID on EVERY VMRUN.  Unlike module A =
(which
+	 * re-flushes the SAME asid) this changes the ASID *tag* so the =
CPU
+	 * cannot consult a stale NPT-derived walk-cache entry left =
under
+	 * the old tag. */
+	new_asid(svm, sd);

 	return 0;
--- 8< ---

--- 8< --- module Q: intercept guest INVPCID+INVLPG, fresh ASID each ---
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ svm_recalc_instruction_intercepts()
 	if (kvm_cpu_cap_has(X86_FEATURE_INVPCID)) {
-		if (!npt_enabled ||
-		    !guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_INVPCID))
-			svm_set_intercept(svm, INTERCEPT_INVPCID);
-		else
-			svm_clr_intercept(svm, INTERCEPT_INVPCID);
+		/* always intercept INVPCID, even under NPT */
+		svm_set_intercept(svm, INTERCEPT_INVPCID);
 	}

@@ init_vmcb(), if (npt_enabled)
-		svm_clr_intercept(svm, INTERCEPT_INVLPG);
+		/* keep INVLPG intercepted under NPT */
 		clr_exception_intercept(svm, PF_VECTOR);

@@ invlpg_interception()
 	kvm_mmu_invlpg(vcpu, to_svm(vcpu)->vmcb->control.exit_info_1);
+	to_svm(vcpu)->current_vmcb->asid_generation--;   /* -> =
new_asid() */
 	return kvm_skip_emulated_instruction(vcpu);

@@ invpcid_interception()
-	return kvm_handle_invpcid(vcpu, type, gva);
+	{
+		int _r =3D kvm_handle_invpcid(vcpu, type, gva);
+		svm->current_vmcb->asid_generation--;   /* -> new_asid() =
*/
+		return _r;
+	}
--- 8< ---


Reproducer
----------
Build: gcc -O2 -static -pthread -o hugestress2 hugestress2.c
Run in the guest as root (needs /proc/self/pagemap and /dev/kmsg).
Panic in 2-3 min on a 1-vCPU npt=3D1 guest; clean under npt=3D0.

--- 8< --- hugestress2.c ---
/* hugestress2 - 2 MiB THP collapse/teardown churn with a canary.
 * On canary corruption: resolve the bad page's guest-physical address
 * via /proc/self/pagemap, dump context to /dev/kmsg + console, stop the
 * workers and FREEZE (keep the VM alive and the page mapped for
 * virsh dump).
 * build: gcc -O2 -static -pthread -o hugestress2 hugestress2.c
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <pthread.h>
#include <signal.h>

#ifndef MADV_COLLAPSE
#define MADV_COLLAPSE 25
#endif
#define HP   (2UL*1024*1024)
#define NREG 48
#define NTHR 3

static int kmsg =3D -1;
static volatile int freeze =3D 0;

static void say(const char *s){
    dprintf(1,"%s\n",s); dprintf(2,"%s\n",s);
    if(kmsg>=3D0){ char b[300]; int n=3Dsnprintf(b,sizeof =
b,"hugestress2: %s\n",s); if(write(kmsg,b,n)){} }
}
static uint64_t rnd(uint64_t *s){ =
*s=3D*s*6364136223846793005ULL+1442695040888963407ULL; return *s; }
static unsigned char canpat(size_t i){ return (unsigned =
char)((i*2654435761u)>>24); }

/* virtual addr -> guest physical addr via /proc/self/pagemap (needs =
root) */
static uint64_t v2p(void *va){
    static int pm =3D -2;
    if(pm=3D=3D-2) pm =3D open("/proc/self/pagemap", O_RDONLY);
    if(pm<0) return 0;
    uint64_t off =3D ((uint64_t)va/4096)*8, ent=3D0;
    if(pread(pm,&ent,8,off)!=3D8) return 0;
    if(!(ent & (1ULL<<63))) return 0;             /* not present */
    return ((ent & ((1ULL<<55)-1))*4096) | ((uint64_t)va & 4095);
}

static void *worker(void *arg){
    uint64_t s=3D(uint64_t)(long)arg*0x9e3779b97f4a7c15ULL ^ =
(uint64_t)time(0);
    unsigned char *reg[NREG]; memset(reg,0,sizeof reg);
    while(!freeze){
        int i=3Drnd(&s)%NREG;
        if(!reg[i]){
            unsigned char =
*m=3Dmmap(0,HP,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
            if(m=3D=3DMAP_FAILED) continue;
            madvise(m,HP,MADV_HUGEPAGE);
            for(size_t o=3D0;o<HP;o+=3D4096) m[o]=3D1;
            madvise(m,HP,MADV_COLLAPSE);
            m[HP-0x48]=3D0x5a; reg[i]=3Dm;
        } else {
            unsigned char *m=3Dreg[i];
            switch(rnd(&s)&7){
              case 0: mprotect(m,HP,PROT_READ); =
mprotect(m,HP,PROT_READ|PROT_WRITE); break;
              case 1: madvise(m+HP/2,HP/2,MADV_DONTNEED); break;
              case 2: mprotect(m+HP/2,0x1000,PROT_NONE); =
mprotect(m+HP/2,0x1000,PROT_READ|PROT_WRITE); break;
              case 3: { unsigned char *n=3Dmremap(m,HP,HP,MREMAP_MAYMOVE);=
 if(n!=3DMAP_FAILED){reg[i]=3Dn; n[HP-0x48]=3D0x5a;} break; }
              case 4: madvise(m,HP,MADV_DONTNEED); m[0]=3D1; =
m[HP-0x48]=3D0x5a; break;
              case 5: madvise(m,HP,MADV_COLLAPSE); break;
              case 6: { volatile unsigned char *p=3Dm+HP-0x48; unsigned =
char v=3D*p; *p=3Dv+1; break; }
              default: munmap(m,HP); reg[i]=3D0; break;
            }
        }
    }
    return 0;
}

int main(void){
    setvbuf(stdout,0,_IONBF,0);
    kmsg=3Dopen("/dev/kmsg",O_WRONLY|O_CLOEXEC);
    say("hugestress2 start");

    size_t CN=3D64*HP;                           /* 128 MiB canary */
    unsigned char =
*can=3Dmmap(0,CN,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
    if(can=3D=3DMAP_FAILED){ say("canary mmap failed"); return 1; }
    madvise(can,CN,MADV_HUGEPAGE);
    for(size_t i=3D0;i<CN;i++) can[i]=3Dcanpat(i);
    madvise(can,CN,MADV_COLLAPSE);
    { char b[160]; snprintf(b,sizeof b,"canary va=3D%p..%p pa[0]=3D%#lx =
pa[mid]=3D%#lx",
        (void*)can,(void*)(can+CN), v2p(can), v2p(can+CN/2)); say(b); }

    pthread_t t[NTHR];
    for(int i=3D0;i<NTHR;i++) =
pthread_create(&t[i],0,worker,(void*)(long)(i+1));

    unsigned long pass=3D0; time_t t0=3Dtime(0);
    for(;;){
        for(size_t i=3D0;i<CN;i+=3D53){
            unsigned char got=3Dcan[i], want=3Dcanpat(i);
            if(got!=3Dwant){
                freeze=3D1;                       /* stop workers, keep =
state */
                char b[256];
                void *va=3D&can[i]; uint64_t pa=3Dv2p(va);
                snprintf(b,sizeof b,"CANARY CORRUPT off=3D%zu va=3D%p =
pa=3D%#lx got=3D%02x want=3D%02x pass=3D%lu t=3D%lds",
                         i,va,pa,got,want,pass,(long)(time(0)-t0)); =
say(b);
                /* is it a stale-TLB flicker or stable memory =
corruption? */
                for(int k=3D0;k<8;k++){ snprintf(b,sizeof b,"  =
reread[%d]=3D%02x pa=3D%#lx",k,can[i],v2p(va)); say(b); usleep(200000); =
}
                /* hexdump 128 bytes around, aligned */
                size_t base=3Di & ~63UL; char line[160]; int p=3D0;
                p+=3Dsnprintf(line,sizeof line,"  dump =
%p:",(void*)&can[base]);
                for(size_t j=3D0;j<128 && base+j<CN;j++){ =
p+=3Dsnprintf(line+p,sizeof line-p," %02x",can[base+j]);
                    if((j&15)=3D=3D15){ say(line); =
p=3Dsnprintf(line,sizeof line,"  +%zu:",j+1); } }
                say("FROZEN - virsh dump now. (workers stopped, page =
still mapped)");
                for(;;) pause();
            }
        }
        if((++pass%5000)=3D=3D0){ char b[80]; snprintf(b,sizeof =
b,"canary ok pass=3D%lu t=3D%lds",pass,(long)(time(0)-t0)); say(b); }
    }
}
--- 8< ---

hugestress2 also runs clean for 45 minutes on the bare-metal host, and
Debian-minimal userspace runs it clean for hours on both a Debian 6.1
and an Ubuntu 7.0 guest kernel - the guest kernel version is not the
variable, the volume of 2 MiB-aligned teardown+reuse is.

