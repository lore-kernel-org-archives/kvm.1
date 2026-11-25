Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605067;
	b=OXPj2LE9z9yVhqjGiQ11s+2xOwVz8Iydz0H2VCV/rW0xkpO9Y+mKGXBNGQ1/9fC1oYff
	 HAXUm3yjRjcJM1nuXsfsl9So5HVIShaX51iwzI2FF80bptnCj91BzxbQk3Ktb4QRWlwoP
	 wPnSyxS1xQRU9HEbgU+h3HLmd0BoXOhoEFeljy+IKFWeShpYX7uqNb0TCAgrX/XQR7dyR
	 0sXakIT5gOodrMa2eUReqT7vfrae/xExcmu4j112SSW1RbQoNwOQh1jJlRoQz1ZolY0UK
	 F76zpRjh7fPMNRMsZOihf4R232h+qD0TstuSLa6o678WcobDtFf20uOGBaNYcikolZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GwYSD6vLytxfk/SaYw157pRt5ax2r3pG88K3W/iLqQE=;
	b=ZVVQQ4ESJErJlmzbQEQVO6iO0Ux0JWHCvbHt04bNyBYUrZNwKOUt5ppLfxxZ/trmSJP/
	 swbZEqLnuWJzcd6aXKGjkn7/Zld3lFNPLZpS2hZC14ZiRdkIN19hWEVI+Ca1VDAMvw6/Q
	 fP0WrNM6pWOLrTrv7UWuLKi3g0+Et5nCLu0UyuAaNJlMiTfbdAdWu4gPSnT98jjTbR/kj
	 1poJ4Ig+NmEapsUDpSsAcJdcIL/WVpFjrIZoTnZf78GB5ArMdNO50NAVPQ14HaUBE7fjB
	 IpjRBd0JmOKoqGKt7nyjjwNLGdfKGdkRUTSgYyCuoYxgIH0mlwIYLdXplS50vE+HiwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=BWLZrYCZ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6D606A330
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C6D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=BWLZrYCZ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491846221ffso4811574f8f.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795605065; x=1796209865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwYSD6vLytxfk/SaYw157pRt5ax2r3pG88K3W/iLqQE=;
        b=BWLZrYCZzZvOcihScmYHFtsJlk9AV9A0y2EYpEIkC6e1E4SDFZoRrK7EEKs9LFzYDd
         1twxZhRV1aHpvQ6say/c2He7AteWUxXV2SFlr7h2QARea+N7CF2hKri7Y6+yGblVI6zv
         f6CANBfhl5UZ41lWHBn5tgQ9zHrkXiRYw/QHQ2+cLIwOsWkDHn4qeHOMuUCxUEdq0lO5
         HPwXA3+CjEuPA9Njg0+AwUJTyepA1E8JQYjXaWXoox00hrDGC3rYw60euY0yQMBecthx
         WePpIbDfV09JI0z8NUG156yCkJkW9FHfBjD7W9UdNFLAxdO2SNrevuuuFi1Tb9RqaETO
         DyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605065; x=1796209865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwYSD6vLytxfk/SaYw157pRt5ax2r3pG88K3W/iLqQE=;
        b=pQWt66TEsKgJMvBsZBJvQ8mfw4YgmoQ6na/ZIgF0JHu1+0ZiUNw+who/j8lfJOt9KO
         PYNFMh+/mas9vz08PQVuT8nbAh3P8vJtuFW9SCQVgNW70aUH/uWwDYgxTTfPDvVt9LwB
         6+6IzU7rAP0EGevxXvVrNIaAMx8erKd+l0xYdSD6N/Jiauu5NFOgy7T1Dml+UC57D+g4
         qAAW4QwlUwNjPeBoxkUiekrozY8lvS7uOaCGAzmxknfyvoasbPYWUQYjxi7dW7b90Ztd
         ek5f5YiNcSqOPMOP3+zAVlRcb74cFXOyc7tgVMKlg9h0Z2n5byMx8vFDVA1ZoEiSln8m
         eONw==
X-Forwarded-Encrypted: i=1; AL+hErFQwGHXlN732EoYjwHEG6iHmh3d4stVSCx2ZNMhOfQoQP66nFCL3zrTNjjcvkGd9SRbpkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CxLVaVG0J9rpvZwP15KCyqolTn43HrjyWYntqGM9JZvbhp99Q
	LxyqUzFjFhb2NhXMkJWOEO0ydBqykWJMmB+s324uIcKbpTCkxBhABkR4OOIXyYPvQsg=
X-Gm-Gg: AZFdTZfvGRkP2EY3ya4rWYkVsUuI/OmDHPMfC3CEYIRO7jBGF8f33RA0IShT6ks1ItO
	mzZBVn6Ft1PPhmPHz+y6m7pWwyqP+B9hqhMKYadJee82uOL14XFcN8pL4GXuXll7uJkPH1b9xfP
	shzfSm/392zjjn3n8cZ5vYftLffOCg2QVZon59UXQ2YYRyH3YtOwe5P42/boY/1dZpBHNFuHYDh
	v4eXVmd/p2X9fAFZJTpaPx4vcMrZqRtWJFzYl6t1dBG+IfEQZ+/MyXwdxC77VR4VFyDbvYFZjCr
	wuLHjB3YFFEiTmwoRJ4XhQM+pNtmvvcx3JfHz/MAXeG8ctn9vMBNh2Tj3vAmbE+u6uI+/T084O4
	cBX0sIXVmGStxxttNRX6rld/AKHt+iZZCRSpj9EpR1XHJLHpWSOzxJUnaS9vCORYAht5QOAGsTz
	YqBcwoxQqmo3qooAJxEauqY8UZHCIl2CDLTrqGiXALz1NkdxBI4a+jqxLp28haH8BZP7x80cuO/
	QpfyAkRkUjCHP7lJYyFXOOL+X9H2HwBoT7Mib5R6gGFOl+rxzKwL44xIPWcND5vGAafZGjDdf8l
	8rTRPLtr09c26yK9JRA=
X-Received: by 2002:a05:600c:3b88:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4bb8880789dmr402949245e9.13.1795605065419;
        Wed, 25 Nov 2026 03:11:05 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm33509812f8f.52.2026.11.25.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:11:04 -0800 (PST)
Date: Wed, 25 Nov 2026 14:11:01 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Oliver Upton <oupton@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 6/8] KVM: arm64: nv: Don't deliver a pending SError to
 the wrong guest
Message-ID: <awbCRenrEfnRszC_@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-6-224689d8a764@pereq.eu>
 <sashiko-outbox-232776@kernel.org>
 <awaWhy3IywYrP2JZ@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awaWhy3IywYrP2JZ@kernel.org>

On Wed, Nov 25, 2026 at 12:04:23AM -0800, Oliver Upton wrote:
> > 
> > [Severity: High]
> > Can stashing NESTED_SERROR_PENDING here cause sleeping in atomic context
> > on the next guest entry when a virtual PMU counter is active?
> > 
> > When L1 has a masked pending SError in HCR_EL2_VSE with HCR_EL2.AMO set
> > and executes ERET into L2, setting NESTED_SERROR_PENDING causes the next
> > iteration of kvm_arch_vcpu_ioctl_run() to re-inject the SError back to
> > vEL2 while preemption is disabled:
> > 
> >   kvm_arch_vcpu_ioctl_run()
> >     preempt_disable()
> >     kvm_nested_flush_hwstate()
> >       kvm_inject_serror_esr()
> >         kvm_inject_nested_serror()
> >           kvm_inject_nested()
> >             preempt_disable()
> >             ...
> >             preempt_enable()
> >             kvm_pmu_nested_transition()
> >               kvm_pmu_create_perf_event()
> 
> The PMU crap should probably go in a vCPU request to avoid this.

Claude is happy to write a commit to do that...  I can add that to
v3.

regards,
dan carpenter

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0614c3b3a40d..6a22156c9107 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -62,6 +62,7 @@
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
 #define KVM_REQ_RELOAD_GICv5		KVM_ARCH_REQ(12)
+#define KVM_REQ_NESTED_PMU_TRANSITION	KVM_ARCH_REQ(13)
 
 /* Bit indices for kvm_arch::flags */
 enum {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a148e80d0aef..fe5e4e47b935 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1310,6 +1310,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 			return 0;
 
 		check_nested_vcpu_requests(vcpu);
+
+		if (kvm_check_request(KVM_REQ_NESTED_PMU_TRANSITION, vcpu))
+			kvm_pmu_nested_transition(vcpu);
 	}
 
 	return 1;
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 39136a89d74b..ee71dfc4b861 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2837,7 +2837,7 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 	preempt_enable();
 
 	if (kvm_vcpu_has_pmu(vcpu))
-		kvm_pmu_nested_transition(vcpu);
+		kvm_make_request(KVM_REQ_NESTED_PMU_TRANSITION, vcpu);
 }
 
 static void kvm_inject_el2_exception(struct kvm_vcpu *vcpu, u64 esr_el2,
@@ -2929,7 +2929,7 @@ static int kvm_inject_nested(struct kvm_vcpu *vcpu, u64 esr_el2,
 	preempt_enable();
 
 	if (kvm_vcpu_has_pmu(vcpu))
-		kvm_pmu_nested_transition(vcpu);
+		kvm_make_request(KVM_REQ_NESTED_PMU_TRANSITION, vcpu);
 
 	return 1;
 }

