Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B3355F53;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623597; cv=none; b=JYD8Y6BVz8kJEIcC4dySeAhBLlY+hVz8abgAqZDukHpNmowiNj9EIVkVhdZxkuOGpz1qWBdbi3Ewn928jXA/fINbc0eDoYAJfXYSPLbvlG3WKdzgkiCSu5A6GjPETbEbhnOuar9LsPdEXMAwM/EF1PfyzBrbW8UudIMo8pEWBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623597; c=relaxed/simple;
	bh=w9IsCz5C65o7SYnzaV255DXsVBXf9lMSVjahsf+0d3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGu2einpTfuiVF7JGCcpPaDpAeCdlE4MLEYNSbS1ksK/mJTVehgJNrIxsMIYrmZ36V2FMJ+Z6R3ReJ4Ft4vu63B2dazY2WFxTS+lu/WZTZ6GhScsCKfynmvCjS0NlOOTwcxjGd+D1COIIf7HJpdyuopWF9yzykf84pvVe//csas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io0i1S8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io0i1S8z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04222C2BC9E;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623597;
	bh=w9IsCz5C65o7SYnzaV255DXsVBXf9lMSVjahsf+0d3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=io0i1S8zyNDeTdGN4yJaLqlYa3RQFwnmCi4dvTfsmB2ngjDUDhE/WQLWOWF+CeeJ9
	 BAT8GTZW0ZcY3sps7tDwnjuoyZkimy2L7GSB2nrFrgBMUZAe5XHDUwBCwAOYRM0PAn
	 +RrdMZ+Jy5VUxB0KUVMQDgjmiAxUOu4A7HUO40NJNu/BJUFxQb0+cdxCxyCK4fExlG
	 T7rtuG0Y1EMKogDfx61PbO98rUM5xMdz4qZkXE4Nh/NVmic717s84V3Vc2PQQjj57X
	 TxsbbHANRbqjMEk96gWw98BjyjLIr/0ATUvCFdK+V56MGGC9q/w7aYhDTaAaHrrhHw
	 Zqlez72oIvsyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F143FFD5F73;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 21:45:56 -0700
Subject: [PATCH 08/16] riscv: kvm: Fix MMIO emulation for sign-extended
 insns
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-riscv_insn_table-v1-8-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
In-Reply-To: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=1861;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=lGPhHeZyq2cBn6D6Rrw+L7g4NlITgLWo0A/2zvmf7AE=;
 b=db8eDgJl+Lxj01XnGSTnQdW6SSxHQwG8ehZ9ti7lZbKgg//zvLEF/VtHi7aOf3Qg/NPY9t3iw
 b6GSI/ckqNOCYdESWlISYlmDPk5zSHfsQP5PliI0bV5S5BiyNWqbc/M
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

KVM MMIO emulation failed to sign extend any signed reads and at the
same time also unsuccessfully attempted to sign extend reads using lbu.
Remove the shifting for lbu to avoid sign extension for that
instruction and cast the data to a signed long instead of an unsigned
long to allow for sign extension.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 arch/riscv/kvm/vcpu_insn.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 62c4510a40af..311e2530f888 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -416,7 +416,6 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		shift = 8 * (sizeof(ulong) - len);
 	} else if ((insn & INSN_MASK_LBU) == INSN_MATCH_LBU) {
 		len = 1;
-		shift = 8 * (sizeof(ulong) - len);
 #ifdef CONFIG_64BIT
 	} else if ((insn & INSN_MASK_LD) == INSN_MATCH_LD) {
 		len = 8;
@@ -650,22 +649,22 @@ int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	case 1:
 		data8 = *((u8 *)run->mmio.data);
 		SET_RD(insn, &vcpu->arch.guest_context,
-			(ulong)data8 << shift >> shift);
+			(long)data8 << shift >> shift);
 		break;
 	case 2:
 		data16 = *((u16 *)run->mmio.data);
 		SET_RD(insn, &vcpu->arch.guest_context,
-			(ulong)data16 << shift >> shift);
+			(long)data16 << shift >> shift);
 		break;
 	case 4:
 		data32 = *((u32 *)run->mmio.data);
 		SET_RD(insn, &vcpu->arch.guest_context,
-			(ulong)data32 << shift >> shift);
+			(long)data32 << shift >> shift);
 		break;
 	case 8:
 		data64 = *((u64 *)run->mmio.data);
 		SET_RD(insn, &vcpu->arch.guest_context,
-			(ulong)data64 << shift >> shift);
+			(long)data64 << shift >> shift);
 		break;
 	default:
 		return -EOPNOTSUPP;

-- 
2.52.0


