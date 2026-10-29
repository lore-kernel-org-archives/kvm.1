Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317847;
	b=JYEVyWpIRoumQ61i8VUkblrilceq8uvDIOCxIe0JogI+zJ8vwABhcsE0aQKzBXbGh5z7
	 yl73x3Uxnxt8THQb76tKvONaPcaGR0CNLtI2ZeVsHg+90vIu+TXsC8+b6SPp8nZBZy4vN
	 dLHXioXF2OY4FVt+3x8XOW5/zRnBVtntsN173jXmWdG7iwF2hpGg1K1T4tWvfj7oFhziw
	 h6Q4JiYnIEThI00X14tTYBen8G5jdtmPhYwEA5AjFBPnikNCofq3VuYCr0yiIiljy8mZ+
	 d4+68t1jnSZwt2nH1J+r4hWcCx/wfYatciZi2+dnNDPcAOAWh0T4WqTG6F98EOpTX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aLKH9Mb7xVZoEANx5zLK4zjozsRFYCrTpLOqfVIFbFU=;
	b=EBzkgY8oHteu7a3vgXT3ZE4X9Gwxt7YITmjTc1glp6jdmc+OyWoDfRB2q+zS1o1sQJuX
	 flnNPCjbuIxv94yY3crk44HLKPpI9LNcBnTaHpGLfoAnvM2ivq6vbBuUpeyRxsietY5Gk
	 F+W7UWjyT9qSZdFrZjY6Hip9Z5kzBjG1y+yeZI9AvsFkDh5vMsX6D3/EtKEmSIFVCE1MU
	 K96qCWgBL0OzNWKZ812x5yt5Ors3zj3XuRtC3+NZDuyvoDDoKmUTJWEynuuVJw3HvvXbY
	 YSiQv8jYptzuZ58/HO4mYt+tMb4kh5Hnd6PLLFb8DFp42m+J+MC/Jztd3Cxcivzdd0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6t4nlL+;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81ED606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B81ED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6t4nlL+
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso836205ad.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793317846; x=1793922646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLKH9Mb7xVZoEANx5zLK4zjozsRFYCrTpLOqfVIFbFU=;
        b=x6t4nlL+/THve+kHJInO3FmP78H3hnlw8R/TNjnUl0q+3MFcz8V4p2WlKkfwrIeXFS
         dDSwysLd952vKhoSz0Fp+dzZwXu+dKZP27WkOYTQmGRQnUCUHrh/2EuLAyFacYHoeIME
         se9FT4e+jl1v0G7doBPpOqMr36vuV1RSriPV0lD6teqvd+fXmoWME/tjOggoTaTOGgpU
         RBb6Cl0ys+h95ymk3vujCbKnKUH12Mw/bxVwKgCqg5/Aw1ToL5oEo2ENt13nHGiRcmzr
         TgE6r2Ym3hB6e7/Xc4mc9JlIT2yeBi4am/Xwi/5ygOXMRQ1bJ0X3s9eZ7NQzRF4WnZKf
         xpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793317846; x=1793922646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLKH9Mb7xVZoEANx5zLK4zjozsRFYCrTpLOqfVIFbFU=;
        b=nu9iN7EJR3HeWnKedV+R/FqoUqEGwieTDfRQ3ZNLMZZbZ4REu02f99KhCDp8JP7aag
         lSbqBCSNYx4om573gN9g0Z/J7TuZBeNjQ2bKe5aXDzW0O4JukiVZ0UT8DtqFEgBDRIv6
         DgK/NQFdeRlgfCXzquhKJwF9dHRbnanF345mGbmWENJdHfL1FBaPC5TTf2CnHwN7JUtf
         yV4RgAUTjUT18ornHqKgfkofbhCV2FzI2LXJkGoFowIm8655QmQhbWkxZJNAnlN7EIV9
         01XNt2LTVTzNrbDnqUVUKWOXyk0sXOGyAmH8cjpSGhKgnccyQzi/hb2TS4pO6aAwp2TP
         iXNA==
X-Gm-Message-State: AFq9FYIJVWpPmAhg1vh1Fx7s/ETykwl2HqvPrzdkylaEMmRrvlGCJ3qh
	uOMFNWtKpqeSPb5u5vmU91FYADdLkFQibzdBwJTaEYR6zrDz30Qq+tjj
X-Gm-Gg: AYBFou3nWFxH/EdyLRFVDrOldGP+hn4jzn/WReMJQcWZpPbVvvrkLsffV927nfhVg0c
	sMPA0J/XZWGBP6jNMfMANiOU1dm3izG9J+hbATPSp0UQYm8B/W84hq/gqfXKy1LQP9OmIukBxdp
	e1GxoyV/7jj1L8i1itoJ9qADPqngEp3D8golE5N9uotUEykRr/C1XKJUi9pacrF2tgnIkcVHRQV
	2AKUz0oHytyOck8I3skZeSO6KLKExDDHBpfayoh2w6anZS+7jrh086kIhLSG92PuOxFgANAvzlJ
	Hp78kG/hgZ67LlMcuC5jhg5O65yIIPUuJnxPIslJVLQoA4DCUfoLl2OkJUj5QTPKbhViq32D3C2
	8NLsdxkYWyklv6M6QCt40eX+LLjuk76ugeZMTpwylzO3FMRK5cv20sdPXtaihSayxbtGOmbCNPQ
	to5+nEQkgVMJjnvOxe4UAjak+vfeMeJ8DxJslUNfXXF2gu2J9MRH/a2FI9s9F+2VAziEYICXMAh
	5sAtoLaiCOC0tuAiasEbxf4xs2U6bGIUbe97lkaIQbp0unM0kW97aT+hEbmEFxNRjYfgx37GEWP
	bQCv3C7dbv1mBEwBQRYyE//DnYmq75gOX/H3z7VfnLWCedV8D0WNP0OIElTs3XMF9d8wGuzawZs
	NfsU9XBSU5Q==
X-Received: by 2002:a17:903:24c:b0:2e9:4b32:fc6c with SMTP id d9443c01a7336-2eb3643d494mr8145375ad.26.1793317845994;
        Thu, 29 Oct 2026 16:50:45 -0700 (PDT)
Received: from monk.. ([2604:3d08:8e80:f800:3c86:745c:97f1:5486])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm384225ad.40.2026.10.29.16.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:50:45 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits owned by L1
Date: Thu, 29 Oct 2026 16:50:39 -0700
Message-ID: <20261029235040.12013-2-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029235040.12013-1-ma.mandourr@gmail.com>
References: <20261029235040.12013-1-ma.mandourr@gmail.com>
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

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

When L2's LMSW exits to L0 but not to L1, emulate it through
handle_set_cr0(), as is done for MOV to CR0.  kvm_lmsw() ignores
vmcs12's CR0 guest/host mask, so L2 could change CR0 bits that L1 owns,
e.g. clear TS, and read their effective values instead of the read shadow.

Fixes: eeadf9e7558c ("KVM: nVMX: Handling of CR0 and CR4 modifying instructions")
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/vmx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c60..3633496299 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5748,6 +5748,21 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
 		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
+		if (is_guest_mode(vcpu)) {
+			struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+			unsigned long mask = vmcs12->cr0_guest_host_mask;
+			unsigned long cr0;
+
+			/*
+			 * LMSW leaves the bits L1 owns unmodified, as does a MOV
+			 * to CR0 that writes their read shadow values.  Emulate
+			 * it as that MOV: L2's view of CR0 with LMSW's bits.
+			 */
+			cr0 = (kvm_read_cr0(vcpu) & ~mask) |
+			      (vmcs12->cr0_read_shadow & mask);
+			err = handle_set_cr0(vcpu, (cr0 & ~0x0eul) | val);
+			return kvm_complete_insn_gp(vcpu, err);
+		}
 		kvm_lmsw(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
-- 
2.25.1

