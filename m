Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75746AEE8
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626421; cv=pass; b=MA8GxkHOb/QVbMjZQjV4mdHbi1Vl/E+x8VheGBhwahVCgK7KMjpZriHlsZseOeJnCHZ1oe4ueQom6UqWfvAlTogvthc/JZVPMN97kYux2dSSAnB8skXyOpIrk6rQ76DMiUhD/8kBI2RvuBtZ+vU+9NFITn9MZFZ07lYz75SLUaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626421; c=relaxed/simple;
	bh=ndEqcE0ljpH5Ond7AgGtEjExOUt6CFJ5ogOAOFvSQNU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGQkxdjmLEINdwDKJMaTd64K82Nuz0km8qPcjWxkkzmaa357FfWiPD0T7+hmtsjSjb2KQnRJDfPtJOsN/Ja9wpC93oslYGBI3n9Gh5z1uIK13nIFjSEeV6xMauU6ZEHpKuaNetje3SDVkK4+N0iMuzCu+neAlbtIeRGH4l9o68E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVR3gCxm; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVR3gCxm"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13810b63a1aso10623015c88.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626419; cv=none;
        d=google.com; s=arc-20240605;
        b=DpH6i7GkhTSvkeoKAaoYKl1P3lP6Q+lKqAIpIsWwYo3WZQUm/S3a050JLMEKPxFFgC
         7Q+jb/T8sgeGQR7daoa39RtaU0WmbxzEvhhI4ikaZ47jbUX6R+zv7TOHkgcx48KhkBKt
         Xgh5KuWDOTfhnGxaPXp0XjqpMuCSvfxPOF/C+IgRKj/MxbkehVeNPk2bI7W2R0qh3+Rw
         P9uU/cACqtdo02+GWzIkMOU9xuBybKW0cVxRUrgL69KzD4KpPzF5wRtCMk3FXhvx9aRV
         g0AEtk8QnP8/dSsBwk/Zsk9oLNg1JwDWHV3tGoFJJcpOGKUvycXsg7VrVHxUiSa2Hbl8
         e9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MNHAi9O6B/tlryNPdWu47BymnIT2qXwJrSOCHJFBXD8=;
        fh=WxHtd4yae/S9aJzGX3NTuOvmHnkUK8M0qmzgSbYmDT4=;
        b=JlV2ovgt/fN/r+r8wQnLpVNUqxRDjJSX4VYIh8kt3j+w4TWfFXTt034IklrC06Na8m
         jQX7H67ReE/TD15zgB3ncQR6xznW2UYDub8z8J3qkPqe47u738EDY2alZva6XkiwKqtf
         Z8j2a+vaad5gozIB0avLA9oPacG6VL0BnAtB+e35pz37zwlUaWyHDyWvd2BXEFz+aOY/
         i+7o0WE2SY2O3uufasGFRcMy5nM7HxggM7TRpidNE+VrXdG/aTMkkAvi0nnVPIm+kKI+
         pKdOekvg4P3pyY4PGrdherjUGiHx63dsadxudjkrDLU3XUfRjAEgJvMYNRxrfTtWE7LQ
         XFoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781626419; x=1782231219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNHAi9O6B/tlryNPdWu47BymnIT2qXwJrSOCHJFBXD8=;
        b=uVR3gCxmtJX0k/bQA4nojeCursjgCgHTEQduGiZvwLlc0XGjmwsPK7ZtAzEIAIY0F0
         Mtyl5lRoV0Iqi7J8F+sFoqWFKawH/y4LitR12vQ1EBv4o8UXyHB6/ZX11ChaHE5Italv
         PUW0iukQLeuYJhRknAygV+HJ0NHLKz9K1JDqpE11nLlXTre5FBSeJXP0KGEg+3JRxmpK
         x/f+A3bNT8pPy+4dKkXHE41Hz9NINQjsMHDPLzlWU3K0yD/7ZAnP6jeh8cGlch40hAQc
         0VYBnaRbSrxkfTTPKKpppj8FFPg2ZVRO9acZGq5w1whFt+dPv0Gh3l1QL1LiWpVd6XN2
         HOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626419; x=1782231219;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNHAi9O6B/tlryNPdWu47BymnIT2qXwJrSOCHJFBXD8=;
        b=lXww5WYigg8joRnGNSZnmasbFW+0HwSwUDg2ZYsvhgy1f5eWFHVLtn+tDeoUIT1JHV
         VhGe2qymNAOfe49nzrREmWqVg76ZQP8kzRz+g/DOYMrL+iXOgCpRZGfR2hjoSdk2mbfX
         6m+p46FO9vIYyr56mqxB/xJMyB73vGWkuucgvLrByOnypKUbKSCV2rAsEiIfdoOfo2im
         wqoLPxKndh2pmZES4flXAgQ0Ld7OLTYc6JBzfEnM45H2ZSY8oGvdhHEVcKkt7Tj6J7Hj
         VGcQlwEH7jEU6h2Kfc1nYIPIzZQKn81wugH3icFr9CGxDuAlJkP53l6kO9De9vQYjpVX
         mB9g==
X-Forwarded-Encrypted: i=1; AFNElJ+dxo1tpAw3/qXi68I4vY/QwhkwJV6y2HvR9FGHLE3lUgzjdlcKIldbsbf6bvp/uqShPT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrxLSF5t0i+jl3cCW+3OazvIEN/C8jav5gyK9/mteWD2YNari
	Kx0wqeBnd0M+myCBeu7/mIti8qA1xBEdKXwm+C3y6BnZxN8PgXBpGl24nFtEyWS8G0BDTD5eRDP
	9hA7v1NAcYP3dOI47i0QK5mjj0wJ3RgGgMiWiL7md
X-Gm-Gg: Acq92OFFBgH6+b9rj0O6mUGg6mTQ5rDRJsq20uKRf8QyX4lIxm6a7kKrmVM8Q9+rQID
	o9pOOfZ8/9YSUNbZH6wZgcnFcj4y8k9kLQ5BC2IAX3OlGScQGP6F3l4yFJhM4Uj7IarK4eHUnw6
	p6KVnjDz0osTakCClvSeOX3BIIRcUx1Bojeo4D2+MhaVqhKoggQTW0iRZiXlgu1q7DDck2KJh8e
	Orx45nENeUrX22+32sbfQmAljsw+lGkCym1YJ4ARpNCLJwtjjMzsABBv4Im4uT6mPorUCoHA5LI
	7rQyrNsdjV9Yb2un+dCWoMIwlmQ0XxGjuRa2yf2D+ewCC9hdfbRrGFLfNg5sV6HqAv/hfA==
X-Received: by 2002:a05:7022:6981:b0:137:fccb:8105 with SMTP id
 a92af1059eb24-13985e954aemr2127181c88.4.1781626418754; Tue, 16 Jun 2026
 09:13:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 09:13:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 09:13:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajFfb9u6dU47Nj3v@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
 <CAEvNRgHEq-hHcTivUw8TYBeMu-RpS=Ho4DXaNXKQKLPL_biTgg@mail.gmail.com>
 <aiMOWkiVBqoQDAPd@google.com> <CAEvNRgF09SfDm=OgbrS8-wpfxbNecQkqAQwf1ELq1jWu7NjbUA@mail.gmail.com>
 <aiM2Nm9Eh68mIVX3@google.com> <CAEvNRgHjno=XDnMpTvZcNCR6D5RAi1rbynrL4CnnEa7Y-M3VLg@mail.gmail.com>
 <ajFfb9u6dU47Nj3v@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 09:13:37 -0700
X-Gm-Features: AVVi8Cd0kI17gcaTu_9-akkDCf_yt6j4MWsybVMXC_T33O0ww1RiPjrA74_vwTc
Message-ID: <CAEvNRgFPKC2uOMaams7SS9B7LxvfU4h8DrPM5vXFb=pmXsgPbA@mail.gmail.com>
Subject: Re: [PATCH v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> [...snip...]
>
>>
>> I still think kvm_arch_vm_finalize_vcpus() is an odd place to be
>> finalizing the VM.
>
> That's literally why the function exists though.  The one and only existing
> implementation (on arm64) uses it to initialize the vGIC.
>
>   void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
>   {
> 	if (vm->arch.has_gic)
> 		__vgic_v3_init(vm->arch.gic_fd);
>   }
>
> That's *very* similar to the proposed TDX usage, where some per-VM asset(s) can
> be initialized/frozen only after all vCPUs have been added.  In other words, the
> name is describing where in the VM creation/setup flow the hook is called, and
> perhaps more importantly, the impact of the call: vCPUs are finalized (obviously
> with a different definition of "finalized" based on the VM properties).
>
>> I would prefer to not have to explicitly call some function like
>> kvm_arch_vm_finalize() (no vcpu in the name), but a common arch function
>> calling vm_sev_launch() and tdx_vm_finalize() is what I can think of
>> for test setup flexibility, without too much magic.
>
> We can't have our cake and eat it too.  Either we launch/finalize SEV/TDX VMs as
> part of the common VM creation flows (as proposed for TDX), or we force tests to
> manually launch/finalize the VM after additional setup.  The only way to have it
> both ways is to utilize crazy macro shenanigans to execute arbitrary code between
> creating the VM and launching/finalizing the VM, and even I would balk at that.
>
> I honestly don't see any reason to try to figure out which of the two approaches
> is optimal at this time.  Whatever decision we make isn't set in stone, and in
> fact should be relative easy to change.  And without being able to see all the
> TDX/SEV tests that are waiting in the wings, it's more or less impossible to make
> an informed decision.
>
> I definitely want to have SEV and TDX use the same core approach in the end, but
> I don't think we should force the issue right now, because the cost of reworking
> the SEV and/or TDX infrastructure when there are only a bare handful of tests is
> so low.  It will cost more to try to predict the future of a 50/50 outcome than
> it will to make a completely wild guess between the two options and rework things
> if we guess wrong.
>

Makes sense. I'm good with merging this as it is done in this
patch. Thanks :)

>> For now, I can't think of many uses of __shared. ucall shared memory is
>> allocated dynamically, and we can also make it shared cleanly within
>> ucall code.
>
> Uh, every selftest that uses global variables to communicate between guest and
> host?
>
>> The global variables (sync_global_to_guest()) will appear in the guest
>> as long as sync_global_to_guest() is called before
>> kvm_arch_vm_finalize(), which I think makes sense to people writing
>> tests for CoCo.
>
> Yes, but that's completely orthogonal to all of this.
>
>> So 2 questions to push this along:
>>
>> 1. What do you think of a kvm_arch_vm_finalize() that calls
>>    vm_sev_launch() and tdx_vm_finalize()? My key issue is that
>>    kvm_arch_vm_finalize_*vcpus*() seems to be for finalizing vCPUs
>>    rather than the whole VM.
>
> Key word "seems".  I'm pretty sure Oliver picked kvm_arch_vm_finalize_vcpus() as
> the name in commit 8911c7dbc607 ("KVM: arm64: selftests: Create a VGICv3 for
> 'default' VMs") for the same reasons I think it's a good fit for coco VMs: like
> finalizing TDX VMs, initializing the vGIC effectively finalizes vCPUs.
>
> We could rename it to kvm_arch_vm_finalize(), but that won't change the fact that
> we'll need to decide between automagic vs. manual finalization, and it definitely
> should be a separate discussion.
>

This definitely should not block this series.

It's coming together for me now with your explanation:
kvm_arch_vm_finalize_vcpus() actually means finalizing vCPUs! vGIC ==
Virtual Generic Interrupt Controller, which has to be done after all the
vCPUs are set up. Since the name is describing where in the VM
creation/setup flow the hook is called (after creating VM and after
creating vCPUs), maybe something like kvm_arch_vm_post_vcpu_create()?

Renaming this to kvm_arch_vm_finalize() makes it sound like it is
finalizing the VM, but this function shouldn't finalize the VM since for
CoCo finalizing the VM also loads the guest image into the guest - deals
with memory, not just vCPUs.

8911c7dbc607 ("KVM: arm64: selftests: Create a VGICv3 for 'default'
VMs") also includes a test_disable_default_vgic() function, we could
also use something like that to skip CoCo VM finalization for some
tests? Maybe that's a good middle ground.

>> 3. Would you like __shared implemented together with this series, as a
>>    prerequisite, or later?
>
> Only if __shared is a hard requirement for base TDX support, which I assume is
> not the case.

Yup!
