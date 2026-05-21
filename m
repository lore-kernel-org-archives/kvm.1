Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61703346FA7
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355474; cv=none; b=KhJ53B+7tt4Q818Rgyaw4gJv94DmvxN7gQI6zpufcO3vyAyEVlCE752gqW1DYbWSwqhSRMY2hkhyvdNO/6RMTU9X1Dhr9kO2muGTjq9vEgXDJWMKnyvW/wFsv/Y09OtedazDqjOusNCpo1i/lV2bGUZQ6wfcuDUEyTSyCWtDyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355474; c=relaxed/simple;
	bh=3QxB8z2JSbzb9/zZnprEmhvxBLqEcSqpjVqLvCtFuVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2t/ZWPkUSU6wUpiLNblu9dTuNAq64jjWbaHpPbz0tJ52kIfM0vc+ntJScEtLypMZJ0Xp4gfszEVpLlXJR/5zYLB8+Dgttytq0IPlAk82DPUYZge9SXz1QN8koFd2qL6qowvOYQF4XSZDZ9Bbyv5i84J/I9XUklP07A7aP7D2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGWoWFOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGWoWFOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779355471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uE8FmMvI+NG9CUOJRem1SehYzInx7xHuyCKWJbrbYvY=;
	b=aGWoWFOF5o/ORyjIo8Z6FllVj6wJDxZzLmOe2AkXqgkRbOo7UTGS8n9k9cyqSFxFl07Lt2
	SgGpqL7AVsZeNU19hiVJfKfmqIGtkkr1f3wwthSkZd9P97kMHzqBE9UzvwcUAzsqCQ5oIK
	/GGoo5PVbeOhQP5Nt6VGiGprg51Nv4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-SHYlFXirNuSmsIs1JDVZWQ-1; Thu,
 21 May 2026 05:24:27 -0400
X-MC-Unique: SHYlFXirNuSmsIs1JDVZWQ-1
X-Mimecast-MFC-AGG-ID: SHYlFXirNuSmsIs1JDVZWQ_1779355466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48E831956095;
	Thu, 21 May 2026 09:24:26 +0000 (UTC)
Received: from [10.44.49.252] (unknown [10.44.49.252])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C00B718001EF;
	Thu, 21 May 2026 09:24:24 +0000 (UTC)
Message-ID: <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
Date: Thu, 21 May 2026 11:24:23 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf
 functions
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 5/14/26 23:04, Sean Christopherson wrote:
> Finally re-posting Mathias' work to provide better backtraces on x86, which
> was blocked by a fatal bug in the nVMX SIPI test that was exposed by the
> stack frame side effects.  This has been sitting on my local system(s) for
> something like 5 months, and I all but forgot I hadn't posted it.
> 
> Most of this series is cleaning up the nVMX and nSVM to play nice with
> multi-CPU tests.  Then to fix the race in the problematic SIPI, abuse the
> VM-Entry MSR load list to atomically detect VM-Enter (I'm still proud of
> that hack).
> 
> For gory details:
> 
> https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net

I'm applying patches 1-18, adding the last two give

gcc -mno-red-zone -mno-sse -mno-sse2  -fcf-protection=full -m16 -O1 -g 
-MMD -MP -MF x86/.realmode.d -fno-strict-aliasing -fno-common -Wall 
-Wwrite-strings -Wempty-body -Wuninitialized -Wignored-qualifiers 
-Wno-missing-braces -Werror  -fno-omit-frame-pointer 
-fno-stack-protector    -Wno-frame-address   -fno-pic  -Wclobbered 
-Wunused-but-set-parameter  -Wno-override-init  -Wmissing-parameter-type 
  -Wold-style-declaration -Wmissing-prototypes -Wstrict-prototypes  -pg 
-mnop-mcount -std=gnu99 -ffreestanding -I 
/home/pbonzini/work/upstream/kvm-unit-tests/lib -I 
/home/pbonzini/work/upstream/kvm-unit-tests/lib/x86 -I lib -Os 
-Wno-array-bounds -mno-nop-mcount   -c -o x86/realmode.o 
/home/pbonzini/work/upstream/kvm-unit-tests/x86/realmode.c
cc1: error: ‘-pg’ without ‘-mfentry’ may be unreliable with shrink 
wrapping [-Werror]

with GCC 16.  This fixes it for both 32-bit and 64-bit builds, but I 
thought I'd run it by you before committing it:

diff --git a/x86/Makefile.x86_64 b/x86/Makefile.x86_64
index 5b221a48..dffbe8cd 100644
--- a/x86/Makefile.x86_64
+++ b/x86/Makefile.x86_64
@@ -66,6 +66,8 @@ $(TEST_DIR)/vmx.$(bin): $(TEST_DIR)/vmx_tests.o
  $(TEST_DIR)/svm.$(bin): $(TEST_DIR)/svm_tests.o
  $(TEST_DIR)/svm_npt.$(bin): $(TEST_DIR)/svm_npt.o

+NO_NOP_MCOUNT += $(if $(filter $(NOP_PGFLAGS),$(LATE_CFLAGS)),-mfentry)
+
  # Workaround for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180
  fno_fuse_ops_with_volatile := $(call cc-option, 
-fno-fuse-ops-with-volatile-access,)
  $(TEST_DIR)/intel-iommu.o: CFLAGS += $(fno_fuse_ops_with_volatile)
diff --git a/x86/realmode.c b/x86/realmode.c
index 0a7104d4..3b2d8c12 100644
--- a/x86/realmode.c
+++ b/x86/realmode.c
@@ -24,8 +24,9 @@ asm(
  	"test_function: \n\t"
  	"mov $0x1234, %eax \n\t"
  	"ret\n\t"
-	/* mcount() stub */
+	/* profiling stubs */
	"mcount:\n\t"
+	"__fentry__:\n\t"
  	"ret"
     );


Paolo

> Mathias Krause (3):
>    x86/vmx: Initialize test stage in SIPI test *before* launching AP
>      thread
>    x86: Better backtraces for leaf functions
>    x86: Prevent realmode test code instrumentation with nop-mcount
> 
> Sean Christopherson (17):
>    x86/vmx: Drop unused SYSENTER "support" in nested VMX infrastructure
>    x86/vmx: Drop unused guest_regs "support" in nested VMX infrastructure
>    x86/svm: Sort (and swap) GPRs by their index, not alphabetically
>    x86: Dedup guest/host context switch of registers across SVM and VMX
>    x86/virt: Use macro shenanigans to get reg offsets when swapping
>      guest/host regs
>    x86/virt: Track "guest regs" using per-CPU variable
>    x86/svm: Don't VMLOAD/VMSAVE "guest" state around VMRUN
>    x86/vmx: Use separate VMCSes for BSP vs. AP in INIT test
>    x86/vmx: Swap GPRs after checking "launched" status
>    x86/vmx: Track VMCS "launched" state per-CPU
>    x86/vmx: Track "is this CPU in guest mode" per-CPU
>    x86/vmx: Communicate hypercalls via RAX, not a global field
>    x86/kvmclock: Replace spaces with tabs
>    x86/kvmclock: Skip kvmclock test when not running on KVM with
>      CLOCKSOURCE2
>    x86/vmx: Tag "struct vmx_msr_entry" as needing to be 16-byte aligned
>    x86/smp: Align the stack to a 16-byte boundary when invoking SMP
>      function calls
>    x86/vmx: Write to KVM's WALL_CLOCK MSR via VM-Entry load list sync in
>      SIPI test
> 
>   lib/x86/processor.h |  15 +++
>   lib/x86/smp.c       |  21 ++++-
>   lib/x86/smp.h       |  32 +++++++
>   lib/x86/virt.h      |  61 ++++++++++++
>   x86/Makefile.common |  14 +++
>   x86/kvmclock.c      |  42 ++++-----
>   x86/kvmclock.h      |   2 +
>   x86/kvmclock_test.c | 225 +++++++++++++++++++++++---------------------
>   x86/realmode.c      |   3 +
>   x86/svm.c           |  19 ++--
>   x86/svm.h           |  61 ++----------
>   x86/svm_tests.c     |   5 +-
>   x86/vmx.c           | 121 +++++++++++-------------
>   x86/vmx.h           |  72 +-------------
>   x86/vmx_tests.c     | 134 ++++++++++++++++----------
>   15 files changed, 443 insertions(+), 384 deletions(-)
>   create mode 100644 lib/x86/virt.h
> 
> 
> base-commit: 4d60e2429d63dc0c24990114a8afc89e86c187cc

