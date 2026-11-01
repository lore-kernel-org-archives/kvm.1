Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544414;
	b=gwsULG65uDwy3AV8XTHwbjo8dwsuzWq/UHOjuZbEXVO28ON3FouuuyW/Ihl6yaDBCIuZ
	 viX8lNK7VlDkzUh5y3iFF/49za0iInUkeDS+Tx/970CLbdPPD9IrfZIfm4V53u1KvK5aw
	 Xv/d8w/h52G0YD2oE5fpEKlsjDXpuUoA5eiASN8DDniowyL6P8/AokGCpGUQ3Nt4GnQIB
	 94ASw4w8ea8jFrNU9tr1uAuQJbfmTEG1TJbJ/H98345zKvXyj5/cT2b00fF8UGWcUzXqy
	 +8+uKqAoJmwfgJPf0ezVE0R6P06gMcjE9urbS+YZAj2UYDJw3nyCQAJR3dDp4vY/mmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
	b=OtqftSOTOhif6PomRIvCsDmzRdezSqdsKIpvQ5B0BtsVxsUB1ehbaui0tp7L50eM7yt6
	 4+gqrdoDk8qinfaULyKzsEeGZABhAE/MaCwBkcnD1BDmTuqeYCshsdy3lGkOqygH62LMe
	 GWh2k4dyey34LSIF6a/OzKbGsLIkRq+CQ5HMElZ9uPoGDW+1MHoG+tFLrIIiZVieiVAbr
	 17n1pSct9y03vxbECUP6O8cx3YZrvzh07K53tsYbd61wimik5ImcasMfj7BV3AjsUyR46
	 3zvwGrfiLEUWDaDCVBMCIJlHkMWc7tHNtMwSEKYuIGJzBBn69yjOZM8xdgJ4UYNGusA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdlQJXTq;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED865606A326
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED865606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AdlQJXTq
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so3005324eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544413; x=1794149213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=AdlQJXTqHZcJYc0nbA5UOeTFhl2elUhlC24a5TNcJT3XnBHIuQh5rozdmgoO7xQyCA
         oOKLswDynnrT1KVFXWgYdhq6ZuZr7gikrzSfW1Ka2i3SxM1lukjqi12+7fvI5driUnKH
         b/3rl0lZCvVksHnrORyURUcRZ07KzhQ8ubFSWY+wXwvMe6PdhGKCwQY0AakoZ0r5eYAc
         45IcTDHiuZZgd/D5eNwc+aVfUcCD0Mr/PpGyvP1ia1bAQiSX1ZI6sRDVJ6ZzqtLCwDdQ
         um2EmlIFqTvMlgcmMTfEPtRAoFDoi2w+9SOvNINoTPCH/dkN/aIms6d02ue1jVfmjnE5
         L12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544413; x=1794149213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=rP24xIpBV224XvayLGegoguj125DViNdrzQJQwzHwMh0CMJquYuyo7wPL2DkckVRck
         c99yZSl+dcFQmgEa5SqegroTo4NhMX8bAbFNda4sUpdS1/+PCaO5x1qvirjwX3zalnzj
         dW3jfqNmg72PlT37+wgliPODsS8lZi5SDfKS6MlcbtJYS+qjByQu9JVn0uE1GmZmBX2J
         CSOhpzAokvRwQcNs+eTYOp2+9tyAtB0LN72YoYzWN/E0p3NQ93IAGx3SqRuYLVcy4Kv/
         sNp1yePnblZFGu0tSz9uNV2HELCUuA+9HujUr/OIuyktZhe2nIX4lH44Ijsl9+fSqFUl
         wt8w==
X-Forwarded-Encrypted: i=1; AKwUvBx5yn7+2L7eoAGUU60v4QqcSUujtK1LbB9DLSAeEDGDg2Y5fH0mzGYNCNUrfgziEd0zOKo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIjJtg4C+2vffT8hzitJYw1O9Wp8zdWbw0jtisguaXag9dynMH
	X6RyIqIEOZ7mSCj8HKKAA+TsVAvIhCMPyh5VNrf/wiumSZE6U+Arr30J
X-Gm-Gg: AYBFou2cryK8SrViLUDIXVq6yq6buo6jsDgK8nEtJQa28YnTOs0olcRAS7F9589Wv1p
	gJdPOAP6cx7dN9ed+DyYJC4A50AfxZgY4SUE/+aDt7F13AenL6wg/llsT189NF7UotC/nyuWCZH
	3cPY8WK5miNW9ZzHEPL+slV8fIE7hWUtnB6P7tMoZXbqKojIQ5JsRdk5EIMBQQ+o1N4rbVeOudV
	5gZ/fbEOqPrFoJvmcjTESVL4HpxLd9D/hmd/CS9XYxxDqHKB9QK91uAwR1Ydv20dPTNGb06ME8A
	Npy8YkwHPzkFx/LMojNjsEeAyFhW8IaynqFjyd0yxaTO1PSDzp9YiL3s/vvX5TKyFq4FOT+48/q
	v+VS0zyn08MNUSRPkQOjOscVt9Et/MsAmfPOZvkGL6/H7cQ1M3xsPOpP/9a7aK7s4Dxk3Vs2TwL
	HH4TKDnbkYtU6ZS+yzhi/VgORpACgVjl0pIquO8VtCwI+V5cXDN8uXMOG7caD6suoX78psN1FKP
	0X7lmKQPc8TsJbjEyircCW+/u28mgseZEwnqkPtzACxpE0t5baZCGAPwYpH6CpCTJ/xs4HJJa8a
	J7RzZNeBd52l9nSaSRlbhU7RE9tm6jvqiQ==
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr14058549eec.27.1793544412069;
        Sun, 01 Nov 2026 06:46:52 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:51 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 1/7] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
Date: Sun,  1 Nov 2026 20:16:26 +0530
Message-Id: <4e883269c887f68f4d9d54f2675799df147a5db5.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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

kvmhv_vcpu_entry_p9() recovers the guest fault state from the paca
exception save area with

	vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];

but EX_DSISR is not a doubleword. It is a 32-bit field at offset 48 that
shares a doubleword with EX_CCR at offset 52 and the exception entry in
exceptions-64s.S stores it accordingly. For e.g.

	stw	r10,IAREA+EX_DSISR(r13)

This issue was caught when running kvm selftests on big-endian, where
this read would land in the high half and the truncation yields EX_CCR
instead - KVM acts on the guest's condition register as if it were
HDSISR.

The result is that every HDSI on a big-endian host is evaluated against a
bogus fault status i.e. it fails with below error:

	KVM: Got radix HV page fault with DSISR=84004840

Let's fix this by reading this field at it's natural width.

Fixes: 89d35b239101 ("KVM: PPC: Book3S HV P9: Implement the rest of the P9 path in C")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index 34bc0a8a1288..16aa8582b888 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -529,6 +529,15 @@ unsigned long kvmppc_msr_hard_disable_set_facilities(struct kvm_vcpu *vcpu, unsi
 }
 EXPORT_SYMBOL_GPL(kvmppc_msr_hard_disable_set_facilities);
 
+/*
+ * EX_DSISR is a 32-bit field that shares a doubleword with EX_CCR.
+ * Small helper for reading it back at its natural width.
+ */
+static u32 exsave_dsisr(u64 *exsave)
+{
+	return *(u32 *)((void *)exsave + EX_DSISR);
+}
+
 int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpcr, u64 *tb)
 {
 	struct p9_host_os_sprs host_os_sprs;
@@ -770,7 +779,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	if (unlikely(trap == BOOK3S_INTERRUPT_MACHINE_CHECK)) {
 		vcpu->arch.fault_dar = exsave[EX_DAR/sizeof(u64)];
-		vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];
+		vcpu->arch.fault_dsisr = exsave_dsisr(exsave);
 		kvmppc_realmode_machine_check(vcpu);
 
 	} else if (unlikely(trap == BOOK3S_INTERRUPT_HMI)) {
@@ -781,7 +790,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	} else if (trap == BOOK3S_INTERRUPT_H_DATA_STORAGE) {
 		vcpu->arch.fault_dar = exsave[EX_DAR/sizeof(u64)];
-		vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];
+		vcpu->arch.fault_dsisr = exsave_dsisr(exsave);
 		vcpu->arch.fault_gpa = mfspr(SPRN_ASDR);
 
 	} else if (trap == BOOK3S_INTERRUPT_H_INST_STORAGE) {
-- 
2.39.5

