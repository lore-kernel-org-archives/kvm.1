Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A22D0292;
	Thu,  7 May 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152960; cv=none; b=Yqe3UvM+TbruZ+qN626P4PWMfdBcpv8oQBx7KyCR/nHVx56Q2/Z4YOTHlYzDT1XlXFPbJendTMZSmFF/KQGb6ngbXOftAntWo/xZnWa4Ff1HW/GUDLEAgiEJX5K3cOLTAT191eiJJYt02KIRvGkbq49vDs8HuBM9x0PHcLFwwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152960; c=relaxed/simple;
	bh=j3qxXjEccRLf2AKtJxK2psPuZL6OUOIqBT3EUDFgTVI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Z2sxMfBYCcsWOjbeS+kGEjxDmRqYYEzfXFgWYBJkfIk3XTydfVc0mIKAzWpCd7dQ9XG9Nm1CEB++5NbsoAr2HZsfcxBoMuPtuFPFtjkPAFEyQCo62arEk+BNXBnAlIrlT/svC9jzFaf63qe/ggJMjjZLruoITVxkJT9HJmjk0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i0thVTfo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0thVTfo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=sAcOdxmOe/xCTS0AuHv5Rh993ZJNh1WFw+rNQs2+sHY=; b=i0thVTfo5LFQewRLXzTuuP2woq
	xNw5sy80RwC0JyhdopqHfILIb1zNhOvPRuOLfJIZGbyHgVURLpxGrDKz0ORX1mm/p6YFy0QgiSmBK
	JbdBO8ydeORbo7JCUHc4Gvd12npm1dELsPIS8i51FAEcLq/OGIC4fm9I25Z545MozBlztNw0wMdSf
	w3znIQx5u7xF/WHbdGWfIG+nEjJr19FA1H+OdpAeTJznOIgEZWwSF5dbPM7gWkkzc4Jyo/bCN8wUo
	n7SuAnvZ56/CSLzDltyQOB8bizKoIIlMFuOcmkrGm5uuBjbOANYRnitYdQoCPlUOWC+GgUwlbAfXN
	4H4XVwvA==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKwoC-00000003LGw-0Evj;
	Thu, 07 May 2026 11:22:24 +0000
Message-ID: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Subject: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "Saenz Julienne, Nicolas"
 <nsaenz@amazon.es>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Date: Thu, 07 May 2026 12:22:24 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-U6jXKNSRi78+HB71c55e"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-U6jXKNSRi78+HB71c55e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
trap, but on SVM it was not always intercepted. Unconditionally
intercept ICEBP on SVM to match VMX behaviour and ensure correct
event delivery semantics.

Add two selftests exercising ICEBP:

 - int1_ept_test: verifies that ICEBP works correctly when the
   exception stack page is not present (EPT/NPT fault during #DB
   delivery). The IST stack is evicted via MADV_DONTNEED before
   executing INT1.

 - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
   task gate, exercising the legacy task-switch path for #DB.

Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
of after it. With the fix, both tests pass on both platforms.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/svm.c                        |  21 ++
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/x86/int1_ept_test.c | 116 +++++++
 .../selftests/kvm/x86/int1_task_gate_test.c   | 298 ++++++++++++++++++
 4 files changed, 437 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/int1_ept_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/int1_task_gate_test.c

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..a820d47a4bca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1159,6 +1159,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool ini=
t_event)
 	svm_set_intercept(svm, INTERCEPT_SKINIT);
 	svm_set_intercept(svm, INTERCEPT_WBINVD);
 	svm_set_intercept(svm, INTERCEPT_XSETBV);
+	svm_set_intercept(svm, INTERCEPT_ICEBP);
 	svm_set_intercept(svm, INTERCEPT_RDPRU);
 	svm_set_intercept(svm, INTERCEPT_RSM);
=20
@@ -2045,6 +2046,25 @@ static int bp_interception(struct kvm_vcpu *vcpu)
 	return 0;
 }
=20
+static int icebp_interception(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * ICEBP (INT1, opcode 0xF1) generates #DB as a trap. Intercept it
+	 * unconditionally so that RIP is advanced past the instruction
+	 * *before* #DB is injected. This is necessary because SVM reports
+	 * the wrong RIP for ICEBP-induced #DB when delivered via a task
+	 * gate: RIP points at the ICEBP instruction instead of after it.
+	 *
+	 * By intercepting ICEBP, NRIP (next_rip) gives us the correct
+	 * post-instruction RIP. Advancing RIP first and then injecting #DB
+	 * ensures consistent behaviour regardless of how the guest's IDT
+	 * delivers the exception.
+	 */
+	svm_skip_emulated_instruction(vcpu);
+	kvm_queue_exception(vcpu, DB_VECTOR);
+	return 1;
+}
+
 static int ud_interception(struct kvm_vcpu *vcpu)
 {
 	return handle_ud(vcpu);
@@ -3333,6 +3353,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vc=
pu *vcpu) =3D {
 	[SVM_EXIT_MONITOR]			=3D kvm_emulate_monitor,
 	[SVM_EXIT_MWAIT]			=3D kvm_emulate_mwait,
 	[SVM_EXIT_XSETBV]			=3D kvm_emulate_xsetbv,
+	[SVM_EXIT_ICEBP]			=3D icebp_interception,
 	[SVM_EXIT_RDPRU]			=3D kvm_handle_invalid_op,
 	[SVM_EXIT_EFER_WRITE_TRAP]		=3D efer_trap,
 	[SVM_EXIT_CR0_WRITE_TRAP]		=3D cr_trap,
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 9118a5a51b89..1b89bf0e5cf1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -86,6 +86,8 @@ TEST_GEN_PROGS_x86 +=3D x86/hyperv_features
 TEST_GEN_PROGS_x86 +=3D x86/hyperv_ipi
 TEST_GEN_PROGS_x86 +=3D x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 +=3D x86/hyperv_tlb_flush
+TEST_GEN_PROGS_x86 +=3D x86/int1_ept_test
+TEST_GEN_PROGS_x86 +=3D x86/int1_task_gate_test
 TEST_GEN_PROGS_x86 +=3D x86/kvm_clock_test
 TEST_GEN_PROGS_x86 +=3D x86/kvm_pv_test
 TEST_GEN_PROGS_x86 +=3D x86/kvm_buslock_test
diff --git a/tools/testing/selftests/kvm/x86/int1_ept_test.c b/tools/testin=
g/selftests/kvm/x86/int1_ept_test.c
new file mode 100644
index 000000000000..1ced77ffeeb9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/int1_ept_test.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that KVM correctly handles an EPT/NPT fault during delivery of
+ * a #DB exception caused by INT1 (ICEBP, opcode 0xF1).
+ *
+ * The guest executes INT1, which generates #DB. The IDT entry for #DB
+ * uses IST1, pointing to a stack page whose backing has been evicted
+ * via MADV_DONTNEED. The CPU takes an EPT/NPT violation when pushing
+ * the exception frame. KVM must handle the fault and reinject #DB.
+ */
+#include <sys/mman.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define IST_STACK_GPA	0xd0000000ull
+#define IST_STACK_SIZE	PAGE_SIZE
+/* IST1 offset in the 64-bit TSS */
+#define TSS64_IST1_OFFSET	0x24
+
+static volatile bool db_handler_called;
+static volatile u64 db_handler_rip;
+
+static void guest_db_handler(struct ex_regs *regs)
+{
+	db_handler_called =3D true;
+	db_handler_rip =3D regs->rip;
+}
+
+static void guest_code(void)
+{
+	unsigned long expected_rip;
+
+	db_handler_called =3D false;
+
+	/*
+	 * Execute INT1 (ICEBP). This generates #DB as a trap, so RIP
+	 * in the exception frame points after the 0xF1 byte.
+	 */
+	asm volatile("lea 1f(%%rip), %0\n\t"
+		     ".byte 0xf1\n\t"
+		     "1:"
+		     : "=3Dr"(expected_rip) :: "memory");
+
+	GUEST_ASSERT(db_handler_called);
+	GUEST_ASSERT_EQ(db_handler_rip, expected_rip);
+	GUEST_SYNC(0);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	void *ist_hva;
+	unsigned int nr_pages;
+	struct idt_entry *idt;
+
+	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/* Install #DB handler using the normal exception handler table */
+	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
+
+	/*
+	 * Allocate a separate stack page for IST1. Map it into the guest
+	 * so the IDT entry can reference it.
+	 */
+	nr_pages =3D vm_calc_num_guest_pages(VM_MODE_DEFAULT, IST_STACK_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    IST_STACK_GPA, 1, nr_pages, 0);
+	virt_map(vm, IST_STACK_GPA, IST_STACK_GPA, nr_pages);
+	ist_hva =3D addr_gpa2hva(vm, IST_STACK_GPA);
+
+	/*
+	 * Write IST1 in the TSS to point to the top of the IST stack.
+	 * TSS64 layout: offset 0x24 =3D IST1 (8 bytes).
+	 */
+	{
+		void *tss_hva =3D addr_gva2hva(vm, vm->arch.tss);
+		u64 ist1_val =3D IST_STACK_GPA + IST_STACK_SIZE;
+
+		memcpy(tss_hva + TSS64_IST1_OFFSET, &ist1_val, sizeof(ist1_val));
+	}
+
+	/*
+	 * Set the #DB IDT entry to use IST1. The handler address stays
+	 * the same (the framework's idt_handlers stub for vector 1).
+	 */
+	idt =3D (struct idt_entry *)addr_gva2hva(vm, vm->arch.idt);
+	idt[DB_VECTOR].ist =3D 1;
+
+	/*
+	 * Evict the IST stack page from the EPT/NPT so that when the CPU
+	 * tries to push the #DB exception frame, it takes an EPT violation.
+	 */
+	madvise(ist_hva, IST_STACK_SIZE, MADV_DONTNEED);
+
+	/* Run the guest =E2=80=94 it should execute INT1, fault, get reinjected,=
 succeed */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_SYNC:
+		pr_info("INT1 with EPT fault on IST stack: PASSED\n");
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall");
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/int1_task_gate_test.c b/tools/=
testing/selftests/kvm/x86/int1_task_gate_test.c
new file mode 100644
index 000000000000..4485445ee39d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/int1_task_gate_test.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test ICEBP (INT1) with a 32-bit task gate for #DB delivery.
+ *
+ * On SVM, when ICEBP causes #DB and #DB is delivered via a task gate,
+ * the saved RIP points at the ICEBP instruction rather than after it.
+ * This is a hardware quirk that the hypervisor must work around by
+ * intercepting ICEBP and advancing RIP before the task switch.
+ *
+ * This test sets up a 32-bit protected mode guest with:
+ *   - A #DB IDT entry configured as a task gate (type 5)
+ *   - A TSS for the #DB handler task
+ *   - Guest code that executes ICEBP (0xF1)
+ *
+ * The #DB handler task records the EIP from the back-link TSS and
+ * writes it to a known memory location. The test verifies that EIP
+ * points after the ICEBP instruction, not at it.
+ */
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/kvm.h>
+
+#define KVM_DEV	"/dev/kvm"
+#define PAGE_SIZE 4096
+
+/* Guest physical memory layout (all below 1MB for simplicity) */
+#define GDT_BASE	0x1000
+#define IDT_BASE	0x2000
+#define MAIN_TSS_BASE	0x3000
+#define DB_TSS_BASE	0x4000
+#define CODE_BASE	0x5000
+#define RESULT_BASE	0x6000
+#define MAIN_STACK	0x8000	/* top of main task stack */
+#define DB_STACK	0x9000	/* top of #DB task stack */
+
+/* GDT selectors */
+#define SEL_CODE32	0x08
+#define SEL_DATA32	0x10
+#define SEL_MAIN_TSS	0x18
+#define SEL_DB_TSS	0x20
+
+/* 32-bit GDT entry */
+struct gdt_entry {
+	u16 limit_lo;
+	u16 base_lo;
+	u8  base_mid;
+	u8  access;
+	u8  limit_hi_flags;
+	u8  base_hi;
+} __attribute__((packed));
+
+/* 32-bit IDT task gate entry */
+struct idt_task_gate {
+	u16 reserved0;
+	u16 tss_selector;
+	u8  reserved1;
+	u8  type_attr;	/* P=3D1, DPL=3D0, type=3D0x5 (task gate) */
+	u16 reserved2;
+} __attribute__((packed));
+
+/* 32-bit TSS */
+struct tss32 {
+	u16 back_link, __blh;
+	u32 esp0;
+	u16 ss0, __ss0h;
+	u32 esp1;
+	u16 ss1, __ss1h;
+	u32 esp2;
+	u16 ss2, __ss2h;
+	u32 cr3;
+	u32 eip;
+	u32 eflags;
+	u32 eax, ecx, edx, ebx;
+	u32 esp, ebp, esi, edi;
+	u16 es, __esh;
+	u16 cs, __csh;
+	u16 ss, __ssh;
+	u16 ds, __dsh;
+	u16 fs, __fsh;
+	u16 gs, __gsh;
+	u16 ldt, __ldth;
+	u16 trace;
+	u16 iomap_base;
+} __attribute__((packed));
+
+static void set_gdt_entry(struct gdt_entry *e, u32 base, u32 limit,
+			  u8 access, u8 flags)
+{
+	e->limit_lo =3D limit & 0xffff;
+	e->base_lo =3D base & 0xffff;
+	e->base_mid =3D (base >> 16) & 0xff;
+	e->access =3D access;
+	e->limit_hi_flags =3D ((limit >> 16) & 0xf) | (flags << 4);
+	e->base_hi =3D (base >> 24) & 0xff;
+}
+
+/*
+ * Guest code (32-bit protected mode, assembled as bytes).
+ *
+ * The main task executes ICEBP. The #DB task gate switches to the
+ * DB handler TSS. The DB handler reads the back-link TSS to get the
+ * saved EIP, writes it to RESULT_BASE, then halts.
+ */
+
+/* Main task code: just execute ICEBP then halt */
+static const u8 main_code[] =3D {
+	0xf1,			/* ICEBP (INT1) */
+	0xf4,			/* HLT - should not reach here if task gate works */
+};
+
+/*
+ * #DB handler task code:
+ *   - Read back_link from our TSS (at DB_TSS_BASE offset 0) to get main T=
SS selector
+ *   - The main TSS (at MAIN_TSS_BASE) has saved EIP at offset 0x20
+ *   - Read that EIP and store at RESULT_BASE
+ *   - Store 0xCAFE at RESULT_BASE+4 as "handler ran" marker
+ *   - HLT
+ */
+static const u8 db_handler_code[] =3D {
+	/* mov eax, [MAIN_TSS_BASE + 0x20]  -- saved EIP in main TSS */
+	0xa1, (MAIN_TSS_BASE + 0x20) & 0xff, ((MAIN_TSS_BASE + 0x20) >> 8) & 0xff=
, 0x00, 0x00,
+	/* mov [RESULT_BASE], eax */
+	0xa3, RESULT_BASE & 0xff, (RESULT_BASE >> 8) & 0xff, 0x00, 0x00,
+	/* mov dword [RESULT_BASE+4], 0xCAFE */
+	0xc7, 0x05, (RESULT_BASE + 4) & 0xff, ((RESULT_BASE + 4) >> 8) & 0xff, 0x=
00, 0x00,
+	0xfe, 0xca, 0x00, 0x00,
+	/* hlt */
+	0xf4,
+};
+
+#define DB_HANDLER_OFFSET 0x100	/* offset within CODE_BASE page */
+
+static int kvm_ioctl(int fd, unsigned long cmd, void *arg)
+{
+	int ret =3D ioctl(fd, cmd, arg);
+	if (ret < 0) {
+		perror("KVM ioctl");
+		exit(1);
+	}
+	return ret;
+}
+
+int main(void)
+{
+	int kvm_fd, vm_fd, vcpu_fd;
+	struct kvm_userspace_memory_region region;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_run *run;
+	void *mem;
+	size_t mmap_size;
+	struct gdt_entry *gdt;
+	struct idt_task_gate *idt;
+	struct tss32 *main_tss, *db_tss;
+	u32 *result;
+	u32 expected_eip;
+
+	kvm_fd =3D open(KVM_DEV, O_RDWR);
+	if (kvm_fd < 0) { perror("open /dev/kvm"); return 1; }
+
+	vm_fd =3D kvm_ioctl(kvm_fd, KVM_CREATE_VM, 0);
+	vcpu_fd =3D kvm_ioctl(vm_fd, KVM_CREATE_VCPU, 0);
+
+	/* Allocate guest memory =E2=80=94 single 1MB region */
+	mem =3D mmap(NULL, 0x100000, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (mem =3D=3D MAP_FAILED) { perror("mmap"); return 1; }
+	memset(mem, 0, 0x100000);
+
+	region =3D (struct kvm_userspace_memory_region){
+		.slot =3D 0,
+		.guest_phys_addr =3D 0,
+		.memory_size =3D 0x100000,
+		.userspace_addr =3D (u64)mem,
+	};
+	kvm_ioctl(vm_fd, KVM_SET_USER_MEMORY_REGION, &region);
+
+	/* Set up GDT */
+	gdt =3D (struct gdt_entry *)(mem + GDT_BASE);
+	/* Null descriptor */
+	memset(&gdt[0], 0, sizeof(gdt[0]));
+	/* Code32: base=3D0, limit=3D0xfffff, 32-bit, present, code r/x */
+	set_gdt_entry(&gdt[1], 0, 0xfffff, 0x9a, 0xc);
+	/* Data32: base=3D0, limit=3D0xfffff, 32-bit, present, data r/w */
+	set_gdt_entry(&gdt[2], 0, 0xfffff, 0x92, 0xc);
+	/* Main TSS: base=3DMAIN_TSS_BASE, limit=3Dsizeof(tss32)-1, present, TSS3=
2 available */
+	set_gdt_entry(&gdt[3], MAIN_TSS_BASE, sizeof(struct tss32) - 1, 0x89, 0x0=
);
+	/* DB TSS: base=3DDB_TSS_BASE, limit=3Dsizeof(tss32)-1, present, TSS32 av=
ailable */
+	set_gdt_entry(&gdt[4], DB_TSS_BASE, sizeof(struct tss32) - 1, 0x89, 0x0);
+
+	/* Set up IDT =E2=80=94 task gate for #DB (vector 1) */
+	idt =3D (struct idt_task_gate *)(mem + IDT_BASE);
+	idt[1].tss_selector =3D SEL_DB_TSS;
+	idt[1].type_attr =3D 0x85;  /* P=3D1, DPL=3D0, type=3D5 (32-bit task gate=
) */
+
+	/* Set up main TSS */
+	main_tss =3D (struct tss32 *)(mem + MAIN_TSS_BASE);
+	main_tss->cr3 =3D 0;  /* no paging */
+	main_tss->eip =3D CODE_BASE;
+	main_tss->eflags =3D 0x02;
+	main_tss->esp =3D MAIN_STACK;
+	main_tss->cs =3D SEL_CODE32;
+	main_tss->ds =3D SEL_DATA32;
+	main_tss->es =3D SEL_DATA32;
+	main_tss->ss =3D SEL_DATA32;
+	main_tss->fs =3D SEL_DATA32;
+	main_tss->gs =3D SEL_DATA32;
+
+	/* Set up #DB handler TSS */
+	db_tss =3D (struct tss32 *)(mem + DB_TSS_BASE);
+	db_tss->cr3 =3D 0;
+	db_tss->eip =3D CODE_BASE + DB_HANDLER_OFFSET;
+	db_tss->eflags =3D 0x02;
+	db_tss->esp =3D DB_STACK;
+	db_tss->cs =3D SEL_CODE32;
+	db_tss->ds =3D SEL_DATA32;
+	db_tss->es =3D SEL_DATA32;
+	db_tss->ss =3D SEL_DATA32;
+	db_tss->fs =3D SEL_DATA32;
+	db_tss->gs =3D SEL_DATA32;
+
+	/* Copy guest code */
+	memcpy(mem + CODE_BASE, main_code, sizeof(main_code));
+	memcpy(mem + CODE_BASE + DB_HANDLER_OFFSET, db_handler_code, sizeof(db_ha=
ndler_code));
+
+	/* Expected EIP: after the 0xF1 byte */
+	expected_eip =3D CODE_BASE + 1;
+
+	/* Set up vCPU registers for 32-bit protected mode (no paging) */
+	kvm_ioctl(vcpu_fd, KVM_GET_SREGS, &sregs);
+	sregs.cr0 =3D 0x11;  /* PE + ET, no PG */
+	sregs.cr3 =3D 0;
+	sregs.cr4 =3D 0;
+
+	sregs.gdt.base =3D GDT_BASE;
+	sregs.gdt.limit =3D 5 * 8 - 1;
+	sregs.idt.base =3D IDT_BASE;
+	sregs.idt.limit =3D 256 * 8 - 1;
+
+	sregs.cs.base =3D 0; sregs.cs.limit =3D 0xfffff; sregs.cs.selector =3D SE=
L_CODE32;
+	sregs.cs.type =3D 0xb; sregs.cs.present =3D 1; sregs.cs.db =3D 1; sregs.c=
s.s =3D 1; sregs.cs.g =3D 1;
+	sregs.ds.base =3D 0; sregs.ds.limit =3D 0xfffff; sregs.ds.selector =3D SE=
L_DATA32;
+	sregs.ds.type =3D 3; sregs.ds.present =3D 1; sregs.ds.db =3D 1; sregs.ds.=
s =3D 1; sregs.ds.g =3D 1;
+	sregs.es =3D sregs.ss =3D sregs.fs =3D sregs.gs =3D sregs.ds;
+
+	sregs.tr.base =3D MAIN_TSS_BASE; sregs.tr.limit =3D sizeof(struct tss32) =
- 1;
+	sregs.tr.selector =3D SEL_MAIN_TSS; sregs.tr.type =3D 0xb; /* 32-bit TSS =
busy */
+	sregs.tr.present =3D 1;
+
+	kvm_ioctl(vcpu_fd, KVM_SET_SREGS, &sregs);
+
+	memset(&regs, 0, sizeof(regs));
+	regs.rip =3D CODE_BASE;
+	regs.rsp =3D MAIN_STACK;
+	regs.rflags =3D 0x02;
+	kvm_ioctl(vcpu_fd, KVM_SET_REGS, &regs);
+
+	/* Run the guest */
+	mmap_size =3D kvm_ioctl(kvm_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
+	run =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, vcpu_fd=
, 0);
+
+	for (int i =3D 0; i < 100; i++) {
+		kvm_ioctl(vcpu_fd, KVM_RUN, 0);
+
+		if (run->exit_reason =3D=3D KVM_EXIT_HLT)
+			break;
+
+		if (run->exit_reason !=3D KVM_EXIT_INTERNAL_ERROR &&
+		    run->exit_reason !=3D KVM_EXIT_DEBUG) {
+			fprintf(stderr, "Unexpected exit reason: %d\n", run->exit_reason);
+			return 1;
+		}
+	}
+
+	/* Check results */
+	result =3D (u32 *)(mem + RESULT_BASE);
+	if (result[1] !=3D 0xCAFE) {
+		fprintf(stderr, "FAIL: #DB handler did not run (marker=3D0x%x)\n", resul=
t[1]);
+		return 1;
+	}
+
+	printf("Saved EIP: 0x%x, expected: 0x%x\n", result[0], expected_eip);
+	if (result[0] =3D=3D expected_eip) {
+		printf("PASS: EIP points after ICEBP\n");
+		return 0;
+	} else if (result[0] =3D=3D expected_eip - 1) {
+		printf("FAIL: EIP points AT ICEBP (known SVM bug with task gates)\n");
+		return 1;
+	} else {
+		printf("FAIL: EIP is unexpected\n");
+		return 1;
+	}
+}
--=20
2.43.0



--=-U6jXKNSRi78+HB71c55e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzExMjIy
NFowLwYJKoZIhvcNAQkEMSIEIIA65NWUvK6MWwGVhh4utLwrLgE0GBrUtA1A+ZTH7y7VMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAIpi/fkXFhYPC
83EiPo0LmtzhG6OYxxbeCuSPp5rCL19I05cWAqU88H3Rczl8rOV8VaiNfHrat9pudRm2YldpOKcC
jPzBfMkWpLS3kMz432h1SpOpwZ8gYzxk7HKWrDJ0za0eT4Mf01PefuFrTsvAPtnMQG9kBzcoK4Dr
o6qD/8soM7maUCaAHBXrSlV2H+rJt8by8EZ2vuPxI0lkkLa4RWcmhghuDe3+g8nwH7gxF9qx3PCN
k6KSEN8EwbHh8iPsmsnBJljxSVeBUc4PNpnHndiu9YI8wjZwwB5afpiPffFoRadhZk6w3zBomLqh
AxzRDZNRIsFoeE7a4tLlZByiARvdiEX5JALL3Y8Pj1fZ2PbPp8ZwOzsLvSGJLAcaLRfEmiibzOGA
rDk2+RvJ99X7BowYUkHqhpavAP+vr2GhE2aPb8VLeyJ+fAwEZ2yOeOg5uUM6kPOV0LojnKEcX9tE
GF4n87PFLJKHnKAY0F+m2qeyniM2Z/327EhUPhjtDO+Jq5TJeyDYFzvd/YJTIccwcaKUloYOBRZe
31M0pIeTSKdjeuqq7wA+PTmxy6m7WiR0z/qJcjfUd23M/m3Id8FLB/aC8n+Pcx3bgYJ3GaLwp/p+
r5kBDe87FRbIJoyxpZ+yA8YXJ8JKebUO/fg83OolQLzSQuKgj8w22Bri4/DhSp0AAAAAAAA=


--=-U6jXKNSRi78+HB71c55e--
