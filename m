Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376831;
	b=vn3fZEeQlyUy9Gg0KQoeK5X7RnHAfTcBO5SImxW1hZmIdi+SJuC/63ONv1NzPQfv7Lln
	 dDzYe54EORsU+cHOLHxjt4Fnus10H7ux0AoPHlfwaSoP60q2n/kYIhDJILtS8mEdvOTyN
	 cF12X5PFY5dvWrB+N+XXvu2lWE8vCvB1csgg76NZQ33t4n5YJw4aFgGl7o9KfaRTn3PmL
	 6MBI9CQNrfO3qWsJ5RLcOn3pzkyey+hVDTVk+ackOAWbzlA+ZhHMC1MWZgaiLw1AN676t
	 VvtVLbED0PGRf3oeUf2B7au3gtkV17nVGbonGNg6QW9CKGHpfy5GxjQpx07jGIggJ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376831;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Wea7mMzw8MaI8LWt3cOMZKJ4EZ/5ojFJ5zLjX644Hno=;
	b=2uXFaVVCEnHRu4tEqgfiy6VNiaRWrUHiFp9ryn9hURNt0SR5Q+4nhKQMHD3dTzTaUGR6
	 EUKwa7KZUxhm14fPVvH0RhkWXKgTOO9z/ySzOfxj3s3Z/kl4CccmSnoYQgyY4GfDi9qvI
	 xMuolKsrkewAFvQWT8M64Jvw3ZQo3nBYL3guCsuSKJES9zTJVc/7DGXj20/eVQ35sI3xR
	 PugjbS0XxS08rLs7YY4M4YestQMVf/oCX9eAw99nUyC/D+o3XWLAJWi91LLyl2X0vIcBA
	 jQeMFppumUJynVvu08ln+2OSe9DRw5MnDQAws2AdV9Cb7y5jMUDTPIQS762njc/mOvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MswletqD;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D877606A324
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D877606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MswletqD
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so1679711a91.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376831; x=1794981631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wea7mMzw8MaI8LWt3cOMZKJ4EZ/5ojFJ5zLjX644Hno=;
        b=t7N86T7uG7sDfIP6EAD0t3pfNn103EKIE5RamXUQVQH7Yzh6dorKnQhRlS5SqLiKgm
         F6kBAIDpnZRRhWvLcl5paIjS0r/pP+ikFdFDeRrykfW27KVyyrHrwwKjfI2kLKVmuuHL
         HP4N2HjQQ2+so0REYVERul440at5Jmj7qTGbSh9SMzWnDwFfg7UdFYvIC9Z7n0X7c2si
         dcdroGp+H7qIT5084mheHAkrsNUV3SbUW0key7hHbUxLB1NwMqxOKDJNM3vtSjwjRLrd
         cUBeZFc+ul5Qk/aM97lb7VzmqlG5RgcXKH5k/49cVfIAlQGXYDUOIG9iaWr6lMOjihKr
         miMA==
X-Forwarded-Encrypted: i=1; AL+hErElhrxsyNhJbULz4YRnRlGp0V2Pq079neDdLGYhQN6Axq4xG+Yi608cBPn0n0eIA73a7Bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XxAHr/MXPI9E7kmEDuSa0M+OxubCbnV/OisxrmxRiTjQOXVp7
	Jvc7qutS7X+mdi3m9zg7WNKXtCcHNaK5MYInfjzZiX7BOLmxct9s2lJY0JCybHMVmZ17oHe9rfo
	7afySGXz1FlKQkX3j9Kljw0tjpqxgpGR+K806E0dLSD8KxBQhTK36MUsNtug4BavwsU2jBRtenq
	OZ54RQcOLwKF0xVkx8Kv7U95JE5pYBjUSwfTylcScoA/QizA340zKDV693oFh44kIsdI3zm2qtZ
	ed+
X-Gm-Gg: AYBFou3zCRFuPYODzgfld14yyAK4vOVHT8Tt0wK4arDFsp4xvWLkirPOa3673UeW5r1
	Ntn84wCAxIGHBzEKnQUZmjawzDqoY39FsVfZ+T9xeN0QXPnCgn8Rn3ZQuaWoG9c2WOWjpzUX0yr
	QZPuts6C89TzF1F6kNFBORlMs2KUizweWHQaIM/nWuUJYV9gbuvor/vHBs15cf83WrnuacqWaFy
	vUhj9iR4nvVUsGrnghLDvS9yUsPoFPCcqwRvwJv1cchrouq63xAYu0nEvnOTVVgNZC/qNVyVr8s
	cdq3BKDoveYi87AiDCB3w54HAoJGiDNc3dDzCM5KO/96vJlGbb9kLWbD6ScZ+v5NMOVY8LIz7M+
	xuSm41KBu5k6yowl0D5Jv2N6weZc07aXIH0qprCZfgwlyBbv5n7CL9H8qpeUz1nRVX7M4b6Sxi1
	QKOI6xK9tJqVxYKO000ZAHA03rksaqLjtC
X-Received: by 2002:a17:90b:4a8a:b0:3b0:cc3e:68b5 with SMTP id 98e67ed59e1d1-3b182efabfemr1492081a91.21.1794376830543;
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b182def9f9sm411266a91.4.2026.11.10.22.00.29
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so583461185a.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376829; x=1794981629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wea7mMzw8MaI8LWt3cOMZKJ4EZ/5ojFJ5zLjX644Hno=;
        b=MswletqDCx3BRZ3J9bAae0sCHSDskFHbqRtt0M//OutG3/KDTVx5fYqVot9mbPF88G
         OH8EN9PdZRXgticEVajwvHNHlpsgohisg8/l6nA35J9K0PICqW0ILR+yUnPBjwcFDyf8
         IA9d9UyzHLLZpgdDoUvCSvO8LhQY6D5KBEs/E=
X-Forwarded-Encrypted: i=1; AL+hErED56f3uQsJwsBZ2EDjzUXjOwEkttrZSb3vbUcLJWSlTy4Ynh2Fjgq9kQZpa9LLPw4jdeI=@vger.kernel.org
X-Received: by 2002:a05:620a:2993:b0:940:f224:5a67 with SMTP id af79cd13be357-947b00cea7amr220970185a.69.1794376828399;
        Tue, 10 Nov 2026 22:00:28 -0800 (PST)
X-Received: by 2002:a05:620a:2993:b0:940:f224:5a67 with SMTP id af79cd13be357-947b00cea7amr220963685a.69.1794376827725;
        Tue, 10 Nov 2026 22:00:27 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:24 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
Date: Wed, 11 Nov 2026 00:59:55 -0500
Message-ID: <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add KVM_VMWARE_ENABLE_HYPERCALL.  When it is enabled, exit to userspace
with KVM_EXIT_VMWARE when an L1 vCPU executes VMCALL or VMMCALL with
VMware's magic value in EAX, and let userspace complete the call by
updating the guest's registers or by having KVM inject #UD, #GP or #PF.

VMware guests reach the hypervisor through the "backdoor": either the
I/O-port interface that KVM already emulates or, on newer guests,
VMCALL or VMMCALL, with the same commands and register conventions.
VMware's userspace implements the roughly one hundred commands, and
reviewing the command list on the mailing list found none that needs
to be handled in KVM (see the Links), so leave them in userspace.

Only claim calls that carry the magic value, so that the same VM can
still use Xen, Hyper-V or KVM hypercalls.  Never claim a call from L2:
the only L2 hypercall that L0 handles itself is Hyper-V's L2 TLB flush,
which doesn't use RAX as an input.

Pass operands and results through KVM_SYNC_X86_REGS instead of defining
a second register ABI; KVM_EXIT_HYPERCALL returns a single value in
RAX, while backdoor commands use RAX through RBP.  Report the CPL and
leave the privilege policy to userspace, as VMware Tools call the
backdoor from user mode.  Instead of completing the call, userspace can
have KVM inject a validated #UD, #GP or #PF at the hypercall, and may
update the registers as well to keep the partial progress of a
high-bandwidth transfer.

Don't forward hypercalls of vCPUs whose state is protected, as KVM
can't access their registers: reject the flag for VMs with protected
state, omit it from their VM-scoped KVM_CHECK_EXTENSION result, and
ignore it once a vCPU of a VM set up with the legacy KVM_SEV_ES_INIT
becomes protected.

Link: https://lore.kernel.org/r/c60b32a3-e699-4a8c-8d52-09b34c4d5269@redhat.com
Link: https://lore.kernel.org/r/CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com
Link: https://lore.kernel.org/r/CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com
Link: https://lore.kernel.org/r/aIEmawm9gLflg8zt@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/virt/kvm/api.rst  | 84 ++++++++++++++++++++++++++++++++-
 arch/x86/include/uapi/asm/kvm.h | 24 ++++++++++
 arch/x86/kvm/vmware.c           | 78 ++++++++++++++++++++++++++++++
 arch/x86/kvm/vmware.h           |  7 +++
 arch/x86/kvm/x86.c              | 11 ++++-
 include/uapi/linux/kvm.h        |  5 ++
 6 files changed, 206 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 57517ebd4340..e2f0e329f748 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6963,7 +6963,7 @@ to the byte array.
 .. note::
 
       For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR, KVM_EXIT_XEN,
-      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX,
+      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX, KVM_EXIT_VMWARE,
       KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR the corresponding
       operations are complete (and guest state is consistent) only after userspace
       has re-entered the kernel with KVM_RUN.  The kernel side will first finish
@@ -7017,6 +7017,73 @@ Definition of ``flags``:
 At the point of exit, PC points to the instruction immediately following
 the trapping instruction.
 
+::
+
+		/* KVM_EXIT_VMWARE */
+		struct kvm_vmware_exit {
+			__u32 type;
+			__u32 pad1;
+			union {
+				struct {
+					__u32 longmode;
+					__u32 cpl;
+					struct {
+						__u32 inject;
+						__u32 pad2;
+						__u32 vector;
+						__u32 error_code;
+						__u64 address;
+					} exception;
+				} hcall;
+			};
+		} vmware;
+
+KVM_EXIT_VMWARE is returned when userspace has enabled VMware hypercall
+forwarding and the guest executes a VMCALL or VMMCALL with VMware's magic
+value in RAX.  ``type`` is ``KVM_EXIT_VMWARE_HCALL``.  ``longmode`` reports
+the calling convention and ``cpl`` reports the privilege level.  Userspace
+must set ``pad1`` and ``exception.pad2`` to zero when re-entering KVM.
+
+The VMware exit takes precedence over Xen, Hyper-V, and KVM hypercalls only
+when the low 32 bits of RAX contain VMware's magic value.  Non-matching calls
+continue through the normal hypercall dispatch.  Xen and KVM hypercall numbers
+never match the magic value, but a 64-bit Hyper-V hypercall does not use RAX
+as an input, so one issued with the magic value left in RAX is reported as
+KVM_EXIT_VMWARE.  KVM reports CPL but does not enforce a VMware hypercall
+privilege policy; that policy belongs to userspace.
+
+KVM never reports an L2 hypercall through KVM_EXIT_VMWARE.  VMX reflects an
+L2 VMCALL to L1 and SVM injects #UD for an L2 VMMCALL that L1 does not
+intercept, except that both handle a supported Hyper-V nested TLB flush
+hypercall in L0, as a Hyper-V hypercall even if RAX holds VMware's magic
+value.  VMware hypercall exits cannot be enabled for a VM with protected vCPU
+state, and KVM does not forward hypercalls from a vCPU whose state is
+protected, e.g. in a VM initialized with the legacy KVM_SEV_ES_INIT.
+
+Hypercall operands are available through ``KVM_SYNC_X86_REGS``.  Userspace
+must request synchronized REGS through ``kvm_valid_regs`` on every KVM_RUN
+that can produce this exit; otherwise the synchronized state is stale.  To
+complete the hypercall successfully, userspace may update all GPRs and RFLAGS,
+set ``kvm_dirty_regs`` accordingly, and re-enter with KVM_RUN.  KVM applies
+the synchronized registers using KVM_SET_REGS semantics and then advances
+past the hypercall instruction.  Userspace must leave synchronized RIP at the
+hypercall instruction so that KVM advances it exactly once.  RFLAGS is
+accepted with normal KVM_SET_REGS ownership; KVM forces X86_EFLAGS_FIXED but
+does not apply an exit-specific writable-bit mask.
+
+Userspace may instead set ``exception.inject`` to one and request #UD, #GP,
+or #PF.  #UD requires a zero error code and address.  #GP accepts an error
+code verbatim and requires a zero address.  #PF also accepts the error code
+verbatim and uses ``address`` as CR2.  Userspace may dirty synchronized REGS
+when requesting an exception, e.g. to preserve partial progress from a
+high-bandwidth backdoor transfer.  KVM applies the synchronized registers
+before queuing the exception.  Userspace must leave synchronized RIP at the
+hypercall instruction so that the exception is delivered at the faulting
+instruction.  Invalid completion data makes KVM_RUN fail with -EINVAL and
+leaves the instruction incomplete.  The completion callback is consumed, so
+another KVM_RUN re-executes the instruction and produces a fresh
+KVM_EXIT_VMWARE.
+
 ::
 
 		/* KVM_EXIT_TPR_ACCESS */
@@ -9211,6 +9278,21 @@ instruction.  Enabling this flag therefore does not bypass the guest's I/O
 permission checks.  Privileged backdoor I/O and pseudo-PMC accesses remain
 available.
 
+``KVM_VMWARE_ENABLE_HYPERCALL`` forwards VMCALL and VMMCALL instructions to
+userspace as ``KVM_EXIT_VMWARE``.  The architecture-specific ``vmware``
+member of ``struct kvm_run`` reports the guest's calling convention and CPL.
+Operands and successful register and RFLAGS outputs are transferred through
+``KVM_SYNC_X86_REGS`` as described in chapter 5.  The flag cannot be enabled
+for a VM with protected vCPU state, and a VM-fd ``KVM_CHECK_EXTENSION`` omits
+the flag for such a VM.  In a VM initialized with the legacy
+``KVM_SEV_ES_INIT``, the flag can be enabled but has no effect on a vCPU once
+its state is protected.
+
+Userspace can instead request that the hypercall instruction inject an
+exception by setting ``vmware.hcall.exception.inject`` and filling in the
+validated vector, error code, and address fields.  When an exception is
+requested, KVM does not advance past the hypercall instruction.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 57167683692b..3b9f53bce2d9 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -53,6 +53,7 @@
 #define __KVM_HAVE_DEBUGREGS
 #define __KVM_HAVE_XSAVE
 #define __KVM_HAVE_XCRS
+#define __KVM_HAVE_VMWARE_EXIT
 
 /* Architectural interrupt line count. */
 #define KVM_NR_INTERRUPTS 256
@@ -966,6 +967,29 @@ struct kvm_hyperv_eventfd {
 #define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
 
 #define KVM_VMWARE_ENABLE_BACKDOOR	_BITULL(0)
+#define KVM_VMWARE_ENABLE_HYPERCALL	_BITULL(1)
+
+struct kvm_vmware_exit {
+#define KVM_EXIT_VMWARE_HCALL	1
+	__u32 type;
+	__u32 pad1;
+	union {
+		struct {
+			/* out */
+			__u32 longmode;
+			__u32 cpl;
+
+			/* in */
+			struct {
+				__u32 inject;
+				__u32 pad2;
+				__u32 vector;
+				__u32 error_code;
+				__u64 address;
+			} exception;
+		} hcall;
+	};
+};
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
diff --git a/arch/x86/kvm/vmware.c b/arch/x86/kvm/vmware.c
index 3136e2971afe..8407dccf81fd 100644
--- a/arch/x86/kvm/vmware.c
+++ b/arch/x86/kvm/vmware.c
@@ -11,6 +11,7 @@
 #include <asm/vmware.h>
 
 #include "vmware.h"
+#include "x86.h"
 
 static bool __read_mostly enable_vmware_backdoor;
 module_param(enable_vmware_backdoor, bool, 0444);
@@ -29,6 +30,10 @@ int kvm_vmware_enable_cap(struct kvm *kvm, u64 flags)
 {
 	int r = -EINVAL;
 
+	if (kvm->arch.has_protected_state &&
+	    (flags & KVM_VMWARE_ENABLE_HYPERCALL))
+		return -EINVAL;
+
 	mutex_lock(&kvm->lock);
 	if (!kvm->created_vcpus) {
 		kvm->arch.vmware.enabled_caps |= flags;
@@ -39,6 +44,79 @@ int kvm_vmware_enable_cap(struct kvm *kvm, u64 flags)
 	return r;
 }
 
+static int complete_vmware_hypercall_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vmware_exit *vmware = &vcpu->run->vmware;
+	u32 pad1 = READ_ONCE(vmware->pad1);
+	u32 inject = READ_ONCE(vmware->hcall.exception.inject);
+	u32 pad2 = READ_ONCE(vmware->hcall.exception.pad2);
+	u32 vector = READ_ONCE(vmware->hcall.exception.vector);
+	u32 error_code = READ_ONCE(vmware->hcall.exception.error_code);
+	u64 address = READ_ONCE(vmware->hcall.exception.address);
+
+	if (pad1 || pad2 || inject > 1)
+		return -EINVAL;
+
+	if (!inject)
+		return kvm_skip_emulated_instruction(vcpu);
+
+	switch (vector) {
+	case UD_VECTOR:
+		if (error_code || address)
+			return -EINVAL;
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		break;
+	case GP_VECTOR:
+		if (address)
+			return -EINVAL;
+		kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
+		break;
+	case PF_VECTOR: {
+		struct x86_exception fault = {
+			.vector = PF_VECTOR,
+			.error_code_valid = true,
+			.error_code = error_code,
+			.address = address,
+		};
+
+		kvm_inject_page_fault(vcpu, &fault, false);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	/* Retry the instruction so the exception is delivered at its RIP. */
+	return 1;
+}
+
+bool kvm_is_vmware_hypercall(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Never claim a hypercall from L2: the only one that L0 handles is
+	 * Hyper-V's L2 TLB flush.  The exit also needs the vCPU's registers,
+	 * which KVM can't access once the vCPU's state is protected.
+	 */
+	return kvm_is_vmware_cap_enabled(vcpu->kvm,
+					 KVM_VMWARE_ENABLE_HYPERCALL) &&
+	       !is_guest_mode(vcpu) && !vcpu->arch.guest_state_protected &&
+	       lower_32_bits(kvm_rax_read_raw(vcpu)) == VMWARE_HYPERVISOR_MAGIC;
+}
+
+int kvm_vmware_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vmware_exit *vmware = &vcpu->run->vmware;
+
+	memset(vmware, 0, sizeof(*vmware));
+	vcpu->run->exit_reason = KVM_EXIT_VMWARE;
+	vmware->type = KVM_EXIT_VMWARE_HCALL;
+	vmware->hcall.longmode = is_64_bit_hypercall(vcpu);
+	vmware->hcall.cpl = kvm_x86_call(get_cpl)(vcpu);
+
+	vcpu->arch.complete_userspace_io = complete_vmware_hypercall_exit;
+	return 0;
+}
+
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
 {
 	return kvm_is_vmware_backdoor_enabled(vcpu) &&
diff --git a/arch/x86/kvm/vmware.h b/arch/x86/kvm/vmware.h
index c4ad1958a4da..de1dc8971ec6 100644
--- a/arch/x86/kvm/vmware.h
+++ b/arch/x86/kvm/vmware.h
@@ -23,6 +23,7 @@ kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
 	return kvm_is_vmware_cap_enabled(vcpu->kvm, KVM_VMWARE_ENABLE_BACKDOOR);
 }
 
+bool kvm_is_vmware_hypercall(struct kvm_vcpu *vcpu);
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port);
 bool kvm_is_vmware_backdoor_pmc(struct kvm_vcpu *vcpu, u32 pmc_idx);
 bool kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode);
@@ -46,6 +47,11 @@ kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
 	return false;
 }
 
+static __always_inline bool kvm_is_vmware_hypercall(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 static __always_inline bool
 kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
 {
@@ -68,6 +74,7 @@ kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode)
 
 void kvm_vmware_init_vm(struct kvm *kvm);
 int kvm_vmware_enable_cap(struct kvm *kvm, u64 flags);
+int kvm_vmware_hypercall(struct kvm_vcpu *vcpu);
 int kvm_vmware_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data);
 
 #endif /* __KVM_X86_VMWARE_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1425376b4f0e..bd4142763f10 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -118,7 +118,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
-#define KVM_CAP_VMWARE_VALID_MASK KVM_VMWARE_ENABLE_BACKDOOR
+#define KVM_CAP_VMWARE_VALID_MASK (KVM_VMWARE_ENABLE_BACKDOOR | \
+				   KVM_VMWARE_ENABLE_HYPERCALL)
 
 #define KVM_GUESTDBG_VALID_MASK \
 	(KVM_GUESTDBG_ENABLE | \
@@ -2432,8 +2433,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_X86_VMWARE:
 		BUILD_BUG_ON(KVM_CAP_VMWARE_VALID_MASK > INT_MAX);
-		if (kvm_is_vmware_supported())
+		if (kvm_is_vmware_supported()) {
 			r = KVM_CAP_VMWARE_VALID_MASK;
+			if (kvm && kvm->arch.has_protected_state)
+				r &= ~KVM_VMWARE_ENABLE_HYPERCALL;
+		}
 		break;
 	default:
 		break;
@@ -7469,6 +7473,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(____kvm_emulate_hypercall);
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
+	if (kvm_is_vmware_hypercall(vcpu))
+		return kvm_vmware_hypercall(vcpu);
+
 	if (kvm_xen_hypercall_enabled(vcpu->kvm))
 		return kvm_xen_hypercall(vcpu);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e43c15c6e5cc..c01bb6a612fe 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -193,6 +193,7 @@ struct kvm_exit_snp_req_certs {
 #define KVM_EXIT_ARM_SEA          41
 #define KVM_EXIT_ARM_LDST64B      42
 #define KVM_EXIT_SNP_REQ_CERTS    43
+#define KVM_EXIT_VMWARE           44
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -497,6 +498,10 @@ struct kvm_run {
 		} arm_sea;
 		/* KVM_EXIT_SNP_REQ_CERTS */
 		struct kvm_exit_snp_req_certs snp_req_certs;
+#ifdef __KVM_HAVE_VMWARE_EXIT
+		/* KVM_EXIT_VMWARE */
+		struct kvm_vmware_exit vmware;
+#endif
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.53.0

