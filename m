Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BF39184C
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460996; cv=none; b=cUALlWX4CxyYjTqdw4ZCy3S+qb3guyBn50kIS5YOQsS/nQVPoLk1YLdbNryXrKSA0eNH7evAGRE/7O5flYz5LuwA0J+cfLlnj59wtutLHZpk7Ep911ShWIa5wqI5iOrOZinEMug8qklMDzFXhq6IZ+ItqwxuEy6WFr8knYLme5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460996; c=relaxed/simple;
	bh=pFrJD8JwpQUONfEODSlbWTr22BuH3bNFwa8aBmpIdmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bW5sQcrxKQxIcRaF8GMfbSOLp5TfoutL/80mElZNcBzkfbiXThwpNde3K4WLn2lj738vKKoXk26c8LRGvLsjmQjBg6lk27ITlG16hv3uwKWL6/hUgGapvccrpmPEkITdimKdW5Nq/PKdur2eJAb2vOGT8wiDlMFyRrV1TPcj+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MC88/irb; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MC88/irb"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so171578b3a.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788460995; x=1789065795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpwT7ULhu2KXciyzAQFb13gHE62hglixd7EQ4ssSx84=;
        b=MC88/irbLwpr48PLKp9AYwyuOj80lwTbFdgAEhv83e3bXif+ke1r4/MZpntKt4zu5T
         iClyjdjN3xCWewOHf1rbJAq8tzPg3Yn3MGrNXd2nvQsrVOGytIt/SV974qNx7brMWlMG
         xlYDIyWPTtzg9TGYvgQJFCSOljWLd4BEdmjOWucmPdk3lavD+VGqIqQ/pGAHZ/mC1djY
         OlRHKrJA4ht6ct8BjIhSGE1D2HpjeEXqpj7fylm0Re34ghGucF4zprC7XLktVfJrib3n
         kKDGjtTfQLBd9fk4TLeD5Q0tDitkdU8lS1tq8U0xB+CdS+H+vpLOxd+t5r5+ktwhVLBN
         Vo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460995; x=1789065795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpwT7ULhu2KXciyzAQFb13gHE62hglixd7EQ4ssSx84=;
        b=cBxBQlWJHGWbBiQm1I7pIrAG2xd2HWseDm6CJInSmr40yv4sEsfsvm0ZcGutMWdNQ/
         pmGYHio2L3u3XnpO1GKUtmjL/ymA50T14t1SJfjZFe9flCToJr23s6XHq3+CEyF6ouJX
         y15VDv5ONNyv23/CQngkXbQUt9vNbXHye2QzYiiZ/kBesk2rGdzQUDLUK1+IuatAfjHP
         4zOggVAw8dEBl+c27Kf0KRP/7pFXMhWABq8PsPjqjqYYI09N9vQsQAch0+GzCje9uM87
         IkX8V4DING6hS7BdT3zi1xeeRKKILSkgk0wM5S1ELKS20o8OmcZIwzMlCdtl/4p3lJRq
         edrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsvIuWB2zC5fcYFn170RAIuAGz0ZFVmtvRKg2csaR1qjUJT1s75ekiLyPFATbadLnElsw=@vger.kernel.org
X-Gm-Message-State: AFuF++kEVdZrFyuXtMiqsnHw54niwoc0G9n241PNmIlz2RYue2mn+luw
	RQ6rOl7iA7HfgJbwzqwbcNZdGphSy8pRGo1pBW/7Qf6e60a7tMA+zQG2mOPCcxPhjgBFGotiS+j
	C304krA==
X-Received: from pfbft4.prod.google.com ([2002:a05:6a00:81c4:b0:845:4da8:56a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:990:b0:852:355b:2430
 with SMTP id d2e1a72fcca58-86168b8de8dmr1282438b3a.10.1788460994331; Thu, 03
 Sep 2026 11:43:14 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:43:13 -0700
In-Reply-To: <apm0BpPvMZZWYthw@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202609030248.b516759d-lkp@intel.com> <apm0BpPvMZZWYthw@google.com>
Message-ID: <apm_wb4yJ0jM9_gg@google.com>
Subject: Re: [sean-jc:x86/evmcs_vmptrldst] [KVM]  7fecb27e8d: bunch of
 kselftests.kvm failures
From: Sean Christopherson <seanjc@google.com>
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Yosry Ahmed <yosry@kernel.org>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, kernel test robot wrote:
> > kernel test robot noticed "kselftests.kvm.hyperv_evmcs.fail" on:
> > 
> > commit: 7fecb27e8d353adda91989eb01b3ae200b846a42 ("KVM: selftests: Always assert that vmwrite() succeeds") https://github.com/sean-jc/linux x86/evmcs_vmptrldst
> > 
> > in testcase: kselftests
> > version: kselftests-x86_64-f5098b6bae76-1_20260727
> > with following parameters:
> > 
> > 	group: kvm
> > 
> > config: x86_64-rhel-9.4-kselftests
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <yi1.lai@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202609030248.b516759d-lkp@intel.com
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260903/202609030248.b516759d-lkp@intel.com
> > 
> > Detailed log:
> > # selftests: kvm: evmcs_smm_controls_test
> > # Random seed: 0x7ad5b4f9
> > # 
> > # ==== Test Assertion Failure ====
> > #   include/x86/vmx.h:434: __vmwrite(encoding, value)
> > #   pid=5240 tid=5240 errno=4 - Interrupted system call
> > #      1	0x0000000000412f61: assert_on_unhandled_exception at processor.c:781
> > #      2	0x0000000000406f86: _vcpu_run at kvm_util.c:1687
> > #      3	 (inlined by) vcpu_run at kvm_util.c:1698
> > #      4	0x0000000000402cc6: main at evmcs_smm_controls_test.c:93
> > #      5	0x00007f0a85d39ca7: ?? ??:0
> > #      6	0x00007f0a85d39d64: ?? ??:0
> > #      7	0x00000000004030c0: _start at ??:?
> > #   vmwrite[0x0] = 0x0 hit VM-Fail
> 
> /facepalm
> 
> I managed to *repeatedly* not update the repository I was using to build selftests.
> Thank you friendly kernel test robot for saving me from major embarassment!

Ok, this is too funny not to tell someone, even if that someone ends up being a
bot.

I thought for sure I messed up the encoding, i.e. that the "vmwrite[0x0]" in the
report was either wrong, or or the encoding was getting clobbered along the way.
Nope, it just so happens that VIRTUAL_PROCESSOR_ID is encoding '0', and the very
first thing done by prepare_vmcs() => init_vmcs_control_fields() is:

	vmwrite(VIRTUAL_PROCESSOR_ID, 0);

The actual bug is stupid simple (and also hilarious/typical):

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 81028c24dc9e..a4807e41fe69 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -430,7 +430,7 @@ static __always_inline int __vmwrite(u64 encoding, u64 value)
 
 static inline void vmwrite(u64 encoding, u64 value)
 {
-	__GUEST_ASSERT(__vmwrite(encoding, value),
+	__GUEST_ASSERT(!__vmwrite(encoding, value),
 		       "vmwrite[0x%lx] = 0x%lx hit VM-Fail", encoding, value);
 }
 
Just to double check that I didn't botch the formatting, I verified that this:

diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index f32f8319301d..6066d200bcc2 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -251,11 +251,11 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 {
 	u32 sec_exec_ctl = 0;
 
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTLS));
+
 	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
 	vmwrite(POSTED_INTR_NV, 0);
 
-	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTLS));
-
 	if (vmx->eptp_gpa) {
 		u64 eptp = vmx->eptp_gpa | EPTP_WB | EPTP_PWL_4;
 
Yields:

  vmwrite[0x4000] = 0x3f00000016 hit VM-Fail
