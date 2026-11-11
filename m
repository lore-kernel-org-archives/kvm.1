Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377228;
	b=GfWZbNwnujTT+vwhUqVvtj5Ud8JnmT198zbfg4V5gybzHNv1ZAcvsIzrLfMP80dyCeZx
	 KXyKpl4h3mfTBgY9TAtmAF5JfRPzp+4OOfgutbJjblViDwkOzBIJoIUNOdgQiKkda2sI+
	 OyRs8EJIwIkFR3cc32EXjDmCPlw9MiblVDTayfbcOS7Q5rNk/kz830hZrdPCOxu8RTQ46
	 Oe6gb6vs2wi8WOE35S0+khkRW+gZtDTHwU/2gz7dL4rcUl6k79/QSpvJkkRO2VBYrsyo1
	 c67aXxm4dFFnKXgVAM9THnL3Btn26LiBF//LUGyH8tEXbNG5+WXGePZzmJQQk5wCnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377228;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Op/9/DpgcKIe0jcvYLiJPNqXkkmx6XxpHhTMkcCwGrc=;
	b=zOfhIxo/Kt6RtGiReVKSO2d0Y7ciYaU7oKuDoL3wxCDA5RfKsbiBvVOfbMHZDuwf4zA6
	 i+wYX8+0NOOsr3KV6PbDWy0lajvXW25+oGD4eoyKNEyhOcx6LHmvlEqz5xrttHDiLHBw/
	 bxVF2FnrKW6SeaX7kdpPin0anpurBV0AfvgKPCQ90GGQJlhtIe31NI5gdhGo6c5pEBl15
	 hb8hUPFOXGVmFTQ2iAE60E0wdESghDs5biLpcs3VRnKEbmWQCHhJa8pSolb14vUXl6ZDO
	 Pay7rBd722GoZl9optFSOZn0n3XVJUrWTT0xW+hjZODeAVroVkhug7E+TBsmfaRNZBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Gpll0rpD;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE260A2604
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20FE260A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Gpll0rpD
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1850675a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377227; x=1794982027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Op/9/DpgcKIe0jcvYLiJPNqXkkmx6XxpHhTMkcCwGrc=;
        b=tKP5CDtpwJUc4xunO1CXR6ssi8DI5b6/ENc9+185rm0rxRoeg7Q2wxl64eQX8VpFCL
         AB4MWhAbQfa14jM2IiyMt0NY3gC/01VDRMNZuzinH2BCLQAH4fFwr0S+OBXTinfi8x2d
         bOS5uZLhtMiMgD5Od+PKh91E48jmMpTASsYdeU3eK4VQOUiswnkXD7s3Gfs3sw98Aa5y
         5sCkthqIIt4JU/mZerVDc8MvF9moJQAkDQohsh3wD+tRUZDXvq6AQl//zOuzVlwh8096
         zUJ2vZBqV2yAwGSmsaqJjcb2dfRoVEBdFTRl7VQ8QP0rIHK9X3GTv8fnSKh+dxNGNn3s
         bLzg==
X-Forwarded-Encrypted: i=1; AL+hErF/AaMiCGJ/H2aCciFiJ8KrKqTL2Uk04j3Q3D26V/m0e16HqXrmDUBizVh41FM+KyWaOxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Qe/i/zxiAPa3z7AD72Dxi64JrOw/DKCDex9H3WpdZieM/oG7N
	bQiIZ+p/YekujmTqe2JIn1G3zsxZ/lGqJ8UkKUo5sm5+PjMCdPzM/uYoh5bx7x18C00Z/FakV4k
	uEVBp32akwiCDIXDzzqf+OHqmgtD7J3mKb7GS1LU8i0G2lmuvjsDIJYnO9TIcYP733ngiCeI0Y2
	1hf2WuV9xaAVKPhN+99nZw8J5L5aoKErYJUIf2tUXob3OeJj7HI9zbpv01Cqo8sCnH1Ib5urgdN
	SZF
X-Gm-Gg: AYBFou3cM/a6JH4JRPfShrRZdHTcZWtEIMUN7NDk2xKX4kZGRbtnUaI2YxB2wztMwiq
	wa09ysCEq/f5v/vahitYr/axh84qqM8yQOpZs3/0XJvz2xQ51SX2JSL0piIEfTcy9leQx2Y6Il5
	rd6ShjZl3ZQslM/2HPGRxx5Fm1t48+6N7BGLyd8bqj+SLvseBSGxfj5581JrDKFVNWUaHQlsQyv
	JbMtNQ9XCKv/YRSWIfMMv4ETI9/sPIXxUKq788fBBdorGiFoQ6kNO/gcF12R/cLh16QPhn++bbv
	VFsFslxcJWuIlaiRtHuotLgfSqBbxEUNCyfKXu5QSBhwUvcV0OZc3tJgCIiuqDzvr8Lwc2BeqIB
	KpG2tuWvmqL1aLaTiBLLAZ8qg1u4Uqo6heS1OYd+sA7snHjcihyc6fvl+rVgEONm++hiO96uTkr
	RNTEq+10Id/6Kc8K8Faef1GkhewcdZ0+SE
X-Received: by 2002:a17:90b:2e47:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3b183011c32mr1379092a91.59.1794377227346;
        Tue, 10 Nov 2026 22:07:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181c01e80sm509802a91.0.2026.11.10.22.07.06
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:07:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-946038e22f5so669823585a.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794377226; x=1794982026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Op/9/DpgcKIe0jcvYLiJPNqXkkmx6XxpHhTMkcCwGrc=;
        b=Gpll0rpDkDFMWUSDVeVLBcrPq3m64MWsZWRgcvDc4FHhLCFDk5XQuyuoPXjBoDm0/o
         XIlqR/pQsfqJcFPxRvRY7MIVfGp7tVRdjaakfYONAuYrRrPHathNvLwVNDH1t2eIPK3Z
         d3V7tNXkesJ40sppCXSPTw3S9nkmjlbPilDX8=
X-Forwarded-Encrypted: i=1; AL+hErGRlG/psuYKSspO1BPharSLktjk77peMs07ILnLPSUA5bKo1MIz1uDmBaoTdxvljcCTwZI=@vger.kernel.org
X-Received: by 2002:a05:620a:29c8:b0:93c:720c:94e0 with SMTP id af79cd13be357-947b001c6afmr209719885a.30.1794376806979;
        Tue, 10 Nov 2026 22:00:06 -0800 (PST)
X-Received: by 2002:a05:620a:29c8:b0:93c:720c:94e0 with SMTP id af79cd13be357-947b001c6afmr209716085a.30.1794376806575;
        Tue, 10 Nov 2026 22:00:06 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:05 -0800 (PST)
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
Subject: [PATCH v3 01/12] KVM: x86/pmu: Honor enable_vmware_backdoor for VMware pseudo-PMCs
Date: Wed, 11 Nov 2026 00:59:50 -0500
Message-ID: <e08e3b6d0a8dcd25f1ee3e97a64acc1cbd3c0f1d.1794374897.git.zack.rusin@broadcom.com>
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

Check enable_vmware_backdoor before kvm_pmu_rdpmc() hands an RDPMC of a
VMware pseudo-PMC to the VMware emulation.

The pseudo-PMCs are part of the VMware backdoor, but only the
emulator's check for RDPMC at CPL3 with CR4.PCE clear honors
enable_vmware_backdoor.  An RDPMC that KVM intercepts at CPL0, or at
CPL3 with CR4.PCE set, returns the host TSC or time to any guest, even
with the backdoor disabled.  Inject #GP instead, as for any other
invalid PMC index.

Fixes: 2d7921c499af ("KVM: x86: Add support for VMware backdoor Pseudo-PMCs")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kvm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eef2f792dc9e..ca6dfb44949f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -759,7 +759,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	if (!pmu->version)
 		return 1;
 
-	if (is_vmware_backdoor_pmc(idx))
+	if (enable_vmware_backdoor && is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
 	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
-- 
2.53.0

