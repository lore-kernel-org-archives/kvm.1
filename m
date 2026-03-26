Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DC43634A
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549117; cv=none; b=iYgjaDEB50+c0RuX11nQPKqwzofCG5BPAvH7YCp+SjUMYxlNd317PvH/DI+KuKgHYh+t4VJ7MTqMwBK1XcS6IzK2jhoyJ4Rzmb6kRS0Kw0eZHgMr4YkwtH2wHns6uVBKL99RIRnrhhAocGuE/7vk5LmBoNX7ehSFstDGa2Y2MIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549117; c=relaxed/simple;
	bh=VqDC5nq0YNGqKNZ6RKmT3do9bT1aOH4fFp5OqMgujK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4aISLeSiRGFqEFWMdPpnLPrQd7UK49AhxfSefPZgnVySwy7sMQYmdl5f8FzG0NAjXcY6Cd33JDQkiMW+Sdurf8V0dse6B2BLTeInjGKvSO4yjbdRSxvwvJe5pFaVEht5d2zElfgwe3EA1bS7jYfepk2hOr/+l8D6kvYdWVHOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dowjdQNt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j1Wm4oqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dowjdQNt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j1Wm4oqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYNGVWrKJXR6S3Kdoud61y7GGD55W7Al+2THWDfCOTw=;
	b=dowjdQNtp7bcCxRdCUj+uYNm6O7BLae4G+IwzjhGGlmOMSxdRkBgFVTmQpHTilIssPXQu9
	Wr5V9IjW7180SH+9puEVEYlxI5ZfmD9RZz7XwmGqHmZ5UWaASVAZuwHj8ABAd/FjtO5uOc
	+zhnl1bnDJ9GSnFYXHcksPWBA1ywhGA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-wPSPdm53Meq8pAhQkLDiiQ-1; Thu, 26 Mar 2026 14:18:34 -0400
X-MC-Unique: wPSPdm53Meq8pAhQkLDiiQ-1
X-Mimecast-MFC-AGG-ID: wPSPdm53Meq8pAhQkLDiiQ_1774549113
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-485397788b3so10701195e9.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549112; x=1775153912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYNGVWrKJXR6S3Kdoud61y7GGD55W7Al+2THWDfCOTw=;
        b=j1Wm4oqu0B2jyLQymexPN11iS5AdsBWVEnEP2qLb0/h4G9xZdNZTlRybnQo/AI/Tfn
         o9Jh4AE5ZV5sBS3tAlYjFgPlN4KXxRpH0WoOEcI23JWg9xmcuRoTpXtn/Mj1JaG2vPxm
         6yXMljda38lGbh3MUKovkRXptOvoCdUSyp3Ii+NYJsAwXYIDQNZOAcTmJZgLVRMW2epE
         73QF35r0kGN4JvDuvtV71LrAObG4NBpx9bxT/CpEE+9E/BAVouTXtthHcElNDPBetSsM
         XYWSsaPYVnxw/9yn3JRA4Mjvbj/HQV24aw9bVAlgD0cmq9KZeK0QKv9O6ao0uPsHfFVs
         74uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549112; x=1775153912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYNGVWrKJXR6S3Kdoud61y7GGD55W7Al+2THWDfCOTw=;
        b=pTHZ1VAyc/1RWUG4AN1d4m98Lf1WD6TWXD9yIqXwl7HT77JKiZBl85ZwKZiA20e1DF
         +v0RG9LRkKja5/sL9EgRtRhDLHFlE2ATp/GaXWYrwDXHGqEqM+x42PyiqjVQOXdjhqDY
         6CGjDopIPp40w+2KET/xGb4HVPbnc+wUT81uOqJRA2DbAwh9iip68lFNoXKTi/PZIQWf
         gi526ZTSQ3oWNDKBJhDCahionnfSqBCgaUd6avd/uWjn1Rcd/RA+ftsY+hVHV+RUGjb7
         PJ7K+20dwGYQ+jS5PFhO9m5BWf8IBmjVVVwkfpF3DD41T0LyB6/sIpkigGT0qE2rvLu8
         BOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFIkaR5EocDso8yr1tnUT48irgabYN9nN4DbDSavtRYQfD1KK7TMom4hc6kMKkXoeEofA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVmP8tcmo3bPLyWvjbBgr1o3wbtZUg16n/nvSHXT37vECcf3f
	mi4n4DneEqb6VVKxb9liEkavP9gRZ7HryQOV+QrGO7CsmYRCQpa1+VsiZZ4f9BmPHC6qrGC1rQk
	6/dC4sTl/K99AUCtUAdY+lii2D46XT1WcCfbK97isx54cnlQmeN9XQrAsD7XuPQ==
X-Gm-Gg: ATEYQzyabK/03Mmm+xhR/wFE1q8e++TXtiSGJDdCCoBR4G44Gg5Z2+4otg4z7/xg69C
	D2uPMNYZXqyFfLmzZGi4wAdOyZ7Mi9eXXm7y2IHlu1HqdrYRINHQeBBRy1O1fnQKml7UOo3UcWl
	i8YmQ2CkHt8Dzw6NKkZbyu3ttbJoszBvxFtMGuAmQsiQU8XbXtSZc0O4NVMVYJaXZ/Qif1p8d2H
	u7wF+DMa1bIzQVmXzVythCIMGXRbOyNuKX1kINqPLbHzOjc2zU7sijBymHB+Tf/hR2REjLzbqwR
	1sYYAEJNW9lqf2QFvscJvg0UjNycDN77P6ZOXt8FoY9OtGkY0t2jkuhBQG5SheAaxy+UVG33b0l
	xTwftWh7rurT4Qg1T+OsMLF7I+CPLft/YUSiYB/E7ShockPNjThJ8XC7E5I/dbxSZv7T1m2aH+g
	w6M/8+PqjLjq1hJBToSKqwJWpw
X-Received: by 2002:a05:600c:c10e:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-48716039dfamr105341775e9.19.1774549112298;
        Thu, 26 Mar 2026 11:18:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c10e:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-48716039dfamr105341435e9.19.1774549111836;
        Thu, 26 Mar 2026 11:18:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm9497117f8f.37.2026.03.26.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 25/24] stats hack
Date: Thu, 26 Mar 2026 19:17:23 +0100
Message-ID: <20260326181723.218115-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm/svm.c          | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 arch/x86/kvm/x86.c              | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2a26c8fe3f4b..1bd12c03c319 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1705,6 +1705,7 @@ struct kvm_vcpu_stat {
 	u64 nmi_injections;
 	u64 req_event;
 	u64 nested_run;
+	u64 nested_run_gmet;
 	u64 directed_yield_attempted;
 	u64 directed_yield_successful;
 	u64 preemption_reported;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 430e4f4ef55b..705bfb98ebfc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4424,7 +4424,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		/* Track VMRUNs that have made past consistency checking */
 		if (svm->nested.nested_run_pending &&
 		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
-                        ++vcpu->stat.nested_run;
+                        ++vcpu->stat.nested_run, vcpu->stat.nested_run_gmet += !!(svm->vmcb->control.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);
 
 		svm->nested.nested_run_pending = 0;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 65892dc6f478..262cf8a69bb8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7749,7 +7749,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		 */
 		if (vmx->nested.nested_run_pending &&
 		    !vmx_get_exit_reason(vcpu).failed_vmentry)
-			++vcpu->stat.nested_run;
+                        ++vcpu->stat.nested_run, vcpu->stat.nested_run_gmet += !!nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
 
 		vmx->nested.nested_run_pending = 0;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..09e4b53f34f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -299,6 +299,7 @@ const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	STATS_DESC_COUNTER(VCPU, nmi_injections),
 	STATS_DESC_COUNTER(VCPU, req_event),
 	STATS_DESC_COUNTER(VCPU, nested_run),
+	STATS_DESC_COUNTER(VCPU, nested_run_gmet),
 	STATS_DESC_COUNTER(VCPU, directed_yield_attempted),
 	STATS_DESC_COUNTER(VCPU, directed_yield_successful),
 	STATS_DESC_COUNTER(VCPU, preemption_reported),
-- 
2.53.0

