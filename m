Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330993;
	b=jZl19Oiu6LOHlU+d5qQ6HWTr74kPF2/9+ofNUUxJqksf9SXWNEdFTeF4mu31V5HvjY/b
	 cHrwOikI+QAdVbP3YKMdJ4i7IAm35dPCkf3lSClFliDAoZ7FtqQubgkd81d1S+ga+jJlz
	 pbotYPqur/LJP0vsYQM7yk6NIPYUEyCADI+gDB1OXmhX23Hw/Mzomv4PiJZNid+b4dqPC
	 j0Ovk85D8cwoDQNdGAkgpJ0awE3IaL2wKE9SBG+hGYPd/N69Pdw0nbk85D6b5uqFKUUbn
	 N7uuc69z4xqj54G/rtNO8o2F6WhBCOF93ZOUcjfuIkpjTJq4/Xxy0iayebYHonLxrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fHqIvwCwjfUgesmssbUyzagyO3sOsIFnDyPzXS5ogoI=;
	b=P3PclmWd2WRApg0oZPXygPhXdvOOUugFyqikTNnHksYNXBpVp5q/AmdM2diCuN5cZRpY
	 c5k2cirmqkL2JBevMFTJyQjxQO4os0xnTUkjUmqdkoqQu33fNRNHi/416gX7N6SZQM+Km
	 N6HZhy1H1/MouQ13ecfFZbPccWdaLzqEJ4jzsudAA/dh/5yGH/+/4dT7ud8+QFf98ARmd
	 lC9MmNB4QhOMl0nBeBoRlkBpEKSHlUELkYOeCaTY/0J+zcfPAkQPYkV1/ktIxzDdDZqWf
	 6JAoCtqrgU42K5s418Dft78eks/tZC/Ls0+M9eY62+TP1fq5xV38jkmDapuSuKV1W0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cALrW9Kt;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B8606A334
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 03:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706B8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cALrW9Kt
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a089dfee18so839718b3a.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330993; x=1793935793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHqIvwCwjfUgesmssbUyzagyO3sOsIFnDyPzXS5ogoI=;
        b=cALrW9Kt1d2vLHLVZ0qIIAyzP5PeKtfJ6STl+wrB44Re6i2+74CdFW7w4ajlYKncOe
         KhyZM7pFJl7WfWHSC5Y07TY3iU9psAVcMfBctFvtluyjFvTuhyEjlExMNXvyCH94xMu4
         qFgOA3wxvKRqPQ/DJDiregA9M0TQN6gLASfjiZq5t6enPe9nwqaPteBbPTYlPBuP/oGC
         qf3bn+M3k14oSJTzMgXqqXGuWWKmyUhcApVIm4sk9Lmj7dlLfUoMhp+5IqtbM+wdnlql
         KoRRN6ofYF0y5Bxk9WK5GZASdC1WCKFj6C+mv2Rn2P6ezjvJrp6Ts1EoURikLUNcrSpr
         eCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330993; x=1793935793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHqIvwCwjfUgesmssbUyzagyO3sOsIFnDyPzXS5ogoI=;
        b=WXSWVk/DkqCwCW7cBtTfLKUOeB+pqQEqYzzn9fIWqNvWG2KXjt/egAjnf/GDCzXK5I
         /tXTrAee9uK5WEmvDWWtfmMZjLpjq7cgkKw4jG8Grge1fCa1nnsXiw12Ct1ZEyOImKae
         SptYff2vhjcy4Cumk0cWa3rvYZDjhEg5Ab27+2Y791g2cVFk0JkCyWrtj65AAeSKwV71
         RrtISsOjXYUTWlyi1v1+JJJCOIICDkLasmUpSuyjXl6WyIyKVIcIfSeBpyxJT0vld6SZ
         YAbY7cGCoh7/2Ohu12yDLOP5Qy1ubPBsxqV1ytdEcIza7WxLSEdtubEB/u+P1XpZCyXM
         GQJQ==
X-Gm-Message-State: AFq9FYLVD21Gp5SpIDmfp7Y+zUYocGlxsYSBtiZZh6FcpfydBAuq0vaW
	yl2NYX8y420E4uxVqWVsCAocGlOmC5vDXCskcm5syzeVYMVd4uaCN4mk
X-Gm-Gg: AYBFou1WLs1lNGVNZNQEXNcFPUpFdAMdfx2dRkNXgduKOJDTp2AaPU6P9oKMInlXnQS
	nyaeOZZtG1ItmeykugeszTLT9AUIuPJrEvQ19ySxj6H2/Wz8hK3TVHVwncDTE7YzU9gm6r9aAva
	AniFtKrmWXvFWi4bYurtMWprgIzKw4TTFnfn6KJOSHOEIb0KlfefV2RAl4xmn+Op8Ds47QIUlZG
	AOBmcXM9PIYVHEsu44l2aWQw7XlvauId2JG9KaIeDiT5ydNvykL2Lvqp3zju/LeXYLUv3y319oA
	wLepptXSk02wPr4qzd0bADXEb4N1Ah8vZtlW+bWJuQrVK5y+RFxpyhQ2ZcfXADKnb9tufZ/Cdri
	1eORjKsiNb8znRRL0shlmMfMgDIBcLV4fs7f8lk3Fc/zWyluaQBHIWkvWDYaX8kDpLMSuVoaye9
	GGDfnpvpBmFlRkt4CDLfeVfptU8TeSZvlUkqqPGOOL1L2QMRsvCzB8YC2hzuIK8QbGN5KutJoax
	SNKVdOlvpMpBmRnv6+9E7nudRVdmxQmx6w2qjIhm8idZKx7mloS4ABbiE3EUrBBjFsHjtW7kwg9
	0gdL60Kf8egLEAuTpEbB9OpCx+cXhwu//r+rKCIRexegLpQBOV104ly2/sUiYtBNJUQUVwiXzb8
	mPPmkijoPnlXZoFdD0p751qPHyTfdO0dD2/Y2QO5zp+K7l9cy1R7p8DYlWkCXmbrpX/hyw+5Y
X-Received: by 2002:a05:6a20:c903:b0:3e2:4a0e:6211 with SMTP id adf61e73a8af0-3e913b67a66mr3504067637.26.1793330992605;
        Thu, 29 Oct 2026 20:29:52 -0700 (PDT)
Received: from localhost.localdomain (S0106e0dbd1c8af8c.vc.shawcable.net. [24.85.96.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981c5desm111713a12.27.2026.10.29.20.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:29:52 -0700 (PDT)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 1/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned
 by L1
Date: Thu, 29 Oct 2026 20:29:36 -0700
Message-Id: <20261030032937.2813-2-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.40.1.windows.1
In-Reply-To: <20261030032937.2813-1-ma.mandourr@gmail.com>
References: <20261030032937.2813-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When L2's LMSW exits to L0 but not to L1, emulate it through=0D
handle_set_cr0(), as is done for MOV to CR0.  kvm_lmsw() ignores=0D
vmcs12's CR0 guest/host mask, so L2 could change CR0 bits that L1 owns,=0D
e.g. clear TS, and read their effective values instead of the read shadow.=
=0D
=0D
Fixes: eeadf9e7558c ("KVM: nVMX: Handling of CR0 and CR4 modifying instruct=
ions")=0D
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>=0D
---=0D
 arch/x86/kvm/vmx/vmx.c | 15 +++++++++++++++=0D
 1 file changed, 15 insertions(+)=0D
=0D
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c=0D
index b341af4c60..3633496299 100644=0D
--- a/arch/x86/kvm/vmx/vmx.c=0D
+++ b/arch/x86/kvm/vmx/vmx.c=0D
@@ -5748,6 +5748,21 @@ static int handle_cr(struct kvm_vcpu *vcpu)=0D
 	case 3: /* lmsw */=0D
 		val =3D (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;=0D
 		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));=0D
+		if (is_guest_mode(vcpu)) {=0D
+			struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);=0D
+			unsigned long mask =3D vmcs12->cr0_guest_host_mask;=0D
+			unsigned long cr0;=0D
+=0D
+			/*=0D
+			 * LMSW leaves the bits L1 owns unmodified, as does a MOV=0D
+			 * to CR0 that writes their read shadow values.  Emulate=0D
+			 * it as that MOV: L2's view of CR0 with LMSW's bits.=0D
+			 */=0D
+			cr0 =3D (kvm_read_cr0(vcpu) & ~mask) |=0D
+			      (vmcs12->cr0_read_shadow & mask);=0D
+			err =3D handle_set_cr0(vcpu, (cr0 & ~0x0eul) | val);=0D
+			return kvm_complete_insn_gp(vcpu, err);=0D
+		}=0D
 		kvm_lmsw(vcpu, val);=0D
 =0D
 		return kvm_skip_emulated_instruction(vcpu);=0D
-- =0D
2.25.1=0D
=0D
