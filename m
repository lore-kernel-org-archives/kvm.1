Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDC3AA4F9
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894096; cv=none; b=h7Hpud0oSNhwuv3ZAv4qVxhYZPQFQWM734YMVm/+c+Us390PMYRZ0aNJN99nWNMbuHsQXX25t3Hocw+QXAXLUrDwmbaSOU0z3FvoNmEbuO9IBLHknN3eER3oeq4WIjaFbVmL+mTKrV0SD9nQAZxQ+MzJy7SZK7KBSGrZ/52Y1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894096; c=relaxed/simple;
	bh=xen+bOCe6UFoaxZ+0OOW8kLN3gkD8aaTiRWd6lEAF8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZEZLPEelQJ5e4oLSw/HbVjSwD2H02YHWcgkx+mfo8vo4EECulKjuU/VXac8SZIHfM7+MwmeJyyIONtF31tlM1EAwEEImYbMxKf9o3PEIELsuZHBz5ijpX1FUJF08LF2SexyjZ/5B/4OXJBc5oycRvBM5LSLqV7/MKb8iqY1E3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hP69fPjj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwIvp32H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP69fPjj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwIvp32H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777894094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OP8QnCfRuvGQp9zBUZSNN4UYtyqUqhrepWYMqNLQrrw=;
	b=hP69fPjjW7wl/F9XoO8VBjGsH1DUU6KY/TPZzgYYKCbHftxSGsKKJq6iR4v63OaFL6DGn7
	ltta7flZRXjAaiAX9RxbgW7JmcPgD1hedAeWbJovDAksGxyO+eLnvcaY2GBXEqU/uoLtdz
	StM/Xr0oZHSoL/zYJEs2lSW4RokMFac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-ZFKKelguOXGxWVJysdo1mg-1; Mon, 04 May 2026 07:28:12 -0400
X-MC-Unique: ZFKKelguOXGxWVJysdo1mg-1
X-Mimecast-MFC-AGG-ID: ZFKKelguOXGxWVJysdo1mg_1777894092
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44dad1b938fso690414f8f.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777894091; x=1778498891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OP8QnCfRuvGQp9zBUZSNN4UYtyqUqhrepWYMqNLQrrw=;
        b=CwIvp32HZMN2nIgok56wL1fTWxK6CQ3Qk4EVoOnBxqk6OonRAQi57xfcWUmMXzevkb
         GvamyCPIrcKLzahYqwGRwLUb2zIFfBETDdovznvxx10CG7qQ8MUslbseq5vtu6Yco/03
         vOuB+z70COibWGnq0mr6kb4QBVSsrpnqntcIPQZfEeS4hd+Ml7770DODwBQpqOEwL2Xi
         pNXVpPfML1AlE8KHe1M9CjYwIVABT1LdSrUE1Mq6K9xJ8Q34SwbjYcXwlYRVPP710ud0
         mkM289KnZVPsx0lGoUZNilyveyWbhDeZgXnmL/ERWHsu1+92SW/1Nxki0tI85/uVkQfz
         CfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894091; x=1778498891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP8QnCfRuvGQp9zBUZSNN4UYtyqUqhrepWYMqNLQrrw=;
        b=KHBuV/GvftvCKmN6YQMyl6LTfTHFmW77c71JP6nY9ZqnM608TbL+vEKps71LOzxQao
         MO2lGa+fCL95o3HjBi/KHWNs7R8IvPoK1YOBNf5ha8UOvn8GcnrvF2hxAjOLgKdEQ8Py
         KH++J5BW0E4mDP8le/2BEAWHNQn1mw/rGroc2FlMTkn2jBW08Tlq246rac9ZRriibjz6
         enC/D4c7ULO4LueghMi/kMGzLKLle4TckrxkpVAhpxxb4sOjGIbYzVGCZyNUEEvXFsl5
         S8r4L9T+ZT8GhfUNd3EGUSVVQNcmzObxhOrAHi1vJx89YSKI0VRQuIw3ZjD55/u7ejt1
         M11g==
X-Forwarded-Encrypted: i=1; AFNElJ/ltqQObkz8sgfnOjeT+kD1gLlxluSumR7NByl9Q2ejVW6kFBp+RutlFD+Gp8BGUgkLXlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTJjMmTWdZ09seKNHWuJv2oTiSfshNBAVVpeQXjiTqL0r3rqg
	IbKUO2O91YIQSMepXl9no8lpFWWEjV4v5oIKB6M/TL4KBvgtqTE/WEAG1BthB94SIe5qSPzi/me
	wTrwJCZrTFQ4zkKMY2AaRXbwYx5M0KE1w1fNMyaMsEes1JLC6V6tFEg==
X-Gm-Gg: AeBDiesMofSXgYON9be28U94AaEbbAjfOV2vDkNh0I06W/dDLYcjzyOcv52KOc2xdWl
	ewumBRa9/1T9vHWzXpvFOuF+Ch7K9XB09DKoGhWcvHBqmUHkF44uRSsAVl49mUcJZM3FrQvbUIt
	Nmf7nUrUhvSIKsHAlVRF6HtiXegRQWTdRKNmmZ1zYgPZRY1EA7iwTSGYLIwi1BpZQy4GPrphu9o
	0i7cu5S0k/cZMx5Oerf0CeVn9HcxVtywJYvakWS3pdYFgyoGfSZIiwNqUPKDF+SWiZubYJotF3Y
	XbYRmmlwVltXoO7ukLBkkC/tZAwZ1vPY/HLv0oG0Yqpgz0SDaR2HXGM6CGJlIsKPNjzNsh8JaCF
	CbAsAQ/X5bVoAuSxuMN/B2T7e3haVMIOA2q+q7TUV1bjFt9qMB+Fx7OkpypIX72t/BBZhvNxC/G
	n7HQhi4Ija5iGGyxcRbGg=
X-Received: by 2002:a05:6000:2410:b0:449:d189:e79f with SMTP id ffacd0b85a97d-44bb5e2daa2mr15074074f8f.32.1777894091591;
        Mon, 04 May 2026 04:28:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2410:b0:449:d189:e79f with SMTP id ffacd0b85a97d-44bb5e2daa2mr15074011f8f.32.1777894091208;
        Mon, 04 May 2026 04:28:11 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1a9a00cfa84c903f391888.dip0.t-ipconnect.de. [2003:f6:af1a:9a00:cfa8:4c90:3f39:1888])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7d0besm25396208f8f.4.2026.05.04.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:28:10 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvmarm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH] KVM: selftests: fix steal_time for arm64
Date: Mon,  4 May 2026 13:28:08 +0200
Message-ID: <20260504112808.21276-1-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following failure to the steal_time test on arm64 by making
the timer address known to the guest.

==== Test Assertion Failure ====
  steal_time.c:229: !ret
  pid=18514 tid=18514 errno=22 - Invalid argument
     1  0x000000000040252f: check_steal_time_uapi at steal_time.c:229 (discriminator 20)
     2   (inlined by) main at steal_time.c:537 (discriminator 20)
     3  0x0000ffffa23d621b: ?? ??:0
     4  0x0000ffffa23d62fb: ?? ??:0
     5  0x0000000000402b6f: _start at ??:?
  KVM_SET_DEVICE_ATTR failed, rc: -1 errno: 22 (Invalid argument)

Fixes: 40351ed924dd ("KVM: selftests: Refactor UAPI tests into dedicated function")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/steal_time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 7df2bc8eec02..76fcdd1fd3cb 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -220,6 +220,8 @@ static void check_steal_time_uapi(void)
 	};
 
 	vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, 1, 0);
+	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, 1);
 
 	st_ipa = (ulong)ST_GPA_BASE | 1;
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.52.0

