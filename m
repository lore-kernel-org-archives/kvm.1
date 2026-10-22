Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703568;
	b=iIzduwVGggv6T5YpuMkqFMHb6BP3hWnsgB6cPufKWn/aAwhoOb7yjQveF7ycSLjZbM7L
	 7HfzSAHSd3QmPfNdDchJymn23nl7X804NuiMB2tZ7SkJxQ5k9R/ug5BcgT2SgW8Z/k/ik
	 JY4n0mpKhzFQh6HHYW6eC0M+lblmec/fJetM9CJHf2Vvki1GOl4oGeP/eMWlfcSc3MaJf
	 dtuA1y4N+GvXuan0sjzz4XlK7+bisJVZIV9E0yVL6wgfMNjUwhmQVIsX6yA2Rx4ojm/iz
	 C82iiWWWSsuHX1LmDvXQsgmAyTDWJNjER4zWYvsqJoY9Zkm3rfxGoDD2BsqlngJIwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:Subject:Content-Language:From:
	 Content-Type:Content-Transfer-Encoding;
	bh=jFuOE8pfAZPQqgdzbPbnWjwK7LES4BgvCexGNd0DNIw=;
	b=V5CbvNWG26iosWZXdN9tmHK3sN2qNAhUtK8KNAUa7UpRv4W2mfqFkpECIDoFUwL4iYYT
	 q7sryn9BkkPqc2GR9mtkDbh78EiHLRSPtyeYWcHpwiAOvCo+G0a3vw99By1C14l64UfTw
	 y8Unr8cA05XAADrKHZGs6IstAI0NqP2HKbpADtDRvaZzyYvyRkeld4AQODYRrnqghehai
	 QIAHqnKV2Y8sI5Zz1IbLLpRrfBusoJ/pfIIaDrqqjJMjMU+IePOwhxc2Dmsy4j5qXLFn8
	 WusP9FVvgvc+Z7dbT/c1W4yJXvFRJ6UXffSnArBlF3bPgx2Apf77dmYuEWMYI1DvsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NM18DjwE;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15AF606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NM18DjwE
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so2642435e9.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792703566; x=1793308366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jFuOE8pfAZPQqgdzbPbnWjwK7LES4BgvCexGNd0DNIw=;
        b=NM18DjwE/DhlA2Pcg3zYl/2cyR6AxA+YbGKxkNP6zUrDPIcWKPq1OcKoTvn8rbE2h7
         MhZtrRpx4Hg41VLUP/69irJGUxbpPvFJxR1ji8JdaNXrIg/jh8cYw5qFun2R9lt9iDfV
         h22UdIA0hOGV3u9p8SHz6DT91dtC9BGF7PZxh9rgRhRVS8WswaMewe5dYlZlcDd1Nl5F
         wr/uJh2XOJrB8XBuu615kbsKg+CcjPE+Q5ctx5SvoTosUapOEMsECr3bLmy6JZZ5nwwd
         gR34KBVLq2S3Hh+44quuGJlR40NEH+59+vIeL1xL2G92dgzs0YOtSY5a9l5IvmW27YmO
         4nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703566; x=1793308366;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFuOE8pfAZPQqgdzbPbnWjwK7LES4BgvCexGNd0DNIw=;
        b=YyBjb85pD0pfmg72YKRuqSobhutj6jrrO/zpGKLJTKZA9Z3tx+dFizRiwOKu1udmL2
         zLQrYiebyfqtz5S8lQkYxjZlLHLYFZ3rfqPk1EOHlJtEx9NqFNU9MIE94y5I7BZmBkvv
         b6ZEUth6tQTI48PLM83+wH416MQ3YZFUpReUDHp85R8yFLj01WQFEypwU0Bj0aXsWQMQ
         5emZWH6eQZrCy9Hatcl20m3ycqnM++hLpypQfp8obfuElu8tEe1+48ZknO/rR5wWBhRq
         UPwCURJHEiYMgFvZJK8GV3einrFj2HRbTTkYgbRsUtvgs0WuVS5Y8uVUAyq3+XIDAvds
         CycQ==
X-Gm-Message-State: AFq9FYKJ66bfk+PSM4v02zy0D2XP+6Ze8aGCwjju8RDiJjwFMfI+htfd
	HY1FYNGI2ageAHzIOx123Ev6WBXzWtbLb/RY7ttq6WjR3tVx5fBfDzp0
X-Gm-Gg: AYBFou1VmKU4DjAB0Onr7EcS1ijGZmp3qlc7stMFkzK30OXjaUrkrw5F22LHC/VWhmo
	XjX2BY4yl0+RmXwIT9VoF2252xxjHInQsLUqjB6YVQVNoocECOjb7cxEjBwfw0lWXuIPrEFMAVu
	Xw8Ikb0y2aINqSP6U3FyRv83XPXB3vPIi0kyLZ+peHNVeIkPx3bRvcmIUSNLkz1lNhq9um+D2yy
	+xDJJifbqZ4y5S5nEnpgAufjz/C6maisqS65o4oh3JQA9MvyVlsvljDsH/XMKg861yVhzPcDQwU
	HThoqKzcrkd/gGM7mujQd9pR4dmAL0uBB0siGfzRbYvWzizJIGTlTHASwPUDGvwBigofqhcR0wx
	xhr87P+npV4Emu7/O/G8ePzIuiNcwN7AqgHD8SOji9FYbBMrG7AN+tSchLKMHebwiRYxixpNeeK
	1xAhFLtCNtdnRnGkTRK4cRQ4ZyOkKRK8ij8zh2ggQ3eoOn64idh0skAbua9vynJIcTJOh4RsA4r
	HpToKox6jm6HKVdLoq9HGmMKC7ui3O6gAELNgKtUEnS2cyfLlKA0lUAP91ETxpWh/gySyHkh1Ly
	oXoZ4AjUz94EajawNJFCD3PVnXlXaWMhZMJJ1iaM5JWp98DEWyKO8+H3Yjil1J5QxdBHPPO2wBE
	af9U+oC/xwI400u4=
X-Received: by 2002:a05:600c:c490:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4a211eef757mr3819855e9.10.1792703566193;
        Thu, 22 Oct 2026 14:12:46 -0700 (PDT)
Received: from [172.16.56.234] ([87.190.40.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b899ccsm9084735e9.3.2026.10.22.14.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:12:45 -0700 (PDT)
Message-ID: <cfe12756-208a-4a3c-bd46-cfdfeae6cdb1@gmail.com>
Date: Thu, 22 Oct 2026 23:12:44 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a
 pending event injection
Content-Language: en-US
From: Amirmohammad Eftekhar <amirmohammadeftekhar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

nested_check_guest_non_reg_state() only verifies that
guest_activity_state is one of ACTIVE, HLT or WAIT_SIPI; it performs
none of the activity-state cross-checks that VM entry requires.  Per
Intel's SDM, "Checks on Guest Non-Register State", when the valid bit of
the VM-entry interruption-information field is set the interruption to
be delivered "must not be one that would normally be blocked while a
logical processor is in the activity state", and for the wait-for-SIPI
state "No interruptions are allowed".  The same section also requires
that the activity state indicate the active state when the
interruptibility-state field blocks by STI or MOV SS.

KVM accepts a vmcs12 that violates both rules, and hardware does not
catch the miss: prepare_vmcs02() never writes GUEST_ACTIVITY_STATE, so
vmcs02 always carries active, and wait-for-SIPI is emulated in software
only after a successful entry (the mp_state = INIT_RECEIVED arm).  The
injection, in contrast, is copied into vmcs02.  The physical VMLAUNCH
therefore sees {active, valid injection} -- a legal pair -- and
succeeds.  Because the offending field is stripped before hardware sees
vmcs02, the missed-exit WARN in __nested_vmx_vmexit() can never fire for
this class either.

 From L1's point of view a VMLAUNCH that bare metal rejects with a
VM-entry failure (invalid guest state) instead succeeds, with L2 left
parked in wait-for-SIPI holding a stale VM_ENTRY_INTR_INFO in vmcs02.

Add the two activity-state cross-checks that KVM strips before hardware
can enforce them.  The HLT state additionally restricts which
interruption types may be injected (external interrupt / NMI / #DB / #MC
/ pending-MTF only); that matrix is left for a follow-up as it needs the
per-type table, whereas the two checks added here are unconditional and
cover the fields KVM elides.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
  arch/x86/kvm/vmx/nested.c | 18 ++++++++++++++++++
  1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f8..66c9d1ffe 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3311,6 +3311,24 @@ static int 
nested_check_guest_non_reg_state(struct vmcs12 *vmcs12)
  	       vmcs12->guest_activity_state != GUEST_ACTIVITY_WAIT_SIPI))
  		return -EINVAL;
  +	/*
+	 * The activity state must be active if the interruptibility state
+	 * blocks by STI or MOV SS.
+	 */
+	if (CC(vmcs12->guest_activity_state != GUEST_ACTIVITY_ACTIVE &&
+	       (vmcs12->guest_interruptibility_info &
+		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS))))
+		return -EINVAL;
+
+	/*
+	 * An injected event must not be one that would be blocked in the
+	 * guest's activity state; no interruptions are allowed in the
+	 * wait-for-SIPI state.
+	 */
+	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_WAIT_SIPI &&
+	    CC(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
+		return -EINVAL;
+
  	return 0;
  }
  -- 2.54.0 (Apple Git-157)
