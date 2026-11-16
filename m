Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794791455;
	b=TDYwrwQvekvDHawmm9MPI/QyA0cQ89XgL3XtVApvVNKaIZBhBWuJ6MzZtTpLOdf3nYqS
	 YADS1vu4qU1n6zeVHqflS4bKGDKzSFLtssbC+AFYVnHxcl2pQkyknEzCPY0a+uxyr0bNC
	 Q02OX//QR4d/aiN/FnhxW4YEnlTi04oc9GAxD8DLagrXoL+7/RIFX/PeCmTlWc6SnT+5j
	 5H76jNetpNz6n4TsM65OQgjU5amwm5baTEXi3oI//qDOyywXGHc6ljvAagkg6tGQZ6G9m
	 eX5U0CEX145tmw7x3GRW99xc0oTjG68oGfC64ne8a5vEQWRyAkjlASIDyZ8Y+9j3i6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794791455;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=lhioPZdrg6ehG82EdncwrlUWsJrKi85IbXPZWP6O8F0=;
	b=NiR+d+1rQ9O+CIqcMERvi1yK/79QBgPXTOODiq0vmZJjzsTO7STd7qHDpYdYa23qC2Gc
	 bcC9LO508ZLIY5x0knpJA8gXmccO59X8Hq76CzToBo579+Kq08BiPZahz/zU8yBnM7uog
	 5+Tv096jm78Yz8hV1L9bg+0UNeZmFlcZVM4RZDBmepliSdjEzqnSxVlV0fwPLpXdvmxoZ
	 V5+vULB2GvUggG8SwZVOlO2CZYPaaAZnpaUad+jXfY2ufIM+RUDy0QJrKXxQMKzOAfCkH
	 YzgU7N1SU3IhLGKu1X9azXPYjKrtjq53Y7wCip9sUi5gRkP/ccUN5Xa1H9RJBbT+Zhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bi8Ksc8N;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0D606A332
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 01:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A0D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bi8Ksc8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794791455; x=1826327455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eTvb7GqTwI+2+KPPonfctytUf/DK5YzSaz6s/Ai6e18=;
  b=Bi8Ksc8NpGQ485ipQ7xYom4L0KZfBJXjyURIgnLWGHS3swtn3j/OGWtj
   mu1ZdcQLySRxgQPcEdOT0osqndDQ/pJHLqAFnNZxJ13M+rzbZpiYfE7U9
   tCdGeEY+lO+EOQsQPmFrrUcCUQeQb9hIcDh0AmQKMcjMbTDaITxSnJr3p
   VPWssvTiNSO+STL4C6Z9IZPXFEbW/ASuOUzOQRQdrMyI/km1ecG2wSW4o
   1zYiIZbosCGh6hDgY5VpslA3BQ5rFZtsZ6yvlO8U6vXQsqiLL++zg3zyJ
   f+AUyJ5sEhv9SpVzWjRQmDR2sPG2DLr4/ychJPFsKYxpmjwXoTFXkbU4x
   g==;
X-CSE-ConnectionGUID: go+Rfh+PRJi1206ArnT+dQ==
X-CSE-MsgGUID: oT5RTD55QjuD5QLW1TwSIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3517631"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3517631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:10:55 -0800
X-CSE-ConnectionGUID: JA6FGKPHQoCiIx866PnL7g==
X-CSE-MsgGUID: U7+5EfQBRFKzhHjU3f+bCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9573936"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:10:52 -0800
Date: Mon, 16 Nov 2026 09:10:48 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kvm@vger.kernel.org,
	Farrah Chen <farrah.chen@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev,
	yi1.lai@intel.com
Subject: [kvm:kvm-memprot-v4] [KVM]  4764db743f: WARNING:suspicious_RCU_usage
Message-ID: <202611160117.9e3da157-lkp@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 4764db743fe860556eea711a26ef11c74db647d2 ("KVM: Introduce a generation number for memory attributes") https://git.kernel.org/cgit/virt/kvm/kvm.git kvm-memprot-v4

in testcase: kselftests
version: kselftests-x86_64-24a19b953e2a-1_20261012
with following parameters:

	group: kvm


config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611160117.9e3da157-lkp@intel.com



kern  :warn  : [  359.591440] [   T5823] WARNING: suspicious RCU usage
kern  :warn  : [  359.592715] [   T5823] 7.3.0-rc7+ #1 Tainted: G S      W
kern  :warn  : [  359.594141] [   T5823] -----------------------------
kern  :warn  : [  359.595825] [   T5823] include/linux/kvm_host.h:2631 Suspicious memory attribute generation usage
!
kern  :warn  : [  359.598735] [   T5823]
other info that might help us debug this:

kern  :warn  : [  359.603182] [   T5823]
rcu_scheduler_active = 2, debug_locks = 1
kern  :warn  : [  359.606347] [   T5823] locks held by hyperv_evmcs/5823: 0, last CPU#10
kern  :warn  : [  359.607343] [   T5823]
stack backtrace:
kern  :warn  : [  359.610037] [   T5823] CPU: 10 UID: 0 PID: 5823 Comm: hyperv_evmcs Tainted: G S      W           7.3.0-rc7+ #1 PREEMPTLAZY
kern  :warn  : [  359.610042] [   T5823] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
kern  :warn  : [  359.610043] [   T5823] Hardware name: LENOVO 90XW004HPL/336B, BIOS M5LKT1CA 01/06/2025
kern  :warn  : [  359.610045] [   T5823] Call Trace:
kern  :warn  : [  359.610047] [   T5823]  <TASK>
kern  :warn  : [  359.610048] [   T5823]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
kern  :warn  : [  359.610057] [   T5823]  lockdep_rcu_suspicious.cold (locking/lockdep.c:6972)
kern  :warn  : [  359.610062] [   T5823] __kvm_gfn_to_hva_cache_init (linux/kvm_host.h:2631 (discriminator 9) x86/kvm/../../../virt/kvm/kvm_main.c:3675 (discriminator 9)) kvm
kern  :warn  : [  359.610141] [   T5823]  ? kvm_gpc_deactivate (linux/mutex.h:253 x86/kvm/../../../virt/kvm/pfncache.c:454) kvm
kern  :warn  : [  359.610208] [   T5823]  ? lock_acquire (trace/events/lock.h:23 (discriminator 21) locking/lockdep.c:5905 (discriminator 21))
kern  :warn  : [  359.610212] [   T5823]  ? __pfx___kvm_gfn_to_hva_cache_init (x86/kvm/../../../virt/kvm/kvm_main.c:4145) kvm
kern  :warn  : [  359.610276] [   T5823]  ? vmx_vcpu_load_vmcs (x86/kvm/vmx/vmx.c:1514) kvm_intel
kern  :warn  : [  359.610291] [   T5823] kvm_read_guest_offset_cached (x86/kvm/../../../virt/kvm/kvm_main.c:3746) kvm
kern  :warn  : [  359.610389] [   T5823] nested_get_evmptr (x86/kvm/vmx/hyperv.c:21) kvm_intel
kern  :warn  : [  359.610408] [   T5823] nested_vmx_handle_enlightened_vmptrld (x86/kvm/vmx/nested.c:2196) kvm_intel
kern  :warn  : [  359.610430] [   T5823] __nested_vmx_vmexit (x86/kvm/vmx/nested.c:3427 x86/kvm/vmx/nested.c:5093) kvm_intel
kern  :warn  : [  359.610455] [   T5823] nested_vmx_free_vcpu (x86/kvm/vmx/nested.h:46 x86/kvm/vmx/nested.c:6889 x86/kvm/vmx/nested.c:389) kvm_intel
kern  :warn  : [  359.610473] [   T5823] vmx_vcpu_free (x86/kvm/vmx/vmx.c:7521) kvm_intel
kern  :warn  : [  359.610492] [   T5823] kvm_arch_vcpu_destroy (x86/kvm/x86.c:9582) kvm
kern  :warn  : [  359.610598] [   T5823] kvm_destroy_vcpus (x86/kvm/../../../virt/kvm/kvm_main.c:477 x86/kvm/../../../virt/kvm/kvm_main.c:497) kvm
kern  :warn  : [  359.610698] [   T5823]  ? __pfx_kvm_destroy_vcpus (x86/include/asm/smp.h:90) kvm
kern  :warn  : [  359.610797] [   T5823]  ? synchronize_srcu (rcu/srcutree.c:1502 rcu/srcutree.c:1558)
kern  :warn  : [  359.610805] [   T5823] kvm_arch_destroy_vm (x86/kvm/x86.c:10153) kvm
kern  :warn  : [  359.610906] [   T5823] kvm_destroy_vm (x86/kvm/../../../virt/kvm/kvm_main.c:1314) kvm
kern  :warn  : [  359.611013] [   T5823] kvm_vm_stats_release (x86/kvm/../../../virt/kvm/kvm_main.c:5394) kvm
kern  :warn  : [  359.611112] [   T5823]  __fput (file_table.c:512)
kern  :warn  : [  359.611122] [   T5823]  fput_close_sync (file_table.c:618)
kern  :warn  : [  359.611126] [   T5823]  ? __pfx_fput_close_sync (file_table.c:479)
kern  :warn  : [  359.611135] [   T5823]  __x64_sys_close (open.c:1560 open.c:1545 open.c:1545)
kern  :warn  : [  359.611140] [   T5823]  do_syscall_64 (x86/entry/syscall_64.c:61 x86/entry/syscall_64.c:84)
kern  :warn  : [  359.611173] [   T5823]  ? do_syscall_64 (linux/irq-entry-common.h:108 x86/entry/syscall_64.c:81)
kern  :warn  : [  359.611178] [   T5823]  ? do_syscall_64 (x86/entry/syscall_64.c:81 (discriminator 39))
kern  :warn  : [  359.611184] [   T5823]  entry_SYSCALL_64_after_hwframe (x86/entry/entry_64.S:121)
kern  :warn  : [  359.611187] [   T5823] RIP: 0033:0x7fcca72733a7
kern  :warn  : [  359.611191] [   T5823] Code: 48 89 fa 4c 89 df e8 78 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	4c 89 df             	mov    %r11,%rdi
   6:	e8 78 b3 00 00       	call   0xb383
   b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  11:	59                   	pop    %rcx
  12:	5e                   	pop    %rsi
  13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  17:	74 1a                	je     0x33
  19:	5b                   	pop    %rbx
  1a:	c3                   	ret
  1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  22:	00 
  23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  28:	0f 05                	syscall
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  33:	83 e2 39             	and    $0x39,%edx
  36:	83 fa 08             	cmp    $0x8,%edx
  39:	75 de                	jne    0x19
  3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

Code starting with the faulting instruction ===========================================
   0:	5b                   	pop    %rbx
   1:	c3                   	ret
   2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   9:	83 e2 39             	and    $0x39,%edx
   c:	83 fa 08             	cmp    $0x8,%edx
   f:	75 de                	jne    0xffffffffffffffef
  11:	e8 23 ff ff ff       	call   0xffffffffffffff39
kern  :warn  : [  359.611194] [   T5823] RSP: 002b:00007ffecc86c270 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
kern  :warn  : [  359.611198] [   T5823] RAX: ffffffffffffffda RBX: 00007fcca71e3280 RCX: 00007fcca72733a7
kern  :warn  : [  359.611201] [   T5823] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
kern  :warn  : [  359.611202] [   T5823] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [  359.611204] [   T5823] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
kern  :warn  : [  359.611206] [   T5823] R13: 000000001529f270 R14: 000000001529f240 R15: 000000001529f270
kern  :warn  : [  359.611219] [   T5823]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261116/202611160117.9e3da157-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

