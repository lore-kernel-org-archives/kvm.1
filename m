Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589811;
	b=yXx9nswJSip5MmZLwJ1j1TYpycrOFOvKUqsCqa3/cJawVQ4S6bKHRZcSenGhBXC4gJy5
	 OhebDN8IEe8Onms31foGKpwx8+Y2ykMlAuzUnxbjRnT84sakB5UZOaptSiIYDt+tgXNbv
	 ku7p55S/E8wB5EakY0IjvvpUlrd0TPcp854euptKWclJDse+/gRNKgOwMe12+XSWDNXMM
	 LKnpEh3YqKCRRgC+PIGOuTgyjECvmQOZmZuaPct6HrOWn1C/05NRMLzqKyOdbIgYsQxjz
	 C9Tp8Nn8DcEBIYb19xdn//XOTF/jXLxjK/fFVGk/intC6BmQIpeWrIFx6i/t8DkISww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
	b=4FDk/7iPT8hwtTBRqqQA7idawMba6hdF04rBesbfWcTA5XRQBca1JosceHPa2j6fvqxP
	 QE7X31Ynz1TR94csU1RmzJi+b7QqIacgAouF9bVn2asuF+ccYc+1UreMx3SbtisWNkTXY
	 akOkgFyw4ATnB5ebcVbc3m8fzOX9ufaxDuzyG2vU4M6b80mDBIf2ZPBIixffffSdXEfnJ
	 BCJyU92oHpEhF6+eHdqo0dAvg/+ehYDV8A5ouedwfL1VRZLcWRsV5qBa4W6HNVcRNzwff
	 9ujw7DqwnfMi8uJi8FMmeqkcwpfJV/7D2y4nUEsSC+Gsy1uuAS/d7Hr/fDKr0/XFcDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=hKxqrr3g;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB076606A6B8
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB076606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=hKxqrr3g
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so47664305e9.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589809; x=1796194609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
        b=hKxqrr3gaqvIXon62dT+8//wIIjdDSIWRBzPd8QV1IYK3M82N3s8pT7KviOlpbceqB
         POL3tFPjnmgCXRvXs3bG0ihWnNUvLHBMDRWNVHVqTa9drm/i04+WX0EQ1JcraNK1UO2D
         rGTIdvjMeawaDNP+KUP6Wbru6HqOcnsPWNvQE3Ez2fsMxktWXBxkVX+oh987pvDJ/j3S
         qcccSF5b3xeERxNLxxFyr0QA0EYp1sBTBh1+GVlAtpj2u+tCsNbl0bOJC03qVUYLvdM0
         aZG+ezaxM97dC6sWPnDmWRletcm4pAZmkSg8dK2uH50d5PedPpEzp7HoGXwBaO/5Zeoe
         13xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589809; x=1796194609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
        b=bvUmlNwOi3cso9XjELhnT6t4rtC74IKYzTu6b/PpX2ztF6UoYllaBCY3juM5vlSyfr
         CpL737zh3vo1dBOHHLvVfXTOFhTfsI6Kpc/XmbI37l0BL1+AFmfC/MGP5WxHuTUl51uJ
         K4W9104f02BU12eCk1neE8bPvxy6mJOt79uGj279YvYiDtTJGUDr7m8ll6Lxfm1HATGj
         gyYJfT6xFiEL8MVqvYdhWTcPUrV4EYcQeYZf+7jrf6xViligGg2cANVBI29ss4Pu9SRo
         3DrUdyob6/oQkrkhx1NnSryj0b4bTQHF3nCFy5ObYyAb4QAWNLL3pYicy2J9zqZXTpJN
         7rMA==
X-Forwarded-Encrypted: i=1; AL+hErGER64iis2s9Xf9lIdWkGV4PUT7RdlHbGawgBKjAvBwD0T4uosdWW9RISeYE+CenX0+RJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EHnrsLIO4dFKOrehpWQdFVAk1dCKSkKk3rP0LRbIaS/pOGtPP
	nvhobbJN4FheLoiMymt8rCwTUgTvcUl/J7Ixh9pVrLRMNav2i2PRebXwi2IpO/QbldM=
X-Gm-Gg: AZFdTZcYGACOm50HD9shS4do8rrTjUjA4ygl705yirRhd5alu0FwVyzzfATVEuJmpyX
	XVUJ1wG7+iSNkQ2BkiCUXBgyomlu8fSTylL2ggPhq9NpEwgXMigUgBU7vu+WQL89UHILRyL6NXv
	mUqrNAVgZgURrRted4R1xwghXN40y1TL6rKrhZQO19TsWe5V0GMj5UgM+Y9OIY5ttYz8IhBIQpR
	cOyDXFxzyVKlJh93uFK1+06X41jmUiMYLv90O29v1ZT1aDvWDK6kROzKIaBpSLeLCMJcElqQExb
	t71vV91xx/3T73Shh9QXrsX8okfuftRhe/KAma9+gxo0lfQ8i/hhvJX9N8+mx3seJbNh4fCSG+h
	hj0cCY7k/7a7O1FtP5HEFDlM5G9XUIPzx2PAyVrVgGkJZmQ/Q+xNAupEvbMLyjbDEzwZ/I9epyj
	iOVl/LmyrPhS2LgbqQNXWsI200ibkVWAqF6hHVlEAcvnrJgG9xT8JV3wTACJpdDf72qI6tRSzQu
	wq7xHH7Yf7EeSJB+y31l1WDrBXhcj326kxjS+QppwI0uZSyFnUjL3Pr3EVBH4qMcxHm4SS5TVct
	879msP1uPuMDJ+JEdMk=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr352660555e9.27.1795589809163;
        Tue, 24 Nov 2026 22:56:49 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm414574595e9.9.2026.11.24.22.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:48 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:20 +0300
Subject: [PATCH v2 5/8] KVM: arm64: nv: Replace a pending SError when
 injecting a new one
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
Message-Id: <20261125-double_exception-v2-5-224689d8a764@pereq.eu>
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

The kvm_inject_serror_esr() function injects SErrors as the name
implies.  The bug is that it doesn't handle already pending errors
correctly in nested virtualization.

In vanilla KVM the kvm_inject_serror_esr() function always sets
the SError to pending.  However with nested KVM, it might set it
to pending or it might deliver the SError directly.  We can only
have one pending error at a time.  Imagine we enter the function
with an SError pending already.  In the current code if we decide
to pend the new error that's fine, everything works.  However if
we decide to deliver it directly then the pend flags should be
cleared but they are not.  So we deliver the SError directly and
then the SError that was pending on the next exit or entry.

Clear the pend flags unconditionally at the start of the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-229065@kernel.org/
Fixes: ce66109cec86 ("KVM: arm64: nv: Take "masked" aborts to EL2 when HCRX_EL2.TMEA is set")
Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: New patch
---
 arch/arm64/kvm/inject_fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index aa2011cc0d5a..0f6a89b65074 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -361,6 +361,10 @@ int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	lockdep_assert_held(&vcpu->mutex);
 
+	/* A new SError replaces any that is already pending. */
+	vcpu_clear_flag(vcpu, NESTED_SERROR_PENDING);
+	*vcpu_hcr(vcpu) &= ~HCR_EL2_VSE;
+
 	if (is_nested_ctxt(vcpu) && kvm_serror_target_is_el2(vcpu))
 		return kvm_inject_nested_serror(vcpu, esr);
 

-- 
2.53.0

