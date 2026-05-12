Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AD3A7832
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602424; cv=none; b=sWKZCnKHC/8yEw+N3px5fHTn9AyMJdfHnb/+v/CWc8KBKbaIbbrMeOMMrRCNBwYe3C6W9dKP+l/OZ+2Wru95IRxHXbd/Om4ErRBCNalwOt6NZpZX9YO39ohsLyvPldbYOYoHm4qlebPEL0YJG3aboPQ0tg1DjTN5A8ZsVpTl41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602424; c=relaxed/simple;
	bh=xEdNtFfkTI4eqQ4AvZso/YR6aXylBm3RqEOecwl+DWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpQjvhvMNWQP4fBm3n5RwT+t/x/5FpsD3/MLqJ6D7xpZS9aRHdWcL3DdczqXgGbOHubGL28wHI2XuMjBrerLMEegr7CKx9D/7US3DJuTANw01qYRDhnzw8CPl2Hexgw9kwUt52ucGuON//7zvIMonTneEa3kB5ASxyZFvBnCsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVXl0OJ0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVXl0OJ0"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcda7765d64so480329666b.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778602421; x=1779207221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC71bm5vhDNsZ/9yQfswbrSvXoDAZ/5TWImHjuQzSTU=;
        b=aVXl0OJ0bU6sqBU3qeWhZnFFvGSQxPqD6TV8N5cO9SkhoLt4biArNp+p+ffkczPLNx
         NeIvqttW2TH7Ni1nbc/f9e78/ipwZLmoBQ5+x42iqSflaSQf5rdyxgDDWRlRL3QlWd8M
         eWi1YRfhDu3z+DnCUu4EJWWKBzdDoxAV8rc5g4UvdaY6iNgJEtT4p+NKazwRUCiV2HUp
         acXcgIULoMzZtpyPxkc1k4AxrHiDoMEpQNcZ8xmy9XTvwmT2FPH9nKZNqO9p5I3dXpba
         I+f/nxjD6KzJ3kUYq4Xecgfq4eGQQ4KINUdJZrIulwN9gv1fXI/rsf63AfwG1UgtZi5T
         WDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602421; x=1779207221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC71bm5vhDNsZ/9yQfswbrSvXoDAZ/5TWImHjuQzSTU=;
        b=HDxp2oWCnfRDlCD+Hura347AfYNd8XK7BPJUZZny/ffnJzcR8wD3MiYTlEy1GEjGRN
         e1pjKtavniYl+m+wG+0P39AGUIFXkqD0MWTNZn+oWVLN2tF8/8f0cs2/hT3es3eWiQA5
         M1iGXNjN1PJl7lpmdRCBI1h5sDt3rH/vcWnoxQRcwfbiKpwX17daZA3V2BfDlV0KIk04
         jE0V9pnXO9g66yDxOSyA/xJWlEOD4/5eFi9R+SOHsGNCT/AbGtuNKNQHu8rScgVUKx3C
         rhkmoZZPSrijoXHl6HvRhUJlVnWz6CLai4YQGbdPJmM1iKgx2Ft+XJxuupc6d2ql/3+5
         qcLg==
X-Gm-Message-State: AOJu0YyxWKmn65jevrPcdVk1VWFbb7sjFNm+56FfVBc2S23nsyM3cnb/
	hbw2/vnKg7wOZnAQK2Fp8ARcmlkLlV7xR8K+ddsS/yK57LtG3C/KfFrZ
X-Gm-Gg: Acq92OGCC51i2yMjVAVkhSdPEh2OB0JkdScRD7VeDKTtTovO43lAy85KaCQrg5FHFo/
	DuIOdEKr2kOPOOoBQ9tzEsLbvUsWEu7m2geIENwUgbJNi8ra6JVPQES9bbHzgRVTVpXijz05EM6
	xwrl0lV0uYd3W7HwjTvo9uwkVFzr/2NOiuttcVRdy6c0H8Iy0F8SY2inPyeAmrD4Um4P+nJWEYs
	8HhPYvRrVOh5ruqkwaM5u5xK82PbNDynyMAD8F0hTSoFluhADwV/Zny4MCpNhX7Iktva4DsWVLu
	1j6ZkfTb93YfvXcMLT3LVz8gWuxDZeEgtpN4W+241+Kha9LNoUtRPG22PWnQWl2LX474x2GRWu3
	o+4F4TiEoDNUQr1ByI665hpPjjFgpSOP5I5EqsoKzK240RV/ixQN4f99Mbvp6rOTH6ufbzBe/0s
	S0SxBy3QXDFBrUIO3C/zv949vtqqTJhJNrcme2huhx5NgDJqk0D2a8LZevFzj1o6Cx3/sDYs9Uw
	ogHcx8ag4WBqsEneQrJef7OUG8=
X-Received: by 2002:a17:907:c30a:b0:bc3:a0e9:e0c with SMTP id a640c23a62f3a-bd23b406da1mr320704966b.13.1778602420746;
        Tue, 12 May 2026 09:13:40 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm357354666b.41.2026.05.12.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:13:39 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pbonzini@redhat.com,
	shuah@kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] KVM: selftests: sync_regs_test: drop stale TODO comment
Date: Tue, 12 May 2026 18:13:17 +0200
Message-ID: <20260512161317.2580678-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agMwjrRbeuJsi9OC@google.com>
References: <agMwjrRbeuJsi9OC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO asked for a build-time check to guard against missing new sync
fields. Remove it, as code review is sufficient to catch such issues.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 tools/testing/selftests/kvm/x86/sync_regs_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
index e0c52321f87c..5b0c2359bbb4 100644
--- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
@@ -255,7 +255,6 @@ KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
 	struct kvm_regs regs;
 
 	/* Request and verify all valid register sets. */
-	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-- 
2.54.0

