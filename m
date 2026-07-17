Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53DE373BF6
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305622; cv=none; b=Xd12yE4jetYgt6sOXdToa98nNUj5qpW3467FlmB84WZKA13h7U9M+OoUaaDBhla9TaU/k6Et5+EFekVpkM5EOzxTZx7amWLckeDDAAZU5rQtXdzUeOIwUKDireZx7jBdvPnOZ3LU087uNM6eDwo5FXZzm756DAIJt/XOyWqJaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305622; c=relaxed/simple;
	bh=jc+NwcWgmEhGx3l3WIzlscIOvmVGOgKdKNIu/nrnPJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VpKSGXpamXNFs2bI8BItn7UqHozSDtvdpiFzEHFZWoYzP3yGW94hlwbPjuzuyDyWfhOlXY+T0mdmpAx4vjGERH/oFTQBfe4hDFutOaVuzHBMdobDZ+xhRugbzKmqvkc+xT23uFEEZopiWZE/jl4GQtCeebYL0Hbm7agEOCxLPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHEPnsQX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHEPnsQX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso420951a91.2
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784305620; x=1784910420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oMnn6SXBHrJTwxImwTs7m6CLT8NGFTr2oUehXQ3gnk0=;
        b=pHEPnsQX7tgrVU1hSW2zNE2p+b1Z4tkAVPOI8nG/jWMrBIcqrSdzJfvgY7o/d7ZH7L
         P1k+EzqAeeTzLRS0dSP4QsFdloaF71U8b1RTZYuXuDtHOrCzG/gI8poMT4Awm8LxJFOG
         H2wEcXwxshz0u4xdenMO4R4iGQMX6UK2W+rR6xLbbrkW0KYIG0lVG4DIGvZg1Fsb1LeY
         /Q0O+rDRgvpBx/87qwOr/B0Ka9ijl9GsFq4VQsW2XQvCJ4/dlic1boOdR9xMveukZCnd
         Fx4/EapDZ9DFcirXLcN5uGka+TAIJTTilpir9Ki3jfUoA+4qrRyb6o6KmgY9mbHytXMB
         AE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305620; x=1784910420;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMnn6SXBHrJTwxImwTs7m6CLT8NGFTr2oUehXQ3gnk0=;
        b=OS3O95+T55J0wL/RLdtthqD8LSPRamvTuFgii7DjFo3WP0zy4B4DumM8xUR44VtQoM
         jjuXR2VpRkU2x+BB6LVEMQ+YttjSz9jF1xoa+aCzNyT/4pMvnTBV/CN76aMtc7WfP5jA
         I2A5ZL3WYm1teOHhBUZiVg2a+/z9kw8WQg7TN+aiME8zw6L/kU4cB5e5frhr+3hCMR+z
         AGIhwog4WZ37B/+Y4qtdtaVvs1uDeNp6PJ8uDOrEia5tKCUw7VN6VH4bYh8xA7q11RE+
         9vzeOh7NFdRgZq7SMoioOnvQOUTx8A3KzPjoh9KxjjowThiI43vZX2UaBSLV5/+HHwSN
         3iNw==
X-Gm-Message-State: AOJu0Yx9DjrQIMtPCrfZLt9n3pHwOL6/l4gYmufo/zLAZY5YPiCUc1Cb
	lN/DIBkMVp7xdAiSu38PvR4j356uAO0sXhIEoYqXrTUEDvRZmazFpcG+XY+5QLTVP4+0640VA22
	D76azwnZYAnmCV9kx37Ives4OySXjfzLh6tS47DhoT4eaA0aa5YntZfGUDDEivbemGmiAPqaMpe
	4y/3rY8T6MBqx+rKVIaBByPBLE6Nk47FwjXopEud2FFZDOv+lyvBSm0fUi9EA=
X-Received: from pjbfr5.prod.google.com ([2002:a17:90a:e2c5:b0:381:ce43:283c])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:224e:b0:37f:9ce0:af36 with SMTP id 98e67ed59e1d1-38e4b5a823bmr3348538a91.33.1784305619074;
 Fri, 17 Jul 2026 09:26:59 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:26:57 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717162658.2833515-1-jingzhangos@google.com>
Subject: [RFC] KVM: Proposed uAPI for querying GSI and irqbypass status
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Mingwei Zhang <mizhang@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This RFC proposes a new KVM uAPI to allow a VMM to programmatically
query the status of a GSI, with a particular focus on determining
the success or failure of Irqbypass.


1. Motivation

The primary motivation for this uAPI is to bridge the operational gap
between the VMM and KVM at the kernel level regarding interrupt
virtualization status:

* KVM (Kernel) holds the precise, live runtime status of each GSI (such
  as whether Irqbypass is active, pending, or has encountered a setup
  error). However, it completely lacks the high-level semantic details
  of those GSIs=E2=80=94it does not understand which logical function or
  physical hardware device they represent.

* The VMM (Userspace) possesses the complete context of the guest's
  interrupt topology. It knows exactly which GSI belongs to which
  passthrough or emulated device because it orchestrated the setup.
  Yet, the VMM has no stable, programmatic way to query the actual
  runtime execution status of these GSIs once passed to the kernel.

Currently, diagnosing when a high-performance interrupt path falls
back to software mediation is highly problematic:

* While some architectures (like ARM64) expose virtual ITS states via
  debugfs, this implementation is highly architecture-specific and
  fragile.

* debugfs is not a stable API, is prone to breaking changes across
  kernel versions, and is entirely unsuitable for programmatic
  production monitoring and fleet-wide observability.

This is not an ARM-specific problem; it is a general, cross-architecture
limitation within KVM's Irqbypass and interrupt routing subsystem.
By introducing an architecture-neutral uAPI, we allow the VMM to
marry its topological knowledge with KVM's live execution state.


2. Main Design Idea

Based on recent community discussions, this proposal follows a set of
agreed-upon design principles:

* Architecture-Neutral: The API is a generic ioctl on the VM file
  descriptor, using the GSI abstraction.

* Extensible: The API provides an in-struct union with a dedicated size
  reservation. This avoids the complexity of userspace and kernel
  managing separate data allocations or chasing userspace pointers.

* Decoupled: It is a KVM ioctl, maintaining the separation between
  the KVM and VFIO subsystems.

* "Pull" Model: The VMM explicitly queries the state of a GSI on
  demand.

We propose a new ioctl on the VM file descriptor: KVM_GET_GSI_STATE.


3. Proposed API Definition

The following sample code defines the proposed ioctl and its
associated data structures.

/* To be included in <linux/kvm.h> */

/*
 * KVM_GET_GSI_STATE: Get the status of a specific GSI.
 *
 * The user passes a pointer to struct kvm_gsi_state. The kernel fills in
 * the status flags, performance counters, and the architecture-specific
 * union members directly.
 */

/* Generic flags indicating high-level status */

/*
 * The GSI's route is theoretically compatible with hardware bypass
 * on this host (e.g. is an MSI route and GICv4/VT-d is present).
 */
#define KVM_GSI_STATE_FLAG_BYPASSABLE      (1 << 0)

/* An IRQFD is currently active and bound to this GSI */
#define KVM_GSI_STATE_FLAG_HAS_IRQFD       (1 << 1)

/* The irqbypass path is fully enabled and active in hardware */
#define KVM_GSI_STATE_FLAG_BYPASS_ACTIVE   (1 << 2)

/* Example architecture-specific failure reasons for ARM64 */
#define KVM_ARM_GSI_FAILURE_REASON_NONE             0
#define KVM_ARM_GSI_FAILURE_REASON_NO_ITS           1 /* No ITS/GICv4 suppo=
rt */
#define KVM_ARM_GSI_FAILURE_REASON_NO_MSI_ADDR      2 /* MSI address unset =
*/
#define KVM_ARM_GSI_FAILURE_REASON_GIC_HW_REJECT    3 /* GIC rejected map *=
/
#define KVM_ARM_GSI_FAILURE_REASON_INVALID_STATE    4 /* Guest state block =
*/

struct kvm_gsi_state {
    __u32 gsi;              /* IN: The GSI to query */
    __u32 flags;            /* OUT: High-level status flags */
    __u64 counter_success;  /* OUT: Generic counter for successful bypass *=
/
    __u64 counter_failure;  /* OUT: Generic counter for failed bypass */

    union {
        struct kvm_arm_gsi_state {
            __u32 failure_reason;   /* OUT: Last reason for bypass failure =
*/
            __u32 padding;          /* OUT: Explicit padding alignment */
            __u64 vgic_its_vlpis_hw;/* OUT: counter for directly injected v=
LPIs */
        } arm64;

        /* Pad union to 128 bytes to allow future arch growth */
        __u64 pad[16];
    };
};

#define KVM_GET_GSI_STATE _IOWR(KVMIO, 0xXX, struct kvm_gsi_state)


4. Implementation Sketch

The KVM_GET_GSI_STATE ioctl handler would perform the following
high-level steps:

1. Find the GSI Route: The handler would take the input gsi and look it
   up in the VM's kvm->irq_routing table to find the corresponding
   kvm_kernel_irq_routing_entry.

2. Evaluate Bypass Capability: The kernel checks if the GSI
   routing entry type and target are capable of utilizing hardware bypass
   under the current host hardware configuration. If so, KVM sets
   KVM_GSI_STATE_FLAG_BYPASSABLE.

3. Locate the Irqfd Context: The kernel searches its registered
   irqfds. If an active kvm_kernel_irqfd is bound to this GSI, KVM sets
   KVM_GSI_STATE_FLAG_HAS_IRQFD. This context is the key to finding
   the active bypass status, as it contains the irq_bypass_consumer.

4. Inspect Irqbypass Status:
   If an active irqfd is found, the handler inspects consumer->producer.
   If a physical producer is successfully paired and the hardware-level
   link is fully established, KVM sets KVM_GSI_STATE_FLAG_BYPASS_ACTIVE.

5. Gather Performance Counters: To implement the counters, new
   atomic64_t fields for success_count and failure_count would be added
   to the struct kvm_kernel_irqfd. These counters are essential for a
   VMM that polls on a semi-regular basis to detect if the bypass state
   has changed or flapped over time (e.g., during vCPU migrations,
   routing updates, or device resets). By observing increases in these
   counters across poll intervals, the VMM can detect bypass path
   instability or dynamic teardowns without requiring high-overhead
   asynchronous event notifications. The ioctl handler simply reads
   these atomic values.

6. Architecture-Specific Logic (ARM64 Example): The kernel detects the
   target architecture and directly populates the corresponding arm64
   nested struct within the kvm_gsi_state union:

   * Inspect the vGIC state for the virtual interrupt corresponding to
     the GSI.

   * Check internal flags that were set during the
     kvm_vgic_v4_set_forwarding call to determine the reason for a
     failure. For example, if vgic_its_resolve_lpi failed because the
     MSI address was zero, this would have been recorded, and KVM would
     populate failure_reason with KVM_ARM_GSI_FAILURE_REASON_NO_MSI_ADDR.

   * Check if the host GIC supports the required features (ITS, GICv4),
     populating failure_reason with KVM_ARM_GSI_FAILURE_REASON_NO_ITS
     if not.

   * Read KVM-internal counters to populate fields like
     vgic_its_vlpis_hw.

   * Copy the populated kvm_gsi_state structure back to userspace in a
     single memory transaction.


5. Open Questions and Points for Discussion

1. Structure and Flags: Are the proposed kvm_gsi_state and nested
   arm64 union structures sufficiently comprehensive? Are the flag
   names clear?

2. Failure Reasons: Are there other common Irqbypass failure modes on
   ARM64 (or other architectures) that should be included in the
   enumeration?

3. Performance Counters: Is adding atomic counters to the
   kvm_kernel_irqfd struct the right approach, or should this be handled
   in a different data structure to avoid bloating the Irqfd context?

4. Extensibility: Does the nested union and its 128-byte pad provide
   enough headroom for other architectures (like x86 posted interrupts
   or RISC-V) to implement their diagnostic payloads in the future?

We believe this new API would be a significant step forward for the
observability and manageability of KVM in production environments. We
look forward to the community's feedback on this proposal.
