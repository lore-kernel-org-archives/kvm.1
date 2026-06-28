Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17415746F
	for <kvm@vger.kernel.org>; Sun, 28 Jun 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671441; cv=none; b=kB/YD5sYh72fmcFHuvcIIpbYJLJnPB6AWWCJren9PBo/XkC/EmQRSnluKHttlIy2p+bsaTNyQc0xmAt206l5k73qp+yQaLBG7y0oORNmXXKyTOwWOsrggECt9u/n5WKTpfIVHE8FRuQvC4XsrgvqCN83VLp693e9DO7eZogu4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671441; c=relaxed/simple;
	bh=7olRA1OWwRnt+hMn4Ias0nfrTgopSu0wZiod1q7BaRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9dZxBs/fwEF4M+D0SALlHJ0ZgpVGat+kIhTJCuczX+PV62yu8cKxht70XtU7yS8lXf6kIhb/+ZwSjkLw2BnhwkLhFW+jLTy6EpJr9boKfH1NQ9lmpLbnztXbiMpOSP5LrskgwGW+Tnc7SXcjJW8D5V4g4JkHuKXiRwpHfTmlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KRCSDBLp; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KRCSDBLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782671426; bh=hau3ggqY9HcRqj/hoZ+vfOqFf/4UpY7B/8XP8+OPS1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KRCSDBLp2oIBFsJMNSzGwrVMyhEIDEDZ2LiR6dIXSihwUdxBo1RbYV2ez4rYbvnD4
	 gLYOPjhf4kaIRM/eswP2jXASIpu1PgCwTSXM6f3KCh0cAlgzKdmvzYTNzZQpqYo1Hu
	 5L0HeuSx/AvFoMu+AbPTaiCni2SH8bJmGsRYunhg=
Received: from [192.168.1.102] ([223.77.180.178])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 79883E56; Mon, 29 Jun 2026 02:30:24 +0800
X-QQ-mid: xmsmtpt1782671424trd52ai99
Message-ID: <tencent_FD175C44E33B0A7C1923AF4772333226E206@qq.com>
X-QQ-XMAILINFO: N91PKLMQLILLiwnE3Nm3UnOcH4aHLgfS8aI4SCNKGVCpJLdAdAnnVVSwW8OEji
	 x1KAGMaxB/j24wtoaVi4frWIfoAdsotfq36GXzR2AmIOrTdTXyZrMaNVy8kCByiS8IOkoWs4cawz
	 fGC8YlHUXk1voy5oZXSUf+cw2+7HTKaMonewEIHFAgji9NcZMW3orsKv5EyoKzWv4pGsRHl05+iJ
	 PEBvq2HtI15+5/eM5Ue8udQDJAf22SFKuwkKvaMVqmXhb5fbn52rGHuAZ4i7slFrrFSJ1E3vyokz
	 tJBetZpJFlfYl1sEPKzW+ZT0Tab8YTchNvQereNID4FUQrEnq+hvHTXlG15T8JHLgkqOGXMYO9xJ
	 ce8QfBqdtFwFp9kc6AhiD0obepzjgAMHfn7Soun7DfUnRmYZmCmWUYToisXT7U9bXwvDr3M8zavU
	 6yWXsXjJ4qcETBvGrwjvaLeHFy0nM/GTL19jhew+T0oOZ+GZsiLV8708SyRkv16CZGU1NNn5ofnK
	 2jZCmOkMZ497ZkH/K7FWsl8cZjCvQv+Pq3TXmdWpxhF2X0C3eiSOF72y/FlHCpazWDk2U7DuvfgQ
	 vRolf0CUA9GW9Me0IpsrAw3nEhNaWtwRy4E+JSc3g8WqeU+Y0nl3XG69xcZH7eAF9RUvCd03LTWT
	 rdfb/QpaEoySxYtsltu6YKGshRZg/U9nJkL8R/XfhaQNncvVWIZsYxCiEISS7RkJDFMM6KTn6ZdK
	 6/x8rSef/3L8keCDJg+wrlqj4SgZITtDz9i9mOtqCFGodtv6vcbtW+suwDsc/14grY2n3bsmaHS1
	 XO07mQe13hKIahXdGjqG3Afuzf2TmKhiKI07rxx8Kfo1mAF5kGji/15HM8jyK4K1mWw4sbNxVMFo
	 S5G4k1chNScwOtOn/5s8w7hexup+BvyLt3Zo7xH/3+1K9bAZIW7ydDAI2aYOj2iRZ32bB+E1sbXW
	 AVYe+IjO2rWvm/+Lem90306l57WkIX4B2yRl4S9p444n08Dj3Y7lv9CgUQsCPpduDXTjHQFGkFF5
	 BpEI7q0g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <2e2a4276-9a13-4a50-8c19-cf246b49e06f@qq.com>
Date: Mon, 29 Jun 2026 02:30:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: SVM: Remove VM from the GA Log notifier list
 before VM destruction
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
References: <20260625220933.3357733-1-seanjc@google.com>
 <20260625220933.3357733-2-seanjc@google.com>
 <20260625222635.A2D461F000E9@smtp.kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260625222635.A2D461F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

Thanks for this patch series! The Sashiko AI review system flagged a
potential issue with this patch, and I was able to reproduce it -- a
KASAN slab-use-after-free triggers when the VM creation error path is
exercised via fault injection.

 > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
 > index 58e493a80cb0..6b100fb014a6 100644
 > --- a/arch/x86/kvm/svm/avic.c
 > +++ b/arch/x86/kvm/svm/avic.c
 > @@ -311,9 +311,18 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
 >      return 0;
 >  }
 >
 > +void avic_vm_pre_destroy(struct kvm *kvm)
 > +{
 > +    if (WARN_ON_ONCE(!enable_apicv))
 > +        return;
 > +
 > +    guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
 > +
 > +    hash_del(&to_kvm_svm(kvm)->hnode);
 > +}

This moves hash_del() out of avic_vm_destroy() and into the new
avic_vm_pre_destroy().  The normal VM teardown path calls both:

   kvm_destroy_vm()
     -> kvm_arch_pre_destroy_vm()   // calls avic_vm_pre_destroy -> hash_del
     -> kvm_destroy_vcpus()
     -> kvm_arch_destroy_vm()       // calls avic_vm_destroy (no hash_del)

However, the error path in kvm_create_vm() does NOT call
kvm_arch_pre_destroy_vm():

   kvm_create_vm()
     -> kvm_arch_init_vm()          // succeeds -> avic_vm_init -> hash_add
     -> kvm_init_mmu_notifier()     // FAILS (e.g., -ENOMEM)
     -> goto out_err_no_mmu_notifier
       -> kvm_arch_destroy_vm()     // avic_vm_destroy -- no longer does 
hash_del
       -> kvm_arch_free_vm()        // frees kvm_svm with hnode still in 
hash

After this, the global svm_vm_data_hash contains a dangling hnode
pointing into freed memory.

--- Reproduction ---

Kernel: 7.1.0-ga868c399eeaa #2 SMP PREEMPT_DYNAMIC
Config: CONFIG_KASAN=y, CONFIG_FAILSLAB=y, CONFIG_KVM_AMD=y,
         CONFIG_FAULT_INJECTION=y, CONFIG_FAULT_INJECTION_DEBUG_FS=y
QEMU:  QEMU Standard PC (Q35 + ICH9, 2009)
Boot:  kvm_amd.avic=1 kvm_amd.force_avic=1 (NPT + AVIC force-enabled)

The PoC uses failslab fault injection to make kvm_init_mmu_notifier()
fail with -ENOMEM after kvm_arch_init_vm() has already succeeded (and
avic_vm_init() has added the VM to the hash table).  Each attempt runs
in a forked child so the mmu_notifier_subscriptions allocation is
always a first-time allocation.

--- KASAN Crash Log ---

[  697.157863][ T9682] BUG: KASAN: slab-use-after-free in 
avic_vm_init+0x352/0x3a0
[  697.159562][ T9682] Write of size 8 at addr ff1100010b75ba20 by task 
poc/9682
[  697.161750][ T9682] CPU: 0 UID: 0 PID: 9682 Comm: poc Tainted: G   
  U  W           7.1.0-ga868c399eeaa #2 PREEMPT(full)
[  697.161888][ T9682] Call Trace:
[  697.161905][ T9682]  <TASK>
[  697.161926][ T9682]  dump_stack_lvl+0x116/0x1f0
[  697.162022][ T9682]  print_report+0xf4/0x600
[  697.162275][ T9682]  kasan_report+0xe0/0x110
[  697.162438][ T9682]  ? avic_vm_init+0x352/0x3a0
[  697.162524][ T9682]  avic_vm_init+0x352/0x3a0
[  697.162602][ T9682]  svm_vm_init+0xc5/0x1c0
[  697.162659][ T9682]  kvm_arch_init_vm+0x19d/0x820
[  697.162819][ T9682]  kvm_dev_ioctl+0xb10/0x1a50
[  697.163422][ T9682]  __x64_sys_ioctl+0x193/0x210
[  697.163479][ T9682]  do_syscall_64+0x129/0x880
[  697.163537][ T9682]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  697.163932][ T9682]  </TASK>
[  697.193129][ T9682] Allocated by task 17750:
[  697.194864][ T9682]  __kvmalloc_node_noprof+0x397/0x920
[  697.195370][ T9682]  kvm_dev_ioctl+0x15d/0x1a50
[  697.196681][ T9682]  __x64_sys_ioctl+0x193/0x210
[  697.196681][ T9682]  do_syscall_64+0x129/0x880
[  697.197226][ T9682]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  697.197445][ T9682] Freed by task 17750:
[  697.199629][ T9682]  kfree+0x171/0x720
[  697.199997][ T9682]  kvm_dev_ioctl+0x5b4/0x1a50
[  697.200881][ T9682]  __x64_sys_ioctl+0x193/0x210
[  697.201310][ T9682]  do_syscall_64+0x129/0x880
[  697.201847][ T9682]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  697.202066][ T9682] The buggy address belongs to the cache 
kmalloc-cg-8k of size 8192
[  697.203320][ T9682] The buggy address is located 6688 bytes inside of
[  697.203320][ T9682]  freed 8192-byte region [ff1100010b75a000, 
ff1100010b75c000)

[  704.158056][ T9682] BUG: unable to handle page fault for address: 
ffa000000278fa20
[  704.159842][ T9682] #PF: supervisor write access in kernel mode
[  704.164220][ T9682] Oops: Oops: 0002 [#1] SMP KASAN NOPTI
[  704.167928][ T9682] RIP: 0010:avic_vm_init+0x29a/0x3a0
[  704.216489][ T9682] Kernel panic - not syncing: Fatal exception

Note the call chain matches the review prediction exactly:
   avic_vm_init -> svm_vm_init -> kvm_arch_init_vm -> kvm_dev_ioctl

The allocation and free are both from kvm_dev_ioctl (KVM_CREATE_VM):
the first VM is freed on the error path, and the second VM creation
tries to traverse svm_vm_data_hash in avic_vm_init(), dereferencing
the freed kvm_svm.

--- PoC ---

Build:  gcc -o poc poc.c -static
Run:    ./poc

The kernel also needs the following boot parameters for AVIC:
   kvm_amd.avic=1 kvm_amd.force_avic=1

// SPDX-License-Identifier: GPL-2.0-only
/*
  * PoC for KVM SVM AVIC dangling pointer bug introduced by commit:
  * "KVM: SVM: Remove VM from the GA Log notifier list before VM 
destruction"
  *
  * BUG DESCRIPTION:
  * The patch moves hash_del() from avic_vm_destroy() to the new
  * avic_vm_pre_destroy().  On the VM creation error path in 
kvm_create_vm():
  *   1. kvm_arch_init_vm() succeeds -> calls avic_vm_init() -> adds to hash
  *   2. kvm_init_mmu_notifier() fails (ENOMEM from failslab on
  *      kzalloc(sizeof(mmu_notifier_subscriptions), GFP_KERNEL_ACCOUNT))
  *   3. kvm_arch_destroy_vm() is called, which calls avic_vm_destroy()
  *      but NOT avic_vm_pre_destroy()
  *   4. kvm_arch_free_vm() frees the kvm_svm with hnode still in hash
  *
  * KEY INSIGHT: The mmu_notifier_subscriptions allocation happens only ONCE
  * per process mm_struct. To try it many times, we must fork a child 
process
  * for each attempt, so each child has a fresh mm without 
notifier_subscriptions.
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kvm.h>
#include <errno.h>

#define KVM_PATH "/dev/kvm"
#define FAILSLAB_PROBABILITY "/sys/kernel/debug/failslab/probability"
#define FAILSLAB_TIMES "/sys/kernel/debug/failslab/times"
#define FAILSLAB_INTERVAL "/sys/kernel/debug/failslab/interval"
#define FAILSLAB_IGNORE_GFP_WAIT 
"/sys/kernel/debug/failslab/ignore-gfp-wait"
#define FAILSLAB_TASK_FILTER "/sys/kernel/debug/failslab/task-filter"

static int write_int(const char *path, int val)
{
     int fd = open(path, O_WRONLY);
     if (fd < 0) return -1;
     char buf[64];
     int len = snprintf(buf, sizeof(buf), "%d", val);
     write(fd, buf, len);
     close(fd);
     return 0;
}

static int write_str(const char *path, const char *val)
{
     int fd = open(path, O_WRONLY);
     if (fd < 0) return -1;
     write(fd, val, strlen(val));
     close(fd);
     return 0;
}

/* Child process: try to create a KVM VM.
  * Returns via exit code: 0=success, 1=ENOMEM failure */
static void try_create_vm(int kvm_fd)
{
     int vm_fd;

     vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);
     if (vm_fd >= 0) {
         close(vm_fd);
         _exit(0);
     }

     if (errno == ENOMEM)
         _exit(1);
     _exit(2);
}

int main(void)
{
     int kvm_fd;
     int iter, status;
     int success = 0, enomem_fails = 0, other_fails = 0;
     pid_t pid;

     setbuf(stdout, NULL);
     setbuf(stderr, NULL);

     fprintf(stderr, "[.] Opening /dev/kvm...\n");
     kvm_fd = open(KVM_PATH, O_RDWR);
     if (kvm_fd < 0) {
         perror("open /dev/kvm");
         return 1;
     }
     fprintf(stderr, "[+] /dev/kvm opened\n");

     fprintf(stderr, "[.] Configuring failslab fault injection...\n");
     if (write_int(FAILSLAB_PROBABILITY, 3) < 0) {
         fprintf(stderr, "[-] Cannot configure failslab\n");
         close(kvm_fd);
         return 1;
     }
     write_int(FAILSLAB_TIMES, 100000000);
     write_int(FAILSLAB_INTERVAL, 1);
     write_str(FAILSLAB_IGNORE_GFP_WAIT, "N");
     write_str(FAILSLAB_TASK_FILTER, "N");
     fprintf(stderr, "[+] Fault injection configured (prob=3%%)\n");

     fprintf(stderr, "[.] Creating VMs in child processes...\n");

     for (iter = 0; iter < 50000; iter++) {
         pid = fork();
         if (pid == 0) {
             try_create_vm(kvm_fd);
         }

         waitpid(pid, &status, 0);

         if (WIFEXITED(status)) {
             int exit_code = WEXITSTATUS(status);
             if (exit_code == 0) {
                 success++;
             } else if (exit_code == 1) {
                 enomem_fails++;
                 fprintf(stderr, "[!] ENOMEM at iter=%d (success=%d, 
enomem=%d)\n",
                     iter, success, enomem_fails);

                 /* After a dangling hash entry was created,
                  * further VMs will trigger use-after-free. */
                 int j;
                 for (j = 0; j < 100; j++) {
                     pid_t pid2 = fork();
                     if (pid2 == 0) {
                         try_create_vm(kvm_fd);
                     }
                     waitpid(pid2, NULL, 0);
                 }
             } else {
                 other_fails++;
             }
         }

         if (iter % 5000 == 0) {
             fprintf(stderr, "[.] iter=%d success=%d enomem=%d other=%d\n",
                 iter, success, enomem_fails, other_fails);
         }
     }

     fprintf(stderr, "[+] FINAL: success=%d enomem=%d other=%d\n",
         success, enomem_fails, other_fails);

     close(kvm_fd);
     return 0;
}

Thanks,
Xiao

