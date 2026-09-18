Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981864E9C33
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731417; cv=none; b=ZzLv5AovGF1xERnX/LY3QyWqJVUv5KF9npV6ydMTQIzBKKzmgWm/Ats8v0s1Gnh5nBlBTW2EquZaL6fnpGlMDwyyokFcOYjsijRSqhNTjJjFtHcmzYO6d3neSLv4PkKHlBerzuVm/9D54Ghqx7k+v5Jw8g8inHFKao0VfcjwIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731417; c=relaxed/simple;
	bh=cq67vtValCzXKP0JnfJpqL0gle41URPMyyjjif4LXCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUNbPvV2QiG1vCOEJE4AiIOxKr0AYIhIhp4IltvYIt9hQ6pe8wxdvCt2KjSf1VZPDv1NUmHml4BkPdzQFD5TBNi2/fDBCwjc85uP1785Q2c4CGxIi3VvDthG3XBt/YBdkEmV0lns2A9Erf+BaMRkaXFQAqDZ3s6s4Lq12KKO0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ8RKtrl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ8RKtrl"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so545456a91.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731416; x=1790336216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goutfUAx32FOvBhVFBRbSGLDzTqpTfwkEkewd8WhIgc=;
        b=RQ8RKtrlE8SFat42bMZAUWGArEK4BPtD6Ull91/gtwSEc8wChuXAUiFZngIwNANVv8
         TCdBjPiLzIvxLFRv2FyWAx4elhmImb07GwkFyfqPR8FLvYFZ1v3eQNkW+ZlP5R8F6Jw5
         +aCaiRmyJpYnupshMEOWg3kZI+y2yvjfMg/YNuEwyfNaDV0FBkp7SNurulWffJ39i6Zv
         mWnMdYcrZ0SS7UZ7h+6DCGsM9TmsAuYAc7w0eYcAmFRewA0lXgYAPq079O3NLHpBYMmW
         VekDJHMQx/JlPvde0Pw/zVwdaekAj3vPAMWot6NWgmSFrKw2dxZ+OsARB8fHGgAakHpD
         qVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731416; x=1790336216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=goutfUAx32FOvBhVFBRbSGLDzTqpTfwkEkewd8WhIgc=;
        b=G/R/TySOPGL9ztzGNrgvNKpJuLf64N9IxL+2PgO93wzT19644dB7R8JtF6Hn/cYb/P
         b5ybmZfGmMYhjCQB3M9Vc9961fPNyaNR5ZbXoa0C+Lk6awAcz3hO+Au5maz3bgsojk72
         70p4IRV59zY3pdo6vEk9see/AKMm/a2+qCDRvjAKq0S5/RmURhaA6gDNrOUrjS8UOUW+
         VsmCEYfcmfRQVnfmsQnVXuHVJU6WwSbppitOg6X6jsvtjeST+1L2Ue4mXHXrNJlXIJPn
         R8t2B5tZd2rZic6upXZbrUS3zhW5XkSpcGofpopOY0754Pu3MJG2qDjNJHXwFkTSFWn1
         RFmg==
X-Forwarded-Encrypted: i=1; AKwUvBw1XedffHzLarXIgypO3/STkdLmh5Ro5iV+9V8ZgJh93VqTrhDgJ+b76A7Px9QqpvFA5Yw=@vger.kernel.org
X-Gm-Message-State: AFuF++lNzkU7R/0QS0gLfKLNdmkg1Jw3x0olq4cCcp4FOtliw/LKO7E4
	Qem7ilofQXG8ISKrZNDuQKeXDbqXfnvPJekIdYuiav8uzpuU/Ox5YjEa
X-Gm-Gg: AYBFou0HgAAcfvAbqEkKjD9coN9zIoD8SS4oz9fTairAdYtzq1U6dniTMqI68Djgb1c
	WA+jXOj/gEZhNXUU45GJ3LtqmpofTB5hQ0E9R3P/FbDfb2VgUZeb4TrSktTe4yzGK3IoCXbXWS4
	0mCqUGPxCTL6Z7SbR4hQvO/QFgibd4qCdt6Po/h/+usTmfsKdGmk7DUl6UwpqdZIYRNErAoQsmW
	QL0aZKdAUmGVnDlqkdplie3zb6U2CW6QFSgczge2UWnoxX2948d+RcrM0P6IX1nlGCydWHu4vxL
	LMQ2lXiBOFqw7rHaETk5baMOpmEsYgX+eXFjhmqzwYAJRMLTOK65Fx53VbBUIb9GJxTxHabOvWg
	lJVBIf4ZlNaFMOVtQfx0O0NzH8RSwAQ/Gl7eF6FX2eoATIl9luGDraXffQm3wFgw3YGAMMN6HUw
	cBJqb1/tYwkk8V1WvmXV43HzwCKxCLrEi9WuD6CRrub5qh8bjAsy/RKIab4SVU0w3+KGp/vcayM
	1jauS6/r7jP
X-Received: by 2002:a17:90b:2c8c:b0:39e:433:23b5 with SMTP id 98e67ed59e1d1-39e54aa1442mr5549176a91.5.1789731415773;
        Fri, 18 Sep 2026 04:36:55 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2890b915sm3735097eec.30.2026.09.18.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:36:55 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] KVM: selftests: Delete the declaration of vcpu_set_cpuid_maxphyaddr()
Date: Fri, 18 Sep 2026 17:06:30 +0530
Message-ID: <20260918113631.634233-3-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918113631.634233-1-gokul02k@gmail.com>
References: <20260918113631.634233-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vcpu_set_cpuid_maxphyaddr() is declared in include/x86/processor.h and
defined nowhere.  The declaration is the only mention of the name in
tools/testing/selftests, so nothing has ever been able to call it.

No Fixes: tag: a prototype for a function that does not exist cannot
have regressed anything, and there is nothing to backport.

No functional change intended.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7579e692bc2b..ffe95ce1ad49 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1180,7 +1180,6 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
 			     struct kvm_x86_cpu_property property,
 			     u32 value);
-void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, u8 maxphyaddr);
 
 void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, u32 function);
 
-- 
2.54.0


