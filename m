Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEC3644BE
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672097; cv=none; b=mGDzLWE7Wj7935r3xUO5Ea3adu58gvpsVppWNWVOSmqZH95+/GhkQSggULiPB39KtgGq+jrLzbDsTVIyPfTGt+PUKbNkbJ+B0HqCH8w3c/ozhuWJLx7h5twPY2CYlgd5kUEy0fNvHGEV4ayQjjYaHUVXHaC7QGfzVo2wnaTJKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672097; c=relaxed/simple;
	bh=oKQrZ1Xq19+umr1iVZEqb1OcjyLmb+nHgcyI503ZoJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjXRMrVco1E+vQt1SpRtpMOEq1IrFf+j90JcRQez0RVOXT3UOqWHqLNNHJLikDFkqDbQXmK+pY8CqfTOSXnacQqsjKmpaXtjDKmYzIGom1xFX+xa/tiyfdG14kJ+3xLgld05i93XYRzqqsChA2nRDQ8PULwU3vtePqS+BfPG1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=J/qGSl0k; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="J/qGSl0k"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d65f4073bfso309063085a.3
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777672095; x=1778276895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hc5RHLA5VFRb81K4SZGy+0XpIw2C1HBIpUMvPfNhCXc=;
        b=J/qGSl0khG5RuRl3m0jxkJHuq4m57PbdGco/VvLa8v+s3zzjoptmGJZltBYto/j+Mv
         u3GzGZQ9HEsMFNT/7ZfO2NXU4x+5gN7U/FqiRSKGTTRxSs7/9/kBEXgcZk2z+g3jV3zG
         DXFU+P924houJymF73ToNVGKg5i40vJwEYTurMmJjhrR5EI8u2deWUoMIOvvach79BW6
         WBjp5rGlVnVziiqjYUZ8fmfx+NG6MwkNC6jg7NNNt1XBbAb/rNc60Qcm/JUdvNFbyIgJ
         HAwUVScj1vvYp7ByB9/7K7EHoceUo6sjy6dODC8rJK0qEtCyC6I5xFLsRTfw5tV/xPf5
         Rk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777672095; x=1778276895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hc5RHLA5VFRb81K4SZGy+0XpIw2C1HBIpUMvPfNhCXc=;
        b=lRcS70ID9gpkRvr8hFSqesMqyOzLUaSEwWxvjp8T45EbS/QZuxqxaOHVWaTCeSywjA
         xRQh9F3JV1trMQfZMjHc9YTQ9BIpAcDKrGnwCx1bgbcDdsZjtcyjMYMcM4xlDc/EbJvh
         UdCdG15JWqVYu1su1VS9T9zKN/BwHib3r0y/aDQz6j5U4TKISpEWdSHUb0rXLf382WFm
         F1Gwt1ch4uy/MNxUlYqJ5tY8FL23uY4rspC7D4X1GCwI13l9eohH2PzFZLlIgTyxJhVA
         MURa9UHFTaj3/OaZ5gBCaUlvD63aEwMjxaXdhAtkpeooMaR9foemgTAXd2K5fc2NPgOm
         szZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2m8uPyP2T0s6iNJRoWbwYQ036NpQkjanceAgA7NBTrXSyf3y4IBhap503Kd6f3kFCOnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8SAsEd+pNtyM4r2OBaidsiEfGjVFh1sXfhSfedSNw/CDAfSA
	GDph/izqMCUDu2JzHy6VyN8TB3RIsswS9sZ8xpxQUCQ3+5iQixiYnI0Etz6BQrDddD0=
X-Gm-Gg: AeBDievQLpH5IMJ10XBa2eMIelh+xY5280fkwhrP1btFqsutR7EV+5pJMlGH8ULL8i8
	lC4Lm6hkS6IyC3LaUFgYHqXp0206zWNdljEBRQJhBIm0WSOxG12fwlQS5V5P13g6F4oqrtXNDnU
	6NEn2YYC9qF71Bk4FTAOHCI9QhoJsnYSGOjdquyUfG6NrJhiN4MlQCbueFElCNcVxv0q052aqAN
	h0Rso7sCPxBrZJL/VjQnKV6ZBMaLRlSQy6nIwSiMdo/aJ8Xvg7Bjgba7GVkWn28ehGDRZDqtCrk
	NR9OFFlAP94qZ0QCSrx8VYHTO78lRwbrurhbKfnNZHWiW2kxqLcouo21iFMEsF+TNcIm/DyT8yr
	ZHQamR4niRLkqFYKYVIeQ5PWENJxFFcIh+a+lsUoZLD8AjbrdMGuXccRnW/ag1vKnUtYHmvIoC9
	NlPm/aNwkX96sysQhMIy3P6Ops/S/NwW4NDDlnW9DBPZiKJifBL0bkn9TdLQZkCzZPEw2HqCBG
X-Received: by 2002:a05:622a:1a82:b0:50e:a1ab:67eb with SMTP id d75a77b69052e-5104bee8fdemr16187191cf.33.1777672094661;
        Fri, 01 May 2026 14:48:14 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8174csm28918761cf.25.2026.05.01.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:48:14 -0700 (PDT)
Date: Fri, 1 May 2026 21:48:12 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, kvmarm@lists.linux.dev, rppt@kernel.org, graf@amazon.com, 
	pratyush@kernel.org, seanjc@google.com, maz@kernel.org, oupton@kernel.org, 
	dwmw2@infradead.org, alex.williamson@redhat.com, kevin.tian@intel.com, 
	rientjes@google.com, Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, 
	baolu.lu@linux.intel.com, david@kernel.org, dmatlack@google.com, mheyne@amazon.de, 
	jgowans@amazon.com, jgg@nvidia.com, pankaj.gupta.linux@gmail.com, 
	kpraveen.lkml@gmail.com, vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, pjt@google.com
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
Message-ID: <afUNlL_lRDP6olHE@plex>
References: <afEwWZksU0Fw61oT@plex>
 <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>

On 04-30 15:28, Paolo Bonzini wrote:
> I have some very similar observations to Alex and some very similar
> observations to David.  This has to imply that everyone will agree with me.
> :)
> 
> Seriously, the main contention point, from reading the thread, is the
> placement and lifecycle of the caretaker.  More on this later...
> 
> On 4/29/26 00:29, Pasha Tatashin wrote:
> > While this proposal focuses on its critical role in minimally disruptive
> > Live Update, the Caretaker is fundamentally designed as an extensible
> > primitive. Its architecture allows it to be leveraged for a variety of
> > other advanced virtualization use cases, such as running custom
> > lightweight hypervisors or completely offloading virtualization duties
> > to an accelerator card.
> 
> One step at a time please---and as an initial step, just place it inside the
> kernel, a la Arm nVHE.
> 
> Since your design would have anyway the ability to update the caretaker, you
> can embed that part into the reattachment process, so that the new kernel
> can use its own caretaker.

This is a good point. If we make the Caretaker built-in and always 
enabled via a module parameter, the update to new Caretaker can be 
handled in the new kernel when we adopt the Orphaned VM thread during 
reattachment.

> This reduces a lot the need to establish a stable-ish ABI.  Only the
> handover (kexec/LUO) needs to be stable, so that the new kernel can populate
> its kvm and kvm_vcpu structs.  And for that we mostly have a solution
> already: a stream of serialized ioctls.

The way I see it, vmfd and vcpufd need to support LUO preservation by 
implementing the liveupdate_file_ops callbacks (.preserve, .restore).

When userspace preserves the vcpufd, the kernel isolates the assigned 
pCPU (probably requiring the vCPU to be pinned to the CPU, and the CPU 
to be in an isolated cpuset), offlines it from the kernel's perspective, 
and signals to the Caretaker that KVM is detached.

We can start with the simplest form of the Caretaker for a PoC:

* No ASI. It duplicates the kernel page tables and uses its own mappings.
* It does not handle any VM exits locally. It passes everything down to 
KVM during normal operation, and treats all exits as blocking events 
when detached.

The PoC can be demonstrated without kexec: execute vcpufd .preserve() to 
isolate and offline the pCPU, and later use LUO .retrieve() to online 
the pCPU and re-adopt the running vCPU thread.

Even for this simplest form, we still need a defined ABI between the 
host kernel and the Caretaker. The host must send an IPI to 
synchronously notify the Caretaker of attach and detach transitions. 
This ABI must also handle Caretaker replacement during the adoption 
phase: when the new kernel retrieves the vCPU, it requires a protocol to 
notify the running Caretaker that the pCPU is being onlined. The 
Caretaker must reach a known, state at that moment so the kernel can 
seamlessly replace the previous kernel's Caretaker version with the 
current one. Finally, the Caretaker still relies on the CCB to access 
KVM routing pointers for forwarding VM exits back to the host during 
normal operation.

> > During the execution of the KVM_SET_CARETAKER ioctl, instead of
> > pointing the hardware's return path to standard KVM entry points (e.g.,
> > vmx_vmexit or svm_vcpu_run), KVM reprograms the host-state return area
> > of the CPU's hardware virtualization control structures (e.g., Intel
> > VMCS, AMD VMCB, or ARM equivalent) to point directly into the
> > bare-metal Caretaker environment.
> 
> This can be done unconditionally for all VMs based on a module parameter,
> again as in Arm nVHE.

Makes sense.

> 
> > Note on Optimization vs. Security: Constantly switching the page table
> > (CR3) on every VM Exit can be expensive due to TLB flushing. To
> > optimize performance, the Caretaker can share the host kernel's page
> > tables while the kernel is still around, and dynamically replace
> > HOST_CR3 with the dedicated, isolated page tables only when the vCPU is
> > orphaned (during the detachment phase). On the other hand, maintaining
> > a permanently isolated CR3 for the Caretaker adds a strong security
> > boundary, achieving hardware-enforced separation similar to KVM Address
> > Space Isolation (ASI).
> 
> Agreed on this.
> 
> > The Caretaker requires a defined ABI to communicate with the host KVM
> > subsystem. This ABI is implemented via the shared, identity-mapped .ccb
> > section of the ELF payload, acting as the Caretaker Control Block
> > (CCB).
> > 
> > The CCB acts as the source of truth for the Caretaker's execution loop
> > and contains three primary elements:
> > 
> >    * Attachment State Flag: An atomic variable indicating the current
> >      relationship with the host KVM subsystem (e.g., KVM_ATTACHED or
> >      KVM_DETACHED).
> 
> This must be done atomically at the time Linux offlines/onlines a pCPU. The
> interface from Linux to the caretaker must use some kind of IPI so that the
> new kernel can force a VMEXIT (if needed) in the caretaker, ask it to
> serialize the vm state, and pass it down to the new kernel's caretaker.

Yes, agree.

> 
> >    * KVM Routing Pointers: The physical function pointers that the
> >      Caretaker uses to safely jump into the host KVM's standard VM Exit
> >      handlers when operating in normal mode.
> >    * Shared Configuration Metadata: A physical pointer to dedicated
> >      memory pages used by the kernel to share dynamic vCPU configuration
> >      data with the Caretaker. Because every guest is configured
> >      differently, KVM populates these pages with the specific parameters
> >      negotiated during VM initialization (such as CPUID feature masks,
> >      APIC routing, and timer states). These pages also include a
> >      pre-allocated Telemetry Buffer for the Caretaker to log VM Exits
> >      and spin-wait durations. These dedicated pages are explicitly
> >      preserved across the host reboot via KHO, ensuring the Caretaker
> >      maintains continuous access to the exact context required to
> >      accurately emulate trivial exits during the gap.
> 
> All this is mostly unnecessary if the caretaker is provided by the kernel.
> The recently introduced remote ring buffers can be used for tracing too.

I will need to learn more about how remote ring buffers work, but it 
would have to be possible to use them even when there is no kernel. So, 
as I understand it, something like this would happen:

The old kernel allocates the remote ring buffer, passes the physical 
address to the Caretaker, and preserves this memory via KHO.

During the kexec gap (when the host kernel is completely offline), the 
Caretaker acts purely as a producer, writing trace events directly to 
this physical memory block and advancing the ring buffer pointers.

When the new kernel boots and re-adopts the orphaned vCPU, it retrieves 
this memory from KHO and attaches it back to the tracing subsystem.

> > The Caretaker first evaluates the VM Exit reason. If the exit belongs to
> > a category that the Caretaker is programmed to resolve natively, it
> > handles it internally. For example, profiling of guests has identified
> > the following exit categories for potential local resolution:
> > 
> >    * Guest Idle Exits (e.g., HLT): When the guest OS goes idle, it
> >      triggers idle exits. The Caretaker intercepts these and halts the
> >      physical core until the next guest-bound interrupt fires, preserving
> >      host power.
> 
> I don't think HLT can be handled entirely here.  Either you skip the exit
> completely or you have to go out to the scheduler.  The HLT exit could be
> skipped unconditionally for an orphaned VM, but while there is a running
> kernel the caretaker has to run entirely with interrupts off and that limits
> what you can do.
> 
> In fact there is already a blueprint of what can be handled easily in the
> caretaker, namely vmx_exit_handlers_fastpath()/svm_exit_handlers_fastpath().
> Stick to what exists already.

I agree regarding HLT: during the gap, the simplest approach is to just 
skip the exit and return directly to the VM without attempting to handle 
it.

Also, yes, vmx_exit_handlers_fastpath() and svm_exit_handlers_fastpath() 
provide a good blueprint for the VM exits that can be handled directly 
in the Caretaker.

> 
> >    * Timer and APIC Exits: Even an idle guest frequently writes to
> >      interrupt controllers and system registers to configure internal
> >      timers. The Caretaker handles these trivial writes directly,
> >      acknowledging the timer updates.
> 
> This depends heavily on the implementation of the hypervisor, for example it
> can be done on Intel via the preemption timer but not on AMD where an actual
> hrtimer is needed.

The Caretaker will have varying degrees of support depending on the 
architecture.

For the initial PoC, we can start with the most primitive form: treating 
these as blocking exits across all relevant architectures (Intel, AMD, 
ARM).

Beyond the PoC, we will expand this functionality independently per 
platform to reduce the blackout window, berpaps based on fastpath 
support. If a specific architecture lacks the hardware features to 
handle a certain exit natively in the Caretaker, it will remain a 
blocking exit on that platform during the gap.

> 
> [...]
> 
> > When the new VMM process spawns, it retrieves the
> >     preserved session and issues LIVEUPDATE_SESSION_RETRIEVE_FD using
> >     its token. LUO invokes KVM's .retrieve() callback to map the
> >     preserved vcpufd back into the new VMM's file descriptor table. As
> >     part of this retrieval process, the host formally brings the
> >     isolated pCPU back online, and the new VMM userspace thread is
> >     attached back to the active VM thread running on the vCPU. Finally,
> >     KVM populates the new KVM Routing Pointers in the CCB and
> >     atomically flips the Host State Flag back to KVM_ATTACHED. This
> >     breaks the Caretaker's spin-wait loop (if it is in this state),
> >     allowing standard KVM operation to resume.
> 
> This would also include some kind of serialization of the old VM into the
> new kernel's struct kvm_vcpu.

> 
> Also some kind of feature negotiation is needed (if that fails, the VMs are
> terminated unceremoniously) so I believe that the transition into and out of
> the gap must be synchronous.  For example with INIT/SIPI for the entry, and
> an IPI for the exit?

Yes, the serialization of the old VM state into the new kernel's struct 
kvm_vcpu is handled via KHO (Kexec Handover) during the LUO .preserve() 
and .retrieve() phases.

Regarding feature negotiation, compatibility checks are a fundamental 
requirement for live update. If the new kernel does not support the 
features required by the preserved VM, the update should ideally be 
aborted before the point of no return, or as you said, the VM must be 
terminated unceremoniously.

I completely agree that the transition into and out of the gap must be 
synchronous. As discussed above, using an IPI is the right approach. For 
entry, the host kernel signals the Caretaker via IPI to ensure it 
reaches a known state before the pCPU is offlined. For exit, the new 
kernel sends an IPI to the orphaned pCPU to force a VM exit, allowing 
the new kernel to take control, update the Caretaker environment, 
and complete the reattachment.

> > Guest-to-Guest IPIs
> > -------------------
> > 
> >    * The Problem: If the guest OS attempts to wake up a sleeping thread,
> >      one orphaned vCPU will send an Inter-Processor Interrupt (IPI) to
> >      another orphaned vCPU. In standard virtualization without hardware
> >      assistance, writing to the APIC ICR (or sending an ARM SGI) causes
> >      a VM Exit so the host KVM can emulate the message delivery. During
> >      the gap, KVM is unavailable to route this message.
> > 
> >    * Proposed Solution: The architecture may leverage hardware virtualized
> >      interrupts (Intel APICv, AMD AVIC, or ARM GICv4.1 virtual SGIs).
> >      This allows the hardware silicon to handle IPI delivery between the
> >      isolated pCPUs natively, eliminating the VM Exit. Alternatively,
> >      the Caretaker can be programmed to emulate the IPI delivery. By
> >      utilizing the shared memory metadata, the Caretaker can determine
> >      the target vCPU and directly update its pending interrupt state.
> 
> Yeah, I think APIC emulation to some extent must be moved into the VMX/SVM
> fastpaths.  The good news is that this can be done already as a PoC without
> needing the whole caretaker and LUO infrastructure.

Moving APIC emulation into the VMX/SVM fastpaths makes sense as a 
standalone effort.

> 
> >    * The Problem: What happens if a Non-Maskable Interrupt (NMI), a
> >      hardware timer tick, or a Machine Check Exception / System Error
> >      (MCE / ARM SError) arrives while the CPU is actively executing
> >      Caretaker code in KVM_DETACHED mode?
> > 
> >    * Proposed Solution: To safely handle these asynchronous events, [...]
> >      on x86, when transitioning into the gap, KVM explicitly programs
> >      HOST_IDTR and HOST_GDTR to [the caretaker's] tables.
> 
> Agreed and this also shows that the transition must be synchronous.
> >    * The Problem: As the guest executes, it may attempt to access memory
> >      that has not yet been mapped by the hypervisor, or it may interact
> >      with MMIO regions. Normally, this triggers an EPT Violation (Intel)
> >      or NPT Page Fault (AMD), prompting KVM to allocate host pages and
> >      update the secondary page tables. How are these updates handled
> >      when the host KVM subsystem is offline during the gap?
> > 
> >    * Proposed Solution: During the "Management Gap," there are absolutely
> >      no updates made to the NPT/EPT. The existing secondary page tables
> >      are fully preserved in memory via LUO kvmfd preservation prior to
> >      detachment, allowing the guest to seamlessly access all previously
> >      mapped memory. If the guest triggers a new page fault (requiring an
> >      NPT/EPT update) during the gap, the Caretaker simply categorizes it
> >      as a Blocking Exit.
> 
> Yes, by default everything is a blocking exit.  In particular, unless one
> day we do x86/pKVM, page tables can be handled entirely by Linux rather than
> the caretaker with no change to the existing MMU notifier architecture.
> 
> As a consequence, the caretaker is absolutely not going to be a TCB---at
> least not in the beginning.

+1.

> 
> > Compromised Caretaker
> > ---------------------
> > 
> >    * The Problem: The Caretaker runs in Host Mode. If left unprotected,
> >      this could allow a lightly privileged userspace process (e.g., QEMU
> >      or crosvm) to inject arbitrary executable code directly into the
> >      CPU's most privileged hardware state (VMX Root / Ring 0 / EL2).
> > 
> >    * Proposed Solution: To mitigate this risk, the KVM_SET_CARETAKER
> >      ioctl may adopt the security model used by the kexec_file_load()
> >      syscall. Rather than trusting userspace to pass physical addresses,
> >      the kernel must take full ownership of payload validation:
> 
> -EOVERENGINEERED.  Just shove it into the kernel.

Ok.

> 
> > Caretaker Update
> > ----------------
> > 
> >    * The Problem: Given that the Caretaker is permanently installed
> >      during VM setup, how does it get updated on long-running VMs?
> 
> Via kexec. :)  I understand you have bigger plans, but we need to crawl
> before walk^Wattempting a marathon.

Sure.

> 
> I even wonder if, for long term simplicity, the interface for
> host->caretaker should be just for the caretaker to swallow the host into
> non-root mode, again as in Arm nVHE.  That would make it much harder to
> implement some kind of live update, but my answer to that *really* is just
> to use kexec.
> 
> Paolo
> 
