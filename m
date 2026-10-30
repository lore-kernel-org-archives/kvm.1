Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395296;
	b=gFy0zymgCpORR6tdb+F6EiDO9L4UiZqmSwKvPGAXIbCWMsJPFkwnnjHCl+ZnXsUtT8W3
	 rrF/I7nXS1PkG186fC8dd4OsK09S89kBvZiR8gVB9GWxz7morNwOrlkjJ5pbrBWM9Rl3S
	 uN5yU0bolYQyfqWhPwDcw9u7Fzr6A0tMQ4dk//Fb6EhdOMmOVMjztcY8GBqKmtVZsfuav
	 byNxz9jZOGdHyF+dLypFacYgn6lGEfRS18CjXvgns6WYVjHAiF8LQHxiTyJvPdd46U9Oc
	 n597Wpl5txXLijIKHKBJxy/h5hIecvlyM3Ldk43szKvgphdDWTWxGz5GHMoe561ZTlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
	b=b/jckl7r/zx5HPI9KzK/QOxL7Aq2f0HDgWMHHw7aQZn2jbYgyCj/QiaMfERoJL81CLK0
	 Fm1J8n5QeNxiTw1a5CgkrO6PXcO1k/AAgVghbs4P1n6wT//DjYnICZ2JTdLwKl6Y1XVuH
	 lH4nXPt1Yzr26Vc9Svaok+uvXPfUHsgNTnmd4nJ6CL2r77WElJ1nsW23q8SLAc4EAwirA
	 Cf/A0FJufQJ7beLVh5S7XgySKp4ETiAdzURpWYUjfc581GdLii1csKUWiEhEsj51lYGmP
	 +vbrQDBjD0eEPOr7KWxnDkfRGrdaKtRVS+vkzbqpqX8nCMEdyzC5U+eqYc0CRg+P2vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R+PQngeS;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61A606D968
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F61A606D968
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R+PQngeS
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so987014b3a.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395296; x=1794000096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
        b=R+PQngeSOkCIs8w+1oDbMZaW7MkHUlsuY7FNbNw7TIre9Em2V58dH7bsp5TUvYBWtT
         3yVvUWlnjcQoxgbq8dZKijcCqmKKB78cgjoyaFtnuAerVV6SGpi/UrzK7r6YUuyDCVqb
         AU5hU5Iw5j4NaX41ayczTXDIO0nBf1fkfTm/9jZivD+9ZvdGwGu4+cy98PEtSxXv6uB6
         QHfBq8yXqnYAMQdPFSUXSl9/DOq6UvKV0zoem8jv8qfpYjgV4xcDUTVismp8V+IF8edC
         TBiSi8QJdmXq4Y0BuWCP8h4onoCZlz1OVhUZKOZMXEI+1uTJr8BifBiPa/gRVWRYcvWb
         foWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395296; x=1794000096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bp4E318lJOU9KTeZ4/sgGBHaMDL7s7CdLDZqDaaPsA=;
        b=z1qicT85B+CDmd+cKyF9XjLEuTT2PBc/1BAtaYGE+WJsH87zDPQ97d+I2Wnf6LH+8H
         M6C31ITEwG5Ur0+LuM1v0awl4nljL9eImM/8vOxe+zQkQOZQR+0FQTPFcOZE4anCIj2x
         tunAgijRRicHbHq0OG3YcFpEb9oNVrosoBdeD8f5C0li46FfChQsobbp94PMcC3QJ0Nc
         dyIlmaw9cirwcdETyGu8QPKTeruzfboF27FBFEuW+YNCFlNdaiiu2N1ynF4LeEXw8K9E
         l/u9EDwTNC34aKPsD4ydbiXXd9eWu2M/q7mgMn0iDXBoSM92JvTJSG/G/FCCwa0mStpI
         f5ug==
X-Forwarded-Encrypted: i=1; AKwUvBx+30EtbXwQ0KAGNetG+cD0O7lxbXSmbSMQwm6dfoMzl2sf1cNI/JecUlEHN5FuMlZ/0iI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKltiYqMu5ebsmDYD5CqqnFx+b2uRy/OxsMVIADfB3+Sd8FvRv/
	M8YBc1AAL5gIfkKWLYZRNAo4n2kCvmDD49HqIt+7f+WirU3G/EhsfwcueTqiV6FsmEmCRmOTDa0
	WMXIJdA==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cda:ea8c:c389])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8201:b0:3e2:7643:30b2
 with SMTP id adf61e73a8af0-3e928a7a901mr3766488637.3.1793395295633; Fri, 30
 Oct 2026 14:21:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:06 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-19-seanjc@google.com>
Subject: [PATCH v4 18/23] KVM: nVMX: Cancel the nested VMX Preemption Timer's
 hrtimer in free_nested()
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Cancel the hrtimer used to emulate a VMX Preemption Timer for L2 when
freeing nested state instead of precisely canceling the timer if and only
if the vCPU is/was in L2.  hrtimer_cancel() bails early if the timer isn't
running, and KVM initializes the timer when allocating nested state, i.e.
canceling the timer even if it's not fully in-use is a glorified nop.

Canceling the timer even if L1 is active will allow KVM to leave the vCPU
in L2 without having to retain an "is_guest_mode()" check just to cancel
timer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b30ad7731ee..553915015a75 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -339,6 +339,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
@@ -401,7 +403,6 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	vcpu_load(vcpu);
 	if (is_guest_mode(vcpu)) {
-		hrtimer_cancel(&vmx->nested.preemption_timer);
 		leave_guest_mode(vcpu);
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 	}
-- 
2.56.0.385.gac671c819a-goog

