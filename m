Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF75419306;
	Fri,  5 Jun 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653644; cv=none; b=Shaz0A1GKBz5ECO7nP3kRa+ALoth2ga3nPifC731jNbNhwKpHc95sZVdcZ6y3MEv/RUYcN9ym30UMofKzZ14SzFQj87/dgJZ6jAY26KIhfoFr9Xh4TFgvtZXVJUJr8nhn2Mvif12n7hU45Vuui89uY6lmW7WlkbDHfXG6xkxteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653644; c=relaxed/simple;
	bh=XQRIyGOLNND3gFnjKW/BBMYpSX1mCH/72yhrkLkkFs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfGt77yS4xEjd682LEj+JhQ84a4mjojxwQfETRwYMNq4ypR3O64KoUKBk65AHt7g4iVtuueGlYv/D89akf4KKonyNun2MjfdADKDETsimV564FKdfZRaklMs0LkkRnLvZoQUSFNjVW5tkBc812tMjPFqP5EvYyhiLt+rhjEC9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=lfMDJ3PW; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="lfMDJ3PW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1780653639;
	bh=XQRIyGOLNND3gFnjKW/BBMYpSX1mCH/72yhrkLkkFs8=;
	h=From:To:Cc:Subject:Date;
	b=lfMDJ3PWGU4OS2tCtJU/CeRs80sA1g44mJ8sIEqboSM+i6cY/CaimJggyVJETYMb1
	 35qJgM4EujzomO6pIPSDiGJdfpl5k6B8daz2X8jNoqmHaoNGJKXv6PbvXiTu1n1SjZ
	 YJDv+U/V0QQ5OCyyT5REJg4+xJy9wv6kzhkaYbHftp2Gg2ohIs8CYVyK2vlcx1C92+
	 FJetSGGpvGzYKD+1WK/yILY4LKWop9T8/+AxipKgJdyBQnVuBi5WpsgJHLpWNNp7DS
	 u//wREhr4Jcqtv0Ge+Vnf8Eco5PeqVeG30sZS4OYDt+fl4e06ZwhYOgciNO2pbITMM
	 ijzThCx3+1GBQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id E95952FF3F1;
	Fri,  5 Jun 2026 10:00:38 +0000 (UTC)
Received: from mshou-H610M-K-DDR4.. (unknown [202.120.40.100])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 5727637C8EE;
	Fri,  5 Jun 2026 18:00:38 +0800 (CST)
From: "muliang.shou" <muliang.shou@sjtu.edu.cn>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	olivier.hault@level-it.be,
	jon@nutanix.com,
	"muliang.shou" <muliang.shou@sjtu.edu.cn>
Subject: [RFC PATCH v2 0/3] GiantVM based on shared memory
Date: Fri,  5 Jun 2026 18:00:28 +0800
Message-ID: <20260605100031.834938-1-muliang.shou@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Mark the series as RFC, as the design is still under discussion.
- No functional changes.

GiantVM is a many-to-one virtualization framework built atop QEMU/KVM.

Many-to-one virtualization aims to aggregate commodity servers into one
logical machine while preserving the standard VM abstraction based on
Distributed Shared Memory (DSM) as pioneered by Prof. Kai Li back in 1986.

As modern AI, big-data, and scientific workloads crave VMs whose CPU and
memory demands exceed the capacity of a single physical server, the old
dilemma strikes back. Scaling-up is increasingly costly due to diminishing
returns, especially the memory wall, while scale-out clusters often require
application refactoring and introduce message-passing overhead.

GiantVM is our attempt to answer the following question: if a leopard can't
change its spot, can we strike a balance between scaling-out and scaling-up
to draw on the best of both worlds?

We feel confident to propose our solution that aggregates multiple
physical hosts into a single virtual machine while keeping the guest OS
and applications unmodified.

1. Key benefits
===================

The architecture provides several key benefits for memory-intensive
services and HPC applications:
-- Simplified programming model. GiantVM provides a shared-memory
abstraction, so
developers can access shared data almost like local memory.
-- Higher resource utilization and scalable memory capacity.
-- Transparent data sharing and migration.
-- Integration with RDMA, CXL, UnifiedBus, and other modern high-speed
interconnects for more performance optimization (Under active development;
see Roadmap section).

2. Architecture
===============
The architecture is shown below in monospace text:

+---------------------------------------------------+
|                     Guest OS                      |
+-------------------------+-------------------------+
                          |
+-------------------------V-------------------------+
|                       Hosts                       |
|                                                   |
|       +-----------------------------------+       |
|       |            Userspace DSM          |       |
|       +----+-------------------------+----+       |
|            |                         |            |
|            V                         V            |
|  +-------------------+     +-------------------+  |
|  |       QEMU        |     |       QEMU        |  |
|  |  +-------------+  |     |  +-------------+  |  |
|  |  |    vCPU     |  |     |  |    vCPU     |  |  |
|  |  +-------------+  |     |  +-------------+  |  |
|  |  |  IO device  |  |     |  |  IO device  |  |  |
|  |  +-------------+  |     |  +-------------+  |  |
|  +-------------------+     +-------------------+  |
|  |      Host OS      |     |      Host OS      |  |
|  |  +-------------+  |     |  +-------------+  |  |
|  |  |     KVM     |  |     |  |     KVM     |  |  |
|  |  +-------------+  |     |  +-------------+  |  |
|  +-------------------+     +-------------------+  |
|  |     Hardware      |     |     Hardware      |  |
|  +-------------------+     +-------------------+  |
|         Node 0                    Node 1          |
+---------------------------------------------------+

This series provides the foundational KVM APIC-forwarding support needed 
for the GiantVM shared-memory startup path. 

It implements a concise IRQ forwarding interface that lets KVM 
hand selected LAPIC interrupt state to userspace, where the GiantVM 
runtime can route and reinject the interrupt for the target vCPU.
This allows guest APIC/IPI coordination to work across nodes during 
boot and runtime.

The series also includes UAPI definitions for related DSM APIC exits and
reinjection helpers that are expected by the userspace runtime. 

3. Implementation
=================
This series adds the interface through the following pieces:

  - Adds CONFIG_KVM_DSM_IRQ_FORWARD as an Intel KVM build option.
  - Adds KVM_REQ_DSM_IRQ_FORWARD and per-vCPU storage for one pending
    forwarded LAPIC interrupt record.
  - Extends KVM UAPI definitions with DSM exit reasons and struct kvm_run
    metadata used by the forwarding path.
  - Intercepts LAPIC MMIO writes to APIC_ICR and APIC_ICR2, records the
    written register, value, and derived destination APIC ID, then raises a
    KVM request.
  - Handles the request in vcpu_enter_guest() by exiting to userspace with
    KVM_EXIT_DSM_SEND_IRQ and filling the lapic_irq fields in struct
    kvm_run.
  - Adds VM ioctls for reinjecting DSM IPI, x2APIC ICR, and APIC base state
    from the GiantVM userspace runtime back into KVM.

The LAPIC MMIO path currently records APIC_ICR/APIC_ICR2 writes and leaves
the policy decision, including whether the destination is remote, to
userspace. 

4. Patch Layout
===============
  01: Kconfig, KVM request, per-vCPU state, and UAPI definitions
  02: LAPIC ICR/ICR2 MMIO interception and userspace exit handling
  03: VM ioctls for applying forwarded APIC, x2APIC ICR, and APIC base
      state

You can opt-in the framework by selecting CONFIG_KVM_DSM_IRQ_FORWARD as
a kernel compile flag in e.g. menuconfig.

5. Performance Data
===================
CoreMark was run on VMs configured with different vCPU counts to compare
the GiantVM shared-memory setup with a regular VM baseline.  Each VM was
configured with 64 GiB of memory, and the tested vCPU counts were 4, 8,
16, 32, 64, 72, and 128.  The reported values are CoreMark scores, where
higher is better.

  Cores  GVM score  GVM speedup  VM score  VM speedup  GVM/VM
  4      98783      1.00x        101032    1.00x       97.77%
  8      205642     2.08x        210817    2.09x       97.55%
  16     390974     3.96x        400500    3.96x       97.62%
  32     744099     7.53x        800328    7.92x       92.97%
  64     1477804    14.96x       1629535   16.13x      90.69%
  72     1511546    15.30x       1810068   17.92x      83.51%
  128    2531447    25.63x       2556548   25.30x      99.02%

Across these CoreMark runs, the GiantVM shared-memory configuration
achieved 83.51% to 99.02% of the regular VM score. Relative to its
4-core result, GiantVM scaled to 25.63x at 128 cores, while the regular
VM scaled to 25.30x.

6. Scope
========
Thanks for your interest in our humble project!

We wish to publish a functional core architecture and gather initial
feedback on the high-level design and overall approach in this Request
for Comments(RFC) submission. Specific implementation and optimization
details are curated in our GitHub repo on a rolling basis.

The patch represents a foundational framework for GiantVM support. It
provides a basic infrastructure and rudimentary resource sharing
mechanisms. We welcome the community to leverage this initial groundwork
and build solutions on their own. Advanced features such as DSM memory
management and software coherence framework is planned for future work.

Testing is primarily arranged towards running benchmarks on lab settings.
Uncharted forest bring out the best of men and the meanest of bugs during
summer time. Community testing and feedback on various hardware setup,
configurations, and workloads would be greatly appreciated!

Setup and demo instructions are available in the accompanying installation
guide.

Link: https://github.com/GiantVM/GVM-kernel/blob/shared-memory/v7.1-rc6/README.md

7. Roadmap
==============
Future GiantVM work includes the following items:

  - GiantVM over TCP.  This implementation is not
    included in this submission, but is available in the GiantVM QEMU and
    kernel repositories.

Link: https://github.com/GiantVM/GVM-qemu
Link: https://github.com/GiantVM/GVM-kernel
  - RDMA support, completed and coming soon.
  - CXL support, completed and coming soon.
  - Huawei UnifiedBus support, completed and under testing.
  - ARM architecture support, under active development and close to
    completion.
  - RISC-V support, planned.

9. Project References
=====================
[General Info]
  Organization: Trusted Cloud Group, Institute of Scalable Computing,
                Shanghai Jiao Tong University
  Website:
Link: https://giantvm.github.io/
  Repository:
Link: https://github.com/GiantVM

[Publications]
  - Xingguo Jia, Jin Zhang, Boshi Yu, Xingyue Qian, Zhengwei Qi,
    Haibing Guan:
    "GiantVM: A Novel Distributed Hypervisor for Resource Aggregation with
    DSM-aware Optimizations." ACM Trans. Archit. Code Optim. 19(2):
    20:1-20:27 (2022).
  - Jin Zhang, Zhuocheng Ding, Yubin Chen, Xingguo Jia, Boshi Yu,
    Zhengwei Qi, Haibing Guan: "GiantVM: a type-II hypervisor implementing
    many-to-one virtualization." VEE 2020: 30-44.

[KVM Forum Presentations]
  - KVM Forum 2025: "GiantVM: A Many-to-one Virtualization System Built
    Atop the QEMU/KVM Hypervisor"
Link: https://pretalx.com/kvm-forum-2025/talk/MDGYZG/
  - KVM Forum 2018: "Distributed QEMU" by Yubin Chen & Zhuocheng Ding
    (Video)
Link: https://www.youtube.com/watch?v=GprmhYU1M8Q

[Citations]
  - Kai Li: "Shared virtual memory on loosely coupled multiprocessors."
  PhD Dissertation, Yale University, 1986.

10. Acknowledgments
===================
This work builds on a multi-year research and engineering effort.  We thank
the following contributors for their work across different phases of the
project:

[Initial Project Development - Linux 4.19 era]
  Ding Zhuocheng <tcbbd@sjtu.edu.cn>
  Chen Yubin <binsschen@sjtu.edu.cn>
  Zhang Jin <jzhang3002@sjtu.edu.cn>
  Wang Yun <yunwang94@sjtu.edu.cn>
  Ma Jiacheng <jiacheng.ma@amd.com>
  Yu Boshi <201608ybs@sjtu.edu.cn>
  Jia Xingguo <jiaxg1998@sjtu.edu.cn>
  Chen Weiye <vorringer@sjtu.edu.cn>
  Wu Chenggang <wuchenggang@sjtu.edu.cn>
  Xiang Yuxin <xiangyuxin@sjtu.edu.cn>

[Modernization, Upstream Development, and Active Maintenance]
  Xiong Tianlei <qmyyxtl@sjtu.edu.cn>
  Xu Kailiang <xukl2019@sjtu.edu.cn>
  Xue Songtao <xxxlhhxz@sjtu.edu.cn>
  Shou Muliang <muliang.shou@sjtu.edu.cn>
  Han Fengze <adoniswhite926@gmail.com>
  Ren Luobin <renluobin0257@gmail.com>

---
muliang.shou (3):
  KVM: x86: add DSM IRQ forwarding ABI and state
  KVM: x86: forward LAPIC ICR writes to userspace
  KVM: x86: add DSM APIC forwarding ioctls

 arch/x86/include/asm/kvm_host.h | 17 ++++++++++
 arch/x86/kvm/Kconfig            | 12 +++++++
 arch/x86/kvm/lapic.c            | 38 +++++++++++++++++++++
 arch/x86/kvm/lapic.h            |  4 +++
 arch/x86/kvm/x86.c              | 54 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h        | 60 ++++++++++++++++++++++++++++++++-
 6 files changed, 184 insertions(+), 1 deletion(-)

-- 
2.43.0

