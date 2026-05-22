Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B45357CE8
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470141; cv=none; b=czuXZUIuCe7qSRAJtALUkDWabV6fqoK7nveuBC2cSwzbowUG03d6dHS8eunpBeoYwuor8P3mV2MbjFZYK9Ut1bTllcjLnrlf7Bc8ecewiwdKEU1qmlzIiP2ED2LBiC1bggL1ZefPvLWuwLq+5h5uPdbIPnU+ivFnETl2aqo6iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470141; c=relaxed/simple;
	bh=+xKgZzyUK7L4enk+f686xiGu/mIaJe/sWvbZiM2YJpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hYUaWDSJRpxzBO3batGD0wRUxA5t2iW3RzFfQmRpk51FZm/qQFkbKs471m0Xgz+0wtBrOoWWPW/vS7kl/CUs2uDHJgUiI2Vp0JYWmcAat1a9anMcTfRhYsjlzCrdLeZX1JxFEdw+j7eQDRAsJSqPsqMh/VOZH7PmNS6HHUY88Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XreQpZk+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XreQpZk+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so77435385ad.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470139; x=1780074939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DZezRcOufIzkcomJGqxeup6LSZ1A0OirRYwLm0URqEc=;
        b=XreQpZk+ciKvN5K1ahgn89OYTlMJtvL3zwxpOjxoaD4gK9jueujJi7nUJEklLN+Cf4
         uhiz3S6Tw0Z5FM98McAXIeLa0SWezdKgl0lXEXdJiEQI5JgV75045w/FmUD2fV7eViWU
         0Ns1Bc1ebAQ/npyuO8LRVMOI6wFqxHV5R3qeZNmCP560OH+E9aQi7fsQk1mYpUwrZKXd
         b4e+EZ0fvkhLfXOsl0c7a72V+9I/AEBK6wYAn+5FMlAAmQPzisA+Nv4KMtxdNDpgj9AH
         7UM13qDW83EO9LqojSaFfGaHQgu5qUklX/1sSCE6w3XIg20CfrTRdeu/w84K87YvEAgU
         hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470139; x=1780074939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZezRcOufIzkcomJGqxeup6LSZ1A0OirRYwLm0URqEc=;
        b=GTQeUFoXEDwFy3ZycFUTbH6jRoQ3NFtyV9hPfa4jfK6491ujMlh74HL7F6jJ5Gu0zQ
         KEQj5ri0BPyhTvQJi/y3OYK3v1g/wucrGz8zHudmha+GIyU5a+xn19RyrrHPmv2DkT6K
         gvfSEuglmUryfjz/TXJP2v29Sl6mHkgn1PkXqFgIUpxyyAU/nFOgOGbQYtDhzLLB8VRw
         CYtzIM2oGiJkCM2RsCIkNyZ5a9X74QJrlsctwdvyGL2nj1WMJDXVg/QJfklA+B+gQKdV
         4xlWdY0NP6s9TRft1yec3pEVM5Fmz7sptM3lB9SmNHpqbBcF9JVsJiklMAcTGJV8YSqg
         kDZw==
X-Gm-Message-State: AOJu0Ywdb9uUae/gSnt7QfigoRkunJ04tpEmmj8JWWrjQzFxRFz+o5+6
	rRZD+FHZ9jI1TDS4MSqXGodRwe7Ld5GjmXT0bV4exTPORq/Folka/r5l/Ekir81XBPaR+rq2USS
	GhLFeUQ==
X-Received: from pldw18.prod.google.com ([2002:a17:902:ca12:b0:2be:22cf:75b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:2b7:aa20:3c61
 with SMTP id d9443c01a7336-2beb083ee1fmr45532905ad.33.1779470138760; Fri, 22
 May 2026 10:15:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:15:34 -0700
In-Reply-To: <20260522171535.3525890-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522171535.3525890-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522171535.3525890-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: selftests: Cast guest_memfd fd to a signed int when
 checking for >= 0
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When conditionally closing a memory region's guest_memfd file descriptor,
cast the field to a signed it so that negative values are correctly
detected.  Because selftests reuse "struct kvm_userspace_memory_region2"
instead of providing custom storage, they pick up the kernel uAPI's __u32
definition of the file descriptor, not the more common "int" definition,
e.g. that's used for userspace_mem_region.fd.

Fixes: bb2968ad6c33 ("KVM: selftests: Add support for creating private memslots")
Reported-by: Bibo Mao <maobibo@loongson.cn>
Closes: https://lore.kernel.org/all/20260508015013.4108345-1-maobibo@loongson.cn
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e08967ef7b7b..4ad015c6c44f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 		kvm_munmap(region->mmap_alias, region->mmap_size);
 		close(region->fd);
 	}
-	if (region->region.guest_memfd >= 0)
+	if ((int)region->region.guest_memfd >= 0)
 		close(region->region.guest_memfd);
 
 	free(region);
-- 
2.54.0.794.g4f17f83d09-goog

