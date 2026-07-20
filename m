Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746614A619
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560773; cv=none; b=fP10OHUX/B5CmDIkoZ0OieyA1O1lS91KgQhAcpoXvMfWkRvR01USAYKX2dW0IJ9QtUVNVkGfET0JZSUG7fDKawfHAHGbQZV7CtQquIvN899/WvgssCjmkPy4MwxWMiyrshpXe6V2uv0IU0kHEphibEeoZ862JJTmgsanQukwgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560773; c=relaxed/simple;
	bh=OcURofY2z1Fq7P1EoSJSb7+UF73+Qi4nme4BcFUst88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BKsE+ZMHHVQ+RXFtVHpJC6GCQKo1twSDm+DHzlKYfQ8C7GeOzmLFLC1NCobYcm6PJpc6KlUaVZDoh+whyMCCj54QN1G7XGGbjdoiP+Nzpz+4UlvMvKMSXkWLqZ+IQWAaGKhUf5NrHi41Z8yFpn04PI9OS3DTRmLStFKq8/1e9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs2ldB8A; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs2ldB8A"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384419c6c74so13059308a91.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784560771; x=1785165571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmhhV/l6c7yy+KGLoVJm/3/iCcrnLm7hqjNCCMMwHLg=;
        b=vs2ldB8AucOvbHguIRTPb1xy8t1tYc8drT4tHB7jfpV+ionqhsWE6wQKxsv6NE7agF
         bmboNeyJ66GSdT7r1kxgR0eUVD2WqMJzJgbvVELSs+gWOmaFi+UzMSr7VCcIqPyDNkfR
         IiRQK1zEm8zrojv7Ls18L/4o46wI9ksoOYZ9He2XTu8KsBWQ4glVCB2zTSOE+UtKOvkh
         ebPHmZWh9tAARofrOFAO3N5WysyUssgFBasjuybUNW6BXjsAQVW4J/cGhVgCxC+r6EsJ
         8Wd4+j1jGomtpEjicyDdAiY08rALUt7MeUuFXXuk3JZ6/4My2/4XmYmgpqCgIZ7xXett
         8csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560771; x=1785165571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmhhV/l6c7yy+KGLoVJm/3/iCcrnLm7hqjNCCMMwHLg=;
        b=ndWeP0qODxegUFZmUJIEGpsY/LNRp3FMmslryF0rSbi5+i+eJp1YD6UMLIVFQ34CQt
         DBATu5zCa0+PUzd4JNgxtXt2jgWDQ3Gce4d5fm5qoTWTX76OpH5wLZ8UyYYQaE9erIUB
         601HTRDhQ56XWB0bR0awUc8CabeI5SpVwsUb4uAWrTgxAuPoze5dWFZA8MDOVjPhHAVC
         P11dqnTdPcTxPyswRTX+rjIHuVvJZiKRy1tHiwMSJw6C6HjRRpgpaPnqcwS/FW3qds0m
         SoEzQRabzTlgm645n+B3ZOreMkDDBzamae9QYu1onPpC74f6R9W+HCZR/GRMTY7tyUvW
         W/hQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqT7mqZvx9CBqXKVLTETs/OySkXvI0inKvLYSp0MXULvys+4o0fiheF8ZBBUW3naOMgTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGKd22dEmUFKm8vz6nSQXaczTcq6kFMehCMJiT6Bw6OI51oBr
	MJr1Cnj0Wi//2TM/C3mIW86NNizsUrBcaspHjHSh6miettqEmMZbPrZwsJXi8P+5IBxdNtC5ZuI
	d2Gewag==
X-Received: from pgj4.prod.google.com ([2002:a63:904:0:b0:ca1:3a05:d935])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc0b:b0:3c3:ac5d:b6de
 with SMTP id adf61e73a8af0-3c3ad7da25cmr16576815637.22.1784560771100; Mon, 20
 Jul 2026 08:19:31 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:19:30 -0700
In-Reply-To: <al3Qbq-jUYE-_72N@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <al3Qbq-jUYE-_72N@192.168.1.215>
Message-ID: <al48gqBHiZgmVc0v@google.com>
Subject: Re: [PATCH] KVM: VMX: Complete pending nested VM-Enter on
 invalid-state failure
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Hao Zhang wrote:
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Fri, 17 Jul 2026 09:18:31 +0800
> 
> Commit 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if
> emulation_required") made KVM synthesize a failed VM-Entry with
> EXIT_REASON_INVALID_STATE when L2 guest state requires invalid-state
> emulation during nested VM-Enter.
> 
> That synthetic failure is generated in vmx_vcpu_run() before attempting
> hardware VM-Enter.  As a result, it returns before the normal post-run
> path that accounts and clears nested_run_pending after a real
> VM-Enter/VM-Exit round trip.
> 
> If the synthetic invalid-state failure happens while a nested VM-Enter is
> pending, __vmx_handle_exit() observes a trusted pending nested VM-Enter
> and fires KVM_BUG_ON(), causing KVM_RUN to fail with -EIO instead of
> reflecting the failed VM-Entry to L1.

This KVM_BUG_ON() is working as intended.  prepare_vmcs02() is supposed to guard
against emulating VMLAUNCH/VMRESUME with invalid guest state.

Ugh this appears to be reachable by clobbering SMRAM state prior to a RSM to L2.
Is that how you triggered the KVM_BUG_ON()?  If so, I'd much figure out a way to
fix the RSM flow.  Or maybe just treat those runs as untrusted?  Because for all
intents and purposes, stuffing vCPU state via SMRAM is the same as stuffing vCPU
state via KVM ioctls.

diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
index 8c5018c65dc5..1f4604a9ae58 100644
--- arch/x86/kvm/svm/svm.c
+++ arch/x86/kvm/svm/svm.c
@@ -5091,7 +5091,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
                goto unmap_save;
 
        ret = 0;
-       vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
+       vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
 
 unmap_save:
        kvm_vcpu_unmap(vcpu, &map_save);
diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..5c410f68a716 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -8453,7 +8453,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
                if (ret != NVMX_VMENTRY_SUCCESS)
                        return 1;
 
-               vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
+               vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
                vmx->nested.smm.guest_mode = false;
        }
        return 0;
