Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132633;
	b=NOR/FO+/jI9gq41WzD09FPeqUOYFn3j6bo1eZbZQeqfghjz6/g9y97aEaPYE+FBstOqM
	 KTsiJGfSjxHORSSZMR8ohFP0qLpHeK3im43ZL485yDaCayh87JHrMokSfH6ZhMKY/js67
	 PsLbWfuhB1iyZ4ktG0mV6/reMKnA90GV9advPQSpK/1NvD5UzWOkjb2im5vtmd7g0bu7V
	 lAvV7j7uouGHxk2Gtj1XS2vnBYyvYC6Fa8UdNx/vOK1mYgZrzpRABZ2u2n7gjie2Bm6Wp
	 UIkxJoGElYrc6351cHBQeZ8D9j3n/wPwcTqEY0zCp7f3mcNRQtp3IcldMVfgvdetqqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=CxL1JG/eaAvQmtg2HGu1fjGYJ5Z2sLLivJqdimcugHQ=;
	b=WalFN7auQjK+b3sIPiZHKZQFc9WZOwFab3oKTGeapI/5WfaHcPLsMG4VKur1w19LgtaR
	 eI73tHCSwGJlN6LxkYlCiXvlH5epvJmaygLZ0Dcd6bnFasN6Es0rrKSGU6cQBjIf+nx0D
	 s/3mU3PibGLxPNC4qldJ/BBHfm9cFryd19TScDr5fkB49hiJT+ExG4pgCUoQD9c3L44/v
	 WPPfEflzC3+tDp2omJzoLGnJhW71BpIi6yOqthquDtunHparHw/J7/lCDgUe2XB428X46
	 5mn5N49AdBJ5otEq8xVoSpXVL2W28YoA2gpzuylRYonkQgwaTxx1h801AS5hnEUTj6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="n+AKW/mn";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D06606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D06606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n+AKW/mn
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b40b011aa4so533960a91.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795132632; x=1795737432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CxL1JG/eaAvQmtg2HGu1fjGYJ5Z2sLLivJqdimcugHQ=;
        b=n+AKW/mn3+R19SrYgtrVtFd5Qzdj+LpN0rbt9HhVWurSSmftxyAqZLc2Ri+jJSwGMH
         3oW4785YiQiD6nhey27+2loE0WJAlKuId2XNQDRYREF6Yc3LOXg1YMgqOZqbP/4aRfbA
         NBH+zJLF+ZKUavTqOkTHNs2Rmc51wkGjZgEfDpYYr0A+UWd7vFkm2IALPMZvu1LYLFy6
         2tEqwhb5eAorQJOHqGH07yxmXpNNWALYYsegF7QPBb00NqxK3LJqkQmD3H14verS0jMw
         JrLv3MBdUm4+FfLokFk1NUFs+ug7XZ3LHCM0qBV+QTqBznGUNBnnKpw6Zzc+c3R5S7w8
         LUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132632; x=1795737432;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CxL1JG/eaAvQmtg2HGu1fjGYJ5Z2sLLivJqdimcugHQ=;
        b=1+a+Zu4kyOXeMNsludy/8X8629jXox8viuCa9qe2FGGk85yCMZF3Uw7TYkRYD8xeeU
         sYW8C+xXWdWSmGd/GBX9saG7DJ8CIUSJyA8S7s9Bive5DDWTaDjEASVE+mbZjDWTvi5+
         kd0KLX1cuS2lk0NXEWN56r/t15cKlSAFWmi6z7T3beY+O15w873fOfPtwDgv4FYegCFE
         ZxgC3+LaiwuQeAQzVmyUCtLyX0z4JuOwJnIRczPLyz6O5Md3RVU3/FVpe2OIs8XU0oAI
         Yofl8MgwtjkXbDWKgEX+S0MQfeLb0pUdhPFMWLKqaMIunV42XsYxmpFkWMujI2pYO/+I
         RlYg==
X-Forwarded-Encrypted: i=1; AL+hErFkCMmtZBnpTaoQfDrhTlGtkkq2y6+FETWWMFtl6mq5rdGOrhN9h7+ZQ2/zXc6Ca1gDPmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z829+SiSkWm6yPTmws6fvGEEKXXsWSdSztFM/I0JlLxnCtRK0ct
	yJDvQyqJoEphQi3fLtrwIn/BHEGkdm5bh1Ds1rPz6rZ1plepjBtFqoODWNUSNcT63V7gqeXyguV
	lLtSNoA==
X-Received: from pjbhs15.prod.google.com ([2002:a17:90b:200f:b0:3b4:a90:5a08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8f:b0:3ac:9f24:44be
 with SMTP id 98e67ed59e1d1-3b41c92a3dbmr971067a91.29.1795132632118; Thu, 19
 Nov 2026 15:57:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 19 Nov 2026 15:56:56 -0800
In-Reply-To: <20261119235656.70315-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119235656.70315-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119235656.70315-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: Extract and dedup the kick code to check if a CPU
 needs an IPI
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Extract the kick logic's code to determine if a target CPU actually needs
an IPI into a helper function.  In addition to deduplicating the existing
checks in common KVM, the helper can "likely" (read: will) be eventually
used in arch specific code as well.

No functional change intended: KVM always uses '-1' to indicate an invalid
vcpu->cpu, so "!= -1", "(unsigned int)cpu < nr_cpu_ids", and ">= 0" are all
functionally equivalent.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 48fef91b8530..d8027ea0c447 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -209,6 +209,11 @@ static bool kvm_request_needs_ipi(struct kvm_vcpu *vcpu, unsigned req)
 	return mode == IN_GUEST_MODE;
 }
 
+static bool kvm_cpu_needs_ipi(int cpu, int me)
+{
+	return cpu >= 0 && cpu != me && cpu_online(cpu);
+}
+
 static void ack_kick(void *_completed)
 {
 }
@@ -273,7 +278,7 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu,
 	 */
 	if (kvm_request_needs_ipi(vcpu, kick->req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != kick->me && cpu_online(cpu)) {
+		if (kvm_cpu_needs_ipi(cpu, kick->me)) {
 			kick->need_kick = true;
 			if (kick->cpus)
 				__cpumask_set_cpu(cpu, kick->cpus);
@@ -3951,7 +3956,7 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 	 */
 	if (kvm_arch_vcpu_should_kick(vcpu)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
+		if (kvm_cpu_needs_ipi(cpu, me)) {
 			/*
 			 * Use a reschedule IPI to kick the vCPU if the caller
 			 * doesn't need to wait for a response, as KVM allows
-- 
2.56.1.708.g77570a6a1d-goog

