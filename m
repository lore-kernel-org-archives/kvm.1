Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938248989D;
	Sun,  2 Aug 2026 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785646868; cv=none; b=gYGgZgW1QuBb5XMl1Tizmt66TVBaaNMQU1boS8L12soTllb6C/BWLeiOIymlBMc5kuEXvbiGnGT43/pDk/4Gt5Hdqquf6Vz6xmQOBT6FtHKfOQwI3H4XTwpvwQPwAIIONa2qn2rhRDQC27SSPVO8WOZ4N27t8GOaKjEKs+oc7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785646868; c=relaxed/simple;
	bh=us16TSVAOi+xR9IweTN1lDgB5up8/upbIOuR+OvC4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OL4SVy5AxyBwhCGPaDY/NKklBf1xd2S6YpTDXkG/Dlnx2U66Q2vayKE/wNZzT0mdpIIumb7/LZp9MzMbgQbomlElafMOKrVbJidLwj3tYmE0AogOSEx1SbG8A8NSNm8ifsKMaovQ2Xkbhmiz5//LpFMpFEaaIrfSsUL1JTCAWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b=BSnsmRsv; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b="BSnsmRsv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1785646855; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Pt73grlFBLxMuyEprmpx00JxnCh3hf5B0ZaySBUrw7M=;
	b=BSnsmRsvEjQqU3gY5n4nFBMC034RyLlYSNOTORmGyfG3V82JQ2ZthcG9Qm3nW9Y/kc/73NZoCAb7Lo/ZgNTHSt96+QZQZNUM12aAsaccu22+B7C61GwEeuuiT9dzSWHNkB+tnhcI5N/Y6YSZ2nsvs9rzPfKLEBD/4wiMRrKQ4KUnZcchbdLsb0t3y4WHA3Schib/VFAa7g/1Ss4D3GoVE/lt8iEAU18jfQ9lfiT6kQwrvQPlqbyWGvMrVsNfB00k8cLny1ttnGQUOGFG2Phxob25fxYEKkby0TNunBvFTqJlJzHn+PRUyBIufdwrrOkV0r9XTNT2azL08xXJewbbkA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07511541|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.143854-0.0024158-0.85373;FP=16572605649191133682|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.ibc6NmS_1785646816;
Received: from guoyaxing..(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.ibc6NmS_1785646816 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 02 Aug 2026 13:00:54 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Hui Min Mina Chou <minachou@andestech.com>,
	guoyaxing@bosc.ac.cn,
	majiuyue@bosc.ac.cn,
	linux-kernel@vger.kernel.org
Subject: [RFC] RISC-V KVM: guest local sfence.vma may miss stale VS-stage TLB after vCPU migration
Date: Sun,  2 Aug 2026 13:00:15 +0800
Message-ID: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I would like to ask whether RISC-V KVM has a gap around guest sfence.vma
and VS-stage TLB invalidation when a vCPU migrates across host CPUs.

On bare metal, Linux uses mm_cpumask in __flush_tlb_range() to decide
whether to send a local or remote sfence.vma. That works because the cpumask
reflects physical CPUs. In a guest, however, the kernel only sees vCPUs, so
from the guest point of view a task may never "migrate" even though the
underlying vCPU moved to a different host CPU. In other words, guest
mm_cpumask is effectively a vCPU mask, not a host CPU mask.

There is also a related switch_mm()/set_mm_asid() aspect. With the ASID
allocator enabled, RISC-V Linux does not flush on every context switch. A
local_flush_tlb_all() is only done when a deferred ASID rollover flush is
pending for the current CPU. That is fine on bare metal, because previous
shootdowns are also based on physical CPUs. In a guest, however, the earlier
shootdown may have been only a guest-local sfence.vma and may have missed an
old host CPU where the same vCPU ran previously.

A simplified sequence is:

1. A guest task with mm A runs on vcpu0 while vcpu0 is scheduled on host
   CPU1. CPU1 fills a VS-stage TLB entry for that mm/ASID.
2. vcpu0 migrates to host CPU0. KVM's vCPU migration sanitization is local
   to the current host CPU, so it does not invalidate the VS-stage TLB entry
   that was left on host CPU1.
3. The guest later updates mm A's page table from vcpu0, for example due to
   COW. Since the guest still sees mm A as having run only on guest CPU0,
   __flush_tlb_range() can choose a local sfence.vma. That local sfence.vma
   only affects host CPU0, where vcpu0 is currently running, so the stale
   VS-stage entry on host CPU1 remains.
4. Later, the task is scheduled again while vcpu0 is running on host CPU1.
   If the ASID is still valid and no deferred ASID rollover flush is pending,
   set_mm_asid() may not issue any flush. The access on host CPU1 can then
   hit the old VS-stage TLB entry.

We hit this on a XiangShan RISC-V system. A bash task in the guest was
scheduled on vcpu0 while that vCPU was running on host CPU1. A read-only
page was prefetched and cached in CPU1's VS-stage TLB. Later the same vCPU
migrated to host CPU0, the guest triggered COW and updated the mapping, and
the guest still issued only a local sfence.vma. The stale VS-stage entry on
CPU1 was not invalidated. After running for some time, the task later
accessed that mapping while running on host CPU1 again and hit the stale
translation. The data in that page was a pointer from the GOT, so it
dereferenced to NULL and eventually caused a segmentation fault.

I checked current upstream RISC-V KVM (v7.0.2) and I do not see HSTATUS.VTVM
being enabled, so guest sfence.vma is not trapped. I found
kvm_riscv_local_tlb_sanitize() on host CPU migration, which handles G-stage
VMID entries on the current host CPU, but I do not think it generally solves
the stale VS-stage TLB case described above.

I also noticed the vendor-specific kvm_riscv_vsstage_tlb_no_gpa path in
current upstream. It looks like a workaround for a particular implementation
issue on Andes AX66, where the VS-stage TLB does not cache guest physical
address and VMID, so the normal VMID/GPA-based invalidation model is
insufficient. In that sense, it does not seem to be a generic solution for
guest sfence.vma coherence across vCPU migration.

I am wondering what the right direction should be. Enabling HSTATUS.VTVM and
trapping guest sfence.vma would allow KVM to translate guest local sfence.vma
into the required host-side hfence.vvma, but that may be too heavy for the
common case. Another possible direction may be to make the current
Andes-specific vCPU migration flush logic more generic, so implementations
that need VS-stage TLB sanitization on vCPU migration can opt in through a
common mechanism. A third possibility may be to define a lightweight SBI
interface for guest local sfence.vma, so Linux could use it in
__flush_tlb_range() for the local case when running under KVM, and KVM could
then decide whether a local sfence.vma is sufficient or whether host-side
hfence.vvma is also needed.

My questions are:
1. Is the behavior above expected on current RISC-V KVM?
2. If not, what would be the preferred fix direction?
3. Should this be handled by trapping guest sfence.vma with VTVM, by
   generalizing the existing vCPU-migration VS-stage TLB flush logic, or by
   adding a lighter SBI-mediated path for guest local sfence.vma?
4. Or is there another intended mechanism to keep VS-stage TLB state coherent
   across vCPU migration?

If needed, I can send a reproducer and the exact hardware/kernel details.

Thanks,
Yaxing Guo
