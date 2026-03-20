Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D88175A7D;
	Fri, 20 Mar 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968565; cv=none; b=j+KgGeMZ6y0YG1PbuSUDsjc5Ja6yqKUJiIyS/tEjak+5V1fU++NAPMx7dSC7rAlOf8uy+/MaZGgyluuh7QCbqcl8enyRJyrXc1DZC4ElZjJmgRlGh4oDhBn7OsDh4MiLM4yd7CPgW2dtq4H4TzMTDzf5r6uRA+xvjdWqzKLByoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968565; c=relaxed/simple;
	bh=4SS+jRPo+mMSIJsPPWjKWTBUrpM34TQ1f+7OfQ+w/Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK0qTBlba2i2Tjlru+JlQg+gJvP+VPQwV39XPHfkYwLzjrSsLQkO4jdTNVIhNRiNBD2suYXsiPTE3fKI0Dx1umKisj8B6T6v1W9HDBpcET6MVsyuTOQTtFJSn3AVfZWBkaGZKbandJrf+uHo2QG86AXmgoZkeqPk0iVY1M6+Lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABngdidnLxpInAyCw--.38047S2;
	Fri, 20 Mar 2026 09:02:22 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: atish.patra@linux.dev
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	jiakaiPeanut@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	xujiakai2025@iscas.ac.cn
Subject: Re: [PATCH] RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask()
Date: Fri, 20 Mar 2026 01:02:21 +0000
Message-Id: <20260320010221.1052724-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <27ce6795-1bb2-437f-a3a9-0589c1d65cdc@linux.dev>
References: <27ce6795-1bb2-437f-a3a9-0589c1d65cdc@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABngdidnLxpInAyCw--.38047S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw17uFyxur45CFWDJw1rtFb_yoWxZr4rpr
	WUGF1UGr4rJFn7Gw12ywn8Xr1UKr4jk3W3Jr1UtryUtF1DKw18Zr95Kry7AryDJFyvvFy7
	tryDWFWvkFW5JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwkMCWm8kisfWwAAsj

> > When a guest initiates an SBI_EXT_PMU_COUNTER_CFG_MATCH call with
> > ctr_base=0xfffffffffffffffe, ctr_mask=0xeb5f and flags=0x1
> > (SBI_PMU_CFG_FLAG_SKIP_MATCH), kvm_riscv_vcpu_pmu_ctr_cfg_match()
> > first invokes kvm_pmu_validate_counter_mask() to verify whether
> > ctr_base and ctr_mask are valid, by evaluating:
> >   !ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu))
> >
> > With the above inputs, __fls(0xeb5f) equals 15, and adding 15 to
> > 0xfffffffffffffffe causes an integer overflow, wrapping around to 13.
> > Since 13 is less than kvm_pmu_num_counters(), the validation wrongly
> > succeeds.
> >
> > Thereafter, since flags & SBI_PMU_CFG_FLAG_SKIP_MATCH is satisfied,
> > the code evaluates:
> >   !test_bit(ctr_base + __ffs(ctr_mask), kvpmu->pmc_in_use)
> >
> > Here __ffs(0xeb5f) equals 0, so test_bit() receives 0xfffffffffffffffe
> > as the bit index and attempts to access the corresponding element of
> > the kvpmu->pmc_in_use, which results in an invalid memory access. This
> > triggers the following Oops:
> >   Unable to handle kernel paging request at virtual address e3ebffff12abba89
> >    generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128
> >    kvm_riscv_vcpu_pmu_ctr_cfg_match arch/riscv/kvm/vcpu_pmu.c:758
> >    kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:49
> >    kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
> >    kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
> >
> > The root cause is that kvm_pmu_validate_counter_mask() does not account
> > for the case where ctr_base itself is out of range, allowing the
> > subsequent addition to silently overflow and bypass the check.
> >
> > Fix this by explicitly validating ctr_base against kvm_pmu_num_counters()
> > before performing the addition.
> >
> > This bug was found by fuzzing the KVM RISC-V PMU interface.
> 
> Thanks for fuzzing. Do you have a detailed report that you can share ?

Yes, here is the detailed crash report:

Unable to handle kernel paging request at virtual address e3ebffff12abba89
Current syz.4.5087 pgtable: 4K pagesize, 57-bit VAs, pgdp=0x0000000130cbc000
[e3ebffff12abba89] pgd=000000005fff6001, p4d=000000005fff5801, pud=000000005fff5401, pmd=000000005b4000e7
Oops [#1]
Modules linked in:
CPU: 3 UID: 0 PID: 5789 Comm: syz.4.5087 Tainted: G        W           7.0.0-rc2-00014-gc61ec3e8cc5d #1 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
epc : kvm_riscv_vcpu_pmu_ctr_cfg_match+0x31a/0xe12 arch/riscv/kvm/vcpu_pmu.c:758
 ra : kvm_riscv_vcpu_pmu_ctr_cfg_match+0x2ee/0xe12 arch/riscv/kvm/vcpu_pmu.c:758
epc : ffffffff8012f320 ra : ffffffff8012f2f4 sp : ff200000067275c0
 gp : ffffffff8a382bc0 tp : ff60000095d03500 t0 : ff200000067276e0
 t1 : fffffffff3f3f3f3 t2 : 0000000200004520 s0 : ff200000067277c0
 s1 : ff20000006727740 a0 : 0000000000000007 a1 : 0000000000000000
 a2 : 0000000000080000 a3 : 03ec000012abba89 a4 : fffffffffffffffe
 a5 : e3ebffff12abba89 a6 : 0000000000000003 a7 : ffe3ffff00ce4ec4
 s2 : 1f600000955dd448 s3 : ff600000955dace0 s4 : 0000000000000001
 s5 : 0000000000000000 s6 : ff20000006727850 s7 : 0000000000000004
 s8 : fffffffffffffffe s9 : 0000000000000000 s10: 1fe4000000ce4ec4
 s11: 0000000000000003 t3 : cbdd65f600000000 t4 : 0000000000000000
 t5 : 0000000000000000 t6 : 0000000000000000 ssp : 0000000000000000
status: 0000000200000120 badaddr: e3ebffff12abba89 cause: 000000000000000d
[<ffffffff8012f320>] generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
[<ffffffff8012f320>] kvm_riscv_vcpu_pmu_ctr_cfg_match+0x31a/0xe12 arch/riscv/kvm/vcpu_pmu.c:758
[<ffffffff80136b12>] kvm_sbi_ext_pmu_handler+0x266/0x630 arch/riscv/kvm/vcpu_sbi_pmu.c:49
[<ffffffff80133636>] kvm_riscv_vcpu_sbi_ecall+0x11c/0x2f8 arch/riscv/kvm/vcpu_sbi.c:608
[<ffffffff80122e50>] kvm_riscv_vcpu_exit+0x7b2/0x9ba arch/riscv/kvm/vcpu_exit.c:240
[<ffffffff8011fa6e>] kvm_arch_vcpu_ioctl_run+0x13c6/0x3600 arch/riscv/kvm/vcpu.c:1008
[<ffffffff800da0ae>] kvm_vcpu_ioctl+0x532/0x13e0 virt/kvm/kvm_main.c:4476
[<ffffffff80d25228>] vfs_ioctl fs/ioctl.c:51 [inline]
[<ffffffff80d25228>] __do_sys_ioctl fs/ioctl.c:597 [inline]
[<ffffffff80d25228>] __se_sys_ioctl fs/ioctl.c:583 [inline]
[<ffffffff80d25228>] __riscv_sys_ioctl+0x180/0x1e4 fs/ioctl.c:583
[<ffffffff80078fc2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff86693a68>] do_trap_ecall_u+0x39e/0x62e arch/riscv/kernel/traps.c:344
[<ffffffff866be63e>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
Code: 9793 0036 993e 07b7 e000 17fd 5693 0039 1782 97b6 (c783) 0007 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	00369793          	slli	a5,a3,0x3
   4:	993e                	add	s2,s2,a5
   6:	e00007b7          	lui	a5,0xe0000
   a:	17fd                	addi	a5,a5,-1 # 0xffffffffdfffffff
   c:	00395693          	srli	a3,s2,0x3
  10:	1782                	slli	a5,a5,0x20
  12:	97b6                	add	a5,a5,a3
* 14:	0007c783          	lbu	a5,0(a5) <-- trapping instruction

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

SYZFAIL: failed to recv rpc
fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

> 
> > Fixes: 0cb74b65d2e5e6 ("RISC-V: KVM: Implement perf support without sampling")
> > Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> > Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> > ---
> >   arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index e873430e596b2..a098a9b417ad8 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -266,8 +266,10 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> >   static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ctr_base,
> >   					 unsigned long ctr_mask)
> >   {
> > -	/* Make sure the we have a valid counter mask requested from the caller */
> > -	if (!ctr_mask || (ctr_base + __fls(ctr_mask) >= kvm_pmu_num_counters(kvpmu)))
> > +	unsigned long num_ctrs = kvm_pmu_num_counters(kvpmu);
> > +
> > +	/* Make sure we have a valid counter mask requested from the caller */
> > +	if (!ctr_mask || ctr_base >= num_ctrs || (ctr_base + __fls(ctr_mask) >= num_ctrs))
> >   		return -EINVAL;
> >   
> >   	return 0;
> 
> Thanks for the fix.
> 
> Reviewed-by: Atish Patra <atish.patra@linux.dev>

Thanks for the review!

Regards,
Jiakai

