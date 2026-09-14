Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF03490C02
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408755; cv=none; b=VFB01lbXQMDjQSL8n/jw59WvNqRJERVmjvnLZkqSY0wDCCdpdf/110MxEvj+9xlYBvMtbZ5EErGl9zZmEhZTmOtMXcCQJ08E0p6oFSCWBwHwlGL2Fwg6v/hZIWrvTEuxZjHLcoRSBvM52xpCpMImQXMQ9qgr164VxoAz1DPjQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408755; c=relaxed/simple;
	bh=MAbY5Mo0nA/K3I7UcMf6Tq7Zry9LDS+V2lgnsG3lpJI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KGVqDXLufLq9c/vMfqUhnIVt0aBeGxCjZ3a1/cADV7YK4Vx9AuCgWH5ammnA/Q2qG2GXb7sLv51nXM20DWJUYmw5atXY+YqQVqhv5Iws7ZFH/1ULPPL7aaN/5UQlIKIGh+i72waIP3zFtkR3snesqh+epcPUOqORZdFJfetqovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wqw53wQz; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqw53wQz"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-869b8d63e28so4397525b3a.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789408753; x=1790013553; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qU26IOiWMcfPB8mP9bmkpZumVUbxtT4Rtb9K/TXxTM=;
        b=Wqw53wQz3WoOiHYhLGrku+Jqo7I8yhviX1x6rij9Bx1rQSoxnkAtjY5+GPdHxoK5eC
         tCUSphJTyzjtXVzEcVGi6vjIR48r6O07VlHlsOGPhP+FRO889+UDKBkqinXu0gTHls3T
         2HXQ0QXJkeuJDXqUeRRQXp9rSAnOK7J5xD9CSjSbABiRywmIzBKObQR+qSDNBUt5Qe1U
         NTNwT4xADYVYpE0Zqvb4U869SW++PSkj6NtkpkwyWGhBKdGdf/uQEDr1oaFRAsY/00Cf
         00k5iNdloYc66c3EnshgiwBwaN2KqBnxatdSfySSIQNu7lD/pjULAQR6MoEMvt27MkJY
         yeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408753; x=1790013553;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qU26IOiWMcfPB8mP9bmkpZumVUbxtT4Rtb9K/TXxTM=;
        b=Db3XTM/p9iwiE19jzxir/UffEZmMj6h9R9STCW7Gk4xBKc3vQtg0KUbubyJGkChY4+
         LQgBE3MvUQMbsMfHPeuYKvHekWwi3emQlFGZKYORVuKNhzBSmCb9W4dE0xEpPxbgJjY1
         uKGoy55FSKR/gkwCbbZ/XMHzZVBPJctgIdZZvScGMCSV/Dt3rjuK3EXoA8BiD09mcAKL
         lAzZepCnM34+C1K2sPBgjSc8/BGmBnjS2v7zHbv15IHsyVIsB6T+xB0eICRexB2t/TOP
         9hM9QCKJXGuke7PM4lNIqHIlXzscS5TrMjiFD/xfaLcA7Bq2tgOxOCfGAh6AiJzHRnck
         PAvg==
X-Forwarded-Encrypted: i=1; AKwUvBwLS3RcVm8dFOu/oopd65Fs8BZYqSOmpgMWpXm94+XzHlTAKZX5aN+SHhtwINf/+D69ASA=@vger.kernel.org
X-Gm-Message-State: AFuF++lSbcQYCh5QGMG/3G6IPIOVFbiYRMldxY7qXoJsPlOIhFKf2a9N
	nRA+fxiiEM40rLpUutzoItiILt+9TtknRdpciEDPE1JOm5djwjQL+sWC7qUOFFqsVXTeip4c2gE
	Uo5e1JP6TAPqnSg==
X-Received: from pfiy1.prod.google.com ([2002:a05:6a00:1901:b0:86a:3526:1712])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6017:b0:868:9662:5137 with SMTP id d2e1a72fcca58-86f8394024fmr7147163b3a.11.1789408752631;
 Mon, 14 Sep 2026 10:59:12 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:59:12 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914175912.3338133-1-jmattson@google.com>
Subject: [PATCH] Documentation: KVM: x86: document KVM_GET_*/KVM_SET_* ordering
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KVM does not define a total order for the ioctls that save and restore
guest state, but the ioctls are not fully independent either.  On the
save path, some getters perturb state that another getter reports.  On
the restore path, some setters validate their input against state that
another setter installs, and some setters overwrite state that another
setter has already written.  One pair of restore constraints is a
cycle, which forces userspace to issue KVM_SET_MSRS twice.

Replace the TBD in the x86 section of "Known KVM API problems" with the
partial order that is known to matter, and with the reason for each
constraint.  Note that a misordered getter fails silently, while a
misordered setter usually fails with -EINVAL.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst | 179 ++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9..9181dfcd7251 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9659,4 +9659,181 @@ available.
 Ordering of KVM_GET_*/KVM_SET_* ioctls
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-TBD
+KVM does not define a total order for the ioctls that save and restore
+guest state, and most pairs of them really are independent.  A few are
+not.  When saving, some getters modify state that another getter
+reports.  When restoring, some setters validate their input against
+state that another setter installs, and some setters overwrite state
+that another setter has already written.
+
+The constraints below are the ones that are known to matter on x86.
+They form a partial order, so any topological sort of them will do.
+One pair of restore constraints points in both directions, and forces
+userspace to issue ``KVM_SET_MSRS`` twice.
+
+Note the difference in failure mode.  A getter that runs too late
+silently returns perturbed state, and the damage is only visible in the
+restored guest.  A setter that runs too early usually fails outright
+with ``-EINVAL``.
+
+Saving state
+~~~~~~~~~~~~
+
+* **Get the MP state before any other vCPU state.**
+  ``KVM_GET_MP_STATE`` calls ``kvm_apic_accept_events()``, which latches
+  a pending INIT or SIPI.  Completing an INIT resets the vCPU, and
+  completing a SIPI sets CS and RIP.  Either can also trigger a nested
+  VM-exit, which overwrites most of the vCPU state.  On Intel, both an
+  INIT and a SIPI can exit, and the VM-exit MSR-store list also writes
+  guest memory.  On AMD, only an INIT can exit.  Every other vCPU
+  getter must therefore run after ``KVM_GET_MP_STATE``.
+
+* **Get the irqchip state before the local APIC state.**
+  ``KVM_GET_IRQCHIP`` clears from the reported I/O APIC IRR every
+  edge-triggered IRQ that KVM has already delivered to a local APIC, on
+  the assumption that ``KVM_GET_LAPIC`` will pick it up.  If the local
+  APIC is read first, an IRQ delivered between the two reads appears in
+  neither snapshot and is lost.  The opposite order can at worst
+  duplicate such an IRQ, which is the safer failure.  The constraint
+  applies only to a full in-kernel irqchip, because ``KVM_GET_IRQCHIP``
+  returns ``-ENXIO`` in split-irqchip mode.
+
+* **Get the local APIC state last among the vCPU getters.**
+  On Intel, ``KVM_GET_LAPIC`` drains the posted-interrupt requests into
+  the IRR, so it reports the most complete view of pending interrupts.
+  Any source of interrupts that is still live when it runs can add to
+  the IRR afterwards, and that addition is not saved.
+
+* **Get all vCPU state before the final pass over guest memory.**
+  On Intel, a nested VM-exit out of ``KVM_GET_MP_STATE`` writes guest
+  memory through the VM-exit MSR-store list.  A guest page copied
+  before that write is stale.
+
+Two constraints that older userspace still carries no longer apply:
+
+* ``KVM_GET_MSRS`` no longer has to precede ``KVM_GET_LAPIC``.  Before
+  commit e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in
+  apic_timer_expired on KVM_RUN"), a ``vcpu_load()`` on a vCPU with
+  APICv and the VMX preemption timer could restart the hv timer, find
+  the deadline expired, inject the interrupt, and zero
+  ``MSR_IA32_TSCDEADLINE``.  A ``vcpu_load()`` between the two getters
+  therefore lost the interrupt and the deadline together.
+
+* ``KVM_GET_VCPU_EVENTS`` no longer has to precede ``KVM_GET_SREGS``,
+  ``KVM_GET_SREGS2`` or ``KVM_GET_DEBUGREGS``.  When
+  ``KVM_CAP_EXCEPTION_PAYLOAD`` is disabled, KVM delivers the payload of
+  a pending #PF or #DB into CR2 or DR6 before it reports the exception,
+  because userspace might not preserve the payload across a migration.
+  Before commit d0ad1b05bbe6 ("KVM: x86: Defer non-architectural deliver
+  of exception payload to userspace read"), only ``KVM_GET_VCPU_EVENTS``
+  delivered it, so a CR2 or DR6 read first was stale.  All four getters
+  now deliver it, and therefore agree in any order.
+
+Userspace that runs on older kernels should keep both orders.  Enabling
+``KVM_CAP_EXCEPTION_PAYLOAD`` is worthwhile in any case, because it
+stops KVM from delivering the payload early at all.
+
+One more hazard is not an ordering constraint, because it depends on
+elapsed time rather than on sequence.  ``KVM_GET_CLOCK`` and a read of
+``MSR_IA32_TSC`` describe the same instant only if little time passes
+between them.  Userspace that needs a time-invariant value should
+prefer the ``KVM_VCPU_TSC_OFFSET`` attribute of ``KVM_VCPU_TSC_CTRL``
+over ``MSR_IA32_TSC``.
+
+Restoring state
+~~~~~~~~~~~~~~~
+
+* **Set CPUID and the feature MSRs first.**  KVM freezes the virtual CPU
+  model once the vCPU has run or once it is in guest mode.  After that,
+  ``KVM_SET_CPUID2`` and writes to the immutable feature MSRs, which
+  include the ``MSR_IA32_VMX_*`` MSRs, only succeed if they do not
+  change anything.  Because ``KVM_SET_NESTED_STATE`` can put the vCPU
+  into guest mode, userspace that writes the VMX capability MSRs after
+  restoring nested state will fail to restore an L2 guest.  CPUID also
+  gates the validation performed by ``KVM_SET_SREGS``,
+  ``KVM_SET_XCRS``, ``KVM_SET_NESTED_STATE`` and the ``MSR_IA32_APICBASE``
+  and ``MSR_IA32_XFD`` writes.
+
+* **Set the TSC frequency before the TSC.**  A host write of
+  ``MSR_IA32_TSC`` computes a TSC offset, and a scaling ratio if TSC
+  scaling is in use, from the current guest TSC frequency.
+
+* **Set MSR_IA32_FEATURE_CONTROL before the rest of the vCPU state.**  A
+  host write of zero to this MSR forces the vCPU out of VMX operation.
+  That discards the nested state, and replaces the register state with
+  the L1 host state if the vCPU was running L2.  Only a write of zero
+  has this effect; clearing individual bits, including the VMXON bits,
+  does not.  The hazard therefore belongs to userspace that resets a
+  vCPU before it restores one.
+
+* **Set the special registers before the nested state.**  This
+  constraint is specific to SVM, where the live register state is the L2
+  state.  ``KVM_SET_NESTED_STATE`` rejects a saved guest mode unless
+  EFER.SVME is already set, it validates the live CR0, and it reloads
+  the CR3 that ``KVM_SET_SREGS`` installed.  On VMX the L2 control
+  registers come from the VMCS12 instead.
+
+* **Set the APIC base and the special registers before the local APIC
+  state.**  Changing the APIC enable or x2APIC bit resets the APIC ID,
+  which would clobber the ID restored by ``KVM_SET_LAPIC``.  Separately,
+  the CR8 field of ``KVM_SET_SREGS`` carries only bits 7:4 of the task
+  priority register, so a CR8 write after ``KVM_SET_LAPIC`` clears TPR
+  bits 3:0.
+
+* **Set the irqchip state before the local APIC state.**
+  ``KVM_SET_IRQCHIP`` re-injects the restored I/O APIC IRR into the
+  local APICs.  ``KVM_SET_LAPIC`` must run afterwards so that it
+  overwrites the IRR wholesale; otherwise those interrupts are
+  delivered twice.
+
+* **Set the XSAVE state before MSR_IA32_XFD.**  ``KVM_SET_XSAVE`` clears
+  from the incoming header every state component that the current XFD
+  value disables.  Writing XFD first therefore discards the state of
+  those components.
+
+* **Set the special registers before the MP state.**  ``KVM_SET_SREGS``
+  forces a boot-strap processor whose incoming state looks like a reset
+  state back to ``KVM_MP_STATE_RUNNABLE``.
+
+* **Set the clock last.**  ``KVM_SET_CLOCK`` establishes the kvmclock
+  epoch, and should run as close as possible to the moment the vCPUs
+  resume.  The per-vCPU ``MSR_KVM_SYSTEM_TIME`` and
+  ``MSR_KVM_WALL_CLOCK`` writes only record the guest page address, so
+  they must precede it.
+
+* **Place KVM_SET_VCPU_EVENTS on the correct side of the nested
+  state.**  For a vCPU in guest mode it has to run afterwards, on both
+  vendors, because it writes the interrupt shadow and the NMI mask into
+  the VMCS or the VMCB that is currently loaded, and the nested one
+  becomes current only once ``KVM_SET_NESTED_STATE`` has entered guest
+  mode.  A vCPU in SMM needs the opposite order, but on Intel only:
+  ``KVM_SET_NESTED_STATE`` rejects the saved ``smm.flags`` unless the
+  vCPU is already in SMM, and only ``KVM_SET_VCPU_EVENTS`` puts it
+  there.  The AMD nested state has no equivalent field, because SMM
+  saves and restores the nested state through SMRAM instead.  The two
+  cases never coincide, because SMM temporarily disables VMX operation,
+  so a single call always suffices.
+
+The vendors disagree about the registers.  On SVM the live register
+state *is* the L2 state, so ``KVM_SET_REGS`` and ``KVM_SET_SREGS`` have
+to run before ``KVM_SET_NESTED_STATE``.  On VMX the L2 RIP and RSP come
+from the VMCS12, which ``KVM_SET_NESTED_STATE`` reloads, so
+``KVM_SET_REGS`` is better issued afterwards.  Portable userspace can
+write the registers on both sides of ``KVM_SET_NESTED_STATE``.
+
+KVM_SET_MSRS has to be issued twice
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``KVM_SET_LAPIC`` sits between two MSR writes that cannot be combined
+into one call.
+
+``MSR_IA32_APICBASE`` has to precede it.  Changing the APIC enable bit
+or the x2APIC bit resets the APIC ID, which would discard the ID that
+``KVM_SET_LAPIC`` restored.
+
+``MSR_IA32_TSCDEADLINE`` has to follow it.  A write to that MSR is
+dropped unless the LVT timer is already in TSC-deadline mode, and only
+``KVM_SET_LAPIC`` establishes the mode.  In the other direction,
+``KVM_SET_LAPIC`` cancels the timer and zeroes any deadline that is
+already armed.  The deadline is an absolute guest TSC value, so
+``MSR_IA32_TSC`` has to be restored before it as well.

base-commit: 827751b699b79a6e569983359c02dce67f81b94c
-- 
2.55.0.1032.g73a4cd73de-goog

