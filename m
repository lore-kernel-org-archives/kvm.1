Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589814;
	b=MXq3QNzGUSwJ3mYp/r2BsQgq2wgdr1ptsxgH7sGjTeNo2PfMxHlu1c4lhsVeIj42Irj5
	 nz15V4QKoa9p1baosjcKu3Pfmc1apkccTEPz+i3CWz99KdShvWHepgkaY8gyQvhqFdeeZ
	 btEM+bUJUXefh5V57lDksch2FAnBYMd5gbWyPXXseaoeWlUyN/MTfAXFVyNvKLVr/1g7Z
	 HoUuG8amX4bpHQP6C/L+ixicSj+6W8Yfedsv18YP0A+ElYVsWJ4VKpudbnK/v+/LxxhrQ
	 Y0NpnjBvpoEGrzePRAtxY/yXmO5lpLl6FTaiz+MQurcS5P9teL+46sbt6rMnp9MI/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=TsvjkV1z3SJCt8rGDNCxfVDi6AQK70itPPBCytlT4MM=;
	b=N8m6ViYdblpmeB8tgGDj8b0sqWiwxC4C2WF2okRMccW22Tpft9fROQ38UARt2wfIffYT
	 xAlh3RUPIvihwgSkD58ulUuJJ26mdJGIbhaXJK2o/6H9OS4+rFBlytrkWIxg+Uf0fILB3
	 pmvD8/1hje6CopTTFLeUDMks70cSi/oze6VBIbu6XzcuIDNf+mJxu0Y5+LL7Z6KL9408Q
	 dENLJYibaE8bxMdKUaNsQqgNnJup6udV68qazW4UTOMTMMoRyAwlTY/Ark6pNMMWVI6F4
	 OBDwT4bmvIuwhZLpaUP7P5ZpCgtaKf9jXmSsiNp9MA2LJK/z82fZR4e78XQZ5PF/ZoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=S7yuMIsz;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F1606A33B
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51F1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=S7yuMIsz
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so3456437f8f.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589812; x=1796194612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TsvjkV1z3SJCt8rGDNCxfVDi6AQK70itPPBCytlT4MM=;
        b=S7yuMIszNcBv7SSTb7fTEcmDGwK/GwmqZFtTOMlrZMM6qLUBXrFmqH/DpXQOJL2GWL
         8TD0OmOwdlhgqliTwH97sEZfqUmz7G+jsPO3IqGyNirQuluZcnt48lqjtQDf0cu2+fue
         hhG4TF14yU3Vl3shwCD3j/78j/FMY2Q4K5KKswUei71oP50ORfLSfRkXYEjwH9CBpUH/
         9uVRe/LnmcvWcmK3YvWhGVbJnrRN8MdHHMqnZzOVUt7guK88G44v08y1w6U+2UCSqeQE
         /RLnbwdRfEuUf7sKql/WROxZ+hnYXeJZfINQiWx3M+/hKjqY8uojpCiS83nYIa3MU65w
         QP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589812; x=1796194612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsvjkV1z3SJCt8rGDNCxfVDi6AQK70itPPBCytlT4MM=;
        b=sANgz3VOInXdC7Ayp1aCtePVt1AQvKE3ThJ9Dt6THNX9kMvFSYIMzm/JeAHnu7hNOe
         536JUjlyt9kWAjaRM/456470rq6iTtZKbGsGChMe1ZZiUtQRUjxTQXw96S+4A0VUIfcC
         9YgORu31hiy+7xvsImY55u7KOR5k0XawhUMaADZY9NdAv2knlMIwmGmKqzFx35eeUWT1
         JxigJvLwYvtcx3kRtKH40XIEoqmP5YLJOOXX5oznEYCvZHGwMw4ObVjy/dv2CKsaaFti
         vmGBsJCcXizZJtzE/kj4NRSGPAvnLtd1KTkFCcOAeP9QOfKj4Wf5xJ1CqFt1mn2ZzIos
         tKNw==
X-Forwarded-Encrypted: i=1; AL+hErGhYUQvzYiz3WO5oKsMxS8uI/xNFOI6kHMRvscd4wAfKckWhXLdECUn6K02+J7vQhhIqbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JaOIWg4AO2N524VqOnHwxJ3hE4ytgIFPhmDQ3P4gQe1/u4v0+
	ub3J2I+7q9QPt/yfefvsIaexIU6nnpKIunavDNbqF1ezRGGObgFEm6cXD5CDwNsHfA8=
X-Gm-Gg: AZFdTZe7zg4WVEKxmggTcUIEEMZ2jUdJxf8MsxLbMh6IVC23wYliwuyzJw6RFiMGuJL
	cJbe2kwxZx0aexG/jhcM/vEoe821Q/7R5JxAf7eRsI8zLzrFtbG7ZYadwePlgJ8ORc4eL2/6unr
	sYRV/n+oLN156em92bhUk5tlQ2QOdqa1RDKWN3h6PAgnd8VaZW6/XtWABmmbQKOW6XAzo8nKcD4
	edqUp12lgAlYerjlohbmIy4W8rhG31KhSouC0DPar0RegUDKARkQRhR9E9pda9LLBmDxgTeLVJl
	2ESLv2VTE640KHgw+jhcsf+TsloMcc5cl1hRwHa+Lc/bRbbK0IVz66tgGcePn+77PSpKTkYtJWJ
	d5u6o+ZUkqWpfPqJprzJKlIL79bAd69G2tkvOXIIvSXeDOWlxKWEpqNpq+B00prU80N95WFUT8l
	HDbeLkZtbBBYNFHs8/fN8HvZOJIcEQooedtwiOo/c3xkqDGGEkfi6SYkkcKoOfL2b6sgOb3z/Ud
	namDUvTonc6DpRBP/4T7R22qlngVIDObX75dmafc4yojGnnSC+WHP4SNiv/pHwwFiGAZgPHeWdA
	0OTlRdhZ3oyc7Pf1mTQ=
X-Received: by 2002:a05:6000:461a:b0:491:1e3f:a427 with SMTP id ffacd0b85a97d-4abb4b84d2cmr32386732f8f.42.1795589812021;
        Tue, 24 Nov 2026 22:56:52 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d55sm32520868f8f.5.2026.11.24.22.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:51 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:21 +0300
Subject: [PATCH v2 6/8] KVM: arm64: nv: Don't deliver a pending SError to
 the wrong guest
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-double_exception-v2-6-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

With nested virtualization, when we inject an SError that the guest
has masked, we set the VSE bit in ->hcr_el2 and the CPU delivers it once
the guest unmasks SErrors.  The problem is that the bit stays set when
we switch between L1 and L2, so an SError meant for L2 can be delivered
to L1, and the other way around.

When we switch, clear the VSE bit and set NESTED_SERROR_PENDING instead.

This matches what kvm_nested_sync_hwstate() does after every guest exit.
Then kvm_nested_flush_hwstate() injects the SError again and decides
where it should go in the new context.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-229065@kernel.org/
Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: new patch
---
 arch/arm64/kvm/emulate-nested.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 39136a89d74b..cccaf02610e8 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2792,6 +2792,18 @@ static u64 kvm_check_illegal_exception_return(struct kvm_vcpu *vcpu, u64 spsr)
 	return spsr;
 }
 
+/*
+ * HCR_EL2.VSE was set for the context we are leaving.  Store the SError
+ * instead, so that kvm_nested_flush_hwstate() routes it in the new context.
+ */
+static void kvm_nested_stash_serror(struct kvm_vcpu *vcpu)
+{
+	if (*vcpu_hcr(vcpu) & HCR_EL2_VSE) {
+		*vcpu_hcr(vcpu) &= ~HCR_EL2_VSE;
+		vcpu_set_flag(vcpu, NESTED_SERROR_PENDING);
+	}
+}
+
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 {
 	u64 spsr, elr, esr;
@@ -2823,6 +2835,7 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	vcpu_set_flag(vcpu, IN_NESTED_ERET);
 	kvm_arch_vcpu_put(vcpu);
+	kvm_nested_stash_serror(vcpu);
 
 	if (!esr_iss_is_eretax(esr))
 		elr = __vcpu_sys_reg(vcpu, ELR_EL2);
@@ -2909,6 +2922,7 @@ static int kvm_inject_nested(struct kvm_vcpu *vcpu, u64 esr_el2,
 	__kvm_adjust_pc(vcpu);
 
 	kvm_arch_vcpu_put(vcpu);
+	kvm_nested_stash_serror(vcpu);
 
 	kvm_inject_el2_exception(vcpu, esr_el2, type);
 

-- 
2.53.0

