Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575187;
	b=pakCEpzDQ+IYcsPzFZGWQsj1ylhf/Hx/IbPtvn0MpinmSGMaFCnfbEvE5BXLVcck2QI0
	 pujQntvHx62OYosJJbnUFtvyo2plOoG6PsaGdM0/ui6TJ6Uh3DPbK71zGrXzHw5pkEd0c
	 LVGHt1AYbOWv87lmjyp/yFEdYJnYLg7cYp6MRqAaj5myu+/2suLy7uHU87s9ihn6y6m/9
	 tVkNrUbb/4BhHX8F6N63l1KS1yK4v0H3VdZKAWOjNthPrj6s4DcEikJwfCeD0DMDpGOFs
	 myXtDEjGtuaSMGiSjoyuFpI7aTyX+/o1WkJILAvDaTlfxeDdL4ze31JvIA/VcxjXHTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575187;
	h=DMARC-Filter:DKIM-Signature:References:From:Mime-Version:
	 Content-Transfer-Encoding:User-Agent:Content-Language:Content-Type:
	 In-Reply-To:To:Message-Id:Date:X-Original-From:Received:
	 X-Lms-Return-Path:Cc:Subject;
	bh=6ckAeucPeYJZwsv39zXkhYohTSd0rEHZZolRFbLvLvM=;
	b=VJGoTEfrbNmNXEAJ72zzjhSafJJK8tRli5s/R5HPRMadOZgsobN54EFBuSKD4nMxztN2
	 29SXXntr60ZDl6AOQqiH2atDNzieWT14grEJd2fVXKpp4fTioSjd5kGrmhWtiHECAMFnL
	 8T6ek7mgUwS1RpEISLG6IkJHqMh7fOP19KaOriXn1EXJc6MD9g7c1eZ2qYO8frzNh8eHy
	 rox7f7D6nAf7iE2uHuzclUITez0ENctCRFMitkG25SpfJeB/FyJJGJgVKZKNV9OYqQZFs
	 wZmpjdgN88imK5luXn1r8lNfoIwg34+Gm71GTzaQiTQUC30rYbTSec3+1PYxs19MMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	arc=none smtp.remote-ip=209.127.231.37
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A026606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 09:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A026606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1792575169;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6ckAeucPeYJZwsv39zXkhYohTSd0rEHZZolRFbLvLvM=;
 b=3Zb2qQJJXu3s9mIJT+kClUcKn8eE82BAvXrHo9cB15YES/y3X966Qrb9wFqOclFlazuDf0
 yCKH/i9x5RKQGiPYF6k3GWXtXU2KJ125DHcQ1W7K1EZT1gR+B7ocVR9CMwLXr6xpUA3Cx5
 P9ceQflwW5cIvEdkq6O8JceX7A4RXjn4N5AxFkqeY5bVQgpHF9ThxxzSLkRT8mcjsjmdmg
 d9oSzvsw11PzUZOHj8d6EeCTsue37L6ycG1L4DVdGg5Qaep63SHVTl/mc2Nl+yqPkpQYce
 zJsyorVRQ/20uNFAqCZKPVvJdDJKzhfF/IQ3hnRibkxJjfa9XkAsSd0JRT2Ekg==
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn> <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com> <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn> <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com> <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
To: "guoyaxing" <guoyaxing@bosc.ac.cn>, "Anup Patel" <anup@brainfault.org>
Message-Id: <bddcd13b-b97d-4c24-8f08-e0a239065e68@lanxincomputing.com>
Date: Wed, 21 Oct 2026 17:32:44 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Wed, 21 Oct 2026 17:32:46 +0800
X-Lms-Return-Path: <lba+26ad886bf+ce8cd7+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Cc: "Atish Patra" <atish.patra@linux.dev>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<majiuyue@bosc.ac.cn>, <anzoso@outlook.com>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host CPU

On 10/10/2026 5:06 PM, guoyaxing wrote:
>=20
>=20
> =E5=9C=A8 2026/10/10 15:50, Anup Patel =E5=86=99=E9=81=93:
>> On Sat, Oct 10, 2026 at 4:12=E2=80=AFAM guoyaxing <guoyaxing@bosc.ac.cn>=
 wrote:
>>>
>>>
>>>
>>> =E5=9C=A8 2026/10/10 02:51, Anup Patel =E5=86=99=E9=81=93:
>>>> On Mon, Aug 17, 2026 at 12:25=E2=80=AFPM Yaxing Guo <guoyaxing@bosc.ac=
.cn>=20
>>>> wrote:
>>>>>
>>>>> Guest Linux uses mm_cpumask to decide whether an sfence.vma needs=20
>>>>> to be
>>>>> local or remote. Under KVM that mask tracks guest CPUs, not the=20
>>>>> host CPUs
>>>>> that previously backed a vCPU.
>>>>>
>>>>> This can miss stale VS-stage TLB entries when a vCPU migrates=20
>>>>> across host
>>>>> CPUs. For example:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 - vcpu0 runs on host CPU1 and fills a VS-stage TLB=
 entry.
>>>>> =C2=A0=C2=A0=C2=A0 - vcpu0 migrates to host CPU0.
>>>>> =C2=A0=C2=A0=C2=A0 - the guest updates the mapping on vcpu0 and issue=
s a local=20
>>>>> sfence.vma.
>>>>> =C2=A0=C2=A0=C2=A0 - later, the guest task runs on vcpu1 while vcpu1 =
is backed by=20
>>>>> host CPU1.
>>>>
>>>> When the vcpu0 is brought back to host CPU1, the=20
>>>> kvm_riscv_local_tlb_sanitize()
>>>> will ensure TLB entries associated with Guest/VM are nuked.
>>>>
>>>> By default, kvm_riscv_local_hfence_gvma_vmid_all() will only do=20
>>>> HFENCE.GVMA
>>>> for the associated VMID because most RISC-V H-extension=20
>>>> implemenation will
>>>> tag VS-stage TLB entries with VMID and HFENCE.GVMA must remove both
>>>> G-stage and VS-stage TLB entries for given VMID.
>>>>
>>>> If your HW does not tag VS-stage TLB enteries with VMID then it buggy
>>>> / inefficient
>>>> so you have to set kvm_riscv_vsstage_tlb_no_gpa in
>>>> kvm_riscv_setup_vendor_features()
>>>> as work-around.
>>>>
>>>> NACK to this patch from myside.
>>>>
>>>> Regards,
>>>> Anup
>>>>
>>> Hi Anup,
>>> =C2=A0=C2=A0=C2=A0 Thanks for the review and clarification.
>>>
>>> =C2=A0=C2=A0=C2=A0 Regarding =E2=80=9CWhen the vcpu0 is brought back to=
 host CPU1=E2=80=9D: the failure
>>> we hit is not caused by vcpu0 being brought back onto host CPU1. In our
>>> case, after vcpu0 has already migrated away, neither vCPU migrates
>>> again. The guest process is later scheduled inside the multi-vCPU guest
>>> onto vcpu1, which is still running on host CPU1. So the stale TLB is
>>> re-hit without any further KVM vCPU migration, and
>>> kvm_riscv_local_tlb_sanitize() is not involved on that path.
>>>
>>> =C2=A0=C2=A0=C2=A0 My commit message was a bit too terse on this point.=
 The concrete
>>> sequence we observed was described earlier in the RFC discussion:
>>>
>>>
>>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-=20
>>> e8c49c2331e1@bosc.ac.cn/
>>>
>>> =C2=A0=C2=A0=C2=A0 In short, the issue is: because vcpu0 migrated away,=
 cpu1 still has
>>> stale TLB entries while cpu0 has the new mapping. After that, neither
>>> vcpu migrated again, but the process was scheduled from vcpu0 to vcpu1
>>> (which is on cpu1), causing it to hit the stale TLB. Consider the
>>> following scenario:
>>>
>>> =C2=A0=C2=A0=C2=A0 1. vcpu0 and vcpu1 are both running on cpu1. At this=
 point, vcpu0 is
>>> on cpu1, and a process on it reads a page, which gets cached in the TLB
>>> (let's call this the "stale TLB entry").
>>>
>>> =C2=A0=C2=A0=C2=A0 2. vcpu0 migrates to cpu0, and then the process (on =
vcpu0, now on
>>> cpu0) does a CoW (copy-on-write) and establishes a new mapping.
>>>
>>> =C2=A0=C2=A0=C2=A0 3. Neither vcpu0 nor vcpu1 migrates again. At this p=
oint, the=20
>>> process
>>> gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the
>>> same page, and hits the stale TLB entry.
>>
>> This cannot happen because in step#2 when mapping was updated the
>> Guest OS will do TLB flush for all its VCPUs which means vcpu1 on cpu0
>> will also receive TLB flush and the stale TLB will be removed. This mean=
s
>> when process is moved back to vcpu1 on cpu0, HW will fetch updated
>> PTE and new TLB entry will be populated.
>>
>=20
> Hi Anup,
>=20
> Thanks for the follow-up. I may be missing something, so I wanted to=20
> double-check this against the guest TLB shootdown path.
>=20
> If I follow the Linux guest CoW path correctly, when the mapping is=20
> updated in step#2 it goes through:
>=20
>  =C2=A0 wp_page_copy()
>  =C2=A0=C2=A0=C2=A0 -> ptep_clear_flush()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> flush_tlb_page()
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> __flush_tlb_range(mm, mm_c=
pumask(mm), ...)
>=20
> So the remote SFENCE.VMA appears to be targeted only at CPUs in=20
> mm_cpumask(mm), rather than at all VCPUs of the guest. mm_cpumask is=20
> updated in switch_mm()/set_mm() for guest CPUs that have actually run=20
> that mm.
>=20
> In our case, before the CoW the process had only ever run on vcpu0. From=
=20
> the guest's point of view it did not migrate: the host migration of=20
> vcpu0 from cpu1 to cpu0 is not visible to guest Linux, which only sees=20
> vCPUs. So at CoW time mm_cpumask still contains only vcpu0 (or at least=
=20
> does not contain vcpu1), and __flush_tlb_range() would not IPI vcpu1.=20
> The local SFENCE on vcpu0 would only cover host cpu0, where vcpu0 is=20
> currently running. The stale VS-stage TLB entry left on host cpu1 from=20
> when vcpu0 previously ran there would then remain.
>=20
> Later, still without any further vCPU migration, the process is=20
> scheduled inside the guest onto vcpu1, which remains on host cpu1, and=20
> can hit that stale entry.
>=20
> This also seems more likely when the ASID allocator is enabled, because
> set_mm_asid() does not always local_flush_tlb_all() on switch_mm(). So=20
> even the first time the process lands on vcpu1, a stale ASID-tagged=20
> entry on host cpu1 may still be present.
>=20
> In other words, I am not sure this case is covered by a full guest TLB=20
> flush to all VCPUs on the mapping update. Guest shootdown looks=20
> mm_cpumask-based, and host pCPU migration of a vCPU does not by itself=20
> add other vCPUs that never ran the mm into that mask.
>=20
> The earlier RFC note has a bit more detail on the flow we observed:
> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-=20
> e8c49c2331e1@bosc.ac.cn/
>=20
> Please let me know if I misunderstood the intended invalidation path here=
.
>=20
> Thanks,
> Yaxing
>=20

Hi Yaxing,

Thanks for your work. To help review and validate this patch, I am=20
sharing the two programs below, which were generated with the help of an=20
AI assistant. I reviewed the code and ran it on my test system: without=20
this patch the reproducer triggers the stale VS-stage TLB entry, and=20
with the patch applied it no longer does.

The test consists of two cooperating components:

   - a host-side controller that discovers the QEMU vCPU thread TIDs,
     pins them to specific host CPUs with taskset(1), and synchronizes
     with the guest program over TCP;

   - a guest-side program that performs the memory operations that
     populate and then probe the VS-stage TLB entries.

Start the host controller:

   sudo python3 vsstage_tlb_stale_host.py --qemu-pid <QEMU_PID>

Build and run the guest program inside the guest:

   gcc -O0 -o vsstage_tlb_stale_guest vsstage_tlb_stale_guest.c
   ./vsstage_tlb_stale_guest

The guest program connects to the host controller on TCP port 12345
by default. With QEMU user networking, the host is reachable from the
guest at 10.0.2.2, and the guest program uses that address by default.

Both the host controller and the guest program can be wrapped in a
shell while loop to reproduce the bug repeatedly.

Regards,
Bill

--- 8< --- vsstage_tlb_stale_host.py --- 8< ---
#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0
"""
RISC-V KVM stale VS-stage TLB reproducer (Host controller)

Scenario:
   Initially both vCPU0 and vCPU1 are pinned to host CPU1.
   After phase 1, vCPU0 is migrated to host CPU0.
   After phase 2, vCPU1 stays where it is (host CPU1).
   Phase 3 runs on vCPU1 and checks for a stale TLB entry.

Usage:
   sudo python3 auto_test.py --qemu-pid <QEMU_PID> \
        [--port 12345] [--host-cpu0 0] [--host-cpu1 1]
"""

import argparse
import glob
import os
import re
import socket
import subprocess
import sys
import time

# ---------------- vCPU TID discovery ----------------

VCPU_RE =3D re.compile(r"^(?:CPU\s+(\d+)/KVM|vcpu(\d+))$")


def find_vcpu_tids(qemu_pid):
     """Identify vCPU threads under /proc/<pid>/task. Returns {index:=20
tid}."""
     result =3D {}
     for task_dir in glob.glob(f"/proc/{qemu_pid}/task/*"):
         try:
             comm =3D open(f"{task_dir}/comm").read().strip()
         except OSError:
             continue
         m =3D VCPU_RE.match(comm)
         if not m:
             continue
         idx =3D int(m.group(1) if m.group(1) is not None else m.group(2))
         tid =3D int(os.path.basename(task_dir))
         result[idx] =3D tid
     return result


# ---------------- CPU affinity ----------------

def set_affinity(tid, cpu):
     subprocess.run(["taskset", "-pc", str(cpu), str(tid)],
                    check=3DTrue, stdout=3Dsubprocess.DEVNULL,
                    stderr=3Dsubprocess.DEVNULL)


def get_affinity(tid):
     try:
         out =3D subprocess.check_output(
             ["taskset", "-pc", str(tid)], stderr=3Dsubprocess.DEVNULL
         ).decode()
         return out.strip().split(":")[-1].strip()
     except subprocess.CalledProcessError:
         return "?"


def online_host_cpus():
     cpus =3D []
     try:
         raw =3D open("/sys/devices/system/cpu/online").read().strip()
     except OSError:
         sys.exit("Failed to read /sys/devices/system/cpu/online")
     for item in raw.split(","):
         if "-" in item:
             a, b =3D map(int, item.split("-"))
             cpus.extend(range(a, b + 1))
         else:
             cpus.append(int(item))
     return cpus


# ---------------- TCP communication ----------------

def recv_line(conn):
     buf =3D b""
     while not buf.endswith(b"\n"):
         chunk =3D conn.recv(1)
         if not chunk:
             raise EOFError("guest disconnected")
         buf +=3D chunk
     return buf.decode().strip()


def send_line(conn, msg):
     conn.sendall((msg + "\n").encode())


# ---------------- Main flow ----------------

def main():
     ap =3D argparse.ArgumentParser()
     ap.add_argument("--qemu-pid", type=3Dint, required=3DTrue,
                     help=3D"QEMU process PID")
     ap.add_argument("--port", type=3Dint, default=3D12345)
     ap.add_argument("--host-cpu0", type=3Dint, default=3D0,
                     help=3D"Target host CPU for migrating vCPU0 (default 0=
)")
     ap.add_argument("--host-cpu1", type=3Dint, default=3D1,
                     help=3D"Initial shared host CPU, where vCPU1 stays=20
(default 1)")
     ap.add_argument("--settle-ms", type=3Dint, default=3D500,
                     help=3D"Wait time after each migration (milliseconds)"=
)
     args =3D ap.parse_args()

     cpu0 =3D args.host_cpu0
     cpu1 =3D args.host_cpu1
     if cpu0 =3D=3D cpu1:
         sys.exit("--host-cpu0 and --host-cpu1 must differ")

     online =3D online_host_cpus()
     for c in (cpu0, cpu1):
         if c not in online:
             sys.exit(f"Host CPU {c} is offline, online CPUs: {online}")

     # ---- 1. Locate vCPU TIDs ----
     vcpus =3D find_vcpu_tids(args.qemu_pid)
     print(f"[Host] Found vCPU threads: {vcpus}")
     if 0 not in vcpus or 1 not in vcpus:
         sys.exit("vCPU0/vCPU1 threads not found; check the QEMU PID and "
                  "vCPU thread naming")

     # ---- 2. Initial pinning: both vCPU0 and vCPU1 on host CPU1 ----
     print(f"[Host] Initial pinning: vCPU0 -> CPU {cpu1}, vCPU1 -> CPU=20
{cpu1}")
     set_affinity(vcpus[0], cpu1)
     set_affinity(vcpus[1], cpu1)
     time.sleep(0.3)
     print(f"[Host] vCPU0 affinity =3D {get_affinity(vcpus[0])}")
     print(f"[Host] vCPU1 affinity =3D {get_affinity(vcpus[1])}")

     # ---- 3. Listen for the guest ----
     srv =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
     srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
     srv.bind(("0.0.0.0", args.port))
     srv.listen(1)
     print(f"[Host] Listening on 0.0.0.0:{args.port}, waiting for guest=20
...")

     conn, addr =3D srv.accept()
     conn.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
     print(f"[Host] Guest connected: {addr}")

     try:
         # ---- 4. Handshake ----
         msg =3D recv_line(conn)
         if msg !=3D "HELLO":
             sys.exit(f"Handshake failed, received: {msg}")
         send_line(conn, "GO_PHASE1")

         # ---- 5. Phase 1 done -> migrate vCPU0 from CPU1 to CPU0 ----
         msg =3D recv_line(conn)
         if msg !=3D "PHASE1_DONE":
             sys.exit(f"Expected PHASE1_DONE, received: {msg}")
         print(f"[Host] Phase 1 done; migrating vCPU0: CPU {cpu1} -> CPU=20
{cpu0}")
         set_affinity(vcpus[0], cpu0)
         time.sleep(args.settle_ms / 1000.0)
         print(f"[Host] vCPU0 affinity =3D {get_affinity(vcpus[0])}")
         send_line(conn, "MIGRATED0")

         # ---- 6. Phase 2 done -> confirm vCPU1 stays on CPU1 ----
         msg =3D recv_line(conn)
         if msg !=3D "PHASE2_DONE":
             sys.exit(f"Expected PHASE2_DONE, received: {msg}")
         print(f"[Host] Phase 2 done; confirming vCPU1 is still on CPU=20
{cpu1}, "
               f"no migration")
         print(f"[Host] vCPU1 affinity =3D {get_affinity(vcpus[1])}")
         send_line(conn, "MIGRATED1")

         # ---- 7. Collect the result ----
         msg =3D recv_line(conn)
         print(f"[Host] Received result: {msg}")
         if msg =3D=3D "RESULT:0x0":
             print()
             print("=3D" * 55)
             print("  *** BUG REPRODUCED *** (read the stale value 0x0)")
             print("=3D" * 55)
             rc =3D 0
         elif msg =3D=3D "RESULT:0xcafebabe":
             print()
             print("=3D" * 55)
             print("  Not reproduced (read the new value)")
             print("=3D" * 55)
             rc =3D 1
         else:
             print(f"  Unexpected result: {msg}")
             rc =3D 2

     finally:
         conn.close()
         srv.close()

     sys.exit(rc)


if __name__ =3D=3D "__main__":
     main()

--- 8< --- vsstage_tlb_stale_guest.c --- 8< ---
// SPDX-License-Identifier: GPL-2.0
/*
  * RISC-V KVM stale VS-stage TLB entry reproducer (Guest side, automated)
  *
  * Scenario:
  *   Initially both vCPU0 and vCPU1 are pinned to host CPU1.
  *   Phase 1: the task runs on vCPU0 (host CPU1) and reads the shared page=
,
  *            populating a stale VS-stage TLB entry on host CPU1.
  *   Phase 2: the host migrates vCPU0 to host CPU0; the task writes the=20
page
  *            on vCPU0 (host CPU0), triggering COW. The guest-local
  *            sfence.vma only invalidates entries on host CPU0.
  *   Phase 3: the task is scheduled onto vCPU1 (host CPU1) and reads=20
the same
  *            page, hitting the stale entry left behind on host CPU1.
  *
  * Usage:
  *   ./vsstage_tlb_stale_guest [host_ip] [port]
  *   Default host_ip=3D10.0.2.2  port=3D12345
  *
  * Build:
  *   gcc -O0 -o vsstage_tlb_stale_guest vsstage_tlb_stale_guest.c
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sched.h>
#include <errno.h>
#include <stdint.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>

#define PAGE_SIZE       4096
#define INITIAL_VALUE   0x0UL
#define WRITE_VALUE     0xCAFEBABEUL

static volatile uint64_t *shared_page;
static int sock_fd =3D -1;

/* ---------------- TCP communication ---------------- */

static int connect_host(const char *host, int port)
{
     struct sockaddr_in sa;
     int fd, one =3D 1, i;

     memset(&sa, 0, sizeof(sa));
     sa.sin_family =3D AF_INET;
     sa.sin_port   =3D htons(port);
     if (inet_pton(AF_INET, host, &sa.sin_addr) !=3D 1) {
         fprintf(stderr, "Invalid host IP: %s\n", host);
         return -1;
     }

     fd =3D socket(AF_INET, SOCK_STREAM, 0);
     if (fd < 0) { perror("socket"); return -1; }
     setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));

     for (i =3D 0; i < 60; i++) {
         if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) =3D=3D 0)
             return fd;
         if (i =3D=3D 0)
             fprintf(stderr, "Waiting for host %s:%d ...\n", host, port);
         sleep(1);
     }
     fprintf(stderr, "Failed to connect to host: %s\n", strerror(errno));
     close(fd);
     return -1;
}

static void send_msg(const char *msg)
{
     size_t len =3D strlen(msg);
     if (send(sock_fd, msg, len, 0) !=3D (ssize_t)len ||
         send(sock_fd, "\n", 1, 0) !=3D 1)
         perror("send");
}

/* Read one line, blocking until '\n' is received. */
static int recv_msg(char *buf, size_t buflen)
{
     size_t n =3D 0;
     while (n + 1 < buflen) {
         char c;
         ssize_t r =3D recv(sock_fd, &c, 1, 0);
         if (r <=3D 0) return -1;
         if (c =3D=3D '\n') break;
         buf[n++] =3D c;
     }
     buf[n] =3D '\0';
     return (int)n;
}

/* ---------------- CPU pinning ---------------- */

static int pin_guest_cpu(int cpu)
{
     cpu_set_t set;

     CPU_ZERO(&set);
     CPU_SET(cpu, &set);
     if (sched_setaffinity(0, sizeof(set), &set) !=3D 0) {
         fprintf(stderr, "Failed to pin to guest CPU %d: %s\n",
                 cpu, strerror(errno));
         return -1;
     }

     /* Give the scheduler time to actually place the task on the target=20
vCPU. */
     usleep(500000);

     printf("  [Guest] Now running on guest CPU %d\n", sched_getcpu());
     fflush(stdout);
     return 0;
}

/* ---------------- Main flow ---------------- */

int main(int argc, char **argv)
{
     const char *host =3D argc > 1 ? argv[1] : "10.0.2.2";
     int port         =3D argc > 2 ? atoi(argv[2]) : 12345;
     uint64_t val;
     char buf[128];
     long ncpus;

     setvbuf(stdout, NULL, _IOLBF, 0);

     printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");
     printf(" RISC-V KVM stale VS-stage TLB reproducer (Guest)\n");
     printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");
     printf("Connecting to host: %s:%d\n", host, port);

     ncpus =3D sysconf(_SC_NPROCESSORS_ONLN);
     if (ncpus < 2) {
         fprintf(stderr, "At least 2 guest CPUs are required\n");
         return 1;
     }

     /*
      * Anonymous private mapping. The first read faults in the shared
      * read-only zero page; the first write triggers COW.
      */
     shared_page =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (shared_page =3D=3D MAP_FAILED) {
         perror("mmap");
         return 1;
     }
     printf("Shared page: %p (initially mapped to the read-only zero=20
page)\n",
            (void *)shared_page);

     /* ---- Connect to host ---- */
     sock_fd =3D connect_host(host, port);
     if (sock_fd < 0) return 1;

     send_msg("HELLO");
     if (recv_msg(buf, sizeof(buf)) < 0 || strcmp(buf, "GO_PHASE1") !=3D 0)=
 {
         fprintf(stderr, "Handshake failed: %s\n", buf);
         return 1;
     }

     /* ---- Phase 1: read on vCPU0 (host CPU1), populate stale TLB ---- */
     printf("\n--- Phase 1: vCPU0 reads shared page (expected host CPU1)=20
---\n");
     if (pin_guest_cpu(0) !=3D 0) return 1;

     __sync_synchronize();
     val =3D shared_page[0];
     __sync_synchronize();
     printf("  [Guest] Phase 1 read 0x%lx\n", (unsigned long)val);

     send_msg("PHASE1_DONE");
     if (recv_msg(buf, sizeof(buf)) < 0 || strcmp(buf, "MIGRATED0") !=3D 0)=
 {
         fprintf(stderr, "Did not receive MIGRATED0: %s\n", buf);
         return 1;
     }
     printf("  [Guest] Host migrated vCPU0 to host CPU0\n");

     /* ---- Phase 2: write on vCPU0 (host CPU0), COW + local sfence ---- *=
/
     printf("\n--- Phase 2: vCPU0 writes shared page, triggering COW "
            "(expected host CPU0) ---\n");
     __sync_synchronize();
     shared_page[0] =3D WRITE_VALUE;
     __sync_synchronize();
     val =3D shared_page[0];
     printf("  [Guest] Phase 2 read back 0x%lx\n", (unsigned long)val);

     send_msg("PHASE2_DONE");
     if (recv_msg(buf, sizeof(buf)) < 0 || strcmp(buf, "MIGRATED1") !=3D 0)=
 {
         fprintf(stderr, "Did not receive MIGRATED1: %s\n", buf);
         return 1;
     }
     printf("  [Guest] Host confirmed vCPU1 is still on host CPU1\n");

     /* ---- Phase 3: task migrates to vCPU1 (host CPU1), hit stale=20
entry ---- */
     printf("\n--- Phase 3: task migrates to vCPU1 and reads shared page "
            "(expected host CPU1) ---\n");
     if (pin_guest_cpu(1) !=3D 0) return 1;

     __sync_synchronize();
     val =3D shared_page[0];
     __sync_synchronize();

     printf("  [Guest] Phase 3 read 0x%lx\n", (unsigned long)val);

     snprintf(buf, sizeof(buf), "RESULT:0x%lx", (unsigned long)val);
     send_msg(buf);

     printf("\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");
     if (val =3D=3D WRITE_VALUE) {
         printf(" Verdict: OK (read the new value 0x%lx)\n",
                (unsigned long)val);
     } else if (val =3D=3D INITIAL_VALUE) {
         printf(" Verdict: *** BUG REPRODUCED *** read the stale value=20
0x0\n");
     } else {
         printf(" Verdict: unexpected value 0x%lx\n", (unsigned long)val);
     }
     printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n");

     close(sock_fd);
     munmap((void *)shared_page, PAGE_SIZE);
     return 0;
}
--- 8< --- end --- 8< ---

Tested-by: BillXiang <xiangwencheng@lanxincomputing.com>

>>>
>>> =C2=A0=C2=A0=C2=A0 So this is an intra-guest scheduling case onto a vCP=
U that stayed on
>>> the original host CPU, rather than a =E2=80=9Cvcpu0 returns to host CPU=
1=E2=80=9D case.
>>
>> My NACK still holds.
>>
>> Regards,
>> Anup
>>
>>>
>>> =C2=A0=C2=A0=C2=A0 Thanks,
>>> =C2=A0=C2=A0=C2=A0 Yaxing
>>>
>>>>>
>>>>> Host CPU1 did not observe the guest-local sfence.vma, and KVM can=20
>>>>> enter
>>>>> vcpu1 with a stale VS-stage translation left behind by vcpu0.
>>>>>
>>>>> The reported failure was seen on a XiangShan RISC-V system. A bash=20
>>>>> task
>>>>> ran on vcpu0 while vcpu0 was backed by host CPU1, and a read-only=20
>>>>> page was
>>>>> prefetched into CPU1's VS-stage TLB. vcpu0 later migrated to host=20
>>>>> CPU0,
>>>>> where the guest triggered COW, updated the mapping, and issued only=
=20
>>>>> a local
>>>>> sfence.vma. The stale VS-stage entry on CPU1 survived. When the=20
>>>>> same guest
>>>>> task later ran on another vCPU backed by host CPU1, it hit the stale
>>>>> translation. The page contained a GOT pointer, and using the stale=20
>>>>> data led
>>>>> to a NULL dereference and a userspace segmentation fault.
>>>>>
>>>>> The existing local TLB sanitize path flushes G-stage entries when a=
=20
>>>>> vCPU
>>>>> migrates, and flushes VS-stage entries only for implementations=20
>>>>> selected by
>>>>> the Andes-specific kvm_riscv_vsstage_tlb_no_gpa static key. That=20
>>>>> handles a
>>>>> split two-stage TLB implementation where HFENCE.GVMA does not=20
>>>>> invalidate
>>>>> VS-stage entries, but it does not cover the generic guest-local=20
>>>>> sfence.vma
>>>>> case above.
>>>>>
>>>>> Track, per VM and per host CPU, the last vCPU that entered the=20
>>>>> guest on
>>>>> that CPU. Before guest entry, flush the current CPU's VS-stage=20
>>>>> context for
>>>>> the VM if either the current vCPU migrated since its last exit, or=20
>>>>> this
>>>>> host CPU is switching from another vCPU of the same VM. Keep the=20
>>>>> existing
>>>>> HFENCE.GVMA behavior tied to vCPU migration.
>>>>>
>>>>> This also subsumes the Andes split-TLB workaround. That workaround wa=
s
>>>>> needed because the migration sanitize path previously relied on
>>>>> HFENCE.GVMA alone for most implementations, and only issued=20
>>>>> HFENCE.VVMA
>>>>> when kvm_riscv_vsstage_tlb_no_gpa was set. The new sanitize path=20
>>>>> always
>>>>> issues HFENCE.VVMA when reusing a host CPU for a VM context that=20
>>>>> may have
>>>>> missed a guest-local sfence.vma, so it no longer depends on=20
>>>>> HFENCE.GVMA
>>>>> invalidating VS-stage entries. The implementation-specific static=20
>>>>> key and
>>>>> setup hook are therefore no longer needed.
>>>>>
>>>>> Reported-by: Zhizun Wang <anzoso@outlook.com>
>>>>> Reviewed-by: Jiuyue Ma <majiuyue@bosc.ac.cn>
>>>>> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
>>>>> ---
>>>>> =C2=A0=C2=A0 arch/riscv/include/asm/kvm_host.h |=C2=A0 6 +++---
>>>>> =C2=A0=C2=A0 arch/riscv/kvm/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ---------------
>>>>> =C2=A0=C2=A0 arch/riscv/kvm/tlb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 ++++++++++++++++++++++=20
>>>>> +--------
>>>>> =C2=A0=C2=A0 arch/riscv/kvm/vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
>>>>> =C2=A0=C2=A0 4 files changed, 42 insertions(+), 26 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/=20
>>>>> include/asm/kvm_host.h
>>>>> index 24585304c..396ac6209 100644
>>>>> --- a/arch/riscv/include/asm/kvm_host.h
>>>>> +++ b/arch/riscv/include/asm/kvm_host.h
>>>>> @@ -91,6 +91,9 @@ struct kvm_arch {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* G-stage vmi=
d */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vmi=
d vmid;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Last VCPU that ran on each p=
hysical CPU */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int __percpu *last_vcpu_ran;
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* G-stage pag=
e table */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgd_t *pgd;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys_addr_t pg=
d_phys;
>>>>> @@ -330,7 +333,4 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu=20
>>>>> *vcpu);
>>>>>
>>>>> =C2=A0=C2=A0 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *v=
cpu);
>>>>>
>>>>> -/* Flags representing implementation specific details */
>>>>> -DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>>>>> -
>>>>> =C2=A0=C2=A0 #endif /* __RISCV_KVM_HOST_H__ */
>>>>> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
>>>>> index 0f3fe3986..b1bbc0835 100644
>>>>> --- a/arch/riscv/kvm/main.c
>>>>> +++ b/arch/riscv/kvm/main.c
>>>>> @@ -10,23 +10,10 @@
>>>>> =C2=A0=C2=A0 #include <linux/err.h>
>>>>> =C2=A0=C2=A0 #include <linux/module.h>
>>>>> =C2=A0=C2=A0 #include <linux/kvm_host.h>
>>>>> -#include <asm/cpufeature.h>
>>>>> =C2=A0=C2=A0 #include <asm/kvm_mmu.h>
>>>>> =C2=A0=C2=A0 #include <asm/kvm_nacl.h>
>>>>> =C2=A0=C2=A0 #include <asm/sbi.h>
>>>>>
>>>>> -DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>>>>> -
>>>>> -static void kvm_riscv_setup_vendor_features(void)
>>>>> -{
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Andes AX66: split two-stage =
TLBs */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (riscv_cached_mvendorid(0) =
=3D=3D ANDES_VENDOR_ID &&
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (riscv_=
cached_marchid(0) & 0xFFFF) =3D=3D 0x8A66) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 static_branch_enable(&kvm_riscv_vsstage_tlb_no_gpa);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kvm_info("VS-stage TLB does not cache guest=20
>>>>> physical address and VMID\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -}
>>>>> -
>>>>> =C2=A0=C2=A0 long kvm_arch_dev_ioctl(struct file *filp,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int ioctl, unsigned long arg)
>>>>> =C2=A0=C2=A0 {
>>>>> @@ -172,8 +159,6 @@ static int __init riscv_kvm_init(void)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_info("AIA available with %d guest ext=
ernal=20
>>>>> interrupts\n",
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 kvm_riscv_aia_nr_hgei);
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_setup_vendor_features=
();
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_register_p=
erf_callbacks();
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D kvm_ini=
t(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>>>>> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
>>>>> index ff1aeac4e..1541d059a 100644
>>>>> --- a/arch/riscv/kvm/tlb.c
>>>>> +++ b/arch/riscv/kvm/tlb.c
>>>>> @@ -8,6 +8,7 @@
>>>>> =C2=A0=C2=A0 #include <linux/errno.h>
>>>>> =C2=A0=C2=A0 #include <linux/err.h>
>>>>> =C2=A0=C2=A0 #include <linux/module.h>
>>>>> +#include <linux/percpu.h>
>>>>> =C2=A0=C2=A0 #include <linux/smp.h>
>>>>> =C2=A0=C2=A0 #include <linux/kvm_host.h>
>>>>> =C2=A0=C2=A0 #include <asm/cacheflush.h>
>>>>> @@ -160,12 +161,19 @@ void kvm_riscv_local_hfence_vvma_all(unsigned=
=20
>>>>> long vmid)
>>>>>
>>>>> =C2=A0=C2=A0 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
>>>>> =C2=A0=C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vcpu_migrated;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vcpu_switched;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long =
vmid;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *last_ran;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_riscv_gstage_vmid_bits=
() ||
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->a=
rch.last_exit_cpu =3D=3D vcpu->cpu)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_ran =3D this_cpu_ptr(vcpu-=
>kvm->arch.last_vcpu_ran);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu_migrated =3D (vcpu->arch.l=
ast_exit_cpu !=3D vcpu->cpu);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu_switched =3D (*last_ran !=
=3D vcpu->vcpu_idx);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vcpu_migrated && !vcpu_swi=
tched)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmid =3D READ_ONCE(vcpu->kvm->a=
rch.vmid.vmid);
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * On RIS=
C-V platforms with hardware VMID support, we=20
>>>>> share same
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * VMID f=
or all VCPUs of a particular Guest/VM. This=20
>>>>> means we might
>>>>> @@ -176,16 +184,23 @@ void kvm_riscv_local_tlb_sanitize(struct=20
>>>>> kvm_vcpu *vcpu)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To cle=
anup stale TLB entries, we simply flush all G-=20
>>>>> stage TLB
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * entrie=
s by VMID whenever underlying Host CPU changes=20
>>>>> for a VCPU.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmid =3D READ_ONCE(vcpu->kvm->a=
rch.vmid.vmid);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_local_hfence_gvma_vmi=
d_all(vmid);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vcpu_migrated && kvm_riscv_=
gstage_vmid_bits())
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kvm_riscv_local_hfence_gvma_vmid_all(vmid);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Flush VS-stage TLB entr=
ies for implementation where VS-=20
>>>>> stage
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TLB does not cahce gues=
t physical address and VMID.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Guest-local sfence.vma =
only invalidates VS-stage=20
>>>>> translations on
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the Host CPU currently =
backing the VCPU. If a VCPU=20
>>>>> migrates, or
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if this Host CPU switch=
es between VCPUs of the same VM,=20
>>>>> stale
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * VS-stage entries can be=
 left behind on a Host CPU that=20
>>>>> missed a
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * guest-local flush. Flus=
h the current CPU's VS-stage=20
>>>>> context before
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * entering the guest.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (static_branch_unlikely(&kvm=
_riscv_vsstage_tlb_no_gpa))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_riscv_nacl_available())
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nacl_hfence_vvma_all(nacl_shmem(), vmid);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_local_hfence_vvma_all(vmid);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *last_ran =3D vcpu->vcpu_idx;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
>>>>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>>>>> index 13c63ae1a..2907218a1 100644
>>>>> --- a/arch/riscv/kvm/vm.c
>>>>> +++ b/arch/riscv/kvm/vm.c
>>>>> @@ -9,6 +9,7 @@
>>>>> =C2=A0=C2=A0 #include <linux/errno.h>
>>>>> =C2=A0=C2=A0 #include <linux/err.h>
>>>>> =C2=A0=C2=A0 #include <linux/module.h>
>>>>> +#include <linux/percpu.h>
>>>>> =C2=A0=C2=A0 #include <linux/uaccess.h>
>>>>> =C2=A0=C2=A0 #include <linux/kvm_host.h>
>>>>> =C2=A0=C2=A0 #include <asm/kvm_mmu.h>
>>>>> @@ -30,7 +31,9 @@ const struct kvm_stats_header kvm_vm_stats_header=
=20
>>>>> =3D {
>>>>>
>>>>> =C2=A0=C2=A0 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type=
)
>>>>> =C2=A0=C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *last_ran;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D kvm_risc=
v_mmu_alloc_pgd(kvm);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r)
>>>>> @@ -42,6 +45,17 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned=20
>>>>> long type)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm->arch.last_vcpu_ran =3D all=
oc_percpu(int);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm->arch.last_vcpu_ran) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kvm_riscv_mmu_free_pgd(kvm);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_possible_cpu(cpu) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 last_ran =3D per_cpu_ptr(kvm->arch.last_vcpu_ran, cpu);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *last_ran =3D -1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_aia_=
init_vm(kvm);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_gues=
t_timer_init(kvm);
>>>>> @@ -54,6 +68,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_destroy_vc=
pus(kvm);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_aia_=
destroy_vm(kvm);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_percpu(kvm->arch.last_vcpu=
_ran);
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_ir=
q_level=20
>>>>> *irql,
>>>>> --=20
>>>>> 2.43.0
>>>>>
>>>
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
