Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D41371048
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274973; cv=none; b=kSVvex7QVzP0IbD0pYBYfbC5AB+zFDBgIZWUZo3T8lw7VfB2XJH/cKc+JV8QOrmN2qe3jZTCDxIoQN8Ebz1bc098Xhdsr8jMyyiw1jvCUO5O7QFiXR6dmV5LovmO+wDN1877pwVbgGNWmX26o2nE6v3SDm6R4xzz4vwAu5K3kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274973; c=relaxed/simple;
	bh=aPsklNPo0W8DL5HXCBB++z7kDGPN6SVBg/uNwc4jm0s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=t4U60y3RzI2pmdVSNSg5nVvN7+QZ1zjABWugOFQRT37qJ7AYo+odeiw3gl5YVSCtbfjCWNdMduknrc15xL17zNV3h80rgjSxQOZ2f0mHSVSrAauQhXw1wkjq6AzRoAf6ltLW1yAgUU3tzJG4V4c0GQOoKv6YJNTVSzM1jGmhyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPEC0BdG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPEC0BdG"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842307473b5so821942b3a.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274971; x=1781879771; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTVHpWDAc44gU8kS/zE/FGdewgWSDCACvR7pfF1CeHQ=;
        b=BPEC0BdGTktGoRQv6bWhr4p79IrM8xexGVsZhIcVwEe6tiwJ0NpcdRynoIym+rTMMU
         oqwyc+tOLSCfT65iSXHwf6uG9D7ac+z08tLxd16dBPlQt3OcpERfiblS1WCOOc3/WoKe
         Qn28mA/JaNLv3m5HBqogjGn/ELkNm+vqXyRaEYNE3r3kF2cHKMohlbXE1Rpxz72OvF1H
         xvELDLzFaz/qz/dyT4sZB8JuzqSThAcw+g3HnNV5nu+7bKxwGBl7Lo42C4bZBcsjLbgu
         0ggsscNDncd6YuUHi86tj3llI8KhSvRvlEl8bsUJ/AsskzNAjXHqVIhwaO7186ZTalY+
         L8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274971; x=1781879771;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTVHpWDAc44gU8kS/zE/FGdewgWSDCACvR7pfF1CeHQ=;
        b=TYSZP5N3GBPNqCgGROY5+a4nRcDvvVrVlDAadR9sMXJtsVtvwzAXox3micU3G6mmzK
         2kIRpkkOO24w7u4MsBKxFBVwCYb/QF9aAFNMdhFuOITf1OmrjBcqElgw++wz/aSQVdZX
         2p24GF4t72cUUwtwG4xjP86HvoixoPYeHPcfM3WHIwC+17laWb7SvjmZi7j7zqFWYVEm
         7qXZlGuCIx35mgFDDIVL/I/vcFk48JiF6YZ4k1GnKdmkpe/DZDqrqAnlTGvVmba2DXSN
         Yq3UdfU7Bq+rV7w3PO22SDyRArPHJNaGFyO+1CS4z3XZlHpDgwgdSoeZ0Dfx5rntSgC+
         bK1w==
X-Gm-Message-State: AOJu0Yw/dktotgyAtiYpAgVl7gA2WRl+jMGHe8MrIkS3plwDJYC4PPSp
	vcWeqtzwVltlVcdySTcQxMMCDOEnQu8QgRFA9oC3TwtqcFQVK3ie5ngO
X-Gm-Gg: Acq92OFJ/E1KwS13SqnbfhuZxkuhfQ5kDKmu3JBDX9sERgpogOhM/S8kSFoCIRi6xQm
	e8cKXfJuB7f7eystsWzH+yMkbWdUUSJkD1V+4bQBofc9YfgAOyPI+BeM2qVk2oExrWOiCJl1DT3
	m6XitvXgIhAo0Fe619ZtE2YT6+LzoryVzmoP5v5G0jxS6gH4++YPRzzkdSz6ydq0+iuQJZv46+L
	RiHie3xKEUo7TG7FQ+nw8t3oed1HctiszhbhbD5aLNJwgTyDlb1NAb8Uj0+CK7mMosOeTFh7xOn
	BUnYrsxOiSH1TP8zMYO5JPyJfg+WMniBSYXZRAoeGpVhAj08yxiu0MtqfndVar52syv9VTibGLi
	YrQDlOs0dE+aOHzNN5U1Z+CE5ctEFKTYCc/CPigjfTI+eGabr8KdusCx222gI6jKB0EMjLxQqxA
	h3IaJoR90mErTT5ONZAzVbHFku8qmt5eV7reYw
X-Received: by 2002:a05:6a00:f93:b0:842:46a6:e2cf with SMTP id d2e1a72fcca58-8434ce46552mr3664545b3a.21.1781274971241;
        Fri, 12 Jun 2026 07:36:11 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf039fsm2390771b3a.20.2026.06.12.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:36:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
In-Reply-To: <aiml9iB_vUASRRQV@google.com>
Date: Fri, 12 Jun 2026 18:19:37 +0530
Message-ID: <ik7nexem.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com> <aiml9iB_vUASRRQV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> 
>> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
>> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
>> VM's limit.
>> 
>> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
>> to the kvm_create_max_vcpus test case to limit vCPU IDs to
>> KVM_CAP_MAX_VCPUS on powerpc.
>
> How is this not a KVM bug?  Literally the reason this test exists is to validate
> KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.

It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
vcpu id = core * stride + thread,
  .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)

So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
with the maximum stride / SMT value.

Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.

e.g.
static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
...
		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
			pr_devel("KVM: VCPU ID too high\n");
			core = KVM_MAX_VCORES;              /* rejected case */
		} else {

So, it's expected on PowerPC. vcpus with higher IDs can be created but
for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
But since the test as of now is not doing that - that's the reason why
the patch only allows to test max vcpu IDs upto max vcpus.



But I guess you must be hating the #ifdef __powerpc__ there. I agree I
don't like it either.. maybe we can do it this way?


-#ifdef __powerpc64__
        /*
-        * powerpc has a particular format for the vcpu ID that depends on
-        * the guest SMT mode, and the max ID cap is too large for non-SMT
-        * modes, where the maximum ID is the same as the maximum vCPUs.
+        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
+        * so a default VM can't necessarily use the full advertised ID range.
+        * Let the arch limit the highest ID this test will create.
         */
-       kvm_max_vcpu_id = kvm_max_vcpus;
-#endif
+       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);


And then in kvm_util.c -
+
+__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
+{
+       return vcpu_id_max;
+}

and lib/powerpc/processor.c can define -

+
+int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
+{
+       /*
+        * The stride is the default SMT mode from KVM_CAP_PPC_SMT (1 on
+        * POWER9+, the host's threads-per-subcore on POWER8) and is always <=
+        * MAX_SMT_THREADS, so the result never exceeds KVM_CAP_MAX_VCPU_ID.
+        *
+        * TODO: exercising the higher (sparse) ID range would require setting
+        * KVM_CAP_PPC_SMT and creating strided vCPU IDs.
+        */
+
+       int stride = kvm_check_cap(KVM_CAP_PPC_SMT);
+
+       return nr_vcpus * (stride > 0 ? stride : 1);
+}


If this looks good, then I can re-spin a newer version with the
following changes:

1. Use above logic in Patch-4 for kvm_create_max_vcpus_test instead of
   hardcoded #ifdef __powerpc__ logic.

2. Drop patch-5 (print vcpu_id) debug patch

3. Squash all the type specifier changes i.e. Patch 6-10 in the main
   Patch-3, the patch which adds kvm selftests support for powerpc.


-ritesh
