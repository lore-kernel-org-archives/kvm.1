Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFB4EDCC3
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781117; cv=none; b=luR11DrXudKwL5X+W8Uojdo8otzPn2fzC1PxuXAyfMJpCJuHKCjefSm2x7UuQYV4xRXpy9buJxdApDIGdqCStrypr5K8awnQxPzeIJw54xSVUg+Q0v4ohk1C/cEnqvFieLdsXa2S4coSSk8KYhmTddSwRgN4xN0rRvbx4cpLlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781117; c=relaxed/simple;
	bh=aJK56cyRzXZjWpIBAPw5fRHCWxiO1QJ0/pWjo+GWpRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s+3gbvhbZs/dDHA5sX2avxh6rrDKSo9UE73yYd1wn2gS6FfertQFBn2iH3dCihSPCcuky8W9WORse0daYrJFT5ap32kkgIL/CXdntVexRMABdo6/Y0MaCyfODpgc6jPC6OxagAT7JuJHUsHV7tjkTOuSEbVuNUOlSC5FvVluIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wb66/11z; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wb66/11z"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3d832827so60845245ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790781105; x=1791385905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnYEy85T6L9VUgYpvbipzar1+R2ojY5ljHxm3uRhDeA=;
        b=wb66/11zVVkg1hhGfYFDt4TsYmICBJphhRh3WZnwfW5BR3TaSwYiyMeWa8LP8geMjT
         OKwbQuJuyuQ67o3fX2jGCpmJcQZo8zNHXSlptJ+J7kyAeco75LPR1zVIagS3J5c6uem5
         U4xaefzoaa5uqMehWCCKmr/Jpw3mQ6pEEztOYy2JREQ708hJiXGaGcWbIvSn3EMG9aaG
         FPrpKo4Yt3RD3fkbuzZeTv3p4LlUDbNRqoK84snlyQhWnJcImEWT66a53cCFxk2hT0hr
         Jb1thsBHuY97g/e/KyNyLFntEYtlDgblW1gyBGDZDAfQWzdC0F0k1nbDJwojWZk7e/Vq
         0psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781105; x=1791385905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnYEy85T6L9VUgYpvbipzar1+R2ojY5ljHxm3uRhDeA=;
        b=HliNYuGMs0M7VLHym9H5iawYNcbQ7oRXhfrrzn0IKODJ86t2aLLW9az//FbcIMBYVT
         axkfnYkXlkmL6AQCwxkNl2JAH1QdH9H843rw723GROqP3jNWh0Ar4sZ2nukQCccO9eJG
         e0LYijM86xkICGOM9ZakBP92xzf+2PuIUEGOkP/ZNNerh+WOQkyWCEfzM9oBRqNjwe5C
         Sb+crKfptfZ/9i9RDIJS9oUX6UiV+ojCEV8qYQS9gfDVHOAe0MGF2fzx1WUyVTE0Filk
         gu0Et8vMxKZjNlNjbMtBk8jAipoW4iOHjlmXXfodsBXqxPz7fLkZ2JW6Wbh4aR7JIMpX
         vkwg==
X-Gm-Message-State: AFq9FYJ2ISXN/NoWXaGN9tatTujA53vgSBGyViQANMV9UY4bn9ZqR11p
	3UMqz4OXcz9S17QvPkfgWhK0YLNY8hTbPt7vMkF44fcqLSeqKshVj2D9qr13e4TUFCkO7VeJDco
	qxWjSWg==
X-Received: from plrq18.prod.google.com ([2002:a17:902:b112:b0:2e2:c684:16fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b46:b0:2e2:e0c6:1689
 with SMTP id d9443c01a7336-2e2e4bb71d7mr13947915ad.58.1790781104894; Wed, 30
 Sep 2026 08:11:44 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:11:44 -0700
In-Reply-To: <f8d5ab37-7bc5-494f-afec-6bd0cb0c412c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ar0KIZ8HQEfIRvVJ@sirena.org.uk> <ar0RN3FICQ-PEqNW@google.com> <f8d5ab37-7bc5-494f-afec-6bd0cb0c412c@sirena.org.uk>
Message-ID: <ar0msIOhuFY0RpCS@google.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the kvm-fixes tree
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, Mark Brown wrote:
> On Wed, Sep 30, 2026 at 06:40:07AM -0700, Sean Christopherson wrote:
> > On Wed, Sep 30, 2026, Mark Brown wrote:
> 
> > > between commits:
> 
> > >   b630929bcc4c8 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
> > >   b0bc51910f039 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")
> 
> > > from the kvm-fixes tree and commits:
> 
> > >   9b2f8146fcef9 ("KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt")
> > >   a4bab1c12fd52 ("KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12")
> 
> > kvm-fixes got force-pushed, which is what's causing the weird conflict.  In a
> > tree that hasn't refresh from kvm.git, I see:
> 
> Ah, I had thought it was an old version of the patch having landed in
> kvm-x86.  It looked like different versions of the same patch got into
> each tree so I went with the main fixes branch version as that's what's
> heading for Linus.  This sort of cherry pick/duplicate stuff is always
> hard to follow. :(
> 
> >   a4bab1c12fd528ccaafee00360e07463873404a9 (kvm/master, kvm/HEAD) KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
> >   9b2f8146fcef9faa73f9dc1bad9a8d6c585cfec8 KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt
> 
> > versus the newer version:
> 
> >   973ea70393e885e540f714904e51bc6cac80e3d7 (kvm/master, kvm/HEAD) KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state
> >   8abbc76120a74bfba1851bd97528099d715e45c6 KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
> >   b0bc51910f0391fea09c0a1d32352fec2acb2686 KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
> >   b630929bcc4c867c9abc8cd5a0ebee3bb5ce5dcd KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt
> 
> IIRC my conflict resolution gitk only showed me the two commits that got
> duplicated, it is filtered by file though.
> 
> > >  -	prepare_for_vmx_operation(vmx);
> > >  +	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
> 
> > This resolution will probably break the final selftests build?  kvm-x86/next
> > moves these asserts into prepare_for_vmx_operation(), load_evmcs(), load_vmcs()
> > etc.  I.e. kvm-x86/next should "win".
> 
> That's entirely plausible, my kselftest build tests are for arm64 only
> since that's what's native on the build machine.  Sorry about the mess
> here.

Ha, no need to apologize, it's our mess.

> If you send me a confirmed resolution on top of today's -next I
> can add the fixup, or I'll try to take look tomorrow?

Here's the fixup.  I'll make sure to push to kvm-x86/next today with the new
version of kvm/master, so this should disappear in tomorrow's build.

diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index 52959287500d..2ae698c9aa1c 100644
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -61,57 +61,55 @@ static void l1_vmx_code(struct vmx_pages *vmx, struct hyperv_test_pages *hv_page
 		evmcs_enable();
 	}
 
-	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	prepare_for_vmx_operation(vmx);
 
 	if (hv_pages) {
-		GUEST_ASSERT(load_evmcs(hv_pages));
+		load_evmcs(hv_pages);
 		current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
 	} else {
-		GUEST_ASSERT(load_vmcs(vmx));
+		load_vmcs(vmx);
 	}
 
 	prepare_vmcs(vmx, NULL);
 	vmwrite(GUEST_RIP, (unsigned long)l2_guest_code);
 
-	control = vmreadz(PIN_BASED_VM_EXEC_CONTROL);
+	control = vmread(PIN_BASED_VM_EXEC_CONTROL);
 	control |= PIN_BASED_EXT_INTR_MASK;
 	vmwrite(PIN_BASED_VM_EXEC_CONTROL, control);
 
-	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;
-	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 
-	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+	control = vmread(SECONDARY_VM_EXEC_CONTROL);
 	control |= SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 		   SECONDARY_EXEC_APIC_REGISTER_VIRT |
 		   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
 	control &= (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
-	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 
-	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
-	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
-			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
+	vmlaunch();
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 }
 
 static void l1_vmx_code_part2(void)
 {
 	u64 control;
 
-	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
 	control &= ~CPU_BASED_TPR_SHADOW;
-	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 
-	control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+	control = vmread(SECONDARY_VM_EXEC_CONTROL);
 	control &= ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 			SECONDARY_EXEC_APIC_REGISTER_VIRT |
 			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
-	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
 
-	GUEST_ASSERT(!vmresume());
-	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
-	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
-			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
+	vmresume();
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_CPUID);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
 }
 
 static void l1_test_x2apic_intercepts(void)
