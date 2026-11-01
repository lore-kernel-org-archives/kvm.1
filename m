Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546907;
	b=t2QvfyO2tBgfpf/tqo11agdt4sS6ksbk1TcRpOfqvBZTYXGlhvYuazfQj3E5hhtkcUnS
	 ADWiQVRPM+3XuhoDcdBWDEMAO8UmbMJippYAk0Ac9vhKgLlGF72aEwPvwRhZLnXNvu8Gk
	 0KJ8h9xFYsnRl+1RwsQOdsS0c0jFZ8uheOS0BkarHD2jpipSTvgMuYRHr1DdQX30szLPw
	 G/XLWu9zcAPG+XzWa66IRViV4SKZUE5kmCCgoyc7w7znPmg6QsagGVFj3GRWGjAx3igOK
	 NGzAg9eCaAgfKv1wQi4azs4q2WNDMpEzN6CIXHkNO8aJmJQSvRT8WF1KBYWxHZmZSTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
	b=qfJt1p5oUzS+lMyiPJj0+MaEfJOCi54uuDLMe8XH02TeJcW2Kn+lEVuSq8KQO8YA8yG2
	 j0W2adEDHbyz8yue6VZCvAbOF2HIeCvxstm1apiRbN5Gr09hta8cXaJKohO0SctqFTZA4
	 WiSXCzilzGbU7U6QZxwtVlJNkU7iSUTVOy9VkVFsQpG3AmgGW21x3HsJpd1lnY4CVdqhL
	 kUoxXORNm746PppDbNPnVtaoR4FKVC+kZQBagdZ5+gNRB4+lFqSNv6/aFLX/YglAUPlfx
	 ET0O2269ubFmkiDlVd931I8OQtY+sNy4ZsGAmFze1CXLh+n38xWLBdCBD58Sk8u5Kgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IF1ScSna;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6A606A325
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E6A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IF1ScSna
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so2706944c88.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546906; x=1794151706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=IF1ScSnajZK18C8SfEjLv3QvNFkS/82W3LVUwM0NV0XGmqT3Dmr/PIXQPmVjeCIAtO
         +1OEwVeF2s2TGP3wfhDg9ki0KgGGVr0yxubd1zvguVcNVxKhprNp8E8lt4yNnA23nFaH
         rpGcTcyb5cJ+dD/Nv+ftrE2BrYCsCwnL4xpShNzn6zV0SBVBf+fj4ZwCHeH314whEu1y
         Oc8X1Ne0Y+4Tv2s72yFY03yYh+VlVeAJ6di1n0ZUytM+DE6v2/1M4Kz2A8LVeaW+UT9J
         kh1zXIZlKS5iMvDubw9knHthqHhZ3oj8cj/QH0mzCCfusaRCMhILMqmYvbZOD6DG6kAy
         qp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546906; x=1794151706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=kUeWAtfBaVE3tgKu5yaiRRKrfmxXblk6gcFdAAG+pmY5igWeEkHeJivUCPh0UqjJLE
         5cQag3skQuGVaufjTjDoDW/hp3vSsCdR3cLNM9typV08mUPPi/km+fGGB3sGfm9zPTx1
         YGB/PS7HB7ruEkj3kK59QbbE0GDBnDoMvHC+h4W/1Y7WXf756sxKwoP74ycaE8DXI+as
         987XdOWlg4kIUPBirm3N66gV3UU0LowRpEXkluiBf00TLofD4+avCk1O2q8vUEqZjXBw
         /UAEDmBmoo49LNilLu/1Ez1Uuko4lzWwptU+pea/YxxswX496deHsBBdmbLg3rlxNhvt
         W9Sg==
X-Forwarded-Encrypted: i=1; AKwUvBzEOSaeW7I6nGu9dZhsJVisbmYcOc+B/WhW8coM2wM73ah4aR5kKE/ipZ/XLnesl8sigRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZbOeBS7eVnraLH32jyfsZXEvO6giuygYybWQfXDn+j4zyUO42
	hMru9jAuXFtwWGlN7Oq8b4yrIA69q9V5lpgMAC2Pt07ssouxA0Goy4dB
X-Gm-Gg: AYBFou1rdmCN1CDTOQbrV5Nrfl8Rbs36lXeb+v4M7FezSZVSSwHEsecabA7hpYo9M8t
	36x6atpLgODrQYu1mRNmHxHEB6qjrNl1q1CC/pf9GkjR1/j6MEci/zY6Pvh/8dqejwcxOiW7GJg
	hGoaQEGjBlAPZm3B7bbehcgtUhrnv28vKGZ6vsH32ndsjoRG68anStzC93OQW/bhyFRXVMWs8KG
	3Z4vmFsLxy7wmgzFarN9a0y0dYonwPxjsdhGoR9BFNvbYDSYTVocukKeGGeeR07AHpMwGkKeXVM
	Md6osPha/4TAOb9NuM3UyTNz2BqZSVjlZ3tVtxwPNp9gUBha2MNSN7oYbc5W0RHehTxBgQwIjGb
	78G/9wiyjRJSdyhhi9BAQUhHj7OUr7PElbPC3zhIUl/FJvphkmPPvFR72NYaCtCK0g0nzT9t1LV
	ISsb5oKRcSokm/dNNpWsUEFN+XzW38H3vOdf1hDTbi3pvIaNl0M0kksxay/UBe9MFv8l3FeytlN
	Jv6J0JvAqeLyOSt07EjDp3onuajcq/kTB637u5zpqpsxJTaMWisnb6D5TgYv9yp9c4eL1LLdM55
	AAqi3H5Gw2Br/dqgw/RKUopJXja+FO2GQyKtGGxA9mLElH20X8ZAxmc=
X-Received: by 2002:a05:701b:2086:20b0:153:3c50:ab85 with SMTP id a92af1059eb24-1ac5cb1c5fbmr12526852c88.12.1793546905701;
        Sun, 01 Nov 2026 07:28:25 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:25 -0800 (PST)
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
Subject: [PATCHv3 1/7] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
Date: Sun,  1 Nov 2026 20:58:06 +0530
Message-Id: <4e883269c887f68f4d9d54f2675799df147a5db5.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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

