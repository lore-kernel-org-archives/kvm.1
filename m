Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236E372064
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470519; cv=none; b=NZXO2Rl47kdZXUai1mtLrNlAVRVMjMCyC4X3WlqhSs7mmD1fwlHk85goVD5qfjUsqUHtsOw5Wn8R29ZFZY8Oa+cWbldpdAGnWzH9Q9coXIFVUhhEvlk04lVSJt3Rl8RD4d6VgrgtTtpAp19fAuJNdT38xuGDp30HeWjWEFWYH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470519; c=relaxed/simple;
	bh=8WpWeyEf3luxQ2wZAyHA8cYkuiddAjE911Qfhzsg90E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sNe+Rey+YmMAVewJ+YX0VkWh9EpG2hc2k3fDHz+pvgMOpcIL/KBPCWPrk7zRlT6M8Ej9s/2NjqTof4E+HIagxj1UgIzqTqXduxuxac9+C1jY2Vsw3ZQzLBcbO3L6PRitlQyafXEJrCK21oIFz/dvqk+Y5up4ralJS8cMncXcsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTab3+fx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTab3+fx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso4851244b3a.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470517; x=1780075317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Eefghdyx2WJstvVJS36TMv8XvfuF7zYMCYG6JFPt/vA=;
        b=ZTab3+fxYVOjUeT0BFEhIpBIt/06bclw8f4IMCC+rbzKWJOaT4coKgCjYRviPj4wt7
         w9h2PbZK7aT28sLcqxjpw/5K1741Qe7o+rSujx8WtkWXpBhjKvcfedd8SHsZbcmITHK/
         juaNNBiEnqJFzgH1aECvM1jyNEZCP1aRuluDYKqxQxpkOtO5MXIsmMtfwfQCZt79JVOg
         JlR467WObcwwBP/4lQ0RctIKnctJ+XCrzRvFgca8CpW+X7Rp8JGNH6SkP/CCA8MSZncX
         NK1zzfNvXzmHwyGtUMEgsFKfMdvaoH3sVPuS5ZrPbLunP5fIHXWZnS0ruxGOwdd99F2X
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470517; x=1780075317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eefghdyx2WJstvVJS36TMv8XvfuF7zYMCYG6JFPt/vA=;
        b=EAl5r2uZJkONQuPzzXMKgCgjlGtMdJ25jjWUl445Wo6Zv1FktLD54vwaO0act3PqAW
         fcBQkK0jlAs+fiMhHoP20GxyO9AM2i3LbEX7EUqSgCa/o3b9l8rkF4f4aBIX5+5C0YQq
         FqwNj9Nhf5+l+C4GGaKCPJYK8ku3ra9FOK7fiV0S//i4cIDdTg+nma4NEc64OjtQi9jm
         vxuDnri+jN1eDUePBYAEzMyijje9z93hN/pUU7OoZYjIoNdIbf1GaQag+2vcgLgPeukV
         HkqeeUcHqn05jbMbEENc4F7+TMjVYZdmz+wCfZ1zdHtSkf/BIHgP6RCmAL/+6dBm0No0
         t/Cg==
X-Gm-Message-State: AOJu0YwPwyQEjqHDffxe/YSU9HT2xGEH1jTN6gbfJezjJ6VJ7Yq20kUj
	wCrBuSfT9+FVzYDH1Qemo7jgX9xCtRx0BmSYC1+C/4QQG5HbnVFGO/F0jcrKP1vZ+s4yix4+OjA
	7wU8e0Q==
X-Received: from pfnc20.prod.google.com ([2002:aa7:81d4:0:b0:829:7f86:623])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240b:b0:835:3f51:72f8
 with SMTP id d2e1a72fcca58-8415f5db6c5mr4494289b3a.18.1779470517177; Fri, 22
 May 2026 10:21:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:21:51 -0700
In-Reply-To: <20260522172151.3530267-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522172151.3530267-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522172151.3530267-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: selftests: Remove unnecessary "%s" formatting of
 a constant string
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop superfluous %s formatting from assertions in the guest_memfd overlap
testcases, as the string being printed doesn't require runtime formatting.

No functional change intended.

Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index be99c1ff5a5a..e0800bfb11eb 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -554,7 +554,7 @@ static void test_add_overlapping_private_memory_regions(void)
 					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
 					 MEM_REGION_SIZE * 2,
 					 0, memfd, 0);
-	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+	TEST_ASSERT(r == -1 && errno == EEXIST,
 		    "Overlapping guest_memfd() bindings should fail with EEXIST");
 
 	/* And now the back half of the other slot. */
@@ -562,7 +562,7 @@ static void test_add_overlapping_private_memory_regions(void)
 					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
 					 MEM_REGION_SIZE * 2,
 					 0, memfd, 0);
-	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
+	TEST_ASSERT(r == -1 && errno == EEXIST,
 		    "Overlapping guest_memfd() bindings should fail with EEXIST");
 
 	close(memfd);
-- 
2.54.0.794.g4f17f83d09-goog

