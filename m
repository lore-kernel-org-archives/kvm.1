Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CB3B27F9
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278662; cv=none; b=WIJAg304fwXs11AiyWS9gGyOtpbOKX0gI7OnjQH/MvxXGaBJrYCE/i+RRTxN/fw77gaGstFPu8auKCLddtJ+KNX1wripY3OAgNV11cza5uBg5RavDGm1KNEwk08nldI0TrTFFNOGgHfhwmx/rbs9Ra2gGQWedN+wbiOio+erwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278662; c=relaxed/simple;
	bh=srB8N8qCbjn8OYCn/cFHQPSvjruCyxi1S8AXEXH/ON4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ssTSZAplm7JLzlskBXnpvaiKWUIBPqXzsIe7n2UT8UGBte0P5sKZy5HAyW5sZxlyKvMHPLSt7TXQ+rVvPo5ws0UadRHARP68A7aIjJuEXV9PA1evjLjOEfNbD1vZ+V9pjx1HerIlQZX88Lhklu/VQKN+NJ5fQPPOcU0TzGWZDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYIQH0Mq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYIQH0Mq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1447165eec.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791278660; x=1791883460; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ohmud8dlW/23qmDZSut2G/bzXusBDFIZZACFjcnqkos=;
        b=QYIQH0Mqp2AdDZi/sW2pklYv9BKhZvaF/vulbuxItdCqEWdCsBDegt126qtDl5k6cs
         iqPEIHyBGQC2imrA8VaQjRmgjzw/oD1Fs2ed5W36WNXpouteNCnzKJUSENCI+UOkIn6/
         OeXIZ/u8QBm+/FGQl1qc4Kls7u0sb+F3P2Pysz37tzGfpjcYsj7VqXopTA34t6CBtpGP
         ZK7+eTqCxytlVv2/z6uKHhR+WnT58ieKyaGzi0AT2UnfeiYbdzvY4h6Z/P7585o1VNL7
         Fx1Zu+uyYvrqxCi9kbljH58ljg2CGe1VCBfW+2ICBiOGGR/UCw5WHc3q/lPWTj4axGho
         nfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278660; x=1791883460;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohmud8dlW/23qmDZSut2G/bzXusBDFIZZACFjcnqkos=;
        b=TAet/w/Piz9IAi+6fQDZ6io+PYrSQwMaW18N8bAaxFmm+7diQSAN/zoNlDvO6cxiUY
         iheDAwKFOdL6zZynTVY53YhmLGugRe2N0VKtmb7h84ovlerg1/t+e5UThllSLEMVze+I
         Q/xBLbTsBPbQFo0NSjVbV3giTWq4Q4XExjJrk7yYzVV8STL5aMC/B1hkjvEi1OS8Lv8+
         42G5W1j/8q/hXu7yGTKVybq2T5jZ8of9R7dAJmlRXAF9Wmd+5iklR4X3oiaVpdkdwlDd
         O0Y276sHTx7neuoNVGtb8s8UBSqEufd7vwa96/iGB1p5B4dYUhsYVMIUXbCI+k//FyOn
         CS5g==
X-Gm-Message-State: AFuF++lw159lalNlYYeKc3aciPWfiJSCnOofEzpFbsImBWCxos91GpY2
	LXZbJFqHfL5QDSapOuLc3KMZ1aPzXTNI8FmyneXFQjpXdlKkHWxcHBIh
X-Gm-Gg: AYBFou2BGX488uicEkA0xC0i+ZjSRPE5u7B+3tkwkrJTx3VM4ppW7hLGAE1FUIFj8HE
	knEBtX1EIKBSiTgU/fPIjZJxUoZ+hw65TGtLMJLJcFWZ1U+Bc+eGy9FYRutMqWJEOTEmBMNZ6lw
	A5itI7nfsZ8+w937Fl2rcXvMcV9mDmrwSEHCarJWnUevvPIRq0ZPw/zrjuXSJptFivtp6vf5JkU
	4J/L+z31RhdwMUan71+ubVzsattelzhJo0YH1E8am6cLUKBq9kiKguEe4oDGGY380TCCrWcLfDX
	NAp6h1CCE4uo5xocpWTysISsxDyWw1v6lix7iiyNL5fPuQKot3L3DxFwEzJyoa771ypYMLIdFje
	a0yXOy1tpvOCeuuYrNVBqv/SFOkIZtMDsUTH7RlcaE/yZYyI46TTz+kwWkkElHT1z90Zxd84OA3
	ks2dI7jma41qnzAUIN8Ll22SfgdsPvTs9oxDF+25vQBVoAW8OL5aETr6fUv3EzJOJ5kcIut0plD
	A3i9Eo3ikssHLlbg6q6aPbJB2+e9wmPtWN6eh+6Rc2CQwcXmW42HQ==
X-Received: by 2002:a05:7300:51e9:b0:351:52ec:60ee with SMTP id 5a478bee46e88-35152ec672fmr48303eec.28.1791278659872;
        Tue, 06 Oct 2026 02:24:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f73fcsm6424655eec.10.2026.10.06.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:24:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asM-1-ptu1b_URqR@google.com>
Date: Tue, 06 Oct 2026 08:13:01 +0530
Message-ID: <ece3k0qy.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com> <asMN_TAX-1_J3jiP@google.com> <fqykkc3j.ritesh.list@gmail.com> <asM-1-ptu1b_URqR@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Oct 05, 2026, Ritesh Harjani wrote:
>  > I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
>> > over open coding TEST_GEN_PROGS_COMMON.
>> 
>> Sure, so will add this check for kvm_create_max_vcpus()
>> 
>> #ifdef __powerpc64__
>>        TEST_REQUIRE(!is_pseries_lpar());
>> #endif 
>
> Or maybe to avoid too many ifdefs, something like:
>
>   static inline kvm_is_ppc_pseries_lpar(void)
>   {
>           /*
>            * Comment about how this setup has unique limitations and isn't
>            * compatible with tests that create many VMs and/or vCPUs.
>            */
>   #ifdef __powerpc64___
>           return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
>   #else
>           return false;
>   #endif
>   }
>
> Probably redundant naming to some extent, but having "ppc" in there would make it
> super obvious it's a PPC-only check.
>  

Sure. So I will get this definition added into kvm_util.h header file.


>> Actually I was thinking we may as well use the same check for now for
>> skipping hardware_disable_test on pseries. Because there also we suffer
>> from the same resource limitation. Let me know if that sounds ok to you
>> or do you want us to skip kvm_create_max_vcpus() only for now, since it
>> is part of TEST_GEN_PROGS_COMMON?
>> 
>> > LoongArch open coded its full test list
>> > for some reason, and in less than a year it has started missing out on new common
>> > tests.
>> >
>> >> (& maybe few others like vm_types_test) from that in v6.
>> >
>> > What's wrong with VM types test?  That one really should Just Work on all
>> > architectures.  It doesn't run on LoongArch, but I assume that's
>> > oversight?
>> 
>> So the test doesn't fail (it gets skipped). However this cap
>> "KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
>> open code all common tests, hence I thought I may as well not add this
>> in the first place.
>
> /facepalm
>
> I completely forgot KVM_CAP_VM_TYPES is x86-only.  FWIW, I'd still say use
> TEST_GEN_PROGS_COMMON if possible.
>
>> BTW, based on this discussion, I think I will re-arrange the patches in
>> the following order and send a v7. (The Makefile.kvm changes will only
>> get added after the main patch which adds powerpc support).
>> 
>> cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
>> 2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
>> f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
>> e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested
>
> Doesn't this one need to come first?  Or is this different than pseries LPAR?
>

That is correct. The patches are in the reverse order taken from the
output of: git log --oneline ...


>> 178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
>> 22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc
>
> This should come before "add support for powerpc", and should have a shortlog

That is correct. The patches are in the reverse order taken from the
output of: git log --oneline ...

> more like "Skip max vCPU IDs test on PPC with <whatever is a good description of the SMT cap>"
>

Sure, I will change this to something like:

  KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
  
  kvm_create_max_vcpus creates vCPUs from 0..MAX_VCPUS-1, then again
  with ids at the top of KVM_CAP_MAX_VCPU_ID.
  
  On PowerPC the vCPU id is not a flat index: it encodes SMT thread plus
  core. So on powerpc maximum permitted vCPU ID depends on the VM's SMT
  mode and the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple
  non-SMT VM's limit.
  
  So, skip that second loop when KVM_CAP_PPC_SMT is non-zero. The cap is
  0 on other arches, so they still run it. The 0..MAX_VCPUS pass is
  unchanged.

>> 11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
>> 63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
>> 
>> 
>> Please let me know if this sounds ok?
>
> Ya, works for me!

Thanks! Will send v7 shortly with the discussed changes.

-ritesh
